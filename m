Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4106E140A12
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgAQMuw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 07:50:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726885AbgAQMuw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 07:50:52 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HClj1s113437
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qtupwy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:49 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Fri, 17 Jan 2020 12:50:47 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 12:50:42 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00HCnpg940894856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 12:49:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6981A5205A;
        Fri, 17 Jan 2020 12:50:40 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0DB4F52059;
        Fri, 17 Jan 2020 12:50:37 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v16 13/23] selftests/vm/pkeys: Introduce powerpc support
Date:   Fri, 17 Jan 2020 18:19:52 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20011712-4275-0000-0000-000003987CDF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011712-4276-0000-0000-000038AC7E41
Message-Id: <800daa04fdd635c839fabdfd9788605fdc2cc011.1579265066.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_03:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=2 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170102
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

This makes use of the abstractions added earlier and
introduces support for powerpc.

For powerpc, after receiving the SIGSEGV, the signal
handler must explicitly restore access permissions
for the faulting pkey to allow the test to continue.
As this makes use of pkey_access_allow(), all of its
dependencies and other similar functions have been
moved ahead of the signal handler.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |   2 +
 tools/testing/selftests/vm/pkey-powerpc.h    |  90 +++++++
 tools/testing/selftests/vm/protection_keys.c | 269 ++++++++++---------
 3 files changed, 233 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-powerpc.h

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 98617a011aa4..ec3f87d53b7d 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -79,6 +79,8 @@ void expected_pkey_fault(int pkey);
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 #include "pkey-x86.h"
+#elif defined(__powerpc64__) /* arch */
+#include "pkey-powerpc.h"
 #else /* arch */
 #error Architecture not supported
 #endif /* arch */
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
new file mode 100644
index 000000000000..f4599a35d2a9
--- /dev/null
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _PKEYS_POWERPC_H
+#define _PKEYS_POWERPC_H
+
+#ifndef SYS_mprotect_key
+# define SYS_mprotect_key	386
+#endif
+#ifndef SYS_pkey_alloc
+# define SYS_pkey_alloc		384
+# define SYS_pkey_free		385
+#endif
+#define REG_IP_IDX		PT_NIP
+#define REG_TRAPNO		PT_TRAP
+#define gregs			gp_regs
+#define fpregs			fp_regs
+#define si_pkey_offset		0x20
+
+#ifndef PKEY_DISABLE_ACCESS
+# define PKEY_DISABLE_ACCESS	0x3  /* disable read and write */
+#endif
+
+#ifndef PKEY_DISABLE_WRITE
+# define PKEY_DISABLE_WRITE	0x2
+#endif
+
+#define NR_PKEYS		32
+#define NR_RESERVED_PKEYS_4K	27 /* pkey-0, pkey-1, exec-only-pkey
+				      and 24 other keys that cannot be
+				      represented in the PTE */
+#define NR_RESERVED_PKEYS_64K	3  /* pkey-0, pkey-1 and exec-only-pkey */
+#define PKEY_BITS_PER_PKEY	2
+#define HPAGE_SIZE		(1UL << 24)
+#define PAGE_SIZE		(1UL << 16)
+
+static inline u32 pkey_bit_position(int pkey)
+{
+	return (NR_PKEYS - pkey - 1) * PKEY_BITS_PER_PKEY;
+}
+
+static inline u64 __read_pkey_reg(void)
+{
+	u64 pkey_reg;
+
+	asm volatile("mfspr %0, 0xd" : "=r" (pkey_reg));
+
+	return pkey_reg;
+}
+
+static inline void __write_pkey_reg(u64 pkey_reg)
+{
+	u64 amr = pkey_reg;
+
+	dprintf4("%s() changing %016lx to %016lx\n",
+			 __func__, __read_pkey_reg(), pkey_reg);
+
+	asm volatile("mtspr 0xd, %0" : : "r" ((unsigned long)(amr)) : "memory");
+
+	dprintf4("%s() pkey register after changing %016lx to %016lx\n",
+			__func__, __read_pkey_reg(), pkey_reg);
+}
+
+static inline int cpu_has_pku(void)
+{
+	return 1;
+}
+
+static inline int get_arch_reserved_keys(void)
+{
+	if (sysconf(_SC_PAGESIZE) == 4096)
+		return NR_RESERVED_PKEYS_4K;
+	else
+		return NR_RESERVED_PKEYS_64K;
+}
+
+void expect_fault_on_read_execonly_key(void *p1, int pkey)
+{
+	/*
+	 * powerpc does not allow userspace to change permissions of exec-only
+	 * keys since those keys are not allocated by userspace. The signal
+	 * handler wont be able to reset the permissions, which means the code
+	 * will infinitely continue to segfault here.
+	 */
+	return;
+}
+
+/* 4-byte instructions * 16384 = 64K page */
+#define __page_o_noops() asm(".rept 16384 ; nop; .endr")
+
+#endif /* _PKEYS_POWERPC_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 3b3abe4cbccd..90bb3a8cd78b 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -168,6 +168,125 @@ void dump_mem(void *dumpme, int len_bytes)
 	}
 }
 
