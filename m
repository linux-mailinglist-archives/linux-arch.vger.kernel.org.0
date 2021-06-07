Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFD439E4B4
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhFGRGB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 13:06:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230241AbhFGRGB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 13:06:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0D9461029;
        Mon,  7 Jun 2021 17:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623085450;
        bh=zzJQore+lowtcv9O6JHxDMZEcl4v02jxhUQCoAvfyv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJR0xm+/yPCNzt4iDQlYCm2qtSjaU1XWDaEE6B6p9XKO2C26x9DHdooWSxqDsDRT+
         AWID0+IdNcriBy360Z0sX07evETUwSvycTZwLsKRiXQXcforpxx6R7eboVitosTEFB
         LYV7HX3VldkR0gQ8vCNok+/jaRY0yYu7WetiSbhbcGf3o/xTnkQNE98877KqzxgI/e
         1xshDzdYPfCxJz7RPE5rygSyGkucTOGBHCZv0hSGHT9Bk4iF1Jwwj5a6j6jNJiGaXQ
         IIRurX4C0zKIhGUEFhRDpJyBzHtKSEhHO9MDksr4j4uPPAEOb56qa9OeLmXeeqqKsh
         2uIOjoW37m6dw==
Date:   Mon, 7 Jun 2021 18:04:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
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
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v8 05/19] sched: Introduce task_cpu_possible_mask() to
 limit fallback rq selection
Message-ID: <20210607170403.GA7650@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-6-will@kernel.org>
 <878s3peesp.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s3peesp.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 06:10:46PM +0100, Valentin Schneider wrote:
> On 02/06/21 17:47, Will Deacon wrote:
> > Asymmetric systems may not offer the same level of userspace ISA support
> > across all CPUs, meaning that some applications cannot be executed by
> > some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> > not feature support for 32-bit applications on both clusters.
> >
> > On such a system, we must take care not to migrate a task to an
> > unsupported CPU when forcefully moving tasks in select_fallback_rq()
> > in response to a CPU hot-unplug operation.
> >
> > Introduce a task_cpu_possible_mask() hook which, given a task argument,
> > allows an architecture to return a cpumask of CPUs that are capable of
> > executing that task. The default implementation returns the
> > cpu_possible_mask, since sane machines do not suffer from per-cpu ISA
> > limitations that affect scheduling. The new mask is used when selecting
> > the fallback runqueue as a last resort before forcing a migration to the
> > first active CPU.
> >
> 
> Nit: Some uses of this mask (cpu_is_allowed(), __set_cpus_allowed_ptr())
> don't apply to kthreads. This makes sense for the 32-bit@EL0 faff, but it
> wouldn't hurt to point this out somewhere IMO.

That's a good point: even after these patches, we still assume the kernel
(and therefore kthreads) can run on all CPUs. I'll expand the comment.

> Also, that's an odd place for the definitions, but IIRC there isn't a much
> better choice.

Short of adding a new header just for this, I couldn't find anything, no.

> Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>

Thanks!

Will
