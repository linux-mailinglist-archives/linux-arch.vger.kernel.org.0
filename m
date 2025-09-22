Return-Path: <linux-arch+bounces-13714-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34170B919A6
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 16:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B79C2A04ED
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C261990D9;
	Mon, 22 Sep 2025 14:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lIhNJYg0"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020113.outbound.protection.outlook.com [52.101.189.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76210F1;
	Mon, 22 Sep 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550191; cv=fail; b=IfvFkLczrGi3HR/STotx3keQTalLUVz+uU+a2Png74biA8qw8hqsVOExW0tsSHtiaTXbw030XSsQNA1y35DJLt4VLH/nC770m+ue2X280ibP11WoFgXu9i0dHSLrgWMNfqNZ6Dg3RV/5q/RB+ogh6JzhYY2p1hPsSaBmHSTbo30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550191; c=relaxed/simple;
	bh=6N/bpl7XfJChtYluHOyXFB1geC0r/6hG24EyBQXQQMk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bKvkeke0pzRcriE4fnnEyvtUkb+SWIyyUpYrBFBW3P29sm/WtkQ4sfEB6EPJjhk/nK6J0Q1L7x2yAeIzWSeOtd7rISUHmZaQ2CK2G3tuOG9KFq6P/0AhBwKYXgMtnUH80JwNLcrDQINgIGwNo/L44dZpKSF4UyAjsUvSIs0as/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lIhNJYg0; arc=fail smtp.client-ip=52.101.189.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mo6Qc16zLvNeRs6RW9KlgW//tbrg8QyU+a+Q5QzyJItKle98jW5x9HAjvqFucWwHFJyG81B5V6ux0bTNn6ZIsVVtO9b4z/hh21x1TqLTC4bSGjUHXCt2v7d1FDApKAm5EkVrau/yjmVPme6NWxXZzSrNcGj1QMCyZUO8ux1LO6q1jcSTsIPTF0Gc+vUpKnk2AJ91W76M+2Va7OQXuoK43wtB2VkAAHDFosFYGKsDgTZ6P5IxvN6z/9fcB6H2Kc0v4yCkKzJ5INLHmfw1YBe6NFgQXn0PDdh9dtLgzUEt0uNu7yIwtxM62r4B1pqOeGLGuoZjPmmjt6fPMHU47nkGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3KvOuLh0KDuqZ2Kp9kq2vI6bPDZroHFTWZSK2hsAtg=;
 b=nCe8QY+af7sxwUUlukkjmfyDoPgCKwPMjbgyYE09I1njOB0LXxGvqhLkYaf2uFuHdNpVMWnYkH1/kvR7OQa4oR93lxUbrhYrwggJq/EuRY4co3Hcfy+wmeLwdWKUEKN02q282EikVxULwwQQ28kuUtND1oA+qJ1xndrywHbQ4sGUzhsS9lnYJZyCGhJl8Exv9+pfuPqfBSDQA36CgRBcODwPWqjV1dDscoTTGkz3HZ3nXRnY5Tv7VQcyQ7jcRL0Lsy8sWu++x1VmM+EMoksPJiCTjscSnjVBIBTJel5lWyRkzwrwHSXNxG7wUlsV/KNRlhHWtAE9PhOjFdvuON/7/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3KvOuLh0KDuqZ2Kp9kq2vI6bPDZroHFTWZSK2hsAtg=;
 b=lIhNJYg0Y+LE3zakbRk5x7Okjgj4ZrR8GlnTm0x+hKtRuQ9y9+XrARNcbe4wW+SKljecf5SX1zfuWIlUhKO9dKIImipppzk1mXkm+O1mtZ55pfQbdvQqppXIN5fC9FX505V7MJfqcfhRlIEVvYJ+i9fUXewqpOqlUO5OQm0rQWphSqjBPZWBcOI0RTIVkkHlJroVZ4+9zF3Zq5FV+efjnwFjDnLBLB1sh0n1F1X8m7mN9T0rrMX6OON0nlNIzF5cFsGfDXFHr5rS7SlUhugf1BwXsaULwOcIAkqfaTkjlo52KIp4DnIDnAy29reV+Z6vIGdzalDr47Y++0r51WH2rQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11575.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:155::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 14:09:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 14:09:47 +0000
