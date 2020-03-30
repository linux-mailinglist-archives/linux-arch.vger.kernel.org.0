Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A88A19872B
	for <lists+linux-arch@lfdr.de>; Tue, 31 Mar 2020 00:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgC3WMx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Mar 2020 18:12:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52026 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgC3WMw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 18:12:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so497795wme.1
        for <linux-arch@vger.kernel.org>; Mon, 30 Mar 2020 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L38ZufUAeeWqGX3EMWl9gTrNlkwDK5WSvnGnXqaOY4c=;
        b=EjdirZ7oYqjE1/6bUUj1QakLJh+mphM2G3TJ+JY4GTI95XicMIEE6DooKZ4Lg/9qj+
         rRacN2UPTVt49/zglWtuvOdK0vfBmlyB4skljcWnk+wfc5N2XmMWUtvIxv9Fl5tNN7Z7
         LYHcFW/nJLH9R12Vo7FqBRcEawN1m9vps49c3ThcMAOwwyz+kEEdpld8RpnjXwuqrdNg
         DewNW6RnmJmNQJ1d3G2lOHOoXPfUpZZcDlo49GICjsxgA3IqHRlwPuJ1Wb/EhVqa3Ih5
         SZqrEyLsvs5iuNkLDP4H7aZVlIimIajVNX5shIybIsq/DEz4bpM1M9A+QpheS6FbpKxv
         VUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L38ZufUAeeWqGX3EMWl9gTrNlkwDK5WSvnGnXqaOY4c=;
        b=SoE2GZ9EsyPMWlaYwWEunBcwVTlieqqwUOMjtZa+EQf0woYvXFrj1CJdXA1ZsTut7f
         R2c/FjMAVTfpXOPF1le0hQ8H6XpWaWQUMCwqj5YoScVQl53fsCxQaRbj+GrJZJG188Ps
         HfKPLg+K7QMUgX9znkVZOEeW+30svo2XsMshZbJ/Z9P+RVOu8v8HA+Go6TnfFAm9ikfi
         q4ihJW7Lek8a/dd2rjGoEGzOUuEZY7nrcQyhTQZpK2ND3IUKo5ekTf7W3I5tdTenNqv2
         q8ttoFTV61I4KZyY68KDWK+gppfW7a9cWjqWWUIekF3pWpR/Y6yn58pCJaVfzHq4juIL
         5T/Q==
X-Gm-Message-State: ANhLgQ2WUbvLCxWQUpYA/sIb02grzMIO75KWDTqZc11rLM3wWUzJM0WP
        4sS2icrdvRzFbPW3+CI+WMua7TT/dNJoVXDSYyw=
X-Google-Smtp-Source: ADFU+vsjAb67I2NV3ssiFq/RQxkrswg3Qlu0QTr/npjhyZXQiwL16smG26uxTQO6toQ0jENCHPUOhrdFpX5Y0L7lt64=
X-Received: by 2002:a05:600c:257:: with SMTP id 23mr207008wmj.155.1585606370369;
 Mon, 30 Mar 2020 15:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585579244.git.thehajime@gmail.com> <dca6ea7260830a03c060f57e6ab9961f16ad55ed.1585579244.git.thehajime@gmail.com>
 <a84f3d7bcddbaa6125349c4bcdec6e3e07d6b783.camel@sipsolutions.net>
In-Reply-To: <a84f3d7bcddbaa6125349c4bcdec6e3e07d6b783.camel@sipsolutions.net>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 31 Mar 2020 00:12:38 +0200
Message-ID: <CAFLxGvyFqXZSmMcD_=o81AHLzdM_u2iH8h412w7VZrxON7Ohig@mail.gmail.com>
Subject: Re: [RFC v4 02/25] um lkl: architecture skeleton for Linux kernel library
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Levente Kurusa <levex@linux.com>,
        Matthieu Coudron <mattator@gmail.com>,
        Conrad Meyer <cem@freebsd.org>,
        Octavian Purdila <tavi.purdila@gmail.com>,
        Jens Staal <staal1978@gmail.com>,
        Motomu Utsumi <motomuman@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        Petros Angelatos <petrosagg@gmail.com>,
        "Edison M . Castro" <edisonmcastro@hotmail.com>,
        Xiao Jia <xiaoj@google.com>,
        Mark Stillwell <mark@stillwell.me>,
        linux-kernel-library@freelists.org,
        Patrick Collins <pscollins@google.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Michael Zimmermann <sigmaepsilon92@gmail.com>,
        Luca Dariz <luca.dariz@gmail.com>,
        Yuan Liu <liuyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Johannes, Hajime,

