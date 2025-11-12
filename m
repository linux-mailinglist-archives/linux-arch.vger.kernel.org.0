Return-Path: <linux-arch+bounces-14663-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96877C50B7F
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 07:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 785CE4E25B8
	for <lists+linux-arch@lfdr.de>; Wed, 12 Nov 2025 06:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ACC26A1B6;
	Wed, 12 Nov 2025 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qiYvdZNs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gioSF7U8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F3A930;
	Wed, 12 Nov 2025 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929229; cv=fail; b=FVP/zywX8RS0137eYkqXTOj78gYw0zhbFdGyCfO3yd78UcWqUN5B77BRMU1jIwtlnyTwKLidIqINoZHdydyHvDOGy9mY6DceV6YaWe+uL5bluSZMibg8SMHL2BD0dFzm+6f6w7EC4G3sU7qd+QElOyDhQAVqBqT+lI1PI/+hV1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929229; c=relaxed/simple;
	bh=EcwbJynd7TL1y8vS8B+IjY7WJ1StVLlcw2vbAa+gXTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jafCJUC8uWQvlK9O9WdaHMbXyBA00JiJ59OpdljDx1EjvnwnyE4gfuhPFP/61Nb9EvkQmhx2EEEdsF68BlCYhJsDPysgtRp58Q7s814vUznxSG8THozHtfa/6akYyhfluf4NVIm1ACipZtsPFyZejpVav1HiWMMVQLHx5cMuE68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qiYvdZNs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gioSF7U8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC5cZ73008839;
	Wed, 12 Nov 2025 06:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EcwbJynd7TL1y8vS8B+IjY7WJ1StVLlcw2vbAa+gXTI=; b=
	qiYvdZNsRU91WXO6Xvop05J9OY/b6hSbwQvC17t+zVfO+wMhLm16nHSjJETT5l2i
	EYe/nHZ53CaKJCGnzL7R4lLjT3oYDOwV9UmVsIQb0msOI5T5lgkfp0aFeefRIpuM
	NbsXXD3m6bKSSZN3KeL+AWIq0vKjcnV5XMZNR8Oj2gRgubw4gEQEuQB4S2cCgKz6
	yBiaWuhWCBEb/TH3S6bO2mti9SJLjQTzU2IMF3mypOWw8YoyyxwlEv55uaMsyJ0a
	UXYPAMSR5XI3BpiyCy1RMjlar7TK70J73sbBziswsnOI+ePHyA31DYudRayTzT87
	CBByk3GY5r4wncJlzachkQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ach7d88yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 06:33:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC4DvdX007351;
	Wed, 12 Nov 2025 06:30:55 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vaau85q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 06:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+sc2DtCvEfCtZ1NgNH7ARfHmjOORIn9/ADc5skELnMdiUN5iNvYmx5qQBe5j1Ye8wX8RaLKgepbrFdg6fmYNpXt7q+GxYPnP6EIG3g58/TKLVWOS0XoVWAC/fYBSKQ/6FcUvNxy+CNJHOK339DMif3ojSy92yJIFZbLyY/Bo9uzaEQ8Z/sWppRkW8LFVGs1w3YQOEiBBLtca/iHeb8q7fxgtLKLMvFOgEJaud8ZNzdf61aOVF/R+OTpI9+gJUaJt9Y3D3iSB+JMGsRKftrq3smcMfGO0ktoaWUQwPL0skQ9SYgYvgxcb9PCclZ9Lr1DK4CI57r9QsUWyAdywx0Elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcwbJynd7TL1y8vS8B+IjY7WJ1StVLlcw2vbAa+gXTI=;
 b=FQT83q0MMann6VKdK5gdQMUhPd8l0a+a31MEOF6Bd7fH6L7SWZO27SPfIAC92849iNt/CDKdr30TgyzBwlK7f513hhh+emdmN1wsZPfvLJEIP8QD8v117yExuAJJ2aXVFwWOLZ5O5jC/b8R+T2lzoQt/DkXfDa7b/RAWZ25zevSf/3VbYLry9/PPxwqTTAAwJl6KZzUcixa3DdXLmXBkxxAwdjk2CcN2sItVlLuNsZwmuTiY8086afKWSPwnZj3jFPV5QyLbe0TNj1eCuNutQf0uXFgO7n7hCft0rgvwFhHmepgcfLID4IQsGqlcTI9nzzQjQKUoY02qTFmTUUxuJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcwbJynd7TL1y8vS8B+IjY7WJ1StVLlcw2vbAa+gXTI=;
 b=gioSF7U8nWl+qwhcCpDKqVkfGvsn74vnTRsksqUQNoxklSoWQVKBK5VZqpf39BXrJP+I1/OvrhIoDVpq9Jg7tyuEiNuzRgTjsG8fVmw1U4pR1tubtjyVRy7MXiLplFEHQx6JjUE506kDadbVu1FXcoFF+aHUEuhuraf34nPXEJE=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MW4PR10MB6370.namprd10.prod.outlook.com (2603:10b6:303:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 06:30:51 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%4]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:30:51 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        K Prateek
 Nayak <kprateek.nayak@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann
	<arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Topic: [patch V3 00/12] rseq: Implement time slice extension mechanism
