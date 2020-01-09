Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C932B1358A2
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jan 2020 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgAIL5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jan 2020 06:57:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44356 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730188AbgAIL5Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jan 2020 06:57:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so7058368wrm.11
        for <linux-arch@vger.kernel.org>; Thu, 09 Jan 2020 03:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fT9BhDTmI6AG5podl6ngmlKifh/4E8Utrb78+X/TIOE=;
        b=Q6iVnO13YSLHuWflcReyDiJz6bk7itxmnVpfAY3xuuwNg2/arUCv19m7p3Z11saH/V
         VUcIJ/LHo392fc8yCa/mKcWuXxx7cEO29Z6pW10fc3O6KCwbZIJIdvQpEyyqfK4Pki0C
         S6jvObItE96a6ejNv8PJsLwaPGLmN3M1YEBxSi2abGy7UF7qBOskmnyuwI55t0CDxzgw
         LEksb19KR+UmsvZhkF2H1hOq+Qv1cv5CJxJ1bP0R8YDrvh2Ni9mC1kXgTCcS1BjrsFfN
         SrTT1vKpFC95/RN3PGIJdRO/j4M9JJR8VNIVeyVwhzi3gJ6Em7+PNFtZyC8PNmZcqECc
         +nlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fT9BhDTmI6AG5podl6ngmlKifh/4E8Utrb78+X/TIOE=;
        b=r3n/Tk3y/zm0KBWAAXsQvRnZFWI9X2ZySgd3AAa3CuaNLDfVrPPI/CVik/A/Sbc38x
         pkM4YFF8nyl4t0jxnlzAwxodgIu+sfyGmhuXSDF0GHHtbTvJp+I1KoOV+UWJN2toS4mI
         nF8vSz1hcmKQGciJKOe0KzCuU6sQrBfyM9CmJGMmbsyir5/ArVQHKxBukA8afiAW2DTO
         qiDRDKEOc92msXcEdb5mJZ37xDqF4MwctUqenDezE7BokrYdLw0Jd35Ar+dgY5IGFys6
         jVX0Ms4sbj8JO8OIVn/GIc0Uu7jlvWHMHTwV7s2t/nC7Y4h0LHbkUEkx81+fEsvLEuDf
         YjiQ==
X-Gm-Message-State: APjAAAWVVV/o1tZHK8t5VXx/Mj9HTX3zIXGTOp85dbVdp9whCxbMdMP1
        FLyt+ROhU0HFexUjiTRN0+X+Ck5S5bdmuQ==
X-Google-Smtp-Source: APXvYqx5DalJRe0S1bVarQQjrg4lcGicLAQK18/0t9pJA3oTUDQ4Ief7dw+Qgrwbg6Lb4BO9azxb4g==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr10676678wru.296.1578571032936;
        Thu, 09 Jan 2020 03:57:12 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d? ([2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d])
        by smtp.googlemail.com with ESMTPSA id u7sm2616997wmj.3.2020.01.09.03.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 03:57:12 -0800 (PST)
Subject: Re: [PATCH v6][RESEND] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
To:     decui@microsoft.com, arnd@arndb.de, bp@alien8.de,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com,
        tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org
