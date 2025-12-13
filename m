Return-Path: <linux-arch+bounces-15389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C10CBA68A
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 08:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B94873008D4C
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 07:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5967274671;
	Sat, 13 Dec 2025 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hd5IO/Ik"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BF238C2A
	for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765610589; cv=none; b=IlWTkInStZ0fuz8JHYYlRx/0vmJS2epvPkwvfbLX8SvMTJla1AA21csQ5S1vO7taAdK/myuwpkbkbQrCVxauO8Ic3bEinTO66CDZGOTUinw3vgaB4XvDppvOKCnC46aRW3vGpe0fgmtVC29NI4Uf2LCV/ELoEeVvLS/JWqZzbzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765610589; c=relaxed/simple;
	bh=9Qa+PthUmnTltiZTazohO99moG5pdpcX7qRMBsxF/ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EnJ2EbyZ/T+mUWr/RNnlp3haDMj32CgcNIndo0bFIf6V8y4pYBjijxVaCGWigoq4RkohOUhzAPHw6FWC1d9lDCgyJI1EV1ifyK0ommmYSySnpOF46VCy13CPmqUlZRl8C1cQzcBdESFhAkzxXf0ks/QJ9cYbvlt9ancUuoMViXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hd5IO/Ik; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f102b013fso22074685ad.2
        for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 23:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765610587; x=1766215387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qS/a8O0BbZSZZsXyGtd7peZrK8putFww9+X+USFCeDw=;
        b=hd5IO/IkAS9Cts2py6hsAvieVf9h9ZCCP+wq7vdZv7lGLHc5Ult5/ZSoGo16bFFEi9
         IIUP5p/qP+Cq74AfbT8Ijn1rQt0YfoBujNP+PLlo3DLIZgqZe7QLOTGgzVNnX3XPq6y2
         OxFZMhGSuLqL7C7N7X12CxPkge2OnVhZsr7umtXcTGBiifiHTF4A/bT//HVcNSx+lxPM
         2SKqJ39F7qwfflmuEa+va62mlcfawqpEBCEFusZvUhYwhLYHjcTiAwl7s1RfyM8dQElg
         l5zPl8kSkv77Dr4s+Jtq4y76qqnXkYlH0D0Bu0RvCUpoVs2eiIwOW/k9hLe6EUNWi5O4
         F52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765610587; x=1766215387;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qS/a8O0BbZSZZsXyGtd7peZrK8putFww9+X+USFCeDw=;
        b=sH95xDKNnTMcELegs/clUzXCEM0eSgTTPivoahUGZp8dmr2JP1aYl4YABdlrQ/83Wf
         GzGWhNJMe/BjsHQoPjz1F3y/TSZWcLOyvjRFr/4bTp6EiJzzTw+M9lBEdf7ahzxivbov
         x/u7Bydw26UCutiuEkrzAV+jY5RWrKgOBQUSXDrF/WmJCGCgkAF7UMueP9uqNEWOgqlu
         fDkD2leeZ1GagRIkFKIDV/HJIIfZzEM48lXd7x4I1eCT4N/8hcdI8P1ncT74YKpojCdA
         no4cbCuI/g6tO+gYcAyDwhNRSeTmu83VMZN2uo9/QucWmGe/qPgUisu3d+96RasFoNaz
         yIIg==
X-Forwarded-Encrypted: i=1; AJvYcCULFZiAJ/s785on351TwZos9tT+c4Ly7/MDws+IA18TKT7Hi9UvyjFeCT+buDEwtBL93sZ9MxVwq1u/@vger.kernel.org
X-Gm-Message-State: AOJu0YwK8Yu6RvootOolJaF8N3hGTgHaLD10RX7uuNRQd1Dsqt0VhpgG
	L6uL1aMGNMSdnBYWNkv6ur7LRVt8fknUlGu+aj0/MGAeH+o+3xzmm3PMQbfFqacocMU=
