Return-Path: <linux-arch+bounces-13658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D282EB5972C
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA86C320C2E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C7311C3D;
	Tue, 16 Sep 2025 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YbYqAM3b"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010025.outbound.protection.outlook.com [52.101.56.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EB223DCE;
	Tue, 16 Sep 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028409; cv=fail; b=Cn48+fO4XAxPzW7Jys3Pze74fIUrFLGG8KEDnWB6vBegwJxVlKhVrLYIzfKeBw5Cm62u+2MCpyN65i+kMIfI0FqVrCa8y71OTtX9p2F51qAuxYck169PXIq6fUFREFGKzBd+XX/W61+tnyDt5/uW1qwYUwpB0D6GrnmFMR/Emoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028409; c=relaxed/simple;
	bh=ozV4RpErbYQF4Wf+xvGhwbP3RboGvaR9ChCP4q3er60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ViPBtlCz+/cvGz9hjfxj7LJxaXkh4/NQPmKw6SzTHHs55Wx1u/XrZ5itveHheoESJx/Q+xBiuyaIarwetwF0gZUKz7d4CBzlHJcNwSD1SlvWt+F2/e+nUPt3F4ESfzTckxhti1uVAkt68IICtOV6DwOFhXKPK81V2IoXTtMJ/RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YbYqAM3b; arc=fail smtp.client-ip=52.101.56.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6A3oDrx9yKCYvIN9L2rB9YRS6IzWITLckuOD4QB/d5FsW5wWt4Rztiu3CL/H3n+dLRWku16gaooHHjhvidThbDIU+gTkyBOpezCsJIhaueiZb/MCgsmnhKgCtdeJVYpuMYqqToxuhJAoD4NttX4bDhgTRSRTmHpoW4zIzIq+jml4UFbvznniIIbMup0M47FTae9B1cNgf/UcNIpjkK0oLw7XMwZ0dH5j1VoxV5yy4x1pPj9yGLY0QYG2wsbtJmDtlg21ag81XT/pn/A+/JvDwYLy2ENmNUtmS4NrVZxin3RJNczpS1FzlCaZ8gn1PI7mTEi6JSl+RnpoU5q6I61IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWmrfRYCwAkAqt7Jxrz9ylwdDFp2hK37Sh+Xi/1VYrc=;
 b=u/krC0VCQCRQhj9Rktjt0q63yhMXkDKTHp90ujNUfbi4u3LRLFmLyRGiXU/9eZ8O5ceNbS5sOnv9nQD9NvHz4szpU/fdRBkvp2OSRyYKoQKEbbDbLpQ1oKn1yCF1hHBV/GZ5IxgF807LVl3vVy0Hfu9g4qk2PjLgI1Hd3rCCfVwfWAmWnMCNk2wD1rAhyPWZaWnau493Jfe0kzlHH4nHBGg7gGDboq7FxrdW0d7X0Nz3UK9zGSaKnR/TdPIJVzF332MKHbWKFEo7cc+phz6f4Z2RHBEn8mLwmPb+n+0IhaVTg10ev+vBnU9FEELg0moCo/Op/RFVXOmzKQQmUeLYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWmrfRYCwAkAqt7Jxrz9ylwdDFp2hK37Sh+Xi/1VYrc=;
 b=YbYqAM3bHhEpYAz2L9rsqNBVyvv6SzmZHjorPANmVj8bwN/YvnL9ZQ72Ltjno5meKuWlJYJqc7NlrEljaljBVFMWw+5H+3R5oU/F01FK34EASeKFUL3a2ceirTLz0MlGV+Ym0gmh0w3nJB+UyvSSs7cILO48bWn6PiRr/Qw7l8b2iD8HvFW9fiVSGcaBuJLUbo9X63GubqnP27CIMCm7QrKihoJbgxHJsfptltgXXzHEdnXCqtfeoJr5B7bZXziWInbwNUVHx0/ZKTm+LUJQOYwgkSyCVSkCSFN05GMrerxYDhgu86lEyvuqBofXX6+mFs1vX4pyCeORtax2G9B26w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 13:13:24 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 13:13:23 +0000
