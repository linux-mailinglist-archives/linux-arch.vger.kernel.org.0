Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6FF2219DB
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jul 2020 04:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGPC1I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 22:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPC1I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 22:27:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBF0C061755;
        Wed, 15 Jul 2020 19:27:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so5199384wrp.10;
        Wed, 15 Jul 2020 19:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=04uHn/CL7pyDvOHTAcht7iY7evRRiAgOiMIVel5xtkk=;
        b=N7NSh/ZnIW59iFvKpadE4to2XYXD0lW8+rmmz2hxj49n80h1+5qGV+WGBgstCePJB2
         Ala7SN70AbDeqv6A7wM52AfGxizEgFKBgl7/5362D3K+26JM99KaLL9T/DOzwp0dTCGq
         aboVNbeOMlbLglLqauca4ya+mIxDaP7CxgiMLUFTPPqGpPSOZ2BL6wKi85C0gBjFv8jL
         6a8xmKUr2YfwFVCPmttiUXPhlKIGk7O2S+DX6naFzXOHL90x1QFOfeYuj/Ha3vFq5PQC
         8etFaFksfyIyUQeeC4Hg/WswjjSc9euzuKROH9oLxunLwg5IJG/n1W7/+WscQ+B1cvoK
         P9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=04uHn/CL7pyDvOHTAcht7iY7evRRiAgOiMIVel5xtkk=;
        b=uRylAf97B21HtWF41I7aq167E4cYi8REAUZstN4GzcrDPkSovVrpg16a8/xTDsUavH
         7vHOUqb/pytG86XleJwEcXemVCrR9qEB82YqEvkBvjY4/McpSvP5DtfeBFM0aGFs/oEy
         dR+1c5t7rvkzGYJHMItEp9z+724m4CchVy1o2VFM07LtBitMxOjFjbHcUm//jDbRhcb5
         GQytAu0sWAcZJ7n763lJN5U73OyKRNZx3BxMzzsgtvdPitxnzJOk7pB9Uvx6NiBa2Dwu
         iIGVuK7Fjtyb+tL/L8GhdieourpW0BGlTzYTWlTBNOSaIATf3BBtxASXzBtxxuBOyGb0
         KzMQ==
X-Gm-Message-State: AOAM533jLogO49dOhZikvg6m+QFKEABE5TXsNiU3NBKxgGp2iroTbF7u
        FskPDrY2FRxL2KCN+p7LEfc=
X-Google-Smtp-Source: ABdhPJweqAS/z8czeSNIY8AyXtowHcjFsy6DuNN3ZzLZ9nFQDTCR+fJAIxMgdGQwRsde5Dq07FdbRg==
X-Received: by 2002:adf:ff90:: with SMTP id j16mr2542331wrr.364.1594866426470;
        Wed, 15 Jul 2020 19:27:06 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id j145sm6361889wmj.7.2020.07.15.19.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 19:27:05 -0700 (PDT)
Date:   Thu, 16 Jul 2020 12:26:59 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy
 tlb option
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>
References: <1594708054.04iuyxuyb5.astroid@bobo.none>
        <6D3D1346-DB1E-43EB-812A-184918CCC16A@amacapital.net>
In-Reply-To: <6D3D1346-DB1E-43EB-812A-184918CCC16A@amacapital.net>
MIME-Version: 1.0
Message-Id: <1594866023.tjwr7nhhg2.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of July 14, 2020 10:46 pm:
>=20
>=20
>> On Jul 13, 2020, at 11:31 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> =EF=BB=BFExcerpts from Nicholas Piggin's message of July 14, 2020 3:04 p=
m:
>>> Excerpts from Andy Lutomirski's message of July 14, 2020 4:18 am:
>>>>=20
>>>>> On Jul 13, 2020, at 9:48 AM, Nicholas Piggin <npiggin@gmail.com> wrot=
e:
>>>>>=20
>>>>> =EF=BB=BFExcerpts from Andy Lutomirski's message of July 14, 2020 1:5=
9 am:
>>>>>>> On Thu, Jul 9, 2020 at 6:57 PM Nicholas Piggin <npiggin@gmail.com> =
wrote:
>>>>>>>=20
>>>>>>> On big systems, the mm refcount can become highly contented when do=
ing
>>>>>>> a lot of context switching with threaded applications (particularly
>>>>>>> switching between the idle thread and an application thread).
>>>>>>>=20
>>>>>>> Abandoning lazy tlb slows switching down quite a bit in the importa=
nt
>>>>>>> user->idle->user cases, so so instead implement a non-refcounted sc=
heme
>>>>>>> that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot =
down
>>>>>>> any remaining lazy ones.
>>>>>>>=20
>>>>>>> On a 16-socket 192-core POWER8 system, a context switching benchmar=
k
>>>>>>> with as many software threads as CPUs (so each switch will go in an=
d
>>>>>>> out of idle), upstream can achieve a rate of about 1 million contex=
t
>>>>>>> switches per second. After this patch it goes up to 118 million.
>>>>>>>=20
>>>>>>=20
>>>>>> I read the patch a couple of times, and I have a suggestion that cou=
ld
>>>>>> be nonsense.  You are, effectively, using mm_cpumask() as a sort of
>>>>>> refcount.  You're saying "hey, this mm has no more references, but i=
t
>>>>>> still has nonempty mm_cpumask(), so let's send an IPI and shoot down
>>>>>> those references too."  I'm wondering whether you actually need the
>>>>>> IPI.  What if, instead, you actually treated mm_cpumask as a refcoun=
t
>>>>>> for real?  Roughly, in __mmdrop(), you would only free the page tabl=
es
>>>>>> if mm_cpumask() is empty.  And, in the code that removes a CPU from
>>>>>> mm_cpumask(), you would check if mm_users =3D=3D 0 and, if so, check=
 if
