Return-Path: <linux-arch+bounces-7961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851A4998623
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C911C21022
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797021C0DFB;
	Thu, 10 Oct 2024 12:35:32 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6D29AF;
	Thu, 10 Oct 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563732; cv=none; b=mm14egS6IT1gUdNwKqHseAe3NOq/CoPSQAnoDLuhznaOxaYNyVRkC8prVPsSc7mda5OKpIOA3lWI1tz2vzyuwVedgFx9fTsQpBcVChqfiQFQzb4FuZSHIaxEyQW2T3YQu2a3plpVTbu+O+ee4lcbpdUWqqJwXKhnNq09urYiVPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563732; c=relaxed/simple;
	bh=fIsd+POJH173emuvnI8MGIWiD+VNJKbD0DF57uz2rTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZnQreEmcpef5Adn+CnQilFedXYWo3CBYt7HlTz+sV3SWp/6Amtw2pmgygC3ui7IeS65G81DTJz8GO35ZHWJEUrqJrzUVAI/rOHIkJw5SRUiv4sHaCZ5eAIbbZI227ChJpAh2eYNDCDxoIM7p+aUp7L6PsjauH9dSOVhDXircdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 777A6497;
	Thu, 10 Oct 2024 05:35:58 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C41903F58B;
	Thu, 10 Oct 2024 05:35:25 -0700 (PDT)
Message-ID: <c9360dce-559c-4523-b98c-041fc748ce61@arm.com>
Date: Thu, 10 Oct 2024 13:35:24 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] vdso: Introduce vdso/page.h
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241003152910.3287259-1-vincenzo.frascino@arm.com>
 <20241003152910.3287259-3-vincenzo.frascino@arm.com> <87wmihr49g.ffs@tglx>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <87wmihr49g.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/10/2024 10:53, Thomas Gleixner wrote:
> On Thu, Oct 03 2024 at 16:29, Vincenzo Frascino wrote:
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>
>> Introduce vdso/page.h to make sure that the generic library
>> uses only the allowed namespace.
>>
>> Note: on a 32-bit architecture UL is an unsigned 32 bit long. Hence when
>> it supports 64-bit phys_addr_t we might end up in situation in which
>> the
> 
> We end up with nothing.
> 
>> top 32 bit are cleared. To prevent this issue this patch provides
>> separate macros for PAGE_MASK.
> 
> 'this patch' is redundant information.
> 
> git grep 'This patch' Documentation/process/
> 

My bad, I thought that Documentation/process/submitting-patches.rst referred
only to the proposed change which is in imperative mood.

I will rephrase it accordingly.

...

>> +#define PAGE_MASK	(~(PAGE_SIZE-1))
> 
> #define PAGE_MASK	(~(PAGE_SIZE - 1))
> 
> please.
>

Will change it in v4.

> Thanks,
> 
>         tglx

-- 
Regards,
Vincenzo