+static u32 hw_pkey_get(int pkey, unsigned long flags)
+{
+	u64 pkey_reg = __read_pkey_reg();
+
+	dprintf1("%s(pkey=%d, flags=%lx) = %x / %d\n",
+			__func__, pkey, flags, 0, 0);
+	dprintf2("%s() raw pkey_reg: %016lx\n", __func__, pkey_reg);
+
+	return (u32) get_pkey_bits(pkey_reg, pkey);
+}
+
+static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
+{
+	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
+	u64 old_pkey_reg = __read_pkey_reg();
+	u64 new_pkey_reg;
+
+	/* make sure that 'rights' only contains the bits we expect: */
+	assert(!(rights & ~mask));
+
+	/* modify bits accordingly in old pkey_reg and assign it */
+	new_pkey_reg = set_pkey_bits(old_pkey_reg, pkey, rights);
+
+	__write_pkey_reg(new_pkey_reg);
+
+	dprintf3("%s(pkey=%d, rights=%lx, flags=%lx) = %x"
+		" pkey_reg now: %016lx old_pkey_reg: %016lx\n",
+		__func__, pkey, rights, flags, 0, __read_pkey_reg(),
+		old_pkey_reg);
+	return 0;
+}
+
+void pkey_disable_set(int pkey, int flags)
+{
+	unsigned long syscall_flags = 0;
+	int ret;
+	int pkey_rights;
+	u64 orig_pkey_reg = read_pkey_reg();
+
+	dprintf1("START->%s(%d, 0x%x)\n", __func__,
+		pkey, flags);
+	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+
+	pkey_rights = hw_pkey_get(pkey, syscall_flags);
+
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
+			pkey, pkey, pkey_rights);
+
+	pkey_assert(pkey_rights >= 0);
+
+	pkey_rights |= flags;
+
+	ret = hw_pkey_set(pkey, pkey_rights, syscall_flags);
+	assert(!ret);
+	/* pkey_reg and flags have the same format */
+	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
+	dprintf1("%s(%d) shadow: 0x%016lx\n",
+		__func__, pkey, shadow_pkey_reg);
+
+	pkey_assert(ret >= 0);
+
+	pkey_rights = hw_pkey_get(pkey, syscall_flags);
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
+			pkey, pkey, pkey_rights);
+
+	dprintf1("%s(%d) pkey_reg: 0x%016lx\n",
+		__func__, pkey, read_pkey_reg());
+	if (flags)
+		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
+	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
+		pkey, flags);
+}
+
+void pkey_disable_clear(int pkey, int flags)
+{
+	unsigned long syscall_flags = 0;
+	int ret;
+	int pkey_rights = hw_pkey_get(pkey, syscall_flags);
+	u64 orig_pkey_reg = read_pkey_reg();
+
+	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
+			pkey, pkey, pkey_rights);
+	pkey_assert(pkey_rights >= 0);
+
+	pkey_rights &= ~flags;
+
+	ret = hw_pkey_set(pkey, pkey_rights, 0);
+	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
+	pkey_assert(ret >= 0);
+
+	pkey_rights = hw_pkey_get(pkey, syscall_flags);
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
+			pkey, pkey, pkey_rights);
+
+	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
+			pkey, read_pkey_reg());
+	if (flags)
+		assert(read_pkey_reg() <= orig_pkey_reg);
+}
+
+void pkey_write_allow(int pkey)
+{
+	pkey_disable_clear(pkey, PKEY_DISABLE_WRITE);
+}
+void pkey_write_deny(int pkey)
+{
+	pkey_disable_set(pkey, PKEY_DISABLE_WRITE);
+}
+void pkey_access_allow(int pkey)
+{
+	pkey_disable_clear(pkey, PKEY_DISABLE_ACCESS);
+}
+void pkey_access_deny(int pkey)
+{
+	pkey_disable_set(pkey, PKEY_DISABLE_ACCESS);
+}
+
 /* Failed address bound checks: */
 #ifndef SEGV_BNDERR
 # define SEGV_BNDERR		3
