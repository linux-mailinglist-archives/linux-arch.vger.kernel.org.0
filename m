Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D7123A92D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Aug 2020 17:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHCPLr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Aug 2020 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCPLr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 11:11:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA02C06174A;
        Mon,  3 Aug 2020 08:11:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p8so3867914pgn.13;
        Mon, 03 Aug 2020 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qmvvle8M5iZN2wTO6PYGSYzmeFputwNtrUduhwXt5WA=;
        b=HGuaebBVFskZH/GPbzSwZRVXH7S38p6apgZE9uqRYR9PKKZcyz+SV7btkoImX4tiSC
         q1pl/VO8xG+wA3v74zvL3xSS7u9YQaTv4kNG8enxOmK2Hhf4daTAWQOi/n800u22FwHj
         iF5MtDm+OjeQoIQ+XPnCyFIaE+Rg3szCMb80YmfR+u4/tn4VS57XLAiD4A6zgBGsIu+t
         uet8iSu/PLRanql8/Kw13z8LxCuN2deSJ+MK7XrqFjyWB70f4tTWgCl0XBdHqQS5gp99
         pC0tUmg8L3yopzRBfTBdpE8OIPodcc+eG10guBgAXbt8n1jkLtxh2cbaiadk6/+Ffv8J
         k7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qmvvle8M5iZN2wTO6PYGSYzmeFputwNtrUduhwXt5WA=;
        b=eEJha720ycGx9JXyyX8akSf62epSRZOgTTAiuG6FQwtP2gwanYNMdJJ6iYM/p89K3X
         wrFhLq0Yu/KGRAPKa0yfyLInmF5gSIlLzsH+1QR0crFN9ySkgO8tQoUkse6RtocD2h+/
         dzW0uVm+JqeYu4z+h2M/d4DT3lmAl8vMStp468StTvRVshOLND87SnfGMPfrikfTU5ca
         yWsGWY7N8pZII0erhLBrqELQ2EvsTaT3im8On40iKKBRxHEpcEzuXPkfX7MPOharK34C
         YcOiU1s9TpD3WduXcRwdcDJO0mBYbW2CZcpKlpMOfvQkelX8P47be6TBMRRXGhKeVPGR
         t11g==
X-Gm-Message-State: AOAM5326VGtbGa0IBdNxdkf2vmeLA/RwW9IwimHC+JDliA6YEbw/W0NS
        iPVD16XhF0e9OPVYUIGHaa0yN7WU
X-Google-Smtp-Source: ABdhPJyd3Px+kgemUmJ6zPZkPyspRVB5doFZGjyTO83bYPMO58QFyW+MoJoefJFh3dOcydSzOgL0uQ==
X-Received: by 2002:a63:a05f:: with SMTP id u31mr14971337pgn.4.1596467506510;
        Mon, 03 Aug 2020 08:11:46 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id p5sm19031674pgi.83.2020.08.03.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:11:45 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
Subject: [PATCH] asm-generic/io.h: Fix sparse warnings on big-endian architectures
Date:   Tue,  4 Aug 2020 00:11:34 +0900
Message-Id: <20200803151134.3740544-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On big-endian architectures like OpenRISC, sparse outputs below warnings on
asm-generic/io.h.  This is due to io statements like:

  __raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);

The __raw_writel() function expects native endianness, however
cpu_to_le32() returns __le32.  On little-endian machines these match up
and there is no issue.  However, on big-endian we get warnings, for IO
that is defined as little-endian the mismatch is expected.

The fix I propose is to __force to native endian.

Warnings:

./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
./include/asm-generic/io.h:215:22: warning: incorrect type in argument 1 (different base types)
./include/asm-generic/io.h:215:22:    expected unsigned short [usertype] value
./include/asm-generic/io.h:215:22:    got restricted __le16 [usertype]
./include/asm-generic/io.h:225:22: warning: incorrect type in argument 1 (different base types)
./include/asm-generic/io.h:225:22:    expected unsigned int [usertype] value
./include/asm-generic/io.h:225:22:    got restricted __le32 [usertype]

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 include/asm-generic/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 30a3aab312e6..c88b73934ab7 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -163,7 +163,7 @@ static inline u16 readw(const volatile void __iomem *addr)
 	u16 val;
 
 	__io_br();
-	val = __le16_to_cpu(__raw_readw(addr));
+	val = __le16_to_cpu((__le16 __force) __raw_readw(addr));
 	__io_ar(val);
 	return val;
 }
@@ -176,7 +176,7 @@ static inline u32 readl(const volatile void __iomem *addr)
 	u32 val;
 
 	__io_br();
-	val = __le32_to_cpu(__raw_readl(addr));
+	val = __le32_to_cpu((__le32 __force) __raw_readl(addr));
 	__io_ar(val);
 	return val;
 }
@@ -212,7 +212,7 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writew(cpu_to_le16(value), addr);
+	__raw_writew((u16 __force) cpu_to_le16(value), addr);
 	__io_aw();
 }
 #endif
@@ -222,7 +222,7 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writel(__cpu_to_le32(value), addr);
+	__raw_writel((u32 __force) __cpu_to_le32(value), addr);
 	__io_aw();
 }
 #endif
@@ -474,7 +474,7 @@ static inline u16 _inw(unsigned long addr)
 	u16 val;
 
 	__io_pbr();
-	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
+	val = __le16_to_cpu((__le16 __force) __raw_readw(PCI_IOBASE + addr));
 	__io_par(val);
 	return val;
 }
@@ -487,7 +487,7 @@ static inline u32 _inl(unsigned long addr)
 	u32 val;
 
 	__io_pbr();
-	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
+	val = __le32_to_cpu((__le32 __force) __raw_readl(PCI_IOBASE + addr));
 	__io_par(val);
 	return val;
 }
@@ -508,7 +508,7 @@ static inline void _outb(u8 value, unsigned long addr)
 static inline void _outw(u16 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
+	__raw_writew((u16 __force) cpu_to_le16(value), PCI_IOBASE + addr);
 	__io_paw();
 }
 #endif
@@ -518,7 +518,7 @@ static inline void _outw(u16 value, unsigned long addr)
 static inline void _outl(u32 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
+	__raw_writel((u32 __force) cpu_to_le32(value), PCI_IOBASE + addr);
 	__io_paw();
 }
 #endif
-- 
2.26.2

