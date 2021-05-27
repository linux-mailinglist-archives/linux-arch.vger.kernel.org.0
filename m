Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D48739291C
	for <lists+linux-arch@lfdr.de>; Thu, 27 May 2021 09:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhE0H6r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 May 2021 03:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhE0H6R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2021 03:58:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7681C06138B;
        Thu, 27 May 2021 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7vS+Qu0ROyOXMOHwL+bMWAA8km2aB6VnaLoAAsQzvU=; b=rXSRfMMSiXLXqF/ssBC0ntassy
        pBpDW4nGdTQ2Xz1vZMDozyyWzGu3DbFP9ZgeW5EdpMU82Y3+MolU/cPL2oeGpjHMSMraxNL+VsxGc
        DAhxXseMR1/30G5dAtNqb43s0YqemFdlRbEJr9Wvj3y4wNxSV6JadEmcdblLpYiYhBtMc0HaecQxb
        yXCfk3zXT9RqvVLBguKM/xUQxVTr+FSSlTp1pLPPZzMP7b5hxljnIMoE365EIKsDLjmduQ9WsKOuN
        ctomzDxTCQh4EDj9T98eqyYVYiVSOIjgTojxhz/2bC38u2UIEJd9M34oGHecq56mVDedMCABuMF0P
        X8w9r0lA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmAsS-000wyY-RR; Thu, 27 May 2021 07:56:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ACD7F300202;
        Thu, 27 May 2021 09:56:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 923102C6C99AE; Thu, 27 May 2021 09:56:30 +0200 (CEST)
Date:   Thu, 27 May 2021 09:56:30 +0200
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
Message-ID: <YK9Qrlr3dJt0Kjkp@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-14-will@kernel.org>
 <YK53kDtczHIYumDC@hirez.programming.kicks-ass.net>
 <20210526170206.GB19758@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526170206.GB19758@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 06:02:06PM +0100, Will Deacon wrote:
> On Wed, May 26, 2021 at 06:30:08PM +0200, Peter Zijlstra wrote:
> > On Tue, May 25, 2021 at 04:14:23PM +0100, Will Deacon wrote:
> > > @@ -2426,20 +2421,166 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> > >  
> > >  	__do_set_cpus_allowed(p, new_mask, flags);
> > >  
> > > -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
> > > +	if (flags & SCA_USER)
> > > +		release_user_cpus_ptr(p);
> > > +
> > > +	return affine_move_task(rq, p, rf, dest_cpu, flags);
> > >  
> > >  out:
> > > -	task_rq_unlock(rq, p, &rf);
> > > +	task_rq_unlock(rq, p, rf);
> > >  
> > >  	return ret;
> > >  }
> > 
> > So sys_sched_setaffinity() releases the user_cpus_ptr thingy ?! How does
> > that work?
> 
> Right, I think if the task explicitly changes its affinity then it makes
> sense to forget about what it had before. It then behaves very similar to
> CPU hotplug, which is the analogy I've been trying to follow: if you call
> sched_setaffinity() with a mask containing offline CPUs then those CPUs
> are not added back to the affinity mask when they are onlined.

Oh right, crap semantics all the way down :/ I always forget how
horrible they are.

You're right though; this is consistent with the current mess.
