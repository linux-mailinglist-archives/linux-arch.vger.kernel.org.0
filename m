Return-Path: <linux-arch+bounces-15466-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E36DCC47D7
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A42583024896
	for <lists+linux-arch@lfdr.de>; Tue, 16 Dec 2025 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0862727E3;
	Tue, 16 Dec 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mqyW87/p"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020141.outbound.protection.outlook.com [52.101.189.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FCA21E0AD;
	Tue, 16 Dec 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897193; cv=fail; b=qaqfmksfZT5hG6aro3p05GpZ4Yjc71PRoWNkVLQfinNntnIAvMtn/av39zba/zJ8/hwnadIUic8u0xQu4M342j5UShV3geHVZg459i03ZBX6yQ682vJlJ2tGXzo3WXm6MYHK1aox5mYRkJ+hF1z3lcpt0XwJkHDU4dmQLtx6nJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897193; c=relaxed/simple;
	bh=gje3c7n4T6hhfyQrUAFPkJBCp56W+kkzHwRFEH40Z88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MSRLaS1/1JztAM66maH3OWFLKm8vsXdXJT+mGmQCOVHbBdoL7OL7FIKsFRLHynJsCvML0Na9oone9X15iCQhu2k+PdUhKeQUcyaX2v196NX0SeRus+L1U5bDL5yOO2lYn6dhOP/vUNxbdGmht4mNSXUwe33K8Kf2tO1OtnIgzGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mqyW87/p; arc=fail smtp.client-ip=52.101.189.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yywguR5Jro0a7JlnRskXj/l3Bd4aFz+uXQl3IRV8rMIWhKwtDzSvRUsAEX45R6UT5wwKLwQ/fKwc2r/6ooNIMGWKEAUx4npxioHQgm5TNNXbUYW0cqzrBF54CFqSFv+UA/nQWG5ab+rFsh6zyDuPtrkHJorykFZ+CRDKWtIqMasUTEjDeG+liN5sUJnFdbWBFuYbVWyA7iA1vGC9kGMTZ48HCENyJCRaZoXTrK9BLqWCWSCs1Vsn5xYxUwlHoH37iK/w13xA3MNAS7PP7CkoRKEu/60hMtOXC8erJSeKVpi4mPIUbI/zIZGeBlFX7QrPEvth3CBhwRlxbZL24/Tp4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMk4ajgKkI8xj7t9Csu9TLerq4rfBPS9IEMUwUYYh3c=;
 b=bdYTVuCs6CMGTB318aGauxeERznFpLpj7AEfy59v8kyVduti50fBw092G6NCRjbNTUuKIGqSj4PhJvXiyzPfalyLYewW9SnxKH5eWGipZ1t3qDOCsK7rj+QIOHDMi/w2zxqnEELsKUAniibXgxLj40DODNkiAI4J3i+dNmWBGXB3W7vSi+nS1FIkfHFELtAdigWnHDRMAtgLI389WSFyVYWBhnobWHb0K6MzzGDhoHiFRA1XI0bTISFgS7qGF+Wyq1sf0HTMPkzyYjMZG9+xPPSZveDR/rd+RHey21HNbmGdxZ6dkz63OMK6G6+Coixk16USxxhUhiQ1aQMbsOHBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMk4ajgKkI8xj7t9Csu9TLerq4rfBPS9IEMUwUYYh3c=;
 b=mqyW87/pkqfUAjyV67aK4VVCq4jbr542t0s2/CxW58CQv4HYBCkQZ/OtEWUb5u0DlFtf7Cn3+sW4sBp2b5jFNmMC5oi3hksQUBKy812v6LTq1V6uhgvYPL1qTShFM/xBZGZrH0BZth/XnCXTLlV9lUXZVTvueb3N0ZJIhAa4SRVB8D2RAr5WUBzkRWncYe4/xbeI67YAIlYkWR5VL3LEhz9XP80SCfJuXU41wDh+oYm1TL0r6k6tU1cl85vphVY3SQmC5sD3bnJkfB9QFiw34TfVkW8eS5TpDqPhE08qsloNHcrMsk82IVH7XaWKSmrYbFT1GnWbmv3YD4Gaf6aN3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PPF9A3978E32.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::56a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 14:59:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 14:59:48 +0000
