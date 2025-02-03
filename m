Return-Path: <linux-arch+bounces-9979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05EA2660F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C975C1885785
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 21:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B0210F5B;
	Mon,  3 Feb 2025 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C7RzcQ4Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NucIihWu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6729F211269;
	Mon,  3 Feb 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619385; cv=fail; b=roLqrprr3R/KFpfkhbmigZezTmdRiozvWS0DrlbhmGsDjXCTlSFLsDFawAX7ClFigRGRZ6SGS+//Sh3LMfu5L4pjswR56j9PtzfuGbRBFNk0YKC0RBVpwejfpXNqSjR/qKtUo1tkZ6qTfISoy4hcwniNDQ4JFnsUtu3ffUsx5Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619385; c=relaxed/simple;
	bh=Gjkj6DMdM2kgmwPtO93LrPzvxEzqSbUL4tw0BkWeIho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b7Gssab9plEktcVrway6pEi/Wdj0wlzQmqdnYpOL5XOTZlHJkRF8I80WUyNR0F+zT8+QUl2OAeypkOAPOlICzsZLjW/pX8w/ovoxDVKFlGdmgqdbHgFP6UZTXHQCTbkITntCV0YmlkmoHQeKvKEtV7a1Q5qG5E7KZObGzJuLq4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C7RzcQ4Z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NucIihWu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMrXB001197;
	Mon, 3 Feb 2025 21:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oW0tJTRh4YPdx5OOsb4s6vVe/A3u1PZOPg3NHKdRyws=; b=
	C7RzcQ4ZxvGT5Dl9JlWdI4duMQ1EsAnJatUJb6Z6YCwTsaK2powS7Ncb2dhQkLH0
	L0T6TOT1PVZDsyfE+4IKFv9VXP/SpXofNJkITqNtvn/QxB7Hwk2LLOvIUo9POoXC
	O+PjhKSwpvgmOAy7/XyxK4xPk7UOOBLZUSzPUdAhMeHlfwTaZjg7PVj6+7pN3WbJ
	pwkZdduQaGcmnaThqHsMm4xIAq0aGIg5rtyUoPHdP+zNI6eXK5w+WOXAjvie1/yC
	9FGJQO0fDfCW0TjdxpBiZMzrvF0j4mSMVyXdMDNBK1t3rzNUtBDtVQKoFGqfDgDn
	9qQdCoqHVCQp7782x7BNeQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hj7uukrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513LW2L8037710;
	Mon, 3 Feb 2025 21:49:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8gg6h0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNt9GRRMSAu0/cD1m+MgbJwEdmrJUzB6logGcUd5TdcXt0FtdO7IeINXv62IdvigsdoNYgQlDVNRFWAUbQyWH7n8K5L7lR3pBtu2PCc2HaJleic1DiSmTPMMoGYh9RfsOOzQ/V9QxWe6R8hfUv/iM9LZojSjpi9Wayr5Rk+TkH2ZWUkj5x6wvQrXPpKaqX3NLXkqBp829zlsofXHC3nAcIgCxWNwK2UW6zwMEorI2BelbZybnN0NNMwvuObF7MUYOZ/QsMdIIR357miRM0eP4qPI9Q3ajLz8JtRAQbVY0KUCaQ6Cltrg5Q7T9LA+ApBp/8hbtaLN4lBonaU2owbJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW0tJTRh4YPdx5OOsb4s6vVe/A3u1PZOPg3NHKdRyws=;
 b=lsR7X0YAVqbtE+jSaq/17sAXhRb/Xtl8ubvOlQJkr/Jsfn0sv+MKqpw2JeDJvNXhW+qaVq+/kgCtaEhU+aGwW1BHlSM+gFlOjOwUcdycHLLL3lFbTuR3tkmhbfdRU9+zXDzEpdOq4nhpneA+/tE3QaZbeC9CCJZh5H7vYU1Xme+QtfzDWaUTIKoT1UP4OrNEhAA2YJ5PXrdl0PD958bv0Q1SReZG6pZHJIrjfouUeKj/vRZTnU0oeqiqmIlBX16g2VPIovo1+YPAvizdvg1I6KF7OH2+pevKoKkT7IslTAOkPl0SKpv3K68VQIiN6sYD15DsHek9ugynOT1Hwwdiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW0tJTRh4YPdx5OOsb4s6vVe/A3u1PZOPg3NHKdRyws=;
 b=NucIihWuEU/1LFHxliblzUWTYCjxjKLloC4OFSUkn24QRtbKSGWF76UETSvhvniCt5s3Gdd30pFYnvgiAicVQdUCWwVb1jNQ4z1S5pTF/O0r6yWGp4v3XS7efaiBfbo7B+2GAzWvTwbcyV9lcsLOs82pFvE54yggle5KpQpmTkM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:49:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 21:49:22 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 3/4] arm64: barrier: Add smp_cond_load_relaxed_timewait()
