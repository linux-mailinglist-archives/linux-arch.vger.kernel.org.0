Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64A011992CB
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgCaJ6m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 05:58:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730182AbgCaJ6l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 05:58:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V9YKft093363
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 303vfh2wvb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 31 Mar 2020 10:58:24 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 10:58:19 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02V9wW3L44957712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 09:58:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA854C04E;
        Tue, 31 Mar 2020 09:58:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47DD84C046;
        Tue, 31 Mar 2020 09:58:29 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 09:58:29 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
        fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        shuah@kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v19 01/24] selftests/x86/pkeys: Move selftests to arch-neutral directory
Date:   Tue, 31 Mar 2020 15:28:02 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1585646528.git.sandipan@linux.ibm.com>
References: <cover.1585646528.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20033109-0020-0000-0000-000003BED755
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033109-0021-0000-0000-000022177725
Message-Id: <14d25194c3e2e652e0047feec4487e269e76e8c9.1585646528.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=1 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310081
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>

cc: Dave Hansen <dave.hansen@intel.com>
cc: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/.gitignore                 | 1 +
 tools/testing/selftests/vm/Makefile                   | 1 +
 tools/testing/selftests/{x86 => vm}/pkey-helpers.h    | 0
 tools/testing/selftests/{x86 => vm}/protection_keys.c | 0
 tools/testing/selftests/x86/.gitignore                | 1 -
 tools/testing/selftests/x86/Makefile                  | 2 +-
 6 files changed, 3 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/{x86 => vm}/pkey-helpers.h (100%)
 rename tools/testing/selftests/{x86 => vm}/protection_keys.c (100%)

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31b3c98b6d34d..c55837bf39fa4 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -14,3 +14,4 @@ virtual_address_range
 gup_benchmark
 va_128TBswitch
 map_fixed_noreplace
+protection_keys
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 7f9a8a8c31da9..4e9c741be6af2 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -18,6 +18,7 @@ TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += userfaultfd
+TEST_GEN_FILES += protection_keys
 
 ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 ppc64 riscv64 s390x sh64 sparc64 x86_64))
 TEST_GEN_FILES += va_128TBswitch
diff --git a/tools/testing/selftests/x86/pkey-helpers.h b/tools/testing/selftests/vm/pkey-helpers.h
similarity index 100%
rename from tools/testing/selftests/x86/pkey-helpers.h
rename to tools/testing/selftests/vm/pkey-helpers.h
diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
similarity index 100%
rename from tools/testing/selftests/x86/protection_keys.c
rename to tools/testing/selftests/vm/protection_keys.c
diff --git a/tools/testing/selftests/x86/.gitignore b/tools/testing/selftests/x86/.gitignore
index 7757f73ff9a32..eb30ffd838768 100644
--- a/tools/testing/selftests/x86/.gitignore
+++ b/tools/testing/selftests/x86/.gitignore
@@ -11,5 +11,4 @@ ldt_gdt
 iopl
 mpx-mini-test
 ioperm
-protection_keys
 test_vdso
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5d49bfec1e9ae..5f16821c7f63a 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -12,7 +12,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
-			protection_keys test_vdso test_vsyscall mov_ss_trap \
+			test_vdso test_vsyscall mov_ss_trap \
 			syscall_arg_fault
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
-- 
2.17.1

