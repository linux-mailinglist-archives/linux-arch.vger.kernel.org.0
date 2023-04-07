Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFC6DB49D
	for <lists+linux-arch@lfdr.de>; Fri,  7 Apr 2023 21:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjDGT73 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Apr 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjDGT72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2023 15:59:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA088AD0A
        for <linux-arch@vger.kernel.org>; Fri,  7 Apr 2023 12:59:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g18so10586624ejx.7
        for <linux-arch@vger.kernel.org>; Fri, 07 Apr 2023 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680897563; x=1683489563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaUQBomv+m9YOS1+lTfr+NOwuLJy2GeX3csYQ/E4Tx8=;
        b=WY0PnRP5u/3kbSNQoSEZoLY0s1/2IbIfOo9zZpnHmHNYIgorJfVe4T+09VfZjKiJV4
         t+5K2+HFnTcl9WoId4lnBdKkOCz5hoL8yJeSS8d+/0v2ilqRU+7PvW77U+XmCmJaBwF+
         A+3/jnje0bq/Cj7RCwDktP4apxNSFJqvE1hnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897563; x=1683489563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaUQBomv+m9YOS1+lTfr+NOwuLJy2GeX3csYQ/E4Tx8=;
        b=cSCsxxeaRx2vzePSWa4/H70icmXip7hkJzWotWtznkfTEOF1IeRO3eKjO9EKTanWGR
         2/wsgSLagQCLUWdh3IM+5kUzDNcajVwMeftlw8VTRdI4moGs/YaJmuwhiw6pc1HAGkwf
         Got2XIcCpXIePsBK1XNMHUYV+76R4Xeth2EZmfsAkmdjrUxYrEJKjenSojDRNHY2j0Kw
         fO6Kn6/hdzUctogdTFnJobMMeBDJP6xHfcbXsHJA+kVMB0Q1jtaFxG7HwxM7gDJX7Hu8
         MQ3VHPS8b46kOt+/FnJiVHO3B2YjB1P++wo3T7Fprc0t6Bgfga9EIyQmaRJto9yMbhSF
         J2ZA==
X-Gm-Message-State: AAQBX9dgIzOwRm4TJksBOIOGFZG4xz+zEB/vY3jYWPDr7osax/rOSSwh
        /aSJYVaX7SJW4ixSVMW/PuC4SutpZ9BcjcZ0Abszqg==
X-Google-Smtp-Source: AKy350Zy554H9qgpRABtnGp2bDbub6f5R6J4DdKZZY8waEZGFBERRT/pHazgBidYCk/CpInV18e6Xw==
X-Received: by 2002:a17:907:10d3:b0:932:4cbf:5bbb with SMTP id rv19-20020a17090710d300b009324cbf5bbbmr540176ejb.19.1680897562999;
        Fri, 07 Apr 2023 12:59:22 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id k16-20020a17090646d000b0094863433fdcsm2369430ejs.51.2023.04.07.12.59.22
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:59:22 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id lj25so10567292ejb.11
        for <linux-arch@vger.kernel.org>; Fri, 07 Apr 2023 12:59:22 -0700 (PDT)
X-Received: by 2002:a17:906:380c:b0:931:2bcd:ee00 with SMTP id
 v12-20020a170906380c00b009312bcdee00mr246788ejc.15.1680897561831; Fri, 07 Apr
 2023 12:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <f44680f5-df08-4034-9ed7-6d43ee4c4c2a@app.fastmail.com>
 <CAHk-=wgyY_FKpWk1LAHirjmWbABc78C+mgVhqaYHZts0fbkYJQ@mail.gmail.com> <bc11f501-f020-4e90-9588-5d234e96159d@app.fastmail.com>
In-Reply-To: <bc11f501-f020-4e90-9588-5d234e96159d@app.fastmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Apr 2023 12:59:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik+Sh=cV9FHxPe1Rsb+=XGNFHU1wJZ7yqtcgwYLz5Xuw@mail.gmail.com>
Message-ID: <CAHk-=wik+Sh=cV9FHxPe1Rsb+=XGNFHU1wJZ7yqtcgwYLz5Xuw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic fixes for 6.3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Matt Evans <mev@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 6, 2023 at 1:03=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As far as I can tell, almost no users of
> {cmp,}xchg{,_local,_relaxed,acquire,release} that actually use
> 8-bit and 16-bit objects, and they are not even implemented on
> some architectures.

Yeah, I think we only have a driver or two that wants to do a 8/16-bit
cmpxchg, and many architectures don't support it at all natively (ie
it has to be implemented as a load-mask-store).

But iirc we *did* have a couple of uses, so..

> There is already a special case for the 64-bit xchg()/cmpxchg()
> variants that can get called on 32-bit architectures, so what
> I'd prefer is having each architecture implement only explicit
> fixed length cmpxchg8(), cmpxchg16(), cmpgxchg32() and optionally
> cmpxchg64() interfaces as normal inline functions that work on
> the respective integer types.

Hmm. Maybe. Except the reason we have those size-dependent macros is
that it is *really* really convenient - to the point of being very
important - when different architectures (or different kernel
configurations) end up causing the same logical thing to have
different sizes.

The whole "switch (sizeof(x))" model with complex macros is very ugly
and I'd much rather strive to implement something that is much more
geared to actual compiler issues where the compiler really explicitly
does select the right thign (rather than have the preprocessor expand
it to multiple things and then depending on the optimizer to do the
"selection").

But at the same time, aside from the macro ugliness, it really ends up
being *hugely* powerful as a concept, and avoiding a lot of
conditionals in the use cases.

Now, cmpxchg *may* be uncommon enough that the use cases are limited
enough that the "generic size" model wouldn't be worth it there, but I
was really thinking about the more generic cases.

Things like "get_user()" and "put_user()" would be *entirely* useless
without the automatic sizing.

How do I know? because we originally didn't have "get_user()". We had
"get_fs_byte()" and "get_fs_word()" etc. The "fs" part was due to the
original x86 implementation, so ignore the naming, but the issue with
"just use fixed types" really DOES NOT WORK when different
architectures have different types.

So switching over to "get_user()" that just automatically did the
right thing based on size instead of the size-specific ones really was
a huge deal. There's no way we could ever go back.

And while 'cmpxchg()' is the problem case here, I really think it
would be lovely if we had some nice *unified* way of handling these
"use size of access to determine variant" thing. Something like
_Generic, just based on size.

I guess __builtin_choose_expr() might be the right way to go there.

That's very much a "compiler statically picks one over the other"
interface. I despise the syntax, which is why it's not very commonly
used, but it might be what we should use.

Of course, another reason - other than syntax - for our "switch
(sizeof())" model is simply history. The kernel "get_user()"
interfaces go back to 1995 and Linux-1.3.0, and actually predates
__builtin_choose_expt() support in gcc by several years. Gcc only
started doing that in 2001 (gcc-3.4.5)

So we do have a few uses of __builtin_choose_expr() in the kernel, but
our really old interfaces simply didn't even have it available.

                 Linus
