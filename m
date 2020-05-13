Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A807A1D0B0F
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 10:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgEMIn5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 04:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732346AbgEMIn5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 04:43:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63ABD20643;
        Wed, 13 May 2020 08:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589359436;
        bh=p0KXgMY7tpUe/IREpDNHsNSfOjdNNzhnfRPem33itzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMCQf1LvsPtc5QjGIWrd/JjIw2fLDdWtR27P63pgFcamZMfBA/pwFEsHLHKbq2Uk8
         +4+JMe5p6uI+n8UJjsuNxhgTjtXt84bBhwRsP8whqV4jqmXFyDlKw5Hhyysb1dFMgB
         YW0sF4wHhi/Tgr19GJjXbRd88yS9rxTmaGY3oV8U=
Date:   Wed, 13 May 2020 09:43:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/14] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200513084351.GB18196@willie-the-truck>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On Tue, May 12, 2020 at 05:36:58PM +0100, Dave Martin wrote:
> diff --git a/man2/prctl.2 b/man2/prctl.2
> index 7f511d2..dd16227 100644
> --- a/man2/prctl.2
> +++ b/man2/prctl.2
> @@ -1291,6 +1291,104 @@ call failing with the error
>  .BR ENXIO .
>  For further details, see the kernel source file
>  .IR Documentation/admin-guide/kernel-parameters.txt .
> +.\" prctl PR_SVE_SET_VL
> +.\" commit 2d2123bc7c7f843aa9db87720de159a049839862
> +.\" linux-5.6/Documentation/arm64/sve.rst
> +.TP
> +.BR PR_SVE_SET_VL " (since Linux 4.15, only on arm64)"
> +Configure the thread's SVE vector length,
> +as specified by
> +.IR arg2 .
> +Arguments
> +.IR arg3 ", " arg4 " and " arg5
> +are ignored.

Bugger, did we forget to force these to zero? I guess we should write the
man-page first next time :(

> +.IP
> +The bits of
> +.I arg2
> +corresponding to
> +.B SVE_VL_LEN_MASK

PR_SVE_LEN_MASK

> +must be set to the desired vector length in bytes.
> +In addition,
> +.I arg2
> +may include zero or more of the following flags:
> +.RS
> +.TP
> +.B PR_SVE_VL_INHERIT
> +Inherit the configured vector length across
> +.BR execve (2).
> +.TP
> +.B PR_SVE_SET_VL_ONEXEC
> +Defer the change until the next
> +.BR execve (2)
> +in this thread.

(aside, it's weird that we didn't allocate (1<<16) for one of these flags)

> +If
> +.B PR_SVE_VL_INHERIT
> +is also included in
> +.IR arg2 ,
> +it takes effect
> +.I after
> +this deferred change.

I find this a bit hard to follow, since it's not clear to me whether the
INHERIT flag is effectively set before or after the next execve(). In other
words, if both PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT are specified,
is the vector length preserved or reset on the next execve()?

> +.RE
> +.IP
> +On success, the vector length and flags are set as requested,
> +and any deferred change that was pending immediately before the
> +.B PR_SVE_SET_VL
> +call is canceled.

Huh, turns out 'canceled' is a valid US spelling. Fair enough, but it looks
wrong to me ;)

> +If
> +.B PR_SVE_SET_VL_ONEXEC
> +was included in
> +.IR arg2 ,
> +the returned value describes the configuration
> +scheduled to take effect at the next
> +.BR execve (2).

"describes the configuration" how?

> +Otherwise, the effect is immediate and
> +the returned value describes the new configuration.
> +The returned value is encoded in the same way as the return value of
> +.BR PR_SVE_GET_VL .

Aha. Maybe move this bit up slightly?

> +.IP
> +If neither of the above flags is included in

are included

> +.IR arg2 ,
> +a subsequent
> +.BR execve (2)
> +resets the vector length to the default value configured in
> +.IR /proc/sys/abi/sve_default_vector_length .
> +.IP
> +The actual vector length configured by this operation
> +is the greatest vector length supported by the platform
> +that does not exceed
> +.I arg2
> +&
> +.BR PR_SVE_VL_LEN_MASK .
> +.IP
> +The configuration (including any pending deferred change)
> +is inherited across
> +.BR fork (2)
> +and
> +.BR clone (2).
> +.\" prctl PR_SVE_GET_VL
> +.TP
> +.BR PR_SVE_GET_VL " (since Linux 4.15, only on arm64)"
> +Get the thread's current SVE vector length configuration,
> +as configured by
> +.BR PR_SVE_SET_VL .

It doesn't *have* to be configured by PR_SVE_SET_VL though, right?

> +.IP
> +If successful, the return value describes the
> +.I current
> +configuration.

(aside: prctl() returns int, so we can't ever allocate past bit 30 in arg2.
Might be worth a note somewhere in the kernel).

> +The bits corresponding to
> +.B PR_SVE_VL_LEN_MASK
> +contain the currently configured vector length in bytes.
> +The bit corresponding to
> +.B PR_SVE_VL_INHERIT
> +indicates whether the vector length will be inherited
> +across
> +.BR execve (2).
> +.IP
> +Note that there is no way determine whether there is

to determine

> +a pending vector length change that has not yet taken effect.
> +.IP
> +Providing that the kernel and platform support SVE,
> +this operation always succeeds.
>  .\"
>  .\" prctl PR_TASK_PERF_EVENTS_DISABLE
>  .TP
> @@ -1534,6 +1632,8 @@ On success,
>  .BR PR_GET_NO_NEW_PRIVS ,
>  .BR PR_GET_SECUREBITS ,
>  .BR PR_GET_SPECULATION_CTRL ,
> +.BR PR_SVE_GET_VL ,
> +.BR PR_SVE_SET_VL ,
>  .BR PR_GET_THP_DISABLE ,
>  .BR PR_GET_TIMING ,
>  .BR PR_GET_TIMERSLACK ,
> @@ -1817,6 +1917,18 @@ and unused arguments to
>  .BR prctl ()
>  are not 0.
>  .TP
> +.B EINVAL
> +.I option
> +was
> +.B PR_SVE_SET_VL
> +and
> +.I arg2
> +contains invalid flags, or
> +.I arg2
> +&
> +.B SVE_VL_LEN_MASK
> +is not a valid vector length.
> +.TP

PR_SVE_GET_VL can return -EINVAL if SVE is not supported.

Will
