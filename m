Return-Path: <linux-arch+bounces-3989-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77658B33E8
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 11:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7429D2849E9
	for <lists+linux-arch@lfdr.de>; Fri, 26 Apr 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01A313F444;
	Fri, 26 Apr 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XO3rE7TC"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2A213EFEC
	for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123563; cv=none; b=jRvi0ptF7grBhRDRetypZ9SXkTmnibIjMu8piC4myIiS703PQKsMSZuR+WYguMhhbcff5IarDtYSo0enIE4aHe51ZBOXXqv5qfddHsLaGSp4eMf5qOjz2AIwqLGuAleyBbvnDiPngyG1VtRKL4sdOItEvt841mcnDhc3XddiONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123563; c=relaxed/simple;
	bh=3prmVvb4CSFrMQtGQGohzxkB5EGRjQF5LNfCJibjaRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ohm+2uSJI1ITrC1zkRmAoT4GN6zmTOuKk1jAQhbeHARcIxrW+dW1ccLO7YJ+xMhgP1Gy6BmBn3V+8Bdlkf309bStwAEYZRxswKJi0ZCZHUOjcdBUKIenXAV1U9TAO1uwDH7NOfr7G79lp9jDRHDVYaJsjkqZzhN3Yc2mfQApQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XO3rE7TC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDf1iJ0rcFw5r9tjCYtJ1fcG4v1z0nEnImYLXEpzCjM=;
	b=XO3rE7TCfy/jarJbKMwZY6fUi1rd9qMXJTUlF3U5BN+w3px91CGnS+cEOrpyK7PjVzOYEr
	JEFRm86GCHtkkk3hwmS8V63JTPhm5pIIysxx+GDdGEHD4RTnS26VaMnURjDmhJ687EYE8c
	jx+BYn/wwJehRLEHCcEBKVY5Cj2PJKw=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-UebYkD-mPrSmKUQy8ULAaw-1; Fri, 26 Apr 2024 05:24:17 -0400
X-MC-Unique: UebYkD-mPrSmKUQy8ULAaw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5fff61c9444so2114095a12.2
        for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123456; x=1714728256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDf1iJ0rcFw5r9tjCYtJ1fcG4v1z0nEnImYLXEpzCjM=;
        b=weXoFn7IQMyUYSkXiiWsuDUvk4P9x7oFC88nkiRXJ1PnMC8atev/Kg4JZvzrHwyGDz
         33MqH9riJK7NjsFFfO3wfC62+Qp4Bip+GTBf74DmRe84RegH5OMdXABDLBtq6CKEShip
         72kGOXYLWQhyK5kOj313nYXdLW/hbmtX1GD5qlAOEfN7Do0ZYlVkCACMwmGBBaN+MZkQ
         ei5fSF3hnGV5dyj6eclB1VWsQ9UXsfm7QXJ9K3qSL4AfieTf0+fTv9rllqW+Tb9zdidS
         ye9jekxqOydHhXm3TDjhYrWY1pBtLzb4AHMgGrxll/0Y5Mh6KpReLtLC621ogb34c3Qc
         8qtg==
X-Forwarded-Encrypted: i=1; AJvYcCX/7owRTbdq4uvBZdDoN3oyYLWThoTZoZK8MTX7riKBqSKbO30dZT5sZJh5PNfnIuJEiuEad5GaYfOu8kYwoe83CCvIDcdsgVgL6g==
X-Gm-Message-State: AOJu0YxX7Q4A1bSKk1k1llNBsJZAoSpyzQUdoGM52wCMUYNuy4ZmxGl7
	IPsDTUopPUwEulCxM89ApMunmgz4yxvg1Z5fl5hBirsUuEL+2WlusMqlQ45PbzM0TamsqyBHzCe
	K/D+5/cYm3eYMKmgv/5r9ZSLk+04CkrYD4ZjVxEYSWN2KV+1+2wYbIcNNyrY=
X-Received: by 2002:a05:6a21:3a44:b0:1a7:7b92:e0ed with SMTP id zu4-20020a056a213a4400b001a77b92e0edmr2325180pzb.51.1714123456721;
        Fri, 26 Apr 2024 02:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxVT+GN5mxbf+mMtYjbokc8FhufYwX7eAOxYXMmkBU6lBE5Xi1LluATczohJhaBcs7ECSJrQ==
X-Received: by 2002:a05:6a21:3a44:b0:1a7:7b92:e0ed with SMTP id zu4-20020a056a213a4400b001a77b92e0edmr2325150pzb.51.1714123456389;
        Fri, 26 Apr 2024 02:24:16 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm15054500pls.61.2024.04.26.02.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:24:15 -0700 (PDT)
Message-ID: <e3fb151e-8d79-439d-9eea-131a23f1d48c@redhat.com>
Date: Fri, 26 Apr 2024 19:24:07 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/16] ACPI: processor: Drop duplicated check on _STA
 (enabled + present)
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
 <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:53, Jonathan Cameron wrote:
> The ACPI bus scan will only result in acpi_processor_add() being called
> if _STA has already been checked and the result is that the
> processor is enabled and present.  Hence drop this additional check.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v7: No change
> v6: New patch to drop this unnecessary code. Now I think we only
>      need to explicitly read STA to print a warning in the ARM64
>      arch_unregister_cpu() path where we want to know if the
>      present bit has been unset as well.
> ---
>   drivers/acpi/acpi_processor.c | 6 ------
>   1 file changed, 6 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


