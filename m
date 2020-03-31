Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2B1992CE
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgCaJ6p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 05:58:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730381AbgCaJ6p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 05:58:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V9YEJN053318
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3020wdhe2q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 31 Mar 2020 10:58:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 10:58:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02V9wZZR56885338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 09:58:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3380E4C040;
        Tue, 31 Mar 2020 09:58:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A4514C04E;
        Tue, 31 Mar 2020 09:58:32 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 09:58:32 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
        fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        shuah@kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v19 02/24] selftests/vm/pkeys: Rename all references to pkru to a generic name
Date:   Tue, 31 Mar 2020 15:28:03 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20033109-0016-0000-0000-000002FB8F26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033109-0017-0000-0000-0000335F4D93
Message-Id: <2c6970bc6d2e99796cd5cc1101bd2ecf7eccb937.1585646528.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=3 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310081
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

This renames PKRU references to "pkey_reg" or "pkey" based on
the usage.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    |  85 +++----
 tools/testing/selftests/vm/protection_keys.c | 240 ++++++++++---------
 2 files changed, 170 insertions(+), 155 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index 254e5436bdd99..d5779be4793f8 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -14,7 +14,7 @@
 #include <sys/mman.h>
 
 #define NR_PKEYS 16
-#define PKRU_BITS_PER_PKEY 2
+#define PKEY_BITS_PER_PKEY 2
 
 #ifndef DEBUG_LEVEL
 #define DEBUG_LEVEL 0
@@ -53,85 +53,88 @@ static inline void sigsafe_printf(const char *format, ...)
 #define dprintf3(args...) dprintf_level(3, args)
 #define dprintf4(args...) dprintf_level(4, args)
 
-extern unsigned int shadow_pkru;
-static inline unsigned int __rdpkru(void)
+extern unsigned int shadow_pkey_reg;
+static inline unsigned int __read_pkey_reg(void)
 {
 	unsigned int eax, edx;
 	unsigned int ecx = 0;
-	unsigned int pkru;
+	unsigned int pkey_reg;
 
 	asm volatile(".byte 0x0f,0x01,0xee\n\t"
 		     : "=a" (eax), "=d" (edx)
 		     : "c" (ecx));
-	pkru = eax;
-	return pkru;
+	pkey_reg = eax;
+	return pkey_reg;
 }
 
-static inline unsigned int _rdpkru(int line)
+static inline unsigned int _read_pkey_reg(int line)
 {
-	unsigned int pkru = __rdpkru();
+	unsigned int pkey_reg = __read_pkey_reg();
 
-	dprintf4("rdpkru(line=%d) pkru: %x shadow: %x\n",
-			line, pkru, shadow_pkru);
-	assert(pkru == shadow_pkru);
+	dprintf4("read_pkey_reg(line=%d) pkey_reg: %x shadow: %x\n",
+			line, pkey_reg, shadow_pkey_reg);
+	assert(pkey_reg == shadow_pkey_reg);
 
-	return pkru;
+	return pkey_reg;
 }
 
-#define rdpkru() _rdpkru(__LINE__)
+#define read_pkey_reg() _read_pkey_reg(__LINE__)
 
-static inline void __wrpkru(unsigned int pkru)
+static inline void __write_pkey_reg(unsigned int pkey_reg)
 {
-	unsigned int eax = pkru;
+	unsigned int eax = pkey_reg;
 	unsigned int ecx = 0;
 	unsigned int edx = 0;
 
-	dprintf4("%s() changing %08x to %08x\n", __func__, __rdpkru(), pkru);
+	dprintf4("%s() changing %08x to %08x\n", __func__,
+			__read_pkey_reg(), pkey_reg);
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 		     : : "a" (eax), "c" (ecx), "d" (edx));
-	assert(pkru == __rdpkru());
+	assert(pkey_reg == __read_pkey_reg());
 }
 
