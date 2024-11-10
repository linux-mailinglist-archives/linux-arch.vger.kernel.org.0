Return-Path: <linux-arch+bounces-8961-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD4E9C33E5
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 18:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E553B1F2129A
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043FE13B592;
	Sun, 10 Nov 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sCcq2szq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961E12D758;
	Sun, 10 Nov 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731258354; cv=none; b=sv6vhVfGad3OqXaDkd3snDD7MUGRtdoP52c80kmdOXVMMnPnFZHZGlNxa8J4J/GHjvydLYQitAn9gIL5iIvO7K0wL2bhJDNyoC/zymRCRxSFJCvhZ34ZwYtwdCyTc5bw5WRmrafag/Jz9rX0NCmrNKegwbYCpVjzkatfTBtL25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731258354; c=relaxed/simple;
	bh=W8IBu8OYgKSWbGvUJPVuafrSAwC9pJZTPDqexPgiF44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqoUxeL5ckejZN90gbqO2tqs9vnZe60+fnJp8NHrhRB9pDu0A1qyjjozDVzO4SHDkozxXqtx+AAKbUoSXIWn132L8ztd+gPhABr846TEnG6tgBe+mEBQMm2lSmf5/B0YSRJB1wcZTNQ0Dwqu7NrBG8oiZQY/Bfr1xQ1VLwtf5Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sCcq2szq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAFQGiX031518;
	Sun, 10 Nov 2024 17:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=w9UgQPRR37++TdBcs9cU8wlUS7kfeK
	sLzG25KHuCYbk=; b=sCcq2szqvl7V388Evf81ubigfPzqtOJNzlcNBvsY99W98O
	gOjAjQ29ZmdSGDI6S9qyQZ9bZqHgxtcI44Gep0IQAfrWTQKZ1l20GgScmV1xioDq
	J97YpP+g0v+w1QEFcJv1ASn0FWoR+LjCYLHwKbp/ibrT1184HD0bEvHz17F1S77c
	PRV6HKiBhswtOm1HCxb7bf+ibJgCo64e6uukqrOyKFMwfqjfZ2Xb5++jbrQQd8Ia
	5h0Z/vR4Pfn1M+Nh/zCcXfu/bK8OoDbrfyhc+SeUWPUOA32EU0acocfOAWkxT0uU
	HaNWufxPDin76lDfr0J+olmOOzAM4HNy9U4F9BRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tpvmsd22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:05:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AAH5EnY016863;
	Sun, 10 Nov 2024 17:05:14 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tpvmsd1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:05:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAFVWrx029688;
	Sun, 10 Nov 2024 17:05:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjk5udm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:05:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AAH59Sc58851720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 17:05:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 780B020043;
	Sun, 10 Nov 2024 17:05:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30DAD20040;
	Sun, 10 Nov 2024 17:05:08 +0000 (GMT)
Received: from osiris (unknown [9.171.74.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 10 Nov 2024 17:05:08 +0000 (GMT)
Date: Sun, 10 Nov 2024 18:05:04 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v19 07/19] tracing: Add ftrace_fill_perf_regs() for perf
 event
Message-ID: <20241110170504.6661-B-hca@linux.ibm.com>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
 <173125380933.172790.13871919598133716103.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173125380933.172790.13871919598133716103.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mDl8ANvFO62Yl3Du7gW-GA6W-IDMkZTL
X-Proofpoint-GUID: VTiNSnrSFul-aTZQ_oPMYdMgRFJUlpu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=681 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411100151

On Mon, Nov 11, 2024 at 12:50:09AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_fill_perf_regs() which should be compatible with the
> perf_fetch_caller_regs(). In other words, the pt_regs returned from the
> ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
> used for stack tracing.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm64/include/asm/ftrace.h   |    7 +++++++
>  arch/powerpc/include/asm/ftrace.h |    7 +++++++
>  arch/s390/include/asm/ftrace.h    |    6 ++++++

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

