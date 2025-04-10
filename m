Return-Path: <linux-arch+bounces-11370-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3264A8399D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 08:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269458C052F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7D2040BD;
	Thu, 10 Apr 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dDWdEbrW"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80E1F0E4E;
	Thu, 10 Apr 2025 06:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267197; cv=fail; b=gYpMfgxXOeZBLigSKlNeoEDX01trCOxlplAIxF5vzRMLrAvlGp5CbnLjReeMG7VYxWsjoGAHSp0k23BbNppC+lTmqDOv9BC9veqkevzvU/OgFagsYShsjYZ0DGBBd/qApIsq429JQa2b3MTU5m647JwnTEGEwmd0vA+GaciVCKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267197; c=relaxed/simple;
	bh=vNs0VWdtgFinwysBFoBsM8G6QaLFZqorDD86TDSTeS0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tdgevSYrPO+fHtVkhrzv4dhy4+5JEs6jBDF349qdemlNdSdno9XO6HgdW4Io0wf5WuQMG/LOBpFZlHADPphDx/BihKOw0syoJdBmd3EIcNZ7NUFVSXbaiPoXSoMZeyJti0oyNFzfzqiWEdmbESyFCFKPfzPh9ll0lCZ4WRIViOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dDWdEbrW; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHGJwusrjZTaJ0NsgouBhm/WKQhICxtgiPCN2og6APtK1TuC8kEZQ276o6RTl5FYpFyY7ZLaJKG3PBFN1LXHcOgG0z2Fl9m4CfCfNJcFQKuA/63y56uPDJ5v5tJixwJrocKilUzUVrLWZBY6vj701//HREU4jxLHR6UvwEt3hSRcFvpabRyciVeC5GF6nL1tSep4fYYFjhD9Le7VQg4UtkK8m97EI3PSAboiVcO1mR0qii/BxdKh8yAdnmPhTT8o7bcBmwTgzXqDUKy4ZFQBdoZPsp0ohlPbMtwsly84s6ATb+cyGqC8KWCJpX/vScAqVvUdcaz5BDM+h7/hWynLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tHCyN8mI1neN77QpD9hXXI7Kxxtyp5Z86S3mB+Wsf/8=;
 b=nrylbllISgEMwBl6F1xMI0pFz8pFzUF9yK7rexisT157kFBsdmUJtxwPA7abxEdMy0pcxPnOsfNweqTwbdqzLwglXC4e4k8kGHoE7l5I64rKPWKFxHplRMsrBkcELfNPJqnirzrzSWCS4LT57QIHsp4Aes6cZtnqHJgExbu6lQCJloVlONMTkrF95Kj5UH0vl0ll4lZC0Lp3vaDBBr+rVUZEHsj4E2sw5O9CfLAh8BwVljuvO/8SLu78G0THV2JPAaTscj6v4lMiAb9wSvdmAirJ5uc0/0YYvM1UI7UddxAUjxK2l4LVy3cYgCKdS43GCXblNZZOtl/fy7DgGDMhvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHCyN8mI1neN77QpD9hXXI7Kxxtyp5Z86S3mB+Wsf/8=;
 b=dDWdEbrWN0jCZ/nOv6bQVboEXMGOCodqDnwTUUsAJyJcfHqXKzYMZsoPw4sNRJCHkN009jwTT6AbgTLU4BhEsHYlGSo2Wi16m9UDb1V8E89DWopBfA5uJwLL0BgFy0Cn5DMLSeRuKMhCrkK0/z0XrPAjGYh8RbH7sx7iyNeXRhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Thu, 10 Apr
 2025 06:39:52 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 06:39:52 +0000
