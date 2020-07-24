Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9071222BDFA
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 08:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGXGQu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 24 Jul 2020 02:16:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgGXGQu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jul 2020 02:16:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O63REN056865;
        Fri, 24 Jul 2020 02:16:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32facequ3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 02:16:37 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O63lKS058736;
        Fri, 24 Jul 2020 02:16:36 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32facequ2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 02:16:36 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O6EIAc002103;
        Fri, 24 Jul 2020 06:16:34 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32brq83tw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 06:16:34 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O6GWI528114984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 06:16:32 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA4BDA405B;
        Fri, 24 Jul 2020 06:16:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4831FA4064;
        Fri, 24 Jul 2020 06:16:29 +0000 (GMT)
Received: from [9.85.89.111] (unknown [9.85.89.111])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Jul 2020 06:16:29 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
Date:   Fri, 24 Jul 2020 11:46:26 +0530
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6BAF6D26-A316-4F0A-AF10-5E43B2C09B90@linux.vnet.ibm.com>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200723114010.GO5523@worktop.programming.kicks-ass.net>
 <1595506730.3mvrxktem5.astroid@bobo.none>
 <1884dcea-9ecd-a1f3-21bb-213c655e2480@ozlabs.ru>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_01:2020-07-24,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240044
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On 24-Jul-2020, at 9:46 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
> 
> 
> On 23/07/2020 23:11, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 23, 2020 9:40 pm:
>>> On Thu, Jul 23, 2020 at 08:56:14PM +1000, Nicholas Piggin wrote:
>>> 
>>>> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
>>>> index 3a0db7b0b46e..35060be09073 100644
>>>> --- a/arch/powerpc/include/asm/hw_irq.h
>>>> +++ b/arch/powerpc/include/asm/hw_irq.h
>>>> @@ -200,17 +200,14 @@ static inline bool arch_irqs_disabled(void)
>>>> #define powerpc_local_irq_pmu_save(flags)			\
>>>> 	 do {							\
>>>> 		raw_local_irq_pmu_save(flags);			\
>>>> -		trace_hardirqs_off();				\
>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>> +			trace_hardirqs_off();			\
>>>> 	} while(0)
>>>> #define powerpc_local_irq_pmu_restore(flags)			\
>>>> 	do {							\
>>>> -		if (raw_irqs_disabled_flags(flags)) {		\
>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>> -			trace_hardirqs_off();			\
>>>> -		} else {					\
>>>> +		if (!raw_irqs_disabled_flags(flags))		\
>>>> 			trace_hardirqs_on();			\
>>>> -			raw_local_irq_pmu_restore(flags);	\
>>>> -		}						\
>>>> +		raw_local_irq_pmu_restore(flags);		\
>>>> 	} while(0)
>>> 
>>> You shouldn't be calling lockdep from NMI context!
>> 
>> After this patch it doesn't.
>> 
>> trace_hardirqs_on/off implementation appears to expect to be called in NMI 
>> context though, for some reason.
>> 
>>> That is, I recently
>>> added suport for that on x86:
>>> 
>>>  https://lkml.kernel.org/r/20200623083721.155449112@infradead.org
>>>  https://lkml.kernel.org/r/20200623083721.216740948@infradead.org
>>> 
>>> But you need to be very careful on how you order things, as you can see
>>> the above relies on preempt_count() already having been incremented with
>>> NMI_MASK.
>> 
>> Hmm. My patch seems simpler.
> 
> And your patches fix my error while Peter's do not:
> 
> 
> IRQs not enabled as expected
> WARNING: CPU: 0 PID: 1377 at /home/aik/p/kernel/kernel/softirq.c:169
> __local_bh_enable_ip+0x118/0x190

Hi Nicholas, Alexey

I was able to reproduce the warning which Alexey reported using perf_fuzzer test suite. 
With the patch provided by Nick, I don’t see the issue anymore. This patch fixes the
warnings I got with perf fuzzer run.

Thanks Nick for the fix. 

Tested-by: Athira Rajeev<atrajeev@linux.ibm.com>


> 
> 
>> 
>> I don't know this stuff very well, I don't really understand what your patch 
>> enables for x86 but at least it shouldn't be incompatible with this one 
>> AFAIKS.
>> 
>> Thanks,
>> Nick
>> 
> 
> -- 
> Alexey

