Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F722B357
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgGWQU1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGWQU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 12:20:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B3AC0619DC;
        Thu, 23 Jul 2020 09:20:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x72so3245722pfc.6;
        Thu, 23 Jul 2020 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=dWKUB0kRohvexbkkPgRM1qwRkgK/3Sd5V3qmYHkfVHc=;
        b=CLFlyE2INNHRtu0udQhGXB/xueYWvsHUKQOa7BhUp+CQibOINf6pl9x8l8tzZnhdso
         ra1AtKgGgUmh80B1VBWFNou9SX1AkDMjVJPKEd6z7bXtYEtL4VtsWvWBKt85CviMvodt
         BCPDK7o0NLHmmMijpm4MSZoDNzKJgXcYkyPwgQI94LaTdG3ZWY8hKiJp0FQZTwHSGX68
         03TQQk4bUoK7KOZGgWGPD5qw1ZjGeDnIGEuePIN3oPvkWPaQfDouRmp3sEiQiRAei0kZ
         iuFRqCxyVbeCBhNxZt0y4ohF4dbrYNqIKL71S9OHION9X5XkwajhSEhjg2H7M3QCdc2S
         CGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=dWKUB0kRohvexbkkPgRM1qwRkgK/3Sd5V3qmYHkfVHc=;
        b=qnIN6AGh1S9ugAjE2eItzb6iHj93ZS7nDVtuAiZe7QExKJtyzIN1Qp34qJFmEsrC2V
         /1UwBa2p2qtv2BfpqFK7KfWcnwaCcenegBLWVpc/OpDT5eiIuw6COs1PSOOgVKqMdeTM
         qzAnlGj5fgQ9SY6kT6X11SR/lOuRo/C7MuMALSqzZm3iGdrA3WKyrsskpRhrw2bHJx+f
         mGJdbMCY3SlIQ+i4X3y8JFF2EtAdsZUb9thLKbukY7cGvNuIixJLNhYGWBS+TYdth0TZ
         WfLqhAp/zWp1HgejGAa/XTj67BG1CKrs/NAU9sSv6wfuy04+mCfEhaTmp7+FcPeFmWt7
         1fdg==
X-Gm-Message-State: AOAM530wj73IFkm7Ntj5Y4d43I9NdQ6HWtAehrkuqj8JITiIzCdeHILg
        glivfjJ4BQJJeAb5htg6xOQ=
X-Google-Smtp-Source: ABdhPJysDWhvIJQomw/DqEdIwc2bVMwxFcnItkq2Ze5+GnmO9BChUUQuuGE4h+UgCL2QhudHR2afgw==
X-Received: by 2002:a65:6246:: with SMTP id q6mr4842817pgv.133.1595521226642;
        Thu, 23 Jul 2020 09:20:26 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id z11sm3376688pfr.71.2020.07.23.09.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 09:20:26 -0700 (PDT)
Date:   Fri, 24 Jul 2020 02:20:20 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200723114010.GO5523@worktop.programming.kicks-ass.net>
        <1595506730.3mvrxktem5.astroid@bobo.none>
        <20200723145904.GU5523@worktop.programming.kicks-ass.net>
In-Reply-To: <20200723145904.GU5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595520766.9z4077xel7.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 24, 2020 12:59 am:
> On Thu, Jul 23, 2020 at 11:11:03PM +1000, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
>> > On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>> >=20
>> >> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include=
/asm/hw_irq.h
>> >> index 3a0db7b0b46e..35060be09073 100644
>> >> --- a/arch/powerpc/include/asm/hw_irq.h
>> >> +++ b/arch/powerpc/include/asm/hw_irq.h
>> >> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>> >>  #define powerpc_local_irq_pmu_save(flags)			\
>> >>  	 do {							\
>> >>  		raw_local_irq_pmu_save(flags);			\
>> >> -		trace_hardirqs_off();				\
>> >> +		if (!raw_irqs_disabled_flags(flags))		\
>> >> +			trace_hardirqs_off();			\
>> >>  	} while(0)
>> >>  #define powerpc_local_irq_pmu_restore(flags)			\
>> >>  	do {							\
>> >> -		if (raw_irqs_disabled_flags(flags)) {		\
>> >> -			raw_local_irq_pmu_restore(flags);	\
>> >> -			trace_hardirqs_off();			\
>> >> -		} else {					\
>> >> +		if (!raw_irqs_disabled_flags(flags))		\
>> >>  			trace_hardirqs_on();			\
>> >> -			raw_local_irq_pmu_restore(flags);	\
>> >> -		}						\
>> >> +		raw_local_irq_pmu_restore(flags);		\
>> >>  	} while(0)
>> >=20
>> > You shouldn't be calling lockdep from NMI context!
>>=20
>> After this patch it doesn't.
>=20
> You sure, trace_hardirqs_{on,off}() calls into lockdep.

At least for irq enable/disable functions yes. NMI runs with
interrupts disabled so these will never call trace_hardirqs_on/off
after this patch.

> (FWIW they're
> also broken vs entry ordering, but that's another story).
>=20
>> trace_hardirqs_on/off implementation appears to expect to be called in N=
MI=20
>> context though, for some reason.
>=20
> Hurpm, not sure.. I'll have to go grep arch code now :/ The generic NMI
> code didn't touch that stuff.
>=20
> Argh, yes, there might be broken there... damn! I'll go frob around.
>=20

Thanks,
Nick
