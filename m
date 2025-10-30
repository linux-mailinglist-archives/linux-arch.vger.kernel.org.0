Return-Path: <linux-arch+bounces-14428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7EC22814
	for <lists+linux-arch@lfdr.de>; Thu, 30 Oct 2025 23:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5102934FC43
	for <lists+linux-arch@lfdr.de>; Thu, 30 Oct 2025 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450363168FA;
	Thu, 30 Oct 2025 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TUad8ZHF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hRpMzVAr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8902EDD52;
	Thu, 30 Oct 2025 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861812; cv=fail; b=aBmuHLw/h4CIaQZcWKY6BzySVUoZ62lBEWT+lx3xvbrLxDUc0RYVzXYAsgO5W+WmbtR0ybARdx4xumuwTqsY5bg/6icNjXBa9VStpAKwUVqqtFO6NkuNd9GnPwkEggZNkCy7Jylu4bdJ0lwj/aOPE8/+mVXaZpjWnQyXoN3cUk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861812; c=relaxed/simple;
	bh=81qIMFfWJBPBRJ1/LhowCIi8fcuHECzR+w15ksDiu/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFD/misrHTlanKOPWrXsRxhs8Oi79m5IVA9Iye6HpmQfc2BHRVnJawpz4aG6Zg+uYFE8kiMb5q0DPw1ZqAQ7etXYfZn+dHMDcTYxFZ81MVfKYi6eqd9/rIGqSWlFxZOVp01MbP5ALh+pqnUVFXBG6evkcIKn/rKGvsaO4mWtL7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TUad8ZHF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hRpMzVAr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UKV11L024720;
	Thu, 30 Oct 2025 22:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=81qIMFfWJBPBRJ1/LhowCIi8fcuHECzR+w15ksDiu/c=; b=
	TUad8ZHF/bn0fPXdGNHy2Zi93bc8/IGQEPtHyfhPhRloqng3OaKCeDn2cwqcuHjv
	wI7pCDnNykVumsIYQ8BXDDd9vlk5HC3UEnrwhdArdOu08eeuzPyjsF0ZMoVVtw+I
	fKQIYrWE5ZXNOD0bfvQzBg9hV7HZtp76TypGikqpGPZEYslXkOX4DLNhcZgf/zv0
	RLscb+yAnx0b/MJNm2iCPgOa/hKZPiJZ6kwuhrnX4ckqEQ422uVd/UEQ/LXbQn2c
	jgGoJRZ2OOfwuEZeMU2aa8f22OF9v7a03+vNVYgaRgi1XkZ7eyJE2+GE1oNiQ0l6
	8cKyDpJadqd9nDJXhrjdYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4dg3rf7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 22:01:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UJklOr027589;
	Thu, 30 Oct 2025 22:01:19 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q9pjhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 22:01:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anRlobQdPfDqMIsToA6rH1TWZFYUdT6gKOegqWOxdm/HCUOvhxr3FqCd9pk+q/4uBAst0I3siPwwZSM7IgaBmTgc68xM8g8UDa0VksRh1GPV++NFnSwb1cpDk0wOc9vSxX90yF1FGJ+7xpe3SqxbUOC/aLx05WZ90NqcBq/CU08xatJWYbhqRo9LxTOPlcI7NiLoSuSqaaTIxIdemQxafaiNz4WmtE+XsguSxgbYDgCC1z8jfNlQ7sxTL1qF9qeT9MIe7LoKF8+ErxlqPS7S72XqevWn1ZIufgVm1BMupY3+9cy9cJm5GNw4zSQuFK6zTQuDOMzaRn7D/FMye5yYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81qIMFfWJBPBRJ1/LhowCIi8fcuHECzR+w15ksDiu/c=;
 b=X/4idKrX1sKzOPNzgecmK+hVUgf1AHpL7w4m5K8vM+fwQaMk8X+FEUjnMaqjytks1NsGZ6RkAjdnIuW3qoff/jWA+v75A1tkmLA2dclWY4fbXbkZW1jGwWlGPl+rlXGjmJK61XDUxzonezQt3vtkd4iL7LyEnIeGH1MfQfcOq0/va+esJzeugM4ckp/N1fiecudh9ATpIOkz5tB41X35z9hYntPhezAI9zHvFEUtDLP8a9MvkNnOBw0ltPabOqrkCodMdZv1BpOS+AUr9kxEKoilYN+3OVo5HMVxHsYQAAPFLjdQZo/sP9QJ0xaL5W+6ONCVK0BXw3F46myKcXqfZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81qIMFfWJBPBRJ1/LhowCIi8fcuHECzR+w15ksDiu/c=;
 b=hRpMzVAr5aXkYpt3UCrJiFrFEzNBQ/msPG1HvJ4oVudrmJtc7YcYbaLkVdvUK2i7pnDb6zf/6t0Pib39m20f+9OGHGT1gj/9pVdWF3lVE8DZSdBfomYRznAgWMb1qDBn/T5c65kmJXfxzBbaO0lu1DroMZQ4HOBnlQHcL2IsOjM=
