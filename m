Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A495AAA2F
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 10:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiIBIhF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235750AbiIBIgp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 04:36:45 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FD37DF63;
        Fri,  2 Sep 2022 01:35:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9E8BE580FBC;
        Fri,  2 Sep 2022 04:34:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 02 Sep 2022 04:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662107676; x=1662111276; bh=R9KRb2+qfc
        +NXDxoZc4lm6ZtQoCr/7j6HjXmzaGE5LM=; b=cFcxuYC+KQw/iBCbsChIU/1HLA
        DebgX+OZ9OFqNVatnLppkWb2Lw07c0nQMCTzMBur13FjgZ44OkOe9Q+NAJjo5Z1A
        5FqgA6VfGar9GJ60xdGxLRVCBV/Z919m/jWbYcfr50vRawyf4T/Fgyg9z8lJIvf5
        8d/ehSqY6dDpbb/h6bpt0Rk/7nVj3buFAkxFoGvsCaUXtIATJMZHocXslEa+4xDP
        2V26Tb6EyRr4LmqFI+BIHrLETXiQLvnSTkr5JIqCl1xpQtaw1Vfejn9QtzW3mdJD
        OYOX8mtkDOSVe4wq1ZaMOYcDhc4PZbRANNWt+C/ipF/7AL7HX3vu4lOo/5EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662107676; x=1662111276; bh=R9KRb2+qfc+NXDxoZc
        4lm6ZtQoCr/7j6HjXmzaGE5LM=; b=yOHCwhGnncJkVl4Sh93oZgUdckvPrk8pOO
        at27zLzlekp+UDM7XZl4ZueDpgbB+itmDPRW1WvfPM8apB0zjUDyjDrMDTG9zoP0
        D9eYESdClOH/07Q03bNHYmW9l+s2/pD1ApywzSgqzcKKCBgsGWFvIEJdSLfNLuKT
        3PdDUTIt9hSIOld503JJu2XATMh57L5OarFnxrBhLbLVqv0eGezqoEhoaxB5JTp7
        HYhLBt7jw4DIdkcvs85UVJWv/i6tsVvMpfpcxbfycpsZ8CitIySqe6TivaMPOv/b
        +RDemMZxF9IBvnlyWa5pvHiUkYjPljGLdZHhr3KtNjZSX9p2aiiA==
X-ME-Sender: <xms:G8ARYxOEA5P8Nn22KtdjREhjYNay_A61TGlyTebJi0y0puJ2MfCwSA>
    <xme:G8ARYz9qokRMPGRDuBf5QRu3QtRv2UAzt4wTfqT5lFDfKHYgbZmb5-o1TRMG9fsT8
    7k9rSmmYdCLKT0BIGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeltddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:G8ARYwQvELCWYswz1uYXig9D1zMNdpKRi8QCT2hKOrgQrWhGt-k5Aw>
    <xmx:G8ARY9sItZXAP7oec1G4T7MdhUNhgwutlvvjMPl8aPRNuAQc_2PtMg>
    <xmx:G8ARY5dLMbSGljTQmlhN-Aejkkr26kzH3uoMG9GBaNiS9hPNfFdUAA>
    <xmx:HMARY94RlhUJKA1E70740ghdKJmQ8QGAX_1pG0U2GKQQxK6gFnfiuA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2E040B60083; Fri,  2 Sep 2022 04:34:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <09b66764-55b1-4ea7-994c-0f383905ea65@www.fastmail.com>
In-Reply-To: <20220902075122.339753-1-linus.walleij@linaro.org>
References: <20220902075122.339753-1-linus.walleij@linaro.org>
Date:   Fri, 02 Sep 2022 10:34:06 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "John David Anglin" <dave.anglin@bell.net>
Subject: Re: [PATCH 1/2 v3] parisc: Remove 64bit access on 32bit machines
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 2, 2022, at 9:51 AM, Linus Walleij wrote:
> The parisc was using some readq/writeq accessors without special
> considerations as to what will happen on 32bit CPUs if you do
> this. Maybe we have been lucky that it "just worked" on 32bit
> due to the compiler behaviour, or the code paths were never
> executed.
> ...

Patch looks correct to me and does address the issue.
A few minor points though:

> diff --git a/arch/parisc/lib/iomap.c b/arch/parisc/lib/iomap.c
> index 860385058085..d3d57119df64 100644
> --- a/arch/parisc/lib/iomap.c
> +++ b/arch/parisc/lib/iomap.c
> @@ -48,15 +48,19 @@ struct iomap_ops {
>  	unsigned int (*read16be)(const void __iomem *);
>  	unsigned int (*read32)(const void __iomem *);
>  	unsigned int (*read32be)(const void __iomem *);
> +#ifdef CONFIG_64BIT
>  	u64 (*read64)(const void __iomem *);
>  	u64 (*read64be)(const void __iomem *);
> +#endif
>  	void (*write8)(u8, void __iomem *);
>  	void (*write16)(u16, void __iomem *);
>  	void (*write16be)(u16, void __iomem *);
>  	void (*write32)(u32, void __iomem *);
>  	void (*write32be)(u32, void __iomem *);
> +#ifdef CONFIG_64BIT
>  	void (*write64)(u64, void __iomem *);
>  	void (*write64be)(u64, void __iomem *);
> +#endif
>  	void (*read8r)(const void __iomem *, void *, unsigned long);
>  	void (*read16r)(const void __iomem *, void *, unsigned long);
>  	void (*read32r)(const void __iomem *, void *, unsigned long);

I would not bother with the #ifdef checks in the structure definition,
but they don't hurt either, and we need the other ones anyway.
Up to you (or the maintainers).

> @@ -127,14 +128,21 @@ MODULE_PARM_DESC(sba_reserve_agpgart, "Reserve 
> half of IO pdir as AGPGART");
>  ** Superdome (in particular, REO) allows only 64-bit CSR accesses.
>  */
>  #define READ_REG32(addr)	readl(addr)
> -#define READ_REG64(addr)	readq(addr)
>  #define WRITE_REG32(val, addr)	writel((val), (addr))
> -#define WRITE_REG64(val, addr)	writeq((val), (addr))
> 
>  #ifdef CONFIG_64BIT
> +#define READ_REG64(addr)	readq(addr)
> +#define WRITE_REG64(val, addr)	writeq((val), (addr))
>  #define READ_REG(addr)		READ_REG64(addr)
>  #define WRITE_REG(value, addr)	WRITE_REG64(value, addr)
>  #else
> +/*
> + * The semantics of 64 register access on 32bit systems i undefined in the
> + * C standard, we hop the _lo_hi() macros will behave as the default compiled
> + * from C raw assignment.

typos: 'i' and 'hop'

The description is also slightly misleading, as it's not the
C standard specifically saying something about 64-bit accesses
on 32-bit targets being non-atomic, it's more that C doesn't
make a guarantee here at all, and the CPU probably can't do
double word accesses.

> +#define READ_REG64(addr)	ioread64_lo_hi(addr)
> +#define WRITE_REG64(val, addr)	iowrite64_lo_hi((val), (addr))


This change should not be needed here, as simply including the
io-64-nonatomic-lo-hi.h header gives you a working definition
of readq()/writeq(). Going through the ioread64/iowrite64 type
interfaces instead of the readq/writeq also gives you an extra
indirection that you don't really need. On Arm machines these
are the same, but they are different on parisc or x86 where
ioread multiplexes between PCI port and memory spaces.

      Arnd
