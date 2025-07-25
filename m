Return-Path: <linux-arch+bounces-12944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CCCB115CE
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 03:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79855588772
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA45A1FECA1;
	Fri, 25 Jul 2025 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q3dUuCwq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kczjYTdl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94D1E9B3F;
	Fri, 25 Jul 2025 01:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406563; cv=fail; b=ny5P4vqsTHV5zuD45N8yRZRL37sWCC2el0D1bcXLtehNh98xFw1g8q9m3S6HY4Bdg4GPfRFT1+UT0/euy8XkxVFb6l02+IYjw37iuxJXDhV+WhbKxFbBYNY1A63UQPeLKDqWIDD5ozSRal6F77vdHCZlOwHTsv6xS+kb6lcC4aI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406563; c=relaxed/simple;
	bh=23GPpDC1w5GB2LH6QLtGJga+VQwHG0EpAnK1W9KOYM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNAS9DPDIQnDKDUWZsuth2Hq31Fp0LSfRMC1fyv/qz6e0b4t06wFt3KkbxWg801Lfdn8Wzc2IvfPvVGN2RHBp5GkUv5gjb7qSA/YF0F5keSHIdaasaLF3Lvxc5839xR9wdSoF3jfNtIgtzRT8Q1RYIgyaQwok8VFFkI6pWgZHQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q3dUuCwq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kczjYTdl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLp1rT008701;
	Fri, 25 Jul 2025 01:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UM4p1dkPmmTXsPx5KAkgrfiGcfvC7R/Axa5lqweT/Ao=; b=
	Q3dUuCwqOsihb4uUhrNXCvbfILDyHR+iLKrrNM7j4jol28HdtC7lVsCJjgjv7cZi
	nm7plI0yV3nAW++5Tmwdz7JkWjjCfBelVNgHgz4wEfIvYIxcaF5wS/buZXZ7aGG+
	9UumNRyNHaWebVcfs4PyLp1xlCuDxu4rtJDtOediB4DSdOVWne+BSeKU9OdceCnV
	HuBgv1POiH6PXVHVYVtDvGkD9WuqWvKq5Ez6qYZ5fw3gBSugcAPjNxdGz72ofvfo
	wrWxhHNdYjx65O6jz7D9qEE+mSDA9HxtIXxIeSmXpR3KoabnP4J1oGV2GW25nTIP
	tj1OgBpEelXCXGtqaKeiYw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wg5yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56P16IrE038445;
	Fri, 25 Jul 2025 01:21:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tcj9d7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpVlkhAQSgVLzR5VFdzklGtVgF3ImXgLuqR2avgGAkL9VEuPnuBnK6o0Pn7awnXVv47NKf50exr2IxlM7/mfAzX/wt3TNF2bEER6HRN6HZe6msigWpFU+qP5U/Ewp81duoW4Njogx3x99boBPz+Qfkg+6tSEplWIvms5cBblLMMF486YsHU/sTiiQfdRzhbTbnWey7QpT7r6LpaGmdwmQBeLKIJbeQo6yn78J0RIfXSOnsPD8/Mu29eSFnTELuj9rJwAs+I/udooWBkfAr6Jd3uV/uY8dTMQ2AeEuL0wxrotNO5pcfsCzIs8f5XEVz+5FfvVMGab/f9DehLAWUKDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM4p1dkPmmTXsPx5KAkgrfiGcfvC7R/Axa5lqweT/Ao=;
 b=qHz2FL5pERafdOyq2gBDJrRr3EZWI/m9hSg3oSl7UOIIVg5D5+NezloEx4V/+c23rqY5lEOembDiz5lbgW+PfHaUcnbSUxOoFbNCRFV1Ttd6gVBF1O7HHBmtEKm5JCY9/1tf+KT/U3el6l0OuEJhgjPslyn4vhQTvHj6qLCffJBbCdf+kFs/+JAuSOVFnkoHwNfJTP2awy+rMtI59he/+vxV00z1WfcIJWu8CYzzcuFsrCQrrIFHUgo6yiOUPtu2//NwauZVLnPg/UfcquFtJeQN2sINmPFqD5yFQfghRIldysmtxQ5BL5Ur+jgnKrl96YnQou7cL5P4Yl+US6HrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UM4p1dkPmmTXsPx5KAkgrfiGcfvC7R/Axa5lqweT/Ao=;
 b=kczjYTdl/O6mVjsZ8t89r/QitxPJGKNyCGzHlGTvoI5MDPIABqpG1YcHlpXLykVZNc8gTdDEUm8GsXFGo5SWjUMeFUaoUH4KtcnjtssrBFpRm0CLGJjWyDhG/2dTmdRvxHL/0JrCTRO9Vw4mRjpgPMBbKcPll2k+HU4gpRbwOXs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 25 Jul
 2025 01:21:39 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 01:21:39 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
        Dev Jain <dev.jain@arm.com>, Bibo Mao <maobibo@loongson.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH v3 mm-hotfixes 4/5] x86/mm/64: convert p*d_populate{,_init} to _kernel variants
