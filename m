Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC24A2F8181
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbhAOREq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 12:04:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11546 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbhAOREp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 12:04:45 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHSCy3tRQzMKdS;
        Sat, 16 Jan 2021 01:02:38 +0800 (CST)
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
Subject: [PATCH RFC 2/4] asm-generic/io.h: Add IO_SPACE_BASE
Date:   Sat, 16 Jan 2021 00:58:47 +0800
Message-ID: <1610729929-188490-3-git-send-email-john.garry@huawei.com>
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

Add a fallback default for IO_SPACE_BASE (at 0) for when an architecture
does not define a value.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/asm-generic/io.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 9ea83d80eb6f..4d74a0c696ca 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -448,6 +448,10 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 #define IO_SPACE_LIMIT 0xffff
 #endif
 
+#ifndef IO_SPACE_BASE
+#define IO_SPACE_BASE 0x0
+#endif
+
 /*
  * {in,out}{b,w,l}() access little endian I/O. {in,out}{b,w,l}_p() can be
  * implemented on hardware that needs an additional delay for I/O accesses to
-- 
2.26.2

