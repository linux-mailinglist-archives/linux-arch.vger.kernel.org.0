Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20F4C45C6A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jun 2019 14:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfFNMOb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jun 2019 08:14:31 -0400
Received: from foss.arm.com ([217.140.110.172]:60702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfFNMOb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jun 2019 08:14:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7972B2B;
        Fri, 14 Jun 2019 05:14:30 -0700 (PDT)
Received: from [192.168.1.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F11DD3F246;
        Fri, 14 Jun 2019 05:14:27 -0700 (PDT)
Subject: Re: [PATCH v6 03/19] kernel: Unify update_vsyscall implementation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-4-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906141307430.1722@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <a69e48a2-575d-255c-2653-d3e99b7ba760@arm.com>
Date:   Fri, 14 Jun 2019 13:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141307430.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On 6/14/19 12:10 PM, Thomas Gleixner wrote:
> On Thu, 30 May 2019, Vincenzo Frascino wrote:
>> +
>> +	if (__arch_use_vsyscall(vdata)) {
>> +		vdata[CS_HRES_COARSE].cycle_last	=
>> +						tk->tkr_mono.cycle_last;
>> +		vdata[CS_HRES_COARSE].mask		=
>> +						tk->tkr_mono.mask;
>> +		vdata[CS_HRES_COARSE].mult		=
>> +						tk->tkr_mono.mult;
> 
> These line breaks make it really hard to read. Can you fold in the patch
> below please?
> 

Thanks for this. I will do it in v7.

> Thanks,
> 
> 	tglx
> 8<-----------
> --- a/kernel/vdso/vsyscall.c
> +++ b/kernel/vdso/vsyscall.c
> @@ -11,6 +11,66 @@
>  #include <vdso/helpers.h>
>  #include <vdso/vsyscall.h>
>  
> +static inline void udpate_vdata(struct vdso_data *vdata, struct timekeeper *tk)
> +{
> +	struct vdso_timestamp *vdso_ts;
> +	u64 nsec;
> +
> +	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
> +	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
> +	vdata[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
> +	vdata[CS_HRES_COARSE].shift		= tk->tkr_mono.shift;
> +	vdata[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
> +	vdata[CS_RAW].mask			= tk->tkr_raw.mask;
> +	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
> +	vdata[CS_RAW].shift			= tk->tkr_raw.shift;
> +
> +	/* CLOCK_REALTIME */
> +	vdso_ts		=  &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
> +	vdso_ts->sec	= tk->xtime_sec;
> +	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
> +
> +	/* CLOCK_MONOTONIC */
> +	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
> +	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
> +
> +	nsec = tk->tkr_mono.xtime_nsec;
> +	nsec += ((u64)tk->wall_to_monotonic.tv_nsec << tk->tkr_mono.shift);
> +	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
> +		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
> +		vdso_ts->sec++;
> +	}
> +	vdso_ts->nsec	= nsec;
> +
> +	/* CLOCK_MONOTONIC_RAW */
> +	vdso_ts		= &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
> +	vdso_ts->sec	= tk->raw_sec;
> +	vdso_ts->nsec	= tk->tkr_raw.xtime_nsec;
> +
> +	/* CLOCK_BOOTTIME */
> +	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
> +	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
> +	nsec = tk->tkr_mono.xtime_nsec;
> +	nsec += ((u64)(tk->wall_to_monotonic.tv_nsec +
> +		       ktime_to_ns(tk->offs_boot)) << tk->tkr_mono.shift);
> +	while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
> +		nsec -= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
> +		vdso_ts->sec++;
> +	}
> +	vdso_ts->nsec	= nsec;
> +
> +	/* CLOCK_TAI */
> +	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
> +	vdso_ts->sec	= tk->xtime_sec + (s64)tk->tai_offset;
> +	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec;
> +
> +	/*
> +	 * Read without the seqlock held by clock_getres().
> +	 * Note: No need to have a second copy.
> +	 */
> +	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
> +}
> +
>  void update_vsyscall(struct timekeeper *tk)
>  {
>  	struct vdso_data *vdata = __arch_get_k_vdso_data();
> @@ -32,92 +92,23 @@ void update_vsyscall(struct timekeeper *
>  	vdata[CS_RAW].clock_mode		= __arch_get_clock_mode(tk);
>  
>  	/* CLOCK_REALTIME_COARSE */
> -	vdso_ts			=
> -			&vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
> -	vdso_ts->sec		= tk->xtime_sec;
> -	vdso_ts->nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
> +	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
> +	vdso_ts->sec	= tk->xtime_sec;
> +	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
> +
>  	/* CLOCK_MONOTONIC_COARSE */
> -	vdso_ts			=
> -			&vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
> -	vdso_ts->sec		= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
> -	nsec			= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
> -	nsec			= nsec + tk->wall_to_monotonic.tv_nsec;
> +	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
> +	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
> +	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
> +	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
>  	while (nsec >= NSEC_PER_SEC) {
>  		nsec = nsec - NSEC_PER_SEC;
>  		vdso_ts->sec++;
>  	}
> -	vdso_ts->nsec		= nsec;
> +	vdso_ts->nsec	= nsec;
>  
> -	if (__arch_use_vsyscall(vdata)) {
> -		vdata[CS_HRES_COARSE].cycle_last	=
> -						tk->tkr_mono.cycle_last;
> -		vdata[CS_HRES_COARSE].mask		=
> -						tk->tkr_mono.mask;
> -		vdata[CS_HRES_COARSE].mult		=
> -						tk->tkr_mono.mult;
> -		vdata[CS_HRES_COARSE].shift		=
> -						tk->tkr_mono.shift;
> -		vdata[CS_RAW].cycle_last		=
> -						tk->tkr_raw.cycle_last;
> -		vdata[CS_RAW].mask			=
> -						tk->tkr_raw.mask;
> -		vdata[CS_RAW].mult			=
> -						tk->tkr_raw.mult;
> -		vdata[CS_RAW].shift			=
> -						tk->tkr_raw.shift;
> -		/* CLOCK_REALTIME */
> -		vdso_ts			=
> -			&vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
> -		vdso_ts->sec		= tk->xtime_sec;
> -		vdso_ts->nsec		= tk->tkr_mono.xtime_nsec;
> -		/* CLOCK_MONOTONIC */
> -		vdso_ts			=
> -			&vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
> -		vdso_ts->sec		= tk->xtime_sec +
> -					  tk->wall_to_monotonic.tv_sec;
> -		nsec			= tk->tkr_mono.xtime_nsec;
> -		nsec			= nsec +
> -					  ((u64)tk->wall_to_monotonic.tv_nsec <<
> -					  tk->tkr_mono.shift);
> -		while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
> -			nsec = nsec -
> -			       (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
> -			vdso_ts->sec++;
> -		}
> -		vdso_ts->nsec		= nsec;
> -		/* CLOCK_MONOTONIC_RAW */
> -		vdso_ts			=
> -			&vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
> -		vdso_ts->sec		= tk->raw_sec;
> -		vdso_ts->nsec		= tk->tkr_raw.xtime_nsec;
> -		/* CLOCK_BOOTTIME */
> -		vdso_ts			=
> -			&vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
> -		vdso_ts->sec		= tk->xtime_sec +
> -					  tk->wall_to_monotonic.tv_sec;
> -		nsec			= tk->tkr_mono.xtime_nsec;
> -		nsec			= nsec +
> -					  ((u64)(tk->wall_to_monotonic.tv_nsec +
> -					  ktime_to_ns(tk->offs_boot)) <<
> -					  tk->tkr_mono.shift);
> -		while (nsec >= (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
> -			nsec = nsec -
> -				(((u64)NSEC_PER_SEC) << tk->tkr_mono.shift);
> -			vdso_ts->sec++;
> -		}
> -		vdso_ts->nsec		= nsec;
> -		/* CLOCK_TAI */
> -		vdso_ts			=
> -			&vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
> -		vdso_ts->sec		= tk->xtime_sec + (s64)tk->tai_offset;
> -		vdso_ts->nsec		= tk->tkr_mono.xtime_nsec;
> -
> -		/*
> -		 * Read without the seqlock held by clock_getres().
> -		 * Note: No need to have a second copy.
> -		 */
> -		WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
> -	}
> +	if (__arch_use_vsyscall(vdata))
> +		update_vdata(vdata, tk);
>  
>  	__arch_update_vsyscall(vdata, tk);
>  
> 

-- 
Regards,
Vincenzo
