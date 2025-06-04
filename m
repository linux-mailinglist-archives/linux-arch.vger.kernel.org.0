Return-Path: <linux-arch+bounces-12208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D59B3ACDDE8
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 14:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2183A42DF
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113A928F505;
	Wed,  4 Jun 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqEo0JN4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BP6QPYlh"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7C28ECE2;
	Wed,  4 Jun 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040159; cv=fail; b=Bq9750MuTJEFmhUC3JfgkXxpgt3MGkvNomxU6s2e3umMrmZnXcv8mT9CzT7lV2xv+Y/PcYQbKqEeiidoM7jrHoQQA6q/hxDvoR5/tsJyfOU6hjIk2YvPeJ7EZKmm0/3/u6yZcMMQCXlArlBlc7bxsJhg/JkzkWe/Qr1neHg0qKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040159; c=relaxed/simple;
	bh=hIObgNEoAusVwXfyuQJUkEcyAX9xmgiPQL7Ntx6Z2D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EZRJPBxTti5xkdW+1mBEjfktfprWo81zJxkCdfqsdSnvLW1vMv0Ptmo7whFRVM5mgX+w2h/l8np6iIzPSfYd0JyjvQ6MFx4PN9OU1IDMDWGTNdK/Rf1pMlNdQ8tjbfHtYPhv6sncUhi9LbTO/+QxzxbUe1evICLAffLe6Nk9TqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqEo0JN4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BP6QPYlh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549Mgsm012305;
	Wed, 4 Jun 2025 12:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=S8ux9laDrq1VlnF3Nv
	OrfGZ85nvj+izGg6V4C3rLB2g=; b=kqEo0JN4cCvcJpoWPLXhmHevSBMTo1He1d
	W89WMqPiewqzNZ80hZmavA+GiXKpXvqtox3YK60XrYoCbo/FTuP5KEktJ53wROgf
	IKMRq4p20fvcxYJ1nqLpvybvZZ0HzOA2hliyoW70riYavj4aLum2SvjpVHjvmO1U
	vkro9wSxq3WBdp3VWYWacemN2lQ01z7Qmw9/uZN/3vspZDiVAIVm6y0HJOUrVRQw
	vr4FqM9l1oPzuia8WTKc47SMqDKvak0ML2T9hJNN12CLq8yl5wKrnaT9lZz+ZvRr
	pIk7o8/OuhcxFuaKrIM40xvvO8UdKiZqBXy4IkOytGmvGDnXGO6A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bkujh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 12:28:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554ADNxx034896;
	Wed, 4 Jun 2025 12:28:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7axhq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 12:28:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3TZKdfjFIVhrazjjH9pCSCvwiggIg43jX2j7w/3SuNwZLmDiJpJ4n8nH01eZbSd+3JyA0N0hUSWKT7ni7KANxtM7QZ95h3nhSoYprbyIp+BqGgw8Xy4ydTR2x5iiWVK+YuV+pZCSTHHN2bwx3uGL1kEfaM1HCs2pVXSU9nztO04ZABBcIF+upgVkdS+2v7mocHyxQZPkv7mEnTdoNgp/dcRQAH2d1O0kJZNhDeKc5+v7OX8bRmvHc+izRlc0KKy4NjfX78PKndc3J8pTj7O1Bejmq/oz0QdcpmwbSHB03D5TxISxhNBvxuAlGkoO0tl2Ox806r7NtQyGNEpm5ejJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8ux9laDrq1VlnF3NvOrfGZ85nvj+izGg6V4C3rLB2g=;
 b=ebgNZxWbQmzqvGOPjXJVhI3jn2X474voxCcTxdiEbC1eikXKD6swpclKLVFim7pQ+PUWHCXocsw2eTrzVN3lllJrG/jgs/9a75CPtgmbK5HMJISg0GFzAcGgATy0OE6sfbGRwtoVscSzp6dF530xAGMA6/RxMePdsc/RiJ4wpgyYI+3L+w3EuwTzmAZzUFE4pELgE+pfvzVx6d8Msj25S2L0M+UeZBeG8Lki8B0id1Zt/N/ENE2D9WCZsVvnayeGP4/YLLuiKokOKpqy+1N3/wRZhYgKlnhzT2E3X/UfQAY76qvd0Kxo+WT3ofRGjMNWxYE92dTduF49xfVmlWQhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8ux9laDrq1VlnF3NvOrfGZ85nvj+izGg6V4C3rLB2g=;
 b=BP6QPYlhjlBWUPKilhMPJU0ujFEArP8zU3hg+qjtX9+ZnBYopa8rwnEdcyb58qglc/hagwNZGKWKNpWmI6RnGn5oc+DwFEZFbv+AT5iA2arw/Sx4VlEpRUFvRmNtbTF3exLTw6W7vAcsI7SrPsczS7MtN6vLd9Q8mHXjxYh7NsE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB4863.namprd10.prod.outlook.com (2603:10b6:5:297::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 12:28:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Wed, 4 Jun 2025
 12:28:47 +0000
Date: Wed, 4 Jun 2025 13:28:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
        Usama Arif <usamaarif642@gmail.com>, Mike Rapoport <rppt@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Barry Song <21cnbao@gmail.com>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <12d7db2e-3a2c-47a2-a973-4110d2424c71@lucifer.local>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDh9LtSLCiTLjg2X@casper.infradead.org>
X-ClientProxiedBy: LO4P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB4863:EE_
X-MS-Office365-Filtering-Correlation-Id: e26cdbbd-01bc-414d-b92c-08dda3635a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8mPD5GfLHiS0MNhT33rQCGwyzeSUDiuyFPXfXXcGb7HdbQGFyDo7lgiAyWl3?=
 =?us-ascii?Q?hcSA+BbI5WZqEVDA43MkFIfQf/LlUVJ1fn2LwB9cH9TbqIZs9vVdWl4zxLgn?=
 =?us-ascii?Q?rVnjFz3L5N6HwuljQeBnEadNuLo+l6NkYwu3vE47SfazdHAauJxTvOdIl70F?=
 =?us-ascii?Q?JEmOrvTCV37MHHR78xOI+LJym0aJfUMVFlQ4DM6AJnCw8E5yBtzPoOMfKFQW?=
 =?us-ascii?Q?MtMKGMTNjjwaNA2x6SzgCMXnN3uLFflA5UuYnWMMK1vR/njPvbjsDWKDosYa?=
 =?us-ascii?Q?80kGGaz82rRzuJBzhxxnGaNPAcphSOjrm3dNzvlPeUhBHnP+1QZ5rSTCOGt7?=
 =?us-ascii?Q?P4jQqBgvazxvId0a/ETME0i6WS1CjDd/wDway6hBU/P/8ik6h+Qbow1y11Qk?=
 =?us-ascii?Q?3U2+JIQ1asTty5biNzFitywdQH6Zl4RkmEvFU+2Vr9mJnrRZpBoQLfeK98EI?=
 =?us-ascii?Q?XDCrM6NchhkcZ0Ega5bvM+ou8XS425SrlzPw9f5TZNml0EqFhQUMpcFMBMEr?=
 =?us-ascii?Q?ax3GJ9KCwtwFAJ4cdSi6/0HhL2/a3clUkwU90cS/e57MKnlXANUuaNFNRsuK?=
 =?us-ascii?Q?Kgeefj0Ni5ZH88M81H8vdz9kv+56A29xWWo0ySE+7R0lhUgpuc9SGq8l1UNn?=
 =?us-ascii?Q?u8oNMWHCD42X4PHC3V7UN5XEmfmWSEFKIMmbXfWMtsn6BCME7Su8ZfkUTAkF?=
 =?us-ascii?Q?x/YsdzuhzdNw05ktRCx/h5oTRz5/afPvNZuWC/g50WLh2QtbjAKH3qPlV4L0?=
 =?us-ascii?Q?S+26cqrtuDy6HtRPi7SuJAEZonKS/3jbSk15rolT36AgF6oFg77JQl8GOHFh?=
 =?us-ascii?Q?o5/XyVp68L3xcTGthq0D3L6LiaCAokUxiTcCnq3Pk3fpaTtCSt4AUpNyVSDO?=
 =?us-ascii?Q?Pj8MudzEWgCqSuRbojDHsaphdcMHAr/UWjHV2l0jKEG/YXJw3FXGjlZxy1g6?=
 =?us-ascii?Q?3hpyjEjFzYFFgXohRxXzCrLFA+PR2aWa4czDdKWHwX4zB1ocOUGg6/jFLGHW?=
 =?us-ascii?Q?n+ye51/i2ooun6XUG+dV4agptd1UnHb/OqDDx/GoeqU+9g4SuMkp/jEvi3Es?=
 =?us-ascii?Q?u7U2v7E1wzAA1ekEVRnq5cKnr5PrvOyU1Y4qcNC9GaGLpXYA105XED4ZPe+O?=
 =?us-ascii?Q?cAKCVGKn+gIyALH/vCzAsbD8c+TjKD3fqUZzBv5oL8fhBaOzA00/9q8tkFxD?=
 =?us-ascii?Q?YfI/gKMUmq5Hhvx+NbPHDZnuU7VvZdH4bkI4OQBZg8iVEEVD5VOrLVtLCVEs?=
 =?us-ascii?Q?LfDg+yUwfQSCSHjNvYHUxYVfniM/Bkf09bLmZ7I05EDqU2YMlwFUwMr7aWwq?=
 =?us-ascii?Q?Kuvj/e9/hBKXvnzU99/4XPcNzpJcmzlY+UH/gEU4Aa9LlkHqmEQLJ9zY0KJ9?=
 =?us-ascii?Q?nX1OJ8AQJJ+VTHF875Z6jb2PwSEMXyzqrHgiQ1Fj6N0J4lr5AHPT8/cOtisv?=
 =?us-ascii?Q?dbOZ/e+iOaw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Isb2Wia9XkWC9kKh3LKBhuDZvfJxjCTNeTjUMuWb7CRr54UBe7JqJVlp1dNC?=
 =?us-ascii?Q?JG7MW8bsPBHgm2FAFZJQ/p9/2rqfza4s0DB/F/e9PhR5Pcjk+u/tsQCjkBFC?=
 =?us-ascii?Q?Jzk7dCcXoKbEI6ir+KzoGnh9TT6rwKT3xaEVKx5O+khULUWDFsaU6EShb2kw?=
 =?us-ascii?Q?jGbZtgevGAxDRhLOTecgikLAOyQACyeS76Mcj/vkLG6J6tkDVfa9DC/vguAl?=
 =?us-ascii?Q?p0pDTrIBXgs6OW2Fje3mRGZsHXcncA/xtydqbDilP8U+CqGVaP0AIItfYLhX?=
 =?us-ascii?Q?TXultGT11ljNFeFhrNQbajz9k0DwRMcQ4C9x78YvcrbYdMsnQUYK7T6/IpGz?=
 =?us-ascii?Q?v2SLcShlCQbGj0Cw91qhb3od5u8S8M0p+co9p7GqW81n90KJXyHRpEHnkhew?=
 =?us-ascii?Q?WoWhgOAEECzAbIxll0ft2+18TDkMeKuTksPFx1gBwC9TqIssc/Qh2OlLHPxS?=
 =?us-ascii?Q?/IH0qkuiC0do1N9c+B9v+lkagkAurFVoeqRI2IFEOwZ0QqQTjc6kzMR0wsUD?=
 =?us-ascii?Q?qg8aH77eWuMksCZ7A9jwDlQR4IWFNM3gpw4cSh5Ma7gVhY89t1x7asWT0grY?=
 =?us-ascii?Q?UfI5Wpy2G4VNkGX7maOgpalPp32En5TpDUW+W+aF8GwMqYT66hOUi/pdnUOS?=
 =?us-ascii?Q?j4OmekM0TVsU2vbZcyZUJEAFflUxnwN+jfvuPAGaZKYxX+JrpLgeC1a2/Ig/?=
 =?us-ascii?Q?z89TD6P+DcU3l/YMTiqeN02xisIfvESkY+qg/0/EWBA7MtGKgBI8CZCHxe7C?=
 =?us-ascii?Q?ibDmLsOuz9LbqbI9hVqgx3EnSFlmnB7xcfajvx/rTceYxtRPbL00rYWOUzX8?=
 =?us-ascii?Q?IEH7MAfIMYFjLnq3WyhRfB1sH6ZL2W1kr/FeWFxmAXs96PXCydA4M/b3oOt2?=
 =?us-ascii?Q?pPXZpb/7evf3M8+r7IPoBeVZnVmJntACPOntmfhq18ksbkGpxy9MnDO4eRPY?=
 =?us-ascii?Q?NuEZmMql5cK3D5ve9dyS+SyuNaA4eKPJ6D2BTSRCKdr0N9+2NibGSYk2kuz1?=
 =?us-ascii?Q?ldwOketx8sUS8xSs178M8srGO08BqZTAxV39WoxDK5YBPLVt8Dqezi85clG2?=
 =?us-ascii?Q?Me6ZbxCjrwTOYzcZVEckrv5vtfxQEPur9dvR0gwRqFRiY9+cDCJ5uw6W4fXV?=
 =?us-ascii?Q?/KYVm+/eq3deiVfNzYjjDq14iDKDjqYsLMtW4cR5Cs1CKwrobkBx6LwoI0h3?=
 =?us-ascii?Q?JH17Ofd7XKjd3pOy6WKyQyTZYS074N9/1f7YOupp73O9aCj/5zNFPfWQERqU?=
 =?us-ascii?Q?HdrbvlymbutGncKBatV03ZhqWIahJccwvYvpJAMwfBADHNmeaNKypRq29oNk?=
 =?us-ascii?Q?Jc1n0uxCd1ZAaAZs8uBfYVP382YkvmhXGXCrRHJA3wd5CUHV11OITu1mlo4n?=
 =?us-ascii?Q?x+H7fis7fyJKWA882aLyrhe/a8su27mmGYoMuK15Pm+OTw4DHBtXuxPhIo2p?=
 =?us-ascii?Q?OrKPuCPz8uWniooqkIvT/Q+YQze+ZYCis7Uw75g5uSTrtILz4ogn6D7U00go?=
 =?us-ascii?Q?ZIU3TobMYo3iXZRkH7/rMjTu9dVkzCwgoHkpOD1dJsjdMRixk3VB5SOx2YzM?=
 =?us-ascii?Q?3oWdiv6MrKRO/OKYsarL/ADUECj1IwODDoIHpxU9vaDjZ38uzQXSSRO7evPy?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dsRb2f4/3rsRowS/pmfybifBt/na9YTyV6yFnFZeZa3kgbSaq2eF8WPP4HSJ/Uu8UvOHFBAVVHzz+1GxuWdnBtiBug7weqr5hDnlcXYYNOXdk9a4YZr1mcS4nMwU30CQqbML/ht9NveOktGEfVQYCEzlt+Be9bI3PgYrZA+3LInL2YGzFkbkkETH5sKCIsOWnaG5dBnXTyCcN2UKCCIJ7Ksfz9bSVq0Ez0RY4xPbZWGx8/9yI5NzyI0ER8R2jGrrh8vLp1uuMFomKGg6Be3Gkm3szrX9Jsi+2dvPXe3h2l0/TysRAnxs+yztbOYXWniKUWj9n9AC6fWH//QMfq0CLnOSEuIsR0lq7EyyhJyeHDGtxy62Sqt5RCSjdVhaIlF9c0+UxyQzAjwUWQgY3ggk1BBfjOnZ/0HvBU0yJL6uZLvejQpiXI72IU4WqVOkRJ3xZsYucxFDErhF8/kmFrZRs05EN+YwI04cJc8HSPP97EoZKJchhNN8p46LX0laB/X9vKGoZGilwZd44DVJYkMHSWjyVyBS+kdbl2sMTkHrg0xolqqRJrkHJMX+3tm8l3vYtrk7qtGrY69hNzI7L3zNA27PxNqjkxjOdYJoAM6fkeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26cdbbd-01bc-414d-b92c-08dda3635a97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:28:47.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmaByHSHFr3K3D2AyioAy7/rjMnZdqzmPNcIGcZ9Cu2OlDKwv73Zs6h82HliWETjKuEkgLMcrSekbkOVyn2WEhjmq56ZvHswf0fn1WOpqHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4863
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506040094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA5NCBTYWx0ZWRfX0MD3Y1ZsUDNj aw/sqjxa+/EvF1ldyQF4UIhN6FbYt5kLNDvRWa/+6J2MW356nQXo/ru/ImMU0Co70Z/YWPdyjko IPZcCjGcPuqPlBpz61t2arhLRczqJasv3eWgjJKZsDLyeZXWnmYumKUA6MA+s40ytaAIbw7EVDS
 P/mx+h9pteGVWzb23ddXRWsJC2AU15UEldG71nRyXrjf6v8BEemz/8iyraGaMVU33U3AKvZTx4y cEJzLJC8rCpnYf0gbROmZuHC7/fkohlH39oa80JlNXAGBjz5cOho73mconMNHEI/HHgG49BnwYH NTGkhOJrQLVaMM9sc+OeDSF6bkuJFHAvd+xQQIIEt0t21TPxrkGiPPPhRhHoTsmdVpvOs/fysjY
 8c0eIiFhpjgWEyA4mRfTQRF/kY1Uy3FTFhoO8jkN8BJqqVJ+nKlIQXSAVfJVBIhlYGXUzFrl
X-Proofpoint-GUID: tFFiuak-o7u2WKrY_zZ0W9NmSZd2Rxbd
X-Proofpoint-ORIG-GUID: tFFiuak-o7u2WKrY_zZ0W9NmSZd2Rxbd
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=68403c02 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=JBLUMK9MvXQNA3m-8AwA:9 a=CjuIK1q_8ugA:10

On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
> On Thu, May 29, 2025 at 03:43:26PM +0100, Lorenzo Stoakes wrote:
> > After discussions in various threads (Usama's series adding a new prctl()
> > in [0], and a proposal to adapt process_madvise() to do the same -
> > conception in [1] and RFC in [2]), it seems fairly clear that it would make
> > sense to explore a dedicated API to explicitly allow for actions which
> > affect the virtual address space as a whole.
> >
> > Also, Barry is implementing a feature (currently under RFC) which could
> > additionally make use of this API (see [3]).
>
> I think the reason that you're having trouble coming up with a good
> place to put these ideas is because they are all bad ideas.  Do none of
> them.  Problem solved.
>
> People should put more effort into allocating THPs automatically and
> monitoring where they're helping performance and where they're hurting
> performance, instead of coming up with these baroque reasons to blame
> the sysadmin for not having tweaked some magic knob.
>
> Barry's problem is that we're all nervous about possibly regressing
> performance on some unknown workloads.  Just try Barry's proposal, see
> if anyone actually compains or if we're just afraid of our own shadows.
>

So from my perspective - I very much agree with the concept of doing nothing
here, ideally :)

But I feel we need to look at this problem from both the short term and the
long term - in the long run I absolutely agree with what you say.

In the short term this proposal is broadly 'what is the least worst means
of establishing policy like this?'.

I think there is broad agreement that prctl() is sub-optimal, so an
mm-specific API makes sense.

So it comes down to a question of - how badly do we need to be able to do
this _now_?

