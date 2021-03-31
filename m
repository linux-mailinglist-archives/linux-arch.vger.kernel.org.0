Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDAE350951
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbhCaV2T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhCaV1s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:48 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E628C061760
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:48 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y9so2357578qki.14
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RWJ9aQhTl20nw/R5RXPJl7NDj1C/UnL5LrldsenTslw=;
        b=OI2BXN7KaQv0FSebUTwCneDYkgM3EAclc0LW8tfWF13e9tAHbT6S7IOhSWAvQZLEnM
         JINs3HBpLvp6Qvodp3XPXwpa2AY4B6TKaD777pUzRWtoTAYeD1ocUHZu2HycU4zx1Kmv
         TNPKwT23uSIbpB+4L8uGbr3k4clT4tWUBKmb6FlOF1Rr6P3NPk9yRjsBi/8/WqNqXQ91
         l8FNow8wvarKsgb5E8LUZNePMtfEnTyG4gLYP5Kv+xRbrPTbyVM2AH1BrU969hKl7202
         it/AECGlU/1SsjxKqzkPukkeE7jMpt1aJJc+o2/Ob3guLAV3RI2sN0Iy2pgsPxnRnjo4
         2KMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RWJ9aQhTl20nw/R5RXPJl7NDj1C/UnL5LrldsenTslw=;
        b=LZ6d2ZeVhmHJaey7QbAZM4LFQHXht51Rmpvk4SqlrxvF7IIoAxUzz2Q0UWeo6eO7Yl
         KvbDnaQnqLuB3KbodFOFojTafsa1OGOz1hLAO298Z2BEKSEUiRd30Avkm8vyaxbDmeh9
         foUcZd+7fe84JMUa88Ou1krOBntsApZvDJIRZHwcy37+vImV2uhkpK+eRH1SBqt/eP7g
         BSTVL0j96VzBGZCkuARbwLCfw0bNijZ6Tchljt4Ck+LdD1JC4l0wwhvFB/6UVu1oysws
         wYVLIBF1L6beLInmpMbVuwCxCnOoE/bwuEdZe1Eq/vfAf1/aFMqN2AV/VaQZR7L3VWDE
         mF8w==
X-Gm-Message-State: AOAM530hJ5ASYfrSXq2/dKKj892gIvW9KaB5iAqXH+G6guHPxV6QbnyT
        QjRu8477dq3tmyE7CKtqRpmU9mLFOpk2AGFD5jM=
X-Google-Smtp-Source: ABdhPJwgeYfpiU4TaL+sNYk8JQhgUoPaRCwg5+9HCoLujfPlRhTT1jZ0jK2Sqbbps882JdAhQwjOAlmdak1l08CL8Lw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b410:: with SMTP id
 u16mr5255799qve.8.1617226067444; Wed, 31 Mar 2021 14:27:47 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:16 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 12/17] arm64: implement function_nocfi
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
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
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
2.31.0.291.g576ba9dcdaf-goog

