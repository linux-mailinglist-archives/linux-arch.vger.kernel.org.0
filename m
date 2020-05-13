Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBB31D101F
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEMKql (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 06:46:41 -0400
Received: from foss.arm.com ([217.140.110.172]:43148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgEMKqk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 06:46:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B94F71FB;
        Wed, 13 May 2020 03:46:39 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D311B3F71E;
        Wed, 13 May 2020 03:46:38 -0700 (PDT)
Date:   Wed, 13 May 2020 11:46:36 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/14] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200513104635.GD21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
 <20200513084351.GB18196@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513084351.GB18196@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 09:43:52AM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Tue, May 12, 2020 at 05:36:58PM +0100, Dave Martin wrote:
> > diff --git a/man2/prctl.2 b/man2/prctl.2
> > index 7f511d2..dd16227 100644
> > --- a/man2/prctl.2
> > +++ b/man2/prctl.2
> > @@ -1291,6 +1291,104 @@ call failing with the error
> >  .BR ENXIO .
> >  For further details, see the kernel source file
> >  .IR Documentation/admin-guide/kernel-parameters.txt .
> > +.\" prctl PR_SVE_SET_VL
> > +.\" commit 2d2123bc7c7f843aa9db87720de159a049839862
> > +.\" linux-5.6/Documentation/arm64/sve.rst
> > +.TP
> > +.BR PR_SVE_SET_VL " (since Linux 4.15, only on arm64)"
> > +Configure the thread's SVE vector length,
> > +as specified by
> > +.IR arg2 .
> > +Arguments
> > +.IR arg3 ", " arg4 " and " arg5
> > +are ignored.
> 
> Bugger, did we forget to force these to zero? I guess we should write the
> man-page first next time :(

Not an accident, but there does seem to be some inconsistency in policy
among the various prctls here.

glibc explicitly has

	extern int prctl (int __option, ...);

(and nobody has to write _exit(0, 0, 0, 0, 0, 0) after all.)

Is there some agreed rationale for requiring redundant arguments to be
supplied explicitly as zero?  For now there are likely to be few users
of this, so we _might_ get away with changing the behaviour here if it's
considered important enough.

There is no forwards compatibility problem with this prctl though,
because there are spare bits in arg2 which can "turn on" additional
args if needed.

Also, it's implausible that PR_SVE_GET_VL will ever want an argument.

There are still 2 billion unallocated prctl numbers, so new prctls can
always be added if there's ever a need to work around these limitations,
but it seems extremely unlikely.

> 
> > +.IP
> > +The bits of
> > +.I arg2
> > +corresponding to
> > +.B SVE_VL_LEN_MASK
> 
> PR_SVE_LEN_MASK

Hmm, not sure how that happened.  Good spot!

I'll recheck that all the names are real when reposting.

> > +must be set to the desired vector length in bytes.
> > +In addition,
> > +.I arg2
> > +may include zero or more of the following flags:
> > +.RS
> > +.TP
> > +.B PR_SVE_VL_INHERIT
> > +Inherit the configured vector length across
> > +.BR execve (2).
> > +.TP
> > +.B PR_SVE_SET_VL_ONEXEC
> > +Defer the change until the next
> > +.BR execve (2)
> > +in this thread.
> 
> (aside, it's weird that we didn't allocate (1<<16) for one of these flags)

The flag definitions are shared with ptrace: ptrace is the
SVE_PT_REGS_SVE format selection bit, which isn't relevant to the prctl.

Maybe it would have made more sense to keep the definitions completely
separate, but it's there now.

> > +If
> > +.B PR_SVE_VL_INHERIT
> > +is also included in
> > +.IR arg2 ,
> > +it takes effect
> > +.I after
> > +this deferred change.
> 
> I find this a bit hard to follow, since it's not clear to me whether the
> INHERIT flag is effectively set before or after the next execve(). In other
> words, if both PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT are specified,
> is the vector length preserved or reset on the next execve()?

It makes no difference, because the ONEXEC handling takes priority over
the INHERIT handling. But either way INHERIT is never cleared by execve()
and will apply at subsequent execs().

Explaining all this properly seems out of scope here.  Maybe this should
be trimmed down rather than elaborated?  Or perhaps just explain it in
terms of what the kernel does instead of futile attempts to make it
intuitive?

Ultimately I'll probably write a separate page or pages for SVE and other
arm64 specifics.

> > +.RE
> > +.IP
> > +On success, the vector length and flags are set as requested,
> > +and any deferred change that was pending immediately before the
> > +.B PR_SVE_SET_VL
> > +call is canceled.
> 
> Huh, turns out 'canceled' is a valid US spelling. Fair enough, but it looks
> wrong to me ;)

Yeah, I know, but the man pages do have a documented policy on this...

prctl.2 has a lot of authors, so having mixed spellings could get
particularly messy.

> 
> > +If
> > +.B PR_SVE_SET_VL_ONEXEC
> > +was included in
> > +.IR arg2 ,
> > +the returned value describes the configuration
> > +scheduled to take effect at the next
> > +.BR execve (2).
> 
> "describes the configuration" how?
> 
> > +Otherwise, the effect is immediate and
> > +the returned value describes the new configuration.
> > +The returned value is encoded in the same way as the return value of
> > +.BR PR_SVE_GET_VL .
> 
> Aha. Maybe move this bit up slightly?

Yes, I'll reorder that.

> 
> > +.IP
> > +If neither of the above flags is included in
> 
> are included

Debatable.

The subject of the verb here is not "flags" (plural), but "neither of
the above flags" (which is more nuanced, though it can be interpreted
as singular).  Usage varies, and I don't consider this wrong.