-static inline void wrpkru(unsigned int pkru)
+static inline void write_pkey_reg(unsigned int pkey_reg)
 {
-	dprintf4("%s() changing %08x to %08x\n", __func__, __rdpkru(), pkru);
+	dprintf4("%s() changing %08x to %08x\n", __func__,
+			__read_pkey_reg(), pkey_reg);
 	/* will do the shadow check for us: */
-	rdpkru();
-	__wrpkru(pkru);
-	shadow_pkru = pkru;
-	dprintf4("%s(%08x) pkru: %08x\n", __func__, pkru, __rdpkru());
+	read_pkey_reg();
+	__write_pkey_reg(pkey_reg);
+	shadow_pkey_reg = pkey_reg;
+	dprintf4("%s(%08x) pkey_reg: %08x\n", __func__,
+			pkey_reg, __read_pkey_reg());
 }
 
 /*
  * These are technically racy. since something could
- * change PKRU between the read and the write.
+ * change PKEY register between the read and the write.
  */
 static inline void __pkey_access_allow(int pkey, int do_allow)
 {
-	unsigned int pkru = rdpkru();
+	unsigned int pkey_reg = read_pkey_reg();
 	int bit = pkey * 2;
 
 	if (do_allow)
-		pkru &= (1<<bit);
+		pkey_reg &= (1<<bit);
 	else
-		pkru |= (1<<bit);
+		pkey_reg |= (1<<bit);
 
-	dprintf4("pkru now: %08x\n", rdpkru());
-	wrpkru(pkru);
+	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
+	write_pkey_reg(pkey_reg);
 }
 
 static inline void __pkey_write_allow(int pkey, int do_allow_write)
 {
-	long pkru = rdpkru();
+	long pkey_reg = read_pkey_reg();
 	int bit = pkey * 2 + 1;
 
 	if (do_allow_write)
-		pkru &= (1<<bit);
+		pkey_reg &= (1<<bit);
 	else
-		pkru |= (1<<bit);
+		pkey_reg |= (1<<bit);
 
-	wrpkru(pkru);
-	dprintf4("pkru now: %08x\n", rdpkru());
+	write_pkey_reg(pkey_reg);
+	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
 }
 
 #define PROT_PKEY0     0x10            /* protection key value (bit 0) */
@@ -181,10 +184,10 @@ static inline int cpu_has_pku(void)
 	return 1;
 }
 
-#define XSTATE_PKRU_BIT	(9)
-#define XSTATE_PKRU	0x200
+#define XSTATE_PKEY_BIT	(9)
+#define XSTATE_PKEY	0x200
 
