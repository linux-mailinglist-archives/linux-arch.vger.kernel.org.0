Return-Path: <linux-arch+bounces-5271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3FF927C35
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 19:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860B8281597
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47832130A5C;
	Thu,  4 Jul 2024 17:26:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4918C131E2D;
	Thu,  4 Jul 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114019; cv=none; b=IiIFn8JH9ZWQB4JfkvyCFx21XvfwanA1af87UoD/S3vRFYOC4CIr9GMHUiJd48aW6lCXHmxt556f+2ZiXgu2/iWBifBb4mNGqGMggg3WVQ7ifnKALdPp+TDwd32KgGkXcX3k5kmDKZkUHtoJPMZKIwbBrUo1s7UayTXZyjKE8lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114019; c=relaxed/simple;
	bh=cz6Upd+dHHABfV89RVRO1EV25BE9bNOPkOXs4JdKxwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQhkCUuWS8PXVEF9oAk/Iz1QLpnbBmax4UV+gh2r3wVpfDrxc4F8mhy5gM8yna9mYYM59VjYOhCU/9iWvCFoKl3bz3aZDOupR4cOxSFqaObWdkUhtxAcO4n7sQxCm42yYZUqAS4cZc4hJIAjRAnhMJEUKpQCvkBEzh759U5rwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF825240003;
	Thu,  4 Jul 2024 17:26:52 +0000 (UTC)
Message-ID: <c6c305a7-37d0-4834-ac65-1ac5d32014d1@ghiti.fr>
Date: Thu, 4 Jul 2024 19:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] riscv: Improve amoswap.X use in xchg()
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
 Andrea Parri <andrea@rivosinc.com>
References: <20240626130347.520750-1-alexghiti@rivosinc.com>
 <20240626130347.520750-8-alexghiti@rivosinc.com> <Zn1wDAXjBdJu48Oi@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <Zn1wDAXjBdJu48Oi@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 27/06/2024 15:58, Andrea Parri wrote:
