Return-Path: <linux-arch+bounces-10693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BC3A5EAA3
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 05:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B19A176250
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 04:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D25013D893;
	Thu, 13 Mar 2025 04:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zaddWAoM"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B0800;
	Thu, 13 Mar 2025 04:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840334; cv=fail; b=KVrLku67bZHKFOYrqJeu6aNMA9tgTSkz9auWLMPO077gxovRsAaUqvwpmK6Xx8FgPS0BVMGckU4cCqQjrPh3Jnn/hrUHQFn7/5Tohwy7EBNxfiyif9ZRFCpLi5Mhsyn4XAlen5DkQs+N7L9iK0TCWqPC+XmhSmzRq6eO+vBxjpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840334; c=relaxed/simple;
	bh=xJMoGf1OCJIDq5I1xoMlZr/93Hcr5sGIdcGutgSqiPw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fODFH3Mgq0KwCTlR++dQcZChME+zJ0CBaHD8mK1oQRgC5OIk5OPB0W+ZhLJiihFTKvHDFg/QdgXqDpRdPeSsSKoxemCnBZ+jcXJgV60KjYilKyO1DlSO25AlKWt+tCWQlHd3YsYzslVMyuyFPxqlimhgrYsjwvofJm/fb1YNmKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zaddWAoM; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+/yAFIG5Kig326IV8lx461BUAuGAuUddwVQUq1WBB/LEvA57GW9JakkDRE+fYhl2Ld+R/LiTH7BEXyH928fJHr9bgK6LYIbGSMd7uxtxedSBRfly7zXc89aqPd5R6tzDUL5OH+CS6vCzVH5oPBzvL2Bu4VC+nDSCaFoxmhPFsEAj7FxTkqk3dIeSN8HTuADr0ZVKDtYQ0Zibh/1WFaYMcG0PYlpK2B7ROISh3ZNL3Pl2tA2L21cRzjsPigCWVP7Lpoz1ov63p+2kV9OeNzig7pkquFpEH+icYYVIPhSHCqYswCNFV1lyRhjsXH2jU6D1oM53Gqa+lLMbk6tsUa6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBX9yHc4qHjMeNb8rj8wwW5e5Dq91ZPwfeyuWucp870=;
 b=f0aHUqXWV0OS80zvvfjqjyfZTG0uwfaE53/WajqAb5iUgm+9cygtOpg2DvlWAtVmS51LIRGUvWli+JzMDH43X3jqsRuFLMQY8aRJocUxQ2PtScIrjdwqwUl1kQ0a/yoeP9nk3Oet6nfYpezFNFETT/h5AxtWhUEJ65BhEEkIf9khyCyNjGzZvXaaUxSGtY5trYo7yTBazFBtM+a0eMSsdd+WXDxEwigCya4n6TDgq5ymT7Z6TymxwfcCnih2j8ttdth/mpi5TQhnQ4/kQcLKoGLpUs1TqueUQuLH26EaOHytUibcrDe0W6kCy8GuGFP3Vf3aIBkiI2EdjNJX+xHHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBX9yHc4qHjMeNb8rj8wwW5e5Dq91ZPwfeyuWucp870=;
 b=zaddWAoMM8HFHLSkbbAXzEQsjzOUlcBov6SwnuI1+0LxC/W9vw7s0yTmVfzfGTSwRjtJqdWdquP8W2pqo00b9eiD4Bpa1AymxG46lhDcrmIyaAXA3whLFjiKjqD1k1TPdqbJlZIADAzNeJsyCofUxu9B/sjSuCG94tWw+jE8v3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 04:32:08 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 04:32:08 +0000
