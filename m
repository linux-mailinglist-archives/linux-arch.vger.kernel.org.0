Return-Path: <linux-arch+bounces-12879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80770B0B973
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 01:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C863B673D
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jul 2025 23:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DB22A7E2;
	Sun, 20 Jul 2025 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8uIcMGX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iwfGzvft"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D31F09B6;
	Sun, 20 Jul 2025 23:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055935; cv=fail; b=WE6UHTKy7iim8PPXqpn2StWYQv1vAismqJi5h20G16hFCkQ3kQkBzbM1wy9z+qidFcKgpyubaPb7ooh7JTyEAnmV/FVTh3E8uERuMfRK5274CXu+QJldD+lDKtLFlZHtTR4uk+zPefdXekJm16ygK4HKK+jg+Yq403ciuPCLL0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055935; c=relaxed/simple;
	bh=w0EsjOSqPz3YC9PVMFWZSZcvRC2Eiz/ZDKOnl0A8R2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pkS4yIC0G7jx+sA1AcY9vpqQPNOcFZaTvi6licXAB7I5a/j+ALpEjiX5ufkC8WI27k/5oKF8UZrOvpE3iaERD99ypC/ZTML8ScnkTYmaMAovoS0aS81IATAtBPMgYjXl3enOpTXgRL2cif8XkfRUf93khN/UgPrDkx+YE1OCw7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8uIcMGX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iwfGzvft; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KNvLgA029354;
	Sun, 20 Jul 2025 23:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=V4wZybweGMBMIWigQD
	gOJEuJwNROvK5S5uvi3O7GNO8=; b=m8uIcMGXqdKSn8aTK3E+omtczLTf8NSnVp
	TZNEXkCFy9lf8DpwpWONXRx/zLR1C+BygFw3ekTcve/ZCYhKGmtknhBj4k77OyAR
	4Zj+YN79eC1te+aCwNd+VB2NHJSYLxxL5I18gZLCyTmnAwtG6kKWgnc/T6wuMKYk
	A2wqPc2Zy1nnZ/9PSrFUmd01pj3tKwwsb3CZK1y5ZsiKvhn4CLfxsKY783QSnsrc
	2fPfHE0TG5Fb5+PZ1h+3r7ZdhAEJEb4pZ3KJGeUwWkxptGULas2GBZDWeqVOcWH/
	L1zuQBa1VvZnpgxasL2kpRqbF1Bs3I3RCa84ZJ9jGv2r0L4I4rBA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056e9jgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:57:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KJwOjE005752;
	Sun, 20 Jul 2025 23:57:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t7ehc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:57:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssxLyBL9uwYZG4ProoGqDdPYLyiBcsSNyg/0m3esBT2nSsAF4C5Dkm0Ezzkgeq+1dq8Xr4J5pH/PZykEe1SgNSOQbFnFEfitEVeHS/Hr/prI7HN6g24inJC8V23/Po0O8nTV5/dcA8ul3KPcl+x/SvJYsPb6ZEXFXW4bc+qEBWIHk89OJkUzaSD3EivOogLaZY/fcsb/YIquWMSab4kFs+oL8AG3XowxfV/MXOMK3cIrqeXMKdM+q39UTqOvF7nR/G7Q87ruS3kAhk/6MoZW+i15JdIVQiNNH7ASJtnA20L1zFxLwDxEsajZ5iyW8WyhgmlNqCmARhlTgvqfqJ8E/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4wZybweGMBMIWigQDgOJEuJwNROvK5S5uvi3O7GNO8=;
 b=dK8Xo5llSQbtYTJONxJRorG6QZxmkNtjTojrEN/x1M8gnEkU5b5rqel08MLGm9R0h0JLiMV1VZafaO5DmjrpMRVG4mmLOBeLZ5xdnY1PUk8bItZyJi6ZMMkX36REWZ0NcOuPLh6NGn44LdMOmPwGvRhozo4a9lDrt7KKB/Zdf7mB9ZlKM8x8N4v3CArD9WHCPcHTqBRbLAjltHWHZ7G5LrhKRWmriPcTykQQfgtDS5VDc9RWUnilkKZ4DfGCYB3P90hqefFn6uUcY/wmswRyApmqCQBL5nGV6HM4kAYQg+pl1I2gLu+fnbPKqNzceb1bqfB3ezCvWqcIcDGv9SHePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4wZybweGMBMIWigQDgOJEuJwNROvK5S5uvi3O7GNO8=;
 b=iwfGzvft3/Dt/4OTosVDxTN/eSdEZU3MeYJD92LYqGC1Wjp2DnC6iUeeiAT0xOJiwbamYFmLCfUAagZPIcKQXpPwxejvdRh7jM/446S+JHuIjFXIYG8tYSTuvDMQ2WP0fiCsjLZ+MAcA6B/+H0/bupWYY7CewUk008VQXDD3Oak=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB5703.namprd10.prod.outlook.com (2603:10b6:303:18d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Sun, 20 Jul
 2025 23:57:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 23:57:29 +0000
Date: Mon, 21 Jul 2025 08:57:19 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Uladzislau Rezki <urezki@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 mm-hotfixes 0/5] mm, arch: a more robust approach to
 sync top level kernel page tables
