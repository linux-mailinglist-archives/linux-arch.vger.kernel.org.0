Return-Path: <linux-arch+bounces-15412-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D35CBD508
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 11:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8316300D902
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 10:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B4A32AADC;
	Mon, 15 Dec 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PKj6Fu5Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HgZD1vXi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49948C1F;
	Mon, 15 Dec 2025 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765793325; cv=fail; b=YuMtPyEOCV9qdDrYk1+qqvbcTHPChw+NDqMpVotJRQhUsrJO6kV+Q/uQpYzyGfY60BwZ4lMs2ybCiQ/+Il6KGqGb3RHTegz3tSjRHTqueKqywbw2KGYpc4rsSQr3QZ1Vda1pFX9B5ioiNuTtFQXnP33gg3d90aB07vgHxgGDGg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765793325; c=relaxed/simple;
	bh=nDVekUQBRvhv65rF4zPtWNovK5Ux9N6S78d8+h9BMV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d0L5dAePkmpBCH6U0ZtidmzdSXuZZ4FbL17g3PK9VGgfBiVVx7D+ZRVVRiVpmmWRPLiEDp9f2nhAAFEyEbuMqaGjds/X357OccPoEocsRVAWKtDGHaLpGYIeu/Qtt06JlE2ST2PKVEPjsIKBydeVbCrrb2SXdWa5bH5jyvUYuWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PKj6Fu5Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HgZD1vXi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF9up5n1921298;
	Mon, 15 Dec 2025 10:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=gF80QiiyiPB4RZYFkC
	gtZMjdu5m6Gsq/uTSKXnYSzq8=; b=PKj6Fu5YQyENqZz1Eq6RHAECvsAmO3fHFf
	QLCRcYh1c+D8AZ35/mW+x2oadjK1GECGVqKbdfRp/tDcxZV1rtYlL6cQngkPaFgT
	95K+/nslWaW3goOpV0SU1iEokdgMaxyMu2b2CAqV9Z3jlUbcdfIZSwb5eoajNVoU
	w3DuKt7XfYWWWe/P6amA4EVi8/wFcSzAJC4XCJx5o20TyUQTIpXnjHfPwdNR+AAC
	9CHFi6G7KwJKimVJX3btmVMd1YVxb3N776mV6qRuqADgm6tOuaiYsiMObqr12ljx
	YyICTN2LOGNhUXzUsm+eV1uC60Lze86jJQGXS/sLOaDIGHHAHnPw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y289t6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 10:06:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF8RDHN024480;
	Mon, 15 Dec 2025 10:06:57 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010016.outbound.protection.outlook.com [52.101.56.16])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk90u8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 10:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CLtlOmFeaqyoAnBPSGUPMNyGZMn4Xv4tXqSfoImjB+zfGPyPYqx8XxlvXuHDOGqaUr6+hss0lsMZr+bVLRjAy++CUGGuGoJIwdH4iHRjiYzRtI6skX680AyL9i3ONcDzJW6xlEo0SGqdiZC99MpGpupko9blXxKBMWIzkEf5po1uIZ+gF5KExkgCcVdLbXBdsdVoDadqpkKxwlhBDarR2+HC0W46FcXaqa2v0K0NmW/XUWaiTj5Br+zRyUIKqQ+CyPuc0xepWZJixn8wTQRaEc4SBDwUuE5Vt2zliqe2y1za7tp6Z25KbWunWrJGUv6NdjLG6tZj3UEAc9qb5qy5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF80QiiyiPB4RZYFkCgtZMjdu5m6Gsq/uTSKXnYSzq8=;
 b=OHRkwEdUEIGZFb88k2mZfgFCRXhBv5exI+bmH3M9QccvgmNJkRqueZLdQdtS4yN/M5n16ueIAF6xLI/bwrJhfenu1M0a59iih+DBROoEo5qtnmEyURQTExtxxpyfcqeQOwAYuGEeS/doWsKKSro4Hp8hnHV2yW2oOAWjfAZDtQY2+YU21i/t/iRY0Y9VgidvkGOiQ1OPK36R/mPk7dL5S5rhCKWeZXD1VaUtRO7tRLWGJqnxqGPxkfSZjiCa8JMATmtgKJ+lKyOiQgdGvAlT2QE+ioRtlYBNQLc4sHISfcJycKWeFG7tfbFXu5E8SU3c3WWGEIaEoFCGT2QDxvqYLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF80QiiyiPB4RZYFkCgtZMjdu5m6Gsq/uTSKXnYSzq8=;
 b=HgZD1vXiqD7dOOLMdhjQ3zUjN+Z8E34rH68J4CQ32W9T0PRj2X/WzFVmc/MmpYJ4JpnWWULCefmUz54Kw3wa0/VIg9oVOSdpcTrHK5bVOTO+Z1twqNtg/bmOZDgc7qS9k0pPkeMHZdiMYTKorv4SIDHr5OtDog1iS8HsB9cSEfw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB7796.namprd10.prod.outlook.com (2603:10b6:408:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 10:06:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 10:06:53 +0000
Date: Mon, 15 Dec 2025 10:06:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        Harry Yoo <harry.yoo@oracle.com>,
        Laurence Oberman <loberman@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mm/hugetlb: fix excessive IPI broadcasts when
 unsharing PMD tables using mmu_gather
Message-ID: <07e8b94e-b4a1-4541-84ed-a5d57058d5a1@lucifer.local>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-5-david@kernel.org>
 <c641335e-39aa-490a-b587-4a2586917bc9@lucifer.local>
 <9ac7c53e-04ae-49f3-976d-44d1e29587d1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ac7c53e-04ae-49f3-976d-44d1e29587d1@kernel.org>
X-ClientProxiedBy: CPCP307CA0004.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::17)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 07ccabe1-e0a7-4f57-6508-08de3bc1abf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZQhRLggU7LYF5fMUe2OXqmNq9T57Hvc3tiiErdI9O1zo5MTZ4y/XjOe5BPYG?=
 =?us-ascii?Q?4PQYQ6mK0gdTvrh+OUI3+gLos4SK+CCcI6aI0XgPeAup/nkE3NnEvT2itfD7?=
 =?us-ascii?Q?GPjVmEIj3yjzzNb8li7Ku4t5o3uwxAonE2pCkxkRfrKlGwN0IvyBMdNF+zNt?=
 =?us-ascii?Q?hNwNaY+rbtfmuH0sR8knucAvsvs+bPExtXP8h6vnD6Fwud5RvE3dhQJ0Kg4e?=
 =?us-ascii?Q?6ZcET745bdLkN4uhq/dzOqtuOsSxt5CBGqwLR6IfQPotOCmdQs6XAKQmFQbx?=
 =?us-ascii?Q?Qpb1WMqVBntkquU+9SLLqbgzCkTVRE/M8jUOdpdrXrWj0/YFB1e5ULHdZbBr?=
 =?us-ascii?Q?eIYhOe+5VXIdUYfAKrA6VRvD9lx8YLdfQ+4YWV+QcGE4VJhSyRrp1lVr5RfY?=
 =?us-ascii?Q?LW8H35lA3UeDwYIfyqFDw6+6XRvojEh1KU/mP9+Y3tbHZM4t7rU2+M03TphQ?=
 =?us-ascii?Q?93EOR99p/H0mbnltAf1WXjLraO7WIkikJTt7FnE9z3s0g7PMBTNp5Bo8Tlhq?=
 =?us-ascii?Q?5+vjAEKl2WM3+QXgRWKRbNIAm/wy5X7uBu3d2r43CWM4u+lL4p6f6JVb1hFh?=
 =?us-ascii?Q?aFTb8jaA4PqjqNwHHCQZzl2iRieJD3e1tddrnETk0j8OmyWEBpUX9ZbcmPVi?=
 =?us-ascii?Q?H8prMfCVgKLnR+psr1KX9MoS1Ko73me9fQPzG4r6g95QqRI9ydNEtIrMp2oU?=
 =?us-ascii?Q?GBPaWnX73d33Zk8hqMkGDoXLewAOUasMDO7udMlLZvIG8Ivxqz/i63oIhvEF?=
 =?us-ascii?Q?vo+162ELLA58oTzAJv5ciy/EC0j0VnexapDVW30wc5pIsJ/ABUpkj3vTJy79?=
 =?us-ascii?Q?JU99MaV9ZQI2FNvutsLwojDJAv04Z7BVmWe968iSmhC9VodmyfJcaRxgYjOh?=
 =?us-ascii?Q?9YeULC62W3VCwoCk+Yw82xGe66wn2YoRTuBL/DkeGuR5/c0fw6ZY/3U2P0iL?=
 =?us-ascii?Q?nTkVCz+Bl2qR4xJ2fMU8LtIupZJeiKAe9rNZ4HfxvNuFAnU2lUxxHJd9SsRw?=
 =?us-ascii?Q?MRAmif3rPaPlbbCYxrf3Au2OOYm9TQdNaDN0dxKvuRmn7cfjeo0u1JGvOwWn?=
 =?us-ascii?Q?fKZdoWqRdYtfCkLpUubZuz3t+lfHIn1YmuIrAiHZjOYj0iBQrOBYgVhNM2BO?=
 =?us-ascii?Q?phkegr19yuHFIs2TrV3AzcnLCyhhLA1ncCROPJHOsSJeMeQpgBB079T70srT?=
 =?us-ascii?Q?BJHYaFnsd4u9LGmQ/ddaIkcGTtf0kG4lD60vE25IHxUQdKav0W7NlRF3a2MQ?=
 =?us-ascii?Q?1J3bD2z+dg27ETYQQdr8GhcSCRhyO4yaqefCeMcFad+9Fq/JJMhKPMFt20bP?=
 =?us-ascii?Q?xrdRUQA5X2zZeXv85wiN3dTnJs0+DNQSUHIc6yBzp+G15FPn5CGzRQc53ijh?=
 =?us-ascii?Q?SYkcfUhFz6jOiW6vdOyvrigKxKjOFe4xMbxKx+/jdeS1p/QWtvfJviVUQZ2L?=
 =?us-ascii?Q?HwEkWGsHFalihs3HIQyNmYHYsll3uUhY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xx2u0TGW4noMUeuLdKBFXYmZO2nLRMItTfN5kAmDUbLUHiJVWSyjx8vyqXX5?=
 =?us-ascii?Q?qCiiEot0ft2bSQfD+jUaOUH6QXK5cxL8UaG5qy8DTEt89faBA0JeW9/mmhGV?=
 =?us-ascii?Q?D4dE0yxBboFfGjMEP4KQmLNMtQh75Wq4mjZ0407/qksClvxQLmzX0/ind0Zp?=
 =?us-ascii?Q?C1QbT/VHBfonxHNjNDY6mt+K7EgLd9Ju4plDQ/KlwomGvZylXfxwVI5SXnLG?=
 =?us-ascii?Q?mRIdJj8LBjgWTTM8dF+Jhgi1W53PlfTyX7lOUN08A6wZcSOW9Opdstn/Rd/T?=
 =?us-ascii?Q?oeVnjcU+N6TCwnmz+4qOZ34FX8L48VRCbySRXudCaIGXQdQCouwW8tCtPDEt?=
 =?us-ascii?Q?4Tb5lxPTDfyORqb/AMkJwo+/gypH6us0bsa6QwWcW7SC6CnFibhMaQBE+Cq5?=
 =?us-ascii?Q?t7CvVHiFiDuNP1r5T6HaG6kIIDspavaDpb3f/cttigKVzf1cAOnSU9x1k8Dx?=
 =?us-ascii?Q?pHyMNHNMgmGWLA77iz7cLNMtsYzBL+jCyvNN8/h3h3UxiHgB+xi6hlGXIH2b?=
 =?us-ascii?Q?P7wgyIQb/Z9JUP55HmfJ/RvaQcBPppmM5JJRftEm8so3r7vFmK1fDbWPXx2a?=
 =?us-ascii?Q?EhRBobTHVZ0cqU24aG6AV4zG2EayjTijv4bwjCF+POq8iC9XzGqwMP9JsiF2?=
 =?us-ascii?Q?TSQhTvFfQ3uf5oAgS06S/66zanScWd8Alx871yVdpg7rt7lPHgYr6vaBxV8K?=
 =?us-ascii?Q?yMHKDvmulS55HmYSStcNqbaWSmdaxdall/PIV2aRcoxYsbEHnOeYP1vLAUho?=
 =?us-ascii?Q?+9ugzrRTUsrS62sfYoddRvFom29/DdfpXmyHQ14/PaGmofcHaMsYvMADq9FS?=
 =?us-ascii?Q?ZSotZWhPOjNo7g5a9KphDo02Abrx2D5gRNnCcL2LQY+x3aUqmgWYVKU8pvnl?=
 =?us-ascii?Q?Wjeu/y/5JC9+uiyLnhROcX6oa4RFLgyLoAD7brSIbibsJ4A9dw1TcNOFR3BR?=
 =?us-ascii?Q?AiAZGWUT7Vo4cMDtKnOSS5j3uJLeDebfHaM+Y6oyXLDoGoPEJLxJvGMcSQWx?=
 =?us-ascii?Q?nCh6tRgLvWrh3dnQZrxe4V0PYMf//9lKX4eglPVg4ibK2lNFUTbgfsvSiHqc?=
 =?us-ascii?Q?ZbOg+JBuZPql26hqD1O7HM4JcxnGDe/aPwRiniCfNuMGJUhrGignWIK5FEfk?=
 =?us-ascii?Q?Kkq9we7c/GNg/79W1RK4ueWFNHtyOah+Q5wXhH5udT3BjFV/b6e4ceGIYEdY?=
 =?us-ascii?Q?AN+W1n85NNBs+kvhrSONmVxs5dDtR4w+YLwauO0NNEsQmegC2piwDBOrbop/?=
 =?us-ascii?Q?iyZAySZStsLLf+N9o61LcmpR41zSZ3Z0uBeiMI7VVvq3M+feMInKaHRb6TtS?=
 =?us-ascii?Q?8OaZgbQ1hte7cD/8AunSE52uuRb84EpG9kNKmqad0zA8uj7At6pgAT5yVldv?=
 =?us-ascii?Q?AcikfgK8CstXSe97yntHNdvKsEYZDDb++9SQcth0p10XPTA1oshrC7Q51QE9?=
 =?us-ascii?Q?QKsGs2WUbqVMdP0RRKNkvBN1kNqnXH+Cd07z5Z4uSctkeN294a4AwbgeL7/y?=
 =?us-ascii?Q?w0A2Mha26F2RJIB3wbUPXTHIllVH8GNU+rJzT/sI+dTHgBtsAJk+IHsDak+b?=
 =?us-ascii?Q?SG5jYxViuKwq4ai5HDqiCaTv7L/AfTV9QiLzMQP0QLWYFLRSmJWhzVg6Be+a?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xs7qeUUx6BI8LHr4NiprZdAcJCjZERYGRJJOZL76SpxvCYMT5ta3pZdp1SJP3bqPWga3ppMqFdGpaLezhndOkScXemRwl4/UtMwOCFKY01oDWTmWzvgr1bYAeeL3RvkiCgEZrlD66dJO2bpLm0YvAy+bL2KbnBWrTJzcLtKYqThNLXIgH2QiRIrIFGgpfr68ZP59Vm18TUBgmJLuMT0rK6qdbDTurdXlSkFOJLE0VyWFKRp9yTcfkKWdnX8CVfah0OqG0hyH9oH61quqHjZIRhobtteIi90HO4sBYFMgpbG34yriRzzz9lBjy/nAr3l59VI6SAX5W30N8j90llnf85haspyNl0p2U3oLnFNr9SCpeP3yQVbWMkvJwfHZ/jdylpDFiijrLaGCizQ30j4jiFy/tcrlTDQlCuwBux9jK6SMFYVlyv3BT12beuLB7UeGBJD9T5kcLhQL6NfEgWCDWsinKhboCbAoI67ElPX2ALua/dM1LlGOzUBdqkKY/f33PyR3w0lEPxuSuPn5mTqZf7lyDgD4nixqQL4t6arYatxbQZVsbwPKs0urxtqh2IzuStH1IRZicoY9zsRieavd/VcuatkceJroqKJjiVeS2qI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ccabe1-e0a7-4f57-6508-08de3bc1abf2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 10:06:53.5909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MkZayLc2hA+Mu35+/Ig7a0sHiw7NWr26zPJ3kWKxq0sI6ZV/CA+AvRTPqUkj0G5bD7IvN3m2dE/ASGJ8MmGU5wOyOFEfFW7XUJMZ9w9ERA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7796
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150085
X-Proofpoint-GUID: O-fg9ZUp5qgMOY8-LezrgsF2P7XoAZJz
X-Proofpoint-ORIG-GUID: O-fg9ZUp5qgMOY8-LezrgsF2P7XoAZJz
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=693fddc2 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=YwKLSiNDGmng8sCRZUcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA4NiBTYWx0ZWRfXwvWR1h1qZXFt
 6e5PW3pZR5sYtL3wuMJG4kQx407ww3AD7WSh2xnOf+BZrsTYXj7sj3sEdx2YVOmJUCQGdHlTAro
 tzETPo4qxbcI6AWWt8vBBNNPOSz7kpGQIuASB/j8vCq7T/cwSMyFrgTpdus9rz5PzlwjV3+wyog
 lXE52XU0NjIurdJHRKy6MdLALQXiL4E6yu8BVCGPZg6DprOcSlf5cgztcK7uf1OLuG+J4+YIJSQ
 NGnoImiBCU2yLp5EWgsKAscdUPLDhF4j0JiJwWb7vLAA6dTKdTiufjTdu8LU2/Znkh+HPBqXFBf
 w/wOEo197sM0UI71mxEaJ1MoNSSTOOBbIf+YHOUve8DTMCiKEj/i5GqxWPw8AeJyOuB4xljFkLN
 5O6HQxJEIuROgZ1BFBYmFjwqRw/ENg==

