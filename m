Return-Path: <linux-arch+bounces-13712-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF168B91878
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FF72A002A
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 13:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA83093B8;
	Mon, 22 Sep 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jRuYDY/K"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021101.outbound.protection.outlook.com [40.107.192.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32F26FDB6;
	Mon, 22 Sep 2025 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549330; cv=fail; b=AZ4jQy8hqh3w34P5Zj4wcJNMNLAyuXArdEpKjshyZzyCr+NBcSBac4+yP/PDcsdTi9agnOxSK2ccsT5at5CTDI/UVMFXi+cjn+OQR3Xb5VtOpwMloQvx83MSR/vPnN0d1T3XgxBfFJcqvvoCmwUlG4oAatCvXW9BVo8Yo+xJMew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549330; c=relaxed/simple;
	bh=leiWUZQ1SJJHkFcw1nc4vPb823DxH+qsXWwJ3jCBMIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lut4fT9t4tR9CoVucJnEswc9Qo30XuWt10S3nmBlLnWFXJiu+jOZk8u7mb3NqFBOIxNoO2zUJbwi2JTSA3z3ebDTruU4IQzu/xG4MoQravxvsyFVGfkCa1de8VRKGSIPvltvzjO87MjSiiy52JkE3YoeQh7B2YuTJidstrQK3j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jRuYDY/K; arc=fail smtp.client-ip=40.107.192.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph0DFdGhjlhVGFuMsCe3KZg12d4sxIQ4El+Wn9NyCBG2f/gTBFXZcWz2THUQ6lDfm6ENxOZpvAYLLw8d0NIkAlI24YlVdOv+5msm4GNACEajtsIgg5DX9wCJDXn1O7FMa1PBHKdj53jC5c1+UtYZoDgsZYS60RKTMq4Kto2HQicWwjDAG39EqY0Jtg2syHF43SjMlMTjmsQ8Kn/EW/9mUV1SUucy+XBCR8A8wIMD6KRGrpjBOCOVKjSP+kayizM5NW2ZXMD2BhGTJ/VzKSXoXY83DhZNPVWV8eXum8+MpnNr967r7GFRo08gR4RD7Pojt+4Lp9hEUf+WkXodQvOb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRBV0W3geP81RStYLz0/6rqybs8mfNFhY4tltuuhi3w=;
 b=x2HBF4cC43EnHLJsZ73M10FBmdbRPoXMPun6nVrbc0kPWTxKV5zBWzAtl5GxEAGjDMxOQwycmHK7x3Pu6u2Uz+N3Z36dD7yxT5arK5H96VaaY0wOFDdWgrmcCegoDQJO7B3bmVus5iOVbcR9gdCq5qxDDO5lncYRD9kENByr8q3/VXgyEmP9R58K74By8zCIpM4dyVcVI2hGLWz6r7Ah+6U2kQ+XU3L0tRGd14vC2wp9hj4DtQKdBb81DONhjDbEp6KBpYy2d3WsRZkcH/ZKVXlvIUuCVrqqJy60wfX7eeurUZe+8GWQoZkLYdbGcSRdnHmxEP0awysAtHbuvXXpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRBV0W3geP81RStYLz0/6rqybs8mfNFhY4tltuuhi3w=;
 b=jRuYDY/Kct4G1v8uOfhG4Ebb0hCKNZuDKjB0ng+YQ53SBP7J7jERODGaXm6jzUSZRv6tEVHRe40eTX2z0iD7aYjXsavO/5XxPWBTud0t40gaBUOsD5NUYLKJT9Wl+nn+lcT9zCmzard3NZsJk6W9zYJvoc2xbrQ5TEol3BrYTVWQYqeRmEF6aZiPwQW+ZF9V0uAkxkfz2U5K1td8WN8aak4S+/4VpYlHQwOgZRTvkM9g9Wr7HKB0wCZsCnn8vSCZ5Xw6Dea4nYF+fnvsxruDTH3g8QY8hDSGLwShvf79qNlvMwWy4VExfZ5XWbEv+BUpEKloFLiYc4SUjSFdOBX7jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by QB1PPF0A0D85274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c08::210) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 13:55:08 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 13:55:08 +0000
