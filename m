Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DCA604F60
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiJSSLt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 14:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiJSSLs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 14:11:48 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E9D1C5A41
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:11:46 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f8so11267123qkg.3
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oUCCyUWxse3Ihxvp+Qy73UCcxKzJGUZipUhThJxcdKU=;
        b=WuiA/6yKGF2cchs6SyRubR0sUiAOrR7hnAR9NdZ2x0xwinAtix2ztOnRoTlNt1SXaI
         roMCjEKH9M6eg3c9U2UbtL3mBN4LsaBH4jFFCPzxkXbbkYzXm6jYktZtwMV7kprSpq30
         K1C/H0DmKvpgKPvqRJv3DcVzYXeY9oOLsD3Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUCCyUWxse3Ihxvp+Qy73UCcxKzJGUZipUhThJxcdKU=;
        b=Y54rBSG9j0UQtqfOEJhBopD49o4TvYm+qgk35bDwBOB9hd6czac+cBU/GW/s3+yNjg
         LYHT2B8tqbpy5qCozKQ7s/8wHvCVhF9yK2y12CSSlowlK1np+kCiAE/ee8BURbEM6iod
         T8s8GTCSLJrIkZjwXSLiIZXnAKJw5A8P1OMau7QKcMlUEm6RpWHK0d7XYNj4jW9lyc0s
         oti1XdPmXAQDz/yV/Tow6b3VsMSZTeirzMSPb6PdKAGaDwLuyJvT0oOekwT29c74f7nf
         7DrTB6y/Lci+Jy4BwRemnzgCOBQYt9wySbQHYPhrxD5JP8HvaMnG9Q4JX3au57ehjmmT
         wpxg==
X-Gm-Message-State: ACrzQf2I0Um7RP+aTvpFHmDZ3atRZjrpwtHIUmtVGww1SNioD6HNc+tv
        ojAMbTOqBFFHOKSK15K18u3S8eTVb8//2A==
X-Google-Smtp-Source: AMsMyM5nimsj6pXSr2b0Z136MSzkUcYwx+3n+V4vK0Gd7N6uWK36vVtqTj/04wG6p+YE5sFJwssIxA==
X-Received: by 2002:a05:622a:44f:b0:39c:dcf5:3eeb with SMTP id o15-20020a05622a044f00b0039cdcf53eebmr7505037qtx.675.1666203094549;
        Wed, 19 Oct 2022 11:11:34 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bz12-20020a05622a1e8c00b0039a1146e0e1sm4513030qtb.33.2022.10.19.11.11.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 11:11:34 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3608b5e634aso176007457b3.6
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:11:33 -0700 (PDT)
X-Received: by 2002:a81:1007:0:b0:357:45e3:304c with SMTP id
 7-20020a811007000000b0035745e3304cmr7943725ywq.340.1666203093522; Wed, 19 Oct
 2022 11:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com> <20221019174345.GM25951@gate.crashing.org>
In-Reply-To: <20221019174345.GM25951@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 11:11:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
Message-ID: <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 10:45 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> When I did this more than a decade ago there indeed was a LOT of noise,
> mostly caused by dubious code.

It really happens with explicitly *not* dubious code.

Using 'unsigned char[]' is very common in code that actually does
anything where you care about the actual byte values. Things like
utf-8 handling, things like compression, lots and lots of cases.

But a number of those cases are still dealing with *strings*. UTF-8 is
still a perfectly valid C string format, and using 'strlen()' on a
buffer that contains UTF-8 is neither unusual nor wrong. It is still
the proper way to get the byte length of the thing. It's how UTF-8 is
literally designed.

And -Wpointer-sign will complain about that, unless you start doing
explicit casting, which is just a worse fix than the disease.

Explicit casts are bad (unless, of course, you are explicitly trying
to violate the type system, when they are both required, and a great
way to say "look, I'm doing something dangerous").

So people who say "just cast it", don't understand that casts *should*
be seen as "this code is doing something special, tread carefully". If
you just randomly add casts to shut up a warning, the casts become
normalized and don't raise the kind of warning signs that they
*should* raise.

And it's really annoying, because the code ends up using 'unsigned
char' exactly _because_ it's trying to be careful and explicit about
signs, and then the warning makes that carefully written code worse.

> Then suggest something better?  Or suggest improvements to the existing
> warning?

As I mentioned in the next email, I tried to come up with something
better in sparse, which wasn't based on the pointer type comparison,
but on the actual 'char' itself.

My (admittedly only ever half-implemented) thing actually worked fine
for the simple cases (where simplification would end up just undoing
all the "expand char to int" because the end use was just assigned to
another char, or it was masked for other reasons).

But while sparse does a lot of basic optimizations, it still left
enough "look, you're doing sign-extensions on a 'char'" on the table
that it warned about perfectly valid stuff.

And maybe that's fundamentally hard.

The "-Wpointer-sign" thing could probably be fairly easily improved,
by just recognizing that things like 'strlen()' and friends do not
care about the sign of 'char', and neither does a 'strcmp()' that only
checks for equality (but if you check the *sign* of strcmp, it does
matter).

It's been some time since I last tried it, but at least from memory,
it really was mostly the standard C string functions that caused
almost all problems.  Your *own* functions you can just make sure the
signedness is right, but it's really really annoying when you try to
be careful about the byte signs, and the compiler starts complaining
just because you want to use the bog-standard 'strlen()' function.

And no, something like 'ustrlen()' with a hidden cast is just noise
for a warning that really shouldn't exist.

So some way to say 'this function really doesn't care about the sign
of this pointer' (and having the compiler know that for the string
functions it already knows about anyway) would probably make almost
all problems with -Wsign-warning go away.

Put another way: 'char *' is so fundamental and inherent in C, that
you can't just warn when people use it in contexts where sign really
doesn't matter.

                 Linus