@@ -198,11 +317,12 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	int trapno;
 	unsigned long ip;
 	char *fpregs;
+#if defined(__i386__) || defined(__x86_64__) /* arch */
 	u32 *pkey_reg_ptr;
+	int pkey_reg_offset;
+#endif /* arch */
 	u64 siginfo_pkey;
 	u32 *si_pkey_ptr;
-	int pkey_reg_offset;
-	fpregset_t fpregset;
 
 	dprint_in_signal = 1;
 	dprintf1(">>>>===============SIGSEGV============================\n");
@@ -212,12 +332,13 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 
 	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
 	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
-	fpregset = uctxt->uc_mcontext.fpregs;
-	fpregs = (void *)fpregset;
+	fpregs = (char *) uctxt->uc_mcontext.fpregs;
 
 	dprintf2("%s() trapno: %d ip: 0x%016lx info->si_code: %s/%d\n",
 			__func__, trapno, ip, si_code_str(si->si_code),
 			si->si_code);
+
+#if defined(__i386__) || defined(__x86_64__) /* arch */
 #ifdef __i386__
 	/*
 	 * 32-bit has some extra padding so that userspace can tell whether
@@ -225,12 +346,10 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	 * state.  We just assume that it is here.
 	 */
 	fpregs += 0x70;
-#endif
+#endif /* i386 */
 	pkey_reg_offset = pkey_reg_xstate_offset();
 	pkey_reg_ptr = (void *)(&fpregs[pkey_reg_offset]);
 
-	dprintf1("siginfo: %p\n", si);
-	dprintf1(" fpregs: %p\n", fpregs);
 	/*
 	 * If we got a PKEY fault, we *HAVE* to have at least one bit set in
 	 * here.
@@ -239,6 +358,10 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	if (DEBUG_LEVEL > 4)
 		dump_mem(pkey_reg_ptr - 128, 256);
 	pkey_assert(*pkey_reg_ptr);
+#endif /* arch */
+
+	dprintf1("siginfo: %p\n", si);
+	dprintf1(" fpregs: %p\n", fpregs);
 
 	if ((si->si_code == SEGV_MAPERR) ||
 	    (si->si_code == SEGV_ACCERR) ||
@@ -247,14 +370,13 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 		exit(4);
 	}
 
-	si_pkey_ptr = (u32 *)(((u8 *)si) + si_pkey_offset);
+	si_pkey_ptr = siginfo_get_pkey_ptr(si);
 	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
 	dump_mem((u8 *)si_pkey_ptr - 8, 24);
 	siginfo_pkey = *si_pkey_ptr;
 	pkey_assert(siginfo_pkey < NR_PKEYS);
 	last_si_pkey = siginfo_pkey;
 
-	dprintf1("signal pkey_reg from xsave: %08x\n", *pkey_reg_ptr);
 	/*
 	 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
 	 * checking
@@ -262,8 +384,14 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	dprintf1("signal pkey_reg from  pkey_reg: %016lx\n",
 			__read_pkey_reg());
 	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
+#if defined(__i386__) || defined(__x86_64__) /* arch */
+	dprintf1("signal pkey_reg from xsave: %08x\n", *pkey_reg_ptr);
 	*(u64 *)pkey_reg_ptr = 0x00000000;
 	dprintf1("WARNING: set PKEY_REG=0 to allow faulting instruction to continue\n");
+#elif defined(__powerpc64__) /* arch */
+	/* restore access and let the faulting instruction continue */
+	pkey_access_allow(siginfo_pkey);
+#endif /* arch */
 	pkey_faults++;
 	dprintf1("<<<<==================================================\n");
 	dprint_in_signal = 0;
