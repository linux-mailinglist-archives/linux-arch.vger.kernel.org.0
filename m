Return-Path: <linux-arch+bounces-10694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3FA5EAD2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 05:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C511B18992A1
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70431F78E4;
	Thu, 13 Mar 2025 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5thj+Ng"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197641F4C82;
	Thu, 13 Mar 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741841491; cv=fail; b=BAE4zGU0nUkyD+jFKpk5dohKOpD/aV5fqD1T2GCo/aBuGd8iULBcV20cCJ+a5Iqa9y7lOE+Hos+xKZhGxsArbDOmdKbzwGDsoVFalgHxUBDQfad7YUJfo5kP/chfqLljvgauZWxn0WlX8PhNtP2VoGB65BeyNOMickvmwUgivZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741841491; c=relaxed/simple;
	bh=SbbNXMYZ3tMlc2I+eHx6qL1lVOeh7bOnjr0b0n+B9LE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VKFlBb4deUoIiQmCc9o/N333yvx99RIB3nGBpZPFPbr3XPxe6QkBD+KNSGXPRN14+TV7Lkgn9lt3HOyUi20jqacZWlNig042/IZlqLk/WA6mL4XyG780nxDH4GeGYCjEM1KJ0/B3xkgt+ERGwGjzyfm/xQRgUvHP6ldWhLruoqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5thj+Ng; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKNhwpEGmrdjM9Qkomc2r079i1RaWVmGJ78kx3Y+1eDCm3h63e5kv16H9CNBJzSxhqoSvaVQHqAM8TRecKfQkV3fPjHcB48/vSKboTAYIMJESXaWZK+Em1cv0oU6C+YFL8JcHa15OpPo7+ulyKxxBK68n9Ycj3jG4ByZWYWJDcbUXjlAgGBaVpZOrNVvoJ1iLVZ65k/wLZHE8AzWf1/3MdT49/4EncV55RT9I4mACm8jcAjPfJz7sOwMD3sfsPwK0v7pS73d2ec5j0H7JTnyIXjm+aXFfsmx7HOyIL1gU0iAL0PU6IBRzj5YSGgnLXdlscgGcFUlS8k4DpWp/Am6Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWY05qHi7vDahlXEHrvEzjkBL/2fL38Qw3357gbx+9U=;
 b=GxflD97pQzDU937pPDGUHY/30wpeqxaAauEwbAFueg82pxsbfStLlL4Fs1GM3jhkjvVewMw39phVgTNbIJ5ELkUA9dcDZzn0HkzmGbSaLueio1Z4CBtW4ZUA0Qyog/+Df8/21E0XtOmrnVgQ4Plea/kYxyfvHZhS4X5xB1gR33qEZKJuU5UtoB5P2HBM9bh9UiUrwwVtb3zOwUq5qnhcrmC2JVJJU3CnVVYr/jQfEgUG4mJy54g2BuxmR8Y0vKD06mpWvUYOU8xYtYBxzE9z0HrieH5NPCJ0/PSOHQPi9V6arr2aQorP5YQ47vBTvZvEIAG7FFCBGMNIwfWx8Hy1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWY05qHi7vDahlXEHrvEzjkBL/2fL38Qw3357gbx+9U=;
 b=E5thj+Ng4zxgxRfi8hj9csVvxx/QYHPlPn/yjzmt1KYIKDIG544YQFsALc2Krbr2GA8YZlVw59RlZHOYUfzkQPb5k839F/D9maFiLglLC09/KzuC6yM8WRngYPQ7VisSoLswpulPK+gTeLtjVqUL/yYPZkjUnaMOplaI50L2Ivg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB8021.namprd12.prod.outlook.com (2603:10b6:806:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 04:51:27 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 04:51:26 +0000
Message-ID: <604c0d0e-048f-402a-893a-62e1ce8d24ba@amd.com>
Date: Thu, 13 Mar 2025 15:51:13 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Michael Roth <michael.roth@amd.com>
Cc: x86@kernel.org, kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>,
 Nikunj A Dadhania <nikunj@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
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
 <20250218111017.491719-13-aik@amd.com> <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca> <20250219202324.uq2kq27kmpmptbwx@amd.com>
 <20250219203708.GO3696814@ziepe.ca>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250219203708.GO3696814@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME2P282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:4d::26) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB8021:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c70527-a688-4dad-80b1-08dd61eab643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmhOai82Z2pWZnRQM1FHUXVDVStPMWpqRFh4eGpDRGRMRTYrbE5HVTE1WFZ4?=
 =?utf-8?B?VmwySCtWSXFIZ3B3TFRFcmFCRHdLQnhQN1picWRLTFNzS0hDQ0ErZmp5eXE3?=
 =?utf-8?B?K1ZZaG1RbmJEeGxJZXViYWdONjVrc0xLU1pBNkVIalNMSGt2ZFRONWJzdmJR?=
 =?utf-8?B?Ylowa2tXYkxlb1JlTUtvVmRzaFJVRTlSbnVxR0ZJclZTSTk3OXRsOWx3YnVL?=
 =?utf-8?B?WWxIUjFUR09YT3hBUHRaVStQeWdKNVI5NkJ2L1pKam81UmZwN2VtWEkzUWZB?=
 =?utf-8?B?a29uY3hZUUR4Ump3cVRTT2hvY1NjY3NlRnQ2WkxQWVl5WWk2WWp5ZmdvYUtr?=
 =?utf-8?B?ekhjUUN6c2YwNmR5dEJ2eU5KMk9Fb3BBVDBZY1lodWJQQ0J0Nmh0WFRtRTU1?=
 =?utf-8?B?QUFHKzhCS2VoNUFMcUwyeURRNXRIa0loY3B6ZDB1UzhIWlh0eVRTQVlZM0Jy?=
 =?utf-8?B?c0k1OUl4bWJjdEZPc1FpYjU3eDRQbGwreEdMc2pCc2FlNmZYWVVqNTg5TjdM?=
 =?utf-8?B?M0VzWXZwbFJ5VFNWNkRQRmhObG93eVk2cWJDZFlIMjlJcE43ZVVQb3FqRzA3?=
 =?utf-8?B?WG1PYWxRQ0dNUFBITTZFR01TQ0RHelI2TDNrL3BRTEcxc3dkSnVXN2dPQ2Jl?=
 =?utf-8?B?bjM4OEg0eFlMYlowMkEvOG9HMXhPdWtXS2hNU2pEcVM0YlBObU9ZU24zVzBh?=
 =?utf-8?B?VEhEUWplUXBwWHMyckthV0llNFpEeUVoUXFUQyt1OHAyT2hOT2RjQUEwMUpw?=
 =?utf-8?B?YllvTDhmYXFzdzVJSEMrWlhUbGJjRHRPdWVUQ3BEeXJQSEsvaDdhRzVtUlZ4?=
 =?utf-8?B?N0VweDdhd0ZGamdsS255RHhvSWd6b0cyWnlDUkxhWEQvNi9qMTdNTjJ6SmY0?=
 =?utf-8?B?S0E4dVVFYWR6alNxTVBCQTd4NWpZMnNMZVYzNWdnaGZzK0EvOWNNTjRzSGRT?=
 =?utf-8?B?aFdaSjgzdEdJUHlmanEzT1ZpTU96VUFnZ3NORUNNU0g1ekI2M2dVSFZqdWN0?=
 =?utf-8?B?R0J1Q1gxTFdkMUZ0L2Z3OTVBeDdJbnFjcStrOHZlN3RtNWVRWEdYU2w1eGxF?=
 =?utf-8?B?NDNnY1U4V25ndzdabEc1SWx0ZEtldkM4S1l0ZnR3V21kaGlFa0pyQUUrb0ly?=
 =?utf-8?B?UjhhcFZtd3lHY3Q4OXBieVlWYVc3eHVncWNsblNFNWlGTjRZUWxmdCt2djJk?=
 =?utf-8?B?RHpJaDE3aGdaOCt2U2JRRUMraEVMZ2dpVTV4RGlGb056U1NROUxhUHZ5cWZR?=
 =?utf-8?B?SVNwQm5yNy9QY2JHSFBjL2szYWN6VDNPekw3SldFcThxZFV6TVpjL2JCTi9P?=
 =?utf-8?B?MDBsOTcrRDB1a05tZkJkSXppV2d5RUVXUFdEUHJoajlEMDcxRTVHZUZXQUkx?=
 =?utf-8?B?d0VndUhUcjVHbGg2ZjhCVnVsc1VXWitpVlhPUDMrM0RHY3hSNjB0QmJjanZR?=
 =?utf-8?B?ejJ3cjRoY1FkM0c2TWROK0FFa0ptTzlPdTc3QVc5S1hGU0dES015MVFqZ3ZC?=
 =?utf-8?B?Tk02NTc0VlNxVzFEcGpHZEFLK1JWekRjL0gzTjc5ZkY3ZXBaM2NtTThTQkNK?=
 =?utf-8?B?MlVVZG1CTWJaT3BZY3laMFBBRWNya1MrdEZsMkRtNk4wK1dSZXoxeDNWV21t?=
 =?utf-8?B?ZW01YVcyQ1p6KzUydmFmWWxNVWNQQVY3bW5hUFhrQnVhOCtzN2ZGeFhwVUVC?=
 =?utf-8?B?ajBWcGxZNEZpNHBFLzhOcXZZSWo4UUNoQ0RmWnp3cUdQd2kwOEZkOGFsTUhE?=
 =?utf-8?B?ZlpraDZ6TTBmc1J5VDEwYzRVYzA4SUZzSGxPZ1U0WUxRT2o2a0s5M2hNTm80?=
 =?utf-8?B?QkVlVVQ2U0tvWHVqN2huT0w2WTJUWWZHbWtvL3FOWEpSd2ZPZERTSVN5bS9R?=
 =?utf-8?Q?uGOkmsDEx7iPs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09OYzR1Zy95UXhBQjJ5K0x2UnNHbFVjb1dvd1o5b2s5N21sUTFDc3NLTDJL?=
 =?utf-8?B?bGlvRm1sTm5HZDl5ZWhQcmpJT1BVZ2wzVUxENFI2S1A4dkloaHhmRlFndEw0?=
 =?utf-8?B?OHF6TEZjSUVnMzFMejUrbWkzdkhsbE84UFZRd1RNeGU4T1BpS0NWanNwMURU?=
 =?utf-8?B?Mmp5S1llUmFXL09sNGZCWkdEdnVmWG56RjBxMVRTbU9idmQ5bmJRcVhvNmxk?=
 =?utf-8?B?Z1RCSEZHYzh6M1M5SVRWUFZlMTZ1MUw4NFFOTmZrc2kvbldDUDF0azlLNXdH?=
 =?utf-8?B?cHBzcU5oNjVqajhVSGxvRmsxb1hhWDBqZzRQQ0JqSWJNUUpBU29mTU1xWXdi?=
 =?utf-8?B?VjREUlJRUGEyVi9jMDdzWjJwT210T2ZHb1lPelQ4UmVqWEhoZ0s0UWdsZGZ1?=
 =?utf-8?B?MkNCSWRzSDArOGx2N0RlMkdTNThTOGsvSmlOemR2aWFHSmI5a21SZTRBWmx2?=
 =?utf-8?B?RzlWUCtITGJtOHIvTzRtN29jOEswSlpnMlN2YlVFUVY3aUNPWmdLNDhTd0Rw?=
 =?utf-8?B?SVZPTVFEUjh2TDg5UG5CNkQxUUYvbU5scmFRNklkWTVlb3hhWk1mWTd0bXdk?=
 =?utf-8?B?cDZ1VTdTZW5IYWl2NklkN3lMTzB4dkVKTnpXYzlRbG4vOFhUZG40UDNJaE5P?=
 =?utf-8?B?d2lHN3B4Tnc0VGtJczJ1d054VndZc29VdEhScG8zbG5DWHpEajFITVhjaVkr?=
 =?utf-8?B?K2ROd0ZOZnZPdURzejlKZnBVckJSUEdHQ05jMEtoY0QxdnZobmI4SzYrN25E?=
 =?utf-8?B?c1lBNmFpOVpCdkZ2NEZmanZpOVNTblBEUzJyUjVzMzFQVFVOUW1zckQ3cG9i?=
 =?utf-8?B?bTRtSC9DcmsvNktCeE5yVndIa0w5Q1cvRHdTY1pTMnV4TnNONWVIbUhTdk4z?=
 =?utf-8?B?aDF5dVgxMlFucFJpZlY2SmJRT3ljckFrRXZBVkxzVmF1ZTFIbTZVTFFzT3Mw?=
 =?utf-8?B?T01KS3pHTHdmbTI1QkptSktKamJTVTErQ2I3VW9DL3hLWUkrTElWZVFqZjB4?=
 =?utf-8?B?bUVjWXVWVmlEa2N5ZE9MWmkwVGI0SGh5NnR6aDRBeW5qUGNac1p0djh4a3Vk?=
 =?utf-8?B?Q2F5RXQ5eXd2b28zY3dBdS8rWmVJYTZBRi9KQWU1elRpSlBiK2g5STQrdTFl?=
 =?utf-8?B?WlA2TXlBYzFHM1ZIR28vUWwrVmtjblA5dGtyMTUrNUU1YThGWHYxZi9aL0xq?=
 =?utf-8?B?N3RzR1UvZC9LY0lNZlRhNGlCLzR2VFpmajJDYkFHc1ZFS2RNc0gyNzRMaUt4?=
 =?utf-8?B?cW8yS3VMbHYvY2tVQzZja0xlTzV1Uzgxek5HQmE3NVVLS1FRVGdyN2lSV3V0?=
 =?utf-8?B?S2x0NW9Ga2llZHhOTTJBMUFSSFNIZXAzT3Z3ODFnR1lIcmhsQUNpK3l0NWZh?=
 =?utf-8?B?d2c1eGE1c3ZvTTZQMXRuR1hiaTE2TThqM0VJdXFBZmFkbDc5S0dhbTJTR2ZR?=
 =?utf-8?B?R1Q4TVlBRDdxOWx6WVAvekhyWEJ5WW5tZytsTGp4UUhXeDJPQlFMVkpTNnFa?=
 =?utf-8?B?bVdYSUpZa0t2MWN2VjhuNE9Gbjd3cGFVcWdJYmlHclNwTjM2VmJqOWlGOXEv?=
 =?utf-8?B?VVczZkJ4Sm92TXpzVjc3L1Q1ek1SUGxYSDI1R1ZUcWNJYWxrQ2ZJL095RG1X?=
 =?utf-8?B?bHdpS2pLc3lPMDBqYkh2TWMwK01aZ1BjRU1RQ2VNVkVFUUpBY3RORFFhcFZh?=
 =?utf-8?B?NXVqYUVsdUYyT0J6WEt5bEJYR3ozZUgvem13cnk1WUJBanZ2aWpMdXF5c20x?=
 =?utf-8?B?aFZSVitPaTBLK2dNM2JuR3dneDkrOXRpVU5ObGwvUmZNN1k2dG9jVVlqNW43?=
 =?utf-8?B?K1NsYnVCV2d4eWszaUVseUZ4aUMyOU1CVmJVbFBFdENqUW4reHRDbHFDaXpJ?=
 =?utf-8?B?RUtSRXJ3NzFXY2g2dUEwT2g5WGdCNDR1TExzRHo5alJ3eC9rR3ZQVWc4V0Z2?=
 =?utf-8?B?bjhOUDd4RXYzbytUM1c3c3pTMlNDS20zc29OK05KSHAzSGxRM2JpbzZiNCtP?=
 =?utf-8?B?ZThnZmZta2tNSXUxZUJ1RVFJMkxJaUtxUnh1SkowTTF5WmZkOW1lVmhLQlBN?=
 =?utf-8?B?VlMvVmljMVZEclUyTlRBclpleCtKQVVqTFVFc2tsVFJWS2VOREJ3TnBoY2Qr?=
 =?utf-8?Q?HOPi2VXwWkgeu/6Go0Hr43Vmn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c70527-a688-4dad-80b1-08dd61eab643
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 04:51:26.7876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwJ6NKimU2JrUaXs1gy3hbcKzNrhksTaHtSXFHWblLs+26eoD6/LRi18mzjh4uSTCAzhoj6gC45KsJ5Gp3oc6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8021



