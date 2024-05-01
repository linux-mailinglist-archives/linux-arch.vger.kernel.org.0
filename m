Return-Path: <linux-arch+bounces-4102-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 629948B8878
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E7282CE0
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491AE52F62;
	Wed,  1 May 2024 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdmfrsHl"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC642524BE
	for <linux-arch@vger.kernel.org>; Wed,  1 May 2024 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558777; cv=none; b=qElCRzV9YYxDZ1+5k4fXtWthef9NDs38U2mzmZyh4ZWCYRmSJpa3nZ6SAyA1KIB8KZo+d41FDDh9wOHkUlx89phT1Opqo02KjuPefioH0hxnwqIm8W/Ah3xoHbZiXnd1cN+H66k3gVr4gZ8Uww9O8qEY/hNIbsuOblsYURc1Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558777; c=relaxed/simple;
	bh=DXhxznU9JjmpSNzg1wHRqUCO05ryVh2E1hgdKVJ0r/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLBsaZtnUknS35gLAdfEq3JEIU7H4/B1oHiMkWvxzVTlIBD6sLJMueYIqPNgPA+Rkwb1NwiPTFAFCeCnGTT9S6o5cRn859uglqCLk05fTLFPR0MXiWiS898cr/FTaIrwQUaLxJPpz5QkLYjrDnsK7KFnKCphajNeBPHgaSO9a9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdmfrsHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714558775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
	b=AdmfrsHlXaTnQk1wpxyiZrYV4pCG1hKqgnBgc0yCbmDKFwZhy21nZo0BcyE5+JOspYWgOB
	pdosOxTTznrRW1kK/lwNLPdWjXpnJhDRYM/F5F28ncJ0F5a/zjzLJOVQF3Lab34DtPY3zR
	M1XWBsZBaNXI0sIA315CMWcNLXP9KI4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-FrZ-1tnAMtWi8lZzlh2CVw-1; Wed, 01 May 2024 06:19:33 -0400
X-MC-Unique: FrZ-1tnAMtWi8lZzlh2CVw-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5b1a8c36932so526827eaf.3
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2024 03:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558773; x=1715163573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mmEGz0tj7kIblBaqJ9h8gJzxXs1BObonWK5NXhTXy2g=;
        b=r3eijYldCFMp5yLvJ4Q0YyDgF/h+KFaJfL/WFnJX/o4fqBO5SUdPexB0hAeIFmzxz1
         hA1Cd6x+65b+UDlg0FDtaPPpm7m1K0JwfeCQlvefd1Wau6wYeLjdJX4egukm/UI8tTIx
         mDCaAyoFUlG93JNOzyv/TBlXyQaUu/EJpQEyyxY2kYZ4asV32Esin6I9SyJ/f2esgp/I
         PUQzN5eqpT/jqHSR5rUpwSn+BCQ9fwCglmTWao2MrXjOSRMzWC+QR823naBSyR/q+922
         mXeQvH7sp1pj2QyfRuKLi5tKjcMnfjdOYF/vXuqhvk54P3lIdpAFiQaKleUJWfMvSrdH
         doyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs1WxbHdXdtc2g7zAgXmAiOECpsnqQXkY2It/DsoJQBas1rU6i6yWEu6oMD9NLZxjIeOL3CT7/GkyElW32uTM7swJrrFW/CqF6vQ==
X-Gm-Message-State: AOJu0Yye3hGiDzMctgMg1GuzJIezTmQb/xHcYOVCukxSBUqoHlHSQNA0
	PDvPSjfIWy1+pB9G0Kq5BEKzZSZZEFVD7KiQVMIbtLAvxOhyf8a60vrhkigAyyZTn0bfJ1ZxklO
	UluWCqEAArZDUVcR4vkuHVxibyhXWwxqRKNVwxNNYTKyA33iXQ74UU+tgTGU=
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565155rwc.30.1714558772874;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH109ZEmrs8b6zIYcwGCPZVYbwoFohFQfuWKsDp3G4uwsHjXJPYYLUDItsMWRt9l+MVNm+LjQ==
X-Received: by 2002:a05:6358:b3c2:b0:186:d3c9:fc0b with SMTP id pb2-20020a056358b3c200b00186d3c9fc0bmr2565125rwc.30.1714558772433;
        Wed, 01 May 2024 03:19:32 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id x71-20020a63864a000000b00606dd49d3b8sm12183225pgd.57.2024.05.01.03.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:19:31 -0700 (PDT)
Message-ID: <02922d47-6bb9-4865-b13f-b3a6972853a6@redhat.com>
Date: Wed, 1 May 2024 20:19:23 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/19] ACPI: processor: Fix memory leaks in error paths
 of processor_add()
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
 <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> If acpi_processor_get_info() returned an error, pr and the associated
> pr->throttling.shared_cpu_map were leaked.
> 
> The unwind code was in the wrong order wrt to setup, relying on
> some unwind actions having no affect (clearing variables that were
> never set etc).  That makes it harder to reason about so reorder
> and add appropriate labels to only undo what was actually set up
> in the first place.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v9: New patch in response to Gavin noticing a memory leak later in the
>      series.
> ---
>   drivers/acpi/acpi_processor.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


