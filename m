Return-Path: <linux-arch+bounces-12003-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D49ABCEAA
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 07:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBEBC7A8985
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 05:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382631E835B;
	Tue, 20 May 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q81VUxEK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X9YEUhz6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5545929A0;
	Tue, 20 May 2025 05:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747719381; cv=fail; b=Ye8rfGyZLVlf+3aw2G6OlAi6YMYm1Q65TtpF2FKEYEiKcS23Vu9p0PQx1Gyy7kFkB4Jd+SFn4QmMtmPj5Wqk6MOtSex+yDOjkapaCLM/9hNm+Nuc4wpy7oFS/0Q7g5hj6hKYizfWDfNxpvO6XoqeBj/Cq4flzky/9/Dxmraktlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747719381; c=relaxed/simple;
	bh=grlPnbwNTP+4aVZTGcdxvqqX1kHYXmwxOxTyb71DNws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UFM3pm5J7H0XglYYA89vNZC6ufjdA2QkeiJmNA+hu3LYChZ2FyBCgUcvWB5tsN3Jcp2GBwGMi2dwofIIE4364an2flB5Keo/9FDyvYYuxm1vews8zuSSIF6dsOecSmom13MMnKu7FGwlRBwnJ0TyXo0TP1oEXibdV7pRSLn/Llw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q81VUxEK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X9YEUhz6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K1NHAT001186;
	Tue, 20 May 2025 05:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=grlPnbwNTP+4aVZTGcdxvqqX1kHYXmwxOxTyb71DNws=; b=
	q81VUxEKk0iTZ5SPbkFHOx6tay8eim6ov4rBBPBjusgwoIizsLQCj3eZkdiIwmsX
	1cLdG7TB0m4DMXy7geljVJEx0WjtjPn6/IA7jqrBGWS36YI3B9wtZxbYHnZy8eNU
	nPyO9EnE7rKj9Iy4yqUbfWeCQtzqzrX/H86XP6pJZWn3EuCArkWYFEylea1l+2Lf
	lpikNJ8oPqbGL3M+CO57ewXaybHgICPMdAdBaRkzyNp9J8L5HvBvSjjljW5xHRPj
	Wt1Br6n4mnGxESGUtN7/TiYFCFhMN4e84BUQ/VdwwKlL/X3jIQlDh0mj+fW8ArH4
	xgmnpS6WQfI38A1kEaivEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdcdrdb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 05:36:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54K3kX1V002494;
	Tue, 20 May 2025 05:36:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw79v5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 05:36:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8SjsGF1co7y8tAfLqIu3gubEs6G8e3NKLSMJBUO1jNxMAjwwf+B0ym4WlwdanryyGgTN2kD14iaRckgVVvgz6Qet1ozaaIWnfCkqerWEgkHo6JJasftP/YYFhBVkF9blMDFPRV6hmKTipRvIXebKsyO36A0pt5vRBh2kYwkQW9h2HHCpkQu27lEQ3jofh7hT+fPuQGs7EOVOFKcsKAKFmkNhtipLn3AekFocbtXKvc4j4K7FSwSUNg0tUZYJA09oJvgEYPcMVzcBLSUeYTaGyXeWstBcUQTDU3GY7npBD8pIgbylrAFOHF5YDU/GSvI9rOCN2jIvOHDLzpGK8Ws/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grlPnbwNTP+4aVZTGcdxvqqX1kHYXmwxOxTyb71DNws=;
 b=TUOqwKiO86f7SiS9UeAtg1hUL4fyPlBtdzEs2uDXkEklwi3E+FuKZwQYXgTbLveLMC5KiOEPi739jD27vqZ1RIh0vBRU0/8Kldn1I/BFavqJLLLF28SJBG/EfXYW7yAaPuLBoj5mRW8HbiGLAr5A2cxQUgWt+pO0monuP5N9Nd4AnAQivH/9xaLnRhFz9K/TZ0PcsmzO42nR+aOuk+4YqHKVizNeeP+STwwtlXbTQmiPfokDsKxr/wg+7JjncQY20fKt/t0RLIAmOc1TUPdQd8zlKNpz5hBBZLCooeWf8xAhvfaPMpjgtacMLcl5iBcdeDkhlNmBKvvsDB90SGHIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grlPnbwNTP+4aVZTGcdxvqqX1kHYXmwxOxTyb71DNws=;
 b=X9YEUhz6iDl2rrMaaIXRLwDe0v9K4F0ZZBe/hXq4+neN8wkSkpyJXcmksYSiRiW0pv6yoWSFmMdwQuGOHFeo+CuJKtps+C/dROMwnhi1mJN8nAqRTTkzBvqY6Jc6C3Jbf0AaVsaShJVyuDiaKvm6BJLTt+Gkp+mWt1u/AuenYe4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 05:35:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:35:59 +0000
