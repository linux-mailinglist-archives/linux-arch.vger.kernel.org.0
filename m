Return-Path: <linux-arch+bounces-14956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAE9C7070E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75E8A353DB7
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEBD358D05;
	Wed, 19 Nov 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV5ypvbi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37B33A71F
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572790; cv=none; b=kM7cZvFAfGK1rjzCjjAPJv69wRWIvQL5K9oqUB+zmq7b3fegXrst2bHQ8ZOYnFhzKqCfTMkdtuDA3HmYkDQgTzlt0VdTWPzmh01XtxaxSqUjWHz95pIPyxNpIz6RH05CcVns8IxdIjWEu7U89ylR+h6K85f7egEXXbIBoM73+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572790; c=relaxed/simple;
	bh=UTnsObU+5/BfOz0pGlvdtOsTqbuwL/EFPcGG/OAK6zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMDl6ZyNi99AfO8dnkMyjCLwlvSy80c9QdyNVh1ly/UksaVZoQnP1QHiH4llVZzawYGKXUqkMY4+JVli7eAG8guUQyP9e2RbyI5Xj8EAoxem5r3d/wZm0oAJFn360wfbP+iGQWxYJfOTU3CbbNUB6SCXH3/sDxg7MWEFy//I14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FV5ypvbi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7277324054so2472466b.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 09:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763572786; x=1764177586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoCeIVGZrihZGBDqvC+f7PXwUd8OXTG8E9X1EYx2gXI=;
        b=FV5ypvbi0c1g1GVk2oRsP6V206ZBIPZ7DJw2Dh/yBQnEfaS3DrvxlCAdZa95+c9xXg
         bb+YFjEt0Ozp3d1PN5x5v+gw6obj0/B1ZiDwzThrcRnW6dJPSATTCaO4vm4/vXoY2ktw
         Adxh515goJVC8qrnbUjtonPWEe0Sb9+/8Lc0xBZu/s53ak5v30IUP1ZNEwpBZvcs9gYb
         72/A/K/toru0tYBR3OdDptgRzjWnWBGekiqSFSK8CnV27FW+3CnlMu0IARu1Py4YdVUa
         eO3C1NMgAFiZy7mnCThN43IgsUfXy9UFfab+494llewzIA2JuHwjX5tikjxOQjypiAPV
         z7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572786; x=1764177586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoCeIVGZrihZGBDqvC+f7PXwUd8OXTG8E9X1EYx2gXI=;
        b=mIpMKFBxSRd9KbqUIQxOa1qkJzU+hCzAYhuON6oBo49TU8Ff6bddmx/w8lqHp/zFSe
         tywo4kE9nOJF8flh0y3lxxO+WYiFTCKz3Uy72rbNx1r901O4wBT5kypKSAFZWb3KwVph
         ov5imEbTtm6XFixbMhPwbSQ2Z673sibkO1gUaQfOibI1dV8N3Yeq5W9qOGC10BsNtx/D
         R8gs73YZ4CQjLSQp0+heDV5hXgsuH4+qC45hf2z0LU4OQHS/eNzAP6yfcfFNjGjd674I
         WYebsezj8MSolGSd+6BxeXN998N1t91YApxN6NXWq2AjQrXIu/+s+tYdpbRmpyJmh5m3
         sU3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2zfhGxW3Nt6NwMrpaTwtTRElaoj86LroEgChRyltX69SwDakLYxkil3ZJb8Ctfc0ZrJfJwAR5HBEu@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SFYZAP893rSU7/FthCsjyre6j2c7PEEveZAI9gqUSQT/cDSi
	xkIs62EpUX0G8dYjyECAO262K8l0yEDjNweSj942cARUAFTxbAP01W8a8dbpm9LiMME=
X-Gm-Gg: ASbGncsafxxogbEyO+TFYaxA51zzZ2Du60/1hXOZF1BpEHgPq5SfOPz6Q+gTr5Hhk++
	GSSgD/g/bEq9lHBm9Y4n26RHmHP40V2Dz8o4yrZVadJNfM2a4lmG/P2Pmck7IrQGP4VMBzJ8x/R
	8nCzcUZQw8PNs8a/gLY3c6hzK+2psjIO+uD78jz/xs9KmfI/c+Pcfi6haiD0Q3qbfueADbs33wR
	NWgZZzhwYvZF2046zUQPkkBeBZHrE/UNe/8ROLWt7iUBx08z/JNvL1C3ZPAIJDwmR1Ku/s7JI85
	vRUK+aQLQnNiWancQVJY5/J08VOLkcFxaIcoUwGSgdRNoAsbvMa9IKoNnamBXZa21viZ9fSu6Mh
	ueXy8pBUq5el+woMQUyQ+Q2dELakBLA76XslCRX15bEuhyF7XyNQW8ETuzWVuTZYtHL3XRV7MAI
	5IPnp8bu93l/x+IYvdxiOyRsFfcFrjGMPCZursK6gOQA==
X-Google-Smtp-Source: AGHT+IHFXlBYjBXYt8PjoVc6j/wKQUSsTRCIrYOrIhFX/QpfdOU8ruX00omnczPPKhikD5LHpvnGDw==
X-Received: by 2002:a17:907:2d12:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b736782d087mr2292251166b.28.1763572785909;
        Wed, 19 Nov 2025 09:19:45 -0800 (PST)
Received: from [10.101.2.140] ([93.122.165.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fdaa15asm1625320866b.57.2025.11.19.09.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 09:19:45 -0800 (PST)
Message-ID: <d24c4f4c-e58e-483d-adeb-9ec1799c80dc@linaro.org>
Date: Wed, 19 Nov 2025 19:19:42 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Introduce meminspect
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com, tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <6c9b0aa2-820c-4153-ad64-cd2a45f7cf32@lucifer.local>
 <19171859-94ac-4f41-b100-70a1497e62e6@linaro.org>
 <dc9a8462-8384-4e9a-94e1-778fc763fa9a@lucifer.local>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <dc9a8462-8384-4e9a-94e1-778fc763fa9a@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 19:14, Lorenzo Stoakes wrote:
> On Wed, Nov 19, 2025 at 07:11:23PM +0200, Eugen Hristev wrote:
>>
>>
>> On 11/19/25 18:30, Lorenzo Stoakes wrote:
>>> Hi Eugen,
>>>
>>> You've not run scripts/get_maintainer.pl so this is missing a ton of maintainers
>>> that you're required to send this to. This is not a great start for a huge 26
>>> patch series that seems to want to make very significant changes.
>>>
>>> Please try to follow proper kernel procedure.
>>
>> Hi Lorenzo,
>>
>> I included the relevant mailing lists, but indeed I have not cc-ed every
>> individual maintainer. Do you think it would be appropriate to resend it
>> as-is to everyone cc-ed (PATCH RESEND) or just do that for the next
>> revision ?
> 
> Yeah probably fine to do on respin :)
> 
> But obviously let's not land this without at least 1 respin/resend.

Definitely. This isn't something that would land without a lot of reviews.
I am sorry again and hope to hear your opinion on it as well.

Thanks,
Eugen

> 
> Thanks, Lorenzo


