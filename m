Return-Path: <linux-arch+bounces-7107-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4FF96F2C6
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 13:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E362845BF
	for <lists+linux-arch@lfdr.de>; Fri,  6 Sep 2024 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C721C9EC2;
	Fri,  6 Sep 2024 11:20:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B071C9DD3;
	Fri,  6 Sep 2024 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621639; cv=none; b=aGK8sIDUYO3xp47fXP5SmUORLMAWuxxnjqHURUTKtieJPXc7gh7Kg2u8TFAlaGP8u8HvfN1a7sREeq8wbEGnHsZaM6BWmD1702qAGakuFWUrXDIMvYO4I5VIbIKuJVBo6CWsbGTyHlb7GybBnE3GiKJ0IndnAnbAXrFdKkZ2LW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621639; c=relaxed/simple;
	bh=mIHJpvtc1pvXP0bXeu1vqC5AbvaqUlDnq2I+EvE1FqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdYbNlpF1DAJVUyq+r/rYRT6fIoOHRSrShTnQ2fZGrRPLH+/IK8RAcTog61oxORmtEipiZOTuMU2Fd8aK0nBxKeZIfUIjphZqgwYeB5foVflKywC4kE9bntP0SOXRG2EJH4mGhiu0jb0v1iCel+NDWSqaF5bOVFyaEQM5xKkRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 539ED113E;
	Fri,  6 Sep 2024 04:21:03 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86F7C3F73B;
	Fri,  6 Sep 2024 04:20:33 -0700 (PDT)
Message-ID: <e28e1974-cced-462c-8f57-ca1474272e73@arm.com>
Date: Fri, 6 Sep 2024 12:20:31 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
To: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Naveen N Rao <naveen@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>,
 Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20240903151437.1002990-1-vincenzo.frascino@arm.com>
 <20240903151437.1002990-4-vincenzo.frascino@arm.com>
 <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
Content-Language: en-US
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arnd,

On 04/09/2024 15:52, Arnd Bergmann wrote:
> On Tue, Sep 3, 2024, at 15:14, Vincenzo Frascino wrote:
> 

...

>> +
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_VDSO_PAGE_H
>> +#define __ASM_VDSO_PAGE_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <asm/page_types.h>
>> +
>> +#define VDSO_PAGE_MASK	PAGE_MASK
>> +#define VDSO_PAGE_SIZE	PAGE_SIZE
>> +
>> +#endif /* !__ASSEMBLY__ */
>> +
>> +#endif /* __ASM_VDSO_PAGE_H */
> 
> I don't get this one: the x86 asm/page_types.h still includes other
> headers outside of the vdso namespace, but you seem to only need these
> two definitions that are the same across everything.
> > Why not put PAGE_MASK and PAGE_SIZE into a global vdso/page.h
> header? I did spend a lot of time a few months ago ensuring that
> we can have a single definition for all architectures based on
> CONFIG_PAGE_SHIFT, so all the extra copies should just go away.
> 
>        Arnd
Looking at the definition of PAGE_SIZE and PAGE_MASK for each architecture they
all depend on CONFIG_PAGE_SHIFT but they are slightly different, e.g.:

x86:
#define PAGE_SIZE        (_AC(1,UL) << PAGE_SHIFT)

powerpc:
#define PAGE_SIZE        (ASM_CONST(1) << PAGE_SHIFT)

hence I left to the architecture the responsibility of redefining the constants
for the VSDO.

As a long term plan I would like to simplify the code and have a single
definition as you are saying in vdso/page.h for both the macros. But my
preference would be to post it as a separate series so that I can focus more on
validating it properly.

-- 
Regards,
Vincenzo

