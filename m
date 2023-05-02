Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389D36F4AFE
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjEBUJY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjEBUJX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 16:09:23 -0400
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A531FCC
        for <linux-arch@vger.kernel.org>; Tue,  2 May 2023 13:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=7Cvc9t2uj+JoEAOf6QiHMtCJcRgtJ26CtzLE3dOVCX4=;
        b=DAJTs66FtfCQ420jLek75/3/XNBefU855ewUyaKmXxygVB6ZwaaX4BG60IJjSKwTrXzoHzbhc711S
         zlp4kZr4AVZMkk0zrDEzy7AwKvjS2/gg0wnNG0W/6Cto4FTV5PtE5S4fDV657GDHfaQzB5Ya9TG/kV
         016qrq5lr1THB0fUDBipjErF2RTfNeOJgg7A+ZHrJaIi4OqW5scOKWYMFFV4N2UMUU69v6W/Pr8BQs
         NJZFnLxFZi/NWItgGcOv4voyhae1n2JoPlDwDZo2F51Gk2sc4H8BM9ikcvgRwc/nFF3aPAbXAJpFDE
         mfmUAPNEjXGlbQD2yXDOnYBNY2Abkjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=7Cvc9t2uj+JoEAOf6QiHMtCJcRgtJ26CtzLE3dOVCX4=;
        b=BufBpesF4qmcj+3WAckz7l+cGAVlOpWomuRms3hnfY+4zICRqPq9RxbIV9afOQ/RW6dKCGaonFM0Q
         kOp2kKxBA==
X-HalOne-ID: 10b6caa3-e925-11ed-9f58-592bb1efe9dc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id 10b6caa3-e925-11ed-9f58-592bb1efe9dc;
        Tue, 02 May 2023 20:08:14 +0000 (UTC)
Date:   Tue, 2 May 2023 22:08:13 +0200
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
Subject: Re: [PATCH v3 6/6] fbdev: Rename fb_mem*() helpers
Message-ID: <20230502200813.GC319489@ravnborg.org>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-7-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502130223.14719-7-tzimmermann@suse.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas.

On Tue, May 02, 2023 at 03:02:23PM +0200, Thomas Zimmermann wrote:
> Update the names of the fb_mem*() helpers to be consistent with their
> regular counterparts. Hence, fb_memset() now becomes fb_memset_io(),
> fb_memcpy_fromfb() now becomes fb_memcpy_fromio() and fb_memcpy_tofb()
> becomes fb_memcpy_toio(). No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
...
>  
> -#ifndef fb_memcpy_fromfb
> -static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
> +#ifndef fb_memcpy_fromio
> +static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
>  {
>  	memcpy_fromio(to, from, n);
>  }
> -#define fb_memcpy_fromfb fb_memcpy_fromfb
> +#define fb_memcpy_fromio fb_memcpy_fromio
>  #endif
>  
> -#ifndef fb_memcpy_tofb
> -static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
> +#ifndef fb_memcpy_toio
> +static inline void fb_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
>  {
>  	memcpy_toio(to, from, n);
>  }
> -#define fb_memcpy_tofb fb_memcpy_tofb
> +#define fb_memcpy_toio fb_memcpy_toio
>  #endif
>  
>  #ifndef fb_memset
> -static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
> +static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
>  {
>  	memset_io(addr, c, n);
>  }
> -#define fb_memset fb_memset
> +#define fb_memset fb_memset_io

The static inlines wrappers does not provide any value, and could be replaced by
direct calls to memcpy_fromio(), memcpy_toio(), memset_io().

If you decide to keep the wrappers I will not hold you back, so the
patch has my:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

But I prefer the direct calls without the wrappers....

	Sam
