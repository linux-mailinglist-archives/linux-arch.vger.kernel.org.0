Return-Path: <linux-arch+bounces-6914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D196889A
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA301F223EF
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7FD19C57C;
	Mon,  2 Sep 2024 13:20:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70B19E965;
	Mon,  2 Sep 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725283200; cv=none; b=h5BOEVis1nO3s+kw916iuQdSgA6vJcr4HgVOowLB7nMOiHVCPPZmsH1L/nU0hCV/wOD+A15lgVeD/FWR1q+K/+FB/BzJJRa4QmtBuXWc+Vdjc2wvh741LtX0fP+lY5xcWy8LYd6t/nsQsOnqHD8TeqnaQ/9QkPr8xvxoMC2zO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725283200; c=relaxed/simple;
	bh=CL9CvstHpgV7WBiph2BCuyi9urSbgPw2GmM7E52T+j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hlSfs9sYsWDFSb8JbNSE1eSWdtMJWtRXgtjU/oo0kLJPPM2bktV3Ai4x45ybgxW3H0B5J6drBDFYZGCtCCvN8vFxaRW85C1ytACcs0KtDPPQLHYZAWZrBshb7qfu1/WzQp55IxiHI4nF/l7ZcWVcREpdz0Hb9pxOZa94vCApfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wy8W127zlz9sSN;
	Mon,  2 Sep 2024 15:19:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JhUY4Y_Xofmu; Mon,  2 Sep 2024 15:19:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wy8W11B1fz9sS7;
	Mon,  2 Sep 2024 15:19:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 17C298B76C;
	Mon,  2 Sep 2024 15:19:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id yFtt-LKodaxA; Mon,  2 Sep 2024 15:19:56 +0200 (CEST)
Received: from [192.168.234.167] (unknown [192.168.234.167])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 726FD8B763;
	Mon,  2 Sep 2024 15:19:56 +0200 (CEST)
Message-ID: <8390ac81-7774-4e67-9739-c2b98813d6da@csgroup.eu>
Date: Mon, 2 Sep 2024 15:19:56 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Cc: Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>,
 ardb@kernel.org
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
 <20240830114645.GA8219@willie-the-truck>
 <963afe11-fd48-4fe9-be70-2e202f836e34@linaro.org>
 <ZtW5meR5iLrkKErJ@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <ZtW5meR5iLrkKErJ@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/09/2024 à 15:11, Jason A. Donenfeld a écrit :
