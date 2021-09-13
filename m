Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2638409DBD
	for <lists+linux-arch@lfdr.de>; Mon, 13 Sep 2021 22:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347922AbhIMUF6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Sep 2021 16:05:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:19216 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347824AbhIMUFv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Sep 2021 16:05:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="221830804"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="221830804"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 13:04:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="469643940"
Received: from sohilbuildbox.sc.intel.com (HELO localhost.localdomain) ([172.25.110.4])
  by fmsmga007.fm.intel.com with ESMTP; 13 Sep 2021 13:04:33 -0700
From:   Sohil Mehta <sohil.mehta@intel.com>
To:     x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 12/13] x86/uintr: Wire up the user interrupt syscalls
Date:   Mon, 13 Sep 2021 13:01:31 -0700
Message-Id: <20210913200132.3396598-13-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913200132.3396598-1-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Wire up the user interrupt receiver and sender related syscalls for
x86_64.

For rest of the architectures the syscalls are not implemented.

<TODO: Reserve the syscall numbers for other architectures>

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |  6 ++++++
 arch/x86/entry/syscalls/syscall_64.tbl |  6 ++++++
 include/linux/syscalls.h               |  8 ++++++++
 include/uapi/asm-generic/unistd.h      | 15 ++++++++++++++-
 kernel/sys_ni.c                        |  8 ++++++++
 scripts/checksyscalls.sh               |  6 ++++++
 6 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 960a021d543e..d0e97f1f1173 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -453,3 +453,9 @@
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
 448	i386	process_mrelease	sys_process_mrelease
+449	i386	uintr_register_handler	sys_uintr_register_handler
+450	i386	uintr_unregister_handler sys_uintr_unregister_handler
+451	i386	uintr_create_fd		sys_uintr_create_fd
+452	i386	uintr_register_sender	sys_uintr_register_sender
+453	i386	uintr_unregister_sender	sys_uintr_unregister_sender
+454	i386	uintr_wait		sys_uintr_wait
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 18b5500ea8bf..444af44e5947 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -370,6 +370,12 @@
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
 448	common	process_mrelease	sys_process_mrelease
+449	common	uintr_register_handler	sys_uintr_register_handler
+450	common	uintr_unregister_handler sys_uintr_unregister_handler
+451	common	uintr_create_fd		sys_uintr_create_fd
+452	common	uintr_register_sender	sys_uintr_register_sender
+453	common	uintr_unregister_sender	sys_uintr_unregister_sender
+454	common	uintr_wait		sys_uintr_wait
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 252243c7783d..f47f64c36d87 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1060,6 +1060,14 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 /* arch/x86/kernel/ioport.c */
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 
+/* arch/x86/kernel/uintr_fd.c */
+asmlinkage long sys_uintr_register_handler(u64 __user *handler, unsigned int flags);
+asmlinkage long sys_uintr_unregister_handler(unsigned int flags);
+asmlinkage long sys_uintr_create_fd(u64 vector, unsigned int flags);
+asmlinkage long sys_uintr_register_sender(int uintr_fd, unsigned int flags);
+asmlinkage long sys_uintr_unregister_sender(int uintr_fd, unsigned int flags);
+asmlinkage long sys_uintr_wait(unsigned int flags);
+
 /* pciconfig: alpha, arm, arm64, ia64, sparc */
 asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
 				unsigned long off, unsigned long len,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c5fb86d455a..b9a8b344270a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -880,8 +880,21 @@ __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #define __NR_process_mrelease 448
 __SYSCALL(__NR_process_mrelease, sys_process_mrelease)
 
+#define __NR_uintr_register_handler 449
+__SYSCALL(__NR_uintr_register_handler, sys_uintr_register_handler)
+#define __NR_uintr_unregister_handler 450
+__SYSCALL(__NR_uintr_unregister_handler, sys_uintr_unregister_handler)
+#define __NR_uintr_create_fd 451
+__SYSCALL(__NR_uintr_create_fd, sys_uintr_create_fd)
+#define __NR_uintr_register_sender 452
+__SYSCALL(__NR_uintr_register_sender, sys_uintr_register_sender)
+#define __NR_uintr_unregister_sender 453
+__SYSCALL(__NR_uintr_unregister_sender, sys_uintr_unregister_sender)
+#define __NR_uintr_wait 454
+__SYSCALL(__NR_uintr_wait, sys_uintr_wait)
+
 #undef __NR_syscalls
-#define __NR_syscalls 449
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f43d89d92860..5d8b92ac197b 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -357,6 +357,14 @@ COND_SYSCALL(pkey_free);
 /* memfd_secret */
 COND_SYSCALL(memfd_secret);
 
+/* user interrupts */
+COND_SYSCALL(uintr_register_handler);
+COND_SYSCALL(uintr_unregister_handler);
+COND_SYSCALL(uintr_create_fd);
+COND_SYSCALL(uintr_register_sender);
+COND_SYSCALL(uintr_unregister_sender);
+COND_SYSCALL(uintr_wait);
+
 /*
  * Architecture specific weak syscall entries.
  */
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index fd9777f63f14..0969580d829c 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -204,6 +204,12 @@ cat << EOF
 #define __IGNORE__sysctl
 #define __IGNORE_arch_prctl
 #define __IGNORE_nfsservctl
+#define __IGNORE_uintr_register_handler
+#define __IGNORE_uintr_unregister_handler
+#define __IGNORE_uintr_create_fd
+#define __IGNORE_uintr_register_sender
+#define __IGNORE_uintr_unregister_sender
+#define __IGNORE_uintr_wait
 
 /* ... including the "new" 32-bit uid syscalls */
 #define __IGNORE_lchown32
-- 
2.33.0

