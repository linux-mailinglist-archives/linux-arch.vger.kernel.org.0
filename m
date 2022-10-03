Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FA25F30A7
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 15:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJCNEM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 09:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJCNEL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 09:04:11 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F994BD08;
        Mon,  3 Oct 2022 06:04:03 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id EA7CA580398;
        Mon,  3 Oct 2022 09:03:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 03 Oct 2022 09:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664802239; x=1664805839; bh=zu4PCeMRnO
        RGWJfCxLvUTFUaQk9wqCqQ+Wi2AG7PaJA=; b=GPwLnzTJZ15R3otzDqlRIWrOpI
        tgYcGG3R0okV/kVyOY7mXt5HYbD9U3x8qh9fExp6oH0DHbyeD4yD26fvcAt48LyP
        ECcplW82yx+HEQzuxgLELkEJURowIPFuehQrHm2622RaokXfzH6o4rY9KOQTDfY6
        9kH673lFxYXGtNO3/BSollpHczbl7sZjJOCoXRm72WzL0eNsU5j8zL5ao2cTwm8C
        gIHsyUEEi7BYUcr6z/f4uUV9Wj+GBJ4b5ap6hyvK+6vWH6yW3q27nja7grC8b2JD
        QhUPi6GWRfBo6LPIZVQtg6ytSdOvT14FKanwSCgGtGsBewzf8vq2I/FgvMkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664802239; x=1664805839; bh=zu4PCeMRnORGWJfCxLvUTFUaQk9w
        qCqQ+Wi2AG7PaJA=; b=VsBQbweeNShY4cYL+Cblm04gOtaEogylIRLQjvDCErsK
        JE/d2KfucOgb+YIkUY8eW69MhREJ1o2W1BXvP7GOaApttZRbVu/v4WCn/X2Bhe6z
        vmqeQJxYen1kekDl18qrKhsbQo/HqN2wdvfEflAdVQf8dB4RixoEVZ3xOuTluO47
        ReT00zKpu3M6H3/TBGA66G6oux85UMFnajmUw8a4Xyj6QLnJtV/QL4xpK4NT7p3S
        wriXxT9Yws5srY1K1KUpxplvm2LmKAsKU3Mk4CPNRNreEuNHO6d48ICWASl6HIur
        jW8t+n2KykYsf/H33ZvPcmLdMHauNGG8+roffe+Z/Q==
X-ME-Sender: <xms:u906Y5VBQ8SmncFlZOn3S_q5ufCMiOm3bXzsuyBv_ZhTkq6cTL1lrQ>
    <xme:u906Y5nm4PCERHIsfKwl6kOFt9_Njr0NblxeHme0tpKV1aug88UcQxuProKONpFzY
    Obneu1FpYeCVHdEtZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:u906Y1b9W9kWlJPLCVLouApnzk_0avaA7mYC2aAhL9HkN_bapMYGiQ>
    <xmx:u906Y8WN8ZXTtPaQT6kV142b8J7FtsYsp5Q1Nbk1eYAS-LSn-o5n3w>
    <xmx:u906YzkfGKEp0YzFmCpfVfKAN6BHdZ12K9mQr3YLG6xj2d3IL76Kpg>
    <xmx:vd06YxY2iJ7XFg1G-BogLm2Jt2UxuIOut9dThBgmDm3zsJzkFM2G5g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9090EB60086; Mon,  3 Oct 2022 09:03:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <fd905ca5-fe0d-4cfb-a0d0-aea8af539cc7@app.fastmail.com>
In-Reply-To: <20221002224521.GA968453@roeck-us.net>
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <20221002224521.GA968453@roeck-us.net>
Date:   Mon, 03 Oct 2022 15:03:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Guenter Roeck" <linux@roeck-us.net>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 3, 2022, at 12:45 AM, Guenter Roeck wrote:

