Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6AE14D682
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 07:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgA3Ghf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 01:37:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgA3Ghf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:37:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6bXf4014756
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:37:34 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xueh6txta-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:37:34 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:37:24 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 06:37:19 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00U6aQMQ38732274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 06:36:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 203A84C050;
        Thu, 30 Jan 2020 06:37:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 928304C044;
        Thu, 30 Jan 2020 06:37:15 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 06:37:15 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com,
        dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
Subject: [PATCH v18 03/24] selftests/vm/pkeys: Move generic definitions to header file
Date:   Thu, 30 Jan 2020 12:06:45 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20013006-0008-0000-0000-0000034DFAF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013006-0009-0000-0000-00004A6E7A25
Message-Id: <e82abb1f9b6e0ea2f28b70e4e5beee66b198f781.1580365432.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_01:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300042
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

Moved all the generic definition and helper functions to the
header file.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-helpers.h    | 35 +++++++++++++++++---
 tools/testing/selftests/vm/protection_keys.c | 27 ---------------
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/vm/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
index d5779be4793f..6ad1bd54ef94 100644
--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -13,6 +13,14 @@
 #include <ucontext.h>
 #include <sys/mman.h>
 
+/* Define some kernel-like types */
+#define  u8 uint8_t
+#define u16 uint16_t
+#define u32 uint32_t
+#define u64 uint64_t
+
+#define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
+
 #define NR_PKEYS 16
 #define PKEY_BITS_PER_PKEY 2
 
@@ -53,6 +61,18 @@ static inline void sigsafe_printf(const char *format, ...)
 #define dprintf3(args...) dprintf_level(3, args)
 #define dprintf4(args...) dprintf_level(4, args)
 
+extern void abort_hooks(void);
+#define pkey_assert(condition) do {		\
+	if (!(condition)) {			\
+		dprintf0("assert() at %s::%d test_nr: %d iteration: %d\n", \
+				__FILE__, __LINE__,	\
+				test_nr, iteration_nr);	\
+		dprintf0("errno at assert: %d", errno);	\
+		abort_hooks();			\
+		exit(__LINE__);			\
+	}					\
+} while (0)
+
 extern unsigned int shadow_pkey_reg;
 static inline unsigned int __read_pkey_reg(void)
 {
@@ -137,11 +157,6 @@ static inline void __pkey_write_allow(int pkey, int do_allow_write)
 	dprintf4("pkey_reg now: %08x\n", read_pkey_reg());
 }
 
-#define PROT_PKEY0     0x10            /* protection key value (bit 0) */
-#define PROT_PKEY1     0x20            /* protection key value (bit 1) */
-#define PROT_PKEY2     0x40            /* protection key value (bit 2) */
-#define PROT_PKEY3     0x80            /* protection key value (bit 3) */
-
 #define PAGE_SIZE 4096
 #define MB	(1<<20)
 
@@ -219,4 +234,14 @@ int pkey_reg_xstate_offset(void)
 	return xstate_offset;
 }
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
+#define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
+#define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
+#define ALIGN_PTR_UP(p, ptr_align_to)	\
+	((typeof(p))ALIGN_UP((unsigned long)(p), ptr_align_to))
+#define ALIGN_PTR_DOWN(p, ptr_align_to)	\
+	((typeof(p))ALIGN_DOWN((unsigned long)(p), ptr_align_to))
+#define __stringify_1(x...)     #x
+#define __stringify(x...)       __stringify_1(x)
+
 #endif /* _PKEYS_HELPER_H */
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 2f4ab81c570d..42ffb58810f2 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -51,31 +51,10 @@ int test_nr;
 unsigned int shadow_pkey_reg;
 
 #define HPAGE_SIZE	(1UL<<21)
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof(*(x)))
-#define ALIGN_UP(x, align_to)	(((x) + ((align_to)-1)) & ~((align_to)-1))
-#define ALIGN_DOWN(x, align_to) ((x) & ~((align_to)-1))
-#define ALIGN_PTR_UP(p, ptr_align_to)	((typeof(p))ALIGN_UP((unsigned long)(p),	ptr_align_to))
-#define ALIGN_PTR_DOWN(p, ptr_align_to)	((typeof(p))ALIGN_DOWN((unsigned long)(p),	ptr_align_to))
-#define __stringify_1(x...)     #x
-#define __stringify(x...)       __stringify_1(x)
-
-#define PTR_ERR_ENOTSUP ((void *)-ENOTSUP)
 
 int dprint_in_signal;
 char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
 
-extern void abort_hooks(void);
-#define pkey_assert(condition) do {		\
-	if (!(condition)) {			\
-		dprintf0("assert() at %s::%d test_nr: %d iteration: %d\n", \
-				__FILE__, __LINE__,	\
-				test_nr, iteration_nr);	\
-		dprintf0("errno at assert: %d", errno);	\
-		abort_hooks();			\
-		exit(__LINE__);			\
-	}					\
-} while (0)
-
 void cat_into_file(char *str, char *file)
 {
 	int fd = open(file, O_RDWR);
@@ -186,12 +165,6 @@ void lots_o_noops_around_write(int *write_to_me)
 	dprintf3("%s() done\n", __func__);
 }
 
-/* Define some kernel-like types */
-#define  u8 uint8_t
-#define u16 uint16_t
-#define u32 uint32_t
-#define u64 uint64_t
-
 #ifdef __i386__
 
 #ifndef SYS_mprotect_key
-- 
2.17.1

