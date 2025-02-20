Return-Path: <linux-arch+bounces-10241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF0A3CF5C
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 03:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8237716B6D8
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 02:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D7E1D5161;
	Thu, 20 Feb 2025 02:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="48iRfnXd"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B101CDA0B;
	Thu, 20 Feb 2025 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018564; cv=fail; b=fxw813WItTY/CxxrrbuPLa6VTI4xMt2dhdSQC6CmroWZkQoHj/QtqYzLt+fDfXbjCPuZ20ylD0XKxhPh0KCXKNiGqRkhNoRWhXI0ENfye0oLRvYUExi3jC7+SL0m9QwJmf9Qwn0Vix/9OPIFu2RezxnqxlOaxnCrPGRKX6bM1ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018564; c=relaxed/simple;
	bh=s4QDMZlYRextyQXLqpAM47tSsnpkuiZfDkxUrkbkYVc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I5OEt8zEUCCByvLY4xOggkC5UhT0rf2XeeCyoqhTPVLPR54F+z/0leg1XlKXmTnOszN1wkHl0ycNxROXcPmcdErytXyuOtdiddD+ynsKme4z+MLIpV1ARqlO+02aguVlSOU1mQbJXTQJVUUTvOf6sNi6yU35JcHx2+dzn0df2qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=48iRfnXd; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d58s5z4QVhutgizQKfUTn8Pktx1VV6o587jvAZ4BPtyIw8tpay4Pfu45D3HKoQpCJab9pzG7/H87xjI4yGZ291D9d/XcWTv+EwvrA18eOZuL1xmz/2yUOxhMGkkh2wz91SK3RHYajrvW86V6D3NKboLC9no5o77bURhC28hHM9VI9DLRHW4dKOPeIoQpTvnhjl5O1YjI23nhG12c2DrH4Lvq3DoDAyybJfY4+OsnuGcFqXhUFsT6VTphcqLzkspq+wkNVf8iKnh74POgEONCUvqXtz9BWk0BivfbM7E/xJwy4kdbCh9cRLa4c3tALLkXB4WItrEnWxhkHFM4X9/1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zABdxna/QVkO6OOIUnODSqnqub/oyBlVnhwDBklxWy4=;
 b=S7b4zoGXqhKg4dxAJ5V6w/OZebtVKXhDQiHg5P0JD7EQR+cLboiGArD92f8XHMz2a//eGRyB6r76z5kdJS8/X8PK0qXfSwemUmN0BnVQ2KxwKf6ZcBk1+3lk+R6nzw3BntSQzR1KAzF5CUrVhgWEnRcmZMyvIX2duqWi6ZsfUP1+MpdP9ERjxcVes7lDcbXJA0agQ3zsfWDWMw13oKpTupP5Ppg/3r2WNJvFcUE3eLUD264PFEScGpJf/zJU0zkVH1Yez7WeR87D2n+OqGMJU0KcTjPk5kLEC2QfxqAP1sElv67L70lXwe8A4pfZJIrF7usic0mNlcZNyVrhOte1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zABdxna/QVkO6OOIUnODSqnqub/oyBlVnhwDBklxWy4=;
 b=48iRfnXdK9JN1snBta0KojpqD2XuipYNBkcY9RWRxg/O+mRNc5MdWUbpFSYeLjfSTeVzY+vRq4kKxoRoVNjP2FjfKjsHZBDCV847+Q+v3f5jFq60q4IClss1qBGyUAOBMx3a61PIiaHsdAw+cI0ca6K7a5IM7WPKj5OUerJOm8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 02:29:19 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 02:29:19 +0000
