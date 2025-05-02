Return-Path: <linux-arch+bounces-11786-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A221AA6D1E
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192CF1B6197A
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CA7242D8B;
	Fri,  2 May 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LWyv8FSG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dGyzhNI4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41C23A562;
	Fri,  2 May 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175987; cv=fail; b=INSGzAar/vjt16Gaq4NsF99aw53pE3FiITJya9N26SHP5Lc47cSBk7TyrYjAiOoSHrX/+czPxhPEtY3fMbSc1A/l3ap8shjBvx0UllXWgUqSMb73S4VeYFPvOnSvEl7cxjq2g3jP7tJ+Js1+QH3qT1h868DypXCkEySiVuk1uaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175987; c=relaxed/simple;
	bh=6f7XxHPwo8qC8olQC598YM2dpo0EcKoX0GyI6AoO4wk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M87WY+PdaY4G5EXQiWrdLYfqd1Rwt0j/+wIvCa4OHLGfDkXzpnYTYeUkRdbLTATJxd5UXX9C8guX0YHxJyTqTO94xYAodY4vUMqPelVEJ5RPOONJ9VQXm1z9et9D/siVHHX1Vp+4Td/E8cIDAhD9fh/070FyEPMAyI0x/Rxge/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LWyv8FSG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dGyzhNI4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WA7w015412;
	Fri, 2 May 2025 08:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6E5rBlA38D6p0Ne51JXF/YGQkc+d7k1SGACK20ORTFM=; b=
	LWyv8FSGYyXBPhZXIZq9YChTTMR+zR+2bgwgVtewXvclmEAvXiY7uQ9NeXgmLdNb
	MVIujsdVjAs39F5mmljBBUXOrBI7fl0XJvBE23+h8YBzjrAJfxjsIlze7t67q2Zy
	rAV3biCAQObTL/FbZHVTw+WXfgaWwL5RmnFBUVd6tRZeu7PeQIhzdSa7DepvpvHh
	KtTQKSV9HoisIZ91RKVIQRHuQsUSQSW8uy7oXhmeBgcSDHqKOtFvD0OGPP76QEHB
	QpE5c7hzJ0zKqqCuYsi85qyvKK7hwpmusldglbECnc5B3rOZC6tR+nXnTg8e6FTQ
	C5lcDqpMSaU9JQR7mh5v6A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukmxgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427CY6H023705;
	Fri, 2 May 2025 08:52:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxkt8tw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7ULeOJSbb6v3rfExUqMrXhz7oVftHMWkuXQm04v6twgcxwe1z4WXHh0wHp8TH+Kh0IJ2k71w8z5pKRQON4Bm/o7SdJTsRtxVUj59L60UUZU+gkuavfJi30vfV2TRP/gTxZq2p2aDsMko1QiaWJYG7WIK/Bls+fPI7pdDt0J/MNrdwiI66H8Vxq/zPgYIjQiN/ytaFWq0efnE2JXNJX3dNj3jNXy9Dzl0OqDL+M0BTmKXOD/D2Hmtxc7nbMTUX/rdd1hxeHJIg0OhrGb4UM5kVkhz3u/nyIVwc69rtqf/YT0A9mBAJAuRJcSYagHsQrLaxqcY0XRng/oqQ6PdnL9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6E5rBlA38D6p0Ne51JXF/YGQkc+d7k1SGACK20ORTFM=;
 b=DjDGOkpWxBmNiKTlcPzoGKEa55rxE7N51C9lIq7oemYpCIVuF/dC7h4BgrlbU9+aD2GPj+KHlDzbg1sch0pnHi1TVlP/ZMnDv+uiR+waF4sms1V4C3M5CMqQ7yNlDP3Bmpxf41J93VTUW570NjQKNyRmdWcdMU4LwFRqfBzF0dJinjV1Oij3t/YL64hsvaU2zGwlp6dq+mkzd8AJqhpE6t/kjNuytiiodAG/p2e5w+uLBXL2xzK3TPjJuGX8BDtfaryO6Tu2Ddxh2O536sagiRtQQdJn41wpKNVbnNmZlyiBX0a6vvdYjLNlCzjj7qs9t3ErqoCjb27bjQU+OHzwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E5rBlA38D6p0Ne51JXF/YGQkc+d7k1SGACK20ORTFM=;
 b=dGyzhNI4NwcguwhGg0xgPVg8wZOWexLpOUhzF1eNSzgV9wmNoqe4e6nFoHoaIrsa/6a6cCSDC79x8aviQNHXrAB3ZmpmUR6k6YauCKoPxdZnRRrd5FpUClmMP0Uo6ebO8HXNQuS8Xc3464AYcwbobw9DooGIw4f/TVI5ppX2ywg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 08:52:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:39 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 7/7] bpf: rqspinlock: add rqspinlock policy handler for arm64
