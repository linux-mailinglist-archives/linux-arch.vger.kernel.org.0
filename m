Return-Path: <linux-arch+bounces-13654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B90B592A4
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7A917B3217
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 09:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3DA296BBC;
	Tue, 16 Sep 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="axfIA8Dn"
X-Original-To: linux-arch@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4B1514F7;
	Tue, 16 Sep 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016055; cv=fail; b=g3a71gNxqA7I7QAE/JVW3n7gCbTLW1kNG77uBGEWvOEa3DoKKcJOlwkLiRDlsHeFiwrv0fKGIgCaeQjYCx30HnSe+08ZOiF4yhaCF1qEf7VuONNDSEEPvi79AAqhGxv3vSTalpT3gRo2ItO/I2kkJrHk1M5HUcGBdopoPdzncnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016055; c=relaxed/simple;
	bh=NNW+zPre5AXNG3eeJFBmmDX5EfNvVNDsXKloGc3b3pE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z32CiwAxi+98NWul6SlZBGWhN4Sg3eyrLD6EAYqfgp8EsziYGBaGBiCfhHFgwAy7Uk1e0IgsO8pBVKeh+KY6SVi4cQAjj7GF+NPqm4Hl9zvNccHNX3U47z0CNkhpdCJtMhoH/bMSwiYiG7qlEAocmh4fEs2IMVUm7u4Ys7QQd2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=axfIA8Dn; arc=fail smtp.client-ip=52.101.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIR5n/M3N4KTwrGE95u089pVmx9ao/fnmlNtw7UHibnFFbzOB2p22nTwNJ8NIxM9rchPsQapy346a4G3WrJ6QuRfqf0anvX6suZX4nukX3CKYklr1uA/lx+9qrqFNa4qIDez4PZl10Lj9fsGnQjAFPtWmqnX08L0XT5UiAiNDqQiaoYXN37v3ONlFQXLqZx4XPUEbBFOWAGopQb07HKdxnK61AkRcU54G22NzErKsclwHi1mLP9xcrVH/3VsDj/7ZIc17Bn/UhyZj/fJ/L+/Q8T6RRf+WUiwRpChQOfbRjIedIK8w2p623npxlyeWm4pj1cNbrcG5lEp0iOtyae9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NRMTIT4J47ynqTx+LrFjOtwr3VgH5awADeNvBBM1Zw=;
 b=hSWip9yO10I+Usk2lxEBTG080+2tUHpc2v4cCYLJP/4s5VAwHHpWp0sbcMz6R7GhO7oNp01XcBlILXX08QD1BXnOIImw8lO9MfbsyK0BzttV5OhBBr3mbbSju5iThgBsqQDnlnIIkO3JhJTUaP010+YjEAn52FQJvFRZNyE8qw9RtI67A2O0HyW7j3+uDl/e7ed9+IP0z+UvF11dOqBthFZMpDlVUe4LcajmiOL3xVK0G8v4IV+YbUGNvEi0pGJCWA19xgZn5DcUEx5qk09DJ/uLyePXx0rTWDAjc9q6RrhsMqBjbVAsIqCZDDAhw/pDd2P4nGnq2k/aXVdDzBrBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NRMTIT4J47ynqTx+LrFjOtwr3VgH5awADeNvBBM1Zw=;
 b=axfIA8DnL0zNuDH05G8wsXInv2vgZ9D0X769bi2/z5TeI7t+7dFaLTqvFGZV8kLs+vfJTHiIoNFHuJPEClrLkaXwt8R2dPjhza0If0JAHv3jMyDgvDVRbwzAyhZMiCsLPQjqCBgLWp9dufUT61f2xf0ARVjWbsj3qOI8HSGToJ3BZputaBMAztV/g2S+BR89iNKVA+OjMEqWcRtdSSp7oK7OR1mvXW1VdgHuUbFi6ZvyORST19xKqxn8v/nYC1OZK15tYmx1iJ6tMjZp1wGqtuGpY8MUMHu2+YmKPe9Rie8soSujSAhQtgwkcuqL82xESI8lcMyl/vWGpqI9yGsxdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 09:47:27 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:47:27 +0000
