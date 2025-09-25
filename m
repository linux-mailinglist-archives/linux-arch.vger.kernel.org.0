Return-Path: <linux-arch+bounces-13770-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CB8B9F34A
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 14:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924C55E0542
	for <lists+linux-arch@lfdr.de>; Thu, 25 Sep 2025 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366330596B;
	Thu, 25 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qElq5Ndu"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB2305E18;
	Thu, 25 Sep 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802556; cv=fail; b=UANONU65khN0l0DuSCDqOEgPdjxg0yHbg50cGsqSxdSXe61yYOpdT5UyG3fjOEKGWj722ulxl5gmprENJWTJw1Dy5w8mEavBfB90bqKyKsuThrVNsXeOKEXEQaV/2fRG/oRDCSF6ervzTLoDgaiEYhCsHqFQ4YG5bWWMde0q2/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802556; c=relaxed/simple;
	bh=C6OK0DEqQYfdE2bu+m7l229wEPb0L3KQ3o/LPEzPde8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ppI/vf3LtHDgxRD8zJUfqptQ/CsVQQ/iWtR1e6eyWuc1X7Zxitn5AKFrXqFckFvPqnQWmHfj3BcA4SvaqIqKOmuYjBDOGCp9T3QOW8Dlk10F7rXeRs3EUbKb+sZVOzZRSS3XqkLhCTFOsQgF0nmXqU+frbypsg3aJoZljHhHJlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qElq5Ndu; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGdKhTkxI9qXzKNakwU3duZ7xCUfa8qTgE1i2px3jJ0BVJP03Bxn8IRurc7fdS9BnX7hUt2eNbSo4eO++CvQYjHaVhi5zF6JaJC/DOq5FdFro5cNVXLH8gYb7piRZqdDhnMnBq8jatYyTXKknua1f/gqnnDhofXYJNlqMyNE91LG1ArmgeyqCWKXuPBTyTkmz1veDMHE4ifLGOgOfRz4ZGxZrcv/TosgjPgsDbwTDhWP/gV/+j1etoQZOppyPkRuKfluUbB0c3Gy9+MkKHGqXgknVhk2KWkWO3NvGqLO0nS/JFFXK0Vu8sMHF8p/hhUkXVBEIWkURUCPUoSnWK+6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C32IGLq3uKmp+y9BZi3DQjc96Hprp6pTZzegU1isd7w=;
 b=dCsJPVcmEz1khoHsgfDQzE0RZDfSAFhJ4bd8h87hQVJBSm0oPkBOw82jx1TX0Bjm/VDRDO4xIhYj0dRAX1nzLhs1H00aqEwkjqwxMRHVWR2au2oH0UwJD9Y1+sQapT12b8SdJ8utKabDlpVvR7jjLf2nTb9LlXDuNDhzTO7Gzq0vcBzJE+hIP0Dki4ExwJxh6NuZGiEWSi+NU3XjjQJLSgCKiv1+bLvDI127MwO51vb0Jcw0C5vmUBjOVbEBZ2VyklmHusuBC9ku644mm3cyAmyL5izulbyQCX53HhjAhBUbgmJNM/QDmSWwjtQDg1X0JLFqZfUOJtpFqXYmzpnTnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C32IGLq3uKmp+y9BZi3DQjc96Hprp6pTZzegU1isd7w=;
 b=qElq5Ndu3vNJiSkWjpdVzBtIIr6UjevZITxz4MolH00MCWfxy70xaPHzmB3GLeFvkGvw2As6taEfnHfaWPTvOpzcZa51+3j6+ytsysin8WkzdGn4RBPG8KT5Rmo5Oy75KJjBu6Ks7rF+xnkFmEd2FUPue6TocXxBhWkEiNqMOyELA+qvFRoevGCaN/5rhIEvJRD2ZB5dUpCGKz1FHewdFF3lIrc2oMbrsEriJd/2rF59dRFRmxTv0XUtP78JLaF4qs2CrPXPcRfE29poOnQgzjeM5YBXzNXiRtMdPmFwbaCoUT6kOdXcaaxT3kYJrcGo2kIqm86I0SC7rSXtFu8uFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Thu, 25 Sep
 2025 12:15:52 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 12:15:52 +0000
Message-ID: <d548b14e-ae28-4807-9b29-9961543ea549@nvidia.com>
Date: Thu, 25 Sep 2025 15:15:46 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V5] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
To: Jason Gunthorpe <jgg@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Michael Guralnik
 <michaelgur@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Will Deacon <will@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Justin Stitt <justinstitt@google.com>,
 linux-s390@vger.kernel.org, llvm@lists.linux.dev,
 Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Salil Mehta <salil.mehta@huawei.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
 Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
 Niklas Schnelle <schnelle@linux.ibm.com>, Jijie Shao <shaojijie@huawei.com>,
 Simon Horman <horms@kernel.org>
