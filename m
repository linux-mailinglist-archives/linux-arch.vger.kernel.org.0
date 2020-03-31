Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 405121992D8
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgCaJ66 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 05:58:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730431AbgCaJ66 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 05:58:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V9WdUG110737
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3022juqrn8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 31 Mar 2020 10:58:45 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 10:58:42 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02V9wo2w50659342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 09:58:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 321E14C046;
        Tue, 31 Mar 2020 09:58:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90ABF4C04A;
        Tue, 31 Mar 2020 09:58:47 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 09:58:47 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
        fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        shuah@kernel.org
Subject: [PATCH v19 07/24] selftests: vm: pkeys: Add helpers for pkey bits
Date:   Tue, 31 Mar 2020 15:28:08 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20033109-0008-0000-0000-00000367B4C5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033109-0009-0000-0000-00004A8938E0
Message-Id: <2ad9705f4f68ca7e72155cc583415e5a979546f1.1585646528.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=1
 clxscore=1015 mlxlogscore=665 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310086
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This introduces some functions that help with setting
or clearing bits of a particular pkey. This also adds
an abstraction for getting a pkey's bit position in
the pkey register as this may vary across architectures.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 22 ++++++++++++++
 tools/testing/selftests/vm/pkey-x86.h        |  5 +++
 tools/testing/selftests/vm/protection_keys.c | 32 ++++++--------------
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index dfbce49269ce2..0e3da7c8d6282 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -80,6 +80,28 @@ extern void abort_hooks(void);
 #error Architecture not supported
 #endif /* arch */
 
+#define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+
+static inline u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/* mask out bits from pkey in old value */
+	reg &= ~((u64)PKEY_MASK << shift);
+	/* OR in new bits for pkey */
+	reg |= (flags & PKEY_MASK) << shift;
+	return reg;
+}
+
+static inline u64 get_pkey_bits(u64 reg, int pkey)
+{
+	u32 shift = pkey_bit_position(pkey);
+	/*
+	 * shift down the relevant bits to the lowest two, then
+	 * mask off all the other higher bits
+	 */
+	return ((reg >> shift) & PKEY_MASK);
+}
+
 extern u64 shadow_pkey_reg;
 
 static inline u64 _read_pkey_reg(int line)
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index 6ffea27e2d2d6..def2a1bcf6a5d 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -118,6 +118,11 @@ static inline int cpu_has_pku(void)
 	return 1;
 }
 
+static inline u32 pkey_bit_position(int pkey)
+{
+	return pkey * PKEY_BITS_PER_PKEY;
+}
+
 #define XSTATE_PKEY_BIT	(9)
 #define XSTATE_PKEY	0x200
 
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index efa35cc6f6b9e..bed9d4de12b48 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -334,25 +334,13 @@ pid_t fork_lazy_child(void)
 
 static u32 hw_pkey_get(int pkey, unsigned long flags)
 {
-	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
 	u64 pkey_reg = __read_pkey_reg();
-	u64 shifted_pkey_reg;
-	u32 masked_pkey_reg;
 
 	dprintf1("%s(pkey=%d, flags=%lx) = %x / %d\n",
 			__func__, pkey, flags, 0, 0);
 	dprintf2("%s() raw pkey_reg: %016llx\n", __func__, pkey_reg);
 
-	shifted_pkey_reg = (pkey_reg >> (pkey * PKEY_BITS_PER_PKEY));
-	dprintf2("%s() shifted_pkey_reg: %016llx\n", __func__,
-			shifted_pkey_reg);
-	masked_pkey_reg = shifted_pkey_reg & mask;
-	dprintf2("%s() masked  pkey_reg: %x\n", __func__, masked_pkey_reg);
-	/*
-	 * shift down the relevant bits to the lowest two, then
-	 * mask off all the other high bits.
-	 */
-	return masked_pkey_reg;
+	return (u32) get_pkey_bits(pkey_reg, pkey);
 }
 
 static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
@@ -364,12 +352,8 @@ static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
 	/* make sure that 'rights' only contains the bits we expect: */
 	assert(!(rights & ~mask));
 
-	/* copy old pkey_reg */
-	new_pkey_reg = old_pkey_reg;
-	/* mask out bits from pkey in old value: */
-	new_pkey_reg &= ~(mask << (pkey * PKEY_BITS_PER_PKEY));
-	/* OR in new bits for pkey: */
-	new_pkey_reg |= (rights << (pkey * PKEY_BITS_PER_PKEY));
+	/* modify bits accordingly in old pkey_reg and assign it */
+	new_pkey_reg = set_pkey_bits(old_pkey_reg, pkey, rights);
 
 	__write_pkey_reg(new_pkey_reg);
 
@@ -403,7 +387,7 @@ void pkey_disable_set(int pkey, int flags)
 	ret = hw_pkey_set(pkey, pkey_rights, syscall_flags);
 	assert(!ret);
 	/* pkey_reg and flags have the same format */
-	shadow_pkey_reg |= flags << (pkey * 2);
+	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
 	dprintf1("%s(%d) shadow: 0x%016llx\n",
 		__func__, pkey, shadow_pkey_reg);
 
@@ -437,7 +421,7 @@ void pkey_disable_clear(int pkey, int flags)
 	pkey_rights |= flags;
 
 	ret = hw_pkey_set(pkey, pkey_rights, 0);
-	shadow_pkey_reg &= ~(flags << (pkey * 2));
+	shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, pkey, pkey_rights);
 	pkey_assert(ret >= 0);
 
 	pkey_rights = hw_pkey_get(pkey, syscall_flags);
@@ -513,7 +497,8 @@ int alloc_pkey(void)
 			shadow_pkey_reg);
 	if (ret) {
 		/* clear both the bits: */
-		shadow_pkey_reg &= ~(0x3      << (ret * 2));
+		shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, ret,
+						~PKEY_MASK);
 		dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016llx"
 				" shadow: 0x%016llx\n",
 				__func__,
@@ -523,7 +508,8 @@ int alloc_pkey(void)
 		 * move the new state in from init_val
 		 * (remember, we cheated and init_val == pkey_reg format)
 		 */
-		shadow_pkey_reg |=  (init_val << (ret * 2));
+		shadow_pkey_reg = set_pkey_bits(shadow_pkey_reg, ret,
+						init_val);
 	}
 	dprintf4("%s()::%d, ret: %d pkey_reg: 0x%016llx"
 			" shadow: 0x%016llx\n",
-- 
2.17.1