Date: Tue, 20 May 2025 06:35:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <368b0ca0-605e-4d2b-b12e-c24b1734d1c2@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e7034f-700f-481d-a974-08dd97603367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFV1Z1RST1JlSWkxYjdrR3luWFUvYmhIWVhMUG8vbWdhTkJzTGp3b1kvUnVj?=
 =?utf-8?B?eGI2TTJZTVpBL2gvaytuWWlPL0ZGRGExQVM3NGxaNlRIWmVmd2pSZ0hNd2VJ?=
 =?utf-8?B?VnpXcmRIa0dEY1h2YW9SQ1NjYTFMd2VNNXNwMk1Ya2h5QUI4Mm84TG05cG0w?=
 =?utf-8?B?QnlIV3gya1dEL1pWMWJmRU5YR0ZSdUJWQmdIUEFYYm4waEcxSmdPOHRCL0dM?=
 =?utf-8?B?clNSamR3VjdRRkh2SnMwOUtSR0d4WTlxeTM0RGFYeENFeUYyTHhuSVJRVC9O?=
 =?utf-8?B?N0pBd0hhMCsrWUtzUFBqM0NRbUZnVkl3enJEMzVjb0dYbnV5WUFncUcyRFAy?=
 =?utf-8?B?cnhpV2ErK1dFUkJtWFZrMHNwUmN1Vml0djVXa3czdEllVDBoRzJFOXFSSDlo?=
 =?utf-8?B?VFRja3BjUWtxTWlSRGpFY0dwYWxjNHVJYnZNWnhVQWluNHpLWWRwdS9KYjVE?=
 =?utf-8?B?UGtXWTR2dVM5RTVNSWVmTnNlSjRGVzNUZitJc2RJU21ESERXdGpBUjZsaHF2?=
 =?utf-8?B?aS92L3BuQ2xDM2RwUm1rdHNwT2FITkRBN1RwaXVpVjNCTGpuRUcyOHFMOENl?=
 =?utf-8?B?L2t3WXZiUnZ6Nm5raTZMZHUvb3gwaHlQNVpKbHJuUisvYlUvV0RwNkQyZmF6?=
 =?utf-8?B?Mk1TYWJudXB1S0QzM1pOdVhBMTFNWGtSVzdmRDZxYTUwMFFCaWdPZ1RPQVR5?=
 =?utf-8?B?bzIzQkdTbDFFR1VCYXR3aXMreWtFdE5sajJiY3M0bG9rVFpEanZmNE54dkQ1?=
 =?utf-8?B?dnltUzhDMjQwamVkTWNXRStZZ01lWERTNFJRUmRZMEJRUHZzc0RVNzRjY0Zk?=
 =?utf-8?B?bjd6aStnalNBMG1ER0xEcGlDSCtneGl3aWhVOUpPcC82ZkxweWVMRThpY2dJ?=
 =?utf-8?B?VDVCQ2YrUHZmczBEbzZlY25BVnlvaHpzVFNsY1hEM1Q4TzVhYjdSbXdhSW0r?=
 =?utf-8?B?OHpGaFdwOU90RmJIVFp3Z0J1T2dySmRTRDdlaVpXSTJyaFlIQnBHQzVkTTk1?=
 =?utf-8?B?cGlKUUxIb25JbEg0dUVLSW8rTEI2dHlOaTVtdElBK1VtQ3JFdWZieDBQbHF1?=
 =?utf-8?B?ellHa3UrTXVheDBCbVhKZFdlb0xzMjRwVkV1MmhIYlBTSEYvNGIvdDU2dm82?=
 =?utf-8?B?V2p3RHZHUGpJRVF1QmJzYStzenpJUFlsUzRGNmp2ekR2RG9KRngybTViY2kr?=
 =?utf-8?B?cE5uMjBQWVplclJ3ZTI1QkEzUXlnYVB6V1FWaUVDcGRTSUpwTTVQa0lVKyty?=
 =?utf-8?B?bkVFQXF6MnlnVXlETTQyTzl2bDlIOFIrWUN6c3FLUFNUMlVMaE9aRmJ0NExx?=
 =?utf-8?B?TWJ6S0FGVjM3Z2dJNlFqVE1SS1Rscld2RVc1NkJZbnpHR1JEZVFwOXRSNGJo?=
 =?utf-8?B?RXFmdGlQUXFQcTlHV0ZodlpWU0VuazJoUjg5MUM3S01SNzFXMG5BV0FuOU96?=
 =?utf-8?B?cCt6Z0Rkbk1UeGRGZXU5K2w2UzREV1JET3F4QlpYTjFUcGhBc2ZkMWEvTFlD?=
 =?utf-8?B?VSsrUTN3Q0pBVWZqRDJabTdxQUYycWhJS3ZBMDRpamxBcGFlOWtLUlRNeWxn?=
 =?utf-8?B?WG5MdEhtU2VTaEo3QmRzVUQ1VGpEZEpqaFV0b2I4S2hhd050Z212ZmhEaGow?=
 =?utf-8?B?L0djMnBlc3p5UHBXZktKLzdscjNNc2tvdElFYlM2bFVVTkVVNXBHUjM1dnVn?=
 =?utf-8?B?R0ZBYVRUMVl6U0RHajBVRnpQMnlkTDN1UHB3ZkQvaDBUSm01SW90a3A4V01F?=
 =?utf-8?B?T0s2Z1lPMmphQVlCdkR3Q0hVSExKZ2svRkdXLzRnZEZmOTN1d0ljbEZhUlFp?=
 =?utf-8?B?cXhuWE51MmlmL0dVZkFoYm9YbVY3SkJVeWM1L0xFQjJsR1MrLytCM0trUHg1?=
 =?utf-8?B?dTUrQ2UyWEptYkE0RFd0NThRTFN0bmFuVGhEemNkN2NDMkVRLyt0YVpHbzFz?=
 =?utf-8?Q?JXaNjMr+6oA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V01zVU5tcFJoRTErcjJFU3hwRHdrMm9IMG4zcmtjcDNVMlRVdjRxNHpwYWI5?=
 =?utf-8?B?emduTDlvRllGOVZtM1dnYWlBbU9PK0Z2eitWZS9WQWNlRDR0MnExeGQ0aExY?=
 =?utf-8?B?Y1FDYTlBRnpScXdLZ0tNSC9qRkRUV05QWEc2cEFoTk9qL1lFK3VmRWN6dXVt?=
 =?utf-8?B?ZzV5bEJ5TkdhTXEyS0xtdU1NTFB5RHlnMmd2WmxpV2FGVExmOEVHWFJLVERC?=
 =?utf-8?B?WS9naWNWV21VUDYrdzh1MXJFY0dUT2NOQTNDdmlnd2NvR25RczcxMEQ4Mm55?=
 =?utf-8?B?cytLNlRQYm10U3k0dFNuYzcyM1lWbE15SDZtdDBhcjh0SmRWNmhwNU4vRHJr?=
 =?utf-8?B?Sm1EVXhUdUx4L0U2K21oYktsVEdVSUdWbVZrbGZZSEFPRjJLelBBYkM2a0Zq?=
 =?utf-8?B?bDAzblJuNTBJdFpUN2ZvQnRXdWNNZ1JLMnQ4N1l6b1RibS94Tlk3MkdOL2lq?=
 =?utf-8?B?WU5wMEkrZ04zZGJjVnJLQjc4MlZwQitNSEpiYWdEYkt0L0JFdTg5eUJWaFEx?=
 =?utf-8?B?MHFPYm0zQTJRRXlsYk9Cb1N6dkY5bHBlOWZMUEpXV0lkQ3V5STUreGM0aTdY?=
 =?utf-8?B?R2VPWklqZDR6bjdDUkJjTzZxaDREQlBheE9jNnNLV3FqWHZpNExZMFFWYjc3?=
 =?utf-8?B?cGViZ1dVK2o2aUhoeGM1aEJ2ZTRyZEhoSG00Y05mTWNCQ0hyS2c2Vm9ZWWFj?=
 =?utf-8?B?OFdPWUI3QndTaXhURHlmWm5hL0E1TnIvZ1ZxbEg3bmVMK3NzUVdkSktBeDVJ?=
 =?utf-8?B?Y2RNMHFNRlJQUGFHS0JGem1ZZ3YydHRNa09VMi8zSVVvRkE0aVE3SzhXazkx?=
 =?utf-8?B?ZWtnWGVIOFp5WXBxSkl1eGtrN1RMb3NUaysvU0U5eVh3Z2NZbjdOaGhyWGhG?=
 =?utf-8?B?V3hDTmxxd1d3MVFwMnp6d0VqRFRGTENxbW5FVDVEZXRqL3EyL0NDTzFLS0Ra?=
 =?utf-8?B?Rnl4cWVmOXltdE5PVWQ2eUFveGd0b1kwOERVclRoRG1BaDBCWk1nZFdEMSt2?=
 =?utf-8?B?SlBkMnpwZTROS1BIN25FZ0J0NTRFZUxYcDRQUFVlTENwdVB2RmdHQmJUNjlw?=
 =?utf-8?B?cmYwOUs5OFNQR2E1aHhoZlJrdkE4eTNXQisrRmRxU28xMlpKT1B6aXJ3bGdF?=
 =?utf-8?B?VlorUkJya1dOSXQ4c04rOFBFbEJhY09yVDFrSlZQenZkM2lNN0pOeTJFSkhk?=
 =?utf-8?B?YVFTYXpwakRsK0tEN1FBcTZibTI4M1pqWUEwb0FQSlFBd0ZldUZIdFJaamZL?=
 =?utf-8?B?K0tvSDVwZFZJZExueDRVVTJ0QjhHV1ZyZUtJWmZHN3lrVVZXQkdNdEVLd3RR?=
 =?utf-8?B?bmFEK0lobnhWMk9RNGxZaGhNTzAwSVpidjFHUGJ6d0RHa1lEVEEzcjZVKysv?=
 =?utf-8?B?cnV5UEVWbHNOMW1hSFV0NnYrU2N1NkZ2THp1aEs4cFNuTmxBRTAzbllBVTht?=
 =?utf-8?B?Nmsva0hTOHg4dEc0UlFxWjNWYWRLUDVBUmdtYWkyRGtNdVBkMSs1VTFLQUJ0?=
 =?utf-8?B?ZmtIQ0hVK0Zncll6VnZCQ2FFd3Y3REFEd2pLQ2RqQytMNGMzblRJU3BpeHlR?=
 =?utf-8?B?QkdZMmVUS0J0LzZqalRaUDVMY0xVS253blE4bDFQQlV1RFlxbEl2RzE0b0I0?=
 =?utf-8?B?WHlPQjlWQTRGaEkwK1ZwamxKUTg2aXpNNThsT2JhbHo3YlhJUXVyZm85V21h?=
 =?utf-8?B?OUIyVmQ3bFhoUDd3WERSeGx2bUF3eHJzb2Nmek9Pa3ByWVpvQWFOL3JtQXMr?=
 =?utf-8?B?RjRNVlM2cUdlck5wbEdGNWRPYXl5VXJIWTJVQ3RIdk5DMkw3MytzOFNwMVE1?=
 =?utf-8?B?aUZvYTdEN09kRHgwNjFjZU1hL29Sd1lubEpZNFlsdFVvMy9XSkE3eEtoN1Bq?=
 =?utf-8?B?NEZUbUtIK1kvdzlvUGRIMEZLRFBGSXhldEcrOVVWVEprMlZXY0tSclpRNStp?=
 =?utf-8?B?U3o1VlNLTHdFaWd6QjVoK2toQzNMSEs4WTBpRlYwVUF3VWNJSTRBV25VQm5N?=
 =?utf-8?B?WEM3bWkzNGlZc0hheTQ3bFpXeE1CZVpackVaK0FoZ0Y3ZEp5SlE2RmZaa0k5?=
 =?utf-8?B?RnVQUVlBNHpGYlM2bkN3SE8zcFZ1aTUrcFIxdktaNk5hUitONmpPKzlETWxq?=
 =?utf-8?B?dGgzRlIzeEZxNnk0WlIrb1hwb0xBYVZ1ZWlJWGdDM040TWhHWVZseEQzbG91?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jOarKASxeTiul7sHStI3cT3PP9nGd8a0Jc9FGYbxNuWVJ594qKj+lb5/WJgwr8lwk5QMdPlmkDRK/tpHcJ+gfr7QftNHd4c5cI3hNIKPb+MqkudZElPWJtbBsn6mP1ZUu4jjDeTO5bgi0Lr1q/eUwq/HX/cRnp9Q8otxkIZuatoK/jh6M6BcZye9d46JI0dM5WMQfCjQAKTUYVOVEV3vr/iysaV7gAmzf/19bClOUZKLgGlMpePNpir/7Nd//kqXYhJS9pCQ/y8OVsv+vFWZ5HW6/Hbg6OZubH7b8j8Mt1qulaTiSnu6AfoLRRdkITdnFmflk3yUutVrayiXS3MSvJ7GNZRKVQnLkDyMomitI8SK+BUwHjP27CkThWt+qh+NEjKmqGAJfVp8y/d2kYnXy0cOulsHHI0fImO5hli05rkNxeKmMPr5EuMvwx6fjNINuGkbohoQKu4qcLRpSoKaD2tO+NtePWeGvK1ruDSbXVKrPk6DA+puDuUGbmWW9eF4804SK2o0MqBm5GTCIJ2/QZKFsQ5t70LkFQOXcSrnlAls9kJym5wMOqFGmlmfaR3wKXcAalqFd9NOlI1RVmevjwycfavpwPsfDchxMuRrXCY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e7034f-700f-481d-a974-08dd97603367
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:35:59.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChlzN/LNIYxWF5u3yF7IfJJUdQc7Ef6nar85om5Pmoe5AprCiBK+xIe2n0l9YhpI34WyKXeROXAYqbP7YD4dV3esiBipuqXwW5X81zKRF2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200044
X-Proofpoint-GUID: WEhTD0aeQ6TB_YPunpLinU2xMs-AaB9c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA0MyBTYWx0ZWRfXy52cleGluZcL CnRdDWmcVMQW8kajmYP7bgHv/DXxyALUtPA/iJDccnEyC9WMhcDbQWqW55d9sURfwunPByrvlWL S5BfcwvUQg3sjglgt0R0PcQudrqjvGKizaqI2l6mUviRY51j73zqyHb8HslbK3NgrZyuV5CcFdM
 9e4P4iROESgDLR1PwH53GuCgTGbLMXvyOxs0ULug2m+Ec+VrED8s8XuG0Hx1GpbtZyRSk9/LgFM B0ppuPJFsn5OOs9eZTfnkcvrkdWHZ1K0yiuSgjmFs9SQR0wNMkBRg9/+3UGvQvYwgAOpX9mwGMs UeXh8/79M0FyKOfvDWhOu4AYiWvZ1QvUMm8qhBvGmu01I24JDg13iSyLxZ0ujRFKWfkpXs38T02
 xDJP5bL53tcWzRDKxBY18Gajm1h3dNNk+1mCXiqJ8YGr9aLldkOHmyqbv5T7Gw2icK3JZ7mc