Message-ID: <cfc62524-095d-4895-8471-cad2c5a712d1@amd.com>
Date: Thu, 20 Feb 2025 13:29:06 +1100
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
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250219133516.GL3696814@ziepe.ca>
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f23549-9bed-4c13-7086-08dd515660d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUJ4emsrODQ2d3RvZkVWbzRyMTJJT2NOOTByTlB5OXNleExhWUsvRnRkVlZQ?=
 =?utf-8?B?RVNWM2N3dzRuQk91Zk1NZUdhbnJxSmFTcnFPc1B1YldNVktRVVJXWDhBWGlY?=
 =?utf-8?B?QkxsL0k1NHRIVWs2NXBWQkt1OERxejRjN2o0dTJzb1FablBxSnRvc2I3dDNt?=
 =?utf-8?B?Q2RDREVROC96SFI4cVYyRjlackd3dGZKdUp3SDJudzhDOXk1bzdlb1NJdXFE?=
 =?utf-8?B?eHlBWkdvbnJQSk5DWlhKSXZKdE1ZU1FnNjNxNzlNeW91bnhYRjUrT0xIM3No?=
 =?utf-8?B?MTVMMzlwY0tLSnNnbk1seUdxQXVjY2dBalVwQ0JQbEdDTDhJL055M2xld243?=
 =?utf-8?B?ZktvdHZTSnR6bW1SYnFCYkdzZnNrTXVGY0RtRUtHZ1pYcG5Fb05pVU5qWnoz?=
 =?utf-8?B?bnN0RjQrUDI1ZHR1bVVnYlpYd3p4RmdTMncxTFp5TGtwb0s3cU1odXJCd1dM?=
 =?utf-8?B?MGJCQXVLRXFKQk50dHBkVytnYktJU2xUWm5BYnBlcUlvZStCcjNEU09ndENM?=
 =?utf-8?B?dmZBTUFIUm1XTlJ0djB0ZHVMblRYdzRhd2gzcW9VU1MrMWVOU0c2ZW40WDR4?=
 =?utf-8?B?bmhTR3NveWllTzVNRDB0eVpRUzNMVGdHRjRJejJDb1Z6Y0ExNXJJOWpvbHdp?=
 =?utf-8?B?Z2h4dXlZdmVjL2tNdFRjMFlBOURiQzJzWkl2RnVmZXV4dlM3Vzh0VHdzc3ZF?=
 =?utf-8?B?OFl2RE5mWmI5dzVCNXpieWRoOGZJeFg0b1AxWjh5clVRUjJDQXhyVVhJQnhk?=
 =?utf-8?B?M2VXZmhDaFhxSzFzVWpMOVlBRUQ0UkJtTVVJTDJVTVhzTGxwMUdGb2dNZkZ1?=
 =?utf-8?B?azlIa0FQbGd2cm50UnRXMmh0K3ZKL2dqRHJHUnhnRUIxM2E1YUFZSlZHRVNh?=
 =?utf-8?B?Ny9sM1F5QmY1L1ZiV0pqYnphMkFZUUo1bTlZRXZ0ZVJnTHdIVHdEV1hXNVA4?=
 =?utf-8?B?K21rOVQyc1U1SlVhSkFNMm5ZWE9OaUdtckJheGl2dXlUMWFkbDhFSzFadzVC?=
 =?utf-8?B?Y2xHS2R0YWloSmppc1duYnNjWXNQMzZlMHVROWRnS05JSUFHYkh2OVF4V2ZR?=
 =?utf-8?B?REhLZGlSeEtrZllRSDQwaUd4TFRDUTVzandVTVpFWHMxWjE1LzNKeEt1S2hs?=
 =?utf-8?B?NXQ2akNkQ2RIaDhla1grdXdmNkw4VlFaTndNZUtpc1lwb3BGd0tOanZLTmFj?=
 =?utf-8?B?Z0NwL0Era0hNN1MwUnR1L2piOTYyLzhrZzNFMHV1U1hBUGdHZ3hDanVOS3Jq?=
 =?utf-8?B?U0p3bkJhb29VMVBmbVVabXR2OHZDcHJWVnpNWFU2emtrNlFOVGxzK3VZZDh1?=
 =?utf-8?B?cFVpdHRDUld3WjVzZHRIdXdidHpPRUk0ZElheVBXcG84QUQveFRCTkhsK0to?=
 =?utf-8?B?MXpMNTdkbitWdlZtNUlLa2N2eEhadUdOdVBnT0VldHM2a1NibmlyREdya0l0?=
 =?utf-8?B?RjBRbS8vanZhLzBpQlluaS9OM3lhdGVzR0xMblNQRjN5MEFEVWVyRkN6TUU1?=
 =?utf-8?B?aXNhdlJKeWREWlZpRmRNcS9CSzA4WmRZUEM4Ym9ybWtMR2ZOVk9XaEhDeVRr?=
 =?utf-8?B?QWVtbDZ1NWdncEpoKzhIdnJ3TFdvWXh6QVlURXVwNzM0Y2pnbkkrREJKT2pt?=
 =?utf-8?B?bTU3aWxFUGJNc3J3ZXFYUWpFemlzN1Y1Z0FXS2NYak1KaEIydW1yazdPUnlD?=
 =?utf-8?B?a2JYa1ppNEJGWHFoWUNua3ppOFcySHlWVFZvMFpvblRxTGhhSitVYUo3VnVY?=
 =?utf-8?B?bXhJUWkzejZWcGF6UlJRRXlKYmJKRUJjaGVaOFdXbGNteEl6SkpsODc3WGls?=
 =?utf-8?B?UVNrL3laWVdiT2VYTlZjdEZtNjNzU3Ntb3RXUjFFSUs3MVByL3orRUNITlB3?=
 =?utf-8?Q?xkVdvEX+DFKcz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlsQjFKWERwSTBIZkMwSlN3Yk80QkYwUllJYTlET3M4cldaNnBsSUxXM1dN?=
 =?utf-8?B?VHA0TVJOQzVVeG9uNlVBc1NYbG1UOHpKZGxVbUFVd1ludXlXcXdWc2ZiY2Vu?=
 =?utf-8?B?TVVJMFNhYzQzOFZsdDFFWXZTUnVRTXA3WHBSckgwc1RDQnNzSm5TWkFqdFZo?=
 =?utf-8?B?aDFNQ3hRcWo0L2lqS1R4ZVVkcXI1YjdZR09QQnlOVTRUTlNrTGpTUzB6WDJn?=
 =?utf-8?B?RmJTMG5sM29rMTFLcjQwQWd1aWVYYVNLUWUwSmJRNHE3N2NTWHV4ajg2cFow?=
 =?utf-8?B?bVJaVlhLZkVYTFJ6ei9UTnBHRGV0Um9WVnVOUklRMHZpYkNkamw5NXFKclBJ?=
 =?utf-8?B?UTdEMGlON2tmWllpUnRRY25KZnJ4MmpmbFpyRWVLWEw2NXV5MlZoSTl4MnlY?=
 =?utf-8?B?OTFRNUtnSjhCb1l1T2RLN1NYenJOR0lmbFB4ZzNDckZEbnhscXZ3d3owby9I?=
 =?utf-8?B?MU40MnRGR0sxVkxsVXcra2xZbnVsYVRncUorNm5IbXB2dEZaVFk2dUxQZkFa?=
 =?utf-8?B?dHMrS3Z3QlUvWU5iSVRJWFk4dXVoSEZ1c1lMSFJCZU1EaFhIYUUvRm5meUVq?=
 =?utf-8?B?bjNLQkw1SVpvWlc4b09kMUl1N082UEtoSlRCZS8rUVlpMzhjcSt3UWVxMWF2?=
 =?utf-8?B?ci9SWFpJM0RrTlFhUnJOYjFJdnU1VEUxUHRLc3JIVXVJNlZmWmZqUWlkNnFO?=
 =?utf-8?B?MHNlM054ZGY0c2VsamFsQWJGTUdKZkVFcno0dEpJUHRzK1d4K1Vld2lUUTVh?=
 =?utf-8?B?TWJBSHRSTzlLejhFZGprMy9xMFFWWFJxOVBGUytkWXpZSEVPSlNNejR5czZ5?=
 =?utf-8?B?WWNqejZQQWg1a3BiVGFJMW5vSkVNZndoRll5YWVLRmlxZGVzVURZL3NqVnhO?=
 =?utf-8?B?NzFKckdKUHZyTlVmTHJTN2NjTFZERmoyVFZkdyttaFlxNzNZajJZTVlYZFl1?=
 =?utf-8?B?ZnpzR3BOSVJTeDVzL3FhUTlIMzhzMGxOY0JZWmZyb0diZjJCYm9XMTh1dzFm?=
 =?utf-8?B?eEM3d2xSbktJWkg0cE5DRnRIM2xBL2JZK3pqajc5Qk9MR2p1c1d4ay9vejFi?=
 =?utf-8?B?VE5SVVRVc0JvQ2d3M1RoOHdjOWU2b1lRWHdNVjV4TFdrTitVbS90T3F6UmZK?=
 =?utf-8?B?KzlUYS9sSFNkQlpKNVE4c0d1VjZjdHlRenNVWnJHdFhFYk96SFRzUWp5OXp0?=
 =?utf-8?B?NHpFRCs0R2p6KzhUOUcxNDhZWWIvR2xGK2YyZ2JjNTduajBKMFVYVGMzRFBy?=
 =?utf-8?B?ZDJhWjllUHN2VHFrMUliVUZQOHBQbzdBem5HSE5iSXBJRDA0QlNsdXoyMzFD?=
 =?utf-8?B?b3hHeDNQdFJZQUlWOEcvV2hkUnhRbWxMalVaOUZncVFlMHVoYkV6RWM3OWpm?=
 =?utf-8?B?WDV5RkYyOUpCZDJEV0VVZlQ5Ym5lTDhVVEE5aVo4ejZNcGV5ZUR1bWVrQXIz?=
 =?utf-8?B?aUdPd1o5RzhteE5MaEliQVZvcktOdmdiVUh3SWp2bkVLQ0d3VzFqSjcvUXQr?=
 =?utf-8?B?YUQySTZsZVk5bzB1d0JoNExKNExpK0o5WlBnSmJIbEgzOFduZlVnQTBwd2NY?=
 =?utf-8?B?OExpZGtuNVgvUzQ3MjZoQ2RYUmQycmJ0VW83NksxMSs2amU0cm9hbGlCM3cy?=
 =?utf-8?B?eXV1NTl5bHowZ3ZuNzArVGZMWUlvM09rcmhEamk3SERNdWNGVXhnMVIwck5O?=
 =?utf-8?B?QTZnY2ZaVDUraGNSL1FWR29GbE9mQnlvRFhkWTJCRGQ1TTVHajZrTzlMb1RC?=
 =?utf-8?B?UFl0MmR5QXF4a2FPTXM5b0FVWXBWYWV2djlVV0tGb094RXUwMWE1UUZiUGgy?=
 =?utf-8?B?dG9jc3hrYWhyMXlvTjhOTy81VGVzUXlOYkRHQ1k4dDFDMXgwOHBrb2xPQjgw?=
 =?utf-8?B?SWNlQVkvNytmVnZOQytvZXZRVnVjelJsZjBBdTUxU2RLazdaeVlmcW5aOVdS?=
 =?utf-8?B?VmFPRHdnTkkwdFVuTHFBQkM4dnkwSk1qbFVCMmRORDNuVk9Gb1hBTGtKRmQy?=
 =?utf-8?B?VlBsamdwcXZLeU1UckVrR0hqdGFWV3ducGgyc2Q1b3Z3Y2ZvcUgvTVpmRDBj?=
 =?utf-8?B?UVhqZGRkN2pabjZPbjZob0FaOXR1YnJETG0wMlRBSkVqOTh0NFUzVkNMVEk3?=
 =?utf-8?Q?hqVl6bVux+Zkn4lTTjR/weXb8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f23549-9bed-4c13-7086-08dd515660d2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 02:29:19.3471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KqEFKgAMOeb+8kqj9j5U+qz+5/r1+dRnAVpuwz2gKnLkd/bIi/nMrp+z7t8Pdj6RlQTl5+0HQmpo80hFLYlHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349



