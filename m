Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EFA1425DF
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2020 09:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgATIjI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jan 2020 03:39:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726465AbgATIjI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jan 2020 03:39:08 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00K8d0uo121523
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:39:07 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xmg39fyke-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 20 Jan 2020 03:39:05 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Mon, 20 Jan 2020 08:36:51 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Jan 2020 08:36:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00K8akch62390464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jan 2020 08:36:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD06011C052;
        Mon, 20 Jan 2020 08:36:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 598CC11C050;
        Mon, 20 Jan 2020 08:36:44 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jan 2020 08:36:44 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v17 08/24] selftests: vm: pkeys: Add helpers for pkey bits
Date:   Mon, 20 Jan 2020 14:06:05 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579507768.git.sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012008-0016-0000-0000-000002DEF938
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012008-0017-0000-0000-000033419BC0
Message-Id: <ece81867019cf4a6c4680e1e2d4254ef11e42a3f.1579507768.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-19_08:2020-01-16,2020-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=624 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001200077
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This introduces some functions that help with setting
or clearing bits of a particular pkey. This also adds
an abstraction for getting a pkey's bit position in
the pkey register as this may vary across architectures.

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 22 ++++++++++++++
 tools/testing/selftests/vm/pkey-x86.h        |  5 +++
 tools/testing/selftests/vm/protection_keys.c | 32 ++++++--------------
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index dfbce49269ce..0e3da7c8d628 100644
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
index 6ffea27e2d2d..def2a1bcf6a5 100644
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
index efa35cc6f6b9..bed9d4de12b4 100644
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

