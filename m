Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE3A52FA30
	for <lists+linux-arch@lfdr.de>; Sat, 21 May 2022 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiEUJNz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 May 2022 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiEUJNy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 May 2022 05:13:54 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F3354198;
        Sat, 21 May 2022 02:13:53 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 63so3687795uaw.10;
        Sat, 21 May 2022 02:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xLfza2d9jzWSXETuWGWxHMn70hKxdLj4BEKjI+ZN4KU=;
        b=oSIMjo+HBdeabEZsbQ2Tknmp8ML4BwyqlGIQbOvpgvEgNmn7vZeTww6VUJqw9sLz37
         a3uXXO18DxKzzA8bTJazl+uJ6rFE9nZTMhXdFWl3LJRDhADCRszXzAHbhw1cWIrc+xIi
         5jSjPrkpKkJ5hZoNeB86u1oZDgOphLkh7CCZdoO3job5/1ffzcxGIZeQGbQ4xCOax/hl
         8yXkFoVSN36VhJ0BsrwsxrHoh183yVltVm39xSwrooDgDtgMPj+JGD/EQQC9AHGOUXbM
         4cKbJOwhWlGiH36Xqbe65bsdyQac0gTbpDYYR3w/Qonby0sGWeRtx5Wy0wejprXd1qT7
         qibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xLfza2d9jzWSXETuWGWxHMn70hKxdLj4BEKjI+ZN4KU=;
        b=fWbFIdo869+PVN6F/yjoP9OjxUNzeKDYfZevgk7cEGYDfYY2unleGqadXYlqbyfPsr
         Ub8FHB7qPPIE38UPnN0wFg/nnxH9gWlFkzBZ+tt0/G/vGgpYEIenseGP1s4eMoaZXm/A
         4tTkImQ31YvdmV6zdQwBhqVawKwKxbLPT6L5xyLuyeq7c+hSnzuTD/Bc86YzXif0ppTF
         +R5seXbP+v1cydnh1ED+i1QAYSYpr63QXP1gbbYTSaI0ah5u/17KaBwwROCoyCTb8rZR
         EL5FXo8XsrYHnlJYLubS8mLXbk74m+SJuzArzq2w2F6tWhuNFhtNZWOgr2U05QRSe5vo
         9o6A==
X-Gm-Message-State: AOAM531HQSLKNRsbV9u0Yf61MqhcVm4rfeLY2pnwvinw/EKW4fQN3Tte
        sPikxymcTkxWX7u2tJCoYdvOdaaR8bXfkfGgGY4=
X-Google-Smtp-Source: ABdhPJyhyvWZH9qrdJngswSfpnin3gAydt0836+qEP+NLvaL1+4syh6qaBPTfW5wDBLc4t4TyTFHx0CWjQq10QuKJUo=
X-Received: by 2002:a9f:354f:0:b0:368:c2c0:f2b5 with SMTP id
 o73-20020a9f354f000000b00368c2c0f2b5mr5086632uao.96.1653124432029; Sat, 21
 May 2022 02:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-10-chenhuacai@loongson.cn> <CAMj1kXEBVWi2ZdR5Le5-G0DA43u-AMxmSO=pVt39qwN=PkzQfw@mail.gmail.com>
 <0bae0df1-48ae-d02f-bce4-d1f69acf269e@redhat.com> <CAAhV-H5dqNiecER3fChkBjQUGGszj6gwcpOFM1b4Kaax5vz27g@mail.gmail.com>
 <cdbb002a-9f0a-caa9-445e-4ba20328171a@redhat.com> <CAAhV-H7yKVWaiU_VKnc2YnCSeZPOwedRWMY8ZTS-VWwk+vE0AA@mail.gmail.com>
 <256e0b82-5d0f-cf40-87c6-c2505d2a6d3b@redhat.com> <CAAhV-H7bJv5V5UKJCWgEbOdOWZhnma3_3eAXbbY1MX_uKodjgg@mail.gmail.com>
 <859d5489-9361-3db0-1da4-1417ed2fad6c@redhat.com> <CAAhV-H4UxkyHr=NQGFAAjCXwXHXDLsN_CV-tSCn6oonOSSjb0A@mail.gmail.com>
 <7caec251-20e7-4a8c-93ee-b28558ec580f@redhat.com>
In-Reply-To: <7caec251-20e7-4a8c-93ee-b28558ec580f@redhat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 21 May 2022 17:13:45 +0800
Message-ID: <CAAhV-H6pfv4OQ5PhSfzG9YM_q5DYdgZ0DHVT7Aac9sppXGgnaA@mail.gmail.com>
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

On Sat, May 21, 2022 at 5:06 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Huacai,
>
> On 5/21/22 09:37, Huacai Chen wrote:
>
> [snip]
>
> >>
> >> A problem with moving to subsys_initcall_sync() is that this will delay
> >> more when a display is available in the system, and just to cope up with
> >> a corner case (as mentioned the common case is native drivers as module).
> > OK, your method seems better, but I think moving to
> > subsys_initcall_sync() can make the screen display as early as
> > possible.
> >
>
> But it doesn't cover all cases. For example, you will get the same error
> if for example your native driver is built-in and efifb built as module.
>
> So my opinion is that instead of playing with the init call levels, is
> just better for you to build your native driver as a module instead of
> making it built-in.
I mean moving to subsys_initcall_sync() on top of your patchset, not
replacing them (Just for display earlier).

Huacai
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
