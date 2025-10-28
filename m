Return-Path: <linux-arch+bounces-14367-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AE9C12F2E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B721AA479F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E732BE7B4;
	Tue, 28 Oct 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gxWBTZxx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vaSDDVk2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DD29C35A;
	Tue, 28 Oct 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629544; cv=fail; b=ltDGCghZ6LuRuJxWAXr5Eit0mjqc+eZrold3x4RDkkKB5vqxtRGXzdShaCAol1Aow+qV3JFXJcAs1OMIBA+LgODCiKCNl0ByJEQASvHdpq2cq6pPwkbT7GKHcTnMiIfsmzuH+I/Kv8+qJvABM6FHzjwB8IvTTLxAxUf6p81naac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629544; c=relaxed/simple;
	bh=pnT2b4FL8OiWvv+d8uW4SDFvsytiussyvW8sZfnt2t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qE6y+qQ4nnteUFCGxFOhFV/Txg0hx1dFkKoktu2acXR/h+0hbPoo2ZyvGQglQ/hlcNEprT1Cbxb4f8p1+5ONs7cs1xzIwh3y82o/D3x9zCrQlMizHzQIj8W2glsindeQS/9v3IRW3CIJKveo+Wgs4JztQJ7UvORDX6hmytiYf8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gxWBTZxx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vaSDDVk2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NLgp017089;
	Tue, 28 Oct 2025 05:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=; b=
	gxWBTZxx1CoVvTKs7xrl7Z20hBY1I7CTQjXGbMuWYR4kWuh6mJ5vjwVFBHyImriO
	BTFdZAMf90q59mcD/sGYDrRHHN0Bchd2S8VUy2j9Ocw8LKQUjd+612iS+w6NhvBo
	Cx8ZR7JzO2N6GJ8wGcSDhQR36YkiIUGYWXnR2ndiVhK6f69tZh9FUfAizsdRK1WH
	DgJ4XrAUl695C4E0xAqZLlYJb1rhU7cOGRb9ahkMrsG0kstG6EoFdZoSJliUY19x
	xmuVj4N/h1Iwjy6Z6w1wNEXwtF8sEadksUNLrGVj2bpItJvbVH+B/kSRTDI4uzWB
	pxrWvJFunToKLizi92nDzw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s54ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S3Vl8X016897;
	Tue, 28 Oct 2025 05:31:53 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012017.outbound.protection.outlook.com [52.101.53.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07pj9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R715NmskdHYZ5q2iGB+py4EJWFz/AVWV19EZVSzBDxkYl0JyhSPre7g/BINiRx9jCtvIj+w2+4UfREoG39IyUBgZLsJkMqz5rEWb8mYOtsPW363Wd4BiGs2sy316Z0G6/VDal1GaycJLQFdza9QKOJLQ4dLWQ/aWNWYth4GxaQNQ+UQqiVdCPPRz0rcUIJSvUL3yh/4C+2MYUPz7AUBl7vHbAI2V7O79bKuG7oT4HNwTDjpEFsapoaVkc4vfpmZbp5/TWB5BE3/JTgah8hlTywEwsXQ+dQ41pKUq7W+3var8ZXJkJ5COBSyezZ+w7UcZWds87a1Yv7a7uwcqLn4noA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=;
 b=B0I7yoGJ+4UL8VmMVlEkB85c6sXWFCDLGehqVsPfJkzhMzb5jKTcdWLmqIzgUVS/+kkW6dcvvHcYCURG5ozpj96JSdlzL6kWYe78CJuxrI61WblU4rofmxphBS/DOMLorP0iSVlBRh1Qyu63G1IBKuK9FS9i4V1+at8FU50TediMLWvx9u5CIDVmy1kscTSQDig+ZqPLDa7ju5xTU00vbD5iNXZM4X/3kV7XKpUzFutiZfavXk0YOYChvp5Il2odgnuU3piYpD22H8gBpHyuAsVsPBpNwmcM0BW/IRooBfbHbZVIjdzSLEiKLWXBOwsDbWrnA1EDcy00onkh61qBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfQvZm1xrBRvoSHsmuJyiv+Ix+vdh2j6DyxvNm66/iE=;
 b=vaSDDVk2OeV3hDSRzejuJBEUeSdSBRV4dexfLci+iaPtbfbXFGJp2RRCxFcuYgu4QEF4dr/CG1cEo2f0GEF6YEcFURVbHFptOxuVA/hUSyWdDeL/cAldBfFssOOgiF+XTCQX5Z7IB0/2ybLDlP4WkXhyWkg7BPy5CqsVPZG27NM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:31:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:50 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [RESEND PATCH v7 4/7] asm-generic: barrier: Add smp_cond_load_acquire_timeout()
Date: Mon, 27 Oct 2025 22:31:33 -0700
Message-Id: <20251028053136.692462-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251028053136.692462-1-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:303:b6::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 89a4aa4f-ea71-4e87-f1fa-08de15e34b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xp0VjtVHi1fU2tazk8NdaZ1Vd5D87h6sTQ/z/mi+CXopBdYh1sVOoA84s6JY?=
 =?us-ascii?Q?s+KQZKy3tysmM2EKQMfTr3G4kMLyQ0TMAF4jHLByyxz0tjCF4mPb+FCchLDw?=
 =?us-ascii?Q?OddBfOp4ZHiCoPfI+e7IoyeJzN9blRZVVl5OEwWuYh7Z1ud0f8bH9w+F/+XP?=
 =?us-ascii?Q?jxn1aVO2S3p75PtPpQ+tKBE3877Z0tSQTW+Rj9DNRXY4NFxyFvJNFDfP/xNB?=
 =?us-ascii?Q?NOnKNlvQq/J0V1T9SBJZ7deHIGY4zBqhgNvT2QBUXoBgxdEApZ0Jfu+ZCFfS?=
 =?us-ascii?Q?pca+7aAaOQFijE6LS3+am7Dy5ewsJgRHTU8bMYC4DNO9hTbV7/CYX6oZRUZc?=
 =?us-ascii?Q?QRSAa5LGa8KPteP/BUUjL1zKp2wr4g8Fz7XnStTOlncHWmbtX89fdf2mGAo9?=
 =?us-ascii?Q?hAMVSaB0YcmiuUsHI9Zu6zvhHOWsYsMM4tcyj2MifK27AmQ5fJxvfovx42ib?=
 =?us-ascii?Q?+yyPau5V4UMBXH2uCfUTIbJOusO37bxgDfHeaNl5H3dbVAgJ1jUG/nVgedho?=
 =?us-ascii?Q?FFHRDsus0KlyGJjdJ/Jf7vjOzER02cTE6X0WfPU6j1UjIL8t5WgCOCUyf3OZ?=
 =?us-ascii?Q?Mn77CKIzDSmwxHY3ampLQ6ZIgRzzTe3jZdCoKxNbhg1FG7cSRI0XhdhlRaLX?=
 =?us-ascii?Q?qdJNeccjPQo2HmJ6fQzkReQGMPlyuP6URmfhJXYHFnS/4DdOe+PZ26WuHvKr?=
 =?us-ascii?Q?/YnanPbTLGtclwv9XBK5I/OgixQxe3Pkp9wCP2xQnPdOIRFOxV9QnciIBIzB?=
 =?us-ascii?Q?NUXq9uO2296FnljvxFT2rKCQlbHmGY/LUuxgySJLbKu0b0gX6YIGr32/VCAf?=
 =?us-ascii?Q?Ez2hlW5RKqGuJOUa4QSVm6LYzHXlL76xkwqmGuaQIySg7r44h49My4ItajHZ?=
 =?us-ascii?Q?R06hUI7YEdApcw3YjYrd/mJ4ikbXzjTUvSF5/Nlql7ydfkQTeN37FYW52+Fv?=
 =?us-ascii?Q?NHvzD8eRTK16aKm29pc8qQ7ZrDMZhr396ga0Ae0Q0S49u2vAHS02HQJ9BVFK?=
 =?us-ascii?Q?5wQ85iy9x35o7aQDtXETC2f6QaV1OKWtUJ5nhgXJn1XJ1aymjpMzgB3D79xn?=
 =?us-ascii?Q?eeLYHZzRT5PyZO8mB56S1fWP49fBKOXiFC8RK80oV3kJdgRMUF37mUuTFwFL?=
 =?us-ascii?Q?DUev4ZJ0WPQSBU4PUZg4XOKIxdgRmHus6HaizYn1l5vvI2L7zlUDzCHIPyxz?=
 =?us-ascii?Q?GuBUm788DlV8+JXJAE6MGr1+YrtGTDE8TJolS9aQJqX9UNiFHGxJkLk9Az5W?=
 =?us-ascii?Q?vAN6Vr3O3F2wXtsFWZ0qfkTvhsuMxb/tb6p8zGsnwi2MAJF1DCgEBrC1UesL?=
 =?us-ascii?Q?LkWY3SYSDiXPZwG6F6eM6SeY/uxtrlJOD+dKutxiDW+J3y4GDmkwdTQZ8Vim?=
 =?us-ascii?Q?EkbV4WCUc4xTGjXGVP57aa4qBSYLxJTKOq4ktkqPDeOEibFLp/ZVCcGHt122?=
 =?us-ascii?Q?SFTMejysP9uZw2Lo4eM20UvVnpje0hij?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NnRMOvxhEERsVt3LqphglznDhq7N9q/cbdI/6Q+7gFeQC4y8ychiBGOLIijv?=
 =?us-ascii?Q?i1QMXVQnRiO/xufOL6Hec1yZKXbWpSjcTSpHqcDDaQxFMmPOHuRigynwr0WE?=
 =?us-ascii?Q?G4poz7gjDE218Z7Zc8iigJ+CVL6QliSAsucTbDLtJJodB3TuDo9uh/sv3Mp1?=
 =?us-ascii?Q?NRU9bNqsGgppQk+/bCCsDublvwhBsKLZjcEgdIvoo05Sqj19GsPZt+fp/wRJ?=
 =?us-ascii?Q?hK4r2M8NT49imJS7xnBkdBtRyGJpXAJE0MZexzp5pkq2/LThzmaC9aGq+Ooq?=
 =?us-ascii?Q?DxTZmiBIeFRBSWpzs+9uvGwL7Pd/0z1DwyK1r55z9nd+0fgfK7BF6NSIza2u?=
 =?us-ascii?Q?1DqsVCSs+zdCn78BFKLRIL6daWe/H9HRjxJvmeCpu/TXXc/rGwX3qZ7N9WZX?=
 =?us-ascii?Q?w8O5zRcZRFZ3esPG3PVo7eXx/1DM8K0SPVtu9fAV/VUfg7q9TIWvrD0Um8ts?=
 =?us-ascii?Q?CiS4AjlrIdcbPVkV5mAwo63HRU3/EU/qFB1AvepJvXz5dtBrdZBoblNUnM1d?=
 =?us-ascii?Q?5iH+18zFAiEgJFJYHz8uaE1lHk5LaEEazGIdDkWWJfTFDobsbQdqY9kO3JqF?=
 =?us-ascii?Q?AGQV7NSrOTEhoRJvr0OqpZ4S99r5XwOof0LZ9OPEFqU8n5hMbO2ax1IjMbSA?=
 =?us-ascii?Q?W9vp7t3H/P//nBTZMrrUrQKnF6MMPKzAeWln00fIgXw17cheqXsIHsB23vEL?=
 =?us-ascii?Q?9zhtjZgpB+XfX8XAa+NMMIR5S9IXuIhrDEkA6DMbkEFc3TWL6G7T09F7Fusn?=
 =?us-ascii?Q?GYx2xHb/YDAYkon5lJSfntKl0fzBIhUSvG8tg8tGXYPNk4QUU+zzC+uPwA9v?=
 =?us-ascii?Q?6B3zYHHM+50ZroQCbpefKrMnENYK/42QJCdzAG8C+6mBnuwmsDK3KJEuQ01q?=
 =?us-ascii?Q?XQwLLYq3D4urssCI87+CS3sX6KN/zdaHVWxpVsI+3gNLNUihhQSYngVOm+ba?=
 =?us-ascii?Q?ubfb2L1BtHAzvMomDNj4DOG3pbA3eh/yfmVHuf+0aM/ArJKfgCaFlHGH43Qu?=
 =?us-ascii?Q?R/MO6Vf+M/3H4O1euDTZ74uqooiM5IIo1nc2PLxO7mBo+pChdd7eVUTbEmnu?=
 =?us-ascii?Q?20Ej4rkfjJ7R9RL88+HJ3/oelm+hEmQ9xDT5RJbVfd8ZZDeW4vB8/EYiueg2?=
 =?us-ascii?Q?BRYIK4vayAU++JsuSPH3vb7QYuzUqjB/8s97Gt6yet6X4meuhJ+X7PM9Yuj1?=
 =?us-ascii?Q?j3U9F6TpSgGD4orpbUFwJUauptc8uiJdwwGtPaTOkmd4v9KDmAogVby7p+Kf?=
 =?us-ascii?Q?jppQNGsn54nDrITHNEqpQdmMtO5cMo6dajn4sZMNXKSRdKGNNaVk/Vwn6Fps?=
 =?us-ascii?Q?wGFfeiUpzL9xlwxZ/ZupvLfLYcD4K+dg1fUR9nKIMEDHdAtqaezv8IX6rxSd?=
 =?us-ascii?Q?Apf7FeSvnF0fhyQehxnAYfg877/9giGkMVcCX2ri/bQyJkKOEbueFwrcr3f8?=
 =?us-ascii?Q?BZBQF3AwZN7RH0vpOD/WD1hSf5xw4gPlQnxHG5q3yoZRwid+VFjTB1jEl8pJ?=
 =?us-ascii?Q?Cp8/GUHZilHo1lr4sv8/VSAf5emchZFghIL9hhRy7hDr+rMmSvlifvewgwQW?=
 =?us-ascii?Q?Nv8zgArcmsUmYQ/b3MoqBSt7tWgpy72JXhMXMf0c0t+1ivuQkAWujUMkJNqq?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LqUfsYPREQCuUu66JCARONCP4/o1Dt2pYIzMQyf9iNyArid6dmc38GA5pTFdxdbZyVnzA93ZZQCGOLpPYN4whNN0dG35ijV6bbzS2N+OaezvOTluSwpbqzRs+ohoHkwmt22oGZvLNsULljagWLZ2pFmrF6yHUxeLb9SpETICsGLmpi5CvHukaBMgsY+ZZAY3UOIXochPBM30jFBBlqgHibeMJEZUsDf1cbbgrVI/kMstvNoKSYDvL/HCwcNxqazESA2QS29+Icf8Hkq4VMrkPxeWhDFcJSpXyVfofxSsTa3gWgAC2Ts4vFLfufMWjCfYK4c0s1jpHSi+M8xP9/IGlwQPTQPeP2QlknBgj0knfCte4ovrV2yegxs1u39e5w5nPYSnipqPLqn2RxHMlyyHG6kzYQZPdhfICx3jhmZWyB15GB7Dr9iLJY122unlCUY5uPXlvW4uN1UI+TLRfY5vZ74eDdGa8+7fWTwbBw5XFq1gHJhw3ZfbNo5aOEIbp3aKLlH0ZuVpajbVcjeb34FBNoa8T+RWareGynnZN20LQO0MQBs+anH01cAt+3Kp+EFJXvI15LCfvnTJpMgOHm1emh0HVcVpuN3/q4Dq6IOgAjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a4aa4f-ea71-4e87-f1fa-08de15e34b71
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:50.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kARnN1+O0qxupCIBaue8rWqK6IhnQYcpZGgA1YMd8R1CCaUa4eMxvZGR6Opezy3SklY3jauAyc18pasj6lyyPoo9GcGRxKS3CWmMvk8ZSBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280046
X-Proofpoint-ORIG-GUID: 6EEEB7B0-Zoit6LG4pxTOfKduuihu6R3
X-Proofpoint-GUID: 6EEEB7B0-Zoit6LG4pxTOfKduuihu6R3
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=6900554a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=_t6Qa8hZe8VChzH1jgAA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfX5UsQULvmczS4
 GnUhSH2LVd/PmfvVUl9+6l3gHl4XD6KHMXtZ1dbqOYjR9IeyIy/ydouyQyX/s1cztdeewDPFSQO
 YAspcG4ylHvtAb1d/d1FJbSbQaLg1NFfemvpYcMVNjn2XSk54aKUJDHNy3E4K1wCyJsGWojp710
 wU5Ue2iO8OwYfw+rP0tEBQaionNzmE4bxn7E+622YjCNkSK9OWHZG3LzoksErnXn7qI+Q7EMeeK
 etbjjQ8UclYBQtA1gqvyeTyGlU7PTjbAPDSLJVIiuyE/+iivZNXsGkHn+ZObq9soRrcSwdjP95+
 jM7Cfwrh9lXzsVtnwpjr351de9R/iK5MUfBLEoTQZVbGm5G5wuPHtFQ+JvHfpaQ+2ok7ruY3M0F
 FfNBetiLVL/fpLBd5PGnO8a0j9W6BA==

Add the acquire variant of smp_cond_load_relaxed_timeout(). This
reuses the relaxed variant, with an additional LOAD->LOAD
ordering.

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
 include/asm-generic/barrier.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 0063b46ec065..9a218f558c5c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -314,6 +314,28 @@ do {									\
 })
 #endif
 
+/**
+ * smp_cond_load_acquire_timeout() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ *
+ * Arguments: same as smp_cond_load_relaxed_timeout().
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timeout
+#define smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timeout(ptr, cond_expr,		\
+					      time_check_expr);		\
+									\
+	/* Depends on the control dependency of the wait above. */	\
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


