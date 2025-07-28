Return-Path: <linux-arch+bounces-12978-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72DB14259
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 21:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396BB3BEFFF
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 19:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CF3277030;
	Mon, 28 Jul 2025 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AhEX3GYM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IVHkpjdI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAD9130A54;
	Mon, 28 Jul 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753729449; cv=fail; b=eXo2TMpw63dDLXfQFGbPvZihTEIPxQHqf3bkrBN6FeFqirpbX96G72ZRmXNTcJ827IuJfYGkUqzzzGZg3Y/9/osMG05NLtMDGEyl96SZIKfvqZXgceW4pGEmN2kLvgPMEx1ruM9enOaD3Qq0AhBizrTcheyvB5wFpaBNsk9ZARs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753729449; c=relaxed/simple;
	bh=cYFybCgBtPpfcwgJe0tvkpY1Gda9HpcAgYHDvWNoy9A=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Vs/TmnEGgmtZIpPLkHWZx0CVDYXXDvpH4vEPWcLBgVDDRZFOAfrv/MMQn+XjBIxqRO0YPO7cSmDJkRywXgFpYe4lpGcj1xqSh35OBnO6onBSfg9rCXF6LX5qRvMrGILzt+qPHE9H78p5IWE/I8OhCvXGVFxLl+hv/WAzoDHpOIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AhEX3GYM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IVHkpjdI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SIlPht028741;
	Mon, 28 Jul 2025 19:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=fzGYO44Lqefdq1ZI0v
	IPgAEmNN20A++XRhY8a2vKIbI=; b=AhEX3GYMwCj9EVzYTx/VVBcCTOsHsIV/uB
	p05RglmPfHaeJwgjXL2IaPcAQISLa0ms/bB+MjSlUy33f6VKfMZ/NgO5+6JGMz7a
	1eLHFuBOiEjDuq7l/aDTY+W3X/AUAZPM3zDrIMINJ7KHq0u0hZBd7pDoloxSqEvh
	sRhErHKRytcMUq/Sv5oYv5stBci606Ru9OPNN9GiHeKZAu8p3RcUvZ3OB+1GPwg4
	8IwEOh7NSJKxL4PoN/DbZHsGiWj3ewf1NYpcJ5l7cayNFiQGYK2Z7co/e8sGuZ/U
	1wmuarlZiljcb64jrWPDqtYQxB3nYcKgIQCxd9D6PNXMPjw9b/XQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4ye1rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 19:03:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SHmFqa020947;
	Mon, 28 Jul 2025 19:03:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nff8px1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 19:03:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8GO5hL/2CKjoxnVc7aQjPH2trH2IvPi9dAbhyrHqxX+sPIAUyZOWhR8bDRk7VXnaqq31EbUJwGiITCQRMu+ravc5Yr//rzk0QAgMAkzaCP+VRSeNfNu+kLDy0BTQUeoPpNJDUA2QiP9sfzsZUdTL7Jn9KvAUWapZTuKOW17Rc4zvHubyAKwmXrY2NKSq12HKS0CbNhO+t7+tD07E63xhs/ExE87D67gzuGl4qFAMZChngu+Lj4R4Z8GbeSupsV1tWKOrx/YKe8L60kXptrsjLSroiul1u4pqJ+Ajyi9NyCuy06L7WysHojP6inl0CLD6DhKDgnfT8o0+F5hi9uX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzGYO44Lqefdq1ZI0vIPgAEmNN20A++XRhY8a2vKIbI=;
 b=I74tnOaTHbaApi+5oUV9y2+WmEafyfEzXNKtoxbwkzAwesRvkL1GPMLcbdCKFA4sHlO6sIq9Vzxx1uiQsQs2WZmlifdYv/GNtfqBTd4lMmpjRhMtiiTdOEfb3qAtxrSObX0WIjPwqqC4BZNfNl17nm7eLlALScprhW5tQCgJsQ9p1B6LQ9nNo8AnbhmPDCOIv1mXJdIR56N/cVcmDS1mkjyykSJpu6EgCk1j9FcazCo/wFEduk+GaFgIzt1rWI2QNvWiQRsXoWKF4ah6j2BIhgkRggPKhfeRlNJ/3x/PjXyrXcmzFGI6RSC0V6Izqu2uM1wxaJMzpuH87cfgypPitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzGYO44Lqefdq1ZI0vIPgAEmNN20A++XRhY8a2vKIbI=;
 b=IVHkpjdIW1mXKqLSosvwaf2Ankurn4CT2ArmuZdZJ52rmQcBH7FU8FXxmfh72hSgI9Etnmi+KJHomHTBR9o3Yfjk9HLbsoAeep7S0hk4xdL3BqgloRpEmrjZdx3sWawCcv29wnil1dmDsUp0foCBk/QqQj0NZLH6rBc5idDIzHQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7398.namprd10.prod.outlook.com (2603:10b6:8:135::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 19:03:03 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8943.024; Mon, 28 Jul 2025
 19:03:01 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v3 0/5] barrier: Add smp_cond_load_*_timewait()
