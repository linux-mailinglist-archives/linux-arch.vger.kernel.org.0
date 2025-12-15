Return-Path: <linux-arch+bounces-15406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A036CBC86E
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59BC43014A2C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEF331AF39;
	Mon, 15 Dec 2025 04:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EJnQ8g3m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="huzVfBSs"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1952E7166;
	Mon, 15 Dec 2025 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774520; cv=fail; b=LBOnxOZ7onfqMZzFOR3rsHi77BVTDYCdsyJ4qaVb7JkXyoq2J0nEoLeCwyKvU+D8WdqAeNr4NDD9sz8ZIjND5BkUe3lDJWf4kHqxaq+btQKkeagrUYZ1H/Py6gJDsiXpjnihMun2BimiHVk5aNhAuaI/FTM6l45bspN2yXMSETM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774520; c=relaxed/simple;
	bh=Z5v1cXfM12yaHHJxBBj7Li7EThXqsUklEm5z7Q6DmmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b+LW0sKx8PGk0jt3GD6TJiMc/8geB6qRPgJMZncBv1vP6XdARZRT+gwNjTvmQEbFbvTwHU6+R8VzJeID07WX7XB1Q3GMtxTdL21Limr33qJ6g0nZBuyDn5GV9zqAlwayQDCmwwPsxF0kSr3LcmoKX9YQDhvdNNvTS/mwH53pcak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EJnQ8g3m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=huzVfBSs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF1VbFE1121780;
	Mon, 15 Dec 2025 04:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6DKWI4tAFWpRMLScx6cVZ5hXPL9VdmTzo3RUevwkODE=; b=
	EJnQ8g3mkWW+u4RhknQrIHaEd5hjbxiyZbzA7zRbFki/41LYTj4UTO1v7SVCtmCc
	Xl7cp06tmSGmdAlcR1Ovg23FX01x2YWLQQnqatboKMygwps/hwifldl47GmHzlGE
	pcX2UQwCFH+qkeT3rHSO/8DsThnMd2NGPrGQLopfr9t6jvJw2Z2Kfi+fFhwSL4wg
	A0+SSM5zisreFRGv0JpA6x7geUmGsUwYyInEMbGSwN0gWAEeikOuNa/bEcn9hjXX
	qEtyXRh9579/LnLRf6/ynxCjvkjYd9nNIdEAG2pFp4/z21zsYZ1/ppknn36DnfSL
	uZUPq5KRp1p3GzLu1zjrbg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015san3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF2KF2N025271;
	Mon, 15 Dec 2025 04:49:47 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8rdhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/n9lDELjuKgfMcVwQNdwKEhyBg+dpF08Sq5Dy7y2fccEtrYviMOjwpf+ZgT16B28gVaenB1tYiiJM7KrNPGBVuMD4XNHnN5OYJsukvqCD8rWTV6Mjy9UFduFPPdnTj+E85nHxxsF4i7u2Zove4jL3pfz/ExTNxLGzbUioRd+Ll/Lr792oKUrubpXC9CPKx5Ikkgh3RBRZsSbauu2sgWhMc8tPHK+mM2Lods6ilv6Mt+nGdzQEFbR5jwh/Lcj3F+mv+Bk5SYID4quDUoemx+olxOBP27RitUUw8UKyPQhrM9tiXcGmU2FFZiTSM028WQixbHsDmRzFTnacMxCmDFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DKWI4tAFWpRMLScx6cVZ5hXPL9VdmTzo3RUevwkODE=;
 b=M/+y5MeRDpWW9yi8KgZuMEl2JS127oiIPw9WtOwpwsgzWSQMDVGuQvdsvcgs2ZmSjuu53UYtUd/ObNziU0xevXTOEyTE30lMeriAE+FjpOhbjZN8/LwMO77oRWsEaQdkB/FydITDzx9rgA8KckyaPirraO6tPPyASrdmvezQERJZ3mV8PuvA/jbn1G1XWThUJtBxjh//Gd1TGcm/VlKEkY2a2B09bt5csmkBexx6hgCs6q+/DYQa7XwxQhIgZz9kIFTKNFzZukOV7iq3+PzmJCpyIixI8yiMvE9F7r+4g3VYw+QePYaZCViQepxPA/A6sofeL/CzaOXJ53LsjjauDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DKWI4tAFWpRMLScx6cVZ5hXPL9VdmTzo3RUevwkODE=;
 b=huzVfBSs/At4znxQ5kvblqnEjoq4beH97RE6U66h0bphaspwcKQDk4tubhbq9qodl569VdCwKIflqXI94gdKaahAF0EWa63wLX2N+8BE7MJJ9LM40UvIOjUYsFsbOiRQXCOV+7Vc6Soeh0RyfLjmIz4gPCB0l+W+Rc0PSZ6AV6g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:45 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v8 11/12] sched: add need-resched timed wait interface
