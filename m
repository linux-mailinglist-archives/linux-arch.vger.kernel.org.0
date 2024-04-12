Return-Path: <linux-arch+bounces-3618-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5A8A2F79
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 15:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF7B282057
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0ED824B6;
	Fri, 12 Apr 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUF2wrSt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97901824B2;
	Fri, 12 Apr 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928762; cv=none; b=V50uH1/SAiKXNOoMeKD/zFgjYH8u6FTs7Qd3Pij7eqj9LOXCMcLzOSXE8+CphYRrOyWBejkAhmgsYhP6Jxq/pV3aipTQ23rt3dkUgH1IMFjKBFxUqeblvZHR2oK9POmh1bF8wovqRlNbajJraGVORQb4yl1XdzFlSSrPGkQ9qwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928762; c=relaxed/simple;
	bh=WFEEAm6/FDO3NQO1jUXoxjsLfk+N80z4jO0hqhHDjGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8jykKqGk4mPWZtJbGRYcTCka5iEXeNC6Z0bISGNEE9rcqZJnO6UBtxezpFz1LWIUmLZq0anQUPuJlZ1mUWY//HI1JsgP9ydHw/6NTJTbQG8eVX2opbpH6TcmrfxhFitPvaPprw8MU3axdoGT6cCy+QTw+v5p+Tvmt6bXwAAtp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUF2wrSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632F9C113CC;
	Fri, 12 Apr 2024 13:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712928762;
	bh=WFEEAm6/FDO3NQO1jUXoxjsLfk+N80z4jO0hqhHDjGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUF2wrStZy44cIua82xY2fsCYlUbhGV3yC3u5gsYSTshB/4s/KRSuvFqaNNzOU3B8
	 RE2Ywgkv8N8HGu3kBxRtFzx3ocvMEj36653yXGoYKkaC73WPZxQ41hYVOcJiX2SfIr
	 fWN4vzumZONEsiLYftBWAp9EApQdcV5xbjpHaX6XBntZoqdz2H/rHqTf6XCPE2HKaG
	 1slIqwybjX7JizF0QSAbbVkxln6ilwL/R/vu96nyDsWunZxTaoLOCuR6cQK5xn5Rk3
	 iQrnGyZM4wjBq/WqdF4joPDME30fvzgo4eM0i5X4YSc5QjGBBcZ6pSvFO7w9z+IQdI
	 5AnVK0+tFqBWQ==
Date: Fri, 12 Apr 2024 14:32:35 +0100
From: Will Deacon <will@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Guo Ren <guoren@kernel.org>, Rui Wang <wangrui@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	mpe@ellerman.id.au
Subject: Re: [PATCH 2/2] mmiowb: Hook up mmiowb helpers to mutexes as well as
 spinlocks
Message-ID: <20240412133235.GA27868@willie-the-truck>
References: <20240301130532.3953167-1-chenhuacai@loongson.cn>
 <20240301130532.3953167-2-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301130532.3953167-2-chenhuacai@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 01, 2024 at 09:05:32PM +0800, Huacai Chen wrote:
> Commit fb24ea52f78e0d595852e ("drivers: Remove explicit invocations of
> mmiowb()") remove all mmiowb() in drivers, but it says:
> 
> "NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
> spin_unlock(). However, pairing each mmiowb() removal in this patch with
> the corresponding call to spin_unlock() is not at all trivial, so there
> is a small chance that this change may regress any drivers incorrectly
> relying on mmiowb() to order MMIO writes between CPUs using lock-free
> synchronisation."
> 
> The mmio in radeon_ring_commit() is protected by a mutex rather than a
> spinlock, but in the mutex fastpath it behaves similar to spinlock. We
> can add mmiowb() calls in the radeon driver but the maintainer says he
> doesn't like such a workaround, and radeon is not the only example of
> mutex protected mmio.

Oh no! Ostrich programming is real!

https://lore.kernel.org/lkml/CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com/

> So we extend the mmiowb tracking system from spinlock to mutex, hook up
> mmiowb helpers to mutexes as well as spinlocks.
> 
> Without this, we get such an error when run 'glxgears' on weak ordering
> architectures such as LoongArch:
> 
> radeon 0000:04:00.0: ring 0 stalled for more than 10324msec
> radeon 0000:04:00.0: ring 3 stalled for more than 10240msec
> radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000001f412 last fence id 0x000000000001f414 on ring 3)
> radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000000f940 last fence id 0x000000000000f941 on ring 0)
> radeon 0000:04:00.0: scheduling IB failed (-35).
> [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> radeon 0000:04:00.0: scheduling IB failed (-35).
> [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> radeon 0000:04:00.0: scheduling IB failed (-35).
> [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> radeon 0000:04:00.0: scheduling IB failed (-35).
> [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> radeon 0000:04:00.0: scheduling IB failed (-35).
> [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> radeon 0000:04:00.0: scheduling IB failed (-35).
> [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> radeon 0000:04:00.0: scheduling IB failed (-35).
> [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> 
> Link: https://lore.kernel.org/dri-devel/29df7e26-d7a8-4f67-b988-44353c4270ac@amd.com/T/#t

Hmm. It's hard to tell from that thread whether you're really falling
afoul of the problems that mmiowb() tries to solve or whether Loongson
simply doesn't have enough ordering in its MMIO accessors.

The code you proposed has:

	mmiowb(); /* Make sure wptr is up-to-date for hw */

but mmiowb() is really about ensuring order with MMIO accesses from a
different CPU that subsequently takes the lock.

So please can you explain a bit more about the failing case? I'm worried
that mmiowb() may be the wrong tool for the job here.

Thanks,

Will