-int pkru_xstate_offset(void)
+int pkey_reg_xstate_offset(void)
 {
 	unsigned int eax;
 	unsigned int ebx;
@@ -195,21 +198,21 @@ int pkru_xstate_offset(void)
 	unsigned long XSTATE_CPUID = 0xd;
 	int leaf;
 
-	/* assume that XSTATE_PKRU is set in XCR0 */
-	leaf = XSTATE_PKRU_BIT;
+	/* assume that XSTATE_PKEY is set in XCR0 */
+	leaf = XSTATE_PKEY_BIT;
 	{
 		eax = XSTATE_CPUID;
 		ecx = leaf;
 		__cpuid(&eax, &ebx, &ecx, &edx);
 
-		if (leaf == XSTATE_PKRU_BIT) {
+		if (leaf == XSTATE_PKEY_BIT) {
 			xstate_offset = ebx;
 			xstate_size = eax;
 		}
 	}
 
 	if (xstate_size == 0) {
-		printf("could not find size/offset of PKRU in xsave state\n");
+		printf("could not find size/offset of PKEY in xsave state\n");
 		return 0;
 	}
 
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 480995bceefa5..2f4ab81c570db 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1,11 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Tests x86 Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
+ * Tests Memory Protection Keys (see Documentation/vm/protection-keys.txt)
  *
  * There are examples in here of:
  *  * how to set protection keys on memory
- *  * how to set/clear bits in PKRU (the rights register)
- *  * how to handle SEGV_PKRU signals and extract pkey-relevant
+ *  * how to set/clear bits in pkey registers (the rights register)
+ *  * how to handle SEGV_PKUERR signals and extract pkey-relevant
  *    information from the siginfo
  *
  * Things to add:
@@ -48,7 +48,7 @@
 int iteration_nr = 1;
 int test_nr;
 
-unsigned int shadow_pkru;
+unsigned int shadow_pkey_reg;
 
 #define HPAGE_SIZE	(1UL<<21)
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
@@ -255,7 +255,7 @@ static char *si_code_str(int si_code)
 	return "UNKNOWN";
 }
 
-int pkru_faults;
+int pkey_faults;
 int last_si_pkey = -1;
 void signal_handler(int signum, siginfo_t *si, void *vucontext)
 {
@@ -263,16 +263,16 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	int trapno;
 	unsigned long ip;
 	char *fpregs;
-	u32 *pkru_ptr;
+	u32 *pkey_reg_ptr;
 	u64 siginfo_pkey;
 	u32 *si_pkey_ptr;
-	int pkru_offset;
+	int pkey_reg_offset;
 	fpregset_t fpregset;
 
 	dprint_in_signal = 1;
 	dprintf1(">>>>===============SIGSEGV============================\n");
-	dprintf1("%s()::%d, pkru: 0x%x shadow: %x\n", __func__, __LINE__,
-			__rdpkru(), shadow_pkru);
+	dprintf1("%s()::%d, pkey_reg: 0x%x shadow: %x\n", __func__, __LINE__,
+			__read_pkey_reg(), shadow_pkey_reg);
 
 	trapno = uctxt->uc_mcontext.gregs[REG_TRAPNO];
 	ip = uctxt->uc_mcontext.gregs[REG_IP_IDX];
@@ -289,19 +289,19 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	 */
 	fpregs += 0x70;
 #endif
-	pkru_offset = pkru_xstate_offset();
-	pkru_ptr = (void *)(&fpregs[pkru_offset]);
+	pkey_reg_offset = pkey_reg_xstate_offset();
+	pkey_reg_ptr = (void *)(&fpregs[pkey_reg_offset]);
 
 	dprintf1("siginfo: %p\n", si);
 	dprintf1(" fpregs: %p\n", fpregs);
 	/*
-	 * If we got a PKRU fault, we *HAVE* to have at least one bit set in
+	 * If we got a PKEY fault, we *HAVE* to have at least one bit set in
 	 * here.
 	 */
-	dprintf1("pkru_xstate_offset: %d\n", pkru_xstate_offset());
+	dprintf1("pkey_reg_xstate_offset: %d\n", pkey_reg_xstate_offset());
 	if (DEBUG_LEVEL > 4)
-		dump_mem(pkru_ptr - 128, 256);
-	pkey_assert(*pkru_ptr);
+		dump_mem(pkey_reg_ptr - 128, 256);
+	pkey_assert(*pkey_reg_ptr);
 
 	if ((si->si_code == SEGV_MAPERR) ||
 	    (si->si_code == SEGV_ACCERR) ||
@@ -317,13 +317,16 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	pkey_assert(siginfo_pkey < NR_PKEYS);
 	last_si_pkey = siginfo_pkey;
 
-	dprintf1("signal pkru from xsave: %08x\n", *pkru_ptr);
-	/* need __rdpkru() version so we do not do shadow_pkru checking */
-	dprintf1("signal pkru from  pkru: %08x\n", __rdpkru());
+	dprintf1("signal pkey_reg from xsave: %08x\n", *pkey_reg_ptr);
+	/*
+	 * need __read_pkey_reg() version so we do not do shadow_pkey_reg
+	 * checking
+	 */
+	dprintf1("signal pkey_reg from  pkey_reg: %08x\n", __read_pkey_reg());
 	dprintf1("pkey from siginfo: %jx\n", siginfo_pkey);
-	*(u64 *)pkru_ptr = 0x00000000;
-	dprintf1("WARNING: set PRKU=0 to allow faulting instruction to continue\n");
-	pkru_faults++;
+	*(u64 *)pkey_reg_ptr = 0x00000000;
+	dprintf1("WARNING: set PKEY_REG=0 to allow faulting instruction to continue\n");
+	pkey_faults++;
 	dprintf1("<<<<==================================================\n");
 	dprint_in_signal = 0;
 }
@@ -402,45 +405,47 @@ pid_t fork_lazy_child(void)
 static u32 hw_pkey_get(int pkey, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
-	u32 pkru = __rdpkru();
-	u32 shifted_pkru;
-	u32 masked_pkru;
+	u32 pkey_reg = __read_pkey_reg();
+	u32 shifted_pkey_reg;
+	u32 masked_pkey_reg;
 
 	dprintf1("%s(pkey=%d, flags=%lx) = %x / %d\n",
 			__func__, pkey, flags, 0, 0);
-	dprintf2("%s() raw pkru: %x\n", __func__, pkru);
+	dprintf2("%s() raw pkey_reg: %x\n", __func__, pkey_reg);
 
-	shifted_pkru = (pkru >> (pkey * PKRU_BITS_PER_PKEY));
-	dprintf2("%s() shifted_pkru: %x\n", __func__, shifted_pkru);
-	masked_pkru = shifted_pkru & mask;
-	dprintf2("%s() masked  pkru: %x\n", __func__, masked_pkru);
+	shifted_pkey_reg = (pkey_reg >> (pkey * PKEY_BITS_PER_PKEY));
+	dprintf2("%s() shifted_pkey_reg: %x\n", __func__, shifted_pkey_reg);
+	masked_pkey_reg = shifted_pkey_reg & mask;
+	dprintf2("%s() masked  pkey_reg: %x\n", __func__, masked_pkey_reg);
 	/*
 	 * shift down the relevant bits to the lowest two, then
 	 * mask off all the other high bits.
 	 */
-	return masked_pkru;
+	return masked_pkey_reg;
 }
 
 static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
-	u32 old_pkru = __rdpkru();
-	u32 new_pkru;
+	u32 old_pkey_reg = __read_pkey_reg();
+	u32 new_pkey_reg;
 
 	/* make sure that 'rights' only contains the bits we expect: */
 	assert(!(rights & ~mask));
 
-	/* copy old pkru */
-	new_pkru = old_pkru;
+	/* copy old pkey_reg */
+	new_pkey_reg = old_pkey_reg;
 	/* mask out bits from pkey in old value: */
-	new_pkru &= ~(mask << (pkey * PKRU_BITS_PER_PKEY));
+	new_pkey_reg &= ~(mask << (pkey * PKEY_BITS_PER_PKEY));
 	/* OR in new bits for pkey: */
-	new_pkru |= (rights << (pkey * PKRU_BITS_PER_PKEY));
+	new_pkey_reg |= (rights << (pkey * PKEY_BITS_PER_PKEY));
 
-	__wrpkru(new_pkru);
+	__write_pkey_reg(new_pkey_reg);
 
-	dprintf3("%s(pkey=%d, rights=%lx, flags=%lx) = %x pkru now: %x old_pkru: %x\n",
-			__func__, pkey, rights, flags, 0, __rdpkru(), old_pkru);
+	dprintf3("%s(pkey=%d, rights=%lx, flags=%lx) = %x"
+		" pkey_reg now: %x old_pkey_reg: %x\n",
+		__func__, pkey, rights, flags, 0, __read_pkey_reg(),
+		old_pkey_reg);
 	return 0;
 }
 
@@ -449,7 +454,7 @@ void pkey_disable_set(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights;
-	u32 orig_pkru = rdpkru();
+	u32 orig_pkey_reg = read_pkey_reg();
 
 	dprintf1("START->%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
@@ -465,9 +470,9 @@ void pkey_disable_set(int pkey, int flags)
 
 	ret = hw_pkey_set(pkey, pkey_rights, syscall_flags);
 	assert(!ret);
-	/*pkru and flags have the same format */
-	shadow_pkru |= flags << (pkey * 2);
-	dprintf1("%s(%d) shadow: 0x%x\n", __func__, pkey, shadow_pkru);
+	/* pkey_reg and flags have the same format */
+	shadow_pkey_reg |= flags << (pkey * 2);
+	dprintf1("%s(%d) shadow: 0x%x\n", __func__, pkey, shadow_pkey_reg);
 
 	pkey_assert(ret >= 0);
 
@@ -475,9 +480,9 @@ void pkey_disable_set(int pkey, int flags)
 	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
-	dprintf1("%s(%d) pkru: 0x%x\n", __func__, pkey, rdpkru());
+	dprintf1("%s(%d) pkey_reg: 0x%x\n", __func__, pkey, read_pkey_reg());
 	if (flags)
-		pkey_assert(rdpkru() > orig_pkru);
+		pkey_assert(read_pkey_reg() > orig_pkey_reg);
 	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
 		pkey, flags);
 }
@@ -487,7 +492,7 @@ void pkey_disable_clear(int pkey, int flags)
 	unsigned long syscall_flags = 0;
 	int ret;
 	int pkey_rights = hw_pkey_get(pkey, syscall_flags);
-	u32 orig_pkru = rdpkru();
+	u32 orig_pkey_reg = read_pkey_reg();
 
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
@@ -498,17 +503,16 @@ void pkey_disable_clear(int pkey, int flags)
 	pkey_rights |= flags;
 
 	ret = hw_pkey_set(pkey, pkey_rights, 0);
-	/* pkru and flags have the same format */
-	shadow_pkru &= ~(flags << (pkey * 2));
+	shadow_pkey_reg &= ~(flags << (pkey * 2));
 	pkey_assert(ret >= 0);
 
 	pkey_rights = hw_pkey_get(pkey, syscall_flags);
 	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
-	dprintf1("%s(%d) pkru: 0x%x\n", __func__, pkey, rdpkru());
+	dprintf1("%s(%d) pkey_reg: 0x%x\n", __func__, pkey, read_pkey_reg());
 	if (flags)
-		assert(rdpkru() > orig_pkru);
+		assert(read_pkey_reg() > orig_pkey_reg);
 }
 
 void pkey_write_allow(int pkey)
