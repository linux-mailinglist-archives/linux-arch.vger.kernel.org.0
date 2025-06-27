Return-Path: <linux-arch+bounces-12475-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5CFAEAE11
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 06:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D603568426
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 04:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38BE1C6FE1;
	Fri, 27 Jun 2025 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CkgS/y5k";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ElwJ2YdZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5942AF1D;
	Fri, 27 Jun 2025 04:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999733; cv=fail; b=tFieT1dGdSN9Eyv3iQXGR1VNJ5OgmUPdFOy9qFgDwevrv07+/z4P6i6ZLmLSPwvypgpCtfAlkhI8Jc1vRgn/Wui20p/peY6GGBNXcYZPBFCSWF9CQq5BB1/qq+3Lg3TRgQlqQq3RVAtvwDnD7LhSZExeENDEtuaVbIKURYxZzb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999733; c=relaxed/simple;
	bh=gU9yN9aMMSM1xmF6YCuvAWXeTidtQ1ObTWI5zAcH1Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arUFd3HKipkb+ULCz6wKLK5Qczc60lEumIxrMYkuGcrKBdYzqJ8/jf671l7u3qR3Cv9sgGbq1LMNiDgYQTsbZvdk1rR9eK0pV1US0FT/EoAEUMqoiYE0+1r0P43bHUaPgEuaiWPj/y1CW58f5iMsBYo0FkzJ6+qf0Idy3tuxEx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CkgS/y5k; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ElwJ2YdZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R44QuJ013196;
	Fri, 27 Jun 2025 04:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r5LwwBxu4QNcnhtNQjgY/aq8vELxRvGTGF34G/ESV8s=; b=
	CkgS/y5k8fUNGCowXL5Kp+NIYesmDOrpDX5nL9X4/doX2QrSzv454A7tlvOzOEG6
	pVBqr8fIaQTl6Q4B5QHti/6e1ZFIUPfNtPOAo55eREueTABATXptqau9GKY4llle
	lrlUGipTV1gFX1liUWGm5meh1ZoQ5od4Cgm949Oxr/5sAQiE/KXN6StUmJ/8lgnD
	+j4hP5Pz5gjkzrUHZziqz6XiPC2cYzpAQ3pmc+CaH1Zv4rY++j7gwlR112Wg5UHV
	ATo8wsSXDXY9kwt0m2bp4lOC5RIr/dPenL7/zt5Xb4gMNYWwR0TKKSyJYEGB6IPz
	7D6BIXBoXNqmOt/LM837aQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5t3fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R3mtnS002627;
	Fri, 27 Jun 2025 04:48:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47h0gvt59j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUVBKaRoLMGM5Mxk/QVxTwUI6kQWsTMt7n/Ljuy7qXmQ1rUIJoLGjnBFi8d1x6H+GdfuuoWzkhXExZ6IYmsJYq5MrBW27gsBpTzz2rQBJwjLO0GCNUowizMZz21WurCYUMgBd+VqZRYT/cT/crbBBnaMTiYH1Xc5g9Gk4f1B7gNp92IFcMd7t0Vls3Vg3wMGnBEoyDuk/EMphyAlVUrlkQbhwh/ntoZBiVx+qhs4x03F5AwZ1YbyfJeFn976mofXhfsalhR+G9QgrKSFXd8U1HB7jxiAXHsNEweYNrnf9tpIkLhFHvnHqUuTdXySJn1nra6Bg0SnkAL/UyIiGsDb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5LwwBxu4QNcnhtNQjgY/aq8vELxRvGTGF34G/ESV8s=;
 b=sGjV8oPGeYpHkkkTJK+frVft17AVK/szSawoh4z7pkUR8q8FCI+5Ad12SQUIgmcA7COUmz0g9LhTp8tmmsfE7EQoPYk9foSZNF2hXpMF0eHCPPSTEvqe+QNLIFF0eAtSeyUQbKPgDYQ5lSQxoPvRaUu+rttwo7a79eVFOcg8XV62p3iPHP0GXyv75LsD3FLQSNO0mXawtoUC61/6lDjUB7Nl2D+yMigwJCfgYl77ePlcjGV1RHiUr6Aw2bEAhYv2kG0fy9f6h7baJ2L5iWupt6BP+1caAtD3GT6o4n17YzMALD+t4DG32Hejx29YCYaqoJQVkZSZhQ4KAFi0liW5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5LwwBxu4QNcnhtNQjgY/aq8vELxRvGTGF34G/ESV8s=;
 b=ElwJ2YdZnBF3qaR7fKEP9GeD9EEzGvGTK92kbpX7vuGpkHjdFcnmagaCkeRewAUZvCKEvFefIbcbvJLEkScz0lo3bfqcWKnwIivNBIRq2DjIu55IVIsTVkQI3rdd6AupDuIw6ebDDcFhSsBIMEZll5H6tJ+SqmorH3qXrWuTN78=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6335.namprd10.prod.outlook.com (2603:10b6:510:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 27 Jun
 2025 04:48:14 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 04:48:14 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v3 3/5] asm-generic: barrier: Add smp_cond_load_acquire_timewait()
