Return-Path: <linux-arch+bounces-13502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D5B53825
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849921CC1D0D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B8C31C582;
	Thu, 11 Sep 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="b/azIl2x"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022077.outbound.protection.outlook.com [40.107.193.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBEE21C16A;
	Thu, 11 Sep 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605776; cv=fail; b=Gcrwz4CdGCo7Y+LlawEhRrTOrG+kmXRLVnEUjgyHjW2ndDXSbPsD1SrERScIOsIT3eKAY7LuIV+d7BJ/EYrgKJeIdk/3MFlnTJsV76+/ra4IM6bsoZiose+KBe1cwsfu8fCMOqnEq2STf2ubJnhLtpvLVOnowkCDWxj7XYDQOQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605776; c=relaxed/simple;
	bh=BhMS2+R/KaAWrBiwFu43FvHEWvz2MUtVRt8WmkSCUm4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LeZNrlOtwKcwWueT/DleCK/esaCm2/HE0St9bl9j/4cdX2bqKrcMqulxtbFmCyZw69n6E3N9EnxMlLgsjVitSUZav6fyftPBhAHuxXc0pyXPp1hvN34wPOv+2bOFreqbMqK1bakOOOXG+ccSzQiZ3BoD6Y7w9O0gSo7GCBmd6Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=b/azIl2x; arc=fail smtp.client-ip=40.107.193.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3Ta+1EA45Dt3MRRChvwpff3dkCmWEhZfGCEcY+HBBKHXxaPhMSYQEXvflohHlZmapMKNM6s70cl8dBC2EidsJ97Fs3R5l6Sevilou89671WkmsAZy20I7s6cC68pkJMgtURZlQM2CZiC/szE5keXeTZo29+NewToBo5ourMPxsfgY2NR2TI/kTb5bDXvAsbIfI+kNZzeLtjbjFLbfdGwlzuo+KepsG0VelLqqkPFsI33UVo2xGSqpdpBUj1SPMFbLt18O82HyQXeNp+c6zjjntrXx/TKC9hAJhVXrKEmoe5wYaY1g9J0uan0zGG+eqwIDYNQygxeoSxX7NCzaUTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/z7lNaA0EbPhj4fk2DjYqC1ZqsurdoZZph/j3hag0c=;
 b=yQaeImtDaahYJ/kschSAXGZENl/EXLVcu+qbNQfa2Mw1BLsxJIhYXM5nJMwtzzPH2yeFE7ChDOiZkqnnp7roSx31S78XKPBkruQvmqRUSeutu+lHGa2OJzjXn8IrXRTHcRmRyM7p7CZplu2yTwNRok1ICF/Vcyif3Sb8WuaezX1s+xAG4weE7nMnbNQwD6ZHNTkz179tsVr0loPUeFQvz1FgjHDYK/f8qcOFlKu1+o832DGN0yGJqAPiQ0SgGFfokRnMSAhYGOR5xdwVNDq92bCkYcEQXbdBVJgY7ay8eLFKI23hKoaYH1K+pGRK1T3N94t5WDouF4iqEliTHha1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/z7lNaA0EbPhj4fk2DjYqC1ZqsurdoZZph/j3hag0c=;
 b=b/azIl2xfqF8LH5ZDk93k1jZM9/YANhyJt29CwfNeQyIZ+L9z+Y8YzduNZZGrXBy4NuqVQ+sg/TrURtnWdUqC3iTzg4en+nkuyfgdbhv7E8Re9pkjF32uwdDzj6VssYHRCeN/FdvncdvdVxQnSY5WaWiFi7WBbzcj+a8xPzOUQUMR66BncvJEBJTgd4tyA8H73+ihFP1Uq+cZnvpeUBre6f33Iq3+gElnVJ1dqfc06dBdeL1HKxFQO5WFA6k/dj9nEMmgpuw542/mbtKMvmaVzD+wfju7msjl75MsGU0c8R4TudKZhqcRt6mGQfyRxqw1Smv0K3sbKX2ofEywzpYfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:49:26 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:49:26 +0000
Message-ID: <010dbadb-0eef-4a35-95c1-932ad26cff21@efficios.com>
Date: Thu, 11 Sep 2025 11:49:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Michael Jeanson <mjeanson@efficios.com>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
 <2ce887bd-f0f1-46bd-a56e-7e35d60880dc@efficios.com>
Content-Language: en-US
In-Reply-To: <2ce887bd-f0f1-46bd-a56e-7e35d60880dc@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::23) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de7698b-ab1f-4e1d-4dac-08ddf14ac8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0daUGtueGNXMDdtRzBmcFNzeWJpZHZ0L2Z0eVZTN2ZBNXg2RGZwQUFTdWpT?=
 =?utf-8?B?UUJDTWZ3aUZ5Zkdqa1l1MGxtL1A5TnRnaWsvQmxYVEFteTY5TnZtbDArYTVj?=
 =?utf-8?B?dm8weU9WQ2hXa1NrNStGVzlZT0VoT1pTUDYrNElBbTdVZmxnTDN1eVFtaWdz?=
 =?utf-8?B?eU9LR0dTeU4yVytiQUh0YksyK3JSQjJRcUxXT3NLMk9ZaHlyeHl5RVpGbmUv?=
 =?utf-8?B?V1F2b2NsaWluV2R3OWUzYjdQTVdEVGVtVHlnT0NIUG4rMXU3Nk83b1I3TDRr?=
 =?utf-8?B?U3Y5SXdGSU56YVQ3emRSdDRNTDc0a0t6cXp1R2lSdzlndHA5NFRwMTlEcVF4?=
 =?utf-8?B?UTZzdmtWczVjTkZZbDM4dlJRU1NaYVBvQlFkdkZnbGhFdytIa0pFSEU0ZjJZ?=
 =?utf-8?B?U1NQK1RMQXV5Rm1NaGoxK1A4dDhic1pCNDdVVHNCU2NnVXZTNnk2eWhrWUg0?=
 =?utf-8?B?cEx6bngwV3A3SXFOQXR1dkJoY2VlUFY1RzNQc1lEaS8raGpMcFY1N091eXJy?=
 =?utf-8?B?UmNqLytBZTlEN2xleE1sY1U0a1BtWEh6dUdPaCt0NXVsekJnMEc4RVFSRVpW?=
 =?utf-8?B?aXJ5TC9jK25oODRrdjdkek01RFdvWTVldUlycGtMa2dibmtwaTRuc1dNTWg1?=
 =?utf-8?B?b1JVendlVWk0QkxCRTNwUEVML0JRWHpGVVpMRXZNcTFsM0FHaFdiM1lBNFlP?=
 =?utf-8?B?cjI3LzBqWHFkMC92T0ZtbU1BVWI4U1FNdm5ZODJybmFSbW1vTkpobnJzUWxO?=
 =?utf-8?B?N3hYRjQrc1RNYzRteTZscjJVSFI3djUrLzdhOFhhUS9kRG1OWkNyK1ZDdTZ5?=
 =?utf-8?B?Mmh2RzRzVGVGaTZMeG4rZ2NHQmxoQ1o3M3d5b1p5ZTlzN0NkMStVOURvZTVz?=
 =?utf-8?B?U1hZVW5LN0RIelVnWUF6bzVrYXEvbFRRQXNPR1NQK1RDYzNnSlcxcnM4alZj?=
 =?utf-8?B?UTlZeXRrMll5THNKYnRyMVRzOUR0ZitLc1pnWlhZTnlnWncrYTRLL1o4bW45?=
 =?utf-8?B?bGlXd21vOWlvVGgvRVFVZDFOVTJHa1dablFWazZSNDMya2s3aDJqVTJaRVBB?=
 =?utf-8?B?ckE0R3dIQmo2dlA2WCt6T2ZteHIwK3FpdkdIQi9kcHlrZ3NFWVdURUZyNG5C?=
 =?utf-8?B?cEtaeEFlc2FoZFNmK1k3SDJrOWpxZjV3eDljanZ5cllOUWlxdmp1R0ZRdSsx?=
 =?utf-8?B?UmtTWmZud21IVGxLK3VXUStNQkoyeHRod1ZNdEJaNFFKYlZaNGl6dk1vRHNt?=
 =?utf-8?B?V1RidXVrR3c5TURLV0tIcktWSGFPODYrNFhMa21malVyRlpzZVU1UEdKbW80?=
 =?utf-8?B?MHJXZEo1MCsxYUtlU2txaDFqL3p2aWszNmxBUXZjUEFFREhtSEMxSnNCdUZE?=
 =?utf-8?B?alpoN1cwM0N4bFhadWxNdlBNK2NHTTlvRzl6a0l1UXpIazlXU2o5Q3hZa3VI?=
 =?utf-8?B?VkhtQ1hEZ29WOWFIK09wUDE1Tk0wY1Z0YmpZZkZlMnNsRG0yMnNOSWdlWmZP?=
 =?utf-8?B?Wm9NeHhvY2F6N2dlL3I4RVROempaTzliZDlCMG9jekpkUGpwL1dKU0prZlRZ?=
 =?utf-8?B?eVdPRURleWU1ZDF2K3BZQVc5c1hCWTRpVEJBcEpGVnJRWmpPeGN5S3JPVk96?=
 =?utf-8?B?M1p4MDB0QmZ4ekYzdjlYSERWYWpmQ0s3WDZOMlhXQnBkZURkb1Y5YnVlYkl2?=
 =?utf-8?B?NlZFdmpHdDNUK2dHaEpFYzNEUWNnQm9pTW11VHo2S3dOL1BiUURUZmFiTFN1?=
 =?utf-8?B?OFMrREhUempwS0hvYmlNbmNaYTF5UnBDS05xbGh5N3hJUUtjRVQ2NFd3bXox?=
 =?utf-8?Q?AUCGdSrv7qC+bmxe4oRyb0VHbAvm4SKdNO6ZY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGdmSFNEK1dBTkM0RGkyRWJZVXl6aWptbFJQRGp6OUJIM3d6eHZGRnJJMDkz?=
 =?utf-8?B?MjZqTnQ1WHk2emdiSkZzdlJkQi8zSjNadlRsUE85M0JqTENUK1JYd3Zac3kz?=
 =?utf-8?B?ZFREQ21mM0x3a2p4WFB2eTZKM0F6VmtHL3h3dy9XeXRBQ2w5Mmt1bUc1S2E5?=
 =?utf-8?B?ODc1OG01V3J1RGZGa1ZiSm8vMnFham5UckoweXR5SmlPTEZ5YVJTSHJSOUpF?=
 =?utf-8?B?MGllOG1MZndUK1lHU2F4eVBIWUtUQVAyOEJCOGJaQzJ2Yy9xelo3Z3pBeGM2?=
 =?utf-8?B?TWtQNWFSaVJqeVJnT0lvdG9UL2tSYWVFckRRNnRxTmJtZGMxZlRjb1h6cHZH?=
 =?utf-8?B?SSs0WXdjSFpwdkdEVGcyOWJuaGhIaEJwcTdyOUhVR2xSRE1ZT0RQM3FjSE1E?=
 =?utf-8?B?SUowN3VoMTFWN3BINkpWK3BaSnNNeUQ3SEh1WmN1RUhHM3BhYzJJUVk3NlZB?=
 =?utf-8?B?ZitOdFZIUlZ4MEw5Q0NqMXhqc0NNSC84UU1OS29lczNLaTlMalVWdVludWI2?=
 =?utf-8?B?dksrUFAxRjhkSXlXanQzVVZaL0lNVXBkeUhGOXk0RVloS2VyWlZiMTkwaldm?=
 =?utf-8?B?Sy84TWRrTWgvdzhCNmNQTmcwdGl0RHZuR3czaXc3OEJmYmNYOUU5RlN1Nm5m?=
 =?utf-8?B?MGFSd1l6WjRnUDFXRGpJbXl6QmxKKzUvcTNTTXRvSEM0UURXbzVaMWRDT1Na?=
 =?utf-8?B?OHJiYlZCTkV5bm1lazQzbUZUdG1OdUxDMVg0bUZLQWVQT3hiamRDZml4aXRj?=
 =?utf-8?B?V2Q1NE5sWmlqUTYxbmY0S0xRbEoraUVFdFhBTVF2alFROEwvTG1Vc3U3ZEtX?=
 =?utf-8?B?K1lXT1lBUmNrZWRVeFNKZjFYZkw5OGpQeW9xaUtxZmw1VXE5TVZ0RTRERkxt?=
 =?utf-8?B?Z0l3bWhKRmRBa2tVT0hVNHJDMndUSGVaVnlRVmZtamVvbDBhTS9GVWJsVlJv?=
 =?utf-8?B?aFJ1dDVORkp3djZxS2VneE13MzhCYXZabDJ4RDF5aWlaRFltNzB4Q2ZqOXJ6?=
 =?utf-8?B?YUhkRjdSS0dMMkZSNnlQTjNiNGFGNGdWMGQ4dUpGZ0FlV1pPNm0vMkFzWVp6?=
 =?utf-8?B?U1BnTU1xNGgvYUdzT3pYVUhGelFwejFiMEJDQTg5UjVEdFRhSkcxNm1TWVky?=
 =?utf-8?B?dHJ1RkRnd3pmNU5zSy8zN1NDa2FSMmR3NEJZM252NW1sajQ2NWgzMGNGTUFZ?=
 =?utf-8?B?QXhrcko2QTNRa05NUXhwcTArengwdEw1ZGpUdGJyc2lQUmFzOHozaklxSGND?=
 =?utf-8?B?U3N3MTlHc1cyQlpmbkQ1Q1pabkF0Q1IxR1YzVWFhN0s0cnN1N3NYamFoL1p1?=
 =?utf-8?B?UDYzaW5qK1RMVWNxd2txcWhzQ2pVbVl5OGpYQ1dYVGpKSlRoRDlmQ053MUdP?=
 =?utf-8?B?MUhCUnJ0M1lOZndudXBleU5VYUg1aUQ2UU01aVY0VTNUejY4TzBIemJkMmFi?=
 =?utf-8?B?a2crQXRVbGZqVUlWK0VQSkIrTTRiMWVRdTI1MmRCUUpKV1JPMFMxZFltbDBv?=
 =?utf-8?B?aW5jTTM1SWFBcHNRMmZCUkhiRTcxV0dYSjYvRDl1aWZlRjBwZE9rQ0IyTzg1?=
 =?utf-8?B?M0ZoajlNYkh0WUZ5bzBqeE5YQWc2OFl1cDl1S1Rhc01RamVoeVY1TVNUVm8z?=
 =?utf-8?B?aUZWZ3NuZzlKOEV6WWpndFEwT0ZtcmgzUGs3TUpJdmU4clNqd0RLaGhzSWsw?=
 =?utf-8?B?Qm1DdVhjd3hscTA5bVdObkRwV1lzcHhvaUY3ZEpTTW5rV2NYTXViN3RqZG8w?=
 =?utf-8?B?QTBNQ0FycnFKZ3k0TE1QTGl5bmFZOHg4Tm90S0pjZWNzay9qYi9WTlQxcmJJ?=
 =?utf-8?B?eDJXTTBFbmh4L0dZcXd2dnRlWUFPYlJjL0VKM1ZZOW9WZ0ZPeWJFKzhBOVR6?=
 =?utf-8?B?ZlVFRnNVTzNHMGEwMG1Yb2JSK1Uyd3hUaTBtMTBuYjBrWFpCaWoyS0tKNFFY?=
 =?utf-8?B?bWtsWWNQS3Iwc05YeDl1UE5VeW9Bb1JydzhZd2ZFN0JQVEVTdGlXZGJ6THAz?=
 =?utf-8?B?WXdMbFpnSXF0WTdZQklhTnlwTzZoUmRVbWFkL3dWZmFoaThYa3pVdU1VdTk1?=
 =?utf-8?B?N3FhTUJZRnpXa2ZidkdEOFdJVHppWnYvMysxWUt3MFBtM1hPT0J4NDdBdzJk?=
 =?utf-8?B?d05SVittT0M1cnR2SFVqZkRWa0Z0WGs4THc5dG15bGc0WFhxVUZTMDJjMmZE?=
 =?utf-8?Q?Su/VfklZAWhxn5DRVmjk294=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de7698b-ab1f-4e1d-4dac-08ddf14ac8f2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:49:25.9356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mj+fggrOS18V2lGL4/pfjkE0KxJLe4PqyAQsaObqsOSDhGLpCCArikNbVk30fjoHKbGS1+K4GLLH+/sXmrYgOVNLesW8JRB+KE1rVUWPuCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9030

