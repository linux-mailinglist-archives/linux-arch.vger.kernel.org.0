Return-Path: <linux-arch+bounces-15400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B02CBC808
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 619E03009601
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19F32D1303;
	Mon, 15 Dec 2025 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vli7RMsi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tScf/vU5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390B1FC7FB;
	Mon, 15 Dec 2025 04:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774298; cv=fail; b=kt/8VNcVBb3ChMo/TPRjsQpl+6jdxWkp8E14QeZ83KAulx1BtX8duwvir3ODod90oeefdpeCIo9LExt9htp6JeD23rjUgJzUFlbz/9zOQWMXvo9bHa5fOkcsiYBbSzzPgDAL+cEMFgS+zE771aZ7rNZUl5FOZMcKgs3oOjjloRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774298; c=relaxed/simple;
	bh=P3pDUL1vQkxLKY5l0z+RTF2f5jov345HsU9Fe7HKko0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DEWfFVfJ2K1XR+gliNSqe82z9tkK7/xxrk9hAVh5fwX+YB0pfwsoXi/34JLHTKkWdbIG5C+bkx5q33KxaY4MAJzWKmXEnd8rwzSWSc5PkVYLt9ljCDQmYbcTQ24us2Pnfj0lxqIBTNjrHmWSW6ILuXaXwLlvzpJCoRolit+MJUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vli7RMsi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tScf/vU5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BENaRWh854623;
	Mon, 15 Dec 2025 04:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BJ2Rx/wGKMs2vYf/SECHZEboqgW34Qxa5Ds0sC94+BE=; b=
	Vli7RMsiF7auxfJuL+lst/ACvKhLQDTCywmiP46zaG1SRpnDQMg/dff2XK6f2BSc
	GF7DBCB+e9sFl0RnzxRxej5guMkHBjPFcg1IVZ+5g8ivMbx8XPbWvIGoVC7yLA+6
	0jXFEq2q4LyQ8qjAuoGEQKCGtlmtErDGdM53/XkgrFHawNykWt1VhHd7NYUVx6LF
	1kHnvIkYLm1fKCEaLGwxOJK8XxyKfGmWK3ig3Vo2XhpU6Qv7fXxwiGq8lbSOm9Vh
	ZSwt/eWNRtEjNe4m6HjMXTcx9+WWO4xHiypnddoxP6VtLZ2CPj2/mlvlXP6QzWtu
	8RDMg7NM1D/AtUC9wGfYbw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja1b65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF39vXC024791;
	Mon, 15 Dec 2025 04:49:46 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8g0f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnzulQ3WOFetPjcFNLBEKpA/tVvtS7Wq4ieCQxXpe4+tf/cbBl4a1FND2VPrOkufi3Dpi9gCsgh7Nl1d4q9NZa0mXMifRbKTdx8ZldlTfHPkInsOUxC95iQO3+devJfDYZHXrRIHsXcbZUDn/gsDWj4MsGjMBVt/dSG8b0ojvBxQb4bwT8Y3vR+4YYFrspdA3OI3oYA7QWyXohHn4yaYPuNPDhMEESfTGa4uRU3vYJJ5QLT+Mns6oq/UfETnnfxWBm2jCv1Ki0LmmqyAX+Ek5w4TYC2PyqKBKUESu7rUok/XWv9a+BMFcYU8Z4XD3AVzjV/eInBcp7ygfqme2/pbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJ2Rx/wGKMs2vYf/SECHZEboqgW34Qxa5Ds0sC94+BE=;
 b=IGN/Xb9VwrBJw/mJ6RK2Ty80eamyUSZrzM3wmc4sC2XQHJeHlVnMUi24Br8F0yYd3JI311CpnOv/izNCX1XkkV5/b/CpQE14um2dxkzkpAGaKi8d05ilTQ6YeEz7BOO88BA6L1ZYh1I6ByYk65QF2Hy9OU0Z20Dip5AIA/sqbTtYzPD6nlo4HCMfj5o2FgjSBXmOOh++Mt4B00ypqHAhpvphVCAJV892WJ2MWcFfqFOJ4L39w1To7jO+KG3xbxNNyuGh21nW5mIcdog1ITpRTxgOeh2KAXZZqTGayX4D2WODeTUzOBI9tlBeWNpFLZdajcrdwqarpHrudr/+srRCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJ2Rx/wGKMs2vYf/SECHZEboqgW34Qxa5Ds0sC94+BE=;
 b=tScf/vU5jjvrHwR6yz/fmaH4L7CckWoKRUcwa8E5kNrVeueXNRo4eK/NecntL766B0HOqxTvhYU3+Tb5t1zh6/4UBv7uWPGiFvPn/s6PRLCqfu7mkNA/ojE4+PgWoB40evR2D2XZ0pKsJ4nfnRCFJAj28s3fHs3nw5VJFOxQnPE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:43 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:43 +0000
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
Subject: [PATCH v8 10/12] bpf/rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Sun, 14 Dec 2025 20:49:17 -0800
Message-Id: <20251215044919.460086-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:303:16d::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eef9341-4141-4737-9de1-08de3b955d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WatjxnJ+T8pGqG4x23HW/xedFuqKimdCDYDrwAepE4/qTw26qnYYw5ONWcjW?=
 =?us-ascii?Q?CxD4m5AxTSIzxjKhEW8Uc9y0uvElCzM86/xhyufqecspzlNEAQaFzgs+zztp?=
 =?us-ascii?Q?WrcWDCy7d9OKaMKFra/ZpSEOOhq1SctLc3Dfac1s8r7W8lsfr2OhZGuMLgOu?=
 =?us-ascii?Q?2fKGKpqzACszHvUR5TOzA/zZgUvrhipT2YKoJUQvm4e3lYKnB/KFWzgsQXZd?=
 =?us-ascii?Q?D6zmJU0GTmSH1TOOVBUeGKd1QsD0cKP3kcmrmDLbY9kSJIU+U7YuapUIl4xR?=
 =?us-ascii?Q?8ALSp3lBifr/kg1DxXnIR1WkA7tKRBcvZfueFTkzHcxVx+sIYquhVvWEewQp?=
 =?us-ascii?Q?b7YUokvA9gov2IVuG0CC7lk28eP0S5RHtnvqf11+IF60P5RZdeWhOPq6FRAg?=
 =?us-ascii?Q?KUg2nfzpRfnaRbyyox17XgvTwdGrtr2l8pj+Wmy8M3L7vo4XlFlgsw4+MO0M?=
 =?us-ascii?Q?umu/bigsnPOZmTDLluCWDAV+TPuqFFn9mdqwFKzH+7QJqFHYhBIZ1iZptTrz?=
 =?us-ascii?Q?9/wf5Nov7bKfp11fHbT2W2EMAapOdcOmNVgmpe2iG5cC6/ZVX6zdr8E8m3BQ?=
 =?us-ascii?Q?5m91vBixgpIrp/pC65vILQ3m6UTVjgeB3ZSMmRnp7HhhMCA6/eDuFgl7IGqp?=
 =?us-ascii?Q?9TcBDyAW/5tIBtpfPXql4NIugKxTqPyJB1jlMS+Vw/QYsKT9EbMxNDUwoN4e?=
 =?us-ascii?Q?HEYPhwoZHJPh6G4FP1H4QTS/miVf/PSyM0s9lbgLtgxttr4H5jGQ+xOSkPXx?=
 =?us-ascii?Q?Pv4jEpyjuFhwwEhm4X4+Bdr6sDomzhvTD8B3WPZpoXDVeSogBdQZDRGpVaz7?=
 =?us-ascii?Q?eRW3H1Qbi4P0NX+nGOufgfuWI7Lx7H7m5QhZ/thV803xfIbnWrn+yCw7k9iF?=
 =?us-ascii?Q?94I/8WroiXtPazmrEOZxkmWdZMgyuEd4KgZlbGtn7mfh+CPBAIvk/FdysiSJ?=
 =?us-ascii?Q?6m9waAKsf//uW+x2BIQraxgj6Ckoo1p52NnbwctOtRCNTw8izKn+kQ9hs71V?=
 =?us-ascii?Q?z9yzgAeUuDw7Nuz5YDDkWWaJcOiNTnKZJ7gePuTzS4wjB806/FmLM36cmkLp?=
 =?us-ascii?Q?INeggyh6OsKMs/SqcSsjsTpCLGtoUNZof9ogFF83u+wXpOEkqA9NrkfUlqlV?=
 =?us-ascii?Q?Q5OgYd/HdQM98Bu2YPTMQyilF2NJiJOYNVWhECfR/+pSUfsRhfqYQXzK/14g?=
 =?us-ascii?Q?WlrkGKKIZUGFJoKmvC0H5LgX4KMNnIN99eC42u2tTuJBgjnLDlg8xv+BWI+c?=
 =?us-ascii?Q?d5OIen5yth6ksWUYIlOvR31VsCPf5CwXJtBqMmMp1H0mKOoFa45DTtk2uSLd?=
 =?us-ascii?Q?VNXr6/IuVaMa/DMINABDvEST23pgCs4HzZOY4iYayMnRk6q0AxowSBOvw/bt?=
 =?us-ascii?Q?ibyWrjTnbBls9FZNUNE1k4p1of8IB0B9ftBcvHk7hoVowlgblKQHkPJoICKE?=
 =?us-ascii?Q?R78aethYcNcKNpdbbfW3/OxjtO73+iwg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?64Q2wkoNYOHqLnWyBCkNKwMC4F9EoQliuvShktj07FerKT0iOTzliBrsMdTC?=
 =?us-ascii?Q?Zag7QIkOJ6h2KptMzzjwCP19YKpd7xXBAJQrDlHhbQdY+01slb8unJf/00ls?=
 =?us-ascii?Q?JaBjdG2v3pqPvB2c/yjfdKd1jtcykN0q2OR7RZ2gRjJyBy/qRRaK11FXlS0I?=
 =?us-ascii?Q?AmwIPLjcLm1abFxOQbhPo/urOsrqz4PynAd05osu/GOYtaQjsvzPQsvOW4K9?=
 =?us-ascii?Q?/oTXNUs4B4czldMtnl14+0zZVu0kmUXk2/se94GYhiGL2kqrnsnoSFqEULkX?=
 =?us-ascii?Q?c16RB+lV6Ve4MJG9cVKc+5q9+rbvzNJdyWy4rLhCnE+kywqB3a4crU+EW7mv?=
 =?us-ascii?Q?K4ubOHvPu2Nh5YiYMR5GaGtkI1Dr6VvavALdCqp5Am5JaAd7UdCIm8hQPZkJ?=
 =?us-ascii?Q?uWDK1LYLilXa4B9EMwtDjto+9n70pUsTwY74pvbH6ywLYthiHpfHuo5pWTwB?=
 =?us-ascii?Q?YUfI41nT6tCjTjv6aZfmQ5ThusxGdqGQSLjX1M4AazprBp7AC5xpU/hvjyoi?=
 =?us-ascii?Q?KLMLLljRMnHR24ieEmO22cPf7ggKFETJ00MZdinJil/5ywAAtLpZQlL1+KfK?=
 =?us-ascii?Q?jtQ29XCa/ecMqOAOKdOUIc5AP8hFYKfTt6N8aqHXFq4O+z55dqYEinxmwBJK?=
 =?us-ascii?Q?RlL2RKoMe7v0X/54KaAiMIZ/EBGiaL6YMnplAQkTM/zIc2jehRsIahhPCh6G?=
 =?us-ascii?Q?0SsH3LQm5aI5oAstyhwvG3jK5D44M7ImD5qlHidgKUu79FIztvOpy+d+3Q1q?=
 =?us-ascii?Q?8d6YnRzJHhj/5efcenCxOl6dzEGG/1DqllqjWUzESQVlUVrI46pJhvDgyt4x?=
 =?us-ascii?Q?/Un6DYkieyas2dd5GqPGMGGiCS0NcaNnjCVFFw90iQXosRWzFhwPjmSvhpn1?=
 =?us-ascii?Q?b2/71ddbrQWeyH1Zt/a6Jco1r0VtawHfrcpNAPx3kXRPLrs68ZovlNhYR5ub?=
 =?us-ascii?Q?yWc8ZyoHhvtWTlwOXAPCxED2MwlLt2xbgYIcpn8Q93EXo1mv4DxSzC6Fwsk0?=
 =?us-ascii?Q?Xwr/ZCz0t2ISqKsWiteCc/FU2ppuku3hrNi2qhrpLHYaKFlVB/vj1MUObdce?=
 =?us-ascii?Q?/SybIYXl//fibRDAf8u83N87TlOnW8ZthwlP9tA175fm/el3FZ6Cn+VJCTWH?=
 =?us-ascii?Q?/nJybcDf35CI13XRY9U7WGJAh/ZCy716Z5sLtjSdEzsBF6ZlPTc9w66CQ/4E?=
 =?us-ascii?Q?L/uJiDC0b4uRWM5Z96+pwKXnBtIapANocmCMfaj8potJg/xSMqzU63zeblaL?=
 =?us-ascii?Q?KvkuyUMpUybHWnVBdc6AWkCnbHkUV1dgBLBVfagmCTSbZk30nWmEi9vt9yEm?=
 =?us-ascii?Q?5M/zP0K0k2puwRanvKDvIVLKhOI/C//cWp8gukp1krGqzt+vu27rgUjKUrE5?=
 =?us-ascii?Q?yTae4yIp/2+LN0u9cuNSXvqYSH/G2ClpysTzaHRSui4/MxcqIMqhTxKQ81ZZ?=
 =?us-ascii?Q?cDH6/TuRfzhoCabh16gQPKrCRY6tMIiq6iVSkt1YTnSRJzjjvAW+x+AT61Yi?=
 =?us-ascii?Q?iFf+SjH/DKmfgGevp+0VaSyj/vfoOPC28DfgqYnqyOz2W2mz2uD9g9J5Vt3/?=
 =?us-ascii?Q?aPmdhC8a0xk9fKOTQzFPXcifxx186vfQ3Q5HGJ28fCYd/bOGBmMWCAQL4Lu8?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u7XnicU7Wf/xRSLq30o/JHlFA7MtukcLrjC7AM6PHuKgOWAt1KW+XkqyKisLkMhaR+igM8qmovhXn2q8fw7uSDEYHrGPn0LSLk6xraD0X73aurWJLOEwTuGjLr/uKsh1S6H3nAPCBmBX3fGuXnzoDu0e2X6YEHq+7ZgbmmNBcYUR+t+IYozuUjWmXpqHnkYhXHh9QGe/o0P5AMdyLP6hsWihVKiIJVj16Na5LCQ8vVIZ3aZMELRRRYENtscUCwOS5uiWwyRIpSnlduyqU0+LGdCKup/0PGy6QbAnThReIDdRtLTy6VMWDeWWb5cgrdB4vsaHbkcaGzLmWgbvAZt4anaVQaXNlwfov5BzOMrDxNahp6N0c0zL5iC168d0V2eEbE0MHF8ZxeMcUAmYUSumbo/ThoJrqUo6oneF0Z09bPpbCRH6kRSup0d8ofhHVup6YRUxZ85Weov8Nl8vN5vqag33GUPFs+9mnXU3FmahM/a9h9/KN3Bl/cLV47ESaTHzF4k+LloC1q6rNxM7qTZNjDxij50OwAkg4XMd4xsqyP0w1wfnV9JgkdlO8pH8QJGp4LaAowgQTPRPZy/TseNWwZYqRfQak3z/n9u6X7KJcnI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eef9341-4141-4737-9de1-08de3b955d60
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:43.7872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVDNcSNDI6tyRs+QBWf6O9cV6O+S/t7BsyaLaoUkp3HnEDC+vDnyaqmxH/sk7OhKGpC5dIH32muPqdMmS/qMXbuy/66OXg/+lNn0bxbD+7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=693f936b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=rUJF80uJHZDRKD-Yun0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX91dZ9tMlIcl2
 yPbH7za60xxDIkhh5jAxSvZ4nSfC5MavrbLAbwK+OyYhSnsgjsasMl1ESbcNwBVNM3Yd6Ue2oar
 pIYv5W80NAxtY3e7ipQVrgvUdrkQk8bCV/INcYW+Cc8kFCL+iWzcTjUvERoS8j8btaoNKUKG8L0
 cYxxIFxhwIUseyfBn0D+8YXwcffW5XldFHFfewb3yIm0UnTgujerMo9BbPk5XKA1/05u0H5nLRr
 gsHFm47smbGfasIR+DdJ15GwDjeoQ6fDJmER+JcwF2KYtiPG/s8mgFYSyoxpi1Ye0GnoS4E648E
 VDE2Kk0JzBs/P8cRARIkvs4JajOZxsR+oGE+Q2CudM/XI04DWO97UuF+zaFs9EMQyxPwuSxg4VJ
 MWqOz+DTMYKHQAsxyoqgyGZs86wCNg==
