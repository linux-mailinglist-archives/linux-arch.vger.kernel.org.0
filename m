Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6D199D1
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2019 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfEJImU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 May 2019 04:42:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:47044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbfEJImU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 May 2019 04:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6C62AF24;
        Fri, 10 May 2019 08:42:17 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH] vsprintf: Do not break early boot with probing addresses
Date:   Fri, 10 May 2019 10:42:13 +0200
Message-Id: <20190510084213.22149-1-pmladek@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510081635.GA4533@jagdpanzerIV>
References: <20190510081635.GA4533@jagdpanzerIV>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The commit 3e5903eb9cff70730 ("vsprintf: Prevent crash when dereferencing
invalid pointers") broke boot on several architectures. The common
pattern is that probe_kernel_read() is not working during early
boot because userspace access framework is not ready.

It is a generic problem. We have to avoid any complex external
functions in vsprintf() code, especially in the common path.
They might break printk() easily and are hard to debug.

Replace probe_kernel_read() with some simple checks for obvious
problems.

Details:

1. Report on Power:

Kernel crashes very early during boot with with CONFIG_PPC_KUAP and
CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG

The problem is the combination of some new code called via printk(),
check_pointer() which calls probe_kernel_read(). That then calls
allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
(before we've patched features). With the JUMP_LABEL debug enabled that
causes us to call printk() & dump_stack() and we end up recursing and
overflowing the stack.

Because it happens so early you don't get any output, just an apparently
dead system.

The stack trace (which you don't see) is something like:

  ...
  dump_stack+0xdc
  probe_kernel_read+0x1a4
  check_pointer+0x58
  string+0x3c
  vsnprintf+0x1bc
  vscnprintf+0x20
  printk_safe_log_store+0x7c
  printk+0x40
  dump_stack_print_info+0xbc
  dump_stack+0x8
  probe_kernel_read+0x1a4
  probe_kernel_read+0x19c
  check_pointer+0x58
  string+0x3c
  vsnprintf+0x1bc
  vscnprintf+0x20
  vprintk_store+0x6c
  vprintk_emit+0xec
  vprintk_func+0xd4
  printk+0x40
  cpufeatures_process_feature+0xc8
  scan_cpufeatures_subnodes+0x380
  of_scan_flat_dt_subnodes+0xb4
  dt_cpu_ftrs_scan_callback+0x158
  of_scan_flat_dt+0xf0
  dt_cpu_ftrs_scan+0x3c
  early_init_devtree+0x360
  early_setup+0x9c

2. Report on s390:

vsnprintf invocations, are broken on s390. For example, the early boot
output now looks like this where the first (efault) should be
the linux_banner:

[    0.099985] (efault)
[    0.099985] setup: Linux is running as a z/VM guest operating system in 64-bit mode
[    0.100066] setup: The maximum memory size is 8192MB
[    0.100070] cma: Reserved 4 MiB at (efault)
[    0.100100] numa: NUMA mode: (efault)

The reason for this, is that the code assumes that
probe_kernel_address() works very early. This however is not true on
at least s390. Uaccess on KERNEL_DS works only after page tables have
been setup on s390, which happens with setup_arch()->paging_init().

Any probe_kernel_address() invocation before that will return -EFAULT.

Fixes: 3e5903eb9cff70730 ("vsprintf: Prevent crash when dereferencing invalid pointers")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7b0a6140bfad..2f003cfe340e 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -628,19 +628,16 @@ static char *error_string(char *buf, char *end, const char *s,
 }
 
 /*
- * This is not a fool-proof test. 99% of the time that this will fault is
- * due to a bad pointer, not one that crosses into bad memory. Just test
- * the address to make sure it doesn't fault due to a poorly added printk
- * during debugging.
+ * Do not call any complex external code here. Nested printk()/vsprintf()
+ * might cause infinite loops. Failures might break printk() and would
+ * be hard to debug.
  */
 static const char *check_pointer_msg(const void *ptr)
 {
-	char byte;
-
 	if (!ptr)
 		return "(null)";
 
-	if (probe_kernel_address(ptr, byte))
+	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
 		return "(efault)";
 
 	return NULL;
-- 
2.16.4

