-- Add auto pairing for things such as parenthesis 
-- (https://github.com/windwp/nvim-autopairs)
return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
}