References: <1578350617-130430-1-git-send-email-decui@microsoft.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABzSpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz7Cwa4EEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAh
 CRCP9LjScWdVJxYhBCTWJvJTvp6H5s5b9I/0uNJxZ1Un69gQAJK0ODuKzYl0TvHPU8W7uOeu
 U7OghN/DTkG6uAkyqW+iIVi320R5QyXN1Tb6vRx6+yZ6mpJRW5S9fO03wcD8Sna9xyZacJfO
 UTnpfUArs9FF1pB3VIr95WwlVoptBOuKLTCNuzoBTW6jQt0sg0uPDAi2dDzf+21t/UuF7I3z
 KSeVyHuOfofonYD85FkQJN8lsbh5xWvsASbgD8bmfI87gEbt0wq2ND5yuX+lJK7FX4lMO6gR
 ZQ75g4KWDprOO/w6ebRxDjrH0lG1qHBiZd0hcPo2wkeYwb1sqZUjQjujlDhcvnZfpDGR4yLz
 5WG+pdciQhl6LNl7lctNhS8Uct17HNdfN7QvAumYw5sUuJ+POIlCws/aVbA5+DpmIfzPx5Ak
 UHxthNIyqZ9O6UHrVg7SaF3rvqrXtjtnu7eZ3cIsfuuHrXBTWDsVwub2nm1ddZZoC530BraS
 d7Y7eyKs7T4mGwpsi3Pd33Je5aC/rDeF44gXRv3UnKtjq2PPjaG/KPG0fLBGvhx0ARBrZLsd
 5CTDjwFA4bo+pD13cVhTfim3dYUnX1UDmqoCISOpzg3S4+QLv1bfbIsZ3KDQQR7y/RSGzcLE
 z164aDfuSvl+6Myb5qQy1HUQ0hOj5Qh+CzF3CMEPmU1v9Qah1ThC8+KkH/HHjPPulLn7aMaK
 Z8t6h7uaAYnGzjMEXZLIEhYJKwYBBAHaRw8BAQdAGdRDglTydmxI03SYiVg95SoLOKT5zZW1
 7Kpt/5zcvt3CwhsEGAEIACAWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXZLIEgIbAgCvCRCP
 9LjScWdVJ40gBBkWCAAdFiEEbinX+DPdhovb6oob3uarTi9/eqYFAl2SyBIAIQkQ3uarTi9/
 eqYWIQRuKdf4M92Gi9vqihve5qtOL396pnZGAP0c3VRaj3RBEOUGKxHzcu17ZUnIoJLjpHdk
 NfBnWU9+UgD/bwTxE56Wd8kQZ2e2UTy4BM8907FsJgAQLL4tD2YZggwWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ5CaD/0YQyfUzjpR1GnCSkbaLYTEUsyaHuWPI/uSpKTtcbttpYv+QmYsIwD9
 8CeH3zwY0Xl/1fE9Hy59z6Vxv9YVapLx0nPDOA1zDVNq2MnutxHb8t+Imjz4ERCxysqtfYrv
 gao3E/h0c8SEeh+bh5MkjwmU8CwZ3doWyiVdULKESe7/Gs5OuhFzaDVPCpWdsKdCAGyUuP/+
 qRWwKGVpWP0Rrt6MTK24Ibeu3xEZO8c3XOEXH5d9nf6YRqBEIizAecoCr00E9c+6BlRS0AqR
 OQC3/Mm7rWtco3+WOridqVXkko9AcZ8AiM5nu0F8AqYGKg0y7vkL2LOP8us85L0p57MqIR1u
 gDnITlTY0x4RYRWJ9+k7led5WsnWlyv84KNzbDqQExTm8itzeZYW9RvbTS63r/+FlcTa9Cz1
 5fW3Qm0BsyECvpAD3IPLvX9jDIR0IkF/BQI4T98LQAkYX1M/UWkMpMYsL8tLObiNOWUl4ahb
 PYi5Yd8zVNYuidXHcwPAUXqGt3Cs+FIhihH30/Oe4jL0/2ZoEnWGOexIFVFpue0jdqJNiIvA
 F5Wpx+UiT5G8CWYYge5DtHI3m5qAP9UgPuck3N8xCihbsXKX4l8bdHfziaJuowief7igeQs/
 WyY9FnZb0tl29dSa7PdDKFWu+B+ZnuIzsO5vWMoN6hMThTl1DxS+jc7ATQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABwsGNBBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwAIQkQj/S40nFnVScWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ/g6EACFYk+OBS7pV9KZXncBQYjKqk7Kc+9JoygYnOE2wN41QN9Xl0Rk3wri
 qO7PYJM28YjK3gMT8glu1qy+Ll1bjBYWXzlsXrF4szSqkJpm1cCxTmDOne5Pu6376dM9hb4K
 l9giUinI4jNUCbDutlt+Cwh3YuPuDXBAKO8YfDX2arzn/CISJlk0d4lDca4Cv+4yiJpEGd/r
 BVx2lRMUxeWQTz+1gc9ZtbRgpwoXAne4iw3FlR7pyg3NicvR30YrZ+QOiop8psWM2Fb1PKB9
 4vZCGT3j2MwZC50VLfOXC833DBVoLSIoL8PfTcOJOcHRYU9PwKW0wBlJtDVYRZ/CrGFjbp2L
 eT2mP5fcF86YMv0YGWdFNKDCOqOrOkZVmxai65N9d31k8/O9h1QGuVMqCiOTULy/h+FKpv5q
 t35tlzA2nxPOX8Qj3KDDqVgQBMYJRghZyj5+N6EKAbUVa9Zq8xT6Ms2zz/y7CPW74G1GlYWP
 i6D9VoMMi6ICko/CXUZ77OgLtMsy3JtzTRbn/wRySOY2AsMgg0Sw6yJ0wfrVk6XAMoLGjaVt
 X4iPTvwocEhjvrO4eXCicRBocsIB2qZaIj3mlhk2u4AkSpkKm9cN0KWYFUxlENF4/NKWMK+g
 fGfsCsS3cXXiZpufZFGr+GoHwiELqfLEAQ9AhlrHGCKcgVgTOI6NHg==
Message-ID: <e3432a0a-6520-c321-f4a3-26afcdd8338d@linaro.org>
Date:   Thu, 9 Jan 2020 12:57:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1578350617-130430-1-git-send-email-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 06/01/2020 23:43, Dexuan Cui wrote:
> This is needed for hibernation, e.g. when we resume the old kernel, we need
> to disable the "current" kernel's TSC page and then resume the old kernel's.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> This is a RESEND of https://lore.kernel.org/patchwork/patch/1156212/ .
> 
> Daniel Lezcano said "Applied, thanks!" on 12/4/2019 (see the above link),
> but I still can not find it in the mainline tree, or the tip tree. 

Yes, it is applied but it did not reached the tip tree yet.

> So, let me resend it just in case.
> 
>  drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 287d8d58c21a..1aec08e82b7a 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -330,12 +330,37 @@ static u64 read_hv_sched_clock_tsc(void)
>  	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
>  }
>  
> +static void suspend_hv_clock_tsc(struct clocksource *arg)
> +{
> +	u64 tsc_msr;
> +
> +	/* Disable the TSC page */
> +	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr &= ~BIT_ULL(0);
> +	hv_set_reference_tsc(tsc_msr);
> +}
> +
> +
> +static void resume_hv_clock_tsc(struct clocksource *arg)
> +{
> +	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
> +	u64 tsc_msr;
> +
> +	/* Re-enable the TSC page */
> +	hv_get_reference_tsc(tsc_msr);
> +	tsc_msr &= GENMASK_ULL(11, 0);
> +	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
> +	hv_set_reference_tsc(tsc_msr);
> +}
> +
>  static struct clocksource hyperv_cs_tsc = {
>  	.name	= "hyperv_clocksource_tsc_page",
>  	.rating	= 400,
>  	.read	= read_hv_clock_tsc,
>  	.mask	= CLOCKSOURCE_MASK(64),
>  	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
> +	.suspend= suspend_hv_clock_tsc,
> +	.resume	= resume_hv_clock_tsc,
>  };
>  
>  static u64 notrace read_hv_clock_msr(struct clocksource *arg)
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