Message-ID: <b051dcc8-58a5-4f24-8b06-e817e9762952@amd.com>
Date: Thu, 10 Apr 2025 16:39:39 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 13/22] iommufd: amd-iommu: Add vdevice support
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
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
 <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-14-aik@amd.com> <20250401161138.GL186258@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250401161138.GL186258@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVPR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:220:204::10) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 27adac7a-4782-4215-9660-08dd77fa7f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZExTY3MwdnNpcFVvR1FIZTJ1eFcrSjRGZmdyYktjWXpyUzdURkRSQlQ0dEtx?=
 =?utf-8?B?U0ZaL2FSYkhHMjNuMW9mWm1yMko5YVhSWHg5OHlZZ1lTTzJNWHZkdy9pWFZY?=
 =?utf-8?B?OC96djRycTRubHJkTERYcjdwWkVrRmpYb2RLZEJZQjYzTzUrV3E5QWJ6UkFU?=
 =?utf-8?B?SUxTR1FuWklrYk42Vm9xbVNJZTZuL1J5Y0QrVlNWVzdma2pmRjJrWmowTDFk?=
 =?utf-8?B?MmQ3YVc5Y1lHZ014bm91bWs4bTRwQzdlOFB2Y0EvV3hCVzlmc1Y0WkRtMERh?=
 =?utf-8?B?dGFGTXVTTjVvUjNLeHp1a1dRVm9iRUxKRU42RjVZN2FMYjg4KzllaVR4KzY0?=
 =?utf-8?B?NFpsRDlhOFF4aGhPY1BzU042aG81cGVKK1NlYmI1dktjV2ZlcmdlS3pYSmc0?=
 =?utf-8?B?UFhaaE5vOXd1OW5zbUNpTWU4ZlpYTEs1NVcrSjAzZWFyeVQ5cm9lbzg5QW1I?=
 =?utf-8?B?MjBaS2pyR2JUTVBVY2x0c3JlN1F1WHZkQXNRM2FBREM0NjFhUHUxOEtnenZu?=
 =?utf-8?B?M0Y4ZzA1REJUWnpCaktlY1hsQzY5M0dSUEJqem95a0dHN2dOejFJMXNkcDBi?=
 =?utf-8?B?Z3FBeVY0RzlibDRxbG96SlExcE1scjE3MWRhSXczY01rSmZWTE81eWpETFRG?=
 =?utf-8?B?UnhPckExa0xaa294Z1Z1bUxSNUlXTkhCN2NkK25iZi9NdGxZK3QzSm5QY2hu?=
 =?utf-8?B?WXJrZ1BTemtYUHBjWjBsbFYxVWVzQngrRS8wRnZrQkhHSEluY1FXcFo0T3di?=
 =?utf-8?B?dTFISGZvaUM4SmtUOU10R2lncGgzOGw2Y1ZTdjlwQzlnRnB6NTg1Y2xaYUhx?=
 =?utf-8?B?RDZCaU8ybVN2VUNXR3N0RzZsK3owd3dBQXU5WDgvRzZwYVZPdU9lNmdiZDhF?=
 =?utf-8?B?RTRObEgrbGdPanN0cWtQL215bVhMQjlRT3dSdWVsaTk1dHE2ekMxNURJc05h?=
 =?utf-8?B?N0N6TWFOUnhCd0kvN2dtRjNtTzhROVJZY0J5Z1pid2oydVlUOHVjd1krNTZQ?=
 =?utf-8?B?OU9wNzZnQXlGcnpYVVNoMWU4elZYbWJWQ0lqeWIwK3VRTTdHNkdhZG5yNFZL?=
 =?utf-8?B?cFZJMmlDSHZYdjRielhDKzRQcEJxYjRTSGFab0xhWlBHeEVsRW1rQ2IycHZS?=
 =?utf-8?B?b2R4V1B3ekpHcFRuRlBuOXNmWWd0ZkVDbHl5NWJoT1JHUGxnclFOY25jUjVz?=
 =?utf-8?B?VkVpeWlVa00ycTBtMmlKVlhwNFFnMmMyU3ByVk9UNEpNSXpiMlRMY0Y4cU5v?=
 =?utf-8?B?SkdDVDBvckJTRDZjSXh3dGlPbmFKM2oyTVprMUYzUWQ2ZE1ESG1odmNVelMw?=
 =?utf-8?B?UzIxVnBSVVJaOEgxanJUMnJZYzhXUVhMMTBCMmZRc3ZmN0gwdEFGUnFoVjBo?=
 =?utf-8?B?NEkxY09hUkZhd2tFNlkzcW96Q2Vmc2pub2xOeHVWSnZ0UkJodTg0eDdkSGRU?=
 =?utf-8?B?RkhLMTVVZDhqQlRRVGF5TjNCam5IOTNvQ3N6Q3ZGTEkzbDY4N3lVR01ScVRz?=
 =?utf-8?B?UG5CdFhZN3lCeWdVNDQ0YStEOXR3RXVrNkQ3MTNWck03d0owNEZKcnBadXVo?=
 =?utf-8?B?WG1wWTZVUEJKOWtVZ1JOeXFpUHBuM2VzblZrZ2x3NHRRb2dmTHJvWGxybWhX?=
 =?utf-8?B?WkpHRW16WE9FWlJzMlpMU0lZNE5mVW1Cbzc5eWxPMWxUemJhSGVYSnViQThl?=
 =?utf-8?B?MXJ0RWlSSHN1bXh6Ui8vdG5CdEFKMVcyWkNkRElNaVNjd3N5MHBKbE0rTUR1?=
 =?utf-8?B?RUk3a3B6UFlKNkRyZndFczZ0K1BtSjYwMjE4VU5ZejZkanFZNk9WVjBpOXp1?=
 =?utf-8?B?dVg0OFV0OEoyNG16QUh1T3luQmVJZVhCbmdQUDBrQktpS0NsQmJKRWZFVnEz?=
 =?utf-8?B?R3dsK1pMSVZVckdzMWVCbnRHN1ZHd1NWNmg1TVBRVmMwVUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmxoeFh3RzhJM0JwUG8wckZDYTd2Q2ZGZ2lheEZzdDRlb1p0OVdNM2lQUy9E?=
 =?utf-8?B?djRqc3h1ZzhWcGJqVzhlV0lxc2V6NTRZa1dYa3I2S29zNTFDNlpwWlBUQXZk?=
 =?utf-8?B?R2tTNU9lV0Y4SnRxOGc5T1F4c215R2NBTXR6TEJmWUxPNmQxU1dmdEExRUNq?=
 =?utf-8?B?Nmxmd28vVFA5WndBbTZ3dkM2NG1sa2RUN1NBT2c0c1FBclgxUDhkdCtsSmtV?=
 =?utf-8?B?M1I1OTVoUlhFYWZoelZGd1JaWGYyTHJnQllhYlAzd2lmbWxGd1pSaUNPWGJB?=
 =?utf-8?B?MXZPelhPRWdqMzg2Y1d2VldwMVJ2cUlvUlVWY1VySlpEWXlnMTVOOUVCTnAx?=
 =?utf-8?B?YUl1eU1UZDYzTmZ0RGlXWjlIeTgxdGFWeE9rOXYzcjRRMUMzejFGM3JzTGhL?=
 =?utf-8?B?WFY0S0pmaUxVZlVSb3UrYVEyaGlGTlFmNFFJK1R0bzZGclNkaGQ1WjVyWTVF?=
 =?utf-8?B?MHFBN2lzcUxSd2JUQ1hwbjhDQTVDdjNHZjlPUGcvY3hxMUdYTFhRREhYZDY3?=
 =?utf-8?B?REhmQStabHdZVjB4d0lmUlRvUnZsbnFCVEZSSVl5WXA2TFBKekxwbVBqVGxz?=
 =?utf-8?B?aVU4bTFGbkYwaHptb3JUZEVTcWpxSXkwRzZUWE5UQURaR1RPNkN0bW50SnZX?=
 =?utf-8?B?YVpPYWFzWUNIa0FMUnZ4dGIwWjN2NkNPa0pZejJSVmZFN2xaQngvdUh4YkZY?=
 =?utf-8?B?cHI3QzdkZWtPc051bVJNeEhhLzJUL2F4RlRUVUg0a1VnS0VqRVJOWkp4ZFBp?=
 =?utf-8?B?eFJiQzA5QWNnYVhCbEhxT2s1TWZCb2wzeHNhV2hBSUtNYVJGZ0cwNGNHRW9Z?=
 =?utf-8?B?enFjeTlYemZHVG1HYjVyQ2VxRjN6dldzelI0RmV6U0JlbnZ0SlZ6L3lhT0h2?=
 =?utf-8?B?S3FWUlhlK21kdVhveDljNUIxOU41a1Z6V0c5MmpxTC95ZjhXU3FEU1hFbEVt?=
 =?utf-8?B?ajVjUTNuNU9pbCtONXF0M00xUEs2bjZlUStQbHRjUmhWaHhJL3lhSGJheEJ1?=
 =?utf-8?B?THplQnV5YmNjamlVOTJCdFBWUFVFcHFlZ0RLSEJ3eWk2VHJzQXBoOFNkbmwv?=
 =?utf-8?B?RkhjUjNvSWFrK3VwUEJkemtOT1JxVktIWDd2WFVybG5YMTRDZzhLK2FObW0x?=
 =?utf-8?B?ZFU4NGRIdGxQMVI0azJzWHNUYm1OQ2Y5OS9HQlNGVHYySTE5bTR3cEVnRG5X?=
 =?utf-8?B?V3JtZHByVUtrZmZVNnZGQUhZd3JvcFpjWERHMVRNc1Q1VFg0b1VSSDZrMUdx?=
 =?utf-8?B?ekNYNUR3VE5nRjZtVzEwcTlHZisrTWNSeTFXcUx2KzZ1Q1pwdjd3RUhUaEJQ?=
 =?utf-8?B?YzM3cGlrTG02VlBlWUtwVXVPdC9vZHhXOFg2SDIvZXYvdmZ2UnFMdGtVQmRz?=
 =?utf-8?B?SHp4NURwb3pKZ09XMVVQeWxOQmpMUE1wOEpVd1JPSmovVnFmcUJaYW1nZjFY?=
 =?utf-8?B?Q1FzNk9GREZJTWM1eWY3S04zdFhETmt6NlF3NWN0NDVXMkNyU3NCZkhRTy91?=
 =?utf-8?B?QVVmOVBia1JVWWUzNmRTc1E3SE41M0MwYmEvTXRST1NRUEd1dEUzdEs1d3Uz?=
 =?utf-8?B?eGk1UEUrZDE5dGtwZE9qMWtVUEZFY0V0TmxyUDhESnJQaDlzcm5seExkZnFN?=
 =?utf-8?B?dk9KNnVhUXF0NUtXZWQrZ3BvaTljWU1paUJvVFROTTV2Y0ZQWnJqd0RTUHU1?=
 =?utf-8?B?Q0RTRjRsQmxFUG41Y2dXZ013d3NaMUMxM0lBL0h3VDI3L09IZytJbDB2bU82?=
 =?utf-8?B?VFlxcWZ1Mi9VaEc2U2dEamhMU1RBUWJDK09CU1RkZCsrRE9RZWdrMVh5S3hO?=
 =?utf-8?B?MGNOZ0lEZWNhbjNaZWhwWDVscDJrc1BOSDFGU3lVMnVCT2R5bE0vN09qMU9Y?=
 =?utf-8?B?RGQ0bDFnc1BWbm9qWkFXdjJsRm5ucE5SU1Fpbitvd25sOERsUmV1cFRkOGtC?=
 =?utf-8?B?TXVsOVpndktTU3hIMUVJZnlGY1BUcTQrWUthNS8zSGo1OGlDaDV2UWFJUjNQ?=
 =?utf-8?B?M043aVRzbCs5YVpaRitnWVduR3kwWm1yblUxa0pVK01hU1VkRm9aTXRwdmVx?=
 =?utf-8?B?SlBqdEZFQlkrZHpOazh1NWpNVjg3VGlvVHpnQVZLOG9mOTNPOHYxV0I1MlFw?=
 =?utf-8?Q?nOW6IGlkJQOx602R0XHBij4FB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27adac7a-4782-4215-9660-08dd77fa7f92
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:39:52.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7U8dZWjowLBXYNFWSEAa7Q1rlIrqW5brYdKMOiXYgUCVU+KJmPPzJypdVVwLsQKNDZr97W1aPdwtKmIicUmWXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763



