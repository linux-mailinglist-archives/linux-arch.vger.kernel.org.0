Return-Path: <linux-arch+bounces-12591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 885B9AFCED9
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jul 2025 17:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079BB1893EA6
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jul 2025 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7C22DEA78;
	Tue,  8 Jul 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fXOqPdFw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC9C2E0B6C
	for <linux-arch@vger.kernel.org>; Tue,  8 Jul 2025 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987845; cv=none; b=MZZzrx/dTUqJIoEIQu/dskKwZwxruFBxOoH/ZCnwJHTQMQWulT1jDEeVP9eNuhCxc5XJB1ll5K2OVdhoN5tI55Y23oM8K/kaSaQeEQ1SKZKgYiZwCUXUKdbslREngm3SgFppacpacSf6DisdUTubKaR09/cD+Rq3SHU/qLEMBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987845; c=relaxed/simple;
	bh=AHNCCG5Tf5jpa/S+PhVW9zo376122RPdsJOEN6MRlrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sRpU2UEUBPVJ6fXGc5zHY6AzwrQCwsLnnybUGX0NMhJdqDfSUzr8PeXyHSO/JUxRGEmerYXZf4nEQTXOEP5HnUBgf3ez8qtdO5zix6Xlls3InVB60cVhP4jBSBKZIQk2kjWr9h2Cz5z6XXaK7zKNe2pxMJvtvm4GF0E3RXBk+do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fXOqPdFw; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250708151721euoutp0112b39a6422f86d679cac4d0aa360690f~QT6i_aq6h0989009890euoutp011
	for <linux-arch@vger.kernel.org>; Tue,  8 Jul 2025 15:17:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250708151721euoutp0112b39a6422f86d679cac4d0aa360690f~QT6i_aq6h0989009890euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751987841;
	bh=yaTLIoaKytTb1Jem3YqYe98mw9JwFlUpJPDA2tKD898=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=fXOqPdFwqMbLXYSJm7Di2upblR2Tsgr1Trx7197+vRwt5Pdc5/zRWXqN0QRFhZrun
	 VVH57VAHLUm2Ytt/wpez3Y3vhPkBUg8FXf747xPsIhpvJeTwq6445TrELjgQG/ogZk
	 1OB8tRI2SDQnT/n7bc0/lyyjF8FkWzyWYo+KguIs=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250708151720eucas1p260f984fd95d3460d3e9f6c9b48e0e25c~QT6iepPcr1882718827eucas1p2A;
	Tue,  8 Jul 2025 15:17:20 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250708151718eusmtip2dcd49f64a9e9889791acd662135310b6~QT6gkeBFF2780927809eusmtip22;
	Tue,  8 Jul 2025 15:17:18 +0000 (GMT)
Message-ID: <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
Date: Tue, 8 Jul 2025 17:17:18 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/14] vdso/gettimeofday: Return bool from
 clock_gettime() helpers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
	<shuah@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic
	Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>, Stephen
	Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
	Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Richard
	Cochran <richardcochran@gmail.com>, Christopher Hall
	<christopher.s.hall@intel.com>, Miroslav Lichvar <mlichvar@redhat.com>,
	Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse
	<dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, Nam Cao
	<namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250708151720eucas1p260f984fd95d3460d3e9f6c9b48e0e25c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250708151720eucas1p260f984fd95d3460d3e9f6c9b48e0e25c
X-EPHeader: CA
X-CMS-RootMailID: 20250708151720eucas1p260f984fd95d3460d3e9f6c9b48e0e25c
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
	<20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
	<CGME20250708151720eucas1p260f984fd95d3460d3e9f6c9b48e0e25c@eucas1p2.samsung.com>

On 01.07.2025 10:58, Thomas Weißschuh wrote:
> The internal helpers are effectively using boolean results,
> while pretending to use error numbers.
>
> Switch the return type to bool for more clarity.
>
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   lib/vdso/gettimeofday.c | 58 +++++++++++++++++++++++++------------------------
>   1 file changed, 30 insertions(+), 28 deletions(-)

This patch landed in today's linux-next as commit fcc8e46f768f 
("vdso/gettimeofday: Return bool from clock_gettime() helpers"). In my 
tests I found that it causes serious problem with hwclock operation on 
some of my ARM 32bit test boards. I observe that calling "hwclock -w -f 
/dev/rtc0" never ends on those boards. Disabling vdso support (by 
removing ARM architected timer) fixes this issue.


> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 9b77f23566f6a35887d4c9aaefc61a971131b499..c5266532a097c06f33d12e345c695357d75abf42 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -82,8 +82,8 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_tim
>   #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
>   
>   static __always_inline
> -int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> -		   clockid_t clk, struct __kernel_timespec *ts)
> +bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> +		    clockid_t clk, struct __kernel_timespec *ts)
>   {
>   	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
>   	const struct timens_offset *offs = &vcns->offset[clk];
> @@ -103,11 +103,11 @@ int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *v
>   		seq = vdso_read_begin(vc);
>   
>   		if (unlikely(!vdso_clocksource_ok(vc)))
> -			return -1;
> +			return false;
>   
>   		cycles = __arch_get_hw_counter(vc->clock_mode, vd);
>   		if (unlikely(!vdso_cycles_ok(cycles)))
> -			return -1;
> +			return false;
>   		ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
>   		sec = vdso_ts->sec;
>   	} while (unlikely(vdso_read_retry(vc, seq)));
> @@ -123,7 +123,7 @@ int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *v
>   	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>   	ts->tv_nsec = ns;
>   
> -	return 0;
> +	return true;
>   }
>   #else
>   static __always_inline
> @@ -133,16 +133,16 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso_tim
>   }
>   
>   static __always_inline
> -int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> -		   clockid_t clk, struct __kernel_timespec *ts)
> +bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> +		    clockid_t clk, struct __kernel_timespec *ts)
>   {
> -	return -EINVAL;
> +	return false;
>   }
>   #endif
>   
>   static __always_inline
> -int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
> -	    clockid_t clk, struct __kernel_timespec *ts)
> +bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
> +	     clockid_t clk, struct __kernel_timespec *ts)
>   {
>   	const struct vdso_timestamp *vdso_ts = &vc->basetime[clk];
>   	u64 cycles, sec, ns;
> @@ -150,7 +150,7 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
>   
>   	/* Allows to compile the high resolution parts out */
>   	if (!__arch_vdso_hres_capable())
> -		return -1;
> +		return false;
>   
>   	do {
>   		/*
> @@ -173,11 +173,11 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
>   		smp_rmb();
>   
>   		if (unlikely(!vdso_clocksource_ok(vc)))
> -			return -1;
> +			return false;
>   
>   		cycles = __arch_get_hw_counter(vc->clock_mode, vd);
>   		if (unlikely(!vdso_cycles_ok(cycles)))
> -			return -1;
> +			return false;
>   		ns = vdso_calc_ns(vc, cycles, vdso_ts->nsec);
>   		sec = vdso_ts->sec;
>   	} while (unlikely(vdso_read_retry(vc, seq)));
> @@ -189,13 +189,13 @@ int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
>   	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
>   	ts->tv_nsec = ns;
>   
> -	return 0;
> +	return true;
>   }
>   
>   #ifdef CONFIG_TIME_NS
>   static __always_inline
> -int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> -		     clockid_t clk, struct __kernel_timespec *ts)
> +bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> +		      clockid_t clk, struct __kernel_timespec *ts)
>   {
>   	const struct vdso_time_data *vd = __arch_get_vdso_u_timens_data(vdns);
>   	const struct timens_offset *offs = &vcns->offset[clk];
> @@ -223,20 +223,20 @@ int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock
>   	 */
>   	ts->tv_sec = sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
>   	ts->tv_nsec = nsec;
> -	return 0;
> +	return true;
>   }
>   #else
>   static __always_inline
> -int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> -		     clockid_t clk, struct __kernel_timespec *ts)
> +bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_clock *vcns,
> +		      clockid_t clk, struct __kernel_timespec *ts)
>   {
> -	return -1;
> +	return false;
>   }
>   #endif
>   
>   static __always_inline
> -int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
> -	      clockid_t clk, struct __kernel_timespec *ts)
> +bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
> +	       clockid_t clk, struct __kernel_timespec *ts)
>   {
>   	const struct vdso_timestamp *vdso_ts = &vc->basetime[clk];
>   	u32 seq;
> @@ -258,10 +258,10 @@ int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
>   		ts->tv_nsec = vdso_ts->nsec;
>   	} while (unlikely(vdso_read_retry(vc, seq)));
>   
> -	return 0;
> +	return true;
>   }
>   
> -static __always_inline int
> +static __always_inline bool
>   __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
>   			     struct __kernel_timespec *ts)
>   {
> @@ -270,7 +270,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
>   
>   	/* Check for negative values or invalid clocks */
>   	if (unlikely((u32) clock >= MAX_CLOCKS))
> -		return -1;
> +		return false;
>   
>   	/*
>   	 * Convert the clockid to a bitmask and use it to check which
> @@ -284,7 +284,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
>   	else if (msk & VDSO_RAW)
>   		vc = &vc[CS_RAW];
>   	else
> -		return -1;
> +		return false;
>   
>   	return do_hres(vd, vc, clock, ts);
>   }
> @@ -293,9 +293,11 @@ static __maybe_unused int
>   __cvdso_clock_gettime_data(const struct vdso_time_data *vd, clockid_t clock,
>   			   struct __kernel_timespec *ts)
>   {
> -	int ret = __cvdso_clock_gettime_common(vd, clock, ts);
> +	bool ok;
>   
> -	if (unlikely(ret))
> +	ok = __cvdso_clock_gettime_common(vd, clock, ts);
> +
> +	if (unlikely(!ok))
>   		return clock_gettime_fallback(clock, ts);
>   	return 0;
>   }
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


