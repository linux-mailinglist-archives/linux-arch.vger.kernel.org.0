Return-Path: <linux-arch+bounces-14608-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D4CC4726E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923F84E742F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Nov 2025 14:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362930F945;
	Mon, 10 Nov 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KXB2A4b7"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020140.outbound.protection.outlook.com [52.101.189.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894330100C;
	Mon, 10 Nov 2025 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784607; cv=fail; b=nTag4U8XM+9hHGnP7Fe0FOiBt+Nbx9zrD6A3pATXwpFWpDqH89iaaA8gcC30k2y8RS2Jmmje1JHyRR5DJg7xlwWJ1EspWpxLwQXK0Ak7fhZ5ha+oT+DP7uYSlbIzaJjh/uFgKSnwLpvkTY2TFY3XTYoAqxmqPYqZlfeBJLiXhEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784607; c=relaxed/simple;
	bh=8xvzY2tYc5xV+64oD7BxJv2AvTH1kBJOxvqCR/IH110=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JSFpE8wK80teELbt7d1kSstYl167iNOyM+nwzchAI1IzxNAfUCvUSPmZ8JhuR82XbgL1AHcC4uCrE5fj0+O7Q40a8DbXvHZO/ihFBwQQUPy9xo//PAT9YAW2mmgEw9w+3vaQCKIOOTgGTFJk/9qpbEBiHuwQVw7rksIE9sw/DPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=KXB2A4b7; arc=fail smtp.client-ip=52.101.189.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3JhOGVttR0HqVLpx0NaMhMDHk2vDHBdLi1SArg42/XB8Fmz6z1NXOW8xmjC8qUrNYM474Iq14GfNeQZWajlFpiDWjNKxIc86WTdf5iHPwyvSuFBgUy/4Fy1kdmibnqCPC4R6oLdqNmFg6cT/vnZ/L/0ENoAWqw0UikVojMyCbFLTFrmirbxETjAOxLzQjeBRid//UPsMgdeQCS0zeuNLTdtL54Q419Mm4UHM2O1QOkOwr8TvbT0gGGCQESTpywHWJ0D5Pbbz6yYBivEzJ8e6QxKJcLoSb+2AAofdT7+QZvozIs6HOqyhT+/92H6PFX5RSRfx2J43NetbkMmx3KdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MYb26vfUNd83nxWfzvi6wL64/nK1CQCZEeXZapHjt0=;
 b=r1r/ojY/NbspLmepHZ4VeJojniOUfVAjAIE4he/pKQWkLkyqGG6qW/CZsJI+Z7upeSu0e+oqRWNauuK/IQNVqVBFq7S0Yj3LtfIeSgxZW0OO3DoDnbz+F9NIMXK7YK0vAecC04h8zgldhPiIGpdFD60/lqtUQwMJMDp3vGxcXuRfkWtA54BvWaDTsUOPT+ehXw3x07belPCp1+/tWmvHOv38Gq/AUztb19cgyS/SibaXEj/I6+bqyyhRaZycvC9ZFg3ZoAc2huuhqrGLn5N2EHgSnPg3gG67U+VOYuAQEJUfbT64sBOCjkkS5fPbY3ns/EjS18bV7ap8hBjgJHL87w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MYb26vfUNd83nxWfzvi6wL64/nK1CQCZEeXZapHjt0=;
 b=KXB2A4b7uMqGp/0KJcg/uiZn5q+yO0WCojLDE8OklX5mNabkl2odlCeYKTNTtaITSLIRkzDRr/gs2YveKHjg/xZK4Yt3ezs78W0L0UsmYa/Zi7a6JoN/ztiQtdjsqmx2eug8iRPv4dKQ8jt7dfBtu75yESk2evLK1etUW9uz5+yCgYOVPmW2SAGn1HM25jGht5TXqr1imcpmKLeDIqk9tiUaFJmTz+zpSz2nlTn5c4h9Rcf5kds49T6dszXzfurJgh0KiWGnPSWWzMFpjeCueiTnmz2SWGtB+uDOv7vxA+aGg8EA0P91/vn+xB9bHe74+zzQA3AB+sUtD5NE6MPEAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB5552.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:60::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 14:23:22 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 14:23:22 +0000
