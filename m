Return-Path: <linux-arch+bounces-7113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF2096F382
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C781F25735
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C91CC150;
	Fri,  6 Sep 2024 11:48:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3A1CBE8A;
	Fri,  6 Sep 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623300; cv=none; b=lz1kSWnwvNDn08c1yiVmjxJ9PbL0cHE1WOyxVQxwb/jGSEuRY1Fza6qW6Q2JmHnP+vBVP90bgCZXNnk976X4yj7LykeKjDPQpppKobGrI1FzAVjCO4zcZDqFlMTwEAc7JJlvhjMr7TqsebT7etpce8qDrMXiCGF92NYZJVBiO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623300; c=relaxed/simple;
	bh=4ClbQmfpxydj6Dcl8lMspojV/o8trKHqXTKFjuewnLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBAUMJKvZcOoThwJmi77Xqdk8g+cInqoRypzy4nlZcegAcXaFifKKlEBw5r6VJM2eaLNnIvbRlDJ3KMqJPj/xx+MVSUKi1tOPZEfm9aR2WfGRc4Ncl19fRvA0B+eckndztSs8y7EsJPFis2Rl2+4gT+CxYwWDWP8uTViMi6T32c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEB57113E;
	Fri,  6 Sep 2024 04:48:45 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D50573F73B;
	Fri,  6 Sep 2024 04:48:15 -0700 (PDT)
Message-ID: <2d11332c-1575-419c-af49-de9cb36dcabf@arm.com>
Date: Fri, 6 Sep 2024 12:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] x86: vdso: Modify asm/vdso/getrandom.h to include
 datapage
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-8-vincenzo.frascino@arm.com>
 <ebb01fce-aea5-4d82-b8b9-2e30f534b54c@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <ebb01fce-aea5-4d82-b8b9-2e30f534b54c@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/09/2024 18:19, Christophe Leroy wrote:
> 
> 
> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>
>> Modify asm/vdso/getrandom.h to include datapage.
> 
> Does  asm/vdso/getrandom.h need datapage ? If not it is the ones that need it
> that should include it.
>

Why do you think it does not need it?

>>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   arch/x86/include/asm/vdso/getrandom.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/vdso/getrandom.h
>> b/arch/x86/include/asm/vdso/getrandom.h
>> index ff5334ad32a0..4597d5a6f094 100644
>> --- a/arch/x86/include/asm/vdso/getrandom.h
>> +++ b/arch/x86/include/asm/vdso/getrandom.h
>> @@ -7,6 +7,8 @@
>>     #ifndef __ASSEMBLY__
>>   +#include <vdso/datapage.h>
>> +
>>   #include <asm/unistd.h>
>>   #include <asm/vvar.h>
>>   

-- 
Regards,
Vincenzo

