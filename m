Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A79185C18
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfHHHwh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 03:52:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731592AbfHHHwb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Aug 2019 03:52:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x787qREJ073729
        for <linux-arch@vger.kernel.org>; Thu, 8 Aug 2019 03:52:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u8efh32ue-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 08 Aug 2019 03:52:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 8 Aug 2019 08:52:16 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 8 Aug 2019 08:52:12 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x787qBCv41943078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Aug 2019 07:52:11 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 636E842045;
        Thu,  8 Aug 2019 07:52:11 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B04B142047;
        Thu,  8 Aug 2019 07:52:09 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Aug 2019 07:52:09 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 08 Aug 2019 10:52:09 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/3] mm: remove quicklist page table caches
Date:   Thu,  8 Aug 2019 10:52:05 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19080807-0020-0000-0000-0000035D2ABA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080807-0021-0000-0000-000021B22C72
Message-Id: <1565250728-21721-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080090
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

I while ago Nicholas proposed to remove quicklist page table caches [1].

I've rebased his patch on the curren upstream and switched ia64 and sh to
use generic versions of PTE allocation.

[1] https://lore.kernel.org/linux-mm/20190711030339.20892-1-npiggin@gmail.com

Mike Rapoport (2):
  ia64: switch to generic version of pte allocation
  sh: switch to generic version of pte allocation

Nicholas Piggin (1):
  mm: remove quicklist page table caches

 arch/alpha/include/asm/pgalloc.h      |   2 -
 arch/arc/include/asm/pgalloc.h        |   1 -
 arch/arm/include/asm/pgalloc.h        |   2 -
 arch/arm64/include/asm/pgalloc.h      |   2 -
 arch/csky/include/asm/pgalloc.h       |   2 -
 arch/hexagon/include/asm/pgalloc.h    |   2 -
 arch/ia64/Kconfig                     |   4 --
 arch/ia64/include/asm/pgalloc.h       |  52 +++--------------
 arch/m68k/include/asm/pgtable_mm.h    |   2 -
 arch/m68k/include/asm/pgtable_no.h    |   2 -
 arch/microblaze/include/asm/pgalloc.h |  89 +++--------------------------
 arch/microblaze/mm/pgtable.c          |   4 --
 arch/mips/include/asm/pgalloc.h       |   2 -
 arch/nds32/include/asm/pgalloc.h      |   2 -
 arch/nios2/include/asm/pgalloc.h      |   2 -
 arch/openrisc/include/asm/pgalloc.h   |   2 -
 arch/parisc/include/asm/pgalloc.h     |   2 -
 arch/powerpc/include/asm/pgalloc.h    |   2 -
 arch/riscv/include/asm/pgalloc.h      |   4 --
 arch/s390/include/asm/pgtable.h       |   1 -
 arch/sh/include/asm/pgalloc.h         |  44 +--------------
 arch/sh/mm/Kconfig                    |   3 -
 arch/sparc/include/asm/pgalloc_32.h   |   2 -
 arch/sparc/include/asm/pgalloc_64.h   |   2 -
 arch/sparc/mm/init_32.c               |   1 -
 arch/um/include/asm/pgalloc.h         |   2 -
 arch/unicore32/include/asm/pgalloc.h  |   2 -
 arch/x86/include/asm/pgtable_32.h     |   1 -
 arch/x86/include/asm/pgtable_64.h     |   1 -
 arch/xtensa/include/asm/tlbflush.h    |   3 -
 fs/proc/meminfo.c                     |   4 --
 include/asm-generic/pgalloc.h         |   5 --
 include/linux/quicklist.h             |  94 -------------------------------
 kernel/sched/idle.c                   |   1 -
 lib/show_mem.c                        |   5 --
 mm/Kconfig                            |   5 --
 mm/Makefile                           |   1 -
 mm/mmu_gather.c                       |   2 -
 mm/quicklist.c                        | 103 ----------------------------------
 39 files changed, 16 insertions(+), 446 deletions(-)
 delete mode 100644 include/linux/quicklist.h
 delete mode 100644 mm/quicklist.c

-- 
2.7.4

