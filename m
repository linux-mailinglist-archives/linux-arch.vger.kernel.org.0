Return-Path: <linux-arch+bounces-11780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCDAA6D04
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701BA4A5EF7
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B0F22CBD9;
	Fri,  2 May 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tl24La3C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GjdzjRjf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522522AE7A;
	Fri,  2 May 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175976; cv=fail; b=MOxp4bmMKxytRkNfXkPiSrrpSdcDJ8fpaGkF+9E5zU0hL/D3qB64PT4VwECKN4wACeUBlgX/DX7QAyX12AM8uJPvlvyHdh6AvlsHlJC1z0YDxOPleAdGqmBpxUoxgRcX+CC/Q3jo2EaNDD0Bx9bzaynF+Z9ebIC5W9JIvk7ZGfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175976; c=relaxed/simple;
	bh=KkU396mXD/Dq9jKPODBxIk8YnBZVgEyYzsHx2FnXTGs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=L2/mptSrUozgHL3xrbYzHK2eXwlZVh94A3VRh1s0+earjffGfFb7amBJAKdKPTx5YQnf0U8fahKjBkqGlFC9usjqhWrNycZle2AP5A0tCeBnyWDMF92FZlP2VaJ0HTOykdfAQ35BoDVZY4Vbmdt3pu1/uknSU5xv1pgZ2UrtKpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tl24La3C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GjdzjRjf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425Wdm8023421;
	Fri, 2 May 2025 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=FqjsSzPOe7Eao5t5
	td/gPcX8njKFRAfGLGGDSSn8u4M=; b=Tl24La3C0b08gjj87mhP3dk3u3s4YLR6
	KH2sMlsl16s9fQbQGMBb6ZGQ16HsDwhEXQ2zOknDIXR4G1/FgV2NRHnA/u0uCXQ2
	VYICYcD7jHi71CepiF0L2SV+syfyxRce5p6SO8ATK84tiXoDHPxjW9CPA5Q2x1IR
	XwVaNGn/xSVitOemzlADLw84NSrx1bVIyTjWw1RKd/jbJqEnfqK2wUzdVCU1OwNw
	6rLQPuEH+n1Xto8reHhqjm/jWpk9V+dbghCgAuPFayMUmMuiXJgbi9/6QKXlTpm1
	3rGXlIpNc9+1KBdGCBon8X71btrLMonhGRl3mmjox4RbRqjw02QDsw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6umcvhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5426aZSE033464;
	Fri, 2 May 2025 08:52:27 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdj4pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy0W2pWgybocs89LmHcRY39lPgF9p5YyVb9r83I195naQFor/BvOvIca1uGmZxQXhE1vnctxlGgIQ0peTZiMoX4SQRgZEx/JkzhghH6ZRmxVAsKw5sqMqshuWf6Mmx778/2NZ6INnze6hJDcVjokDMiUhFeo/gi+zVRdoPf3MW4rjBKscY6DqhcoHnmlE838Y+8T76tO2NxmBzwPgVEXLmPupqMHyBSjUnB8Ad5+S/mGb28TQOO2jCVlqG1/ptjMtGWWqQf9cwsVSpqiPEfU1cFqZjSLFl7vi+sHPM0HAD/2T0X04+HXTYCb5Cn23wU+DCjNKrzSft1AnYi0VIwGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqjsSzPOe7Eao5t5td/gPcX8njKFRAfGLGGDSSn8u4M=;
 b=m0WQIN6bjqR2hcgh/WNOmAmJfCiARk5/xNW3UcQP2PJiF7eEjrJpjMkNKWnDdbZMCXcCgh07gby+KFhji/QQgtsvji7hkZPR2pv89Lnoc6JVmsdjYCgudUl3MauuOJsBQ0eZxjPmvnEGJuVdXTk1sJhLknTocFlS6Ypp/f2wbqqMx2yXn7YEiSUHCpHGEABtmggThCE4PBfGxGHPoQ9ctxlzvYqvTU2sVH7PtaFImWB7aa7REZcSslGtAQxzAEcUwzN9ITOhGSOCJzxVHTKdejJw3Lr3i4pH+2IzU4QxKUoPjsJCI8l/uFngkjy7QMJaMblRRzmeNWlUDFmXR8OGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqjsSzPOe7Eao5t5td/gPcX8njKFRAfGLGGDSSn8u4M=;
 b=GjdzjRjf2rzf021VRwCRBw3jQ6LrxU9TDLC5/pABKwatO9NXGPnGLL5xwZGrLROYZZvG0+yxcZHB2XOT+wO0oXkgE/u2r+DIQUG6cCujNZK/9VuHSwetPYSrGhTbEYBZXFwEAGwbFyc1qvABF9KXAn6uJIcqVVPyBXkHp8j4qks=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 08:52:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:24 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 0/7] barrier: introduce smp_cond_load_*_timewait()
