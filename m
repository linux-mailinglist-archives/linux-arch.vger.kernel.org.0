Return-Path: <linux-arch+bounces-15397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0D1CBC7F0
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCB7E300A354
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC8320382;
	Mon, 15 Dec 2025 04:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MCUx2LGB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="owmg552j"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723D2727E3;
	Mon, 15 Dec 2025 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774273; cv=fail; b=G4TWYn8bEAq7qWhlfJ4O2zQs5T8YFIXs706hiGvnG/wxKZ958wz0/3Z5yLQmrYhQYC6y1DgtWgqB5ve0EayBp+CGbuX/hTyplpcrkWknaMPt10kRv2XsEtomW1ByTtLl4iODvlQTBVTZtW7/9JaTKcgEkLy43VmyIusgMQLLEuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774273; c=relaxed/simple;
	bh=8er9HkOAyaNwtxi9KyaE12vAyeEbY0ndgEhI2UVtS7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SG+9RPjkSQHwieWXZcOzl5llVPZBZxOZycKbMXaGj4CGV7bgU10mfZtsQ6xCD636et4F5/CFLRzUE8o72FGoBsCAYsFLrDUqujcKr0nl6y4qYcpOIEvxh9D2AH4nt5bnOOrz7P0RTGTxLE6SQ9jV/OwRa7u/6iIg37PD5iL2/R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MCUx2LGB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=owmg552j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF2xDqV1420645;
	Mon, 15 Dec 2025 04:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RIFrJ+IwPYQtq4AFhF+Ofbwbbt8Eqi5KSLy5R1SF0Fc=; b=
	MCUx2LGBxGvHSo6huzlJPFz0qfhUrwWgkOv0QNbp76TqC0XC0enfuxrpHrSc7gMF
	2ltb7cRWEdgZI/1JqRZmuq+6YMEb8Rbmyas9EleleyF9W4bIQOubMJtDHrNsByAK
	Su4lTWuFm6nUE8lLt7sc6NXChF11I7HKDfNQgVO0HFGifeHIJ2DfXfl6Nb5OxnsS
	QEAv4fYixHY4Ssr1UT0hESOteFqejrkshVsaKtJLd9I6Ebs8QJX1On3uY+pLCP9J
	qYljoX0wyoaDm+RjAwpUa3cOea++N1PXD7UjtCTQR7cam5GVpH785R9nfg+cVJIg
	+iQYueFDgcN5efs3YRXgVg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b106c9a7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF1gU9M025249;
	Mon, 15 Dec 2025 04:49:24 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8rda6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym5g4scogYrjU8yEtV3T6uJVTbIl8/IyrR+CBRwj9+2vxAQbaO6cgLnnZoVOZK3o/tiBAduzfoYGToG60ZrG3O8ybIP0zQGMUslck1rbxfYeWrxFIfOGtLqd7Z+WutI8XehQb6yNrYYwE46vbi96W2733obe2SjN8aLg3NccUL4c7o+whwIkjuoc0NpO4sFt5D7qW0c5HBQk0jnx1kqiJ7LGADtJaQCBy9osx1Z0Q1w/YYN4eeZVNKOQt8LxGvdzwqveap/3xDl+oCehQv0HahFwjE3K3bZOIV/HKYU4cw8iT18SXf80DndnvZofenFUrP8luoG6cNgis8WZ8RkeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIFrJ+IwPYQtq4AFhF+Ofbwbbt8Eqi5KSLy5R1SF0Fc=;
 b=jZsBvooWvZixZu9jNiN5SJ15mGUSgeQvthyo2v9Ac+HHsuA5fSe12/YGAnuTPfpoxpaMjD//MXe5E9c504igerrQ6ZPPp5BWEFICnYEdbXNNCeQ5FUmnWZoSnH/mZY1NBgp64JB9zdMup263ajjE932LvHcj83TM6g+WqX67mt0MDGw1HbK0S7SW5lvk2NNrpUZ3qTHUhoB6nPf+0s6SUxjZ3lXyI1dgLhVQm02c3ncZ98Wr99NOAI93dHjAimXu3QSmo3VDMhljQhH0sXVQkegYJU82VoYvL/NrDWtGLmNKI2uZ5LRtpfWKRRKlJ86hUAAojDNpk/X/jNFdu8pYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIFrJ+IwPYQtq4AFhF+Ofbwbbt8Eqi5KSLy5R1SF0Fc=;
 b=owmg552jLGTu2uXTF1DEfdAJJOzR26vmPj7ZMP0Zr0hlP4tW+xukylkX8TyxUngCERh3qLcuqI5sKhiEC6dI3l6/dJpO1wtHhi0MUnxfUFr2ugjNFwQlOXY6Jd+heTFT3DyU3Ku8nryeWFJBv1agMb4kU3d8wqa62u8m4r8oILY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:22 +0000
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
Subject: [PATCH v8 01/12] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Sun, 14 Dec 2025 20:49:08 -0800
Message-Id: <20251215044919.460086-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c7ac240-73cf-46f1-6c73-08de3b95507f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dxjJvDsVvWc1QD3ll6PkzrtzU2l0ec0uYtrROL8QbAqXKDvJL3ne2wSenvEE?=
 =?us-ascii?Q?/TwF9LwvDj9tWpYmKAboCW5rBi4B1YO8PlgMzFN0NFbT2+lM//yS/3qSDFzm?=
 =?us-ascii?Q?NuxG0RR1smKOtcvXLi3PVk8jhne1deYdaGIARr0Ir8C8otSYs+Sr5wURiaY1?=
 =?us-ascii?Q?njDtQ+rGTc2WJ4AFa+wj6AtRHHn9RUm+1icQXUt+RLgz2hAbpnizXr2gyZo6?=
 =?us-ascii?Q?wDhHI02kAINRe43D8Y+sB1eQx1InoERZJINB5XDyGG+uG/iZdSzBL88a+qoL?=
 =?us-ascii?Q?pR/DopFI+MSr9c8Vo/uzwWhflPDnHHTDG1WFl3jhaqZ3pu8fDe1c7ZhC6aA7?=
 =?us-ascii?Q?aWEI3V9X2ZzHCSDBBQ6EAvpqXwpRWANpRJhe7VKXk7SLh/KUI1/13oVCWw4Z?=
 =?us-ascii?Q?DXssU5wgcCcIXqL3FEDLMzY/cQozaAVCBBzQNPFpXOS9UnA5kH4h2sYEzqLI?=
 =?us-ascii?Q?0A3hrNcPP86i90k6TAWASS1UbyYTuZ9ddwPyyBMup4PX77vfR6IP3m4PiDcI?=
 =?us-ascii?Q?4qyVW2IwJQmCyE7v71zzjaea7ho5o5TvwBzj8hM3XPZdFkHBvWaL4KSnNj9c?=
 =?us-ascii?Q?mTbBIZ5/A7HvVMRGBiDpICRgRfiyr7R1pJzHD6vaqnJG01JV0GFMSe11s5rV?=
 =?us-ascii?Q?xDMsrSAPyupeUrgeLEurQ6j8kwot8SvBJU98nvuddQ6y/nxPJA4KKoxB6fpY?=
 =?us-ascii?Q?De7cLaPo+oL2zH2sejH4KA/FX+9Gj+NYxPcrbvvivt58WfqviuDql98coh7E?=
 =?us-ascii?Q?YavdE0fDTU1014Gdp8q9JLiK3WLY0dlFTCyk9Zh2j2azT4Mxr0HVwzaHocXK?=
 =?us-ascii?Q?mLigywlabE/NE/Rb+J6aP5tdpzJ1q0cyXR8N2wGphV2m/JeBYiJF+VlAtOyo?=
 =?us-ascii?Q?zoyU55+nN3i9Uxk8NDBpMwMECK3YOMkJ9i0akRPu/O+D5FvGSSQgHs7PKNCM?=
 =?us-ascii?Q?AR2MtTQAulQn1s2IOBbzey3Y+Bzi3WkOYO5rtGJ/+wNLh2WRw1TRYR1LyRx2?=
 =?us-ascii?Q?3xUUZD08qn1atRwGvwXKNOXT1SneaIxVii0mDhT9ojK2ZL2q4SnqAw8sZBlL?=
 =?us-ascii?Q?f7r0QjMWxog4pxA22ac+xgGXmTgLTfAlIFL88FmAksnsVHtRrORwtL8UBgee?=
 =?us-ascii?Q?LMkcvbnIYHk3rHyXxoRtVac9kP7HyqrZVE8zlIenOsX4FtIKphnkB1qPGfWD?=
 =?us-ascii?Q?i0I8umrurbXbqLq+4tkb8KUUezthzWeOe1sYoiYFZMonaJkoXCfS5zEZKo93?=
 =?us-ascii?Q?nVd40TUsyUpgaOsjYypDdrXGjUS07OogTxjp0Z5pPHqnCBLKrk4mHQxB6j0W?=
 =?us-ascii?Q?ExS9cqLcZgOmp7zFidRvJ2QZ7YIvOBus55FceqYujNFQP+0nNS0HvXliRQsU?=
 =?us-ascii?Q?3I0H2piARk0SU8rm7hFLyKTZvuBvGbdjM0En6RxrOYE25Mo/kMJa+jMD3VJw?=
 =?us-ascii?Q?+Qsx1mrGmZzZn1EyNJP0m9KzW/l0np5D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iWDzrBwXhuJNbtDR4d/eB3f1xeUKNbAR+7PwEAD1NEkpYg6KHhU1ln+es8F2?=
 =?us-ascii?Q?A5q1gu2o1ekogH7XWXq7Tc7eDRRJhD9dES5Czb27zaIJpPbZ0/9WMtmSW75d?=
 =?us-ascii?Q?WfU6fYShgjrvFjFDBkPgGry+Y1G6Iof6iPjCsYnF/hi0jf+gmFlUd83TA7Ez?=
 =?us-ascii?Q?JCmh7EoWn5VVO/uvSOXlX7Uwf+SZJvf0YOm7BWuXMPKmbcNeJFTRl52UZP5p?=
 =?us-ascii?Q?Ol2bZHb37dVPYANftSIZ28y/dLw2+H4KHQAN2Anv0UUT63vTYy7lDREVdlUb?=
 =?us-ascii?Q?oakG23QAXuvsVgeH2I7Va6MtNCMpq0aLr2jNHVR6A4EOUuC1DCKhLt7Az7EC?=
 =?us-ascii?Q?QMywcvOWdVov0IwIcS8+odocc8uU0CMp1pk/JyuvSCPbtlNXppqkF2mFdC1y?=
 =?us-ascii?Q?wXg0DynvbWxs7GkHejKy3nv4cB9PY8WYOHQeW8HE+CLJhbPmAXmdq3li+ifL?=
 =?us-ascii?Q?kYSPbkWL1gzeaj+3ZKDyZmmV7tIYLG4Byvz0OD07VOHyeFyK7HTKJhcKYdVo?=
 =?us-ascii?Q?8BcUJKoT9zXtBewtXdbu05H2IV8jlOi5t2NmOXyCRz7DACAbEcoPycZF4Wpd?=
 =?us-ascii?Q?vHEE9sDluxRr6Pc+qdtzclVVkhhgu+7tqxPwIPAvoqeC+Rb6JzJYt6TaoL2Z?=
 =?us-ascii?Q?h5r1vJef0eNeoxurkJmQMdODrmLBipJDFgxJmB+2CJgCHi6LKiV+WIPwqrV3?=
 =?us-ascii?Q?jvUmu5dDCHS20CjVn1J8ALUwyvS01JQjNdgwPvLaLP2f5D6skfBZ+6OSdkjj?=
 =?us-ascii?Q?b7SyOEwEO9B5NF35X+pCDBL11bQK0zOrqZ3qMHXFVqWTJhAuksbRQHom9LAL?=
 =?us-ascii?Q?8clQUZe+cs50SIoHnTaoeUNMl3uIdWg1kAmjpicN7P8N3eJRd/1zYip+H2s0?=
 =?us-ascii?Q?wLtY9NTt3wQ96CIUoBRHNqe2tJcWWif/Vk5WI8mpb37UgulnnqvkvCOJcudD?=
 =?us-ascii?Q?1G296862BZY7JalkonPID/16wNwoqXTEks1/cwcBqxOVkYKLBMmyfqIGrd2T?=
 =?us-ascii?Q?zMuiRExfTMFmidaFB5fprry0cPm+Q5IQZZB1rE5N5RDtTRrWA7CS/Izj/dO/?=
 =?us-ascii?Q?xt21t3/6cgKxH44c9sPzekTS9LOwH6Y9TL27QH+jkBs6XN3OzkI2meFmxBBg?=
 =?us-ascii?Q?q3BXUkxZoe/ekYAxUYO7Uhppr8HZovIO3FMjpN2ddYR+lT2eIt25tKuP2Hg1?=
 =?us-ascii?Q?ZCyuVmzrP4RjbdaqU7GxpToF8pAOj3rnkDycQTg17uSwKC1lj1MEzKnFgeEf?=
 =?us-ascii?Q?oqz9yy28Z2mFnKNDwVWTHAXYEsmy557dAMbMUlPf6HE9PXOn2DgwIEPoa1lH?=
 =?us-ascii?Q?My/I81Nh821icZ4iQUy65IUMtbgFDBGYDeUnnkK+BNDlDZH8A0QPBkGDliEN?=
 =?us-ascii?Q?uAYKP2Apk68vnV5w6GW/mCLXe0Wj+kfdoqLkFAK2ND1tKirvk29Ij2uTSqfS?=
 =?us-ascii?Q?CJhtRiKgeM5qNIdsGuir9iDnG8BK2Z0rqFRMmh+iJr3zrMT2ZDHVQ9ztKNpk?=
 =?us-ascii?Q?obG5CxPLrKb2+Zpr/doXFczmqpa5FGUaEfHgppoQGCMr4G/zG5GpYz/gvWQX?=
 =?us-ascii?Q?q8v60owyQLGt2YNq2XQd9W0/cycJXHfy9pTQI+lfcZ7RHXTboal4LALRrA5A?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a70p0bxdxE4LUsYHnL8P7N41qrdt/e6bV3aR7DxljppYnqqpOj/g8V74BLX1vIXsEGZa41Mf8oIG0dJhgN/kDEeboP0bWGqZOcvP0Q3Ch+oGelauk9d0GOLjtSbcm4dnOzUtTMLoixtcXJX/auSR8LRAbJTUqReXrDFQh9p/+QXmNCfS2YETdY5TzW9PtTOfvF0yausnD0GCUGFJFksrMx+/69KyK3Y28E4940K9K6mfULPmJhpgdnxk/ElwpjNf1syMaGR/b1dy1IBnaS91KdXl+sd6OgT026NHeqxLayP0gyTQS6tn8EmFnegvYF2QSSGbOdiXWKqIK5FedBjFQLj+Wubues08vC7H8A25h56JBnla7cYL9pBcxlEXqNwSBkmm+GwQVd8pxzckI52iIWSkorPPcnWHELGrymncYCIVxwAtAWL0GGFcYp3FQ423Bl3TArUqHLWPX28dlV5ZyqLXNiQM3zMo59CcMZbrkBWdsWalllX0VDMMc12EGDD82TZW0FwXun3bfepLTmqtiq7oDNUvHNKqrHkGi/5zWXHA6ko1p7g1X+pBYa1UkzcbIwErtwg5E6mPFNbL0T8F27QbK1+L0CSmu2kgWL06mzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7ac240-73cf-46f1-6c73-08de3b95507f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:22.0824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvitSAC6bXMot30jdSy1haMO0oZomJ3XiK/7nNvKTRXQBGCbJitbq6WtEungWq9Z2lbtBRDc84MhZlPEvBgJnTTPKSevcZa/eAuVeovOBKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Proofpoint-ORIG-GUID: G6xDGumvdDmvHeSeHtIJ-bV2St3mFpfJ