@@ -561,33 +565,38 @@ int alloc_pkey(void)
 	int ret;
 	unsigned long init_val = 0x0;
 
-	dprintf1("alloc_pkey()::%d, pkru: 0x%x shadow: %x\n",
-			__LINE__, __rdpkru(), shadow_pkru);
+	dprintf1("%s()::%d, pkey_reg: 0x%x shadow: %x\n", __func__,
+			__LINE__, __read_pkey_reg(), shadow_pkey_reg);
 	ret = sys_pkey_alloc(0, init_val);
 	/*
-	 * pkey_alloc() sets PKRU, so we need to reflect it in
-	 * shadow_pkru:
+	 * pkey_alloc() sets PKEY register, so we need to reflect it in
+	 * shadow_pkey_reg:
 	 */
-	dprintf4("alloc_pkey()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n",
-			__LINE__, ret, __rdpkru(), shadow_pkru);
+	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+			__func__, __LINE__, ret, __read_pkey_reg(),
+			shadow_pkey_reg);
 	if (ret) {
 		/* clear both the bits: */
-		shadow_pkru &= ~(0x3      << (ret * 2));
-		dprintf4("alloc_pkey()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n",
-				__LINE__, ret, __rdpkru(), shadow_pkru);
+		shadow_pkey_reg &= ~(0x3      << (ret * 2));
+		dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+				__func__,
+				__LINE__, ret, __read_pkey_reg(),
+				shadow_pkey_reg);
 		/*
 		 * move the new state in from init_val
-		 * (remember, we cheated and init_val == pkru format)
+		 * (remember, we cheated and init_val == pkey_reg format)
 		 */
