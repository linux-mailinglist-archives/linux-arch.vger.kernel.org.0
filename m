Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16063124093
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2019 08:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRHwI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Dec 2019 02:52:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfLRHwI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Dec 2019 02:52:08 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBI7lMM5004871
        for <linux-arch@vger.kernel.org>; Wed, 18 Dec 2019 02:52:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wybqph051-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 18 Dec 2019 02:52:06 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <sandipan@linux.ibm.com>;
        Wed, 18 Dec 2019 07:52:04 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 07:52:00 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBI7pxxJ9240750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 07:51:59 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2000AAE058;
        Wed, 18 Dec 2019 07:51:59 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C31F9AE04D;
        Wed, 18 Dec 2019 07:51:56 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Dec 2019 07:51:56 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, fweimer@redhat.com,
        dave.hansen@intel.com, x86@kernel.org, linuxram@us.ibm.com,
        mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        msuchanek@suse.de, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v15 00/24] selftests, powerpc, x86: Memory Protection Keys
Date:   Wed, 18 Dec 2019 13:21:33 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19121807-4275-0000-0000-000003903973
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121807-4276-0000-0000-000038A401AC
Message-Id: <cover.1576645161.git.sandipan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_01:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=898 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180062
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Memory protection keys enables an application to protect its address
space from inadvertent access by its own code.

This feature is now enabled on powerpc and has been available since
4.16-rc1. The patches move the selftests to arch neutral directory
and enhance their test coverage.

Testing
-------
Verified for correctness on powerpc. Need help with x86 testing as I
do not have access to a Skylake server. Client platforms like Coffee
Lake do not have the required feature bits set in CPUID.

Changelog
---------
Link to previous version (v14):
https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=55981&state=*

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

Ram Pai (17):
  selftests/x86/pkeys: Move selftests to arch-neutral directory
  selftests/vm/pkeys: Rename all references to pkru to a generic name
  selftests/vm/pkeys: Move generic definitions to header file
  selftests/vm/pkeys: Typecast the pkey register
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

Sandipan Das (3):
  selftests: vm: pkeys: Add helpers for pkey bits
  selftests: vm: pkeys: Use the correct huge page size
  selftests: vm: pkeys: Use the correct page size on powerpc

Thiago Jung Bauermann (2):
  selftests/vm/pkeys: Move some definitions to arch-specific header
  selftests/vm/pkeys: Make gcc check arguments of sigsafe_printf()

 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   5 +
 tools/testing/selftests/vm/pkey-helpers.h     | 226 ++++++
 tools/testing/selftests/vm/pkey-powerpc.h     | 138 ++++
 tools/testing/selftests/vm/pkey-x86.h         | 183 +++++
 .../selftests/{x86 => vm}/protection_keys.c   | 688 ++++++++++--------
 tools/testing/selftests/x86/.gitignore        |   1 -
 tools/testing/selftests/x86/pkey-helpers.h    | 219 ------
 8 files changed, 931 insertions(+), 530 deletions(-)
 create mode 100644 tools/testing/selftests/vm/pkey-helpers.h
 create mode 100644 tools/testing/selftests/vm/pkey-powerpc.h
 create mode 100644 tools/testing/selftests/vm/pkey-x86.h
 rename tools/testing/selftests/{x86 => vm}/protection_keys.c (74%)
 delete mode 100644 tools/testing/selftests/x86/pkey-helpers.h

-- 
2.17.1

