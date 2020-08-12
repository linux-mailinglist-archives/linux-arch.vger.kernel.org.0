Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC48242698
	for <lists+linux-arch@lfdr.de>; Wed, 12 Aug 2020 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHLISf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Aug 2020 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgHLISf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2020 04:18:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA02C06174A;
        Wed, 12 Aug 2020 01:18:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so736578pjb.1;
        Wed, 12 Aug 2020 01:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=79f2Q6E1np8SG+am2XzUSjzcDBDgFqCYmgnZYDZDf0A=;
        b=nlhfMQnM79bkE++hU9UHzfAUO66rEjOEAxexFuScCLj0xVeTisj/51Sld5gT92RraL
         AIS1BNxrJdTMd/O/cmh0/IGywD8U+UHWRAWdJw4sn6pFNJ1aM+ZEFJykhekp8fyRlekv
         LNTPHdU9+KOMOqB4Be8S/E5WxkWJoog5eZn7ITX+DJUEKrw0BTVVaIMiHMlJ7VXRMMwo
         kiCYV0pib4I4ri3GTSoo9n57yoWVf8Vp7rHBmryszp5U/Rr18mZaWiOGWRmwA4iTrrCr
         KNrv3q9Zt3T+MKIrxclD6UrzJkuhy0i1V0g7GfQb/NXC/roh2pwnOrLc4NQSycPfN/Pr
         mMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=79f2Q6E1np8SG+am2XzUSjzcDBDgFqCYmgnZYDZDf0A=;
        b=jbIeel8cq2Pv6qd3hVQIjF5CUuIwdmuCeiFHWw/t7qtmYkV/WRp1rxENSZ/pE0ref6
         QtfUIcsaxfC7EYILcnhzD8AjXs/jQr4Oi1aBZtXrQmxwX7jCiV3V0/E/6M3HnzMRDWd/
         163hXcQjnzHBJ+XicavAK0PvFk8uAFEmpb5cKAspK9dvOdhDctCfxDbSeL7T9cIl9kqD
         Fb/GK9OPkMdXdD0SA+ZAikZPWGxdDhXxDQKGQ5oMjQH/9fxYgZwppUsifK4NVlVZEKmE
         uRMGOH13oL1KXsmVD9+oRHxelXVAYf54HKBdGmZ0FESHuMm1a9mg3jbByP2c8qcnqGt0
         /QaQ==
X-Gm-Message-State: AOAM532EcxYuWE6rfxVHpiQZ3c9n3r2P7HnMRwpyUGJ4yIVNTVqfgDMX
        j0U1TLJ4xUn0L9fVqQi0+iQ=
X-Google-Smtp-Source: ABdhPJxeeFrT8J1cTifNM8kGu2J2wqCIyrp58B7SlaMaeh8+s3Jr8gHNTZT1n1PHaZ/FvCH/wjcD2w==
X-Received: by 2002:a17:90b:f09:: with SMTP id br9mr5035461pjb.11.1597220314648;
        Wed, 12 Aug 2020 01:18:34 -0700 (PDT)
