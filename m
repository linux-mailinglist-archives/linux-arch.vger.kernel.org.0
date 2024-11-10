Return-Path: <linux-arch+bounces-8963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 726BA9C33F2
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 18:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32C3F2811C9
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6E313775E;
	Sun, 10 Nov 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c4vg8FMP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199E483CC7;
	Sun, 10 Nov 2024 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731259036; cv=none; b=ZK6eXgWgTbE1WPD+yWZrr4UOhGC9Vyo0w9SKr+j0Z0azvNy6btM4XsCyyrSUDqdbWYGDAeyu9ktfyjZfUav35QVO6mCUBUgJtCr7A9c5rZC2x0ASRMLlBDPMREoCh85p0b+jmDcyZm1WDK7qFXNzRJVkQvyqoZX+Ng+urF5vRIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731259036; c=relaxed/simple;
	bh=d/Nbv/2a4fNGYpYfknQMtQ/oP/laBmvhR1O2gSULEUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGIBYSSNZ3Z2xxtrLutlvBqz9+xY9zXre3Wea3Zhjhy8vlX5OniHncZkMH5fIIaxOJnNeG38H6qDQsVWP2u26KsGfyu0U8kPencYD5Mw3h2MooHypyMURJHM+JudiPcz9RbjtMoN2g4iLodt/RCI0VrmUEn/NqQddp6+eau8HqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c4vg8FMP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAFb5L1032278;
	Sun, 10 Nov 2024 17:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=lFd4Fam7Rl/a+c8SETSijmhw1wHdaw
	vG28+eDPKUbTY=; b=c4vg8FMPd5AkvBn7/EwHFTHjzKEByCnTy9mxwklBTl5QOB
	Iup4yAtEAtH083cxsjawyIAccQpg3ZKNVHK5mwQR/F9B4XMNwUqvyIiTSTTD8ziH
	e8FETXvslUZspkYOBGnIgcotR2fRV1le+A3egia/S5xw5rkCtz8h2H6i84R9/n7Z
	5lRQRjxnUeNa505alx/OH8Xg/TLH86GVkDdRe1qL2zYsv+YUWdj1prIYfXUxWFP1
	ZAwJkkXrMOq6DAVatxG0R6FCGxBQah9KUWwtcgAV4ohtZfM3KJeB0w1AJDNWxDPz
	ZHD/JBr9YnC0myexcE7sUaP/uc8Vbzosb3v/hcWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tjg3a9qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:16:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AAHGjEu019200;
	Sun, 10 Nov 2024 17:16:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tjg3a9qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:16:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AA2gvH9007218;
	Sun, 10 Nov 2024 17:16:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tm9j8vnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:16:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AAHGeVw21692846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 17:16:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D150E20043;
	Sun, 10 Nov 2024 17:16:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E3F20040;
	Sun, 10 Nov 2024 17:16:39 +0000 (GMT)
Received: from osiris (unknown [9.171.74.231])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 10 Nov 2024 17:16:39 +0000 (GMT)
Date: Sun, 10 Nov 2024 18:16:38 +0100
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
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v19 13/19] fprobe: Add fprobe_header encoding feature
Message-ID: <20241110171638.6661-E-hca@linux.ibm.com>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
 <173125388510.172790.1161831132316963172.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173125388510.172790.1161831132316963172.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GJCKposUAeWJS4L6p4y06TvBF-vByzu7
X-Proofpoint-GUID: n_GXdkFm3pIvgXraT9dt0EiUt6IaSzmq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=345 lowpriorityscore=0 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411100151

On Mon, Nov 11, 2024 at 12:51:25AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fprobe store its data structure address and size on the fgraph return stack
> by __fprobe_header. But most 64bit architecture can combine those to
> one unsigned long value because 4 MSB in the kernel address are the same.
> With this encoding, fprobe can consume less space on ret_stack.
> 
> This introduces asm/fprobe.h to define arch dependent encode/decode
> macros. Note that since fprobe depends on CONFIG_HAVE_FUNCTION_GRAPH_FREGS,
> currently only arm64, loongarch, riscv, s390 and x86 are supported.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/arm64/include/asm/Kbuild       |    1 +
>  arch/loongarch/include/asm/fprobe.h |   12 +++++++++
>  arch/riscv/include/asm/Kbuild       |    1 +
>  arch/s390/include/asm/fprobe.h      |   10 ++++++++

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

