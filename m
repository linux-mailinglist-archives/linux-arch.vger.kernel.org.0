Return-Path: <linux-arch+bounces-9611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B771A02821
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8052164D8A
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2025 14:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEDD1DC9AD;
	Mon,  6 Jan 2025 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RgUCNi9X"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2884182D2;
	Mon,  6 Jan 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174156; cv=none; b=nSPp6tPF6ayVTY/a5pedrFbrmt/i+wCr+yz508hl9G8nla4p4wSY37k5KUZ8BrL/k+YB6JlAtZdvfyoGCBcZIs508OWzKPZ4vU/LtK5Ucm0mgvLo3IRl/hhgp/G2gU7OhuFX+Y1CbFGgVLebm3YEzfAWuIeVaCSpDU5YKQnLPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174156; c=relaxed/simple;
	bh=WrBClNWHsnouBe6gMmvnJXu5JeEQgq+GHFi+Cr5S6HY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd1wcNP97XEjiWUsrRJi3owYq00LdJOrnWBFMO6X2bXrwigHRV+joQ6VHL90e7xhk0KgnFXZTGXAmFpEO/sWDNu/5jgIZQbikcDmHFokSjzVgdrs4ZHdPU7RyfpXjXpV7vzdmXMtezHBaMeRQlmcVHOmMWxp3fTK2QEq3mc3cZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RgUCNi9X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506DKdR6028353;
	Mon, 6 Jan 2025 14:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yoK5E8r9ZiVbP/iseDdGu93jcAAz/4
	Uy/8D3TkhMEPQ=; b=RgUCNi9X25JhEHAe1CAG1qqWDykE2cD2UYRU3jmdIYZ8Ch
	T5zNuZL1wNyGI3Vx6v5lGgT6nrQjUFmPBzbnAHtewI+GPO2JVytXZHj2wHKmhggO
	GdcJ4vAjUlaHrEKk26fgqLKossjwTqPk3DWuWYX2Dr+Z7onrnepYYdpVWHvCydHs
	bu32Wpeqd9ftCqq6EZBoM7oOtX/GhoZh7MR5d6abz5ggaLaPXwccpK1Z1mGCENN4
	yKVEOjmgL8y/m6mo88lKz8bR0FDZGFR18HK66OfhU0FrVIV1cSA7wvm4ufpM7WPO
	4ER6RJeXDR1BpR42AHtSLYfW3/ShkDYByj64zWig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44047hb2wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 14:35:17 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 506EZGRn003388;
	Mon, 6 Jan 2025 14:35:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44047hb2wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 14:35:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 506CA9Jj026189;
	Mon, 6 Jan 2025 14:35:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj11wr3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 14:35:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506EZDIG28705314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 14:35:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96B4320043;
	Mon,  6 Jan 2025 14:35:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 345D620040;
	Mon,  6 Jan 2025 14:35:11 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.26.127])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 14:35:11 +0000 (GMT)
Date: Mon, 6 Jan 2025 15:35:09 +0100
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
Message-ID: <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
 <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sJuxnsXxxJgGCCGTIUc0sEdh5BRYGtAz
X-Proofpoint-ORIG-GUID: UPicS2fzhLCrpHuuN_a8oN-YM2X9yFa6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=791 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060128

On Mon, Jan 06, 2025 at 09:34:55PM +0800, Qi Zheng wrote:
> OK, will change the subject and description to:
> 
> s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()
> 
> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
> PMD|PUD|P4D to pagetable_dtor_free().
> 
> But pagetable_dtor_free() is newly introduced in this patch, should it
> be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
> strange. :(

s390: pgtable: consolidate PxD and PTE TLB free paths

Call pagetable_dtor() for PMD|PUD|P4D tables just before ptdesc is
freed - same as it is done for PTE tables. That allows consolidating
TLB free paths for all table types.

Makes sense?

> Thanks!

Thank you!

