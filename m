Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D586180E3A
	for <lists+linux-arch@lfdr.de>; Wed, 11 Mar 2020 03:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgCKC42 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Mar 2020 22:56:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727528AbgCKC42 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Mar 2020 22:56:28 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D688528DB561F007B992;
        Wed, 11 Mar 2020 10:56:23 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Mar 2020 10:56:14 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <aneesh.kumar@linux.ibm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>
Subject: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
Date:   Wed, 11 Mar 2020 10:53:06 +0800
Message-ID: <20200311025309.1743-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated. Hardware can use this information
to determine if there was a risk of splintering.

This set of patches adds TTL field to __TLBI_ADDR, and uses
Architecture-specific MM context to pass the TTL value to tlb interface.

The default value of TTL is 0, which will not have any impact on the
TLB maintenance instructions. The last patch trys to use TTL field in
some obviously tlb-flush interface.

Zhenyu Ye (3):
  arm64: tlb: add TTL field to __TLBI_ADDR
  arm64: tlb: use mm_struct.context.flags to indicate TTL
  arm64: tlb: add support for TTL in some functions

 arch/arm64/include/asm/cpucaps.h  |  3 ++-
 arch/arm64/include/asm/mmu.h      | 11 ++++++++++
 arch/arm64/include/asm/sysreg.h   |  4 ++++
 arch/arm64/include/asm/tlb.h      |  3 +++
 arch/arm64/include/asm/tlbflush.h | 35 +++++++++++++++++++++++--------
 arch/arm64/kernel/cpufeature.c    | 10 +++++++++
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/mm/hugetlbpage.c       |  2 ++
 8 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.19.1


