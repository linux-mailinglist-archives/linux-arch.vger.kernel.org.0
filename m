Return-Path: <linux-arch+bounces-10297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B95B1A3F597
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9FE37A2385
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD220E018;
	Fri, 21 Feb 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GXpc4jkm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911320DD46;
	Fri, 21 Feb 2025 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143822; cv=none; b=kt7kRusM5NSG/u6zbE5vYkLP2rJGAyPSZ9VebUmlKufFAlsX3tVQjBdMaDKUAnjkxrwlQEKdVVGj9r5qZEGiGL+joPIhFOwtDHXRPzxc39coBaJvaQOK47QB1Z7sTM+GJ60xnHz9ncWM2BM6V5SHAwvGC3ZrfqiUGEkWp2ihMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143822; c=relaxed/simple;
	bh=7Q/D8RghOyQ/KqhFnFzSNOl6lXSfSgLpiiU60rl6VL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gj3ElOhC4EFX1RWj8C3hZfCfu9jj7Z0DmWyig3myCVtSYYMmKv7Pl1tHE3sFnysIEJNv4ZPa0SeuP8WxHwT5wHw7qixcKRAwInIgG5b2JNp7qHyd+4yJqg8s154EejeSusyas2GDgNi8KYqlEh/wP7GSbl6A+PUDOZyrJDIdySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GXpc4jkm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCoZSC012227;
	Fri, 21 Feb 2025 13:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hXZATStOuQiUIAFb67THfjHdGBUb7YTvKE8kj2FT690=; b=GXpc4jkmdL/MQPOr
	pZp6PmeL5Mi6h+yjuc7De9EjOcGwyLk5Pzt+DWsFuvR/4zMHpji7JNti0PzDAsuF
	iuZbvlN3vWkCNT3dXV3XjsLyd/9+5x7WucaTYx/SwXM5Uzym3sMyZpu2PA0fcbZ/
	ElH+Q7hSqBEDGfS94WFZxNChfTCTL7xbpz94nJjmDLZximaFc7Kdx+cS+jv4InpO
	O3MC+FBUWRZZ3ovwFu7u/g+N2IJy4VU44DrfTPhwtfk8/cjY2U/UvWRPue8rGldQ
	Upx+Cvchd4mqxlWfdssnCq94EEAFk8TQ1ubenUTdIjdE5cgzjvAL1GTrzmDcT1TW
	Dlg9cw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy1t4hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:15:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LDFmDi007900
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:15:48 GMT
Received: from [10.133.33.29] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Feb
 2025 05:15:40 -0800
Message-ID: <7a151447-4961-4cba-b989-9a9e890d7ba3@quicinc.com>
Date: Fri, 21 Feb 2025 21:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 00/18] Remove weird and needless 'return' for void
 APIs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Will Deacon <will@kernel.org>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Thomas
 Gleixner <tglx@linutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang
	<xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
        Jason Gunthorpe
	<jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones
	<lee@kernel.org>,
        Thomas Graf <tgraf@suug.ch>, Christoph Hellwig
	<hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy
	<robin.murphy@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard
 Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, Zijun Hu
	<zijun_hu@icloud.com>,
        <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <iommu@lists.linux.dev>,
        <linux-mtd@lists.infradead.org>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
 <2025022145-ungodly-hanky-499e@gregkh>
Content-Language: en-US
From: Zijun Hu <quic_zijuhu@quicinc.com>
In-Reply-To: <2025022145-ungodly-hanky-499e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PjXLPSlfU4X8CAU-woeSzf1fJQlgHVdf
X-Proofpoint-ORIG-GUID: PjXLPSlfU4X8CAU-woeSzf1fJQlgHVdf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=775 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210097

On 2/21/2025 9:12 PM, Greg Kroah-Hartman wrote:
> These span loads of different subsystems, please just submit them all to
> the different subsystems directly, not as one big patch series which
> none of us could take individually.
> 

sure. will do it as you suggest.
thank you.

> thanks,
> 
> greg k-h


