Return-Path: <linux-arch+bounces-15864-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF15DD3A681
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 12:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB4B3057EB1
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C4B3590CF;
	Mon, 19 Jan 2026 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="HgKyNfNc"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020076.outbound.protection.outlook.com [52.101.189.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B023570D6;
	Mon, 19 Jan 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768821037; cv=fail; b=Ug40ljEMc5ksRgg+OZek032J0ejB/ltjKi/2wwKYtet/5lnTySr+YhiGxWqdyoUbBhZ3QTpX5unI3csUmcqI6ermMDAvBPGmAaKBPiWgfulk67pU9APBZHiL126UxykRQoHVR0sLPm5SViG3gX99GORBWbLWJMmwVjoAP8rfKBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768821037; c=relaxed/simple;
	bh=/jAbT2OoYvY+ZUrkQxoWW89UYNIUDUfBO+BeNgAXXgc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=anLJ1LlbW336Bqzr121LAftDmFVQ9upI9fglHrNIGB0aPSqSlSCrUVtwHsTQmxU+/OWnFo7eHGF2Oz/TqJW3l38LNOFF6OhKZTL0wZ9AvgrszCV9TYZ7bZZJI+HqoIqV2e9i9w6c8cwpIm7tHNn7BTEUnxhQKnlJiPu36yRGO0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=HgKyNfNc; arc=fail smtp.client-ip=52.101.189.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6mn36dzTnX0CUkESjieZaMJ7RpqsaLnxSXKaDa3tpvb3I094dQlibagfBMB/TKbwpxvWeXJy0yUX1OGGI2vpX+uN1vlku+M/XjwHYJef4teWyiphpbZ6DBEWJ8ml5VMoeQNBpvrNvItA5tRCWhSN8rA93AeLeuaHK/RfEqVERBlmM+VYlWywVITVFVEslMxbF3IsXjf5F8Ct1u5z5Z9GTEfZyIt2poUELrU/DnpuMQxODT+jYoTKfdeNB55ISQ0wMtyuu8davU8jVHOeW4LNSIzWA++uY8GvZObmvS0UH8DafJ2QISe2alHaC0mO/szvCasYRyqxMC6K8as99vLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs1Or/jZOl4q1A+TzS7y9zLTW9Gi7+mV77I9qD7Oe0o=;
 b=uL1hEClK3bDlZOQhJ4IQ5M5oma91OX5HPJjeB4zlx5lNM8vlekbIwsFFkaoCKTKYiHM7Lr7JYP6Px6XkhTUtRNoue9ok2DZ73EKsXdjsZsqUcYxZpMXGjMBp4jGx/hI5queWT/6NHA8y2G9pClbYl/ZyLnHxpfXi57ZeixtMqaeymE20kjhwyh0hX0/k9TOYQm32WCi/zhXeAp2xfgy5/QoUKjVQiLfU3aFgt1PRp3TCWqrONajw/JDIeYymF1y12eHKxZYfiAQcJXb+VKG1wz4UIYqahPqyEcqXTWYZRq5aAr2zTUvlukk+YYJ/Y7vjOABgRQBXH35H1Of1q8AZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs1Or/jZOl4q1A+TzS7y9zLTW9Gi7+mV77I9qD7Oe0o=;
 b=HgKyNfNcxNIQ4Fpt4UA9g8EYsreqz2kj0f9ijQi1JC2YQbTuawkcvZxGYc3hLiYFuSWn4c4TbYsGamWVpjbb6Q4dDhq5dee/kZLDZ2B6Xc5OultWZYuo2NmfZsWyopMztCK4n86rTmUHfjAhK9kFM6bo5nwY1p5bf2eKQ+zfXNdXnP0C8ez3m8WGHWxfsId2lwoJtrl767rTyujbUaiRvFOPugv3afXgHeq/Gw9fvudeSzGDaTlIvxBhhln4u/i8ucIDBoDVslmsW5jNrcaxQjzxO9k0jWI83leVrN8tqthM/brWiXSq3N664a8J7e2FDTV2NTbDcP13UOfc5e6UiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11256.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:10:32 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 11:10:32 +0000
Message-ID: <840016ad-9188-4df4-904e-b7462b2cfd81@efficios.com>
Date: Mon, 19 Jan 2026 12:10:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
To: Peter Zijlstra <peterz@infradead.org>
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Ron Geva <rongevarg@gmail.com>,
 Waiman Long <longman@redhat.com>, "carlos@redhat.com" <carlos@redhat.com>,
 Michael Jeanson <mjeanson@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com> <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com> <87ldi4gjm3.ffs@tglx>
 <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
 <45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>
 <20260119102138.GQ830755@noisy.programming.kicks-ass.net>
 <5d2f428d-4fdc-486d-90e1-474f3ee9f54f@efficios.com>
 <20260119110300.GR830755@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260119110300.GR830755@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00014AEE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::318) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11256:EE_
