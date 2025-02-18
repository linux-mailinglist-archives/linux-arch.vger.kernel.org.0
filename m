Return-Path: <linux-arch+bounces-10205-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCBA3AC96
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2025 00:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BE188F937
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 23:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AC1D86F1;
	Tue, 18 Feb 2025 23:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RnhcRISy"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977271CAA67;
	Tue, 18 Feb 2025 23:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739921749; cv=fail; b=unsw5FBviCk7nHBOSSQhTAc6irhx6H6UrbQvhidb0PI1gbLNCv7dKJ9iWUNOmQEmYwgZDwVmsUaZbposJ6gKP0jj/luwv2c/tQVlNgPQvh1vbN59ut0Bx74yQRnxWWZEQUn0PtLBazXN3Jmy9F5KLl6UaZXDMyl7Flo5so2mxF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739921749; c=relaxed/simple;
	bh=muMlvIqUcLF+ovrGpKBj7HnUDZEQwpkl3gsBdXtAjJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYA1eUWr3EJl1HhrfP2dY5ADajvnZdjNu44Mzi2K0Wd8ow9ok5vOvvF6rHVuusmuEqYhb7s5cIA+IP9XAWWPhpZoWD0/C2sgswQ98Ty5f0QefzXk8DspaEbqFoAUsn1nKD6TIOHAMsand94Sk08M+DJank5mRiE8oA/uddCamsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RnhcRISy; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AG5JNBZtCXjDn5eaEvcWyzIw4GMEO9LBGcSz+DhtK8Oe1FKQh9ZAU5fhZZqAtuwrXfJ878J6enBWJEuiSWBC06EX0yDWGi61Bt+5fM0nj+6dIOEM8tttbf1TVB1zKxsr4l1Pe4UVy5vWIBHYYXrjoUVS6JPs8AG+plGs4dUoDgtrXQbekuS+LTOZLDDjCVNmSrw0O8t5DJgr4DI+1fAk2LtXNOIva+nDOzi7EuHNjvTuhMOvfFLifv4uezgFreS6Z0j7O78Tig9nznDLfY4M9BJR/2SWKY0YxnzK5im+2ztA03ipKay64It37k6bPPYY1nlqw3esVg7yCtX4sDTvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2msRbauNI29iakSlQWxGGHad/7AU8nVUYMyJ8UxKTs=;
 b=kFIipG+vwdjVlvYlfehiTBe+Z1fYjNe+JwX8Ge5BfTbnW2J6WGob3AlloG5sPyR30zipvYpMKdRnzNWpvvlJZOGX2o6qCJyVObq8P+i15RbCu68KF8Ut2eWwb3nCQf2mYT1WyNWL/FAEow/+lfnaUWk3BRaQptBr04p36F2XD4by/HLZ7A8taXwh/DWQ79MFsq6CGnrlbVKLYXI1EJzOrF+C1Db/etSsc54a670Ny4lDexF5vQiO7xTOuhNvOBw26XpBfwWE33Z9aUQpEjuofzAXv5MWJn7XupP2b4AIIEP304RR3idlZqm+MO/k22C9tew17XKLkuv//GvF3C3wRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2msRbauNI29iakSlQWxGGHad/7AU8nVUYMyJ8UxKTs=;
 b=RnhcRISyZL2k4ZXZbBbnEG3WPlhf5nfAinjDkxv2E8WL3d5ZlSnj06536lNfaDC35InIR+voSNnAk2IGKwMw6AMen9SX0esrSz6HF0o7qgYbvynH+HYECKDwvfxhyURm2jl0YHg02um3uEmiaAcQQ8CicX1wow5UW9AvTS+u5Q4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 23:35:42 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 23:35:41 +0000
