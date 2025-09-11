Return-Path: <linux-arch+bounces-13500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC754B5380D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 17:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A12516735E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 15:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45471342C92;
	Thu, 11 Sep 2025 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qEHwiGJ8"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021143.outbound.protection.outlook.com [40.107.192.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF02D97A8;
	Thu, 11 Sep 2025 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605379; cv=fail; b=DpigxW2qTJLQnLQT0MokywOczigFm/n9C2wsfId8tILB/zyi3uqpi6AaD2Uh/d+Xjbd4SyBIWWAbeK0l1iTmKwdknEae3SDY9boNvn4maRiNP+4aQdmjT4NFeQsPoXmz/bixT0+6+swPCscmugJFWoKV1YLDB2yyLzTuwpOXs3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605379; c=relaxed/simple;
	bh=rQCTdjdHIoC5tqaPUGQU9xTjkIZpW8/4vLAYdn6FLrg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KWh9sUXNVgBnYOdgWL/teoWjP82IZMShNAPynYQU8Zet5VxiKaqtOZOCNxgqh44M2NI3BphCdeVj+9WJBld7g/cz4xEMcusVr0mKJu2sjAG/QNJgqoc3G3TKwMPs/me92tGpW82ZhMfqnLBSBQHD0QV3BMXH2zm0FgFPY6WozG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=qEHwiGJ8; arc=fail smtp.client-ip=40.107.192.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXwm+9gtGhPmH+TVY1SrQ2rXYC1EqHIZeNBlWOZJH/xasMjt6inxeANplYuf33sjcU1DV7htE2JktR6MPvMyrxIzDd8WAvNgS3NEZ9dMNLxdNZ7zQEcGhnjZBxnpi+raFG5Mnp7qpVqiVuwPJiwKkG5SJKH+0kp7xmVdMAn3d7YNTa5k1x9aVv7WvcOyx5tExH+/3VX3OmZZJTqXLYG4/ZSt744FeMgqxDIB2LNV/C1XWu9pbjGO5iSgtiwcNxMWf07Ftcy3SU4uzsV1TLr21N9cxnNQVGIfC130InrF9Ob3EEes3dF0mTskhTaG70IyT7sg6+7WxEAteNDFR+jq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RKnvY9q5liUqMeQBa5t0GI/xnWIg4O8duO8JrVpzfc=;
 b=IksqgtORRv9J8JwR3sVARekMEgxVO09235y6o4L2bygldDaqIF3/oUyDlmA5iM2B/np53d4j/UP7rhdgEZTUED3mmtFlu3sYF8AnDBq7s4x5v9x0Q9Y2mbU0rik210CHvfC5xnc/ZUzD9sUekiKf/nbDshOZbYdEgUaD28shTVAF2vWTZ0SWo86PCBC1uY3Se9s4lvF7Yin/bdw5FaIkQczGmayWfbxYzNu2ABNqi2UeRX+iNylZmqWIKKAMqAcrsS9sz+2aKTbaGCgk6w1UeWynjucehhqCF7tYP4Vgm2LNdTzynEVbnrV+W3vO4gdxRZahfqviT8LJx0wcaKZiuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RKnvY9q5liUqMeQBa5t0GI/xnWIg4O8duO8JrVpzfc=;
 b=qEHwiGJ8MKzVv70x6KgaFARrgC4zfoclC4E1YuLh+rE/4LV8Ym0E0e21yusvgpD9MhKrOj6hQtRHgrJtCkQd9msNe6eB3mkQ1S1xAfTBnTbFjsdeO4XD0t+gQAa0Tc87tJi4Nurx4N7FPbkrWhy2h9LGbeIzNrCzrfV2nLv5UtZtaKGd8FGGcwHtXwDmbLWj48iVUeEsfAMdtYchnrMPmaWithZ38Ulqk/EnmOiM7E9qZn9PS8LLH2t3WRi/Ts9kGo+ppJYiKgIVK0Ehm+bveK4v8Tdc7eH/Fy5jX0GkiVvhIm1kZkHKqXNvpTmzdT2MRuacmG+DBrPmFjBMczyH6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11226.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:42:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:42:48 +0000
