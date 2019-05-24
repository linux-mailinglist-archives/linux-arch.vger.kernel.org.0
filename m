Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87D129C53
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 18:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbfEXQbP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 12:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390392AbfEXQbP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 12:31:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DF3C581122;
        Fri, 24 May 2019 16:31:09 +0000 (UTC)
Received: from treble (ovpn-121-106.rdu2.redhat.com [10.10.121.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9365210027BC;
        Fri, 24 May 2019 16:31:06 +0000 (UTC)
Date:   Fri, 24 May 2019 11:31:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, guillaume.gardet@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Jessica Yu <jeyu@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] module/ksymtab: use 64-bit relative reference for target
 symbol
Message-ID: <20190524163104.o6xh54x4ngbihneb@treble>
References: <20190522150239.19314-1-ard.biesheuvel@arm.com>
 <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com>
 <f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com>
 <20190523091811.GA26646@fuggles.cambridge.arm.com>
 <907a9681-cd1d-3326-e3dd-5f6965497720@arm.com>
 <20190524152045.w3syntzp4bb5jb7u@treble>
 <CAKv+Gu9DLf9y2uqTo407gLK3AX3pq+HGFxytsoR9C2zfGdUc-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9DLf9y2uqTo407gLK3AX3pq+HGFxytsoR9C2zfGdUc-A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 24 May 2019 16:31:15 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 24, 2019 at 05:55:37PM +0200, Ard Biesheuvel wrote:
> On Fri, 24 May 2019 at 17:21, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Thu, May 23, 2019 at 10:29:39AM +0100, Ard Biesheuvel wrote:
> > >
> > >
> > > On 5/23/19 10:18 AM, Will Deacon wrote:
> > > > On Thu, May 23, 2019 at 09:41:40AM +0100, Ard Biesheuvel wrote:
> > > > >
> > > > >
> > > > > On 5/22/19 5:28 PM, Ard Biesheuvel wrote:
> > > > > >
> > > > > >
> > > > > > On 5/22/19 4:02 PM, Ard Biesheuvel wrote:
> > > > > > > The following commit
> > > > > > >
> > > > > > >     7290d5809571 ("module: use relative references for __ksymtab entries")
> > > > > > >
> > > > > > > updated the ksymtab handling of some KASLR capable architectures
> > > > > > > so that ksymtab entries are emitted as pairs of 32-bit relative
> > > > > > > references. This reduces the size of the entries, but more
> > > > > > > importantly, it gets rid of statically assigned absolute
> > > > > > > addresses, which require fixing up at boot time if the kernel
> > > > > > > is self relocating (which takes a 24 byte RELA entry for each
> > > > > > > member of the ksymtab struct).
> > > > > > >
> > > > > > > Since ksymtab entries are always part of the same module as the
> > > > > > > symbol they export (or of the core kernel), it was assumed at the
> > > > > > > time that a 32-bit relative reference is always sufficient to
> > > > > > > capture the offset between a ksymtab entry and its target symbol.
> > > > > > >
> > > > > > > Unfortunately, this is not always true: in the case of per-CPU
> > > > > > > variables, a per-CPU variable's base address (which usually differs
> > > > > > > from the actual address of any of its per-CPU copies) could be at
> > > > > > > an arbitrary offset from the ksymtab entry, and so it may be out
> > > > > > > of range for a 32-bit relative reference.
> > > > > > >
> > > > >
> > > > > (Apologies for the 3-act monologue)
> > > >
> > > > Exposition, development and recapitulation ;)
> > > >
> > > > > This turns out to be incorrect. The symbol address of per-CPU variables
> > > > > exported by modules is always in the vicinity of __per_cpu_start, and so it
> > > > > is simply a matter of making sure that the core kernel is in range for
> > > > > module ksymtab entries containing 32-bit relative references.
> > > > >
> > > > > When running the arm64 with kaslr enabled, we currently randomize the module
> > > > > space based on the range of ADRP/ADD instruction pairs, which have a -/+ 4
> > > > > GB range rather than the -/+ 2 GB range of 32-bit place relative data
> > > > > relocations. So we can fix this by simply reducing the randomization window
> > > > > to 2 GB.
> > > >
> > > > Makes sense. Do you see the need for an option to disable PREL relocs
> > > > altogether in case somebody wants the additional randomization range?
> > > >
> > >
> > > No, not really. To be honest, I don't think
> > > CONFIG_RANDOMIZE_MODULE_REGION_FULL is that useful to begin with, and the
> > > only reason we enabled it by default at the time was to ensure that the PLT
> > > code got some coverage after we introduced it.
> >
> > In code, percpu variables are accessed with absolute relocations, right?
> 
> No, they are accessed just like ordinary symbols, so PC32 references
> on x86 or ADRP/ADD references on arm64 are both quite common.

Ah, right, now I see some PC32 percpu references.

So if PC32 references are sufficient for code, why aren't they
sufficient for ksymtab entries?  Isn't the ksymtab data address closer
to the percpu data than the code?  Do you have an example of an out of
range ksymtab reference?

-- 
Josh