X-Proofpoint-ORIG-GUID: WEhTD0aeQ6TB_YPunpLinU2xMs-AaB9c
X-Authority-Analysis: v=2.4 cv=Ldw86ifi c=1 sm=1 tr=0 ts=682c14c4 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=HSvmCJcLluKmeNGRlnYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On Mon, May 19, 2025 at 11:53:43PM +0200, Jann Horn wrote:
> On Mon, May 19, 2025 at 10:53 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > 3. PMADV_SET_FORK_EXEC_DEFAULT
> >
> > It may be desirable for a user to specify that all VMAs mapped in a process
> > address space default to having an madvise() behaviour established by
> > default, in such a fashion as that this persists across fork/exec.
>
> Settings that persist across exec are generally a bit dodgy and you
> have to ask questions like "what happens on setuid execution, could
> this somehow influence the behavior of a setuid binary in a
> security-relevant way", and I'm not sure whether that is the case with
> hugepage flags but I guess it could maybe influence the alignment with
> which mappings are created or something like that? And if you add more
> flags to this list later, you'll again have to think about annoying
> setuid considerations each time.

I do absolutely agree they're dodgy, which is why this is significantly
restricted.

The intent is that we'd _only ever_ add anything to this list after such
careful consideration had been made.

And obviously then you can assert whatever checks make sense for each
permitted madvise() flag.

