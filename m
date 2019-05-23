Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD32127A2D
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfEWKRG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 06:17:06 -0400
Received: from foss.arm.com ([217.140.101.70]:42332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfEWKRG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 06:17:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36DF9341;
        Thu, 23 May 2019 03:17:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D34083F718;
        Thu, 23 May 2019 03:17:04 -0700 (PDT)
Date:   Thu, 23 May 2019 11:17:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not
 force_sig_fault for SIGKILL
Message-ID: <20190523101702.GG26646@fuggles.cambridge.arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
 <20190523003916.20726-4-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523003916.20726-4-ebiederm@xmission.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 22, 2019 at 07:38:53PM -0500, Eric W. Biederman wrote:
> It really only matters to debuggers but the SIGKILL does not have any
> si_codes that use the fault member of the siginfo union.  Correct this
> the simple way and call force_sig instead of force_sig_fault when the
> signal is SIGKILL.
> 
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

I know it's a bit of a misnomer, but I'd rather do this check inside
arm64_force_sig_fault, since I think we have other callers (e.g.
do_bad_area()) which also blindly pass in SIGKILL here.

We could rename the thing if necessary.

Will
