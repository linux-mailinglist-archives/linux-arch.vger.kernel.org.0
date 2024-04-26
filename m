Return-Path: <linux-arch+bounces-3988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA4A8B33E3
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C08EB222AA
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA613E8AE;
	Fri, 26 Apr 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIU6F4Rf"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2113D53C
	for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123552; cv=none; b=sEybPcLTXg0epySqrLaVoDJ+bAmEBd61nuguoRVqOLYTHK7MXK5Z1x86AgnA9bIC1yn+MS1aONuN77WWCNGB5Bywq30PJMzM7e6wr5JXSMC/3gh3FyVVGk5ibpCWHODiaNtj705YQMZrerphnLsv40ir5SP5TinqiTIYX660nJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123552; c=relaxed/simple;
	bh=v/8fP7ljlfNYu8p9ZmxbNzZV08oGzX9HMMT08K/tl/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1e0D7Hk+VvbAAx9yKx4Bh5PGan2lgAh9yrLatArcT6q7k2A9B4pnQVsH6ZhDRmyUb9laLEDfoe0Kf147Cxt4QySCWwn+YohaM92DFzKpSFSPGg+yW5gREPB2OevcneZ3658iLol7EYZW7fzrFM48O117Ar1euDyeFLuCInIxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIU6F4Rf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aI+0tk0N0rfZ0+RaTapxWMbQJR8XZdeH/fzJ04k7BlA=;
	b=EIU6F4Rfhg9Jg4lpAv/aUgrpZcYkEisw/QVybvAClUuBCydNMr+xuISt3Nx/TMO8lARn20
	R07r+yZBL19tSIoRBBKObjWZMaLw2AeP/GX12P/YOo7j1eY+JMS+h51RhUkZ1cw8DqkGpF
	+yuIHe1cTLDW2IjtTLFYGcuk2d0zxXk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-FSIKofS6NAq6FInf6n75uw-1; Fri, 26 Apr 2024 05:25:46 -0400
X-MC-Unique: FSIKofS6NAq6FInf6n75uw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5dbddee3694so1440781a12.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 02:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123545; x=1714728345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aI+0tk0N0rfZ0+RaTapxWMbQJR8XZdeH/fzJ04k7BlA=;
        b=gvrEr89FRz7HzmXtP62bW+SeIryn8cuRX+KCYj9MJfw4IzfyfHynBqxgJ+3utHjpyc
         C8TwMPFZ1BG19czcT08N3cI9ac8oigepGwRpfxKXf8x59uiDKmj/vUY1yvMUq/cPoott
         COZwE8Lr2H8eR03kVWEk9z9zeknAJkq9Berdre5wSBvXpl7epTYG8y4FQKTmixiw1gM5
         ef7rdI4TFi1H1yGdFsURafgeF26iwgi6GM+0Pc2zG0dKFDQTNTjVmOi9bPuJd5vn9T4v
         eVpUcvTvZPwi/QPF+OLPD2eM5jWupwjgE2TIW/6rUC0x21NfxOAkAGZ2cEEumSOQ2lXZ
         ySGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJBxjgrBg7vsNPHmzSLF8aE0SEyj4isDAuhN+XCxCnJ/1XqSY2rs6Q2NVwHHUyajXa1MEBtFj3MKkvkRFlQIHAEFKJCLdryOF42g==
X-Gm-Message-State: AOJu0Yyomc8dUM1Mi47Su9NJ9MLZcCFTntJJvXhOwmvokr7vPqOQtLCQ
	mvlHnK5zFV+CHyyNsznHlend9RHn1rtyD9AS4ppOITfKDqhv49H/jn6Xuw29iT+gfNzL+Ks+OvU
	9h/ozg5pQRR/ucoirgVFrUT4/8hYjCrPGLKz88U4Lo7tFIAfZkDOeaqNQvf0=
X-Received: by 2002:a17:902:cec3:b0:1ea:482f:f41e with SMTP id d3-20020a170902cec300b001ea482ff41emr9963258plg.15.1714123545328;
        Fri, 26 Apr 2024 02:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvlGXSv/tKHY50Dw7+RKb6bmu/jV2eWJbng5XCKDvWXp8D8BnGzOt+jBjaEMTVQZ+CP26+DQ==
X-Received: by 2002:a17:902:cec3:b0:1ea:482f:f41e with SMTP id d3-20020a170902cec300b001ea482ff41emr9963218plg.15.1714123545006;
        Fri, 26 Apr 2024 02:25:45 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm15054500pls.61.2024.04.26.02.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:25:44 -0700 (PDT)
Message-ID: <0a96abc4-8205-447d-9e7d-03397de5ada8@redhat.com>
Date: Fri, 26 Apr 2024 19:25:36 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/16] ACPI: scan: switch to flags for
 acpi_scan_check_and_detach()
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
 <20240418135412.14730-8-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> Precursor patch adds the ability to pass a uintptr_t of flags into
> acpi_scan_check_and detach() so that additional flags can be
> added to indicate whether to defer portions of the eject flow.
> The new flag follows in the next patch.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change
> v6: Based on internal feedback switch to less invasive change
>      to using flags rather than a struct.
> ---
>   drivers/acpi/scan.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


