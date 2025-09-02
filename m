Return-Path: <linux-arch+bounces-13363-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420AB4104B
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 00:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4AE1B6096B
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7622765D7;
	Tue,  2 Sep 2025 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iqc+z1tl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cMHSe5Mz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC2272803;
	Tue,  2 Sep 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853242; cv=fail; b=KsfTMVabfjUVkvIOxVHQAWLpgGExQyuXsGQjOpFmvjbDDfUHpUS2xDNaoL/dWrcVganws2eUNhwM0+xYeqvQYBvUcXDJZWVkZWM5ADsmG2tMDNXDpcBEnbJczna8AlxSiJI2mw4cnmWTjsGi9qowwBkAHxKx3v+GphL5pWYLRQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853242; c=relaxed/simple;
	bh=0MMFz3On0fisslSSvjjUqY45elOMxCdA6dcEvPLtlkc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ghqBi6ePtNoJFlDT8cUetj9LrflvEwO2j5o8nRHpB+3/JTgBQycDzYY4wky04C0P6fM6zw//bhkTsPtM2ZsB6tOtiqAjBUhi+LQj/xul0fqfbb1vrTNTY9uvw8mVL6ECTUY7lSgN+e2cYbcZLjRghGxSGeH8CckvrL3jcl0fR2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iqc+z1tl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cMHSe5Mz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582MNWee001693;
	Tue, 2 Sep 2025 22:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8NncU0qQsn7PJ+U6yf
	wRfHnl2xOjeqMPlOoEUaOWJNA=; b=Iqc+z1tljferlomWw2jzFuYqVOW2h9l6hc
	5W165i8YN7v434jjZfSx/QqVSYVomgnExzOme40UnOTRmdpALze++RnhWORxulW4
	zY4SEMs4ir71IK4qMCWqk8SRpfj+77BJALhA9+tXtTm+hblijzCNF5MfsYQLMipy
	wgze5hO4pqSb5o+n1uYgfWyws0A/FPZWfj6+pWpunntoGIe4XnIFwn7iMeAAoUXO
	QuzM3zAA3ENQxhmnRwgX2aYSUPHUHobCo6jHrNiU4UDp7xadrCleqMltVh79AZUO
	/lOjYiFfQjUkORYI3JqmqyR1J1IgWrLEbdVDGJRriHSP/vF/C97Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4mjfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 22:46:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582MXBgU015785;
	Tue, 2 Sep 2025 22:46:56 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01nxgc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 22:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJZuRHmg/OwevtznL7QIwNXVqXsloLENUu7p3OpToqTbncnI2ejJ/jq4qxcFlNhMQEmctMZHMDsZXXb2gx3kOierctMNmaJznWMpwKQe/IGlDRQ+v7CkZGjeMYpzd4j7jjVUTbaTRE4xK9YD2gEqulBSPbeXPEefxqx0dieQ+4kkEKixPJGI04xpoJ7+ST9YmQVgWGx3NAQqTd7pIwODvOHqQXJu17xV2jD9EMyLKp8zhDMR0WM+xKvXNYlKu9SlYf8YfBcTdtJTenlbZ3oYpyDY6S+qbFIlgMARcObK2h1NvpvXOq3iVGQvAHywQbf43sf3l+5RqSo6z0I1Re3kKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NncU0qQsn7PJ+U6yfwRfHnl2xOjeqMPlOoEUaOWJNA=;
 b=gHrDoBeR/ucYByupguif7GxcdalyWSN8wsGUqPmC/neYwYrmTCliOtWebl7EVsEJvFQAE7xdC/dux+q57UtNXGu6mH04MnrED/bv67z2QtzKXskktj9tb8r0hN0C5g/X+Pkm8WTtLUbWgxrEpkxmYGQupnR2Qaibg/oJdg6HxFx0fGH56GHFamuG/mWMW2EjudmDP2Fuo33HonqePYTC8dwEe5H5HwdkUbrKt17IK0VqF+t44BhhrIqU/+Hrq8G4r4TlYQZv54bfmrK0sAsxUQNnx9o24uEQeloIEo3xPRqL9JBS0HBkI3TpgqqZEnawZQMEdJLCJr4OeSpj+VGy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NncU0qQsn7PJ+U6yfwRfHnl2xOjeqMPlOoEUaOWJNA=;
 b=cMHSe5Mz+uC/Hh5o0gihsB4J5b3AECg66nfaKAYgso3EhYX6giUSkJmV7unPEca6HXPKWoD4dw78WiAMUAEGIDRLy7XSTHHhMd4VHq/7Q2eTcCvcpFWzMrU8SyBmj/kPXo8/mbk2kW8XfL91czAc4niFR9DTb6n3rsCMRzYPIxQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 22:46:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 22:46:53 +0000
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <aLWITwwDg06F1eXu@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
In-reply-to: <aLWITwwDg06F1eXu@arm.com>
Date: Tue, 02 Sep 2025 15:46:52 -0700
Message-ID: <87tt1kpj4z.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: eb992642-6abc-47c3-740e-08ddea729cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OMYjkRlqmr8Lr/ETItQf2bYxSvP+QiIANm821wMsRJhmXALcYmYRMu+sgYTd?=
 =?us-ascii?Q?6AAf122MSOpybsd6h6OatH4NN3n8E2r1isqgRFKAFOAZMfB9N/Epf7H1AsvK?=
 =?us-ascii?Q?o7yoNVNiPNsBcrXiwAVzq2gmki2JOWTA5RLKb3KuQko3MCF1UZfxhhLBqEhR?=
 =?us-ascii?Q?TCadQAd7DTxxKvibdUGB2SjrmkcXbqjAdbpF1budo/rrPVns0PS3gk+UctAj?=
 =?us-ascii?Q?wKAovvpHbIyMV2O3fUHOgmeKAz1L1DeVySqhnyuiCMOzem4/vzuEnEPze13g?=
 =?us-ascii?Q?9eVqFc7qJxLA0CU04KW53Z7dYUBl1/HBufmNi6x/3/GTLN0xzro8ZxoC23ES?=
 =?us-ascii?Q?LurdH73DbrxFJs9DleC+d1ttAFJzsQhNjOnRKf15iHwUYcmeLkRzIfT6n39E?=
 =?us-ascii?Q?AdjFquMNI7aIMCK/cph2oJwuTKE7BH4y5d6x9Uu+K4IUhQET3tpneyuObI4t?=
 =?us-ascii?Q?rLZvRPkoej3IvZpDc6lgkJLiOwMcomqWj3c6Fc6Ns5Hlp43mEOg+83zlWybj?=
 =?us-ascii?Q?LWdPAN05cYtHJHQhnChvrmvrAUYX1/EEdGFK40Bjzju/5lzzqHSq3DO0+2sC?=
 =?us-ascii?Q?3vZcIVLlnSquqmr2xc6RGSUdTzw0k6MLUyxqDNFwnZ8pbJ6j6yRv1mNzCV8A?=
 =?us-ascii?Q?ZxYKM/CUIGME26zMkzt0SB6WoOEm4CLBn6EEO3b8kf4yItnGpN06sSxoboGv?=
 =?us-ascii?Q?4BmYDSnANLm8ZAJi8li7nNkaBlmSXcKD1nvNPXLmj+ajJD0c013YHZeQYwVf?=
 =?us-ascii?Q?8AjqJfwjHarJ6+u3x2Fzaxl65FNBH5C/uKNl2CxaYsRfR80YdW++mZeuJRg9?=
 =?us-ascii?Q?C7fx0fMHKcpHckQLInZrcCJVsWA+56N/iX0Vzqa9UjK2OtS6mEAvQWS2vPWf?=
 =?us-ascii?Q?dvm/9uaRQyzMxXUpRssQctS+ToMs3FGvr95hQDvwGHFf7Xvx3f5fPnfyzVbO?=
 =?us-ascii?Q?/yAD8tnZg+ScXzQsFBV7olA9PChWbZ+dIEfK2TgCS1iCzZ53AncCLmH0+ojI?=
 =?us-ascii?Q?9/ZRIxC0ij6pd2Rw/yRzu26Bo42mttL2sFlEF80uGoDy9riTdYIs2JqdvIFl?=
 =?us-ascii?Q?HXQ37fw7W4/pLIsbQEicB2/79+IrMdWgiO+Fb1mPdkmZ1hCsjefOIvtPfDnh?=
 =?us-ascii?Q?M/8P7ERFkSYdWefVHiB2zXR9rUEDTUWfboP4L5YsJZD1bm9f90vOGta7Cww0?=
 =?us-ascii?Q?M86UVvJyAA2Wp1OVnRwvhJtTdKpgSU4SC+tnSVRsJvyWZxzxc3RRC2xr/qdb?=
 =?us-ascii?Q?AIglKud10cwvxgQkGd8vUqf9/BKVksfAirRwSe6OkVrSWcgB3aY5auykemo0?=
 =?us-ascii?Q?vF4OzWq1a9zr/17wAi9T15eWzF26PX9AuDHCuVrmYbcpswDNNIw/30YkJr6G?=
 =?us-ascii?Q?n/BrS/vKu64nMFSV4WO4Ni4FL1Ur+hfci7H1St9SxB9GUs8at7JtxQ6x+cuo?=
 =?us-ascii?Q?vz24tJXdrNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFubirxpsAZ4aPRLDh+u5zdeu0PWiGX6wSMIQld1AM7eeeXa1NTSarlgoniG?=
 =?us-ascii?Q?lXf/b1o2rMeESEdqysrcUFTEnUT1I3oWtCe0rs/fhlcaRG7jjVYL2bE+yHBQ?=
 =?us-ascii?Q?1yiPaQAhcKPQWM2KdFq9iDV30tqoi/Vz9W/TmK4RQIjWK9LzTzpcgtP9t4GR?=
 =?us-ascii?Q?ZYoRB/YqdR8UTYX/NnVNIBrJYf0kJBSeStzcbbX+nhiLy88c2v5k20PiFd6O?=
 =?us-ascii?Q?VSH+UgOgxEtMgQlzk4gsvzqzfVd5E2FUmDD2CiGuUCoiFu16DqgzBIKpCvpx?=
 =?us-ascii?Q?MPrnnn5Rq6IV8h5CEEo1I59q+hjTf24DQQOy0IapnYI3zqh9s8oZcQG3xR/i?=
 =?us-ascii?Q?zrw/snjd0L57oONgwNn5dh8ir9fY39tx/C67nre5vixNDf3uv5bfvMlySLEj?=
 =?us-ascii?Q?7fM1D5G5Uvhxm9T3jzSwe+wvFdOVPAIHHin6UjkDc/1ReejROCWPAsWspWst?=
 =?us-ascii?Q?DQrjwAuiKztgicOE9KMaA3B0A/2ETx76LRv+VEutpUs4vu09hng6fXZUq6Bc?=
 =?us-ascii?Q?GtRRJ1xffyXnB9K4U6kTpVGUub7GKyP47cG8wxAq98nDdPTsjcb9n67LVxxq?=
 =?us-ascii?Q?R6w13SR0X8DrEGR0zSCRUkYhwwikHsFkpJAj4kmTAaXh7jH3rcsy4kQ9tawf?=
 =?us-ascii?Q?0/hx31hyKVtp1iDZKh+QjUhPA/maS3HaV2BIlpTL/81q0MB76EuwBpd6sqhV?=
 =?us-ascii?Q?kh3AHZysW+kXhXZhvcCx4hZ/Wdk8c9lLYIQzsYPegu8fiNoAKhPkTD5IzEWk?=
 =?us-ascii?Q?9o5Mu94IYfOQJMurgkkJRLyWfSnpk4KmF93UONsDIUomtMg0INmDQDAiJQsy?=
 =?us-ascii?Q?836Jf7kMVYDrnf++1qbuds9pf/K+qUBD9Nt2c9cSqkIaLUMUVvcq1xCdSzVA?=
 =?us-ascii?Q?5Aux/j1dLfAcrTrTzwX0oCDEcNt5KULdZBCfasX+HvQl+6P2/1XD6YIH+lZe?=
 =?us-ascii?Q?5nIw8VRnbuA6bpPyqCR5a5zc9UuICtHw0XtFFzSaOAWzjOht2HqPQb8FEIsu?=
 =?us-ascii?Q?DJkMUr+XRcDyHWyBi8FYk51/JOM7YWdhlD3vIGJpkbWiP66uM6ipdXGRJ9bU?=
 =?us-ascii?Q?bRSC+o1HGZOFhwet9HLX9egRjj2jF9Pe0xrSYy1z2hD/CCbtv/wVDlJUtlEH?=
 =?us-ascii?Q?T1K2I3XIP4qjKfx2wIOas66XLSFu3mMwxEHZXfeyP5LH1Sm3xGJZ/QXj9qhB?=
 =?us-ascii?Q?iNyvR/oSngDs+UOlPrRR/5zGI6mLck1KHUF8EjEo3Dr4vQU6Edetg4f/U2pS?=
 =?us-ascii?Q?dGEqqiOghtRr85uzQp9qAIhvmP1OhEHDNb0c+MxaT7xBE0YB1ZsnXRUzLNMu?=
 =?us-ascii?Q?IsRUsXqwQ9CUXheaaQsB4wLBhBnpjHo/sYsv4G7wjYcO9GTkk5jYMIJMsoR8?=
 =?us-ascii?Q?i9GBa0ly1ZMwH94jU3K/SNR8TjimvgRCCwCa99oLVXvENjXogzE2F0YfmYM4?=
 =?us-ascii?Q?DM9zLQ5tOYTwTh48qTx/z6AW/mGyjMrt9uwMoI/WnG8wLdTxhxI9ntNUBKl6?=
 =?us-ascii?Q?Twy5GguO1636A24b/oKieiyVHHd3w2tTDkRdvYnaM7EATj5hg77Mv8qhtX11?=
 =?us-ascii?Q?YgME3wAheL9IC1l9MsOaFstzlUW5WXRqKb8KRSW2Gue0R7Fco+Vcb5C9sETH?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GU5XL3AW56+l9WAQerq/kQ8WlO/FeogwzfuDfAsC3t3YzmJ2M74CetGt54sqetZQfh0ztFlGLHnODm64vAupoFYAjsK11yZBWn0ZDoVfINo9bcbcMlVgZe+0HSN9LMjaR6foykE5AXcXIMizObZoYw8AU3ehju9KzG1S038oPOMo9vLHqRZqI5A3h1luDc9e8F51NMa/uoWFAdb6EbTeVXTEAwpTWLLkrM3dE1rpioN8ooch86blicqo8twWwZXbhL1wLvz2Yl/e05K7kzsdViqmjMXEg9eXkQ4wvmGbGR9PXfI0IXaPqvGa/4Xx2wG1DKboDIg1SU7wkItb2W5ok/pm2F50FiV0PssS7pVC3wCNlDWHaFO+szrGs0jWAGhlxM+yHnsYG8x9WpDlUcmWu+sqOF+MhV8YSF80S/SV+Q4zvWITeFL1BEijCMEgV5hOSOIZzQMPDcFSCQonY94nOfG0bdzW/WS1Dx4qT7HpQJb+R6HMNBYVlVVWrs+tsBLSTDgtAG2dI53ECih9k6k6Ll0/b3dN3/g2vbsYany4IqpBPEoWHd5nPmdQ/hYhBoUljLynsaEJMLpCmICwJR8T3nSYWLEE8Vte1Ks/bL8IVTU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb992642-6abc-47c3-740e-08ddea729cd5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 22:46:53.6214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfB0l0MA4WDEMyjPMJRmRl8QNJCbUhOQIth/aLfcQ2rmKW/Bn8Agk2efOKRz4HzeyxYlq/XR8Vd7EDY23C3N0Ag0VgB2UlIu85cLZE5hIQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=954 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020226
