Return-Path: <linux-arch+bounces-12453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1BAE7EF9
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2343A1B43
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jun 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E327E059;
	Wed, 25 Jun 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkfXbFa+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB557199E89
	for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846852; cv=none; b=VlXbUpyafobBLMx83vdS/upiakD4hydzqht0nMxzR5jdm92coHX44tiVCAPW/tRRsyDNnX7Vdv0YMs4S6sLLhLTcmhFSbFy+KhIeBPEOzosr+G4R/Ks3WGLVqii/v8C29AYnmE9qIrDROWx5ygZHYdtwDaMcIOJ2TcMDImT5iyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846852; c=relaxed/simple;
	bh=yb0VUisRFfpgJ9Ycv+uTDvja7eYb08VTPyrIam8ZUn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGCS9M/Mg/iH8mnTsBqv9gd9HqgRXqoTXf9OPqppp4oFAUTDjuZj4eURYL9de2wKlSlB/pvKuFazeRdx3yEV7hlcVI0pq4PP7j0dTLAr3S0nQ+48XTuSGr251VTI4OsC5MhlfJbx2g3atjdaj+nN2xIhsxuGH/3otFzGjSEg7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DkfXbFa+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a5257748e1so4301356f8f.2
        for <linux-arch@vger.kernel.org>; Wed, 25 Jun 2025 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750846849; x=1751451649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhAAx8z9nS1zfmK+wzXrKni8X7LB0abogxyZPI/1F5Y=;
        b=DkfXbFa+LmZgm5zZ+ucbCv90LZ7ENH1nbZgMSE3TM+k6EcvR1qHJN4zq5HJ/oRpoAG
         cbXQYMW5Pfl01QPnyxwqxNu9Rx1LNIDzegb2he3NGiXCTvNmohvwxmD2z/4ur5G0Sf4S
         qQAlmWE2WkIS1vjNxIL8kFju25M76NU6W/RGN10jWSuYAXTf22kIrVY76agi4pojqqnD
         mOlcLe43qdJE3gHHv7tbnuc4b+9R+xaJN+jE3zLH/om1RW0niAVjV4RMkQCZnL4bBdmT
         oAO1SX+oyIRtTF5/Fqfjc12I2Mc3R6a5VfZEgteRD9Om3rE/cGBIPGXOqv7OSCg3vFPy
         aYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846849; x=1751451649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhAAx8z9nS1zfmK+wzXrKni8X7LB0abogxyZPI/1F5Y=;
        b=v96f2QxF6Ub7f5/CXIJD0DXz9N0qYnsH9dRgGGR+C6KAJ6p2KXYodLfaZcJZEeuI/Q
         K3jXrgmD5SiKeugZ3x+bO/kQSOe4S2ANO4ciOWcsHiZWLrG9+9N0ZEjb9ef0Ev3E2UrB
         znBXA6ZJ4DmgLPOLVu0LWt9JXMRGDYlMSyqy5B7iF+q/91PX6JwAZuVkWw7gW6iJbeAk
         8AUKO9E2kkwV7HlYMh8xwn9/U+NBeNq39V8X95s/QDGpHLzSS5arpm+eCyV+2oSu/sZA
         cOkv1FmEkeFhPItyhM8HCLAY+DTbKVVBwM6R2ozYs8l1MJ/nblrVyfBZtVNqd3p0qpd7
         xO+w==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0/gYys5CAy3Uk5PW7ZoaCAfFpwt7HQcJlnn9/RUnAwd8vFwKNQ5zjo0Cqu5n2QrCaPbdzpuN6DKR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11GFrmT7WKfFjnKizBTYpV2Y6GD4DenDFHj2Zo74knXdu49If
	iv6C2kWg3v6hG6JUwCaa2ZtvbANEbJjlWjt907tMgg7IJ75TT/iPQaTE8PwFX+kV0zk=
X-Gm-Gg: ASbGncu+MQg98/6a4S5xNUnYx0dXn6xsroRujApX6UzW2ndT8EVFL7MajO58nWUB9He
	V1bCD3d/ZimT6I3T4b757uLfmostwYwbnFdj7HKenCf6uTW+LNdcl6NOk8faKv2Syr7ZEdCsD8C
	zoFeT80OdVfCWSaPjSVIAuLoyfKBGs6JVk3U37+6Zrxnemer89JsbblbZPcV6obwFTMZqgT4oxH
	zrC5x4jiSMZ/BuBSzPSiQ9DtDXTbwoknhVOXv9m7iWV4cGthL4gVuNW0bMkOgAnOzL0xAKN/xG7
	sw5Ck/8HLFnoNcUcO0IMEXksnYR3IheErMlGvbZh+KXScMT2mM6Z1swEc+v5isev43uK9d4Mtlz
	juhg3BlWbvmK3ofZOi6P5MeSpmlsKEDcju8YuMw==
X-Google-Smtp-Source: AGHT+IECzQ6BbuewhwMNZdgUhrWMpVTzcJ884zO545LKQnQJvupwU/uT7MOKUj4Yh9WaAvXLDontlA==
X-Received: by 2002:a05:6000:26d2:b0:3a4:d0fe:42b2 with SMTP id ffacd0b85a97d-3a6ed631f38mr1748764f8f.19.1750846849091;
        Wed, 25 Jun 2025 03:20:49 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8050eb3sm4225374f8f.5.2025.06.25.03.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:20:48 -0700 (PDT)
Message-ID: <e557503b-ccd5-46e2-b0b6-e8db30ad0ac4@linaro.org>
Date: Wed, 25 Jun 2025 11:20:47 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] timer: of: Create a platform_device before the
 framework is initialized
