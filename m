Return-Path: <linux-arch+bounces-14949-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65826C70190
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C380504656
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E533342146;
	Wed, 19 Nov 2025 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVj410F2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91099350288
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569197; cv=none; b=ZY+YJOSpNwwCy3ZtUD26i9hDI1bQUsfI8AxBHN1PRoPFdul46AsyjWtaJM+XCRszfPeL63rtumM/LoHel7YkqfxRPq9nmhQ1XozslPz7wEerVtd4hpXZlIct5m94yXbekGmLs8Io70/8JFPJksgz8VHm+d3nYs2iE0bEHRch+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569197; c=relaxed/simple;
	bh=PytOZzTAioEaMxmqRTBvSzOZkl5VeEfXc7Gpm4o827k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQtcNfVpyyKrITCFeqg1qItnt9ooPH/7qIYvSHQ/fpL/VQVnxeSe2lkrZ1emhcwe8Ru2OCbIqxhfKsEFuP6X2W+Hol2NZG85gZSxnJJvz0GKIlh/fbgj1ixSECZkZbIcGfjSDmrKRtoiZK39PPeIRmJKlfYIjJcvNyNHMEmyGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVj410F2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso35409875e9.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763569194; x=1764173994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+urd6hZuWEo3shlMiSBaDb8+AZAhwgeZeQG9S0pL0o=;
        b=vVj410F2JGATilDsa/pV64I8vu/EgjtpauMLcfnve5aDLDLRggiGgiczAPhvKEsC3Y
         qDXsmY8b9iE9k44HdeH59Jd2iOHcE1IcK3uUkBTJkxhk6m6NM0KNPb65EnIabplC90n8
         znvjFs7XksNK3svNPrMQSSegOuGUh/I1vO0SoAHjRqxL9HT9lvLY3hwDEEms+v9mRy65
         rD9IwyKRZ1XlMnj2ridWYuAnQdQTbSzA+VwbLOkDTMX8sr25aBhbSUh9nXF4lBNrB9B7
         jLk/pygSgSJgEGj/qc4Lv0tZgfFZ+G/VsG8Ozxc/uEw4L4ygGFz0ftuuPGtRmO4n4LIz
         SQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569194; x=1764173994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+urd6hZuWEo3shlMiSBaDb8+AZAhwgeZeQG9S0pL0o=;
        b=eYywqeULmStPZE/J9UWBWFHqgRlbNQyBmVf/RoSuGCpuHzKmVtgr31e3IXCcz6Cq2/
         3pEc55SfDCfGp0+3v9PyIgL9LrWTIFbfVdBe7oLiksFeFEqXjMY7u0QfVp/QwlWmBgsx
         RAoRAh+i2TlAm878xbP8xbTtgn35hi0jfoqXIXQFvc901x76WNcNtDGPbeaVndxRuzMM
         2gGMHOafLgT8TK9tmxfN1OrHxhDxUanZxVojAVPoQCmBocSLMAFV0GGX5ncDkqw2VLL+
         Kallhb8Eh1PDn+8THNF/osPheyd+U0e4Z9WYlZGH4AcTUPaiqTfcLaWE7FxJFM42OmiV
         yXIg==
X-Forwarded-Encrypted: i=1; AJvYcCWDpBlkBGtpyrxEy/BSdIOZ0Lm2WsYW4iTJTi5HwousPApsrKEk1VWF2h+gMRcVsO9KV3mw0OLL+7X6@vger.kernel.org
X-Gm-Message-State: AOJu0YwaEs+xqwn8TEtKzfwA2ZqeWPFi2ZLh/2Fl9lAy52LcuVgm7KMu
	X3mm/hUfXVVhVctwhOBiFwJ8++wh+ZY6PYrpb05DrFBEff4GHIGlRDSjUKn95NZztjs=
X-Gm-Gg: ASbGncuGbK6jwOP/UZIfOuRCvMtM8MfTE03T1YC1Lan7DPwYQL4YOo2ujuGtraDvPjp
	KHGMrZz2pR5cQ97Yh9c4e3OIcSkpS3T2qzbF31hVRG+cHADJABCr+OCoFUWK8PyikMPmdiupBOm
	xJ8/VcIDYbJBgvgC12nh/Npw39BpA8mMwW1Vd/yf/gvCEYQH5Aq+oltFJ3bWm34hUEPCVKIRb7E
	TZYVosQ78r2am7x8Nx8kZcJ4fg1RCQBLmiq1OlVapFeohTTLkCbh2sZ0Qk+skV8XAN8ubBsQJhE
	XIdZ/ofVcqNo9F5uU4+QmKBvSC5udpyV2Hr3fq8PvyLhNdkLD4MsbIw3Yo5Zgl60KdYyxxwLmpx
	qkeLuen0Vgzdve8gXm+FqY9RtDlUloY5zoZbaJVkkXl7UgQzE1iu9A394aLSd8+6gGT2d3Yu9jY
	jx4sOkYZ16mDK/+eqnfWxkl+o8P+4A
