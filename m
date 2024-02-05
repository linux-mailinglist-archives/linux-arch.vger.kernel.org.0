Return-Path: <linux-arch+bounces-2088-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AA9849712
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 10:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237441C22485
	for <lists+linux-arch@lfdr.de>; Mon,  5 Feb 2024 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB8B134A8;
	Mon,  5 Feb 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JR0908qK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8D14019
	for <linux-arch@vger.kernel.org>; Mon,  5 Feb 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126851; cv=none; b=SW0uAekfQIxVGurxDJXXfKhRSf53VsbMFtFD4ynC2euleMlHZoplYm2mAKin/FjiOoJVadFsat2SFy0gJbli7d3TEmXXxLqxSmYWRkSnBDB12DOYSUtDQ48JQEzfUMQkx6vHDhWT2H1Kez+OCQysNpJon9D8xiKRGc41231N8KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126851; c=relaxed/simple;
	bh=psNvAEWE8baTrB1sGbOl50Zzr/iYSp3s6jN5Loc/K40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2BzXpBqB+B/F0Hxy8I3ema3vjqvCBrUkZuaM1xsnfrnYU55Qswr6o6YGAej7AgZ1WqEP5WsU0/7qlDVqa8Ics5ejG9Is2Ihd0VTcaW6SnlKvcuQtu7L7NR1SgC7mjyrMNFw1BB7VvrSFZ7VBoMUI6+LCvzcvynqY8ZrUZp1r7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JR0908qK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b1d7f736bso2115244f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 05 Feb 2024 01:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707126848; x=1707731648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kdDd6iCjxYSugu/r8r8KvZPs9W5M6V3aWJQphhyzw7c=;
        b=JR0908qKCttck214fnW3VNBymWrmraukQDgo1FIGcK+mq2Ux6YMZvd87r3glO1XSs9
         2znzPtaiELvVu/0u88h3jfyQoyugLD0FU9PHyqEAxjYs1HcUW7V++Y2QHGeLjNwJo9H7
         q46/prRnGJoYSYc4rUWoAHVuaiebmSnEHAXlAbxapQc9g25kd9xz0/gP6PpwD9QK/Sx3
         MJXmkD4684biPalNShyaIBrboj7XXlctcLSSTR0Qaak4nbQ2Tm4KhrbcGGA+q1c9G+rZ
         cYn/3onDzGib6WcFk/A+4qYmJSGcXXnF+W/1LB9xuMMhjyOFjPNB+Zstjpl+6pJbekjH
         Q2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126848; x=1707731648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kdDd6iCjxYSugu/r8r8KvZPs9W5M6V3aWJQphhyzw7c=;
        b=RObW0QkUu8JJr7aZALZhktsH297IkjZ7szNgZkN9YPnezsyOrM7wU1OUgml3JiOPt8
         bYWAAXpp6UsVN/4YWCsn87wfM+6cCTgrtuRofrVvK4BTDUt+HDhJVY/x5ySP9UrpdHcV
         l4reYpTLJe1iRnln/ZTjmOMw1p9TRoNtfOyO6XbGFG8FxYcPgkgu/FlPdGTMKfM43U+K
         01t1dp8KFjsvR2XjK7MURs0aW7rGFcpqvV9xrtgEMeqwxLagFsQGvCbEH60jf1zFomIp
         LTG6fyd3FdBoTfJPCSWcw8HkB+BtzHCfn5z5bF4Qf//oed0cZ2EwJTB6+6Rgo3exM9Dm
         MEAQ==
X-Gm-Message-State: AOJu0YylQYTXhHLUwpN6nnuNMrpVqj4CUudLVmqUXhCcgA4ICKL2MeJd
	qnciBkaRVU9iiji67zpit6JQPDtMihhlxBDT1uv4PQN5ncf7IYAfuGByC1X2N44=