On 20/2/25 07:37, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 02:23:24PM -0600, Michael Roth wrote:
>> Just for clarity: at least for normal/nested page table (but I'm
>> assuming the same applies to IOMMU mappings), 1G mappings are
>> handled similarly as 2MB mappings as far as RMP table checks are
>> concerned: each 2MB range is checked individually as if it were
>> a separate 2MB mapping:
> 
> Well, IIRC we are dealing with the AMDv1 IO page table here which
> supports more sizes than 1G and we likely start to see things like 4M
> mappings and the like. So maybe there is some issue if the above
> special case really only applies to 1G and only 1G.
> 
>> But the point still stands for 4K RMP entries and 2MB mappings: a 2MB
>> mapping either requires private page RMP entries to be 2MB, or in the
>> case of 2MB mapping of shared pages, every page in the range must be
>> shared according to the corresponding RMP entries.
> 
>   Is 4k RMP what people are running?
> 
>> I think, for the non-SEV-TIO use-case, it had more to do with inability
>> to unmap a 4K range once a particular 4K page has been converted
> 
> Yes, we don't support unmap or resize. The entire theory of operation
> has the IOPTEs cover the guest memory and remain static at VM boot
> time. The RMP alone controls access and handles the static/private.
> 
> Assuming the host used 2M pages the IOPTEs in an AMDv1 table will be
> sized around 2M,4M,8M just based around random luck.
> 
> So it sounds like you can get to a situation with a >=2M mapping in
> the IOPTE but the guest has split it into private/shared at lower
> granularity and the HW cannot handle this?
> 
>> from shared to private if it was originally installed via a 2MB IOPTE,
>> since the guest could actively be DMA'ing to other shared pages in
>> the 2M range (but we can be assured it is not DMA'ing to a particular 4K
>> page it has converted to private), and the IOMMU doesn't (AFAIK) have
>> a way to atomically split an existing 2MB IOPTE to avoid this.
> 
> The iommu can split it (with SW help), I'm working on that
> infrastructure right now..
> 
> So you will get a notification that the guest has made a
> private/public split and the iommu page table can be atomically
> restructured to put an IOPTE boundary at the split.

About this atomical restructure - I looked at yours iommu-pt branch on 
github but  __cut_mapping()->pt_table_install64() only atomically swaps 
the PDE but it does not do IOMMU TLB invalidate, have I missed it? And 
if it did so, that would not be atomic but it won't matter as long as we 
do not destroy the old PDE before invalidating IOMMU TLB, is this the 
idea? Thanks,

> 
> Then the HW will not see IOPTEs that exceed the shared/private
> granularity of the VM.
> 
> Jason

-- 
Alexey


