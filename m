Return-Path: <linux-arch+bounces-10415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D0A4703E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 01:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF1CD16A963
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46BE749A;
	Thu, 27 Feb 2025 00:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qIeUc3xD"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E910D14B945;
	Thu, 27 Feb 2025 00:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616429; cv=fail; b=N147zTX9l6fRG5mGL6qWXa78aWSDtStfw9ec/QXeW3J0O4ULoWbNCd8xv6mVYwtz9f4RSt7x6M9nHmeSvyJwzNW9W26Hc7p1IkroGwUN/ZTlyKVEKCjaP9G4z9MHgRR/Z1FBbbEreAS87ARZXCs5S3HqghBkh1/p5hGgM/GuhpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616429; c=relaxed/simple;
	bh=7DUQs0Ho3TPXYqgsvSWSfccSUGW8gNWC3Bt4Q25zdqY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tq9W43d9mY6o4CG06ZKmNZSOUFr9fLseURmz83imjVNVSUbZxbVkfhSKv1zo2ATw3ND3nKAhTwB3Wgw/uF9346ETkYBS9vb7XzFfp6IKNVqDMKo8Q5mt4ETkmv3bTWLqcgmaN2OnVj4JGstOpj9ObivcaJwK2qADSISGvEcF6lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qIeUc3xD; arc=fail smtp.client-ip=40.107.212.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHbNxnpmx2WMdzFbb0S86CyPaSd/tr0D3GKDxDV8w+qDwB5MC4mZRbt6ZzOjKjK8qGCW9iRY6KeRg5g7SXDEycN3ybqPu22Wo1TQTuEnYNAhbPmK8MKGne2a1eDUeur8tZuvVQHCDb1CZR7aJTU/V7qNzFAVLJlHpmabmaTYMy5o79WXSGOFLosQAZnVcylRiBD/ilnrcaXkPumAvzjegrqkurGVY2e5u6F8KjBUP5xBg/Ylw7k2fZzoTdWCUKem0FxhiaDr4CPjxKiPijP42KkVlT4gWu6bt0MRkUvtsgQ6MWgGsUX3mv/s0QlUxCU1PohatMFlucEtcPFvfhL4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tABq2iIKsp7aigREQL13bMpbZoZpUdcqxTePJGpGAE=;
 b=ohD+LAiFtfJtPt0WdNoR9NAcF1B5mhWILtWYOhwb+q8W7/a+aUjonuJ0bdInptrtaQEDM4fLNJyD9bOEDvwt1yhuq+ALbKJ9AfH14QGL1q3hXsN5Tl2fdyBceGzDGTGxYvLyIWIDKAIuM1R33B2S1OMcm8uRC2ySIR0o+cMGPMLQqPYBB27VlveGDEjWYxAtYYdrKg1SoYHbVzggqjdSZNHLjlmm75EbAE7zenEevKRnQzBGtPjqeZK/WSn9i766j66hgeu7NFUxPsTfa+CK55cSePei5CqZC2fqsBqSxNkD51zk5IuojQYxRGoGH3GbuouZ+1l3lbtzdAqeSn3jeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tABq2iIKsp7aigREQL13bMpbZoZpUdcqxTePJGpGAE=;
 b=qIeUc3xDoWl2nJBtiwnp+L4w+KCvqbxBZ4bN2FiKMs5Didv/72jJFRRZX93RQ8oLHQalsH+sUn9OKbZ2rOJP0hgQg8pz5cXfNeW0yrknZF1zYr8VKIkWXxeE2BDfsLJ5vH54ikx/MjCZOmNks9p6iZlqOnFS9h0Kf8diki+tq/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Thu, 27 Feb
 2025 00:33:44 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 00:33:44 +0000
