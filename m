Return-Path: <linux-arch+bounces-10291-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F29A3F551
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8FA1890436
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A202218584;
	Fri, 21 Feb 2025 13:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d2c9PCcc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E55214A97;
	Fri, 21 Feb 2025 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143146; cv=none; b=g6tItkkLgAbToDDhLUhjVi6J0GE35g0U2P6s00f4G93O16EZfG2uF5s9tG5JH8tUy5moeOwY5cjQRs7ljirddODcOlEG90N6bmcjc4ZVcMqXsJKtsB4hUnZDA77NNeLhbKNNv6pFC+R1O2+70Ete5gutOclVALZIh1qv4Qryf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143146; c=relaxed/simple;
	bh=CcGQMSb22UmT+FE9aiemz6olWHcyJgow7KRkof6d8h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uSDnDuQvzIkCRiculkpXkqg96xL0oLCsKst6A4XCAq1O/4S2IFPWnSbvSh+ejcZZb7N919HPsgh998dAPjdMZZIkBbhXMwXVk8nu1MT7+6VEvE3D2DP+IYRKG3uKukBX4At7yGbdwJ6cq35yxwXv8yyWcOKfpb32maaWKzp93Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d2c9PCcc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L6011u015961;
	Fri, 21 Feb 2025 13:02:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e8qnIPdSVA2jtju2GS19nOdRjzm3zHGxjzyB9pSCusI=; b=d2c9PCcc47Zh0SML
	tLaMjQtGnaXZQZXQgkVyCtHf1x4TmmGvrLwErqMe7PQh5igGKy2QRMp0TKQUx8Et
	bw4/lw7DO+YeewiKmu7DOk5cvRV6nTjqAzsvSFsCEwpazoRBjj/iEvRsXfLJBbEE
	F5OngitLR8/5YjNq0b0U4vmbZvPfonnaBC+PIzfKbnmmQPeFREPeRC5qIABiH/9j
	ssKwtxgc4XQyIMPPw9NMATf2Betd2MJwsKcVrB90FlhhsIP/fR4bnGPAiioVkTGE
	jvo3vZW4QsRTiH4f3+TwBFAnJd7/MlGgqJKi9o9ymUHbdG0+V5sGB57sYUZKoHQX
	yuqaXw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xku6sccc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LD2eQh016923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:40 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Feb 2025 05:02:39 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Fri, 21 Feb 2025 05:02:19 -0800
Subject: [PATCH *-next 14/18] PM: wakeup: Remove needless return in three
 void APIs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250221-rmv_return-v1-14-cc8dff275827@quicinc.com>
References: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
In-Reply-To: <20250221-rmv_return-v1-0-cc8dff275827@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Danilo Krummrich" <dakr@kernel.org>,
        Eric Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Jamal
 Hadi Salim" <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
	<leon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
        Thomas Graf
	<tgraf@suug.ch>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Miquel
 Raynal" <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-mtd@lists.infradead.org>,
        Zijun Hu
	<quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DKQfdozma52UXuCPvRzdEuLz1FvuQgQJ
X-Proofpoint-GUID: DKQfdozma52UXuCPvRzdEuLz1FvuQgQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=892 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210096

Remove needless 'return' in the following void APIs:

 __pm_wakeup_event()
 pm_wakeup_event()
 pm_wakeup_hard_event()

Since both the API and callee involved are void functions.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/pm_wakeup.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index d501c09c60cd..51e0e8dd5f9e 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -205,17 +205,17 @@ static inline void device_set_awake_path(struct device *dev)
 
 static inline void __pm_wakeup_event(struct wakeup_source *ws, unsigned int msec)
 {
-	return pm_wakeup_ws_event(ws, msec, false);
+	pm_wakeup_ws_event(ws, msec, false);
 }
 
 static inline void pm_wakeup_event(struct device *dev, unsigned int msec)
 {
-	return pm_wakeup_dev_event(dev, msec, false);
+	pm_wakeup_dev_event(dev, msec, false);
 }
 
 static inline void pm_wakeup_hard_event(struct device *dev)
 {
-	return pm_wakeup_dev_event(dev, 0, true);
+	pm_wakeup_dev_event(dev, 0, true);
 }
 
 /**

-- 
2.34.1