> Hey Christophe (for header logic) & Will (for arm64 stuff),
> 
> On Fri, Aug 30, 2024 at 09:28:29AM -0300, Adhemerval Zanella Netto wrote:
>>>> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
>>>> index 938ca539aaa6..7c9711248d9b 100644
>>>> --- a/lib/vdso/getrandom.c
>>>> +++ b/lib/vdso/getrandom.c
>>>> @@ -5,6 +5,7 @@
>>>>   
>>>>   #include <linux/array_size.h>
>>>>   #include <linux/minmax.h>
>>>> +#include <linux/mm.h>
>>>>   #include <vdso/datapage.h>
>>>>   #include <vdso/getrandom.h>
>>>>   #include <vdso/unaligned.h>
>>>
>>> Looks like this should be a separate change?
>>
>>
>> It is required so arm64 can use  c-getrandom-y, otherwise vgetrandom.o build
>> fails:
>>
>> CC      arch/arm64/kernel/vdso/vgetrandom.o
>> In file included from ./include/uapi/linux/mman.h:5,
>>                   from /mnt/projects/linux/linux-git/lib/vdso/getrandom.c:13,
>>                   from <command-line>:
>> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_prot_bits’:
>> ./arch/arm64/include/asm/mman.h:14:13: error: implicit declaration of function ‘system_supports_bti’ [-Werror=implicit-function-declaration]
>>     14 |         if (system_supports_bti() && (prot & PROT_BTI))
>>        |             ^~~~~~~~~~~~~~~~~~~
>> ./arch/arm64/include/asm/mman.h:15:24: error: ‘VM_ARM64_BTI’ undeclared (first use in this function); did you mean ‘ARM64_BTI’?
>>     15 |                 ret |= VM_ARM64_BTI;
>>        |                        ^~~~~~~~~~~~
>>        |                        ARM64_BTI
>> ./arch/arm64/include/asm/mman.h:15:24: note: each undeclared identifier is reported only once for each function it appears in
>> ./arch/arm64/include/asm/mman.h:17:13: error: implicit declaration of function ‘system_supports_mte’ [-Werror=implicit-function-declaration]
>>     17 |         if (system_supports_mte() && (prot & PROT_MTE))
>>        |             ^~~~~~~~~~~~~~~~~~~
>> ./arch/arm64/include/asm/mman.h:18:24: error: ‘VM_MTE’ undeclared (first use in this function)
>>     18 |                 ret |= VM_MTE;
>>        |                        ^~~~~~
>> ./arch/arm64/include/asm/mman.h: In function ‘arch_calc_vm_flag_bits’:
>> ./arch/arm64/include/asm/mman.h:32:24: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
>>     32 |                 return VM_MTE_ALLOWED;
>>        |                        ^~~~~~~~~~~~~~
>> ./arch/arm64/include/asm/mman.h: In function ‘arch_validate_flags’:
>> ./arch/arm64/include/asm/mman.h:59:29: error: ‘VM_MTE’ undeclared (first use in this function)
>>     59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>>        |                             ^~~~~~
>> ./arch/arm64/include/asm/mman.h:59:52: error: ‘VM_MTE_ALLOWED’ undeclared (first use in this function)
>>     59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
>>        |                                                    ^~~~~~~~~~~~~~
>> arch/arm64/kernel/vdso/vgetrandom.c: In function ‘__kernel_getrandom’:
>> arch/arm64/kernel/vdso/vgetrandom.c:18:25: error: ‘ENOSYS’ undeclared (first use in this function); did you mean ‘ENOSPC’?
>>     18 |                 return -ENOSYS;
>>        |                         ^~~~~~
>>        |                         ENOSPC
>> cc1: some warnings being treated as errors
>>
>> I can move to a different patch, but this is really tied to this patch.
> 
> Adhemerval kept this change in this patch for v3, which, if it's
> necessary, is fine with me. But I was looking to see if there was
> another way of doing it, because including linux/mm.h inside of vdso
> code is kind of contrary to your project with e379299fe0b3 ("random:
> vDSO: minimize and simplify header includes").
> 
> getrandom.c includes uapi/linux/mman.h for the mmap constants. That
> seems fine; it's userspace code after all. But then uapi/linux/mman.h
> has this:
> 
>     #include <asm/mman.h>
>     #include <asm-generic/hugetlb_encode.h>
>     #include <linux/types.h>
> 
> The asm-generic/ one resolves to uapi/asm-generic. But the asm/ one
> resolves to arch code, which is where we then get in trouble on ARM,
> where arch/arm64/include/asm/mman.h has all sorts of kernel code in it.
> 
> Maybe, instead, it should resolve to arch/arm64/include/uapi/asm/mman.h,
> which is the header that userspace actually uses in normal user code?
> 
> Is this a makefile problem? What's going on here? Seems like this is
> something worth sorting out. Or I can take Adhemerval's v3 as-is and
> we'll grit our teeth and work it out later, as you prefer. But I thought
> I should mention it.

That's a tricky problem, I also have it on powerpc, see patch 5, I 
solved it that way:

In the Makefile:
-ccflags-y := -fno-common -fno-builtin
+ccflags-y := -fno-common -fno-builtin -DBUILD_VDSO

In arch/powerpc/include/asm/mman.h:

diff --git a/arch/powerpc/include/asm/mman.h 
b/arch/powerpc/include/asm/mman.h
index 17a77d47ed6d..42a51a993d94 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -6,7 +6,7 @@

  #include <uapi/asm/mman.h>

-#ifdef CONFIG_PPC64
+#if defined(CONFIG_PPC64) && !defined(BUILD_VDSO)

  #include <asm/cputable.h>
  #include <linux/mm.h>

So that the only thing that remains in arch/powerpc/include/asm/mman.h 
when building a VDSO is #include <uapi/asm/mman.h>

I got the idea from ARM64, they use something similar in their 
arch/arm64/include/asm/rwonce.h

Christophe

