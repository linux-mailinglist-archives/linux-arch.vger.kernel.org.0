Return-Path: <linux-arch+bounces-11423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AC6A92183
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0101D3AEC9A
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FDF253B4A;
	Thu, 17 Apr 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XUYLLGZJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2019.outbound.protection.outlook.com [40.92.41.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93924DFF3;
	Thu, 17 Apr 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903682; cv=fail; b=QS79PV5QVut1beRFcd8vY9h+Ek7MAgypgO1oPhS6fLMS5KGbkHE4x1Ve39USC9WBVc3lh/Vp4zA9ogwQ2th4gBBLdQ5JoU5vAKitULMHNZOhhxL+u7QNEZM59kzurr5zB3i2xZNod4egVh6WxEtUmSXerm72/5DvQE6AMcnz77E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903682; c=relaxed/simple;
	bh=HKJoMbGUtP9JuD/sh2OZDPfCoCBPZMdoP5ZQrmPUTjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GvMqpaZl4DnREALkz+SbX5cKzFwf4h65PxMIQNx0uCDV1+bZp7Hv0AlmeNV2uypGMd7SIWl8fIdpkqqEDpMzw3ZtM61wtSD7QdRiADtse+LJIvvmghoz84/B9hw0Myvdi5/cd0R+zii1VsB7SxIeWxdXzr5NPd13SH9AcTWOTII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XUYLLGZJ; arc=fail smtp.client-ip=40.92.41.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i26VqlbsQd2+OknwFMVGF2RKJG+d97NwFN+oeVVPLcztKT0UyZvwolpRj/mRfDayO8MnNEtu/O5odXC7b4fPp/QbTopPeBuAPmY+zYybVJ4PLoxvJWs3SNCX3uYZ60HACqHNA4cskir+I2U+7IKbDiBWE/Y0Bmq53BURU9tEphuy+QqTItTMfqkkiFy2U/nl42D209we5Js+cOSNeZwNSYAx5Z31eFlJdq7X1sOyv3DMa3m4bdKwTSvHBx8/wkusecMmCZ96XdBRwTDXluOUroqYPnXX1ro7W2MNrDo3KCu1ocDMFdKyAym5saGXTjCBD9DD57m5hkJcz1IK+7WtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKJoMbGUtP9JuD/sh2OZDPfCoCBPZMdoP5ZQrmPUTjU=;
 b=t6Q5X6OaejULSLNLzo9uJALwJveCWReM/d0bFF/wDzE7AmuQJyGMvm5mCsjfZ9fcQDGnmOyEYt44PMCdu5YnvdHWUlcN7+zoKOxSJoeTm0B622l8D/dZXL/tOGmfKwKPFL0B4iVJaMtSHxTLfXKGJAklDODYTaILdwXfaECPpGxsHCSOccQvENfwMY86YF+iaE4qELzKgjcjMJzV+1ZVKPQ94aOme0Vx3ftP8D5hG3bIASHjxAMooqCqmYCPfMdM6ZXlPMU+gm0R/jIz+D/ES24OIbm1kev/UWx6CGM7+ZkPwCMUOhp/yNmyZxnb7bfcz9lETAb2Ca+vLJInegvvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKJoMbGUtP9JuD/sh2OZDPfCoCBPZMdoP5ZQrmPUTjU=;
 b=XUYLLGZJPY/iC+hg/dqbzNxZSHJ4ui7FAfsQ38GlrRxeHGI7Lis+hRAmNx60rP9xSWV7OscOWu3+ofyWDoLfUrNyy3U9Xcdd9657Il+qo7Z1nVoVo647YzNr+gwb1OR2JsIZJ2CpixkAZNfYLufAD15in+bjUglVibSt84OUsGdAd3J4hvkuw7+VaJ6WgfurX4kO53tTh+6bGmdL6A5wy2uF47C0oAn+kcMTO7mQuj5CUwO2kABwtoNIhaOfHFVGVyjLBOQQQrgCAxT6I7DF3Eq4x0T3nlmxblZCCaAjUszAl/E7jXGJcxL1ogQpQDEviSQZrn76avmzmnRR3joiVg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8209.namprd02.prod.outlook.com (2603:10b6:610:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 15:27:58 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 15:27:58 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v8 03/11] Drivers: hv: Enable VTL mode for
 arm64
Thread-Topic: [PATCH hyperv-next v8 03/11] Drivers: hv: Enable VTL mode for
 arm64
Thread-Index: AQHbrY9v+cXc6xEnBEiBA4yWQWEMjbOn91pg
Date: Thu, 17 Apr 2025 15:27:58 +0000
Message-ID:
 <SN6PR02MB4157E2387F07BE02566D0D7ED4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
 <20250414224713.1866095-4-romank@linux.microsoft.com>
In-Reply-To: <20250414224713.1866095-4-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8209:EE_
x-ms-office365-filtering-correlation-id: e7d7cc8b-e71c-4ed5-3143-08dd7dc46ecf
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmpI8tRyoOXaSUmOkLVCBKasgPDN4Gql4NEFIrmUE7Cn01gjc8CI7VNqmPh51nQ8dR+u/bF9CA/wFWJcFde0HYEeBT1B1KqY2HJRKMQtc0I9F06i7LiQHKxt+m/+3JqzFLFEa63i9Yf6tFYBZA5WSjnGpleyw+dXRlHDOLyQz9eTnTRf2t9vkAOEJK2X/WkC8gOxIWZRXZbZeL7xsxt9/kuGAbl6njvoefX7yDh/XCl5Bi6Bu/1nuISCUcAqnLC0GUwUTu9nBSwKAcx/sa6ZadeU25PV7wXbtc3BM2V4cz33NLA8nfoDZihImi+a8Kb28ngI+3IXSBAK9KTsecruBDhyKnRZYe2nFtVxYekA8GSNdZUCNdCpC0WJiuOiFbdrWAr/YYIy0CaIVOGpgl64JMtUm8IByTC46zJZQIaQQqsez6gjQ2nhHGYNPuqduSHVhie9SPVkZZwvAlycHblgCLB/83iIylq1MgBg4NehcR1oF7Fs549F0gbEYF2pDlYV6KmIR4ItxpeeQdLFJIdfdYbiD89Wd7GzhmQ+eh5ELwBspIy7UpsTX5akVmAimdbrVX5l6jYyIoYN4CwV1w59051Afn/kkuUkGHgfM4QUzktgqYMX62Y9wZyTQSSAdHgb+j8qZTtwZ9xmmUi2hI8zIpnw7mPaxqy2DQqQm30nXq7vrPypOB8q+ucizuhK2ckqsqarhb74AEAkfRhMCfhUCsFUnN4ajVOETCLSWbXOQe8EjGnmdDglJTEOpbKs7aHwNaE=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uno5Myt1RTF3T0J3eHJwT0tCSHYxQzREdVB5MnM0ZThncUxsVmg0OGFqQXdt?=
 =?utf-8?B?SWpBcmN4M21ZejhkQ1dRMTlpc2Y0V0tXUEJGRDFhWVJ4OEdSb29SOGFxcVVy?=
 =?utf-8?B?ZmJlaC9HWFBXbjFVNlVIYlUvNGwxYUk2ZGJCMm8zR2VjaTRvaTF1NVpaVnhw?=
 =?utf-8?B?bS9VcklMUHU4NzFpQXVUSTdNcVNYbjFjZEZQbWZKaEFjN3NWZmU1K3BibEJZ?=
 =?utf-8?B?ZjNVVmg5MXdpblNBZWphUjg4TnNkb0FWTXhTMmRXT1c5eHhIci9iVFhuUlph?=
 =?utf-8?B?QWYvOElpYjM5bjA2dXlIcnpqd2N3Um5md3hMby81YWFsNmtNMStDZEdDZWdh?=
 =?utf-8?B?RDArZ1kxaXBIUC9GWDdMRGdwdmNoZ3p2QWtiM2FvYWx3akZvWEgrRFFtcko0?=
 =?utf-8?B?ajA0Rm1URlNoSmxuS3FCL1ByenlndHE0dzJHRmdmR0Z0ZmMvRDVvRmJ3ZUhy?=
 =?utf-8?B?eVN4VFhCMDlxMTlhYXlGaXRCTys1Vjk4aGdZTmQzSXduVGw0ZktlUEptcW56?=
 =?utf-8?B?MzBUYlVnbzU5bHowVE1qYkZOVTVBMTJYWGlPOFYzYjVhUWVueFFuZjV3UERu?=
 =?utf-8?B?RmhsT2tLOFh6Sk1temg5c2JHaE81SkhBd00xOGdLVm5USkNyTlpZNU45djZQ?=
 =?utf-8?B?aUkybGltaU54U1ZaTmJBQ1ZLR0Y5OWNiS2VGOXFqNjNQVjFwbndPbEhiUGJ3?=
 =?utf-8?B?TlU0UVRrZXdWU0k1MWVCV0VhbGdQWjNkMjduWEErZENacnRrUFk3eW9oNGhk?=
 =?utf-8?B?eTU3L0VYRWpQNldsMm95L2FMYzdneVRHcEo0b0gxS0Zjd3FUMzNBMGIzRDZW?=
 =?utf-8?B?Z3pKM2ZjNGtBYlJpK3YwdXNqYkJDNHBKRExaLzkvUXI1VG5SbnlLZzBSWFZ2?=
 =?utf-8?B?cVlEd2hSa2hXOUtNUyt0TzArOTN0UlNGcTJSdUdVa1hHVzd6a2xKWlNURkM3?=
 =?utf-8?B?NG93M1F6S0NGNFhuWEJhNW9HSUZleDk4bVZaYmY3Q3RKaW9pZC9uMkhPUTBv?=
 =?utf-8?B?K1FTQ3hUc25VUHRHaWZjcDZINDA0UHc0QUE3V3VDa21BdlFzVmE5ZzBoQ2ti?=
 =?utf-8?B?N3dpbGdOYjJpZ3VFQ2t1Y256cFVjbldLZVp5cy9qbkdrK1lEcStIenNoelVE?=
 =?utf-8?B?QU1YdzZySnZBUklzMms3ZU5ERU5FUXhtSVRCY0lZSTBvUDh2MTlXbUhDQ3Jl?=
 =?utf-8?B?N2ltRkgzS0dpQWpGZXdkeHVySjVBKzFVRlpReDJvNUFzY25JZG5nUkR1aWVl?=
 =?utf-8?B?WlJCMEo0ZWtPK29GcllvREFEVk4zZDAvS2V4QUFibithMi9vS1IzV3gyMTdU?=
 =?utf-8?B?RTlZUGR2WXp2M1ZXUkhFTDJOR2FmMitsc3BibVRJaytNUmNkN3dUVFBSSGpk?=
 =?utf-8?B?eC9pMTFXazJEMlpldVlleW83R3RUeWJjeTlRV1p4QnVxWXFZZFZjUmJOSTdq?=
 =?utf-8?B?ZEJzUmE4clczN25hZmV2MVJpZWI2SUhueEcwNW1BPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bnhPSkZMbUNxZXNycHptRVlnMkJYU3VWZDh6T05oOEllNzRsTkxhSkV3eERv?=
 =?utf-8?B?QlFVejJGS1JwNTBBb0I1L3Zlb2owQU9WcURIUzI5NVVXTFpEd0g3VlVhMzZz?=
 =?utf-8?B?MmZaYzV6WmlYSTRCWUJZakFXSlZ1YUYvbGtTODRGS2dSVXFKeGNkM29wUm1F?=
 =?utf-8?B?citoNlMwL3dBSHBiK1FMb1l4cmNya3NBWnlFMEFNTDF1NVdwUnl4TVA4Y1Jo?=
 =?utf-8?B?K3pMQ2o0NUYzVGtHQUx4Q2p5alRXU3FwQThhc09iZmVabzZjSXkwU0RUS252?=
 =?utf-8?B?Y3JXeXhuSXQ4SC9pK3VHbnozRTRLWXZoQ2pwZXZUYTMxQjhxQ3MzS0NzU0Zw?=
 =?utf-8?B?bVQ0RWEwSUVoZ2plWEVzeWZ6L3NLVXZlSkp2N1hwcmtHbkdueTNESGRGMnV6?=
 =?utf-8?B?d0xFSVdiOWJlaUhZM2VHTjRQVjlXN1pTNVRFbVNMdHZTMTlPUUNqbGZNRGhn?=
 =?utf-8?B?bnNmWUcxV0hScU45MVRVNy8ybnJ2V0lvQ1F5T3VyYW0xUXhWS3BQYy92bEZC?=
 =?utf-8?B?QWRNbnRZWjJlS3FjL0NoUGh3TnZHd3JkQlNTSFNBMjFQSSszei9ub2J6WXFF?=
 =?utf-8?B?SFE5RXljVFpqd2NLdGdTeDMwRXhWdWVSNmx1UUJ1ZkxRNTRaTy9ENGEyQjVB?=
 =?utf-8?B?NS92WUtCb0R1c3JSSmJBWHI1WCtWN0lsMnNEcFRoaXM1dTIzOWU3T0NMN3Bu?=
 =?utf-8?B?bUx1WjNrbHpybkFCdFV5RndaS3pTb281bGwybjNtUWFYZzdONTZ2MTNiYVlm?=
 =?utf-8?B?RVRYY25DMkxRbTRRTW1HM2NIQmxjRWhyVWpPVDA5djlqbTlhNWZJaGYxS0Fp?=
 =?utf-8?B?TGVmbC9sWFZ2eDVwZnFqVGRDdVErdi9RQXV4SWtsZGQzSUNuU2FJSHZLQ2p3?=
 =?utf-8?B?bXJhd2J4a2xJVHdwRFFidERxeFJyaGo2QjJMOWNkQm84dTN5bDE4SjBvVXRY?=
 =?utf-8?B?YVpzNkhvWWJoNUNMcVMyZGx6OG81WFNraHIzZjJPcVl6VW9RZ1BwVXEraWlq?=
 =?utf-8?B?cU04SkVFanlFdWVaNGlyVW0rZHJockx4S3l6Yzh6UlBaaFNtaHpXWXorWkNu?=
 =?utf-8?B?dDFqKys1QUtiZ2tSelBVZDBZUjFaeWxkem15TFdGY2tSM1k1Sk04Z3R5TlF1?=
 =?utf-8?B?cVJSVmF6ZktKVHZPNTloKzZlNStjWGNYOGdPUFpyNjBMc25NMnhRQ2RuYmZN?=
 =?utf-8?B?c3VhV2gzVTZEMytDRCtueHEvb3d4cUphUkgyaW5rUEc5NUYxWGJyRTFvSVIw?=
 =?utf-8?B?VEY3T2tMdWlyWUF5ckI3UC9jZHlYNldUSXQ1NERHWHNaUlR1b05uS2pzd2hr?=
 =?utf-8?B?ekU0VXF6cmpvQzlkeHBFN25kNjk4SEpXbENVUVNUTEx6L2hEcXpUUHlRUHFn?=
 =?utf-8?B?K09yUVo5RVIxak8xRWNWdVlBeEl3ZjlIR0haUVVqenFLU0huUzg4cHBicmhU?=
 =?utf-8?B?MzNvOEZ5anZiaEhCeFZnSVNHVS9qSkp5WkRSUGZjdW1HR1Z5OGdINi81eGo5?=
 =?utf-8?B?K2wvaWR4c1hjcVV6UEdRcHBsNmVzeXlFL1MxbHNaME9EeDl1QjJiMnVRdVZZ?=
 =?utf-8?B?UWNwaDY0OFpqRXp2d0hFS0ZNSVJ4R042ZTlKeEZoazJ3ZkxJbk9FUHp5V3BI?=
 =?utf-8?Q?bITbIMSLISYO/LvRFEwuimszhQ6guJCPusOd9UXXDzyM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d7cc8b-e71c-4ed5-3143-08dd7dc46ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 15:27:58.2516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8209

RnJvbTogUm9tYW4gS2lzZWwgPHJvbWFua0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25k
YXksIEFwcmlsIDE0LCAyMDI1IDM6NDcgUE0NCj4gDQo+IEtjb25maWcgZGVwZW5kZW5jaWVzIGZv
ciBhcm02NCBndWVzdHMgb24gSHlwZXItViByZXF1aXJlIHRoYXQgYmUNCj4gQUNQSSBlbmFibGVk
LCBhbmQgbGltaXQgVlRMIG1vZGUgdG8geDg2L3g2NC4gVG8gZW5hYmxlIFZUTCBtb2RlDQo+IG9u
IGFybTY0IGFzIHdlbGwsIHVwZGF0ZSB0aGUgZGVwZW5kZW5jaWVzLiBTaW5jZSBWVEwgbW9kZSBy
ZXF1aXJlcw0KPiBEZXZpY2VUcmVlIGluc3RlYWQgb2YgQUNQSSwgZG9u4oCZdCByZXF1aXJlIGFy
bTY0IGd1ZXN0cyBvbiBIeXBlci1WDQo+IHRvIGhhdmUgQUNQSSB1bmNvbmRpdGlvbmFsbHkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb21hbiBLaXNlbCA8cm9tYW5rQGxpbnV4Lm1pY3Jvc29mdC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9odi9LY29uZmlnIHwgNiArKystLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9odi9LY29uZmlnIGIvZHJpdmVycy9odi9LY29uZmlnDQo+IGluZGV4IDZjMTQx
NjE2N2JkMi4uZWVmYTBiNTU5YjczIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2h2L0tjb25maWcN
Cj4gKysrIGIvZHJpdmVycy9odi9LY29uZmlnDQo+IEBAIC01LDcgKzUsNyBAQCBtZW51ICJNaWNy
b3NvZnQgSHlwZXItViBndWVzdCBzdXBwb3J0Ig0KPiAgY29uZmlnIEhZUEVSVg0KPiAgCXRyaXN0
YXRlICJNaWNyb3NvZnQgSHlwZXItViBjbGllbnQgZHJpdmVycyINCj4gIAlkZXBlbmRzIG9uIChY
ODYgJiYgWDg2X0xPQ0FMX0FQSUMgJiYgSFlQRVJWSVNPUl9HVUVTVCkgXA0KPiAtCQl8fCAoQUNQ
SSAmJiBBUk02NCAmJiAhQ1BVX0JJR19FTkRJQU4pDQo+ICsJCXx8IChBUk02NCAmJiAhQ1BVX0JJ
R19FTkRJQU4pDQo+ICAJc2VsZWN0IFBBUkFWSVJUDQo+ICAJc2VsZWN0IFg4Nl9IVl9DQUxMQkFD
S19WRUNUT1IgaWYgWDg2DQo+ICAJc2VsZWN0IE9GX0VBUkxZX0ZMQVRUUkVFIGlmIE9GDQo+IEBA
IC0xNSw3ICsxNSw3IEBAIGNvbmZpZyBIWVBFUlYNCj4gDQo+ICBjb25maWcgSFlQRVJWX1ZUTF9N
T0RFDQo+ICAJYm9vbCAiRW5hYmxlIExpbnV4IHRvIGJvb3QgaW4gVlRMIGNvbnRleHQiDQo+IC0J
ZGVwZW5kcyBvbiBYODZfNjQgJiYgSFlQRVJWDQo+ICsJZGVwZW5kcyBvbiAoWDg2XzY0IHx8IEFS
TTY0KSAmJiBIWVBFUlYNCj4gIAlkZXBlbmRzIG9uIFNNUA0KPiAgCWRlZmF1bHQgbg0KPiAgCWhl
bHANCj4gQEAgLTMxLDcgKzMxLDcgQEAgY29uZmlnIEhZUEVSVl9WVExfTU9ERQ0KPiANCj4gIAkg
IFNlbGVjdCB0aGlzIG9wdGlvbiB0byBidWlsZCBhIExpbnV4IGtlcm5lbCB0byBydW4gYXQgYSBW
VEwgb3RoZXIgdGhhbg0KPiAgCSAgdGhlIG5vcm1hbCBWVEwwLCB3aGljaCBjdXJyZW50bHkgaXMg
b25seSBWVEwyLiAgVGhpcyBvcHRpb24NCj4gLQkgIGluaXRpYWxpemVzIHRoZSB4ODYgcGxhdGZv
cm0gZm9yIFZUTDIsIGFuZCBhZGRzIHRoZSBhYmlsaXR5IHRvIGJvb3QNCj4gKwkgIGluaXRpYWxp
emVzIHRoZSBrZXJuZWwgdG8gcnVuIGluIFZUTDIsIGFuZCBhZGRzIHRoZSBhYmlsaXR5IHRvIGJv
b3QNCj4gIAkgIHNlY29uZGFyeSBDUFVzIGRpcmVjdGx5IGludG8gNjQtYml0IGNvbnRleHQgYXMg
cmVxdWlyZWQgZm9yIFZUTHMgb3RoZXINCj4gIAkgIHRoYW4gMC4gIEEga2VybmVsIGJ1aWx0IHdp
dGggdGhpcyBvcHRpb24gbXVzdCBydW4gYXQgVlRMMiwgYW5kIHdpbGwNCj4gIAkgIG5vdCBydW4g
YXMgYSBub3JtYWwgZ3Vlc3QuDQo+IC0tDQo+IDIuNDMuMA0KPiANCg0KUmV2aWV3ZWQtYnk6IE1p
Y2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCg0K

