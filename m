Return-Path: <linux-arch+bounces-8186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D536F99F50A
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 20:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805A51F23AA2
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A11FAEF3;
	Tue, 15 Oct 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oXxMKnXw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961948614E;
	Tue, 15 Oct 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016334; cv=none; b=ClYzGB7L3QgnAdYGBsA+nJ0Ck5kTeSi+iSpaLHTMbU/c6Plh4f+HeqsxHLjXoQ9cnG7ZFvPGULrRe7EG3wky7l0HgnVOhnpcY4xXs51OcYjAwXq1s2CFUoQxqqGDs+a5E4EC1XZuyLC6/cPUbeikOwiJ/PVFmBz6OEJOrTuIjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016334; c=relaxed/simple;
	bh=JwHxPiXJuZclFdn5e8WGZJdc6o7BnirTKbw/DtMZwbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jnCDqJz2IW4CQdK+1Y4kjH8nrK4DWzoIRG/+Dh3iTU9R/yxBbdJUMt2+XkqeGZYY6FIq74PYq69S9sJfojbDNL72qlJhJA8gOHUMq3z8Y2m7/bAX5gHMlBcAjcMwGy0A7Mhwfva+ziAO73u5ZwLLR8L10ZXSy2G+rvWQToaNGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oXxMKnXw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHODGH011739;
	Tue, 15 Oct 2024 18:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=z9jWvZ/gm8Qq74Tyw7fwZ62BiKpBEm
	K2ZEvrNXAcRUM=; b=oXxMKnXwCx5amMohU6CS37GyuU4RSujbOh4wL35gbCULV4
	5CL3IhUzyTQSj8wyoysAigLAAQb5hNbuUpsLp+iTUprbuPP9Vey2nOsrbfpBfQV6
	gHxbXZWSIzuH8sOh/ubwMtW2dPyiWJengtaTtqy7Ybeew+I90ssjeQk0puSAp00e
	O9Y1hyfNO3e61gFJEWN+bKlvawwS6LYe5FwRub3MLQCS+/cBeV2vGZ5/chHc/1hF
	PSDpcbZBLYzrFchFF79/uAcSNuMsXx0Gzg/OCV+OQ2bbbIFQ8zQcvIr4e0jL6zbf
	dIq546Aty20ccGqoNEVeoDCX4rMAbsUvsw9hVCqQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429vrw87yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:18:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FIIBeG030802;
	Tue, 15 Oct 2024 18:18:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429vrw87yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:18:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHoNUt001940;
	Tue, 15 Oct 2024 18:18:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emnav9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 18:18:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FII6wd43254264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:18:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7DFA20043;
	Tue, 15 Oct 2024 18:18:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4881C20040;
	Tue, 15 Oct 2024 18:18:04 +0000 (GMT)
Received: from osiris (unknown [9.171.70.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 18:18:04 +0000 (GMT)
Date: Tue, 15 Oct 2024 20:18:02 +0200
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
        Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
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
Subject: Re: [PATCH v16 09/18] tracing: Add ftrace_fill_perf_regs() for perf
 event
Message-ID: <20241015181802.19678-A-hca@linux.ibm.com>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
 <172895581574.107311.17609909207681074574.stgit@devnote2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172895581574.107311.17609909207681074574.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bD2jHtvmSdCYlz0f55HyYodQIP0i2U6G
X-Proofpoint-GUID: ZKaQmoX4Y2qQZa3eReUFKrNvHdqwfXne
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=559 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150122

On Tue, Oct 15, 2024 at 10:30:15AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_fill_perf_regs() which should be compatible with the
> perf_fetch_caller_regs(). In other words, the pt_regs returned from the
> ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
> used for stack tracing.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes from previous series: NOTHING, just forward ported.
> ---
>  arch/s390/include/asm/ftrace.h    |    5 +++++

...

> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> index 5c94c1fc1bc1..f1c0e677a325 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -76,6 +76,11 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
>  	return ftrace_regs_get_stack_pointer(fregs);
>  }
>  
> +#define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
> +		(_regs)->psw.addr = arch_ftrace_regs(fregs)->regs.psw.addr;		\
> +		(_regs)->gprs[15] = arch_ftrace_regs(fregs)->regs.gprs[15];		\
> +	} while (0)
> +

This misses the feedback I gave for v15:
https://lore.kernel.org/all/20241009100502.8007-E-hca@linux.ibm.com

