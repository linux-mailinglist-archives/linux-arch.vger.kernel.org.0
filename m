Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6AE22DBA3
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jul 2020 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgGZEOm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jul 2020 00:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgGZEOl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 00:14:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D454C0619D2;
        Sat, 25 Jul 2020 21:14:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so7542744pgb.6;
        Sat, 25 Jul 2020 21:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=NaFK/HvQAlrC7LDIbLRf6mGY+l5iAmDEfcE+qmb5VDg=;
        b=M7W5LhxzJcXQLxq1nYyKrilWrWy1XNfMjBlV9bXpDzPhVA6K5rMDIE1V2mPVeyUTws
         y5cq75EQ9HH4TMLotEbpZmUWfMYZ+ynFAcWyATiwnazm1YrbFwYZmQWD3VUauqCT6vOf
         DjAvJzy5aMN3iHQNZbgFW1G1/6V3eUDzuROebY92ON5x0+uYdnyVJCW1bMMsW3SYgJB+
         z7K/gk7EJ1LEoCEcnXV+ARKglSstcyiuXByG14F40ckoC95yfJ56fjQSry4jgJA1O1mC
         o4ggqUqm37AnpRVrFkB0nSW1oXBMQRt4aqxaPsNd1i5bWIA7UYycVn9EFt08odvk3b57
         BCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=NaFK/HvQAlrC7LDIbLRf6mGY+l5iAmDEfcE+qmb5VDg=;
        b=F1YYEf+h5rbOy1yIsm/3zjlVVLrJMIITH9V4V8OdkMbowKaCMZN7/XFLO1vx1ZwqaK
         leXrPOxW2olCJMe1/g98sMNGIaZ/3I4z0YN3e5InVbo2d4KfoSWWM04mN7XMrhb6g01W
         dEdHJ2mDXtDXgX3LwkP8YS5zeEkCPxcswhgxpEnz4HBXI3P8ho+U9a4CPowAsqsUUfFq
         tYGcfppsTtfSs2WdyG36D9tdR/75wyqIXEuO6L+3rMB9nsN4XKepym1ejqozApjTgZUG
         t1hWXqgOfIPRAdVziuW3RJmX5qijt7m1x26LQs8jPrndzkIjAPPUUDuUwGA3ezAIFbFk
         UhfQ==
X-Gm-Message-State: AOAM531Iu8Ida+IMH377JwTan5SCQ7VAeEK+Uercx75z2RWIts5Q710+
        N9ISLT86Jl/jjkgJk4846rc=
X-Google-Smtp-Source: ABdhPJwQi5Jco6i9POh2NO1VNAXMvnHLFEAztqlB9K276iQFTK0wWDev7lSFOpmxXGPSbh5vtd07lQ==
X-Received: by 2002:a63:5d54:: with SMTP id o20mr14356921pgm.253.1595736880937;
        Sat, 25 Jul 2020 21:14:40 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id v11sm11846251pfc.108.2020.07.25.21.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 21:14:40 -0700 (PDT)
Date:   Sun, 26 Jul 2020 14:14:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200725202617.GI10769@hirez.programming.kicks-ass.net>
In-Reply-To: <20200725202617.GI10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595735694.b784cvipam.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 26, 2020 6:26 am:
> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/as=
m/hw_irq.h
>> index 3a0db7b0b46e..35060be09073 100644
>> --- a/arch/powerpc/include/asm/hw_irq.h
>> +++ b/arch/powerpc/include/asm/hw_irq.h
>> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>>  #define powerpc_local_irq_pmu_save(flags)			\
>>  	 do {							\
>>  		raw_local_irq_pmu_save(flags);			\
>> -		trace_hardirqs_off();				\
>> +		if (!raw_irqs_disabled_flags(flags))		\
>> +			trace_hardirqs_off();			\
>>  	} while(0)
>=20
> So one problem with the above is something like this:
>=20
> 	raw_local_irq_save();
> 	<NMI>
> 	  powerpc_local_irq_pmu_save();
>=20
> that would now no longer call into tracing/lockdep at all. As a
> consequence, lockdep and tracing would show the NMI ran with IRQs
> enabled, which is exceptionally weird..

powerpc perf NMIs will trace_hardirqs_off() if they were enabled,
and trace_hardirqs_on() at exit in that case too.

Machine check and system reset (like x86's "nmi") don't, but that's
deliberate to avoid any tracing in those cases which often causes
more problems than it's worth (and we have flags to prevent ftrace,
etc too for those cases).

> Similar problem with:
>=20
> 	raw_local_irq_disable();
> 	local_irq_save()
>=20
> Now, most architectures today seem to do what x86 also did:
>=20
> 	<NMI>
> 	  trace_hardirqs_off()
> 	  ...
> 	  if (irqs_unmasked(regs))
> 	    trace_hardirqs_on()
> 	</NMI>
>=20
> Which is 'funny' when it interleaves like:
>=20
> 	local_irq_disable();
> 	...
> 	local_irq_enable()
> 	  trace_hardirqs_on();
> 	  <NMI/>
> 	  raw_local_irq_enable();
>=20
> Because then it will undo the trace_hardirqs_on() we just did. With the
> result that both tracing and lockdep will see a hardirqs-disable without
> a matching enable, while the hardware state is enabled.

Seems like an arch problem -- why not disable if it was enabled only?
I guess the local_irq tracing calls are a mess so maybe they copied=20
those.

> Which is exactly the state Alexey seems to have ran into.

No his was what I said, the interruptee's trace_hardirqs_on() in
local_irq_enable getting lost because the NMI's local_irq_disable
always disables, but the enable doesn't re-enable.

It's all just weird asymmetrical special case hacks AFAIKS, the
code should just be symmetric and lockdep handle it's own weirdness.

>=20
> Now, x86, and at least arm64 call nmi_enter() before
> trace_hardirqs_off(), but AFAICT Power never did that, and that's part
> of the problem. nmi_enter() does lockdep_off() and that _used_ to also
> kill IRQ tracking.

Power does do nmi_enter -- __perf_event_interrupt()

        nmi =3D perf_intr_is_nmi(regs);
        if (nmi)
                nmi_enter();
        else
                irq_enter();

Thanks,
Nick

> Now, my patch changed that, it makes IRQ tracking not respect
> lockdep_off(). And that exposed x86 (and everybody else :/) to the same
> problem you have.
>=20
> And this is why I made x86 look at software state in NMIs. Because then
> it all works out. For bonus points, trace_hardirqs_*() also has some
> do-it-once logic for tracing.
>=20
>=20
>=20
> Anyway, it's Saturday evening, time for a beer. I'll stare at this more
> later.
>=20
