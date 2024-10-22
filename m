Return-Path: <linux-arch+bounces-8429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6AE9AB6FB
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 21:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3212FB24350
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 19:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779831CBEAB;
	Tue, 22 Oct 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DxokXUbA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b9F5MypZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3C1CC141;
	Tue, 22 Oct 2024 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625774; cv=fail; b=ltJt2QOIVSkuR3n+BgWXJiOkNKJyh211m4GFQvYXuQl3fyy24aJ9tTv9QRV5luAVEx75jZ3BcH5eTNBuYwzWAslMaZRK2rbZ0hhdAnC1jQKgE0B1UjpzUGfQ6qb7beK0nW4wjkSP9KQMOpMJ+PTF287UtI5+GcA1vqHXAqfmAxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625774; c=relaxed/simple;
	bh=dVkRTzKhgKOd1DOlmpOZ3W0wdLU0JRnT2hedKCcsJpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LyKGlKC3Vr03q04zj94osqpzXPI/ECs9sXbM3CU/exewhotkmM0LuDj7BlJQ32FOGtH+zr91CR4r0s+8pptVfukc55Y+I+wUYX6J+HCZ0mlKQM9AWu9eGK+zACl6wHFrcTqQFZrHUNmeq0WBBj5rO5ci8jcda/1SfsU/5SOL6AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DxokXUbA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b9F5MypZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MIBber007392;
	Tue, 22 Oct 2024 19:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LRhspz4FEt7ZFBFmGHHSDD87gKMlYYEI4w0orCG8eUk=; b=
	DxokXUbA7ia5h5GDltr54qjPX9w8e2gDfvCsVBKvBZGpB1rpVYXNM3ELk9r0FscE
	o9hyuHk7K0yZ6kMopmROr4oCkjsAo3O57sA/XLgi/kSx+Z0ENnB1inI4Td3vJ19S
	Am55w7nJWjylMrfAUpZnXmEmcovV4JuiyM02yUukZdENIuOGaZ1WJa/spw7egnv4
	bYCqE2pC+gwVL0GpJitarNe17OJkH6G3/zS4OOYQvKKCxekK4hDkJw6nvS83mOle
	T918wZT1mWPDvqmAs56IBW1a33xPpBQ1noWdUTjoceEf5uBDCmOg5E5AfrSYR5CU
	V8Ssr9NJmYC+j5qQmYwAHQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qeh7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 19:35:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MIr3I7020318;
	Tue, 22 Oct 2024 19:35:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37ecu0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 19:35:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0VgyKthaJLN1cBr6bJlgVkLkrBMvs8SXF8VcT2VMq+RzCnPA0OwSJBeCR4NhjiBipp/tPk3aiBz7FSLZLGBuFV6IZJWQahk6jP/nT06XSRnCaP1e7mvTEmWz8zrQNNQoaBAby9UMl8iwyle9XVNyqhjohkZ5fMb8IV1xKOjf4tMdGcol54ePvpGTGxdCbQ1H/41jaix/4QHsUSR9oInW3v7IVUYvZfB7pwctlOzq3OENm4iKYbuj1HLi5bE2frR650reeFcqiEmEuwEkCV2Gl26ueVHdX3fe1dCbvNHZHseBodQRiWjL2CY+KfqK9z42jUjG2lP+L2U/l0W6DR2tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRhspz4FEt7ZFBFmGHHSDD87gKMlYYEI4w0orCG8eUk=;
 b=rYgh2dqjPqw6xd3xYjr5M2VKP0oxsCtxAWMRRmRLJqhdqT6aMze2K86jsIZ+AyeNB14r/FaOOdfdFoEYAwUIXaDMxVH8M9QmI9JmEkAwwZb/uCG9962gWbGUGVDp7CrIlYoVLqfbNmGc1Zk3Mjo5WyPze8xa7+n2KTfi2O18gS2Wesp+9reP5VkOztpSZmpMWQCg7twuA2ej3tAJhGvo/HjvNcP6b7jlMPekvye01x1nzHMslzzWv/1T/qikkR/Uz4105yiwBX/yFSdll01ZGYFCJP+ZlWUbf7YrJsG3tFtpcL9DQJ9L+Fly2EbXx8e3EYs5N3EBaUZVZccrmNWl9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRhspz4FEt7ZFBFmGHHSDD87gKMlYYEI4w0orCG8eUk=;
 b=b9F5MypZVc7BQhxnr2zzDHS3hTp1zxk1/c4FbK/rK5LadpQllLXK4gCP65x5r6LkAwmt6h/e0Kzn0pp2bZ6hwZ4LgUJFefcOVxBVhdD1C+Y0XVYvQMhMvR+4jx/CstZ7STlH0NTKwG48mFQylAHHO7pTE2RuwtMN7Wj5jgV2JEU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB7132.namprd10.prod.outlook.com (2603:10b6:8:ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 19:35:28 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 19:35:28 +0000
Date: Tue, 22 Oct 2024 20:35:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
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
Message-ID: <2647d37b-3482-4fc9-8da2-1158ebdc919e@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <393b0932-1c52-4d59-9466-e5e6184a7daf@lucifer.local>
 <f2448c59-0456-49e8-9676-609629227808@suse.cz>
 <CAG48ez3WS3EH9DuhE1b+7AX3+1=dVtd1M7y_5Ev4Shp2YxiYWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3WS3EH9DuhE1b+7AX3+1=dVtd1M7y_5Ev4Shp2YxiYWg@mail.gmail.com>
X-ClientProxiedBy: LO6P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: a8117f15-0bb6-482b-661f-08dcf2d0aef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWF2cTNzV2x1aE5yL3NNcndYTm9IR2dya3RqWVhkTllmeG5iTnl2YVJhcWFZ?=
 =?utf-8?B?cGRvNGx1akI3TUw3M1lFN3VHSzR4akFBUklvSmFDQmN4M2FIVmFaYlZDMmF3?=
 =?utf-8?B?Q09rdnRsekR0SXFPSnpkaWNlSUVQdEVXY05VVmNtR2xyblJpNHJiLzFnWDZi?=
 =?utf-8?B?NXBJcklaZGNQdG1aR2RDa2JvbDFtT0FvSUFlcVV3SHBDWFdlRkNVRGdUSWQ2?=
 =?utf-8?B?ZWg4anJRWkFJSmNhU2V5bzNIMjF0Z0VpalhlaWdXTDJYVWxLNzBxdUg4djVW?=
 =?utf-8?B?bzMyWlQ0aEtDTWZLdEF4TFVtYmtoWU9yUWpGUmZnS3REUVBaZzk1cVBCZEUv?=
 =?utf-8?B?ci9GbVNSOEIzQ2RwaDhkVjdTNHd0NnAwSGZHQ1NUeEJURCtUYTlHS0l0OVFk?=
 =?utf-8?B?VzNXUWN6U0lMS2JqSzZURk40cFJ2MXZQUEkrcStYandQbFpPZE85SkliN21W?=
 =?utf-8?B?Z1VscHVmelRCSlJQNXdhZGFPZTBIRlBuSHQ1eVRJdC9lRDBROEFKVXVBT2tP?=
 =?utf-8?B?NElHY2dHcjVHdUU3ZkEyR1JMTlRRaFJ4clRiZzltNHVQa1VnL21nYTBGd0d1?=
 =?utf-8?B?MGxoRWMxUXllRGswUUZHa25ubzBTREhoN2pzVFppYmV4d0pZMFhnV0E2cm5k?=
 =?utf-8?B?T1IyRHJyN0NXd0FHamJxVDZWR1o4VDJkaVBBZ2tnRytDTXZnU211Wmo1bEVo?=
 =?utf-8?B?UDdRTTRKMUpUVXdJZXJHTEl3UHBFc0tQc3dKaGoxdHRPWjRZdisyWGo3SmFp?=
 =?utf-8?B?MXNlME9DQkR3ZWVkMHRKb1dmZ3FNaFZ0OHh6RVhRNjNkZm9zODEzSmtQdTJR?=
 =?utf-8?B?Sy9aeHRDeCtVWlVNTnI2eFZKUzIwbWNxU1F5RHowNTRUZ2FUQUloNCtweU1i?=
 =?utf-8?B?QmhtdFJDZW50SmMvTDlneEZaa2FPRTB6VTFHYkV3ejVVM3VucHZJZDNNNEtN?=
 =?utf-8?B?MWh4OWI1QVoxK2RpaFY1Q3piMi8rYm53SVIwTlpWNEI2OHJVdDNmVk56YnFw?=
 =?utf-8?B?bHoyUFUzdjE1dWt4UmdFVXRRMTlCQVBGOS9UUzJmZXp5NlpxNGZ3cXJObXU0?=
 =?utf-8?B?bmFoWmdHSm1hMTRDaVFVNEhhdE9ZRldUeXJGaUZUMW1KRS9YU1k0S0RVYnZL?=
 =?utf-8?B?azI1QWlmaElzekFVbVJxSDVhMlhJQ3M0aW1Fcitoa2FCamg4ajh6ay9NNHU4?=
 =?utf-8?B?L3dwT1YrMTdCcklHVWJ0RUhlUWx4eXVrTmJNUm9na0JZczAxSGpoTElzTEdK?=
 =?utf-8?B?Uy9Vd25qbGtKeDV4Y1luYTc5alVnTFFIaHZTWnh1S3NETlp3STZYV1lrTXdW?=
 =?utf-8?B?ZjlQTmdzMnZpM2lzWVJ0ZTZXeHNyTVIzVkRIeHh1S2JMOWp6eDlaUjZNbWcr?=
 =?utf-8?B?Z2tOc2t0WFNLRHFWTlNzYXdWV212dWF4KzlCYk16MmZ0c0p1ZEhPTFZUMnV3?=
 =?utf-8?B?Z3B3djVNYU14MTl4UTNubDFmTk5lMmVIci9Hd2F3aXcrVWhTZFpIbzFhV3V3?=
 =?utf-8?B?WCtpQStZdUhES29rMU0wNE1WL0UrTjRpZzN3c1FVVFBWSHh5WEdJbTg5RDky?=
 =?utf-8?B?K2xSc2lENGlZS0V1NFZpTFdKNzBWWFg3MkJkRDZQaW44dUNlZDJJaDFKa0E0?=
 =?utf-8?B?VWxwVWJjTGE3eVRkNmVsTnRGTDJQSFBjOWl3cmViSytaV0lZekE3VGNwSXVK?=
 =?utf-8?B?Vm00bmFLR0wrNGRtbkt4Nmk2VVJtVnpJT09SKzE3T2RHQ05mSDJKUm1BRTVG?=
 =?utf-8?Q?AC6fIadEz3h1QQolM+lPSv/mME9IZ/FmCuD0eak?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTZ4VlJiMkF2NjhMVWgrQi81WWMzT2pjRlZRZzlLTElsellNZGx5TTFFRDJG?=
 =?utf-8?B?a3dhdzR0bjZMWkgwMHprcU0xUVlRR0VwcjM4eURaSWROcVNxSW5reVNpc1A0?=
 =?utf-8?B?cGcwS1VSQWlyK0dScGxjNXlMMFNSK3NETkhMbER1U0NXMWhKWnBYaTdlNURQ?=
 =?utf-8?B?bVVBMXdVKzJIZEtiUkIyRklYdytTL1Y1dm5pdU5PUlBxRTUvbWtFeFozVWtZ?=
 =?utf-8?B?N1dKNFptdkl5cG1vazFkSWJYcm4xQi9tN3ZkV1lnRjZYekxVMlRESnZJVzZM?=
 =?utf-8?B?R0tucGx4Z2hTVi9QTkhPWXhsWjlnWTBTZHMzcjVXcTd1aXd1eHZ1cCs2Yk0v?=
 =?utf-8?B?azlwRG82TXBTalFnYlc5L2l2bWJhbW9lSUdVaDZnMEVWa3F1QTAvZndiRE1Z?=
 =?utf-8?B?RWI4eFhDYXRhc1p2R0JmZG5jWFNpWWJwYmdVV29BcW9BSTZNSnltUFpyc01L?=
 =?utf-8?B?dEwrZkJ2b1ZsMGRwakUrRHBFY2dOdFl6cFo1MUVCcEs0QUF2QlNZcFNOS2Vv?=
 =?utf-8?B?cmVkTVRQaDY5YnAvdHZ3WDByeDRhWmRCbWhYUUtqTUg4R2RHSnZWMkYwMm1l?=
 =?utf-8?B?dFhTYXp0UTFCcVA3RnR0OUdDSjZxTExtQW1hSUVGU1VPZW1kUUtIS2lmT1ow?=
 =?utf-8?B?TXVCSjQ1b2t3NFA0RzM2aE1oSUlEamU2T2lYZUlpSEtwSFYyUU1zZDNhQlNj?=
 =?utf-8?B?aGpVNnZ5cHZqSDY5WXVDWmRJTGppdWV5b0lsZlNZL2FxU20xVHJYM0YyNWdm?=
 =?utf-8?B?bjRtNUkwdUYrcUhXY0ZWdHJvcGlyMkNZTFdvd0loNExaaXVtOXFRWURxM3Zk?=
 =?utf-8?B?OVlhMGdkcHRSM1l5bytsL3FyejVNZ1g3WllwOU5uVEk2a255MzJsZHhUN0hu?=
 =?utf-8?B?cmgzZldGTzVqTytqQWRRVXRWd2xpRjloWjJxYXlUZXZRbFVwZHRVdHNjcTlk?=
 =?utf-8?B?SkEwc3MwMU9QUXpzbzNBaFpEVnJvUnJnYXRMUnZWamZNNWdLWDZ1NjgrYTJS?=
 =?utf-8?B?MjhSOFJZUWZ3ZXd3Nnd3aFNDOVlXREM3ZGx0STgxb0l4ZDZsdXhxaTJ6MWJm?=
 =?utf-8?B?ajh3V0tiSmdPUXBWMU9BZFJ5d1dxTEJYaGpBMjdsRW9qcjF0QkFWZEN0VVBC?=
 =?utf-8?B?WEIzRmJ4TmpZWW5sVE82SVVIOUtyaEt2ZFlZN1VUb1dkci9yM3phU0xrcHpp?=
 =?utf-8?B?Uk5lMGpqQWF0VmgrazBuS2hLWGwwV2FaR3JZZ1hJclV3VVhpVjh6ZVNyN1k4?=
 =?utf-8?B?MXNFVVY0NG1aN0VWS25yaSs3VFlIZVBUaEZ5alFLTFBUZERMSFBtR05lcFdM?=
 =?utf-8?B?VytaZ3M5MU1vYTFnNG1jWHo1Y1Z6UThDME1sK0lvZXlDOEgvSzIwYVdwVmw4?=
 =?utf-8?B?K05MVnc4VmIrOWRhN2VOVFRNVnpiT1BZdnpZUlVIQm9GZmFPNlVTeGJUdjhZ?=
 =?utf-8?B?VEFqM1hYdmRMeHNnR1lPbUkzYXJhSmVVWXpRdUdnT1JoS05mbUxCYVl0TEFS?=
 =?utf-8?B?V3RBOHNYN2dsaGViOUxOTzI3by9Eb1JDZkRKYTJBdERjenF0VWNzc0FaYzB6?=
 =?utf-8?B?eWxqYXNOMWsrZERTMXgrc1JDSTVaSHdHaVR1QjBqOEN1Tk00dWU5dXgrSjBV?=
 =?utf-8?B?cU1YMzdGNGpyeTNtd1hpK1IrRitoNDBBN0ZSdjV6bzFtcCtCYlh5WnlKNVpx?=
 =?utf-8?B?RGIxUCthc3plMUJaNUZFWVNnZGpwcXVLeEpFTGd0bEk4cTM3Yzc1NHhFNEFF?=
 =?utf-8?B?d0lBYUZtZWE3M25GV2RiWS9RRFlCd0ExcTBzbkNhMVppOUVLR2xyQ3JnOVY1?=
 =?utf-8?B?S2V5MzhCWWxVWmg3d2NMTEJZWSsycmRLZUJOdVVLUFBVeGxOQ1VJS1NVSFdN?=
 =?utf-8?B?U05HbmZuWW8rM3dFM0I0bGJMMXhSekczUWFjV2Y0cHd3QXN6VDUvYkx6SWla?=
 =?utf-8?B?MHREOEMzUzByLzVqaEFzUjBGTlU5MWJFMTVJQXZaQ1VtZTNjREppUURhbnIz?=
 =?utf-8?B?R3VMZmczQytJajY5TENLS0ZSVHlQV2lXbXpKNlBCYmhnT1FLTDhvcUNzeWtU?=
 =?utf-8?B?ZFhJbjFCZmc1QVorTXhneHErL2ozdDA1V2Q1TUpocUhUQ0JvM21FaFFwa3kw?=
 =?utf-8?B?YmdyQ3lQZFcycklZWXVkWnUxeDJLQjFGakRUMHcvbFFWTDdEaE9RQVBvWFBL?=
 =?utf-8?B?L0JrRFU5NnhnSlFpdzFoUjM4UTlqZGFKK2xqTmMrRFJ3T2pqMldwelIzaWk0?=
 =?utf-8?B?Q2tHYzllNkFGQWpVQUo5Z2lUa0dRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/heGu2F2pYhFreba6hBfvNRUrQFUz76WJpld5CiPDc07PCzpTlfXwvczyQXO3NM3cidgqGIZPOnxtbOhHQubouX8Xfxn7batLsMTkp0ZbIH23EtqgbLTX0eXwYpnD5EteqAErhVdzk+gDOo8Mt43nMAql4xxQoMblRmJSfu02m6BSaf4SuNsbC5wgWkYai5xaq3a+yZjzxVlzXALNrWtVr3WGoE+P3gZtT4EjwU4bVtgQQbwMrCNl+Bh7vnKPa9E69UVgCFd+gcDl1qXrg0R69cPWJMqh5oscmkZMAIjBW14t1E71iFpL5K7T5SqQeadiAKHkxhDiX0tHkfIu2ugPo5wI2MHflzTGKejGpVeqzNCXg0tMGXy9glMkR0H2xcbdd0/rdM/pXzbrTqqeKXBLTKtLDKuekp+xS4fI4twzXi3reIRK+xo5NX7b0/GM/2QI7kdoEj9PV9wClHu790wMq6bacatXsZeyL0kPxdarAIqOSpASunLg1aNO2oP47bLWXEqCq79nvr8guWQPIB8smbkq8Rtkj31M4rR26hISkjXxb+GDMjxSGHkUJTMQOZ214XnW3paFDgwK+cwzvLnw2npOGedpsxKtvXfFhTSGCs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8117f15-0bb6-482b-661f-08dcf2d0aef6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:35:28.6797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AWqFgIsprBX3+Tt+5bAd+06TngKOwqcyZZvBTmpRQlsMP6Dstu99WlqpgHzPREOAhACHh0eq/C/pVUr+CFvgvQGhDg+zZTWFBp/vyhxLy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7132
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_20,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=393 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220126
X-Proofpoint-ORIG-GUID: Xw5pFBZG4jjme-mu0dc4LvUyfkS6dSzt
X-Proofpoint-GUID: Xw5pFBZG4jjme-mu0dc4LvUyfkS6dSzt

On Tue, Oct 22, 2024 at 09:08:53PM +0200, Jann Horn wrote:
> On Mon, Oct 21, 2024 at 10:46 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > On 10/21/24 22:27, Lorenzo Stoakes wrote:
> > > On Mon, Oct 21, 2024 at 10:11:29PM +0200, Vlastimil Babka wrote:
> > >> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > >> > +  while (true) {
> > >> > +          /* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> > >> > +          err = walk_page_range_mm(vma->vm_mm, start, end,
> > >> > +                                   &guard_poison_walk_ops, NULL);
> > >> > +          if (err <= 0)
> > >> > +                  return err;
> > >> > +
> > >> > +          /*
> > >> > +           * OK some of the range have non-guard pages mapped, zap
> > >> > +           * them. This leaves existing guard pages in place.
> > >> > +           */
> > >> > +          zap_page_range_single(vma, start, end - start, NULL);
> > >>
> > >> ... however the potentially endless loop doesn't seem great. Could a
> > >> malicious program keep refaulting the range (ignoring any segfaults if it
> > >> loses a race) with one thread while failing to make progress here with
> > >> another thread? Is that ok because it would only punish itself?
> > >
> > > Sigh. Again, I don't think you've read the previous series have you? Or
> > > even the changelog... I added this as Jann asked for it. Originally we'd
> > > -EAGAIN if we got raced. See the discussion over in v1 for details.
> > >
> > > I did it that way specifically to avoid such things, but Jann didn't appear
> > > to think it was a problem.
> >
> > If Jann is fine with this then it must be secure enough.
>
> My thinking there was:
>
> We can legitimately race with adjacent faults populating the area
> we're operating on with THP pages; as long as the zapping and
> poison-marker-setting are separate, *someone* will have to do the
> retry. Either we do it in the kernel, or we tell userspace to handle
> it, but having the kernel take care of it is preferable because it
> makes the stable UAPI less messy.
>
> One easy way to do it in the kernel would be to return -ERESTARTNOINTR
> after the zap_page_range_single() instead of jumping back up, which in
> terms of locking and signal handling and such would be equivalent to
> looping in userspace (because really that's what -ERESTARTNOINTR does
> - it returns out to userspace and moves the instruction pointer back
> to restart the syscall). Though if we do that immediately, it might
> make MADV_POISON unnecessarily slow, so we should probably retry once
> before doing that. The other easy way is to just loop here.

Yes we should definitely retry probably a few times to cover the rare
situation of a THP race as you describe under non-abusive circumstances.

>
> The cond_resched() and pending fatal signal check mean that (except on
> CONFIG_PREEMPT_NONE) the only differences between the current
> implementation and looping in userspace are that we don't handle
> non-fatal signals in between iterations and that we keep hogging the
> mmap_lock in read mode. We do already have a bunch of codepaths that
> retry on concurrent page table changes, like when zap_pte_range()
> encounters a pte_offset_map_lock() failure; though I guess the
> difference is that the retry on those is just a couple instructions,
> which would be harder to race consistently, while here we redo walks
> across the entire range, which should be fairly easy to race
> repeatedly.
>
> So I guess you have a point that this might be the easiest way to
> stall other tasks that are trying to take mmap_lock for an extended
> amount of time, I did not fully consider that... and then I guess you
> could use that to slow down usercopy fault handling (once the lock
> switches to handoff mode because of a stalled writer?) or slow down
> other processes trying to read /proc/$pid/cmdline?

Hm does that need a write lock?

>
> You can already indefinitely hog the mmap_lock with FUSE, though that
> requires that you can mount a FUSE filesystem (which you wouldn't be
> able in reasonably sandboxed code) and that you can find something
> like a pin_user_pages() call that can't drop the mmap lock in between,
> and there aren't actually that many of those...
>
> So I guess you have a point and the -ERESTARTNOINTR approach would be
> a little bit nicer, as long as it's easy to implement.

I can go ahead and do it that way if nobody objects, with a few loops
before we do it... which hopefully covers off all the concerns?

Thanks

