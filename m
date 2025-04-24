Return-Path: <linux-arch+bounces-11520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52769A99FA3
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 05:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44BB619453F6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 03:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4AA199396;
	Thu, 24 Apr 2025 03:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ssLe/xVT"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40A4502A;
	Thu, 24 Apr 2025 03:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465860; cv=fail; b=ntd9JJo9Yk+BRcXueUAzQGzBMRLHIBacqLmD9gZLcY283vJYbOFI6t3x2QcbAhhj/gQU21jqcveLV/lbaUXuTVF5Wy5vzm+RcO+W/I5LtjYGnO6mHxXd/apQLwreEWhm5rGhjCbwTzLacnZ+tZMFo0EPDSqLJ3oyazwm1OQMkPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465860; c=relaxed/simple;
	bh=F0gkAS0hlbm35xWhTYzOvzGkP5q8sPW2FcZ1rf5HVZw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oonX34Naqd9A4t7DgJKoy7ouHUXEufnDniikxcXaZKprUKMYFzM3OftnvpL9j6mLQuFDdeVjlz+HXRDiomJx0ptH0jggl1kIfNeIF0ETLpGcIUTloCyqB9hEOejttcpFihkB8jOUYgilgCzbn0SV77X5UZmZsV5CyLdLGVIjkC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ssLe/xVT; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQXf5pcAsIxMHKFVhVMg2usSRpe+hzuZFutpvbJBBCYnt6fYPM54ppqRZJmsIbE81bakeUcjHrQgvNzVK70rWIjgtTpz2tcO2P6nT+Qq0mQsb5atZajZoPyVvnmze5ppYCZrG9UdDFpPwtMiAZdxGN+0r0L6CyiCIMOcKxnawqRHw8SVeFLI5ac99STGnPINFOmNGAU+ObKTftuserIyTCKZMSVolyg0kSoRSL2lkGFFT04a1H4dZwZTvfo7J3HO3Ij/JIQ1uxqv2vMFu9hbB9wG+EkenCI51+K6wuxGrhpMQG6ptOBSPqwGK1znFqaii4clrdFh37Dg+x4FbudtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/LdKyb0k/siQ2qNx1AgeVi9zGbH35gno8OppO/yzw4=;
 b=J2SWs5NCjSYemHLW5LlOEU3kUmXS6SSw2QMzsk6LXmu8hokgKdXygx/ftKuSRQISYwItZxvo0v4wF/Hpoip7bWJk1jmKpwsEDRPC/vk/CKwm9lGXGII8BnozNl1eyQwWruhNiY3C7B7I0I0KPJZheKovMgkXlLWQCJ+xq42ZBlRCjfwnGMsfJ3f2gYYrnvUzTfUsAUT9i7Y5nQuErRqvtTqWGIoYR+o8NvCfLnsAcv1wojbv7U4aWnVM0g5kEINQ764vIXqyL45Pytc8ere/k+8dvEIjJ/BfGYF2cx8NBshQ0YaM/tgfDguGduRpxoFoxPjiIk/psmW0g47GlIFEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/LdKyb0k/siQ2qNx1AgeVi9zGbH35gno8OppO/yzw4=;
 b=ssLe/xVTDeqEhVt9QTahFgpDcpyYqRFFaZyfjxfbMdMLYzx+e0h+8zD9rH6pPXk4bTwo2p8HFVsJBeMBzbC1QFAcMy6nso1xKwE/9HPDmjan1tBwyoYK+/RCqf7jg04ESxnNxIawLU7MLEd6wpUZEVkPPfqYng38p1r1X2Od5T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:37:35 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 03:37:34 +0000
Message-ID: <6e51e434-42c3-4af3-ba53-9b35a64d3dbe@amd.com>
Date: Thu, 24 Apr 2025 13:37:20 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 06/22] KVM: X86: Define tsm_get_vmid
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, x86@kernel.org
Cc: kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Michael Roth <michael.roth@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Joao Martins <joao.m.martins@oracle.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, Zhi Wang
 <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-7-aik@amd.com>
 <67d23a3e6667_201f0294ed@dwillia2-xfh.jf.intel.com.notmuch>
 <7719c1ad-84b8-40e2-9ce7-93248a410ebd@amd.com>
 <67d32d60bf4f4_1198729418@dwillia2-xfh.jf.intel.com.notmuch>
 <844aca18-6d75-4a75-801a-09ae12d1f512@amd.com>
