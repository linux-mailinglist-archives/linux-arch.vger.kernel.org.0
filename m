Return-Path: <linux-arch+bounces-12579-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F24AFA774
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jul 2025 21:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1EC189A148
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jul 2025 19:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409221B4236;
	Sun,  6 Jul 2025 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouRlHTa4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="08w8b11H"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC8186A;
	Sun,  6 Jul 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751830274; cv=none; b=Qnh2BwXXAOcGSUdy5YcGfdV3DQQ85AhyPNT8884VBMN7X901jzBiJIWt53vlQCfqwRuXKUPSynWuEL7cFtj1WC2RaP92U72N4fdrkyUKkinisWanyBTNBTFRTAcMmzOIk8/g+OTG2RdUnVuy4RijsNIcmOnA3Xo7uhKPUWZZZsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751830274; c=relaxed/simple;
	bh=ErheLBjJIY7xX2xLi0jBWMKRz0Lq6hTX/02109y1ikU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X8aW4gG3v0Ymxk+uyWmw61e/cAJ2vrq8GgB2rs7aTdEdidHo+AmwmRp/Be6UrKlNYpJEHO1ceyhofBdP4VZPSCkRsmEHOAcQ+UwH5AdiH3DZihTlTEGmDHqUFjC9zCPG8m3MkkMbm8Tx21H6WpheJP2fzCDyQ5McDrhTwdyCMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ouRlHTa4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=08w8b11H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751830270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQ2ofv+1+bTJIyO4X+Dd0vlpx4YzhCJIFQaCUQm3+2M=;
	b=ouRlHTa4haX1qT8sDx76BltC3KKVZP/ZFOMqYyWAYBv7odCxFXjSDNln0ScqPB0rG9e4FW
	ZhfoT5HmVDdWSMIdcjTm9FwWuliyu3d8VZ915+f4fTyhtpV1Ifn4NlOIQhjBk4IiObEenT
	mfx6N4liAmA8qS/Vc/xnGHoRhgfir2eQilEeiu6HShp+odVWfUTUBBOOQvce3jcWfTPzcq
	njz37X9XuDwuN7t55pDqviLFR9CarXeJPmZNxMvt/+MZRx+EE0Xyl24dv1hYiW5T1wX6Fy
	o45l4IxDCAGJ1WVWTNqWqNZkb3gUIdHdwOZcixtvSmuXXBAyR5WuSoQHZeHmyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751830270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQ2ofv+1+bTJIyO4X+Dd0vlpx4YzhCJIFQaCUQm3+2M=;
	b=08w8b11HUPEFVAPYIV20BJr7Gnft2w4D17JIHk7NQkX3TBpuwvcO7FDNcCx/mp9lpAMhsG
	2fx7UuR/2nzikNAw==
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
Subject: Re: [PATCH 12/14] vdso/gettimeofday: Add support for auxiliary clocks
In-Reply-To: <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-12-df7d9f87b9b8@linutronix.de>
Date: Sun, 06 Jul 2025 21:31:08 +0200
Message-ID: <87frf9ru9v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01 2025 at 10:58, Thomas Wei=C3=9Fschuh wrote:
> +static __always_inline
> +bool do_aux(const struct vdso_time_data *vd, clockid_t clock, struct __k=
ernel_timespec *ts)
> +{
> +	const struct vdso_clock *vc;
> +	u64 sec, ns;
> +	u32 seq;
> +	u8 idx;
> +
> +	if (!IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
> +		return false;
> +
> +	idx =3D clock - CLOCK_AUX;
> +	vc =3D &vd->aux_clock_data[idx];
> +
> +	do {
> +		/*
> +		 * Open coded function vdso_read_begin() to handle
> +		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
> +		 */
> +		while ((seq =3D READ_ONCE(vc->seq)) & 1) {
> +			if (IS_ENABLED(CONFIG_TIME_NS) && vc->clock_mode =3D=3D VDSO_CLOCKMOD=
E_TIMENS) {
> +				vd =3D __arch_get_vdso_u_timens_data(vd);
> +				vc =3D &vd->aux_clock_data[idx];
> +				break;

This actually wants to be a continue because otherwise @seq contains the
stale value from the initial read of the TIMENS page, which is
0x1. That's a pointless extra round through the below.

With continue it re-reads, but this time the actual value from the time
data page and also takes an eventual odd value into account properly.

I fixed it up locally already.

Thanks,

        tglx

