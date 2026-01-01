Return-Path: <linux-arch+bounces-15627-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33B7CECC22
	for <lists+linux-arch@lfdr.de>; Thu, 01 Jan 2026 03:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92F04300DC90
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jan 2026 02:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B656285050;
	Thu,  1 Jan 2026 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1n495X4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7F2877D8
	for <linux-arch@vger.kernel.org>; Thu,  1 Jan 2026 02:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767233240; cv=none; b=DZJMkVuG89DpQoCKkJDGrQFNPtlo7WDaIBguGEjQRP2bwYb/c9nuByQfGSCMSEpX9NgNQ2YGOlb75qlCYeKcbdlwF8XzuX2pggsjeob26e50/G1Ek8fJTkyjLz6mam6k5fwLWJp/+dr1iYAm1WJaIYEpzO0cAWO07uMSkBc+iq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767233240; c=relaxed/simple;
	bh=NSSdoE7G/g/QaVmDnjP9LfDazgPNO8PlY1pApWlnZBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3krVVW2auEKWFCFM2/wzYrAt/NrMFnUosuPuVjphCyLRSSxy1sO9eOaEyO3H0e5bBvPSGsMyBotj17Br1A8vvCcH4D6OeavnY1NEdp8cZ6SCX5xQbtiXLJKHPktPKaURknyx6RfPKdxZHWQXh2GbbuQjWAlD/QTwup8kIJMiVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1n495X4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7633027cb2so2027782066b.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Dec 2025 18:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767233237; x=1767838037; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQBF0g7LGMkaWXJONFj1Zzubf3JQP1KLJgb8Ha1McV4=;
        b=i1n495X42Awi4n07MNXXkHhs/ZSWHAPyNb3ik83mMMvg7FjQvBFSC+rSMdi9Px3igo
         ad9Hs5X4ug0sLCxi1ZTfwxmPNhO57XzfFjK2XzYXLBqTwhkTlmvIgF5yW8GvjCkwQbbU
         NBN60YCrFfAHaoYx70H4Caie7FhFlYhTHrDGvZH51ECY9G5L9S84eZ1gsjPoIU5wrf/J
         w1PMy2Fa0iKzfmNLuS3AqPw8moPkPPNKnssHuxbv09FulbTckOiPt0xA063QLX+AwQek
         Yp1rTYvpi2E2k0qvHGE95AmwuJjpGUKSAN9TAAQAPA2l2LmiPgU1KiM9BmVeYPVefN+4
         4vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767233237; x=1767838037;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQBF0g7LGMkaWXJONFj1Zzubf3JQP1KLJgb8Ha1McV4=;
        b=f/DcNget56fG5+mtBFGbBbbE7sJAQR+Hz6h7wDNSjucOhLetJMafZU6ProK7XIOyLC
         ouzxg+F2Q8LZj3AsB/X1pR7igOzTEv/HpwkkoWh9zYNn2JwyMruSrHC9CyG88bD7+e6u
         Cz8xzSwy6Fz3TQmeVvWH/iP54xslevCnQ3D3Mqm/MUAMUyzD8bkA+Ym8MV483ZvA2ens
         ziduS3RPMoIbyWdgYYBaWCw0AcAdPiwwFzBC+SiWXNVGT8KlbllZDzXpKJng2kbgigee
         Yf3yCQr4VhsIEbN7KzAgP89EuBpzBXqamPks7+vHraPGjQGPwLZMYdu7yojjyf4TDeZe
         3KWg==
X-Forwarded-Encrypted: i=1; AJvYcCVpx9Pl9D7WyQNdms9kmztfd1MVCjXAoSz/onfTw8kczg/eCmrnEf1K9ihJ0XjzmiyQYgMrQYxLuzGU@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCBOZ1/jSloo+HG6M4+mLGdlL7WS1FVRY+d6UFrjFXMNRr1nr
	nhw3TQJbOvENKGuffu+hhBOFGXmMf4NQExvBH4vS5zu1rxuBNCHcEhTQ
