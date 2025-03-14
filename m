Return-Path: <linux-arch+bounces-10755-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3035A6079B
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 03:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6CE19C4C8D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 02:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFA36F30F;
	Fri, 14 Mar 2025 02:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MO938J7e"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B861F957;
	Fri, 14 Mar 2025 02:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741920569; cv=fail; b=YEcudk4PELzVkGyj9FiJMGm9s43mKJddBDOS/TTk294WS6bBNpYdc/BM2aO57vyO2XfTSTgh18cZq9xz7AO9SbuuqmOKc/sNK53vQaDg/mO3/fLWfDTIFUnNMjyVrhMQuyny6Kio+/2o56bn3d6j9owrAjlkhmH0RABp+3MNtKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741920569; c=relaxed/simple;
	bh=2SbB/5DmYKZWKZ1UCThufa1RkyhQNGAd0bJx3/rAGoU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KC9y+pP1hyJkkA1EMfIoRG+MvvsaI1YHlwX9IKhdnFUpanKu58GACO+bLQRJ0JOdxxqH/PUTF5oTxEhji3BSBAp162zS7s3SY31DmH9xqvmREs+mV5mDJxtxc8ceQUGjJMJYNP1lFqbb3nvyKEC5DDvyWIrVnINg3IUuYsRoIMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MO938J7e; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqTYjv15mZRFGhFXIGTYReXMGy+aqS5CotS3zQzrpC41j8MBfls9qWhT5MWQjXHkMwXHWCzaS+ejJsT4i9v0s6+ncVOWESdEoUQn882Xu/+0U4Y0NTk/NwE8wZmlqv69yPUIZYaITA4SlBi/X6G0SVCRtwH1WXiQWXZKxqRpq+cpTuuorydcsuwjhg3Qb23pAfa/9euEtGliWwr/03LtOTiwZCfNRIG/UPLV137iIMdSwTiv2MLXVZis+6u6NacWDdRsa8UgfRelriC50+MRjTckPM72FvjKj2oQ23qVH+MeuXirlDUQ1AnxG5tL8DjsAMkcfzYftC/WCDtUazf6wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHql7R9L+oDmcvs2af4YLdsOV2gR04X6Az5uS5aafow=;
 b=psCfHllD+O46J/TQ177Wq402pA5Xa63NqSFI/CJ97qEJ7ruxCV6SyDTNVy1lrB5Xp3oxp7OpfbUkbvDLSE5/zrERDPj4G9SJh2S9flsrWT0qan4/r2h4kahY6m8Q37cDlLMH7TAFb3JFfuvW2sRDJboNAX6qNXlW0LgdrapfKixZsU5cKCkpw/RKBYsG9hxzGcTIEPEi3PJYvfy1yhg3XUdWt9WNcGrCBgy97USdSuc7IlXrBneBEcgfUvheXeWQF9ccqt1w/yGeZF4EfY/Oy1wM23LMiBQel+fmVe1AGiYYIQf0SIvr563xq08JiyXcCS3DWe+cSMQqpZxCV+4rvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHql7R9L+oDmcvs2af4YLdsOV2gR04X6Az5uS5aafow=;
 b=MO938J7eBO9LzhsryyZtihYDTCmeYpR869Ky8oDZk90E0EC8fN4/YME/S28ntc3YGW98b3zRCaS13GgGBXRaEpkkcc+CgWe+sm6fuFz+irs2+P06ULbSlFyddBJSyapcywX8I+2bN0qGNg99AmRITabraHgBC0Jyj0PZfh3+BcA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 02:49:22 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 02:49:21 +0000