X-Proofpoint-ORIG-GUID: PjD7xV6g5e1oBXpt_bOnN2EldfgGpwY-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX9V5cZwpzMmE/
 T3xZDUmtLY8XdX9qsbbR9W9SripOvRaVaf82GANvHr7LXhuo2p0fx4Alr601O72qGanvR9wpx7g
 ISkYiA94TksSVd25ve1I/UAPEmhZGJpLdcHRxBfRk4dX7j/kJz48lY23JAemWD7LSd0SgbH43vc
 zN08W3482Jjj5ldp9fFCM/wqxE6ncPgfNvvSVRDO4ARYBYLfAKjzXC4Amq1Pk5v5TW+LEXoiSiY
 78z6vmP7vzgaf1HNX7dSWax3a7Ab555fwYPr7v6YgVexQ9alyBQOVwYGFS1uRf1Gxolm3Zc2oLS
 HzgJ8r4nAY+K5nbuvDBHhxWbxetdaEbjctQZj2l6lLJK3rWbO+uJQVBLb2gQlTwfjIiV6V243m7
 Nn81932L
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b773e1 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=kzNr17P8OBhAOj0-960A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: PjD7xV6g5e1oBXpt_bOnN2EldfgGpwY-


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Fri, Aug 29, 2025 at 01:07:30AM -0700, Ankur Arora wrote:
>> Ankur Arora (5):
>>   asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
>>   arm64: barrier: Add smp_cond_load_relaxed_timewait()
>>   arm64: rqspinlock: Remove private copy of
>>     smp_cond_load_acquire_timewait
>>   asm-generic: barrier: Add smp_cond_load_acquire_timewait()
>>   rqspinlock: use smp_cond_load_acquire_timewait()
>
> Can you have a go at poll_idle() to see how it would look like using
> this API? It doesn't necessarily mean we have to merge them all at once
> but it gives us a better idea of the suitability of the interface.

