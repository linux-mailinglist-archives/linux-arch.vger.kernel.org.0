Return-Path: <linux-arch+bounces-9288-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148E9E6A71
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B9518863CA
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA91F472F;
	Fri,  6 Dec 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mzxnsOij"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D471F543E;
	Fri,  6 Dec 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477783; cv=none; b=P3m2T2XwxbzJCtWx5FuBscnv1kpPdRdTdChvmyKshLRTxj/F4QyTfmgsevUpOXlBO5fd015DdgM+QeCDKG8JF5JUmO4KHjyo3yK17iccpKMSloGHUQTtXqIaf5K+Qh5s1uqayt3zmDP7C6TLbsY7Pu+no8amFqdPtN6jNDu3R1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477783; c=relaxed/simple;
	bh=qgUDk+W+PIyTOGoAKRTvzyiV3ijeNBD1N4UTpLpjEhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7wrOPjsDnvA1ZCULK1MOWFkPFU4qL25AYPgk4pXG+tn7KOm5uIuxECD6gD7dxCh3MXcednCKdBPHimaVQoC0RNIPXZZ+BlV2W+EmCByHMTohJN/Sqc1pAHkgsS7CyxwTGr8K6UYyp+wMBKIqpq1tebwdSlyUJoXg4/fljmu2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mzxnsOij; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67REtR028543;
	Fri, 6 Dec 2024 09:36:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=N8fRNsyI6v+DciPAXUcifEKU55GUAY
	Uh9TWGHulSCA4=; b=mzxnsOijoF3t/+ZDnyTbeT4uobmZhBxF6WLdSxpovKCOld
	JF/pwh2gPFTOSCeyNdZCOtpVgZVIfh6FWNv4XWMXAm09BnuNt4s1nhlsJAaZDAy8
	51NkQL774mlUpqYmB4BQcv2Hp2j/kSWKkce4/k6ZJTA7h0I2nJlYx5ysm4BKReLU
	/XxpxFzs8t6EEVVaWA03syUflVtgJoueypCQrBkvxGePQdYi7uKKTZSK6ZdRPd0C
	+awDussSrEPRaF0H35giGoJ53ghLRujtwVQx/UlJPstxM4fS9Q9xRUwLInxf4j76
	IDt813vVM1sho8XrmmYa3xsV0qnPtlHnXxz2bJpA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ax661745-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:36:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B69RYVs008431;
	Fri, 6 Dec 2024 09:36:01 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ax661741-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:36:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B69XLoA006840;
	Fri, 6 Dec 2024 09:36:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jwxr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:36:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B69ZxtV52625736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 09:35:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 153EF2004B;
	Fri,  6 Dec 2024 09:35:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5049920043;
	Fri,  6 Dec 2024 09:35:58 +0000 (GMT)
Received: from osiris (unknown [9.171.17.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Dec 2024 09:35:58 +0000 (GMT)
Date: Fri, 6 Dec 2024 10:35:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v20 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <20241206093556.9026-B-hca@linux.ibm.com>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173344373580.50709.5332611753907139634.stgit@devnote2>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -lHs55unlvg6qIyZj6aDfrYW0-N2M25V
X-Proofpoint-GUID: qUwWR2oi7s5dOJ7jHDw_vlUQLLNjoFPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=415 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060068

On Fri, Dec 06, 2024 at 09:08:56AM +0900, Masami Hiramatsu (Google) wrote:
> Hi,
> 
> Here is the 20th version of the series to re-implement the fprobe on
> function-graph tracer. The previous version is;
> 
> https://lore.kernel.org/all/173125372214.172790.6929368952404083802.stgit@devnote2/
> 
> This version is rebased on v6.13-rc1 and fixes to make CONFIG_FPROBE
> "n" by default, so that it does not enable function graph tracer by
> default.

Is there a reason why you didn't add the ACKs I provided for s390
related patches for v19 of this series?

