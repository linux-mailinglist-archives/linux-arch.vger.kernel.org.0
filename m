Return-Path: <linux-arch+bounces-3987-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1658B33D9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B52B222F2
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 09:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F294C13D89C;
	Fri, 26 Apr 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSfzzAQA"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210113D53C
	for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123415; cv=none; b=iG+3Nz5EXHO3yAQaxHGwqdisvcDqAB9g+wxoVyyMfZiqcnG/4OhKZgIY/KXPESi9daSy7rgQyDVY6pJXv9AA4Bbna8PZ8jMysowX/vbhgZE+jDVUC3MuxaC+BtozcDKQlQ6JEcgfOwiq38bAWL4r4UEDfJOyEtvy0ozABLcjvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123415; c=relaxed/simple;
	bh=Udl46LR7XVoXfrBKhl6mIDBjIxqJOh882IzI0S4UAM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbbFaNBtS9zCOsXM9ybhZsyfuwQ2gdJIGmlSpQWH6kD5m3xlkqOoxWj/e/zE3ePmk8MVF0O8sadBYbLYJq/Us0PPrgDIye+OWsN65wwr+TMYTIgkkArq0C/I8K2vkAq9ehiae3Ao5LRXaaYiLpC8oLWqJP+mQTbtIYdo0MfNslw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSfzzAQA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRAd8wfnSBnkmuLuRNYN/BGd3qvtIlEXRV1WTPss9aM=;
	b=ZSfzzAQAhgZxujKRSys68q292URUOoGyft6rzm0FWsj8AjanGJnImCJ9fquqF+QBB2kn3a
	auIT8Hq1RGeG89pk6jOIIhv52DotF6kMMPYP8xFgYeY08t6I2z/tenrEkdit4plEL/XVyd
	VWMzS7QQwmBQ8tmCuaulartEzrCzLhE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-hvUctRxFPsyFJuNflruUZg-1; Fri, 26 Apr 2024 05:23:31 -0400
X-MC-Unique: hvUctRxFPsyFJuNflruUZg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a5457a8543so2156207a91.0
        for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 02:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123410; x=1714728210;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRAd8wfnSBnkmuLuRNYN/BGd3qvtIlEXRV1WTPss9aM=;
        b=ccblqvz4MZYrtcohNzS+cAwkQchMSXpfZp4stGsi8vtlbP9HucWr4Jc7y4Y46XP/YO
         zgEFfcVCsHzT55aOAEwOAosQyNFBkvuAenyR5jAeUBUu1QmRkNh3NRh6kuTDHjluedHA
         j1Tmwyu+MYJ2aeLRlK1gJ/QKbMkkoNh7HI12EbmwiCfMSjYaBUrK1AD4yBZr/k4l09+A
         ecVnp5QmSrt+rnHp2x8Efkl48Ry7OZuCFdXYza7k/vGoypjFnuciwRcPegSvToFwsonc
         JHG5uAxvEUT5YhN16doHLolcc+vwbKrztMt2it69P+DjcdgOfkeyy5vYiDkn4Fu9/YP/
         js2A==
X-Forwarded-Encrypted: i=1; AJvYcCUfOILNz0ndj2Jqg45RROqaEKj8KsEgPaeAF6W7N6FH/ANL4SwEEK+uUiouwMWy2eRlMi2vecFwKW1OKcOTspPj13gFzzaM7HeuEQ==
X-Gm-Message-State: AOJu0YwL2ovSgvKk+HPZv6rPH60++i5OJ4xYzIGdL1SyIPyPs0nvakW1
	9QJATPm2J1AKX1aPhMhqUkSAQGgtfveaxYa4EH1V7khWn5hBGe9QRN7PoH0/nwt4MKwQGglrU6Z
	u3F2gutVTbl+/uV5pZFwfS3WJVpRVcyHiE6rbxYcAasFhPiivantXAOWxr/o=
X-Received: by 2002:a17:903:11c3:b0:1e5:5bd7:87a4 with SMTP id q3-20020a17090311c300b001e55bd787a4mr2283755plh.16.1714123410679;
        Fri, 26 Apr 2024 02:23:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTmWdacAorvyOh8QQAQnPNEyl/iXm9VdRYljIzI/YjTWhI47bK72rLeP2m/Hny5DHEF82p7g==
X-Received: by 2002:a17:903:11c3:b0:1e5:5bd7:87a4 with SMTP id q3-20020a17090311c300b001e55bd787a4mr2283739plh.16.1714123410303;
        Fri, 26 Apr 2024 02:23:30 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm15054500pls.61.2024.04.26.02.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:23:29 -0700 (PDT)
Message-ID: <566817ae-90f0-4ec9-b54e-b9fdb635119e@redhat.com>
Date: Fri, 26 Apr 2024 19:23:19 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/16] ACPI: processor: Simplify initial onlining to
 use same path for cold and hotplug
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
 <20240418135412.14730-2-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:53, Jonathan Cameron wrote:
> Separate code paths, combined with a flag set in acpi_processor.c to
> indicate a struct acpi_processor was for a hotplugged CPU ensured that
> per CPU data was only set up the first time that a CPU was initialized.
> This appears to be unnecessary as the paths can be combined by letting
> the online logic also handle any CPUs online at the time of driver load.
> 
> Motivation for this change, beyond simplification, is that ARM64
> virtual CPU HP uses the same code paths for hotplug and cold path in
> acpi_processor.c so had no easy way to set the flag for hotplug only.
> Removing this necessity will enable ARM64 vCPU HP to reuse the existing
> code paths.
> 
> Leave noisy pr_info() in place but update it to not state the CPU
> was hotplugged.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change.
> v6: New patch.
> RFT: I have very limited test resources for x86 and other
> architectures that may be affected by this change.
> ---
>   drivers/acpi/acpi_processor.c   |  1 -
>   drivers/acpi/processor_driver.c | 44 ++++++++++-----------------------
>   include/acpi/processor.h        |  2 +-
>   3 files changed, 14 insertions(+), 33 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


