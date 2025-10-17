Return-Path: <linux-arch+bounces-14179-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B9BE69C8
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0784F4FBD4F
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA9630F7FD;
	Fri, 17 Oct 2025 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HI/TgnwF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HqArrkR1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87430DED0;
	Fri, 17 Oct 2025 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681800; cv=fail; b=bdVcHRr0Ci2HFxNADv/lkp5GOkDv255tDgnRWk4SoH5XFvfLoUIZM7rrwg6Cl24s9HX5DHPemAfhomUuQrW5yRl91NwpGry9wOAxWMM9/qBtc35EP5mceK3XeG7wR3d5iFa+Bnsor4O1oZBrl64yMpzrGBNfkTk7aiKUSgc/1ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681800; c=relaxed/simple;
	bh=FNBBPkd4C+8kMWKJhQnjvIR/0a56KaQDaeowZzbbH38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nXIFP/AA58g9AD+l5CTkhQtoPzbNntkChEEiQDTK4zThO5yHaKiiUwrNMaTAinv6wRjvwCHolZwvbOP086wONoTZTytMn+UB3VpY0OVVW5NMykwzdd0yM+ixYpj9DePmclqh2Qaeo/1krrx0yOAKOrYr/IY/KsWUwFznivrFSLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HI/TgnwF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HqArrkR1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLuKq7013646;
	Fri, 17 Oct 2025 06:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O8RVxnbvgdfuSCM/DiRWjegJbz99rDvkC5TsF4Qm2pU=; b=
	HI/TgnwFnkDmbWHE1A5+4cepp5Dlh1J3jnaDZ7UZ85gGD0DVGRihZICgV3NxIbJw
	YcvpbmKc+HTC7zP89ry4kMveu5Hkc2koAEKJOMuFqpmEAISC0jceJFbtppud11ZW
	GA9CWT4sHMeoj9r+v7bnus7+Auf8Rx77bKrh8Wrj1APt7wZ4kuN5vb4KZXAASAdd
	FoN8AXnDwbXWvH4fm7qrB25veJW/LMPUxKYp6kJhWFrGEg6I9fllM7yJoFzLgY+x
	aV4975WIZQkLdC6mCWAt6/LbCZvxeSSSQW4pEdlH9XCsezXCXx1olljcryac8ZdS
	mSx9y6gzFVCTtH917bHUNw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9c2dj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H3rVPS000914;
	Fri, 17 Oct 2025 06:16:14 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcnsqt-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEYkk2LJrIO8VkUEoP2+jc8Fi61rO4UzxDssj8vNaE2s53hrClPYGI+pUdMtQ4QmY038Mb9NV2JJD0FY2tmoprlWDGqw9awgFmn5ZQsvFmAruJ08R+sCxrd0fgOIFGfE16Sg2zGxMHZFYEGYsZJ78pxXJn3JE0XV0qJzfv6itbu46gA8xv7EviR0IjpEAcvNxNU+LRUhCM2UEGFj6qKBPHhh8jrCpahJgLM+ZhuOD+Nsih9RTqFAAj3cjEpEkJNO5SKXZAPc0aV6oOwJs8XNPzg2lsNhBQ7sAErFjfCB6PyGUSriiApdleNud//Oi8kzWEaq05t8BNFeahnC3IM87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8RVxnbvgdfuSCM/DiRWjegJbz99rDvkC5TsF4Qm2pU=;
 b=TdsZp2XlXQvSaifosYWdznCQHzhb+X9UPUM0NwjGuIbFuPVETC67YsQVEu2gdHHIhmp9IdvE9HjhR5lzHl7AFaFIka+nJtl4xyfsSTsNDXXBGNy0apwgd0U2lsEHxu1w5bEO2UQLIqLHRVbwa2psj+nHng2kHlAyvsVuY2GnO6ZyAf1p0e9iDfLuOJJuYTJDzMvGHNz49cO3s9KPOlVqFPgQi6WAw6TAXioBJFEqMyriEaelfFh8L1/MWDdncpP5yUWrDBuIjmboDnusDWo11JPrlqKehmtETFR8kysScF31oN18gYtUbsJeRzcSoQu49Y2hiLTsM5BZMbQegsbBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8RVxnbvgdfuSCM/DiRWjegJbz99rDvkC5TsF4Qm2pU=;
 b=HqArrkR1o/d5ZlJ0cCCfX3SimPwOg2pFW/QcQLS2klGbaGoLGronXW90NNUYHaKGsijkMJHBg+cDoV2HwoeAgsm93p3/KE6lx5ub4z8ibpBv8+pWjntOZc3Us68aE2979+zU+QhkfYrbhGerQRL9pn9w1Cyrz5X6Ghbwnjaf4n4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:11 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 2/7] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Thu, 16 Oct 2025 23:16:01 -0700