Thread-Index: AQHcSNcOglHsgNF4y0S/q4HcTckeK7Tl8+kAgAYViQCAAbkyAIAA53EA
Date: Wed, 12 Nov 2025 06:30:50 +0000
Message-ID: <F940B2E6-2B76-4008-98B9-B29C27512A60@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <03687B00-0194-4707-ABCB-FB3CD5340F11@oracle.com>
 <2eee5e37-e541-4ac7-9479-cef3e62f234d@efficios.com>
 <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
In-Reply-To: <b28c9f26-7a79-473c-a390-f502b74b02ac@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MW4PR10MB6370:EE_
x-ms-office365-filtering-correlation-id: 2f3ad0fd-b8ed-453c-9a8b-08de21b50636
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWNDRWNhMUl6NDA4MGxBSnhkV3d4Wjg4NWtmK2hhcEpZb0F1VGIvUm1NZksx?=
 =?utf-8?B?V2VTTDdoTFp1YUFiRW1MQmNyUEVGczdzb2NpZkVVRW1ucCtCaXRMNjZ6N2RT?=
 =?utf-8?B?ZFE5VWtqYkpRSk4wOUdXaUxnQ3hHdmxvVVR3YWQ1VHRyNmRRcUVWTldrQWMx?=
 =?utf-8?B?RWFNZGFaSnpjOXVFbm1Gc0Zhbk5wRXhyOElmQ0p5SUg0aXQ1YWx0bW9xempR?=
 =?utf-8?B?SXFxSkxTTGpkQXVsTjR1RS9ZUGhSaXpQV0l0cTJhc0hkU2FSN2RyK0VUd3Ni?=
 =?utf-8?B?TjdhNTlCelErVmJCWkNZVk1EWnQ4cjVZRW1xOG13OXU3OVlWTVZzT205enZ0?=
 =?utf-8?B?Ymc5cGN5VzVac0hpSjQwc0dlVXRRUG9udmR1Y0FENTNsZ3VaSXRFTldGeFFo?=
 =?utf-8?B?cWpMRTBFRDFQVnpBZ3F5LzQ5dCtFYkJCbDlZb0F6Z3pGUGVIRHh1M0d3c1Rk?=
 =?utf-8?B?UXc5WllnMUFDQkplZ0pramtJUnlubVFmb0dtcDRIVENBa1hRRVAzb043Q0dD?=
 =?utf-8?B?dUc0dWhENnVWWi9tLzAzcjM1YTVFWStLbmhmZGtoUXcvOFkrNlgvODlYNjBU?=
 =?utf-8?B?ZWkvVkdmMGhNUURXQ1lSb3lzaitTWXZtTStBbmptRkl5b0x3RVdjU2tOeENl?=
 =?utf-8?B?UDQvbFc2b2s3L1QyNHk2NGZoejJybmljWWxOOUluZmlPV1lGYWk2aU1lWk05?=
 =?utf-8?B?dGc3WldOOUNwbU9mS0tQVk9tTytEemVLZXZUM051R3AzYnByTWxGSlF0dWdm?=
 =?utf-8?B?R2VHSDkxYjA5aG1zaXF0WXBCVGRJdnVLRklYYWMyNVZ1QUtvdS9lTlR5MHlM?=
 =?utf-8?B?aU1iTUZhNzNVcEY5SEhxSlZ4ZHRuWXlNdHVrbENTNHNMMC9jOWJ6RS9xM2hL?=
 =?utf-8?B?aDVqSVVkS0JKeHNmQVBhRnRnbWxvYU5DOXNVbEZQUmU1UUZoT3RpYjc3eUJ0?=
 =?utf-8?B?N1l0ZWR2aU5UWHRXK2YxQ1AvMEt6ZDQyNXQ3Y3BUY1JuOVNtUTA0ejdLanY3?=
 =?utf-8?B?NXJXVkkvVWpZaFFXTkxjS252OEVqVnZ1WDltMkw3SURyNGd3d1N3YmFDWXVp?=
 =?utf-8?B?Z1dLZ2wza0RISXRSY00yZnp5cGp5blh6ZEtsMEhRc0xNSWs4V1p6ZkQzMWlN?=
 =?utf-8?B?V0lzenZHRDBXcFlJWmZ6a3habDBScS9ac1ROd1V4K0txVDZ0cUNXWm56RWE2?=
 =?utf-8?B?VFV3MHQ4ZFFQTks2SVdYeStFaW9sVnlrT3V5K3N4OFpSUHZ5QjFWN3orcGgr?=
 =?utf-8?B?Ti8vMXdVa3AyMVY2RHFMQ0Y0cFJEU1c1ejVKOFhUcmxORWF3eWxVdXM0eVBX?=
 =?utf-8?B?L0Z5c0tBUUs1VllKT2drM3BzcG9adWdZYTFieW5wd0F0c25sb24zaWg4VEhK?=
 =?utf-8?B?a3dLaWs5RWliMnQ3WVdleFhzM1UvRGJkWTZSUzFodko1eVVmVHFsU3hodDJm?=
 =?utf-8?B?WmxlNS9rRjdWcEw0azZSR3NzVjhrN1lpbS9uMWNYVjBHS3JNUFFjYTM1Nlkx?=
 =?utf-8?B?emJyd3ErY3ppZkNMMU4zYXF6RDBvM0JUMVVpUGsyTjNEbDVISUI0MG54QVJB?=
 =?utf-8?B?OTk3azhWSlJNMStTaGRUWGJpQXBWYnpvUEgrcDBxVFJRVlI3NDZDdkVYUmxS?=
 =?utf-8?B?Z1o0TVEzVHJjM3JqVjlhU0J5RFVsdlk5M3o4WUhJM0tvZ2hVanBkYVNLS21M?=
 =?utf-8?B?OG0wUHJtc3JZSFJFVXVkYVlIU1dLQWtGNkFTb01iNVhJRmt0Nm5NbGhtMFJl?=
 =?utf-8?B?dGRZNjdBdVYzYUppSHMxVzQxZGNYZmQ5NHBkcDlGM0RnMzc3R1VBRVZ4eHlB?=
 =?utf-8?B?UmZiZXBqa3R4djBwL1Nzdk55VzA3YzE2akVzSFBkSEw4dnFrMzBqUDZoWk9o?=
 =?utf-8?B?T2w1RGRWOVNZaDJiTko5eVB6ZW11azhRakFpL0QrMjVXVVBKNFlhVmRvV0NK?=
 =?utf-8?B?U3FRalZ0akRJZ0lkZ0RQanpWeStGdXAzUHhJRlpxTllseitVcGxDWGZveEtk?=
 =?utf-8?B?TlRZUmwzZUpBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXVZTGNCK0xZcEdFcWorOGY4NHJVdWY3UTArdGVQUDlzdEgxL05LWG1NWDVN?=
 =?utf-8?B?b1VEeVNJZWlabEpBbDduYitrRFc5S3pvV0tIZzZVeUhnMTI0ZlFHcHUzRHdK?=
 =?utf-8?B?L3RHTUNpM1o3NXlLelU1ck5IRy8wVDJZZ3hVZC9aMWFVbHhuYW5kQnJZall0?=
 =?utf-8?B?QkdrUUNGdlRXNklNM2xiYi9xa0VsdnhjdXUzRDJsdVJjV0pnNld1WTFidHhO?=
 =?utf-8?B?SzFUMkE5RHd1R203Vm93T3h1ZUVhVU1ob0gxOGY1b1Q4OW14a2dNanE5TVRw?=
 =?utf-8?B?cG9LVDNMWVM0YVNyM1B6NWNxWGwwQTlsaVJJcitJeGZQcnkwL3Zwb1E3NE9G?=
 =?utf-8?B?WjhxdzRHL3haRTY2SG15Q1Y4VjFUc1Juc05Nb0lzcnV2TzVsdDh5TEtycnRF?=
 =?utf-8?B?TjVGTWpzMU9leHRjNHhKZnV4NVcvYlZVSWxBbysrR240UkxTSTF6YlJaQVZo?=
 =?utf-8?B?QUFVY25KZlRERE1XejIyUm1VNTcyQ0JROG80WGhGNzlZQW1nMlgvSWZWREMy?=
 =?utf-8?B?QmRtSU02bW50bDdvOFRzcUlHNzJ5TnlUaGtnQXhwazhESGxJT2ZVaHBaVGxH?=
 =?utf-8?B?Y2RiMWtsMGIzRERibWJmYWdJdnQxcEQ0WVpScEdkQ0lLalZBeFFLNXJxRFhL?=
 =?utf-8?B?ZHQ2UkdtUndEUkJ4c2N0amREbzNBd3Fma1ZPbEEzbFdLTTF6WGRVZmJGbFFu?=
 =?utf-8?B?cXRhQUpTRzJZVXptUFRJR3JGZnhKdHo2ODVZaEVYbXlmVGl5VnlQRWhXWmpI?=
 =?utf-8?B?MjBYQkJ6ZTQ4TmFLa3ZSSHloN3MrdzFUUTRheWt6UmlOa2dQZ2ZvdW10ekYz?=
 =?utf-8?B?UGFzTzl0TjZ2M3VKOHpSWFpNNVJpVnp4Q05QZ2tNVks3QldBUVVxNnYyS3VW?=
 =?utf-8?B?NXhVKy9yenIrRkNxd0IwUnBwMDd2NnAwQjR0QndmQUJNYkJxelJRWCtlL2Yr?=
 =?utf-8?B?WFQ2Y1BQTFN5MTNGM1RYcUx2Q1VkYjVYQjllSzk3Z3BBeThIQlVRZ1FZTWYy?=
 =?utf-8?B?VjhrbWpLT3hMN3NubllxN01hWjY4MmhEZ3pBalZSb2dzbFJpZlRJOW9uVzR0?=
 =?utf-8?B?UVN3YkN0TVRrQU1kUkJrV2ROVDRvSUJWUEs5eS9PVzRDMEc0SVhSNlhLY1Qz?=
 =?utf-8?B?RUNPYm51TVRjK0NWVnFyb0VnRGpVcVV5SVlodVQyZVFHeVUwZjkvWXM3d2Jq?=
 =?utf-8?B?SE5obVJ3Mkwyai9WemNJL3dlejVHSDZhRTh0ZjFIaEtUeXpkYU1wSzR3YVhQ?=
 =?utf-8?B?OGlwSUlDMEF1NnJ1Yi9GUWdEdktINFNBT1VobW8zM040YkV4LytoZ0p3WURD?=
 =?utf-8?B?R0lXUmMrR1h0NWxVczgrTlhldk9iVDcxdmxwb0dpaGRJNzdrY2RTWlNsZG9I?=
 =?utf-8?B?bWxYL3A5c3pJcUVIdVBueGJNcnVsMVhaQnFnd0JlLzVJUGpNVGZ5N1d1WGMx?=
 =?utf-8?B?YUFMTFFrZmJtNmphM2ZDd2M0QUxtdWxORTB2VzhvUE5pY3BoRFR6T1VCWlhO?=
 =?utf-8?B?dlZ1U095TkE2S0UveTVmdXFBSU81VTJCeUdIY2Y5bmZ3ZnJPMXdnelFjSFkr?=
 =?utf-8?B?c05NdjNkSENrZTZjY0pVUjNpN091aFVKejZ1cDR2QkUrUVZ1aDJPS2RkMjh1?=
 =?utf-8?B?ZEYwbnp2ZnlRUDltTmpvVmZSckdnR1ROYjRpejhma1IyeU1Ca3BrUHZYbGlW?=
 =?utf-8?B?T0ROVkVpZm4xY09QMGVBUCs3VXFSK0VJbUZrazZHdEhVWS9KU0hKS3ZlN2FQ?=
 =?utf-8?B?N2R0QlQ2OWpsck5lU0pwNVhFT0VhajJmbWdGZGFGc0RMTU5jOE5VVUI3R2NL?=
 =?utf-8?B?VUlDK1ZxRG5nTDVWdFZINDE0R1hLQWtDTTlFTWVHQnVIamo5eUZNOExnOGVQ?=
 =?utf-8?B?bG9reU93OFJKNTQ5aGppbUNNWE9VeWVtb1BwazZscHRZNllRUTEvUmRDdkdz?=
 =?utf-8?B?Y0JOT0NYaVZIb0hFRHZqdDVBNWlpY1U1L0YzRHRPUUg2T3EvSFVkaXdYSzJj?=
 =?utf-8?B?bFVDYmY1Y0ZkOW9EbzV3RXp5K2Q2aVdUWDBlZU5YMC9aNUI2UzRTdUcyTmp0?=
 =?utf-8?B?dmJkcWRid2JhZXZaMFFScDZaTXZKOXljb2NScnJYUXBiV2hYOGFWU3Y3aFBi?=
 =?utf-8?B?L3JDTW9XYVlyTEZHK2Mva0xYSHdFM3UxM2tMK0I3bnhVWU42OFBsVzZSUWZs?=
 =?utf-8?Q?VXH88qzCXiTFos6dNtT703Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAD2EA2DB586F444992D55D3A1145941@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BAbhGCpGKei4clvz4yMISYcw1NCFBciQ08j8C8VtvHrGx9DDCUmrZyVUqPMf1GXi9DRQLRKn33JvgZCvI6jOzc7WCJNPxVCYUSuXtICyRTk5n79wEsEiSLhCin0ZMeJU33rgUo3OYT2ElhXMogblpBVYR1IeStoBQINotdJuCLABmvyOH5C/P0AxdF0OF2O9/gRbm5g+UlXE/eB07mtA6LRyz4/lXY3JOj+YXK3SWYrSL042aQr4nPO5XX/2xpuJV1eTw/31F470VowaQsvUzmTEL6GM61gyz5doEVtucn5JxbF/nTVt19/v1VQ46d09iNOkHpRB0UmguA07jylmGtCIl84xqk2pJUnnaQ1R3YLVpcuMiqPyXKqPL+HYQx34O+yIvBsBfE125u13w4cI36KqDtv2l5WLl6JjSM4BXUc+ERRxgXq70JZEFnhuAYapzHmJoKPmg92FxUc+CpEngR5PH/ocj0WSxP0TQGRQgU5+c2aVgOuWF3WeyVEZIZl72jouOf/HICZWYGTbrUn1M15lL4LRAO1xXhLwhsxp4V6iUqJtQsxXahBvDvugngQs5zUsC3dencO7aNu5HTxpdup2oWXyHTvACNjD5C6/sTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3ad0fd-b8ed-453c-9a8b-08de21b50636
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 06:30:50.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPg7YqHVVQBXIvOEcG0f2Ozk7iRhi16Nbm2q82vOQsFJkNSIBW8nvm4sRW2+9hN/JXWs6JvwP2qrLSRhX8eQVEH8mo3r+bN0eDEM6UGRiyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511120049
X-Proofpoint-GUID: o2iSd4u1q6uM8NhE_F8ipYU9ljH5rY8H
X-Authority-Analysis: v=2.4 cv=c4mmgB9l c=1 sm=1 tr=0 ts=69142a20 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7d_E57ReAAAA:8
 a=Z8jnT1IkcGgQq3cNSKAA:9 a=QEXdDO2ut3YA:10 a=jhqOcbufqs7Y1TYCrUUU:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDAxNSBTYWx0ZWRfXzOB3wRAkE3Vt
 O6NF+uzu75RLyeTtWdUygeHeSwtXg8gAM/5uKBNlom7KbgN7mZeG0fqqkFOnvOLGKLLYLCn9HSL
 2qx8MzuJKW8nNpd7ylbeIKi4P/jkRiCyr4FwU2TZn5smV01KDFw0fGg6oiA016DEYJARkTds7/Q
 Sx7G/FUDQXkz2x/CxXvqD2RQyk6uKsT607yKgr8sWaJdjJXbeZgVH//wS+uBu65HISguFlgI5nx
 90hC39hWvdeoIjooIDC1+d+hNB0vlQLE3pNn6hpzHvPCT0pVL3DG4AnO+HKrihFfBpA05dUtRSf
 1OoGpeot7Kxcm2aPKve/5/B+S8FJJg6a0qx9g3wGcd3hxTpZLl5JlYNtZhstPPPq/79+n5oonUT
 okwCBU+2/kz3gCtMd9OUQz4JOXfqDQ==
