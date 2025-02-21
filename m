Return-Path: <linux-arch+bounces-10293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6DBA3F570
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E021896CF1
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA92722332B;
	Fri, 21 Feb 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fj5Rr2Gq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647F22331E;
	Fri, 21 Feb 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143153; cv=none; b=a+gfDdZEt5JvXaWk4Z8L8j1nNdaQyxoD2+QefaO1+xI2TGzjO3TFGTTeQTG3PvF+J5THrve/znuOGrp3BkbwMadQLlbfBh/mBA68wY4jQ8oiOmGPqRrNe5WcJPM2Hd92dKqZrpx8vVKUAFDLmoKZ748SydEohoOdd7gmpsOIKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143153; c=relaxed/simple;
	bh=/I6J3/xUjow+0WgP+TVAWOTlXqQ0okRRsj40L7zjJwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EQBPFUGW1lh2vtZGb4YuMhOA/sbwFsxl1VATC+7YMvGes5b5rIO2l/+QsUnYMkQiqcZSzYuMKR2G5U8x6nOPTfe8J10mVcWWBIUnN7uvCPmPesNqveUro3Y3An0WLCqm8LBPrITvHw/FyWxRT42E4FVwrVEV8OEjBJpjPC6Ng4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fj5Rr2Gq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L6IIic018792;
	Fri, 21 Feb 2025 13:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tm0Zt0Z5RF7rdSISUfZdhv6NUQ6vAdfywek+iOtN6ys=; b=fj5Rr2GqOR7fi3FG
	fjsXss2q2XoaUgou8BqAEeuLk62qi3JZ4uNEICFBcHVUhQgKhMH8iqNcQ+14OsDI
	3D8JYvyo18EgihIddxyPogVOfhf+IguAN7tT+m9DJTvKNDYweVPExp19+qrKn5lb
	hJeVgUYsrkGHEsc8mTukuCQ/wQiA7crqrDWy327ibsMuw7PvZxg3Vz/wURGUYS/7
	43fQHWlJsBBU6V8nSV8AvPbYEQEkm40tUJfw5Vefj3GBZpSSPnlVT4BnsMrqvN8J
	daY07Suy0b7Bz+hzpkbQ5CZ24JJJhm+4rTFweOuxERxbV2XKM1wQxCv0ZMX/FHir
	v8rajQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44xm3rhaak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LD2h8q028033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:43 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Feb 2025 05:02:42 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Fri, 21 Feb 2025 05:02:23 -0800
Subject: [PATCH *-next 18/18] mtd: nand: Do not return void function in
 void function
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250221-rmv_return-v1-18-cc8dff275827@quicinc.com>
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
X-Proofpoint-ORIG-GUID: SV8SpptYSPEhBGh6-hClx7JhQY8AZVMI
X-Proofpoint-GUID: SV8SpptYSPEhBGh6-hClx7JhQY8AZVMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=763 phishscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210095

In the following three void APIs:

	nanddev_pos_next_lun()
	nanddev_pos_next_eraseblock()
	nanddev_pos_next_page()

For void function void func(...), convert weird statement:
	return func(...);
"to":
	func(...);
	return;

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/linux/mtd/nand.h | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index 0e2f228e8b4a..8e3f6cca0b24 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -863,8 +863,10 @@ static inline void nanddev_pos_next_target(struct nand_device *nand,
 static inline void nanddev_pos_next_lun(struct nand_device *nand,
 					struct nand_pos *pos)
 {
-	if (pos->lun >= nand->memorg.luns_per_target - 1)
-		return nanddev_pos_next_target(nand, pos);
+	if (pos->lun >= nand->memorg.luns_per_target - 1) {
+		nanddev_pos_next_target(nand, pos);
+		return;
+	}
 
 	pos->lun++;
 	pos->page = 0;
@@ -883,8 +885,10 @@ static inline void nanddev_pos_next_lun(struct nand_device *nand,
 static inline void nanddev_pos_next_eraseblock(struct nand_device *nand,
 					       struct nand_pos *pos)
 {
-	if (pos->eraseblock >= nand->memorg.eraseblocks_per_lun - 1)
-		return nanddev_pos_next_lun(nand, pos);
+	if (pos->eraseblock >= nand->memorg.eraseblocks_per_lun - 1) {
+		nanddev_pos_next_lun(nand, pos);
+		return;
+	}
 
 	pos->eraseblock++;
 	pos->page = 0;
@@ -902,8 +906,10 @@ static inline void nanddev_pos_next_eraseblock(struct nand_device *nand,
 static inline void nanddev_pos_next_page(struct nand_device *nand,
 					 struct nand_pos *pos)
 {
-	if (pos->page >= nand->memorg.pages_per_eraseblock - 1)
-		return nanddev_pos_next_eraseblock(nand, pos);
+	if (pos->page >= nand->memorg.pages_per_eraseblock - 1) {
+		nanddev_pos_next_eraseblock(nand, pos);
+		return;
+	}
 
 	pos->page++;
 }

-- 
2.34.1


