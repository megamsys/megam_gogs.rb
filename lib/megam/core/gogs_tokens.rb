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
  class GogsTokens

    # Transform the ruby obj ->  to a Hash
    def self.to_hash(response)
  
       index_hash = response.body
      {:status => response.status, :body => index_hash }
    end



    def self.list(username, password)

      megams = Megam::Gogs.new
      res = megams.get_tokens(username, password)
      hash = {}
      puts res
      puts res.status
      if res.status != 200
        hash = self.error(res)
      else
        hash = self.to_hash(res)
      end
      hash
    end

    def self.error(response)

      {:status => response.status, :body => ""}
    end

    def to_s
      Megam::Stuff.styled_hash(to_hash)
    end
  end
end
