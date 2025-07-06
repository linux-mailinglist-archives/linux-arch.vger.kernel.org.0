Return-Path: <linux-arch+bounces-12581-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51CAAFA7BD
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jul 2025 22:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5B83A5E1B
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jul 2025 20:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42529E0E0;
	Sun,  6 Jul 2025 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lOvOH69S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CkG1J0Ej"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C3B29E10F;
	Sun,  6 Jul 2025 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751834634; cv=none; b=pZUtgfvjeRypU/atwxwVTzdoPdLekoIxIS/K54cMIV7rHUkPUcnjODyG2yjGq5puNg+nVLgbpuk3JZ3LnqV/cbrj3s6ilw3+c5orrkpFRemTPusFz0YGBlPLfh/E/FAyGyv9zjIjY/qeeOMMiCvM+Fs9bj/S8KbxQsSNO37iktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751834634; c=relaxed/simple;
	bh=usPTwVNy/TYUdvESMy1rw1mD95rKVFtnjKLHy2LTfcg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RjtZwNSiM3Q+h7YKB/Mivshlyg5DCasjDKS3THWPgkVbi/2+ij+FQ2f8FOp6peNjCzDv2Uc+JD4UNoXnWZOEP989mVyjbdqWThM9APK1JYdB/EUTkocY8zI/fYeBmvMtVylYYJXeJxsqWbgXBbx8SKJCURMQZUpLC2EHV80dn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lOvOH69S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CkG1J0Ej; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751834629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaMWKZFSACMkJF/x1KbPma+33xBrwS00+hXmnNdOlm4=;
	b=lOvOH69SMeJW7XSU1i1qeC+GJkPScm498GO4iFaSQnJrYk2vNxV/I7wB1kMmczG+RjC+t1
	sNTvAh2sma9xtPJtUByMPzUQU7sfALHJohE9wBzet0Vi6NkSa3S9lQLkUpZLgFJZjDVCD6
	GU3kiEXwCgiNFzdOqgQS371mJOvFfq2pBWdd3XtwXX2avFcBKiZ3CCGPFEcKieZyuFIQf+
	RGvSp1jXATV3jDDrg1boqA6lqFKQLfbP/ZM1gyO4wLth/d2BMk4vOc2ZuZaM9xIvPRyL08
	hTT/UrHp57vdURrhLTDmiD+T2zAmuGcaWl26379BmLp1OftfaZuRklq7eaO06g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751834629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HaMWKZFSACMkJF/x1KbPma+33xBrwS00+hXmnNdOlm4=;
	b=CkG1J0EjBS5wGsQmH1a+QFjhkr4r3k8slMTxfndI7cdIdNcYOoj6TC7QYpZ7wdngy3rrtK
	f3AzK+33Zy0wMeCw==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski
 <luto@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah
 Khan <shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Kurt
 Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
 Tenart <atenart@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 13/14] Revert "selftests: vDSO: parse_vdso: Use UAPI
 headers instead of libc headers"
In-Reply-To: <20250701-vdso-auxclock-v1-13-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-13-df7d9f87b9b8@linutronix.de>
Date: Sun, 06 Jul 2025 22:43:47 +0200
Message-ID: <87a55hrqws.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01 2025 at 10:58, Thomas Wei=C3=9Fschuh wrote:
> This reverts commit c9fbaa879508 ("selftests: vDSO: parse_vdso: Use UAPI =
headers instead of libc headers")
>
> The kernel headers were used to make parse_vdso.c compatible with nolibc.
> Unfortunately linux/elf.h is incompatible with glibc's sys/auxv.h.
> When using glibc it is therefore not possible build parse_vdso.c as part =
of the
> same compilation unit as its caller as sys/auxv.h is needed for getauxval=
().
>
> In the meantime nolibc gained its own elf.h, providing compatibility with=
 the
> documented libc interfaces.

I'm kinda surprised to find this here in this series. Isn't that commit
c9fbaa879508 obsolete since nolibc got it's own elf.h?

So this should just go straight to Linus, no?

Thanks,

        tglx

