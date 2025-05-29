Return-Path: <linux-arch+bounces-12129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B3AC77B0
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 07:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07DE7AC46E
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 05:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8B254AFF;
	Thu, 29 May 2025 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TDPGz99J"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9481253956;
	Thu, 29 May 2025 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496659; cv=fail; b=UAJdFXMg4C6y36VqmN3TMPWHxRXf6TxoF3IKDWZ7yBiXKT8Dqy9SoG3D8yVPcRdueARK+bxsL96PMQj3kdEvUMkdtuPUIKfumwtBLTJeajODUiPB2lwLLRTc6oHaT3k/Hn/7ngwDDGYmiIQ6RdcrF2ukWb5N4XB/arPZCGmCDoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496659; c=relaxed/simple;
	bh=xkTIJaEOrTzy/ZHEg7tZRRrinPryrQ2zbK9QZbxlXhY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j+f9TOI2xA55LOdH5yi/VrDCypngP7/x51eBlUS9Gbs5CNWk0TvlhEn2OZKU8CzGv9U5KxnFpuFWGaAmkhK4seHSNZ1u4e5rcH4cICTse78uaWSfCkEctNxi4jmevc3KupJo2w6MfWopRULf9+/lmsSesgp3qJsCmgkBiBegRFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TDPGz99J; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meGARn0VgzuNQtSAeotGuut0Zx69n74M9gVUjZOC4Lg3tTNnX7LMCTIb0azY5tjxUVc0Hi8s5Gw0bvhtdt8EyOSPqoOUQtZD/OWVfyfMDyiX6/LT1+4JQiFbPQF+iYTK67BTcJ/JfpzrFKHE+oxIX8xZavmzl6m/H+Pxh0r6yWmB2jXTsdk7uPe/jx7tCf/ZvoaWjBJS6otHp4Yoo8Zcz76KaWCE3znkP+MB+vqg9mz6UKGbG9quWKpnBSkOm4u3mAzIcxZZGfJHqnS3Kdqbt+4+tNT4FVNoBsqbN/EvA4U5bMvv7zS4cKg3o3u67m518myS8jr6hZLkmQ7TlxESpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCHM4tpod7LqofdXDPSVH08+A+VmcbfGSR1YRqvB7BU=;
 b=rdW+lf07hz/aAG2YxOwbo4B/jJQxrQY43WvCPg6iKpkh6MM0zwSr04jOtftRolvrUPFEZ4gIzK4/dmum1RKECbrkITBUM8T5rg+sXOzdSYIpBObQFMBZMVDwROn/hrjSrz9Gu5Ka+XY6oMD9hnCMzjaAk/dGEfg58yaTN2u4qCZW6bfpebn/yKabMciN6sx5Pv7ZS1J65HrlAnlwp1qawBvlJyDN2Y69tX1fbh3XHNHFMs+XFewOPDrdpeIQQXBN+0eO/RP9rf5KXZx2dEZKAMgrAABIwSKnWM+GPlPIq39LofiULJZsMZto66zojBud/Rx3ug16mgn1oaPxgCuOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCHM4tpod7LqofdXDPSVH08+A+VmcbfGSR1YRqvB7BU=;
 b=TDPGz99Jq3sEMtXIbnXTgM4aWUwveH9rxY129C8RQ04jXLvaqo2MhBZXysKZViaPb6zrjw5y2MnVUT2kzZUmFJ1nL23H9q8j3mKovYImla8OQavtKvcPAXuvfTv8L3TqIQ3gz1pXcuLvm6m8rRKzjWP2veZnVE39ueW5DGmY0ws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 05:30:51 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Thu, 29 May 2025
 05:30:51 +0000