Message-ID: <7719c1ad-84b8-40e2-9ce7-93248a410ebd@amd.com>
Date: Thu, 13 Mar 2025 15:31:54 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 06/22] KVM: X86: Define tsm_get_vmid
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
 <20250218111017.491719-7-aik@amd.com>
 <67d23a3e6667_201f0294ed@dwillia2-xfh.jf.intel.com.notmuch>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <67d23a3e6667_201f0294ed@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME0P300CA0063.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:20e::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: e132acb5-4178-489d-9a4a-08dd61e80394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWkremF0SGVXM0RneTNSNzdOSU43eXllOUhaUU5KdXFsaEVQd05vUWJPNTc2?=
 =?utf-8?B?U0dubGxrbXk0Tnc4dDg3QnFEa1hGOHQySWNIbVV5enhQN1lya2tQeDZiYWlX?=
 =?utf-8?B?dFA0OGhUMDZRY0hmZk5HSnFneXlLWHg2d3JaQ3VTTk4vSUxnSFBDTGhuOVRH?=
 =?utf-8?B?QTBsbnhKUCszekJqSHRUUWQ5aTlmdXkzRDZlQ2NEaGVyTVNaNGJnM0J1ZEY3?=
 =?utf-8?B?bExDMVdwRytUK3oya0FpMzBwSGlDVXBEZmp6OXppeGhWNEtJcG9jTklPOThF?=
 =?utf-8?B?cnJwa1Q1Vzd3eFRDc0xhTEkzNndEL2NyT01pOWRNZGRYTFA2SEJ2aHllajFk?=
 =?utf-8?B?RFR3bjdkSnQ1bnBFcklBRlpOZW9lSU5sT0ZhK1RkY3p2R2Rrdit2d0ZockZR?=
 =?utf-8?B?dk0yd0lOU1hJN2xPemxyemFSZWZ2d0hqandNUkM2SWpaRkpLSVFGZWwvdFNo?=
 =?utf-8?B?UjdDYlpSUkVMMGtueE4zOStOMWE1R0daVDMrOVNuRzBYSDNwb2cwaWpzZlBm?=
 =?utf-8?B?UWRkWVJjNlV3VXpZKytNbm8yZkYrZG1OR0hPWDBMVmxSbTNmTEFVQi9kVUIr?=
 =?utf-8?B?TUgwR0dPL1kwZjhBMmxXQzFlWFptNTFZdkVnbHB4ekNjbjhhNUo5aE9iTmp5?=
 =?utf-8?B?VTI5NnBlM2dnbzlaYzRUOWQ4SW41bTdqRnA4NTBGTkJ6NEROY1d2S3NZcHpm?=
 =?utf-8?B?KzRVN1dTajJjclFsSzBmOVdWSVV6RitzVkhYZXRGUmRWVHBPWUFoV3JiQVdu?=
 =?utf-8?B?ZnU0Y05WeU50WXQxUXdNWHBWVkJMb2gyNmRrZU5iTVJpWUNpOVVsbnhneFdx?=
 =?utf-8?B?RnU1QlkrN3pzYm1pMzlNeHpIK29sdkwvSVFhSlJvM3pQaHprVkUwVk5INlVs?=
 =?utf-8?B?YTgvY2dzRWw4Z2tiSjFvMnJENkpjRzQ0SHlZYVdqbXRhQkVhN21QWEZVR2ds?=
 =?utf-8?B?SWdXZG5zdWVRZzhKUTdOZjNRemlpZzFKTWxkVnVoMVBSVDhkdFhrY2dyNzJO?=
 =?utf-8?B?STRubElpYncydzVxaks3Z1FOaVQ5dGNBdkNFSHBTaEo0aFhtZTFhVWJDMDNF?=
 =?utf-8?B?UWoxZGQrWjV3NDhQK3p0VjhnZFBudjRuekszLzRqWDdYWVdqckgyd1NuZmYy?=
 =?utf-8?B?aC9HditQWXo0SU8vN2V0NFJQSktzYnhNM3MzblczaUZxWVVoblE0d0Y4YU9a?=
 =?utf-8?B?S1FIam9wRWhVZXBjaGk0Z1hWdXF5OXNURUVaWnBicm41djA4VEN2MVFCRHJT?=
 =?utf-8?B?NjBub2tZeEJGQ0N3czJVd2VBdUZ4Nk5TQnJmcG9aenBnMnRaYkpzNTg0MXNn?=
 =?utf-8?B?MWtKdmlTcC90M0xNMzA2OFM5d0tWL3ZlS3hyMGNsaHdrS1RmZlV5RS94bTcy?=
 =?utf-8?B?OGk3ZGJCMGduUUk5c2g1OHQxUDAzNXRkeHRPVnJWczVSYzVqZkxTY2Z1ckQ3?=
 =?utf-8?B?WU1RcUJ0dGdYTHN6bEw5d25nVHd2Y3QyWmxmTTlRWHVnTVVuaHRtVWZSZURn?=
 =?utf-8?B?YkJtKzg1WGorcWJFMEg5M3VrZ2hSZzVmZ1puNEpWaGdYRFM4NmtINFcvNzFG?=
 =?utf-8?B?SmJ0c21rUWdUcExIaitlNitaeU5OM09FZHhuZktldWg1eEFEZStObGNlMVE3?=
 =?utf-8?B?NytJaSs4L2tnL25UeThPZlZIdDd2SHhudWNpczg5ckJkMndTblEyTzRDQ0NU?=
 =?utf-8?B?OEI0MmVjN3ZEbm1KQlJNajV0dnRjYUpPK3ZyM2dzTi95QkxtbDJST1hoSWl4?=
 =?utf-8?B?ei9NK2tqQS9Lb0k2Nmo0R0M5MzkzeklFL2EreURqTmExWGNpeFFTZVVjbWdR?=
 =?utf-8?B?RXQ5ZVpiZnFhaE5YWkticm56M3Awdiszb2JDZ2x2T0dadXBVK3BPMC9Iczhl?=
 =?utf-8?Q?BDdGDGgRCgTK9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alNZT1I3eFA0QjZZY00rYk8vcmlyTWxTems3T1puNTBwUDdhc1MwZG5Vdlk0?=
 =?utf-8?B?RExKampZRGxTZEErMDROVFE1MForaktIcE1tRENmZGhydFY5V1JQTHVQWDk0?=
 =?utf-8?B?NjRDNGRWNzhtQmJiSlY3N015UTdEeWk5YWtxSVU2eVBkMXJsMnRlb0tQTS9S?=
 =?utf-8?B?ZVdRMFFVN0xEeWxtVjZpTmk1RUQ2K1JQbzQxa2pHRmRtV1Q2SE84THBEYzA1?=
 =?utf-8?B?eUtjTU5kbmNVZTB4bVVLQ2pydDdGdnZObFh5a0l6S2hTbUMvbjVFK3YzSmRn?=
 =?utf-8?B?NklCcGxCNGNQelA0N2JsN1F3SllGMVhjejB3dlN2bkpwM2l6alpyeEhFdENs?=
 =?utf-8?B?RFUvNjRkbHNpZEJ2bEdUdHY1cExmbHdJZUp3cWpYUGdJK2JYV2R0amhXc2RN?=
 =?utf-8?B?UlJ6SGF1Z1U0YW85MmFQczVIVFRpVHBBeG5OQ1h2Q2ozcG9HbWhNTC9CWEFz?=
 =?utf-8?B?ZWNDQXpEZitVcHVBTjJLQzJTbTBMZnUxMXVVTXorbVIzdldMZm1SUFhZejZv?=
 =?utf-8?B?THZSRG8rUHQzeUl5eXQySWcvMHJhd3F0ZC9RM1g4TXpyelRIdEZxeitRak9B?=
 =?utf-8?B?U0FVd0VxRUo0ZTdyR3BTOEVGMmh2Y3dkRThub2lCNkNyZ3hmdG5sa1pDbkw1?=
 =?utf-8?B?aDZKN2pZdTdJcm9uTHdleENjdVRWR1hmOFI3dzRNZElEV2dLWXVLeHIydkdt?=
 =?utf-8?B?TUdsK1FDZjZGaDBGRngrNEFXUDA0c3hIZ2pTdysrMHNyTDFzWEVDbm9LUjJU?=
 =?utf-8?B?OEJMV0FBVnNoMVQzRTJjTHhyKzVjdWpoRWFpMlMxSWJ5dDlkUklIdVFjdXRz?=
 =?utf-8?B?MnRWWElQMnZBUmg0dHB4ZytQdnJMaXdGM25UcUZicUNoWFNXWExsRUo2bEJt?=
 =?utf-8?B?L2QxQlhkdTFNaTdyQkZqQXZGWXNaOHNwNlpBWHBWcjlRNTVYR293RVZkNFhK?=
 =?utf-8?B?T0pVL2dySk5LdHFyaGFCZE5ZWi9ZVjZCdEVRc1o1TzNhMnRrczdKTHcrWjNp?=
 =?utf-8?B?ZVJEcjh4VnZJUlV6emdWSFJDbmJ4RjNpSTBUVDRyL0JmdG9oYjRkUWZVdGtK?=
 =?utf-8?B?YmwzWVdTSlNYeWZteEtmclg2cXNiOWQ2Qm44RCsrdzNOenA0U3RJR09oeCtR?=
 =?utf-8?B?TGtydGRrL0FzMDd5S0cySXhvQUpZRTRxNHlmV3F3cmpVS2xWcjlYQ2pweXBJ?=
 =?utf-8?B?RGdPWVdJRkozYVhXMjhjTmVzV0Q4Vnlva2RTYXFWSWsrYSsranhLMWVpU3pX?=
 =?utf-8?B?NmV3QktaN20rYlFEV0ZYR0w1aGFFdHNzeitNVTVtUDE1aVRlcmhleDJXTmpz?=
 =?utf-8?B?ZDlZSmpKTzNtbkRPN0hYWTlvbkNPSmNRcCtrR3JRUGord3ZrRXlYa0JiQ2VU?=
 =?utf-8?B?a3NqMUV1UzBQaEZoSCs2SFdBM3dDS3NQTVBEaE5PZzRWMzhmdkhNazY3N2FT?=
 =?utf-8?B?M1gvRmZvZVRSWHVnOGlxb2ZobDI2OHM0SHNzVEUxckc0alJERWlEcXRTYXNr?=
 =?utf-8?B?U29EQmpvRkpxaFZVTzhqTDBISHBqTWJEeGlCTHlDYXJ3bkUxanJiVlNOb0Nu?=
 =?utf-8?B?VTRkWEtpbVptdjhMSjJTdW5sOVJEaTBOZ2hyMC83U3NWNEE2Nkl0cElJRkw3?=
 =?utf-8?B?Y3gwR2NtWXNTNXJyOWJNeEdnYTlseE5iNGZHKzQxYmZhRGpGVGJPQXZLUUFE?=
 =?utf-8?B?ejhxTVlFenZsWWVTczRsNzJMVytiT3p4Vm5mMGpNdmkzOFRJalBVV1ZXcU93?=
 =?utf-8?B?RmJHZ2RjZ2xBb2NRdklZTkh3SzJGcGJ0aXBGZmpLdk5CL1hvNDNnU3NORE42?=
 =?utf-8?B?SjZWTFVyQzFNVTVsVkpRbndQdnh3OERvTFVCaXRhOUdIYjQ2a0loL05EUm5U?=
 =?utf-8?B?Z3B4bGdxYmpybWIxZi9vbVpuUTBNb1FwV1ZsT2JuQ2VDNHEwMjRTL0t6em0w?=
 =?utf-8?B?UUtkSEs5R292eGVSRzR5ZFdLTWJVNnJldWgwNGY5MXl0dG5hYlRTTzJFODZq?=
 =?utf-8?B?NWRFYU9IZHhSV1Y5WjhEZWhaZDVjSWVlN0ZQaVU2ZG9LRCtFSWEzdjhMQzdT?=
 =?utf-8?B?NS93OFpFYnZyTDZGc0daSHdnK1VHY0lUSU1MUEZFdlc2WGNGY3dTVEtWV1kz?=
 =?utf-8?Q?PnXQ9RWOiGzcLw9N4nWv/bUIT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e132acb5-4178-489d-9a4a-08dd61e80394
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 04:32:08.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoEQ6fxKa+EOOxMcSpP1rsiWeuI3UXUnM3yFgT+X7+xW9hPXuVMgMhRS1bVqgMn8rmvWafDsQhhGNVa7UVv1MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864