@@ -332,125 +460,6 @@ pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-static u32 hw_pkey_get(int pkey, unsigned long flags)
-{
-	u64 pkey_reg = __read_pkey_reg();
-
-	dprintf1("%s(pkey=%d, flags=%lx) = %x / %d\n",
-			__func__, pkey, flags, 0, 0);
-	dprintf2("%s() raw pkey_reg: %016lx\n", __func__, pkey_reg);
-
-	return (u32) get_pkey_bits(pkey_reg, pkey);
-}
-
-static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
-{
-	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
-	u64 old_pkey_reg = __read_pkey_reg();
-	u64 new_pkey_reg;
-
-	/* make sure that 'rights' only contains the bits we expect: */
-	assert(!(rights & ~mask));
-
-	/* modify bits accordingly in old pkey_reg and assign it */
-	new_pkey_reg = set_pkey_bits(old_pkey_reg, pkey, rights);
-
-	__write_pkey_reg(new_pkey_reg);
-
-	dprintf3("%s(pkey=%d, rights=%lx, flags=%lx) = %x"
-		" pkey_reg now: %016lx old_pkey_reg: %016lx\n",
-		__func__, pkey, rights, flags, 0, __read_pkey_reg(),
-		old_pkey_reg);
-	return 0;
-}
-
-void pkey_disable_set(int pkey, int flags)
-{
-	unsigned long syscall_flags = 0;
-	int ret;
-	int pkey_rights;
-	u64 orig_pkey_reg = read_pkey_reg();
-
-	dprintf1("START->%s(%d, 0x%x)\n", __func__,
-		pkey, flags);
-	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
-
-	pkey_rights = hw_pkey_get(pkey, syscall_flags);
-
-	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
-			pkey, pkey, pkey_rights);
-
-	pkey_assert(pkey_rights >= 0);
-
-	pkey_rights |= flags;
-
-	ret = hw_pkey_set(pkey, pkey_rights, syscall_flags);
-	assert(!ret);
-	/* pkey_reg and flags have the same format */
-	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
-	dprintf1("%s(%d) shadow: 0x%016lx\n",
-		__func__, pkey, shadow_pkey_reg);
-
-	pkey_assert(ret >= 0);
-
-	pkey_rights = hw_pkey_get(pkey, syscall_flags);
-	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
-			pkey, pkey, pkey_rights);
-
-	dprintf1("%s(%d) pkey_reg: 0x%016lx\n",
-		__func__, pkey, read_pkey_reg());
-	if (flags)
-		pkey_assert(read_pkey_reg() >= orig_pkey_reg);
-	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
-		pkey, flags);
-}
-
-void pkey_disable_clear(int pkey, int flags)
-{
-	unsigned long syscall_flags = 0;
-	int ret;
-	int pkey_rights = hw_pkey_get(pkey, syscall_flags);
-	u64 orig_pkey_reg = read_pkey_reg();
-
-	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
-
-	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
-			pkey, pkey, pkey_rights);
-	pkey_assert(pkey_rights >= 0);
-
-	pkey_rights &= ~flags;
-
-	ret = hw_pkey_set(pkey, pkey_rights, 0);
-	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
-	pkey_assert(ret >= 0);
-
-	pkey_rights = hw_pkey_get(pkey, syscall_flags);
-	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
-			pkey, pkey, pkey_rights);
-
-	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
-			pkey, read_pkey_reg());
-	if (flags)
-		assert(read_pkey_reg() <= orig_pkey_reg);
-}
-
-void pkey_write_allow(int pkey)
-{
-	pkey_disable_clear(pkey, PKEY_DISABLE_WRITE);
-}
-void pkey_write_deny(int pkey)
-{
-	pkey_disable_set(pkey, PKEY_DISABLE_WRITE);
-}
-void pkey_access_allow(int pkey)
-{
-	pkey_disable_clear(pkey, PKEY_DISABLE_ACCESS);
-}
-void pkey_access_deny(int pkey)
-{
-	pkey_disable_set(pkey, PKEY_DISABLE_ACCESS);
-}
-
 int sys_mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 		unsigned long pkey)
 {
@@ -889,11 +898,15 @@ void expected_pkey_fault(int pkey)
 	if (pkey != UNKNOWN_PKEY)
 		pkey_assert(last_si_pkey == pkey);
 
+#if defined(__i386__) || defined(__x86_64__) /* arch */
 	/*
 	 * The signal handler shold have cleared out PKEY register to let the
 	 * test program continue.  We now have to restore it.
 	 */
 	if (__read_pkey_reg() != 0)
+#else /* arch */
+	if (__read_pkey_reg() != shadow_pkey_reg)
+#endif /* arch */
 		pkey_assert(0);
 
 	__write_pkey_reg(shadow_pkey_reg);
-- 
2.17.1

