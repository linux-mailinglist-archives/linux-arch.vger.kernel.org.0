Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3093C493EF2
	for <lists+linux-arch@lfdr.de>; Wed, 19 Jan 2022 18:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356365AbiASRVC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Jan 2022 12:21:02 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:43289 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356355AbiASRVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jan 2022 12:21:00 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N5VPe-1mDVEe23Ss-016tVz; Wed, 19 Jan 2022 18:20:58 +0100
Received: by mail-wm1-f43.google.com with SMTP id c66so6467944wma.5;
        Wed, 19 Jan 2022 09:20:58 -0800 (PST)
X-Gm-Message-State: AOAM530ExIW1CdWL3zLljqpQX/t/ALN9co1FfWvKHpBg21QjWhm/iFMt
        s23CBId5kTKj54Q+O8hwXZoYTNJ/Q0FrJB2iL0k=
X-Google-Smtp-Source: ABdhPJw8DlyT7pKhsJLWmueJ95RIFxvoT7HEoBLWXH1En39mN2I9a5at/6YQLxRx6DsDTBeawvhqxIHGFWkfKKALPzw=
X-Received: by 2002:adf:e193:: with SMTP id az19mr23380958wrb.407.1642612857910;
 Wed, 19 Jan 2022 09:20:57 -0800 (PST)
MIME-Version: 1.0
References: <Ydm7ReZWQPrbIugn@gmail.com> <CAK8P3a1emGYHPcjTfLqd-yyU8_9w88=2g_B_vfhbKeDtDHMM-w@mail.gmail.com>
 <CAK8P3a3SpYe101RSFD5rzbTQNyQyfG1eb1sCY+rBO-DKVqBdBw@mail.gmail.com>
 <Yd/idffvv8QIQcEU@gmail.com> <CAK8P3a3FahVogb3wfbXSaCpnUsRBGmO9M56M+Cay=skc9rUzjw@mail.gmail.com>
 <YegErRbP+cT42oOC@gmail.com>
In-Reply-To: <YegErRbP+cT42oOC@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 Jan 2022 18:20:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2XPwG7rP+TFdEYH7tutE7Zat5vf7PuV2idESZsrxBXyA@mail.gmail.com>
Message-ID: <CAK8P3a2XPwG7rP+TFdEYH7tutE7Zat5vf7PuV2idESZsrxBXyA@mail.gmail.com>
Subject: Re: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9bBkhrbDaG5PYnnmFLx5Puqtn6APHaGaSKks3C5hslvyToFEzly
 7uWFCFq5IXoopmcuLLlJA3GJ8aTbMIWMU1/0L2w9yILxOCs3yMtuXPmUmM+wCBh5tSmGuW5
 yBwnvQlFaift4c/ErMJiBxHlBzFRXp8xccKpgSD/eOdrjmtYbbGkfODzkFVIyeCh2QcYwFY
 4fDHvrlzEzbDoI0fgmxeQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJZ1Dxb5cx4=:wNTfWpJLzYDAJNvCBYUpDP
 GXEZOe/FD1qfj8mIH8lkDKsmBQjnwBoRelLQ+kYpw2FMKUrjG7j9JGoNLmIhDoJ/zrjmwCQMy
 5VF6CjcI3P1WqkmJndLKrWVMQnKzSvsV1hO1/oOvd3SnrwlsB8jd5+j76jB5N25LWj86iSkD+
 SgcsdoeAm63Y8xLadz+1Z94jFWyC9S8NJMqdhbCcsklBoffa9+fLCHGM623nmbFOOn7FYh+PF
 ZhBQQjHumkTQDv9M260DhN4nN0jPbOACaLKQlls22fUOzOsJEzaqhKBfLoFyd3R7AkzalD6QP
 BfektCwwbFp/joy1PuzUsCspYj8raQuUbEwkl7jy+DZx73kLdueR8GqgwiwYH7y0aDIfDCvXu
 jmAh0Jll00wMBZvZko2XOZECVDDLz4O+oTi8f7fu9wu6f/5ofUM2UNjQBk9JjKNWEryBuJC5D
 gGYeIZFWlBmhwZ+VQFoa5QsOdpfdvlFCw6oVvRU77MM/u3kfBCaXqeF8vX8w2C1JYAJrRgdyi
 3YDnEj9YJ2PNUsF/sUfq4CXPk3AhDCUvpLPq+piWep9PGEcpcS5T7vF7cNmeGYo7dUli3EfwX
 Ho3ekmR+lXdfSC3eFxfSjCBnPbVH+6tWH3F57GT73whtnxteIienS2XPa8sKitl1kfx3pTuBa
 1lKjqF0FwIplXi23vaR+6dsHw8yOXy7m560IuyO+WhMOIcIOEGPfWSW92eBATR9CHvyTMAljV
 X3O1lJMry2zN6iGOmwXBN05c84NrZDVhYh507w==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 19, 2022 at 1:31 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> * Arnd Bergmann <arnd@arndb.de> wrote:
