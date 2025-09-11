Return-Path: <linux-arch+bounces-13507-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0B1B53BF4
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 20:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88FA1C24677
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B5523E23C;
	Thu, 11 Sep 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmRsfn/N"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5A8188CB1
	for <linux-arch@vger.kernel.org>; Thu, 11 Sep 2025 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757617031; cv=none; b=rBeUBChCWcSCuqwne/TBlAaglxqmx6D1Rj6Qb2Nmn1qgLJlFmznfpw+vQvcrzNAafamFnSjCivtxXctxv0u4Oc/Ja8yErY4HAnCmldezKcHo2ywCjfkd4WS30vpSdNrKPwV5ejEz7cTX2732fjuAqQl7lZCOwI7r7P+b6FuCjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757617031; c=relaxed/simple;
	bh=s9bQCZmwLqgSpo6W3MThOpW7wZh6pS3/XtZlBy31OMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opu81IxG3rsAYYGWmivy5DFTAIE7jfxvizxr2eROBJr0OKaU5zQftcOv/K87fHkOS8eMQwTz6sAUFXygWLvFq78r5XVGr1Mwh0Jsy8yUqOAEXTGl9iBC5+KSVmXD9XdR+G5v1d1eoh2P4d1Bf1jYrLzXXeicRgjbgORYfLZCQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmRsfn/N; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so1436730a12.2
        for <linux-arch@vger.kernel.org>; Thu, 11 Sep 2025 11:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757617028; x=1758221828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pr9tX7pp1WDhvourRe0B/uP9WABiFIXN6KF2E46kYr8=;
        b=VmRsfn/NjoecdgCm5VD6IcHmT5U25QkMdKJI0QoSZ0NuFuYI3ZXuUCrutoVA9ug291
         uUVtAPKbIRdnSAZ3qliG9dV8ldDzr0ugv6oeDtrnI6Nc4sLHqIJrxPCGrtVhsHSli0q5
         e+mnOwqKaL1CF29Jlzze37wW0PadKTM6WR1OYR6Imx0gommAyzm0tfCHLcouAmIK/viR
         znUaU468UMJE4BGZIbwQlSqTN/VqKJrVOl2TKSwWX7Wxl87IvDxrRY5yFcGTUxKjixLs
         LybuOg9D3AZy+CsToMOA87QRhAbTQnOEm+LaSBipmqnRbUT61vhK3z+QTMrGQKFtOTuN
         Ftiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757617028; x=1758221828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr9tX7pp1WDhvourRe0B/uP9WABiFIXN6KF2E46kYr8=;
        b=nvNpAzMPS2031V61eRH1dkMtOJeaz55JDEUUoOOIQL7KzvpYJl6ofjZN5R7htHrUcA
         yCBLZXnW54JvaQZBzNoylkrXa/9n5UIRo6vSHrHKJdAWfOSqj69XNzUx/UNIA5VOJRbe
         JQQ9eFWAFslddLI3NCPxwwMNWu2TykLMedjTY7sLXXLeiQu8bYT6Cuedy6LohdXRlPyV
         j9lAaUSHqAxVFXA9zN88d/nuPhZWjKOhfd0bsYllT7SoBGX3Qqr2JLxHoPFTEQC4TOwp
         sthaR98+0tGbZ99OJI5nVXiNSWRIpCbjOygs5ExktvgBWjo2TyWjuJ2jROda/SF/t9pD
         aEhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4cYnk6M7uHFSt89RSoR7Pz54MjTGNBWQKC19cWo+sAcXGDYFdi+Oh0Dr5SaHYd0+uLhwNCJmuaGbm@vger.kernel.org
X-Gm-Message-State: AOJu0YxvRlQSxYMeycbv8WpaZtVjLjbT9SAHPz1q0ZAp8UP7zLEJnCRu
	Odf5HinDdfQ7/5sgEaVerCEN389dcY4xCUr0/SXQdLjBzjjhbcWolDeVCnH7cus5x/JHxwmznqS
	+AuMWmAV/GTd+AmT57FXoBYSc0kS43l0=
X-Gm-Gg: ASbGnctoJL/gvpHy5VqByN2CkfXSHodJb9k6FKbUDGqW6l6+/m3++xoL7DrfuEDiSCq
	eLsyjxiG04WOJd/ilPRlH9LZyhMaqsQSqCLSDBti/6Ogl4zzP/NX0z29tonBPhyOyegPBDb80nG
	5HlbJlbj8jwjpLX0boHQNA2eXc3uJ4+oB4f+5kgwZyZwMUyzgZGKL+hsw5Fs6cT3H+9E/uwxCCX
	iyRD6PNH92izFcbsJlYo3aLmAcUkg8F9EJDtHt4VKjmqJ3BqcE=
X-Google-Smtp-Source: AGHT+IGKxDih6ERXHwgyq0yZdSI3KYy7AT+aqJ67B4OiUGV2Ac/JxHPP/UIhhWHfeURuCo8qEbRbLD4HPdE5MiweW1U=
X-Received: by 2002:a05:6402:40d5:b0:61d:2405:b47c with SMTP id
 4fb4d7f45d1cf-62ed864bcc9mr495434a12.37.1757617028259; Thu, 11 Sep 2025
 11:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com> <aMLdZyjYqFY1xxFD@arm.com>
In-Reply-To: <aMLdZyjYqFY1xxFD@arm.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 11 Sep 2025 20:56:31 +0200
X-Gm-Features: AS18NWD_vDg9CGLpqBo3-WZ0dCqpbP__-WdZRDuhupRZ7xI3H77I9oF8KLziKGM
Message-ID: <CAP01T778qzHqNYanGtQ_UB9av9BtxLYdf2xWnJWtsf=-w=gANA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org, peterz@infradead.org, 
	akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com, 
	cl@gentwo.org, ast@kernel.org, zhenglifeng1@huawei.com, 
	xueshuai@linux.alibaba.com, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 16:32, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
> > Switch out the conditional load inerfaces used by rqspinlock
> > to smp_cond_read_acquire_timeout().
> > This interface handles the timeout check explicitly and does any
> > necessary amortization, so use check_timeout() directly.
>
> It's worth mentioning that the default smp_cond_load_acquire_timeout()
> implementation (without hardware support) only spins 200 times instead
> of 16K times in the rqspinlock code. That's probably fine but it would
> be good to have confirmation from Kumar or Alexei.
>
> > diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
> > index 5ab354d55d82..4d2c12d131ae 100644
> > --- a/kernel/bpf/rqspinlock.c
> > +++ b/kernel/bpf/rqspinlock.c
> [...]
> > @@ -313,11 +307,8 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
> >   */
> >  static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
> >
> > -#ifndef res_smp_cond_load_acquire
> > -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
> > -#endif
> > -
> > -#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
> > +#define res_atomic_cond_read_acquire_timeout(v, c, t)                \
> > +     smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
>
> BTW, we have atomic_cond_read_acquire() which accesses the 'counter' of
> an atomic_t. You might as well add an atomic_cond_read_acquire_timeout()
> in atomic.h than open-code the atomic_t internals here.
>

+1, and then drop res_atomic_cond_read_acquire_timeout from this file.

> Otherwise the patch looks fine to me, much simpler than the previous
> attempt.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

