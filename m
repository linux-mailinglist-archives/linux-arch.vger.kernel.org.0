Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9BBEA83B
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2019 01:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfJaAcM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Oct 2019 20:32:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35232 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbfJaAcK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Oct 2019 20:32:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10so4355671wrb.2
        for <linux-arch@vger.kernel.org>; Wed, 30 Oct 2019 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YGjLcdx9KXKhg9YECWTpZ9bCIGLdak4UGDzKAXAAeDM=;
        b=dSAbWiy17OZMli/VazTnjYLhJ/fBH4XviqbTVhDYKWDZTRAbfb5lfbbwzHTia3qwyX
         SaCCsfFF5LMCBCXV1wkM4COyJ97bWFwoUrVXsDrqTPiM4PW4a4uqUepJ0JmXeJcGK4qH
         Ab0vWhCeoL9vXwoVAOl/ZHoSAWRg+U+jWoy5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YGjLcdx9KXKhg9YECWTpZ9bCIGLdak4UGDzKAXAAeDM=;
        b=XoDx15ZcyUG1ev7Dl/+3svw/syDMu7Zu/Jir9mRqYSr01hY3XDETAZb7Kq5akXjBZX
         cMVK8jDjWRgzPPsDCK7NHbmkI3L7v7HeNQW68VHcFdQJrct5avby/nRFlAJ0wtD/MXKx
         EKSvy3YGYX63T/7lfPhusEKXjRa6DxcVITYvXmF50UtCpqMnFGlk2RX7JfAMDmpp/Wze
         0N8ZPA+vYLX+PCojVoCOt3bBFq3jE7lB3ujuhXLrZ30fviu2UHvrDCLk66MFupnJzoYM
         NT3cWKOuJFVufdtnaCFMsimw+HxG/4t3P5AlRiIBSMnXI8tDE4hZZw9iNYfrrQdp1Zgy
         89NQ==
X-Gm-Message-State: APjAAAV9XMIHyssLMR4u0oq3FI13CHwEb5mbFPSIdTwxFd/aQbVovUgC
        wHhBQzkZn0f2NvnNJ8kXb+6mW08soP1uxPD9
X-Google-Smtp-Source: APXvYqwVUehvwoFgGnD9cecxRxGad/kVRBBgTLONSUGtsGz+C8YNoj+GJyg21DvBYXFJy2LNkBhEjQ==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr2437079wrm.240.1572481925942;
        Wed, 30 Oct 2019 17:32:05 -0700 (PDT)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id r13sm2357111wra.74.2019.10.30.17.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 17:32:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH 5/5] powerpc: make iowrite32 and friends static inline when no indirection
Date:   Thu, 31 Oct 2019 01:31:54 +0100
Message-Id: <20191031003154.21969-6-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
References: <20191031003154.21969-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When porting a powerpc-only driver to work on another architecture,
one has to change e.g. out_be32 to iowrite32be. Unfortunately, while
the other target architecture (in my case arm) may have static inline
definitions of iowrite32 and friends, this change pessimizes the
existing powerpc users of that driver since out_be32() is inline while
iowrite32be() is out-of-line.

When neither CONFIG_PPC_INDIRECT_PIO or CONFIG_PPC_INDIRECT_MMIO are
set (e.g. all of PPC32), there's no reason for those to be out-of-line
as they compile to just two or three instructions. So copy the
definitions from iomap.c into io.h, make them static inline, and add
the self-define macro boilerplate to prevent asm-generic/iomap.h from
providing extern declarations.

This means that kernel/iomap.c is now only compiled when
!CONFIG_PPC_INDIRECT_PIO && CONFIG_PPC_INDIRECT_MMIO - a combination I
don't think currently exists. So it's possible that file could simply
be deleted.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/include/asm/io.h | 172 ++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile  |   2 +-
 2 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index a63ec938636d..a59310620067 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -638,6 +638,178 @@ static inline void name at					\
 #define writel_relaxed(v, addr)	writel(v, addr)
 #define writeq_relaxed(v, addr)	writeq(v, addr)
 
