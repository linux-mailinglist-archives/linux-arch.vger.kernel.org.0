Return-Path: <linux-arch+bounces-13486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA72B526D2
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 05:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FEA1B2721E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 03:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8FB13D891;
	Thu, 11 Sep 2025 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kRjslDzD"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120053594A;
	Thu, 11 Sep 2025 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757559838; cv=fail; b=L1lg1v2+nwLNAkm+Bo/RBWlCT4Ntg6XfugwEBaHWmKCGHpDiFIOpumWG28mXFiEC+D365VygY7+G7m/LSw42XRDwi7cyTX+ZF/kujjpfThS/Es+2EF9DpJZDXBYAhFGUhtAhbICC/+g6m1emJyANFozzpHB3Sx0vkXl37vl2TJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757559838; c=relaxed/simple;
	bh=pULXPH4hqDsjUjh3oiripPtxkd+Iz09e7ReEBS6vUKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aVDBBGXq1shiOSwW4IL8s7K0Lkr6y0zAJfQRmbfIwblGJmhW7DrBYpF8Qh05QWhn2t+cRuA+3afumsuTnriK8cbGz/Di6g973mOnE2cl7ltpzoD2xXBpHsZIIUtbsmoMHUoIUbm0XgtRUHZoShnyg6qYfoa66KODo8PEO6HtYx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kRjslDzD; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZQHllu31DrfKBfJLTgWIKr+VCbeBsgXAwZezo2p0Lbkdbvot7u75xmAQmcXIVbbZOU+wYEo2+rsgw3KPbOtmrP4YoKeetuHPf1COBDnaZ1Ul++STtxZAfd/J6ACisalaKSu2EDMuTzVKtI+aJHTfj6St9MdPmBdc9SZC9LJoU+j9xrHvZukcc9TZwNoJ56Rnl5724JD1kp6A2IUt7uL/gMzMrLDpmk1Liavul/IxoPrPSTQmdphZ8Pq1iT8ZJBQEJEgcDfskV0j3jB1tic3YLkV4s0ZF8ntekFWq4G9JQS6gY7hQAafRLMOz7TGVydUoi58OFlTgKnOn9tgq6mihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt1damcrpLpNlGnBVKSmtMR+fr//tmnjGYHKjCd7svo=;
 b=LKlXRKUHmZ7zVZex++nVAJhKHbT0nnpmH9hJ8XGelYfvJFIH/k2JN5KWlBJLTlOG+uOzoPtE91WNRO452frZenOwm7amCzpobI6/NwXNVhI9adLtWzBx3jgYbImlBFXvdiYh/FFLEWLdXLSR+y7jYMlAQtgN7r8zACyEbVCs/74QRgo/gf8whXRG8LsuzilTw4Uc2h4J4P6dPlIH2wpprs6/qD/gU032B+JOjOcRkN2bAAzFYHmlTfbHPiKBfWhTw30qNBHbK4QgxWxxW7kqYBsht0ZdLo4FCf8arjT0Fn0Spe85Md6z8GrJEt1/Tb7flqA4MYpOSdbmjDAKQgo7pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt1damcrpLpNlGnBVKSmtMR+fr//tmnjGYHKjCd7svo=;
 b=kRjslDzDQrLGry+sobjljDZQ3mPKA4WUwT+1wBxo+YixOSjaJVC5W1H6bNUfq/wBofGFNYSEKsPLex8vLBpdGLgZIxFQapCbig53WTswwOW+YuDS2Ntb+aE3UyraLJxCyB7RmhgcQxbVrH5zq9GO/H1wywq9bic9dElL9GzMqKo=
