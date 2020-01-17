Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B3140A04
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 13:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgAQMuc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 07:50:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgAQMuc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 07:50:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HCm0bo078166
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:30 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qrc6v0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:30 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Fri, 17 Jan 2020 12:50:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 12:50:23 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00HCoLZY56229970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 12:50:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD1F752054;
        Fri, 17 Jan 2020 12:50:21 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 571125204E;
        Fri, 17 Jan 2020 12:50:19 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v16 06/23] selftests/vm: Typecast references to pkey register
Date:   Fri, 17 Jan 2020 18:19:45 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20011712-0020-0000-0000-000003A195A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011712-0021-0000-0000-000021F918E7
Message-Id: <ba30fdb27558102c1764821d2f11b954a2486a9e.1579265066.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_03:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 malwarescore=0 mlxlogscore=723 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001170102
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

The size of the pkey register can vary across architectures.
This converts the data type of all its references to u64 in
preparation for multi-arch support.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 23 +++---
 tools/testing/selftests/vm/pkey-x86.h        |  8 +-
 tools/testing/selftests/vm/protection_keys.c | 83 ++++++++++++--------
 3 files changed, 66 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 7f18a82e54fc..cc3491a6df2d 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -80,13 +80,14 @@ extern void abort_hooks(void);
 #error Architecture not supported
 #endif /* arch */
 
-extern unsigned int shadow_pkey_reg;
+extern u64 shadow_pkey_reg;
 
