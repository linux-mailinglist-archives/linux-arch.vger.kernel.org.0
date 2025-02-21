Return-Path: <linux-arch+bounces-10296-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EBFA3F568
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F26B7ABDDE
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61C820E302;
	Fri, 21 Feb 2025 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pc773gsj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A6320E027;
	Fri, 21 Feb 2025 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143612; cv=none; b=HruttD+hhPN/EoIbBvvyVKUkNxMes4B7WKTZ+KuYgV9g0KFWMx7sWFqvTZYpVS1jGqjPVpHhp1OY8mX2aq/2b6COoxYewlM/E6mZE1yutr/bA1pptsvkNHuIsjiIpdQtSIJS2QMvSkAlnrJFq832GiNbN7aFxoVLZf+Wmz9vcVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143612; c=relaxed/simple;
	bh=kAcOLa17ff6TZ6T7FrfRu13aeeAhZnyOFjwr0jp7VKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=twKWpgjAii4Hx4VUPgrDmUsml1/SAO38Yg8lAKcEbTnJvzgcOX860GS91hI/+60md2fiPLpGQt6jJk3UiyQYH4OSzDUjV08FI53VrW2vdfJr8XIOqdz7pWx/wj6JnozszIc96LzGR7jqn4q+P4Kieah5HLeNqkhVe4JHVFXP2zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pc773gsj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCkunU031803;
	Fri, 21 Feb 2025 13:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rMvoDC9TQDacf/N4q7elXEm8gc6mCq2kbKwfjC8SnZE=; b=pc773gsjOQLDV/PM
	r17xLoo6bZqZ2646wj4cFe1GVnZb/X5+Q3SL5PCzSLg058TzPTP4wC9gwdLLi7uR
	w+MvokjXu516qUFcWhVs5inKQIXjZEOs+27Hstywy2GStMMl9S2Ye0kFmYcm36fI
	VnTW4nQ1ftmRByq4AZnerZaYKIpPYRqkogaGne5lMCENEzLeKLqXT2enmfz0oFMX
	6t0SJIyZDOaW5/LM/HDgvhtiljH+do9ffOB7c3F0YC6qKXcXYZCIFJJp9mOJjB97
	NEoeItGOkynDrKEFPp2FSIfQEAJ35Ga5eLsYPD0f4hKDhXXYEpa7aLPF++I//CzR
	BAlz9Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy5j0cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:12:45 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LDCdgX003306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:12:39 GMT
Received: from [10.133.33.29] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Feb
 2025 05:12:31 -0800
Message-ID: <1aefcfbe-cdfe-460e-9ccc-d7b5e0f9f330@quicinc.com>
Date: Fri, 21 Feb 2025 21:12:10 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH *-next 13/18] gpiolib: Remove needless return in two void
 APIs
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon
	<will@kernel.org>,
        Aneesh Kumar K.V <aneesh.kumar@kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra
	<peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S.
 Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jamal Hadi
 Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, Lee Jones
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
 <20250221-rmv_return-v1-13-cc8dff275827@quicinc.com>
 <CAMRc=McG2xLUcE_yHq4MiFnm665riHHuHjk0GJE4cFV_gGU90Q@mail.gmail.com>
Content-Language: en-US
From: Zijun Hu <quic_zijuhu@quicinc.com>
In-Reply-To: <CAMRc=McG2xLUcE_yHq4MiFnm665riHHuHjk0GJE4cFV_gGU90Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6LBvVGxpuh7hzUH31SaVtdTZALn_bpnL
X-Proofpoint-GUID: 6LBvVGxpuh7hzUH31SaVtdTZALn_bpnL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=827 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210097

On 2/21/2025 9:06 PM, Bartosz Golaszewski wrote:
> On Fri, Feb 21, 2025 at 2:02 PM Zijun Hu <quic_zijuhu@quicinc.com> wrote:
>>
>> Remove needless 'return' in the following void APIs:
>>
>> gpio_set_value_cansleep()
>> gpio_set_value()
>>
>> Since both the API and callee involved are void functions.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
> 
> That would normally make sense but we're getting that reworked[1] in
> this very cycle so please drop this patch from your series.
> 

sure, will drop it in next revision.

> Bart
> 
> [1] https://lore.kernel.org/linux-gpio/20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org/