Date: Mon,  3 Feb 2025 13:49:10 -0800
Message-Id: <20250203214911.898276-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250203214911.898276-1-ankur.a.arora@oracle.com>
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 1249a418-0af9-4125-79b8-08dd449c9e7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LEb79jh55bU9csp+0O7GmKzc23U4UxqGpZYBQMqBaXwAGROtc1sAQr3yi4+q?=
 =?us-ascii?Q?cOM95l8sdefSE/1d+VEQ76GmQsCYUSWbp0H1Uast+nsBIRr6xQT4/YwsNCK0?=
 =?us-ascii?Q?n4PqWBAbjAJVZC9Du+lTNQs2NiylPapOHRshg3o82sYZJ7JFiv3buJhkE3wo?=
 =?us-ascii?Q?hcAecraNWh7Srnh05N/9kmrpFwB3kiRAI2dCioCDK4xiiBd2GN+1MTswcqbT?=
 =?us-ascii?Q?ZF0vDL26DeKbU4yIy4rwo0YP4LnDcC8mdTpzNzj8UktQkdaeXqsAXPXiKaOP?=
 =?us-ascii?Q?LqBp/IXaBrE3axuy1fIkWagoOubmROXXTtxSXmmqUEIMoUXjARBzCBIT3e94?=
 =?us-ascii?Q?vCr3zDklcl/eUsnjfaMtL02HvzipF7b8IJYn1OaPgjeX4kaXEMNdi5nx29SX?=
 =?us-ascii?Q?2Od9jPsmZcngFt3XnRGOnBgG0fnqcTdNL8UYC1b6WdkH17tS/YhrWmyYIKjL?=
 =?us-ascii?Q?S8qmrTUAgL9iIrVmy1+o720rYlW8ev1xYQBRxdEceo+WnOcKKcIRyaEyM6XW?=
 =?us-ascii?Q?zCEOdoBnb45zF44x/6OWqWhusQ4dXTHgZhl33SCE6DuDJqLPG1+wVcOusKhp?=
 =?us-ascii?Q?CcWpVdCu3oL78SFzwON1QOmAyvTqWfeFV5JyOvUbaSXIvd9IdfPPwHnY6AMq?=
 =?us-ascii?Q?bWbudQuz9rupIPEEE0BHGdF+AIlMLTAjKYwsKy2NhSfZ1w+cRZamU1DRCUXv?=
 =?us-ascii?Q?e1rz3vyUYfUOvQQDGZV9z1Lu9FnNo5zZuJuL1FzVFFP6sTRzrnIsym6W9jID?=
 =?us-ascii?Q?mMFXw2steGus7yCZH26uuLjtSqkI5fRR/47zfoyn+uzybUR/yM7g4nQuO1U/?=
 =?us-ascii?Q?WpcvZ041UIfZUahzyscnchMzrCVhXQXu/tWQQLO2RcOcCknOTH/DLc4rHBiE?=
 =?us-ascii?Q?g/6keJ8ikzBHkFtzIBD5lhVeIOfaYPVn8y47mEVhrGYs9XpR7OXckKrGa6gs?=
 =?us-ascii?Q?T0FD65pA9KG50rtD93/td6g4cv6DSIvserzbPkt0j6KVPNv1Fk0ktL8Er97L?=
 =?us-ascii?Q?H74Hd5p4LPgPOJkON1YbH/LpPeeUAOWUpKHbAtbDtoNwWvA86uyAGkqheOjC?=
 =?us-ascii?Q?gQj+B07I2pEsCEjbxADdplFsKJLoHWivNLRfIKfz0DIMjLQC+Snw4KwTNVKM?=
 =?us-ascii?Q?cYn5qgl6uhisNZmH71WEJpAeapURQtA/2up7PpPa1FQCq1WZ2v/1AFZBwwKy?=
 =?us-ascii?Q?2d+u5PIXk7H6TnMHITS1W9cKdoxz6nFkLq+zj1ygS3lzIUHMlO5PK1imdnin?=
 =?us-ascii?Q?dFLPbfGHHpX70M40vGcG8usroqAlU6QkvbaNYmrnfZqw6cyM8bU8TNUtWUYp?=
 =?us-ascii?Q?ponbnlcOzeNHJK/uusP1voiDqFDtUDElkp69IA3Gvi71kyfq+PB67fMNtGSZ?=
 =?us-ascii?Q?TQKupGUQMAwCx79/AGqG5ttde7AG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c2BZPlxy0S8A01uPAjb1BBi0v5YXoJwN034ZfVodsxckz1SKmG+saKh679oK?=
 =?us-ascii?Q?3ce25jvrEYIhtVTxNpTzKyiJuIJQNzxw60ceDb/NjgGaKDDnYTTBLkSNLtee?=
 =?us-ascii?Q?KoLLATPdDrl26cm/dwYVDxWVgWgo1Jx0cz/8srSnk3rRPPIJQ0vOaOvVCQpf?=
 =?us-ascii?Q?Lr/036y1s/LJOxg3j0su9RD77wkXca1zEoPtejkXB7ndYNb3w0OqKHMlbo/S?=
 =?us-ascii?Q?GYl7ohQrO8SJXxhAu0SZBw6h8clMO6QIbL2iCL8GPPTaAOVxrumgckWrnfPy?=
 =?us-ascii?Q?gifdN338DFOT3QTugBmcnjl1Rc5h2KYt5QIFL4n/npgjUYnJT2ldfYx2rynR?=
 =?us-ascii?Q?HBk1i3RQAbO0VpxHEumIivbmOKK8Bx+yg4NxmiEbB7DqFabg14z2n+Bp7fsc?=
 =?us-ascii?Q?syhunqt+J9qC4Y/PQ1J72x3ECoqBrlavkwndkXN1h7+yx/8XVoAj3KHPFSby?=
 =?us-ascii?Q?PtGbLk020SCi6goD07ATFnntG5MRPQaBeJcth4Lzj8R8B2rOZPV2ekhPqpR2?=
 =?us-ascii?Q?u40qlFKsLcohUksqeDgVJnzccsBNqTSBPRuP5tGSUqyFjBAEqvdNeCzi/5xz?=
 =?us-ascii?Q?cmj9nTZ4F0ol9VgQLvscAJQ8WDpwQ/tsGnGexlBhSA3nW4jOQ87z1+7qHQzy?=
 =?us-ascii?Q?jHU22BbdjNdNR+2qn/N4T+EgK2T2ly0ivMQVd8uacsQ3+Q6EKXqI/eM+Mrxd?=
 =?us-ascii?Q?2cQAZTwsnkoum1WTR4GWiwP7JQAaWooOIeCi6C8FSB7vQ5q7VVMu+WABEflM?=
 =?us-ascii?Q?WhBmfJLX/cu2ojQk8Vvby50XZFO8/sZfhqokYxmxvN0+g7VHmnQiMmUZca+N?=
 =?us-ascii?Q?m/hcVEjsPW8+qFQftQY7Ofe1/+Yftv9NaczWXVoig7rkio1n2Wm6L3Vp99Rz?=
 =?us-ascii?Q?u47GBVz0FhelqKoNfTBFTD8xKs52ZTJrw1WMs8Cdq7P0Nt2K8pskdlGM5EFq?=
 =?us-ascii?Q?MPipkg5tyKOR6TU0vjRJmleJ7GWahnJWYH1OP1Y8cr1EnjyZJheRu8oYkVYF?=
 =?us-ascii?Q?APRUPolSj3C5QIeeI2MuRPmYHBl/8BJ4KXZuUkFJxQHvy1mN2q9WBbQT1Cxf?=
 =?us-ascii?Q?M6PcI6MoFvKWpUAYP8R1wGJFSqyDSKN5/LESdKP8z3z4QtniocBA8C23qt4+?=
 =?us-ascii?Q?D8PurNQlTMtXJb8DeiFvhZC0K9HtXxXbJbE5rszG23IKfjPVB1OpJHksDC8P?=
 =?us-ascii?Q?xE9qZI9Kv+YGsXdEzHKZ8JOr/Crqra1Fo3DJqitcYgOqcSHN/4wVU4Y2oRBB?=
 =?us-ascii?Q?vTaCiIL/1FQtmL1vugO2FNTK8AmrJjl90tzqCd5+wJKH56TCJt5Dg4DOih8B?=
 =?us-ascii?Q?vvVgqIT+tlbIfA8cUDWGYuaXPqqhna21rPIOEByBI4wBafWkG9EnMu7cgTAY?=
 =?us-ascii?Q?tTdgHB66UwrkMv9Q4CEVHkfLP9CKwa2/juNHW6c40jKeEnQDV88cQOw7n3SD?=
 =?us-ascii?Q?mzNqfKRjwWyXUyMPJoV7b5pqqwFQZQ1CtOwZ4hK4x0c1ckVs6p9aWWySAjgD?=
 =?us-ascii?Q?DdLjQW9DoIvFBqyXHJzvGvxCIx/fcKz7TD99GL/NEs1ORFKgpcM02QT4fjJn?=
 =?us-ascii?Q?QNs7DHljbbdJx38bjGXTvvFxsHwLDpaf1nNjoW8gE2Ee0y8Fu9XAkUG/2JoC?=
 =?us-ascii?Q?wA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ekJqXnnA1oN4Cjcl+bUGFxWy091CQGav5L0BGPIPLL4k74+BXklCxpbK6Lv0IWnCdKtCrZWwanTm8V3GEeCQVqRUeO/ddTZMmc1QJkub1V8Pd5q3WmmozsvELRwBMlIf7qBk/83sPpXGfXJLPnR8H0JYc10dAdwKiv+6PiQNa+g0w5U5rbapQ+wO/RdWjWUhLhLrTwO1+1vKxZYK7Ezc+S2THJETNgB7LatYxcu671wQiOYvdr4R+Z+ZgztFrZ3jHbXVMr4G1+TQQZvTxVh1jPP7VWLaNjrIyrGQWsBVgZZvMYwTQgNNa9t1RG1E9wOmCMPHHlQlqamTusNw0Y6ApmzvxgQ6KSBDLNbzly71iFPCeAJL+n95Hi0XffL4ZwsgA4cP80Lkwp9dL8jSN5VdWlE+hywHOYK2QLcGOR74zp99vem5her434g7ztnuAjvKj6HR9xRrNs6P/DXb1W7lnprsJEayeKdRKwPgZQmfn5QO7sgj3TvOodz3p6NdpEatFOFKo4G2WJkr1PIZVHgUVoLAoZHoyJfUNd5BV/J8enx8g8fHJaJrEwz876OfGXV3Ak4nsUx8ELo31IpTLth9xg2nN5dgNE0yE5Ds1Q8mUk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1249a418-0af9-4125-79b8-08dd449c9e7c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:49:22.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Y5qc5nndi9oGTeqWQze1WWfxLYh312dpbAuyd2epcTiiEtPOHasfkJYnyJR7LhJMMHMlcvlMZiqpFne2pRKE7ilUIgfn5ul9UJEtcFGh9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030158