Date: Fri,  2 May 2025 01:52:16 -0700
Message-Id: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 278b8ad2-c981-47ad-ff64-08dd8956a84a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRL59qaeLPeRODvHKVHlyFusbctveM81ukJcz8h/0p2n7zqPQE8fOaPdPPRy?=
 =?us-ascii?Q?nZ3c5XWlTcgwJ30XEwUnUnsk4BBwScePhL+dcepIlYJG4jhjbn09VJCkON2P?=
 =?us-ascii?Q?MMsQOElyj0wFgz2RGswtfPE7BUnvyTdqT8VZJi/p89m5mujc3y5iALiwJ9U6?=
 =?us-ascii?Q?mbt9LXccLRjJjyshCLshDtKPaW1svSsqUtVi9dulw1dB1psnl/pYH5jC0aDK?=
 =?us-ascii?Q?163Bpu93AxnpwR6ed4QaDqDgfAtlAZFNGYWXSYgXn13wBVsEmxBVvHOWRJAw?=
 =?us-ascii?Q?d8TP8cB9u6SmE1guaQSR8XP43hAXYdBCIVtQ4Lf2SZC7CKHIQsZv0qC3gEw0?=
 =?us-ascii?Q?je02E0VLllZfWvSMUOaP/0fhifH8Ecg14FSN3VTTIdMl3wHynQiRR6ExV9QL?=
 =?us-ascii?Q?RPE9+0xROwdB5TbIBPPJGBxdPbXvju73oc7DtP76EiPvK+FhT2OShD2WZghr?=
 =?us-ascii?Q?5F0IEvDajF5C2how3fnduVzRSht9tW7xXzqduWqMuQROAWwbFyyfi/OjGB4H?=
 =?us-ascii?Q?pAbPtizPZaXXQePQbsvYUAwI8RmaWaMC8XEYdlgoomwnykfY61FJXxfF8eAK?=
 =?us-ascii?Q?9FUnrb7LnM7+vKrKMLiceHMuOXeLep/tbWYNYiOrdjDpOOqWjmprJSUJp7yj?=
 =?us-ascii?Q?S7uGUhFfJS2ke88XilbaEa7rorUuiW7RP1nQXPinvUjtp9eVvakrX12g4+u9?=
 =?us-ascii?Q?hkjbEIayN8rvv2JEbjn4NQ/EdHKRkldan02LvPc6lTltOq+DUN3Er34QBY8h?=
 =?us-ascii?Q?ORPLtJCwRJzDKRWHHzqlPpw8GSEwWEAu4I6oW6yXITtnHFR0Yr4K6JP7lzzt?=
 =?us-ascii?Q?WOI3Yzamu4ESlS/FoHIm+pX2754kq8e+KBgAyB3Iaa/lhWPV7Kw1DB2BSXbs?=
 =?us-ascii?Q?yz/4bsVDqK+FOGPJh1yuNcgEA2dsDp7hV3WtKT4xsUk31LxDTVWrCXpdmKni?=
 =?us-ascii?Q?Ua//tGweOC7ueU7kPPu/aRVxN3jrASIVrEkUTDmx0A80qNbIHOTj0/RwsTyM?=
 =?us-ascii?Q?343jOASuKxUpw7znyVbCISMhG8GcilK9J3pDbn3K50bR00UvLnv6UQzkhm/T?=
 =?us-ascii?Q?gmoMFvBdvOQBlBxgXSFxsgPjRC2pPJUDxJPO+qAh8d2xGqf3w2/xww4zetax?=
 =?us-ascii?Q?SL/lGpQOrb8gHNHUBzs3TFLNDDakNJhbkPlsMLAALVU61ANVeVSgpBs1JtIn?=
 =?us-ascii?Q?8xdWTKHv646BPGpJeqWGATf4LUSmHcu7PlbOMB+w7Ww6uq6BfJuSuhaR/QG2?=
 =?us-ascii?Q?a75phzhBhpQftLNJ2MRmzJBBG9Jo1THUDznXwajqYwnGZDhPTziSWukJLu5G?=
 =?us-ascii?Q?rBVlufNGmposym5PLedpcsYWrs1aYtglbBfH3goIW1kAwAkzFLr4sbtyR2PN?=
 =?us-ascii?Q?Adx1fVZmPeEBuWrHju9OJ+AMvCxkuPn3nEl4AUyBFtcoZ1isUek5ERCBDgXg?=
 =?us-ascii?Q?tqBLkGUiKbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zq1+PzKQKScnUIzJvFGbjtVmxYBKEhIgGvrOnbpHqsFCgVtxi9VxNjZmwkvr?=
 =?us-ascii?Q?WObSqTC/NcG5zOgbRTljnUubMgJotcGVpqSS81KlKU0tL9prtP1UmxlWQ39E?=
 =?us-ascii?Q?sjBEs/lOwGDgSwhFBxnRHRvXhL7UjrgCme6D+zxByk7R8obronFeshXfkA19?=
 =?us-ascii?Q?74hR0IZSt0H4ONg2aEXvvuqbUsZl8KNgxdRIh4JdNapxJtqV7HM2bAiho0FA?=
 =?us-ascii?Q?t1+cq9c1D04hTVkNWj59CiYcBj1h9X5pYMMQhcaiG2ISUhZoqxDJ78TDv0W3?=
 =?us-ascii?Q?UnwfNislxJ4KlqCE9Hk95cuBabHluWcAXzpEHnlm44KiADAU8zmdY88enhsr?=
 =?us-ascii?Q?6Rnh3A+hZ3c417LyhmA52pCC2u1ym9dG88AuMyGMnGYjdgMZ5WEKpWq0Scin?=
 =?us-ascii?Q?IJGNNGFYqtsgcNZ065BcWuCD1aw8UjxmKA/3xP9Gichp0E2Ke7zyIKLUAp7u?=
 =?us-ascii?Q?mY42Ocsf+wr2Cs8rNd9W4MMjUvOxypP5rQzUvF/pmbZAqy5OKGgQp16nu1lf?=
 =?us-ascii?Q?U7588HwHn5+IrJaqkPzxCwlLG343CzVKSO24tKHaGrD+zuVpgzgq/LdNpkBI?=
 =?us-ascii?Q?UAUy2VbbWy2YyTF2CsO+Rv9hV1vIfS98/lLZyoBTAvr5lWUDSr/148RsW8bN?=
 =?us-ascii?Q?rJ8w74w41sqsuXGhdZl9G4yoXhUp7sEy22kN206fcWY8bzOMjFGBm62zuYyF?=
 =?us-ascii?Q?4Q9hahINXfcLpHSIhkgj1cHkMxyO1x/fEc5v+B48V8y/XSJyjGrw+hzatTiQ?=
 =?us-ascii?Q?9m0paz7xWHjqOUlLErtT6G5whfExldVvm/K2JK1/Sz5ilFFHZZMtYI3pGqv2?=
 =?us-ascii?Q?Br1KG/CDuWAb/NDV+TehXMVIT7e5H/0fheJdhhS73JBQgC7l9K3UZcqL1o17?=
 =?us-ascii?Q?LUn+6Bsk2VIdhlLQgn1veRhcE6Rv4bvzspBqfQ9s6sCIYRojqgQ1yf6HN+OF?=
 =?us-ascii?Q?ienNOoIPEF2fNa4/JQDqjTfchn8MrBikxxe/FIhCOCHD3gRoWxf3dbvt0VIc?=
 =?us-ascii?Q?dUZYsNo//DrdQzCfPHMtM8KrFmmkGxLfifbidvTETJVDAExEXa5JMzgeq4BP?=
 =?us-ascii?Q?JXTAWfnsgPOe/7tpSJvzdlq3xf7ynxC8J88KKcINmYanRWxw4RalL9UnRTtg?=
 =?us-ascii?Q?Om0n7FVwFnl9tK6CRawQuYd2oN1ziyugcnojhL9LbjFoMUpsAp4hQ6in1jCz?=
 =?us-ascii?Q?EtxKtF3Zq7N0qJ8udQJ+R/wJ0sK47YEOLYtVc+KmD80du44iTMv6YA5w+WJS?=
 =?us-ascii?Q?VENCiZL/tijhWbfGpOT1rr3T4pMC3C8G8Urs+6d97LX/qROFR0pEUUWBaBkH?=
 =?us-ascii?Q?wfs7O3B3rUGpO6xJqeKEX4yCpsa+imLD96LotdtmDoDfZV6iNtwsRwncRzuL?=
 =?us-ascii?Q?QabkcZ8mliFjEwWO0ZmURfrSovlz1tL9fUrSpd56kdPUcWPcktcN9aLT5yZ7?=
 =?us-ascii?Q?PBXaDPuFC/+xNS+bTU7ycZ9xXEI/LWy5K0iVdeISt/Fr7bf+2uBqe34Hmt1I?=
 =?us-ascii?Q?SD/h5o7edfpUSHicuOCmU07LXGjgP7PXHSuBOAWX67z1AEVsySFnV1ZuucND?=
 =?us-ascii?Q?lVaEvDUqtJuqASEpZ43hmUdxnJWDY1TVmr462ZjVGr9hfYPEY2cv0HcmxdKV?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BDg59SPpMeTcFCZffNouwB6p2BTosk31A5uwclDHlROkR1mQncQKc34wzKQvI3M3hCjb4peMKJRt+jmJYp0EFFtMoNlcx2fltauBYMOAeKWgU1UaL1NveY/TPOxECqTevLqwDnkDdKhmd3GL+c/zlgLikwQU6cBDYtIH3vdSaDdZVdTh/ebzCql1jPgZWzzHRgDJY3IrHYw5ETOP1IJzg31ZEFiUig29aEgb9D2dzpPbUh00mOYW7ll3P7ilS1fYCkiDyl4NEDUvSBLfEg3lTYeB/TT+d+Y1OXxHf3YZtnppeftqZIqqcq/Uso9djhPDlBGJS3HhQzWSi9mG/qxd1wN+tfGJ8ExYE93s8kx9zWVeq8t5KpV5BvtfsyUeHhaX80Ci0YzKSyf9/AKuez+xjDNgQX0coXbQNITG+3nAjaVauLvuYnatDKm0tpxhQ/+BmwFyfywEqDyBrSYmASCzZbCOtJDAYXPK5st65mKJU1E+vSLf2KoafcwPGGOK+ojjmojLxE3p4D2o6r0zJP8rnyOZYQyml5QFXDRsN8wbR6ijOZjI2bYV1q27NcVc9xq9/kqVzkgf8CVGhNCvrFy8OMpYlrJhGBbErfDKKJGq1VY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278b8ad2-c981-47ad-ff64-08dd8956a84a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:24.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qnCCMDntKfEgwuE0LnqahMzzVkmRgG76U4qQL3jJeUq/uKx4FFfFouKoQP33sDwELkTc1qLzT6ij6sMRU5vreB61TpNLsL2HOhnFdKXunQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020068
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=681487cc cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=Nf7RAVy6C_e17fuR2qQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: EOc64GGtt22q7EVZfD6c8hmaL58ZVO4H
X-Proofpoint-ORIG-GUID: EOc64GGtt22q7EVZfD6c8hmaL58ZVO4H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfXwQEM8/6uh+++ 2+1RNa479m8ZQ0xZUd0LnV5xh6wT4ICntyH0fzSwBRvSJn01ng8og3a+QubipS1tnLWK1rhSpwf 2Qq9zv+XVlkSWQkOGzXyXL1h7zESc5iCQohLS8fDaMoYmtAypNd6+xXD5crqT57P3N8TSb+joHB
 jQWhge1PhFpHSNIk3ukoBEYw1JjnzrE/FRMM1EnS3SkHV3sF8e7jx5ok0krgQzHJafTFWQJ7S1o xcJm9I4bz7Ia/68VAUh6EvvR01FM2xyC5FNJn/IhWvowhP7+8LC87ocRXow+z97f//qAGtBfV5c CuL4OK8muplXHshY6DzwaJpF2Z1VSGihENq1S/oJ7XQe1c86CvaVXPjwUcDBolZcrpS7NQ1qc/I
 6DC+GdCSenANPxjTWzaJdjWCJ9XRPRB2KaZO3G2Q8Rrcvi1CJgaI9VJmZAsePiscvH8MOQCc

