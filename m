Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2F4568242
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jul 2022 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiGFI7c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jul 2022 04:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiGFI7b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jul 2022 04:59:31 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612C397;
        Wed,  6 Jul 2022 01:59:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0VIXd7j9_1657097961;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VIXd7j9_1657097961)
          by smtp.aliyun-inc.com;
          Wed, 06 Jul 2022 16:59:22 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     rppt@linux.ibm.com, willy@infradead.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, kernel@xen0n.name,
        tsbogend@alpha.franken.de, dave.hansen@linux.intel.com,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, arnd@arndb.de, guoren@kernel.org,
        monstr@monstr.eu, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        baolin.wang@linux.alibaba.com, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add PUD and kernel PTE level pagetable account
Date:   Wed,  6 Jul 2022 16:59:14 +0800
Message-Id: <cover.1657096412.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Now we will miss to account the PUD level pagetable and kernel PTE level
pagetable, as well as missing to set the PG_table flags for these pagetable
pages, which will get an inaccurate pagetable accounting, and miss
PageTable() validation in some cases. So this patch set introduces new
helpers to help to account PUD and kernel PTE pagetable pages.

Note there are still some architectures specific pagetable allocation
that need to account the pagetable pages, which need more investigation
and cleanup in future.

Changes from RFC v3:
 - Rebased on 20220706 linux-next.
 - Introduce new pgtable_pud_page_ctor/dtor() and rename the helpers.
 - Change back to use inc_lruvec_page_state()/dec_lruvec_page_state().
 - Update some commit message.
link: https://lore.kernel.org/all/cover.1656586863.git.baolin.wang@linux.alibaba.com/

Changes from RFC v2:
 - Convert to use mod_lruvec_page_state() for non-order-0 case.
 - Rename the helpers.
 - Update some commit messages.
 - Remove unnecessary __GFP_HIGHMEM clear.
link: https://lore.kernel.org/all/cover.1655887440.git.baolin.wang@linux.alibaba.com/

Changes from RFC v1:
 - Update some commit message.
 - Add missing pgtable_clear_and_dec() on X86 arch.
 - Use __free_page() to free pagetable which can avoid duplicated virt_to_page().
link: https://lore.kernel.org/all/cover.1654271618.git.baolin.wang@linux.alibaba.com/

Baolin Wang (3):
  mm: Factor out the pagetable pages account into new helper function
  mm: Add PUD level pagetable account
  mm: Add kernel PTE level pagetable pages account

 arch/arm64/include/asm/tlb.h         |  5 ++++-
 arch/csky/include/asm/pgalloc.h      |  2 +-
 arch/loongarch/include/asm/pgalloc.h | 12 +++++++++---
 arch/microblaze/mm/pgtable.c         |  2 +-
 arch/mips/include/asm/pgalloc.h      | 12 +++++++++---
 arch/openrisc/mm/ioremap.c           |  2 +-
 arch/x86/mm/pgtable.c                |  7 +++++--
 include/asm-generic/pgalloc.h        | 26 ++++++++++++++++++++++----
 include/linux/mm.h                   | 34 ++++++++++++++++++++++++++--------
 9 files changed, 78 insertions(+), 24 deletions(-)

-- 
1.8.3.1