Message-Id: <20251017061606.455701-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251017061606.455701-1-ankur.a.arora@oracle.com>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:303:b6::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 271c37a2-51a0-4844-7ae7-08de0d44aace
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HwxxmaFZ7ILi+e6LZprM66Du/COeWKTLVb6hzo9NUe09cu7h1MqF6pjHGTYk?=
 =?us-ascii?Q?5QwbAtOmrfKourQiacXJn7sJSQ7SMkHH1UFK+dae0LywGt1EQKdLybrmvkUl?=
 =?us-ascii?Q?2Iz0OTbnIorUsRa3f3OKMDOPE3twtNOKK1zHR2OzDEmUc2VzBl9ImPE6CnVa?=
 =?us-ascii?Q?Bn5WjnQogKJmVb361FP9xj1ib8rWUSl6IsjjeH+Zq0dO6MRER/l7p5qJv0RN?=
 =?us-ascii?Q?6HfSKhraRBVeY2p1/L1FkH+skwA2v+NCSeZ/VLUtH5u1f1FSv1GQDDd2b5Nk?=
 =?us-ascii?Q?0onC1VG2wLsa1r5m7lHbbrDT7oEuuocKOkaokMiWH1ElH7OGFJBSXljtYH4c?=
 =?us-ascii?Q?Lyypy8jfl69Rn0CHlqiNEtKlyycKigja80EG8Xbu4Vn9pVXkNpO1cXIibrVl?=
 =?us-ascii?Q?VuNq53rYb5opw6zJmxFFUK1WqbYGWtSvzyT8qrGCIYEQwjpABhncA2D7SU2W?=
 =?us-ascii?Q?9Cgdk9BzVeVkXdazwTY5ynZfYeNVgXW/C8hoAnljyWxVMVeEDg/FishaWu9V?=
 =?us-ascii?Q?Q9K/X7YrvjS1Ej0rapSo5UG4OzlW3vdJMJPKOunEANV1bLAOJF6z/wO9omzA?=
 =?us-ascii?Q?4DeA4Mcm7WRjzUVVhPpscBZeNIiurYGWMykiHAc47hs5Ess5ZYa1Gn2vISNB?=
 =?us-ascii?Q?3RHr4dvwMTQlWK20VftI2GofcxKHjVz4f7nBn4SDmdM2vzxz7pR+sI+r6y/A?=
 =?us-ascii?Q?aLkf77U0qhJ6445W5ONxExcSHMrOqq4IgGXOAwkoQsLO9XVqkkSvQRXJoPya?=
 =?us-ascii?Q?uKA2Xn/Omgfoua3all4WYvQpc2DIOWYzVZYViWdtXdqfb30shxbQGSepOBVW?=
 =?us-ascii?Q?lKojiTUbpK/yaKCJc6oQjKdaRDQEosXS5i5O3wPqMEmsriCLf1NAWDAoJrjd?=
 =?us-ascii?Q?DBPKcWSKHgW8ED79nmpIoxeqXYItuMl3YUpK3h7bjZGH9leJwjf4yyhTvnT4?=
 =?us-ascii?Q?V71yeVQhx+p8FxoJP18wufZtmXMWINopmIwow16lljQ/k/zPiJCncfOxvr2J?=
 =?us-ascii?Q?tpvCW6ct6Z0v6PVvYRhwyQ2/LGtEtZp1Ylqaoxio/l3oDmF/4pVYrKkE09hp?=
 =?us-ascii?Q?ybvaUhOTwkCLP5wwwcYE6EUgNZVonIRa0Pqpty39Rf5+/FNRyoXSWAUWucXJ?=
 =?us-ascii?Q?7ZNBhdFNjuj/ntqYc6Kypc7ZAbUzTIUVcPLon97tOU5Q93wVD/AFRY/7RlKR?=
 =?us-ascii?Q?1TR5ZKomPavYINugSQSYF0BIM8uG56u5o7dJZiScVIF2ZI5TKLhxzC7+3AGR?=
 =?us-ascii?Q?bKGtEY2+xyukNb9AZCzTkY1LWtL+lAwwfXMWN3mjWgbjUwRc5WK0+x851kP4?=
 =?us-ascii?Q?TjPOizOp1VAfATPj6YDDKtfF6ticfcVqQtArkvseBaC93Q4BXcZIoIKoiCs+?=
 =?us-ascii?Q?VV+smHbz2tB4E7rh60Mqtugxb2yGKHRp5MhqNu/vtkhzASMDbtZbRLIm9soH?=
 =?us-ascii?Q?pFQJ76nrrcLNL+s2W0/9j/j+IrnkOn29?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FPGqTmb7iwTZFpgmH8SDlsC7TzHi7J1W2mjnhRDrO0w96jHkdA0X52VBji0h?=
 =?us-ascii?Q?n5ajadkgYjW+7UA28XzqdpxHp5hGt+xAzRoWHB9PMepKl8Kb3p0MwbsKUNt3?=
 =?us-ascii?Q?xP++J/uC7hRXFlxVCcUnydjXpsjwaosm/TyQND7Bko05K3TAa6xsUSx4WE9Z?=
 =?us-ascii?Q?/nIUALyjgTH8ZTyvsIpHdYaEMzEZhbKReLXr5+D1roPyCGBAxTYjJz8hBrdr?=
 =?us-ascii?Q?LAM0ZOe01iol8KQeyRwI0/zk9Fal4I8SNWvHtzKhtYm4laOn42D5TuguCA72?=
 =?us-ascii?Q?zj+vuTy1sdXJnxLCDsHKflHKTFj+yEERkGncFNIsLQhHd66JmWnb+q90pP9W?=
 =?us-ascii?Q?4VuRzNIVdR2vOd0bEzJo0UtyvdLmX935dVgkGESvyGPz2+EVlT+QcZpKp6EI?=
 =?us-ascii?Q?hLt43g0n4tENwBIWcj2L9uoFP2/3s7PSM1u20F2QKvTOORSQFtaA9M+C/bWC?=
 =?us-ascii?Q?IpbXQ8h3CZDZxN3pOZgzAQT1EeLf1QoT/1eM7g+jtpoOI5WqSn4CJ6k1nY2O?=
 =?us-ascii?Q?o+KOKwFE9k0YySfblEEUxKxF/qce3YW3eNS+YWyFFg7Cyh87Ri2vGXXtY9dj?=
 =?us-ascii?Q?QCR4Nktw4kDP8A88GRx+G5c+0HXdmGEpR96F+IFtwN9isuPw+R8IzCbcVVB5?=
 =?us-ascii?Q?0dFsOTe8PuO315PTmyQITNMTvQjZ7m3Kj3j0eKoJmd4/3gJFKe3qgak+LUVY?=
 =?us-ascii?Q?sVgPA+CWeYoQDsBtiFOqJ138La3piMMw07mwMwzKZ2iG3ZpTeWPFye1zIsj6?=
 =?us-ascii?Q?WgtJEJsQD5MtZPAo0vf5C5Xm1zKfcepwpM/ACwMA+pMSRGyIRHnZNaWWzwL3?=
 =?us-ascii?Q?NG9K2FnGLEoONm5mVtGGKKxfpAiAK+u0kRRkpFeIctspMgDdU2FUOWoGeH/A?=
 =?us-ascii?Q?NqrSFuHX8qGFXJBBdylgK/m0L60w611X6xupKRVDa7IWTbEWxQy2epn1Ow5j?=
 =?us-ascii?Q?PcYNOuNmL1NjizhbMIdV6FwhD6yxPGHkgQFBG66vrhOqntRg0cfalQvzO3EE?=
 =?us-ascii?Q?mO6mwac9eAZ+dhYN+46wOABqDC5JQAUa/Bb5KyqO61x3Nv525iVMuHYSYKjq?=
 =?us-ascii?Q?qh4pMqAbhOmEZvVxHTAqSprrgayFWf6sczdjx6tRjTvcNwiD/TIeRxkadkV8?=
 =?us-ascii?Q?J51y/bWgcf/v/iWfsZbtf9zHa9FgcD778WSzVa5CwjblUwlV+N9xZxHZ57Uf?=
 =?us-ascii?Q?gsEYc5ABxbk4kqbhD88BKsbex05M/UCPy6wFe7qbUOWR39j7rB2xKewza1BF?=
 =?us-ascii?Q?owzRd2+qbhpN5GKD/+xB+rGd47TwKlkCMb8MMaUa7ZjRFRzRnNz2xJbAVnDF?=
 =?us-ascii?Q?EiFnSm2IyaFddFcjz7XViXOWNIKwzjclzzNgtu4rGNojnCpj1llJOTrmpmzx?=
 =?us-ascii?Q?UBZKxClD6lEfhkXMP4P1B6fFLrE9NBUs+AlYXESETTHD9/5dXDNG4hUiN8VZ?=
 =?us-ascii?Q?X8807NGec1kBCc0HhYHWwp8Qi5vq/+Jui/1hJ7XnUgXnHi5znnOECpeV7blH?=
 =?us-ascii?Q?haUYTM51v1EMz2k57KaYuNIOEtGZ0++DsVnSRlzGf4+LuWDJeSkMcEXmbyu/?=
 =?us-ascii?Q?eyYGTob1dzkpYnMpktQEikDYududEVQUzcLXrLGQ5MLdaMp645JeX9jmxd/r?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JAYNnW/rbiURVxJVgY6inLsVMpAxBSe+Bb98N5/0q37ijhsAlTIPhjxhUtnetrbpz4c1uieFNMLuSt7PXt9qEGShbTxd6EIFmEOntqtWY9wi+hVhNzg4+DJ41DxOTNXyuEIHixCz477voC1nEqk/I5A8ZDYoZ0V1p9bQ9Db9lNnrNQUoH7p+1DI02PtHIQN37yw7+C7SH04XTlotsL+ZqSJs3vsTZOvlQivfCgGcQduDI+WiJ/I9DQz5G03W+CU+RDwjtcQ4k1nGhTIz5BgnGfs8FZzp6CnNAoUTP+qhNYg01JyyYbXHgCRtB+e7DWdjfQCplSOQSqsSb2CO0llwHomdq49ziaJiNt9/hI+GQtu5fBWF3uUhlGk52lzbXn1pNszaHQWmnac8GktoFoSMw5TCnHu/DTa48gv2RW9EaEEuS41me51OVl5R7Fp/Q1dZHjrQbHHQtEHZidQZr2aJE8ybv2+Z497LB+8b9LSFh11E+iLzYQHmZ748YGSpfqBhfFZzZ4D3gSg3aMR7epPsGOyOvWbNPaou8sDvKI5QsOR8r9T8NoMUKDRJ06rlJAPKScfY7IwgBUcmMFu9p8NM365GUfwi82jYKhZNF94HDJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271c37a2-51a0-4844-7ae7-08de0d44aace
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:10.8986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiDi21jdKPbPlfJADYZMjlzQEnFmJwCr6S+X3BTxAc/NAo/eFiLYFMpbyxbWmg0dTIrgKvZW9MFhNX1iNVNvf5RUaPGLWW3iXKrEATDBM3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170045
X-Proofpoint-GUID: nZ9405LGsMe9_WVpMG9nMwaJPEOAo26V
X-Proofpoint-ORIG-GUID: nZ9405LGsMe9_WVpMG9nMwaJPEOAo26V
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68f1df2f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Z1HUBbmx4UX_vy3hcwUA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfXwqBp6NMdgkRp
 EHnuzNadKZJCwMTs0Dyzro3fRsfmmBvOZQCTyXst7z6aZeeXOYfZq8mXFEfQT5qfqzfZ9RP5bK6
 TGwXG8E2l2jUJy+z0I4t2Yp68Yt0+mHhYB1d4soUvccMPaGAQUENhfmmF8EQU7rRR/MTsj3cTz6
 IdpMLYmM9wcbxoCWTxHUtbs+n0Ez0y8OFtqyf5XLg0bWCJ/LDvIUZU3/lq1OUcjc4dnOwHF6Mvm
 2Oq3CgWoO/aZNljesMM/5k5Y2YTyovAryaGqlnstb82nA3cCX+vs4Ls7mdljvj7yXWy/to06VEk
 YSJ6S9cx9Ervqm/Q0JqdtQGX6rCOl6q4/lMlx28/UI2VZGdjXnRRZjFka1t/d/xtj8F6hni3rrn
 zEwObDpOPwgxi9WOuHMwM8t6Vx0GFw==

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). Limit this to when the event-stream is enabled,
to ensure that we wake from WFE periodically and don't block forever
if there are no stores to the cacheline.

In the unlikely event that the event-stream is unavailable, fallback
to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check for each
iteration in smp_cond_load_relaxed_timeout().

Cc: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f5801b0ba9e9..92c16dfb8ca6 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -219,6 +219,19 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+#define SMP_TIMEOUT_POLL_COUNT	1
+
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+#define cpu_poll_relax(ptr, val)					\
+do {									\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


