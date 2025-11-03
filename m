Return-Path: <linux-arch+bounces-14488-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3FC2D55D
	for <lists+linux-arch@lfdr.de>; Mon, 03 Nov 2025 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E41204ED3AF
	for <lists+linux-arch@lfdr.de>; Mon,  3 Nov 2025 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DFF31D747;
	Mon,  3 Nov 2025 17:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OTF6XLdq"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021123.outbound.protection.outlook.com [40.107.192.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844931D39C;
	Mon,  3 Nov 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189243; cv=fail; b=CqaSi3CVPELcgI6C0qiqahIfdZpIY8RvOfmD5h18cx6hes7ubmHQzbhKgA9eAeUCM5cy6o79EMb+PYKZEc35p1wr3c+8ywxCj9GdzmeoiNkwrJIx5KTZ5PzK6NMyhi8UecOlzxLN+gFNs71z5HBdeHB1Ara87gtF9EDCj+W9bUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189243; c=relaxed/simple;
	bh=UGMp01JneSD+lsX3KzKQBnqRrlBe9EwrqABF84QTMkw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E8FvnPHlplSu+54EKxLBa4XPrdz78Bh6OqSRwe43SJDhCSaqDRhDcX9l+avdyRrwtr4vGng/xlrnrzPIMOaEav3PzdxNo4/M/js5njLlw6nvU/dMNFAGZ8VyER3iu2iYIbx2ThBZXYM4CMVRm1QN4WU7GnF8IFYzYvrzPvR6TGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OTF6XLdq; arc=fail smtp.client-ip=40.107.192.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZBPQSlHPszv7sEMXnF/3SHHyOZnlcknFMJqWxrkbMZOtaJ5qLoE4InqO/X27oaUYvV+lkCZ9krelXI0bXXYpPqIxgO0rEQO3aKU+8HqoreyUTf1EQzwYCLI7EHS6bizbiB5G3hqz7cknkRHyGGnXXlumiY9t1Km1UGGTITRnf2+lZsBxRl0btaD4iC7X2MG2nMLmpZ04qSDG2yKhAB+Yp/6eh7sSlwq6cE/Q0rDaGepP9ODY5eKPoVMseK1ULUsZ3B4GsMYnYGAu0LhsIbOiqkOuvpj6CWIiRti5dxrixLUs3hRu1gPsffZoZu25rmBMQNqBB+wOhHjPiP+SQ8zEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEvd2maPXdL/EGAijhbZPMjo1HyE51uggfUqze/Mo2w=;
 b=ttPFZNAVsahO4iSxM4Sa1Lg+nMCKsEEx6ruLic/4mWru2xoFivANBxug/mPjIZ5AV280VM/pHP+diYnoalGqpMZdjw1K8/RbL+WmRjcVaWqrqggfy6O7rGyaFn+KAOZ9Sh3N3FPjVEhoGC+s/1kH1Ct/J88v8bJIkwXdVxppsmVJHjSMHyATwE/nTrhAmba5f07gTT8KazZZ3k3dTGIKS8QR/g1mvACKjFEsIxY53nhak5q6IJ1VCz78lhwieX07BGg/CNNv93CgPbJ6Szq8zuyNEVxTUHga7NMI9GfydaK9yTMAXxqq483LciX9ci+G/Fp2O56n1QkIWxeXbGtUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEvd2maPXdL/EGAijhbZPMjo1HyE51uggfUqze/Mo2w=;
 b=OTF6XLdqTQckeloIKojViFduVxvwAdphJNZADsdiZ7Heir+phP8G18WqWpjtnUNjy+jkgrqJ16fF9Glc4ZM4L+Cv7nCyy2DC+9oY6TeBqxabAVBsT0vZfGKLAZXMzf2Bev/3rHOJdayNa3G2bPYY8t5tpyENKAMFCmSjiAC30i5w+A+mHHSojCMS5fin99B888Xi5F3i5KvJSQR4XLj7fGIabwN4fvJvG2mhqvaCnlOoM6Ish+1MgzMo+mwe7P9Pj9aqfZh2ilHKXvrpcl/eAcMsfikpgKaX9hyJ26uz8KujIKVxweDnPFQMFZ59OYNO/jCclHXS0pI306koZLvgTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT4PR01MB10689.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:105::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 17:00:32 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%2]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 17:00:31 +0000
