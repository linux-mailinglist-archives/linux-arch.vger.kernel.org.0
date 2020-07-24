Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E38F22BDD0
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 07:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGXF7m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Jul 2020 01:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgGXF7m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 01:59:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA86C0619D3;
        Thu, 23 Jul 2020 22:59:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so3899036plo.3;
        Thu, 23 Jul 2020 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=2R0lW9dUL1nYb/9lgperk2g748vxQMNCmmnNHRKkl+M=;
        b=Pb4/uDyqpRTTP9b3ebYsdYcsxNScuYdJIPeDBdZdQ0oiVxIw9UIdugSoUtLX7SJ1/B
         3Xdajmy3uy5LYrQAe1LgIUmt9GE2Vm15HXVAfbSCg3F0Qeru3fAvX3RNB/iMTCee5YEf
         Adelh56xJuUYcwoXbqlzhH99jqeA0YOu72J/OiCuy0fBv5rjilfboH5Vdua2NoTnkgaP
         NSculWvNNeRGDKrLDX9WSmf3+GTuvKrepedSaFzEn9p46GRTm21RRPTHKGRdD+k0n+GM
         ofGi26OjkkbLfQt5mu++mN1BJa3/e/9cUcmQdOHUK+ZigZC4XvuAIo2C03brXMwXU575
         EKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=2R0lW9dUL1nYb/9lgperk2g748vxQMNCmmnNHRKkl+M=;
        b=duXxVlKM+S1f/30IaC9ZK8TtJeP5va/zq/uO1kGarvC3A7HVu/7uIMSn9XlW+wvlUj
         Ez/+6+w2/ro7EC2DpaS21tfGKd5diz4uAh/9puM/Smiid/fg2bRQdgoqHm4Di2DLAldL
         2Rpcl3l4oF1YUyu5ogpbEsoSsMCPsS+c9qTdQxIhzKBgjVQbHH1nuSrnlSxd/UEK9i/K
         V1E/IGPUwzQDYfLHp30wOLuaMVcd+hTKeD6NiFDOpvQesLJsYxckIBYMz71J7Bf91ujO
         IkjfJ/IIk0golrsvlTB8hwH4ozWrN7t9YeX9LaKdqu4P1o2cBS5Mozz9F4djZplM2vFz
         4gdg==
X-Gm-Message-State: AOAM531oxNj5JbQHpbIHwl2hqN3vF4m3ENfnOjGnrphaqQQn1uTrnADI
        pvp7Ail1fG5JuTMbAdMIVaK7zFWU
X-Google-Smtp-Source: ABdhPJxbeH9FlO3dIACKcXGFcLekN350jP0rI0GOjOvxK+MH/SPj/LKJY2RwdAnGdzEYCg0FKF+/iQ==
X-Received: by 2002:a17:902:6181:: with SMTP id u1mr6767335plj.205.1595570381925;
        Thu, 23 Jul 2020 22:59:41 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id y24sm4966404pfp.217.2020.07.23.22.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 22:59:41 -0700 (PDT)
Date:   Fri, 24 Jul 2020 15:59:35 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200723114010.GO5523@worktop.programming.kicks-ass.net>
        <1595506730.3mvrxktem5.astroid@bobo.none>
        <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
In-Reply-To: <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
MIME-Version: 1.0
Message-Id: <1595568105.4eodjnxzwp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Alexey Kardashevskiy's message of July 24, 2020 2:16 pm:
>=20
>=20
> On 23/07/2020 23:11, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
>>> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>>>
>>>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/=
asm/hw_irq.h
>>>> index 3a0db7b0b46e..35060be09073 100644
>>>> --- a/arch/powerpc/include/asm/hw_irq.h
>>>> +++ b/arch/powerpc/include/asm/hw_irq.h
>>>> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>>>>  #define powerpc_local_irq_pmu_save(flags)			\
>>>>  	 do {							\
>>>>  		raw_local_irq_pmu_save(flags);			\
>>>> -		trace_hardirqs_off();				\
>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>> +			trace_hardirqs_off();			\
>>>>  	} while(0)
>>>>  #define powerpc_local_irq_pmu_restore(flags)			\
>>>>  	do {							\
>>>> -		if (raw_irqs_disabled_flags(flags)) {		\
>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>> -			trace_hardirqs_off();			\
>>>> -		} else {					\
>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>>  			trace_hardirqs_on();			\
>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>> -		}						\
>>>> +		raw_local_irq_pmu_restore(flags);		\
>>>>  	} while(0)
>>>
>>> You shouldn't be calling lockdep from NMI context!
>>=20
>> After this patch it doesn't.
>>=20
>> trace_hardirqs_on/off implementation appears to expect to be called in N=
MI=20
>> context though, for some reason.
>>=20
>>> That is, I recently
>>> added suport for that on x86:
>>>
>>>   https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
>>>   https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
>>>
>>> But you need to be very careful on how you order things, as you can see
>>> the above relies on preempt_count() already having been incremented wit=
h
>>> NMI_MASK.
>>=20
>> Hmm. My patch seems simpler.
>=20
> And your patches fix my error while Peter's do not:
>=20
>=20
> IRQs not enabled as expected
> WARNING: CPU: 0 PID: 1377 at /home/aik/p/kernel/kernel/softirq.c:169
> __local_bh_enable_ip+0x118/0x190

I think they would have needed some powerpc bits as well. But I don't
see a reason we can't merge my patches, at least they fix this case and
don't seem to make things worse in any way.

Thanks,
Nick
