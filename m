Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2E1212E64
	for <lists+linux-arch@lfdr.de>; Thu,  2 Jul 2020 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGBVBP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Jul 2020 17:01:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46018 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbgGBVBN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 17:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593723671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qmj46YtkbL+I9zTq7ntIIfxROQfpX1hCxEUSvoiv0+I=;
        b=g/xM+BLgrovoby+kviRdN9Dkc3icGTjpRo+QrEq8owbsyP32i++gvpMnYQpeLLw4V3T1e+
        e7g84wuN30iRfIp7Ut5vuEwGctwXEdwiqRUSY9d92x29y3q5DOIFrWgIhQw11pFlxYR2pK
        MOvXa3DgXt6Noj9hJqKiM1PBWylxfCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-mkvppFasMUC-xIraJrAEgA-1; Thu, 02 Jul 2020 17:01:09 -0400
X-MC-Unique: mkvppFasMUC-xIraJrAEgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17FAA107ACF7;
        Thu,  2 Jul 2020 21:01:08 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-66.rdu2.redhat.com [10.10.118.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9FBE77899;
        Thu,  2 Jul 2020 21:01:06 +0000 (UTC)
Subject: Re: [PATCH 6/8] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-7-npiggin@gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <6b8ccb02-53ca-35d2-0dc6-2fc8e5523a97@redhat.com>
Date:   Thu, 2 Jul 2020 17:01:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200702074839.1057733-7-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 7/2/20 3:48 AM, Nicholas Piggin wrote:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/powerpc/include/asm/paravirt.h           | 23 ++++++++
>   arch/powerpc/include/asm/qspinlock.h          | 55 +++++++++++++++++++
>   arch/powerpc/include/asm/qspinlock_paravirt.h |  5 ++
>   arch/powerpc/platforms/pseries/Kconfig        |  5 ++
>   arch/powerpc/platforms/pseries/setup.c        |  6 +-
>   include/asm-generic/qspinlock.h               |  2 +
>   6 files changed, 95 insertions(+), 1 deletion(-)
>   create mode 100644 arch/powerpc/include/asm/qspinlock_paravirt.h
>
> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
> index 7a8546660a63..5fae9dfa6fe9 100644
> --- a/arch/powerpc/include/asm/paravirt.h
> +++ b/arch/powerpc/include/asm/paravirt.h
> @@ -29,6 +29,16 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
>   {
>   	plpar_hcall_norets(H_CONFER, get_hard_smp_processor_id(cpu), yield_count);
>   }
> +
> +static inline void prod_cpu(int cpu)
> +{
> +	plpar_hcall_norets(H_PROD, get_hard_smp_processor_id(cpu));
> +}
> +
> +static inline void yield_to_any(void)
> +{
> +	plpar_hcall_norets(H_CONFER, -1, 0);
> +}
>   #else
>   static inline bool is_shared_processor(void)
>   {
> @@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yield_count)
>   {
>   	___bad_yield_to_preempted(); /* This would be a bug */
>   }
> +
> +extern void ___bad_yield_to_any(void);
> +static inline void yield_to_any(void)
> +{
> +	___bad_yield_to_any(); /* This would be a bug */
> +}
> +
> +extern void ___bad_prod_cpu(void);
> +static inline void prod_cpu(int cpu)
> +{
> +	___bad_prod_cpu(); /* This would be a bug */
> +}
> +
>   #endif
>   
>   #define vcpu_is_preempted vcpu_is_preempted
> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
> index f84da77b6bb7..997a9a32df77 100644
> --- a/arch/powerpc/include/asm/qspinlock.h
> +++ b/arch/powerpc/include/asm/qspinlock.h
> @@ -3,9 +3,36 @@
>   #define _ASM_POWERPC_QSPINLOCK_H
>   
>   #include <asm-generic/qspinlock_types.h>
> +#include <asm/paravirt.h>
>   
>   #define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>   
> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
> +extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
> +
> +static __always_inline void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> +{
> +	if (!is_shared_processor())
> +		native_queued_spin_lock_slowpath(lock, val);
> +	else
> +		__pv_queued_spin_lock_slowpath(lock, val);
> +}

You may need to match the use of __pv_queued_spin_lock_slowpath() with 
the corresponding __pv_queued_spin_unlock(), e.g.

#define queued_spin_unlock queued_spin_unlock
static inline queued_spin_unlock(struct qspinlock *lock)
{
         if (!is_shared_processor())
                 smp_store_release(&lock->locked, 0);
         else
                 __pv_queued_spin_unlock(lock);
}

Otherwise, pv_kick() will never be called.

Cheers,
Longman

