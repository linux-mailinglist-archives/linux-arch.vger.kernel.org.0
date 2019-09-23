Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BFEBAFE1
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfIWIr0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 04:47:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731460AbfIWIrZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 04:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/43GF0QWgIU5tkmUtQcTjX9yL5SM1r1TS8Ahy7IgToA=; b=K1+zCvsaewII+mHTy3eoOME7L
        8jpgtr+xqiZNxhbLy48TCKcvo0sb5elmojLefPfZOSyoeetH4ZeIRnseyYu/uJxClwyioMtmgZ6+i
        x3MGNbjz5+DxGOpFMFc+8PGbORulTuI8DGmtoKngWbDpphyXH3sbw7cOz7YbhskSi6WlAevBmuRzF
        AlXWHcG9wL45968qfB2n0WLK7gVFWkAQJHqi1wgUvxA9iBn63t/6IVyE18WReWeLgDZnjVWMQq9J+
        uFzIRF52TzH5ONzcbofMAcJ5VdGFE9GoYysFA9GlDN3QkT32YER24V80ZiAvgUIdcffUmhZiVIFo7
        SpqZplQcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCK09-0004sR-48; Mon, 23 Sep 2019 08:47:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8222303DFD;
        Mon, 23 Sep 2019 10:46:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C79032B1204C7; Mon, 23 Sep 2019 10:47:18 +0200 (CEST)
Date:   Mon, 23 Sep 2019 10:47:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC patch 10/15] x86/entry: Move irq tracing to C code
Message-ID: <20190923084718.GG2349@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.446771597@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150809.446771597@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 19, 2019 at 05:03:24PM +0200, Thomas Gleixner wrote:
> To prepare for converting the exit to usermode code to the generic version,
> move the irqflags tracing into C code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c          |   10 ++++++++++
>  arch/x86/entry/entry_32.S        |   11 +----------
>  arch/x86/entry/entry_64.S        |   10 ++--------
>  arch/x86/entry/entry_64_compat.S |   21 ---------------------
>  4 files changed, 13 insertions(+), 39 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -102,6 +102,8 @@ static void exit_to_usermode_loop(struct
>  	struct thread_info *ti = current_thread_info();
>  	u32 cached_flags;
>  
> +	trace_hardirqs_off();

Bah.. so this gets called from:

 - C code, with IRQs disabled
 - entry_64.S:error_exit
 - entry_32.S:resume_userspace

The first obviously doesn't need this annotation, but this patch doesn't
remove the TRACE_IRQS_OFF from entry_64.S and only the 32bit case is
changed.

Is that entry_64.S case an oversight, or do we need an extensive comment
on this one?

>  	addr_limit_user_check();
>  
>  	lockdep_assert_irqs_disabled();
> @@ -137,6 +139,8 @@ static void exit_to_usermode_loop(struct
>  	user_enter_irqoff();
>  
>  	mds_user_clear_cpu_buffers();
> +

	/* Return to userspace (IRET) will re-enable interrupts */
> +	trace_hardirqs_on();
>  }
