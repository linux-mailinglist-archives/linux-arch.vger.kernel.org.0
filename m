Return-Path: <linux-arch+bounces-13652-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE02B590ED
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 10:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A60A7A35E5
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 08:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203E0285C9A;
	Tue, 16 Sep 2025 08:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t6uHJztu"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38A2288EE;
	Tue, 16 Sep 2025 08:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011963; cv=fail; b=KezO/nVcMFF8kTGY3TGB5tJP5TJMWs8+09W0ioEL9zbUsNZmSGD8OaloglezRR/5pOwJkPXXQs5zv9OE5+i19b/PO8Yl6ydY+y+lcYwmuW47SRX0cn+C2xIAoOwswP+z3umiGgISY8m+tzY6FBPN2HFiTZMCORMNvfFXaolmSiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011963; c=relaxed/simple;
	bh=N6O/PvCpz3pk+JOQk+NfYOeuifXiZcTzACs1JSGONQw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J6WkPhq0r9yE4zrTgrjSsPemPs0drEaz5X9dgi+RlzC8ikQkflyBFLtueyqbjk8sUI19yf2O+dLPaDkmmpnLHED5pJuYeASo58ObIKh66cVfgYxtACzdiKy12d/ngA01gJFMshwFhBW3MJwVqXvxLyeEyjn7Q9MA5Ah0NlS7bpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t6uHJztu; arc=fail smtp.client-ip=52.101.57.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilZzQOGn21nviF8lq0L7q25p0949xCIzqMx4+DkjZziGzJwTrWxEGooBZaZPeggT2sr3vIOwruHnC636Mz8xaiVi5cu6VmsvTTAlwohMR4/LvnSUoixXx0QJgH0mT+H3IdR2rQ+tziEhRgJA4Hxlpo/tJlnhjG21ernPCz8TvF+i7LbCqIDfqD81Gx/XkRYz4TIDfWzULE27U2Z8bitNtAWars96VIe5FgsmmPd6Lp/ztBNGO46OmPf4Wyg9b4NDrAibaEbH1Ot5wQqI6LYADoV9HicLKNLPFKpr4IHJHcUctdNzfFKFnzlVm8ArxtB8318J3doCUZmcjR81YUE8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa6K1OKn+TYzSATmbDhF0CXXh1nf0B8kIo3ka/CVGSU=;
 b=tSM/7noVRbMqW+GxRo7P/1lx3CH8nFeM/XTfrgZlrRoRqPi3AIXegt4IWeNfx+IYtHjWYZIbo8UEkdlm71ux9I69Suky2QMOU1NjmviymsOQF+gjlYh1Ogc1ZRc5MKk9Aav4scxAqe5vKlAfN6DWStQ7NDZa6BzLSGcGSdIPbcRXBfdm/s0/TH6tiAZOyN8eMmMmwKXGuMWHKPuRmPdX9GahW/rAylayxcPA3wMps10ngnP1/DfFKy4V+UOA32iH/+k4L3RWkuzgfSuN5IrzGvi51F3WLVVI5wXiLXxR48kp7DZDo1Bxklhb2xgrw5Qe58KVyscwl76BkR00GCUO8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa6K1OKn+TYzSATmbDhF0CXXh1nf0B8kIo3ka/CVGSU=;
 b=t6uHJztu90HDdHYwT5i5uwA1pofw+/B8H9fc+YECNFiyJN/BGfSL0IhPyPBZ/H/ockrqTxDg5xo30p8oSq6ZtYAxzO1TLYxT4WmQWwW4O36hGChgaEXMX8faNCDWEWBqAd06eENt77HrxNvCYxcMgSbOQz5/o7Yot8OogP2etmxd38wEGvENfnh61KrEgF50lT/S/wz0vK0gkQpbCpGatn+RCRdZ9y6rBDWe/G0juCbxls7G6nEOzm3jFijedG+4+ycsnweSZW9BB7CkHWZ6R5/hAOjOjJZIzaSUZEhrVD2R52TQMtZSJmjGeUhkHr+MwU55keMPLhvx894k5t4hYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:39:17 +0000
