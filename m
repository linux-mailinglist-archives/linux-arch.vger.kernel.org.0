Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B6E52EEEC
	for <lists+linux-arch@lfdr.de>; Fri, 20 May 2022 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350716AbiETPUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 May 2022 11:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiETPUI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 May 2022 11:20:08 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2170177892;
        Fri, 20 May 2022 08:20:06 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id o2so8442571vsd.13;
        Fri, 20 May 2022 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ldYu4uEd9EUTgULDcpam0C8yau3sO4b+CjjUvv2d4OQ=;
        b=E7Oa2UTH/aQ9fbr2uLMmgrKJCUty+fZ/ANDeR317sVrNQK+NnFTYsNAhpMdech16Eb
         z5yLxC0w59nnpKFh4Vpsejh+Ob+KZG4o7Z/ZsDoDvvnp2q5oQu3Hgwwyb0nh5GctICx5
         F/NLJmoHdUmCnJcNomziJOqdsnhCFBGw/N2VUMlP6vzEbT1WlnSY0qArzdFf8AP98k5N
         dfdw9HEbmHLyJhyK74PWyIKZJk1DRq9h4Qwia707cfVwk63DzoqHYFfA2aUqNxmadCmX
         Ncf7+Wfb3nGjrOMd42QKGbamRvP+jDs9wMLN6WC0qdNQAMC5JetWFk0OlHMuVi76pQD8
         tgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ldYu4uEd9EUTgULDcpam0C8yau3sO4b+CjjUvv2d4OQ=;
        b=C5lhm7xn2M8GaKGPxYn1l9GILtmONrEao9+paiO9oSoigrkfAwv3xLuBPXwVZFFkMv
         vZkqRBQa/wP/3fp2RTby/H0zwnagj59RN+SzaoDauy7U0zW57oBltQTUhxPBbP8kgHPD
         0ojYAVtyXVsp76rFGybBPc7llbucjlpaRBrSC4ahW/0ZXm1DKlqmr4zj26X8zEJhC2+n
         2zeV3rfkCRYpnX6qAQKpGxorCxvk2pj09utAL2ppft8nE1KbTEAZQNkpqWIjfj9tcUMO
         w0coNWyzeKUmEm1RfoZjEIAZV6Sd1Sq59xGMbmDVB6iPDqW/EXSO5x6wA1GwwKocQlXp
         IoAw==
X-Gm-Message-State: AOAM5332pJ5oZTP1lHsmF+G4nDDDIeUZOyOLzk/KSNvnrQMldSvrB+pT
        4eUCQEQKDGQML26PbrzRDaTd0UDDJMVqyiAA/b4=
X-Google-Smtp-Source: ABdhPJzm46aRGTJE5xdyxgtvxKN1pS2wNrW6p1Z/Gh8TEIUJ5v0Wc3zHvtxjN0Jg/TWwHkPgvD8c+6T9hgfXuVbIzzE=
X-Received: by 2002:a67:e899:0:b0:337:932a:2fc5 with SMTP id
 x25-20020a67e899000000b00337932a2fc5mr823786vsn.40.1653060006120; Fri, 20 May
 2022 08:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn> <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
 <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com> <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
 <cdbb002a-9f0a-caa9-445e-4ba20328171a@redhat.com>
In-Reply-To: <cdbb002a-9f0a-caa9-445e-4ba20328171a@redhat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 20 May 2022 23:19:54 +0800
Message-ID: <CAAhV-H7yKVWaiU_VKnc2YnCSeZPOwedRWMY8ZTS-VWwk+vE0AA@mail.gmail.com>
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

On Fri, May 20, 2022 at 10:23 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Huacai,
>
> On 5/20/22 16:09, Huacai Chen wrote:
>
> [snip]
>
> >>
> >> In summary, just enable the following to use the firmware framebuffer:
> >>
> >> CONFIG_DRM_SIMPLEDRM=y
> >> CONFIG_DRM_FBDEV_EMULATION=y
> >> CONFIG_SYSFB=y
> >> CONFIG_SYSFB_SIMPLEFB=y
> > Thank you very much, since 5.15 sysfb_init() do all things of
> > register_gop_device(), so register_gop_device() here can be removed.
>
> Correct.
>
> > But there is another small problem: if simpledrm or efifb driver is
> > built-in, there is no display. The reason is both sysfb_init() and
> > display driver are in the same initcall level (device_initcall()).
> > From the comments I know that sysfb_init() should after PCI
> > enumeration which is in subsys_initcall(), so, could we make
> > sysfb_init() to be a subsys_initcall_sync()?
> >
>
> I don't understand why we would need that... it shouldn't matter the order
> in which the driver's init and sysfb_init() are done. If the driver's init
> is executed first, then the driver will be registered and later when the
> sysfb_init() registers the device, it will match the driver and probe.
>
> Conversely, if the sysfb_init() is executed first then the platform device
> will be registered and latter when the driver's init register the driver
> this will match the already registered device.
Yes, you are right, my consideration is too complex. The only real
problem is a harmless error "efifb: a framebuffer is already
registered" when both efifb and the native display driver are
built-in.

Huacai
>
> In other words, it will be handled by the Linux device model and we should
> not attempt to hand pick the initcall level for each. That's quite fragile.
>
> Or am I missing something here ?
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