X-Proofpoint-ORIG-GUID: kyhyQeDTyJ7_5JAcA3EdZQecNTnK2oOU
X-Proofpoint-GUID: kyhyQeDTyJ7_5JAcA3EdZQecNTnK2oOU

Switch out the conditional load interfaces used by rqspinlock
to smp_cond_read_acquire_timeout() and its wrapper,
atomic_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use
clock_deadlock() directly instead of going through RES_CHECK_TIMEOUT().

For correctness, however, we need to ensure that the timeout case in
smp_cond_read_acquire_timeout() always agrees with that in
clock_deadlock(), which returns with -ETIMEDOUT.

For the most part, this is fine because smp_cond_load_acquire_timeout()
does not have an independent clock and does not do double reads from
clock_deadlock() which could cause its internal state to go out of
sync from that of clock_deadlock().

There is, however, an edge case where clock_deadlock() checks for:

        if (time > ts->timeout_end)
                return -ETIMEDOUT;

while smp_cond_load_acquire_timeout() checks for:

        __time_now = (time_expr_ns);
        if (__time_now <= 0 || __time_now >= __time_end) {
                VAL = READ_ONCE(*__PTR);
                break;
        }

This runs into a problem when (__time_now == __time_end) since
clock_deadlock() does not treat it as a timeout condition but
the second clause in the conditional above does.
So, add an equality check in clock_deadlock().

