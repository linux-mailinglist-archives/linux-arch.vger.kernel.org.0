Return-Path: <linux-arch+bounces-8219-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A129A045F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 10:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB97C1F28F76
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 08:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EA1F8185;
	Wed, 16 Oct 2024 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d6XodqGe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DF1BE871;
	Wed, 16 Oct 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067657; cv=none; b=amsI4IAzZzCeYwTBD4YNf6VlScB8YmvxibQLs+FO+niHxOc2bg8upsQurABCDTIlMruePXzO4nejxD1T4FMoKlb4EpgTNv19cA5SfFAeMuC5SX6n+uXf8n5JZlMyrKQ3aw31iiLcJsccTIJWpTfpG7nafN1BwfwqX/VWN5pXOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067657; c=relaxed/simple;
	bh=3ixjSPj57/3HkHGg+1AgHR7Q4xBBgsWAjhtgab4RGGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HQcBba1EN8JiTmmstF8gQvXIIf2qJt71egDVBuGAJhWBlY2kCmDK31jDagzsxQ7PxDOJPwXfnA6RvGkYWmSYjejQQXeXbaMsrqCxmBAArJgrUKZMDFbbCzkvbJthtNYGMNFQtSX6k+czNpIPDPf06u613WJCsRVjKW9q9yON5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d6XodqGe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G4tSLM013571;
	Wed, 16 Oct 2024 08:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=s1ClHwECgAqvw8fo7bgayDaexlCa/k
	jzSj/hte/BsI0=; b=d6XodqGefVZ2Oo3pY6raHP+3dLv8SsY/LOAnt0i62dmXK1
	hU5uCifU8RLSuMzcw7Q5Pk/rHp5A54/luTfmeDzJ2Wkz12ODQ63nc+5m/oH/W6Vr
	sZIYpxscfjlLGMYYEQVAeqTgFPU9gMTsvQxLIfDzfn5cunyKXwh3VQn7xStqQlOn
	qvpQc26z8BAlzizP4VlTtu57IeBeShr4sg4Um3MgVhCERbYdvT5aZwUNFPsreabI
	nS9u9vdoZYwPRgtF9QOgD5ms1OclAbjK8+2feiPWyyN9A06TnXWk45+hGe1rV6IT
	cUgNSaTJY9MVuirzexgTvfqg9/zz8BOOYPSmL6Gw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a6vm0x57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 08:33:32 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49G8XVG1020697;
	Wed, 16 Oct 2024 08:33:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a6vm0x54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 08:33:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G7Y1Ui006761;
	Wed, 16 Oct 2024 08:33:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk85e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 08:33:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49G8XQlq54198614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 08:33:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7003720040;
	Wed, 16 Oct 2024 08:33:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E7DB2004B;
	Wed, 16 Oct 2024 08:33:25 +0000 (GMT)
Received: from osiris (unknown [9.179.27.227])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 08:33:25 +0000 (GMT)
Date: Wed, 16 Oct 2024 10:33:23 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v16 04/18] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20241016083323.16801-A-hca@linux.ibm.com>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
 <172895575716.107311.6784997045170009035.stgit@devnote2>
 <20241015183906.19678-B-hca@linux.ibm.com>
 <20241016084720.828fefb791af4bcf386aac91@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016084720.828fefb791af4bcf386aac91@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: THvSImdZT7cNTKydum66qvZm3KuHppMe
X-Proofpoint-GUID: Ti8WhGAnHe5v38r1fomyzE9dHOz0LqKQ
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=539 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160056

On Wed, Oct 16, 2024 at 08:47:20AM +0900, Masami Hiramatsu wrote:
> On Tue, 15 Oct 2024 20:39:06 +0200
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > That would make things much simpler... e.g. your new patch is also
> > writing r3 to fregs, why? 
> 
> BTW, according to the document [1], r3 is for "return value 1", isn't it
> used usually?
> 
> [1] https://www.kernel.org/doc/Documentation/s390/Debugging390.txt

That is true for the 32 bit ABI, but not for the 64 bit ABI which we
care about. Besides other this is also the reason why I removed the
above file five years ago: f62f7dcbf023 ("Documentation/s390: remove
outdated debugging390 documentation").

If you really want to understand the 64 bit s390 ABI then you need to
look at https://github.com/IBM/s390x-abi .

A PDF file of the latest release is available at
https://github.com/IBM/s390x-abi/releases/download/v1.6.1/lzsabi_s390x.pdf

See section "1.2.5. Return Values" for return value handling.

All of that said, I would appreciate if you would just merge the
provided patch, unless there is a reason for not doing that. Chances
are that I missed something with all the recent fregs vs ptregs
changes.

