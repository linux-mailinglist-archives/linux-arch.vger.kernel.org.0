Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1AFB3B8515
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhF3OfJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 10:35:09 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbhF3OfJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jun 2021 10:35:09 -0400
Received: from [192.168.1.155] ([95.114.41.241]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MI59b-1m2me92Qr9-00FFu8; Wed, 30 Jun 2021 16:32:30 +0200
Subject: Re: x86 CPU features detection for applications (and AMX)
To:     Thiago Macieira <thiago.macieira@intel.com>, fweimer@redhat.com
Cc:     hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
 <2379132.fg5cGID6mU@tjmaciei-mobl1>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <e07294c9-b02a-e1c5-3620-7fae7269fdf1@metux.net>
Date:   Wed, 30 Jun 2021 16:32:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2379132.fg5cGID6mU@tjmaciei-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jQMhLb669qYUiBdHS8TuwUhMShKrBKA44JZi+rkkizuV45+uHcy
 g+PnlkDokDpPZ49en0PYC1d8ecsJX9QCo4iNI/4Z9/KFgPZS5nwNJnuEugOQY2IC7SMoQPs
 QpZTVu0uTpeXcCfeHdmpjoQj5MC75Vi69xjE0qbZJGlpQXGJWcHqkBqSe4zIkWBW48rw5A7
 FTa8/5vWjl7IXq+hwD5qw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KxQDP+o0B38=:ZxXRy3rrtDz5j9hCAfXmj9
 Q/coyEj0TOj2O09a8ijojtRFjq8B79tpwfeIrXK+VWgZf/PvSgb+jX14YrdN4Z6sRn+mUGCUO
 PzMSdynnFN3JZ+BwFBKAl0Rn3Xb5hECkIfSr84RZTnIHAnjfKhq1ZdUFMnPLWiFmzKJGKYaX4
 jK6iLBdZDX1+Q/A55LtZPBLabVQjRUM3pS/O4p5ylv8MTRKEMEJHYzv59rZAs4gF+IqGD4uHJ
 mLlkr/mrs7dsG+MCBKXSE3iml8WkvBLG8is/YF+HUQqe/BzRCLQCz/CS9Z+rkyQfcfhf9qogF
 KWW7r2qOZ1hBEhI6/EDJa+//lrRwmSwNYNfwveOuALbJ8eRQOWtLVfbNb+n0ekZnQW8qxu7A9
 3g2tWop+iU/JdJi5lifFUQsIdnG++QTNhfdhzSvX90pTA7+jbQOB+t+ewVD6sEnbW2U8gPnDL
 uqorw0EJVnr0nrWO6FGZ/Jd60LNRdh9WXYy9Boh273iBdJP5AiCT2GnSdmODDuOMisa8PTSt0
 OP3HqCyj32CL+gU4iY39bKd65Jebyq83As7QGg8G7Bb0QWkBxdgsoKyUzibpYckaIRvu06l8c
 nB9/U8Ig6sggcTapKI2wc9TYTxMenC+Lu7kUQDD4nEp8uRGn+JxHWjIymbT5E0AdrGtAzxITg
 UW9jixMzy6LqxODsKZbgNkUEjFHJ8MyVvg41pNOMD7i8fyr+86RlCpykGe+/zhPliy8RmioB9
 tb+hMCzR8vxe37hoOsY2T6/fA1g5hUk10yoNmfNuUw/RzNoZda08xg6ekqKAThWGaXr3UDNpV
 QZau9T89Lw/76Mft3ytCU3cc6GtjkILrIJIfpQYJK/Jyhk4h4YL2xly6EMWdT4jIBc+3Orv
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28.06.21 17:08, Thiago Macieira wrote:

>> hmm, maybe some libcpuid ?
> 
> Indeed. I'm querying inside Intel to see if I can get buy-in to create such a
> library.

What does "buy-in" mean in that context ? Some other departement ? Some
external developers ?

I tend to believe that those things should better be done by some
independent party, maybe GNU, FSF, etc, and cpu vendors should just
sponsor this work and provide necessary specs.

>> Since we're talking about GNU libc here, binary-only stuff is probably
>> out of scope here. OTOH, using differnt libc versions in those special
>> cases isn't such a big deal.
> 
> Shipping a libc is not trivial, either technically or due to licensing
> requirements. Most applications want to link against whatever libc the system
> already provides, if that's possible.

Shipping precompiled binaries and linking against system libraries is
always a risky game. The cleanest approach here IMHO would be building
packages for various distros (means: using their toolchains / libs).
This actually isn't as work intensive as it might sound - I'm doing this
all the day and have a bunch of helpful tools for that.

OTOH, if one really needs to be independent of distros, one should build
a complete nano-distro, where everything's installed under certain
prefix, including libc. Isn't a big deal at all - we have plenty tools
for that, daily practise in embedded world. The only difference would be
tweaking the ld scripts to set a different ld.so path.

Licensing with glibc also isn't a serious problem here. All you need to
do is be compliant with the LGPL. In short: publish all your patches to
glibc, offer the license and link dynamically. Already done that a
thousand times.

If there really is a serious demand for that, and you've got clients who
are really interested in doing that properly (a lot of companies out
there just duck an cover, and don't actually wanna talk about that :(),
let's sit together and create some consulting material on that.

>> Actually, you should talk to the compiler folks much more early, at the
>> point where you know how those features look like.
> 
> We do, but it's not enough.
> 
> GCC releases once a year, so it's easy to miss the feature freeze. 

Wait a minute ... how long does it take from the architectural design,
until the real silicon is out in the field ? I would be very surprised
whether the whole process in done in a much shorted time frame.

Note: by "much more early", I meant already at the point where the spec
of the new feature exists, at least on paper.

 > Then there are Linux distros that do LTS every 2 years or so.

Why don't the few actually affected parties just upgrade their compiler
on their build machines when needed ?

Come on, on other languages like rust (often also w/ go), you're
expected to upgrade your compiler almost on weekly basis, or you can't
build the current master branches of many projects anymore :p

> Worse, those two are
> usually out of phase. For example, if you're using the current Ubuntu LTS
> today (almost July 2021), you're using 20.04, which was released one month
> before the GCC 10 release. So you're using GCC 9, released May 2019, which
> means its features were frozen on December 2018. That's an incredibly long
> lead time.

Just install the backport ?

And if the backport hasn't be done at that point of time yet, just do
that ?

>> For using certain new CPU specific features, the need for a compiler
>> upgrade really should be no excuse. And at least for vast majority of
>> cases, a proper compiler could do it much better than the average
>> programmer.
> 
> To compile the software that uses those instructions, undoubtedly. But what if
> I did that for you and you could simply download the binary for the library
> and/or plugins such that you could slot into your existing systems and CI?
> This could make a difference between adoption or not.

For me, it wouldn't, at all. I never download binaries from untrusted
sources. (except for forensic analysis).

And putting my build engineering consultant hat on (which actually is
huge part of my business), I'd clearly say NO to precompiled binaries,
unless there really is no other way - very rare cases, where one usually
has a lot of other trouble, too.

Such precompiled binaries (where you cannot control the whole process)
are dangerous in many ways, for security, as well as safety, as well
economically.

>> Uh, that's really ancient. Nobody can seriously expect modern features
>> on such an ancient distro. If people really insist spending so much
>> money for running such old code, instead of just doing a dist upgrade,
>> then I can only reply with "not our problem".
>  > Yes and no.
> 
> Red Hat has been incredibly successful in backporting kernel features to the
> old 3.10 that came with RHEL 7. Whether they will do that for AMX state saving
> and the system call that we're discussing here, I can't say. AFAIU, they did
> backport the AVX512 state-saving to that 3.10, so they may.

Indeed they did. No idea why they spend so much resources into that,
instead of fixing their upgrade mechanisms once and for all, so a dist
upgrade is as simple and robust as e.g. on Debian. Or at least add newer
kernels to older distro bases - extra repos really dont hurt.

 From my operating perspective, I wouldn't actually call RHEL a very
professional distro, many simple things are just very complicated and
weird ... really no idea what these guys are doing there. Never could
find any serious technical explaination, must be some purely political
or ideological thing.

BUT: we're talking about about brand new silicon here. Why should
anybody - who really needs these new features - install such an ancient
OS on a brand new machine ?

 From my experience w/ larger clients, especially in public service, the
only reason is their own extremely lazy and overcomplicated beaurocratic
processes (problems that they've created on their own - the excuse of
this would be regulatory obligations is just proven completely wrong,
I'm perfectly capable of setting up formalized management processes
that are much more agile and still confirm to the usual regulations like
BSI, GDPO, 62304, etc, etc, and actually make them work as intented :p)
But exactly those organisations wouldn't be able to even buy this new
silicon anytime soon, since they own processes are just too slow in
updating their internal shopping basket.

Oh, and another interesting point: those organisations usually run all
their linux workloads in VMs (mostly ESXI, sometimes hyperv). Is AMX
already supported in these constallations ?

At that point I wonder whether the actual demand for this use case -
brand new silicon features && ancient distros && out-of-distro built
precompiled binaries && precompiled-binaries (not auditable) permitted -
actually a suffiently frequent use case that's worth taking care of it
in such  general way at all ?

[ not talking about very specific scenarios like CERN, who're building
special machinery on their own ]

> Even if they don't, the *software* that people deploy may be the same build
> for RHEL 7 and for a modern distro that will have a 5.14 kernel. 

Now we're getting to the vital point: trying to make "universal"
binaries for verious different distros. This is something I'm strictly
advising against since 25 years, because with that you're putting
yourself into *a lot* trouble (ABI compatibility between arbitrary
distros or even various distro releases always had been pretty much a
myth, only works for some specific cases). Just don't do it, unless you
*really* don't have any other chance.

What one could do is taking the distro's userland completely out of the
way by not using a single piece of it. Once upon a time, glibc could be
statically linked easily - not so easy anymore. But with a few bits of
patching you can have an entirely separate instance. (basically tweak
install pathes, including the ldstub). Or picking another libc supports
this better. Most of the other userland libs are quite easy to link
statically (yes, there're unfriendly exceptions) or at least can be
easily installed in a different location.

Now the questions of the build process for that. I'd recommend using
ptxdist for that. We have to twist a few knobs, but an creating a
generic toolkit (some /opt/foo-install counterpart of DistroKit)
shouldn't take much more than 4..6 weeks, and the problem is solved
once and for all. Anybody can then just put in his own SW, fire the
build and gets a ready to use image/tarball. Pretty much like we're
doing it in embedded world for aeons.

 > That software
 > may have non-AVX, AVX2, AVX512 and AMX-specific code paths and would
 > do runtime detection of which one is best to use.

Yes, nothing new, not unusual. All the SW needs is a way to detect
whether feature X is there or not and pick the right code pathes then.

> So my point is: this shouldn't be in glibc because the glibc will not have the
> new system call wrappers or TLS fields.

Yes, I'm fully on your side here. Glibc already is overloaded with too
much of those kind of things that shouldn't belong in there. Actually,
even stuff like DNS resolving IMHO doensn't belong into libc.

>> What we SW engineers need is an easy and fast method to act depending on
>> whether some CPU supports some feature (eg. a new opcode). Things like
>> cpuinfo are only a tiny piece of that. What we could really use is a
>> conditional jump/call based on whether feature X is supported - without
>> any kernel intervention. Then the machine code could be easily layed out
>> to support both cases with our without some feature X. Alternatively we
>> could have a fast trapping in useland - hw generated call already would
>> be a big help.
> 
> That's what cpuid is for. With GCC function multi-versioning or equivalent
> manually-rolled solutions, you can get exactly what you're asking for.

Not quite what I've been proposing.

My proposal would an conditional jump opcode that directly checks for
specific features. If this is well designed, I believe that can be
resolved by the cpu's internal prefetcher unit. But for that we'd also
need some extra task status bit so the cpu knows it is enabled for the
current task.

Another approach (when we'd design a new cpu) would be a special memory
region for opcode emulation call vectors with enough room for dozens
of potentially upcoming new opcodes. If cpu encounters an unsupported
op, it jumps there. A bit similar to IRQs or exceptions, but designed in
a way that emulation can be implemented entirely in userspace, just like
if the compiler would have put an jump instead of the new op there.
With such an instruction architecture, those kind of feature upgrades
would be much much easier, w/o even touching the kernel.

This wasn't invented by me - ancient mainframes from the 70ths have
prior art.

>> If we had something in that direction, we wouldn't have to have this
>> kind discussion here anymore - it would be entirely up to compiler and
>> library folks, no need for any kernel support at all.
> 
> For most features, there isn't. You don't see us discussing
> AVX512VP2INTERSECT, for example. This discussion only exists because AMX
> requires more state to be saved during context switches and signal delivery.

But over all these years, new some registers have been introduced.
I fail to imagine how context switches can be done properly w/o also
saving/restoring such new registers.

Actually I claim that (user accessible) registers are already the
problem. The good old Burroughs mainframes didn't have that problem,
since their IA doesn't even have registers, it's all operating on stack.
The harware (or microcode) automatically caches the top-n stack elements
in internal registers, so it is as fast as explicit registers, but the
code gets much simpler and more robust (they also have fancy things like
typed memory, etc, but that's another story).

>> And one point that immediately jumps into my mind (w/o looking deeper
>> into it): it introduces completely new registers - do we now need extra
>> code for tasks switching etc ?
> 
> Yes, this is the crux of this discussion.

Yes, and that's the reason why I call that a misdesign. It shouldn't
have been the big deal to do it w/o new registers - we know that's
possible from the 70ths.


Finally, as this stuff changes the ABI completely, perhaps we should
treat it directly that way: call it a new architecture that has its
own ID in the ELF header. By that we'd have a clear border line and
don't need to care about a dozen of corner cases nobody of us has on
the radar yet.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