On 20/2/25 00:35, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 11:43:46AM +1100, Alexey Kardashevskiy wrote:
>> On 19/2/25 10:51, Jason Gunthorpe wrote:
>>> On Wed, Feb 19, 2025 at 10:35:28AM +1100, Alexey Kardashevskiy wrote:
>>>
>>>> With in-place conversion, we could map the entire guest once in the HV IOMMU
>>>> and control the Cbit via the guest's IOMMU table (when available). Thanks,
>>>
>>> Isn't it more complicated than that? I understood you need to have a
>>> IOPTE boundary in the hypervisor at any point where the guest Cbit
>>> changes - so you can't just dump 1G hypervisor pages to cover the
>>> whole VM, you have to actively resize ioptes?
>>
>> When the guest Cbit changes, only AMD RMP table requires update but not
>> necessaryly NPT or IOPTEs.
>> (I may have misunderstood the question, what meaning does "dump 1G pages"
>> have?).
> 
> AFAIK that is not true, if there are mismatches in page size, ie the
> RMP is 2M and the IOPTE is 1G then things do not work properly.


Right, so I misunderstood. When I first replied, I assumed the current 
situation of 4K pages everywhere. IOPTEs larger than RMP entries are 
likely to cause failed RMP checks (confirming now, surprises sometime 
happen). Thanks,


