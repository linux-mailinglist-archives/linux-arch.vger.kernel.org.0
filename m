Return-Path: <linux-arch+bounces-12876-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE64AB0B955
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 01:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F17618985B8
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jul 2025 23:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFD230BE0;
	Sun, 20 Jul 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fR0gEovs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OCHEvO9y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE3230BEB;
	Sun, 20 Jul 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055010; cv=fail; b=JSYxPomfKRYuStDiU5QFyy5nTcbtGpUgKHjf+Yk//5lPhKgJu41iXEdwBmpVY9bKWG3/fzeTb/iMY3u+5uogb6rD/Q8czx3oWauCaeAA2xQHTziPqU3O96ykl38EZKPFg7ejBZ2VDlPKIjjhPdv9VSGHZz2YjDAF2zZWvXNYRl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055010; c=relaxed/simple;
	bh=v9FT/DCEOxqxIpQQxAy+Pnycoe4l/AwIzmUzL8tiPSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNAfmHMbwFGLZ8Rc6us1Q1MSyN1C4FDMSH73fp1fLyWq1vFpy9cSJO6uF9RbUQqv0h38myptkTPfwjxm4XITwCDL7Qj/V5g2zd95crHaH2J1IM8/lQt+D1N4k3SlmcbsrVPuZ31dXj81tDt/jdFfefliBseS/LvjH3qz6JicFC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fR0gEovs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OCHEvO9y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KMmaFr024590;
	Sun, 20 Jul 2025 23:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7CTx4us1BWCLH9+FojT/ImHRWf3T6xJTWvDU/xCzg74=; b=
	fR0gEovsA4RFFtpJqTG4TRrtNCH4wUHZ6xdLgE5cnIL9EKF0fDb7ZKLvQeHcysRg
	k4vvEKiCWYMqR5vCiYnNKml6MCbE9GAsSp5sRmG13YxaH7HCqR4HonzzxnSa7ut3
	qyVRWcsotovN4OrY0yCda9sKw1VaL6XuEPokk8YYLzmFmWlYV6o0o2srOUXXIWnb
	Q+39W6P52a18mi1HQf08zjv66DXWTg3x6cKxnV/g1kNeFEiL7zwRVnU26LaZxzi+
	c8VK55xJpXF2xHGMgB+HVNa/11872sFuZKXFsrt6oV2BFxqkmA9jbWKwk2r2K3pE
	tsE4Gboww5v3lzsRyfGsJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hp9hy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KM08Ij014405;
	Sun, 20 Jul 2025 23:42:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdpt0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnU+UUOvpgXDE1d2qGXU9lYbonGpQ7AEJTeUiH90SHYnk8PCQU5A6SGcEs2SQCLUCuxlRHiF0VulQ1d5kQ/O9zoDcL3e85SPKFg9H9UlqXQHhEeF/zQ5q43AjnB11XQfMu2z8xfypaZfhW/05t83hAz0+/Fib02Qsp6UkqNbcaKnbPRkufcAzoNA0L8pbFnCPyREvo+LaRgmXEjw6njyTR7/n+iuIXr5R8Rxe0WJaHx3/TWr/unJEFEPXwVUfkSq814Z8/MPhrVeJ8iFi8IYgUme9wUOnlb0/ZFwqYk4PGRUdx8/b6h6kxGLYnxgqlZKUOXxIjt5pnOGpO9pI4j9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7CTx4us1BWCLH9+FojT/ImHRWf3T6xJTWvDU/xCzg74=;
 b=BstkJdiVxNN7a80fZM7G0Qnq2QrXk93y2SiKfTOtveoiQs1RyakjMVvebf2tJIoc3AmHilwef4830t+e4oo+9EZI0DvIMdYwnuRpmQlKXQkZlLXtr8ucfWvYb09Gxf9isZKzhSnp5xHU1ogD+QzRpUXWIJTspCoRIGKaqHsPG46KoByH37Zn7QATTh2uNg65GOz8uatSYKjqd5LlGhHfOLtgqA6hlkIyuKaDaas4g5Yb0axTS4wrNQR3Ztz5/YjXbDB7DHkY9Dt/nwfV5mdQpLE0+HkJg8Rb3T74xqtBu7yFEc27bOjGigLO8+P48IdCUMqNh9LL3zBOllClhXtN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CTx4us1BWCLH9+FojT/ImHRWf3T6xJTWvDU/xCzg74=;
 b=OCHEvO9yQPy1ap8qokSLhc3UmSHQpquFk/HMNTEmVsc5f/JbpBAmxdf7v9YXFABKTvz872feXv4GEDI/nJZ7FVKUv/UAeZv6WWyXAArcsB1q6sjWC1fyqz/Vo4aVgPmE9hvsAKTKB6ox7NY8USnHzWUP4xvSoRsdTU+l5E8OziU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 23:42:39 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 23:42:38 +0000
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 mm-hotfixes 4/5] x86/mm: convert p*d_populate{,_init} to _kernel variants
Date: Mon, 21 Jul 2025 08:42:02 +0900
Message-ID: <20250720234203.9126-5-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720234203.9126-1-harry.yoo@oracle.com>
References: <20250720234203.9126-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c927f4-f155-4304-9100-08ddc7e71c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GC3TsqctGzAG8+2uwE4mJ6fIRaUvuCFv6CSNYhqdh/igJsiz5lSwxKQV1Azu?=
 =?us-ascii?Q?3+fNrmMx3NekGHe+FWzszbhCcfKEf46HAGh+lFGSq9iiEVQ1wa+6OJk/Eki2?=
 =?us-ascii?Q?X6Iz3MqwO5ougCDjR73F0utzxfm6pYNVkzbaWiUzVkS9wAenQlKmdlNAS1MF?=
 =?us-ascii?Q?2LP3A2k7hxBFsE4NcxiwVW/tbFVcWzN6wxMlRCg97N9dGo6MEy6LVe2Obuad?=
 =?us-ascii?Q?ej77NLqY33dAjXeXqYjTUUjC5lxZ6fxfd+ksSkWLp9ml4RAnS1lHT3CRkGW5?=
 =?us-ascii?Q?FxTnQw/z2dynP8d9g5I0zhnxOGli7BgPqKVM/CcPM2E0MOSDn7iPRjhsQwWE?=
 =?us-ascii?Q?UEXDGyk2nUqYf9+r1WNQ6QQ34Z5ImRDe6LULHON+tAl5U95Qr7ItnPnySBP5?=
 =?us-ascii?Q?prxo4Zu/KyDcMo9L7DB1PtDtfan88SBxZ1Zpwa53PaAoYyNE/FGFhwPtSP6x?=
 =?us-ascii?Q?/eRsdvWOGYNH+kPFuNSxR/6UrxRfaRdnDEhyHFLNa5Xtt6orqbCyS55wETJO?=
 =?us-ascii?Q?+CwRmWRnbN2yVGXjsdtq2o5WymYGtcRHu5i4l1gjZ5Khxvz3ifBgMBYKO09u?=
 =?us-ascii?Q?Fn5lrQUBbLiYQKGoeAeN77lFxc+jmPmao/SEXS/BZUOtFseD2TGC+oy7psj6?=
 =?us-ascii?Q?2vXLqagOrIvpAP+RFAMplGvxj3MHv2gThcdbCZ796OhO/V+XW3Ad7CUEX//I?=
 =?us-ascii?Q?Dwhxxv9emYiOqRGitmqRKSsY/HUqxjR6ORSq1PZMCcIvEtmHk0sdT4kUxhz9?=
 =?us-ascii?Q?T9AJMXJMdtd5C70otxltT7ZXhk5QVb4xiVkjRLUalyH016gX6yrxZiIoPB4+?=
 =?us-ascii?Q?+LGpN6I9Y2ol7zT9pouFTUHEFkL+BzhafQ3eYzR8C7fYAt4c/f0Jfst2SSTe?=
 =?us-ascii?Q?6CZX5PqpxusYaDWVShwNsszUeN1sQANfEN/bsH9U5odHlzgq8wcieTKG6zrY?=
 =?us-ascii?Q?LWo7B3Dq3C/nfDoXH8VxFOQnPM4JzGMJh+UeJn78j7o1+e4yIVRl+ahrUyu5?=
 =?us-ascii?Q?YUmPo1lRq6Sy5Zy1SIsiCT3elwDHR4a4OQ9b7OcTE+6FuLWMtCeoSJaqmRs3?=
 =?us-ascii?Q?UAMI9u3EYdkubLzC2P136k3FKgflyFVZLJOlvnNqyuQziHvQg0NPG4yclxxF?=
 =?us-ascii?Q?z/UYWaga1h8KCmxytmgTKvhXGuUsZcFcl9Jupth5YHPJaJZ9oXZxVNomCQpE?=
 =?us-ascii?Q?mG3MjB2bNiX0/3g03CJxzGrATs/dTzSmh4e15vFASGPhi3MizndGdeL2Svd2?=
 =?us-ascii?Q?78t4E0UMFPrDAERWdCSwuGr5P39cZv2MH2i5d+PQPPyMlbyl5lpAsrZbZNT+?=
 =?us-ascii?Q?3C59fnVsJwYX1T4rl938pMy87+8yatg248gFDNEnrVYW3zIM8wdSS22b3720?=
 =?us-ascii?Q?DuE+H0qalksCPkqchox9+6sCMRpeKAYl50DYvKj6279RSr/A5wfwE3MKliXO?=
 =?us-ascii?Q?BujLgm1ZPkkyvRSvTxQui47gZ7QO5HLK+YhP+9yepm0WPOoJ+xdtjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2UBz+otm5fmP/BCh/OkVfY4xBTgMe9wueh0YWzs47UbFSHwAZJk9At4Q1JNG?=
 =?us-ascii?Q?KwFyLybrJ+3dE5Lo8I1JWAGgYDrweyNyCMD+9zlK5lPLgCynREIPG56PiLsc?=
 =?us-ascii?Q?s24gv9AxUKhhCHHb2pcnx6886kMfVIppMUGF7DdL32aPs3PUqQVlnOlfPdO+?=
 =?us-ascii?Q?icY5w8hvVuokHGR1EH/ASSg4K4VP4nOUXeXs1nKKLDF1UrcGvOmm1UkCPJXY?=
 =?us-ascii?Q?ei7Q/Vwz+8MR3dfZmLIFH31JjrHLZQB9kvasSYnFYhnKXiejVLmIy4Owm+8C?=
 =?us-ascii?Q?stQZmfnDOmpkU1pBVJlyQ81zbAgVjoWejlxG4pithGDrpc+I++AsAgFSSynz?=
 =?us-ascii?Q?EwPU4x/LIqT+ba93k7arFYeNAyGyhxXcCu0vzat33yzv5cs5Ufv+oZJlDaTC?=
 =?us-ascii?Q?VDXV9tHXm/kaHxvNQg2lpmj2BVF7m8FoEPrKusJ9c9DDpKEo0LR+D8aaun1M?=
 =?us-ascii?Q?1jgh6p0W04yRSe6Vrre03nb7OGXIxJr/AIQ+/qOlMGuE0u9NtCs+4eGRvorg?=
 =?us-ascii?Q?tjTWU8tpWZDP3SmWNqF1/XKxXJpeumvIaHrsBMzWzL1ijQh5XCG9xmoHkXvb?=
 =?us-ascii?Q?qtCkyXKsrObPTGQcmwDFy+lKxYJBnLPpzR5aX5KtiHDsqmMRR0IqkURyhUvX?=
 =?us-ascii?Q?M810yxi8Cax7Hy1mwvW4AhJnuN5ovI41uNeDPwz05ec4d4bW7GFqewRc7WOa?=
 =?us-ascii?Q?hgj1/ypoPUmgEQUJSUKQ7K1prVaEz0KhI2SL4n2SUFX1s/bs2oVIvisaaNj9?=
 =?us-ascii?Q?0sVjeObJlwoIZiTCFJ4jlVLA9aExQYxVIlKstACD4wn/MnVvHdvmeNVdxgDm?=
 =?us-ascii?Q?9gl5kNVMrY+N4GbOOGbSjbXzoCmxShGPcRgtTJoqu4VSybseoem1DkXIePkP?=
 =?us-ascii?Q?iilZ/1xAl7CDrxaLuMP20Iv55AdEerAqBDIgNmVvtIVhK2v13yaYh00lfO5c?=
 =?us-ascii?Q?+utWI+NlcWzPsclGTZceFz/YtY+RnN1Grbd2r6q+fFl+OUD2TzR2vz3zpGpB?=
 =?us-ascii?Q?R0mg2/wLaKy47hlekVEnY4LydUT40kJy7deh42ybjeFrbSl97N1U/nFTDnda?=
 =?us-ascii?Q?nepzt0DK3w2vCN1CaRrAABkoKSCJeaD07Dlxq6NbdutrZ/nv0ZsxXFVnSgcd?=
 =?us-ascii?Q?27obr4gawxMRkgy1pBfgP41IhJBsckKnUvytRGEmtbKOIqknBDS7P0DmXUMS?=
 =?us-ascii?Q?Ur38IkiycbxRPm805o1r8+nOp0zm8TBcYZyzKGpHM9/ITPfN4K9mxRxw0rD5?=
 =?us-ascii?Q?SVmrikBL7jwJfNPfjQupFffT++ywR1FBpoAxjYYLuE4k3lDBKxIX1qRWxoyf?=
 =?us-ascii?Q?b/Bj3azorF6Amk17MgLk+xkyo+ukCy5lYpqBOJm4HRZa2zG8SpdUzkGvPmDl?=
 =?us-ascii?Q?1OgfNkG2Dujy7a8MUU7uSGQJ59gW5IUfzpR2b60KPkB1G7irr4LMmXYTRD4F?=
 =?us-ascii?Q?FWz+mPM5sgw25bRETQGgJZMR5n3GOuG9ZnUZNM6Y9987mDX58fSXvy/47Ci+?=
 =?us-ascii?Q?kVDiXu4FmdHN14QumPnqv2ObaNaNyC2TXGkXJInq+dHJ66FsGEcQ2BCcuJfm?=
 =?us-ascii?Q?CzfMCnsyN3baX3d7fS/kzLMut9wvJyNN2ZhJOHND?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L4zmISCh5q8czIsW5+9pdWJAy8nBJ+uSHmb3dkfGXuB6DuWNkMgbRsbMcoDoCUo5/jD4SYq5/sKsvT/rrA8Hlu9G9hzwZflJH8H/X+wLlG7DqxM/QKiusIcx/l9/bH+L2I3DCCvs/SNNxqR5sGn35X7mqev5Wr3Ao9bW0sXuDt1mK9uFPR25gKJoIlvimVLCCXGJAd0FTbNB7Ll9AeGz9e3m/XBfUVMRyVGuuUQgeKyAdDd+fvjpccjtTJVVoR0vrHignBdgUk7D5tLS4L/VW/ZwSJjBj4ckVhLP5d72//eN23X23KrSrba7qta9fA89brqx9k0HZJx11PsuHK0nsVK67UY00KBZl+duieI/LbCqEKYLz4YNQ3YM/XDZompTJ4A/9H/EtMoYw1Ta6OXjCX/LYxlHTzSvwFtXvcm5yqpdH/GvMAGZGyU0RwQ56+mTlIGdZMXmLROGKkYW7ZZDnDbY2bS0YSAGJGDCEAN3erxf/ftj6hcFr13RnFYSWfcE+BWTVBCjPb0FoItboIgoLVoDsiYP39ooUCbWUTK6VfK6iMCUXH1sQebjCI08VbJGk7za3YRA8l3hG4fbhVo6BnSjR+BaSAFCMvFZZ3Nih2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c927f4-f155-4304-9100-08ddc7e71c83
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 23:42:38.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9dAxyA/Tu86SjPENo6zPkpkOJooWih5rdm5LGBB30sY89W57dW3vEUcTP/rahfqnXGdG3Gpjsmby1TOpiAkZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200228
X-Proofpoint-ORIG-GUID: w7jD10sj-9lgRf7I-Gk9s1Wuv5IF8T19
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=687d7ef2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=U6_OK38MrKt_FgBMkhMA:9 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: w7jD10sj-9lgRf7I-Gk9s1Wuv5IF8T19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIyOCBTYWx0ZWRfXyoLhmEZtcc9l
 bIrf5d1OAi6FAQYa7rbL3sF85Y73j+vyzOM9U5O0vF0AoI8XXSkTp1I4VH703DGieivw4mNxtSt
 L7hTK3RwPdoOkgJQlbguV0U0UV04KQ2fkykhqi7j5LVvDMGeNkldrZx3MypfqAkJthIJf7QdoU1
 ouw7L3IVXIHWUzjRhyllHU6pG5TNGX4pRQkGfWfRTfmbsZpTDoX2tS3sL0jY2jL1CwDzOdgAmyR
 MOnbDh4ZxCjcViEkBCUi7EBIAJsEbpTOmIsSaOmVx64ggglJJittQ4WjiJis6L8Q846HizcrGt7
 04YiHzCclwCm7x5sXlMxHnoQEBTD+BPkUZ8tUgxN5qy753tKuV2/X76xl6i5zfNHHGfsyTw8n5n
 uXvIUbldzpSVuzzGEy5kX71pUgRRYYHGQ+wycAX857RiJouQymQzBM3eMvzHY2hKePI985qH

Introduce p*d_populate_kernel_safe() and convert p*d_populate{,_init}()
to p*d_populate_kernel{,_init}() to ensure synchronization of
kernel mappings when populating PGD entries.

By converting them, we eliminate the risk of forgetting to synchronize
top-level page tables after populating PGD entries.

Cc: stable@vger.kernel.org
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/include/asm/pgalloc.h | 20 ++++++++++++++++++++
 arch/x86/mm/init_64.c          | 25 +++++++++++++++++++------
 arch/x86/mm/kasan_init_64.c    |  8 ++++----
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index ead834e8141a..aea3b16e7a35 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -122,6 +122,15 @@ static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d, pud_t *pu
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
@@ -147,6 +156,17 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd, p4d_t *p4
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