On 2/4/25 03:11, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2025 at 10:10:00PM +1100, Alexey Kardashevskiy wrote:
>> @@ -939,6 +939,7 @@ struct iommu_fault_alloc {
>>   enum iommu_viommu_type {
>>   	IOMMU_VIOMMU_TYPE_DEFAULT = 0,
>>   	IOMMU_VIOMMU_TYPE_ARM_SMMUV3 = 1,
>> +	IOMMU_VIOMMU_TYPE_TSM = 2,
> 
> This should probably be some kind of AMD_TSM and the driver data blob
> should carry any additional data needed to create the vIOMMU that is
> visible to the guest.
> 
>> @@ -2068,7 +2069,18 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>   		new.data[1] |= DTE_FLAG_IOTLB;
>>   
>>   	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
>> -	new.data[1] |= domid;
>> +
>> +	if (domain->aviommu) {
> 
> AMD should be implementing viommu natively without CC as well, try to
> structure things so it fits together better. This should only trigger
> for the CC viommu type..
> 
>> +		/*
>> +		 * This runs when VFIO is bound to a device but TDI is not yet.
>> +		 * Ideally TSM should change DTE only when TDI is bound.
>> +		 */
>> +		dev_info(dev_data->dev, "Skip DomainID=%x and set bit96\n", domid);
>> +		new.data[1] |= 1ULL << (96 - 64);
>> +	} else {
>> +		dev_info(dev_data->dev, "Not skip DomainID=%x and not set bit96\n", domid);
>> +		new.data[1] |= domid;
>> +	}
>>   
>>   	/*
>>   	 * Restore cached persistent DTE bits, which can be set by information
>> @@ -2549,12 +2561,15 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>>   {
>>   	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>>   	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>> +						IOMMU_HWPT_ALLOC_PASID |
>> +						IOMMU_HWPT_ALLOC_NEST_PARENT;
>> +	const u32 supported_flags2 = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>>   						IOMMU_HWPT_ALLOC_PASID;
> 
> Just ignore NEST_PARENT? That seems wrong, it should force a V1 page
> table??


Ahhh... This is because I still have troubles with what 
IOMMU_DOMAIN_NESTED means (and iommufd.rst does not help me). There is 
one device, one IOMMU table buuut 2 domains? Uh.


> 
>> +static struct iommufd_viommu *amd_viommu_alloc(struct device *dev,
>> +					       struct iommu_domain *parent,
>> +					       struct iommufd_ctx *ictx,
>> +					       unsigned int viommu_type)
>> +{
>> +	struct amd_viommu *aviommu;
>> +	struct protection_domain *domain = to_pdomain(parent);
>> +
>> +	if (viommu_type != IOMMU_VIOMMU_TYPE_TSM)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +
>> +	aviommu = iommufd_viommu_alloc(ictx, struct amd_viommu, core, &amd_viommu_ops);
>> +	if (IS_ERR(aviommu))
>> +		return ERR_CAST(aviommu);
>> +
>> +	aviommu->domain = domain;
> 
> This is not OK, the parent domain of the viommu can be used with
> multiple viommu objects, it can't just have a naked back reference
> like this.
> 
> You can get 1:1 domain objects linked to the viommu by creating the
> 'S1' type domains, maybe that is what you want here. A special domain
> type that is TSM that has a special DTE.

Should not IOMMU_DOMAIN_NESTED be that "S1" domain? And what does "S1" 
mean here? Currently the domain in the hunk above is __IOMMU_DOMAIN_PAGING.

> Though I'd really rather see the domain attach logic and DTE formation
> in the AMD driver be fixed up before we made it more complex :\
> 
> It would be nice to see normal nesting and viommu support first too :\

It is in the works too. Thanks,


-- 
Alexey


