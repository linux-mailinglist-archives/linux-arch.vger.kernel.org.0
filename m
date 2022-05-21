Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA0452F75C
	for <lists+linux-arch@lfdr.de>; Sat, 21 May 2022 03:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiEUBkY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 21:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiEUBkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 21:40:23 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D1D17CE7D;
        Fri, 20 May 2022 18:40:22 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j7so9173420vsj.7;
        Fri, 20 May 2022 18:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDfEl5mt67Uk2JtFy1F5etR1XIT/8mQYkvO3Y6QSrnY=;
        b=hLep6F/+HhOrX2anekYXeIn7SaxYEzurrjmjYW4f+vxS+JC6ZbV0/lkE6ZkM4ZHhhM
         p6GFFM/ejJFgLpsjjgUFQM9qBp8zwTW7B9MDFvN6FLMuvZd/JEk3cLbXSHelnSs2aGXp
         jGgEw3WRD46cdSdXuCsarwv2NKu0GRDLj8CND5r3df0H3obYCy+nNmSnWkSfK9fj1FWz
         Sj6ZUMGV5oL1yt5GJPwZv2c/jCHSdRXrn0hFJOK3F6JYy3pAz2EXSO2HAOhSgX0hl3ik
         9sJUP2WRMeK+s+JXxOPSKNm0UqNubiogxx9SyEnlvlbT4WI7Jxq/njmOYaTIgRMAAUmx
         s4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDfEl5mt67Uk2JtFy1F5etR1XIT/8mQYkvO3Y6QSrnY=;
        b=4aO9nWmFElTkcIITWatva/+BjJ6cXxEReUZj9OEtNmGhCoiinrP6kVTHse3Rbyxysg
         qL5jsf1zYzHGe+O2APKR0CAhfJycFmQA6TvWHfKmJ32sD2/u2aIAQWHpZBwfckJzfcm5
         kKBJPqtpyPOa4BlNFOFkupscRtapsVmvZDwOpGHdaDPWI4dzjTIt6kFxBfDD3YgP7NgF
         M45DydNtxw+FKSetEDU6spXLMDpL1cW4rbBPrSnwrvMP7aG6u7R6OoSRU74X7UFWgFKZ
         c/4cX1YK6BPd5l9i40zZMzRh1JM2OZJ/O02uJdpQ6e7PZFTGKWOfe+F2UQnnqDC9wqJP
         O50A==
X-Gm-Message-State: AOAM532L/E3QLWgkqdI4WDqOWi9cQc65DFJYf9iRTEmIqj5TGS2459X0
        RMnF0niwtK8tJ2JBynHbtowCDH2QLEayymzEDfNuQgwMfgC4ReLl
X-Google-Smtp-Source: ABdhPJxkwuvt7UNsBHH6RpwJ8o1/BmWjNqdYFULK/sZIG4mAQRSe0B3XH2Tix4Jl6SEfwxmzYxI6uj5N7WAG9IxDD1M=
X-Received: by 2002:a05:6102:f06:b0:337:9881:5031 with SMTP id
 v6-20020a0561020f0600b0033798815031mr884291vss.67.1653097221459; Fri, 20 May
 2022 18:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn> <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
 <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com> <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
 <cdbb002a-9f0a-caa9-445e-4ba20328171a@redhat.com> <CAAhV-H7yKVWaiU_VKnc2YnCSeZPOwedRWMY8ZTS-VWwk+vE0AA@mail.gmail.com>
 <256e0b82-5d0f-cf40-87c6-c2505d2a6d3b@redhat.com>
In-Reply-To: <256e0b82-5d0f-cf40-87c6-c2505d2a6d3b@redhat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 21 May 2022 09:40:14 +0800
Message-ID: <CAAhV-H7bJv5V5UKJCWgEbOdOWZhnma3_3eAXbbY1MX_uKodjgg@mail.gmail.com>
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

On Sat, May 21, 2022 at 12:32 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> On 5/20/22 17:19, Huacai Chen wrote:
> > Hi, Javier,
>
> [snip]
>
> >> Conversely, if the sysfb_init() is executed first then the platform device
> >> will be registered and latter when the driver's init register the driver
> >> this will match the already registered device.
> > Yes, you are right, my consideration is too complex. The only real
> > problem is a harmless error "efifb: a framebuffer is already
> > registered" when both efifb and the native display driver are
> > built-in.
> >
>
> But this shouldn't be a problem if you drop your register_gop_device() that
> registers an "efi-framebuffer", since sysfb would either register a platform
> device "simple-framebufer" or "efi-framebuffer", but never both. Those are
> mutually exclusive.
>
> I think what's happening now is that sysfb is registering a "simple-framebuffer"
> but your register_gop_device() function is also registering an "efi-framebuffer".
No, I have already removed register_gop_device(). Now my problem is like this:
1, efifb (or simpledrm) is built-in;
2, a native display driver (such as radeon) is also built-in.

Because efifb, radeon and sysfb are all in device_initcall() level,
the order in practise is like this:

efifb registered at first, but no "efi-framebuffer" device yet.
radeon registered later, and /dev/fb0 created.
sysfb_init() comes at last, it registers "efi-framebuffer" and then
causes the error "efifb: a framebuffer is already registered".
make sysfb_init() to be subsys_initcall_sync() can avoid this.

Huacai

>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
