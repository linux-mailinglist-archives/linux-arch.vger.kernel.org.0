Return-Path: <linux-arch+bounces-895-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B867380D0EE
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 17:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E0B2823F3
	for <lists+linux-arch@lfdr.de>; Mon, 11 Dec 2023 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534134C62D;
	Mon, 11 Dec 2023 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QhHAruhH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D89199
	for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 08:16:16 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67ab5e015aaso30775646d6.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Dec 2023 08:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702311375; x=1702916175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9O17D9j4YT4XtoaSYd3/nhs4s1HCIt9uZx1EA+AxCks=;
        b=QhHAruhHDJwS1YqCWWOQjZe6vFaNZl9vgrCfr2rLk9334kqkidfz2I6xFi2MqCplRK
         HsRzepNc+fum+8+RIuauotY7cHATmK/eMKsnfV8ms2fP6nSNVCqcFUC7zmC/Nkm9ZwWW
         f0ZiLblbVR982iaPGxCRzOj8zDxoJ4o+hU+HdQ5znBuUlKgjWrSAaeO+z8su6MlRihKc
         keIHTLn2X4M+dJx5N5IkONalQ9m0AUtZJWKh8W8zBfA9PSke2nihsWQl1/fH2SRMuHg1
         P4W4zt4SWofkbaBfwPZsvWksGts4NRS9buQk1JL+imD4BcQ33oW2Cj5/lepwoN1nia0g
         ZABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311375; x=1702916175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9O17D9j4YT4XtoaSYd3/nhs4s1HCIt9uZx1EA+AxCks=;
        b=TIyKHFZFpqgknc6VLHrWOAegO8r2ue5EYBnXE4/EPCJ6qqb3+U1FI7imJzbFHe14Rp
         RWQlHgL5SyPdeWTt6k8G4u0CVgd7jn00x9/LdFjfKpghXq54J8l78dDPnEmpn5/YJKD7
         VKqaYLX4St5Ws1j6jmCKUjzCbNQartWQ/wgqfrhs59LpOeBnEl/etNTI2uFr4uovNdLV
         ceYfOByuZgphtz+Be2pYbNuDG0yaflu13oJf7Df/KsI7yfmMVz8cGFfV5wxMSXQP24mQ
         yHYHfBCT+suLA6Il8LovcZucegaRAb83aIF+Y6+1GOt4++7nBLFUMcV1rzZgeKIeIZgA
         vZ3A==
X-Gm-Message-State: AOJu0YyAE8b//l9qvIBCB4d4uSGIYKy4k4cMoURGiN+JVL5UcILycJyb
	fSY4KBA6Yh8FqNPXgdllOBl3Vw==
X-Google-Smtp-Source: AGHT+IHy4FKXKcoa5vr1zWRR7h8ldItNotN+bq27os2Gmy1WmTZV3fGNzyOi2gfObdJOXzxcGBLOzA==
X-Received: by 2002:a05:6214:1fd9:b0:67e:b878:8e48 with SMTP id jh25-20020a0562141fd900b0067eb8788e48mr4904522qvb.39.1702311375258;
        Mon, 11 Dec 2023 08:16:15 -0800 (PST)
Received: from ?IPV6:2600:1700:2000:b002:f8a3:26ec:ac85:392e? ([2600:1700:2000:b002:f8a3:26ec:ac85:392e])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cf6d1000000b0067a18167533sm3380983qvo.83.2023.12.11.08.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:16:15 -0800 (PST)
Message-ID: <3f28c1f7-f29c-461f-a90e-58d8e0996cc0@sifive.com>
Date: Mon, 11 Dec 2023 10:16:14 -0600
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/12] riscv: Add support for kernel-mode FPU
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-10-samuel.holland@sifive.com>
 <ZXc0rAdi7Vo8nbS8@infradead.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <ZXc0rAdi7Vo8nbS8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-11 10:11 AM, Christoph Hellwig wrote:
>> +#ifdef __riscv_f
>> +
>> +#define kernel_fpu_begin() \
>> +	static_assert(false, "floating-point code must use a separate translation unit")
>> +#define kernel_fpu_end() kernel_fpu_begin()
>> +
>> +#else
>> +
>> +void kernel_fpu_begin(void);
>> +void kernel_fpu_end(void);
>> +
>> +#endif
> 
> I'll assume this is related to trick that places code in a separate
> translation unit, but I fail to understand it.  Can you add a comment
> explaining it?

Yes, I can add a comment. Here, __riscv_f refers to RISC-V's F extension for
single-precision floating point, which is enabled by CC_FLAGS_FPU.


