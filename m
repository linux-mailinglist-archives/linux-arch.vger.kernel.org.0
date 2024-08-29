Return-Path: <linux-arch+bounces-6803-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402309643B5
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A83DDB215DD
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A206192B83;
	Thu, 29 Aug 2024 12:01:48 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54CE18CC02;
	Thu, 29 Aug 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932908; cv=none; b=UiGwoT0fC0j/KMUH3WtzPVHMzQU6kkLOpgq0pEwBEQs/EzkJkurlWEGwZ/CKv/q+Vyaytr2yKdmhbIARG96V7AfWLNE5MjOa+/aj1p2f5wIs4INa4kSPVKDNrNKnj0P1upFvF89Eu8kj0VaaQNJS0Xko7CmjQ+dKSaanFMVzfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932908; c=relaxed/simple;
	bh=4mJjWETIZmbDstqAvIMhzLQse09kCQvTp1m1O7h/UN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQf8oHjmE8va2H8WfHUEdfzVXP6KlnT1TeQIy7VaUwAiYaRL1Ne4xKOZy+QJm4neKTpUZEka5AUavxTTB0TTJ2PJpe9jytouxrS2izFir/h2BKUj6Zg9XfCc+zVYF0ksryNYYV+0y1AKI6QNio9TsvT7nvA3rM3CkIynizUkXG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 822E2DA7;
	Thu, 29 Aug 2024 05:02:05 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 604163F762;
	Thu, 29 Aug 2024 05:01:37 -0700 (PDT)
Message-ID: <bab7286c-e27e-450a-8bb6-e5b09063a033@arm.com>
Date: Thu, 29 Aug 2024 13:01:35 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Arnd Bergmann <arnd@arndb.de>, "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linux-Arch <linux-arch@vger.kernel.org>
References: <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
 <Zs2RCfMgfNu_2vos@zx2c4.com>
 <cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com>
 <0f9255f1-5860-408c-8eaa-ccb4dd3747fa@csgroup.eu>
 <17437f43-9d1f-4263-888e-573a355cb0b5@arm.com>
 <272cb38a-c0e3-4e6e-89ce-b503c75c2c33@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <272cb38a-c0e3-4e6e-89ce-b503c75c2c33@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christophe,

On 27/08/2024 18:14, Christophe Leroy wrote:
> 
> 
> Le 27/08/2024 à 18:05, Vincenzo Frascino a écrit :
>> Hi Christophe,
>>
>> On 27/08/2024 11:49, Christophe Leroy wrote:
>>
>> ...

...

>>
>> Could you please clarify where minmax is needed? I tried to build Jason's master
>> tree for x86, commenting the header and it seems building fine. I might be
>> missing something.
> 
> Without it:
> 
>   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
> In file included from /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:11,
>                  from <command-line>:
...

> 
> 
>>
>>> Same for ARRAY_SIZE(->reserved) by the way, easy to do opencode, we also have it
>>> only once
>>>
>>
>> I have a similar issue to figure out why linux/array_size.h and
>> uapi/linux/random.h are needed. It seems that I can build the object without
>> them. Could you please explain?
> 
> Without linux/array_size.h:
> 
>   VDSO32C arch/powerpc/kernel/vdso/vgetrandom-32.o
> In file included from <command-line>:
> /home/chleroy/linux-powerpc/lib/vdso/getrandom.c: In function
> '__cvdso_getrandom_data':
> /home/chleroy/linux-powerpc/lib/vdso/getrandom.c:89:40: error: implicit
If this is the case, those headers should be defined for the powerpc
implementation only. The generic implementation should be interpreted as the
minimum common denominator in between all the architectures for what concerns
the headers.

-- 
Regards,
Vincenzo

