Return-Path: <linux-arch+bounces-7364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AD697E743
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B83C1C210F8
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2024 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2037604F;
	Mon, 23 Sep 2024 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mCfr1jkX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16047F484;
	Mon, 23 Sep 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078938; cv=none; b=arv6zS28sTGzoJ97p73Nq3hxDFQR6C3PYD8F1BaiKvV7MvJTnSQgLWyuSXXOpOsAwuPo543rlsjKhOYMcTzBFQdY7b22RJ2YXZjWB593e763dSDFnfJLPOaUN7d3bonU1Xtf/m5sqxyPspY1y7W7weqdhjv87p0BhW3da/02CHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078938; c=relaxed/simple;
	bh=DpxhoiVY4UveFzijoTaZZuYDPDgdMW8hSTAj3Aw1WtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q+jmL1Kj+/Cm3vCl3z6yX8urYjHN7PojbUewNxHoCG4uiYPc2h+sbi13khAVYtNe2s0fYwUKLGoomSoxR01bjUxhJ6JWWAzBAkCAcyk/TfKxMNTbUfbQfOmLblvZMwZRES2N1fFDSt/bbmBp7nPpwY85PWv1WGiP0GQKK8GZ7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mCfr1jkX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N1nNUg026249;
	Mon, 23 Sep 2024 08:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type; s=pp1; bh=1R9JlDqk6J0Q09htjggzzB6TZ2
	8LP8W5JbuY7zcW460=; b=mCfr1jkXIfMG5PUV/2avPEKDfIHBU3MJWHgETurzEG
	1l1U5Bufckz4Ol5dLdXuavFzIwCCgkT8oxmiCR7EFxwJHO/biSkgS1SCWvcpVsLg
	uVXNWIHB0VTUCVD+4EUqAv3pAmCulrtmpwyjdL5EJrfEvGLedWQ0k/GHrd6yE5if
	jJODLhj9gMMmM+Shd9WiKt+LqBt0MFkWm1XgHPrlFS4fK4+wL2D2T0o/zdYWeqbm
	zkHTTtTvYI68rUaYzFBFxmeMEZJPlZ6j6+LOVsw4QSx+uLoUZO76A0qjvOIq/KUK
	LJ0cEVLqVySw6pbibn8gg6HANqUnOvpZh305xrg1AnnQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna2f27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 08:08:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48N84U49023386;
	Mon, 23 Sep 2024 08:08:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snna2f23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 08:08:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7Gn4n000668;
	Mon, 23 Sep 2024 08:08:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41t8fudhxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 08:08:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48N880k218743704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 08:08:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C68672004D;
	Mon, 23 Sep 2024 08:08:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF1A20049;
	Mon, 23 Sep 2024 08:08:00 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 23 Sep 2024 08:08:00 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark
 Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v15 13/19] fprobe: Rewrite fprobe on function-graph tracer
In-Reply-To: <172639152107.366111.11355494843935654791.stgit@devnote2> (Masami
	Hiramatsu's message of "Sun, 15 Sep 2024 18:12:01 +0900")
References: <172639136989.366111.11359590127009702129.stgit@devnote2>
	<172639152107.366111.11355494843935654791.stgit@devnote2>
Date: Mon, 23 Sep 2024 10:08:00 +0200
Message-ID: <yt9dmsjyx067.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LLRWWqtHpZxdyP_87_aFJYy56ygCj52M
X-Proofpoint-ORIG-GUID: Cg4VZKSNlROPP6jDB8fnjbZeTePXL0PW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_04,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=799 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409230056

"Masami Hiramatsu (Google)" <mhiramat@kernel.org> writes:

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
>  Changes in v14:
>   - Add ftrace_regs_get_return_addresss() for riscv.
>  Changes in v12:
>   - Skip updating ftrace hash if not required.
>  Changes in v9:
>   - Remove unneeded prototype of ftrace_regs_get_return_address().
>   - Fix entry data address calculation.
>   - Remove DIV_ROUND_UP() from hotpath.
>  Changes in v8:
>   - Use trace_func_graph_ret/ent_t for fgraph_ops.
>   - Update CONFIG_FPROBE dependencies.
>   - Add ftrace_regs_get_return_address() for each arch.
>  Changes in v3:
>   - Update for new reserve_data/retrieve_data API.
>   - Fix internal push/pop on fgraph data logic so that it can
>     correctly save/restore the returning fprobes.
>  Changes in v2:
>   - Add more lockdep_assert_held(fprobe_mutex)
>   - Use READ_ONCE() and WRITE_ONCE() for fprobe_hlist_node::fp.
>   - Add NOKPROBE_SYMBOL() for the functions which is called from
>     entry/exit callback.
> ---
>  arch/arm64/include/asm/ftrace.h     |    6 
>  arch/loongarch/include/asm/ftrace.h |    6 
>  arch/powerpc/include/asm/ftrace.h   |    6 
>  arch/riscv/include/asm/ftrace.h     |    5 
>  arch/s390/include/asm/ftrace.h      |    6 
>  arch/x86/include/asm/ftrace.h       |    6 
>  include/linux/fprobe.h              |   53 ++-
>  kernel/trace/Kconfig                |    8 
>  kernel/trace/fprobe.c               |  639 +++++++++++++++++++++++++----------
>  lib/test_fprobe.c                   |   45 --
>  10 files changed, 535 insertions(+), 245 deletions(-)
[..]

> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 90a3c8e2bbdf..5a0b4ef52fa7 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> +/* The entry data size is 4 bits (=16) * sizeof(long) in maximum */
> +#define FPROBE_HEADER_SIZE_BITS		4
> +#define MAX_FPROBE_DATA_SIZE_WORD	((1L << FPROBE_HEADER_SIZE_BITS) - 1)
> +#define MAX_FPROBE_DATA_SIZE		(MAX_FPROBE_DATA_SIZE_WORD * sizeof(long))
> +#define FPROBE_HEADER_PTR_BITS		(BITS_PER_LONG - FPROBE_HEADER_SIZE_BITS)
> +#define FPROBE_HEADER_PTR_MASK		GENMASK(FPROBE_HEADER_PTR_BITS - 1, 0)
> +#define FPROBE_HEADER_SIZE		sizeof(unsigned long)
> +
> +static inline unsigned long encode_fprobe_header(struct fprobe *fp, int size_words)
> +{
> +	if (WARN_ON_ONCE(size_words > MAX_FPROBE_DATA_SIZE_WORD ||
> +	    ((unsigned long)fp & ~FPROBE_HEADER_PTR_MASK) !=
> +	    ~FPROBE_HEADER_PTR_MASK)) {
> +		return 0;
>  	}
> +	return ((unsigned long)size_words << FPROBE_HEADER_PTR_BITS) |
> +		((unsigned long)fp & FPROBE_HEADER_PTR_MASK);
> +}

I haven't yet fully understood why this logic is needed, but the
WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
has the upper bits of the address set on x86 (and likely others). As an
example, in my test setup, fp is 0x8feec218 on s390, while it is
0xffff888100add118 in x86-kvm.

Regards
Sven

