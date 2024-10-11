Return-Path: <linux-arch+bounces-8012-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A36D999979
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 03:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD068B20F87
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6389450;
	Fri, 11 Oct 2024 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hjNRFRFU"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021114.outbound.protection.outlook.com [40.93.199.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8068BE8;
	Fri, 11 Oct 2024 01:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728610494; cv=fail; b=qGtKSb2bjKd1xPAWBO0Wd/2du+cqIoXvKwB9sGZDKGv8M/cJAezf/nhZaEK5wz36Y4fMgNjiLT6LxQxFXWM5HnrMUeX8+4C24i4KMBwm38+fqIyLDMQn+Xba2v4kD7ZNNYBepdsmenZ6kNpnZ13ZYktbFNM4Pq6aoPaHhqaoVrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728610494; c=relaxed/simple;
	bh=y78aC1MOJO1KgVzKLNy0pdE4j5F2xRW40CAPLjNwurg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FVWT0csRBhSB5QROqZ8JkPo1eW/apbYc7eYdyuVZBqjKuGvUUzJj0Xan/gm0P18TT7kt+AeDZIxyBzLo8dGIzYkoQLdAI6TxlQ/6NNxp6n5bp+ovoYIL7rSAqC3JoNCPygsIeMiF6GnK5TxcxxzNldA5aVQenjVwEwJHbTZFMWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hjNRFRFU; arc=fail smtp.client-ip=40.93.199.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKbHILYloUvJkW/zB8bm5KlZ5y9RHtGmkcOk/o8FUPd9kbNU3wVD3P6bx5sx9QjaL3OhM7IuG64GA/fya+SOeaM5FegS/AFhGKqz0RUpymFUd65vaS1y1zovX4Zc2IjRGJATwlqvQWVYjSgXjkmFfbeIk+EtatuIAu1wlQG75l3ectu5EVC18kTyaBs1mY2Fw8HXRqOd63YP1aiGZgMGZuMuI1y1wHCJkNOO2Xssym4Br+nFVdM9eN/x2slC2cWk3m67gIrXA1sXgiRjO21GXF8cvFhKZbtuAwaUjIAKcmIXxImK4nUAbtfP+3dH0JmsUkVUjjlULYifGL9pNGplxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y78aC1MOJO1KgVzKLNy0pdE4j5F2xRW40CAPLjNwurg=;
 b=cad9cFzOfE2xNq7p1Etq0DN+FfhLOw3OtZgodnvq1AFeTRXP8fgiA3u2WX0aIhbQyv3O/M36Tibp+dVZwv3Rd8m6W2qiT9NunHGqOc7h2jlpRvG7S6XMNFXnAqZRHCDQVb+wvtHM2UYKMxhJAC3XzmgUq5X97AlBh6yw5ObKhY1OvBoVJHcXW17Skqde3/pwTZOPjwaSyKkdIT3Bo8jlR6xMb/Y0pDPvmkjJ+0PJ36obPJVAbmJ6JdblbYMHxKitUPOYEo7ixzUUndyqA13gd52zJMZOr9ZYLvEix52ZyH2nRUdeOFCD1N8l+CZ1su3b7roWwwij4R7XXAFFpkomAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y78aC1MOJO1KgVzKLNy0pdE4j5F2xRW40CAPLjNwurg=;
 b=hjNRFRFUwIQK5bVT8alckIuyutzt0g6/GDPmcA5i5dzyHIpeqP0ee2rz7EggUQ3jDbAI87a2imX4Ve3EykCZldQfthquadwKq3SosPXaijpARLl3CmZBGdDaAM3Nl0l7uxyj6VspwJshAbpNWfMte9UPvfhbANXu3B04uQ8knpo=
Received: from DM6PR21MB1434.namprd21.prod.outlook.com (2603:10b6:5:25a::10)
 by DM4PR21MB4542.namprd21.prod.outlook.com (2603:10b6:8:66::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6; Fri, 11 Oct
 2024 01:34:50 +0000
Received: from DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd]) by DM6PR21MB1434.namprd21.prod.outlook.com
 ([fe80::790a:4e07:a440:55cd%6]) with mapi id 15.20.8069.001; Fri, 11 Oct 2024
 01:34:50 +0000
