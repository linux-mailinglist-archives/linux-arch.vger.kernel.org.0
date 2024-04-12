Return-Path: <linux-arch+bounces-3617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF98A2C39
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988BF1C21933
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411CE53818;
	Fri, 12 Apr 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY5GTtGO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EB54273;
	Fri, 12 Apr 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917384; cv=none; b=Z5ozGF4kBGXLeExxGSWrfZBRJroz0GSUtMdLmxU8ZmyDeH2jeVP2/pjVUWQ3chH9qtgyXKbOtEHtvW6Q6NQDWQXAVSNBMHZUdWWbNfWYFqEbDa5j24dvjULPKFP8uCmBaHhDhFkp3G87yOP8OE2/YN/qHNd91YiaJHoMOQ9cKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917384; c=relaxed/simple;
	bh=lx/mzNmYe+gTjPQ6nAnsnztHRku3uCOcq194Vk7GP8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPO9Z9NVXhWU5YsRORbmxmrhSWUZH2nDFNyzdoiiO5QUv8pRS0/RjMXXDKoCeuuAfgxO5jKSt8GIJegL2eLuz365jTZau8XHI7qYhluoojdmX+7M7cX7FBImpHn5UXdwVdbf7WR4QMos2Gt5e/0fXr45Mxe+GqDLthZIf32xSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY5GTtGO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso756765a12.0;
        Fri, 12 Apr 2024 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712917380; x=1713522180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzOdBlKYaerdid9lqA521iJH25UlFopxA3ir8MLFtZ8=;
        b=ZY5GTtGOODnKbLi7O0QzTZa4baEiwFebORcHGHlZXeeuvEhHNdRwKQVP2XS3B/gbTC
         w2aNM0Y1vp9pT2zxE4s9euJbBFCqHJIYul4C0c/P4E6ViM/fm255v5xZ+ESTN4oXFUWv
         Vy6+AOZV9apjHdJN2f51zldeVH1KhWs1jUTVjxoWAEwo6W/sU5OTsYvEvI14Px+6wJcK
         vd0Zo5AQA7q/XYJREn0PnecAreemlStyA8E0qIHnm7a0GSbahT3hA7I+yDYKj/ydofF+
         Rl8Fu4NUuA/F2Y8QdNMHgYSQTUkU1iTKX+kRu8v/hWJDNn3kmSWdsoAMVverUb2Iz19z
         YCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712917380; x=1713522180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzOdBlKYaerdid9lqA521iJH25UlFopxA3ir8MLFtZ8=;
        b=I3YIFZAWFx5JSN3JwD8bFXIhigCpf4CRdGkR1uMDPgMSD1Pg7L+MtMqKsgKYkJA1rB
         OxX130J0ywRHNOjg5HDHowM1H+x9/9ynD52Xo84zmm0hejHVP+hdECuArqyyopbpXdUT
         jKA9Ptvna2PRJmfnQU6INEhrC++ZQdgE53xVY9iE7lDA8KsfI4pItchD+qjQzEUDm6bI
         7Eb5V7lcVwq4etvwCdOzl8VyPPXOkg2OLoQGBFoz3eNlrVUxV3d6uvPVK7g4NLiS34d/
         QWXAvnKk2YV2DR3+ddd1SzK1Yn+GxjAP8t93t6EfwXyWZ0JFslmvoie2gZWsGaf25+IK
         f1gg==
X-Forwarded-Encrypted: i=1; AJvYcCUe5cMOXA8KkZf/GH5biMdW0D0BFLodEUfMwUK7iseijfsZUOdA+mmv6CN+ibmuxfyUfGSZnYedwujb5WCsob/0O2meUR0X9WlLt2QQiyRhGDcR7nUd+6eETumye+P0upHPCU8YUs/GAOL80gecqxPjGUz4HB5oMFvNha38V1y7mw==
X-Gm-Message-State: AOJu0Yw0FJ+TNeNB/7n96BbjAl+T0u1Vs5qTidlqR/BN29edvOOtr5Ku
	kEhKFs5wASAScnQ5zAD1zPri1JZPkMZs1EPef6r0IO7e6ujTaK4a
X-Google-Smtp-Source: AGHT+IEcQ9QlbNTawUPcRzL9ZfPgkeLxXYdp8hA6uGuutwA12jpqExjzZsC94ItVvXq6MAtW7xeb+w==
X-Received: by 2002:a50:cd5c:0:b0:56c:5a49:730 with SMTP id d28-20020a50cd5c000000b0056c5a490730mr1497914edj.19.1712917380143;
        Fri, 12 Apr 2024 03:23:00 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id fj11-20020a0564022b8b00b0056e6a0ec702sm1515248edb.65.2024.04.12.03.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 03:22:59 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 12 Apr 2024 12:22:56 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, "levi . yun" <yeoreum.yun@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	Aaron Lu <aaron.lu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH] sched: Add missing memory barrier in switch_mm_cid