Date: Fri, 25 Jul 2025 10:21:05 +0900
Message-ID: <20250725012106.5316-5-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725012106.5316-1-harry.yoo@oracle.com>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0180.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ca::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: a89b1aca-115f-4650-460a-08ddcb199af3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PaCmgtv1lOXr2fnXaHe1K2aoOpnrKMTqVkWhgPuRLAAXLEw1sCLBhycganzj?=
 =?us-ascii?Q?VO6aKpsusNPCtFnfJf5X4ZZRh2H+av2iIwKAgosghUTisCK93U1zHbpB3Bya?=
 =?us-ascii?Q?JVHyIwUKdh5sOjVF5GpkDRJJ4TDer8sq3n+LnJERQikQGf3G6gTfbtxSUJ38?=
 =?us-ascii?Q?UDYxEaSfrZA1PazWLner/TbpfrQ94RI3IPiX7N9RfVqctW7Pg491ItOAFSvn?=
 =?us-ascii?Q?T/4/IMGDwq1LJmiPrkg/l2+PTqtuTjg9tc1cysgOusqW3Y2AOQwyJg2EEouu?=
 =?us-ascii?Q?IqZtMIUmEBu5aEMnoVNS+RwvGOIy7Bqz1MRAXFe+YVPSGEDyq6wIwDALeFzv?=
 =?us-ascii?Q?JzbJgnixCvLRngH0m7Blr3ETmzob5Ehu8tgXAaY2ilL6Art4T2yVuRqvthtk?=
 =?us-ascii?Q?yfoGc+pKLfaZ+hWZ2yaDMxay4Bitd74nZjvsceV3m+BqdiV7ibVkIH99rys7?=
 =?us-ascii?Q?blzkxCHWjGPcIcbrepjGZEsDYBQUbi0IoujiRRjEJFBGH863zs1SIDPPimz9?=
 =?us-ascii?Q?tJg2WKXL+Cb14mWl/Y6sMdwH4qFJ2ZulPejYbc/Sh+zUXhuw0kqsKd7VVdgR?=
 =?us-ascii?Q?m3VG8A2Nnpdl0iPhp9vo8mjAq2xTG2SjFSJpqDmmD1+zR+wCkL9OHOV82qLg?=
 =?us-ascii?Q?e2st3rSjUcbC48TqHdwLMDHAIQDTASxTQBensFahhlBrIv7HvSkJpu9Tq+Q5?=
 =?us-ascii?Q?txfEdxJaIkC74Vxp3sQZ9LHa7RVW3VFT3ArqhztFcXwLynNlAPL6tkN0E1QY?=
 =?us-ascii?Q?BGa2a1gVvIV7g5/SpyLnBm0vK5OLgdsQNxsHNAufHlqflyVUvm5v4jpZ6E2V?=
 =?us-ascii?Q?UntPmo++HSoaobAhELFTC/neljzRwwjcnigT6F+CBFTsQm6i+w8devAYWUmh?=
 =?us-ascii?Q?+FA52UnIHQfI17YQ7al/wosjfVU2XHkW5I46UQTC3pLZdOAuKjs8QbyFDX5Y?=
 =?us-ascii?Q?/pr+bKp9/rtkbLJDc8ILdn5bxfUxp0JRyaVJmZ7O2JB2MRriA7+ZbJFntoCV?=
 =?us-ascii?Q?TlY5DNA79qIUczUvxTRZUvaT5BbQdBlOTVgO36tD9QZGgspCd6rPnAosCzFF?=
 =?us-ascii?Q?pYVG5Py32ctythOKjewn41bwVTEJ4txzvUpvJy0R6ek7ZhaeF+4a5LzM+hP5?=
 =?us-ascii?Q?sQxsnJTLl/8D2kRVTIDjki4zqQSnc4tCRym9ruZ2+89Ho/y63zv5zUQjgM3s?=
 =?us-ascii?Q?yQrOHk+cChUyEdZN0jAQAG5HfGQ2bzTsBBkSnAVXGm/MihUW7i8LUTkESwQV?=
 =?us-ascii?Q?UjseNgnlBByyrbkSGD3pt8SuJNAkqQb1eVe/NQvL8BGFFQBgWmsY3XF2K/1j?=
 =?us-ascii?Q?hP3CcwFx4FEecaSd554wNT9wNeOWtypXUUMIJfsdI6fpsi4XCxo6nPrNcs3+?=
 =?us-ascii?Q?YeqOslTZNMO9Dcuubum/KDq1PRfrXPbR/DexQ0rSwChLzpYn6cNYIzl8p9mR?=
 =?us-ascii?Q?upYgmS/45LI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sTSoCFuwte4nbEEQ4O2FkGHK4GxiZpu1L/+a2FsbTVFkVVDcHP5txuLWM3+V?=
 =?us-ascii?Q?cFov69Jj4kyZX6IHm2CxoDiXRNp4kMfJnXluHkZ7jYThGjP85+bCExtAxN/w?=
 =?us-ascii?Q?hCsRccmC+muMtHg3TG+MNq2CUudDz7xF6NrYhIf4DnOqw1BpIClzeCTDmi7F?=
 =?us-ascii?Q?9dZ/9Hmh/VaLcMyAaFgfy2hnv/mQu1StClhTOxEfzLpodVdtdRtigjTdQJlE?=
 =?us-ascii?Q?S/MavbaQAl3rmyhw8ExWyBNQeANjznWnFwl6nM8JimUA/Rtl056pcy/qozUD?=
 =?us-ascii?Q?siU1bo4kiJkuCbj4xEh7i1Gc3PQJwtnQ7SPCJcNk5KNdw0iUVfqM/JaaVGUR?=
 =?us-ascii?Q?rcK8yMBkGgN7H/1foDEvTKnGzeUV5ZDUH+18T72MTVFR1k/yEuI66dwONqhe?=
 =?us-ascii?Q?oZenzGYSF+Zjnd4fwy3nR40OwrYFttO0m3dzBwjGSWrxO4NzJos87B8SBXvJ?=
 =?us-ascii?Q?UtJ/rrypBypPCxtcJrBkDvh2PfHIv9Q+7qLuw56ezA4jX4csZFBbFc3Ue1vJ?=
 =?us-ascii?Q?PhGm9er9iskLsz0IO8zXvrP8IjWrO4WPBQpC2v68D/0NEncPoHpkaIs1eKKL?=
 =?us-ascii?Q?eJ71nJbuRyvJoUXeQ7xTLDbPaoUrvD6zcb45U5j5/Ei/hIS1det3TY0EoNCh?=
 =?us-ascii?Q?pqJ3r3lZW7r11m3AwWR/Hs+iXgSCJkhjqMCe138+ioIwuGh1Akc/viGp670A?=
 =?us-ascii?Q?M3k8hG4E3jUYyZN7uo76M3CNOjkojmij7kqZx+bYWz76BNSA9cgXIsyl6d6p?=
 =?us-ascii?Q?QP70wI+pOU86tC+4aFyL+g8GNb2nLBO0ehH81euMfrlZqi1ufJGv0M7iE8OB?=
 =?us-ascii?Q?dzg2alGKNh6Vj8vp5XmCRGZrI2O2O+hULvbBtmlkXsahqBWOpJwtg3Mpbq4N?=
 =?us-ascii?Q?STGrUL5IQZ/XJRQhZ10wXgT/SPfOwVPmKSxNESSa3XMXnv1JqZmnXYvkeUby?=
 =?us-ascii?Q?aYKyanMACxAmpEF+nFoeYqDNC/5GhpuWggGXc+CgUbwRdI4LHPGTf5+dOPr2?=
 =?us-ascii?Q?rwJKIOgReBOViam1HZ3nmYqPE5kuvIrTsUl2znPm4gQN8rPHcJQPnmey0BAj?=
 =?us-ascii?Q?+ajGzVO73+yA2miCyj4/2OqCVxn/DCsddTrkDMBcES0OoYTCiSrpd1PrqEQ3?=
 =?us-ascii?Q?ITIXIzesAXGjW6SWXwHnqxqkyZnWaQsUvB9iVHL5LubXn4a58bo+DglJu6SW?=
 =?us-ascii?Q?Gmjd31R0vcmoALQUxPGF6jS9md3j6iaISAHOoVXkbi2Weqg6TRSp9jq3OnrK?=
 =?us-ascii?Q?Z0lOT29s51KZRGUm7a/ZttnvMnPjSj4OhR5CAXdCT9vx3/R8I12JdEB2LXa6?=
 =?us-ascii?Q?YSjsSKd0tPVA/MeOHojNsErC9Jzh8oN2nL93+Wo1GpxYY8OrOE6UAJRsO7cT?=
 =?us-ascii?Q?nFNzjQkQkIABv24iSTagyPoxOVVrZPbd9R6jCGD/g5O4MEHIPIy9mJr+26Gn?=
 =?us-ascii?Q?yoqw2gZ20gMajpyfIrFRpjQRlQAvPDyw2ZXTieEST9SzjqYbVhJFI23shfC+?=
 =?us-ascii?Q?JmSNJQpOxu4PtwzVqLl5o8HCaibzYmf1e3fcwoFQPHnnggUqSVYFxUCNlk8U?=
 =?us-ascii?Q?Ndxs1eEvfqcVRyAQWIg4pRkNbWktTyVVf2LXRIl8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VazHwtGrPladXJ+137ght+7hxLGamfjp+8scCO1hHDTYBzY7JsMeYcVnS1XrcQJKL1Zpfxdn8t1cc1Bieqe6xLKW4zeM21rtYzHSH+JEt42Yzb72XwrzmC/D+A9U4BFmEIaDDrXvk7qMC5VVPHvmucxOa4KsWhGlmf3kagV6N4bfI3ak6NrO4dYPtp/Pgh/t7JvpAckHvzKOoUBVjOOkcz+UBrpYA8bnY/uwA6cDuxKqC2REQN5gYRWISd6y/idMUhexNFlOJ86NRja37eEWyHiVCnLVWJaM7O+wTJS3hNNSGjUi/rp9I1tL2sJkm4rrJMwPxj8fMa2f4nJQUy+6vnzvHc4BDpYeavekTCdxK6lGOCfgRT2zvKbEgEab7XuYGpBIVyZSav5mUOT+Zq2cJcYvupXEfxH967XK+YkB9ClP5QAMJjDMXKU8aKCzB5y8bOwC3Xw9JAPDT8VGZZBiiu5qTTTeorMB2EFZ+/09MNpAV7kBrZD7/GnKfbEZgCdykAMgrKPybp1pDX5xqHFoen/FVF849FFNJVmD9xVcET19AkByOvcZG9116RYm8SiYCNMdIFcznWwIbe7uGDZaTTFKNb4lLj4ps02PG+lcjAs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89b1aca-115f-4650-460a-08ddcb199af3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:21:39.4386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RkXvHV2PthR/IO9SnWyZvzX1aBj/0XuPYn9puignNE331yZgks0fK59kPSN9KX280FytRRTCswngxsI0kMEcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250009