Received: from CH0PR03CA0403.namprd03.prod.outlook.com (2603:10b6:610:11b::13)
 by DM6PR12MB4186.namprd12.prod.outlook.com (2603:10b6:5:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 03:03:53 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::35) by CH0PR03CA0403.outlook.office365.com
 (2603:10b6:610:11b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 03:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 03:03:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Sep
 2025 20:03:46 -0700
Received: from [172.31.178.191] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 10 Sep 2025 20:03:42 -0700
Message-ID: <fb66953f-8d03-4026-a33b-f414db776f37@amd.com>
Date: Thu, 11 Sep 2025 08:33:41 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: Peter Zilstra <peterz@infradead.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Prakash
 Sangappa <prakash.sangappa@oracle.com>, Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	<linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <e2b2d2dc-adfd-46db-85ec-a09590fcb399@amd.com> <87ecsetl87.ffs@tglx>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <87ecsetl87.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|DM6PR12MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7dd79a-baf9-406b-a7ac-08ddf0dfd6d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3dNQnFrcTZVYUlXN1p6eVJFRFFwOVF2OWlEYXNBblFMMWJERW5WLzM1c1Bl?=
 =?utf-8?B?ak00YUtMK2x3dno5YlNWYko2cnRzd3h4cmN2UXlNNUo3V1dNSTJrb05FUHZm?=
 =?utf-8?B?TndJM1VGc0Z4ZXlYd0c0czE1aWJIeDJXRlJodk5laXpRTEhyMFV0SVFFZm8z?=
 =?utf-8?B?VFg4dkNVTTFCSEZKTVZ4eDFUNDkxWGlmMjVpSUFzcjFoL0hKSkF5YVZxNlhH?=
 =?utf-8?B?blVrY3VrSUJ3NTAva3FJV3Z4dGdBd1VzeURadkQ3Y3kxRkNmVzNCdTNnNVp6?=
 =?utf-8?B?ZWhZQjBTd05Za1lBRkdRVkU2K2p6YUwrY0NUeVBEemdSUTlkem5mSzJBWTRn?=
 =?utf-8?B?akY3ODF3UGNwL0NZZ2trVHlzdzZJRGpBZ3Fram1qZkJtTG5uenY1ZGJjZzZm?=
 =?utf-8?B?MVpUeDN2a1J6dVJRaGJvZUZ5aU9TM204TFd6bk56Z3lnMHlkbnF0a1FUSWNz?=
 =?utf-8?B?OFgrT2FkU2d6NlZBN2ZVQkJmbU5hVlZVNjFzUmN1NmtYWGZoaDI5azB0bjVD?=
 =?utf-8?B?V1EyVE1ELzF0YTBvVFJBTU9jU0hKanFPcXBUeFJSZDU4ME03YnFObWdEdWVr?=
 =?utf-8?B?NnA0OXhBSlVhNXBOWkRJcmNtT3RBNWl0VkdMY3h5ODk2b3dyZTFtbWh3MCtp?=
 =?utf-8?B?c2ZkeUd2d2drN1pob0hsOU5zOXc0dXBqZWhEK3IyUk5LcnlYK05mcjE2ODkx?=
 =?utf-8?B?cTFWOVRReE9Mckx0Nitsc1oweFRIVGxzUU1UN3N1Zy9CWGJhZXlJZ05icU1r?=
 =?utf-8?B?U0JLTVVsd2JoYmdYcENKRms5NHh4ZkxvVGV6VnJUWXFyQ1l5b2tJQWpCM2dT?=
 =?utf-8?B?OXVBT3U5L2x1MXZJWU96ZDlSbUhEaEN0eVNDZ1c1NU9IL2Y4Qnp1L2VMN0t1?=
 =?utf-8?B?SWgybG4xenRCQlNJYk1MbXVRNWhHeXZFaHlJT2t0ampjQ1htZlpuMUU3c0lv?=
 =?utf-8?B?dlNzWUkzTjg0ZHNIKzJhOFJaZlVZUmVENUZ0bVZHaUxjSDNZTUh5V0Q2bk5E?=
 =?utf-8?B?MG13VGl1K0NJN0RuT2hCaWlpaFFuOExSNVovWTZlNVZBWXVXTThjSFdtZEhp?=
 =?utf-8?B?VkFHRVpBUHBLelE1cHFhQ2tMR0x6aFBub21IRkVUdjFoOTFlaUZIWXZ2UDRO?=
 =?utf-8?B?WWFJb01WM1RneHFkQ3ZGcmc4VXhsbVhRK1UyS3dtMEVPdDhWSTJKS25RK0hT?=
 =?utf-8?B?MmtOdDBGbERmWUgxU1RGRGRMVHovSGwxOTl1ZVJvd2RHczM4TXNNdGxRdk5y?=
 =?utf-8?B?QnhidXY1YnNXWHhoUlB5cDNma0szUkhzR2ZlK2IyZWwzNTZORjJxR1VTYlFC?=
 =?utf-8?B?aThyV292MDhGb2doNk53MEJaMFgxZy8wTnBMb3A0MTRBSnhLaXJVZ0NXcGp6?=
 =?utf-8?B?YndoZlhJMCtCcDVQTEgzNDBmT3BkOFpwOTFFNlFZQTV6N0l4U09lc012dGpQ?=
 =?utf-8?B?b2d5cDVTbzIzR3FKZjFrNTF0emRBbEtqMEg5Q3N4YjQ0YnNGMFg5cVcxcmVW?=
 =?utf-8?B?dE1NN1J6TXNPb2llbk5uVDcrT0dDNnhNK2krMFFKN2RENnE5a1RNczh0VWpu?=
 =?utf-8?B?SGdDS2RYeEYzTXdmeVYydmZ2bHFGZ2tZS3dHTHZOMjFBTFl5NkhhZEV2cWhV?=
 =?utf-8?B?dndHTElKUzZHNmx3SVZJcklleWVuQjN1ZG1NSXl2N1c2MHpmODdhWU45VHhj?=
 =?utf-8?B?VDFPd1B5ek1OY1hFeUd1Wlc0S3RmQXB6WXZwWWNCQU4xdGlTeGo3aFJxTHdX?=
 =?utf-8?B?Y2NNM1MvMUFVSFdORTlpMDFjSlozcU1xTlhuVjh4WEZuYU56T1Fxb25sMlVN?=
 =?utf-8?B?SHVvbklQR1g1clk2czB6M1ZodHdSaTYvY3FqbGIzWHJTTjNZbmdOTjNtSGp0?=
 =?utf-8?B?Q3NkZ0kvODd3S3FjTGkrY0NYVDd1WnhEcGJZTndVVkdDRVg3K2FlVlZJQ1B4?=
 =?utf-8?B?eSszaFQxUHdzcHVUT2VjUC8zME5BeWpHVk12RmxXcktoY0Q0V0tpbnlFTlFt?=
 =?utf-8?B?V2V2VjJ0dk9IOTBDZ291Rmd5YnpSZjhZNlZiUk9lL1ZYYzdDOHY0YXJFT0l1?=
 =?utf-8?B?NzFvZWQyTVUwYWxSVkhFTFpZc2NGd1Z0UG5qUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 03:03:52.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7dd79a-baf9-406b-a7ac-08ddf0dfd6d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4186

Hello Thomas,

On 9/10/2025 8:20 PM, Thomas Gleixner wrote:
> On Wed, Sep 10 2025 at 16:58, K. Prateek Nayak wrote:
>> On 9/9/2025 4:29 AM, Thomas Gleixner wrote:
>>> For your convenience all of it is also available as a conglomerate from
>>> git:
>>>
>>>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rseq/slice
>>
>> Apart from a couple of nit picks, I couldn't spot anything out of place
>> and the overall approach looks solid. Please feel free to include:
>>
>> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> Thanks a lot for going through it and testing.
> 
> Do you have a real workload or a mockup at hand, which benefits
> from that slice extension functionality?

Not at the moment but we did have some interest for this feature
internally. Give me a week and I'll let you know if they had found a
use-case / have a prototype to test this.

In the meantime, Prakash should have a test bench that he used to
test his early RFC
https://lore.kernel.org/lkml/20241113000126.967713-1-prakash.sangappa@oracle.com/

-- 
Thanks and Regards,
Prateek


