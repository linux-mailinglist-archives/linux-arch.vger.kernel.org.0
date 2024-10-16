Return-Path: <linux-arch+bounces-8239-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CAA9A1152
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 20:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63385B25766
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CC1210C29;
	Wed, 16 Oct 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WhE8Uygb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B518A933;
	Wed, 16 Oct 2024 18:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102479; cv=none; b=Pc2YwuaIJMqjUm2kcTArlQH0rJGxRsD/55vYrsA7xkSCtmiEQS6dJXw0PDndP/jLy8nH4PWBcd4PVSoR7Vrp8jBfZcqaPYD43O5F9KPJ1ZtwqEyXXbnjk+iEQCWK12VqY+6yDGY/n4bm7zJ68w1Hs+iSEjQBY6O0BtMBF2fKV1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102479; c=relaxed/simple;
	bh=LuUZlapvI84DdJZHU9QMoCDC+FCF9KdOGMfDaQYtbQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=BDeOtmvn0bfZ++9FHeKW5MuEzhu27wR4zCuoy49txhpk+R1AMfnIvsayWRkNGxV/+GZ24sI1kKOFMg5x6/9ZVbhr10cxUhK7U3s586Gnh9uDf7p692UavCL+kBUAsFhaHbkiJ+o62Xk9tk37tXCWzwnx9vw78OB6J/a4jcMgAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WhE8Uygb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGo2TY027587;
	Wed, 16 Oct 2024 18:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=gEUxcOe9Ffkf05DAObJrOzHApc1WNv
	zljlsK5BIJmpo=; b=WhE8UygbgECe86BrZHE5+vPV0zNpOd3+JpVpsMtcoB7+2d
	vGtg4yt4OfF/oY+Wiw1PPLrEqBntk1ON+hvgvvpvZ80icX9tSctAIVnVkYCrI6qM
	ogYmdrd775fjfxg3aA2yoVF4MKuY895knbCSIeT5MD/X8H+yoUGgYE4kl5UQSZzy
	asxXf/Epsg+S55FUptnwLJ51oexx65GpQfJ2XSnfM+SXe6Y9lbmO4/BL1iRrGJTU
	4KJQPuWCFj3IsTnMA1HeaiSvOZg691KvOS1skn/J/TfkXxDwtwfTmUYip6u4qlI8
	1NvT0Z3AXYzSpz1Cbuf2cNNm+xaWrPpXcxOtofSw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahbr0avh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:13:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GICmD4007410;
	Wed, 16 Oct 2024 18:13:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahbr0ava-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:13:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GGTD9u002408;
	Wed, 16 Oct 2024 18:13:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284emtuf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:13:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GIDQWH54919478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 18:13:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C7720043;
	Wed, 16 Oct 2024 18:13:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C922004D;
	Wed, 16 Oct 2024 18:13:25 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 18:13:25 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
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
In-Reply-To: <20241016101022.185f741b@gandalf.local.home> (Steven Rostedt's
	message of "Wed, 16 Oct 2024 10:10:22 -0400")
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
	<20241016101022.185f741b@gandalf.local.home>
Date: Wed, 16 Oct 2024 20:13:25 +0200
Message-ID: <yt9da5f3gblm.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jgMfR1X7UjfollVmKBkZZEBGkodkC0dW
X-Proofpoint-ORIG-GUID: dyEvInqsMKjOzSGioAThkCdgUFrU3kvR
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=520
 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160115

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 16 Oct 2024 14:07:31 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> > +/* Return reserved data size in words */
>> > +static inline int decode_fprobe_header(unsigned long val, struct fprobe **fp)
>> > +{
>> > +	unsigned long ptr;
>> > +
>> > +	ptr = (val & FPROBE_HEADER_PTR_MASK) | ~FPROBE_HEADER_PTR_MASK;
>> > +	if (fp)
>> > +		*fp = (struct fprobe *)ptr;
>> > +	return val >> FPROBE_HEADER_PTR_BITS;
>> > +}  
>> 
>> I think that still has the issue that the size is encoded in the
>> leftmost fields of the pointer, which doesn't work on all
>> architectures. I reported this already in v15
>> (https://lore.kernel.org/all/yt9dmsjyx067.fsf@linux.ibm.com/)
>
> From what you said in v15:
>
>> I haven't yet fully understood why this logic is needed, but the
>> WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
>> has the upper bits of the address set on x86 (and likely others). As an
>> example, in my test setup, fp is 0x8feec218 on s390, while it is
>> 0xffff888100add118 in x86-kvm.
>
> Since we only need to save 4 bits for size, we could have what it is
> replacing always be zero or always be f, depending on the arch. The
> question then is, is s390's 4 MSBs always zero?

s390 has separate address spaces for kernel and userspace - so kernel
addresses could be anywhere. I don't know think the range should be
limited artifically because of some optimizations.