References: <1758800913-830383-1-git-send-email-tariqt@nvidia.com>
 <20250925115433.GU2617119@nvidia.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20250925115433.GU2617119@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f5a0ca-d984-485d-2595-08ddfc2d44f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm9zVVZVOTdXcjJaVXpPcG1oTHdxb1haYUljT3N1cUMwUjQ4L29QUDVMeXgw?=
 =?utf-8?B?SnRLcWRwVW1TanIyYWYvemsrR2Joc29rbGE3ZzlGQnhvTGt2UWE0K3MvanQ5?=
 =?utf-8?B?STlyNHNzOEpqQk8zMHRZSjdVM1FwQWVacFRIdnRwYTFCTXZnSXZ0eWEvT29S?=
 =?utf-8?B?SjhncE9KQi9JSEg0a2tXdW4rN0RPT0c0eXR6My9ESDB5QTR4SktVZkZIRFFj?=
 =?utf-8?B?Y2t4NTdEekJTaExpNmZkK0xadUxjRVVPNFd3YUZJZ0l2NUxyVGF4cWZqcFVr?=
 =?utf-8?B?dFMrYi81ZGFhNHJLdDcydVZ0T1A0bmVhbmtHNlpONkEwMEQ0NXZYODhZSk5z?=
 =?utf-8?B?WWg1UHFETHIrM0lzT2IrNnFBNzlmZkpUakNBNzNlZ0xsSEl6NzNHTmV4MnIv?=
 =?utf-8?B?eGc5YjhOYmN2NkZjRnJiYm8wRzE0MlRDcnlZY09zaUhEaDJYNUVyUXVPWjcw?=
 =?utf-8?B?Wlk1dUZUZGcyano0dnFvb1ZzZkVIME1ZUkR0ZXM0cDNsOVBWbjc0QjNJSncw?=
 =?utf-8?B?c1A3VFp6L0lYOFNQWkNHZVZoTDI0Rk4vV1NULzlBcTRPL3U4aU0wa0ZWbmVK?=
 =?utf-8?B?bEIvcktCYVNxU0EwTW1qamdkdDlGbXgyZ2c1Z1E5VmZReVV0RXp1RTh5dlo3?=
 =?utf-8?B?cDF5UEk0Z0pROTIxMC8xdUdDR3pueFI5TzIzUXFMd3F1OFFDOGQyTzYwdGU0?=
 =?utf-8?B?TUVVQWh2eEx3MWVJSnYxMDZJSHY3MFBhNlBzTXJkMC85Y3kzV091bTRLOWZM?=
 =?utf-8?B?YStmMlFpdmgwMXVJY3AwblJCTjlNU3pVb1pRV1pQM3V4NUpGL1ZjWGptZkg4?=
 =?utf-8?B?dkNkazgxN2NpcHhaTDlaUW9uRHJRSmZMMnNXSTA4V2ltZjFEUDR4TjJza3I3?=
 =?utf-8?B?Y1dEY3lvVStITllhYjU4UW4wMUdNcWtITWhsMnMyUEx3d0RZYUg5cFhWSnM1?=
 =?utf-8?B?SzZ2V3NOVU5KZzJXSllNd1U3eFNqUGZGKzFhK1BjcGVrYmZNTkN2N0UxNldF?=
 =?utf-8?B?YzVzM3A0YzJnaE4rSXpDU0VNTDNYTFpHSTBvR2l6RGhCZ3JCVVBBRGloUEtP?=
 =?utf-8?B?Rkc1L3VnZktBRlFqUEN1VzZRZTlUMWNVZEhTMkp2aFJKRlBqRHJBM3NhSnlR?=
 =?utf-8?B?Ni93VG9TRWdFSWo0clIwVHZ2eG9UR2V2SXF1UGtqYWtnVFNHS1FtV3hzeVJF?=
 =?utf-8?B?WnY4K3FaS3pOQU05MW5HeW5VeldkclloNG9CaWhiR3Mxbmx5eENINWlVQzRh?=
 =?utf-8?B?UVdPa0hpaEt4VTB1Z1dQL2RyZFB5aE5DMVBudlovMGx5ZHZlMlJSbEJHQzh0?=
 =?utf-8?B?SUM0K2RqT1p1Y1U1Vno4RW41WkJpU0tMTHE1djFzSGtwR05CdXVGSVFCWmlx?=
 =?utf-8?B?dFpValpFb2RDUjlBSFVVak1BdnhyTytrcWQ5U1pYSmFDamVOSmhxSVhKajMw?=
 =?utf-8?B?NHExWURiU3ZnNlk2ZlA0SFdJdnNnVHM4ZlJXLzgvc2NKYzBtL3lwV3ZwaTZx?=
 =?utf-8?B?Zkh3S1NsaWh2TXJFVTNPbVZLWTRiUFRLREd2RTJET2hscVN6cENzRFVJMFE3?=
 =?utf-8?B?dGpyVGE1MUlFaDBzNnFyYmdFUlY0YythUUJtRnZ3V0dMWlFhZm5CQjNyVm8y?=
 =?utf-8?B?SUVVR2FyVmkxc3V4NFFqY1lwUEwxcGoyUjRYSlhvc2llRVV4a2x2NUFwd2ZQ?=
 =?utf-8?B?VjBKZU8vS1JER1BXOGoySWdUbklOeXZuV0NTVmJRbGUwYkdVeDQvc2ppemo0?=
 =?utf-8?B?aVN0dFRXQzZLd2U5bTkwV2s1RVQ4cVFqK09OYWhad1pBYzdWSjVBMVE3aEsx?=
 =?utf-8?B?ODZLcjhlWWZaS3lPNXFqbkIrQ2ppZW9wODRkdmpzVUU0bEtjbnF6ajRDRkpF?=
 =?utf-8?B?MHNSenFnUUlncW05TVZHOWtIM0h6RmovNVduUVhBekdUUU1sVWtNYnlWRzNs?=
 =?utf-8?Q?lJ+TkwxcU84urUYT2yOvwSUrK9mpFEwO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkkrVk9lL0xNOEVsQU81UFJ1U3FxV2ZqRWwyTWMrSWlHK2V2SmRTbnJkVU1t?=
 =?utf-8?B?QlpLM1BmZms4YmpNV2I5S0c4ZGFNL3pCRE81ZlNqZHkwZmU1M1h3VGxiNTlP?=
 =?utf-8?B?eHdKWEFsSnJXd1VDV25wSkVPbnl6K1EweTc3cjY4N1A5WngwQkxYZnRnRTNp?=
 =?utf-8?B?QkhRYmRJbjN5RjN4OEdsdkhQRHpsMlREMjFKOWRKcFJ5bS9qaDY1Rmd6UFNC?=
 =?utf-8?B?V25OZ2lMSVRxelF5eXJZWHBZK0dzQzk1Z3ZvM05kR2lubXVIVE9IMEpBd2dm?=
 =?utf-8?B?dnZSMURJM2NyKzVDaDI0M1crZDJ2MGlLdXNDM1NjajVjbHdUSnd0RlR0SkF0?=
 =?utf-8?B?a1Q0Z0pUNElITXNYOHI0T1dyeFc0UlovWjYwbFJMSStHaHRSejE4SE9VL1Zk?=
 =?utf-8?B?K1o2c0tUOHkzTFNSSkdaY1lzVWIvajR4aDJVb0gxTFM3REVZUUdSVFE3b1RM?=
 =?utf-8?B?YU84V2thOEZwbzVkR3plSnR1b0dPSXJSa0E5Ukl0WFFEelZaUSt2NUluNkEw?=
 =?utf-8?B?TjVEdTFPWUc1Q2ZiNUdObTVMOVpSR3FsaWIxL3BDV1ZlMklKeDJ6YmIwZGln?=
 =?utf-8?B?d0JHUUt3QWVyNk0yWFdpSk1NK2R4ZlB0WnZmdmZpNDVhNWZnRGtacEREQVhF?=
 =?utf-8?B?WDcwUmlNR0FoY0hUam55YXBvaWZOQlZqQkdINlc5YTg0eXdSa2hQZ1QrSGRE?=
 =?utf-8?B?blp5eXJLYVV4aTRTYjFUVEY2K1ZzWUxJdFdLNGpMWmZteUFQSlFWa1dZeWpP?=
 =?utf-8?B?dXJGeU94ZmtGaldKQmhYcWpMYlZBeXZ5S2g5WHk5TWlmclQ0VU1WRHF1dTZl?=
 =?utf-8?B?b3p4KzlQOHlha3ZXYWV2cmRoOURsZHdMY3Y1NFIvRlRqdS9FRmFaeEVaamEv?=
 =?utf-8?B?QlFFZVhiZHI5SEh3dGFSdTk4My9sUjNzZFp1YUhWRXVqTjJGZzN2QmZBVTZS?=
 =?utf-8?B?ZFdNdDVnN0ZqU1JlY3NpSmp6dlVFUXoyUXhucEZhcytlbW9KV1BHL1JRUUs3?=
 =?utf-8?B?cDlQTDFSYU1hdEtjMU5lQVJ0dXBsU29IaGtpa0RCb1FoeUl0aTZSUW0vaTAr?=
 =?utf-8?B?eEpkazJicm1pSmhyRW1LN1ZVZ1diY0FOTStFZ1B5aC9wUVJaVUNDcnFyOHNC?=
 =?utf-8?B?NEpOWG9wVjEyU1Y4ZVdrNFNZaWhGbjhLQ25KV1htK3pOb2lqY2VlRDBxOHBn?=
 =?utf-8?B?Wk4zN25qcFE5NktIRzdNSTIyN3lsL0U5KzFlLzkrVkJJTzBLN2pWZjd3WEwx?=
 =?utf-8?B?OFEwTjRRelB0NDhtczVxYUNTYThhQUl6N0JZdWlmaE1zbjh5ZjVUcHBLTDNr?=
 =?utf-8?B?Skx4TS84amJnSGZGUmV5cy8zbmtQOUVRUzc5MVZTVmZ6aWkzOGNRVFE5TDgw?=
 =?utf-8?B?c0ZEQXc0ZVZobEdhUUpBcUZqL2E5aFdHd0Y2UEJuU3VzdEg1R2I2bUo3d3p1?=
 =?utf-8?B?a0tVMTBXb2MvNExwblFtM0tic1BlOXF2cndaUEpPb3MwK04rdHU2YytNcWEv?=
 =?utf-8?B?c2YxQ29wQ2kzSGkwMU5rOTd3dmxzVWp3cThoS1ovVzVzYWlsMXYxeGE3d29G?=
 =?utf-8?B?bzhJSjNueUlMTkdGZU0rRmhUTmIyQjBVMHc1Zk8xWnluZTBJTHZnMnc4NkRX?=
 =?utf-8?B?Rm1LczZXa25VcXhXNDd3bUpDZkNsUlVtVFhFYnJDaWFIR2gwMFo4eDNOZ09j?=
 =?utf-8?B?TkJvMERSQ0dhcHZUaU9QL2dYNE1CdllLOSs0dVl4cUxtYTJFcWVFa2tKdU9i?=
 =?utf-8?B?SmtqNkZRQ3c3TDBodHJreDJVeEdMOHBjQUI5OEhDYVIrNXRvbHhaQktvcXFJ?=
 =?utf-8?B?ZjF2WlR3TUZ3U0dBenRYbzd1YndiS1hzMlhQTldndmhBRTJsVXg4L2oxcy9x?=
 =?utf-8?B?cVp6dFJMV1QyU1VtK1hWMnlFTk1RQUovMUdhYTJHbkl0RDRYOFFqN3lBTW0r?=
 =?utf-8?B?NFlTNDRKVk9nbHdQYTBsdHhNM2NFdHNOUFRqZ1l3YjJuWXNJK0hsekx6S3Zn?=
 =?utf-8?B?ZjNsdFRDalJnYXA0a2Z3bEtERHJwN2owVFhYbzlhQURNNm9Ya2lqUEcxbDR1?=
 =?utf-8?B?U1ZYd2p3NVVYS1NZZU5JdGlySzZHVmxwMnA1c3pJS3UzMVk3aFloeldocVdP?=
 =?utf-8?Q?phnxY6WhfHrO5EEhdA7HY12sI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f5a0ca-d984-485d-2595-08ddfc2d44f3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 12:15:52.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYnmVmLPPQA6uWBxpZDEid0/sRtlBkzVHvoF/zkhjxtXlYjDiBcbMo9AztRqgqn2PacCz8n9Kv7GxpfmQsls6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137


On 9/25/2025 2:54 PM, Jason Gunthorpe wrote:
> On Thu, Sep 25, 2025 at 02:48:33PM +0300, Tariq Toukan wrote:
>> +static void mlx5_iowrite64_copy(struct mlx5_wc_sq *sq, __be32 mmio_wqe[16],
>> +				size_t mmio_wqe_size, unsigned int offset)
>> +{
>> +#if defined(CONFIG_KERNEL_MODE_NEON) && defined(CONFIG_ARM64)
> IS_ENABLED() not defined()
I just wonder why, Is there a preference in the driver from like 
aesthetic/convention point of view?
Since here it technically doesnt matter - IS_ENABLED have no functional 
difference from defined since these are boolean configs not 
*tristate*ones (cant be loaded as module).

Patrisious.
>
> Jason