-static inline unsigned int _read_pkey_reg(int line)
+static inline u64 _read_pkey_reg(int line)
 {
-	unsigned int pkey_reg = __read_pkey_reg();
+	u64 pkey_reg = __read_pkey_reg();
 
-	dprintf4("read_pkey_reg(line=%d) pkey_reg: %x shadow: %x\n",
+	dprintf4("read_pkey_reg(line=%d) pkey_reg: %016lx"
+			" shadow: %016lx\n",
 			line, pkey_reg, shadow_pkey_reg);
 	assert(pkey_reg == shadow_pkey_reg);
 
@@ -95,15 +96,15 @@ static inline unsigned int _read_pkey_reg(int line)
 
 #define read_pkey_reg() _read_pkey_reg(__LINE__)
 
-static inline void write_pkey_reg(unsigned int pkey_reg)
+static inline void write_pkey_reg(u64 pkey_reg)
 {
-	dprintf4("%s() changing %08x to %08x\n", __func__,
+	dprintf4("%s() changing %016lx to %016lx\n", __func__,
 			__read_pkey_reg(), pkey_reg);
 	/* will do the shadow check for us: */
 	read_pkey_reg();
 	__write_pkey_reg(pkey_reg);
 	shadow_pkey_reg = pkey_reg;
-	dprintf4("%s(%08x) pkey_reg: %08x\n", __func__,
+	dprintf4("%s(%016lx) pkey_reg: %016lx\n", __func__,
 			pkey_reg, __read_pkey_reg());
 }
 
@@ -113,7 +114,7 @@ static inline void write_pkey_reg(unsigned int pkey_reg)
  */
 static inline void __pkey_access_allow(int pkey, int do_allow)
 {
-	unsigned int pkey_reg = read_pkey_reg();
+	u64 pkey_reg = read_pkey_reg();
 	int bit = pkey * 2;
 
 	if (do_allow)
@@ -121,13 +122,13 @@ static inline void __pkey_access_allow(int pkey, int do_allow)
 	else
 		pkey_reg |= (1<<bit);
 
-	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
+	dprintf4("pkey_reg now: %016lx\n", read_pkey_reg());
 	write_pkey_reg(pkey_reg);
 }
 
 static inline void __pkey_write_allow(int pkey, int do_allow_write)
 {
-	long pkey_reg = read_pkey_reg();
+	u64 pkey_reg = read_pkey_reg();
 	int bit = pkey * 2 + 1;
 
 	if (do_allow_write)
@@ -136,7 +137,7 @@ static inline void __pkey_write_allow(int pkey, int do_allow_write)
 		pkey_reg |= (1<<bit);
 
 	write_pkey_reg(pkey_reg);
-	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
+	dprintf4("pkey_reg now: %016lx\n", read_pkey_reg());
 }
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index 2f04ade8ca9c..dc34ae21e714 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -53,11 +53,11 @@ static inline void __page_o_noops(void)
 	asm(".rept 512 ; nopl 0x7eeeeeee(%eax) ; .endr");
 }
 
-static inline unsigned int __read_pkey_reg(void)
+static inline u64 __read_pkey_reg(void)
 {
 	unsigned int eax, edx;
 	unsigned int ecx = 0;
-	unsigned int pkey_reg;
+	unsigned pkey_reg;
 
 	asm volatile(".byte 0x0f,0x01,0xee\n\t"
 		     : "=a" (eax), "=d" (edx)
@@ -66,13 +66,13 @@ static inline unsigned int __read_pkey_reg(void)
 	return pkey_reg;
 }
 
-static inline void __write_pkey_reg(unsigned int pkey_reg)
+static inline void __write_pkey_reg(u64 pkey_reg)
 {
 	unsigned int eax = pkey_reg;
 	unsigned int ecx = 0;
 	unsigned int edx = 0;
 
-	dprintf4("%s() changing %08x to %08x\n", __func__,
+	dprintf4("%s() changing %016lx to %016lx\n", __func__,
 			__read_pkey_reg(), pkey_reg);
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 		     : : "a" (eax), "c" (ecx), "d" (edx));
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 2d0e881f109d..f36e9e7789ce 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -48,7 +48,7 @@
 int iteration_nr = 1;
 int test_nr;
 
-unsigned int shadow_pkey_reg;
+u64 shadow_pkey_reg;
 int dprint_in_signal;
 char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
@@ -163,7 +163,7 @@ void dump_mem(void *dumpme, int len_bytes)
 
 	for (i = 0; i < len_bytes; i += sizeof(u64)) {
 		u64 *ptr = (u64 *)(c + i);
-		dprintf1("dump[%03d][@%p]: %016jx\n", i, ptr, *ptr);
+		dprintf1("dump[%03d][@%p]: %016lx\n", i, ptr, *ptr);
 	}
 }
 
@@ -205,7 +205,8 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 
 	dprint_in_signal = 1;
 	dprintf1(">>>>===============SIGSEGV============================\n");
-	dprintf1("%s()::%d, pkey_reg: 0x%x shadow: %x\n", __func__, __LINE__,
+	dprintf1("%s()::%d, pkey_reg: 0x%016lx shadow: %016lx\n",
+			__func__, __LINE__,
 			__read_pkey_reg(), shadow_pkey_reg);
 
 	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
@@ -213,8 +214,9 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	fpregset = uctxt->uc_mcontext.fpregs;
 	fpregs = (void *)fpregset;
 
-	dprintf2("%s() trapno: %d ip: 0x%lx info->si_code: %s/%d\n", __func__,
-			trapno, ip, si_code_str(si->si_code), si->si_code);
+	dprintf2("%s() trapno: %d ip: 0x%016lx info->si_code: %s/%d\n",
+			__func__, trapno, ip, si_code_str(si->si_code),
+			si->si_code);
 #ifdef __i386__
 	/*
 	 * 32-bit has some extra padding so that userspace can tell whether
@@ -256,7 +258,8 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
 	 * checking
 	 */
-	dprintf1("signal pkey_reg from  pkey_reg: %08x\n", __read_pkey_reg());
+	dprintf1("signal pkey_reg from  pkey_reg: %016lx\n",
+			__read_pkey_reg());
 	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
 	*(u64 *)pkey_reg_ptr = 0x00000000;
 	dprintf1("WARNING: set PKEY_REG=0 to allow faulting instruction to continue\n");
@@ -331,16 +334,17 @@ pid_t fork_lazy_child(void)
 static u32 hw_pkey_get(int pkey, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
-	u32 pkey_reg = __read_pkey_reg();
-	u32 shifted_pkey_reg;
+	u64 pkey_reg = __read_pkey_reg();
+	u64 shifted_pkey_reg;
 	u32 masked_pkey_reg;
 
 	dprintf1("%s(pkey=%d, flags=%lx) = %x / %d\n",
 			__func__, pkey, flags, 0, 0);
-	dprintf2("%s() raw pkey_reg: %x\n", __func__, pkey_reg);
+	dprintf2("%s() raw pkey_reg: %016lx\n", __func__, pkey_reg);
 
 	shifted_pkey_reg = (pkey_reg >> (pkey * PKEY_BITS_PER_PKEY));
-	dprintf2("%s() shifted_pkey_reg: %x\n", __func__, shifted_pkey_reg);
+	dprintf2("%s() shifted_pkey_reg: %016lx\n", __func__,
+			shifted_pkey_reg);
 	masked_pkey_reg = shifted_pkey_reg & mask;
 	dprintf2("%s() masked  pkey_reg: %x\n", __func__, masked_pkey_reg);
 	/*
@@ -353,8 +357,8 @@ static u32 hw_pkey_get(int pkey, unsigned long flags)
 static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
-	u32 old_pkey_reg = __read_pkey_reg();
-	u32 new_pkey_reg;
+	u64 old_pkey_reg = __read_pkey_reg();
+	u64 new_pkey_reg;
 
 	/* make sure that 'rights' only contains the bits we expect: */
 	assert(!(rights & ~mask));
@@ -369,7 +373,7 @@ static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
 	__write_pkey_reg(new_pkey_reg);
 
 	dprintf3("%s(pkey=%d, rights=%lx, flags=%lx) = %x"
-		" pkey_reg now: %x old_pkey_reg: %x\n",
+		" pkey_reg now: %016lx old_pkey_reg: %016lx\n",
 		__func__, pkey, rights, flags, 0, __read_pkey_reg(),
 		old_pkey_reg);
 	return 0;
@@ -380,7 +384,7 @@ void pkey_disable_set(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights;
-	u32 orig_pkey_reg = read_pkey_reg();
+	u64 orig_pkey_reg = read_pkey_reg();
 
 	dprintf1("START->%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
@@ -390,6 +394,7 @@ void pkey_disable_set(int pkey, int flags)
 
 	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
+
 	pkey_assert(pkey_rights >= 0);
 
 	pkey_rights |= flags;
@@ -398,7 +403,8 @@ void pkey_disable_set(int pkey, int flags)
 	assert(!ret);
 	/* pkey_reg and flags have the same format */
 	shadow_pkey_reg |= flags << (pkey * 2);
-	dprintf1("%s(%d) shadow: 0x%x\n", __func__, pkey, shadow_pkey_reg);
+	dprintf1("%s(%d) shadow: 0x%016lx\n",
+		__func__, pkey, shadow_pkey_reg);
 
 	pkey_assert(ret >= 0);
 
@@ -406,7 +412,8 @@ void pkey_disable_set(int pkey, int flags)
 	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
-	dprintf1("%s(%d) pkey_reg: 0x%x\n", __func__, pkey, read_pkey_reg());
+	dprintf1("%s(%d) pkey_reg: 0x%016lx\n",
+		__func__, pkey, read_pkey_reg());
 	if (flags)
 		pkey_assert(read_pkey_reg() > orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
@@ -418,7 +425,7 @@ void pkey_disable_clear(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights = hw_pkey_get(pkey, syscall_flags);
-	u32 orig_pkey_reg = read_pkey_reg();
+	u64 orig_pkey_reg = read_pkey_reg();
 
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
@@ -436,7 +443,8 @@ void pkey_disable_clear(int pkey, int flags)
 	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
-	dprintf1("%s(%d) pkey_reg: 0x%x\n", __func__, pkey, read_pkey_reg());
+	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
+			pkey, read_pkey_reg());
 	if (flags)
 		assert(read_pkey_reg() > orig_pkey_reg);
 }
@@ -491,20 +499,22 @@ int alloc_pkey(void)
 	int ret;
 	unsigned long init_val = 0x0;
 
-	dprintf1("%s()::%d, pkey_reg: 0x%x shadow: %x\n", __func__,
-			__LINE__, __read_pkey_reg(), shadow_pkey_reg);
+	dprintf1("%s()::%d, pkey_reg: 0x%016lx shadow: %016lx\n",
+			__func__, __LINE__, __read_pkey_reg(), shadow_pkey_reg);
 	ret = sys_pkey_alloc(0, init_val);
 	/*
 	 * pkey_alloc() sets PKEY register, so we need to reflect it in
 	 * shadow_pkey_reg:
 	 */
-	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+			" shadow: 0x%016lx\n",
 			__func__, __LINE__, ret, __read_pkey_reg(),
 			shadow_pkey_reg);
 	if (ret) {
 		/* clear both the bits: */
 		shadow_pkey_reg &= ~(0x3      << (ret * 2));
-		dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+		dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+				" shadow: 0x%016lx\n",
 				__func__,
 				__LINE__, ret, __read_pkey_reg(),
 				shadow_pkey_reg);
@@ -514,13 +524,15 @@ int alloc_pkey(void)
 		 */
 		shadow_pkey_reg |=  (init_val << (ret * 2));
 	}
-	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+			" shadow: 0x%016lx\n",
 			__func__, __LINE__, ret, __read_pkey_reg(),
 			shadow_pkey_reg);
 	dprintf1("%s()::%d errno: %d\n", __func__, __LINE__, errno);
 	/* for shadow checking: */
 	read_pkey_reg();
-	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+		 " shadow: 0x%016lx\n",
 		__func__, __LINE__, ret, __read_pkey_reg(),
 		shadow_pkey_reg);
 	return ret;
@@ -573,7 +585,8 @@ int alloc_random_pkey(void)
 		free_ret = sys_pkey_free(alloced_pkeys[i]);
 		pkey_assert(!free_ret);
 	}
-	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
+	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+			 " shadow: 0x%016lx\n", __func__,
 			__LINE__, ret, __read_pkey_reg(), shadow_pkey_reg);
 	return ret;
 }
@@ -592,11 +605,13 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 		if (nr_iterations-- < 0)
 			break;
 
-		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+			" shadow: 0x%016lx\n",
 			__func__, __LINE__, ret, __read_pkey_reg(),
 			shadow_pkey_reg);
 		sys_pkey_free(rpkey);
