Return-Path: <linux-arch+bounces-4104-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6948B8907
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 13:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5161F24B91
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59655E5C;
	Wed,  1 May 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdwJeK55"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A173E5644B
	for <linux-arch@vger.kernel.org>; Wed,  1 May 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714561870; cv=none; b=dkpwDQUJxWGToDtmM2iqhTRuQipb0GqwvFaSY5belPrXM/4ia3HL1H2R81HnZVzaZ+1iZBy1WJMQMB3jwapuiXTkLsk09pXOz9iRx/uHyeb2H1ZuWvAsBfLJf9xi7rCvoX4sOlWRSb/AD2+wa6yPFg+YDocK+XIj4762C71YplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714561870; c=relaxed/simple;
	bh=HjmQN/vLfXCeKes7nGzRxBen9HgLMO+9+ng5Ze3Bavk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rucTUe6a7sQSIYcG7Ag/hCUDS9Iy9/rUKPA4y+l4Zd7+BddpwPH64AscCAB/Rnes3iWE/kUbZvxp13hbiCk2o9xOy894UrxG1Dk++jjN5synxVu6z71zD66r1tpOe8d0Zt1R2StHeYy//TF0Fk7WJq6ktiP5k5lLKgd6YvUx7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdwJeK55; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714561867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9EhiTpZ039qYHHJ6iv2nIzs+2XcBDCLGyTfEI94qWw=;
	b=AdwJeK55hxoBcMTRfNAs9Aob7W+ZGgvJsyf9DMHJOeCknTdUZnQ9eWYMfz2rnsstS0wKS+
	2ItzrNhOPa8CuZcm+8xKQmQLYJqDeeN+jTq3Q7hZlxifuKRFd7kERReFt6axqpZUiWI/Xu
	qC3fAcw28EI1I2/J5HfFiCBIpxneewE=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-M1kj_CwrMYmWW4BGlQ4LvQ-1; Wed, 01 May 2024 07:11:06 -0400
X-MC-Unique: M1kj_CwrMYmWW4BGlQ4LvQ-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6ed2e00aa22so6215110b3a.0
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2024 04:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714561865; x=1715166665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9EhiTpZ039qYHHJ6iv2nIzs+2XcBDCLGyTfEI94qWw=;
        b=QT19kFBvoWV6JHsbsnm8/rUcw3TMQ8ObKMfckCSO7F/qP0tCWUIZIlDJkFvZhHUV4l
         GBbseT2Y0m/H0LhVjzPRskekVDg3/PvrKCrFOkI6Jv8toE0gYPO/2RJq7jkmpyLkXO1i
         Mg0RMmEPT9tbhfJueG7Gbn6ohTHXPfYBTDvyHho52xU2SrnaAQfa6lA3Q+99brH9Usm5
         9SjaVU2clKnARroE9JKLfbrTEmT3ulw9RT8BAiBDSdNOXnUm8atALrWsDLAidz1e2ry7
         oqmkk7yJT5gyIpgqvYOt0ZWfx+2cLhQnj3ehZCPjNlUvXjuox9MRCZqGjM+pCoPGU/gz
         M7aw==
X-Forwarded-Encrypted: i=1; AJvYcCU0GfwrTvziBlhAXFjFSRoPzzXaQyY4iBRvmMP1Hnl1VeZSfhr8KH+W9qTbJgaEWH+oIWUVDTMt0YhEREYGrYhVg27bPlnv7OCyRw==
X-Gm-Message-State: AOJu0Yy04SOTCMEereK+zZ3yAa87xWBlyk3+pMkAl6xyWLLLKLbsmqVh
	is5yUqk/v5p9V0Nc15JgV4oJA8oFKApucdKtLy8WZc8KHdAk1K4ucEX5ZUlRZT1mmkDL9xOJoN4
	juI7WzBJq/6pNUeIYvJbUIMvPSEbngPjOjg7Z8DOwzfdYVnfGnXADuGJ9IDo=
X-Received: by 2002:a05:6a20:f38a:b0:1af:59b9:e3ed with SMTP id qr10-20020a056a20f38a00b001af59b9e3edmr2412170pzb.5.1714561865254;
        Wed, 01 May 2024 04:11:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjAPRGKaaujq7rTK1yaA7Ot9xIJqN3jHlI3pLra3C5HiqJNFkOQs4ByCYnk6CyZCfgy9Hx2w==
X-Received: by 2002:a05:6a20:f38a:b0:1af:59b9:e3ed with SMTP id qr10-20020a056a20f38a00b001af59b9e3edmr2412126pzb.5.1714561864872;
        Wed, 01 May 2024 04:11:04 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r10-20020a6560ca000000b005fd74e632f0sm15597042pgv.38.2024.05.01.04.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:11:04 -0700 (PDT)
Message-ID: <47e1b241-9085-44e6-a3d0-4ded94a183ce@redhat.com>
Date: Wed, 1 May 2024 21:10:53 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/19] arm64: acpi: Harden get_cpu_for_acpi_id()
 against missing CPU entry
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
 <20240430142434.10471-13-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-13-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> In a review discussion of the changes to support vCPU hotplug where
> a check was added on the GICC being enabled if was was online, it was
                                                  ^^^^^^^

                                                  typo

> noted that there is need to map back to the cpu and use that to index
> into a cpumask. As such, a valid ID is needed.
> 
> If an MPIDR check fails in acpi_map_gic_cpu_interface() it is possible
> for the entry in cpu_madt_gicc[cpu] == NULL.  This function would
> then cause a NULL pointer dereference.   Whilst a path to trigger
> this has not been established, harden this caller against the
> possibility.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v9: New patch in response to a question from Marc Zyngier.
>      Taking the easy way out - harden against a possible condition rather
>      than establishing it never happens!
> ---
>   arch/arm64/include/asm/acpi.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 

With the typo corrected:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bc9a6656fc0c..a407f9cd549e 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -124,7 +124,8 @@ static inline int get_cpu_for_acpi_id(u32 uid)
>   	int cpu;
>   
>   	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (uid == get_acpi_id_for_cpu(cpu))
> +		if (acpi_cpu_get_madt_gicc(cpu) &&
> +		    uid == get_acpi_id_for_cpu(cpu))
>   			return cpu;
>   
>   	return -EINVAL;


