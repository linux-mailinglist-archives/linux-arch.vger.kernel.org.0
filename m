Return-Path: <linux-arch+bounces-15396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7F6CBC7E1
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 472CE3006F77
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86A3009D5;
	Mon, 15 Dec 2025 04:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bDfRd1s6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bibIehwl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5A253F11;
	Mon, 15 Dec 2025 04:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774272; cv=fail; b=pC/L6MpJeJ8h9OKHeZiK1NKN/y3lMk+6Nd7dGd8tI8aWsX1nctJs3FZlWrT428BdzjDHboPzivSTJoLrI7P5BJurAjO8pU7NtAde9c3xU7xiiTtAuG6CQHFJWYhx+U24suK6BIooYFxBLFDdW4KUEL1cuswTZyLfmbQNDrHgjF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774272; c=relaxed/simple;
	bh=Yhzz61YYmGdTL3ELOvYnaZNQ5knN0WJs5c1ZSpH4TtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LOURCQFp8NnufuVlRYK/P2rWio1xjSNjTg+XPaW2LUlV8Bq+2V+B6AoV5bD+hm93OefDpvfLJqrnZwWQaJ3AfPqob7Vvmjl/Go9RoomLoWS4E1HYa/96NXU/CGCEAicrHaxReOUdBmsOCMirW5aQhq+V4++aLn+LjeYrCQmtPAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bDfRd1s6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bibIehwl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF3UxcI1470666;
	Mon, 15 Dec 2025 04:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VRULXyJ9/p4woM/6OiWNdEgFi2W5iIyYQAPf47z5TZA=; b=
	bDfRd1s6w8VKutFoU9c2mBiXWulLdLP4v+C6yXEjRqLalxNVy8HeEN1IqF5myX3e
	h6HAuhxxZ4FOP4rhnEwhktsJezh6SZkuTRPu0BIhZcA+BM65qGnXT0/uJH0olVT6
	FbeDNyCs5ygWCAHbi7bZNAcz3mawTe35b4GN08INrNpcRcyje9NBxt/boZz8YvO5
	NKs4b6bc78/wjL6OvWs0uMWsP3KQPsbsZVRK1PqMvf1cdJ0sAegJvR4vel41cQF+
	yfY3ahqTcab+29kGB1yFYI3D7s1F77zoAVFvQ0K1296UKjcUq9gZmcmJNmB13MNG
	k7LrqXCDT+Ni/h8bb7EVXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106c9a7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF3De04025232;
	Mon, 15 Dec 2025 04:49:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8rdf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjH7DjZyKCK3JLii7xzlSeZsbHMi8KFGYZdsPuXr8UofkZ9gaaFJm2yuV3G8Yovn2tYJ6wgrDil+k89v2okELyQ+4hQcXghWc+JaUw/ql6aX8tP0UsUp9o02ZMiB2N4F4Xc4Ct5rJep5NA3LiYQwB5+CSwm2wIKSFhwP+qfTMLERUjC6jQPJBPX/S/PHYbvuOdwl3wQzdLQ3Jr1wkbE2dHk87vDDd/M47ZPk65n9envFNbuR5KZr+DjqmHdG1dHjfBD8PtBw64R0xpJl3E3llav6rOArFWzcyQnYeejklERG6enIP/g9CrtJRQr+B1FLiiIdipO+87lcB2HqbQkNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRULXyJ9/p4woM/6OiWNdEgFi2W5iIyYQAPf47z5TZA=;
 b=BqBVusHTR1/ktFoK15RF51hpAlsuT59WfpeVaVLEG1rsq0VtqhNZDmkjEY4p/XWU76UwVqrUiTGxxwv79XyBs+qXYYwdXJIuwXWR2wwhLNjTND7aiRcEb+aXE5Js+5+s9THx2zAaP4WD5M3uKnQAJoYpQG+UxN2pBJG5x852IncVphKCdxfz8vMRTucQa/mU7fkc6ZWif2ry8Dl+i2UjUL9cBrHs62s8OdeInFHdVWEtXQ+heVXxIws00qhAO5ct3H3KzpwAICtjkN802NrPkFL6E27f5B04mduj/UEivOCM2WUaSdMCcvkYAliUQ9Qj3TNqxVmmNqYzC9aPZjAVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRULXyJ9/p4woM/6OiWNdEgFi2W5iIyYQAPf47z5TZA=;
 b=bibIehwlEfgbo5EG7hZfazzqhsKM7DgEchzLsLlRjzsu/sfwTE7XGBz/yqiZ96FDfn1u3UcFLlzgkOdnEweU3wuTT7xSotvGlpO0nv8cvqheRPZKrm3Pv3nvGWSboJzM8DwnhIA0AvyP/hWaRfGERSI9mSDfgGhSRxuph8LBMgc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:34 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v8 06/12] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Sun, 14 Dec 2025 20:49:13 -0800