>> 
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/linux-mm/202208181447.G9FLcMkI-lkp@intel.com/
>> Cc: Mark Brown <broonie@kernel.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
>> Cc: Matt Turner <mattst88@gmail.com>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-alpha@vger.kernel.org
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This patch results in the following build errors when trying to build
> alpha:allmodconfig.
>
> ERROR: modpost: "ioread64" [drivers/pci/switch/switchtec.ko] undefined!
> ERROR: modpost: "ioread64" 
> [drivers/net/ethernet/freescale/enetc/fsl-enetc.ko] undefined!
> ERROR: modpost: "ioread64" 
> [drivers/net/ethernet/freescale/enetc/fsl-enetc-vf.ko] undefined!
> ERROR: modpost: "iowrite64" 
> [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!
> ERROR: modpost: "iowrite64" [drivers/net/wwan/t7xx/mtk_t7xx.ko] 
> undefined!
> ERROR: modpost: "ioread64" [drivers/net/wwan/t7xx/mtk_t7xx.ko] 
> undefined!
> ERROR: modpost: "iowrite64" [drivers/firmware/arm_scmi/scmi-module.ko] 
> undefined!
> ERROR: modpost: "ioread64" [drivers/firmware/arm_scmi/scmi-module.ko] 
> undefined!
> ERROR: modpost: "iowrite64" [drivers/vfio/pci/vfio-pci-core.ko] 
> undefined!
> ERROR: modpost: "ioread64" [drivers/ntb/hw/mscc/ntb_hw_switchtec.ko] 
> undefined!
>
> Reverting it doesn't help because that just reintroduces the problem
> that was supposed to be fixed by this patch.

Thanks for the report, I've now added this patch on top.

Matt, can you take a look if this look correct?

     Arnd

8<---
From 258382f3ca77b0e50501a0010d8c9abc2d4c51c8 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 3 Oct 2022 13:12:54 +0200
Subject: [PATCH] alpha: add full ioread64/iowrite64 implementation

The previous patch introduced ioread64/iowrite64 declarations, but
this means we no longer get the io-64-nonatomic variant, and
run into a long error when someone actually wants to use these:

ERROR: modpost: "ioread64" [drivers/net/ethernet/freescale/enetc/fsl-enetc.ko] undefined!

Add the (hopefully) correct implementation for each machine type,
based on the 32-bit accessor. Since the 32-bit return type does
not work for ioread64(), change the internal implementation to use
the correct width consistently, but leave the external interface
to match the asm-generic/iomap.h header that uses 32-bit or 64-bit
return values.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/alpha/include/asm/core_apecs.h b/arch/alpha/include/asm/core_apecs.h
index 2d9726fc02ef..69a2fc62c9c3 100644
--- a/arch/alpha/include/asm/core_apecs.h
+++ b/arch/alpha/include/asm/core_apecs.h
@@ -384,7 +384,7 @@ struct el_apecs_procdata
 		}						\
 	} while (0)
 
