Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15A7399E28
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 11:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFCJx6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 05:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhFCJx6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 05:53:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EABEF613DA;
        Thu,  3 Jun 2021 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622713934;
        bh=jAEXIZ/nUnfkivzRkb18fUwoN/7URkHoNnzScjR6ylQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1epUq1UQCB6cSC7WqV7EaQ+gqzdTfG6a1gl+PxZV0B0SyPhJ9uyKtSRJPW511eMq
         AAXBSSeqPzKoUDBfDSeBeXvuggg+NnERdHUHMIh7mbdu+fCsBbWmnAEVu6yceLGNt0
         g6zjCzj3r2rroc81bX9vy6KUygqYDe2HVwz/rtyoAsj4QIgfgH7KtLUMgp6DH7cOdE
         eagIp9pz1DoWX/Vp3+Q8jREkWbHrNuU/OuugrI4RMuGKcP3cC1c8unDU7YPLY27Pf/
         MuyLjsDvn48PfjeNAnpxjfm2nmwDnzAxq/5tY+F+kT403DRUILI9aOzwzjWJWhIRpk
         b4XB7Q9I5WArA==
Date:   Thu, 3 Jun 2021 10:52:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v8 12/19] sched: Introduce task_cpus_dl_admissible() to
 check proposed affinity
Message-ID: <20210603095207.GA32641@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-13-will@kernel.org>
 <5ab65165-49e6-633f-d4a5-9538fb72cc36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ab65165-49e6-633f-d4a5-9538fb72cc36@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 11:43:08AM +0200, Daniel Bristot de Oliveira wrote:
> On 6/2/21 6:47 PM, Will Deacon wrote:
> > In preparation for restricting the affinity of a task during execve()
> > on arm64, introduce a new task_cpus_dl_admissible() helper function to
> > give an indication as to whether the restricted mask is admissible for
> > a deadline task.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  include/linux/sched.h |  6 ++++++
> >  kernel/sched/core.c   | 44 +++++++++++++++++++++++++++----------------
> >  2 files changed, 34 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 91a6cfeae242..9b17d8cfa6ef 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1691,6 +1691,7 @@ extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new
> >  extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
> >  extern int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src, int node);
> >  extern void release_user_cpus_ptr(struct task_struct *p);
> > +extern bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask);
> >  extern void force_compatible_cpus_allowed_ptr(struct task_struct *p);
> >  extern void relax_compatible_cpus_allowed_ptr(struct task_struct *p);
> >  #else
> > @@ -1713,6 +1714,11 @@ static inline void release_user_cpus_ptr(struct task_struct *p)
> >  {
> >  	WARN_ON(p->user_cpus_ptr);
> >  }
> > +
> > +static inline bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask)
> > +{
> > +	return true;
> > +}
> >  #endif
> >  
> >  extern int yield_to(struct task_struct *p, bool preempt);
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 58e2cf7520c0..b4f8dc18ae11 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6933,6 +6933,31 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
> >  	return retval;
> >  }
> >  
> > +#ifdef CONFIG_SMP
> > +bool task_cpus_dl_admissible(struct task_struct *p, const struct cpumask *mask)
> 
> Would you mind renaming it to dl_task_check_affinity(), in the case of a v9? It
> will look coherent with dl_task_can_attach()...

Of course! I struggled with the naming myself, and your suggestion is much
better.

> Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Cheers!

Will
