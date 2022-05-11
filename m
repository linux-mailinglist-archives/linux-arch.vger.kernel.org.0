Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7D52326C
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiEKMEm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 08:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiEKMEl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 08:04:41 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8A592318;
        Wed, 11 May 2022 05:04:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0VCw.G9V_1652270670;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCw.G9V_1652270670)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 20:04:31 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     catalin.marinas@arm.com, will@kernel.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 0/3] Fix CONT-PTE/PMD size hugetlb issue when unmapping or migrating
Date:   Wed, 11 May 2022 20:04:16 +0800
Message-Id: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Now migrating a hugetlb page or unmapping a poisoned hugetlb page, we'll
use ptep_clear_flush() and set_pte_at() to nuke the page table entry
and remap it, and this is incorrect for CONT-PTE or CONT-PMD size hugetlb
page, which will cause potential data consistent issue. This patch set
will change to use hugetlb related APIs to fix this issue, please find
details in each patch. Thanks.

Note: Mike pointed out the huge_ptep_get() will only return the one specific
value, and it would not take into account the dirty or young bits of CONT-PTE/PMDs
like the huge_ptep_get_and_clear() [1]. This inconsistent issue is not introduced
by this patch set, and will address this issue in another thread [2]. Meanwhile
the uffd for hugetlb case [3] pointed by Gerald also need another patch to address.

[1] https://lore.kernel.org/linux-mm/85bd80b4-b4fd-0d3f-a2e5-149559f2f387@oracle.com/
[2] https://lore.kernel.org/all/cover.1651998586.git.baolin.wang@linux.alibaba.com/
[3] https://lore.kernel.org/linux-mm/20220503120343.6264e126@thinkpad/

Changes from v3:
 - Fix building errors for !CONFIG_MMU.

Changes from v2:
 - Collect reviewed tags from Muchun and Mike.
 - Drop the unnecessary casting in hugetlb.c.
 - Fix building errors with adding dummy functions for !CONFIG_HUGETLB_PAGE.

Changes from v1:
 - Add acked tag from Mike.
 - Update some commit message.
 - Add VM_BUG_ON in try_to_unmap() for hugetlb case.
 - Add an explict void casting for huge_ptep_clear_flush() in hugetlb.c.

Baolin Wang (3):
  mm: change huge_ptep_clear_flush() to return the original pte
  mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when migration
  mm: rmap: Fix CONT-PTE/PMD size hugetlb issue when unmapping

 arch/arm64/include/asm/hugetlb.h   |  4 +--
 arch/arm64/mm/hugetlbpage.c        | 12 +++-----
 arch/ia64/include/asm/hugetlb.h    |  5 +--
 arch/mips/include/asm/hugetlb.h    |  9 ++++--
 arch/parisc/include/asm/hugetlb.h  |  5 +--
 arch/powerpc/include/asm/hugetlb.h |  9 ++++--
 arch/s390/include/asm/hugetlb.h    |  6 ++--
 arch/sh/include/asm/hugetlb.h      |  5 +--
 arch/sparc/include/asm/hugetlb.h   |  5 +--
 include/asm-generic/hugetlb.h      |  4 +--
 include/linux/hugetlb.h            | 11 +++++++
 mm/rmap.c                          | 63 ++++++++++++++++++++++++--------------
 12 files changed, 87 insertions(+), 51 deletions(-)

-- 
1.8.3.1

