Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA09C29550
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 12:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390156AbfEXKAN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 06:00:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38584 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389758AbfEXKAN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 06:00:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC285A78;
        Fri, 24 May 2019 03:00:12 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 544253F718;
        Fri, 24 May 2019 03:00:11 -0700 (PDT)
Date:   Fri, 24 May 2019 11:00:08 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [REVIEW][PATCHv2 03/26] signal/arm64: Use force_sig not
 force_sig_fault for SIGKILL
Message-ID: <20190524100008.GE3432@fuggles.cambridge.arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
 <20190523003916.20726-4-ebiederm@xmission.com>
 <20190523101702.GG26646@fuggles.cambridge.arm.com>
 <875zq1gnh4.fsf_-_@xmission.com>
 <20190523161509.GE31896@fuggles.cambridge.arm.com>
 <8736l4evkn.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736l4evkn.fsf@xmission.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 23, 2019 at 03:59:20PM -0500, Eric W. Biederman wrote:
> Will Deacon <will.deacon@arm.com> writes:
> 
> > On Thu, May 23, 2019 at 11:11:19AM -0500, Eric W. Biederman wrote:
> >> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> >> index ade32046f3fe..e45d5b440fb1 100644
> >> --- a/arch/arm64/kernel/traps.c
> >> +++ b/arch/arm64/kernel/traps.c
> >> @@ -256,7 +256,10 @@ void arm64_force_sig_fault(int signo, int code, void __user *addr,
> >>  			   const char *str)
> >>  {
> >>  	arm64_show_signal(signo, str);
> >> -	force_sig_fault(signo, code, addr, current);
> >> +	if (signo == SIGKILL)
> >> +		force_sig(SIGKILL, current);
> >> +	else
> >> +		force_sig_fault(signo, code, addr, current);
> >>  }
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > Are you planning to send this series on, or would you like me to pick this
> > into the arm64 tree?
> 
> I am planning on taking this through siginfo tree, unless it causes
> problems.

Okey doke, it would just be nice to see this patch land in 5.2, that's
all.

Will
