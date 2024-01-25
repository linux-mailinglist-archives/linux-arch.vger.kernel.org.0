Return-Path: <linux-arch+bounces-1617-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F483C83B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8033F1C2334B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED512FF99;
	Thu, 25 Jan 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgzLHAvO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FF12FF82
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200693; cv=none; b=QpsdNNj2eG94vpFNs/KnJNp2kfIE67kwxXcB+/q8y0xQYOLv3RjvOQKmUtS5IOxyIxcxEOGjl2AF91SDFRlkT9OE6pO+zijyMQK7stJjRZILQ5DR8BuM4px2Zghvcto9s1xB11Ep3+wV+CGWHCGDZo+PZk1Aovkd8MQIRFGrjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200693; c=relaxed/simple;
	bh=5iHmZSUw/hxQN9z3V+lUnPdT+e3bU0zrcKfS5gS85Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rElvphR4jwQ3Ub6azG2QYONo22xde4npBVzKyepZBdynPokUCxeI5smWbmzezBnXSFj8omAKr8vX1T8PZ25g5LkxlQy/wDWFDSukC3Vhhinqqnzk431kHO0w25/0RaoW9TsiFesvoTALZrhwlyej92EExU4inHEayQ3B8pMd/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IgzLHAvO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so67898635e9.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706200690; x=1706805490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rdWJmaQOAQRqKfeFd0MmNRfM9EYtkNX7pmnDfEinoJo=;
        b=IgzLHAvOEaS80zWpEmg5BFAtnbXO+eTi0fW/bIZznAHv0dHOre72Md6C7cN7Pfu3V/
         pEzhWSHr6kBWGXrekYoVVadQZ1WUNKd+rxiuLTXtauYCDiXLFHSwJG5fNllg8alXZlH2
         m0SEGKzkTA98Zp2HWBD85ONaxFUzs3eL6JUXDWOJE1+HysC9YgJVfOkjHF9SahTXSwTv
         YmjETnOqWYkDR1NfrC45d9d8bEVMZrPd/8/fEBMJRm3lIU0sJ2CVIWmQF+w3196VpOgK
         FtkAapWKfe2YWG3G+56MB1N7+00+z8DbnPvEsdeyaDD301ZHUT3vm1CRp2cTx3RKf1sc
         +FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200690; x=1706805490;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdWJmaQOAQRqKfeFd0MmNRfM9EYtkNX7pmnDfEinoJo=;
        b=vsiSR4Q0AQflzjubCRjz4ndlshD6rUYHKUcEdXnx6saavrG+KolC2uh1I9lNwWuDPt
         VZYAin7sn+PNDQSBicZ40MInlY9CaHRGNe9jq1kGfl7K1QKIQT3spAjsgGHxG1B2d+vB
         Lutiy1hDW3Zgfye7/pPgg3j8UlRiZMpOuHptkB8aBB9HDXKmCmNPIjzRUHAlXiV5Nl1J
         cSWpINt+YvAhf0xKgq9iIGwEHKsxPvgnnolFiiV99LIrDWyTSoQ8SOVOLbusBiwN+OaN
         dtBBg/jzGY2b+yAs1dJ7ySca9iPrKKTsJjwsgFjDjNmMhsYzuczzsIlhztaRsIz3WJum
         KaTw==
X-Gm-Message-State: AOJu0YzQDdnggCsfpQcQwHI99imaDC+2eevq+cj8WGpwb5xahRpXku6C
	vAAluov9ImaoMhqP/CwlDOJKWRNRAoAPDtBIb5W3fogIjCMmLH92+gyZAxf6VHI=
X-Google-Smtp-Source: AGHT+IENGpkXRnJ4oq3mQYeuH9mZrQxEhx1vWZCv34pZFd4Er736Z33tETLnlINQ8GGk7N3f9x3CtA==
X-Received: by 2002:adf:e686:0:b0:339:21b8:e716 with SMTP id r6-20020adfe686000000b0033921b8e716mr988724wrm.127.1706200689695;
        Thu, 25 Jan 2024 08:38:09 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id l9-20020a056000022900b00337d980a68asm16818099wrz.106.2024.01.25.08.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:38:09 -0800 (PST)
Message-ID: <1c58deef-bc0f-4889-bf40-54168ce9ff7c@linaro.org>
Date: Thu, 25 Jan 2024 16:38:07 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/28] spi: dt-bindings: samsung: add
 samsung,spi-fifosize property
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
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-6-tudor.ambarus@linaro.org>
 <7ef86704-3e40-4d39-a69d-a30719c96660@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <7ef86704-3e40-4d39-a69d-a30719c96660@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 16:16, Mark Brown wrote:
> On Thu, Jan 25, 2024 at 02:49:43PM +0000, Tudor Ambarus wrote:
>> Up to now the SPI alias was used as an index into an array defined in
>> the SPI driver to determine the SPI FIFO size. Drop the dependency on
>> the SPI alias and allow the SPI nodes to specify their SPI FIFO size.
> 
> ...
> 
>> +  samsung,spi-fifosize:
>> +    description: The fifo size supported by the SPI instance.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [64, 256]
> 
> Do we have any cases where we'd ever want to vary this independently of
> the SoC - this isn't a configurable IP shipped to random integrators?

The IP supports FIFO depths from 8 to 256 bytes (in powers of 2 I
guess). The integrator is the one dictating the IP configuration. In
gs101's case all USIxx_USI (which includes SPI, I2C, and UART) are
configured with 64 bytes FIFO depths.