Message-ID: <aH2CXyyrYbgtUXJB@hyeyoo>
References: <20250720234203.9126-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720234203.9126-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SEWP216CA0108.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bb::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5963af-24d7-40df-684b-08ddc7e92f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hav52vv/v8FMEWUc2nY5p2/jtPdjy5DoFytiHY2REmwNnhiwcQXVYppUwTfU?=
 =?us-ascii?Q?TukpHC3uYTmV15gCuNdG90uFMH/0eIqo8huFAqeNgMMfN9kmz0dLg/XzkWfY?=
 =?us-ascii?Q?+n2PdoY57vn0oYeCgW1CLfGWXVwRK2QURoXMYAGs8OX4P8bR2GOD+LisCMtd?=
 =?us-ascii?Q?PcmhbSmdCj+5JTgl1EtRX672MeJOowBDJgKrios6Ci7PYs9fAIbD/uQnSuIc?=
 =?us-ascii?Q?mbkg8L+hL1BAKn59EElEZe5IzzGQKv8NTWp7/nF4IxmFDKb9HIs6AAHuGf04?=
 =?us-ascii?Q?0Sgl3ZFy5VKdhrvmkH8/hYBLQRuhm+i2UUKjU+Gans2YAQrYdLsmOpVLUa8v?=
 =?us-ascii?Q?jnBrFK6f/VCgMRRzvXu53tlDGEChGjli/2roNlSmCPPXHxlRCWV2/ZJKX4Ah?=
 =?us-ascii?Q?EE0rjgD+orPOoAK1X5jcvFK2F8gCZ4r56z03/xhtXQksw4xm0AYixHnGUVYU?=
 =?us-ascii?Q?i2Qi9UBFfGMD1ljHrXJFEza/yUrkes8HFtvWP4BOkiXM0IxlQOHWzAtDD8lm?=
 =?us-ascii?Q?klkad+cyPOwPD5JHSgbg3eEq35+0VCtQQ9TwFoKiZpJ2YDsikNdjSPxFFwYs?=
 =?us-ascii?Q?ARKmds7lJlHzLPyO95uO+SxKPho/UeUCdJ2nSgCjTKGJ2QX0ld3WmhPboZTL?=
 =?us-ascii?Q?Vjz2F+/pASun0V7Y4WSt8k+4AwF++anDByQIWN0xHSg+WomVTLe9nY1jDmru?=
 =?us-ascii?Q?2m9cuF3+RirsflsJ5YUPEEJwrVNb7ejBmjQZcY6gcVTxIf7uLJvh+hisVtUl?=
 =?us-ascii?Q?DGPFuuPCCbfPSVUiS78GTgwUvgu6Gh44R9+D1ErG2HuT289L0nV4Y/3uXMiD?=
 =?us-ascii?Q?2ea1a2fNgMI5kCYE0XDkKOgne9TyeR+VaurDZ5pq+BXkuQQJjCXHmHbrYAKM?=
 =?us-ascii?Q?JEclrCjsZXaM5YZEKHyrkyCsEZWzq9aPGI1A/P3PFqq/zz6a3AmUCww1u/5z?=
 =?us-ascii?Q?HDYotsb/8BmTJIXLxFEpHq6KBPQw3zUXsJeAexpbAL46+l1eyjTA+HdhL6iQ?=
 =?us-ascii?Q?78HicavxEYJA20DxVDCug+v8+3xrEUgFsuCIka5xrr3obX2FU2Nyc9McoAHL?=
 =?us-ascii?Q?Xsfx0MYD2Ni96efJYzfF7HM5GaHPRlPCgTKXw6wZyU3zp8Mn3V9oLYML3Ica?=
 =?us-ascii?Q?TSZ+GABerUUp7a1iGQrLBAeTDI2aOxYyui/gxIeuDuESJz22OvOEPAr3XjYC?=
 =?us-ascii?Q?c2B6hwGFdfJmozZ6KyobT66T530Xkraa97s8JDB6mU3BBOMH2m+fBuODOLlw?=
 =?us-ascii?Q?acKjxd3Yc6cIAFU9QAVCr6/KCJyy55b0+Py8MJJhvPuWtt61LcD1/uG8mUbY?=
 =?us-ascii?Q?3QRGRbhwrXrY4H7WbxB0HZTSYxO5Y4F60UHWBPIYhauVGX8qcwED4sc5VJ7o?=
 =?us-ascii?Q?s3a58L8sTeOcg6H7pgpbD3vlFG3LiNtGFVEmM09WX/pZKBdVSqskuyswcmGS?=
 =?us-ascii?Q?/3Mt3ux/Rpjwj5Z2NHIyzkaPitqwFEj4pbUbcTO1aauTdfHZpE08vBx0QXFw?=
 =?us-ascii?Q?xnpfhFgYIDI3DI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sJpdEF28GU+y2LO6VDULFPguHCKxfQM1idHlcMJRi34Ixq4zuemHY+/Okmbw?=
 =?us-ascii?Q?k9pBGDpJpLcrXirjgswlRg1cxtrzb07O09n7JRoph8TdOnFfLUdE2Xz3yK4f?=
 =?us-ascii?Q?cdiO7S3+813fLRZEDI45EjNKvqz28XQB94TEtHHuf+0M2gM/zHLUKvYhINyo?=
 =?us-ascii?Q?y1vxM/miVsTR+0y/Z8+g2RuRU+FwVaF1LQCCIhjV1ImtcLNIdpLQTCR4urWx?=
 =?us-ascii?Q?G9zn8GIsfF2Xy8GmLO1W0tCA5QZgoBt75izSv37Zj3cuVXyWtKVe07A8HVEh?=
 =?us-ascii?Q?RMWfI/7rUziMzxDbD+9AY5GkwheMvXb5p5nHQ2cQe6yXz50zu1BLMskoqFhu?=
 =?us-ascii?Q?6V1H6TucZo3hKB6X2+3sxtAa3hWSVNgktCWhlkV/UuipZ+Ms26pWNYjlQ6D4?=
 =?us-ascii?Q?uyNsDxFq3UosWAeXqQRr2rRg9PUSWI+LLDw996Uu8Nf0kBSOoZRWpYSIcMT/?=
 =?us-ascii?Q?yelql+jV55RALil9fnE+fotIt0+gtuDits7ypWnQ5APrICda0HEEhlSWRoqQ?=
 =?us-ascii?Q?wIP3N1TI0IZ6RRlYtY73LZIWy5wO+T8hVCVs5+IUOsJY3UDXvX5xlrPApB7H?=
 =?us-ascii?Q?DiYtdyBPlCgAu2s9XiOiFgwWmRiQQS3hGdh3znkFBrIPNt1SChWeyzE5Hwr7?=
 =?us-ascii?Q?mRQvmE9I9lSSVzxe2Y20hegjedThUA3CNvl+f67OmE2XL4IDvT0U4SXYZ7lY?=
 =?us-ascii?Q?sMgeFv/xvISHxk2o8+iqDs3cu1VPGG5s5KzzK2A+3wASt2vrQwcUK9m8TgVp?=
 =?us-ascii?Q?hGUmBPZhbkaKPVGTOU9xqcS21SCtNN5poNhV/GVH9rUe5ZTEmnriw8HCLMb3?=
 =?us-ascii?Q?zphYb7PE1uLGEBtfsyvx/xJugHxgLsVTv4POANYe8246Z0Kvax1mDKA5guFd?=
 =?us-ascii?Q?ElzEthUMUC5FjAIeGqkdzByx11lHWodog3skifoWVTBvsy71yyq8HPJFgADv?=
 =?us-ascii?Q?FSwCu3zjwUxVYx425bt9NMjAHPGAicXbHawtqcK5/VFDYvI49b+heXOlj++4?=
 =?us-ascii?Q?myxJmwQloL9LypXYvvGMC9TWsnwpXYextXK1fbNKg3dE4EQ/HeQF5XPaXlnP?=
 =?us-ascii?Q?20igY5O96nWU5Lp+56esMzh6mhOwAZv2+tsdduuMqJSjPV517nvCgaUK96xo?=
 =?us-ascii?Q?V2ahcb+XY3P/rgrhXA1Iznd6idH7XN2fcIGspgQqG30/q9QsdiypaKCjhoIt?=
 =?us-ascii?Q?3enw8HEyCoM9LqYw7ZImeT9zYnJNEixIeYL9vmbS5Mk+XP4nM/sp7KCRBETY?=
 =?us-ascii?Q?ypwHOJKs485cYF/9AzhqjARhx3Zxtku5q3MWFQtCZHsy1/MNjfpb0t4fWS1Z?=
 =?us-ascii?Q?JLNTTVbIJcYtBF21EJPGF3beTPd64QPyTzQw1qPyBErUTWMfeLhq/3+oriuF?=
 =?us-ascii?Q?T87OiA49EKh7uab4MwXN44k2twUr3yPpdwlvC9CO3s4YAd5+mFAd/mrla4ek?=
 =?us-ascii?Q?Nuq7O3I8EOaUwK+9tyFu6YG7SyP/m+uOZG/n8Ua40NOouk6Gtt1kJ7Q9lLTL?=
 =?us-ascii?Q?S473k0TggkeTJ5LraEvlCs7qQ00n6/a07XRUgHYzZN5uPpKzAr+ouSEe2LSF?=
 =?us-ascii?Q?7JJB1filnnbQ+OJ/Pptd0Cb5gZh00SB8K8tBQoGY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j5dchbRqqwF4WMQ09vYUijE2knncMqQXjqc7UBWc1SYk+GMO63QYiAkebo46WQ8ypyvQt5xMHGzS1ZiNgIvkGgUvyNsY6FmBCBL2ZVhBlHdlHkJ6qM6swnUNEtTRCyK+NBIDbVpfiFZSnj5SoY4DJ+ynlWnrBHqklMrWkoYrKK41UvkhuyDCHfXO6w692oRJLO2Sec9jnjaQAloxC2IcyNWDtrFQcg2YNcKiCJYn/wtoye14V9vo9MK4XCqGz380cjfyA8qLbwD7zNNnEqI2Q5ju/cta/nvpEfogW3j7EOtwCCXgi9o4cCO8ChZF0NLRQ+vqcZQwrR/abtFpRGoST9eNJow5a5PhfZPirdjq/Ax0KXi/BekuJwHh6QlVFSAoxvnhbA0b2NJWYJ1ZR2xMLRVYjEk+kjTsx7kdPy7/XRLbSbbnfQpBjlyaRKnzB1ObgEvITApKz8bqlEBje2mdoZkvqg94F0lPRxojap60XZlfI57xp6Lc9hNwjJ2NzzOJpuPFi90l2oa77n8KdjfoZchyXKtJVwK3LhYZBmGPJpV/xD+4xIhhIkNFde8p8QvWQXdr/lscyWQquSMCJwQpcr1K1rcISMSd3x0eYLxtsXU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5963af-24d7-40df-684b-08ddc7e92f32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 23:57:29.2324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ctzBVAltUsQSnQoDZZzPJtHdWKPrZC0Yz2E2LlFHBXyII1PxojWpb5I9BGWsId6xv7nyysOZpy/TKujSVwCmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507200230
