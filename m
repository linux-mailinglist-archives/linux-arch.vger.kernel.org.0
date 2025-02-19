Return-Path: <linux-arch+bounces-10213-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1EA3B5CB
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 10:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC221188B0FD
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 08:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243E31C9B97;
	Wed, 19 Feb 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ug04kj8i"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87651C7B62;
	Wed, 19 Feb 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954809; cv=none; b=dUoOx0T8KGkk0MfY2NFiH2BOgSJ56l9tmSNZQ9SRoaz5nk35MQ1SrLfhd8jsMXZB7e8mRRC/3pRc4sWc/OMnVc/7vja7FSkC7VwM4Uwk1sj36cTbOtliFNiqmIHhBovZtFNSfNZkzH4u0dbVTV/le5noRcb4yG7rZe9lRc6nLZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954809; c=relaxed/simple;
	bh=tnUmi/+GDTm7yWualJNQl5++GpWqIIggR47W1xDCCK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4+Nk0UeIJLLxLzxR/S8ZgBEsvhm/mj7YRbfiXVKH19zt7e42GjP41n0wbXIpPKo9bNhW30ENY20LYjWQUrER/+1zxcK0nnKC1rQzeLK42KVWgVgwYFD+YAURcGCcaRiaFC71EetqslOjbwIAG87f46obPwYGwaSTPAhmN1xSIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ug04kj8i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75CS5019820;
	Wed, 19 Feb 2025 08:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tnUmi/+GDTm7yWualJNQl5++GpWqII
	ggR47W1xDCCK0=; b=Ug04kj8iMYHe7BiulyxakjeqvhE5vGWEcPq1sZxyUUiMpV
	L96GGlP4zARNaJAQWTwAIzJ7EYyj0/fLOO/eEeUz1Qm6PfyohszWQLhfigjhHJuO
	9pkGDOD9Duvtl78Z15h0FvDq7LS487A6ZFmo8kLD6G82ubP/YDeq9iB1rUmZRZhV
	Acyq1Urx+Hj4DKgbBOSfp73Oe9aQ9jKG9rh3AJoHS80RUjKxZQa0+nlkm+JhwtlT
	46b85K1laetS/QWKGHZ9udfq6tm95YB6oytrzPAwgmJLUzssI8GbBT28E9SPsn4S
	P1ZDUi46KCB2gRarv3/+GEPtr7ZabhTbY890Zxrw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyq2vp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:46:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J6YC18009702;
	Wed, 19 Feb 2025 08:46:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y33kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:46:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J8kREv49545472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 08:46:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C172004B;
	Wed, 19 Feb 2025 08:46:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB2B20040;
	Wed, 19 Feb 2025 08:46:27 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.14.227])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Feb 2025 08:46:27 +0000 (GMT)
Date: Wed, 19 Feb 2025 09:46:25 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7WaYRjS/VW2aKJN@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
 <Z7WJL+sgPLB3dboi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WJL+sgPLB3dboi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0vOIzLJ4HxK9oV3CqviyzbQJOr99MTrw
X-Proofpoint-ORIG-GUID: 0vOIzLJ4HxK9oV3CqviyzbQJOr99MTrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=414 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190066

> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sorry, I meant for s390.
Can not judge the other archs impact.

