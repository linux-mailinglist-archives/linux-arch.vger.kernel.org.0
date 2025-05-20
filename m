Return-Path: <linux-arch+bounces-12020-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D692ABD9BE
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 15:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F769164D9A
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 13:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC00242922;
	Tue, 20 May 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VFL8plfV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F5242D8D;
	Tue, 20 May 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748382; cv=none; b=CndgO1mkQBeHXMb3wtDOumL+p9qVKhu/STqB8haPkSf9SdbhV+oYszENa1NH6d3Ligt02rFbGIE8C8ziV7LNGyZRjmm/z1tK051TDC9QICUrVBEsurKLpOtc+aJnenkxMY05bOeyrbkGtpH4IYXHoZU9VZSJTF5YYWhojqn5hpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748382; c=relaxed/simple;
	bh=JI7BRKlJ7L7TcVojKwT6FygrPqwpLlSIjE9HUyeTdAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE7yyBDhKduS1Hm1AH7uBod+eO7PWnIIRufbnQdhG3gnxyrKGIH9MiqVDdsAxZ1sPiGk8J6BXFMWe2s4uZy3oaDg/T5cd4N6FCJZqdLmOvhd5s37Jk+MlyDizNAjXOjfhQkoM7qQe1xSEE/mb1gAOe6fdf5bdkluIEKVxyYe8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VFL8plfV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K8pbg7020548;
	Tue, 20 May 2025 13:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=86cyq+9QSWpMlaNOcrGbEFCSOHlqWW
	2fF5laNvPKg0Y=; b=VFL8plfVjOiZ0OYWGxr8swfV4dWou8LCw5/dVK8GJkh/nJ
	UyjJ1Dq4Ket7NsqW5k17oihP8GeY/wbMMcHkv6mLbiODMeA9dzbN6nrIzP6aFYES
	GCaCXPdj5ihsnoIx9XgcXEgSBGuMRGrZkhYyARRt7YvQ+4tMFS6RPb6XCZPb4RPm
	0ZXXfxCcSO29xO80CFRlNN/Tu2HBNmxmvyZx2R8ytCET4j2rHEvMwdjwAuTVnBsM
	kzE+Ca4oxheHxJvwxjfJuPVJoUdVV9X+QN4ZGgnors+Oia7P5YPYkuyl8ffbUm0X
	CoaPNzkhQQ5wWM/d6pkEqIVamzcRBlWwpaZScJng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpkh9dhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 13:39:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBV35p007466;
	Tue, 20 May 2025 13:39:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q70kbxc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 13:39:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KDdSOB28705132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 13:39:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE4902004E;
	Tue, 20 May 2025 13:39:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63F1920040;
	Tue, 20 May 2025 13:39:28 +0000 (GMT)
Received: from osiris (unknown [9.152.212.133])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 13:39:28 +0000 (GMT)
Date: Tue, 20 May 2025 15:39:27 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 10/15] bugs/s390: Pass in 'cond_str' to __EMIT_BUG()
Message-ID: <20250520133927.7932C19-hca@linux.ibm.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-11-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515124644.2958810-11-mingo@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dqB4p_hWj5qOA_zyqTUADHzKIyYT-szV
X-Proofpoint-ORIG-GUID: dqB4p_hWj5qOA_zyqTUADHzKIyYT-szV
X-Authority-Analysis: v=2.4 cv=RM6zH5i+ c=1 sm=1 tr=0 ts=682c8615 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=BSkM0CFHy9RXmmpL7vwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEwOSBTYWx0ZWRfX9K4erI4hHFK+ wvt5eo6z39Nvz4Qk9abOWyNH2l2TOsw0lyrPSab16mymYywDxzrmeTlaMeR1q9y01O11bmOduIy xU0q6QkV8YRiOOK9plSz0+3mOyTvrUKef6o7x1RsMA13x8gZLSpsKYH1+DSCuOB+A7Vd5w14ZMF
 bIgdewxBsc4lpRgivR5WMJiknxV334pAeBX79wq30iN2kD2pxaYHAUrUU1B53j1k7WnxBF4IhK1 Bxv9QBGqQGUILkeXCD+6PMHST0CgOkOaJ6WDuFZiNR7Ag9YkW+Qivt6CV5BvkYlOo7YZDuUAMNJ RztNFeNbuxAqCiM7XG4ZlhG6IZGAD8J/ADaF9+osM8TgSE+hWmwU4VmAitRkLCod7i4rn4zrRSr
 qqSU9CptaW4nB/qyGAzyDjvAj3v/4/h3SvpLTTMXqDLG9yexSs/mPXEexuXPtMEjfzNbzvad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=297
 clxscore=1011 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200109

On Thu, May 15, 2025 at 02:46:39PM +0200, Ingo Molnar wrote:
> Pass in the condition string from __WARN_FLAGS(), but do not
> concatenate it with __FILE__, because the __bug_table is
> apparently indexed by 16 bits and increasing string size
> overflows it on defconfig builds.

Could you provide your change which didn't work?

I cannot see how anything would overflow. Trying the below on top of
your series seems to work like expected.

In order to keep things easy this drops the mergeable section trick
and results in a small increase of the rodata section, but I doubt
that would explain what you have seen.

Also allyesconfig builds without errors.

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 30f8785a01f5..837bfbde0c51 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -11,16 +11,14 @@
 #define __EMIT_BUG(cond_str, x) do {				\
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
-		".section .rodata.str,\"aMS\",@progbits,1\n"	\
-		"1:	.asciz	\""__FILE__"\"\n"		\
-		".previous\n"					\
 		".section __bug_table,\"aw\"\n"			\
-		"2:	.long	0b-.\n"				\
-		"	.long	1b-.\n"				\
-		"	.short	%0,%1\n"			\
-		"	.org	2b+%2\n"			\
+		"1:	.long	0b-.\n"				\
+		"	.long	%0-.\n"				\
+		"	.short	%1,%2\n"			\
+		"	.org	1b+%3\n"			\
 		".previous\n"					\
-		: : "i" (__LINE__),				\
+		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__),\
+		    "i" (__LINE__),				\
 		    "i" (x),					\
 		    "i" (sizeof(struct bug_entry)));		\
 } while (0)

