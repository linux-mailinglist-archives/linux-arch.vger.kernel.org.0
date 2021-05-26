Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C22391D0D
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbhEZQdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 12:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhEZQdX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 May 2021 12:33:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92887C061574;
        Wed, 26 May 2021 09:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sOL3BvHKeXuTa8i7Byc9prFY//hqK/wPv2ycrlvaUAM=; b=ZYJ8C3RxiGEPbWFtIXjRPkM59W
        sru2KByW3HIzP2hQPaAyW4Cw6bKx2JjtYevRI7O+wrSriourpVabI7o2eSa5miBvEGeZuX15BkUC2
        omEq4h1sV5ayhhk2SBAN+MJFZKhao90FjW/wyW3Z9DsuaFMHR4Ai28EHerkMQoi4WYXJ1lQSl+iN7
        UAvoqI/ZQ0JpAPRCD8tE/8hKYgtTRjSVdA5Yy1PIT+Va9pfJoTPqpIHO8BNUGs8k8wrfM7ff02/tJ
        0ze/wAL9+MPwmPcI1rac1i4GaqYSFDoUuPWRBXYRRXfUJM4E0rvl6SWQ85PCtAK9hRe6cNOpS1lUF
        jSd/7+Ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llwQ5-004hNf-HH; Wed, 26 May 2021 16:30:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E071430022A;
        Wed, 26 May 2021 18:30:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C6453201D301D; Wed, 26 May 2021 18:30:08 +0200 (CEST)
Date:   Wed, 26 May 2021 18:30:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 13/22] sched: Allow task CPU affinity to be restricted
 on asymmetric systems
Message-ID: <YK53kDtczHIYumDC@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-14-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525151432.16875-14-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 04:14:23PM +0100, Will Deacon wrote:
> @@ -2426,20 +2421,166 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  
>  	__do_set_cpus_allowed(p, new_mask, flags);
>  
> -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
> +	if (flags & SCA_USER)
> +		release_user_cpus_ptr(p);
> +
> +	return affine_move_task(rq, p, rf, dest_cpu, flags);
>  
>  out:
> -	task_rq_unlock(rq, p, &rf);
> +	task_rq_unlock(rq, p, rf);
>  
>  	return ret;
>  }

So sys_sched_setaffinity() releases the user_cpus_ptr thingy ?! How does
that work?

I thought the intended semantics were somethings like:

	A - 0xff			B

	restrict(0xf) // user: 0xff eff: 0xf

					sched_setaffinity(A, 0x3c) // user: 0x3c eff: 0xc

	relax() // user: NULL, eff: 0x3c