-		shadow_pkru |=  (init_val << (ret * 2));
+		shadow_pkey_reg |=  (init_val << (ret * 2));
 	}
-	dprintf4("alloc_pkey()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n",
-			__LINE__, ret, __rdpkru(), shadow_pkru);
-	dprintf1("alloc_pkey()::%d errno: %d\n", __LINE__, errno);
+	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+			__func__, __LINE__, ret, __read_pkey_reg(),
+			shadow_pkey_reg);
+	dprintf1("%s()::%d errno: %d\n", __func__, __LINE__, errno);
 	/* for shadow checking: */
-	rdpkru();
-	dprintf4("alloc_pkey()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n",
-			__LINE__, ret, __rdpkru(), shadow_pkru);
+	read_pkey_reg();
+	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+		__func__, __LINE__, ret, __read_pkey_reg(),
+		shadow_pkey_reg);
 	return ret;
 }
 
@@ -638,8 +647,8 @@ int alloc_random_pkey(void)
 		free_ret = sys_pkey_free(alloced_pkeys[i]);
 		pkey_assert(!free_ret);
 	}
-	dprintf1("%s()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n", __func__,
-			__LINE__, ret, __rdpkru(), shadow_pkru);
+	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
+			__LINE__, ret, __read_pkey_reg(), shadow_pkey_reg);
 	return ret;
 }
 