Message-ID: <80719e67-2878-4118-9cc0-98779603702a@amd.com>
Date: Thu, 29 May 2025 15:30:41 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 07/22] coco/tsm: Add tsm and tsm-host modules
To: Zhi Wang <zhiw@nvidia.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Nikunj A Dadhania <nikunj@amd.com>, Michael Roth <michael.roth@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Joao Martins
 <joao.m.martins@oracle.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Steve Sistare <steven.sistare@oracle.com>, Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-coco@lists.linux.dev,
 AXu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-8-aik@amd.com>
 <20250514213943.49e1949c.zhiw@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250514213943.49e1949c.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY6PR01CA0036.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::23) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbb857f-7f4a-4e82-b41b-08dd9e71f887
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWdpS2xWVWUrc3JuZ1k3TXNyRGd5WmV3RUtTWGN5SllpVHZVM2lZaW9OOSt0?=
 =?utf-8?B?Yjc5ZGF3a2RsbEZ2TTZiL0JOQ0VaM3l2QTBKVFVGbXZuUWtwR2ZuZjZxWmRa?=
 =?utf-8?B?RG5HUUZ6U1VSRldUQTA0QUdCSFhJVW04UmVmbUJwL25HRE9JMDJSL1o2YXhU?=
 =?utf-8?B?TWUwMHZ2UWhOK1J6YmlRMkVLS1FhVy9SV3dEVCtEZ3Frb3VlYWlmSklzZzFK?=
 =?utf-8?B?R0cwTGZTRll2Wjdzc0UwUHRZYkc4WkhJdDFnVFNFRHRQd3FwbTE0USt0REhV?=
 =?utf-8?B?SnNuOVFvL1FPQVRTVVFFcithaHVvbU1xaUtBKzBTZEVrZmdVYlNyS2VmdUR6?=
 =?utf-8?B?eDZmVWswUG5rS1R1bGk5MnplSEpIMVVCaTQ0UEtEbC9iMnhKYXhYQ3h6a0Yx?=
 =?utf-8?B?RU40alhWN0RiZ2JWaHRzL1dYQ0tmMXFHaEdVejh5ZEFNOHZKOFk4VlRWS3JC?=
 =?utf-8?B?Sk9udTBweGJRQkVzdkJ5MWlzL0lyMkEyY0xSZHRBaEpOTmhQaXRCenZSUGdk?=
 =?utf-8?B?SWpjZFdTT0RkMjhxcTd6cVdJUU85MmhwUTFJYWxRWFRJenpMUVZacVhRSGZX?=
 =?utf-8?B?dk5ZVm9TblBDOHhyT3drNk9pMzZDUDJxbGxKV1J5R1FodDJxRUF4OUV5cU9q?=
 =?utf-8?B?Wk0zaXpkbE9NR3d2Z0hodEc1TXcvWGRTdDRxS0o3d25PQm5sSWxTQVY0MSt6?=
 =?utf-8?B?UDNiVkRYVHlqYmVvYmxoRFlHZHlpR0JzUDV4dVNjcDMwME0ra1pOdEoxYkRp?=
 =?utf-8?B?Tm8yNjJRbmRHRng1V1NoK3V5QnoyTlBFUGlSUzlrR2Z4eDVYNkYyRDh4Q1lr?=
 =?utf-8?B?M3o2T2Z4MlhrWEt2TkJsZ2MxQU1TSVJPczV3bDRDS2FKeHNhT2JnZ0Evdzdm?=
 =?utf-8?B?VGx3TlpMUUZzcVFtQmozaGdGNzNyNEloSGNRR1ozZWRRYmVQbUNLd1p1UjZw?=
 =?utf-8?B?MTNxVUdyMTBuL2ozYnNsNkZQMGRDZ3JzY1JjRWlEaUhvOUY3WDFzZWdKSmdU?=
 =?utf-8?B?Rk1WS2RVWnRNT1BkbHd4ZkFOT2toaHBWVHRJUkt2b2ZxeHlQem9EY1VMYWph?=
 =?utf-8?B?UDJXSEJ3RHEyaENGTHFndVdHelB1M0VDZ2prYTF6YUVsblRMdUorTVBiU1gx?=
 =?utf-8?B?VGlIU1orOURiWGpoVTIxZngwa1lGc2VlM0pwUEFZZGx1UjZhdHhYaHBpREN2?=
 =?utf-8?B?V3lJSVM2aHdVd1ZFZFYxT1VGNXR5MnVOT3dSdGxRYUN3VWdSSFRvN1B2WE83?=
 =?utf-8?B?bm9TbEowc01OOHRWTXZHWXNhY0VVa3hScUZWU0duK2FweGhHYU0xWXhIMWg3?=
 =?utf-8?B?YVpnbHlaTW9NVFZRUnB2UThyOGs5eTdISTlxekwveElHZFQzNTFhRWRRWkM1?=
 =?utf-8?B?WUx6MUZIL3pHRVhDOGZjaW56eFEvdi9WeHZmWkoyOFd6OHpwNmRhQTRNWDIv?=
 =?utf-8?B?dndXLzluendhcWN1SCtrUGVKZkVCNUtUR2lSRjNudU5NZklvTDc5cVpkWWI5?=
 =?utf-8?B?b0Q1SkVjK0VkUnQvZTIvdG8rOXRjVDE3L2NlWHZXNTB0YzVqOGJiQkVvbTdU?=
 =?utf-8?B?djNlR2NXREVyM2VpdWpmRUk4MGhzeWpSNU9tdzdGNG5ZakwxVHNYMEd0QTVK?=
 =?utf-8?B?K1hFTUdpY0IrcUVpODFpN3FwN1FQUHFHWTJNVkpUYjVuSEUxbXhWQXhiVDAr?=
 =?utf-8?B?MS8wbU5kSVFiak5Zdmp2TFczVzhIZitEOXUxSTM0OHVrUWZLeHRtNE1UWDVv?=
 =?utf-8?B?Y1c2K29yVnVqVDN1S1U3bWluemdZOW5jUElvNDUyV0pPOG01UE5KWUJSV1lu?=
 =?utf-8?B?ckRBUmdGdmdrOU1MckNiSU5TN2hCK2FJSFVaVWJyMzRKUnhubFRPcXhETGF1?=
 =?utf-8?Q?l78Xo4uKz/yIm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2xpUlovRFNXb2N2cEV4a2o3TE43KzNKc0JmTnNDRmlzbkVvWkdwRk5yTVFY?=
 =?utf-8?B?VXZwaUloRmU5ZTN5VExWU08xN2w0elEzSkRnQU53dmFNMURBbyttdHNZQld2?=
 =?utf-8?B?SEVzVXFXM2Vld21MZ3FCQXIrblBpWmRuZURUMk9iVEFNR1A5V3Y0MEtzZVdX?=
 =?utf-8?B?SzQyN0srWnBFMEhONnM2RkpPOFpZdjJEdWMzT1JNNUVQanBWTG1leXVIQVpM?=
 =?utf-8?B?M2NQb0p1MFlCZGJnQ3AxY2c4b2ZHUGp3d3lPUmthbHA1NVlHaGZ3d1pXU1Bq?=
 =?utf-8?B?dGkzTno4MjdRUjErVjNSMnJ5MjJUTEsxZmdYbll6NlR2NXpMaWN2T3JNTjZp?=
 =?utf-8?B?QWtmaWlzZkxSb0JjSk1KVElTdjZ4Z09vUkJsTDJsUGZZQlNkSXpPNlRZZFIr?=
 =?utf-8?B?V2pLMGpYcGsvWFJ2aEhuMHJicTg2MkQwai9CTEswTHFtTnRPeUtUV29NVm5D?=
 =?utf-8?B?b084aE4yZU9aVVhET0J4OXpteG9hR0VPcEQ1MU5lcDNCcjRtTlZUT2hoUlpI?=
 =?utf-8?B?UTNIQktnUm9pK2I3OWNEbHFQcG9IeEoveFR3TWx0Yk5kYmsxL0lrZUIrcWJu?=
 =?utf-8?B?SjNlSUNxMDk3enU1WXQydW5TRVRabTNwSjBTcGt1bTcrL0hFVllQSzZaMEY2?=
 =?utf-8?B?T3lnRm1sL2FzT29lQUJCV2gzL1ZoR1c3bko0N2R4WEIyUWRTQjBiZmRFSzR6?=
 =?utf-8?B?dExxelAxQTBtZU1GTGhZdkx4TS9Zam9KRkdHZXlHNVVKYWt5UGFZc1NHcnQz?=
 =?utf-8?B?OStPdDB3ZGVlWlVYWU1uT1Nod1d1YVg5SG1jYnhaY3N4ejRNVmk0aVppSmxD?=
 =?utf-8?B?azdoTVZra2h0dHdZSGdUSFpGMmJqOGZ4OHB0TmsvMHczSUdubm5ONnIxbVM1?=
 =?utf-8?B?VzJuRkpWMFoyMmFmZlMvWWVXT3BhQXpuZTNmWWlJekxEdW5nM1MvbzhBNmJs?=
 =?utf-8?B?QXVldUsxSHlOMDRDWFN6dEZTcVVDUGpLdzRQaHNyVEd5b1FHMjJVVnhsOVJw?=
 =?utf-8?B?a2xvSTRvNnpLSHpmcjM0L0s0QndHRUpVWDhVSTJzOVBBKytBRkdPekN1L05m?=
 =?utf-8?B?bnRoTzR3WlBCZHIwdGJtRGFVcVBMbDcwMU9weDdUYVIxMWxoQVFRbjU1Ni9n?=
 =?utf-8?B?MWY2QnMrZG1Sc2V0TDZFUy9kYm5UUkpZV1liUDRoNVUzbHVCcGdtbWg0RExR?=
 =?utf-8?B?SWhRVEZ3RG9vTHlVMDlWZ3BhWGs1SFFIQkx3RWxtNUhlcjNXYzBFTnpzMG4w?=
 =?utf-8?B?b21YdVlHQW5ldm9halE2aklxZXlSYWpVazZUUGdZSjlMeWw1MEdxb0xlaVBq?=
 =?utf-8?B?czRuQVlDNmR6MWlyUVdXd0d2MzJ5TzBaaEhPYlRKV0RrZk5qZEVGN1dwdGc4?=
 =?utf-8?B?bjI4UWM3ZldYZ0lPNXU2RE4rRkJuTWdYNi9vaHFzeHpuTEJWeGs0Q3lWWjMz?=
 =?utf-8?B?VVNzb0U0VWZvaEYybGlKY0ZvSVRVaEt3SG9nc1dUNGN0cVFJbDd5OXAxRkx6?=
 =?utf-8?B?V25POS9sWU0yUXk3bkE0TVdDKzFwUUtvN0tjcXhscFRnUW81WXBVdUdwcmhB?=
 =?utf-8?B?RWt6Y3E0TlNDVkxkS3RSbFhiYm56dlU0YW8rUC9xWkZNOUphSTZjZVBXL3Uy?=
 =?utf-8?B?S0ZZSHhWa092cThPQW40UzV4NUF5bFRZRVI5WDROZ3pZUDRTNDVHYXNXc0lV?=
 =?utf-8?B?MmpGRVdUYlBiWHlMNjEzUVF1ZExabG5uRzhsZGdEY05QR3M3RStqUURGTEJm?=
 =?utf-8?B?V3ZGMmFhSzNNbENqQmRxa2gvL3FjQkVWRmNCaVhxS2xsam11Qjg3Y3BMbDZz?=
 =?utf-8?B?NSs4Z3lJdWRzZjNhVFdpL0VxbEZ3NEhhZlJEN3Fla0cySjNoTVV0MFU0VjJa?=
 =?utf-8?B?cmlQaDIveTRTQkpjQ1E4b3Q1SGUzejZ1bmtabFhXcUVhNU5Gb1ViakVWbTNG?=
 =?utf-8?B?aFo5Y2o1OFZNNitpQ3NFY3YvYzRvMEhJMC9wcS96em1nRFFBeDQxZUFoUyt5?=
 =?utf-8?B?eldpSFlJSEpib29CV0p0RU1Wa1EwUGhid0tYT0M3VnRuSWtYWWo3cW9qMFBR?=
 =?utf-8?B?Zkc2ZFZMOTJuOWFkZVlUTGdYbGJjQkREczN2Qy9COFB6dUQvamZBOWpmU1Fu?=
 =?utf-8?Q?W44wYFnAZf429AlI1xez5GiCF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbb857f-7f4a-4e82-b41b-08dd9e71f887
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:30:49.8211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9Dy2iQw9x/7AJf9lioelWugclo/dcNlSsRAJJTVsOvoi0n9c41E37i13ZvDFNDLrcwcBFQqUpR7j+s7hQvxPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884



