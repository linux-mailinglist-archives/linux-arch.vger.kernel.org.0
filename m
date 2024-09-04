Return-Path: <linux-arch+bounces-7013-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E1996C1B9
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2721C21107
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DE91DC1B5;
	Wed,  4 Sep 2024 15:05:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476E1DA2FE;
	Wed,  4 Sep 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462330; cv=none; b=J3c1E4rDyVMa7jlFWbff3l915rjIh/6Fogz1vqPJuEgwnPf+tlk/lI+wTmlFS8K2UX9YEobN4U1NS7koHnjXl4X5vgv5gfWKnLStEh4SsIehcgS2cDkfxEUFZDnMrY6hSQsbLxOVhjrD2N3zAK5ghNNWS1ywUjTQzFgup6izcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462330; c=relaxed/simple;
	bh=f+0vRXoih0EUpPP0SzBjRwhKHqCaRkEfFTPGXPO5bZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOfWwB2CyewJVBMrFesfHP3Q7dI8ZilMoCH85WCZOTEOFvsGjZkYg7fvqANwWAieeeBiU8AgFY774qrxqRxgXQb44v7uZ7VReMaYn6KNRA6GhdP72liyMePYMQIil53J+tu1Icm9gkLTy4y3i81RzzQQFo4L7pwoxgoOv4KzJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WzQlj02Xdz9sS7;
	Wed,  4 Sep 2024 17:05:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6oFgwZsIkdDQ; Wed,  4 Sep 2024 17:05:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WzQlh6HLQz9sRy;
	Wed,  4 Sep 2024 17:05:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C48C38B77A;
	Wed,  4 Sep 2024 17:05:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id E_t6YZIKUyZe; Wed,  4 Sep 2024 17:05:20 +0200 (CEST)
Received: from [192.168.234.246] (unknown [192.168.234.246])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EB1F68B778;
	Wed,  4 Sep 2024 17:05:19 +0200 (CEST)
Message-ID: <a298ba4e-cbbf-4f50-b175-8ee3063963bc@csgroup.eu>
Date: Wed, 4 Sep 2024 17:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] x86: vdso: Introduce asm/vdso/page.h
To: Arnd Bergmann <arnd@arndb.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kernel@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cfb5ea05-0322-492b-815d-17a4aad4da99@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/09/2024 à 16:52, Arnd Bergmann a écrit :
> On Tue, Sep 3, 2024, at 15:14, Vincenzo Frascino wrote:
> 
>> diff --git a/arch/x86/include/asm/vdso/page.h b/arch/x86/include/asm/vdso/page.h
>> new file mode 100644
>> index 000000000000..b0af8fbef27c
>> --- /dev/null
>> +++ b/arch/x86/include/asm/vdso/page.h
>> @@ -0,0 +1,15 @@
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
> 
> Why not put PAGE_MASK and PAGE_SIZE into a global vdso/page.h
> header? I did spend a lot of time a few months ago ensuring that
> we can have a single definition for all architectures based on
> CONFIG_PAGE_SHIFT, so all the extra copies should just go away.
> 

Just wondering, after looking at x86, powerpc and arm64, is there any 
difference between:

X86,ARM64:
#define PAGE_SIZE		(_AC(1,UL) << PAGE_SHIFT)
#define PAGE_MASK		(~(PAGE_SIZE-1))

POWERPC:
#define PAGE_SIZE		(ASM_CONST(1) << PAGE_SHIFT)
/*
  * Subtle: (1 << PAGE_SHIFT) is an int, not an unsigned long. So if we
  * assign PAGE_MASK to a larger type it gets extended the way we want
  * (i.e. with 1s in the high bits)
  */
#define PAGE_MASK      (~((1 << PAGE_SHIFT) - 1))


Which one should be taken in vdso/page.h ?

Christophe

