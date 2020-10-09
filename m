Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402AA288E6D
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389837AbgJIQPr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389831AbgJIQOw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:14:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C47C0613B8
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:14:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k3so9384981ybk.16
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eOx9MhffeJ9wDXWdE5ocpTXQ8u7ymKHm7bpeM0Lggio=;
        b=Plxh6rO8fZsaoEQYUiFTv8Gctd0ORGzpZ7B+rZvfUdc7hYRYEfwwGuB/jOOB4N8mRZ
         iAAD+kQylOB8+xnUsPp1FuxiMJFvWDb9+nHFjKZSUxLvWnE/9FbEqxjRwOpDx5ONEslI
         8qXKafYcstPuDgNqimTWoairPVZO2J3rswrWaBPN8Qj/9SVTW+SDOPJ/1LdMPf3bODQ3
         tIT8O2Z6HcQ4IP/C1bLPAj4juZIAgQDUFSX0gtccixqyP1Lwa6S3qb2MSbgtHQfAoxEv
         QRJywRQXLDBTL6z66phNxnXE5ujjd1RTPx5601HvsGfueNCH/Cf7DS82U8ob3oCEPZMJ
         O6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eOx9MhffeJ9wDXWdE5ocpTXQ8u7ymKHm7bpeM0Lggio=;
        b=hAMHIGz3hHJ4d4ZTOuqH5QD6FiLpsTheIiFp0e2jcN1+O6V5qa8T8f+pZBshtqorpN
         UJxeNgsJQ7fiNJYZR5eQoAD6wvD2HWLD/q2htPdMK/xWLzrZXCB94Uuzu9xKnHhOKp9W
         lTtKCvY9ec90NgsoUgU05aApCJNmA10zvyp/BOkZcfC6QFfb9q79qhjLnNE6zNJsV/jZ
         7G+uTeqTmpNUKBBt2b5EnzEWciIgMVs7P+bngEzBGqVxLl24/pOrpgRLObE7xrX4g2T6
         sThZBPnRdNxzlZ5kzxHd2NEt/LTbsc3N9/y1TPT9g2W2wZvMtz9x6IXXxkk7NEcbvUgj
         D79g==
X-Gm-Message-State: AOAM531F/asCawimVX0FzSTYqe/uAZTO/ziEk9fm/DEGbYyssIVpJ6v9
        vrNhSgGk4slJ7QJdHgfTng71tG1cNTjaBIo0+Wk=
X-Google-Smtp-Source: ABdhPJxyS0XHBxv62ZqOUe+ZCIUsnixCIBFhk+Syvlgu7UF8/267koanykdI+IOKX/T5PRLdfssp5bIj1Kz2wguq10U=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:8209:: with SMTP id
 q9mr19033461ybk.353.1602260072154; Fri, 09 Oct 2020 09:14:32 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:35 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-27-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 26/29] x86/asm: annotate indirect jumps
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Running objtool --vmlinux --duplicate on vmlinux.o produces a few
warnings about indirect jumps with retpoline:

  vmlinux.o: warning: objtool: wakeup_long64()+0x61: indirect jump
  found in RETPOLINE build
  ...

This change adds ANNOTATE_RETPOLINE_SAFE annotations to the jumps
in assembly code to stop the warnings.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/acpi/wakeup_64.S  | 2 ++
 arch/x86/platform/pvh/head.S      | 2 ++
 arch/x86/power/hibernate_asm_64.S | 3 +++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index c8daa92f38dc..041e79c4e195 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -7,6 +7,7 @@
 #include <asm/msr.h>
 #include <asm/asm-offsets.h>
 #include <asm/frame.h>
+#include <asm/nospec-branch.h>
 
 # Copyright 2003 Pavel Machek <pavel@suse.cz
 
@@ -39,6 +40,7 @@ SYM_FUNC_START(wakeup_long64)
 	movq	saved_rbp, %rbp
 
 	movq	saved_rip, %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp	*%rax
 SYM_FUNC_END(wakeup_long64)
 
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 43b4d864817e..640b79cc64b8 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -15,6 +15,7 @@
 #include <asm/asm.h>
 #include <asm/boot.h>
 #include <asm/processor-flags.h>
+#include <asm/nospec-branch.h>
 #include <asm/msr.h>
 #include <xen/interface/elfnote.h>
 
@@ -105,6 +106,7 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* startup_64 expects boot_params in %rsi. */
 	mov $_pa(pvh_bootparams), %rsi
 	mov $_pa(startup_64), %rax
+	ANNOTATE_RETPOLINE_SAFE
 	jmp *%rax
 
 #else /* CONFIG_X86_64 */
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 7918b8415f13..715509d94fa3 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -21,6 +21,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/processor-flags.h>
 #include <asm/frame.h>
+#include <asm/nospec-branch.h>
 
 SYM_FUNC_START(swsusp_arch_suspend)
 	movq	$saved_context, %rax
@@ -66,6 +67,7 @@ SYM_CODE_START(restore_image)
 
 	/* jump to relocated restore code */
 	movq	relocated_restore_code(%rip), %rcx
+	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%rcx
 SYM_CODE_END(restore_image)
 
@@ -97,6 +99,7 @@ SYM_CODE_START(core_restore_code)
 
 .Ldone:
 	/* jump to the restore_registers address from the image header */
+	ANNOTATE_RETPOLINE_SAFE
 	jmpq	*%r8
 SYM_CODE_END(core_restore_code)
 
-- 
2.28.0.1011.ga647a8990f-goog

