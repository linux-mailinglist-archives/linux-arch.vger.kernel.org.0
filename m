Return-Path: <linux-arch+bounces-10309-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DBEA3FF0A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 19:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAF118986DA
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289C2080F6;
	Fri, 21 Feb 2025 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="XMHPQFdU"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11020108.outbound.protection.outlook.com [40.93.198.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA81D7E50;
	Fri, 21 Feb 2025 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740163639; cv=fail; b=dq0R9AOVvE9NRBxkHkJn1SA2krZ8bjcSVY1VEhmA3470cBNkiV6CIwkrBe6lKAuf66Q+GzEMQkwbI+r/i5JMPvXqpDul5z6zhcalnzWx/kxu2cEsH7+6eHKuVKzDQ/BeZ8a18shepRCYCDa8K+/4LTSwbAC+r2PN3WPYzZm4R9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740163639; c=relaxed/simple;
	bh=Tr9ZWg6Ei67ZUZor98qFO1BgoOfiqvGhJe9ngGEa1QU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O2bBsQEXi0Vc9B+mXaboYSoql5446PtsdLMGDqBKB/2ZTYiC/tb5H9t+LBzbuRvseFG6NgMvLuuWv03Log3EfmejGJnDkuCKggKSGw9EH166KlW1F/Bo/V5YTKc5xmJMd01ekIKaviDOjX+cwjhtaKa2TkwxgZriiWK9dF1r6gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=XMHPQFdU; arc=fail smtp.client-ip=40.93.198.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drw4dIv+qU2u1W0uIdZszDUpmrdY1C8ifEaQAZEA5AscLaZ6P6b4uqr0CIgryaAjJT08rW8jyGcAWP739Ml7sQGiUVUfDICbj+MDCCkcew3BbxVhwxYyVine6YjJVpvpLgSfNP8+z0aDEiaqnn8f7Y0OSaoISOg4qpuYGVzJRH7Ae4Y5NrHFWhUAi2BoMMIa6RbVeJIYxC6a2z+Ara3mhQgfzUF8HBhRRP1EHeRmLby9KhQ/bcx8hfRkNn5YtSKdfb/4riUNyWJxq/uY8ZdqSfXWBQkdP0X9Fud44Ld3HeIEbB6uVc3B7F3VeGjyz0q0JG8g+caO9mXdt5a43G3EcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr9ZWg6Ei67ZUZor98qFO1BgoOfiqvGhJe9ngGEa1QU=;
 b=Uh70KoWo0Oy+fjfexURgRdMlNCIvyYOJv8Dtzl0efa+Lmfp5RiVinUBOqKom0cXsOz3XtvJlPQl0ugDFpGF2Rdm7OKcEY1+oh9L6v8dkehUqhLu8iTzrzV8EoyARcb0Clsq3sKIca48Eh6YlcwhyzlJNR8iUQzZB1/QbM46rXYEc1ns5RlkklTeYXzleNhrqHBmvn/J9Q3GGZ+puMTp60xDnTRnlxtPlX7lYCI/c4AGB1adEbSwOboBv3vjK4Xe9EdzWmvOYWKQvXL2RB4GffWe2JziiYtgzmkbNwce02D1dTX0vRzeLfG4jZ8JXM0V4cq5kOjEWqRhg7ld834Qklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr9ZWg6Ei67ZUZor98qFO1BgoOfiqvGhJe9ngGEa1QU=;
 b=XMHPQFdUHNXsedPWQVZgtsjwoYokjqKC1bIghJRje3yUdTdN4lPG9mCklcBqiIjBiVnXd0AiegK8c9RrIEvk61Vy6cT+ZTzG3nDxvKrxxRYV/w05LPgGm3WIP9uPyn20tPz8dT+YadMSB8MUpWMYaReGxFZw8TIKwP5eIOPLMXU=
Received: from DM6PR21MB1434.namprd21.prod.outlook.com (2603:10b6:5:25a::10)
 by DM4PR21MB3297.namprd21.prod.outlook.com (2603:10b6:8:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.13; Fri, 21 Feb
 2025 18:47:12 +0000
Received: from DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd]) by DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd%4]) with mapi id 15.20.8489.009; Fri, 21 Feb 2025
 18:47:12 +0000
