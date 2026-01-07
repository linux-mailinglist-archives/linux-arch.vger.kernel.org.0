Return-Path: <linux-arch+bounces-15687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B0CFD082
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 10:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BC843009082
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30032A3C9;
	Wed,  7 Jan 2026 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WKERTzpG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bRsYm69m"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9047E31196C;
	Wed,  7 Jan 2026 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779302; cv=fail; b=RupMxfbI2OAc4I0PGiv1n0XcI6IJHEVrPaR1wLeE57gASaB/YLTjwCB3s6SBKvObFELNMN3qNhoOkLKt4YH9Ri07ZyBBt86X59EskPYIShwJpFPotfzcI3CHbFhVg+ATBz5qDtzzzij16O0NoF5ld4puErTD9lJYjInZ8YPzxmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779302; c=relaxed/simple;
	bh=YjsP+RAaDllUE8olX9AErmEUdMsbk/iEvApvKViDGg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rPcCfQtL2NRB8K5k6Ww0zoNU+swcaKnyTYiH94TBKDwyKIzatfcpxth5xQfXAe4jNLYDLhpkQONx7n4I6o7iy/4hI4nEAUxJJaXu55cJISpDP+Lr3LJUI/iEheTXvW3VfEYOTj8aVLJyx573J0SMKdlc/LCh7wFatbIhr5UcT9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WKERTzpG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bRsYm69m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079ehjX1422868;
	Wed, 7 Jan 2026 09:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XiHy1dpWE324hxuCqtFItUr6Mgm0ZEAZYS4rrSAQC7k=; b=
	WKERTzpGRPPoMSPx40JUNUmU1Id6NnlO38WK8lYDDZ+Cbn/ZKczaGdrdmtkhw071
	DMoeRGmfxBuzTOLRyN8DdbPUaDUcMFIdhuiH94mpGmVkRbtGOWgaWiyFkj7AGm8L
	QQhDaq+MMdiRg/iC58/YBESWx/Xi7PgwYLVV0/ta0Eg+00g7S8tQvgBpaM74tG3b
	R2s10W137VbR59VCzc7pVp8CTVTA/sTO8UtV15tyRW1izqR8Qmi/KO3emXM4nIZS
	7eWBQMIS2Qf6YlUJ+ROa6TTpK4v4ahbB40Gy8VCzM7P1JZZEiZGY0/VRo+abOI//
	vNroc9ooy18V8QD8dKcOUg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhn2ng06y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:47:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6078qwfm030813;
	Wed, 7 Jan 2026 09:40:32 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjdp51u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qs/2i7D4Hr+NIyKXCNWzVZagbbPKOb6y+LNG3Tt7T/sBJLhLsX1OQgdwiMOZ7sZqoCa+xnH5RXMTWeL3NVFJSyeXDacEEx2zFOrp+F1nor9/sUP0jXY/indD0grjGliW1t+rVdMkMnxQuHYP4cysgaADGbvynxjdkJM+WBEvZWPDUKjuWGxXzT6uY+ABJGV/VF0VsK9quzQDkWAbZx8SpxsFnQK6ScucstZsw4mf+uBLtR1T8Vp1DxfbbbzlhsK2ikzAXWdZT1kQUkt6KR0jLByCzZjqHO+ExXa0DeFw2DrHTJdm728v+ZIDiKe/x1kkRvBvHEd64JTXGSK0oT5aYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiHy1dpWE324hxuCqtFItUr6Mgm0ZEAZYS4rrSAQC7k=;
 b=bgKJH5onqw3bKmMB/OAG/aY7bE/x+T78g9iWiD9veHx8iQr6f+auHuUmvSL3K23prUwMmPSl9IHD9PVIfvaKzkDReW5nNdIw75yeZ6AaL1CDf+8O2FysN7jtMkcGBIUCYfeHLwmSaaIwjZj94vue2pRzrgbbOqZjZgDwAVSAK2WR9llEIVmOrQlvuUNNeT1fA0cUI4ONfmJEstZitn/9R4laWP9aSxeTMxKh4YV0K1XKtKHjyGiHMaMSpHJOKtS5QlfiRWHAIt1ydb3ZFRplBbmQP/VbZCsmzpSPguPBQPhXfJKvOm1ozY+MN0gN4yqlhTqsrdlZ7tEJQO/n4bHA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiHy1dpWE324hxuCqtFItUr6Mgm0ZEAZYS4rrSAQC7k=;
 b=bRsYm69mhf2BsGBUTiZvywCzxLEpCmqpCLqU7OTWzjcTDnMs8o3JhmhGtx6CKRS3vz9M14zwXbOxtd88J/DLFmxxshVOj5g0kxw8eMlwmlN62NUg1GRzQaMeK+VI3Bjolc9Z3oqqB111tVdX3Xr4sBMVEsN9RZD2IwS7Cpuk3Q4=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB7479.namprd10.prod.outlook.com
 (2603:10b6:8:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:40:24 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:40:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 2/4] LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Wed,  7 Jan 2026 09:40:05 +0000
