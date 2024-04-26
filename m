Return-Path: <linux-arch+bounces-3986-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2701C8B33C9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4503284238
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4629713F447;
	Fri, 26 Apr 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9wx+cLu"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E113E052
	for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123247; cv=none; b=M+ZNotZ8/TIQ/izsJjf3911OxQ0FB+W4jreGKbt/U5Q4/PRseQw26W8xwAxzALxl2DZI0aPPUvF3rl9y3EFa/gN9wVwAPv3e2ujbd6tZHA68n4vJy4abc+J+pWXXgBTFKsu1yBgKx1WZxrsRjdCu+lsB2yzX4uwoNRgozwb8BjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123247; c=relaxed/simple;
	bh=C3rHTvF9PHfzdrgv16HQit9eIpwFV1aeMPWDWLSjEDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9/CqOsUXd80+S16dDwK1GjTNZ65tVmxgBMxHIIPq8CRQLWM5JepkQxym5sBjizcTEcJR09CKx/HELPOXclr0OBz7XxWjgbVbF1iZch5fHUXXdtWPCw4T4ZtojvCeRuoWEUlBcTiZ+YRvZ/3gAYKpOY8RoGcebQIMtKULA9l2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9wx+cLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Dmcns0FZ9CNJhWQ+HJ61vRnl0WhR0+EUECBc2kBET0=;
	b=h9wx+cLui4+LP+jP5nDArDLaUsFeiecYNHmg4/s5WF9a1RkTyTlJooGzTNgOI7SkyRKa15
	DQpqvMd3BW3Hpt521KpqQ5hAE5UZ0eNQVFfqdKtdswFBSt77gQnzs63924ED8sspSy7AV7
	PCVk4mF3i3QCxeTdd7foaTk6iHVoh2o=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-NDVr8OYrM4eXz4HYwBaiPw-1; Fri, 26 Apr 2024 05:20:41 -0400
X-MC-Unique: NDVr8OYrM4eXz4HYwBaiPw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3c700dc69a9so2375424b6e.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 02:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123240; x=1714728040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dmcns0FZ9CNJhWQ+HJ61vRnl0WhR0+EUECBc2kBET0=;
        b=irYS+uwRWqK3OzmjtJunSnBWmbSTIY3Ss20D4mHOPnAliCSVhFe7kjrAVd/T2wReIz
         x5M5Ut4nB/d4IeG7ZiX7lHsTDGN/bp4vcJSwqQsVFBWj3fyGEA3hoxFUGy808Pp0lTUb
         jfDzXoeG1xKLE8o10Je59C1aKBkDgz1bIa67lGhsLDfqtjO1Wct3ZYAuz8KZHkGnBmxM
         T9bA4IQwqmS97zkBKDWyBH9i5Pn3rt7XPG8pi/V7t+8cWet2ebvsewkG5YEr73Q+8Wf6
         VqS+dIWMWQzKF8N63ENRwOxJC43eZX921EsylPefMMmePFD1X5k3J6VbcLznCh9T4sab
         ohVw==
X-Forwarded-Encrypted: i=1; AJvYcCU3bZfdNIjzV7+MhKk2xAjzYiBkMzuvV/ea+8S1Q+Q7hJeKQ6tKlBKiH/AtKNCg1xvOEyFErpJIE7ktoIp3SawPR6HYTdtRTNnK1Q==
X-Gm-Message-State: AOJu0YzgrvQ8aa9IejiRL3rCT1vW84ZLIBAc3Wvuc4ivSN7gstAXmSjL
	q96M5RYM4xObvKp70w8iKuEFKy+Z8Er5aoa8YSarwBC4dZRL/QCPkn9HrxsBw9mgYjjfNlqOrzx
	rCx+jeauwtWC7j5j2i2djOj44I/RW+Wm4um7luEVbomTyqNzL+j232w8EAhk=
X-Received: by 2002:a05:6808:1528:b0:3c7:dfb:a295 with SMTP id u40-20020a056808152800b003c70dfba295mr2563875oiw.55.1714123240352;
        Fri, 26 Apr 2024 02:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkmQHR4xd5DGzRLvfFnAFgkLJtQPF1g3QWZiwSfctnEJmyqeJV0jASxLHf/gm5VeDDfBboyg==
X-Received: by 2002:a05:6808:1528:b0:3c7:dfb:a295 with SMTP id u40-20020a056808152800b003c70dfba295mr2563855oiw.55.1714123239985;
        Fri, 26 Apr 2024 02:20:39 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id u9-20020a637909000000b006047eb9c7fcsm5263952pgc.34.2024.04.26.02.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:20:39 -0700 (PDT)
Message-ID: <0cf50b2f-999f-4aab-bc32-15549d48af2c@redhat.com>
Date: Fri, 26 Apr 2024 19:20:29 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] cpu: Do not warn on arch_register_cpu()
 returning -EPROBE_DEFER
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:53, Jonathan Cameron wrote:
> For arm64 the CPU registration cannot complete until the ACPI
> interpreter us up and running so in those cases the arch specific
               ^^
I guess it's a typo? s/us/is

> arch_register_cpu() will return -EPROBE_DEFER at this stage and the
> registration will be attempted later.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: Fix condition to not print the error message of success (thanks Russell!)
> ---
>   drivers/base/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 56fba44ba391..7b83e9c87d7c 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -558,7 +558,7 @@ static void __init cpu_dev_register_generic(void)
>   
>   	for_each_present_cpu(i) {
>   		ret = arch_register_cpu(i);
> -		if (ret)
> +		if (ret && ret != -EPROBE_DEFER)
>   			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }


