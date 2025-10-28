Return-Path: <linux-arch+bounces-14362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3AC12F0D
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC5E1AA468E
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A261D5CFB;
	Tue, 28 Oct 2025 05:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+R+xbF7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0IPTVQ8L"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A611713;
	Tue, 28 Oct 2025 05:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629537; cv=fail; b=sL+9/DJ6DVRNZd7NVntGSRLfqDI1nZRUwyQ5LmxSHJ6q/DrDE98PZxmCP+ZM3kqR576LibTWm59czhRHlOvQOfCg1FsYbTkNTFqx2ixjifQHT2m+sjZX8Gd5MSzaXtuu7Us90nTnjyFmcHfP8cHaDeJ7j9ap6CpbiR5zBU8vqws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629537; c=relaxed/simple;
	bh=j2Xw/i9vkTOLP3GnCkIuGxui5rJdDWwAR/E6zMDTBl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nNu60rhGAQvcf8kBVZmuukuYDE8b/67YJyQvL6KeHWGXXeQdD6DRubNhBYu5GUssAQkk+qudJTybn3di7pceZ1FUyyOFvnDLn/eEBdy9+q1lYFAqw6Bn1IqEA6ciwM5NNwPtytezOTlxuPOyTH4WfrIbwAIHlcpyWZPePRYsFPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+R+xbF7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0IPTVQ8L; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NjDj010646;
	Tue, 28 Oct 2025 05:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=; b=
	d+R+xbF7qFa6EagJsHoWC902L0dmwhv7Pmy9rrTcVk/I//DDyd6XR8kQ7JYLDU80
	F4LjFuTVTbpycl1LsU/eJdGgovTzH5d9Z1oECS8WdLQMep36FzP3zyhQr+BdXgF/
	+jtJ1XxQhsPh6vLGnCSNqIrtV2IP3YlXB7/v1RKGz3bN8DxWyMs23nWvsrJ4sE2e
	vKROylP9VgB97Di2gj4adMBzlM6GvFauYgZfDaIhRGqr6Cc/6sQI6UHaVYggWqn0
	U12p5/Pky4X0xGTwZZV5VIswXsDGogX5eq4lAgm6ZxtK2T+cpoIdgypR5P4980HG
	MK2ZzFzYkTdN90dV8HNS0Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a22uuakdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S2iEDn034916;
	Tue, 28 Oct 2025 05:31:45 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pf3qn1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woKVcPAyZTaMLDeyYk4I9JvMxf951cC9HT10PjRkZhMPcWn23BPPx8HnS06owoJe7n3TkCSfFJn/V3oE/DOGECvLHnIM/U4GQctOIQF/PKuy+4g0TxfleXYyDDRJIR6Hm3oDW/Yns9Edk/32QoKJbtJVlE21bdSc/UGehcfKJU7ks1F1N0bt1ooHL/tOxKsonDn0Subjc/hijJdXLKr6Jty7WTXJfb+3KaJmUdvampEdRgcaxZ8Mzh1Nd5cwdLY4E2fVn7WuGppV4Crp4mfScEecDx+Yl/2v0V/qHa6D7kTVyqtM3aEbqyxfteecSbj3hmmexX/3Xryrk9TieQbmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=;
 b=Um3d5IX60Jxbb2HYsbNC1ATfdnYu7EgdBkwGvMm51yKBKaCkMjxXp7oQOmkC7qVpJ0J90svOVsQL27RN+Ze1cojr+T2839n0tFk4/0dmrb4yi2TJkOGF3TbSXR4i9XuOjdyW4y83/YeL9ziiswNsalqDHS299c9cHnMc2OBF2SlsbyrWnEhSPIwjew21nd9rET/LWhfURHvD5d1tIYAeoDay4UVYSKuyHE0gDpx9MdHoGGYqQJ11toO8x0D+eDX63hKnSJCe/t1IWY/xUs9uZlAJ+Xqu2YtoO3rqXTmngRO2RvyiKn4VKpJcBb1Hg6Lrasln/ybdqfrOHaWRcUcngw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=;
 b=0IPTVQ8LvQaycKoYmQ94YPsNqOy54mgUPImvXmX+iFzB/Pzjkoc6CEjRhyZBn1DgacxKLV+6AuJERwhq+lYUVBYSmQBRgiO6LEPDHCxLLJoxBGdjzfD4O84ZpX1k7i3Uz/umTkVFEEEna+v+BQ0YX4KHGLmEwemrjzLiIUS0iLs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:31:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:41 +0000
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
Subject: [RESEND PATCH v7 1/7] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Mon, 27 Oct 2025 22:31:30 -0700
Message-Id: <20251028053136.692462-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251028053136.692462-1-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:303:dc::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 509f64d6-e98c-444b-0cc1-08de15e345dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpJHUn3YQmUjEk7dBQtfOqhfY/VNzcwlmqlo2Q0x8je8bGSJ1u4ac3OovIzg?=
 =?us-ascii?Q?8IlaGUc2hO57tuUjjNEHlNrSb9gCFerIRN+AVJbgz5Toz4sYWrPBYPaZ81I6?=
 =?us-ascii?Q?5yw9wCWPmMvhcBjYE5d9DgKNoYElrugEim3hx4rNVXvC+xJI7Bw3F3LArzF3?=
 =?us-ascii?Q?ckIArLADWQBEzw2ppfUv7V0ruW/CnyVaDnntsiYjz8HGTfXeX3+XqnAKCp0T?=
 =?us-ascii?Q?lqlJz5OLsCF1sTgJmOKl70g1AUieMQSniOFv+srIpQZrPZ3XAhYZvsK3Epci?=
 =?us-ascii?Q?4fOJGehtrQk1AYROJnx6fYjaC/EVM0j3NUX2Ne7O1cUY7Y2uKdx5Ojo0bzM3?=
 =?us-ascii?Q?zIx3SKq5JnJK4Mtzp8ZAKpbOjsU7yaqCsWB9eU6ejOXOV4MhT3wnhDurGy8+?=
 =?us-ascii?Q?35OX5sE7xERLCA4a9qqvvFjoYcmAzhKMrirnlMPZit9v0YqUX/FnhEK2mj1N?=
 =?us-ascii?Q?iAdzn0hL5OOa7xFQ0c+1SJj3Zf5dH2YJvtqhIWaudemmbazyJPsv1qxpQOGM?=
 =?us-ascii?Q?+Mvety5gC0+V2a8q2/UwTc/sWrZT1UjTiwLYY3SMgbRqDAjEaRc4kJLXzSmY?=
 =?us-ascii?Q?Cs9trrtyfRqrYvLH7bqikzdgvQmRG5QUNlQteIQj04sssjyEEgq6UbZ1j24E?=
 =?us-ascii?Q?qW1hrgds51dhSucjTshZAw3B9rQyCl+7bup9pkii7hvfw7wnYnn1kev1ZDVx?=
 =?us-ascii?Q?8QY1gGv8cLGX7OfBS33WzmtP1gF/zqAm0e3bAupJYUdOiYHfgnCmsyJSL7wz?=
 =?us-ascii?Q?fIMx40CqR3pBuTOaKSNulBvM51ZESWuzr+L8q/o9XZoOeoqQTlyZmckdDhHU?=
 =?us-ascii?Q?dtAAHWvOr4nZCZdJAt6cu6daFsCfJdrAex+JguDjhbUzMa7jyZ2AfFI6SmMt?=
 =?us-ascii?Q?lEQLFFc+1NNDaibgYKmnS6BXk4Gc7gtnDpw4ig5Zige5+a5Hjvbcvtf6rawN?=
 =?us-ascii?Q?h9gcKfJ4IFSnIo52dqtb6U/gtxpe5ORnDRYSyLE8rhW0F4VG8offfCemvSNv?=
 =?us-ascii?Q?uZWmqBoJN0dAxe9T3RKsEIGUYJXYdhkLqJL9mTZRe8GvwXyGUVMImpMIKKYE?=
 =?us-ascii?Q?tHIi+k4AIxuW6ah8l+FPRF3tWqqyb5rl2Dw3sBs4Ysg7HlTv6mt8UxrXSE7f?=
 =?us-ascii?Q?/naoZlu27wlUHiNJmxfgeyYXXdeBNA3lwhNypVnaw1QgdrF0aNoMGVp1tiWD?=
 =?us-ascii?Q?tpF+8u3GbbKvQipkutqv3Ef1k3ueqFyYQb6SEL+nrncmU/abwX5M9rxCPLbR?=
 =?us-ascii?Q?OMlDgKMdqM7H6TKlFAuqTYz/SlKhn7BSN0J8ZN51llaCuVPRWj6/CZcACbVe?=
 =?us-ascii?Q?0Ru+P8rQ3srab7NUa0B6xSMk310LgpBkScCRdMQVmwBAH5ugpxQQSM13lPVp?=
 =?us-ascii?Q?NNN+w6jEvrb+LDSzrJj0WdgmQQkaRV42LBo3QeQt1y7sPah80pdQFUmKUnTQ?=
 =?us-ascii?Q?wpwPeSb3L/oaSwxd4JmttLhfIow/I08L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C1kTL4OlJ3ntkn/8ecDrTvN8+LxA+UsczETwb89/ktTrJipGeNJTnc6VpZvD?=
 =?us-ascii?Q?3pPtRkLiLj6xHGAwrU4/pXECatce3uLYNTrBFFxLl40XNdnTY67n4XheGn5V?=
 =?us-ascii?Q?Tx/grZEVArV+1twvPwzuTkt5VfNoOHqVSwcQM47vcJyZE1ybv1ddRRAKHSTH?=
 =?us-ascii?Q?s+Q9EkpXm/nri4KjxA9L6dvo0Uk5yuS2ONUkANVsZPkzuHanysh+Su8FqBDT?=
 =?us-ascii?Q?D7XFsoXPTXdDKE6L9pSII8r0Ic0AnceYID5Fudl4Jk213X3rskqoIxxPJH1n?=
 =?us-ascii?Q?ELLDSlJQKivD1gUMhHbFQ1N8saJDMMKKNN6r0AIx6QYWdzao4qLR00f8aujz?=
 =?us-ascii?Q?/PRUCayvMDlR0q9XeR4/SN3zZtaku2u6SoGVd9HQvVFdZ0XscNIHUsSZjhK2?=
 =?us-ascii?Q?BxvxmHM8sp5P3kt+GydGUnMLjAOkuoUVtg0zusx+4x6EIZdXyn06s1fxX/dw?=
 =?us-ascii?Q?f8YlCDL2RNmz/VYIDoooLn1Kx7hbQq+lQtPN0JkUhVUSLBAGxSw0EVCd9E8c?=
 =?us-ascii?Q?aK8mXTKkxJn6fWjpUevGq53RPhmYP4ZAk9v6VE0DcdkHkV0p0tzvIzOwavrO?=
 =?us-ascii?Q?Cuz7hPL5fBQUVEYUtQcPdeidxtoK4IRlck3O2ZP7QVfep+/ao1BLpbsUz7x9?=
 =?us-ascii?Q?3vLrOZ+N0DpmkQN3KYsMuGwMFSQUqEgpODWjANjv5/5A2WKeWEumISuZ2tO3?=
 =?us-ascii?Q?6cCZAgwoqm+IzyGexg1Xdbzj5B83hBWSH3q6/t28psicZjWKJC5ec2a4sipi?=
 =?us-ascii?Q?45/QyxJ+nQRuLmjZKiaPKdGxP/3kFt/FM0AqNnVTsb+921B15qbtCnR5zcTM?=
 =?us-ascii?Q?FW8nd/VS6QkCuVVKk52DKAacznubLVqc+mAhKSmoI8DHIBvXMb3DvYX6QRaR?=
 =?us-ascii?Q?ovvjYK15e2Ix8aP0iWHkukouMC7Lli07kohxJ/BCBNuPyNbE3g+Ed37MOhPB?=
 =?us-ascii?Q?JjoBsVJLS3Yjo0bNJzZZvSkvVL1yDFZDfcYTh17goYl8Zpmp7hYBiwkY2xVY?=
 =?us-ascii?Q?Wy+I0T6vK8MrmY4vJ5yjBkBHu+KHxA+tA72jPyjluxpahIzpXonpZDcjdGby?=
 =?us-ascii?Q?tdG8Z/hnQGeWq8VoO9JnjqiHc8efyuekGcxcJ87Vyzn+umItojUTeWcIg2hN?=
 =?us-ascii?Q?3U543Aw+vPUJQl1LtUrd0CkXpoqATDTz2jhsfC2SQHNno+OpvPbrOdmglqsa?=
 =?us-ascii?Q?Tn55OJ2puJNXBL3RovoT+2aBPUNftMgPWksFeqcb0W1cMBUwlY3MRQNbFx84?=
 =?us-ascii?Q?PF7z72Y/3ygcTWVkOtCjtd/Rrtliwd2VgRYgy65Svh9sfyFNIVkiEj8R0/v+?=
 =?us-ascii?Q?L7EXzY7r06TIG8RQOC75MgPWk92hd04PbnuADAU5ryRgdaKUT0alBOmjtAFG?=
 =?us-ascii?Q?z7hHiwn6/3zJMfWuX6TxUgZxyU5ANhaDfB92XFtY4rfOCeSpAyAsopNZS7Qj?=
 =?us-ascii?Q?eQcR4+OY0/GQPgxK2v8qfXm/qsGDp3ZwydU1Njc+ZvqUmSIERSpP30qGYet2?=
 =?us-ascii?Q?jCT+RZ8vl/YaIsIoHMUosK1Q9X1K/NC9zceqcnZDi1a9rY0CCtURfwL31f9T?=
 =?us-ascii?Q?KEUKlgh0ewk9egnFbKvz8VJav1J41Yw9Id3ZPJyJi5UUU2hMFT9UhI+98b9t?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mqVLNnaQPniD/gW+dUrIKzwoZ12pNkZ6Kjx0bTITYiavwq9ScOWl/vkFlF/yXtF9OpDgG13pwjZrk9Lk2rZJil5R0YDLFWt6GqD/OgRsVOgbdEdQPUpyPBIWs9Vfaxq7X7PzMOYAAF5M5yJiDMBieXJBKXm6TuySvUokNIPa+LQU3lHJXMfXA2Ptthho72VOxwO7xYR3E7MRVt6c1xFfNo9Dw3botP6HP+Vkp2Iw2ChsIa3UlD2kN+rAFQ/1lDnz5r45ut9nm1c9b/n0G0KM2qIHJGlcn8+SF/vCt+W8EbUO2whnJ0zvP2bnlH88FO4a0FojA3lE0D688Uf33wTQ82bAtIRQHeQxm290R/AH0CU9VNdipqFx+PsmWpwT6SdHJyfw8eQv4MFbFfMvB2c8HXGBCXlhQ9LO982O+tuvsKeFwKp3XgSLg+EdAvB+UWAieWfq9k8Pw0gCPizWNYtab8AYKqRebTD9ecDqZ/xkrSmvPjEsdjfYt/51TAILUTH30+/rsCmGlm8VCDTCw6ITweAClPG+TZaZ+xvp2Ak+XhgZi/nvuSz487pkm1kWfasgHByEcr1vdDuhj6h/0oekh3MVzW1nHnr/+/iGpRyNWcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509f64d6-e98c-444b-0cc1-08de15e345dc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:41.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyw1geZ1qSCtgmf9TRr9HLGBtQajNfgrReJEYqHVosNH2xzB12loBTF39s1tjsyQoqlw6G87dRy5KSVrs+Zb4z6jH1tK7KdzyaG/0eXb2kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280046