Hi,

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().

There are two known users for these interfaces:

 - poll_idle() [1]
 - resilient queued spinlocks [2]

For both of these cases we want to wait on a condition but also want
to terminate the wait based on a timeout.

Before describing how v2 implements these interfaces, let me recap the
problems in v1 (Catalin outlined most of these in [3]):

smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns, time_limit_ns)
took four arguments, with ptr and cond_expr doing the usual smp_cond_load()
things and time_expr_ns and time_limit_ns being used to decide the
terminating condition.

There were some problems in the timekeeping:

1. How often do we do the (relatively expensive) time-check?

   The choice made was once very 200 spin-wait iterations, with each
   iteration trying to idle the pipeline by executing cpu_relax().

   The choice of 200 was, of course, arbitrary and somewhat meaningless
   across architectures. On recent x86, cpu_relax()/PAUSE takes ~20-30
   cycles, but on (non-SMT) arm64 cpu_relax()/YIELD is effectively
   just a NOP.

   Even if each architecture had its own limit, this will also vary
   across microarchitectures.

2. On arm64, which can do better than just cpu_relax(), for instance,
   by waiting for a store on an address (WFE), the implementation
   exclusively used WFE, with the spin-wait only used as a fallback
   for when the event-stream was disabled.

   One problem with this was that the worst case timeout overshoot
   with WFE is ARCH_TIMER_EVT_STREAM_PERIOD_US (100us) and so there's
   a vast gulf between that and a potentially much smaller granularity
   with the spin-wait versions. In addition the interface provided
   no way for the caller to specify or limit the oveshoot.

