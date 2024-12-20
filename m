Return-Path: <linux-arch+bounces-9455-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7359F94E6
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 15:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C977A1A2A
	for <lists+linux-arch@lfdr.de>; Fri, 20 Dec 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F821882F;
	Fri, 20 Dec 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eDSwEVQ5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98561A31;
	Fri, 20 Dec 2024 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734706351; cv=none; b=i5GkT2b3ZU3dxkFnSSVKWg/hczkzSYXwanH/zIysEqtMsgruNp9KR+HWmWvrjygRSevw1GOMMCuaXHsMcfF3IKxGQPU+fYq/WfW0WYjOtq/5V7UlnekSY3RWkvB2r+x8Ic1sgtyH/kuvXvxhOqk52Rk/8U0uX2UXRTbtWJ7kpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734706351; c=relaxed/simple;
	bh=ZJ5/0AjtwEVJhSAe2QiMxUUTnv/SLWtSjiviGvRk79k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOk2Mqz5oOfUIV+jhhiBQL167mUEakoYqb2FFV0gx7CRSaPiQ83HnenXtckwfEBHNslUMOkC2DbijMGzUckTcYxkQHBZ8PECQctNODsGxJMhGJKP6ReGPkUGcK/SmHmCOR5zmgcKKwTphp5he8Hg+hBtG/P6E53MrMyGDNIswwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eDSwEVQ5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKDCLVp002618;
	Fri, 20 Dec 2024 14:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mKPrT1JelCj+eZ9nHFa7ke5vVUTVXA
	p3dlHcoxg1Dxg=; b=eDSwEVQ5yCFtlmrAYF/SiyrhJIpx9uIfQsq3y2ujHPg1QN
	zgMoCaEZLqxSPEcBol35h5WPMr9t/1X6E8kP+2JasCj7JNHY5+NF1AV2E0hhxWKF
	5PfhymWbzwh+2RMlV4pJxJprD2KugJWXeHt4p5vSuerXejCEED9hd+DmpmQo1VHX
	KQv6aB8eOC3jmkaAGZ6YnOJ3eP20t4sjrVrBZIQi1hv91ECkoFis6UG9KXEqAumJ
	KFiNqGJWNQKDz0L+uUuZKn3g11DgCOy24QpPaaxMFDvSbRFvl9UahaRpdX7m/80e
	xhY6y2GX3sudthVrGtN/y7UbA44A2jz/1HVUuodg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwmhkedu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 14:52:05 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BKEn46u001174;
	Fri, 20 Dec 2024 14:52:04 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwmhkedh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 14:52:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKC2BLA014412;
	Fri, 20 Dec 2024 14:52:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hq2226nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 14:52:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKEpxRK55378300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 14:51:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7890820043;
	Fri, 20 Dec 2024 14:51:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FA7E20040;
	Fri, 20 Dec 2024 14:51:58 +0000 (GMT)
Received: from osiris (unknown [9.171.21.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 14:51:57 +0000 (GMT)
Date: Fri, 20 Dec 2024 15:51:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
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
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v21 03/20] fgraph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241220145156.12646-B-hca@linux.ibm.com>
References: <173379652547.973433.2311391879173461183.stgit@devnote2>
 <173379656618.973433.13429645373226409113.stgit@devnote2>
 <20241219163448.7fe08f79@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219163448.7fe08f79@gandalf.local.home>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HrynHg9cz6mMkipmk1AxHMwVIG6LuECb
X-Proofpoint-GUID: noteq2OLo4fWPoG6xjEDGLY8ZX2H4bwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=383
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200119

On Thu, Dec 19, 2024 at 04:34:48PM -0500, Steven Rostedt wrote:
> On Tue, 10 Dec 2024 11:09:26 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Use ftrace_regs instead of fgraph_ret_regs for tracing return value
> > on function_graph tracer because of simplifying the callback interface.
> > 
> > The CONFIG_HAVE_FUNCTION_GRAPH_RETVAL is also replaced by
> > CONFIG_HAVE_FUNCTION_GRAPH_FREGS.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Did Heiko ack this? I don't see it in my inbox.

Yes, I did:
https://lore.kernel.org/lkml/20240916121656.20933-B-hca@linux.ibm.com/

> Heiko,
> 
> Does the above look OK to you?

Looks still good to me.

