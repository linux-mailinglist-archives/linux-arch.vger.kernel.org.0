Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C575B13D484
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 07:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgAPGqF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 01:46:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725973AbgAPGqE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Jan 2020 01:46:04 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00G6im9u003774;
        Thu, 16 Jan 2020 01:45:46 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xj5xb7pk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 01:45:46 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00G6fwKk027331;
        Thu, 16 Jan 2020 06:45:44 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2xf758ev9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 06:45:44 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00G6jhj651446222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 06:45:43 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF76C6E04E;
        Thu, 16 Jan 2020 06:45:42 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81A3B6E056;
        Thu, 16 Jan 2020 06:45:39 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.45.56])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jan 2020 06:45:39 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org,
        mpe@ellerman.id.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 0/9] Fixup page directory freeing
Date:   Thu, 16 Jan 2020 12:15:22 +0530
Message-Id: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_02:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=2
 malwarescore=0 priorityscore=1501 mlxlogscore=523 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160055
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
easy to backport these changes. Only the first 2 patches need to be backported to stable. 

The thing is, on anything SMP, freeing page directories should observe the
exact same order as normal page freeing:

 1) unhook page/directory
 2) TLB invalidate
 3) free page/directory

Without this, any concurrent page-table walk could end up with a Use-after-Free.
This is esp. trivial for anything that has software page-table walkers
(HAVE_FAST_GUP / software TLB fill) or the hardware caches partial page-walks
(ie. caches page directories).

Even on UP this might give issues since mmu_gather is preemptible these days.
An interrupt or preempted task accessing user pages might stumble into the free
page if the hardware caches page directories.

This patch series fixup ppc64 and add generic MMU_GATHER changes to support the conversion of other architectures.
I haven't added patches w.r.t other architecture because they are yet to be acked.

Changes from V3:
* Added Cc:stable for first two patches
* Explained why we have sparc related changes in patch 2

Aneesh Kumar K.V (1):
  powerpc/mmu_gather: Enable RCU_TABLE_FREE even for !SMP case

Peter Zijlstra (8):
  mm/mmu_gather: Invalidate TLB correctly on batch allocation failure
    and flush
  asm-generic/tlb: Avoid potential double flush
  asm-gemeric/tlb: Remove stray function declarations
  asm-generic/tlb: Add missing CONFIG symbol
  asm-generic/tlb: Rename HAVE_RCU_TABLE_FREE
  asm-generic/tlb: Rename HAVE_MMU_GATHER_PAGE_SIZE
  asm-generic/tlb: Rename HAVE_MMU_GATHER_NO_GATHER
  asm-generic/tlb: Provide MMU_GATHER_TABLE_FREE

 arch/Kconfig                                 |  13 +-
 arch/arm/Kconfig                             |   2 +-
 arch/arm/include/asm/tlb.h                   |   4 -
 arch/arm64/Kconfig                           |   2 +-
 arch/powerpc/Kconfig                         |   5 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h |   8 --
 arch/powerpc/include/asm/book3s/64/pgalloc.h |   2 -
 arch/powerpc/include/asm/nohash/pgalloc.h    |   8 --
 arch/powerpc/include/asm/tlb.h               |  11 ++
 arch/powerpc/mm/book3s64/pgtable.c           |   7 -
 arch/s390/Kconfig                            |   4 +-
 arch/sparc/Kconfig                           |   3 +-
 arch/sparc/include/asm/tlb_64.h              |   9 ++
 arch/x86/Kconfig                             |   2 +-
 arch/x86/include/asm/tlb.h                   |   4 +-
 include/asm-generic/tlb.h                    | 120 ++++++++++-------
 mm/gup.c                                     |   2 +-
 mm/mmu_gather.c                              | 134 +++++++++++++------
 18 files changed, 207 insertions(+), 133 deletions(-)

-- 
2.24.1