Message-ID: <8181a3e3-f49f-4278-9b15-67211d6151e0@efficios.com>
Date: Mon, 3 Nov 2025 12:00:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
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
 Florian Weimer <fweimer@redhat.com>, "carlos@redhat.com"
 <carlos@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
 Marco Elver <elver@google.com>, Peter Oskolkov <posk@posk.io>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.542731428@linutronix.de>
 <7e44ca0b-e898-4b7f-aaaa-30d8ac52c643@efficios.com> <87bjlmss8j.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87bjlmss8j.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT4PR01MB10689:EE_
X-MS-Office365-Filtering-Correlation-Id: 6589a848-3891-40e1-4744-08de1afa7f6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGdGNE1pM0pvTjVVeUpYcFh3Zk5ZYVVxc1dRREx5UW9MU3B0QlpsT3FsY3BW?=
 =?utf-8?B?ZmxVNWZKY0JZZng5QTZUak52V1p2RkFrdEE5aDFWYmVzRG1BbVg1WjJwaHVn?=
 =?utf-8?B?MXdvQ1RjZ2RWTG8vTkFUTFpQNlY4OTdLOEVOVFIwMXlmOHF1aDEvclNHR0F1?=
 =?utf-8?B?Y3JnVytTZWxIRFovWnJvR0pEYnh5d05VWTU0QzF2cXptMHd2M2JybXBEdkxE?=
 =?utf-8?B?TjFLVm44UUZvcy9IcmE3dHVubDhXSHhpQmZaaW4xMXdleUpjV3Nwa2hlZ2ky?=
 =?utf-8?B?WUVobTJNVW5oZWcrbURlRXlDMnAvdlV6dXhxRU9MeG1BWmFJT2tlM3EzbXZw?=
 =?utf-8?B?TXh3WTVSMUpTNWtwNmIwWTFNOUpEM1EzOUpQbTdVTHJxL3JQYkN5MGFSdmZ2?=
 =?utf-8?B?MThOQjVXVnJpa0ZaWXNxeVA0VVFuNGdOV0VwSzJWVXV3WUZRd1RWU0EwZWNp?=
 =?utf-8?B?WXJHNHh6MGt6NXdzUzJNUTVLK01QMW10M2RYWjRsSlZZeVFxakZWYnN4cXQw?=
 =?utf-8?B?aXo5VllBbXZuWWl5RTYyVTJvK2FjcGxtbi94YmxFa0hvR2N4ZTRKVE9Fc09K?=
 =?utf-8?B?MXNmN1dpc21TQzRkeDI1alNFaDVqSVI0OThuRE9rWktKOUZzV2VCOUw4UFN5?=
 =?utf-8?B?RHRCSmlWVUpLcFg3VlNsbmNQblExNXBLazIyZDNJUFRHL3k0MTEzeTkyYS91?=
 =?utf-8?B?bmhiUndGbU1MWDlMT3hOR0xHOEQvdmd2b3F6cEowc0VENWJZMWFuUTRYbmxw?=
 =?utf-8?B?M0lkSVh2cmVJaHo0Nm91UzhuUDRPdzZSc1EvZUJnclZIeVh5TkFBVE1QY015?=
 =?utf-8?B?SVRJNk1MQTluUEQyMkhqa056TjdhMXNwck1YcUNHa0FyR0hVV2pQSkRzU0lr?=
 =?utf-8?B?cEQzbEtJUXpJeGFIV2EvQXZ3TWdYWkpFR2lCUDQrRXEwcHArL3BSNW5hNHJB?=
 =?utf-8?B?NFNRYy9jaDVOUVVnWnEwYW9YMUc3YTMzQlR1eWdtVThTUEtsaVJoVDlnaW93?=
 =?utf-8?B?b2cxOXJaVTRIckk0d3Rzc3lPbU5VTmlIZ0c5Y3hEUzFubjhLT3FkUWhyaHZs?=
 =?utf-8?B?aWwrY0xXS1hQWTI4UXM1ME5RcUQvb0UrbFFEMml5a3JrZHFIV2dZeXJybFFS?=
 =?utf-8?B?M0tGQk8yYzlyWTYvbkdEQTEzUEtEQ2NMd1RsbFl3aXZ5Y1I1eUxWdU84dGdi?=
 =?utf-8?B?MlFwRzlWYlZkOVMxZzRyUU9hdTlOWnFxK0lGemVza1RZSmRXN2VWc2RDc3dl?=
 =?utf-8?B?NUxIWCswdTdjUEVQRi9taldUV1hvN1ZiV0ZTaTFnUms2MzhHTmczRXNuZEFl?=
 =?utf-8?B?YkpHUjlFdExTb1BuaWVWNFFISzVVSEpFNGpqQ3N5L09qN2cydnRhNFl4aHo1?=
 =?utf-8?B?Sjh3QUxFVHI3SHBPcVBOV1NFRlRlU1JhTUNVK1BRd2RDaUpJeGthTXM3WDEx?=
 =?utf-8?B?cEpCN3hRWGVuaWhUT2lWeW42aHF5VHlxMWh4ZWhOSVJNRTZFZ1V5Ui9ORi8z?=
 =?utf-8?B?bUYzaGt2RXZzYmRTV2t1QTkyUGxkMUd6SU5PTWhxNk1ld3Qyc0NqZXQzMzJM?=
 =?utf-8?B?d0FpdlhQWDRMdGI1VlFMZUxZYUIvMEV0OGc4czNUQjZjcURCeWVDL1ZFWlV2?=
 =?utf-8?B?ZFBndVR4ekVaL1M5TkI5QTZRT3c5Mmthanl2b3NndGRJMVdGS3ppcEgxQkgr?=
 =?utf-8?B?TnljUmY2cnNRSVRYNkZCR0Nsb2FVL2IreEZ1TXNDTnlJdUdDNy82Wnh6eU9n?=
 =?utf-8?B?WlFENkM1VGhoQ3hoQ0NrYlhNYzN2OHhvencvM08rVEZhR1pwckg3cjMvOVZO?=
 =?utf-8?B?WHE5eGR2VFJLeGZjd0VHRkJKdXZOUVRjZ0hBRVM3L2pzc1BMN2lDOW1QSStC?=
 =?utf-8?B?UDNoNXNzR3l6cEgzVTNyZFlQODBVdXZNNGZmSHpkdlAxZVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm5ZZ1RRbHRCTWRBNm9rOFJjVXdiTXJ6TDl1WjZSMnlLaWZ1NW5KYk5kYzVv?=
 =?utf-8?B?eHpWODJiaUhGZ0t0ZitEZ2RVSCswejBlMEYzaXBuVHozcUN1cW91bVowSTYx?=
 =?utf-8?B?R290bXNoalliWWc5R1QwMHRlbFF0MnBodC9DWGtUWnVjQWRhOEwwQjY0cm13?=
 =?utf-8?B?VFlxZWl0Qk11REJnQVRrRmczVGJ5aGZWdVcvM2VNOElGZ21xZUV2RE5BdllW?=
 =?utf-8?B?dzhDeCtPOGpYS2gzZjQ2emx6SVQwOEpxOG4rTFY0NFRsSzR5WkV1VnVXMGE0?=
 =?utf-8?B?L0dld1FPK0xVUXNVREVkaENNSkVOMUV6ajVjMXFTQTU0Qm1BN0pjSi8vWHIx?=
 =?utf-8?B?ZEY1MlpVMFduU2tNa1RIcTZ0ZHRxamlhWUJjN2o1WTlLTmlSUGxoWWFLajVU?=
 =?utf-8?B?b0xxYkZJK0ZJUmRaSktibkdyWXZoZkw2T28xOVMwSThoZ2pwQ2E5dTMyblpw?=
 =?utf-8?B?UXBMM25OSEVrRjdVVVp3RWlRZjVScStoUzB1eVdUd2Q5dUxwcmdaQ1J6RmNa?=
 =?utf-8?B?aXlzUWErSSttVXYyT1BCcHdtdXpiQ0ltamphdDZXbjFLQW9OL2IwSVZBbVFz?=
 =?utf-8?B?bkF6aVdsTXNpMFFsWGx2UVRHamkzNG1TdHpPQmtnMjV4TnFaWXM4QW80OHlV?=
 =?utf-8?B?ZVl5azg4Y1NtZ3diQ0tQSW5pZVB5OGFraCtqWUZyd1hmeEY2Q0VYOTdIZkds?=
 =?utf-8?B?ZVZuaEZDdzBtL1JSbEtUOVRrdHAwNm9pMXRRNEJnRmtWcmZLZmJmZTM1akxu?=
 =?utf-8?B?elNtR2VORTdCRHFseVd6eExyQlAvSkhzU2FpVnQxSzNGM0VHWjNtdWVMSXNT?=
 =?utf-8?B?WTc1WU9UZ2lzNjJKV1lpWE9FZi9lenJmb0RzMFA3N3N5OSsvVlRWZ3pUTHBN?=
 =?utf-8?B?bGhPdjNHeEQ2bnFVWWUzVGsxa1ZyN00xb0N2YVN3RU1CQmtyVURBV3V4L0Z3?=
 =?utf-8?B?eFhFbDNibGxOUzAzMm5sVU5vYU9XSEkxcnk2QTJHOXVtRGxPeUVQTEV1eUNP?=
 =?utf-8?B?dDFFNVZXK0sxbXVtL2QvYVdQZjlIVk1GQ1ZCUGtXNC9OVjFzcXpIK1NwV1Js?=
 =?utf-8?B?ZjVzVm43ODFtNE1yKzJFTHhPTUV1bjNyVTVPV0VoeHBheXJmRHY0aDVtVjlS?=
 =?utf-8?B?OUJxcXpRSDAvZWp0ZFVMVk53ZUxmOFpBM3Q4ekZVbDdJUFE2cWZtdnpEWUxi?=
 =?utf-8?B?TGZjZFJtNXdqa1dkNXhXVDRUM2FmWm9BSlNOUDc4RXBtQ280RGZJQWhuTC9s?=
 =?utf-8?B?bkNLNzNILzRSdmdyRTJFam5Sc3JMWkN6YjJKdWNNU3JORUJQZEtHT2xsQ3pT?=
 =?utf-8?B?N0tUbFhUZlVHZnd5Ym5HTkZ3V05RUFEzZ3pvb0xlZnd0WU0yWGl2aVJJT0t1?=
 =?utf-8?B?T29Rb25uTDVicnBkRmdaM3hXSlp6SElKTXZMQzNVTTVnQ0FEeVUycURENWRy?=
 =?utf-8?B?Zm5GT2pDd3BuSXNrOWJRcVdqWWpZdHdQNE1DVUJzMm1Ib3o0VjFXWFdsVU1L?=
 =?utf-8?B?VnU4ZUVSSlZLTTE3RHh4bGdjNDUrNUdBZXhadXMwdWlPZGJXQVEwR25FQ2ti?=
 =?utf-8?B?ZmVNRFVlamtlSXkrNE1XMzNsMTB1eU02RlVWSWRlU2pNczlieWIvRjFIR2tj?=
 =?utf-8?B?ZGhlSEFRUmhaZ0hsUmZrYUo3OUhmdUpGRUFZbVZLV1JvcTRDTWlxTnMybXVT?=
 =?utf-8?B?QlJNVGxtN0FtclF6SnNReTRqOGF1RVI2eko3d3FvTFJIRVlWZmgxM25XZ1dM?=
 =?utf-8?B?YUJRUy9EK1lqeFVYakVzVUc5VUQvcmtDeVJodWFaRlpQODdQbW5sTEVtTjFV?=
 =?utf-8?B?UmRLOWxKUWVXazJWTnpoK2xlR3FhazY2R0dFMk0rcnUwMjhmR3NLZ1drQmRP?=
 =?utf-8?B?V3dLVjlrV0ZibG1UenB2UWp3TXFCcC9OQ3AxWUZQdVpQaGowVm91QzhLOTNI?=
 =?utf-8?B?Si9FVnNVWmZueGNWTHhOaGw4MkRLZlh4Mk9jbDYzUGk4WG5MaWZLUmwvTXRH?=
 =?utf-8?B?dU5PNlh1WTd2cDR0RXB3YmtGUXM5YmpQaVdaNkJwYWtYZG02TGhxOFRMTWtj?=
 =?utf-8?B?emFsckNyUlJydUdEellWbXY2S0FyT1oxZTlHcW1YN3A2SFU2TE5FdlZnWGlV?=
 =?utf-8?B?TG5EU2FvMmN2dmdrbUpXdXl6K3J4OXVXanhFOHhYS0dNR0ZCdDNRRXVGamlM?=
 =?utf-8?Q?UIr4vzWFNn0FmObNuaVLedc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6589a848-3891-40e1-4744-08de1afa7f6b
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 17:00:31.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja48I5wP9TPaGB1Fx6UfnU3lDmXn1JNAkXC1YbSpgwld/wZkD9pO34Rk25SDXzQMDXwmy6Mk6CeimLBlAxPwYjSGorZXMFZbC52Q9yGBaO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB10689

