Return-Path: <linux-arch+bounces-14441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C50C26C1D
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 20:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 842374EDE4D
	for <lists+linux-arch@lfdr.de>; Fri, 31 Oct 2025 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88829DB64;
	Fri, 31 Oct 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pUFoeVu6"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022110.outbound.protection.outlook.com [40.107.193.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FD92BD5A8;
	Fri, 31 Oct 2025 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939076; cv=fail; b=GP8UrUtrOUgHhlQcHQJX3H0JZIAa5BDOP07uHUZwjxxj3tMlU9uuNXNmNhRtz7GCD/AdwrI6yYLT+2mm08zYxmwX2lDprwgvYaCKTwRJu9TGYcARb1+4VmYId0HrL5NB8xG0IDa4XdpApWEh8LMzdKyFRzaBLcDnKhS+nZWLNig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939076; c=relaxed/simple;
	bh=RZ/m3Z00nHer6+AWMpItGbL+vdw4GNRdP8cXQGqD3xk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gUvUy+lbTxj8Iih2XagPbYKBlrgxpxovvd17AA4uE9U1H3pfR68kGb+uW3C1sgzH5doM46dNZR2iUNz7Q1D2YHGe+4wOwlhjWbla0rCEJXeG6CKhyh4mQeHOiRZ4W6+anN34C4ZCV+cdmORy1l/zyMpHpvPcYJzCpElLE+Fdhz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pUFoeVu6; arc=fail smtp.client-ip=40.107.193.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mwxcZKXa4E3p8/hqTHQWhUWd0ymdCks2mhPlvgOSD5KnGWmdevuzJeMGIyuYN7USnPLLdOxZWQ2MRLVM8pqhmY68t3Mb/lKM/mNHIpo1+iUW53IDR1toTRf/YbX6fTOmq/bHDvqaZ2ruBjxBq17CPtuArZWScGf8HTHJKLa0K8I3ulFp4rIZezcYkhCrp5sZflq6f58uG1vcr/tZ11NUNivJJxJh7LzSfluPKvvRt/XZPfMwtIrBlkxZKHGaqJeBLbqubsUWQwwErkZB1xK6hs9qWW1VZ8VFRxgMKP5PRkppQk+nvJ2PfcN4QPp68DO3uoEI2hGj8aMZiqGxYA5G4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqC0x1H9c+ne5b46uLb3XTtTo20Wsihx/j3iur69ht8=;
 b=pv8ZtIxxrvyxZPPpZYC99bXUmleGrCG2UxYN04G+Ab5RokvziiLymV8H9SFnIHP8v39GBpDFG9fIge8uBHD//BadrHCDNo1+/I2bOZLS4Y47L8tZtIchBrDGiHt0ZmgJAyNIpBMcZtki6sYcugi7b9Ybxi48xzmgKEgDqVLVG4Lhu1ouT2QxOFVpHP9tlj6dSm5jHk1iSXifovXPNgIg12P/KLZX6fvJj5ON95QKGq8ywSI5QKS3bKb9B3CIUNSKBZKKuvzWIOMLfD0GxXQ5oO5At+MIfg8IDqGeQtNXcUjzijNOK4MdIgEX99QZ+4f0SOg8+7Z/cbU/WIiWH8u6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqC0x1H9c+ne5b46uLb3XTtTo20Wsihx/j3iur69ht8=;
 b=pUFoeVu6r7LJv3W/gdcjQfxJBoFtpVB/C7dMgTS3LS06gKndDtewEk0vrZL5vr9A/ypGp+8cBGDaSFozPjOOX2mljvVlibTCkBHdOevLEARymexL/+O7gt2BzGW9c0bRH0YG2VlYSbui36vApb7Kqw+FE0DyTJ7aTBchYgsLTR8EsnElp5xLzr6nKQ28BHj2bsEfRKIM2bqBsjalGxmaSBUdfn4KeTWF1sbp4EH6DrGHQphpHkvXlxSYFQ6KI0jh6RcJsMirZAVpKRwUCvexL8gtUYQkSww17pyvfxdUM56X5AQv+O+YkWCt/NBz1g3DCps9vKJf3CEScWPztcTLOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9020.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:cf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 19:31:11 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 19:31:11 +0000
