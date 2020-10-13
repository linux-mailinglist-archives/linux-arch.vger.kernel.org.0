Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A5228C646
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgJMAe1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgJMAdl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:33:41 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281DC0613B6
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:55 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 7so13738902qtp.18
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=eOx9MhffeJ9wDXWdE5ocpTXQ8u7ymKHm7bpeM0Lggio=;
        b=lfisHSpMMsM7ePJwI+v7HRtPOXkYDBWSveo+yiAPp2kd+swu/ghhLB9oJY5IHVFqiE
         F5vc/SkTvuuf0Lgt7JbGpVg8qXwHBHAcLLbVuo/OA0ocXOhsXIisl8SWGlrqNLOaPUaB
         7bgQuMqSvZNQ9teX/jTQ1S1vOOH5dOspFSNwJNQ/4Rwu9xyb592VpU0PqUz7lhyZyXvY
         fnQb15tKz3yfXXclpkb3Y2MSCar9BR1ao21X+EWkaSZ+y6oxMJbI/K+n3io9XZBJTun5
         YTbUEoZEzysrkxGQ0gkCfW+/irLace7s6VHMzWPne9EQazh8q3VwnXUwyj8Lws+oHFyQ
         0yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eOx9MhffeJ9wDXWdE5ocpTXQ8u7ymKHm7bpeM0Lggio=;
        b=Ef35WYme/DYl4XC7nkVThgnaMpKcYpjvd/5DE2r9XYRMV1Qpz20rArSrPbH18m3N5X
         LIkBHpPrZXOgcvPuNwzM5BVg5e/ApuM3LWutq/IDDnV/5Gkzo4qJaX3gal4zCzJTI9yJ
         S94K0fW8J9XT4FQIBS6w6QUQPgCbG99cgY/azsZpFtISCAKS3ag31V4EDi1j9vrdWCeV
         d+XNkMzMBlEARGFf6JvCy3FYdhm/eeZSYj142ayEZmi/6lndsDJJYRhmpNdtCUdN+9sB
         wOawyhhVrBDaPYHWI9GnwygleDNcy/0ZHqHvbEjujiEF0+0Yrjk/b6lq2rBqFlIpTKVV
         n1oA==
X-Gm-Message-State: AOAM531bXBLa9TxReSytV9Jr3OHtx2VwA/5PUssTodXVBCkcLr82xysq
        KSsCfVzIpEJq2uXVLRDxmp7nJy40/fn+GQ2NhKY=
X-Google-Smtp-Source: ABdhPJzpop6dxq3bNALNHs53P2n45RdCQq8Qh6KI82XpeuF+GDPsSVikWyxpJ2HCELYpKgptdSzk3Rhv0WYhOvJFT2Q=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4eaf:: with SMTP id
 ed15mr7416748qvb.40.1602549175140; Mon, 12 Oct 2020 17:32:55 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:32:00 -0700
In-Reply-To: <20201013003203.4168817-1-samitolvanen@google.com>
Message-Id: <20201013003203.4168817-23-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201013003203.4168817-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 22/25] x86/asm: annotate indirect jumps
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

