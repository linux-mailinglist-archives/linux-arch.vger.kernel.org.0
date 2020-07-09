Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B793421A456
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGIQGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 12:06:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25391 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgGIQGV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 12:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594310780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OfLVV9ee+e3aH9dIq9Uyj1RNa4dEfM45FxDPLW9s5s=;
        b=U1PwqBpIDqjpaQE2/Sxo3rHKaQCUfFFj278lqj3OcdsMrJvioMXFPFAvL8ZgD7+K+ed5Qf
        ePH/rhndKNFkhcvz7PmNB/hu/glzi8xSnFirFKowWhe8hPDQUkvyFQtorSFaoWdMsA6Ll0
        +3la+EIrl4vOvnxy/Ei411EdgvG++eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-3cdqq7fgOK-wggAAqi1Q3w-1; Thu, 09 Jul 2020 12:06:17 -0400
X-MC-Unique: 3cdqq7fgOK-wggAAqi1Q3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A94100AA21;
        Thu,  9 Jul 2020 16:06:15 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-122.rdu2.redhat.com [10.10.120.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB60179CE7;
        Thu,  9 Jul 2020 16:06:13 +0000 (UTC)
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
Date:   Thu, 9 Jul 2020 12:06:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <874kqhvu1v.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/9/20 6:53 AM, Michael Ellerman wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   arch/powerpc/include/asm/paravirt.h           | 28 ++++++++
>>   arch/powerpc/include/asm/qspinlock.h          | 66 +++++++++++++++++++
>>   arch/powerpc/include/asm/qspinlock_paravirt.h |  7 ++
>>   arch/powerpc/platforms/pseries/Kconfig        |  5 ++
>>   arch/powerpc/platforms/pseries/setup.c        |  6 +-
>>   include/asm-generic/qspinlock.h               |  2 +
> Another ack?
>
I am OK with adding the #ifdef around queued_spin_lock().

Acked-by: Waiman Long <longman@redhat.com>

>> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
>> index 7a8546660a63..f2d51f929cf5 100644
>> --- a/arch/powerpc/include/asm/paravirt.h
>> +++ b/arch/powerpc/include/asm/paravirt.h
>> @@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
>>   {
>>   	___bad_yield_to_preempted(); /* This would be a bug */
>>   }
>> +
>> +extern void ___bad_yield_to_any(void);
>> +static inline void yield_to_any(void)
>> +{
>> +	___bad_yield_to_any(); /* This would be a bug */
>> +}
> Why do we do that rather than just not defining yield_to_any() at all
> and letting the build fail on that?
>
> There's a condition somewhere that we know will false at compile time
> and drop the call before linking?
>
>> diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
>> new file mode 100644
>> index 000000000000..750d1b5e0202
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef __ASM_QSPINLOCK_PARAVIRT_H
>> +#define __ASM_QSPINLOCK_PARAVIRT_H
> _ASM_POWERPC_QSPINLOCK_PARAVIRT_H please.
>
>> +
>> +EXPORT_SYMBOL(__pv_queued_spin_unlock);
> Why's that in a header? Should that (eventually) go with the generic implementation?
The PV qspinlock implementation is not that generic at the moment. Even 
though native qspinlock is used by a number of archs, PV qspinlock is 
only currently used in x86. This is certainly an area that needs 
improvement.
>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>> index 24c18362e5ea..756e727b383f 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>> @@ -25,9 +25,14 @@ config PPC_PSERIES
>>   	select SWIOTLB
>>   	default y
>>   
>> +config PARAVIRT_SPINLOCKS
>> +	bool
>> +	default n
> default n is the default.
>
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index 2db8469e475f..747a203d9453 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -771,8 +771,12 @@ static void __init pSeries_setup_arch(void)
>>   	if (firmware_has_feature(FW_FEATURE_LPAR)) {
>>   		vpa_init(boot_cpuid);
>>   
>> -		if (lppaca_shared_proc(get_lppaca()))
>> +		if (lppaca_shared_proc(get_lppaca())) {
>>   			static_branch_enable(&shared_processor);
>> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>> +			pv_spinlocks_init();
>> +#endif
>> +		}
> We could avoid the ifdef with this I think?
>
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 434615f1d761..6ec72282888d 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -10,5 +10,9 @@
>   #include <asm/simple_spinlock.h>
>   #endif
>
> +#ifndef CONFIG_PARAVIRT_SPINLOCKS
> +static inline void pv_spinlocks_init(void) { }
> +#endif
> +
>   #endif /* __KERNEL__ */
>   #endif /* __ASM_SPINLOCK_H */
>
>
> cheers
>
We don't really need to do a pv_spinlocks_init() if pv_kick() isn't 
supported.

Cheers,
Longman

