return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      local col = function(strlist, opts)
        -- strlist is a TABLE of TABLES, representing columns of text
        -- opts is a text display option

        -- column spacing
        local padding = 12
        -- fill lines up to the maximim length with 'fillchar'
        local fillchar = " "
        -- columns padding char (for testing)
        local padchar = " "

        -- define maximum string length in a table
        local maxlen = function(str)
          local max = 0
          for i in pairs(str) do
            if #str[i] > max then
              max = #str[i]
            end
          end
          return max
        end

        -- add as much right-padding to align the text block
        local pad = function(str, max)
          local strlist = {}
          for i in pairs(str) do
            if #str[i] < max then
              local newstr = str[i] .. string.rep(fillchar, max - #str[i])
              table.insert(strlist, newstr)
            else
              table.insert(strlist, str[i])
            end
          end
          return strlist
        end

        -- this is a table for text strings
        local values = {}
        local buttonsValues = {}
        -- process all the lines
        for i = 1, maxlen(strlist) do
          local str = ""
          -- process all the columns but last, because we dont wand extra padding
          -- after last column
          for column = 1, #strlist - 1 do
            local maxstr = maxlen(strlist[column])
            local padded = pad(strlist[column], maxstr)
            if strlist[column][i] == nil then
              str = str .. string.rep(fillchar, maxstr) .. string.rep(padchar, padding)
            else
              str = str .. padded[i] .. string.rep(padchar, padding)
            end
          end

          -- lets process the last column, no extra padding
          do
            local maxstr = maxlen(strlist[#strlist])
            local padded = pad(strlist[#strlist], maxstr)
            if strlist[#strlist][i] == nil then
              str = str .. string.rep(fillchar, maxlen(strlist[#strlist]))
            else
              str = str .. padded[i]
            end
          end

          -- insert result into output table
          table.insert(values, { type = "text", val = str, opts = opts })
        end

        return values
      end

      local logo = [[
                                                                                                                                                                                                          
                                                                                                                                                                                                        
                                                                                                                                                                                                       
                                                                                           #                          *(                                                                                
                                                                                          &(                          (&                                                                                
                                                                                         &&                            &&                                                                               
                                                                                        &&                             &&(                                                                              
                                                                                       @&                              %&&                                                                              
                                                                                     .&&,                              &&&               &                                                              
                                                   #%                               &@&&&&&&&&&&&&&&&&#        ,/###&@&&&&&           #&/                                                               
                                                       &&,                      /&&&&&&@&@&&%#%&&&@&@@@%. /&&&&&@&&&&&@&&&&&&&/    #&&#                ,                                                
                                                        ,&&%                 /&&&&&#.               %&&&&&&&#. (&#,       #&&&&&&&&&                  //                                                
                                                          &@&@.            &&&&&             .(&&&&&@#         *&&&&&&&       *%&&&&&&               ,&                                                 
                                                            &@@&&&&&&&&% &&&& #&&&&&&&@&&&&&&@&#*.                  &@&&&, *,.     ,&&&&*            &&                                                 
                                                            %&&&@&&&&# &&&%      .##(/,  ,%&&&&&&&&&&&&&&&&&&&&&&&&&@,.&&&&& (&&&&&&&&&&%/          &&&                                                 
                                          */             .&&&&,      &&&&    /&&&&&&&&&#               .,/#&&@&&&&#.     *&&&&#     ,(%&&&&&&&&&.  (&&(                                                 
                                              ,@&&&*   &&&&&       .&&&  (&&&&&&&&%                          #&&&          ,&&&&&/       @&* (@&&&&&&&/                                                 
                                                   *.&&&@&        ./&&&&&&&&&&&&%                              ,&*           #&&&&&&#     &&&%  .&&&&&&,                                                
                                                   &&&&&,#&&&&&&&&&&&(      ,&&&,                  (&            &&             #&&&&&&&  ,&&&&&. ./(###        ,(                                      
                                                  %&&&&,&&&&&&%. (*           &&#                  (&              &            .&&&&&&&&@//&&&&&&&&&&&&&#,.                                            
                                                 .&&&& &&&   #&&&              &&            (&&&&&&&&&&&&&         ,          *&&#     .&& &&&&&.   &&&&/                                              
                                              #&.&&&&//    /&&&.                %(                 (&                         #&#          . &&&(    ,&&&&                                              
                                           &&&&& &&&&    *&&&%                   *       &#        (&         *&             #%              &&&& &&  &&&&.                                             
                                         &&&&&&& &&&&  ,&&&&/                            %&        (&         %&            *.               &&&&%,&&&(.&@(                                             
                                        /&&&&&,  &&&./&&&&@.                        &&&&&&@/*.     (&   *&&&&&&&&&&&&                        .&&&&* &&&&@ /                                             
                                        &&&&(    * &&&&&@*                               .&        (&         &,                               &&&&   /&@@&.                                            
                                       *&&&.    /&&&&&                                    &/       (&        ,&                                 &&&#  (#.&&&&                                           
                                     , @&&&    &@&&*,                                     &#       (&        (&                                  &&&& #&&,(&&&*                                         
                                   %&&&&&&&   &&@%.&&                                     #&       (&        &%                                ,%&&&& &&&   @&&(    *#&#.                               
                                       &&&&  @&&* &&&&&%*..,(&&&&%#/*                     ,&       (&        &/                         .(@&&&&&&&&&@ &&&..* &&&#,                                      
                                       /&&& &&&/  &&&&&&&%*                                &. #&&&&&&&&&&&&&%&.                                    & &&&&&&&,(&&&/                                      
                                        &&&%.&,  &&&&                                    ,&&&&&&&&&&&&&&&&&&&&&&&@#                                 &&&&*    .&&&&,                                     
                                        ,&&&(    &&&&                                 %&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&.                          ,&&@& @    .&&&&&(                                    
                                        #,&&&%   &&&&&&&*                          &&&&&&&&&&&&&&&&&@&&&&&&&&&&&&&&&&&&&&@&                      %&&&& @@&,  (&&&&&&&&&.                                
                                      *&@& &&&@, ,&&&.     .                   #@&&&&&&&&&&&&&&&&&&&&&&%%&&&%%&&&%&&&&&&&&&&&&#                 ,&&&&  (&&&# &&#        ,%&(                            
                                    .&&&&.   &&&& &&                     ,&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&(&&&&(&@&&(&&&%&&&%&&&&&#,.         *&&&,   .&&&#%%              /&#                        
                                  #&&&&&&,    ,&& &&.            ,  &&&&&&&&&&&&&@@&&&&&&&&&&&&&&&@&&&&%@&&&#@&&&*&&&&/&&@&*@&&(&&&#&&&&&&&     /&&(     (&&&                                           
                               (&&&&&(&&&&      .(&&..       &%   &  .*/      .&&&&*      #&&&&&&&&/   .&&&%#&&&%#&&&%/&&&%*&&&#/&@&/&&%(&&&&, ,&&&       &&&*                                          
                             %&&&.     &&&&      &&#/&&   &&/   (&.   &&&&&&&&&&&&&&&&,        %&&# .&&#   .&&&&#%&&&##&&&#*&&&#*&@&((&&&*&@& %&&&&     ,&,@&&.                                         
                           *&(          &&&&    &&& &&&@ %&/  %&&  (    /&@&&        ,&% (  / *%&&@     .#             &&&(#&&&/*&@&(*@&&*( &&&@&&&*  .&&& &&&&/                                        
                          &              &&&&,  &&&  %&&&*  /&&,/   &/   &&&*/(#%&&.     ,&%   .&&&&*     ,&&&&&&&      ##.%&&&*#&&&,/@&& &&&...&&&**&&&&,  &&&&                                        
                        ,                 &&&&% &&&   *&&&&@&&    .&&&* ,/&&####((/ *&%      #      @&%/,     ,%&&&&&&(      /%,&@&&.%&%*&**&%..& %&@&&&@&&&*                                           
                                           &&&&&(.&    .&&&&&,(&&&&&&/&%.*&&&&&&&@&&&.  *&/      #/%&%%%.          .(&&&&&#    .* *#.&/#  &&&# ,&&&&&&/,.                                               
                                            .&&&&@&.    *&&&&,&&&&&&&&&&&&&&&&&&&&&&&&* #/  #&/%  ,#&&&&&&&&.     *      .&(. &.  (#   &*,&(.&&&&&#*&     (&&&*                                         
                                                %&&&@&(  %&&&#(&&&&&&@&&@&&(.     /&&&@&# #(#&&&&&@%      /&&&&&&#           &&&&@&&#.   .@&&&&&(*&&&.  *&&@&                                           
                                                @&.,&&&&& &&&& &&&&&&&@&%(*,*%&(. ,#%/  ./%@&&&&&&&&&&&@&&%,     .(&&(%      &&&&&%    ,*&&&&&(  %&&&*#&&&&                                             
                                                &&&@  (&&& @&&#*@&&&&&&&&&&&&&&&#(#&#* &&&&&(. (&(.(*&&@@/  (&&&%,    *& @&&&&&%&#  .&& &&&&#    %&&&*#&&&&#                                            
                                                  *@@&&@@&& &&&,%& /@&&&&&&&&&&&&&&@  @&&&&&@& . (%(  .&%&&&#   *#(    #@ &&&&&&&&&&& *&&&&    / &&&@     @&&&                                          
                                             *&&&&&( .       &&& &&&&&* #&&&&&&@/ %%.&@&@( #&.(&&&&&&&&&&&(  .  .       %&/   *&&&&&.%&&& .%&&& &&&&         %&%                                        

     ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", "", ":Telescope find_files <CR>"),
        dashboard.button("n", "", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", "", ":Telescope oldfiles <CR>"),
        dashboard.button("g", "", ":Telescope live_grep <CR>"),
        dashboard.button("c", "", ":e $MYVIMRC <CR>"),
        dashboard.button("s", "", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "", ":Lazy<CR>"),
        dashboard.button("q", "", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
        button.opts.width = 1000
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      local first = {
        "[f]   " .. " New file",
        "[n]  " .. " New file",
        "[r]  " .. " Recent files",
      }

      local second = {
        "[g]  " .. " Find text",
        "[c]  " .. " Config",
        "[s]  " .. " Restore Session",
      }

      local third = {
        "[f] 󰒲 " .. " Lazy",
        "[n]  " .. " Quit",
      }

      local block = {
        type = "group",
        val = col({ first, second, third }, {
          position = "center",
          hl = { { "Comment", 0, -1 }, { "Title", 89, 100 }, { "Title", 152, 159 }, { "Title", 198, 209 } },
        }),
        opts = {
          spacing = 0,
        },
      }

      local opts = {
        layout = {
          dashboard.section.header,
          block,
          { type = "padding", val = 2 },
          dashboard.section.footer,
          dashboard.section.buttons,
        },
        opts = {
          noautocmd = true,
          margin = 5,
        },
      }
      dashboard.opts.layout[1].val = 8
      dashboard.opts = opts

      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
}
