Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A1452F9BB
	for <lists+linux-arch@lfdr.de>; Sat, 21 May 2022 09:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbiEUHhm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 May 2022 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiEUHhk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 May 2022 03:37:40 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D19417D384;
        Sat, 21 May 2022 00:37:38 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id c26so10285701vsl.6;
        Sat, 21 May 2022 00:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlSKAs3s0kr2VyaxlqapX2mwoIuc6vEDbZK8m3Uw8dg=;
        b=QrJchFbfkWC1lrrNC3+8zoEJmpzdRyTvsqDNOawdtcfdGkh4hemFF7E+TKVqU7jkDI
         yH4bGGhGIwRNFhloMK9+822rb2xNQMS6bJls6VYSerizoTUlrZ+TjgCdQ8sj5LgHbUnm
         VSuTC7SmlPovdc6AqB63uq4aT9dkApDFXrx3WOS5G0fZnGp0NRqLKVeDZ0RGHly0iXnR
         tppHr6MEP57wA0uKQDijZbzC8yRd746S5HTyCUAhpAp3CLM4iyBoqge/l5o2SbRMHnaE
         4fPBCLfXtGrUX+xNL9dC8CSa0s6WEQlkhSzZVOIiDppbJ2Y4UpSbi7fJTe5b187FzAwp
         4hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlSKAs3s0kr2VyaxlqapX2mwoIuc6vEDbZK8m3Uw8dg=;
        b=qiy5ZtVWn4ExFUb5/BovZWgNK/vBZkKpuJ9vIdOISLoSj//foQpljTynHEByqMWqNJ
         Jti8jKQFt/FLr97TTjlyu2gPlBApIRcDQRZHMDTvh6PhEdrkxSXfZJSI3ytn7cTRF6fl
         +Ra1mOhc1ifl9NK4PbwMWzdvNAEG4dLBYbzGEqNee2B3eKx5hFJ5qBCORw7NSgCw+HNq
         ZpYaQqZ+MB4ytypieMo0wBQZwU7hnoJeP5FWnQIett4qAP/Jhm9jsJaYP+81lr/7+3p/
         0yRpDiEfqTgGDHCwvNvdAKAPumv+hb2mQRz3P4Nt7EYBZBMCsP3Fcv2h+aNem4qTZmpn
         3KbA==
X-Gm-Message-State: AOAM531ZEcltEqLA2qxu6yvhLS61ZLSvbrdJdrQoRTr8uI3sL+wHjEvW
        JOHPvcZ/EtvlRBURP5/9VmOGKHN9hix2+kzGRgQ=
X-Google-Smtp-Source: ABdhPJzXODSxm5106EThbJSsvwHEbzsQiRKh85txkF604PRnqTAnsgWm+JdyyEt11RD8r6FhAnQ42EufT61/8uxy3vw=
X-Received: by 2002:a05:6102:f06:b0:337:9881:5031 with SMTP id
 v6-20020a0561020f0600b0033798815031mr1105757vss.67.1653118657556; Sat, 21 May
 2022 00:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn> <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
 <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com> <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
 <cdbb002a-9f0a-caa9-445e-4ba20328171a@redhat.com> <CAAhV-H7yKVWaiU_VKnc2YnCSeZPOwedRWMY8ZTS-VWwk+vE0AA@mail.gmail.com>
 <256e0b82-5d0f-cf40-87c6-c2505d2a6d3b@redhat.com> <CAAhV-H7bJv5V5UKJCWgEbOdOWZhnma3_3eAXbbY1MX_uKodjgg@mail.gmail.com>
 <859d5489-9361-3db0-1da4-1417ed2fad6c@redhat.com>
In-Reply-To: <859d5489-9361-3db0-1da4-1417ed2fad6c@redhat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 21 May 2022 15:37:30 +0800
Message-ID: <CAAhV-H4UxkyHr=NQGFAAjCXwXHXDLsN_CV-tSCn6oonOSSjb0A@mail.gmail.com>
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

On Sat, May 21, 2022 at 3:07 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Huacai,
>
> On 5/21/22 03:40, Huacai Chen wrote:
> > Hi, Javier,
>
> [snip]
>
> >>>> Conversely, if the sysfb_init() is executed first then the platform device
> >>>> will be registered and latter when the driver's init register the driver
> >>>> this will match the already registered device.
> >>> Yes, you are right, my consideration is too complex. The only real
> >>> problem is a harmless error "efifb: a framebuffer is already
> >>> registered" when both efifb and the native display driver are
> >>> built-in.
> >>>
> >>
> >> But this shouldn't be a problem if you drop your register_gop_device() that
> >> registers an "efi-framebuffer", since sysfb would either register a platform
> >> device "simple-framebufer" or "efi-framebuffer", but never both. Those are
> >> mutually exclusive.
> >>
> >> I think what's happening now is that sysfb is registering a "simple-framebuffer"
> >> but your register_gop_device() function is also registering an "efi-framebuffer".
> > No, I have already removed register_gop_device(). Now my problem is like this:
> > 1, efifb (or simpledrm) is built-in;
> > 2, a native display driver (such as radeon) is also built-in.
> >
>
> Ah, I see. The common configuration is for the firmware-provide framebuffer
> drivers ({efi,simple}fb,simpledrm,etc) to be built-in and native drivers to
> be built as a module.
>
> > Because efifb, radeon and sysfb are all in device_initcall() level,
> > the order in practise is like this:
> >
> > efifb registered at first, but no "efi-framebuffer" device yet.
> > radeon registered later, and /dev/fb0 created.
> > sysfb_init() comes at last, it registers "efi-framebuffer" and then
> > causes the error "efifb: a framebuffer is already registered".
>
> Yes, this is problem because only conflicting framebuffers and associated
> devices are unregistered when a real driver is registered, but no devices
> that have not matched with drivers and registered framebuffers or disable
> devices to be registered later.
>
> I proposed the following patch series but the conclusion was that this has
> to be fixed in a more general way:
>
> https://lore.kernel.org/lkml/20220511112438.1251024-1-javierm@redhat.com/
>
> > make sysfb_init() to be subsys_initcall_sync() can avoid this.
> >
>
> Right, now I understand your problem and you are correct that this will
> avoid it. But I believe is just papering over the issue, the problem is
> that if a native fbdev or DRM driver probed, then sysfb (or any other
> platform code) should not register a device to match a driver that will
> attempt to use a firmware-provided framebuffer.
>
> A problem with moving to subsys_initcall_sync() is that this will delay
> more when a display is available in the system, and just to cope up with
> a corner case (as mentioned the common case is native drivers as module).
OK, your method seems better, but I think moving to
subsys_initcall_sync() can make the screen display as early as
possible.

Huacai
>  --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
