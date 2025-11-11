Return-Path: <linux-arch+bounces-14654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D593CC4F19A
	for <lists+linux-arch@lfdr.de>; Tue, 11 Nov 2025 17:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308B63A8829
	for <lists+linux-arch@lfdr.de>; Tue, 11 Nov 2025 16:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EB236C5AA;
	Tue, 11 Nov 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="W9KAFYza"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020087.outbound.protection.outlook.com [52.101.189.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2626E14C;
	Tue, 11 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879355; cv=fail; b=HXH9LsKThwWBvrkz+W27ZOeVmAtAa/MbYuXtm09y0KpbYehEa5jsY/JXT4JphWLTAwm60jbIpeAHQnwjvEtJEEOOnmatin6In1BgxbU54QZarPAyLyPvPaFtEpVLrvaweugjRj75RNG9oHjtLZMVeM9f2CG21heN6DOdiwSrkm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879355; c=relaxed/simple;
	bh=eqg4Cor3xP6nd3M5WBBbvxfcoVm1kt/wBFN/Q++/Kx8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=icnCgLbkX1uynH+caa2YADgydvQ/9qTDLATmTA9TSu6WX3ybXWwLY5h46Po+BeAnXIXXxg8QFtNks2zHkEFS2DBzfV1AalZsC/HEEdCZO9Tlm/UCJ9CIfoZPsXKsDERKP/1StbMF5oXcXw3DLG3oym0lsEtY6sih9/KZPMn93ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=W9KAFYza; arc=fail smtp.client-ip=52.101.189.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huTShDnWVE5j74U17QXc2VTrGdFnHNX0j9qlEqVReRdIJy4sJ3RfpUOMBez6EPTYt1+ePGjosNPPWCDISgF9GeC82BC7MKKzoGuSOE9ZMEBzjS5Zn/ztiozxZWs1YT09/nvfG0oCFrh1w7JJQbAfNawMuwrgVM9EZem2QxbfFibWerkUdAmenbOuCCvt9gjZQkWgS4xlZEx3m+nJJHbkM+DmdLNBqHbzB7/5HCsjXlWbPe2xJGaASi5R0u9cYdsOvXZ4gurHRRJ3gZA1dUJpA59Pg857w6jxjGM4JjKjkooOvbB/V3Ud8e6oBoriIUx3Ln/HRsmc/G7Za6+xHM/M8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g9h0ggTNIQ6A1X735k4Tp4FPvNcT4CBFJR9Fr1WEDU=;
 b=sZH4dvF7bUa7PD0pyAM+2kdbTqrX4scQrThn65X4O/w9MWcxGGtCfbES76+vwDVELxJGHeSiJCub+A8QUlUIqsGEPgQG6/OPPf1XZ2Fykf4g+IPow4svY7hIlIaYyX1dDLy6lo/uYDGy4K+vKmBujlUSVO+MeHkN5D++IiMu9Q43dUzaLrWaD/XLQx+eYmWj00Y2ovep9U2wWdjNTL03JNd5NxnNqHsui5uYZehQA7tgAMb0LP8QyglElEOR3+8qnRI1UzcZdMTb67SeAdGwB1YvqFzaZ8aOE143qvVasrlyfEmiOuo/cDy74z6wr46Ubji7ec/syJ+IlbjhilJWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g9h0ggTNIQ6A1X735k4Tp4FPvNcT4CBFJR9Fr1WEDU=;
 b=W9KAFYzafpCIUVC2sX/Ayytu1AUw3kSZAPHIDQEdP3jjQ4GdrPU6XuQJhmKn+0caqZYL0XOR9Ho1K5ubi+SkD+VokXYQN4fDk/CvJdPJJKqXevuWkeFsx5hzWhGUHaG+kr4I4jnbC+UshNk9pw6Lf462KBnfTwXxFMII23lBpqWPPgiizRCjYskBvLP4OVn575opa7oMzoiTngv8Urgqmwpg4eUxBjI7sgsPeb6AFd57+VZ/qNP63g/+esXIt0Kg6jMmJHrqlSzTVHk8wgjP/PaZNAgJgN50fYosbt+TgAwgVaHj9cLzvqr2DAF5LrlNCozn916wK7+jUcMk+d6tZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB5675.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 16:42:28 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 16:42:28 +0000
Message-ID: <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
Date: Tue, 11 Nov 2025 11:42:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
Content-Language: en-US
In-Reply-To: <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0470.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: a422375b-9baa-47de-6e88-08de21414d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGVCeWd0cHovemliYklJeEE2S3pWMHhIbElHeFgwZWVldUVYZjJpdEZiUDJy?=
 =?utf-8?B?KzVXVUY4NzlWVi93ZXNSL1k1Q3lsd1VYVi84YU9Bc0FQNzVFT3pmcXYwbCtw?=
 =?utf-8?B?WVNueFJ4c3V2MlBGbkE2TVJVWHcxRjVEaUZzTnFESDZNbCt5dU1URlNnL3Js?=
 =?utf-8?B?anN1aEppbEZhcjF2OWdPbUJINGhqaGczUm5RRUUweTN0WkRCRkxVeTltbjVG?=
 =?utf-8?B?QnhleTc0cTRndFVtWlFiWExZR1ZoZ1dMbWJSZzNWVFFtUVl2MjFuLzkwZ1RP?=
 =?utf-8?B?MUlkT2tJZGNLZk9PNTlxNklCeWNkL2V4T3VscUlENGR5WlJUbExWWUdiVHVZ?=
 =?utf-8?B?NDk5WGpHbm4vbVNEN0gxVndsZ0FMdUR4NytVa1BoTWxxN3g3bkZEcUlDR0Jj?=
 =?utf-8?B?WWYxenZ3Tnk5L3dSYTE0MjJkSlVneFRCNTVYQlRaeWNPYnZNR09NNmRqVS9G?=
 =?utf-8?B?VEFZZTkzaGF2Z3VETUhleDJpTVNlNlFMYXlSZE5xQnpudkhmaGtqRWdmTDcr?=
 =?utf-8?B?eEZrclA3SEFFZnpUNmFsTk5QOUJIbjJWNzY5TmpRbWZPZTlRb3o0blI2U3Jx?=
 =?utf-8?B?YTZxcWV4c0MxNjFaWUpBUUp5c3NrQUpsM25zeDRSV0JBdUczNWQ4aXhJbHhS?=
 =?utf-8?B?bXNiamxhelJVNlBuYnNtNnNWUUpFMHJEVUtWNWFOckc2emQ3amxLUEhXN0JH?=
 =?utf-8?B?MjRxYU80eTJ2aytpZEJuQ0NzUm9VekRWVnU5YytlSElxUmVjS3VLd0hiSHBF?=
 =?utf-8?B?bXgwTHNReXNndXNhVDJLV2tNbHYyWmRUbWpvay9CZnR1UnljZEttaGFWSUJs?=
 =?utf-8?B?TmNlSFNhb3ZnN0hrQzZLRnczWG9iNFZBSW5PSHlzcUt2dHU1ckFMSjZvYXBX?=
 =?utf-8?B?RTJBMnZ1TTBNL2poTWtVWUMvR1BURDhRRFZRRlVvZzFDaCtoV25wOU9URkF5?=
 =?utf-8?B?ZDJVWDFjWVFtZHQzeCswMVZheThETVEwMnNqdDlwR01tbmdHYkxMcmNNRFdt?=
 =?utf-8?B?ZmZkRjY0ODNxOWYrSVltK01mZmxIdWJSZlpFT3pYcFdTVS9kNnB3VCtXYVFv?=
 =?utf-8?B?NUlsNWZoTHBPb21hTytpV2syODhrR1BaeVovK0NvSnhOSEpBcU4wUVhxN0Uy?=
 =?utf-8?B?bEpRZmFZMDhhYll2cEROSVhIM2xJZkowVWtuTCtWZVJJTjhJaTlSY2s4d25y?=
 =?utf-8?B?ZTlLM0ttbmZkWVlZcTNhWGFXYy95MTdvQ05HZXlIdXMyaHRjcjIzd3JBMVo1?=
 =?utf-8?B?SmZsdWtqdlFuTm9sb3dlMHV1T1MyWmtvc0U4NmM1M0ErTllKTC9xcWl6Vzhq?=
 =?utf-8?B?MGc5WVFqUm95a3QrUlFLTEdFcmQvMzhzYTBJTG9VMWxXT2xlbmNPUGJZZjJs?=
 =?utf-8?B?V3VyVkNjMkRwM0I0QnRVM3prYnBQaTNySWs2R0N1ZkMyK3hzekdERTRrSkxs?=
 =?utf-8?B?S2dJcU5rVyt0NXVCQ01QcEQ5UXpTSUN1MC96K2tLTGxlSXgxZ1pScHdVRTY2?=
 =?utf-8?B?L2l3bThVcWRlbFR5U2lLTTNLK2I5anBtOUlBQmNGekJjMXVVMVZnM09RRmtG?=
 =?utf-8?B?dzNVZFgxRlBNMCtvVUQxOG5MN0JsUkVPNWp6ZXJldDVQZkpJTlJpcUx1SmUy?=
 =?utf-8?B?MmkrS3JpbFB2ODJOVmdqeUtaUUNMU29lSHhuR2c0T3JwTEd6WDZVZmhreXlj?=
 =?utf-8?B?Q2FDTzloUXlwZzV1ZW5kT1pBLzdxZkRnQkZPcTl3TS9wR0REeDRES3FNTFFK?=
 =?utf-8?B?Qk41TWx4SG5mL2Fya2prUnJDek1McWJrZUNRbFQ3eDdLNUpoeFlxTDI4T3Rv?=
 =?utf-8?B?dE8rcU9OVHhMZW5PVURNSk1KVHF2ejEvbE1BVXFQM2VEOXBhaFhCV2JienRp?=
 =?utf-8?B?c1docVJJTkZxV0FONmkvWkgzeFRnRFNKdVNHTU9QOHVFSHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVAxYTA5emxRUDNncmFZdStjVnI2cjcyTWJzWWprRkFKNmRsM1BTR2FvWnQx?=
 =?utf-8?B?cUJhSnZsbWxWSTRVUWdFYmNLdVZ0OEU4aEZySkNDN1NEMUVoQytqQ0ZWNWpH?=
 =?utf-8?B?bGRaRGlidkxab0h3ejRtcW9ZdEV2Tk5yaGVoR09TSkpHeGpqT1JZL1V4YVFw?=
 =?utf-8?B?Q2VpWlNBL0RzK2lGd2xtNG56QkwwU3NhalRvVDIwbXQrc3VkUGZtREZHYjJD?=
 =?utf-8?B?V3A4NTNsWkZRNHFNbjBWd1c1eEdCOTRubG1ESE9hNnpSKzdkaTV2ZHJSQ2Rz?=
 =?utf-8?B?Rm83N3c3ODlVeko1RDRvWGd6MDhCc3doMUhxWE0zNHlxaitwakRyRVgzSitY?=
 =?utf-8?B?REhXZXQ4eUZEK3pqeVhhbk9vTE9UQlRqWDJZTFlscFhkazZzd3F0bUhHUExV?=
 =?utf-8?B?Ymk5cmV2L0VQUmdaZyt6bVpSUnpSSENFOXZ2YXphVzZVcnBCMjc2c0pFTzFT?=
 =?utf-8?B?cjZaYXBaV1N6K3diUTBBb3BodllCS3FSczRWNkFodmpISUNVTzR2Yk1hODVU?=
 =?utf-8?B?eDJ4YmVYSWQxV1cvYnBqaTgrdlhpMFY0d3BEbHZvVDBEYllLWU00N3ZMWWFY?=
 =?utf-8?B?MU1uQU4ranJZbTI5Z2lzbTJrQ1Y3NWFwK0YvWGFPbkswVWVxSW5QRmNHUjRP?=
 =?utf-8?B?STBpQXlNeGg3TndBeXBUSWxKdTJRL0JIWDZCTEhmOExSTCt3MkJCRWlmTlRh?=
 =?utf-8?B?dWtFMlBGdGhReTVMK21hQzUzRzAyb2tiWXhCakhEcWVPcW5UNC9yM0hzZ25p?=
 =?utf-8?B?d2Y2S1pCRHBscmZLRjJocWZzMnB1U09BWTczV1J5SEFTZmdEMGk0cXhJLzlk?=
 =?utf-8?B?bG9RazhoQnNkK2tIYTlNSFJ1dzNyOTZoRlFpdlF3SXdBUVdEaGFObjJTOERz?=
 =?utf-8?B?bFhIeUthYTVWbUU1MTlSMWc1VFBxbW1RYmFxeml2dnpMcXBRci91ZXc0WXM3?=
 =?utf-8?B?eG4veklzaGJRWTBGZzlOOURyUlo5OEt0ei9MSXFla0owVXNPZXNoOGFEZGVt?=
 =?utf-8?B?R3B5NDVZTCtTYnAxeFlYc2h1QlRnUG5hL0cxVWNiekE5cjVTV1AwcTRmaUta?=
 =?utf-8?B?QUduaVVpRW5PVWVXMnRlOFVHMCtmeXhodDhaS2R5d3pMTkVCTUdVeEQ4SjBH?=
 =?utf-8?B?a21wNld6QUN4RjVQUmhBRHp3Uk1UZFZYdDNBbXlnRTU4K0l3OTRCTUlDVGw1?=
 =?utf-8?B?QTN3NWpWQzdzM3lmWmlWMVBmZm0ycmFTVkVJMmptTUxudVEzL0VhbUdkeXJH?=
 =?utf-8?B?azJpRXd0eW9oU3B6VGsrZ1dzb1p0b0huWFZudStXQW5weTlOMHB6VUJ3N0ZK?=
 =?utf-8?B?QWFsQUhCbDdHaWVrNFNUeC9wN09ubm82NGt1NjhoUWxydk5qZWticzFBZGVG?=
 =?utf-8?B?LzdYai9oMEZ2eDROWDJXT2dadWVoUG1CMVl6TVVwZmQ5MHUzcDh5Q1pwMmlo?=
 =?utf-8?B?L1J3NE5LcE8wS2tobUgxdFlJaHpUVVFlWTBRSGNXU3dsTS9QdGgxRUdldW1K?=
 =?utf-8?B?RVZCUml1WnZYNFpYNmJzTnRYZkVHaVVaazNxN0lrZFoyN1hKeHg4SWZBNnpa?=
 =?utf-8?B?dDFxbEhHdktDN0VwVTNvSHpzVmRsWG1pZDdOZ0xQZm1pRzRxdTdSUHJCN3Bm?=
 =?utf-8?B?bVkzKzhLRWRrWW52a1AweDB3VU5JNXRBT2RuVEdubGlHYWlSdzNURG0rRmhH?=
 =?utf-8?B?UkJQRmgvcGVyT2Q1b1VCcDd1MXlNMEFqRXZFZXVJRmRDVFdXUE11MTdoL0x1?=
 =?utf-8?B?dEV5TE81em83S2tya2czSW9KUjhFdWF0OVJ3VXhDRnZ2bTJyT3RNdzNrMkli?=
 =?utf-8?B?MWg2SUVpMlJvMjFFckhOOFBwVDJjbEVFSDBLTGxCanVGS1RGQjNvOGtoZEhB?=
 =?utf-8?B?Rlh5c3U2TnZzNjB3ZlNJZWVSQS9FUmlOWGU5bWpxcFBGbndJWkk1ektJWGVI?=
 =?utf-8?B?VlJqRDZUZi9lTlA0dmZsdGFmUHdwbHM4bGtycFo0Rkh4OGhxQTZSVHM5QU4z?=
 =?utf-8?B?YmJLMXE2QlNYK25HOCtFaU9oYVkrSC80Q2hUOXhlaGtzTCtWVzJ2ODFJcE51?=
 =?utf-8?B?d0FtSFoxcUFrMDM2RC8zMkdNOXR4N3huclU2R3Exb0MrSWNpMVFKWUYwVitR?=
 =?utf-8?B?dlhyTTFDZzFQY0wxUDlXSi9OQmRIVm8yTXJ6WUZwcjNhbHdYRHc3dWtCMlJk?=
 =?utf-8?Q?Zo3QpLm//mSik/NH5OxAYWw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a422375b-9baa-47de-6e88-08de21414d2d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:42:28.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALwwgPOWYcgtx4hsPfR3h9UE6ItL3gDo6pDWX8NvRabK5PVQ2YACxS7tK+zD0Xgsfu6rAsOnQzDiLL+GBIN38FRwSOxV4GTXwylX/+9f8Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB5675

On 2025-11-10 09:23, Mathieu Desnoyers wrote:
> On 2025-11-06 12:28, Prakash Sangappa wrote:
> [...]
>> Hit this watchdog panic.
>>
>> Using following tree. Assume this Is the latest.
>> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/ rseq/ 
>> slice
>>
>> Appears to be spinning in mm_get_cid(). Must be the mm cid changes.
>> https://lore.kernel.org/all/20251029123717.886619142@linutronix.de/
> 
> When this happened during the development of the "complex" mm_cid
> scheme, this was typically caused by a stale "mm_cid" being kept around
> by a task even though it was not actually scheduled, thus causing
> over-reservation of concurrency IDs beyond the max_cids threshold. This
> ends up looping in:
> 
> static inline unsigned int mm_get_cid(struct mm_struct *mm)
> {
>          unsigned int cid = __mm_get_cid(mm, READ_ONCE(mm- 
>  >mm_cid.max_cids));
> 
>          while (cid == MM_CID_UNSET) {
>                  cpu_relax();
>                  cid = __mm_get_cid(mm, num_possible_cpus());
>          }
>          return cid;
> }
> 
> Based on the stacktrace you provided, it seems to happen within
> sched_mm_cid_fork() within copy_process, so perhaps it's simply an
> initialization issue in fork, or an issue when cloning a new thread ?

I've spent some time digging through Thomas' implementation of
mm_cid management. I've spotted something which may explain
the watchdog panic. Here is the scenario:

1) A process is constrained to a subset of the possible CPUs,
    and has enough threads to swap from per-thread to per-cpu mm_cid
    mode. It runs happily in that per-cpu mode.

