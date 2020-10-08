Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306C5287D80
	for <lists+linux-arch@lfdr.de>; Thu,  8 Oct 2020 22:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgJHUxo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Oct 2020 16:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJHUxo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Oct 2020 16:53:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38190C0613D2
        for <linux-arch@vger.kernel.org>; Thu,  8 Oct 2020 13:53:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d24so4281142ljg.10
        for <linux-arch@vger.kernel.org>; Thu, 08 Oct 2020 13:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PKIFmls6pCBrUR8Zpcbb9k/xspAeUfkoaewtC93wQFs=;
        b=I/3McJXIRSI3gUclgrhJmQkUKYAnSpq+vsO2iyVah5ZD6+FKl3G5yWJ36ubycwDikk
         jax+8dWP3F5/aNpdKmTXjHcKX+ZJDJXcbsR9utDeHEW8c5LIH/qijVDERkxquJUm2RU6
         eVF8RycVMrawr2RhkZpulCxJKWRf9O1+PTjYCZvqiJ7O8zvWlhl/GRcAvtDWWxG9ID9r
         LRXti4MoqesPd2jWkdsxKFkM3aEEBsdxvoD+bqGILCN9Aj31gO09TbhE8RjUBJeR4WDQ
         NiAuHbQLPnKqssIE/WKas+fF9qEPUgrNaDFT0DncrTcLlRqM+0fHvdhA70JaMtEV9xPK
         wPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PKIFmls6pCBrUR8Zpcbb9k/xspAeUfkoaewtC93wQFs=;
        b=hF8QCEPqT82oYT7onB4VURohUJLmpjpk72F795RcmRn76cvjrZ8z93MhvghLydCj85
         M/4XKdplO+zDtxUML8shsK9rfdIxjAwUMfX8iuAHU2DZAlf8wN9VlZ/UoCY7roC2rqck
         7VqY5pist6sSW8RUgHxnarfI/NJuAbxnyR+sXDOVKj3RSpnlSMeAzs3jvYmLpKbUjJad
         PuC7fhzb82g4kueQBrrtGbmcS4/SdGe3iHOElpsua3k07LrmBu6z4e+gMnp1N3aYL4Yk
         cH5PNllnZZiriAknHhy2/K94Y5oB2skQesQe813FvpxPdeizPYaaw6Y+QMugKGnGd56O
         IUow==
X-Gm-Message-State: AOAM533g86UzYRI/pgG8UtMPASlFD0ao5XoC9KpcutW5T3VgiVlcyZgw
        SwcK71fjBz5GjU7MGePcLS0nyFgiiPsZxSUHuDo=
X-Google-Smtp-Source: ABdhPJz50xYJBB3ZfD0B6N6FNNcDbWJfoHd0fKaJIQ0ZCk9nW6xK1OQuUYYhH8yXFPbDPCl99GIKhg8Zl6VzwtWhao8=
X-Received: by 2002:a2e:a58c:: with SMTP id m12mr4337532ljp.378.1602190422517;
 Thu, 08 Oct 2020 13:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com> <d5df1b8807384a00f96e4b02d41a37183fad5562.1601960644.git.thehajime@gmail.com>
 <0ed761fbe77f9858244ee2ffbf3e700d7df78418.camel@sipsolutions.net>
 <CAMoF9u1XX6gJpPfUh-6hmh1RNosn+=GUf75FQsMoxacrP=f7jg@mail.gmail.com> <1b271e1bca9852bebc2d67c6aada25f7ce1a7240.camel@sipsolutions.net>
In-Reply-To: <1b271e1bca9852bebc2d67c6aada25f7ce1a7240.camel@sipsolutions.net>
From:   Octavian Purdila <tavi.purdila@gmail.com>
Date:   Thu, 8 Oct 2020 23:53:31 +0300
Message-ID: <CAMoF9u2Fc2s1uitk3D3osgq1XByebxUTirq4SROcMZg9kJ_Gfw@mail.gmail.com>
Subject: Re: [RFC v7 03/21] um: move arch/um/os-Linux dir to tools/um/uml
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Hajime Tazaki <thehajime@gmail.com>,
        linux-um <linux-um@lists.infradead.org>, jdike@addtoit.com,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-kernel-library <linux-kernel-library@freelists.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Akira Moroo <retrage01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 8, 2020 at 10:46 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Thu, 2020-10-08 at 20:48 +0300, Octavian Purdila wrote:
>
> > > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > > This patch moves underlying OS dependent part under arch/um to tools/um
> > > > directory so that arch/um code does not need to build host build
> > > > facilities (e.g., libc).
> > >
> > > Hmm. On the one hand, that build separation seems sensible, but on the
> > > other hand this stuff *does* fundamentally belong to arch/um/, and it's
> > > not a "tool" like basically everything else there that is a pure
> > > userspace application to run *inside* the kernel, not *part of* it.
> > >
> > > For that reason, I don't really like this much.
> > >
> >
> > I see the os_*() calls as dependencies that the kernel uses. Sort of
> > like calls into the hypervisor or firmware.
>
> Right.
>
> > The current UML build is already partially split. USER_OBJS build with
> > a different rule set than the rest of the kernel objects.
>
> Yes, that's true.
>
> > IMHO this
> > change just makes this more clear and streamlined, especially with
> > regard to linking.
>
> Well, maybe? But I actually tend to see this less as a question of
> (technical) convenience but semantics, and the tools are just not
> *meant* to be things that build a kernel, they're things to be used
> inside that kernel.
>
> I dunno. Maybe the technical convenience should win, but OTOH the
> "contortions" that UML build goes through with USER_OBJS don't really
> seem bad enough to merit breaking the notion of what tools are?
>

Half-joking, technically uml is not a kernel, it is a tool that
simulates a kernel and it uses part of the Linux kernel to do that :)

> > We are using the same build system as the rest of the stuff in tools.
> > Since it is building programs and libraries and not part of the kernel
> > binary build, it is using a slightly different infrastructure, which
> > is detailed in tools/build/Documentation/Build.txt
>
> OK, thanks for the pointer, I hadn't seen that before.
>
> > The reason for picking tools was that it already has the
> > infrastructure to build programs and shared libraries and the fact
> > that it is the only place in the kernel source tree where code is not
> > built directly into the kernel binary.
>
> Yeah, but all of UML/LKL _is_ eventually built into the kernel binary
> (or library as it may be). Which is in a way exactly my objection.
>

Leaving the library/standalone build itself aside for a while, do you
agree that the various tools we are building with library mode should
be placed in tools? Things like lklfuse - mounting Linux filesystems
with fuse, or lklhijack.so - a preload library that intercept
network/file system calls and routes them through the library mode.

> You're looking at it the other way around I think - it seems that you're
> thinking the kernel binary is the vmlinux.a, and that's what the
> kernel's build system worries about; then the "vmlinux.so" (library
> mode) or "linux" (standalone mode - perhaps that's a good name?) is the
> eventual 'tool' that we build, using the previously built vmlinux.a.
>

Correct, this is my perspective.

> But that really isn't how standalone mode works, and IMHO it also
> doesn't match what tools are today.
>

What if we could use standalone mode for other purposes that would
require creating a new binary in addition to the current linux binary?