Received: from CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11)
 by DS0PR10MB8055.namprd10.prod.outlook.com (2603:10b6:8:1fc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 22:01:16 +0000
Received: from CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5]) by CH3PR10MB7308.namprd10.prod.outlook.com
 ([fe80::b5ca:360f:30bd:83f5%6]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 22:01:15 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra
	<peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Madadi Vineeth Reddy
	<vineethr@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
Thread-Topic: [patch V3 02/12] rseq: Add fields and constants for time slice
 extension
Thread-Index: AQHcSNcR0dKsFra+T0Gf8aA9iUiXhrTbP7KA
Date: Thu, 30 Oct 2025 22:01:15 +0000
Message-ID: <999E136D-49BE-4AEE-8392-C09D0511351C@oracle.com>
References: <20251029125514.496134233@linutronix.de>
 <20251029130403.542731428@linutronix.de>
In-Reply-To: <20251029130403.542731428@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7308:EE_|DS0PR10MB8055:EE_
x-ms-office365-filtering-correlation-id: 3731927a-f65b-4cf6-9284-08de17ffd900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2JUU2kyZVRqQUo0WkNvVmlGZ3JHOEdmOXVMVjQwNVZOMWRYNUZsaDNzRjVu?=
 =?utf-8?B?SkpsUGE4VWJpVTFJTEVQK3NpNjNqRm1aVmlBRGpBOGlnNGdyY0ZxbWpBNmRJ?=
 =?utf-8?B?UmsrODlvRGhjNFNDQ1NnNVl3TU5oa1pJay85aGtEUXFmRzdhSEppMlNqZnhE?=
 =?utf-8?B?NXVjSTAweWVVcEU1OWMreWV6bEN0aXhzL3dGNGZObXJZa1M5TjA5blhUbXFz?=
 =?utf-8?B?Sk05dTNWM0J6VFIvZkxXNnI5L0d3VFNUc1hEUk15ZS9IUnJhM0RXV2hQb05q?=
 =?utf-8?B?a2pwRzJ6YW9LS2VTajNweXc3QlBVdU0xQWV0enNmV3RLM0dYS1ljQ1V5SmVN?=
 =?utf-8?B?T0NlSkZ4cGtuRU5uWjR0dlo3TW9RY1FjbEJWUFpnbmhlY1JpbHc3a3UrajdB?=
 =?utf-8?B?Z1MrUkJaTEJCdkxGOVlsNjM3elRzdjErSFNoeEtDQjBsbVJ2UDFGVmw0V3Zm?=
 =?utf-8?B?eWJtbHAyL0FrczZEZ01XV3N3cXk4OTZJTUNmMUR3ZGswYjlXZmFRbjhkTkpX?=
 =?utf-8?B?Y0lEbmFvMnk3VHJnRDRnSmdCMEdGT2RUUHprMmZNamNQQXVLWUJ5L05tcFVE?=
 =?utf-8?B?MVlXOXgrVU1BVTZ3TVl4QTVWUGJtT3pIL25JMDdQb0JOUUpDeERELy9EelFm?=
 =?utf-8?B?dWRJQ0VyVjVFclhCLzFqdmdyUysyT2JBZHlNRWRCck03U2ZBT2NTNWZTSk5l?=
 =?utf-8?B?QmJYQm8wRXJiREdidnZJbmpORWd0Y29uTlpnQjNNcmdENmE5UmdjYTVodlQ4?=
 =?utf-8?B?eVl0M3JwUTBobDhXZm5HS1NUcFByZFBBL3hZZzR6RzYwQkpNbFloZTFPYlo3?=
 =?utf-8?B?TWw2bGVqaGhHbXppYlR6WGNjUnBLQVc3enU0K2ZSY0dZNTVMbVhHL1NmOHpm?=
 =?utf-8?B?TzRJWXRlTVZIbUE0bEVoLytPRi9lVTd5NHRjY1ZjRHFIeEFwZjhsRStBWndW?=
 =?utf-8?B?M0pCd05ibk4zbG44Z2Z4RU85bVc0bXlmekxVdmxYem42SnhPVndEMVUzWGFz?=
 =?utf-8?B?WkY2MHdHRWhaY0Ria1g0a3Fmd0s1K0wvQjgyaW5UcnNNVzJPeWpjL3dudEpF?=
 =?utf-8?B?VzB1YWtaYmxGYXE3Z04zd1RPNXlmT2dZKzRVVys5OEdYa1ZjdmZhRkhuMkJ1?=
 =?utf-8?B?UlY5OFFxaEk5MXI2dzZjM1BtN1hyd1R0MjkvSVZjMG1US1RJREdYQjNBQkJX?=
 =?utf-8?B?elVseWdPN2pkWjFyK2ZveXBGUkNFb1RJUHQrTEN5MS83c094NUxRZ2N6eXVO?=
 =?utf-8?B?dktUN0trK29YZUc0TjdrMmRrWFB3ajIrY1B1SXhlY2xpR1ZkYzZES1RtaUxR?=
 =?utf-8?B?RjMvK2NOS1NmcEc2eUpRcXFTZHlBdFE1WElHOFc5aTB4ZmZKVFVRQTMxQitB?=
 =?utf-8?B?Uit0U1E0T0pWUmRFaUI2cmpVL2FrK3NqWFlJWnUrZk1NRzI2aGdLSU9WNGc3?=
 =?utf-8?B?YzBkL3RZUnpQU2p3SVViek52c3VRQVZwNzVnN3B1MGxGYWJGRDdDMUV3MWM5?=
 =?utf-8?B?bmVFb0VTQmYyMk9TcFpMMmJRMW1xaUJYc0Fac2Zjd0xYTUFlbjZ3T2VnM0NN?=
 =?utf-8?B?NDZUd0FWWmg3L1F4MlFYOW9YcXo2dlNYeGhKU3I2TVVLMEdBR3hha3R3dEpx?=
 =?utf-8?B?SStVN1JvV1poM085ZE9mejRnM3JqaCsybVFTUDV5SWtJRy96ZkpaNTJTZVMy?=
 =?utf-8?B?d1hvMkJHMGNOdjhoT215dWw5U1pybFNPcEllQXU5VWg5UEo5dkJZMis1UDhL?=
 =?utf-8?B?c2MzWEQ0YlloUGo4SlhqVGg2L3dUaHA3N083MjZ5ckZwalYxMTMvdlNDSTYr?=
 =?utf-8?B?MEhFVndmNngzcDZlZDFQckdYenZFSkRZWnQ4UTZ1ckpKWmZOalB5QTBWd29s?=
 =?utf-8?B?NG5iV3R6eVhUdUdVd1JHU3B2VGNLa2pYZk0zSHJEQUk0dHZBTVI5Y3RlSUQ5?=
 =?utf-8?B?L1JSa2hEbDduQmRldFdUTWo4SHlsTC90eEtubUNZdWxYTlBsTmJCQWZVOS94?=
 =?utf-8?B?b1JIWWlpTzN3eDg5aDZkOXhJMkJGY096ajlBSjhJd29iQVJvVWExR08zRnRL?=
 =?utf-8?Q?BiUvJd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7308.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXYvY3FORUJmRy82azBMMnRQQXJTQndxdmQ2SW1DdFd0RytSRVVOQTYrM0RG?=
 =?utf-8?B?VUVDVWorR0xVNHIwUmFIKzFvd0ZjVklReEd3VzhpNHZRRE0xNkVDYzY1RzVt?=
 =?utf-8?B?QzNxeEJmOHRTTjFYVzNHUXVlMW5zNUN0eEdFSDZMaktuajlUY25MNm4wUEJD?=
 =?utf-8?B?U1lWZlNpYnM1QUFiL01MY1UvR2Vka1NHSWpieWZFTXRaUlRxS21naTBYcVVY?=
 =?utf-8?B?UGZ6Ky9EZHNZR2o1Z0dHS0p5Vnl6dk85RjBSWWRTWFhIT2I0VkxUcys2cUxZ?=
 =?utf-8?B?S3gvMDVZTWpPZURnb3Y0NkRnZEZoNWludVNNSnF6UzNaQTY2N1hhcTBzR1V5?=
 =?utf-8?B?bDlHVXo1M3pGdFZVbjhoZCtGYU1raXNjR2d3cUJqYzFkNlVVcDN0RlBpMllC?=
 =?utf-8?B?bzR3eEZtRk80SDM2bHk1OXM3cmVHWmlsN0h3OEFlUTMxZ0ZRT3ZNWDdVWWpO?=
 =?utf-8?B?V0ZNL3VoZHVSS3hvWFpNa281QVJjN0ZDblp5WFdRYXpwZGJ5eURoTkNpVmE4?=
 =?utf-8?B?QVp0UnRkK1FCeVRzRmNEdnFNM1dpSVFrTjRNMURCV0FzbVN1QXFJS1hEVGFW?=
 =?utf-8?B?UVUvOWgvb3RuSlpBdHhkdkc1OVNmVWxMTkpXMFZDMHc5QVVSVWRCU0N4TUZU?=
 =?utf-8?B?ZEV1OGFjVGNHSm1rSkVHZ1dwdkF5TkxoVVVNSkFWT1hEL1dYbW5KeGJ4OFJp?=
 =?utf-8?B?MjJtRVVLUzFKVW1YRnBLSC84TzRuakttcm1pbTl6ZUhvNDEvajBldElmQmZm?=
 =?utf-8?B?Mk5aTk1UOVdpZEtseDVrTElmMEpzczNSQXEzakU1N2RHQnlkRUJRSE0wcmdQ?=
 =?utf-8?B?L244ay9VcHVIQnhEb3UyaUwzRkg1akdPbmp5QUhNZENVVWJtWUpWdTZXdGhJ?=
 =?utf-8?B?Z3RxOFhQOXM3dzZhVVBIdTc4dWJ1YllHWjk0NFZZTHBkWmJXMFlEeVhJSGtk?=
 =?utf-8?B?VEFFRmRGd2svNzN2RC9OOVN2VVVETEtmcHhQS2RRbHo1ME1iTWdFVkd4dlJL?=
 =?utf-8?B?cUlCbGxGblovRjFaMlBQUDZQL3B1Q2NTUEVWQlA2bm9PS2lRQjgyQmRYeERn?=
 =?utf-8?B?eWs4OUtVQUpvUkpqWjg4bXhDNUlweVppZERIMXp0MXBZZUFvYmhNa1RVSmhE?=
 =?utf-8?B?Tk13QnJhL0xwWEJoVzhCamJFNDVXSVFsNzFFSTJsbjZhKzlicURUbWk1aGFk?=
 =?utf-8?B?bE1GNFJaZExVRkwxV29IM2JKY1JlblhJOFYyR2ZEd3FHZ3RNSUdQdkpuZWhK?=
 =?utf-8?B?QlBMODQwUGpkYlpUR0lFYlBaNDBtWTZjM0FobWtiK2djMC9POFpkaklTV3c1?=
 =?utf-8?B?dG1nVzFOUmJWT0U2MHpjVmJXSC9aMzJ1Y29JWE9zN1ZNRk5zODQzMy9NRVVI?=
 =?utf-8?B?MTg5L2UyNkhwR3EvMzdTSXlFRnNOZmNxSmNaOWdIUDBZZEpHcE1BUlBITUQ5?=
 =?utf-8?B?TmhzN0VyYnRSdGpRRWpXRlJRdkZ2MjVoL09peTYzb1poWXZNZVlkRjYvZ0E0?=
 =?utf-8?B?T0t5Tkg3eXhBRk45S3o1US91ZWt3TzZhemdCbE8zZHd2blBiR3NRY0Ezd0NP?=
 =?utf-8?B?SkR4MHBGMk5zZEFTSWRtaTc2ZGltRW1kUHZCYkQ1T3BKSmNwWkNuZkVlanhh?=
 =?utf-8?B?czhGcXg4OThqenZUVmJCd3lFaGEzaDhiSDd6T3NoU3BCYUVxNVZPM3pydHlH?=
 =?utf-8?B?TFUzM1ZTUXpkdDFSQjNwck02N3ZiWGNzL0c3Y0xVWWV5bGs3ODF1bkxPblVu?=
 =?utf-8?B?aGhkRFVDMi9GYnBYTm1xWElycGJRNmRUWE13ZzE2bkpuS3Y3L3pVU0swMUFK?=
 =?utf-8?B?b1A1OTVyQURLL2NhQlJlakluMFJvWUhFRUZobzlscnEyck1MNVQ3MC81N2Ew?=
 =?utf-8?B?dzMyL2doTWE4TVZmYUFOVy9lbU1GM3ZoWHg4Yyt6czBQT1lDVlBmOFM4NFZw?=
 =?utf-8?B?ZGJpa3M2R0U0dktRTWNRbGt4UmM3UVFYZEN6RFFyN1V1eHlidENZRXFMcWhQ?=
 =?utf-8?B?WUxUNTBVVWZsOWNRSXg2WWxtWGtRRnM4NmszV1dnNHpRbEVlQ3ZVTzZaQUhZ?=
 =?utf-8?B?REdRbi9zQ25jc3JaTDZZTURNY0ZPZkI4bVlyNDVVS1ZZV2hZc0k2WDJnd2N6?=
 =?utf-8?B?TmMwd0lJZnVwVE1mTUtZaVJKbFJ3NVdhbk1NWHM2bEREVGc4RHVQNkFjK0Nm?=
 =?utf-8?Q?hbUXowx8AleVC/kTCuXJi60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6182A36499B558459FF8A9D767F27D1D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fdpm8p/LdlNKZ5cD47IanZuh/vmpz5r+6kzDzt08ff2ravTAXD/NdLpopqVg/gkWu78RJaOLbbPJlae2/2dLsFWG4I3u/p9gPIaov0vAdMdcGsScE7Z2TtZce6GN1rPr4z4QWjs+U/kDhmeiKm76D0+fjSjl1MTsNSiZ4lzd9pxVaXB2Lyh6QuQO8wGa1sEKZjE6JGWxm+Xa0vv9XEx6J0Il+krY5KdY3LXIavlFCsACn/dN6VK2oRbeZ9WduBeg2BndpLlAmfpshRc5ah+5gCyH751f6+KLqFzW8poK1yBem5BsCFmE/PJtWmP6rxN4/IkwXL/IMhaLfhxebDjfPFpE8yqg29tR2IXJ36Wed4eTcHgzdBz35DcA4IdsLDiiJKSC3iJ3k47la7le1nydqcGii3YfWgoTW/tV6XgvovCY2cz6ygqKTT8I/BipOuFP13/jgM8NtLxOBOv3dXT3tNHhqYFwgcBZq0JMvJ2cUcVqvwEN4JaUzNGnNEhNgm5N4rV5NTRw70gJ4XGTmcUyt9Y4/LExdKIi9FGjgvjzcs566X1cl3vzWIJymlVRr+dloqQkAB3ioRShTbSM/dPz+3zlMZzHTus7pl4NoaoHlQA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7308.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3731927a-f65b-4cf6-9284-08de17ffd900
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 22:01:15.7503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGbgJ5N1qcAoYgshDcQRFUETPLkb4TfeoHpngChZ6QZV52D3TTDTB24JZpLGUcxC93AHTyUp9uIDTjoNXpLqMt80nFW/BxPLyeWw1qskUUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8055
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300186
X-Authority-Analysis: v=2.4 cv=ctCWUl4i c=1 sm=1 tr=0 ts=6903e030 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=BDpqFueg_UnsECjX0a0A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12124
X-Proofpoint-ORIG-GUID: 36xs33OVOnegd0vV-YFNUZSb6OKvQcJI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1NSBTYWx0ZWRfX0ptE7xpz/ghX
 Pis61p2o6SBKkwTvxnfELeDmRKWczcq0J899h5+kmY0NG8B0VLVtfnRkDLIMqbZebd9mhnXWDMw
 sUeQke+bjtB66+fRLmNhIdcSVmRWUvz/q3yP+rBt3LxUMIRtlSM74iUtY+7R4Hd7JhsSqEwg/5z
 aiC9OBZUk3bV1HlqyfxIJUjV3/CR43LYre16r0iSpyaE/Whdz0N3L0fYV6a3zpP2yfAPMRUP7TF
 jYyT34Aq8kebTnh5IKK7nXX7mS4c3HNg00Tv6/rGpCyUCQqFMqqsZBPiAmJzBFYou4O5caYRoTh
 gYrCift/MFv6bniyt9lJKJhKf7zabk2UrhkUVMfxYuIIRqkTRA9xP1Ro6a93CF6AgMLNVUDTVTt
 KuhF2gWdwT4MO/a5Vz/afMQmnvUfSF8E6nz9G2yJyVvoTh6fsF4=
X-Proofpoint-GUID: 36xs33OVOnegd0vV-YFNUZSb6OKvQcJI

DQoNCj4gT24gT2N0IDI5LCAyMDI1LCBhdCA2OjIy4oCvQU0sIFRob21hcyBHbGVpeG5lciA8dGds
eEBsaW51dHJvbml4LmRlPiB3cm90ZToNCj4gDQo+IEFzaWRlIG9mIGEgS2NvbmZpZyBrbm9iIGFk
ZCB0aGUgZm9sbG93aW5nIGl0ZW1zOg0KPiANCj4gICAtIFR3byBmbGFnIGJpdHMgZm9yIHRoZSBy
c2VxIHVzZXIgc3BhY2UgQUJJLCB3aGljaCBhbGxvdyB1c2VyIHNwYWNlIHRvDQo+ICAgICBxdWVy
eSB0aGUgYXZhaWxhYmlsaXR5IGFuZCBlbmFibGVtZW50IHdpdGhvdXQgYSBzeXNjYWxsLg0KPiAN
Cj4gICAtIEEgbmV3IG1lbWJlciB0byB0aGUgdXNlciBzcGFjZSBBQkkgc3RydWN0IHJzZXEsIHdo
aWNoIGlzIGdvaW5nIHRvIGJlDQo+ICAgICB1c2VkIHRvIGNvbW11bmljYXRlIHJlcXVlc3QgYW5k
IGdyYW50IGJldHdlZW4ga2VybmVsIGFuZCB1c2VyIHNwYWNlLg0KPiANCj4gICAtIEEgcnNlcSBz
dGF0ZSBzdHJ1Y3QgdG8gaG9sZCB0aGUga2VybmVsIHN0YXRlIG9mIHRoaXMNCj4gDQo+ICAgLSBE
b2N1bWVudGF0aW9uIG9mIHRoZSBuZXcgbWVjaGFuaXNtDQo+IA0KW+KApl0NCj4gKw0KPiArSWYg
Ym90aCB0aGUgcmVxdWVzdCBiaXQgYW5kIHRoZSBncmFudGVkIGJpdCBhcmUgZmFsc2Ugd2hlbiBs
ZWF2aW5nIHRoZQ0KPiArY3JpdGljYWwgc2VjdGlvbiwgdGhlbiB0aGlzIGluZGljYXRlcyB0aGF0
IGEgZ3JhbnQgd2FzIHJldm9rZWQgYW5kIG5vDQo+ICtmdXJ0aGVyIGFjdGlvbiBpcyByZXF1aXJl
ZCBieSB1c2Vyc3BhY2UuDQo+ICsNCj4gK1RoZSByZXF1aXJlZCBjb2RlIGZsb3cgaXMgYXMgZm9s
bG93czo6DQo+ICsNCj4gKyAgICByc2VxLT5zbGljZV9jdHJsLnJlcXVlc3QgPSAxOw0KPiArICAg
IGNyaXRpY2FsX3NlY3Rpb24oKTsNCj4gKyAgICBpZiAocnNlcS0+c2xpY2VfY3RybC5ncmFudGVk
KQ0KPiArICAgICAgICAgcnNlcV9zbGljZV95aWVsZCgpOw0KPiArDQo+ICtBcyBhbGwgb2YgdGhp
cyBpcyBzdHJpY3RseSBDUFUgbG9jYWwsIHRoZXJlIGFyZSBubyBhdG9taWNpdHkgcmVxdWlyZW1l
bnRzLg0KPiArQ2hlY2tpbmcgdGhlIGdyYW50ZWQgc3RhdGUgaXMgcmFjeSwgYnV0IHRoYXQgY2Fu
bm90IGJlIGF2b2lkZWQgYXQgYWxsOjoNCj4gKw0KPiArICAgIGlmIChyc2VxLT5zbGljZV9jdHJs
ICYgR1JBTlRFRCkNCkNvdWxkIHRoaXMgYmU/DQoJaWYgKHJzZXEtPnNsaWNlX2N0cmwuZ3JhbnRl
ZCkNCg0KDQo+ICsgICAgICAtPiBJbnRlcnJ1cHQgcmVzdWx0cyBpbiBzY2hlZHVsZSBhbmQgZ3Jh
bnQgcmV2b2NhdGlvbg0KPiArICAgICAgICByc2VxX3NsaWNlX3lpZWxkKCk7DQo+ICsNCg0KDQot
UHJha2FzaA==