So, I've been testing with some version of the following:

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..361879396d0c 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -8,35 +8,25 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>

-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
+	unsigned long flags;

 	dev->poll_time_limit = false;

 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
-		u64 limit;
+		u64 limit, time_end;

 		limit = cpuidle_poll_time(drv, dev);
+		time_end = local_clock_noinstr() + limit;

-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
+		flags = smp_cond_load_relaxed_timewait(&current_thread_info()->flags,
+						       VAL & _TIF_NEED_RESCHED,
+						       (local_clock_noinstr() >= time_end));

-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		dev->poll_time_limit = (local_clock_noinstr() >= time_end);
 	}
 	raw_local_irq_disable();

With that, poll_idle() is:

  static int __cpuidle poll_idle(struct cpuidle_device *dev,
			       struct cpuidle_driver *drv, int index)
  {
	unsigned long flags;

	dev->poll_time_limit = false;

	raw_local_irq_enable();
	if (!current_set_polling_and_test()) {
		u64 limit, time_end;

		limit = cpuidle_poll_time(drv, dev);
		time_end = local_clock_noinstr() + limit;

		flags = smp_cond_load_relaxed_timewait(&current_thread_info()->flags,
						       VAL & _TIF_NEED_RESCHED,
						       (local_clock_noinstr() >= time_end));

		dev->poll_time_limit = (local_clock_noinstr() >= time_end);
	}
	raw_local_irq_disable();

	current_clr_polling();

	return index;
  }

--
ankur