To: Daniel Lezcano <daniel.lezcano@linaro.org>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lorenzo.pieralisi@linaro.org,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Saravana Kannan <saravanak@google.com>,
 "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>
References: <20250625085715.889837-1-daniel.lezcano@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250625085715.889837-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/06/2025 09:57, Daniel Lezcano wrote:
> In the context of the time keeping and the timers, some platforms have
> timers which need to be initialized very early. It is the case of the
> ARM platform which do not have the architected timers.
> 
> The macro TIMER_OF_DECLARE adds an entry in the timer init functions
> array at compile time and the function timer_probe is called from the
> timer_init() function in kernel/time.c
> 
> This array contains a t-uple with the init function and the compatible
> string.

tuple

> 
> The init function has a device node pointer parameter.
> 
> The timer_probe() function browses the of nodes and find the ones
> matching the compatible string given when using the TIMER_OF_DECLARE
> macro. It then calls the init function with the device node as a
> pointer.
> 
> But there are some platforms where there are multiple timers like the

Don't start a sentence with But.

"There are some platforms", "There are platforms" or "Some platforms"

> ARM64 with the architected timers. Those are always initialized very
> early and the other timers can be initialized later.
> 
> For this reason we find timer drivers with the platform_driver
> incarnation. Consequently their init functions are different, they
> have a platform_device pointer parameter and rely on the devm_
> function for rollbacking.
> 
> To summarize, we have:
>   - TIMER_OF_DECLARE with init function prototype:
>     int (*init)(struct device_node *np);
> 
>   - module_platform_driver (and variant) with the probe function
>     prototype:
>     int (*init)(struct platform_device *pdev);
> 
> The current situation with the timers is the following:
> 
>   - Two platforms can have the same timer hardware, hence the same
>     driver but one without alternate timers and the other with multiple
>     timers. For example, the Exynos platform has only the Exynos MCT on
>     ARM but has the architeched timers in addition on the ARM64.

architected

> 
>   - The timer drivers can be modules now which was not the case until
>     recently. TIMER_OF_DECLARE do not allow the build as a module.
> 
> It results in duplicate init functions (one with rollback and one with
> devm_) and different way to declare the driver (TIMER_OF_DECLARE and
> module_platform_driver).
> 
> This proposed change is to unify the prototyping of the init functions
> to receive a platform_device pointer as parameter. Consequently, it
> will allow a smoother and nicer module conversion and a huge cleanup
> of the init functions by removing all the rollback code from all the
> timer drivers. It introduces a TIMER_OF_DECLARE_PDEV macro.

"It introduces" => "This change introduces"

I think, it would be nice to see an accompanying patch showing how this 
change achieves that IRL.

> 
> If the macro is used a platform_device is manually allocated and
> initialized with the needed information for the probe
> function. Otherwise module_platform_driver can be use instead with the
> same probe function without the timer_probe() initialization.
> 
> I don't have an expert knowledge of the platform_device internal
> subtilitie so I'm not sure if this approach is valid. However, it has
> been tested on a Rockchip board with the "rockchip,rk3288-timer" and
> verified the macro and the devm_ rollback work correctly.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Hans de Goede <hansg@kernel.org>
> Cc: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/clocksource/timer-probe.c | 61 ++++++++++++++++++++++++++++++-
>   include/asm-generic/vmlinux.lds.h |  2 +
>   include/linux/clocksource.h       |  3 ++
>   include/linux/of.h                |  5 +++
>   4 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-probe.c b/drivers/clocksource/timer-probe.c
> index b7860bc0db4b..6b2b341b8c95 100644
> --- a/drivers/clocksource/timer-probe.c
> +++ b/drivers/clocksource/timer-probe.c
> @@ -7,13 +7,18 @@
>   #include <linux/init.h>
>   #include <linux/of.h>
>   #include <linux/clocksource.h>
> +#include <linux/platform_device.h>
>   
>   extern struct of_device_id __timer_of_table[];
> +extern struct of_device_id __timer_pdev_of_table[];
>   
>   static const struct of_device_id __timer_of_table_sentinel
>   	__used __section("__timer_of_table_end");
>   
> -void __init timer_probe(void)
> +static const struct of_device_id __timer_pdev_of_table_sentinel
> +	__used __section("__timer_pdev_of_table_end");
> +
> +static int __init timer_of_probe(void)
>   {
>   	struct device_node *np;
>   	const struct of_device_id *match;
> @@ -38,6 +43,60 @@ void __init timer_probe(void)
>   		timers++;
>   	}
>   
> +	return timers;
> +}
> +
> +static int __init timer_pdev_of_probe(void)
> +{
> +	struct device_node *np;
> +	struct platform_device *pdev;
> +	const struct of_device_id *match;
> +	of_init_fn_pdev init_func;
> +	unsigned int timers = 0;
> +	int ret;

Small nit.

Reverse Christmas tree the declarations.

> +
> +	for_each_matching_node_and_match(np, __timer_pdev_of_table, &match) {
> +		if (!of_device_is_available(np))
> +			continue;
> +
> +		init_func = match->data;
> +
> +		pdev = platform_device_alloc(of_node_full_name(np), -1);
> +		if (!pdev)
> +			continue;

Shouldn't this be return -ENOMEM;

> +
> +		ret = device_add_of_node(&pdev->dev, np);
> +		if (ret) {
> +			platform_device_put(pdev);
> +			continue;

Why is this a continue ? you can get -EINVAL and -EBUSY from 
device_add_of_node() - can/should you really continue this loop after an 
-EINVAL ?

Understood for architected you want to keep going and get the system up 
at the very least I'd add a noisy message about it.

---
bod