In-reply-to: <20250627044805.945491-1-ankur.a.arora@oracle.com>
Date: Mon, 28 Jul 2025 12:03:00 -0700
Message-ID: <87wm7sdtp7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:303:b5::22) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7398:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a106fd-3263-4bab-3337-08ddce095fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GI4D3lgpvRZl/HQJh5r7JrqwiPzmKPSF4azQ4kOHTvlRfOIB8zAamAztchm8?=
 =?us-ascii?Q?ftoiIs/u5+vjA5tYVKIAYSQszkudw++POc28ty6b4sUC3wjuUcn08uY8AiAW?=
 =?us-ascii?Q?syNuHytYqwZP61vENMb2b8/M7APY6oMPcS1uWpn8vX8WsEUa30MkiNBKEPYM?=
 =?us-ascii?Q?OSVveezC7pI+5A/MyOjH3UnDOzkMxmXz/lkrcsqUE+RGMkFV0pNIrYDBYPHC?=
 =?us-ascii?Q?p68lSkJliDwYsQ8LNmUNIysW4Ah+poNVEKDj6uDAX8iTEZATVEq4/S3vidq3?=
 =?us-ascii?Q?6nIIOSLS8iuIrgpOVpBI/LZi2rzkMSHOzasaG3zpcPBNbINldZAnEKKJoDBU?=
 =?us-ascii?Q?Cmud2fmUAVeG0up0Z1Doku2kA3zdWANmbAdOudl+NkcadgiOpc0P0254WKrj?=
 =?us-ascii?Q?6ZJtK++4xtwaw8kd9PF9MmHbhUV7MDW8ocIjDBvX/ivSxgkAi8WBfCHeYgge?=
 =?us-ascii?Q?HRp40JuL2++xJQ9V1xFoDryUVwXhWgNYSWGTn0WwHGtYgaWO+hKP8LIZg5my?=
 =?us-ascii?Q?xxYRs/PuGEtFOWxxEyX8HlgTJnn6eq63IM4tnjYJhm8zrEPnldyzEKjF79uQ?=
 =?us-ascii?Q?q/eYuxNjRdsHpDeW9B0ZMGzog6LGp0ofuZiXF/uRtklPJgQGrq+Dn7vvkx9y?=
 =?us-ascii?Q?BLRS9Aq9JCCO9wP3DUTfC5nrdYMUrO9MESzp3f41tF0FTdxFxb4mupyugBtj?=
 =?us-ascii?Q?1SCalRxTZdAxNhXlSNcxAW66efrkKfs67tQy5XBGDxMHDYYf9JsruEZWmBru?=
 =?us-ascii?Q?/KmgwyQF4S1zpit4tmUZcOlZLkTZnvFYnjsEhBeAmkaSFUOghC8I0SnR4X4C?=
 =?us-ascii?Q?ToVqSCbk92+UWvTb8yiVZJJ1xV2B8e/pOAn805pzz9qDJdVKYX7Tj1ajIZG2?=
 =?us-ascii?Q?95hbcSc1gQlhkhcA3pAOq6H0qlgGYOZivHIJg9cdjdLI0AQYdcidFbLK9+ki?=
 =?us-ascii?Q?qqorjSN5uiNSL2BTsTe6u9H1sXq4/YFa97gSDAbZNV7c5BIjxdu39UlTPjXd?=
 =?us-ascii?Q?wCNOsUVH+J3Lp1HFt8XI+FSv7sZRcUK1HoU6HqjgP8IkFyePsX2p0mZErQif?=
 =?us-ascii?Q?Q6rzH05fH6pAhMDxDaksndjr6MJXeiOz0HSj1jqDumV00CJYbyaIJ3ZH7EL6?=
 =?us-ascii?Q?QcU4GdJt6I5SFU5N0I2O3Fm423ijR+mi6LtptV9gyGyw2FmrIhnve05EpaCQ?=
 =?us-ascii?Q?bnzBJMyt/girDlTJVCMEx0R3GkowMc4KWLS53A0bWvdC6PvI7aC96BzZDF+/?=
 =?us-ascii?Q?3JIY4IhztDJVSOvb7oQxuunNqUjt2uMoQ0qzULl27Ce5R8nj7KkZs1LHofd2?=
 =?us-ascii?Q?n+jNxfCe+W/KcbzgQJBD0kGtuxahgi8PpMQB3CVI0ydgVkTiuguh52lPGfbN?=
 =?us-ascii?Q?0yGSP3x+xCeOj3navjk4vR/k0ZSw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WF9OwTb/+/aP9LoX8h/+4F0P/rJQ5V6cohuDZ0tWfwe7v+USYg4oG/IOWqA3?=
 =?us-ascii?Q?QlhrrxvZnzXosQgOoyADUCbxn+KILXC5Q9zKUE3R26heBq+Yld8AgHW8fwR5?=
 =?us-ascii?Q?bmVmRZqevsS8cDw4jJ3e9OOTBeAbLL9k1gLhatyg8MWPKSRKJPlOXZ7xatJf?=
 =?us-ascii?Q?B1BiEDlbxgDJ3I1IHBWoJABEgb1/T1zK6zbPw1CnafCYV4caNaGbXmhdv++H?=
 =?us-ascii?Q?/dQ3ZwSiDnxvHAdjL1+p7bftFsbyeiYQWfpEyuh0P+DgLnzvsU0kauY6Mg6T?=
 =?us-ascii?Q?p7hWC6maNMj5ENuIBZighWO/bU3VssFt+qGkWuEO/TsC+J3eEJEMDeVsaNPQ?=
 =?us-ascii?Q?DAsulm2KW0fYu303oDSnk7ltLP6N/Fpg9pxbK+vXsPuvaMdor7FEgNOciTTn?=
 =?us-ascii?Q?HEp8Q+7xO/NP9SDuSBMMHMVvSOm+WenuB07W2cL6SMbSthxcZ6Mw1vxf+Uxx?=
 =?us-ascii?Q?S88/s5MUaWGKk/L/QRNCir1lgu953d8gvqdQpOix3mz1VMhjFxCs2im/AUgn?=
 =?us-ascii?Q?4zg5PHwxrft6Mdfsn6uhLNjkBoV9/aoRY6ww2iyVCW+3YP7MJr4mYrYuunGS?=
 =?us-ascii?Q?NAz2pxQowhRYJPAVcmjVlKnpie3yppxDWP3nSr6/glD5osvl86iyqn1OD3wk?=
 =?us-ascii?Q?N/uAHWGug4frwWczEfG/ftIhSsWYSTZkauH9I5ksMey93w0MGv6Am8UCgK6p?=
 =?us-ascii?Q?HLh5fTTEpY0GFEgJKe5qHk7ETdI0YZBk3BPLolCqnNXVqe6bvm0wSiEvhj4v?=
 =?us-ascii?Q?J8gUu9V8ioGNhLLGE/XZskGB7buPIJRY1lKuQ/KarM+Occ8H0iD4JOi6bgh1?=
 =?us-ascii?Q?eSyFVRtaFQoxLMFEG7fxVbJ391VuZ/auIHLlxsrYbI6eV3PLgnxcknqEcT8I?=
 =?us-ascii?Q?O/kVAr1cynfgnKC7lPlQh9CdEcuFAXap02pnlDPX4mNf1Blicuy40M7PESZ5?=
 =?us-ascii?Q?ywaOdpGewJXdammHUh1xzOG75pqHkOCqlZu7fwrgQzsq/ShAarnUVVInpN0T?=
 =?us-ascii?Q?MQMtlNE7tIzVushkALzmllKKLx/NIF87mfn7NKowQVkRWlkG7YLv96L7IPHY?=
 =?us-ascii?Q?l97ZzBSbJ0N0che4eT+hRG+KqFlZJLF4o48BOXYJpzDOOtjBDIfRRvGHTeGQ?=
 =?us-ascii?Q?c1SKiDR1myeYmksmRtq8/skIfD7oRMhYg8GLc4lnhK+OHWJP0d8y7nYhPLf2?=
 =?us-ascii?Q?EwK3CO5cn1VnM3Hvs+l0nTi6ohr+1wYVWCLEzeVaykR15eVUxLimzi45cuZY?=
 =?us-ascii?Q?IIPk5IZ9iYR3Yl/YOwduMKJ/0kk7PjxBNTU9CMt1zYpD0Lw/WGARJNVd6Uwb?=
 =?us-ascii?Q?Nf0ASwiV8+zFrBB01DNE58sJSrHDIS2rZN5DPfgbcNE2NZ1EfZ6yQxMeacAH?=
 =?us-ascii?Q?0xK11RxQl51qhUtOt1cNVQNNRA7HaKZ1335CxQdnLAFUWb1JxOR6NSeZqmR6?=
 =?us-ascii?Q?/B8FqIMQTgBcXbqv4q7Map+V4VP3+b8teZk/CcpGPUlTubtXASTykft9Tv2j?=
 =?us-ascii?Q?Dncbe5UTv+XYNCn+CttrTDs8ufLPvY9AJJC8501q3iL7dkiuWH8j8oN4qHDj?=
 =?us-ascii?Q?lR+ZDlL6xVpnbgsLp3KI9Sx2tu8xuT+iLbT3nyNaLET61mZaPt9vQrZrwWrX?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RDRKCDRn16McjBaOEZCkyVE1R+HzVGpPLtmJio5FKMkyQe6OGzXVegWcY96A7JVCC1p2x5K0nQBfxnHyYW3d/aw5ff2cc06hADLA5iv7ojqWD66J6fTBvJOYriL/REViLdfikn1F8VDy9UeaD6ot1f0Oj9lp+AcdC4x4e3OVBzOnDhCRvjhH7eynGq5kpcRtp+Pg+g84uglTUfzM2DQ7Rd1xkTeDAEfKN6kqBuWs18uIGCaYdDPUpRk+LTf8BKTErOFv8yRRWZNfUTHwtjdIdMWkRbZ1hXRs869oczTqtffWZkHx7yBWJPbj32ADBekXzf3euQRXZzcKmTszrF+hkGDhEOnJ8u5ICMNThPOT/ZuTYM5EbIfKeL49kyJAzi3M2TiRNWGY6y8NUZxHa//Q48oNNz/pEEOS/oLBDlpuss0PUTmKNcPgSmF+g8qS77AASV5ygg91EvmCOmKymfGiLMLHXe4EzwFJHtDxSHIp2yPdHWTzE81prprn4W4Jos44gf2YIQfa2WYw5mJxjj/oTmO3WRjrkUAT5quY/XuM6RFYVulzoPTbGRWZenA/C+BsBTqOyQxfMZLXPFD+SJbilDpPlsqqjaHK9ObRiW/GmGo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a106fd-3263-4bab-3337-08ddce095fdd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 19:03:01.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rlS1gb27xQijqzcGylKOLsDDl9Q+FLfxIAl/dcOeb00xO387QrwRBVIgGhJ6J0BpaNqZZszhGriEUfM/avoi45k3PoiN/9v39f85UsxLp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7398
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507280140
X-Proofpoint-GUID: jGGdoartAr9ki377CbZDodvqLrn7dOIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE0MCBTYWx0ZWRfX5kk8kbraTjJe
 zsQXwd4ySiAeomB2uKFuDqrg2QY+vMktl2oWwIXTkd/nFUFjKNM0gBmGCD+ri2Sg2GMqOB0muz/
 Sf7v1q55T/0ECFMmNiqKZMnw5KPkR9EysHVNNYlT+q+ttsbuvJ2LQMTbsjDc77zG5SoIiUWkJpH
 U9UkQGgVI0RDbUPTL0M6Ys5nl065PyVEd5Wdg5G40CCfm5lqrd3p79hEpbPcTDlppwqDufsKhqn
 Tcg55JfcwMRRaIxusL6dQN7ZFjWkscT/6+OCJ1ksMfTHM+2mKIqWkNdcijxvHJlHQGn++4lTGFR
 JSquvvLdC4nEyY/1uvFi+l/6nEX7IjGmeTJed7C53vJ2x0CFNAZvuZZP8rZQTqKSOmr8Fh8GfTS
 2zQfpRsVGITDl1SNsu7D7voKAQtWuQg5si2ncC0fKdWg3GqEo0otyL+YjzPbLFr1rCdiT3ud
