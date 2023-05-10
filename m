Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7746FE067
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbjEJOey convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 10 May 2023 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbjEJOev (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 10:34:51 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25FFDE;
        Wed, 10 May 2023 07:34:49 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-559de1d36a9so105794767b3.1;
        Wed, 10 May 2023 07:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729288; x=1686321288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozQA/cDvPs2H88bJoE4ZEXy4NN+hc65oP+0zn7oNwKg=;
        b=lnuPn/Md3kCrpmgC5T8hatrzEdfDmfbrpqj24AAGR9nWRm52Yy4eK7YAbvanqeg3HV
         9n0GNyok/WHq0nNra4bon6B40n/7cSdBdpofD0Zqvm3GKUIIjrlhTfwezs1X3yYyi+nc
         yJP5oJJ4SuKr0dbg/6ce7E0sVLK2MHL9UCsCXLCUJt1zdZLcsZaB1Kz3nTUBiMKfV15f
         HRnymY03+fsI6lX/6H49I7lsopPpilGyOEJF9bVEcqq1Nd2cae6YLS9UzekgaGrcXD4f
         Mj6Ll78QBPEW2InSLP/GmjWO2liBXwG2gRyjCK6W80qeB0kpGTvmAUC+byl5zxKHAbxW
         QgeQ==
X-Gm-Message-State: AC+VfDw0quOdmRljp0t2BPdk76YuzvTnb9a/uwHpLgDcOKw5wgIRuOyL
        B90gGEkT2wzOm5eI5XcK5jdaRJMh5vISLA==
X-Google-Smtp-Source: ACHHUZ7REBtXk8+GACjdQjmrsTHQhYdFGPhmtQd9s+M3OG8pOeEyAufWYRO0lRqWNlYyEsPvKL4Nxg==
X-Received: by 2002:a81:6d48:0:b0:55a:881d:e744 with SMTP id i69-20020a816d48000000b0055a881de744mr19986822ywc.47.1683729288666;
        Wed, 10 May 2023 07:34:48 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id m67-20020a817146000000b0055a8b115f6esm4112292ywc.128.2023.05.10.07.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 07:34:47 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-b983027d0faso9323113276.0;
        Wed, 10 May 2023 07:34:46 -0700 (PDT)
X-Received: by 2002:a05:6902:18c6:b0:b99:5707:4e6f with SMTP id
 ck6-20020a05690218c600b00b9957074e6fmr23871358ybb.32.1683729286388; Wed, 10
 May 2023 07:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230510110557.14343-1-tzimmermann@suse.de> <20230510110557.14343-6-tzimmermann@suse.de>
 <CAMuHMdVV-MQV3C_o6JxPj23h3zo0kMmsn9ZEWJxsrzr6YpKmyg@mail.gmail.com> <487ff03b-d753-972f-7a06-a1d5efda917d@suse.de>
In-Reply-To: <487ff03b-d753-972f-7a06-a1d5efda917d@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 May 2023 16:34:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWQLF6QZi4j5Yg3oiy8dMbuApk+r=5c2tSLvYxvAaudMA@mail.gmail.com>
Message-ID: <CAMuHMdWQLF6QZi4j5Yg3oiy8dMbuApk+r=5c2tSLvYxvAaudMA@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@hansenpartnership.com,
        arnd@arndb.de, sam@ravnborg.org, suijingfeng@loongson.cn,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Wed, May 10, 2023 at 4:20 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 10.05.23 um 14:34 schrieb Geert Uytterhoeven:
> > On Wed, May 10, 2023 at 1:06 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> Implement framebuffer I/O helpers, such as fb_read*() and fb_write*(),
> >> in the architecture's <asm/fb.h> header file or the generic one.
> >>
> >> The common case has been the use of regular I/O functions, such as
> >> __raw_readb() or memset_io(). A few architectures used plain system-
> >> memory reads and writes. Sparc used helpers for its SBus.
> >>
> >> The architectures that used special cases provide the same code in
> >> their __raw_*() I/O helpers. So the patch replaces this code with the
> >> __raw_*() functions and moves it to <asm-generic/fb.h> for all
> >> architectures.
> >>
> >> v6:
> >>          * fix fb_readq()/fb_writeq() on 64-bit mips (kernel test robot)
> >> v5:
> >>          * include <linux/io.h> in <asm-generic/fb>; fix s390 build
> >> v4:
> >>          * ia64, loongarch, sparc64: add fb_mem*() to arch headers
> >>            to keep current semantics (Arnd)
> >> v3:
> >>          * implement all architectures with generic helpers
> >>          * support reordering and native byte order (Geert, Arnd)
> >>
> >> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> >> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
> >> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> >> --- a/arch/mips/include/asm/fb.h
> >> +++ b/arch/mips/include/asm/fb.h
> >> @@ -12,6 +12,28 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> >>   }
> >>   #define fb_pgprotect fb_pgprotect
> >>
> >> +/*
> >> + * MIPS doesn't define __raw_ I/O macros, so the helpers
> >> + * in <asm-generic/fb.h> don't generate fb_readq() and
> >> + * fb_write(). We have to provide them here.
> >
> > MIPS does not include <asm-generic/io.h>,  nor define its own
>
> I know, that's why the TODO says to convert it to generic I/O.
>
> > __raw_readq() and __raw_writeq()...
>
> It doesn't define those macros, but it generates function calls of the
> same names. Follow the macros at
>
>
> https://elixir.bootlin.com/linux/latest/source/arch/mips/include/asm/io.h#L357
>
> It expands to a variety of helpers, including __raw_*().

Thanks, I forgot MIPS is using these grep-unfriendly factories...

> >> + *
> >> + * TODO: Convert MIPS to generic I/O. The helpers below can
> >> + *       then be removed.
> >> + */
> >> +#ifdef CONFIG_64BIT
> >> +static inline u64 fb_readq(const volatile void __iomem *addr)
> >> +{
> >> +       return __raw_readq(addr);
> >
> > ... so how can this call work?
>
> On 64-bit builds, there's __raw_readq() and __raw_writeq().
>
> At first, I tried to do the right thing and convert MIPS to work with
> <asm-generic/io.h>. But that created a ton of follow-up errors in other
> headers. So for now, it's better to handle this problem in asm/fb.h.

So isn't just adding

    #define __raw_readq __raw_readq
    #define __raw_writeq __raw_writeq

to arch/mips/include/asm/io.h sufficient to make <asm-generic/fb.h>
do the right thing?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