X-Proofpoint-ORIG-GUID: 8dN5yuj0gY92FItGSi_sMIWD8ptpTWOQ
X-Proofpoint-GUID: 8dN5yuj0gY92FItGSi_sMIWD8ptpTWOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwOSBTYWx0ZWRfX5dF5+iXHvAY9
 Jav6ZAAL5KiXNn86qcVPPX43x8X91byZcHKjzdj9ma0HOBX4CqqsC20P10CNdpqb0u9dT/Vvo2u
 l6kE/esomzITTwrN2S5Bp8TRFAC1emmxYGUT+KbeQEadvZsLxnBxtj1oTRkAX5NNnk7LfCRKGod
 XxUXDId8e0S6M0hH7sNvAPEv+7MogYpft3dHN1g7DjHYsJ5OtFndzS410hvSgkSD67EPaNitsKV
 6K1YVvMa2MfO8LW12CIUUpvYG2fMFiTxCzDFE01TlFW8T7SepJR9XdXxZfV3qXFYePq2U2Ubcg3
 FygupRn/ztbBTW0QAKxmYpfcKOcF0uYUAsMIWq54G7bN6kYziMXSsKslNSKGrAMekxQZyH59d4L
 WSiE38PXCte9sftcT6YzhZGHd6Y5EANVIEEYThQSxhv53Dk5yS4MefX2PhBWCZYbYRqF9F9x
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6882dc2c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=U6_OK38MrKt_FgBMkhMA:9 cc=ntf awl=host:12062

