Return-Path: <linux-arch+bounces-9609-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C78AA026B5
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 14:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD47A021F
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 13:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FC91DCB24;
	Mon,  6 Jan 2025 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PDtlb5Bs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC10159596;
	Mon,  6 Jan 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170550; cv=none; b=g0ED9+NDoYDORD8RyDKkXG9y2nLWCrrqz43dna0+VzS2c1Wlwc3JHhXLxVRvmw4GlyKmVWgmjXfZADi0mY29ABUcAyam4WTr+HVhti+ZrDkzaM8zF73S+JO585ZMx0b0uM1DdKEmBa8ZKLoke7jy3BqPOsx+dl0si3aB1XlBlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170550; c=relaxed/simple;
	bh=+T3CCLCXRAjTkFnYgLafh4r3DV6xN3g0BJaJzftrmsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFP8ypKGDcvFJVkqgJ+eqpqygUPNDA+2tm8BomVYgr58fGFYclpjpzk/0W/sFqKftT65GycyA3IxGzDsjxs8TWkfq8qk+N4uF+H7oOrOGK/5eHDnx7svwn8TP1cOizYKVVEXSerh1gs6apMOZEGMiULFhOIrpPUxKXTkcr/rAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PDtlb5Bs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506BoOUG007085;
	Mon, 6 Jan 2025 13:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lrftkFSyTk2s/yfIapFP+84J+Q9Pn5
	cd9LVcrQZ2iI8=; b=PDtlb5Bs7aIfNSK6IDvwDAT5115xFIn9zs/UvICAM0v+eC
	g+1dQHbRORY4WtYTVHnBGKFMHlsum17PMdPkHxGG8c+Hk1qp9gIgNYqampQyph/L
	7+Iyu3Eh2EL1ZpXOQqlTp9xf9jcs+nnkA/SqlGB9wfOgk1Z76TLVBFPp6KnEhUsl
	sep4v9WCj9iFJA/3XWeaTiTAe7D25ZLWuotAgyhqA1PeYHgzC7zVd2fp37ltKmwk
	1OHrieDYwJU2jzFyuqubKBLa6kUkQKGeQoJ14ralKi0q47s3GP2C4b4LbiHXFbXr
	ywPBX6l8sMXsvIHzw6tl4sOCH2VAVHQCEGwb2Spw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4403wajp6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 13:35:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 506DZ01B000336;
	Mon, 6 Jan 2025 13:35:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4403wajp6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 13:35:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5069PNdl003571;
	Mon, 6 Jan 2025 13:34:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfasx25x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 13:34:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506DYvtv53149954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 13:34:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4295C2004B;
	Mon,  6 Jan 2025 13:34:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A410720043;
	Mon,  6 Jan 2025 13:34:53 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.26.127])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 13:34:53 +0000 (GMT)
Date: Mon, 6 Jan 2025 14:34:51 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
        tglx@linutronix.de, david@redhat.com, jannh@google.com,
        hughd@google.com, yuzhao@google.com, willy@infradead.org,
        muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
        arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org,
        npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
        ryan.roberts@arm.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v4 06/15] s390: pgtable: add statistics for PUD and P4D
 level page table
Message-ID: <Z3vb+0MktvDNysQD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <35be22a2b1666df729a9fc108c2da5cce266e4be.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxVkg3i7zXI92e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <a3a2bd64-9952-4c66-8626-f2436ce07d1d@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a2bd64-9952-4c66-8626-f2436ce07d1d@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XFfmZXEbdi1lmX4sTCZJHlLIWFA4SLIH
X-Proofpoint-ORIG-GUID: N1gUawSn25jz-02tMlFh_LT5dfHmG37b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=703
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060120

On Mon, Jan 06, 2025 at 07:05:16PM +0800, Qi Zheng wrote:
> > I understand that you want to sort p.._free_tlb() routines, but please
> 
> Yes, I thought it was a minor change, so I just did it.
> 
> > do not move the code around or make a separate follow-up patch.
> 
> Well, if you have a strong opinion about this, I can send an updated
> patch.

If you ever send v5, then please update this patch.

> Thanks!

Thank you!

