Return-Path: <linux-arch+bounces-13505-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A148AB53A39
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 19:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2BD188AB7B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AB9314B8E;
	Thu, 11 Sep 2025 17:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="g4FovKh8"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021120.outbound.protection.outlook.com [40.107.192.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77D2EDD64;
	Thu, 11 Sep 2025 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611141; cv=fail; b=gHn3Al//UMhHvujx27rz9pvJG2Mi7yOc2Dum/SElWf+oJdaDHOfncZs/p/xQar+KaGqJdmBG0eV5ACSRbi584IzFB5q/e21zOvpYqM9BrzjM+sUkwBAS8ALWOh3FqG2P+nmqBaQx7J5qibaqOq7TkyHb3ALejvg6P55Fz3Dlhfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611141; c=relaxed/simple;
	bh=RbcrERgPtxlrcK6g12P2lSWaopSt0KfbJiPoNV5T/xU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fTVK4WZSLWowdr3E7URewDVUryKkPqCrx/GAbMxd94DZ2fvunHqlmZfsRdWFPHW/5lQL2q+9VKv4fhvP8mRWSQMl5VWcVxUjtNwMZOYYDDTaj65QKvHfZGyhiPFM8kLQA0jo9uo7zf8IyNOf8wUSHnh1pb79UUD5/fJIhoBvDa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=g4FovKh8; arc=fail smtp.client-ip=40.107.192.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3XyzCJM94+o9FsEnbOQRspnZv0xfpExDQgyUvh2EJF/fOhsURF3LIHym1kgodeaDh+KG+y2Zz3VNBIL43JByQtUefWz8tUCuatiUL6EvR5Vk9APNs+nmwLlaiyzpLKoHcEkOdDttPAy9p7xzkme7va7i5u5+thhg32VI1v0586ra67xxHr6o6B6kZKOum6WdGYnBbqCT1DHxyHnI+Q6qgjrZzRhBkcgmIt3+ofzM9tNMXZlJ25kLwNUXVcUxDGVw6lerIuc6m4+Em0gzh/0mD3SSzIRvvIYoZ7EqQNLmFhc1IrScSZXw91FS8v+wBwH+C7gRRyMtVA9nISuZwE0JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIMx3Mge/KzDOHA1HEhuQdQKZPYm3+TZzi+7YhR9arw=;
 b=nKjHKRiXVR+MBQ1dwqYrtLTXfZI2Q9coOeyiGMt8YEtD+2Xgico/Yrmgu8S6w0s0fSvuveA7xzitCANVzlnd2a9wKA/ZCUJryViOKU8x1RgVJzVheLYf5W03WCI9jVWEvAVMtaiawiwmqXRommpLtBNOEu3RaS5rg1t3A03um4Ujo8KP58TZobg8B9Dd531UakR7GxZcB3R+YWaC3xL4QQbrdTaBBf6zAN7cINQ/4e4nRnLDsBrpNCfNmTRYurOfD9TDc/LfcMZzwvHsO5lW3HM6rRcDWT0cwTFH1bdO53RNF8KUfv1rqCbwUWazGx1WnRGGkiG6rzSHpTNW02bNRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIMx3Mge/KzDOHA1HEhuQdQKZPYm3+TZzi+7YhR9arw=;
 b=g4FovKh8esIFSWVfeQA7B0NM6egLqvoUH/EVVEmcHKgESSpx0r0NtCW1Im9gln4W5jijTS+fyDmh/iPoTP3bgbKe2WZuQLzBp+krTMzh+k7oPuer1cdYbNCPgRu6GuuF/fNZg++20EAFkejLFazGvv5yK7jTh4rmucYIegA3epsgs3hBAgwZEr0GqFH4IaqPZVRkiJklDMtumzP0eIwZ6MFt+9yJ9QeQ4/VDpwtzcbmSLp841iDfb83MPIU0gcs7mSpNqEtouPJyMKjYuhLvZpinCQbJP5n3avY2h7oh7kHg120//ubMgBZ4E/jZ5P963u8+FbWxMivWO77v0ZVcMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR01MB11178.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:90::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:18:54 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:18:54 +0000
Message-ID: <42bc968e-183d-44f4-9abb-6a88ed7d49c8@efficios.com>
Date: Thu, 11 Sep 2025 13:18:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 05/12] rseq: Add prctl() to enable time slice extensions
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.872081859@linutronix.de>
 <3951a525-8fce-484c-bdc3-3da4e6160c75@efficios.com>
 <16fae242-8eec-473a-b040-5c6d35ddcb4f@amd.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <16fae242-8eec-473a-b040-5c6d35ddcb4f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0348.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR01MB11178:EE_
