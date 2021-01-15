Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EEB2F8187
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbhAOREu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 12:04:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10664 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbhAOREu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 12:04:50 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DHSDH3K0Kz15t3w;
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
Subject: [PATCH RFC 3/4] kernel/resource: Make ioport_resource.start configurable
Date:   Sat, 16 Jan 2021 00:58:48 +0800
Message-ID: <1610729929-188490-4-git-send-email-john.garry@huawei.com>
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

Make IO space base address to be configurable through IO_SPACE_BASE.

This will allow architectures which do not natively support IO ports -
like arm64 - to harden against legacy ISA-based drivers which use
hardcoded addresses to access IO ports.

Any attempts for these drivers to request a resource region will now fail
for architectures with set IO_SPACE_BASE above legacy ISA IO port region
(0xffff).

Signed-off-by: John Garry <john.garry@huawei.com>
---
 kernel/resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 3ae2f56cc79d..d191c4d796c7 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -29,7 +29,7 @@
 
 struct resource ioport_resource = {
 	.name	= "PCI IO",
-	.start	= 0,
+	.start	= IO_SPACE_BASE,
 	.end	= IO_SPACE_LIMIT,
 	.flags	= IORESOURCE_IO,
 };
-- 
2.26.2