On Thu, Dec 11, 2025 at 03:27:29AM +0100, David Hildenbrand (Red Hat) wrote:
> > > (2) tlb_remove_table_sync_one() is not a NOP on architectures with
> > >      CONFIG_MMU_GATHER_RCU_TABLE_FREE that actually don't need a sync.
> > >
> > >      Take x86 as an example: in the common case (!pv, !X86_FEATURE_INVLPGB)
> > >      we still issue IPIs during TLB flushes and don't actually need the
> > >      second tlb_remove_table_sync_one().
> >
> > Hmm wasn't aware that x86 would still IPI even with
> > CONFIG_MMU_GATHER_RCU_TABLE_FREE??
> >
> > But then we'd have to set tlb->freed_tables and as per your above point
> > maybe overkill...hm one for another time then I guess! :)
>
> I have a prototype patch to handle that, Lance wants to look into polishing
> it up :)

OK cool.

>
> [...]
>
> > > +++ b/include/asm-generic/tlb.h
> > > @@ -364,6 +364,17 @@ struct mmu_gather {
> > >   	unsigned int		vma_huge : 1;
> > >   	unsigned int		vma_pfn  : 1;
> > >
> > > +	/*
> > > +	 * Did we unshare (unmap) any shared page tables?
> >
> > Given mshare is incoming, maybe worth clarifying and being explicit about
> > hugetlb in both comment and name?
>
> I think we should instead call out mshare eplicitly, once we know what that
> would need here.

Right, fair enough.

>
> In general, I don't think we'll really use the "unshare" termonology a lot
> with mshare, as it's not really something transparent. In the mshare world
> it's simply an unmap in the mshare-owner MM. (mshare_detach similarly is
> rather a unmap operation)

Right yeah. By having an owner mm we keep things simpler than they'd otherwise
be.

>
> Long story short: I'll lean towards keeping this here as it is and not
> creating even longer names.

Ack.

>
> >
> > > +	 */
> > > +	unsigned int		unshared_tables : 1;
> > > +
> > > +	/*
> > > +	 * Did we unshare any page tables such that they are now exclusive
> > > +	 * and could get reused+modified by the new owner?
> > > +	 */
> > > +	unsigned int		fully_unshared_tables : 1;
> >
> > Does fully_unshared_tables rely on unshared_tables also being set?
>
> See below.
>
> >
> > > +
> > >   	unsigned int		batch_count;
> > >
> > >   #ifndef CONFIG_MMU_GATHER_NO_GATHER
> > > @@ -400,6 +411,7 @@ static inline void __tlb_reset_range(struct mmu_gather *tlb)
> > >   	tlb->cleared_pmds = 0;
> > >   	tlb->cleared_puds = 0;
> > >   	tlb->cleared_p4ds = 0;
> > > +	tlb->unshared_tables = 0;
> >
> > As Nadav points out, should also initialise fully_unshared_tables.
>
> Right, but on an earlier init path, not on the range reset path here.

Shouldn't we reset it also?

I mean __tlb_reset_range() is also called by __tlb_gather_mmu() (invoked by
tlb_gather_mmu[_fullmm]()).

>
> >
> > >   	/*
> > >   	 * Do not reset mmu_gather::vma_* fields here, we do not
> > >   	 * call into tlb_start_vma() again to set them if there is an
> > > @@ -484,7 +496,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
> > >   	 * these bits.
> > >   	 */
> > >   	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> > > -	      tlb->cleared_puds || tlb->cleared_p4ds))
> > > +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->unshared_tables))
> >
> > What about fully_unshared_tables? I guess though unshared_tables implies
> > fully_unshared_tables.
>
> fully_unshared_tables is only for triggering IPIs and consequently not about
> flushing TLBs.
>
> The TLB part is taken care of by unshared_tables, and we will always set
> unshared_tables when unsharing any page tables (incl. fully unshared ones).