Message-ID: <d4b25a25-f336-40eb-b9de-3e370050b60c@efficios.com>
Date: Mon, 22 Sep 2025 09:55:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Michael Jeanson <mjeanson@efficios.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
 <736A5840-3372-453F-8F78-5861AFA0F140@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <736A5840-3372-453F-8F78-5861AFA0F140@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0354.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|QB1PPF0A0D85274:EE_
X-MS-Office365-Filtering-Correlation-Id: 49c8b39a-8dd4-4f5c-901b-08ddf9dfa3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THBZd3FlN2o4aVNmVXNSZENFNnBSVFh5d0FOdWVzYVEzZjdnYlREWFJvM2tH?=
 =?utf-8?B?VG9RZG8veEhsS003QW5qUkd3WDBPV0FuOWZ5S2dyL1Q0RlUyaWR3MGMzOW9H?=
 =?utf-8?B?eWZERnkyaUhUSkVpMk9XVzRseTIyQWlXRkJBblRGYytYZkxranJ1REJmcUhj?=
 =?utf-8?B?WUh4WUYxdERyMXh1WEdxdWo1MHp3RFV5dUxRVHNBTjNLa0ZaRkZHQU9lMlZB?=
 =?utf-8?B?c3IxWDY5Q01qdGVMc0VaSlpOUXNrRWpMd1IwMUVtUHdIaVlFcTBlWXBRVGxQ?=
 =?utf-8?B?K1dKdWFRN1FCNkFMZ2U1dDc3T0dDWU9pZTQ1RUg1U2tkODh3d0E2dksrekhu?=
 =?utf-8?B?cVA4VGh5ZXg4c3dnN0xqUW5rajdSQml5VHAwcDBXSmJBSlBSamlieG1LR1Bz?=
 =?utf-8?B?MnRla2hlZFBJelZvcGhwR1NnQTRhZEk2cHZFaTVncmxmZTErUHU5NTU0VnJV?=
 =?utf-8?B?L2l5VzVHb2phaHRSVUVCdXpuSUlTanRQNEVyL2dLdG5NODhvWkNjNDBQamw5?=
 =?utf-8?B?T1NBbGt6bkNXSnhXdlFpS3BvZ3F4cUl2cDhsSUE2ZHlIRG1LakpZTG0yV0Zk?=
 =?utf-8?B?cGpQTnBsWENQbng4cSsreWExbytWNEh0cnlZTVc0NytQdUlCSW9keERRcmZr?=
 =?utf-8?B?anBZbXVWU2ZrajNRQ21zRGFTUXFtZjVnRGhmSnFxNTc1UjZzMzdiZk03L0xZ?=
 =?utf-8?B?b0VObTlibVpXeUxIMTljMXlmNjc4OTFmaGFJc1BIbTNDZTRLQ1A2TXk5bERF?=
 =?utf-8?B?cXF0SUdrRXA1bGpKeXNoTnI1M2ZOL3UvSHRlR3NNMmQzTjBMQzJ2bzN2Q2ds?=
 =?utf-8?B?T0NUb0kvTmRPNUdrVlM4TWZ6R3duaHl3ZWtUSEg1RU1GVW5vRkxYYjhyR3NU?=
 =?utf-8?B?dzJQelRodUFjWEFDWDJJNXlhanNYNXkzYWh6T2Z3dHNld2hwUHBjSzBXaXVk?=
 =?utf-8?B?N0xOazhCTW1PZ2Vja3l1UlBlbk02TG91T2NHUER6RGlNdnRlZmZHdTlQOU42?=
 =?utf-8?B?ZlVpMXQ3WE1yVFEwdVJRNjBYajh2Ym13Q1pyVEJkSk16ai9ZNVhzUHpGV3BX?=
 =?utf-8?B?NTJDM1BSOFc0eTFqRlBBc0Fmbk9lS1lCWVBpR1RXSXNGUTFyU1RISlZuZS9i?=
 =?utf-8?B?MlZnVklWZUluSTlVSXBxLzhKbGVFa0FNcVI4QzVRRjQrSFdpbG02VXZHL0NK?=
 =?utf-8?B?aFJkRElBOGRaVWcwU1IxQXVxd0FZcGNaaFQ2YkgrQXhJdjBqZkoyU1R1RHVl?=
 =?utf-8?B?MmxRYmVabmxpblRHcm1Ra0YwWUlzbXRRYkp3M2tYR3BaQ1hpamtObzI0dHZL?=
 =?utf-8?B?aGhRYUtZMGVGamJGc0UwK1J3c1lkakRJVlBEQTBFTmcxdlY1aFkzZm12bThr?=
 =?utf-8?B?NTVoek0xVDdZT3VrV0N3MXZrYnJRbldwTEZjT2ZrQ0JsVHZvdzVoK2lWMHcz?=
 =?utf-8?B?bFFvN0ZvQXBiaGhzQk5MUU5mK1VRV3UwTms1Yi9tZ09VeUViNnA4TTMxTVYz?=
 =?utf-8?B?U2ZlYlErTHI2TFZOcWVpbEU1bnJ3NTcyZmszWHJ4R1I3NE1EV0ZRdEtGc3A5?=
 =?utf-8?B?V25CT1h5YkhSakR3YWgzeTdFeWNUQkdwR2Z4amh3ZW9OWlZraW5KSWZuKzcr?=
 =?utf-8?B?V1RoZ3Qyem5FSkRpNXZsYTBoTXoxMkJpS1hzRVR3NGtBSlJHREQ0VDREajcw?=
 =?utf-8?B?TDdLTXYrV3NqRzBQZW50VWRzTlNVNyt1cHBOZlRsWG8vYnRaRS9aS0hnZkN4?=
 =?utf-8?B?Sit3L3JORU96aFBta25QcStvbmI4TWFZa3Bid2VDWjE3QnRrQmJKeENWQ1lv?=
 =?utf-8?Q?J57WUIz0D/FQqSlWAhMAozLzbktX+KAFufm4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SitsejRNQStsNUlpMjkzQld6L2o4blVneUFLczB1dE9zU0swcFJybmJ0Wmd3?=
 =?utf-8?B?TERaVzNxeXRiU2tjVWwyM1AzMllDZlFCd3J5R3A3clkwbklESFUvU1YzS0Zl?=
 =?utf-8?B?TmVXT2dDQ3o1b3B6Nk1sSTVucTlwN05QTDhKd0cvY2V3RFM1TnRGU25yQkk2?=
 =?utf-8?B?ZWRsTFAwbzdMZmlzbm1lOWYxbE5vdzh6UlNCSXc3UnVwTVExV09qVDh6K2U0?=
 =?utf-8?B?ZU1NdzJrNmhwazVDc0g3c3RWVStvN3ZaeURZakxpY0V0K0VPcC9BemZ0UHVQ?=
 =?utf-8?B?QU9pa2xNSCttK3U3MEdVTFh3Q0JKUUthYm5SV2VzL084ZDF4TnpYcFN2TElK?=
 =?utf-8?B?RmdQazFRWk5jamFxbVN6SDRsZE5udytQYjNDcGpvK1NtOFhMY0hhYlpNRFIx?=
 =?utf-8?B?MFJXbGhQaEUvall0VEdvWkdHSy9qWitlaTRyOVBJSG1QcVY5NXY0eG9DLzY0?=
 =?utf-8?B?U0dJMWNzcFZXZENHYjZjbjBmSHNlR3RSblV6bWEwSkd4Wjk1MSs1TFdQeUll?=
 =?utf-8?B?K3gvVTVyWFVJZzVlZ1RpYlpYTytIZDdXQi80eWduKzRUVFBCVTFaR1hybUhL?=
 =?utf-8?B?bnBQVnJwY0hPZVE5VERZd0xEb1o2RXIzREgzL0owNDgva3hST1NDd1pJQzc2?=
 =?utf-8?B?QjdFdG5LWXZRT0x5Z2RVOG8xd2hMWDZhTDFhS3VIN0d1MS9kL09VaEs1bEVj?=
 =?utf-8?B?QVkyTENHUkRuZjR3V3RxNWc4d3QxTlpLcWVoaEJwTms1OU5QQWhJU0MvNy8z?=
 =?utf-8?B?WkRFUFVrSDdnb0l5L0xuL0JhR2ZDcEthZ1JJaUoyYldkV0ZnRUQrRkd3RUNL?=
 =?utf-8?B?Znc0ZmpKVW05WDl6MWNJb3lmREpBYUJYdVNkUVFRN3VQVnZqM2h1YlVxUkgz?=
 =?utf-8?B?b0FDWUJGb1pOTUQ2SnJxS1pHQ1E2NHliTzRCeXovOWhlSDdhcVY5bExHLzNW?=
 =?utf-8?B?RnhtWVcraUdzQzA4eUMwaUhaWTJNRXp4K3VDYktZcmJjaFFpZG55cjVRT0w1?=
 =?utf-8?B?ZTl3VG9rVG5kMzFIWXkyTXFYd21TU2p4dEQ3bWkvaVpuWWtQM1VtdnZYcFND?=
 =?utf-8?B?YWJxSnpVSkptaUpBbGVVK1ZWUWc1VWMydnhnWVZTQURJMGk5K3QvUk5XaEt1?=
 =?utf-8?B?VExFVU5OT0ZLRFFFYjdsdUpQTXFRNmtiam1aUnhQRGdkcS9NWHpNYmJjVW04?=
 =?utf-8?B?ZWd0Tnk3ejA3THIwaE1BNmJpb3BaR21YVWxxU1cyUGZ4Nk9XUmRGdVd5WUsr?=
 =?utf-8?B?V2tRSXA5SUtCMGhsWm00UzdRT2JuTkJuaXY4S2tQQldpZHp6N2VDQ21MQlpH?=
 =?utf-8?B?YkU2WDBpY2RFZW9SZXh0M3JUVFdTUmtQUXREY1J3UHlFaDdtQkFWbzhFOU5l?=
 =?utf-8?B?MHhQdGJNdWJtSzlXaERFV3hrY1I4T0RxRHdCRlltVVh5ZFJNRnF2N2NZRjFE?=
 =?utf-8?B?VzQ3OFlUY3NJelRYKzN6em5LS2hGd25MQ29nVFdRUzRaVytZUEhYalpheldH?=
 =?utf-8?B?S1o3T1JIZGFiczFXVTYrKzZqV3l3VlppaUMvWHh1bU1Va2J2TW5XT3N5ZFhN?=
 =?utf-8?B?M2V2bGdjNHlBd01sa3Q4aGdRQVRWZ0o2bURDeXZTYkVwbVJabC95TnpxaU9y?=
 =?utf-8?B?Y2F2UmFkNU9adkFYVjgrUk43dE94dS9BdGZTOHE3c200YXZ6NzN0M1loMHlw?=
 =?utf-8?B?YWIyT0w3WlpiSktTTkVVNk5WdktvclNDRW5maWxFdmJVcW83bWszc3ZMSHRX?=
 =?utf-8?B?M3NGTms0ZEtvMWZrODM4T1d2c0ZaWmhzY21Yb2xyR0Ywb2pzaEhDaGl2Tmxu?=
 =?utf-8?B?TkRyai9nVVFkemlFR0IxbGswOGthY1hpZk5Md1B1SWVNZTBDTXZaNmFmcDVr?=
 =?utf-8?B?d3V2YlJ6YkJyYjlJYVNaSWNHN2NxNDM0NG12TGZPS245RjRDMUdPNVJIbHBX?=
 =?utf-8?B?eEJZb0piRkQvUmxFeGhGMjU3NWVybjJsWnFIb20wbndScU81UmJIS3phekJ0?=
 =?utf-8?B?M3ZrbkJxY0tEQWlnT005M09iYytTRDA3ZlBTSVVlZ2ZLU25pVWVLUXlWcEpz?=
 =?utf-8?B?SGZwMFVCaXA0d0JUSDUwZ21pRldySHdDU0ZKUmxUdnhlejZqSitSVjkrT2hs?=
 =?utf-8?B?V1lkSjJGWmhXenRwR2VkL2d1K2hGbzI1dDBQNktIOFdVSTF3T0lJZUc2Qldx?=
 =?utf-8?Q?7OM8by5IB/YsTwDVjXzpXFE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c8b39a-8dd4-4f5c-901b-08ddf9dfa3c7
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:55:08.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97vnd9WZvjqOYZUKHpeVdYpw6+M7kH1NKdLk04si/tYKdnqRKEWQgvl6ZxtKZgl4DWB6w8DpY9fWvFSXtdwSo/V4JKlCIlqtTnZVdfFXjMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: QB1PPF0A0D85274