Message-ID: <433217be-55e3-477b-bc10-cf81f02ab21e@amd.com>
Date: Thu, 27 Feb 2025 11:33:31 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Xu Yilun <yilun.xu@linux.intel.com>
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
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250226131202.GH5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0133.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d1::14) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b151fd-6d97-45ca-0d92-08dd56c66440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M01INlczaGV3aGxwUk1XRThkRVRsU3NudStJbUdxam1nTXpkbThHWEVPZi9N?=
 =?utf-8?B?Z09UQ0JEQTFxYnMzS0I5ZHY1NmMwZHFxVmUwZ1oyOTJ2UUJyVG8yQ3VuQS9v?=
 =?utf-8?B?M3NLaEZFdFBCZjk3R2d6U1R4bzc2T1NVakx3NDVhYlJ6ZzFqazdyOXEvcFVI?=
 =?utf-8?B?S2VSS09aVHdVazh2ekxabXoyV0paK3hnNXNsblEvUHBVdmxjS3FQWXZLY0ti?=
 =?utf-8?B?SlJEOFZKN1lrTk5qN3JYLzVWVVJQVHBvdUIxenp5RDQ3NlZSSGdNTU5tRFN5?=
 =?utf-8?B?eUd6azNOR2dxellxZFdVZlRFQ2g0QXg3OTFobitYSWNOOFhlQlRFcXZ0TEVx?=
 =?utf-8?B?SytWU3ZScHhnbXNCQnd2Mk9TTEF6L1k2OXh5NCszUml4cUdLRjlUVXR1QzIy?=
 =?utf-8?B?R1ZuL20rcHZzQ1cyWEZYZjNKaTNjT1VxNGZXTzhJL3ZqaG5ncjZZSEFLaHF5?=
 =?utf-8?B?OWUvbW02MFdVbWJhaFRRTWRiVU9PU0laZnZvMUE0Z2hkcUthSkhWbldpSWl6?=
 =?utf-8?B?WTNNdTZKeTFNZDkzMnJzd1FSRGlKZ0FzK0QySFBuc2pZcmwyMCtvQ1lHZGNM?=
 =?utf-8?B?U2Y4TXc2cUZvOVo5cm14S25VTCsrb2pXckZHZmt5em5Lb3dhWEV6MUgrWVJH?=
 =?utf-8?B?cU45dWJzdHNQN2xSN05WV0hBcVY1WkNKbml4bkxzMkNWZE1FRE12alFONEt0?=
 =?utf-8?B?WnVWZ1BCTWd0SVBXU2Z1N3dhZ0JTWVVCSzloT1lsdGF2dzRBaUpjbkRYMVht?=
 =?utf-8?B?anhtcWF6M0QveWVPdFgzSHNOM1VjTWRoeEtadkl0Z2dyZ1FxeE9QTVdvQ3dx?=
 =?utf-8?B?L2N5TXhTSEkyVnQzZnB5SGp4UGpCL3ZNNUwveXRUMGVMTTlPMnJ5SVc5TkIv?=
 =?utf-8?B?SDVTejhick5HT1NQbG92YVpYcEE2Z1crc3NWenplRHkwMnFNQVRwRjRSQ0J3?=
 =?utf-8?B?cjBidXJVS2NDVnl2NHk2Z1oyRnRWcXI1VG5md2grMWhONTZ2dGw4andWbWFG?=
 =?utf-8?B?NFhHQ1FpNzlkS1FQdnhFZDYybm5XZDlwaWFRZEJSaHovZ0cwTVZDNEZQOWlL?=
 =?utf-8?B?NVJFQmxQUWdFak5tUnViOURjSUtBZzV1MlhZeTdNMGFkNjM3Qy9PWEs4cm5O?=
 =?utf-8?B?Zkx1aVQvMWlFWm9VNXN6WXpGMitETEQ3YUpiV3R0QVRHY3FOT2Z0aWQyUjlM?=
 =?utf-8?B?TGNmMDJheDZIZEpDME5wZmdmSFNLTmlJZFl3alo5VlZyTHZob2Jtdzdtdjdj?=
 =?utf-8?B?YmlQbGlEajNOQXUzVzE0NElZcElFZDZTWnZVRzRlNlIzYjhzM1c2ZEFDUi9u?=
 =?utf-8?B?TEl1VzZzblFCc2NMTklsZ3pjWVI3RU13RlpaQkJ0ZGpOZWE3NTJxOFAwNFlQ?=
 =?utf-8?B?NzYwK3ZSVUNzSWxoYjc3N3puaG02Q3E0cm9QVjczNlVIdWowaTg4VFBhVExH?=
 =?utf-8?B?ZVZtUCtOKzBsYzlFQUhDTitzQk8zOU5WREFTZ0tjMGtyZ2h4ZWIwYlY3bmY0?=
 =?utf-8?B?aGxQZVdRYXVOZXdmWnFaM1hYcU5lL2wwUXcxMHNvUkZjd05WdXNNMVpsajBE?=
 =?utf-8?B?WkJWQm5FMkVDRG1BSkRBOWFWTytLclMvNGw4SFpaTjhwODdLUVEvdnRod2sw?=
 =?utf-8?B?VWxGNEt4akkvcERHMWNyN0JMM3Jsc3dsaDd5ejltVXkyaCtoeDIzcTBTYVA0?=
 =?utf-8?B?M3Nyb1dHYVptdEdRZ0JEMTFxa0NqZmVidkM3VXl1eTBBS1ViQ2Q4QmpYTkxm?=
 =?utf-8?B?R0szQWZYbTUyU1d1S2Zwb3NPTmNmWkZwQUtQR0x6d0NINlBHZ1Y5TlpWUENK?=
 =?utf-8?B?R3AvdkgrRlRSWW1GZzFkd3lLb2x6TkdZVFBsREZZdWIwODFjQ21kMVdwUThV?=
 =?utf-8?Q?zHIWbaTIQq2zk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVJEZm9xNEpQTTRPL3ZpRTlLRE5zc0U3RytCVTFmM3VWTXZBK2lUbFkzTGpm?=
 =?utf-8?B?bmZEa1ZEY3JFTUcrU2FEV3haYjZBUjI4bVA2TnR4cWJWRFl4MzlCWmNZK1hU?=
 =?utf-8?B?UUZ2WWtQS0cyVk52Y1poNTJTUVB0MkVxN1JwQlVkRW03TWt6MS9UaUlqVUZO?=
 =?utf-8?B?aWEzWVBBdk5oYk0vT1JqdzFLaHlTNStRRFl5eUluSG00Q09KQlBZY1k2SWxV?=
 =?utf-8?B?VUl6YVlpZG9HYzBvWEZRa1JFMEk0dnd1cVU0ZTRkc1VXcW5RYXFXOXhqMnh2?=
 =?utf-8?B?NmVZYmMzaDAvY25yc0w5VGNOZkZPcGxJWC9WNFp3Ukw4WGdFc2grZmJOQlJB?=
 =?utf-8?B?bjE0VG82WGtnMHBBaWx3bzlmUTdFMDdsUExvNW9EaE5OUUdGMEo2M3BDNmRP?=
 =?utf-8?B?WlVZd3g4MFhPdkZEUm14YVFkMlFUQ3dSVlZCR2l6b2VBaHBvT3o3TWVHbEh0?=
 =?utf-8?B?SVNVU2c0eUVQSnJaSnhwajhQQURqaFpWaEpndHNockQwWTdoUm1PYWtZTVRP?=
 =?utf-8?B?clR1Zkt4dCtJTE1aZmxqWWZRZzB4RHJiTEMzNHpzRnNuWkh1eUFrcndnNWdN?=
 =?utf-8?B?ZEtLUFRMTGF2M1BNRzg2a0l1YnRxRUJUZm5ReWpiYjIwQ0NFRHNPYkV4Y3BR?=
 =?utf-8?B?dVQ0c0ZaSWdRT1dXSSsrMDB4b3ErS21weTB1bkIyWmRtSUVLNUl0R003Zlhw?=
 =?utf-8?B?cVhDR3ltZTNTaS9WZENzQXhxeUswSFBvbFYwQlJySXJtcThYK0kwMnVCUmhF?=
 =?utf-8?B?L1R3Q0hmUTlvVHNMY3djV1E1ZmdQbnFjbTgyTS9Kb3BZbW1uQndXUEwyRDRY?=
 =?utf-8?B?MEtTN2ppNVd3TEJxQTQ0SnVwUjJoMTBsbllYN3d0cnIyZkJ5MXFrYk1NakN6?=
 =?utf-8?B?YTlDRzhzNzgxVmNMZDI4a0dxQ0dPK1BGRUlicVNPRTF4bXRTWnFzbjlUNWlT?=
 =?utf-8?B?K2I0eDNLWVJwSzkzRGMyYzRTQ2ozaldDSkp4bEhpcVNtY3RxcURGd1Bud3g2?=
 =?utf-8?B?dXhnMDlnVGtneDJuSUN5U0ZlMThFZHhBdU4zK1k5NitqbnJPbzJQbUp6eTZP?=
 =?utf-8?B?SmZFRytydzNjMUgzQkpZVFBzR1BxZ2tKblVJSks5eGNtNTQ1cWw3Rzd4RDU1?=
 =?utf-8?B?R0lnZGxFWTBVMmdKOXVtU0ZjMmVvV1Z4UXBDL0pvdkVLRmFWZVQ3bGdtRVUr?=
 =?utf-8?B?eFpJaVFvdDNyV1B0bW5VOU10aWFLM3ZnTFFsbU5UY0wzVzYvdllGYzRSdm5V?=
 =?utf-8?B?WjZDQnBKOFVCZDRaSFBQSUFyeDQ4WFVhUGFEaGp3aUNXbVBMaVFGVWdwMnls?=
 =?utf-8?B?cERScllsckpuZGZTcVpGQUFWdmRDVEQyWTFkSXFtM1Iycmo4d09Mc0pZNzZa?=
 =?utf-8?B?WmwyNGttTnlnMzBQdGpLMEJMdno5eGErTlZkUVJZYmlsV2VNdFhGOG9HMm4z?=
 =?utf-8?B?U0Rra2FVZ3ExT05PMmg4YzBoTEM1SUdaNkx3cXNWZ0I3ekk5RUJXZ00vRlZG?=
 =?utf-8?B?MG1GTVBTdlJjSkNmUjlFOGlzKzRpY1lCVmRCUW5tcFhsRjd4OGhLcDNlVjda?=
 =?utf-8?B?d0gyV1pDbUNyRFltckk0aGg1SGQxaklQZXlzRjJnalhKRUxQeTZZZmdkQVM2?=
 =?utf-8?B?ckJ2UjlsdEhpZm5xZWpGUDM0TFI5YU1HeXNhOUw0c0Z1dFdiK0tVSDdDWFBR?=
 =?utf-8?B?VW9nQ0d6SitYQ3d3aDRLQnFNdlMyS3dWQTlzS1g0MEpDMkRhS2doTC9uTXov?=
 =?utf-8?B?TGMyK0VDblVYODZRRkdFRTgrbFRKZ01NczUxQW9wUzg3U01ma09IdnBVdlB3?=
 =?utf-8?B?bVlQSXJEcUdKYzJQOU9haVFvTW1KeFRGUDM0cUxZaTRTeklqSnRlSHlaR3Nt?=
 =?utf-8?B?K2pPMEZmb2pSNGlJSlBtakJiYkpzbXJhcE9uN0VPVlZwc0N6bitHL0JSeHRI?=
 =?utf-8?B?Syt6TUFzTEYzRmZPcnRYUW4rZHhiWVZraEN1bkRWUkFnODVFWU9WaTZ4NllV?=
 =?utf-8?B?UUhTUkhIaUtPSE9nYUFmM21BOElLbEFxd1ZtK0wwTEVvL2M2R0lFMGFzVEFD?=
 =?utf-8?B?UlRWMDNDUzVWdkZvSlVhWjBNOHJZVVNEdGM0MVZSYTlzUi9LMWROZGRyVUlP?=
 =?utf-8?Q?yM/B5/+Zad87rVgsnSJFBPJYh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b151fd-6d97-45ca-0d92-08dd56c66440
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 00:33:44.5203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4ai6cqlyCKM8IYAWYq8U3XV5WyLnVA7suRhxgDpX7kOSjtlzTKLVNXt7GPLh61nZzdnt90B+1QiDIa/6O4QvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604