OK, so is there ever a situation where fully_unshared_tables would be set
without unshared_tables? Presumably not.

>
>
> >
> > >   		return;
> > >
> > >   	tlb_flush(tlb);
> > > @@ -773,6 +785,61 @@ static inline bool huge_pmd_needs_flush(pmd_t oldpmd, pmd_t newpmd)
> > >   }
> > >   #endif
> > >
> > > +#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> > > +static inline void tlb_unshare_pmd_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt,
> > > +					  unsigned long addr)
> > > +{
> > > +	/*
> > > +	 * The caller must make sure that concurrent unsharing + exclusive
> > > +	 * reuse is impossible until tlb_flush_unshared_tables() was called.
> > > +	 */
> > > +	VM_WARN_ON_ONCE(!ptdesc_pmd_is_shared(pt));
> > > +	ptdesc_pmd_pts_dec(pt);
> > > +
> > > +	/* Clearing a PUD pointing at a PMD table with PMD leaves. */
> > > +	tlb_flush_pmd_range(tlb, addr & PUD_MASK, PUD_SIZE);
> >
> > OK I guess before we were always flushing for each page, but now we are
> > accumulating the flushes here.
>
> Yes.
>
> >
> > > +
> > > +	/*
> > > +	 * If the page table is now exclusively owned, we fully unshared
> > > +	 * a page table.
> > > +	 */
> > > +	if (!ptdesc_pmd_is_shared(pt))
> > > +		tlb->fully_unshared_tables = true;
> > > +	tlb->unshared_tables = true;
> > > +}
> > > +
> > > +static inline void tlb_flush_unshared_tables(struct mmu_gather *tlb)
> > > +{
> > > +	/*
> > > +	 * As soon as the caller drops locks to allow for reuse of
> > > +	 * previously-shared tables, these tables could get modified and
> > > +	 * even reused outside of hugetlb context. So flush the TLB now.
> >
> > Hmm but you're doing this in both the case of unshare and fully unsharing, so is
> > this the right place to make this comment?
>
> That's why I start the comment below with "Similarly", to make it clear that
> the comments build up on each other.
>
> But I'm afraid I might not be getting your point fully here :/

what I mean is, if we are not at the point of the table being fully unshared,
nobody else can come in and reuse it right? Because we're still using it, just
dropped a ref + flushed tlb?

Isn't really the correct comment here that ranges that previously mapped the
shared pages might no longer, so we must clear the TLB? I may be missing
something :)

Or maybe the right thing is 'we must always flush the TLB because <blahdyblah>,
and if we are fully unsharing tables we must avoid reuse of previously-shared
tables when the caller drops the locks' or something?

>
> >
> > Surely here this is about flushing TLBs for the unsharer only as it no longer
> > uses it?
> >
> > > +	 *
> > > +	 * Note that we cannot defer the flush to a later point even if we are
> > > +	 * not the last sharer of the page table.
> > > +	 */
> >
> > Not hugely clear, some double negative here. Maybe worth saying something like:
> >
> > 'Even if we are not fully unsharing a PMD table, we must flush the TLB for the
> > unsharer who no longer has access to this memory'
> >
> > Or something? Assuming this is accurate :)
>
> I'll adjust it to "Not that even if we are not fully unsharing a PMD table,
> we must flush the TLB for the unsharer now.".