From: MUKESH RATHOR <mukeshrathor@microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "mhklinux@outlook.com" <mhklinux@outlook.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>
Subject: Re: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
Thread-Topic: [PATCH v2 2/3] hyperv: Change hv_root_partition into a function
Thread-Index: AQHbg8X7D+BhCLhaE0W3GmwFogL1arNQvd4AgAAQDYCAAADHAIABQWgAgAAKYoA=
Date: Fri, 21 Feb 2025 18:47:11 +0000
Message-ID: <1706b682-6ab2-6f2d-989a-97434621fc84@microsoft.com>
References:
 <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-3-git-send-email-nunodasneves@linux.microsoft.com>
 <5980eaf9-2e77-d0ec-e39b-b48913c8b72f@microsoft.com>
 <a29af204-e4a9-4ef2-b5b8-f99f2ac0a836@linux.microsoft.com>
 <f5366d52-1714-87bc-5fa5-94230f2acca1@microsoft.com>
 <5ae3454f-61e4-4739-816c-20525e2087be@linux.microsoft.com>
In-Reply-To: <5ae3454f-61e4-4739-816c-20525e2087be@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1434:EE_|DM4PR21MB3297:EE_
x-ms-office365-filtering-correlation-id: 657e5c6a-c1cb-4d10-95b3-08dd52a8270f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnoxejJBMnFLajVoOWxMbkxza1YxM3dpVGM1S0ZJcjhZMGg3bnBHTkNkaXpI?=
 =?utf-8?B?VVFsT21JTHIrYkhnMy94bGJONDBuc1MyVlNJR2tFREJZc3diNkR6V2E0T3hv?=
 =?utf-8?B?bFRabWtqY0FkcEhxY3F1bXJBRGtpK0RBdEJ4RDdZR0k3WXlwM3RqclE4MkxY?=
 =?utf-8?B?UEVkbU03dDFnb2xQTHAvTWczMTJFZ3E1Y1BORG0ySXhHL3FEaHRlakFFb1Rl?=
 =?utf-8?B?ekY1cWRjT3M0VlI0bjFLaTFsMFpnMys3ZGxYNjlsTEpWZDJmRnpmN2tTdEk1?=
 =?utf-8?B?eGhoYUY3b1ZjVTZaODQ2ZzIxWHdhcTNUS0NxeEF6YkcwMVlDMDJ5VnhiVUZp?=
 =?utf-8?B?ZHA5bVpXeUs4SzR5cys5YUVtSXJIQ1hvYkJpZ2NkaDhJRklxWkErZnBFcjVN?=
 =?utf-8?B?SUtwYXplbk9qNnJaTXVrdXNmQ0M0ckh0eFBjbDcwTnRQMXFYQ2J6dUt1VUw4?=
 =?utf-8?B?eUVhRklDVytyM3B5eW9qN28zSDFCODNQalN0dWhBVWV3LzJsSkNFWmdGTDYv?=
 =?utf-8?B?ZXh3MTcvb0VVQnRYdTVJUFZtMGtObVpTT2Fjb1RZWVpkb0tFTXAzTDYvV0tF?=
 =?utf-8?B?d095YUFyT0JaZ3BEQ3pqWFpFZTJxcG5CaVluQjFSejZqWEIremtTeU9TMHZX?=
 =?utf-8?B?ZlhveUNTM2pNcmpjenI2M2NpZWlJcmJKYVRpM0JrenVLc2NQZk1VTHJyL0tW?=
 =?utf-8?B?SGJKUk8ramJGV0ZSWUdCeDJvM2JjMlBKdGxyR3h4MlhQNkJrbW9PcXp5WXdx?=
 =?utf-8?B?S0djWGRXT2xvOGdIMkQ1Nlk4MEZoWGJTSm1pdDBxQlJPQ1ptTWQzQmhqVDRF?=
 =?utf-8?B?bHA4TnNZcHA2TTdKOS9iZm1hay92N0RRZjNyczBwSDBlZVRBcEl6WkdhcU5j?=
 =?utf-8?B?d2pEb3BEVjJHS2kvRERJbWhGRGJTemdhNExqOXBHZlJveWpoTW5pc2U1Tytq?=
 =?utf-8?B?MHpIcGNhSUwrYkRnL1dReXhKNEV4RDZFY3NtdVZYbWE2MlZWTExxdnVrdVU3?=
 =?utf-8?B?SjNsWHJBRnVCSVljeFh1V0E5NlA1ZW5nWVkwM3MwVHkvYTFjV3MyRkdnRHpv?=
 =?utf-8?B?TllSZjl3RlFJenBRaWZuWTNUVDFJUFRFUmZGcnJmbDBQTmVrN0NhUjlaTDNP?=
 =?utf-8?B?V29BMlkxWEQvQ0JSWlQyM05YYU82MGV6QkZ3SG9oWTB2dHN1VWpMcGxqVFkx?=
 =?utf-8?B?My92UjJrNDk5T2hOOWxsNjBlUFpqc1JlMEU1cUZNQXJjelphMTI3TzNUZnNs?=
 =?utf-8?B?U3B0a0FsZk1TdWtNSWtTZlZkd0JORmpKMFFHdFVYQVBBWHpkNDZCWXI0RmZL?=
 =?utf-8?B?ZW5OQ25lcGJJdnZxYmYzbmFZVmNYR3F3Q0dpb3Q3aEM1ZnQ2UktoaWk2NHZE?=
 =?utf-8?B?eUNsTnR6V2JLR0t5alFZbGN5RW42eW80MXZXdkNYL1NxNzV1ZU5hQ1oyMXhn?=
 =?utf-8?B?YkgvTGgzU25pcTBTdGlxMUFpUFdhUEt6WUxDSlBmYWFPbzN6V0xzYnJoQytq?=
 =?utf-8?B?RlZXZm5uRTAwZGxsWUVDMVRSdGhhbzA5SThkSitQNm1FR2lvRDZXMjhtSUUz?=
 =?utf-8?B?NFFzbHVYYWZYREJmQjdNNnpHTHd2M2wvNWJlS1FQN2Fmak5VMWxqcmpKd1RD?=
 =?utf-8?B?NXRuSS9QN21ScmZPa0JGZThQSE9TRlNqeWxHU0ptcnFHdmNjVHBFK3N0K0dn?=
 =?utf-8?B?VzZRalVxQUxlcnA4VDRTbER6b2Fjb3BwVUl1YnhCUHlIa2VzaklzTFJHK25W?=
 =?utf-8?B?T2Voc1NjQzZ2MERPNGYrNkY4YVBJOWxBYjFOa1JuRGtZcFpYUE02Q2ZkT1Rm?=
 =?utf-8?B?RHg0WlJTUzVEbHFJL0U4WHBPempPQ2x4NnZldkJPUmwrNSszUTFKeWFHVkkw?=
 =?utf-8?B?MkIxb3UxZ3gxZnMrOEVHWDRNd0I4LzlxSDJqOEE5Y1lzSnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1434.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmxGN3FKQmQ0WjFEOTZhbGxIamE0d3BWYzlQTWZJZzJ2VHJMb2ZvWElvTEk4?=
 =?utf-8?B?TEdqZlZXWTg0RjlyTXVaVnFOMDhmK2RKUzRscXU2bXp3ZmFkaDkvWGYvd0ZP?=
 =?utf-8?B?T2NMekwvTGUraGQ4enJCUVVPeTh2M2ZKemladmt2N1ZBekVubGpzVXRnbi9u?=
 =?utf-8?B?WTZoUGVQd2UxMzdnR05ycGV6eTNtQTlmUlZ6Yyt4OFVrZEdSUTdYRFkvcXhs?=
 =?utf-8?B?T2JTcFVCaDFxVWozbERzbHY5ZHdNN3NDdnVwa25YWmo4YWZaY3hMY2Z1NjBU?=
 =?utf-8?B?Qi9xQlFNeEhpU0JwMnZBVFM1dWxOZ3AyOHkxeldvejYwMFV1OTByd0g5TXd4?=
 =?utf-8?B?bCtjSHI0REs1YVV4WnhOR1BxL0o1WlJlMlExU2JKTVhJekZEWENIbEhyVExL?=
 =?utf-8?B?Vjk5Nm01SEZhTndFNUdqZVJYZ3lGdTR2aHRDWjlDeWxxREl4alBJeFNnNC9k?=
 =?utf-8?B?K3c5UERxOTFUeVFqMzY4UFRNSHNmby9xaGxYdkx5TENTTTNIL1pUaUtkYUlV?=
 =?utf-8?B?QW84M0NtMDZNd2ZiY1BZamREVFpmbU5lcWE5OGNwT3lMZllXTVczaE1qV1hx?=
 =?utf-8?B?OUtBMXFYMVV4eVFlcHp4aFFMOWhuVFBGclFIaEgwMERWVERkK25QMFpOa0V0?=
 =?utf-8?B?ZVJuWWROSWIvV2YxOVJwNitKajNBVXdUd1VzM2RDTEsxV0R3akN1RXRsa2px?=
 =?utf-8?B?L2VCaUgxRlJoQnRkVnFxMFFoeDdIUE5xY3o2U0JSUTNTRWpJa1krb08wa3U3?=
 =?utf-8?B?OHFLY2RXdnk5NkRDcUY2a0M0ZWlnY0NDQ3VyZkZOM3hsRVF0QnlnWW9DWHZq?=
 =?utf-8?B?SC9ncFdpOUNhQ1R4RHFpSzdQamJ6d2w4NmNZdmtyWmFmbDFxQktQTlJwR21o?=
 =?utf-8?B?KzFiTFo3K3FYVXdLYTRVRG9oRVdxM256WFBqUGNSbTdRMDN6L3NzL2ZYU09k?=
 =?utf-8?B?c2QrY1pHUHBYaVNBNzdSVnk0ZExSY2hiQjBRcnQrdXloWnhDSnJlaDU0ZVJs?=
 =?utf-8?B?cnFtYXNTSGZsZGVkaDRTNmdDb3puQ2c0NVRYRSsyc2VLVjNKUDJOV2c5ZGlj?=
 =?utf-8?B?bEkwc2VycHNLQnJJcXBWQ0h3NkNhTjR3dzM1bVY3RXQzODVKbVh1czhhbENK?=
 =?utf-8?B?ZmNMeUdQQ1dmMXlRMGFYc2I0UHMrMHJSd3VHK2pqV0Q5MjhLbDdhRXZvOGM2?=
 =?utf-8?B?WjZHSUZsQjZZWmp4R0t0NzdqRlBRTWRtNHp2RHo3TmtxWlk5QlF6QS9jRVpW?=
 =?utf-8?B?c0lZcHo3WW8yVXVkMDJhQ0N1Q1lxcjFLRG5hVWdaSmtJUy9PYjBVc25VYnFp?=
 =?utf-8?B?d2JDOXY3ZXNiT0JrS3FmSVlIbmlaOW4reGUxa1AzS1NrN2ExRitEc3VMTUhR?=
 =?utf-8?B?ZVgrM3RnN0Z4TUIxQnVhcGFYUTlSRmY0ZzVIRFZTY2RhL2lzM3J5dGlTMGNy?=
 =?utf-8?B?RVIzUmlCaGczNHpIRjNjdDNMUHJZT1ZCWGY3Nm5WQkc2U3h6TndpeGZlTlpF?=
 =?utf-8?B?YVF3WXl6V1kyTmdFc1BWakx3ZGJhM2NnNndBQW9Db216bUNsaFZUWVBDNjFI?=
 =?utf-8?B?VTUrU0dzbzVZZWx6dGoreVd2NXdMdFY0SnIrbmR0cFB5RXhMeTRhMXIvR001?=
 =?utf-8?B?TG5jS28ybUVhbFFOMk92a0xINWlkSWFRK3lvNXM4N2R3RUkzWk95YUErcWdy?=
 =?utf-8?B?N29EZ0ZNZnpDNXZybVgwL2FhZ2x0OUdTbFh1RUpOMUlldFJUNHl3TTFQV3dm?=
 =?utf-8?B?eHMwRlRWdjdWbWpZYUd4cS9pK1ArK3JtRUVhRXludFFjSUFYYnVLSk1yQ29x?=
 =?utf-8?B?b0xxMHkwcDhmS0pVUmw5aHg1RlJPTEpNNzdDK0tDQ3F4b1dEdEdlbXZnVzEv?=
 =?utf-8?B?d1hwWllqVTk1eC9tc2szVkluWXpqNjliR2lzMlRwYmFLRzRxQk1qMzJUbUFx?=
 =?utf-8?B?NkpYcVhsRGRBNFRVQnV0MG5XNFNmVFZKMk1pdG9UZFJSR01Yc2VlMmhvcUcr?=
 =?utf-8?B?ZzZyTHNrZlpHZDVKR3J6dG9QejNIQnQ3SHNlZ2k1L2JadG51Q0hsWkRYU1k3?=
 =?utf-8?Q?vqR38f?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3C3257CA16FCE4290E8F69FADD5A6A1@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1434.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657e5c6a-c1cb-4d10-95b3-08dd52a8270f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 18:47:11.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLJSBll+/kNHqA/GOLdQqxKjr1eCf2bSANhBJH6MKzZ7+8h+z3R7jWM+X+K3CjEBNSddlUu6RH4PIq7OAE7pQnZ12CIVMlrRFcEF8zPSbvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3297

