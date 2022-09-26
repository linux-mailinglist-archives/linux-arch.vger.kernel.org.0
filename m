Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0FC5EB471
	for <lists+linux-arch@lfdr.de>; Tue, 27 Sep 2022 00:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiIZWRo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Sep 2022 18:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbiIZWRR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Sep 2022 18:17:17 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E5A6A4B5;
        Mon, 26 Sep 2022 15:17:00 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:43744)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ocwOT-001CVq-En; Mon, 26 Sep 2022 16:16:05 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:42146 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ocwOR-00962z-8R; Mon, 26 Sep 2022 16:16:05 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-arch@vger.kernel.org>
Date:   Mon, 26 Sep 2022 17:15:32 -0500
Message-ID: <871qrx3hq3.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ocwOR-00962z-8R;;;mid=<871qrx3hq3.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+9B/Nm3Lp/ocJiezHkV8uDvjNhC/JcGV0=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1591 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 10 (0.6%), parse: 2.3 (0.1%),
         extract_message_metadata: 30 (1.9%), get_uri_detail_list: 12 (0.7%),
        tests_pri_-1000: 29 (1.8%), tests_pri_-950: 1.37 (0.1%),
        tests_pri_-900: 1.31 (0.1%), tests_pri_-90: 187 (11.7%), check_bayes:
        181 (11.4%), b_tokenize: 41 (2.6%), b_tok_get_all: 24 (1.5%),
        b_comp_prob: 6 (0.4%), b_tok_touch_all: 104 (6.5%), b_finish: 0.96
        (0.1%), tests_pri_0: 1305 (82.0%), check_dkim_signature: 1.18 (0.1%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.45 (0.0%), tests_pri_10:
        2.6 (0.2%), tests_pri_500: 17 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] a.out: Remove the a.out implementation
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


