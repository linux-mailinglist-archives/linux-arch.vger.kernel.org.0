Return-Path: <linux-arch+bounces-15416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC758CBE201
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 14:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40A4A3037895
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 13:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3D2F0C74;
	Mon, 15 Dec 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="mwetCPOK"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021098.outbound.protection.outlook.com [40.107.192.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFF82E0401;
	Mon, 15 Dec 2025 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765805765; cv=fail; b=cFUtvFovdyLq8dNaTmfoBG2i+49A2sA9g8pePGX2xQnL9ALVy/2rNR9DSiUk4H+nlXTvg/SqKX6P8a5l7SG+SErjOmaM7y90j9BRC0SyYB9q2B+NBRQtnTsfenkxf5UoH7g6YIZ6KR4dG8AY/APAzYMD6KmrP8EndomSWpSNquk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765805765; c=relaxed/simple;
	bh=96gnnKjPgiEKojOHv5b48EPxkPM4qE/YSrfNaA2VmFc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sGJEl5W9MVmUPahhi1qGGsWwQ922XcmI5RIvaG/QL3uvHmBUuurtNdY2jUBRjz8CY0n1pBHa38dlvC0KtKP6ufCytk8/NVTJSr575u/4dBiAUs16xXVFxcVgPNgncCy7JqvS8qFKqp80ZPQ9e0qr5N5RBo8eeqNvtVe+kQpeQvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=mwetCPOK; arc=fail smtp.client-ip=40.107.192.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmip6x5UwbFIa3xxAcT6XG7OJob7OcH/unP82JmRG0Gk1d9gX9yoBb1wl5PfSCprvoILDI46wuEnCm5/4z5L1vtAjg40SH+ev5cBGR4LFcB8csa/isEf/NDFrcr+WKPPdUsq8ajSeSUa+7AYmaU6/qkQLz7HERkPZuzL4aIOizXEv6NVDzF8NFG8ONtkbUrj/0XMeP4ceT9sMCJZyV6j0bj5m4zdDg+zH4gho+NX0GnS2oiVtdFOOwbDtTfU+XNgPvc/5CEzoUZ1HJ6C8X8dpDNms6D9Me1LqMDXmoNHSe8QZB63D3JotQs9/OzztG73+yUwYDXX1bbCxe7ut9Nybg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqGhfk4DPMzaCuvzlk0vbe36KfgrNbnCbKjhu5dWuWo=;
 b=HPrROhuolg3zLKFUT7OawgbGGMLzlAuj4xzA7rYD8dIByXCznS1tChV0vUfBJwUmwBsOCSlvKf0jPSsctMaxIgzeGjuQJBNegI+2iGCAS8/Sg8htlPTw/QchF7ocEjOiGXqQO6nUT7xJgWBG9gI82c+FqueHyw2gUg+zr7srwKW8D8wFZ/pPgjwrLFCICHgZLsP9+15lmv/ht0IfILKAoQhYT+ZqYRN88mnNAFyzs2uZEpIZWBes4R8stQMbnnflHWhhpRHkkTcKo8ZbsYyFhCsfym2XMDxis75S91X0txCOit1fslbENszAa6cJRGtGuRwkZbRLJEXFQLTx6Ynxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqGhfk4DPMzaCuvzlk0vbe36KfgrNbnCbKjhu5dWuWo=;
 b=mwetCPOKQFTcj2NOKm/HlDGGNvRjTWfBg8orRx5NcgxQ/bIs3FNmGRActpeD5fHO4rHs9Ymnclbou4Xn/hAPprIzZrMhri/bPyoRwJ8Iu7tWKp8b2J+JGSgWX11tlWnisH8WE6WhI4rY/MC1zLOrz/TQtI19a+TRNp6WUq/0uSXwmx29oTlbjjOQQddtVe5BmO4jtWrMsnPdiPKm4Fwa522vbu9u/IrO0v0gr8Yk6zokNTJ5GvDilCreWS0OtTMWpkYRVXF0KAlmqTiYFaDxTGW6fjyuyBTwejyoYDBBLQ+AogurhZOuAXMLLlhcfePPC76mdUEQdWuJLosXTbKNqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB9526.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 13:36:00 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 13:36:00 +0000
Message-ID: <c754c406-2816-4b70-a4a8-7a11b9ec45d3@efficios.com>
Date: Mon, 15 Dec 2025 08:35:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: Remove tlb_flush_reason::NR_TLB_FLUSH_REASONS
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Tal Zussman <tz2294@columbia.edu>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 x86@kernel.org, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 David Hildenbrand <david@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org
References: <20251212-tlb-trace-fix-v2-0-d322e0ad9b69@columbia.edu>
 <20251212-tlb-trace-fix-v2-2-d322e0ad9b69@columbia.edu>
 <a5f3885f-aa32-420b-8d2f-e8ed6bfc6ee3@lucifer.local>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <a5f3885f-aa32-420b-8d2f-e8ed6bfc6ee3@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d50caa-bd40-4ca8-97d9-08de3bdee261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnU5T0lQY3FBYUtZUlV5OXhBblhESHlzRnRUVFNxajIxVUszRjhYZlg4NE1C?=
 =?utf-8?B?OE54OHJ0V2doV0JiWVl0RklsWklGcHp2dmZQc2loTTRyQWhEcFFlV2hBK2N4?=
 =?utf-8?B?aFBkTmFvL09SNG1lRG9wemx1VCs2ZjQ1aTJOTzZYM0RUbnhjMkk2TFRsWk43?=
 =?utf-8?B?NldLeGlCckxTeHRFRjd4QUp0cllpSVhZaGRaZmlEM3RneUF1NVF6MHN2QitP?=
 =?utf-8?B?eTVGcDZ0MUZiUVBNdUFSSnJBMGJYYWs5VFU0MjJ0TVprV3lqRFZWOGQ1d2Qw?=
 =?utf-8?B?NFE0dEEzSHZtend5Z2NuV1o3UC9tVmlJdVljdEkreHJqV0xISUV5bWJNSytL?=
 =?utf-8?B?Nk16ZlNIcDVZUFRqdk11THFvOEdlUDZVcjF6UXkwSitpMTNDV29nYVcxTW8w?=
 =?utf-8?B?cisxVUhXU1VaQ0RJZ3lRZTUxQkZBQlU1L2N0dFVaWTlNeHR6TlhjRkswVlJD?=
 =?utf-8?B?OWJzVkhxSGIvT2JqSmdBOUppNGY3dHRxUVNTUTB5bGk1a0VJVjBiNkNjQjNl?=
 =?utf-8?B?bkg4SWpDRkUvMzAzTkozNnoyeVRVeUUwSjRScTJCeVdOT0k5OGFvN1FEQVlR?=
 =?utf-8?B?R1ZQVnNFanZFK1dncUMybStqNmxVV3NZTkszWFhMQVNTZzFWbjRwK0xtMUZ6?=
 =?utf-8?B?c2NtUXBxQitHUi9QTmlHVHVObFRtQU91dDRIaFhZZGpscW5yY1lyeGZDZUM3?=
 =?utf-8?B?WHlwa1hTZmFTMGE3YXFGUGxNMVpjSUcrUXdKVTlhb2ZGSWhpeVJ6REdvQWVG?=
 =?utf-8?B?dnV5SFJPMlEwKzlYQmRZN3NHZngzOEJFVE9NcmQzS0E3Z0x1My9GcE5lc21w?=
 =?utf-8?B?MGdIczNtZ1J1cEh3cjIzMklqRVdBU3NSaDdFMElYR2UvSUozcy80UHd3cDhp?=
 =?utf-8?B?eVF5Um5kckNRSlpKRmZLdE94VzV1YkxDUmdFRk4ycWhFRlR6LzRScHZ3dHVk?=
 =?utf-8?B?UkdpVFRWTjFtbHRpdEtTNVhyVFByc2dXc2svVEIxZWE2ZjdOY2d3a01hK2lv?=
 =?utf-8?B?cFlxZUpXY3RCak51RzIzclF0VHM1S1JTQzhlbzBJaTBuNFFRdHRqNy9OQy9V?=
 =?utf-8?B?MG9YeFFRelBVcjREQjlGa3Vpdy9kNFdVQlBkb3hmL25MRVh4MUtZaG5hSmxO?=
 =?utf-8?B?OG1WeEdaK3VFWXA3aWU5ajZITGwvVU9vTmMvTG9YRXhVZVVrNFVuaWo2ZDBT?=
 =?utf-8?B?WTNwOFRBc0pwYVRqOGczeXVGUmJzUnNqZCtBYmtFL0pOY1dlblM3WW9RNHlt?=
 =?utf-8?B?OVJNa0NzbkdWQVFNMEc1SDEwdDRPUlMzR0g2UHE0b0hvTXZyMUp6WEhCVXZj?=
 =?utf-8?B?dGM2RTlDWEE5K3orc0NLVUpDYzk2MllHaGV3Mjk3LzFkVnNPazJtZC9MRFY0?=
 =?utf-8?B?ZXkzbTJGVnhJWHpGMzhzSTM5WjQ2bzY3QmNXV0hud29VV1BvRm9GYjh6NEsv?=
 =?utf-8?B?eXFDa1kxRElhQXZmNW84YUdNbXVRbWx6RzF5SFpXVXZ2NXRWTmMzUGFNNFRP?=
 =?utf-8?B?QnpaL2gybDhZUEN3cDFvRjZMVlY1OWtjcEdFeWJhNXROZzU1Rkk4dWk3dWwx?=
 =?utf-8?B?YkxqT0lObXRNR2YvZUFLSVovdmluN05Eb3IrTFdPajREMGNxdkZVUjdyWmpZ?=
 =?utf-8?B?OVlCRGtLQlJ3ZUNFSW9JdG1MR1ZqcjFYcWlBUlhiRVJJeEsxMEE2d2ZMczBW?=
 =?utf-8?B?OTdjTHhLRE5SWDhtcDdKcDVkUW5SYXRxOE1SRU1PN1NMYkZCbjlNblNobGhT?=
 =?utf-8?B?RHZZZWJRU3JLYUQ2T3VndVRENDJMNDhIdHczV2IyZ3lGVFlOdHVQR3hqTGlX?=
 =?utf-8?B?K0Vtdzhoalg3OFcxUlJsZFJzOVVHZDZNczQxRnkrbVpkZW1HL1lUUldiVEZE?=
 =?utf-8?B?anBXcVp5K2ppNXF2K3JEUkpaM1IwdTFiT1k5QkdXNTBjYkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFNwYWhhS1dZc1VMdGttOUNwZm9sV2VkaTJYTGRrb1hrQ0hZMnFnbTlkSTcr?=
 =?utf-8?B?QmpEdExuWHhEbUNmK0tHL3Vvd1Jsd2ZFanNBdWRHemZiV2g3d2dSbnVTM0J3?=
 =?utf-8?B?cVYvZUxEUGJmVy9RNlZzR291QWxRb3hiUkRQczgwMFV3TjhsdXZkWXFVZmNx?=
 =?utf-8?B?S3NxWnZpcm8vUFRseklvY3NSaVdidHlhZHpPdG4zc21XZ0JqR2hITDk1dHBP?=
 =?utf-8?B?RE9RSFZJQjZvSmU1c3h5bTVpR1RWdkU5WEZybVNNVDVGTFVqWk51OERwSzdm?=
 =?utf-8?B?c3lVYnU4dU5HYnRldnZpOHdzSjR4NTNQZ3NRNHJPSVNjcURJOWszWkdDb3R6?=
 =?utf-8?B?cmJma2x3ekRkMXVxYlpKdVhNbUV2VmpBYUo3ZFZoRjBIRExaUklDcElCamh1?=
 =?utf-8?B?MnUrd1kvdDlHM21uNGpaMUNSUFRoRDhxN2YvMEZtSldqT1N3V20vVW5MRlkv?=
 =?utf-8?B?MWhCZXp4c1VzY0VvYXNqVVhNWE5ITDVVRkYvNW1XcUx0T0N5V1JLSXg2cjVo?=
 =?utf-8?B?dE10MFE3cEYxNE5NN1ZiSGx6cjdKbXE0aUNPSFd2M1RraXFsV0gyS1g5bisr?=
 =?utf-8?B?ZnExemxZWG90Tks1RHhMOWx2RElVc0xWS1FsWDNJaTBlaWZLNmxkRjVaQ0lZ?=
 =?utf-8?B?VnYybktmWXo3QUNFTDJZemlCbGV5U0czTTh5Wmt2Znp6bUM3bmNxZUkvUXhT?=
 =?utf-8?B?Y3ZneDlOR2ZNVkp4NkxMbGc4SmlmNHpMQUI3aCtnYnpLOXVCa0FwZlZXRmV5?=
 =?utf-8?B?UlRWVGdHSURvYjZTLzJuMW45M1RoK2NyL0dySS9LQTBTWm9uWisySEFybWNq?=
 =?utf-8?B?SDZGNXBsN2ZXUE5tWTJXZllQWEF6cW9vMVZUb0x1NEZHVFgyeS9DS3NvZGlZ?=
 =?utf-8?B?eHhsWnZaRy9aMjF2ZWd0R1VueDNHTjBucGI3K2Y1Ky9hZFVhb1N0QlFWMWhi?=
 =?utf-8?B?T1lhWUMvalA4QlBSeE1lTFpLbXRFVXd3TXJuNGhxdldDWE1lKzBkS29lVFFu?=
 =?utf-8?B?OTVEQUJJNlgrd3Vqd1NMK0RjUkpLS2E0R2NxVDQrSFh5Z3dsV0dzWXpKT2I1?=
 =?utf-8?B?M1hkdDVPeDhRZzdmRElBdHJkS1pTWlVTdy9XRkx0azR6TjhEU2J4UjBoajNS?=
 =?utf-8?B?dTFHengrbU4yTkxWOEpaeWJuMVVyQXRJbm55MC8zZHliMFo0eFdZZFh3blZ0?=
 =?utf-8?B?aXZPN2xPajh2RzNjWWN2Y0dUQ2xkRDhFY3ZWR1ZRMXhxc2xvdmcvL0VRNEZr?=
 =?utf-8?B?QXNKbHRyNDBXUHJQUGZ1aTYzTXl0QS9YWm9UV1N6R0RNUlhZeVQxOWM1K2VI?=
 =?utf-8?B?NFUrUlFvU2Njaldxamh3UTBZVFp4Q2EybjcwelFkc2E4VDE2RkNuK2F2ejZE?=
 =?utf-8?B?empJZ1p4UlNQQ2p4b2pwQit0c2UyUU8xOVl1ODlVbW00Z2xFUHlqQk5GbE51?=
 =?utf-8?B?enQrUG84UitYL0o4bm9CTlFmWDJBWmlKN1hJNWpWYjIzdW5jc2RVQkpxSDRE?=
 =?utf-8?B?elJiQytvOW5pc1BOSFd1SGlFdEIwdEI3N1RhanB0aHBtWFZaYytreHk3VjlO?=
 =?utf-8?B?NFM4UWNIRHE0d0o3ZUFlT0ZmZHNJcjB2a0dLTk90NDNyQ1dxdmhiVmdLRTNn?=
 =?utf-8?B?TloySEZTL1d0aU50bXF0bkoxaGtpWXlrdnQ5NTBmTnRGL2dEc3V2YVAzcXE1?=
 =?utf-8?B?L3QxTmllUHhNRks1cTg1SDFMRnJwOFpyU0p4MForUm5qeHNYbDZhSnRGU1R5?=
 =?utf-8?B?TFc0NE1LTHRVMU1qM1RFY3lUcEQvbU5QY2o5K0xmUmhaak5MY2lVeUlOaU1s?=
 =?utf-8?B?VUVOb2N4TTVkMGZ4c0VCOGRYcml6MWNDQVhkZC9IUnpxalN4M3Nyc09uVkVB?=
 =?utf-8?B?Mml1cEcxZlVVQmJreERDMWFuQWRpR01BM205di9NM2ZyVG05RlZ3RVFJSVZI?=
 =?utf-8?B?OEpBT3Rwbm9idVV1ZlErNC9mbTBYbmhDZElha0d6ckQxU1JxZ1d4RldGVE9S?=
 =?utf-8?B?NkcxamwwRzI1N1NOMVJHeis3RHhzSE9ZalpnZFNZTm95MUFLZWtEdUtTSlJW?=
 =?utf-8?B?ekNERG9pQmc3eWFKZ2tvR21lb2xYQ2QzOUNFTHFISnM2K3hINVdHZkpTOWY0?=
 =?utf-8?B?eFBpOXg2UEpEVnR3YmkvVGVNOUgvaTJtbTR4MDFTUlpTeFpXYmhIeWtvSWhu?=
 =?utf-8?Q?blfpWOl+uNPGGw6hnQE962A=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d50caa-bd40-4ca8-97d9-08de3bdee261
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 13:36:00.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: usIeG3PGTnMxg+PClA29T52GrHXV0zQcmZmGpIqQUvT4aCNoFfr9EyCEFpjashK4CikuW/2rQRlsDuf5QZzfZtATaD2LFogK1iTjxPQKDnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9526

On 2025-12-15 07:40, Lorenzo Stoakes wrote:
> On Fri, Dec 12, 2025 at 04:08:08AM -0500, Tal Zussman wrote:
>> This has been unused since it was added 11 years ago in commit
>> d17d8f9dedb9 ("x86/mm: Add tracepoints for TLB flushes").
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Reviewed-by: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> 
> Hmm, guess just a way of counting the number of reasons, but if nobody's using
> it that's silly. So:

If TRACE_DEFINE_ENUM was implemented differently [1,2], then we could use
NR_TLB_FLUSH_REASONS in a static assert to validate that the number of
exported enum labels matches the enum tlb_flush_reason.

This would catch this kind of discrepancy at compile-time.

Thanks,

Mathieu

[1] https://github.com/lttng/lttng-modules/blob/master/include/instrumentation/events/sched.h#L132
[2] https://github.com/lttng/lttng-modules/blob/master/include/lttng/tracepoint-event-impl.h#L176

> 
-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