Obviously this change is motivated by Usama's series, looking at an
alternative approach (as well as - at the same time - expanding what we can
do with [process_]madvise() - an ongoing bugbear for some time).

So this provides a less 'tacked on' (and thus bit rotting) version of this
change, to enforce that behaviour is consistent, aligned with madvise()
generally, and also importantly, maintained by mm :)

>
> For comparison, personality flags are explicitly supposed to persist
> across execve, but they can be dangerous (stuff like READ_IMPLIES_EXEC
> and ADDR_NO_RANDOMIZE), so we have PER_CLEAR_ON_SETID which gets
> cleared only if the execution is privileged. (Annoyingly, the
> PER_CLEAR_ON_SETID handling is currently implemented separately for
> each type of privileged execution we can have
> [setuid/setgid/fscaps/selinux transition/apparmor transition/smack
> transition], but I guess you could probably gate it on
> bprm->secureexec instead...).
>
> It would be nice if you could either make this a property of the
> mm_struct that does not persist across exec, or if that would break
> your intended usecase, alternatively wipe it on privileged execution.

The use case specifically requires persistence, unfortunately (we are still
determining whether this makes sense however - it is by no means a 'done
deal' that we're accepting this as a thing).

I suppose wiping on privileged execution could be achieved by storing a
mask of these permitted flags and clearing that mask in mm->def_flags at
this point?

Mightn't a better solution be to just require ns_capable(CAP_SYS_ADMIN)?

Usama - would wiping these flags on privileged execution, or requiring a
privileged process to be able to do this break your use case?

>
> > Since this is a very powerful option that would make no sense for many
> > advice modes, we explicitly only permit known-safe flags here (currently
> > MADV_HUGEPAGE and MADV_NOHUGEPAGE only).
>
> Ah, sort of like a more generic version of prctl(PR_SET_THP_DISABLE,
> flag, 0, 0, 0) that also allows opt-in on top of opt-out.

Right.

Thanks for taking a look at this! Your input on the security side is
absolutely invaluable :)