-__EXTERN_INLINE unsigned int apecs_ioread8(const void __iomem *xaddr)
+__EXTERN_INLINE u8 apecs_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -420,7 +420,7 @@ __EXTERN_INLINE void apecs_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int apecs_ioread16(const void __iomem *xaddr)
+__EXTERN_INLINE u16 apecs_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -456,7 +456,7 @@ __EXTERN_INLINE void apecs_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int apecs_ioread32(const void __iomem *xaddr)
+__EXTERN_INLINE u32 apecs_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	if (addr < APECS_DENSE_MEM)
@@ -472,6 +472,22 @@ __EXTERN_INLINE void apecs_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 apecs_ioread64(const void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < APECS_DENSE_MEM)
+		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x18;
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void apecs_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < APECS_DENSE_MEM)
+		addr = ((addr - APECS_IO) << 5) + APECS_IO + 0x18;
+	*(vulp)addr = b;
+}
+
 __EXTERN_INLINE void __iomem *apecs_ioportmap(unsigned long addr)
 {
 	return (void __iomem *)(addr + APECS_IO);
diff --git a/arch/alpha/include/asm/core_cia.h b/arch/alpha/include/asm/core_cia.h
index cb22991f6761..d26bdfb7ca3b 100644
--- a/arch/alpha/include/asm/core_cia.h
+++ b/arch/alpha/include/asm/core_cia.h
@@ -342,7 +342,7 @@ struct el_CIA_sysdata_mcheck {
 #define vuip	volatile unsigned int __force *
 #define vulp	volatile unsigned long __force *
 
-__EXTERN_INLINE unsigned int cia_ioread8(const void __iomem *xaddr)
+__EXTERN_INLINE u8 cia_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -374,7 +374,7 @@ __EXTERN_INLINE void cia_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int cia_ioread16(const void __iomem *xaddr)
+__EXTERN_INLINE u16 cia_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -404,7 +404,7 @@ __EXTERN_INLINE void cia_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int cia_ioread32(const void __iomem *xaddr)
+__EXTERN_INLINE u32 cia_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	if (addr < CIA_DENSE_MEM)
@@ -420,6 +420,22 @@ __EXTERN_INLINE void cia_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 cia_ioread64(const void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < CIA_DENSE_MEM)
+		addr = ((addr - CIA_IO) << 5) + CIA_IO + 0x18;
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void cia_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < CIA_DENSE_MEM)
+		addr = ((addr - CIA_IO) << 5) + CIA_IO + 0x18;
+	*(vulp)addr = b;
+}
+
 __EXTERN_INLINE void __iomem *cia_ioportmap(unsigned long addr)
 {
 	return (void __iomem *)(addr + CIA_IO);
diff --git a/arch/alpha/include/asm/core_lca.h b/arch/alpha/include/asm/core_lca.h
index ec86314418cb..d8c3e72ef8f6 100644
--- a/arch/alpha/include/asm/core_lca.h
+++ b/arch/alpha/include/asm/core_lca.h
@@ -230,7 +230,7 @@ union el_lca {
 	} while (0)
 
 
-__EXTERN_INLINE unsigned int lca_ioread8(const void __iomem *xaddr)
+__EXTERN_INLINE u8 lca_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -266,7 +266,7 @@ __EXTERN_INLINE void lca_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int lca_ioread16(const void __iomem *xaddr)
+__EXTERN_INLINE u16 lca_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	unsigned long result, base_and_type;
@@ -302,7 +302,7 @@ __EXTERN_INLINE void lca_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + base_and_type) = w;
 }
 
-__EXTERN_INLINE unsigned int lca_ioread32(const void __iomem *xaddr)
+__EXTERN_INLINE u32 lca_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long) xaddr;
 	if (addr < LCA_DENSE_MEM)