Message-ID: <0c61ff65-fdc7-43a3-a62b-75e0d76b95fd@nvidia.com>
Date: Tue, 16 Sep 2025 12:47:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
To: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
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
 Nick Desaulniers <ndesaulniers@google.com>,
 Salil Mehta <salil.mehta@huawei.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 Yisen Zhuang <yisen.zhuang@huawei.com>, Leon Romanovsky
 <leonro@mellanox.com>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
 Niklas Schnelle <schnelle@linux.ibm.com>, Jijie Shao <shaojijie@huawei.com>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
 <20250915221859.GB925462@ax162> <20250915222758.GC925462@ax162>
 <20250915224810.GM1024672@nvidia.com> <20250915231506.GA973819@ax162>
 <d259ffa9-6c9e-488f-a64f-81025deba75c@nvidia.com>
 <9d4cd8d2-343e-4448-ab59-65e69728c850@app.fastmail.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <9d4cd8d2-343e-4448-ab59-65e69728c850@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0009.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::18) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e873a1-d0b4-417c-9bec-08ddf5060bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TG9DU1UxZy9uQ0Z4eHprUHNRdUJveCtSeGtsRERJUU1kWjVCc1l5WTVTTjRo?=
 =?utf-8?B?alNnaDNpR0xJVjdqN3RHczZiZFhIQVg5eGpmc0lRaXl3NXdtNE5KZ05wREgx?=
 =?utf-8?B?SS9ST1VuWGlUbi9COEN4aTNxMnByRkFqYkZlSEprQmRKekhkNDAxZndlcDBa?=
 =?utf-8?B?b3dRMXBveFc2VmtHNlNjRCswK2YxVWxYTU5tT0d2M0hES3paYnhWcHlvaDBD?=
 =?utf-8?B?eTJsS1VNb2JyOXZ1S3hzWVNubmdWak05NUkybUVoai9uK1l6TnlWV0E0YWd4?=
 =?utf-8?B?dTlmeGI4U1FhaFhSZ0lndnI3WU1LSytrS3ZYVnpuUmsrd21rZ1RFNjNBMTV5?=
 =?utf-8?B?dkN1WktSZmV0dGIva3diTmJmeDJKbDN6YVNxa3dpSHIyNVd2S3pRdGZCOEhI?=
 =?utf-8?B?WDJLcEZ2algvRmJlVkNFSkxiV0pKOUdZM2Y3aThLajNEQkR1RFZ5bEkyZ1Fk?=
 =?utf-8?B?TGliNXRoVU5DRk44U2kwVy9mOEVEVEg1dXEvT0lSbWZWeXBtcktXWkdXbXNY?=
 =?utf-8?B?eVgwSDZtNjBQN3VUaUNJNFV5MmdTTHpacjhQK1NYNFVETjRoTEY3U0ttR3JV?=
 =?utf-8?B?Yzg2QVJpdVp1cWFMV08xeTVMejNoUEhDby9TNVRLZGJpLzJrbkdUWGpxRS9k?=
 =?utf-8?B?bFJBZzViTSs1UTMxcUYrVTJSODhTRFZIQlV5TXh1cWFkbGg4Rm1FWHFLUm5r?=
 =?utf-8?B?ejY5TkhRck9hSWJ2K25nV0Z2d2hDZ1J6b0NoVXRhRmluK3M2elo2M2RNR3Jh?=
 =?utf-8?B?Sm5SSStic2s5RmNmd0p6RWQ4cEQzejZOZVhmdWVoQUJpOVRxZ2tWZFJxZ3Zr?=
 =?utf-8?B?T3gwMlllbFoxU3h3VHQ1WHREV2EwSm5UY2J3ODltN0IvZ09PbVF4Z09mMWIr?=
 =?utf-8?B?WWllZW5NNGxSd3VIczdaajYyQXo3Qi9CV2oyOTJXRmhoekFjcWpPb0IwZ00x?=
 =?utf-8?B?bzFTR1RhT2VoaWYwYjdUNEs5Z3M5UDBpTmRrM0VBSThHaVJjV1B3eTFraWE1?=
 =?utf-8?B?MUYxWTd0Qk1kRUhSL3U2TEs4UXVTODNzL0dWeGxuNnVLRnVYNjhGckxwNVY1?=
 =?utf-8?B?bTlHYXZLRlJJZWNkNDMvNjgwYVVhaWNLVzNrb2swNHN5d0F0SS9icEoyRnZW?=
 =?utf-8?B?bmZhL3puMlNlT2UzVG5aWi9SNzE2VmRJcVBrMy9rUGt2TmJTc2JmL3p2SG0w?=
 =?utf-8?B?ZXkrV0pGSGlEdzZGWUVSb1JPSk5EeEVJNjZzUW5va0gzZHJWU2tYY1U5bXNa?=
 =?utf-8?B?V3ZoUlZEbzc1amlyR3JZdDdFQnBrV3BkMXJ1dWl4NThGWXpvN3AwN3Q1UEdj?=
 =?utf-8?B?R3F2cVpZUlB5eHZkMUJ5NE5iWkt4bUQ0bGxTVGJvRFRGQlhiQXVkK1pRYWZR?=
 =?utf-8?B?clFJN2dDMDhZdmk1dFpuNDRXcmd0akk5dWlPdGFzaGlvNE5maDM1NENITW9J?=
 =?utf-8?B?T1NjUmE3YVBuRzhhSTBsUDByQUlOMjNXZStPN1pGMCtLYVMrcTU3UnZSNkxN?=
 =?utf-8?B?RStBNndNVUR0S1I0Z0V4a1VGUkxGa1dsOGpEYlJFVVI3ajlIQ0hXdDFrMWRB?=
 =?utf-8?B?ZVJGN29tY3RSNDFRRk82VnJRWGZPbjE2Vkx3aEl2Mzh6MDBMT0xXdGlLVEc1?=
 =?utf-8?B?N0VmbWZxUW1WMHhWM3pXYmFQeWYvUWtGSlZUT0p5WFFGZXhmRk1aaElMKzJB?=
 =?utf-8?B?a2NZY0srYlJSMFcxeUxvak5LR29RZXZUaXJjRStudFFXVnczYjdzUStXVDdp?=
 =?utf-8?B?eGV2dWEramM3WTUrc0FHV3krWE13Z2Y3TUtnb2tBSERibzVZeDkwdjlBc0ZW?=
 =?utf-8?B?eFlhTFh5dUJpT1c2d3N6OGJJbjZmakN4SWxEWjJEdVdGVVpwblNUV09RZW1o?=
 =?utf-8?B?cUNYdDc1RkFwTjVFcVF1WUpuLzRwNXFCa3FWM3RaeU4zQk9QWlhqVTBTN1lG?=
 =?utf-8?Q?WjPgn2PMghg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjFodmVwMXRjZjcvU2NINW1ZK0R2OUYySjRkUytDL21YZk1QVTJHdGtkOEMx?=
 =?utf-8?B?RS94VTNyem1wWFh3dEpiaHN2V2hxd2xTU1BqUENsVDF6Y0FYUHVjM0RnLzhi?=
 =?utf-8?B?aUJYN285YTRVRzJQRTRnZVZicEJYSFUzcEZVT1JkZkZtU3BPanBOb2FpTkNO?=
 =?utf-8?B?TEwyaDB4YUd4TjlOY2JaMmZGYnpKWDFIT3BmUVlYUGlMQ0V5UTJPcEo4VDgw?=
 =?utf-8?B?Z2lQMWhkZ04zb2E5RGVXYzlFcDlycGhqSy9EZFY3ckdhR3N4U2RWQncrTGE0?=
 =?utf-8?B?MDVkUDVrclBpbXdPN2NvOFVFUHN1V0pETlk2M2E1K1JnL3A0R3dJYmh0UjI3?=
 =?utf-8?B?UGFyQ3d6RC93TU5pRWtGLytFZ0FPampQL2NrWDZrcUJ2VTFuL01adUlzMVBa?=
 =?utf-8?B?c1c3MWpWT1Bzd2F1T3lEd09QRXhQMHZxVVFpbHBZMDhodkpWNERQOWtBS21v?=
 =?utf-8?B?VGtkTEZHcU1SRlNFODRxcXlCa2k5d0RMTnBtMlZ5Y3JGT0pURHVIcHhmcnZn?=
 =?utf-8?B?RjNyTng5MWJRYWQ1eHpjSm1KWWJXYWllWVBxejBDcjRSdXp1dm9rbTNQT2tK?=
 =?utf-8?B?M2tuZmxTWWM0YmNtYjVxMWs2aGlHYTNGUHFpSHFocEppQ25Ibi96RlJKZnlO?=
 =?utf-8?B?STlQZUczNEtqSE55Tnh2dnd1a3ZOd0twWG5OcnBKNGROM09zQWkwMERqSW1U?=
 =?utf-8?B?aE5JWm5VY3g5QS9lSmNzNElqTzhQazlNdlB0bHYrcWdLRzVTenZjMWJGLzJl?=
 =?utf-8?B?UFkxcGEwRXpaZng1T3hXTEFibnVDYWdOcnI0SERvbmI4NFJneWdoaHk4dStr?=
 =?utf-8?B?SHNRZkxSODQ4eFpTaE8wRXptRTh2cTVBaTlCUFVqcFVPRm52Z0ZBVXdvSUFG?=
 =?utf-8?B?V1VIWERXbytXUjNpaXc3Mlo2UjV6K055Q1VVbklhZHJoMGxiUWVuSE9HZEdq?=
 =?utf-8?B?dG94WEZ5THlRaXNISnNIOUFzTytaUk5ML2ZEKzlRQ0VHMFVZYklCWVdvWFZX?=
 =?utf-8?B?RmM3dDB2S1F3djE0enNOUWQvaEZzNnlOUnZ0TjRYc0o5UllwY2VzSk1NWmxK?=
 =?utf-8?B?VkIrNS9KY2ZuYnJWMDJ1ZEt2bXN3WnpodzFWYThMVXRUVzNEZER2TTFNb3d4?=
 =?utf-8?B?eGZuZ3dQa1pWVUordTMrTUptQ3BqS0VqSEp6Y1lqcElZRUZYcjJDckF4U1J1?=
 =?utf-8?B?VkRIU2JNL3JhREhjY3dIdzhiekoxZS91L2hYK2xNMXk2cHVmaituNm5ONStF?=
 =?utf-8?B?WlAycGhJZGJJcmlpbU5ubzdtZ2EzTTdEODhNaVcrcG54a081WktsLy9PbmNN?=
 =?utf-8?B?R2dvclRXSEV6K1ZiY2JmZDMxTFFLYnMwVDZJSXZLVHk5NzFPdkg3SHEyQi8z?=
 =?utf-8?B?cEZsaTcyTUhDS2tWcHFDNWEvRUMrR2xjWXR2U3BXSEFhUlM3dGszQTl0RzFC?=
 =?utf-8?B?SEdBTlh2Y1NNWTYxaGcvSVVhZkNpNWRVcjc3bUJzZkhROGtWMWh0aHB6dWFx?=
 =?utf-8?B?STh0NFRFSTh5cGJ3cDRCL0E5M0RkdkQ0OTZYZ2Ztb29rNHBaRFlvTmdpWmJ4?=
 =?utf-8?B?S2JHOHhqSEsxT0pPUUFxNVYvN1VhTWU3K05lclZEajdHWEZKSndlZ0RuUGpV?=
 =?utf-8?B?bDQ3SjJSL2FPbUhXbHQzZ2JJOE5DT3F2YmRsS1hud1l4M0dzMDBMSCt3R1FG?=
 =?utf-8?B?UDJTM3pnRk1UcWtuY3lRclg4dG5hM0lLTUxEd0xXVmxzMVFNQXpSL0hVNElL?=
 =?utf-8?B?YVRZRWNUbVdRaWxIZ1ptQ3Ura1RXZW9sMnRUVFpqK3pmUFJWOGpkVnZ3Z1BO?=
 =?utf-8?B?VU1tT1d0QjdXTG80bUlpLzJBNFYydXZXcTJBUTNSRy9wUkhSS3hibGF3dHNI?=
 =?utf-8?B?bGlVRy9LYU1GbnFiMEIxZVZEeVdrVWVKL2c0L3BuQVRoR3lsY3REMEMvM3FK?=
 =?utf-8?B?dDFrd2w4SDRxZ0RpM0RqRTN6eGwvWWQ5a1VML0JNbHFKcTFIelpZT0lZbkV0?=
 =?utf-8?B?NjFxVlJhcUdGcDJFRk9KMU0wTzFiQitoL0w4RHkzNmRBcG9scGc1eFBwakMy?=
 =?utf-8?B?Z2tzMGpSaU5qL21taEpVeVdnUG9rZ3UzS3RUUFU1NE40T2xwanBnQkFQZ2Z3?=
 =?utf-8?Q?EjkWWyIu9KhcjRTSkS68vzSFp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e873a1-d0b4-417c-9bec-08ddf5060bcf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:47:27.6664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +NDWM+M3IKEUN8kgJw1GDWzvyta4gbbi/PXgVgEbwjrFccocH331EVRyUn0PuSRHeXoAbdzsKFjuwojNGo5ijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772


