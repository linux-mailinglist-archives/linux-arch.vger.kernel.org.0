Return-Path: <linux-arch+bounces-13358-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED0B40C53
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 19:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83CF85648CC
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 17:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B432E06EA;
	Tue,  2 Sep 2025 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWzaZhRU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDE213E7A;
	Tue,  2 Sep 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756835039; cv=none; b=qbpRsEzIoISDMKFksWD3Xbj3c2fDS1yqgGDm28e1qPf/6U9K1Vzo7VM2crXs4cS9wjKB+uGIC0NeQ5ryGljC8zCI6jlXOK8ywlIRiPQfAwYjGg44Ymq44X4rXgLiPUqJlztSVKnjyuoOjImE/UOceCJ27INWmlOgsOSP4CbHED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756835039; c=relaxed/simple;
	bh=Vme36lNSGQ23tNgKQ2c9wO6J1JV4k7r3beNMjqDeJKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPFWNI2seRRV0Mjz5cbGZoCQqw6mqLj0KofXk+Qe2Gb8xaGb4f32NCbtwooGiCv4hK8PQGuKwYikA4gNl3w3A5YlaIpB+U+Byc+icXM0/Xs3dHl3J6bR1kSlGLaPISkA+8Beri4mNpzXlqAE6S+y+T+e6jrVattUCkffWfXVkYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWzaZhRU; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3cf48ec9fa4so3104213f8f.0;
        Tue, 02 Sep 2025 10:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756835036; x=1757439836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYP2onSUJNHhGvq3oMvWn0G6NURkvkxAY3WWJ1PkhtM=;
        b=EWzaZhRUbAif3VB8IJCEePifGTQgX4OrTsrCnqFMps68pUFOA1JYA91qOyqoRvQGn6
         9T+11nxHU5UwbzpGkJSZ/TjZ0HK/xYXvQlbqp0AiIgUrxxF/OpKTXwyhAh1QCmqBAIsN
         xPKIb81m19WeynV//VCz4tYv6BewaAUCyIUlbQBm1/PYh8gB6BFV1gUUCmPuA34Vu0If
         J8iqyx2ttpkP4WgApK2bCDD55k8Np2Bf3k45ZZ1uwl+ni7qcWQOR2+oP95JtT0IAmj14
         lU+6/7qqOv8NL5MMrS+wFUWd4oElX79X1CjZVmqKmQbK+IAlGWXgdpwrI/Wczi+PelBX
         1oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756835036; x=1757439836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYP2onSUJNHhGvq3oMvWn0G6NURkvkxAY3WWJ1PkhtM=;
        b=bI1NDtHjCGoa2pkLDvGwFaEoV/Gi+sSdb5heFH3xHimPxAwMenhxh9tBaW/esIWBe+
         NYW+pUYnGzKHmub8T8jeuSAhjsAwD7aHxvvCDO/sKrzGTKW0hZHRwpWFevG9PdObtUOf
         lLOspsiI0DAUef6+4wM5Cjih0mbx39gXWIbCC+ucPISAlMFMmBPrjBE8gAcO7j8TdUYl
         zlCri4cGNPEZNmi+arqY03hwEFRFAymEdW03nYU0wGJKHc7d255rnm4TQ9uBy6YFwvHC
         wwzctWxZ581FhJiiROrJTk+lk4QwhvRWXNcHo9DqlgYYAcuPSMgeRY8ddHnqaUT6Jq3f
         u/YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQjWmJD5QMYCs4bt66vZE3S186bVVjbNC6J4bZXDmcKtQk7MnvE50+RKzLQNfwCis1yMxnkb8lKRFcCw==@vger.kernel.org, AJvYcCW65Pz4ma23BjsUlcnq8uCBDve5d8YE7xhVI2uTjBmW36yDP6Uc38dbFGpk2bzDvMBeu9BYdZ6v8ica6P7C@vger.kernel.org, AJvYcCWayIZ81PM0Z08F+zn0sULrtV5IBE0I6j7Se9NkAga2mUhxDWpVjIgPWsHTvH54KUY0U2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+srxgUiv/flPwa38olpr5wDhrF98NEszC/l9SNfmT/MFaw0DR
	VfAUGLSDW/V0Q8bDGbwpr6sbGpNLLGhVRngyl+l59ws2Zjks22ssNrq2EvQtEs9IVKi1aPL1ruh
	sJZkL7T4OozNBp35HDLBLxz0WRe3a5UY=
X-Gm-Gg: ASbGncuIgl0b+vrRMUYr68pNuPvO144l3bJRGA4Sxh8YeWiREFcz5a3FmLVOG5yC+6/
	2MktddL8rIa2KY3bN28UobsBfOTRdy4ecYLQGJljb7a9/ZuhYPbqbJxpX9q56ks66dvbz6vElWY
	OwHKM+Naem7Al1+V4w0T9ga/qsS4v7vGeQZwv0wgjX5yHLH28qlBH5uZJz+OZixHOXvxYt7RILU
	mx5hzDBOVjQ6dqJZdXwG7BUD5OJ4tcUUA==
