Return-Path: <linux-arch+bounces-9982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75140A26614
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 22:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A2F3A3DDA
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 21:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B118521148B;
	Mon,  3 Feb 2025 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G18ohPU+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YFrx+d1V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730321127A;
	Mon,  3 Feb 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619386; cv=fail; b=amMc2l+bCNwFhHtJ5N/dHg9rdWpLii0nSzRZFdoBJqtpJc3Ir5lZ/0flbNVVnFBVv/k49DVRYcaZI7/dy9CJlDnsA4no1kBcIfIYT60oAE98npRkRzTkwHepoN7ItT7CoyPytVUaQk6RedvhakPNELjfod21iQfp2BaC4x/cgQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619386; c=relaxed/simple;
	bh=jbbBPT/7trmvHA2VTl2JUjcENd68D/Jy5Sy4dFyrrLA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n94/D+2ChamL6RT8F+AF1C80dLbpmh1989iQ0ZD/T1bzkP7fosLvwJSUiJDvcGuI05wB2PJklaAiCF9+/19bdEdS+HFlTjsqrvWCmpPNwtongPJXBJlnVzXAF8j17+nMxaA1waw5iYajJuF1cVTpoWawLMK6Z11e5yMuvGMdqKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=G18ohPU+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YFrx+d1V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMtkV024975;
	Mon, 3 Feb 2025 21:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=PH02Jf7Pt7dKKHK2aY/SF55pk6XPOHTWsr2IZ5TmImI=; b=
	G18ohPU+VPCbG5TvKJCgEbsyRH/ba9GB50kfi/d7aY4k0+Q6/puY0ybgd/jzRl66
	76xvAO/DF+MR2iqnQR/vE6L/t7sowXPn3316Zx7XrwrbdS9umAFs2vD6FNoDEudM
	6A2JZ5QJPUbkR13+aCFLDeGQC3fNI1V72e3BAjAaPUdw9btITj5H9w6e07KtFNc2
	9LjJ9/T1P18uIFUDbBltddw3qzRqQKjmkVjAozCxDxTBqfr1wRzlE5mT/EHGa0Q+
	k6SSQjVHeBS1dUogFOZDIVN8YEUDTn7gwNqJbmixvsSnaSKDzqv1LVFG2C7DL3R7
	+gM6xgB3QIZYK+1tEfOBGQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy83n20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513LQcxp038900;
	Mon, 3 Feb 2025 21:49:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8e6xjya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiT5eOJVhNTKkDdhRLUaEmlZuu0ZN5zSj7r/J9gMFj22odJ1VvCNzrWZhaUto2RltcM8XhHKfhsbVIXepqKDy5tESmI0QTdX11FHOeX6fkZ5RTMgp4AoxIH4h6D5tDr8L6VrlcJ7Myy4stvUcOHQxG9LTQfs0FRKTsGanAVeSc1npf7FPP2tIK+eHZfOc/Vtgeve277f2w25ZibPQGIQzEjSMOPwRs1Aa4Os57v4mpzEv6Z35dBRvjsjG6TSw/iu1a9kiZNYK2a2wOFTpHTWIx6tQbsBoYnTl2rPU+aWbxxANAwy2y9xCAgIFV3WdkrPMt31VGraHn16QZ5HYl+Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH02Jf7Pt7dKKHK2aY/SF55pk6XPOHTWsr2IZ5TmImI=;
 b=HQ0gVX0665YErWGTZ99NOSVCVubGlONa3smYf9u7SnI+Hs1D/XVdDoT+dpUQ1sotr4FxEjwmOXWQNUGm50yHWtvakWsNBWKN7lRth5mvJc8mX7qd9jG3jHwre4z4F5CJZmmuNliLmaTZneYwIjmkTWvM73eAqitPm9PHjzyBlpJ/RQ/ySa78O00SMmySqTYQIdiGvdAXj1Mn0gBQj5/l5ZDkqs/vXqds5CJ4I1iYczpu6Wa7JPU7pNIKGSSePeflbTo91SiVcqZOaNo0HKhGSahUmTf64zPE213YYGOe11/UIlWZivdjxAt2HN0xKq3wQ9nmQx26jCChqeLPo9LCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH02Jf7Pt7dKKHK2aY/SF55pk6XPOHTWsr2IZ5TmImI=;
 b=YFrx+d1VGY/pfeYBYt+M2Ull26OISIEqSqgB1kSpaUn/VCZ5u3G/XIixq+1lIf6/REbVuo1xv9CVo2KNfGVHeNw0W+LyjJc2VA8MAg4ZI20kQPF1GTki2mT8Siuz8iJsFjvl7eTzymFB/Qu+0cX2QQD1OV/mU8av13tst39nEUA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:49:17 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 21:49:17 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 2/4] asm-generic: barrier: Add smp_cond_load_acquire_timewait()