Message-Id: <20251215044919.460086-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: eb249abc-6f7a-4e48-5be2-08de3b9557d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?akz1xuFiQaKIcvwRQYR6fkGlkhH0+DSeYL36g4m8ndnmK+nC7D+wj8eukUIm?=
 =?us-ascii?Q?bsYELEO9YylCIIUGAg/7eYaOj+YfAXj4OQ8XA+SAi6tnXhSVVeYBLsJaczML?=
 =?us-ascii?Q?AiCgEI3QQ8G477f88MpMZvl96SPDr4NEhcqxZzu10qOvQWV6MD5npf2f+1b7?=
 =?us-ascii?Q?dhkKJoLQx5sTtXbqZ4AO3umKrE0AXUxC9tG7PIAR/pHbLQKFP5ZLFcLggw2M?=
 =?us-ascii?Q?yjT7TV4DYNBsuH8fvH4PBgVaPWyuVWk7w56nEzED8vd3ySGTH5/tiECY8y/a?=
 =?us-ascii?Q?QzApb+aVMpbFa9qua40Xi8ozgC3hASo8yUcHYgXI2ucW0MMCBmWx7+wyNJkZ?=
 =?us-ascii?Q?+DEEyE9MuKk7WylU2S7IVFMzRZi8uana43g+lF+inaq+5QAY12+ppXcKv0Sr?=
 =?us-ascii?Q?VxvaEn4SQZzxZFAHKPDZe3AJRlBWzR+PbSAh0Ovssah9yUAO3p55TKUPyq5f?=
 =?us-ascii?Q?oYHy73U4ctINU54DsvdMTmPqeJ0prjB5sCm/0BN/KYVFi//iIUh7DMIE+M6P?=
 =?us-ascii?Q?bG3D1Wj96gBDaWxdGN9h6BiOH9Xsy7P2kWHvUS4qiMA73yMPH+T1p2FUycW7?=
 =?us-ascii?Q?FslYxOmm2LzD7StFjnhxULCia0Ii3BjOhTQThU0oqlLaHkCTyImI5FL06Zcb?=
 =?us-ascii?Q?CTLFIKQTeMp1+o66vze1Tj9LTWlyrE1w9xxNROm2ApiD3suVEcerDgpdf+/X?=
 =?us-ascii?Q?4V3jkb/us46FQjsF8GVn9p3YY0x/txnzipSRSHdIb4NXRjTm08vzV53MkRq0?=
 =?us-ascii?Q?EgNYbrqRjd3WxPD0XvZ495J/RYrbYfL1mYS5IZ+mNN3uKbkHyyjtKK1sKh/K?=
 =?us-ascii?Q?EU2rvL806xqydwUKPvJy4ySA6dtrjkSO0IzR5tXC9dyIuHvbOnrg6P1rk+M9?=
 =?us-ascii?Q?WKyM7MRADlz+TKZCMqPrpzSNjvKGbGeGeRoUEJCt93JySku7V/qIdD76Q9RA?=
 =?us-ascii?Q?+yRAJFdnFXZyoVg5o5xu8NJ0dJ1iHBf8/C5pi9F8vurQw3DZJDS0iqVq+LCs?=
 =?us-ascii?Q?2Xuf64s1l9q2dKvgUSh8XgfwsBS9chKAA+/xw7DbvVoA6mOu7X+qlKHLxWT/?=
 =?us-ascii?Q?3m139FfErjIchTZ8LS0wxTLdezyFTD3F5MtwRjuKWpITsNlkStMgc2b+n2Gv?=
 =?us-ascii?Q?8QxvZqLEzzEde20iRTxQGp1dAYaDEw7lRf6sSzb8ZWctFwIvO6LrCYX0cTsq?=
 =?us-ascii?Q?Wc1xp2QVmdzYzdx8FkTQ23FPCJKQ1BWupdfmKHkyqsZuODQTpOcj/+EvcD9d?=
 =?us-ascii?Q?6duUb54D0Duv2K7AvgkfB/eH1ts4MrZQhEczQOmJuj8MrCBZSx6FVqECf/7N?=
 =?us-ascii?Q?L2pu8xR5OUpwyIAFPNoO5olcWSG4V4+UoM8jWFpb/mkpCVCsAAUQQEeNnY7G?=
 =?us-ascii?Q?zEiqdAnfgXRUjtDR/GA5GH0yIpI6BoTEuHFGgmGSAEyy/j5TR58F4Sm6PgPp?=
 =?us-ascii?Q?DwQ8EXFVx8M9PbeaPllcjqMkKxbJeN6M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?osCP25fPre8/r1vvgMHNdHB3zH1+txGwjwLqeR5TUy+GHfiRm/R4pf9sTwNk?=
 =?us-ascii?Q?RbTZQi6p+E4yR75aKkGAtaOxaaUbPtDuz4pddrTTYJOemsrTBGrVM8HL9Jjf?=
 =?us-ascii?Q?Dsm7Wv7u5e4yJthKAC1mKszSnaTbAYI5BA9hYODVxe42Nh0kMgww0jBBUpxC?=
 =?us-ascii?Q?GhHgCH2tF0oNZu3fW+h4+fhrU3WhhWDqLGPVOepHNzOM6/tPZZq/DGyHh0oE?=
 =?us-ascii?Q?hRlgxqz/7Xjg2zi2AQGQMp06MNJZJj+g+PiSkR4kcVluIyRsGAalU6yON8+s?=
 =?us-ascii?Q?ByPe6dpaxq8cy06xPYgoLKQk3BkPr0H+/cxVwGOYvFPiJxia0joibF8uuWRA?=
 =?us-ascii?Q?4MA1J/u3duNw4UT+g9VDusVbm7Xu+PGVpqBwgxtaH78HHAhYTWKINnPe2dBb?=
 =?us-ascii?Q?wwMeWjgn6aRzqsAoAMF1ZU/XZvaTCEVM81xRVB5svROgnCkVhJZgCSvefYbR?=
 =?us-ascii?Q?XqmzbyQi9RWI0IYXjDTa5tBbymCF7+/oVa/wIt4z92PwfzuaIdnHhKk3U1qj?=
 =?us-ascii?Q?hV7ABpzsHTkldUrzVxcPijr6/fJnnbxv+2NGzVAnW1XO8XMjdgyJk203e7sZ?=
 =?us-ascii?Q?8oGEKUQM67ACqgiK4MjscS/BgC7xXrK576KbYetZdhujQ9G+uD+V/Lr1dRw2?=
 =?us-ascii?Q?VdlH8am9V9/aqBiYTjAprUPMq1ncyoNpI8iZF9Z5WFceCVHjQAnn/FmQYLsq?=
 =?us-ascii?Q?pJNftRH1SIHN9C9uiM66TNRaxqZIZL/4jdfsanlpCISr77v1vJE2sh3uvKDs?=
 =?us-ascii?Q?7O3kBdrEXSPd0uwQWb9xCMw5fn2g70QkukUN7YYFPNv7JqqcCCmI4t9Y9zPo?=
 =?us-ascii?Q?ZZBXPWrHZkFmW1jlEbLViB3BKNTUmLqrApKBJPKJ8pdSDkgJF6rOUAI8mJXd?=
 =?us-ascii?Q?UPw/kp81YNui4Sik/Oy38malbVqHuRFfNl24QzSTdcjnu/c83yB5EiLUOv5Z?=
 =?us-ascii?Q?SoiLzHc/C6PIL+acJ05ype6UT0zX7zqu9CmtUihdI7QDb6JsHZwxMJ0opDzG?=
 =?us-ascii?Q?KK8hrwLy+6SCVR1FPJbRoAuQnzcge1VNiu3ywMnfF7uunbNxYZx1Ob+jCmM8?=
 =?us-ascii?Q?TovPKCSwJ0zvA18Vrx0M20StyghpGQbmwR2OWFvf4LngMww09+Tac35f1271?=
 =?us-ascii?Q?CmtN5d35ayxYWWyP8Sv2OP48ppsZjj/swAxs3HmW5/8+QfphGKMCTvLDSqTO?=
 =?us-ascii?Q?YnoVPaKsY8D9XucIpU/nwzns+WG0zhd8jbk9QcQ7yPlWUPYOWUlsneaV9hIi?=
 =?us-ascii?Q?Nkb7RU7A4Zx8BnqEaOXe0vWUuCecb7+hBjS2bW92oVh7zFgbBiOj3It0NGp6?=
 =?us-ascii?Q?NaEVTobNdQw17S6woYhrI7faf4ITsDIBX31aiZS5SBxK3FQTsEPFE4jjD8mq?=
 =?us-ascii?Q?jjZYNJnMiuiaOLpIfL9+jKvhYEmO8I3gjOkWojxKP8zrgdV+Ds3YBYhGsrZQ?=
 =?us-ascii?Q?iD/P93bz2fKVaIwbwZbwJMFQx4NPj02ynwB5BO57W23dnLn2b7dQ0Q3hma3Y?=
 =?us-ascii?Q?XlhfABnHFHkNlOR6AWEJKo7GoWS+77HbUBvnGaKTzCVd9AapKxb45BeWP76g?=
 =?us-ascii?Q?eOCGTewHI+ZV1U3EyGA6PwnkIOUiRnf6/SThxO2nayPbCn5eFnZQcIgvXLTj?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ngJORS7+T70paoLMSHQcvct7QxRTQ9xYY3pOEPJUmtVqTVlobATMQhAHUdugReN49mZ0Q5rpCKfI/qbzx2nYwde56Cut1NOvg9s49k+spHxl84CaNEsvYyfroJth2vMt5gZ/bv0OH9qcK+WkyvZTRdARDOFHfhVv8AVVMyn9ugtdim33gyhfCS97Qot5eKCHnYJwLFNydyHjmu7+dud+x7YD9OCJNYk/Q2OgZvGFk73+iDqftyJy5M1WdLlnaei2m04iHoYgFih9QUhDqE5qBC4umlzGd/wA9V5X3Z9XWKCqwTunbzB3GqUIBHqOr+W7iQUEn8kffk4zeu11bN87gBGktiMuR70/KHtEYujvm4YhovgphtfZXUWW75PxmR4Fcbj2xzjexsfMzUxaq8Uk8fl+nUgYmqxDFP/ezjR+ITq+CSzWUhyrXrW9khJKP6f8O2QUKqMK6o6u0B594SfN/bj5JkIOhnWL6bKCb90Ue6AaS0Owp5FPlkbPO9NqpWdSPEQ7atr/vBscj1t9lsRHouOqanUXhmW2k1G2cV4Dd8h5aCwocus0XflDee75jXw8MFGZMvxIt31wFgPvzb5I/noZLADqrOa3E3LOrDqQmOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb249abc-6f7a-4e48-5be2-08de3b9557d5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:34.3869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RCipzBa1YCuR1Yv6dlYVgRCLdI9glxch1SNgoQHcl6KLg/HoTaG3ugBxic/EWv/FfTmSbI7Lhd4tPzBnCAyF/5n2xn715T4GQ11R2brPgAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-ORIG-GUID: hX4GY5ugWzOEGKZeJnMv0g_JL8ja_lvx
