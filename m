Return-Path: <linux-arch+bounces-4106-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEBD8B8913
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 13:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5922859CF
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 11:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C205C8E2;
	Wed,  1 May 2024 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGRzVFwM"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5E56B68
	for <linux-arch@vger.kernel.org>; Wed,  1 May 2024 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562105; cv=none; b=UmzirxOXSC6YHkUKOP/TBINqiA+jVZRKvA9uG/SxUl04vWXYUgytZ0u5pwSBMpFm1iFLqFUw1MOg7S+fGf/cxb15OPfmN5JyaOFBwktJf5d7KfixVic4XA7lboa03CxU2/ZeZ5sTAm610iW0bTYpLxXZMB4Ccy9peVmSxe9osnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562105; c=relaxed/simple;
	bh=FQodAUfD1JkLmt1uTy5qfN1UspuJsm4imcTHYIOZ1zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxxIkpS6/dJyUtj32LP20c0kUTh8NqXZdb4OqHzUQgYIDmBZxD+fq5wFXsanJMFmoGtUbPDqq6uPfOXFkH/rUxt/27b0hTh0JL9w4Lzp9r2iK0hBoDdiUDdvVFiJEyvaJd8w4zKI0aqpQq7NpmGCFc5jnMlrztBzyBqlC1qu9+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGRzVFwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714562102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4zwGvBc/1zudle3Fu3mxvomgwnAp7EzJRWK4hmMCrY=;
	b=QGRzVFwM4PeI30rFlRkRFuZq6UB3Z4zYRNIcS2thKyTFmGdbjiEqDPFrroi6KN2bo7V+3D
	N4xNmBi8cBFgecv6LEnhRhKyLupXOaArDxIuQMREqwsMCtXhZMOdDhMxh/6t8YxRDesXQc
	RZlEsMJbCgdu8r7mfF+LQWsW8vv9uFw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-gjUR5GefPz2_QynHVj-gyQ-1; Wed, 01 May 2024 07:15:01 -0400
X-MC-Unique: gjUR5GefPz2_QynHVj-gyQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2adb84b10c1so654476a91.0
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2024 04:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714562100; x=1715166900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4zwGvBc/1zudle3Fu3mxvomgwnAp7EzJRWK4hmMCrY=;
        b=ZC9drjYFyrdz7NDtiOJdBGBnBkfu6W5vmAZo4P3QwY7/wntPq2dVTJYoY6o/psbxJs
         0OtwUEBRMa35ZwXESPopJYH7Mllyf04pWS4nKc0zA8d/VUHX/XvjGHeUVoD4DoMKFchK
         Kdg6Nyam1bamAUp5ZAUEMWvaCBpuDBab4cYvk+i3NrTzx3eT1d8/6icF12E8aXGyGFQj
         PIsOLNArIQzuSAbAAMCXpg1tHNEe5wp/qG5RbMvPkXzxTsdwmwEnc54gYWs+5EWzd4H/
         0I58eNIHVHa0DBScde66F6Tz68BnPJ9LQLmFli6GZ1qLtUZHnlbSWC/Ha3foEwWb+18P
         5GbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdjUCb0+7QlBUPYOyG7BUMJTu9DQlG7e2YokcRn57JSaKMvgEy6f0ZGi3BBkpfq7gOqWcGOw4CGKf6D/Fr4l2MWsQf10Szdpuggw==
X-Gm-Message-State: AOJu0YzgrbAEi1n2LgKqEtWcyyGC+Qz+Kpav1ji/Z7tFoFKNFLdBb+7y
	2AnDqWxURZ2DDiVZSKmRRz04e0/qcEberQ/wGhcgVHzjLEHxLX5vleRy1KJkPg+WPMa9UvQ1yBF
	aF+mpJyweqskyuEFQQo80nPBktQIBjA+u5yoGI91W0psZ/grtGKkUH66N4W4=
X-Received: by 2002:a17:90b:3749:b0:2b3:6898:d025 with SMTP id ne9-20020a17090b374900b002b36898d025mr189449pjb.9.1714562100005;
        Wed, 01 May 2024 04:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgkwe4UKKc3WldVwMV2boi6I+r208XEIsyNzplTWK4MFoORCuavWHQA0/i+SiniS3enNZ28Q==
X-Received: by 2002:a17:90b:3749:b0:2b3:6898:d025 with SMTP id ne9-20020a17090b374900b002b36898d025mr189419pjb.9.1714562099556;
        Wed, 01 May 2024 04:14:59 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a050900b002a55198259fsm3245338pjh.0.2024.05.01.04.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:14:59 -0700 (PDT)
Message-ID: <27e48da5-e1d0-4e4b-978e-954f1766c350@redhat.com>
Date: Wed, 1 May 2024 21:14:50 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 19/19] cpumask: Add enabled cpumask for present CPUs
 that can be brought online
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
 <20240430142434.10471-20-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-20-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> From: James Morse <james.morse@arm.com>
> 
> The 'offline' file in sysfs shows all offline CPUs, including those
> that aren't present. User-space is expected to remove not-present CPUs
> from this list to learn which CPUs could be brought online.
> 
> CPUs can be present but not-enabled. These CPUs can't be brought online
> until the firmware policy changes, which comes with an ACPI notification
> that will register the CPUs.
> 
> With only the offline and present files, user-space is unable to
> determine which CPUs it can try to bring online. Add a new CPU mask
> that shows this based on all the registered CPUs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: No change
> ---
>   .../ABI/testing/sysfs-devices-system-cpu      |  6 +++++
>   drivers/base/cpu.c                            | 10 ++++++++
>   include/linux/cpumask.h                       | 25 +++++++++++++++++++
>   kernel/cpu.c                                  |  3 +++
>   4 files changed, 44 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