X-Proofpoint-ORIG-GUID: K-rFivqaEqWggG5Bv0W1vD3F6kjUEnoo
X-Proofpoint-GUID: K-rFivqaEqWggG5Bv0W1vD3F6kjUEnoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIzMSBTYWx0ZWRfX2RNUCVb3kyu3
 JoQtU5PPacXDhrFMO5VzV6S+efps6hNT8SPTig5jqwg1qHKee1dCSXk5pBs4U5Af7oEeCK8PXmL
 lbZ/9+jf55+cMlrCly6VQ3VUU/WM+OBf4+2prxH3OSP+MDr8yCWp2RZ3F58HnqZFIbClowwc9iH
 nNblPMh0vCUK4/z1RHbxYwyVhQReT10CZiuXJp9BTaDy9DXovfqLlCHS5ykTlc+z+Kg1BEefhzi
 gX+VLEs4g3mXJK571w3Axj5pX0/9gTrPtASfj47bOP6B1hn0DCxAKPW6/1gmkpRqy66yJE7VZ8B
 /5yrNvtCqQFo4AiELxu6IE4Ro6pvUvKMNEW8s8UVP6bkwHBBOAucUC/+FWFGWM+v4kPCiV3Kj0Q
 oOfbGIIIs9+ltf55RJIGhLVNVsY13zx+0azzUSIXImzcSn42JukNNR6hQ1CbNBbg5199CT6b
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=687d826e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=XYUyMK8ejbiZP74cOG8A:9
 a=CjuIK1q_8ugA:10

