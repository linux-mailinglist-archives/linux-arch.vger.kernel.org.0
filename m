Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51E604F85
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 20:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiJSSVW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 14:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJSSVV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 14:21:21 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9611017D875
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:21:20 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y72so20217078oia.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h1RcL8BPrrn0ZTMAZgdWymleKVlN0GVlF2LLrZfELFo=;
        b=FfoVpW9MKQr/IY4n02JjJbEh3PPjuWKUkQNWyKfLWg6Mm7D6GF2jkSWT1a9oPRh51Z
         Wed2BjOT3ZUQKsXj6kOMo3sIAm9dEPTKrK7GqcT+1L5v8L+fwtRrC88unTMpHnWJr/A0
         DnTjnpp1obnUbdnNcA9UZjol2Nd6zKbe/fonWgv2E+xgM04QeT1tJZ760kicMekHqMmb
         rIpR3bgauPdOGF0rTXy41v7v/lzaGeAW9IZEBvCWUEXz9lnO9btJxS86bnUC8SnsOpN2
         7ceVlVMdz+wWOpYdiMGQCP/9n/x2hDAvyySpHDfywp0l3kJyDVYQu3ziOkro9NBFiK2W
         o3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1RcL8BPrrn0ZTMAZgdWymleKVlN0GVlF2LLrZfELFo=;
        b=fLU528TSEM1MiOdI6hmRj316vfPTzbLSV4hxsNFH3wBaK49mPIM5ccFm50xI2ouB+P
         9BTL3LmZzyQN2N6KIPt+EglabglX5gG4Fw6tAdfcNjQJp6nOTDAvn26HS23zHnAo5BQC
         6iZ+kaUXILdYcwlgFtwpAe6ZP06xk+zKqc7ggYhx88n7wzPaknUS0jVFKO62yzWJdF9K
         N2kZQTua/VhtV1r/oQdLF9AOVzY1qU94baFN9BcfcJGIUlvljCKG7bRtken2sT7bDnWK
         ozH3SZT0hsjLpGErPRyIF0fwQxdLRBpouhYlfStqhhPdMw6GqsvimAlUdBTpo13s5Tpn
         DWHA==
X-Gm-Message-State: ACrzQf2YhxHeNFXv46CKxTWc+NT8hVO8wuqPOPrZZzcBUh/eAabia4tS
        NJRhS3NjAltKGvEAgmVazv4XhJopqfsExAbljh3ayZvuzFI=
X-Google-Smtp-Source: AMsMyM4bao8KvMe6WMKZX/dIyc/1ffRx5FeiX3pdYV7oLVE9G7Aj8q9Nqbaj7wFgzoffi2e5BwnpIBcmPSgr2GmCzn8=
X-Received: by 2002:a17:90b:3a88:b0:209:f35d:ad53 with SMTP id
 om8-20020a17090b3a8800b00209f35dad53mr46571979pjb.102.1666203669615; Wed, 19
 Oct 2022 11:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
In-Reply-To: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Oct 2022 11:20:58 -0700
Message-ID: <CAKwvOdn4iocWHY_-sXMqE7F1XrV669QsyQDzh7vPFg6+7368Cg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 11:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But while sparse does a lot of basic optimizations, it still left
> enough "look, you're doing sign-extensions on a 'char'" on the table
> that it warned about perfectly valid stuff.
>
> And maybe that's fundamentally hard.
>
> The "-Wpointer-sign" thing could probably be fairly easily improved,
> by just recognizing that things like 'strlen()' and friends do not
> care about the sign of 'char', and neither does a 'strcmp()' that only
> checks for equality (but if you check the *sign* of strcmp, it does
> matter).
>
> It's been some time since I last tried it, but at least from memory,
> it really was mostly the standard C string functions that caused
> almost all problems.  Your *own* functions you can just make sure the
> signedness is right, but it's really really annoying when you try to
> be careful about the byte signs, and the compiler starts complaining
> just because you want to use the bog-standard 'strlen()' function.
>
> And no, something like 'ustrlen()' with a hidden cast is just noise
> for a warning that really shouldn't exist.
>
> So some way to say 'this function really doesn't care about the sign
> of this pointer' (and having the compiler know that for the string
> functions it already knows about anyway) would probably make almost
> all problems with -Wsign-warning go away.
>
> Put another way: 'char *' is so fundamental and inherent in C, that
> you can't just warn when people use it in contexts where sign really
> doesn't matter.

A few times in the past, we've split a warning flag into a group so
that we could be more specific about distinct cases. Perhaps if
-Wpointer-sign was a group that implied -Wpointer-char-sign, then the
kernel could use -Wpointer-sign -Wno-pointer-char-sign.

I don't know if that's the right granularity though.
-- 
Thanks,
~Nick Desaulniers
