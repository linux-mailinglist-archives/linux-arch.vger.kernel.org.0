Return-Path: <linux-arch+bounces-8959-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258409C33DF
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 18:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D78280F6D
	for <lists+linux-arch@lfdr.de>; Sun, 10 Nov 2024 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E996D130A73;
	Sun, 10 Nov 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VJsFhROb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0D81749;
	Sun, 10 Nov 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731258326; cv=none; b=uuun5VY1qG+cs9+9k4QRQWCxiCScnOReZyuXnJYq3v0XbN67jd8pvPA6alZ9TSv13Lp7zPK14ob0k7g0Ywqfkl/rDJ1UwqYix8Kxj5BHC5mD+67tF71GWpR19f/3ki5qAUzr3Iahe6bLA5VJ6LiNvvAAHqaWwsCpOoHTLyQlIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731258326; c=relaxed/simple;
	bh=Pnh3433UtHsbIP9/dYZxTpk00g1+JZSbalZdN33ybvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LggVJDnPWZDtKGzBWq0TY7hLbTq9RfCr321Epf6o2P7uF278lwYHZhVUfzpRKKoBCZCj0s9ieRGpjuP1gW9dRHz2Wrhl+NGHDaNdS5aFq8O0F81ppebNpHrT1Nzkpn4Z/GYnEFu54poIRWlJEmB1+GjLu32Vn4pW5xu3veuUAGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VJsFhROb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AABQ85T024414;
	Sun, 10 Nov 2024 17:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=frQ6QYtXz5tMjJ8Ox9swnqK1a1aNNK
	cBTsSHw7pehXE=; b=VJsFhRObJYitThQEqjAIsMuoGRseEjDNnOJihVcv4iSAoH
	lAO+DequcP6W2vm6+BrcQroo8jl3UD9noUUl0V0S+lCLFT7R6SpLYdaG6LsYkXGP
	MVlnKtBlLoTWpjmtbFpiU8qydsZLw9oB+oqe86j0SS8lYPO4xaOl9BgP50SwVtE3
	TLMHce9EjmzjbvbitbrqUIJUDTxoG8Vt4vbHQXwBpPuOXW6NFdWO4QZyi3B4OLVx
	Wc+LsxmLeqJLMQNSl15mFllgen1i2CctWJ68Kox/+SnDmoLe/34dJ2iATUdGsNyd
	TmkwwUSJZoaGV/q8wTFVx0n+OWoZTjng8RbRtopw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tqass9yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:04:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AAH4K0E007951;
	Sun, 10 Nov 2024 17:04:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42tqass9yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:04:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AAGPktE018059;
	Sun, 10 Nov 2024 17:04:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tk2mry51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 17:04:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AAH4FgP35324206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Nov 2024 17:04:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4020820043;
	Sun, 10 Nov 2024 17:04:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACD6520040;
	Sun, 10 Nov 2024 17:04:13 +0000 (GMT)
Received: from osiris (unknown [9.171.74.231])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 10 Nov 2024 17:04:13 +0000 (GMT)
Date: Sun, 10 Nov 2024 18:04:12 +0100
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
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v19 05/19] fprobe: Use ftrace_regs in fprobe exit handler
Message-ID: <20241110170412.6661-A-hca@linux.ibm.com>
References: <173125372214.172790.6929368952404083802.stgit@devnote2>
 <173125378270.172790.5407978814601760638.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173125378270.172790.5407978814601760638.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y4KkmDzv_RfQUUDzdkAuzUGlBSRvEsau
X-Proofpoint-ORIG-GUID: lTz9pkfDChxrEnI8Wbh9YNbvhWacrVls
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=3 priorityscore=1501
 spamscore=3 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1011 impostorscore=0 adultscore=0 mlxscore=3 mlxlogscore=147
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411100151

On Mon, Nov 11, 2024 at 12:49:42AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Change the fprobe exit handler to use ftrace_regs structure instead of
> pt_regs. This also introduce HAVE_FTRACE_REGS_HAVING_PT_REGS which
> means the ftrace_regs is including the pt_regs so that ftrace_regs
> can provide pt_regs without memory allocation.
> Fprobe introduces a new dependency with that.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes in v16:
>    - Rename HAVE_PT_REGS_TO_FTRACE_REGS_CAST to
>      HAVE_FTRACE_REGS_HAVING_PT_REGS.
>   Changes in v3:
>    - Use ftrace_regs_get_return_value()
>   Changes from previous series: NOTHING, just forward ported.
> ---
>  arch/loongarch/Kconfig          |    1 +
>  arch/s390/Kconfig               |    1 +

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

