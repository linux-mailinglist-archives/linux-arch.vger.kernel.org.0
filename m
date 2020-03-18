Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6718A00D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Mar 2020 17:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCRQAH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Mar 2020 12:00:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52540 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726473AbgCRQAH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Mar 2020 12:00:07 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6DE90C19703925D4B0E4;
        Wed, 18 Mar 2020 23:59:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Mar 2020 23:59:39 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>, <arnd@arndb.de>
CC:     <okaya@kernel.org>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <olof@lixom.net>, <jiaxun.yang@flygoat.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH 2/3] logic_pio: Improve macro argument name
Date:   Wed, 18 Mar 2020 23:55:34 +0800
Message-ID: <1584546935-75393-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
References: <1584546935-75393-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Macro argument "bw" is used for building byte, word, and long-based
functions. Use "bwl" instead, to include long.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index f511a99bb389..21dc731bec88 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -229,13 +229,13 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 }
 
 #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
-#define BUILD_LOGIC_IO(bw, type)					\
-type logic_in##bw(unsigned long addr)					\
+#define BUILD_LOGIC_IO(bwl, type)					\
+type logic_in##bwl(unsigned long addr)					\
 {									\
 	type ret = (type)~0;						\
 									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		ret = read##bw(PCI_IOBASE + addr);			\
+		ret = read##bwl(PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -248,10 +248,10 @@ type logic_in##bw(unsigned long addr)					\
 	return ret;							\
 }									\
 									\
-void logic_out##bw(type value, unsigned long addr)			\
+void logic_out##bwl(type value, unsigned long addr)			\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		write##bw(value, PCI_IOBASE + addr);			\
+		write##bwl(value, PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -263,11 +263,11 @@ void logic_out##bw(type value, unsigned long addr)			\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,			\
-		   unsigned int count)					\
+void logic_ins##bwl(unsigned long addr, void *buffer,			\
+		    unsigned int count)					\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+		reads##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -280,11 +280,11 @@ void logic_ins##bw(unsigned long addr, void *buffer,			\
 									\
 }									\
 									\
-void logic_outs##bw(unsigned long addr, const void *buffer,		\
-		    unsigned int count)					\
+void logic_outs##bwl(unsigned long addr, const void *buffer,		\
+		     unsigned int count)				\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+		writes##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-- 
2.12.3

