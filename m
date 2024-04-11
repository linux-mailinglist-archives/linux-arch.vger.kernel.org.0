Return-Path: <linux-arch+bounces-3554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D28A057D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 03:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356241F22C8C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 01:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9B0612D3;
	Thu, 11 Apr 2024 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKkv38HO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E076960B9D
	for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2024 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798877; cv=none; b=VBiSvplXXywe+bTqZrUnxdSS3E5RKusXznVlBfO9w0sYFeWZ7vihEVN2F95e0MJxNXCTlVbA79m9IOY+MWQt3167E8RfcOOsTNTWppDnuS5pqgc1NrEP8jLxd76wr0q7LINQLt0LO0YjyAKGBoNUnaYnePoejyiDyd/yE70KrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798877; c=relaxed/simple;
	bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFnO2xfY1GlwErcPHH5bjjPMAc4V8r5oPhYxf76DQIwJgvBfsY73xHKHU1SEklCGuz8RGPwhPMn6BtnDxsxcJ7ZcNwUojJkflmZP+x0A2TkCTJq2nssFtPKSUl3fe9TK2ogJva/FMIxKMdV6oFXkkikYLJNEc8pkDBHXtbMuH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LKkv38HO; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2330f85c2ebso752645fac.1
        for <linux-arch@vger.kernel.org>; Wed, 10 Apr 2024 18:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712798875; x=1713403675; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
        b=LKkv38HODTb7tDoqSW7ZCIK/QIRsuMQ9wf+dwQ30x4ZBho8y9efrp9yM/PjWM3ErC+
         fXD340D/fTjXt/riFHYr4ektQKre0gAPXLQ3DrwS/FDP/mntefcL7GiPcoZI3ZW/X7ER
         QESXKnJHie7YzUyiuykysAsz4/uYZIMMSWA8wPrXKlh6Qy5yGk8Oox2vJU6FL3jWrbMb
         brM4ED9ofH9Oj5IhMJPbXJJqTHQzRu9bQFrD65cGYAJAOh4T/9cpUGudUlOsMnrTkyO4
         l25xuXKUVY+T02d8Vza+IMYylD+TCRb1I279Ca/rzY/rP05249yuJnRZEDoIqtvmsh6k
         u+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712798875; x=1713403675;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY1vBuYzXUVAUPu7RYDaF9UtFORvIFjy44r4Y5Ige4g=;
        b=p7T6BM5X4mzIiqDX6yHNgwjL4xDL93zbyDTm1vGKpo9GvO+tsH5iHU+B2MLAMwUcr6
         ljI9k3XJdLR0IHeshZTeEwvaMHI5/b7iG12gl2LgKjnTvKpq5COxu9Ers3jh9fAzBzJs
         nmUV07s26X85uq+uMJIQz0C8ie2zOyLDAHn9xFex4VEqHXaRg1POXx1xolMhyEZpt/42
         d653WumNoKbEG7i+l2ElmBZCU9ofmV10yqffeONdCpkn8Pnd8i7sLcLf8cpIdq1SHuXr
         JJluVdc+Kr6sLV405iTpYIep150w6RmSKRglBM42y6H0QrgvdDVxhurFkAXVtWutqJy8
         zFhg==
X-Forwarded-Encrypted: i=1; AJvYcCXW/NpICUs5NShI7BTlZ9HflWptNz977Uer0GMJYJLNXRo2nn4Jn8RQ4j3N8cdPNyxTScFLmaLkw9OQHHGp8dFZXWwkI/C53Yexkg==
X-Gm-Message-State: AOJu0YwNm1XH4eNy1tJ+V2TOpTAI8hLSHQenoswSclqClXp/SU6S6OGj
	ZDRFEuHH7OYyOseTICh3DL5lM6wbeHgmbrfcMBassV5ES/Xs1FnQ2pdCSowF35w=
X-Google-Smtp-Source: AGHT+IF8lPPFTalL1WPSfnBvduuYhf5K6F9EIeC9RLCCka0Vl/mHkW4wRauCXJubFXwb7faJCr3ffA==
X-Received: by 2002:a05:6870:518:b0:22e:bcfd:deb0 with SMTP id j24-20020a056870051800b0022ebcfddeb0mr4667832oao.41.1712798874921;
        Wed, 10 Apr 2024 18:27:54 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:8470:fcac:9b42:fe81:c62f])
        by smtp.gmail.com with ESMTPSA id c1-20020aa78c01000000b006ed38291aebsm289791pfd.178.2024.04.10.18.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 18:27:54 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-arm-kernel@lists.infradead.org,  x86@kernel.org,
  linux-kernel@vger.kernel.org,  linux-arch@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-riscv@lists.infradead.org,
  Christoph Hellwig <hch@lst.de>,  loongarch@lists.linux.dev,
  amd-gfx@lists.freedesktop.org,  Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
In-Reply-To: <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com> (Samuel
	Holland's message of "Wed, 10 Apr 2024 20:11:04 -0500")
References: <20240329072441.591471-1-samuel.holland@sifive.com>
	<20240329072441.591471-14-samuel.holland@sifive.com>
	<87wmp4oo3y.fsf@linaro.org>
	<75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
	<87wmp4ogoe.fsf@linaro.org>
	<4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
User-Agent: mu4e 1.12.2; emacs 29.3
Date: Wed, 10 Apr 2024 22:27:52 -0300
Message-ID: <87le5kofhj.fsf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello Samuel,

Samuel Holland <samuel.holland@sifive.com> writes:

> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
>> Samuel Holland <samuel.holland@sifive.com> writes:
>>> On 2024-04-10 5:21 PM, Thiago Jung Bauermann wrote:
>>>>
>>>> Unfortunately this patch causes build failures on arm with allyesconfig
>>>> and allmodconfig. Tested with next-20240410.
>>
>> <snip>
>>
>>> In both cases, the issue is that the toolchain requires runtime support to
>>> convert between `unsigned long long` and `double`, even when hardware FP is
>>> enabled. There was some past discussion about GCC inlining some of these
>>> conversions[1], but that did not get implemented.
>>
>> Thank you for the explanation and the bugzilla reference. I added a
>> comment there mentioning that the problem came up again with this patch
>> series.
>>
>>> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
>>> 32-bit arm until we can provide these runtime library functions.
>>
>> Does this mean that patch 2 in this series:
>>
>> [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>>
>> will be dropped?
>
> No, because later patches in the series (3, 6) depend on the definition of
> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
> find a GPL-2 compatible implementation of the runtime library functions.

Ok, thank you for clarifying.

Andrew Pinski just responded on the GCC bugzilla and if I understood his
point correctly, it seems to be a matter of changing function names to
what GCC (or actually the arm EABI) expects...

--
Thiago

