Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79DFD27A3E
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 12:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfEWKVI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 06:21:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42470 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbfEWKVI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 06:21:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEC50341;
        Thu, 23 May 2019 03:21:07 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 780123F718;
        Thu, 23 May 2019 03:21:06 -0700 (PDT)
Date:   Thu, 23 May 2019 11:21:04 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        James Morse <James.Morse@arm.com>,
        Will Deacon <Will.Deacon@arm.com>
Subject: Re: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not
 force_sig_fault for SIGKILL
Message-ID: <20190523102101.GW28398@e103592.cambridge.arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
 <20190523003916.20726-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523003916.20726-4-ebiederm@xmission.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 23, 2019 at 01:38:53AM +0100, Eric W. Biederman wrote:
> It really only matters to debuggers but the SIGKILL does not have any
> si_codes that use the fault member of the siginfo union.  Correct this
> the simple way and call force_sig instead of force_sig_fault when the
> signal is SIGKILL.

I haven't fully understood the context for this, but why does it matter
what's in siginfo for SIGKILL?  My understanding is that userspace
(including ptrace) never gets to see it anyway for the SIGKILL case.

Here it feels like SIGKILL is logically a synchronous, thread-targeted
fault: we must ensure that no subsequent insn in current executes (just
like other fault signal).  In this case, I thought we fall back to
SIGKILL not because there is no fault, but because we failed to
properly diagnose or report the type of fault that occurred.

So maybe handling it consistently with other faults signals makes
sense.  The fact that delivery of this signal destroys the process
before anyone can look at the resulting siginfo feels like a
side-effect rather than something obviously wrong.

The siginfo is potentially useful diagnostic information, that we could
subsequently provide a means to access post-mortem.

I just dived in on this single patch, so I may be missing something more
fundamental, or just being pedantic...

Cheers
---Dave

> Cc: stable@vger.kernel.org
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Fixes: af40ff687bc9 ("arm64: signal: Ensure si_code is valid for all fault signals")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/arm64/kernel/traps.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index ade32046f3fe..0feb17bdcaa0 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -282,6 +282,11 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  		current->thread.fault_address = 0;
>  		current->thread.fault_code = err;
>  
> +		if (signo == SIGKILL) {
> +			arm64_show_signal(signo, str);
> +			force_sig(signo, current);
> +			return;
> +		}
>  		arm64_force_sig_fault(signo, sicode, addr, str);
>  	} else {
>  		die(str, regs, err);
> -- 
> 2.21.0
> 
