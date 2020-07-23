Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AFE22B00C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 15:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgGWNLK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 09:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWNLK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 09:11:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9F4C0619DC;
        Thu, 23 Jul 2020 06:11:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so3148941pjb.2;
        Thu, 23 Jul 2020 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=E/e6bkQ7xor2tf39B3HoCRN8UgDNduwN1Zl5yinxqAQ=;
        b=VHCvV4tDO0Bo5lG2Zc4hPcBRi5ULljYg08PlC0vzAhBt1p+CAjOX0WO/MyIX6FT/Xz
         AVXqfD1jopjxBj0S7kL4mgO5TWFgxhWjIwgiNW/HnU1AXeN9Wa9A/R9UWkrrkJZDEl9A
         Y4GRXVfQdi2aBc5if6fb1s/fm8E43m7KFrJmOZ5D4lLx1neR//DLIeK5TXy+RMVs9mWL
         zXyf0bGiSKnAjEfPXF02FACc0rMk0Ikkzot//SenWG4yCVgqJ4UgWgE4sRgiS6gbaRIH
         maTuWUdkFpnk4sPb5nhbOtEDUUMLgvXitYsyqxIZqPsm2ZMlXRIHbfw+ZRcAv2LRAGjV
         wLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=E/e6bkQ7xor2tf39B3HoCRN8UgDNduwN1Zl5yinxqAQ=;
        b=NEvO9CeaUnSEZ+hDUG4eF6pvVN7c0ts44PCupbUm1bYVFYjHFL+YsFBs0AHWS8UWJu
         loObe8hhl2pYlStSrxERDRluP8smrjVDwS/sZrYdHIeyHZuR1TAqp/QoFfPx9ETxxnih
         2NDot1AOlN0rj16dfX87zklXfd39dI1BfjrjhkhgJKryD88qyGGAgvg9Bxw15nc0iU94
         u3wrEDXAM+dJzb1v/5CxBntNMsfhgbJjocxwmVpgZgpMlzcVE6aA6peHaMjfuRXSq3Uh
         oe5/lJb4qLWSE/hWQid7T0E2y36mvufV33RH7WdYcgJZWLKv/zj0RKFDaEEF264IUKql
         L5Jg==
X-Gm-Message-State: AOAM5336AMSISRXHwZi/JXahnDtrJX3FM6T8r3W4fFolix7gJJi6jzTs
        UqeY2Hda2j9t+1fZzqJwkp0=
X-Google-Smtp-Source: ABdhPJzyDRqU0+pKFo017avcsBGjeFT0wLcR3XwTdTSuoYbBl6djhiXCSDZYxDgTPpeRhvXDAsKYsw==
X-Received: by 2002:a17:90a:6b02:: with SMTP id v2mr310422pjj.163.1595509869825;
        Thu, 23 Jul 2020 06:11:09 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id g18sm3001623pfi.141.2020.07.23.06.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 06:11:09 -0700 (PDT)
Date:   Thu, 23 Jul 2020 23:11:03 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200723114010.GO5523@worktop.programming.kicks-ass.net>
In-Reply-To: <20200723114010.GO5523@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595506730.3mvrxktem5.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>=20
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
>>  #define powerpc_local_irq_pmu_restore(flags)			\
>>  	do {							\
>> -		if (raw_irqs_disabled_flags(flags)) {		\
>> -			raw_local_irq_pmu_restore(flags);	\
>> -			trace_hardirqs_off();			\
>> -		} else {					\
>> +		if (!raw_irqs_disabled_flags(flags))		\
>>  			trace_hardirqs_on();			\
>> -			raw_local_irq_pmu_restore(flags);	\
>> -		}						\
>> +		raw_local_irq_pmu_restore(flags);		\
>>  	} while(0)
>=20
> You shouldn't be calling lockdep from NMI context!

After this patch it doesn't.

trace_hardirqs_on/off implementation appears to expect to be called in NMI=20
context though, for some reason.

> That is, I recently
> added suport for that on x86:
>=20
>   https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
>   https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
>=20
> But you need to be very careful on how you order things, as you can see
> the above relies on preempt_count() already having been incremented with
> NMI_MASK.

Hmm. My patch seems simpler.

I don't know this stuff very well, I don't really understand what your patc=
h=20
enables for x86 but at least it shouldn't be incompatible with this one=20
AFAIKS.

Thanks,
Nick
