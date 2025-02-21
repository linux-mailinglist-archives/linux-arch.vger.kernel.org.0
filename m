Return-Path: <linux-arch+bounces-10281-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A0A3F4FF
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E18B861DB5
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F38220F07C;
	Fri, 21 Feb 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xx+pZRdn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379720E312;
	Fri, 21 Feb 2025 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143139; cv=none; b=Hiqpp1JboHJ3EY/F70KhaEEU3lbDM4XK/I97zh7pXMUMrKbHgMN57uTkUNKX255F7IUtSPzjvJGk6dSvSfWwzM98o2ae0uXW9HUzxDoah4PdNLWAnpqz5FzGdZldnMqkYD0vNEDNbUZQtbb8cgJxWEFveuwdXaCCr23nWRBclRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143139; c=relaxed/simple;
	bh=YFQGHQHEVWREtFfoPBas1ZphEeEkrv/cYduerf3nQfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pAI2sRsE8AtfOvxpaeisjlQw0PLc3KdbzxWi9pXyMBLQ+/e46j14OmXt7ZexOpX5wh7DW506o6u7or3I5xOuIScJ1I+MssURxpJX2PEEMyDPToxmkf9ejzF/RwZ+4Q8ljs3d1MKI4GGwQXYWZHoruRWpAsyKiZMYNOrQCQ/rxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xx+pZRdn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L6IYHq018868;
	Fri, 21 Feb 2025 13:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Q9qz3ZZdoCTR7XNck0p4FMWguo74EqG/wO/FOpmnuA=; b=Xx+pZRdnAp2LVSgV
	CoFPMlTIj6Ajqn8dgmuN++Pj/UUnZY5QhY35b/F4eLgFsFyndQrmr6Q/XtZU6j81
	nwBvNsxIMiIT9zuaXujzuha6irHDvR8JQi91YYZpYjPS7vMSLtSgCUmhPJpgTojZ
	SihrwsUWsi+Li/9nDL+M8IrpVsPGg5cL/zrFefccd/5sgHQdnCzjsCUu1E37KKjJ
	LvvNZ6BBKe9+mDhm8/2RyksgNeFwVdO0k2248vU01eYDO7iHQus+cU0NYDSWJIBa
	SWT6FRzB8bKJKYIgCKQI/w86ajbsm+E5Uteb/ANM1SMNG9DpYqV/GH4b15VmTvCf
	kellyw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xm3rhaag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:43 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LD2gur028017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:42 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Feb 2025 05:02:41 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Fri, 21 Feb 2025 05:02:22 -0800
Subject: [PATCH *-next 17/18] dma-mapping: Remove needless return in five
 void APIs
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250221-rmv_return-v1-17-cc8dff275827@quicinc.com>
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
X-Proofpoint-ORIG-GUID: IV7B4yMbMqYcwBNPpAuc_lo8ao45zX7c
X-Proofpoint-GUID: IV7B4yMbMqYcwBNPpAuc_lo8ao45zX7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=750 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210095

Remove needless 'return' in the following void APIs:

 dma_unmap_single_attrs()
 dma_sync_single_range_for_cpu()
 dma_sync_single_range_for_device()
 dma_free_coherent()
 dma_free_wc()

Since both the API and callee involved are void functions.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/dma-mapping.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b79925b1c433..a5de6ecaace3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -388,21 +388,21 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	return dma_unmap_page_attrs(dev, addr, size, dir, attrs);
+	dma_unmap_page_attrs(dev, addr, size, dir, attrs);
 }
 
 static inline void dma_sync_single_range_for_cpu(struct device *dev,
 		dma_addr_t addr, unsigned long offset, size_t size,
 		enum dma_data_direction dir)
 {
-	return dma_sync_single_for_cpu(dev, addr + offset, size, dir);
+	dma_sync_single_for_cpu(dev, addr + offset, size, dir);
 }
 
 static inline void dma_sync_single_range_for_device(struct device *dev,
 		dma_addr_t addr, unsigned long offset, size_t size,
 		enum dma_data_direction dir)
 {
-	return dma_sync_single_for_device(dev, addr + offset, size, dir);
+	dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
 /**
@@ -478,7 +478,7 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
-	return dma_free_attrs(dev, size, cpu_addr, dma_handle, 0);
+	dma_free_attrs(dev, size, cpu_addr, dma_handle, 0);
 }
 
 
@@ -606,8 +606,8 @@ static inline void *dma_alloc_wc(struct device *dev, size_t size,
 static inline void dma_free_wc(struct device *dev, size_t size,
 			       void *cpu_addr, dma_addr_t dma_addr)
 {
-	return dma_free_attrs(dev, size, cpu_addr, dma_addr,
-			      DMA_ATTR_WRITE_COMBINE);
+	dma_free_attrs(dev, size, cpu_addr, dma_addr,
+		       DMA_ATTR_WRITE_COMBINE);
 }
 
 static inline int dma_mmap_wc(struct device *dev,

-- 
2.34.1