Message-ID: <59bda561-2a21-494d-983f-2a1e647def6c@amd.com>
Date: Fri, 14 Mar 2025 13:49:08 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 14/22] iommufd: Add TIO calls
Content-Language: en-US
To: Xu Yilun <yilun.xu@linux.intel.com>
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
 iommu@lists.linux.dev, linux-coco@lists.linux.dev, Zhi Wang
 <zhiw@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-15-aik@amd.com>
 <Z9K68m8iq3cDXShL@yilunxu-OptiPlex-7050>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <Z9K68m8iq3cDXShL@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEAPR01CA0038.ausprd01.prod.outlook.com (2603:10c6:201::26)
 To CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f72cb2e-59ce-445e-a05a-08dd62a2d256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dStBeEZMaVNBZy92TlUxck1pbFBXRkVzNXgvTktFL3ZXS3ZtL0V5ajdRV3Iw?=
 =?utf-8?B?Rk9FWGt0Q2UyelJzQWxBZ0xPWHIxRGwyVXNHSGNHSW04NU5FUTkrOTMwOEZY?=
 =?utf-8?B?TGkwTzNDb0R3Q1UvZ1JCR2FUeXNjQ2hTRk55MndCTVdTZjZGclRyVzV3eTdP?=
 =?utf-8?B?Tmg4aVVwWktzd3RDZ083NU1rSllsT1IxQk81ZUtRSWVTbDJrZ1hWby9nbzVl?=
 =?utf-8?B?TkY0WldZektHN2ZpVXRyTm9aYmJIdGNyYTdCU2xheFk4VEUrV1VLVHJmTnBi?=
 =?utf-8?B?RWpYbnorYS9WaWxCOFc3SmJmSnF3OHFTN2E4UGU0bVpMUWxPUFBZczJqbDkv?=
 =?utf-8?B?eEFpTm1DK3dpRWJXZ0k3WGxsM3NobDZXMUcvSVZOWVE0bW92VkxIRTRnMEZQ?=
 =?utf-8?B?d25YSUw3QzMvQ0hvL0kzTi90ZnFKUDVDMm83RkprRzRIREpmMkZhZjFXSVpC?=
 =?utf-8?B?VDJNbmlpb2F3MExXamFHWTRCOHh5dVE2b1lsVmEvUHNRa3ZDcDdqYXdLNGxh?=
 =?utf-8?B?TUcxK2dsMGI2c1BOL3pkcmgxOHlkTDkwN3ZRa3F0aUNMUGFWeHF3QW94aGht?=
 =?utf-8?B?Vlc4NzRHLzZZS21mUXp1SnJKQlMvVVVydVhmT0RlaWd6cnNvNUlnaUhvZ3Ri?=
 =?utf-8?B?c3hVZURhNDJNRGYwRlg0NTRWdE5xd2dwelJDdTJ6OW5mZWdTNkNqUnU4azFP?=
 =?utf-8?B?MGlqOW5YLzJOOG1SS3EvekpwS0pYL0l4UDlKM29LQnhpYi9hSE82eDNYNG02?=
 =?utf-8?B?VGU1b1NMekFCK1VhTVlocVgwbjFJM01sbmdFMlNKUlY0OWFJS0cxcnNxVFhD?=
 =?utf-8?B?eVBaSHBlb3NzYVN4SWdVektyaFNNa1RBSFBza1ZHKy9UTGpRamoxdE5VclIw?=
 =?utf-8?B?ZW4reEVWd3BTSE1uOUhvOEQyNzEzakVTY09IMWtWSjZyMDYzSVk3QWVQNmdL?=
 =?utf-8?B?S1NyOXg2Sm1hUTZvWHF0VDZIN2tUMnQ2QWFGMW5xb1dGKy84VHFXWnRrY0ZD?=
 =?utf-8?B?WVFCcWZWaG5sVmFzVFhUNStBeGxoRjZMY3dOdEhTVHJFU0VSYiszNEluTVIy?=
 =?utf-8?B?dzRYMUUrdEpUSWphbFU1SWpwdlhDNEpPSWxOYVlCRHpMNmpwL3NVNURWZmtt?=
 =?utf-8?B?c0M2VEZJczVLR09PaEIvNkJnOGFrbXBURnB0QzVxcjdmcGphM2pPSXN1Ump0?=
 =?utf-8?B?dDF5YWtySWZjcTU2WGRyTm1lWGY2Q0lYSjcvckZxU1hvMElwU0tnRm15ZW5p?=
 =?utf-8?B?bmxLYVIrMC9ZRkdJZnY0SVljNWY3L1cyNDdSWHNMbEN6czB0bllLLy9HYzRj?=
 =?utf-8?B?dVRHZUxJYnA3dmFqNTNsaFV2eldBTi9iK1BMTzFzOGF0bm9pK3A5WFlJNHhL?=
 =?utf-8?B?MlRPdUthUlRFSTFYUEovL0E0RkFwdnZTT1E5Y3d3QmRDODdKVEdlalBtQUhR?=
 =?utf-8?B?UUt6dC9JaFZnK1BKWkFkRDVpeEZvVDFlYVpTWGovVEorLzVMQXdWMlg2UE1a?=
 =?utf-8?B?TTJmRnVEMnJxZkh4L2tsdnRhY05zaHVjWkxGM3ZqU0pWaTJkNlNZMVZIdUh3?=
 =?utf-8?B?KzFEbW0vMnJpTlBYem5UTHRhdE1HcmdpSnFZek1MZTRWVzVSYjlHdVJVVWRP?=
 =?utf-8?B?NHdCSThnb3dadUxQbWRFazIvaDRMejFid1pOMWdsMXBxNklIVkhyRkZNU2tH?=
 =?utf-8?B?YTdjL3hxaHJYejhzMWhaYlROTXMydVp0UUNBMmx4d0trVnY1dVVQbEpUcW9l?=
 =?utf-8?B?Z0JtSGFKRklNOTZaQkxaREJmYnlVd3pZWUFJRmdlWGdSMEtVZ2tzR2VZZDZZ?=
 =?utf-8?B?K210clVBMWhwZi9xdGNZNDU1Y0dkNU9sbEdNbFc5ZmtNdWU3YjlMUTMza21F?=
 =?utf-8?Q?i36ITORt9Vu/3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXdYOEw2eEtLOVN1dy9qZzduR21SKzgraXRlNmhTNFRaclZ4S3BCYWFpRVB5?=
 =?utf-8?B?MHBHL2NxZUxZYXl2TnNTVHNHdEVpVXBMUmRHR2JNTFNxc3RhcGpxQzRoM1p5?=
 =?utf-8?B?a1FqN3M5cjAzN2JqTUVxc1Q3SnZPQUlFNVlMcHl4emFpUFl1VWNRYVJwVjdj?=
 =?utf-8?B?M0hyTGJ2TkwwSlVrTExoNTdVYnpPbkk0U1dLbHlSTXJHdmZOYWd4TDB1amU2?=
 =?utf-8?B?dzNTVm5YOGZvenQ4M0dHb3dVNm5yQThLZU1TVFV0N2hUQ1hDNE9GQlVka1NR?=
 =?utf-8?B?V2tpMndIcnZVNGRzYnJGMVIxUDlmWTBrNWxmMkN1SFpQcjB2NkpQVzIxQ0dI?=
 =?utf-8?B?V3pncXJyYmdENVIvNlJFS3lOR1BLck1IVy81ZDVDaGRHVzNTQmdEMUxzQ1Bm?=
 =?utf-8?B?SERER0hQb3o4a3BPdXdsR2Z3ZFdFL3dNNHVQT2d5U3VTL3ArVHJhMlc2QnJX?=
 =?utf-8?B?UHBibUdrOWhtakEzZkM4SGlGNmtEWEdabWVDbUJYbW1NY1NUaXpzUE1rOUhQ?=
 =?utf-8?B?K3dVSnEra0dWNk8vYU9ybXBrZVJVTndCWEpRbWswRU9NcWVmSXZkR3U2ZnBY?=
 =?utf-8?B?a3dEVmhNMnl4R241S1FiSE80N0JEdHlaaTk2TC8yWnpWeDZRZkdNMjhaeEdj?=
 =?utf-8?B?OEI2blB5RnB6cDJFaFpoQWdEbk0xaUUveDVPKzQyM1JPejVCUGo1Q0FYb0Qx?=
 =?utf-8?B?eTVoSGtqalNJMngyMkYvUU1WSTU2bGpaSVpCQzFma1hZYSttdEJYL3V4WnVj?=
 =?utf-8?B?N1FvVkNWb3ArOENxdU1aUXZsb0xhek5xejg5THV2ZzAzUGVBYXQ4dnZnL21L?=
 =?utf-8?B?amtZQTFQNDJDL2dGNTZnNHhPUkVsZ3VnUXJlVzd6eTZ0OVJTcVV6RVNiV2NK?=
 =?utf-8?B?Mzk2cnFWRnZYMFBNREtQaHY5cTRFb1ZrdWN6UU55Uk51cjdpb2JUSUcrQnQ0?=
 =?utf-8?B?aGdHaHlPbFEyeGtCM2xDVERCWDl2S0lpRmo1d09wdzgxN1hzSmZWclRhTmla?=
 =?utf-8?B?b1hCd2k5NUtMaUFtMDJUTVNNQ0g3ZTMxUHlJVWFTSGgxc0F3SU9Ob0pUTmdw?=
 =?utf-8?B?dW5jSm5IUUJjYnpJRmttbThraUlLalo1bDUrSFFpTVhabzR6K1J1UUJQdklL?=
 =?utf-8?B?YTZIUnRsblVXUjNQL0FSNUQ3UisxMHRWeVJ5ZjIrU0hNQVdnd0FyVmVLa3lJ?=
 =?utf-8?B?SHN5MXN6MzllME9EV012WHFKVGx0dDJvMnRMbUNKU1NGSjBuK1MrTXpzMHFt?=
 =?utf-8?B?akJJUHZSV09NenhURklDTXlnY2t0Z2xOUURvRG5HQzZJR3lieFRIMkZVQ0Y0?=
 =?utf-8?B?cXo2cUZqZXFzZE5VYTV2b3A1QjRsbkVpb25jNTlnNHpSdmtWTWVkSjk5dXVT?=
 =?utf-8?B?T1N5cW5sVXdPZ1haQW5ua0NSdmQ2SSs3WTNVbG9MMjFlL3pMMVdWZnd1R0Iz?=
 =?utf-8?B?NlRMS2lrSW16QzFWY1BlRU14U1VqbnFqcUlvSGJSRjBPT2ZnamhidkdUWmVi?=
 =?utf-8?B?bDE4aFlCWGJKanZ1dElGL3prblB6Z01iZGlXWHNZUEhHYzZHeVF6Sjh3ZElp?=
 =?utf-8?B?Vm9aNml3dTRrM0ZkOThmSE9IaG56aDE2dkkxdmZJbWtkaS9Qdlptd3I2aHZn?=
 =?utf-8?B?UXpOSFdjVmVWY1YrRWQvVHptMmpjZUlwTGhnMWtDNHJJRTlpYVdmS1lRZ3Vy?=
 =?utf-8?B?ZjNoaVpXeDhVMHd3L2kvbkt1M0ZZaU91T2N2LzhkKzRmek55NDE5V1cvWjdH?=
 =?utf-8?B?ZTRTbUkyVXlMb2IvTmM4RFFoZWxWSWlRaTIwODFCcThtcWkveG1OandST01K?=
 =?utf-8?B?SFBBWDZqQ1NuZUtzazcrTlFuQkJ4VE9USWRBRkQxMFgxYmtLcy9NODhrWm5T?=
 =?utf-8?B?aFFZV29vUGRVL2hsQkp3a29hRDJYS0tVcnpMMmFmWkU4R0ozYit4bmNGcklW?=
 =?utf-8?B?YzRidkdYS0pRR1E4dXU2MWVUVFg0eStXZnJMc29zY2srVUZNY3pEU3VyeXpo?=
 =?utf-8?B?WlBaTDlqYWVrNVJNYWRidkp3TFhrS1IzK0hLeDVpRGkrdUs3M3BtRjFmN2ti?=
 =?utf-8?B?ZXcrcmhuVGxvaUFBRHE1dXFlaHpEV0lTdndBb09VdkQyc0lxYmlLNERzRk5W?=
 =?utf-8?Q?fF4TF4TQfyBDwKIoYfrL76VaW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f72cb2e-59ce-445e-a05a-08dd62a2d256
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 02:49:21.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lYf8PUEJay1i7im2iOWyVix76RXzNQ2ZbqlfkjYms1jLXR+w1Gki5rWrcwfgybCPb0MxOfzr8BRK0jv05Ojvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787