Message-ID: <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
Date: Wed, 19 Feb 2025 10:35:28 +1100
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
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250218141634.GI3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWPR01CA0174.ausprd01.prod.outlook.com
 (2603:10c6:220:1f2::15) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: c16ad51d-0104-458e-ed4f-08dd5074f51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmU5V0xLRzlnYzMvV0hLWUlaNVdvSkVKOXk4YitJaVRGRjljZkdNU3c3Y2hM?=
 =?utf-8?B?a2dxeEZlNVhGWFZmd1BSb1hDdUdQbElWUzFVWWpzbFEyYW9VYU1VQmFJTWhr?=
 =?utf-8?B?cEdDc2pBVU4yTDR4Tk5Fb0JQdE9HanRjbDlPaVJXblVSQ05uVjl3ZmZyalQ2?=
 =?utf-8?B?ek5FRVIwVnRzK25pN2lvSytxSis2NUcyODVVL2FNTGJuNitRS0lZekx0eE5o?=
 =?utf-8?B?OVFzeWRBbG51Qlcxc0VKd2FRZk5PcHBSRmdDYlVaTFU3NUlhbTd6ZGRLazYr?=
 =?utf-8?B?YzE3VlVXdHQ2MnFmdDhZNTNjTFFvODlkck40MS9wbTVGc3BYUVh4NVVUYWx1?=
 =?utf-8?B?eWFLYXdhTUo4TG9ES0diYytpY2l3MjR5N0tPSFdhSmxTTHNGRmQvVU0wd2NN?=
 =?utf-8?B?Yy9wcDhrOXV6Q0ZVTUJZYUNaVENtdmVrdEFZa0p1dGhoaXV0YytKaTZyUWJw?=
 =?utf-8?B?UlVYTFRjKzRoZ3g5c0QweUdRVmlrTXo4Ym4vTzgrcTkzYUJOcUc1b0NIV1M2?=
 =?utf-8?B?M1dDS2Rnc3Jua3Z4UE9Ocko3WFprengxTWRoRkRBOUNUZXllK3BWY1I4dlY1?=
 =?utf-8?B?S1JhVkJjdnRuMjIxSjUrdG5YU2NndlV6Uzc0MHhyQXdsVU1VVm1NWUQ5ZkRQ?=
 =?utf-8?B?dnBzRmx6NThnbENUckJBNjJ5R2libklOMUUzbVRuaG1zTnVyM0g1T3YvWkp3?=
 =?utf-8?B?N0hTUzh2YjBtbUFnb0N3cS9ZR3VxejBDdThxOHIzcHNmR0FJejFLNGs5L0dk?=
 =?utf-8?B?WEZWaS8yc0NISTk0a2lzMHBpbytKS3czb25PMFZqOWJoaFVhM1pnMlY2Nml2?=
 =?utf-8?B?emYzOVFXb0dXUEhiREd4dEx0Q3UxNmdCN3hNOXBXbEdWOWNIMzdjNm9hV2Ra?=
 =?utf-8?B?ckF1RHJja0hWWHdua3BXUHhPTEJJdjZtUy9YN2F2eWNoWkhyRlB4V3A4Mmtu?=
 =?utf-8?B?RjNuVUsrRnNQWHBoOHhmZDlEbVRVZkU4ZzNDT3kxMjlXMHNhbWxDck1ncnZo?=
 =?utf-8?B?WlZleFVNU2czY3ZhZmV1Q1czVkpLMHhmcjlPM0V5MlJncWpHYjN2RDlldmRS?=
 =?utf-8?B?ejVteFdBVEw0SFowYU5HMUN3V3g2NmVPN2VQM2xxTzBBZ0pIWGdOenRJbFJi?=
 =?utf-8?B?V2pGSFVGdXg0YUhjbVladkU5eHM0RVBuY3dsczB6TnQyYkpYeXVWZXFNN2dn?=
 =?utf-8?B?UzFESGdkc1M0OVo2Z0VXOG5LWm5qMnEvZWZNL2xPQkZhbFU0blcrWjNrUFQx?=
 =?utf-8?B?bHY5cUNaSEhlUWJtWWZQMlhGbDVwZ1FwcGc0SHFWYjRHT1FiRzFPbWQxQ0xS?=
 =?utf-8?B?bUozd2FtanRZbDhuKzZxajhYS2s2YnVSL2ZjSjBOWXVNK1p2U3BvN1hBYlMv?=
 =?utf-8?B?RHc1d3c3aHg1UVdEbDA5eGdhbFgrdUVWdUdQZkZDcktjREJFdXpOeHZtVjAy?=
 =?utf-8?B?R0lONUoxa1p6T3ZIUzREWGYzK2tLLzRLNHVVS3VCSmZYNFkzNGNMaUhLUW5l?=
 =?utf-8?B?bXl4SEVvcGVRK08wODUvcVN2RDZaNDgzVG1Ndk8zMDNqRmI5WW5jZzkzNmFW?=
 =?utf-8?B?a3FCbkNZK2NkU0JtRGlLdEs3YXl2OC96RUdTNUtjZWlQQTlYMXZhYkZkSjBK?=
 =?utf-8?B?c01uZkp2b1pPMHU1dWYwTnFGZUxWTGVDck5mcFBveFZoM280UGpXZkJHQVRw?=
 =?utf-8?B?OGxoWllreHdod0dqcUpRazJMSkZ5VFhoUWljUkJUSVVXZjNOMTlWOFpNcUk4?=
 =?utf-8?B?M1VtdFR1SXg5ZGhNWnJhNkp0Mm42ODBzWTZ0bzVIWmp0bFc2eWYvRE9CQnlm?=
 =?utf-8?B?UmV0QXRUNVhDWklqbFordDZSaDRPNVUxN1VpSUk5MXR0T1BDUDc3Vk8yUXU1?=
 =?utf-8?Q?b337Rj/iYQc+M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODB0MVBVZjJvVHc1UDc5Yk9LTmRjVUhaOFNqSFhYUFZrelFGZElKdXFWc1VR?=
 =?utf-8?B?TnFtVjlGYThHM2FKRVpTWkxHWktBbzhJdWZHWkN3RWE5TDVTK0xCQlNsVlQv?=
 =?utf-8?B?SG55NHBQSis4VDVrcFRidHBvWmtUVXF5T3dNRnVyQkx5ZFpLNnp3c29MUitH?=
 =?utf-8?B?TmtrRmlnNldOUUxvRnE0WVlvZ0l3Vllaa21LMXNUdzVEcXlpWnhFb3BaNURv?=
 =?utf-8?B?RmZZeGZ1THZiSG5EcjNMSm5tYk1kVmd4L3cyK1V0b1dKb1FXUWNza1FwUXds?=
 =?utf-8?B?Vy9ENUovRTFuWEo3YXBaaG5YUlNqSnhsK2ZNNzNLaWgrWG9hTlV3RHZjem9y?=
 =?utf-8?B?b1E3YWxhQXU1K3hDMUlZeitydUV6MTdaZW8xMGdwS3Iyem1wbEphOUVCUHNa?=
 =?utf-8?B?aHBpY1RMa01TbWpWSDNhNlhuWHdLYjFiRlpUcXAxQWxXLzlUQmJUSzhoSFI1?=
 =?utf-8?B?d0FBbXFUZkpoR0RtY1RtdTZNQnBtS3Vma2U4M1IzUkFiQTJweGd1R0VuL1dJ?=
 =?utf-8?B?aGdicFBNMzV3NVRDYkFJNFpYVDF5eXYyTkRNSVMreTluWmZyeU43MEtMVjla?=
 =?utf-8?B?L29mclVhWGROWUh0T2RNU0p3TDNzeEJ6L05QYW1aQXpjSjVLS2NyUCtRUzRS?=
 =?utf-8?B?LzB3bk9Xa0hBVnBzQ3Z6dDg1cUZxZlIwMTBSb2RzeHloTW9SOExrUFpjcDZC?=
 =?utf-8?B?T3cwcnlhMkp6Q1hWRUltTnF2WjJBNFpqTmFpajBKWTZDK2pGSTMrMWV6S0lx?=
 =?utf-8?B?bGZSN0NGY3YwOWJSeWdSUExXc1VJMmI0bVFJdnFsdzQzVnpvNm91TythRDFq?=
 =?utf-8?B?NlJJWU1QcmVHMHd1M29UbTR0QzdDTFRISDZ5RjZzYzAwUkVmbWpVZi8vekR4?=
 =?utf-8?B?T1B2SFprdjRXTDF1eWZPcUkyOGhnUms1dW5GdS9IWHVySmZNK2hsTXJqdXRN?=
 =?utf-8?B?bmlMUER1MHJoaDZvNGtsUHY2TzF3djhJOWgwdlJiQjJHYkIvREhJdDZ6dFl5?=
 =?utf-8?B?VHl5WGQ2cVl6ZzRYSFdPZ3ZabnBJVHBVVGlnWGhxWFFlL3QzYmpiOE5VZXRl?=
 =?utf-8?B?S1FUSU1LWGEwWVBGRTZmd2lmQkNaSU5vNzVYUHBRQkRybjI2cnI3K2lXays4?=
 =?utf-8?B?aVpBK1lURjZCL2Exb0NYWnpiSGtkTmVuQ2JVMnVnUmM2bktZc2dHK1ZBTmFk?=
 =?utf-8?B?aElBblpmYVMxME1mZzNlS1c5eXlvWW82bzdSbkV6MGxFYWR5TmIxVWpVTmpw?=
 =?utf-8?B?c0xYYXZqREk3Z3dnZHhvR0JYQkdyMFY4aldTNStlUEdYZU1MTWl4OHd3T0R3?=
 =?utf-8?B?NEJwQ1VSYXB3OFE1OWlyOG5iZElJcVFmNnlYUk5SaG1WdTVPUUk2ZUV5clNK?=
 =?utf-8?B?dWNrSDYrNUNhemNiM3NIS0ZzU01DTVFxT3NqZER4SFI1aFAwSEx5M0FwSkN6?=
 =?utf-8?B?bHBEODBqOUhuaHhSeDA3Z1R5WjUxRzl4T1NraWM2OVVUSmRZQ3lnV0NHSExP?=
 =?utf-8?B?MkdMMS9TWC9pUWIzc3dBTzBXTW5wQVM0ZFg3WjR5czVHQ1g0QUpGU1RWYnM1?=
 =?utf-8?B?NHh5R2w5WTNrZ2ZkZG1TYXRSZmtWQTRRd2xqWFVESzBBNHA0enRZdFgwdjVX?=
 =?utf-8?B?azdUb3dZRWRtdnpOWXF2SEwyU1FtV1RudWdoc2dsRkZOVXRYdjd2U1dkUkpI?=
 =?utf-8?B?UjVnNFlRTzdPTW1meFM2ODd0WjZzYWFyVDdnaDgzSzlOaEhITEw1elFNdXdX?=
 =?utf-8?B?ZThyZlU4bHduRkJzOVV6NFJIZTRXTkt6Z2pqNklyamdycFNWaDE2WklIY0xq?=
 =?utf-8?B?dSszWjdqS0k4Uzl5aU5JWGE1VXQwN1pDSnEwNjYveWFWb1JRdnYrZm44NGlk?=
 =?utf-8?B?OVhaNVpRRUNLTWZQUVl3RHZNR2pOSk81WmdDQ21yczBzQTczZGsxSjZBZ3VK?=
 =?utf-8?B?aW9oVFI2WUtONFVUejJ1VjFMMFZwT3RuU1hzS2VaU1I2cHBPczdRYjlJU2tN?=
 =?utf-8?B?RDFFdC8xWWQ2SUVlWlU4NlozbjdzU0c4RTN0S0JNOTZHU3g2K2FaVlA1MlVG?=
 =?utf-8?B?bnZ4TmwyQzNUNmJKTWRuODlkZWpyTHZNMGlpa1AxYXRJbUYzaTJxc1VBWExM?=
 =?utf-8?Q?+TIrDZoo8FaIrvrvMTv/oiOTZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c16ad51d-0104-458e-ed4f-08dd5074f51c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 23:35:41.8689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwyWV03hRN3NKH0qHDbJlNmK4xyu/oV3RaxzWvh9MRSfr8goUgZ+3Rayzr+dfDNaevxn1WCiYkZBsCfdSevTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806