Message-ID: <20260107094007.966496-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260107094007.966496-1-john.g.garry@oracle.com>
References: <20260107094007.966496-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 038a5edc-f410-4870-97f6-08de4dd0c87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfvKgnyKbwnCcfDd9BXmtGxMUOsUORMDewfmDGYpvQdUTQcYlSz6hEBiG6me?=
 =?us-ascii?Q?EfZY1TCWNbwnoK33/K8kudLtp8LgX1HQNr+6jGlOjXPEKrZ9zHfwrFGN5YgH?=
 =?us-ascii?Q?vZ4DcN0Qh+2fl9SFWiW06IOdWwRCUVzBP6NfO0T0LzMzUV1+bfeGKC5lDBxM?=
 =?us-ascii?Q?ktQi6yZitz0uxjJn+YoVSUaf25mmbK3fw090Rx26DE+RT44DCitiv+iQlSpT?=
 =?us-ascii?Q?fxObt9aGhAcNCtG2tbxWaegp5R2qZJ0jjSws/gumOJ1LqEsGjbH71EgSveJ2?=
 =?us-ascii?Q?svSyIx6+jYkmhFX7ps83iVVDL0beZHlzGlFUmTJFBcJ4ZzO8nei6qrsqqX5f?=
 =?us-ascii?Q?U/ttfEnVPlGcIkBUDbYSVRCDINHjaXwje9ssuf3kHwkx4k1eUSg2E13+ApiD?=
 =?us-ascii?Q?Jc+Rnt3m4EPGu//xKOTIXqdXa9AoVlj342iDSNgiw1uQ6tNOykWbr7g57Pfr?=
 =?us-ascii?Q?eUGSKzP2cfkfEe5SaJnKBrYPgQD8Q8RGZJXUZrCb3TEk6aHyCN8T6a1yiZjt?=
 =?us-ascii?Q?tEFvKIMN2A5Z4SJIgYKVonOSeWvZpVMltc05dDtzh16nuGyNoxnvgTLlYUOW?=
 =?us-ascii?Q?ZkFUIuICiabvNnA8/W6iMMyb/d9M3smECUgJ7rEn66x2xahT4fTf+8+9M9B4?=
 =?us-ascii?Q?e4RJ9NbDpPCjN0Q4x/i0x2jLOdOVLM7F33pFfKP6GnEB5fZCGIr8Qb2P8H2e?=
 =?us-ascii?Q?omZlP49eezSzcca7/xpjn+0RGDKEaY2AO9JmCayNehR6pBXUyBj2ZPENKfpY?=
 =?us-ascii?Q?qSUajEpHQtqSksagThdg2OQplctxw/lFv6dxRSmvsmtsqny9TCupG4b1T4lB?=
 =?us-ascii?Q?WMPmDNsiBiuHAkpB/pP4TmjNYXQsFME/Cjvx427ymkfmOF2LGRAB34fjlGKb?=
 =?us-ascii?Q?3cwCwcvISiSjiOmjlGknG1niOab0Ytcwo8+fd7BomzPnxJEeVceNpQhTE8K3?=
 =?us-ascii?Q?vV6iaiInrYt5V/Z3aSZEAsWE0famdAlSPdRigQ8walar2imvL+RsvqMGFxwI?=
 =?us-ascii?Q?5CMdHWuaRppBuGzLD7AteVNk2AaRTmLeDzxksxFyDV2M4w4HrotH4q53yM1y?=
 =?us-ascii?Q?3IFk+iM9E9Qvm4r+4caY9O7JxeW/U8BxcWIUUvNpXdwiDxvXhE5FrUGXa21X?=
 =?us-ascii?Q?eqNEOerSXcQEEVtZHqBjgFLgjQzBqMoSR+cHPfMaOKegLzyUEUD0GJTPZKcQ?=
 =?us-ascii?Q?s5pV+4utLh6/l3TdPPPzjWiPeRaKgSBgaeT3/W/7Z+6DZvCeCRIK9t41SYcc?=
 =?us-ascii?Q?pdETQK0Zrdr3etyncG2lAE0CMiBn1rd/3N3dPq5DJ0ZaI3CzzHt+XhcNZ81Y?=
 =?us-ascii?Q?I3CAX5Q2dCGJp4x5yOCd8BJGdwhWRS27y4fvYiL29saVydetCQe5ipKZagUT?=
 =?us-ascii?Q?2xIUtLrHHdmt0pyJlo6RvEie6o3zgO2zTF1CGkUmsV7pKD7E+gIH10g2xmiQ?=
 =?us-ascii?Q?DGFnPmYJu+WCS7Vd5sIW0WB5UdVigAQJYTT5DA/UGm83frNtvf5xfW961G9Q?=
 =?us-ascii?Q?4gumsL3PTfeJBpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U1kbnnpPymblLGpK9othgTUpRw0DHaaMjV23x/hWSDB9R2O5UdVn+RsH7TaQ?=
 =?us-ascii?Q?+Rf7wpBQrmi7wlKDiqWP92Fle8KswxVybgvvgmqHk4jdnk0kUR0boeji0r95?=
 =?us-ascii?Q?P8N7FPSPRxAttBgHpr9r3cI3NOdXyxCPz03kczuTh4I5pLQ3J+1bS10+0ZYV?=
 =?us-ascii?Q?xeQF7YcnjT0u09wd9PjCuz7JAY5VSMEPVksHqnbMkMluQluityts5UZJNttx?=
 =?us-ascii?Q?kHgcyTAthcOaYvmeX+I+kYaq5TVGVH1wt3WRLary/nMPLTR1yTeMb7ejMA1K?=
 =?us-ascii?Q?zBMOtMYdR7SepqcvX7his9mgXCrH1wCOZZ6jE6q08/a+uPMhgFt7BBxtUCcy?=
 =?us-ascii?Q?8mMtImZtFqi4urAjxRZHGzhB4uoMf+FSlnS+ctYYcFyjSnwbhvYjemL0e1V3?=
 =?us-ascii?Q?PqG2kAeAdgsLXWOSCTBDVxT8nWxCoFcU15L0OkBpx45Erv7j0ucxEvf/8T9o?=
 =?us-ascii?Q?a+bvjuVz+3PUmFirKU1SFIOFwJeZ51bggjppIz2tqrW3t6t9zcIb8XgepNp9?=
 =?us-ascii?Q?Z23cfgyFsDWpud1KGlH+EUY9AU0XnFtMcuu7N3j89gtTz9TLMZBWJ5H6N20B?=
 =?us-ascii?Q?k15WF+ylntJ1li3Cp9Qzk3VuCNHDLGoE1/8LzogYuDyUXL6RzsXjACHTlc6V?=
 =?us-ascii?Q?faXhq34U9iI6gNnXWJlK6aDbgKZqGtEeT1N+WeGoa4eyz4jvyO6aHMRkIAJu?=
 =?us-ascii?Q?f7jWG/GcFYjKwNS+fhsVjR4+Dk3Z8FL3/ZJAIXfDQlnUF9sjlzKBIAJSWLlh?=
 =?us-ascii?Q?13e7rQd9XWQkBNcfVKheJYpKWhZ+lkGxeIMW1937yWBcMT3KOx4dgnlpxkQH?=
 =?us-ascii?Q?VyqE/6JdMPhfqqz802MhRBp3xhqWCAMbUZMLbCrpMlNVQVx0pZmqb8xU6krb?=
 =?us-ascii?Q?dllyq24oImJwMnFskLwLAFcX2Pm48uX2Lcbx+msFdAaogCceFHcmXCfZI8/u?=
 =?us-ascii?Q?8AMUB2tj6lf0gIfKZo0isHboiZx5xqLSLzGiD2MoHloEIvs8hGySH137UB+E?=
 =?us-ascii?Q?E/d877DtsrwRDumuAJtxogJVV9X7HsmCvylsz9MnoxejG5aoE0xF+REy0zxt?=
 =?us-ascii?Q?nPoR49sgy+AsY4Eua7e5cmQg7DcSafalg2iAi6XkPg7/W351XH6JadVAHCz7?=
 =?us-ascii?Q?co6BXszvLv8KxJG4KfR+J8dBMxAQWB3wSYQVvvx7v18kkcRgsdjwDmvrmiiH?=
 =?us-ascii?Q?lTx509NPtlfa/MO7Pi2uMHLbjSmf4CubReW5p/OabRyw+BtqhPSzZhFRB49W?=
 =?us-ascii?Q?IPV30u2LuTwHt4w1YsD7qhT99Kt0E82tf18cPsmRYU7XAqexSQqArrAlfUdd?=
 =?us-ascii?Q?VmeGiiYTTyfmCqoX0EQqrq2KxK8U58mi9JfkCigP5SddJABnj1cMGgjebwZd?=
 =?us-ascii?Q?VStGwROcZTAK/x1rNKsee8965LUz+JPVexfQsZ5cDA2JTJd8WFzhq4dGRB+R?=
 =?us-ascii?Q?203kHuxsRYHUyLwKM+QEl64uUSI4wmGeK9zKHHhbSOnulxwr2dCs19kfvcOA?=
 =?us-ascii?Q?ZrmOiEbjRW/lXWFlCa2QA0E2Wz0zEfai7DEOBaBHJHWELITAmpn3AROnEpT3?=
 =?us-ascii?Q?QEiDd24yS5fTYLVkIomSlTO4w3p8gZrqawKCWVkAvZ4fXhCfX3oOBpT3O3RX?=
 =?us-ascii?Q?8HDFJTLVHY6hE0t57ooGeIYvZFfKrBkdXB1UUMXNJPiro9zMj4JAcJWNPlLD?=
 =?us-ascii?Q?0cfmPx2XGzEUks4qUR3JUbYAZUa4mACaCain6Ll4BriUqGSyt2tdX5mV6Kql?=
 =?us-ascii?Q?8QfRwwL8kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xf6mgzJjDKHP6489cRmfcatUK7KKHt4dh16jsJWGgrflAF4EhdNzFREx16WGaBgTLRwhrL7MAPxY9Sf4p9I+AahW+vY18egeWppHGvj98EsFfMUNjDggmCt4+q8cRXVsBpUYPlQtLW9imMvAoDEjR7kHe1mnBA9Zx7/YhBqSgGiHDCUCFoX1vwV/bqju2CDSCq+xs2cWTx5qynXHw3AMXlI1dLG39BNld2myfk7d3ZOvnxicE/ddIBJCYCbeDMy9IUaxT3BJISSO5z08/wqpPCMSGKX0hBFOOmX4NtICYZ1YIZuHDrfasPTpLcmdxbtKrDYmWqCwwJzpvbT4AB9acKCiXTrAt1zHqhN+Sjs2iAtfbntNN6mwbLcoxjNPgWl5RZ3FuvdllqRRhuKU8s2YmiYBVTP8pbO+hwnwmKhxlqge116pEIIEKrDu71EDSsX5Tvnku8bHmpoX7TH3CIGxe8zBs8Be/J/Si86AhCGddmtE+uOc/2mAdeo9BwOMIrxvPBTNV7Ll7cbnm0lgpniJlopU8/ujelg5zvRfeA0fsZNGx8v+XE8P9g79ZeS/kc1R2+5zfN27OSmLFXOu7AqssNF7ZjtqUvsE+bXU6Bu/9GE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038a5edc-f410-4870-97f6-08de4dd0c87d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:40:24.6455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7Kkk1CTMVfKWCmOmvp5IP9S9x17Q5tzePQXU5yNBCEZ/f3ITeXCXXBFm93KDD41dpcq6OQIkgNGzHctFOw5rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070077
