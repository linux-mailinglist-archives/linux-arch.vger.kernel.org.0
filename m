Return-Path: <linux-arch+bounces-13514-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87EB54E1E
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9163C169E85
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 12:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8256A30497A;
	Fri, 12 Sep 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LKelg/W7"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020118.outbound.protection.outlook.com [52.101.191.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF1D3009F8;
	Fri, 12 Sep 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680433; cv=fail; b=UQVmrx0lfYaLd7UPeSRRl3rrdlqXpHimyVFQbySsrpgCR3RPTkNAtDXipodeaqyyuGu6/kXAl/eayTRcjPNmGwPY0ckwg+/iik85XuGeJwleF3eds9w2bIFgbD4kBtujqrofN3wUZwwBjyYjgHtpzsG0/lE1OT7AHBxflSrOEHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680433; c=relaxed/simple;
	bh=LCDY4qkzg6jiNxNB+xnnudGtjLuHdDLtiO6JHhK8IDY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sH0GAZCDq8pOcUscbwD9ZCRE6SPt4aG+TKr5Yix1d4fU9aPbZazTtBV5qRMDGeZ7ZYkfZUGRCmmEpxRQEAZxpqbigA+D6s1pA3Ul/JUNqqVJfQLMojES0ZYx5ixPve4jSCKB2vTXzEwlqZEvOGjsBiM0cIwKV+jiMsPne/XMvhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LKelg/W7; arc=fail smtp.client-ip=52.101.191.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRuxpI09Xl1CHE4YFjT3hUh41u4wUGxV/RDO+BS7X2DJ9N21FSkMAnsDsh/21jBkoC2C11HuTmKjqbrzxemc/N6R6NGVy6VIv9cumoM/+bgdxjWqVJVshEiVJ8SkQn7pJlkbcsoX+UWl6wxMw8ESEGrEUa3R44CbSGCAF2sfRBFKfJktdI0nHrl7VFPuQXPDAecmtE9iLstj0GlHcU04qgt73Qc9W0EZOPruB48vnYH5NV07wLCfgDsyFJguK9uScIarty4TvaCIjdY/ysPo28Lxwq1a7Lcr4kAgRMRHgXCqOuo8LbWuPBRebuEkJ2NJwa/pcG4/mnPaRcou5Qjwnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0UHjURg8CRuXIVotXNeQxJB3TFuDcgWasAzbp0Qti0=;
 b=hpD9QiB6YHXv3TPcNP24qBGlUlIWF8mevmipgMQNk23hejylXDKpJZEGlfcSixoAmsY0eI6MJDeucMuCLu7yC0aGKN5NM9wbtTFQh5vCxXF7LTqABxGj1m8elf7YmiX7ld43hZOxHgaiu6CuOoUMnzMGeA/Ou0zFoyUuMOp0n+dNa2xw30s06hjhl1UpNk6yLrA87xIh5OQANMVjs+CX+yNCxqioJHP/ca01tq36WLZfo1dEDfkvDj3d2MOX1XShUB3cI2uk8Yvaptl3gdQfMLSeHwfTJ+T7y2H8EjpPavc9baeu/irqvh0lnDNWVwzog5fW0socPYT6Q0fD+EM9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0UHjURg8CRuXIVotXNeQxJB3TFuDcgWasAzbp0Qti0=;
 b=LKelg/W7pnpVY3fwnGLVT1I0N5FjuWajM+2qsd1VP9gqqHhgr9TGjyjcXNORuBMgKaWyYEcEN3ZLWgSuT1vgHHaQTsqsRAEIrB19ydRrn7WryFKMKZspM0+pCfSE5HZaNckP2VLeiOgBO4YFx6m8f8K3QXQwLJ8hCX9nMizk1may2p6TrQKq9WeK1BmdxzDuAkxBLNTYGZJeOXON6SPh5sNIl9d5MStFnWTsFCVSoN6ORE1Za3a3GWhxC+D78RVxqqrdlJUzaxPM5Y1KlSazgBlUcY+TtAysQAbUjEoJce1KRESe+jj2XYzpCiIvPWeM180gWsyj8RUAC28l+NtUVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB9201.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 12:33:44 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 12:33:44 +0000
