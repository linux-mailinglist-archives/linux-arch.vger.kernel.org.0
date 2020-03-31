Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7A241992C9
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 11:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgCaJ6i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Mar 2020 05:58:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729997AbgCaJ6h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 31 Mar 2020 05:58:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02V9X1Rl119146
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 303v2skgkq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 31 Mar 2020 05:58:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Tue, 31 Mar 2020 10:58:24 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Mar 2020 10:58:20 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02V9wTHJ40763428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 09:58:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFCD74C04E;
        Tue, 31 Mar 2020 09:58:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5946C4C04A;
        Tue, 31 Mar 2020 09:58:26 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 09:58:26 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mm@kvack.org,
        fweimer@redhat.com, linuxram@us.ibm.com, mhocko@kernel.org,
        mingo@redhat.com, aneesh.kumar@linux.ibm.com,
        bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        shuah@kernel.org
Subject: [PATCH v19 00/24] selftests, powerpc, x86: Memory Protection Keys
Date:   Tue, 31 Mar 2020 15:28:01 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20033109-0008-0000-0000-00000367B4B4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20033109-0009-0000-0000-00004A8938CE
Message-Id: <cover.1585646528.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_03:2020-03-30,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310086
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Memory protection keys enables an application to protect its address
space from inadvertent access by its own code.

This feature is now enabled on powerpc and has been available since
4.16-rc1. The patches move the selftests to arch neutral directory
and enhance their test coverage.

Tested on powerpc64 and x86_64 (Skylake-SP).

Link to development branch:
https://github.com/sandip4n/linux/tree/pkey-selftests

Resending this based on feedback from maintainers who felt this
can go in via the -mm tree. This has no other changes from the
last version (v18) apart from being rebased.

Changelog
---------
Link to previous version (v18):
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=155970

v19:
	(1) Rebased on top of latest master.

v18:
	(1) Fixed issues with x86 multilib builds based on
	    feedback from Dave.
	(2) Moved patch 2 to the end of the series.

v17:
	(1) Fixed issues with i386 builds when running on x86_64
	    based on feedback from Dave.
	(2) Replaced patch 6 from previous version with patch 7.
	    This addresses u64 format specifier related concerns
	    that Michael had raised in v15.

v16:
	(1) Rebased on top of latest master.
	(2) Switched to u64 instead of using an arch-dependent
	    pkey_reg_t type for references to the pkey register
	    based on suggestions from Dave, Michal and Michael.
	(3) Removed build time determination of page size based
	    on suggestion from Michael.
	(4) Fixed comment before the definition of __page_o_noops()
	    from patch 13 ("selftests/vm/pkeys: Introduce powerpc
	    support").

v15:
	(1) Rebased on top of latest master.
	(2) Addressed review comments from Dave Hansen.
	(3) Moved code for getting or setting pkey bits to new
	    helpers. These changes replace patch 7 of v14.
	(4) Added a fix which ensures that the correct count of
	    reserved keys is used across different platforms.
	(5) Added a fix which ensures that the correct page size
	    is used as powerpc supports both 4K and 64K pages.

v14:
	(1) Incorporated another round of comments from Dave Hansen.

v13:
	(1) Incorporated comments for Dave Hansen.
	(2) Added one more test for correct pkey-0 behavior.

v12:
	(1) Fixed the offset of pkey field in the siginfo structure for
	    x86_64 and powerpc. And tries to use the actual field
	    if the headers have it defined.

v11:
	(1) Fixed a deadlock in the ptrace testcase.

v10 and prior:
	(1) Moved the testcase to arch neutral directory.
	(2) Split the changes into incremental patches.

Desnes A. Nunes do Rosario (1):
  selftests/vm/pkeys: Fix number of reserved powerpc pkeys

Ram Pai (16):
  selftests/x86/pkeys: Move selftests to arch-neutral directory
  selftests/vm/pkeys: Rename all references to pkru to a generic name
  selftests/vm/pkeys: Move generic definitions to header file
  selftests/vm/pkeys: Fix pkey_disable_clear()
  selftests/vm/pkeys: Fix assertion in pkey_disable_set/clear()
  selftests/vm/pkeys: Fix alloc_random_pkey() to make it really random
  selftests/vm/pkeys: Introduce generic pkey abstractions
  selftests/vm/pkeys: Introduce powerpc support
  selftests/vm/pkeys: Fix assertion in test_pkey_alloc_exhaust()
  selftests/vm/pkeys: Improve checks to determine pkey support
  selftests/vm/pkeys: Associate key on a mapped page and detect access
    violation
  selftests/vm/pkeys: Associate key on a mapped page and detect write
    violation
  selftests/vm/pkeys: Detect write violation on a mapped
    access-denied-key page
  selftests/vm/pkeys: Introduce a sub-page allocator
  selftests/vm/pkeys: Test correct behaviour of pkey-0
  selftests/vm/pkeys: Override access right definitions on powerpc

Sandipan Das (5):
  selftests: vm: pkeys: Use sane types for pkey register
  selftests: vm: pkeys: Add helpers for pkey bits
  selftests: vm: pkeys: Use the correct huge page size
  selftests: vm: pkeys: Use the correct page size on powerpc
  selftests: vm: pkeys: Fix multilib builds for x86

Thiago Jung Bauermann (2):
  selftests/vm/pkeys: Move some definitions to arch-specific header
  selftests/vm/pkeys: Make gcc check arguments of sigsafe_printf()

 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |  73 ++
 tools/testing/selftests/vm/pkey-helpers.h     | 225 ++++++
 tools/testing/selftests/vm/pkey-powerpc.h     | 136 ++++
 tools/testing/selftests/vm/pkey-x86.h         | 181 +++++
 .../selftests/{x86 => vm}/protection_keys.c   | 696 ++++++++++--------
 tools/testing/selftests/x86/.gitignore        |   1 -
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/pkey-helpers.h    | 219 ------
 9 files changed, 1002 insertions(+), 532 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/pkey-powerpc.h
 create mode 100644 tools/testing/selftests/vm/pkey-x86.h
 rename tools/testing/selftests/{x86 => vm}/protection_keys.c (74%)
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h

-- 
2.17.1

