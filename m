Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9970953C40A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 07:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiFCFN5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 01:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiFCFNv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 01:13:51 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EB51E3CF;
        Thu,  2 Jun 2022 22:13:50 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b17so668971ilh.6;
        Thu, 02 Jun 2022 22:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6nwj+N0btcAhrlduVQaHIJkNfwj6bOjYkg8VFFJB53w=;
        b=HBHfhqzqLLypExTd6ahy302xLg7IurmMbEDCcYnorkVnh9POPCvzobQHDdBapvg2U8
         W8ps2Z/dl+expoVMqGjQEY9Ns5EBWf6hqakUyBKv3ukd3nFUYf7+fv7xO7EWln2/O3aX
         /ixbWBEaxQjOlHv55SgOz/kK7v7OBUf51zcz8dmsQxusrfP+XH7SkjFIvYNrk5633C/A
         xM0RgrKFeWzug8KbSIzlyCQ5SRlU8hernD1BMKgUbodyy/TraaUNWq4eTj3AHLDOVOLq
         Rg41Zda1b22+tjHq4PzGQLv7sca/vvCyVrzFjknE511WWTvlEjwjCiun4Drk/v5V3jYH
         VDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6nwj+N0btcAhrlduVQaHIJkNfwj6bOjYkg8VFFJB53w=;
        b=Z5DVIgLKyjdD8EI/PFNUqAviyYygCcBTQo49pQUkZaFpqV6O7sGw6t4Zf3kHKDHrde
         slDP2IZXZJqJS6qZtG7v1FIF0Xv6pn7ySj2UK8YPINFSXRByFn65/Huupkd9b2ty+F5d
         urFM15Sk8uXM19qUWrhWoLOapJzo+aqJuE3hiirWZyZ007G0IDz+aVo8HndY4LEGraZY
         0ioAiq2rQRnGbmSU3ZOQ1ugrGkjOm+t3/JmRvW1iIdepKLDqmY7CcL7yuMDTh4Vkc/2J
         jnPdAtxLu5jZ8w/zuBkKktsq6t39KiWkptTaP7XHu0xxS7ZQSborp+VU6scTKFALgEIe
         hRQg==
X-Gm-Message-State: AOAM531YVOsO9OmUVTcpC3F4wKdxGqznPGcgoMLdpF3ftxFKN5DJ7OrF
        5aVuDIINY0SNvwqvFeK6PhNAWjLHD4y0FSvHenE=
X-Google-Smtp-Source: ABdhPJzLV3/h9JnimRUMzzPBUrj78Wu/O1S+cL3jrwWVQaadkihCHqwN8D4zsdFvDJsERNstWwPos9zXeCV5mJbs9vc=
X-Received: by 2002:a92:194c:0:b0:2c8:2a07:74e7 with SMTP id
 e12-20020a92194c000000b002c82a0774e7mr4979140ilm.272.1654233230074; Thu, 02
 Jun 2022 22:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-12-chenhuacai@loongson.cn> <d88ede74-b7a5-e568-1863-107c6c7f5fe0@xen0n.name>
 <CAMj1kXE1Gg+jN0yGZCi86HQBPrtX=-EHjMW9Z9XxsobH=RS0LA@mail.gmail.com> <CAK8P3a2dv1_vtg2k8ifxD+XAJX6SZEYRsCt0W065yDA9gmssmg@mail.gmail.com>
In-Reply-To: <CAK8P3a2dv1_vtg2k8ifxD+XAJX6SZEYRsCt0W065yDA9gmssmg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 3 Jun 2022 13:13:40 +0800
Message-ID: <CAAhV-H4jLqrVJnMNY6j35pUAbmGkTAAP0X6SCBa8zTj9kRQg+Q@mail.gmail.com>
Subject: Re: Steps forward for the LoongArch UEFI bringup patch? (was: Re:
 [PATCH V14 11/24] LoongArch: Add boot and setup routines)
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-efi <linux-efi@vger.kernel.org>,
        WANG Xuerui <git@xen0n.name>, Yun Liu <liuyun@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

Hi, Ard and Arnd,

On Fri, Jun 3, 2022 at 12:29 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jun 2, 2022 at 6:14 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Thu, 2 Jun 2022 at 16:09, WANG Xuerui <kernel@xen0n.name> wrote:
> >
> > > For this, I don't know if Huacai should really just leave those
> > > modification in the downstream fork to keep the upstream Linux clean of
> > > such hacks, because to some degree dealing with such notoriety is life,
> > > it seems to me. I think at this point Huacai would cooperate and tweak
> > > the patch to get rid of the SVAM and other nonstandard bits as much as
> > > possible, and I'll help him where necessary too.
> > >
> >
> > I don't want to be the one standing in your way, and I understand the
> > desire to get this merged for the user space side of things. So
> > perhaps it is better to merge this without the EFI support, and take
> > another cycle to implement this properly across all the other
> > components as well.
>
> I think that's ok. As of today, there is still no working interrupt controller
> driver because it hasn't passed review yet, so there is little value in
> merging the boot support.
>
> The main point of merging the port at all is of course to allow compile
> testing and building userspace, and both can be done without being
> able to boot it.
>
> If Huacai is able to produce a tree by tomorrow that still builds and
> leaves out the boot support, I can send a pull request to Linus and
> let him make the final decision about it, but at this point I think there
> is a good chance that he prefers to let it all sit for another release.
>
> If the port doesn't make the cut for 5.19, we can still debate with the
> libc maintainers whether they want to merge their side of it anyway,
> given that the user ABI at least is now as stable as one plan for,
> regardless of the upstream state.
Thank you very much. It seems that the majority of our efistub design
is completed (drop bootparamsinterface and use generic stub), but
there are still some details that need further discussion. E.g whether
to map the runtime in kernel address space, and where to call the SVAM
routine. So, I agree that we should temporarily remove the efistub &
efi runtime parts, in order to make other "good parts" be upstream
first. I will send V15 today,  as soon as possible.

Huacai

>
>       Arnd