X-Proofpoint-ORIG-GUID: o2iSd4u1q6uM8NhE_F8ipYU9ljH5rY8H

DQoNCj4gT24gTm92IDExLCAyMDI1LCBhdCA4OjQy4oCvQU0sIE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOg0KPiANCj4gT24gMjAyNS0xMS0x
MCAwOToyMywgTWF0aGlldSBEZXNub3llcnMgd3JvdGU6DQo+PiBPbiAyMDI1LTExLTA2IDEyOjI4
LCBQcmFrYXNoIFNhbmdhcHBhIHdyb3RlOg0KPj4gWy4uLl0NCj4+PiBIaXQgdGhpcyB3YXRjaGRv
ZyBwYW5pYy4NCj4+PiANCj4+PiBVc2luZyBmb2xsb3dpbmcgdHJlZS4gQXNzdW1lIHRoaXMgSXMg
dGhlIGxhdGVzdC4NCj4+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC90Z2x4L2RldmVsLmdpdC8gcnNlcS8gc2xpY2UNCj4+PiANCj4+PiBBcHBlYXJzIHRv
IGJlIHNwaW5uaW5nIGluIG1tX2dldF9jaWQoKS4gTXVzdCBiZSB0aGUgbW0gY2lkIGNoYW5nZXMu
DQo+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUxMDI5MTIzNzE3Ljg4NjYxOTE0
MkBsaW51dHJvbml4LmRlLw0KPj4gV2hlbiB0aGlzIGhhcHBlbmVkIGR1cmluZyB0aGUgZGV2ZWxv
cG1lbnQgb2YgdGhlICJjb21wbGV4IiBtbV9jaWQNCj4+IHNjaGVtZSwgdGhpcyB3YXMgdHlwaWNh
bGx5IGNhdXNlZCBieSBhIHN0YWxlICJtbV9jaWQiIGJlaW5nIGtlcHQgYXJvdW5kDQo+PiBieSBh
IHRhc2sgZXZlbiB0aG91Z2ggaXQgd2FzIG5vdCBhY3R1YWxseSBzY2hlZHVsZWQsIHRodXMgY2F1
c2luZw0KPj4gb3Zlci1yZXNlcnZhdGlvbiBvZiBjb25jdXJyZW5jeSBJRHMgYmV5b25kIHRoZSBt
YXhfY2lkcyB0aHJlc2hvbGQuIFRoaXMNCj4+IGVuZHMgdXAgbG9vcGluZyBpbjoNCj4+IHN0YXRp
YyBpbmxpbmUgdW5zaWduZWQgaW50IG1tX2dldF9jaWQoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQo+
PiB7DQo+PiAgICAgICAgIHVuc2lnbmVkIGludCBjaWQgPSBfX21tX2dldF9jaWQobW0sIFJFQURf
T05DRShtbS0gID5tbV9jaWQubWF4X2NpZHMpKTsNCj4+ICAgICAgICAgd2hpbGUgKGNpZCA9PSBN
TV9DSURfVU5TRVQpIHsNCj4+ICAgICAgICAgICAgICAgICBjcHVfcmVsYXgoKTsNCj4+ICAgICAg
ICAgICAgICAgICBjaWQgPSBfX21tX2dldF9jaWQobW0sIG51bV9wb3NzaWJsZV9jcHVzKCkpOw0K
Pj4gICAgICAgICB9DQo+PiAgICAgICAgIHJldHVybiBjaWQ7DQo+PiB9DQo+PiBCYXNlZCBvbiB0
aGUgc3RhY2t0cmFjZSB5b3UgcHJvdmlkZWQsIGl0IHNlZW1zIHRvIGhhcHBlbiB3aXRoaW4NCj4+
IHNjaGVkX21tX2NpZF9mb3JrKCkgd2l0aGluIGNvcHlfcHJvY2Vzcywgc28gcGVyaGFwcyBpdCdz
IHNpbXBseSBhbg0KPj4gaW5pdGlhbGl6YXRpb24gaXNzdWUgaW4gZm9yaywgb3IgYW4gaXNzdWUg
d2hlbiBjbG9uaW5nIGEgbmV3IHRocmVhZCA/DQo+IA0KPiBJJ3ZlIHNwZW50IHNvbWUgdGltZSBk
aWdnaW5nIHRocm91Z2ggVGhvbWFzJyBpbXBsZW1lbnRhdGlvbiBvZg0KPiBtbV9jaWQgbWFuYWdl
bWVudC4gSSd2ZSBzcG90dGVkIHNvbWV0aGluZyB3aGljaCBtYXkgZXhwbGFpbg0KPiB0aGUgd2F0
Y2hkb2cgcGFuaWMuIEhlcmUgaXMgdGhlIHNjZW5hcmlvOg0KDQpbLi5dDQo+IEkgc2VlIHR3byBw
b3NzaWJsZSBpc3N1ZXMgaGVyZToNCj4gDQo+IEEpIG1tX3VwZGF0ZV9jcHVzX2FsbG93ZWQgY2Fu
IHRyYW5zaXRpb24gZnJvbSBwZXItY3B1IHRvIHBlci10YXNrIG1tX2NpZA0KPiAgIG1vZGUgd2l0
aG91dCBzZXR0aW5nIHRoZSBtYy0+dHJhbnNpdCBmbGFnLg0KPiANCj4gQikgc2NoZWRfbW1fY2lk
X2ZvcmsgY2FsbHMgbW1fZ2V0X2NwdSgpIGJlZm9yZSBpbnZva2luZw0KPiAgIG1tX2NpZF9maXh1
cF9jcHVzX3RvX3Rhc2tzKCkgd2hpY2ggd291bGQgcmVjbGFpbSBzdGFsZSBwZXItY3B1DQo+ICAg
bW1fY2lkcyBhbmQgbWFrZSB0aGVtIGF2YWlsYWJsZSBmb3IgbW1fZ2V0X2NwdSgpLg0KPiANCj4g
VGhvdWdodHMgPw0KDQpUaGUgcHJvYmxlbSByZXByb2R1Y2VzIG9uIGEgMiBzb2NrZXQgQU1EKDM4
NCBjcHVzKSBiYXJlIG1ldGFsIHN5c3RlbS4NCkl0IG9jY3VycyBzb29uIGFmdGVyIHN5c3RlbSBi
b290IHVwLiAgRG9lcyBub3QgcmVwcm9kdWNlIG9uIGEgNjRjcHUgVk0uDQoNCk1hbmFnZWQgdG8g
Z3JlcCB0aGUg4oCYbWtzcXVhc2hmc+KAmSBjb21tYW5kIHRoYXQgd2FzIGV4ZWN1dGluZywgd2hp
Y2ggIHRyaWdnZXJzIHRoZSBwYW5pYy4gDQoNCiNwcyAtZWYgfGdyZXAgbWtzcXVhc2guDQpyb290
ICAgICAgIDE2NjE0ICAgMTA4MjkgIDAgMDU6NTUgPyAgICAgICAgMDA6MDA6MDAgbWtzcXVhc2hm
cyAvZGV2L251bGwgL3Zhci90bXAvZHJhY3V0LmlMczB6MC8uc3F1YXNoLXRlc3QuaW1nIC1uby1w
cm9ncmVzcyAtY29tcCB4eg0KDQoNCkkgYWRkZWQgZm9sbG93aW5nIHByaW50a+KAmXMgdG8gbW1f
Z2V0X2NpZCgpDQoNCnN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IG1tX2dldF9jaWQoc3RydWN0
IG1tX3N0cnVjdCAqbW0pDQogew0KICAgICAgICB1bnNpZ25lZCBpbnQgY2lkID0gX19tbV9nZXRf
Y2lkKG1tLCBSRUFEX09OQ0UobW0tPm1tX2NpZC5tYXhfY2lkcykpOw0KKyAgICAgICBpbnQgbWF4
X2NpZHMgPSBSRUFEX09OQ0UobW0tPm1tX2NpZC5tYXhfY2lkcyk7DQorICAgICAgIGxvbmcgKmFk
ZHIgPSBtbV9jaWRtYXNrKG1tKTsNCisNCisgICAgICAgaWYgKGNpZCA9PSBNTV9DSURfVU5TRVQp
IHsNCisgICAgICAgICAgICAgICBwcmludGsoS0VSTl9JTkZPICJwaWQgJWQsIGV4ZWMgJXMsIG1h
eGNpZHMgJWQgcGVyY3B1ICVkIHBjcHV0aHIgJWQsIHVzZXJzICVkIG5yY3B1c19hbGx3ZCAlZFxu
IiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbW0tPm93bmVyLT5waWQsIG1tLT5v
d25lci0+Y29tbSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWF4X2NpZHMsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1tLT5tbV9jaWQucGVyY3B1LA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBtbS0+bW1fY2lkLnBjcHVfdGhycywNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbW0tPm1tX2NpZC51c2VycywNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbW0tPm1tX2NpZC5ucl9jcHVzX2FsbG93ZWQpOw0KKyAgICAgICAg
ICAgICAgIHByaW50ayhLRVJOX0lORk8gImNpZCBiaXRtYXNrICVseCAlbHggJWx4ICVseCAlbHgg
JWx4XG4iLA0KKyAgICAgICAgICAgICAgICAgICAgICAgYWRkclswXSwgYWRkclsxXSwgYWRkclsy
XSwgYWRkclszXSwgYWRkcls0XSwgYWRkcls1XSk7DQogDQorICAgICAgIH0NCiAgICAgICAgd2hp
bGUgKGNpZCA9PSBNTV9DSURfVU5TRVQpIHsNCiAgICAgICAgICAgICAgICBjcHVfcmVsYXgoKTsN
Cg0KR290IGZvbGxvd2luZyB0cmFjZSh0cmltbWVkKS4gDQoNClsgICA2NS4xMzk1NDNdIHBpZCAx
NjYxNCwgZXhlYyBta3NxdWFzaGZzLCBtYXhjaWRzIDgyIHBlcmNwdSAwIHBjcHV0aHIgMCwgdXNl
cnMgNjYgbnJjcHVzX2FsbHdkIDM4NA0KWyAgIDY1LjEzOTU0NF0gY2lkIGJpdG1hc2sgZmZmZmZm
ZmZmZmZmZmZmZiBmZmZmZmZmZmZmZmZmZmZmIGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZmZmZmZmZm
ZmZmZiA0OTRlNDk1ZjQzNDU1MzU3IDQ0NDU1YTQ5NGM0MTQ5NTQNClsgICA2NS4xMzk1OTddIHBp
ZCAxNjYxNCwgZXhlYyBta3NxdWFzaGZzLCBtYXhjaWRzIDgzIHBlcmNwdSAwIHBjcHV0aHIgMCwg
dXNlcnMgNjcgbnJjcHVzX2FsbHdkIDM4NA0KWyAgIDY1LjEzOTU5OV0gY2lkIGJpdG1hc2sgZmZm
ZmZmZmZmZmZmZmZmZiBmZmZmZmZmZmZmZmZmZmZmIGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZmZmZm
ZmZmZmZmZiA0OTRlNDk1ZjQzNDU1MzVmIDQ0NDU1YTQ5NGM0MTQ5NTQNCi4uDQpbICAgNjUuMTQy
NjY1XSBjaWQgYml0bWFzayBmZmZmZmZmZmZmZmZmZmZmIGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZm
ZmZmZmZmZmZmZiBmZmZmZmZmZmZmZmZmZmZmIGZmZmZmZmZmZmZmZmZmZmYgNDQ0NTVhNWZmZmZm
ZmZmZg0KWyAgIDY1LjE0Mjc1MF0gcGlkIDE2NjE0LCBleGVjIG1rc3F1YXNoZnMsIG1heGNpZHMg
MTU1IHBlcmNwdSAwIHBjcHV0aHIgMCwgdXNlcnMgMTI0IG5yY3B1c19hbGx3ZCAzODQNClsgICA2
NS4xNDI3NTJdIGNpZCBiaXRtYXNrIGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZmZmZmZmZmZmZmZiBm
ZmZmZmZmZmZmZmZmZmZmIGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZmZmZmZmZmZmZmZiA0NDQ1NWE3
ZmZmZmZmZmZmDQouLg0KWyAgIDY1LjE0MzcxMl0gY2lkIGJpdG1hc2sgZmZmZmZmZmZmZmZmZmZm
ZiBmZmZmZmZmZmZmZmZmZmZmIGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZmZmZmZmZmZmZmZiBmZmZm
ZmZmZmZmZmZmZmZmIDdmZmZmZmZmZmZmZmZmZmYNClsgICA2NS4xNDM3NjddIHBpZCAxNjYxNCwg
ZXhlYyBta3NxdWFzaGZzLCBtYXhjaWRzIDE3NSBwZXJjcHUgMCBwY3B1dGhyIDAsIHVzZXJzIDE0
MCBucmNwdXNfYWxsd2QgMzg0DQpbICAgNjUuMTQzNzY5XSBjaWQgYml0bWFzayBmZmZmZmZmZmZm
ZmZmZmZmIGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZmZmZmZmZmZmZmZiBmZmZmZmZmZmZmZmZmZmZm
IGZmZmZmZmZmZmZmZmZmZmYgZmZmZmZmZmZmZmZmZmZmZg0KDQpGb2xsb3dlZCBieSB0aGUgcGFu
aWMuDQpbICAgOTkuOTc5MjU2XSB3YXRjaGRvZzogQ1BVMTE0OiBXYXRjaGRvZyBkZXRlY3RlZCBo
YXJkIExPQ0tVUCBvbiBjcHUgMTE0DQouLiANCiA5OS45NzkzNDBdIFJJUDogMDAxMDptbV9nZXRf
Y2lkKzB4ZjUvMHgxNTANClsgICA5OS45NzkzNDZdIENvZGU6IDRkIDhiIDQ0IDI0IDE4IDQ4IGM3
IGM3IGUwIDA3IDg2IGI2IDQ5IDhiIDRjIDI0IDEwIDQ5IDhiIDU0IDI0IDA4IDQxIGZmIDc0IDI0
IDI4IDQ5IDhiIDM0IDI0IGU4IGMxIGI3IDA0IDAwIDQ4IDgzIGM0IDE4IGYzIDkwIDw4Yj4gMDUg
NjUgYWUgZWMgMDEgOGIgMzUgZWIgZTAgNjggMDEgODMgYzAgM2YgNDggODkgZjUgYzEgZTggMDMg
MjUNClsgICA5OS45NzkzNDhdIFJTUDogMDAxODpmZjc1NjUwY2Y5NzE3ZDIwIEVGTEFHUzogMDAw
MDAwNDYNClsgICA5OS45NzkzNDldIFJBWDogMDAwMDAwMDAwMDAwMDE4MCBSQlg6IGZmNDI0MjM2
ZTVkNTVjNDAgUkNYOiAwMDAwMDAwMDAwMDAwMTgwDQpbICAgOTkuOTc5MzUxXSBSRFg6IDAwMDAw
MDAwMDAwMDAwMDAgUlNJOiAwMDAwMDAwMDAwMDAwMTgwIFJESTogZmY0MjQyMzZlNWQ1NWNkMA0K
WyAgIDk5Ljk3OTM1Ml0gUkJQOiAwMDAwMDAwMDAwMDAwMTgwIFIwODogMDAwMDAwMDAwMDAwMDE4
MCBSMDk6IGMwMDAwMDAwZmZmZGZmZmYNClsgICA5OS45NzkzNTJdIFIxMDogMDAwMDAwMDAwMDAw
MDAwMSBSMTE6IGZmNzU2NTBjZjk3MTdhODAgUjEyOiBmZjQyNDIzNmU1ZDU1Y2EwDQpbICAgOTku
OTc5MzUzXSBSMTM6IGZmNDI0MjM2ZTVkNTU2NjggUjE0OiBmZmE3NjUwY2JhMjg0MWMwIFIxNTog
ZmY0MjQyMzg4MWE1YWE4MA0KWyAgIDk5Ljk3OTM1NV0gRlM6ICAwMDAwN2Y0NjllZDZiNzQwKDAw
MDApIEdTOmZmNDI0MzUxYzI0ZDYwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KWyAg
IDk5Ljk3OTM1Nl0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1
MDAzMw0KWyAgIDk5Ljk3OTM1N10gQ1IyOiAwMDAwN2Y0NDNiN2ZkZmI4IENSMzogMDAwMDAxMjcy
NDU1NTAwNiBDUjQ6IDAwMDAwMDAwMDA3NzFlZjANClsgICA5OS45NzkzNThdIFBLUlU6IDU1NTU1
NTU0DQpbICAgOTkuOTc5MzU5XSBDYWxsIFRyYWNlOg0KWyAgIDk5Ljk3OTM2MV0gIDxUQVNLPg0K
WyAgIDk5Ljk3OTM2NF0gIHNjaGVkX21tX2NpZF9mb3JrKzB4M2ZiLzB4NTkwDQpbICAgOTkuOTc5
MzY5XSAgY29weV9wcm9jZXNzKzB4ZDFhLzB4MjEzMA0KWyAgIDk5Ljk3OTM3NV0gIGtlcm5lbF9j
bG9uZSsweDlkLzB4M2IwDQpbICAgOTkuOTc5Mzc5XSAgX19kb19zeXNfY2xvbmUrMHg2NS8weDkw
DQpbICAgOTkuOTc5Mzg0XSAgZG9fc3lzY2FsbF82NCsweDY0LzB4NjcwDQpbICAgOTkuOTc5Mzg4
XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQ0KWyAgIDk5Ljk3OTM5
MV0gUklQOiAwMDMzOjB4N2Y0NjlkNzdkOGM1DQoNCg0KQXMgeW91IGNhbiBzZWUsIGF0IGxlYXN0
IHdoZW4gaXQgY2Fubm90IGZpbmQgYXZhaWxhYmxlIGNpZOKAmXMgaXQgaXMgaW4gcGVyLXRhc2sg
bW0gY2lkIG1vZGUuDQpQZXJoYXBzIGl0IGlzIHRha2luZyBsb25nZXIgdG8gZHJvcCB1c2VkIGNp
ZOKAmXM/IEkgaGF2ZSBub3QgZGVsdmVkIGludG8gdGhlIG1tIGNpZCBtYW5hZ2VtZW50LiANCkhv
cGVmdWwgeW91IGNhbiBtYWtlIG91dCBzb21ldGhpbmcgZnJvbSB0aGUgYWJvdmUgdHJhY2UuDQoN
CkxldCBtZSBrbm93IGlmIHlvdSB3YW50IG1lIHRvIGFkZCBtb3JlIHRyYWNpbmcuIA0KDQotUHJh
a2FzaA0KDQoNCj4gDQo+IFRoYW5rcywNCj4gDQo+IE1hdGhpZXUNCj4gDQo+IC0tIA0KPiBNYXRo
aWV1IERlc25veWVycw0KPiBFZmZpY2lPUyBJbmMuDQo+IGh0dHBzOi8vd3d3LmVmZmljaW9zLmNv
bQ0KDQoNCg==