I guess you mean Note or that's even more confusing :P

>
> [...]
>
> > > +		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
> >
> > OK I guess we need to add these to cases where we remove previous entries
> > because before we weren't accumulating TLB state except in
> > __unmap_hugepage_range()?
>
> Exactly.
>
> >
> > >
> > >   		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
> > >   		if (!dst_pte)
> > > @@ -5136,13 +5137,13 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
> > >   		move_huge_pte(vma, old_addr, new_addr, src_pte, dst_pte, sz);
> > >   	}
> > >
> > > -	if (shared_pmd)
> > > -		flush_hugetlb_tlb_range(vma, range.start, range.end);
> > > -	else
> > > -		flush_hugetlb_tlb_range(vma, old_end - len, old_end);
> > > +	tlb_flush_mmu_tlbonly(&tlb);
> >
> > Maybe:
> >
> > 	if (!tlb->unshared_tables)
> > 		tlb_flush_mmu_tlbonly(&tlb);
> >
> > To avoid doing that twice? Not sure if so important as will be noop second time
> > though.
>
> No,  see the existing code on the !shared path: we flush even if we didn't
> unshare anything, and I am not changing these semantics.
>
> The huge_pmd_unshare_flush() will skip the second tlb_flush_mmu_tlbonly().

Yup ok not a big deal

