Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E071F3DAD
	for <lists+linux-arch@lfdr.de>; Tue,  9 Jun 2020 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgFIOLw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Jun 2020 10:11:52 -0400
Received: from foss.arm.com ([217.140.110.172]:43026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgFIOLw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 9 Jun 2020 10:11:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FACE1FB;
        Tue,  9 Jun 2020 07:11:51 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41CEE3F66F;
        Tue,  9 Jun 2020 07:11:50 -0700 (PDT)
Date:   Tue, 9 Jun 2020 15:11:42 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 4/6] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200609140948.GA25945@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-5-git-send-email-Dave.Martin@arm.com>
 <20200609095734.GA25362@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609095734.GA25362@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 09, 2020 at 10:57:35AM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Wed, May 27, 2020 at 10:17:36PM +0100, Dave Martin wrote:
> > Add documentation for the the PR_SVE_SET_VL and PR_SVE_GET_VL
> > prctls added in Linux 4.15 for arm64.
> 
> Looks really good to me, thanks. Just a few comments inline.
> 
> > diff --git a/man2/prctl.2 b/man2/prctl.2
> > index cab9915..91df7c8 100644
> > --- a/man2/prctl.2
> > +++ b/man2/prctl.2
> > @@ -1291,6 +1291,148 @@ call failing with the error
> >  .BR ENXIO .
> >  For further details, see the kernel source file
> >  .IR Documentation/admin\-guide/kernel\-parameters.txt .
> > +.\" prctl PR_SVE_SET_VL
> > +.\" commit 2d2123bc7c7f843aa9db87720de159a049839862
> > +.\" linux-5.6/Documentation/arm64/sve.rst
> > +.TP
> > +.BR PR_SVE_SET_VL " (since Linux 4.15, only on arm64)"
> > +Configure the thread's SVE vector length,
> > +as specified by
> > +.IR "(int) arg2" .
> > +Arguments
> > +.IR arg3 ", " arg4 " and " arg5
> > +are ignored.
> > +.IP
> > +The bits of
> > +.I arg2
> > +corresponding to
> > +.B PR_SVE_VL_LEN_MASK
> > +must be set to the desired vector length in bytes.
> > +This is interpreted as an upper bound:
> > +the kernel will select the greatest available vector length
> > +that does not exceed the value specified.
> > +In particular, specifying
> > +.B SVE_VL_MAX
> > +(defined in
> > +.I <asm/sigcontext.h>)
> > +for the
> > +.B PR_SVE_VL_LEN_MASK
> > +bits requests the maximum supported vector length.
> > +.IP
> > +In addition,
> > +.I arg2
> > +must be set to one of the following combinations of flags:
> 
> How about saying:
> 
>   In addition, the other bits of arg2 must be set according to the following
>   combinations of flags:
> 
> Otherwise I find it a bit fiddly to read, because it's valid to have
> flags of 0 and a non-zero length.

0 is listed, so I hoped that was clear enough.

Maybe just write "must be one of the following values:"?

0 is a value, but I can see why you might be uneasy about 0 being
described as a "combination of flags".

> > +.RS
> > +.TP
> > +.B 0
> > +Perform the change immediately.
> > +At the next
> > +.BR execve (2)
> > +in the thread,
> > +the vector length will be reset to the value configured in
> > +.IR /proc/sys/abi/sve_default_vector_length .
> 
> (implementation note: does this mean that 'sve_default_vl' should be
>  an atomic_t, as it can be accessed concurrently? We probably need
>  {READ,WRITE}_ONCE() at the very least, as I'm not seeing any locks
>  that help us here...)

Is this purely theoretical?  Can you point to what could go wrong?

While I doubt I thought about this very hard and I agree that you're
right in principle, I think there are probably non-atomic sysctls and
debugs files etc. all over the place.

I didn't want to clutter the code unnecessarily.

> > +.B PR_SVE_VL_INHERIT
> > +Perform the change immediately.
> > +Subsequent
> > +.BR execve (2)
> > +calls will preserve the new vector length.
> > +.TP
> > +.B PR_SVE_SET_VL_ONEXEC
> > +Defer the change, so that it is performed at the next
> > +.BR execve (2)
> > +in the thread.
> > +Further
> > +.BR execve (2)
> > +calls will reset the vector length to the value configured in
> > +.IR /proc/sys/abi/sve_default_vector_length .
> > +.TP
> > +.B "PR_SVE_SET_VL_ONEXEC | PR_SVE_VL_INHERIT"
> > +Defer the change, so that it is performed at the next
> > +.BR execve (2)
> > +in the thread.
> > +Further
> > +.BR execve (2)
> > +calls will preserve the new vector length.
> > +.RE
> > +.IP
> > +In all cases,
> > +any previously pending deferred change is canceled.
> > +.IP
> > +The call fails with error
> > +.B EINVAL
> > +if SVE is not supported on the platform, if
> > +.I arg2
> > +is unrecognized or invalid, or the value in the bits of
> > +.I arg2
> > +corresponding to
> > +.B PR_SVE_VL_LEN_MASK
> > +is outside the range
> > +.BR SVE_VL_MIN .. SVE_VL_MAX
> > +or is not a multiple of 16.
> > +.IP
> > +On success,
> > +a nonnegative value is returned that describes the
> > +.I selected
> > +configuration,
> 
> If I'm reading the kernel code correctly, this is slightly weird, as
> the returned value may contain the PR_SVE_VL_INHERIT flag but it will
> never contain the PR_SVE_SET_VL_ONEXEC flag. Is that right?

Yes, which is an oddity.

I suppose we could fake that up actually by returning that flag if
sve_vl and sve_vl_onexec are different, but we don't currently do this.

> If so, maybe just say something like:
> 
>   On success, a nonnegative value is returned that describes the selected
>   configuration in the same way as PR_SVE_GET_VL.

How does that help?  PR_SVE_GET_VL doesn't fully clarify the oddity you
call out anyway.

Really, I preferred not to have people relying on this one way or the
other.  The only sensible reason for an _ONEXEC is because you've
committed to calling execve().  On such a path, queryng the vector
length isn't likely to be useful.

Maybe I was optimistic.

> > +which may differ from the current configuration if
> > +.B PR_SVE_SET_VL_ONEXEC
> > +was specified.
> > +The value is encoded in the same way as the return value of
> > +.BR PR_SVE_GET_VL .
> > +.IP
> > +The configuration (including any pending deferred change)
> > +is inherited across
> > +.BR fork (2)
> > +and
> > +.BR clone (2).
> > +.IP
> > +.B Warning:
> > +Because the compiler or run-time environment
> > +may be using SVE, using this call without the
> > +.B PR_SVE_SET_VL_ONEXEC
> > +flag may crash the calling process.
> > +The conditions for using it safely are complex and system-dependent.
> > +Don't use it unless you really know what you are doing.
> > +.IP
> > +For more information, see the kernel source file
> > +.I Documentation/arm64/sve.rst
> > +.\"commit b693d0b372afb39432e1c49ad7b3454855bc6bed
> > +(or
> > +.I Documentation/arm64/sve.txt
> > +before Linux 5.3).
> 
> I think I'd drop the kernel reference here, as it feels like we're saying
> "only do this if you know what you're doing" on one hand, but then "if you
> don't know what you're doing, see this other documentation" on the other.

Well, the docmuentation doesn't answer those questions either.

I could just swap the warning and the cross-reference, so that the
cross-reference doesn't seem to follow on from "knowing what you're
doing"?

Cheers
---Dave
