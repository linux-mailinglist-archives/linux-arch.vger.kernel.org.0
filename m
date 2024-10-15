Return-Path: <linux-arch+bounces-8187-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9DF99F5CA
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 20:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAE6281E38
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DB2036EE;
	Tue, 15 Oct 2024 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XyI0MA00"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182892036E3;
	Tue, 15 Oct 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017590; cv=none; b=BkE/ohC8iUPe2VGNnmZTEAVFfhUIYb+D3C1mHvyunJjOkdKdppPAisWuFqz6ypxO55k4m3bauPxnXRxfQp0M15KbW5wSL9IEctkWKRyLwwwSA1Sb+7x6v8RGuDq3IK++U6r4v8KU3G7S0sDT8g4l36l33uXhUY/rUNoHS/uqkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017590; c=relaxed/simple;
	bh=WMMPQa5nz5uL37eLh4HB6ilkOBqJrEE/WBB+kf3KXjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Oh6SBobCdvaphX0iKbl01/z3L2kyhh87Id63u14+hbR896G5QvtFIhAATeSfwGVxG1yGxOeny8F8Jk6RdDxn377oR5Wo8KGh6Hd1BEl+Pt1+ohm7r5WGzHnWB1xeoUKN/ZkSRBK4fFU90PnOxsHWL8ecLzR75JyFUJrGeFX+kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XyI0MA00; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FIPV6N007905;
	Tue, 15 Oct 2024 18:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ss7iI6bkPoaS+Y+L8y+5qkCxYznDSP
	pd817IDjqbwYo=; b=XyI0MA00kTyqok4qAWlHaEIUQRmdKlb93lIjXp0Sn8rI91
	+l0yxe24Gq+aBHH6tOFskudaQjNdrTCAmULM03pTIdub2mi65s4soT8xoUm1uxEw
	bbi+u7sLAskNl2IohMUHugtClZKgx/suz/ND7Mydqe+ZugkX8PbYoEZmsxPE/slR
	cc7RI7FiYPswK1JAeKB+FJ1U6n5gCFxtA77dg51V21HpSUMO+ZFWDikFm3nAttqj
	Fq+THFSZRTpL94XWGg4MUuA8zimgIBycx8Hn/sCobDx+G9Mam+pfVfkOGpf0pmjq
	6IVqEzNg2D5wtCClUvavSz4QzpjV2knZKAfuy14A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429wng82fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:39:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FIdELe007012;
	Tue, 15 Oct 2024 18:39:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429wng82fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:39:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FH1m8v027452;
	Tue, 15 Oct 2024 18:39:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txnfs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:39:12 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FId8Q952035914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:39:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5F6020043;
	Tue, 15 Oct 2024 18:39:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9394C20040;
	Tue, 15 Oct 2024 18:39:07 +0000 (GMT)
Received: from osiris (unknown [9.171.70.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 18:39:07 +0000 (GMT)
Date: Tue, 15 Oct 2024 20:39:06 +0200
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v16 04/18] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241015183906.19678-B-hca@linux.ibm.com>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
 <172895575716.107311.6784997045170009035.stgit@devnote2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172895575716.107311.6784997045170009035.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Us35ezRVuJAVPgZnL8yf-hXVmLe3f8Pi
X-Proofpoint-ORIG-GUID: I6MloaO0jd-bMySZ7vuHW5gMDDRmrOF9
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=351 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150126

On Tue, Oct 15, 2024 at 10:29:17AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> on function_graph tracer because of simplifying the callback interface.
> 
> The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

...

> diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
> index 7e267ef63a7f..a9ca56ea0858 100644
> --- a/arch/s390/kernel/mcount.S
> +++ b/arch/s390/kernel/mcount.S
> @@ -134,14 +134,15 @@ SYM_CODE_END(ftrace_common)
>  SYM_FUNC_START(return_to_handler)
>  	stmg	%r2,%r5,32(%r15)
>  	lgr	%r1,%r15
> -	aghi	%r15,-(STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE)
> +	aghi	%r15,-(STACK_FRAME_OVERHEAD+STACK_FRAME_SIZE_FREGS)
>  	stg	%r1,__SF_BACKCHAIN(%r15)
> -	la	%r3,STACK_FRAME_OVERHEAD(%r15)
> -	stg	%r1,__FGRAPH_RET_FP(%r3)
> -	stg	%r2,__FGRAPH_RET_GPR2(%r3)
> -	lgr	%r2,%r3
> +	la	%r4,STACK_FRAME_OVERHEAD(%r15)
> +	stg	%r2,__PT_R2(%r4)
> +	stg	%r3,__PT_R3(%r4)
> +	stg	%r1,__PT_R15(%r4)
> +	lgr	%r2,%r4
>  	brasl	%r14,ftrace_return_to_handler
> -	aghi	%r15,STACK_FRAME_OVERHEAD+__FGRAPH_RET_SIZE
> +	aghi	%r15,STACK_FRAME_SIZE_FREGS
>  	lgr	%r14,%r2
>  	lmg	%r2,%r5,32(%r15)
>  	BR_EX	%r14

Why didn't you simply merge the addon patch which I provided, and
which I tested?
https://lore.kernel.org/all/20240916121656.20933-B-hca@linux.ibm.com

That would make things much simpler... e.g. your new patch is also
writing r3 to fregs, why? The stackframe allocation is also wrong.
I didn't try, but I guess the above code would crash instantly.

