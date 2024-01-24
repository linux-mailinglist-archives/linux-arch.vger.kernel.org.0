Return-Path: <linux-arch+bounces-1503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E17583A0D1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 06:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD29D1F22209
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 05:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C9C8E1;
	Wed, 24 Jan 2024 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoW63TPl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EDCC2D3
	for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706072467; cv=none; b=umF3vZPfdYkN9GVyX2ykpyywz4adRFqPlREkH0yTuCixlKxV07veQlQs9DpX91SrNjbn87phqba1t93asWV/6bk1LiKkWQddYp0EaMV9Eu2LOFH8gZhfW9VyinMGDPxrDYQwqRrC1o7ZLRiNSC0NSEKl1s7ynkjgjGGYP+u/0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706072467; c=relaxed/simple;
	bh=Lr34oEPG56izAEfXVC+VzS7CMs5oRhBgTumF1Fjwtvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6jJPCpuJToe9sIwpxek8mOQANLx/nOovEt23X24nbtftWMCftiTldFRlPtU/W7IT7c13HaPcSJ+Udtli0BQcUPnslsE2iCnFnJwYhfEfyqGABdwIIquYTIFjQhFklflb01jfLp5HNXx9+5JWz9Pe/nkeSqk/GDkv2jMoI4RVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoW63TPl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso56213845e9.0
        for <linux-arch@vger.kernel.org>; Tue, 23 Jan 2024 21:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706072464; x=1706677264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mg+yXoqVMruWKFx75OynXl2HLLDpn2EH7QUiBIIbeGI=;
        b=XoW63TPl5WtLYSkUE/4LBkViMglt0tEd1TAFAWxv8l/ayF02uhKSm8kpm0z6vTUqK6
         Y/KGEDGCb0VXjG0wyg0fyZfheWPgEpJQNfeQQojqoA8EtdPPrKv3tbLawTBFv9Ams6Ca
         /p0jXsBk8HNjgNWmkV6/WKxTIRm2JpyOcgRzYVosIpg9dC8NCEQnPM1OADC+6XP8NceM
         CFPuAVPk8rvJ8IFSLGjOw+7qg9EglH4NvNSK19vkmeNWxQVUtpbM9ywRAdAl0XxhK6eP
         gef57ITw7xYX4B1AG8ULZX+La5qAEbIeSP0VW2PGE0hz/pB6Ogo7NFqYRXq+OX9x5GiT
         ecgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706072464; x=1706677264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg+yXoqVMruWKFx75OynXl2HLLDpn2EH7QUiBIIbeGI=;
        b=O4M5+zwxpYPPwAKWQVd/52RrZT9ck1I6sno0AfeqbvqOMI6isJBuQd7nOfQPbDe588
         UQpnQHkLT/4lHMTfL08t7LsfGz0AjYg2DvuOvYqHWniBtZFB6Bs6I9MfulGPkDcWNNZT
         N1G4Cuk5K4ONZy1bnCmAezLwYhglOzubaufaoFm0yWjSsHV/M6SfjIc2sEJFrmr2tIHo
         QWPMbiX10n4bx8cM2TaHucTJZevLQOyWZqArGiH/fld65tjfNu+Htq7XP613MJmBRdcw
         5XbduMP4uH9s/GWCtWHS3tVr0l7PuBow8oOjwSB8gEh/f16Z2Vre2GxF1h72dOiIX4Vk
         s5HQ==
X-Gm-Message-State: AOJu0Yy9Ja7tPT/BQclUASqRQwk4vBLO4Rm+JHQFgGNhj1wF+u9t2Y/Z
	gRqcQd6qWMg/l/xc7Bw+W/7lROGME/jnsmZgVyKofOr62oDXIgKaDeZo7s3osm4=
X-Google-Smtp-Source: AGHT+IEF+sQIT0s3TeYunlfmOn2bN96e3yfHNUoZvFh1cXGgZ/0DgRMpBSUOVh9lxQLIL7MTkSj4YQ==
X-Received: by 2002:a05:600c:84ce:b0:40e:44c2:92be with SMTP id er14-20020a05600c84ce00b0040e44c292bemr706757wmb.143.1706072464015;
        Tue, 23 Jan 2024 21:01:04 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id t21-20020a05600c451500b0040e3ac9f4c8sm48185934wmo.28.2024.01.23.21.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 21:01:03 -0800 (PST)
Message-ID: <7c998d34-919b-46e7-8942-75da94d5ac21@linaro.org>
Date: Wed, 24 Jan 2024 05:01:01 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] spi: s3c64xx: winter cleanup and gs101 support
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: andi.shyti@kernel.org, arnd@arndb.de, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, semen.protsenko@linaro.org,
 kernel-team@android.com, willmcvicker@google.com
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <e233f4ff-9ed9-42bd-8ffb-17b66bcf2b5b@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <e233f4ff-9ed9-42bd-8ffb-17b66bcf2b5b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 19:00, Mark Brown wrote:
> On Tue, Jan 23, 2024 at 03:33:59PM +0000, Tudor Ambarus wrote:
> 
>> The patch set cleans a bit the driver and adds support for gs101 SPI.
>>
>> Apart of the SPI patches, I added support for iowrite{8,16}_32 accessors
>> in asm-generic/io.h. This will allow devices that require 32 bits
>> register accesses to write data in chunks of 8 or 16 bits (a typical use
>> case is SPI, where clients can request transfers in words of 8 bits for
>> example). GS101 only allows 32bit register accesses otherwise it raisses
>> a Serror Interrupt and hangs the system, thus the accessors are needed
>> here. If the accessors are fine, I expect they'll be queued either to
>> the SPI tree or to the ASM header files tree, but by providing an
>> immutable tag, so that the other tree can merge them too.
>>
>> The SPI patches were tested with the spi-loopback-test on the gs101
>> controller.
> 
> The reformatting in this series will conflict with the SPI changes in:
> 
>    https://lore.kernel.org/r/20240120012948.8836-1-semen.protsenko@linaro.org
> 
> Can you please pull those into this series or otherwise coordinate?

ah, I haven't noticed Sam's updates. I'll rebase on top of his set and
adapt if necessary. I'll review that set in a sec.

Cheers,
ta

