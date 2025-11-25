return {
  "mfussenegger/nvim-lint",
  config = function()
    -- vim.diagnostic.set을 오버라이드해서 ktlint 에러 필터링
    local original_set = vim.diagnostic.set

    vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
      -- ktlint 파서 에러만 필터링
      local filtered = vim.tbl_filter(function(diagnostic)
        local message = diagnostic.message or ""

        -- 필터링할 메시지 패턴들
        return not (
          message:find("Skipping rule%(s%)") or
          message:find("IllegalStateException") or
          message:find("Parser failed") or
          message:find("RunAfterRuleFilter") or
          message:find("Expected value but found invalid token") or
          message:find("Cannot access.*it is internal") or
          message:find("Unresolved reference: MutableStateFlow") or
          message:find("Unresolved reference: kotlinx") or
          message:find("Unresolved reference: Optional")
        )
      end, diagnostics)

      -- 필터링된 diagnostics로 원래 함수 호출
      original_set(namespace, bufnr, filtered, opts)
    end
  end,
}