X-Authority-Analysis: v=2.4 cv=ZMjXmW7b c=1 sm=1 tr=0 ts=6887c987 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=DHtMyJ2ckF_egkZNYWEA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12071
X-Proofpoint-ORIG-GUID: jGGdoartAr9ki377CbZDodvqLrn7dOIi


Gentle ping for review.

Ankur

Ankur Arora <ankur.a.arora@oracle.com> writes:

> Hi,
>
> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().
>
> Why?: as the name suggests, the new interfaces are meant for contexts
> where you want to wait on a condition variable for a finite duration.
> This is easy enough to do with a loop around cpu_relax(). However,
> some architectures (ex. arm64) also allow waiting on a cacheline. So,
> these interfaces handle a mixture of spin/wait with a smp_cond_load()
> thrown in.
>
> There are two known users for these interfaces:
>
>  - poll_idle() [1]
>  - resilient queued spinlocks [2]
>
> The interfaces are:
>    smp_cond_load_relaxed_spinwait(ptr, cond_expr,
>                                   time_expr, time_limit, slack)
>    smp_cond_load_acquire_spinwait(ptr, cond_expr,
>                                   time_expr, time_limit, slack)
>
> The added parameters pertain to the timeout checks and a measure of how
> much slack the caller can tolerate in the timeout. The slack is useful
> when in the wait state and thus dependent on an asynchronous event.
>
> Changelog:
>   v2 [3]:
>     - simplified the interface (suggested by Catalin Marinas)
>        - get rid of wait_policy, and a multitude of constants
>        - adds a slack parameter
>       This helped remove a fair amount of duplicated code duplication and in hindsight
>       unnecessary constants.
>
>   v1 [4]:
>      - add wait_policy (coarse and fine)
>      - derive spin-count etc at runtime instead of using arbitrary
>        constants.
>
> Haris Okanovic had tested an earlier version of this series with
> poll_idle()/haltpoll patches. [5]
>
> Any comments appreciated!
>
> Ankur
>
> [1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
> [2] Uses the smp_cond_load_acquire_timewait() from v1
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/rqspinlock.h
> [3] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
> [4] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
> [5] https://lore.kernel.org/lkml/f2f5d09e79539754ced085ed89865787fa668695.camel@amazon.com
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: linux-arch@vger.kernel.org
>
> Ankur Arora (5):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
>   asm-generic: barrier: Handle spin-wait in
>     smp_cond_load_relaxed_timewait()
>   asm-generic: barrier: Add smp_cond_load_acquire_timewait()
>   arm64: barrier: Support waiting in smp_cond_load_relaxed_timewait()
>   arm64: barrier: Handle waiting in smp_cond_load_relaxed_timewait()
>
>  arch/arm64/include/asm/barrier.h    |  54 +++++++++++
>  arch/arm64/include/asm/rqspinlock.h |   2 +-
>  include/asm-generic/barrier.h       | 137 ++++++++++++++++++++++++++++
>  3 files changed, 192 insertions(+), 1 deletion(-)


--
ankur

