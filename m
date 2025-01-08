Return-Path: <linux-arch+bounces-9649-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05EA060E7
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BC41673DF
	for <lists+linux-arch@lfdr.de>; Wed,  8 Jan 2025 15:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB71FE46F;
	Wed,  8 Jan 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dshx/WuZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352701F9439;
	Wed,  8 Jan 2025 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351956; cv=none; b=Lt2naWQwc076RuQD/iGnqFzXBE7ylAUEYb3vfT98x1fABCc5WVtXqZtqDguAO7TcCue1pt7tm3RN0Ewouq+lxHak6QvC+VQ49ygt3Mcru+9kEPj6sis5Rni5GbOjFSk1RIX1Fs6QStZzu70FagapRlbKXRdWjZUYdHuRi5aAXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351956; c=relaxed/simple;
	bh=yZ84W1dpC12PZBNHbBBR3qHgkYhlLts1OxLuI8wtZig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTV+JHJqcBhgtOe9tXFnbu+sJ/FMzSa1pT0JNCJ2IVgut63HvBWxO3E65hf3hyrNQ6p6Y669NJzD/TCEAWHUX7p8MIPjRdyGXKXPb28DmK6B0ZLjJnKBlc8XLxpj2dkWuJLOf7zn9wj+1hMqL0dFS7brkaQnu3DWYy1rxEMhJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dshx/WuZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508E6Jqq032725;
	Wed, 8 Jan 2025 15:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MY+iiPye8+N17txRsEvkwvzUmMz0DV
	07GQ1GbnTJG4c=; b=dshx/WuZ0Qv/bc4mqlSJYaiOkN7jL0FodFWBDrBRH8iVF8
	WAI9eK0nOPSGi4Ue0KDd+kgkKDTntcs4bUutgiouUjDX4BlPvF1UbzvRZEeb3Yw6
	EYTqt4W5bBOGMNO5lCOURgKWnE2+9zAe6O/Oi7PzYz1zsunM//DdAAdZ5CSYAoym
	I1KKvecZW9WoTLLd5M4scUQzNpw16OKZOLo8aIO+e1US2KI25lwksMICBEo9VsrG
	Mx/KdyakeC0LBfanBnRQnFUaCc0X15p84Er7Ocmg2Dwx7xXczkSnHguQxll55fap
	bPfOIn5luAQOagl71oTApOOe3UjCBq+fJjBvpx5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5ggka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 15:57:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508Fnvql003022;
	Wed, 8 Jan 2025 15:57:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441tu5ggk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 15:57:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508DgGTv013576;
	Wed, 8 Jan 2025 15:57:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygap0dkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 15:57:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508FvsnU36372768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 15:57:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B4C20043;
	Wed,  8 Jan 2025 15:57:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4553720040;
	Wed,  8 Jan 2025 15:57:53 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 15:57:53 +0000 (GMT)
Date: Wed, 8 Jan 2025 16:57:51 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, alex@ghiti.fr,
        andreas@gaisler.com, palmer@dabbelt.com, tglx@linutronix.de,
        david@redhat.com, jannh@google.com, hughd@google.com,
        yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
        vbabka@kernel.org, lorenzo.stoakes@oracle.com,
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
Subject: Re: [PATCH v5 07/17] mm: pgtable: introduce pagetable_dtor()
Message-ID: <Z36gfzNyKLuldFvE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <47f44fff9dc68d9d9e9a0d6c036df275f820598a.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47f44fff9dc68d9d9e9a0d6c036df275f820598a.1736317725.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: idHm2yZqvsjSn96DmI6ivvBkTbSLnUtC
X-Proofpoint-ORIG-GUID: RLWMWP920gTrXASiDmVZwB5jZaufsLsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=337 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080129

On Wed, Jan 08, 2025 at 02:57:23PM +0800, Qi Zheng wrote:
> The pagetable_p*_dtor() are exactly the same except for the handling of
> ptlock. If we make ptlock_free() handle the case where ptdesc->ptl is
> NULL and remove VM_BUG_ON_PAGE() from pmd_ptlock_free(), we can unify
> pagetable_p*_dtor() into one function. Let's introduce pagetable_dtor()
> to do this.
> 
> Later, pagetable_dtor() will be moved to tlb_remove_ptdesc(), so that
> ptlock and page table pages can be freed together (regardless of whether
> RCU is used). This prevents the use-after-free problem where the ptlock
> is freed immediately but the page table pages is freed later via RCU.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
...
>  arch/s390/include/asm/pgalloc.h            |  6 +--
>  arch/s390/include/asm/tlb.h                |  6 +--
>  arch/s390/mm/pgalloc.c                     |  2 +-
...
>  include/asm-generic/pgalloc.h              |  8 ++--
>  include/linux/mm.h                         | 52 ++++------------------
>  mm/memory.c                                |  3 +-
>  28 files changed, 62 insertions(+), 95 deletions(-)
...
For s390:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

