Return-Path: <linux-arch+bounces-7898-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F03299666A
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 12:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAD9B25BFF
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 10:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F718DF7D;
	Wed,  9 Oct 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BBNBuvqE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71C17E012;
	Wed,  9 Oct 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468343; cv=none; b=pt9fQpYLP9OSSHrqQeJLmCGo7jSE0CCI307zJoUfv75s3lyEG/XVnFN0TjY4Z5NC4ClJ81VGvdX7lgUXNw9X3jbdxGJhp8Dz5kX3d7lm3deOtzonoF6C6ub8ZtR8RRJVvIXKNnTDs6n2d7OmEQ3KfEkHoP0UoLwBTyG+0kbe62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468343; c=relaxed/simple;
	bh=XTWDFFN0K/4CnanN15KfWFAABgOA1DcvEox26LpRj/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3Lw2l1txpdHAhcR022nHdQfbrabV05VnCb7co/1r5UQOcN+0KHasQVjdGdA28c2w6Js3aJMSdp8Yp4spk1C0hgu5NFCKntscLLLPthRjijSUBXK2vg6MNvrqqeeC7bQJI6s95sAKgKBBlxGzbVD+kV6YFqJLC9+o3W+jaJsEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BBNBuvqE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4998t1Wr001951;
	Wed, 9 Oct 2024 10:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=nVMC8hWUl3VGZIi+W4/90+yYg49
	AVX/ZNYZZyeu1uvw=; b=BBNBuvqEM7vLCJOWfbdID2sz5eKqLmDhlh698K+Y1r0
	amEBjvn1xK8YcAeryzZfpXgWNCtPpxBwlsldn4OXzT9SysVaPRdtCo7EI8XH+V3A
	rHBjPWUpcMhcq1vqh0yUvY12/fEgA9HvnyYUkIELd05TALN/8r97/33ciKUkMx6c
	h4/R1Bs9CUmsVHbfCann5YncukcPLtwYOEI7BhqhYr6+dAUJC1X0QNrZ/DunGPi2
	0QRgewxjYn3bbp6nDswA39EvtnPEqYqoLnJgB0ogISv+IDXTJWEFzt0g83ZhS5rh
	dWv/fMWNimKUYgLPMX8I+RcVo7SUZMlIhtHfEwXCVUQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425pqw89c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 10:05:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 499A58Wh000664;
	Wed, 9 Oct 2024 10:05:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 425pqw89bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 10:05:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49982aEu030179;
	Wed, 9 Oct 2024 10:05:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsms47w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 10:05:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 499A55Xj41157058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Oct 2024 10:05:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55D2B2004E;
	Wed,  9 Oct 2024 10:05:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4DAA2004B;
	Wed,  9 Oct 2024 10:05:04 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Oct 2024 10:05:04 +0000 (GMT)
Date: Wed, 9 Oct 2024 12:05:02 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v15 09/19] tracing: Add ftrace_fill_perf_regs() for perf
 event
Message-ID: <20241009100502.8007-E-hca@linux.ibm.com>
References: <172639136989.366111.11359590127009702129.stgit@devnote2>
 <172639147435.366111.834128908630424679.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172639147435.366111.834128908630424679.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bm4H5rA_QgZ7Sc9h873tvvfylZD7pSVb
X-Proofpoint-GUID: 1nlkCiRZbXhaiNpfV4GBRo2mRiRcpGM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_08,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=590 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090064

On Sun, Sep 15, 2024 at 06:11:14PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_fill_perf_regs() which should be compatible with the
> perf_fetch_caller_regs(). In other words, the pt_regs returned from the
> ftrace_fill_perf_regs() must satisfy 'user_mode(regs) == false' and can be
> used for stack tracing.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
...
>  arch/s390/include/asm/ftrace.h    |    5 +++++
...
> diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
> index 9cdd48a46bf7..0d9f6df21f81 100644
> --- a/arch/s390/include/asm/ftrace.h
> +++ b/arch/s390/include/asm/ftrace.h
> @@ -84,6 +84,11 @@ ftrace_regs_get_frame_pointer(struct ftrace_regs *fregs)
>  	return sp[0];	/* return backchain */
>  }
>  
> +#define arch_ftrace_fill_perf_regs(fregs, _regs)	 do {		\
> +		(_regs)->psw.addr = (fregs)->regs.psw.addr;		\
> +		(_regs)->gprs[15] = (fregs)->regs.gprs[15];		\
> +	} while (0)

After reading your commit description and looking at the code I think the
s390 implementation of perf_arch_fetch_caller_regs() is at least
suboptimal: it is not possible to tell if an address belongs to user or
kernel space by looking only at the address (psw.addr); this also requires
to look at psw.mask. It _looks_ like all current callers of
perf_arch_fetch_caller_regs() initialize the passed in pt_regs to zero,
which of course also sets psw.mask to zero, and therefore
user_mode(regs) == false is satisfied.

However I'd rather make that explicit and don't want to rely on
callers. Therefore the above arch_ftrace_fill_perf_regs() should
set the mask to zero

		(_regs)->psw.mask = 0;

I will change perf_arch_fetch_caller_regs() accordingly.

