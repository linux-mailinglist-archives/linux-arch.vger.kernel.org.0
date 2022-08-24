Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8222A5A03D6
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 00:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiHXWPy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 18:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiHXWPu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 18:15:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CBC78BE3;
        Wed, 24 Aug 2022 15:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=M7543lfE0SArKDKxNt2+d7p7IIY0Jo5yIiutMPnjNK4=; b=KBv7hcqv70I72ABNqaGqseX40f
        jhbd7P77Zzdkml+0BLC/IPp8VXz4zoYDLZMx15rCrFGxsNhVB9Bm/Si55jMeOYbLh9K9KSPY2llL6
        cGFwuleEjaepCjjo57mxcdU9d7ErZHvx3h2tErit9AMz69Xx3o9mXaP9miqVJ5BrsDYn2RFvZ653m
        U2BloIQabUD3nVLrJc0HKJqj5w2A9yYMalwFyoXFUIThAWShChzkH5Gp8dQmzuKktIgv0FES8kCft
        Q3B/hRRGi6CnAsDQSfpe3Mg0TXIKqerDipwG0vsIHQEAnNDJVgfav0+w/Hd7dXm9Hk0LOMzuwP9j2
        O6NMJOCQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQyf2-0027nQ-N2; Wed, 24 Aug 2022 22:15:44 +0000
Message-ID: <48f9ddc8-02e2-2f2a-8bde-2d7346998096@infradead.org>
Date:   Wed, 24 Aug 2022 15:15:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] sparc64: Fix the generic IO helpers
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220823085014.208791-1-linus.walleij@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220823085014.208791-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi--

On 8/23/22 01:50, Linus Walleij wrote:
> This enables the Sparc to use <asm-generic/io.h> to fill in the
> missing (undefined) [read|write]sq I/O accessor functions.
> 
> This is needed if Sparc[64] ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that Sparc64, while being a 64bit platform,
> as of now not yet provide.
> 
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
> 
> Bite the bullet and just provide the definitions and make it work.
> Compile-tested on sparc64.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-arm-kernel/202208201639.HXye3ke4-lkp@intel.com/
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Both alpha & parisc (32 and 64 bits) need this fix also.

Is it always safe to do this?

> ---
>  arch/sparc/include/asm/io.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/io.h b/arch/sparc/include/asm/io.h
> index 2eefa526b38f..88da27165c01 100644
> --- a/arch/sparc/include/asm/io.h
> +++ b/arch/sparc/include/asm/io.h
> @@ -19,4 +19,35 @@
>  #define writel_be(__w, __addr)	__raw_writel(__w, __addr)
>  #define writew_be(__l, __addr)	__raw_writew(__l, __addr)
>  
> +/*
> + * These defines are necessary to use the generic io.h for filling in
> + * the missing parts of the API contract. This is because the platform
> + * uses (inline) functions rather than defines and the generic helper
> + * fills in the undefined.
> + */
> +/* These are static inlines on 64BIT only */
> +#if defined(__sparc__) && defined(__arch64__)
> +#define memset_io memset_io
> +#define memcpy_fromio memcpy_fromio
> +#define memcpy_toio memcpy_toio
> +#endif
> +#define pci_iomap pci_iomap
> +#define pci_iounmap pci_iounmap
> +#define ioremap_np ioremap_np
> +#define ioport_map ioport_map
> +#define ioport_unmap ioport_unmap
> +#define readsb readsb
> +#define readsw readsw
> +#define readsl readsl
> +#define writesb writesb
> +#define writesw writesw
> +#define writesl writesl
> +#define insb insb
> +#define insw insw
> +#define insl insl
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
> +#include <asm-generic/io.h>
> +
>  #endif

-- 
~Randy
