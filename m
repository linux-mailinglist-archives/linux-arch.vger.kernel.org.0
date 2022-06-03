Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE3B53CA50
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jun 2022 15:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbiFCNBn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jun 2022 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiFCNBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 09:01:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EF33E00;
        Fri,  3 Jun 2022 06:01:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id y17so6402901ilj.11;
        Fri, 03 Jun 2022 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rgrulR9sWDCPB8J3w8134fSxmlMlybKB98GjFOYddPM=;
        b=nZB/9Tim4HYP+RhLMDzSxYWSOsxlOt7c/zQOESbRHdxdNgnVJTtf94ATrxncZN4kD3
         i11tzP7/xhpdjjmzkRpPfOIbYWnfu8VcelF+AMt30/pnlz1b/fBcaH96JUTz0dvmSwvR
         yBaTYF0Qcz9Uuh9lLWrHHMtlG6oKj7pZUgIFdgwNH7ihpMCEYz4dQzHoZItFxpesI4zj
         xVm0/mxZGsiO/MhduXeM45jZE9V+La/hlgesJqDWFNmMqdSgB8gH4MHH2rLmoMJnP9t1
         AaMPFdDdU997v8W9YkDhoneZzLOrx7pXVUfFxJi+bbjXAsqpMZRd8DGWno6vLVQ0CfSn
         SU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rgrulR9sWDCPB8J3w8134fSxmlMlybKB98GjFOYddPM=;
        b=WOZkqgTWgQcvIU75M2Ohi1T4qfH0Wc/011nL9ilHvOb79a9/SO0lz+77Kv0nNpCjef
         WxLtYOP+QyN6ggvkB/1+jxrnA8jjZH8tC5IiCEFRXwfyQVTOCBEoUik6yL27HRwkjkSH
         mP8T34pnSryfC6+TYaeoC2vUl4dqYf7YVvwGVrKkn6mKQ4y9KS+FGruqcBMlIWfsrNCA
         7rycZlns0YMN24mlfN07/tlmJDpAE+SFvbEYLozwV+co4XSzd9XmFyY8NK6mg8kwCrF2
         ex7L3KGI7RZp7bcMvE4xCT27HlYFbGZIBrnxVuF5VxaPr3/vfQzrmwyv8qpSLyHZscNo
         oQ3A==
X-Gm-Message-State: AOAM533gYsbKYXyGW/iwVOa3iDwWpapBvyD27/j5yzcWgEFzHyOASU5y
        RE0y9Zx/LPtp0iYudWB9UmLv0nbr2Cywjy1nk08qez4kSG2XAGNTz1w=
X-Google-Smtp-Source: ABdhPJyO+Wy90k2d7bT9meJht2LMrT2KMmjl3ZbZHYIX42IrUTb483qKosBX0l5mNBSohko5/wmN7WiKuJk6RZCTo6Y=
X-Received: by 2002:a05:6e02:12b4:b0:2d3:a822:3a16 with SMTP id
 f20-20020a056e0212b400b002d3a8223a16mr5629446ilr.279.1654261301972; Fri, 03
 Jun 2022 06:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220602115141.3962749-1-chenhuacai@loongson.cn>
 <20220602115141.3962749-4-chenhuacai@loongson.cn> <YplnruNz++gABlU0@debian.me>
 <CAAhV-H5Hi_gYvrO6DAGGA=OVExunCubNpDBdkRBxFxiP1APAKw@mail.gmail.com> <de31731a-5cb5-ece1-6b7f-895d9c04fa95@gmail.com>
In-Reply-To: <de31731a-5cb5-ece1-6b7f-895d9c04fa95@gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 3 Jun 2022 21:01:31 +0800
Message-ID: <CAAhV-H53=9=qsmasoZ6efeiCez4vo0P2Eg-itTvNh3zerCtJsg@mail.gmail.com>
Subject: Re: [PATCH V14 03/24] Documentation: LoongArch: Add basic documentations
To:     Bagas Sanjaya <bagasdotme@gmail.com>
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
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        WANG Xuerui <git@xen0n.name>
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

Hi, Bagas,

On Fri, Jun 3, 2022 at 3:35 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 6/3/22 12:27, Huacai Chen wrote:
> > Thank you for your testing. In my environment (sphinx_2.4.4), with or
> > without the border both have no warnings. :)
> > And I think these are more pretty if we keep the border, especially
> > when formatted into PDF. How do you think?
> >
>
> I think what you mean is reST table border, right?
>
> By comparison, in Documentation/arm/booting.rst, there is a diagram
> in "Setup the kernel tagged list". The diagram is written just inside
> the literal code block and works fine, albeit the code block
> spans fully. The diagram is small, however.
>
> Otherwise, I see unequal padding in rendered IRQ diagrams. If I
> remember correctly, the bottom and left padding are larger than top
> and right padding. IDK why.
>
> So please apply my suggestion diff.
Your suggestion has been accepted now, thanks.

Huacai
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