>
> > > I tried to avoid as many low level headers as possible from the main
> > > types headers - and the get_order() functionality also brings in bitops
> > > definitions, which I'm still hoping to be able to reduce from its
> > > current ~95% utilization in a distro kernel ...
> >
> > Agreed, I think reducing bitops.h and atomic.h usage is fairly important,
> > I think these are even bigger on arm64 than on x86.
>
> So what I'm using for 'header complexity metrics' is rather simple: passing
> -P -H to the preprocessor: stripping comments & not generating
> line-markers, and then counting linecount.
>
> Line-markers should *probably* remain, because the real build is generatinginclude/linux/mm_page_address.h
> them too - but I wanted to gain a crude & easily available metric to
> measure 'first-pass parsing complexity'. That's I think where most of the
> header bloat is concentrated: later passes don't really get any of the
> unused header definitions passed along. (But maybe this is an invalid
> assumption, because compiler warnings do get generated by later passes, and
> they are generated for mostly-unused header inlines too.)
>
> If we include comments & line-markers then the bloat goes up by another
> ~2x:
>
>  kepler:~/mingo.tip.git> ./st include/linux/sched.h
>   #include <linux/sched.h>                | LOC:  2,186 | headers:  118
>  kepler:~/mingo.tip.git> ./st include/linux/sched.h
>   #include <linux/sched.h>                | LOC:  4,092 | headers:    0

The metric I've been focusing on is bytes of the preprocessed header, which
is more sensitive to function definitions that get generated from macros,
and I multiply this by the number of inclusions (from scanning the
.file.o.cmd files). It probably helps to have a couple of metrics and look
at all of them occasionally to not miss something important.

In the meantime, I have made some progress on reducing the headers
for arm64, on top of your tree from Jan 8, but I have not looked at
later changes from your side, and I need to work on this a bit more
to ensure this doesn't break other architectures.

For an arm64 allmodconfig build, my additional improvements on top
of yours are significant but not as good as I had hoped for, this
can still improve I hope:

5.16-rc8-vanilla  32640 seconds user, 3286 seconds sys
5.16-rc8-mingo  22990 seconds user, 2304 seconds sys
5.16-rc8-arnd   19007 seconds user, 1853 seconds sys

As my tree builds any randconfig cleanly, I keep looking at
different configs and find that this has a big impact, some options
end up eliminating most of the benefits until I add further changes
to clean up certain files. This happened with kasan, kprobes,
and lse-atomics for instance. After eliminating all circular includes,
I was also able to revisit my old script to visualize the inclusions,
see[1] for the current arm64 defconfig output. This version uses
my arbitrary metric as font-size, and uses labels for the number
of inclusions.

        Arnd

[1] https://drive.google.com/file/d/1wbs252I8LyswscBAeV3SpjBG2AGoBnB8/view?usp=sharing
