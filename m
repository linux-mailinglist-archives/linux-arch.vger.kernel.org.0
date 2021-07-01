Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7278C3B9162
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jul 2021 13:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbhGAMAb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jul 2021 08:00:31 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jul 2021 08:00:31 -0400
Received: from [192.168.1.155] ([95.117.176.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MyK1E-1l0MY320KK-00yeWD; Thu, 01 Jul 2021 13:57:47 +0200
Subject: Re: x86 CPU features detection for applications (and AMX)
To:     Thiago Macieira <thiago.macieira@intel.com>, fweimer@redhat.com
Cc:     hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <2379132.fg5cGID6mU@tjmaciei-mobl1>
 <e07294c9-b02a-e1c5-3620-7fae7269fdf1@metux.net>
 <7070437.BNXKksOFrS@tjmaciei-mobl1>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <5496c8ce-b318-5fba-446f-c821f7258e15@metux.net>
Date:   Thu, 1 Jul 2021 13:57:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <7070437.BNXKksOFrS@tjmaciei-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Tvd9DFxExuG6iRcUB8dMct7nwb777tIy8HKCq9DYfRVcBl/dsY4
 uzExCS/OltWkRzJy2ipRc1VVdne7TVqzc+m9peaGyHF5ydoIbHIC/enaDd70AI8Uggh2epI
 95uzbTze+Zd1cc3wQ2cWBlskmvXX5Q9CmMhWqWu66UKw5ugTNpKkxmK2/xga16WB7UAnJ2D
 SgXHd2mS91oibKHSr73aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wnpSa0yAmCQ=:EnfphqJOApRluCI3eQJsdU
 TbPLuPGIAbbKs6nDu96RSdh55bgtX5I06uP73v3nZE8D9SzGsv/Lju6tuzu6h6igREhsh3ZQE
 Eij4xKz8kV+MZt1mEb71CFxUHEq3cNI8xC1XyIgCfnSOvtaW04CnuPyNM5Sw6Y2bORz9y5lXR
 xUekmvb1JF/Np2T3KXKbyV57/j+AbcmXF09HIR4FwTxTyKe/ZNsSeAuN6v1RtXOOv8SIexVZE
 Om+gMMkc0OwsSr1weWte2y/CN3b5InXvxd1Unzz7rKaL9CHMBdbw8sKU7e80+6NP2NYOQH3zr
 InezIGApuRqlURA4i7yALx/XzX8k5NqTCDSp+cWTL00vpC3EYghO3f24z/j5FE59tfD+sEqGP
 2OTyk89ktjcz4Zh0JZosJdyE4VNrdjWRSzFk83eJK2XXrt23n1+JH1zMdi1QzRPZjZPlJ0lRj
 2iPtbLgpVwlNup1NkW8aV/wJQBqGkkXcjjByZJ53TheRJnXY+obpocOZh1cPcmE0crFSqlCyv
 yZZ/uy+Ciho+yySHFU1OqGN56Hfa1MF730Y+Gv6vLmpTUkQP2SLDygCGOF84FdKZbgsECyVSx
 32RcsD6Xr4ZJ+4ttSGTGTyZVt9Cbh6weFrM3ZataeHts3t4SQd4JchYoYDf3tAaVqY8/7JwXH
 mhKwGkpgWzXJfu+gTCSL/WPQaRukttCRllF5SMOrdRkaSimpodEx33lcuHXAWYzKTVZaQz9At
 U3kfAzhnt2jIeKv9Y9zKb2BPfzIe8FuPYQ9YeUeF6rvti5eBIT7gk0NAvSucKDbwRCBFVYBrq
 tGLzSXfmgrt1zWXFyyrdv5nruq8L78TkF4E9YifPp6J/Attb6t8A3icRD6H9MMqZYdOK01h
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 30.06.21 17:29, Thiago Macieira wrote:

Hi,

> For me specifically, I need to identify some SW dept. that would take on the
> responsibility for it long-term. Abandonware would serve no one.

Right. And from what I've learning in such large organisations, finding
someone who's willing to take such responsibility isn't an easy task :o

> I wouldn't mind this were a collaborative project under the auspices of
> freedesktop.org or similar, so long as it is cross-platform to at least macOS,
> FreeBSD and Windows.

hmm, this also hightly depends on what that library shall be actually
doing. if we're talking just about cpuid parsing (and providing some
comfortable API) isn't a big deal at all. (personally, can't contribute
much for the actual backend side on window or macos, but shouldn't be so
hard to find some people here).

