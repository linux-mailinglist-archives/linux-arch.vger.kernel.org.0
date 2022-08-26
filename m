Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5178E5A2A32
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242617AbiHZO7k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiHZO7j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 10:59:39 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD36D99EE
        for <linux-arch@vger.kernel.org>; Fri, 26 Aug 2022 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=qDL5Tg2IqqA0ltv6Fk1DWX6ax0mUzivwVe12DXyF6pg=;
        b=IfcZL1pr+nzHEijafNDJgY0n1BgaMXw/t+tS7sK+R3goidKF+A1PMXxiJwi2MbLG+qu9ej0rejSf+
         kq2Pua1NCXvWrTn5e/wtwZs3gYZy6ywkMPg6cLJDl4Hovl10tlxzKlozOOaFJ7rFevKluBGEH2SYKb
         8P+/MlMLGbSS8GxNd/MhuMM14k7uBmhHOZ1B2pOg88zZJYBnZ9nNTFZ0SUd9bE43vFgLhXEMjrBgIj
         jGrMHfINFDfXDnowsJz4CGLXYTWiUVLvRsijUolEP4f8VHwfFzHoxpqFWhiSwk8ixZ1SJRZAxAaIKD
         oDeth/F4nRQa8O5LH7Uq2QbOPScRT1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=qDL5Tg2IqqA0ltv6Fk1DWX6ax0mUzivwVe12DXyF6pg=;
        b=sga+EQjlbg8JGDfH3UjSFJgeH3pc9j5/bGbr/+Q8nQ57NldTUMe4pgwuFjnhapISb30TjzkU+ItSy
         8LmyD4+Aw==
X-HalOne-Cookie: 617958fb2f51c3542a6ff33c3b9f3298d0d4f098
X-HalOne-ID: b301d863-254f-11ed-a920-d0431ea8a290
Received: from mailproxy1.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id b301d863-254f-11ed-a920-d0431ea8a290;
        Fri, 26 Aug 2022 14:59:35 +0000 (UTC)
Date:   Fri, 26 Aug 2022 16:59:34 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sparc64: Fix the generic IO helpers
Message-ID: <Ywjf1ocWTBMwi3eM@ravnborg.org>
References: <20220823085014.208791-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823085014.208791-1-linus.walleij@linaro.org>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On Tue, Aug 23, 2022 at 10:50:14AM +0200, Linus Walleij wrote:
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
This file is shared with sparc32 - so you need to build test it here as
well.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-arm-kernel/202208201639.HXye3ke4-lkp@intel.com/
> Cc: David S. Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
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

The normal practice is to stick the define near where it makes sense,
and not an ureadable list in the bottom.
Also "readsb" looks wrong as sparc32 do not provice it.
I guess most needs to be pushed to io_64.h as io_32.h already includes
asm-generic/io.h.

I gave up migrating sparc64 to the generiv io.h when I migrated sparc32 -
but I fail to remember why. Most likely lack of motivation.

	Sam
