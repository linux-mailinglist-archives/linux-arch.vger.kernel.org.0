Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990046081CB
	for <lists+linux-arch@lfdr.de>; Sat, 22 Oct 2022 00:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiJUWqX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Oct 2022 18:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJUWqW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Oct 2022 18:46:22 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA19227D4FB
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2022 15:46:20 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id f14so2822897qvo.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2022 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTbq7uclSMTVXXA1OMDUajwXRPp0OSsgp8g8w/Yycn8=;
        b=e7LtUG6Rz/h1Bucum6a4llHSoi6ASZ8bgy8v/vr7NdZLi3DSRtYydxrnqTEJEtEgXd
         bBbS+hLNA+ziEHxwHgdxadKOIU2Y+1wgBPy7kVCD6Or1u4lqXtPQhCrnhki0y5ScjqQA
         o7T4qbScBo0bkx5lHwh/Y4G8hWq1T588grEBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTbq7uclSMTVXXA1OMDUajwXRPp0OSsgp8g8w/Yycn8=;
        b=JCQ5te1CdYzdG+YoIW7F7qe+Dj/ju+TkapMHWokNaIql6Q+KECrBJ2meuzIJffyq/b
         rn5yalQ4NxhwTdUY/uksNrNHOATVyS/mxOkbzUXKRePMfScZ8NG6n5il5sxjY1cVle1K
         nxYGB2wsTNCMYvW7lfJu6vtSLUPEHvpJhju0tIKh2vPq4i0E1r8ck7MEluPffUIpU/rn
         KnCHryWb0EWN8hrK+RfYtB0Z+pm5lNDTov7iakSvAjmEOtb85+SDE507s+2eSX5JbdpC
         85JJ1zsPRv13FER4wGsKsC15AYoeaIzGxGZ5IDxsQMEKAw60Ykodmc8EhNLVlyqQjGWh
         yKXg==
X-Gm-Message-State: ACrzQf1GBgxDnhffYDuePTC9CD5A74aRxkmivgdVWPT13EIwq69BFEKh
        szTMuFsMD3y7+mE/lt4DxpSMe4HPrqjglw==
X-Google-Smtp-Source: AMsMyM50PfTYaGYiqiOl6ncYoOu/M8JTegD4mNbosLrQDks/Sw9uyKqfGDFYVmnwqZXE8Cljwj0dzQ==
X-Received: by 2002:a0c:9a4c:0:b0:4b1:d3ef:85cc with SMTP id q12-20020a0c9a4c000000b004b1d3ef85ccmr18513479qvd.105.1666392379676;
        Fri, 21 Oct 2022 15:46:19 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a414b00b006e99290e83fsm10646755qko.107.2022.10.21.15.46.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 15:46:17 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y72so4874147yby.13
        for <linux-arch@vger.kernel.org>; Fri, 21 Oct 2022 15:46:17 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr18369474ybk.501.1666392377403; Fri, 21
 Oct 2022 15:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <20221019174345.GM25951@gate.crashing.org> <CAHk-=wiNNKLFfa0d+Hk=Wm5caiKjLY4V9wwu9DhcSSwPuMbxrg@mail.gmail.com>
 <Y1Elx+e5VLCTfyXi@lt-gp.iram.es>
In-Reply-To: <Y1Elx+e5VLCTfyXi@lt-gp.iram.es>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 15:46:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
Message-ID: <CAHk-=wiYtSvjyz5xz2Sbnmxgzg_=AL2OyTiRueUem3xzCzM8VA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 20, 2022 at 3:41 AM Gabriel Paubert <paubert@iram.es> wrote:
>
> I must miss something, the strcmp man page says:
>
> "The comparison is done using unsigned characters."

You're not missing anything, I just hadn't looked at strcmp() in forever.

Yeah, strcmp clearly doesn't care about the signedness of 'char', and
arguably an unsigned char argument makes more sense considering the
semantics of the funmction.

> But it's not for this that I wrote this message. Has anybody considered
> using transparent unions?

I don't love the transparent union-as-argument syntax, but you're
right, that would fix the warning.

Except it then doesn't actually *work* very well.

Try this:

        #include <sys/types.h>

        #if USE_UNION
        typedef union {
                const char *a;
                const signed char *b;
                const unsigned char *c;
        } conststring_arg __attribute__ ((__transparent_union__));
        size_t strlen(conststring_arg);
        #else
        size_t strlen(const char *);
        #endif

        int test(char *a, unsigned char *b)
        {
                return strlen(a)+strlen(b);
        }

        int test2(void)
        {
                return strlen("hello");
        }

and now compile it both ways with

        gcc -DUSE_UNION -Wall -O2 -S t.c
        gcc -Wall -O2 -S t.c

and notice how yes, the "-DUSE_UNION" one silences the warning about
using 'unsigned char *' for strlen. So it seems to work fine.

But then look at the code it generates for 'test2()" in the two cases.

The transparent union version actually generates a function call to an
external 'strlen()' function.

The regular version uses the compiler builtin, and just compiles
test2() to return the constant value 5.

So playing games with anonymous union arguments ends up also disabling
all the compiler optimizations we do want, becaue apparently gcc then
decides "ok, I'm not going to warn about you declaring this
differently, but I'm also not going to use the regular one because you
declared it differently".

This, btw, is also the reason why we don't use --freestanding in the
kernel. We do want the basic <string.h> things to just DTRT.

For the sockaddr_in games, the above isn't an issue. For strlen() and
friends, it very much is.

                       Linus
