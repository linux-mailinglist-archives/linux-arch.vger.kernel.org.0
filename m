Return-Path: <linux-arch+bounces-7109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D662296F324
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997D2286CAC
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513101C9DF7;
	Fri,  6 Sep 2024 11:35:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9531715852B;
	Fri,  6 Sep 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622531; cv=none; b=hsqpx8TAo5K6l2VoEYwDimfVU6y9tV1vDlHw5MUwS8z1y5Upzy3wL/qRUach4bKfU4JfjiwoCLnbUwF20WA7W3R1SddRDn5D/zwtenrqnCF+RWyln7VEIMp5zAyYYXOtyZAweBvzjHjdMrnIDX7n+3mpkEAqNTciM0/qrzgceFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622531; c=relaxed/simple;
	bh=cP5H11M94mDRYEtC3KilSyKz8vdV//0EuGPxUnLCELc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnGc/xRNmaMZzkR0NaSqwMo6KZnlXcf1r+squPtA9QjuCwm88CtXafK0Bl7+oE887l2pAefD2PzZCECi0I/N/dGtEDC5Q0wkvEc5vyr4r+qdFUsYho+Y0qxkAe6/CFxCyVo9NMAxLWfWXnn0g7OJnOY+7EN3rVw7vKYXJ5jGPts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 033B7FEC;
	Fri,  6 Sep 2024 04:35:56 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25FE53F73B;
	Fri,  6 Sep 2024 04:35:25 -0700 (PDT)
Message-ID: <23a1c751-d957-4785-b54d-7e0b03b9117f@arm.com>
Date: Fri, 6 Sep 2024 12:35:25 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] vdso: Introduce vdso/page.h
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
 <20240903151437.1002990-5-vincenzo.frascino@arm.com>
 <18bcf426-b0a8-486b-b9f7-8418d401bb70@csgroup.eu>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <18bcf426-b0a8-486b-b9f7-8418d401bb70@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christophe,

On 04/09/2024 18:16, Christophe Leroy wrote:
> 
> 
> Le 03/09/2024 à 17:14, Vincenzo Frascino a écrit :
>> The VDSO implementation includes headers from outside of the
>> vdso/ namespace.
>>
>> Introduce vdso/page.h to make sure that the generic library
>> uses only the allowed namespace.
>>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>   include/vdso/page.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>   create mode 100644 include/vdso/page.h
>>
>> diff --git a/include/vdso/page.h b/include/vdso/page.h
>> new file mode 100644
>> index 000000000000..f18e304941cb
>> --- /dev/null
>> +++ b/include/vdso/page.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __VDSO_PAGE_H
>> +#define __VDSO_PAGE_H
>> +
>> +#include <asm/vdso/page.h>
> 
> I can't see the benefit of that, the generic library can directly include
> asm/vdso/page.h
> 

I think you agree that any discussion we can have on this point will be made
obsolete by the fact that we will end up defining PAGE_SIZE/PAGE_MASK in
vdso/page.h.

>> +
>> +#endif    /* __VDSO_PAGE_H */

-- 
Regards,
Vincenzo

