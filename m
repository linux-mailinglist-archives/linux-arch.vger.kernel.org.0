Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4E60F1AD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 09:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ0H7V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 03:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbiJ0H7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 03:59:11 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381416CA7E
        for <linux-arch@vger.kernel.org>; Thu, 27 Oct 2022 00:59:09 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id bs14so1159455ljb.9
        for <linux-arch@vger.kernel.org>; Thu, 27 Oct 2022 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUr2EXQ4ftgpTV8ZEQ41jHHOycsGjgaOj2fkUN/SmwY=;
        b=RjUFbbMfNxCxFcmIKsdWa5O9byrd1jpSQlJe5eU3whNU+B6yepvb7B0D9b8+Jm2SvU
         K2AC1/Qphb//OHOael7l/Nmty1KTOoEHMsSJtADAHM3UvBWii75uGpQUvhid/+irjrGQ
         BxwH1/loV9BB3luEH+etQBpjeAC8ZqCizyO/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wUr2EXQ4ftgpTV8ZEQ41jHHOycsGjgaOj2fkUN/SmwY=;
        b=AtozwFpUiF9nWZ4nt17BIsZEtdSl2bkFjDfe7HkmR00U6Xtkd5HrLeew6vzn74++7I
         BJJ1V8KEXcbXy5L6mHFUcNxHailBeVJYP45ttqfoeYwwjlhqXjUPwmP0JeZm3O3AdmMk
         x7Jez2DpazSaX9GaI965FrBqRMrUFpDMIx3EInNSPd35S1Q6gYnHBmfNYv63Bi011EYZ
         hVSxNYc0AqGVs3ew6pa6DcOAQxg3hS/wX3qaxz9bw9zW0vpCH8J/VrEWqNuH/Ki1ZFad
         OeDdWXGKZTrhuVuicvUrzI1EZEjWaQAuOTMD2j3cX/BP9Twt+ba0n08EXCxVi4AUrf3x
         2ojQ==
X-Gm-Message-State: ACrzQf1nanWYIQCxLKZbNIma0yFKMquiiOVRFQGLdgr2wckxSDBBMnrp
        brAG0FqwifewDeW+n7Url6YyJl2a+qClr0o3sGU=
X-Google-Smtp-Source: AMsMyM6JfSRaduVbrfa57dcCJjTzQ7W0+QDnmLqDB+SkcXec0y+BqsXViensSxRqxUz8HX+M/nNvgg==
X-Received: by 2002:a2e:9e47:0:b0:276:1ee8:7216 with SMTP id g7-20020a2e9e47000000b002761ee87216mr11763411ljk.339.1666857547760;
        Thu, 27 Oct 2022 00:59:07 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t27-20020a2e8e7b000000b0027709875c3esm130842ljk.32.2022.10.27.00.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 00:59:07 -0700 (PDT)
Message-ID: <915a104b-0e70-dfb8-3c85-54fd1e5e63e5@rasmusvillemoes.dk>
Date:   Thu, 27 Oct 2022 09:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: make ctype ascii only? (was [PATCH] kbuild: treat char as always
 signed)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <CAHk-=whT+xyge9UjH+r6dt0FG-eUdrzu5hDMce_vC+n8uLam2A@mail.gmail.com>
 <3a2fa7c1-2e31-0479-761f-9c189f8ed8c3@rasmusvillemoes.dk>
 <CAHk-=wg9RNhvDyanUQnxa_xnir70TUiMgjhVhRWUuF5Ojj96Dw@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=wg9RNhvDyanUQnxa_xnir70TUiMgjhVhRWUuF5Ojj96Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26/10/2022 20.10, Linus Torvalds wrote:
> On Tue, Oct 25, 2022 at 5:10 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> Only very tangentially related (because it has to do with chars...): Can
>> we switch our ctype to be ASCII only, just as it was back in the good'ol
>> mid 90s
> 
> Those US-ASCII days weren't really very "good" old days, but I forget
> why we did this (it's attributed to me, but that's from the
> pre-BK/pre-git days before we actually tracked things all that well,
> so..)
> 
> Anyway, I think anybody using ctype.h on 8-bit chars gets what they
> deserve, and I think Latin1 (or something close to it) is better than
> US-ASCII, in that it's at least the same as Unicode in the low 8
> chars.

My concern is that it's currently somewhat ill specified what our ctype
actually represents, and that would be a lot easier to specify if we
just said ASCII, everything above 0x7f is neither punct or ctrl or alpha
or anything else.

For example, people may do stuff like isprint(c) ? c : '.' in a printk()
call, but most likely the consumer (somebody doing dmesg) would, at
least these days, use utf-8, so that just results in a broken utf-8
sequence. Now I see that a lot of callers actually do "isascii(c) &&
isprint(c)", so they already know about this, but there are also many
instances where isprint() is used by itself.

There's also stuff like fs/afs/cell.c and other places that use
isprint/isalnum/... to make decisions on what is allowed on the wire
and/or in a disk format, where it's then hard to reason about just
exactly what is accepted. And places that use toupper() on their strings
to normalize them; that's broken when toupper() isn't idempotent.

> So no, I'm disinclined to go back in time to what I think is an even
> worse situation. Latin1 isn't great, but it sure beats US-ASCII. And
> if you really want just US-ASII, then don't use the high bit, and make
> your disgusting 7-bit code be *explicitly* 7-bit.
> 
> Now, if there are errors in that table wrt Latin1 / "first 256
> codepoints of Unicode" too, then we can fix those.

AFAICT, the differences are:

- 0xaa (FEMININE ORDINAL INDICATOR), 0xb5 (MICRO SIGN), 0xba (FEMININE
ORDINAL INDICATOR) should be lower (hence alpha and alnum), not punct.

- depending a little on just exactly what one wants latin1 to mean, but
if it does mean "first 256 codepoints of Unicode", 0x80-0x9f should be cntrl

- for some reason at least glibc seems to classify 0xa0 as punctuation
and not space (hence also as isgraph)

- 0xdf and 0xff are correctly classified as lower, but since they don't
have upper-case versions (at least not any that are representable in
latin1), correct toupper() behaviour is to return them unchanged, but we
just subtract 0x20, so 0xff becomes 0xdf which isn't isupper() and 0xdf
becomes something that isn't even isalpha().

Fixing the first would create more instances of the last, and I think
the only sane way to fix that would be a 256 byte lookup table to use by
toupper().

> Not that anybody has apparently cared since 2.0.1 was released back in
> July of 1996 
(btw, it's sad how none of the old linux git archive
> creations seem to have tried to import the dates, so you have to look
> those up separately)

Huh? That commit has 1996 as the author date, while its commit date is
indeed 2007. The very first line says:

author	linus1 <torvalds@linuxfoundation.org>	1996-07-02 11:00:00 -0600

> And if nobody has cared since 1996, I don't really think it matters.

Indeed, I don't think it's a huge problem in practice. But it still
bothers me that such a simple (and usually overlooked) corner of the
kernel's C library is ill-defined and arguably a little buggy.

Rasmus
