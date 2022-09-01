Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EDE5A908F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiIAHky (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 03:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiIAHkw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 03:40:52 -0400
X-Greylist: delayed 342 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Sep 2022 00:40:51 PDT
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742AFDDAAD;
        Thu,  1 Sep 2022 00:40:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 887292B05A2D;
        Thu,  1 Sep 2022 03:34:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 01 Sep 2022 03:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662017698; x=1662021298; bh=JdVAEezLJe
        Agx2YVhc/NJHbjC9th6TpBpDiZFu9hugA=; b=J8zSmTAtur+4BVg4IPbTrKBlN9
        hA04HZKhiXHN9C38ljRP4TOOZE5QI1RwIp9VQ8+xmo4QZy9X0zVe5czFVhaN8CrX
        OF43N1iP0yPBVK8rpNUueZDo3Kk2t637cWeBRgn7rQ0IkuZ/Nycpv5I3C8RrdCVj
        bJz0dznhkaMRwO3sVucJsJSqQNbtF6wx0dA4uE0m/FAhSlOtaQio6+RN/K8Ey7vr
        uPfhd/nmTWMgSEALMFOc/+oheNGXAB42VSf29zQetq5ohLLhZdLMcSAm6cd8F+id
        QTFMejPmXTXoi9d+JMWElBoIQninkw44mFb5rBMSuIAL+rq9tlcYYoWhKs5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662017698; x=1662021298; bh=JdVAEezLJeAgx2YVhc
        /NJHbjC9th6TpBpDiZFu9hugA=; b=LKJidikKhhCZlRzfau8V9cJOLb6gOphpvL
        zYHVhxVXLWIjEUJP189g63Rg9pfBo+uoK7hfChGImnHuvRDvjpitt3sN+w1jCPzt
        6tmhgVYF+GJpe0eeobXSEylRH57Aqs1DTl8rOy/TOPXl8nUW1lXY5pf4vU5umMeG
        lNZglHJXfoun1Evwj3kTdR5dBG9laslKuB9hgC5XPrE7DgWr3FAT2+wFcPpgG1V6
        9V5hbzsZfVqTeoa/JN0YQl0hwqehjgl7ES9wjc+6uv5P4p0ek7BTEmooneyNKBFB
        5Rro1do4BPpz4fVQdgt4BQldhPnrHiIO4d1nxVoi4Ru6pHhpHqdQ==
X-ME-Sender: <xms:oWAQY23zvbz9JP_-dEpKNnFmsrhFMQmaZPLleNbWv24sdnM5ZxPt7g>
    <xme:oWAQY5GvBjw71_5tBV1Hs-2JvYpROSdd-WstZXI7LebG5yr05bkzNsC5LVqsFw2l3
    KVFdWNnlsqN92zd3WQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekjedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oWAQY-5eoR8NZA7vWlBYlFkTJdXDj3jSYUzw2oWvICo-LzkhG4Flxg>
    <xmx:oWAQY32rSp_YTDYEZjjlg1jUeWFeQImcqxydSzfPQKsBMvNM87fV1g>
    <xmx:oWAQY5EWXaIs3vvWlZ5TprEi6Khv4-WrY1P93m6jjmHb_qeSQeD3Hw>
    <xmx:oWAQY9j6Ftfb8fjZ1_5Bydh5D7N6PWXwyVOvwmKzFIEhuW7IEo5rMVklh_0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 876D4B60083; Thu,  1 Sep 2022 03:34:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <5b1f418e-3705-4093-9a13-3fe7793ed520@www.fastmail.com>
In-Reply-To: <20220831214447.273178-1-linus.walleij@linaro.org>
References: <20220831214447.273178-1-linus.walleij@linaro.org>
Date:   Thu, 01 Sep 2022 09:34:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] parisc: Use the generic IO helpers
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

On Wed, Aug 31, 2022, at 11:44 PM, Linus Walleij wrote:
> @@ -135,35 +135,43 @@ static inline unsigned char __raw_readb(const 
> volatile void __iomem *addr)
>  {
>  	return (*(volatile unsigned char __force *) (addr));
>  }
> +#define __raw_readb __raw_readb
>  static inline unsigned short __raw_readw(const volatile void __iomem 
> *addr)
>  {
>  	return *(volatile unsigned short __force *) addr;
>  }
> +#define __raw_readw __raw_readw

These are the same as the asm-generic version, so it might
be nice to just use those and remove the duplicates.

The readl() etc wrappers around them are more complicated in
the generic version, and may require to #define the
__io_ar()/__io_bw(() etc to nothing to avoid adding extra
barriers. Not sure if we want to go so far, or if parisc
is actually correct here: Most RISC architectures do need
barriers between a readl/writel and a corresponding DMA,
so pa-risc would be an exception here for not needing
them.

>  #include <asm-generic/iomap.h>
> +/* These get provided from <asm-generic/iomap.h> */
> +#define ioport_map ioport_map
> +#define ioport_unmap ioport_unmap
> +#define ioread8 ioread8
> +#define ioread16 ioread16
> +#define ioread32 ioread32
> +#define ioread16be ioread16be
> +#define ioread32be ioread32be
> +#define iowrite8 iowrite8
> +#define iowrite16 iowrite16
> +#define iowrite32 iowrite32
> +#define iowrite16be iowrite16be
> +#define iowrite32be iowrite32be
> +#define ioread8_rep ioread8_rep
> +#define ioread16_rep ioread16_rep
> +#define ioread32_rep ioread32_rep
> +#define iowrite8_rep iowrite8_rep
> +#define iowrite16_rep iowrite16_rep
> +#define iowrite32_rep iowrite32_rep

You should not need these overrides here, since the
definitions in asm-generic/io.h are only relevant
for the !CONFIG_GENERIC_IOMAP case, i.e. architectures
that can access port I/O through MMIO rather than
special helper functions or instructions.

Somewhat unrelated to your series, I suppose it would be
great if we could move the "#include <asm-generic/iomap.h>"
to include/asm-generic/io.h itself for the
CONFIG_GENERIC_IOMAP case. Hopefully each architecture
uses one case or the other.

      Arnd