On 2025-09-22 01:28, Prakash Sangappa wrote:
> 
> 
>> On Sep 8, 2025, at 3:59 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
> ..
>> +enum rseq_slice_masks {
>> + RSEQ_SLICE_EXT_REQUEST = (1U << RSEQ_SLICE_EXT_REQUEST_BIT),
>> + RSEQ_SLICE_EXT_GRANTED = (1U << RSEQ_SLICE_EXT_GRANTED_BIT),
>> };
>>
>> /*
>> @@ -142,6 +164,12 @@ struct rseq {
>> __u32 mm_cid;
>>
>> /*
>> + * Time slice extension control word. CPU local atomic updates from
>> + * kernel and user space.
>> + */
>> + __u32 slice_ctrl;
> 
> We intend to backport the slice extension feature to older kernel versions.
> 
> With use of a new structure member for slice control, could there be discrepancy
> with rseq structure size(older version) registered by libc?  In that case the application
> may  not be able to use slice extension feature unless Libc’s use of rseq is disabled.

The rseq extension scheme allows this to seamlessly work.

You will need a glibc 2.41+, which uses the getauxval(3)
AT_RSEQ_FEATURE_SIZE and AT_RSEQ_ALIGN to query the feature size
supported by the Linux kernel. It allocates a per-thread memory
area which is large enough to support that feature set, and
registers it to the kernel through rseq(2) on thread creation.

