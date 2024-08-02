Return-Path: <linux-arch+bounces-5910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022AC945A53
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 10:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95BD285D69
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 08:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02E1C8227;
	Fri,  2 Aug 2024 08:59:01 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBC1C7B9D;
	Fri,  2 Aug 2024 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589141; cv=none; b=PrmPhFdoNEMlcD19U1ByUoSVR3AfxclIgIDYjgKseaUhsI9KjcTK4XKlMMetbFBOTy67wSXTlkagd59d8jFR3J/yPONgEvSC2KxCVRH3pcLFStMrFAcBSzHnOx/bYl0MZxurOVqNS6sTu0fBFH5dXgUsXgTEqp1YLdDtW4UD/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589141; c=relaxed/simple;
	bh=dbKN0+MqNrFpMCkf55bs3q79x4n4B1Fo54lJuYi4g80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xj/e8jKkhFfDeh2mJY15Oe3Pw0991qayJ652GVb27VTHaTNj/Px8rK9joOdczYNrQ1XdSdqPmWGXgbgSU58JncRbilTnKR9i8nhvak7mK7fOEX1Xv7gRiQcZBaviJLzKlVnWsMML9F60lZrJfnWGzZZXZeno+hIgNobua2HzjY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 281D91C000E;
	Fri,  2 Aug 2024 08:58:51 +0000 (UTC)
Message-ID: <0abc375c-61a1-4b8c-bac5-a5dc170c5fb6@ghiti.fr>
Date: Fri, 2 Aug 2024 10:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Andrea Parri <parri.andrea@gmail.com>, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
 Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com>
 <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubhQefQ6i3Vow_p-uSACQyPcMJNC2UwB99xt_=jDtRUDFw@mail.gmail.com>
 <20240801-e773d3752fe8b5484405d404@orel>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240801-e773d3752fe8b5484405d404@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr


On 01/08/2024 12:15, Andrew Jones wrote:
> On Thu, Aug 01, 2024 at 10:43:03AM GMT, Alexandre Ghiti wrote:
> ...
>>>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
>>>> index 0655aa5b57b2..bf47cca2c375 100644
>>>> --- a/include/asm-generic/qspinlock.h
>>>> +++ b/include/asm-generic/qspinlock.h
>>>> @@ -136,6 +136,7 @@ static __always_inline bool virt_spin_lock(struct qspinlock *lock)
>>>>   }
>>>>   #endif
>>>>
>>>> +#ifndef __no_arch_spinlock_redefine
>>> I'm not sure what's better/worse, but instead of inventing this
>>> __no_arch_spinlock_redefine thing we could just name all the functions
>>> something like __arch_spin* and then add defines for both to asm/spinlock.h,
>>> i.e.
>>>
>>> #define queued_spin_lock(l) __arch_spin_lock(l)
>>> ...
>>>
>>> #define ticket_spin_lock(l) __arch_spin_lock(l)
>>> ...
>> __arch_spin_lock() would use queued_spin_lock() so that would make an
>> "infinite recursive definition" right? And that would override the
>> "real" queued_spin_lock() implementation too.
>>
>> But maybe I missed something!
>>
> It depends on where the definition is done. It should work if the
> preprocessor expands the implementation of __arch_spin_* before
> evaluating the #define of queued_spin_*. IOW, we just need to put
> the defines after the static inline constructions.


So I have just given it a try, both qspinlock.h and ticket_spinlock.h 
define arch_spin_XXXX(). That triggers a bunch of warnings.

I'll drop this suggestion as I find it harder to understand and because 
of the warnings that would need the introduction of a new preprocessor 
variable (or something else?).  And the solution with 
__no_arch_spinlock_redefine is really straightforward and lightweight.

Thanks,

Alex


>
> Thanks,
> drew
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

