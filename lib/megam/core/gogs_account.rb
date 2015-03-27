# Copyright:: Copyright (c) 2012-2013 Megam Systems, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Megam
  class GogsAccount
    def initialize(name=nil, displayName=nil, mail=nil, password=nil)
      @creationDate = nil
      @admin = nil
      @type = nil
      @password = nil
      @name = nil
      @mail = nil
      @displayName = nil
      @lastModified = nil
      @active = nil
      @some_msg = {}
      super(name, displayName, mail, password)
    end

    #used by resque workers and any other background job
    def account
      self
    end

    def creationDate(arg=nil)
      if arg != nil
        @creationDate = arg
      else
      @creationDate
      end
    end

    def admin(arg=nil)
      if arg != nil
        @admin = arg
      else
      @admin
      end
    end

   def type(arg=nil)
      if arg != nil
        @type = arg
      else
      @type
      end
    end

   def password(arg=nil)
      if arg != nil
        @password = arg
      else
      @password
      end
    end

   def name(arg=nil)
      if arg != nil
        @name = arg
      else
      @name
      end
    end

    def mail(arg=nil)
      if arg != nil
        @mail = arg
      else
      @mail
      end
    end

    def displayName(arg=nil)
      if arg != nil
        @displayName = arg
      else
      @displayName
      end
    end

    def lastModified(arg=nil)
      if arg != nil
        @lastModified = arg
      else
      @lastModified
      end
    end

    def active(arg=nil)
      if arg != nil
        @active = arg
      else
      @active
      end
    end

    def some_msg(arg=nil)
      if arg != nil
        @some_msg = arg
      else
      @some_msg
      end
    end

    def error?
      crocked  = true if (some_msg.has_key?(:msg_type) && some_msg[:msg_type] == "error")
    end

    # Transform the ruby obj ->  to a Hash
    def to_hash
      index_hash = Hash.new
      index_hash["json_claz"] = self.class.name
      index_hash["creationDate"] = creationDate
      index_hash["admin"] = admin
      index_hash["type"] = type
      index_hash["password"] = password
      index_hash["name"] = name
      index_hahs["mail"] = mail
      index_hash["displayName"] = displayName
      index_hash["lastModified"] = lastModified
      index_hash["active"] = active
      index_hash["some_msg"] = some_msg
      index_hash
    end

    # Serialize this object as a hash: called from JsonCompat.
    # Verify if this called from JsonCompat during testing.
    def to_json(*a)
      for_json.to_json(*a)
    end

    def for_json
      result = {
        "creationDate" => creationDate,
        "admin" => admin,
        "type" => type,
        "password" => password,
        "name" => name,
        "mail" => mail,
        "displayName" => displayName,
        "lastModified" => lastModified,
        "active" => active
      }
      result
    end

    # Create a Megam::Account from JSON (used by the backgroud job workers)
    def self.json_create(o)
      acct = new
      acct.creationDate(o["creationDate"]) if o.has_key?("creationDate")
      acct.admin(o["admin"]) if o.has_key?("admin")
      acct.type(o["type"]) if o.has_key?("type")
      acct.password(o["password"]) if o.has_key?("password")
      acct.name(o["name"]) if o.has_key?("name")
      acct.mail(o["mail"]) if o.has_key?("mail")
      acct.displayName(o["displayName"]) if o.has_key?("displayName]")
      acct.lastModified(o["lastModifiec"]) if o.has_key?("lastModified")
      acct.active(o["active"]) if o.has_key?("active")
      acct.some_msg[:status] = o["status"] if o.has_key?("status")
      acct.some_msg[:msg_type] = o["msg_type"] if o.has_key?("msg_type")
      acct.some_msg[:msg]= o["msg"] if o.has_key?("msg")
      acct.some_msg[:links] = o["links"] if o.has_key?("links")
      acct
    end

    def self.from_hash(o)
      acct = self.new(o[:name], o[:displayName], o[:mail], o[:password])
      acct.from_hash(o)
      acct
    end

    def from_hash(o)
      @creationDate        = o[:creationDate] if o.has_key?(:creationDate)
      @admin     = o[:admin] if o.has_key?(:admin)
      @type   = o[:type] if o.has_key?(:type)
      @password = o[:password] if o.has_key?(:password)
      @name = o[:name] if o.has_key?(:name)
      @mail = o[:mail] if o.has_key?(:mail)
      @displayName = o[:displayName] if o.has_key?(:displayName)
      @lastModified = o[:lastModified] if o.has_key?(:lastModified)
      @active = o[:active] if o.has_key?(:active)
      self
    end

    def self.create(o)
      acct = from_hash(o)
      acct.create
    end

    # Load a account by email_p
    def self.show(name, displayName, mail, password)
      acct = self.new(name, displayName, mail, password)
      acct.megam_rest.get_accounts(mail)
    end

    # Create the node via the REST API
    def create
      megam_rest.post_accounts(to_hash)
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end
  end
end
