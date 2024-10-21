Return-Path: <linux-arch+bounces-8367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E139A6F87
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11F7E1C21806
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7561CCB4A;
	Mon, 21 Oct 2024 16:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JaJaAar5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827421CCB49;
	Mon, 21 Oct 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729528398; cv=none; b=Y68W/lMNclZ+4YwRRI65I4fNirsOQ7cbc6+oFaUfoyeHrjwvgW5zw2tYKYIf83jWpeZKrCXcY9JwDF3nR30jny8ftlxe2lFcQBC7pwBjIUGPbIDFRd3e4sqjDdj40wqFIqMw5MA7H9EozGUPSGmgiqSjIxXNxtTGZ6NgkcrbAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729528398; c=relaxed/simple;
	bh=/ZEE4dAHja/jx7hFXES/3WuoWLb6cL1AwZWxWpfkPgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNNO6kdVsvq9BdHJuCG3tNGQTldcFRGvXXyz0+jNfk51W/u219tF8GhzMQlkeywGFplTd8ipcsKtfPIpnOu3q3+iaAyiiYg8dStP1t6P31Z3eOjmkoVKcdV6HOLDKhAM45aZSGe7PJgP5NhrP+1QDlKANYWJ9l/R5RjXWtTlXPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JaJaAar5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LDWsMu002198;
	Mon, 21 Oct 2024 16:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=EgVTOIVuHrUx3+a0PIe3la/66sN3of
	ubW/eCXQTIKxU=; b=JaJaAar5Estf+NHXglGlbPEfOqCuygCieGI9sxbFK0MS88
	/kK1RT/WX2986IXWK4YzsoMBnORNYeXNtQk6GMuVU2K2xXgS+cwOHhAnza52WCGo
	r2w0r72PCbvPjOGYzrhsU4/sMyyhEZUuS1I2LzBDRtT2aj3XtpvGN/7nLdxtVJv4
	dz7bPmQoY9T4BScf+P8lzcEHS+6OoYxwVsw4aDIQ3xzldnNmC2+FEii41jEM6QE+
	9fLzthRKP+C4dhR7TM0i3KR1k8JM+NKw/s+EOatWwxaczlo5xNDDmIBC3smmR99b
	1EgUyUSebjzvlNmqmXC0vvsaj5BICIYj45WDCbvQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5gcjdw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 16:31:50 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49LGVnnE023432;
	Mon, 21 Oct 2024 16:31:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5gcjdvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 16:31:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49LFNcgx009312;
	Mon, 21 Oct 2024 16:31:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cr3mq9cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 16:31:47 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49LGVhGD34210552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 16:31:43 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0851620043;
	Mon, 21 Oct 2024 16:31:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EF7220040;
	Mon, 21 Oct 2024 16:31:41 +0000 (GMT)
Received: from osiris (unknown [9.171.37.192])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 21 Oct 2024 16:31:41 +0000 (GMT)
Date: Mon, 21 Oct 2024 18:31:39 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v17 11/16] fprobe: Rewrite fprobe on function-graph tracer
Message-ID: <20241021163139.6950-F-hca@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
 <172904040206.36809.2263909331707439743.stgit@devnote2>
 <yt9ded4gfdz0.fsf@linux.ibm.com>
 <20241016101022.185f741b@gandalf.local.home>
 <20241018124952.17670-E-hca@linux.ibm.com>
 <20241022001534.96c0d1813d8f4a26563d4663@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022001534.96c0d1813d8f4a26563d4663@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9AmhKf9TQJNJT2m-e7Wp5uIZfJT77FFT
X-Proofpoint-ORIG-GUID: ST7FdDqbz5b8uQa9hqBd-wmwS1X93w4b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=454 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210118

> > Please note that this only works for addresses in the kernel address
> > space. For user space the full 64 bit address range (minus the top
> > page) can be used for user space applications.
> 
> I wonder what is the unsigned long size (stack entry size) of the
> s390? is it 64bit?

The s390 kernel is 64 bit only. So unsigned long is 64 bit as well.

> > I'm just writing this
> > here, just in case something like this comes up for uprobes or
> > something similar as well.
> 
> I'm considering another solution if it doesn't work. Of course if
> above works, it is the best compression ratio.

I'm think we are not talking about uprobes here, and everything ftrace
related would just work (tm) with the first four MSBs assumed to be
zero.