@@ -318,6 +318,22 @@ __EXTERN_INLINE void lca_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 lca_ioread64(const void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < LCA_DENSE_MEM)
+		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x18;
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void lca_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long) xaddr;
+	if (addr < LCA_DENSE_MEM)
+		addr = ((addr - LCA_IO) << 5) + LCA_IO + 0x18;
+	*(vulp)addr = b;
+}
+
 __EXTERN_INLINE void __iomem *lca_ioportmap(unsigned long addr)
 {
 	return (void __iomem *)(addr + LCA_IO);
diff --git a/arch/alpha/include/asm/core_marvel.h b/arch/alpha/include/asm/core_marvel.h
index b266e02e284b..d99f3a82e0e5 100644
--- a/arch/alpha/include/asm/core_marvel.h
+++ b/arch/alpha/include/asm/core_marvel.h
@@ -332,10 +332,10 @@ struct io7 {
 #define vucp	volatile unsigned char __force *
 #define vusp	volatile unsigned short __force *
 
-extern unsigned int marvel_ioread8(const void __iomem *);
+extern u8 marvel_ioread8(const void __iomem *);
 extern void marvel_iowrite8(u8 b, void __iomem *);
 
-__EXTERN_INLINE unsigned int marvel_ioread16(const void __iomem *addr)
+__EXTERN_INLINE u16 marvel_ioread16(const void __iomem *addr)
 {
 	return __kernel_ldwu(*(vusp)addr);
 }
diff --git a/arch/alpha/include/asm/core_mcpcia.h b/arch/alpha/include/asm/core_mcpcia.h
index cb24d1bd6141..ed2bf8ad40ed 100644
--- a/arch/alpha/include/asm/core_mcpcia.h
+++ b/arch/alpha/include/asm/core_mcpcia.h
@@ -248,6 +248,7 @@ struct el_MCPCIA_uncorrected_frame_mcheck {
 
 #define vip	volatile int __force *
 #define vuip	volatile unsigned int __force *
+#define vulp	volatile unsigned long __force *
 
 #ifndef MCPCIA_ONE_HAE_WINDOW
 #define MCPCIA_FROB_MMIO						\
@@ -267,7 +268,7 @@ extern inline int __mcpcia_is_mmio(unsigned long addr)
 	return (addr & 0x80000000UL) == 0;
 }
 
-__EXTERN_INLINE unsigned int mcpcia_ioread8(const void __iomem *xaddr)
+__EXTERN_INLINE u8 mcpcia_ioread8(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long)xaddr & MCPCIA_MEM_MASK;
 	unsigned long hose = (unsigned long)xaddr & ~MCPCIA_MEM_MASK;
@@ -291,7 +292,7 @@ __EXTERN_INLINE void mcpcia_iowrite8(u8 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + hose + 0x00) = w;
 }
 
-__EXTERN_INLINE unsigned int mcpcia_ioread16(const void __iomem *xaddr)
+__EXTERN_INLINE u16 mcpcia_ioread16(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long)xaddr & MCPCIA_MEM_MASK;
 	unsigned long hose = (unsigned long)xaddr & ~MCPCIA_MEM_MASK;
@@ -315,7 +316,7 @@ __EXTERN_INLINE void mcpcia_iowrite16(u16 b, void __iomem *xaddr)
 	*(vuip) ((addr << 5) + hose + 0x08) = w;
 }
 
-__EXTERN_INLINE unsigned int mcpcia_ioread32(const void __iomem *xaddr)
+__EXTERN_INLINE u32 mcpcia_ioread32(const void __iomem *xaddr)
 {
 	unsigned long addr = (unsigned long)xaddr;
 
@@ -335,6 +336,26 @@ __EXTERN_INLINE void mcpcia_iowrite32(u32 b, void __iomem *xaddr)
 	*(vuip)addr = b;
 }
 