Message-ID: <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com>
Date: Fri, 12 Sep 2025 08:33:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com> <87plbwrbef.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87plbwrbef.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0009.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::7) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f38c15d-b682-4fa5-bce5-08ddf1f89cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0JMcVdIY0tVWHVxZEdYeFVOME9XMDNrbEd5NUNFR0RuVkx4NWY5b01ocnhU?=
 =?utf-8?B?WStFaEhHd1czZnF4WCtKSXJSQUovN3dFYWJOVWNob3dRM2NGck14SGpVZko4?=
 =?utf-8?B?N1hkWkNVOUt4UGV5RUhCN2dSMlIwVXphcklDZHVlcFpwQ3VVbGt5eW9XY3g0?=
 =?utf-8?B?emhUMzFJaytscDJBYkIvbXMzajZmdkN0L0xwRlhOalNZeWV1Rk9xZVNNR0cz?=
 =?utf-8?B?RW1jdGFGVG5xeHpTSko2VkpmR20xZ2psejZ5RFBBS3lWdUZ3eXh4UThQUVR0?=
 =?utf-8?B?QW1ZYnk4L2t0QVhjNC82Q1E1L3BWaDdTTE5iSzhuQXJnMWl5VVR2cXVDeFhs?=
 =?utf-8?B?ejJOZGdDd0RtTTU4S29WRFhydHczOGxseGc4VlhMOCtOT2pJSnZjRzRiTHhE?=
 =?utf-8?B?MWZpVkJiYWdEenNDc2hDRE5UZ3kySG91SElCRzJRREFnOXBGU3JqREl5QmI5?=
 =?utf-8?B?QVhSWXNwS21ySU9DREcwcGJheUlVcURTQTQ1UkVYQWMxU0xEUmMzOUczaFJD?=
 =?utf-8?B?aTJJNUJGWlBhdU1TMlZoNktkSU9BdXVOMTh0L0dOTTFlTnBETnBGQWJUM0xY?=
 =?utf-8?B?ZlRsbzBYVFZ6SFYySjc5b0pPSTJlSEJUcUJGSWU2eUd1WGZOYjRnOW5CSi9L?=
 =?utf-8?B?WkVyYmNUTTdBRzdLVUFucUpZMDZrUXRxYXdUU0o2U1VDSTM2dFVXU3N0R2xG?=
 =?utf-8?B?S2JsWDhBM1hTY0tneXFkL0o2QU1ZSVlPZjFIUFBINHRVUUp4Y3g5NllhNHZ5?=
 =?utf-8?B?V1RPVlhGZ0NtVUJlL0pxVGpHaHMvRGxZSkNaMlFOSDYvZ0hYZ3dNaGxZZm1V?=
 =?utf-8?B?RGhqRUQvSm5UbDVRb09HdWl4TVZjU2MrOU1US0Q3NmRodEFWRExqK25uSTZT?=
 =?utf-8?B?dWZDZG9TU3VYYmw0OGp0K09uNGpqSWRVbmJUc0xvc0RlVGl1SURKYjM0MEZ3?=
 =?utf-8?B?RjcxYUE2RzN6TjhMRHZQVGpaQ2xURVg4MFBlYlJ6dkx0aXRiYXFoSFBZQ0R0?=
 =?utf-8?B?cjd0ZUJraWtaTSthdXl0dkVIeEw5RHo1VXJQSlBCOTE2US9KdTdnOTcyYk9D?=
 =?utf-8?B?SjgxS3lYZENxUWdYa3NLWFFQcW9Id0lhcDRqZDY2MklId2FyZmFNZU0rS21S?=
 =?utf-8?B?eTNMVlAyQ1F0QmR0eVFuS1JOdDdyQ1VTV3hyWUM2Zm5tcTlFUlg2REVVSldk?=
 =?utf-8?B?U0JNVDhWT3Z0dWtuTnMyWER0dWE2ZTFadXpMc0tKV3ByQW9QcWVjZjV2TUdj?=
 =?utf-8?B?V0oveDZJSVo1ZnJiZGxWaENHL3loM3owTWkvZVl6cXVvVFFGRDVTOTdONEZX?=
 =?utf-8?B?dk56cUR1Mk5iZmRYT3V3ZnN6TFdvWk9GaDR2QUlCQk5DR2VjaFZ5TU00c2xh?=
 =?utf-8?B?TTdtN0xWRTQ2MFdWUnFoZzhDMUQ0NEFIaTBLVEw0MUttdHp5dW9yQnNaRUs1?=
 =?utf-8?B?WjgzRjM5Q2dpbjc0aGo3ZHhQLzQ0QzZKUGoxTDFPOGhYcVJoY0FhNm9IVUZ3?=
 =?utf-8?B?RnhaR0gyS1BLZzI3Mjl1aGsrZGhBSCs1M1phVGRVUnh0WGNhVlNROC9KRXRW?=
 =?utf-8?B?L1BxOEZzOEwrWWc0SG5aRGs2alFuSnhGenI3Ti9rVVg1cmlkamZsMTVLTGVS?=
 =?utf-8?B?TG5wS1VqL25GUzk4Nk1McGFtSUxiREUvd2tsb2dHUHYxSWZpcXJiYWNmMHow?=
 =?utf-8?B?eW9qRGtta1U5aGZUNmhyamg0dnRDOFBscGRVUFVMQWhPWERMZ014ZFF5Qm1X?=
 =?utf-8?B?ZkkzaTlTOENUMlIrZmlDazNLRnNxY1hOUC9qcjJUMXFjZGhWQ240bXoyLzlQ?=
 =?utf-8?Q?pWMfBwsoWJJkdFyOLFa63+pK/6uFCxu36Ew+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkNROTZMT2lNNjhGWTZ0ZkpVcWxIUDJLTW1MU0tNUUxLakZqcmFXZy9xZ1o0?=
 =?utf-8?B?MWxZSFNXc0tndEM0MVQ0dGlORUlySEY2UzRqVXI2WWdjR0huU3lTTEl1cTU5?=
 =?utf-8?B?SGxlUkk5OVlnTGFhcXBxaXBaL3ZtOExYeXI1M2EyeDJOeldUM1hqMlRtUkRz?=
 =?utf-8?B?d3N4OUs1cC94VmpwRitvQlloSEVpbXFTWExmd1MrYy9maVJMRjVuWThhWlpy?=
 =?utf-8?B?eW9KbmtISjdhZWNDQVh3R1NxRTN5OUtYbGlUTzh4RkNpSmdGay9LY1N1VDBR?=
 =?utf-8?B?ZTgzajk1ZUQ1anEzYmlVMHQ3Q0dudUFVWlAwZktrRUtxbXE2YWdXcTFPTk9V?=
 =?utf-8?B?WHBKa2Z1aFAvc2hkV0xaQitDRHBHQkxaWVI5ak9HZlRmS2tKVGJPaE9veE80?=
 =?utf-8?B?L3BlMVBDL0FyWGxvVUJPb3FGNWpTTTFpaGRQaXZCajBkMC9mVkxYaHRlSmdV?=
 =?utf-8?B?aVNsN2FZM1pCR1JsdEVpaStKaTZzMk9YaFQyT3dHbGtkeldaNWJwTWNoOC9r?=
 =?utf-8?B?cVV4aWw1K2IzN1lzeC9BNlB1eXc0TThueFNwQmh0eVpvcEgvbDJiM1BKcWpH?=
 =?utf-8?B?ZWFvUkZLT3I1ckVwNmUwdzZNcUtLY1hBcEhINmdzcENuaHkybjl2cy9kWEtr?=
 =?utf-8?B?SlI3M2dyQ0Z5ZkVRcmcxK2pUN0FUUkhtNjB6SXFZQXRlYWZTa0JDWFlKUFBZ?=
 =?utf-8?B?c3ZOUG9ZZ3ZQenZvOEo3Smw2NjN5YWprT2tuMzl1dFNYY1J0eWVhcHRZdUJH?=
 =?utf-8?B?WUtWaGo1SmVwWXFYUFpJTERrYzVVM1hrUjhoU255SENrZ2Y4OWQranpaWG1h?=
 =?utf-8?B?UEVwMVVFSzRsNXFMZkFJYnZXbVc0Y1UycW9kUDF3c0tIaW5BMEplaVZ1YWZk?=
 =?utf-8?B?SEMvQkZFazV5dzlUM3A0MjcwdXhPdHdtNERnODIxOFVzbkxTM0w0emhvOVB5?=
 =?utf-8?B?bmtpeCtVL1d3UnpWSWxYcVk2K09WamNiY1RDbjZrTGg0blBMclZ4RDQ3Rytt?=
 =?utf-8?B?NDBDSXZOY3VadUE4VisvbFJiQnNVVm5lT1dZK2lhTUVob1h5K2sxbDZiNUk1?=
 =?utf-8?B?Z01jZk5zak8vaFFjdHFHelBLdi9SdGdDemtyUTB2WEZPNTZwK09ZUUJOenE0?=
 =?utf-8?B?SWxtd1lCM2x6M3g3UDZEU0RjdnZHSTB3aFd1cEdRZ0tMWTRGMUR2RStRSGU3?=
 =?utf-8?B?NTMrd2VUZzdHOTBpcGxqWTAvVmhKN3FtSzYvVW5FeU42USt5RGVKZTVxVmZG?=
 =?utf-8?B?Wk92aTlIQ1NVcjhDS3kwNkYrVXRnVFpPWXEwd0Y0UzdUN3BYeCt6ckd2Tjgw?=
 =?utf-8?B?d1RYNStXTklzdSszOGxEYjRHWExhcGNxd2xTanU1QklDSGlRdFBsNW8yakNL?=
 =?utf-8?B?c1hnNDd3blJhNzZZL0c5ZFVLZHFYTzFXcVF4NWtTbUZHZURXZ2hYNzhWVjla?=
 =?utf-8?B?VFIwQ3ExV1pETmt0dGVoUVdWeWR2SmZLN2ZRT05ucHIyekpYcG5sUjJ5Zk9z?=
 =?utf-8?B?ZDFCSFBsbjBhZVhWOTJHdTRXVm5zZDBHNXVLVXRwOTM5Z0Z5alQwdnQxdEh6?=
 =?utf-8?B?R2QwRXBmcUJKbmZsMm11YXk4ZS9NQTFKeGpnbWZUakQ2MksrQVF5NTB5ZHI4?=
 =?utf-8?B?RngxUXhBcTVlc3NUV0doT21vdTAvb2psckhKM2Q2eFJyY2lVL3E3SS9mRXZ2?=
 =?utf-8?B?dmF2R2llQVh6RkFlTHQvaUdlTG93R2ZhTlhaSWhxM21wdVdaS2lMWGNzYUh6?=
 =?utf-8?B?d2hLL1ZsS3VCY2dMQThaUnZZVGpZcExoaWpUOVJzVlorUGp4cnh5Y2V0R0Nx?=
 =?utf-8?B?TXB6YWttQWFVb0pDMCtXLzA2Z0xhRFp4YUdpb3hMV0UxakVhZjVRTzYwVjdF?=
 =?utf-8?B?aDY2K0t1RWcvZi9hZkNjQ1YxUUdCbUYyTXdBQkpkSmJIeUtYRTZnbFFxNDhR?=
 =?utf-8?B?MSt2K0ZhNVZaVXNVMkpSWTM0VGhGSCtsaFo3Y21GdmxJb2dzd21wV2pnNFl2?=
 =?utf-8?B?T0ZCeXJVTXgrSEpFWmF2MktzbHNtcUZKQmthTnNYc2x5T0d1cU9VdCs5aC9s?=
 =?utf-8?B?Ris0RTNEUTZCYmNjcHhkc0NmV2FDeWxvQmVhYjAxem44Zm1TaFMwTjRUQy9q?=
 =?utf-8?B?ellXREc5WkM5ZHhOdjBIVG5xYUovTTYzTURYT1djQnExYjZJaTZlbjBWbnQ3?=
 =?utf-8?Q?xEPevyFtWHizk4XwQDb0B9M=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f38c15d-b682-4fa5-bce5-08ddf1f89cdd
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 12:33:44.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6+C2UhCawFKuuX6poA27xmchoUYXRCvcl7qHj87loT2PI9aTS64BquPN4IbFpamsDNraKnfKLJxX/oza50F5hdRlXgMRF7OOLD18Ei1pfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9201