Introduce p*d_populate_kernel_safe() and convert p*d_populate{,_init}()
to p*d_populate_kernel{,_init}() to ensure synchronization of
kernel mappings when populating PGD entries.

By converting them, we eliminate the risk of forgetting to synchronize
top-level page tables after populating PGD entries.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/include/asm/pgalloc.h | 20 ++++++++++++++++++++
 arch/x86/mm/init_64.c          | 25 +++++++++++++++++++------
 arch/x86/mm/kasan_init_64.c    |  8 ++++----
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index c88691b15f3c..1d5af9fc4557 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -120,6 +120,15 @@ static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d, pud_t *pu
 	set_p4d_safe(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
 }
 
+static inline void p4d_populate_kernel_safe(unsigned long addr,
+					    p4d_t *p4d, pud_t *pud)
+{
+	paravirt_alloc_pud(&init_mm, __pa(pud) >> PAGE_SHIFT);
+	set_p4d_safe(p4d, __p4d(_PAGE_TABLE | __pa(pud)));
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
+		arch_sync_kernel_mappings(addr, addr);
+}
+
 extern void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud);
 
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
@@ -145,6 +154,17 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4
 	set_pgd_safe(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
 }
 
+static inline void pgd_populate_kernel_safe(unsigned long addr,
+				       pgd_t *pgd, p4d_t *p4d)
+{
+	if (!pgtable_l5_enabled())
+		return;
+	paravirt_alloc_p4d(&init_mm, __pa(p4d) >> PAGE_SHIFT);
+	set_pgd_safe(pgd, __pgd(_PAGE_TABLE | __pa(p4d)));
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
+		arch_sync_kernel_mappings(addr, addr);
+}
+
 extern void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d);
 
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3800479022e4..e4922b9c8403 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -75,6 +75,19 @@ DEFINE_POPULATE(pgd_populate, pgd, p4d, init)
 DEFINE_POPULATE(pud_populate, pud, pmd, init)
 DEFINE_POPULATE(pmd_populate_kernel, pmd, pte, init)
 
