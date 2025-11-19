Return-Path: <linux-arch+bounces-14959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4535CC70A68
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5314E4D4C
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B640314D22;
	Wed, 19 Nov 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHB56gLK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C703009CB
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763576680; cv=none; b=WqDx55P6Y6QUqivxeyuS8mXJpCH7er2H7U5yJPU0Ntxg9AKNvHLm14sfDL2H33PrvVQN79Rvs2QgKeIsoF3exO9O3hGJ3IMCeyS8KIaSSA98IYS8Hnn5ud7pHOSfq0mSjI85EJycaBuEh4Faz5jz9d6PdyeVP2fDlH+jgKT+S9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763576680; c=relaxed/simple;
	bh=d2VKNeBI9mdU3CulQqLDBXeD89R8ghbqwp0xbHbIKDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Haa4N62qbKA3T2ISvTYafpPJPgwkpswZb6eGR/01r+UBpmsbbXSW2FzqcX4amJxWIj28Ot2Woy4HtjS9kcEuN/HAQwuUUxyCv5qwl7r6vwafQsTBEUZALvtDe1Gvp2gexBbWXguiqnBKTQxAGcB2IbL15vS/1o+xG996OVYfMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NHB56gLK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so2776058a12.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763576666; x=1764181466; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wXp2uUfyAn7qQSV84bcf4nMWFAwyWFqJON+TttJbAcU=;
        b=NHB56gLKbXdEvERiIKxyKRzQy9x+BRJO0FalV2vWqUvsDwCie6WhACfrN9e36qHhJG
         OGpSc25nBLdINljnrtbcWaXr3kHm5dxGf0IyXFcfK4WZma60ovr/3E0doiG8m5vj643e
         mriYNHJ2bsjrcqiN2uO/CUNNlORYDELZ3r1mrN1g7c6GkCoiTvSnWQKAj3EjRL5lIGCG
         oRlG5Q/VRcCNsBAAfLsApgXoxbL9PG3ka/MMCPIVWRWXSJjbGggV6lyCKu/VgSv0dZKK
         25bBFCR+Uj3S5mAGC6qgXTaRuKtSvSx5Hs/MYXahRdJSseagBo7onsRf697vqSx8U4+u
         eBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763576666; x=1764181466;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXp2uUfyAn7qQSV84bcf4nMWFAwyWFqJON+TttJbAcU=;
        b=fOtXypO/pvBXMt/8S0JZMWwAkI4Jy5XakuRATTEhGaK5CNgIa0I2YqjDjLeSnnxcr1
         qs1Ko9wx+zhYGiXF1JJfSKBUYqVmL4ZDM6Ocj2DLfe36q3DOHdpiL1SkjPfT4p+oqUd5
         +DsS/ZmzrIK2LjNSUEVrAQ9i8140nsF7v2RnApgLnXJQ0ysy0/4xxPW6jTaMUEXkQ+K2
         RB6lLIsKCCNTVD47Zt4BBM2oUykPASAqoFU2wt6Dncy3Z/K967Hxzn5Fd/v3pwGRE05r
         Im82yCzaqt6E4otb5pQVLG6tw1A8F4KjAEGj5XB9A8slNadqYpz5kpFAl4dJ4FUTmOtA
         aMpA==
X-Forwarded-Encrypted: i=1; AJvYcCXdI43EDyXlLdH9dEFQctkyZnsdU7ZOIK5LpsHyabYTDAEuikQb4oxCdd27tLqxKyhdcP8gwTHkFx1b@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9fcF1DS3zceXnBDkeNXW9CQ42biy+r4rc4ZI07/YRzoG2m9U
	hdQ9lT+YerSviBpqPQknGg+6Dd4nbgl1a8R1rOiurSFkCiC3VH/LyV9eLLVptSt87YI=
X-Gm-Gg: ASbGncvGKHRPb7X+CRHpBNRqe1DFBo79orNafGh1dmxJ2LpxR6PyY4L0KiXQJVJZ6cY
	A+gzK/hJbaoeDUSWLcqjhD7KmEPBWC2OKO6r8ZvqhEnBlI0grclA6CRvDp034uFzg3uCVYE1FNv
	XIAR9B5jZhDfIsky9aC80TYGcPMlsImfnHorBUIzmy5Cb6sgJV+Log2H6DRqdYBl5lpBwVSQYVJ
	bWGKSDGa6LvKgoN5tmJoz0/L+tPTGPonUYAFfEsvxIT25lHkXaBNsaG/dn5AO+f0UEcGsNUEIa9
	YXkiCnGoWuHL9ovsFxSdlP2qN3m3rrlwC22vQPdrbCURdyPGZVLiLlE9pnouSkiCRdElePCMLsJ
	1nf/0PIBcOpX5N1r6Y6icuy5nMw7HhrpJboklT5AriWl66VpTrFISgb5NwyLg+8HZ+4pc+VdnXy
	BgmRUwPoJfDJspsgn0NJ+W0PHmGtDlhIw=
