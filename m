Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BA1346A0A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhCWUkB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbhCWUjx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:39:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FBBC0613DB
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:39:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so3805647ybc.13
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bTCEWvQMjkTW/eVBx3Fi28gIb6vhFXkJKuQZd7egWL4=;
        b=Mvn7lVq7e94Xs9OllSd9NAojDT1Q4suOxQi12d+B51KtOKIdMx0eF7tdNTA4iGEpNc
         ZT4DHBgg761FglHw7pwMEYDTT1Ecj7P/xF38j+p9TKtZbkyqcsGDtFE/RHzgKWZl+VHO
         uCsdIPhwwFaLxjgvQ6z41fx3DrWVbQUxBcWiGwtvTfBRpGu+zwZz1oFLdNIu/A2tGpWz
         P0ivEwPNEDS/3rKoR7F5Z2X623Tsi3/kfzJf/dJCiIqTQEt8dnId9DYrNflKjRBmYsEY
         3yjnIOKkQ8kHE6WAEa51Dbz5jOPibBaaQiBVe2nGs+TAM55eM5uQVd3zyU422J7qChbA
         V5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bTCEWvQMjkTW/eVBx3Fi28gIb6vhFXkJKuQZd7egWL4=;
        b=lcDbuarVGb34mMCmvE2EWhhpBzbicrnwrwofH06wQFLk/xlFz62I+LvvU6Pi1esSN5
         H2a/YZykwMpOITMqZC9/Qg4/mSg1hL9YuZ1xFnbKsKgJhSyhihiLHAYwE16cpoFoPRlA
         8I0pZ+yVVl8WsWiU34LroY2Ixrz3Izy7tL5tOofI0h2vvPAwDWGUzA9SPvXraqjHc4T7
         W94PfPLtfQvrQFNRDRpWzE0ukGRzbo/KnrCJ5iwlXpJv6KjUs2blO+i0JWob2mx/r9SJ
         sjCDlo3fjwayWU9fhPkHPNbWIlyq0HLjKCQ8aLi0PPxCl8+MMISFHk183Yq6J34ftMVO
         GpeQ==
X-Gm-Message-State: AOAM530ZT7ZwbhzEpSnMf5jQ9rSzMCkDXE9O+3JRAfkHOK+I0/wXLQxZ
        MJe/JbH8i7Wi2aJW53bTL0ysZ7TZ2KMOS0mtNDU=
X-Google-Smtp-Source: ABdhPJxwOPrsV/lppntljv3ZRk7U60aDtP04A2wkg90aE1+shnozpf82bcMb0fGuvfEtjKLsVJLLsrwjtM8144LkmFo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:a25:3ac1:: with SMTP id
 h184mr34203yba.503.1616531992519; Tue, 23 Mar 2021 13:39:52 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:31 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-3-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 02/17] cfi: add __cficanonical
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces a function address taken
in C code with the address of a local jump table entry, which passes
runtime indirect call checks. However, the compiler won't replace
addresses taken in assembly code, which will result in a CFI failure
if we later jump to such an address in instrumented C code. The code
generated for the non-canonical jump table looks this:

  <noncanonical.cfi_jt>: /* In C, &noncanonical points here */
	jmp noncanonical
  ...
  <noncanonical>:        /* function body */
	...

This change adds the __cficanonical attribute, which tells the
compiler to use a canonical jump table for the function instead. This
means the compiler will rename the actual function to <function>.cfi
and points the original symbol to the jump table entry instead:

  <canonical>:           /* jump table entry */
	jmp canonical.cfi
  ...
  <canonical.cfi>:       /* function body */
	...

As a result, the address taken in assembly, or other non-instrumented
code always points to the jump table and therefore, can be used for
indirect calls in instrumented code without tripping CFI checks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci.h
---
 include/linux/compiler-clang.h | 1 +
 include/linux/compiler_types.h | 4 ++++
 include/linux/init.h           | 4 ++--
 include/linux/pci.h            | 4 ++--
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 6de9d0c9377e..adbe76b203e2 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -63,3 +63,4 @@
 #endif
 
 #define __nocfi		__attribute__((__no_sanitize__("cfi")))
+#define __cficanonical	__attribute__((__cfi_canonical_jump_table__))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 796935a37e37..d29bda7f6ebd 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -246,6 +246,10 @@ struct ftrace_likely_data {
 # define __nocfi
 #endif
 
+#ifndef __cficanonical
+# define __cficanonical
+#endif
+
 #ifndef asm_volatile_goto
 #define asm_volatile_goto(x...) asm goto(x)
 #endif
diff --git a/include/linux/init.h b/include/linux/init.h
index b3ea15348fbd..045ad1650ed1 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -220,8 +220,8 @@ extern bool initcall_debug;
 	__initcall_name(initstub, __iid, id)
 
 #define __define_initcall_stub(__stub, fn)			\
-	int __init __stub(void);				\
-	int __init __stub(void)					\
+	int __init __cficanonical __stub(void);			\
+	int __init __cficanonical __stub(void)			\
 	{ 							\
 		return fn();					\
 	}							\
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..39684b72db91 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1944,8 +1944,8 @@ enum pci_fixup_pass {
 #ifdef CONFIG_LTO_CLANG
 #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				  class_shift, hook, stub)		\
-	void stub(struct pci_dev *dev);					\
-	void stub(struct pci_dev *dev)					\
+	void __cficanonical stub(struct pci_dev *dev);			\
+	void __cficanonical stub(struct pci_dev *dev)			\
 	{ 								\
 		hook(dev); 						\
 	}								\
-- 
2.31.0.291.g576ba9dcdaf-goog