>>>>>> you just removed the last bit from mm_cpumask and potentially free t=
he
>>>>>> mm.
>>>>>>=20
>>>>>> Getting the locking right here could be a bit tricky -- you need to
>>>>>> avoid two CPUs simultaneously exiting lazy TLB and thinking they
>>>>>> should free the mm, and you also need to avoid an mm with mm_users
>>>>>> hitting zero concurrently with the last remote CPU using it lazily
>>>>>> exiting lazy TLB.  Perhaps this could be resolved by having mm_count
>>>>>> =3D=3D 1 mean "mm_cpumask() is might contain bits and, if so, it own=
s the
>>>>>> mm" and mm_count =3D=3D 0 meaning "now it's dead" and using some car=
eful
>>>>>> cmpxchg or dec_return to make sure that only one CPU frees it.
>>>>>>=20
>>>>>> Or maybe you'd need a lock or RCU for this, but the idea would be to
>>>>>> only ever take the lock after mm_users goes to zero.
>>>>>=20
>>>>> I don't think it's nonsense, it could be a good way to avoid IPIs.
>>>>>=20
>>>>> I haven't seen much problem here that made me too concerned about IPI=
s=20
>>>>> yet, so I think the simple patch may be good enough to start with
>>>>> for powerpc. I'm looking at avoiding/reducing the IPIs by combining t=
he
>>>>> unlazying with the exit TLB flush without doing anything fancy with
>>>>> ref counting, but we'll see.
>>>>=20
>>>> I would be cautious with benchmarking here. I would expect that the
>>>> nasty cases may affect power consumption more than performance =E2=80=
=94 the=20
>>>> specific issue is IPIs hitting idle cores, and the main effects are to=
=20
>>>> slow down exit() a bit but also to kick the idle core out of idle.=20
>>>> Although, if the idle core is in a deep sleep, that IPI could be=20
>>>> *very* slow.
>>>=20
>>> It will tend to be self-limiting to some degree (deeper idle cores
>>> would tend to have less chance of IPI) but we have bigger issues on
>>> powerpc with that, like broadcast IPIs to the mm cpumask for THP
>>> management. Power hasn't really shown up as an issue but powerpc
>>> CPUs may have their own requirements and issues there, shall we say.
>>>=20
>>>> So I think it=E2=80=99s worth at least giving this a try.
>>>=20
>>> To be clear it's not a complete solution itself. The problem is of=20
>>> course that mm cpumask gives you false negatives, so the bits
>>> won't always clean up after themselves as CPUs switch away from their
>>> lazy tlb mms.
>>=20
>> ^^
>>=20
>> False positives: CPU is in the mm_cpumask, but is not using the mm
>> as a lazy tlb. So there can be bits left and never freed.
>>=20
>> If you closed the false positives, you're back to a shared mm cache
>> line on lazy mm context switches.
>=20
> x86 has this exact problem. At least no more than 64*8 CPUs share the cac=
he line :)
>=20
> Can your share your benchmark?

It's just context_switch1_threads from will-it-scale, running with 1/2
the number of CPUs, and core affinity with an SMT processor (so each
thread from the switching pairs gets spread to their own CPU and so you
get the task->idle->task switching.

It's really just about the worst case, so I wouldn't say it's something
to panic about.

Thanks,
Nick
