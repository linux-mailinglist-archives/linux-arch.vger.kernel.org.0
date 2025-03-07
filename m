Return-Path: <linux-arch+bounces-10562-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806ADA55D92
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 03:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F753B49DC
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 02:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C1D189B91;
	Fri,  7 Mar 2025 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uOqasL1a"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D501624E0;
	Fri,  7 Mar 2025 02:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313968; cv=fail; b=N1qdmH9LRzQbTEGKhShk0AXbePCZqVjcNV5yF7XYVWZj7tcn01wwD6Xaeo4B1qm6OdHzFWR71Kx/g7LqHry5rIpUpMJOuy2HEUoQk8WfWy+RbuiHXNa/BUvgXTBlg9WUBbuR5i6g5R+4axhgNwp5jM9qMi033+/12yxOxMh4mrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313968; c=relaxed/simple;
	bh=009Dfc+NlIplw3MTlEGT89S/8ajTNxDPVjWtMsoPQhc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rW1OHHYGqecYLaaB9ipBjTw2Dqb8d4LnLTaC49WYUy3kppAMVHkaKsANCLfqEvVc+qEr7lmAYiFhzsnY4vicDvsZfd3Jiklcs0e3cufUJA6bonubrXyOjl2MKEL1ANqHW48tOJhRqlbVM4620PjqJ0BXwKzRVkVMEsydFqKu5UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uOqasL1a; arc=fail smtp.client-ip=40.107.95.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dox/TsTiBY60NiXhXDB81YRQxTbYziuYsMpgOcDZnzArJhl1ieHWvO9HOvkDQTFnwoonNQSqkOASqvl4EhvGDxDvvpY2c3ub9tbb7CrQmMAhy69qVupQdmadeICWYOWuMmNSHxdY7GJFTTbqvmXPBMdNd5HIz2kBpazdPW3syH74ys2N1eTXwj/8ogSFgA07JrVzU0Uj2VUMkB6U6JDHdL1sYXD6gpTwOD0kbhf14pEUK2dgRxbaV+ivpvvxbb4cm26SVSGZnRQZnw23LlnUWTW+GZBuPxkivJYpWxHp46lBe8sBHQAv4NgyENrTkrlSPxqs1TJXM3R8Xg4NwKcWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rC4aOCbWVxP2DP583h1HcML2cj49D4DHoTWBimFLFEs=;
 b=vWRffGzHSyc9VyomXqKrvdGO6KLJ2y8AhAymB69K9U6IMVQUYeKDYOKL+DKiS0D9eE3B21mCi/JlLn9tOPL6yw7LoTDjR00e9q7x2vUqjqDpW/YYUG7pMOwqpt9DUdWSduK59XNijfOBVEQzUqmP5moL4/pQ6AmX7GKdPikgXF81N7sb39uHD/lyvIlPnQgFzFkSKNidI64Hw1pEnXr12khKKz6dLWTh7f5eJaE02mzSnHP7vE/inGOgMQ/htfj7nP3tie/RYALWZ4nLLtvvaw99N5T4HG8bR0nSjLCevOQ19oO2pKK8F2ifU5gM2f4RsS3O93FYr816JOIzrwxvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC4aOCbWVxP2DP583h1HcML2cj49D4DHoTWBimFLFEs=;
 b=uOqasL1aM+V5H9QG27xDLpKmFWYexYrxlEdr8X8x2knNYUpl8c2MBtI1X44Gq792AA+Xa+kcPhytx0Js9qor96bcpWaFconMiFKEsKk3GFyLCGNxv08Leo9F7w/f1rAcI90KZkFVtvEubSyt0Oz29YhP1donI1LB9mbzyz3643M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 02:19:24 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 02:19:24 +0000