From: MUKESH RATHOR <mukeshrathor@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>
Subject: Re: [EXTERNAL] RE: [PATCH 3/5] hyperv: Add new Hyper-V headers
Thread-Topic: [EXTERNAL] RE: [PATCH 3/5] hyperv: Add new Hyper-V headers
Thread-Index: AQHbFc2fpELizClC20+KdB1By4J6TbKAVvmAgAB48YA=
Date: Fri, 11 Oct 2024 01:34:50 +0000
Message-ID: <3432a47a-0936-9d1a-896f-d1e019905131@microsoft.com>
References:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-4-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415716A55D46E5D4F37D7DD2D4782@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415716A55D46E5D4F37D7DD2D4782@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1434:EE_|DM4PR21MB4542:EE_
x-ms-office365-filtering-correlation-id: f1a4eb0c-2ce5-455e-92e3-08dce994e5da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnFZZDNPNFlxK0hDTzIvZ3F2YVNwbXoydzI0Q0VqL1h6Z2FlUUliYmgzZ3JU?=
 =?utf-8?B?V0Nhb1BLZmxLS0k3TjN1S0YxcFdScFJSaHYvR3hmNlhqSzN3L2FpNE9xK1Z1?=
 =?utf-8?B?b1ZRa00vSk5ISy93K0xTSHFNZC84N2o3SCswSnJVWXpkelJMZE8vcFg0S1J5?=
 =?utf-8?B?d0RJdStBaE56SFdKdlV5MzliMTByS0JDOUlIeG81UUlvQkZ3cTdGQjZKTnow?=
 =?utf-8?B?UDY3ZDJ4eVVDV3R4VDZSaGtFK0JndU8rb0dVUng1SGZ0VzlwWTVoS0lxQ3hw?=
 =?utf-8?B?ck9UaDhIQXpZdUtNRXJHWW1LdGVMNlpsOG90bWJ5czVJaTdrL1ArMCtaRkU3?=
 =?utf-8?B?SGhlT09wVkd1WXZ2aUZ3V0lhRFV4V0lTMmJ0Mk1US25LNmsxaHNXMEN3eVZz?=
 =?utf-8?B?NmJjWHFVaFMyNmFtMjdqTXZlckVzZ21FYjk1RkhPUVVIcFpLNyt3ZlRSWGJK?=
 =?utf-8?B?cVJ2MXJYSDlHcmFEMEZIUGFoYUMwWlZUN0RoUElkUVBCYVhoMjdpbnZsZVQy?=
 =?utf-8?B?QzJQeXN0bmtyaEVjRC9UbEhaTE9Jbkw3TGlJYjZveGNaUk5QVUVDcHF3WGRF?=
 =?utf-8?B?M1kySGQ0bXl2clBZOXBTMmtrMGxMZktmS25NQ1M5U1lPYVFSMGhQMlJmc3hI?=
 =?utf-8?B?d1Raa1M1QUQrOVpKUW1nZ3lMNkZ1dWhlSis2UHpvMFA2Wm9Zak9pN2NwNm9u?=
 =?utf-8?B?anFpMTFzUi9QMG1HaXJNa0Zua0c0MmREaHV1Y3VlR29HQjRFdUMya2ZPc2h2?=
 =?utf-8?B?NHhYWi9UWnFEdjhZbzlDY0RUMTlra3c1U0RGclVrNlZEdUVXd0ZVSGp2SU5k?=
 =?utf-8?B?cWRFT3dPaWNSajhReHhvRjVNb05LYW8xOGl0cC93RDdPSFVBRTNHNW5GdCtH?=
 =?utf-8?B?bmR4RW0rTUhuRjNPTGNjTWIwYi8xenROM29tdDNoc1c2dWYzMldXTWtSR2c1?=
 =?utf-8?B?UHd1bkNIZGRyTHFMOCtVVFIyNXp2UWd0UFQ3c0RQY1YxTHV3d3RObkhPNlhS?=
 =?utf-8?B?QlhkQXZQdXlyc1pheG5PZ2NqQXpUODFLQ0xyWU5QQk9pWU92eDhQUTU3cWJJ?=
 =?utf-8?B?NUpPNEk0eDNHb0U1L1U1WTlHa09FYUk3Y3RDWFQyRFcrNFdWY25XNVMrWWxT?=
 =?utf-8?B?VGE5Z0pwUVY2MDdRdGp0ZHQ4QVhkaUo2Q3JLc1RCdkNhNHRiZjVUUzR2emtQ?=
 =?utf-8?B?VmlPczROVkNXTFY1bCtrZmhQa0wxTnJvV09NUnY2VURtMHhLNnY5d2hySE50?=
 =?utf-8?B?emdySVM5V2VDVzBya0RHYlBtaGVzSjRPYjhJQWdSWGsya2NyNHNPYXBRcHd5?=
 =?utf-8?B?UnJQdmpFQUhGZmYvc3E4bEV0cHp6TFpBODFWampOQWR2V3JBWFRsQ0UxckRz?=
 =?utf-8?B?RmlQcGhGUHNpUWxnblpTS25DOHR6L2Uwb0RRSEFjWWQxeStjeXlDYkZnME1Z?=
 =?utf-8?B?SklpSG1WSVdpS0M1NlF2VE5KTTBkSUFadkFVYWlRT2lXcWxrZmZod0M4NDBD?=
 =?utf-8?B?NnYyYUsxNDFDZ05qTjBXdGFwWDN3cndlclRpNUczWXFFWnQyNVd2OFJCTXhC?=
 =?utf-8?B?TitVb2ZaRDVmSDFDK1RJWTdRa2hkRG1CUnh0UzVTQU0zMkY0c0k2cnZualhj?=
 =?utf-8?B?SmhNMUNPM0t4QlBpdFZZWmJQeDQ2dzhEaUlaQnFkSkRlYkc3SVJ1cVNWOHpI?=
 =?utf-8?B?U1UxNDY4VVhsZTJUK2R5Sm1nT1FpNnBYaW5KRGM3eCtuRDhMUm0vcUVSL2dB?=
 =?utf-8?B?cFhHekwwcjF0bk1kaUlBV1BzMHZXWTNmNWVBOGpSQWtjWHdBK2loeE85OUNy?=
 =?utf-8?B?SXc2UzhYY3UrTEx4d3REdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1434.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K05pTmpDSWVLNlJmT3dPaWZpQlBKTjdQYzgrUU9BRE02OHpLWlZFU1UrZlNH?=
 =?utf-8?B?YVRtNXh4dnVuWTQrZi93WERXeGJSWGs4UGl6Q1d6dkZGQ0MwdzE3aHBnMWtN?=
 =?utf-8?B?OVlMZWwrRnZ2UjJKQTgyWGUyUEt3bGQ2Y3Q5OVhZL3A5elpYQllhTmxtWjBq?=
 =?utf-8?B?UVhRdmFaY3JHcWlZL0JESTF4R3VrQzBORnhjQzNqUkdMUkYwNFFlTzVTODZi?=
 =?utf-8?B?bGdlMVFMNGhSRHJZVlI4QXc2eklKQmIxSEpVTndvYldxRFJvT0dEQTJyenFt?=
 =?utf-8?B?eTB1SGFmTFkrVTdzUEExdkpvSFVXOG1kaVkvd0puK1pLZWlWeVdBeDNSVXND?=
 =?utf-8?B?VHJFVHFMd3lOUGJFSEx5NzBaV2RjRExEVzFRT2tJVnF1ZUFyUjhnbXI0V2cx?=
 =?utf-8?B?cTRhcUFUTDlrTFpGcU01SlFEK2JmcEZSVnZ6c01iaXp3bDhiT3pFKzFEQThm?=
 =?utf-8?B?eC9URllqb1B3Nkx6TkNhK3BGdHI0S3Q2SDdpZmhIaTAyRFZGTUhZQngxMkw3?=
 =?utf-8?B?ZjUxZ1dPRlZ2djlPYmg4TG9wNjg1OGtvRU42YnNoUkRqZTA4bDd1eVNNNHBO?=
 =?utf-8?B?bUp5Z1FVNElCVk8wTkloYWhRUzI1Z242bjA2L1VpK25rSGpaRjIranl2MVdX?=
 =?utf-8?B?ckpmbHorVTJRSlhoZ3FEc3RKTmtwMVV6UGZLVktUNk1GankxaTZndEZtWC96?=
 =?utf-8?B?OW5IK3puUUl1VDVkMjY2bFdVUXJkRFl5cyt4YUhSRzhvbzlvd2JhV2F5QlBV?=
 =?utf-8?B?aFROZTliaDRKa2RJVktFWGxvTjZicjk2UWlGbk0vQ0lPTnAvNnF0YjQ3ZDZK?=
 =?utf-8?B?TXR4OVU4L0VKMXJYNTFUMFkvU0wxYmNZREsxaUdQamdrYVhnWFpyWWlqYnpi?=
 =?utf-8?B?ejEydmUyYzNGd2tEbnJTL3QvRkhoc3QyMUh4UTJhQzZTRUZzZnBDcUVIU2Z3?=
 =?utf-8?B?L0VVaC9DYlVBWW9jZ2JuQzJ0WUNPMmNuREYxeTd3V3dlYVRPR2ZSeHNGaUFx?=
 =?utf-8?B?VjZvTjJKVTRGWkorM2dXNEFGZzRjVHArOWlScko4UU1heDllaUMwVFF6TVFk?=
 =?utf-8?B?czBsUldIWWZFZWVIek5ycmNQejhHeHVkajB5WDBKT0RqV1ltb0JjZzY3eXRs?=
 =?utf-8?B?dXo3NW5CSTB5THRNWVVwS29EKy8vcXlVTXdjdnZBbXBnWlpqNnNrTnRmVldO?=
 =?utf-8?B?NnBqRGJMNnVZZUhEUmhvMTM5b0w0ckY2VkJoUERSd3BueitmdnBENVRySW5o?=
 =?utf-8?B?RU9Fcnk4TTUwTW1vYjUxcnJGdWZKMm5xcm81ZXR5R2NmeG02VGRRalZjcmdq?=
 =?utf-8?B?akhIRFc1S2V1eWgvVlVlNnZJUERoSjd3aTE5ZmVOZ3drTjRlMlRMUFMzdFhP?=
 =?utf-8?B?WmljbDhOdkZ0KzlhQWpDaWdXVUY0TktWQTc1b3FiQWFUQU5WWkl1ejR5aVpm?=
 =?utf-8?B?K2NKdGVOYzFjS2wvY09vZ2F0K0tSSmVhZlkyRFRGaWh1dWYvRDNzS2duVkU0?=
 =?utf-8?B?S05aaGEyeEFKaHdqckgxZ3ZtVjc5VFlqSzQyRW9lWVVqSmF6YzkzN0x4K2lm?=
 =?utf-8?B?bkF0ZHJKTG9Ob2h0Y3R3UXBCMmZmSjBEVTNpZ3R3eko3UnBwT09qRDQzbGtv?=
 =?utf-8?B?RGVHbGkvUUZZU3IrRkE5UnY4cGszZFdLMkxTbDJGcVE1dWZnM0w2em9rdytL?=
 =?utf-8?B?b3I2Z0UwQjBwb1NCK1dkS1lTUHFpNXZxRDZ6cEJLR1JNQlpEOXk1NkRlcDd5?=
 =?utf-8?B?SXdVenF3bWltMHZ4U1dtMjUwQ2F2bVJxTThudzZBb3lwK05HVWZXWkFoVFlN?=
 =?utf-8?B?VzA3NW9hbHhva29WR0ZoZXczNWlGM21aUkFtVWFvay9MWkNoR3FKdGRHeHZl?=
 =?utf-8?B?enVkSjdidFRHdk43c0k2UWhxUHhha2s5MEIxM1JoU1VJVGRkN3ZVV1Z3MnRn?=
 =?utf-8?B?a0NuUEl3YUpkcjFNU3dOdUcyRHVtOGNaTWkwR3h5QmVBS1g1bGYySVRQbzQr?=
 =?utf-8?B?eGZGQmx4blpwajd3c2NRNXQyRFZobmQ4MGIwdmpTblUvYVg1NTY1MHBGcGV6?=
 =?utf-8?Q?qx+FW4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5803F32AA60C3D46A97C6CC53BDD2CDC@namprd21.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a4eb0c-2ce5-455e-92e3-08dce994e5da
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2024 01:34:50.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuDshbOl4a9qA/5W0ypo+eYvUqVrNVbmCNbU62c+vQuplPcSbAP6XHnni/YUJ6ztmQ3J5W4f4Bd0FJNTDdPKQI9GX5QRMb87oRWIFE1zR5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB4542

