Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205064D1FD7
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 19:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242847AbiCHSOW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 13:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiCHSOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 13:14:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F9A1FA6A
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 10:13:24 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g17so10245249lfh.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Mar 2022 10:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uk8vMG8yzUNABGSbXXlhMALinCLxe9UxsQZpByRJJYo=;
        b=Xcm39d4IsVwThejLea1knKW9B43AMUw0+QwtNkfcHuI8k7Z3/eGWS0Lj4SWyDGFoKI
         s6xYWNIFH8MyE4ov6jE5VGI62n2Uv3aNcve3A8xjbMU7sakLrdFgdRyVCLE4GPdj2nj5
         zwD3wGo75LsCYT/agZSVQ4u4X2Wl2+l1RWoJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uk8vMG8yzUNABGSbXXlhMALinCLxe9UxsQZpByRJJYo=;
        b=PTS63pPd968moPaTWsl3PXCGtPe6kVKYn0KbtZICUOGXoWSLdBlqNDm3vyQdxbqw/K
         deBZS0btst/3hFl527nELQ6MuDnNnzamVAZmiHtc7SyC8AMBalwLHJzMfGGvP6nWT7Nd
         nM23gD1BmiNfnzqzgk33eD5sZuMujADUk47gLrwnj9ZT4WumxNZdjxiwmzEDcQK9q9Gn
         EilJTe12Q+7hukQ9KD3oKPXXvGjiU2MatnEFx2MFNHmAWJ3JpOMa3eqBmLDfb/LunOKB
         EJVcjRxRqumZdaQK+Iy6TPQYLuF1zkujRyMgn8hsDFae5YzQ5sspenuyUxQRnumtHzoT
         31eQ==
X-Gm-Message-State: AOAM533o1Q/eYdSkkDsBg5KxJXPHnxOlw13L5Qa+Oo5qx6ekK6tCDXhB
        3sVmUedBfSVVFBjn8A30pF9GBeb9GiRHoKo+t0M=
X-Google-Smtp-Source: ABdhPJy9z6NwuKaiNSfvpobMPXTuPpkKfEZNR5Kq0stOH3fAM3tV0y71i7UBL9P1qwEcvOAIOsh3sA==
X-Received: by 2002:a05:6512:32ad:b0:448:3256:e40d with SMTP id q13-20020a05651232ad00b004483256e40dmr5792139lfe.6.1646763200380;
        Tue, 08 Mar 2022 10:13:20 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b00443143c4803sm3608084lfu.209.2022.03.08.10.13.18
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:13:19 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id h11so3875521ljb.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Mar 2022 10:13:18 -0800 (PST)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr3570290lji.291.1646763198615; Tue, 08
 Mar 2022 10:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr> <20220308141201.2343757-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20220308141201.2343757-1-mailhol.vincent@wanadoo.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 10:13:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvGWbpsTa538CvQ9e=VF+m8WPQmES2y6-=0=-64uGkgg@mail.gmail.com>
Message-ID: <CAHk-=whvGWbpsTa538CvQ9e=VF+m8WPQmES2y6-=0=-64uGkgg@mail.gmail.com>
Subject: Re: [PATCH v2] linux/bits.h: GENMASK_INPUT_CHECK: reduce W=2 noise by
 31% treewide
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 8, 2022 at 6:12 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> This patch silences a -Wtypes-limits warning in GENMASK_INPUT_CHECK()
> which is accountable for 31% of all warnings when compiling with W=2.

Please, just make the patch be "remote -Wtypes-limits".

Instead of making an already complicated check more complicated, and
making it more fragile.

I don't see why that int cast on h would be valid, for example. Why
just h? And should you not then check that the cast doesn't actually
change the value?

But the basic issue is that the compiler warns about bad things, and
the problem isn't the code, but the compiler.

                      Linus
