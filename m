Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCF604FC3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Oct 2022 20:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJSSgr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiJSSgq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 14:36:46 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671A6182C7B
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:36:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id j8so592609qvo.6
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Hic1oazVXE3zC6bxc7l73SbPyyOlgvu3WnXoJo8Sr0=;
        b=V01kWhoyFvXQa88Ht6WMjphqL1lN6byPpIbIDK3W41MOcgbJDpKD3vxULheyUZmTEp
         NCBfyrQsWYEt4tLS+X7KE/eUBywCcBY3ZYljTQ1vY5HfXulKEcutsetsAU7Ix8M39MTK
         fCzZzPaGLPvKqaL5Po7CO+2Wzkt5AlEOjbhmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Hic1oazVXE3zC6bxc7l73SbPyyOlgvu3WnXoJo8Sr0=;
        b=kXbKIV80WKxnxHzpfs1kapr7FOdwNlEy7K5zWsJQvv/IqPSMsg0Vtnz7upyQezwSF1
         AzuPPn6ybzODaKmbZxVmW6+Eg76WLpH5Flt2MpEuXuVcOhQ65HNckn7vQ4ABBTiPZYV6
         AyzOFX2p3zAAfe/OtwW1wDr6CQHusFCb888FhBbr3h6OJ8GaR2D9PK4e5ue5+DL/qDfP
         +CN/U3l3rzbMDrZmEOJY7qhumkIf9UgFDK2oySZTVTrwwRRrjlAfy7igB8s1wnyK4ON8
         UA66GBMsKpIfKxyqvm3QWOYjvx4nW82QVp5FTXbRZypZLPW6dzkroEHR1R5qXLpuwCAH
         IavQ==
X-Gm-Message-State: ACrzQf2VQ/+62Mm3UqUhgbs0I1TXLJjvMKEZ+6+wibIY+9jYXD3ifLIR
        O0XvQaNVwUqdDJJxdBztKSQ2xtfi/bV1oA==
X-Google-Smtp-Source: AMsMyM7n86QzoiKSfYR3feIexZQ9AvpE/RSXQ5S5vyO74ZzSIfrDfL1ypsguJuoRFuG5/VR8iz95Zw==
X-Received: by 2002:ad4:574d:0:b0:4b1:d10d:cdb5 with SMTP id q13-20020ad4574d000000b004b1d10dcdb5mr7962735qvx.23.1666204570110;
        Wed, 19 Oct 2022 11:36:10 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id h3-20020a05620a13e300b006ea7f9d8644sm5192407qkl.96.2022.10.19.11.36.07
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 11:36:07 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso176692137b3.5
        for <linux-arch@vger.kernel.org>; Wed, 19 Oct 2022 11:36:07 -0700 (PDT)
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr7629450ywl.67.1666204566848; Wed, 19
 Oct 2022 11:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221019162648.3557490-1-Jason@zx2c4.com> <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com> <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
In-Reply-To: <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 11:35:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com>
Message-ID: <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: treat char as always signed
To:     Nick Desaulniers <ndesaulniers@google.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 11:10 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Oct 19, 2022 at 10:26 AM Linus Torvalds
> >
> > Side note: several years ago I tried to make up some sane rules to
> > have 'sparse' actually be able to warn when a 'char' was used in a
> > context where the sign mattered.
>
> Do you have examples? Maybe we could turn this into a compiler feature
> request.  Having prior art on the problem would be a boon.

It's been over a decade since I seriously worked on sparse (Hmm.
Probably two, actually).  And I never got the 'char' logic to work
well enough for it to have ever made it into the kernel.

I'm also fairly sure I did it wrong - if I recall correctly, I did it
on the type system level, and the logic was in the tree
simplification, which was always much too weak.

Sparse does *some* expression simplification as it builds up the parse
tree and does all the type evaluations ("evaludate.c" in sparse), but
most of the real optimization work is done on the SSA format.

So what I probably *should* have done was to have a special "BEXT"
opcode (for "byte extend", the same way sparse has ZEXT and SEXT for
well-defined integer zero extend and sign extend), and linearized it
with all the simplifications that we do on the SSA level, and then if
the BEXT opcode still exists after all our optimization work, we'd
warn about it, because that means that the signedness ends up
mattering.

But sparse originally did almost everything just based on the type
system, which was the original intent of sparse (ie the whole "extend
the pointer types to have different address spaces" was really what
sparse was all about).

> Clang's -Wbitfield-constant-conversion can catch that.

Yeah, so bitfield signedness is really trivial, and works all on the
type system.

It's very easy to say: "you defined this member as an implicitly
signed bitfield, did you *really* mean to do that?" because signed
bitfields simply do not exists in the kernel.

So that warning is trivial, and the fix is basically universally
change 'int a:1' to 'unsigned a:1', because even *if* you do want
signed bitfields, it's just better to make that very very explicit,
and write it as 'signed int x:10'.

We do have a couple of signed bitfields in the kernel, but they are
unusual enough that it's actually a good thing that sparse just made
people be explicit about it.

Do

        git grep '\<signed\>.*:[1-9]'

to see the (few) examples and a few false positives that trigger in
the trace docs.

So sparse doesn't actually have to be clever about bitfield signs. It
can literally just say "did you really mean to do that", and that's
it. Very simple. Not at all the complexity that 'char' has, where
every single use technically tends to cause a sign-extension (due to
the integer conversion), but that doesn't mean that it *matters* in
the end.

            Linus
