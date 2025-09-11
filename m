Return-Path: <linux-arch+bounces-13503-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54235B5382E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC331C25D07
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E821341662;
	Thu, 11 Sep 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="PMDqRb8S"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021115.outbound.protection.outlook.com [40.107.192.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F86322536;
	Thu, 11 Sep 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605809; cv=fail; b=kcMjbCbuoZDCc5XDF6YUxixu5a7jwzFrQhDmg1L/GxW78UeB3RwugxJh0PYcFNrj9VGuwWu391H9GAE4LpsXoE1C1T/pr/J9a/rG04QphwHpH9kSr5Gt+diEFlU2lgkAkcI4PIQfeKNK8DZICAqCH+3TCE247P0J7J2lVF0mmZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605809; c=relaxed/simple;
	bh=eWpFSd+n1ROmKsiTGJM/Xs0pfK7nZY/FolWv0utCFWw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B2SEpj3B3GMrTpR2OWxB528mfG+8B/N2mGkmHs+ZoJeJmdZE0I16AP87AmiF+hQW7CfvqfLFEeNsol2qW/CgsXCKBJPLuDVmW7aAFMg0Y+/g5dpLjeCeD59FDMRMaJJ76gWhJIGQXm67tKdZBc/XHCKmo+3ApdWKMX933oQDC6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=PMDqRb8S; arc=fail smtp.client-ip=40.107.192.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8ZckiJon5Sn+1vsegPfFB++3Hzo9u349GZ13zozQVT30AyMiAF4QP/5VAn8WpfWJjWGj95dxmW+hUmDI9QKOjo4exbECcQnqSdlN2AMrirggQFgNGCJq7Bicp5+fGt/I91uNHAUtFAQ865i3RFfg980WLg2S5J5wRYauPp5SHgaGOAJTi40PIh40Ro7SHzoPhKqBuP1NTXkYHQ3z9yeLmT5HkpxMf0dIWYLzD38+eKTtODU7s0flcL7ZjE3lxsel0d5l2VM+vl79B+mt1qHaeEQltW8embv0VD1+nf4PKxlNXQwSsfZrl79S//Zh0a+Vl5KkIhwQPCTBz2MYBEjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y552D1Yt8wOKUYmgmzG7GiZQq6I62tAzOWG0/uYtKZA=;
 b=qqaG0BrgAkCxL8VEaS8vQ8QglUGPEHTmdyvyjjzKCERVUXT4jkc80tzNpXdJLRKPdHCuvUpyzh8dIeYbQ0U4ebH56zbY+lGhI1EZc5jvGktefnGisiBS2wjnoAdl3kuUVRaQeC76ELARP4eCT4PHeRKwUno8rwdy01eql+vFxp1kvAAHM9LSxkWvuswxwl7VdvauT6I0Mj7p/a4R4CRyOZvEJ+no5Unahi7RaAZynMu7YQ3YUeibdirGXtd/O5Hp7b/jS3TRHYFbMfn2vhbmaTJ/2A3jFvwLp/w6MqtspUs2L1jMxqFIafYwOYmhNjW6+9p/5iIKYKgVgM+ADTe94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y552D1Yt8wOKUYmgmzG7GiZQq6I62tAzOWG0/uYtKZA=;
 b=PMDqRb8ShQJ85Yu/nqRQmNLSNGGXXJ/PiSa2DM806yUJXqSX+2c0FC2VpbsK9qgiGxv67ZNcgR0T8Sb6qA+Ek+zb6Qx52o6dBwETG0FFVSQR/tTqkRkMBx+GyLrMZR9m671jaLSpBQP2Stwux19sdI3sCq0VP0iYwQce0eX5Mebh+MEjXU1GjFxUmCJVWGadtlifoTRfqz7tWyBelqJeiS1+H+1wbDCGARnm4GpSSA9kWKLQvBq063lbB2MVNvVv9PuAcC9pZOmMckH/xPElBf5kCSYgAzmkNUmY1sFKqApWgG4MNOvDVBBnME+lqenPchINgESVcQeu9S4q95lNfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB9030.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 15:50:05 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 15:50:05 +0000
Message-ID: <3951a525-8fce-484c-bdc3-3da4e6160c75@efficios.com>
Date: Thu, 11 Sep 2025 11:50:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 05/12] rseq: Add prctl() to enable time slice extensions
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
 <20250908225752.872081859@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250908225752.872081859@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::39) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 1793fc12-ca3b-41c3-3c66-08ddf14ae062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTFmOEdnelliNC80MDRZdVJYaXdHa2t2YWFuOXYwTncwd2ZrclVxdFFTSGVm?=
 =?utf-8?B?SVFVU05xMmdweWNkR1Q0UnRManBUSm1mWkFKb3JzajloSGR3bkFvMU45ait3?=
 =?utf-8?B?NE9RL25XcXhNS1FycmUrQUJSbDR6bWJKQ3hXcENKZjQ0Q29ZSFd5cjVEc1Jt?=
 =?utf-8?B?RjlldXBpb2VWMVJNU3pnRUR0aE5FMUdSeVV1dHYzTkhxQ09VWktUbVUwMGE1?=
 =?utf-8?B?S25PWHdtbURnNXhpS0t3T21CaEpRTS9MU0JmaDRrZExvZGhGcEF5MjFnc1dX?=
 =?utf-8?B?VWNsdUZiMXhWN2RjOGdCQmVIRjAxY2ZQWWpDQ0hnNE45NjQvR0xOYTB5SG5P?=
 =?utf-8?B?OW9ldlpOTkZNN0VGMEY2MGMzeS84QUxGaWozWjAvTXN4WElZZkNzdmtvcGlM?=
 =?utf-8?B?dzZXd3lxZWpxQTRpT1VlZnl3OXZLdmowczFhOWFNZmRUOEhJVm1vaDNRNU9P?=
 =?utf-8?B?SjdaNjdkYTVPY1VBeUVTK1o2LzVqOHFjM2ZTVlBtcmorU3ZkQjRmdWduRytP?=
 =?utf-8?B?WWkzQ0k1eWhxOXZ1WWtaRlp5YjY1bmUxeTViSVFhMnlVdUVPS3orRkhtWGN2?=
 =?utf-8?B?MjNUU3JaeUhvRkVuSXBBN09PaGFCRWJkbDVob2FQR0EvMlMzY011UkdrblN1?=
 =?utf-8?B?c29mclFzV2h6RVhjVVlzTmprcUlWSXBmamlDZkdJRm5EcW93aDE3WXoxcWZR?=
 =?utf-8?B?Rjk0YlpUbHBXVGZlbVRiU2FmaDV4VE0vVDZXQ1pmT2tEZzh2VnpwZWxQdDlK?=
 =?utf-8?B?ckd5TSsvWkZjMjVqK1JmRkdnTDZvdEU5TlhwWkMxME9jd0pTK1pXVGYxRHRS?=
 =?utf-8?B?cm56UVNFMmZxdlorVStQK0Z4cDMvWTdWSVFJRHpEOGZZVGQ1MjhnR1Z5RkZE?=
 =?utf-8?B?RjJLNWpmZHFGRzNPSWhpTXlKSDNTenNmVXM4OEtubEFzSUNJaU9EN3RSR29o?=
 =?utf-8?B?b0hWQkx1UUlaRW1iQ3N1K1h1M0FxT2M4cmltTlB5cm53bTBXdEpUckdFU3VO?=
 =?utf-8?B?K2ozK0Q4TVRSVytSZEJHbHJDbW40bE9HRlNoWkxQY2RvbmNmM0FvRWJiTE1a?=
 =?utf-8?B?SW9mbHQyZnV5YTVVYzM1VmtHRTRSSEZWSVd0SmhrTCtoU3d2bVgxbUJ3Tzkw?=
 =?utf-8?B?OTh1TmUxUzZJVURVQVZYT3V1UWNiZW9NVkdqZlVadkRKT2ltT1pvZi8vaEND?=
 =?utf-8?B?cGxFUEJkemhJNFoyTi9EVk5xUitYMm4rbUlUNzQ4QkNTTEtDS0N2TXoxSVFl?=
 =?utf-8?B?aVNUSURodmI4ejFLenZibDV5V0IwYnN6bG5iNmtXeitRb3AwNXY2ajdldEZh?=
 =?utf-8?B?NEl2YlVTT1hmMFd3cnlYTSt0eEg3ZnFLZGdxbTRTd011TER1SFFrUXZoVmNv?=
 =?utf-8?B?cnZwSnJpd0NCZ1E4SzlDV2YrUmdSVUxEN1FZTitIbEJveTJQNjFlbzI0YzQ4?=
 =?utf-8?B?SUtvVjFBa0NDMURhL1Awc2RQeVM0N05pcGFBOEg2TkNtWG5ZMnNwNlZSRGEv?=
 =?utf-8?B?dlBkYTFnVG94cVFmdEl3Mkl1V1dNTlUrWUk2MFAwOXNrcXZ5UUY3N1o0V3Av?=
 =?utf-8?B?TklzRDZqWVBDNS8wS1hMVnl5MWpWU09PMzhza1V2ck1CM001QWgwWTBSQ2FC?=
 =?utf-8?B?YTR1enk2YzMrYlg1K29XOVJxVUlvVVo2YWFwbjRMZElFVzkrbzdzbmZwSGNn?=
 =?utf-8?B?NXM1NVJjdEJQUnN5SmtIczhuTmhWMUkrdU5xZWJZL3hnNEtveUJadGs0WVpL?=
 =?utf-8?B?eDBFQ2pRdnNJTmNkY1dnVDFlVXZOSXZ2eFd6U0MrUzVsYS9tRUMxMW5iUXhu?=
 =?utf-8?Q?fXkxANiiGndIzGJ9txDBZosgxCBxDMV5MNdMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGFCUWl6dUwxTnhubk9JM3hKMEhseldQTDFrNDU3ZjlkQ1phWWEzazNKVi8r?=
 =?utf-8?B?cEU4d1hUUHYzOHl1UW1RQVBXOUtETFJGVnJlbzFLZ2JRY295MWJicUhKZDAx?=
 =?utf-8?B?UWVydUk1U2I0SGFleFRSWDlNUXFaUkpjWDZaTElSc29aeDhxNkVKL3VzbUg5?=
 =?utf-8?B?WUM4QmR0QWFBRmhpTjJLeXJwaExjaFEzaGJkRlA4OHZQdFE2Rzhyekl1dFUv?=
 =?utf-8?B?NUJiRjdOcTZkanZ6SWdPaXZpVUVMeUZ4VnF6TUVnbVVVUG5UK0xkejZ2am96?=
 =?utf-8?B?SVVrY3BuN1lNUnR5V2dQbFdaMS90Tk1ySW9XRk9kRU1XRUtNMjVqTHBHcFpu?=
 =?utf-8?B?cW5KYnJHQUJLdFFtdUhCaU5INWJhOGtudmk2VWx5MDk5M0JrTFNZSUdoMS82?=
 =?utf-8?B?dTZUc2JqcCtPR2N6SllIc1gwR2JQeXIvc2g4RStmN0tJa3RjbnphS3cyS3ZN?=
 =?utf-8?B?dGw0VDVQMmY2K3NISnRubGdSdEZ0QUJMYlJGaHJqQWp5bklyWndCVDd2VjJi?=
 =?utf-8?B?cC9QeVRMV3FYalVJRWJoclozdU9BbVpHZHQzeUk4NWFvUDlwNXpxMkZtUTI1?=
 =?utf-8?B?dVJ5M3E5T0pMOHJ6ekVBY2w2NEVUQjBSbkJPeit5MHJQcExlcGl5cE1QWTBJ?=
 =?utf-8?B?VnFidmhXdHM4ejdKS2UybXkyRGpCZlhBbTY4bThkVWNHSFFhQ0tpMm9VWGFV?=
 =?utf-8?B?ekR6eml1bjhNc21nbHllWm1YS241eWdCZ3YrYTd4ZnROTFhYVmZXUHFFNkxZ?=
 =?utf-8?B?dGorTDQ5YTc3UVJ1TzBLQXJYZTQ3Rm1PekJvNWZlVFVFdHdJU1REVmxubWw3?=
 =?utf-8?B?Sk85Qkl4UWN1S0o1K2dnc2o0NjNXQ01NazBrMHBqVTN3bnRvdkZhK1hoNzg4?=
 =?utf-8?B?cjFST2tYTUVZRVd1OXBoTXhkdThnS1RJRCtQLzhQMFNiUFZxOGlhUzhFTXV5?=
 =?utf-8?B?azJFTjBaR01VSEY5Y1lvV0s2ZFVvWis1bUxlaDdYbjE5T2lheDB6WnpoV0FE?=
 =?utf-8?B?VzJRc3BoMDlkRjhqM3hNNW9qSUo5LysrSHd2am03d25JZ2Jnbnh2TU1MeVRt?=
 =?utf-8?B?MFlJWmVLRGovWVU1U2o4VjhjbHRqTVFNcDRGLzJyeTg0S2JNTTJacmlIZkty?=
 =?utf-8?B?ZSsydms4TGkvcHdKZ0d4K2hhTFBmYkIxZHc5dVZyTUdSLzc5Z2FLMFBqU1Zr?=
 =?utf-8?B?enArTEltSk94alpNMFJZOU9lRG5tdGxRbDYyWkpOU2s3UEVqczdKN3BDZU9H?=
 =?utf-8?B?VXQ5STI0R0xmM3VMdmFkRzc3OVR2RDZSbE13V2UxU0gvcUp1bkFFTll0TWNP?=
 =?utf-8?B?ZmxQbncxMFBnc2hyU0xOR0k4bEt1WE9yVDZkR0hoRTcrSDNPdnZGMjJzV3Ns?=
 =?utf-8?B?RUVLa3N4NHpTMzhZVy9xQ0hKcklONFRUeE5jUmZBY0s2RjBwQ1JiaC9iQzN3?=
 =?utf-8?B?NWNueURoNXhRS250V2ZtL3FkNCtjWUpBS3pETUtQL0ZNaU1qL01maWdJc2du?=
 =?utf-8?B?ck92SEowd0gzeUNYNWVtTDBYdmpoREhON3FuM2ZjMC9kTTBqOWVIbElJaGla?=
 =?utf-8?B?akwrVmdvRnAwNTBJcWRlV1NGUHpocVVWTEhWMVh6OFRhTHByak1SRVVFaUNt?=
 =?utf-8?B?Wnp4Q0FoU1lBUVJmNkdmVkZFZFZ3S3lRVUY4d0dVSWF0cWp4aS92S2dNTTEz?=
 =?utf-8?B?QTcyM3kvSFJLNUo2MXFIdHNYU0hxVDZaamliZnBERWx3dTlJaXQ1QmJhNE9N?=
 =?utf-8?B?ek1ReFByOUh4OGhVZG9sNXYxS2tVTVdBZXNFVnhiaVhBelJYV1FqMHpIU09V?=
 =?utf-8?B?NEczSTU0RHVTODNMdkNxRHlWNktsSU1qcTdEUTFNc3A2TDByNXpxR3NTSnBy?=
 =?utf-8?B?Si9jK2pPV1NkdW4xVDZpRnVUa1R6RHdxUGFNeW1RcG0zQ2gzU3N4T1hVUit5?=
 =?utf-8?B?ZDkrbzlpSnA2WW5sNERIbXhBdElyWTAvODd1SkFQaERzY0RpUHhydHFOM1l6?=
 =?utf-8?B?VmtWeGgwN3RXcStyMG96bk5TSnhCWTcrMVg2cGhsVnNkaXFSRDZmNUtLZGJN?=
 =?utf-8?B?aHlMMmU4Q3lnL010cmlKZUpOQWs3WTdpS2ptd2kyUXQrdURhSXhidkkxUmIx?=
 =?utf-8?B?Q040ZktXd0pOem4rVGlIbWV4MFFXNmsrV04xdFE2bHlzZHNHOFY4WHRvZ3Vz?=
 =?utf-8?Q?5Gaeo2uwCJyet9srqUPViko=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1793fc12-ca3b-41c3-3c66-08ddf14ae062
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 15:50:05.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0jwW87yCKOsQnNCJSh4hSTSzjlOWf9LefGWUoSkR1cpV3vw2BWi2DEe/OMgqyAFqHIFXVSa4aV9LFmLm6M6tATJB2gmOT0SYxdfSqgx2BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9030

