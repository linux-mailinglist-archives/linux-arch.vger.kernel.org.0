Return-Path: <linux-arch+bounces-9035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD829C5742
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 13:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C321F225BE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03AF1CD1EE;
	Tue, 12 Nov 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmC4LlwZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E23A1BD4FB;
	Tue, 12 Nov 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413118; cv=none; b=TKWhfOeeEgREvY8/E+2zYKJ5s0TAfXqMx9LR/EwgZDS6A4KMnBiIF9H4tRlt2JYnrs16WmZmdTVO8mZzdqA2eo/mfQqwIyT9SJ8E/IRMlYheNXjOuwDqcBUDbNawngfyEmFlSPbKOAnyfUEGgt+ZTkMQIbrlpOY2f61LPGuER+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413118; c=relaxed/simple;
	bh=3cMtTIEGjOTBq/rpaFcUbPlOwMZMkBoEmZY0c/eZGYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/6ukcNQAilMnqEhY/uPfRFD0HuKGp9xBr2yQK0+zzLUZo+4vA3ZzZR/L9wH63erohRabEGmKYbfQiKE5uqfHC1b47EegygCC9ERdvqjpYZ7WCrUbWxC+xtE+6SrS4FKwwdY/yJ8dZF5Efg6MW6YOUWBHX1bo7DMGGmjtuwVy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmC4LlwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEA9C4CED0;
	Tue, 12 Nov 2024 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731413118;
	bh=3cMtTIEGjOTBq/rpaFcUbPlOwMZMkBoEmZY0c/eZGYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmC4LlwZY2UTiC4oBuvreQj8ilDpgg2S/9Z6CxKU00MgQq45EvwjhDjreUScg27is
	 WVfTdtbue/9dOdMrgp39oRqjofq56CONSuyfaUPMvM6YvIGA9GkU+Md0sdTKEmD32q
	 MtdwjwrB9uL29Po0BOANP3D7KXaeXFhYDibVr4BfyizhYGrrOc8KTsMTgKVsgwjpFq
	 wXFsNNnGGz/sI52AZyEpuHdkDQjxihs+l35FeT1Hq0sIdNeGjjj+JaKkse7IaNqSpk
	 OhS5iRFSPXiUweMQ7jzKT7hdBZNcrHm100q1V8Tlx85tBAhOwfV1drM6tMQndXpg2Q
	 evd/SSp/htn6Q==
Date: Tue, 12 Nov 2024 12:05:10 +0000
From: Will Deacon <will@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241112120510.GA21181@willie-the-truck>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com>
 <20241111164259.GA20042@willie-the-truck>
 <CAJF2gTTuvmtmKVFMZCTMxEWHrpSpqPE8QO4MC5njPAskGEmpig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTuvmtmKVFMZCTMxEWHrpSpqPE8QO4MC5njPAskGEmpig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Nov 12, 2024 at 09:49:15AM +0800, Guo Ren wrote:
> On Tue, Nov 12, 2024 at 12:43 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> > > In order to produce a generic kernel, a user can select
> > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > > spinlock implementation if Zabha or Ziccrse are not present.
> > >
> > > Note that we can't use alternatives here because the discovery of
> > > extensions is done too late and we need to start with the qspinlock
> > > implementation because the ticket spinlock implementation would pollute
> > > the spinlock value, so let's use static keys.
> >
> > I think the static key toggling takes a mutex (jump_label_lock()) which
> > can take a spinlock (lock->wait_lock) internally, so I don't grok how
> > this works:
> >
> > > +static void __init riscv_spinlock_init(void)
> > > +{
> > > +     char *using_ext = NULL;
> > > +
> > > +     if (IS_ENABLED(CONFIG_RISCV_TICKET_SPINLOCKS)) {
> > > +             pr_info("Ticket spinlock: enabled\n");
> > > +             return;
> > > +     }
> > > +
> > > +     if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA) &&
> > > +         IS_ENABLED(CONFIG_RISCV_ISA_ZACAS) &&
> > > +         riscv_isa_extension_available(NULL, ZABHA) &&
> > > +         riscv_isa_extension_available(NULL, ZACAS)) {
> > > +             using_ext = "using Zabha";
> > > +     } else if (riscv_isa_extension_available(NULL, ZICCRSE)) {
> > > +             using_ext = "using Ziccrse";
> > > +     }
> > > +#if defined(CONFIG_RISCV_COMBO_SPINLOCKS)
> > > +     else {
> > > +             static_branch_disable(&qspinlock_key);
> > > +             pr_info("Ticket spinlock: enabled\n");
> > > +             return;
> > > +     }
> > > +#endif
> >
> > i.e. we've potentially already used the qspinlock at this point.
> Yes, I've used qspinlock here. But riscv_spinlock_init is called with
> irq_disabled and smp_off. That means this qspinlock only performs a
> test-set lock behavior by qspinlock fast-path.

That's... horrendous.

Will

