Return-Path: <linux-arch+bounces-13490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A55B52765
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 05:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100607BCF5A
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9640723D7D7;
	Thu, 11 Sep 2025 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8Xw7nDO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LOt4E8N7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21201E50E;
	Thu, 11 Sep 2025 03:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757562451; cv=fail; b=KeyimrT9R3dnWGZN3roY8vh5rUJzsxaRZ9aA7jctwR33NPRcZO2W1h+SSZ7YGn3t94JBU4eikW5lrqfyloj9kV0trXFBi8AkmbRVmuRm3JixEjyLdfwyOQ4+8k0fjCYQMLA1DtkpM1P4HjiYhqAuM1wXm5kZiaf78nQ2jvNrlsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757562451; c=relaxed/simple;
	bh=EjrOwH+WJAXVyquBWpGoaHn4ajtO5kGJIvmlzxrZsEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bz841e7LcsSADSuNUcRw4pxvBchXQwmCf3k9pvJ2nK1mhweKzLJ3ZdBojLc7+qdo57fa+FZs6BvsirCBgUUIg2GW0n4gG3yAkpgb5sdhce9EWTn5OEhdQv7ZjbyajOYB72DoVPHvy8/fypnFqcTOH0I+2aq7g8epVTwK+thl9Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T8Xw7nDO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LOt4E8N7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ALflfc027103;
	Thu, 11 Sep 2025 03:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Dqhg7aAATqn+WotQXZliV2rvYC7OFzK+2fqxfrKCcJY=; b=
	T8Xw7nDOCQh9PH5tX5Do4NYDdOQub3lH9nYBxJRGt7G3kx4aLnV0lc3/BtNATxZV
	zEXiKDX+Wlh6TXpnZU59q10U1YFoDyHfHAKExaAq2B6Mhbm1Cdc5r3oUlV6YaWV9
	jAwgDF32f+FOFsnUPtIUzURTUj6NRwUYn8ogSy9FY2AjWx/oBuKA90XhU4Ys3Mo+
	D4f8f1AhbiwBI6Wv6YibbU7mwDcQVAGG52qRW6LGrp5cdGcdvjtOv1yyaPDsfCy9
	Xm6+BroKWYoP8jdx2NTwhzI/DJLsksuwoKryS3IqIYGI8P9CwjDR0GUM59Cwzobk
	iljGdTwuTc5rTmcrfpHwGA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x95cqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58B3jsRC032819;
	Thu, 11 Sep 2025 03:47:12 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcudye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 03:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeZfcsraXSH7kFjPZz6zEkVxrxUsGkLxiuTns967HaV3Ek5sJQySkuUW/7P00GYsxAjCigHQafJIqWhqjuzcfYYc3Nu8Dwa2yCtHiMSbOJg4PQfNUEjNq9Maf9F5Zxwdt4lKC2v2IekMdKhhT0vhVcKyutqj7a+7nGXxJE35b0DACPWXdUzT3o0bU3MXXoJYnUhs+Ffd9MIbWJeSG/t3Vc+U8MIaJXUAfYA5WRO1zJnjAVkLVih00pkUozZV0STjQdMyQoEoQaLp97Il71EXhuUbxnr28hm4kHA/eOyFzF/b8KVi+4edg1LNjib6Kvm6XnF0myVeu+s8YV3JMFpt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqhg7aAATqn+WotQXZliV2rvYC7OFzK+2fqxfrKCcJY=;
 b=Xuhc//n8EpA3k2p0omtHfel+Ciw/d0HJrV/9KqG9jNyDL6edrd5h7xIrKt/iwkpbtVlGxI66I1GCuDckW5ycjBhnfGORH5rHQsS6E6bxEmvfESqk4sOkE5SJbLblCSYfn6C9EdkHHd7YrLJBD1QYESRnAg5bY61ahH7i+mhO8Hsk6g4TtLJr5oJfaslJEWFE0DJTdmlTCsDSpeLt1/1OCf4JWTNhBYTQ1xydWQzq+2BSjWWIdYCozuZTmG9HihN1W3S2r5wT0k/cGRvClnDdf1TqkSnsFBYpx1bhtOocsgC8XRmMXRk05JAxyU43ndEUOGIveTnSC9bxn3O5EBuF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqhg7aAATqn+WotQXZliV2rvYC7OFzK+2fqxfrKCcJY=;
 b=LOt4E8N731fjItLimq/+FheiGLO/mKB1YAlLLVSAOmVNFMTxzghMHtXLzmKu3flrX+Gqmf/pJf5OPE/uCXcZfhf02FYqO2AuUvQf4GvWlDoq/VnE3nzv+7qxRjPKk60fo46Xiaj2cos5MymPzkPiyHyIRTr/+Y6ahC6QWJKDkgQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS4PPF6C5A39D55.namprd10.prod.outlook.com (2603:10b6:f:fc00::d26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:47:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 03:47:07 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Wed, 10 Sep 2025 20:46:55 -0700
Message-Id: <20250911034655.3916002-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0362.namprd04.prod.outlook.com
 (2603:10b6:303:81::7) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS4PPF6C5A39D55:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd6ccad-cca0-4a33-61aa-08ddf0e5e0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/uryPd4JS54HUmHZfMaWvaTWkP2oCisJsm6rvdL6BFYm7+u2ZmnNEE5yhDA5?=
 =?us-ascii?Q?qLobMstmwGfRd6jihw9eTcWUcPhhfM2K43/lvYZ/20Ru9o06vvGCsId5K0Mq?=
 =?us-ascii?Q?9OVDqbC7qxgM/F6bKqN3l2L3ZTm9m1tEVIogUsrdDLpKxTAi3pIqsp8aztKZ?=
 =?us-ascii?Q?9DNkHdrWWLI2O+Gdd44RpI4pAtvR/DPupdDuE1Q3siqlr5eU7lXbEY0ignBt?=
 =?us-ascii?Q?YhlJWWEXV0+1hpPZZm+fLMtzeLYQ3Pp/xRLHt3gpETNvRM5CHz6nyZceNSs8?=
 =?us-ascii?Q?1ShqiW+hEh0DWpwNd/i+MxygG2KZ18oSWhJzqRRecauFcBggtrB9Ud4J2sl9?=
 =?us-ascii?Q?inMUmVhJj/R4G4ttAOgWVEnYmTg8P5WUHMNM37Pn+nj3gqFIFLZst7xRrI1Y?=
 =?us-ascii?Q?b3YFhw+S7yu+i0/hw0t58s1vRUQRhxdp35D6XFLIstgMmmklFZwXz4rGqwah?=
 =?us-ascii?Q?2b2SU1Xb08U4PBDGm2JQUtoPvA0gu86Ffdd/FVBqbeZ5s9fJUR/PfT4bkVt9?=
 =?us-ascii?Q?psKl66GZhCcY5PTzm474pxQvnJfWc/zctXLbBOoG4G1pw/Up5PspAVxhd4un?=
 =?us-ascii?Q?tDoZhl5cGp+4ePgc9FXG0I8MS1wGo0ZjMilJeuag5ILqkr2/XYDRVIulNOxl?=
 =?us-ascii?Q?Di66uY9mLHJVliA0ANrdnIzzKvEcdNAxgS986wpyAapHyX8UCb0caa17KDa2?=
 =?us-ascii?Q?KR2oRWKYQpdQmnpz9S0T8NrRO80psGw9ZBB5oPaQeCMy8ls0M2GlBSoSkM3p?=
 =?us-ascii?Q?PPiPmhIjmQMMDEv8xllMvL8YPrd98UuLS2LNCJbnuqdIZL9Niae+sRTsUylY?=
 =?us-ascii?Q?4Yp/vdE3197zVIYHyfjlfX2pnagZ8V+hy2gT02b2UZlMvpKdr4Y8YK7Y8Emi?=
 =?us-ascii?Q?dPXSxxYJMTl1H8AbmgnF/DPd1soQ3Lw5HrgmCclhHf0M1F8kBTEvN3GmKti4?=
 =?us-ascii?Q?mj8FI6i978JQKOkDsUI1gyD07MFf4Ef5NgTG25+/Y41WLQD4h5yMtZxD64pQ?=
 =?us-ascii?Q?MK4dFmFrtEUQb2AlyfRNo7n834EOFCZEgI+RA4adacoFx/rxwefZlRbUsHYZ?=
 =?us-ascii?Q?B9wO1f//ztc6V/hLQDr6bD8S8CNaT0E46h+xz9z81RQYgbHvult9uJ01JqQm?=
 =?us-ascii?Q?iv/rWP5FpxVag7W7jJke5hsGyXzpQyhw5LrIcPZ7mx2SyMIV05uT5LhTBjhp?=
 =?us-ascii?Q?amxoWruAxfr5Zf8FL5E2YEHaWAKKdwKE8yP0/4Ner1nM6eRkvJxgUO4/r4Gr?=
 =?us-ascii?Q?pD0vVnYrLJC+2cDSdf/KTdDmE+ex92xVxcpcTxPlVzoL90sDUBW+BMFZkx2c?=
 =?us-ascii?Q?wxXAUx5lOJutz0kLgOUJ8S2MzoSfXtIMWA2FHhP3eydGrsPy2zeIaD6oldIK?=
 =?us-ascii?Q?6hDzRBy1VEwhrIhZRdxCWseOzhHKxBNyqGvjAIopVlFsfjBm4yfOIx9zZHgo?=
 =?us-ascii?Q?0SOiy7Nem+E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n5HHch0/2rmNkKdIEnsB7NHHWCSd473Jm16u30nTPlAjO/xy0gXgxvw8ZnEb?=
 =?us-ascii?Q?npSs7ZnZsuW+dGIGbBkgRZHF0vFnGZitYBKpK8Dy/aQVmPWv7LiHfRteqiVu?=
 =?us-ascii?Q?RafVrf9xCp6cFioR3GpGbcguup5O/UUHSjQtnXetcOjhumQ+kruT+Kehii9w?=
 =?us-ascii?Q?awyI/NUUsieX6+u7u1CLACuOBzj0dwGIPVsSD/V9ebenE3ZoecdWLfMN0eJs?=
 =?us-ascii?Q?MsMCuCvrZoJb0p+Fvm0+t9kdBrGAnWGNYOkRi6qp1uHNCDnTAdAvdp+6SORT?=
 =?us-ascii?Q?K8+GpuZfJ3P/P7ON8BlHNME1sqV7Je225nOzOb9JG/zHI4kAIaLORe9PiATO?=
 =?us-ascii?Q?TS0CokDq8aTQHCirvNiz948DFI+U5XXqfHXzuepvIoRx4g5+Qh0p+MfUAEbr?=
 =?us-ascii?Q?4cBjJmwgURp4ZS1gKof8dw2jCvM1M1srhESOCgo35BuD/zTV0LPy0yUpJRIr?=
 =?us-ascii?Q?GGRxfTB2kJOCu4qG3WdG2sAotM9bdRyGxeNkOdPIYzdhJY1Z59adB+175xSL?=
 =?us-ascii?Q?0oHSi2LGiWMR+fWIlJJDagZABbtOso/YfwC4HutbY/tNlfzycC5ArCdJIqVC?=
 =?us-ascii?Q?l2y4Fxw1FyHgdxIWeXzzH4IRiiWvqpZrRT6DXgAi995caE3c7sQ5FUUAhTu0?=
 =?us-ascii?Q?4h98Oo794SMSf9DTGVixyY6+5covjna76ue+yZwPw1ESCHliZ99nVdKuT+84?=
 =?us-ascii?Q?j6JzubFjJR3G2M/M5brkSadcQhPV2nXB9+eOpT90+Tixv2tZkZvDpDKa6Oq9?=
 =?us-ascii?Q?GHXSdNGR6/Hrvufis2KIDvPoAipuLCKWsd922USx6z2BIQ6G7OuVIi1r0xxo?=
 =?us-ascii?Q?b3z+aQH3W5hs0TAS8tZKC60eEA7IBFbv0X45Q0VULm6xIrbAD+1Vr/JrFKYI?=
 =?us-ascii?Q?0FRts8EiosmtyyJNjl/UK54B04h6ojPYgohSbRCD/kaiVy4gv3TIVPY+3Hji?=
 =?us-ascii?Q?t3R50iFEk3oPkzNwvJ51MnnZ54ZpUWCnzDkD44pqh70ErS2ISQtIkN39Xcnk?=
 =?us-ascii?Q?vtA0FqPgIHwOpyR/Dx0wawIRWS+zXO2d6qQ5IpgYLZBSp3kn55gx2BHrwO+2?=
 =?us-ascii?Q?nWV0wVsWlK7rXsZzvJsJ4GB7KwDKfeuMinnssik/gFGuA3W45alOmdH6HSCb?=
 =?us-ascii?Q?BZJ26qwP0AUM38Ky0gAYWjTtwh7PVtCnXlNcw3Ej+8k9W2gt0cUUSHr7puDf?=
 =?us-ascii?Q?rBGhbMPoGaNbxe9zl4ruGoiRdfCjj7wSqBEqlZBl5hhpd0XH3CzWDru23+3s?=
 =?us-ascii?Q?44kItIX+owkIwX6ATIgPF9mbITcMB5cHP3/5Q2ayXCri+T1bP7h5loKMsj2W?=
 =?us-ascii?Q?QnziSpMBMLs1SOClvPEjQW4wlGb+zUz0C3YoqI4/FkpHKoQNcjaJRVFRW8WW?=
 =?us-ascii?Q?1LXHWVPwyn4ioxyikOUu+Ux+5M3IH6JNnvV6tWCztlTdBFfmHq1adKig5XWT?=
 =?us-ascii?Q?0bp9s9FYl8iEx580JJiVuEstqJ/s86iQuxueHUKqGH2AYu6ulT4wCfFmqwXL?=
 =?us-ascii?Q?v47KNn6NBJks1GF54vKvUbqforF0oGJR5lgRygs6963Eulm7qUgcv1RpfBJ9?=
 =?us-ascii?Q?4fA4aRDppJOZdml1PyrWs6qtUgC6kL70vlQyjP1jsEup/sv9inZroCIudVET?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gFttdJ209d0JJ1UO8sHqwG723r5O5mkH5qkJmN56DiT16GQ2y6McvM5LrOOY0Ay4S8gIguPVgh0NAQyZz+MPRVanaZrUG2seF+JkXWgJACWIP6LWq3k43fuBpt2jOvthDxWumaJ5bTcUyNYCgLMe8aXb7J5KguP0FId75EWXkh9hHOs08kas8Wwvjs+lYvl/rTruZlLh1amt7EgYaiydvdtq32yo282D8hove42Te9VZnVyst4k+u8hwv2w+gai26KkTlU0KHcwuc9zKfviTaPFJkQ1OU7CtTG7WOe8Ch9b3W31YzcETiiXNbefRszj85yym5FOE9SpH/q3JZkiCWrc1asDTeDYf3eoCgdPJYMAmwJN96mdVCdM+d133FZpv4SaJg72oQbHd8h38EJsF5cq/oH9KfFU4SfQhMyGeVOO+eRI4+zeDV6uNaSuTbqxpnvkhMRpIAoKJ1XwxFT7+gm9A7bfHH3wvwsj22WZ5dX7SXL+tV8AmbF4RJkC0txgdh3rkRjyOFOO8smY8wjT3749b9acpU1iHk7v0r7EMyqIilklCZ9wAi43POZgeDnIqcOizKVZw3svPTaU1QprRkL/gWHgK8j1lhiz3eItbuBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd6ccad-cca0-4a33-61aa-08ddf0e5e0fa
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:47:07.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzw2fT92PADwj/mPITc6I8Vn2/Z3A/DPi9Vz5LAcxE9M5lJLl6G78iVH1gabSv7t+kCWCecAjg8p/ukJ8Hte3J73Iw/J9Xog/of8woNuZzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6C5A39D55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110030
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX14v1XhdqJQDe
 O61GTxHJduLrJmfnThWEuKuFOCQm2ARp5sxUHucu+/WKYp33+rFOpFW8yIxlpDV1DuEphCEDaoY
 misOiOSqpqZB5deEoTgkpNFQD+SYz0KJRZBHb3tlLGRMWAWXyg6c3uPbL85pZrP6zNfMIfCMP7H
 OYIKPcD3QsoYBI3wbPMWCwuQ+1TxGN6P6NbOgUezkFlBVfDiSuMmCVkslpYai3L8RGBJJJ14Qhp
 CAFGLHKoBV/8unhAcU4MSrab3+07AYg3qqa/CnJomvPzgxRp21sAu1YRChHrXyoKamebWXdWONA
 s9hKBUGrEPwHuXmTfPZ7zha9Tyrwug54QNwdDfRIRxQfqSS6+rl+4hbEJhftG2YPz1FPk1ouP2V
 00TzffdH
X-Proofpoint-GUID: ofy4PAQ-YjAIcWhWV1cn-FPdmXrBJ9sA
X-Proofpoint-ORIG-GUID: ofy4PAQ-YjAIcWhWV1cn-FPdmXrBJ9sA
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c24641 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Xdqy_anm06y2ZC_Ps0YA:9

Switch out the conditional load inerfaces used by rqspinlock
to smp_cond_read_acquire_timeout().
This interface handles the timeout check explicitly and does any
necessary amortization, so use check_timeout() directly.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 5ab354d55d82..4d2c12d131ae 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -241,20 +241,14 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
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
 			(ret) = check_timeout((lock), (mask), &(ts)); \
 		(ret);                                                \
 	})
-#else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -313,11 +307,8 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
+#define res_atomic_cond_read_acquire_timeout(v, c, t)		\
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
 
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
@@ -418,7 +409,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      (ret = check_timeout(lock, _Q_LOCKED_MASK, &ts)));
 	}
 
 	if (ret) {
@@ -572,9 +564,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
-
+	val = res_atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+						   (ret = check_timeout(lock, _Q_LOCKED_PENDING_MASK, &ts)));
 waitq_timeout:
 	if (ret) {
 		/*
-- 
2.43.5