>
> >
> > > +	huge_pmd_unshare_flush(&tlb, vma);
> >
> > OK I guess the semantics are
> >
> > huge_pmd_unshare() for everything that needs unsharing, accumulating tlb state...
> >
> > huge_pmd_unshare_flush() to, err, flush :) followed by tlb_finish_mmu() obv, and
> > with i_mmap lock held...
>
>
> The tlb_finish_mmu() can be defered, as it's mostly for safety checks in the
> hugetlb usage here. For pure unsharing, huge_pmd_unshare_flush() will do any
> flushing early.

Right.

>
> >
> > > +
> > >   	mmu_notifier_invalidate_range_end(&range);
> > >   	i_mmap_unlock_write(mapping);
> > >   	hugetlb_vma_unlock_write(vma);
> > > +	tlb_finish_mmu(&tlb);
> >
> > Does it matter that the hugetlb VMA lock is gone when we invoke
> > tlb_finish_mmu()? I'm guessing not.
>
> It shouldn't, as it's mostly safety-checks only for our use case here.

OK.

>
> >
> > Kinda wish we could wrap these start/end states, it's fiddly to know that
> > you have to:
> >
> > - call huge_pmd_unshare_flush()
> > - release i_mmap lock
> > - unlock vma hugetlb (ugh god don't even get me started on how that's implemented :)
> > - call tlb_finish_mmu()
> >
> > Obv. this kind of thing can be part of future cleanups
>
> Yes, not messing with there here :)