On 19/2/25 01:16, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2025 at 10:09:59PM +1100, Alexey Kardashevskiy wrote:
>> CoCo VMs get their private memory allocated from guest_memfd
>> ("gmemfd") which is a KVM facility similar to memfd.
>> At the moment gmemfds cannot mmap() so the usual GUP API does
>> not work on these as expected.
>>
>> Use the existing IOMMU_IOAS_MAP_FILE API to allow mapping from
>> fd + offset. Detect the gmemfd case in pfn_reader_user_pin() and
>> simplified mapping.
>>
>> The long term plan is to ditch this workaround and follow
>> the usual memfd path.
> 
> How is that possible though?

dunno, things evolve over years and converge somehow :)

>> +static struct folio *guest_memfd_get_pfn(struct file *file, unsigned long index,
>> +					 unsigned long *pfn, int *max_order)
>> +{
>> +	struct folio *folio;
>> +	int ret = 0;
>> +
>> +	folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
>> +
>> +	if (IS_ERR(folio))
>> +		return folio;
>> +
>> +	if (folio_test_hwpoison(folio)) {
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +		return ERR_PTR(-EHWPOISON);
>> +	}
>> +
>> +	*pfn = folio_pfn(folio) + (index & (folio_nr_pages(folio) - 1));
>> +	if (!max_order)
>> +		goto unlock_exit;
>> +
>> +	/* Refs for unpin_user_page_range_dirty_lock->gup_put_folio(FOLL_PIN) */
>> +	ret = folio_add_pins(folio, 1);
>> +	folio_put(folio); /* Drop ref from filemap_grab_folio */
>> +
>> +unlock_exit:
>> +	folio_unlock(folio);
>> +	if (ret)
>> +		folio = ERR_PTR(ret);
>> +
>> +	return folio;
>> +}
> 
> Connecting iommufd to guestmemfd through the FD is broadly the right
> idea, but I'm not sure this matches the design of guestmemfd regarding
> pinnability. IIRC they were adamant that the pages would not be
> pinned..

uff I thought it was about "not mapped" rather than "non pinned".

> folio_add_pins() just prevents the folio from being freed, it doesn't
> prevent the guestmemfd code from messing with the filemap.
> 
> You should separate this from the rest of the series and discuss it
> directly with the guestmemfd maintainers.

Alright, thanks for the suggestion.

> As I understood it the requirement here is to have some kind of
> invalidation callback so that iommufd can drop mappings,

Since shared<->private conversion is an ioctl() (kvm/gmemfd) so it is 
ioctl() for iommufd then too. Oh well.

> but I don't
> really know and AFAIK AMD is special in wanting private pages mapped
> to the hypervisor iommu..

With in-place conversion, we could map the entire guest once in the HV 
IOMMU and control the Cbit via the guest's IOMMU table (when available). 
Thanks,


-- 
Alexey