X-Gm-Gg: AY/fxX44GrfEUzNHB7+0E9vY1WGOi1cplDszZn7lyu7bdVzzQafxu05f38n610bKE/D
	A7CVYqphiO+3aVd7COU/FWFAf5wFOeO0wgOvQe4EdprbYlIWDdSA111QlGiupUPalpVLAo5Og/W
	KNxtdAloA6muDzBbtuoZgrKNbMgVtDjlcUgiAiHxpG34kElSgz7qqdtKKML6XB0o99pQZcPIs+s
	dGc5DIReiq/EjCiWhzToAXNGP8adg1dweR8JNqeQdECFcCAR6LFzMmji1dcPYscbVgQ4ZdS6RAr
	QO74hQmIjG9/wKFbWmTRNmy/ZUgAdDqxb9+kBwGrkhbYXfijxb7YKGIn80PpJZLZl8bGzZ8Bv0j
	Tku/WnKiwuOGFgGWnaZ1nQ3nuseokQTJ+9weE3mdVG7F0sGfhvgcbnWAg3sSuP1c+S/2+tGiEaq
	6Ab0B80hjsDC8+V4gYNJ24o9MwanDfSEuSnCbsZf/uJxAWD9MyWAc=
X-Google-Smtp-Source: AGHT+IF5ZAK05FTZM7z1I/Tfu2uwtqip2Rr6c/twbgvqZujsfkv8PIP29+IUmV2/Et+MT9YWs2FBBQ==
X-Received: by 2002:a17:903:2c07:b0:29d:df04:fcdf with SMTP id d9443c01a7336-29f2436dfb5mr47558295ad.42.1765610586985;
        Fri, 12 Dec 2025 23:23:06 -0800 (PST)
Received: from [10.200.3.203] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f2563b116sm39121255ad.102.2025.12.12.23.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 23:23:06 -0800 (PST)
Message-ID: <c3db6ccd-dfc7-4a6a-82b7-3d615f8cab4f@linaro.org>
Date: Sat, 13 Dec 2025 09:22:56 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Introduce meminspect
To: Randy Dunlap <rdunlap@infradead.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, corbet@lwn.net, david@redhat.com,
 mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org,
 Trilok Soni <tsoni@quicinc.com>, Kaushal Kumar <kaushalk@qti.qualcomm.com>,
 Shiraz Hashim <shashim@qti.qualcomm.com>,
 Peter Griffin <peter.griffin@linaro.org>, stephen.s.brennan@oracle.com,
 Will McVicker <willmcvicker@google.com>,
 "stefan.schmidt@linaro.org" <stefan.schmidt@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <bf00eec5-e9fe-41df-b758-7601815b24a0@linaro.org>
 <5903a8e1-71c6-4546-ac50-35effa078dda@infradead.org>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <5903a8e1-71c6-4546-ac50-35effa078dda@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/25 08:57, Randy Dunlap wrote:
