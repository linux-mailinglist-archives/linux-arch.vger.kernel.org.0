Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BD113D291
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 04:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgAPDOM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 22:14:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39380 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729472AbgAPDOL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 22:14:11 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D32D92D23A1DF1A05B8C;
        Thu, 16 Jan 2020 11:14:08 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 11:13:58 +0800
From:   Xuefeng Wang <wxf.wang@hisilicon.com>
To:     <arnd@arndb.de>, <akpm@linux-foundation.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH 0/2] mm/thp: rework the pmd protect changing flow
Date:   Thu, 16 Jan 2020 11:09:15 +0800
Message-ID: <1579144157-7736-1-git-send-email-wxf.wang@hisilicon.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On KunPeng920 board. When changing permission of a large range region,
pmdp_invalidate() takes about 65% in profile (with hugepages) in JIT tool.
Kernel will flush tlb twice: first flush happens in pmdp_invalidate, second
flush happens at the end of change_protect_range(). The first pmdp_invalidate
is not necessary if the hardware support atomic pmdp changing. The atomic
changing pimd to zero can prevent the hardware from update asynchronous.
So reconstruct it and remove the first pmdp_invalidate. And the second tlb
flush can make sure the new tlb entry valid.

This patch series add a pmdp_modify_prot transaction abstraction firstly.
Then add pmdp_modify_prot_start() in arm64, which uses pmdp_huge_get_and_clear()
to atomically fetch the pmd and zero the entry.

After rework, the mprotect can get 3~13 times performace gain in range
64M to 512M on KunPeng920:

4K granule/THP on
memory size(M)	64	128	256	320	448	512
pre-patch		0.77	1.40	2.64	3.23	4.49	5.10
post-patch		0.20	0.23	0.28	0.31	0.37	0.39

Xuefeng Wang (2):
  mm: add helpers pmdp_modify_prot_start/commit
  arm64: mm: rework the pmd protect changing flow

 arch/arm64/include/asm/pgtable.h | 14 +++++++++++++
 include/asm-generic/pgtable.h    | 35 ++++++++++++++++++++++++++++++++
 mm/huge_memory.c                 | 19 ++++++++---------
 3 files changed, 57 insertions(+), 11 deletions(-)

-- 
2.17.1