Date: Fri,  2 May 2025 01:52:23 -0700
Message-Id: <20250502085223.1316925-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:303:2b::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3366705f-318f-4d19-d744-08dd8956b1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EXj6DqWN55EALDmIYSfUiYlLfW41oqD1WR+fFHUS3OL/EbZCiehUN4Q+EdGJ?=
 =?us-ascii?Q?eANHkjsEPVLjchvkt2FKiD4/nf3rNc2HKBNPFoFNss4ELYFy5Uy8o8tNi6Tm?=
 =?us-ascii?Q?Q1J8N+YrmiIEhF3UrvYqDdNzu5ITwOdLbU4AKX4U8P2kaTvVlDPavQP5uryS?=
 =?us-ascii?Q?dIV4BotTTLi5+v2bgxolxTzA3pHlIZajs5bcfQnpzxYQzxWqYOBvLcqug9wx?=
 =?us-ascii?Q?roPDc0znpKGlHxVcn8Gr9gJKYXOQZTYLcymVDRqh+NuRUT1W/92HTlcFT1S8?=
 =?us-ascii?Q?/O87RbdEJNyul0hSihtM9FNAxR6bPP7vIN0fhi1pslIu+f6o8xgqMmZOQarj?=
 =?us-ascii?Q?qB1g2tMlrvj5117SRDAO1Mz/KEinPoo7Kc8LwBfOUGn1YqMs6vcV/p1jdfq9?=
 =?us-ascii?Q?El9g3voF+bDVuvmzM2u4gzs6jIUw6NAbGceFP7omx5BxUReml/4ifMyEwAMt?=
 =?us-ascii?Q?RxUWbSs/TfLPT03Bxz2kHvn6kDbJqj041cA8KDHIg3S4BzkwMHUzggLi5LTl?=
 =?us-ascii?Q?/6FtdAVCpWOUG11voblrWiYN+Sc1JJerG2VrT4c8DxguDOl1GDGFU5kUJN9f?=
 =?us-ascii?Q?I4VYFhWXiqWT6FTnaO/zD7pwydhAH7nNLpQ256rdA5pir0tES4m0F4FlLdth?=
 =?us-ascii?Q?o3jc/zmXGMM81pRgp5QDGXKOY2U6Ar1VLYCN2TJVDRBYJ2nzdaiJdmkY0VPT?=
 =?us-ascii?Q?e13/doyhkptep9MqM4CrRoBoL5fkbKBlbh3IRjluWXS1F0KQRX8pyNzBjlyD?=
 =?us-ascii?Q?7uzhgX71+Tel8mvmJ29CSHQib/1YL/snO7eCfoqrOvmS5KTiqImgEghKfJUd?=
 =?us-ascii?Q?cjczn0IgN8pKws1Lp3ke3dfFOPyYBkNu4rBIhc8Iy3eAj88oS96t6Mo6hz+t?=
 =?us-ascii?Q?V6nzJuZCYBF76NWhLQfbzS8Jy0kwIRPhg0Bzw0N8Ek1piiJqXQdQJtDocBU6?=
 =?us-ascii?Q?WCY9DBXIQpQYJJf15+0/N3XPaAs5qiaIO1tWLl9L1BVryfZdCdWETSC1GNBb?=
 =?us-ascii?Q?gxRfBjHTww0iGJQZgg5VMscGip5HdvkL9VlMgSIjCKJUmmn0Bw7h6ktZy8Ms?=
 =?us-ascii?Q?NzD56e58EYAjMHUS2wHgh99Zsc0bJGzotMtJtLhOlm7EGgezNr1LecZrmWtL?=
 =?us-ascii?Q?5xpnSgB0nDktHorXQ/00W+N96kuH9tEiUXqshxSXjPpNLFiuAsSPzcFLdACA?=
 =?us-ascii?Q?pBqvCe4giEv65p7bOqMoBreHZwdJNDTHqVVH2DkUaHrKyQOT2alqf62hBGKV?=
 =?us-ascii?Q?cpWOl1x5S1MFz7xjUzyO+fF2So3uGSCbECSjNvfe/d1yClyrn4kWT86LYXHZ?=
 =?us-ascii?Q?DNmwlOQsFe95evOfN1MTlfBLucBM14wIAguDZVZYPP4RsmszFq4IQ4itqvjw?=
 =?us-ascii?Q?ZCAmGcf8GU/PiVyte/sSSxq8HwG4FB1D9dvT+OpEB+Ziz7ozUpMJpzAOWRFN?=
 =?us-ascii?Q?xZM7VHmKk/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kTjq72UWYVbJFNyYwh3DDPPyBrLwEvwSb05tWVNbYQaCuLMgd5OIIi2WLfve?=
 =?us-ascii?Q?MvAGAcpZpGNJKBZz5DgMFAWpogACY0oTRN1lID7m+uLROg5UemfRP2dNza5y?=
 =?us-ascii?Q?Rg9H5itBNgcDoVj0QgBqC53LqVr0m0V5Qy0uxQWrKvdWWKVxr6o9/a7HocEa?=
 =?us-ascii?Q?3Rfm9BU8sLWr7okRdN3J84+k/aIQtmS2BG3DHDSZKrniXF+hRs5ay8MLTNAe?=
 =?us-ascii?Q?/6bYTyHOfz8pbCtjVWlLbBKYCNzmvFlfPw6Pzswh4z131KCaD0/RXxMZ/gTf?=
 =?us-ascii?Q?Z2IZ8xsDS5DOy4BAwgjTgM6x0/EbOWX8oiRWoSOPoOx0Nz0OBgFPTcxMlAxb?=
 =?us-ascii?Q?dTKyyzf3wNyPq4SyLush2Q0U9Tgt/m4eewcBlyK8fL1CTZCJ4KLcDvbVkF91?=
 =?us-ascii?Q?v4aCVmh7Icn7kpRfisiIBnrtfiQF5cN2R3ME+asbk9kQ0y1yfsjpQDd0ZLlS?=
 =?us-ascii?Q?zHpRcVMfw0b+DWnqV/RipOx/D61479t6ZAe8xbr3JwTtLLdDjDzxOkg9AXon?=
 =?us-ascii?Q?Q84ksSs8A8WZtKAMLJ28lO/CYS16ScAa0ZdP5pS6OLC1gKfVpSmzDo86RhyO?=
 =?us-ascii?Q?vtKnheLKXtQ+XssHz7B+fwotw9FWX1tYvAR37fYtwCRNvhtghs0KKN5Qmp7y?=
 =?us-ascii?Q?ouESfkwTgD43du/AcsyrZZHyNEX4ZiMSTaWxmrX2n0bd4NQTiD6IbUBeTh3N?=
 =?us-ascii?Q?Bou3KtaDrDOYdD9LmozjV8EUy8HhZd1B8Cg59vTS03m13BkyaL97ry2ZNhVb?=
 =?us-ascii?Q?C9rKGxoM45m/FZ1IQyAdl4VEspS4g3WPwdS7dzRVr9XQaatTQMjC6bn7/baK?=
 =?us-ascii?Q?An7z1IP84SDczh2ua80H7IitBoglYe3n4lCyaW7gEWaXbUT3VZWiwAlGFKCZ?=
 =?us-ascii?Q?F3AHZnBccPEr7VuyZuA9XPZfOlSReXHW0rge2Lv0tHDdxLDT6hH3eaj8Iied?=
 =?us-ascii?Q?7XZ6sGUtjMfbm1JrI1nIumdA6Clw8HycRat8rtkaPCDTKYh3P/vDqbvnR/xN?=
 =?us-ascii?Q?XOsde28ofcv61Cz0mA+y8EW6S+I6793Ig0lHlZBccPerCfPbrcA8bhJykZM6?=
 =?us-ascii?Q?3UmdIEK3DojwGpjt8kuX3S3vOuoSeVOjmolW7K0lCbtB2JM1bzLNvYQaJD2l?=
 =?us-ascii?Q?BNSCm7ucMvkiQFaWMyuwr2+iBvDNZ6XDITGfJQaSEmwYblpIXErn8iLPp03G?=
 =?us-ascii?Q?uOrerghjaar0ZRCQy2IZLEr41Ib+11njelb4KYFGEDhhGdDatqDa8jX6F9IH?=
 =?us-ascii?Q?JEPdGlJxPJ8atNmIsHXfWYyYtUtwI8p2MHYlsZbvxNIu/lr4Sh9u6TThKr4H?=
 =?us-ascii?Q?r1xJNPPKpEYFGJwH9w8fvZuitL2na4WqVYpnE5byBtdpa+iEo48QXBqUCgeR?=
 =?us-ascii?Q?pNGMYHyTK0Ab4bDoEAjx2lo0QDQElsejG/lXqOnxBXrl4cLvpkY5iMOFVUTd?=
 =?us-ascii?Q?/wM3TFaRWgt8fFk5ilIf1Ja0LtKfevPSjnmSTpzgf/tonzwwWVt4jkarCD0I?=
 =?us-ascii?Q?nM69gwyssvSxHS8xwQ3dHZDe4H7sSuocEiiovBF93B7McufB/KmfJ0l6dwOe?=
 =?us-ascii?Q?0aB0FEFyewTn/MSQ/CzkW3cp66L7dk4YI3yBq+FmROXVMj0zwZySx0ZAVBTu?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9qEywf6Mk2tVVvJnA04b9ey+Zc/E794rcbEMCMwLaeetL60uqRolDUZ8odKW5GaoL22Oir90EDL67W5/j9sPqqMaShuQcfcJQmqqrbg9dRxp6dtnh5AImTULG3fUC2Ln85zppqJQZYItv2L6BgH3Q7Hrn12jzFPe/AhRumU4QdZrHri0v3HkbkP2w+Sps8TBz6rOOoN6PVTfzSTEnMYcemIJI+zGMrwpMc74c+wtI/Tl0zQAozOA52c4uiP9vFnRqE3duZN7AC3AMxCvoDke6uEqWiv+eIroux4c50XAoY37Hn3OG2NBQuFgtdEf8OqPJG7wJLDTbmXAmbEM/dTgvK8mciBHKp2WeBwLCp6cC0MErWVYDXoN1YIfJ2GHELgcV0EV2fvMeVbQytoOr95EvWWcwV7EbZTfbKIiK1Ve3hpcKXPUVcb1eyzjvXTdR0wCdu7PYQWe3/e3aBf6kX9Qy2LFKvY2FL+HvmFw5TiCczdsDcTn4mWIk3Hc7/S/XDlCrLOT6cUKlPcbJEE1By4en2piJEH8Mm+p7sHdfddFfgx9+Fohv2IOgzeoExUN8IXfBi/waJ+pgUCuZTsvIk58gs2Yv0u/VeOMTcNgWFxq/hI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3366705f-318f-4d19-d744-08dd8956b1b0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:39.9090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l26InHx/yr9k3y6xxy+uoOQxdidNxHzCwLKnTpDrG1BEHF8WgInNMDDIC2tLxYd90j4nVnYfV1HCdIy65OsFOM8IJGdV6UHcn2jIFcZLRSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020068
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=681487db b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=wxXpT7fL2LLBmjscUt4A:9 cc=ntf awl=host:13130
X-Proofpoint-GUID: f7QrIgJsNOY_mXyuBt53E927C0OUG7Wa
X-Proofpoint-ORIG-GUID: f7QrIgJsNOY_mXyuBt53E927C0OUG7Wa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX9znZxqauQxAF RPsy4DilD4GF9lnfHXq94hIF/A6jnD6EumHnNp//arHdpSCVMYi1htN+ZL0AudjUyv9jBwSNbKB 46aAcH2lsOGha70EKD2rNJGBps5ga+0HLPzQXPdvC275J7I/04QUmF/5yyyyqsPKD4r9272/54y
 B5crEYK62Uw98BaBKcaUQI6i5UdmCvFm3Jm+C2o4/t0SFYq3CfAUUhvPPqeP99+DBuhC821PArw 9u+4/UmjdVFnDugdTbHwBPHsxfsC8P+uLL0M7HhDqXgb5L0A34tNaNp1xKlrSOpcjV6aJX0lcHa GI+xcSzfqAP05wiUfIR7+OpZcgCFIDGSKEPQ2obvVuVH92vhgzNtKONh5OFkIgPeBur1zcaibiN
 VmY/0eDIlMw/rMVf3VyAszu02b6Q+Tkcuh6m7RkXORX+Ouzbf9BwM8BuNOecJYyBT+vhqT0A

