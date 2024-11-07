Return-Path: <linux-arch+bounces-8892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 862349C0E63
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45861C21089
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4BA217313;
	Thu,  7 Nov 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KiV+60nF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y2mn5WBp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC6366;
	Thu,  7 Nov 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006559; cv=fail; b=Ji+bLM5hyePrhh7xOsNK6nhJMnn7G+G4oDe4xqOAULDdrw5+PKTK7iZ4jLpvHDSwiaY5+tzzzLuCYCy9YZdimuEvpvyDjRIWs/1MhXEtsIBLGaWwQHPIABp0fBW+BZwTbuN1FBeKmrRx2j9rTkCjDB8Sb/MSar5cuHA5fBSYhNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006559; c=relaxed/simple;
	bh=pjFZT0fb/gVn3I7dwMz3S9F9Z+DaEFtVfi7oVA/DSlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqVcLI0uWeH3kjG78fnHgqk5KIXSCAsZMUr8iNf4ST1x3KcFWSpA06LJ8tVhLBr5tcRzi85xdWZM+TXYe56XhwG1tR+65Ms4kxNbzyREnrtm7M3lUKP4WT+1EKXYCS+nucySQt+e2IDelbpnhwc9S5Cs3ktrEse1x8n05/pXJLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KiV+60nF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y2mn5WBp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBfMQ029239;
	Thu, 7 Nov 2024 19:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SXIK4lyZNeGwltLFKkc++ba2e94bN0lRjiyisxGBoFo=; b=
	KiV+60nFQb8TomZQHsqbvBMJwlPomeLUy6uIGq0x993TOGyTiwKXW1XPBSd0oyHk
	XEI66pQX2Slfa2hNpjEPS4u1m9tIEWkeb/4tCWmUpMPfVAdTlA5Fd/vBpDxQ3fgh
	SKERh+fvYH4HMH+RA1Z7j1x8gb6TUChQYyZ3GXMmJpr0psVUoCkMUz9zV757oCzH
	e1kaCEgHpkBrgFh/bNCh3Yk1RDXc7EGVwVLP3Yfz0k6O0ntrBrMP7USiNrq/xwAb
	NRw1fROetDjp6h8CLEl+Iws5BFl8ntAEwssbngiak7hWy3MlXx1SodUNYNmY45q3
	0tRKXq0WQsQ2RizbYKGnOQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42qh03efe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HotYZ031469;
	Thu, 7 Nov 2024 19:08:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42naha6c5t-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCjwV1XWdeGHF8fkqRSHR14Ncy4JpJ8br8XA1YjKgnKbf4rw4S44zNZye6znm9zNwrz+3kIQGooMnKPPnuBo3KIBfYvp2lyBi4SDPi2rpXK4EUIBSHJJESjaVOYqVwERZGeMg5tMfh6tSyXCq7HvrxS3jYuwUOQrMy3LGoQhV+hXoseOWbzn4npgJRRrLdZHvOUNQ6HxjRnvxMnKuV6WWAMqa8hcgN+hgzNZu7+BPnj+HRv8m9T4aom4pdZeNKrYhNRrSMN2lzaoqJbPbh1r4pCTB7FYDTwCTQXWgCp81zkNGHyVZeqIuEid4LDm5FDW5a0znUf97EqXcygY1ed+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXIK4lyZNeGwltLFKkc++ba2e94bN0lRjiyisxGBoFo=;
 b=Jp5eKm6YYh5Rf55QE5UwD0mFySc6NTK+kFGF++Nqcksz5yo9+wRoNrTV37tkVRX420+7BhQu1H5br9VFw9qCc61zOJiSYR77hFu3b8hXQxcRf/VtsdKUYPNCsZ1jSSH6VdelPtnDIvjrROgfGqI6THMA8cDLtBYdIcjd1vxLvJ9HwSK/1LC2mWR2MrlUqCTospBZ0TVKbEwkTY93n75tGSMPyv0E3dBFb0YlZtTwfiliLkNtsI647Dd+BoGYg9A0A2Du/tGgzE+WeBfGXl/58NI5RBUWA6dAEZYc1IccwvKetCUi1J8vSv5GV55LlhTNy5f5MSnV2/v5GUmHl0VM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXIK4lyZNeGwltLFKkc++ba2e94bN0lRjiyisxGBoFo=;
 b=Y2mn5WBpxUkO6JcXvn7rzxGVZMtu51LPqWM9w4DMFKX8QQPixzH84EFauqPMii8Z6iLM1PEG3DN9XckEj4THYvzHJCtWHhtqao3LRJaoMt2brvIqR82nIEjs28qi/u359efpvhVsGvJuBKtHlV4hrhb/a0rYfEjICNwe2fRH2q4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:22 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, cl@gentwo.org, maz@kernel.org,
        misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v9 01/15] asm-generic: add barrier smp_cond_load_relaxed_timeout()