On 15/5/25 04:39, Zhi Wang wrote:
> On Tue, 18 Feb 2025 22:09:54 +1100
> Alexey Kardashevskiy <aik@amd.com> wrote:
> 
>> The TSM module is a library to create sysfs nodes common for
>> hypervisors and VMs. It also provides helpers to parse interface
>> reports (required by VMs, visible to HVs). It registers 3 device
>> classes:
>> - tsm: one per platform,
>> - tsm-dev: for physical functions, ("TDEV");
>> - tdm-tdi: for PCI functions being assigned to VMs ("TDI").
>>
>> The library adds a child device of "tsm-dev" or/and "tsm-tdi" class
>> for every capable PCI device. Note that the module is made
>> bus-agnostic.
>>
>> New device nodes provide sysfs interface for fetching device
>> certificates and measurements and TDI interface reports.
>> Nodes with the "_user" suffix provide human-readable information,
>> without that suffix it is raw binary data to be copied to a guest.
>>
>> The TSM-HOST module adds hypervisor-only functionality on top. At the
>> moment it is:
>> - "connect" to enable/disable IDE (a PCI link encryption);
>> - "TDI bind" to manage a PCI function passed through to a secure VM.
>>
>> A platform is expected to register itself in TSM-HOST and provide
>> necessary callbacks. No platform is added here, AMD SEV is coming in
>> the next patches.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>   drivers/virt/coco/Makefile        |   2 +
>>   drivers/virt/coco/host/Makefile   |   6 +
>>   include/linux/tsm.h               | 295 +++++++++
>>   drivers/virt/coco/host/tsm-host.c | 552 +++++++++++++++++
>>   drivers/virt/coco/tsm.c           | 636 ++++++++++++++++++++
>>   Documentation/virt/coco/tsm.rst   |  99 +++
>>   drivers/virt/coco/Kconfig         |  14 +
>>   drivers/virt/coco/host/Kconfig    |   6 +
>>   8 files changed, 1610 insertions(+)
>>
>> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
>> index 885c9ef4e9fc..670f77c564e8 100644
>> --- a/drivers/virt/coco/Makefile
>> +++ b/drivers/virt/coco/Makefile
>> @@ -2,9 +2,11 @@
>>   #
>>   # Confidential computing related collateral
>>   #
>> +obj-$(CONFIG_TSM)		+= tsm.o
>>   obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>>   obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>>   obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>>   obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>>   obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
>>   obj-$(CONFIG_TSM_REPORTS)	+= guest/
>> +obj-$(CONFIG_TSM_HOST)          += host/
>> diff --git a/drivers/virt/coco/host/Makefile
>> b/drivers/virt/coco/host/Makefile new file mode 100644
>> index 000000000000..c5e216b6cb1c
>> --- /dev/null
>> +++ b/drivers/virt/coco/host/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# TSM (TEE Security Manager) Common infrastructure and host drivers
>> +
>> +obj-$(CONFIG_TSM_HOST) += tsm_host.o
>> +tsm_host-y += tsm-host.o
>> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
>> index 431054810dca..486e386d90fc 100644
>> --- a/include/linux/tsm.h
>> +++ b/include/linux/tsm.h
>> @@ -5,6 +5,11 @@
>>   #include <linux/sizes.h>
>>   #include <linux/types.h>
>>   #include <linux/uuid.h>
>> +#include <linux/device.h>
>> +#include <linux/slab.h>
>> +#include <linux/mutex.h>
>> +#include <linux/device.h>
>> +#include <linux/bitfield.h>
>>   
>>   #define TSM_REPORT_INBLOB_MAX 64
>>   #define TSM_REPORT_OUTBLOB_MAX SZ_32K
>> @@ -109,4 +114,294 @@ struct tsm_report_ops {
>>   
>>   int tsm_report_register(const struct tsm_report_ops *ops, void
>> *priv); int tsm_report_unregister(const struct tsm_report_ops *ops);
>> +
>> +/* SPDM control structure for DOE */
>> +struct tsm_spdm {
>> +	unsigned long req_len;
>> +	void *req;
>> +	unsigned long rsp_len;
>> +	void *rsp;
>> +};
>> +
>> +/* Data object for measurements/certificates/attestationreport */
>> +struct tsm_blob {
>> +	void *data;
>> +	size_t len;
>> +};
>> +
>> +struct tsm_blob *tsm_blob_new(void *data, size_t len);
>> +static inline void tsm_blob_free(struct tsm_blob *b)
>> +{
>> +	kfree(b);
>> +}
>> +
>> +/**
>> + * struct tdisp_interface_id - TDISP INTERFACE_ID Definition
>> + *
>> + * @function_id: Identifies the function of the device hosting the
>> TDI
>> + *   15:0: @rid: Requester ID
>> + *   23:16: @rseg: Requester Segment (Reserved if Requester Segment
>> Valid is Clear)
>> + *   24: @rseg_valid: Requester Segment Valid
>> + *   31:25 – Reserved
>> + * 8B - Reserved
>> + */
>> +struct tdisp_interface_id {
>> +	u32 function_id; /* TSM_TDISP_IID_xxxx */
>> +	u8 reserved[8];
>> +} __packed;
>> +
>> +#define TSM_TDISP_IID_REQUESTER_ID	GENMASK(15, 0)
>> +#define TSM_TDISP_IID_RSEG		GENMASK(23, 16)
>> +#define TSM_TDISP_IID_RSEG_VALID	BIT(24)
>> +
> 
> I would suggest that we have separate header files for spec
> definitions. E.g. tdisp_defs and spdm_defs.h. from the maintainability
> perspective.

True as this shares bits and pieces with Lukas'es CMA.

>> +/*
>> + * Measurement block as defined in SPDM DSP0274.
>> + */
>> +struct spdm_measurement_block_header {
>> +	u8 index;
>> +	u8 spec; /* MeasurementSpecification */
>> +	u16 size;
>> +} __packed;
>> +
> 
> ....
> 
>> +struct tsm_hv_ops {
>> +	int (*dev_connect)(struct tsm_dev *tdev, void *private_data);
>> +	int (*dev_disconnect)(struct tsm_dev *tdev);
>> +	int (*dev_status)(struct tsm_dev *tdev, struct
>> tsm_dev_status *s);
>> +	int (*dev_measurements)(struct tsm_dev *tdev);
>> +	int (*tdi_bind)(struct tsm_tdi *tdi, u32 bdfn, u64 vmid);
>> +	int (*tdi_unbind)(struct tsm_tdi *tdi);
>> +	int (*guest_request)(struct tsm_tdi *tdi, u8 __user *req,
>> size_t reqlen,
>> +			     u8 __user *rsp, size_t rsplen, int
>> *fw_err);
>> +	int (*tdi_status)(struct tsm_tdi *tdi, struct tsm_tdi_status
>> *ts); +};
>> +
> 
> 1) Looks we have two more callbacks besides TDI verbs, I think they are
> fine to be in TSM driver ops.
> 
> For guest_request(), anyway, we need an entry point for QEMU to
> reach the TSM services in the kernel. Looks like almost all the platform
> (Intel/AMD/ARM) have TVM-HOST paths, which will exit to QEMU from KVM,
> and QEMU reaches the TSM services and return to the TVM. I think they
> can all leverage the entry point (IOMMUFD) via the guest request ioctl.
> And IOMMUFD almost have all the stuff QEMU needs.
> 
> Or we would end up with QEMU reaches to different entry points in
> per-vendor code path, which was not preferable, backing to the
> period when enabling CC in QEMU.
> 
> 2) Also, it is better that we have separate the tsm_guest and tsm_host
> headers since the beginning.