X-MS-Office365-Filtering-Correlation-Id: a235f195-9437-4f70-a3ba-08ddf15748fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWhnTHlud0RLTWdVb3FnRTZ0b2pkelBsYlNWR2JSS08vWno1K285SkpPZjVR?=
 =?utf-8?B?SFE2QVV1R09nMjdMUThtM3pTWVFxekJ1N3hBT3RCZm9tUHJEOTdxanJjWjIx?=
 =?utf-8?B?N0IxemFTQ0VCdVJhUXhLUkQ1cm5abUdYN2Y4NTIyemNxOGZSbHJrNFdPUDJT?=
 =?utf-8?B?cjIva3ZYY2NBRTlkajBqM2Y3U2xDendXZUJsRjczN2JqZUlqU01Jcm5EL2tG?=
 =?utf-8?B?MGUrNkNWMklBYzlHNFRCMVNDbTVpUkJ5b3g3T0s1NW90SVpLSUV1VnBBRnlU?=
 =?utf-8?B?K293SmVKanBBSEdzT2czWXlpV25NWHNwTlA0Q2p5bnNnZXZLUm9CN3Q4bDR0?=
 =?utf-8?B?YVp2dDQ4dkIxbDZ1VkpHWTlESU50NkZXbERRQ2JYNUZFa0RjeUppZTlOTjRD?=
 =?utf-8?B?S2M1Vmtqc0prcGdiMHpYWUMxS3RFbzQrdG50b215cXliRzlMdURObkFEMG0w?=
 =?utf-8?B?eFR3SkdmSW8xT1E4VkJOZDY3QlEzMkxhbEJOYTdOZ2VNOEliRzNxN3hkTWda?=
 =?utf-8?B?VjZhcitsL0Z4WDhzS0NiSmkrUkJjOG1td0U1MEFmU2psNFBnQnlxblVmT3Y4?=
 =?utf-8?B?Zk1HV2k2WmlXQkFoWDE1c2tnUDhUWURoUG1Xc2hhTHJZc1FaL2FMRE1yOXhl?=
 =?utf-8?B?UkdYZk1TNVNlUTVGTzFrQVNvcnpMYy9rNm1WVHdPZFhEOXF0M0lTQjJWc2Ny?=
 =?utf-8?B?V1lpVWxrOURjd3V2Nk5IR0tMcmN2a0M3MFBqL0VtakIxRFUvN3ZiUkx3NUR1?=
 =?utf-8?B?ejEyR25LZnRuVU1sYityRU8wZDFsckIxQ2FySVhjc3JHRUdlKy9aQ2FNYWNw?=
 =?utf-8?B?aERubmVZQ25BK29BdW1INkQyL25RYlRiY29UcUQ4d2lBMHlxVGg2MWVkMENi?=
 =?utf-8?B?NjVvQUhHaTd0N2hySlNxWDc2WFNtd1A1VExVcDBaUzVqTkJJUkY5Um9Pdkx0?=
 =?utf-8?B?Z2p3N1ZlaGo4S05tYmp0K1I1SnhlK2J5b1J2bEtlOWFRNG9JR09qZDBnQ1JU?=
 =?utf-8?B?RGhWWnNJdXVFZ3V0dGc4YjRnazJEcWFXVG1kVkJxS3ZoYlA3cVpPM0dDcVNk?=
 =?utf-8?B?RnE5cHZ6M1JSaGt4N3NmVzdoWEVWS2c1R0NJVmwvdjUzMGk5UVM5MmUycnVy?=
 =?utf-8?B?VDcwQUtjTlhwdVVrRk5WNTdBU2pyb0VSaVZEVEdxY2UvOVgyWldtcCt5bDh5?=
 =?utf-8?B?cURBK2lKaGNTWVBIeGhvRXZkc2RBTUxhOFRaZTM4WU5UQTVSVEhLaU9jTHZj?=
 =?utf-8?B?aURGV3FSK1F0SVJ4RGthWG95b3dScDRJcWx3NmZJNEM1YjlVVFJqSEdVYlZx?=
 =?utf-8?B?UTc1b250bTVqWkNaL3lDYnlXak1LQ2xUVi9IdCtlaVNPWXB5eDdwZHFtbHc3?=
 =?utf-8?B?UkR5bjYvQzVvZUJKWktWTnpiVnhjV25XVnpZVWZNZTMwUHhwSmUrai9iSGdH?=
 =?utf-8?B?K3RpWFRjN1hWZmlTeFk0dEduM2prR0Erdk9VV010dHFLN0xITktaL1kvU0dx?=
 =?utf-8?B?RGJWRGs2andHWHpLb2pwem5jZXhDV1B3RUh2Q0ZTVFJZME1JaFVJbGZpYmtw?=
 =?utf-8?B?MHFCRE5XU0YyWEQ3NHBrNWNpYWpkMVVJb3h1ZnhyZFlaY0t6czVkNGxSZmJ4?=
 =?utf-8?B?VXlxMjFzaEZGTnRLd3Y1dE5ubTdad0dwaTdwQU5wSWpyUExlMjJJdGNyWlBQ?=
 =?utf-8?B?SlRNbXQrV212Wko5Yy9BekhYZDVxYzdVMzh4bCtBK2hCWTRYM0VJd0k1L0Yz?=
 =?utf-8?B?QUpEcEk2dEtzcFBJcWJhUlZPR0dsTmZnOFFqTTJQYThkNWRqbU0xcit4TjBs?=
 =?utf-8?Q?OVpAq4Hh8edgbVbd5Be/LdyNWhpEL/jkduWhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDgxb0NkNDdqZkVaSUQyQnFiT1pIM0tISjhMZjFHbERDRjhtcmdWZktaK3Mr?=
 =?utf-8?B?VFhzdk0wdnk4eTBhWlJFeW9QTUdwYitVN0ZXVkRKbE0wbkVsY2pVWHBxQ28x?=
 =?utf-8?B?RHhvTTBEZTYzOUlaNzNFcUppYldPeTVWQkFJMHkwa3ZXUnNvTzg1dEE4bTZ4?=
 =?utf-8?B?aXhKOU5UNFVGcllLUGMzSGkvYkJpMXhkdnA1RVovY2M3Y3krNHBmMkxMK0J2?=
 =?utf-8?B?TmtweUYwRXNNWnBUQ0RGNjEwRnUvcHppOXpRMTQ1SGd6WnhuallpcW9RTCt1?=
 =?utf-8?B?MEphZjVSY2JpamgvMTgvWWk3Z1BkWHVwMHFwQjVrVU1wY1NIVWJpSGZxN2pE?=
 =?utf-8?B?NWdLTVEzSisrVmJXaVYzR0Nrc3RXdkRtMEhaSU5RclhtM1ptTUIycjFSWEwy?=
 =?utf-8?B?RlB3SG1pcHYrVGRHM1p2UmhKVE1lcFA3OWNRREVuaWtnWFVhQzYwdDNyeVEz?=
 =?utf-8?B?T1ZsSkl6V1QzZEs2bXZaSy9VSXg3Y25wSjhVWTNIOGlLQ1VRR0dIaEQwakZS?=
 =?utf-8?B?Qkh2SkM1TnN5QU9CRVJYbXRXT2kyYzJveUhZSzZJV3FYQUtoVVFaTkZmdTk2?=
 =?utf-8?B?N1p5NkY3UkNpNjRPK0ZxM0FIcDA1UWVacGNZUHJ4YzdveW02NTlXaTJYSUhv?=
 =?utf-8?B?V24yN2RDeXVWYWZMdit5Rjc5c3IwYk1YOTByR3Z5Z3RITGg2eUVLK2xhRVl2?=
 =?utf-8?B?Wm5aS0taY2trS0FsdDhWWUNaWFRyQkp6TE80V2EvbUV2VXhVdDkzMnh2dmV3?=
 =?utf-8?B?Z1JZU0xEaGZ4VmY2SjdaRjRBdlVkbWdJQjJoT3M2WWpxVDJNbE1ZRERKVFpm?=
 =?utf-8?B?ZjFJVXBoRXpJODB5cGhRc3gyZWJMRVF6YTZQaDZ6NXRuZU9UWUdJeEV1NGYx?=
 =?utf-8?B?KzdySXovekVtQmwwS0Rwc1I5akJuQXJCMXFEWmdjUFc2MTRQZmwybW5NeFow?=
 =?utf-8?B?VWJKOXJzTHZrb3YzdW5wcXVMeXdWT0ErdU5CSGlKYWhjTldpM3A1Zk5UWmNH?=
 =?utf-8?B?Qy9RWTErNnlWUHlCSkpWZVcvMzVUYWV3T2d6d2lIZ3VQR0dEWEc3anZUT0hB?=
 =?utf-8?B?S1p6REpwdmZCVk1pRmJpU0JibkJIUHRlWXhZem1rWnRMN2JKT0dIWnpJVzA2?=
 =?utf-8?B?MVJBQ2pISTlKT0V6bDZEaEtXUkdheGhnYmpJMkF2WHE1cFNsVGdrcGVYRTQ4?=
 =?utf-8?B?dUJwY21XUnVuZHF0WmpoKzdkWks0NmROYkpwRXUwcUdmUHNTQ2VpMXdZZnp5?=
 =?utf-8?B?cDNSK3JYME5WUVpyR1liOU9GNlN3b3VQWWhSWmtOQVhmWVVienRyQWE1TGtJ?=
 =?utf-8?B?TWFLL3ZsVERGODkvWHV3NlhqcUM5UzNUc2ZWQW0zRHVPNzA5RVA0cDF6YlBi?=
 =?utf-8?B?YmszUzIyY3ZDclUvZGptQUo4cmFaaGJYTjYvNkhwWnVzY1cxR0NDVnBWNzVI?=
 =?utf-8?B?OHV4UFhDTUh1TWoyU1czSjFTSlFaYlU5b3pqUnd6UDJzUGdZRHpUVERIdkp4?=
 =?utf-8?B?OTM5R0JNZ2FrUEFBTzI4cFQySUQvWVJmTWhPYzZQVDQ2YTBxSkNwV0xpSzE4?=
 =?utf-8?B?SHJoNEJiTzZia1JwNk5DQUlkUlJsc3JhSlRTZ3pUUnloYzd0TGhXS3Z1QnNJ?=
 =?utf-8?B?b1pwR0pYTDhtRVZybEM0TFF2b25wd3lzSHRTcFVwSEMyOVk0Tyt6MnRDYndw?=
 =?utf-8?B?SnhRZFE0Mkxrek8vNHBZNlZuRXhrVnVFcm90Qzd6RERxR09iRjJFUHV2YWxu?=
 =?utf-8?B?eG9XN0xSZUdSaUxjaVpBbWJmbWtrTlJ6VDU3cjZPMGRaN0YweERZRzRiNHox?=
 =?utf-8?B?Y1BuNzNOZlFKbmlFbS9pR1N2MkNwN0NvbS9Fb3ROTS9JQmx5YS9GWlZCQ0ps?=
 =?utf-8?B?eWkrT1hXT0pZQ0FzZzZMVys4NTBjWGY4bXorSUJBREJ1Z3REWUNzZUxFNjgx?=
 =?utf-8?B?OHg2VUVCRmpGMjl2eGZaalcxTXdKSlp5OWhnSXk5ODc1cXZMZDR5d1o1d25G?=
 =?utf-8?B?a0d6U1FmRXZVRU1MeEhNRFN0WUxESUFsNmNvWXdEdmJtNmtjTUhGL041L1VL?=
 =?utf-8?B?T2RjdllJSGtkUC9YMTNoV2kwNWJRbnNtQld4MUovRFdOMUlXYmV3UUludk9S?=
 =?utf-8?B?ZVN2eTVHWWVKd3F1L2xYcHI4N0c3YjZSTTNmaDBXSnIyRmdLWU8yTjB2Yitj?=
 =?utf-8?Q?v0QW6n4khGt5OLFYvWlBRws=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a235f195-9437-4f70-a3ba-08ddf15748fa
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:18:54.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4R/zXvL6Gk2sbywoyE1wVzTXSpG3/wgZS3a7CxB1sJmwbdemZczsdpkV9PD9T3RzZamxQHOg+T5Fq86niCPf8CDQfTjovYKaSvQnxmlI3Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB11178

