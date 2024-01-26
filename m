Return-Path: <linux-arch+bounces-1708-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4383D510
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 09:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201BC1C243DA
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713941A92;
	Fri, 26 Jan 2024 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H5e120DQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6F39AC0
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706253703; cv=none; b=t+y+Vhskf6Calwa1Pw6GaAjW8i6Equmkq8teNWVJtzx8QIaYctCNeIErc5YWR6YL4z5WupzroAYsFy3WNjv4YT9Jq7+P9rZ83ZuKdeV1knR0BFeAD8bKbWXD02C6XqJ6TjH3b9MUyhSYIk95vU1HVKVcQ0UFoAqYsz2LZoTlhY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706253703; c=relaxed/simple;
	bh=Qqs2cdGj2JKXrK2vdbzBgigcaqwqPehTD4VKYAKqeo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MjpY/5FIEp7uEKlAedKJNXSrvxfsc446cQT62ihng375xjRT2HFas6yRZfTcUirm/+vVUYoa6oMhhQMAa0pHs+sr0L2DrX45RvXTjadjYa+oxBm74ZjZu2qcSbm58E6BFp6Uog36bS+WiolaohdP8EzRe4ivxd8Ub0uUiiyQ0TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H5e120DQ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ed356a6ecso414665e9.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 23:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706253700; x=1706858500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qqs2cdGj2JKXrK2vdbzBgigcaqwqPehTD4VKYAKqeo4=;
        b=H5e120DQ7ky1aoAIoS/Sa+JfS7bOFT/O7qQDMq5AKNsaunV+/JqhD3p3KQ0eYrkElD
         HpREsjix+F7CzqhDI2TDPa74JlQ8q6wOr+X4xZG0n/SXX18XWA7X9xZ7kxVeVIhJ3gLE
         +67fCREFKr4BGgPJNw2FMbgFCRrHFt8eu/l2NOwE2HSwKXFQPsFpMt21pwmMAzs15vhd
         QsctlwlM11c3hyo0Iue/OhadjEx0xEB1X0HX2DPn8zq+D/qGGGk9LapSdRkmmXTDIa1M
         5KFIQ4rXtCzm5CC04RWtqH6lrGdnvf8SXCsk0NA5bXaV5gJVMBmEopIreb5JQ2OVpX1M
         RnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706253700; x=1706858500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qqs2cdGj2JKXrK2vdbzBgigcaqwqPehTD4VKYAKqeo4=;
        b=X9kVqNf9tNepEQ/xghAxNZP2mKet3Hy4yGo3EFfbjo3onCQMcIcY+A39W4U1w0poWI
         Zm/1ceflywZaX8YPHGsAHwZoOd62HyLMP2Ge/2QfMdXc7Mk3jY9D/6XuhvM7+jwjnXFb
         rpSOh8sR8qetsySd9eyeb+MKfrX6p1BnTED6xzKzsQLXxEmsADprlhmXQb88FKtcqeVn
         H8do1aKsZ+zNir69Jtc6dgPwlFT/hcpCQ3g/CGxh0OlZVhygzp5eu6Hd0vhHjGpuE7mR
         A5OfEEc59J5e7JS8HxIPnzKawOSm6r1pqxHs0ztREmeA5/6JrLk8r6QMbLGLyDPOlx+1
         I6KQ==
X-Gm-Message-State: AOJu0YzvdbEsDpmTC5NoTSCe3m2B9Ho3nOhpcIcKO8uWwQvwiQ+PU2sL
	Lvl93o3avZKhx+QPxJSRRrVxlF1xbvjlze3pqLKwYplcYOMbDDB9CODxEGRBn6E=
X-Google-Smtp-Source: AGHT+IFgth+c5V2TpCXrE0m0JpTlmPOCL1AgrxkX6Qg8BBS3HUskyuuakorYsWB4EK7/vNA2m8s4OQ==
X-Received: by 2002:a5d:5cc8:0:b0:337:bd79:3434 with SMTP id cg8-20020a5d5cc8000000b00337bd793434mr834137wrb.64.1706253699969;
        Thu, 25 Jan 2024 23:21:39 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id bw3-20020a0560001f8300b0033953f87085sm614364wrb.35.2024.01.25.23.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 23:21:39 -0800 (PST)
Message-ID: <50dc8cf7-525c-4261-b225-7db1f7e5ace0@linaro.org>
Date: Fri, 26 Jan 2024 07:21:36 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/28] asm-generic/io.h: add iowrite{8,16}_32 accessors
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 Andi Shyti <andi.shyti@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, kernel-team@android.com,
 William McVicker <willmcvicker@google.com>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-26-tudor.ambarus@linaro.org>
 <01d24044-6cac-4034-a9de-5b69c2dab139@app.fastmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <01d24044-6cac-4034-a9de-5b69c2dab139@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 21:23, Arnd Bergmann wrote:
> My feeling is that this operation is rare enough that I'd prefer
> it to be open-coded in the driver than made generic here. Making
> it work for all corner cases is possible but probably not worth
> it.

Thanks for all the explanations, Arnd. I'll open-code the op in the SPI
driver for now.

Cheers,
ta