DQoNCk9uIDIvMjEvMjUgMTA6MTAsIE51bm8gRGFzIE5ldmVzIHdyb3RlOg0KID4gT24gMi8yMC8y
MDI1IDI6NTkgUE0sIE1VS0VTSCBSQVRIT1Igd3JvdGU6DQogPj4NCiA+Pg0KID4+IE9uIDIvMjAv
MjUgMTQ6NTYsIEVhc3dhciBIYXJpaGFyYW4gd3JvdGU6DQogPj4gICA+IE9uIDIvMjAvMjAyNSAx
OjU5IFBNLCBNVUtFU0ggUkFUSE9SIHdyb3RlOg0KID4+ICAgPj4NCiA+PiAgID4+DQogPj4gICA+
PiBPbiAyLzIwLzI1IDEwOjMzLCBOdW5vIERhcyBOZXZlcyB3cm90ZToNCiA+PiAgID4+ICAgPiBJ
bnRyb2R1Y2UgaHZfY3VycmVudF9wYXJ0aXRpb25fdHlwZSB0byBzdG9yZSB0aGUgcGFydGl0aW9u
IHR5cGUNCiA+PiAgID4+ICAgPiBhcyBhbiBlbnVtLg0KID4+ICAgPj4gICA+DQogPj4gICA+PiAg
ID4gb3B0aW9uIHRvIGdhdGUgdGhlIGNvbXBpbGF0aW9uIG9mIHJvb3QgcGFydGl0aW9uIGNvZGUu
IEluDQogPj4gcGFydGljdWxhciwNCg0KPHNuaXA+DQoNCiA+PiAgID4gPHNuaXA+DQogPj4gICA+
DQogPj4gICA+PiAgID4gQEAgLTM0LDggKzM0LDExIEBADQogPj4gICA+PiAgID4gICB1NjQgaHZf
Y3VycmVudF9wYXJ0aXRpb25faWQgPSBIVl9QQVJUSVRJT05fSURfU0VMRjsNCiA+PiAgID4+ICAg
PiAgIEVYUE9SVF9TWU1CT0xfR1BMKGh2X2N1cnJlbnRfcGFydGl0aW9uX2lkKTsNCiA+PiAgID4+
ICAgPg0KID4+ICAgPj4gICA+ICtlbnVtIGh2X3BhcnRpdGlvbl90eXBlIGh2X2N1cnJlbnRfcGFy
dGl0aW9uX3R5cGU7DQogPj4gICA+PiAgID4gK0VYUE9SVF9TWU1CT0xfR1BMKGh2X2N1cnJlbnRf
cGFydGl0aW9uX3R5cGUpOw0KID4+ICAgPj4gICA+ICsNCiA+PiAgID4+DQogPj4gICA+PiBuaXQ6
IGlmIHBvc3NpYmxlIGFuZCBub3QgdG9vIGxhdGUsIGNhbiB3ZSBwbGVhc2UgdXNlIG1vcmUgVW5p
eA0KID4+ICAgPj4gc3R5bGUgbmFtaW5nLCBlZywgaHZfY3Vycl9wdGlkIGFuZCBodl9jdXJyX3B0
X3R5cGUgcmF0aGVyIHRoYW4gdGhpcw0KID4+ICAgPj4gbG9uZyB3aW5kb3dzIHN0eWxlIG5hbWVz
IHRoYXQgY2F1c2VzIHVubmVjZXNzYXJ5IGxpbmUgd3JhcHMvc3BsaXRzLg0KID4+ICAgPj4NCiA+
PiAgID4+IFRoYW5rcywNCiA+PiAgID4+IC1NdWtlc2gNCiA+PiAgID4+DQogPj4gICA+DQogPj4g
ICA+IFBlcg0KID4+DQpodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL2NvZGluZy1zdHls
ZS5odG1sI25hbWluZw0KID4+ICAgPg0KID4+ICAgPiBHTE9CQUwgdmFyaWFibGVzICh0byBiZSB1
c2VkIG9ubHkgaWYgeW91IHJlYWxseSBuZWVkIHRoZW0pIG5lZWQgdG8NCiA+PiBoYXZlIGRlc2Ny
aXB0aXZlIG5hbWVzLA0KID4+ICAgPiBhcyBkbyBnbG9iYWwgZnVuY3Rpb25zLiBJZiB5b3UgaGF2
ZSBhIGZ1bmN0aW9uIHRoYXQgY291bnRzIHRoZQ0KbnVtYmVyDQogPj4gb2YgYWN0aXZlIHVzZXJz
LA0KID4+ICAgPiB5b3Ugc2hvdWxkIGNhbGwgdGhhdCBjb3VudF9hY3RpdmVfdXNlcnMoKSBvciBz
aW1pbGFyLCB5b3Ugc2hvdWxkIG5vdA0KID4+IGNhbGwgaXQgY250dXNyKCkuDQogPj4NCiA+PiBU
aGFudCdzIGhhcmRseSBhIGZhaXIgY29tcGFyaXNvbi4gU3VnZ2VzdGlvbiB3YXMgTk9UIGh2cHRp
ZC4NCiA+Pg0KID4gSSdtIGluIGZhdm9yIG9mIHNob3J0ZW5pbmcgdGhlIG5hbWVzIHdoZW4gdGhl
IGFiYnJldmlhdGlvbiBpcyBjb21tb24gYW5kDQogPiB0aGVyZWZvcmUgc3RpbGwgcGVyZmVjdGx5
IGNsZWFyIHRvIGFueW9uZSByZWFkaW5nIGl0IC0gZS5nLiAiY3VyciIgaXMNCiA+IGEgcGVyZmVj
dGx5IGFjY2VwdGFibGUgYWJicmV2aWF0aW9uIG9mICJjdXJyZW50IiwgaW4gbXkgdmlldy4NCiA+
DQogPiBJIHRoaW5rIGFiYnJldmlhdGluZyAicGFydGl0aW9uIiB0byAicHQiIGlzIHByb2JhYmx5
IG5vdCBhIGdvb2QgZml0IGZvcg0KID4gZ2xvYmFsIHZhcmlhYmxlcy4gQW55b25lIHNlZWluZyBh
IHZhcmlhYmxlIHdpdGggdGhlIHdvcmQgInBhcnRpdGlvbiINCiA+IChhbmQgaHZfIHByZWZpeCkg
Y2FuIGdvIGxvb2sgdXAgd2hhdCBhIEh5cGVyLVYgcGFydGl0aW9uIGlzIGlmIHRoZXkgZG9uJ3QN
CiA+IGtub3csIGJ1dCAicHQiIHdvdWxkIGJlIGNvbXBsZXRlbHkgaW1wZW5ldHJhYmxlIHdpdGhv
dXQgcmVhZGluZyB0aHJvdWdoIGENCiA+IGZhaXIgYW1vdW50IG9mIHRoZSBjb2RlIHRoYXQgdXNl
cyBpdCB0byBmaWd1cmUgb3V0IHdoYXQgaXQgcmVmZXJzIHRvLg0KID4NCiA+IEkgdGhpbmsgZXZl
biBzbGlnaHRseSBsb25nZXIgYWJicmV2aWF0aW9ucyBsaWtlICJwYXJ0IiwgInB0biIsICJwcnQi
LCBvcg0KID4gInBydG4iIGFyZSBub3QgZ29vZCBlbm91Z2ggdW5mb3J0dW5hdGVseS4uLiB0aGUg
d29yZCAicGFydGl0aW9uIiBqdXN0DQogPiBkb2Vzbid0IGxlbmQgaXRzZWxmIHRvIGFiYnJldmlh
dGlvbiBpbiBhbiBvYnZpb3VzIHdheS4NCg0KVGhhdCBpcyBmaW5lLCBJTU8uIFdlIGxvb2sgYXQg
dGhlIGNvZGUgb2Z0ZW4gZW5vdWdoLCBhbmQgc29tZSBuYW1lcyBsaWtlDQp0aGF0IGdldCB3ZWxs
IGVzdGFibGlzaGVkLiBGb3IgZXhhbXBsZSwgcGZuIG9yIGN1cnJlbnQgZm9yIGN1cnJlbnQgdGFz
ay4NCk1vcmVvdmVyLCB0aGUgcHJlZml4IGh2XyogbmFycm93cyBpdCBkb3duIHRvIGh5cGVydiBy
ZWxhdGVkLiBPdGhlcg0Kc3VnZ2VzdGlvbnM6IGh2X2N1cnJfcGFydG5fdHlwZSBhbmQgaHZfY3Vy
cl9wYXJ0bl9pZCBpZiB5b3UgZG9uJ3QNCmxpa2UgcGFydCwgcHRuIGV0Yy4gSSdsbCBsZXQgeW91
IHBpY2sgd2hhdGV2ZXIsIGh2X2N1cnJfcGFydGl0aW9uX2lkIGlzDQpkZWYgYmV0dGVyLiAgSW4g
dGhlIGVuZCwgY29uY2lzZSB5ZXQgdW5pcXVlIGVub3VnaCB0aGF0IGFueW9uZSBjYW4NCmVhc2ls
eSBmaW5kIGFsbCByZWZlcmVuY2VzIHZpYSBncmVwL2NzY29wZS9ldGMgd2l0aG91dCBSU0kgOiku
DQoNCiA+IFNvLCBmb3IgdGhpcyBwYXRjaCBJJ20gZmluZSB3aXRoIGNoYW5naW5nIGl0IHRvICJo
dl9jdXJyX3BhcnRpdGlvbl90eXBlIg0KID4gd2hpY2ggc2F2ZXMgYSBmZXcgY2hhcmFjdGVycy4N
CiA+DQogPiBGZWVsIGZyZWUgdG8gcG9zdCBhIGZvbGxvd3VwIGZvciAiaHZfY3Vycl9wYXJ0aXRp
b25faWQiIGlmIHlvdSBsaWtlLg0KDQogPiBOb3RlIC0gRm9yIHRoZSBkcml2ZXIgY29kZSB3aGlj
aCBpc24ndCBhcyBleHBvc2VkIHRvIHRoZSByZXN0IG9mIHRoZQ0KID4ga2VybmVsLCBJIHRoaW5r
IHdlIGNhbiBjb250aW51ZSB0byB1c2UgInB0IiBvciBzaW1pbGFyIHRvIGtlZXAgdGhlIG5hbWVz
DQogPiBzaG9ydGVyLg0KDQpUaGF0J3MgYSBnb29kIGlkZWEuDQoNClRoYW5rcywNCi1NdWtlc2gN
Cg==