2) The number of allowed CPUs is increased for a process, thus invoking
    mm_update_cpus_allowed. This switches the mode back to per-thread,
    but delays invocation of mm_cid_work_fn to some point in the future,
    in thread context, through irq_work + schedule_work.

    At that point, because only __mm_update_max_cids was called by
    mm_update_cpus_allowed, the max_cids is updated, but mc->transit
    is still zero.

    Also, until mm_cid_fixup_cpus_to_tasks is invoked by either the
    scheduled work or near the end of sched_mm_cid_fork, or by
    sched_mm_cid_exit, we are in a state where mm_cids are still
    owned by CPUs, but we are now in per-thread mm_cid mode, which
    means that the mc->max_cids value depends on the number of threads.

3) At that point, a new thread is cloned, thus invoking
    sched_mm_cid_fork. Calling sched_mm_cid_add_user increases the user
    count and invokes mm_update_max_cids, which updates the mc->max_cids
    limit, but does not set the mc->transit flag because this call does not
    swap from per-cpu to per-task mode (the mode is already per-task).

    Immediately after the call to sched_mm_cid_add_user, sched_mm_cid_fork()
    attempts to call mm_get_cid while the mm_cid mutex and mm_cid lock
    are held, and loops forever because the mm_cid mask has all
    the max_cids IDs reserved because of the stale per-cpu CIDs.

I see two possible issues here:

A) mm_update_cpus_allowed can transition from per-cpu to per-task mm_cid
    mode without setting the mc->transit flag.

B) sched_mm_cid_fork calls mm_get_cpu() before invoking
    mm_cid_fixup_cpus_to_tasks() which would reclaim stale per-cpu
    mm_cids and make them available for mm_get_cpu().

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