X-Google-Smtp-Source: AGHT+IFwK5aAXHXIDIc3E2JseMPHhoLC/8O7sdHZVlYBJKdiPiGNYDVrkfdVj41qV4fzGcHy4cnIEg==
X-Received: by 2002:a05:600c:4513:b0:477:2f7c:314f with SMTP id 5b1f17b1804b1-4778fe5c820mr231183085e9.10.1763569190918;
        Wed, 19 Nov 2025 08:19:50 -0800 (PST)
Received: from [192.168.0.39] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffc90fsm61424875e9.2.2025.11.19.08.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 08:19:50 -0800 (PST)
Message-ID: <060e7412-8f1f-4d31-af39-79213c560e85@linaro.org>
Date: Wed, 19 Nov 2025 18:19:48 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/26] dt-bindings: reserved-memory: Add Google Kinfo
 Pixel reserved memory
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
 corbet@lwn.net, david@redhat.com, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-26-eugen.hristev@linaro.org>
 <e73bdb23-c27b-4a18-b7e3-942f2d40b726@kernel.org>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <e73bdb23-c27b-4a18-b7e3-942f2d40b726@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 18:02, Krzysztof Kozlowski wrote:
> On 19/11/2025 16:44, Eugen Hristev wrote:
>> Add documentation for Google Kinfo Pixel reserved memory area.
> 
> Above and commit msg describe something completely else than binding. In
> the binding you described kinfo Linux driver, above you suggest this is
> some sort of reserved memory.
> 
>>
>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>> ---
>>  .../reserved-memory/google,kinfo.yaml         | 49 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 ++
>>  2 files changed, 54 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>> new file mode 100644
>> index 000000000000..12d0b2815c02
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reserved-memory/google,kinfo.yaml#
> 
> Filename based on the compatible.
> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Google Pixel Kinfo reserved memory
>> +
>> +maintainers:
>> +  - Eugen Hristev <eugen.hristev@linaro.org>
>> +
>> +description:
>> +  This binding describes the Google Pixel Kinfo reserved memory, a region
> 
> Don't use "This binding", but please describe here hardware.
> 
>> +  of reserved-memory used to store data for firmware/bootloader on the Pixel
>> +  platform. The data stored is debugging information on the running kernel.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: google,kinfo
>> +
>> +  memory-region:
>> +    maxItems: 1
>> +    description: Reference to the reserved-memory for the data
> 
> This does not match description. Unfortunately it looks like you added a
> node just to instantiate Linux driver and this is not allowed.
> 
> If this was some special reserved memory region, then it would be part
> of reserved memory bindings - see reserved-memory directory.

I sent this patch for reserved-memory directory, where all the
reserved-memory bindings reside. Or maybe I do not understand your
comment ?>
> Compatible suggests that it is purely Linux driver, so another hint.

This reserved memory area is used by both Linux and firmware. Linux
stores some information into this reserved memory to be used by the
firmware/bootloader in some specific scenarios (e.g. crash or recovery
situations)
As the firmware reserves this memory for this specific purpose, it is
natural to inform Linux that the memory should not be used by another
purpose, but by the purpose it was reserved for.
Which would be the best way to have Linux understand where is this
memory area so it could be handled?


> 
> Looks like this is a SoC specific thing, so maybe this should be folded
> in some of the soc drivers.
> 
Not really soc specific. Any soc who implements this at firmware level
can use it. The firmware can reserve some memory for this specific
purpose and then pass it to Linux, so Linux can fill it up.
It just happens that the Pixel phone has this implemented right now, but
it is not constrained to Pixel only.

Instantiating this driver with a call like platform_device_register_data
would make the driver unaware of where exactly the firmware looks for
the data. This is right now passed through the DT node. Do you have a
better suggestion on how to pass it ?

> 
> 
>> +
>> +required:
>> +  - compatible
>> +  - memory-region
>> +
>> +additionalProperties: true
>> +
>> +examples:
>> +  - |
>> +    reserved-memory {
>> +      #address-cells = <1>;
>> +      #size-cells = <1>;
>> +      ranges;
>> +
>> +      kinfo_region: smem@fa00000 {
>> +          reg = <0xfa00000 0x1000>;
>> +          no-map;
>> +      };
>> +    };
> 
> Anyway, drop, not relevant.
> 
> 
>> +
>> +    debug-kinfo {
>> +        compatible = "google,debug-kinfo";
> 
> Device node with only one phandle to reserved memory region is a proof
> it is not a real device.
> 
> Also,
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument, so you will
> not CC people just because they made one commit years ago). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.
> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
Thanks for your review and suggestions

> 
> Best regards,
> Krzysztof
> 


