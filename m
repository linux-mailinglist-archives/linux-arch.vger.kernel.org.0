Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F232F817E
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 18:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbhAOREl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 12:04:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10665 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbhAOREk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 12:04:40 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DHSDH3lPDz15tQD;
        Sat, 16 Jan 2021 01:02:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 01:03:48 +0800
From:   John Garry <john.garry@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <xuwei5@hisilicon.com>,
        <lorenzo.pieralisi@arm.com>, <helgaas@kernel.org>,
        <jiaxun.yang@flygoat.com>, <song.bao.hua@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 4/4] logic_pio: Warn on and discard accesses to addresses below IO_SPACE_BASE
Date:   Sat, 16 Jan 2021 00:58:49 +0800
Message-ID: <1610729929-188490-5-git-send-email-john.garry@huawei.com>
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

Start the PCI MMIO region at IO_SPACE_BASE, and warn on any accesses below
that address. Those accesses are also discarded.

This is only for CONFIG_INDIRECT_PIO currently, and support can be added
later for !CONFIG_INDIRECT_PIO.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/logic_pio.h |  5 +++++
 lib/logic_pio.c           | 20 ++++++++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/logic_pio.h b/include/linux/logic_pio.h
index 54945aa824b4..425369f2ddd5 100644
--- a/include/linux/logic_pio.h
+++ b/include/linux/logic_pio.h
@@ -111,7 +111,12 @@ void logic_outsl(unsigned long addr, const void *buffer, unsigned int count);
 #else
 #define PIO_INDIRECT_SIZE 0
 #endif /* CONFIG_INDIRECT_PIO */
+
 #define MMIO_UPPER_LIMIT (IO_SPACE_LIMIT - PIO_INDIRECT_SIZE)
+#define MMIO_LOWER_LIMIT IO_SPACE_BASE
+#if MMIO_LOWER_LIMIT >= MMIO_UPPER_LIMIT
+#error MMIO_UPPPER_LIMIT should be above MMIO_LOWER_LIMIT
+#endif
 
 struct logic_pio_hwaddr *find_io_range_by_fwnode(struct fwnode_handle *fwnode);
 unsigned long logic_pio_trans_hwaddr(struct fwnode_handle *fwnode,
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index f32fe481b492..cbb12260ede6 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -36,7 +36,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	struct logic_pio_hwaddr *range;
 	resource_size_t start;
 	resource_size_t end;
-	resource_size_t mmio_end = 0;
+	resource_size_t mmio_end = MMIO_LOWER_LIMIT;
 	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
 	int ret = 0;
 
@@ -234,7 +234,9 @@ type logic_in##bwl(unsigned long addr)					\
 {									\
 	type ret = (type)~0;						\
 									\
-	if (addr < MMIO_UPPER_LIMIT) {					\
+	if (addr < MMIO_LOWER_LIMIT) {					\
+		WARN_ON_ONCE(1);					\
+	} else if (addr < MMIO_UPPER_LIMIT) {					\
 		ret = _in##bwl(addr);					\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
@@ -250,8 +252,10 @@ type logic_in##bwl(unsigned long addr)					\
 									\
 void logic_out##bwl(type value, unsigned long addr)			\
 {									\
-	if (addr < MMIO_UPPER_LIMIT) {					\
-		_out##bwl(value, addr);				\
+	if (addr < MMIO_LOWER_LIMIT) {					\
+		WARN_ON_ONCE(1);					\
+	} else if (addr < MMIO_UPPER_LIMIT) {				\
+		_out##bwl(value, addr);					\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -266,7 +270,9 @@ void logic_out##bwl(type value, unsigned long addr)			\
 void logic_ins##bwl(unsigned long addr, void *buffer,			\
 		    unsigned int count)					\
 {									\
-	if (addr < MMIO_UPPER_LIMIT) {					\
+	if (addr < MMIO_LOWER_LIMIT) {					\
+		WARN_ON_ONCE(1);					\
+	} else if (addr < MMIO_UPPER_LIMIT) {				\
 		reads##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
@@ -283,7 +289,9 @@ void logic_ins##bwl(unsigned long addr, void *buffer,			\
 void logic_outs##bwl(unsigned long addr, const void *buffer,		\
 		     unsigned int count)				\
 {									\
-	if (addr < MMIO_UPPER_LIMIT) {					\
+	if (addr < MMIO_LOWER_LIMIT) {					\
+		WARN_ON_ONCE(1);					\
+	} else if (addr < MMIO_UPPER_LIMIT) {				\
 		writes##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
-- 
2.26.2

