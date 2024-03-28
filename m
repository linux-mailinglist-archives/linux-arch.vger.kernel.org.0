Return-Path: <linux-arch+bounces-3274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67172890714
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 18:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF361C23D95
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7B7EF00;
	Thu, 28 Mar 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpYK7CtE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05BF5A780;
	Thu, 28 Mar 2024 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646574; cv=none; b=O6tEhWY8xlMqdZphDudDFIpkzMi9qGEkngehtaDa5a2hXZqy20uGMxvabjght3B3esmTI7G39bP+02lE2iVHtw6kcMHJzWjNEKqW1zsBsfrbaECvxLmN0nrWG6+1IWkVqzWAR48RzD/EZv7FoMGYD6EBpPVDGNCRGKTViRvVTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646574; c=relaxed/simple;
	bh=qua/zmPT+EiKZ8b7JnambugGScyxnGAtKKDsUfi9O2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zlazpe4VPIR3v2+lSMk4Fj6sJc+w395N65gYETieee3LxVeXbbhEs5SGlrU+99/n3fM42wlrpDaknm/aL65wpklUiNUSnnpkHV1mphp1dWjSI0z/siQwPsLURxlFxkwFqHOTK3+yPuu662zTX7VUNvircHecYx5zrUS1c2WXpD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpYK7CtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8E9C433F1;
	Thu, 28 Mar 2024 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711646574;
	bh=qua/zmPT+EiKZ8b7JnambugGScyxnGAtKKDsUfi9O2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mpYK7CtE8kP2DP4Gu/JghUPoKhF/ix5wL8F/cGRw0BPfjxCHeQgzcRUhx36ZVsp80
	 BG6oCt60Yp9PzIXXfRAGmtYKTZKokjop+im8Zc7KcXJIyr4fSsGSKa/fwK1NHSxJMT
	 SP1YadUZAQyd5PFF/KSB5IJ56nULe28LhhTUD0aBAxCtqY0O1drmObju/epGG/bPOh
	 DM8iMm+aYuIKeJeyCDD9CFVcdE3GYCSCwo7z8ndISI97l+1PvGUkmEdHCPD7QvMzVe
	 SzMEnVMeeHuEcq1qhcD9ZnIvs6yJ8OQUVKZ0+uyLtquaHJ0m1wOlaSS29MCLtItglR
	 WrMzaodCMARog==
Message-ID: <abb3f8ab-c88d-4b04-ae75-62de0dddd343@kernel.org>
Date: Thu, 28 Mar 2024 10:22:52 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARC: mm: fix new code about cache aliasing
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20240328053919.992821-1-vgupta@kernel.org>
 <20240328053919.992821-3-vgupta@kernel.org>
 <2084d534-5e64-4a38-aba5-aeb03c9e71cd@efficios.com>
Content-Language: en-US
From: Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <2084d534-5e64-4a38-aba5-aeb03c9e71cd@efficios.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/28/24 06:57, Mathieu Desnoyers wrote:
> On 2024-03-28 01:39, Vineet Gupta wrote:
>> Manual/partial revert of 8690bbcf3b70 ("Introduce cpu_dcache_is_aliasing() across all architectures")
>>
>> Current generation of ARCv2/ARCv3 based HSxx cores are only PIPT (to software
>> at least).
>>
>> Legacy ARC700 cpus could be VIPT aliasing (based on cache geometry and
>> PAGE_SIZE) however recently that support was ripped out so VIPT aliasing
>> cache is not relevant to ARC anymore.
>>
>> P.S. : This has been discussed a few times on lists [1]
>> P.S.2: Please CC the arch maintainers and/or mailing list before adding
>>         such interfaces.
> Because 8690bbcf3b70 was introducing a tree-wide change affecting all
> architectures, I CC'd linux-arch@vger.kernel.org. I expected all
> architecture maintainers to follow that list, which is relatively
> low volume.

Ideally yeah arch maintainers should be lurking there.


> I'm sorry that you learn about this after the fact as a result.

Please don't be, no harm done, the fix was easy ;-)

> My intent was to use the list rather than CC about 50 additional
> people/mailing lists.

That is true but I don't think maintainers mind that in general. I still
posit that any new interfaces to arch code should be explicitly run by them.

> Of course, if VIPT aliasing is removed from ARC, removing the
> config ARCH_HAS_CPU_CACHE_ALIASING and using the generic
> cpu_dcache_is_aliasing() is the way to go. Feel free to add
> my:
>
> Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thx,
-Vineet

