Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127116A6DD6
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 15:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCAOHW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 09:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAOHV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 09:07:21 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34672A6F3;
        Wed,  1 Mar 2023 06:07:20 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 52EA25C00E2;
        Wed,  1 Mar 2023 09:07:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 01 Mar 2023 09:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677679639; x=1677766039; bh=5m3HfYKwmw
        BaOjWZWUy6qvDlncIvme0bGcT9RvLhnCs=; b=NY6zRLj9LNQXp1PiMPVL+Sr2oM
        7BYgON/qWAtNrM7M8WK2lJjFXaTtPW4TtKYCcqbe47p//ahHMaHQLwWFuIFATzjk
        KeqqWMXthvgK6HbJf2swGC57Xh3eXlECzJiL0gb5jDESuRLq6HNxOCT1146Xgx55
        ijgcnmQaLTV3bBWWFboOhI4iAcpadeSB6l4B3KOZMqN+I+1aMsLrcmMZq3WgDZCb
        v1+MXnjnnCKnOUAmqlHIHwnIHo18eTxn17OueOcnYbiy0ISVe2dEvnICjwgTDT0y
        ix2Ubj7mtVdljq1Qt9nDwyFDEBOLeZ58cjofqrckolUcunsiEIuE2k7lbWiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677679639; x=1677766039; bh=5m3HfYKwmwBaOjWZWUy6qvDlncIv
        me0bGcT9RvLhnCs=; b=PAmVBsQn04eoXV7tafopSDqW1GPJUefcqlmXK9zwvsJo
        uuXz52sQwkE8j/aIiAR8OtC3BOTi2V1EhCRZqi9sw5Tl5ruA+b0iI4ip2AXvLh3C
        oh/shkGAA8TP3P3irDX9SBcugi1Q6yYpnUw4EkBrQRAkOCCPnnIP9iR23uFGqXAw
        q6wNgyzecjaVQSGPlMDd9d+hJAF2SOiWmXB0HS7hG+/vchOIuyAiu67MO/E1fZcj
        AS7BdrOkWre003ihJhlHjCarbJEfKLuJm6mBas3w0m7mnJjqCso8FGoYTqVgDoIT
        NpakBSvosoXDk/GmDa9DaQokJmngemfbheJzVwvIDw==
X-ME-Sender: <xms:Flz_Y-6iYkpWayTgX_kvG8bGxQCJVEFZGZAD2Htm2St55dKROFxhDw>
    <xme:Flz_Y35Pvyn1jvLk6NqQpK2Zq7UOkx6AYgeeBRceeijNcsdOpphBA_4pg90cfCQQR
    U_-mDCzy34bTy4NxZM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelhedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Flz_Y9dkaCvlP0KTkAp3mSa7p7S6FrpWjQy1ymSo2jCIvSRSEwws_w>
    <xmx:Flz_Y7KFI_NnNmyeL72FqzLSh9wnuUzJsR0x0_QkZ0WNk7Sq8ZvGhg>
    <xmx:Flz_YyKdmUhH8jKDqt2ZkQbejONqtT6589g5X_ofrnURKoO9Cw44-A>
    <xmx:F1z_Yx8xZl81ocms4LScCca1AOq3aloCOes4YRCeOUaNNW2PfAL9Kg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 75B41B60089; Wed,  1 Mar 2023 09:07:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <5edd5304-ef11-4607-9189-a07613ecfee2@app.fastmail.com>
In-Reply-To: <20230301102208.148490-2-bhe@redhat.com>
References: <20230301102208.148490-1-bhe@redhat.com>
 <20230301102208.148490-2-bhe@redhat.com>
Date:   Wed, 01 Mar 2023 15:06:57 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: add <asm-generic/io.h> including
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

On Wed, Mar 1, 2023, at 11:22, Baoquan He wrote:
> With the adding, some default ioremap_xx methods defined in
> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> NULL.
>
> Here, remove the <asm/io.h> including in asm/mmiowb.h, otherwise nested
> including will cause compiling error.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org

This looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

but it obviously needs to be properly reviewed by the MIPS
maintainers as well. I think others have tried to do this
in the past but did not make it in.

> @@ -548,6 +552,46 @@ extern void (*_dma_cache_inv)(unsigned long start, 
> unsigned long size);
>  #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + 
> __CSR_32_ADJUST) = (v))
>  #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + 
> __CSR_32_ADJUST))
> 
> +
> +#define inb_p inb_p
> +#define inw_p inw_p
> +#define inl_p inl_p
> +#define insb insb
> +#define insw insw
> +#define insl insl

I would prefer to put the #defines next to the function declarations,
even when they come from macros.

> 
> -#include <asm/io.h>
> -
>  #define mmiowb()	iobarrier_w()
> 

I think this only works as long as asm/spinlock.h also includes
asm/io.h, otherwise linux/spinlock.h will be missing the
iobarrier_w definition.

Most likely this is implicitly included from somewhere else
below linux/spinlock.h, but it would be better not to rely
on that, and instead define mmiowb() to wmb() directly.

     Arnd