Date: Thu, 26 Jun 2025 21:48:03 -0700
Message-Id: <20250627044805.945491-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250627044805.945491-1-ankur.a.arora@oracle.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: a69b411c-dbf2-45b3-ca30-08ddb535d36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZEUUsK0ckb3WvgQHnNwQb/Ql+5awZGXM8Ax7e1JgxgS9h8XEMgGvqL/FXpvI?=
 =?us-ascii?Q?a2r7s+Tp4NvqGmdDc53w47sSNqIE4tFnhXM3Y0xA/ga0DM5G76Vo1JHCZo+S?=
 =?us-ascii?Q?AgGgc+ShvcyFImX9HzLexqAVgMieZxuvz5eFWkLOXMlDO424XixdusH42F92?=
 =?us-ascii?Q?Yt7wl9/VIqTek7NYv6Y8lPmqiNgxD/1SuBsmTiQAtzVw6NBT+GE4RiyDz5I2?=
 =?us-ascii?Q?q3BpD7HEvnN4izQm2mg2b1kkkr0sMSai2sY3PKvdBGIKZtml+4/jLPqe3lP2?=
 =?us-ascii?Q?LCRjWQJ5V5heoHALZnd5MyYp9llXOqenyoSf2tvh4+Uz822agdRjVaQ+13Pv?=
 =?us-ascii?Q?q+yTJowLYk1FeIMIDt+z2z8E/XRki8OiDhyhuOOou2DxnPUjrVhIWB59s9sz?=
 =?us-ascii?Q?mxghpWgbQC/7JzKKEnl1xXC8/A7UX/vgZzacTbm/dSrVutfFkr18bjNU0j3J?=
 =?us-ascii?Q?zvR0Sv2AIHSbusRKny509nWI5M6escZ52L7D/klQZIWSaDrJT+ldV5zqL1jq?=
 =?us-ascii?Q?uytNx6UGQJ7kOF9UgGUPdE13oe0iC3hPmQ2DMG6F1w+qdrJpwF04mXip0Y1J?=
 =?us-ascii?Q?IOJoGSvoGr2tKeGJBSxJIrAynMw/zoZWTaokjutgsi9AVlkiNvF/SabJRQwR?=
 =?us-ascii?Q?IqQZcpFYeZJQCbqkVGyqEjAaj/ZTBMs3KBXT4pPQn5cQA9O0VPb0I/zY+PF2?=
 =?us-ascii?Q?DWOcEaAExJ/XldEFjoP4RJdMKWEUmoy+f705+d/4cWKqI4cNLSyEccgVYKGH?=
 =?us-ascii?Q?Y0gHpmWG2AmAf344GWX/nLD+yVzmmkJsrJL2/ociZ0dZqhzteWfst4USFhgF?=
 =?us-ascii?Q?jpYww4BZRQB6+3SW5+TzIvLF2xVkXexbg2+fUQDKVWRG5iCDsHLtzHP3Z5bc?=
 =?us-ascii?Q?Rp9Bwn/Yto7z3w4XFHY9PIbULxMpK9lVVBNdubsKQdhPHF/pz6hpQfpvk8hy?=
 =?us-ascii?Q?uwv2w1tucM5yhwET4XqrUT5HD0+hCiYF8rmpp906HCwk+Jw4oHyzeX6BsnbF?=
 =?us-ascii?Q?JvB+Yo9ZUpHK32EFoLl85ZnzAHjujb/gMFZgBcQ4QbmmfnXnHAiDN6KqsUrQ?=
 =?us-ascii?Q?L9/Peb9gFMMrmk6nrW3QK2a/UmQx/MevCK9Ar2AhW+K5sOb/bMUZMWXLRLXF?=
 =?us-ascii?Q?X1yyO/xi8+XXjO1axo7tj+FR+leXtfcLtfqzdmgtI8VIehslkkS9nSBa6p3U?=
 =?us-ascii?Q?wjTVTUYuYRhXqFbsRSVYjK8CHGLVGE2GBt5A7Fdwwj8zgw/tcaUx+lYzY5qi?=
 =?us-ascii?Q?XGiCsxSVg3q6dbA1G2At6X2MMiVZcaqF5ALn4NkwSTN42qNbuoN0W01MZ2xa?=
 =?us-ascii?Q?b9FNLeJpXsq4F59IFCMR1QxoMtp3+3GvCMGDIBNJY2RwOZR6toqwzTw8yW6l?=
 =?us-ascii?Q?9UvCLF79QLWUr36eCbct6F9AA8MujPqS+LuSo8gP8Zp7HHd6dRNOXcb+3CqX?=
 =?us-ascii?Q?RJwJNGu9DK8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?knr5p0Q3i+uofCxMrXHL5w2vxGGPTqnGAmDVHvWZCRn8xZbAPx/ddyPWsLu4?=
 =?us-ascii?Q?QROKr0QTEXzzhWHGD8halua2R21w9GgTf0+toqkYqJG0XZkDTeBAhACx0RLS?=
 =?us-ascii?Q?2/PFYozylHkC2AaS+/FaUxFIM93vjZwmDnY6KtKeVTPXqbTtF7OeqPZm+hAj?=
 =?us-ascii?Q?9KVQ+9ovQZ6EIiAlt2XRufjHByOiRPpDppawZxXmJX+GWMCi7xeRJHTnHi0j?=
 =?us-ascii?Q?Cr7lEHtDPeRW66h3pEWUS3f9h0GuFMTtdF6iMDsWh0Jvsxt5TMk1OyGk67cW?=
 =?us-ascii?Q?te4SQ4R3RBmwa8xV+MLS9EmqIh6a0N5Uq+HR/L8F0+eFpTssfXIL7WM3iqtc?=
 =?us-ascii?Q?6Li11xjtl/ARUwWG5AirGdkUr7yGc0xmKZux8SeZySGWtc8rJLYBv2ocMfeb?=
 =?us-ascii?Q?S8oh3ppMoMApEB6SBKn7reTEAWYEzanXfKs1ZjPZA366ySFLjIsZNDrGS+He?=
 =?us-ascii?Q?r0Tacgp2Br+TtMMpLeyVvvnAJoQM0bdP6IGVABxEvPFkIh+IhKSqYNwxzPkH?=
 =?us-ascii?Q?xjT27nhb2n5SAUPuzcvFBo01DAm2iY46e1DuIeE6D2RG0myHawFNJywO+5kJ?=
 =?us-ascii?Q?D17W9AtafgkLkh5oRdTKXf+GGAMz3iiDsJ0352X0G1r6by1ycQhQlh4f24qI?=
 =?us-ascii?Q?4G3mJ7D2gUQsXACX0edFFRLHS4/Lk90H2gjFUIVPgonWErhrdYjJvs0GNB1V?=
 =?us-ascii?Q?ECVQnwFG7cmQFTRQ5b8RSypd0sZ2WPBOpJFbX/mWd4qDHj89/jpF/pBcCO4z?=
 =?us-ascii?Q?sPGOt54A2posxLupb1Yk414/PzV6qI6AZa5dS0CELpAAwDK78fQGD3jVor21?=
 =?us-ascii?Q?USDmZ5yPQjB1roSfbW6MPueOCjl6xL/qCOyFT3JDskM7uKwabAMySZJctCrY?=
 =?us-ascii?Q?S4mYFI9hAn4ahk1admM+1/7Y0HOzF7/3poug//LLxdBks03FTHVJY7eRQWIq?=
 =?us-ascii?Q?Bq8KWX5I0qBKBzs6m2Tw+OlMG7gLWDEWod92blrOfQA6FDHQoIIIlhmzGZLc?=
 =?us-ascii?Q?bCMp0uJVTf9sQSaW7RZ0pONE91FPOpT+73d8FXkatVxh70ZU6Cs5hjA3Uak3?=
 =?us-ascii?Q?LIGMT7Qp71tJVyn5y21mEMewFhw86kVctuXc5RIEHbecJ60Pf9TTMmmWVwCT?=
 =?us-ascii?Q?eD6cBsBcCxmQR+yIm84saR3boLkR+52+UBOl+PZtshFdTHoEm861+OguddaG?=
 =?us-ascii?Q?GZeYd1OxPKn8+fJfLVXHiQwZ5uu64jOZ9pvXYoiYJlnF/Wv1i7GHNIucYdGD?=
 =?us-ascii?Q?O4vcJee8k3ypq5NPB0HTWa3piYK9n702/FReI2Dc38sXgeKeoiuRxrd7c0G1?=
 =?us-ascii?Q?+Ohlz0b8odw2YDifSEPchKsF3QMr1mwDWNl+bQpqSElmrA+jnKME72K4FTyY?=
 =?us-ascii?Q?WPn+62ePeW7KWK1ZO69JRDxgetaCgEskqE/8rrrInDKqW9Uco5VqNDIYuB8b?=
 =?us-ascii?Q?iCaLwItyl/SiJcsDRRioUF/JEUnKv1inORsnKfZ7Ox+lDRrZW4QGALPIVHSD?=
 =?us-ascii?Q?9+l4d4BNCmMTFY2bpO73CtFKYq0nV1vBPIJBU5NcGdrKOY86m7JnEvDZLTX1?=
 =?us-ascii?Q?//XaTVcClGuaqh/6/luhetsl5D/TIjQSKe6P6hSHUqE0/FVW6JuESLalCdpa?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	irzYsI07cljKTHwhanGrs2K6AApr8cL9ABBeP5quzIwg3TAVkkvQUMS9ukHABritRCQMYzEZMo8ntNvHhA8b24Um8uK7v656qw4rFPzJ44A759MXJrwvSSl3w+3s7GqdmW9JZUR5CZ7CudwtzTGpQVd4kGrbs8g5ZEIkgmb6R6zOGBxQVUBbsF+i05bKbCAIuQL3GJ72dbWqNxYrejJPHNMBhMu+DD6gVDAMuCoxPui8Az5iFql1wdBldF7Z+nCDPbwaTZUfrcgziYjhgmr/QqRfl1VtxkwYPMO566SZbtucZajmstm7OABn62HJzTt0wVhjuYtJMFJrzUNo+uov2rmvFwOgKL0HR6R5/GS3NGWyBsrUg49ciGrByV5K+M7JJ07tBEzrmIt9pnIiKJT3vL6uLyMs/6qNbKKyHHesNPHXyIgzvc6zT+gWojvoSox4JAoL6eEFFqubCDPHdTuf5gbrADzElC8Qb9psARrv2wnwp3mF6aYPGk9yTSxJR4Zznyq+BCu2ogRLLrFjmC2uBi1fp9Qg6XBJp+l2MOIhpZwY1A/j0xx/6TIdViGendA/IomxYAQjzUH+r0xDUmtZT/G7+1g4xdbmreSu+qTFg+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69b411c-dbf2-45b3-ca30-08ddb535d36f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:48:14.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNuZoHNb8C1Mxb2767W5oOF4P9Yq2e0AYFjVbDK++H89xZNO7vLCwmXUsPbV5Xu0u80ZnOBs27j9F1KmEQAj3TfgeZzo5Dh+U+Lhz2XU9kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270036