Message-ID: <c5c31890-14fc-4fab-8cd4-d4dcfdecdd2d@amd.com>
Date: Fri, 7 Mar 2025 13:19:11 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
 <joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, Zhi Wang
 <zhiw@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z72GmixR6NkzXAl7@yilunxu-OptiPlex-7050>
 <2fe6b3c6-3eed-424d-87f0-34c4e7e1c906@amd.com>
 <Z77xrqLtJfB84dJF@yilunxu-OptiPlex-7050> <20250226131202.GH5011@ziepe.ca>
 <Z7/jFhlsBrbrloia@yilunxu-OptiPlex-7050> <20250301003711.GR5011@ziepe.ca>
 <Z8U+/0IYyn7XX3ao@yilunxu-OptiPlex-7050> <20250305192842.GE354403@ziepe.ca>
 <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z8lE+5OpqZc746mT@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0186.ausprd01.prod.outlook.com
 (2603:10c6:220:1e9::10) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 563793b3-e912-4b47-6d4e-08dd5d1e7a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ni9QelBsMUpaNEMwR3RHNlFJWk9yS0Q3Z2pNdEc3L1FVOTdhTm0wbXprUzR6?=
 =?utf-8?B?dlBQTVhISkNZTGlsZ1hoNDdjckdISE5oajdpOGxyb3FsTzZJc2ZvNFZHcFQx?=
 =?utf-8?B?ODIyMEtiRkUrRUVlNzhUUmg5b1I5aUF0RTN5THRNQmZuSldLUVd6NmljRWp4?=
 =?utf-8?B?eXlmOXg2eVpySi9lbjhobVU5QnlZdFJNdmdKbjYzOHZNRzNONzlqSjFWajVy?=
 =?utf-8?B?Q2xjMG8zR2J0N3ZZdmtPcXdFSHhoWGFya2R2M1VMaWhlZnViRFRsWWY5QlIw?=
 =?utf-8?B?dnlxYU5kSXBZa3N6SzV0d2VCdXJjazNjUWI0NGVHcFZQN2hoUEZ0ZHZtV1pD?=
 =?utf-8?B?elU2NmQ5Z2U3WURkZWZ4MXBtd2VoM3ZGTlk3bEI5ZHJ2M24xdmFGdWhTMk80?=
 =?utf-8?B?cUN6b2Jyb2JpRmM0SytiN20zWFJpcDBaeDZOVGhlbXh4RWFqVmFISnZUd2FK?=
 =?utf-8?B?MXV1cCtOMW9NMEU0WkFkNjFUVHRPK1B6R2ZENTNKc2dVSi9SZHpLaGx3cDlt?=
 =?utf-8?B?akY1Y2M1MG8rWFJuZUFzbFVlczhvVGFGM2Nrd3dQMnZFSWJUYjJudnlsN3FT?=
 =?utf-8?B?VUtuempwa2dSeEdFNHN6YkJFMnBZQVhRNC9USkROdjFuanhldDExYTZNS0Rt?=
 =?utf-8?B?SU5pNGVFbTRUQTAvUlpRdVNIR05OR1hDYUw2TG9iQ2t3UXZ2V2FOdWFLdTcw?=
 =?utf-8?B?bzk2Rk91bHNUQWVEKzcyR2IrYXd4OElZN3owNWx6K2lQSm9UYVhTd2ZjcnZ0?=
 =?utf-8?B?dUQ5Nk9US1MvYVcwYk1zdEovTTZMZzVieVd2V2Q1R256Z1FCZGd4SC95WkNC?=
 =?utf-8?B?TjB1SklXcm92VE1ZbmtTdnBXbWpkNUp3aVdYdDZjZGFlVk1Eb3U4Nm00KzRL?=
 =?utf-8?B?SHFQYm1Pb214ZkRKajBZaFNQcERPMkNhZ1ZncEdvQjFmZUt3dE9yTVRtdlZ3?=
 =?utf-8?B?RTJPeGkrdlFXZzMxUlVHVVVWRjU4WDg5U3ZpWmdPUGdZRll0dTh6ZXFVRUlr?=
 =?utf-8?B?MG5ZcGNZUXMzeWRVK3lxSm9kemtDTXNHc0UvV1FaS1hmcmd6SjdOc1VZWE9P?=
 =?utf-8?B?ZDVKZjBITWl5MllKNjFKNklpMXljUzZ2Z0tCYUlVUWNrVWk1cDB2cm16bTVx?=
 =?utf-8?B?c2M4U25WOTQxRHFLd1A0ZXZIbFc4R2VZTldTcEo5VlVSWHRqRTdJUkhlZWRu?=
 =?utf-8?B?YVZhc2g0TlhPV0dDSmdmVS9sdnhjaWRTY0RiSlIrK2ROd3VXNG5qZDdDU1kv?=
 =?utf-8?B?enczQ1gzNS9LbWsvTGdDbVhRcnBQOVJsUVNERHoyZ0NscVNzSk8zYnRvN0J3?=
 =?utf-8?B?N1pEREJVNjB1ZktyU21zMTZKNk81dDlTWmxPZlNUM2l1aWh1NUc5VlFwc1o0?=
 =?utf-8?B?aTc2WW9QeFBzdUtOTWF0Sll1QWhLcFJ2RlBrMFliQ1phZGh2SUY4ZlVKeXRM?=
 =?utf-8?B?TnRRUGsrUnRNdjFtZitXbkNvSVZuRHNaQ3VDeGE5bnpsZ1JCcDhzQVZ4ZE9o?=
 =?utf-8?B?dTlQSUVoblBIS1h4YVl6NEZsUTJJQjNCZSsyM2MxU0NpWXFqWTN2MkIxTnN4?=
 =?utf-8?B?L25odkNsNW1BVFZ1UmVBNWlYcDduc3BTQ09PNFdMSnNiYVF2Mm1yWno5ZEJO?=
 =?utf-8?B?ZG9oTGNaOE5CYmxYQy91SWFTcXE1ZzhiZ09ja2NRMUNJMllkZFkzYm9IbUVG?=
 =?utf-8?B?MlRZQTVzNlpjZDZ2RlZEeGp0TTlNUWRkVDNveW1DRUgxaVlFNHRzRWZSRjlL?=
 =?utf-8?B?Ynp2MFBGN1ExeTVHMmpFUkM4N2NRVmdoNHlIcHpjMDFxVHNWMUY4aEhlMWE3?=
 =?utf-8?B?YndSeGVnT2J5SVFkaTR5akw1ejhtdkRxalR5amZ5YmZ5MDlMT2JKeUxSWTJG?=
 =?utf-8?Q?D/L/A/wHXnY70?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekVvOFIrUVhmTGlualhwWXVCa0Y2dXFNL3B4em5aczk3bi9RWkpSY2cwYjJv?=
 =?utf-8?B?cTFrV2ZLZXg2WjJQMlFDMW9lc1dMRFZJY1A5dGVsSXhpSk5RZTVvYXdUYkdO?=
 =?utf-8?B?YWdSQUZ3a3FxWGpvdjFxelpFc2NPM3N0eHkrWm5uQjdSYU5ubkVMaUlUY0RK?=
 =?utf-8?B?ak0rbFZnV3JJbGVtMnVhcnhuVGI1dHl2aTNydjdvelRMaW40b3pzeHYwYXky?=
 =?utf-8?B?M2ZSN3E4MnFqVjJmdjkvNWhGMG8vNmp4bFhESEM5cjc4TDBSZ1I3RFJmc3Jm?=
 =?utf-8?B?ZEl5TmRLa0c4YlVIZTlEdk9XNGcvYzQwQWpMcStzYm1VSG5BbnFpTlF4N3J0?=
 =?utf-8?B?T2RDSEtmZVZFcExHY2NwODllUTRkQzJFUGxzNUxKREpENS9OTlVybkpBdGt1?=
 =?utf-8?B?UjZjV1M0cVBmVGVvUjhtNnRwTExJTTZFRFFSSTF2dHBsTGVVU3ZESVZiVWxQ?=
 =?utf-8?B?UDRYSVBUOVd3a2ZTZmQxenlnbHJwM0tNWnE1MUJVY3A0VCtaRSswVE0rOGZa?=
 =?utf-8?B?UCtJb0tHOHNOTUQyZnVzbEZ4dmorS1RXNVVXNFRDbFpxa3ZiM3FleStobnVv?=
 =?utf-8?B?WEtNNWpQTUM1bGhudmR5VUlIcGhIYWQyQjZVbll2QjZXM3ljM1ZEQmFZakd5?=
 =?utf-8?B?SUk5eEE3OXRUT2xONnRrbEo2OWI4anZvRzhRZkI4UUJQQVBXdUsxQ2d3R3Nj?=
 =?utf-8?B?U3NQcHFBTjA5OU5iY1FXaThocTE3eEJkRnNqZHNaRkFvbmpxdVM0VFhXSnc5?=
 =?utf-8?B?MEtBYXF3TDNOcStrZUtWMUZ1cXpyRUkxRnVHYkNKN1JOTSt6STFkSExMcWov?=
 =?utf-8?B?RlhMSFo1N2wxSXd2Q1pjU2hEd3RSNE9YZVNKNmRzeG9VSVZzV1Rjd3N4S0Ev?=
 =?utf-8?B?UWpkQWRBOHZTdCt1NFlBUVY1NDVQVzJHVW8vaDloQjRGMzMzRXpzYVFGY05Y?=
 =?utf-8?B?Q0t0Z1RwbXkyNzc3bW1WcVMrOWt4bDVnV2ZHTkJ6c1gyWExvMldhVktTV0d5?=
 =?utf-8?B?eWM2emkwK1NId1hYT0RkMHVEM3huMnNwWHd3K0Y0RmlzNGtsVXdnSG8zTExE?=
 =?utf-8?B?OWNDTW9HU0RUMEJDVGtCMVViM0lVUCtJZy9nbjFnN1YzODdUOUF4T3dybWdk?=
 =?utf-8?B?a2VNUjV1WU8vaVJKMXNDbXZ1OTcwclZxR2tXVyt2OENuNXpoU3FvSUZHS1Bp?=
 =?utf-8?B?ZjRqZytpNTJZc2paeDBXRnduOHJmVC85bHNhMWhyT0FSL2RQMEYzWFI2N2g3?=
 =?utf-8?B?YmJWNlltMkhjY0wybitLMWROVk1YV0EvWGxpaW5YekY0MU1UMWJuKzNDU1hL?=
 =?utf-8?B?bS9FUzNGVXRMa3ZnUXh5cVJ5WVlzOHNLS3gxMEMyVVlxQjBtNEk3azdXOTl4?=
 =?utf-8?B?eDcwakZzVVRpNHZkNWtqazVMTk5QWm9nM3NsakRHMnAyamx3L1liemV3SkpK?=
 =?utf-8?B?clBCUWFqbmpZYkZ0aWQxU2hZTW9veG5LRXAxOVAyQWEzbVd0NGdJY2luU0hD?=
 =?utf-8?B?Zngwc1RGUjlpaklGRDZjWk84L2UrUFpJQlNxZDhYRTIyUWRDRFZMVU56SDQx?=
 =?utf-8?B?aWtuM1JsWlM5WHNxNGZCaUo1ZHZvMGRSa3dsSk9HejBmTXIrZXl4MkczR0NP?=
 =?utf-8?B?dXdQSDdIaFZLeWwxUjAvSTdMK1kyc1I4Z3RKQmU4RlV0T2RtM1ZteXcyZ3Qz?=
 =?utf-8?B?QTQ2YlBxU0Y3aHdUZ20rRGlKaFd5ZEl5SzRMb0YvS0VQWXE4OEltYlhNWUJu?=
 =?utf-8?B?bVJiOW9EWnlFL0o2VjFmakhuR080aUJRQ1djL1NaeDdUVVlaRXMvMnhQd0VS?=
 =?utf-8?B?aExNUGxrd2RLWCtESENJQnRTYnpRWlBxTm5ncGxnZyt1OVAzODJsQk9GaExY?=
 =?utf-8?B?WU52ZE5JWUkzcXJnQ3ZHMWE2ZUV1aFZTYWRoaFlRZ0YwS0YxbjJGVCtURmEw?=
 =?utf-8?B?eWV3aWZEbDI3VlNSK3B6TzZkQm5FOUdwd2JjK1g2VE1BVHRTOGdvcy92ckdl?=
 =?utf-8?B?ZkJ3ZVM2dHZacjRsV2F3dWJCQ2FoWVcyclZHQ3JqK2lPakZtTWxwQm9JSkc0?=
 =?utf-8?B?b3Jpc1lnMGUwMEsvK0trNFhWMCtBdjBPOXBaNlAvbDQ4TFJzTjRKNy9PdWNK?=
 =?utf-8?Q?KTySpONR4pNkQfhEfeRua6yUn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563793b3-e912-4b47-6d4e-08dd5d1e7a63
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:19:24.2463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXIhZShT1P+jr+VCWmEu2FQzeTIqpJoO5ClNAmsj40xi9PrRcSnhp5sDT2qTPIZsXTXaJs+rrwic9k+GtN2Qpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091