X-Proofpoint-ORIG-GUID: _712IK0Fd7LlMSaCycNcbFIiKGTPDZtG
X-Proofpoint-GUID: _712IK0Fd7LlMSaCycNcbFIiKGTPDZtG

Add smp_cond_load_relaxed_timewait(), a timed variant of
smp_cond_load_relaxed().

This uses __cmpwait_relaxed() to do the actual waiting, with the
event-stream guaranteeing that we wake up from WFE periodically
and not block forever in case there are no stores to the cacheline.

For cases when the event-stream is unavailable, fallback to the
generic spin-wait implementation.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 38 ++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1ca947d5c939..25721275a5a2 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -216,6 +216,44 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+#define __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
+					 time_expr_ns, time_limit_ns)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_relaxed(__PTR, VAL);				\
+		if ((time_expr_ns) >= (time_limit_ns))			\
+			break;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+/*
+ * For the unlikely case that the event-stream is unavailable,
+ * ward off the possibility of waiting forever by falling back
+ * to the generic spin-wait.
+ */
+#define smp_cond_load_relaxed_timewait(ptr, cond_expr,			\
+				       time_expr_ns, time_limit_ns)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	int __wfe = arch_timer_evtstrm_available();			\
+									\
+	if (likely(__wfe))						\
+		_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,	\
+							time_expr_ns,	\
+							time_limit_ns);	\
+	else								\
+		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
+							time_expr_ns,	\
+							time_limit_ns);	\
+	(typeof(*ptr))_val;						\
+})
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


