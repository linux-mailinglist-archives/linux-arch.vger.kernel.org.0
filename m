Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC5D195AB9
	for <lists+linux-arch@lfdr.de>; Fri, 27 Mar 2020 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgC0QKh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 12:10:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727780AbgC0QKg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Mar 2020 12:10:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ADDF4F4A2F785919988D;
        Sat, 28 Mar 2020 00:10:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 00:10:16 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>, <arnd@arndb.de>
CC:     <okaya@kernel.org>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <olof@lixom.net>, <jiaxun.yang@flygoat.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 1/3] io: Provide _inX() and _outX()
Date:   Sat, 28 Mar 2020 00:06:12 +0800
Message-ID: <1585325174-195915-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
References: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since commit a7851aa54c0c ("io: change outX() to have their own IO barrier
overrides") and commit 87fe2d543f81 ("io: change inX() to have their own
IO barrier overrides"), the outX and inX functions have memory barriers
which can be overridden.

However, the generic logic_pio lib has continued to use readl/writel et al
for IO port accesses, which has weaker barriers on arm64.

Provide generic _inX() and _outX(), which can be used by logic pio.

For consistency, we check for !defined({in,out}X) && !defined(_{in,out}X),
for defining _{in,out}X, while a check for just !defined({in,out}X) should
suffice.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/asm-generic/io.h | 64 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d39ac997dda8..3a7871130112 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -448,17 +448,15 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 #define IO_SPACE_LIMIT 0xffff
 #endif
 
-#include <linux/logic_pio.h>
-
 /*
  * {in,out}{b,w,l}() access little endian I/O. {in,out}{b,w,l}_p() can be
  * implemented on hardware that needs an additional delay for I/O accesses to
  * take effect.
  */
 
-#ifndef inb
-#define inb inb
-static inline u8 inb(unsigned long addr)
+#if !defined(inb) && !defined(_inb)
+#define _inb _inb
+static inline u16 _inb(unsigned long addr)
 {
 	u8 val;
 
@@ -469,9 +467,9 @@ static inline u8 inb(unsigned long addr)
 }
 #endif
 
-#ifndef inw
-#define inw inw
-static inline u16 inw(unsigned long addr)
+#if !defined(inw) && !defined(_inw)
+#define _inw _inw
+static inline u16 _inw(unsigned long addr)
 {
 	u16 val;
 
@@ -482,9 +480,9 @@ static inline u16 inw(unsigned long addr)
 }
 #endif
 
-#ifndef inl
-#define inl inl
-static inline u32 inl(unsigned long addr)
+#if !defined(inl) && !defined(_inl)
+#define _inl _inl
+static inline u16 _inl(unsigned long addr)
 {
 	u32 val;
 
@@ -495,9 +493,9 @@ static inline u32 inl(unsigned long addr)
 }
 #endif
 
-#ifndef outb
-#define outb outb
-static inline void outb(u8 value, unsigned long addr)
+#if !defined(outb) && !defined(_outb)
+#define _outb _outb
+static inline void _outb(u8 value, unsigned long addr)
 {
 	__io_pbw();
 	__raw_writeb(value, PCI_IOBASE + addr);
@@ -505,9 +503,9 @@ static inline void outb(u8 value, unsigned long addr)
 }
 #endif
 
-#ifndef outw
-#define outw outw
-static inline void outw(u16 value, unsigned long addr)
+#if !defined(outw) && !defined(_outw)
+#define _outw _outw
+static inline void _outw(u16 value, unsigned long addr)
 {
 	__io_pbw();
 	__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
@@ -515,9 +513,9 @@ static inline void outw(u16 value, unsigned long addr)
 }
 #endif
 
-#ifndef outl
-#define outl outl
-static inline void outl(u32 value, unsigned long addr)
+#if !defined(outl) && !defined(_outl)
+#define _outl _outl
+static inline void _outl(u32 value, unsigned long addr)
 {
 	__io_pbw();
 	__raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
@@ -525,6 +523,32 @@ static inline void outl(u32 value, unsigned long addr)
 }
 #endif
 
+#include <linux/logic_pio.h>
+
+#ifndef inb
+#define inb _inb
+#endif
+
+#ifndef inw
+#define inw _inw
+#endif
+
+#ifndef inl
+#define inl _inl
+#endif
+
+#ifndef outb
+#define outb _outb
+#endif
+
+#ifndef outw
+#define outw _outw
+#endif
+
+#ifndef outl
+#define outl _outl
+#endif
+
 #ifndef inb_p
 #define inb_p inb_p
 static inline u8 inb_p(unsigned long addr)
-- 
2.16.4