In-Reply-To: <844aca18-6d75-4a75-801a-09ae12d1f512@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME2PR01CA0031.ausprd01.prod.outlook.com
 (2603:10c6:201:14::19) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb5f807-f3de-4a38-908e-08dd82e159a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFY2NXlKU25CNzNkemZnQzZ3UUt0UTlEc1F5NWMwbnBaRHllSnpQREpsMWM0?=
 =?utf-8?B?V2ltYllRQmgrWnkyZjlEODRPZHFlMmJ5cFFQdG04VVJHbm5SOXhzbkU0RUNn?=
 =?utf-8?B?WnZlK1RCcjZ2S0dvaWF1bVZsWWh3UHF0WHJGN25iTzVhcGlrOEkvOEdIM0pw?=
 =?utf-8?B?THFyYnhnVmpYZDc5Q3FQMUZmSFlKUnNHOG0rZ29JOE9CWTVocmU2bGpBQ0pR?=
 =?utf-8?B?cG5qeHlqMlJhVmpobUd6MENUM2dXNU5nYVYyU05sdUg2YUhNSFYreUJScjdO?=
 =?utf-8?B?ZVkrZUZXUFFvQXd1cVdlQUNtK0I1NUEwbnNPanlReGpkVlVwNWtnVE5YUkxj?=
 =?utf-8?B?N1ZWNHp3NXlFQ1k4WGI5Sm5xTnE5cXNSS2JMSVI5YUZLRWNSeDZsTlFiYjkz?=
 =?utf-8?B?MHkvdkZOSEE2ZFpGWFJpTEhpQ04wb3JDcEZRQnFoQ25iSzZXak9EazU3bkxw?=
 =?utf-8?B?MDA4ZzFBR1c3YTJpVjdXazhTUnhBWFlKbUYzNjNCRzZQVSs3eVU3WGNXY0tB?=
 =?utf-8?B?WmJNbDZUZW9NTWFlTUwyc054YnZ3RHAzV1N0cTBOU0IzNGpOa2w4bEtWQmJn?=
 =?utf-8?B?SDhHOCs0QXZUbnovTyt5WHJobHFyOWJ6a0l6cXlPWEpPb0VrRnVJK0JVWjlK?=
 =?utf-8?B?RGtsekx1WjFMV0FZM2RPMnE2cGtOZHJRUDdIMFNneUhhRXVLWFl1TW51endv?=
 =?utf-8?B?VWxqRXZ2VElZZlorcWlzamE0bk4xMjFMU1lMZVIyaXdiaDUyTmZFNkhMOVlt?=
 =?utf-8?B?VGhib09oaHV0WGRIVmMrcVMxR1I3eWpGSHBqM001UWwwM1ZwM2hZN1QyN0pU?=
 =?utf-8?B?aC9renVuc2NUYTdHVEtxaW5lOHQ2dWJLU1JXeXhwYXR6ZERWZ21YbmpJS2xZ?=
 =?utf-8?B?ekV2Znc4VWJhNE5CUUZweGo2RGErQWs5QWNhNkdtWjVENDF2RzZCMHkzQWdM?=
 =?utf-8?B?SU1ISkcxZkJFeUFlb21ZQngvU1I2REd6NE5LbE5HbjQ0Y3RJZWsvak94S2tY?=
 =?utf-8?B?b2NEa0ZsWjVYcVh3MnJQUUhuMEl1M1RzOUtPd25iclhkR0VBV1VyWklVTXYv?=
 =?utf-8?B?MnFoNUorYStGZEd4OEcxOXZLbW1KMFpGVjFURWRSd05Ba0RDV0haT3RyNFFM?=
 =?utf-8?B?WmJGR3djVklodi9Ga0FEQVMvQ2VlcDZFQ01QeGVkaVAwNnRFLzBtVmloRU1z?=
 =?utf-8?B?VGRzMHc3QnFEL0FyTFo4SXpEa25iTGpUQUpxOGZpUXVKZUl5SUl4cFRhMVFI?=
 =?utf-8?B?RkFiQTN3TVRWQUV1WXNTQ1Z5bjcwQ0lIZ0FoU3p4V3BxZDVTTmkwQ3JhaXBi?=
 =?utf-8?B?WThaczRrUnRERGJaNWZ3OUJoeTdvbkZGalVpblIxN3gvT0YyTFo2VlBFanE5?=
 =?utf-8?B?QnMzd3dWazFMRHF3S2l1cXNNYVFqRVh2bTkrVzVKSm90dXExQnNxWFh5T3N2?=
 =?utf-8?B?QjNIdGJBTWdGemQwa2dieFZweXhKcy94WUJjTmJxd2tBWWVuTmhmVE9hOUNP?=
 =?utf-8?B?Q2U5L2JNSmxmWitQZFlJaEZIVDRuQkdrT2Q2cFo2WW5IaWx6TGlyMVJwU1gy?=
 =?utf-8?B?VmtZWDRQdG5SbHI0bGRpNHN5ZXlldUxYTzNNNk5NNlgwdlJ0U2x6eTM0TFJj?=
 =?utf-8?B?a3ZkN1k5bVlmNk4zUllCKzhsWk9DajBjQ0lsUlJoSFo3Q3IwVXoxUGlxUFNM?=
 =?utf-8?B?cWV4cGpLQmVtMnF6SHNWMU9zK0h6MkVhMWFrVjgrdStzdUhnYlE3eWpwYTBS?=
 =?utf-8?B?Z0hFREF5Rm1hRmJnL1J6dXFSYXZqa2dBd1VFUnd4Y2V0Y2ZRVy9Ga3NqcFRV?=
 =?utf-8?B?Sk1heU1wOVBJWmp1a0NJYXNKbDdQUWRKWW1MeTNsWDdGZEJTczk1OERjaVJJ?=
 =?utf-8?B?aXB5cWpLK3ZWUitFdlJ4RW5qbE42VTFqMGFPb0FWbkpVeHFMT1RQVjlIMDdz?=
 =?utf-8?Q?InnYNEqU3uM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUVRMERsdGdITTYvODRrUFh3ZXNXbElUTW9oQTN0aGFYbGxLRVYxbXEzMTJW?=
 =?utf-8?B?SEROdUlFR1NaZitTeGJmRHA0L1BuR0wwQU1iNjdiZ0Q4Z2llckRlbTZUcWor?=
 =?utf-8?B?dUZHVHI0QXVJQzBua2lyR292VldHLzRBcEM1bW5rbnc0bjVaTUZMcWtCMGhG?=
 =?utf-8?B?M0hOYTczb2RpV3loa2t3VmJiSkcyVDRTeGdwRGJ6NTBNazEvK2JHZVl6SE5L?=
 =?utf-8?B?aHRuMktMcFRXdmVmZUdVTi91M2VzOGxTbWRCUWQ1aG5SVTE2cjFzVENjNTla?=
 =?utf-8?B?V2RNYm8yOEtxeXNZNCtrQ3IyU1ZjZmlFUkZrY3kwMU1Rc1V3TWdKQ1Z0aWNF?=
 =?utf-8?B?dlZUdng2QlR2b3ZnWFJsbW5TOHRBZzdqbkRPSlNMYXpjUk91Q2p2NUZWcTZ6?=
 =?utf-8?B?cktRNFlWb1RrWjk1bE40OHN4RXh5YVlEci9KZWJJbFBPM0EreEJ3WmJaQjBq?=
 =?utf-8?B?MFFBcmlBL1VoZXpIaTVCUlFPOVFTMFJ1MC8zU3MyQS9EU0F2Z0RJd08vSzNy?=
 =?utf-8?B?ZTZpRmgwZ0RKZzBlLzlWalJuRUY1Vk93b2ZvUFJXWWp2RURvQm9LcXhMSkhi?=
 =?utf-8?B?TEZEMFRUdzBkbW16T1dVVzFSdkNBWnlhcWlqSTZqRXMyODZnaVJxTy9yQkts?=
 =?utf-8?B?M0R2TDRoR2JKNGR6MmRFd09JcWNMNEVKTDc4ZEp1UUVnekhtQlhLdTZFTGtt?=
 =?utf-8?B?Q1NEeVUrU3QwbzBzRFpLSFAzT05hdHNQRlVEb3FidUNEcGp1S0kzTDdZZGlO?=
 =?utf-8?B?cVNaMjZPWmdwa24zTnF0cHNjUGtvNVRUUDlYMVJ1UWdLYk0yQjd1emFPd0l6?=
 =?utf-8?B?Mk5rTEtUSktIcU5zNi9qUklsRkM1TFJYbUtMemZHbE0ycWhUbWsrTXozdnZs?=
 =?utf-8?B?MjFwZ3c3VDZmOW9pdGNkWk1LMGJvckh1WVFWQ3BEam0rQmFCOTVVZGJ5WUU2?=
 =?utf-8?B?ZnVXZmFtcy90bXk3VXRqZjBLemE5M0dPcVIvVEN5Q0dndUNjcVFuQ2EzdEpi?=
 =?utf-8?B?RVVzM1pkcjg3bzNtTkQ2enkxUGN6ZTludEtoTEh5dERpTTl4dmcyYlcwajZO?=
 =?utf-8?B?VUxIN0drVlZVR0pXMmJtZTgwRmppeURBZ2JBVEx0ZDZhN2UvNWdNb29zT1pk?=
 =?utf-8?B?RWlCbDZCMkFxVGpKd0JvejAvTUFNRG9MbVhISnh4MFF4NjFad29jdzRHN290?=
 =?utf-8?B?YkxaZGpPNkNZSnNuMjByT1JlTGZwRHc2ZDlISUNEd3JrTEsrMGFpdFcrY1Jq?=
 =?utf-8?B?SUZvT2NvMThISGNIZ1V0cHhKNkhvWkE2aHNqWlRpa3hsWmNEQ3p5NUp3d2pY?=
 =?utf-8?B?c3N5R2ZzMHhkOU1PdGF6WTZFOU93dnNndUxPMWx5b3FiaHhXTWR1Ukd3Nlpy?=
 =?utf-8?B?ekdNbUY2TGswKy95dHlJZEE5aGJsckovZHFvcDl4QzcxZzB0ZWxMeGR5TzZK?=
 =?utf-8?B?emUxQ3F5UUFiNmE2MGc2WG1kNmNuMW95cm1JbHNhSnVmRnJLRi9keUx1U3Za?=
 =?utf-8?B?UU1YK3VzVWpaWmJUdmhORGZ0L1dHNCtFNHRMK2Z5aWxzMzNjRW90dGJtWkZv?=
 =?utf-8?B?MnZrbTBrbEhPdDV2MGtqLzJFNWl1eGJQbUxheGhaa3pmR09hU0tXakQ4Yzcv?=
 =?utf-8?B?cy90WmkyaGw4N1NZL1JHcEROdlcrYTkvbjFhOHVobjZrNEYyYXB3UmtiZTJT?=
 =?utf-8?B?Z2xkZTJORkd4VHZ0aytSSzZJY282RHVxWEd5WlVLZnk3bTJWTUZoaS9NY2Na?=
 =?utf-8?B?RFdBY1NpNVVvRTYzMzdteFlCdGFXUEhDbmNkVUdtWDc5YlJReWZSOXE3VWl5?=
 =?utf-8?B?aWJkWk9KVXQ3aWRBUWc0dmt5UTdYaDQxNDY0VS9QaUdndi8vTFhrOVJ3YXI0?=
 =?utf-8?B?Vmp4Vk1QL1QrWDdvLzJPeDdzOEd6d2d1aDZGSDhXQUlKYVJ4NFdqVnhkQjhk?=
 =?utf-8?B?c3duQkNrV2N5ZHhIUmxRV04yTjB1ejRCZzdQWXFtUWd3NXJxdFFTNGowVkc4?=
 =?utf-8?B?cUN5QTlHYlhSOHpmdVBNWE1zbG51L0tyRDdTSmdKRElNR09hd09nYSs3UWk2?=
 =?utf-8?B?SFNkNVhDVUVTa3p1cEc1c3RBRzFXcm1aTFl0Z3dYZXJoTkRHb201UFlneUMx?=
 =?utf-8?Q?fQDFcGWejqhxyw7fpn8oQrYV1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb5f807-f3de-4a38-908e-08dd82e159a5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 03:37:34.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lrwEC1udEYnkBKryMe4sMjL4F7lcCUmlfh2tltGDD2mzx3bBrO4HIp/A7EhwOeqfIKDd1uTqMGguQ0Vqqlqug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062