X-MS-Office365-Filtering-Correlation-Id: ac563362-fe97-4132-3924-08de574b5ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L1o4Zytzak1YbUtVTk51ek9pZnl2Rlo1YkRCYitLMmd2UkVDbDJyampmckla?=
 =?utf-8?B?YnJqL0lnODNsRnVsSnZZSGh6K3VEbUdZbjdZeUU4dk1zbnJ3S3R6aElDNnFK?=
 =?utf-8?B?eTJybVFSeFdjYkFtZE1aVGpURnJwZjNXY0lrOHNuMmMyZlJ4U1ZPR1hXRWtk?=
 =?utf-8?B?Q05JODlYTlcwVkxnVjdTMFhkQ0ZObWRHTm9CTVVLNExacjBzN2wxYlZzUHdl?=
 =?utf-8?B?WFlWRGpEaTNsV25QaUtSdFBkdnB6Q0Y1TmJJcmthNnZ5VGM0a2hvVmVqK3kx?=
 =?utf-8?B?cTlDak56SDl3WlVKK00xL1dwSFM3ckJlanh5Qi9ucXdrQjdPSFVDcGR2VTVP?=
 =?utf-8?B?MnN4U3dya0ZNM1NNb1k5UXRreFVJVEgxOVl0bVlvMXRIaTlkZW5BVFRJRnZ4?=
 =?utf-8?B?VHdZOFpybzIzc1R5UWJzdk4xS0tiRkZiaTZoSzI1TTJlcFFEaWJWdVp1NlA1?=
 =?utf-8?B?endHdEl1YWE0NGU5N1NXdkRYbERma3VrU1Nhek5qMlNQRHFCck5LaG9OdDVL?=
 =?utf-8?B?MHpRVHU2cUhiL1VSYUVQVEhLZVhBQjVYOHplUExsalFPdWJ1V21hVWRMZEQ5?=
 =?utf-8?B?VkxkWUJpWUZPcitvdndma2NxaVBEaGcxRmpsSjdNaUp4M2JNcFcrMXhhcG1I?=
 =?utf-8?B?SE1ZUk1EalpSWTR3MEI2bXovaXV6WkVRb0EzN2JDWHd4Y21naEtQWndDOVgr?=
 =?utf-8?B?dXdtSDdFYlhhUFNoMEdhNGt0NDdyM0JSSDg4aE90b2Vvc3JSQTF3UWgvYXBv?=
 =?utf-8?B?RkNWWFJWWng0QlJZQm9yUGV2bzgvaTI2VWhHc0lSdGJieHRqVWdTNlRLbUkz?=
 =?utf-8?B?dVc5NEMyaTNlckExNmJ2dEVtQWJjSHQvK2J6K0IxdGlPaENCZnpLaVVvZEor?=
 =?utf-8?B?cXo3ZXk2dUF1UEUyS2xtdW5zdlVCb3M1Wkd4cjk3Sm1nV1hkdXVkUGsxdWJi?=
 =?utf-8?B?d0JFM0lDN1p5aitQWmJ2bzFxSERzUnRYZDk0VVNWci9SWSttaG5JSTFPeUNW?=
 =?utf-8?B?cldNK293NHROZXZOU0NOQUJEanNMbzFxSVhLdmV4ZXh2OHhybENrc0plZXpE?=
 =?utf-8?B?S2dnRWpSbnYydUlnMjM4L1VweTBBUmZCSDZUbUdDaExzTGlpaEQ3ajROSmVx?=
 =?utf-8?B?YW95WjVvZEg3a3RZMHFCVXZRQVZKRytpUlRsNmNWbjczWlF0azkxRVZXYm5M?=
 =?utf-8?B?THFRS2NqQm1VM3lxeDViak8ybHEwazVyNGN6SlVGVkNha3BXcFE3S04zUEI0?=
 =?utf-8?B?Q25nRUNpcHgvbTBaWEd2ci9waDEyRlF3OTMvNjhxdEpSYzF2U3lOYWZ5ZkQw?=
 =?utf-8?B?RnZJTDRsVEtnVFpLM05DekxGOTJuMk5aVEVKaXFudGFyQktUZDViR0VFQUJL?=
 =?utf-8?B?QSs5K3E5cUdackR2V1dzMXN1MkNScUpOOXg4VzY0RmZZZHhZaU9xZmZnRUli?=
 =?utf-8?B?TktMaFVwenNuWk1oU3FRVFpuT25vQnhQVGlyUW5wbGNCZGxMZFJsSTVJVXBq?=
 =?utf-8?B?WlJybFgvYnNsR1l3cEg5c0RISWJTVXU4R3dGYlNQU05LWXNyUHZmdDQvS21U?=
 =?utf-8?B?MU1YeC9OcVRmQ0Vtd2hlZVFLWFlWT1pmWjJneWJLNVVUcDFqWnJpSjBzeXpy?=
 =?utf-8?B?Y1pjZUhXd0VvbHVQMjdHeTI0WndxK0J4K0hrc0pTSEFHcnhwYWNlMTFwb2c3?=
 =?utf-8?B?WEZWN3NyK2M1K1k4Wm5LTDZqK0wwWU1LUWN4ZDh2d3BNYjVBS2RZZXBoNUgx?=
 =?utf-8?B?T1M5UHJRZ011N3dNTTdwKzhaa2ZzUWJKZmVqYmR0T3BTT1dVR3JxdzNrb09k?=
 =?utf-8?B?QktKTFZhdnNZSnA3T0xpS3R5ZS9BcVFNRCtCc0ZqR1Zmdm1XQ3RqQXZXNXZr?=
 =?utf-8?B?ZkhObUU4U2JtTXhlUGduOUgwdVJnN3RyOVBRTXEyRlVvMEdkQXBjYkhuK1BP?=
 =?utf-8?B?WjJkQlhCUWoxdHRtcmcraWZJQzVVaC90NWF4TDJYa1dWSWI2eG9VVCtoVUZ0?=
 =?utf-8?B?SVBacndHbWJNdXozbGV5VXZsZHpSSk5pUkVOMWVadEcwc2drR2J3WnBUWVJS?=
 =?utf-8?Q?kh1yXp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDVOTHVwQk5mVWQ4ZVRSNzVnaXE3bUMzMnpCUlA4aElYcm93cis5R2FYajdv?=
 =?utf-8?B?MXl2VDZ5R0lyUWNOM09rSnJZTDc2ZmtlczRRaWU5YWp6WnRRTHVXRmRPbmpE?=
 =?utf-8?B?VmxIbVV3TVB5Q1IyTEdlS0hXRGpZRnAvQWRSRERvQkhzUGthQStvTVcvSmM4?=
 =?utf-8?B?d0ZvOUJJbXk3OEJ6bHlpTTdNKzQvaVVoQjY4RFpwUkpEVC8zUWlkTEhwTEpP?=
 =?utf-8?B?Z2orNHQxRTg1MjlOb2tnck51Si9PK0NHZDFSeUNIZ2lNQ2VKWS9MZTZoelRE?=
 =?utf-8?B?Nms2THBRT2NISUtwZmp5Y0dhelZwY00vVzBTcmpyanZLbHR1UlMxT3Y4aldi?=
 =?utf-8?B?b2w3aGIyZnZ4L1Vscy9IdEJvdlRzZjRheE82MUZTN0xBbmlSZWxkTExhVzdE?=
 =?utf-8?B?dXNEcld3aGlzZVJhZzl0bU4wa2dSS0xwUktLcUtNR3Qwc2YzQlpSYjJ3Rkdq?=
 =?utf-8?B?M3k2VXNPc1N3cGRmRC9LbHdCa1JTMm9XSmlCNHlHRGoxMC9keWlDU1IrcUZm?=
 =?utf-8?B?QitqQkc0YkFnakdNbFZaTEhqcnZPQmRvR01mSkJoR2NLS2pXK2pySGhOakUy?=
 =?utf-8?B?Nk5NdlBidU9hVGN3a3RJT2RESzB4UXJvb21lMFdiSTJRd0tVMEJTdUdRM2lo?=
 =?utf-8?B?dGloelEyc1Z1YXU1cXR0bUwrU2YyVGd4cVc5ZkV6dzVsMWR5aXp1ZEpVMTRq?=
 =?utf-8?B?SWdaZFpQaGJhaVdubHNhSXRSd2pSVFp0alRUZkgrV215SldqNEFoeXJuSkRO?=
 =?utf-8?B?cEJ2N1Iyb2RHS0x4TG9oOTg1ZURKMDNicUtDZGlad0MrdHo3UENJM1R0cWZw?=
 =?utf-8?B?ZHBMcGhZOTNJU1RVK05SYjZ2M2U4RUhGK3RldkI0U2VvaTM0b3ZTQTNTdXlI?=
 =?utf-8?B?cVgycWovT2lNRk96V1pSTkU0T29tcFFhU1hnTXRITGZwYkdjTm1TTlhHNERv?=
 =?utf-8?B?L0lHNUVhdVV0bHpoZE1yeFNJcmkvbWhnSVdaalBBajBtaStPSGZiWnV4TUNn?=
 =?utf-8?B?WmR3S0JJb1lTOVFVOWxIbFpiUllKbkNRUHd5eTQrTC9FMTRRemxvT1FHUkt4?=
 =?utf-8?B?RGpOUklzQk1MUkRiQlNsSEtkRVdQSkxkZTFYSFF5OXhtb2tIZGUyM3lVNFUr?=
 =?utf-8?B?QWlMVFNjQXhZV1F1SjByZENZdDgxelhBQlRJbThJUTQxR2dEZmlSYlBMVHFN?=
 =?utf-8?B?NXN5aFlwa200dVVVMk1Pa2hkVUZLTDlCSjFEM3Z6V1NUaTI1d2t6d2ZiZllN?=
 =?utf-8?B?VEVQYndxV0ZKcktlblpnT1FyL0swandBMWxGZVhGb3BNTGp6dW9MMnlvNEVj?=
 =?utf-8?B?bFRkUzB6VHFwSTZubWx6S09nZ1NxVTF1SGdtNnJQV0N2ZXd1eEpHMENjZCsv?=
 =?utf-8?B?OUpwQ041RG9tUXE1TjZCNVNDRG9hZ3M5aHA3aGRDNFdPU2JTRGdkWmNFZ2FF?=
 =?utf-8?B?cDZrMDZGcEtIbFE4SHVJVDMyWllzcUJNQUhiMlVjZzVpblJJNjQ2SlVERjk1?=
 =?utf-8?B?YjFRSFN1UFFuR3EreUw5ZVJ0UE1TQXk5aUpXcTJZUmpMd0RLT3J4dnJSMlYr?=
 =?utf-8?B?WlJTVjlvTWd1YjlhQmhTODN2TTIzc3lGK0ViQnF4N1Z5aTNKSUtWU2s5UzBE?=
 =?utf-8?B?ell3MW45NGc3dTY1SkVEMjZMNVBkM2tZRkpBalFGWkR4T0N4TFNOcGZVZXdY?=
 =?utf-8?B?UVkvOWN6ay93clBXUTZwM2VUVzNwRkVwU2JSSGUrcGk4ajhKaUxhbU1Pai9Q?=
 =?utf-8?B?QXFDQmpUdkJFa2hhWVZvK1dmZnFLYjYrNDZEdUhGT1R1OUJ3MDdYZk1IZHRK?=
 =?utf-8?B?VlV5OU5yRzVrelVsV3g1Nk1kcEkrM3BZZTBTbGVXd1d3WFJqcThwSHVBMXpl?=
 =?utf-8?B?SmY1Z2VFS213K1lRdWVCdFVaa1hIVktHR3hDM2xFQjZBdVI1TlNvTFhUdnJ1?=
 =?utf-8?B?OGplZ09nNnJTOTk3a2JuK0JyRUoxNTBITFA5Y3VIcllrcVp2NUQ0TElsalM4?=
 =?utf-8?B?WFFwSEhtcjEyVTVMYk1RclVtQWVyZXJTRm9HMldkd1oxbUM5NFA5d0tsN1d5?=
 =?utf-8?B?eVZtTHJCa09KOC85T2gybDVxRVBYaW11K0RYN082bDdKNFBGZFZpNEJkb0Jt?=
 =?utf-8?B?MVh0R2IvYzJqSTRlTVBKK3c5K1NTQjh5ZkQ5clowSFFyaXJWRSs5aElaYmFF?=
 =?utf-8?B?V3p1VDRCTDVjS2pOOUk2ZTdEV0RaMjlkMmlaWjdHeVhnSUtqcTRqU1IyY0pT?=
 =?utf-8?B?RU9sdWVwRE5aalpkeHUrN1RrRUo3THlDcUNNa0c0UW0zSzVEOXBEZ0kwbURK?=
 =?utf-8?B?UlVpM2xKVnBWUjZMcFVHbnMxajg1ZDVQV1VVUDdCT0ZRZVV4WVZqR21Hc3BF?=
 =?utf-8?Q?JjazynlUS7ety4rc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac563362-fe97-4132-3924-08de574b5ccb
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:10:32.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt5uYVSQ28zKAN/8YcV6v+5MIcKwERmI07CUgjuTxy1Sy+4/lgjgfhc+P736q79TKYJ7chwSFUxkqhmi4aVYxXgwesu2tjFgGjmHD1tJQXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11256

