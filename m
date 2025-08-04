Return-Path: <linux-arch+bounces-13030-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7DB1A032
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 13:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A2B1887E63
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308542459DC;
	Mon,  4 Aug 2025 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLyE1HJB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E521F0E25
	for <linux-arch@vger.kernel.org>; Mon,  4 Aug 2025 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305577; cv=none; b=KD9BKi+3so7G9YGwKayf7he29UartaqiNHfNj25ZZQfoj6QecQcU3SGaDtgOPUeVzqfQEHFr3E7R3QSH8GG+FnnDuh8Ad2/nXvTqQ2z5YJXZDXqKkdVB69KtVxZofq0La5SPgmn/RPhmvgYVfyotT0pruP7QQOaUQ2O5J4E6Xx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305577; c=relaxed/simple;
	bh=w5XtDIivcbCdAqyNR6P6njAnhtzT50eI72GOitq7UVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQdl8TIBHjxViLyOtLqDBwoCtbdZc0sjn/wZnC/MwYUatPHN0FGktjgVlFJV3b5kwenW05pevDGnxMhSehNDSTONspB3faSnE7CVifo6sRKk8BzNr1HpXHsH0A0z3JwzUQRHfhA01jVEoRFx9GfKO+NgdhuLe27THYhaT38sf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oLyE1HJB; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so9268066a12.0
        for <linux-arch@vger.kernel.org>; Mon, 04 Aug 2025 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754305574; x=1754910374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AbCL33p6FgXvGTA+R2ME1gzKoUWjtIJjxxkRY3HfTrM=;
        b=oLyE1HJB8aSCeCp6zX78iyLdsQH8Fgmt1tFEQLcvr/mKVzsjQAzFPP6QUBHt93gpAj
         7azeCvO3/Xe5aWsU+BlloT9Vr5CXwLfBYyd5bsLpeeAi2pAXwiArHLum+kSAbbXAT3xq
         gouVb6LVWBPhDik8RmUFvpy9Kj1aDN3CZzwUUo+m6px6HZmpLuRVy8CAZn+GQGM5w1Mp
         LytyhVtT6DjJy2Ofrvl8dcfuL5CEXXmfnaDloGlA/rKxoL2zBIuTZc0JJhOYJou6+wEC
         bnQT5rHlyduHDchPCV2rjMQqfo8WQiyJxsp85ErX2klfVoKdJI+IR5xspMhHsAm1y84g
         cEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754305574; x=1754910374;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AbCL33p6FgXvGTA+R2ME1gzKoUWjtIJjxxkRY3HfTrM=;
        b=fVBP+ts2pFRW0DoByQedYjJOpFenguhy7KfX3Qo3MeF1KEsZ/ZvT/ZOOxuW8mhCDc+
         cEm9xBI7OUY0Qa2T5kwg4O59IOFtg72qOkz2w/ZpzYJXR2CRU92eedmrtFY2UQtNZnlb
         ROFg2ywnvCEWLBrfuPY4cLPhz46W7MlOPB91jDP1qquonpMtCnv8zZ5P5BTbKq8ij67c
         FaQpGZf4Vf5UlM32yaN7hMl/bdnnV3NYQCAmh9rTYmIWCBt5MWq/mhMkA/ZY3JuF4dyF
         LF79ZJU7PsoUM9cLIHvMtqAoIMPHcJy7enFIh2Nau+beSA5xXVJqDSppFzR11TK1oDHD
         bbvA==
X-Forwarded-Encrypted: i=1; AJvYcCU+hj0qeGZ42Dl01AvVmh3acxUtqkPk57UKZ95Wv3jFCp8mr9kehKkId4RNuv86phZtsOsCoWMTi77E@vger.kernel.org
X-Gm-Message-State: AOJu0Yystzedz9JLOkH595My6hmiGsZ1Stn2h7H+HPuxTadGbv3fS2jt
	CuGIRsYgtZkyI88Wa1KSnW4b8M3NLEAi0IY6ozcehGvKM0qSdjQxqfTstkgv5Bo3xls=
X-Gm-Gg: ASbGnctiKQuwO1TUK1TyGz9VlZek/v95KEfobHq/dXJuCZUhFmKa3qE5i4ocRBQphjO
	vPeK+uKvxf05G+doEKQdeo4xD5NfKCx0g7wgZgkXsT58GeTTdyvEojc0mSSTf7xfhej8WUrgSgK
	Yv1KBGaT/EP68E4nxg6fxwOGrApHfsGI+QSdiQolxPYSeBf4FFGWyaNAVPKWaF7V7elKROHkgi/
	/3j6m0np+PYf/+EizBawOK4k9XMSRYXSOcC2PbOhjaAbW703FN3sT3txh2LxyB9CrO1MUWGMYTz
	mV/rXEkKYgwjEsGaVwcJOLJuzlf72jJSIp+RvXoa9Q3jXyXVrQm//lkPKYwyQdwdQy28R5BHDg1
	StrfSuuE+87Ujmd01epjHtzJ9VYxloQ==
X-Google-Smtp-Source: AGHT+IE4XPeXZCbPPTnUeGFh37dBHmQZ35wpgsW3hiGwLGtsXzKowOSWjqCke7T73Fj9hT1fEebjmg==
X-Received: by 2002:a17:907:3f2a:b0:ae3:8c9b:bd61 with SMTP id a640c23a62f3a-af93ffa2d63mr907152566b.12.1754305573593;
        Mon, 04 Aug 2025 04:06:13 -0700 (PDT)
Received: from [192.168.0.33] ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076409sm721053666b.12.2025.08.04.04.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 04:06:13 -0700 (PDT)
Message-ID: <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
Date: Mon, 4 Aug 2025 14:06:11 +0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <20250724135512.518487-23-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <aJCRgXYIjbJ01RsK@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 13:54, Michal Hocko wrote:
> On Wed 30-07-25 16:04:28, David Hildenbrand wrote:
>> On 30.07.25 15:57, Eugen Hristev wrote:
> [...]
>>> Yes, registering after is also an option. Initially this is how I
>>> designed the kmemdump API, I also had in mind to add a flag, but, after
>>> discussing with Thomas Gleixner, he came up with the macro wrapper idea
>>> here:
>>> https://lore.kernel.org/lkml/87ikkzpcup.ffs@tglx/
>>> Do you think we can continue that discussion , or maybe start it here ?
>>
>> Yeah, I don't like that, but I can see how we ended up here.
>>
>> I also don't quite like the idea that we must encode here what to include in
>> a dump and what not ...
>>
>> For the vmcore we construct it at runtime in crash_save_vmcoreinfo_init(),
>> where we e.g., have
>>
>> VMCOREINFO_STRUCT_SIZE(pglist_data);
>>
>> Could we similar have some place where we construct what to dump similarly,
>> just not using the current values, but the memory ranges?
> 
> All those symbols are part of kallsyms, right? Can we just use kallsyms
> infrastructure and a list of symbols to get what we need from there?
> 
> In other words the list of symbols to be completely external to the code
> that is defining them?

Some static symbols are indeed part of kallsyms. But some symbols are
not exported, for example patch 20/29, where printk related symbols are
not to be exported. Another example is with static variables, like in
patch 17/29 , not exported as symbols, but required for the dump.
Dynamic memory regions are not have to also be considered, have a look
for example at patch 23/29 , where dynamically allocated memory needs to
be registered.

Do you think that I should move all kallsyms related symbols annotation
into a separate place and keep it for the static/dynamic regions in place ?

Thanks for looking into my patch,
Eugen

