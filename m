Return-Path: <linux-arch+bounces-8622-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F349B1612
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 09:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3E0B21D97
	for <lists+linux-arch@lfdr.de>; Sat, 26 Oct 2024 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112DA1C2434;
	Sat, 26 Oct 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UmUN3O2r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="epyOhizP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3609190663;
	Sat, 26 Oct 2024 07:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729928588; cv=fail; b=f8gEZJKsFU89O07GZqMZ+0WTmWG2VToY5KN7U4JtlnyBAr/MEjq1Pi7CghTSRPlJOU2c08UqxSYIb7UN4gULvmPP2yrJ37wl2LvK1MhPK0kA4ghaobyzOv6YEM/coVy0FWprVtVgX4dMl4oWP+BKZA2I8GZSm9oqlHU3xUpTN/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729928588; c=relaxed/simple;
	bh=Y/9lxSXiFLZL280nirlRFkbnSpofaVOHVfQZ+cOiOtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PyqCQZG3I7w+Zqqrv+U+T+rAini+NjoIwhpWJzyd2139a9vKgI0KIXkctuj0EoeogaUqXiXudZYJ7s61m/X9lmxOI00C5t7yJ2l/nLIMcsTQdVFja3wAWk7zCaOsa+nPG1mUbAsPUCR8/D/DBHpp8GcLaeB9FoBDCk5k6z5eNVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UmUN3O2r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=epyOhizP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q5qHRj017637;
	Sat, 26 Oct 2024 07:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Y/9lxSXiFLZL280nir
	lRFkbnSpofaVOHVfQZ+cOiOtU=; b=UmUN3O2rH1wsEU9366/iTlGNRlh+fVi2EP
	2LauJorgaDl4V/GZDaVM/CpjJVflHAm4BFsetClrwg2kr9/7YuoEicpCM56LAImf
	UPi4FX5EuQifOaIRztWO8j4DW7OK3IcUJuBlD19mfVIi1HYWr6VRuiiITupiM3Sz
	DVJo3VgNpmFw95HfwKAb+waDR7JyqDocmZ6XaDF1vqJtIi3fSfPBA+cfB/x5X5/x
	Y/osPEBVPbryjd1GWWRMMbjbtYgoPLBCty8Y3gD+kc2d42KogdzKafj20aPCGBcS
	wkw8CXtmbWU1t8ROKCeQO1SasDkunOcGMUlWARjJKqA2KYjGz+3Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc8r67n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:42:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3Dja9016396;
	Sat, 26 Oct 2024 07:42:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42gpv455p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 07:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJHRf/y9ywmDiIkU63iYMOzEA3y6EJL5QXhhwgdxfSwK8nT0hrI6pG1cdgaEyr4nEdcqwaAEKo4SXJ6WjzYgxuIHSVySdP0chvSYdn2sPWLKfnBSQcobBh3JihCVhNYxD0D95j/At4J2sxXtUeeYMAVpW7DSoWbKYnNYZXBETDzGl31aGlDtMumLeYY2AfgmUKBOJq3+ZhHaa9psCG9O7BoXalWx3775GXdA+9y6wDUd6eJszm+c9jwRuwLCdXgMMySnm0Mc9/SBH0TmxxtmFglYzH2ENl95mOdnR3Pa2z/1ZyEzmkbe12bCcZl6q3xShlto9uaH/lqmJQyjFzrwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/9lxSXiFLZL280nirlRFkbnSpofaVOHVfQZ+cOiOtU=;
 b=rLVktQ/mjo+uFs9HE0zkVXyHUcgHvKKz/yzLqG5kHYMcDmQHJ3tIRc4bihDIiPSznH+ePsRto2eORPQat+qTOO8Tbf2Uw6c205SD+++f1MvkMc8QHMsh0qkj+syQ9QC7nXWVa4StGTU3g2tKYZGxGw/mlJ1CzmUZ8E/ZUOWhJNAY3R4b7jtQ/EybcQuL6xSw7/YAw44hXK2RTjs2bNkR2qhUDMHhzVUurfP6zGaIRuDLKh6wsCrxmwbawFAalf+Dd0Rcu1CeOeNfjpW0c8iO1/OXyZ4PmiV2gN8/UvllJFc0Qt1TST8HO7ArtUiNzGKJMa/C7lLcjO7qIlaUiWj4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/9lxSXiFLZL280nirlRFkbnSpofaVOHVfQZ+cOiOtU=;
 b=epyOhizPXUX1IVW09BKcfFNhkE8Rsolx3qNpqMeiwrcsBIiHRydcMRviLaLYqr+KJSRkmHp+oTQh47GY+ZjUKJaACz/Tb/24T9qtzCiI8i56wRNsmiZjh8C50OcsoWmc3j4EJ6shR7xMB2eP5s2OiMfOtf2ualDauXyCUGAiy3o=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB4854.namprd10.prod.outlook.com (2603:10b6:408:123::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sat, 26 Oct
 2024 07:42:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 07:42:32 +0000
Date: Sat, 26 Oct 2024 08:42:30 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
Message-ID: <dc180613-1b55-4e8d-b365-a501cc076474@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
 <20241023160405.33995c68f20c141325a8fadb@linux-foundation.org>
 <635de052-35a6-40e0-82ea-4349f3aecc06@lucifer.local>
 <a089ff3b-119e-44a0-a780-3abca01886f7@redhat.com>
 <e62ef664-1c71-48e0-a695-6a53b6d46922@lucifer.local>
 <c072049b-d6ef-47ce-b281-006ae0f721b3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c072049b-d6ef-47ce-b281-006ae0f721b3@redhat.com>
X-ClientProxiedBy: LO4P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c57c7cd-e877-4209-4883-08dcf591c03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PD/Ph3ylJJoF/sLk/K1cfURwlL++XHsLaWleTfpDBGbdKs0KIg+2XtOVULGi?=
 =?us-ascii?Q?vScNRz17FEeYFalufEISaZMC922H8HJlUxIqsMymogwn2XwuUoSfk4dfNtZl?=
 =?us-ascii?Q?wjAtcxQbSRG+dm7GR+rL1djTZ6dKtyvLw2o9be6WLFFeq0RXAjH51QR1/jm2?=
 =?us-ascii?Q?eLi2bdhIvJxWVdnr02OA93frV/e5YrpLUld/qil0VmKoO+otrKBSXYixsxVa?=
 =?us-ascii?Q?prvO8IC3ruPEcuKFDJ8NYjbZ2cCtkhqkAJMC8DAQgni3LqnCedTyijZdCU7h?=
 =?us-ascii?Q?kC7WbMvIW8cDxejUM9LPMd9rpMFMWA/tbtnduNG1Ceqcfh/3WdrGf1DAXqzZ?=
 =?us-ascii?Q?lh51YU8a0AoWXDQnV0zw2rBcNUCctKhFuBm7i0g0aBqSmIQDpp2h29f+mZ5z?=
 =?us-ascii?Q?ZxVysNyOJPJ4LOrj18ZYHrt6Xc9InNd3L9VCPB2CzbJCgI1CmVp2XHTZ/cqx?=
 =?us-ascii?Q?FwqRzKZeYxhxeMhXvb/EH41oj5g8ZioopyHfZ0DyPrdiFo3ciblrA2sfd667?=
 =?us-ascii?Q?c5eGIjE9oo+Yak+hrKwXcBrKMv6fXD6CiibBmSdo5GNUFve2kLx4EwIG7sC8?=
 =?us-ascii?Q?Z7vSoLt/lOpL6o7Zhizm2ARe31EIEzLWH9Qctq/vZpAQapbV4chX+7jAPDP2?=
 =?us-ascii?Q?0dwX6NnVsDs0pJen7jw8Udzi7poTMhdZ4FwpYC1AUWIhJopVayoS321p/82G?=
 =?us-ascii?Q?3XyHDg/TR0MrvpHMTusYiteT+Vr6TPIUdr2CwPtuwVqh5cXDjSg65Wr2JY4I?=
 =?us-ascii?Q?Il8fTtO0i0+fPDfczB229FQA2UvlUrPad4EgOAtteRNDP21eTx4yUS6E6X0v?=
 =?us-ascii?Q?QEO8u4M/LP41l/KOo+ANeunSEc3gc3X/2E6h26wtQcRLbuG3o+Pp02nlPSna?=
 =?us-ascii?Q?/dhxwinYyOlKyhOWpCoQIecVjeGlBibe77S+KZG9mWHrFrl4fzmZgZBsxAEC?=
 =?us-ascii?Q?PcDIx1vecLhj0XUKofK2FhVU2MgX2BJUzd2CpzKCABkASCyuLahvth5v1JtO?=
 =?us-ascii?Q?RM00wRWJ2xCrp6UBUorbgBLFK//nfxzsm+TdilsGaP6x+i3mwgkG12f5ubzF?=
 =?us-ascii?Q?HgejzCGJ+vKwz0qzPh2USfgnq838LdxvJSJc8RZ1DejZXwP32hydtoKFS9tm?=
 =?us-ascii?Q?pcWvf/UQv8rc3qeGEsayIB3F/M4WUbn2rhUVfcjC7zTc0Wfftri8RN6W+XMn?=
 =?us-ascii?Q?qp1KZXWuJCR+twE0VEuZSWOBBh6f7xR9sh15d6JXqKKGKVGmXkuKy0XHqFgM?=
 =?us-ascii?Q?Ni7FLo34UtBHURuemDuoGu9SZdvntGgiaF0t94GVr8o7YdRMQyvJN5C0/Ro9?=
 =?us-ascii?Q?P7WYoGKe7JCA1f4KWHPRo/i+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/pGCOW8kX4RtbSm35e0KdFOat7l59+njL8obPcUGdyVjbCzcBzC6s5AcZNB?=
 =?us-ascii?Q?KhuWDr0gmd6DFR0GiiEpA0My4EHyv7bYngLyYbTYQRlZhW/BKgYkt78ZTEPL?=
 =?us-ascii?Q?VA9KK/uQo4yztS17XhNhMfUerVoCYGrhqAZrSGd02UkN1QmeiIkL46QikpHk?=
 =?us-ascii?Q?jC/m6ZCRdauh+i8yw//lPjS+OPLSgQ+Q7M3VsDLM1bKwMBJ+E11WKOHIpJxW?=
 =?us-ascii?Q?EDpE7jfr+FH+Mmr+xeWUXnDKJaLv+Fm5tJbaxuHu3GXE8oek9AHx0+WeFLiB?=
 =?us-ascii?Q?IQPZgB0GpO8F+PGDaD4/zNha7/mV8RFsMqJ8WexwAV97j2f98mxSbdQuGdLM?=
 =?us-ascii?Q?M+AzOv5P3ew4y0+xe6WuRIgMYZ4mUF8KCzeEjDuUp6U7thn2IBamy2QVZ4BI?=
 =?us-ascii?Q?MlFO3XtdYWqvz72gMYWxrfyzgsFdN6otDTcQCb+tysg7yL9rGHq/KRFdQOGk?=
 =?us-ascii?Q?mG6yEtYBG1aCLQ8Na9Q/vzO9Muaij36CU32ItrSGKGL7TvFKV7P6Qul1D8Hk?=
 =?us-ascii?Q?2YQUnLTpOeh95TyIF6xNtqdSa8786NnQ3N3GDpBrI+NnrMdDrzkcU+SyXeIV?=
 =?us-ascii?Q?yRL32Yohs5jYgD4EbxeK5KjPTMyc0zSE5UrdtF5PofevF/dg3GSKJQBb0qM9?=
 =?us-ascii?Q?YAE9/AEkY+5vNI2C0VOo8JTqyuQjRBFD3QrH5URx+wqiJ9frPsiqXBg7ltWq?=
 =?us-ascii?Q?BnywUbfVOCZn8+SH4KHitwunBS4ECzFR6Fox/nQ3PMthCOfbF9wPntsvCvr0?=
 =?us-ascii?Q?nCiX5DG1euu2O8im89+gXzgbc/66GTEubCy6vKAT1QPajtImTITkoEdQfbiu?=
 =?us-ascii?Q?rHturXBBkI2oYObldKgmcVhEJOESGbo4AFGcl7UIQjJgr4mY5VbYe+mUDA2i?=
 =?us-ascii?Q?RfMXw7dbHicp18pDK/8s2h6firBW3UKpIprYR8vVgQ59V7kynLU4t5NFMb8H?=
 =?us-ascii?Q?zvPtzx8nQ6MNJJCD7coErH0qYWiZfCpNvt/WJNQTENqmyV1f5ZwnIVfc2K/V?=
 =?us-ascii?Q?ErYnBM5B9julXuaGdpwmrUoxvr0HFFR6sigj2+OUPWgrAhUh8D2XZ8uC5Yw0?=
 =?us-ascii?Q?OnZCJVlJh8v5cYON2BvLmWImXPQ1g66wVnTObiuVoxPxtX0/0t7BDclGOaZJ?=
 =?us-ascii?Q?6uo/vwvDbZ6JLBxkeiBkvwV4z4UHkTOnRl1VyCQumHZODS6smILYeiTlUjn9?=
 =?us-ascii?Q?jHa3ppuvCs+iAVO7UFF45LpzR7I6fFTqdflGd3Ro6YLFVGjR1mnyIQDHQygO?=
 =?us-ascii?Q?xvecYbBAGmNEOAUsk2ofbvoJkKN6Ew+Zqo8u5qDXEptqhxZDHjxR+bPHjn3y?=
 =?us-ascii?Q?Btm8TZKV12fFAPBIPS4fSFM22q9KvoP/a4R9T2+Ou6ZL5ccexLwJ3/wsvWS0?=
 =?us-ascii?Q?U3wH9qL4pmcmGfpheGFKNmrQ+BHPaebLYsrC6AdkgGjn/QWTxCg/dHADOGvm?=
 =?us-ascii?Q?+E8Ydthu6XSKff/yLyWKDkb5fCVeCPzg+W2IXIvSrcD3OLtSfxT1lCAuRo2K?=
 =?us-ascii?Q?s0gyVPSPwmNDxacXVhhCb5Oy3Nr1E68croJ1CuARQlp9I/6slTZEHRVeQeCv?=
 =?us-ascii?Q?W6XUEp5jRXaWTdIhosHKGIq+RibGtBtOvHMEGWa9qhlv9XYhljtAnTKs+OaI?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TyKQLYPn+CnBNgPolkq7G0Dw0s46mX/DXmVxw0yMZwyKafb2un9Y10l5WFeUhK34ljdLAQfo/rdb4k4qeMuG/G4J4w5Oxu8YNK/zV5XOWVZ3qRUxH1332/kfsnmkHQAOBa8W+k8QQfD+0xDc7vvyGFfapESiwwmHkBWVOBhTpX5ZAkMWB7viOL0P/5bdvzb+5LRHjuiZTZ5bVsppESPg5Qq2yshEszyzcLHsrfTfYp5O7pa24VXHXNiWtep/93fS6bL0Ta1iys6NIr3aWCDHc4GKSwjHETChPAb7KBBcjmnwUXoBeqBu+JSg2FtSoMCirXru2vngNwvghSM82a3yB9YpHofcy7ajbSpWdetSx0YMtHEswHrxRr0d5W9mvG7kiYjPGcbeG3aFLMpS8azEpZQ7kSjnHr4saxBv5tT+9mqhQUv7s79Tet0tMS+uvgUObwiz0tBaJKsHPs8k8ukzOZirCQaGdBS7oiaphHG9CFhX9vBliby1LeP7uTY7zssQQVCagdtrXMFfHLy/m5sg8+l9a+Nv2nrlijc88jtpBEu00Jh35l7lh3p9KVi2tIk8btMKGMqY5LkNSKZKO5NfAwsQK940oog+/iOmyoyzBY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c57c7cd-e877-4209-4883-08dcf591c03f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 07:42:32.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPYrtnHmDMqJVYoXw7VuyyDWpgDDDXnpUyw3mdpXNZZ75S2i+lRs9xxTBLTStdkgRBRt5EgC/DjgNWp38sUtHmRpHELKYHW9JYENZ7fraLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=771
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260062
X-Proofpoint-GUID: 5oSQ5VQ-H1tGXWIssuGImHxoCSjs5iJ_
X-Proofpoint-ORIG-GUID: 5oSQ5VQ-H1tGXWIssuGImHxoCSjs5iJ_

On Fri, Oct 25, 2024 at 09:08:24PM +0200, David Hildenbrand wrote:
> > >
> > > We already discussed in the past that we need a better and more efficient
> > > way to walk page tables. I have part of that on my TODO list, but I'm
> > > getting distracted.
> >
> > Yes I remember an LSF session on this, it's a really obvious area of improvement
> > that stands out at the moment for sure.
> >
> > Having worked several 12+ hour days in a row though recently I can relate to
> > workload making this difficult though :)
>
> Yes :)
>
> >
> > >
> > > *Inserting* (not walking/modifying existing things as most users to) as done
> > > in this patch is slightly different though, likely "on thing that fits all"
> > > will not apply to all page table walker user cases.
> >
> > Yeah, there's also replace scenarios which then have to do egregious amounts of
> > work to make sure we do everything right, in fact there's duplicates of this in
> > mm/madvise.c *grumble grumble*.
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
> > OK so I guess I'll hold off my TODOs on this as you are looking in this area and
> > I trust you :)
>
> It will probably take me a while until I get to it, though. I'd focus on
> walking (and batching what we can) first, then on top modifying existing
> entries.

Yeah entirely understandable and that's the right order I think, the
modifying path is the trickier one especially with all the special cases
all over the place...

>
> The "install something where there is nothing yet" (incl. populating fresh
> page tables etc.) case probably deserves a separate "walker".

Yes this would avoid all the heavy handling a replace handler needs.

>
> If you end up having spare cycles and want to sync on a possible design for
> some part of that bigger task -- removing the old pagewalk logic -- please
> do reach out! :)

Thanks, I may have a play when I have a brief moment, as I feel quite
strongly we need to attack this (as do you I feel! :) will send some RFC or
some thoughts or whatever should I do so!

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers!