On 27/2/25 00:12, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 06:49:18PM +0800, Xu Yilun wrote:
> 
>> E.g. I don't think VFIO driver would expect its MMIO access suddenly
>> failed without knowing what happened.
> 
> What do people expect to happen here anyhow? Do you still intend to
> mmap any of the MMIO into the hypervisor? No, right? It is all locked
> down?

This patchset expects it to be mmap'able as this is how MMIO gets mapped 
in the NPT and SEV-SNP still works with that (and updates the RMPs on 
top), the host os is not expected to access these though. TDX will 
handle this somehow different. Thanks,

> 
> So perhaps the answer is that the VFIO side has to put the device into
> CC mode which disables MMAP/etc, then the viommu/vdevice iommufd
> object can control it.
> 
>> Back to your concern, I don't think it is a problem. From your patch,
>> vIOMMU doesn't know the guest BDFn by nature, it is just the user
>> stores the id in vdevice via iommufd_vdevice_alloc_ioctl(). A proper
>> VFIO API could also do this work.
> 
> We don't want duplication though. If the viommu/vdevice/vbdf are owned
> and lifecycle controlled by iommufd then the operations against them
> must go through iommufd and through it's locking regime.
>>
>> The implementation is basically no difference from:
>>
>> +       vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
>> +                                              IOMMUFD_OBJ_VDEVICE),
>>
>> The real concern is the device owner, VFIO, should initiate the bind.
> 
> There is a big different, the above has correct locking, the other
> does not :)
> 
> Jason

-- 
Alexey