X-Proofpoint-GUID: hX4GY5ugWzOEGKZeJnMv0g_JL8ja_lvx
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=693f9362 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=9GcLsRiznYava-zPbe0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX8igSTWLnyzlR
 VPozkWOdbD3V5Mkor8a+XX278jLqiWozXH71Nkjs7IBDlYBjxII0Ek98TJ1csfLgY1CkwMxXsSF
 LLeWUTUn/nEgZLavqyiU3GVPtn5JCAgTD85yC3DwjAwAynOSn7rnZaOV4mwrESEkVLoeIjQoeBJ
 SgCXRa7M2gjGp4MsZdRKVXvoFoA4KRCJTkJ4Mz8JhRpgJ6PX3Elope6YXgd+QxX0REGUCi3x88w
 ogkq1uG+VzU0pQvxcDuH6HpTiZtKDHzf60nkt6lCyoW0F50E0wGDdzhbMCr8O38752N14ObuuL7
 olE1fmeO/vU7tkbpJV/wYhAZGs4yu+9Fq5dCua2gXaf8T8P12cp9sUVTaJSZlAzK0ZGzp+ieBZs
 F7i61D/yGQ9gMBDM5t2/a3HgBHjR8Q==

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with additional LOAD->LOAD ordering.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index e25592f9fcbf..d05d34bece0d 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -331,6 +331,32 @@ __done:								\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr_ns: monotonic expression that evaluates to time in ns or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					     time_expr_ns,		\
+					     timeout_ns);		\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1


