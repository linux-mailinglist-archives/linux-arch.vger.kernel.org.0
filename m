Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D226050D5
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 21:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJSTys (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 15:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiJSTyg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 15:54:36 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DB9D6F
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:54:26 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-131dda37dddso22054284fac.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSG5J/Jp19bLIoPO0PSW05M1FrVD5Y1lwTSpwfUz75M=;
        b=ZrWRNl/i7xLO3nCLpj86TANKjfrJc9VYQdyddvCNNDWkZjgWsynXIGYYloHFmBLkKo
         ZR9Y3xyXyLHydBorVZbvJSJonq7xYGlgjFoDKaaU/SmxYWVFgc92FuQ5ds//JqPJOM9o
         JGfjyqN/Ol18NKSuEY7LLTfvzFHs7HKX9e1iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSG5J/Jp19bLIoPO0PSW05M1FrVD5Y1lwTSpwfUz75M=;
        b=SmQWdS1Y7uq8uLUfqJTlxMdXWZZdH36Wn5/GktCCnlKYfntfubeqny1s+SJY7VHzGp
         WbEBrgj4Yp947eayeaLcd1sQGJ6PJlH69OjW0//aOr1ZxKTcbamAxZYNYSbg2zF64oNO
         a10T+5AO41el8ZHTmrGXGg3+GiY0Doc66Sl87w6ivNJFksrfteVHKddUgeTinksQJs3h
         XvJiLfmNGX/cWjKcN4Tv8lE0sVkBHduveeWpAALaLMSRgvT4xA1/F7XjhNPlP/pFucf+
         gZ7i6escX/cabk3qumGnAARxrH1auAEkDiDj/hM8G5MXlnA1YErILE2nDir1WZWv1C6t
         6+PQ==
X-Gm-Message-State: ACrzQf29jOFnQ8JH9nh5HpClTRPgLUQukf983OiWFrvPkrePOlBQ96ND
        B6Wm44XwQuEyyWJQwbuQypWp5X8PWaqwlQ==
X-Google-Smtp-Source: AMsMyM7NJ2ojBlOH2DLFTc8asfHJGfsWRryX6dxfnJaBPKyXSdBw4ar5rtHee37zXbJed1YJEhERBw==
X-Received: by 2002:a05:6870:630f:b0:132:8af2:c8f2 with SMTP id s15-20020a056870630f00b001328af2c8f2mr23149048oao.284.1666209264927;
        Wed, 19 Oct 2022 12:54:24 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id z36-20020a056870d6a400b0012b298699dbsm8161274oap.1.2022.10.19.12.54.23
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 12:54:23 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso10135465oto.9
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 12:54:23 -0700 (PDT)
X-Received: by 2002:a05:6830:4408:b0:661:dfa1:f018 with SMTP id
 q8-20020a056830440800b00661dfa1f018mr4856482otv.69.1666209262824; Wed, 19 Oct
 2022 12:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com>
In-Reply-To: <20221019162648.3557490-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 12:54:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
Message-ID: <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 9:27 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> So let's just eliminate this particular variety of heisensigned bugs
> entirely. Set `-fsigned-char` globally, so that gcc makes the type
> signed on all architectures.

Btw, I do wonder if we might actually be better off doing this - but
doing it the other way around.

IOW, make 'char' always UNsigned. Unlike the signed char thing, it
shouldn't generate any worse code on any common architecture.

And I do think that having odd architecture differences is generally a
bad idea, and making the language rules stricter to avoid differences
is a good thing.

Now, you did '-fsigned-char', because that's the "common default" in
an x86-centric world.

You are also right that people might think that "char" works like
"int", and that if you don't specify the sign, it's signed.

But those people are obviously wrong anyway, so it's not a very strong argu=
ment.

And from a kernel perspective, I do think that "treat char as a byte"
and making it be unsigned is in many ways the saner model. There's a
reason we use 'unsigned char' in a fair number of places.

So using '-funsigned-char' might not be a bad idea.

Hilariously (and by "hilariously", I obviously mean "NOT
hilariously"), it doesn't actually fix the warning for

   const unsigned char *c =3D "p";

which still complains about

   warning: pointer targets in initialization of =E2=80=98const unsigned ch=
ar
*=E2=80=99 from =E2=80=98char *=E2=80=99 differ in signedness

even when you've specified that 'char' should be unsigned with -funsigned-c=
har.

Because gcc actually tries to be helpful, and has (reasonably, from a
"type sanity" standpoint) decided that

   "The type char is always a distinct type from each of signed char
or unsigned char, even though its behavior is always just like one of
those two"

so using "-funsigned-char" gives us well-defined *behavior*, but
doesn't really help us with cleaning up our code.

I understand why gcc would want to make it clear that despite any
behavioral issues, "char" is *not* the same as "[un]signed char" in
general. But in this kind of use case, that warning is just pointless
and annoying.

Oh well. You *really* can't win this thing. The game is rigged like
some geeky carnival game.

              Linus