On 2025-09-11 16:18, Thomas Gleixner wrote:
> On Thu, Sep 11 2025 at 11:27, Mathieu Desnoyers wrote:
>> On 2025-09-08 18:59, Thomas Gleixner wrote:
[...]
>> Does it "have" to ? What is the consequence of misbehaving ?
> 
> It receives SIGSEGV because that means that it did not follow the rules
> and stuck an arbitrary syscall into the critical section.

Not following the rules could also be done by just looping for a long
time in userspace within or after the critical section, in which case
the timer should catch it.

> 
>> I wonder if we could achieve this without the cpu-local atomic, and
>> just rely on simple relaxed-atomic or volatile loads/stores and compiler
>> barriers in userspace. Let's say we have:
>>
>> union {
>> 	u16 slice_ctrl;
>> 	struct {
>> 		u8 rseq->slice_request;
>> 		u8 rseq->slice_grant;
> 
> Interesting way to define a struct member :)

This goes with the usual warning "this code has never even been
remotely close to a compiler, so handle with care" ;-)

> 
>> 	};
>> };
>>
>> With userspace doing:
>>
>> rseq->slice_request = true;  /* WRITE_ONCE() */
>> barrier();
>> critical_section();
>> barrier();
>> rseq->slice_request = false; /* WRITE_ONCE() */
>> if (rseq->slice_grant)       /* READ_ONCE() */
>>     rseq_slice_yield();
> 
> That should work as it's strictly CPU local. Good point, now that you
> said it it's obvious :)
> 
> Let me rework it accordingly.

