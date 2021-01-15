Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBDC2F8174
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 18:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbhAOREh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 12:04:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbhAOREh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 12:04:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHSDB5GBfzj8Gd;
        Sat, 16 Jan 2021 01:02:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 01:03:47 +0800
From:   John Garry <john.garry@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <xuwei5@hisilicon.com>,
        <lorenzo.pieralisi@arm.com>, <helgaas@kernel.org>,
        <jiaxun.yang@flygoat.com>, <song.bao.hua@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 1/4] arm64: io: Introduce IO_SPACE_BASE
Date:   Sat, 16 Jan 2021 00:58:46 +0800
Message-ID: <1610729929-188490-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
References: <1610729929-188490-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Introduce IO_SPACE_BASE, which is the base address of the IO port region.

0x10000 is chosen intentionally to exclude legacy ISA IO port address
range.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 arch/arm64/include/asm/io.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index fd172c41df90..2bcf55704bee 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -148,6 +148,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 #define arch_has_dev_port()	(1)
 #define IO_SPACE_LIMIT		(PCI_IO_SIZE - 1)
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
+#define IO_SPACE_BASE		(0x10000)
 
 /*
  * String version of I/O memory access operations.
-- 
2.26.2