+__EXTERN_INLINE u64 mcpcia_ioread64(const void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long)xaddr;
+
+	if (!__mcpcia_is_mmio(addr))
+		addr = ((addr & 0xffff) << 5) + (addr & ~0xfffful) + 0x18;
+
+	return *(vulp)addr;
+}
+
+__EXTERN_INLINE void mcpcia_iowrite64(u64 b, void __iomem *xaddr)
+{
+	unsigned long addr = (unsigned long)xaddr;
+
+	if (!__mcpcia_is_mmio(addr))
+		addr = ((addr & 0xffff) << 5) + (addr & ~0xfffful) + 0x18;
+
+	*(vulp)addr = b;
+}
+
 
 __EXTERN_INLINE void __iomem *mcpcia_ioportmap(unsigned long addr)
 {
@@ -362,6 +383,7 @@ __EXTERN_INLINE int mcpcia_is_mmio(const volatile void __iomem *xaddr)
 
 #undef vip
 #undef vuip
+#undef vulp
 
 #undef __IO_PREFIX
 #define __IO_PREFIX		mcpcia
diff --git a/arch/alpha/include/asm/core_t2.h b/arch/alpha/include/asm/core_t2.h
index 12bb7addc789..ab956b1625b5 100644
--- a/arch/alpha/include/asm/core_t2.h
+++ b/arch/alpha/include/asm/core_t2.h
@@ -360,6 +360,7 @@ struct el_t2_frame_corrected {
 
 #define vip	volatile int *
 #define vuip	volatile unsigned int *
+#define vulp	volatile unsigned long *
 
 extern inline u8 t2_inb(unsigned long addr)
 {
@@ -402,6 +403,17 @@ extern inline void t2_outl(u32 b, unsigned long addr)
 	mb();
 }
 
+extern inline u64 t2_inq(unsigned long addr)
+{
+	return *(vulp) ((addr << 5) + T2_IO + 0x18);
+}
+
+extern inline void t2_outq(u64 b, unsigned long addr)
+{
+	*(vulp) ((addr << 5) + T2_IO + 0x18) = b;
+	mb();
+}
+
 
 /*
  * Memory functions.
@@ -572,7 +584,7 @@ __EXTERN_INLINE int t2_is_mmio(const volatile void __iomem *addr)
    it doesn't make sense to merge the pio and mmio routines.  */
 
 #define IOPORT(OS, NS)							\
-__EXTERN_INLINE unsigned int t2_ioread##NS(const void __iomem *xaddr)		\
+__EXTERN_INLINE u##NS t2_ioread##NS(const void __iomem *xaddr)		\
 {									\
 	if (t2_is_mmio(xaddr))						\
 		return t2_read##OS(xaddr);				\
@@ -590,11 +602,13 @@ __EXTERN_INLINE void t2_iowrite##NS(u##NS b, void __iomem *xaddr)	\
 IOPORT(b, 8)
 IOPORT(w, 16)
 IOPORT(l, 32)
+IOPORT(q, 64)
 
 #undef IOPORT
 
 #undef vip
 #undef vuip
+#undef vulp
 
 #undef __IO_PREFIX
 #define __IO_PREFIX		t2
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index a887628f2ea6..1c3605d874e9 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -155,6 +155,7 @@ static inline void generic_##NAME(TYPE b, QUAL void __iomem *addr)	\
 REMAP1(unsigned int, ioread8, const)
 REMAP1(unsigned int, ioread16, const)
 REMAP1(unsigned int, ioread32, const)
+REMAP1(u64, ioread64, const)
 REMAP1(u8, readb, const volatile)
 REMAP1(u16, readw, const volatile)
 REMAP1(u32, readl, const volatile)
@@ -163,6 +164,7 @@ REMAP1(u64, readq, const volatile)
 REMAP2(u8, iowrite8, /**/)
 REMAP2(u16, iowrite16, /**/)
 REMAP2(u32, iowrite32, /**/)
+REMAP2(u64, iowrite64, /**/)
 REMAP2(u8, writeb, volatile)
 REMAP2(u16, writew, volatile)
 REMAP2(u32, writel, volatile)
@@ -400,12 +402,27 @@ extern inline unsigned int ioread32(const void __iomem *addr)
 	return ret;
 }
 
+extern inline u64 ioread64(const void __iomem *addr)
+{
+	unsigned int ret;
+	mb();
+	ret = IO_CONCAT(__IO_PREFIX,ioread64)(addr);
+	mb();
+	return ret;
+}
+
 extern inline void iowrite32(u32 b, void __iomem *addr)
 {
 	mb();
 	IO_CONCAT(__IO_PREFIX, iowrite32)(b, addr);
 }
 
+extern inline void iowrite64(u64 b, void __iomem *addr)
+{
+	mb();
+	IO_CONCAT(__IO_PREFIX, iowrite64)(b, addr);
+}
+
 extern inline u32 inl(unsigned long port)
 {
 	return ioread32(ioport_map(port, 4));
@@ -418,7 +435,9 @@ extern inline void outl(u32 b, unsigned long port)
 #endif
 
 #define ioread32 ioread32
+#define ioread64 ioread64
 #define iowrite32 iowrite32
+#define iowrite64 iowrite64
 
 #if IO_CONCAT(__IO_PREFIX,trivial_rw_bw) == 1
 extern inline u8 __raw_readb(const volatile void __iomem *addr)
diff --git a/arch/alpha/include/asm/io_trivial.h b/arch/alpha/include/asm/io_trivial.h
index a1a29cbe02fa..00032093bcfc 100644
--- a/arch/alpha/include/asm/io_trivial.h
+++ b/arch/alpha/include/asm/io_trivial.h
@@ -6,13 +6,13 @@
 /* This file may be included multiple times.  */
 
 #if IO_CONCAT(__IO_PREFIX,trivial_io_bw)
-__EXTERN_INLINE unsigned int
+__EXTERN_INLINE u8
 IO_CONCAT(__IO_PREFIX,ioread8)(const void __iomem *a)
 {
 	return __kernel_ldbu(*(const volatile u8 __force *)a);
 }
 
-__EXTERN_INLINE unsigned int
+__EXTERN_INLINE u16
 IO_CONCAT(__IO_PREFIX,ioread16)(const void __iomem *a)
 {
 	return __kernel_ldwu(*(const volatile u16 __force *)a);
@@ -32,7 +32,7 @@ IO_CONCAT(__IO_PREFIX,iowrite16)(u16 b, void __iomem *a)
 #endif
 
 #if IO_CONCAT(__IO_PREFIX,trivial_io_lq)
-__EXTERN_INLINE unsigned int
+__EXTERN_INLINE u32
 IO_CONCAT(__IO_PREFIX,ioread32)(const void __iomem *a)
 {
 	return *(const volatile u32 __force *)a;
@@ -43,6 +43,18 @@ IO_CONCAT(__IO_PREFIX,iowrite32)(u32 b, void __iomem *a)
 {
 	*(volatile u32 __force *)a = b;
 }
+
+__EXTERN_INLINE u64
+IO_CONCAT(__IO_PREFIX,ioread64)(const void __iomem *a)
+{
+	return *(const volatile u64 __force *)a;
+}
+
+__EXTERN_INLINE void
+IO_CONCAT(__IO_PREFIX,iowrite64)(u64 b, void __iomem *a)
+{
+	*(volatile u64 __force *)a = b;
+}
 #endif
 
 #if IO_CONCAT(__IO_PREFIX,trivial_rw_bw) == 1
diff --git a/arch/alpha/include/asm/jensen.h b/arch/alpha/include/asm/jensen.h
index 1c4131453db2..66eb049eb421 100644
--- a/arch/alpha/include/asm/jensen.h
+++ b/arch/alpha/include/asm/jensen.h
@@ -98,6 +98,7 @@ __EXTERN_INLINE void jensen_set_hae(unsigned long addr)
 }
 
 #define vuip	volatile unsigned int *
+#define vulp	volatile unsigned long *
 
 /*
  * IO functions
@@ -183,6 +184,12 @@ __EXTERN_INLINE u32 jensen_inl(unsigned long addr)
 	return *(vuip) ((addr << 7) + EISA_IO + 0x60);
 }
 
+__EXTERN_INLINE u64 jensen_inq(unsigned long addr)
+{
+	jensen_set_hae(0);
+	return *(vulp) ((addr << 7) + EISA_IO + 0x60);
+}
+
 __EXTERN_INLINE void jensen_outw(u16 b, unsigned long addr)
 {
 	jensen_set_hae(0);
@@ -197,6 +204,13 @@ __EXTERN_INLINE void jensen_outl(u32 b, unsigned long addr)
 	mb();
 }
 
+__EXTERN_INLINE void jensen_outq(u64 b, unsigned long addr)
+{
+	jensen_set_hae(0);
+	*(vulp) ((addr << 7) + EISA_IO + 0x60) = b;
+	mb();
+}
+
 /*
  * Memory functions.
  */
@@ -305,7 +319,7 @@ __EXTERN_INLINE int jensen_is_mmio(const volatile void __iomem *addr)
    that it doesn't make sense to merge them.  */
 
 #define IOPORT(OS, NS)							\
-__EXTERN_INLINE unsigned int jensen_ioread##NS(const void __iomem *xaddr)	\
+__EXTERN_INLINE u##NS jensen_ioread##NS(const void __iomem *xaddr)	\
 {									\
 	if (jensen_is_mmio(xaddr))					\
 		return jensen_read##OS(xaddr - 0x100000000ul);		\
@@ -323,10 +337,12 @@ __EXTERN_INLINE void jensen_iowrite##NS(u##NS b, void __iomem *xaddr)	\
 IOPORT(b, 8)
 IOPORT(w, 16)
 IOPORT(l, 32)
+IOPORT(q, 64)
 
 #undef IOPORT
 
 #undef vuip
+#undef vulp
 
 #undef __IO_PREFIX
 #define __IO_PREFIX		jensen
diff --git a/arch/alpha/include/asm/machvec.h b/arch/alpha/include/asm/machvec.h
index e49fabce7b33..8623f995d34c 100644
--- a/arch/alpha/include/asm/machvec.h
+++ b/arch/alpha/include/asm/machvec.h
@@ -46,13 +46,15 @@ struct alpha_machine_vector
 	void (*mv_pci_tbi)(struct pci_controller *hose,
 			   dma_addr_t start, dma_addr_t end);
 
-	unsigned int (*mv_ioread8)(const void __iomem *);
-	unsigned int (*mv_ioread16)(const void __iomem *);
-	unsigned int (*mv_ioread32)(const void __iomem *);
+	u8 (*mv_ioread8)(const void __iomem *);
+	u16 (*mv_ioread16)(const void __iomem *);
+	u32 (*mv_ioread32)(const void __iomem *);
+	u64 (*mv_ioread64)(const void __iomem *);
 
 	void (*mv_iowrite8)(u8, void __iomem *);
 	void (*mv_iowrite16)(u16, void __iomem *);
 	void (*mv_iowrite32)(u32, void __iomem *);
+	void (*mv_iowrite64)(u64, void __iomem *);
 
 	u8 (*mv_readb)(const volatile void __iomem *);
 	u16 (*mv_readw)(const volatile void __iomem *);
diff --git a/arch/alpha/kernel/io.c b/arch/alpha/kernel/io.c
index 838586abb1e0..eda09778268f 100644
--- a/arch/alpha/kernel/io.c
+++ b/arch/alpha/kernel/io.c
@@ -41,6 +41,15 @@ unsigned int ioread32(const void __iomem *addr)
 	return ret;
 }
 
+u64 ioread64(const void __iomem *addr)
+{
+	unsigned int ret;
+	mb();
+	ret = IO_CONCAT(__IO_PREFIX,ioread64)(addr);
+	mb();
+	return ret;
+}
+
 void iowrite8(u8 b, void __iomem *addr)
 {
 	mb();
@@ -59,12 +68,20 @@ void iowrite32(u32 b, void __iomem *addr)
 	IO_CONCAT(__IO_PREFIX,iowrite32)(b, addr);
 }
 
+void iowrite64(u64 b, void __iomem *addr)
+{
+	mb();
+	IO_CONCAT(__IO_PREFIX,iowrite64)(b, addr);
+}
+
 EXPORT_SYMBOL(ioread8);
 EXPORT_SYMBOL(ioread16);
 EXPORT_SYMBOL(ioread32);
+EXPORT_SYMBOL(ioread64);
 EXPORT_SYMBOL(iowrite8);
 EXPORT_SYMBOL(iowrite16);
 EXPORT_SYMBOL(iowrite32);
+EXPORT_SYMBOL(iowrite64);
 
 u8 inb(unsigned long port)
 {
diff --git a/arch/alpha/kernel/machvec_impl.h b/arch/alpha/kernel/machvec_impl.h
index 393d5d6ca5d2..c2ebcb39e589 100644
--- a/arch/alpha/kernel/machvec_impl.h
+++ b/arch/alpha/kernel/machvec_impl.h
@@ -78,9 +78,11 @@
 	.mv_ioread8 =		CAT(low,_ioread8),			\
 	.mv_ioread16 =		CAT(low,_ioread16),			\
 	.mv_ioread32 =		CAT(low,_ioread32),			\
+	.mv_ioread64 =		CAT(low,_ioread64),			\
 	.mv_iowrite8 =		CAT(low,_iowrite8),			\
 	.mv_iowrite16 =		CAT(low,_iowrite16),			\
 	.mv_iowrite32 =		CAT(low,_iowrite32),			\
+	.mv_iowrite64 =		CAT(low,_iowrite64),			\
 	.mv_readb =		CAT(low,_readb),			\
 	.mv_readw =		CAT(low,_readw),			\
 	.mv_readl =		CAT(low,_readl),			\