Message-ID: <827c26cd-3924-4556-a36d-da42b23a9a17@efficios.com>
Date: Mon, 22 Sep 2025 10:09:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zilstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Florian Weimer <fweimer@redhat.com>, "carlos@redhat.com"
 <carlos@redhat.com>,
 "libc-coord@lists.openwall.com" <libc-coord@lists.openwall.com>
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com> <87plbwrbef.ffs@tglx>
 <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com> <87a52zr5sv.ffs@tglx>
 <a65dfd2c-b435-4d83-89d0-abc8002db7c7@efficios.com> <874it6qzd0.ffs@tglx>
 <0BF9AF0D-EA88-4504-99E4-BB3674FA588F@oracle.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <0BF9AF0D-EA88-4504-99E4-BB3674FA588F@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e00a497-5556-425c-fd4b-08ddf9e1afbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXh2YklqdFpDSUFPMlBoRlZEV2tZTitZallvMXAwblU3TXd0b1ltSVA4cXRH?=
 =?utf-8?B?Y0Z4OE9DMU5iMFhrYzNLTEkyaGVHczB1dXhveWJ4cU5yVnF1RG5nQ0NqM2pm?=
 =?utf-8?B?eWx5cVpRb3U5Y09zRS84Z1RYc2NQelF6K0J4NFhOaStkU2x4UnJybkJOMFVy?=
 =?utf-8?B?T2F5aGptSmdxQ1ZEenZzTmE4N2Z2dURCQThNZUlTU0t5QnNOa2orekc3Y3hj?=
 =?utf-8?B?UzhHQkZaZTk5WGpmci9xVEhWQVNzWnU2aEFxVFkzSy83cWcxdEJwQmtXaFRW?=
 =?utf-8?B?Zmtka01hcGVPYkI0cG5NUStEeDViM3FxWFhNQnRoZUVuSm9BbFRLVy9VY1Ar?=
 =?utf-8?B?UUNVNEthekcwdjhydndkWW4rUGhvMzNzTHZKZUxQRVprNUhDL1BReDJ1ejVM?=
 =?utf-8?B?b3RmVGJYdzcydm1WSS9pandscldGZ0lKT0xFZzRZSXl4ZG44U0IxZzhXNDdC?=
 =?utf-8?B?SVNFWHY2K0pmdnlNd3Zoa1FoVVgwY1UzWmRTTlNrajkvWFFhQ2E2YzBvYU5x?=
 =?utf-8?B?SFFXVEwvQkpEYU9va0JtQ290Mml4dkk1L3pBZmFrQzhNTFA1QXU1VzVINFN1?=
 =?utf-8?B?clIxU1RBaWRsU1ZyZURKclVkOXl2dXF3WHFoaHRNNlNwSXRIOEhsZU1uRGdj?=
 =?utf-8?B?ZVpETkhyU2dnTjB2Z0FTWXRMNGIrdStoT0VZYTZoU2FuU1Fjc0tNQ01tM08x?=
 =?utf-8?B?N0dPSHlBTzJrenllSGViUk43ZUJKZ1NuQVovMG5ZRFcyTVpHNFBJc2dqSlF3?=
 =?utf-8?B?cTllS1lOY1A5K2pSc1diMzI0L05RdWRHYjVudXE2VnBXZWhMbDNFQ3lGV1U3?=
 =?utf-8?B?WFd3QWV6Z2hhOFhJUW5WMVowSG9QMXhIc1NaaGJRWnF1d0R0YlNsdFFQb3Qr?=
 =?utf-8?B?ZHhuTVcwZ3V1bTNiSFlOaEhvQ25LRVkxdTlCNDhOSFFEcExhVkpGajNUMTVh?=
 =?utf-8?B?U2t6cE5IQ093T2V6SE14bEo2dUE4d2VOc0F0RjFoNEs3QnNVc1hvMm91OUk2?=
 =?utf-8?B?dUdxcjIxK05MMklGVFJaSG1hQVR4OG1xQ0dpdldqa1hMWXVuZVhHbjc2elg2?=
 =?utf-8?B?Z2tEWEcvMHVDYVc1OERyUkRTS3k2ZVFReVd1NXpybmdXa1NHd2RZMitQeUxL?=
 =?utf-8?B?NFpObGExNGRMSHR0UXc0b2xqVm1qV1RaS0lOUFhibkl5bWwrZGhJeHhmY24x?=
 =?utf-8?B?a1Rkd3d5QW84QjZGY3RuRzRJN2NoWEVCalZUSCs2Qm9aL0hkbldXakI1bGVX?=
 =?utf-8?B?b3g5L013eC9KV2NwVUc1alQza1N1aVdPN3VSRjBwSDFmUTJ3b0FpZUFqcWtw?=
 =?utf-8?B?UEkxTjEyODJpREFGbzVHVjJYN05RbE4zb1dkNnZoSTh3U002VmY4SnlhQUxF?=
 =?utf-8?B?b3lHOVZxR2lqM2Fya1lzYTdId0x4TnM5UlFWWGR1ZVJRczAzaURzaHlncEQ2?=
 =?utf-8?B?Z0ljSVBZbDl6Kzk2THVNRmxlVW9ra2ljM1lIMkx1VzlROGVtL1Vaelc4WW9G?=
 =?utf-8?B?MzZKM3g2WmR5NzZiZWs2VjZBOXdqaWNPLzdoR0VDR0JxT21rLzNXWUxwUFVU?=
 =?utf-8?B?MWdHQlNFcWJxNkpRUmJ1QmNsQ1J1aDY5alJmSGJtb1JHUjcrNlJXN291SHJM?=
 =?utf-8?B?bFJEbXYwVmNqbk4yaGVSOVNlQ1lDVW1Sa1lRc0dTS0JycTRCWlJ1Z095Z0g4?=
 =?utf-8?B?enBFbENqVDcwT3NYUXlVOU1VMk1nNmR2TXU2VVVlMmZUaXhidGh4VVpDMVRT?=
 =?utf-8?B?b2cyY01zd1c1dEFDVHZYZzdVYktzSXBhL215WndWcmc4djhMNGYzNlFuMk9w?=
 =?utf-8?Q?Jty3wtJKBh7vQ7c9OJFTB4HsIqOSBYTPuHo8o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3Y4cXJHaEt1ZHMxOEJpb0xCOXdhdTEzZCt0dHBIekg5MDVQSGdxNVpnVFpN?=
 =?utf-8?B?ODczVmdQUlVPMFBNQUNxWUFOSnNlQWlXRHBKZmtxVFo0ckpBNDVkYnlvUUhV?=
 =?utf-8?B?dHhXT1IvbldNRzBIZHg5NmdMSmV6WWlqeGNCOGx1N0ZjcFZVNTFtRHh0NTZC?=
 =?utf-8?B?WGxyZHQ0dEpSWkFhUDJ0L1NuQzZkYjgzUmk5dFpicnN5ay9iNksvVUF4N1Jn?=
 =?utf-8?B?ZzFIQW0rcGNTdWFyeW5BOTFHRk9NblMwYldaMWUrRytyNUZLaWorR2F6SEwz?=
 =?utf-8?B?TVpwSE16eldpSVUxRUFLWW1PTDdzVkRWV1BzQXh0b3J3M2wzMzlXOFRhclJ0?=
 =?utf-8?B?YXhhYkJSYlhYTVdjRkIyZEUvODY2Ry9QZnA5MjZZa2JNQVpCdkw4aUVqQ0E2?=
 =?utf-8?B?cVpOSTV3M1dXK3RwczFPU3pQYVcxQTRyc2RXZ2MrSDFHVWgzM1pTblMyUTNE?=
 =?utf-8?B?S2ZrTElIRFR6UmhseGYzRkdRdGVJRUdEV2t0L0pKRVNSSGZLNlNKRi93VTBT?=
 =?utf-8?B?VndjWWpvUndybnFzUy9TaDRoR2djSkJVemNmaDFMZkw0UzNBV0lvKzFnV1FQ?=
 =?utf-8?B?WTBrRkZZNXVWUlorODdTdGhjOGJFOVYwR2hsRFJ0V3h4TTJEYzV3WTczd3Iz?=
 =?utf-8?B?MzdicFMyVTJaTHFFNWVsNDBZdE1ycWdadFUrY3ErVC8vQS9MV01XbUttRGhx?=
 =?utf-8?B?eGEyYUFJK2sxdHpPelBISTJ3TTBTakdmeVlLRXllWW52Sk5SS05lRjBkOUVU?=
 =?utf-8?B?QktyU28rRld1eGFGL2c4UEtXUlJKc1dGMGZLYTVxejlFSDZCQ3JXeFBaajFh?=
 =?utf-8?B?cElFdEh0bjlMN3l0Q0dlYjhCNWNRMlZYdW1PZnYrNXBXRmU2Nkhzd0t0M0R1?=
 =?utf-8?B?WXJuYjZvY2htSTFIUCt0OUJLYi85UXA5KzNnT0ZjUHBEKy9aMHN2bUVNR3BO?=
 =?utf-8?B?aWFidFp2S1Q2eWRsVGlwNlVtbzZNUDNsbHBkS2VydXAweGgrLy9DVEhhSko5?=
 =?utf-8?B?OEQ1QVY2NGxWZGxSRUs4WjNPRnRSMmxsQnVWNEZBY1UxN09xNkxXRmlWekhP?=
 =?utf-8?B?WHNuTk4wMDJsSG8xR3ZQZU1sMEJUUHZzQWpmeE1DbUlBektIVCt4QTdyUEpG?=
 =?utf-8?B?K3JJNlR4QUN4aElOcXpYY3dHK1FvVkVFMDczaVFWRXN2UzlhaE5qTjk0NlYw?=
 =?utf-8?B?M3hNb1pETGpNVUpJOTZ1aElFdlNEUXo0RGF4cFNLcndEMm1oQjhTWk1sY1Fq?=
 =?utf-8?B?dEhOdjdjRTZVWTNJdDFhS1ZlVEp2RzJ3NjR0UjRqWTg4akpjbnRUaTRNejZh?=
 =?utf-8?B?YjVTOHJnYWVpcnM4STIvS0FzVWRjMkZVVDI3QU85NUV3WnpRVGZ2aWoxeWg2?=
 =?utf-8?B?Y0hrZVJ0M2tEenR1aUxxNlEyU0pYMVhEeFJjaHFLczIrdnI0MzRJRHRpM3Vi?=
 =?utf-8?B?YmNuMEt5VTljYzFyaVVBQm5OR082Y1BOTi9XZ2JlNGpkaFRQMDZDWG1mbGh1?=
 =?utf-8?B?S3l6Wi9sa3JWYm1wRzJEU0hPOXhFTmgyVEdVeVJFZ2p3YXdEMkI3SzZja1hY?=
 =?utf-8?B?MHVlU2wraUsvWVZtM0MvbkZqSmlITzdIQlUxY051R0sxT2EwbWZZZStySzcr?=
 =?utf-8?B?NGpaRUNaYTYxQTJZK0dyMnAvY1lDZXFqd3RyRUt5VGN6cHRKR3N5U3ZTWVRK?=
 =?utf-8?B?dzFPYU9zdnJadTBFV2xBRzJhNmR0akNVZERLRG9NMXRMQTRHS2pFV2IxaDlO?=
 =?utf-8?B?akdPL285bTZNY1I4ak1SRDNsZkJ4OE11V1Y2eXlsYk9jQW9KYWxHOXBQSm5C?=
 =?utf-8?B?a1V2eDU5b0xaMzlQQzlsREVPNnkyTEhqU1Q2WXN2R3B0RUt6TVArUTU1ZHZo?=
 =?utf-8?B?aUtZQVJOcVZPQzZaVUt3WHRuUlVEOHRodmtBQUFoY045T1BBY3BKcFhhMlM0?=
 =?utf-8?B?OXFrTW9aTzVFU0VUeWR2a1lpdWZFU3BxaXRTalZpbHR5WlRiZ05tOFBiVklx?=
 =?utf-8?B?d0NPTWlJMm1IYjZXNnI4Nmp6TFRtZktKd3FwT3dXVVIzd3JBdk5tQzJDV0Uz?=
 =?utf-8?B?NGNpZUY5eGxSSklKSnQxWERGUXhURmpsSDJXQXh4a2p6cEhtWWx6cEZCY1gy?=
 =?utf-8?B?YzQzaVZXc09IRHdyeTlWOE45c25KdHhHTzk1UEJZU2doVzQra3BUTkxoY29h?=
 =?utf-8?Q?Msrb9q5h8xLCvykzsgJ8goo=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e00a497-5556-425c-fd4b-08ddf9e1afbf
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 14:09:47.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfYH3p6k2xi8KEdvHzQ4mzyUM+ySihaZLeMAWrnw2jP5+RJGAAJj2atmDVQ5Ixcrvm/fThpSp8Hh8Bm4kTM2MFRvMNK0k6IMmVbURuHyLLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11575