X-Proofpoint-GUID: qRobeT3d8lRz8evYh_n0LDCeIt160z7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MSBTYWx0ZWRfXy2ZDAtNp92Zl
 LBkIb9+oLRUx7yJ37GmJl+xpABQ7mF2hWdDOE2Dr1HWObf9WZKzSX/O8RJNo84dxhc3qr0tOUCD
 N2bkCpK79NunCOUrLH9A9/l2mP24qxMvEBcpB8ZHn3gSK0CAHtpZy1Huqx0SsOo9La9MgBSNjgA
 ydERg0yfcaMr+xUIp8WJ2J0J8m67yY+yC0IFlMg1zh9Sfut1QSoeCY8tYMGz8zhfJb+gZYatIGs
 vUXJhogcWYGrHZpC7x4xYz32FlOW+bQ4j7NaUdZ9PR8emPOP32mCmsnDi5tFac0oaHk8vNNWAWg
 KC4F2vhGnlqdpu7QjCITHIjJrEcI4iqyBTwAuvKP7oaygl7XJ6myjgsRcT3hdgH48VibtG4d1bl
 83ZLGMzBnyDhhBVTjyDNz1MVyOVAXE+Btnhro/bi60F/LTXZoj4=
X-Authority-Analysis: v=2.4 cv=Xe+EDY55 c=1 sm=1 tr=0 ts=69005542 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=tAfxz9XjlOImCDDYAN4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12124
X-Proofpoint-ORIG-GUID: qRobeT3d8lRz8evYh_n0LDCeIt160z7q

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

The waiting loop uses cpu_poll_relax() to wait on the condition
variable with a periodic evaluation of a time-check.

cpu_poll_relax() unless overridden by the arch code, amounts to
a cpu_relax().

The number of times we spin is defined by SMP_TIMEOUT_POLL_COUNT
(chosen to be 200 by default) which, assuming each cpu_poll_relax()
iteration takes around 20-30 cycles (measured on a variety of x86
platforms), for a total of ~4000-6000 cycles.

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
 include/asm-generic/barrier.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..0063b46ec065 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,47 @@ do {									\
 })
 #endif
 
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_check_expr: expression to decide when to bail out
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL);				\
+		if (++__n < __spin)					\
+			continue;					\
+		if (time_check_expr) {					\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


