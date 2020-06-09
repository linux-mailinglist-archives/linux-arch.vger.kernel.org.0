Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899741F3CC0
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 15:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgFINiU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 09:38:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728400AbgFINiS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 09:38:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A594A20760;
        Tue,  9 Jun 2020 13:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591709898;
        bh=f1sQCbbciaw4Ga3Y8vVZNl0kGnRv/j2g4lYw38F0/YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjPEk+zeq6u8nNYAMVt9OrcfHl0tBdqTdg98cN6OepIhyitfDJGoEOgC41/ZdoKrQ
         xya2vwUDONkAkNh5CpE0BYSs5fN94h5jLei4ehRj0Lg72Y/j6uN7irH4qfMt4fr1N+
         /72bbHfHZ/Y6wBC+sQ2SGnVlG/7k11doa8U25vN0=
Date:   Tue, 9 Jun 2020 14:38:13 +0100
From:   Will Deacon <will@kernel.org>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        andreyknvl@google.com
Subject: Re: [RFC PATCH v2 6/6] prctl.2: Add tagged address ABI control
 prctls (arm64)
Message-ID: <20200609133812.GA27794@willie-the-truck>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-7-git-send-email-Dave.Martin@arm.com>
 <88ac761e-64b3-e1e3-3cdc-1f413a6d69d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ac761e-64b3-e1e3-3cdc-1f413a6d69d6@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 09, 2020 at 01:04:25PM +0200, Michael Kerrisk (man-pages) wrote:
> Do we have any review comments for this (extensive!) patch from Dave?

(Adding Andrey, since he was involved with this ABI)

Regardless, it would be good to have Catalin's ack and I think he was
planning to take a look at this.

Will