+#define DEFINE_POPULATE_KERNEL(fname, type1, type2, init)	\
+static inline void fname##_init(unsigned long addr,		\
+		type1##_t *arg1, type2##_t *arg2, bool init)	\
+{								\
+	if (init)						\
+		fname##_safe(addr, arg1, arg2);			\
+	else							\
+		fname(addr, arg1, arg2);			\
+}
+
+DEFINE_POPULATE_KERNEL(pgd_populate_kernel, pgd, p4d, init)
+DEFINE_POPULATE_KERNEL(p4d_populate_kernel, p4d, pud, init)
+
 #define DEFINE_ENTRY(type1, type2, init)			\
 static inline void set_##type1##_init(type1##_t *arg1,		\
 			type2##_t arg2, bool init)		\
@@ -255,7 +268,7 @@ static p4d_t *fill_p4d(pgd_t *pgd, unsigned long vaddr)
 {
 	if (pgd_none(*pgd)) {
 		p4d_t *p4d = (p4d_t *)spp_getpage();
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(vaddr, pgd, p4d);
 		if (p4d != p4d_offset(pgd, 0))
 			printk(KERN_ERR "PAGETABLE BUG #00! %p <-> %p\n",
 			       p4d, p4d_offset(pgd, 0));
@@ -267,7 +280,7 @@ static pud_t *fill_pud(p4d_t *p4d, unsigned long vaddr)
 {
 	if (p4d_none(*p4d)) {
 		pud_t *pud = (pud_t *)spp_getpage();
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(vaddr, p4d, pud);
 		if (pud != pud_offset(p4d, 0))
 			printk(KERN_ERR "PAGETABLE BUG #01! %p <-> %p\n",
 			       pud, pud_offset(p4d, 0));
@@ -720,7 +733,7 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 					   page_size_mask, prot, init);
 
 		spin_lock(&init_mm.page_table_lock);
-		p4d_populate_init(&init_mm, p4d, pud, init);
+		p4d_populate_kernel_init(vaddr, p4d, pud, init);
 		spin_unlock(&init_mm.page_table_lock);
 	}
 
@@ -762,10 +775,10 @@ __kernel_physical_mapping_init(unsigned long paddr_start,
 
 		spin_lock(&init_mm.page_table_lock);
 		if (pgtable_l5_enabled())
-			pgd_populate_init(&init_mm, pgd, p4d, init);
+			pgd_populate_kernel_init(vaddr, pgd, p4d, init);
 		else
-			p4d_populate_init(&init_mm, p4d_offset(pgd, vaddr),
-					  (pud_t *) p4d, init);
+			p4d_populate_kernel_init(vaddr, p4d_offset(pgd, vaddr),
+						 (pud_t *) p4d, init);
 
 		spin_unlock(&init_mm.page_table_lock);
 		pgd_changed = true;
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 0539efd0d216..e825952d25b2 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -108,7 +108,7 @@ static void __init kasan_populate_p4d(p4d_t *p4d, unsigned long addr,
 	if (p4d_none(*p4d)) {
 		void *p = early_alloc(PAGE_SIZE, nid, true);
 
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 
 	pud = pud_offset(p4d, addr);
@@ -128,7 +128,7 @@ static void __init kasan_populate_pgd(pgd_t *pgd, unsigned long addr,
 
 	if (pgd_none(*pgd)) {
 		p = early_alloc(PAGE_SIZE, nid, true);
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 
 	p4d = p4d_offset(pgd, addr);
@@ -255,7 +255,7 @@ static void __init kasan_shallow_populate_p4ds(pgd_t *pgd,
 
 		if (p4d_none(*p4d)) {
 			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE, true);
-			p4d_populate(&init_mm, p4d, p);
+			p4d_populate_kernel(addr, p4d, p);
 		}
 	} while (p4d++, addr = next, addr != end);
 }
@@ -273,7 +273,7 @@ static void __init kasan_shallow_populate_pgds(void *start, void *end)
 
 		if (pgd_none(*pgd)) {
 			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE, true);
-			pgd_populate(&init_mm, pgd, p);
+			pgd_populate_kernel(addr, pgd, p);
 		}
 
 		/*
-- 
2.43.0


