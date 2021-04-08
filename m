Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD77358C7B
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 20:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbhDHSaX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 14:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhDHS3z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 14:29:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FACC0613B4
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 11:29:09 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b18so1611213qte.21
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 11:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rfpjk5lcXiQmXeSx6i4pVVD3rq5mJRtqi0n+qpZr8Ec=;
        b=uxzGce9H+bQxI3BH5eSnZL/WitMYUsWyiXWRdxtpao5coAXNqK6ECiPrZVE6VXKF2d
         CFnPSiZQdP6yjcairauODzoA9soSLiJLebgkNNcL2BAyF5MUxAS7P5C4M86UUGzfgPQV
         LOCPp0ihlS3AG2ENC7WGpgFjZTY5txSczvxDjD7tmVSfQbZ5P9Ym4yOL6BmQy3mZAV+X
         +6IUfO3iU/PRlH4C6yevg8ke5hfllIcxkEb6BySdOrds6Wpbm3ZPy5IL7Q0UKBS/950R
         EoKMmBaAN4rDGa+BOE83OyIhGGRij4llD8VaQ6C/cDMFpzuzbYDBUJ8/H9t9SIp+2du0
         TTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rfpjk5lcXiQmXeSx6i4pVVD3rq5mJRtqi0n+qpZr8Ec=;
        b=RaFCvEnqJjMwJLnvH451p0vnw1NUlhaSajt3/z1I3LTULgjpOfYUwizRGe/+60zh8V
         yfhSrFl347fNSJD4l73EYxdXvz8XdXAzROiNf0YKY4t0s3QtKP1HVsB+Z5ZKK5gLkAss
         7NBlbcpV3BUr3GaqYa/3QCZ/ogCuFBkOYs4G230r1Tj+JLMAAsrKCMNbFnX7l6VnW1b2
         WOGAbYwU1HilFHo9WI/w0u/eu5UpmWLlBP2NvKUDr0MHr8qhnDG0H+/pw4ZscPnaI8Xl
         b5dhBQ3XkHeEyrhyeDGtArAOFv+4Q54PCvGoD1KfBo3JzyeUKfC8kjkluVtPqsx3ubFs
         Ps0A==
X-Gm-Message-State: AOAM533xtBx/wwCijuas8H+TYduBLuwpSATn0i2FalZ5Q4G0aQjqqBgu
        ny6ZN6O+Jn0oJF9Q/50U8MIgJ6bz4JHXffPZCoE=
X-Google-Smtp-Source: ABdhPJykkCoAAlAuPh9UWpRW+zA8QhzqRpVC9BlGLOFGa1L0GzjX44pUdqjjGr9/CGnpUy9ZPsJOE4srXjI5kf/aoHk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a0c:e84e:: with SMTP id
 l14mr10480012qvo.39.1617906548385; Thu, 08 Apr 2021 11:29:08 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:37 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 12/18] arm64: implement function_nocfi
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
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm64/include/asm/memory.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0aabc3be9a75..3a6f9df63606 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -321,6 +321,22 @@ static inline void *phys_to_virt(phys_addr_t x)
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
+	    "add  %0, %0, :lo12:" __stringify(x)			\
+	    : "=r" (addr));						\
+	addr;								\
+})
+#endif
+
 /*
  *  virt_to_page(x)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(x)	indicates whether a virtual address is valid
-- 
2.31.1.295.g9ea45b61b8-goog

