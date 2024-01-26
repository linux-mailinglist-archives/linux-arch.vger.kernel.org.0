Return-Path: <linux-arch+bounces-1710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD16D83D53F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 10:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEF51C25A3D
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 09:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822115BAF2;
	Fri, 26 Jan 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4LPTNxN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C7C128
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 07:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706254940; cv=none; b=boxyPKt5f/gS/FMH5nlpyjfg7kyxvm6nR83Sm61dJk9ieeoCPui4V4YIu1rHGE/S+KTMPC8I+KftePXu75Bi5iV32kVR+K+0r9UC1cQBziWVdwQX5XUBNWWjUXCJW2sMo7x2E4VmAOANmDnjIEhFinYFjydXHgHZ1nLwQSHOpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706254940; c=relaxed/simple;
	bh=tQ2c/cEw5aGWnB+naAPEzDYby+wwji15e2euP5qvuIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdIGVQ1jucGNFPvQP4lqn2nXVthaev16xuunA2vrasnd0FkagyObYy2KBsAlU7CanfG5+0WfNp/7ps5aXJ2at8GoqvoLc/4+R43eqEcZCO8b3nbblH76KC5OwpofWn/AgcAn57FGrEAXDbs+VyF5qcXnr1zGY7uMv4QvzH44Czg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C4LPTNxN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3392b045e0aso87754f8f.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 23:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706254937; x=1706859737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnzF4d7oKuUxVxb8z8zdPhok7BTrKRtoEsaABtyF68M=;
        b=C4LPTNxNkVmvTzzpl2deAb7f9nHS9gfz7uijCtITPNBUjkDENwiM+Zkr2uXoKw9SCp
         16k3alnceek0xjqhbutM5qwgnTUPR5rBeFYcajLF1WQqXdcQlbAOiY++tu6wjjs8qvGB
         C6iEV04jHiWdVdPKiCIgsM9fX+yA/mHiDyMYPuq85Si0XHirS+tuo0L4x+jsgzXiY6Ey
         d4QGtlN0QbC1LC24AeXpww4CnNJi+r6qeHbgueOjJOSqape+J4DgMpdrxtdXZcMBw1Lr
         UUW8o4OXVLs3POhQZO9As2708Q7r5nOCasg4sCcFInRJ/ui5OXWGXA1FF5vfJysieZvJ
         Sf/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706254937; x=1706859737;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnzF4d7oKuUxVxb8z8zdPhok7BTrKRtoEsaABtyF68M=;
        b=Hk4Zq7AEBUycKBTIOj/p4z1Yk0bD83jNAD+TsGyzVAxmSAKaFlysif1qGbLa5N90he
         Qifd3EjT1uJxtj+/tuJO4u3WN8W6UP4nExWgT6wLdWsBufXqz5sGsXfM7qj92+q339iU
         6c7MYoM8KtJ/7+2zhpp3fsiNspECY/caEn1x3tvBjvOIXJ4EoLsbie60XPceiQ7LkFEQ
         iaKWcrPnrKV3rrbE278c2TyotwFE9eeOQY74EzTRh/rMvlsMBr5SxevVKibmDiMvLzDm
         /bUeFod/1c99sNnXMz8H/u54L+cZMqI49AX/rTJ3jdwk+PQJDWY57iPOLdypAvwhFu/8
         Dicg==
X-Gm-Message-State: AOJu0YxF66ZU60IDBowsbH4vfL8qL2f19FvMBYZ+QdJfGWg2me5JUgDY
	j/7Mblf6nmAbJdb5bra6jhseSoo4di+4l0h0H05yd1ApKW/gZ1/rrORpvt39ryQ=
X-Google-Smtp-Source: AGHT+IGxzskXsWJhluWdGE+2pAIX5uI6zyafuzHDyLWiX8QqbRioRlYV/axGVinNGwk1ssNvCZdZyA==
X-Received: by 2002:a5d:5302:0:b0:339:3edd:1435 with SMTP id e2-20020a5d5302000000b003393edd1435mr651614wrv.56.1706254937133;
        Thu, 25 Jan 2024 23:42:17 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id b26-20020adf9b1a000000b0033924b4d1f9sm651781wrc.94.2024.01.25.23.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 23:42:16 -0800 (PST)
Message-ID: <04da0787-0b44-4c60-94c5-e3a521af2381@linaro.org>
Date: Fri, 26 Jan 2024 07:42:15 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/28] spi: s3c64xx: propagate the dma_submit_error()
 error code
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-14-tudor.ambarus@linaro.org>
 <CAPLW+4m6W-SC=gijBkx_-pK7RvcxFQgnkQzpA23hbO5TEYd_3A@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4m6W-SC=gijBkx_-pK7RvcxFQgnkQzpA23hbO5TEYd_3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/25/24 20:23, Sam Protsenko wrote:
> On Thu, Jan 25, 2024 at 8:50 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Propagate the dma_submit_error() error code, don't overwrite it.
> 
> But why? What would be the benefit over -EIO

I'd like to see why dma submit fail rather than "oh, it's an EIO".
DMA submit should just add the dma descriptor to a queue, without firing
it, thus EIO looks very wrong here, and it's misleading.

> 
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index 48b87c5e2dd2..25d642f99278 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -316,7 +316,7 @@ static int prepare_dma(struct s3c64xx_spi_dma_data *dma,
>>         ret = dma_submit_error(dma->cookie);
>>         if (ret) {
>>                 dev_err(&sdd->pdev->dev, "DMA submission failed");
>> -               return -EIO;
>> +               return ret;
>>         }
>>
>>         dma_async_issue_pending(dma->ch);
>> --
>> 2.43.0.429.g432eaa2c6b-goog
>>

