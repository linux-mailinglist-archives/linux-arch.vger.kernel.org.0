Return-Path: <linux-arch+bounces-15693-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C6BD001CE
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 22:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B246C30194CA
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 21:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101524677B;
	Wed,  7 Jan 2026 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oxDYzMPO"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022118.outbound.protection.outlook.com [40.107.193.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF263A0B36;
	Wed,  7 Jan 2026 21:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820285; cv=fail; b=CqGUOpHElKMevjbC91T5xKrR7uEqDK9OcJ6oT642aer1BZTIlojCKsBBWn0NCjgqOK+75GH3hWRFRCHt4Q6/WP5YwkNuyfNj4hf+zp9k53fU0f91keEVhVo0B8VkXt3b5nfFQpMNt4CMaWL0Ru11bAnn3iQ0QwSvAUvKhXSnWV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820285; c=relaxed/simple;
	bh=rIV4tj0nHtYolGlJpvqt9IdrJVmnhHVbRX6O01CLdV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WBAiuaf0rQ3P6CpSm3drpF7co/APMFQRn1l9+DOXtWmo9JsvOa8K+zWn4xx/Fb3F2xNKIWGCUb9KjxYpfhoeROpX0DXs5yFfa0FWM2cjwWVOmA58xkUT7krZ82dfR2fHcPgyRXv16Azinncb4a14G6GNkfi6MJliOpHXhujJmh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oxDYzMPO; arc=fail smtp.client-ip=40.107.193.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5UgJY6FmsIEAsd7vNWCdRIADZqFvX6DOHhExPy2keF3OTcu8sj4MuA2lYtArrb45w7Q9E7EG+JPPUJuumHhUpiEd2K+t9s3B4sPsheZbXpxk6utyikv5f6T1530qCYWcxfonh+kWFbTEnzV+15g5PNy7LLMMEZ+8exZBcE6VJHZ4sNTGRmohbocguGo/jB6hxLThCmha7zfV8Y8zOsSgDZJxLK0EXIGUGFs//ReUh+ZBM4NtlFqEEUbF2vMDUQmw8aUG0FLn+n66gWRZ70JAfPhYInOH5r6j9mb/BDzAoTGBmgpC1LiQ6SwI6XsohQxj5N0pHMmwwzYfIxugFae5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRPxGkcNRUvBFxgEsEsEIK6dbm5Gs+nO48c+waWPQk4=;
 b=Sagm2ArRtqbMLXLerq98h/6/iqcd8eEM4RDtsT0JpakPb5MPhzcOLVPLJv4ajvml8GPkRD3YsAkWUVyKR3c52n/F8hCdAYgl/Ddu67V8TO1o4gMqVdxJyrl/xVMguKSVsfImPZRGWy6oZbWkLGLEBCd2QDZyBXXKQqt6BfvPHbcL1huMYPwqj3wJG1pnuasf3nYEYas7KwS+jEkQHr6/DBlhyrn4F173ELftJe551kQBKBwRGsMBjMYTgfjafBzXy0Vp0o5gE9en3D83r2WwmwJwXg6lezbds0x0spks3R4KW7oxh6TfJM8cgwJrDsIq8NBK8ychG0DAXsHRhe2Q7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRPxGkcNRUvBFxgEsEsEIK6dbm5Gs+nO48c+waWPQk4=;
 b=oxDYzMPO5B0OjFNevJc5AYf6Ijz0M/JmC1xSlTlP9vfhLqvkmZMN2/28G9A5E22Ww0fB7IFye9zx+zZMLtuq7FHzxUcGSEaPJx6jRjlPGscp7t51/aB+HXQqNZC4r05iPyrR9+sAcHQjXniRVnsC5q1RerzD/jFUqJ4DuUxjmvd8eqIPkS3C3/n46f/A29JsDWzoHuyv0H2m1I6scLVprRXxR39QXyLk4lLoUOuNRHHZs+iZEpqizpGzeALpvX+DGpkeX1UEj9/mYsAI+M4AplRiSSitf9AnaDzXlzFxmbCjFrkQsZ4QYWzG4Qd74gbVbx7tokhLT/YtIChTZxZcgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YT3PR01MB5891.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 21:11:19 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 21:11:19 +0000