On 6/3/25 17:47, Xu Yilun wrote:
> On Wed, Mar 05, 2025 at 03:28:42PM -0400, Jason Gunthorpe wrote:
>> On Mon, Mar 03, 2025 at 01:32:47PM +0800, Xu Yilun wrote:
>>> All these settings cannot really take function until guest verifies them
>>> and does TDISP start. Guest verification does not (should not) need host
>>> awareness.
>>>
>>> Our solution is, separate the secure DMA setting and secure device setting
>>> in different components, iommufd & vfio.
>>>
>>> Guest require bind:
>>>    - ioctl(iommufd, IOMMU_VIOMMU_ALLOC, {.type = IOMMU_VIOMMU_TYPE_KVM_VALID,
>>> 					.kvm_fd = kvm_fd,
>>> 					.out_viommu_id = &viommu_id});
>>>    - ioctl(iommufd, IOMMU_HWPT_ALLOC, {.flag = IOMMU_HWPT_ALLOC_TRUSTED,
>>> 				      .pt_id = viommu_id,
>>> 				      .out_hwpt_id = &hwpt_id});
>>>    - ioctl(vfio_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, {.pt_id = hwpt_id})
>>>      - do secure DMA setting in Intel iommu driver.
>>>
>>>    - ioctl(vfio_fd, VFIO_DEVICE_TSM_BIND, ...)
>>>      - do bind in Intel TSM driver.
>>
>> Except what do command do you issue to the secure world for TSM_BIND
>> and what are it's argument? Again you can't include the vBDF or vIOMMU
>> ID here.
> 
> Bind for TDX doesn't require vBDF or vIOMMU ID. The seamcall is like:
> 
> u64 tdh_devif_create(u64 stream_id,     // IDE stream ID, PF0 stuff
>                       u64 devif_id,      // TDI ID, it is the host BDF
>                       u64 tdr_pa,        // TDX VM core metadate page, TDX Connect uses it as CoCo-VM ID
>                       u64 devifcs_pa)    // metadate page provide to firmware


