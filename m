Return-Path: <linux-arch+bounces-10280-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76BFA3F501
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 14:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67322423E03
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BC820E70E;
	Fri, 21 Feb 2025 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LPO9aBDD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDC20CCE7;
	Fri, 21 Feb 2025 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143139; cv=none; b=sWsJMi8fQE+gPNuzDzYJnWmvXSSZm3FNvoaVZuKABQwd2/khVI6QoGy2I6C8oXkUoDBSJV6ae6L7g6zZ55FRGZzb6pi8numCpNnN54kWMoAFVA58k74PK+chXkqz85HPlbQBfDY7CETnz+898yxeym3lvfwSjTXzDwRh/AMs8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143139; c=relaxed/simple;
	bh=UqvytLdopItWGXyDMaFScrdLk0zpyWJi+0VnlcphEQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lAAu/mmwTPIbFfXV13UjnzVqiPg7L/7GwsHcKc2L/nG5zItLmshyUitbvPMW/DHZqnK3Ji8ftigNWk9benfVYgIt6yi/SaaI3eSgGWlgbtF01PgIARFUyNAl3wjyJPuJ/6/RrnrbFJg45OYBqKeS3k7mTgZqhQXBNdGiHI4FuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LPO9aBDD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LBulhk008309;
	Fri, 21 Feb 2025 13:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a3BtQIhlA8aAG89uR+C8DMvJdtYemVsNlnwoCtpLicg=; b=LPO9aBDDMsxB31dw
	WyjEK3CLUErmibrT9lWzXMKIOlj9scR21l/EvLCqI1iE+F6d7ajSGM1Q7o7/UTva
	d6BCo5GfnagS3ZlFBms2f+vn949oTKynvFtUIgGlvTucQIzBAPCpUtJJ7kyNxIls
	gp2VHXA0pCLqa69VB1ozNks7kF5WZb0sVY3fIhvMfxrNG/9yv9mwvqsZokftd1GN
	2nTbNp4amwmIW1yvtDpVUeXeW2HKIdUTXbDD+E/BaCPpa8tR4lGMcaskaUE7xURJ
	tBul1zdDWMev8T8r9cAZcCIQWRVn7cSKVD/7UYWMHBDw1IOKOUSMC6HEBlauMjmc
	aIzqRQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3j2mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51LD2Whs027840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 13:02:32 GMT
Received: from hu-zijuhu-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 21 Feb 2025 05:02:31 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Fri, 21 Feb 2025 05:02:09 -0800
Subject: [PATCH *-next 04/18] crypto: scomp - Remove needless return in
 void API crypto_scomp_free_ctx()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250221-rmv_return-v1-4-cc8dff275827@quicinc.com>
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
X-Proofpoint-ORIG-GUID: oXrPtGt6iYym3jCKcWCq-N451L8zfZaz
X-Proofpoint-GUID: oXrPtGt6iYym3jCKcWCq-N451L8zfZaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_04,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=812 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502210096

Remove needless 'return' in void API crypto_scomp_free_ctx() since both
the API and crypto_scomp_alg(@tfm)->free_ctx() are void functions.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 include/crypto/internal/scompress.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/crypto/internal/scompress.h b/include/crypto/internal/scompress.h
index 07a10fd2d321..44130680dc0a 100644
--- a/include/crypto/internal/scompress.h
+++ b/include/crypto/internal/scompress.h
@@ -79,7 +79,7 @@ static inline void *crypto_scomp_alloc_ctx(struct crypto_scomp *tfm)
 static inline void crypto_scomp_free_ctx(struct crypto_scomp *tfm,
 					 void *ctx)
 {
-	return crypto_scomp_alg(tfm)->free_ctx(tfm, ctx);
+	crypto_scomp_alg(tfm)->free_ctx(tfm, ctx);
 }
 
 static inline int crypto_scomp_compress(struct crypto_scomp *tfm,

-- 
2.34.1