Message-ID: <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
Date: Wed, 7 Jan 2026 16:11:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
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
 Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, "carlos@redhat.com"
 <carlos@redhat.com>, Michael Jeanson <mjeanson@efficios.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com> <87jyyjbclh.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87jyyjbclh.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::12) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YT3PR01MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 80776022-33e3-4487-fb9e-08de4e314d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUtxa0dhcnJ6QzhDSUNzMWd2OFVIQzVkaS82NEZiS0V5UWYwRjN0TmFrMnhy?=
 =?utf-8?B?eC8xS25jYXpYczNkcGFBdzhLeEwzSk1JbzJXTUJ4VW1kSWFEU0JiTjZWR25H?=
 =?utf-8?B?akNxbXhJQVkyK056WFlXNURCR0ozOGI1dWJzWHcyYi9iRDFCNTZKWVhaOGY3?=
 =?utf-8?B?UDBmQW5RVE90WmhKK09BeU95djlSWHdnVkE5cWtoZDI4R241d1JobytaMjIy?=
 =?utf-8?B?SndQWGFvOFBabTU0am05aldGb1ZDZ3pwcHRRWWVURW9iTnVkbGxZYkM0bVVx?=
 =?utf-8?B?L01KL0syYkprek11eEN2Vm03Q3EwRkkybUtTSnFjckROaEJManJzblhUeVF6?=
 =?utf-8?B?MVNmcmx3eU5YbXZHZ0ErVVRKRThZZXVKejlaalVoQW9EbDB6KzBIMXlaaVB1?=
 =?utf-8?B?ZzFvMmM2YnhYd2pza0pNSjBkdFlpTGZIa2NZSjByNWZoNEIwSjVhY2FrdjVT?=
 =?utf-8?B?S0dMVnNRTkRDN2NLUFJrT3ZrR1hNcFlvVG14OWgvaEErdUQ1MWlua0hqTVpw?=
 =?utf-8?B?aHNsdWNkNzZhSXR6SDdWZjZpOVYrZjNUcGk1NzZRQmVUeUMxZEVtR1FQOHpM?=
 =?utf-8?B?cXg0SVlVODUrNmtCRUZTUFJjcW8vSzU4WGt5c0lpNFhXWXFyRmkyeE1DRDB4?=
 =?utf-8?B?blcvUSs3N3AxZ1VOZXcyTWpJYjJjaW5NZGYrWmFmZlE0Z0JEQW9KRVVwdzVq?=
 =?utf-8?B?U1d4aWVSSGMvRldqTDhDMlRRVGtzaFdiRlVPS1lPS3c1a3BWRzY5VjE5YXBX?=
 =?utf-8?B?SmhocERsNHZQNzAyckpyWStFZXpwM011Z2pRRUQvUWoyOVc0bnliZkloR1NW?=
 =?utf-8?B?MEl4WFdTem93T09xUUN2eWJwQytteHFOTHJDTXIxcDE2UnpmQzBZS1JCdCsw?=
 =?utf-8?B?aU9TYkN2MEIrcUI2OEVkclhLYXl5Nk9sTGlFQWZ3M2Z4cyt1ZEdmRWhnL3BF?=
 =?utf-8?B?ZjZLanVWcWNSeGZhNUkvWXNTR05USGU4ZUplSDlCcGlxdGdkZ0xsbUNHdWVY?=
 =?utf-8?B?V2RMTlpkTGZWbm1CbFdEdWdmZVJRdnFvVkoySFpRUzZROGZmTXhGLzR1NG5X?=
 =?utf-8?B?N0FDOE4ra21vaS9lRWhwWFpPZ09uVC9GMUhGUmZORXlvOFNRLzJSdDVReGhX?=
 =?utf-8?B?YURhSjlETnA4UEdSNnREVlJJaWMxSnFLRGt5Sk04STBmeHpxaTZjSzM0N0NW?=
 =?utf-8?B?SDRTb1JwenR3UVhUL1BGd2tGRTlCSkN6WC9XVTYrSkZuMmRPdVdDNnVyckpJ?=
 =?utf-8?B?a1Uwd01DNTJvVHYwSy85akRSdm5rUmdOdml1UjQ4WThybmxXb3ZoU21HV2JD?=
 =?utf-8?B?d05OZHlITFJyZWM0QWplZHJ1S2N6M2JnTWw1VEFNZzYyQ083Q0FiaWRGV1Vz?=
 =?utf-8?B?V2pDNmorV0JaS2FqVFFnbkdPLzhuVGpsRHd0N25sUzRnK1YzdEFaVWNHaElj?=
 =?utf-8?B?UXU3RGd3NTVKL2xzeEE0TkhQT0owNGZzNTEvcko4UmRPcE5KekM4N0dhbnVW?=
 =?utf-8?B?UHB2L0tyT2JIeHFMVTlraWxrZndSWGlKVnBFQnEwdUhmZGYzdHc0Z09RbjFw?=
 =?utf-8?B?VXUwbW9NejR6YmhJRkNQK1g2bXF2U3VDdDM4TktrSXhwS1ZsUzhrUk5YOG9Z?=
 =?utf-8?B?WHR3cWc0SmFSOEMzMnkzdUdFeWVNMHdYTGtYUGJ5djM5bW0wUFFkSVFBN2xW?=
 =?utf-8?B?enpqUHFFeEZEQTZDdFU3LzR5V2pwZ2RYa1hoWCtyMFZ6WG1DY09lOWk1TWxz?=
 =?utf-8?B?SWxsRzhOUzZBVjNOd04wNitWL29RQjJOQStYd1JXWnUzczhoZFVwMGVpWUdR?=
 =?utf-8?B?b1Y4cmZqaDBMZzM4ZzE1MjRneFpweTFHSGZ2N1N6cUkwaVJjb3l0eDN5WVpR?=
 =?utf-8?B?V1lES0dCeDNod25DYStxdmMyNUsyd3d5WXhRbCtGNEZuVVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3hlNFZGUWJ3V2E2UmtwZnlxWWIzWEtiazRTaGJsVU9OV3d5aVprVWhKZExl?=
 =?utf-8?B?MzJlU0ZVYUF3a2VQVFN1U2VzNWROVmxQQUdoajFzZTNWUHdoejBZc3JEM1Qw?=
 =?utf-8?B?dDcrWnpjL2llQ3I2RVVIa05WVmFjclMrdnAxN28yR3VtYUxFMUFIM0JmamFB?=
 =?utf-8?B?U0NBcVFTcjlTR0xsdFJKN1Q3SUZSZjBPdE9CeUpMSjVaMTFjMmNmSEVCRHMy?=
 =?utf-8?B?R2NYUnBoQjZ5MWo5bHF2WURaSFZ2QjFuODJNZG9FbGRzL1o0UXFlM0tXSXkr?=
 =?utf-8?B?aHQ2bnduNityQWJWK0UxNzYxelI5aUI0STNzQ1ZCM3JvdFg4ZWNqVnJOWW5S?=
 =?utf-8?B?Tk51cFFnK0xUOEtDNWROeUNmU3p2L3lBY0Q0c1V1SWU3L2ljVmR1bEpXWTQ5?=
 =?utf-8?B?SHlpenU3cnZnKzhTZnBxUTlyR0JjTGxISnY3blNiSG10aHhLY3JFUW8wMHEz?=
 =?utf-8?B?Y0ppSUtvOVphTjdud3IzeFdCYzltRjhmUzRrL25LZUUxUUZGNVVhQS9ybkh5?=
 =?utf-8?B?WFVNalZMeHpRWjJHcGZFTGp2VnlZU2xrQlZBZ3lqKzg5TWJLaXNmc3RWaXJK?=
 =?utf-8?B?NEJhUkJiYWFZcVduSlpNemhLME1KV1FoV28xRDFWUzZ1eEdYblRmL1I0aGlr?=
 =?utf-8?B?RHRkdFFJaHRacTd2czFrOG53ZGNvV1R3TkdkRkxpQjNvd1JIanpHWi9FSG56?=
 =?utf-8?B?QXlKTUhuemhjc2dlOUx3MnM0TGFMekEvN3JyRFUwWkdrdmRsa3hTZmJlOEhy?=
 =?utf-8?B?U0E0bVJHRXVaakM0aEsyKzRBS2xEOWhSbWRrSHFMYkdZSG44endIelBybTd1?=
 =?utf-8?B?bnhnUFM2VzhodmJ5dVFlb25rK2pzeFhCTEpudnZheXAxeC8ybGdYcGpkWUow?=
 =?utf-8?B?M0Ywcy9iRkxCajFFbitQa2hnemJkei9lZG1acWY3UlRKQlJMM0pkdXQ5RGdJ?=
 =?utf-8?B?M1lJUFp2OEVFWEFvV2tlc01weW1xTDljaC9ETFkrcnQ3VnRkVzE1QWY4MFkw?=
 =?utf-8?B?VFlFTFdqWThnZ1I1TWs4SnczRVhIZFhsa2pveVJ5ZytjZ2drOFp2SnFIUzVa?=
 =?utf-8?B?ZUNRa0ZETUczc0JKUS9XeHlEZXliczBITmRTRGE2ay82QnJzeEpMdTFKcVFN?=
 =?utf-8?B?aHduM3BTMGZtK2VGcHdsUm1RYmhCSTQ0YWpuYnFkNlU2NXN3dmFONEVEV0VO?=
 =?utf-8?B?dnk4cDE5LzdHbEphS0VTcSsyQXp4a2s3RldJOC9NVDBIcGt4UWZWM1VaY0hi?=
 =?utf-8?B?WWM0VVQ5SE9zMXYzYTRJakJtTDl3WFlkOTRQaFRPU0o5aHRjZG5IL2NMQmtO?=
 =?utf-8?B?bWdPdTBUKzlSNWVzVmx2K3R4d2NSZld5Mmh0M2ZmWGJ3MUFWQmM3U0tmOEpw?=
 =?utf-8?B?eUJUYVh1WktzMnlMakhxSmdDYVlRNDlkZUVqM0tFOHJQOU4vZ21oekJhS1kw?=
 =?utf-8?B?VW55TjZHS1pFclFwTXVzQTd0NGthR3pFQy9kbGE0OTllZkEra3Z5WTlMN0ww?=
 =?utf-8?B?YzNldmI0MGNkdm9KbWxCQmtyZFBrVCtmcDB3UmNLbHV6Wjl0TGhQN1dyQ2Yr?=
 =?utf-8?B?VzhFTUxYUU1kVjZqdDJDM05yT3c1ZEVrRUg2NXF2cm44WFdHcDhWdmZxNTFI?=
 =?utf-8?B?T1F4NVFidjBZOGFXUWNQczZpOEI1WW5jWklJeVFJOUN4VWVXQ05zRFljNGpE?=
 =?utf-8?B?ZnU3bUxOVWpRMDhoL3RHcHZ0eVhQR3B5NDgremJBQ0ZoNUFwRTFzR2ZMVVUz?=
 =?utf-8?B?a0RzcjU0ZmJ3dWN4TnZ5aTFVNXhVcUNJMllYdEdBL0VRakgzUHpqMno2MTcy?=
 =?utf-8?B?dXJvb3UybjNEc3lxaGc1L2M5NWJqbEt4dXZ5cFlUeE9VN1JIeVhTNkZoNlJR?=
 =?utf-8?B?dEN3bGdwaHhyODQvMDN4MGE4VW0zb05VNFNoUFJSb0srYVluVjMvMURESWRz?=
 =?utf-8?B?M3NpVEhUVEl3Q1VUQ2dTcWNweFJ5dFhnelpBVnJ1NTN0NjE0OStKU1hBZ0FQ?=
 =?utf-8?B?YU1DWERtenlhZ285M2VsNjdCZ3A0ZXZDTFZXdU1iMFBHelgzVUg5WTllVzk5?=
 =?utf-8?B?OFA4MU11dDNQS1AvQWRnT2tYT1Nnc2YrZHI5RDZSVmk5TWJ2clY0dkJEYk55?=
 =?utf-8?B?R0VaejVnbFc5THhqTHdjMlp2alBuS01ua3BhYjVzZzYrZG1ocjByNW5Ob2hn?=
 =?utf-8?B?R2NyOHVWazNNVERtM0FXMkY2WnE2SytnMHFkbDhrTVhVMTA0NW0rcis2dUoy?=
 =?utf-8?B?VWl1b1JLUXpFNVFRSG4wQVp0LzZvcDBjVjRoUGc5V0dsUXJCdUhna1h3K2pu?=
 =?utf-8?B?TWlhek1neTRLeVdLSm44eUtSVVZxZHltcXdvSlRkUmlKaFFRRlZuTGFpaktF?=
 =?utf-8?Q?+BfhPag0o5RpJy2I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80776022-33e3-4487-fb9e-08de4e314d4b
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 21:11:19.2164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziFF2s+WIRO3VJl8d/qXXfTeGDKEVcxAAgTGkMkMtIUKdLZwAk+Vm5wk6lOfY/2Cg70JLkU87eJt0Sz98457Zlre6J8pbBt9DusE3ZoIHjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5891