On Mon, Mar 30, 2020 at 11:53 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> On Mon, 2020-03-30 at 23:45 +0900, Hajime Tazaki wrote:
> > From: Octavian Purdila <tavi.purdila@gmail.com>
> >
> > Adds the LKL Kconfig, vmlinux linker script, basic architecture
> > headers and miscellaneous basic functions or stubs such as
> > dump_stack(), show_regs() and cpuinfo proc ops.
> >
> > The headers we introduce in this patch are simple wrappers to the
> > asm-generic headers or stubs for things we don't support, such as
> > ptrace, DMA, signals, ELF handling and low level processor operations.
> >
> > The kernel configuration is automatically updated to reflect the
> > endianness of the host, 64bit support or the output format for
> > vmlinux's linker script. We do this by looking at the ld's default
> > output format.
>
> Can you elaborate what the plan is here?
>
> I mean, you're not actually "unifying" anything with ARCH=um, you're
> just basically splitting ARCH=um into ARCH=um-um and ARCH=um-lkl or
> something. Is there much point?
>
> Even the basic underlying building blocks are _very_ different, e.g. in
> UML the host interface is just a bunch of functions that must be
> implemented (os_*()), while you have a "struct lkl_host_operations". If
> we can't even unify at that trivial level, is there any point in it at
> all? I'm not even really sure what those ops are used for - are all of
> those things that the *application* using LKL necessarily must provide?
>
> Similarly with the IRQ routing mechanism - two completely different
> concepts. Where's the "unifying"?
>
> Ultimately, I can see two ways this goes:
>
> 1) We give up, and get ARCH=lkl, sharing just (some of) the drivers
>    while moving them into the right drivers/somewhere/ place. Even that
>    looks somewhat awkward looking at the later patches in this set, but
>    seems like that at *least* should be done.

Yeah, this would be a goal.
UML and LKL are quite different but they should share at least their userspace
drivers.
I also don't mind if we don't share every driver at the beginning but
it should be
a feasible goal for the future.

> 2) Ideally, instead, we actually unify: LKL grows support for userspace
>    processes using UML infrastructure, the "in-kernel" IRQ mechanisms
>    are unified, UML stuff moves into lkl-ops, and the UML binary
>    basically becomes a user of the LKL library to start everything up.
>    There may be some bits remaining that are just not interesting (e.g.
>    some drivers you don't care about would continue to make direct calls
>    to the user side instead of lkl-ops, and then they're just not
>    compatible with lkl, only with the uml special case of lkl), but then
>    things are clean.

A few months ago I though this is doable but now I'm not so sure anymore.

>
> Now, of course it seems like (2) would actually be better - LKL would
> actually get support for userspace processes using UML's tricks, most of
> the code is unified, and even LKL's users can take advantage of new
> things. At the same time, all of the duplication is avoided.
>
> However, I just don't know if it's actually _possible_ to do that
> though. Conceptually, it seems like it should be - why shouldn't a
> library be able to spawn other userspace processes - I mean, it's not
> really in the model that LKL really _wants_ since it's supposed to offer
> the syscall API, but you could make a "bool run_normal_init" or
> something in the lkl-ops for the user of the library to determine what
> should happen, right?
>
> However, there clearly are huge differences between LKL and UML in all
> respects, and I don't know if this wouldn't conflict with the library
> model, e.g. there may be linker issues etc. Or maybe the specific UML
> interrupt handling is required in UML and cannot be done in LKL (but
> then perhaps it could be put into the hypothetical UML-application vs.
> UML-the-LKL-library?)
>
>
> Ultimately, personally I think it's going to have to be one or the other
> of those two options though, I don't really see much value in what
> you're doing here in the patchset now. This way just messes up
> everything, it's not clear what's UML and what's LKL, and they're
> intertwined with ifdefs everywhere; just look at where you have to add
> ifdefs in patch 23 - how would anyone later understand which part gets
> compiled for which of them?
>
> johannes
>
> PS: actually having something like lkl-ops in UML would've been nice
> also for my "time-travel" work, since it neatly abstracts the timers
> out. I do wonder a bit about the overhead of jumping through function
> pointers all the time though, it may be worth rethinking that overall
> anyway!

Agreed. UML can also learn from LKL. :-)

-- 
Thanks,
//richard
