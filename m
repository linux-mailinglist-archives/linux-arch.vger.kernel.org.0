Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE44D423A
	for <lists+linux-arch@lfdr.de>; Thu, 10 Mar 2022 09:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbiCJIK7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Mar 2022 03:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiCJIK6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2022 03:10:58 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCEC13396D;
        Thu, 10 Mar 2022 00:09:58 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id jq9so4012994qvb.0;
        Thu, 10 Mar 2022 00:09:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfibjxXpSiDUQkdsSWqfUL3zPU0FxzAokd4WU1kLbJM=;
        b=VIHeGNCzsEug6JSTznyhYDRuqFYhNS5IM+wCUly3SyVu8S0B9DaDbotAGybkwkGGUw
         bu+229bxuffmxyN3GNyVZmD8jv3yaRW9lchcZU+J3qmkgsTqT7ncNw/85MYVI3yAo9xz
         fpaYFMwt8y5ScjXf3ngWvmLw7pDcZu3yMYL+71q3oeOsGfGLQdrLcyfBWseLSyF+s9Q7
         Y244WsdUGzjpyQVtHfnd/u63AUmUETwI4cIWYGN/eEkB6imcYurnxzZ7trhM7curroMN
         /2DpUA7JZWrbIqO1el24YNj+s+/9kqvGPTn6hi40ALf9FavrG7bFFTZwC1QhtkRUgxOO
         CExA==
X-Gm-Message-State: AOAM531WzJaKG2X44Px14YzepFfZR8WSJFjGIjvyVF5w+mPYEBZrzsEm
        sqXQ40E05Oz4hsvFl630lOaPk7OcwmIFmg==
X-Google-Smtp-Source: ABdhPJxICWNDTxNVx7O/YwUWXStD8W1F+v06J6hGPZuCfIaFgRldu+p1o0OD3lSlzKcHSygKWfyaIw==
X-Received: by 2002:a05:6214:29e9:b0:435:3428:d0f3 with SMTP id jv9-20020a05621429e900b004353428d0f3mr2751669qvb.28.1646899796952;
        Thu, 10 Mar 2022 00:09:56 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85916000000b002d6844c51b9sm2811209qty.86.2022.03.10.00.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 00:09:56 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id f38so9391427ybi.3;
        Thu, 10 Mar 2022 00:09:56 -0800 (PST)
X-Received: by 2002:a5b:5d0:0:b0:623:c68d:d473 with SMTP id
 w16-20020a5b05d0000000b00623c68dd473mr2923471ybp.506.1646899795891; Thu, 10
 Mar 2022 00:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20220113160115.5375-1-bp@alien8.de> <YeBzxuO0wLn/B2Ew@mit.edu>
 <YeCuNapJLK4M5sat@zn.tnic> <CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com>
 <YeHLIDsjGB944GSP@zn.tnic> <CAMuHMdUBr+gpF6Z5nPadjHFYJwgGd+LGoNTV=Sxty+yaY5EWxg@mail.gmail.com>
 <YeHQmbMYyy92AbBp@zn.tnic> <YeKyBP5rac8sVvWw@zn.tnic> <b40d1377-51d5-4ba3-ab3f-b40626c229ad@physik.fu-berlin.de>
 <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87ilsmdhb5.fsf_-_@email.froward.int.ebiederm.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Mar 2022 09:09:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLyu6LNONJa1QcMGv__bWSCRvVq9haD7=fOm1k5O3Pnw@mail.gmail.com>
Message-ID: <CAMuHMdVLyu6LNONJa1QcMGv__bWSCRvVq9haD7=fOm1k5O3Pnw@mail.gmail.com>
Subject: Re: [PATCH] a.out: Stop building a.out/osf1 support on alpha and m68k
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Borislav Petkov <bp@alien8.de>,
        "Theodore Ts'o" <tytso@mit.edu>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Michael Cree <mcree@orcon.net.nz>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 9, 2022 at 9:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> There has been repeated discussion on removing a.out support, the most
> recent was[1].  Having read through a bunch of the discussion it looks
> like no one has see any reason why we need to keep a.out support.
>
> The m68k maintainer has even come out in favor of removing a.out
> support[2].
>
> At a practical level with only two rarely used architectures building
> a.out support, it gets increasingly hard to test and to care about.
> Which means the code will almost certainly bit-rot.
>
> Let's see if anyone cares about a.out support on the last two
> architectures that build it, by disabling the build of the support in
> Kconfig.  If anyone cares, this can be easily reverted, and we can then
> have a discussion about what it is going to take to support a.out
> binaries in the long term.
>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-alpha@vger.kernel.org
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> [1] https://lkml.kernel.org/r/20220113160115.5375-1-bp@alien8.de
> [2] https://lkml.kernel.org/r/CAMuHMdUbTNNr16YY1TFe=-uRLjg6yGzgw_RqtAFpyhnOMM5Pvw@mail.gmail.com
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

>  arch/m68k/Kconfig  | 1 -

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