On 2025-09-11 12:52, K Prateek Nayak wrote:
> Hello Mathieu,
> 
> On 9/11/2025 9:20 PM, Mathieu Desnoyers wrote:
>>>    +int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
>>> +{
>>> +    switch (arg2) {
>>> +    case PR_RSEQ_SLICE_EXTENSION_GET:
>>> +        if (arg3)
>>> +            return -EINVAL;
>>> +        return current->rseq.slice.state.enabled ? PR_RSEQ_SLICE_EXT_ENABLE : 0;
>>> +
>>> +    case PR_RSEQ_SLICE_EXTENSION_SET: {
>>> +        u32 rflags, valid = RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
>>> +        bool enable = !!(arg3 & PR_RSEQ_SLICE_EXT_ENABLE);
>>> +
>>> +        if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
>>> +            return -EINVAL;
>>> +        if (!rseq_slice_extension_enabled())
>>> +            return -ENOTSUPP;
>>> +        if (!current->rseq.usrptr)
>>> +            return -ENXIO;
>>> +
>>> +        /* No change? */
>>> +        if (enable == !!current->rseq.slice.state.enabled)
>>> +            return 0;
>>> +
>>> +        if (get_user(rflags, &current->rseq.usrptr->flags))
>>> +            goto die;
>>> +
>>> +        if (current->rseq.slice.state.enabled)
>>> +            valid |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
>>> +
>>> +        if ((rflags & valid) != valid)
>>> +            goto die;
>>> +
>>> +        rflags &= ~RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
>>> +        rflags |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
>>> +        if (enable)
>>> +            rflags |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
>>> +
>>> +        if (put_user(rflags, &current->rseq.usrptr->flags))
>>> +            goto die;
>>> +
>>> +        current->rseq.slice.state.enabled = enable;
>>
>> What should happen to this enabled state if rseq is unregistered
>> after this prctl ?
> 
> Wouldn't rseq_reset() deal with it since it does a:
> 
>      memset(&t->rseq, 0, sizeof(t->rseq));
> 

Good point, thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