The local copy of smp_cond_load_acquire_timewait() (from [1]) is only
usable for rqspinlock timeout and deadlock checking in a degenerate
fashion by overloading the evaluation of the condvar.

Update smp_cond_load_acquire_timewait(). Move the timeout and deadlock
handlng (partially stubbed) to the wait policy handler.

[1] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Note: This patch is missing all the important bits. Just wanted to check
if the interface is workable before threshing plugging in the deadlock
checking etc.

 arch/arm64/include/asm/rqspinlock.h | 96 ++++++-----------------------
 1 file changed, 19 insertions(+), 77 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..27138b591e31 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -4,89 +4,31 @@
 
 #include <asm/barrier.h>
 
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
+#define RES_DEF_SPIN_COUNT	(32 * 1024)
 
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
+#define rqspinlock_cond_timewait(now, prev, end, spin, wait) ({		\
+	bool __ev = arch_timer_evtstrm_available();			\
+	bool __wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);	\
+	u64 __ret;							\
 									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
+	*wait = false;							\
+	/* TODO Handle deadlock check. */				\
+	if (end >= now) {						\
+		__ret = 0;						\
 	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
+		if (__ev || __wfet)					\
+			*wait = true;					\
+		else							\
+			*spin = RES_DEF_SPIN_COUNT;			\
+		__ret = now;						\
 	}								\
-	(typeof(*ptr))_val;						\
+									\
+	__ret;								\
 })
 
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
+#define res_smp_cond_load_acquire(v, c)					\
+	smp_cond_load_acquire_timewait(v, c, rqspinlock_cond_timewait,	\
+				       ktime_get_mono_fast_ns(), (u64)RES_DEF_TIMEOUT)
 
 #include <asm-generic/rqspinlock.h>
 
-- 
2.43.5