On Mon, Jul 21, 2025 at 08:41:58AM +0900, Harry Yoo wrote:
> RFC v1: https://lore.kernel.org/linux-mm/20250709131657.5660-1-harry.yoo@oracle.com
> 
> RFC v1 -> v2:
> - Dropped RFC tag.
> - Exposed page table sync code to common code (Mike Rapoport).
> - Used only one Fixes: tag in patch 3 instead of two,
>   to avoid confusion (Andrew Morton)
> - Reused existing ARCH_PAGE_TABLE_SYNC_MASK and
>   arch_sync_kernel_mappings() facility (currently used by vmalloc and
>   ioremap) forpage table sync instead of introducing a new interface.
> 
> A quick question: Technically, patch 4 and 5 don't necessarily need to be
> backported. Does it make sense to backport only patch 1-3?
>
> # The problem: It is easy to miss/overlook page table synchronization
> 
> Hi all,

Looks like I forgot to Cc: Uladzislau and Joerg.. adding them to Cc.

-- 
Cheers,
Harry / Hyeonggon
 
> During our internal testing, we started observing intermittent boot
> failures when the machine uses 4-level paging and has a large amount
> of persistent memory:
> 
>   BUG: unable to handle page fault for address: ffffe70000000034
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   PGD 0 P4D 0 
>   Oops: 0002 [#1] SMP NOPTI
>   RIP: 0010:__init_single_page+0x9/0x6d
>   Call Trace:
>    <TASK>
>    __init_zone_device_page+0x17/0x5d
>    memmap_init_zone_device+0x154/0x1bb
>    pagemap_range+0x2e0/0x40f
>    memremap_pages+0x10b/0x2f0
>    devm_memremap_pages+0x1e/0x60
>    dev_dax_probe+0xce/0x2ec [device_dax]
>    dax_bus_probe+0x6d/0xc9
>    [... snip ...]
>    </TASK>
> 
> It turns out that the kernel panics while initializing vmemmap
> (struct page array) when the vmemmap region spans two PGD entries,
> because the new PGD entry is only installed in init_mm.pgd,
> but not in the page tables of other tasks.
> 
> And looking at __populate_section_memmap():
>   if (vmemmap_can_optimize(altmap, pgmap))                                
>           // does not sync top level page tables
>           r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
>   else                                                                    
>           // sync top level page tables in x86
>           r = vmemmap_populate(start, end, nid, altmap);
> 
> In the normal path, vmemmap_populate() in arch/x86/mm/init_64.c
> synchronizes the top level page table (See commit 9b861528a801
> ("x86-64, mem: Update all PGDs for direct mapping and vmemmap mapping
> changes")) so that all tasks in the system can see the new vmemmap area.
> 
> However, when vmemmap_can_optimize() returns true, the optimized path
> skips synchronization of top-level page tables. This is because
> vmemmap_populate_compound_pages() is implemented in core MM code, which
> does not handle synchronization of the top-level page tables. Instead,
> the core MM has historically relied on each architecture to perform this
> synchronization manually.
> 
> We're not the first party to encounter a crash caused by not-sync'd
> top level page tables: earlier this year, Gwan-gyeong Mun attempted to
> address the issue [1] [2] after hitting a kernel panic when x86 code
> accessed the vmemmap area before the corresponding top-level entries
> were synced. At that time, the issue was believed to be triggered
> only when struct page was enlarged for debugging purposes, and the patch
> did not get further updates.
> 
> It turns out that current approach of relying on each arch to handle
> the page table sync manually is fragile because 1) it's easy to forget
> to sync the top level page table, and 2) it's also easy to overlook that
> the kernel should not access the vmemmap and direct mapping areas before
> the sync.
> 
> # The solution: Make page table sync more code robust 
> 
> To address this, Dave Hansen suggested [3] [4] introducing
> {pgd,p4d}_populate_kernel() for updating kernel portion
> of the page tables and allow each architecture to explicitly perform
> synchronization when installing top-level entries. With this approach,
> we no longer need to worry about missing the sync step, reducing the risk
> of future regressions.
> 
> The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
> PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
> vmalloc and ioremap to synchronize page tables.
> 
> pgd_populate_kernel() looks like this:
>   #define pgd_populate_kernel(addr, pgd, p4d)                    \               
>   do {                                                           \               
>          pgd_populate(&init_mm, pgd, p4d);                       \               
>          if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)     \               
>                  arch_sync_kernel_mappings(addr, addr);          \               
>   } while (0) 
> 
> It is worth noting that vmalloc() and apply_to_range() carefully
> synchronizes page tables by calling p*d_alloc_track() and
> arch_sync_kernel_mappings(), and thus they are not affected by
> this patch series.
> 
> This patch series was hugely inspired by Dave Hansen's suggestion and
> hence added Suggested-by: Dave Hansen.
> 
> Cc stable because lack of this series opens the door to intermittent
> boot failures.
> 
> [1] https://lore.kernel.org/linux-mm/20250220064105.808339-1-gwan-gyeong.mun@intel.com
> [2] https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com
> [3] https://lore.kernel.org/linux-mm/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com
> [4] https://lore.kernel.org/linux-mm/4d800744-7b88-41aa-9979-b245e8bf794b@intel.com 
> 
> Harry Yoo (5):
>   mm: move page table sync declarations to asm/pgalloc.h
>   mm: introduce and use {pgd,p4d}_populate_kernel()
>   x86/mm: define ARCH_PAGE_TABLE_SYNC_MASK and
>     arch_sync_kernel_mappings()
>   x86/mm: convert p*d_populate{,_init} to _kernel variants
>   x86/mm: drop unnecessary calls to sync_global_pgds() and fold into its
>     sole user
> 
>  arch/x86/include/asm/pgalloc.h | 22 ++++++++++++++++++++
>  arch/x86/mm/init_64.c          | 37 +++++++++++++++++++---------------
>  arch/x86/mm/kasan_init_64.c    |  8 ++++----
>  include/asm-generic/pgalloc.h  | 30 +++++++++++++++++++++++++++
>  include/linux/vmalloc.h        | 16 ---------------
>  mm/kasan/init.c                | 10 ++++-----
>  mm/percpu.c                    |  4 ++--
>  mm/sparse-vmemmap.c            |  4 ++--
>  mm/vmalloc.c                   |  1 +
>  9 files changed, 87 insertions(+), 45 deletions(-)
> 
> -- 
> 2.43.0
>

