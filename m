Return-Path: <linux-arch+bounces-15895-lists+linux-arch=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-arch@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCjDGBy6b2kOMQAAu9opvQ
	(envelope-from <linux-arch+bounces-15895-lists+linux-arch=lfdr.de@vger.kernel.org>)
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 18:23:40 +0100
X-Original-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EC2487D2
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C5787CCCEF
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 15:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662EC47D953;
	Tue, 20 Jan 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bR3/T7zd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C445BD60
	for <linux-arch@vger.kernel.org>; Tue, 20 Jan 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922035; cv=none; b=sGhLWYo/4WUYxd4h3TrohU44mwqa3SthqU7dPaeHBsU6NhfNnqyBuv7ZyWNIRvSZu9xyMm3JWf76nWoAKFEby0XtFvIslKwNxST1LCu6SkMoYWC20wituyzhlKLsbi/utaiqU5jb9TJChf8AsQJIOtjhjayTcklzTnVFwL7UnXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922035; c=relaxed/simple;
	bh=tTdNJ9w0A3SRS2jGZyO87hh6ddJ8/yTI7BHcKalWjPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0aQkNfheVSOSp9+cI3gpHteHd0qI05Ew1zvk9RlO0kd7Y7Ir2jo8Ox5hbL3jOMXO8yv1sKzLW8gjoakH1GdecVGG13Jr0zxnLuiVOtpjBqopItuF5EvQMlB/uK9zKN+zimhJAxvKR4Zgv+ohf8ANuPW5Eqrmiep0JC2YdpVwbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bR3/T7zd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso32848135e9.1
        for <linux-arch@vger.kernel.org>; Tue, 20 Jan 2026 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768922031; x=1769526831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KfHF8XX2sLoiWwn6mh6WL+QXvB0XHx4J/lS+4r+T224=;
        b=bR3/T7zdFsQ79orClB/OtuJkhWjteFZ0ldd6bNXwgN6fisE5qcOQgkjwxTZFoHHc5y
         7yOyZDtZSZaDTS8ifjUmEfV9CoS4RA0mOQRRHhOX37mQc5i2WUhVK/u4Fj0WEq244H2m
         EL8NGU7vTFgO0C5cgmMINHG7iQ82UZZYrBQhBcFL3LFsiYgUncQGXA/w0u1AqIGJk6WN
         JM0QyEhH/TdLoVc9N/tGqY0ahOhJLCkixGa08RxflOIfnO2f/B+6aHagRzCQwLkG22Bf
         QqDk0s97FGVeslJMAlK5OHWLIEqY2BEyQ63ZNs6fO3Us9xRwOe7ylg8LmnX5TJqPW7qe
         UMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922031; x=1769526831;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfHF8XX2sLoiWwn6mh6WL+QXvB0XHx4J/lS+4r+T224=;
        b=jp5HnNIKBWB/NhkSJ7N9H+DU4ZcVicMyKk1Yha/f2JMEGDrbZlQsuyhAjwhaf0c1jt
         3iZ2VejP+T7y4NR6hZAlFXLvIwu8Xc5YXx//WmZDZOFf6OxLD0K2XsLLHi9rl03dnQYt
         T5JSg0FJaMS9OTbMabNDqm3JYeHHpQJl8RU2/NZ/GCnfI6qDzzWmCePIROYUhQrOH9M/
         kyfK+D0pG7dzt8y+NUuFg4whfMYZWKoEph3H47HtDLY149Ad1VAfhMtK9YxSTdkg2vTL
         iqen023Fu3yF2/vhiEh/AX2LLdV5dLq9TvbWXdFZvWUFIqtcGvXiFSUB7o9Ki0Fjn6O5
         m/gA==
X-Forwarded-Encrypted: i=1; AJvYcCW5TqqTbGEtJnGFgyabOzq34IBxP5w51OZ9bVQEgurPlMMzi6Fcv07zl++y9QMu6nxgGv5V6aM7nslL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxld8cWJAoAgQ+gRaCjPNPRrQUvUv/Mi2lVa428I2e1zJwxYwbJ
	6rc49whWAoNRgEeluh/8x4/+42p+hAFwebME71+zI4YG66PtvAR55BB4EiBfSaFF8pY=