Message-ID: <7e44ca0b-e898-4b7f-aaaa-30d8ac52c643@efficios.com>
Date: Fri, 31 Oct 2025 15:31:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
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
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.542731428@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251029130403.542731428@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0319.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8b8d2b-64c2-40b5-6e97-08de18b40c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NndBTVF1c1RvUzAraWdicUVBZXNDMm9Eb0l6d1Q4Qmp6dnlnV2FRd1RrVXVK?=
 =?utf-8?B?bTZSZkV5L3VZNUdJaWZxRFBwbCtjb3ZTZ1BKeWl0ZEVoSnJXanBmL0VzQ00y?=
 =?utf-8?B?cjRXcEJsc0RVanFpTmF6Z3haM3Z0R0U2cW9RNnpVQ3JjSFZuMHYvd1pnRG4y?=
 =?utf-8?B?Qm40bmROR3FYaElVMm5DNnJKcUNvV0RZRTdOeDQrdTVtek8wRWFMeTlFLzZj?=
 =?utf-8?B?Y3hUQkRhWkthTkVkN0xLdmYvcEppWEYyNXM5Tzg3ck9BWU5rVVFwbzJnNjlE?=
 =?utf-8?B?NzJiS3JjemMxS1dPNWRpMmdxNkEvM2JzVWdKalAyTElSTitQMnJYRXlzUDg1?=
 =?utf-8?B?RGZwTmkzYTllZXZ0SHdLTld6Njd2Znp2SDBoaW1kOFVaUXVKRHN0OTVuZngw?=
 =?utf-8?B?eUxReFRiNGFyczdxT1FSZS9MekNJQTFGekhWY3dBc0x5d0xEVk9VMWJPZ3dZ?=
 =?utf-8?B?Y0NxNkxTNmNaSkNWNTRUNXI3Y3VYWFdldEo3MTZadjNKelIwaC8ycktjQkRh?=
 =?utf-8?B?UDcwVThtN1dLSjVUL3BUeFV3c2VKNFMzR2drUE5QYVFFRVovcllKeW1qaGZt?=
 =?utf-8?B?U3ExY2dmMHM3dktPRStGbi9MKzNvQTJUWTNtaDk1aHhKbjRjK2FhZGRmbXpT?=
 =?utf-8?B?cUk3eGd0cklhWituaUJwZFpWVlZVU0EwZlJGTXBBMWFyQ29mZXljZXFDd2hY?=
 =?utf-8?B?VXhaWlhMREV2RERTRi91bEQxRTltMHB4a1dSQ3dYRk1XL2VyeTVjZkdNRzVF?=
 =?utf-8?B?WFR6SlNXejVjTmt3NFlwYjBFbnFEdFU1VThzangzcFpUcS9oMmdnRHIxWGw4?=
 =?utf-8?B?UGVZK3owN3NRNjRKYnlDRVlYM21VRHBXaThETGJ1dEw5NVQ5eEV3ZkhiRWp2?=
 =?utf-8?B?VGJadFR4U1krbTdqaVBaMzZGMGhwNVN6MGVLcW5xYmpuSmxFeFNmOGp3Smk4?=
 =?utf-8?B?eERxSTJncEhKUUxRTHQ4YnJIMVY2Zk5sUENick80Z2R1QmNXOWp6L2llR0NU?=
 =?utf-8?B?MEdVYlJ6WDJrTHc4bndKd1FIcyt1cVJXTjQrbzl5TkN1amZLNk5sZHQzRFMv?=
 =?utf-8?B?S0NySGpJVllnNjNxSjJYQ0pXem4zQmxEcmFYM3d5Y0dPcVZ5YlBPQjlJVDZF?=
 =?utf-8?B?UXhSVlFmVDlBNURwSEJxM25pOWR6UmxnejdIODlvS1MzTk0wbEpzWUhCblVW?=
 =?utf-8?B?dVkzNzNpWXNTRStHL0NCaTFCR2s4d0dIU1pFYVZqYW1PbjE2UEZia29kdGhl?=
 =?utf-8?B?VnBOK3FKTElmQ1Y5ZGJWakYvTmp3RTkrSmd5L0s4RkwrRG14ZTZaRXdFa0R6?=
 =?utf-8?B?OE9mVys1TG94UmJ3bmQ3WkdHTlhuTi80RkFVUHM5NXBSak55RWh2MG9wa1pN?=
 =?utf-8?B?aW1wb29kL3dOa3ZudHNFSlFwZGZJNWRNcXB3d3lEYnVXTW5qeWxYRjd4eGd2?=
 =?utf-8?B?cjNQTkhEbkZka1k0VEVkTncxY0tONnlHNUJzeTRsVFkzUm9EcEZBZlBoVWsx?=
 =?utf-8?B?KzFKa2U5VWIvK2N5TFY0eXh3L0JXRzVUQjNjV2x2QUtGKytMTGdUTm90TjJ2?=
 =?utf-8?B?R3lnQU4wY1VtRnpQM3BiZnJlUDl5a0UzbHBRVDdWOWFGTWIraCtBMGlHcjF5?=
 =?utf-8?B?cHJvY0ZyRHZnUmMwR0JVS2Y4S29RQ1pHN3g5TVRSaVlTQXdZV1pja1hmQVdv?=
 =?utf-8?B?YXl1M2daMktzSkpaUXRpekF4Q1owYXdTYTFiVEdObStQZWdKUmp4YlNHQitU?=
 =?utf-8?B?ZDZGMEMvNS9LeHI3TldqZDg0MjFFc0ZjRXl1Tmo3UEtnZVVUajB1T016Wk5U?=
 =?utf-8?B?N1kvOGJZM1RsQkV6QTNxU1lzMmp2Uk9TQm8wYnFLb25kU0ZXQkkvYSsvMTVq?=
 =?utf-8?B?VStVWS9XSXRocCtRRy9Gekk2VTlnb3RBalYrNXZjQnhVbkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ait2OHlxRWgyT0d1WFBndytiMmY5bjhEajdBY3kzOTdpT2ZMTEYwZFNMQnhu?=
 =?utf-8?B?ZFg2bUtlcTZMdjg0cWxOUVhEeE5jZ2Q2MGtHem5Gak52UTB6WXdSbGQ4RDht?=
 =?utf-8?B?MTBCa3F5UVBFVzZxK2pqNE1ndlVmaVd3RVR2c2crRFU3emhvMHBhVTh6Qkhw?=
 =?utf-8?B?QThPMVpObTZzaGhLdUhWK3M0UU1Db09leXQrd1h6b0pDNGRibGg0REkzSW4r?=
 =?utf-8?B?eXpwZWtyVFFtY1VBVGhtc3p2OEdqcGRZK0hPaGRzK1pTa1ZTN0YwL0kwbnB5?=
 =?utf-8?B?elFhdWlVZDQycFBGTzVkaDVPdUNXRUFMdWRwNlFHUHVJVHVJQ0hzN0Ntd2Mx?=
 =?utf-8?B?ejRxSktGS25sWm5kY3VUT2RORUlBQzFQaDRDUkM5NEpHWkdRZUg1d0gwSkFp?=
 =?utf-8?B?V1JEUm5OdzE0NDl3RitHcUttZ0ZVT2ZuWGVLUjY3ZkdjV0gwUU5ZTER0NC9t?=
 =?utf-8?B?bFdmeWxPdlNGSmVuZE5HZ3c3cTUrNFVNVUMxTHhPemltYlhleHFIOUJuVFJI?=
 =?utf-8?B?ejY1MDJobFVpSE5PR3Y0RWxwVmFaNFpzTHhlOThPNVl1elBkQXpnQ0pkaDVh?=
 =?utf-8?B?ZzZ2VWpvWktoTWZSSlBPbjBlcmhmQlFYQmFOY3ZaTFdYdjc1NHhrS3BXZEhE?=
 =?utf-8?B?dEtxQnBoUkRzek5XMk90VWJ2M1RsY2R5TUR3cE0zT3h0OGUvMWppOW1VcGJ3?=
 =?utf-8?B?ZU9hd3pPNTBuNkh5am5IcWlZVTk2azFNWFJkY0U2cVVKNTlyRVdUdWxkd0Mv?=
 =?utf-8?B?NTFLTndWOVd1YUhiSCs3ci9rUXdGdEIyZ0szUFZ3U1RMaG5OcE4zRUxwcG9n?=
 =?utf-8?B?YUFIQ2NEbmx4aCtqOHVRaWlOWkN3UFBxZE9FNXVsOFJuQk5Ed1NTTlUzakt6?=
 =?utf-8?B?VC9DdWJQb1Q0Y0xwSldlOTh6cUc4NXh0YUtKcnoxMHJRMWtvdlc1QXQ0Q0RX?=
 =?utf-8?B?NlFyZ2wyN3Y3QWlnandQYU5GYmdFaWNLamZIMm9oc0tjUEhLRjQyQ1BERWhV?=
 =?utf-8?B?bndKOC8xOFBvZG1OSHArL2RGWHRmWTgvTFZzRGJBS0NhK0thKzZ2T1pvczk4?=
 =?utf-8?B?QUdsYVJLWFUvUzRIMGpGYjNMYzRwNHhYbnppQjlKV0NCVlBnMkhzOGhMclJt?=
 =?utf-8?B?dTNXNE9qSzQyRmtacU9hY1RJRFU5YlMwa2hpekk2R05TTms5STdVMUFnVk82?=
 =?utf-8?B?Y3NhUDZrSGJoZkN6a0NxYlpYSmxvd2xINEkyUUErejNoZHlIN1YwbEhJWXdG?=
 =?utf-8?B?TVpjdHhMV2ZFaEJQcUFQV2RXbW80TmJmRHVBa1I4cURxKzlvaWJRL3E5Rm54?=
 =?utf-8?B?TlBRdlgycU16UUNiOXdodDFJMUh0SzJzQW9QUDZvNUlZY2VZZjZQSFlIR05x?=
 =?utf-8?B?SUdIOUJQcTQ0dCtDWmdwb1gxcitHMlJnaWtQeGk0M2tRL1Z1UlhnTTBqemJ6?=
 =?utf-8?B?RkRWVysvbXcxM0RidkNNTU4xYnRvZkNiWldnRHJ2cnJhRFBqVEVUaitYR3o4?=
 =?utf-8?B?YXJuU2RMQlpWSXlQc3N6c2ljd1BjdytvUXZtdXBjbTNXNEtvcU9GbnY2MmhY?=
 =?utf-8?B?SmcvUDJadjZWUSsvTEk2N29oS0dDcTc3QTVpUG5PbEZpb0hEVzBEMEFyMm92?=
 =?utf-8?B?OUI0aE8wNnJpdmFDcXpUV1I3SHdYNGw4d3BFWXB1SGg0WXIwUXRXaXk4bTBj?=
 =?utf-8?B?WGl0Q0RSTjhKdnJVSUIwOFgyR1JSZDlqN3JCNExyeE8waWh6ODVIcW0xOUk4?=
 =?utf-8?B?RDBhYnVSN0MyQXJRNVUrUHUvb3dRV25hWFZ1a2pwMnZVTkJYWkdMRGJpYytj?=
 =?utf-8?B?N2tFWTEvWjE2VDh1TEtBNFlRd3hjaGp3K202N0NWS2d6SUdxQVcvRFd5VjF3?=
 =?utf-8?B?Tkh6emxFMjF0WW9jc0c5enlUSVhPSTlOSlFPUk56dGYybUxTNis4ZGxSd0M4?=
 =?utf-8?B?QWlodXJ5a09rdjV3ZHpkdTZuRnI2dFhNUnlmVjBLcXFKNUQvUGVYRmxUdkhv?=
 =?utf-8?B?ZmpSMm1Pc1NDbXhmcWl6Qm1CN2xHYmxPV1JYVU42RHY3TVF1TUFHTnlab2dm?=
 =?utf-8?B?UmpRVWlPcXhaZTNlQllxT1RGVjRHd0U1TW05QWZjUXdRUXNIYWFpd3Vzb3ZH?=
 =?utf-8?B?eEJzVFdFdTJoRjlydVlIMm1vUEtoeVJHdDlPV0Z3ck5wakpOMTRqVkZ3MTJw?=
 =?utf-8?Q?A6nsMT2VnX59gdW1xr6gYSs=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8b8d2b-64c2-40b5-6e97-08de18b40c33
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 19:31:11.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0h1HH/YL3B5LYQyExvA1vozDeARLRUT2UJLZ9JXFyZBwThjJmNTZOpAf70sEMus2zw7qe4W4v3FoPixEtGJkzVL39pKwCdPmG7BNfCEIPY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9020

On 2025-10-29 09:22, Thomas Gleixner wrote:
[...]
> +
> +The thread has to enable the functionality via prctl(2)::
> +
> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);

Enabling specifically for each thread requires hooking into thread
creation, and is not a good fit for enabling this from executable or
library constructor function.

What is the use-case for enabling it only for a few threads within
a process rather than for the entire process ?

> +
> +The kernel indicates the grant by clearing rseq::slice_ctrl::reqeust and

reqeust -> request

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

