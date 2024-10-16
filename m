Return-Path: <linux-arch+bounces-8240-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BF89A115C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 20:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0674A1F2192A
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3218C90E;
	Wed, 16 Oct 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XWzifagy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81F185939;
	Wed, 16 Oct 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729102553; cv=none; b=BZWctEm+bIw1gHTSZ+XHHglx2Bl368yu5S3COnRkQxTMc0OW1xKCasfTumgwVUcwLp3u1IXirrlCXdmxsIDML9Xqn0bRliha3XAaacj1erQX8JIY8AH5PmAJHvL6fxDSEnUJKbmLVXsQ9SSDDayadLejLaj+NMy8P29QmD7gvvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729102553; c=relaxed/simple;
	bh=JufLHtMSuGaTzBKJg/6VeV666klq+gVXM9Gg7iqlmoo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=odzQT4IsD+bKrRtyD4DOrFU0ifoszAvECB2Tbx0bYFPYWntP0N/g/62UWQ/MpyiE3mATiZ5E2Pulna9ByMZkOWGtf5M9KWh2s7QyRsjTIrdbP6xlOABLCtDtUChEkDGIll6iu7w5MMZjkw7oFBwS17yGjoZI7UEADjj7mbNNBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XWzifagy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHxvak008364;
	Wed, 16 Oct 2024 18:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JufLHtMSuGaTzBKJg/6VeV666klq+g
	VXM9Gg7iqlmoo=; b=XWzifagydH7B4bw0tHvnm/lB+4FgXIAfy4lEglWfPwncrU
	oQx+wYIUVZ+woEv/bEUzosB+AxFswJ4X9hpV3Kkr6vv78PrPMlCHi6DPzOxqBoty
	0GaKfAfyWDs4W7Gwp/M1wFkoFlqTJd7jdnvamjthyu71uiJtq0vhnhGSUomlD1Fi
	mNsQf8XowSQZIgLorYX0dEdmUN4QEJQNjKxJ9+tKAS6JOdZTTs1E3iJ7SDzhgg6n
	7NmP//l8vUjm41MgZiw1wQWYvV7SgyIl5Fx9PY6ZuKxcEy875PW0fxUxJUmo3vSQ
	i16jW4/xPBmFKhq/ppxlkSf1uLAD6ZB2bGMeEVIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ajcjr1tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:15:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GIF1EK005111;
	Wed, 16 Oct 2024 18:15:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ajcjr1tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:15:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GF0iJY005946;
	Wed, 16 Oct 2024 18:14:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4286512f5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:14:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GIEuOR27001366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 18:14:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02FBE20043;
	Wed, 16 Oct 2024 18:14:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32E4320040;
	Wed, 16 Oct 2024 18:14:55 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 18:14:55 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
In-Reply-To: <20241016234628.b7eba1db0db39d2197a2ea4f@kernel.org> (Masami
	Hiramatsu's message of "Wed, 16 Oct 2024 23:46:28 +0900")
References: <172904026427.36809.516716204730117800.stgit@devnote2>
	<172904040206.36809.2263909331707439743.stgit@devnote2>
	<yt9ded4gfdz0.fsf@linux.ibm.com>
	<20241016234628.b7eba1db0db39d2197a2ea4f@kernel.org>
Date: Wed, 16 Oct 2024 20:14:54 +0200
Message-ID: <yt9d5xprgbj5.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aVgmt4uBhiNvRvAHxsRA41t7dXjhThcz
X-Proofpoint-ORIG-GUID: BHPv_kPDWrWmiNA2N_cY_1A-wk1t9MVb
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=626 mlxscore=0 priorityscore=1501 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160115

Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:

> On Wed, 16 Oct 2024 14:07:31 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> writes:
>> I think that still has the issue that the size is encoded in the
>> leftmost fields of the pointer, which doesn't work on all
>> architectures. I reported this already in v15
>> (https://lore.kernel.org/all/yt9dmsjyx067.fsf@linux.ibm.com/)
>
> Oops, thanks for reporting. I should missed that.
>
>> I haven't yet fully understood why this logic is needed, but the
>> WARN_ON_ONCE triggers on s390. I'm assuming this fails because fp always
>> has the upper bits of the address set on x86 (and likely others). As an
>> example, in my test setup, fp is 0x8feec218 on s390, while it is
>> 0xffff888100add118 in x86-kvm.
>
> Ah, so s390 kernel/user memory layout is something like 4G/4G?
> Hmm, this encode expects the leftmost 4bit is filled. For the
> architecture which has 32bit address space, we may be possible to
> use "unsigned long long" for 'val' on shadow stack (and use the
> first 32bit for fp and another 32bit for size).
>
> Anyway, I need to redesign it depending on architecture.

Could you explain a bit more what redesign means? Thanks!