Non-timekeeping issues:

3. The interface was useful for poll_idle() like users but was not
   usable if the caller needed to do any work. For instance,
   rqspinlock uses it thus:

     smp_cond_load_acquire_timewait(v, c, 0, 1)

   Here the time-check always evaluates to false and all of the logic
   (ex. deadlock checking) is folded into the conditional.


With that foundation, the new interface is:

   smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,
					 time_expr, time_end)

The added parameter, wait_policy provides a mechanism for the caller
to apportion time spent spinning or, where supported, in a wait.
This is somewhat inspired from the queue_poll() mechanism used
with smp_cond_load() in arm-smmu-v3 [4].

It addresses (1) by deciding the time-check granularity based on a
time interval instead of spinning for a fixed number of iterations.

(2) is addressed by the wait_policy allowing for different slack
values. The implemented versions of wait_policy allow for a coarse
or a fine grained slack. A user defined wait_policy could choose
its own wait parameter. This would also address (3).


With that, patches 1-5, add the generic and arm64 logic:

  "asm-generic: barrier: add smp_cond_load_relaxed_timewait()",
  "asm-generic: barrier: add wait_policy handlers"

  "arm64: barrier: enable waiting in smp_cond_load_relaxed_timewait()"
  "arm64: barrier: add coarse wait for smp_cond_load_relaxed_timewait()"
  "arm64: barrier: add fine wait for smp_cond_load_relaxed_timewait()".

