Return-Path: <linux-arch+bounces-3620-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164608A30C6
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473FC1C20B3B
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 14:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C21A13CFA0;
	Fri, 12 Apr 2024 14:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9/qT5zn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12667205E22;
	Fri, 12 Apr 2024 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932544; cv=none; b=O8yeeYlryQ6wcGOE/7uJ8t4ES8BGEqrTEXcx9kj8n6zwG4L+dD6X7cRDdssI6x/DpyOBWqYpVb282yK29ayMnbTiyoSIWqMbGMwI17vBsoEYO2OhCYneT7Y6A5rgMYK0ena8BqweVh9QCJWotR3JrEYuFyyzqLRkn/OZN7frUsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932544; c=relaxed/simple;
	bh=O3nJ43+rFmMOBYnN5dpRArxVDL7kzbTHUko/HHy6Vw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjPZDJmd6qzsy1yKIvG5QBZLHwj72EMhSDcft4hg2dRVRkV+ZdNKNIWpG+G0Hqo/5sUTQsfWXulPUDsGyGbaNi0aUJ5MD6FUTyZisVlF2Vyw261KC4Jzx1WLenmNthbgK3u1LmreNp5dmk2rY/rWQC8V1JAYmVkxOoQ6pu9uCnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9/qT5zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F634C32783;
	Fri, 12 Apr 2024 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712932543;
	bh=O3nJ43+rFmMOBYnN5dpRArxVDL7kzbTHUko/HHy6Vw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=q9/qT5znh72zB+98BEW0nAZrnGAzabUQxyfLyLzuZBHGOaWNqjBwu+hRNAHC8fA3M
	 mSTW1F9bbr7RUaVWsQ8tCdR0FBd3iHNcjf2Z5q9AX5SbTmvNhpqX45o7YWBVv8TrOA
	 lHp1V7/oHuiTg3dGUnef89Zgn4R8pVjz/rpizkJdrGywSuYl+URusB45ztW7h2shMT
	 G2h1a2pRsq7ZjmB+nCQ85OqklOryC6fItX1q8Jm2pf+RCYarjzxHg4Q9D3+QGv4gfK
	 J73gxwYjOTAbzPM74qG6DXNKQSLX8ePxRvzFx3iLpRsWzMijQZy0LtPcNq0byNoaiF
	 4nnqtfhoziH0A==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516ef30b16eso1159650e87.3;
        Fri, 12 Apr 2024 07:35:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGmsd1cwovosHI1Peynv4+R1Qx3PKEFkutcAt0KKqBPvNUe4z0z5IzbXRur7lsVQOhpvnuSu5r6GvsdefXhf+qPMP9LDG4aSq32086ALM5JO6YgQQ3WKnz0fzoC0M5S7oZs2TFdwE1AQ==
X-Gm-Message-State: AOJu0YxmggnfStIjFAL7PMytxHUtQ8KdkfWgObp7Caj289DXuiC3u5BB
	9wUaSlCyCCulz5La9aRypkkI0vHy3sKlXRa6CWtMJqoU83tMyefGet5Pc0Og7hboQ8aWgaXzwlm
	l9qPzeYAiD8IyztDRLx7qhvBzUhQ=
X-Google-Smtp-Source: AGHT+IGU0+cRuc7lM/dd8bXNwl+lgYbgcGY4vVK9ysVZlj1yjJ4nuXhPAeBtCl3R71HqXJ8fezssKLCOvfef9Le3JsA=
X-Received: by 2002:a19:910c:0:b0:513:ccda:bc86 with SMTP id
 t12-20020a19910c000000b00513ccdabc86mr1770884lfd.4.1712932541923; Fri, 12 Apr
 2024 07:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301130532.3953167-1-chenhuacai@loongson.cn>
 <20240301130532.3953167-2-chenhuacai@loongson.cn> <20240412133235.GA27868@willie-the-truck>
