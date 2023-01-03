Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B218065C4E5
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 18:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbjACRPN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 12:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjACRO2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 12:14:28 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A396A2623;
        Tue,  3 Jan 2023 09:14:05 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303Fjn4h025167;
        Tue, 3 Jan 2023 17:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=cR848DV/avWdzW+8TQLHNvdqDv5EnZo6I+sEiaUQgyU=;
 b=d0BRI+yJlp1ntt9JE7KP5XJNx7sDkuXDblGQ63y0XVjw+A0vaDeC4VhBtykhvPVY0nW1
 hR46Ikic4Nt6u7sehfxoyywcpwyHqA2Bp5dWRBBHLf8z9AdWLw4WT9VAhafLRIgxaH/U
 7Fk4racF+pjoGu0n2iFU1Or5KrRHNp6qNGiCjosGtIKuga9rbTbc1iB/TxCDjvkj9+ky
 bb2zZBiYvjUp8+JfL5lNRNQHsa0PBRSYmSRJ95KEVgPMWsDWnNFK1JyOqzFTWYucZuTL
 /SeQ3K6eDlBvSAL4Zdq2gbp2gJZtQQajDP0/bIVHPNjmYXpijNlHC5UzzhAJ2KT9UCAB bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjvf0uh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 17:12:57 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 303FbwO9005772;
        Tue, 3 Jan 2023 17:12:56 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvjvf0ugg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 17:12:56 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303Fgg3g004570;
        Tue, 3 Jan 2023 17:12:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mtcq6c52f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 17:12:54 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303HCowG39846200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 17:12:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 423DE20043;
        Tue,  3 Jan 2023 17:12:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0606E20040;
        Tue,  3 Jan 2023 17:12:48 +0000 (GMT)
Received: from osiris (unknown [9.171.65.115])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Jan 2023 17:12:47 +0000 (GMT)
Date:   Tue, 3 Jan 2023 18:12:45 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org,
        boqun.feng@gmail.com, mark.rutland@arm.com,
        catalin.marinas@arm.com, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        joro@8bytes.org, suravee.suthikulpanit@amd.com,
        robin.murphy@arm.com, dwmw2@infradead.org,
        baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH 05/12] arch: Introduce
 arch_{,try_}_cmpxchg128{,_local}()
Message-ID: <Y7RiDadEzeU3JnaO@osiris>
References: <20221219153525.632521981@infradead.org>
 <20221219154119.154045458@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219154119.154045458@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xoSCL8_TXsgG3bbtGsOnUYsi0X3pKuJ1
X-Proofpoint-GUID: SdrN_aW3Zv0ogzlhsuoHVhZTQgkm5BPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=976
 adultscore=0 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030145
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 19, 2022 at 04:35:30PM +0100, Peter Zijlstra wrote:
> For all architectures that currently support cmpxchg_double()
> implement the cmpxchg128() family of functions that is basically the
> same but with a saner interface.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/atomic_ll_sc.h |   38 +++++++++++++++++++++++
>  arch/arm64/include/asm/atomic_lse.h   |   33 +++++++++++++++++++-
>  arch/arm64/include/asm/cmpxchg.h      |   26 ++++++++++++++++
>  arch/s390/include/asm/cmpxchg.h       |   33 ++++++++++++++++++++
>  arch/x86/include/asm/cmpxchg_32.h     |    3 +
>  arch/x86/include/asm/cmpxchg_64.h     |   55 +++++++++++++++++++++++++++++++++-
>  6 files changed, 185 insertions(+), 3 deletions(-)
...
> --- a/arch/s390/include/asm/cmpxchg.h
> +++ b/arch/s390/include/asm/cmpxchg.h
> @@ -201,4 +201,37 @@ static __always_inline int __cmpxchg_dou
>  			 (unsigned long)(n1), (unsigned long)(n2));	\
>  })
>  
> +#define system_has_cmpxchg128()		1
> +
> +static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 new)
> +{
> +	asm volatile(
> +		"	cdsg	%[old],%[new],%[ptr]\n"
> +		: [old] "+&d" (old)
> +		: [new] "d" (new),
> +		  [ptr] "QS" (*(unsigned long *)ptr)
> +		: "memory", "cc");
> +	return old;
> +}
> +
> +static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
> +{
> +	u128 old = *oldp;
> +	int cc;
> +
> +	asm volatile(
> +		"	cdsg	%[old],%[new],%[ptr]\n"
> +		"	ipm	%[cc]\n"
> +		"	srl	%[cc],28\n"
> +		: [cc] "=&d" (cc), [old] "+&d" (old)
> +		: [new] "d" (new),
> +		  [ptr] "QS" (*(unsigned long *)ptr)
> +		: "memory", "cc");
> +
> +	if (unlikely(!cc))
> +		*oldp = old;
> +
> +	return likely(cc);
> +}
> +

I was wondering why arch_try_cmpxchg128() isn't even used with later
code. Turned out this is because of a missing

#define arch_try_cmpxchg128 arch_try_cmpxchg128

which in turn means that the generic fallback variant is used.

The above arch_try_cmpxchg128() implementation is broken, since it has
inversed condition code handling (cc == 0 means compare and swap
succeeded, cc == 1 means it failed).

However I would prefer to use the generic fallback variant anyway.
Could you please merge the below into your current patch?

It addresses also the oddity that *ptr within arch_cmpxchg128() is
only specified as input, while it should be input/output - it doesn't
matter due to the memory clobber, but let's have that correct anyway.

diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 527c968945e8..0b98f57bbe9e 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -173,31 +173,12 @@ static __always_inline u128 arch_cmpxchg128(volatile u128 *ptr, u128 old, u128 n
 {
 	asm volatile(
 		"	cdsg	%[old],%[new],%[ptr]\n"
-		: [old] "+&d" (old)
-		: [new] "d" (new),
-		  [ptr] "QS" (*(u128 *)ptr)
+		: [old] "+d" (old), [ptr] "+QS" (*ptr)
+		: [new] "d" (new)
 		: "memory", "cc");
 	return old;
 }
 
-static __always_inline bool arch_try_cmpxchg128(volatile u128 *ptr, u128 *oldp, u128 new)
-{
-	u128 old = *oldp;
-	int cc;
-
-	asm volatile(
-		"	cdsg	%[old],%[new],%[ptr]\n"
-		"	ipm	%[cc]\n"
-		"	srl	%[cc],28\n"
-		: [cc] "=&d" (cc), [old] "+&d" (old)
-		: [new] "d" (new),
-		  [ptr] "QS" (*(u128 *)ptr)
-		: "memory", "cc");
-
-	if (unlikely(!cc))
-		*oldp = old;
-
-	return likely(cc);
-}
+#define arch_cmpxchg128		arch_cmpxchg128
 
 #endif /* __ASM_CMPXCHG_H */
