Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63495641D6
	for <lists+linux-arch@lfdr.de>; Sat,  2 Jul 2022 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiGBRXs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 2 Jul 2022 13:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiGBRXr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Jul 2022 13:23:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDF7E008
        for <linux-arch@vger.kernel.org>; Sat,  2 Jul 2022 10:23:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n15so6121448ljg.8
        for <linux-arch@vger.kernel.org>; Sat, 02 Jul 2022 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=il+ZyDBxn0EXlULxf75c3oKM6Oz9Nzs2kT9ulcG3ntg=;
        b=AvpeJ2y3obDMtoTmhFwHDaHq3gpaWuFkFb9SFOECVzvF7Ut7PQt4V7wdroBR0/cx5M
         SxIzCPADDmpAnDfJ7WM0KQFaDT5+R57nujC4MFCdgjYwnwVx93plj8J4wWckxLtNwStl
         HXFMwtmdOD06ghqq5vTm5wQM0VyefeNQxnfuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il+ZyDBxn0EXlULxf75c3oKM6Oz9Nzs2kT9ulcG3ntg=;
        b=odoIORdcDwI5SHSOwCGYvdxz+SQT591PVa4yMNfiIMAHUkYjVbPtKV6QpQlSeOTolU
         uVYiiWQHFOoiLoNOLwViYxXZsvFTszyRiq8eFrntMOVeYavyeoPa1tqFUYnnUOzNcWUY
         yBnNmucSfcQbMcEe0rl/Xm2XrYCVm8gYnI1FfE2YO9yQEp1EW+ua057kGn5Xnf7MAegG
         O/9oH1qzQjssdyCBJuCeGX6x2RYfxENsDrsjisviqVkwnhGwcypt4MIFBF2XjEagWND5
         aUJYhWb/YfamG+Z22nTMZnnq3zENgzFzYtZdy0GG0myMd3ZwtuHEbQYAZXblkOiEff/G
         dUkQ==
X-Gm-Message-State: AJIora/aDrNUyTza+7cbqN5EygLXScejTLb3ZpSfGUxwIPjTqSHxwWU6
        8OXKrHc8BfRarjW/sMsyTAUNGi3mmCqbaofw
X-Google-Smtp-Source: AGRyM1sBK7CVAnX9qcpBzBYoS2dkWl75xBYIUq/j+32gjZmROG//a++mYCZGvtTqFyU1FKsOUzwBmw==
X-Received: by 2002:a2e:a7d0:0:b0:25a:86ad:461b with SMTP id x16-20020a2ea7d0000000b0025a86ad461bmr12191576ljp.271.1656782624280;
        Sat, 02 Jul 2022 10:23:44 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x5-20020a056512078500b0047f77729723sm4217501lfr.43.2022.07.02.10.23.43
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jul 2022 10:23:44 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id t19so8205633lfl.5
        for <linux-arch@vger.kernel.org>; Sat, 02 Jul 2022 10:23:43 -0700 (PDT)
X-Received: by 2002:a5d:64e7:0:b0:21b:ad72:5401 with SMTP id
 g7-20020a5d64e7000000b0021bad725401mr18424110wri.442.1656782613069; Sat, 02
 Jul 2022 10:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220701142310.2188015-1-glider@google.com> <20220701142310.2188015-44-glider@google.com>
In-Reply-To: <20220701142310.2188015-44-glider@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Jul 2022 10:23:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
Message-ID: <CAHk-=wgbpot7nt966qvnSR25iea3ueO90RwC2DwHH=7ZyeZzvQ@mail.gmail.com>
Subject: Re: [PATCH v4 43/45] namei: initialize parameters passed to step_into()
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Vitaly Buka <vitalybuka@google.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
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

On Fri, Jul 1, 2022 at 7:25 AM Alexander Potapenko <glider@google.com> wrote:
>
> Under certain circumstances initialization of `unsigned seq` and
> `struct inode *inode` passed into step_into() may be skipped.
> In particular, if the call to lookup_fast() in walk_component()
> returns NULL, and lookup_slow() returns a valid dentry, then the
> `seq` and `inode` will remain uninitialized until the call to
> step_into() (see [1] for more info).

So while I think this needs to be fixed, I think I'd really prefer to
make the initialization and/or usage rules stricter or at least
clearer.

For example, looking around, I think "handle_dotdot()" has the exact
same kind of issue, where follow_dotdot[_rcu|() doesn't initialize
seq/inode for certain cases, and it's *really* hard to see exactly
what the rules are.

It turns out that the rules are that seq/inode only get initialized if
these routines return a non-NULL and non-error result.

Now, that is true for all of these cases - both follow_dotdot*() and
lookup_fast(). Possibly others.

But the reason follow_dotdot*() doesn't cause the same issue is that
the caller actually does the checks that avoid it, and doesn't pass
down the uninitialized cases.

Now, the other part of the rule is that they only get _used_ for
LOOKUP_RCU cases, where they are used to validate the lookup after
we've finalized things.

Of course, sometimes the "only get used for LOOKUP_RCU" is very very
unclear, because even without being an RCU lookup, step_into() will
save it into nd->inode/seq. So the values were "used", and
initializing them makes them valid, but then *that* copy must not then
be used unless RCU was set.

Also, sometimes the LOOKUP_RCU check is in the caller, and has
actually been cleared, so by the time the actual use comes around, you
just have to trust that it was a RCU lookup (ie
legitimize_links/root()).

So it all seems to work, and this patch then gets rid of one
particular odd case, but I think this patch basically hides the
compiler warning without really clarifying the code or the rules.

Anyway, what I'm building up to here is that I think we should
*document* this a bit more. and then make those initializations then
be about that documentation. I also get the feeling that
"nd->inode/nd->seq" should also be initialized.

Right now we have those quite subtle rules about "set vs use", and
while a lot of the uses are conditional on LOOKUP_RCU, that makes the
code correct, but doesn't solve the "pass uninitialized values as
arguments" case.

I also think it's very unclear when nd->inode/nd->seq are initialized,
and the compiler warning only caught the case where they were *set*
(but by arguments that weren't initialized), but didn't necessarily
catch the case where they weren't set at all in the first place and
then passed around.

End result:

 - I think I'd like path_init() (or set_nameidata) to actually
initialize nd->inode and nd->seq unconditionally too.

   Right now, they get initialized only for that LOOKUP_RCU case.
Pretty much exactly the same issue as the one this patch tries to
solve, except the compiler didn't notice because it's all indirect
through those structure fields and it just didn't track far enough.

 - I suspect it would be good to initialize them to actual invalid
values (rather than NULL/0 - particularly the sequence number)

 - I look at that follow_dotdot*() caller case, and think "that looks
very similar to the lookup_fast() case, but then we have *very*
different initialization rules".

Al - can you please take a quick look?

                    Linus
