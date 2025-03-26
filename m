Return-Path: <linux-arch+bounces-11129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4958A70FE3
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 05:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68987189A5EA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 04:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB745165F16;
	Wed, 26 Mar 2025 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l0bD727f"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B543130A7D;
	Wed, 26 Mar 2025 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742963197; cv=fail; b=EAKEhb3uZkIay520MrwzRuXH/qc61RpjGoom1rkGl3PvJRm5+Nwt+91UJIOcIUkGajSmiiy4YLZYTo3OiFmJ8gAetbsds9PtSLrRx+hAeecgVkVP07oIc985/QIQZt2W2QSIq/BvNceGEOt5Nbk5iHaDVTy4ZWyWc1y3Cil73yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742963197; c=relaxed/simple;
	bh=VaQvaRtKhCVF2NWuZIDRLVX6SzG7/ZxvYcgpaN8v87k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o01QJ1Y53PKPgoURiurWf1bW5BCeViGKDyB+x92J4rfvI8xotb9nDF82b5PigPChAYXzezAMJjhFG5oHdRcriuQX+vyLCDxZESN7gQ2Nwn38r+mjXNWZ6CJijTjW5yMaTL8U3ziqiAov2G1gIY/VeVbrfoEhddX5YAvmEi9ZBqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l0bD727f; arc=fail smtp.client-ip=40.107.92.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6k4j6/RveLZRY1zfwdV6JpdGEe06cFfW0zoGaVLpC1nFKSpoTzRaUF/DLN+Rgpx4BtyC3k7a4eoZgajo8hqvBlS3YQPo34/Fw/4FEL2t4JnV/oDJmYsYbN85H7BKwQNpYOG3gIY1U4uTN8RPOwRJb84NEU0e/g6uvMyiQBBrdqQu8PToNrw3b2NJCmzx4Dk5/BZM5qzMb7zbIzZzHk48xddxlRnqK6yOhG04xJWuaYFv1ywcU8tLBdhtB73GEC6QFdJnYYSJmleXSMRRm65+LVSJ/2pP8ElHD3xbr4UYad65dEe6xGevCmYF4kfh3zSj0tAR8blUI+iu28n0bFt3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siFjqx67TIeUW2F9kqCvK5OVhMZ2DdPsXHO06MeGGho=;
 b=Vgza5ZEuRcFbfWyD6WRvDP3SFjfcr8I0IsFR8KDckDLwLFdBhp9vR4LDtQ0ijbPQbhb7Jf9m86vzVmsy3pgiVyCHrqytuHJQI7M+BjQez//7OKP+5zZLQMPHaNlorrEv0hl8PbCtXe2Vs/K+1RTDvVdq7ZrcgIBnaJUHHOQahl0zi2gZxmM8MdiIByUXOwenEf7XiUotGCiVroUKpbhDORDgIs88Y3k7kHdtaiNf51OVJAgQmyIzT9uT5qtmgOhmZvoXp9nuYAyvgZJ4nKGNvWCyOGL1DXnbsVsCNc6NcM8cHd+VdgyvNOEKL1KTE6WPTUA3tqVs/KegFtc0Mh89CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siFjqx67TIeUW2F9kqCvK5OVhMZ2DdPsXHO06MeGGho=;
 b=l0bD727fGWxmTsxiDjez6NUmpZGIu4ES6xI5yOIdRCl1Ckfsn9dDgnbnAVHQiOHBgyEhqdMfbS3hmUsstqzLud1uyH23L+kw91H6q6T0OURPy8C2+s6UOW9Vske/ifwAWCyZdEr3hjQZwz+odb2E0t43mleuM0NVSqYRjBngCtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 04:26:33 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 04:26:32 +0000
Message-ID: <bb1b8e3e-85e5-44c7-97b4-c8f86ecbf5c2@amd.com>
Date: Wed, 26 Mar 2025 15:26:17 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 05/22] crypto: ccp: Enable SEV-TIO feature in the
 PSP when supported