On 13/3/25 22:01, Xu Yilun wrote:
>> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_vdevice_tsm_bind *cmd = ucmd->cmd;
>> +	struct iommufd_viommu *viommu;
>> +	struct iommufd_vdevice *vdev;
>> +	struct iommufd_device *idev;
>> +	struct tsm_tdi *tdi;
>> +	int rc = 0;
>> +
>> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> 
> Why need user to input viommu_id? And why get viommu here?
> The viommu is always available after vdevice is allocated, is it?


I thought it may be a good idea to hold a reference while doing 
tsm_tdi_bind(), likely not needed.

> int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> {
> 	...
> 
> 	vdev->viommu = viommu;
> 	refcount_inc(&viommu->obj.users);
> 	...
> }
> 
>> +	if (IS_ERR(viommu))
>> +		return PTR_ERR(viommu);
>> +
>> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
>> +	if (IS_ERR(idev)) {
>> +		rc = PTR_ERR(idev);
>> +		goto out_put_viommu;
>> +	}
>> +
>> +	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
>> +					       IOMMUFD_OBJ_VDEVICE),
>> +			    struct iommufd_vdevice, obj);
>> +	if (IS_ERR(idev)) {
>                     ^
> vdev?

yes.

> 
>> +		rc = PTR_ERR(idev);
>> +		goto out_put_dev;
>> +	}
>> +
>> +	tdi = tsm_tdi_get(idev->dev);
> 
> And do we still need dev_id for the struct device *? vdevice also has
> this info.

