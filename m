Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63B522CE64
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 21:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgGXTIi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXTIh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 15:08:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CABC0619D3;
        Fri, 24 Jul 2020 12:08:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595617714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDN6+oEq+rXXE3L9eqvVhY8T2LwO0r+OvHOIHPOdeUs=;
        b=el+I9+uQblelBDjYB//Cal2rLo4nU3iFXpDSaBgrTN+Gqe0m1TddgxerIJmVagiDFK0gWf
        CyV/KxAlDTzUt0zrDOn/2RrKXH/5oFv1dExHp8xBDLIlwaI9ATikeGvsglX2qOagUAYLMB
        pheHNkJHIZ1OgRKLxRjCh4f0eWjtypi+cwbpnAv24hWi9GKZ+yPNEW5SiPf+8yoZyG38JS
        I/p+jLZqeSHvzZBPvzuwDyW54Etmj9QdvG2NgR5gxljp7dyle1DKPlmgOMy+UCBDijfcMZ
        L8BRqm/ISG0fdbHksFxHZ4DdSX8GLyeMTnwt7N5mBJZMcYPN8BlQTne+/tcGvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595617715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDN6+oEq+rXXE3L9eqvVhY8T2LwO0r+OvHOIHPOdeUs=;
        b=DpuwIS4slPn8hA1LX5q05nEMp3zaBYNmq/xtwXclhxwCVdYvfh9uyeHozT6oyBGWJvZmj+
        G65wLHmg2aKSxxDQ==
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [patch V5 15/15] x86/kvm: Use generic xfer to guest work function
In-Reply-To: <20200724142426.GA651711@gmail.com>
References: <20200722215954.464281930@linutronix.de> <20200722220520.979724969@linutronix.de> <20200724142426.GA651711@gmail.com>
Date:   Fri, 24 Jul 2020 21:08:34 +0200
Message-ID: <87k0ysu3wt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>>  		/*
>> -		 * Note, return 1 and not 0, vcpu_run() is responsible for
>> -		 * morphing the pending signal into the proper return code.
>> +		 * Note, return 1 and not 0, vcpu_run() will invoke
>> +		 * xfer_to_guest_mode() which will create a proper return
>> +		 * code.
>>  		 */
>> -		if (signal_pending(current))
>> +		if (__xfer_to_guest_mode_work_pending())
>>  			return 1;
>> -
>> -		if (need_resched())
>> -			schedule();
>>  	}
>
> AFAICS this chunk removes a conditional reschedule point from 
> handle_invalid_guest_state() and replaces it with 
> __xfer_to_guest_mode_work_pending().
>
> But __xfer_to_guest_mode_work_pending() doesn't do the cond-resched of 
> the full xfer_to_guest_mode_work() function - so we essentially lose a 
> cond_resched() here.
>
> Is this side effect intended, was the cond_resched() superfluous?

It makes the thing drop back to the outer loop for any pending work not
only for signals. That avoids having yet another thing to worry about.

Thanks,

        tglx