X-Proofpoint-GUID: G6xDGumvdDmvHeSeHtIJ-bV2St3mFpfJ
X-Authority-Analysis: v=2.4 cv=et/SD4pX c=1 sm=1 tr=0 ts=693f9355 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=3XRe5t2kunFDnJQC4W4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX8e78WYx0alcu
 1t/jXzSjmMXj/WqSspJ/QFbib0MqWIr727T2Kz5lvXszjdon1yzXRuSzgs358dbLd4az2kC1aEy
 P3lRz9lv13TJgg9uwAR+PcylPKghLMNwLiC50KmubKE45kN72Rupfr3XwreM36LgsglO7km0rXI
 seIhYFXZNTVIS9xWCrQ4kZNrVjyQJUfepuPtotgKeU9e+INcngMkFRE9apPF9Sj2L5EnXCOhYey
 kUv7KV01P+UrpbeNiqSno0HeCVBzanijDrN4M/oy2qQuU6NTs8zCfDGLq7k99p2YMTsPIxRj2c3
 XMMm9CtiZV+YccT+C4wPL33VCHzPgRrnKjJ+4N0UpFem6xJWOEps/pEKBTbNjGo4fk4wi5YbquS
 tq5AW7bq0hpBV3pNElyWbu8WWYMbwA==

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