Fine.

>
> [...]
>
> > > +/*
> > > + * huge_pmd_unshare_flush - Complete a sequence of huge_pmd_unshare() calls
> > > + * @tlb: the current mmu_gather.
> > > + * @vma: the vma covering the pmd table.
> > > + *
> > > + * Perform necessary TLB flushes or IPI broadcasts to synchronize PMD table
> > > + * unsharing with concurrent page table walkers (TLB, GUP-fast, etc.).
> > > + *
> > > + * This function must be called after a sequence of huge_pmd_unshare()
> > > + * calls while still holding the i_mmap_rwsem.
> > > + */
> > > +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > > +{
> > > +	/*
> > > +	 * We must synchronize page table unsharing such that nobody will
> > > +	 * try reusing a previously-shared page table while it might still
> > > +	 * be in use by previous sharers (TLB, GUP_fast).
> > > +	 */
> > > +	i_mmap_assert_write_locked(vma->vm_file->f_mapping);
> > > +
> >
> > Extreme nit: inconsistent newline here compared to elsewhere :)
> >
> > Not even sure why I'm making this point tbh
>
> Inconsistent with what exactly? I prefered separating the
> safety-check+comment that explains why we check for the lock from the actual
> logic that carries out the actual logic.

As I said, I'm not sure why I made the comment :P not a big deal.

