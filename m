Return-Path: <linux-arch+bounces-8933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C49C2766
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B2F28423C
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2024 22:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9F1E0DB2;
	Fri,  8 Nov 2024 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EUxZyCn/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GSeIsijF"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D56208C4;
	Fri,  8 Nov 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731104204; cv=fail; b=MhdGaYfhHSk7n0OqJygYQANQKUxuDCekiRjbqUXO7BKLOGyIFVo0AcmrafiqctwRtCGDRWhKtvUO4mzIS+HW1kXWLxwYHColB23qLUJIoRGBy12nSYS7C53dOeYOfX8CFvLfmY4rvV7aD4vTqn636QqhgA8UzkTX7hQXVmZ39DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731104204; c=relaxed/simple;
	bh=SxCb7sJzOgMHli4PuGHDSqcmWdzh5ZnHk0EljJtp7vo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=mOmA8euufpS2eKyJ97kUyBLTwVsd8t58eiWAK2s7qeLDd6U8oYrohwbjAbHm954OK4jNqs7bCfFITbkPNQLurXvl5nmuXbGO9mnMlShpvbgiMnZGLucSYpadTJJtcvTZpm498JBJgNK6/fMx5dgggVerzM1VEsRrts60CWREEsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EUxZyCn/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GSeIsijF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FtW3U001560;
	Fri, 8 Nov 2024 22:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SxCb7sJzOgMHli4PuG
	HDSqcmWdzh5ZnHk0EljJtp7vo=; b=EUxZyCn/4j5QZ6H1TIkpuslYvVoRe3T2Gs
	UDX6eI/1sgA7TJohsBo/8ofcsJ8hYJBjw3mirdnPRLLm8FSZAWKou8C+H3fILNFf
	dpC9I8yaeSNWJaHw4dissfvuMDW8czlRQVkzakBAPWJ5o/L2JI1sveRs4nrLKLxH
	Q3xg99M1fa2EMWapxnqib/ZG2g3YuDK4ztDe4qH1SbMmU48Zjv6bRUQjujXeHb6s
	HMsC7ipMEKRfU6pwifiG0iPIusy+XLN8OpW1PesSfcYqsm/2a2WuBAv8WrrS1IXA
	+7idwVwHlLcJwkU5V2MXOoGYaCEQ3n6YYzDX9bcV+MHGlEArZkUg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gjjkkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 22:15:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8KuNJg033572;
	Fri, 8 Nov 2024 22:15:58 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahjaw7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 22:15:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+xcB78rkQX6D2FiTx2WS3v7uBMP3/VsC5XeLqEqoMnjo919/+v1CIDMYxUlFmItDEtglekuQ75Aj+XJsFNqxbXrOPaGnBejlsUymj9vlJuNvzr1XwmXWb0JvZnxYpEvQJdqyp6dUg5+EcZzHrMrgWXAcsuMFdzo8zr432bbHp7bW1OgC1e68BdwkQEjFIGFaK8puBjSzfXp5ZYZoABaKu/j17Rtkwa+c7jegkqLHBPOF2BMlowhJZPMglr/iewMzQDSAe3I3H/9Cl6Tmm6apkb+v9ZZ8oPTo609pyMgOmJw6YM6Nx3MJRoPADmXEViezLlqIl61Qwh3zmItQ9dw8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxCb7sJzOgMHli4PuGHDSqcmWdzh5ZnHk0EljJtp7vo=;
 b=EZU96rkK+zEStyzwfQo84vJpUR7mNQ/G8/gGYR6f35RCegD7c1ae+C9AfoarCQVai74vjAk43ETFwFPgp+W+NkVbrRTvFF6TF6UjhW0PwU+YOG5k/ItCEWX+2FH46xH4jeGXWwsvCX4G6qfB2EjHYizl6+wLufiEbNezy+iEThLU1+wHBV0m98whyw2rz67HosfnW/K6yvBd+WwQGdD3+2OCqtam21+JGz/Vw45+oNEzvN91AQ7FVvhQKLbZWW+cOu/TsTv4Kil2v+blca8llURj/hbPn3J1Ew8SYPbUztOIDnYgvv8IAT5MmGf2gvA4y3nU0FMxrbm4M6HnQtG62Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxCb7sJzOgMHli4PuGHDSqcmWdzh5ZnHk0EljJtp7vo=;
 b=GSeIsijFuJnmXbkUBiKFBQVp1uCwVsLNUHag+xJAUBaVJClPTu9qOyh+Qe3yGWKAlOCYwQiZdbQkGTG38KMQf6OOgH9cA4jjw69TK+tYXs0+tb7eBqmX+fGHVylXqiK4c+/RsqXPyBPxjIi6m/G/CzzcSVQbZIp0DtiJD1JYI5c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH8PR10MB6574.namprd10.prod.outlook.com (2603:10b6:510:226::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 22:15:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 22:15:54 +0000
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
 <20241107190818.522639-2-ankur.a.arora@oracle.com>
 <9cecd8a5-82e5-69ef-502b-45219a45006b@gentwo.org>
 <87v7wy2mbi.fsf@oracle.com>
 <88b3b176-97c7-201e-0f89-c77f1802ffd9@gentwo.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-pm@vger.kernel.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, maz@kernel.org, misono.tomohiro@fujitsu.com,
        maobibo@loongson.cn, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v9 01/15] asm-generic: add barrier
 smp_cond_load_relaxed_timeout()
