Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0F4140A18
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 13:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAQMu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 07:50:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64056 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726890AbgAQMu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jan 2020 07:50:58 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HClEUY058590
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qsmb6j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 17 Jan 2020 07:50:57 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Fri, 17 Jan 2020 12:50:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 12:50:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00HComeG36176110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 12:50:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 938A852059;
        Fri, 17 Jan 2020 12:50:48 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2D98352054;
        Fri, 17 Jan 2020 12:50:46 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v16 16/23] selftests/vm/pkeys: Improve checks to determine pkey support
Date:   Fri, 17 Jan 2020 18:19:55 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1579265066.git.sandipan@linux.ibm.com>
References: <cover.1579265066.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20011712-0016-0000-0000-000002DE4385
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011712-0017-0000-0000-00003340DF61
Message-Id: <0dfcb9e184190bc9f3928031113085e0cd28d844.1579265066.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_03:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=775
 malwarescore=0 suspectscore=2 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170102
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

For the pkeys subsystem to work, both the CPU and the
kernel need to have support. So, additionally check if
the kernel supports pkeys apart from the CPU feature
checks.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 30 ++++++++++++++++++++
 tools/testing/selftests/vm/pkey-powerpc.h    |  3 +-
 tools/testing/selftests/vm/pkey-x86.h        |  2 +-
 tools/testing/selftests/vm/protection_keys.c |  7 +++--
 4 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index ec3f87d53b7d..ac9076136fc8 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -76,6 +76,8 @@ extern void abort_hooks(void);
 
 __attribute__((noinline)) int read_ptr(int *ptr);
 void expected_pkey_fault(int pkey);
+int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
+int sys_pkey_free(unsigned long pkey);
 
 #if defined(__i386__) || defined(__x86_64__) /* arch */
 #include "pkey-x86.h"
@@ -186,4 +188,32 @@ static inline u32 *siginfo_get_pkey_ptr(siginfo_t *si)
 #endif
 }
 
+static inline int kernel_has_pkeys(void)
+{
+	/* try allocating a key and see if it succeeds */
+	int ret = sys_pkey_alloc(0, 0);
+	if (ret <= 0) {
+		return 0;
+	}
+	sys_pkey_free(ret);
+	return 1;
+}
+
+static inline int is_pkeys_supported(void)
+{
+	/* check if the cpu supports pkeys */
+	if (!cpu_has_pkeys()) {
+		dprintf1("SKIP: %s: no CPU support\n", __func__);
+		return 0;
+	}
+
+	/* check if the kernel supports pkeys */
+	if (!kernel_has_pkeys()) {
+		dprintf1("SKIP: %s: no kernel support\n", __func__);
+		return 0;
+	}
+
+	return 1;
+}
+
 #endif /* _PKEYS_HELPER_H */
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index eaced8c198a2..a5e5157c4f7e 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -63,8 +63,9 @@ static inline void __write_pkey_reg(u64 pkey_reg)
 			__func__, __read_pkey_reg(), pkey_reg);
 }
 
-static inline int cpu_has_pku(void)
+static inline int cpu_has_pkeys(void)
 {
+	/* No simple way to determine this */
 	return 1;
 }
 
diff --git a/tools/testing/selftests/vm/pkey-x86.h b/tools/testing/selftests/vm/pkey-x86.h
index 296151309a30..207e8c180f39 100644
--- a/tools/testing/selftests/vm/pkey-x86.h
+++ b/tools/testing/selftests/vm/pkey-x86.h
@@ -97,7 +97,7 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 #define X86_FEATURE_PKU        (1<<3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE      (1<<4) /* OS Protection Keys Enable */
 
-static inline int cpu_has_pku(void)
+static inline int cpu_has_pkeys(void)
 {
 	unsigned int eax;
 	unsigned int ebx;
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index a91d11c6a0ec..4a0677e618ac 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1377,7 +1377,7 @@ void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 	int size = PAGE_SIZE;
 	int sret;
 
-	if (cpu_has_pku()) {
+	if (cpu_has_pkeys()) {
 		dprintf1("SKIP: %s: no CPU support\n", __func__);
 		return;
 	}
@@ -1446,12 +1446,13 @@ void pkey_setup_shadow(void)
 int main(void)
 {
 	int nr_iterations = 22;
+	int pkeys_supported = is_pkeys_supported();
 
 	setup_handlers();
 
-	printf("has pku: %d\n", cpu_has_pku());
+	printf("has pkeys: %d\n", pkeys_supported);
 
-	if (!cpu_has_pku()) {
+	if (!pkeys_supported) {
 		int size = PAGE_SIZE;
 		int *ptr;
 
-- 
2.17.1