Date: Sun, 14 Dec 2025 20:49:18 -0800
Message-Id: <20251215044919.460086-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:303:16d::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: dc541c52-cc29-47b8-a852-08de3b955e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7lznSkdqEGc8lfmkT/Qj3Sk9y0TWKrlCzEEQe9oTLbAkWvG+s3ZcGsYLpFPg?=
 =?us-ascii?Q?YX9Wr+IKRJmp1enXtJkKIuL39JbaVEiCunBejmLPk1M4J4sj5EyE1n0FZskT?=
 =?us-ascii?Q?pwAdHp7PP+1DkfryCvzRdLHpQKw3X8y4JneYhPpuHgKpFksI6pNWyV0mdyh5?=
 =?us-ascii?Q?OKbSCv0PS62Hx50mkp0mneiA1xQ+8FkQSJ3AtYXQhKWerAXTE5mrNHiU3VVw?=
 =?us-ascii?Q?KFgdzoN3JJJ6UMjDOYthFCtT/nQt6ARG/fBYwKAWYPKd37ql2S3BZsKcqcZS?=
 =?us-ascii?Q?vYDvZ4lsUUJUvpQxtQwZv2dMAkTbqIIBGQ/qXJdQSeELr4darsG6TW3/bazi?=
 =?us-ascii?Q?tm7krkQnL5qrOV8o2rq3v051aeLeDvX69uhY1Bp7S5EVlXuy8imDPQj0fzUF?=
 =?us-ascii?Q?zpY1rRTToYcdKyk4+mH92NcJXiSq58e1uZmenrpIclGTrZHHjqVWgZ+zhLUS?=
 =?us-ascii?Q?EcOPUYQqQ8YdOUDfpJ3ImpndKdyF5Qt5cY93eEA8wsXNaUKggR29BVrtc9If?=
 =?us-ascii?Q?L/ZRAc+0AfH0MjNxvnDwpnYf378z7oleC5vHN9w8QFgnlShBG9hJPAnmCxjL?=
 =?us-ascii?Q?Xj+f3BMltl57MU119Enpru713HfLaDRnpNSkMPHuUzRW4uv6GMhnoaTq7Sli?=
 =?us-ascii?Q?0Bo6905Ui2pTwlbkFhcLqniWwfavdwTFOqWc3am06sD9kELjV888zwSAvfYc?=
 =?us-ascii?Q?TKAJwXEOzAgL+C+rM6xJjGcZyE1nldC3rhq87u6V1nbh6K99vR4Uv9CwtjXd?=
 =?us-ascii?Q?sgO9XrPURD7VoU3OQ5K2ytDGYhIaPnM2AUzUiynJ+VYbf/pC78H2LASWyPAV?=
 =?us-ascii?Q?Pm8BYJAT9BiJiCPPxf8FTgOXJKC1sY1HXaGrRcsuFoYFEB/nJOIld83L6wAj?=
 =?us-ascii?Q?Wl4/hcKhZWDv76e9ICpk9YRxa3v7aZIS4LSY5gz/Cy2dhESNR3HgE1gw5QVJ?=
 =?us-ascii?Q?1CS+H/9QqcKliIlDwX7cP22zwteMp4vT6ebBu5iswdqZnpHBCAewLjU7YsKK?=
 =?us-ascii?Q?eVB+iMpgBHweMqK6fp1XE9Suh4s37QM3b6AKxmt9nb5Lj1fFjyQsZFEoEwU8?=
 =?us-ascii?Q?8DFCfu16ZTihFNej8he8fNEP/yFxTnLuQG7bpu69A78zKy6d29B/JvEiMNbY?=
 =?us-ascii?Q?ts0vhrx8uJ0h6eCrHv469W4ais8nG7gj5EKhi9ERk/A8vjVqGW379pDjzbTJ?=
 =?us-ascii?Q?BmPYdUroK5kdUNVt6hnj9jwIr/6iDJgNTUpipPrTNd81p8KdMCrL8jtM1f6q?=
 =?us-ascii?Q?8RLzXzM5rtqLkaTd/OkjZ9NoXFetkGfcupXLJa8O1srVdWH9kGMKs5xVKZHN?=
 =?us-ascii?Q?0GtwLLxO9gn0i0w/AVRV//nf827hXwBoxiEIvFhoIMKBrDBYn71kVQAlE5GF?=
 =?us-ascii?Q?mBQ4MoQMdOuCCW70SG2HKbwSBko0duixg7dwsxAQAFhALXSNrHI6c5fVazae?=
 =?us-ascii?Q?KPidq/6NVHSCXpyC+WVg2JCSTzKGbxFi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lqjjQDTrvBdGQxvJLwRoTJG8JpzZ8YZMtklXnKbWyDHKqhHfQ2V1C4HtblZ?=
 =?us-ascii?Q?kaJ9d3EAI1iYaaO6PQhbQWzInj64OWifjQSrBl09AhgbcgStrhCpAZW0Maro?=
 =?us-ascii?Q?nFKDzURpKaTTexMPZQO16pL2KzJMZPkUkOMeV6f8VI9t5aSO7e1fDnQXj74L?=
 =?us-ascii?Q?uMCHiBOSCpcGSPX4l5vA2YBfOiWiJpmH7ClaW7k+C4z6iysf1cG73C5qVJOf?=
 =?us-ascii?Q?DjRyAZ1iGU9s1ncSvRGqzNP/xNCcgX1z8t0EKBIh3uLl/hR8m8JPpP7h5cJe?=
 =?us-ascii?Q?UL/ijyyqMJCy/tZdwQ9wMWgDTiQ7mfty3T6imfe9QZPJ9hTtiSn0M0tV+DHS?=
 =?us-ascii?Q?dr5N8uwdztl4fgNU5jdBDnKD93xysrOliXqPEl6eH+mpU2/0Fz6pblCeBoGx?=
 =?us-ascii?Q?JRq75a48uRBNfMGYqTCgGwL6H9kYg6kOAlERNQyBEQwJWUPNMXKnWusiENfH?=
 =?us-ascii?Q?R/H8ZH2Pc8jY0RwPUDAmsjvAKXLhmQL8RopxjOs0Dgx+wdWU+CbHLXX3YlA7?=
 =?us-ascii?Q?eDcSP9hl949qBy//PQujKw8aMfi2tLXXRbwvK9oi8cJbP2p9sCMW4W4X4e/E?=
 =?us-ascii?Q?xKhzbr2e/mNkZl8GHYI3MUEOMBKEvjwmp/PVtGRyrxAQ7Zs7o2Zkv/vXvhoF?=
 =?us-ascii?Q?3kBdZ090piBj38z12ne45tcP/MCRe91QSJ/lG71lNW4MQSJAE/5QLZwzHQMg?=
 =?us-ascii?Q?557mxI+HUlnk0n5FLjIQKr0foGVUpGN//+IW6Z/MxICH//NxBfdHbCqsbies?=
 =?us-ascii?Q?Zdm5nQ46cXyyjV2+zTtrMZvib1sQT/rwhZMewvkiKy2tofCcmIEVzsG3iaoC?=
 =?us-ascii?Q?Ny2a21jxTNzqwM1ZVFlE/165ymLyweUec/4RHbZS6HcxIQQhqWGwa/qO5YK1?=
 =?us-ascii?Q?sD27dBq8a4x2IEEubaae1DuPf+8Lf3YdSr19FN7Ni/0z2ERGCmZUw+/orL4j?=
 =?us-ascii?Q?CBhyn2DPQeMEsBLLxPTQphA0rDiYeb3kZ4zvP+hakp5t/qhSJ3m4Lubu7UWT?=
 =?us-ascii?Q?HBSJYwCd6forNQ9hkxCV5UNZCf+lQQzPA0jVg9Ap0rU0Nt5Cpfexkcpa5jXe?=
 =?us-ascii?Q?bkWbB2FKQe6pYT/6tvTK1I3teMc44IJC4t7Ah2OloP1W1BFo2Wg1B6mN0N8G?=
 =?us-ascii?Q?vn2g1vRjFtKlzHnuLnBOAzwixWsyVekaf+UFi0Spbnful8UJHVrnFHUF3w0W?=
 =?us-ascii?Q?DiQsMuFKfmRgjt9KUW+wdUQl9SInBcA3YL85oFr/qj1ZQKP0NUPVLMO6YVnF?=
 =?us-ascii?Q?ZNPMFmZ8sFJhBpPC1MwhKdBiGaqpk3UTlek6/TBvEY/ftM4Ob21GbQv3GhAi?=
 =?us-ascii?Q?NSUvkMHRNiLxz1LPz0SPQfVpkmSuDs686B/vJ8Q7i07BYgiREOlH9OJVLKXj?=
 =?us-ascii?Q?p1vlvSigsZ0FgAK7+Ni8+bOcchmh93y6b6YNT2tSD3Do7NuR1bmuyQVTwTL/?=
 =?us-ascii?Q?FeboSCvw+pL7bogB1SxzvwxV9OE6qnQEkJhPbJnxqAxthqTV/PFCyIeBXQqe?=
 =?us-ascii?Q?y9lGvdlD5fR16qcYPobbANav6s+vPxv1egl2lLO6uNUIMGJFcJJG4djuV4Dm?=
 =?us-ascii?Q?nzjicL1xkYkpPC1DRzKxo2fqqFdTr9UNNAF6jRu7DNREwaVAnMPGYPWu395H?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h1ZIQBT+cMGUKgpxw/ch/8OU85acuEn8axK3BUrdWFajyK2W95Y1nWFmstdOdecxvLN+/ISp2ZW0EWGJGuuCJBxik+tiGfmH+hXcfdiaDhr6ckf0FcrqNNA4cvA7KDhMZQFiX+DqWPFpZwbtnPvPZuP93QEOvJxNgqUmrbs0WSAbQWuw2z2OUSqP/nJwgegAZfJe+YdJKhR7wVPzaPsay/zEKze0TKXZoLuyhx5p7sp0+k+5a1qZRhwe2V5vlXTpzavEyTB040WQCSDnyLORhVb5jmn9K/InEgGgLOWGEJ1kOQssZd9GNlPer0t0uiZVQhP+yuKGn69by13ZrIEruxldCIwJKbFoLtdFLU+mGe3JGw6/DxgJmkGdUiin/vJAP/sgELV/Zl5G3BCTs4hJeZYTSjRILNkEHeHCLOtXdvlyzTlmskl8y6OQNKmtmyHQc0uTt4QPXT4g/tCa0yDORA7ooS9OveV72YMjsKsRQ3LNOkht1VTik6/biR1dyfupwzmyHljJJf9cy1AdUdCpRwiApy4qtpzby2ZY5QYs22hT/KC5kbX2WYay3dujYE1ziooUqpbeee2ghcdqucFXydLXwlxg9lvaVr3v0pXS/LE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc541c52-cc29-47b8-a852-08de3b955e7c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:45.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyRxBphku7NYHrJ5VXIjpKnSnoba2BLiSOHbacOOLoXWDBF+cULY3d8fngqcqg4CgGxQvFWcL2QiHYUhDV3bS0yzw2dq/GMmilCCbCsQiQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-GUID: dSos7e03kg2-KVy84TBnDnrNYI7rMkJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfXzXt7/HaytFbh
 7F+bDqbfnZ96VLy9oz7Y5r3vE3aaL3EKaq/iBJD9WFgr6n2mu8s3x0qcmiRb9jlUnrqRIDsEqSs
 V4yw2fuuAWQIDOJ0tHx3L9rOFXpz6LACuLQsBqjCFbstu2cw1f7vZsQhg7/4tK0VTmyoNCLkztW
 p4gktm/VMD6W6wo19sNgjUHhWrjj5dbt5s/Eh7QPzzVKKExaEjq4RXtypyNEswLX8K5iq/kma/Z
 fvTNWs5thfzqvrOOTU+ofZ45BJNkNCMTIRoV0OrbG65DqWrkDbwAwrqgrwNx/+E1NjosXVc2zvK
 JKks+YPptS589Y5uJ80RDPpaqNT4VrFb5nXPwZPiJNI5onz+qgKCQxdUfym0HAx8qSVo1ZvNWUJ
 meaQwWKs7k/fBPDuhEjRgM1tWR04sg==
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=693f936c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8 a=DC2jtUcBNbVnd9lHvZoA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: dSos7e03kg2-KVy84TBnDnrNYI7rMkJN