On 2025-09-19 13:30, Prakash Sangappa wrote:
> 
> 
>> On Sep 13, 2025, at 6:02 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Fri, Sep 12 2025 at 15:26, Mathieu Desnoyers wrote:
>>> On 2025-09-12 12:31, Thomas Gleixner wrote:
>>>>> 2) Slice requests are a good fit for locking. Locking typically
>>>>>      has nesting ability.
>>>>>
>>>>>      We should consider making the slice request ABI a 8-bit
>>>>>      or 16-bit nesting counter to allow nesting of its users.
>>>>
>>>> Making request a counter requires to keep request set when the
>>>> extension is granted. So the states would be:
>>>>
>>>>       request    granted
>>>>       0          0               Neutral
>>>>> 0         0               Requested
>>>>> =0        1               Granted
>>>
>>
>> Second thoughts on this.
>>
[...]
> 
>>
>> If user space wants nesting, then it can do so on its own without
>> creating an ill defined and fragile kernel/user ABI. We created enough
>> of them in the past and all of them resulted in long term headaches.
> 
> Guess user space should be able to handle nesting, possibly without the need of a counter?
> 
> AFAICS can’t the nested request, to extend the slice, be handled by checking
> if both ‘REQUEST’ & ‘GRANTED’ bits are zero?  If so,  attempt to request
> slice extension.  Otherwise If either REQUEST or GRANTED bit Is set, then a slice
> extension has been already requested or granted.

I think you are onto something here. If we want independent pieces of
software (e.g. libc and application) to allow nesting of time slice
extension requests, without having to deal with a counter and the
inevitable unbalance bugs (leak and underflow), we could require
userspace to check the value of the request and granted flags. If both
are zero, then it can set the request.

Then when userspace exits its critical section, it needs to remember
whether it has set a request or not, so it does not clear a request
too early if the request was set by an outer context. This requires
handing over additional state (one bit) from "lock" to "unlock" though.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

