Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCCE2187C7
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jul 2020 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgGHMkw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Jul 2020 08:40:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbgGHMkv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Jul 2020 08:40:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0F2C12A3B17F5D981EE8;
        Wed,  8 Jul 2020 20:40:46 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Jul 2020 20:40:38 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [RFC PATCH v5 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date:   Wed, 8 Jul 2020 20:40:29 +0800
Message-ID: <20200708124031.1414-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

I tested this feature on a FPGA machine whose cpus support the tlbi range.
As the page num increases, the performance is improved significantly. When
page num = 256, the performance is improved by about 10 times.

Below is the test data when the stride = PTE:

	[page num]	[classic]		[tlbi range]
	1		16051			13524
	2		11366			11146
	3		11582			12171
	4		11694			11101
	5		12138			12267
	6		12290			11105
	7		12400			12002
	8		12837			11097
	9		14791			12140
	10		15461			11087
	16		18233			11094
	32		26983			11079
	64		43840			11092
	128		77754			11098
	256		145514			11089
	512		280932			11111

See more details in:

https://lore.kernel.org/linux-arm-kernel/504c7588-97e5-e014-fca0-c5511ae0d256@huawei.com/

--
ChangeList:
v5:
- rebase this series on Linux 5.8-rc4.
- remove the __TG macro.
- move the odd range_pages check into loop.

v4:
combine the __flush_tlb_range() and the __directly into the same function
with a single loop for both.

v3:
rebase this series on Linux 5.7-rc1.

v2:
Link: https://lkml.org/lkml/2019/11/11/348

Zhenyu Ye (2):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   3 +
 arch/arm64/include/asm/tlbflush.h | 101 +++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c    |  10 +++
 4 files changed, 102 insertions(+), 15 deletions(-)

-- 
2.19.1