X-Gm-Gg: AY/fxX6mzI9WedsrnVohJAvw6ieS+2boke1AeJfksk5ayWQC0ou2Ws288RUIo4HBOCT
	N5IZb49alv5y+7/HM80caUDqyrpwZiBkv+1QdZsHFQI3kiMd2mfYJWetTHriB9RNDVtoI0C/Qm/
	E+4IomCTFrE1TvmsJ5jFviLWqUQiUKOcl5N26Bp8YqkS2cIHxV2CxkFfzn8Rekib5Zdv3KHOYSj
	j3hwKm36Rk5fHaLAAjHWWhBwVYlZMjjxxjd+bcwQbzjfKyWLtwOmBMbKyqo/5+ytiTk6ztFP0+k
	60LVmMVJxhbc21Z7bcEGPBZITNi5mNkM2/PqC2/2Auc5QJidG+argJiTzeyfpy3LW9c3yjbBzOo
	CIWzONCQ2ajxi/Q2DqiIfZ9bLvb+jt464ipN5ymgBDt4YOGRbywKNU3A1XNLnQTEGEqSQwhcD87
	3Uad88Ui2l/g==
X-Google-Smtp-Source: AGHT+IGkCnh9dqfLUptvpy4PZGXmScqGnHYP3DGjjwJuJ8br2u0RfwesNHaEMQG1tTnLLwW9sFl6GQ==
X-Received: by 2002:a17:907:7f05:b0:b72:9961:dc04 with SMTP id a640c23a62f3a-b8036f86950mr4237184166b.28.1767233236739;
        Wed, 31 Dec 2025 18:07:16 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b910601c7sm39251595a12.14.2025.12.31.18.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Dec 2025 18:07:16 -0800 (PST)
Date: Thu, 1 Jan 2026 02:07:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, will@kernel.org,
	aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
	dev.jain@arm.com, akpm@linux-foundation.org, david@kernel.org,
	ioworker0@gmail.com, linmag7@gmail.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
Message-ID: <20260101020715.45wqnjgcklvjcth3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <20251231094243.zmjs7kgflm7q6k73@master>
 <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Dec 31, 2025 at 05:52:57PM +0800, Qi Zheng wrote:
>
>
>On 12/31/25 5:42 PM, Wei Yang wrote:
>> On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>> > From: Qi Zheng <zhengqi.arch@bytedance.com>
>> > 
>> > The PT_RECLAIM can work on all architectures that support
>> > MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>> > MMU_GATHER_RCU_TABLE_FREE.
>> > 
>> > BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>> > to turn it off.
>> > 
>> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> > ---
>> > arch/x86/Kconfig | 1 -
>> > mm/Kconfig       | 9 ++-------
>> > 2 files changed, 2 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > index 80527299f859a..0d22da56a71b0 100644
>> > --- a/arch/x86/Kconfig
>> > +++ b/arch/x86/Kconfig
>> > @@ -331,7 +331,6 @@ config X86
>> > 	select FUNCTION_ALIGNMENT_4B
>> > 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>> > 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> > -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>> > 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>> > 	select SCHED_SMT			if SMP
>> > 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>> > diff --git a/mm/Kconfig b/mm/Kconfig
>> > index bd0ea5454af82..fc00b429b7129 100644
>> > --- a/mm/Kconfig
>> > +++ b/mm/Kconfig
>> > @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>> > 	  The architecture has hardware support for userspace shadow call
>> >            stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> > 
>> > -config ARCH_SUPPORTS_PT_RECLAIM
>> > -	def_bool n
>> > -
>> > config PT_RECLAIM
>> > -	bool "reclaim empty user page table pages"
>> > -	default y
>> > -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> > -	select MMU_GATHER_RCU_TABLE_FREE
>> > +	def_bool y
>> > +	depends on MMU_GATHER_RCU_TABLE_FREE
>> > 	help
>> > 	  Try to reclaim empty user page table pages in paths other than munmap
>> > 	  and exit_mmap path.
>> 
>> Hi, Qi
>> 
>> I am new to PT_RECLAIM, when reading related code I got one question.
>> 
>> Before this patch,  we could have this config combination:
>> 
>>      CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM
>> 
>> This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
>> is semi rcu version.
>> 
>> I am curious could we use rcu version tlb_remove_table_one() for this case?
>> Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
>> there some limitation here?
>
>I think there's no problem. The rcu version can also ensure that the
>fast GUP works well.
>

Thanks for your quick response :-)

And Happy New Year

So my little suggestion is move the definition of __tlb_remove_table_one()
under CONFIG_MMU_GATHER_RCU_TABLE_FREE. Do you thinks this would be more
clear?

>> 
>> Thanks in advance for your explanation.
>> 
>> 

-- 
Wei Yang
Help you, Help me

