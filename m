Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8628514D678
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jan 2020 07:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgA3GhW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jan 2020 01:37:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725847AbgA3GhV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Jan 2020 01:37:21 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00U6Xo5a077897
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:37:20 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xu5q5x7yp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 30 Jan 2020 01:37:20 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Thu, 30 Jan 2020 06:37:18 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 Jan 2020 06:37:14 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00U6bCHL51380350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 06:37:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6680B4C046;
        Thu, 30 Jan 2020 06:37:12 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D408E4C044;
        Thu, 30 Jan 2020 06:37:09 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 06:37:09 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-mm@kvack.org, fweimer@redhat.com,
        dave.hansen@intel.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au
Subject: [PATCH v18 01/24] selftests/x86/pkeys: Move selftests to arch-neutral directory
Date:   Thu, 30 Jan 2020 12:06:43 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1580365432.git.sandipan@linux.ibm.com>
References: <cover.1580365432.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20013006-0012-0000-0000-00000381F229
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20013006-0013-0000-0000-000021BE4B95
Message-Id: <2c7111313a759a9c53807caed4b87cc66df807c3.1580365432.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_01:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300042
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
index 31b3c98b6d34..c55837bf39fa 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -14,3 +14,4 @@ virtual_address_range
 gup_benchmark
 va_128TBswitch
 map_fixed_noreplace
+protection_keys
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 7f9a8a8c31da..4e9c741be6af 100644
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
index 7757f73ff9a3..eb30ffd83876 100644
--- a/tools/testing/selftests/x86/.gitignore
+++ b/tools/testing/selftests/x86/.gitignore
@@ -11,5 +11,4 @@ ldt_gdt
 iopl
 mpx-mini-test
 ioperm
-protection_keys
 test_vdso
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5d49bfec1e9a..5f16821c7f63 100644
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

