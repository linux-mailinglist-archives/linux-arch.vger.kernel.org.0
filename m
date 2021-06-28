Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9867E3B5E2B
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhF1MnJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 08:43:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40257 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhF1MnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 08:43:09 -0400
Received: from [192.168.1.155] ([77.9.21.236]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MDQNq-1m8KhA0Cve-00AYPw; Mon, 28 Jun 2021 14:40:34 +0200
Subject: Re: x86 CPU features detection for applications (and AMX)
To:     Thiago Macieira <thiago.macieira@intel.com>, fweimer@redhat.com
Cc:     hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
Date:   Mon, 28 Jun 2021 14:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ODCk6xRYnDSdAh5bVZ17PidmlPVcSX3xmbUJU6N2SPqZ38geyoC
 fNFI0r0nggZjARFfq+WwHx0tKH/29X5RxpjwKlvGto1lJsXjLtsN2moKTQUVeIkAya5HqbV
 50taw4EtgoOt3xGXH9FJqHCz3/SnctHalqmYWbS8ofHcS/BGcLb+LYTQZHBge6t9jp1pugV
 8EaBVs4lRAexqWTnZx7WQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9UVpeT2twbc=:l045R1ipyrHR+Mj3zm4dd1
 M1nYYsDbkXaT7jgerAckw+a732RCz1vpiEiKOQZbULXdySmKZslayj5cUfq2RBqyP9z2op3N9
 I+Ke4g1qXydgOA8VIr2QtZVJ+hwLkKUmPCAbq2KEcuGKUayvSpHhjkgC4LiLA0qAwrHt40smI
 t3c7f9N+Bpe2jRX5CODv3K4aSt5Al9FN2Lzr/slaLM8sPmfSxAM3UJ8DxBJO6f7mRiSr+Pavj
 cqK/7yt8AolGu7lbgcQKYMFjTq/SIdqz6gocFbHCsKIo+koDbqCUU5GMqYr1QJk57JhAsnwRb
 us70aEEQwDe6RTi5QloA/H0Xh4bFRYI7daO6DhHLcsjE0qbDqI08cmvx8lRDCoTFTIQRXCcfU
 Aw4Y6dESebyJ5ybeWgHk0XgAMi55vFLepU9h7gpTITyA3v5tUw8nq4lWxvVEx1echQuduCGz3
 pzqnwZKguqhMcu0TAuO1UEnUzhLyR8Df3+5fYLXK9AIlSl5dXkaaD9jTPvKuENnbq13DF9hBn
 UHfV/Kne0R/sBng6IDFLwc=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26.06.21 01:31, Thiago Macieira wrote:

Hi folks,

> The first problem is the cross-platformness need. Because we library and
> application developers need to support other OSes, we'll need to deploy our
> own CPUID-based detection. It's far better to use common code everywhere,
> where one developer working on Linux can fix bugs in FreeBSD, macOS or Windows
> or any of the permutations. Every platform-specific deviation adds to
> maintenance requirements and is a source of potential latent bugs, now or in
> the future due to refactoring. That is why doing everything in the form of
> instructions would be far better and easier, rather than system calls.

hmm, maybe some libcpuid ?

Personally, I believe that glibc already is too big, too much things
that belong into a separate library.

> The second problem is going to be backwards compatibility. Applications and
> libraries may want to ship precompiled binaries that make use of the new CPU
> features, whether they are open source or not. 

Since we're talking about GNU libc here, binary-only stuff is probably
out of scope here. OTOH, using differnt libc versions in those special
cases isn't such a big deal.

OTOH, depending on the programming language, those things might be
better put into the compiler. (Of course that needs good coordination
between different compiler vendors.)

Why do I believe so ?

a) If you really want optimal performance, it's not just about whether
    you can call certain opcode (and have a fallback if the opcode's
    missing), also the order matters.

    For example, back in P4 times, and old friend of mine (raytracing
    expert) did in-depth measurement of the P4's timing behaviour
    depending on opcode ordering, and he managed to achieve 5..10x (!)
    performance improve on raytracing workloads. But this was only
    possible by hand written assembler code, a C compiler wouldn't be
    able to do that (we actually designed some DSL for that, so a special
    compiler can generate the optional CPU specific code)

