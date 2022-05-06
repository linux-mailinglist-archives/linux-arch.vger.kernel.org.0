Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B17751D8D6
	for <lists+linux-arch@lfdr.de>; Fri,  6 May 2022 15:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391705AbiEFNYt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 May 2022 09:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392347AbiEFNYr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 May 2022 09:24:47 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E2366FBB;
        Fri,  6 May 2022 06:21:01 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id v139so7173642vsv.0;
        Fri, 06 May 2022 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ov/2s8L5gt/KlpinanE/9NpBhE3fk6VnsmvlXmdq/tA=;
        b=HVOjmBsa8kBJNSGcp8KgsSBEbZqqaI7zDGE7jxIHn5y9/M+EbLZT05sakERciInCNa
         bpaf948KuVtXAbBuuHvpV52Qi5sRvPZ8OEpfvZFfwSa/DrFo9xViw9bWDmh3MB/eX1zN
         WjYq2uaw1JL80Q+PE92wayWOwBLlQqWF7OZ3/64idHgI3i+GXC7MVA3Y0DmRDgrbLarU
         xsTJxgXi7BDnMn4KKSkW+bZTu1Sp2ffaWt7CxmTnXfofBTeJgU0jEX/z8DhkxSbQ7gMP
         5ZwUcRF7izU535xyZ9K6wyWuDmUDY/pYs67HlhgvufmetPivMYncaOghg2KFMKtsxciZ
         KB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ov/2s8L5gt/KlpinanE/9NpBhE3fk6VnsmvlXmdq/tA=;
        b=sPlV8bPUGQvbTcgB6eC/MbirSuAg6X/Hb5dv8or3z/tShnBv/3AXPggBSZiCltshuo
         6pAFJE7/fV9KKwVcaJFwbno+Zl9nHndl98OfZRdZm8SkXHYYVBde+2E1aNcSlsKwFyC2
         qARmth1urZgEi1GtAVTRbZs8MNQqh9Cy47cdCqpq+cSmWQ1YQ63E6nrRpYyS1dePGfBt
         BbswgWV8xDxF5yQDoLjOCUFW0ERmJLR7ccKTeOvUEPPUJHaPVobKEjYvb+17iHMzNFAZ
         ohUEGkR/hpPjcUrhLLcEA929KA1u0iOR/+Yj9QT4RygYzb2EPuPzx7XrYeBPtQjMcHu5
         I2Hg==
X-Gm-Message-State: AOAM5320curBc33DnTfDxhuggdk4S8SCr+UdjbRMUoZUJWd5Sw0yQaWy
        MrkBhw7ENk2ZLD0b4kvwzZ+3GeL0FP10pNU6s4E=
X-Google-Smtp-Source: ABdhPJxzza0kPCqwV0BQbh/O77ndFbUKI+dODtzckIUOeQJQnROXd0zi5cGUpautfsp5ngXXQ46R0Oidd5fJ9+BauDE=
X-Received: by 2002:a67:2e91:0:b0:32c:df82:9ad3 with SMTP id
 u139-20020a672e91000000b0032cdf829ad3mr955748vsu.40.1651843260252; Fri, 06
 May 2022 06:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-21-chenhuacai@loongson.cn> <CAK8P3a2SPTLLrZtSz0LT0LqMpq4SKCScD4vLvr+DJn+u5W_CdA@mail.gmail.com>
 <CAMj1kXEDpJwLDD4ZGLwzdo1KcJG_90iD9MnBVamCK06YKF7BdA@mail.gmail.com>
 <CAAhV-H4eR5YvhABp9L4FBmofWwH+XM3V_nOjatQTV_M7Gihs7g@mail.gmail.com>
 <CAMj1kXFD8_CuijJFgQbrxvY4MVBLmKQKFKmYhD1NBFLn3v=+FQ@mail.gmail.com>
 <a6afaa3f-cb9f-2086-0e02-5ec21ba535d4@xen0n.name> <CAK8P3a0xuh1aAM7iwE-jiBbR-OOF5YVfhmU0Nygbpviso3tmbQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0xuh1aAM7iwE-jiBbR-OOF5YVfhmU0Nygbpviso3tmbQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 6 May 2022 21:20:49 +0800
Message-ID: <CAAhV-H5FbA5DJvPwygiUyBrzq9M5R=Fr06rHAHLR31uu6ZLmkQ@mail.gmail.com>
Subject: Re: [PATCH V9 20/24] LoongArch: Add efistub booting support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     WANG Xuerui <kernel@xen0n.name>, Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

Hi, Ard, Arnd and Xuerui,

On Fri, May 6, 2022 at 7:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, May 6, 2022 at 1:26 PM WANG Xuerui <kernel@xen0n.name> wrote:
> > On 5/6/22 16:14, Ard Biesheuvel wrote:
>
> > Or is there compatibility at all?
> >
> > It turns out that this port is already incompatible with shipped
> > systems, in other ways, at least since the March revision or so.
>
> I think we can treat user space compatibility separately from firmware
> compatibility.
>
> > So, in effect, this port is starting from scratch, and taking the chance
> > to fix early mistakes and oversights all over; hence my opinion is,
> > better do the Right Thing (tm) and give the generic codepath a chance.
> >
> > For the Loongson devs: at least, declare the struct boot_params flow
> > deprecated from day one, then work to eliminate it from future products,
> > if you really don't want to delay merging even further (it's already
> > unlikely to land in 5.19, given the discussion happening in LKML [3]).
> > It's not embarrassing to admit mistakes; we all make mistakes, and
> > what's important is to learn from them so we don't collectively repeat
> > ourselves.
>
> Agreed. I think there can be limited compatibility support for old
> firmware though, at least to help with the migration: As long as
> the interface between grub and linux has a proper definition following
> the normal UEFI standard, there can be both a modern grub
> that is booted using the same protocol and a backwards-compatible
> grub that can be booted from existing firmware and that is able
> to boot the kernel.
>
> The compatibility version of grub can be retired after the firmware
> itself is able to speak the normal boot protocol.
After an internal discussion, we decide to use the generic stub, and
we have a draft version of generic stub now[1]. I hope V10 can solve
all problems. :)
[1] https://github.com/loongson/linux/tree/loongarch-next-generic-stub

Huacai
>
>        Arnd