In-Reply-To: <20240412133235.GA27868@willie-the-truck>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 12 Apr 2024 22:35:28 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4UVVgEJeM=+Ua5xW=tn-dNdw_YRygFWMAfFqeyZL2dWQ@mail.gmail.com>
Message-ID: <CAAhV-H4UVVgEJeM=+Ua5xW=tn-dNdw_YRygFWMAfFqeyZL2dWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmiowb: Hook up mmiowb helpers to mutexes as well as spinlocks
To: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>, Rui Wang <wangrui@loongson.cn>, 
	WANG Xuerui <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Will,

On Fri, Apr 12, 2024 at 9:32=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, Mar 01, 2024 at 09:05:32PM +0800, Huacai Chen wrote:
> > Commit fb24ea52f78e0d595852e ("drivers: Remove explicit invocations of
> > mmiowb()") remove all mmiowb() in drivers, but it says:
> >
> > "NOTE: mmiowb() has only ever guaranteed ordering in conjunction with
> > spin_unlock(). However, pairing each mmiowb() removal in this patch wit=
h
> > the corresponding call to spin_unlock() is not at all trivial, so there
> > is a small chance that this change may regress any drivers incorrectly
> > relying on mmiowb() to order MMIO writes between CPUs using lock-free
> > synchronisation."
> >
> > The mmio in radeon_ring_commit() is protected by a mutex rather than a
> > spinlock, but in the mutex fastpath it behaves similar to spinlock. We
> > can add mmiowb() calls in the radeon driver but the maintainer says he
> > doesn't like such a workaround, and radeon is not the only example of
> > mutex protected mmio.
>
> Oh no! Ostrich programming is real!
>
> https://lore.kernel.org/lkml/CAHk-=3Dwgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSv=
hY9sUk7QA@mail.gmail.com/
Yes, you are probably right, so we solved it in the architectural code
like this finally.

https://lore.kernel.org/loongarch/20240305143958.1752241-1-chenhuacai@loong=
son.cn/T/#u

Huacai

>
> > So we extend the mmiowb tracking system from spinlock to mutex, hook up
> > mmiowb helpers to mutexes as well as spinlocks.
> >
> > Without this, we get such an error when run 'glxgears' on weak ordering
> > architectures such as LoongArch:
> >
> > radeon 0000:04:00.0: ring 0 stalled for more than 10324msec
> > radeon 0000:04:00.0: ring 3 stalled for more than 10240msec
> > radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000001f412 la=
st fence id 0x000000000001f414 on ring 3)
> > radeon 0000:04:00.0: GPU lockup (current fence id 0x000000000000f940 la=
st fence id 0x000000000000f941 on ring 0)
> > radeon 0000:04:00.0: scheduling IB failed (-35).
> > [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> > radeon 0000:04:00.0: scheduling IB failed (-35).
> > [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> > radeon 0000:04:00.0: scheduling IB failed (-35).
> > [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> > radeon 0000:04:00.0: scheduling IB failed (-35).
> > [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> > radeon 0000:04:00.0: scheduling IB failed (-35).
> > [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> > radeon 0000:04:00.0: scheduling IB failed (-35).
> > [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> > radeon 0000:04:00.0: scheduling IB failed (-35).
> > [drm:radeon_gem_va_ioctl [radeon]] *ERROR* Couldn't update BO_VA (-35)
> >
> > Link: https://lore.kernel.org/dri-devel/29df7e26-d7a8-4f67-b988-44353c4=
270ac@amd.com/T/#t
>
> Hmm. It's hard to tell from that thread whether you're really falling
> afoul of the problems that mmiowb() tries to solve or whether Loongson
> simply doesn't have enough ordering in its MMIO accessors.
>
> The code you proposed has:
>
>         mmiowb(); /* Make sure wptr is up-to-date for hw */
>
> but mmiowb() is really about ensuring order with MMIO accesses from a
> different CPU that subsequently takes the lock.
>
> So please can you explain a bit more about the failing case? I'm worried
> that mmiowb() may be the wrong tool for the job here.
>
> Thanks,
>
> Will

