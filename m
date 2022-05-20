Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF2C52EDD6
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350130AbiETOKW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiETOKU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 10:10:20 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813C91668A6;
        Fri, 20 May 2022 07:10:18 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id c26so8477058vsl.6;
        Fri, 20 May 2022 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xlJ0095zgB0c2Vb8evf5eblS7KNjFsBRz7hA5cc4xk=;
        b=F2adFm0dsksybi2rC6k+PIt076DVcea/Bd3N45htU6EsZqv1MmC95+sCQDslUJqtp+
         1UTtP8FAs/s2Hr4RRaiXr/CW6VuR07LJ5aNDn1kTlxpIISVvJbQvigLbPcpb+/VsKuw7
         t8lw4FfVrlH7WwYXRSwvgX32weXdKkRLbCvGFHD7rBDXVr1Q5WSvC8Otj8IZ5Fvelxuk
         bhYnmp3KEixDXCDc9b+YK+wXR8uC+7yGs4dJiokFQ+Om0+GlC1YFr6dq3qj/4wTsZ5J+
         mlJ8w0+XTB7cP4DnskE2lLCFPEc4Gumwy9vN4cxHh25yhvzu/xDmcYcZ/fFixXNC4BkC
         XW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xlJ0095zgB0c2Vb8evf5eblS7KNjFsBRz7hA5cc4xk=;
        b=JhFd6mc7OKAa27vkqeAgVJCVtyvASf5iCQqgVG4WRUn8vMYuMs6ARYX2CPglMAoJHf
         J+yXkorhp/6cB3JKEh8t3C9cOUzzvVEKhQ6/RwKtf/uTdjd7C5jBuRc/PqrtoJ/C6pdh
         V85MKimDBiFjOpakatRfqP0fXPJsblcx9gjR0nLUxive9eEgnkkecUPHaaW+OH9Dytzi
         fspASuqiA418aTq2aWCXMvA118RRye8nwI+iJvmWS73hxHsdxffxV7FNm8qhHcSlnQ+v
         /02rpmDFPja2HsMxCy4OyK5dF1vOa3lEx4Q1rHoUxArerPhiwXq+9NBSVaTTU9crxzgY
         QBNw==
X-Gm-Message-State: AOAM530HyJlY7xSRmMVoKjs5rqMQrE3NP+4xFYKbQalXB0/csJK/ztd1
        8HfItTSnNNLj95BEPLkXljoH5yh0qMQLOjRyRuJb5EUkNVOak1ot
X-Google-Smtp-Source: ABdhPJwMOpVVngVB9TKYcsUkabtpLsRVzOSIqPkMg89E3lfuVoGU22wXBvVzfFrEzkIrrUjt/KLQjQYOViE2Oykxv6s=
X-Received: by 2002:a67:e1c4:0:b0:335:cdc4:395f with SMTP id
 p4-20020a67e1c4000000b00335cdc4395fmr4220006vsl.71.1653055817568; Fri, 20 May
 2022 07:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn> <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
 <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com>
In-Reply-To: <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 20 May 2022 22:09:18 +0800
Message-ID: <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
Subject: Re: [PATCH V11 09/22] LoongArch: Add boot and setup routines
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>
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

Hi, Javier,

On Fri, May 20, 2022 at 5:41 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Ard and Huacai,
>
> On 5/20/22 11:17, Ard Biesheuvel wrote:
>
> [snip]
>
> >> +
> >> +static int __init register_gop_device(void)
> >> +{
> >> +       void *pd;
> >> +
> >> +       if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> >> +               return 0;
> >> +       pd = platform_device_register_data(NULL, "efi-framebuffer", 0,
> >> +                       &screen_info, sizeof(screen_info));
> >> +       return PTR_ERR_OR_ZERO(pd);
> >> +}
> >> +subsys_initcall(register_gop_device);
> >
> > Not sure this is now the correct way to do this - cc'ing Javier.
> >
>
> Is not the correct way to do it indeed, that can just be dropped.
>
> We have unified now all the system framebuffer platform device
> registration under drivers/firmware/sysfb.c (and the EFI quirks
> if needed under drivers/firmware/efi/sysfb_efi.c).
>
> So the only thing that a platform should do, is to enable the
> the CONFIG_SYSFB config option. The screen_info should be set
> correctly from the EFI GOP, but it seems that's already working
> since you were already using it in register_gop_device().
>
> But also, the "efi-framebuffer" platform device matches against
> the legacy efifb fbdev driver. And now there's a simpledrm driver
> that is also able to use the firmware-provided framebuffer.
>
> You can enable that driver with CONFIG_DRM_SIMPLEDRM.
>
> That driver though doesn't match against "efi-framebuffer" but with
> a "simple-framebuffer", to make sysfb register that instead of the
> "efi-framebuffer" device, you need to set CONFIG_SYSFB_SIMPLEFB too.
>
> If for some reasons you need to provide a fbdev interface to the
> user-space, you can enable CONFIG_DRM_FBDEV_EMULATION to have that.
>
> In summary, just enable the following to use the firmware framebuffer:
>
> CONFIG_DRM_SIMPLEDRM=y
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_SYSFB=y
> CONFIG_SYSFB_SIMPLEFB=y
Thank you very much, since 5.15 sysfb_init() do all things of
register_gop_device(), so register_gop_device() here can be removed.
But there is another small problem: if simpledrm or efifb driver is
built-in, there is no display. The reason is both sysfb_init() and
display driver are in the same initcall level (device_initcall()).
From the comments I know that sysfb_init() should after PCI
enumeration which is in subsys_initcall(), so, could we make
sysfb_init() to be a subsys_initcall_sync()?

Huacai
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