X-Proofpoint-GUID: ZkUl0FzhFpmh2uUjWN-uGLGMeN97DH6t
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685e2297 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=9Hjk7SY-VBZdzCxDJJEA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNiBTYWx0ZWRfX6hROOojYJfq5 mnonTWe6tNuxp+9Z7AuKb06uxaFvXEVAKbkXdytU23FR/HuT2KbCqgZgrUThCnzdwxQxJ630z0n AldsGOAXXfNhC8GD5G6I9W+qk2ulpK2q3vdb7VWviPelXLQotcAAl+pMKgNS13oznj9hVvGtzHB
 BJ+GNAeo5t+q3KVFefHsxFGJwnP4UkJNgVmsU2lnql94yGXt81Tr9pkyFbIxwUrE9RBPtYTgVz+ hmjyjz32/vJ0ALnb3rAd6+p0msn8L0yo+FTLntsDh0+mBn8DWag3mdo6teaXi3q7/8ZBrDF9h6c KXXF1E4hgOSjv2jD5ap/RFP2uZkY8PDJbSt842HMdQz7LJTO43dkE7C69igTcptClrzhsXy0h4l
 4fhAljg1VpNevL3ZhTuRVjALQ8VuiMcJW52rA5bodk8vW08F0DkFAefthMyXe1ppyLKo0gcQ
X-Proofpoint-ORIG-GUID: ZkUl0FzhFpmh2uUjWN-uGLGMeN97DH6t

Add the acquire variant of smp_cond_load_relaxed_timewait(). This
reuses the relaxed variant, with an additional LOAD->LOAD
ordering via smp_acquire__after_ctrl_dep().

Also, the rqspinlock implementation has a locally cached copy of
this interface. Fixup the parameters used there.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h |  2 +-
 include/asm-generic/barrier.h       | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..f1b6a428013e 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -86,7 +86,7 @@
 
 #endif
 
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
+#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0ULL, 1ULL, 0)
 
 #include <asm-generic/rqspinlock.h>
 
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 8299c57d1110..dd7c9ca2dff3 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -388,6 +388,28 @@ static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
 	(typeof(*ptr))_val;						\
 })
 
+/**
+ * smp_cond_load_acquire_timewait() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ *
+ * Arguments: same as smp_cond_load_relaxed_timeout().
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timewait
+#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
+				       time_expr, time_end,		\
+				       slack) ({			\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
+					      time_expr, time_end,	\
+					      slack);			\
+	/* Depends on the control dependency of the wait above. */	\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


