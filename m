Return-Path: <linux-arch+bounces-12128-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAECAC77AB
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 07:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E294A20D59
	for <lists+linux-arch@lfdr.de>; Thu, 29 May 2025 05:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF924685;
	Thu, 29 May 2025 05:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gdEm7s29"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9B27701;
	Thu, 29 May 2025 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748496656; cv=fail; b=tuOMI60UCdpyrQ5p1igpy+SwG8Jv9qsRmQwZPfJm+nzcZ1oOUfsuRCYGU6F6SWuL3HZSFf58/fFbpbsBa/NNN8xSL3XVOX0AZMtOM26LKY+oswTMAgfkwv7JY7ToTvyFSfQQzxBz4lmvyXdPOm3sW0uGJAVrtlq1oUskNuI3WqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748496656; c=relaxed/simple;
	bh=lMF37M836GP9DIpF6IMkWIVOhuJXkB36OP2E/SP7JS8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxwPaE6yqpJZjA5IRcovGCSPKEHEsIdX0HAnHAciTkhyRs6hzFoM0af4zH8l3YDcgR7S6z71lAuwvE4UX5X7sPszh2byfqhQmg7/UHb57yDrCby3SN8DWrFFFV2nO1PO81IxhQoev/muXQYEEjgDByonzBgbFV6mlRnXhX8I1Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gdEm7s29; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uedM4Pg0/rCd/hal6oVbQbhzhNjOxfc99fyc9WImNYXBsHY8NCuQ6FyRhw8Ms5DFvJaGjOdF6CvIdK5M139cSgVXvNNCrHjGqIm7HU9HlU6t+8c0R9kXx/Z2F/AN7QQeNdQqvdhorayCbdEmNAXuaXP3rMAMJsDZX2QvF6wp1hqLJ21sGf450BWAQiom4F1BNJaYcySRE4cHS40Pg2pKOA5FZSI7VjLvOkAXWwxjYx12KsbXRNy4eCxOp0AZiouCq1suXZXB3UdMwuX/NIFQIlKGYRILwhEaAolkU5R7x6ET6IBeviYhednX1L1AHVsNE7q7aT2049a4Lux8R37n8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwuKt7iAuSRXQPOWLq2PPiyMuzkKeHx709uTHlrEjuE=;
 b=YfQ2IbJaBwBvpQXFsX7Fn+iHl0e+8Wlg89tbID8UBLS1ZtIcBz7IocLrUNu8aLszZxRKDepjyxQZPz+fi7A3UQzHRVreQGaAS355F4Bv1WYrQ6+lfGiqIMvIfu+i+yqiP/yW4kcEnFvgNb1Uw0zlt6brFr7zs7+59IAogfZ1hzz0WIe4YzHvLqMjTmcSxpaFC3aJ8iZQz+Q/BQeG4SLb/tGtyzOBFWRqh944xguCwGVwLZM0J7IV+pH/YnrzsAeKtgTXSok76xC8i+eMuHT7xCA73hjN7SZY0eXc5QvWBaeXOsOPgMXraTDcC8Xc4Ntx2rwXNbUesEMI8/7AaMj+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwuKt7iAuSRXQPOWLq2PPiyMuzkKeHx709uTHlrEjuE=;
 b=gdEm7s29l8mKdPMdYNM+QqLu9DrHpVY/cRJLIMDTE0gOqSIED/hrRkUEYXXFVGap0w69iWlzHpHSpSmnX27EF5C0zA5CixQB9lSByYc7PLoGNR+sgn/yzX+klrK1r0frZVVcaJ4uLf+b25Ts4qjm6ZHR5WuKIc4pkdh6LmWrBFA=
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
 05:30:39 +0000
