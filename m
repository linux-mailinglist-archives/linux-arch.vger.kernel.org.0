Return-Path: <linux-arch+bounces-14445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC90FC26D0A
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490761A228F2
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 19:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B547313E1B;
	Fri, 31 Oct 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rTJxzGQf"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020101.outbound.protection.outlook.com [52.101.189.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016C274B42;
	Fri, 31 Oct 2025 19:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761940008; cv=fail; b=lzgzcuXCLtmjkCvMJALlTKQyM5V93hfg82/EajgaB9P+ZHVW+5owM5maCdMNOj4zG2sluhhLH/7/NNDOCJQtay4FG8Kku2/LJMywjJO+zEFE2Cg3idLRzpHPCeTHy+6L8PoYNRd8lcFKBRreSG2IXI7kai24uJTZLxBPMkS0UOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761940008; c=relaxed/simple;
	bh=/xEKKGaGXXRHMZRXjd1AMSIBgJqRx3HZdqp+WZrGqI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EE3vp2lqrGh9OjEb+aXUZhCpPP37SCIlNPTlonBCjVUvKkXm9XYmgs9FeeCy5ID2vq/iwYy38XHlUAG4jP6T45cvezo1ZWX/uaUgGIyRa5X2Q5mUkWxK9J2Xx9Ocs0ioQlejTC3U0YZ38X5AzM+nfo1nflWtaoOUu3h74G3MLbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rTJxzGQf; arc=fail smtp.client-ip=52.101.189.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYXK5lQLJUH+hfxqMwd2CMfOdX3Ap59vxC9A64yPU4+EJ1wj3ikaCo2UEbeSdtW+ZAJid//+RKYUjfYJ6ZGLngGLTXR5D7FYThDxlOlIWrXnqqqJz9fB0OErATQiON07M9ccmoOmb6tdHRXYWM5e0wWEpEAcSl/oze8Fj2pAYU+nybhyYNAb7rIJYJJLdV6xMSvjmKtrGPlq6FpEREQgrfcP3UpF+7+WVJ6CHZDkiY/l4at2G2ijCi5An9oEogHuv1V/JEoqD0L0Jqb1qgbaXcWCnvpzBVEv4yhaWZi4yafXCXxtsHwyOdL+m8y1V1Ze9tbEtRma8zijRuNoZA1ULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DK7lVRcKFmb++CXS0P3JeSMQ0486DOe06dmdde6F7g=;
 b=nzQ9klf18BHxy46+tM2cFQ72U2tCpU6ppuKvQ/FmLWt2ESPZNMlACZiHz8MnTmTw2OZTEEgmJWfRUNcyqdd3iA/9mODIlatGf4TysQ4WfWZx6HywcvV6lUOiLzCY26l3LQwKmAqjlo9Wki5RWDxnFY77LDngGeuuBSq7lanqCfc1phBkpDjsuUIYw13dyJf2JKqMDiqt6w0NlkMfQdzGz836EUuUHTaiRcGDc6L+xiD4oRea0xOiUvDmMWohyYVXU5v5NifHC1Rre0rG1ty+F+p6etLZqVvNLa9+fa624GAJ3RuDapShsFcTBKMuAaef34cz+LuD20Uh/JkemBmiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DK7lVRcKFmb++CXS0P3JeSMQ0486DOe06dmdde6F7g=;
 b=rTJxzGQfj+VTrkLh9rjeSocO0naXZYWulvFA5+j0pQbtx5ciYdif/XnDcPzdERonRRneWdUXdYn0rb+ZtuHiqCkYe1WX4HkJ/JBmKF4FNPbu+O8KqM/fXBOBhlZpShwBE8YFe6/a1z5xY396LB2F1h7LnFy9CH9xYrRgzKqNNjkglzZndAGvOfvaoWrK0FYjob4RjLH6CcH+ttLfNHMErRsCCPmcVTNawjTEgMKV/e2AYE94P921VAlU7cUbv9SBg/d+uKELOcQrm0lGis1vX8Q3R+l4yRiv8SCCbTe2VRTnb9e0Cde+LzxQ0dz3Ge36CC82EsbBWeKFvFzrwxD+xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9612.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:46:43 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:46:43 +0000