Date: Thu,  7 Nov 2024 11:08:04 -0800
Message-Id: <20241107190818.522639-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0102.namprd04.prod.outlook.com
 (2603:10b6:303:83::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ff19b90-d2ad-40d6-c917-08dcff5f8c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UP5A9Zc/Q2hFCEIApnt+lvtB6z1e+vqNqZyTa9v5B4I4EvGuBGBu+7qdcmnR?=
 =?us-ascii?Q?UPAjBqiVtx0XQNl+fzQ/WmAtZvu/hNstFQw6eB7Z+qTSuyFLMZwIMpw9wd9q?=
 =?us-ascii?Q?9dCW9wKF8SCxwcVqLvnYHW3jwPmFOSxCc1nbTgNjxrN2jK2owkRhFVzmq9jE?=
 =?us-ascii?Q?TogvvUIrYgddM3kcul/n7P8Qf1PNJ2JeAIx2yMkEtF7T9CzI5nkDI6+fugKr?=
 =?us-ascii?Q?RI6Am368GqL7+LftTn5Cr8ldAGpVUcWqwjrbRqOIGLiDx0N7FEXQZd94FX90?=
 =?us-ascii?Q?35UNeG0WftWetqXPDhlqGh5jNb44gvojfMcdb0qGKuwW8XAjFjBqKU4umn8Z?=
 =?us-ascii?Q?ZATMyAYchTO3X74dodl4N4exEJKCcphw5mMxiVd4kkQ/P3pjiIv0nVdWQon1?=
 =?us-ascii?Q?/55Y9ALhR9oOWpUhiNITB3Dqdp7DsodS7aHonNDh/EAdBCPsnVSnsmCdEIFX?=
 =?us-ascii?Q?AeYw0bi7nBdTOskW0yYO6oxbj6pdKXCyQcemAIm51DAiGSLLdidFAEq7pSid?=
 =?us-ascii?Q?StbTt4quIwN5W9CkBhyhBrbEDaU/1MMtt3nRxd/aijljlFcLbKUytuDuDn9l?=
 =?us-ascii?Q?o/9f7tj3N/h44BATLADDSVKpNwZVaJYQW45F3/Lkeo2SsExRFjFiMvGgtzxg?=
 =?us-ascii?Q?kob9YOU4Ch2QSWtoJbE5efIzQFZL+Z1He9NmsD4fyJzzHbSi6Ojg8Z/pWTFt?=
 =?us-ascii?Q?MgJcSzttK4oxQzPLFSgqUy9Rxqn0gmgugDX8tcyWHM2pGu3E+xAFoSHeHTWY?=
 =?us-ascii?Q?8L+KJF7GSByEQNed3Wkn83hgMBlF/w6jjsLzebjhGxiXZuaWoGmBvFOsyXkx?=
 =?us-ascii?Q?eMidUZCIm7s7QixhW4d/lFGL/S3+T5RKXAQa/8/iCmJfjDO+zkTNcrgxGTRg?=
 =?us-ascii?Q?UJ7UNXiDyyPGi2BuIvHvRer0zqRY8nkVd/HqOdSe0dG9aDpQTdwjUgeF8r61?=
 =?us-ascii?Q?JV9Dx7hTK4jXa6TLQn7/lYi7m8zxBt/rFMqE0QXRjxS+srldir39qWl7r/Zo?=
 =?us-ascii?Q?Opv+WwhGA2H6GZbaY6nuKMQaNFpmYvJzTbk8bSitiCElFNeBwmhI51CRXv9w?=
 =?us-ascii?Q?s6IiKLw1w3PX7eabw9sBsivQpjrrXLBLuJMnHW3/OnJu5wg1W1M3DNOuCE1e?=
 =?us-ascii?Q?G5dpcj4plEuoFhC8c5Dhjlg57jiZPvnLxYUfXE41PDuzFRSdG/iM5Nw6TQT8?=
 =?us-ascii?Q?qumkaxrAGPatPDfmsLgYliumk8YmpfeAjVqL8eS8shSzOeLMyaZzRELq1bUi?=
 =?us-ascii?Q?LJMZdpuKueMbP23SE/cAu0xmWV7YntQfuu/JZEhb6zh3NsOA09H7oSY2jFd0?=
 =?us-ascii?Q?1FQ16pPCScf7YK92LvFRI1sA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d2vo6+1ix52dNDu/gp/FtHrS08lJPyu5oOl6qZhw4/EwmgshDF6XxAiYp3vh?=
 =?us-ascii?Q?SZgbuAbrO9mKKWye2Af9rfUpA8zH63ODgImFRKuBNQG/T6psmAiozqTNIUAo?=
 =?us-ascii?Q?bnpsUAlYo9BfKuDXeoKuqIbZI2+BP0aahnXmBHHDMVWR2GM2iRsIR6JzSFcy?=
 =?us-ascii?Q?Q3yGv3FtOj5ID02BgSmYGRJccEckkwzCWcIDLOIs6WMpf+f5MJn9mWXSeQWb?=
 =?us-ascii?Q?m1sPV5AYMYH4cSDEY2DAJMblpHEQ6fUSUBFSPhMrISfWxNEXH5/n6+ikKkOB?=
 =?us-ascii?Q?LXE/RJbKJZP5AT/29m4jk14OU/YR0cBQueg03gsacyFJzMdx/Yc11GUgE+GF?=
 =?us-ascii?Q?o302qD93c40T1rREnI/DMUul6ffjAEXjJ/4gTScqpfaIftJV4c7fXCzOMiI/?=
 =?us-ascii?Q?uVOUDc9U6OKLoWcZkbB+HTYEAx5fDcro7KIroTPDj6gyfeEDPfsEk8n3SgL7?=
 =?us-ascii?Q?6BFOxUGsEXfSD3vyS58p7wc0KnRNWrR0gJ84FXRrzse/RvKqWEmUCEZwUrh1?=
 =?us-ascii?Q?chm2A9eoesvBBS7/A4mU0T1OCp2e3uuXfBD/tXL+3RW+IZ6W0ic5Ckb72u2q?=
 =?us-ascii?Q?1S5zTMFpQ9FoTwzUD/WMcgSrfsXfQTNGNbLCodSDE+vHHVoWCWEIvQLTK2gY?=
 =?us-ascii?Q?6S0uFHWZAAxMwS5FCRTfoyOn+f4yVkydGfo9eXze388bQAbHODnNmmXytvyl?=
 =?us-ascii?Q?T5nLHSjD6BfDjG9F9j1rNAJ24X/Zpp15LGD8/iIvol6uikkKFuNYvrbHJvl2?=
 =?us-ascii?Q?o/HQAgUzxHz3GqnWUQtwZEEYNc/RQfoeJ9+HP3pZnkasSJPbNryu0Pq0SQSK?=
 =?us-ascii?Q?vaFdBKJ7VRbs+X7P878YrVSWu3FW8aPRFm7DXsqL65Gm+RqMV/o7hjRZ6S2L?=
 =?us-ascii?Q?eW/qYOP5jz97RCxDnaXyVPzG+AOkQXwTHU3fXBH4mjoNdafDSWBz8gZXR7Oo?=
 =?us-ascii?Q?k7eUuNrfToRgmaEAYcfjzfWVVpEOx9t5niXAgFAndu5x6wegDcO2S7KzPUik?=
 =?us-ascii?Q?2dDyJhxLB5NVBP+NE5D9l4m/kAZhQlxJKo1QDcAYrCJu1KlHZ3Zowz7GVx48?=
 =?us-ascii?Q?509i5+XEU07q/9j2hWY9KdqdEk638+C1Bl0Mul2KgkNmf+qnlyZvb0wMAqfr?=
 =?us-ascii?Q?Vh3iJq/2mAu9XxweBf9tQo2/WN1m76blaoe0kuwU3v+27u6po4RqzCUl0+D4?=
 =?us-ascii?Q?q7ZycE0OgJe1u/UbOJoOTVIBVEEimOIp0QrdOTVGjOZWZhYseeIcnzQWsGFO?=
 =?us-ascii?Q?y2w52EjktnPiyzsg3wHptyaFIG5u+4ODcgxOgmrkZwgJPXTZTungHHWCLLZ6?=
 =?us-ascii?Q?4Pd8aONt6v8ZKa8LVU/kRJ44qunVmvKidTi+C2qk/hZNRdhEWNm5fJ9UpkMH?=
 =?us-ascii?Q?tt9Z6V5rL4QZ2oEZgz3bbXp1muZkv710HX+NGxJZKXkTjC8OZJhE4T8WXdUi?=
 =?us-ascii?Q?H9y3r6SmoEKonXegKh9UwHXtRkAHv3fFYBBrGgcB/uU+kwCeGJiYW1ovGKzA?=
 =?us-ascii?Q?WElNo+S/+Zi5ymi3DTOU0iMV5TZKcVfYXW6wXSKTQb8CUexGx+eXukgv/dAW?=
 =?us-ascii?Q?VCD0rQ7W/Nde5RfaUqv+7WFuOnfPH6RzsPqIr+YHKa+Ejqq/3Z700GfL5TiB?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9/oe2hRigAPUcas89QZvInW+mfaXFoh2SgeU24tR/cDeWsYmrHB1SQhJaMGJPhIE3cxgNogqZXru1S00Weh/Sc3QSHWZeu2036UViPNxoGMNXMmu1ztoZ+UKjQgHYR2Tz/ElchORfe0ZyppZyUWY0gVTcDRMAy/RlsnunxlEDdXo2MZNjBJbaNwo8VCxtkgy3zrq84EI50ciX9o+u5VWw0UDsirD5BVN+dwXoU9aaCXURwQYS015btqWXMShU6BFagaIz+eVOwAkFljgZp7XBJGNipikphWld6L86bQDQzCTTNwHWEuQ+C1DD/0OdDFuXab4kZIAwR0slvd1t1oFVy6+0cY9hKPrD5inEEOraT7AEnnjtKfEFLc9wT11ie+RLPmjf0J7TJuQg6sg+3KNt9S/UQtHMuxSjADlD3l7saiWn9K26PNmVqo9lINacDcxXe+F9CssmpCs4A82mJ7IGRTfzhwEdDGN1iXdn5HWqbs7yHaxo5kiPr10iDPdUI+ruoX/0e9pSdO8c31rmzRj2daN2O4aRRgJ68OwpxVkHRE+MgQvsF0hE2fKrQQdXD11/GO71NVTdnWoHHIEmkhjAZBUI9IHoKQdpv0pFrAwS30=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ff19b90-d2ad-40d6-c917-08dcff5f8c82
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:22.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gbv1xopQKs9qHy5z6s4drnxJssyJGNmBpKFMIX9k8rJ+YjVUA5X6sBOgjL5iigc/UJFU0kCoK7LG7ikT4VFIg75chaxCRE828ALkHzj1L18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-GUID: PywjNqxFCDylieKsOIh960Pv61wAvhaX
X-Proofpoint-ORIG-GUID: PywjNqxFCDylieKsOIh960Pv61wAvhaX

Add a timed variant of smp_cond_load_relaxed().

This is useful because arm64 supports polling on a conditional variable
by directly waiting on the cacheline instead of spin waiting for the
condition to change.

However, an implementation such as this has a problem that it can block
forever -- unless there's an explicit timeout or another out-of-band
mechanism which allows it to come out of the wait state periodically.

smp_cond_load_relaxed_timeout() supports these semantics by specifying
a time-check expression and an associated time-limit.

However, note that for the generic spin-wait implementation we want to
minimize the numbers of instructions executed in each iteration. So,
limit how often we evaluate the time-check expression by doing it once
every smp_cond_time_check_count.

The inner loop in poll_idle() has a substantially similar structure
and constraints as smp_cond_load_relaxed_timeout(), so define
smp_cond_time_check_count to the same value used in poll_idle().

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..77726ef807e4 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,48 @@ do {									\
 })
 #endif
 
+#ifndef smp_cond_time_check_count
+/*
+ * Limit how often smp_cond_load_relaxed_timeout() evaluates time_expr_ns.
+ * This helps reduce the number of instructions executed while spin-waiting.
+ */
+#define smp_cond_time_check_count	200
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_expr_ns: evaluates to the current time
+ * @time_limit_ns: compared against time_expr_ns
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Due to C lacking lambda expressions we load the value of *ptr into a
+ * pre-named variable @VAL to be used in @cond.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_expr_ns,	\
+				      time_limit_ns) ({			\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	unsigned int __count = 0;					\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (__count++ < smp_cond_time_check_count)		\
+			continue;					\
+		if ((time_expr_ns) >= time_limit_ns)			\
+			break;						\
+		__count = 0;						\
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


