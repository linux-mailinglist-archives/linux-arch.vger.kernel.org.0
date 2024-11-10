Return-Path: <linux-arch+bounces-8962-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFA79C33E8
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146301C2093D
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E2F1386BF;
	Sun, 10 Nov 2024 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oKbC6L9u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C1D4594D;
	Sun, 10 Nov 2024 17:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731258477; cv=none; b=k79JpZjK0ObAZNT4M3POc9KbvzIIoKdBeaD8SUAfo1/oLSALnemSfWj1a+gEDlAjLn3ufsATIrOTYJ8kWcLi9Wec9fVlyhfKR4I1Altw/9VT3d6ULQa1NNK1vp7SgoEiWdmCXqxVm0XVdensM5EpZovW32+V59AqF8jmcnwx/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731258477; c=relaxed/simple;
	bh=h60pEsIQpOR1/jSz0MbvvPG4Nuacn2L5RGrtOYqjjog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdGoD9qinZsb++zuXqNNT1kLHEf4+HoIsrnerlfD0GBTvZuRthWsbsUP1VMwe1ul8uWd8VOOo+k/ZObEaCx3Kd1jstJJaPH8tawaGPfXLqHrj3PgQST1oX5YTAwinqTYLq0LKuaOWtJNlSVDf5uENXKAhIn2GfLO+kTn2SMPb9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oKbC6L9u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAFb5Ki032278;
	Sun, 10 Nov 2024 17:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Fyttpba9yUUO6fCu6rMH3lKtKc9KsN
	UyGlgNKi1Ih2M=; b=oKbC6L9uPt5jsN2l5/TQ28E7qs+6jFqB90CbVvz0N40qvp
	q9UoqJLTCgqqnVkvm9sqlEg7NnLQH2v6B/iy0+0glGA2FjtLUI/ivnKTEkuPmcLn
	u9j21sA2dxSznFI1A3p0ueIJ4JJ6zZrzjLvTICfbhGdWe+LKV9e1rhWbAR+md1eR
	GVRNstc1PEcupTLwnNoBTdO6qDLidg+hqQaIZIL2ozYUeyZfShMDQhSy26uglrDO
	IVlp04YQwU6boaWg8xNpTS+RJUr5Xr0t+AHFx446fvqALOQhzutvPlGrzKMTc6Ic
	TZ/ZejsMGJ2i05xOqQEmE5ZPZYoR4kCXfQtMhpOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tjg3a944-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:07:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AAH7MB3003803;
	Sun, 10 Nov 2024 17:07:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tjg3a940-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:07:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAFVWtB029688;
	Sun, 10 Nov 2024 17:07:21 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjk5ux6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:07:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AAH7HTv39322004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 17:07:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44FD020043;
	Sun, 10 Nov 2024 17:07:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF80A20040;
	Sun, 10 Nov 2024 17:07:15 +0000 (GMT)
Received: from osiris (unknown [9.171.74.231])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 10 Nov 2024 17:07:15 +0000 (GMT)
Date: Sun, 10 Nov 2024 18:07:14 +0100
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
        WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v19 12/19] fprobe: Rewrite fprobe on function-graph tracer
Message-ID: <20241110170714.6661-D-hca@linux.ibm.com>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
 <173125386944.172790.10278368602020246931.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173125386944.172790.10278368602020246931.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rdhWYV-Fr8MreJ0VWZbe0TF3N1RWiPHL
X-Proofpoint-GUID: QTHKXNGy9oTA1Zp4hBNbPcOoy1xbMP0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=457 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411100151

On Mon, Nov 11, 2024 at 12:51:09AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Rewrite fprobe implementation on function-graph tracer.
> Major API changes are:
>  -  'nr_maxactive' field is deprecated.
>  -  This depends on CONFIG_DYNAMIC_FTRACE_WITH_ARGS or
>     !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS, and
>     CONFIG_HAVE_FUNCTION_GRAPH_FREGS. So currently works only
>     on x86_64.
>  -  Currently the entry size is limited in 15 * sizeof(long).
>  -  If there is too many fprobe exit handler set on the same
>     function, it will fail to probe.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/arm64/include/asm/ftrace.h     |    6 
>  arch/loongarch/include/asm/ftrace.h |    6 
>  arch/powerpc/include/asm/ftrace.h   |    6 
>  arch/riscv/include/asm/ftrace.h     |    5 
>  arch/s390/include/asm/ftrace.h      |    6 
>  arch/x86/include/asm/ftrace.h       |    6 
>  include/linux/fprobe.h              |   58 ++-
>  kernel/trace/Kconfig                |   10 -
>  kernel/trace/fprobe.c               |  637 +++++++++++++++++++++++++----------
>  lib/test_fprobe.c                   |   45 --
>  10 files changed, 539 insertions(+), 246 deletions(-)
...
> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> index fd3f0fe9f7b3..a3b73a4f626e 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -77,6 +77,12 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
>  	return ftrace_regs_get_stack_pointer(fregs);
>  }
>  
> +static __always_inline unsigned long
> +ftrace_regs_get_return_address(const struct ftrace_regs *fregs)
> +{
> +	return arch_ftrace_regs(fregs)->regs.gprs[14];
> +}
> +

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

