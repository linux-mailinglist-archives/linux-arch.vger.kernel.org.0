Return-Path: <linux-arch+bounces-10208-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C140FA3AD52
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 01:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2478D3AFD53
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 00:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2701DFE1;
	Wed, 19 Feb 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DhpV2wjO"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007F3FD4;
	Wed, 19 Feb 2025 00:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925844; cv=fail; b=iW+FajdhpqyNkQ+Egbvu6MtPTaQFPDhvWcOasu0lSh1lR7xUxauY9n1nuXQ55dKGJxqvqCR1qF/Pv55Njht1hclcEfs6kehea7u/WTWuNCjlHSJVLxigGcrdlJ22KM+D8E7c626+RsDzf7iRtKs7EzVI1MucEuLudfw0ZBIds6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925844; c=relaxed/simple;
	bh=6Q/hroU8yYcjwPBZvwoirOQTc/mNYxT4M/7ZtzdGzTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j2KoNBhZOW0VoJINCD8NBfRBnKoscB6jbacB2ZydsYreZ48n1YNDInj3b/ydondPwb5HVPFqr7zjb7/8pQg95QvGxu0Xmf3UPYPq4dFLxzBZ6CwqLl8xMdJmdKcTjxknd4Jqbt6muSKFweGWX5soVJTEjjjrAiEUocjUiUV6kBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DhpV2wjO; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUp9ADNVK2zp8CYu/V9T77T0Q/8nwF+c8LvvUjSKgRbuiowZixw8xoes+pHErBI5jrEa9XFu/25/VUj+z4xDBOan5uUn7wNBs9APvEYWsL45IXTU9hCLES9BydvVWxYrb7DwyDP5eivpuXcNvS3Hf1POynlkIQYdQsDlJTyZ2k9mDv18pOeYXmlwdoZqJ+Te9b7gomfWUTUfZfmF4mfCxbpAYz9PPYBkHP8VUXof1z0d6Mmmtga+qU1qOeW8jB1KuAQIXopeRmaASF+EwUYbruxEm/M3Qs48ExIhElwERre3NB91preaecgVO/kz/Kpsm9zzi7ZjQCrkreH75ZUh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FfejP7Ayh7IXgSLPn/QuqXVUNsP/NmjBTajgf492qw=;
 b=o5yyA5Ro9bcWoBTtgyTHA78ISDCwIKYfnrVLtYkdU3AZ63DotxntPg8KkefQYABIohYeQ0vxnfhEbtU6oc4CjTnfk59YxUXRwP+F5phAPEyYoTODXF2QpETCycE8q2iry5Ibp2julk73ZUUTDfCR8zJLyI5zxlw8oeszg1wgeDgDnTGpZ2uiHEMHJJQq6Ndbf1IPIszTp80e5Qu6jOc88f6uQ+B6I701aLTNKieCYHRiWrEDDflEquw/im2egV5SYAKOo7gEdIWrsrGlAUFl06EqyzmAPF/eJYXgJMe7+j7BG7hdgaW5mYcmtrfwXhmrKJkj+VrdqMRcPM+GEvvi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FfejP7Ayh7IXgSLPn/QuqXVUNsP/NmjBTajgf492qw=;
 b=DhpV2wjOMeTeBqROFCt9CWKE0Knz1xDi8CcRUxvRGPAXMb9FFKf2epSWGyfDqIDe4TJqCsGr5VJSF1369POeslud/2Vm54FeWz/J2y9yXaymDOHPCCDKIoLE9OI1uxQyZ4skCbBjYYq3KsNFRK/G7oMYrhmDypdRwht4pHRLKgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 00:44:01 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8445.016; Wed, 19 Feb 2025
 00:43:59 +0000
