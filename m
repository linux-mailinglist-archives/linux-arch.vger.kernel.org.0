Return-Path: <linux-arch+bounces-8902-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39459C0E8D
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82CFF1F25B4D
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9479621A718;
	Thu,  7 Nov 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvyugIT6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QYyJ0E0W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE51F21A4D4;
	Thu,  7 Nov 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006573; cv=fail; b=VUpIdq+SA9nBB0UofDKU863Wj6G4BdkLF9+QUhM7PRm1MXONKlY9xJfU3ZNbUsLHBSWJZfA1iWPPjAlG8IQ/I5v/2Lvyv87OjV1OKcs37n72TaUy3LOWB5kx1Lzm+LIaIlbVjSRnuvTGDZk0pvcSOoJyXGA2e8gUxH1MhQ1JPXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006573; c=relaxed/simple;
	bh=DVVhYd/WrhOtb8aUDHlylIdNS9AATp/2thz35KUD9e4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=prH80AJKEM/IN3AwBMO/XdA4Anya6h5WazGlM8iXevt+HwCQ5UfA4HZeuqJM+9ORh/VvKEk63MwUDCVzBB5Ti5dWkEYQzs/9D4FJOaFPJY0MlqIhd0qcarq4kAgAXjuhwdo0zKGdYcMju4fzxcI57Hlylye5x+oo8qDCUFsPJY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JvyugIT6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QYyJ0E0W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBgoh004777;
	Thu, 7 Nov 2024 19:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vbxLcRDXwMau6ojZuyq/zCmmjpfyFtoL4t1auecO12s=; b=
	JvyugIT6yY5ZJv4nZ3OuS/ze3NLtBbSumtYaJweln09jFkKGoGNbSyN3QTaF4LmJ
	pS9qmCURkTsczP6mtoMNJ6gbhT39QTeF2h6zP2pB3+I9gkaKm9iNPSAitCvelVVQ
	kX4aPujzJTtd6NEK9UPqiZyddGhaMIQ0CoaqxPWywT+/7ZiLU8SlqHq6mW0O/Kzo
	SkImW6rP00ukU+euCtMvrTgF9x4AWaZTpkb7+fttnE23pKFZYHcQf6HLIFqxybRu
	pXOULLIcBnV5PqVn/pyfRSJUf7291K9DsC3U+jRO4oHRlj3KDIcic2HPm/ICP7xc
	dVg1hISwPIWxVm7712Kvug==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap03d8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HuoFO031413;
	Thu, 7 Nov 2024 19:08:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42naha6cn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHYU7SuaOZjJrvGAewVU4vHppufYR7+3ucTqKmo2RJTOlrPEmCSVvopy0BA7XtMPXCKtmNhV63ODn4Z7tVWLb/xK453vKWT3OEnmhcQD5pILeHnXAgGl2q1+D8+wnI4BjV+0/SzHhfRG6ve9UQUdPOBi+BMh9oYlo/cU0/o/vTlEiZjXj2IQZQLXzDbX9UUScdUa6YqIGPHGp3FWy6DM8xYC0+xZVa68gcvRcAendtkoeyJPp56h6M9ln+xYsP9KbGv7FAhYzKEUH1oqydOBNzeB4/Ug80CHRb8t93lLmQ2aUC2BMSlYPXJAcs86riZHVL9otbihCiwsUPpRjag1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vbxLcRDXwMau6ojZuyq/zCmmjpfyFtoL4t1auecO12s=;
 b=XPvrIIQQV+w2g39xrH/bUZByDz8GyN3inpLKCGT1sxGUkQDkriVK2pYhm8w8zM2BawJ1tzPr9GP5O1Nxy/0Frc2Pp1Aqcemp58jjaTzXFlrSIDh9qZdvJjkqgSmVi8SPi80We4LVieBllknWHVsiCsneOwlEyWnQRxQbzv+XXw4LtPN3dU6I45KmOnI+R6ni6t7zdRAqB5++0Hjeu51+J81GexO0VYL/zbVpAEgoa/Je6y5cV5hqIeMhrgtpaz1na7d0nTytcFjdcAlTkTwpfVh86b71wh3D5rk9kUqOQJKDVb3AdFAI5mxheAPnig11XY4ETRlfyzCGgy2ES/5EVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbxLcRDXwMau6ojZuyq/zCmmjpfyFtoL4t1auecO12s=;
 b=QYyJ0E0WWrNRvrGG/IcZrrpd/vB57sE2K6/4J+t8LjzYAk6FBT8fqzreHIqPkFg58LHojM1AYd0SpveMnVnFlmDbq9+H0jAaWJ3os7NWw+WEMHFwUTijTFROnPbAjNDIorXgCgCLJJzcYMf9wsiezSPjiEAdDY6o8tHocw04yA4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ2PR10MB7736.namprd10.prod.outlook.com (2603:10b6:a03:574::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 19:08:49 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:49 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, cl@gentwo.org, maz@kernel.org,
        misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v9 10/15] governors/haltpoll: drop kvm_para_available() check