X-Google-Smtp-Source: AGHT+IGnbXb7pZEEKjDl3Xb/VVDaXmOkLzTurvRIsV32P0sxrEfn6u8c4/IIuiIksHosRpAojQeaElZ2NxTEaXB5bnc=
X-Received: by 2002:a05:6000:22c4:b0:3ce:5408:3e9b with SMTP id
 ffacd0b85a97d-3d1de4bc312mr10005305f8f.32.1756835035509; Tue, 02 Sep 2025
 10:43:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-6-ankur.a.arora@oracle.com> <aLWDcJiZWD7g8-4S@arm.com>
In-Reply-To: <aLWDcJiZWD7g8-4S@arm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 10:43:41 -0700
X-Gm-Features: Ac12FXxPt48d0DrkO5T5_o7KXQLuNvB-VRFsY3mAwjR3V9x2L6YyOpjWOTrBYoQ
Message-ID: <CAADnVQJf317mXSDLs=K0pzTDGqMA8vqSDoNm5=LvEst6kdAi6w@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] rqspinlock: use smp_cond_load_acquire_timewait()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf <bpf@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, harisokn@amazon.com, 
	cl@gentwo.org, Alexei Starovoitov <ast@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
	joao.m.martins@oracle.com, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 4:28=E2=80=AFAM Catalin Marinas <catalin.marinas@arm=
.com> wrote:
>
> On Fri, Aug 29, 2025 at 01:07:35AM -0700, Ankur Arora wrote:
> > diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/a=
sm/rqspinlock.h
> > index a385603436e9..ce8feadeb9a9 100644
> > --- a/arch/arm64/include/asm/rqspinlock.h
> > +++ b/arch/arm64/include/asm/rqspinlock.h
> > @@ -3,6 +3,9 @@
> >  #define _ASM_RQSPINLOCK_H
> >
> >  #include <asm/barrier.h>
> > +
> > +#define res_smp_cond_load_acquire_waiting() arch_timer_evtstrm_availab=
le()
>
> More on this below, I don't think we should define it.
>
> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> > index 5ab354d55d82..8de1395422e8 100644
> > --- a/kernel/bpf/rqspinlock.c
> > +++ b/kernel/bpf/rqspinlock.c
> > @@ -82,6 +82,7 @@ struct rqspinlock_timeout {
> >       u64 duration;
> >       u64 cur;
> >       u16 spin;
> > +     u8  wait;
> >  };
> >
> >  #define RES_TIMEOUT_VAL      2
> > @@ -241,26 +242,20 @@ static noinline int check_timeout(rqspinlock_t *l=
ock, u32 mask,
> >  }
> >
> >  /*
> > - * Do not amortize with spins when res_smp_cond_load_acquire is define=
d,
> > - * as the macro does internal amortization for us.
> > + * Only amortize with spins when we don't have a waiting implementatio=
n.
> >   */
> > -#ifndef res_smp_cond_load_acquire
> >  #define RES_CHECK_TIMEOUT(ts, ret, mask)                              =
\
> >       ({                                                            \
> > -             if (!(ts).spin++)                                     \
> > +             if ((ts).wait || !(ts).spin++)                \
> >                       (ret) =3D check_timeout((lock), (mask), &(ts)); \
> >               (ret);                                                \
> >       })
> > -#else
> > -#define RES_CHECK_TIMEOUT(ts, ret, mask)                           \
> > -     ({ (ret) =3D check_timeout((lock), (mask), &(ts)); })
> > -#endif
>
> IIUC, RES_CHECK_TIMEOUT in the current res_smp_cond_load_acquire() usage
> doesn't amortise the spins, as the comment suggests, but rather the
> calls to check_timeout(). This is fine, it matches the behaviour of
> smp_cond_load_relaxed_timewait() you introduced in the first patch. The
> only difference is the number of spins - 200 (matching poll_idle) vs 64K
> above. Does 200 work for the above?
>
> >  /*
> >   * Initialize the 'spin' member.
> >   * Set spin member to 0 to trigger AA/ABBA checks immediately.
> >   */
> > -#define RES_INIT_TIMEOUT(ts) ({ (ts).spin =3D 0; })
> > +#define RES_INIT_TIMEOUT(ts) ({ (ts).spin =3D 0; (ts).wait =3D res_smp=
_cond_load_acquire_waiting(); })
>
> First of all, I don't really like the smp_cond_load_acquire_waiting(),
> that's an implementation detail of smp_cond_load_*_timewait() that
> shouldn't leak outside. But more importantly, RES_CHECK_TIMEOUT() is
> also used outside the smp_cond_load_acquire_timewait() condition. The
> (ts).wait check only makes sense when used together with the WFE
> waiting.

+1 to the above.

Penalizing all other architectures with pointless runtime check:

> -             if (!(ts).spin++)                                     \
> +             if ((ts).wait || !(ts).spin++)                \

is not acceptable.