But for AMX, unfortunately, that's just a tiny fraction. Actually, it
seems that this specific information is actually useless, since we need
to explicitly ask the kernel so set things up and it can just say no.

> But given that this is in Intel's interest for this library to exist and
> make it easy for people to use our CPU features, it seemed like a natural
> fit for Intel. And even if it isn't an Intel-owned project, we probably 
> want to be contributors.

Great :)

> I understand, but whether it is easier and better for 99% of the cases does
> not mean it is so for 100%. And most especially it does not guarantee that it
> will be used for everyone. For reasons real or not, there are precompiled
> binaries. Just see Google Chrome, for example.

Yes, there is a lot of such crap out there and Chrome is a good bad
example. But that doesn't mean that we here should ever care about that.
Let'em deal with their weird stuff on their own.

Specifically on such applications like Chrome, their official excuses
for doing this are pretty funny, some examples:

#1. "oh, it is so hard building native packages for many distros."

     No, it's not (especially not for such huge sw development companies
     like Google, who do have the right people for that). I'm doing that
     all the day. I've got even my own tools for that, freely available
     on github. This can be done 99% fully automatically.

     The actual problem is: SW like Chrome is just a monster, which is
     very hard to build from source. This problem was created by nobody
     else than the vendor.

#2: "we need our own install/update mechanism, to make it easier for
     users to install"

     No, we have easy install/update mechanism since 25 years. It's
     called package management. Just make your SW easy to build and
     customize, and distros take care of it - just like w/ 100s of 1000s
     other packages. Oh, BTW, this even exists on Windows.

#3: "we need some fast update for security fixes"

     Yes, we have that: package management. See #2.

Chrome is an excellent example for doing so many things so fundamentally
wrong (BTW: large portion of the security problems also come from that
crazy SW architecture - e.g. putting so many different things into one
program that could easily be done in several entirely separate ones).
They just made simple things extremely complicated.

I could start a rant on even worse examples like NVidia or NI here, but
in respect of blood presure I'll stop here :p

>> Licensing with glibc also isn't a serious problem here. All you need to
>> do is be compliant with the LGPL. In short: publish all your patches to
>> glibc, offer the license and link dynamically. Already done that a
>> thousand times.
> 
> We can agree it's an additional hurdle, which will likely cause people to
> investigate a solution that doesn't require that hurdle.

Yes, it is *some* hurdle, but I doubt that this is a show stopper. When
you're already on Linux SW development, you almost certainly have to
cope with such things anyways (unless you're really don't using anything
of the existing ecosystem - which, in very most cases, is very bad
design in the first place).

The *extra* hurdle here in that case is:

*if* you patch glibc, you have to publish the patches, if you don't
patch it, there's nothing to do.

> I'm not going to comment on the timing of architectural decisions. But just
> from the example I gave: in order to be ready for a late 2021 or early 2022
> launch, we'd need to have the feature's specification published and the
> patches accepted by December 2018. That's about 3 years lead time.

Sorry, but I still don't get why that 3yrs window. We're talking about
entirely new features where SW actually *using* that doesn't even exist.
I wonder where you get the idea from that *old* SW shall magically
support something entirely new, w/o rewriting it.

