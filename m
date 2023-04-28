Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAED66F17EC
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjD1M1Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 28 Apr 2023 08:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjD1M1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 08:27:23 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31AC10CF;
        Fri, 28 Apr 2023 05:27:21 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-555d2b43a23so112888087b3.2;
        Fri, 28 Apr 2023 05:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684841; x=1685276841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDsEdn6WDxg314v0qLuVGHvJOHZvS1YLN0vYRrRrPEc=;
        b=EFQRW1hwFnxp01Qm0JPXl47W0OVAkIH6hshspGTKEw8j2HEs0TnbRaePHC4om1z0Jx
         GtOZPabv0RV7aL6B4ykzgedIQz83wOx0KPUpjIh5aWI0v5q6EWOaHj0wCNLkXoga+69k
         HmPfyU97Lb/H0aghk0kcyIpcQiZInGg/q2kQP4Eaj1Xqo2a8qLZ/+JrNyGIKxEZTWDX4
         zSFCFoViiSZhh8EHZzyXvJJHex/GMnCdXWBnkbKgSShq0UaOxDFrtkTDt5wrQjGTLyvB
         JS9ekPc0VX6a6CaVWQRLucML+sfeZdrSUNuGLQaCFrDLSeAy3u2JXX73XFLNhLVqcAeF
         4FcA==
X-Gm-Message-State: AC+VfDzyr9ziEVaAQ+3kOOkt/xXrsw9oN9i+IkQhtWXOZQky3B0iAY1c
        foSQ43MsvtkzWcV5F5cMXDeNIq63KQD0cg==
X-Google-Smtp-Source: ACHHUZ4iFwJ+due3uopV1pQ+Y6ebygs8N1yM8zCLInmi3OPKQ77UofvBxV6CeC+IF7xEFIMuaMLv+w==
X-Received: by 2002:a0d:cc84:0:b0:546:4626:bfc5 with SMTP id o126-20020a0dcc84000000b005464626bfc5mr3798626ywd.31.1682684840686;
        Fri, 28 Apr 2023 05:27:20 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id k187-20020a816fc4000000b00545a08184b9sm5421128ywc.73.2023.04.28.05.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 05:27:20 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-555c8a12b26so113027977b3.0;
        Fri, 28 Apr 2023 05:27:19 -0700 (PDT)
X-Received: by 2002:a81:8a01:0:b0:544:69f5:fadc with SMTP id
 a1-20020a818a01000000b0054469f5fadcmr3593096ywg.6.1682684839491; Fri, 28 Apr
 2023 05:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230428092711.406-1-tzimmermann@suse.de> <20230428092711.406-6-tzimmermann@suse.de>
 <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
In-Reply-To: <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Apr 2023 14:27:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
Message-ID: <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O functions
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        javierm@redhat.com, daniel@ffwll.ch, vgupta@kernel.org,
        chenhuacai@kernel.org, kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 28, 2023 at 2:18 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2023-04-28 10:27, Thomas Zimmermann wrote:
> > Implement framebuffer I/O helpers, such as fb_read*() and fb_write*()
> > with Linux' regular I/O functions. Remove all ifdef cases for the
> > various architectures.
> >
> > Most of the supported architectures use __raw_() I/O functions or treat
> > framebuffer memory like regular memory. This is also implemented by the
> > architectures' I/O function, so we can use them instead.
> >
> > Sparc uses SBus to connect to framebuffer devices. It provides respective
> > implementations of the framebuffer I/O helpers. The involved sbus_()
> > I/O helpers map to the same code as Sparc's regular I/O functions. As
> > with other platforms, we can use those instead.
> >
> > We leave a TODO item to replace all fb_() functions with their regular
> > I/O counterparts throughout the fbdev drivers.
> >
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
> >   include/linux/fb.h | 63 +++++++++++-----------------------------------
> >   1 file changed, 15 insertions(+), 48 deletions(-)
> >
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index 08cb47da71f8..4aa9e90edd17 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -15,7 +15,6 @@
> >   #include <linux/list.h>
> >   #include <linux/backlight.h>
> >   #include <linux/slab.h>
> > -#include <asm/io.h>
> >
> >   struct vm_area_struct;
> >   struct fb_info;
> > @@ -511,58 +510,26 @@ struct fb_info {
> >    */
> >   #define STUPID_ACCELF_TEXT_SHIT
> >
> > -// This will go away
> > -#if defined(__sparc__)
> > -
> > -/* We map all of our framebuffers such that big-endian accesses
> > - * are what we want, so the following is sufficient.
> > +/*
> > + * TODO: Update fbdev drivers to call the I/O helpers directly and
> > + *       remove the fb_() tokens.
> >    */
> > -
> > -// This will go away
> > -#define fb_readb sbus_readb
> > -#define fb_readw sbus_readw
> > -#define fb_readl sbus_readl
> > -#define fb_readq sbus_readq
> > -#define fb_writeb sbus_writeb
> > -#define fb_writew sbus_writew
> > -#define fb_writel sbus_writel
> > -#define fb_writeq sbus_writeq
> > -#define fb_memset sbus_memset_io
> > -#define fb_memcpy_fromfb sbus_memcpy_fromio
> > -#define fb_memcpy_tofb sbus_memcpy_toio
> > -
> > -#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) ||      \
> > -     defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || \
> > -     defined(__arm__) || defined(__aarch64__) || defined(__mips__)
> > -
> > -#define fb_readb __raw_readb
> > -#define fb_readw __raw_readw
> > -#define fb_readl __raw_readl
> > -#define fb_readq __raw_readq
> > -#define fb_writeb __raw_writeb
> > -#define fb_writew __raw_writew
> > -#define fb_writel __raw_writel
> > -#define fb_writeq __raw_writeq
>
> Note that on at least some architectures, the __raw variants are
> native-endian, whereas the regular accessors are explicitly
> little-endian, so there is a slight risk of inadvertently changing
> behaviour on big-endian systems (MIPS most likely, but a few old ARM
> platforms run BE as well).

Also on m68k, when ISA or PCI are enabled.

In addition, the non-raw variants may do some extras to guarantee
ordering, which you do not need on a frame buffer.

So I'd go for the __raw_*() variants everywhere.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