On 9/16/2025 11:58 AM, Arnd Bergmann wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Sep 16, 2025, at 10:39, Patrisious Haddad wrote:
>> On 9/16/2025 2:15 AM, Nathan Chancellor wrote:
>>> External email: Use caution opening links or attachments
>> ifeq ($(ARCH),arm64)
>>           CFLAGS_lib/neon_iowrite64_copy.o += -ffreestanding
>>           CFLAGS_REMOVE_lib/neon_iowrite64_copy.o += -mgeneral-regs-only
>> endif
>>
>> Which is actually equivalent to the diff you sent, Thanks for the
>> heads-up will fix and resend.
>>
> I think it's better to handle this inside of the inline asm itself
> by adding
>
>        ".arch_extension simd;\n\t"
>
> at the start of it.

I don't get it why and how is that better - than using the correct CC 
flags for neon, also are you suggesting this in addition or instead of 
the CC flags fix natan sent above ?

Using the correct CC flags by itself is sufficient and correct - and I 
don't see other neon users using the ".arch_extension simd" you 
mentioned , so why do you think it is needed here ?

and I'm assuming you meant to add it like so? (incase it is really 
needed - I'm still not convinced it is ...)

diff --git 
a/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c 
b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
index 8c07d2040607..cde3d11909a8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c
@@ -6,7 +6,8 @@
  void mlx5_wc_neon_iowrite64_copy(void __iomem *to, const void *from)
  {
         asm volatile
-       ("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
+       (".arch_extension simd;\n\t"
+       "ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]"
         "st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%1]"
         :
         : "r"(from), "r"(to)


Patrisious.

>
>       Arnd

