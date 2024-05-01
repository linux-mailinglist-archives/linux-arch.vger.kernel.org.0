Return-Path: <linux-arch+bounces-4105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407728B890E
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 13:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1F12858D5
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 11:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8243956770;
	Wed,  1 May 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCrtPYnZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CA548CE0
	for <linux-arch@vger.kernel.org>; Wed,  1 May 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714562042; cv=none; b=rqY5ijck1gI1NzG+vZ7Sda8c/hY8d/QffqqJ+FQeASDRpjbXfcN/2yzalmSyyia/wNnv7+4apUR8Y2udUS2JxI88RTSr1xNlDnj7zuS61HXvxQ8gqyeit0EVIDwFAqAycHDDgZI6X4LKOJw2dPRnSs0uYF3za/VdpTY434Kzwbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714562042; c=relaxed/simple;
	bh=Gn2C+fSEj9oEgEcKRZTFnYTq392nKVc8ox1XVnAtZ4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lneKpkpzARLeIC0qcgCf1UJOjxQ2b66OwrwTcBgXZibQgnBjZezFHKRIP+lsxvm7akURdZq1TPCxoWtRC544s/x3rgGe+v7ArXODXGkhjkR7QTtRdN/sA+AOXsURqe/edUS1vZr+BZAmkwqWVBiu6BdAeSS3Uk7xLJJsfCa1ua4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCrtPYnZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714562040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klJb2Hbg7SNB5TUedK1etVELNa99mZOeY3ik6uIdHp8=;
	b=cCrtPYnZiWRgYHzxmllroQOT2O32EuArsrHKPmdUEGCXfQlpKMHzFE8IAEkjFtvTuezduJ
	OJNaTsUUq4nUTXY8qAukcnVP/mBJoTgp3mdI5VcHit6yHsT2VFD4SMk0Lm9vl9nuxm72l7
	bx+NX13bLrjZvYqa/6DoRSjQcArOxyk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-LGD7dkKpM0Ktutc05E4yTA-1; Wed, 01 May 2024 07:13:58 -0400
X-MC-Unique: LGD7dkKpM0Ktutc05E4yTA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5fff61c9444so6536214a12.2
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2024 04:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714562038; x=1715166838;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klJb2Hbg7SNB5TUedK1etVELNa99mZOeY3ik6uIdHp8=;
        b=wZ2BVEnXW7TfDYRrcajb031pDIXLjU4C4DOJLi3YBq1Y1ac4DeEj2Z6rgxxQB0nVtg
         Lc/ppvDCuxHL0xLNngmahs9gqbaOrvi1Z3+zIWpAHdJBO2jJW/CMpW85bJcVgm5z56Mg
         R1vlJfXPOxlvm4BX2UA/GCfOgpLVou9L/6aaukvthERodJxUfAVlt+JTRmfIAfTrdoIx
         uVM1RVSl46Y6VjZYLKj9PJSzYK06dY2sC8z45boyDy+jO7Swl2VhgqFABxkYvruDr2Sh
         XaheVU3b5KR3XQ3IMbEtJyjnvBZCAu1CW2mJ1ThjX12/6MVmCFakv5tx53DfY5bmMynM
         2qQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfvep/wwaArFfYKB1G+zGZyOMztEkWSGjdee0JX67rZ55RHghBpRWj277XBihHH5t9kaE6BOqfr/bOm3XdTNpwpZgGmx7hK/rI+w==
X-Gm-Message-State: AOJu0YzlpmaxUD3vttV4uETdsvPLDsM+VN2IsjZt6YmXBNZvq0QOvKlk
	8GKCC+aXzwodRseb0AHykdmfo5uuhjDfQDilewR5WjCFkuWFRBtDuuOE8dhoexO24CEJ+kHq2YQ
	RlWCFXmbNJ5CMFpSyWJ3V3nDKxAMqhQPHuL7MPTG26/t9xK59KBpJEXER1BM=
X-Received: by 2002:a05:6a20:551d:b0:1ad:9413:d5c3 with SMTP id ko29-20020a056a20551d00b001ad9413d5c3mr1712252pzb.17.1714562037858;
        Wed, 01 May 2024 04:13:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk8RZbujTlZAxMHP0HYG36OV8O8L5/EuxcrJRH9h3TeGMjvsyX78a8rPdkWjXbbD+MV6exNg==
X-Received: by 2002:a05:6a20:551d:b0:1ad:9413:d5c3 with SMTP id ko29-20020a056a20551d00b001ad9413d5c3mr1712231pzb.17.1714562037414;
        Wed, 01 May 2024 04:13:57 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a050900b002a55198259fsm3245338pjh.0.2024.05.01.04.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 04:13:56 -0700 (PDT)
Message-ID: <114fcd7e-33e3-4741-936f-21b0576c59e4@redhat.com>
Date: Wed, 1 May 2024 21:13:46 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if
 ACPI_PROCESSOR is enabled.
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
 <20240430142434.10471-18-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240430142434.10471-18-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/1/24 00:24, Jonathan Cameron wrote:
> In order to move arch_register_cpu() to be called via the same path
> for initially present CPUs described by ACPI and hotplugged CPUs
> ACPI_HOTPLUG_CPU needs to be enabled.
> 
> The protection against invalid IDs in acpi_map_cpu() is needed as
> at least one production BIOS is in the wild which reports entries
> in DSDT (with no _STA method, so assumed enabled and present)
> that don't match MADT.
> 
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> V9: No change.
> 
> ---
>   arch/arm64/Kconfig       |  1 +
>   arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


