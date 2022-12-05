Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B0642489
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 09:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiLEI0b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 03:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiLEI0a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 03:26:30 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD38ABF78
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 00:26:29 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:38226.171270457
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 0F3471002FA;
        Mon,  5 Dec 2022 16:23:17 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-6cffbd87dd-5n69v with ESMTP id 45464105cef54241af91040c29347a1f for rostedt@goodmis.org;
        Mon, 05 Dec 2022 16:23:18 CST
X-Transaction-ID: 45464105cef54241af91040c29347a1f
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3 3/4] include/asm-generic/io.h: remove performing pointer arithmetic on a null pointer
Date:   Mon,  5 Dec 2022 16:30:06 +0800
Message-Id: <1670229006-4063-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

kernel test robot reports below warnings:

   In file included from kernel/trace/trace_events_synth.c:18:
   In file included from include/linux/trace_events.h:9:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic
	on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic
	on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note:
		expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))

The reason could be constant literal zero converted to any pointer type decays
into the null pointer constant.

I'm not sure why those warnings are only triggered when building hexagon instead
of x86 or arm, but anyway, i found a work around:

	void *pci_iobase = PCI_IOBASE;
	val = __raw_readb(pci_iobase + addr);

The pointer is not evaluated at compile time, so the warnings are removed.

Signed-off-by: Song Chen <chensong_2000@189.cn>
Reported-by: kernel test robot <lkp@intel.com>
---
 include/asm-generic/io.h | 45 +++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index a68f8fbf423b..394538fd2585 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -542,9 +542,10 @@ static inline void writesq(volatile void __iomem *addr, const void *buffer,
 static inline u8 _inb(unsigned long addr)
 {
 	u8 val;
+	void *pci_iobase = PCI_IOBASE;
 
 	__io_pbr();
-	val = __raw_readb(PCI_IOBASE + addr);
+	val = __raw_readb(pci_iobase + addr);
 	__io_par(val);
 	return val;
 }
@@ -555,9 +556,10 @@ static inline u8 _inb(unsigned long addr)
 static inline u16 _inw(unsigned long addr)
 {
 	u16 val;
+	void *pci_iobase = PCI_IOBASE;
 
 	__io_pbr();
-	val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw(pci_iobase + addr));
 	__io_par(val);
 	return val;
 }
@@ -568,9 +570,10 @@ static inline u16 _inw(unsigned long addr)
 static inline u32 _inl(unsigned long addr)
 {
 	u32 val;
+	void *pci_iobase = PCI_IOBASE;
 
 	__io_pbr();
-	val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl(pci_iobase + addr));
 	__io_par(val);
 	return val;
 }
@@ -580,8 +583,10 @@ static inline u32 _inl(unsigned long addr)
 #define _outb _outb
 static inline void _outb(u8 value, unsigned long addr)
 {
+	void *pci_iobase = PCI_IOBASE;
+
 	__io_pbw();
-	__raw_writeb(value, PCI_IOBASE + addr);
+	__raw_writeb(value, pci_iobase + addr);
 	__io_paw();
 }
 #endif
@@ -590,8 +595,10 @@ static inline void _outb(u8 value, unsigned long addr)
 #define _outw _outw
 static inline void _outw(u16 value, unsigned long addr)
 {
+	void *pci_iobase = PCI_IOBASE;
+
 	__io_pbw();
-	__raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), pci_iobase + addr);
 	__io_paw();
 }
 #endif
@@ -600,8 +607,10 @@ static inline void _outw(u16 value, unsigned long addr)
 #define _outl _outl
 static inline void _outl(u32 value, unsigned long addr)
 {
+	void *pci_iobase = PCI_IOBASE;
+
 	__io_pbw();
-	__raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
+	__raw_writel((u32 __force)cpu_to_le32(value), pci_iobase + addr);
 	__io_paw();
 }
 #endif
@@ -689,7 +698,9 @@ static inline void outl_p(u32 value, unsigned long addr)
 #define insb insb
 static inline void insb(unsigned long addr, void *buffer, unsigned int count)
 {
-	readsb(PCI_IOBASE + addr, buffer, count);
+	void *pci_iobase = PCI_IOBASE;
+
+	readsb(pci_iobase + addr, buffer, count);
 }
 #endif
 
@@ -697,7 +708,9 @@ static inline void insb(unsigned long addr, void *buffer, unsigned int count)
 #define insw insw
 static inline void insw(unsigned long addr, void *buffer, unsigned int count)
 {
-	readsw(PCI_IOBASE + addr, buffer, count);
+	void *pci_iobase = PCI_IOBASE;
+
+	readsw(pci_iobase + addr, buffer, count);
 }
 #endif
 
@@ -705,7 +718,9 @@ static inline void insw(unsigned long addr, void *buffer, unsigned int count)
 #define insl insl
 static inline void insl(unsigned long addr, void *buffer, unsigned int count)
 {
-	readsl(PCI_IOBASE + addr, buffer, count);
+	void *pci_iobase = PCI_IOBASE;
+
+	readsl(pci_iobase + addr, buffer, count);
 }
 #endif
 
@@ -714,7 +729,9 @@ static inline void insl(unsigned long addr, void *buffer, unsigned int count)
 static inline void outsb(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
-	writesb(PCI_IOBASE + addr, buffer, count);
+	void *pci_iobase = PCI_IOBASE;
+
+	writesb(pci_iobase + addr, buffer, count);
 }
 #endif
 
@@ -723,7 +740,9 @@ static inline void outsb(unsigned long addr, const void *buffer,
 static inline void outsw(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
-	writesw(PCI_IOBASE + addr, buffer, count);
+	void *pci_iobase = PCI_IOBASE;
+
+	writesw(pci_iobase + addr, buffer, count);
 }
 #endif
 
@@ -732,7 +751,9 @@ static inline void outsw(unsigned long addr, const void *buffer,
 static inline void outsl(unsigned long addr, const void *buffer,
 			 unsigned int count)
 {
-	writesl(PCI_IOBASE + addr, buffer, count);
+	void *pci_iobase = PCI_IOBASE;
+
+	writesl(pci_iobase + addr, buffer, count);
 }
 #endif
 
-- 
2.25.1