On 14/3/25 14:28, Alexey Kardashevskiy wrote:
> 
> 
> On 14/3/25 06:09, Dan Williams wrote:
>> Alexey Kardashevskiy wrote:
>>>
>>>
>>> On 13/3/25 12:51, Dan Williams wrote:
>>>> Alexey Kardashevskiy wrote:
>>>>> In order to add a PCI VF into a secure VM, the TSM module needs to
>>>>> perform a "TDI bind" operation. The secure module ("PSP" for AMD)
>>>>> reuqires a VM id to associate with a VM and KVM has it. Since
>>>>> KVM cannot directly bind a TDI (as it does not have all necesessary
>>>>> data such as host/guest PCI BDFn). QEMU and IOMMUFD do know the BDFns
>>>>> but they do not have a VM id recognisable by the PSP.
>>>>>
>>>>> Add get_vmid() hook to KVM. Implement it for AMD SEV to return a sum
>>>>> of GCTX (a private page describing secure VM context) and ASID
>>>>> (required on unbind for IOMMU unfencing, when needed).
>>>>>
>>>>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>>>>> ---
>>>>>    arch/x86/include/asm/kvm-x86-ops.h |  1 +
>>>>>    arch/x86/include/asm/kvm_host.h    |  2 ++
>>>>>    include/linux/kvm_host.h           |  2 ++
>>>>>    arch/x86/kvm/svm/svm.c             | 12 ++++++++++++
>>>>>    virt/kvm/kvm_main.c                |  6 ++++++
>>>>>    5 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
>>>>> index c35550581da0..63102a224cd7 100644
>>>>> --- a/arch/x86/include/asm/kvm-x86-ops.h
>>>>> +++ b/arch/x86/include/asm/kvm-x86-ops.h
>>>>> @@ -144,6 +144,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>>>>>    KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>>>>>    KVM_X86_OP_OPTIONAL_RET0(private_max_mapping_level)
>>>>>    KVM_X86_OP_OPTIONAL(gmem_invalidate)
>>>>> +KVM_X86_OP_OPTIONAL(tsm_get_vmid)
>>>>>    #undef KVM_X86_OP
>>>>>    #undef KVM_X86_OP_OPTIONAL
>>>>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>>>>> index b15cde0a9b5c..9330e8d4d29d 100644
>>>>> --- a/arch/x86/include/asm/kvm_host.h
>>>>> +++ b/arch/x86/include/asm/kvm_host.h
>>>>> @@ -1875,6 +1875,8 @@ struct kvm_x86_ops {
>>>>>        int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>>>>>        void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>>>>>        int (*private_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
>>>>> +
>>>>> +    u64 (*tsm_get_vmid)(struct kvm *kvm);
>>>>>    };
>>>>>    struct kvm_x86_nested_ops {
>>>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>>>> index f34f4cfaa513..6cd351edb956 100644
>>>>> --- a/include/linux/kvm_host.h
>>>>> +++ b/include/linux/kvm_host.h
>>>>> @@ -2571,4 +2571,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>>>>>                        struct kvm_pre_fault_memory *range);
>>>>>    #endif
>>>>> +u64 kvm_arch_tsm_get_vmid(struct kvm *kvm);
>>>>> +
>>>>>    #endif
>>>>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>>>>> index 7640a84e554a..0276d60c61d6 100644
>>>>> --- a/arch/x86/kvm/svm/svm.c
>>>>> +++ b/arch/x86/kvm/svm/svm.c
>>>>> @@ -4998,6 +4998,16 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
>>>>>        return page_address(page);
>>>>>    }
>>>>> +static u64 svm_tsm_get_vmid(struct kvm *kvm)
>>>>> +{
>>>>> +    struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>>>>> +
>>>>> +    if (!sev->es_active)
>>>>> +        return 0;
>>>>> +
>>>>> +    return ((u64) sev->snp_context) | sev->asid;
>>>>> +}
>>>>> +
>>>>
>>>> Curious why KVM needs to be bothered by a new kvm_arch_tsm_get_vmid()
>>>> and a vendor specific cookie "vmid" concept. In other words KVM never
>>>> calls kvm_arch_tsm_get_vmid(), like other kvm_arch_*() support calls.
>>>>
>>>> Is this due to a restriction that something like tsm_tdi_bind() is
>>>> disallowed from doing to_kvm_svm() on an opaque @kvm pointer? Or
>>>> otherwise asking an arch/x86/kvm/svm/svm.c to do the same?
>>>
>>> I saw someone already doing some sort of VMID thing
>>
>> Reference?
> 
> Cannot find it now, RiscV and ARM have this concept but internally and it probably should stay this way.
> 
>>> and thought it is a good way of not spilling KVM details outside KVM.
>>
>> ...but it is not a KVM detail. It is an arch specific TSM cookie derived
>> from arch specific data that wraps 'struct kvm'. Now if the rationale is
>> some least privelege concern about what code can have a container_of()
>> relationship with an opaque 'struct kvm *' pointer, let's have that
>> discussion.  As it stands nothing in KVM cares about
>> kvm_arch_tsm_get_vmid(), and I expect 'vmid' does not cover all the ways
>> in which modular TSM drivers may interact with arch/.../kvm/ code.
>>
>> For example TDX Connect needs to share some data from 'struct kvm_tdx',
>> and it does that with an export from arch/x86/kvm/vmx/tdx.c, not an
>> indirection through virt/kvm/kvm_main.c.
> 
> a) KVM-AMD uses CCP's exports now, and if I add exports to KVM-AMD for CCP - it is cross-reference so I'll need what, KVM-AMD-TIO module, to untangle this?
> 
> b) I could include arch/x86/kvm/svm/svm.h in drivers/crypto/ccp/ which is... meh?