Message-ID: <69996cd3-fd1f-4844-a0ed-3abd7098db44@efficios.com>
Date: Tue, 16 Dec 2025 09:59:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 05/11] rseq: Implement sys_rseq_slice_yield()
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
 <20251215155708.929634896@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20251215155708.929634896@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0242.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PPF9A3978E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae6927c-0911-4275-dc2a-08de3cb3c1b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTBoeGtxV25XMm9DUnIwMHFaaWFKbTN2R1NQY0lROWhFZ0syYWV0SWVmVGdN?=
 =?utf-8?B?WUVxNkFlUWdYVVhrbHo1VmpHbUptNldmWENTS2VTRGd1SnFxNWUxSlNWWnlR?=
 =?utf-8?B?SGpGRzVjQWRSc1NsMG1vYkJaU0ZDWVQvTEgwczV6Wmw3bzQ1aWo0YXUxMUNY?=
 =?utf-8?B?TGlDUG9lbnBUMGl3WFpGMDQ5WFhveWtyazJ6MXE5TGc2RjN0RWVvOUlUcGo0?=
 =?utf-8?B?a0F6RUhzbFNJeXJaYmI4RHpNM0J6Y2RKZHZIU01hbXlHWkxNVDI2T3JHRWdC?=
 =?utf-8?B?N2syTkhnWUdkdmZYb0lXMmdpcXAxZm56TEord09uOHJDSFlWbytkSTV5c1Nj?=
 =?utf-8?B?ODZyQTN2b0p6ZngyMk1MajNBU3RCbkVSakJHdEtkOFZaMmRGZXB0MFdzS0xO?=
 =?utf-8?B?NUoyVUpzUWliVElrTEhNbERFRU51K0gyV3FOeklGaVdFMmFpcm90UGF2TkI2?=
 =?utf-8?B?N1dUbVNWUjY3ZnRpSHlnMmF6TXdVZ3pKTU1Pd2ZaWTZ4L2o1V2k0MzRKQ3dP?=
 =?utf-8?B?cll2UWlXWittNjBrSkh0YkVXdlpRR1dHS25oQTRkbWRLV2pZRmtoRjgrYXZI?=
 =?utf-8?B?c1VOaGVPVWJpdDZ4UFZ1Z3dKeURZamFJajJMM0pqSjlueXRPbXVBL0xkVzBO?=
 =?utf-8?B?UDhCZE9hSVpValpKd3prZENQMWM2Z1NEWjkwVy94NW5LLzdxV29TeW9IaUtr?=
 =?utf-8?B?TTNnZTY3bUphZUpqUGhNS1ZEcDVPc2JlZVcwWjN6MEsyM1VzSWpTcVQ4U3Uy?=
 =?utf-8?B?QXB2eWVwREkyVm94NGRGbkJRb0tqSFN1ZWlBUlBDRUN2VXRYRFZOWW9hZjJE?=
 =?utf-8?B?RWRVMGlLU092M3lQTzBvNXZnRk16bk5WYldjdHBIQURWdTdORDhya0dMT1lX?=
 =?utf-8?B?dHRNeHFiQzZJN0NvTFo2Zlc2Y3RUQnNqa1dKS0lXRnRBTnJpS2ZRcjA2enZp?=
 =?utf-8?B?NXJBTWYxQVh4d3JHaVBUekYrY3dDd0dqYzVXbngzQkR4VHIxdkd5OXlJcVlz?=
 =?utf-8?B?TFVBM3ZOM0l6ZnBkN0ZXak1qTHZuaHJxS1BJenc4dHExVEd6WUxneDJWN2R6?=
 =?utf-8?B?WGpocFRxSjhhY212VWQ5elJFTDJKMDdTUW85bXVhdy9GaC9YNGJBdFFQNXpV?=
 =?utf-8?B?anQySUo1Vm9OMnNsTk0rUkVuVGRlQnJZemVmZUcrSURNTlNRYVlLOGU4Zm1I?=
 =?utf-8?B?Zjg4NGtMd0R4Wjl6dEhxL0RIU0dHdThEcWczR1pJc2l3WmtvekhUZXYwMTcv?=
 =?utf-8?B?ZWtPL3NKRmRTVlU5MDBjTGlWRHMzUkhaKzYvbjhrbU9yblhHTUFrUDhLbkox?=
 =?utf-8?B?SmpqdjBaYkZZMDZHbUhWK2JWLzJsOWdITFVLdlpIYUMwVUNkanZpTmtvSHls?=
 =?utf-8?B?c3duazJhSTFVaWRhRUVkUnhadThpSmphUnVrNnBReHpkTVE4QllnaWdPV252?=
 =?utf-8?B?cUxsNDVNSkphcFZxN3J4blJ3MVVDaDFwVXQvQ2NUaHMwaVJ5dHVtcXJQMWdu?=
 =?utf-8?B?cmFkbkZXb0JyYUU4d0NEOE1mZUVLSWVsa29vNGVIWlpRbHh1WDZVMndHaFp3?=
 =?utf-8?B?QUdEYTlBUEYwOEQyS29TU1dCUTRldWl4dHM2QUFVSWNDRGtzc2ZhenNwQjZt?=
 =?utf-8?B?bXlOODB3Z1FrdmN3UEdGakhKZ2tYT2pJekZaYXhZUVY5ZmtjYWVjR0JPSzAz?=
 =?utf-8?B?a2wya3duUzhweGdweUg5MWNnRW5Yc2RUeG1naGJCNS9GTDlxd1dTay80WkFF?=
 =?utf-8?B?VWltVUVmY3ZSamtGL1BIY0UrM2wvTzg3ZEplcXZ2b051djhqYXBCVlNMUk56?=
 =?utf-8?B?eWQzdjRLTk1DcGE5M3NpY3R3RlZmSE1LTjFpTDlET2hVMjZhSTh3cDRVZWVZ?=
 =?utf-8?B?Ry9XaEpCNVFUQkVxU1JlRWRGaWxLdkpXYU43TWlMVWtOSFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlQ2TXB1azI5L2F6Y1FYeW92OFVLaFVZdWEyYXZEYUFmWUdIell4a3doUXJ5?=
 =?utf-8?B?bUx0ek91ZFQrV0s4TnJBMHN0Z09XMFhRZ0ExencydkpVcnB4QkZPRTdTM1My?=
 =?utf-8?B?WVpiT0V4MTR4b0xnWVRlamhpZHczZ0dhTnQvNitHR01ycmY0UnNQbEx6enV6?=
 =?utf-8?B?RDFzcjFOekhpUTNRZUJZSldERHlOSGsvNTFoS1NuSmlwVng4TzhUMVdvNjZv?=
 =?utf-8?B?OTZ0WXVMNWg1Ukx5bURLSzZPVGdzSVllbnNVQkFuSEQ3dGNDVklGMWJFelpa?=
 =?utf-8?B?M3RLRmx3YXBhZnpQN1JBT2Qva0hlZzJpcWp5YkFFZmxmNXVQdFRSUzc5WUNx?=
 =?utf-8?B?QnZwdVBwTGljRWFZaUhTSlB1RmFpYlNnR1NMZ2tSc01yQ0xESGpFZS9nKzlE?=
 =?utf-8?B?aHFLMGFzUGdsVW4xMXRrd0hBeEc1bnAvYURZMmlXTFhuemQ0VkJadnEvb2ov?=
 =?utf-8?B?M2V4aE83cnhkVndTdFl0V0IyWWxuQjJRaGc5OUhUdzFrVTkrdkpQQjZFdHpG?=
 =?utf-8?B?SEF6R2twYTk3SWlGb0I3OWVHT3RiNFJjbEk0bWYrS3p1QjdqUFczemI1N3c4?=
 =?utf-8?B?L2NJeTEyR1BlbFJkbUVHR3hydGtpOVEzNStNQ1NiN2UxUXF4MmtINzJUNVdW?=
 =?utf-8?B?eXpxeFY0bm8xOUhYZWI2NWIvL1dRbmFyT2N3cVpGMExHUS85dHc3OUhwZUkr?=
 =?utf-8?B?VWliSEV2SFUyWWJnVzdROC9OK0tCeGQrUjVmZjcyTXZzYzBlbFZZYzhybDNy?=
 =?utf-8?B?UlFLT0daMlkwQUc1NDlHckNoZnhGN3hFMTJoR2ZJUGhBaGFBNkZYMGhTNjEv?=
 =?utf-8?B?bWd2cmo4SFczdk43eHFSdVUvUHV3bWhjM05xZ0VuL2VTNmp2UFNkcEl0RXhi?=
 =?utf-8?B?QkRxaVkxNjI5S29KQUx3Y2hyZ3JQUUc0MnNCbXBKYnh6L2wwTTR0UGpoclFu?=
 =?utf-8?B?VWVETWdlc1BUVGR4MlA4ZVJsSDF0OUk4T2ZzbHMvazNGQXl0eXBPYXgvRGhB?=
 =?utf-8?B?RmlrZy9jWjFSekZLNnpiS29GcUpENUYzZHNPSndVeFBwM2NWVmNhdUo3bWI4?=
 =?utf-8?B?ekhyclpBb0lQbmR5SnVEWVV3MGdkcmVsOU9hajZqQ3F4OWtiZEw3NDROTWZR?=
 =?utf-8?B?ZnBsZE9PemlDdW1KSVNQaHNuVFFVRk5VY3BLaDdIcTNjRmF2alpRK1JaZ0xV?=
 =?utf-8?B?QTVtZklGQjNRc251Um05eENlekJFQ1VuUzhOTmszTHdWVGU1UVk1NFlJOEVL?=
 =?utf-8?B?OWlybHMvZVpYc1ovanAza3pHSTJIL2tJV1VBNHpITlV3elVLQ01GMlB3R1FZ?=
 =?utf-8?B?YVQ3QnFjZzJ4YkpuNEg1Z0NpQTJnT1NNanM5eWpVMkNYZUVvZC81bmZodkdX?=
 =?utf-8?B?OVNvVFArajZDdmFaUUdpc3NTMlpURjhCM2YxbmZGcnVMcUZjOVd1V05rdjdR?=
 =?utf-8?B?M0JDZktjdjdmYnlGbzVsY2wxZnhrekxjWlRoZ2hLQy96NnRtMmowMzJ0aHdW?=
 =?utf-8?B?UEgzMmh0Qy9uWktnbjFuYUI3YnVtbGlYWkdLOXI4NVM4azNwZWU3cVdRUUFI?=
 =?utf-8?B?eHB3alA1QW8vK1B0dk8rR1dVTmQ3WWlrSXhPWU5hNTMwdXl2alk3NTdtajFH?=
 =?utf-8?B?SGZnSmRkeDhGdnFZREdaYzVmUFVEQW9SVEExR2NiM3RMdytVZW5JeE1tYTBM?=
 =?utf-8?B?aUdSeXl6bmNXSjFFTTAyRTBEek1BMzF5WHNUK1l0ZkZ3MU1aSFZGZElvWXlv?=
 =?utf-8?B?T1ArTXR2TEZUclc0TTgwc3VLSzF6ZFdRVnBhVGRpUjNXTlRaWEY2SjdtK3dj?=
 =?utf-8?B?MTFOdjhwdjR6ZGZpbzBKbzIzNy9TaXh2VHRNYjV6NVBuVVpOaHdiZldmUHhp?=
 =?utf-8?B?bnIwQW1STUJpRWQ2STFMOHNoUVNPN1hDSGJYL1N5QXRneG94SHNobGVHQkVQ?=
 =?utf-8?B?cWFQNzJrQjVqRmtBMzRML2kxRGx0d3JDRWZkbzJlT1pubUJtTW1kUGNSc3Za?=
 =?utf-8?B?Z2ZUZHVWL2dURmZJdHAxL281TFkrR0YxZUR5M1BQZmJyQytqN0p5eGF3NXpi?=
 =?utf-8?B?M1A4am5MQVZJTVpOK1lkcmIyRlJ4dkw4MnpSL3pZbG9pUzBpL2x0cFVuUWxl?=
 =?utf-8?B?T0FObEltZjQvdVJLRmtueU1wWmJjd0t5bVg5cCszeGZlUXdjcmpOZ2J4NGht?=
 =?utf-8?Q?RGkL/dSdhTnRL/jzX9+JaNI=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae6927c-0911-4275-dc2a-08de3cb3c1b3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 14:59:48.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VWXodNicGSI6Bt6Y+2KjALOArRxcgX5tWtE6wMndNKumse1Dgmo9kLPSiK9wbfUUtkx8W+aWkEqylrSkvo+hs4nE0X8nqVlpkGvxX01dVuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPF9A3978E32

On 2025-12-15 13:24, Thomas Gleixner wrote:
> Provide a new syscall which has the only purpose to yield the CPU after the
> kernel granted a time slice extension.
> 
> sched_yield() is not suitable for that because it unconditionally
> schedules, but the end of the time slice extension is not required to
> schedule when the task was already preempted. This also allows to have a
> strict check for termination to catch user space invoking random syscalls
> including sched_yield() from a time slice extension region.
> 
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