On 2025-10-31 16:58, Thomas Gleixner wrote:
> On Fri, Oct 31 2025 at 15:31, Mathieu Desnoyers wrote:
>> On 2025-10-29 09:22, Thomas Gleixner wrote:
>> [...]
>>> +
>>> +The thread has to enable the functionality via prctl(2)::
>>> +
>>> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
>>> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
>>
>> Enabling specifically for each thread requires hooking into thread
>> creation, and is not a good fit for enabling this from executable or
>> library constructor function.
> 
> Where is the problem? It's not rocket science to handle that in user
> space.

Overhead at thread creation is a metric that is closely followed
by glibc developers. If we want a fine-grained per-thread control over
the slice extension mechanism, it would be good if we can think of a way
to allow userspace to enable it through either clone3 or rseq so
we don't add another round-trip to the kernel at thread creation.
This could be done either as an addition to this prctl, or as a
replacement if we don't want to add two ways to do the same thing.

AFAIU executable startup is not in the same ballpark performance
wise as thread creation, so adding the overhead of an additional
system call there is less frowned upon. This is why I am asking
whether per-thread granularity is needed.

> 
>> What is the use-case for enabling it only for a few threads within
>> a process rather than for the entire process ?
> 
> My general approach to all of this is to reduce overhead by default and
> to provide the ability of fine grained control.

