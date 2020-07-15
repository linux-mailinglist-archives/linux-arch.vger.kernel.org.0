Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5422060A
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 09:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgGOHUD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 03:20:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728876AbgGOHUD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 03:20:03 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 367C086A3F7B3A2F6EFD;
        Wed, 15 Jul 2020 15:20:01 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Jul 2020 15:19:51 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
Subject: [PATCH v3 0/3] arm64: tlb: add support for TLBI RANGE instructions
Date:   Wed, 15 Jul 2020 15:19:42 +0800
Message-ID: <20200715071945.897-1-yezhenyu2@huawei.com>
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

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

--
ChangeList:
v3:
- add check on whether binutils supports ARMv8.4-a instructions.
- pass -march=armv8.4-a to KBUILD_CFLAGS.
- make __TLBI_RANGE_PAGES to be 'unsigned long' explicitly.

v2:
- remove the __tlbi_last_level() macro.
- add check for parameters in __TLBI_VADDR_RANGE macro.

RFC patches:
- Link: https://lore.kernel.org/linux-arm-kernel/20200708124031.1414-1-yezhenyu2@huawei.com/


Zhenyu Ye (3):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: enable tlbi range instructions
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/Kconfig                |  14 +++
 arch/arm64/Makefile               |   7 ++
 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   3 +
 arch/arm64/include/asm/tlbflush.h | 156 ++++++++++++++++++++++++------
 arch/arm64/kernel/cpufeature.c    |  10 ++
 6 files changed, 163 insertions(+), 30 deletions(-)

-- 
2.19.1


