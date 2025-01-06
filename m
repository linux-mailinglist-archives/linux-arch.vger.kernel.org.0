Return-Path: <linux-arch+bounces-9606-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03111A025CF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9FC7A2141
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 12:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13641DDC3A;
	Mon,  6 Jan 2025 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ntA6zIAK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDE41DCB09;
	Mon,  6 Jan 2025 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736167504; cv=none; b=Y1OjsqCwE0Un5SEjMJSvO/2+/yz8Sztojqup/nc8GDao4eWpoZvsaLD1dqqizIY8n/X3lO1jbtBa+mRJdp2OTa5qTVGdulEbg79CBt8EHHcnIsYU6cwYRJ8T7+ztV4cTUalzK+OgxL5/JMKufk9t4Udt7Z9DJNFSbL7L/YEmfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736167504; c=relaxed/simple;
	bh=8EJg/o2B0qrl9zIisKpYGpGw5WHYLs2yuAvac4xx5tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLE9WqTgdv+duaOUUlH9OmUZWQeZ6TJLGO/9BCA9iXyM0Jr8fotNsct7RGL7HNnIcSxAiF3qONnID/iiZgc4+46AVJ9uchPXemrWgeRKf5OoZpIHdhm0LBHt/a3CjKtQYVsS2tUoeMRW4PWf1uViNM+O5kn1cI3ucM4Ivf81blQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ntA6zIAK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5063rt7j001311;
	Mon, 6 Jan 2025 12:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7dUprz6iii0nxv85hIGsJCS0ldBed9
	AvdLxve3ElZ/g=; b=ntA6zIAKwr9Ctlh/HzpfWqu3gi5wcUsghUZNPFXuLj0M4/
	H59jMkbloFNTwWtw8o3p5H9IXi19JHU6qAvfVSyB+YTGOngkEj6Cc+a3/HTR+dEJ
	5N3VFJ1yuZxAjVA4jisoUbzEW44BALuxI7AOwkwV5G7BBneSzfErmPyFIpTPlfGT
	Jd2ibzTcSOUZNGzTc7bFfQo1QnngQXav3TC6hBOETEpRQysN2/txlZoHa83gV4RP
	IoUPw6Av6G2MNYhJFDL3ccAE/Uk3t1/EVkGFKiHM547FEUSOtiwDBvllCcSj2D9K
	Iy6pIoI5cQzq68XtICzdJqRDLycaxkRSF74seOJw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4407nbhxr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:44:21 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 506CgZ65013857;
	Mon, 6 Jan 2025 12:44:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4407nbhxr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:44:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 506BbpxD026176;
	Mon, 6 Jan 2025 12:44:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj11wctt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:44:19 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506CiIS518219288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 12:44:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0877F20043;
	Mon,  6 Jan 2025 12:44:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D881A20040;
	Mon,  6 Jan 2025 12:44:15 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 12:44:15 +0000 (GMT)
Date: Mon, 6 Jan 2025 13:44:14 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
        tglx@linutronix.de, david@redhat.com, jannh@google.com,
        hughd@google.com, yuzhao@google.com, willy@infradead.org,
        muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
        arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org,
        npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
        ryan.roberts@arm.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of
 PxD to __tlb_remove_table()
Message-ID: <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pBEfcQBgF5vkTjfwUfa5dco3kr9lNTtL
X-Proofpoint-GUID: kKTLJJdNiCahdOdrkZ96oEBulIRxKyk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=520 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060110

On Mon, Jan 06, 2025 at 07:02:17PM +0800, Qi Zheng wrote:
> > On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
> > > To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
> > > PMD|PUD|P4D to __tlb_remove_table().
> > 
> > The above and Subject are still incorrect: pagetable_dtor() is
> > called from pagetable_dtor_free(), not from __tlb_remove_table().
> 
> Hmm, __tlb_remove_table() calls pagetable_dtor_free(), so moving to
> pagetable_dtor_free() means moving to __tlb_remove_table(). Right?

Right. But you Subject and description claim "... also move the
pagetable_dtor()" not to pagetable_dtor_free() - which is another
function.

> And the main purpose of this patch is also to move pagetable_dtor()
> to __tlb_remove_table(). So I think this description makes sense?

The patch makes sense, but the description it is incorrect ;)

Thanks!