Message-ID: <cc0a6c0f-9aa3-45a5-bcd0-9c02e1b21a8f@nvidia.com>
Date: Tue, 16 Sep 2025 16:13:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
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
 <0c61ff65-fdc7-43a3-a62b-75e0d76b95fd@nvidia.com>
 <20250916122715.GA1086830@nvidia.com>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20250916122715.GA1086830@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To CH3PR12MB8583.namprd12.prod.outlook.com
 (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e7dbb5-03d4-4c98-a72c-08ddf522d05b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGU3dFNEOTZNdnYxbVc2TkNIY3hlL0FWKzZSdVJXN1M2NG9jOFVXUHB2V2lP?=
 =?utf-8?B?TFhyV2oxVHVHdFU0R0dTbTBzSUw3NG1mWHJLWSs4bHhkQmZYM21DL3ZaaU1E?=
 =?utf-8?B?OEw4OTkxRVc2QUVYUnhOMVRoclhZV2pBVTd2UW5uWU9hdG9lbCtrU0xUWmJR?=
 =?utf-8?B?S09xa0tkelJ3dWo3T1BpNmFJREdFWW05T0J6QlU3R2J2bTRBMmVUaXZWWDMy?=
 =?utf-8?B?cDR0K1l5Vllub0poMTRtbGxpKytIUnA3U0pnVWhDVktLQk9ucFBUR3Ayb0xs?=
 =?utf-8?B?ZWRtYWN3cWpmTnFUUGZ6ZS83SGZiYUNOVmxJNk4zL3JDajlsQTRicVh0bk8z?=
 =?utf-8?B?ZnFETGtkTk5vVGtVaVVMMDA2TDhSWENFN0NGQm5nVXBTUnl3RFNvcjhXQ00y?=
 =?utf-8?B?NVBjSHAxRTFpMElhTFJyQStyK3NqSHJneFptYnhhUmZRK3pkTXdPM213NXZm?=
 =?utf-8?B?RFpGbjkzNTlxQlFYT0FJWC9QSzRPU2tsczRxTW4zekl3OG11enVPRHdPdnBR?=
 =?utf-8?B?Mk9xQldhL3IwWW51U3dQeWNyTU5KNU12NTFDU3QvNm8yeFJwVk1IZG95SytD?=
 =?utf-8?B?K3BJaUN6VUltcEU4UzV4WWYwbkdGYjBrU0pTUFMxZytZeUl6YXhYRHlmY1N6?=
 =?utf-8?B?dCtsVW0yMTgxVkt3U3dqK0JzeWROQzdqdEpYdnh0ZlZqNzhNNGpLcU5LOWM2?=
 =?utf-8?B?ZlNqZ0VWNHhzMC9OUnh6dndHRlVKRGlXYUVOU1l2eG9pbVQ3U0gybVNtRHFN?=
 =?utf-8?B?N2I1YldnU1duUEJzTUFpTVp1UUZyNWRvMmxhUXVvaXRVaE8xc3BaZ09DNExa?=
 =?utf-8?B?S0ptUUptaDBDRkpKb0ZzYllTYnZoWFhpK3Bwc2RUMHI4VjRUcHJaMU9ONC83?=
 =?utf-8?B?QXU2d2tReUhFSWNMWTlLeXBWaExaU1Zpb05ha2pTMGE3UWU1U0FLZE9JWldk?=
 =?utf-8?B?VC91NWZlSmFBazg3c014b1g2eUFLcnZWdml1anhMZVhtOTJvNjVhK1NEbHFW?=
 =?utf-8?B?WUxxenEvUFMrdkF5MTgxVlF5L3U1WlBBbmkyTnc3MDZmTVJqd0FtdExUQ1dx?=
 =?utf-8?B?YVVYUmd4NVRsdjdBUmJhbGtCUEVXZHdvY1FvQzh4dHdZb3paQytGbkNZRkxB?=
 =?utf-8?B?Z2EzOHN0bmIxRExvYTNjSVYwaS9CeXJwcXRsQ3laUEd2ZzlNYnZsZ3lVeGxB?=
 =?utf-8?B?SEN0TGRqaWV5cldVOHNKMEFsWnpwY0FXcmRsWlB6UC9Xdm9NSU1SZkI5OEN0?=
 =?utf-8?B?bkI0dGI1eWlwMEFwQTV3dTI3RG9ldE0yYkZBMVhtTzd3QWdBN2lMQTRlUG1v?=
 =?utf-8?B?RFgrWWkwUmVLTTlaUHljdlpYQ1J2VlJQdnpJMmcxbk9RZlJROTliMitrKzE0?=
 =?utf-8?B?UjNPZ3dtNll5SzAzVk9FcDROaFFIc1BLQmhjS2UwNkVBTXArM2s3VUdTSXdQ?=
 =?utf-8?B?RDRSakN5cmsvV2FVYkc0eWR2WVlpZVFjYXlOcDJsZ1hIL2JCekN3L0F3empu?=
 =?utf-8?B?NXNvTGgzeUREbGE5Sy9tRmhqVWVOeU1aajJ4T2k2Q1ZsSEo4bm5OUFRwbmQ2?=
 =?utf-8?B?OEdLY24raXJDbkRSZUR6T1FYU1BUY0Q1ekZPbnhqbjlVWXBRRXJGaXFPcDNC?=
 =?utf-8?B?V3VCSjNZVmpBR29XZ0NJL0c4Wm0rQ1c5bWRVQm1lQXI5a0haeUF6LzR6YkhQ?=
 =?utf-8?B?L2wzTzBkcmMxaU9KRUJiSGxlRkJDakZwK2xocTlZRmZsS0paMTdFanpZczZ2?=
 =?utf-8?B?MFFRQnA0S1ltdnl3Z2hEaUtGQjI0L0NEbkhWOHV4SmxRMGhqV1N3eXNYUzRa?=
 =?utf-8?B?cVE0dS9zRWtqMVZHRno3V2xETEMxMktoZktyMVVTc0RaM3Y4cjJKNm5pSWxM?=
 =?utf-8?B?bXdCQ3V1eXkrKzFQUFJyOEVaN0loc1hHTERpMXNwVHJJRVBlaWNxbGdJQ2Zk?=
 =?utf-8?Q?f67tOlfrqD0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djhCRWtmV0VNSUYxQnhLbW9rQUw1cmQ3a2YvenJvNFphaVJyOTlBWGw4UHpu?=
 =?utf-8?B?VXU3djlvMHJtdkFrT3NPTWwvK1IwV2ZaNU1TVklDTS9aT2NMZEx6dlV0ZUJn?=
 =?utf-8?B?TGJBTktmZkFWS0h2eVArdERHL0RTanhKT2h5bEdldEhuaWFmVDg4ZkJMekV2?=
 =?utf-8?B?T2llSk9hRXNjWUlLTWpxUUtPb25wb0tRV3BiUm1WNjQ0WUthVlVhYWxLNFp1?=
 =?utf-8?B?MHREOEhYOHdqZFMzSGsra3NyNEZFQm5laXdqdUZ5c0V6R0trRWJLMFpWUFoy?=
 =?utf-8?B?Zzhvbzg2MFJKSkwxWGNRY09sbTFwTS82Q2l5V2NEV2VJRVhPbllLMzJZRHpM?=
 =?utf-8?B?ZlZnZEkyREZ0dlJEdmVqR1lWRTMvTzhWUnc2QUNRQ3lQU0Rvb2lvMzNZYlJv?=
 =?utf-8?B?ZTRHa2txT3VuV2NZL1lQRDdDS0RmTExtWmlJMjhTc3NKNWNnYmNmbWorT04x?=
 =?utf-8?B?ZWVwR1pTSnNzRXc2cUU2eVIzTzhhTmxVdlQ0MlJHeVg2bWJ5cWk0ZzRxT3VX?=
 =?utf-8?B?emVYcFh6K3paMDVmUjJRU0N6ZnVUeUU0RzhvcUZsSnhtbktENDZiVjBCK0N1?=
 =?utf-8?B?UE9zN0hiYTljeUJMelNKdFRaRGpHV1FsZjMvWE5HSGRBSFRlMkJKdlZXdGdq?=
 =?utf-8?B?N1ArZ1JjS1BMMjNENlhuV3MrNW13Nmp5b1d4YjIwak9uZ3BQUjVwUEVVT0th?=
 =?utf-8?B?bGl3WjVlVkhKZy9GTllxSFB1MWFJWXU3S2hjOXkrN092ck9JdzhZUFVlcElH?=
 =?utf-8?B?M1IrV0V3YUpValpZaGF5Z3l4RkdBQTZsNkRxaWwybGUydCs2TzRwcmpxeksz?=
 =?utf-8?B?a0NTTC9LL00rZndaaDQvSlZLclpnOXNlcUV5RnBaWXNST0xROTlsT082TFE4?=
 =?utf-8?B?ajJ3dFk2TkxHaDF1REhkakRwU2Nub1BTQStHYWxGK3hFZDloQlFaeFBQM2p2?=
 =?utf-8?B?dDBMenVSaUUrWngzQi9VTGZVZmhpWVZMaUkvQ29NMmYvYnpOT1hzaVhBQXdk?=
 =?utf-8?B?eFo5V29JTDFBRTJIVHlldUdpYVlWSUpTZnpQRUdyMmJPL3NXOTljZWJMZDhn?=
 =?utf-8?B?V0tDNkp5czZ5S1Bsd3JIZkJrc005aUxVa0U1K1d3MXpHQmRRT1JnZlRzMmd2?=
 =?utf-8?B?TFZLWkhFZm1BMmEzckpmdVRpRm51MFRrN01LTHVyZHVHRVJGbjU3cWFraCtV?=
 =?utf-8?B?Y052RUtPWmVXVzQrOGpOc3EzbWkwdDhPTW5SWmptQzM2RXMrb0d3d3E1VDcz?=
 =?utf-8?B?NEl2bm92eUdoa0hYc01yenU1RUQ0M05YNng3SGN0dnlhVmFjUDBodXY0K3U5?=
 =?utf-8?B?aXFhZ0kvN0tjRWdLZC9SUzk1SThNWitJbFhvY0NzaHVrUEtzd3dKdnBmU1BR?=
 =?utf-8?B?OWRjb1lCcVZTNWFmSFFBV0VkNEVHTTkwSzE5bWkzaEdtQVFPcTN3NENNWEdV?=
 =?utf-8?B?VERwMHBDOUtDZzVuek1STVVZOVJLUEtzU1haNnFNRzJLak53V21vbzE5c1Q5?=
 =?utf-8?B?dk1LeUNtZlBNaXdqRSthN3ZKNXNpeTJ0b3d0TlhJUkJsSndKTHl4MVd3VUNR?=
 =?utf-8?B?Y2JvYzE0bmxodHY4QWg0eHgwaXZBMk9ORHdpU1dGUWk1WUhLWFgvcFZpS0Fn?=
 =?utf-8?B?Y3RBSGc2bkx4RmhjMWVJZ0hEZEswdEFwNUgzV1l4VWxNQUpFR2VGQWduR3FU?=
 =?utf-8?B?ZVJ1YzZrQmhRWXpMS3phYlROUktTQmdEeUFsaDliVHJLZGt4d1pBYTFZcHBn?=
 =?utf-8?B?aFpXbDBaVEVjaHhMTjZob2UrdXhKeXduK1lBUllycERKVEFLbDhMZVVNK1hY?=
 =?utf-8?B?c3o4L0d2ZnBmZGdZU3NUeFd5eEd3Njh4SmZtZFZMOS8xbEV5LzRIMWhaR29N?=
 =?utf-8?B?VDdGQlBSM2lzMmxMaTdJazJ3bzBTSnlJUmJrZkIrbTRPSzRJazRwcko2aFhG?=
 =?utf-8?B?SDhPaU1ZdFJGSjNRbkZROUNKZXFva2RZYnU4YTdOYUMvTzdZWlhyZ25PYzV1?=
 =?utf-8?B?b0dWUXYvNHkwUjFWNVJxSi9OOWVRVWh5WDFmTkd2cHJzV3oycXBNSFZ6d0Vy?=
 =?utf-8?B?SWhUcnZGREk5aHF3TFZVUjZTNFRjRjBBWk1PYlo4VU9JSnhldDFxVGlJU1Bl?=
 =?utf-8?Q?J8enAPtZ3ZKR56WO2WuGRLh3C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e7dbb5-03d4-4c98-a72c-08ddf522d05b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:13:23.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJD+ontKMvxnPsrM7lwWR1lzrffeP6/S6qgKMQG5Jiy/nKDTNc9VXsSeyWC57CnBod3/ju7vxZRdlTmXWCJzqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223


On 9/16/2025 3:27 PM, Jason Gunthorpe wrote:
> On Tue, Sep 16, 2025 at 12:47:17PM +0300, Patrisious Haddad wrote:
>
>> Using the correct CC flags by itself is sufficient and correct - and I don't
>> see other neon users using the ".arch_extension simd" you mentioned , so why
>> do you think it is needed here ?
> If you do it as Arnd suggests then we don't need a another file,
> makefile changes and so on. You can just drop a 5 line inline right
> before it is used.
I see, thanks for clarifying that, will try it and test it locally, if 
that does work , and gives identical results then indeed that it is way 
better/cleaner, will send V3 as such after testing.
Patrisious.
>
> Jason

