Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420735AAAB3
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 10:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiIBIzs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 04:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236048AbiIBIzr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 04:55:47 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F036A60506;
        Fri,  2 Sep 2022 01:55:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 029292B05A6E;
        Fri,  2 Sep 2022 04:55:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 02 Sep 2022 04:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662108941; x=1662112541; bh=PBzCn3EDIk
        KPXWFIbtgWW+zB4R9uRwOO84jR4tzdkfY=; b=rG7rAoFiMigO2ukqYERqKKuDbU
        QLmAqESC7+gr2ttUk9iCeIxAjK+Y5BH5s9aHlWmettTyXao7L/cKYuzLEhEk57t+
        p/WTSUOBHll6tejgYWDEqCx2Obu31PCdD+7omAtCBiM5ZxAmJ/SGzqI7VH74RLl/
        J2YGr2bxarptO1EAtU1ZM4i5x9iaHjN+hpAOiGDToy7zfhksXK2qY253+S9kw64s
        NQUSWeFXKhOuNaTgBDPLUdyvJAoG4Ck6IvOTaFSZWAScJeYPy45uplVup8vCfKYo
        ZVyuYnP3qhNtnLstXivu7k8xIjMUtVv8aK2/wbxhT6Xqfx8XDPUEG5mbCsqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662108941; x=1662112541; bh=PBzCn3EDIkKPXWFIbt
        gWW+zB4R9uRwOO84jR4tzdkfY=; b=wWZyCR59uwL3Vlh5WysPJ0F+iAHXh0HKs2
        UmZY4OlZl5JgSqxD/3TNVDjO0QnSWWOF+UxUHpiecVAe20WN7jY34/xel0iC0/B1
        Vw0NsPf4gcjMeB3U99D6K2NfGBajiXcgJOQe5UKpOPPrYk4g7SIMsI0sJGHKRXkQ
        IbRMjQ2vOpz12Q6OLpA0FR/CzYN0avqxLw6ZDyf8TCOA672FHAdyBBxJ0ySlgM3a
        /YGsc/bnggsiGb8yHGDq9Hy55okXFQXAgBmsX9OXmmdXv/LSOPmEIu+3JPMJ6Keo
        PekU9d2+IoS5t9lt7Mg7/2iQBa6j9bQWj29Hgt7g64OY8iD8ldTw==
X-ME-Sender: <xms:DcURYx72yFLJ7OUcB4qSA6MuFAf7ab2Fe4izYNYO812ndcluKj3r4Q>
    <xme:DcURY-7aTfxluBNDwqxQHzZrgXI6RrMaIfSHxc9pyMIf11Sjsgzrz7HKRnVWY87dX
    2YN2Z1VGFvsxWL3Klk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeltddgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:DcURY4djoI4Fj_841P5-Ws5BIgzp2jeO1i4uvgcacliaLr8Z_rlApw>
    <xmx:DcURY6IWDeugF7gKQVQqXfZW79cij3jn_yvhz582Ivk13UJPIDm9nw>
    <xmx:DcURY1Lzg2xyqa5ytJJXssS-_W9u1kGvMOaQ34Bcn11WnWPPQ-YEjQ>
    <xmx:DcURYzhm7PyI71qxNZuNm3m8KUsHCGfPEZFzmdrCpfayYmocJZNBsKJb4Lg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 311CEB60086; Fri,  2 Sep 2022 04:55:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <3b31b5e0-4bca-464d-adfe-ebdb2b68eece@www.fastmail.com>
In-Reply-To: <20220902075122.339753-2-linus.walleij@linaro.org>
References: <20220902075122.339753-1-linus.walleij@linaro.org>
 <20220902075122.339753-2-linus.walleij@linaro.org>
Date:   Fri, 02 Sep 2022 10:55:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Mark Brown" <broonie@kernel.org>,
        "John David Anglin" <dave.anglin@bell.net>
Subject: Re: [PATCH 2/2 v3] parisc: Use the generic IO helpers
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
> This enables the parisc to use <asm-generic/io.h> to fill in the
> missing (undefined) [read|write]sq I/O accessor functions.
>
> This is needed if parisc[64] ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that parisc64, while being a 64bit platform,
> as of now not yet provide.
>
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
>
> Bite the bullet and just provide the definitions and make it work.
> Compile-tested on parisc32 and parisc64. Drop some of the __raw
> functions that now get implemented in <asm-generic/io.h>.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: 
> https://lore.kernel.org/linux-arm-kernel/62fcc351.hAyADB%2FY8JTxz+kh%25lkp@intel.com/
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

>  #include <asm-generic/iomap.h>
> +/*
> + * These get provided from <asm-generic/iomap.h> since parisc does not
> + * select GENERIC_IOMAP.
> + */
> +#define ioport_map ioport_map
> +#define ioport_unmap ioport_unmap
> +#define ioread8 ioread8

[nitpicking] 's/since/though/' or similar:

As discussed, the asm-generic/iomap.h declarations are meant to
be used with GENERIC_IOMAP, parisc just uses them anyway despite
having its own abstraction.

     Arnd