Date: Thu,  7 Nov 2024 11:08:13 -0800
Message-Id: <20241107190818.522639-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:303:2b::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ2PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: da8681c3-1d68-42fd-cafe-08dcff5f9c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7DBvckTMLZ0nFbzJij0clM6HDhC4QGIDzXzGkgPZAuwjLKkv4VrdTjqs4MH?=
 =?us-ascii?Q?wJxE8mIknSQASV5hnL8/adaj8cSJrg2th0KoPFA/dIG4NtsCrhickFp+ij1C?=
 =?us-ascii?Q?bQCt/INF9LeMwyFJbGFLQpuhcW3qnZpr1sjt/C4uv94KDsFjpyX24QhcYPC5?=
 =?us-ascii?Q?8RFx+yvrdSE5Qmrs+0BhH7yydbZbdDev8W+ChvkXKSKbv7f/7OxDc09D7HwO?=
 =?us-ascii?Q?+H1/J/6PU7Ltf1VdJZmVVC8JBm+WIZmqJ3ZconX1C/uJymtf4DSABkrcHNDi?=
 =?us-ascii?Q?LbQ2cfVpkqDD9O5Zubz0jc8GcLlbw8/1GiQVbetMyFtdD/QtV5kmpRGqwqtM?=
 =?us-ascii?Q?/hXNo5kZav40ZZ+p0D9WZYXXXOJQHbzBiLAZ0DoHdkkTrgNIx0bfF7qIB9sd?=
 =?us-ascii?Q?57UWGM4Se5wiDHohqSvE6X7D9DbWTl3BWW9V6kzn0OKl8Wrq3Z0eJV6coXE+?=
 =?us-ascii?Q?Gnd4SHsVatJ+uzCgDW0miTJ3y2lw2AjNZIwsTpeeOBuTgoHlZBgRIlzlI38f?=
 =?us-ascii?Q?Q2x02pP7/euaZi8/dWMJVgQYHAQmjfO+T7JlkgA2nC0jAkADyhi7jCVIb+Hi?=
 =?us-ascii?Q?WrBAJVm78OwBrbc2SRVQyZzWGKK1cFZz92Uux/MR9L+SPvyTGwW6sOOydqkP?=
 =?us-ascii?Q?64R+yKZVY+AOTGapuS5fjCjsxpO3jPgMW9b90xwEt9eAmmTTqNME+BXMZ64A?=
 =?us-ascii?Q?Se1rAUYSa3JH9+Z5WfbpANT2qNqy5uW+njyT47gSoiCjdJ8GwnXc3FAB+/2L?=
 =?us-ascii?Q?3UG67qD19b5TPvTLAPc7hQKUui2Wu2GXqIrmwqlYGJ48fnEbRQr8mM4SsmM9?=
 =?us-ascii?Q?+IYonuPxVo6rkB1FsEiRGs9JAfjcf+SXLld928D0oU1rIQBPETlALDiGThl8?=
 =?us-ascii?Q?SIJZOHRsvtFkuwDUqzJYqe7zKb9lb1FcRKoXkWqz8aph/iE/bu7OXvtM3tof?=
 =?us-ascii?Q?hPzHV1INbuFZqs/XLyxicFl+ygxpxjcgtoNAtoVfrawDoLrot8cDLCVBg9Z7?=
 =?us-ascii?Q?+AGREd5TkL28NlJwls5i+z/zHz1+EkkOEUf26igQLay7QAjHAa97WFk2IBu0?=
 =?us-ascii?Q?fjFF8NF1T1oSnCkrc/13Ri9etOlYxvI2oJ7QmKXPUBdCFyiGafPyPYhV1bps?=
 =?us-ascii?Q?zHUrEMQO23BlBdUvdaHSV8uXAJ+FacWY9iJVG4ogyU2uRRePMsequqshsgY+?=
 =?us-ascii?Q?zEsCY0d7fFO35dl9uKmlxcqYRDq6JtpUnK/o00cI4egTqfCKEdkBWMasx2k8?=
 =?us-ascii?Q?YRK/GaHV0oMv/50q789CwidhYziGbh18Jrk545YYTd3sjpASgk9tDT4gYyID?=
 =?us-ascii?Q?BQ1qWAbecHtU2Lt0TzGLdmIM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kgiDIvdF9LLBnqtepMRCwW3usphjX5b8PP7zYT7/2lxStC8LRvDG/8mwdyD?=
 =?us-ascii?Q?0JnInhkRBY1nAC85CYtsOQ2sP6QcfcpJmim0as69R19dq5gUUwyUYIit/eaW?=
 =?us-ascii?Q?ch8qIV9xqSs2EOxrgnFt3nL4sDKEUiacMuKvd3t1sB/OUlSHkTlqlyMvjxLb?=
 =?us-ascii?Q?atuiKdeDvdKdBNhM0LIvOP3iHaRfx5+xGrvXf/knFkpzJ+KMgSvxubmGKRf3?=
 =?us-ascii?Q?9QC+5MsqZTZhqzyQ5RoBGRXWP4MG8fWbfevSv+2DeuMnW/kgsDM17c/N7VqB?=
 =?us-ascii?Q?1Hfzfb1XvpX3sDN7XTGLiugi/3YteyXgvAMukyZ3V0qJWEYQRWoYZU9iQUA4?=
 =?us-ascii?Q?mdwJTKLj1wyF80BlqhNKYG6QPurOI66E5gxlGmtB+Enz2wBNOOTijD3eHDUN?=
 =?us-ascii?Q?CT+/M0WgJh8Q30Q1NcBvcE32fGqe4aJfj3918RtT6hlmPrK/sgO1KkciAgoE?=
 =?us-ascii?Q?EgUe1zU2gEclGE1sMsgqKAi3FmOr19DbJY52MhuU5RBKM/ySG67K7XlmDMx8?=
 =?us-ascii?Q?+ttf5iKIW82jWmlFEteD4yVpFZGCrCsULyxEetrV3FadVWBcgmWYLea1QI1Z?=
 =?us-ascii?Q?BTG60viSvoFJ5PbM818X/JwT54SoXMzFJ93vqi8K051+J2XjKf5xnPO+njB0?=
 =?us-ascii?Q?0R9G+fDhvSXpNtLoqU40dJdSuQYVsEnFv6r+dePocNXtwnxes5+mlW/KEQAS?=
 =?us-ascii?Q?+fOjL9EZyFdP2lEClS951GVgv32An1X10jmCpALamDG/y9vw8OHr7LXh9s/P?=
 =?us-ascii?Q?IVhGyChwaj9gawA1OcdcqhdM91vwI4WM01HIpZx57RCs2HfE6J5T1ikIL7zT?=
 =?us-ascii?Q?dAmUH5MAUD7n+46BFkSZKGXPevtQmnx1VyIecTPjIHQBRGBYU4uWlmrPGuBH?=
 =?us-ascii?Q?KLuViCi/vnO9n5szCP0M7V17OxIXdAW/APrusHkmlpqb2UPfqq96okNugvdI?=
 =?us-ascii?Q?0kMAaZNU8hIOVXv7nSgyqG1VBfEQqdFYghFk81L7tcPV4Po8czoPWdtRJ4Lw?=
 =?us-ascii?Q?fo/eNK+NWID2+7ypYMlJZcYT9DIEGm+i5EVi4lIn8UxOE59XNZTsaf1xnstr?=
 =?us-ascii?Q?1IelgcDh1nuKsUePcUJOS21b5oAauBo5+c1Q+6iEGlIPu+ZAJiIx4ykVOjdt?=
 =?us-ascii?Q?kKhccwj0yeceBvi7rbjuhK80OpI6H8thAPK3mZtZzKY25UCiH0sy0q0nAgRi?=
 =?us-ascii?Q?FboPbKc+BqQtjeCVBpadTGxgORdcD3a7secoXtkYPKzTkjlJIkiNKNIlCLeY?=
 =?us-ascii?Q?IDU+9AO6yc59DdkbNw/ciPo/hQGNL0Bks3twJ3oPweM0U+GWXCM8Uv0qXCUs?=
 =?us-ascii?Q?DtTbs9pxwIBh3gERWKLI6Pru+OtiXh/PmfT0oxRF+t3TdmFR3f1wdvw5qkX0?=
 =?us-ascii?Q?XFrOOVkMnXP85tSgdwc3dDMSyGdXL1aDO2uMc2q+tbXGVEbpi5ebrgm9Xnnz?=
 =?us-ascii?Q?YdoEGg6ZrwGesjEpMC1QlBPklkGAORBAbgFMx5Xn2GMQVt/tJaW9Np283vGx?=
 =?us-ascii?Q?Ul8gHsonU2cr0NNx85Fg3lf14EF7E5jFMUl7haHLNmGW4gQWwZwpitjrE74P?=
 =?us-ascii?Q?KId/7eZLQK2COuzfszqgBDF1l9OMNj3wYIjyU6UvhCIXRxcrE0FG+hZ7NeYb?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1zXvoZuJZ+yFLK7vrwbCS8zdGRM8wRhixmhNePyg9XzCbwBIImeq1YSiDyPH1InetGAfNw1vXF4dnHeGyfrijtz1c8t3khFeuR5+IQ1E/vMwQQUCy0QDcyH6D06KHiOpv9U7Vr1if0Lw04a6qqzO9Zqlj511BO4z9H2SqJhGZGazntp6UY+6alpdefqmDzrpWq+CyAatz6ROKnGPpg4wRTrOPxhsiw5H2iTNX7cWiSTEF2FbpNfzn7px1AWwXzMYqiNTwk3Ye1ZBdJLJjGWu1gEPOdpD16i6JMN7RpiarrFEWaapMNjUHTXS7qfBCQ4vLSFTCFfwujhKXWdnWTz6lG7YJ9RJH9kSI+rx30hZoVr6IyEK7vzsGqekmqK9leDoM9lKPklZKzNEpBMhblZ6cwMBBmS5V4bHjy/ShlhqlWyRFR/nZB7mDGXbqhvIn/Bbt/nKPlfmsiSs2cDPioiXaC+oFiA5NHnMvAhhwYlPVUuTW846Zg9PhAXsGmhCqMwYQkVCba9INs9GM4AKIwbFuUo8XY3WHfZXwAIIbHRksCAzJWwhuV7tv+aKRAaa6juODZnsftioShcSq+1wZplsVn65Gs5CxHg5jhwvAAEbJY0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8681c3-1d68-42fd-cafe-08dcff5f9c87
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:49.5254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qpYzJIW1GWJt/qteBKNw70H8Hi2hXWa0C7ZuhvBbclxIfJwxWXZz7ZKMeHXtE8Vqwse8T07HhtzsPZD9mRkDYK8Sywlt/wzMgGJ9/EPJ8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-ORIG-GUID: mvbRESuLZ7okeDC-4lhKifUqEaBRIEns
X-Proofpoint-GUID: mvbRESuLZ7okeDC-4lhKifUqEaBRIEns