We loop around waiting for the condition variable to change while
peridically doing a time-check. The loop uses cpu_poll_relax()
to slow down the busy-waiting, which, unless overridden by the
architecture code, amounts to a cpu_relax().

Note that there are two ways for the time-check to fail: once we have
timed out or, if the time_expr_ns returns an invalid value (negative
or zero).

The number of times we spin before doing the time-check is specified
by SMP_TIMEOUT_POLL_COUNT (chosen to be 200 by default) which,
assuming each cpu_poll_relax() iteration takes ~20-30 cycles (measured
on a variety of x86 platforms), for a total of ~4000-6000 cycles.

That is also the outer limit of the overshoot when working with the
parameters above. This might be higher or lesser depending on the
implementation of cpu_poll_relax() across architectures.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:

   - the interface now breaks the time_check_expr into two parts:
     time_expr_ns (evaluates to current time) and remaining_ns. The main
     reason for doing this was to support WFET and similar primitives
     which can do timed waiting.

   - cpu_poll_relax() now takes an additional paramater to handle that.

   - time_expr_ns can now return failure which needs a little more change
     in organization. This was needed because rqspinlock check_timeout()
     logic mapped naturally to the unified check in time_check_expr.
     Breaking up the time_check_expr, however needed check_timeout() to
     separate a clock interface (which could fail on deadlock or its
     internal timeout check) and the timeout duration.

   - given the changes in logic I've removed Catalin and Haris' R-by and
     Tested-by.

 include/asm-generic/barrier.h | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..e25592f9fcbf 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,64 @@ do {									\
 })
 #endif
 
+/*
+ * Number of times we iterate in the loop before doing the time check.
+ */
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val, timeout_ns)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr_ns: expression that evaluates to monotonic time (in ns) or,
+ *  on failure, returns a negative value.
+ * @timeout_ns: timeout value in ns
+ * (Both of the above are assumed to be compatible with s64.)
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, timeout_ns)		\
+({									\
+	__label__ __out, __done;					\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+	s64 __time_now = (s64)(time_expr_ns);				\
+	s64 __timeout = (s64)timeout_ns;				\
+	s64 __time_end = __time_now + __timeout;			\
+									\
+	if (__time_now <= 0)						\
+		goto __out;						\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			goto __done;					\
+		cpu_poll_relax(__PTR, VAL, __timeout);			\
+		if (++__n < __spin)					\
+			continue;					\
+		__time_now = (s64)(time_expr_ns);			\
+		__timeout = __time_end - __time_now;			\
+		if (__time_now <= 0 || __timeout <= 0)			\
+			goto __out;					\
+		__n = 0;						\
+	}								\
+__out:									\
+	VAL = READ_ONCE(*__PTR);					\
+__done:								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.31.1


