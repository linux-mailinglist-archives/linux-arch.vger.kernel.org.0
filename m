Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5D70A133
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjESVFy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 17:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjESVFx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 17:05:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6C81A4;
        Fri, 19 May 2023 14:05:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8B46432009AA;
        Fri, 19 May 2023 17:05:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 May 2023 17:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684530349; x=1684616749; bh=Xr
        THEyJu1Ni599Pw9MkGcF8SgZL4/WA/RkzXdqbqqVk=; b=cxrKgkURIaZOGGwbJ1
        WJj8/uOqVm1Zq17L3xVPbZWnLLJ2eWblh37yZAPNLDF+aT2Y3VtT1JBGIsoQlb5P
        OqifYhhFqcWxeBey3qoWg5Gwde18xNFC8F2BOpNGN8YDwq+8T0lInJbCR9X2HeZE
        bm6EcncD9CdLFWXJffXyfCa3afIi8e4GAif0L1JXIMzKoyEQ4VDgPe1ew3TEhZAR
        Sr+CeY2W/EeFDLn8w6RBsazxXPD1kFQGWvt2vb3JIDZv20rQi8oSbgFf2jdmbzTg
        lIimmNFlsVW9Fjih+C30OCSOsSFwwWCMdFEoxy3I3FV8xwA08Ida1bVWy8r0Uhsk
        FgSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684530349; x=1684616749; bh=XrTHEyJu1Ni59
        9Pw9MkGcF8SgZL4/WA/RkzXdqbqqVk=; b=cmfsSoVVA6cL0NnDAuWL/58VOPscJ
        8++7h6MRZv0Davqkumh9w4QvAwzLF8KrwcszevUPGbeCs4ZnsubAmGETOJ442pLp
        p7K6ijWRcoIooRiX3eosNfIklCVsynai2Z1RZkaiWY/etEBO8P+EhLO5ETchhHz8
        iuLKRnRJuSTlMc0aJfKsmV8VY80crs8Z3cbZOFvXYk+Nf32YlPMylWLEgKvYrXqt
        TBL1UV3vDLZU4jFHXQ6d9pUgs9HQz8zcrb112Xgblw9m0BjEZfjJLNGxLNMbUzyy
        HYpxXT/YSU8KJWcUjfItXvVaTRVBr6vK51QfsoaWJ9l0wvyhLKh/Ehqrw==
X-ME-Sender: <xms:rORnZOXE6nMakSfyaImY2XgebGe3k2uVibDh0M45f99nYHHCjdKZHQ>
    <xme:rORnZKmv7ajOEab8AF3V2aF-4TeU47E_0Qa4QwMG0lwXDvZauiA3PNl3rK-d5SFol
    7YcZASiH-ZvU01O0wY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:rORnZCb5Me427u9H4BrdQmdsYN5XnCf5vssiNlKJhKE2Fe_g-Tg0tw>
    <xmx:rORnZFWlCjnC5zYIdh4PfmfQ9uWALoyVbaVErxBbdsj3ZID0-a_h4g>
    <xmx:rORnZImHsjaR9okEhHXeFM8gAU0XbfZjvwSYI-XtbeMTih6Jp1NLIQ>
    <xmx:reRnZJD_Udob72N_Nzm-OtbWo5LIZdnkCQDCrt1gzA1I92AF824E-g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9163AB6008D; Fri, 19 May 2023 17:05:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <dae342ed-8999-4fa5-b719-322182580025@app.fastmail.com>
In-Reply-To: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
References: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
Date:   Fri, 19 May 2023 23:05:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiaxun Yang" <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Baoquan He" <bhe@redhat.com>,
        "Huacai Chen" <chenhuacai@kernel.org>
Subject: Re: [PATCH v4] mips: add <asm-generic/io.h> including
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 19, 2023, at 21:51, Jiaxun Yang wrote:
> With the adding, some default ioremap_xx methods defined in
> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> NULL.
>
> We also massaged various headers to avoid nested includes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> [jiaxun.yang@flygoat.com: Massage more headers, fix ioport defines]
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org
> ---
> Tested against qemu malta 34Kf, boston I6500, Loongson64, hopefully
> everything is fine now.

Thanks a lot for figuring this out!
> 
> @@ -44,6 +42,11 @@
>  # define __raw_ioswabq(a, x)	(x)
>  # define ____raw_ioswabq(a, x)	(x)
> 
> +# define _ioswabb ioswabb
> +# define _ioswabw ioswabw
> +# define _ioswabl ioswabl
> +# define _ioswabq ioswabq
> +

I'm missing something here, what are these macros used for in addition
to the non-underscore versions?

> +#define memset_io memset_io
>  static inline void memset_io(volatile void __iomem *addr, unsigned 
> char val, int count)
>  {
>  	memset((void __force *) addr, val, count);
>  }
> +#define memcpy_fromio memcpy_fromio
>  static inline void memcpy_fromio(void *dst, const volatile void 
> __iomem *src, int count)
>  {
>  	memcpy(dst, (void __force *) src, count);
>  }
> +#define memcpy_toio memcpy_toio
>  static inline void memcpy_toio(volatile void __iomem *dst, const void 
> *src, int count)
>  {
>  	memcpy((void __force *) dst, src, count);

These three could probably go away now, as they are identical
to the asm-generic version. Not important though.

> @@ -549,6 +555,47 @@ extern void (*_dma_cache_inv)(unsigned long start, 
> unsigned long size);
>  #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + 
> __CSR_32_ADJUST) = (v))
>  #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + 
> __CSR_32_ADJUST))
> 
> +
> +#define __raw_readb __raw_readb
> +#define __raw_readw __raw_readw
> +#define __raw_readl __raw_readl
> +#define __raw_readq __raw_readq
> +#define __raw_writeb __raw_writeb
> +#define __raw_writew __raw_writew
> +#define __raw_writel __raw_writel
> +#define __raw_writeq __raw_writeq
> +
> +#define readb readb
> +#define readw readw
> +#define readl readl
> +#define writeb writeb
> +#define writew writew
> +#define writel writel
> +
> +#define readsb readsb
> +#define readsw readsw
> +#define readsl readsl
> +#define readsq readsq
> +#define writesb writesb
> +#define writesw writesw
> +#define writesl writesl
> +#define writesq writesq

As far as I can tell, the readsq()/writesq() helpers are currently
only defined on 64-bit, it's probably best to leave it that way.

On most other architectures, we also don't define __raw_readq()
and __raw_writeq() on 32-bit because they lose the atomicity that
might be required for FIFO accesses, but the existing MIPS version
has them, so changing those should be a separate patch after it
can be shown to not break anything.

     Arnd
