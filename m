Return-Path: <linux-arch+bounces-15471-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B4CC40E3
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C36353022B4E
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD701366575;
	Tue, 16 Dec 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KPpNp9XT"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022096.outbound.protection.outlook.com [40.107.193.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03E35CBA4;
	Tue, 16 Dec 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898733; cv=fail; b=h4kSPhNydYpPn4FMGGYazqZnXYNgOYyNMgR43+0fUXMU7ToM2mRg/rCQu/6BugaI+zRsXaY8+bT9DEGQy5MUqxaQFPyBdK+eT4Er/oTWD/Qtik98p9OWemKMFcVBy62Wu8vPj3/cT/bYY6eZiUaDL0LyTC5A6ULoruSnnwXQ2po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898733; c=relaxed/simple;
	bh=8RZMJTRBxA5EAJMVUfRTKBjGp3hs6RapZlaAT1BM1IQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDobBy1+A5Ih1FiTgWJWsZDz4XVk2B5bw1SyifnAPbOQuCH6Kjw5kpLmdSf0V0a9i3BNYFZ17YQXKkRkYIiM5sLvqooigVgoqDO8TsQMmikdAUmcfspItljMr2xe7i/qoG1lQ5Oycchj528mkaJ4WArg2F7L+6DfOh2zLNaiWe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KPpNp9XT; arc=fail smtp.client-ip=40.107.193.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+EFA9sVRAtoMjSMC1UCQtD4MyGUpmBQf8MD4YEJj1MrCnndpBGLE/SYtwDPN2tFnqTSKuDNWLLzSjlEINzxxHZfc4bwuDvItJlzrfLsW18VYpQD7qa95xKnnCAfHVFogRojGIKAjO5yvUmiL9b7ghEa3ePzEYeDE2gP+jL7EYgbwS1O/lV1gxkNs0hWnFQPd8Ye6rynBVtP58PW0hCsbdYCxl2I3zsQ/3m9IABHLUAjWasFXodj40/f2KOUl8SbXlhz+UqwWSta8qoA0/jmYSNTCD/eHb2Tkce47VFJgauD4GUN9+TA69YcGuecjJwDQ7EwZeNw9m0Zfaf28DGlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBCxYVYBJxHpmm3v+bEwbKXb+tEk11jcud9xMJsxqok=;
 b=SkfU3jreMz/7bhjbADj3wTG9qjHDwjxoIve37EJ0ow50Vds47SIwh0cQu7LDzm6MuelvUERvepy0DBgNgfIUouV8ZWuHnvW0qXjEbwNO3WrJrVrbXQwl/CIgKoU9ZZULW3MZ45dsrgFoHjGEt2TQExpPCnxCUQowCQ9vB20ZHFPddyBkh8b1N4W+bVrut60HISylnO4IleU2yrgLHr//wJvOOizbx0bphV///ZPU1Bp8t1dZY/Waq3zeIwCPUiKJ8yg35GVgL0myue0ilLV/45huOvRhj5iP8aDZ0OzuUXFssQ07WxqAFa/jxQHbMH8ZVPmKfj6cUsFnAaWqPrpICg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBCxYVYBJxHpmm3v+bEwbKXb+tEk11jcud9xMJsxqok=;
 b=KPpNp9XTDEx8GLCYBjBoytFPh2zVx2jrENNyweZvA7rBPCvvjIrxV+E1J67NItiG6G7XMPF4Peuy9VsIRK2zZnlL6kpz4J0e4qOUoGZ25HY1jLCJwLC0IvT0NvJ+yviNPwDsUW/VDqoc4Z3qOI3vW9S0vNOnADTCA01rn4z3s6Ak86anzq+RVMauGPG1PXjYtWDiykqh50byJmPssPyYfFDzLFA9yGFGfl01MqbjQu7nASy0553g5qFkl807IYBJkHwSv0FV9RKqQJlpe7TenZ8+qtONByhp/dv4IOpOrYv5evSplHUCZSWST9KPRH7ZIkwcL9h695E3k6lrPWpGgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8206.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:51::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:25:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 15:25:25 +0000