> It is why we had to do this:
> 
>>> This was the whole motivation to adding the page size override kernel
>>> command line.
> 
> commit f0295913c4b4f377c454e06f50c1a04f2f80d9df
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Thu Sep 5 09:22:40 2024 +0200
> 
>      iommu/amd: Add kernel parameters to limit V1 page-sizes
>      
>      Add two new kernel command line parameters to limit the page-sizes
>      used for v1 page-tables:
>      
>              nohugepages     - Limits page-sizes to 4KiB
>      
>              v2_pgsizes_only - Limits page-sizes to 4Kib/2Mib/1GiB; The
>                                same as the sizes used with v2 page-tables
>      
>      This is needed for multiple scenarios. When assigning devices to
>      SEV-SNP guests the IOMMU page-sizes need to match the sizes in the RMP
>      table, otherwise the device will not be able to access all shared
>      memory.
>      
>      Also, some ATS devices do not work properly with arbitrary IO
>      page-sizes as supported by AMD-Vi, so limiting the sizes used by the
>      driver is a suitable workaround.
>      
>      All-in-all, these parameters are only workarounds until the IOMMU core
>      and related APIs gather the ability to negotiate the page-sizes in a
>      better way.
>      
>      Signed-off-by: Joerg Roedel <jroedel@suse.de>
>      Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
>      Link: https://lore.kernel.org/r/20240905072240.253313-1-joro@8bytes.org
> 
> Jason

-- 
Alexey