In-reply-to: <88b3b176-97c7-201e-0f89-c77f1802ffd9@gentwo.org>
Date: Fri, 08 Nov 2024 14:15:53 -0800
Message-ID: <87zfm9z812.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0198.namprd04.prod.outlook.com
 (2603:10b6:303:86::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH8PR10MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: facddfb2-73cb-4ea8-a241-08dd0042e9b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BJk0J7prDDnfFkZYmXWUGGruQapudCq3TaPKZ+woI2ymX/haimtsTJm0O8T+?=
 =?us-ascii?Q?FE5ZTK2z0f8BxvJxojPHheFbmZopwiMwt0d7RjcOgME0c2G438qfS7Clcvzw?=
 =?us-ascii?Q?oNoNnVZvENqT1tafJQTOnFagcekbrzLjn1yXmKr46ke4mGV4FKrJ9XbH9W9E?=
 =?us-ascii?Q?orvvDyVQpnpAJbQzKF8GBtXGeLU+jWEjjkrE5eOA3dfCRZRuhCmwomU7EtAp?=
 =?us-ascii?Q?aIidlStbno3s6+YPEXlMbW+0/PVX62HoJqE9v5m9d+ecmkWaFrxCbvXLU05D?=
 =?us-ascii?Q?Na9FZ6J19oEzks8+3+nCidcv+DVAzj+QQnjtxR6TnoCLmUomm1aB9G6YlXxL?=
 =?us-ascii?Q?r58nTB8uXfF9tphhHrxblMJKjUZj0RgCLo1m5O5kRSynjeLnYTE9vM2P4Yg/?=
 =?us-ascii?Q?O1nQWk+9vVhPH+qGiT2G09EI7yvZR0Bdiw42ZlBUO2PQZUs9Jtcep+ht2K3S?=
 =?us-ascii?Q?TezDMd8uzQHaqtwVAgZgrklZNgfxfSqaH0OYk0mjNeXZXrddN2DfUbi4Se+3?=
 =?us-ascii?Q?izmGIKrspveB32ybFxmE+Tqjy8y0opm9b1qoRrEzKiv6PB755MrGQhWd0tnv?=
 =?us-ascii?Q?410r9nKHsWrZDpTsl8wQ2cLkMFdFEziktWink0Ybp0nuE2XPcd2s85i3Nd70?=
 =?us-ascii?Q?sZrzYH8888q/vOBcTtBO1S9ULb+300vMKMCq1Ql7kRwyvo6QvI+efWxgYERu?=
 =?us-ascii?Q?dYulMQuqE4q+LJczg9bMz63RLWrCJcIdL7h78K7w63CpL7PnPMChE3j1SV7c?=
 =?us-ascii?Q?5l60prheVZdbe1cGhNGbNuf2dVQ4+jZrbcI08rFSahhHvZbAOCqqld3Gom/r?=
 =?us-ascii?Q?zFZNRBQ4JTpvshCFgnpfuQ0vf7q8brKuFgpSU8OcN0S/UQhp/21c5XETOI5z?=
 =?us-ascii?Q?FZhHWjELTwwDnJX8NyRmN3ADVVDZc2Vg4eZ8GinRvJRiLAN5YVIgfCGqAVuP?=
 =?us-ascii?Q?gYknbJZz/z/KiBdAiawES3M3Qla8NOnEpvVzqncE8eCY/OuI0k4pVYQcTtd9?=
 =?us-ascii?Q?rlU+cp1gKgfCVsIlucrkg2b5oCT31CBXh4Wu5/eKiWia1KqxGJpr+QAjbg1W?=
 =?us-ascii?Q?9JhfrZXDSueoVqCOTiuDG5BXra7JNbpgRXg7gg4GGsLFBUWy3PX4+9XTJrYi?=
 =?us-ascii?Q?7TsZBgZsKhrLl+UPy0/YivTSPjBa8Z+r3Vjmo42u/7aQEljSqdjOBXPNvx1K?=
 =?us-ascii?Q?wmKKQ4NgcAZE+gOhtIfs1b3MLtYAD6eEMoNC0BUPtqKiFZABafWcOSh+LDfY?=
 =?us-ascii?Q?SnWnCs1VRgIoX6aJx35IbprWKGpYzH2tRPutBDg9BZQVDL3UHuvGs8P/xp7V?=
 =?us-ascii?Q?0DeuOi3u9HZyc+AhxOhWv+VD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHWpArepqVFezLj9rl41CpjGa01fwXpnAzmFsBzQG+HfWSq6u4eQozM3NEf7?=
 =?us-ascii?Q?DDhuUyApHcVMxN5BBZ+rPrsqBKc4Mb0XIaFleItYqQFzzpiUySDI6wUFpTrT?=
 =?us-ascii?Q?xUh4mlCgVsqek4QzgQSFGFiVkKxAxrTbOLGPDq7cZDkKtsUwi08gnSMFcwXY?=
 =?us-ascii?Q?RA58bA646XlUnOgkUr30i4BDyu1O1KRfoqekqzpvSbmYmTr3yjZw7aCwmPAr?=
 =?us-ascii?Q?6ybHkq9KKV5SQiwxf64QoH0eR/3bBI406WzjKqQdyJ+bBvYLd/962/GW0ue7?=
 =?us-ascii?Q?HePx8dfD1WNoJk2XKhUiVTF24XeYJg7wexlb7t5SRU/s2421YCiSvlHd6jZh?=
 =?us-ascii?Q?Mv0HyhqrU+E/GcQ7NAhQDDl58kpb2n8pSTqedStg+Lvw1/ZWiF6+2oU9joaF?=
 =?us-ascii?Q?2vxKTNLgQImimCx/xO92jK/yfN1n+I4RqAmsLJ6hWSmDKDsU1k7i5lvaxlxJ?=
 =?us-ascii?Q?FR4GkRZeiuN3UeTvyo/dehTxkovmWHA4dQdanpkshx+D3CGp9aPcBb9asJvT?=
 =?us-ascii?Q?zYJwuuIzWsftiSiL86nIt8Qe7L4Xnvo35tKCkckzuMP+7M9Ouapn6ggiG+F+?=
 =?us-ascii?Q?N1FGcPtupdcLvOiJxlL5PrtFeijtBF2eSQ4pwtlErBHyRIjsQGURj2UcBeic?=
 =?us-ascii?Q?vE5GZQEvKc2aaW4br0zVNQGnspaz8V5GnQtezWGBG2yWsweQjFRhaN2Giwo5?=
 =?us-ascii?Q?7UjshyLGDd8cilYavULeIIsRaotGuQ4YSOXz5YIxA/J/DISlZGB6dPOhiNHE?=
 =?us-ascii?Q?7YaLdDiwvd+KyR/G3jk2mF55Mhjg7pVV4kx2EPVaEofJO03Cx06peh9Ck67K?=
 =?us-ascii?Q?ki9YM6wxIb6CZXj7lkL0Ek2ZLrXGPLsoB3gFUZO4eisVxuabDqwHZcA028w+?=
 =?us-ascii?Q?baOIhaKQQUWXqGW1Q9GXPlU+zTEv2689QKlRotkg6mPdbYmZ1lFLtXSI6ljI?=
 =?us-ascii?Q?3pzJwIJ4KDr4uGy4QLX43cQy3SxSaqXfwxYZVlkn9cnv3J+SvFgrLX0/VcKF?=
 =?us-ascii?Q?ErU1ouusJKqJjhXIOIphr1grcUmw6xgdPV4L9T2EEC5g2VO/UEA7d04+p7Fo?=
 =?us-ascii?Q?nJH2LZGmg2w0p/GBVxBGSHfv3R77KPsV+ZBhb+1Y8qGHUZrg5fYHkNQB6xie?=
 =?us-ascii?Q?eZ5R/1MGp08hvJLvIkGAW80f7FhHFsEF3f7I0UvsviEdmgxA6czUldWHH1iW?=
 =?us-ascii?Q?VRUGEPMbjOLxzCEpmjl6wt4GoRnVMupZWQctJyvMOClUq4jgektNTIJFDtPc?=
 =?us-ascii?Q?J3iu0uJcaXCoi7m8xa6knlCvbpL/MaG36ucnODy55gw1SUcVI1v+lnKyhdNY?=
 =?us-ascii?Q?AkTXdQj5k7ZYsccSUJsfccICxrW70TubAlWH20EynZr0i1Eprl3r5lqWlF4/?=
 =?us-ascii?Q?AJYyUoUkCbVUWO0IMAxrhCPlFga2i6xpNWoUjTlOm8yRHo3YoqrYm8h8CL5o?=
 =?us-ascii?Q?tjgD1gN86VEaosp3vbFKbR0NZv6lEMlwqQzIdQ6NBRA9nVCg54epAyGZNtke?=
 =?us-ascii?Q?mnYgOcTPR5+2MIEEkh73mDhCQHtB6xPmMSmcZAYqyclWqUxj8rrPFlHr66Mn?=
 =?us-ascii?Q?vu+50d4e3qMjMmnOnyuFMyjAnk7timsj7NzUETtlgoJLGVtQdvlBXV8oXtbr?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XwNIxZWqkIOCNyL/DuWYfXOAoG1yjbJeRQKByGrdE+uh9n1GPwRobTI8yS8IbtFopm8UifNONzNjkNu1HbJog5TlcGh+K5UMWaWrqfY1ZyUfpLuERJr7aRfooSI36DCv7vVtN+ApRGazUS1rbOU4jvL4x5ifK8lldEoJI8rR6Sg9Z6+Rgj6/7Ws/QcCgXqhYbyvWiP55r4vNazipvu17qXRjPtmK71hLykC0DILhhh5V1tkouIbQwt8uRBXtVW8JF7RPI11TS1O3Ae6CcI5eVQY0ClCcOZWwdG3Yqdp4Vwxn2Tmnwpkpg4NiKkJVKUEnXLAaXV1DV49TEA96vSiHcQFI+8xcRyHH+JU+lrbgdf2lWDycfNrNOxsQcc7ZyT9XpUDItvhBWTm5DGsmsddUxwTEDMxtN4sLI/f85rImK3FDPcTyWjeZu2w5Z6c7iOVn/beyQ9pHaNHX/mQlnc6VFKWPX9hLBp7YnWr7QzMXKUHjREsOV9qnjRMG8iXBYWobPN9FP/SYfABllWajEg63CSt3Aezh8nl4ffNZaXKQ5obAjpHLJdlzsiHIJVMybYDHnbsfYpBkMZNXSnup40qOozauZaocgyWZflHgdoeTos0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facddfb2-73cb-4ea8-a241-08dd0042e9b3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 22:15:54.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTv4pQ8KxrckEmOSfXssghyK2GWX0/jwPVohIlZwXrjbwD1BbI6x4t50gqpgXja2WUnxtcvgZoH18s8mv2FirPmYJhfBSaDy/jG4T5oeRPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_19,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411080183
X-Proofpoint-GUID: lq3CPqPhEq5-f9avO23Mx3EJYYKVgH_4
X-Proofpoint-ORIG-GUID: lq3CPqPhEq5-f9avO23Mx3EJYYKVgH_4


Christoph Lameter (Ampere) <cl@gentwo.org> writes:

> On Thu, 7 Nov 2024, Ankur Arora wrote:
>
>> > Calling the clock retrieval function repeatedly should be fine and is
>> > typically done in user space as well as in kernel space for functions that
>> > need to wait short time periods.
>>
>> The problem is that you might have multiple CPUs polling in idle
>> for prolonged periods of time. And, so you want to minimize
>> your power/thermal envelope.
>
> On ARM that maps to YIELD which does not do anything for the power
> envelope AFAICT. It switches to the other hyperthread.

Agreed. For arm64 patch-5 adds a specialized version.

For the fallback case when we don't have an event stream, the
arm64 version does use the same cpu_relax() loop but that's
not a production thing.

>> For instance see commit 4dc2375c1a4e "cpuidle: poll_state: Avoid
>> invoking local_clock() too often" which originally added a similar
>> rate limit to poll_idle() where they saw exactly that issue.
>
> Looping w/o calling local_clock may increase the wait period etc.

Yeah. I don't think that's a real problem for the poll_idle()
case as the only thing waiting on the other side of the possibly
delayed timer is a deeper idle state.

But, for any other potential users the looping duration might be
too long (the generated code for x86 will execute around 200 * 7
instructions before checking the timer, so a worst case delay of
say around 1-2us.)

I'll note that in the comment around smp_cond_time_check_count
just to warn any future users.

> For power saving most arches have special instructions like ARMS
> WFE/WFET. These are then causing more accurate wait times than the looping
> thing?

Definitely true for WFET. The WFE can still overshoot because the
eventstream has a period of 100us.

--
ankur