On 13/3/25 12:51, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
>> In order to add a PCI VF into a secure VM, the TSM module needs to
>> perform a "TDI bind" operation. The secure module ("PSP" for AMD)
>> reuqires a VM id to associate with a VM and KVM has it. Since
>> KVM cannot directly bind a TDI (as it does not have all necesessary
>> data such as host/guest PCI BDFn). QEMU and IOMMUFD do know the BDFns
>> but they do not have a VM id recognisable by the PSP.
>>
>> Add get_vmid() hook to KVM. Implement it for AMD SEV to return a sum
>> of GCTX (a private page describing secure VM context) and ASID
>> (required on unbind for IOMMU unfencing, when needed).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>   arch/x86/include/asm/kvm-x86-ops.h |  1 +
>>   arch/x86/include/asm/kvm_host.h    |  2 ++
>>   include/linux/kvm_host.h           |  2 ++
>>   arch/x86/kvm/svm/svm.c             | 12 ++++++++++++
>>   virt/kvm/kvm_main.c                |  6 ++++++
>>   5 files changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
>> index c35550581da0..63102a224cd7 100644
>> --- a/arch/x86/include/asm/kvm-x86-ops.h
>> +++ b/arch/x86/include/asm/kvm-x86-ops.h
>> @@ -144,6 +144,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>>   KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>>   KVM_X86_OP_OPTIONAL_RET0(private_max_mapping_level)
>>   KVM_X86_OP_OPTIONAL(gmem_invalidate)
>> +KVM_X86_OP_OPTIONAL(tsm_get_vmid)
>>   
>>   #undef KVM_X86_OP
>>   #undef KVM_X86_OP_OPTIONAL
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index b15cde0a9b5c..9330e8d4d29d 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -1875,6 +1875,8 @@ struct kvm_x86_ops {
>>   	int (*gmem_prepare)(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order);
>>   	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
>>   	int (*private_max_mapping_level)(struct kvm *kvm, kvm_pfn_t pfn);
>> +
>> +	u64 (*tsm_get_vmid)(struct kvm *kvm);
>>   };
>>   
>>   struct kvm_x86_nested_ops {
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index f34f4cfaa513..6cd351edb956 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -2571,4 +2571,6 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>>   				    struct kvm_pre_fault_memory *range);
>>   #endif
>>   
>> +u64 kvm_arch_tsm_get_vmid(struct kvm *kvm);
>> +
>>   #endif
>> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
>> index 7640a84e554a..0276d60c61d6 100644
>> --- a/arch/x86/kvm/svm/svm.c
>> +++ b/arch/x86/kvm/svm/svm.c
>> @@ -4998,6 +4998,16 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
>>   	return page_address(page);
>>   }
>>   
>> +static u64 svm_tsm_get_vmid(struct kvm *kvm)
>> +{
>> +	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
>> +
>> +	if (!sev->es_active)
>> +		return 0;
>> +
>> +	return ((u64) sev->snp_context) | sev->asid;
>> +}
>> +
> 
> Curious why KVM needs to be bothered by a new kvm_arch_tsm_get_vmid()
> and a vendor specific cookie "vmid" concept. In other words KVM never
> calls kvm_arch_tsm_get_vmid(), like other kvm_arch_*() support calls.
> 
> Is this due to a restriction that something like tsm_tdi_bind() is
> disallowed from doing to_kvm_svm() on an opaque @kvm pointer? Or
> otherwise asking an arch/x86/kvm/svm/svm.c to do the same?

I saw someone already doing some sort of VMID thing and thought it is a 
good way of not spilling KVM details outside KVM.

> Effectively low level TSM drivers are extensions of arch code that
> routinely performs "container_of(kvm, struct kvm_$arch, kvm)".

The arch code is CCP and so far it avoided touching KVM, KVM calls CCP 
when it needs but not vice versa. Thanks,


-- 
Alexey