>
> >
> > > +	tlb_flush_unshared_tables(tlb);
> > > +}
> > > +
> > >   #else /* !CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING */
> > >
> > >   pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> > > @@ -6947,12 +6957,16 @@ pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
> > >   	return NULL;
> > >   }
> > >
> > > -int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
> > > -				unsigned long addr, pte_t *ptep)
> > > +int huge_pmd_unshare(struct mmu_gather *tlb, struct vm_area_struct *vma,
> > > +		unsigned long addr, pte_t *ptep)
> > >   {
> > >   	return 0;
> > >   }
> > >
> > > +void huge_pmd_unshare_flush(struct mmu_gather *tlb, struct vm_area_struct *vma)
> > > +{
> > > +}
> > > +
> > >   void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> > >   				unsigned long *start, unsigned long *end)
> > >   {
> > > @@ -7219,6 +7233,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> > >   	unsigned long sz = huge_page_size(h);
> > >   	struct mm_struct *mm = vma->vm_mm;
> > >   	struct mmu_notifier_range range;
> > > +	struct mmu_gather tlb;
> > >   	unsigned long address;
> > >   	spinlock_t *ptl;
> > >   	pte_t *ptep;
> > > @@ -7229,6 +7244,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> > >   	if (start >= end)
> > >   		return;
> > >
> > > +	tlb_gather_mmu(&tlb, mm);
> > >   	flush_cache_range(vma, start, end);
> > >   	/*
> > >   	 * No need to call adjust_range_if_pmd_sharing_possible(), because
> > > @@ -7248,10 +7264,10 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> > >   		if (!ptep)
> > >   			continue;
> > >   		ptl = huge_pte_lock(h, mm, ptep);
> > > -		huge_pmd_unshare(mm, vma, address, ptep);
> > > +		huge_pmd_unshare(&tlb, vma, address, ptep);
> > >   		spin_unlock(ptl);
> > >   	}
> > > -	flush_hugetlb_tlb_range(vma, start, end);
> > > +	huge_pmd_unshare_flush(&tlb, vma);
> > >   	if (take_locks) {
> > >   		i_mmap_unlock_write(vma->vm_file->f_mapping);
> > >   		hugetlb_vma_unlock_write(vma);
> > > @@ -7261,6 +7277,7 @@ static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
> > >   	 * Documentation/mm/mmu_notifier.rst.
> > >   	 */
> > >   	mmu_notifier_invalidate_range_end(&range);
> > > +	tlb_finish_mmu(&tlb);
> >
> > Hmm, does it matter that if !take_locks, the i_mmap lock and hugetlb vma
> > locks will still be held when tlb_finish_mmu() is invoked here? I'm
> > guessing it has no bearing but just to be sure :)
>
> See above regarding safety checks.

