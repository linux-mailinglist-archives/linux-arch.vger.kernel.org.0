Return-Path: <linux-arch+bounces-13382-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88956B442AE
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 18:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950A01C85BBA
	for <lists+linux-arch@lfdr.de>; Thu,  4 Sep 2025 16:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A983002CA;
	Thu,  4 Sep 2025 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lnq7SL95"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2017.outbound.protection.outlook.com [40.92.41.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8A23278D;
	Thu,  4 Sep 2025 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003227; cv=fail; b=ZCQZPlkOepGooOww0+MT/oCLolIsg2i9KjS30JKUKJVxLVt/LmVqrxnKaq03+fFXgm+yYY/V85QgR4aGTyTx4J1GqmXRjQWU+9Si1LajnmvXFrX8+MWV9uIasHTsXmLCZHX8cSINC96/ERBdtOrKAW0pSOFZbKQ3A/kLHZuOAOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003227; c=relaxed/simple;
	bh=+0L3JpoX3zzHAZ6OVWwTNziUegN88CqQZOcSK9StIM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RyEUwbwjOYb1Z0N4RBf349dO8GS/jImsXDuQ94mmXgHk89Hl8YDNtN2C8f0blC+8o7VbifGRYCbMUpdnQdk4lbwZlW04pEDWkr8C3WBinsQGeJVavK9VIjCBfJFkhp4pQQFm1T3zL2StORP8DFN0EeRG4Eu8DWQdGoeO16FbWh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lnq7SL95; arc=fail smtp.client-ip=40.92.41.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qltr8uj+wqKMcbB2awVPXSHfTMh3ONWUkdycIveZbgG6x0cDhdF35YruXf9WoplZI2XVDnY5ckqnU8hwZH/Ur1LvTqSdR3VjcleYHUwVOJeSRZZoU62MNotShCe6fLag0Ldrfnb6csiseFQUgvI+GdofOMmiI/76VJHB0x9Z08Js5Mw7kyBlXGPz7lrFZcIjpGb6cxyQlaVtSS5nFhlRBjweCNdehel84VcNIYiXgoPrphOlA7noBareNbX+107k1tYXvIdX/T17tzqWive0NFEfJj6Lr4/uXTKCEAKsk84Qtmq+A2ssDdsmrMn2TnxU9lmMmGroMZwsINoOZPzYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0L3JpoX3zzHAZ6OVWwTNziUegN88CqQZOcSK9StIM8=;
 b=hozq0CMe+34JyD/E3/tMjJ6zWZZAQTNTDNGPdOY6lzJ6kmxJl8s6UPlePldYm/jlFqmIWuTeZ/5wTCqdnI09ZIoF8qFQ5TfGD6YNPlGmLEU5UWRrLM3IJ/6N5FTjBdBWO8VNpzaC+XMET/mguPLCvancLupeg9dBxm+MK80AGn1wCjQQ1qWfaJtgCidQVAeFndjU2lQmq1tImGElehDGu6gxkdjzJQXxeejA0o8pOn3uNI/XlpH3kuJ5Zfl4M4WaSPKuhFyjHMaVEBQok0HjXYmZmbfJ814VT0FDtOLdWqjSODEzPFhjxoNh5ozD5AlAZ0dXAh9zQidgg6u7L9Oqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0L3JpoX3zzHAZ6OVWwTNziUegN88CqQZOcSK9StIM8=;
 b=lnq7SL95EZhtlZfMaGQ9l/BR6sTWMmTO1e+yZALQ0czPZEPaGV3VVT4C113b4a8W6hwzkV9xH/gSM/9WcJoGrAUCY56Bni7DnVNuDX6UJzHfKB/Ay7kARn6cp5vvV8IlD64Ol0UdbG66dwBL599XjnxOe1tRsqVNUHFdKkIwzxxDZK6tMxqSsTXJWaYZ3jEg1ah8aGmEzTc3fE6LmpYdlZpcTvZU1k/SBZeIRG8M20krDnCrOdJ7xYSKXBk+Z33726BPoqvTMjKt7VTIy8SfZBs0oAYIHYyUHL4/VqWE6PMSS526pCng6RdOkcUcemmXyKz8Eu8iPAY9PC+/Toe6nw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB9306.namprd02.prod.outlook.com (2603:10b6:510:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 16:26:59 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.9052.027; Thu, 4 Sep 2025
 16:26:59 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "linux-fbdev@vger.kernel.org"
	<linux-fbdev@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "jikos@kernel.org" <jikos@kernel.org>,
	"bentiss@kernel.org" <bentiss@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "dmitry.torokhov@gmail.com"
	<dmitry.torokhov@gmail.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "deller@gmx.de" <deller@gmx.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH V0 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Thread-Topic: [PATCH V0 0/2] Fix CONFIG_HYPERV and vmbus related anamoly
Thread-Index: AQHcF7c4ZH9DwegJF0iLCVnaUNUDXbR7UfGggAcCgoCAAOY3YA==
Date: Thu, 4 Sep 2025 16:26:59 +0000
Message-ID:
 <SN6PR02MB41573C5451F21286667C5441D400A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250828005952.884343-1-mrathor@linux.microsoft.com>
 <SN6PR02MB4157917D84D00DBDAF54BD69D406A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ff4c58f1-564d-ddfa-bdff-48ffee6e0d72@linux.microsoft.com>
In-Reply-To: <ff4c58f1-564d-ddfa-bdff-48ffee6e0d72@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB9306:EE_
x-ms-office365-filtering-correlation-id: 7003f448-682c-490c-1fa0-08ddebcfdf7c
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|461199028|13091999003|15080799012|8062599012|8060799015|19110799012|40105399003|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?K1p1cXdla2JqdkQ3ZXg3Z1BZdTdxZ2ZvOG9DdkF5ajBnMTBYZlhjZW8rZzcy?=
 =?utf-8?B?bFVrdUZIRFN2VWlqVk9RcGZmZ3pzdmp5ZGJuSzI4dkZOYVFXT0U0N0lXV0hN?=
 =?utf-8?B?c0ZEWUZCYXhMekZnNXJoTy9BSTFLY1lYaFZjSDJ0Ri9RTi93d2QrOUp4QjZy?=
 =?utf-8?B?RXF3aVNqNFhLQTAwa2ZaQk0wOWhjZDFWK080UWljbzhBTzV5TFlQUVhYd1Vq?=
 =?utf-8?B?eGZPbTJsZjQvb292U1lUbjJ0NWJKVkFXVnhhUjNrRWU2d3QxbFRFa2VDbVVx?=
 =?utf-8?B?Zm1RMW9CM2ZLS2dabFhPQVdXNk1TN2hSb2xXdk8vc2JVTERobFc0WDJmSWJU?=
 =?utf-8?B?NHl5V0lQWUZRcGd1VVRqcWk0a3ljb1N0VFE1RkZPdlNWSjdDeXRyV25BZ0Ny?=
 =?utf-8?B?NGVWZTExd1drUmh6N20zM25vaGZzQlROK2R2RlM0N3RRUml5VTVlOWNHT3hY?=
 =?utf-8?B?cXlsc0cxOG5ORG1Kdko2OHRNTXkyUm85bjVqMzNxcDc2NU5wQnlDQlNmN09z?=
 =?utf-8?B?cDExYmhKR0xiU2JjcUFEbStPUEh2OE5xV0JyYjE5Y1R2NnpKd1dPNXNGN2RN?=
 =?utf-8?B?T2toQ2J6eFdDNzlVUGZwRlE3cmg2WWdNZ1ZKYi85U0lvQ0tUYmZhU2lXWTdy?=
 =?utf-8?B?Vk5LQk5XYm1QL3A5Wis2K3Z1Y3FUcjJxQzJBQmZrWlZ1ZTZ6YUw0RlYxTWRB?=
 =?utf-8?B?aGR4MWQ5UnhDZVIzOU9pbWduLzkvWlNuRzRzM1BYRndqRW1CWXBXSVVRdHU1?=
 =?utf-8?B?c2ozRE44ajRFWHlaMFNzYnhlUW5oTklOWEo4cElWRllScVNheHorQjZUQVFr?=
 =?utf-8?B?QkFreVZCNU5uK1puOUtkVm5EUUZMR2t3aVRZR0Z6am5XWjc2d3pFbXlpSHZM?=
 =?utf-8?B?b1hWLzNKSFR1dU1tdWpnZERKd3VHYmM3ZmJtclYvc0F4RUU5NWVEUVRuRmxw?=
 =?utf-8?B?WUt1RkV6YnQzR3dOSWxxR05GTjczYWl2aGh3MG1BcGU1RjhDQ1JnNy9abDFC?=
 =?utf-8?B?cm5BRmUrSjZsWmlralhyVFo5S3lwdW93MFoyaTBjMG9qWnA0MFlrSUdNd3lq?=
 =?utf-8?B?eDRKWEdKbTF5UEhPcWZoVkFqMVltd3NNemd3ZDlnS2cvNUVBR0VuSkFORXN3?=
 =?utf-8?B?anVEWkx6elA3cnNWWDNiZUxWaWs3RUVnMW1RMm5pNTVnYS84bjNFSkJ2WHNO?=
 =?utf-8?B?UEV1Mm5WZW9GSGxrcmRsMmhVNzI0V2xaeUtwK0plMHpOZUtuRWx2V2IyQXhG?=
 =?utf-8?B?WE1EQXh1VEhUZ3puZUNlc2tBU3B2d0VYWHp6blJMd3RZL0FwSGt5VzhNNVBM?=
 =?utf-8?B?cHREOVhtMVNQaGhZLys2RDlORWlLREJkNnA4ZEFXaXZTd2toem9KN2c5OGVI?=
 =?utf-8?B?d1JlSXY0VDBGRGF1MjN0VVQwYTJqcVhJcFFKaTlOb0QxS0I4QVJoSXEwR21N?=
 =?utf-8?B?MUxhMmd5aDNTVDIxR1c2cE12dnZybkI2eXJjeVdjSjR6ZkM5cmtmZnlSaTFN?=
 =?utf-8?B?THEwUnJJWlNjdXMwcnd4NklUYWJ6ZDhOMzhwQTB6MTFKM2psWHo3d1hyOUpk?=
 =?utf-8?Q?aDHqpcRr8Ug2Fj5ja+dPbhmbE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjM4ZGR6ZTdMM2hMR2VEV1BiKzRVR2wvR0RCTlRQWU5JSWg4K3gySU1tY2x5?=
 =?utf-8?B?T29HQmJzQ2RkcitVV1AwaWpmODc0SjliSldON0d0QXNBK2JacndoeW1kSTQw?=
 =?utf-8?B?QVFkQ1JMcXpNYjhoYmxucldGM2hoK3FZUnFoOU9ERVJkR3orSGxPNmNEMjZT?=
 =?utf-8?B?di8zdWRiaStoSHcvZ3lFQUlLV3ZqQlpyY2RFdFgveEtZeit6ZzArb3c1dkc3?=
 =?utf-8?B?OGF2RDJVNmhpYWVJTmhKbTBMa2dkRldDMGxXUUoyaDZSZEpzTjRJd3dNcWhI?=
 =?utf-8?B?QnpyNDZhdlZ0dWxzUXF5aURqUHBCZGNSbXM1Z2Y1WVBraVI4Ykl1S1pJV0pi?=
 =?utf-8?B?S0hqV0JjQ3BUb1R4R3FNSW1ybmxtbGNaUTNabEcxb0NwM3lvUThvdFM1ZmRo?=
 =?utf-8?B?NEQxSUt2MDVTWDI5WURtV3hMV2tLRDBZZ2VxbUJia3dURjBqa1phSzhYY3Iy?=
 =?utf-8?B?RGtYeUJpMU5kd0lncE5KakhmdnlWQmVjMDNGY3JZNDNMQWsxTmR3eDRqbzJl?=
 =?utf-8?B?VUpoSXFOeUM2STJISUJDUDdPREpFUGFzRE01dWJCMlE2VnplT3BMNUJNcEZG?=
 =?utf-8?B?azA3YlZaVjFFSmVYbWtHTnB2QlVjVWVONzkyQ3dLZ3RBUUt5eHZLaWt2QWtB?=
 =?utf-8?B?WXdtTkRVakdTcUVQTDl3S3pvMUs5cEN6NzZoNmRnUFpYKzB0eHJISXQvRTVS?=
 =?utf-8?B?REZRZU5hdkJuT0ZJK0h6cXRwTkZQOEVqZXRSVmJMUXowQUdrVDhBZGVjQVBx?=
 =?utf-8?B?UVVLTkZQQnh6elFCbkRyWXRJR0ZhZGpBNThwTmc0WXc2bzlJNzJ2Y3NpOU5S?=
 =?utf-8?B?RGk4VXI0ejRvZVNIcmUxTnJZRnN6UXhoQWFudmU2eFM5L1Y4L3FPTnZWL2Ny?=
 =?utf-8?B?S28xNm5pdkZmYjM4S3o3bk1oYjBia1pHcWlZN243ektENVlxcDBKeUczNEth?=
 =?utf-8?B?aFpIcWF6VjFTM0F1T1RNV3VCL2dRcGhUOWVLbk1nWk1tVlcwK2VwSkdzRTQ4?=
 =?utf-8?B?NGxTY05VLzVQanVFRXdiZEFsakpsL1lDUHRtbCthRUc1SUN5T0ZyTkRwNEht?=
 =?utf-8?B?MEZ6UytYR053QjJDMkpSQS9qMXc3Z0pWQTcrM3NJWTBEdUo3WG9RSFZ1S3hX?=
 =?utf-8?B?WStTTlZ3QTk2R29BTDdxcXZxeEZYRkYrR0UxejZSKzQyUXFuVEUwUFdCZEhR?=
 =?utf-8?B?VTMvS0Y1VFJnNGFBNFh4TEl1ZkM0eGNHVDVKZVNmenpMamF2c1IvTms4dTBI?=
 =?utf-8?B?L09LR28rN0tjVVY3UDlhN0tGZWJkaXUvQldsQTMwRCtTam1hdU9TakhKQ09Q?=
 =?utf-8?B?QWlYSm1hNU5jcTRtdXZYV1UxSVMyYUhFMlN3Z0pZNEt3UlFwQS9TaHp3TStQ?=
 =?utf-8?B?STlOWnNwT3VScU83ZG9Nc2NCTmcxaStpSE1uMzUxZXoyazdWcFdSZ0IySzNR?=
 =?utf-8?B?NDI5YWFRRkQyb3ZWV0JIdTRxMjBsSUdhcVI4T01nZzdCMWFsMXMrSldIT2RX?=
 =?utf-8?B?RTViTE0welEvN2Q2NnhKTW1VRUZNMlU1NFhZR285QWliQWF1UjJGS0lrVHQ3?=
 =?utf-8?B?N3BKMWthQ1d2VlgzRnZNY1NaY1ljeUxONWpuSHhhRURGVXFmdUxoR1I5bXFv?=
 =?utf-8?Q?56sK2RyqJj9dJn/FE5hEnx+yiEAY85AdUebJRJYgKl3E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7003f448-682c-490c-1fa0-08ddebcfdf7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 16:26:59.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9306

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogV2VkbmVz
ZGF5LCBTZXB0ZW1iZXIgMywgMjAyNSA3OjE3IFBNDQo+IA0KPiBPbiA5LzIvMjUgMDc6NDIsIE1p
Y2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE11a2VzaCBSYXRob3IgPG1yYXRob3JAbGlu
dXgubWljcm9zb2Z0LmNvbT4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjcsIDIwMjUgNjowMCBQ
TQ0KPiA+Pg0KPiA+PiBBdCBwcmVzZW50LCBkcml2ZXJzL01ha2VmaWxlIHdpbGwgc3Vic3QgPW0g
dG8gPXkgZm9yIENPTkZJR19IWVBFUlYgZm9yIGh2DQo+ID4+IHN1YmRpci4gQWxzbywgZHJpdmVy
cy9odi9NYWtlZmlsZSByZXBsYWNlcyA9bSB0byA9eSB0byBidWlsZCBpbg0KPiA+PiBodl9jb21t
b24uYyB0aGF0IGlzIG5lZWRlZCBmb3IgdGhlIGRyaXZlcnMuIE1vcmVvdmVyLCB2bWJ1cyBkcml2
ZXIgaXMNCj4gPj4gYnVpbHQgaWYgQ09ORklHX0hZUEVSIGlzIHNldCwgZWl0aGVyIGxvYWRhYmxl
IG9yIGJ1aWx0aW4uDQo+ID4+DQo+ID4+IFRoaXMgaXMgbm90IGEgZ29vZCBhcHByb2FjaC4gQ09O
RklHX0hZUEVSViBpcyByZWFsbHkgYW4gdW1icmVsbGEgY29uZmlnIHRoYXQNCj4gPj4gZW5jb21w
YXNzZXMgYnVpbHRpbiBjb2RlIGFuZCB2YXJpb3VzIG90aGVyIHRoaW5ncyBhbmQgbm90IGEgZGVk
aWNhdGVkIGNvbmZpZw0KPiA+PiBvcHRpb24gZm9yIFZNQlVTLiBWbWJ1cyBzaG91bGQgcmVhbGx5
IGhhdmUgYSBjb25maWcgb3B0aW9uIGp1c3QgbGlrZQ0KPiA+PiBDT05GSUdfSFlQRVJWX0JBTExP
T04gZXRjLiBUaGlzIHNtYWxsIHNlcmllcyBpbnRyb2R1Y2VzIENPTkZJR19IWVBFUlZfVk1CVVMN
Cj4gPj4gdG8gYnVpbGQgVk1CVVMgZHJpdmVyIGFuZCBtYWtlIHRoYXQgZGlzdGluY3Rpb24gZXhw
bGljaXQuIFdpdGggdGhhdA0KPiA+PiBDT05GSUdfSFlQRVJWIGNvdWxkIGJlIGNoYW5nZWQgdG8g
Ym9vbC4NCj4gPg0KPiA+IFNlcGFyYXRpbmcgdGhlIGNvcmUgaHlwZXJ2aXNvciBzdXBwb3J0IChD
T05GSUdfSFlQRVJWKSBmcm9tIHRoZSBWTUJ1cw0KPiA+IHN1cHBvcnQgKENPTkZJR19IWVBFUlZf
Vk1CVVMpIG1ha2VzIHNlbnNlIHRvIG1lLiBPdmVyYWxsIHRoZSBjb2RlDQo+ID4gaXMgYWxyZWFk
eSBtb3N0bHkgaW4gc2VwYXJhdGUgc291cmNlIGZpbGVzIGNvZGUsIHRob3VnaCB0aGVyZSdzIHNv
bWUNCj4gPiBlbnRhbmdsZW1lbnQgaW4gdGhlIGhhbmRsaW5nIG9mIFZNQnVzIGludGVycnVwdHMs
IHdoaWNoIGNvdWxkIGJlDQo+ID4gaW1wcm92ZWQgbGF0ZXIuDQo+ID4NCj4gPiBIb3dldmVyLCBJ
IGhhdmUgYSBjb21wYXRpYmlsaXR5IGNvbmNlcm4uIENvbnNpZGVyIHRoaXMgc2NlbmFyaW86DQo+
ID4NCj4gPiAxKSBBc3N1bWUgcnVubmluZyBpbiBhIEh5cGVyLVYgVk0gd2l0aCBhIGN1cnJlbnQg
TGludXgga2VybmVsIHZlcnNpb24NCj4gPiAgICAgYnVpbHQgd2l0aCBDT05GSUdfSFlQRVJWPW0u
DQo+ID4gMikgR3JhYiBhIG5ldyB2ZXJzaW9uIG9mIGtlcm5lbCBzb3VyY2UgY29kZSB0aGF0IGNv
bnRhaW5zIHRoaXMgcGF0Y2ggc2V0Lg0KPiA+IDMpIFJ1biAnbWFrZSBvbGRkZWZjb25maWcnIHRv
IGNyZWF0ZSB0aGUgLmNvbmZpZyBmaWxlIGZvciB0aGUgbmV3IGtlcm5lbC4NCj4gPiA0KSBCdWls
ZCB0aGUgbmV3IGtlcm5lbC4gVGhpcyBzdWNjZWVkcy4NCj4gPiA1KSBJbnN0YWxsIGFuZCBydW4g
dGhlIG5ldyBrZXJuZWwgaW4gdGhlIEh5cGVyLVYgVk0uIFRoaXMgZmFpbHMuDQo+ID4NCj4gPiBU
aGUgZmFpbHVyZSBvY2N1cnMgYmVjYXVzZSBDT05GSUdfSFlQRVJWPW0gaXMgbm8gbG9uZ2VyIGxl
Z2FsLA0KPiA+IHNvIHRoZSAuY29uZmlnIGZpbGUgY3JlYXRlZCBpbiBTdGVwIDMgaGFzIENPTkZJ
R19IWVBFUlY9bi4gVGhlDQo+ID4gbmV3bHkgYnVpbHQga2VybmVsIGhhcyBubyBIeXBlci1WIHN1
cHBvcnQgYW5kIHdvbid0IHJ1biBpbiBhDQo+ID4gSHlwZXItViBWTS4NCj4gPg0KPiA+IEFzIGEg
c2Vjb25kIGlzc3VlLCBpZiBpbiBTdGVwIDEgdGhlIGN1cnJlbnQga2VybmVsIHdhcyBidWlsdCB3
aXRoDQo+ID4gQ09ORklHX0hZUEVSVj15LCB0aGVuIHRoZSAuY29uZmlnIGZpbGUgZm9yIHRoZSBu
ZXcga2VybmVsIHdpbGwgaGF2ZQ0KPiA+IENPTkZJR19IWVBFUlY9eSwgd2hpY2ggaXMgYmV0dGVy
LiBCdXQgQ09ORklHX0hZUEVSVl9WTUJVUw0KPiA+IGRlZmF1bHRzIHRvICduJywgc28gdGhlIG5l
dyBrZXJuZWwgZG9lc24ndCBoYXZlIGFueSBWTUJ1cyBkcml2ZXJzDQo+ID4gYW5kIHdvbid0IHJ1
biBpbiBhIHR5cGljYWwgSHlwZXItViBWTS4NCj4gPg0KPiA+IFRoZSBzZWNvbmQgaXNzdWUgY291
bGQgYmUgZml4ZWQgYnkgYXNzaWduaW5nIENPTkZJR19IWVBFUlZfVk1CVVMNCj4gPiBhIGRlZmF1
bHQgdmFsdWUsIHN1Y2ggYXMgd2hhdGV2ZXIgQ09ORklHX0hZUEVSViBpcyBzZXQgdG8uIEJ1dA0K
PiA+IEknbSBub3Qgc3VyZSBob3cgdG8gZml4IHRoZSBmaXJzdCBpc3N1ZSwgZXhjZXB0IGJ5IGNv
bnRpbnVpbmcgdG8NCj4gPiBhbGxvdyBDT05GSUdfSFlQRVJWPW0uDQo+IA0KPiBUbyBjZXJ0YWlu
IGV4dGVudCwgaW1vLCB1c2VycyBhcmUgZXhwZWN0ZWQgdG8gY2hlY2sgY29uZmlnIGZpbGVzDQo+
IGZvciBjaGFuZ2VzIHdoZW4gbW92aW5nIHRvIG5ldyB2ZXJzaW9ucy9yZWxlYXNlcywgc28gaXQg
d291bGQgYmUgYQ0KPiBvbmUgdGltZSBidXJkZW4uIA0KDQpJJ20gbm90IHNvIHNhbmd1aW5lIGFi
b3V0IHRoZSBpbXBhY3QuIEZvciB0aG9zZSBvZiB1cyB3aG8gd29yayB3aXRoDQpIeXBlci1WIGZy
ZXF1ZW50bHksIHllcywgaXQncyBwcm9iYWJseSBub3QgdGhhdCBiaWcgb2YgYW4gaXNzdWUgLS0g
d2UgY2FuDQpmaWd1cmUgaXQgb3V0LiBCdXQgYSBsb3Qgb2YgQXp1cmUvSHlwZXItViB1c2VycyBh
cmVuJ3QgdGhhdCBmYW1pbGlhciB3aXRoDQp0aGUgZGV0YWlscyBvZiBob3cgdGhlIEtjb25maWcg
ZmlsZXMgYXJlIHB1dCB0b2dldGhlci4gQW5kIHRoZSBpc3N1ZSBvY2N1cnMNCndpdGggbm8gZXJy
b3IgbWVzc2FnZXMgdGhhdCBzb21ldGhpbmcgaGFzIGdvbmUgd3JvbmcgaW4gYnVpbGRpbmcNCnRo
ZSBrZXJuZWwsIGV4Y2VwdCB0aGF0IGl0IHdvbid0IGJvb3QuIEp1c3QgcnVubmluZyAibWFrZSBv
bGRkZWZjb25maWciDQpoYXMgd29ya2VkIGluIHRoZSBwYXN0LCBzbyBzb21lIHVzZXJzIHdpbGwg
YmUgYmVmdWRkbGVkIGFuZCBlbmQgdXANCmdlbmVyYXRpbmcgQXp1cmUgc3VwcG9ydCBpbmNpZGVu
dHMuIEkgYWxzbyB3b25kZXIgYWJvdXQgYnJlYWtpbmcNCmF1dG9tYXRlZCB0ZXN0IHN1aXRlcyBm
b3IgbmV3IGtlcm5lbHMsIGFzIHRoZXkgYXJlIGxpa2VseSB0byBiZSBydW5uaW5nDQoibWFrZSBv
bGRkZWZjb25maWciIG9yIHNvbWV0aGluZyBzaW1pbGFyIGFzIHBhcnQgb2YgdGhlIGF1dG9tYXRp
b24uDQoNCj4gQ09ORklHX0hZUEVSVj1tIGlzIGp1c3QgYnJva2VuIGltbyBhcyBvbmUgc2VlcyB0
aGF0DQo+IGluIC5jb25maWcgYnV0IG1hZ2ljYWxseSBzeW1ib2xzIGluIGRyaXZlcnMvaHYgYXJl
IGluIGtlcmVuZWwuDQo+IA0KDQpJIGFncmVlIHRoYXQncyBub3QgaWRlYWwuIEJ1dCBub3RlIHRo
YXQgc29tZSBIeXBlci1WIGNvZGUgYW5kIHN5bWJvbHMNCmxpa2UgbXNfaHlwZXJ2X2luaXRfcGxh
dGZvcm0oKSBhbmQgcmVsYXRlZCBmdW5jdGlvbnMgc2hvdyB1cCB3aGVuDQpDT05GSUdfSFlQRVJW
SVNPUl9HVUVTVD15LCBldmVuIGlmIENPTkZJR19IWVBFUlY9bi4gVGhhdCdzDQp0aGUgY29kZSBp
biBhcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMgYW5kIGl0J3MgYmVjYXVzZSBIeXBlci1W
DQppcyBvbmUgb2YgdGhlIHJlY29nbml6ZWQgYW5kIHNvbWV3aGF0IGhhcmR3aXJlZCBoeXBlcnZp
c29ycyAobGlrZQ0KVk13YXJlLCBmb3IgZXhhbXBsZSkuDQoNCkZpbmFsbHksIHRoZXJlIGFyZSBh
Ym91dCBhIGRvemVuIG90aGVyIHBsYWNlcyBpbiB0aGUga2VybmVsIHRoYXQgdXNlDQp0aGUgc2Ft
ZSBNYWtlZmlsZSBjb25zdHJ1Y3QgdG8gbWFrZSBzb21lIGNvZGUgYnVpbHQtaW4gZXZlbiB0aG91
Z2gNCnRoZSBDT05GSUcgb3B0aW9uIGlzIHNldCB0byAibSIuIFRoYXQgbWF5IG5vdCBiZSBlbm91
Z2ggb2NjdXJyZW5jZXMNCnRvIG1ha2UgaXQgc3RhbmRhcmQgcHJhY3RpY2UsIGJ1dCBIeXBlci1W
IGd1ZXN0cyBhcmUgY2VydGFpbmx5IG5vdCB0aGUNCm9ubHkgY2FzZS4NCg0KSW4gbXkgbWluZCwg
dGhpcyBpcyBqdWRnbWVudCBjYWxsIHdpdGggbm8gYWJzb2x1dGUgcmlnaHQgYW5zd2VyLiBXaGF0
DQpkbyBvdGhlcnMgdGhpbmsgYWJvdXQgdGhlIHRyYWRlb2Zmcz8NCg0KTWljaGFlbA0K