Received: from localhost (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id n15sm1501361pgs.25.2020.08.12.01.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:18:34 -0700 (PDT)
Date:   Wed, 12 Aug 2020 18:18:28 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     peterz@infradead.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200807111126.GI2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200807111126.GI2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1597220073.mbvcty6ghk.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from peterz@infradead.org's message of August 7, 2020 9:11 pm:
>=20
> What's wrong with something like this?
>=20
> AFAICT there's no reason to actually try and add IRQ tracing here, it's
> just a hand full of instructions at the most.

Because we may want to use that in other places as well, so it would
be nice to have tracing.

Hmm... also, I thought NMI context was free to call local_irq_save/restore
anyway so the bug would still be there in those cases?

Thanks,
Nick

>=20
> ---
>=20
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm=
/hw_irq.h
> index 3a0db7b0b46e..6be22c1838e2 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -196,33 +196,6 @@ static inline bool arch_irqs_disabled(void)
>  		arch_local_irq_restore(flags);				\
>  	} while(0)
> =20
> -#ifdef CONFIG_TRACE_IRQFLAGS
> -#define powerpc_local_irq_pmu_save(flags)			\
> -	 do {							\
> -		raw_local_irq_pmu_save(flags);			\
> -		trace_hardirqs_off();				\
> -	} while(0)
> -#define powerpc_local_irq_pmu_restore(flags)			\
> -	do {							\
> -		if (raw_irqs_disabled_flags(flags)) {		\
> -			raw_local_irq_pmu_restore(flags);	\
> -			trace_hardirqs_off();			\
> -		} else {					\
> -			trace_hardirqs_on();			\
> -			raw_local_irq_pmu_restore(flags);	\
> -		}						\
> -	} while(0)
> -#else
> -#define powerpc_local_irq_pmu_save(flags)			\
> -	do {							\
> -		raw_local_irq_pmu_save(flags);			\
> -	} while(0)
> -#define powerpc_local_irq_pmu_restore(flags)			\
> -	do {							\
> -		raw_local_irq_pmu_restore(flags);		\
> -	} while (0)
> -#endif  /* CONFIG_TRACE_IRQFLAGS */
> -
>  #endif /* CONFIG_PPC_BOOK3S */
> =20
>  #ifdef CONFIG_PPC_BOOK3E
> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/=
local.h
> index bc4bd19b7fc2..b357a35672b1 100644
> --- a/arch/powerpc/include/asm/local.h
> +++ b/arch/powerpc/include/asm/local.h
> @@ -32,9 +32,9 @@ static __inline__ void local_##op(long i, local_t *l)		=
	\
>  {									\
>  	unsigned long flags;						\
>  									\
> -	powerpc_local_irq_pmu_save(flags);				\
> +	raw_powerpc_local_irq_pmu_save(flags);				\
>  	l->v c_op i;						\
> -	powerpc_local_irq_pmu_restore(flags);				\
> +	raw_powerpc_local_irq_pmu_restore(flags);				\
>  }
> =20
>  #define LOCAL_OP_RETURN(op, c_op)					\
> @@ -43,9 +43,9 @@ static __inline__ long local_##op##_return(long a, loca=
l_t *l)		\
>  	long t;								\
>  	unsigned long flags;						\
>  									\
> -	powerpc_local_irq_pmu_save(flags);				\
> +	raw_powerpc_local_irq_pmu_save(flags);				\
>  	t =3D (l->v c_op a);						\
> -	powerpc_local_irq_pmu_restore(flags);				\
> +	raw_powerpc_local_irq_pmu_restore(flags);				\
>  									\
>  	return t;							\
>  }
> @@ -81,11 +81,11 @@ static __inline__ long local_cmpxchg(local_t *l, long=
 o, long n)
>  	long t;
>  	unsigned long flags;
> =20
> -	powerpc_local_irq_pmu_save(flags);
> +	raw_powerpc_local_irq_pmu_save(flags);
>  	t =3D l->v;
>  	if (t =3D=3D o)
>  		l->v =3D n;
> -	powerpc_local_irq_pmu_restore(flags);
> +	raw_powerpc_local_irq_pmu_restore(flags);
> =20
>  	return t;
>  }
> @@ -95,10 +95,10 @@ static __inline__ long local_xchg(local_t *l, long n)
>  	long t;
>  	unsigned long flags;
> =20
> -	powerpc_local_irq_pmu_save(flags);
> +	raw_powerpc_local_irq_pmu_save(flags);
>  	t =3D l->v;
>  	l->v =3D n;
> -	powerpc_local_irq_pmu_restore(flags);
> +	raw_powerpc_local_irq_pmu_restore(flags);
> =20
>  	return t;
>  }
> @@ -117,12 +117,12 @@ static __inline__ int local_add_unless(local_t *l, =
long a, long u)
>  	unsigned long flags;
>  	int ret =3D 0;
> =20
> -	powerpc_local_irq_pmu_save(flags);
> +	raw_powerpc_local_irq_pmu_save(flags);
>  	if (l->v !=3D u) {
>  		l->v +=3D a;
>  		ret =3D 1;
>  	}
> -	powerpc_local_irq_pmu_restore(flags);
> +	raw_powerpc_local_irq_pmu_restore(flags);
> =20
>  	return ret;
>  }
>=20
