local opts = {
  provider = "hyperbolic",
  vendors = {
    deepseek = {
      __inherited_from = "openai",
      api_key_name = "DEEPSEEK_API_KEY",
      endpoint = "https://api.deepseek.com/v1",
      model = "deepseek-chat",
    },

    hyperbolic = {
      __inherited_from = "openai",
      api_key_name = "cmd:cat /run/secrets/hyperbolic_api_key",
      endpoint = "https://api.hyperbolic.xyz/v1",
      model = "deepseek-ai/DeepSeek-V3",
      temperature = 0,
      max_tokens = 4096,
    },
  },
}

return opts
