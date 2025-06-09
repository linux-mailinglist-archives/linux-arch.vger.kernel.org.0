Return-Path: <linux-arch+bounces-12290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560ACAD2320
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 17:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00183B18BA
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jun 2025 15:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4FF41C69;
	Mon,  9 Jun 2025 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DutVtiPq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A907820FABA;
	Mon,  9 Jun 2025 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484636; cv=none; b=SqCbyta3x/00nVLpdBAG2pv+4l1II3YSCNiwRi6L4O6kboyG+F4qme0yi0NehEyEsISfCVpgRhmftqBSVOpyE9QFjsYcruRlU32Q0LGYwFe9E+KAvPNGSI9QZVe5LbzWxYGbePQTYWMozsUZvo0pD/w/9zOeaNM1hiIPeeVsfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484636; c=relaxed/simple;
	bh=WVN4Rk8eFlSf26V+gHVby7ROOyqmVgdva3yS0D4ZzAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOJsIfElXu+8Q2S2mhXP5gn9wUElVTmrbQ9cct7RfOgtmFHbX61ybcS82fDlUTxDJGJ9fUDSiLA31kZA7OaslyDkIituxz1vdbUoGPGuUMFUfQoEKEih1f+jl/MOQkwMNp4CS5Gi086LsRMQGCokf7oWjZGuziHga+uB/Hg/s50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DutVtiPq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 559B6Q2E017406;
	Mon, 9 Jun 2025 15:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=mdHOKqWabxLvDWTcu89UeJRrFDbtbY
	dwbmCuWQ0Vc6g=; b=DutVtiPqUVTsIL4JJim4pw+Fp+IxFJD5gyucLIbOtK2JxM
	oQIrv1LxkuKnbhOK+VevYOKuzU5rsotX7MeevcAR6rKwJzH4MLHMfyuWHse61JfZ
	iXcg3zG+kvDJYXe4f+Bv62ttTlj8O8BvqA1c74LI8DiGSxGeofMOLI5IQuUUBEmU
	H0oVwp49lDs27iMqr0KBrFe4O1F9Jty7fct4C6zq++vL6F/0i3NEmox7Mfhp/Q9t
	EX3wZWvtb+UFlFgsY7b/aktpMsyS/1GaVmcBw60llxjVThgC/OQTsr+n88oMiSqh
	O3M0TsOVHYaTjQsD0MN+r9tPRVNUR9PuxsgbGVzg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474hgu8kvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 15:57:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 559Ed3nJ014912;
	Mon, 9 Jun 2025 15:57:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rnxbun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 15:57:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 559FuxUi35193454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Jun 2025 15:56:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BA8920043;
	Mon,  9 Jun 2025 15:56:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 933312004B;
	Mon,  9 Jun 2025 15:56:58 +0000 (GMT)
Received: from osiris (unknown [9.111.49.56])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  9 Jun 2025 15:56:58 +0000 (GMT)
Date: Mon, 9 Jun 2025 17:56:57 +0200
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
Message-ID: <20250609155657.8183A92-hca@linux.ibm.com>
References: <20250515124644.2958810-1-mingo@kernel.org>
 <20250515124644.2958810-11-mingo@kernel.org>
 <20250520133927.7932C19-hca@linux.ibm.com>
 <aEabAPB5Y9EbSPkt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEabAPB5Y9EbSPkt@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pfr/hjhd c=1 sm=1 tr=0 ts=6847044f cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=mP1wJ5fc1yCHjsL5jbEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: pIF64b1PPfd49sEebyRFZmxtT0EY6wZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDExNyBTYWx0ZWRfX+AQo1stHFX8g yOWiu/SoaoxK5WIrbD+RLkixeakAugcZMuM9mjN2AuHfPk8tCT/QcVFGJMtcOYH18TduiNUYFyd Q9EkLBj4pejJ07587Hn7ByW7vxGa/kClTI2ldhyQ/A9JMtL8IL8k3bbL1kUflQ+yub6P453TBTk
 qTSUkEQYM+vZoXxgomd05egRu+8JeCvGRsi90SSiPK1te97sPN7i5nw6DsqtV0XJL8GV+S/q6Gs amqVDabJjesKVwJt8zzqEOD3U8wyXv4CMMi/qgrQMFNiUTEb3SI6C8TArWSrEYsSHLosVN/6WTD zDDJHyB/fCGoypcUyPNeXqnfGakQYrfXn/PA/3j8dYH9RwHsp5GZfxM2Oe2qUwY6EPzB09twi1k
 pq2KOVOZfnxJsFyaUDdecJr9SCwLJYyBV3vXbRfzodCnOsLQrdC1bS9nMg3yoWArTH9T/nso
X-Proofpoint-ORIG-GUID: pIF64b1PPfd49sEebyRFZmxtT0EY6wZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=363
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090117

On Mon, Jun 09, 2025 at 10:27:44AM +0200, Ingo Molnar wrote:
> So I'm not sure what happened: I tried to reproduce what I did 
> originally, but my naive patch ran into assembler build errors when a 
> WARN_ON() macro tried to use the '%' C operator, such as 
> fs/crypto/crypto.c:123:
> 
>  include/linux/compiler_types.h:497:20: error: invalid 'asm': invalid %-code
>  arch/s390/include/asm/bug.h:12:2: note: in expansion of macro 'asm_inline'
>  arch/s390/include/asm/bug.h:50:2: note: in expansion of macro '__EMIT_BUG'
>  include/asm-generic/bug.h:119:3: note: in expansion of macro '__WARN_FLAGS'
>  fs/crypto/crypto.c:123:6: note: in expansion of macro 'WARN_ON_ONCE'
> 
> Which corresponds to:
> 
>         if (WARN_ON_ONCE(len % FSCRYPT_CONTENTS_ALIGNMENT != 0))
>                 return -EINVAL;
> 
> I'm quite sure I never saw these build errors - I saw linker errors 
> related to the u16 overflow I documented in the changelog. (Note to 
> self: copy & paste more of the build error context next time around.)
> 
> Your version doesn't have that build problem, so I picked it up with 
> the changelog below and your Signed-off-by. Does that look good to you?

Yes, fine with me.

