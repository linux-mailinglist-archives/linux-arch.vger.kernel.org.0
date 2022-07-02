Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7C1563EFC
	for <lists+linux-arch@lfdr.de>; Sat,  2 Jul 2022 09:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiGBH7V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Jul 2022 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiGBH7U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jul 2022 03:59:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825331AF33;
        Sat,  2 Jul 2022 00:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A50EECE08CB;
        Sat,  2 Jul 2022 07:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F483C34114;
        Sat,  2 Jul 2022 07:59:11 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Feiyang Chen <chenfeiyang@loongson.cn>
Subject: [PATCH V3 0/4] mm/sparse-vmemmap: Generalise helpers and enable for LoongArch
Date:   Sat,  2 Jul 2022 16:00:17 +0800
Message-Id: <20220702080021.1167190-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series is in order to enable sparse-vmemmap for LoongArch. But
LoongArch cannot use generic helpers directly because MIPS&LoongArch
need to call pgd_init()/pud_init()/pmd_init() when populating page
tables. So we adjust the prototypes of p?d_init() to make generic
helpers can call them, then enable sparse-vmemmap with generic helpers,
and to be further, generalise vmemmap_populate_hugepages() for ARM64,
X86 and LoongArch.

V1 -> V2:
Split ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP to a separate patch.

V2 -> V3:
1, Change the Signed-off-by order of author and committer;
2, Update commit message about the build error on LoongArch.

Huacai Chen and Feiyang Chen(4):
 MIPS&LoongArch: Adjust prototypes of p?d_init().
 LoongArch: Add sparse memory vmemmap support.
 mm/sparse-vmemmap: Generalise vmemmap_populate_hugepages().
 LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn> 
---
 arch/arm64/mm/mmu.c                    | 53 ++++++--------------
 arch/loongarch/Kconfig                 |  2 +
 arch/loongarch/include/asm/pgalloc.h   | 13 +----
 arch/loongarch/include/asm/pgtable.h   | 13 +++--
 arch/loongarch/include/asm/sparsemem.h |  8 +++
 arch/loongarch/kernel/numa.c           |  4 +-
 arch/loongarch/mm/init.c               | 44 +++++++++++++++-
 arch/loongarch/mm/pgtable.c            | 23 +++++----
 arch/mips/include/asm/pgalloc.h        |  8 +--
 arch/mips/include/asm/pgtable-64.h     |  8 +--
 arch/mips/kvm/mmu.c                    |  3 +-
 arch/mips/mm/pgtable-32.c              | 10 ++--
 arch/mips/mm/pgtable-64.c              | 18 ++++---
 arch/mips/mm/pgtable.c                 |  2 +-
 arch/x86/mm/init_64.c                  | 92 ++++++++++++----------------------
 include/linux/mm.h                     |  8 +++
 include/linux/page-flags.h             |  1 +
 mm/sparse-vmemmap.c                    | 64 +++++++++++++++++++++++
 18 files changed, 222 insertions(+), 152 deletions(-)
--
2.27.0

