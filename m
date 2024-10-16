Return-Path: <linux-arch+bounces-8221-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B839A0907
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 14:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD15D2840DB
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71033207A23;
	Wed, 16 Oct 2024 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mcBrTKfn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23021207A00;
	Wed, 16 Oct 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729080503; cv=none; b=VccVFXblYvi4isA24gQ0c8Gp455aLEXdURhURxMYzfkmF6VZyKkXOu4S78/N4020BwE6km4gDITjzYXfnL905vDbOqNkfqYDGK7yF0rvRUZ/QLk5HQo9fBcN5iYglV7OYm6qUTw3YDk2ssmRVPQJOtkE0dJaWHS7znFVxqvTyRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729080503; c=relaxed/simple;
	bh=iFXajJ+uhfYq77bvE0Buox5UIoutriZs/rZUrV1WcJE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=HVzdpHssi58uZPBZSZzHBv/BsZfU71o0n4w/soF9z7b6NZis689xs0BGRf6a7iNsrKmi0N4GTu9kboV7oEd9c35C+FoOUHG9CkprwHSIi3YnY5XNcgn3Glm+GVY514jEic02ojjiiEiheiZVx+iWd9kNmKYzd0vNV6MunS86lEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mcBrTKfn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9Opr9023504;
	Wed, 16 Oct 2024 12:07:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xXHOa8a4oOvBDuDElF/1n1rWwz2Wq3
	Ens1cHOmyVqx0=; b=mcBrTKfn2i0h/drhPN35CziaXV98CKI83nlMjqQ43nftoq
	/K5lZK3RPQicu0YfwNX8CSQ6Vwqo59Ex6Npk9YF5C5JVdyKXm3+M4bSHFhtr3hlu
	YuxDBDGez+lum788WlIPwGUlORYi31Lsa34pnrEjNScejjn1FTSGmMH56CjHSons
	uEc5hpGJlY7RZLe2uwP0G6mke/KAR9qdBJeSboI6FXDQq2p/BbzZEZJ1q+Lv0nRA
	0E7X85r7ZhXxkODZxPL74LS93J2v34M0thnZ59iV8gzK6MVf33EyM9i62PIBNGYT
	gpM58swIwB7CiLvM5epYl+R5K4fGNQexqmGstYRw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aau5rtqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 12:07:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GC06Db015836;
	Wed, 16 Oct 2024 12:07:38 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aau5rtqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 12:07:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GB8oG9005936;
	Wed, 16 Oct 2024 12:07:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4286510vkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 12:07:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GC7XV051773778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 12:07:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13B2F20040;
	Wed, 16 Oct 2024 12:07:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17A0420043;
	Wed, 16 Oct 2024 12:07:32 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 12:07:32 +0000 (GMT)
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
        Alan
 Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Paul Walmsley
 <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert
 Ou <aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov
 <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
        Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 11/16] fprobe: Rewrite fprobe on function-graph tracer
In-Reply-To: <172904040206.36809.2263909331707439743.stgit@devnote2> (Masami
	Hiramatsu's message of "Wed, 16 Oct 2024 10:00:02 +0900")
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
Date: Wed, 16 Oct 2024 14:07:31 +0200
Message-ID: <yt9ded4gfdz0.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N9NVG4Sz2Y7MUsH0Cajp52m2PEkNu3Cv
X-Proofpoint-GUID: dysTsyCVI-T_V3s46P20Mv-6vHqlE6mY
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=436
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160074

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
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>
[..]

> diff --git a/include/linux/fprobe.h b/include/linux/fprobe.h
> index ef609bcca0f9..2d06bbd99601 100644
> --- a/include/linux/fprobe.h
> +++ b/include/linux/fprobe.h
> @@ -5,10 +5,11 @@
[..]
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
> +
> +/* Return reserved data size in words */
> +static inline int decode_fprobe_header(unsigned long val, struct fprobe **fp)
> +{
> +	unsigned long ptr;
> +
> +	ptr = (val & FPROBE_HEADER_PTR_MASK) | ~FPROBE_HEADER_PTR_MASK;
> +	if (fp)
> +		*fp = (struct fprobe *)ptr;
> +	return val >> FPROBE_HEADER_PTR_BITS;
> +}

I think that still has the issue that the size is encoded in the
leftmost fields of the pointer, which doesn't work on all
architectures. I reported this already in v15
(https://lore.kernel.org/all/yt9dmsjyx067.fsf@linux.ibm.com/)

