Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E7523B3AA
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 05:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgHDDyo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Aug 2020 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbgHDDyo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 23:54:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD7C06174A;
        Mon,  3 Aug 2020 20:54:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y206so9174198pfb.10;
        Mon, 03 Aug 2020 20:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cb9Zf+T+lG+gtOsk1owLoMWY7pZE0H1RQHusNF38Jhs=;
        b=F//qhSFz9rhFOAXIqS9/SxQIIy18/1Q6ns+M1drCY0SW8JP2RayRGoraq9td9YRq0r
         ka4W3OiyZEKlLv2BuyUT/qS0v6GHAzR46l3SC4/2anJi3Gf4HfTqudGwz3weIvpTOFVr
         aDlLrsehQVn0e15rJKuLR/IjcjDJHQzqlZntFMsdZuBCkJX6UNh4Hq+HTahjucMzjMon
         RRgbD+4VHxq215tFRbD9R9DxfdSIl9WGV2ruz5hF+chfFdi8VBIkwRyGD6gLTi2fViu+
         xfH/Zjfyb9PycKrp16u9o0722VT31RPUKsrUtQaxJrh0UBpB3OWoX29IjrAjnv9D0a9S
         jN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cb9Zf+T+lG+gtOsk1owLoMWY7pZE0H1RQHusNF38Jhs=;
        b=Rzy29/zjPaOv4nHrPctUfevwIFmtoX2Kh4hQTYRHl0z/0PIj/yQZzGBlb/mdNlxDnX
         E281m1m19W8A7PjBHp+mUJnHXuwDH0HLmzVf/aoj4jukN4+bLJLB6qdRdv5fntTmO1OO
         t+C2Yz0593i1YGc6CfrNRok6/w4cgoTsvGnrRZpU0adnKd9kFjI9udpdhTfofD+i3EPf
         xWbr3YNGrDQkFpbELxb0OJ+XqxLV8S8ScarTzwXfroNIHT/IWy4MWOng1PrTemKzyNeI
         EAiNr0e3rDoy6hbWkFujfichP0yieaBNuZSNTgpjitCQOZy6VJetB582ZglykxNjw8Ao
         2dkA==
X-Gm-Message-State: AOAM530AA48fbT77dVaxj8Gb7EHR7IvM/C51QwiKMsU1WWxJXGbfgilZ
        ugTkkqxGqyc51fCAfmJper5dkjxH
X-Google-Smtp-Source: ABdhPJyNir5/+dPsOXoH2aCi7bHT7fl4iNTAfWgtcklV1vG1vXnC1xvKLLTqJb1MWV5cRnOtuT+rpA==
X-Received: by 2002:a62:2b85:: with SMTP id r127mr17658193pfr.239.1596513282975;
        Mon, 03 Aug 2020 20:54:42 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id z19sm21797941pfa.9.2020.08.03.20.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 20:54:42 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2] asm-generic/io.h: Fix sparse warnings on big-endian architectures
Date:   Tue,  4 Aug 2020 12:54:37 +0900
Message-Id: <20200804035437.3920009-1-shorne@gmail.com>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes since v1:
 - Remove white space between casts and right hand value. That matches all of
   the other casts.

 include/asm-generic/io.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 30a3aab312e6..dabf8cb7203b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -163,7 +163,7 @@ static inline u16 readw(const volatile void __iomem *addr)
 	u16 val;
 
 	__io_br();
-	val = __le16_to_cpu(__raw_readw(addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
 	return val;
 }
@@ -176,7 +176,7 @@ static inline u32 readl(const volatile void __iomem *addr)
 	u32 val;
 
 	__io_br();
-	val = __le32_to_cpu(__raw_readl(addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
 	return val;
 }
@@ -212,7 +212,7 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writew(cpu_to_le16(value), addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
 }
 #endif
@@ -222,7 +222,7 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
 	__io_bw();
-	__raw_writel(__cpu_to_le32(value), addr);
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
 }
 #endif
@@ -474,7 +474,7 @@ static inline u16 _inw(unsigned long addr)
 	u16 val;
 
 	__io_pbr();
-	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
 	__io_par(val);
 	return val;
 }
@@ -487,7 +487,7 @@ static inline u32 _inl(unsigned long addr)
 	u32 val;
 
 	__io_pbr();
-	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
 	__io_par(val);
 	return val;
 }
@@ -508,7 +508,7 @@ static inline void _outb(u8 value, unsigned long addr)
 static inline void _outw(u16 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writew(cpu_to_le16(value), PCI_IOBASE + addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
 	__io_paw();
 }
 #endif
@@ -518,7 +518,7 @@ static inline void _outw(u16 value, unsigned long addr)
 static inline void _outl(u32 value, unsigned long addr)
 {
 	__io_pbw();
-	__raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
+	__raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
 	__io_paw();
 }
 #endif
-- 
2.26.2