Since much of the discussion here was about large and beaurocratic
organisations (which I'm coping w/ on daily basis) with lots of formal
processes - those who still run the ancient distros, we've been talking
about:

For those, if some software already in use by them comes around with a
new release that actually uses that new feature, it's not a minor path
anymore, but a major jump that implies migration or new installation.
They have to go through the whole evaluation, testing, qualification,
integration processes from start. From process perspective, it's
basically a new product. And most likely, it's not even a standard
product (what some departement could just order centrally, like some
laptop or a standard VM or some piece of storage). It will take even
quite some time, before they're able to order this new hardware.

There're basically two chances for getting such installations in those
organisations (remember: exactly the users of such old distros):

a) bring the new product into the organisation wide standard process.
    Usually takes *at least* a whole year (often much longer). And also
    add the new hardware (complete machines that already come with the
    the new CPU types) to the standard catalog (similar time frame)

    If the SW is run in the data center, which alomost certainly means
    running in a VM (ESXI or HyperV), then this VM infrastructure needs
    to fully support this, too. Add another year.

b) the whole installation is completely taken out of standard processes.
    (often called "appliance"). then all the factors that lead to
    sticking to the old distro version in the first place, vanish in
    thin air. (the whole reason for choosing those distros is mostly
    coming from the management processes, not actually technical reasons)
    IT-ops managers usually don't like those out-of-process "appliances"
    very much, they're are quite common.

> How many software projects (let alone mixed software and hardware) do you know
> that know 3 years ahead of time what they will need?

In embedded world (large portion of my business), that's the usual case.
Once you go into regulated fields like automotive or medical, that's
even required by the usual processes, and the time frames are much
longer.

But we'd been talking about the timeline of CPU feature development and
corresponding SW support. Haven't done actual CPU development myself (my
self-soldered transputer experiment from the mid 90th wouldn't count
here ;-)), but I'd suspect that from the point in time where the CPU
designers create a new feature on the sketchboard and decide how the IA
would look like, until the point where the public can actually buy
standard machines with these new chips, will take several years. Let's
just randomly assume three years. Now if these CPU designers would
publish the new IA spec at that point, we had three years time until
we might see the first actual machines in the field. (as outlined above,
wide deployment in large organisations will take even much longer).

>>   > Then there are Linux distros that do LTS every 2 years or so.
>>
>> Why don't the few actually affected parties just upgrade their compiler
>> on their build machines when needed ?
> 
> Have you tried?

Actually, yes.

And when setting up CI infrastructures, I'm usually letting them build
the SW by various toolchain versions and combinations. Once you've got
the basic infrastructure set up, adding more combinations is just a
matter of more iron.

> Besides, the whole problem here is barrier of entry. If we don't make it easy
> for them to use the new features, they won't. 

Let's to look at it from a completely different angle:

In order to make actually use of those new features, several things have
to be done (with different stakeholders):

1. education: developers need to know how to actually write code
    actually using these features in a good way.
2. tech: OS and tooling support
3. customers need to be able to actually buy and deploy that new HW,
    as well as new SW that actually uses these new features
    (internal purchase, qualification processes, support, ...)

The main point we're discussion right now is #2. In this discussion
we've now learned:

1. it needs certainly needs new versions of OS components and tooling,
    and SW vendors need to build and deliver new SW versions for that.
2. many folks out there have problems with upgrading these things
3. the above problems aren't specific to cpu features, but we encounter
    them in a wide range of other scenarios, too.

So, why don't we focus on solving these problem once and for all ?

Let's try to give the customers the necessary means that they just don't
need to stick old compilers, libraries, etc., anymore.

An important part of that story is building and shipping software for
various distros. We have the tools and methods for doing very most of
that fully automatically. Basically needs: putting the tools together,
lots of iron, and training + consulting. Been there a lot of times

(actually started creating some out-of-the-box solution for that - just
lacking the marketing to make it economically feasable for me.)

> And I was using this as an
> argument for why precompiled binaries will exist: the interested parties will
> take the pain to upgrade the compilers and other supporting software so that
> the build even of Open Source software is the most capable one, then release
> that binary for others who haven't. This lowers the barrier of entry
> significantly.

As mentioned, the root cause is that tooling upgrade and building
certain software isn't quite easy, which is also one of the main causes
why certain SW isn't up to date in many distros. Let's solve the root
problem instead of just cleaning up its fallout again and again.

> And this is all to justify that such a functionality shouldn't be part of
> glibc, where it can't be used by those precompiled binaries which, for one
> reason or another, will exist.

