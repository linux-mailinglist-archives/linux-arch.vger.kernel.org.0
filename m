Return-Path: <linux-arch+bounces-13168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF93B2661A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 15:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABAF1893E8F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972E137C2A;
	Thu, 14 Aug 2025 13:00:16 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CBBFBF6;
	Thu, 14 Aug 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176416; cv=none; b=JCxAZLIs61rcUap4vWqjkR2utDUlCx1WsKmJSkpL2flFSCxyRJwrgYJLxtsdlpWWKoXavzKV6Ar7Civq7N7NUzYsyNT4F+VWFQkPuMv6OWl/e4oCxiO7ellEUIjMa+epaK1E1jcEZ5qOD+OOSXzRqCjOy+fXtlMbV4hwb0pvmSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176416; c=relaxed/simple;
	bh=xNNKyJhtlm8JK+V5iwT+KOv/M87jAzxv6I72bmVTRgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y96sRar3HHRCmlbTcYjYafoQLFoaKVneo9J72zEvhHEkfLiazSZT9BeeZoJcYgGPgo/sarIe4b7PJZKmYTxBTTs5E3zPVssxgPRBEDqIcGksnEMaqm3juH8/N8XlUMF/pe/Sq/DQlNrCI+CmXSSoaNtm8mL+GOgTwoBnisiyfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0912CC4CEED;
	Thu, 14 Aug 2025 13:00:12 +0000 (UTC)
Date: Thu, 14 Aug 2025 14:00:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>, harisokn@amazon.com,
	cl@gentwo.org, Alexei Starovoitov <ast@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
	xueshuai@linux.alibaba.com,
	Joao Martins <joao.m.martins@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
Message-ID: <aJ3d2uoKtDop_gQO@arm.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com>
 <877bz98sqb.fsf@oracle.com>
 <aJy414YufthzC1nv@arm.com>
 <67b6b738-0f1c-4dd4-817d-95f55ec9272b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b6b738-0f1c-4dd4-817d-95f55ec9272b@app.fastmail.com>

On Wed, Aug 13, 2025 at 06:29:37PM +0200, Arnd Bergmann wrote:
> On Wed, Aug 13, 2025, at 18:09, Catalin Marinas wrote:
> > On Mon, Aug 11, 2025 at 02:15:56PM -0700, Ankur Arora wrote:
> >> This also gives the WFET a clear end time (though it would still need
> >> to be converted to timer cycles) but the WFE path could stay simple
> >> by allowing an overshoot instead of falling back to polling.
> >
> > For arm64, both WFE and WFET would be woken up by the event stream
> > (which is enabled on all production systems). The only reason to use
> > WFET is if you need smaller granularity than the event stream period
> > (100us). In this case, we should probably also add a fallback from WFE
> > to a busy loop.
> 
> I think there is a reasonable chance that in the future we may want
> to turn the event stream off on systems that support WFET, since that
> is better for both low-power systems

Definitely better for low power.

> and virtual machines with CPU overcommit.

Not sure it helps here. With vCPU overcommit, KVM enables WFE trapping
and the event stream no longer has any effect (it's not like it
interrupts the host).

That said, my worry is that either broken hardware or software rely on
the event stream unknowingly, e.g. someone using WFE in a busy loop. And
for hardware errata, we've had a few where the wakeup events don't
propagate between clusters, though these we can toggle on a case by case
basis.

-- 
Catalin