Oh, likely no. Probably leftover from multiple rebases, or me not fully 
following what nature these IDs are of (some are just numbers, some are 
guest bdfn).


> int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
> {
>          ...
> 	vdev->dev = idev->dev;
> 	get_device(idev->dev);
>          ...
> }
> 
> 
>> +	if (!tdi) {
>> +		rc = -ENODEV;
>> +		goto out_put_vdev;
>> +	}
>> +
>> +	rc = tsm_tdi_bind(tdi, vdev->id, cmd->kvmfd);
>> +	if (rc)
>> +		goto out_put_tdi;
>> +
>> +	vdev->tsm_bound = true;
>> +
>> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +out_put_tdi:
>> +	tsm_tdi_put(tdi);
>> +out_put_vdev:
>> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
>> +out_put_dev:
>> +	iommufd_put_object(ucmd->ictx, &idev->obj);
>> +out_put_viommu:
>> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
>> +	return rc;
>> +}
> 
> Another concern is do we need an unbind ioctl? We don't bind on vdevice
> create so it seems not symmetrical we only unbind on vdevice destroy.

I'll add it as we progress. Just for now I have no flow to exercise it - 
I accept the device into my SNP VM and that's it but if something in the 
VM is unhappy about the device report, then we'll need to unbind and 
continue using the device as untrusted. Thanks,

(sorry for late response, still going through all comments here and in 
Dan's threads)

> 
> Thanks,
> Yilun
> 
> 

-- 
Alexey


