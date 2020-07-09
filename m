Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2019219BC5
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGIJLN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 05:11:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbgGIJLN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 05:11:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 67D4C386280350642122;
        Thu,  9 Jul 2020 17:11:10 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 9 Jul 2020 17:11:03 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v1 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date:   Thu, 9 Jul 2020 17:10:52 +0800
Message-ID: <20200709091054.1698-1-yezhenyu2@huawei.com>
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

NOTICE: this series are based on the arm64 for-next/tlbi branch:
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi

--
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
RFC patches:
- Link: https://lore.kernel.org/linux-arm-kernel/20200708124031.1414-1-yezhenyu2@huawei.com/

Zhenyu Ye (2):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   3 +
 arch/arm64/include/asm/tlbflush.h | 156 ++++++++++++++++++++++++------
 arch/arm64/kernel/cpufeature.c    |  10 ++
 4 files changed, 141 insertions(+), 31 deletions(-)

-- 
2.19.1


