Return-Path: <linux-arch+bounces-14489-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BFC2D617
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 18:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4288E4ECB63
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 17:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E838D314B97;
	Mon,  3 Nov 2025 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="gMEqEDyV"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020131.outbound.protection.outlook.com [52.101.191.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D2531A7F5;
	Mon,  3 Nov 2025 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189637; cv=fail; b=OYyAufXId7zTA2fd4Wd/Gve4XgLQD6aJzETj80vnico/jwbwV3uZEjq0Io1r27Rqlnc5Mc8GW6mjm7DRpBsVCni+Fbu0UKDmQwPGUKqek1x9aOlET3SPyRqvZQCoLKt3hZsHx62jaEOlz441p2kx7TtYWBCUvhvT5NE3Fas7muQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189637; c=relaxed/simple;
	bh=8EfxXgxkjjXgxcoI3bXseNm9TFUlwzNAou+HcjwBhJw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yba7QNkKsg9zM9U8Jp0eg/O/CP06dUWca6YSLMAVHIrCOaKaViGX8NJbta1ZzeEnIWLH2QxL6xZw6FNCpCZnhXN/SVBkUEy4JArGxPkA5r7vvp7ONbk+vvC3EhKt7U0f4ltYpHA11sSBhCdCLEWK/NZLd0LsU4jHaYksnxQVEH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=gMEqEDyV; arc=fail smtp.client-ip=52.101.191.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwSSeokNURqjiq3fm8F/YUtuzckOh8kF1Xq1iRXxBZyzXRE0NRe33hOpyAm+mypCYjBqJD38KRnkDD2gFQh7hcLQOy65hwzh7lGzJ0z5luRIs/IvjDvQfmiLYyHUNq34lNnyoFPiYpHtRDPrbKwENzLGMqQEoisCXFCKgUgUa+ZxQaE5mV13PpxsUWMwIlC9Hg7GUSJYZcOb93Dn82fLp01PCpco7VN/GpGRny4Rj/DJ6wXuX4Ietua797fRuyuV8j9aBYdymzK5kCGtbslRQxnovu7YFPRlu3SlM3NbU/ptv+fq7bI+5Pi53yCVzc04end9D+il+lSNRplgm2UXZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAEjqLHFJbHASebNnCMJk+sgEzycc8aj6PlEpsdWTsw=;
 b=CFA+y9fw9OjKhwj+FvZApwa/Ip5MJgfaoSSEkxu6EGSjgXXoPgwsnoJvowEYgJICXLBno2NkpSKTeiBVwuNWrc7mWmlZXMYvYXhLZBbvt1EQ1rvM/WX/rz7zufaJOPJu7o+xc56ppQQTF8N1OXexHqhlGCOAZkE0Jr/WGaHWFRrTc6HYpGMMTa9VHoKcVnWIv1SIoXNa1CYle7ViSOlp+1iD3GZ/exgT1Ih5ivbXc2u9LTvvLybHnH9PGeAry2vKrKHOwMce2XQpDHAtKNiwJcjl6l3rpAF7rclTDXp+91Pz6E332b9fKTIG+k/eR+VK3C03RfnYa9j5on4EyeDtrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAEjqLHFJbHASebNnCMJk+sgEzycc8aj6PlEpsdWTsw=;
 b=gMEqEDyVQl20oKwsrFbb1Qv+6L6vT7cjF5pXIcolJYgTM/Eq9nn8mg60mVViS+74NyaqNqqvLNexQRbesMqQVGR5XuNaVsBwNtzKNTDEUtS677jz3gb2DCfjMkh2UBOLw/2G+gaBgi6K4u9kY0V0CblNeCY3y+rUwesV55/ZXwD7JKXhOMMAg23laoJad1+r1nooTsD2/XXyKEMFELDRU3R+Tk4h61Vvdos2GHfZvO36TcMUiitFVj3qBXwl/z+Jq5b68R4AB6mZkXLpyuoqyL9bU5q9ZFVoIthNcs/iOZPYVkysLIaFRYqK3GnABU56xq25hKpKygnlrZWeffFkhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6512.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:07:10 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 17:07:10 +0000
Message-ID: <641a0f99-d131-4b74-b258-a5f62ff9011c@efficios.com>
Date: Mon, 3 Nov 2025 12:07:09 -0500
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
 <8a06928e-7bdc-4b46-a4be-63032843ea6e@efficios.com> <875xbusruq.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <875xbusruq.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0327.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6512:EE_
X-MS-Office365-Filtering-Correlation-Id: 375073b1-71f8-4c6e-33d6-08de1afb6d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHpqblhXRkZ4Vnp5eUJqY3B1ZjNyTmxXeFk2R280RlY3YUpKSWtVRTR6TEVU?=
 =?utf-8?B?L2J4NEFhUUxPMi8rSlJjQkF6OHpSbFlWWC9vNTVCQitReDFteTVBMjZwa3M4?=
 =?utf-8?B?dDlreTFtWWJqZ0FQUWdiSU5WMWVGUzRrUm1XR01Fb0pOVmVaQm5HU240VVlJ?=
 =?utf-8?B?bmRxTEswWmwxSzhBbEdFVXRRNktBQmZJQ013ejIxcHdKdHc5T1FsVFFUUVY4?=
 =?utf-8?B?N2V5NTYrcGxQMzVuV0JXdmgvL0xCdFRDMFB5M2FIRFdVc05LeVVuMHBkUjNZ?=
 =?utf-8?B?M09oSzNMcGZ5UGRaTnEzL1hITmNjNVBwVG1ibDBjM1dESk0vcWZJWDVRQWZz?=
 =?utf-8?B?bXdJejYrYkVvNnRlNUJibUJuZ0pteWlmOExXSDRwVFExRWtLcTF1OWo1eWxz?=
 =?utf-8?B?MjI2dEFGK3ZNT1NLTVE1bmxvTXV5V3gxUzBEcVROa0IzTHJzZkE5VXlLZVFW?=
 =?utf-8?B?emsyd3VsQ1ZXTEp6c21TUnVQYTVic0Y0T1V6UGhZeHRYdCtwVXF0NlhuZTVM?=
 =?utf-8?B?SVhpRDdDeUZCTWhMR1ZUNHFNenN0VHpGRk9QN05GaytrRjlOcFUyMXAzUGtU?=
 =?utf-8?B?Wm40V2ZTTktJa3ExbHBCbzh0Z1JBVW1pYWI5NDJnaFVZMHJKQ3RHRlQ1VXFy?=
 =?utf-8?B?NENOUHlwbFZKZ3FTcDdqVVZVSUhKYjNPdDl4Q1J1R2trZkFqZ01aRTNrMUQy?=
 =?utf-8?B?VU1jNjBVK0oyMkdTSzhURllDalFaa0dCVnNqTXhVY2twUVgvRXJyL1YySG1h?=
 =?utf-8?B?bGY0anZNQ09nOEJYZjNUK2daaXNoRHhxUWNpTEFYTlJSR2JlOU1pNEwvTDZ1?=
 =?utf-8?B?Mjc3cGdEdGNYekVJaXg2VnFOQy9tVXA4aXJnSnBFK1hqZXluSnI0dEFFUjVF?=
 =?utf-8?B?ZVdPZFI3a20vNEZVUUxLV1lJMm9wNHlvOFhmZlZVRG0rbFFIempzcXd2Z2Jz?=
 =?utf-8?B?K3dGaTlWYW8zL2Q0VU80ejBNbDRyeDFxYUtEN1ZPVzVvWmxLNzhhV1ZPV2Q5?=
 =?utf-8?B?cTVmTWJkRTZmNCtBL3l2T3IxRkJreFl6UXlmelR1NkVqNHR0Y1BWWFNNc0F1?=
 =?utf-8?B?SzFnY2hjbXZCMWI2ejNjMndqbkp2K1BBMVExdjladTRMVytvQjNIclQxakVh?=
 =?utf-8?B?YVhWVXhOZk5mdVpnOWFpRjg1alhUWkd3dzd6VUlMSTBJNE1IN3pKWG41TUgr?=
 =?utf-8?B?Q3J1VllmbkVTNnROU0VDU1p4aDE3RWIvVGZnWFJic1RDenF0RHp6eGpMV2FZ?=
 =?utf-8?B?Z0tTWWh3N0ZWQU9KY09IdE9BR3hQbWtxc2xXZjFQekxhbHBGWlpVWDl2Wnly?=
 =?utf-8?B?UXk5TUNnUWRGQzc3RzJaSUw0NEJUNlNmTkFSMlpxL0hybkp6UTBibzh5dDVC?=
 =?utf-8?B?R212dDhjLzA2TnRWbUx4dU1WMXAzUHU0d2o1V0w0aFpSSm02K2hSUm4xL2N0?=
 =?utf-8?B?RWFBRk1TSURJYktYVHNvQkZkb253Z1lVb3ZBOWdZNkdELysrU1VhRzgydkpp?=
 =?utf-8?B?UnVVakQzN3lzbkpYSTJMZkdvRkhBVDBIT0ZWWkpFRitXTk1Pb1l4NXlWNHpS?=
 =?utf-8?B?Y2dKMDdUL3FXaEdZaHRCLzk2aFJTZDNXdlNGYUhTUG5icUZOa1REd3UyY2Iv?=
 =?utf-8?B?WnRHcis1TFZhTHdTV2UwWHRhSDhkYTloaDhGMEZUYjJPRm8rVUlQWmZ6QUlq?=
 =?utf-8?B?NjByeHdrbEtpR1VBM0RIUkNNblkwRE5pci9CZTFUV0wrMDJHakVhWmJwaWlW?=
 =?utf-8?B?ejE1QWxRRnlQZFQ3VFBlSjZRNmJtLzZFMzlFNVkvbFJTcWl4a3VYRXNiakUx?=
 =?utf-8?B?MDJQd1hUNXY3aGxJbnVrUGNoRVdnRXdBTGppWGMrZm5QcEJneElGcnY0dmQy?=
 =?utf-8?B?OHdJKzJuNHdaRnlDRGhQSU9xLzdxSjF6amJuMHFiZ01yUHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVQ2VjhQcVhBK3Z4MFh0NlZhVFJGRHZQWHdXSTRBK0RPS21UaG01VkRPdjBN?=
 =?utf-8?B?NmFJbFk5dGkyOFVNYXdLT3ozaGNKanJaSmNmRmpBUlhFMjBUNDZMeWl6Zyt1?=
 =?utf-8?B?M2N4RkhsV0ZQTS8xLzU3M1pJZ0dZZlYwcFY5dUZQa29YK0JhVW9tdkFpbzlJ?=
 =?utf-8?B?bzhwU3NGczIvaURuYkpmbFpSYzFMQWxLenhVdFcyK0EveW1vS0ZrdlZTSWFl?=
 =?utf-8?B?alE2Slk2a05kK09BeVJqUVpZV3BHemt4bGdVaytsN1JLUVl4VnduYXJCeFZT?=
 =?utf-8?B?b0U1TVgyV2ZUVFhoMHZrUXlIRTYydTZzdDl3S1pLb0lGWllUOUdxQWJ4RGJj?=
 =?utf-8?B?U1MwTGlzYjJOdjRSRHdid1V4TFVUNDVhalh4aEo1ZVZaQTcycDdsUUE5RXEy?=
 =?utf-8?B?STFvWEUvUTNuRmV2ZHN1TDl5UTVZK2ZqV1BSdTNWb1RNcjBjRERsRytudTNh?=
 =?utf-8?B?d1NLL1R4VHUzL2VMU2JNQ2RUcDRNQ1U5WmRHM3Z0NzBsOTB1WmhabUltWWZl?=
 =?utf-8?B?SXZRajhrNXIyTFZpOUdKd1VHUnNuVVd5cThJV1oydUlVcSt2MndIV1RoeXVj?=
 =?utf-8?B?a04zR0dSNGt3ZkpBdzVoOG1BUDIwN2VJZzF4RFhuMnJBN3F5aWJSVHBoa3dv?=
 =?utf-8?B?OU5KK0FmbG52WWVidmR4ejVJaWtlQ2wzclZMQkRqWW4rdVVlVHAvZVJ6NFJx?=
 =?utf-8?B?UkVIU1RtNVhhdk0vdnQveFZVeUZSMjVrRFFmUkVjcDhNNEdhc0NuQ0o2WnJo?=
 =?utf-8?B?ekhuTTlQT0ZHbE1XeFhRVnJINkp3WlczTURPY1JZNTFCWEtObFVsTitiSERO?=
 =?utf-8?B?K21xUGlzU3o4RDJvbjFMNkUwTWttNHRNYVIrcmt3elYrTjkzZDVpdVlVTkpa?=
 =?utf-8?B?cUdOTy83V2pvamltL2FsaDU0MzR1N2p2Y1JzK2RraDVmZGdPOFFxVnMxM1JQ?=
 =?utf-8?B?Tk5RdGk5NUQ0UTFOakFlQWRZcUdBRzNMazdYeVJqYjloaWNoYk1aMG9JQzhY?=
 =?utf-8?B?MHFUNUNhSVJVMUZBR3RqZVYrKzdXMWUrRENFblNMN0N1UmtScWtjLzRNVmkx?=
 =?utf-8?B?ZjNreU12WDdqWExla3BlRVdIV3RQZW4wSHlCZklVTEFJWEJ6b3ZkWUNrZDNI?=
 =?utf-8?B?K3hTN2FXbUN1eHhUckdmeHFHWmwyRGI5RkFFb3M1SjNyWHJHbGpWMTNmOGVS?=
 =?utf-8?B?MUs1WmhwQ2N0d2F4WDgrblRGQzZiSTlxbUdCN0MrdTc2YkdOLzMybnhWdTAy?=
 =?utf-8?B?bEZhSEhqY3E3YzBjNjNTWUh3Z2hubytsOGJsQm15eWE1YWhXWVRMYUpmVHZ1?=
 =?utf-8?B?UU9nc3puVXJ5VjlNYXlLMklqUHFXc1JTSXduRjFHNlkzZW91bG1NUUwxbTR3?=
 =?utf-8?B?a0pha0RIekc4bzlNVi9ZWFhjaXhFdVFNWjRHdkh4Y0tmbDQ5d29ybFdKUnM0?=
 =?utf-8?B?Z3RpVkloaTFYSXRjUk56WTRMU3dJd0UvS0tkeVluRmJnUEpmbDNOa2g0K1JZ?=
 =?utf-8?B?aTlySWxFMmFINE1RQWJLWTNaKzJZWUFMaEU1UGxiMitjTDRNcVhadU1qZS9u?=
 =?utf-8?B?MG5YcUdBK3g5aTdtSmNDRG5vUGtwUGxsMUJvZllMaE9kcXJ2TzgxYlFRM2VT?=
 =?utf-8?B?bDdJdTFLOE83YStDK2VhZTV1bXgzcFN3enJwS3R1eVZ2MlBRZTAxOFVXY0hn?=
 =?utf-8?B?WjdVeE9ueFBTRjlyczE2TWFLS2pZaVhKSU1CMzZCZEQ3WFBxQ3FqYTdPV2Y5?=
 =?utf-8?B?K0VKVFFnWU41b3U1TUpiRW9xNkdBMVRZbURONnE1S254Um1JbXdERG15cDRh?=
 =?utf-8?B?WldCTko1dXAzSTFNVDY0emwvekZoVHFOeDhhakhNU0VsOWNhNUtOaFR1N2h0?=
 =?utf-8?B?bVI1cS9jTWdoSnoxam5HWlZDZndpOFVpR0dYc1BiaWxoRlp6Mmc4ZC9oVWdD?=
 =?utf-8?B?TEp6cmdib0duRVJ1aDFNUlB5TzczL3BuakF6QUtKb3IvTkFIVWxUT2ZuOTNW?=
 =?utf-8?B?b29PNWdhYkVmUTdhL251c0NDUWRZN1VOZFV1eS8xMjF4WjcwblgxVkRSZFpk?=
 =?utf-8?B?Wlk3Q1NGTFc5bFQ1UnRYYnhTL3hEaFpGZW9QRmg4dUFFUEEzMVUxU2VlS1RV?=
 =?utf-8?B?OUZFeWpKUnI0M3JKaHBKUVI2Q2lOcUk1YURWVDc5QTNCZnF1aUl3bkwzaThI?=
 =?utf-8?Q?2ZE4JHUBOhlQi6DIgS/c7JY=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375073b1-71f8-4c6e-33d6-08de1afb6d1b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:07:10.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGFx9ufIcn+8oaD7oUQI5rnuDgIn33sF0blEWzBLTeeFEVxajK42hWPn3dLIgvPaiXSXmQHqiV5kdtJh3cKSsbmQp+HKGuJY89SSv1elniw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6512

On 2025-10-31 17:07, Thomas Gleixner wrote:
> On Fri, Oct 31 2025 at 15:46, Mathieu Desnoyers wrote:
> 
>> On 2025-10-29 09:22, Thomas Gleixner wrote:
>>>    
>>> +/**
>>> + * sys_rseq_slice_yield - yield the current processor if a task granted
>>> + *			  with a time slice extension is done with the
>>> + *			  critical work before being forced out.
>>> + *
>>> + * On entry from user space, syscall_entry_work() ensures that NEED_RESCHED is
>>> + * set if the task was granted a slice extension before arriving here.
>>> + *
>>> + * Return: 1 if the task successfully yielded the CPU within the granted slice.
>>> + *         0 if the slice extension was either never granted or was revoked by
>>> + *	     going over the granted extension or being scheduled out earlier
>>
>> I notice the presence of tabs in those comments. You will likely want
>> to convert those to spaces.
> 
> And why so? It's perfectly formatted and there is ZERO reason to use
> spaces in comments when you want to have aligned formatting.

You're right, nevermind.

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

