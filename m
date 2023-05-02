Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E56F6F4ACC
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjEBUDH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 16:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjEBUDG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 16:03:06 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C81997
        for <linux-arch@vger.kernel.org>; Tue,  2 May 2023 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=KtZNQ58vZ5N98TWm6M5w+L57kPYXNb5tAf0VlF8Flpc=;
        b=Xah1/oyErMFNpxOGfQEez/E+8w0LLHZXJKtrW/ScT0xAhSKJyU1eZ3frWCdrdSF0GTGRRpJhPQrZs
         I+uBJafShd3l9pu/kBATSdEVDgpUVD6i+FYH+AM1xPvyJ0UmNqbSnLpRvHzxNrVSMZzfiNM1KvbeUW
         KGgXkpysLgZ/zewOpQiKznhcJPVatUQuOeymT5kBhkjt9Eq3PGZFnXDKGHoufHpJA6S/rh+SALRC4U
         RIFwlrXy7znYTkNSqweLa/0D/HwYv9u4U6krbhYlJX7lMOSK5LXpPTdXhRVtOt8FJyFPUh9YDeusba
         Gl27IKREH5sEcHLYQw1s+yrcHZiZ1BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=KtZNQ58vZ5N98TWm6M5w+L57kPYXNb5tAf0VlF8Flpc=;
        b=7QUNa4Iy2G7XUqb7b772O2zddt3FyCgHB/im3Jp8IwJy6rF7WzgO5eusroyZ9PEtznHxDPL5De33H
         tmENBvLCg==
X-HalOne-ID: 56af12f5-e924-11ed-94e2-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 56af12f5-e924-11ed-94e2-99461c6a3fe8;
        Tue, 02 May 2023 20:03:02 +0000 (UTC)
Date:   Tue, 2 May 2023 22:03:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 5/6] fbdev: Move framebuffer I/O helpers into
 <asm/fb.h>
Message-ID: <20230502200300.GB319489@ravnborg.org>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502130223.14719-6-tzimmermann@suse.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Tue, May 02, 2023 at 03:02:22PM +0200, Thomas Zimmermann wrote:
> Implement framebuffer I/O helpers, such as fb_read*() and fb_write*(),
> in the architecture's <asm/fb.h> header file or the generic one.

In reality they are now all implemented in the generic one.

> 
> The common case has been the use of regular I/O functions, such as
> __raw_readb() or memset_io(). A few architectures used plain system-
> memory reads and writes. Sparc used helpers for its SBus.
> 
> The architectures that used special cases provide the same code in
> their __raw_*() I/O helpers. So the patch replaces this code with the
> __raw_*() functions and moves it to <asm-generic/fb.h> for all
> architectures.
Which is also documented here.

> 
> v3:
> 	* implement all architectures with generic helpers
> 	* support reordering and native byte order (Geert, Arnd)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  include/asm-generic/fb.h | 101 +++++++++++++++++++++++++++++++++++++++
>  include/linux/fb.h       |  53 --------------------
>  2 files changed, 101 insertions(+), 53 deletions(-)
> 
> diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
> index 6922dd248c51..0540eccdbeca 100644
> --- a/include/asm-generic/fb.h
> +++ b/include/asm-generic/fb.h
> @@ -31,4 +31,105 @@ static inline int fb_is_primary_device(struct fb_info *info)
>  }
>  #endif
>  
> +/*
> + * I/O helpers for the framebuffer. Prefer these functions over their
> + * regular counterparts. The regular I/O functions provide in-order
> + * access and swap bytes to/from little-endian ordering. Neither is
> + * required for framebuffers. Instead, the helpers read and write
> + * raw framebuffer data. Independent operations can be reordered for
> + * improved performance.
> + */
> +
> +#ifndef fb_readb
> +static inline u8 fb_readb(const volatile void __iomem *addr)
> +{
> +	return __raw_readb(addr);
> +}
> +#define fb_readb fb_readb
> +#endif

When we need to provide an architecture specific variant the
#ifndef foo
...
#define foo foo
can be added. Right now it is just noise as no architectures provide
their own variants.

But I am missing something somewhere as I cannot see how this builds.
asm-generic now provide the fb_read/fb_write helpers.
But for example sparc has an architecture specifc fb.h so it will not
use the asm-generic variant. So I wonder how sparc get hold of the
asm-generic fb.h file?

Maybe it is obvious, but I miss it.

	Sam