That is a sound approach, I agree.

> 
> Using time slice extensions requires special care and a use case which
> justifies the extra work to be done. So those people really can be asked
> to do the extra work of enabling it, no?

I don't mind that it needs to be enabled explicitly at all. What
am I asking here is what is the best way to express this enablement
ABI.

Here I'm just trying to put myself into the shoes of userspace
library developers to see whether the proposed ABI is a good fit, or
if due to resource conflicts with other pieces of the ecosystem
or because of overhead reasons it will be unusable by the core userspace
libraries like libc and limited to be used by niche users.

> 
> I really don't get your attitude of enabling everything by default and
> thereby inflicting the maximum amount of overhead on everything.
> 
> I've just wasted weeks to cure the fallout of that approach and it's
> still unsatisfying because the whole CID management crud and related
> overhead is there unconditionally with exactly zero users on any
> distro. The special use cases of the uncompilable gurgle tcmalloc and
> the esoteric librseq are not a justification at all to inflict that on
> everyone.
> 
> Sadly nobody noticed when this got merged and now with RSEQ being widely
> used by glibc it's even harder to turn the clock back. I'm still tempted
> to break this half thought out ABI and make CID opt-in and default to
> CID = CPUID if not activated.

That's a good idea. Making mm_cid use cpu_id by default would not break
anything in terms of hard limits. Sure it's not close to 0 anymore, but
no application should misbehave because of this.