-		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+			" shadow: 0x%016lx\n",
 			__func__, __LINE__, ret, __read_pkey_reg(),
 			shadow_pkey_reg);
 	}
@@ -606,7 +621,8 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 	dprintf1("mprotect_pkey(%p, %zx, prot=0x%lx, pkey=%ld) ret: %d\n",
 			ptr, size, orig_prot, pkey, ret);
 	pkey_assert(!ret);
-	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
+	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%016lx"
+			" shadow: 0x%016lx\n", __func__,
 			__LINE__, ret, __read_pkey_reg(), shadow_pkey_reg);
 	return ret;
 }
@@ -885,7 +901,7 @@ void expected_pkey_fault(int pkey)
 		pkey_assert(0);
 
 	__write_pkey_reg(shadow_pkey_reg);
-	dprintf1("%s() set pkey_reg=%x to restore state after signal "
+	dprintf1("%s() set pkey_reg=%016lx to restore state after signal "
 		       "nuked it\n", __func__, shadow_pkey_reg);
 	last_pkey_faults = pkey_faults;
 	last_si_pkey = -1;
@@ -1097,7 +1113,8 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 		int new_pkey;
 		dprintf1("%s() alloc loop: %d\n", __func__, i);
 		new_pkey = alloc_pkey();
-		dprintf4("%s()::%d, err: %d pkey_reg: 0x%x shadow: 0x%x\n",
+		dprintf4("%s()::%d, err: %d pkey_reg: 0x%016lx"
+				" shadow: 0x%016lx\n",
 				__func__, __LINE__, err, __read_pkey_reg(),
 				shadow_pkey_reg);
 		read_pkey_reg(); /* for shadow checking */
@@ -1285,7 +1302,7 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	pkey_assert(!ret);
 	pkey_access_deny(pkey);
 
-	dprintf2("pkey_reg: %x\n", read_pkey_reg());
+	dprintf2("pkey_reg: %016lx\n", read_pkey_reg());
 
 	/*
 	 * Make sure this is an *instruction* fault
@@ -1316,7 +1333,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
 	pkey_assert(!ret);
 
-	dprintf2("pkru: %x\n", read_pkey_reg());
+	dprintf2("pkey_reg: %016lx\n", read_pkey_reg());
 
 	/* Make sure this is an *instruction* fault */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
@@ -1433,7 +1450,7 @@ int main(void)
 	}
 
 	pkey_setup_shadow();
-	printf("startup pkey_reg: %x\n", read_pkey_reg());
+	printf("startup pkey_reg: %016lx\n", read_pkey_reg());
 	setup_hugetlbfs();
 
 	while (nr_iterations-- > 0)
-- 
2.17.1