In commit 19e8b701e258 ("a.out: Stop building a.out/osf1 support on
alpha and m68k") the last users of a.out were disabled.

As nothing has turned up to cause this change to be reverted, let's
remove the code implementing a.out support as well.

There may be userspace users of the uapi bits left so the uapi
headers have been left untouched.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

I was reminded that while this code was successfully disabled
in the kernel we haven't deleted it yet.

Kees can you pick this up.

 MAINTAINERS                           |   1 -
 arch/alpha/include/asm/a.out.h        |  16 --
 arch/alpha/kernel/Makefile            |   4 -
 arch/alpha/kernel/binfmt_loader.c     |  46 ----
 arch/alpha/kernel/osf_sys.c           |  30 ---
 arch/arm/configs/badge4_defconfig     |   1 -
 arch/arm/configs/corgi_defconfig      |   1 -
 arch/arm/configs/ezx_defconfig        |   1 -
 arch/arm/configs/footbridge_defconfig |   1 -
 arch/arm/configs/hackkit_defconfig    |   1 -
 arch/arm/configs/iop32x_defconfig     |   1 -
 arch/arm/configs/jornada720_defconfig |   1 -
 arch/arm/configs/lart_defconfig       |   1 -
 arch/arm/configs/neponset_defconfig   |   1 -
 arch/arm/configs/netwinder_defconfig  |   1 -
 arch/arm/configs/rpc_defconfig        |   1 -
 arch/arm/configs/spitz_defconfig      |   1 -
 fs/Kconfig.binfmt                     |  33 ---
 fs/Makefile                           |   1 -
 fs/binfmt_aout.c                      | 342 --------------------------
 fs/exec.c                             |   3 +-
 include/linux/a.out.h                 |  18 --
 22 files changed, 1 insertion(+), 505 deletions(-)
 delete mode 100644 arch/alpha/include/asm/a.out.h
 delete mode 100644 arch/alpha/kernel/binfmt_loader.c
 delete mode 100644 fs/binfmt_aout.c
 delete mode 100644 include/linux/a.out.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f5ca4aefd184..5458aa09f634 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7688,7 +7688,6 @@ R:	Kees Cook <keescook@chromium.org>
 L:	linux-mm@kvack.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/execve
-F:	arch/alpha/kernel/binfmt_loader.c
 F:	fs/*binfmt_*.c
 F:	fs/exec.c
 F:	include/linux/binfmts.h
diff --git a/arch/alpha/include/asm/a.out.h b/arch/alpha/include/asm/a.out.h
deleted file mode 100644
index d2346b7caff1..000000000000
--- a/arch/alpha/include/asm/a.out.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ALPHA_A_OUT_H__
-#define __ALPHA_A_OUT_H__
-
-#include <uapi/asm/a.out.h>
-
-
-/* Assume that start addresses below 4G belong to a TASO application.
-   Unfortunately, there is no proper bit in the exec header to check.
-   Worse, we have to notice the start address before swapping to use
-   /sbin/loader, which of course is _not_ a TASO application.  */
-#define SET_AOUT_PERSONALITY(BFPM, EX) \
-	set_personality (((BFPM->taso || EX.ah.entry < 0x100000000L \
-			   ? ADDR_LIMIT_32BIT : 0) | PER_OSF4))
-
-#endif /* __A_OUT_GNU_H__ */
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 5a74581bf0ee..6a274c0d53a2 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -47,10 +47,6 @@ else
 # Misc support
 obj-$(CONFIG_ALPHA_SRM)		+= srmcons.o
 
-ifdef CONFIG_BINFMT_AOUT
-obj-y	+= binfmt_loader.o
-endif
-
 # Core logic support
 obj-$(CONFIG_ALPHA_APECS)	+= core_apecs.o
 obj-$(CONFIG_ALPHA_CIA)		+= core_cia.o
diff --git a/arch/alpha/kernel/binfmt_loader.c b/arch/alpha/kernel/binfmt_loader.c
deleted file mode 100644
index e4be7a543ecf..000000000000
--- a/arch/alpha/kernel/binfmt_loader.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/mm_types.h>
-#include <linux/binfmts.h>
-#include <linux/a.out.h>
-
-static int load_binary(struct linux_binprm *bprm)
-{
-	struct exec *eh = (struct exec *)bprm->buf;
-	unsigned long loader;
-	struct file *file;
-	int retval;
-
-	if (eh->fh.f_magic != 0x183 || (eh->fh.f_flags & 0x3000) != 0x3000)
-		return -ENOEXEC;
-
-	if (bprm->loader)
-		return -ENOEXEC;
-
-	loader = bprm->vma->vm_end - sizeof(void *);
-
-	file = open_exec("/sbin/loader");
-	retval = PTR_ERR(file);
-	if (IS_ERR(file))
-		return retval;
-
-	/* Remember if the application is TASO.  */
-	bprm->taso = eh->ah.entry < 0x100000000UL;
-
-	bprm->interpreter = file;
-	bprm->loader = loader;
-	return 0;
-}
-
-static struct linux_binfmt loader_format = {
-	.load_binary	= load_binary,
-};
-
-static int __init init_loader_binfmt(void)
-{
-	insert_binfmt(&loader_format);
-	return 0;
-}
-arch_initcall(init_loader_binfmt);
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index d257293401e2..b3ad8c44c971 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1278,45 +1278,15 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	return addr;
 }
 
