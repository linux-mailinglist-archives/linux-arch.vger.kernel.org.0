Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB7D3EDB
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfJKLvq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:51:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:33364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728147AbfJKLva (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 634A7B488;
        Fri, 11 Oct 2019 11:51:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v9 28/28] x86/asm: Replace WEAK uses by SYM_INNER_LABEL_ALIGN
Date:   Fri, 11 Oct 2019 13:51:08 +0200
Message-Id: <20191011115108.12392-29-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the new SYM_INNER_LABEL_ALIGN for WEAK entries in the middle of x86
assembly functions.

And make sure WEAK is not defined for x86 anymore as these were the last
users.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/ftrace_32.S | 2 +-
 arch/x86/kernel/ftrace_64.S | 2 +-
 arch/x86/kernel/head_32.S   | 2 +-
 include/linux/linkage.h     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index b4f495bbd5a1..8ed1f5d371f0 100644
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
index 16deae706950..69c8d1b9119e 100644
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
index ea24aa5465fd..3fe7d2008b7a 100644
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
index 331a2306312c..9280209d1f62 100644
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
-- 
2.23.0

