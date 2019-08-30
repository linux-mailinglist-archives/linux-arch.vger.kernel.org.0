Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB8A38FD
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2019 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfH3OQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Aug 2019 10:16:53 -0400
Received: from foss.arm.com ([217.140.110.172]:32928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfH3OQx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Aug 2019 10:16:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BC1B344;
        Fri, 30 Aug 2019 07:16:52 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B4383F703;
        Fri, 30 Aug 2019 07:16:49 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] lib: vdso: Remove checks on return value for 32
 bit vDSO
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     catalin.marinas@arm.com, 0x7f454c46@gmail.com, salyzyn@android.com,
        paul.burton@mips.com, luto@kernel.org, tglx@linutronix.de,
        will@kernel.org
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-6-vincenzo.frascino@arm.com>
Message-ID: <ffbbd289-b282-53e6-03c2-14563bd8ebf3@arm.com>
Date:   Fri, 30 Aug 2019 15:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830135902.20861-6-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 30/08/2019 14:58, Vincenzo Frascino wrote:
> Since all the architectures that support the generic vDSO library have
> been converted to support the 32 bit fallbacks it is not required
> anymore to check the return value of __cvdso_clock_get*time32_common()
> before updating the old_timespec fields.
> 
> Remove the related checks from the generic vdso library.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> CC: Andy Lutomirski <luto@kernel.org>

Forgot to add to this patch:

Suggested-by: Andy Lutomirski <luto@kernel.org>

> References: c60a32ea4f45 ("lib/vdso/32: Provide legacy syscall fallbacks")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  lib/vdso/gettimeofday.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 2c4b311c226d..d5bc16748f81 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -129,10 +129,10 @@ __cvdso_clock_gettime32(clockid_t clock, struct old_timespec32 *res)
>  	if (unlikely(ret))
>  		return clock_gettime32_fallback(clock, res);
>  
> -	if (likely(!ret)) {
> -		res->tv_sec = ts.tv_sec;
> -		res->tv_nsec = ts.tv_nsec;
> -	}
> +	/* For ret == 0 */
> +	res->tv_sec = ts.tv_sec;
> +	res->tv_nsec = ts.tv_nsec;
> +
>  	return ret;
>  }
>  #endif /* BUILD_VDSO32 */
> @@ -238,10 +238,10 @@ __cvdso_clock_getres_time32(clockid_t clock, struct old_timespec32 *res)
>  	if (unlikely(ret))
>  		return clock_getres32_fallback(clock, res);
>  
> -	if (likely(!ret)) {
> -		res->tv_sec = ts.tv_sec;
> -		res->tv_nsec = ts.tv_nsec;
> -	}
> +	/* For ret == 0 */
> +	res->tv_sec = ts.tv_sec;
> +	res->tv_nsec = ts.tv_nsec;
> +
>  	return ret;
>  }
>  #endif /* BUILD_VDSO32 */
> 

-- 
Regards,
Vincenzo