> Hi,
> 
> On 12/12/25 10:48 PM, Eugen Hristev wrote:
>>
>>
>> On 11/19/25 17:44, Eugen Hristev wrote:
>>> meminspect is a mechanism which allows the kernel to mark specific memory
>>> areas for memory dumping or specific inspection, statistics, usage.
>>> Once regions are marked, meminspect keeps an internal list with the regions
>>> in a dedicated table.
>>
>> [...]
>>
>>
>>> I will present this version at Plumbers conference in Tokyo on December 13th:
>>> https://lpc.events/event/19/contributions/2080/
>>> I am eager to discuss it there face to face.
>>
>> Summary of the discussions at LPC talk on Dec 13th:
>>
>> One main idea on the static variables annotation was to do some linker
>> magic, to create a list of variables in the tree, that would be parsed
>> by some script, the addresses and sizes would be then stored into the
>> dedicated section at the script level, without having any C code change.
>> Pros: no C code change, Cons: it would be hidden/masked from the code,
>> easy to miss out, which might lead to people's variables being annotated
>> without them knowing
>>
>> Another idea was to have variables directly stored in a dedicated
>> section which would be added to the table.
>> e.g. static int __attribute(section (...)) nr_irqs;
>> Pros: no more meminspect section Cons: have to keep all interesting
>> variables in a separate section, which might not be okay for everyone.
>>
>> On dynamic memory, the memblock flag marking did not receive any obvious
>> NAKs.
>>
>> On dynamic memory that is bigger in size than one page, as the table
>> entries are registered by virtual address, this would be non-contiguous
>> in physical memory. How is this solved?
>> -> At the moment it's left for the consumer drivers to handle this
>> situation. If the region is a VA and the size > PAGE_SIZE, then the
>> driver needs to handle the way it handles it. Maybe the driver that
>> parses the entry needs to convert it into multiple contiguous entries,
>> or just have virtual address is enough. The inspection table does not
>> enforce or limit the entries to contiguous entries only.
>>
>> On the traverse/notifier system, the implementation did not receive any
>> obvious NAKs
>>
>> General comments:
>>
>> Trilok Soni from Qualcomm mentioned they will be using this into their
>> software deliveries in production.
>>
>> Someone suggested to have some mechanism to block specific data from
>> being added to the inspection table as being sensitive non-inspectable
>> data.
>> [Eugen]: Still have to figure out how that could be done. Stuff is not
>> being added to the table by default.
>>
>> Another comment was about what use case there is in mind, is this for
>> servers, or for confidential computing, because each different use case
>> might have different requirements, like ignoring some regions is an
>> option in one case, but bloating the table in another case might not be
>> fine.
>> [Eugen]: The meminspect scenario should cover all cases and not be too
>> specific. If it is generic enough and customizable enough to care for
>> everyone's needs then I consider it being a success. It should not
>> specialize in neither of these two different cases, but rather be
>> tailored by each use case to provide the mandatory requirements for that
>> case.
>>
>> Another comment mentioned that this usecase does not apply to many
>> people due to firmware or specific hardware needed.
>> [Eugen]: one interesting proposed usecase is to have a pstore
>> driver/implementation that would traverse the inspection table at panic
>> handler time, then gather data from there to store in the pstore
>> (ramoops, mtdoops or whatever backend) and have it available to the
>> userspace after reboot. This would be a nice use case that does not
>> require firmware nor specific hardware, just pstore backend support.
>>
>> Ending note was whether this implementation is going in a good direction
>> and what would be the way to having it moving upstream.
>>
>> Thanks everyone who attended and came up with ideas and comments.
>> There are a few comments which I may have missed, so please feel free to
>> reply to this email to start a discussion thread on the topic you are
>> interested in.
>>
>> Eugen
>>
> 
> Maybe you or someone else has already mentioned this. If so, sorry I missed it.
> 
> How does this compare or contrast to VMCOREINFO?
> 
> thanks.

This inspection table could be created in an VMCOREINFO way, the patch
series here[1] is something that would fit it best .

The drawbacks are :
some static variables have to be registered to VMCOREINFO in their file
of residence. This means including vmcoreinfo header and adding
functions/code there, and everywhere that would be needed , or , the
variables have to be un-static'ed , which is a no-go.
This received more negative opinions on that particular patch series.
The annotation idea seemed cleaner and simpler, and more generic.

We could add more and more entries to the vmcoreinfo table, but that
would mean expanding it a lot, which it would maybe defy its purpose,
and be getting too big, especially for the cases where custom drivers
would like to register data.

How I see it, is that maybe the vmcoreinfo init function, could also
parse the inspection table and create more entries if that is needed.
So somehow memory inspection is a superset or generalization , while
VMCOREINFO is a more particular use case that would fit here.

Do you think of some better way to integrate the meminspect table into
VMCOREINFO ?

[1]
https://lore.kernel.org/all/20250912150855.2901211-1-eugen.hristev@linaro.org/