Then there is the question of how it should be enabled. For mm_cid,
it really only makes sense per-process.

One possibility here would be to introduce an "rseq features" enablement
prctl that affects the entire process. It would have to be done while
the process is single threaded. This could gate both mm_cid and time
slice extension.

> 
> Seriously the kernel is there to manage resources and provide resource
> control, but it's not there to accomodate the laziness of user space
> programmers and to proliferate the 'I envision this to be widely used'
> wishful thinking mindset.

Gating the mm_cid with a default to cpu_id is fine with me.

> 
> That said I'm not completely against making this per process, but then
> it has to be enabled on the main thread _before_ it spawns threads and
> rejected otherwise.

Agreed. And it would be nice if we can achieve rseq feature enablement
in a way that is relatively common for all rseq features (e.g. through
a single prctl option, applying per-process, requiring single-threaded
state).

> 
> That said I just went down the obvious road of making it opt-in and
> therefore low overhead and flexible by default. That is correct, simple
> and straight forward. No?

As I pointed out above, I'm simply trying to find the way to express
this feature enablement in a way that's the best fit for the userspace
ecosystem as well, without that being too much trouble on the kernel
side.

I note your wish to gate the mm_cid with a similar enablement ABI, and
I'm OK with this unless an existing mm_cid user considers this a
significant ABI break. As maintainer of librseq I'm OK with this,
we should ask the tcmalloc maintainers.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

