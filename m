Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC2E1E2461
	for <lists+linux-arch@lfdr.de>; Tue, 26 May 2020 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgEZOp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 May 2020 10:45:29 -0400
Received: from foss.arm.com ([217.140.110.172]:51692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgEZOp2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 May 2020 10:45:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33E151FB;
        Tue, 26 May 2020 07:45:28 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 372023F305;
        Tue, 26 May 2020 07:45:27 -0700 (PDT)
Date:   Tue, 26 May 2020 15:45:25 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/14] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200526144524.GR5031@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
 <20200513084351.GB18196@willie-the-truck>
 <20200513104635.GD21779@arm.com>
 <a01fc572-cac8-1932-c3e5-c70184417ca3@gmail.com>
 <20200513140200.GP21779@arm.com>
 <20200513211153.GB28594@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513211153.GB28594@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 10:11:54PM +0100, Will Deacon wrote:
> On Wed, May 13, 2020 at 03:02:00PM +0100, Dave Martin wrote:
> > On Wed, May 13, 2020 at 01:01:12PM +0200, Michael Kerrisk (man-pages) wrote:
> > > On 5/13/20 12:46 PM, Dave Martin wrote:
> > > > On Wed, May 13, 2020 at 09:43:52AM +0100, Will Deacon wrote:
> > > >> On Tue, May 12, 2020 at 05:36:58PM +0100, Dave Martin wrote:

[...]

> > > >>> +If
> > > >>> +.B PR_SVE_VL_INHERIT
> > > >>> +is also included in
> > > >>> +.IR arg2 ,
> > > >>> +it takes effect
> > > >>> +.I after
> > > >>> +this deferred change.
> > > >>
> > > >> I find this a bit hard to follow, since it's not clear to me whether the
> > > >> INHERIT flag is effectively set before or after the next execve(). In other
> > > >> words, if both PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT are specified,
> > > >> is the vector length preserved or reset on the next execve()?
> > > > 
> > > > It makes no difference, because the ONEXEC handling takes priority over
> > > > the INHERIT handling. But either way INHERIT is never cleared by execve()
> > > > and will apply at subsequent execs().
> > > > 
> > > > Explaining all this properly seems out of scope here.  Maybe this should
> > > > be trimmed down rather than elaborated?  Or perhaps just explain it in
> > > > terms of what the kernel does instead of futile attempts to make it
> > > > intuitive?
> 
> Hmm, if we don't explain it in the man page then we should at least point
> people to somewhere where they can get the gory details, because I think
> they're necessary in order to use the prctl() request correctly. I'm still
> not confident that I understand the semantics of setting both
> PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT without reading the code, which
> may change.

On this point, can you review the following wording?

I simply enumerate the possible flag combinations now, rather than tying
myself in knots trying to describe the two flags independently.

Cheers
---Dave

--8<--

       PR_SVE_SET_VL (since Linux 4.15, only on arm64)
              Configure the thread's SVE vector length, as specified by  (int)
              arg2.  Arguments arg3, arg4 and arg5 are ignored.

              The bits of arg2 corresponding to PR_SVE_VL_LEN_MASK must be set
              to the desired vector length in bytes.  This is  interpreted  as
              an  upper  bound:  the kernel will select the greatest available
              vector length that does not exceed the value specified.  In par-
              ticular,  specifying  SVE_VL_MAX (defined in <asm/sigcontext.h>)
              for the PR_SVE_VL_LEN_MASK bits requests the  maximum  supported
              vector length.

              In  addition,  arg2  may  include  the following combinations of
              flags:

              0      Perform the change immediately.  At the next execve(2) in
                     the  thread, the vector length will be reset to the value
                     configured in /proc/sys/abi/sve_default_vector_length.

              PR_SVE_VL_INHERIT
                     Perform the  change  immediately.   Subsequent  execve(2)
                     calls will preserve the new vector length.

              PR_SVE_SET_VL_ONEXEC
                     Defer  the  change,  so  that it is performed at the next
                     execve(2) in the thread.  Further  execve(2)  calls  will
                     reset  the  vector  length  to  the  value  configured in
                     /proc/sys/abi/sve_default_vector_length.

              PR_SVE_SET_VL_ONEXEC | PR_SVE_VL_INHERIT
                     Defer the change, so that it is  performed  at  the  next
                     execve(2)  in  the  thread.  Further execve(2) calls will
                     preserve the new vector length.

              In all cases, any previously pending  deferred  change  is  can-
              celed.

              The  call fails with error EINVAL if SVE is not supported on the
              platform, if arg2 is unrecognized or invalid, or  the  value  in
              the  bits of arg2 corresponding to PR_SVE_VL_LEN_MASK is outside
              the range SVE_VL_MIN..SVE_VL_MAX, or is not a multiple of 16.

              On success, a nonnegative value is returned that  describes  the
              selected  configuration,  which may differ from the current con-
              figuration if PR_SVE_SET_VL_ONEXEC was specified.  The value  is
              encoded in the same way as the return value of PR_SVE_GET_VL.

              The  configuration  (including  any  pending deferred change) is
              inherited across fork(2) and clone(2).

              For more information, see  the  kernel  source  file  Documenta-
              tion/arm64/sve.rst  (or Documentation/arm64/sve.txt before Linux
              5.3).

              Warning: Because the compiler or  run-time  environment  may  be
              using SVE, using this call without the PR_SVE_SET_VL_ONEXEC flag
              can lead to unpredicable behaviour in the calling process.   The
              conditions for using it safely are complex and system-dependent.
              Don't use it unless you really know what you are doing.

-->8--
