Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD053523E0
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 01:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbhDAXdi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 19:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhDAXdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 19:33:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EB1C0610D3
        for <linux-arch@vger.kernel.org>; Thu,  1 Apr 2021 16:32:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w9so7494542ybw.7
        for <linux-arch@vger.kernel.org>; Thu, 01 Apr 2021 16:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=US4jGgKY8G5DfLFeUodkpP35btrx7ts0CLHDF+n9ZqI=;
        b=PRz3MFDuokm+w3IxnWltMpzxfsPLf8nUTH2Cm2JRtKoFDs5tjZV9dE2QQ7zHJVdVLi
         4iY5onXSOWdoZLvRKnbHGN3US9zL9LyQt6POgqN1iJGwPo0t9Q6Mzom1yqVFkfTwGgxR
         7g0AQg/BkgU93LW8c8y/FNi1kjeU5+buOKaJ+c+1Zo96nm+JnRe7GXMG0bfZSVbgwrBy
         S8gTnIGO8lKmp/TA2Irs02Gsmasx5KNnKuAz71fowOI44G0xsJvDSVa4EdT6ZwJ7oiHW
         JIRrVdeZXPVojoF1m9tr8GOvmzAdnoz0Xuud72L3TS/uh00kfkLUB7c1SinbKPgzQdVq
         t+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=US4jGgKY8G5DfLFeUodkpP35btrx7ts0CLHDF+n9ZqI=;
        b=pR2L0BaxIADSW9lsKYfGIUT4ppfVOcCFNGvolzSdQbcAURIm6QXPWcNN7f9xMEiqj7
         lZ0bxoK8efCK7PrhBr0VpFJPXP9BWmpt3heQRyp5hi/b+dp7WJ4eZZW0QIcKkJbicwR3
         UFBboqXIX32i8v8+7LuAPyVdlRCOBDNvcquwBHSsY3SEVcbWIU3aZ/4vngDva0jqHLve
         w4W3/Lpm7cuPdOh63JAwb+NLNh97Dd8wlf6LJPfqPrtnWH1psR9qXxeDxM3QVZm4E19l
         QcWFAgBI1Wb16yTORGx3ZfXNusBO2r6RQJveyGhDGmICt/a6ggQwSUlz93Ufn7nDB/Bv
         tndA==
X-Gm-Message-State: AOAM531nVoUsHAfhJNux7d0dP8i3+XKdwAHYENL6QQp1jpePrxZzke03
        +Dz4apB8pKlN8mtAR3xTpFNIG9F1Mw24Imn55/Q=
X-Google-Smtp-Source: ABdhPJyAtum2nuP+lVZ9BfeUeCfXFUi2ZrH2E6FgcEuBzztVxnpeaqWs+SRUS0lZ2LuUE5T5CK4HQCRb+WFqq84q4xA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a25:ba85:: with SMTP id
 s5mr15701230ybg.336.1617319963848; Thu, 01 Apr 2021 16:32:43 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:10 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 12/18] arm64: implement function_nocfi
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function addresses in
instrumented C code with jump table addresses. This change implements
the function_nocfi() macro, which returns the actual function address
instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/memory.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..b55410afd3d1 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,21 @@ static inline void *phys_to_virt(phys_addr_t x)
 #define virt_to_pfn(x)		__phys_to_pfn(__virt_to_phys((unsigned long)(x)))
 #define sym_to_pfn(x)		__phys_to_pfn(__pa_symbol(x))
 
+#ifdef CONFIG_CFI_CLANG
+/*
+ * With CONFIG_CFI_CLANG, the compiler replaces function address
+ * references with the address of the function's CFI jump table
+ * entry. The function_nocfi macro always returns the address of the
+ * actual function instead.
+ */
+#define function_nocfi(x) ({						\
+	void *addr;							\
+	asm("adrp %0, " __stringify(x) "\n\t"				\
+	    "add  %0, %0, :lo12:" __stringify(x) : "=r" (addr));	\
+	addr;								\
+})
+#endif
+
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
-- 
2.31.0.208.g409f899ff0-goog