Message-ID: <f3390ee6-dfcb-4a97-8aa4-3ba01889c12d@efficios.com>
Date: Thu, 11 Sep 2025 11:42:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 03/12] rseq: Provide static branch for time slice
 extensions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.744169647@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908225752.744169647@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11226:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a4ab9e-6c8b-4f9c-e279-08ddf149dc2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGJZdlV5U2tnUVNFNVZmcmJUNUdkQ3Vic2MxbEpGM0ZCZWlSS3REc1pHaVdJ?=
 =?utf-8?B?eUkwU1QrQTJ4Mk8wM0Y1S0lKZklwOUFJak9QQ2RpejY0Rk5ZTG1DdkFpV1U3?=
 =?utf-8?B?OTNERmxaZHVQazM1NFNQekJaQkxtMlcxOVpMbWJvVkdRUm1wQnZxRWpnZ0hN?=
 =?utf-8?B?bGZBeHFTMVlyMXZhQjV1M0pZMDVDdTFIYm1nU0Q5Y3BXdHB3bmV2UndYdGNW?=
 =?utf-8?B?RGZLL1lIalRpZS9JYTQ2SVRLWllHODQyV0dCZW5PZkNpcll0MTNtK21kcmVi?=
 =?utf-8?B?Q1FlMzR5TzRrOEFCNitYck5LWVBLbDVUdHNNRG52Mms2ZG5aMFNUOGVUUVM0?=
 =?utf-8?B?cHFhWFBLSXZydjJKSklSVDIzak5tZ2pmR2R0aXdhbDdNUHZLSHRTL1FXSVhx?=
 =?utf-8?B?ZExsMFppcG5FcEtnUzd4bXlEU3QvOW1DZkxFYVlZSnFkdkVGaFUzTkVvM3FT?=
 =?utf-8?B?WWFvY1hRU1lIQ0FmYzQ3SGVoNjNFS0VKZkNQbENkbk1uYm5XVmg3L2ljRFU4?=
 =?utf-8?B?WStubFliTkNRTStFNnBIYlhsSmNiYnNIcDhGQmo1anVGb3lxT0lOK283VFQ5?=
 =?utf-8?B?WmJTKzUvOTYwakIvdDk0cW1TcldpcFBkNEVBK2I3T0l2em5pbi9yQTdQTlRQ?=
 =?utf-8?B?MGl1OWNsWEc3ZmxQN1VYTWlBRGczclBMbUxxdE9jVXIyOGREQkpnQWpaT1Bu?=
 =?utf-8?B?enI3N1JVSnhPNXJwT0IwQkJZaktmaUxxYXAvZEZla2pnZjBNdTB3QXBWTldJ?=
 =?utf-8?B?LzBXQjVOSmRBR1hlQytNdWV5a0o3eHFHQUlxUy9PNnBXVi9xcTBUbWJuWWU5?=
 =?utf-8?B?eFhtcXluVldxM3dwb2F6dTJGa0tFL2Z0ZlFhc3doM01Qc2lxSUZQWVJDQmJT?=
 =?utf-8?B?a2QxRXJZOXVWYVRNemZKL08rbGZIOXB4b1NxZnBTRTBWbFRheUwvNGZIM3dh?=
 =?utf-8?B?SkNMc1VUYkRTY1ZZWWhuZXFOdExKZzdwOFNhOUNIaitmL09mc2dSTEs2NWts?=
 =?utf-8?B?S21ELzNITmxJOUJkSmNrcmdHRTFsaElza1psOEt3dFlESFViSndzYWNRVDJa?=
 =?utf-8?B?aEVGTENZWE5PZ2ZwUStKWjVrL3AwTHE4eng5UnM3bFRPSVpoRGlYekZiOHg3?=
 =?utf-8?B?S1VUaDRPVVZMRnAyZVo5NDUyazV3NXRWR2pabnhDRHZBUjJ3NDhmQkt3dDBK?=
 =?utf-8?B?YU42bGEvL0YwZHp1TjVHYnQ0YnJZTldHblhpcmMway9peE5OaTJIUlEwdzZP?=
 =?utf-8?B?Wk5zL1RSZmMxeHhaVjRJQmdLM2l4U1dNdStiVWgxcmlvZFg0dndNb0FldWgv?=
 =?utf-8?B?V092Z3kzSGxWcWxGOVowQnBTM0grQW9vSkRQOFUzQjZHTUVNd0tHR1VRYWd1?=
 =?utf-8?B?blpEQ0NIcDZTWktoNGhBSjRVRGZPeitVLyttK3lEOVNFUkt5U0pVNWpqODAy?=
 =?utf-8?B?ZkFidkJXa3VMZk1xWXFCYXRvUmozS0Q1THF2WkNncURGZG9mZWdtejRUQzgw?=
 =?utf-8?B?cE9DODM1dHA0dFdGN3FrYUM0S1NCNTE0OGZpbU1BOFE5cnFDd0dkT2d1SmN0?=
 =?utf-8?B?MGs2RGo0ODV2bHF4QUw5bmgzT3pQUVQ5MUxmbG9pL3gwZnFtZFlsSHZOQ3Bm?=
 =?utf-8?B?Vit6WWFSQ3pGQXJYM05BQ21LZmw2cnBKT001bVF5WnRWcXZ1bkhmVjBURFpO?=
 =?utf-8?B?QkN4d2RyY2RRTWt6WE4vOWJONUxNeFM0RURZamp4WXVZVlJVcVpJcU10Q3o3?=
 =?utf-8?B?Z3hUMndxcW0wbHF5Q2FmRkhQaHJONU4rbXcrM0ZVQzkyRk14a1gwczlJWWJh?=
 =?utf-8?Q?APXnVNTalJbUjF8VbfblarS15uyAc1N7Fu0vE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RklSQ01uTU5lQUZHNkVVMkIxa1J3Ly92emJkTzJxTUtkRkROdVkyOTZnUlNJ?=
 =?utf-8?B?a2NIc3Zzd3dKYXR6Z1U0NEJCSXVFSnJzMGZtbGt2eDRIa1c1YXp0WmVIWVJF?=
 =?utf-8?B?cHBmZzFjZDRlbzB2a3RWUHR4b0ZmbXpsNmZZSUpCUXVkcnVMMnh5cWh3K0hn?=
 =?utf-8?B?bS8zemU4bEZkeHNsL2NOckZXVEFETktMYU1TZXdtb0dmOXR2WGJELzdCZEQy?=
 =?utf-8?B?eU13T0dHNFgrU01xYjVzRlZ6Tm11QVdDNmNqY0pjVmNGeWhvcFQvTGJYR0V4?=
 =?utf-8?B?ZTAwSzFxcU5MQ1ZuRnJUbVFMUGhnNGpwSnpnVUJqUHEwNTc5eUVxQ2t5WjVv?=
 =?utf-8?B?bUdwN0p6Smo2R2IwSTRmZ1lsbDVpblV1Ny9xMHFZRDQ3dnB6VnB5b1N1b3dF?=
 =?utf-8?B?WHJ0YVhjRWxyMWxRRnVFRXErcG9JMC9DZ3NYRm9ySXZRdE9jdkhFbFhlVHFi?=
 =?utf-8?B?Q1RzZkE0eTZtSlZ0TlNpZmpIVlRNR1JpRjVUdnpDeDFNbTREeENoK1VURU1t?=
 =?utf-8?B?ZnU4TDVLR0tpcGNOVHlXQXBZYU9WNytSaU1WcEpiUUtaUHZvZGFyUC9aVFIr?=
 =?utf-8?B?UHpiQkh0b1UrZy9aRDBIYjF2Wjl3SVBaSW4yOUJzR2k0ZmVKQUp1dmYyZWNp?=
 =?utf-8?B?bEZqTjBnd2VGeHRBVTBEVjIyZzcwRTFJWmgwVXp3SExObHpFMUJBL01XdFpH?=
 =?utf-8?B?QTJaTm1Wd2g1R0dDSnNBZnBZbGNYa1hTNEQ2OE9wTGMxTE44ZVZqUmUyRXlv?=
 =?utf-8?B?TTcxN1d4UlhFb0dqY3RvRHF2ZmVYeitBNVdUT1hlU2xQamV1K1JjTFV5TmFD?=
 =?utf-8?B?NDBqQ2sybCtOVFpoZDArdUdVTUxuWnZDQTRHWGdmUDg0R2lGOWlyQUFZbGNW?=
 =?utf-8?B?ZWI0MlNiK1pFWkppcmYxdWY5ZHRzeU8wWWYxZ0g1a3VzNHIwMGIxQW9wY0Nr?=
 =?utf-8?B?WWZEVUswdm9YNjNTRHlRR3FOeE5Nb0QrMEh5T3c4VS9KYUlCbnZ4cTFIcVdl?=
 =?utf-8?B?SVBFS3IxU2hxQzZDblhkUWdSMS84cWtkOTdwa2I4RkVVQmIxV1ZIS0h1N2to?=
 =?utf-8?B?WDFsczRuSlRyR0lPQTdKQ3JrdWNyMFdUajN6V1Fyd0VidnM3M2VWTXUxNGJh?=
 =?utf-8?B?WXRyeUZsczlsWjdyWGI1VkhIVFZaNlR6d1YrMVQrRFc3UHBzZmFlZXNRakZu?=
 =?utf-8?B?N1lNUnVkZGpQdEJWM01RSlk0cUZIUlNqUlEydUYzb1ZDblRNS2lzTmFTb29X?=
 =?utf-8?B?aVQrYXIzczRmc0VabHhkWEwxODE4SlQxRlFoNndwSm50YjVqVjI5ak9SSW9w?=
 =?utf-8?B?Qno2OHJ6SkQ5OWlLeEpUYy9pVnVlazhyK29xMmRxWmtBOEFDSHQ5YkVPTEFQ?=
 =?utf-8?B?elZXMjV5NE5lOGpPc1VzZWdPcnp4Wm10VVlPcUdhcFZLWjFWRGVkVmFXQTZP?=
 =?utf-8?B?MGpNU2l6SFM2WnNqd1NXb200eUduUHlwaUhzTExFMjc5MkhXcVR6bDNRdWJj?=
 =?utf-8?B?d2hGTTQvelc2T2VMeHdBMEdlZGlZaFBRNUxHOTdFS0gxN2ZlbGR0ZnFNNTBG?=
 =?utf-8?B?b2VRZzBnTzU2Sndva1hoN3g3YkUxaEd0c0drcWdWSVRIaGppVVJ4QytWcnVi?=
 =?utf-8?B?WVpuUkxsNDQwWWpxckYzMUt4SEdhS3NXWkUxU3JsRnY2SlF5VFNLWEV4T3pP?=
 =?utf-8?B?VFRHSzdQSU5od1FOdkpKcW8vWjBiM3I3NnNOUzRvZjluYm80K29TTmQwc2VZ?=
 =?utf-8?B?UlpsM0ZZYmdSNTFKUEJYZVBFcUM5U1RKV3MxZFRDelRVa3FIT3VRM1hYcUV4?=
 =?utf-8?B?VXdBWTFUcHpWSnJGNTF6aGQ4NXNSWEFJVEI0YVYycGE3a0NodldCSGJnNWhZ?=
 =?utf-8?B?M2VEbjlmeHUwQUJPaXZIWkRnMks1ZzRuVTNzVXRhMThieDZ5ZVJrcUQzZmk0?=
 =?utf-8?B?VVNJVVlkSmloMmNIWXBjNVRvQTRkQzllckxZazdSaTNKRVgxUXRReFNYN0Yr?=
 =?utf-8?B?OVdVeHVGeDdrcFhoRmRVRGJoeFhpN0NKUDNtMmxpRm5YVmEyd2ZLazhpci80?=
 =?utf-8?B?VWVIREZ4Z2NNMnpkdDcva1hTbkFyclVSRXdLYVpNWkQxM25CVC9NaEgzNFlS?=
 =?utf-8?B?djQ5TmdySEN4aGdzdGNZTW9sN2NDM0c2SCthdEFqYjhBbUJNRkxRMnN5R0th?=
 =?utf-8?Q?2EbprTKGjieQFifOQ3iJe/I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a4ab9e-6c8b-4f9c-e279-08ddf149dc2c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:42:48.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9SCSSq9CIdnXc59M/xF7nxQxcocsRUFvndJaqmQPDBIWzMTGOFG3jmfIlwhBZ9egSc6+aRNmwC/NNF62hFefd0FJV/o7v/xsk4PER48nMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11226