On 2025-09-11 11:41, Mathieu Desnoyers wrote:
> On 2025-09-08 18:59, Thomas Gleixner wrote:
[...]

> 
>> +
>> +The kernel enforces flag consistency and terminates the thread with 
>> SIGSEGV
>> +if it detects a violation.
>> --- a/include/linux/rseq_types.h
>> +++ b/include/linux/rseq_types.h
>> @@ -71,12 +71,35 @@ struct rseq_ids {
>>   };
>>   /**
>> + * union rseq_slice_state - Status information for rseq time slice 
>> extension
>> + * @state:    Compound to access the overall state
>> + * @enabled:    Time slice extension is enabled for the task
>> + * @granted:    Time slice extension was granted to the task
>> + */
>> +union rseq_slice_state {
>> +    u16            state;
>> +    struct {
>> +        u8        enabled;
>> +        u8        granted;
>> +    };
>> +};
>> +
>> +/**
>> + * struct rseq_slice - Status information for rseq time slice extension
>> + * @state:    Time slice extension state
>> + */
>> +struct rseq_slice {
>> +    union rseq_slice_state    state;
>> +};
>> +
>> +/**
>>    * struct rseq_data - Storage for all rseq related data
>>    * @usrptr:    Pointer to the registered user space RSEQ memory
>>    * @len:    Length of the RSEQ region
>>    * @sig:    Signature of critial section abort IPs
>>    * @event:    Storage for event management
>>    * @ids:    Storage for cached CPU ID and MM CID
>> + * @slice:    Storage for time slice extension data
>>    */
>>   struct rseq_data {
>>       struct rseq __user        *usrptr;
>> @@ -84,6 +107,9 @@ struct rseq_data {
>>       u32                sig;
>>       struct rseq_event        event;
>>       struct rseq_ids            ids;
>> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
>> +    struct rseq_slice        slice;
>> +#endif

Note: we could move this #ifdef to surround the definition
of both union rseq_slice_state and struct rseq_slice,
and emit an empty structure in the #else case rather than
do the ifdef here.

Thanks,

Mathieu

>>   };
>>   #else /* CONFIG_RSEQ */
>> --- a/include/uapi/linux/rseq.h
>> +++ b/include/uapi/linux/rseq.h
>> @@ -23,9 +23,15 @@ enum rseq_flags {
>>   };
>>   enum rseq_cs_flags_bit {
>> +    /* Historical and unsupported bits */
>>       RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT    = 0,
>>       RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT    = 1,
>>       RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT    = 2,
>> +    /* (3) Intentional gap to put new bits into a seperate byte */
>> +
>> +    /* User read only feature flags */
>> +    RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT    = 4,
>> +    RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT    = 5,
>>   };
>>   enum rseq_cs_flags {
>> @@ -35,6 +41,22 @@ enum rseq_cs_flags {
>>           (1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
>>       RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE    =
>>           (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>> +
>> +    RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE    =
>> +        (1U << RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE_BIT),
>> +    RSEQ_CS_FLAG_SLICE_EXT_ENABLED        =
>> +        (1U << RSEQ_CS_FLAG_SLICE_EXT_ENABLED_BIT),
>> +};
>> +
>> +enum rseq_slice_bits {
>> +    /* Time slice extension ABI bits */
>> +    RSEQ_SLICE_EXT_REQUEST_BIT        = 0,
>> +    RSEQ_SLICE_EXT_GRANTED_BIT        = 1,
>> +};
>> +
>> +enum rseq_slice_masks {
>> +    RSEQ_SLICE_EXT_REQUEST    = (1U << RSEQ_SLICE_EXT_REQUEST_BIT),
>> +    RSEQ_SLICE_EXT_GRANTED    = (1U << RSEQ_SLICE_EXT_GRANTED_BIT),
>>   };
>>   /*
>> @@ -142,6 +164,12 @@ struct rseq {
>>       __u32 mm_cid;
>>       /*
>> +     * Time slice extension control word. CPU local atomic updates from
>> +     * kernel and user space.
>> +     */
>> +    __u32 slice_ctrl;
>> +
>> +    /*
>>        * Flexible array member at end of structure, after last feature 
>> field.
>>        */
>>       char end[];
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -1908,6 +1908,18 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
>>         If unsure, say N.
>> +config RSEQ_SLICE_EXTENSION
>> +    bool "Enable rseq based time slice extension mechanism"
>> +    depends on RSEQ && HIGH_RES_TIMERS && GENERIC_ENTRY && 
>> HAVE_GENERIC_TIF_BITS
>> +    help
>> +          Allows userspace to request a limited time slice extension 
>> when
>> +      returning from an interrupt to user space via the RSEQ shared
>> +      data ABI. If granted, that allows to complete a critical section,
>> +      so that other threads are not stuck on a conflicted resource,
>> +      while the task is scheduled out.
>> +
>> +      If unsure, say N.
>> +
>>   config DEBUG_RSEQ
>>       default n
>>       bool "Enable debugging of rseq() system call" if EXPERT
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -387,6 +387,8 @@ static bool rseq_reset_ids(void)
>>    */
>>   SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, 
>> int, flags, u32, sig)
>>   {
>> +    u32 rseqfl = 0;
>> +
>>       if (flags & RSEQ_FLAG_UNREGISTER) {
>>           if (flags & ~RSEQ_FLAG_UNREGISTER)
>>               return -EINVAL;
>> @@ -448,6 +450,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>>       if (put_user_masked_u64(0UL, &rseq->rseq_cs))
>>           return -EFAULT;
>> +    if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
>> +        rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
>> +
>> +    if (put_user_masked_u32(rseqfl, &rseq->flags))
>> +        return -EFAULT;
>> +
>>       /*
>>        * Activate the registration by setting the rseq area address, 
>> length
>>        * and signature in the task struct.
>>
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

