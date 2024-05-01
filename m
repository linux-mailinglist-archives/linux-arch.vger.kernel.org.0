Return-Path: <linux-arch+bounces-4101-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815D98B8876
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 12:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B31591C22B68
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 10:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C3537E8;
	Wed,  1 May 2024 10:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqppKfNX"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235B51C4C
	for <linux-arch@vger.kernel.org>; Wed,  1 May 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558737; cv=none; b=Z9D/d5oi63vvOKuLpN0xBKgjZe6Flot2KwLJ8YWJUaL4X+xQumyYJn8u6BwSEEPdgDMkvxj2mNqIPoTSmgm0vifA22iRbcQHjEJQVqkh2icBKJjk+btxTCEV+AauL1QkIpTFPiIBsqSdEx+s+nazA0IH6/soInWLE+/0xgXHq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558737; c=relaxed/simple;
	bh=Ev3McdlDAs4BYS6y+XNElwdCdUSfrG/SuHrK3FK3B+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGYPVomb6Rl0WuWEy3u9CfANPldtmsGyuNZJkwZ6CRA7RPEpEWdyqG2t/W8r1IbsvQgtT4zodggRYRypiJwBp9/Lo8kUYaK6H47AjkJdH+Cw5ErLmnccJNNmIlEJt2N0XEFP2jAQ4Izx/iTljCQJ4aMjaS5Mm8NQGMstQlawCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqppKfNX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714558734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxKl3udzzGpg1eT3+MxaYs7RsOyw5KvkU4S7GKrDV/g=;
	b=HqppKfNXGTfgv0SYVLu6TlG/eqZ4d3IpPdCIufevQdNB1SgjdWJ4rR6VZJuaBhb1lte94D
	Pk/yQ/9NhxNQ68P7GgRmtCcTx1VoT76tJFQSBgXjKR59/INjQ52yTTgM3wCTc5Z9YAAmO/
	hJOg12kAaux9BJ5UlzU9Ob2Iy/N0Loc=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-gkZYH1cOMe6YMYWn4pBBXA-1; Wed, 01 May 2024 06:18:53 -0400
X-MC-Unique: gkZYH1cOMe6YMYWn4pBBXA-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c1af8f2f3so70854025ab.3
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2024 03:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558732; x=1715163532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxKl3udzzGpg1eT3+MxaYs7RsOyw5KvkU4S7GKrDV/g=;
        b=gJixuVRBrG9tjkHdG7z2WIktW3T4S+98FyM6Hh2QOhJ1osgAsjF7J26KKITMFbAkFj
         nW6wDZdL3uJxezPMv/2cgDztbYatmRfwqSGrFkwYkCCamPsFZRG96MWHcgtz9qw2sXUN
         1b1j55wTqgepB8g54zRF/hEJD2z9xmSsG6hUfxr9OfLw8BI26VFKK0UB6cVFO2UDf7kl
         SgNsQPtvOWch5vGBrZhrwHYNyK8DnFRyGFFrodBjGIt7I8dhlSoyFh55vK5WbwMUkZHh
         QOev0c9pyohszebcx5bAQhqWHjnIy+h3TigquwoqBC2VgKv08YWn9XRDIZ5PTA5l6Z4n
         y6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMW1Dm9DyqpNUIYRSk9Jl/p2lVbkZ9ZiMTNRe1JNFeXAvPWqIkyF+WytW/GtyMJimtoZk6Sh+CQzkbxzBLk/uWASMqSM58I8w0Eg==
X-Gm-Message-State: AOJu0Yy4/vVNNElG9Dmd164ah380xKNNqN00tYLSg9USJ414j4PwMul+
	N5NiHv1ntFOjc9guE14JTCEQpBVpJCLeNmu1rytWvMpaNnoow7OlnSNrHpgTBV/EzK9j3GL2tQW
	7vs/1TuOzyOZJnUox+PSJmXWz4JyD+aqcYCdKSzqEnmPWaL6tYVuNYFTb9eA=
X-Received: by 2002:a92:cda8:0:b0:36c:5092:e6a1 with SMTP id g8-20020a92cda8000000b0036c5092e6a1mr2567013ild.29.1714558732197;
        Wed, 01 May 2024 03:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXwbnm2St0QGkNYvo0Kzya2DtdxpDRe1dq5klNVqI1ZMi8KwgV+DlV3hJf4iiekAiT2koB1Q==
X-Received: by 2002:a92:cda8:0:b0:36c:5092:e6a1 with SMTP id g8-20020a92cda8000000b0036c5092e6a1mr2566984ild.29.1714558731861;
        Wed, 01 May 2024 03:18:51 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm12183225pgd.57.2024.05.01.03.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:18:51 -0700 (PDT)
Message-ID: <08c6ff11-ab3d-4a4f-95ea-735134fca8cb@redhat.com>
Date: Wed, 1 May 2024 20:18:40 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] ACPI: processor: Return an error if
 acpi_processor_get_info() fails in processor_add()
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
 <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> Rafael observed [1] that returning 0 from processor_add() will result in
> acpi_default_enumeration() being called which will attempt to create a
> platform device, but that makes little sense when the processor is known
> to be not available.  So just return the error code from acpi_processor_get_info()
> instead.
> 
> Link: https://lore.kernel.org/all/CAJZ5v0iKU8ra9jR+EmgxbuNm=Uwx2m1-8vn_RAZ+aCiUVLe3Pw@mail.gmail.com/ [1]
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: New patch following through from Gavin pointing out a memory leak later
>      in the series.
> ---
>   drivers/acpi/acpi_processor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


