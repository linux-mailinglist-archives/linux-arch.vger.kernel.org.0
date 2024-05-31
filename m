Return-Path: <linux-arch+bounces-4637-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6138D661E
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 17:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0BE91C230B3
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2024 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7A2155C8B;
	Fri, 31 May 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/oMHs0B"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC85381A;
	Fri, 31 May 2024 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170738; cv=none; b=KZ8s5+dNcYF3xTZSWcVAq6uwixJzQCjJg5XuwJRR0ClHIZmrCJHMbSw+b2dNmr1Z4m1hvnYDCKJOloIDScDdaHrDZe7jK4nMOh40cqNULsNwFYyZLqkQ4BSDOvjCcATZcT3NFEVPYJ+JU+0FvR13u418dRUVceIqRHS2Sc+G4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170738; c=relaxed/simple;
	bh=9n/HcMCH5RfGL2g1X6Nd8u6p6mPRRHmonc8msy5CFLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sREljtYNg05K0mtjpK0E+/cXImZ56F7SRO5/d5FZ+SIwu2RwzdEPh6N9DqPxzExW05xdhfkX1sA5iYqpPPhIeT4Uk+E7BkOTJI9YQqiMqpnBw4l6Wzd8vPfLWhGmtgnHWYkDrcHx/QIG81pIIlXJr623yCk2YQ2huWRbBve8GBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/oMHs0B; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5785f7347cdso2339159a12.0;
        Fri, 31 May 2024 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717170735; x=1717775535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1+QjxjxBPrIugYD0OZnRQMiPTgmwtCBI97ys8OyOiU=;
        b=Z/oMHs0BrnuWlD2bNsp9D8bo0m/ftvTp30fTx3xmDxsrKDne3sU+4tpXEhLSr6nLvf
         MCJ2j+nRACARomAf67QSVEBvd2H1BbM2zzDlatHRjYNG0xFGSIbCIWrz97S/tXZXhm3V
         cla9OquNGKS8ECa9id4FiYDn6wgQjMdeFrC3VATLn2dbp+LKo8YXqGwEhSY1SJsdrw/O
         kPe74KZPPrJs+5/w2jIwH95Wd8LSWVycevFevGSXPaiBFUmNl1iVsoRKlIreQ6dLWdLU
         bFeXJCwsbi9t+7pCHkdwPoxxSVN1hN/SwSTr3XjS3h9YF10PvoPWm5awX6Vd7ThJ3SAZ
         Medg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717170735; x=1717775535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1+QjxjxBPrIugYD0OZnRQMiPTgmwtCBI97ys8OyOiU=;
        b=BUKzZO2jTKQIK2dJ1FrMqAKZ72U+qDGLTXiyK8R75wBLk66lsA+3iI5STQuvqC01hA
         y3rwhhnSR6OrXCnzDm62obxWLIGHqw1c0AcRkf28ME3LzxfLtmgi4hOVY+D/IXj7pnbq
         k7NNQbec+WkLWAsQ6/YbcmV1kaHxk4QdBuvZA5EvCoeKMccxCXPPGvpUQuRnXgjaR9kW
         eIB3B9u5Hmn2fZdbG5fUTIRAQit7Or2y+IED9QyjD/00kLyY9TD+ptH75bLxkUJTptBG
         YfzX+Vfj3r1oXI+2xA9Xey6ZkUoU+kO1tnrhbIhkAgYHWxstDzJaFleOEZiWN1O2XlQF
         VnHw==
X-Forwarded-Encrypted: i=1; AJvYcCUsGVph7JGPLn3T4alt7Hx98xhk4KWWTo+8QwNolIOPyuPVp+bP+rGKPzrwApgRW1eO1bHjgZTKIvWj840pHxyGyYBNjxXXIi49oyrAbqEhuMN23CNbmaN5hMoGdu6n3KnMJqx8O+xaCIxbVBM+JGAj+ZQW8ymG2cibVY1enqwMeQa3Zg==
X-Gm-Message-State: AOJu0YyGEEjNzizW4l2osGKwEpGUqT/AhdYMJMIXSOipVR3JCB0djoyO
	VCXpB8LYHCuG0K+vVRlzAFUUtnvfk+95NU3223303L0urg3N0U4t
X-Google-Smtp-Source: AGHT+IGbfRp1452zzCRnB9sJc29htGrbuzhsS6g6C0EBQQxO8KLQ7fkvTbV09Id0Zo9VJiu87sACYg==
X-Received: by 2002:a50:d4d2:0:b0:56e:99e:1fac with SMTP id 4fb4d7f45d1cf-57a365a0b9cmr1818306a12.39.1717170734692;
        Fri, 31 May 2024 08:52:14 -0700 (PDT)
Received: from andrea ([151.76.32.59])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b98e01sm1135963a12.16.2024.05.31.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 08:52:14 -0700 (PDT)
Date: Fri, 31 May 2024 17:52:09 +0200
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 7/7] riscv: Add qspinlock support based on Zabha extension
Message-ID: <ZlnyKclZOQdrJTtU@andrea>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-8-alexghiti@rivosinc.com>
 <ZlZ8/Nv3QS99AgY9@andrea>
 <39a9b28c-2792-45ce-a8c6-1703cab0f2de@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a9b28c-2792-45ce-a8c6-1703cab0f2de@ghiti.fr>

> > > +	select ARCH_USE_QUEUED_SPINLOCKS if TOOLCHAIN_HAS_ZABHA
> > IIUC, we should make sure qspinlocks run with ARCH_WEAK_RELEASE_ACQUIRE,
> > perhaps a similar select for the latter?  (not a kconfig expert)
> 
> 
> Where did you see this dependency? And if that is really a dependency of
> qspinlocks, shouldn't this be under CONFIG_QUEUED_SPINLOCKS? (not a Kconfig
> expert too).

The comment on smp_mb__after_unlock_lock() in include/linux/rcupdate.h
(the barrier is currently only used by the RCU subsystem) recalls:

  /*
   * Place this after a lock-acquisition primitive to guarantee that
   * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
   * if the UNLOCK and LOCK are executed by the same CPU or if the
   * UNLOCK and LOCK operate on the same lock variable.
   */
  #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE
  #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
  #else /* #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */
  #define smp_mb__after_unlock_lock()	do { } while (0)
  #endif /* #else #ifdef CONFIG_ARCH_WEAK_RELEASE_ACQUIRE */

Architectures whose UNLOCK+LOCK implementation does not (already) meet
the required "full barrier" ordering property (currently, only powerpc)
can overwrite the "default"/common #define for this barrier (NOP) and
meet the ordering by opting in for ARCH_WEAK_RELEASE_ACQUIRE.

The (current) "generic" ticket lock implementation provides "the full
barrier" in its LOCK operations (hence in part. in UNLOCK+LOCK), cf.

  arch_spin_trylock() -> atomic_try_cmpxchg()
  arch_spin_lock() -> atomic_fetch_add()
                   -> atomic_cond_read_acquire(); smp_mb()

but the "UNLOCK+LOCK pairs act as a full barrier" property doesn't hold
true for riscv (and powerpc) when switching over to queued spinlocks.
OTOH, I see no particular reason for other "users" of queued spinlocks
(notably, x86 and arm64) for selecting ARCH_WEAK_RELEASE_ACQUIRE.

But does this address your concern?  Let me know if I misunderstood it.

  Andrea

