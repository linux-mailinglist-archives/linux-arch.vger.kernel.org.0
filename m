Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1961F57C6
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jun 2020 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgFJP0j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jun 2020 11:26:39 -0400
Received: from foss.arm.com ([217.140.110.172]:59992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgFJP0j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jun 2020 11:26:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08741F1;
        Wed, 10 Jun 2020 08:26:37 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E144F3F6CF;
        Wed, 10 Jun 2020 08:26:36 -0700 (PDT)
Date:   Wed, 10 Jun 2020 16:26:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH v2 6/6] prctl.2: Add tagged address ABI control
 prctls (arm64)
Message-ID: <20200610152634.GJ26099@gaia>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-7-git-send-email-Dave.Martin@arm.com>
 <20200609172232.GA63286@C02TF0J2HF1T.local>
 <20200610100641.GF25945@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610100641.GF25945@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 10, 2020 at 11:06:42AM +0100, Dave P Martin wrote:
> On Tue, Jun 09, 2020 at 06:22:32PM +0100, Catalin Marinas wrote:
> > On Wed, May 27, 2020 at 10:17:38PM +0100, Dave P Martin wrote:
> > > --- a/man2/prctl.2
> > > +++ b/man2/prctl.2
> > > @@ -1504,6 +1504,143 @@ For more information, see the kernel source file
> > >  (or
> > >  .I Documentation/arm64/sve.txt
> > >  before Linux 5.3).
> > > +.\" prctl PR_SET_TAGGED_ADDR_CTRL
> > > +.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
> > > +.TP
> > > +.BR PR_SET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
> > > +Controls support for passing tagged userspace addresses to the kernel
> > > +(i.e., addresses where bits 56\(em63 are not all zero).
> > 
> > Nitpick: maybe say "userspace addresses" again inside the brackets since
> > kernel addresses have all top bits 1.
> 
> Happy to do that.  This is a user-facing interface though: userspace
> addresses are the only kind of address there is.

Living in the kernel land for too long, it's hard to switch perspective ;).
I think the original sentence makes sense anyway, it should be obvious
that it refers to user addresses.

> > > +.IP
> > > +The level of support is selected by
> > > +.IR "(unsigned int) arg2" ,
> > 
> > We use (unsigned long) for arg2.
> 
> Hmmm, not quite sure how I came up with unsigned int here.  I'll just
> drop this: the type in the prctl() prototype is unsigned long anyway.
> 
> The type is actually moot in this case, since the valid values all fit
> in an unsigned int.

Passing an int doesn't require that the top 32-bit of the long are
zeroed (in case anyone writes the low-level SVC by hand).

> > > +which can be one of the following:
> > > +.RS
> > > +.TP
> > > +.B 0
> > > +Addresses that are passed
> > > +for the purpose of being dereferenced by the kernel
> > > +must be untagged.
> > > +.TP
> > > +.B PR_TAGGED_ADDR_ENABLE
> > > +Addresses that are passed
> > > +for the purpose of being dereferenced by the kernel
> > > +may be tagged, with the exceptions summarized below.
> > > +.RE
> > > +.IP
> > > +The remaining arguments
> > > +.IR arg3 ", " arg4 " and " arg5
> > > +must all be zero.
> > 
> > Indeed. The above commit didn't have this, we added it later in commit
> > 3e91ec89f527b9870fe42dcbdb74fd389d123a95.
> 
> Ah, missed that.  Did any full kernel release expose the unchecked
> behaviour?

No, they both went into 5.4-rc1. I probably didn't want to rebase the
series and just added a patch on top.

> Mind you, there's probably no need to document in any case.

I agree. Just mentioned it because I looked at the commit you mentioned
and there was no check for the arg3..arg5, so went to check the history.

> > > +.IP
> > > +On success, the mode specified in
> > > +.I arg2
> > > +is set for the calling thread and the the return value is 0.
> > > +If the arguments are invalid,
> > > +the mode specified in
> > > +.I arg2
> > > +is unrecognized,
> > > +or if this feature is disabled or unsupported by the kernel,
> > > +the call fails with
> > > +.BR EINVAL .
> > > +.IP
> > > +In particular, if
> > > +.BR prctl ( PR_SET_TAGGED_ADDR_CTRL ,
> > > +0, 0, 0, 0)
> > > +fails with
> > > +.B EINVAL
> > > +then all addresses passed to the kernel must be untagged.
> > > +.IP
> > > +Irrespective of which mode is set,
> > > +addresses passed to certain interfaces
> > > +must always be untagged:
> > 
> > Maybe you could add some extra info from the kernel comment (commit
> > b2a84de2a2deb76a6a51609845341f508c518c03) along the lines of "... to
> > avoid the creation of aliasing mappings in userspace).
> 
> It depends.  It's useful if it helps people to guess highly accurately
> the rule for in interface that is too new or that we don't explicitly
> document (such as a random setsockopt or perf widget).
> 
> If not, it might be best to say nothing and make guarantees only about
> the explicitly listed interfaces though.

Fine by me to keep it as it is. We can always update the man page if new
syscalls come into this category.