Message-ID: <0cb26892-c68e-4a57-8029-8c582f868505@efficios.com>
Date: Tue, 16 Dec 2025 10:25:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 09/11] rseq: Implement rseq_grant_slice_extension()
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
 <20251215155709.195303303@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251215155709.195303303@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0475.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: adb28e4d-711e-4245-5f3a-08de3cb755fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckc0T3AvSmE4Mm0ybCt0UytoM0Z5NWoyR0xnZzIvZWl1MnFxa2dHS1Nob28w?=
 =?utf-8?B?NXBFOTZFenlpWlRQc0RiMmRxNGVYeGRUUStBYXI4K05Gd3JISkNQbzBGWnVm?=
 =?utf-8?B?WFRybndqeGc3WkdoWDQyOUhLYUNPaEtqMzhpS2N1Mnd3ZURhMkRVN1Y2T2lB?=
 =?utf-8?B?ekhraGRHbTZQUk1kYmZNWjBnd0dINFRoRmVUcWtLVTlHbnFFS2k4elk2VEx4?=
 =?utf-8?B?UEVoeVRwcVJ1WXdSZGJRQ0c0RGpqWXVqMHR6TlpXbTZScHVrT3p0R2UwS2JW?=
 =?utf-8?B?VDhiTjdIdWZmc21GbWFEMXV1SEJ6NnF4bmtzQ2tLYTFkVUgxQVdNYS9sYkJB?=
 =?utf-8?B?dzZhd2YzS0NxS1J1NHdLUllsWDd6MHU1VnNTVVJ4RE4yZXpLY2NHNGlGWDdE?=
 =?utf-8?B?NndNTXRpSzdQZWJqYmxmbjBRZlIzdXJFYW1EM1N2em91Qk9PUVQ0Qm54ZFc5?=
 =?utf-8?B?c29MUVdkYndZeFZUd3NhZC9rdzczUDI1eGtYT0ppNy9vTlJ4aXFVUFNqbzMx?=
 =?utf-8?B?dVZPMmJydzRHQy9ORUtKamVDM0E5SmtiYzVKK0loVHoxdFFQcUY3dE04OWox?=
 =?utf-8?B?SDF0S3hEV0dKeStMZ2ViREhSQVErbDJPVkszNHRmdThEMktGQVMxYUg4NU9Z?=
 =?utf-8?B?RVkxUU9wQUVobnhBT0xwSnozTE9TYncyYkpueUhoUGFzUk1aMkZIcFJzaUYr?=
 =?utf-8?B?Tkk3d2xIbXZmK1FkTExvd3RTOXR3MHZBbEJXRmViZHZIckZLUGFjNHlEdlA4?=
 =?utf-8?B?ZkhGZnhHQmJ6UFhJS1pNTlR6T2xJazJ3MzZ1L1lvR0J3bzA2d204UTNlalVx?=
 =?utf-8?B?cWh3WHNwQTJyZjQvOTVoWDhPaFRtTFpTeVIrU0dqYXZ1RkF6V0JabUdEajM3?=
 =?utf-8?B?K1JNN0hQQ0VNczNmR3dvS2VBZGZsV1ZFdnlIZUI3VWE3L3l5S0YrUlF4UU53?=
 =?utf-8?B?MndPa3gwdFZsUjlMdUdTbnhrVW1IcFYvaG5Hci9JTE4xMGFIQ253d1hqVzZZ?=
 =?utf-8?B?MDBqUFllWEYrczRYakQ4ZFBrUnFHY2N6L1hyRUdVdHloZFNJM24zdStucE1U?=
 =?utf-8?B?Y21aMXJpMENGRTUva3ZSQnk2OHBlMmE5RkRDcjIvek5zTzVyTE5Za3lTUDZT?=
 =?utf-8?B?L3htSFFXOVU3S1p2eUhIeVhSOG53RDhidWtLY1hSTHRYbWE5YlQ1TG9lOVY3?=
 =?utf-8?B?a0JWTVkzMktzYncrM3FPc0NMeGJ2Y3lEUVM3UkNuM0sydC8yaFFwWnFGdTV3?=
 =?utf-8?B?Mm1Ec1FPV1MwRjBMQitNWEFadFB1OFdST2ZnYTlFYy94ci8ram9GSmtEcVRQ?=
 =?utf-8?B?Rm16NnJudG1Eam1SVENGQ1R6ZDNHVWxRQW1oNUV5ZDd1Tm5IdkpjeUJIQW1C?=
 =?utf-8?B?VFh0cGI3UUpVT1UyUklHYnVKRy90QytSaDJwWmRVNXEzVmw2bVBQT2JkTGR2?=
 =?utf-8?B?amZ2TWFGbDAwT3lveW9zdlp6UytFeXJxY3RiZk1oS2lOamM5bVE4Y1NSeHNy?=
 =?utf-8?B?MEF6czN5MTBvV2NqTUdWOENwbndwM01pNVlUY241Zi9rZDZUdEU4MmtzOTVw?=
 =?utf-8?B?d2tHSjBzNVgxYWdzcHVGQmg5dXNTRWlDZ2RKMWgzR3RGQWJEUlIwbURRZUl4?=
 =?utf-8?B?ZmFvbURpTUp1WGVycEVSTEh3YWJVdXFQSTZ5Q2djdWpBS2g0Ujlmb0l0YVp1?=
 =?utf-8?B?Zmg5NGI0VHNqUmlYeFkyamlpdEhUMjJxU3dsak1FWHp0dTlsc1psZEl4NU1C?=
 =?utf-8?B?Y0dIaVhiekg0SEFMVW1Ja1lrVDdMN0RTam1HQWFuTzlOMlRFWmg3TlY0Y0pw?=
 =?utf-8?B?QjRMV1JFOVhiVW1JaU9TTXNaeWIreWNGdzJMMmQ5UytuallqdWgxVmVxcUti?=
 =?utf-8?B?ZmZMTjJ2ZXNWWnN4QWpPb3ZsL054K1lyU0xLdkplb3FwcGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2pRb3RNWTV2ckptbVBBQ0IzNFFjZ3JTVFV5cmR2WGozK2xXV0NqTjFCS252?=
 =?utf-8?B?WTExWXQvZ2F1dnBmRzdNRElHTk56SmhjYVVEZmhmcGowVHVBY1dFMGhvcnRY?=
 =?utf-8?B?WXUzZXhyUWhRZWRSUytVWjJQLzluK3c0azZSSmovS3FrclN1Z0ErV1g0U2JE?=
 =?utf-8?B?V0RkQy9BQVB4WGR1MVJSSS96SUdMbmJseVFsM2tUOEhvc0RnQU1XdVlLUzZh?=
 =?utf-8?B?bUdJelNreUdLbWUyNW1xOXhRU2Z2R2xQOU5Bb2s4a3AyMTJDdGszaVlnanEr?=
 =?utf-8?B?eWVOclRoYlk1elQvYUQ2V1BIUzFLRWtwK0dlVWZkbURBTy81Tm96bldvNmdp?=
 =?utf-8?B?dVF6QjhPUmprWGN6VDlZejRDdGQzSzQ3U1BBM3c1akc1WTk0aXZPbmFhUzZX?=
 =?utf-8?B?ZUEvTmFVdFRPZ0JXL0ZRbUNscEQwVTc2c285ZGhUV3RyNW1FRzBSY0JBSnha?=
 =?utf-8?B?YnY5WHo0MXB3ZUk4ekk1SXh4eHdVNi9rUUYxRXJWNmdHNk5UUlp5YUlvN3NK?=
 =?utf-8?B?Z09yeXdhcDRzREozZHVPRkN2dXRuaUZ5TzJZcENVdkVwRmlkRHdwNkRvbWoy?=
 =?utf-8?B?UnIyNVhPYUNvNUZIM25BTVY3NWczMWxFWVdCcWQwdHJCL1hkWkdjcFAvUlNi?=
 =?utf-8?B?K1FUN0lUaER4QXBHbXlCdGtLelNaYkVQdDJEMkptNmFUS1FuVGIrUi8vVlpv?=
 =?utf-8?B?SUZxaEtEVE51eDhuQisrbis1d053elpGcFhOSFdXMWFFSmNjMUZNSzhScHpz?=
 =?utf-8?B?Q1lBdkFGN0tRRzNWTngzcVZIdkVrQUp0bmdzb2NUdDV4WkdOZWNJNWd1NjZP?=
 =?utf-8?B?ZEg3RWN3TmlJekJvN2RITVBWejYzZUYyT20yYTRsT1JsUVg5Y1BWZzNDV2RM?=
 =?utf-8?B?WDByR0RFV0pLNmtzVnYveG9jaWQ4eTc1TWwzTTJmN2NHTHdpZDMrdUdGb2p0?=
 =?utf-8?B?bS9xNFBiNVIzaE1NWmtKQ0kwdTY2bk9Ed09FNEJmTENKTCtqZkJkemJjWFdr?=
 =?utf-8?B?bjRVWncxM282WGxnbDBEZEJ0MEFZRmRZYUplU1B6dW1xcktEaGRJRzFZa01E?=
 =?utf-8?B?QnYvVHdDUll2L1djdXBQUTlhcFFrb1Y3SFRTdFh4WEZlYVBnVUZKekJXakM5?=
 =?utf-8?B?NjJ1SExUT21aUkpmTXFsWXIrcm5kZ0N4T2lUY3psb2Rpc0lDd1JNb2FKV2t6?=
 =?utf-8?B?ek1mSVFDeEIvZFZRb2NmSGJQWnQyNXF5OXhjMG10WUwvNXVVREZRcWhBTlNF?=
 =?utf-8?B?bGdMZmdCS3NzS1JOV1JHMmdYQTBML1ZadjNPNVhkeG5aK0hJenM0dWwzU2ls?=
 =?utf-8?B?T1d5UWxoeXFOSUdXZlJNMmdHY1owS1QzbjNQdE9MaC9iT29OSHVwWGVLNXVr?=
 =?utf-8?B?RzlsTUdvNlE2aUVudFdDci91YXZwUUpzc0tYb01OcDRJUy9vRGxNOERXK1pI?=
 =?utf-8?B?Wmtlc3g2K3lsSFRNaWZRMkljcS9sR2ZzZllHcDdLZi8wS05vYVQrdERLY0FL?=
 =?utf-8?B?Q2dZRUJUem40VEJEOGFZNW00eDdlTlJKVS94VGpWMUxFRExucENPdzM4UTdl?=
 =?utf-8?B?MWh4eGVlREpSWjFwRWp5d2tkaDN6TnlhaENJVjlNaHE1R1JQRnVYMUp5SWdQ?=
 =?utf-8?B?RFlCRG1pRjVwTGFlY2dKdUNzU3NrZFBnaVY2dkZJaktiMkNvbkF2dWZMOU9Y?=
 =?utf-8?B?VGE3VFNqTy9nc0c4MERLd3JaYXliRlJZVkV0WGd5T0ZFVWJ0VUdIM2xGUEhh?=
 =?utf-8?B?VXgzWG1LTC9hc24zYlJrYlpiNHRkV1dIY1hqOE1FZ2RLZXFVdjk4ZDV6RlVC?=
 =?utf-8?B?TGdUVGkraWl2RU1OMFltNHdoQVVkUjVMeENRRGFVUXR6Rjl4cEhtSWhWc2Fs?=
 =?utf-8?B?U2taWGZoTUl4YVM4bUNWOGJod25WMWJrNlpwS2hPdGppdDFmT0NoVzJZdUlP?=
 =?utf-8?B?ODRhR3BxL3JsLzYxMVRLYzIrc1M1aG5FdUlvQkFxRjI3ellDUE5tMytVWmtt?=
 =?utf-8?B?eG9DeFVIczFGbHhnNjZkbk9HZ1ZLOFVWKzZTZmVrUlpLa0x5ZVNWMUtUd0pZ?=
 =?utf-8?B?MnFLWldTakNjeWs2VkhlK0YyUzVYUFhCS0I3Ly9wQS9CNTlCUUtKcHcxRWFu?=
 =?utf-8?B?bEhuVFV0SStZdEQrRnZveGE2QjZVeTJsZmt1Wmk1Q0twTis0V1Y1bGlzN2tL?=
 =?utf-8?Q?9sSS6jXoDI4zMRQK7aJdPAw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb28e4d-711e-4245-5f3a-08de3cb755fd
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:25:25.4297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BhWcL2XSOORVcnKrTtUTScf+VgidkkK1kCdDUJIpk3KJt7LTpp61viG7f2CcBMpuyhYAX52mRjj3uj+iS23a4E8Vi3G492BYOcKjZ6OBAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8206

On 2025-12-15 13:24, Thomas Gleixner wrote:
[...]
> In case that the user space access faults or invalid state is detected, the
> task is terminated with SIGSEGV.

It appears that only access faults trigger SIGSEGV. Perhaps removing
"or invalid state is detected" should be removed, or the code is missing
some state validation ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