And, patch 6, adds the acquire variant:

  "asm-generic: barrier: add smp_cond_load_acquire_timewait()"

And, finally patch 7 lays out how this could be used for rqspinlock:

  "bpf: rqspinlock: add rqspinlock policy handler for arm64".

Any comments appreciated!

Ankur


[1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
[2] Uses the smp_cond_load_acquire_timewait() from v1
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/rqspinlock.h
[3] https://lore.kernel.org/lkml/Z8dRalfxYcJIcLGj@arm.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c#n223


Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org


Ankur Arora (7):
  asm-generic: barrier: add smp_cond_load_relaxed_timewait()
  asm-generic: barrier: add wait_policy handlers
  arm64: barrier: enable waiting in smp_cond_load_relaxed_timewait()
  arm64: barrier: add coarse wait for smp_cond_load_relaxed_timewait()
  arm64: barrier: add fine wait for smp_cond_load_relaxed_timewait()
  asm-generic: barrier: add smp_cond_load_acquire_timewait()
  bpf: rqspinlock: add rqspinlock policy handler for arm64

 arch/arm64/include/asm/barrier.h    |  82 +++++++++++++++
 arch/arm64/include/asm/rqspinlock.h |  96 ++++--------------
 include/asm-generic/barrier.h       | 150 ++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+), 77 deletions(-)

-- 
2.43.5