Message-ID: <8a06928e-7bdc-4b46-a4be-63032843ea6e@efficios.com>
Date: Fri, 31 Oct 2025 15:46:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 06/12] rseq: Implement sys_rseq_slice_yield()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.796935865@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.796935865@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::13) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf1788e-8968-41ee-f7a3-08de18b637ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S29DbFJFM3U5aFcwTzZrdFRiN2p3VE9tTHRxRytOdThaTVlSei96bjE5NWo1?=
 =?utf-8?B?K2lnelpUS2Z1SmNlaFFLV0R5MEcxZ3BLdmhLb0QvZDlnazg3QW9haFR6UkRZ?=
 =?utf-8?B?V1Ixb0M0SG9VNDdJaithcjNGL2Q0RkI0YlJ5amJmWStINjVWajFHc1U4a0hI?=
 =?utf-8?B?YkdEMUM5T3dBS0p0d1NRYTk4MXlsaFJyZkR6NW0zQ1N5d0twQ05OYTUxdWV4?=
 =?utf-8?B?NG9ERnhaejdxc1ZDM1Z1MEM0NGxpcE1xbTErMVNvUDE4UngrTThtbjEvWWVJ?=
 =?utf-8?B?dWd5NGwrbHN3Q2xmODdNUmdXV3hET0VuL3VCakFyM1RtajdQbEFuQW96dzdG?=
 =?utf-8?B?ajlwSEM2cHNoTitLUCtRcW0vY08yRklDTC9OOHpSNW55dVhHcTlXWUVhQ0Iv?=
 =?utf-8?B?SktTSUVrcm9yMnRVcjV3RWdMVlVaTTlEYWt0RXpEYWptdGp6NGU4bU41TnFJ?=
 =?utf-8?B?c1RndWFVeUYzQ0sxUWl5V0hUdjlnNFFaUzlsUDh1OWZ0S09udWZIYjFhT3pB?=
 =?utf-8?B?MzQ4VUFBbkp5NlovMGRRa1lheGpBN1JJcVkvWWFlUHcwU29NWWs4L0x0dmFK?=
 =?utf-8?B?STJzR2dvQjBFVWhHUkhHdndJR3NyYjdyVnJnbm12OXRoOEhWVExZSElhYk1Y?=
 =?utf-8?B?VGN0VFMxUnZuQVIwYmJmd0RFbXNGQ1MyQ2tneFN1aGxKa0g5WjV5aDJXODVH?=
 =?utf-8?B?TEFiOVZzVnNUSjhORGtmQWhvdzR4S2l3UHJMdVcxMCtreXgvU1RhV0VMWFdU?=
 =?utf-8?B?VGFmdk1JT3NuK0ZacXJOcnZUS21FWHpxQm1xdGRESXVLN0ZNamgvWjBlQTds?=
 =?utf-8?B?R2N2QzRrbGlUTy82Y1FsY05OMC9pNkluVVdWRTBiMUJWUFdZZ2s3VStPQVRK?=
 =?utf-8?B?SXNGbE50UGN4UU1OK090LzVPYlo1ZVRITmViQUIwM28yRWFPZ210YVB6Zm1T?=
 =?utf-8?B?cmZEcituR3pZdFBLUzlrSFVlUjBhMGtITVpTOStTUU1DSTZMalI0VFNxMmR0?=
 =?utf-8?B?SkJ4TVRYVS91TUtWWW9PMDFUbE9HNmkrTFVPN1REMVB4OVFYaFZMWjZqNzc2?=
 =?utf-8?B?RE0rbUYxazN1WW5iTVpUbTJ1eFFXQ0pDNzk2MmpzcjlYak1Nc1JVejdsaGRG?=
 =?utf-8?B?eWRoMUFNdUJwZDZYNkJJQ0dBOEhsZzIvdkp6MVRwWC9sOVJwSi9zUVNiZW44?=
 =?utf-8?B?N0cvRUpsSEtGQzIveURFQUl0SkRESERRSXAyc1ZzT0hoL1Q2S2lLQy80MENw?=
 =?utf-8?B?bjlCL2JNbDNlbXhqNXR1Mm9QQjZnbGJKNFRQZjVjSXp4WUFZR0hoMVJuclJT?=
 =?utf-8?B?Sjk0QkNGbUNBejZyTE9qS1JaRW5iZW1hZXlqSlYwZXlQaXlqZUx3ZjZoMCtw?=
 =?utf-8?B?cUVJU2JsenV4MXJkSUI0ZFpTa0VScmJMODNFWXV6QytQTmNoYVNCRTQrM3ht?=
 =?utf-8?B?RjI2bFY3bzlnR0ZyVjR2REZmM3dzWC9UeHUyZzNRSlVjM1VJM2Myc2pZQzVh?=
 =?utf-8?B?bGJhams0SkROMklRbEQrdlYyODZZZDVwa3dLTTd4WGhHL21FVkpRMVovQ2pJ?=
 =?utf-8?B?eE5ReU9YRlYyV1RiK1c1dlRic2MyNUg4dWpycmNOdmU0Uk9vZ0tlMnNFbmUz?=
 =?utf-8?B?QWgycnl6T0FIK25VVUlQd1o5aGxFQlZoUlduRDk5ckR0dnE0a1YySktKSTNI?=
 =?utf-8?B?aXhHd0Z1S0RHSjNDUkdQZEhqdkY3NmxHWWZZTFRjRUxoTTQ0SVBhRUZZTnJw?=
 =?utf-8?B?Um5DZjBvSi9MZjBNZmY3UGkzbzl5SXRRVi9DMFhhN2Q0MnhPUlRDaTkvQml6?=
 =?utf-8?B?T2MxVXg0U2E4elI2c2QxRUxLMDBvMVkwQ1F0cEc4Qk4yTGY5bm9hcUNGcnBI?=
 =?utf-8?Q?UKVPBH9y+v2MH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGNOWnB6M01haGc2NlphUUlJbkJtWmt6ZEhvZlBnTXk3RmdmVG9TNElqVUtE?=
 =?utf-8?B?OVRuVGt1M0ZYbDdVbndTZGZqQmYxZVpOQVJxMVliaEs5TnEzWkRVMW5SODJO?=
 =?utf-8?B?N1MvNmxYS2FFK0VwTFdqVkQ0TTl4VmdQM0Z2Q1hHLzF4NjJwVE4xc3hLdjJX?=
 =?utf-8?B?eEcyeDlOa3hZVENzYmwxSHNvVlU1NGcxN1M3aFFPTnNjWis2bFNwdzJvZlZK?=
 =?utf-8?B?d0RrMm1SSUdIT2VqRVB6VHFHQTZNU2t3aXNHUW1rYjhQT0dYSklPUjd4OW92?=
 =?utf-8?B?MCtkaTcvTHB1UGdYQlRrK2RWdGF1Wmgrc1lJd0ZHVitYUVZrcy9FY3crV2JE?=
 =?utf-8?B?djNYb1AwaVlYbGpkYVJPMzE1S29jM3pwMFRpZDcweXg5NGRnaEYyOVJxeWsw?=
 =?utf-8?B?bWFDOVQ3a3ZmSUZXL1lsNjNJc25INTNNaXllMnNNVXhMa1pZRTkvTWRlYTVm?=
 =?utf-8?B?VGdnQTJCQ1piV0hIQTltWEt6ZXkvL2drUWRjVkhTSjU5UXhaUDJTZFdTbGdu?=
 =?utf-8?B?OXlUYTFoVTFxdll6cTVxeEM0NlNJamhDZFJYQXFkSks0djhqN0dsdVNBUGNw?=
 =?utf-8?B?RDI5dFRRT1N3OVl4VXJ4clVjUi8zb2V6WHVPdWRab3luRTFtM1orUFd3VEtT?=
 =?utf-8?B?VWlIa3dCMkJ2dWdkeU1CQmhkcEExT1pZdlBxYzM3NGZQYTdyYVpSTmFhdmk3?=
 =?utf-8?B?SHlIcnpwZjJoRmc2cVFvcjhoWVVobXBVU0tSZjB5LzBUN2crTlNXc1A5UXM3?=
 =?utf-8?B?em1aMzhPdDhaenIwU25FaVRYSEZ3Sm5OOXh3UDdBTURubzRmd0Y0cjFuQzU5?=
 =?utf-8?B?OGg1cXk5bTdwMGwraFpDRnpFSllac1FJczlyajJtalh3RmFsam5oT2pKcExq?=
 =?utf-8?B?SkdXcHI5TGNsdWwzWTFXYVZxK2pRb3pjcVZOSDdUZW51alU0VEZDWGgvK1l2?=
 =?utf-8?B?SjR4Q3BuM05ZQlpkSGpPQWhGTXRYU2NRYUN6dmZiYkFBQzQvTFRMaitPTmJP?=
 =?utf-8?B?bWxtMzdQOENxQmgwS3VYZmZLb1dzWFVKb0k5ZHpZbHU1eVM4cWNuUm5kWjgr?=
 =?utf-8?B?RmdERk5TZGhhWXA1bHZ4WnhsaURLZ2R1WUt3Yk1MOGFSTEpvS0ZsSjdacGNu?=
 =?utf-8?B?OWp0dHlOSFJ6LzdiRVErS1l2R084SldiTUlrblVIM1BKazk0cHM1K20zNEc4?=
 =?utf-8?B?K0VvWVBZaWU3UVA1c0Z3aVk5OHN3czdFSVl5OXNqWk1XVzBJVldkWEUwbVJG?=
 =?utf-8?B?N08yZmNldHZ0d3pHcFdtVG5BNG1OS3lFTkxnSnovVTRlQWJWd0JuU1ZybCtx?=
 =?utf-8?B?NGhIQ3hEaVorMmhpRGI5Q0trOGM0anQwZGdoNkY5Zk8wMFpBYi95WEk5THBM?=
 =?utf-8?B?U0J4U3FVVHNqQVBrd09hQVQ5UStrUWxrbDZsdUJ0NHpwQmFrVDRmQzVzWmEz?=
 =?utf-8?B?STFWcmZvWmhjc1E2b0xmYUp5NWZpd1B1cnNYc1Ryd1FwTDNTM29YaWtzc2xX?=
 =?utf-8?B?eFZCdzFOYjB5R1V3WmdoeXZCekRtUHJQb24xdERTMnJyeEtLcVpHL3U4MjNF?=
 =?utf-8?B?WFhJbWdzSG12QkMwSnZnYXVzNHRmbzR3WmNhVjZ6S3dja2c4QzRyZk9qSy9q?=
 =?utf-8?B?M3BiU0xVaDFDSktLQWlXM0VsYnpndFVlNXFpOHNCSnBXN1RtR2p2TDNqckRR?=
 =?utf-8?B?c1BzUnVyU1dZSXJPcnhKeDNmWUtQMlVnVEVTU2FpdEZyR1FhMzJPQklLVk15?=
 =?utf-8?B?cWYyZ2pnQ3NlczB4T2RncE5heldBME1EcFBTSjUvWG55TUFZOUhmMWtKb1Zp?=
 =?utf-8?B?cEt6UTU3YXZ3NkdnTk04ai85MXRhbXdIMjBFc3IySDY1aitJeFdBTkNlbVla?=
 =?utf-8?B?NnJ1ZnppZ3B3ekYwWTFhTFEwdXZmWjF4eUNPQklDbjU2N21PYUhyVmM3QUQ3?=
 =?utf-8?B?emY4OHFzU3k1Y0UrSUdIM0FjQVNZTW83MmZpRW4yb2p1VkxjN1JkWkxtZVUr?=
 =?utf-8?B?UnJueHB2dXh6d0JvZlVvNGpORWJ0V2laS2JDYmVsVTRIc2ZOQnRva2xjMVoz?=
 =?utf-8?B?REZsUkZWSXlGeWUyRFA5SSt1VnZlNGhoYmZvbGJMZGZhOWNSWjNxSVNZVlJD?=
 =?utf-8?B?YTM4QkY3ak9DalJrKzJGMlBsMk5oRDFZaXBya2E0T296TEZGYzhaSHFNU3Zz?=
 =?utf-8?Q?UEZkq+gSyqvWktU3g00vEjQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf1788e-8968-41ee-f7a3-08de18b637ad
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:46:43.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LX41F0BX5PHVKadVgzXttyUKnD1nh/2H4figOc8+cKGbtYgYjtleBRFfotZ8hHZw7u6hpSCYrgkzqc54WE6IMSlZTn31jM2hE1LadYhzSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9612

On 2025-10-29 09:22, Thomas Gleixner wrote:
>   
> +/**
> + * sys_rseq_slice_yield - yield the current processor if a task granted
> + *			  with a time slice extension is done with the
> + *			  critical work before being forced out.
> + *
> + * On entry from user space, syscall_entry_work() ensures that NEED_RESCHED is
> + * set if the task was granted a slice extension before arriving here.
> + *
> + * Return: 1 if the task successfully yielded the CPU within the granted slice.
> + *         0 if the slice extension was either never granted or was revoked by
> + *	     going over the granted extension or being scheduled out earlier

I notice the presence of tabs in those comments. You will likely want
to convert those to spaces.

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