> > +.IR arg2 ,
> > +a subsequent
> > +.BR execve (2)
> > +resets the vector length to the default value configured in
> > +.IR /proc/sys/abi/sve_default_vector_length .
> > +.IP
> > +The actual vector length configured by this operation
> > +is the greatest vector length supported by the platform
> > +that does not exceed
> > +.I arg2
> > +&
> > +.BR PR_SVE_VL_LEN_MASK .
> > +.IP
> > +The configuration (including any pending deferred change)
> > +is inherited across
> > +.BR fork (2)
> > +and
> > +.BR clone (2).
> > +.\" prctl PR_SVE_GET_VL
> > +.TP
> > +.BR PR_SVE_GET_VL " (since Linux 4.15, only on arm64)"
> > +Get the thread's current SVE vector length configuration,
> > +as configured by
> > +.BR PR_SVE_SET_VL .
> 
> It doesn't *have* to be configured by PR_SVE_SET_VL though, right?

No, "as" here is trying to mean that PR_SVE_SET_VL illustrates how the
vl can be set, not that it is the only way.

Maybe just delete that clause?  I'm not sure it adds much.

> > +.IP
> > +If successful, the return value describes the
> > +.I current
> > +configuration.
> 
> (aside: prctl() returns int, so we can't ever allocate past bit 30 in arg2.
> Might be worth a note somewhere in the kernel).

Agreed.  The chance of adding more bits seemed negligible, but dropping
a comment in would probably be a good idea.

Maybe we could redocument PR_SVE_SET_VL's arg2 as an int.  Passing an
int must survive the variadic argument marshaling of the glibc prctl()
wrapper, otherwise passing the existing #defines without an explicit
case to long would already break.

I'll probably just add the comment for now though.

> > +The bits corresponding to
> > +.B PR_SVE_VL_LEN_MASK
> > +contain the currently configured vector length in bytes.
> > +The bit corresponding to
> > +.B PR_SVE_VL_INHERIT
> > +indicates whether the vector length will be inherited
> > +across
> > +.BR execve (2).
> > +.IP
> > +Note that there is no way determine whether there is
> 
> to determine

Ack

> > +a pending vector length change that has not yet taken effect.
> > +.IP
> > +Providing that the kernel and platform support SVE,
> > +this operation always succeeds.
> >  .\"
> >  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
> >  .TP
> > @@ -1534,6 +1632,8 @@ On success,
> >  .BR PR_GET_NO_NEW_PRIVS ,
> >  .BR PR_GET_SECUREBITS ,
> >  .BR PR_GET_SPECULATION_CTRL ,
> > +.BR PR_SVE_GET_VL ,
> > +.BR PR_SVE_SET_VL ,
> >  .BR PR_GET_THP_DISABLE ,
> >  .BR PR_GET_TIMING ,
> >  .BR PR_GET_TIMERSLACK ,
> > @@ -1817,6 +1917,18 @@ and unused arguments to
> >  .BR prctl ()
> >  are not 0.
> >  .TP
> > +.B EINVAL
> > +.I option
> > +was
> > +.B PR_SVE_SET_VL
> > +and
> > +.I arg2
> > +contains invalid flags, or
> > +.I arg2
> > +&
> > +.B SVE_VL_LEN_MASK
> > +is not a valid vector length.
> > +.TP
> 
> PR_SVE_GET_VL can return -EINVAL if SVE is not supported.

See the earlier patch about the "unsupported hardware case of EINVAL".

This affects many prctls, is "obvious" and we'd just have to document
the same thing over and over again...


Thanks for the review.  Perhaps I was slightly oo hasty about having got
it half right!

---Dave
