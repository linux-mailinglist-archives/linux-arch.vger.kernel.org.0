Return-Path: <linux-arch+bounces-12604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D5AFED5E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 17:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 950667BD8D2
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609282E88BE;
	Wed,  9 Jul 2025 15:13:05 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7E2E8DE9;
	Wed,  9 Jul 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073985; cv=none; b=rjCvOBVo+OH7NaMzRMupv46AnZl1tKaL8ChWaMcLoMR4fQk38b+HQxF7zeZ8xCODEdRf2xqislCu/5OrB5WoGnJpDxnX3/lg2dx1g6VEl4P7ydenjAvEp2U46Z5RsBY3N0soYXxzKszYhYTCy6hI6MoErA0ycWuP6Kps1Hpj2/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073985; c=relaxed/simple;
	bh=EJseggIkD+nS+69ZP6dE+TUdykIpXwWPOgf9eLg99f4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mo2B1dE2VLSHlXtLG4ro/5mvF8DQf9okE8WOILKGO+wrr7LOMuHPE/x10y1iB9OQhrWMiYXSilTs83B3rUaloeXZiKpZWI3qnI/sFL35ZqvkeYAIRgEV6h41ph/BN9wmB1S6Lx0Uan3Sv+0S4Pn1cjIWpEVFmxWQYUpn28oiG80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 565AA43136;
	Wed,  9 Jul 2025 15:12:52 +0000 (UTC)
Message-ID: <aae8559c-88d2-4882-92cd-7e906eb8b7d6@ghiti.fr>
Date: Wed, 9 Jul 2025 17:12:51 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Implement endianess swap macros for RISC-V
From: Alexandre Ghiti <alex@ghiti.fr>
To: Ignacio Encinas <ignacio@iencinas.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, Zhihang Shao <zhihang.shao.iscas@gmail.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-arch@vger.kernel.org
References: <20250426-riscv-swab-v4-0-64201404a68c@iencinas.com>
 <57352cc0-420b-42e6-a493-2764794a5206@ghiti.fr>
Content-Language: en-US
In-Reply-To: <57352cc0-420b-42e6-a493-2764794a5206@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffhvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepfeegvdelkeetgeehleefjeduteegtdfgtdekveevudehieejteeiudelledtveelnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmegrjegvvdemrgguledvmeelrggsjeemfeduhegsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmegrjegvvdemrgguledvmeelrggsjeemfeduhegspdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmegrjegvvdemrgguledvmeelrggsjeemfeduhegsngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehighhnrggtihhosehivghntghinhgrshdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhop
 ehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlqdhmvghnthgvvghssehlihhsthhsrdhlihhnuhigrdguvghv

Hi Arnd,

Gentle ping as we would like to merge this in the riscv tree but we need 
your ack (or nack).

Thanks,

Alex

On 5/16/25 16:37, Alexandre Ghiti wrote:
> Hi Arnd,
>
> Do you think we can merge that for 6.16? It is nice improvement for us.
>
> Thanks,
>
> Alex
>
> On 26/04/2025 16:56, Ignacio Encinas wrote:
>> Motivated by [1]. A couple of things to note:
>>
>> RISC-V needs a default implementation to fall back on. There is one
>> available in include/uapi/linux/swab.h but that header can't be included
>> from arch/riscv/include/asm/swab.h. Therefore, the first patch in this
>> series moves the default implementation into asm-generic.
>>
>> Tested with crc_kunit as pointed out here [2]. I can't provide
>> performance numbers as I don't have RISC-V hardware yet.
>>
>> [1] https://lore.kernel.org/all/20250302220426.GC2079@quark.localdomain/
>> [2] 
>> https://lore.kernel.org/all/20250216225530.306980-1-ebiggers@kernel.org/
>>
>> Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
>> ---
>> Changes in v4:
>>
>> - Add missing include in the 1st patch, reported by
>> https://lore.kernel.org/all/202504042300.it9RcOSt-lkp@intel.com/
>> - Rewrite the ARCH_SWAB macro as suggested by Arnd
>> - Define __arch_swab64 for CONFIG_32BIT (Ben)
>> - Link to v3: 
>> https://lore.kernel.org/r/20250403-riscv-swab-v3-0-3bf705d80e33@iencinas.com
>>
>> Arnd, I know you don't like Patch 1 but I tried your suggestions and
>> couldn't make them work. Please let me know if I missed anything [3] [4]
>>
>> [3] 
>> https://lore.kernel.org/linux-riscv/f5464e26-faa0-48f1-8585-9ce52c8c9f5f@iencinas.com/
>> [4] 
>> https://lore.kernel.org/linux-riscv/b3b59747-0484-4042-bdc4-c067688e3bfe@iencinas.com/
>>
>> Changes in v3:
>>
>> PATCH 2:
>>    Use if(riscv_has_extension_likely) instead of asm goto (Eric). It
>>    looks like both versions generate the same assembly. Perhaps we 
>> should
>>    do the same change in other places such as 
>> arch/riscv/include/asm/bitops.h
>> - Link to v2: 
>> https://lore.kernel.org/r/20250319-riscv-swab-v2-0-d53b6d6ab915@iencinas.com
>>
>> Changes in v2:
>> - Introduce first patch factoring out the default implementation into
>>    asm-generic
>> - Remove blank line to make checkpatch happy
>> - Link to v1: 
>> https://lore.kernel.org/r/20250310-riscv-swab-v1-1-34652ef1ee96@iencinas.com
>>
>> ---
>> Ignacio Encinas (2):
>>        include/uapi/linux/swab.h: move default implementation for 
>> swab macros into asm-generic
>>        riscv: introduce asm/swab.h
>>
>>   arch/riscv/include/asm/swab.h   | 62 
>> +++++++++++++++++++++++++++++++++++++++++
>>   include/uapi/asm-generic/swab.h | 33 ++++++++++++++++++++++
>>   include/uapi/linux/swab.h       | 33 +---------------------
>>   3 files changed, 96 insertions(+), 32 deletions(-)
>> ---
>> base-commit: a7f2e10ecd8f18b83951b0bab47ddaf48f93bf47
>> change-id: 20250307-riscv-swab-b81b94a9ac1b
>>
>> Best regards,