b) In recent years we're moving more and more to higher level (but still
    compiling to machine code) languages, where writing such machine
    specific code is either very hard or practically impossible - it's
    just the duty to handle such things.

> It comes as no surprise to anyone that we CPU makers will have made software 
> that use those features and
> want to have it ready on Day 1 of the HW being available for the market (if
> we're doing our jobs right). That often involves precompiling because everyone > who installed their compilers more than one year ago will not have the
> necessary tools to build. 

Actually, you should talk to the compiler folks much more early, at the
point where you know how those features look like.

Of course, there are cases where folks can't upgrade their compilers
easily due to certain formal processes. But those are just special case,
they've got tons of other problems for the same reason, and quite
frankly their processes are just broken to begin with. I've done several
projects in regulated areas (medical, automotive, etc) where folks use
ancient stuff just by the excuse of too much paper work and the silly
idea that certain sheet of certification paper for some old piece of
code gives any clue on actual quality or helps with their own
qualification processes (which, when reading the regulations carefully,
quickly turns out as nonsense).

For using certain new CPU specific features, the need for a compiler
upgrade really should be no excuse. And at least for vast majority of
cases, a proper compiler could do it much better than the average
programmer.

> And by "recently", I mean "anything since the glibc that came with Red Hat
> Enterprise Linux 7" (2.17).

Uh, that's really ancient. Nobody can seriously expect modern features
on such an ancient distro. If people really insist spending so much
money for running such old code, instead of just doing a dist upgrade,
then I can only reply with "not our problem".

In that case it's the duty of Redhat, doing their job right for once and
provide newer libc and gcc versions (and yes, it really isn't a big deal
having multiple versions of them installed concurrently).

I'm really not a fan of running bleeding edge software, but doing a dist
upgrade every 1..2 years really isn't asking too much (except perhaps
for some very exceptional cases). Especially not for big organisation
with enough money for being able to spend so much money to such vendors.
(or are their pockets empty because they already pay so much for RHEL ?)

> A platform-specific API to solve a problem that is already solved is "knock
> yourself out, we're not going to use this." So my first suggestion is to
> remove the "platform-specific" part and make this a cross-platform solution.

Speaking of platform specific problems: that's where I need to tell that
I'm *very* unhappy with you CPU vendor folks. Actually it's you, who
created a those - not just platform but CPU model specific - problems.
The whole topic is anything but new, there could have been a long term
solution decades ago, on silicon level. (I could say a lot about the
IMHO really weird opcode layout, but that'd be too far out of scope)

What we SW engineers need is an easy and fast method to act depending on
whether some CPU supports some feature (eg. a new opcode). Things like
cpuinfo are only a tiny piece of that. What we could really use is a
conditional jump/call based on whether feature X is supported - without
any kernel intervention. Then the machine code could be easily layed out
to support both cases with our without some feature X. Alternatively we
could have a fast trapping in useland - hw generated call already would
be a big help.

If we had something in that direction, we wouldn't have to have this
kind discussion here anymore - it would be entirely up to compiler and
library folks, no need for any kernel support at all.

Going back to AMX - just had a quick look at the spec (*1). Sorry, but
this thing is really weird and horrible to use. Come on, these chips
already have billions of transistors, it really can't hurt so much
spending a few more to provide a clean and easy to use machine code
interface. Grmmpf! (This is a general problem we've got with so many
HW folks, why can't them just talk to us SW folks first so we can find
a good solution for both sides, before that goes into the field ?)

And one point that immediately jumps into my mind (w/o looking deeper
into it): it introduces completely new registers - do we now need extra
code for tasks switching etc ?

Since this stuff seems to be for tensor operations, I really wonder why
that has to be inline with classic operations ? Maybe I'm just lacking
phantasy, but I don't see much use cases where the application would not
want to do those operations in larger batches and we already have
auxillary processors like TPUs or GPUs for. What is the intended use
case for that ? Who would actually benefit from that ?


--mtx


*1) 
https://software.intel.com/content/dam/develop/public/us/en/documents/architecture-instruction-set-extensions-programming-reference.pdf

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
