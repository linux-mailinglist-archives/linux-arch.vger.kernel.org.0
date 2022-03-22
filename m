Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7B4E4603
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 19:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiCVSbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbiCVSbK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 14:31:10 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08338BE18
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 11:29:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m3so19270600lfj.11
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 11:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s7fGS2THKosBu353nmhFTYnuK74oZhJix6ssyL7knBQ=;
        b=Q/ZAdDUNaeSeKURz7X4B2cBhM6bNXJWO2xu3e29wki3/WuCjnbZ82m1VywcC7gHSKD
         H9PkeROEneN6EmxZABVo727EtN9zLqdiAke3RVkes/bdmZ76eQ4mDBg23CtRHP7GBYTG
         20z98gmaXsaOS7HD7PH1Wzt9H+PEEaXY+7i5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s7fGS2THKosBu353nmhFTYnuK74oZhJix6ssyL7knBQ=;
        b=rslN7vUjwONjWpdqr8+ms1drkf2rrTgD3b5FtnChmsu/10EUuasVCN1SKNRjvqX+Cl
         TgkcEarpSBjxyjQNLEXAv8WD+F8YqBmCQXjKIL1hp7V349zEXE3i6yR14hhYodbEpWlX
         /XnDlNw6uI9sHb3lAo8YgxxYoH/dJ8e/kZOnLoLdjXUfJA2BcqH3ilEklb+NKmgfW6pQ
         iex66Z8wpTHRRCRldFJKzJHHWIwlVI3c91uRQV+oPV8MjzXqK49OSK3t66TnSyqn3Mrt
         icQO8APcipZjeTTG7TqfpISHTN2yl4Ugw5aB9AOmR3aMf0qcs2E/17RCiR3xzWby3Umr
         bYYA==
X-Gm-Message-State: AOAM531wbEFPfRILTIIs626wMG+MfqSDt9m4z/nlopoRxHv0rmRVxsbh
        O/cw29yY2jz7wcg19LZ1gF4KUAzvBsbgCrOtND8=
X-Google-Smtp-Source: ABdhPJwO1hyyLbkG8JFsJsSDQz1kMQYYhkbymcSC2AGaB3fKabH2ei3VNJq6LVj7bxHWr6GBWG7Ynw==
X-Received: by 2002:ac2:4adb:0:b0:44a:d01:e2a with SMTP id m27-20020ac24adb000000b0044a0d010e2amr14205234lfp.338.1647973780743;
        Tue, 22 Mar 2022 11:29:40 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fa6000000b0044313e88020sm2274477lfe.202.2022.03.22.11.29.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:29:38 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s25so25163480lji.5
        for <linux-arch@vger.kernel.org>; Tue, 22 Mar 2022 11:29:38 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr20248728lji.291.1647973777786; Tue, 22
 Mar 2022 11:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162848.303601-1-Jason@zx2c4.com> <20220322155820.GA1745955@roeck-us.net>
 <YjoC5kQMqyC/3L5Y@zx2c4.com> <d5c23f68-30ba-a5eb-6bea-501736e79c88@roeck-us.net>
 <YjoTJFRook+rGyDI@zx2c4.com>
In-Reply-To: <YjoTJFRook+rGyDI@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Mar 2022 11:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiq3bKDdt7noWOaMnDL-yYfFHb1CEsNkk8huq4O7ByetA@mail.gmail.com>
Message-ID: <CAHk-=wiq3bKDdt7noWOaMnDL-yYfFHb1CEsNkk8huq4O7ByetA@mail.gmail.com>
Subject: Re: [PATCH v1] random: block in /dev/urandom
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "David S . Miller" <davem@davemloft.net>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>,
        Borislav Petkov <bp@alien8.de>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Kinard <kumba@gentoo.org>,
        David Laight <David.Laight@aculab.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>
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

On Tue, Mar 22, 2022 at 11:19 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The first point is why we had to revert this patch. But the second one
> is actually a bit dangerous: you might write in a perfectly good seed to
> /dev/urandom, but what you read out for the subsequent seed may be
> complete deterministic crap. This is because the call to write_pool()
> goes right into the input pool and doesn't touch any of the "fast init"
> stuff, where we immediately mutate the crng key during early boot.

Christ, how I hate the crazy "no entropy means that we can't use it".

It's a disease, I tell you.

And it seems to be the direct cause of this misfeature.

By all means the code can say "I can't credit this as entropy", but
the fact that it then doesn't even mix it into the fast pool is just
wrong, wrong, wrong.

I think *that* is what we should fix. The fact is, urandom has
long-standing semantics as "don't block", and that it shouldn't care
about the (often completely insane) entropy crediting rules.

But that "don't care about entropy rules" should then also mean "oh,
we'll mix things in even if we don't credit entropy".

I hope that's the easy fix you are thinking about.

              Linus