Date: Mon,  3 Feb 2025 13:49:09 -0800
Message-Id: <20250203214911.898276-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250203214911.898276-1-ankur.a.arora@oracle.com>
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 93db88d0-f448-49ea-6df2-08dd449c9b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NYyZY5unlZPIpSCpKo3j6R3a1jBc7H1LbbPwXP6RwEuiUVqE1ai5RUgfzyZE?=
 =?us-ascii?Q?guzw8z1c0X1uHWSYppKyDvyZHUrMcLiy6kjWVsxiLU4rD9ac23jYlE6UxW/Y?=
 =?us-ascii?Q?cd32mJZh8hpQK+oAVlLKFdc788Bm8i4RAlgBUsfW4JFbHhLfOjRDyQuXnA4o?=
 =?us-ascii?Q?UWMclZEiayAAGeBUbOoNcRxJU4MYReoqMuUjqV/RxkYfdc4Ndp8rBjm27eGQ?=
 =?us-ascii?Q?SuM+Cb5QZlQtbYz4ppirayYzI9Lln4X69oUoVfxRgEMKXRETpqQE66aOOHI1?=
 =?us-ascii?Q?bBfB83L3WBccFeC5gCpfLcvu0VQGvAMJjWD/XPpC+FiGN4EZ+1h/gIaRXIqw?=
 =?us-ascii?Q?Y7DXz6ZmNYjHnAU41NYiEkgYoX5pPUierDQ8VLCpx1M2BhUNZmBmSpfpBCV+?=
 =?us-ascii?Q?7lIe8WuV1O8Z/9lQtm7+Ud+L8BBlExsKbNzQXtYrufoGRWHbgn8N2pfP+SRp?=
 =?us-ascii?Q?X0aRK0wOrE3J7jv84oXXMRcTszLsP54/Rz+/xhHN3IrnCvdUYM77nJEcJkqA?=
 =?us-ascii?Q?gomwk4aLxZPJBOSrN6e6r1bVdzIvhsRL5g8PR2u/OeUd1ejqaz9kQvZi6UIF?=
 =?us-ascii?Q?5bQQxxpWVcm3usEeEn2fwrDQA2E1nVt8xwxfYLB+6iWeajQkmy865+pLEwUz?=
 =?us-ascii?Q?5iHP8VJ28cSDBVec9iSgkMzuQqTbeBFSOc5ISC697qU0X1bFLUUwr2CY9xy3?=
 =?us-ascii?Q?6TZhk6bzxPJpSNHuxfhDUKHvF1eW38qXxmg4Go8RY6uP/xa7Brh1P0mURirQ?=
 =?us-ascii?Q?MsIEOC7cFqVgzMcqsovs0OuuNAjrFk3XgZt2tULEyog7nMfgmzA2TOYPR4ho?=
 =?us-ascii?Q?s1cdhLJPE4QfgaXTRZSnteGg6y7CaPf5d5NIhaD7J4x1ylKxZ8/mV8C/X5Pw?=
 =?us-ascii?Q?nu0eYpastiX/mvl+plMJ5BeaOTCodRuDVCgqqsMYr29M2n6Xx2g/cQGfjpn6?=
 =?us-ascii?Q?2maF9W+20JD3CwMYv1ySv1bPKjA33F5319ZFWG5ae3CAx9jgTyny8LF5Q2t+?=
 =?us-ascii?Q?pWToTDesap8p38B5TJDSKcKfnhTuxV5xd6BIK4zElxckvK+OVLPW24A1wcH4?=
 =?us-ascii?Q?EU/Bqeqw9HUzRwK92hXhyucNFKpi5NdjIssIyHlQZANFHoM6JA5KAZPGNMRb?=
 =?us-ascii?Q?d6ZBBAZVIseB7rHf6QedLhSg8sYODzzD+CLiXx54ShWOirgVZR2MreIqwJgB?=
 =?us-ascii?Q?SR/YQK0zJEZBvP47bta6g40cXpJyQNHcqsujZrIY2oVbF/sIpLjSiaIvvaE3?=
 =?us-ascii?Q?sVAuD5BR45LRKXSDoqMcqtce2UKQd6f5tkX/2s9vbKrW7vk6f6nN/tLXct0i?=
 =?us-ascii?Q?+eA2xrRQSmNz2UldewaVzufBa79FjPM2xAyGKgMoicrcrhnNBo99YEnEVgM/?=
 =?us-ascii?Q?uztVP9n0kXN5cz93LpIz4U0SPOFx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PsFBcMsoYcqZJ/hdIJjxUfpGf+s1nmJNnwytdckRg5Uilf+E+cMq4RB/QkEz?=
 =?us-ascii?Q?GsCOTbfFSUa+AHLiO2rivlu7yxKyr9r+jzB/0SagP++9vUDS86iFUHn1RTnC?=
 =?us-ascii?Q?uy8RKmCKjKpAo+mYfOLALUpypDz19Ssyiqj3I+tRi2yk9RcMMzbV/L+XGE4D?=
 =?us-ascii?Q?aetLHNZ7/vObZvaXBiEHWjayn2cYNBBs4H/uMF3T9iZ4wVeQI38Si2Eho1vN?=
 =?us-ascii?Q?ZkImOZ98AwBm5iakQHjHiaSHfSqCuHOFMUIHPmlLrjOF/A4jJNyX2WJQCc9z?=
 =?us-ascii?Q?tyCz5fIhsh3cZnjvc+Oc0DjYGj38tRUKgcNw/wRgEqgxCoL+iJZ5W+CY2cgq?=
 =?us-ascii?Q?4KAF6it19yNYPBQS9CdLP6Drgt1txIotjLnDWo+kOn8FruxRZJCvJ8afeOo2?=
 =?us-ascii?Q?2sCQ+OZ7W/1DneGIoYbPZGrkGK8AZdkkF37kr4OAxL7Xa8Jpk2Cx81RHA50a?=
 =?us-ascii?Q?kQKOGw49QacHf15Ni3R2xNw9gC1gbdM4M1AGcmyr03tz4mGBu/J/yzkdGguz?=
 =?us-ascii?Q?slEEvSzd+UShy678hO5lp/mtGNwBFsu71+81Boar3kD5CZLuM+oel+Atb6fF?=
 =?us-ascii?Q?t/HodT2ut+vW2bJ5BaRckr37+osLlxvn2y4xvB54UendSrLAcJhkQL/Chex9?=
 =?us-ascii?Q?1HFmwBgzTCu8y9IYDAX/gS0SgFNkMLPOtgtwRJ1eiRYEeA00szEVH282omry?=
 =?us-ascii?Q?B6zR59NJL8CSWKGDjTc6D5ia80dx4LMz0RbhfZrMRw5TXlg8bW8T9ddE49+7?=
 =?us-ascii?Q?ETtMXQCl0kGNj0y84DrduPZ4uxYL0SgYjfN5/1BkFk0tSjnNcO4QktaTqtdk?=
 =?us-ascii?Q?SyPeYkZQu+sYlduZrygnxK37rx6zsg0Co2ajJfbydWt/FKaH0LndKxLLRQPN?=
 =?us-ascii?Q?/PPHj9K3+AdorA1Cb0GKUzxVC34UIvMReP5XBZAW2YMJDDaj6U7blEVY07KA?=
 =?us-ascii?Q?nBzGpbbpq8IVnxjD5P9Y+d0beh/80ktumY03lAJCoXczscQMmShwCOYr84eQ?=
 =?us-ascii?Q?lS3GxBckX85RdMi10TKYtrPfkOAP0lFE+KD5g1yVV78bKS3lOLRVrZ01CKra?=
 =?us-ascii?Q?z3zbAVapWObwLPmAPb4fJ7QTs40wSlMu56iYrhbtXYDe6RfSla70CEXZHEsu?=
 =?us-ascii?Q?ELuX5q9rW5OqYTnLWAzHaU9tuotLo87SEdfn4z0+3SHaAaHOG2k07pzX6FzA?=
 =?us-ascii?Q?yceAoUWItcFjZp9PFL6DNjLXxGIfHr4fMARYzrSsM88Z68HFvmU+eK/xJJNK?=
 =?us-ascii?Q?Qw1CNM/Q2oUx5E42ItPQCJRE7clAuMPN2i8ltyRHM/NZT5GDMXNsn4IugxDI?=
 =?us-ascii?Q?ujfQNf9vSdZQ0X+au09XxS4FbsGorFWJcK86Y9sR3VJZ5QIK6Os40v4bIKfo?=
 =?us-ascii?Q?mKu2htw1ongK43aIzO34LRIrHTtukyxsWI9ovYuKvbc4hQxQa0lg/vrD8kUk?=
 =?us-ascii?Q?BggnjpG8q42sc2pM2YKkn9tPQa2CCGDJpA6SuNSSfcLUCoZpaw8axd/AWZZc?=
 =?us-ascii?Q?e9lCjh2691di3dBldDjbzL/vQgI+c+i7/7WYGcd6rqFUFKjpennNE6Hp2tlY?=
 =?us-ascii?Q?gRY608xGNDQ4MCHkuEbgLx0hITDZUYBhsodrYgbJ1fhKiICBMA/o8ay/kLjZ?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8hwHpYmMLf6GmsAROfGxZx7T4ks/Jyaz3QFAWbOMj3XKa5jcv+FYzmfmpAKwtKNig31QFKH8vzkm4wSf1CMiW7LVMWVSmnp307Af4AR58YklZG+FPa6/LL5R+mxvE2ytktP/I3+vQ0tZLGCybFTinexpkw/f4V2KPxOIPdDpElqWHhMIOK7S4njaz46b/fYULi165DyqmxbcSHp7EZZpZITGUTNZwvGy5Ruf0C7mz/oHMR0NLSfhx7AiQq51PcmTqK4OXbXS/zqppxXRh9t9Di4M4CxiWmIHvNG/lJ+kVCwKuwnmAPc8xy5hnNvqYAAOIVx9tmqe4rxc183W1AP12uioERaCjXxq7OLx3NBza/SbVyADbResNL7xePYF3k0JbtjNOLzcjzkBMAjEjgMzxP55kUqUvINwj1elbZHVaNeXXQz3+YDsRzbqmLI8fuSFOrVgX8vHU5pdDOb2TM3l/zjhngC1aRkveq56Uf3mM89UCyG6bfOvhYT/lsqeaQEonM5IYdXGfHVDkOKJt4bPZP8FRB9kfZO/2XQIjAPNfRVRM1JpzOx45Z877Y2eMa6N+PTO6jcs4PG18N98TQ7OfFDgAFJdc8OvlpJcohIqNAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93db88d0-f448-49ea-6df2-08dd449c9b8b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:49:17.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BO0c8rJMd7WtMX4yhJa++vKHB/DXv2dzzqTzC4h7TlplU4FoFra8XuULH0nDlj1vTtxk0QYcxx4VIsMYCHa7w1273b8l00mxm14MpMVrvTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502030158
X-Proofpoint-GUID: TNWc_Uzng5y3uaG-VSCBdXt4TGe_22x5
X-Proofpoint-ORIG-GUID: TNWc_Uzng5y3uaG-VSCBdXt4TGe_22x5

Add smp_cond_load_acquire_timewait(), a timed variant of
smp_cond_load_acquire(). This is useful for cases where we want
to wait on a conditional variable but want to ensure termination.

smp_cond_load_acquire_timewait() is implemented via the relaxed
variant, with the additional LOAD->LOAD ordering via
smp_acquire__after_ctrl_dep().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 31de8ed2a05e..62673ad37db2 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -321,6 +321,29 @@ do {									\
 #define smp_cond_load_relaxed_timewait  __smp_cond_load_relaxed_spinwait
 #endif
 
+/**
+ * smp_cond_load_acquire_timewait() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr_ns: evaluates to the current time
+ * @time_limit_ns: compared against time_expr_ns
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timewait
+#define smp_cond_load_acquire_timewait(ptr, cond_expr, time_expr_ns,	\
+				       time_limit_ns) ({		\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
+					      time_expr_ns,		\
+					      time_limit_ns);		\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