X-Google-Smtp-Source: AGHT+IGtvkqzyuHRg2AIaNvrcWfI06C3jSQ4JEtyGaxdwwkkfH7T7ama0SR39rz/09fk5t+1uHsxXw==
X-Received: by 2002:a5d:64c3:0:b0:33b:3adb:c67d with SMTP id f3-20020a5d64c3000000b0033b3adbc67dmr3117079wri.39.1707126847711;
        Mon, 05 Feb 2024 01:54:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXTYFjUwwmWYl+PyUwuMweiAuEpQyf5KVGLhQH6TJBalIW6PIBhnzCYjxjMtpAgvA2KwgpI/q2wYIJxiGebRrTXua9XOB9HUALGWT+pjR3hqRXqoBEWHQfEBB0wUT312Ki/3V0SDJyBmKl0YQwKyM41WHaTS/57ElRPXm2si9a+WmoF7x9m8Cv20iFnlpj+V33uG+u7iVkBlyPXF/aOtVZryjpsVO6yrPz5vFuvVdWWO44CEiFLfjkfuzsNhhq+t3H9Dx1cHhn5wPUu+QJOhb23Uh10PVM5V45hNkcqrp5f94hT+ZVJbiKpLpbBLFQ0Z0HnIp1fQNQsMB6NTAx0JhuVF0kwrp3GlgRaQHbsnlltJ+AQ0hjWYMSmQRshr+mAl1cDdlqpU0Txoh+eRxfm022hFUwz5t1q7PYMJ9sSJ0GOc8D4qq/S7qNlczoV/jk67pVPQohx1zV1bv+bVWETI3RucMqV+ODm7XmKaHCKPSEMOmbVqhOP3NI93fhjgDpjpnuWVXVFNSWaxdyPZWwXuB9nCHo94n8NOT/s2g9/eV4jyzlz7zFoyq/c8czs+GeulG/7tr211QYUQG1ELQd9tlrJBnE5xV3EUpoHSAf8t0fMQSliA/16rBi1EA==
Received: from [192.168.0.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id d15-20020adfe88f000000b0033ae50e2c6asm7706512wrm.83.2024.02.05.01.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:54:07 -0800 (PST)
Message-ID: <03f335d6-80ed-4dfd-9bc7-c959431c7420@linaro.org>
Date: Mon, 5 Feb 2024 11:54:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/28] spi: s3c64xx: retrieve the FIFO size from the
 device tree
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Linux-Arch
 <linux-arch@vger.kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Peter Griffin <peter.griffin@linaro.org>,
 kernel-team@android.com, William McVicker <willmcvicker@google.com>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-24-tudor.ambarus@linaro.org>
 <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
 <CAPLW+4kTUmG=uPQadJC5pyfDvydvr1dKnJY6UxQva2Ch-x7v3g@mail.gmail.com>
 <e4b76c3d-f710-4b32-aa30-23cb54346d15@app.fastmail.com>
 <CAPLW+4mQ=q1c061Zv=dxnHwMJtjH5sbQsvg25x5uzxL3UCAuTA@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4mQ=q1c061Zv=dxnHwMJtjH5sbQsvg25x5uzxL3UCAuTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26.01.2024 22:20, Sam Protsenko wrote:
> On Fri, Jan 26, 2024 at 2:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Fri, Jan 26, 2024, at 20:23, Sam Protsenko wrote:
>>> On Thu, Jan 25, 2024 at 11:33 AM Mark Brown <broonie@kernel.org> wrote:
>>>>
>>>> On Thu, Jan 25, 2024 at 02:50:01PM +0000, Tudor Ambarus wrote:
>>>>
>>>>> Allow SoCs that have multiple instances of the SPI IP with different
>>>>> FIFO sizes to specify their FIFO size via the "samsung,spi-fifosize"
>>>>> device tree property. With this we can break the dependency between the
>>>>> SPI alias, the fifo_lvl_mask and the FIFO size.
>>>>
>>>> OK, so we do actually have SoCs with multiple instances of the IP with
>>>> different FIFO depths (and who knows what else other differences)?
>>>
>>> I think that's why we can see .fifo_lvl_mask[] with different values
>>> for different IP instances. For example, ExynosAutoV9 has this (in
>>> upstream driver, yes):
>>>
>>>     .fifo_lvl_mask = { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff,
>>> 0x7f, 0x7f, 0x7f, 0x7f, 0x7f},
>>>
>>
>> That sounds like the same bug as in the serial port driver,
>> by assuming that the alias values in the devicetree have
>> a particular meaning in identifying instances. This immediately
>> breaks when there is a dtb file that does not use the same
>> alias values, e.g. because it only needs some of the SPI
>> ports.
>>
> 
> Exactly. I guess that's exactly what Tudor mentioned in his commit
> message, and he's trying to fix that very problem by relying on
> corresponding dts property (in his patch series) rather than on
> .fifo_lvl_mask.
> 

Yes, all from above are correct. I'll split the FIFO size patches into a
smaller series to be easier to review.

Cheers,
ta