> On Wed, Jun 26, 2024 at 03:03:44PM +0200, Alexandre Ghiti wrote:
>> xchg() uses amoswap.X instructions from Zabha but still uses
>> the LR/SC acquire/release semantics which require barriers.
>>
>> Let's improve that by using proper amoswap acquire/release semantics in
>> order to avoid any of those barriers.
>>
>> Suggested-by: Andrea Parri <andrea@rivosinc.com>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/cmpxchg.h | 35 +++++++++++++-------------------
>>   1 file changed, 14 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
>> index eb35e2d30a97..0e57d5fbf227 100644
>> --- a/arch/riscv/include/asm/cmpxchg.h
>> +++ b/arch/riscv/include/asm/cmpxchg.h
>> @@ -11,8 +11,8 @@
>>   #include <asm/fence.h>
>>   #include <asm/alternative.h>
>>   
>> -#define __arch_xchg_masked(sc_sfx, swap_sfx, prepend, sc_append,	\
>> -			   swap_append, r, p, n)			\
>> +#define __arch_xchg_masked(sc_sfx, swap_sfx, sc_prepend, sc_append,	\
>> +			   r, p, n)					\
>>   ({									\
>>   	__label__ zabha, end;						\
>>   									\
>> @@ -31,7 +31,7 @@
>>   	ulong __rc;							\
>>   									\
>>   	__asm__ __volatile__ (						\
>> -	       prepend							\
>> +	       sc_prepend							\
>>   	       "0:	lr.w %0, %2\n"					\
>>   	       "	and  %1, %0, %z4\n"				\
>>   	       "	or   %1, %1, %z3\n"				\
>> @@ -48,9 +48,7 @@
>>   zabha:									\
>>   	if (IS_ENABLED(CONFIG_RISCV_ISA_ZABHA)) {			\
>>   		__asm__ __volatile__ (					\
>> -			prepend						\
>>   			"	amoswap" swap_sfx " %0, %z2, %1\n"	\
>> -			swap_append						\
>>   			: "=&r" (r), "+A" (*(p))			\
>>   			: "rJ" (n)					\
>>   			: "memory");					\
>> @@ -58,19 +56,17 @@ zabha:									\
>>   end:;									\
>>   })
>>   
>> -#define __arch_xchg(sfx, prepend, append, r, p, n)			\
>> +#define __arch_xchg(sfx, r, p, n)					\
>>   ({									\
>>   	__asm__ __volatile__ (						\
>> -		prepend							\
>>   		"	amoswap" sfx " %0, %2, %1\n"			\
>> -		append							\
>>   		: "=r" (r), "+A" (*(p))					\
>>   		: "r" (n)						\
>>   		: "memory");						\
>>   })
>>   
>> -#define _arch_xchg(ptr, new, sc_sfx, swap_sfx, prepend,			\
>> -		   sc_append, swap_append)				\
>> +#define _arch_xchg(ptr, new, sc_sfx, swap_sfx,				\
>> +		   sc_prepend, sc_append)				\
>>   ({									\
>>   	__typeof__(ptr) __ptr = (ptr);					\
>>   	__typeof__(*(__ptr)) __new = (new);				\
>> @@ -79,21 +75,19 @@ end:;									\
>>   	switch (sizeof(*__ptr)) {					\
>>   	case 1:								\
>>   		__arch_xchg_masked(sc_sfx, ".b" swap_sfx,		\
>> -				   prepend, sc_append, swap_append,	\
>> +				   sc_prepend, sc_append,		\
>>   				   __ret, __ptr, __new);		\
>>   		break;							\
>>   	case 2:								\
>>   		__arch_xchg_masked(sc_sfx, ".h" swap_sfx,		\
>> -				   prepend, sc_append, swap_append,	\
>> +				   sc_prepend, sc_append,		\
>>   				   __ret, __ptr, __new);		\
>>   		break;							\
>>   	case 4:								\
>> -		__arch_xchg(".w" swap_sfx, prepend, swap_append,	\
>> -			      __ret, __ptr, __new);			\
>> +		__arch_xchg(".w" swap_sfx,  __ret, __ptr, __new);	\
>>   		break;							\
>>   	case 8:								\
>> -		__arch_xchg(".d" swap_sfx, prepend, swap_append,	\
>> -			      __ret, __ptr, __new);			\
>> +		__arch_xchg(".d" swap_sfx,  __ret, __ptr, __new);	\
>>   		break;							\
>>   	default:							\
>>   		BUILD_BUG();						\
>> @@ -102,17 +96,16 @@ end:;									\
>>   })
>>   
>>   #define arch_xchg_relaxed(ptr, x)					\
>> -	_arch_xchg(ptr, x, "", "", "", "", "")
>> +	_arch_xchg(ptr, x, "", "", "", "")
>>   
>>   #define arch_xchg_acquire(ptr, x)					\
>> -	_arch_xchg(ptr, x, "", "", "",					\
>> -		   RISCV_ACQUIRE_BARRIER, RISCV_ACQUIRE_BARRIER)
>> +	_arch_xchg(ptr, x, "", ".aq", "", RISCV_ACQUIRE_BARRIER)
>>   
>>   #define arch_xchg_release(ptr, x)					\
>> -	_arch_xchg(ptr, x, "", "", RISCV_RELEASE_BARRIER, "", "")
>> +	_arch_xchg(ptr, x, "", ".rl", RISCV_RELEASE_BARRIER, "")
>>   
>>   #define arch_xchg(ptr, x)						\
>> -	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER, "")
>> +	_arch_xchg(ptr, x, ".rl", ".aqrl", "", RISCV_FULL_BARRIER)
> I actually see no reason for this patch, please see also my remarks
> /question on patch #4.


You mean that we can't improve the fully-ordered version here?


>
>    Andrea
>

