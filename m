Return-Path: <linux-arch+bounces-15472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC474CC4173
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 17:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EA2D30C9E56
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B183612F7;
	Tue, 16 Dec 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mVUIIRZC"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020078.outbound.protection.outlook.com [52.101.189.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2A1FF7C7;
	Tue, 16 Dec 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765899451; cv=fail; b=FWUsJAtfvvVlzt3jB9aB/SPze3Da7OcBJw8HzMDXj3CAc9BbMLA7dbJcBiLnn5LXBZxKqQk7O+m3GkJPCL9EIf/N98I+vj7EmRayEbibUigdH9HbXNBZ5+6Yqf7bVFjanp+Di5kaoJn0Hl/sP4kGc+07SqSh/IRmMNDoXCI4U/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765899451; c=relaxed/simple;
	bh=EBJ0oNtQCltPf/LCeJliwuw45Fr6t+ih+arpNxfzXbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBXUGGWmES3LBGJzDe1CIfG8wm0zyy1DtWjEbJOG6QEuwYz48cA46L02ST3kqc3vdzmWmjZinTjj3Ah7UygCKGnbHwPHh2f6FFwnDC8tQBg8Kg/OsxAW+Jr/k/xHMhI610ZhkUzWI+UtfLjdgZ3opu4tbXO8k40SIgCh/abl2HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mVUIIRZC; arc=fail smtp.client-ip=52.101.189.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1CawwXgh7I+JtT9z40ECGP2Bq0A8JAYtqrCIcKoJvi+EBEMQQrIp6tAq13LEI7M4El6s7jLqTq2lkQ94MuCmLIex9cvhEjJnxlMQgYHFuc/LIMrrhfRJPB++vn6tMUzWQ5OlaQn8BJuSCu0RqlEI9kGR0xAVDyRAGIUJDupSAD7NUhIlRe9eWk9ngu0QtSYhL2QMLQMUQ1rSwKOV0Pboja/a/PnsiGNfkL6ZIwiVNOBr4dKPclAYRlTSBItNG+0bkufCvOEZPQXRrFw9cTsEavOGEWnrTqn/D3hmDDf9J29d3w9aFVdSlUEDh5mneEZ7/e79NH5wbkpziMbCpbexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LMHULEkCHdB2WoibbbT1mJRKvn/kx/PJdfAHiyzsJ8=;
 b=VbNatfrmZM0OsPQKv4t2PFD+fHCAaq8VDG+qYVd/nbk/+nngYwvMoyq2+TaE9PMhJU5SDQD6WtFgz3pNzAEmmgC5q1GGnxc92FfnMxGI/Ippl3aKifQCfSUjcFDymaN++TX2X8ZWAUHiVB4E4pDvqlfPsRLcgQCvTXNmwU/1vxSs1lRcRv45IMZ0IQHd4SNWbF/TikqX8Q4jwMn+xQlAuDy0582VPWcArZxx1IKFPLz8RbRlq4I8D3C3LeJn35c/E87G+b0zqn47L1dIDE3JEGKQNVsoFXFwTBaPHV4Mgz34IEvAgmChCNB9seWPQvYWquRcTu7ToNi2QFK5AAComA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LMHULEkCHdB2WoibbbT1mJRKvn/kx/PJdfAHiyzsJ8=;
 b=mVUIIRZCPIRrfwpJGpJIJ1BAftwmyk30Y/fVb8fxc68JmoPnFilVLEfY5AlWBb3pJ/yMZXfELHXraDtlKj8ZAWKG91NiVS1lXT4FkMo+fbXjWRMdNDn6/DcI0bsN+/irvh7/pH4dKwBx1e7RwiFJuUQEsT0aWyeFi/zf3KC+l2e7cz6AYg1aozvoe3Gq/MSHwA/l65kB3xoF1d+tP1IR9wKIyV54mzPlUUcAXPxcrVKZFbZGSYdzCDxeFO/tHATujWpLVbagKKVsqNv8hSVfndzvJ9MoGQ4BPpFrcSDgrrnOilVYlve3UFikkbfx6bnfXItVY8t1zqskrNlvRV1fiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5955.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:68::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:37:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 15:37:26 +0000