I have two questions wrt ABI here:

1) Do we expect the slice requests to be done from C and higher level
    languages or only from assembly ?

2) Slice requests are a good fit for locking. Locking typically
    has nesting ability.

    We should consider making the slice request ABI a 8-bit
    or 16-bit nesting counter to allow nesting of its users.

3) Slice requests are also a good fit for rseq critical sections.
    Of course someone could explicitly increment/decrement the
    slice request counter before/after the rseq critical sections, but
    I think we could do better there and integrate this directly within
    the struct rseq_cs as a new critical section flag. Basically, a
    critical section with this new RSEQ_CS_SLICE_REQUEST flag (or
    better name) set within its descriptor flags would behave as if
    the slice request counter is non-zero when preempted without
    requiring any extra instruction on the fast path. The only
    added overhead would be a check of the rseq->slice_grant flag
    when exiting the critical section to conditionally issue
    rseq_slice_yield().

    This point (3) is an optimization that could come as a future step
    if the overhead of incrementing the slice_request proves to be a
    bottleneck for rseq critical sections.

> 
>> In the kernel interrupt return path, if the kernel observes
>> "rseq->slice_request" set and "rseq->slice_grant" cleared,
>> it grants the extension and sets "rseq->slice_grant".
> 
> They can't be both set. If they are then user space fiddled with the
> bits.

Ah, yes, that's true if the kernel clears the slice_request when setting
the slice_grant.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

