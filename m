Return-Path: <linux-arch+bounces-15386-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF9CBA633
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 07:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D83F630A513C
	for <lists+linux-arch@lfdr.de>; Sat, 13 Dec 2025 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59097226D0C;
	Sat, 13 Dec 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/rv/PvX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5C156C6A
	for <linux-arch@vger.kernel.org>; Sat, 13 Dec 2025 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765608525; cv=none; b=Dr7aI2GGil4I/d1WoMRBId7jUylMhaoe9oqZC2cHupq9gGP2YMDaAqzMka1FATz8AMXSKuz7PjgGGP8FYMwyxw4m/e+1a4F9CuM6J8FY/0t5AzVG0CtmKldkc9Y37HTu99JkYhQmtGsKp1y5CRCtmRUDOKVFiSmtCpW5WM1SLHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765608525; c=relaxed/simple;
	bh=OSPLFg4W3QR5ByFn0Z+25izVWJy4kGkKLbWih19PHZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmTfwaRrsK5yIW5UVa02fAUIQWUZtfXfUSCVz9nVcV/bvyVI/jRGareeys770LZwc2sXCG6kb57FgTcSMhQ9Yc9d3JA6HHOuyFBVrlvOqn917k3B9CCIN7UTXZ3gPQKn3wNxuJFOIOh69f8KDq70MR2buEifuuR7FP0AyG7/k8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V/rv/PvX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo2211579b3a.2
        for <linux-arch@vger.kernel.org>; Fri, 12 Dec 2025 22:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765608523; x=1766213323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSPLFg4W3QR5ByFn0Z+25izVWJy4kGkKLbWih19PHZA=;
        b=V/rv/PvXawv5NhhkAlMigL5A3ymTVqMjUYFcMQfTez04D7GoxsMFc3nHxvrRxu0+Bx
         q/ag4Oils+4vYzzLAYkocXSctwh95tJIk7AfzCjE9g4pD/crZacOKcamExzMPbbSjgdU
         KpahdKnZjsNP57dPYv7jaInJnq5iLcW9+0ZWmvT2OozAB0E1wIJitV0Dv73h8kHCl6Je
         gm6vdMhqnhnrGP6jyc/R+pcvBWKNWf5P9e8+76Dii1eOMderlpgnbFv5KVQKR9ZZP1Q2
         +7GgkROGYw6lLjhmPRcJU5vV3NKGCV2mkB6SwBClNERHoV9nzTfyhH/Rn2nie3gdTSjk
         kIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765608523; x=1766213323;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSPLFg4W3QR5ByFn0Z+25izVWJy4kGkKLbWih19PHZA=;
        b=ULiVe0T+n1P/98+X+cVJA0EG+jGOhZkvbz5vwTxXt91Ot9JfoDujxwA8eApOiPXC2e
         e+y8AD+DuGH5iYyxbU2tgmTLiwhIbotoZgP6S5gFl5pU6KPBG2tWON60zWZhB7pvJXBr
         bxe5PEGCKHwdn6VQ6M/tXmxlM8tkXHKWimaxgxs9MvcCk0/jLamqYStL2zVEcO9tqJSx
         AcM8tUyfPxrAcXGGeidQ+0afitCBfP04m7iuYbbgHSY9BaDgPdE8GFRYwAKnojc6NZdd
         JT1HEJP76wLpn/kmlaSnc+StNzk6YlQ/UVMd+7x3gu19BhsxbOrfqUs+2btEieit6XFk
         43NA==
X-Forwarded-Encrypted: i=1; AJvYcCVDAooWoqJIXpww9np3qvwx+Y3G5wpJ8tYQjOWBbQElCJUDc+5wOkiaMqxLrUxcJMqqfhCbnSVN30fR@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOQFBACSoJSClR9FhnKgXmUHLiVFprmB3Nqq9lOA6GsauC7li
	FAFwQS9eUIPH/WvsdgQPaiQx0ubLO6okSeABb4fy750vQ8efOjDkNDUZbXYIlvuRc/g=
X-Gm-Gg: AY/fxX6R+uyyT3zUXUDJzl8tvdLGU6OCToDdst/QAvveNzAntXBA5BaXluWsFJxGTbY
	52wbeuAbjdY5PC7nuprp2O9PD0wrbuWi8kWulhr9syNb/qWRwauF19U9sfeJdMzD2XqY+E0AV3k
	HMJsgMLkzGcwcWCAcruO3n1edDcrx1AXyw64h4234u5P4ueWtm7mpOmvgDNiXWDfnaRCs4Rt3rw
	AKieDxwKFXATFw4U5+q3jC5vy/+NrNIxw1OuDm8j7uHRhPvEZTAB+QRZNW1DCz1oxs1O1bMCjSi
	7+l9clyMCC1mc9E7Um1zjktXhj12JUtguSgivpPfP//9eM8bcNEQsdASZcRLgzynL6fEJH3Luns
	HgKz5rI9NncZoaryRUysUyKqvdrHuCsX3ZoJ0jGYBvgHbycm+o5TrpT5fdjcf30B8anHlaCwS3t
	Jdg42rs8+ICsR6tBlkGAQRUapsCPX4n4EhqhtbN71ctCbJDMdxr9l8IA09sy/fcg==
