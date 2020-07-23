Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B232622B107
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 16:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGWOJ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgGWOJz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 10:09:55 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0479C0619DC;
        Thu, 23 Jul 2020 07:09:55 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s189so3153216pgc.13;
        Thu, 23 Jul 2020 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=QQ+1Br77BLz8lQjoivkzwXKzJFU6kfi+6X+tKUpNas4=;
        b=VrjaKnJdpR1Q8/zxNQwaywYVL4aRO5VkRzHmFjYwybGM9tx089/g1Ffv46QKdc+RUs
         R6DCZA9k7t+FSZ+Mx0vuWBZYJQ3WTcoGb0I4V6VpiEKCbu9AdTetnakuIydsSwfoz2+j
         l9EEEwDmIUWZaHP8Ud2g2is+SUIFouXgPyKbBKXnQFdCHgwraxGL1m6ZgEJgDc8Y5tPM
         A9btbBCW4lz7/PYi8S0j5NpaOSvPfDMwrMQ9KKnOcxBdZWT/pclllFueGNwszxTu6NYA
         M65pHDPqBZpoRwWQi+vBgtEGz3FonNJXLnNsaxu5yE/7TsVl63Qg3ZTXw78Xo8A9jJtj
         DI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=QQ+1Br77BLz8lQjoivkzwXKzJFU6kfi+6X+tKUpNas4=;
        b=YZmZBSJlNjpgxHp26SH9siM08cWzI0Jnz0fs9lg8OEal0jEMhr8JHs5lMQYc4I40QE
         srF636l0Mp8d2p7B1CEzY/RxXwDKTLWnanoDIE6dPO0e2TwM4dpj1YG+u0yv3jSwsktB
         O/PwpKUIjNzcorBhEizuyF45wp1cMPpm+W+o9mHSIx8Nwjsy7aTzmO/nTTHCTNgCyY32
         R5juYZl3JGvmPx757hzIwFDxfwYq9P5R1AgA5tDzQcJtuskLE/Cpb7QhCfgl39xz60a4
         BtHZHVWNYwxca62rA3ROSXHOrYDS1eJHJB6RqiMVttavnXJwsd3OBznHLsy6uvMe9D0a
         rgYg==
X-Gm-Message-State: AOAM530KN1Uywyz8Qsa0o51scKmOFSI3iNvW3YTwIQnKgpjjKRKNesI3
        Ij8hpLG/L1KEYJKsU4OPo3g=
X-Google-Smtp-Source: ABdhPJz9Ux/xe9gUmHJptXyzmvpTWCDbn3NSD1ykHJ9GcvjlxMgG8/bFHnuOpReypGSbZRKQ2OYRGA==
X-Received: by 2002:a63:ca11:: with SMTP id n17mr4276124pgi.439.1595513395017;
        Thu, 23 Jul 2020 07:09:55 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id q4sm3208683pjq.36.2020.07.23.07.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 07:09:54 -0700 (PDT)
Date:   Fri, 24 Jul 2020 00:09:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks for
 SPLPAR
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Anton Blanchard <anton@ozlabs.org>,
        Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        virtualization@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
References: <20200706043540.1563616-1-npiggin@gmail.com>
        <20200706043540.1563616-6-npiggin@gmail.com>
        <874kqhvu1v.fsf@mpe.ellerman.id.au>
In-Reply-To: <874kqhvu1v.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-Id: <1595512823.5k2rrd4zk5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Michael Ellerman's message of July 9, 2020 8:53 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/include/asm/paravirt.h           | 28 ++++++++
>>  arch/powerpc/include/asm/qspinlock.h          | 66 +++++++++++++++++++
>>  arch/powerpc/include/asm/qspinlock_paravirt.h |  7 ++
>>  arch/powerpc/platforms/pseries/Kconfig        |  5 ++
>>  arch/powerpc/platforms/pseries/setup.c        |  6 +-
>>  include/asm-generic/qspinlock.h               |  2 +
>=20
> Another ack?
>=20
>> diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/=
asm/paravirt.h
>> index 7a8546660a63..f2d51f929cf5 100644
>> --- a/arch/powerpc/include/asm/paravirt.h
>> +++ b/arch/powerpc/include/asm/paravirt.h
>> @@ -45,6 +55,19 @@ static inline void yield_to_preempted(int cpu, u32 yi=
eld_count)
>>  {
>>  	___bad_yield_to_preempted(); /* This would be a bug */
>>  }
>> +
>> +extern void ___bad_yield_to_any(void);
>> +static inline void yield_to_any(void)
>> +{
>> +	___bad_yield_to_any(); /* This would be a bug */
>> +}
>=20
> Why do we do that rather than just not defining yield_to_any() at all
> and letting the build fail on that?
>=20
> There's a condition somewhere that we know will false at compile time
> and drop the call before linking?

Mainly so you could use it in if (IS_ENABLED()) blocks, but would still
catch the (presumably buggy) case where something calls it without the
option set.

I think I had it arranged a different way that was using IS_ENABLED=20
earlier and changed it but might as well keep it this way.

>=20
>> diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerp=
c/include/asm/qspinlock_paravirt.h
>> new file mode 100644
>> index 000000000000..750d1b5e0202
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +#ifndef __ASM_QSPINLOCK_PARAVIRT_H
>> +#define __ASM_QSPINLOCK_PARAVIRT_H
>=20
> _ASM_POWERPC_QSPINLOCK_PARAVIRT_H please.
>=20
>> +
>> +EXPORT_SYMBOL(__pv_queued_spin_unlock);
>=20
> Why's that in a header? Should that (eventually) go with the generic impl=
ementation?

Yeah the qspinlock_paravirt.h header is a bit weird and only gets=20
included into kernel/locking/qspinlock.c

>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platf=
orms/pseries/Kconfig
>> index 24c18362e5ea..756e727b383f 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>> @@ -25,9 +25,14 @@ config PPC_PSERIES
>>  	select SWIOTLB
>>  	default y
>> =20
>> +config PARAVIRT_SPINLOCKS
>> +	bool
>> +	default n
>=20
> default n is the default.
>=20
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platf=
orms/pseries/setup.c
>> index 2db8469e475f..747a203d9453 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -771,8 +771,12 @@ static void __init pSeries_setup_arch(void)
>>  	if (firmware_has_feature(FW_FEATURE_LPAR)) {
>>  		vpa_init(boot_cpuid);
>> =20
>> -		if (lppaca_shared_proc(get_lppaca()))
>> +		if (lppaca_shared_proc(get_lppaca())) {
>>  			static_branch_enable(&shared_processor);
>> +#ifdef CONFIG_PARAVIRT_SPINLOCKS
>> +			pv_spinlocks_init();
>> +#endif
>> +		}
>=20
> We could avoid the ifdef with this I think?

Yes I think so.

Thanks,
Nick

