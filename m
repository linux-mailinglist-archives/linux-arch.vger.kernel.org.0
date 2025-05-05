Return-Path: <linux-arch+bounces-11844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAB6AA9064
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC273B3C4F
	for <lists+linux-arch@lfdr.de>; Mon,  5 May 2025 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162421DF254;
	Mon,  5 May 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rSXq/GKo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E793EAE7;
	Mon,  5 May 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746439035; cv=none; b=IMm3Ll4lsmhNWsvWVmKWvFJ9Uk667MT4stxv1CjtW8Ab4RN4e3CNGzm3JqHqT8rlcRuI4krCce6bLUb+qyx4UHoOmVO79XWqDLGMfMxlnivKulKmqnWk41iKEliQPFDJ5r9COvzH2hWIWpWjNd84AnDY4Rb0ApQEUd/27EPjx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746439035; c=relaxed/simple;
	bh=DdUUTkfnlA9fK+AY7ESBEJWr8GgX2XsTVOxe0gHjLFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bni5rZoUSa7tFjJcbVho9H6VjxNaHnp5onVjsW4EdAG839Kfgf2r0py2xR7SEu2y87+1C1L95tnccpp57MXAhEhBzuCXgRFyf/1jUiV/YTzTIiE0gMAbX3dsi/ZqSsHmxjASKS0y+ADy/CaDNhAGYP20oZybWPLW9dBv2L1K7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rSXq/GKo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 544L4Asp030724;
	Mon, 5 May 2025 09:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=LhUGs6EEJ+/H8XoxFLa+sktR1zW0IF
	WrMGyaiWI3uTk=; b=rSXq/GKoEvm8sjQA6bU+/dc88eodbGbZLyvF6AgQZiLo2S
	WjYYCeP6GftDPgY2HF7yzJQ0soHbyonEaeaq0vCbvFQO27xFjCGQcwD20UvcQd8J
	y7FYHmS5Etq8GRGK8567LQV2KvqmLWXE58p746hWMb37aoju6eS/msyOQAqioFwi
	JNa5xxXgVSamEUyT8Ppr+1SUJWVXIrKcImFyV1ndvHyxVPAjhEvzarbQU+/EPnD+
	x1sdwGR1biLXggbkXtamzJoKccuWA3lGV0++0oaIO2zXYLyBtV9sOe93euKLL4DC
	ssebMectqwwdqBS3FABjSD26ee4qONHgpaGdNB9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46eftkjaxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 09:56:38 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5459ou9E002673;
	Mon, 5 May 2025 09:56:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46eftkjaxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 09:56:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54579DSq025969;
	Mon, 5 May 2025 09:56:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dwuynsg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 May 2025 09:56:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5459uWsh59113944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 09:56:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C39520043;
	Mon,  5 May 2025 09:56:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F009B20040;
	Mon,  5 May 2025 09:56:30 +0000 (GMT)
Received: from osiris (unknown [9.111.37.115])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 May 2025 09:56:30 +0000 (GMT)
Date: Mon, 5 May 2025 11:56:29 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v9 2/9] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <20250505095629.13658Aea-hca@linux.ibm.com>
References: <20250227221924.265259-1-lyude@redhat.com>
 <20250227221924.265259-3-lyude@redhat.com>
 <20250228091509.8985B18-hca@linux.ibm.com>
 <1491bedb15db7317d2af77345b2946c2529c70b1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491bedb15db7317d2af77345b2946c2529c70b1.camel@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDA5MSBTYWx0ZWRfXwwP0h4V48zhW 0AVSEswbTvJIy33/TC7mPjmelx5mY/fBKGqOfZeO62vdclxmwgmEzdZ23P6nHJ79SHfb1/Cc8bM P5zZ/+4RgCWhqwoC0lFvAr4xBtyqTHVFIdavnZSF6vJ+Q+Ko+gZnR70DWEV+OnZUvab9wR1aU6l
 /+T81fMYkazI5rIDrqnJwPRQQnPNbzT1rmL80QY1Y1gz7LWJfH/pD0WPURTfWAkA0XlhL6E2CDO e/Kug34Y7PRy9TbQV4W94TPYiVsFucZ+Xp8lFLWq73iK1sSNcSTFQjkPhM/WU2JoGLyh7aTkfz3 7oupbUF3uvbw8G5DwwczPeylex+rlypqmpZ2bTkyxxiq5CZIscj089xXeELVEjflCR3711/I7Xj
 lB26F3+9oMDm+Jk3IU7C2kqArGZynSBmWL7vYs3vjcHt6f9oF4diQUrRNzZ5XBB07CGI5XEn
X-Proofpoint-GUID: VP6z2O9dsYmZNNJdubnfxfxKgcPntrt1
X-Authority-Analysis: v=2.4 cv=Q7vS452a c=1 sm=1 tr=0 ts=68188b56 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=1J5S7fVpQaFMGjp2_GYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QgC67dW-fUJDkaoN9Kch0MBUP2vTEdIS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_04,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=833 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505050091

On Wed, Apr 30, 2025 at 05:38:02PM -0400, Lyude Paul wrote:
> On Fri, 2025-02-28 at 10:15 +0100, Heiko Carstens wrote:
> > 
> > Well.. at least it should not, but the way it is currently implemented it
> > indeed does sometimes depending on config options - there is room for
> > improvement. That's my fault - going to address that.
> 
> BTW - was this ever fixed? Going through and applying changes to the spinlock
> series to get it ready for sending out again and I don't know if I should
> leave this code as-is or not here.

Well, this fix was that the atomic primitives, like used in your code, would
always fail to compile. That was address with commit 08d95a12cd28
("s390/atomic_ops: Let __atomic_add_const() variants always return void").

So yes, you need to change your code like I proposed.

