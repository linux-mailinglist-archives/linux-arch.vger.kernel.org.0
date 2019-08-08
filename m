Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88028670C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfHHQ1H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 12:27:07 -0400
Received: from foss.arm.com ([217.140.110.172]:35818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728825AbfHHQ1H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 12:27:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 605471596;
        Thu,  8 Aug 2019 09:27:06 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BCCE3F706;
        Thu,  8 Aug 2019 09:27:04 -0700 (PDT)
Date:   Thu, 8 Aug 2019 17:27:02 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v7 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190808162702.GJ10425@arm.com>
References: <20190807155321.9648-1-catalin.marinas@arm.com>
 <20190807155321.9648-2-catalin.marinas@arm.com>
 <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826a9ace-feac-c019-843e-07e23c9fd46c@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 07, 2019 at 01:38:16PM -0700, Dave Hansen wrote:

[Random comments below on a couple of points]

> On 8/7/19 8:53 AM, Catalin Marinas wrote:
> > +- mmap() done by the process itself (or its parent), where either:
> > +
> > +  - flags have the **MAP_ANONYMOUS** bit set
> > +  - the file descriptor refers to a regular file (including those returned
> > +    by memfd_create()) or **/dev/zero**
> 
> What's a "regular file"? ;)

A file, as distinct from device nodes, sockets, symlinks etc.

I think this is fairly standard UNIX terminology, even though it sounds
vague:

From glibc's <bits/stat.h>:

#define	__S_IFREG	0100000	/* Regular file.  */


Or for POSIX test (a.k.a. "[")

       -f file
              True if file exists and is a regular file.

Using memfd_create() or opening /dev/zero doesn't yield a regular file
though, so perhaps those should be a separate bullet.

[...]

> > +The AArch64 Tagged Address ABI is an opt-in feature and an application can
> > +control it via **prctl()** as follows:
> > +
> > +- **PR_SET_TAGGED_ADDR_CTRL**: enable or disable the AArch64 Tagged Address
> > +  ABI for the calling process.
> > +
> > +  The (unsigned int) arg2 argument is a bit mask describing the control mode
> > +  used:
> > +
> > +  - **PR_TAGGED_ADDR_ENABLE**: enable AArch64 Tagged Address ABI. Default
> > +    status is disabled.
> > +
> > +  The arguments arg3, arg4, and arg5 are ignored.
> 
> For previous prctl()'s, we've found that it's best to require that the
> unused arguments be 0.  Without that, apps are free to put garbage
> there, which makes extending the prctl to use other arguments impossible
> in the future.

Because arg2 is already a mask of flags with some flags unallocated,
we can add a new flag for ABI extensions.

If arg3 is used someday, it may or may not be natural for 0 to mean
"default".  Enabling this argument with an explicit flag in arg2 may
be cleaner than mangling the semantics of arg3 so that 0 can have
the right meaning.

Avoiding redundant 0 arguments also allows userspace to take advantage
of the glibc's variadic prototype for prctl() for example.

Not a huge deal, but that was my rationale anyway.

> Also, shouldn't this be converted over to an arch_prctl()?

Most arch-specific prctls seem to use prctl(), and arm64 already has a
few there.

arch_prctl() is x86-specific.  I don't know the history.

[...]

Cheers
---Dave