+#if !defined(CONFIG_PPC_INDIRECT_PIO) && !defined(CONFIG_PPC_INDIRECT_MMIO)
+
+#define ioread8 ioread8
+static inline unsigned int ioread8(void __iomem *addr)
+{
+	return readb(addr);
+}
+#define ioread16 ioread16
+static inline unsigned int ioread16(void __iomem *addr)
+{
+	return readw(addr);
+}
+#define ioread16be ioread16be
+static inline unsigned int ioread16be(void __iomem *addr)
+{
+	return readw_be(addr);
+}
+#define ioread32 ioread32
+static inline unsigned int ioread32(void __iomem *addr)
+{
+	return readl(addr);
+}
+#define ioread32be ioread32be
+static inline unsigned int ioread32be(void __iomem *addr)
+{
+	return readl_be(addr);
+}
+#ifdef __powerpc64__
+#define ioread64 ioread64
+static inline u64 ioread64(void __iomem *addr)
+{
+	return readq(addr);
+}
+#define ioread64_lo_hi ioread64_lo_hi
+static inline u64 ioread64_lo_hi(void __iomem *addr)
+{
+	return readq(addr);
+}
+#define ioread64_hi_lo ioread64_hi_lo
+static inline u64 ioread64_hi_lo(void __iomem *addr)
+{
+	return readq(addr);
+}
+#define ioread64be ioread64be
+static inline u64 ioread64be(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+#define ioread64be_lo_hi ioread64be_lo_hi
+static inline u64 ioread64be_lo_hi(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+#define ioread64be_hi_lo ioread64be_hi_lo
+static inline u64 ioread64be_hi_lo(void __iomem *addr)
+{
+	return readq_be(addr);
+}
+#endif /* __powerpc64__ */
+
+#define iowrite8 iowrite8
+static inline void iowrite8(u8 val, void __iomem *addr)
+{
+	writeb(val, addr);
+}
+#define iowrite16 iowrite16
+static inline void iowrite16(u16 val, void __iomem *addr)
+{
+	writew(val, addr);
+}
+#define iowrite16be iowrite16be
+static inline void iowrite16be(u16 val, void __iomem *addr)
+{
+	writew_be(val, addr);
+}
+#define iowrite32 iowrite32
+static inline void iowrite32(u32 val, void __iomem *addr)
+{
+	writel(val, addr);
+}
+#define iowrite32be iowrite32be
+static inline void iowrite32be(u32 val, void __iomem *addr)
+{
+	writel_be(val, addr);
+}
+#ifdef __powerpc64__
+#define iowrite64 iowrite64
+static inline void iowrite64(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+#define iowrite64_lo_hi iowrite64_lo_hi
+static inline void iowrite64_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+#define iowrite64_hi_lo iowrite64_hi_lo
+static inline void iowrite64_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+#define iowrite64be iowrite64be
+static inline void iowrite64be(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+#define iowrite64be_lo_hi iowrite64be_lo_hi
+static inline void iowrite64be_lo_hi(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+#define iowrite64be_hi_lo iowrite64be_hi_lo
+static inline void iowrite64be_hi_lo(u64 val, void __iomem *addr)
+{
+	writeq_be(val, addr);
+}
+#endif /* __powerpc64__ */
+
+/*
+ * These are the "repeat read/write" functions. Note the
+ * non-CPU byte order. We do things in "IO byteorder"
+ * here.
+ *
+ * FIXME! We could make these do EEH handling if we really
+ * wanted. Not clear if we do.
+ */
+#define ioread8_rep ioread8_rep
+static inline void ioread8_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	readsb(addr, dst, count);
+}
+#define ioread16_rep ioread16_rep
+static inline void ioread16_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	readsw(addr, dst, count);
+}
+#define ioread32_rep ioread32_rep
+static inline void ioread32_rep(void __iomem *addr, void *dst, unsigned long count)
+{
+	readsl(addr, dst, count);
+}
+
+#define iowrite8_rep iowrite8_rep
+static inline void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	writesb(addr, src, count);
+}
+#define iowrite16_rep iowrite16_rep
+static inline void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	writesw(addr, src, count);
+}
+#define iowrite32_rep iowrite32_rep
+static inline void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
+{
+	writesl(addr, src, count);
+}
+
+#define ioport_map ioport_map
+static inline void __iomem *ioport_map(unsigned long port, unsigned int len)
+{
+	return (void __iomem *) (port + _IO_BASE);
+}
+
+#define ioport_unmap ioport_unmap
+static inline void ioport_unmap(void __iomem *addr)
+{
+	/* Nothing to do */
+}
+
+#endif /* !defined(CONFIG_PPC_INDIRECT_PIO) && !defined(CONFIG_PPC_INDIRECT_MMIO) */
+
 #include <asm-generic/iomap.h>
 
 static inline void iosync(void)
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index a7ca8fe62368..0991b3cd007b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -143,7 +143,7 @@ obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
 obj-y				+= trace/
 
 ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
-obj-y				+= iomap.o
+obj-$(CONFIG_PPC_INDIRECT_MMIO)	+= iomap.o
 endif
 
 obj64-$(CONFIG_PPC_TRANSACTIONAL_MEM)	+= tm.o
-- 
2.23.0

