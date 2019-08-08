Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B35E85FFB
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389754AbfHHKjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:39:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:47402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732116AbfHHKi7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:38:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 188EAAF2A;
        Thu,  8 Aug 2019 10:38:58 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v8 02/28] x86/asm/suspend: use SYM_DATA for data
Date:   Thu,  8 Aug 2019 12:38:28 +0200
Message-Id: <20190808103854.6192-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some global data in the suspend code were marked as `ENTRY'. ENTRY was
intended for functions and shall be paired with ENDPROC. ENTRY also
aligns symbols which creates unnecessary holes here between data. Since
we are dropping historical markings, make proper use of newly added
SYM_DATA in this code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_32.S | 2 +-
 arch/x86/kernel/acpi/wakeup_64.S | 2 +-
 arch/x86/kernel/head_32.S        | 6 ++----
 arch/x86/kernel/head_64.S        | 5 ++---
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index e95e95960156..427249292aef 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -90,7 +90,7 @@ ret_point:
 
 .data
 ALIGN
-ENTRY(saved_magic)	.long	0
+SYM_DATA(saved_magic,	.long 0)
 saved_eip:		.long 0
 
 # saved registers
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index b0715c3ac18d..a142c5ee0d4f 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -134,4 +134,4 @@ saved_rbx:		.quad	0
 saved_rip:		.quad	0
 saved_rsp:		.quad	0
 
-ENTRY(saved_magic)	.quad	0
+SYM_DATA(saved_magic,	.quad	0)
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 30f9cb2c0b55..d1e213da4782 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -507,10 +507,8 @@ GLOBAL(early_recursion_flag)
 
 __REFDATA
 	.align 4
-ENTRY(initial_code)
-	.long i386_start_kernel
-ENTRY(setup_once_ref)
-	.long setup_once
+SYM_DATA(initial_code,		.long i386_start_kernel)
+SYM_DATA(setup_once_ref,	.long setup_once)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 #define	PGD_ALIGN	(2 * PAGE_SIZE)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index f3d3e9646a99..6c1bf7ae55ff 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -469,9 +469,8 @@ early_gdt_descr:
 early_gdt_descr_base:
 	.quad	INIT_PER_CPU_VAR(gdt_page)
 
-ENTRY(phys_base)
-	/* This must match the first entry in level2_kernel_pgt */
-	.quad   0x0000000000000000
+/* This must match the first entry in level2_kernel_pgt */
+SYM_DATA(phys_base, .quad 0x0000000000000000)
 EXPORT_SYMBOL(phys_base)
 
 #include "../../x86/xen/xen-head.S"
-- 
2.22.0

