Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5770B52775A
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 13:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236588AbiEOLut (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 07:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbiEOLus (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 07:50:48 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCC860D7;
        Sun, 15 May 2022 04:50:46 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id x5so4849882uap.8;
        Sun, 15 May 2022 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLEKRhCjkEicF/q9VGRjE4mwODg7BpEFx03HlRH4+xA=;
        b=COtDhuf28JebQyTZABWvcl22R/KPO275GjxkphGGcrMiWSXyWBTeIIAQT8LUtVorvU
         h569AjKQTVPaRxRBsAV6kjRQp5p1Vj5ZVoqRFLt/rnyBrzw7A6WBl3ghnHX01VNIjTbV
         Y73taqU/h4AaW0IdhZ2RH/bNA3W/IZC/koVgTAyZlTyHETIzd1r49fsitiwB8g3ZbFaO
         l8nPvfh0sPZ6BhowMoXvpR1puh8sJNXvSvGpDobVeFCrF3uUOwMD1lh+tTZGPEKfgAQ3
         VpYh3ZUZRQw6Kvkdnx9xo+Yy8PZ1o8OiU3LXGm2/LR2INnbUKN6VIFW5hshHOsB8Blvn
         FPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLEKRhCjkEicF/q9VGRjE4mwODg7BpEFx03HlRH4+xA=;
        b=GMcw8Z372uKmlc9zNgHsGj7S2ZER2qRwZz84nh2DJnUluSJZtz8U9AgEVn5Wzzmn8R
         0FyWi8hAaRQZGcVTTU498dpMHE8M+0AZsvlnvLTlg59UfW3QztKZXYAmq9FXGvaOsBbo
         jfvY1DU6AzcitJP4K08Wrk4lUDNH4pndO4jfbg+6AfuApmbLXKezbC+/Lr58iwjn7kRp
         ulu4sjG6ay9bBSpGxxJeFdBPDO0uG1B436hCNqI/OEq3qUSfnDkg6x5noYcMpY5q1366
         M+00M3zfbfiEJLLmmgit5v7nSwr1++PJhKfx+txm6MB1woz9I7eb57TLN+ahkbrQyLq9
         RGHA==
X-Gm-Message-State: AOAM5336nFsL7JMC9pWeLs1SQGxgSU2jaZE4UKdfCCgJLtO3iok2BAZj
        yIuDPSsDBdJy9Ta8DXx2M5NhEZMDnzhh5kDMNJqF9645z217Bbjr
X-Google-Smtp-Source: ABdhPJwrsKQqR9Npw6UusOWT688bwLgjwrG3+4Hq2fo9Lh9bfGu0q5lHC5NNE86zr70o4uTEVRSBdWXvwGSG7wwEAlg=
X-Received: by 2002:ab0:2bc9:0:b0:362:8750:8032 with SMTP id
 s9-20020ab02bc9000000b0036287508032mr4562392uar.118.1652615445364; Sun, 15
 May 2022 04:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-5-chenhuacai@loongson.cn> <9dbdcb6d-90bc-e49c-cbdd-44f33b3f2351@xen0n.name>
In-Reply-To: <9dbdcb6d-90bc-e49c-cbdd-44f33b3f2351@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 19:50:34 +0800
Message-ID: <CAAhV-H66ybZsboFBgjdOQbrrCLvhh4mp_srbmtkGkghHHYFP9w@mail.gmail.com>
Subject: Re: [PATCH V10 04/22] LoongArch: Add writecombine support for drm
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Xuerui,

On Sun, May 15, 2022 at 12:19 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
>
> On 5/14/22 16:03, Huacai Chen wrote:
> > LoongArch maintains cache coherency in hardware, but its WUC attribute
> > (Weak-ordered UnCached, which is similar to WC) is out of the scope of
> > cache coherency machanism. This means WUC can only used for write-only
> > memory regions.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >   drivers/gpu/drm/drm_vm.c         | 2 +-
> >   drivers/gpu/drm/ttm/ttm_module.c | 2 +-
> >   include/drm/drm_cache.h          | 8 ++++++++
> >   3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
> > index e957d4851dc0..f024dc93939e 100644
> > --- a/drivers/gpu/drm/drm_vm.c
> > +++ b/drivers/gpu/drm/drm_vm.c
> > @@ -69,7 +69,7 @@ static pgprot_t drm_io_prot(struct drm_local_map *map,
> >       pgprot_t tmp = vm_get_page_prot(vma->vm_flags);
> >
> >   #if defined(__i386__) || defined(__x86_64__) || defined(__powerpc__) || \
> > -    defined(__mips__)
> > +    defined(__mips__) || defined(__loongarch__)
> >       if (map->type == _DRM_REGISTERS && !(map->flags & _DRM_WRITE_COMBINING))
> >               tmp = pgprot_noncached(tmp);
> >       else
> > diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> > index a3ad7c9736ec..b3fffe7b5062 100644
> > --- a/drivers/gpu/drm/ttm/ttm_module.c
> > +++ b/drivers/gpu/drm/ttm/ttm_module.c
> > @@ -74,7 +74,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
> >   #endif /* CONFIG_UML */
> >   #endif /* __i386__ || __x86_64__ */
> >   #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
> > -     defined(__powerpc__) || defined(__mips__)
> > +     defined(__powerpc__) || defined(__mips__) || defined(__loongarch__)
> >       if (caching == ttm_write_combined)
> >               tmp = pgprot_writecombine(tmp);
> >       else
> > diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
> > index 22deb216b59c..08e0e3ffad13 100644
> > --- a/include/drm/drm_cache.h
> > +++ b/include/drm/drm_cache.h
> > @@ -67,6 +67,14 @@ static inline bool drm_arch_can_wc_memory(void)
> >        * optimization entirely for ARM and arm64.
> >        */
> >       return false;
> > +#elif defined(CONFIG_LOONGARCH)
> > +     /*
> > +      * LoongArch maintains cache coherency in hardware, but its WUC attribute
> > +      * (Weak-ordered UnCached, which is similar to WC) is out of the scope of
> > +      * cache coherency machanism. This means WUC can only used for write-only
> > +      * memory regions.
> > +      */
> > +     return false;
> >   #else
> >       return true;
> >   #endif
>
> The code changes look reasonable, given the adequate comments, but have
> the drm people given acks? This seems to exclusively touch drm bits and
> not directly related to arch bring-up. (You may get scrambled screen
> output but everything else is working, I'm running my LoongArch devbox
> headlessly ever since I first set it up last year.)
>
> If anything, IMO you could even take this patch out and still get the
> arch properly brought up. What do others think?
Thanks, I think I should add Cc:  dri-devel@lists.freedesktop.org

Huacai
>
> Nevertheless,
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