Message-ID: <ca10bd95-5e86-4845-8310-7a408d138499@amd.com>
Date: Thu, 29 May 2025 15:30:28 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 15/22] KVM: X86: Handle private MMIO as shared
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
 <20250218111017.491719-16-aik@amd.com>
 <20250515111829.45e31bf2.zhiw@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250515111829.45e31bf2.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-MS-Office365-Filtering-Correlation-Id: daab0de0-c1a1-432b-1911-08dd9e71f23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUxzeWF3VGdjOG1CRGxMOW56bE9wZkNPajZueWRSR2lqeFU1WVptNmE4RlFa?=
 =?utf-8?B?RHAxaldqTFdqNW5hRGpUaEZFVGdsSmZ3Lzc1Z3Z1QlBhZ3JJYTdxOERZaVdy?=
 =?utf-8?B?MGtzNE1XZ1BiQzRLUmNod0VzcEtxNXVUS3Q0Q0cySWZsRS9vWHRFb3ViRDR5?=
 =?utf-8?B?UzR4QjlYS2VpeWtzemVvTFVab3dySE9kYVMzWFFaK2l1OUIrcmdrK1pYNVJC?=
 =?utf-8?B?V250Smc5cjhVOHVhKzY4by83T1FEZFRmY2tPVlA2VXdHNE50SFpCMDNjamUy?=
 =?utf-8?B?dW1XUlg0K0tFWUFuRk5zOEdIU29NTE5oMWZOSmRJSk5PSEw4aWoyRHd0Mi9H?=
 =?utf-8?B?MGcwajhmT1hkT2xnVkl5YkQ0Tjk3bWp2V0dGVENBdXdQWVBUZUdFZWw3RnhC?=
 =?utf-8?B?YTVaTFZOMWZKNklRZmFGWGp2Njc0STlScEFCdERXTnNLblBCOFNySUFsV0do?=
 =?utf-8?B?ZWlIZ245RUlLTjVsSUtOZTV3bWJGdUlNV2hYVTlwa2wyNmNSYm14OVFuQzFv?=
 =?utf-8?B?RWx0ZitjN3JYSjBZZWhKWFFsOWtlYVl3SWpUZHZoKytoUHJRNEFIckZaMUd6?=
 =?utf-8?B?Nm9nSTZINUM1eW90ZjF5SnlHZThwQ0ZLZUFLREtOcXNyL3BVT2RjOXBYZTBC?=
 =?utf-8?B?MUVpQUxvcWNCbjVoVC9QVlExSjhtWlU1TVM3ZXNsTDJCR2NOaWFBeHpEVzRx?=
 =?utf-8?B?Z0xBT3NGeVJDMURoRHQxQTRsS1Vta1MrVG1DMEJ4WU9YbjZjS04vQ3Vwb0pj?=
 =?utf-8?B?YnprRExLc3pvTWRoV3FVK2t2eXU5MlZidzZoNmQ1SVA5VXhZdVlLYmVSVGRz?=
 =?utf-8?B?dmVoSWpSRGRkV1Y4N2dDZmtEVDgrOFdCOHN2eEpmMmMzTXlkck9tK25ma0h1?=
 =?utf-8?B?dEd2K0lFdythZXhaYmZEdTdtUDc0ZzM0dWFYMG42ZmJuMTFQSHRseHllVGo3?=
 =?utf-8?B?ajg5WCttQ1NMM1EzNVJMcGNBbS9ZeXd3T0F2YlNMVmxpVTJiTnZUVVNPY3RD?=
 =?utf-8?B?UVhjb0djUHdZaEVjKzB6dHVaOUhwcTN0VHM0Q3huMzhMek4xS2RqdENQMTY2?=
 =?utf-8?B?b0tVdk1TbmNUMWVmMGxvU0pLZWN4ZDBtQjIwaFA2YTFIYnlkVmtJQWxaWEZX?=
 =?utf-8?B?dmdmZEM3ZG1pNGdSUXM2dWRLeThwL0wyaFJ3OHlrYTMrc3hoQUdXRE1oM0px?=
 =?utf-8?B?VmQ0aE1qSllNV20wY1p3Y216R3ZmUEd3cERiUTJHRWpHOUF3OTFOQWFrQ3Zl?=
 =?utf-8?B?QjR4bTlxNmlCcEpoa0ZlaXpLeXNJUERjMHExZW5Wd0hPZFJYdEEzYm5ma2Ey?=
 =?utf-8?B?M1Q4UDduU0N4Mzd6d1RlQjJHYkJHWHBxSk9IOWViRm9OMzU5eXE2djZYTWF2?=
 =?utf-8?B?cWVIQlBCUVRxYjRacVhwTjdPaXp5aHZzdnRRSXlsMWpwZzcvWm9FR3RlT2Y2?=
 =?utf-8?B?ZnorZ0dWVkQ5UXNpQnJjT2R6TGtZT1FhUE9aYjhibXVvbVN2OEZ4eXlSNExh?=
 =?utf-8?B?WU5SamFoaUtKTzg1aWFReUJEeFZMNGdDTE5Ua3RjT1IxOHVlN1BvMkFJR1hX?=
 =?utf-8?B?dXkyWGJwalR0VE5sdnMxdmVBTkE5NEhGaUZFM0pqWWFlM0xYN3M2T3dtc09x?=
 =?utf-8?B?Rjg3MTNYWnA1Z0tJWVVneTIybk9jeVQzNmNsb0FlTkdreU9Ob1Z4WlBDMmMz?=
 =?utf-8?B?UTZDSTg0UDNrR2U1cVl3N01scnhPSHlNczVVMnZXOFhJUjlBbG93Tjl1aW9X?=
 =?utf-8?B?ckJSQy9FaXVRTWUxN0plS1J4YVROZkJtcXdMN0VESnl0VUZWbk9SNFhjeWMz?=
 =?utf-8?B?M00xZ09oYk9mR0RmbDg2V2RONllxbGpONnNRRzFxM0tYMHhid2NESktSNXpC?=
 =?utf-8?B?dm1uTStWMDVKcmxHSVVVMVJTbjVIbGUyUTlQTUF5VXBoMUR0TFZKbmJGN3Ny?=
 =?utf-8?Q?QQkjDfBpMXc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dy9HMFNGSkdxd0JhNlhtVjA2RDZFMmJpVW9pK3JmV3U0blY4cTB0NHBad0JZ?=
 =?utf-8?B?VHNtay96OExNWnZaVFJLbnpiNVNpWGVaRlZnV2t1YnVXNkc5YStrTFdIamlI?=
 =?utf-8?B?Skp0Y20xem9zeldKWUpHVTRHTk4wZTd5OVdLSjlEamwzemF3MUl5WlJaWkJG?=
 =?utf-8?B?cnZMSVJ0NGZncWQ0VTQyYk52VXJ3ZTk3NzdUU0t5RTFsTmhQdjB2S0x5TDVW?=
 =?utf-8?B?ekh4S1BwQUNhWVF6TEVoWGxRTVJEKzhBbDV1NDBkLzJkT2tvLzNDUkZPNWR5?=
 =?utf-8?B?OEpPdkVxUHBiV0Urb3JnTHdoRXBEZFI2SkREeXVjV21CNUVINERuNUQ3TUds?=
 =?utf-8?B?WFdVdzMyYTF6dXBhQ3N0OEZBNWEwYXcxcXIzeng0YTRZN3dLb0VrL3pvY1gx?=
 =?utf-8?B?RTcvSTd5N0VqbGVBM2lRb3kxRzFyNTNoOXFiTnVPQ2ZIZ3A5bnJhTkZhaXEw?=
 =?utf-8?B?Si8rV04vTzMySnRqY0FjNndsYzR4QmwyTWhoUWlrSlBXWWhmcjBoeHVNUFZ3?=
 =?utf-8?B?TGdDaHZMRWZoYUM0YURlL2JUdVVucjJNRDRmNDFOd0lxcHFXMy9VVy94MGoz?=
 =?utf-8?B?WEJOdFptWDVpemhoeXEyWmVxUFBoR0VLRXY0YU9VWjQ4eWpCVXJFTFhLYXE2?=
 =?utf-8?B?azdYelZFTXZDUHkyeVdjdzZlaUJkekI4NXdFVkFHWEhCQzE5YllBVTJTL1Er?=
 =?utf-8?B?R0crSGxpR2NkME84Sis4Z1I3T3ZXWFZEeUwwdE9mZXdwZDk0ODl2VkprVFY1?=
 =?utf-8?B?VnFMWmVaZjYvTWhmMGI1YjB0VCtSamxXeFRMbVJtaEVxSlhFb3c0dUNqcEFI?=
 =?utf-8?B?OTBWOEZBUDNjWGU1UE1XZTNkbnpoMUhGcVFYMGkwQWdlRFdzUDBuNXM3RS9k?=
 =?utf-8?B?MEFSSXZjczRPNHRmaGVkUm9USXhMSFo4TnpPK1NncFo0TlIvRnJMaHhnWjFu?=
 =?utf-8?B?dWRXZ0Q4VDhqN2o5Z3drRkRZQjArL2pxY2lBK1E0UWFWaUhIWGNYaXRMNUFh?=
 =?utf-8?B?VUZtVFpUck1SWnhtSVdnMWl1cXJRSUdjbWdyMStQQjRic0wzYXNIekNabzdX?=
 =?utf-8?B?VSsvMDRQYjhYSUw2L2NNeDRCZlBsYjZXUExNWU9NVVgyK3g0NE5JcUZsVzJP?=
 =?utf-8?B?b3lKenZNWmw0clBLUWRndGJwdC9YelRXRzJRZ1A0Wm5FYjlIeDB0TXlnUFhm?=
 =?utf-8?B?RFVpUS9mRlI5WUswckhLOHFieUpUT2NKdFVxRXpoZzRsZ1VwOUlOR2JreS9J?=
 =?utf-8?B?dXAxVFZGaWJUb3pRRVhZWmFtb1NoY3pkMiszYzIvNzlIOWhyK01yTisrQ1gz?=
 =?utf-8?B?bWNFT1g2RGZqZmJLdS9vampUbWhhNFh1LzBsVDlNYkEvaGIrSmVSNElablY3?=
 =?utf-8?B?UHVKdHFzbC9rd21wZTN2ZExyMmF0WXJuVlVVUk1jbGV5VmpWd0FEUjBsM2Rv?=
 =?utf-8?B?NTNRTlBndnRqZTZ0bHNzeEJ0c0NselNKWGpHV1dQeFlIVVdHNkphQUlaUVJy?=
 =?utf-8?B?allZVDAzU09xeFFYRU1GS0RTclIyMUU4Nzhpb1JtVU13RGxsOGIrOTZpejVx?=
 =?utf-8?B?NC9wN0ZmY3k1V1pMcm8raXgwNXpRZy9jTkNPa0UzUzVlSmJVMktueDVBZUta?=
 =?utf-8?B?L0MzVFFFUUlZMkVybkYxVWZnam1kV2JyUUJualpKWmdKUlFpTUZqWWJId1dx?=
 =?utf-8?B?dDN0Z2hGdzFXNHg4bytIemZtYktOTVJrWWdxVnMxb0g4MU1MMUZKR3RYQ3F0?=
 =?utf-8?B?QS9CbnVRZGZPdWhQWWxMQzlzNExiNkVCQklCaFMwUWVrNEFHYk1HL0VwRVFo?=
 =?utf-8?B?OXJrYTBFWStOR1NSK0htQ2MyeFpka21wQ2NsWXJHdk44TUlBSWl5MW01OE1W?=
 =?utf-8?B?dzRHMzE2empUOHROYzM3WlZlVkFVOWIySFlIRlRMY21Ua1RTN2h0bWZCcVY2?=
 =?utf-8?B?Tjg5OHNaSDUrcDhPZHhlQmtOdzFqYVorT3lEV0xlSGhGQ2NhQk9mQnNCcS9Y?=
 =?utf-8?B?SXlKV1E0ZnNXN2k1cnlUR2tyY0JIM1VLMFNVdjZlZ090NEo4Q2JMY3JRM3dM?=
 =?utf-8?B?eVAvUHhjSy80UE0vVktrb0JWR2dhN3N0eE9jN1RHa2YzRFZLamJibDZFcmg4?=
 =?utf-8?Q?vr5r8rUSAwt/aIYmP+SrallmW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daab0de0-c1a1-432b-1911-08dd9e71f23a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:30:39.2024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aVMJHVc2rlBOyj4wuCuhbbKST9HjKWvuwYft0qoeONI50Ysz5xVaPUBb8qvBB5Joz0xszm8p+2loocPEXUivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884