Note that before we had the extensible rseq scheme, glibc registered
a 32-byte structure (including padding at the end), which is considered
as the rseq "original" registration size.

The "mm_cid" field ends at 28 bytes, which leaves 4 bytes of padding at
the end of the original rseq structure. Considering that the time slice
extension fields will likely fit within those 4 bytes, I expect that
applications linked against glibc [2.35, 2.40] will also be able to use
those fields. Those applications should use getauxval(3)
AT_RSEQ_FEATURE_SIZE to validate whether the kernel populates this field
or if it's just padding.

Note that this all works even if you backport the feature to an older kernel:
the rseq extension scheme does not depend on querying the kernel version at
all. You will however be required to backport the support for additional
rseq fields that come before the time slice, such as node_id and mm_cid,
if they are not implemented in your older kernel.

> 
> Application would have to verify structure size, so should it be mentioned  in the
> documentation.

Yes, applications should check that the glibc's __rseq_size is large enough to fit
the new slice field(s), *and* for the original rseq size special case
(32 bytes including padding), those would need to query getauxval(3)
AT_RSEQ_FEATURE_SIZE to make sure the field is indeed supported.

  Also, perhaps make the prctl() enable call return error, if structure size
> does not match?

That's not how the extensible scheme works.

Either glibc registers a 32-byte area (in which the time slice feature would
fit), or it registers an area large enough to fit all kernel supported features,
or it fails registration. And prctl() is per-process, whereas the rseq registration
is per-thread, so it's kind of weird to make prctl() fail if the current
thread's rseq is not registered.

> 
> With regards to application determining the address and size of rseq structure
> registered by libc, what are you thoughts on getting that thru the rseq(2)
> system call or a prctl() call instead of dealing with the __week symbols as was discussed here.
> 
> https://lore.kernel.org/all/F9DBABAD-ABF0-49AA-9A38-BD4D2BE78B94@oracle.com/

I think that the other leg of that email thread got to a resolution of both static and
dynamic use-cases through use of an extern __weak symbol, no [1] ? Not that I am against
adding a rseq(2) query for rseq address, size, and signature, but I just want to double
check that it would be there for convenience and is not actually needed in the typical
use-cases.

Thanks,

Mathieu

[1] https://lore.kernel.org/all/aKPFIQwg5zxSS5oS@google.com/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

