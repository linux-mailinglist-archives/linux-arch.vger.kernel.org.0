Return-Path: <linux-arch+bounces-11154-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3146A72995
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 06:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 548FD17243C
	for <lists+linux-arch@lfdr.de>; Thu, 27 Mar 2025 05:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C628156F28;
	Thu, 27 Mar 2025 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PtPNRalI"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC33FC3;
	Thu, 27 Mar 2025 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743051647; cv=fail; b=UjRS0BwUN3y0VtgEPHFaeNZRQCE9dJ7TGHAJ4GwAo3M2pcmsduGf+dS+x+LnGs3tlyCavvYqECKm6Lyfm+YxNfiCh9p0/YpMEdt+33wkE1Y29IzcjZNMVEEVZBkFg3hPMBiGskdVI8iDpzx0j/Gapzo9GMdSIRPBxipGfiLcjkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743051647; c=relaxed/simple;
	bh=0Tamt3tYWWJIXjLRJ4BU/IrKLMAE9v3s80GBKDASaJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHznQgRJzvQFao4NYiGLOe1fdb+i4ilAiqA0fUG6ZQHRn+g8btGcZvMGPkjihZfu7eGgMo0SUFbpbtTEZDSHV5nm0TZ98c6QGA/E8/nPFrDtKKVNEIe7BY1zGegHCMPJpYow4i5rVLycAi1kfMjllAkB6JxoO6AKrJ7NHFiY+s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PtPNRalI; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykq9vQhjPmaJfOdXEtCTtDZrEToKS1ZCFwQXkJTOuWmDP95d58HthlKgw2GnvKZmgxt4p2ApgnP8Aw+BjMfMr71baLwYKXxhH2B2PTz3kqCvPTlG3bHVoCz67InG7BalOThWholFnZeG3UvdvjRfp+MM+YXHO+FWJ3JTfQpXOXD781sPBYjdDxmaV9jMi26RGL/LvA+QQY5S0RPhV7iQjOKNdnSCu/rGHmgvHKAFEjWzUb5rw8ppITBRazyPWZOGEjhAAO4glltA5QqLqv/KK7fGSJv2C3KPy87JJ82BCN401xjumbuxbP7h7xTtkJAervc+k0L4L+xM5bXZ5439TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouAAQDf+WI+j9s0Guucqnry++sEnIJPp3rqrFuqFlYE=;
 b=aMpXm+0hUyAh2hf8mz0mLcVo4Ta09eJ1bsgMG2EXdnvbcTvZoAInoqHaTqNoTvJhOvQDimGQktWB5GOwDMusLYZAkkh35cYEgpSEOkeEB8FAlLWY5eOsAJjNdFx5Y17kfo+rhOhNhyZznwZsluyiP23HJRYIaHymAtPq/F02tYXo4keXGDaB1dz36uw6eIjlZdsVaJBA1rmh+meZH7pN51ZxqHvhtYwlAvL8GS5TBnzIe8pO0j4YohJYAbyTnh0V+jaZyP/rBu+IrMpGwrxBkf+N2xIo3CxpWwwNMRUuEurM0OL/QteGeDZjkEpPxRuXOZUkLTfY42pXi6gn/M9hvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouAAQDf+WI+j9s0Guucqnry++sEnIJPp3rqrFuqFlYE=;
 b=PtPNRalIf1My59bQGvTSUoWsu0OYSTT74uYjgAZcd3RG6yu1k0Soe0ccmQHQObRFS+ppeCRyy40BG7XZYrIbv3+KKuywcGiaA5KOTQGR96NwUoD403Hz5ZZCK1ZugZg5aaVQUAtcGG/tJCAc2LEE7aNY+RjSCJSvnNAFqqsWd2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by LV8PR12MB9452.namprd12.prod.outlook.com (2603:10b6:408:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 05:00:43 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8534.042; Thu, 27 Mar 2025
 05:00:43 +0000
Message-ID: <ebed8c5b-4874-4fd0-a156-543990ea3603@amd.com>
Date: Thu, 27 Mar 2025 16:00:30 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 10/22] KVM: SVM: Add uAPI to change RMP for MMIO
Content-Language: en-US
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
 <20250218111017.491719-11-aik@amd.com>
 <67d4c4e5b711a_12e3129414@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67d4c4e5b711a_12e3129414@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0152.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c9::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|LV8PR12MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b5370b-0ec5-4d88-4997-08dd6cec538c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3VBU0YzT3FpUEFYTi9jUHZxem45YVl4VmVkMzVETXZ6a2N6bjJ3Y1pISXRB?=
 =?utf-8?B?TXFTbWx2cjhMdFNMZG5la28xR2EvUW1jczAxalNtK3RlR0xFZWFXTFI2YTdS?=
 =?utf-8?B?TS9DSzFYdHp5d2tHY3JPOEdPZ2hIWFBRdEl2bnlVSWlsRFlXR2ZaZ3B2ZzJF?=
 =?utf-8?B?eTJNVlMxNlBrc1hsWVcrWHVIWTlkRHZ2a0JXQ0pGcWdmdUcrTk95VmJ5YjMx?=
 =?utf-8?B?bWJMWDArbG5tL1hwYUhtZHNzOS8xdzN6cWpNVnZndmR1ZC9JMTJHKzBIeWVu?=
 =?utf-8?B?R0FsaVJUMTkzRGtyWENZWDMzdC9JN2pxdlBoWTd4cU94QVZ0Vy80OXh4MHlD?=
 =?utf-8?B?Z2l5MGt3d0pwbXRIMFpuNCtNS2NQNHhPWkdXbUYvME9MUGQyUDJrN1hTdTJs?=
 =?utf-8?B?dHJPRWpCNVBWQ3ljb2dMNGUrOGpCbFdvampxMjF3M2dpOFRMTHNYWk8wdHVj?=
 =?utf-8?B?TVN1cmZYV3ZVYkJVRW9XZm80Q1l6cmpBZnNqamw1cjZ1b1gvV2JTQ2VtaFVP?=
 =?utf-8?B?dDR5TklsYW5BR29WMWJPbE90M3liVUdWUVpMeTQ5WkNBeUx3TW50WGdENE5h?=
 =?utf-8?B?dXROYU04VExxZ054YU5JOFVuNHpveW1KZEZCTG0reFJXMDBzWkwvcURZMzFT?=
 =?utf-8?B?Ui9xYzdZWFJiNEJNQWcrMFZYend5WXczMU1oMDMrOEgrbXo2aGpRQ3BHY3U5?=
 =?utf-8?B?dG9ic2VaTnBXVTRLczRzTUEzSnlpaGJBb1EyaERIZFpvaXBJandxOUlvNkkx?=
 =?utf-8?B?Tk9TTmE0R2xxSExiRlJ2V3FSV213QzdoNVFab20rUEhOUHpoeVdndjg1eDM5?=
 =?utf-8?B?aFVnOG5iTDI0YlE5cElvRjZCaGUrWHNPeW05OEgrNFRhaWplcWhnZEFjYzM4?=
 =?utf-8?B?a0lDYXQ1RDI2WThJV25HZkxKenNXYmVZL0N0S05WTHdJYUV5cXFzVG1hcExo?=
 =?utf-8?B?Zm5wK0g5Nm41L3VjTE9XOEpmdVB3Tkx3bHkxbjhqSFk4N2NZUmpmN2J3b2tW?=
 =?utf-8?B?NytvQkVPeUc0SEl0d3RRV2ZUaVo5Yitqbi9GdVdDQkNFcVVBZU1lNmdKcFQ2?=
 =?utf-8?B?dGphZnlGU29kdW8vUmt0cjNyd0NXR1JWQWJpWTQyaG40RHRSSlAzNnBRTEFv?=
 =?utf-8?B?MHR2Y0JMdDNsbDR4MU54MFlsdnBFWmRtWUxnUStWeWVPR3BtSHppZVQ0UGhx?=
 =?utf-8?B?bVZhenNUVUIrMTFNYzJBQ1dRNFVCRkorMGVyeHlhcmlKMWlOV1E0c1NTbldC?=
 =?utf-8?B?UU5zbE1IdkNqbjkxMVFHcXNEeitWTExUWE56M0l2cklkaUx4aFMySHJNUnhq?=
 =?utf-8?B?cUprRUJLZXF0Z0pDVzJrZE9PdmtqR2VhR3pEZHpMN0JabStYK3U2Z3ZQNGlm?=
 =?utf-8?B?WVVUelEzQXNlZ1lhTk9IeENDWGQrbC8xSlZQUDFYSFlFalVOVDFBZGM1QU5Y?=
 =?utf-8?B?V2JqTUtBei91S3BBR1lGbzEycFY0aXcwRzh3UnVmS0c4U0l6Y2J1ZUxQSm1v?=
 =?utf-8?B?MXNRUzduWk96R2FWVFRuUnRCVUw2VU4zWjk3dlFuZVp6YkthZXk1ZnJnTUFz?=
 =?utf-8?B?alBZVmwyQ3NlQ092T0IraUwrY2lIVnBBTFpBZENKTE9Ud0pNWUE2VzVValVV?=
 =?utf-8?B?R3dZUkR6TGtHTGtVd1B6bWJVQ00xL0NuSFNOdnpscktrSGUzRG9wMS8xaFc4?=
 =?utf-8?B?SEoyR3hGYzNEQ1BxdDhHc0R2TUw2SEFNVG80OC9PQzhzRmllS2k2eWFoUTZY?=
 =?utf-8?B?K2luS2FlLzlvaDZuQ0VMRDNKbHUzdzJiWHVEeVdSdDFHWWwrTVdJdW8yVVVz?=
 =?utf-8?B?ZVVxN1FuZ2R6bjZkS3hyQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlNhN3h3MTlhR0JZNGlPS0czbXVCc0IrdWxzbG9qano3cWVwQmtZKzl6Y0JM?=
 =?utf-8?B?Wk1NWFJlRTJWcXhMVlRiYVcrSjd3a3lUQ1RiSnRqalRZcWo4cmU0Q1dMM3Rt?=
 =?utf-8?B?Sjc4elU5TURUK045OWJPd2Z0VUlNU1MybzFQY0dEU0F6eU4rTWNndnREU2Mr?=
 =?utf-8?B?amNBWVBmM1NDTm1Idi9iUERGanFvTGJFNCtnSEJOQ1VIbW9DaTNaVWlUUXl4?=
 =?utf-8?B?bnpETHlHbDhqK05odzdmWTZRUWpCVkVocmEyckttcEFnN1NRZXRyNDJVRVhC?=
 =?utf-8?B?V2FIdXJlc0I3WDZwNUNVcTB6REIzWjRnekZLd0x6OFg4MExTc1F3dVplY1dE?=
 =?utf-8?B?dFF6aUowQ2kySU4xNXNLYnBxRXgrRVowOU92TFdFMVNvTGhxV0VMOE1ndkI1?=
 =?utf-8?B?ejdGVEFJT3pSREhLcjNrSE4wR0pJT2pweDRCNGtDaW1xdXI1eEtwMWg5NWFh?=
 =?utf-8?B?WmdDWk4vZXMrd3c2eWtzZmVSQ3NvZjJBdnorSG8xN2p5OEJmc1dpMERMYjhP?=
 =?utf-8?B?cGlMbTJTRTcxZEFYUFl4aDU3WWx4bzMrbWJ5bGUzNDJqdTU0czdIdXJmNnJP?=
 =?utf-8?B?VW45WjJWZEc2dUhNZzNjbGRvdHRnblljY1YxdkdKbERnQXJrYVozd3dSSVdB?=
 =?utf-8?B?SlIvSzZobm1jVzNYa0podHVFazhBVjhOY1k4RjF0NlpWeDJZaVFIYklhaDVv?=
 =?utf-8?B?WVZkcVhPeFVBM0t0OGlXeStHaFFIZE9hUU1Cc3RlYXBnMnRYUzFRV3VBNFcv?=
 =?utf-8?B?MnRpdFN4ZWl4bXZDYjhicEE0aGZjcitiU21YcnlZS05UM25ORkQvdkRmNCs3?=
 =?utf-8?B?QWUyaExQOVhRSFJTSVYvR3grUnk4cFR6SVJVTjhwemJlTWpzdXE4cjhqdlpQ?=
 =?utf-8?B?UFZQVk5xNk44Z1BVL0pmNmQvd1VlTzROeXErMTZxNlovVm1TemFnZGowNmUw?=
 =?utf-8?B?MkZFMG55amlra05wWXIySThaUWladmFuVGtudUtMWFE0Y3dHanVaZjFMV004?=
 =?utf-8?B?NDAreXV4OGRocnR2RkxvUmJKUytWb2NISlh6R1d6Rkd4N3A3THV2MHc1K3lY?=
 =?utf-8?B?NG1UZytiandZa0dvMlkzYkQzUHh0NFdOb3RXM0VhYjV5Z2VoVG52T0p2dWI2?=
 =?utf-8?B?MmdkU0RVRVpxZ2E0YnpMbCs4UkJpdlN0TVdzMmpzN1Q3aGF3SUNTMUN0Nk1x?=
 =?utf-8?B?RUhiSit4QmpKS09ucUpoMmtlUjRLdkNObVZZSTQwMWNwSkt0VElEaFZIR2Yw?=
 =?utf-8?B?UVYrU0xITEtpamNtZ2twTkpDSnJRS0VHdVVtUWtWYmUxLzdrbmFPR1hnbW1k?=
 =?utf-8?B?WUN1Skg5NjdWU3BzZzFQcStqK1Vud2JxODh2eUYvZ0RSL0tJZzNKdzcrUStG?=
 =?utf-8?B?MnlMZlYyb0E1UW5hM1h3dXhEdlVoeVVCVDRpd0tUU1N3ZktHZGtWZGNrRjIy?=
 =?utf-8?B?ZzlGRjh2czNTaDRPZjBPYys3MzJzemJpYldVVGxZWUl5Q2NsN0x0U0o2WTRn?=
 =?utf-8?B?aWttOWlTR1VaeFdFRSt4a1Y2U1NCWkFXTGdFY0lKYldGYktseGdjcEdYNURr?=
 =?utf-8?B?MWNxenBrbGI1UUYzTGkwSk5lSklsamJxNG5HdEtERnF4bnpNN21lNUthY0lW?=
 =?utf-8?B?L2pUam1MVkRBem91OVNzOFdLZnhxMzNjK0ExOWlCcHU3NmxQN3pQUzNwY3F1?=
 =?utf-8?B?WkZ6Sm9XUDVFWmtXSHE3ckorZzhnUVFqeTBWdGZYME9vS1pDVGNORE45cnIw?=
 =?utf-8?B?UlF6MDhibnhYYktCdmp4S3E3SGFvMVJYREtnK3U0V1ZuWi92SGVvRHVoOUNJ?=
 =?utf-8?B?UDB0YmZDa3ovWm1uc0JYeCsyK2xuL0IyMm9BQkVpaGdieGtFamUwNFZ1R2xD?=
 =?utf-8?B?Mkd2ZDYyS21nWEhncGhwSXpsNkJON2tkd3ZrU3ZFdnZqSFZWaTBZTWpaYTJY?=
 =?utf-8?B?ZCszRFoxK3JNR0VpVTZIT3FCYXB0SDZ5Z2MzYUs3TjN5dHZxR21lZmpzTzJS?=
 =?utf-8?B?alkvc2xyQUk5SnNnby9JS0FTck5DSmdBSi93alFhMUw4QytMUnFReGNjZjZ5?=
 =?utf-8?B?a0dZazNVQWd0MnpVdGgzdi9XOVUyZHBHQmZsaTNoalo5N3J5OWgwV0t1S2d4?=
 =?utf-8?Q?6VP7rhS9w4Y+TGOOuK0JLJzUI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b5370b-0ec5-4d88-4997-08dd6cec538c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 05:00:42.9667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwdNuvpPydor2+k6SWCpg0J0Z7CJFHLEDJdbtHl9eU0z0BCdk1sccFTVUzWXOi9z/aHrwvfCrFaVlwHopLMDZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9452