On 2025-12-18 18:21, Thomas Gleixner wrote:
> On Tue, Dec 16 2025 at 09:36, Mathieu Desnoyers wrote:
>> On 2025-12-15 13:24, Thomas Gleixner wrote:
>> [...]
>>> +The thread has to enable the functionality via prctl(2)::
>>> +
>>> +    prctl(PR_RSEQ_SLICE_EXTENSION, PR_RSEQ_SLICE_EXTENSION_SET,
>>> +          PR_RSEQ_SLICE_EXT_ENABLE, 0, 0);
>>
>> Although it is not documented, it appears that a thread can
>> also use this prctl to disable slice extension.
> 
> Obviously. Controls are supposed to be symmetrical.

I agree that the vast majority of prctl are symmetrical, but
there are exceptions, e.g. PR_SET_NO_NEW_PRIVS, PR_SET_SECCOMP.

>> How is it meant to compose once we have libc trying to use slice
>> extension internally and the application also using it or wishing to
>> disable it, unaware that libc is also trying to use it ?
> 
> Tons of prctls have the same "issue". What's so special about this?

What is special about this is the fact that we want to allow userspace
to specialize its fast-path code at runtime based on availability of an
rseq feature.

If we allow slice extension to be disabled by the program or any
library within the process, this means that either the program or any
other library cannot assume slice extension availability to stay
invariant after it has been setup. This therefore requires adding
additional feature availability tests on the fast-path. And if this
state is per-thread, this means testing flags within the rseq area
on every use. Even if this is a simple load from an address at
thread pointer + offset, test, and branch, the overhead adds up quickly
for fast-paths.

