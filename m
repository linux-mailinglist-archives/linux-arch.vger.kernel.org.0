Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1616F5EDD
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjECTGY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjECTGX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 15:06:23 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17207D9E
        for <linux-arch@vger.kernel.org>; Wed,  3 May 2023 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=WdyijgrhY4RTD1q08ndFDbdTcMhAA946cORCCTZmsdo=;
        b=gNsbDnuimH08qa10cbdLhym1IRrgRdP9AeDQNlOy+MDGfpEbFka6iHLaMl53BJLZ9ds0o+tb2McSK
         umFvpOk/DQBiNLyNcdfFi+G7QPGueDnWCyi92LsYRkrKz08tjED2SvZo0z4jeOxUD2PPUuOifj2N0K
         8uHgXDhcBex5pGBKPYq+6EFmdgSXjV5/AF7AzSAHaexKpK0gYptqQ5AiuJKB/RSVWTUx0MmGBla+c1
         3XCQ1bchQnlI1pRtu0F7C4NDiY7uFhuYU2stFxHDcvsRqF/E8zNYFWRE3hdphxBm2IxdMxYpGmgYdM
         IX5HrfOaCuHWc45u/ociK//KjVptQZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=WdyijgrhY4RTD1q08ndFDbdTcMhAA946cORCCTZmsdo=;
        b=BFeyD0DeTOJBCOL0z6ux7O7hUQiygYBxE0HwrzdugYwmBlQt32kD7CLH2TN/FY+HRiNUVv4M/2hmJ
         GRBucEJCA==
X-HalOne-ID: 942bba87-e9e5-11ed-bfec-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 942bba87-e9e5-11ed-bfec-b90637070a9d;
        Wed, 03 May 2023 19:06:19 +0000 (UTC)
Date:   Wed, 3 May 2023 21:06:17 +0200
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
Message-ID: <20230503190617.GB422961@ravnborg.org>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-7-tzimmermann@suse.de>
 <20230502200813.GC319489@ravnborg.org>
 <828664d0-3562-56cc-019d-1bb8a55826b5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <828664d0-3562-56cc-019d-1bb8a55826b5@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Wed, May 03, 2023 at 10:15:46AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.05.23 um 22:08 schrieb Sam Ravnborg:
> > Hi Thomas.
> > 
> > On Tue, May 02, 2023 at 03:02:23PM +0200, Thomas Zimmermann wrote:
> > > Update the names of the fb_mem*() helpers to be consistent with their
> > > regular counterparts. Hence, fb_memset() now becomes fb_memset_io(),
> > > fb_memcpy_fromfb() now becomes fb_memcpy_fromio() and fb_memcpy_tofb()
> > > becomes fb_memcpy_toio(). No functional changes.
> > > 
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > ---
> > ...
> > > -#ifndef fb_memcpy_fromfb
> > > -static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
> > > +#ifndef fb_memcpy_fromio
> > > +static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
> > >   {
> > >   	memcpy_fromio(to, from, n);
> > >   }
> > > -#define fb_memcpy_fromfb fb_memcpy_fromfb
> > > +#define fb_memcpy_fromio fb_memcpy_fromio
> > >   #endif
> > > -#ifndef fb_memcpy_tofb
> > > -static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
> > > +#ifndef fb_memcpy_toio
> > > +static inline void fb_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
> > >   {
> > >   	memcpy_toio(to, from, n);
> > >   }
> > > -#define fb_memcpy_tofb fb_memcpy_tofb
> > > +#define fb_memcpy_toio fb_memcpy_toio
> > >   #endif
> > >   #ifndef fb_memset
> > > -static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
> > > +static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
> > >   {
> > >   	memset_io(addr, c, n);
> > >   }
> > > -#define fb_memset fb_memset
> > > +#define fb_memset fb_memset_io
> > 
> > The static inlines wrappers does not provide any value, and could be replaced by
> > direct calls to memcpy_fromio(), memcpy_toio(), memset_io().
> > 
> > If you decide to keep the wrappers I will not hold you back, so the
> > patch has my:
> > Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> > 
> > But I prefer the direct calls without the wrappers....
> 
> At first I was also skeptical if those fb_mem*() wrappers are needed. But
> Arnd mentioned that there are subtle differences between the current code
> and Linux' mem*_io() functions. Keeping the wrappers might be needed.
Saw the dialog, and agree that keeping current behaviour is the way to
go for now even if this is more code and wrappers.

	Sam