X-Google-Smtp-Source: AGHT+IHwMXPg7Qn0Ef9xWbq83SFpsB1sFhZLa5C8vjkRdWjkXJZFN6bz1qhctibBoHiLjB/xaNqEfg==
X-Received: by 2002:a05:6a00:1c99:b0:7e8:4471:ae56 with SMTP id d2e1a72fcca58-7f6694a964bmr3530338b3a.34.1765608522549;
        Fri, 12 Dec 2025 22:48:42 -0800 (PST)
Received: from [10.200.3.203] (p99250-ipoefx.ipoe.ocn.ne.jp. [153.246.134.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4ab52aasm6927000b3a.38.2025.12.12.22.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 22:48:41 -0800 (PST)
Message-ID: <bf00eec5-e9fe-41df-b758-7601815b24a0@linaro.org>
Date: Sat, 13 Dec 2025 08:48:33 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] Introduce meminspect
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
 pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net, david@redhat.com,
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
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/25 17:44, Eugen Hristev wrote:
> meminspect is a mechanism which allows the kernel to mark specific memory
> areas for memory dumping or specific inspection, statistics, usage.
> Once regions are marked, meminspect keeps an internal list with the regions
> in a dedicated table.

[...]


> I will present this version at Plumbers conference in Tokyo on December 13th:
> https://lpc.events/event/19/contributions/2080/
> I am eager to discuss it there face to face.

Summary of the discussions at LPC talk on Dec 13th:

One main idea on the static variables annotation was to do some linker
magic, to create a list of variables in the tree, that would be parsed
by some script, the addresses and sizes would be then stored into the
dedicated section at the script level, without having any C code change.
Pros: no C code change, Cons: it would be hidden/masked from the code,
easy to miss out, which might lead to people's variables being annotated
without them knowing

Another idea was to have variables directly stored in a dedicated
section which would be added to the table.
e.g. static int __attribute(section (...)) nr_irqs;
Pros: no more meminspect section Cons: have to keep all interesting
variables in a separate section, which might not be okay for everyone.

On dynamic memory, the memblock flag marking did not receive any obvious
NAKs.

On dynamic memory that is bigger in size than one page, as the table
entries are registered by virtual address, this would be non-contiguous
in physical memory. How is this solved?
-> At the moment it's left for the consumer drivers to handle this
situation. If the region is a VA and the size > PAGE_SIZE, then the
driver needs to handle the way it handles it. Maybe the driver that
parses the entry needs to convert it into multiple contiguous entries,
or just have virtual address is enough. The inspection table does not
enforce or limit the entries to contiguous entries only.

On the traverse/notifier system, the implementation did not receive any
obvious NAKs

General comments:

Trilok Soni from Qualcomm mentioned they will be using this into their
software deliveries in production.

Someone suggested to have some mechanism to block specific data from
being added to the inspection table as being sensitive non-inspectable
data.
[Eugen]: Still have to figure out how that could be done. Stuff is not
being added to the table by default.

Another comment was about what use case there is in mind, is this for
servers, or for confidential computing, because each different use case
might have different requirements, like ignoring some regions is an
option in one case, but bloating the table in another case might not be
fine.
[Eugen]: The meminspect scenario should cover all cases and not be too
specific. If it is generic enough and customizable enough to care for
everyone's needs then I consider it being a success. It should not
specialize in neither of these two different cases, but rather be
tailored by each use case to provide the mandatory requirements for that
case.

Another comment mentioned that this usecase does not apply to many
people due to firmware or specific hardware needed.
[Eugen]: one interesting proposed usecase is to have a pstore
driver/implementation that would traverse the inspection table at panic
handler time, then gather data from there to store in the pstore
(ramoops, mtdoops or whatever backend) and have it available to the
userspace after reboot. This would be a nice use case that does not
require firmware nor specific hardware, just pstore backend support.

Ending note was whether this implementation is going in a good direction
and what would be the way to having it moving upstream.

Thanks everyone who attended and came up with ideas and comments.
There are a few comments which I may have missed, so please feel free to
reply to this email to start a discussion thread on the topic you are
interested in.

Eugen