On 2025-09-08 18:59, Thomas Gleixner wrote:
> Guard the time slice extension functionality with a static key, which can
> be disabled on the kernel command line.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   include/linux/rseq_entry.h |   11 +++++++++++
>   kernel/rseq.c              |   17 +++++++++++++++++
>   2 files changed, 28 insertions(+)
> 
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -77,6 +77,17 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEB
>   #define rseq_inline __always_inline
>   #endif
>   
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +DECLARE_STATIC_KEY_TRUE(rseq_slice_extension_key);
> +
> +static __always_inline bool rseq_slice_extension_enabled(void)
> +{
> +	return static_branch_likely(&rseq_slice_extension_key);
> +}
> +#else /* CONFIG_RSEQ_SLICE_EXTENSION */
> +static inline bool rseq_slice_extension_enabled(void) { return false; }
> +#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
> +
>   bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
>   bool rseq_debug_validate_ids(struct task_struct *t);
>   
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -474,3 +474,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   
>   	return 0;
>   }
> +
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
> +
> +static int __init rseq_slice_cmdline(char *str)
> +{
> +	bool on;
> +
> +	if (kstrtobool(str, &on))
> +		return -EINVAL;
> +
> +	if (!on)
> +		static_branch_disable(&rseq_slice_extension_key);
> +	return 0;

as pointed out elsewhere, this should be return 1.

Other than that:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> +}
> +__setup("rseq_slice_ext=", rseq_slice_cmdline);
> +#endif /* CONFIG_RSEQ_SLICE_EXTENSION */
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

