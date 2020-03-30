Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519C71986CF
	for <lists+linux-arch@lfdr.de>; Mon, 30 Mar 2020 23:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgC3Vxv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 17:53:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43944 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgC3Vxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 17:53:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJ2Ls-00764A-KJ; Mon, 30 Mar 2020 23:53:48 +0200
Message-ID: <a84f3d7bcddbaa6125349c4bcdec6e3e07d6b783.camel@sipsolutions.net>
Subject: Re: [RFC v4 02/25] um lkl: architecture skeleton for Linux kernel
 library
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, Levente Kurusa <levex@linux.com>,
        Matthieu Coudron <mattator@gmail.com>,
        Conrad Meyer <cem@FreeBSD.org>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Jens Staal <staal1978@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        Yuan Liu <liuyuan@google.com>, Xiao Jia <xiaoj@google.com>,
        Mark Stillwell <mark@stillwell.me>,
        Patrick Collins <pscollins@google.com>,
        linux-kernel-library@freelists.org,
        Pierre-Hugues Husson <phh@phh.me>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Luca Dariz <luca.dariz@gmail.com>,
        "Edison M . Castro" <edisonmcastro@hotmail.com>
Date:   Mon, 30 Mar 2020 23:53:46 +0200
In-Reply-To: <dca6ea7260830a03c060f57e6ab9961f16ad55ed.1585579244.git.thehajime@gmail.com>
References: <cover.1585579244.git.thehajime@gmail.com>
         <dca6ea7260830a03c060f57e6ab9961f16ad55ed.1585579244.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 2020-03-30 at 23:45 +0900, Hajime Tazaki wrote:
> From: Octavian Purdila <tavi.purdila@gmail.com>
> 
> Adds the LKL Kconfig, vmlinux linker script, basic architecture
> headers and miscellaneous basic functions or stubs such as
> dump_stack(), show_regs() and cpuinfo proc ops.
> 
> The headers we introduce in this patch are simple wrappers to the
> asm-generic headers or stubs for things we don't support, such as
> ptrace, DMA, signals, ELF handling and low level processor operations.
> 
> The kernel configuration is automatically updated to reflect the
> endianness of the host, 64bit support or the output format for
> vmlinux's linker script. We do this by looking at the ld's default
> output format.

Can you elaborate what the plan is here?

I mean, you're not actually "unifying" anything with ARCH=um, you're
just basically splitting ARCH=um into ARCH=um-um and ARCH=um-lkl or
something. Is there much point?

Even the basic underlying building blocks are _very_ different, e.g. in
UML the host interface is just a bunch of functions that must be
implemented (os_*()), while you have a "struct lkl_host_operations". If
we can't even unify at that trivial level, is there any point in it at
all? I'm not even really sure what those ops are used for - are all of
those things that the *application* using LKL necessarily must provide?

Similarly with the IRQ routing mechanism - two completely different
concepts. Where's the "unifying"?

Ultimately, I can see two ways this goes:

1) We give up, and get ARCH=lkl, sharing just (some of) the drivers
   while moving them into the right drivers/somewhere/ place. Even that
   looks somewhat awkward looking at the later patches in this set, but
   seems like that at *least* should be done.

2) Ideally, instead, we actually unify: LKL grows support for userspace
   processes using UML infrastructure, the "in-kernel" IRQ mechanisms
   are unified, UML stuff moves into lkl-ops, and the UML binary
   basically becomes a user of the LKL library to start everything up.
   There may be some bits remaining that are just not interesting (e.g.
   some drivers you don't care about would continue to make direct calls
   to the user side instead of lkl-ops, and then they're just not
   compatible with lkl, only with the uml special case of lkl), but then
   things are clean.


Now, of course it seems like (2) would actually be better - LKL would
actually get support for userspace processes using UML's tricks, most of
the code is unified, and even LKL's users can take advantage of new
things. At the same time, all of the duplication is avoided.

However, I just don't know if it's actually _possible_ to do that
though. Conceptually, it seems like it should be - why shouldn't a
library be able to spawn other userspace processes - I mean, it's not
really in the model that LKL really _wants_ since it's supposed to offer
the syscall API, but you could make a "bool run_normal_init" or
something in the lkl-ops for the user of the library to determine what
should happen, right?

However, there clearly are huge differences between LKL and UML in all
respects, and I don't know if this wouldn't conflict with the library
model, e.g. there may be linker issues etc. Or maybe the specific UML
interrupt handling is required in UML and cannot be done in LKL (but
then perhaps it could be put into the hypothetical UML-application vs.
UML-the-LKL-library?)


Ultimately, personally I think it's going to have to be one or the other
of those two options though, I don't really see much value in what
you're doing here in the patchset now. This way just messes up
everything, it's not clear what's UML and what's LKL, and they're
intertwined with ifdefs everywhere; just look at where you have to add
ifdefs in patch 23 - how would anyone later understand which part gets
compiled for which of them?

johannes

PS: actually having something like lkl-ops in UML would've been nice
also for my "time-travel" work, since it neatly abstracts the timers
out. I do wonder a bit about the overhead of jumping through function
pointers all the time though, it may be worth rethinking that overall
anyway!

