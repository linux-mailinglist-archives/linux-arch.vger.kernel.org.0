Return-Path: <linux-arch+bounces-8266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC8F9A3ED7
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 14:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22DC1F266DA
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C353D43AB0;
	Fri, 18 Oct 2024 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gyaRwtGS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E172032A;
	Fri, 18 Oct 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255849; cv=none; b=RsGm3fSrQyafPi9GMK7o1PkLu+nxUCB6hJ03jkPlJ2LFQ5hczyQnAITe5a2zgQqQGVJmgeQgTmuUNdTIsOpG12FyV2CmLA5ur5Zz2lmusMg+qxnfje2XEP7hgi5IZ2dDZJYK5DK5vYVqKHSMoIn7M5CWsG4xDu0OgSRTqHJOLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255849; c=relaxed/simple;
	bh=UiEODK30WMf6c99as8tczI3ce9+36ip9+CEDUbshnfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKUtXmvkorPFgGREtm7TqOaTyqynmPrA/61w8XVMrsCvO6SFTTV5s8Wv2kd+PeumDxmHOp8hQ/3Bekad8HMoWnuXI7Lz2p2f9lH6yyRlLF1aUsUOLKyqs932RQ9BUVK2KSXSC7e11hPgJafGBpDF/Yq3UlNc1i9x7fS4g9ZN7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gyaRwtGS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I5ZBjP011784;
	Fri, 18 Oct 2024 12:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XSncqozF5VzTrwK4gClpEKpFn30dbM
	DgMlseiEjUKOw=; b=gyaRwtGS8IXzLTpHXi1MIwbH2HRW0uhbOjq6lah7+Vgwrj
	JXmSH45vch0H7zx3Vt/t8kk1jeAGl/MZUSxUxEO/ks9Q8U0jEJi9PXhwuHJK6LgU
	/QTOTzvtFAk8mfKAghAsj8VoDoFaq2KVcB8yTBq3B+Q7KcVDCIhi8F9ETP/7O4G9
	fmgr047Z2/63WLno4XVb2NMil6PbGOVVtyv7UyAzo4Jrolf6pAA8aUaNnhU1bf6N
	nm/LT1j1xhSm5aSLFJMCMn11izW5Q2J25nS5klYNjp9BUEt0dstfx5Do0qxADcvW
	sTA0oCAB+0SOolzPb18747QthL8XeuqoKgUCcfPA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnfa77a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 12:50:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ICn7pa023203;
	Fri, 18 Oct 2024 12:50:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnfa776-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 12:50:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBnIhL006415;
	Fri, 18 Oct 2024 12:50:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xkmfcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 12:49:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49ICnu1B17105376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 12:49:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA0782004B;
	Fri, 18 Oct 2024 12:49:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EAC920043;
	Fri, 18 Oct 2024 12:49:54 +0000 (GMT)
Received: from osiris (unknown [9.171.52.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Oct 2024 12:49:54 +0000 (GMT)
Date: Fri, 18 Oct 2024 14:49:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
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
Message-ID: <20241018124952.17670-E-hca@linux.ibm.com>
References: <172904026427.36809.516716204730117800.stgit@devnote2>
 <172904040206.36809.2263909331707439743.stgit@devnote2>
 <yt9ded4gfdz0.fsf@linux.ibm.com>
 <20241016101022.185f741b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016101022.185f741b@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UUW38Z9rXO76MvRYA0XJsM_S28KlnPP_
X-Proofpoint-ORIG-GUID: VuHSGxc_ruZFY61dIrF2n3tsSHHcNP1E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=610
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180080

On Wed, Oct 16, 2024 at 10:10:22AM -0400, Steven Rostedt wrote:
> On Wed, 16 Oct 2024 14:07:31 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
> > I haven't yet fully understood why this logic is needed, but the
> > WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
> > has the upper bits of the address set on x86 (and likely others). As an
> > example, in my test setup, fp is 0x8feec218 on s390, while it is
> > 0xffff888100add118 in x86-kvm.
> 
> Since we only need to save 4 bits for size, we could have what it is
> replacing always be zero or always be f, depending on the arch. The
> question then is, is s390's 4 MSBs always zero?
> 
> Thus we could make it be:
> 
> static inline int decode_fprobe_header(unsigned long val, struct fprobe **fp)
> {
> 	unsigned long ptr;
> 
> 	ptr = (val & FPROBE_HEADER_PTR_MASK) | FPROBE_HEADER_MSB_MASK;
> 	if (fp)
> 		*fp = (struct fprobe *)ptr;
> 	return val >> FPROBE_HEADER_PTR_BITS;
> }
> 
> And define FPROBE_HEADER_MSB_MASK to be either:
> 
> For most archs:
> 
> #define FPROBE_HEADER_MSB_MASK	(0xf << FPROBE_HEADER_PTR_BITS)
> 
> or on s390:
> 
> #define FPROBE_HEADER_MSB_MASK	(0x0)
> 
> Would this work?

This would work for s390. Right now we don't make any use of the four
MSBs, and they are always zero. If for some reason this would ever
change, we would need to come up with a different solution.

Please note that this only works for addresses in the kernel address
space. For user space the full 64 bit address range (minus the top
page) can be used for user space applications. I'm just writing this
here, just in case something like this comes up for uprobes or
something similar as well.

