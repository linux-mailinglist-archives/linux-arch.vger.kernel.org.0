Return-Path: <linux-arch+bounces-15839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF33D38F4D
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B093014DB0
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877E202C5C;
	Sat, 17 Jan 2026 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZVmpNk7F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62130B67E;
	Sat, 17 Jan 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768663363; cv=none; b=uok9c+vhZOWFgTIIVow2delIaH7DBebftqiGrIvTpYC8ddWfNkahi80pII1LqsCf7FvniuzXmrPNQpFLvGZXeEDR4BFfCE05eDwcNEycTWog/WC32Mf70LqwC8ziT9wvQjntecPs1nHbunNsZ4EC4CRGzWn6ffF0q3U9BsR8fAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768663363; c=relaxed/simple;
	bh=N7HXwdjfE30uqy04iJU1FStgTIhiDvhGzOQxh9Ebvro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmnNWXWy0sf+QjM+pDZrIQI+da+0gQNQfkT/Pb/8lHhhX4A3bAelwxpfmISttlVJieZ0ntaP9Zl9B8oyrtirn+V33loXPJ1yGSia3WpiKDqJvzE08BhTiLB9/2gMiBqAqqnXrhnKWBHTJjyVNfXBZMPwdidMaC0x1edUpKekMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZVmpNk7F; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60H9uQIW022057;
	Sat, 17 Jan 2026 15:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=39V+5n
	TQx+ZGw4NWhKS5TRKL8x8VYeVQW3Z2+AElGIA=; b=ZVmpNk7FYpAsSSfh2qsnLL
	4cT4ffdjOAi6sO3KNv8NykuPC+0ab99Z5G/kf2wiMastZWtHTwyuAjNeUSHkkETG
	REPuxwQG2Et1ct0bRBm5CpB/vad5Lf2FUesonF/TAVOsH9y/Yo9JjtWs3XmqG5HN
	eVS3pL7kZhQyGJeHK4wvUq9KygyulxXmLQo73fFtFFXP1pCGI4ykx6NEJH70b5fJ
	MFpW4LVJ0XJq/vdMTTYpEzYSPdaJq5G/KNVYC75bGsq8MtsFTY0cZ3beqF6xBRWX
	1v+XfQD+znk8GN+Leln0Ld+q/ykl5F0/FmtFn1rKrnkAyywldvOWqL5bRnf8g1aA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf1hse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 15:22:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60HAo4HK021581;
	Sat, 17 Jan 2026 15:22:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bqv8uucq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Jan 2026 15:22:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60HFMHrG36176378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Jan 2026 15:22:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C4520043;
	Sat, 17 Jan 2026 15:22:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBF7620040;
	Sat, 17 Jan 2026 15:22:16 +0000 (GMT)
Received: from osiris (unknown [9.111.69.86])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 17 Jan 2026 15:22:16 +0000 (GMT)
Date: Sat, 17 Jan 2026 16:22:15 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/4] s390/vdso: Trim includes in linker script
Message-ID: <20260117152215.9947Cd3-hca@linux.ibm.com>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-3-4a83b4fbb0d3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116-vdso-compat-checkflags-v1-3-4a83b4fbb0d3@linutronix.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0_Q8dhcxnTwvsodtYh7ZiRR6Ct30TEZc
X-Proofpoint-ORIG-GUID: 0_Q8dhcxnTwvsodtYh7ZiRR6Ct30TEZc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE3MDEyNyBTYWx0ZWRfXxAqNzok56/7J
 YxADf3KtO309+FCgjdhZ+ykru8inQlM6HmFCI2DBBR9Dw8mKP6BllHvDAdJFZS7hxx7F4YgqQZn
 ZIJncmWnku0p3LYOruUOIZa5ztAXQW8o05nnvjiqG2P8y+DdcKH19zIA15FRteFPaMKUstxJ3L+
 n2fu5WOHuFVqC3xYqMI8Su8RwS7gyKYfQnIL2diydSj2OfJzTM8LJy71JuIJYmyhvTrk/cK431C
 VWwDH3YfNaqIMgLrxoHWsv47tegfXGh7PuwZ0PoRJ/v6CNfv8ILGNVzSSZ9spMk7N+1/p+5CMFf
 t2P6aPsvUpjkTJwwd0gTUMV03obtgzqSRL+4y3aRKm9RHVpwAs4CIXdwD+PD+Ba1DSiftzhs5wu
 dJq+fR9Z6s8WnlfKdzxiDgwVn/TCSuFHAAkwkJXqcvRLLEzZR8RtC1g66wpD/I5uZYL2Jwj81gu
 6LNwz5tprgM+uqZBNKw==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696ba92e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=96DDLKwRfJTpT7j2upIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601170127

On Fri, Jan 16, 2026 at 08:40:26AM +0100, Thomas Weiﬂschuh wrote:
> Some of the included files are unnecessary or too broad.
> 
> This is a preparation for a new validation step to validate the
> consistency of __BITS_PER_LONG. vdso.lds.S may be preprocessed with a
> 32-bit compiler, but __BITS_PER_LONG is always 64.
> 
> Trim the includes to the necessary ones.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/s390/kernel/vdso/vdso.lds.S | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com>