@@ -657,11 +666,13 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 		if (nr_iterations-- < 0)
 			break;
 
-		dprintf1("%s()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n", __func__,
-			__LINE__, ret, __rdpkru(), shadow_pkru);
+		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+			__func__, __LINE__, ret, __read_pkey_reg(),
+			shadow_pkey_reg);
 		sys_pkey_free(rpkey);
-		dprintf1("%s()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n", __func__,
-			__LINE__, ret, __rdpkru(), shadow_pkru);
+		dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n",
+			__func__, __LINE__, ret, __read_pkey_reg(),
+			shadow_pkey_reg);
 	}
 	pkey_assert(pkey < NR_PKEYS);
 
@@ -669,8 +680,8 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 	dprintf1("mprotect_pkey(%p, %zx, prot=0x%lx, pkey=%ld) ret: %d\n",
 			ptr, size, orig_prot, pkey, ret);
 	pkey_assert(!ret);
-	dprintf1("%s()::%d, ret: %d pkru: 0x%x shadow: 0x%x\n", __func__,
-			__LINE__, ret, __rdpkru(), shadow_pkru);
+	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
+			__LINE__, ret, __read_pkey_reg(), shadow_pkey_reg);
 	return ret;
 }
 
@@ -752,7 +763,7 @@ void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
 	void *ptr;
 	int ret;
 
-	rdpkru();
+	read_pkey_reg();
 	dprintf1("doing %s(size=%ld, prot=0x%x, pkey=%d)\n", __func__,
 			size, prot, pkey);
 	pkey_assert(pkey < NR_PKEYS);
@@ -761,7 +772,7 @@ void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
 	ret = mprotect_pkey((void *)ptr, PAGE_SIZE, prot, pkey);
 	pkey_assert(!ret);
 	record_pkey_malloc(ptr, size, prot);
-	rdpkru();
+	read_pkey_reg();
 
 	dprintf1("%s() for pkey %d @ %p\n", __func__, pkey, ptr);
 	return ptr;
@@ -924,14 +935,14 @@ void *malloc_pkey(long size, int prot, u16 pkey)
 	return ret;
 }
 
-int last_pkru_faults;
+int last_pkey_faults;
 #define UNKNOWN_PKEY -2