On 2026-01-19 06:03, Peter Zijlstra wrote:
> On Mon, Jan 19, 2026 at 11:30:53AM +0100, Mathieu Desnoyers wrote:
>> On 2026-01-19 05:21, Peter Zijlstra wrote:
>>> On Sat, Jan 17, 2026 at 05:16:16PM +0100, Mathieu Desnoyers wrote:
>>>
>>>> My main concern is about the overhead of added system calls at thread
>>>> creation. I recall that doing an additional rseq system call at thread
>>>> creation was analyzed thoroughly for performance regressions at the
>>>> libc level. I would not want to start requiring libc to issue a
>>>> handful of additional prctl system calls per thread creation for no good
>>>> reason.
>>>
>>> A wee something like so?
>>>
>>> That would allow registering rseq with RSEQ_FLAG_SLICE_EXT_DEFAULT_ON
>>> set and if all the stars align, it will then have it on at the end.
>>
>> That's a very good step in the right direction. I just wonder how
>> userspace is expected to learn that it runs on a kernel which
>> accepts the RSEQ_FLAG_SLICE_EXT_DEFAULT_ON flag ?
>>
>> I think it could expect it when getauxval for AT_RSEQ_FEATURE_SIZE
>> includes the slice ext field. This gives us a cheap way to know
>> from userspace whether this new flag is supported or not.
> 
> struct rseq vs struct rseq_data. I don't think that slice field is
> exposed on the user side of things.

Yes it is. (unless I'm missing something ?)

See the original patch of this thread at https://lore.kernel.org/lkml/20251215155708.669472597@linutronix.de/

--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
[...]

@@ -142,6 +174,12 @@ struct rseq {
  	__u32 mm_cid;
  
  	/*
+	 * Time slice extension control structure. CPU local updates from
+	 * kernel and user space.
+	 */
+	struct rseq_slice_ctrl slice_ctrl;
+
+	/*
  	 * Flexible array member at end of structure, after last feature field.
  	 */
  	char end[];

> 
> I was thinking it could just try with the flag the firs time, and then
> record if that worked or not and use the 'correct' value for all future
> rseq calls.

That would work too, but would waste a system call on process startup in case
of failure. Not a big deal, but checking with getauxval would be better because
this information is already exported to userspace at program execution and
available without doing any system call.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