(offtopic) is there a public spec with this command defined?

> 
> While for AMD:
>          ...
>          b.guest_device_id = guest_rid;  //TDI ID, it is the vBDF
>          b.gctx_paddr = gctx_paddr;      //AMDs CoCo-VM ID
> 
>          ret = sev_tio_do_cmd(SEV_CMD_TIO_TDI_BIND, &b, ...
> 
> 
> Neither of them use vIOMMU ID or any IOMMU info, so the only concern is
> vBDF.
> 
> Basically from host POV the two interfaces does the same thing, connect
> the CoCo-VM ID with the TDI ID, for which Intel uses host BDF while AMD
> uses vBDF. But AMD firmware cannot know anything meaningful about the
> vBDF, it is just a magic number to index TDI metadata.
> 
> So I don't think we have to introduce vBDF concept in kernel. AMD uses
> QEMU created vBDF as TDI ID, that's fine, QEMU should ensure the
> validity of the vBDF.
> 
>>
>> vfio also can't validate that the hwpt is in the right state when it
>> executes this function.
> 
> Not sure if VFIO has to validate, or is there a requirement that
> secure DMA should be in right state before bind. TDX doesn't require
> this, and I didn't see the requirement in SEV-TIO spec. I.e. the
> bind firmware calls don't check DMA state.
> 
> In my opinion, TDI bind means put device in LOCKED state and related
> metadate management in firmware. After bind the DMA cannot work. It
> is the guest's resposibility to validate everything (including DMA)
> is in the right state, then issues RUN, then DMA works. I.e. guest tsm
> calls check DMA state.  That's why I think Secure DMA configuration
> on host could be in a separated flow from bind.
> 
>>
>> You could also issue the TSM bind against the idev on the iommufd
>> side..
> 
> But I cannot figure out how idev could ensure no mmap on VFIO, and how
> idev could call dma_buf_move_notify.
> 
> Thanks,
> Yilun
> 
>>
>> Part of my problem here is I don't see anyone who seems to have read
>> all three specs and is trying to mush them together. Everyone is
>> focused on their own spec. I know there are subtle differences :\

One is SEV TIO (earlier version published), another one TDX Connect 
(which I do not have and asked above) and what is the third one here? Or 
is it 4 as ARM and RiscV both doing this now? Thanks,


-- 
Alexey


