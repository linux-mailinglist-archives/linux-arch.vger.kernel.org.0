Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF59D3EF9
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfJKLvR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727905AbfJKLvR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CB8ACB486;
        Fri, 11 Oct 2019 11:51:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v9 04/28] x86/asm/entry: Annotate THUNKs
Date:   Fri, 11 Oct 2019 13:50:44 +0200
Message-Id: <20191011115108.12392-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
marked as aligned, use NOALIGN.

The result:
 Value  Size Type    Bind   Vis      Ndx Name
  0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
  001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
  0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
  0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
  0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra

The annotation of .L_restore does not generate anything to the code (at
the moment). Here, it just serves documentation purposes (as opening and
closing brackets of functions).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: <x86@kernel.org>
---
 arch/x86/entry/thunk_32.S | 4 ++--
 arch/x86/entry/thunk_64.S | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 2713490611a3..e010d4ae11f1 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -10,8 +10,7 @@
 
 	/* put return address in eax (arg1) */
 	.macro THUNK name, func, put_ret_addr_in_eax=0
-	.globl \name
-\name:
+SYM_CODE_START_NOALIGN(\name)
 	pushl %eax
 	pushl %ecx
 	pushl %edx
@@ -27,6 +26,7 @@
 	popl %eax
 	ret
 	_ASM_NOKPROBE(\name)
+SYM_CODE_END(\name)
 	.endm
 
 #ifdef CONFIG_TRACE_IRQFLAGS
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index ea5c4167086c..c5c3b6e86e62 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -12,7 +12,7 @@
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func, put_ret_addr_in_rdi=0
-	ENTRY(\name)
+SYM_FUNC_START_NOALIGN(\name)
 	pushq %rbp
 	movq %rsp, %rbp
 
@@ -33,7 +33,7 @@
 
 	call \func
 	jmp  .L_restore
-	ENDPROC(\name)
+SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
@@ -56,7 +56,7 @@
 #if defined(CONFIG_TRACE_IRQFLAGS) \
  || defined(CONFIG_DEBUG_LOCK_ALLOC) \
  || defined(CONFIG_PREEMPTION)
-.L_restore:
+SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
 	popq %r10
 	popq %r9
@@ -69,4 +69,5 @@
 	popq %rbp
 	ret
 	_ASM_NOKPROBE(.L_restore)
+SYM_CODE_END(.L_restore)
 #endif
-- 
2.23.0