> On 5/27/20 11:17 PM, Dave Martin wrote:
> > ** This patch is a draft for review and should not be applied before it
> >    has been discussed. **
> > 
> > Add documentation for the the PR_SET_TAGGED_ADDR_CTRL and
> > PR_GET_TAGGED_ADDR_CTRL prctls added in Linux 5.4 for arm64.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> > 
> >  man2/prctl.2 | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 156 insertions(+)
> > 
> > diff --git a/man2/prctl.2 b/man2/prctl.2
> > index 3ee2702..062fd51 100644
> > --- a/man2/prctl.2
> > +++ b/man2/prctl.2
> > @@ -1504,6 +1504,143 @@ For more information, see the kernel source file
> >  (or
> >  .I Documentation/arm64/sve.txt
> >  before Linux 5.3).
> > +.\" prctl PR_SET_TAGGED_ADDR_CTRL
> > +.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
> > +.TP
> > +.BR PR_SET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
> > +Controls support for passing tagged userspace addresses to the kernel
> > +(i.e., addresses where bits 56\(em63 are not all zero).
> > +.IP
> > +The level of support is selected by
> > +.IR "(unsigned int) arg2" ,
> > +which can be one of the following:
> > +.RS
> > +.TP
> > +.B 0
> > +Addresses that are passed
> > +for the purpose of being dereferenced by the kernel
> > +must be untagged.
> > +.TP
> > +.B PR_TAGGED_ADDR_ENABLE
> > +Addresses that are passed
> > +for the purpose of being dereferenced by the kernel
> > +may be tagged, with the exceptions summarized below.
> > +.RE
> > +.IP
> > +The remaining arguments
> > +.IR arg3 ", " arg4 " and " arg5
> > +must all be zero.
> > +.IP
> > +On success, the mode specified in
> > +.I arg2
> > +is set for the calling thread and the the return value is 0.
> > +If the arguments are invalid,
> > +the mode specified in
> > +.I arg2
> > +is unrecognized,
> > +or if this feature is disabled or unsupported by the kernel,
> > +the call fails with
> > +.BR EINVAL .
> > +.IP
> > +In particular, if
> > +.BR prctl ( PR_SET_TAGGED_ADDR_CTRL ,
> > +0, 0, 0, 0)
> > +fails with
> > +.B EINVAL
> > +then all addresses passed to the kernel must be untagged.
> > +.IP
> > +Irrespective of which mode is set,
> > +addresses passed to certain interfaces
> > +must always be untagged:
> > +.RS
> > +.IP \(em
> > +.BR brk (2),
> > +.BR mmap (2),
> > +.BR shmat (2),
> > +and the
> > +.I new_address
> > +argument of
> > +.BR mremap (2).
> > +.IP
> > +(Prior to Linux 5.6 these accepted tagged addresses,
> > +but the behaviour may not be what you expect.
> > +Don't rely on it.)
> > +.IP \(em
> > +\(oqpolymorphic\(cq interfaces
> > +that accept pointers to arbitrary types cast to a
> > +.I void *
> > +or other generic type, specifically
> > +.BR prctl (2),
> > +.BR ioctl (2),
> > +and in general
> > +.BR setsockopt (2)
> > +(only certain specific
> > +.BR setsockopt (2)
> > +options allow tagged addresses).
> > +.IP \(em
> > +.BR shmdt (2).
> > +.RE
> > +.IP
> > +This list of exclusions may shrink
> > +when moving from one kernel version to a later kernel version.
> > +While the kernel may make some guarantees
> > +for backwards compatibility reasons,
> > +for the purposes of new software
> > +the effect of passing tagged addresses to these interfaces
> > +is unspecified.
> > +.IP
> > +The mode set by this call is inherited across
> > +.BR fork (2)
> > +and
> > +.BR clone (2).
> > +The mode is reset by
> > +.BR execve (2)
> > +to 0
> > +(i.e., tagged addresses not permitted in the user/kernel ABI).
> > +.IP
> > +.B Warning:
> > +Because the compiler or run-time environment
> > +may make use of address tagging,
> > +a successful
> > +.B PR_SET_TAGGED_ADDR_CTRL
> > +may crash the calling process.
> > +The conditions for using it safely are complex and system-dependent.
> > +Don't use it unless you know what you are doing.
> > +.IP
> > +For more information, see the kernel source file
> > +.IR Documentation/arm64/tagged\-address\-abi.rst .
> > +.\" prctl PR_GET_TAGGED_ADDR_CTRL
> > +.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
> > +.TP
> > +.BR PR_GET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
> > +Returns the current tagged address mode
> > +for the calling thread.
> > +.IP
> > +Arguments
> > +.IR arg2 ", " arg3 ", " arg4 " and " arg5
> > +must all be zero.
> > +.IP
> > +If the arguments are invalid
> > +or this feature is disabled or unsupported by the kernel,
> > +the call fails with
> > +.BR EINVAL .
> > +In particular, if
> > +.BR prctl ( PR_GET_TAGGED_ADDR_CTRL ,
> > +0, 0, 0, 0)
> > +fails with
> > +.BR EINVAL ,
> > +then this feature is definitely unsupported or disabled,
> > +and all addresses passed to the kernel must be untagged.
> > +.IP
> > +Otherwise, the call returns a nonnegative value
> > +describing the current tagged address mode,
> > +encoded in the same way as the
> > +.I arg2
> > +argument of
> > +.BR PR_SET_TAGGED_ADDR_CTRL .
> > +.IP
> > +For more information, see the kernel source file
> > +.IR Documentation/arm64/tagged\-address\-abi.rst .
> >  .\"
> >  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
> >  .TP
> > @@ -1749,6 +1886,7 @@ On success,
> >  .BR PR_GET_SPECULATION_CTRL ,
> >  .BR PR_SVE_GET_VL ,
> >  .BR PR_SVE_SET_VL ,
> > +.BR PR_GET_TAGGED_ADDR_CTRL ,
> >  .BR PR_GET_THP_DISABLE ,
> >  .BR PR_GET_TIMING ,
> >  .BR PR_GET_TIMERSLACK ,
> > @@ -2057,6 +2195,24 @@ is
> >  .B PR_SVE_GET_VL
> >  and SVE is not available on this platform.
> >  .TP
> > +.B EINVAL
> > +.I option
> > +is
> > +.BR PR_SET_TAGGED_ADDR_CTRL
> > +and the arguments are invalid or unsupported.
> > +See the description of
> > +.B PR_SET_TAGGED_ADDR_CTRL
> > +above for details.
> > +.TP
> > +.B EINVAL
> > +.I option
> > +is
> > +.BR PR_GET_TAGGED_ADDR_CTRL
> > +and the arguments are invalid or unsupported.
> > +See the description of
> > +.B PR_GET_TAGGED_ADDR_CTRL
> > +above for details.
> > +.TP
> >  .B ENODEV
> >  .I option
> >  was
> > 
> 
> 
> -- 
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/