From: Joao Martins <joao.m.martins@oracle.com>

The haltpoll governor is selected either by the cpuidle-haltpoll
driver, or explicitly by the user.
In particular, it is never selected by default since it has the lowest
rating of all governors (menu=20, teo=19, ladder=10/25, haltpoll=9).

So, we can safely forgo the kvm_para_available() check. This also
allows cpuidle-haltpoll to be tested on baremetal.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/governors/haltpoll.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpuidle/governors/haltpoll.c b/drivers/cpuidle/governors/haltpoll.c
index 663b7f164d20..c8752f793e61 100644
--- a/drivers/cpuidle/governors/haltpoll.c
+++ b/drivers/cpuidle/governors/haltpoll.c
@@ -18,7 +18,6 @@
 #include <linux/tick.h>
 #include <linux/sched.h>
 #include <linux/module.h>
-#include <linux/kvm_para.h>
 #include <trace/events/power.h>
 
 static unsigned int guest_halt_poll_ns __read_mostly = 200000;
@@ -148,10 +147,7 @@ static struct cpuidle_governor haltpoll_governor = {
 
 static int __init init_haltpoll(void)
 {
-	if (kvm_para_available())
-		return cpuidle_register_governor(&haltpoll_governor);
-
-	return 0;
+	return cpuidle_register_governor(&haltpoll_governor);
 }
 
 postcore_initcall(init_haltpoll);
-- 
2.43.5