X-Gm-Gg: AY/fxX7fzE46lAVKFGlX6rhfdCqzO5nfqAPtEyjSmQjxgZPvMejSr9nG/qRgZC74JDb
	xXC5GPu970bkzufgNgI5MUvgm9D8w9F9xJADYr+UFPsLVe0j82kKwbiGdi8Jrx/b2+s4X8Vvcmo
	hRhuX2NSuY4TIX134uApBwdZNWpHfFTK2yXUTRc852DlXBzkzvAVgOye6umcXc54y/CXeLu7w2B
	iZ9LGKu4ozRMpexfsVIVeLqDwT+N7mIxywmK9pfT4U7LdHlI4eBi1R4nSUS3u63pAGsaf95GLrK
	wzP3gY2uLNhaaq+hIiqdWQy8ZAUvjIx9t+3MYiV2+wG3tOm9Tx5NrEq8jDf/ghH/AscL+68wCWH
	G4U1AS79TOIIYJu/Ci3Ytl5aAbhrxm/fp582vOrlU0SN9BvBvqgGfksJmm2sYBgBPBH2VZ6Em/+
	zyLEeO8oZ6QvG/bATA3zFh7wIu7lQKnmQ=
X-Received: by 2002:a05:600c:458d:b0:47d:264e:b435 with SMTP id 5b1f17b1804b1-4801e34209cmr173700875e9.22.1768922030743;
        Tue, 20 Jan 2026 07:13:50 -0800 (PST)
Received: from [192.168.1.221] ([94.202.56.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9ee5c3sm113053335e9.2.2026.01.20.07.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 07:13:50 -0800 (PST)
Message-ID: <ae85df64-b6b7-43d7-ba50-9c0525481299@linaro.org>
Date: Tue, 20 Jan 2026 17:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/26] mm/memblock: Add MEMBLOCK_INSPECT flag
To: Mike Rapoport <rppt@kernel.org>, david@redhat.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, mhocko@suse.com,
 tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-19-eugen.hristev@linaro.org>
 <aVImIneFgOngYdSn@kernel.org>
 <4b8953ac-567b-4d68-9c25-72a69afdf1b3@linaro.org>
 <aVlsqdgXSBLIE9Xi@kernel.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <aVlsqdgXSBLIE9Xi@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-15895-lists,linux-arch=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eugen.hristev@linaro.org,linux-arch@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-arch];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linaro.org:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 07EC2487D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 1/3/26 21:23, Mike Rapoport wrote:
> On Sat, Jan 03, 2026 at 08:36:40AM +0200, Eugen Hristev wrote:
>>
>>
>> On 12/29/25 08:56, Mike Rapoport wrote:
>>> Hi Eugen,
>>>
>>> On Wed, Nov 19, 2025 at 05:44:19PM +0200, Eugen Hristev wrote:
>>>> This memblock flag indicates that a specific block is registered
>>>> into an inspection table.
>>>> The block can be marked for inspection using memblock_mark_inspect()
>>>> and cleared with memblock_clear_inspect()
>>>
>>> Can you explain why memblock should treat memory registered for inspection
>>> differently?
>>
>> It should not, at a first glance.
>>
>> The purpose of the flag is to let memblock be aware of it.
>> The flag is there to have a "memblock way" of registering the memory,
>> which inside memblock , it can translate to a meminspect way of
>> registering the memory. It's just an extra layer on top of meminspect.
>> With this, it would be avoided to call meminspect all over the places it
>> would be required, but rather use the memblock API.
> 
> memblock APIs are not available after boot on many architectures, most
> notable being x86.
> 
> But regardless, I can't say I understand why using memblock APIs for
> meminspect is better than using meminspect directly.
> I'd imagine that using meminspect register APIs would actually make it more
> consistent and it would be easier to identify what memory is registered
> with meminspect.
> 
> In the end, memblock_alloc*() returns dynamically allocated memory, just
> like kmalloc(), the difference is that memblock is active very early at
> boot and disappears after core MM initialization.

Hi Mike,

Thanks for sharing your opinion.

David, what do you think, does it make sense to have this flag or we can
ditch it and use meminspect directly ?

Also, for some memory blocks, they do not disappear ever, e.g. the
printk log buffer, it's allocated early and never freed, so it's
required to have some memblocks marked for inspection.

Eugen

> 
>> And further, inside memblock, it would be a single point where
>> meminspect can be disabled (while preserving a no-op memblock flag), or
>> easily changed to another API if needed.
>> Ofcourse, one can call here directly the meminspect API if this is desired.
>> Do you think it would be better to have it this way ?
>>
>> Thanks for looking into it,
>> Eugen
> 


