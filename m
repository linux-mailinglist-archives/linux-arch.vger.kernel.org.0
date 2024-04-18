Return-Path: <linux-arch+bounces-3782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01158A903E
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C367282FA3
	for <lists+linux-arch@lfdr.de>; Thu, 18 Apr 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6A5CB0;
	Thu, 18 Apr 2024 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SDAV5RYY"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94288376;
	Thu, 18 Apr 2024 01:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402048; cv=none; b=OZP4E0efDSNfelfX16/yzDukmlNHXb7cD/HvxGOTgAi0jW8wlkrz2FEGicHDHypupFLPoR/gIPlxGRBiC06I2D95u8yDg+MTql47HEKGH1I4BTp+1kyoyLHI78Yt3zBquVmWRyrAMiWJ2lU4B0z5fmW45hfPF7lY1NchFUTG5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402048; c=relaxed/simple;
	bh=vTanqau4t/U+Uyls6+AXjIbwm8dSM1/9KWNhqrmGuGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otEjDYYAxJzUPU8dIoTzzJUQEzhpYqWb6RLecslo7r8ZwZ4efbl+X2Xji6PiyeyqT3kZvZuAkxLYYsLderBNpJKlnbS2zU9pXdS6mwkTQgfvoerdhVoOsp4UpWKKUxfGge14+y0YkmXKzNfz8ZmVkPGKU1fVKaZjuRpAjm3xSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=SDAV5RYY; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713402045;
	bh=vTanqau4t/U+Uyls6+AXjIbwm8dSM1/9KWNhqrmGuGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SDAV5RYYCtv9/IfXyhzcOOOTEmUMqPzfiEGS4GgSjQnGQUV7yADPMa14Nd0rmUE/K
	 aquXYXEUaYGpBv5GCsf8zH15kInnF/2Xi9xZigUB1VFYkbS3IWcata7UA7dTgHg+rs
	 7Fd+yV9yJBuUoLZkiMLrspqMbOl6FKqPUQ87rykTej4IKlGrkD83YiCNOwliRNm4yR
	 osPxlSCN9oSgSQNXy9fbIMcKfAXI08A3mrZCyZ3alA/xpYUJRjClRlIDtlLJqY56IV
	 SHmyD7lVNtHX7SS+8Q95mEw1DDSmFAz18MUgX1C0dHSN0cUPgvKKr58M4Yvj5nc+fc
	 4UEOJKGC3p1iA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VKfbJ1h6Hz4wc8;
	Thu, 18 Apr 2024 11:00:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Weisbecker <frederic@kernel.org>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, Nicholas Piggin
 <npiggin@gmail.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v2 RESEND 0/5] sched/vtime: vtime.h headers cleanup
In-Reply-To: <Zh-kEvJbNR2krwmx@localhost.localdomain>
References: <cover.1712760275.git.agordeev@linux.ibm.com>
 <Zh-kEvJbNR2krwmx@localhost.localdomain>
Date: Thu, 18 Apr 2024 11:00:43 +1000
Message-ID: <87h6fzbi2s.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Frederic Weisbecker <frederic@kernel.org> writes:
> Le Wed, Apr 10, 2024 at 05:09:43PM +0200, Alexander Gordeev a =C3=A9crit :
>> Hi All,
>>=20
>> There are no changes since the last post, just a re-send.
>>=20
>> v2:
>> - patch 4: commit message reworded (Heiko)
>> - patch 5: vtime.h is removed from Kbuild scripts (PowerPC only) (Heiko)
>>=20
>> v1:
>> Please find a small cleanup to vtime_task_switch() wiring.
>> I split it into smaller patches to allow separate PowerPC
>> vs s390 reviews. Otherwise patches 2+3 and 4+5 could have
>> been merged.
>>=20
>> I tested it on s390 and compile-tested it on 32- and 64-bit
>> PowerPC and few other major architectures only, but it is
>> only of concern for CONFIG_VIRT_CPU_ACCOUNTING_NATIVE-capable
>> ones (AFAICT).
>>=20
>> Thanks!
>
> It probably makes sense to apply the whole series to the scheduler tree.
> Does any powerpc or s390 maintainer oppose to that?

No objection. It has acks and reviews from powerpc.

cheers

