Return-Path: <linux-arch+bounces-12987-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D38B16233
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 16:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877023A5C3A
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jul 2025 14:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3412D9794;
	Wed, 30 Jul 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP0fX2fT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A92D94B0
	for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2025 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884267; cv=none; b=QMkxRepqUYY5Y0u3/ZigeoiI47rZ0SyOlVhGyGLOdYFNg+gdgeBeDKc6fuduu3KAVtW1ElAD7lIkDBzLf4wFk3bHYHIcjIJwfE8yMD8poGHOcFfV22c1Pevi2BciT03M9vLxn7H/r2MYGzIQwHBvaFNxYV4VqNIrQXY6ZKOAY/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884267; c=relaxed/simple;
	bh=nZU05SYgwuxz9tXqf+2n4kG2ZxRFgsh3LY/Vsv1Amyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/SzsjA3wlMDe51PfdAN1Fnjd1TbtxsfDxmUsEcgY2pcpQ3hEhFilPmEUm1xzAf2nCbYzploqaiKmcM2G4rem2sMbL8ilmUpxfRntWmcNNoOHQjbHk+fxImOpzFM+jy7Zipqnr/crDuwBkyW/PUCqS6aDFQtSpfaPP4kQ8QGDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GP0fX2fT; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso5772585e9.1
        for <linux-arch@vger.kernel.org>; Wed, 30 Jul 2025 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753884264; x=1754489064; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jk6Gtn926lXsIj4x4Dh1A7mGQexyVuqQFAqQu1Vz/9Y=;
        b=GP0fX2fThCo+QUvvVO00lJN+qe8vl5TFgrK3Xpk8vqL+HVZmw9sa0mofHBToGJwgjG
         bdkseuVtRNtOOIt/sEG2U+sFFFz2v4K8RIevJvOBZ2Eq8ivawkjruCwlAMJQ/EeRvmG+
         9IpmRlM0qsUlheO7CsEy47dri87oHrHZtiEwnl+uYMAFT44GzICOWXwC799VBYgYf3NU
         roL9RYmN3xcScWFf2t5TEaZl8nwI3jIOKmC2cDBHii7u+1j8ZXa+31X6LmAZGkRIP083
         VKJBp3dbhvXX8Dcnh5xYCCqeLE4rIMpBaUSOhM88NwIIEGIFc8Q729FI9CiCzbR5wfEn
         eN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753884264; x=1754489064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jk6Gtn926lXsIj4x4Dh1A7mGQexyVuqQFAqQu1Vz/9Y=;
        b=tYrPeKWitDxQ9aI0DP5Ni7QAHoNs4Z52B7CLyRnBumy1533B8kepOD1A2kqg0cSPKH
         XdSe/tzIN+DL3fB8Nn6pOuXdahtcM8N76G61tRHVbVa+bse+8GBZFIRRWzjqpHa7HprF
         85OwITOxZcEZcvCliMzt3EocAvSFMy7xUcqNX+jdj4DU4sT7nv9L6oey2Z0USxfTdM4E
         h+bzzMWBTg7SxyNvNZGb/xj5q3P0H1lsnlA4kK6iFgeTXY1Kcz88LTdcpKOEkK3vOiQD
         0C5Eu6BK8IJ2S5LHvL/7SLsf5UX97PhOhHXaIi3kAICDBuzymjX+9tLfRJMpANakSVo1
         qqSg==
X-Forwarded-Encrypted: i=1; AJvYcCVpsw8yAtFB7OQje+Q1a/LO9TGDM2Kvg5BtBxFtf3/cTCiYTbV2MLC+hHes594xHd7lt5KG2X2zRAnT@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWjTjM90BUvmbUQk6fQ4T+SlQTujXOxZWm1wvGzXcbj6EnOZG
	ynSblP4qqLAz5vZpNa6DMaw9lwjJOgZGWUfJYpChMlZLfBfsohR1hFkyHLqkq9qzMxM=
X-Gm-Gg: ASbGnctZMDeNUvtEnDp75dKCRSzcHaL0nZo2/sd7ApjVixlMevYsIxfZAQ/5rUjMB1z
	Dr/SmSN1zC9anaMrDX9O3hE2J6yR3HL294x/hbUzo7wdtVK6TejXKe+GEPs1qnwKyabXe7dy+Hw
	FRHQ20jujSveINzaYA4EvNEO9u8uKA0gFStPAGpMdh5o5ReaZXzk6ycX20AZj9/5q6Ri9Fg7AVM
	Y6GQ7dzSDM9NoePEedIqgalGmLUdQ+AfeyXbRwllgwd0acBC7QB2sI6oC0i+5rkfeu6fJZ4r/SR
	BoRw13DlJl/hxbaG19jfAZEBDugfdKPJov+6USGe+zKycQPxzezKGjoOArB1vDfeT5foZF7Tv7O
	IqEW7kRLcBsNB4E2tH0S0DnQK4WKxmVAv1sZOA/JY
X-Google-Smtp-Source: AGHT+IHNA6XybUky+XOgMeIdLaBli11kALj6z7ErPNCO0GKInoPJQDHw2ePlzrIieSLuzlwB0GbSLA==
X-Received: by 2002:a05:600c:630f:b0:456:18ca:68fd with SMTP id 5b1f17b1804b1-45898a828a3mr27912095e9.10.1753884263659;
        Wed, 30 Jul 2025 07:04:23 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b788f5f255sm10023729f8f.13.2025.07.30.07.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 07:04:23 -0700 (PDT)
Message-ID: <9843578b-2adb-4f6f-b3c1-99dac003e2bf@linaro.org>
Date: Wed, 30 Jul 2025 17:04:22 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 16/29] mm/show_mem: Annotate static information
 into Kmemdump
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-17-eugen.hristev@linaro.org>
 <7ecaae9e-a088-4c1b-9caf-6a006a756544@redhat.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <7ecaae9e-a088-4c1b-9caf-6a006a756544@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/25 16:55, David Hildenbrand wrote:
> On 24.07.25 15:54, Eugen Hristev wrote:
>> Annotate vital static information into kmemdump:
>>   - _totalram_pages
>>
>> Information on these variables is stored into dedicated kmemdump section.
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>   mm/show_mem.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/show_mem.c b/mm/show_mem.c
>> index 41999e94a56d..93a5dc041ae1 100644
>> --- a/mm/show_mem.c
>> +++ b/mm/show_mem.c
>> @@ -14,12 +14,14 @@
>>   #include <linux/mmzone.h>
>>   #include <linux/swap.h>
>>   #include <linux/vmstat.h>
>> +#include <linux/kmemdump.h>
>>   
>>   #include "internal.h"
>>   #include "swap.h"
>>   
>>   atomic_long_t _totalram_pages __read_mostly;
>>   EXPORT_SYMBOL(_totalram_pages);
>> +KMEMDUMP_VAR_CORE(_totalram_pages, sizeof(_totalram_pages));
> 
> Tagging these variables that way is really rather ... controversial.
> 
> As these are exported globals, isn't there a way to have a list of what 
> to include and what not somewhere else?
> 
> Not sure if any of that would win a beauty price, though.
> 

Annotating the variable was suggested here :

https://lore.kernel.org/lkml/87h61wn2qq.ffs@tglx/

It does not win a beauty prize but it's simple and efficient at least.
Do you think it would be better to gather all the annotations for the
globals in a single place ?

Eugen

