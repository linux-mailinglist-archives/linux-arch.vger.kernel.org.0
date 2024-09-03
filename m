Return-Path: <linux-arch+bounces-6990-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C612896AD24
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 01:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C6D2857B5
	for <lists+linux-arch@lfdr.de>; Tue,  3 Sep 2024 23:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E971D7996;
	Tue,  3 Sep 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yeeo9wAC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UvSxFWkZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09931D5CE9;
	Tue,  3 Sep 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725407928; cv=fail; b=LQwals3M5crRoKUH8w0YdKnk7k2yLeWGWSyO1wo/cJ1yhSRSpA9kdwm1ckq7jCosP/HhqKtWS9j1AspqVCk1HGGd1IGUFJP2Wjs8fGux7wmIB1mhx4s66soAsJ2feIbaP5mTFzZM822XVBV4nYAk8lfaz4rkNOYWh3zCdGa/XfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725407928; c=relaxed/simple;
	bh=jB8hnFqMmA0SK65LcnaTLw9vDU2IZh0DUtPWvl8Rb4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QB1b45neEuknxdB2+8qpHtvG3yuTAUSGSUCr30foHkun2JEpkkaXojindEcqT0SzGNKX1F94By1qZGg5SM/5h1kIQrmKgj10L5iQNEih/D0T2BpTl0ubBV9SPvv9IVIZZTDOFW8O11CrFWXSoow2JAkWSHiD1r/N2HcGJ3lWOU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yeeo9wAC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UvSxFWkZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NtWST000729;
	Tue, 3 Sep 2024 23:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=Sts7LtjHbYXrDknVLEREXDSVTrh50NWljlu9zbvns1w=; b=
	Yeeo9wAClRDOBr4bKkd4LEYazD4MLp5UxZsXhuWPS3OOMC4lmHNKmItHHoB4//uZ
	jvbvF6pb+/SMrl+afQNbwX6olzUFxcYqUwu0XPO4uf7EvmnIvTgbczrE+R3ej+cr
	8tDj/aMK0488NcDS/fiSHqVKDIVymo3SF16WHqvR0617Pi1ZBIWRqkuVbO9wAB8z
	BBSB2nAg18dj4wpBMk8UYGsptMHz6BYJfl4pIubGPDZLd9703cZjbjh9YtN/ZeHp
	2clOsnHjGAf7gaaMoazajpZO4gV6VuSROZM3DMMJIjB10WtN2qdha40/fcA/zH5Q
	w4BSJvJWy+G8LCh5+AS2qg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duyj28eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:58:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483LAZV0018318;
	Tue, 3 Sep 2024 23:58:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmfd75n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 23:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqSkvm5zi6e4k7aoqbez/K8ojG2vNRxMVrxtchlJyhhFerr7DlDEwOM8K2k40U865EBLvupjEQn8/Fc6x8zJ/eqxDZlkQ5R9m2uc7wZduFW9EcXEZn2g87SATClznv2AFoJGUv7+BsSUMnatgc8cvDbC7SdonBVskXB8yJNpOmSn+Xj9mcT7PtMpv6sJrFf9uBbHW9w4VmC9mydfImfaV61U1YUh354n1vK4iVvCoCFEUaemeByXslp6FyNkQiq80ApkEB3/VDVxx5wg0arhnsaXKoqjkPVUGMU0JWpTX80+kt2nDPZvmCVWMSWZ86dYH+KDYHDDeNAXAI7hT4Pbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sts7LtjHbYXrDknVLEREXDSVTrh50NWljlu9zbvns1w=;
 b=RPaqfqL0GTRAnoHUeRUFyDC4mUm0GISG2w+KLAYVDzYezlSsftNk+oVAkIcLL4mu6eih9UpDdhxUL9a47ms94Ltd4wDttfI22eSTkVqk3SFF8Xcm6ysQm66ZNhO7p9UIljnHTek3M9zE02PGZCciezv+huCP29oI2sIS2nOveaTtqfXkKeyGC9tG1JeSXqoqQrVSf1bS4slrl9aWoJda9e17GXRZuh6VvldL1PjvMMiTJBMhld7Y8IBX2Apv4TYueHgqFicIRpgdu60fxk90Eef5WRw23s6w/AsXcAq5E/YU3TjLNjMFQmvEn4zJ/PMXNRcAoLv7zY4moG/RoKsCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sts7LtjHbYXrDknVLEREXDSVTrh50NWljlu9zbvns1w=;
 b=UvSxFWkZuw/oWZyLock5mwQOidE5X1b/A/m5iNGc+Oc22vDy3WxYdiFlmSJn7UE4CG8e/tAY+bMhR33LqWMr3KXmwhZC2sl5j0wAxtcs08NLVRiWUaqvhxr9X8JW8Xiql2acc2eE1nfUGVuFwAO8UG7fGPXtPGTSB5P/bO59rHw=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by BL3PR10MB6066.namprd10.prod.outlook.com (2603:10b6:208:3b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 23:58:10 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 23:58:10 +0000
Message-ID: <ab9872ab-4be7-4dae-a8b9-dc360d6070b5@oracle.com>
Date: Tue, 3 Sep 2024 16:58:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/10] mm/mshare: Add vm flag for shared PTEs
To: James Houghton <jthoughton@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-7-anthony.yznaga@oracle.com>
 <CADrL8HV51t44EBKFwXoT-A48miq2TT7w1yjSUFo6uc5WDN=z9A@mail.gmail.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <CADrL8HV51t44EBKFwXoT-A48miq2TT7w1yjSUFo6uc5WDN=z9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|BL3PR10MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c361786-bb9a-4f4c-936a-08dccc7443b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHUwTHdETVNjdVNWVFZwQ1ZjUUovdWJlY0pxMlpsYUJncm1EQUlYNFQ4dWtY?=
 =?utf-8?B?UlYrRlpiT1JwMk4vQXBrSGRXZ0lmRlZZVUxlSFpGME5uVmZWMWZXQVJqNGlK?=
 =?utf-8?B?STd2MHRpQU5WVGpwVXVpOU9EWmdHNiswbmNOSHJHTFk2RWwwSUpidmlkR2Ry?=
 =?utf-8?B?ck9kbXY3aEZFVmZESDMvK2dEbGY1dy9qUWVYcWZ6MDdoWHB1UmZYelNJdjFl?=
 =?utf-8?B?VVRIZG1kL0ZHVlFTaGNna3QzUmJIQjR3SFVJbXZ5cUtzb21qT1ZucWZqOWVj?=
 =?utf-8?B?YjBEQXc5WUZMOUZ3aGhiSzAvcW8reGJzbjNBeW1jdXJsRzRnc0RxTlg4QUxN?=
 =?utf-8?B?K2kvUnZmejdyZkxZMlFQNlBOYldqOWovU3RFK2NjUUlMbTlQaUtwSmNRclVy?=
 =?utf-8?B?MUZPdzZGbkFUOGt5dTJMOEE1Z3RvWVQ3LytjWnNEdkNpejhETTJhUzE1djRS?=
 =?utf-8?B?dG92MThVL3VkQVY0bGZRK0RkVGhHZHVHNENIZzBMV1hCRkE2anlIV3dUbkVJ?=
 =?utf-8?B?cDYyd3dRaG8rZVZPeHMzVUNmcGJEWnQ1NE1yN25Td1AyVnA0bjg3ZlNmZmJU?=
 =?utf-8?B?eWh2c1kvWVhCbU11emRkU2pvbWJRVnNaT2JibCtMMWNOS2hyQ1hsNUNjREtw?=
 =?utf-8?B?elQ1TFFtNG1LcVZpaEFGbGs0c21ESXg1YlpSTk5EQXBMZ3o1T1ZKQW9OU25M?=
 =?utf-8?B?VkZ2RS9tcFlvdlU2TFFRNmR5UGt2MVF2akhNL0JHWVVGanduak1JeCszdkVl?=
 =?utf-8?B?WVM4RkZzN2M5YWJOdmFLL0JMcjl6VXRZSTNjUEFETnJTTlJNbjFYUVZyZWti?=
 =?utf-8?B?eTcvNDFWeWJ1TEVRNzVmWWFldys4aVczbDNpempxMjJsYjRGWXM4SUE2WTBY?=
 =?utf-8?B?cUhkcUhJcGFHZFhrMm9UNkk1WXorTG1vM3Z0Qk0vYVpVVEZrQTZxV3BoSUVr?=
 =?utf-8?B?bkw4NEpIeVJhTkFUN1hoQSswd3FJRkJkZkFEZG5zQlpZOG5qTG9QcElSbisv?=
 =?utf-8?B?Q25WZ1hrR3N4bXhtSjJzRUxLeXQyaTZvbGlNMldNcWpuUHJsbGJFYXQwd1VG?=
 =?utf-8?B?Z1hVdm1KOXpNM2FESGx3Y2ZwYUozcWViTVgwTWNMcmJsTlBXRHFvdkRmbDE0?=
 =?utf-8?B?Z3QrcDdOWlpMSUtLdVVuVGZqZnZDVHdvUzdCQlFBMWZEOXlIaVdzVHlLSmZa?=
 =?utf-8?B?WGtxZmxmTEJoZXAxVjNWY2VCT1B3OG9rTTVKaS9vR2Nuc3cyNlVaaGI5QkFK?=
 =?utf-8?B?NWtRRjJFSjFFZ3l6SnJ5QzQ5enZmU0lJVm1vMEkya2dXTGxWRUJBUVMwWURw?=
 =?utf-8?B?enZPeVhhZmMwSkNYSVZVM0l0MHR6M1JCd3o1amtPcHZnWjBKa1B3d3pFR0dH?=
 =?utf-8?B?RXNsaFFXckttT1A0cW9qejdBVkpEckoybUZHdEZmMTVuV28vTnZITEJtU3kr?=
 =?utf-8?B?OEJXZjZxV2huTC9uSDdlbjNmS2kzSGRpbHF4eG5VK05TUTJzTVdxMStHYWp4?=
 =?utf-8?B?Mjk0aFBnMkN3Z1FTSGRDY0lCUUpqam1lTHpJa1lCT2xIUHBXOWZoUmZQZm5J?=
 =?utf-8?B?bFRQQmV3TW5TaWhjUE5mVjB1SUw5UUxBUldOKzZDK3pyOUk4MEdCeThxQlNH?=
 =?utf-8?B?d3Jjcm85TW1aR1dWK1pEa0pvY3BiYStKLzVyY0RDajYvWmhTSXVMa1c2Vm1a?=
 =?utf-8?B?K1VxNUtodmgxeUVWZXk0V0dXckZERGNMbkFkSFVBOWdMTUZSNkhIVGk4aVB6?=
 =?utf-8?B?SHF1YllmMkhKV0hHS2pLWGJEQklwZWlBSktVMmJEbXpkVDIxaFFEaVRBdXQx?=
 =?utf-8?B?anFVclFKbVE1RUlGd0VsQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHU0b1pmQXNCY0k4VjN1Z29NT052NE5HZmNUOThLdXNJRktGUWdEbFRLMFJl?=
 =?utf-8?B?OGNEQmloNE1aNEZ3enBTVkVucmF5NlpjYXJ3Nlg5eFJXYlZQdVQveGE1NUMr?=
 =?utf-8?B?WVQ5cGZKVjk1NXYzdHg4VmtnYU53dVg3OC9pS3JVVU5pSzRjZVJOV3pNcXQ3?=
 =?utf-8?B?NmRSb1NRQWRrbERnQjVvcjZyK0ZiQUg2OC9LUXc1cDFEUjQ3dStIT29YUUE5?=
 =?utf-8?B?TG5xVjdKazVGQnRHa3lRTWNOLzk3Uk9jWlhtbmdRZGZmZ0tjWEZuNFRBbXNl?=
 =?utf-8?B?eGF0NU1aRzM4RDg5RElxRUtUbHRpOHROTnh0VThTUWdDNDFuN0x1V011MmlW?=
 =?utf-8?B?c3orSWc5cHluTEYzSk5YOXFPb3pZNVNhK0tGUXA4aWVYc1VvMEhxalA4V1Y3?=
 =?utf-8?B?c3ROd3BLTnM4TVZ5M1pDL0hVVmt2SWsxVzVmdFBBeUlBcElCOFkrUVpiM1FV?=
 =?utf-8?B?RXh0QkkxMm5RRi9ROHhSK2YwR3pKRDlVWGFaSDlPMnBIWEZZUk9URUVOQ1J2?=
 =?utf-8?B?amhzajF5blBNWFo5UnZWbXZBNUh1dDBFM2JOMGFtNVVVT1hSV0V2UC9yZG9S?=
 =?utf-8?B?bFdLS2xtZHp5QmxRTlcvS2xFcWFDekxnSzZtYmtDREswYmRyc3gvZXN0OVhW?=
 =?utf-8?B?UmlDZ2FPMjdNZUpRTC9TTU5EcXhmditWS2YvUXMyVlpJUjdLLzBhYjZLMDFK?=
 =?utf-8?B?RS9OcXZLek90MUFQTElsRHNRbU9tem9RK2NjZ1hYZjFkZXNPMlpURlRzaERv?=
 =?utf-8?B?TkwvMGUyQkptQlkzMnoxOFY5MkFwNldVNlNpaUNndC95YXFrajMwUlp4c0w1?=
 =?utf-8?B?NDhNYVhqWVdLeEltRmhnQVorKzNpQ0x1elQxSzJ1Ky9kSUtmYU5JRXI2bzd4?=
 =?utf-8?B?WHdIbXJ1c0lpUDNocG4rSUJMK1hxUlhWeGZ5Y3BCMXVzNWljNWt4RUpSLy91?=
 =?utf-8?B?K3UzdGgwZnAwRUdHWEJ5d1NzTkVBTEkzK3lsTW1TRnphU2JqTDllU2c1KzVP?=
 =?utf-8?B?aGhGVjUrSk9pb2ZDNWhSLzVMaWFtTUhFaDF2dElsUjRkNE1TZnlRQ0ZualVl?=
 =?utf-8?B?a2E3Rk9XeG5tcXdyOE9KN3ZheGZrbHlLcURJTitnRGpJNlFyQk8yc1BITXVQ?=
 =?utf-8?B?N1BRZ0RyRWQyM2NRK2VKYlJtL1ltaUVhN1FISUJObXYxeHFScmlIVS85ekZj?=
 =?utf-8?B?cFhKTEx4Zytuc20wNXByL0xTb1h0WktKQ0NYL1YrT2VMMlU4bUozSWhIODlv?=
 =?utf-8?B?bDhkWHZnZDI3dSt0bHN0ZEF1Z2I0RWNXNnBmbkZtMmVWQTZ1Q0w0S0FuTm9j?=
 =?utf-8?B?VEJBYzJWK0RhZStDcDlRWHR0ZkxZY01PdXBsejJZTWowMVRUWFBRM1Rmd2JC?=
 =?utf-8?B?YVNyUmo5YjAyNXdVZFQvNTV6NXA1K0tseE91U0hRdFNDRDhzNUJCVmFrNEF2?=
 =?utf-8?B?R1VIUkdIbW1teGZYa1dZc2tnOVRtc1lxZ24xdER5L3NVbUFLYkpzRDJGU2ZR?=
 =?utf-8?B?ek5sYzAxOHdlMkQ4Sm5ub2tacW1XUGFTSzVyMkxiSzdTRG1HNkZBdkVmV1NK?=
 =?utf-8?B?YUdmWStzaEFNNkt0cU1yaG1kNG5RUnRsRDVPL0w1TjhjY0hKWXV0VkNZTmcz?=
 =?utf-8?B?Z2JXVEQxRm1xdzFCQWRJeVhoT01SOFlXRitxdnJlWFZJUXMwVm1YN1YrczRy?=
 =?utf-8?B?cG5mWXhiWVdROHc0RUtTT0hSRkpVdlZkKyt1UHNQSTRGdTQzelhHbW80Y3Mz?=
 =?utf-8?B?TVA4dzV4Z0poRWZpUlBER3RSay9vNk0rVWhvM0VCSzRCL1BsZHpRR0t1TXhw?=
 =?utf-8?B?YkRqNEVuN0E1bEZQcStlWjhGcXpLOFhyRTJ1RW43S2FRejFYeUJ6bXlMWDdr?=
 =?utf-8?B?ejhhaGNlc1NuRXRxemJtdjdmbko3WHFDeDRxTkQwNm9XcG5qQ1o1TU4rTnRQ?=
 =?utf-8?B?NTU2TFF4aFphcm9OUzFKM3AyWjhBVjFNeFFySDhZUFZUbXpOVEZ6R1BIV0dD?=
 =?utf-8?B?SDRyNW5WT25pVyt0TFhZZXJIRzZaeUloVjJaMnBFdEhpMUhtTXkwU3oxcTRX?=
 =?utf-8?B?UEVNRHpmL1ZBUUVrN3gwQU83Q0hpWHlUWms4RFIyNCtCRlg5VUFBZEt3eDEw?=
 =?utf-8?B?TkVGM1FFc3VlVllTYzhjQ2NmVWUxYjFXWElSd0VEWFNwNHV3Mm9LUkhIWXZu?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x3TcT2lgJia7WpNfnaMsvlEveK9Y4ROLbIufZxco0a9/L/MViECOEHRUqjP8OtFfuDAjV+S/XwpMrBAaCHJ9dMHIhJ1dTGUnIsNwdd6AnMKOKn7U2peVzBBJJMwoWAudOfVDiKk69Wo6GCYVlFje0GG5nIuWEcOXAoBw3cf1E3lSuvC84mJNlAFEAFxA3H1JS1xUy9ZLjHIfPb5Vsl4iLt7e00oAp0p4IJqIdpwJV2Kokkm5mhWWSsZarUUINKJOYx2OvuVuCmqf318iDdvj2sf832Ij7RfOiGHF8ZiYGhsGUPiyiYZxPBbKA9hsETo5JjD/+mdzc9pNpfOBmg8M+nZrX7Z1dWqLdhWdCWXmeeeuiM+MAcNjcfJknpfBFftB/uX64vQLat5TnW7lePD0l37EVHaJREsKARg3TEEpH9S46R5Ni8MDflbyBrgVKmFyv+B+V5Pk4CrY5T1aX9vEo5cOh7HOThLZjU3tAdpE57y/bbuJPeTl4EjCnwxXrytF8XyhgcwZ0ZUdxYjJDYM6c50lGJPFxM/MeeRHpF/r3wdls5RlYVQoODb/hxNmDPE3ceWpOyG7nEMyWyoJqC3CrGs9Op3hTm6Vlnjrz2JlEsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c361786-bb9a-4f4c-936a-08dccc7443b7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 23:58:10.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIynGJ9SwrWVgETV4A73epnym8Iu90u8NR/t/6AjwPkqvO5Tt9A6SyfE+EizCbg7BxnP+H/27fE52cyP/zZlz/7W73YxbAtUCECnEE2Qrxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6066
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_11,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2409030191
X-Proofpoint-GUID: fexZZHpKzA0eCYpLUlGYKI7zGbRVuyMO
X-Proofpoint-ORIG-GUID: fexZZHpKzA0eCYpLUlGYKI7zGbRVuyMO