Message-ID: <ZhkLgJ2ZkI3JO0m/@gmail.com>
References: <20240411174302.353889-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411174302.353889-1-mathieu.desnoyers@efficios.com>


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Many architectures' switch_mm() (e.g. arm64) do not have an smp_mb()
> which the core scheduler code has depended upon since commit:
> 
>     commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
> 
> If switch_mm() doesn't call smp_mb(), sched_mm_cid_remote_clear() can
> unset the actively used cid when it fails to observe active task after it
> sets lazy_put.
> 
> There *is* a memory barrier between storing to rq->curr and _return to
> userspace_ (as required by membarrier), but the rseq mm_cid has stricter
> requirements: the barrier needs to be issued between store to rq->curr
> and switch_mm_cid(), which happens earlier than:
> 
> - spin_unlock(),
> - switch_to().
> 
> So it's fine when the architecture switch_mm() happens to have that
> barrier already, but less so when the architecture only provides the
> full barrier in switch_to() or spin_unlock().
> 
> It is a bug in the rseq switch_mm_cid() implementation. All architectures
> that don't have memory barriers in switch_mm(), but rather have the full
> barrier either in finish_lock_switch() or switch_to() have them too late
> for the needs of switch_mm_cid().
> 
> Introduce a new smp_mb__after_switch_mm(), defined as smp_mb() in the
> generic barrier.h header, and use it in switch_mm_cid() for scheduler
> transitions where switch_mm() is expected to provide a memory barrier.
> 
> Architectures can override smp_mb__after_switch_mm() if their
> switch_mm() implementation provides an implicit memory barrier.
> Override it with a no-op on x86 which implicitly provide this memory
> barrier by writing to CR3.
> 
> Link: https://lore.kernel.org/lkml/20240305145335.2696125-1-yeoreum.yun@arm.com/
> Reported-by: levi.yun <yeoreum.yun@arm.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com> # for arm64
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Cc: <stable@vger.kernel.org> # 6.4.x
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: levi.yun <yeoreum.yun@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Aaron Lu <aaron.lu@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: x86@kernel.org
> ---
>  arch/x86/include/asm/barrier.h |  3 +++
>  include/asm-generic/barrier.h  |  8 ++++++++
>  kernel/sched/sched.h           | 20 ++++++++++++++------
>  3 files changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 0216f63a366b..d0795b5fab46 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -79,6 +79,9 @@ do {									\
>  #define __smp_mb__before_atomic()	do { } while (0)
>  #define __smp_mb__after_atomic()	do { } while (0)
>  
> +/* Writing to CR3 provides a full memory barrier in switch_mm(). */
> +#define smp_mb__after_switch_mm()	do { } while (0)
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif /* _ASM_X86_BARRIER_H */
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 961f4d88f9ef..5a6c94d7a598 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -296,5 +296,13 @@ do {									\
>  #define io_stop_wc() do { } while (0)
>  #endif
>  
> +/*
> + * Architectures that guarantee an implicit smp_mb() in switch_mm()
> + * can override smp_mb__after_switch_mm.
> + */
> +#ifndef smp_mb__after_switch_mm
> +#define smp_mb__after_switch_mm()	smp_mb()
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  #endif /* __ASM_GENERIC_BARRIER_H */
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 001fe047bd5d..35717359d3ca 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -79,6 +79,8 @@
>  # include <asm/paravirt_api_clock.h>
>  #endif
>  
> +#include <asm/barrier.h>
> +
>  #include "cpupri.h"
>  #include "cpudeadline.h"
>  
> @@ -3445,13 +3447,19 @@ static inline void switch_mm_cid(struct rq *rq,
>  		 * between rq->curr store and load of {prev,next}->mm->pcpu_cid[cpu].
>  		 * Provide it here.
>  		 */
> -		if (!prev->mm)                          // from kernel
> +		if (!prev->mm) {                        // from kernel
>  			smp_mb();
> -		/*
> -		 * user -> user transition guarantees a memory barrier through
> -		 * switch_mm() when current->mm changes. If current->mm is
> -		 * unchanged, no barrier is needed.
> -		 */
> +		} else {				// from user
> +			/*
> +			 * user -> user transition relies on an implicit
> +			 * memory barrier in switch_mm() when
> +			 * current->mm changes. If the architecture
> +			 * switch_mm() does not have an implicit memory
> +			 * barrier, it is emitted here.  If current->mm
> +			 * is unchanged, no barrier is needed.
> +			 */
> +			smp_mb__after_switch_mm();
> +		}
>  	}
>  	if (prev->mm_cid_active) {
>  		mm_cid_snapshot_time(rq, prev->mm);

Please move switch_mm_cid() from sched.h to core.c, where its only user 
resides.

Thanks,

	Ingo

