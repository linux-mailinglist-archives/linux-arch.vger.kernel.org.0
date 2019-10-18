Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2E26DCB51
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408855AbfJRQcV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:32:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442973AbfJRQbJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:31:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV90-0002j2-6Z; Fri, 18 Oct 2019 18:30:26 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7BCB51C009C;
        Fri, 18 Oct 2019 18:30:25 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:25 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Replace WEAK uses by SYM_INNER_LABEL_ALIGN
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-29-jslaby@suse.cz>
References: <20191011115108.12392-29-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141622513.29376.15999556589986391789.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     13fbe784ef6e58d0267a6e183f90ce7826d7d885
Gitweb:        https://git.kernel.org/tip/13fbe784ef6e58d0267a6e183f90ce7826d7d885
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:51:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 12:13:35 +02:00

x86/asm: Replace WEAK uses by SYM_INNER_LABEL_ALIGN

Use the new SYM_INNER_LABEL_ALIGN for WEAK entries in the middle of x86
assembly functions.

And make sure WEAK is not defined for x86 anymore as these were the last
users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-29-jslaby@suse.cz
---
 arch/x86/kernel/ftrace_32.S | 2 +-
 arch/x86/kernel/ftrace_64.S | 2 +-
 arch/x86/kernel/head_32.S   | 2 +-
 include/linux/linkage.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index b4f495b..8ed1f5d 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -85,7 +85,7 @@ ftrace_graph_call:
 #endif
 
 /* This is weak to keep gas from relaxing the jumps */
-WEAK(ftrace_stub)
+SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	ret
 SYM_CODE_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 16deae7..69c8d1b 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -168,7 +168,7 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
  * This is weak to keep gas from relaxing the jumps.
  * It is also used to copy the retq for trampolines.
  */
-WEAK(ftrace_stub)
+SYM_INNER_LABEL_ALIGN(ftrace_stub, SYM_L_WEAK)
 	retq
 SYM_FUNC_END(ftrace_caller)
 
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index ea24aa5..3fe7d20 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -156,7 +156,7 @@ SYM_CODE_START(startup_32)
 	jmp *%eax
 
 .Lbad_subarch:
-WEAK(xen_entry)
+SYM_INNER_LABEL_ALIGN(xen_entry, SYM_L_WEAK)
 	/* Unknown implementation; there's really
 	   nothing we can do at this point. */
 	ud2a
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 331a230..9280209 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -121,13 +121,13 @@
 #endif /* CONFIG_X86 */
 #endif /* LINKER_SCRIPT */
 
+#ifndef CONFIG_X86
 #ifndef WEAK
 /* deprecated, use SYM_FUNC_START_WEAK* */
 #define WEAK(name)	   \
 	SYM_FUNC_START_WEAK(name)
 #endif
 
-#ifndef CONFIG_X86
 #ifndef END
 /* deprecated, use SYM_FUNC_END, SYM_DATA_END, or SYM_END */
 #define END(name) \