On 15/3/25 11:08, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
>> The TDI bind operation moves the TDI into "RUN" state which means that
>> TEE resources are now to be used as encrypted, or the device will
>> refuse to operate. This requires RMP setup for MMIO BARs which is done
>> in 2 steps:
>> - RMPUPDATE on the host to assign host's MMIO ranges to GPA (like RAM);
>> - validate the RMP entry which is done via TIO GUEST REQUEST GHCB message
>> (unlike RAM for which the VM could just call PVALIDATE) but TDI bind must
>> complete first to ensure the TDI is in the LOCKED state so the location
>> of MMIO is fixed.
>>
>> The bind happens on the first TIO GUEST REQUEST from the guest.
>> At this point KVM does not have host TDI BDFn so it exits to QEMU which
>> calls VFIO-IOMMUFD to bind the TDI.
>>
>> Now, RMPUPDATE need to be done, in some place on the way back to the guest.
>> Possible places are:
>> a) the VFIO-IOMMUFD bind handler (does not know GPAs);
>> b) QEMU (can mmapp MMIO and knows GPA);
> 
> Given the guest_memfd momentum to keep private memory unmapped from the
> host side do you expect to align with the DMABUF effort [1] to teach KVM
> about convertible MMIO where the expectation is that convertible MMIO
> need never be mmapped on the host side?


Well, I need to do better than the horrendous "[RFC PATCH v2 15/22] KVM: 
X86: Handle private MMIO as shared" and this one fits the purpose so 
yes. Thanks,

> 
> [1]: http://lore.kernel.org/20250123160827.GS5556@nvidia.com

-- 
Alexey