X-Google-Smtp-Source: AGHT+IHFWcpqhe+aEp30Ksls0LghzQFo1sGYaD1WHh6eJAE08Lx/+/aqM6jp4/gMRRi4U1LtQQLFuQ==
X-Received: by 2002:a05:6402:5247:b0:643:129f:9d8e with SMTP id 4fb4d7f45d1cf-645363e41d7mr312140a12.8.1763576665944;
        Wed, 19 Nov 2025 10:24:25 -0800 (PST)
Received: from [10.101.2.140] ([93.122.165.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b66e5sm169342a12.14.2025.11.19.10.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 10:24:25 -0800 (PST)
Message-ID: <b0102b82-9ae8-4e01-ba27-44b78b710fca@linaro.org>
Date: Wed, 19 Nov 2025 20:24:23 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Introduce meminspect
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com, tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-arch@vger.kernel.org,
 tony.luck@intel.com, kees@kernel.org
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119131534.392277e3@gandalf.local.home>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251119131534.392277e3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Steven,

On 11/19/25 20:15, Steven Rostedt wrote:
> On Wed, 19 Nov 2025 17:44:01 +0200
> Eugen Hristev <eugen.hristev@linaro.org> wrote:
> 
>> Once you have all the files simply use `cat` to put them all together,
>> in the order of the indexes.
>> For my kernel config and setup, here is my cat command : (you can use a script
>> or something, I haven't done that so far):
> 
> Interesting.  Hmm, it seems this could be used with the persistent ring
> buffer code as well. But if the firmware does not keep the memory around on
> reboot (where the buffer would be reloaded), you could mark the persistent
> ring buffer's memory to be inspected.

I was kinda hoping I could get a chance to talk to you about this.

I managed to mark the trace buffer for inspection. By using the cmd line
argument to have it preallocated, it was very easy to just mark it for
inspection and dump it on a crash, as a dedicated meminspect region.

> 
> The persistent ring buffer creates a single allocation to hold all per-cpu
> memory in a single region. That is, because on a crash and reboot, it
> expects that memory to be at the same location and does a verification
> check to see if it contains a valid buffer. If it does, it will recreate it
> for view in the instance directory of choice.
> 
> Now if this same range is marked for inspection, you could then download
> the entire contents of the persistent ring buffer after a crash. It would
> be trivial to update trace-cmd's restore functionality to rebuild a
> trace.dat file from it. It would require saving the event formats of the
> running kernel before the crash, but that's not hard to do.

The problem is that all the meta-data is not allocated inside the
preallocated buffer. The meta-data is kmalloced all around the code. I
mean the structs that hold the information on what's in the buffer. You
know what I mean.
And all these kmalloced things, turn out to be in order of hundreds just
on a kernel boot, which I tested. This is not feasible for the
meminspect table, as it would get overcrowded very easily.
I thought of perhaps trying to kmalloc all of them in a dedicated cache,
but I haven't progressed on that. Another idea would be to try to
recreate the meta, but I have not found a way to do it yet.>
> That is, by using the persistent ring buffer code with the meminspect, if
> the firmware doesn't save the memory across reboots but allows you to dump
> it to disk, you can enable tracing within the persistent ring buffer, on
> crash, extract the buffer, and then use trace-cmd to rebuild a trace.dat
> file that you can now inspect, and see the trace that lead up to the crash.
I used 'crash' tool with trace plugin and I am able to see all the trace
contents, but, with the limitation above. (To achieve this, I dumped a
huge area to include it, so , not feasible for my goal )

> 
> Now I don't have any hardware that uses this feature (not that I know of),
> but if others find this useful, I would most definitely help them implement
> it.

We could have some drivers pass the inspection table and then store it
in ramoops e.g., tapping into pstore. This idea has been going around,
but I have not had the chance to write a pstore thing yet.

So , I was stuck, and I was hoping to talk to you, either by email or
maybe at Plumbers in Tokyo where I have a talk about meminspect.

Thanks for looking into it,
Eugen

> 
> -- Steve


