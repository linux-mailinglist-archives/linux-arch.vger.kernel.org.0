Return-Path: <linux-arch+bounces-8405-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B99A9215
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 23:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B81B210DD
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 21:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A099C1C9EDA;
	Mon, 21 Oct 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bDGkWKbC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fHU3O3LY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065A10A3E;
	Mon, 21 Oct 2024 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546445; cv=fail; b=eaLM8SNu0ir+PeWZ0124W36JmCBtYAGmUl4qngt/4xd0qLvRjgMOlAgZp4wB44JmNBXrSjt9z0zVY3eYDLprZGnUwj0XILd03h54sTxIbjjOkurlhQJ0rnjgHzzL2UEl+B+rJEQn7kesjmDTfVe/w3NOVfwHEz6ay+d/ue6nj6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546445; c=relaxed/simple;
	bh=16hBEJBI80YtUnRXDJPQdBBsuu8TEJYRRpSWtL6IlQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q/KNM+MWTXy5nxGHekny+2c5wLoypJyYmbspYsMS1id9sbhHWSCE8uDB17rU9LxNj8g+hlT3twd1lQVh+CQZlzaNzcLNEwQFbSXqNKaVwZ14IdcfAx/kxtpGcxbdqPSxxhcWhWuJPqWHkIKeRfXSWXt6fHvy4R0uvzmwv9tucNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bDGkWKbC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fHU3O3LY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKffx5029865;
	Mon, 21 Oct 2024 21:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=16hBEJBI80YtUnRXDJ
	PQdBBsuu8TEJYRRpSWtL6IlQ8=; b=bDGkWKbCXfg0H9/SEeVnWFluOeJWpc3DhT
	Q6MGCPOr4et/x2W89FfSoruMbh7j/MR9BWngRsG9QHonEUIw/odHg9BWpwwsuxsT
	m4uSNx6JiA+4HaUI3UCUCZzsqo9+Jsyo1IknTg9gaSBnekVMTMBYyWDnk65xDXiv
	yWWt4dfLvSpSSVze8L9zCQLznb7aRBkDhd6roZPpfCbGOnibfUGOey3Y0Z8mGeAb
	cPM2gbDHMbAUYl3ZJI4vADiZQ0R7MCC6MRiq0GA3mKd0+Y1iRM7vQlbDImwNHJJW
	odC9a1DRAtpJEhidTZ1Mtf2IhgPXwZM2rC18TdhJxYX//ATzmPMw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c54547x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 21:33:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKUhhG026303;
	Mon, 21 Oct 2024 21:33:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376vpth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 21:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRw7GOnRIVPX3G1xuUMgYw8rlqmy+WVS8k8D0K1Umj9Uw1ILTW8vTS5rSyfyYdxlhoyqwzsQ00j06jW5F02GMax9ihMlKP/Q2tELuzJuAgk/5V5U2By650lAHfZBtYxEoyAyPl8dEXsu1bZ0mgnzS/eWL1sQM8uw/OSgLL77J0SrNPKl+08gA8nyOgtbb3lr/jz4LNzo5uiIN1CfRkUpAPveHBO00GaB+2q1Kkol/yP5zpSY0oJJVSf9hfkOcZsCg/sGfTl4xGRpXDhzT+UG5FBKhNKzAbT4sBmm/GvlX2rhCZxUbSY5vHac5Xi26DCnz58TiXhb9fU1lz65DbHVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16hBEJBI80YtUnRXDJPQdBBsuu8TEJYRRpSWtL6IlQ8=;
 b=X0DS92b5rhy8lYCzNFUYcg7fCGUWefPY+SwNfbBoGYkbgPhe0Itg+kr8sYes0AfeuPugbi8QoDbU7CfvZseD+IWWpuOTvQs/n3/O4vOPo7iMO2eJKvkY8TNshUgC+zu1bzaP/qmzopJNj6E7gzufwaGMBNXqtFvznWJpXiB6/o28Qkz8JHJ89mhq4wGMv66z8XrEaPgywZiuVy38IRU8+ckC+pr6fDiQdCbVsKUE0XTC6ajL9/3kO0Johwp3ET7jtIosjJRVQOTA+rZe1vfBunmKpCrr0OqxtJcVo17Nj0wF0vYIuinRPZsTpmx32R7LLF35M78zakT/2cWwCO1jtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16hBEJBI80YtUnRXDJPQdBBsuu8TEJYRRpSWtL6IlQ8=;
 b=fHU3O3LYdhXc1ZjWXltEcCvwUVvk7Bkty0yuqQrUaG4c8jWFwcZ7qXggU7H6538YhPuJfMcrYZI1VVpAU829TO2KLOWtPNFon3eWowoVeaQZYIdMTTgTNgyBhlC1L025gcJ8uSW9EH7jIftn1cnzXBbNZw412WB1ZS91YFNwc1Q=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ1PR10MB5980.namprd10.prod.outlook.com (2603:10b6:a03:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 21:33:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 21:33:21 +0000
Date: Mon, 21 Oct 2024 22:33:18 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <fb7ab58b-a05f-4d23-8633-e1b3a28f1acd@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
 <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
 <9727ada4-0048-499b-a43f-ac0a625bae5d@redhat.com>
 <73134e10-19eb-4e52-b87f-5fbfd322b575@lucifer.local>
 <0f7a6b69-5706-4010-ba7a-68a071922c80@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7a6b69-5706-4010-ba7a-68a071922c80@redhat.com>
X-ClientProxiedBy: LO4P302CA0035.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ1PR10MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3896b152-9751-48c7-84f5-08dcf217fca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pvEyigKpa49ZRwuBA8m2zuoeo5QstCBjqirmaUSZDfQhZ9xF6MkpF2sZ6GZn?=
 =?us-ascii?Q?na99eQlq38ZqPECWUUieBY3ETMx8sSXKEAzvNejVq6zLwoCG6lhy3z8kXlpH?=
 =?us-ascii?Q?xHpJFrEMIAihv3oaEQx+n1FGj0X9i5tZrX7XjDY17+1lLrSRa/Uzlhom+cHc?=
 =?us-ascii?Q?Ab7AjVBCksAxHBXELkXDRoFtXj3Zq5gh2UEULVbe4+AbVQOsJxFJyIorWO86?=
 =?us-ascii?Q?wIDTQqS9mIpsGs1rhxhwO7JCdw+W0JBUl+HiNz8A48i5uZz6g1OJY3A7+c4S?=
 =?us-ascii?Q?xgleBlN9aHaOwkBv3/QlWGDDQwf8Bgn1a6915evnQI/mK85ohCFKpFwhEzoW?=
 =?us-ascii?Q?bvGMN5aOljC7wkuUAnEiXSl1wPR5nYRlR2hzcvAspOd/Xp+7P9hUu45dq3Tj?=
 =?us-ascii?Q?xR3+KqwClpI6kWfoJyXFtTC9Me3M+r/LfVVwbu6SNqs+4Jis++22XWEH1TMs?=
 =?us-ascii?Q?dYthT3lCAiUgbxuAdcENxHXCcSl/fbCes6M4s22ai8E3DBZaeNvpR/MkT8zj?=
 =?us-ascii?Q?OlV5ZFWg/e5kgbQdRRsuw1RttYccTbzXDLKQrCQxvzt5c3RRXbcRAQ3CKyGM?=
 =?us-ascii?Q?1B4gdqbkZ/adEY+GKGjpqTklTyNkkeJVPH2OVMoApJrvdZOvDp4ONtyTYgZ7?=
 =?us-ascii?Q?SapwqYDhsInJoiVsbZQ2GdyXozKKghSgwGtnD6RzAHDop6zvuUUPQw3BIbm6?=
 =?us-ascii?Q?GfG/kTcz/tV8p+QZrra6lyZNrHqBchLi+zur9VAGX9FO4qOXIspP2hD+EnQp?=
 =?us-ascii?Q?fpZWdklGMh4dMOef9DsH6uoA0XgPJ7nLMzpup5VS9A8smm2QMmVmfIK+wyW5?=
 =?us-ascii?Q?JmpYjH6LQ5uktuNUVNRp886v/pNQbkrQ0ugmq5DlmveNyelY9o9m97w5naIY?=
 =?us-ascii?Q?cyJYe0/AEKg6TFqCjhZkT2YtP/w5gHzx45AfpALxX1xE4crP9BJ06HQhvB5Y?=
 =?us-ascii?Q?xtv+AkSTLguZScDwRWgyqLfz/GZlcqGg9UQsTaHNr8GqyMF7WyKjd9mF+Jjx?=
 =?us-ascii?Q?j9CbJ0PIHQg4kgyLFpr5Awf4SNnvfGLVVWpXUurpnqDo9dd16vmwsm+xf1lt?=
 =?us-ascii?Q?8iAR7i8YccNiCyAUiozTDuivIX3/Xlu1Np74lDq7y36qIqXCxyBEx5nty5Jk?=
 =?us-ascii?Q?m1VjqVE/m5NkPkQeWdEI8+9t10nEeOi3ROQTK+0w4JUv5jhF8bxcotCw004T?=
 =?us-ascii?Q?IDzheau2rgpagk/fqi6DoJNlAPR7q5/UcvvwOLS5HdmPWVCVIxVEkzSiGz4W?=
 =?us-ascii?Q?xK1LslCMYIkxEQHu2pK3PE3y4mp8qbUKWTFA9YVrKDft1fiMd3Fvv00chbFU?=
 =?us-ascii?Q?Rl0oxwIWiI6ysMVbl9C4Jb66?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wUv0hChNgsAJ9gKRBJMifqMrbyKmWc1R/TZm9TI1gttaGUC8F1V1wUEzkdn9?=
 =?us-ascii?Q?xzwOxdqqteerkFhWsKGeqIrqBEARr521fWnGTSuVzGaV2arN4EGZPnAQAIJV?=
 =?us-ascii?Q?22HnEhhgazelH5emMxfp8zJi+LF6dDsbFGopAIpcMIo1jCVAyvCS+PuuLHnI?=
 =?us-ascii?Q?gRsRNo5Um8htNwj/SCbM7aVfjpZW7vbvM8rcBQasEdjwOVtWaLg6xS1+aGVo?=
 =?us-ascii?Q?eqPPkoi5S2lcxagxroKkrzNuvzDUmx36jgABw65t6O4wtEVWBuuZc5azb6J7?=
 =?us-ascii?Q?8CVAUE3mnuLPgW+n/4DYLI6wShEuTTuzfX29uwhus/aCAv8g+yGKuwTwFDvP?=
 =?us-ascii?Q?ycHotzId8k/+HRh8uGyHC6cZN+mnJbRTIJflL7raLib0lNV2D92mPPc1GHY1?=
 =?us-ascii?Q?gfvk+iqpj0Ddd2UwJMS6f8hnS+2RjP2dSjmTl1ZMebis9HoWJLBv0up7q3le?=
 =?us-ascii?Q?9DoSQsyyMyvn0mIrVVDj3K5AdNIrh7/pnkgT8WCzVo+hhYEYLc/EZ0pONrjk?=
 =?us-ascii?Q?370g0IMpIxuMkvP6Zok3nEoTZVZJE/kPhN9l0HRZLgJiXNdez4xthB+S4D4a?=
 =?us-ascii?Q?Wo04jafqOiop7MY0ANVCxH6sZTZUfOyKqMMAFZrt9ifGze8OUkaZ1PD/oLvc?=
 =?us-ascii?Q?h/sWIuSK79KeDHRE0tEnwBDAbxVZlbuBw2NuyVyQ0on4R1PhoRgXLl4F4cfu?=
 =?us-ascii?Q?XeK4FodC6tNuoJYH87xeoyosfbm6rHy2n/fXENdkZ9NM3OOX/mo4TWwys0PX?=
 =?us-ascii?Q?TlEksyTaRFLAad2XCgL1BiNwACi/IDBhpiR0Z594vVgewzVEu+ZwjIgvKLjc?=
 =?us-ascii?Q?5IyO43/VWo2lTDheV3JPo6AJOoyh/HexvHvMwZRXRr+HIPROoQ+LGE4JKK/O?=
 =?us-ascii?Q?FXsCJ8dQ/QrJ5/pSUZlwQ1DI7rlNlofhwpxEWOdAu+3i09M43SPa0756ITdX?=
 =?us-ascii?Q?XY+kFlPUWcOl6eOFUpMaazw4+rphWUCN59FdJincoQpRtDmtnQ6nFwWaybP4?=
 =?us-ascii?Q?korJnvEosjr259mMmFSEY9w6+HDvWUJc090Mj6ytcSU8DBnhZqEuXvWc7bvL?=
 =?us-ascii?Q?TcP8OukMZZoeZVmMrktmZf5ANILaPT7cBvhO8/tOBzjavFWlb/LLaGiEoBPk?=
 =?us-ascii?Q?9xzrYnqzOOuFEL13Rxc/KyMzMhvvu15YuOf0IBLvtM8OkIJqBM5+OEfLtqvi?=
 =?us-ascii?Q?IIoci4ONJ3rK2fx9ZDmKaIXReIcAJYWHjJFpL2/MlvozWLy3MatTL3buPhAt?=
 =?us-ascii?Q?kYb7n/NYwpcMJiaq+GJXu/v1psHcRFfDdC8kn3aa/FhQ3c6QnozcT98BUsm+?=
 =?us-ascii?Q?nG7awe80t5fniMQHNF9FGy3PZJ1w0oJwfU6lI8NqeMStQyF3fXB1wZXHJT5K?=
 =?us-ascii?Q?REDWtfO+WHKIaVPATzfS4/d28FIvS+3OoRTAwkquGIaU8X0dyiAZ7MVH7cGH?=
 =?us-ascii?Q?b/cZX+7Li3vVxI+WEwK4asANPdN9Nfs2GKCEDb6WdR7/vZTYB4ukuYj9xckx?=
 =?us-ascii?Q?CyYysI9MC5hw4/j4gtBGoF2na57Yhg9PDElsr6heU0irWEqS0goSIev+5RbY?=
 =?us-ascii?Q?bq7oIb40msySg9rGtMGqlTxmMAFj3STCPDKG8AnLOIGOl+kqBAcNtpPv7IV3?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tM0wLWaYf9mm0mmdNMwTzejXol1Tuowc/zmBgVWgvXEOul6ebZhVtmXIh0/hP+/893AIZ9LUtDIffjpB7PzhPtOqX3DmG22DlTzhDLqzc5gcnGyiVKLqNKLbAwY6drCQSGckxqrM14LBjGCP7bGNMUyGCy6hgT+TVJWM/USDWwAfFA2SdlKhyuhkHN6lbQ7yjCb94jD3YuIH6NkKDLbVlC6XRj6DaKPpF2Um9LZJI+6Zz0s2pWakIm/hoSJYpaMaTsjVnO6KM+0JhOCkG23mxXZ3YEUmqTkvn6UeclIhtGPZ3YkNWINpetaap4FRDChJeSCcc2Cl7JANM/mUUQQcMA5YFL13ggUe3wkTD3qBZ4dFCg0W5rzDkwjYVO49FILNEWe9B/Tl+nWHHCx2Tu4mBjEE2Oo0k+/Hvt+94eym/Im7u4PhqJUciS26Ke10uxHNCnJqWBJdGcFZt/unjz8DPMrn5TjFvRsXcUR5tKcIPSC87jYe6oAAQmfFwoi5AY5Lz5LES37SqIBXS8LqxQelzbA1PD+Kvs3wGP6kZ430clTgdGbFsSMBGlQklBzbXdIPzZDuXHAOJxNQmJDmy3iPBhwDtPVZ4NtQY8huOa6+JJQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3896b152-9751-48c7-84f5-08dcf217fca3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 21:33:21.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZ2UcjYQthJjzO1EUE5iKpbXpK1yZARi2VWxIorti3d475zzjd++j+7coyJn+poIky39VRjgSjLkekG7QGh8S9ZHqPB2YTTcR5Xm7Nt6V8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_21,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210153
X-Proofpoint-ORIG-GUID: brwaRwW1TKUdq9AjBq1ml_UQXpw0qYhk
X-Proofpoint-GUID: brwaRwW1TKUdq9AjBq1ml_UQXpw0qYhk

On Mon, Oct 21, 2024 at 11:20:03PM +0200, David Hildenbrand wrote:
> > > Yes, I see from Lorenzo's reply that there is apparently some history to
> > > this (maybe it's all nicely summarized in the cover letter / this patch,
> > > have to dig further).
> > >
> > > Not sure yet what the problem is, I would have thought it's all protected by
> > > the PTL, and concurrent faults are user space doing something stupid and
> > > we'd detect it.
> >
> > The looping mechanism is fine for dealing with concurrent faults. There's
> > no actual _race_ due to PTL, it's just that a user could repeatedly
> > populate stuff stupidly in a range that is meant to have poison markers put
> > in.
> >
> > It's not likely and would be kind of an abusive of the interface, and it'd
> > really be a process just hurting itself.
> >
> > In nearly all cases you won't zap at all. The whole point is it's
> > optimistic. In 99.99% of others you zap once...
>
> Exactly! And that's why I am questioning whether the kernel should care
> about that. See below.
>
> >
> > >
> > > Have to do some more reading on this.
> >
> > May I suggest a book on the history of the prodigy?
>
> :D
>
> >
> > >
> > > >
> > > > I'd normally agree with the KIS principle, but..
> > > >
> > > > > We can always implement support for that later if
> > > >
> > > > it would either mean later we change behavior (installing guards on
> > > > non-zapped PTEs would have to be an error now but maybe start working later,
> > > > which is user observable change thus can break somebody)
> > > >
> > > > > really required (leave behavior open when documenting).
> > > >
> > > > and leaving it open when documenting doesn't really mean anything for the
> > > > "we don't break userspace" promise vs what the implementation actually does.
> > >
> > > Not quite I think. You could start return -EEXIST or -EOPNOTSUPP and
> > > document that this can change in the future to succeed if there is
> > > something. User space can sense support.
> >
> > Yeah I mean originally I had a -EAGAIN which was sort of equivalent of this
> > but Jann pointed out you're just shifting work to userland who would loop
> > and repeat.
> >
> > I just don't see why we'd do this.
> >
> > In fact I was looking at the series and thinking 'wow it's actually a
> > really small delta' and being proud but... still not KIS enough apparently
> > ;)
>
> You know, I read a lot of kernel code ... and mfill_atomic_install_pte() is
> what popped in my head: if there is already something, let user space handle
> it, because it is unexpected.
>
> The uffd interface is slightly better, as it gives you the number of
> processed PTEs back, which madvise() is not designed for.
>
> But maybe this (returning how many we already processed) is not required due
> to the nature of guard pages (below).
>
> >
> > >
> > > Something failing that at one point starts working is not really breaking
> > > user space, unless someone really *wants* to fail if there is already
> > > something (e.g., concurrent fault -> bail out instead of hiding it).
> > >
> > > Of course, a more elegant solution would be GUARD_INSTALL vs.
> > > GUARD_FORCE_INSTALL.
> > >
> > > .. but again, there seems to be more history to this.
> >
> > I don't think there's really any value in that. There's just no sensible
> > situation in which a user would care about this I don't think.
>
> Making sure nobody touches an area, and wile doing that somebody already
> touched that area? I guess it could be worked around by
> mprotect(PROT_NONE),madvise(GUARD),mprotect(PROT_READ|PROT_WRITE) ... which
> is not particularly nice :)
>
> >
> > And if you're saying 'hey do MADV_DONTNEED if this fails and keep trying!'
> > then why not just do that in the kernel?
>
> Heh, no!
>
> If user space doesn't expect there to be something, it should *fail*. That's
> likely going to be the majority of use cases for guard pages (happy to be
> told otherwise). No retry.
>
> And if user space expects there to be something it should zap ahead of time
> (which some allocators maybe already do to free up memory after free()) to
> then install the guard. No retry.
>
> There is this case where user space might be unsure. There, it might make
> sense to retry exactly once.
>
> >
> > Trying to explain to a user 'hey this is for installing guard pages but if
> > there's a facing fault it'll fail and that could keep happening and then
> > you'll have to zap and maybe in a loop' just... seems like a bloody awful
> > interface?
>
> Hope my example above made it clearer. This "retry forever until it works"
> use case doesn't quite make sense to me, but I might just be missing
> something important.

It won't be forever in any case other than a process that is abusing itself.

Then it's a security question and... see below!

>
> But again, I have to do more reading on the history of the current approach
> ... and it's fairly late here.

Yes late for me too and I've been working since 8am pretty solid so... :)

>
>
> --
> Cheers,
>
> David / dhildenb
>

So we all agree it's very unlikely, we all agree that even if it happens it'll
happen only once, so what is the problem with the loop exactly? Other than
philosophical?

We do have other loops in the kernel like this... it'd really be the same as the
process throttling itself and whether it loops in userland or kernel land is
kind of immaterial really.

So to me this comes down fundamentally - is this a genuine security/abuse
concern?

Since Jann suggested this, I find it unlikely. But I have pinged him for his
input.

Otherwise I don't know what we're arguing about... and I think we're fine!