On 15/5/25 18:18, Zhi Wang wrote:
> On Tue, 18 Feb 2025 22:10:02 +1100
> Alexey Kardashevskiy <aik@amd.com> wrote:
> 
>> Currently private MMIO nested page faults are not expected so when
>> such fault occurs, KVM tries moving the faulted page from private to
>> shared which is not going to work as private MMIO is not backed by
>> memfd.
>>
>> Handle private MMIO as shared: skip page state change and memfd
>> page state tracking.
>>
>> The MMIO KVM memory slot is still marked as shared as the guest can
>> access it as private or shared so marking the MMIO slot as private
>> is not going to help.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>   arch/x86/kvm/mmu/mmu.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index 74c20dbb92da..32e27080b1c7 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -4347,7 +4347,11 @@ static int __kvm_mmu_faultin_pfn(struct
>> kvm_vcpu *vcpu, {
>>   	unsigned int foll = fault->write ? FOLL_WRITE : 0;
>>   
>> -	if (fault->is_private)
>> +	if (fault->slot && fault->is_private &&
>> !kvm_slot_can_be_private(fault->slot) &&
>> +	    (vcpu->kvm->arch.vm_type == KVM_X86_SNP_VM))
>> +		pr_warn("%s: private SEV TIO MMIO fault for
>> fault->gfn=%llx\n",
>> +			__func__, fault->gfn);
>> +	else if (fault->is_private)
>>   		return kvm_mmu_faultin_pfn_private(vcpu, fault);
>>   
> 
> Let's fold this in a macro and make this more informative with comments.

Rather than this, https://lore.kernel.org/r/20250107142719.179636-1-yilun.xu@linux.intel.com  seems to be the way to go. Thanks,


> 
>>   	foll |= FOLL_NOWAIT;
> 

-- 
Alexey