Content-Language: en-US
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com, baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com, dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca, joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de,
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com, robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com, suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com, vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, zhiw@nvidia.com
References: <7177c7ae24b9f7ebbfc001166e09beadb81305ae.camel@gmail.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <7177c7ae24b9f7ebbfc001166e09beadb81305ae.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3PR01CA0071.ausprd01.prod.outlook.com
 (2603:10c6:220:1c1::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: df321fc1-92f8-4957-7e3a-08dd6c1e6309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWk0bGtqRDBlZXM0T3gzdEFoeVNkY3B4dTlDMjJXeUtRQWlpNXY0ZGtqMWly?=
 =?utf-8?B?WGJoL0ZMOElmL2NxamZjSWZTME5Ydjl5MFpodnJwRlAyaGVYcEZEK0hOTlAv?=
 =?utf-8?B?azE0eHpQZWF2UXRYWXlwcGVlcFBlampiRDZvR1pvN1RzbjQweDRVeUNjYjFZ?=
 =?utf-8?B?VTUwWVlZQUlUdnMrRU13V1E4RTJLRWF3ZnV0ZVAvMkdoaEhORUl0SHdFR2FZ?=
 =?utf-8?B?eVRzK3dzRWFSdStPNzVJQ3NSRzNBTWdNMlZ5MzdNOCtMWDFFVS8zNzVpWFhx?=
 =?utf-8?B?RzRqM1d6ZzlTNWxFcEVtcnRoOHlqNnlrREh4b0lkTUN5RTEzQmIrYzBFOXNY?=
 =?utf-8?B?TVBYVWlOZUJqbnhGQVNVM2VQSVVBS25FQUlJblJlYVB5Qk5lMXdSOEhBRjda?=
 =?utf-8?B?UE5QaVQ4Q0w1OVVGbnVQbTUvd2JZbDZJQXd5YzZZN3ZnMFpXeVUyMnpYNzNy?=
 =?utf-8?B?RjV3UmdCOU5iUlY1dzRSdXNLOStWZkFtM0Y0WFdBTVNHYkRrM0hUbFBZRzNw?=
 =?utf-8?B?UXNzMTJ2UXE1dmh1eVBOdzFsTG1EeURJaERKNG5LditWWC9iZ01MbEpyL1RY?=
 =?utf-8?B?NzljcTNnRVF1T3BRMlVYcVFWb2dML0RlcWVUNnNMTnl2QTU3Q21WRlVvL1dO?=
 =?utf-8?B?SnlJRkJxNTdDcHlJT1ordEMwOUREdjhMRENUMU1EdEdDZ3NsNFJtbC93TWxR?=
 =?utf-8?B?MXR1N1BTZXpVL1ZlaEtWSlpodWFBdVpkMlNVaEFOSy83b0U4Z1pxSWp5M0dT?=
 =?utf-8?B?d0JjRDJ5Z3o4ajhRdWFLR3JsWFJlN1pwSjNuR2ZiamhHNGRXdmExZTRzcW5C?=
 =?utf-8?B?UnF1RzZxdGFselBjVTBPVXdQTnc4aGtPajQvV1BheXB6M3BXTXI0SU1GZm5G?=
 =?utf-8?B?ZTdFTmFoMWp2b0t5c0RUMDgzUlhlY1d3dnU4c3pwZmJVZzdFVmZ2MUlQd2FE?=
 =?utf-8?B?MGdGRVZwZm4xdWx3akd4enJvS2t3MW5oSjQ2V0JUK0o4S2x1RktYblVrUzJU?=
 =?utf-8?B?R3VmbWJNZnIraGFBWUx0cjMrL3VIVFpHQ1JrN01RUTRUSEowOGtIZHNMK3dq?=
 =?utf-8?B?YXFDWWVReEZ0enAvQ2JYSFgwazVScmZOMjBkUHF2a1BDbythNWt1UTVOMnJa?=
 =?utf-8?B?WFZXWXFxYWV1SmlnTGlBVWJZSUlSL3lxbnZNRE9HVlR6S01hekJmL0hVS3l0?=
 =?utf-8?B?aDZKMTEzMFhwQUJSSlpCWCthcmxENGdsVUFiU0FUNEZkMVVLdzh5NEdQSlFp?=
 =?utf-8?B?RlhTMUVNeFVyVkVMWGY2Qnh0eHd6cE9yZnNMaVV2R2xVZnhHazhLSXdpT3VK?=
 =?utf-8?B?d3gvRVhCcUV1VlhHRlY0aEZBN1N6K0tmNmhqWm90Ny9NQTBLM29pR2dwdlZm?=
 =?utf-8?B?MGxQRjVvbFdlNUM1bG1WTHlCRWZxRjNLWVd6NWpyOURiT2YrMlhIb1FiUmZP?=
 =?utf-8?B?dGVOMkc3TXJwTndqeGNvOTBTSmRqRmZTNnMvU0RJQ0w2RlJvaGUyRGY3SGRa?=
 =?utf-8?B?b29HKzR0bm9jSGJ5SzVaRjFZaU1ZWXhPRFVwUHBQR2hCUE03WDFQSTl6YUxK?=
 =?utf-8?B?UFFlZ2kvNU8rdUJiUHRBbG41TUUxZEFBWllaNWJnQ3k1VzhaRElTNkxzRmVp?=
 =?utf-8?B?RTBPY21sNjFnZE5BQUltYkcwaG1ZeVRhZFgwNlVSSGNtdnJZZzloUWF3TGdI?=
 =?utf-8?B?LzlWcGExTVJuZWZXL216UlJSMytsRVdJaGxJUGkvay9VcFlibjJoU0JyMnpv?=
 =?utf-8?B?M2czSHg3NE93NjVaVUNPMXdSVjg5d09OZjhxM2pkZjNreUo2YlMwbTZ1Y1hO?=
 =?utf-8?B?UWpTTWF1TDFKcmo0TDhkWUZDQk0zL3A1Z0ExYk5iSGNqcnZXODF3NmZ0elJs?=
 =?utf-8?Q?5tvEbxeN6J6tA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWpuU1g4TE9odjhjcWRmL3ZUVUFERVF3RXhhVjBiSytadFFjVHdQbkhCSWdP?=
 =?utf-8?B?cmlBUnhMMUVZTmpORFhoREJ4YVF2YjZFOWIrQ2RScjk2SjNNVVRTSXBlVllo?=
 =?utf-8?B?RC8zV2ZiaXczUjdqaE5wdG84SGFkdFV2d05GS1pyaFFVM3lSY0J5MGxZUmJQ?=
 =?utf-8?B?UmNieUhuZ2ZCOGlyNUw5ZHFpOHdFMzVYV1BrYTNqdG1sSlBpRmYvaGVwYS9t?=
 =?utf-8?B?UEx3YVh0U0cyYVU3S2FpcnZiZmxRRTd0ZEo1RERTSVZGOWxpbGliZjUyL2ZC?=
 =?utf-8?B?eVlFWi9qSlNUWXpRM0s0ZjA3OUl0QlQrQ2V5N2tBZ3NIMXRBZVRZaWJYOUlG?=
 =?utf-8?B?Tm16Z2h0QVkxdXZCR0NoWllOSUcrTDVBOW83ak9xdjNMMUdLT3N4Y2M0SWFH?=
 =?utf-8?B?NHhPTTlYTjdPMXRQdjNtZUg1UjBkTVY3UUdoRDQ1eGxBaFMxbXZrTzhJZ3c5?=
 =?utf-8?B?cUNYWjdUaHVPUWpzeGp6UmY3UDNuNHhxR2gyU3ZZc2JvK2RKanYzZFQ4RkU4?=
 =?utf-8?B?YmoxWVRJbGdmWnBGdDRKbENmM1NNaUpaMVM5aytHZmsxbFNraEhCVHhPYnF4?=
 =?utf-8?B?TURlM2JuT05TR0tCdVNsU3BFUGNMNTZVNC9DOVNhZzlNUlhmZ1JZODNUckVz?=
 =?utf-8?B?ME1yWjgwL3R3MXFYSmhYSEJVa3k5eEwzN0xtRzNiNFlSNC9Gd3VpcWRhRlZm?=
 =?utf-8?B?ODFmRzhuMWdHWkduaTNjRjBlRTk2bms3Snk1QjZPUGQ0bEdzdDluV2tka0JC?=
 =?utf-8?B?Q2ZENXFpK3NqbWdOekVpNEVsWDFMODJwQmtnWG4xdzRmdnVIZU1saG84VjJi?=
 =?utf-8?B?TXZocnVTclVRVUgwVWFOaWEzZTNQdVRXaXBjaW42T0k1YTMxU25mcElqWlM0?=
 =?utf-8?B?N0tyR1lhMDVxbmJzNmhHVnJYV3JjR2t3Q0FsQjZ5M29jMmFCMmtnVEtDeW1L?=
 =?utf-8?B?OUJPaG92NzhIcmZ6R3duOCtaMjJEMEpQai85Ly9BSkswRFJKbVJMRVFCZkor?=
 =?utf-8?B?Tk5zcjhZNGx3QWV6L3NwUXVHMmI2WU1nWkNGM0RERTQ0TG9xY1QycVd6QWFC?=
 =?utf-8?B?QjF4aUNGRzVrOUhXYWFBbWc4VTJYbDdsZkw3a2VYdlZLajhZME5LOTN2WFBk?=
 =?utf-8?B?cVM5Wmd2ekEvRTc1amVtL2ZBTTIzZUc4aU5saXBKNERDaHlmeEZ4Y0w3Zkwv?=
 =?utf-8?B?SDZQTjZaaEIzQkJ0ZHpsVVBueFB6cktKS3lQWVlsMnpYakwyRE5yWXkzRWlC?=
 =?utf-8?B?bC8xSG90MG11dFRKbVplQmY3VmpEMDRoS0pCNFNkS0FhNFBOWGxHbWdvYmNI?=
 =?utf-8?B?bm9odnJTaVBIN24xZFVrUmJ2MnJ3T2hKaWZsT0pGNG9WajNQQmJSc0lCQWly?=
 =?utf-8?B?R3lKTTAzMzFHUkNPOCtPVUs1bSswWmhINW1PS3ZmK1I1Z2psalhzS1FoZkh3?=
 =?utf-8?B?YkljMk9VaEgxblFDOExneE5paFVCbDJyRzFEanpXNHRqLzIxemdEUXBvb3Iw?=
 =?utf-8?B?U0pWYVk3NmZlcGRramNRaXpFUXh3SlVIZTh4UE9mL2Q4SGFmSXZVemVLQW1Q?=
 =?utf-8?B?VCs4UFd5OEM3eEpWaE5XTE4xek51NE9EbU0renRnaHRZazRZNmg5OWlBSEJH?=
 =?utf-8?B?Wm8ySUM1MEJ1NWNFNG9xY0VSVXRZTk9EQkpYZlEvem9ZSWZVaGpMSkpvUU10?=
 =?utf-8?B?OGc0K3dvY3ZBOXdaTEVSaThSeEJVNGJTTVp6OVB1MUZxRUE5L3pXNU1MQ3E2?=
 =?utf-8?B?RVVrYi9manZKTDZoaVd5VUo0anhIaDNQSXZHeFZvZXhoLzBiMkVjazNRallm?=
 =?utf-8?B?RHVSVk1LM1Iva0hyalhmRVZLN3FDRmY2aHFVMmNsYXVHL3MvUkh5TDQ1Qmd6?=
 =?utf-8?B?Qnpoek9UZzQ1bjV5ZWUwV2lsRm5NUGE4UEUrRWJwQmFQUlFSSkdRWGxMOGRP?=
 =?utf-8?B?Q2RJcWZKb2RBZ091dGI0MWx4VUYvMjYxVXNJTVZyT2RzM1FjcVJHUVZIQVdH?=
 =?utf-8?B?VW9Rc1VCc25hNStrUnJZYzlESmxSRlhwWThYRU16dDMrMFo4Z2hoektPbVlL?=
 =?utf-8?B?MWg0bXc0SlkzNi9iNU40NzNobU9zWm5jcDlWc2xYRnpRVE9jNU9tVE1MTFQ3?=
 =?utf-8?Q?fT+kFVV45snmEUJHg9rOnMPvu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df321fc1-92f8-4957-7e3a-08dd6c1e6309
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 04:26:32.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjHC7JSdbFl3in1RIpL80n0BIEg0/6su3TB9N9SJ+dHE2GGijJjfBkdKsipRafwUvj1xe39OJhBwoGRcA9rsow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091



On 22/3/25 22:50, Francesco Lavra wrote:
> On 2025-02-18 at 11:09, Alexey Kardashevskiy wrote:
>> @@ -601,6 +603,25 @@ struct sev_data_snp_addr {
>>   	u64 address;				/* In/Out */
>>   } __packed;
>>   
>> +/**
>> + * struct sev_data_snp_feature_info - SEV_CMD_SNP_FEATURE_INFO
>> command params
>> + *
>> + * @len: length of this struct
>> + * @ecx_in: subfunction index of CPUID Fn8000_0024
>> + * @feature_info_paddr: physical address of a page with
>> sev_snp_feature_info
>> + */
>> +#define SNP_FEATURE_FN8000_0024_EBX_X00_SEVTIO	1
> 
> According to the SNP firmware ABI spec, support for SEV TIO commands is
> indicated by bit 1 (bit 0 is for SEV legacy commands).

well, I wanted a bit number (which is 1) but this is wrong nevertheless:

present = (fi.ebx & SNP_FEATURE_FN8000_0024_EBX_X00_SEVTIO) != 0;

should be:

present = (fi.ebx & BIT(SNP_FEATURE_FN8000_0024_EBX_X00_SEVTIO)) != 0;

good spotting!

> 
>> +static int snp_get_feature_info(struct sev_device *sev, u32 ecx,
>> struct sev_snp_feature_info *fi)
>> +{
>> +	struct sev_user_data_snp_status status = { 0 };
>> +	int psp_ret = 0, ret;
>> +
>> +	ret = snp_platform_status_locked(sev, &status, &psp_ret);
>> +	if (ret)
>> +		return ret;
>> +	if (ret != SEV_RET_SUCCESS)
> 
> s/ret/psp_ret/

yeah I noticed this after posting. Thanks,

> 
>> +		return -EFAULT;
>> +	if (!status.feature_info)
>> +		return -ENOENT;
>> +
>> +	ret = snp_feature_info_locked(sev, ecx, fi, &psp_ret);
>> +	if (ret)
>> +		return ret;
>> +	if (ret != SEV_RET_SUCCESS)
> 
> Same here

-- 
Alexey


