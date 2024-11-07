Return-Path: <linux-arch+bounces-8906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB1A9C0E9D
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9281C23EDF
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B8221F4DA;
	Thu,  7 Nov 2024 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RnhO4b3o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bm9LEFFv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3628E21F4B9;
	Thu,  7 Nov 2024 19:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006587; cv=fail; b=eXGODySaYQL11iDhpiEInpjIio6RBdBzi7xe+9TAicoZuqHDyEg/+VSXUh7au+Y3TBxPQSz0PcVux64KPzsOeFGr9IES7yHuavQHY3V1qhVsGza70Af8o+5ULbK8rstN0+9/MhLLKloaLBW4itnoxbe4FQK6G5Pj2IHuLEWvJGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006587; c=relaxed/simple;
	bh=RWXJsQAWI8E4rVsNQMLP0FS5DAXuJLgRTPgVysLDiHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UCZa/ISSb0raT4p7WGjiu/FfjBax4gvydjzXsbvLZtvoV+mEiikKuax5CkbH05xUR4BkNSsZ7Y9NfzBXNIdmYhSCXqcFf9onFlmKWuckUpjzUoJdHhsQhTyCTXjmgGn24HLL6C+P0zJlxcK7JGTjOFj9/X3uPiZnqXfkoKAPb20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RnhO4b3o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bm9LEFFv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBWB1025022;
	Thu, 7 Nov 2024 19:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fakUqzDmzaD3RTe7NO+yLwk8t6vTIFFk5+sqvN+b18w=; b=
	RnhO4b3o5Qi3hQFKGNlmNAaGBhDEMuizAQtwtgJqrv2m0RLdYKUdJpfhDybJgR0e
	CAGhI+bKrRvYdBcbSPW7wp9K0tsqToWDks/FV2RTym64n8v3+YFrryPRdaBvHr5T
	4dWOoaxT37afxq+tOeldpURsEVPGRqyGPF5WRlNgEBDlzGYGJ1I2SzV9pc24BwAW
	hDBSZYlI/nk9kyOQPibqJhomJbpH1WnxqV+1I9+Ex616Igt6Z9t8evjVPFFZrDJ3
	IisMf4Dp1IHep1IRWw/AxiQlV4E0EO36KnxKZ54IPx47SNWxKCzxhEkwo8GKlbsU
	0M0rfadmg3/zYxtqIKCqog==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4c3g45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:09:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Ho2IY009141;
	Thu, 7 Nov 2024 19:09:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahgt646-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:09:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvrAVstRyQg87Vo6qlf3PIHPCQsb7G+OYpxIQJS9Hur828scVHPoB6Lh1idmHatSbQHIKDpZUHzkvl2s5avEtYnjkj/YejwlUeoyBHwFO2vaaffHPLdPo/lQAgvG2T65NaeyepeSAwWpaM80/kxILls3fqNLcn4FMx5G+u0LmXP9UrxFuI2wJAODAheG/9zEQRDqwQinKhnl1hoM86t0Ho9fRCdkVM8gVgWyH3xy3ulp5txqvUQ0+/Tw9MTAbrpRM7chotAnCGt9wv4Zw0u2qGfyS0qqhTmCbVymLhXcPZcb2cALH61CRSDk8CYZqvYWHJgZaWNSkceYIwjesjEM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fakUqzDmzaD3RTe7NO+yLwk8t6vTIFFk5+sqvN+b18w=;
 b=o8vqaFcc2Oi9U/ZT5Sh46IpIP3fZCfEFrxWxitKHXr09ASKGr/J1aOhuSkqAR2Ca/ET9lzKANyz1JHNYTrzTlTXlv3SFbW6Q5WP6Z/JXkn8YYJ+VZHtg9dKc+wQNI5FQJrW2uDNpjtfAfRZyDaqZSRDTS6YIcwlpiL3sHr6pWKCPBb6bjzHjYQQLUs3Y4necidKigRO0TySOV6AOINsKAugMvtxWMTPp7qFp/4F2aBRP4kCpj+YXoAy2h7ohjy7H7qLQJ6za+q8r+JVsFeh5jQZ0VSkPX2/EJVmQUj8WSHmGCRgBRvk+WUxE0pEIbcWWGhZQCwuDyBrXF8AIFG4Z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fakUqzDmzaD3RTe7NO+yLwk8t6vTIFFk5+sqvN+b18w=;
 b=Bm9LEFFvMvMSp2OiQDmiStSQ2CbCdNaAagWSUiVdFXsUYutvIrBAQMKdfm21wUbN+3neaK5n0SKnGOujkKP2R4wki4kIT+aPtKHJVzhd2Q90v8PuX+dpS2ljd31hU0titZteMWU39xWOaU+z9hnzUHhWUmtzRYGDdfTHImvkZpA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ2PR10MB7037.namprd10.prod.outlook.com (2603:10b6:a03:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 19:08:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:58 +0000
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
Subject: [PATCH v9 13/15] arm64: support cpuidle-haltpoll
Date: Thu,  7 Nov 2024 11:08:16 -0800
Message-Id: <20241107190818.522639-14-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:303:83::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ2PR10MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: bca9db8c-87d0-439c-5148-08dcff5fa1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZhQTkKcUC4Td7e26bSH3XdKBIVO5Cl2ODNeSUijfkipAlavkwM32UAQjgUc2?=
 =?us-ascii?Q?yvckvNmKqDjQSHw62UOU/CJAOa7dFNvlHKUY9X0RG9As9sydu7ti7xnwPoUv?=
 =?us-ascii?Q?9pnaLYjCP6FRo6qu8UMe12qswUgIjir5ZtQLYw3TZC02oWKhSq6RGLIkrg8d?=
 =?us-ascii?Q?BI7Ej1MGzqb2tzoJ3lgbg/VS+9c411N92MHluGTNIWEvvtU5yXKJ+rSD/iLj?=
 =?us-ascii?Q?JYyIjgSiQveEC/WYsfOVRyVHX99Jqnlw+uxC2rs7MsQhXARUIQAbZ6exilQQ?=
 =?us-ascii?Q?dTNuudMWZEKJ61mO1JK7Px7ZmD8tE8WjOx4baraYxKZkEVLkbavvDuEUnEUP?=
 =?us-ascii?Q?IemS6gO920Dw4jB+4FY5Q0o3c0qwfpVTggACh7Swd7BgPH4CZEIwU8d0ZJDi?=
 =?us-ascii?Q?fwR6A/lxZwC9kNO2BekgYWHrjEM7EMRu24rKaiWcEbeTv7fbs2OOlPH+Xi5A?=
 =?us-ascii?Q?WJerfpYK085xadmwoDaF7i7ZtGSr2x3wGLg+ZlD06HpDEC20xbJfCzPbOJZ8?=
 =?us-ascii?Q?Vxxi63fdb2GDlPgSwD4Egoznv3QT1HW+lPtMbNDHrXMuQj9Mw/IWUI8rlr+O?=
 =?us-ascii?Q?IfMSR/5AZgh0LjdgMKsXH9/jorTn0FR+mBMyAn5eH1xN+8naxXosYnUoFCtb?=
 =?us-ascii?Q?fSuu0YFdLsj5IuihjHky1i7jbB+Fu/mkBaf5HVdjsTaWlPN97VEzguIKbXXx?=
 =?us-ascii?Q?UUEpSEYfMEyGxsDTi5U68tyM1EoOLSWAz/4L2VTYSFLcQst02Yxd1BNHukik?=
 =?us-ascii?Q?e8omoZe7G5Xo9IEKJpQRGp8a4A3h4685OcGpDt42/TtgUlkDUu3RnCvAkRl6?=
 =?us-ascii?Q?JMH68ZAT3MXQa+UeZoupWC7s4LJMR2BHsDj4UrHAJDACsoBlkHenv0nhrsq/?=
 =?us-ascii?Q?jpd7Kvcy3gUUqHTajg93WiZrVVCdxM7XDLGa9Vk51FmjG4BPdZsMsKJctTj5?=
 =?us-ascii?Q?8SdY0oPbwKkDTv/lJh3pbvscE6Pi9LqwMVQEFzBbRWg7qif8AgTpf9ypLjFL?=
 =?us-ascii?Q?qC0d8xPj+kilrk7r/os/qwOVt1NQ6GeHuH/cu5bUug67ABcEL3rr474wlUYs?=
 =?us-ascii?Q?BQ/tT18DeMEDLTyY8aDfnD6PSXlVhJECJj5xgHiJ+s1uwzNVJvMBdDtN6/yZ?=
 =?us-ascii?Q?2c5DKuNu27cHEaZSxToIH5x7EMiQyi+G+/GFOvfqKnsOla5X8ogZQQrngB5h?=
 =?us-ascii?Q?xp7UD+al0vdGQsipdYZ5Vgqad38O+6tbEBsT6C/5gWTrf8TAiEjnduDcJ3ec?=
 =?us-ascii?Q?Kj7jOgOsKVrukCHjFJ9OY9OfQGbRbqCCciJy2Kr72D6RUnzpMfIUtyo/NJjZ?=
 =?us-ascii?Q?Mao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kwkcu8nAI+qsTzzlYybgNe2cEDwHBE3rbF3n88dG0/C7ZUh2mQrJ9tzfiSo7?=
 =?us-ascii?Q?yL8ydx6gsRtY7bolm65Sp8GcxCcHMlIMJQHI9ySQdoh5I5lrICoTGIUJ2bVB?=
 =?us-ascii?Q?mnVtl7Fj1Ko8A4n/jbhUgVoH01j42UB4rFSwDhPahxMAHKrbu2qG/rkh4ta3?=
 =?us-ascii?Q?kt5IXpxheIaPnMwekSAF4qb9wryhzOvRyarAl1BpIoezalnSzck384mAwTYr?=
 =?us-ascii?Q?UmguG3OKKvWZAzrrq2y0VLs+YiIJSSY9fYidFw7ShfRmuHouALP5EO5baLDQ?=
 =?us-ascii?Q?YpbGI3arVzAsN8572e+8IzxgzmJTnoJL7qkPeHu5F9v8QM0E6bgRKBGYZSlA?=
 =?us-ascii?Q?AhMNpCyyJTgRcTNkEcqdTMpyxA9GE2HbiQchudUQzT+Tx5DWA06lDX77Vs6B?=
 =?us-ascii?Q?UteYqh4vRSbWfWpZ9WLfll79qrjLBXoxRiPe1lhF8XcmlAOD4lemPg96KHWP?=
 =?us-ascii?Q?UuEoAbvfte0aHzE/UNa+qSCA27dgXjjyK7+vLE9/pCCXrPef8oS6jj/zJeIU?=
 =?us-ascii?Q?QajftGN0XERsFTB0WbpJurs/5vDH8fwtH5P1bP99bY440w5sIwq2tnGBfALk?=
 =?us-ascii?Q?LUX0iz6b7BTYrrO3CR+GOPW2eo5sUpp9dzhGw60Y1b3MNqgTOBCUi/ruoISJ?=
 =?us-ascii?Q?yJmhYY0i03A0d+ZF3PrY9BpnRwOq52A9F8xGGZC9Vv4bW0ScbvX+Pau+/yJD?=
 =?us-ascii?Q?MRS2CFIIlGDihW7HvZW/ovN6p8jKRY8iJslnuo5BqbVVGsCycBweyH6dynJl?=
 =?us-ascii?Q?mQp01zcGn09GOE4foALEKWoMbiHMwFEzSk7XklknlXckyr4xB2yREw65bZ2L?=
 =?us-ascii?Q?ZW6L6VizzGWWVIPAqtIk+vAzF8YkUQYnkvFNAX+siPG3SEnElwN8XSwRwZBW?=
 =?us-ascii?Q?BpxbcqIKmWVAmFg4Qtxg8vl60T9KWAIT64Ho0/DPCmKKc/N7bis1aJ49i9jH?=
 =?us-ascii?Q?Z2GB3U9qzykn09Bc0WDIt13AAxVyq1Zh/DHh2EehPMiGbKFWBmYJAcBkuI86?=
 =?us-ascii?Q?mmxgEIK9YQT7dqOyIlV5oadT5zlP6coz+rlpsKPhar3cc5oiXyCN9Rf2jRbb?=
 =?us-ascii?Q?9c+2nPz0tLNpoGIKmwfTSqx51b8Rh5rKcxuJEWj3rg1KosJ2wtNdpIxLgeWF?=
 =?us-ascii?Q?t8tRHdCOfqLQLmqLbXFLvSxz8hyBOFzHXXW9QadHVVWqa8qe+UF5PJKWDHVk?=
 =?us-ascii?Q?y9/3kF3JJuOztCl+DREOnfOp9gaAF7+MWKCKg+ugdI4E46+Si2BVjqlziIWb?=
 =?us-ascii?Q?ScjGfyF/wXiDLxvk3UvDgQ+E2IMjvDYIoRSNYkHDt48ITOtMaR9CPa30ARxe?=
 =?us-ascii?Q?SYSR7ls3N/dkuoCMJMn9CHkfR0iCZvxM+MlKIK67t5kLKbBiYIpQU4AQ+Peg?=
 =?us-ascii?Q?lkvdmSSXE7tKiEdGj1hCrgk8pmnf7RMy+6BY/c3R20izKTaSQyA4a4+YrNeC?=
 =?us-ascii?Q?YrAkhWhSpB8OH+mfW6WmCW+lpR1hoW75LmFRX11R4+ONIQlFW8ZR7FGeZalt?=
 =?us-ascii?Q?1zuRgQbrsyypgQAUuRk3V6quIUiJbH1Y7wEsVudzaeUemV34XWskMlzJM0/j?=
 =?us-ascii?Q?UMcNs4ETIfQ+DnGk/Xzmcdfe81dBxx62AuVXlO7E6MkHf7czJDe8CsZK7qSc?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HIGWv/xm1U6W9CfWIA6P4E2Mon7cJGYYaWGXp5TblZbRgDUVtAQX2wQdWzCnhYnx21xWIhG0vTsbxhC4tZHMherEYtSnYfIk1ev9FdBsFLkSYqr/5QitpixF1hGCJPh1LgLWPELeM6jRTFOnDyPlUJHQrzLPTeU1d/klbecQ8udHPayQTfOPhsj3C2R0MWP1odGaoDHx8qXSHQsDO2jA5Kq949EFcWuV43D1dGEIU+NCEsB1c8y3u1LC73Mk0JlKdyaBWO7JL5kYJyvAtyVa1gZXS1VfPPF/zzzEK/8QdVP6zADAnXPWJynWqhGXknwMx2WUu1Df19GPSukecZ/zt9C+5DaJ1i4CxVYuTK86SSStL5+2/KJw8scV7P17VSsIycf2xJv7yVXSBMlk71Z8RZh6nkHe+xqy1RS8VBakIeKswf0EUSRHoE2kS7LNhD16kG/Ad31HKL7cDvgO1ziGwD305oCcR52KwBuy7tUiuchofLZbpEfxB6peJ3xqotXTy3p4h7RiRGquDzCsnQLppjfeh+f6sORBscMWBJJBV5SZe+4PIAUBXWsTAgBfjjrHes2UBBfKlBGt/F2PFNS4ueuhuHuP4bL6kRB1438Ui4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bca9db8c-87d0-439c-5148-08dcff5fa1ae
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:58.0985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sMZfgTFZxtVnTX56hkvD2RHeB70+o7S1t8NW1pGweB8qLmuVChcbGCJJpiAdIS7k3pEVrebB3s3Zx2MTOdCL2Cvfu+DAZ1sev6im2Q3Rtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070150
X-Proofpoint-ORIG-GUID: lnBww-DGDsumJYMSR3YzDvrNzQ9WGIfl
X-Proofpoint-GUID: lnBww-DGDsumJYMSR3YzDvrNzQ9WGIfl

Add architectural support for the cpuidle-haltpoll driver by defining
arch_haltpoll_*(). Also define ARCH_CPUIDLE_HALTPOLL to allow
cpuidle-haltpoll to be selected.

Tested-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/Kconfig                        |  6 ++++++
 arch/arm64/include/asm/cpuidle_haltpoll.h | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpuidle_haltpoll.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 43762c68e357..bd00647f6013 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2428,6 +2428,12 @@ config ARCH_HIBERNATION_HEADER
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
+config ARCH_CPUIDLE_HALTPOLL
+	bool "Enable selection of the cpuidle-haltpoll driver"
+	help
+	  cpuidle-haltpoll allows for adaptive polling based on
+	  current load before entering the idle state.
+
 endmenu # "Power management options"
 
 menu "CPU Power Management"
diff --git a/arch/arm64/include/asm/cpuidle_haltpoll.h b/arch/arm64/include/asm/cpuidle_haltpoll.h
new file mode 100644
index 000000000000..aa01ae9ad5dd
--- /dev/null
+++ b/arch/arm64/include/asm/cpuidle_haltpoll.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ARCH_HALTPOLL_H
+#define _ARCH_HALTPOLL_H
+
+static inline void arch_haltpoll_enable(unsigned int cpu) { }
+static inline void arch_haltpoll_disable(unsigned int cpu) { }
+
+static inline bool arch_haltpoll_want(bool force)
+{
+	/*
+	 * Enabling haltpoll requires KVM support for arch_haltpoll_enable(),
+	 * arch_haltpoll_disable().
+	 *
+	 * Given that that's missing right now, only allow force loading for
+	 * haltpoll.
+	 */
+	return force;
+}
+#endif
-- 
2.43.5