> > > +.RS
> > > +.IP \(em
> > > +.BR brk (2),
> > > +.BR mmap (2),
> > > +.BR shmat (2),
> > > +and the
> > > +.I new_address
> > > +argument of
> > > +.BR mremap (2).
> > > +.IP
> > > +(Prior to Linux 5.6 these accepted tagged addresses,
> > > +but the behaviour may not be what you expect.
> > > +Don't rely on it.)
> > 
> > shmat() was not part of the subsequent fix
> > (dcde237319e626d1ec3c9d8b7613032f0fd4663a), it always rejected tagged
> > address. But I guess it doesn't matter much, the user should not pass
> > tagged addresses to these syscalls anyway.
> > 
> > You could move shmat() down together with shmdt().
> 
> I guess I was highlighting that shmdt() is a special case, because the
> user would guess from the pattern of the other listed calls that shmdt()
> should accept tagged addresses.  If you think separating it just adds to
> the confusion, I'm happy not too call it out specially here.
> 
> OTOH, we could fix shmdt() and document the legacy behaviour as a bug in
> specific kernel versions rather than the canonical behaviour.  But I
> guess that's one for later.

If we patch shmdt() to allow tagged addresses, then it makes sense to
keep shmat() with the rest of the above. Just pointing out that shmat()
never allowed tagged pointers

> > > +.IP \(em
> > > +\(oqpolymorphic\(cq interfaces
> > > +that accept pointers to arbitrary types cast to a
> > > +.I void *
> > > +or other generic type, specifically
> > > +.BR prctl (2),
> > > +.BR ioctl (2),
> > > +and in general
> > > +.BR setsockopt (2)
> > > +(only certain specific
> > > +.BR setsockopt (2)
> > > +options allow tagged addresses).
> > > +.IP \(em
> > > +.BR shmdt (2).
> > > +.RE
> > > +.IP
> > > +This list of exclusions may shrink
> > > +when moving from one kernel version to a later kernel version.
> > > +While the kernel may make some guarantees
> > > +for backwards compatibility reasons,
> > > +for the purposes of new software
> > > +the effect of passing tagged addresses to these interfaces
> > > +is unspecified.
> > > +.IP
> > > +The mode set by this call is inherited across
> > > +.BR fork (2)
> > > +and
> > > +.BR clone (2).
> > > +The mode is reset by
> > > +.BR execve (2)
> > > +to 0
> > > +(i.e., tagged addresses not permitted in the user/kernel ABI).
> > > +.IP
> > > +.B Warning:
> > > +Because the compiler or run-time environment
> > > +may make use of address tagging,
> > > +a successful
> > > +.B PR_SET_TAGGED_ADDR_CTRL
> > > +may crash the calling process.
> > 
> > I don't think PR_SET_TAGGED_ADDR_CTRL could crash the calling process.
> > Rather disabling tagged addresses would break it. If a process is using
> 
> This is precisely how PR_SET_TAGGED_ADDR_CTRL could crash the calling
> process, no?

I see your point. E.g. it was enabled by glibc but disabled by a user
application.

> Rather than try to explain the different cases in detail here and have
> the reader take it as gospel, I thought it would be better to scare them
> a bit and encourage them to so some homework.  Perhaps I'm being too
> cautious.

That's fine, leave the warning in place.

> > tagged addresses but does not pass them to the kernel, it will continue
> > to do so even when the syscalls accept such addresses.
> > 
> > > +The conditions for using it safely are complex and system-dependent.
> > > +Don't use it unless you know what you are doing.
> > 
> > This syscall is intended for the C library if the heap allocator
> > generates tagged addresses. So it's not a general purpose prctl() random
> > application code could call. Anyway I'm fine with your warning of not
> > doing it but you may want to clarify the intent.
> 
> Maybe add something like
> 
> "This call is primarily intended for use by the run-time environment."

That works as well, maybe in addition to the warning. Up to you.

> > > +.IP
> > > +For more information, see the kernel source file
> > > +.IR Documentation/arm64/tagged\-address\-abi.rst .
> > > +.\" prctl PR_GET_TAGGED_ADDR_CTRL
> > > +.\" commit 63f0c60379650d82250f22e4cf4137ef3dc4f43d
> > > +.TP
> > > +.BR PR_GET_TAGGED_ADDR_CTRL " (since Linux 5.4, only on arm64)"
> > > +Returns the current tagged address mode
> > > +for the calling thread.
> > > +.IP
> > > +Arguments
> > > +.IR arg2 ", " arg3 ", " arg4 " and " arg5
> > > +must all be zero.
> > > +.IP
> > > +If the arguments are invalid
> > > +or this feature is disabled or unsupported by the kernel,
> > > +the call fails with
> > > +.BR EINVAL .
> > > +In particular, if
> > > +.BR prctl ( PR_GET_TAGGED_ADDR_CTRL ,
> > > +0, 0, 0, 0)
> > > +fails with
> > > +.BR EINVAL ,
> > > +then this feature is definitely unsupported or disabled,
> > 
> > I guess it's outside the scope of the prctl.2 to describe how the
> > feature was disabled (e.g. sysctl).
> 
> We could include it here, but I'm thinking we might want a more
> comprehensive separate page to describe how to use MTE in general.
> 
> For now, is referencing the kernel documentation enough?

I think simply saying "unsupported or disabled" is sufficient in the man
page. The sysctl is not aimed at the user sw/run-time developers but
rather those controlling the system. For the latter, the kernel
documentation is sufficient.

So with the (unsigned int) fixed, feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I don't have a strong opinion on the other nitpicks, so I'll leave the
decision to you.

-- 
Catalin
