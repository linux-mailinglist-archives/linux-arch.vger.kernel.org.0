Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE6E608EF2
	for <lists+linux-arch@lfdr.de>; Sat, 22 Oct 2022 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJVSQz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Oct 2022 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJVSQy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 22 Oct 2022 14:16:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF08EA9EB
        for <linux-arch@vger.kernel.org>; Sat, 22 Oct 2022 11:16:52 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o2so3932088qkk.10
        for <linux-arch@vger.kernel.org>; Sat, 22 Oct 2022 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d0KCdG35QJgPzxY2PI5qF4wSDq+As804wur+n4mrk0=;
        b=Dlapqk7u3r5R+hK/Sg/KWPsYs7tfU6S9C02brY3SkmFAMIHHhptUQoMcR3/b7mTkYi
         MbJkeUIbDnrtnp02J3XF1lFi4YRuFRnn+UlALHdVhdPTVUv7JgEC44f9h8+dASuHGJac
         gfstM1uSAC+JNHVJYDEwl7uW6MEu4hiaC10EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8d0KCdG35QJgPzxY2PI5qF4wSDq+As804wur+n4mrk0=;
        b=i5U0IFKes12fqRq0oQL/8u2HmcfoAtIzlRYeCSsUTpZHbbPN/0OFT8QadMTnp4WsnL
         RU2XWWkTzVdW0TKf3YI0MAheIATA1iIb8QoJhEVANA7Uev5teR2sN9npupeVfGyyfo0+
         zzNSj2fZUN10l6LvP8JG2mBDA3FX7NqlQfV6QtpIu6QCb8RxQg0DeJD/OnNm1gyREcrl
         E1pujWX7fSQNpqCDQgCVI9Poa9ZcVtRkly18bDUykz8UAd7RgEOsxZFLRlNtBkSh5x3c
         xQkrwrOFDWfnWJF+CESR2pD0TfFGjz8FqP+neLcdxkLk7qchC12K0nPsEKlO/Kb7lt8p
         BiKw==
X-Gm-Message-State: ACrzQf2geg7wBGr9Dp2z0zvGaXxEWm9u7MgtIq9dEyzmUAV96W2RoBtj
        wSikYjaO8K4XSPGFuyNPXa+giTGVVpCEZw==
X-Google-Smtp-Source: AMsMyM6KyNLjV9XzC7iBqycrbZv/L6SdoeGAEVgentBnUcs3q7veFF3Et3WHwgRKIFAfaykCmM62sg==
X-Received: by 2002:a37:5401:0:b0:6df:aeea:89f0 with SMTP id i1-20020a375401000000b006dfaeea89f0mr17375050qkb.763.1666462611673;
        Sat, 22 Oct 2022 11:16:51 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id gd21-20020a05622a5c1500b00399ad646794sm10069774qtb.41.2022.10.22.11.16.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 11:16:49 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-369426664f9so51761747b3.12
        for <linux-arch@vger.kernel.org>; Sat, 22 Oct 2022 11:16:49 -0700 (PDT)
X-Received: by 2002:a81:11d0:0:b0:35b:dd9f:5358 with SMTP id
 199-20020a8111d0000000b0035bdd9f5358mr22201031ywr.401.1666462609310; Sat, 22
 Oct 2022 11:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <Y1Elx+e5VLCTfyXi@lt-gp.iram.es> <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
 <Y1OIXdh3vWOMUlQK@lt-gp.iram.es>
In-Reply-To: <Y1OIXdh3vWOMUlQK@lt-gp.iram.es>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Oct 2022 11:16:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaeTa9nAeJ8DP1cBWrs8fZvJ7k1-L8-kjxEOxpLf+XNA@mail.gmail.com>
Message-ID: <CAHk-=wgaeTa9nAeJ8DP1cBWrs8fZvJ7k1-L8-kjxEOxpLf+XNA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Gabriel Paubert <paubert@iram.es>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
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

On Fri, Oct 21, 2022 at 11:06 PM Gabriel Paubert <paubert@iram.es> wrote:
>
> Ok, I=C2=B4ve just tried it, except that I had something slightly differe=
nt in
> mind, but perhaps should have been clearer in my first post.
>
> I have change your code to the following:

I actually tested that, but using a slightly different version, and my
non-union test case ended up like

   size_t strlen(const char *p)
  {
        return __builtin_strlen(p);
  }

and then gcc actually complains about

    warning: infinite recursion detected

and I (incorrectly) thought this was unworkable. But your version
seems to work fine.

So yeah, for the kernel I think we could do something like this. It's
ugly, but it gets rid of the crazy warning.

Practically speaking this might be a bit painful, because we've got
several different variations of this all due to all the things like
our debugging versions (see <linux/fortify-string.h> for example), so
some of our code is this crazy jungle of "with this config, use this
wrapper".

But if somebody wants to deal with the '-Wpointer-sign' warnings,
there does seem to be a way out. Maybe with another set of helper
macros, creating those odd __transparent_union__ wrappers might even
end up reasonable.

It's not like we don't have crazy macros for function wrappers
elsewhere (the SYSCALL macros come to mind - shudder). The macros
themselves may be a nasty horror, but when done right the _use_ point
of said macros can be nice and clean.

                  Linus