Finally, redefine SMP_TIMEOUT_POLL_COUNT to be 16k to be similar to the
spin-count used in RES_CHECK_TIMEOUT(). We only do this for non-arm64
as that uses a waiting implementation.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
Notes:
  - change the check in clock_deadlock()

 kernel/bpf/rqspinlock.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index ac9b3572e42f..2a361c4c7393 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -215,7 +215,7 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 	}
 
 	time = ktime_get_mono_fast_ns();
-	if (time > ts->timeout_end)
+	if (time >= ts->timeout_end)
 		return -ETIMEDOUT;
 
 	/*
@@ -235,20 +235,14 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Amortize timeout check for busy-wait loops.
  */
-#ifndef res_smp_cond_load_acquire
 #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
 	({                                                            \
 		if (!(ts).spin++)                                     \
 			(ret) = clock_deadlock((lock), (mask), &(ts));\
 		(ret);                                                \
 	})
-#else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = clock_deadlock((lock), (mask), &(ts)); })
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -262,6 +256,18 @@ static noinline s64 clock_deadlock(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often we invoke clock_deadlock() while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ *
+ * (ARM64 generally uses a waited implementation so we use the default
+ * value there.)
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -312,12 +318,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -415,7 +415,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_MASK) < 0);
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      (timeout_err = clock_deadlock(lock, _Q_LOCKED_MASK, &ts)),
+					      ts.duration);
 	}
 
 	if (timeout_err < 0) {
@@ -577,8 +579,9 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, timeout_err, _Q_LOCKED_PENDING_MASK) < 0);
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       (timeout_err = clock_deadlock(lock, _Q_LOCKED_PENDING_MASK, &ts)),
+					       ts.duration);
 
 	/* Disable queue destruction when we detect deadlocks. */
 	if (timeout_err == -EDEADLK) {
-- 
2.31.1