Moreover, if the prctl enables the feature independently for each
thread (rather than for the whole process), this requires a conditional
state check on every use because it can be enabled or disabled
depending on the thread. This prevents code specialization that would
select the appropriate code at process startup through either ifunc
resolver, code patching or other mean.

[...]

> The prctl allows you to query the state, so all parties can make
> informed decisions. It's not any different from other mechanisms, which
> require coordination between different parts.

I'm fine with having prctl enable the feature (for the whole process)
and query its state.

The part I'm concerned with is the prctl disabling the feature, as
we're losing the availability invariant after setup.

> 
>> This goes against the design goals of RSEQ features.
> 
> These goals are documented where?

We should clarify those design goals somewhere. So far those have
been enforced by me when vetting new features, but that approach
is not good in the long term.

Is Documentation/userspace-api/rseq.rst a good location for this ?

> 
> What I've seen so far at least from the implementation is that it aims
> to enable the maximum amount of features, aka. overhead, unconditionally
> even if nothing uses them, e.g. CID.

I don't mind having things disabled on process startup and then opt-in.
What I care about though is that the enabled state stays invariant across
the entire process after setting this up at program startup.

I agree with you in retrospect that this opt-in approach should have been
taken for CID.

> Your vision/goal of RSEQ being useful everywhere simply does not match
> the reality.

