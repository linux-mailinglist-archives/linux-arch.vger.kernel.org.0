Return-Path: <linux-arch+bounces-7452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7896986C25
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 07:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43DCBB24A2C
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2024 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A982488;
	Thu, 26 Sep 2024 05:52:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34E4145346;
	Thu, 26 Sep 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727329924; cv=none; b=BwsvYu0gVTRCPa+tTIYRpw8HBx7jCoXQVJqimIdk3QR5Fgt7UmSn/I0b84nDzMT/iePOEES94o+Pz4eiNUMf/PMJfJ9p+0sWEnU2U2DFDj+9TdJeyr53Zv77vpYcWdU7fnPY3lbB6yf/BXu8jgRHAl3XjqmLNUI3IHEM1rT/xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727329924; c=relaxed/simple;
	bh=pDRHhmxVEt5GUk7JtGPzDbnjf5NNfChyQCgN3YFNodw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNTRH9nJO5Jsi3TRdNJrLOuf5NEt8RCOXCNLUUT2a0RIieQhYxdF1KW238pY+udcjQw0awwZbzvpezausl3OAFKYzasvadpxeaDJghN90Xg4K7CbuOU6XStNnLmcYiv/7DMtQp6cBU2BaQhQa/WMP9aOpjj5iGSIRgOcQHc95sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XDjQy68Zfz9sSK;
	Thu, 26 Sep 2024 07:51:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nIapQb6SH8TJ; Thu, 26 Sep 2024 07:51:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XDjQy50hbz9sRy;
	Thu, 26 Sep 2024 07:51:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 92DE98B76E;
	Thu, 26 Sep 2024 07:51:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id aQV3KcvF_OW9; Thu, 26 Sep 2024 07:51:54 +0200 (CEST)
Received: from [172.25.230.108] (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E52B8B763;
	Thu, 26 Sep 2024 07:51:54 +0200 (CEST)
Message-ID: <fb5f8856-5753-4b2b-bfed-82b3e3cd589e@csgroup.eu>
Date: Thu, 26 Sep 2024 07:51:53 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] x86: vdso: Introduce asm/vdso/mman.h
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
References: <20240923141943.133551-1-vincenzo.frascino@arm.com>
 <20240923141943.133551-2-vincenzo.frascino@arm.com>
 <626baa55-ca84-49ba-9131-c1657e0c0454@csgroup.eu>
 <fe23745e-a965-4b74-863d-9479fdef239f@app.fastmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <fe23745e-a965-4b74-863d-9479fdef239f@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/09/2024 à 23:23, Arnd Bergmann a écrit :
> On Wed, Sep 25, 2024, at 06:51, Christophe Leroy wrote:
>> Le 23/09/2024 à 16:19, Vincenzo Frascino a écrit :
>>> @@ -0,0 +1,15 @@
>>> +
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +#ifndef __ASM_VDSO_MMAN_H
>>> +#define __ASM_VDSO_MMAN_H
>>> +
>>> +#ifndef __ASSEMBLY__
>>> +
>>> +#include <uapi/linux/mman.h>
>>> +
>>> +#define VDSO_MMAP_PROT	PROT_READ | PROT_WRITE
>>> +#define VDSO_MMAP_FLAGS	MAP_DROPPABLE | MAP_ANONYMOUS
>>
>> I still can't see the point with that change.
>>
>> Today 4 architectures implement getrandom and none of them require that
>> indirection. Please leave prot and flags as they are in the code.
>>
>> Then this file is totally pointless, VDSO code can include
>> uapi/linux/mman.h directly.
>>
>> VDSO is userland code, it should be safe to include any UAPI file there.
> 
> I think we are hitting an unfortunate corner case in the build
> system here, based on the way we handle the uapi/ file namespace
> in the kernel:
> 
> include/uapi/linux/mman.h includes three headers: asm/mman.h,
> asm-generic/hugetlb_encode.h and linux/types.h. Two of these
> exist in both include/uapi/ and include/, so while building
> kernel code we end up picking up the non-uapi version which
> on some architectures includes many other headers.

Right, and that's the reason why arm64 and powerpc guarded the content 
of asm/mman.h which an #ifndef BUILD_VDSO.

Note that arm64 also has a similar workaround in asm/rwonce.h, brought 
by commit e35123d83ee3 ("arm64: lto: Strengthen READ_ONCE() to acquire 
when CONFIG_LTO=y") without explaination on why VDSO builds are excluded.

> 
> I agree that moving the contents out of uapi/ into vdso/ namespace
> is not a solution here because that removes the contents from
> the installed user headers, but we still need to do something
> to solve the issue.

Should header inclusion be reworked so that only UAPI and VDSO pathes 
are looked for when including headers in VDSO builds ?

> 
> The easiest workaround I see for this particular file is to
> move the contents of arch/{arm,arm64,parisc,powerpc,sparc,x86}/\
> include/asm/mman.h into a different file to ensure that the
> only existing file is the uapi/ one. Unfortunately this does
> not help to avoid it regressing again in the future.

Could we add a check in checkpatch.pl to ensure UAPI headers do not 
include headers that exist both in UAPI and non-UAPI space in the future ?

Christophe