Message-ID: <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
Date: Wed, 19 Feb 2025 11:43:46 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
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
 <20250218111017.491719-13-aik@amd.com> <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250218235105.GK3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVPR01CA0074.ausprd01.prod.outlook.com
 (2603:10c6:220:201::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: d59444ce-1535-4e49-a5f1-08dd507e7f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1hGTGZ1dGg0OG5VcWVYVFBFYUtPU3RsRmZXSVVOODJFSnBqWXMyM1ZtS0hu?=
 =?utf-8?B?a1ovdVo0T2hJem9QVTQ2T25iWjM0aHFpVEhCQkxpMjNMSWJwOFJiV2MxSjVT?=
 =?utf-8?B?ZDQxY09UQkFUekcrQW9mZmVUNmNDL1hpU1hpUVYwTXoyLzM2VDNjQUxRVVdr?=
 =?utf-8?B?VWhFdVUveDBDbmw3eW1ySzBoQVlOYll4WFdPQVJwQXAvdEo5NmlmR21lTFRX?=
 =?utf-8?B?Q1U0RC8yUUZpeG9SamhsRmFlWUl1cnVzTjYzKzhLSmtPWExDVE96dmhrS0dh?=
 =?utf-8?B?R3UzdEVJWDFjeFNreGt6eDRDOFpaZEtERjNXNjk1azFvdVYwSExTclhiaFFR?=
 =?utf-8?B?Z0gzWnI5TTg3eEtpVmV2cGdoQlJGMkpmZTVEQldvK0ltSVpwTk9jNXo3Smd5?=
 =?utf-8?B?c0hwazZsYm9zY3h6YzQrUE94Q1dpSGxHK2w4TW5iOFg3MkxOdWhURU5LdDNH?=
 =?utf-8?B?OE5BOExKL2tXUzd1SHNwZExLNm9OUUN1bm04YlNvNm51Q0xkaUxYdUZvc0Zk?=
 =?utf-8?B?S2N6MFMxQnVRSGg5MU9FQXdEbXp2MU1wOENjb3B6aVk2M3Fhd1NoUUhGcEx1?=
 =?utf-8?B?dGlycWdBYTlaOXBOZnZiTmp5MDFTWWNOdGdoalozMjAxaFl2UzROV1EyaEts?=
 =?utf-8?B?MkVYZlZzRmVqcHJudHlmU0VjSG1rQkhnYUNJOHk0SzBCR2xrMCtjTVAveCtz?=
 =?utf-8?B?VERGZGlBa1B3OHFkaHQ0T0xEd2Jvdi9yUkRpSkF5czJrMDJaUGlxaFptOFQy?=
 =?utf-8?B?VXUyWnBZUCtOdWNBUEpnYTlVcW9DWmtvSStPd0IzNDJwUGFPNGMxZndFNnJ0?=
 =?utf-8?B?bkVqR29jZG9ud3ExaXl1bUFYTzZtek1EeGtOWmUvRWZmU2NwWnlRRjFGajRm?=
 =?utf-8?B?QWJwT1pJbjJVODM2N2hQeVJRR252M1JFOE5CQU1SeDZyM1pLMlBBZGJhdEJF?=
 =?utf-8?B?MTBsU3JPOW5hcEl0SC9EV0ZjN0o1K1lEMFRBRXJheVVBdTdzZTJaQ1VtSWRE?=
 =?utf-8?B?MlNnOUJEM1RLS2N4OC9STmMzR2ZUcUIzbllEeHlZWGVsRjhMSmtPN1Fxbkk4?=
 =?utf-8?B?S3ROY0xwclVrajJtbW1objZUMUhweUR2WEx5WDg3b09sQnhhdm5TVGc4Sk1i?=
 =?utf-8?B?aGZld3p0Nk5XdHFFeXBkMWVVUnNKZ0F1RWZzUzkvRk5IbXR6cWN4U1NRYWJt?=
 =?utf-8?B?a1F6MHE4N3U5aGV2Z2RlL1FNRFl0WkxRVGtpbFZNUHA3MXVabVRqUmtXWm1v?=
 =?utf-8?B?cG1aTlVsL08zTWZHS3l2bDJTcEREQ2VLbGZnaGtTN3REeHNsRm0zTTJzQ1Rk?=
 =?utf-8?B?dmpkOTBqamdVL2JhQ056VUplTTRMVngrUHZ0Zjg0MWhmb3pzaFd0c0d3aWk5?=
 =?utf-8?B?WksrdkpKcDc0NGhCRk55bXBRT0NuWDJIS2x3a0hOUFFhSVNrWVcvMmYra0ZI?=
 =?utf-8?B?VWUvUWc3V05nUEFCS3ZiOHU1WElUY0lNNS9zOEM5K0p2YS9ZNFlFbUgvZ1lG?=
 =?utf-8?B?bEd4TWgrdDhnVFNSeWNQU2dkcm1GVnpNRFp5YklGNzRaRjl0NExZNzc5ZmFa?=
 =?utf-8?B?YUtMZzZmRE92bklrRU9JZDNpT3ZjR29jSFdCb0c2c0tjYnpxdGpqcExnenhu?=
 =?utf-8?B?b0NPYWVnRzBwMyt2bVFIMWttRVdJY2hOaUh0T3VHbm1Ra2RzaSs0ODN6Z0tv?=
 =?utf-8?B?b0V1eHVMZWZNck9mV2VoTURVTzNGcGpYYzA1dmhVcFVjVThnY1hIdEFsYWNi?=
 =?utf-8?B?bjlFYzFyR2F3MDlBZ0E4ZThyTjBKbGVaTWJFcUx2NDZHMVJxRCtkV0h2dnoz?=
 =?utf-8?B?cUMvcWlWenVLL0padTVtNS8rWXN5emVZWFo1VlF0bHNlanVsT3crZ0FjaVZ1?=
 =?utf-8?Q?kGwBWDzWPLHEB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVRDUXVpczZUeXUrTXA0N0FXcmh2Vm9JOWd3QzhJL0lzZXF2KzRMekIwOTA4?=
 =?utf-8?B?TE1iZHVmTFNTM3J2bkQ0d1FpNDZqRGdtRTBRaTl0M0lXemVKbXRTbnNQY3V2?=
 =?utf-8?B?OWk5SmRCUzR2OW5GU2RLZkhoUmV1R3hGeEt2dDkrRWRWQ2NWdUlYMmswcnpY?=
 =?utf-8?B?dFl1UUNRTm1oRk1uZmRGVGhnN05qbm04OFJkaWRhMjFwR2Z6UDBJTE9kUjQ3?=
 =?utf-8?B?czlNMnVLTVJoV3QzNDdBUWhPaXRORm9YK3h6QUtyYmx5dmdpNnFPU2pmdVBL?=
 =?utf-8?B?L1F0L1ZKZkZzNzc1U25Za0VMMUIweWhZWnlyd0pUR0VxNWwxd3kwSEROM05m?=
 =?utf-8?B?U01zRmNnbjNPSGhEOEdoRWIzT0F3dDlXM2xsOFNBM0pPWFpSREJibFNVNnpn?=
 =?utf-8?B?emI0ZGxSckVndkhWczd6M2dOb1V0ZkJPQ0V2TkpEM1A2K1ZNaDF1ODJpcDZW?=
 =?utf-8?B?Sm4rb2dvSXgrQ3RCVDFvYUUzM0RxZVNQVXladkxFaVFGR1JpUXhNOERkSWh4?=
 =?utf-8?B?QmRpRjBhLzRRdTlmZVErWE9yeWQ1enh0RDN3MmhXU2Z4NCt1ZFhtZnB0VnIx?=
 =?utf-8?B?T0JOWERCcExMNjI0MzFoaHd4ZFRmL1FhOWZnTjhBYVo1em5sdy9jMWpSeC9I?=
 =?utf-8?B?RlBrT2l0Z1ZidWhIQkxXQk0yak5Ha2x3cDFlY2dDcnVnTnlhcTNaWXp5RFZH?=
 =?utf-8?B?Y2ZDUU0vNmY4WXAxOTNTNHIxR09iNkdzT3RBZ1FweTYwY0JUUW5kUGJyYU82?=
 =?utf-8?B?TjNyK3RFL1hvSnBvUC95Wi9pS3Y1ZFJXQXhXWWZzNkJ6MXZETjFtN0VIR2Vh?=
 =?utf-8?B?djIvaC9wRG9teXFGZnZYSCt4OW1QQ0VyV0xEbmpDbU0vdjZ4R2R5aURhcURx?=
 =?utf-8?B?Tzh1RUhBb1BLTjRUY0dUSjk4cWFwR0daK2lKYTI0bHJsS2lTZ2JNZTFhc2kr?=
 =?utf-8?B?dlNTcllwaXZ4blhxSXNJSkxUNWh5RllhNjZzZm1wV3diOFZvYUFMWDRudENE?=
 =?utf-8?B?bWErZHYyeDRXRDNwRlB1eFl1UzF6aXBpU21Sc3lBSEgxMXRvbEs2cEJKR0Rr?=
 =?utf-8?B?ekhtQTA0S1BwcnVJZ1JQZWovaXI3cmMyVFZxa0U5ekxPak8ybHZzT1JtV2JV?=
 =?utf-8?B?RXJqbTlxemlER2hWVkk3SmtXK3MrQm9GYytPSnN1SW5zdHRPMUVQWGVoSnF1?=
 =?utf-8?B?enNlMG91bTk4T29TbGxSVWhmV2RnSTNCMzAxZWx1R2crbmtIR2ZxVGZsNFBY?=
 =?utf-8?B?SkhHMDcrak9EOU42OTNad0dRRmVZeHFEZ1QxOUtESTFUV1ByTGVNTmFTSXB2?=
 =?utf-8?B?NnMwL3l2RUhHZllET0tZSi9XRmNDOThGa0h5dkIvN0hQZXo3ZnlKaGhlS1RB?=
 =?utf-8?B?MnlPWThTamZGNUFGai9QYmNvaEhXNXFKTHZYSHpVUzFPNitUMWtxc0lydFVR?=
 =?utf-8?B?bFMvSmIybmN1ejR4LzFYQUROVmJXcXBoam0vS3F0a1BlN3pGR0dPNXpwNS9D?=
 =?utf-8?B?M2gvZ3FGUXd2clo0VUlNeWhldFhQamtpLzlDKzNOZVBMUThCTjdZeE91NlBi?=
 =?utf-8?B?OFF4UThzK1ZYbjlwZFUvcllzR1BXbjBLSTlpNmh5aDF4U25hVnlFa0YzYUFH?=
 =?utf-8?B?OHR5TE0reDI1S2JvT2ZUNmN5WW0vQjkzOUVKa3EwM2pNaTV1SzZQYW5ZMmZD?=
 =?utf-8?B?WHluamkvL1FhTDNoU29oWkdoM09XTTFORXZnY1ZoKzJDUVR5ZXBicy9tNVBQ?=
 =?utf-8?B?aFJjTVNqb25ualpOZFNXenJPMXpvUGNkYml2MzN0ZFRSVGg2ZEkvTjEwWTRz?=
 =?utf-8?B?T3JibHNTMlhhazRrSVQwUlBCZldDZGlyNW81T1d5UUhmOS9jZ0lXSXhJVmZj?=
 =?utf-8?B?bE1SZVlFUitPb3BlbklUZ1Z0ZjB5eDg5VlpNbFlVeFRIRTU5UXdlM0hCUUta?=
 =?utf-8?B?UjJhTk1MOWJFYjJVb29kczVETTI3THBiU1dObEN3YStoMmYwQ2hXL2libW9J?=
 =?utf-8?B?Mys0Q1F4NCtmOUZiVVhxM0NYY0Z5NUZqNFArVHJ1MjQ5UkxLNklUbXpyc2VB?=
 =?utf-8?B?RlRmZEhLQVl0dnZuZkZ4UzlFVmkwQ29nNEZ3UWNsbUY0ZTV0TW5UVVByelNV?=
 =?utf-8?Q?ng1cgfwGA7x2j27yAPxYARlJX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59444ce-1535-4e49-a5f1-08dd507e7f9c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 00:43:59.7738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1VDN6JEPR5axm1q6FjSrZYBErsILx0BNajAQpNbm4SSW/6BKR0qkbXg7G6qKz1hGVJ+scBCf81z/cZS1rczaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126



On 19/2/25 10:51, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 10:35:28AM +1100, Alexey Kardashevskiy wrote:
> 
>> With in-place conversion, we could map the entire guest once in the HV IOMMU
>> and control the Cbit via the guest's IOMMU table (when available). Thanks,
> 
> Isn't it more complicated than that? I understood you need to have a
> IOPTE boundary in the hypervisor at any point where the guest Cbit
> changes - so you can't just dump 1G hypervisor pages to cover the
> whole VM, you have to actively resize ioptes?

When the guest Cbit changes, only AMD RMP table requires update but not 
necessaryly NPT or IOPTEs.
(I may have misunderstood the question, what meaning does "dump 1G 
pages" have?).


> This was the whole motivation to adding the page size override kernel
> command line.
> 
> Jason

-- 
Alexey