X-Proofpoint-GUID: k0ebey4Rln3tqCu3ffftq0e5PqqupXfO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3OSBTYWx0ZWRfX3x4FWOrQTrp/
 8jrvHTXK3Ud/TDv0ajlRM4FNO+B5dnzUq/+C4V1b/Kj5eDRePkDJaVeBgEFS4+JRUgOM6VqkAkD
 LhC1620wYFb1jnhKO/w7RVwX0ntLe0fh5cYxp5b+nc4+OmptckwadugL+Q17WRAelfCD9KYE7Bn
 I33M667daNYYdD5aXeF2KEL2MGvxu3K24KNLcChEQ1hKcOM78G/txWa7u1Btx4tATRk6FHolPfv
 6uB//OOo1847rclggVDij6JJN7iSxaxR9VAvcEMWpv8RkWU+O1Ld3GTO4ayz2HFK5zJgmrqaSoK
 4zFiW4GMGMLIsdpiglNSTCueidZvUHL7QVL5qv1KsdgQ7jj4zNgQPpZmOCUUC0jgsicCco8dRHW
 7BUM41F1wbnwu0Yf15ECeKoEAJy9OokT6e2d6vmyvv3tJYNL3e1GB93XRheBTXgj0Q+SI8B49it
 gTht/0Ua1XAo5hTWTPiuOtCq34C9aU4mYrdBHVtk=
X-Proofpoint-ORIG-GUID: k0ebey4Rln3tqCu3ffftq0e5PqqupXfO
X-Authority-Analysis: v=2.4 cv=X65f6WTe c=1 sm=1 tr=0 ts=695e2bc6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=sDudjs3wggNUJs88yxoA:9 cc=ntf awl=host:13654

The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - which
is a valid index - so add a check for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 arch/loongarch/include/asm/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index f06e7ff25bb7c..6b79d6183085a 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -12,7 +12,7 @@
 
 extern cpumask_t cpus_on_node[];
 
-#define cpumask_of_node(node)  (&cpus_on_node[node])
+#define cpumask_of_node(node)  ((node) == NUMA_NO_NODE ? cpu_all_mask : &cpus_on_node[node])
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.43.5