-void expected_pk_fault(int pkey)
+void expected_pkey_fault(int pkey)
 {
-	dprintf2("%s(): last_pkru_faults: %d pkru_faults: %d\n",
-			__func__, last_pkru_faults, pkru_faults);
+	dprintf2("%s(): last_pkey_faults: %d pkey_faults: %d\n",
+			__func__, last_pkey_faults, pkey_faults);
 	dprintf2("%s(%d): last_si_pkey: %d\n", __func__, pkey, last_si_pkey);
-	pkey_assert(last_pkru_faults + 1 == pkru_faults);
+	pkey_assert(last_pkey_faults + 1 == pkey_faults);
 
        /*
 	* For exec-only memory, we do not know the pkey in
@@ -941,23 +952,23 @@ void expected_pk_fault(int pkey)
 		pkey_assert(last_si_pkey == pkey);
 
 	/*
-	 * The signal handler shold have cleared out PKRU to let the
+	 * The signal handler shold have cleared out PKEY register to let the
 	 * test program continue.  We now have to restore it.
 	 */
-	if (__rdpkru() != 0)
+	if (__read_pkey_reg() != 0)
 		pkey_assert(0);
 
-	__wrpkru(shadow_pkru);
-	dprintf1("%s() set PKRU=%x to restore state after signal nuked it\n",
-			__func__, shadow_pkru);
-	last_pkru_faults = pkru_faults;
+	__write_pkey_reg(shadow_pkey_reg);
+	dprintf1("%s() set pkey_reg=%x to restore state after signal "
+		       "nuked it\n", __func__, shadow_pkey_reg);
+	last_pkey_faults = pkey_faults;
 	last_si_pkey = -1;
 }
 
-#define do_not_expect_pk_fault(msg)	do {			\
-	if (last_pkru_faults != pkru_faults)			\
-		dprintf0("unexpected PK fault: %s\n", msg);	\
-	pkey_assert(last_pkru_faults == pkru_faults);		\
+#define do_not_expect_pkey_fault(msg)	do {			\
+	if (last_pkey_faults != pkey_faults)			\
+		dprintf0("unexpected PKey fault: %s\n", msg);	\
+	pkey_assert(last_pkey_faults == pkey_faults);		\
 } while (0)
 
 int test_fds[10] = { -1 };
@@ -1015,25 +1026,25 @@ void test_read_of_access_disabled_region(int *ptr, u16 pkey)
 	int ptr_contents;
 
 	dprintf1("disabling access to PKEY[%02d], doing read @ %p\n", pkey, ptr);
-	rdpkru();
+	read_pkey_reg();
 	pkey_access_deny(pkey);
 	ptr_contents = read_ptr(ptr);
 	dprintf1("*ptr: %d\n", ptr_contents);
-	expected_pk_fault(pkey);
+	expected_pkey_fault(pkey);
 }
 void test_write_of_write_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling write access to PKEY[%02d], doing write\n", pkey);
 	pkey_write_deny(pkey);
 	*ptr = __LINE__;
-	expected_pk_fault(pkey);
+	expected_pkey_fault(pkey);
 }
 void test_write_of_access_disabled_region(int *ptr, u16 pkey)
 {
 	dprintf1("disabling access to PKEY[%02d], doing write\n", pkey);
 	pkey_access_deny(pkey);
 	*ptr = __LINE__;
-	expected_pk_fault(pkey);
+	expected_pkey_fault(pkey);
 }
 void test_kernel_write_of_access_disabled_region(int *ptr, u16 pkey)
 {
@@ -1160,9 +1171,10 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 		int new_pkey;
 		dprintf1("%s() alloc loop: %d\n", __func__, i);
 		new_pkey = alloc_pkey();
-		dprintf4("%s()::%d, err: %d pkru: 0x%x shadow: 0x%x\n", __func__,
-				__LINE__, err, __rdpkru(), shadow_pkru);
-		rdpkru(); /* for shadow checking */
+		dprintf4("%s()::%d, err: %d pkey_reg: 0x%x shadow: 0x%x\n",
+				__func__, __LINE__, err, __read_pkey_reg(),
+				shadow_pkey_reg);
+		read_pkey_reg(); /* for shadow checking */
 		dprintf2("%s() errno: %d ENOSPC: %d\n", __func__, errno, ENOSPC);
 		if ((new_pkey == -1) && (errno == ENOSPC)) {
 			dprintf2("%s() failed to allocate pkey after %d tries\n",
@@ -1201,7 +1213,7 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
 		pkey_assert(!err);
-		rdpkru(); /* for shadow checking */
+		read_pkey_reg(); /* for shadow checking */
 	}
 }
 
@@ -1287,7 +1299,7 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	pkey_assert(ret != -1);
 	/* Now access from the current task, and expect an exception: */
 	peek_result = read_ptr(ptr);
-	expected_pk_fault(pkey);
+	expected_pkey_fault(pkey);
 
 	/*
 	 * Try to access the NON-pkey-protected "plain_ptr" via ptrace:
@@ -1297,7 +1309,7 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	pkey_assert(ret != -1);
 	/* Now access from the current task, and expect NO exception: */
 	peek_result = read_ptr(plain_ptr);
-	do_not_expect_pk_fault("read plain pointer after ptrace");
+	do_not_expect_pkey_fault("read plain pointer after ptrace");
 
 	ret = ptrace(PTRACE_DETACH, child_pid, ignored, 0);
 	pkey_assert(ret != -1);
@@ -1347,17 +1359,17 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	pkey_assert(!ret);
 	pkey_access_deny(pkey);
 
-	dprintf2("pkru: %x\n", rdpkru());
+	dprintf2("pkey_reg: %x\n", read_pkey_reg());
 
 	/*
 	 * Make sure this is an *instruction* fault
 	 */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
-	do_not_expect_pk_fault("executing on PROT_EXEC memory");
+	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
 	ptr_contents = read_ptr(p1);
 	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
-	expected_pk_fault(pkey);
+	expected_pkey_fault(pkey);
 }
 
 void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