Again, I don't mind the opt-in approach, only that the state stays invariant
after program startup.

> As I pointed out in the previous submission, the benefits of time slice
> extensions are limited. In low contention scenarios they result in
> measurable regressions, so it's not the magic panacea which solves all
> locking/critical section problems at once.

I agree that whatever code we add to an uncontended spinlock fast path
will show up in microbenchmark measurements.

> 
> The idea that cobbling random libraries together in the hope that
> everything goes well has never worked. That's simply a wet dream and
> Java has proven that to the maximum extent decades ago. Nevertheless all
> other programming models went down the same yawning abyss and everyone
> expects that the kernel is magically solving their problems by adding
> more abusable [mis]features.
> 
> Systems have to be designed carefully as a whole if you want to achieve
> the maximum performance. That's not any different from other targets
> like real-time. A real-time enabled kernel does not magically create a
> real-time system.
[...]

I think we are talking about two different program/libraries composition
use-cases here.

AFAIU, the aspect you are focused on is whether we should allow users of
slice extension to nest. I agree with you that we should document this
as unsupported, since the goal of slice extension is really for short
spinlock critical sections, and nesting of those goes against that
basic definition.

The concern I am raising here is different. It's about just _using_
slice extension from various entities (program, libraries) within a
process, without any nesting of slice extension requests.

If libc successfully enables slice extension in its startup, the
kernel should guarantee that it stays invariant for the lifetime
of the program so libc can optimize its code accordingly, or use
a fallback, without requiring additional per-thread variable checks
in its fast paths.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