Message-ID: <d8215f9a-3088-483c-bd96-4058767b886d@efficios.com>
Date: Tue, 16 Dec 2025 10:37:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 10/11] entry: Hook up rseq time slice extension
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.258157362@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251215155709.258157362@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: b33b49ee-add9-489c-968a-08de3cb903ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzJOQVVwN2FSZjRxN0gwNFZiNVlOL3VtSkdkbVJ6OXNlVnpWTmd4V0NqVWVm?=
 =?utf-8?B?d3lMeFhUdEFQMGpaOXFhVjZjbzArUXFEaVlpMXo3K3FPd1l2c1FZbDNwNkp5?=
 =?utf-8?B?YUh5U1pDeTQxakRKcjBWYXV2eUlYZGxVeUp6bXh4MFQvNHJGdjFBZDN3Yi9U?=
 =?utf-8?B?MlpiV0J6VHIvOWg0MGxzVHlReWNRb1A1emxycVdHaTNkTjhtTXllSFRVTGFj?=
 =?utf-8?B?OGV3R3FzcmZPRGR0dDRveW92dkE5ejJyZ29WbVhLNDhMRzhhZ0R5K21HMkI3?=
 =?utf-8?B?MzJkT2duUDJ2N3MzK004SmhhREQrY3Y0SEMvWWZJK3RIUFFlWGFpa0VxbFFl?=
 =?utf-8?B?UGd2aGN4QjIzOGc4ZmdtZy80YmRuV0tWYkZDalR1dkdTd0RrTjF0NTBiTFNX?=
 =?utf-8?B?Ti84cERzUndzdjY5UVZMT0RsbU12OWF3WGdXM0w4aXZ6NU5OVGZZaHdnc05v?=
 =?utf-8?B?WTZMVzQrSkRaRTNZNHV2aldMaGJlQzRzK2tHdW13Qkh1VU94ZXBjZktxOTFL?=
 =?utf-8?B?cUkrbHk3dnYrbkVFTkRVNTZQZFlzc3NYZ2tYWlh4UXZXd1pmTlF5SWFUb2F5?=
 =?utf-8?B?ZExTNk9vSzZqV3l2NEZaS1hnOFRrTkdGVFlKaUdhZnpmNWlib0MyR1YzME43?=
 =?utf-8?B?U0htcDhEbkdhVGFkd05WbVBnMDc2RjZnNXVRcDFnNEZoYUtpNWJvbUYweE0r?=
 =?utf-8?B?cjF5WkpwZWtwVzBSTVNXUXpWZURFeFVRQ0YvZVo0Wm5YSnM1ejlxZk1UQWJV?=
 =?utf-8?B?ZDhXSzJqRmRHeXpLR3pCdTF4SVRjYXBnQmNDNkNFdDh3K3lKZldBeis2VlVG?=
 =?utf-8?B?SnJSRHBYZ3NmMTBYN1B2QVY3SFUwTDVKbVIvVDQ3MStIaVBtUm1DUXl3RTNa?=
 =?utf-8?B?REx2dklUVThhNDBzRnhQRmFwcjBJLzJWTmVVK3dBcTdkbStNazAyeTFuM0V0?=
 =?utf-8?B?OHlUQ21tcHVkVStiaGJnQUgvUTVqN245UlZiM29kUVZKMVZsc3J6SFNGNm9q?=
 =?utf-8?B?SjZkMjY2R0RiVmd0MnRWZjc3ZEhYZXg3ZFR2QnBHWEtaZjZKeDNuY3BTWWxt?=
 =?utf-8?B?cEtUZXcvVUpvTnA5WlMraUN0TnlTeExiVEFic0VpNndMemNwSnp6Vmlvdm0y?=
 =?utf-8?B?VENWajFLNFpIYndSN2x6ZHVuOFdFZG9xL1R0VjBVUlRwOFRFV2lWKzlxa0dq?=
 =?utf-8?B?VkZvTmIySHl0MjJDQWNtTWFDeEhsbmJwOWN2MkdBL0UramZDb0d2cjN0TDlY?=
 =?utf-8?B?Yk53MXZnUlU0c1hQOUFJWk5ORGhLRi94RVI2cmNoK2lZWk1LaUVKdEI1T003?=
 =?utf-8?B?UU5UKytFUHR3dldhcFI5YlRWQXVPSHNSa09FNjZ6RnFlMlVmbnNjaXRJMERX?=
 =?utf-8?B?cWFHSnZUdlBJeWtSZW8zZzI3dSt2Q08yeGQzT1dnYzNBaGZIT2UyNFV5OVdi?=
 =?utf-8?B?V1YxdDI5ZnFUQ2JJWDdzZHhEMWZaUUxRTTdaRDFNbU9ydnA2QjVrVTByZ1Vz?=
 =?utf-8?B?YVpHVWVDdXFScXkzUUpkaVoyT21EMXQwYnlwak5pR3lpL3E5WnQrVllxMU95?=
 =?utf-8?B?bHNpMEswTmNiMTNZUkdvN0tKZVZzcURwQmo1ZlZsU3VpZ0MxZmZTbDhxVzc4?=
 =?utf-8?B?TXZsOTVVYnY5MXdxSkEvTi9VSW9hOEFXZkRhZmpZWm9GaHcwQWo2c1IwT3Zv?=
 =?utf-8?B?UGtlazcycTVjalErTGs0MkNxOUhvMk1NYjF1UThIS3lKNzFMakhqWGc3SjhI?=
 =?utf-8?B?cHlBZ1hWSWlnRWg2UTFoZ3JmOUZOaW5LWnVjLzhMS3BvOFo4a05tb01Gemlw?=
 =?utf-8?B?Q3FTOUZhTm8rbUt0NVdwRy9aY2orQlNPbitFM1lOUWgwSVpCQVROOENDSjl4?=
 =?utf-8?B?TjZzSEN3Wk1DQkFDTGlkQkg2TVlJaUY0Ymd1V3VDdytpK0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVllY2lQUTN5UlhEYWNhd3BmcDJmbVJta1VxVWdWdmJybjQ0THlPMzFRek4y?=
 =?utf-8?B?SXlDb0psVHJuU0t4VzdncGdyeFZ5c1h0RGE0MEh6ZEFFQ2R1cnNYa0dzMmNp?=
 =?utf-8?B?RVlzUFpkVnlLVVVHekdER3ZIZkd0WGN6ZDkyeU5ldmdHdXllWkVlUnRkQVA5?=
 =?utf-8?B?WnpXQlk2UE8zWTYwTzVqWlZjbkNFMEZ2ZHRoTndOcWx5YmwvTHAvWjRBVklo?=
 =?utf-8?B?YlVFNmc0SlBRUHhSNytsbmRJVzhiQjJPdWZMa0svWmNPdkpFZlFXZ1VzNTRW?=
 =?utf-8?B?amhab0Y2bHZjaVMvMDN2UmxFNzVIbmh0aDZXZlBRNkFvRksxS3oxbFZyRHM3?=
 =?utf-8?B?SDdKNXRYcUxEYTZFUG5OQ3RReUQzeU4zcjFTWTBEbUNsWDdwdkoydUVHYkpF?=
 =?utf-8?B?WnU0WDd4c2ZaVTBBMnJoM21RelF1R3RCbitEKzlWQVVVSXo0bWJJL3ZQNWIy?=
 =?utf-8?B?UVlDK25qVUgwQ3RmRXVjYzh6d0ZzMWhCYXk0cnNVdlgydkEzWTB4K1pSVVdZ?=
 =?utf-8?B?QWo3REVQTldxRU4xK01XM3lydlBvakZnWG00amdmb2lOUVJjU25hRjFDdkFa?=
 =?utf-8?B?RmxKZWlBY2ZYRnZWWk44VEhlT1JkZHpyeU05VkRab3RBUlQrSXRyUitxNVJH?=
 =?utf-8?B?QXU3VTlyZXU0THlVaW5vVW9SQWJsbUFCTm1ud0NzcUFzWXRiUksrTkhaOTkz?=
 =?utf-8?B?aFowb1dKOGZ1OHA1TU9aZmVzWldvcWpmbG1EVWJ5ZXhkU0JUVDZDRDIycExx?=
 =?utf-8?B?L04zckRLMVFCdzlBaVZYRzVuYjAyanVGZmRYcFNHQ0VhU1hwSUd3eFY2NnRq?=
 =?utf-8?B?UUMrZW51azZWcFlhZXlmY2tVbmJCaFEvWVlTdHU4Z0x2QVBab0lvUHBuRkJ3?=
 =?utf-8?B?aVdNcGNPL0hRVmZ4T0Z1MStUdHBLaXdyeTdmVTZVM1dCQ3ppQ3ZFN1lQSmVE?=
 =?utf-8?B?ZTJubU5nTkk3RGViNVhkdFQyMkZFaUFOSFM4VHZmY3JWNlZFSHVVM0MwMHFJ?=
 =?utf-8?B?MG42MnJJUHFxUVV5SGdYSnJpY3E3MWlFQVdmeVNYZzZBcFdTdVAxOGFrRUhi?=
 =?utf-8?B?eE1UYWxhY1R5MlY3dWVkVDFLdFBZd0hXb0dvZ2ZVNTI0T0M3cEFPU2h0cVhE?=
 =?utf-8?B?MXdOMjhJR2lreDE4RHp0eVFVVzBLd0pnZ3c0b3ZQSHUxdCtSY2JzUXpTUi9E?=
 =?utf-8?B?M0xsV09aRVpjRy9Tcmc1NzI4eEN6T08yWno1Uk9qeWUxcG1nUDZ2TVB3djJh?=
 =?utf-8?B?bmRiVkpkWk1YeW0zR0JaUWFsQlJPYkxJSVJpc1dvbmg0T0ZRQkN5SEVKT2sz?=
 =?utf-8?B?TVhiWi9QcGNBL2VoRXp3MDlJbXBkRkxtb1E3SXpsZS9WNllmUU1EK3BLd1p3?=
 =?utf-8?B?d1F5OU4xMGVIOTd3a3lkVGdhYmJ0VDRlUU1melF5RXhDdGFvOXVKT2h0emQz?=
 =?utf-8?B?Nk9mM3p3SWdNY3RLd2h2RnRpbldUV3JVUlR0WDRCSkRVTEIwY01BK3NxQjNC?=
 =?utf-8?B?RjVmRTNkQkpwWjJFM0JPbVJvNnZkZUFUcEU2WHlqd0ZFUEN0ME5JekZZZjRB?=
 =?utf-8?B?ZktCZWxqYUxZZFNXSXZwMDhCWEFrM0lsNDNhamMveG1hRmxiQjRWRTJsTUdH?=
 =?utf-8?B?RkdsMGNENzF0Y3kwbTdlWVIvZTlGWjFtWk4yTWIwcDFUMEQzNkpmSHpFRVlM?=
 =?utf-8?B?Y2FSLzRKa1ZPQy8xcUVqWExjYVd5bi9oZzVObzdDeGd6T3E3bUxUbnVjVjhP?=
 =?utf-8?B?ZUp2Tjkwc3VvT2x2aHNBYmdxZDFaUXRjTkVGcTRsS1dNb05hQlpicC9Iczhz?=
 =?utf-8?B?UVZrUDFHVVRUcFZEVUl0aVA0V0hnbURMUUVmNlZXOXdFT0tNUFpEUFVTOHVG?=
 =?utf-8?B?YWtnVkVsNzZTUTVPRkRTZ0JJalpKNE5VMmU5QkRtaGM2dDYraXhqZXU3b1lE?=
 =?utf-8?B?K1JiSmlBbnc2Y1YwcU95dURmQmwxMkVoc3dTYjhBbVJyaEM2OVBkejBKSTV6?=
 =?utf-8?B?bmM0ZDBWQUZFK3piQzBzT1NkRDAwMWFyZjJKdzhVcVZiYU1JQ25FNlR4VU9E?=
 =?utf-8?B?eG1UREJGbTBkZEJJK2pTNEgzbksvakdFUlNNdDBXUDh3VDVRYTlzcTBVejlr?=
 =?utf-8?B?UldsTkZLTGdBbDJHREk0ekk0WmZIS2QwMDBJSGxSRWtCZGF0c2xocUdrTlda?=
 =?utf-8?Q?jANLFWl6CSTGZ4JkYcoutD4=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33b49ee-add9-489c-968a-08de3cb903ae
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:37:26.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpNo8lJ1NGdjfIFoUsS/gRGzpGOhQzdCiCxzMDn0oo36/3E1UkUAZHk5LDYnDljZww6hqGIW/S8FSDAtHFFNpJjhdnglkXUGPNIoOTsdwmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5955

On 2025-12-15 13:24, Thomas Gleixner wrote:
> Wire the grant decision function up in exit_to_user_mode_loop()
> 
[...]
>   
> +/* TIF bits, which prevent a time slice extension. */
> +#ifdef CONFIG_PREEMPT_RT
> +# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED_LAZY)
> +#else
> +# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)

It would be relevant to explain the difference between RT and non-RT
in the commit message.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

