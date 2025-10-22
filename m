Return-Path: <linux-arch+bounces-14249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A633BFAFB8
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3847189EFCF
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 08:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD9F3064BB;
	Wed, 22 Oct 2025 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C5kuHeMa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BD30649A;
	Wed, 22 Oct 2025 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123155; cv=none; b=q5KxQwKHDb09WR3RlcyT4U7JQL+zH2YKpE/SYrwqN5dWM0u9WtCpJENKvVH5M9L6bzH+bjkNwhLMqJ7zPlHPEIpbWEnzSjDWsfm0Z/zNyBNbd70VoGWAmsgOyR23nctU7sVB+5+891Kn36keXKPY/KMJzWCeMxsTFmt0keOcUJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123155; c=relaxed/simple;
	bh=a/aYw9um5mmbOeR+Zc4NkjwlXD1bC6f0L9h0bx/RsnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfIQhndteEdiEh6Ohxhr7yNjmh7sD0KIWqacBIm7SXIGm5oYehqlqRKwKFvS7UUFi4ASRzkpe+07G9RDcLyWXcHsUhGGf5l0JoI3c9iG7E6m8CobkKk/bYxo6ct51sATjVB0j0i2SXaJ+AeIpwOXw4v01tg3aTRdpxiMNbqAcPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C5kuHeMa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LMwNdg001260;
	Wed, 22 Oct 2025 08:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=x5nVMa1XAhPUXMnT7ptKtvcjLmXqVU
	h5yjJZ/45AaLc=; b=C5kuHeMafLvRh6Ei3XDjCPDykk3uXii9FHRMwPjdkO4okZ
	wqVVbjEAuHThQCNR2i6L7hRXABA9k2yyowOV8Mj1XW9nNhHjR32vjDrFkUG2Blwx
	A04qMTpMK+u0hxOyOafTcZDWkFpd860QOFUo66wE6lU5P6/XZOqbhnDjGxZkq8o+
	vxHl721pDEhOQx6jKYgRmkqW8ZQK/YK68nQwvnZatXMaEAU89kDtOqzXfXNJwvSR
	5oToZFFLc5JZfHhC6xAOu4CHJV1vXUKnun9IxtClDtIltf/Y8QiIOMA8j0nypudF
	Zh0Ysn+bE05QgbsLcPev/tWYYinf3o3LDLaUW5qg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s3rc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:52:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M82HwL011053;
	Wed, 22 Oct 2025 08:52:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx173v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 08:52:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59M8qNn051904904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 08:52:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B20DB20049;
	Wed, 22 Oct 2025 08:52:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A49420040;
	Wed, 22 Oct 2025 08:52:23 +0000 (GMT)
Received: from osiris (unknown [9.155.211.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Oct 2025 08:52:23 +0000 (GMT)
Date: Wed, 22 Oct 2025 10:52:21 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 16/15] bugs/s390: Use in 'cond_str' to __EMIT_BUG()
Message-ID: <20251022085221.14219A7f-hca@linux.ibm.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-11-mingo@kernel.org>
 <20250520133927.7932C19-hca@linux.ibm.com>
 <aEabAPB5Y9EbSPkt@gmail.com>
 <20250609155657.8183A92-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609155657.8183A92-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LTYgem-GKj4AYFIgCqhWGPObn1r3NOZ5
X-Proofpoint-GUID: LTYgem-GKj4AYFIgCqhWGPObn1r3NOZ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9TYRyfWiZt6G
 HWLxyKz0bQxtneu1hpUkOLO6/QebTrx6tPJf8KuEabVIbJ0Byx14sEcnb72THPL9qU/DB9H5piO
 ZOU9gky536Y/olxqJo3i242lj+skMqXS0Do8dWszIQVRcelwo5s1vQBrcdkgKe7yUu8ohbhl7lf
 tlsSOW3q19+qKQRlZiHTm8aPt6VBvZC1k6JbryziAj1N8JazbAgC4XjxQeQ/6PGw3gLK7dRA6Fa
 vsYnH5kmKUcBlnRQHUcj5fHQJszhNs1j4yBwXHS1xDyDDbhsiOCnCHpdYxbzWOxoQHQbJveBOeP
 eVPkVxGjdgi94HqYMt8kffXTNt/e77lkJwTbnU4jmSABOhyQ5HUuGHfO4GdUb+FzptS8UexjaW/
 IyHALLPA4ydtjFLjThQuXBgieEJNlg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f89b4c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=h8emfhCFL6kOGPYS9jUA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hi Ingo,

On Mon, Jun 09, 2025 at 05:56:57PM +0200, Heiko Carstens wrote:
> On Mon, Jun 09, 2025 at 10:27:44AM +0200, Ingo Molnar wrote:
> > So I'm not sure what happened: I tried to reproduce what I did 
> > originally, but my naive patch ran into assembler build errors when a 
> > WARN_ON() macro tried to use the '%' C operator, such as 
> > fs/crypto/crypto.c:123:
> > 
> >  include/linux/compiler_types.h:497:20: error: invalid 'asm': invalid %-code
> >  arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
> >  arch/s390/include/asm/bug.h:50:2: note: in expansion of macro '__EMIT_BUG'
> >  include/asm-generic/bug.h:119:3: note: in expansion of macro '__WARN_FLAGS'
> >  fs/crypto/crypto.c:123:6: note: in expansion of macro 'WARN_ON_ONCE'
> > 
> > Which corresponds to:
> > 
> >         if (WARN_ON_ONCE(len % FSCRYPT_CONTENTS_ALIGNMENT != 0))
> >                 return -EINVAL;
> > 
> > I'm quite sure I never saw these build errors - I saw linker errors 
> > related to the u16 overflow I documented in the changelog. (Note to 
> > self: copy & paste more of the build error context next time around.)
> > 
> > Your version doesn't have that build problem, so I picked it up with 
> > the changelog below and your Signed-off-by. Does that look good to you?
> 
> Yes, fine with me.

Given that this missed the last merge I'm wondering what is supposed to
happen with this series?

It is still in linux-next, and I'd like to see at least the non
CONFIG_DEBUG_BUGVERBOSE_DETAILED s390 parts upstream with the next merge
window. In particular I'm talking about the two commits

ed845c363d8c ("bugs/s390: Remove private WARN_ON() implementation")
6584ff203aec ("bugs/s390: Use 'cond_str' in __EMIT_BUG()")

where the second commit is mainly a rework of the s390 specific bug
support.

