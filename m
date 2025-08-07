Return-Path: <linux-arch+bounces-13088-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66464B1D543
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 11:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535031AA17C3
	for <lists+linux-arch@lfdr.de>; Thu,  7 Aug 2025 09:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B4326B76A;
	Thu,  7 Aug 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="go9qRIE7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EE7376F1;
	Thu,  7 Aug 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754560034; cv=none; b=WSiYB1sov9r+MyOLLEO6RGAWbcL0l17FwXQ+H2xTTEzkXWesvR/IAHJIm6psFUlXLyOB5RQ9OVjVO9KZtqTGtQxxikQnDDz8KOVw7s5Mta7lCrfrkyjSMU1RwpNirg67TwJODNuYxfUDTODaXao3bbHjqeKRr0aMcc7CaTJhLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754560034; c=relaxed/simple;
	bh=TDeiBApOh1NcX4yBW9i2CsFOUdCFeSFRwM+KeVVkTrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sTQXZgV5k76/7a0JzNMXmvVyerfb5kbE2Z9SZ+vSuXIkpMJ96HGqPuMrGfj3LQpL8Hj6uA8Y4DjmETc2k6OEA9b88Wi81VGjdUJG8lE58o7qxeoHndmrEauBy+PK8S7lEU8W8+vr+zPNgDLO3iE5cfFF+aJd3M7XQNMho7+aKgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=go9qRIE7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57790AX3021567;
	Thu, 7 Aug 2025 09:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ImRZUe
	6tVuS8TT869/9J1UoTQ8hVJxjnFHqcKjWzkmg=; b=go9qRIE70CfPyS9Kn8TPsq
	JkZyaxDOMfgvgd9oOkezsaYQ7nO6H1+vyJlxnFf+6IS8gazLQFoHJPSCtC/ozPKm
	6VKICh++4mFIXlvEA+Fv861i489NybwU9awUyTQXXGMIfzvBpYV01KVsDF9Iz4YI
	Ww/eXWrOH1iZah1GKzst8ykQD8OdLbBS52aH5gpTLX9hzYzJnzq1Wj6ghnhGN7K+
	HeSCbGXR0u5BWfqTnzNxp7wSohfiND9Ay/p0FkDgE9Qit35GSbcVN7CqdFOj9pan
	uk5bsEsgRkx16zjIPUzdIH9a6QpTBUGyN7bRfWvIADnQUc0lqNAVn74p649+uPzA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq621brx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:46:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779eRBP008042;
	Thu, 7 Aug 2025 09:46:52 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwmyygs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 09:46:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5779kpb241746786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 09:46:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450E158055;
	Thu,  7 Aug 2025 09:46:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F5705804E;
	Thu,  7 Aug 2025 09:46:39 +0000 (GMT)
Received: from [9.197.227.8] (unknown [9.197.227.8])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 09:46:38 +0000 (GMT)
Message-ID: <7f4f4d07-38f7-444c-adff-ec2a2387e86b@linux.ibm.com>
Date: Thu, 7 Aug 2025 15:16:35 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/17] powerpc: Add __attribute_const__ to ffs()-family
 implementations
To: Kees Cook <kees@kernel.org>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20250804163910.work.929-kees@kernel.org>
 <20250804164417.1612371-5-kees@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20250804164417.1612371-5-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA3MyBTYWx0ZWRfX0unUnmBlk9BR
 JyFnhjGUCcX72+ZTvzudrWhw0DB4YVlTamytH3O0p7bgfe1t3RFHu6oXmijVRlkSINNESQcI2ed
 WV3l/gYRQ2VZynkYP3Tav0+7jWhZaLSgpYND2noyaRsJ968IyHQXslrcztFRDh0MZBgxPGbCx8b
 +uiLKSt+6Y6IffZklEx4VluWHkjrCmfWHrp45aQanh3SGagw7gHzrJqpepYvNT4HS8EbCADH/Wn
 zPt3JFi7B14TKcENIp/5NLm0esF1T5EYGCGzXF9hdI2cf8y7VhMMiJqeZefBkl9p6Z1CLp13muG
 PGN5oX3iZrejuEHJm8J9sJaxrIF5Rg9tb8/6Jc0aiE3VKei/f3z6YRAKdY8HGg4pDBW4p1GLl1f
 BVmzVXfbgFB6avmCIX9UByEecqNiyQFlc4BOgzcQYghhJIGa/JLCPKcNMH7ACy88lL+pl3p9
X-Proofpoint-GUID: _d76WmYcTWXQ7iz_O6QVqZlqoAE5ZdTK
X-Authority-Analysis: v=2.4 cv=BIuzrEQG c=1 sm=1 tr=0 ts=6894760d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ob59Q8BqYF9JHPHMJZcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _d76WmYcTWXQ7iz_O6QVqZlqoAE5ZdTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1011
 malwarescore=0 phishscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508070073



On 8/4/25 10:14 PM, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
> 
> Add missing __attribute_const__ annotations to PowerPC's implementations of
> fls() function. These are pure mathematical functions that always return
> the same result for the same input with no side effects, making them eligible
> for compiler optimization.
> 
> Build tested ARCH=powerpc defconfig with GCC powerpc-linux-gnu 14.2.0.
> 

Also tested with gcc 8.1.

Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>


> Link: https://github.com/KSPP/linux/issues/364 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  arch/powerpc/include/asm/bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
> index 671ecc6711e3..0d0470cd5ac3 100644
> --- a/arch/powerpc/include/asm/bitops.h
> +++ b/arch/powerpc/include/asm/bitops.h
> @@ -276,7 +276,7 @@ static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
>   * fls: find last (most-significant) bit set.
>   * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
>   */
> -static __always_inline int fls(unsigned int x)
> +static __always_inline __attribute_const__ int fls(unsigned int x)
>  {
>  	int lz;
>  
> @@ -294,7 +294,7 @@ static __always_inline int fls(unsigned int x)
>   * 32-bit fls calls.
>   */
>  #ifdef CONFIG_PPC64
> -static __always_inline int fls64(__u64 x)
> +static __always_inline __attribute_const__ int fls64(__u64 x)
>  {
>  	int lz;
>  