+1.

> 3) How do you trigger the TDI_BIND from the guest in the late-bind
> model? Was looking at tsm_vm_ops, but seems not found yet.

It is implicit - to trigger TDI_BIND, the SNP VM needs to request TDI info (via GHCB) which exits to QEMU and QEMU then binds the TDI (if not bound already). This is made so in assumption that the VM is not just curious "what devices can be possibly trused" (the VM knows it from the PCIe capability) so it works.

How exactly the VM is going to trigger is a big questions, right now I have a hack to do that when the guest driver enables bus master and the TSM module(s) need to be loaded first. (we discussed elsewhere, just keeping it here for a record).



>> +struct tsm_subsys {
>> +	struct device dev;
>> +	struct list_head tdi_head;
>> +	struct mutex lock;
>> +	const struct attribute_group *tdev_groups[3]; /* Common,
>> host/guest, NULL */
>> +	const struct attribute_group *tdi_groups[3]; /* Common,
>> host/guest, NULL */
>> +	int (*update_measurements)(struct tsm_dev *tdev);
>> +};
>> +
>> +struct tsm_subsys *tsm_register(struct device *parent, size_t extra,
>> +				const struct attribute_group
>> *tdev_ag,
>> +				const struct attribute_group *tdi_ag,
>> +				int (*update_measurements)(struct
>> tsm_dev *tdev)); +void tsm_unregister(struct tsm_subsys *subsys);
>> +
>> +struct tsm_host_subsys;
>> +struct tsm_host_subsys *tsm_host_register(struct device *parent,
>> +					  struct tsm_hv_ops *hvops,
>> +					  void *private_data);
>> +struct tsm_dev *tsm_dev_get(struct device *dev);
>> +void tsm_dev_put(struct tsm_dev *tdev);
>> +struct tsm_tdi *tsm_tdi_get(struct device *dev);
>> +void tsm_tdi_put(struct tsm_tdi *tdi);
>> +
>> +struct pci_dev;
>> +int pci_dev_tdi_validate(struct pci_dev *pdev, bool invalidate);
>> +int pci_dev_tdi_mmio_config(struct pci_dev *pdev, u32 range_id, bool
>> tee); +
>> +int tsm_dev_init(struct tsm_bus_subsys *tsm_bus, struct device
>> *parent,
>> +		 size_t busdatalen, struct tsm_dev **ptdev);
>> +void tsm_dev_free(struct tsm_dev *tdev);
>> +int tsm_tdi_init(struct tsm_dev *tdev, struct device *dev);
>> +void tsm_tdi_free(struct tsm_tdi *tdi);
>> +
>> +/* IOMMUFD vIOMMU helpers */
>> +int tsm_tdi_bind(struct tsm_tdi *tdi, u32 guest_rid, int kvmfd);
>> +void tsm_tdi_unbind(struct tsm_tdi *tdi);
>> +int tsm_guest_request(struct tsm_tdi *tdi, u8 __user *req, size_t
>> reqlen,
>> +		      u8 __user *res, size_t reslen, int *fw_err);
>> +
>> +/* Debug */
>> +ssize_t tsm_report_gen(struct tsm_blob *report, char *b, size_t len);
>> +
>> +/* IDE */
>> +int tsm_create_link(struct tsm_subsys *tsm, struct device *dev,
>> const char *name); +void tsm_remove_link(struct tsm_subsys *tsm,
>> const char *name); +#define tsm_register_ide_stream(tdev, ide) \
>> +	tsm_create_link((tdev)->tsm, &(tdev)->dev, (ide)->name)
>> +#define tsm_unregister_ide_stream(tdev, ide) \
>> +	tsm_remove_link((tdev)->tsm, (ide)->name)
>> +
>>   #endif /* __TSM_H */
>> diff --git a/drivers/virt/coco/host/tsm-host.c
>> b/drivers/virt/coco/host/tsm-host.c new file mode 100644
>> index 000000000000..80f3315fb195
>> --- /dev/null
>> +++ b/drivers/virt/coco/host/tsm-host.c
>> @@ -0,0 +1,552 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/module.h>
>> +#include <linux/tsm.h>
>> +#include <linux/file.h>
>> +#include <linux/kvm_host.h>
>> +
>> +#define DRIVER_VERSION	"0.1"
>> +#define DRIVER_AUTHOR	"aik@amd.com"
>> +#define DRIVER_DESC	"TSM host library"
>> +
>> +struct tsm_host_subsys {
>> +	struct tsm_subsys base;
>> +	struct tsm_hv_ops *ops;
>> +	void *private_data;
>> +};
>> +
>> +static int tsm_dev_connect(struct tsm_dev *tdev)
>> +{
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	int ret;
>> +
>> +	if (WARN_ON(!hsubsys->ops->dev_connect))
>> +		return -EPERM;
>> +
>> +	if (WARN_ON(!tdev->tsm_bus))
>> +		return -EPERM;
>> +
>> +	mutex_lock(&tdev->spdm_mutex);
>> +	while (1) {
>> +		ret = hsubsys->ops->dev_connect(tdev,
>> hsubsys->private_data);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		ret = tdev->tsm_bus->ops->spdm_forward(&tdev->spdm,
>> ret);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +	mutex_unlock(&tdev->spdm_mutex);
>> +
>> +	tdev->connected = (ret == 0);
>> +
>> +	return ret;
>> +}
>> +
>> +static int tsm_dev_reclaim(struct tsm_dev *tdev)
>> +{
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	int ret;
>> +
>> +	if (WARN_ON(!hsubsys->ops->dev_disconnect))
>> +		return -EPERM;
>> +
>> +	/* Do not disconnect with active TDIs */
>> +	if (tdev->bound)
>> +		return -EBUSY;
>> +
> 
> Can this replace a lock? refcount is to track the life cycle,
> lock is to avoid racing. Think that we just pass here tdev->bound
> == 0, take the spdm_mutex and request the TSM to talk to the device
> for disconnection, while someone is calling tdi_bind and pass the
> tdev->connected check and waiting for the spdm_mutex to do the
> tdi_bind. The device might see a TDI_BIND after a DEVICE_DISCONNECT.

You're right, requires fixing. Thanks,


> 
> Z.
>> +	mutex_lock(&tdev->spdm_mutex);
>> +	while (1) {
>> +		ret = hsubsys->ops->dev_disconnect(tdev);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		ret = tdev->tsm_bus->ops->spdm_forward(&tdev->spdm,
>> ret);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +	mutex_unlock(&tdev->spdm_mutex);
>> +
>> +	if (!ret)
>> +		tdev->connected = false;
>> +
>> +	return ret;
>> +}
>> +
>> +static int tsm_dev_status(struct tsm_dev *tdev, struct
>> tsm_dev_status *s) +{
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm; +
>> +	if (WARN_ON(!hsubsys->ops->dev_status))
>> +		return -EPERM;
>> +
>> +	return hsubsys->ops->dev_status(tdev, s);
>> +}
>> +
>> +static int tsm_tdi_measurements_locked(struct tsm_dev *tdev)
>> +{
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	int ret;
>> +
>> +	while (1) {
>> +		ret = hsubsys->ops->dev_measurements(tdev);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		ret = tdev->tsm_bus->ops->spdm_forward(&tdev->spdm,
>> ret);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static void tsm_tdi_reclaim(struct tsm_tdi *tdi)
>> +{
>> +	struct tsm_dev *tdev = tdi->tdev;
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	int ret;
>> +
>> +	if (WARN_ON(!hsubsys->ops->tdi_unbind))
>> +		return;
>> +
>> +	mutex_lock(&tdi->tdev->spdm_mutex);
>> +	while (1) {
>> +		ret = hsubsys->ops->tdi_unbind(tdi);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		ret =
>> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +	mutex_unlock(&tdi->tdev->spdm_mutex);
>> +}
>> +
>> +static int tsm_tdi_status(struct tsm_tdi *tdi, void *private_data,
>> struct tsm_tdi_status *ts) +{
>> +	struct tsm_tdi_status tstmp = { 0 };
>> +	struct tsm_dev *tdev = tdi->tdev;
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	int ret;
>> +
>> +	mutex_lock(&tdi->tdev->spdm_mutex);
>> +	while (1) {
>> +		ret = hsubsys->ops->tdi_status(tdi, &tstmp);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		ret =
>> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +	mutex_unlock(&tdi->tdev->spdm_mutex);
>> +
>> +	if (!ret)
>> +		*ts = tstmp;
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t tsm_cert_slot_store(struct device *dev, struct
>> device_attribute *attr,
>> +				   const char *buf, size_t count)
>> +{
>> +	struct tsm_dev *tdev = container_of(dev, struct tsm_dev,
>> dev);
>> +	ssize_t ret = count;
>> +	unsigned long val;
>> +
>> +	if (kstrtoul(buf, 0, &val) < 0)
>> +		ret = -EINVAL;
>> +	else
>> +		tdev->cert_slot = val;
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t tsm_cert_slot_show(struct device *dev, struct
>> device_attribute *attr, char *buf) +{
>> +	struct tsm_dev *tdev = container_of(dev, struct tsm_dev,
>> dev);
>> +	ssize_t ret = sysfs_emit(buf, "%u\n", tdev->cert_slot);
>> +
>> +	return ret;
>> +}
>> +
>> +static DEVICE_ATTR_RW(tsm_cert_slot);
>> +
>> +static ssize_t tsm_dev_connect_store(struct device *dev, struct
>> device_attribute *attr,
>> +				     const char *buf, size_t count)
>> +{
>> +	struct tsm_dev *tdev = container_of(dev, struct tsm_dev,
>> dev);
>> +	unsigned long val;
>> +	ssize_t ret = -EIO;
>> +
>> +	if (kstrtoul(buf, 0, &val) < 0)
>> +		ret = -EINVAL;
>> +	else if (val && !tdev->connected)
>> +		ret = tsm_dev_connect(tdev);
>> +	else if (!val && tdev->connected)
>> +		ret = tsm_dev_reclaim(tdev);
>> +
>> +	if (!ret)
>> +		ret = count;
>> +
>> +	return ret;
>> +}
>> +
>> +static ssize_t tsm_dev_connect_show(struct device *dev, struct
>> device_attribute *attr, char *buf) +{
>> +	struct tsm_dev *tdev = container_of(dev, struct tsm_dev,
>> dev);
>> +	ssize_t ret = sysfs_emit(buf, "%u\n", tdev->connected);
>> +
>> +	return ret;
>> +}
>> +
>> +static DEVICE_ATTR_RW(tsm_dev_connect);
>> +
>> +static ssize_t tsm_dev_status_show(struct device *dev, struct
>> device_attribute *attr, char *buf) +{
>> +	struct tsm_dev *tdev = container_of(dev, struct tsm_dev,
>> dev);
>> +	struct tsm_dev_status s = { 0 };
>> +	int ret = tsm_dev_status(tdev, &s);
>> +	ssize_t ret1;
>> +
>> +	ret1 = sysfs_emit(buf, "ret=%d\n"
>> +			  "ctx_state=%x\n"
>> +			  "tc_mask=%x\n"
>> +			  "certs_slot=%x\n"
>> +			  "device_id=%x:%x.%d\n"
>> +			  "segment_id=%x\n"
>> +			  "no_fw_update=%x\n",
>> +			  ret,
>> +			  s.ctx_state,
>> +			  s.tc_mask,
>> +			  s.certs_slot,
>> +			  (s.device_id >> 8) & 0xff,
>> +			  (s.device_id >> 3) & 0x1f,
>> +			  s.device_id & 0x07,
>> +			  s.segment_id,
>> +			  s.no_fw_update);
>> +
>> +	tsm_dev_put(tdev);
>> +	return ret1;
>> +}
>> +
>> +static DEVICE_ATTR_RO(tsm_dev_status);
>> +
>> +static struct attribute *host_dev_attrs[] = {
>> +	&dev_attr_tsm_cert_slot.attr,
>> +	&dev_attr_tsm_dev_connect.attr,
>> +	&dev_attr_tsm_dev_status.attr,
>> +	NULL,
>> +};
>> +static const struct attribute_group host_dev_group = {
>> +	.attrs = host_dev_attrs,
>> +};
>> +
>> +static ssize_t tsm_tdi_bind_show(struct device *dev, struct
>> device_attribute *attr, char *buf) +{
>> +	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
>> +
>> +	if (!tdi->kvm)
>> +		return sysfs_emit(buf, "not bound\n");
>> +
>> +	return sysfs_emit(buf, "VM=%p BDFn=%x:%x.%d\n",
>> +			  tdi->kvm,
>> +			  (tdi->guest_rid >> 8) & 0xff,
>> +			  (tdi->guest_rid >> 3) & 0x1f,
>> +			  tdi->guest_rid & 0x07);
>> +}
>> +
>> +static DEVICE_ATTR_RO(tsm_tdi_bind);
>> +
>> +static char *spdm_algos_to_str(u64 algos, char *buf, size_t len)
>> +{
>> +	size_t n = 0;
>> +
>> +	buf[0] = 0;
>> +#define __ALGO(x) do {
>> 			\
>> +		if ((n < len) && (algos & (1ULL <<
>> (TSM_TDI_SPDM_ALGOS_##x))))	\
>> +			n += snprintf(buf + n, len - n, #x"
>> ");			\
>> +	} while (0)
>> +
>> +	__ALGO(DHE_SECP256R1);
>> +	__ALGO(DHE_SECP384R1);
>> +	__ALGO(AEAD_AES_128_GCM);
>> +	__ALGO(AEAD_AES_256_GCM);
>> +	__ALGO(ASYM_TPM_ALG_RSASSA_3072);
>> +	__ALGO(ASYM_TPM_ALG_ECDSA_ECC_NIST_P256);
>> +	__ALGO(ASYM_TPM_ALG_ECDSA_ECC_NIST_P384);
>> +	__ALGO(HASH_TPM_ALG_SHA_256);
>> +	__ALGO(HASH_TPM_ALG_SHA_384);
>> +	__ALGO(KEY_SCHED_SPDM_KEY_SCHEDULE);
>> +#undef __ALGO
>> +	return buf;
>> +}
>> +
>> +static const char *tdisp_state_to_str(enum tsm_tdisp_state state)
>> +{
>> +	switch (state) {
>> +#define __ST(x) case TDISP_STATE_##x: return #x
>> +	case TDISP_STATE_UNAVAIL: return "TDISP state unavailable";
>> +	__ST(CONFIG_UNLOCKED);
>> +	__ST(CONFIG_LOCKED);
>> +	__ST(RUN);
>> +	__ST(ERROR);
>> +#undef __ST
>> +	default: return "unknown";
>> +	}
>> +}
>> +
>> +static ssize_t tsm_tdi_status_user_show(struct device *dev,
>> +					struct device_attribute
>> *attr,
>> +					char *buf)
>> +{
>> +	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
>> +	struct tsm_dev *tdev = tdi->tdev;
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	struct tsm_tdi_status ts = { 0 };
>> +	char algos[256] = "";
>> +	unsigned int n, m;
>> +	int ret;
>> +
>> +	ret = tsm_tdi_status(tdi, hsubsys->private_data, &ts);
>> +	if (ret < 0)
>> +		return sysfs_emit(buf, "ret=%d\n\n", ret);
>> +
>> +	if (!ts.valid)
>> +		return sysfs_emit(buf, "ret=%d\nstate=%d:%s\n",
>> +				  ret, ts.state,
>> tdisp_state_to_str(ts.state)); +
>> +	n = snprintf(buf, PAGE_SIZE,
>> +		     "ret=%d\n"
>> +		     "state=%d:%s\n"
>> +		     "meas_digest_fresh=%x\n"
>> +		     "meas_digest_valid=%x\n"
>> +		     "all_request_redirect=%x\n"
>> +		     "bind_p2p=%x\n"
>> +		     "lock_msix=%x\n"
>> +		     "no_fw_update=%x\n"
>> +		     "cache_line_size=%d\n"
>> +		     "algos=%#llx:%s\n"
>> +		     "report_counter=%lld\n"
>> +		     ,
>> +		     ret,
>> +		     ts.state, tdisp_state_to_str(ts.state),
>> +		     ts.meas_digest_fresh,
>> +		     ts.meas_digest_valid,
>> +		     ts.all_request_redirect,
>> +		     ts.bind_p2p,
>> +		     ts.lock_msix,
>> +		     ts.no_fw_update,
>> +		     ts.cache_line_size,
>> +		     ts.spdm_algos, spdm_algos_to_str(ts.spdm_algos,
>> algos, sizeof(algos) - 1),
>> +		     ts.intf_report_counter);
>> +
>> +	n += snprintf(buf + n, PAGE_SIZE - n, "Certs digest: ");
>> +	m = hex_dump_to_buffer(ts.certs_digest,
>> sizeof(ts.certs_digest), 32, 1,
>> +			       buf + n, PAGE_SIZE - n, false);
>> +	n += min(PAGE_SIZE - n, m);
>> +	n += snprintf(buf + n, PAGE_SIZE - n, "...\nMeasurements
>> digest: ");
>> +	m = hex_dump_to_buffer(ts.meas_digest,
>> sizeof(ts.meas_digest), 32, 1,
>> +			       buf + n, PAGE_SIZE - n, false);
>> +	n += min(PAGE_SIZE - n, m);
>> +	n += snprintf(buf + n, PAGE_SIZE - n, "...\nInterface report
>> digest: ");
>> +	m = hex_dump_to_buffer(ts.interface_report_digest,
>> sizeof(ts.interface_report_digest),
>> +			       32, 1, buf + n, PAGE_SIZE - n, false);
>> +	n += min(PAGE_SIZE - n, m);
>> +	n += snprintf(buf + n, PAGE_SIZE - n, "...\n");
>> +
>> +	return n;
>> +}
>> +
>> +static DEVICE_ATTR_RO(tsm_tdi_status_user);
>> +
>> +static ssize_t tsm_tdi_status_show(struct device *dev, struct
>> device_attribute *attr, char *buf) +{
>> +	struct tsm_tdi *tdi = container_of(dev, struct tsm_tdi, dev);
>> +	struct tsm_dev *tdev = tdi->tdev;
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	struct tsm_tdi_status ts = { 0 };
>> +	u8 state;
>> +	int ret;
>> +
>> +	ret = tsm_tdi_status(tdi, hsubsys->private_data, &ts);
>> +	if (ret)
>> +		return ret;
>> +
>> +	state = ts.state;
>> +	memcpy(buf, &state, sizeof(state));
>> +
>> +	return sizeof(state);
>> +}
>> +
>> +static DEVICE_ATTR_RO(tsm_tdi_status);
>> +
>> +static struct attribute *host_tdi_attrs[] = {
>> +	&dev_attr_tsm_tdi_bind.attr,
>> +	&dev_attr_tsm_tdi_status_user.attr,
>> +	&dev_attr_tsm_tdi_status.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group host_tdi_group = {
>> +	.attrs = host_tdi_attrs,
>> +};
>> +
>> +int tsm_tdi_bind(struct tsm_tdi *tdi, u32 guest_rid, int kvmfd)
>> +{
>> +	struct tsm_dev *tdev = tdi->tdev;
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	struct fd f = fdget(kvmfd);
>> +	struct kvm *kvm;
>> +	u64 vmid;
>> +	int ret;
>> +
>> +	if (!fd_file(f))
>> +		return -EBADF;
>> +
>> +	if (!file_is_kvm(fd_file(f))) {
>> +		ret = -EBADF;
>> +		goto out_fput;
>> +	}
>> +
>> +	kvm = fd_file(f)->private_data;
>> +	if (!kvm || !kvm_get_kvm_safe(kvm)) {
>> +		ret = -EFAULT;
>> +		goto out_fput;
>> +	}
>> +
>> +	vmid = kvm_arch_tsm_get_vmid(kvm);
>> +	if (!vmid) {
>> +		ret = -EFAULT;
>> +		goto out_kvm_put;
>> +	}
>> +
>> +	if (WARN_ON(!hsubsys->ops->tdi_bind)) {
>> +		ret = -EPERM;
>> +		goto out_kvm_put;
>> +	}
>> +
>> +	if (!tdev->connected) {
>> +		ret = -EIO;
>> +		goto out_kvm_put;
>> +	}
>> +
>> +	mutex_lock(&tdi->tdev->spdm_mutex);
>> +	while (1) {
>> +		ret = hsubsys->ops->tdi_bind(tdi, guest_rid, vmid);
>> +		if (ret < 0)
>> +			break;
>> +
>> +		if (!ret)
>> +			break;
>> +
>> +		ret =
>> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm, ret);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +	mutex_unlock(&tdi->tdev->spdm_mutex);
>> +
>> +	if (ret) {
>> +		tsm_tdi_unbind(tdi);
>> +		goto out_kvm_put;
>> +	}
>> +
>> +	tdi->guest_rid = guest_rid;
>> +	tdi->kvm = kvm;
>> +	++tdi->tdev->bound;
>> +	goto out_fput;
>> +
>> +out_kvm_put:
>> +	kvm_put_kvm(kvm);
>> +out_fput:
>> +	fdput(f);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_tdi_bind);
>> +
>> +void tsm_tdi_unbind(struct tsm_tdi *tdi)
>> +{
>> +	if (tdi->kvm) {
>> +		tsm_tdi_reclaim(tdi);
>> +		--tdi->tdev->bound;
>> +		kvm_put_kvm(tdi->kvm);
>> +		tdi->kvm = NULL;
>> +	}
>> +
>> +	tdi->guest_rid = 0;
>> +	tdi->dev.parent->tdi_enabled = false;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_tdi_unbind);
>> +
>> +int tsm_guest_request(struct tsm_tdi *tdi, u8 __user *req, size_t
>> reqlen,
>> +		      u8 __user *res, size_t reslen, int *fw_err)
>> +{
>> +	struct tsm_dev *tdev = tdi->tdev;
>> +	struct tsm_host_subsys *hsubsys = (struct tsm_host_subsys *)
>> tdev->tsm;
>> +	int ret;
>> +
>> +	if (!hsubsys->ops->guest_request)
>> +		return -EPERM;
>> +
>> +	mutex_lock(&tdi->tdev->spdm_mutex);
>> +	while (1) {
>> +		ret = hsubsys->ops->guest_request(tdi, req, reqlen,
>> +						  res, reslen,
>> fw_err);
>> +		if (ret <= 0)
>> +			break;
>> +
>> +		ret =
>> tdi->tdev->tsm_bus->ops->spdm_forward(&tdi->tdev->spdm,
>> +							    ret);
>> +		if (ret < 0)
>> +			break;
>> +	}
>> +
>> +	mutex_unlock(&tdi->tdev->spdm_mutex);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_guest_request);
>> +
>> +struct tsm_host_subsys *tsm_host_register(struct device *parent,
>> +					  struct tsm_hv_ops *hvops,
>> +					  void *private_data)
>> +{
>> +	struct tsm_subsys *subsys = tsm_register(parent,
>> sizeof(struct tsm_host_subsys),
>> +						 &host_dev_group,
>> &host_tdi_group,
>> +
>> tsm_tdi_measurements_locked);
>> +	struct tsm_host_subsys *hsubsys;
>> +
>> +	hsubsys = (struct tsm_host_subsys *) subsys;
>> +
>> +	if (IS_ERR(hsubsys))
>> +		return hsubsys;
>> +
>> +	hsubsys->ops = hvops;
>> +	hsubsys->private_data = private_data;
>> +
>> +	return hsubsys;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_host_register);
>> +
>> +static int __init tsm_init(void)
>> +{
>> +	int ret = 0;
>> +
>> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static void __exit tsm_exit(void)
>> +{
>> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "
>> shutdown\n"); +}
>> +
>> +module_init(tsm_init);
>> +module_exit(tsm_exit);
>> +
>> +MODULE_VERSION(DRIVER_VERSION);
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR(DRIVER_AUTHOR);
>> +MODULE_DESCRIPTION(DRIVER_DESC);
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
>> new file mode 100644
>> index 000000000000..b6235d1210ca
>> --- /dev/null
>> +++ b/drivers/virt/coco/tsm.c
>> @@ -0,0 +1,636 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/module.h>
>> +#include <linux/tsm.h>
>> +
>> +#define DRIVER_VERSION	"0.1"
>> +#define DRIVER_AUTHOR	"aik@amd.com"
>> +#define DRIVER_DESC	"TSM library"
>> +
>> +static struct class *tsm_class, *tdev_class, *tdi_class;
>> +
>> +/* snprintf does not check for the size, hence this wrapper */
>> +static int tsmprint(char *buf, size_t size, const char *fmt, ...)
>> +{
>> +	va_list args;
>> +	size_t i;
>> +
>> +	if (!size)
>> +		return 0;
>> +
>> +	va_start(args, fmt);
>> +	i = vsnprintf(buf, size, fmt, args);
>> +	va_end(args);
>> +
>> +	return min(i, size);
>> +}
>> +
>> +struct tsm_blob *tsm_blob_new(void *data, size_t len)
>> +{
>> +	struct tsm_blob *b;
>> +
>> +	if (!len || !data)
>> +		return NULL;
>> +
>> +	b = kzalloc(sizeof(*b) + len, GFP_KERNEL);
>> +	if (!b)
>> +		return NULL;
>> +
>> +	b->data = (void *)b + sizeof(*b);
>> +	b->len = len;
>> +	memcpy(b->data, data, len);
>> +
>> +	return b;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_blob_new);
>> +
>> +static int match_class(struct device *dev, const void *data)
>> +{
>> +	return dev->class == data;
>> +}
>> +
>> +struct tsm_dev *tsm_dev_get(struct device *parent)
>> +{
>> +	struct device *dev = device_find_child(parent, tdev_class,
>> match_class); +
>> +	if (!dev) {
>> +		dev = device_find_child(parent, tdi_class,
>> match_class);
>> +		if (dev) {
>> +			struct tsm_tdi *tdi = container_of(dev,
>> struct tsm_tdi, dev); +
>> +			dev = &tdi->tdev->dev;
>> +		}
>> +	}
>> +
>> +	if (!dev)
>> +		return NULL;
>> +
>> +	/* device_find_child() does get_device() */
>> +	return container_of(dev, struct tsm_dev, dev);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_dev_get);
>> +
>> +void tsm_dev_put(struct tsm_dev *tdev)
>> +{
>> +	put_device(&tdev->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_dev_put);
>> +
>> +struct tsm_tdi *tsm_tdi_get(struct device *parent)
>> +{
>> +	struct device *dev = device_find_child(parent, tdi_class,
>> match_class); +
>> +	if (!dev)
>> +		return NULL;
>> +
>> +	/* device_find_child() does get_device() */
>> +	return container_of(dev, struct tsm_tdi, dev);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_tdi_get);
>> +
>> +void tsm_tdi_put(struct tsm_tdi *tdi)
>> +{
>> +	put_device(&tdi->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_tdi_put);
>> +
>> +static ssize_t blob_show(struct tsm_blob *blob, char *buf)
>> +{
>> +	unsigned int n, m;
>> +	size_t sz = PAGE_SIZE - 1;
>> +
>> +	if (!blob)
>> +		return sysfs_emit(buf, "none\n");
>> +
>> +	n = tsmprint(buf, sz, "%lu %u\n", blob->len);
>> +	m = hex_dump_to_buffer(blob->data, blob->len, 32, 1,
>> +			       buf + n, sz - n, false);
>> +	n += min(sz - n, m);
>> +	n += tsmprint(buf + n, sz - n, "...\n");
>> +	return n;
>> +}
>> +
>> +static ssize_t tsm_certs_gen(struct tsm_blob *certs, char *buf,
>> size_t len) +{
>> +	struct spdm_certchain_block_header *h;
>> +	unsigned int n = 0, m, i, off, o2;
>> +	u8 *p;
>> +
>> +	for (i = 0, off = 0; off < certs->len; ++i) {
>> +		h = (struct spdm_certchain_block_header *) ((u8
>> *)certs->data + off);
>> +		if (WARN_ON_ONCE(h->length > certs->len - off))
>> +			return 0;
>> +
>> +		n += tsmprint(buf + n, len - n, "[%d] len=%d:\n", i,
>> h->length); +
>> +		for (o2 = 0, p = (u8 *)&h[1]; o2 < h->length; o2 +=
>> 32) {
>> +			m = hex_dump_to_buffer(p + o2, h->length -
>> o2, 32, 1,
>> +					       buf + n, len - n,
>> true);
>> +			n += min(len - n, m);
>> +			n += tsmprint(buf + n, len - n, "\n");
>> +		}
>> +
>> +		off += h->length; /* Includes the header */
>> +	}
>> +
>> +	return n;
>> +}
>> +
> 
>> +
>> +void tsm_dev_free(struct tsm_dev *tdev)
>> +{
>> +	dev_notice(&tdev->dev, "Freeing tdevice\n");
>> +	device_unregister(&tdev->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_dev_free);
>> +
>> +int tsm_create_link(struct tsm_subsys *tsm, struct device *dev,
>> const char *name) +{
>> +	return sysfs_create_link(&tsm->dev.kobj, &dev->kobj, name);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_create_link);
>> +
>> +void tsm_remove_link(struct tsm_subsys *tsm, const char *name)
>> +{
>> +	sysfs_remove_link(&tsm->dev.kobj, name);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_remove_link);
>> +
>> +static struct tsm_subsys *alloc_tsm_subsys(struct device *parent,
>> size_t size) +{
>> +	struct tsm_subsys *subsys;
>> +	struct device *dev;
>> +
>> +	if (WARN_ON_ONCE(size < sizeof(*subsys)))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	subsys = kzalloc(size, GFP_KERNEL);
>> +	if (!subsys)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	dev = &subsys->dev;
>> +	dev->parent = parent;
>> +	dev->class = tsm_class;
>> +	device_initialize(dev);
>> +	return subsys;
>> +}
>> +
>> +struct tsm_subsys *tsm_register(struct device *parent, size_t size,
>> +				const struct attribute_group
>> *tdev_ag,
>> +				const struct attribute_group *tdi_ag,
>> +				int (*update_measurements)(struct
>> tsm_dev *tdev)) +{
>> +	struct tsm_subsys *subsys = alloc_tsm_subsys(parent, size);
>> +	struct device *dev;
>> +	int rc;
>> +
>> +	if (IS_ERR(subsys))
>> +		return subsys;
>> +
>> +	dev = &subsys->dev;
>> +	rc = dev_set_name(dev, "tsm0");
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = device_add(dev);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	subsys->tdev_groups[0] = &dev_group;
>> +	subsys->tdev_groups[1] = tdev_ag;
>> +	subsys->tdi_groups[0] = &tdi_group;
>> +	subsys->tdi_groups[1] = tdi_ag;
>> +	subsys->update_measurements = update_measurements;
>> +
>> +	return subsys;
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_register);
>> +
>> +void tsm_unregister(struct tsm_subsys *subsys)
>> +{
>> +	device_unregister(&subsys->dev);
>> +}
>> +EXPORT_SYMBOL_GPL(tsm_unregister);
>> +
>> +static void tsm_release(struct device *dev)
>> +{
>> +	struct tsm_subsys *tsm = container_of(dev, typeof(*tsm),
>> dev); +
>> +	dev_info(&tsm->dev, "Releasing TSM\n");
>> +	kfree(tsm);
>> +}
>> +
>> +static void tdev_release(struct device *dev)
>> +{
>> +	struct tsm_dev *tdev = container_of(dev, typeof(*tdev), dev);
>> +
>> +	dev_info(&tdev->dev, "Releasing %s TDEV\n",
>> +		 tdev->connected ? "connected":"disconnected");
>> +	kfree(tdev);
>> +}
>> +
>> +static void tdi_release(struct device *dev)
>> +{
>> +	struct tsm_tdi *tdi = container_of(dev, typeof(*tdi), dev);
>> +
>> +	dev_info(&tdi->dev, "Releasing %s TDI\n", tdi->kvm ? "bound"
>> : "unbound");
>> +	sysfs_remove_link(&tdi->dev.parent->kobj, "tsm_dev");
>> +	kfree(tdi);
>> +}
>> +
>> +static int __init tsm_init(void)
>> +{
>> +	int ret = 0;
>> +
>> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>> +
>> +	tsm_class = class_create("tsm");
>> +	if (IS_ERR(tsm_class))
>> +		return PTR_ERR(tsm_class);
>> +	tsm_class->dev_release = tsm_release;
>> +
>> +	tdev_class = class_create("tsm-dev");
>> +	if (IS_ERR(tdev_class))
>> +		return PTR_ERR(tdev_class);
>> +	tdev_class->dev_release = tdev_release;
>> +
>> +	tdi_class = class_create("tsm-tdi");
>> +	if (IS_ERR(tdi_class))
>> +		return PTR_ERR(tdi_class);
>> +	tdi_class->dev_release = tdi_release;
>> +
>> +	return ret;
>> +}
>> +
>> +static void __exit tsm_exit(void)
>> +{
>> +	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "
>> shutdown\n");
>> +	class_destroy(tdi_class);
>> +	class_destroy(tdev_class);
>> +	class_destroy(tsm_class);
>> +}
>> +
>> +module_init(tsm_init);
>> +module_exit(tsm_exit);
>> +
>> +MODULE_VERSION(DRIVER_VERSION);
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR(DRIVER_AUTHOR);
>> +MODULE_DESCRIPTION(DRIVER_DESC);
>> diff --git a/Documentation/virt/coco/tsm.rst
>> b/Documentation/virt/coco/tsm.rst new file mode 100644
>> index 000000000000..7cb5f1862492
>> --- /dev/null
>> +++ b/Documentation/virt/coco/tsm.rst
>> @@ -0,0 +1,99 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +What it is
>> +==========
>> +
>> +This is for PCI passthrough in confidential computing (CoCo:
>> SEV-SNP, TDX, CoVE). +Currently passing through PCI devices to a CoCo
>> VM uses SWIOTLB to pre-shared +memory buffers.
>> +
>> +PCIe IDE (Integrity and Data Encryption) and TDISP (TEE Device
>> Interface Security +Protocol) are protocols to enable encryption over
>> PCIe link and DMA to encrypted +memory. This doc is focused to DMAing
>> to encrypted VM, the encrypted host memory is +out of scope.
>> +
>> +
>> +Protocols
>> +=========
>> +
>> +PCIe r6 DOE is a mailbox protocol to read/write object from/to
>> device. +Objects are of plain SPDM or secure SPDM type. SPDM is
>> responsible for authenticating +devices, creating a secure link
>> between a device and TSM. +IDE_KM manages PCIe link encryption keys,
>> it works on top of secure SPDM. +TDISP manages a passed through PCI
>> function state, also works on top on secure SPDM. +Additionally, PCIe
>> defines IDE capability which provides the host OS a way +to enable
>> streams on the PCIe link. +
>> +
>> +TSM modules
>> +===========
>> +
>> +TSM is a library, shared among hosts and guests.
>> +
>> +TSM-HOST contains host-specific bits, controls IDE and TDISP
>> bindings. +
>> +TSM-GUEST contains guest-specific bits, controls enablement of
>> encrypted DMA and +MMIO.
>> +
>> +TSM-PCI is PCI binding for TSM, calls the above libraries for
>> setting up +sysfs nodes and corresponding data structures.
>> +
>> +
>> +Flow
>> +====
>> +
>> +At the boot time the tsm.ko scans the PCI bus to find and setup
>> TDISP-cabable +devices; it also listens to hotplug events. If setup
>> was successful, tsm-prefixed +nodes will appear in sysfs.
>> +
>> +Then, the user enables IDE by writing to
>> /sys/bus/pci/devices/0000:e1:00.0/tsm_dev_connect +and this is how
>> PCIe encryption is enabled. +
>> +To pass the device through, a modifined VMM is required.
>> +
>> +In the VM, the same tsm.ko loads. In addition to the host's setup,
>> the VM wants +to receive the report and enable secure DMA or/and
>> secure MMIO, via some VM<->HV +protocol (such as AMD GHCB). Once this
>> is done, a VM can access validated MMIO +with the Cbit set and the
>> device can DMA to encrypted memory. +
>> +The sysfs example from a host with a TDISP capable device:
>> +
>> +~> find /sys -iname "*tsm*"
>> +/sys/class/tsm-tdi
>> +/sys/class/tsm
>> +/sys/class/tsm/tsm0
>> +/sys/class/tsm-dev
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm_dev
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_tdi_bind
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_tdi_status
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_tdi_status_user
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_report_user
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.1/tsm-tdi/tdi:0000:e1:00.1/tsm_report
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm_dev
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_tdi_bind
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_tdi_status
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_tdi_status_user
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_report_user
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-tdi/tdi:0000:e1:00.0/tsm_report
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_certs
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_nonce
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_meas_user
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_certs_user
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_dev_status
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_cert_slot
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_dev_connect
>> +/sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/tsm-dev/tdev:0000:e1:00.0/tsm_meas
>> +/sys/devices/pci0000:a0/0000:a0:07.1/0000:a9:00.5/tsm
>> +/sys/devices/pci0000:a0/0000:a0:07.1/0000:a9:00.5/tsm/tsm0
>> +
>> +
>> +References
>> +==========
>> +
>> +[1] TEE Device Interface Security Protocol - TDISP - v2022-07-27
>> +https://members.pcisig.com/wg/PCI-SIG/document/18268?downloadRevision=21500
>> +[2] Security Protocol and Data Model (SPDM)
>> +https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.2.1.pdf
>> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
>> index 819a97e8ba99..e4385247440b 100644
>> --- a/drivers/virt/coco/Kconfig
>> +++ b/drivers/virt/coco/Kconfig
>> @@ -3,6 +3,18 @@
>>   # Confidential computing related collateral
>>   #
>>   
>> +config TSM
>> +	tristate "Platform support for TEE Device Interface Security
>> Protocol (TDISP)"
>> +	default m
>> +	depends on AMD_MEM_ENCRYPT
>> +	select PCI_DOE
>> +	select PCI_IDE
>> +	help
>> +	  Add a common place for user visible platform support for
>> PCIe TDISP.
>> +	  TEE Device Interface Security Protocol (TDISP) from
>> PCI-SIG,
>> +
>> https://pcisig.com/tee-device-interface-security-protocol-tdisp
>> +	  This is prerequisite for host and guest support.
>> +
>>   source "drivers/virt/coco/efi_secret/Kconfig"
>>   
>>   source "drivers/virt/coco/pkvm-guest/Kconfig"
>> @@ -14,3 +26,5 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
>>   source "drivers/virt/coco/arm-cca-guest/Kconfig"
>>   
>>   source "drivers/virt/coco/guest/Kconfig"
>> +
>> +source "drivers/virt/coco/host/Kconfig"
>> diff --git a/drivers/virt/coco/host/Kconfig
>> b/drivers/virt/coco/host/Kconfig new file mode 100644
>> index 000000000000..3bde38b91fd4
>> --- /dev/null
>> +++ b/drivers/virt/coco/host/Kconfig
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +#
>> +# TSM (TEE Security Manager) Common infrastructure and host drivers
>> +#
>> +config TSM_HOST
>> +	tristate
> 

-- 
Alexey