Message-ID: <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
Date: Mon, 10 Nov 2025 09:23:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
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
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::34) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB5552:EE_
X-MS-Office365-Filtering-Correlation-Id: 1294789e-89cb-4dbc-3991-08de2064b3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGtzU2lOaXVIN0pjMmdUN1FGMDNiNU9BdXpVaENjNHdlUXEzRGFQa3Z5aHAr?=
 =?utf-8?B?dEFvcEg0SWNUTE9ja0hMNUJnQjYyS2ExR1dhWUpYZUdTQUZkb1FzV1EzdkVF?=
 =?utf-8?B?NXZZcEVWdWo0dUhjWGpCaW04WFR1MFFBYzRQM3FwMFVVeVp5UGw4WlVKZTJ1?=
 =?utf-8?B?VGZOWGRiS0lzMmx1eE1KR1cvcXRJWnM2OFh4U3dQajZSWXdyd3oyek1CbFU1?=
 =?utf-8?B?dllaUVpWM0k0TGNlUDllU0JtWGM1M2l3ZEFTdlJKR0hPK1ljTmRIMHNZZGJm?=
 =?utf-8?B?UDIyM0t6RUZPclU2MzdJVXo3L1pmK1VPY3pwczJOWGhFV2FkQXpDYVYwZWhn?=
 =?utf-8?B?NFM0QlpWWDdEY2hKWTZndThlR2g4TnluK1JmVDI5VHZnamZheGNNTUpVYnFD?=
 =?utf-8?B?WktyYzNOK3hmSjRVejVxZUZFYUlXOFc3dkFJRlpVU1BIa202dE5CbEMzcmRh?=
 =?utf-8?B?R3FJNUV2ZytvUU5Fbll5SEg4WHd3OHdQWlF2dmxvTGZBQXoybHo1SFFObGNp?=
 =?utf-8?B?WXRYbTFuSDFGWDJKNW4xd1JsWVpkZXJUUGxucWZ6OEo3VDNHeU1wNkp2SVdI?=
 =?utf-8?B?Nm5LZWJ0dHE3emRldUlpeVlPak9hNFVnK0FKbDRqbXU1WVhOUE1lL1NmdmUy?=
 =?utf-8?B?M2o0UDRwOHVaeXBQMjNxS3laUFJrWVMwUWdmK29Scmp3OFJ1RktPNExPam5v?=
 =?utf-8?B?MW50OGlrT2h0OFBkOEgvV01RSDU1MndjWmhTUVN0N1RhSzE0Z0JnM29wd29F?=
 =?utf-8?B?WnEvQnhjV1EzNjB3a3pEckZKdE5ubU9MNmZmcm9QTTRKTWhRR1ZuMFgzR2pk?=
 =?utf-8?B?NzJBRTRRZE9XQ3RIT3dpb2VkRDJyY255RjMyK1lvQUlLdlNuRXBJSkZVcHlI?=
 =?utf-8?B?YXR0WWRwaG01KzhaU1hDRDlEVkhZaE0xNWxqS3BRay9WTmU0SjFlSzdHZ3VT?=
 =?utf-8?B?bUVBYVZLYTNXMkczZFV6Rm8wL1F4VzE3SHVLM1BlVWFLMjMvRkZ5bExUV09Z?=
 =?utf-8?B?RHJCWFAwYVEwSjFyZkdDdVBTVlhSd2tQOEt6Mmw1RDB1S3B0WUlVakE4S0kx?=
 =?utf-8?B?RmJ2MkxTYzRiUnFwOHdKYzZQUUlvcEVHRkVkdjNBcnZWT3hYb1ozejc5cUFC?=
 =?utf-8?B?QnJDeG9CS3ltQnVPNmFBSDhxZ1pmUFNyWjhhN3h2RnZTN3Q5cWd6TTl4Vk42?=
 =?utf-8?B?emdjVWcremswQ2lwc3YxZDRaNkRrWGpQMkJmZzJNanUvTFQrcmdTU081NmZ3?=
 =?utf-8?B?OU1yZ0FGNExqdFNubFlVRkl2M3BNVndaaWlxR25ycW9ENnZZeFhRT3VScTVC?=
 =?utf-8?B?b0lFakJKbXdCTHFWSW10eVJadG84U2orUS96cjVFMm1YZnpxS0NwWkoybHJP?=
 =?utf-8?B?K3NhbitTSW1CVlJxN2xxNTM2NGwxcHJYNkxaNXNRZEluaTc2eFRxY2k4TTlz?=
 =?utf-8?B?YlBFRDEvTTdqYkNCdkVMVUErVDJOOVovWWY4OGc3RTczT2wzTTd2cXJ1OXds?=
 =?utf-8?B?MmUzc1hnWnl0SXVOeC9kelRWN0I4MGlhRmYxeHlQNlFjMExoR1I0MjRVazZH?=
 =?utf-8?B?Rk42QkEyNDh5eFFHOTYwOHBneVl5OFJXQ280YlFqU1NhS1NPcldZaUY5WGV5?=
 =?utf-8?B?U3E0R0Z1MlFvZlUycjNhdWRDaGJSaHhmSzFaNkVETkdMYS9vbGg1TVBGWUw3?=
 =?utf-8?B?MDlVYWVzc0RHc2FmZitsUDA2dEhWMk1hVHZHdW54NGlKaVVOaWhUR2RTNnZJ?=
 =?utf-8?B?NWc3SmE3dzRVMTlsU1Qvb3BlSG9sUEtLbWtZNXd0K3lsRmN3cmdFdnJIbldm?=
 =?utf-8?B?WkNOclgrTW9mYWQydlFDT2tRcHdLOXVWcFdBTkloSUhwRkRTVGZ3MWJWSHlF?=
 =?utf-8?B?ZGlRQ0UzQitYZGd3bktXaDMrZkRlTTJtRDc3RTlQT3gzUGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UWoybHNrV1o2bE92Tm16VlRwYTZNbWpPUDA5VkpNMUN0a3dGYzF1TmhHY1Bt?=
 =?utf-8?B?bEFta0ZUKzgzdGV2aitJREM4YUozaTZFbGQyZ1hmbGRxQ3FUd1dSOVZldU9n?=
 =?utf-8?B?Y2w3b2U0NUR1T1l4R0ZGUFZkWkZQQzVYSmI2clNoZkZGU1NsM28rV29kOWEy?=
 =?utf-8?B?VW03cWZ6SUVTQ21keFhxdWJYUmhLRHgvSlJ3V0I1a3FhWGJHRExkYU4rYWZr?=
 =?utf-8?B?M083dWovcUlXMkZhZ28xMnhHeWc2S29Yb3ZYMmlHSTFXdEZzMDFqeWNVaVF5?=
 =?utf-8?B?emdHem9NTWJVbHBhZUJrNXpHVGNabjBUSE9sVXJtMmgvK0FjTXdhbllnZmdU?=
 =?utf-8?B?WlB3TUs4Zi9NVjlhd09qV1dlbmhjV0pzZlpOUzVQaVUzaW1ra3pqVHlyTkQ4?=
 =?utf-8?B?QmFIMTVnYXNobUZlTmVCUi9vTjNhb29QSWprdXlERHVxZzV0UWdJRVlpdURL?=
 =?utf-8?B?SWx0M3hZV1l1bkFxZXYyMndFRVJUamdnVGo5cmFoUGd2TmVUbWQva21wY3Rl?=
 =?utf-8?B?OHhQcTVQSFRJR2FZWVk5LzRSQWxSRWRQYzZXRGVEMDA4OUhtL3c1VjRwN2E4?=
 =?utf-8?B?dk9tQUtwc2NRRVFHckxWUWtSbFNFRTQrU1ZsM0ZnQnY4THZkMXNsSzhNaDdl?=
 =?utf-8?B?UWV5NzBTenluakllSGNzVFRmVyswaTVobEY2bFdnUElMeStOZVFDVFh1czA2?=
 =?utf-8?B?NHVlYmU2VnVxM2F3QzhCZXREd00zaTd1SkxGNlpXbnY1NXRTZktoQkVINCtu?=
 =?utf-8?B?OExXT1dDNHZkbzhaemNrbTdyRU9oS3RTdnJ3SnpoMmtObEtCSWVaaDdiQUky?=
 =?utf-8?B?ZXgxN1NPakFWdkdGTzcvUVRXQ1dKcWpOREhtVE9lMlA5MUpGL01ZWjRWY0RZ?=
 =?utf-8?B?Wmc1WklyRm1weFp4L3RTOWU5MzZQNzFEeUxoUEJIRTkrbys0d2VIeHNqQWFI?=
 =?utf-8?B?Ris0ZDhLY3d5aWF6K2NlZ2o2Ym5LZVI5TjJ2SDlGaWlkUW9BSCszUFJhYnJD?=
 =?utf-8?B?RnMxelRmMVZqKzdDUDFZc2x3OXpUUGhRVFAvZjNjVEUyR0RtWUE0WVFEK2Vm?=
 =?utf-8?B?R2hDSTdHUlZIclBlOFlnN0U0c0ZwcytnRjBpZmNxWVZ3WjlZUUpwbmxoanlU?=
 =?utf-8?B?b2NyRFRiN3hnMm5JdVJ4Zityek1xWk1pT0VHNmkrelZETWM3RXBUR3psenY3?=
 =?utf-8?B?VUxGeTNlRmRIVTlFb2N4UldnNEtuRjVzTE1kQUtodS9OUDU3ZVJMUDhocW9r?=
 =?utf-8?B?RkFZRDFKd1lMNDVySjErdjVZbkFCNXJ2TUJJSS9vOW5YMXRSM3N5MHk3WjV0?=
 =?utf-8?B?QVUzcGdEMGRRaUczZCtDTDBsMEZCcFAwcHZvNlhkVDVQOGJKcTJXQjUrbHd2?=
 =?utf-8?B?bXVuQnZwMjZoWXpVT081WldxM2hJWEMyNnVRczM5WVpqWHMxdUZnYU14TjhY?=
 =?utf-8?B?VG5OSmU4OHkvNnl1Yi9mL3ZpbjJMdm1jRGJqM3dFejBHbVZzMnR1SlBydTQ3?=
 =?utf-8?B?N1pQdk1EVG1NWlJpVGN3VUl3NTlmZFl0YUhtdmUwMExxbzVLYmJ6K3FxK2N2?=
 =?utf-8?B?SEhvZG5KUUxiYzRSYTZ4eTVCcVBYSVF5OU1BSUIreXJucHZFUVJRcmc1clNL?=
 =?utf-8?B?WXZqOGkwdnJtcEdUaE5SWkd0dnRBbVBzbUVoWWVxNDJVenhhaDRiQkZzaEg3?=
 =?utf-8?B?YmZpbHA5QVBHWXltVU5VcHJna3h6YzlYRUdYdCtoN2tHeDBlcXQ2YTlZdTNq?=
 =?utf-8?B?M2l3cEh0SWFYVzNGNkJGRURSdjdLUkNLbWFDckVVTjRkaHc4UDhFQU85VTVF?=
 =?utf-8?B?UnN5QjA1bG5PTmkrWjNvSitVME9SYUNDWnNLdk9YU21CRytJNE1OZFZBSkFh?=
 =?utf-8?B?NG9rcEl6clNqanlNamthVjdhcy9sc3VBc3RCR0FvRVlCV1FwbEdEOEt2cUMv?=
 =?utf-8?B?MDkzamZKTzNzN0lSTmUxSlNORjZaZVdtalRyTDFVdGJ4WlFTQ05zNlV2dGxS?=
 =?utf-8?B?RmNtekJXOUNoMzh3WkNQWmVpQ1dadzY5Rld4M2M0VmNyN3psSVRnSnlLcVl0?=
 =?utf-8?B?ZnljaGU4ZHNiY2g5d0gzRXdrK2wxdnFpb0pIWkc0bXJmeW5wc0NPSmpicWJ2?=
 =?utf-8?B?RWZ0VFJPOGxvMkdtOXlOVXJIcEI1bHpHeHRjVCs5L3h0RVRGY0dOM0o1aFZh?=
 =?utf-8?Q?HkpfhzT/gvMay5WOMxha+UQ=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1294789e-89cb-4dbc-3991-08de2064b3cc
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 14:23:22.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inw9Pln+NFZR9cp/PDw6myhXCVKP0gVBNYCal7soeOyfz/qxwZ05mhpQfBwDLb1vVoOEmd4n4lEfUcdtUz520SdSJirvGaXxJRy3uY2vN5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5552

On 2025-11-06 12:28, Prakash Sangappa wrote:
[...]
> Hit this watchdog panic.
> 
> Using following tree. Assume this Is the latest.
> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/ rseq/slice
> 
> Appears to be spinning in mm_get_cid(). Must be the mm cid changes.
> https://lore.kernel.org/all/20251029123717.886619142@linutronix.de/

When this happened during the development of the "complex" mm_cid
scheme, this was typically caused by a stale "mm_cid" being kept around
by a task even though it was not actually scheduled, thus causing
over-reservation of concurrency IDs beyond the max_cids threshold. This
ends up looping in:

static inline unsigned int mm_get_cid(struct mm_struct *mm)
{
         unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm->mm_cid.max_cids));

         while (cid == MM_CID_UNSET) {
                 cpu_relax();
                 cid = __mm_get_cid(mm, num_possible_cpus());
         }
         return cid;
}

Based on the stacktrace you provided, it seems to happen within
sched_mm_cid_fork() within copy_process, so perhaps it's simply an
initialization issue in fork, or an issue when cloning a new thread ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