On 9/3/24 4:40 PM, James Houghton wrote:
> On Tue, Sep 3, 2024 at 4:23 PM Anthony Yznaga <anthony.yznaga@oracle.com> wrote:
>> From: Khalid Aziz <khalid@kernel.org>
>>
>> Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
>> a function to determine if a vma shares PTEs by checking this flag.
>> This is to be used to find the shared page table entries on page fault
>> for vmas sharing PTEs.
>>
>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   include/linux/mm.h             | 7 +++++++
>>   include/trace/events/mmflags.h | 3 +++
>>   mm/internal.h                  | 5 +++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 6549d0979b28..3aa0b3322284 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -413,6 +413,13 @@ extern unsigned int kobjsize(const void *objp);
>>   #define VM_DROPPABLE           VM_NONE
>>   #endif
>>
>> +#ifdef CONFIG_64BIT
>> +#define VM_SHARED_PT_BIT       41
>> +#define VM_SHARED_PT           BIT(VM_SHARED_PT_BIT)
>> +#else
>> +#define VM_SHARED_PT           VM_NONE
>> +#endif
>> +
>>   #ifdef CONFIG_64BIT
>>   /* VM is sealed, in vm_flags */
>>   #define VM_SEALED      _BITUL(63)
>> diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
>> index b63d211bd141..e1ae1e60d086 100644
>> --- a/include/trace/events/mmflags.h
>> +++ b/include/trace/events/mmflags.h
>> @@ -167,8 +167,10 @@ IF_HAVE_PG_ARCH_X(arch_3)
>>
>>   #ifdef CONFIG_64BIT
>>   # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
>> +# define IF_HAVE_VM_SHARED_PT(flag, name) {flag, name},
>>   #else
>>   # define IF_HAVE_VM_DROPPABLE(flag, name)
>> +# define IF_HAVE_VM_SHARED_PT(flag, name)
>>   #endif
>>
>>   #define __def_vmaflag_names                                            \
>> @@ -204,6 +206,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,  "softdirty"     )               \
>>          {VM_HUGEPAGE,                   "hugepage"      },              \
>>          {VM_NOHUGEPAGE,                 "nohugepage"    },              \
>>   IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,     "droppable"     )               \
>> +IF_HAVE_VM_SHARED_PT(VM_SHARED_PT,     "sharedpt"      )               \
>>          {VM_MERGEABLE,                  "mergeable"     }               \
>>
>>   #define show_vma_flags(flags)                                          \
>> diff --git a/mm/internal.h b/mm/internal.h
>> index b4d86436565b..8005d5956b6e 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1578,4 +1578,9 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
>>   void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
>>   void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
>>
Hi James,
> Hi Anthony,
>
> I'm really excited to see this series on the mailing list again! :) I
> won't have time to review this series in too much detail, but I hope
> something like it gets merged eventually.
Me, too. :-)
>
>> +static inline bool vma_is_shared(const struct vm_area_struct *vma)
>> +{
>> +       return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
>> +}
> Tiny comment - I find vma_is_shared() to be a bit of a confusing name,
> especially given how vma_is_shared_maywrite() is defined. (Sorry if
> this has already been discussed before.)
>
> How about vma_is_shared_pt()?

Good point. I'll make this change. Thanks for taking a look.


Anthony