SGkgTWljaGFlbCwNCg0KSSBjYW4gYW5zd2VyIHNvbWUgb2YgdGhlIHF1ZXN0aW9ucyBzaW5jZSBJ
IGluc3RpZ2F0ZWQgdGhpcyBlZmZvcnQNCndoaWxlIGFnbyAoeW91IG1pZ2h0IGZpbmQgb2xkIGVt
YWlsIGNoYWluL3MpLg0KDQoNCk9uIDEwLzEwLzI0IDExOjIxLCBNaWNoYWVsIEtlbGxleSB3cm90
ZToNCiA+IEZyb206IE51bm8gRGFzIE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogDQpUaHVyc2RheSwgT2N0b2JlciAzLCAyMDI0IDEyOjUxIFBNDQogPj4NCiA+
PiBBZGQgZGVmaW5pdGlvbnMgbmVlZGVkIGZvciBwcml2aWxlZ2VkIEh5cGVyLVYgcGFydGl0aW9u
cy4NCiA+Pg0KID4+IFRoZXNlIGZpbGVzIGFyZSBkZXJpdmVkIGZyb20gaGVhZGVycyBleHBvcnRl
ZCBmcm9tIHRoZSBoeXBlcnZpc29yIGNvZGUuDQogPg0KID4gQ291bGQgeW91IGVsYWJvcmF0ZSBv
biB0aGUgbmFtaW5nIGNvbnZlbnRpb25zIGZvciB0aGUgbmV3IGZpbGVzLA0KID4gYW5kIHRoZSBy
dWxlcyB0aGF0IGdvdmVybiB3aGF0IGdvZXMgaW4gd2hhdCBmaWxlcz8gU3BlY2lmaWNhbGx5LA0K
ID4gd2hhdCBpcyAiaHZnZGsiIHZzLiAiaHZoZGsiLCBhbmQgd2hhdCBhcmUgdGhlIF9leHQgYW5k
IF9taW5pDQogPiBzdWZmaXhlcz8gRXZlbiBpZiB0aGUgZmlsZW5hbWVzIGFyZSBkZXJpdmVkIGZy
b20gV2luZG93cw0KDQogICBodmhkayA6IGh5cCBob3N0IGRldmVsb3BtZW50IGtpdA0KICAgaHZn
ZGsgOiBoeXAgZ3Vlc3QgZGV2ZWxvcG1lbnQga2l0DQoNCklPVywgaGRrIGZpbGVzIGluY2x1ZGUg
ZGF0YSBzdHJ1Y3R1cmVzIGZvciBhIHByaXZpbGVnZWQgVk0sIGFrYQ0KZG9tMC9yb290L2hvc3Qs
IGFuZCBnZGsgdGFyZ2V0cyBhbiB1bnByaXZpbGVnZWQgVk1zLCBpZSwgZ3Vlc3RzLg0KDQpUaGUg
X21pbmkgaW1wbGllcyB0YXJnZXQgaXMgaG9zdC9ndWVzdCBrZXJuZWwsIGFuZCBub24tbWluaQ0K
dGFyZ2V0cyBWTU1zLCBidXQgdGhhdCBhcHBlYXJzIG1vcmUgaGlzdG9yaWMgYXMgb3ZlciB0aW1l
DQp0aGluZ3MgbW92ZWQgZnJvbSBrZXJuZWwgdG8gdXNlciBzcGFjZS4NCg0KVGhlIGh2Z2RrX2V4
dCB3YXMgY3JlYXRlZCBmb3IgZXh0ZW5kZWQgaHlwZXJjYWxscy4NCg0KUGxlYXNlIG5vdGUsIHRo
ZXNlIGhlYWRlcnMgYXJlIHB1YmxpY2x5IGV4cG9ydGVkIGJ5IHRoZSBoeXBlcnZpc29yDQphbmQg
Y29uc3VtZWQgYXMgaXMgYnkgV2luZG93cyB0b2RheSAobm90IHN1cmUgYWJvdXQgQlNEIGFuZCBv
dGhlcnMpLA0Kc28gY2hhbmdpbmcgdGhlbSBpcyBwcm9iIG5vdCBmZWFzaWJsZS4NCg0KLi4uDQog
Pj4gVGhpcyBpcyBhIHN0ZXAgdG93YXJkIGltcG9ydGluZyBoZWFkZXJzIGRpcmVjdGx5LCBzaW1p
bGFyIHRvIFhlbiBwdWJsaWMNCiA+PiBmaWxlcyBpbiBpbmNsdWRlL3hlbi9pbnRlcmZhY2UvLg0K
ID4NCiA+IEknbSBub3QgdW5kZXJzdGFuZGluZyB0aGlzIHN0YXRlbWVudC4gVGhlIG5ldyBmaWxl
cyBpbiB0aGlzIHBhdGNoDQogPiBhcmUgb2J2aW91c2x5IGZvbGxvd2luZyBMaW51eCBrZXJuZWwg
Y29kaW5nIHN0eWxlLCB3aXRoIExpbnV4IGtlcm5lbA0KID4gdHlwZXMsIGV0Yy4gSSdtIGd1ZXNz
aW5nIHRoZXJlIHdhcyBhIGxvdCBvZiAiYnVzeSB3b3JrIiB0byB0YWtlDQogPiBXaW5kb3dzIEh5
cGVyLVYgY29kZSBhbmQgbWFrZSBpdCBsb29rIGxpa2UgTGludXgga2VybmVsIGNvZGUuIDotKA0K
ID4gV2hhdCB3b3VsZCAiaW1wb3J0aW5nIGhlYWRlcnMgZGlyZWN0bHkiIGxvb2sgbGlrZSwgYW5k
IGhvdyBpcyB0aGlzDQogPiBhbiBpbnRlcmltIHN0ZXA/DQoNCkNvcnJlY3QsIHRoZXkgYXJlIGN1
cnJlbnRseSBub3QgZGlyZWN0bHkgaW1wb3J0ZWQuIFRoZSBjb2Rpbmcgc3R5bGUNCmlzIGRpZmZl
cmVudCBhbmQgYWxzbyB0aGUgaHlwIGlzIG5vdCBidWlsdCB1c2luZyBnY2MvY2xhbmcuIFNvLCB3
ZSd2ZQ0Kc29tZSB3b3JrIHRvIGRvIGJlZm9yZSB3ZSBjYW4gdXNlIHRoZW0gYXMgaXMuIEZvciBu
b3csIHdlIGhhdmUNCiJtaXJyb3JlZCIgdGhlbSBtYW51YWxseSBlbmZvcmNpbmcgTGludXggc3R5
bGUuIEdvaW5nIGZvcndhcmQsIHdlDQpoYXZlIHRvIGRlY2lkZSBpZiB3ZSBjYW4gdXNlIHRoZW0g
YXMgaXMgKHRoZXJlIGlzIHNvbWUgcHJlY2VkZW50IGluDQpsaW51eCBmb3IgZHJpdmVycyBpbmNs
dWRpbmcgaGVhZGVycyB3aXRoIGRpZmZlcmVudCBjb2Rpbmcgc3R5bGUpIG9yDQp3ZSBjYW4gYXV0
byBjb252ZXJ0IHRoZW0gdmlhIHNvbWUgdG9vbCBvciB3ZSBjYW4ga2VlcCB0aGVtIG1hbnVhbA0K
YW5kIG1vZGlmeSB0aGVtIGluIHN5bmMgd2l0aCBoeXAgbW9kaWZ5aW5nIHRoZW0uIEluIGFueSBj
YXNlLCBpdA0Kc2hvdWxkIGJlIHJhcmUgb3BlcmF0aW9uLiBNYXRjaGluZyB0aGVtIG5vdyBhbGxv
d3MgdXMgdG8gZ2V0IHRoZXJlLg0KDQpZb3UgYXJlIGNvcnJlY3QsIGl0IHdhcyAiYnVzeSB3b3Jr
IiwgdG9vayBtZSBtb3JlIHRoYW4gdHdvIHdlZWtzIGluDQphZGRpdGlvbiB0byB0aW1lIE51bm8g
YWxzbyBzcGVudC4NCg0KID4gQWxzbywgaXQgbG9va3MgbGlrZSB0aGVzZSBuZXcgZmlsZXMgdGFr
ZSBhIGRpZmZlcmVudCBhcHByb2FjaCBmb3INCiA+IGluc3RydWN0aW9uIHNldCBhcmNoaXRlY3R1
cmUgZGlmZmVyZW5jZXMuIFRoZXJlIGFyZSBpbmxpbmUgI2lmZGVmJ3MNCiA+IGluc3RlYWQgb2Yg
dGhlIGN1cnJlbnQgbWV0aG9kIG9mIGhhdmluZyBhIGNvbW1vbiBmaWxlLCBhbmQgdGhlbg0KID4g
YXJjaGl0ZWN0dXJlIHNwZWNpZmljIHZlcnNpb25zIHRoYXQgaW5jbHVkZSB0aGUgY29tbW9uIGZp
bGUuIE15DQogPiBzZW5zZSBpcyB0aGF0IExpbnV4IGtlcm5lbCBjb2RlIHByZWZlcnMgdGhlIGN1
cnJlbnQgYXBwcm9hY2ggaW4NCiA+IG9yZGVyIHRvIGF2b2lkICNpZmRlZidlcnksIGJ1dCBtYXli
ZSB0aGF0J3MgbGVzcyBwcmFjdGljYWwgd2hlbiB0aGUNCiA+IGRlZmluaXRpb25zIGFyZSBkZXJp
dmVkIGZyb20gV2luZG93cyBIeXBlci1WIGNvZGUuIEFuZCB3aXRoDQogPiBvbmx5IHR3byBhcmNo
aXRlY3R1cmVzIHRvIGRlYWwgd2l0aCwgdGhlICNpZmRlZidzIGRvbid0IGdldA0KID4gd2lsZC1h
bmQtY3JhenksIHdoaWNoIGlzIGdvb2QuDQoNCldlbGwsIHdlIGFyZSB0cnlpbmcgdG8ga2VlcCB0
aGVtIGFzIGNsb3NlIHRvIHRoZSBvcmlnaW5hbHMgYXMNCnBvc3NpYmxlLiBCdXQgbm93IHRoYXQg
bGludXggc3VwcG9ydCBpcyBoZXJlLCB3ZSB3aWxsIHdvcmsgd2l0aA0KdGhlIHByb2R1Y2VycyBv
ZiB0aGVzZSBoZWFkZXJzLCBpZSwgdGhlIGh5cCB0ZWFtLCB0byBtYWtlIHRoZW0NCm1vcmUgbGlu
dXggZnJpZW5kbHkgZ29pbmcgZm9yd2FyZC4gR2l2ZW4gdGhlcmUgYXJlIG90aGVyIGRpcmVjdA0K
Y29uc3VtZXJzIG9mIHRoZSBoZWFkZXJzLCBXaW5kb3dzL0JTRC8uLiwgaXQgd29uJ3QgYmUgcmln
aHQgYXdheSwNCmFzIHdlJ2QgaGF2ZSB0byBjb29yZGluYXRlIGFuZCBtYWtlIHN1cmUgYWxsIGFy
ZSBoYXBweS4NCg0KSG9wZSB0aGF0IG1ha2VzIHNlbnNlLg0KDQpUaGFua3MsDQotTXVrZXNoDQoN
Cg==

