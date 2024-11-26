Return-Path: <linux-arch+bounces-9165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F59D95A5
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 11:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B32284F2F
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 10:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779451C5799;
	Tue, 26 Nov 2024 10:36:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E7192D8C;
	Tue, 26 Nov 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617399; cv=none; b=kMZKq3KYPJ3juFB6d+yn4SMSwzUD8HdR9BM8dv1movFAuK1fFPpVN9RkjvrjEGQ8L1DANfPkkhuhp4eMaX2UOhGhgC/Uw8G/p24l2hpOAyTqBfXV2vwT7QhRZqydNCevbi6b6e09JolNA8dLJ2TL4I3OY4o0C6SgMofGhDqs+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617399; c=relaxed/simple;
	bh=Da9klZ2XnSHf8Ge8YCtVA4R3Umks+GHaBshSS2Uxxv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syW3v+XzOC+ukHlX3V2rJ2SJI0abgtMQRkZ6YZEJvTKYCKAmcgG4xDQhNRY6TaZI9XngbuIakyY446FFA0+cpHrWNf7cVDKvQI/WE99MiIDDz8D312evG08bQONVcCBC6VVaJudDb8j6c/DtsdV+unYcGw1lNVVoLc45E/o25DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCC6C4CECF;
	Tue, 26 Nov 2024 10:36:33 +0000 (UTC)
Date: Tue, 26 Nov 2024 10:36:31 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, will@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
	vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
	peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
	mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
	sudeep.holla@arm.com, cl@gentwo.org, maz@kernel.org,
	misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
	zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
Message-ID: <Z0Wkr-BcSsSzFth8@arm.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-2-ankur.a.arora@oracle.com>
 <878qt6h9kr.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qt6h9kr.fsf@oracle.com>

On Mon, Nov 25, 2024 at 09:01:56PM -0800, Ankur Arora wrote:
> Ankur Arora <ankur.a.arora@oracle.com> writes:
> > +/**
> > + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
> > + * guarantees until a timeout expires.
> > + * @ptr: pointer to the variable to wait on
> > + * @cond: boolean expression to wait for
> > + * @time_expr_ns: evaluates to the current time
> > + * @time_limit_ns: compared against time_expr_ns
> > + *
> > + * Equivalent to using READ_ONCE() on the condition variable.
> > + *
> > + * Due to C lacking lambda expressions we load the value of *ptr into a
> > + * pre-named variable @VAL to be used in @cond.
> 
> Based on the review comments so far I'm planning to add the following
> text to this comment:
> 
>   Note that in the generic version the time check is done only coarsely
>   to minimize instructions executed while spin-waiting.
> 
>   Architecture specific variations might also have their own timeout
>   granularity.

Looks good.

> Meanwhile, would appreciate more reviews.

It's the middle of the merging window, usually not much review happens
unless they are fixes/regressions.

-- 
Catalin