Add tif_bitset_relaxed_wait() (and tif_need_resched_relaxed_wait()
which wraps it) which takes the thread_info bit and timeout duration
as parameters and waits until the bit is set or for the expiration
of the timeout.

The wait is implemented via smp_cond_load_relaxed_timeout().

smp_cond_load_acquire_timeout() essentially provides the pattern used
in poll_idle() where we spin in a loop waiting for the flag to change
until a timeout occurs.

tif_need_resched_relaxed_wait() allows us to abstract out the internals
of waiting, scheduler specific details etc.

Placed in linux/sched/idle.h instead of linux/thread_info.h to work
around recursive include hell.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched/idle.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 8465ff1f20d1..6780ad760abb 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_IDLE_H
 
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 
 enum cpu_idle_type {
 	__CPU_NOT_IDLE = 0,
@@ -113,4 +114,32 @@ static __always_inline void current_clr_polling(void)
 }
 #endif
 
+/*
+ * Caller needs to make sure that the thread context cannot be preempted
+ * or migrated, so current_thread_info() cannot change from under us.
+ *
+ * This also allows us to safely stay in the local_clock domain.
+ */
+static inline bool tif_bitset_relaxed_wait(int bit, s64 timeout_ns)
+{
+	unsigned int flags;
+
+	flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+					      (VAL & bit),
+					      (s64)local_clock_noinstr(),
+					      timeout_ns);
+	return flags & bit;
+}
+
+/**
+ * tif_need_resched_relaxed_wait() - Wait for need-resched being set with
+ * no ordering guarantees until a timeout expires.
+ *
+ * @timeout_ns: timeout value.
+ */
+static inline bool tif_need_resched_relaxed_wait(s64 timeout_ns)
+{
+	return tif_bitset_relaxed_wait(TIF_NEED_RESCHED, timeout_ns);
+}
+
 #endif /* _LINUX_SCHED_IDLE_H */
-- 
2.31.1


