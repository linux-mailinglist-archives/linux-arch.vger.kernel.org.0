Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091DC3B8656
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 17:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhF3PjV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 11:39:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:21005 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235828AbhF3PjV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Jun 2021 11:39:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="205360956"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="205360956"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 08:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558333551"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 08:36:47 -0700
Received: from tjmaciei-mobl1.localnet (10.209.13.190) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 30 Jun 2021 16:36:45 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     <fweimer@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Wed, 30 Jun 2021 08:29:14 -0700
Message-ID: <7070437.BNXKksOFrS@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <e07294c9-b02a-e1c5-3620-7fae7269fdf1@metux.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <2379132.fg5cGID6mU@tjmaciei-mobl1> <e07294c9-b02a-e1c5-3620-7fae7269fdf1@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.209.13.190]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wednesday, 30 June 2021 07:32:29 PDT Enrico Weigelt, metux IT consult 
wrote:
> What does "buy-in" mean in that context ? Some other departement ? Some
> external developers ?
> 
> I tend to believe that those things should better be done by some
> independent party, maybe GNU, FSF, etc, and cpu vendors should just
> sponsor this work and provide necessary specs.

For me specifically, I need to identify some SW dept. that would take on the 
responsibility for it long-term. Abandonware would serve no one.

I wouldn't mind this were a collaborative project under the auspices of 
freedesktop.org or similar, so long as it is cross-platform to at least macOS, 
FreeBSD and Windows. But given that this is in Intel's interest for this 
library to exist and make it easy for people to use our CPU features, it 
seemed like a natural fit for Intel. And even if it isn't an Intel-owned 
project, we probably want to be contributors.

> Shipping precompiled binaries and linking against system libraries is
> always a risky game. The cleanest approach here IMHO would be building
> packages for various distros (means: using their toolchains / libs).
> This actually isn't as work intensive as it might sound - I'm doing this
> all the day and have a bunch of helpful tools for that.

I understand, but whether it is easier and better for 99% of the cases does 
not mean it is so for 100%. And most especially it does not guarantee that it 
will be used for everyone. For reasons real or not, there are precompiled 
binaries. Just see Google Chrome, for example.

> Licensing with glibc also isn't a serious problem here. All you need to
> do is be compliant with the LGPL. In short: publish all your patches to
> glibc, offer the license and link dynamically. Already done that a
> thousand times.

We can agree it's an additional hurdle, which will likely cause people to 
investigate a solution that doesn't require that hurdle.

> Wait a minute ... how long does it take from the architectural design,
> until the real silicon is out in the field ? I would be very surprised
> whether the whole process in done in a much shorted time frame.
> 
> Note: by "much more early", I meant already at the point where the spec
> of the new feature exists, at least on paper.

I'm not going to comment on the timing of architectural decisions. But just 
from the example I gave: in order to be ready for a late 2021 or early 2022 
launch, we'd need to have the feature's specification published and the 
patches accepted by December 2018. That's about 3 years lead time.

How many software projects (let alone mixed software and hardware) do you know 
that know 3 years ahead of time what they will need?

>  > Then there are Linux distros that do LTS every 2 years or so.
> 
> Why don't the few actually affected parties just upgrade their compiler
> on their build machines when needed ?

Have you tried?

Besides, the whole problem here is barrier of entry. If we don't make it easy 
for them to use the new features, they won't. And I was using this as an 
argument for why precompiled binaries will exist: the interested parties will 
take the pain to upgrade the compilers and other supporting software so that 
the build even of Open Source software is the most capable one, then release 
that binary for others who haven't. This lowers the barrier of entry 
significantly.

And this is all to justify that such a functionality shouldn't be part of 
glibc, where it can't be used by those precompiled binaries which, for one 
reason or another, will exist.

It should be in a small, permissively-licensed library that will often get 
statically linked into the binary in question.

> > To compile the software that uses those instructions, undoubtedly. But
> > what if I did that for you and you could simply download the binary for
> > the library and/or plugins such that you could slot into your existing
> > systems and CI? This could make a difference between adoption or not.
> 
> For me, it wouldn't, at all. I never download binaries from untrusted
> sources. (except for forensic analysis).

I understand and I am, myself, almost like you. I do have some precompiled 
binaries (aforementioned Google Chrome), but as a rule I avoid them.

But not everyone is like the two of us.

> BUT: we're talking about about brand new silicon here. Why should
> anybody - who really needs these new features - install such an ancient
> OS on a brand new machine ?

I don't know. It might be for fleet homogeneity: everything has the same SW 
installed, facilitating maintenance. Just coming up with reasons.

> > Even if they don't, the *software* that people deploy may be the same
> > build
> > for RHEL 7 and for a modern distro that will have a 5.14 kernel.
> 
> Now we're getting to the vital point: trying to make "universal"
> binaries for verious different distros. This is something I'm strictly
> advising against since 25 years, because with that you're putting
> yourself into *a lot* trouble (ABI compatibility between arbitrary
> distros or even various distro releases always had been pretty much a
> myth, only works for some specific cases). Just don't do it, unless you
> *really* don't have any other chance.

Well, that's the point, isn't it? Are we ready to call this use-case not 
valid, so it can't be used to support the argument of a solution that needs to 
be deployable to old distros?

> > So my point is: this shouldn't be in glibc because the glibc will not have
> > the new system call wrappers or TLS fields.
> 
> Yes, I'm fully on your side here. Glibc already is overloaded with too
> much of those kind of things that shouldn't belong in there. Actually,
> even stuff like DNS resolving IMHO doensn't belong into libc.

Thanks.

(name resolving is required by POSIX to be there, so it exists in every 
system; might as well be every libc)

> My proposal would an conditional jump opcode that directly checks for
> specific features. If this is well designed, I believe that can be
> resolved by the cpu's internal prefetcher unit. But for that we'd also
> need some extra task status bit so the cpu knows it is enabled for the
> current task.

That's more of a "can I use this now", instead of "can I use this ever". So 
far, the answer to the two has been the same. Therefore, there has been no 
need to have the functionality that you're describing.

> > For most features, there isn't. You don't see us discussing
> > AVX512VP2INTERSECT, for example. This discussion only exists because AMX
> > requires more state to be saved during context switches and signal
> > delivery.
> But over all these years, new some registers have been introduced.
> I fail to imagine how context switches can be done properly w/o also
> saving/restoring such new registers.

There have been a few small registers and state that need to be saved here and 
there, but the biggest blocks were:

- SSE state
- AVX state
- AVX512 state
- AMX state

The first two were small enough (and long enough ago) that the discussions 
were small and aren't relevant today. The AVX512 state was added in the past 
decade. And as you've seen from this thread, that is still a sticky point, and 
that was only about 1.5 kB.

However, the vast majority of CPU features do not add new context state.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



