Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F99527754
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 13:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236223AbiEOLr2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEOLr0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 07:47:26 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8232DE0;
        Sun, 15 May 2022 04:47:25 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id b7so8473732vsq.1;
        Sun, 15 May 2022 04:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1UIMuZgS/AaTJF7a/43WreHqXJqcISPM00CuLOlmcj0=;
        b=bs7QG/rTI+A7/Mi3DRYwemoChEEIRYLjpy1cPxyjbPqeEZhieYgAAFFRTyaOfRMi4S
         d7teP3P5hPZK2jT75MZOrF+brqwgQ6cHhwkBAmCca5QCWjdRFlDUyFc+N5fQiy9bVdZW
         UtUWol+xdNeva2dTEcstIgbMGv/5OZ8RsRfnB64Yh3G5AQroO+Z9pphiS/zYEvx/tMir
         tsaiW/RDw4G9SUdJrRVZL5mgZKissHcUxuiZIk+KvO6ZeyPOsLGmQMQq1h4ENjBSVKES
         tlZmoXrBjNGonLhOwU844DYJA2UNwlQKayDsAph/N9x3CPxTNUl5+hs/35TMUm30EX6F
         c/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1UIMuZgS/AaTJF7a/43WreHqXJqcISPM00CuLOlmcj0=;
        b=K5+NlekmZE3Xdz1gmL7vOp51EwcMW1hWvkLqblSN0P8rSsCMwCHEbyeWYqfCDQRTUv
         6h2f6n07/aq2WNj5i3N95BdXRo/fic9Co9m1vTG/deY7onF+Fan8296etE3AkFc8EJci
         am/rQoHxg79YkO+iPt1UwgPXlyLk+jFNe4LKe3j8Aa3/abVeKwUBdH74kGdUuVkpgolf
         dqRyb/1b4O1gyPbTfjxNnxgMQSjECYS4EqzZJN/4vz+WzNjNrjKG1gb2l+HT9bGKSJba
         PIoVT7/wzb5xhQyKev7FpRWMhrPpySr8Kma0BPAVKqQ0VEkweZXWG8Zx3uLaS+T0K/TQ
         JKgw==
X-Gm-Message-State: AOAM530J4zodnYpop+XZvUz1ImUOP6XGspkN9sy/Sgt/sV9T0MeUb/Sm
        /7NYf9Tenq2PEECjFSYv6tvn900+1xLAvy97QWs=
X-Google-Smtp-Source: ABdhPJwnKqeNk1/oUEf3jPm+yQufYknA1Sva4/GXH50sMSV7ytzHERTe7CoQ8Ci/rg1LzOfQHDqnGTFrV/FSbYi8mjk=
X-Received: by 2002:a67:e9d1:0:b0:32c:eb44:efd6 with SMTP id
 q17-20020a67e9d1000000b0032ceb44efd6mr4527784vso.16.1652615244161; Sun, 15
 May 2022 04:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-4-chenhuacai@loongson.cn> <25efb0c1-f2e7-0052-c925-08dd778d7ad7@xen0n.name>
 <CAAhV-H6rBtmTQTpxdZtk26sP9SJui5dpv2e-2ZUyWTtpxpf9FQ@mail.gmail.com> <689e103a-07f0-a55c-9b34-073cf81f84c0@xen0n.name>
In-Reply-To: <689e103a-07f0-a55c-9b34-073cf81f84c0@xen0n.name>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 19:47:13 +0800
Message-ID: <CAAhV-H7qWgRvmhREhyJF7cHKN6V+r1RFcZ1zit-VyevoQLFD9g@mail.gmail.com>
Subject: Re: [PATCH V3 03/22] LoongArch: Add elf-related definitions
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

On Sun, May 15, 2022 at 12:13 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 5/14/22 22:11, Huacai Chen wrote:
>
> > Hi, Xuerui,
> >
> > On Sat, May 14, 2022 at 9:29 PM WANG Xuerui <kernel@xen0n.name> wrote:
> >> Hi,
> >>
> >> Why this patch is from V3? I guess it's by mistake so would you re-send
> >> a proper v10?
> > This is just a typo, it is really V10.
> Okay, got it.
> >
> > Huacai
> >> On 5/14/22 16:03, Huacai Chen wrote:
> >>> Add elf-related definitions for LoongArch, including: EM_LOONGARCH,
> >>> KEXEC_ARCH_LOONGARCH, AUDIT_ARCH_LOONGARCH32, AUDIT_ARCH_LOONGARCH64
> >>> and NT_LOONGARCH_*.
> >>>
> >>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>> ---
> >>>    include/uapi/linux/audit.h  | 2 ++
> >>>    include/uapi/linux/elf-em.h | 1 +
> >>>    include/uapi/linux/elf.h    | 5 +++++
> >>>    include/uapi/linux/kexec.h  | 1 +
> >>>    scripts/sorttable.c         | 5 +++++
> >>>    5 files changed, 14 insertions(+)
>
> The code changes all look good to me, only minor typographic nit: please
> change "elf" to "ELF".
OK, thanks,

Huacai
>
> With that:
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
