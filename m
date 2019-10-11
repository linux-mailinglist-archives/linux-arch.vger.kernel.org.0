Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1ED4459
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfJKPcb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 11:32:31 -0400
Received: from foss.arm.com ([217.140.110.172]:35922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbfJKPcb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 11:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2272A142F;
        Fri, 11 Oct 2019 08:32:31 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A6D93F68E;
        Fri, 11 Oct 2019 08:32:28 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:32:26 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Richard Henderson <richard.henderson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>
Subject: Re: [PATCH v2 05/12] arm64: Basic Branch Target Identification
 support
Message-ID: <20191011153225.GL27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <20191011151028.GE33537@lakrids.cambridge.arm.com>
 <4e09ca54-f353-9448-64ed-4ba1e38c6ebc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e09ca54-f353-9448-64ed-4ba1e38c6ebc@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 11:25:33AM -0400, Richard Henderson wrote:
> On 10/11/19 11:10 AM, Mark Rutland wrote:
> > On Thu, Oct 10, 2019 at 07:44:33PM +0100, Dave Martin wrote:
> >> @@ -730,6 +730,11 @@ static void setup_return
> >>  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
> >>  	regs->pc = (unsigned long)ka->sa.sa_handler;
> >>  
> >> +	if (system_supports_bti()) {
> >> +		regs->pstate &= ~PSR_BTYPE_MASK;
> >> +		regs->pstate |= PSR_BTYPE_CALL;
> >> +	}
> >> +
> > 
> > I think we might need a comment as to what we're trying to ensure here.
> > 
> > I was under the (perhaps mistaken) impression that we'd generate a
> > pristine pstate for a signal handler, and it's not clear to me that we
> > must ensure the first instruction is a target instruction.
> 
> I think it makes sense to treat entry into a signal handler as a call.  Code
> that has been compiled for BTI, and whose page has been marked with PROT_BTI,
> will already have the pauth/bti markup at the beginning of the signal handler
> function; we might as well verify that.
> 
> Otherwise sigaction becomes a hole by which an attacker can force execution to
> start at any arbitrary address.

Ack, that's the intended rationale -- I also outlined this in the commit
message.

Does this sound reasonable?


Either way, I feel we should do this: any function in a PROT_BTI page
should have a suitable landing pad.  There's no reason I can see why
a protection given to any other callback function should be omitted
for a signal handler.

Note, if the signal handler isn't in a PROT_BTI page then overriding
BTYPE here will not trigger a Branch Target exception.

I'm happy to drop a brief comment into the code also, once we're
agreed on what the code should be doing.

Cheers
---Dave