@@ -1378,15 +1390,15 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
 	pkey_assert(!ret);
 
-	dprintf2("pkru: %x\n", rdpkru());
+	dprintf2("pkru: %x\n", read_pkey_reg());
 
 	/* Make sure this is an *instruction* fault */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
-	do_not_expect_pk_fault("executing on PROT_EXEC memory");
+	do_not_expect_pkey_fault("executing on PROT_EXEC memory");
 	ptr_contents = read_ptr(p1);
 	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
-	expected_pk_fault(UNKNOWN_PKEY);
+	expected_pkey_fault(UNKNOWN_PKEY);
 
 	/*
 	 * Put the memory back to non-PROT_EXEC.  Should clear the
@@ -1400,7 +1412,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	ret = mprotect(p1, PAGE_SIZE, PROT_READ|PROT_EXEC);
 	pkey_assert(!ret);
 	ptr_contents = read_ptr(p1);
-	do_not_expect_pk_fault("plain read on recently PROT_EXEC area");
+	do_not_expect_pkey_fault("plain read on recently PROT_EXEC area");
 }
 
 void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
@@ -1442,7 +1454,7 @@ void run_tests_once(void)
 
 	for (test_nr = 0; test_nr < ARRAY_SIZE(pkey_tests); test_nr++) {
 		int pkey;
-		int orig_pkru_faults = pkru_faults;
+		int orig_pkey_faults = pkey_faults;
 
 		dprintf1("======================\n");
 		dprintf1("test %d preparing...\n", test_nr);
@@ -1457,8 +1469,8 @@ void run_tests_once(void)
 		free_pkey_malloc(ptr);
 		sys_pkey_free(pkey);
 
-		dprintf1("pkru_faults: %d\n", pkru_faults);
-		dprintf1("orig_pkru_faults: %d\n", orig_pkru_faults);
+		dprintf1("pkey_faults: %d\n", pkey_faults);
+		dprintf1("orig_pkey_faults: %d\n", orig_pkey_faults);
 
 		tracing_off();
 		close_test_fds();
@@ -1471,7 +1483,7 @@ void run_tests_once(void)
 
 void pkey_setup_shadow(void)
 {
-	shadow_pkru = __rdpkru();
+	shadow_pkey_reg = __read_pkey_reg();
 }
 
 int main(void)
@@ -1495,7 +1507,7 @@ int main(void)
 	}
 
 	pkey_setup_shadow();
-	printf("startup pkru: %x\n", rdpkru());
+	printf("startup pkey_reg: %x\n", read_pkey_reg());
 	setup_hugetlbfs();
 
 	while (nr_iterations-- > 0)
-- 
2.17.1

