Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84A83DDE10
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 18:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhHBQzU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 12:55:20 -0400
Received: from gate.crashing.org ([63.228.1.57]:44987 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232056AbhHBQzU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Aug 2021 12:55:20 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 172GlmVS025072;
        Mon, 2 Aug 2021 11:47:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 172Gllk1025071;
        Mon, 2 Aug 2021 11:47:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 2 Aug 2021 11:47:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] isystem: delete global -isystem compile option
Message-ID: <20210802164747.GN1583@gate.crashing.org>
References: <20210801201336.2224111-1-adobriyan@gmail.com> <20210801201336.2224111-3-adobriyan@gmail.com> <20210801213247.GM1583@gate.crashing.org> <YQeT5QRXc3CzK9nL@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQeT5QRXc3CzK9nL@localhost.localdomain>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 02, 2021 at 09:42:45AM +0300, Alexey Dobriyan wrote:
> On Sun, Aug 01, 2021 at 04:32:47PM -0500, Segher Boessenkool wrote:
> > On Sun, Aug 01, 2021 at 11:13:36PM +0300, Alexey Dobriyan wrote:
> > > In theory, it enables "leakage" of userspace headers into kernel which
> > > may present licensing problem.
> > 
> > > -NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
> > > +NOSTDINC_FLAGS += -nostdinc
> > 
> > This is removing the compiler's own include files.  These are required
> > for all kinds of basic features, and required to be compliant to the C
> > standard at all.
> 
> No they are not required.

This is false, they *are* required, whenever you want to use these
features.  If you do not include the required headers you get undefined
behaviour.

> Kernel uses its own bool, uintptr_t and
> static_assert, memset(), CHAR_BIT.

Yes, and it occasionally gets it wrong.  Great fun.  See c46bbf5d2def
for the latest episode in this saga.  (Yes I know this is uapi so maybe
not the best example here, but it isn't like the kernel gets such things
wrong so often these days ;-) )

The kernel *cannot* make up its own types for this.  It has to use the
types it is required to use (by C, by the ABIs, etc.)  So why
reimplement this?

> noreturn, alignas newest C standard
> are next.

What is wrong with <stdalign.h> and <stdnoreturn.h>?

> This version changelog didn't mention but kernel would use
> -ffreestanding too if not other problems with the flag.

It is still true for freestanding C implementations, you just get a
severely reduced standard library,

> > These are not "userspace headers", that is what
> > -nostdinc takes care of already.
> 
> They are userspace headers in the sense they are external to the project
> just like userspace programs are external to the kernel.

So you are going to rewrite all of the rest of GCC inside the kernel
project as well?

> > In the case of GCC all these headers are GPL-with-runtime-exception, so
> > claiming this can cause licensing problems is fearmongering.
> 
> I agree licensing problem doesn't really exist.
> It would take gcc drop-in replacement with authors insane enough to not
> license standard headers properly.

There does still not exist a drop-in replacement for GCC, not if you
look closely and/or rely on details (like the kernel does).  Some of the
differences are hidden by "linux/compiler-*.h", but hardly all.

> > I strongly advise against doing this.
> 
> Kernel chose to be self-contained.

That is largely historical, imo.  Nowadays this is less necessary.

Also, the kernel chose to *do* use the compiler include files.  It is
you who wants to abolish that here.

> -isystem removal makes sense then.

-nostdinc -isystem $(shell $(CC) -print-file-name=include)  makes sense
for that: you do indeed not want the userspace headers.  Maiming the
compiler (by removing some of its functional parts, namely, its generic
headers) does not make sense.

> It will be used for intrinsics where necessary.

Like, everywhere.


Segher