Received: from CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4]) by CH3PR12MB8583.namprd12.prod.outlook.com
 ([fe80::32a8:1b05:3bcf:4e4%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 08:39:17 +0000
Message-ID: <d259ffa9-6c9e-488f-a64f-81025deba75c@nvidia.com>
Date: Tue, 16 Sep 2025 11:39:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
To: Nathan Chancellor <nathan@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Michael Guralnik <michaelgur@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
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
 Yisen Zhuang <yisen.zhuang@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
 Leon Romanovsky <leonro@mellanox.com>, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
 Michael Guralnik <michaelgur@mellanox.com>, patches@lists.linux.dev,
 Niklas Schnelle <schnelle@linux.ibm.com>, Jijie Shao <shaojijie@huawei.com>
References: <1757925308-614943-1-git-send-email-tariqt@nvidia.com>
 <20250915221859.GB925462@ax162> <20250915222758.GC925462@ax162>
 <20250915224810.GM1024672@nvidia.com> <20250915231506.GA973819@ax162>
Content-Language: en-US
From: Patrisious Haddad <phaddad@nvidia.com>
In-Reply-To: <20250915231506.GA973819@ax162>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To CH3PR12MB8583.namprd12.prod.outlook.com (2603:10b6:610:15f::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8583:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fe3cdc-510c-4922-eab3-08ddf4fc85c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VktTcjZ6cGNpeHRWOGZLcFJZYlB0c1ZVdEtDY05JYVYvWGFVSEVTdVhxb0NX?=
 =?utf-8?B?aXlhblFndTNnT0FxaTJvVHJ3NDQ1N2FqemN3U2dFazVyM1BCL3hiTUNMLzJC?=
 =?utf-8?B?cmR3SVUvUzE2SHhQb2xRSWpkdUMzUG5MVkd4NVpWdlpNVXhLOTBYVENXdzRZ?=
 =?utf-8?B?SzNEQ1k5UjAxZStvWXl3Ri9kcTg4ZlVTc2tlK2JlbXJhbW93VHFOUWlyQjVZ?=
 =?utf-8?B?OHJ1OWR4VjExSDU0NjNScEFYMkdtVHA2UjdKZ3pEM05mK0tzTlVsd1M5NHVP?=
 =?utf-8?B?c0doek5yWnhxVW1NWEE5SDl3bWRaYnh4ZFBrdG1iTFlCcyttcVd4SDdlb1Nw?=
 =?utf-8?B?UFIzRGFVOTZiMzdYbnhSN2pnS3dzbDNKK1RrNE5iUUhtdDBmS2NlQ2dCYmNS?=
 =?utf-8?B?dkt3eFhqR1l0VXRVLzFQMDRNQ1Zycm5Cb2ppa1hRaTlSRTdlVlNmV2Nqa0Zy?=
 =?utf-8?B?cjVrMkFWeitQNER1b1QwTGJHaE01cVhJZ0w2MFJkUHEvUjUyMzdqS1VmeGhK?=
 =?utf-8?B?VCtsR2xlTTcxck5GV2w2L1NWcjNOY2dJVDZzU0psL2hWR0c2NFplNEo4WmJX?=
 =?utf-8?B?Zkc2V2JObE41QkxGYkNWNjZBb0E2TThJTUxXSEFpRzJnZ2tpWXo2Uno4a1ZM?=
 =?utf-8?B?UURRaG1YODZpSHRTa1ZwMDJPUVhtZmx1bHBpMG1USnlRZ3hCRGttcnBhdWpH?=
 =?utf-8?B?VHpCTEpBTXZESWxNWEIwVUhXYStmSTU1Yms2T2dIMjFNbW9LR2ZXYVFwdDhC?=
 =?utf-8?B?WTJOUE84eml1cFFORGJQb1I2L3RUR09SRGlwc0ZBaU80QUlUdUQ5Z3FYdW9l?=
 =?utf-8?B?MEE4ZjlBRkpzWG1odUY0dWxrVGxTcWwyMzQxK3FWQ3VXRE96UzMzOSswU200?=
 =?utf-8?B?S1NOTUZHZmkzMUN4ZHU4NDRIWHlsY3Z5SFNTUzdHaVJiZkFVZGNjeUhJZDNC?=
 =?utf-8?B?SEhOS3N6WEZNVldjNi9NaUljUVhSTTZ2dis4TlhrRFg1bTJDcTJYVjBrdzZw?=
 =?utf-8?B?Zlp1cTFNa3RRM2wxNmM5dncwTjBvYi91UXF5VWxlbXBadDR2MjAwWjN2SVlB?=
 =?utf-8?B?aXZrK3ZoS2JqblJHaTBFdzB2OEpIZzBSN2poSlY1M3hvUEJ0NUpnT3grajJC?=
 =?utf-8?B?bGcvUjVoSVFMNVlIRFNaQ3hiWitPd2FkSVhldE1FVGJhMWxLczVlWnVkcVRF?=
 =?utf-8?B?SU01RWdDWDJpRVZZZmpTQlVXQkRIU2U4MDM1a2tqdXdLZHZ6bi9CazluK0pB?=
 =?utf-8?B?Qys4dzdmZEpWN0Y5Nm1KL0tQZlB4bWNYdHl5d2MyZUFZN1RkYlJGb2dlRzhm?=
 =?utf-8?B?cWZVM0lKSnZnNUUrRUIxSXB0MTBmclpQRTdSd0QrSm1JT1pkWS83UjNYQnJv?=
 =?utf-8?B?MlpoNElkTW53d0pjMVRuelI1RjNMMmlIck9QVGJ5UGZEaTNqc3llOHNpb2dX?=
 =?utf-8?B?RTFHZ25VR1ZMekZoRW03VGRXbEw3bU9tUVhjRlpWdllpdWM0cnlNbkhyZ1Mw?=
 =?utf-8?B?TW1NckxNaGZNZTUyckVvQ05nOGVOek96OU11YTZMSFFWb3NmSUJnRzhNY3Nn?=
 =?utf-8?B?TGVjZHprNm5QektEK1JhK3A5QXZRa1NYLzJIeTcrUVc4MWJZbndrb21JalZX?=
 =?utf-8?B?cmttTVVNQjhXeDhmdnBRTEppaVh2Rkk1ZXlKM0FFcUw0bjY4ZFFnd1E2U3NE?=
 =?utf-8?B?R1hOcitjVDE0UU1YTExuYmo2dVpJSFkvNE92eFZGZ2dBU2ZQVkxPVmxuazRQ?=
 =?utf-8?B?MlVKRWRjN1FReXlsN1lnUW11MThXYm8xeWF3ZVlqR1hiWG9pWGdXendYNGRZ?=
 =?utf-8?B?eVc2dFZiWjVieHZjWDdUK3hZdHdSQ05HQjZoMTMvQ0xKRlo5d0dtT3BONk1x?=
 =?utf-8?B?NjdQZzRaZFp4U0pNZnpwVlI1VU5LNnozZkhFaXV0MnA2QXI3SHdZUFZlS1hS?=
 =?utf-8?Q?DXar3oqeYDA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3EydzVJL2hzaG1Tci80SjcySDI2Nko0ZkdEYWZBQmVSb2krV2JVcXRwdG5T?=
 =?utf-8?B?WEQzOWdNOG5TbjI1L1RKU1V4TTEyWmVjTk5mZ3RMSXJUY09lMzhqVnVadkg4?=
 =?utf-8?B?OGdmZmNHZHJvU1d1V1BRTHRkeDZCMnJ4WHZTM2dSREVEMlhBclp1NDhORHZx?=
 =?utf-8?B?aW9KaDY4UWc4ZnlWYVp3Vm5TTGhKang1WHAvVWh4ZUoyUHROWmJrMFdIbTNj?=
 =?utf-8?B?Rmh1cEJWbVFLTmI3K3QvbjZxajRwQnVHMlhIQ2hjUFhjUXFubE1ZcFcwWkRF?=
 =?utf-8?B?ZzcvV1dqd2dCTi9mWU9DNitOREd2V1hjZ3krMGpKMjhQdjlCRGUxRmlHQkh0?=
 =?utf-8?B?WnBhamNPOVMzNWVTWTM0c0ZXcldVUEVoc0lwbTAvZW1TN2NCaWJWL21uWXRr?=
 =?utf-8?B?Wi9URWVKbnY5N3g2TmdXWTdFbWZ0V00wdFBMM210L0g5MG1oMlhUNUxOVWlH?=
 =?utf-8?B?cXhaZXlNYVhSMkFpMHo1cjhpZG1FOTBRVVIrS3l5ZklqTXFWdFJoc1pUWlkr?=
 =?utf-8?B?Yjh0aVBrQ05Bc1VyNUVTTURWVGc1UDY0ZE5iUStoOUcwalBiNDRVZlZSVFow?=
 =?utf-8?B?WWxOYlF4VG9ycVYyemVVc3EwdCtZNGtVMjkwT1czUGdqaENEeUF1VDlnd0FK?=
 =?utf-8?B?R2ExdFVpQlEwdGdSR2Vwc0FsYlltcy95NDZxN3ZEVFdOWitHaytyb0ZkWitv?=
 =?utf-8?B?RG1aaE9ZbGxVMDRjVnhvT1pmakJXVWJGODV5L0tLaEVFQ1A2VllxbFVZZ25w?=
 =?utf-8?B?UURJazQxend0dXpNQjBEYlUvVDE4Z0NvdlVSY29wZHp4MzN2eUJxVkNaOE52?=
 =?utf-8?B?U3lyZkJTKzRqQ0cwcmF0dnhjSTVVNTVZWGxac2V3dGlOaGZrN3EyUFBIcVdS?=
 =?utf-8?B?aDVnWm1EZmN6T2RNcElNK3VxV08xN2J1RVhkOWZxS3NKN0lTaWFpUVRnMXBD?=
 =?utf-8?B?VWlISzgzdWZYemhvWlFRcWJCU3JSV2JhUmFtUVdjdVFxSlZVZnB5b09uSE1t?=
 =?utf-8?B?bHdIT3I2b25VNTU0MGx0WVNGbEZGdXdIT0t2MU84ejQzdjFRQ01FTW5lcWMv?=
 =?utf-8?B?Yk45a2hIdFI4blZLckhOdFRGNlBSMysxZ0JKSzQwV1ZJMkVDQzFncG8zZlo1?=
 =?utf-8?B?V1JMSkwycjN2UXI2QjNsQjJRWUZNWk4xVE1Bc0Zsd1JQY0U4WjRIbG5nSkEz?=
 =?utf-8?B?VktDY3VJbDI5ZjJSZzc0SjVDUTArN1FHb0wwcXVmSVRpTTdGdkpnSk5UTk5U?=
 =?utf-8?B?Ylk3bS9RemkvOHpVSmJjeXAvZmt2ZWZWd3V3MTF2T1k1Rk1wR0E3ZldWejRF?=
 =?utf-8?B?UnFFNjlSM0tiRE1BRHNIdGV0RG9OWWJhZHdMTGhNQll2Zlk3UW0rRjI1MGdD?=
 =?utf-8?B?ZCs4MzlQS05YelRjT0NhMUsyNCt2UUlNRURqRktkVkd3bmV4djBBUS9zZytM?=
 =?utf-8?B?SElhalRxaitmMDlWTzY5T0VqOUkvR0dkS1BnYkd5TVFHeFhMbktlcEZ4WDNE?=
 =?utf-8?B?QXNMSThiMVBkVC9VV1dDTkpZME9sRFlicWpsYXRhaEw0NjNwSmVnU2VlOWlQ?=
 =?utf-8?B?YWxjdm52NjFIc2dDU016am1SQ1UzODNVbkxJOTY5NnVrN0NWaGpxYlhpTVh2?=
 =?utf-8?B?Qkl3NG5YVVhKVEtBbXpVaGFTbGk4dWpUQnk1VXlqbENDbHd4b3lEV01WQXR1?=
 =?utf-8?B?b0kyc0lFSDNpdGx5UUV5bExMcHM5S2hXWGFKb29HaTlnMlloWE9mU0lGYkR5?=
 =?utf-8?B?cmRpbFpjd1BTWVBXdWlFNmprOUR1UXpUMjNLS0hpZUZvWk45MjJnWGx1dVVW?=
 =?utf-8?B?RTBYazZzeXJRdlZrN3oyWUFMUWpSOWZ3YWtVOWJTZjdub25aWThJazUybEkz?=
 =?utf-8?B?b2JRZnlYdWp0UFBhbUNxY2xzNEF6NStrcnhyNjdYQmtadUh2VEN4QXk1bnZi?=
 =?utf-8?B?ZUxPaTBSdVM5YVIwMFl4UVNlQ1NaVkt3TG1nQ1lySWV4cTZEM2tTUVBMMXJi?=
 =?utf-8?B?Y1Q1ZjhqVzMrdWxDOWlOUXJnc1BSQW1QblF3WlZQNEN3QmtyWmx5V2xWbmZH?=
 =?utf-8?B?L2IzRGpZaENuOWFhY2g1SHc4TGJvS215cy9ib2JHNHRiNCtxRG1lMXU2bXVP?=
 =?utf-8?Q?1SFCvxijF66QEIcyUM/5f1nHJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fe3cdc-510c-4922-eab3-08ddf4fc85c5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:39:17.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TRc7adfViRoc0c76DPfXkl08MWZpIu8uBeCCxWSdCGTCrKr8TkWuihE1W4I6/xz2ohYsG+yoXbvuHGQ/XoAUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769


On 9/16/2025 2:15 AM, Nathan Chancellor wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Sep 15, 2025 at 07:48:10PM -0300, Jason Gunthorpe wrote:
>> On Mon, Sep 15, 2025 at 03:27:58PM -0700, Nathan Chancellor wrote:
>>> On Mon, Sep 15, 2025 at 03:18:59PM -0700, Nathan Chancellor wrote:
>>>> On Mon, Sep 15, 2025 at 11:35:08AM +0300, Tariq Toukan wrote:
>>>> ...
>>>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>> index d77696f46eb5..06d0eb190816 100644
>>>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
>>>>> @@ -176,3 +176,9 @@ mlx5_core-$(CONFIG_PCIE_TPH) += lib/st.o
>>>>>
>>>>>   obj-$(CONFIG_MLX5_DPLL) += mlx5_dpll.o
>>>>>   mlx5_dpll-y := dpll.o
>>>>> +
>>>>> +#
>>>>> +# NEON WC specific for mlx5
>>>>> +#
>>>>> +mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
>>>>> +FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
>>>> Does this work as is? I think this needs to be CFLAGS instead of FLAGS
>>>> but I did not test to verify.
>>> Also, Documentation/core-api/floating-point.rst states that code should
>>> also use CFLAGS_REMOVE_ for CC_FLAGS_NO_FPU as well as adding
>>> CC_FLAGS_FPU.
>>>
>>>    CFLAGS_REMOVE_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_NO_FPU)
>> I wondered if you needed the seperate compilation unit at all since it
>> it all done with inline assembly.. Since the makefile seems to have a
>> typo, it suggests you don't need the compilation unit and it could
>> just be a little inline protected by CONFIG_KERNEL_MODE_NEON.

There is difference between what actually compiles and the effect of 
these flags on actual performance/assembly translation. To avoid finding 
that the hard way I prefer to stick to their documentation which does as 
Natan described below,

a separate compilation unit between begin and end and the correct flags 
- and eventually that was what I tested , I missed to re-test this post 
finishing my code review - thinking my changes were only cosmetic ...

> Hmmm, clang rejects the current patch
>
>    drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c:9:3: error: instruction requires: neon
>        9 |         ("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
>          |          ^
>    <inline asm>:1:2: note: instantiated into assembly here
>        1 |         ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x19]
>          |         ^
>    drivers/net/ethernet/mellanox/mlx5/core/lib/wc_neon_iowrite64_copy.c:9:48: error: instruction requires: neon
>        9 |         ("ld1 {v0.16b, v1.16b, v2.16b, v3.16b}, [%0]\n\t"
>          |                                                       ^
>    <inline asm>:2:2: note: instantiated into assembly here
>        2 |         st1 {v0.16b, v1.16b, v2.16b, v3.16b}, [x20]
>          |         ^
>
> while GCC accepts it... It looks like GCC's -mgeneral-regs-only only
> impacts the compiler using floating-point and SIMD registers after [1]
> in GCC 6.x, whereas clang's restriction is on both the compiler and
> assembler. Perhaps clang should be adjusted to match but its behavior
> seems more desirable for the kernel to ensure floating-point code is
> properly separated and called between kernel_fpu_{begin,end}(). This
> error is resolved with the following diff.
>
> [1]: https://gcc.gnu.org/cgit/gcc/commit/?id=7d9425d46b58e69667300331aa55ebddddcceaeb
>
> Cheers,
> Nathan
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> index 06d0eb190816..a85fc21419d8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
> @@ -181,4 +181,5 @@ mlx5_dpll-y :=      dpll.o
>   # NEON WC specific for mlx5
>   #
>   mlx5_core-$(CONFIG_KERNEL_MODE_NEON) += lib/wc_neon_iowrite64_copy.o
> -FLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
> +CFLAGS_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_FPU)
> +CFLAGS_REMOVE_lib/wc_neon_iowrite64_copy.o += $(CC_FLAGS_NO_FPU)

You are spot on, I checked my patchset and the actual tested code 
(performance wise) beyond compilation used the following code:

ifeq ($(ARCH),arm64)
         CFLAGS_lib/neon_iowrite64_copy.o += -ffreestanding
         CFLAGS_REMOVE_lib/neon_iowrite64_copy.o += -mgeneral-regs-only
endif

Which is actually equivalent to the diff you sent, Thanks for the 
heads-up will fix and resend.

Thanks, Patrisious.