> 
> c) Or move parts of struct kvm_sev_info/kvm_svm from arch/x86/kvm/svm/svm.h to arch/x86/include/asm/svm.h and do some trick to get kvm_sev_info from struct kvm.


Thanks for the suggestion, I ended up doing this and ditched the whole tsm_get_vmid() thing, looks semi-acceptable (at least contained to the AMD code) to keep going. Thanks,



> 
> d) In my RFC v1, I simply called tsm_tdi_bind() from KVM-AMD with this cookie but that assumed KVM knowledge of PCI which I dropped in this RFC so the bind request travels via QEMU between the guest and the PSP.
> 
> All doable though.
> 
>>>> Effectively low level TSM drivers are extensions of arch code that
>>>> routinely performs "container_of(kvm, struct kvm_$arch, kvm)".
>>>
>>> The arch code is CCP and so far it avoided touching KVM, KVM calls CCP
>>> when it needs but not vice versa. Thanks,
>>
>> Right, and the observation is that you don't need to touch
>> virt/kvm/kvm_main.c at all to meet this data sharing requirement.
> 
> These are all valid points. I like neither of a)..d) in particular and I am AMD-centric (as you correctly noticed :) ) and for this exercise I only needed kvmfd->guest_context_page, hence this proposal. Thanks,
> 
> 

-- 
Alexey


