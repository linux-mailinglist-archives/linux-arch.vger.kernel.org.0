Return-Path: <linux-arch+bounces-5168-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52F91A86D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 15:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCEE1C21961
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jun 2024 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5515617D37E;
	Thu, 27 Jun 2024 13:58:12 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1C36B0D;
	Thu, 27 Jun 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496692; cv=none; b=DiFZM27Fi4zYQ9KFG/DLVMevGGt02NgbMK7yxra7MqCpsCmYrfBtcxHREKyvb9yc59H/1M0zs1AIRuvc1uv6JPkurf39H3ubCwbosngkQ9t1PWCfgdKpMHbQ95krgbbQR5K1VMpWwYygVIYrbK2Tnmvz1Xlq7cXp22Hg42j+u1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496692; c=relaxed/simple;
	bh=R/3gw7X0NUmVPuaHrazN7KSa+IPv0NClpRt5VSZK730=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ex0CBxac06JSk8x0pIx59IB2M5NfYhfXhO0sMNfRJbGFY8i9t6qVtxXgX+6lPOZwozxJBH1B1jOjmD7v3b47itKZt2X0e2Ok6aBRaZm5lADJyb8ugavzJ+2ylep9pKS6X67Cwg7wGer8QWBr1bjlTaOM+IPhNnT/IOpO5TX5ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7206E367;
	Thu, 27 Jun 2024 06:58:34 -0700 (PDT)
Received: from [10.1.30.72] (e122027.cambridge.arm.com [10.1.30.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D6DD3F73B;
	Thu, 27 Jun 2024 06:58:08 -0700 (PDT)
Message-ID: <5fc31a39-2068-4fff-b9bf-27feb4ca3bbe@arm.com>
Date: Thu, 27 Jun 2024 14:58:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixmap: Remove unused set_fixmap_offset_io()
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20240612160038.522924-1-steven.price@arm.com>
 <7f258a4c-6048-4718-851d-4768789bc5e1@app.fastmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <7f258a4c-6048-4718-851d-4768789bc5e1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2024 21:02, Arnd Bergmann wrote:
> On Wed, Jun 12, 2024, at 18:00, Steven Price wrote:
>> The macro set_fixmap_offset_io() was added in commit f774b7d10e21
>> ("arm64: fixmap: fix missing sub-page offset for earlyprintk") but then
>> commit 8ef0ed95ee04 ("arm64: remove arch specific earlyprintk") removed
>> the file causing the only user to be removed when the two commits were
>> merged. Since this has never been used again since the v3.15 release
>> remove it.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> This came up because for Arm CCA there is a need to override
>> set_fixmap_io() [1] and rather than also update set_fixmap_offset_io() I
>> thought it would be better to just drop the unused macro.
>>
>> [1] https://lore.kernel.org/lkml/20240605093006.145492-6-steven.price@arm.com/
> 
> I assume you want to keep this with your other patch, so
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Actually for now it looks[1] like we're going to drop the overriding of 
set_fixmap_io() so if you want to apply this change separately please 
do!

Thanks,

Steve

[1] https://lore.kernel.org/r/b611bb5f-b6f8-44a4-9b33-a92862974363%40arm.com

