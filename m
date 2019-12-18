Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F801240C1
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 08:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfLRHxI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 02:53:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725882AbfLRHxI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 02:53:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI7qtbb048490
        for <linux-arch@vger.kernel.org>; Wed, 18 Dec 2019 02:53:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wybqph0xn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 18 Dec 2019 02:53:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 18 Dec 2019 07:53:04 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 07:53:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBI7qxXe25100334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 07:52:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 405A3AE045;
        Wed, 18 Dec 2019 07:52:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA159AE04D;
        Wed, 18 Dec 2019 07:52:56 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 07:52:56 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 23/23] selftests: vm: pkeys: Use the correct page size on powerpc
Date:   Wed, 18 Dec 2019 13:21:56 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1576645161.git.sandipan@linux.ibm.com>
References: <cover.1576645161.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19121807-0012-0000-0000-00000376140A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121807-0013-0000-0000-000021B20162
Message-Id: <ff7c288e2a88ccfb3b79be30967646fe5b869683.1576645161.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_01:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180063
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Both 4K and 64K pages are supported on powerpc. Parts of
the selftest code perform alignment computations based on
the PAGE_SIZE macro which is currently hardcoded to 64K
for powerpc. This causes some test failures on kernels
configured with 4K page size.

This problem is solved by determining the correct page
size during the build process rather than hardcoding it
in the header file.

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
cc: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/Makefile       | 4 ++++
 tools/testing/selftests/vm/pkey-powerpc.h | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 4e9c741be6af..ada3a67eaac6 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -4,6 +4,10 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/')
 
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
+ifneq (,$(filter $(ARCH), ppc64 ppc64le))
+protection_keys: EXTRA_CFLAGS += -DPAGE_SIZE=$(shell getconf PAGESIZE)
+endif
+
 LDLIBS = -lrt
 TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_benchmark
diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index 3cd8e03fd640..07fa9f529014 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -36,7 +36,6 @@
 					     pkey-31 and exec-only key */
 #define PKEY_BITS_PER_PKEY	2
 #define HPAGE_SIZE		(1UL << 24)
-#define PAGE_SIZE		(1UL << 16)
 #define pkey_reg_t		u64
 #define PKEY_REG_FMT		"%016lx"
 
-- 
2.17.1