I fully aggree that those things shouldn't belong into glibc (along with
many other things).

> It should be in a small, permissively-licensed library that will often get
> statically linked into the binary in question.

ACK.

>> For me, it wouldn't, at all. I never download binaries from untrusted
>> sources. (except for forensic analysis).
> 
> I understand and I am, myself, almost like you. I do have some precompiled
> binaries (aforementioned Google Chrome), but as a rule I avoid them.
> 
> But not everyone is like the two of us.

The really interesting question why do people wanna do that at all ?

IMHO, the most plausible reasons is: they can't get that SW (or release
thereof) from their distro and also can't build it on their own.

So, that's the main problem here. We should focus on eliminating the
need for such out-of-distro precompiled binaries (even for proprietary
software - take care that it is built for the distros, and using the
distro's build/deployment toolchain).

>> BUT: we're talking about about brand new silicon here. Why should
>> anybody - who really needs these new features - install such an ancient
>> OS on a brand new machine ?
> 
> I don't know. It might be for fleet homogeneity: everything has the same SW
> installed, facilitating maintenance. Just coming up with reasons.

Yes, and where's that actually coming from ? Beaurocratic processes that
reached a state where they're more for their own sake. Not a technical
problem. Nothing one being in the role of software engieers should care
about - the best thing one can do at that point is to ignore this
beaurocrazy and focus on technological excellence.

I'm not saying we IT folks / SW engineers shouldn't take care of
management processes - in the contrary, we should actually work on
improving them. But we can only do that when we're asked to do so and
put in control of these processes - which, unfortunately, rarely
happens.

>> Now we're getting to the vital point: trying to make "universal"
>> binaries for verious different distros. This is something I'm strictly
>> advising against since 25 years, because with that you're putting
>> yourself into *a lot* trouble (ABI compatibility between arbitrary
>> distros or even various distro releases always had been pretty much a
>> myth, only works for some specific cases). Just don't do it, unless you
>> *really* don't have any other chance.
> 
> Well, that's the point, isn't it? Are we ready to call this use-case not
> valid, so it can't be used to support the argument of a solution that needs to
> be deployable to old distros?

Almost. The solution is simple: software needs to be built for the
distro, using the distro's build/packaging toolchain. And if some
particular distro is yet missing something (e.g. a more recent
compiler), just add it.

It's actually not hard, as soon we get out of our inhouse bubbles and
act as a community, actively cooperating with each other. Yet another
not technical, but a social problem.

>> My proposal would an conditional jump opcode that directly checks for
>> specific features. If this is well designed, I believe that can be
>> resolved by the cpu's internal prefetcher unit. But for that we'd also
>> need some extra task status bit so the cpu knows it is enabled for the
>> current task.
> 
> That's more of a "can I use this now", instead of "can I use this ever". So
> far, the answer to the two has been the same. Therefore, there has been no
> need to have the functionality that you're describing.

Not quite. There's a wide range between "now" and "ever". Yes, AMX is a
much harder problem since extra state needs to be stored on context
switches. If I'd would be designing a completely new CPU, I'd make sure
that those things don't cause any trouble at all (as Burroughs already
did in the 70th).

But yes, that's quite academical, unless we had a chance to actually
discuss with the CPU designers and influence their decisions.

>> But over all these years, new some registers have been introduced.
>> I fail to imagine how context switches can be done properly w/o also
>> saving/restoring such new registers.
> 
> There have been a few small registers and state that need to be saved here and
> there, but the biggest blocks were:
> 
> - SSE state
> - AVX state
> - AVX512 state
> - AMX state
> 
> The first two were small enough (and long enough ago) that the discussions
> were small and aren't relevant today. The AVX512 state was added in the past
> decade. And as you've seen from this thread, that is still a sticky point, and
> that was only about 1.5 kB.

Yes, so we see the problem isn't new. I'm feeling very sad about the
CPU designers not just repeating those mistakes but now even worse. And
they don't even discuss with us SW engineers first :(

If I had been asked by them, I'd basically recommended a dedicated TPU.
(along with a very long list of other points)


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
