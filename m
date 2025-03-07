Return-Path: <linux-arch+bounces-10565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFDFA56C08
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 16:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FC83A8244
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A521A44E;
	Fri,  7 Mar 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qKQQC8sC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A4C101F2;
	Fri,  7 Mar 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361371; cv=none; b=prTrNJs4Nb9kJI/9e8Am5iyvlF9bM1BsNjlO0AIhY90DYZhEBqj8qLCeZLOvLvXfn+2c99t61LZmPitymVYH2osuEe4I1jCsShk89hLjYP65Dr3iMdozymYw9O9LbKkXg5B6rjpqLjAz3fwtnoRUOtDOVKmqUZlom3IYjiXr314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361371; c=relaxed/simple;
	bh=IQGBIqRB4GzYAQ/tDFR+0LkWEAzC++ZVR1ooYLXKi7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oswP1zt/tvvfvx2OTk18YH+EQN+g2AO65nyU7GAlGI+kHHuFK+l48z7OTQHin7SY7qM6MIG/qsflFG+lEvN3ghgGljBJ7+dIXzxuLntbWKE/De836ZzQ3+ehjFaH/nPYqzg7tORHuwdpeloWXJjexs4BPCbBC8mkK+7IEQZnwCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qKQQC8sC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527E3AWH028905;
	Fri, 7 Mar 2025 15:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Y0KvhWxi6k4smjT1a6uHtK0WLe6VaK
	HOV2hSoWFI5bI=; b=qKQQC8sCg9pR0Rgf2U4SjNR+davwX5FjEufMomgRsB00fg
	zyRoTfxYxXh4Y8vuiZOJjrJtRUBqHxyVXsqcdfStADiDsVoEhvGXke2IzKBOI/hb
	WiESqINaMWZlctFARnqnvnWiPTNBO/qTgrLVOx+veNXvwWI6SMXfFRzUxY07Dh9Y
	p4E9rDCnukHT+Y6EVG26BlOZ16mHO3x7KhgMU6qM64BlKcUlVNv2REetqaorOfxE
	Hv9tuR0tLZlF0MsbPIllc5+326ZsUeYtZPM3HYRousN2gYIQuhJdn4OFhBw8Ldam
	BqYL6oneEKifef2Z24hvK1SLIU1JVnxU0/X7HqUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45827p8e9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:28:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 527FOGZe009112;
	Fri, 7 Mar 2025 15:28:26 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45827p8e9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:28:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 527CW0hk013724;
	Fri, 7 Mar 2025 15:28:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2m7eh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 15:28:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 527FSKc034669078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 15:28:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC592004D;
	Fri,  7 Mar 2025 15:28:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CBC420040;
	Fri,  7 Mar 2025 15:28:17 +0000 (GMT)
Received: from osiris (unknown [9.171.2.237])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Mar 2025 15:28:17 +0000 (GMT)
Date: Fri, 7 Mar 2025 16:28:15 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 07/13] s390: make setup_zero_pages() use memblock
Message-ID: <20250307152815.9880Gbd-hca@linux.ibm.com>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-8-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306185124.3147510-8-rppt@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A6EZhWyKm6a7TATSJL5pnfOrX3P29DY0
X-Proofpoint-GUID: Cc95RTw9axkwgZElLQM4IM54NfQR-ck-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=334
 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070115

On Thu, Mar 06, 2025 at 08:51:17PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Allocating the zero pages from memblock is simpler because the memory is
> already reserved.
> 
> This will also help with pulling out memblock_free_all() to the generic
> code and reducing code duplication in arch::mem_init().
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/s390/mm/init.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

> -	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
>  	if (!empty_zero_page)
>  		panic("Out of memory in setup_zero_pages");

This could have been converted to memblock_alloc_or_panic(), but I
guess this can also be done at a later point in time.

