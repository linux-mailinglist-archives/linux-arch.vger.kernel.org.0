Return-Path: <linux-arch+bounces-3002-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1095287C0C9
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0490284923
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747837317E;
	Thu, 14 Mar 2024 15:59:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63116EB74;
	Thu, 14 Mar 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431993; cv=none; b=fRes4FBxBIt0NkAdOboqNDGwPsOiYzisq+WDKBxVqZIVvKetFsUtsSqXNG4WZ7fk/EVEGiSEmdlBBFe/n1DwFbKZeWrJg1mbuWRsce6HnpZE3Lzyh6oKvrws1kBPfAytnSitliVDkN26W3t7BiSKac/iGgkMR+i75MleB3ep0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431993; c=relaxed/simple;
	bh=okaw4O3R57c6tEMT0TJSs1UtnZZCStffxFfDr2xlyHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeNHzxxsVnfkXCjyuZrVl9Yz4ZPzdStJRtSAp7dmCJ1Du41C1qBhU6mOltq7qPkTa/O0eJyh8Q6AeHY3mBOTCOUh3ghvnlLSdVXRlMZdXEA0ZLuBFj09hKbZSFheR37EzmMe2h0yZBVIxmPMxTwr7lESVOgnFc4oHEGSbu0jx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA7E1007;
	Thu, 14 Mar 2024 09:00:25 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.69.235])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 281FB3F762;
	Thu, 14 Mar 2024 08:59:45 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:59:39 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, richardcochran@gmail.com,
	luto@kernel.org, datglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org,
	peterz@infradead.org, hannes@cmpxchg.org, sohil.mehta@intel.com,
	rick.p.edgecombe@intel.com, nphamcs@gmail.com, palmer@sifive.com,
	keescook@chromium.org, legion@kernel.org, mszeredi@redhat.com,
	casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net,
	brauner@kernel.org, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
Message-ID: <ZfMe66MfHBEfxrdd@FVFF77S0Q05N>
References: <20240314090540.14091-1-maimon.sagi@gmail.com>
 <87a5n1m5j1.ffs@tglx>
 <CAMuE1bH_H9E+Zx365G9AtmWSmhW-kPPB+-=8s2rH4hpxqE+dHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuE1bH_H9E+Zx365G9AtmWSmhW-kPPB+-=8s2rH4hpxqE+dHQ@mail.gmail.com>

On Thu, Mar 14, 2024 at 02:19:39PM +0200, Sagi Maimon wrote:
> On Thu, Mar 14, 2024 at 1:12 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, Mar 14 2024 at 11:05, Sagi Maimon wrote:
> > > +     if (crosstime_support_a) {
> > > +             ktime_a = ktime_sub(xtstamp_a2.device, xtstamp_a1.device);
> > > +             ts_offs_err = ktime_divns(ktime_a, 2);
> > > +             ktime_a = ktime_add_ns(xtstamp_a1.device, (u64)ts_offs_err);
> > > +             ts_a1 = ktime_to_timespec64(ktime_a);
> >
> > This is just wrong.
> >
> >      read(a1);
> >      read(b);
> >      read(a2);
> >
> > You _CANNOT_ assume that (a1 + ((a2 - a1) / 2) is anywhere close to the
> > point in time where 'b' is read. This code is preemtible and
> > interruptible. I explained this to you before.
> >
> > Your explanation in the comment above the function is just wishful
> > thinking.
> >
> you explained it before, but still it is better then two consecutive
> user space calls which are also preemptible
> and the userspace to kernel context switch time is added.

How much "better" is that in reality?

The time for a user<->kernel transition should be trivial relative to the time
a task spends not running after having been preempted.

Either:

(a) Your userspace application can handle the arbitrary delta resulting from a
    preemption, in which case the trivial cost shouldn't matter.

    i.e. this patch *is not necessary* to solve your problem.

(b) Your userspace application cannot handle the arbitrary delta resulting from
    a preemption, in which case you need to do something to handle that, which
    you haven't described at all.
  
    i.e. with the information you have provided so far, this patch is
    *insufficient* to solve your problem.

> > > + * In other cases: Read clock_a twice (before, and after reading clock_b) and
> > > + * average these times – to be as close as possible to the time we read clock_b.
> >
> > Can you please sit down and provide a precise technical description of
> > the problem you are trying to solve and explain your proposed solution
> > at the conceptual level instead of throwing out random implementations
> > every few days?

100% agreed.

Please, explain the actual problem you are solving here. What *specifically*
are you trying to do in userspace with these values? "Synchronization" is too
vague a description.

Making what is already the best case *marginally better* without handling the
common and worst cases is a waste of time. It doesn't actually solve the
problem, and it misleads people into thinknig that a problem is solved when it
is not.

Mark.