OK yeah, I didn't think there'd be any issues holding those locks here.

>
> [...]
>
> > >   #define CREATE_TRACE_POINTS
> > >   #include <trace/events/migrate.h>
> > > @@ -2008,13 +2008,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> > >   			 * if unsuccessful.
> > >   			 */
> > >   			if (!anon) {
> > > +				struct mmu_gather tlb;
> > > +
> > >   				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> > >   				if (!hugetlb_vma_trylock_write(vma))
> > >   					goto walk_abort;
> > > -				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
> > > +
> > > +				tlb_gather_mmu(&tlb, mm);
> > > +				if (huge_pmd_unshare(&tlb, vma, address, pvmw.pte)) {
> > >   					hugetlb_vma_unlock_write(vma);
> > > -					flush_tlb_range(vma,
> > > -						range.start, range.end);
> > > +					huge_pmd_unshare_flush(&tlb, vma);
> > > +					tlb_finish_mmu(&tlb);
> >
> > Not sure if it matters, but elsewhere you order the locks as:
> >
> > - huge_pmd_unshare_flush()
> > - release i_mmap lock
> > - unlock vma hugetlb
> > - call tlb_finish_mmu()
> >
> > But here it's:
> >
> > - unlock vma hugetlb
> > - huge_pmd_unshare_flush()
> > - call tlb_finish_mmu()
> > - (later) release i_mmap lock
> >
> > Does that matter in terms of lock inversions etc.?
> >
>
> I had a cleanup patch to change some of that, but I decided to keep it has
> is for this series: flush the tlb and issue the IPI while we still hold the
> page table lock.

I guess my concern is lock inversion, but not sure there's really any chance of
that here.

Lockdep will help point it out if so :)

>
> (no idea what the hugetlb vma locking even does here, and how it interacts
> with the existing TLB flush -- not touching that confusing bit :) )
>
> Thanks for the review!

No problem, thank you for the series!

>
> --
> Cheers
>
> David

Cheers, Lorenzo

