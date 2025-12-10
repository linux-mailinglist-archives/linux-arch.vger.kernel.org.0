Return-Path: <linux-arch+bounces-15320-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E90ECCB2CB8
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 12:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5B3830080ED
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCD21CFFD;
	Wed, 10 Dec 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="meXAr2xQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y7hMG+H0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A532AEF5;
	Wed, 10 Dec 2025 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765365365; cv=fail; b=dr9eDm5ZGlQivc5Yr4BJWCz/iRopD31TH50g5Qeah0M96VV6C5v/nzX9jZx0ebAVpui67rfz9+py3Y6fORii4w6wz+QUWjqUm6gn1bH9ABDuQ7boZWhQQNOvu6xhcBdZr9/UwiRtIFYbLsY3mMkDwrnbRv0t86fw7+Zi3Lae8qQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765365365; c=relaxed/simple;
	bh=5/NUfdgsoJ7uUU/9W2ZATLZsOd/zaFFR8DugDkaOBbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fEKZ1OhGKBnAWL4SDpbgWCIIlb4aI7rLal7ToCbzNqQjCOvXG7CNXZV8vferz+xt8H+MD62PicGPZiyOHedB37QRG4M8VSIRm1eivaLlCS3ghNzg9gu7VwvU+zcEoGeXfB7SnYqjDdgMUQBzyiuaZi6UrC0Lczb0xOnkuoADRR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=meXAr2xQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y7hMG+H0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BAAvVx82961716;
	Wed, 10 Dec 2025 11:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bf5kjDDGt7oRqBLVg1
	ZcLdgrEGOuPID/SU767+X+96M=; b=meXAr2xQq9HaTh0mvPqSpUKaWnssMq2Zfp
	dlauDnlEHA+8DXr7LMSGBAZ6EhzUeC/BAs+WGFIDSBomvwqpdNakAOhSBGoQTEjP
	0IRVTyJrblaAjQBn6R0DTB9hp8V6VpRsIM5yYKEYom45Sqd9hOHP+cTPttKjg/A2
	FiNrxX3dPYRqphuaE9nDUtBXd1QQO7jCWt8NDO3RTzfy75X42e+TdjoFFmC3ojZw
	2FzRwbuzLHWbxDi5ZjUTg9TnI4tWMcce6MgmpA8gCabzmE/6q36LQPT0fPK4DkgL
	//uGrkcmTuHdUqdBOsT0YTRUjRNp/Xc8AfURHtCzgNsz5x5LADYQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ay7jnr0j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:15:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BAB0CWD038127;
	Wed, 10 Dec 2025 11:15:22 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxac25h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 11:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMxN9Wm8IOk8+TMhqY0aZXQkF5IyTFCv+hgA4n47wwjJgXUlw9V4vElqBMEM4duisFIRFbxkT7Ez+3KtgD6IccokNeYQbl9dGqwD2YwFP40HksbdMT7g2n0HcX54ODfnFW9V0JmMS9iQx/BjK6vj6irYJCr0qYo1zWF2xTN8UmA+FEOFziBxRuhqUMV5Uyy3BV04NZO9UxYre8pC5kxCeDcgrtkM2FmRIP/jhXW84ztqmKKhkXaiFO+gOj3w29rWEHSjLDZbaOWeTC+vSGkmDVP233QUvlb394dTi228tY16eD7Xc92k12ImHng4Vfee9uMi8VxtLcbqLXt+Ro/aYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf5kjDDGt7oRqBLVg1ZcLdgrEGOuPID/SU767+X+96M=;
 b=vnURlrmVHPmNuK0n32pJR75ogcxjGKLgfop6qkKaNz6mcE9/MFM/iR1z+Nhjlm+OH49ZsljrgExzjGNk6MZbcLeVRKcPst0VmIS3HvuTHqcNbshr2VbYOtmrxwOCJqAYEgUrbU0zYDdPrYfQxyZjJzJoeh1oG/+78qtDv1RJmODYlAd3L35QO1EgVBlXbjceLJ5HAdMZrRGThxM+P9Ir8gLzeTMiZVxco0/Nce+z8IQqAtm1vw+rVs8VuFcxUOt2OxSbj75lBQBz+RUbgLIAL5UNC7RAoENxNLm17LjAGVzsHzAvA82fqw2JKmP+2dBag1FU4J4q2Kok9uIxfxjHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf5kjDDGt7oRqBLVg1ZcLdgrEGOuPID/SU767+X+96M=;
 b=y7hMG+H0tTNAeklyOysS+ufM5Zgj0erLmDgK6qTrxx/caQbqTHeL5em/OQhmzLZEX2a2ddKp3BU/+mwBXRpZQgJUYlwGsRSEeQ2hFWfzoU1x5+UH8muNLJ+zexBeumByEH5zjp0c09HR30kkmXO26rwI48r2MsYGZ6JhaVAf9vE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6561.namprd10.prod.outlook.com (2603:10b6:930:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 11:15:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 11:15:19 +0000
Date: Wed, 10 Dec 2025 11:15:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: david@kernel.org, Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        aneesh.kumar@kernel.org, arnd@arndb.de, harry.yoo@oracle.com,
        jannh@google.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        liushixin2@huawei.com, loberman@redhat.com, muchun.song@linux.dev,
        nadav.amit@gmail.com, npiggin@gmail.com, osalvador@suse.de,
        peterz@infradead.org, pfalcato@suse.de, prakash.sangappa@oracle.com,
        riel@surriel.com, stable@vger.kernel.org, vbabka@suse.cz,
        will@kernel.org, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v1 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
Message-ID: <66418122-5fcc-483c-a7e2-e3a0e6977cb3@lucifer.local>
References: <20251205213558.2980480-2-david@kernel.org>
 <20251208023231.1257-1-ioworker0@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208023231.1257-1-ioworker0@gmail.com>
X-ClientProxiedBy: LO3P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: c209be3d-92a1-4808-dad6-08de37dd6716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?stsiJcyFoM+Vpt3poMo1SXsts6zTH+bZ3qYle7X+vN/dhfEzpHS7b3TLYMDB?=
 =?us-ascii?Q?eJFaHfGpdLiLabVlL8fBlxx0jl29gB602eIqzVjmEco4hHvhQI3IpVariITg?=
 =?us-ascii?Q?YDvKQsLUpknWoFs95kgKT+JTv72mO4Xsi+nEEhuPHV+uGQimxMSzityNvSKC?=
 =?us-ascii?Q?CmY7NhuTXQhuMVzHl2K18LLcgzJAuAu+dPTX8PGsXefs3bVs3djAPS7ltf3A?=
 =?us-ascii?Q?dr/KqDVVNRBwWmCWyHnIe3mGkku5/aZzeWEgBbl2jFvAmMtYgDUYGDSQxJum?=
 =?us-ascii?Q?q9ic/gqmo4NR/mtLCKPC91+rDYjqGy4CwQVxRWK7fCkYu3rNY62fbKrXPXMg?=
 =?us-ascii?Q?KY6/Q6mFns+nKrvTaJ4bSkn2jEnWMyovy0Y6M8s9lMXC3iA5X/q7OSM5jTCU?=
 =?us-ascii?Q?zvsi8KqHUmf859DzT4sIrX41xMSQGROjR6Myuw63OZV5LYvCTXZCwcetEczM?=
 =?us-ascii?Q?SBNOoesX5vZheT1u5q75PS6l9ha7We/2IfT0+hRLdGjEhIcF28AKfkSCrof5?=
 =?us-ascii?Q?EnfBn86Bmz/SUObP3LMzM78B687ptYE30rI37pmasW489rXgmAlqmesHfALd?=
 =?us-ascii?Q?7/0ExhDxkEI6FWC7GVKM2XhUR0FNwVGgLsf6WUkYBkX7tnZAOevE5w9AxdWK?=
 =?us-ascii?Q?Jb9M23lURMIGZtAuGp9KrdqxaKHfyfDs1qR3VskA3CTYL41idehucowiWqeL?=
 =?us-ascii?Q?0AgYj43BScOVZqolPldGYmKOiX1YP0PZCIuAqIV17naweZ7MuE6gxhROZ4Sc?=
 =?us-ascii?Q?vu39ZHA9SdFgR1t1/h5Kv1RqwnyKgwDjB9zMbwF4uScSPHCVmeFkINRmGKUb?=
 =?us-ascii?Q?zKFqn9nlTv7isCcuby7N27iMoILgwoejs826G9jkzaPjzqq+aKomKaw5MFwX?=
 =?us-ascii?Q?O1NMxSKIYr6ppHNjwf+b+Kvme6xTU0guomKpsHj7Ra8ArwpDKVE45dIf5O9u?=
 =?us-ascii?Q?Bki7vVD8jIyPmRm3As9FEuRF5FGJtOsAjJNuXw0d2coX7uc59t9xrZJRmXBJ?=
 =?us-ascii?Q?aZIlNJ3PhdddA0VgpqqmsS7O/0BAxIXzUVZHxBbxwVUx8vJyUgREVYfvj+Rf?=
 =?us-ascii?Q?/r9IN2WLnfa0JQcC1bCS1TFFArHNz1CLFIfFF6KLnQ8nJXp/pqO4rkw0WvSt?=
 =?us-ascii?Q?fvaNpBbecP7AHvQCf64RWLQA+4rabDsbbMB9Wvc12wvesRYy3Qz/NtvByT+F?=
 =?us-ascii?Q?rurdO7+ftrCh8Dk1P6Yg9X9irUcqzTzNvYMjdyXEtyOVJZHyRH8s3d6i8mlI?=
 =?us-ascii?Q?+WcFVKE/jYx8gnGeieNz59AZM0ttiG7OEzpferp22tiJU+hYSKiWziWjHycF?=
 =?us-ascii?Q?EiCBYQrs/z14cIKl0gysMOVvPU3SwIarLmiFOJ+DMvEAj3VWWtVXigGcvDXd?=
 =?us-ascii?Q?HEwAQPoBf3/SsAkZIJ31GY/k1CVWXwJF8WR/8iTKMEKt/24vrSB24in6U1Ka?=
 =?us-ascii?Q?0+/Ru4BRqDdp1gqLNGEPPTctVg5gFmAF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4ulcKG/R7e2LW9Zzw260P9F/gdCmTCtsKGbAeN0fjqsIZTNILjbn0H5xkUg7?=
 =?us-ascii?Q?7bxaRaqr1eF8vIJZviUfd3AwmwnGnTAWppGfKhP5yJmdOrZgzmvTGufQSBek?=
 =?us-ascii?Q?C1PwZNbuuVcmCPHqVCoyT3MzYjnuWMb+w6fHmuaFHNQ44on3p7aNmYfzdsp7?=
 =?us-ascii?Q?4QHPaU9JXMvZE3di2/cciLW65TXzkPBTPxOnUYdzejnjrKLH4m2h06iDz7yn?=
 =?us-ascii?Q?rLWZSiHbpEpCzbbexafS5lAUfYEYce1W8tNQEU/LOq+VKNYlnqjVwprBFyFB?=
 =?us-ascii?Q?xQWmCxzPHL6bEG56Y7MROFMU/40/C6+tKgUgbbzLw021PLkFhS39mJEgsjfB?=
 =?us-ascii?Q?GRevvX3LZR8MKFwTM1ofsXmjKewqzQf0esKWKHis6IO/LnDOFmXw/zFw151K?=
 =?us-ascii?Q?E01umQ2lYaJK9d4EKh3jsTNCx6j2wZngF/qZj2fV45gMCPJIbrMr+T1515in?=
 =?us-ascii?Q?c5r4IIVOWpDu7iPcw2363MSmTFcEBlKAjYsMiHw/6x88i4lsD6tAAESDLiaK?=
 =?us-ascii?Q?uNSA3JxKW88EIzi4xqWPrFiqwmlfVR4v5W8jfLyGlsYC9Ek8bdTBXI2SkBDf?=
 =?us-ascii?Q?ZKkB3HXM+oCR1aGx6oanoMSTy+al8BDuuDgsYYjuuILIgjLqDRlsK/Ao/rRO?=
 =?us-ascii?Q?meK4yBZaeWoi/jqmUsTRUkM0vCXznhe2h7vK32HFQKNp4mZmwbFFL7FtyqmJ?=
 =?us-ascii?Q?59FvUOIR//Txg0Y3LrLHhUqO8FHGZ2w1CXvWKrMxa97iRYm/Q5oKxCVmGZx0?=
 =?us-ascii?Q?IvtIQuXBPZFoLtkEJe2roE81igc065hoClmYzA+DnR/TNJz+Q+EEpJuOU5z8?=
 =?us-ascii?Q?nVdAHOx9LJc9VEUgfiGAOO+eKlQxlq5Gv9rNUjIHDgFFvVFibJ4MAimNNZnb?=
 =?us-ascii?Q?LqzKHj7kU4/c0dqbZzpkOtWdmabUeTs/Agsv2s8d9pYv9UZdT/lfwyx9Sqzp?=
 =?us-ascii?Q?aOTlkfIkaxujv+7miHriZCUqUEXP4Msw5LO5oeWTTQ7HDyfUgz45XikNk/zB?=
 =?us-ascii?Q?NmKIpXVHNOGyNAXQouJv1CeJH4TD+nhiTKHA2kcNdADPaDclPVHywwqtINoJ?=
 =?us-ascii?Q?wPMQesQxgV5U0bw9c66L+ZDnW816azeY/HMsDvmNmE/Yy3xg0A4qB7LbEEKQ?=
 =?us-ascii?Q?E9Js5xpDeHAhHPuwcG6uVqdAw0Lxdk0MwUQudbRK/oDQF9jY01dx6oD9JAfq?=
 =?us-ascii?Q?f12y+l1Eh9V9Fg1v2i7641gC/hOy6swxfBPnwV7OnaBFv2H6duEeEt2/lyIc?=
 =?us-ascii?Q?sUqImvlyAWt0jXRCDn3+b+OU2IQyENjxm1SCWXk91YlYImCl9LHFP0Mzlxsx?=
 =?us-ascii?Q?XnyqSO31xArBEonCMcyVw3Dc8sKbqiMHt/jw0xL7JCPyzXnKHnkGWY7Y3gQJ?=
 =?us-ascii?Q?TnCvkA5IgTGzq77TwN9uwO6C1owIeJ4TrSsKVhv+tdpb+siSwnkFl/X7vvQ/?=
 =?us-ascii?Q?qK6FuFRWjLjhbu+dKKPsgVcRPr7i+mSPjM1X6ljjgtrgZlouyOe05tBfzXkU?=
 =?us-ascii?Q?zdutBq8nD2nkmRa+lF6l150L8eKo+SKXt2bOfpA9VweDCd7gUtji79bnnrU+?=
 =?us-ascii?Q?j/MqrrK27AyCUZFK2y+KDhYp4H7Hx52uMVotUeetQfsEkC6f2ZEEAwd4+gF4?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sy+lwsHq1bEc729Aoq5kYKknFFG0XrPN65teosgUb/kBM5/Kr8UCbsdnIedfnx7Ng4VTQXmFCn/6eCylOIMyThCcU4d27guyUDknhHJx0mPvwKN8q9aIvn+iRiyWTyeUXgPIrbSJdmiPCA9uaRFdj4QaS4Mm9qN59EmFx9mxXB3nF4loCMfv+7MF4fB3DmElGO2Wt9CO7CBcf0Vpk3X6N8led/SX056iCyh1Vrx28i6VahfQJAfOAe4jEyogI/YtxPWwifr4VgeD4zX5C+NnT1hxPB+Ojwula68eqLBIYChMePph+pI2xSLQi/DqMUbKC0f1rXnviFstExodKhhPHBxMDirFypHjDR/FDB9cYocKnKq5O30j3frRMPbykIz9o8nH7h6hhBWOPRzi76oEOZMnFoDkzACARG9ViiN0F5Tttd6hxCDp1Szai2v+LSDiCf+xO3gsj7Uc71NGKskfo6eDzZ9rMKHMeCFGCd3fI0CRGcajri+78M9K+gNZD/Nfuc6mXBH9VkvrmRj5eAbw8g2252RYRqxXX1BaNsDein/5KwetaBf3UUZiPhjYQhg2F96Zmksp1Bz0xt4l728mN3WDnmjzqtua73h15SOEGnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c209be3d-92a1-4808-dad6-08de37dd6716
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 11:15:19.1363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Fj1pOAJdZSiN4eoRXx35vCdR+vIcgcO1jsVd+f8IVjHCEYA1RJub81MbCqRZi9flpskLCQrufZbRr+QzfafugzoHiVnXNmO0qfRRVOv3aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=745 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512100090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA5MCBTYWx0ZWRfXzPNNjGFHbQJi
 28vIsp5UOCdaz9JQWqNXxyNWgqmwsSBdK++We+ClxWGOCOkP0GZWexx6jhoQAxfLXwmzchSYkmn
 j6m2d1if2KiS2Fv/hLU7pj31tGb4QBpsNHXU++4hZO9IeU5idxHEBgwF/r1v6iKofzSm+kRo36R
 Qaav3jkfQ+EZT2D711LQKphhOYbqwdn/f7kGOqDWRtSxNeeeZ74cccNVNJdZSxKpiw2gCTJlqEN
 dQqvm5L5+0pERLZlwEpLscdVRXnaTkvZc9ZxKXC40nPwREPhJIsqtn28Nf6IASXJSQGAYlDNe4c
 TnebwcI+/DJr33ACYJCLYBNY1i0WgBuHackOROakA+cNyZYy1VTdMreYWEchxZ5DyKtFnIqonR6
 vsmDZmdaFMsEEnkgQgc+D/u9pS0NKA==
X-Proofpoint-GUID: uKXvYmolvx3lTMTPoJc5_pKEMikCj8Cn
X-Authority-Analysis: v=2.4 cv=SvidKfO0 c=1 sm=1 tr=0 ts=6939564b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=VzCGGaeLlvMk78a2bswA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: uKXvYmolvx3lTMTPoJc5_pKEMikCj8Cn

On Mon, Dec 08, 2025 at 10:32:31AM +0800, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
>
>
> On Fri,  5 Dec 2025 22:35:55 +0100, David Hildenbrand (Red Hat) wrote:
> > We switched from (wrongly) using the page count to an independent
> > shared count. Now, shared page tables have a refcount of 1 (excluding
> > speculative references) and instead use ptdesc->pt_share_count to
> > identify sharing.
> >
> > We didn't convert hugetlb_pmd_shared(), so right now, we would never
> > detect a shared PMD table as such, because sharing/unsharing no longer
> > touches the refcount of a PMD table.
> >
> > Page migration, like mbind() or migrate_pages() would allow for migrating
> > folios mapped into such shared PMD tables, even though the folios are
> > not exclusive. In smaps we would account them as "private" although they
> > are "shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
> > pagemap interface.
> >
> > Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().
> >
> > Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> > Cc: <stable@vger.kernel.org>
> > Cc: Liu Shixin <liushixin2@huawei.com>
> > Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
> > ---
>
> Tested on x86 with two independent processes sharing a 1GiB hugetlbfs file
> (aligned a 1GiB boundary).
>
> Before the fix, even though PMD sharing worked (pt_share_count=1),
> hugetlb_pmd_shared() returned false because page_count() was still 1,
> causing smaps to report it as "Private" and pagemap to set it
> PM_MMAP_EXCLUSIVE incorrectly :(
>
> After the fix, hugetlb_pmd_shared() correctly detects the sharing, smaps
> reports it as "Shared", and PM_MMAP_EXCLUSIVE is cleared ;)

Yikes yikes yikes...

I wonder what else might be broken in this stuff :/

>
> Tested-by: Lance Yang <lance.yang@linux.dev>
>
> Cheers!
>
> >  include/linux/hugetlb.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 019a1c5281e4e..03c8725efa289 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -1326,7 +1326,7 @@ static inline __init void hugetlb_cma_reserve(int order)
> >  #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
> >  static inline bool hugetlb_pmd_shared(pte_t *pte)
> >  {
> > -	return page_count(virt_to_page(pte)) > 1;
> > +	return ptdesc_pmd_is_shared(virt_to_ptdesc(pte));
> >  }
> >  #else
> >  static inline bool hugetlb_pmd_shared(pte_t *pte)