-#ifdef CONFIG_OSF4_COMPAT
-/* Clear top 32 bits of iov_len in the user's buffer for
-   compatibility with old versions of OSF/1 where iov_len
-   was defined as int. */
-static int
-osf_fix_iov_len(const struct iovec __user *iov, unsigned long count)
-{
-	unsigned long i;
-
-	for (i = 0 ; i < count ; i++) {
-		int __user *iov_len_high = (int __user *)&iov[i].iov_len + 1;
-
-		if (put_user(0, iov_len_high))
-			return -EFAULT;
-	}
-	return 0;
-}
-#endif
-
 SYSCALL_DEFINE3(osf_readv, unsigned long, fd,
 		const struct iovec __user *, vector, unsigned long, count)
 {
-#ifdef CONFIG_OSF4_COMPAT
-	if (unlikely(personality(current->personality) == PER_OSF4))
-		if (osf_fix_iov_len(vector, count))
-			return -EFAULT;
-#endif
-
 	return sys_readv(fd, vector, count);
 }
 
 SYSCALL_DEFINE3(osf_writev, unsigned long, fd,
 		const struct iovec __user *, vector, unsigned long, count)
 {
-#ifdef CONFIG_OSF4_COMPAT
-	if (unlikely(personality(current->personality) == PER_OSF4))
-		if (osf_fix_iov_len(vector, count))
-			return -EFAULT;
-#endif
 	return sys_writev(fd, vector, count);
 }
 
diff --git a/arch/arm/configs/badge4_defconfig b/arch/arm/configs/badge4_defconfig
index 506f3378da07..6908032fbce8 100644
--- a/arch/arm/configs/badge4_defconfig
+++ b/arch/arm/configs/badge4_defconfig
@@ -6,7 +6,6 @@ CONFIG_UNUSED_BOARD_FILES=y
 CONFIG_CMDLINE="init=/linuxrc root=/dev/mtdblock3"
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=m
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/arm/configs/corgi_defconfig b/arch/arm/configs/corgi_defconfig
index 1f137f74050f..df84640f4f57 100644
--- a/arch/arm/configs/corgi_defconfig
+++ b/arch/arm/configs/corgi_defconfig
@@ -16,7 +16,6 @@ CONFIG_MACH_HUSKY=y
 CONFIG_UNUSED_BOARD_FILES=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
diff --git a/arch/arm/configs/ezx_defconfig b/arch/arm/configs/ezx_defconfig
index 1a41391d7367..cd9ccc4e4627 100644
--- a/arch/arm/configs/ezx_defconfig
+++ b/arch/arm/configs/ezx_defconfig
@@ -25,7 +25,6 @@ CONFIG_CPU_FREQ_GOV_ONDEMAND=m
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
 CONFIG_CPU_IDLE=y
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=m
 CONFIG_PM=y
 CONFIG_APM_EMULATION=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 504070812ad0..b5b56f8dda5f 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -9,7 +9,6 @@ CONFIG_ARCH_EBSA285_HOST=y
 CONFIG_ARCH_NETWINDER=y
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_MODULES=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ACORN_PARTITION=y
diff --git a/arch/arm/configs/hackkit_defconfig b/arch/arm/configs/hackkit_defconfig
index b9327b2eacd3..398558c4ffa8 100644
--- a/arch/arm/configs/hackkit_defconfig
+++ b/arch/arm/configs/hackkit_defconfig
@@ -7,7 +7,6 @@ CONFIG_UNUSED_BOARD_FILES=y
 CONFIG_CMDLINE="console=ttySA0,115200 root=/dev/ram0 initrd=0xc0400000,8M init=/rootshell"
 CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arm/configs/iop32x_defconfig b/arch/arm/configs/iop32x_defconfig
index c16e92cdfd00..19e30e790d35 100644
--- a/arch/arm/configs/iop32x_defconfig
+++ b/arch/arm/configs/iop32x_defconfig
@@ -12,7 +12,6 @@ CONFIG_MACH_N2100=y
 CONFIG_UNUSED_BOARD_FILES=y
 CONFIG_CMDLINE="console=ttyS0,115200 root=/dev/nfs ip=bootp cachepolicy=writealloc"
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index 3dcf89d3e1f1..1a11ee6b3e24 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -6,7 +6,6 @@ CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
 CONFIG_UNUSED_BOARD_FILES=y
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/lart_defconfig b/arch/arm/configs/lart_defconfig
index 0c2f19d756c0..00583d64d2ea 100644
--- a/arch/arm/configs/lart_defconfig
+++ b/arch/arm/configs/lart_defconfig
@@ -8,7 +8,6 @@ CONFIG_CMDLINE="console=ttySA0,9600 root=/dev/ram"
 CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 907403529e30..2d16ddb0e7ff 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -9,7 +9,6 @@ CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
 CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index cf7bbcf9d98a..7a14ea1faa65 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_NETWINDER=y
 CONFIG_DEPRECATED_PARAM_STRUCT=y
 CONFIG_CMDLINE="root=0x801"
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 16d74a1f027a..b667c9d4527c 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -7,7 +7,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_RPC=y
 CONFIG_CPU_SA110=y
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_BSD_DISKLABEL=y
 CONFIG_SLAB=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 1284a1d92ca3..66d74653f3fb 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -13,7 +13,6 @@ CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_FPE_NWFPE=y