On 2025-09-08 18:59, Thomas Gleixner wrote:
> Implement a prctl() so that tasks can enable the time slice extension
> mechanism. This fails, when time slice extensions are disabled at compile
> time or on the kernel command line and when no rseq pointer is registered
> in the kernel.
> 
> That allows to implement a single trivial check in the exit to user mode
> hotpath, to decide whether the whole mechanism needs to be invoked.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> ---
>   include/linux/rseq.h       |    9 +++++++
>   include/uapi/linux/prctl.h |   10 ++++++++
>   kernel/rseq.c              |   52 +++++++++++++++++++++++++++++++++++++++++++++
>   kernel/sys.c               |    6 +++++
>   4 files changed, 77 insertions(+)
> 
> --- a/include/linux/rseq.h
> +++ b/include/linux/rseq.h
> @@ -190,4 +190,13 @@ void rseq_syscall(struct pt_regs *regs);
>   static inline void rseq_syscall(struct pt_regs *regs) { }
>   #endif /* !CONFIG_DEBUG_RSEQ */
>   
> +#ifdef CONFIG_RSEQ_SLICE_EXTENSION
> +int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
> +#else /* CONFIG_RSEQ_SLICE_EXTENSION */
> +static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
> +{
> +	return -EINVAL;
> +}
> +#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
> +
>   #endif /* _LINUX_RSEQ_H */
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -376,4 +376,14 @@ struct prctl_mm_map {
>   # define PR_FUTEX_HASH_SET_SLOTS	1
>   # define PR_FUTEX_HASH_GET_SLOTS	2
>   
> +/* RSEQ time slice extensions */
> +#define PR_RSEQ_SLICE_EXTENSION			79
> +# define PR_RSEQ_SLICE_EXTENSION_GET		1
> +# define PR_RSEQ_SLICE_EXTENSION_SET		2
> +/*
> + * Bits for RSEQ_SLICE_EXTENSION_GET/SET
> + * PR_RSEQ_SLICE_EXT_ENABLE:	Enable
> + */
> +# define PR_RSEQ_SLICE_EXT_ENABLE		0x01
> +
>   #endif /* _LINUX_PRCTL_H */
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -71,6 +71,7 @@
>   #define RSEQ_BUILD_SLOW_PATH
>   
>   #include <linux/debugfs.h>
> +#include <linux/prctl.h>
>   #include <linux/ratelimit.h>
>   #include <linux/rseq_entry.h>
>   #include <linux/sched.h>
> @@ -490,6 +491,57 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
>   #ifdef CONFIG_RSEQ_SLICE_EXTENSION
>   DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
>   
> +int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
> +{
> +	switch (arg2) {
> +	case PR_RSEQ_SLICE_EXTENSION_GET:
> +		if (arg3)
> +			return -EINVAL;
> +		return current->rseq.slice.state.enabled ? PR_RSEQ_SLICE_EXT_ENABLE : 0;
> +
> +	case PR_RSEQ_SLICE_EXTENSION_SET: {
> +		u32 rflags, valid = RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
> +		bool enable = !!(arg3 & PR_RSEQ_SLICE_EXT_ENABLE);
> +
> +		if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
> +			return -EINVAL;
> +		if (!rseq_slice_extension_enabled())
> +			return -ENOTSUPP;
> +		if (!current->rseq.usrptr)
> +			return -ENXIO;
> +
> +		/* No change? */
> +		if (enable == !!current->rseq.slice.state.enabled)
> +			return 0;
> +
> +		if (get_user(rflags, &current->rseq.usrptr->flags))
> +			goto die;
> +
> +		if (current->rseq.slice.state.enabled)
> +			valid |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
> +
> +		if ((rflags & valid) != valid)
> +			goto die;
> +
> +		rflags &= ~RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
> +		rflags |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
> +		if (enable)
> +			rflags |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
> +
> +		if (put_user(rflags, &current->rseq.usrptr->flags))
> +			goto die;
> +
> +		current->rseq.slice.state.enabled = enable;

What should happen to this enabled state if rseq is unregistered
after this prctl ?

Thanks,

Mathieu

> +		return 0;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +die:
> +	force_sig(SIGSEGV);
> +	return -EFAULT;
> +}
> +
>   static int __init rseq_slice_cmdline(char *str)
>   {
>   	bool on;
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -53,6 +53,7 @@
>   #include <linux/time_namespace.h>
>   #include <linux/binfmts.h>
>   #include <linux/futex.h>
> +#include <linux/rseq.h>
>   
>   #include <linux/sched.h>
>   #include <linux/sched/autogroup.h>
> @@ -2805,6 +2806,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
>   	case PR_FUTEX_HASH:
>   		error = futex_hash_prctl(arg2, arg3, arg4);
>   		break;
> +	case PR_RSEQ_SLICE_EXTENSION:
> +		if (arg4 || arg5)
> +			return -EINVAL;
> +		error = rseq_slice_extension_prctl(arg2, arg3);
> +		break;
>   	default:
>   		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
>   		error = -EINVAL;
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