-CONFIG_BINFMT_AOUT=m
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 21e154516bf2..f14478643b91 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -142,39 +142,6 @@ config BINFMT_ZFLAT
 	help
 	  Support FLAT format compressed binaries
 
-config HAVE_AOUT
-       def_bool n
-
-config BINFMT_AOUT
-	tristate "Kernel support for a.out and ECOFF binaries"
-	depends on HAVE_AOUT
-	help
-	  A.out (Assembler.OUTput) is a set of formats for libraries and
-	  executables used in the earliest versions of UNIX.  Linux used
-	  the a.out formats QMAGIC and ZMAGIC until they were replaced
-	  with the ELF format.
-
-	  The conversion to ELF started in 1995.  This option is primarily
-	  provided for historical interest and for the benefit of those
-	  who need to run binaries from that era.
-
-	  Most people should answer N here.  If you think you may have
-	  occasional use for this format, enable module support above
-	  and answer M here to compile this support as a module called
-	  binfmt_aout.
-
-	  If any crucial components of your system (such as /sbin/init
-	  or /lib/ld.so) are still in a.out format, you will have to
-	  say Y here.
-
-config OSF4_COMPAT
-	bool "OSF/1 v4 readv/writev compatibility"
-	depends on ALPHA && BINFMT_AOUT
-	help
-	  Say Y if you are using OSF/1 binaries (like Netscape and Acrobat)
-	  with v4 shared libraries freely available from Compaq. If you're
-	  going to use shared libraries from Tru64 version 5.0 or later, say N.
-
 config BINFMT_MISC
 	tristate "Kernel support for MISC binaries"
 	help
diff --git a/fs/Makefile b/fs/Makefile
index 93b80529f8e8..4dea17840761 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -38,7 +38,6 @@ obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
-obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
 obj-$(CONFIG_BINFMT_SCRIPT)	+= binfmt_script.o
 obj-$(CONFIG_BINFMT_ELF)	+= binfmt_elf.o
diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
deleted file mode 100644
index 0dcfc691e7e2..000000000000
--- a/fs/binfmt_aout.c
+++ /dev/null
@@ -1,342 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  linux/fs/binfmt_aout.c
- *
- *  Copyright (C) 1991, 1992, 1996  Linus Torvalds
- */
-
-#include <linux/module.h>
-
-#include <linux/time.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/mman.h>
-#include <linux/a.out.h>
-#include <linux/errno.h>
-#include <linux/signal.h>
-#include <linux/string.h>
-#include <linux/fs.h>
-#include <linux/file.h>
-#include <linux/stat.h>
-#include <linux/fcntl.h>
-#include <linux/ptrace.h>
-#include <linux/user.h>
-#include <linux/binfmts.h>
-#include <linux/personality.h>
-#include <linux/init.h>
-#include <linux/coredump.h>
-#include <linux/slab.h>
-#include <linux/sched/task_stack.h>
-
-#include <linux/uaccess.h>
-#include <asm/cacheflush.h>
-
-static int load_aout_binary(struct linux_binprm *);
-static int load_aout_library(struct file*);
-
-static struct linux_binfmt aout_format = {
-	.module		= THIS_MODULE,
-	.load_binary	= load_aout_binary,
-	.load_shlib	= load_aout_library,
-};
-
-#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
-
-static int set_brk(unsigned long start, unsigned long end)
-{
-	start = PAGE_ALIGN(start);
-	end = PAGE_ALIGN(end);
-	if (end > start)
-		return vm_brk(start, end - start);
-	return 0;
-}
-
-/*
- * create_aout_tables() parses the env- and arg-strings in new user
- * memory and creates the pointer tables from them, and puts their
- * addresses on the "stack", returning the new stack pointer value.
- */
-static unsigned long __user *create_aout_tables(char __user *p, struct linux_binprm * bprm)
-{
-	char __user * __user *argv;
-	char __user * __user *envp;
-	unsigned long __user *sp;
-	int argc = bprm->argc;
-	int envc = bprm->envc;
-
-	sp = (void __user *)((-(unsigned long)sizeof(char *)) & (unsigned long) p);
-#ifdef __alpha__
-/* whee.. test-programs are so much fun. */
-	put_user(0, --sp);
-	put_user(0, --sp);
-	if (bprm->loader) {
-		put_user(0, --sp);
-		put_user(1003, --sp);
-		put_user(bprm->loader, --sp);
-		put_user(1002, --sp);
-	}
-	put_user(bprm->exec, --sp);
-	put_user(1001, --sp);
-#endif
-	sp -= envc+1;
-	envp = (char __user * __user *) sp;
-	sp -= argc+1;
-	argv = (char __user * __user *) sp;
-#ifndef __alpha__
-	put_user((unsigned long) envp,--sp);
-	put_user((unsigned long) argv,--sp);
-#endif
-	put_user(argc,--sp);
-	current->mm->arg_start = (unsigned long) p;
-	while (argc-->0) {
-		char c;
-		put_user(p,argv++);
-		do {
-			get_user(c,p++);
-		} while (c);
-	}
-	put_user(NULL,argv);
-	current->mm->arg_end = current->mm->env_start = (unsigned long) p;
-	while (envc-->0) {
-		char c;
-		put_user(p,envp++);
-		do {
-			get_user(c,p++);
-		} while (c);
-	}
-	put_user(NULL,envp);
-	current->mm->env_end = (unsigned long) p;
-	return sp;
-}
-
-/*
- * These are the functions used to load a.out style executables and shared
- * libraries.  There is no binary dependent code anywhere else.
- */
-
-static int load_aout_binary(struct linux_binprm * bprm)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct exec ex;
-	unsigned long error;
-	unsigned long fd_offset;
-	unsigned long rlim;
-	int retval;
-
-	ex = *((struct exec *) bprm->buf);		/* exec-header */
-	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != OMAGIC &&
-	     N_MAGIC(ex) != QMAGIC && N_MAGIC(ex) != NMAGIC) ||
-	    N_TRSIZE(ex) || N_DRSIZE(ex) ||
-	    i_size_read(file_inode(bprm->file)) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
-		return -ENOEXEC;
-	}
-
-	/*
-	 * Requires a mmap handler. This prevents people from using a.out
-	 * as part of an exploit attack against /proc-related vulnerabilities.
-	 */
-	if (!bprm->file->f_op->mmap)
-		return -ENOEXEC;
-
-	fd_offset = N_TXTOFF(ex);
-
-	/* Check initial limits. This avoids letting people circumvent
-	 * size limits imposed on them by creating programs with large
-	 * arrays in the data or bss.
-	 */
-	rlim = rlimit(RLIMIT_DATA);
-	if (rlim >= RLIM_INFINITY)
-		rlim = ~0;
-	if (ex.a_data + ex.a_bss > rlim)
-		return -ENOMEM;
-
-	/* Flush all traces of the currently running executable */
-	retval = begin_new_exec(bprm);
-	if (retval)
-		return retval;
-
-	/* OK, This is the point of no return */
-#ifdef __alpha__
-	SET_AOUT_PERSONALITY(bprm, ex);
-#else
-	set_personality(PER_LINUX);
-#endif
-	setup_new_exec(bprm);
-
-	current->mm->end_code = ex.a_text +
-		(current->mm->start_code = N_TXTADDR(ex));
-	current->mm->end_data = ex.a_data +
-		(current->mm->start_data = N_DATADDR(ex));
-	current->mm->brk = ex.a_bss +
-		(current->mm->start_brk = N_BSSADDR(ex));
-
-	retval = setup_arg_pages(bprm, STACK_TOP, EXSTACK_DEFAULT);
-	if (retval < 0)
-		return retval;
-
-
-	if (N_MAGIC(ex) == OMAGIC) {
-		unsigned long text_addr, map_size;
-		loff_t pos;
-
-		text_addr = N_TXTADDR(ex);
-
-#ifdef __alpha__
-		pos = fd_offset;
-		map_size = ex.a_text+ex.a_data + PAGE_SIZE - 1;
-#else
-		pos = 32;
-		map_size = ex.a_text+ex.a_data;
-#endif
-		error = vm_brk(text_addr & PAGE_MASK, map_size);
-		if (error)
-			return error;
-
-		error = read_code(bprm->file, text_addr, pos,
-				  ex.a_text+ex.a_data);
-		if ((signed long)error < 0)
-			return error;
-	} else {
-		if ((ex.a_text & 0xfff || ex.a_data & 0xfff) &&
-		    (N_MAGIC(ex) != NMAGIC) && printk_ratelimit())
-		{
-			printk(KERN_NOTICE "executable not page aligned\n");
-		}
-
-		if ((fd_offset & ~PAGE_MASK) != 0 && printk_ratelimit())
-		{
-			printk(KERN_WARNING 
-			       "fd_offset is not page aligned. Please convert program: %pD\n",
-			       bprm->file);
-		}
-
-		if (!bprm->file->f_op->mmap||((fd_offset & ~PAGE_MASK) != 0)) {
-			error = vm_brk(N_TXTADDR(ex), ex.a_text+ex.a_data);
-			if (error)
-				return error;
-
-			read_code(bprm->file, N_TXTADDR(ex), fd_offset,
-				  ex.a_text + ex.a_data);
-			goto beyond_if;
-		}
-
-		error = vm_mmap(bprm->file, N_TXTADDR(ex), ex.a_text,
-			PROT_READ | PROT_EXEC, MAP_FIXED | MAP_PRIVATE,
-			fd_offset);
-
-		if (error != N_TXTADDR(ex))
-			return error;
-
-		error = vm_mmap(bprm->file, N_DATADDR(ex), ex.a_data,
-				PROT_READ | PROT_WRITE | PROT_EXEC,
-				MAP_FIXED | MAP_PRIVATE,
-				fd_offset + ex.a_text);
-		if (error != N_DATADDR(ex))
-			return error;
-	}
-beyond_if:
-	set_binfmt(&aout_format);
-
-	retval = set_brk(current->mm->start_brk, current->mm->brk);
-	if (retval < 0)
-		return retval;
-
-	current->mm->start_stack =
-		(unsigned long) create_aout_tables((char __user *) bprm->p, bprm);
-#ifdef __alpha__
-	regs->gp = ex.a_gpvalue;
-#endif
-	finalize_exec(bprm);
-	start_thread(regs, ex.a_entry, current->mm->start_stack);
-	return 0;
-}
-
-static int load_aout_library(struct file *file)
-{
-	struct inode * inode;
-	unsigned long bss, start_addr, len;
-	unsigned long error;
-	int retval;
-	struct exec ex;
-	loff_t pos = 0;
-
-	inode = file_inode(file);
-
-	retval = -ENOEXEC;
-	error = kernel_read(file, &ex, sizeof(ex), &pos);
-	if (error != sizeof(ex))
-		goto out;
-
-	/* We come in here for the regular a.out style of shared libraries */
-	if ((N_MAGIC(ex) != ZMAGIC && N_MAGIC(ex) != QMAGIC) || N_TRSIZE(ex) ||
-	    N_DRSIZE(ex) || ((ex.a_entry & 0xfff) && N_MAGIC(ex) == ZMAGIC) ||
-	    i_size_read(inode) < ex.a_text+ex.a_data+N_SYMSIZE(ex)+N_TXTOFF(ex)) {
-		goto out;
-	}
-
-	/*
-	 * Requires a mmap handler. This prevents people from using a.out
-	 * as part of an exploit attack against /proc-related vulnerabilities.
-	 */
-	if (!file->f_op->mmap)
-		goto out;
-
-	if (N_FLAGS(ex))
-		goto out;
-
-	/* For  QMAGIC, the starting address is 0x20 into the page.  We mask
-	   this off to get the starting address for the page */
-
-	start_addr =  ex.a_entry & 0xfffff000;
-
-	if ((N_TXTOFF(ex) & ~PAGE_MASK) != 0) {
-		if (printk_ratelimit())
-		{
-			printk(KERN_WARNING 
-			       "N_TXTOFF is not page aligned. Please convert library: %pD\n",
-			       file);
-		}
-		retval = vm_brk(start_addr, ex.a_text + ex.a_data + ex.a_bss);
-		if (retval)
-			goto out;
-
-		read_code(file, start_addr, N_TXTOFF(ex),
-			  ex.a_text + ex.a_data);
-		retval = 0;
-		goto out;
-	}
-	/* Now use mmap to map the library into memory. */
-	error = vm_mmap(file, start_addr, ex.a_text + ex.a_data,
-			PROT_READ | PROT_WRITE | PROT_EXEC,
-			MAP_FIXED | MAP_PRIVATE,
-			N_TXTOFF(ex));
-	retval = error;
-	if (error != start_addr)
-		goto out;
-
-	len = PAGE_ALIGN(ex.a_text + ex.a_data);
-	bss = ex.a_text + ex.a_data + ex.a_bss;
-	if (bss > len) {
-		retval = vm_brk(start_addr + len, bss - len);
-		if (retval)
-			goto out;
-	}
-	retval = 0;
-out:
-	return retval;
-}
-
-static int __init init_aout_binfmt(void)
-{
-	register_binfmt(&aout_format);
-	return 0;
-}
-
-static void __exit exit_aout_binfmt(void)
-{
-	unregister_binfmt(&aout_format);
-}
-
-core_initcall(init_aout_binfmt);
-module_exit(exit_aout_binfmt);
-MODULE_LICENSE("GPL");
diff --git a/fs/exec.c b/fs/exec.c
index d046dbb9cbd0..69a572fc57db 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -957,8 +957,7 @@ struct file *open_exec(const char *name)
 }
 EXPORT_SYMBOL(open_exec);
 
-#if defined(CONFIG_HAVE_AOUT) || defined(CONFIG_BINFMT_FLAT) || \
-    defined(CONFIG_BINFMT_ELF_FDPIC)
+#if defined(CONFIG_BINFMT_FLAT) || defined(CONFIG_BINFMT_ELF_FDPIC)
 ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
 {
 	ssize_t res = vfs_read(file, (void __user *)addr, len, &pos);
diff --git a/include/linux/a.out.h b/include/linux/a.out.h
deleted file mode 100644
index 600cf45645c6..000000000000
--- a/include/linux/a.out.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __A_OUT_GNU_H__
-#define __A_OUT_GNU_H__
-
-#include <uapi/linux/a.out.h>
-
-#ifndef __ASSEMBLY__
-#ifdef linux
-#include <asm/page.h>
-#if defined(__i386__) || defined(__mc68000__)
-#else
-#ifndef SEGMENT_SIZE
-#define SEGMENT_SIZE	PAGE_SIZE
-#endif
-#endif
-#endif
-#endif /*__ASSEMBLY__ */
-#endif /* __A_OUT_GNU_H__ */
-- 
2.35.3

