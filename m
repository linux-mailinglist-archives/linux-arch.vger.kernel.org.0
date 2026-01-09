Return-Path: <linux-arch+bounces-15733-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1687BD0C128
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 20:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 253343094A68
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC381F4C8E;
	Fri,  9 Jan 2026 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kw0stkII"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012052.outbound.protection.outlook.com [52.103.2.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EC2EAD1C;
	Fri,  9 Jan 2026 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986672; cv=fail; b=A3WryYn2qRJbgW22h+gUmO3CBrGX/tmRLxqfP+HGRbEjJrqWox1OmtKo/f+1HJ5CyPgjpuj5dkE7eScWg8bMEEXPQXsGPyvFpXT6wxxfSc51W6gX2TPQkR/mh4dnNF668EebOHvRcpcqMbBB0RYQp+xxXUFHYNhua8xa9ocRQ+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986672; c=relaxed/simple;
	bh=+2UFKn5kCglFWytbv+4mEQgEGLmIMj6IJpWjkiSJnnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=slYxqHcUDETSdALaDGgQwPFAMtUIVirsqTYuDvnjWvQbwGglREQi0s+axXawOUsrYTFW5Zt2oe2Z678xg/HFDouPLYrZSRVcllhFtVTtY+hiIB6Bdy8cRh/6jEQItJExzaxVtv7Dcqu8OnGnJxDt6n2oJxtGqIWNdGt9wdccBeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kw0stkII; arc=fail smtp.client-ip=52.103.2.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwY7Iz7px8skFMmaNhyQHzEVZ5m70m34cF5m5u7YzfEMFTfjQtsutzuYsPqHyjXq8odTWD5tr9J/X9/FSvVD0eUpIQrB+v+YoTiwB8Lg117sfckCeLb2XrybwcHR3VvEJJuRJEYnJFoLAjIdtbzSqWCGiD7RkjrukaKh4ojjhu19AiQODu5ruPdN2t8nIzONYTu4F8x14i1/OPazQ8VMSDh/2pn4KA710DmmTj+JtvHMR6PahJVwlsAAAMyAjK6UtwMe1CFCSM2BvsrYWAlytJnp+VuWNLatJWo3zk+tr2jpEQ0okNFpDPrBcA1HCqPdxaM0BKZXmViWHmCsi6nTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2UFKn5kCglFWytbv+4mEQgEGLmIMj6IJpWjkiSJnnE=;
 b=fbBEb97LPP7TtrWnRFkWaLWsqeqLitlRn4LnE9KL4pjqEDw/zUReik/Nt+47Z9ZP310sSkYfqNsS1iAo7Z0HnNpm+QDSBIBYP7JE+Dtlrj3ULpcW7smIX2HkNgmXwJLdVGyezTaC9tUTwCdC+2WBV5JOUNlLa6R8CR1bB23WuZS3UDmimg78TLQNCM33IUAhpaQFj/0CD+SmhvOEsX0ViJjO8u6Tldp69mwac01uFkfcwGun44tweTV9kbg8CjKCbWnNJFIv5EUJsomN9wcTby6XbLf2UTyS9Ihfk0s4HoxjspvIKl0DUKm2DXbG7cK0+sLUMiDy92/BQTVQDuMskA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2UFKn5kCglFWytbv+4mEQgEGLmIMj6IJpWjkiSJnnE=;
 b=kw0stkIIFcCKlCmPTVp54RsTaBLUFv5qHCc4hEPKkdGrSUSa1dWnw/T/Idi6pV7d4JmLofJ174MQ15o5EvYnS/KTDEgWfpMofRUKPiXnXhsPDafhqGnGDUdHQIhwIh/waaqaNpCLq+Lbo6Cbr//MEZolrdG8OOhoW3MebVYtFPmA1TEIacQ0rkBQi79R+2FUOekYI20wSheDU3PbL5jQGtPgLAAGhJBf10AwyWN8pyEMQy5QL3ON/Tc9ozYNVoRdmDHOWCag3qyRg7m5TpEkg03iB82zqkN5/noXMjNntFOoQsbpgYC6tTL2QwKjSURIvCwiFZ3z7F1Ui0/haGFe8w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV2PR02MB11304.namprd02.prod.outlook.com (2603:10b6:408:351::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 19:24:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 19:24:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
CC: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
Thread-Topic: [RFC v1 3/5] hyperv: Introduce new hypercall interfaces used by
 Hyper-V guest IOMMU
Thread-Index: AQHcaMpUCD6VSZQZOU6EcthBZLbCPrVIporQgAG4pgCAAAXQYA==
Date: Fri, 9 Jan 2026 19:24:25 +0000
Message-ID:
 <SN6PR02MB4157009C747D487E289B96B9D482A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB415755B0CED30E8BEB062942D485A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <330d26ac-f1a2-4ee9-8cd7-20fd17db9f92@linux.microsoft.com>
In-Reply-To: <330d26ac-f1a2-4ee9-8cd7-20fd17db9f92@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV2PR02MB11304:EE_
x-ms-office365-filtering-correlation-id: 02481486-d750-4b9a-3182-08de4fb4b320
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|31061999003|461199028|51005399006|19110799012|13091999003|8060799015|8062599012|3412199025|440099028|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?SnFOdWtzMGlEbmJhTlJmR2FyVmJCUC9Qc05OTVVZNWVEdTNFT3lMTGlnTk5K?=
 =?utf-8?B?RzdiazQ2N0dxTWpIVWF5c3hSWEwvK2ovc2VXK2k0Q0JpQ2VVaGtFSmJRSHNu?=
 =?utf-8?B?V2lWR3llUjBWbVg3M2ZzbEh3a2EzcXpkREhSdnZXVXdwTmR3TXRKbEFrMzNT?=
 =?utf-8?B?M1Nvc3g0cG5QSWsreFpiRm9ka3drN3V5blhNRVpXVjBDSHJlOFR6NzZQaUFx?=
 =?utf-8?B?d05JaXVsaWJieEU4TW9xTXlVM1hITWZ1T2dpckxGSVJLeGVCZ3VJUEVTQTV1?=
 =?utf-8?B?QXEzOUEvVEdENHp5UXlUelZDUGh6S0IyWkJMWG5LcHh5TXJVRlhFc0lKbm5M?=
 =?utf-8?B?T1ZzYUJ0bVFVTWVPdERmclZoV0diV0xicmJIOTQ4d3p0QXFOVlBhQ3RCSG94?=
 =?utf-8?B?MlRIbDMzYjBZTGp2SUVIdXJYRXowaGRiaUUwUW91cGNKUWJBZXNIdmh4ZmVk?=
 =?utf-8?B?Mmc0SjBYRlBuUFNnaUE1NmdaSHJVS3J6NWdHM2toS21pRndXL0RiL25uOHBS?=
 =?utf-8?B?ekVwb09ZVU16ZWMvK3c5cUw1dWxRRWZTRmhjNlA0aGlRQmNjS3BicUR3Ulgz?=
 =?utf-8?B?NW5VUmlHRVR4NHZqS1g2aklKdGhQbjduQ3FPbVN1ZTZSdUlNZFh4YjdmRWtN?=
 =?utf-8?B?blNGQlNSbnhHekxqNlRRc01xQmRZV1BqT0VrcUwxdWRwSHZCbXRtWFN3VVo0?=
 =?utf-8?B?elMyZm12QWpGQ0VVZXBnbHZjN2NBVEcxRjUyZDR0UjFyeElUbEtlYzNTYUFJ?=
 =?utf-8?B?endocEFtaGVOaHQ1QzN4cTEyQkE5ZExGenpUdU9Ud3FwR0NpOUNIOE9VQjJF?=
 =?utf-8?B?WGEwM1JBOTRFSk1CV2dncDRSWkFpejNER2plQjMxSFhQWldNdVR0VHFTQjJC?=
 =?utf-8?B?MVZxMXpndHhwdk5ab2M1U1NGenBBWTMxTUhIN3ljcEVHZmFLSG5aRjRDdG04?=
 =?utf-8?B?bjcvVzZmd0QxNjRsbEE1dm1abXZXRkNrVytYVzZ6NkdEY0ZjM25FN3QvN0xY?=
 =?utf-8?B?bjcrNExtbEVITWRBMGphZFdJRFlVUU8yK3VCMWhuS2I3NTlubnFMTFQ3MHdU?=
 =?utf-8?B?dFN4RUNtaUpwbWVEeGhzOWs5VDA4dFhIUmY0VXZ6MVk0d1RJMGl2VzBiejJ6?=
 =?utf-8?B?M1dEMzh5dFNYanNwTk9uZkJHTzUzOStPZlZiK1RKL1NmbFFRKytlZWFURjdC?=
 =?utf-8?B?MTNsdnhyNkRhemNTRXBlR2dWNE04ejI1bE1GRXBUQ1d6Uk83RU1OTG0xR1hO?=
 =?utf-8?B?bWlJMFZrcFdHUUxTMEh3MUNOZGpUMVR6R3AyUElxZkxWaCtkc2dhMVp1K21F?=
 =?utf-8?B?UGdCbzVwci85T0xuMDBZb3RWb1VMbS9qL1dMQ0sxZTQwRXdHTWxmaFVyU1RZ?=
 =?utf-8?B?TlZ2Nmk1dFFVWXplTUVNeHYrU1F3cm1VWndNREZIMituczNGUlVWQkQ3bGVk?=
 =?utf-8?B?MGFYbUtSRnU5NDBuQ1F1Nk9BT3hnSHkrazIyOWZSNUJOTG9kaFEvVmdJSXhL?=
 =?utf-8?B?RG5hQ2F4V3JaQnloKy92UHZwOUREUHVveC8ydXZ5ZmNDZXR1V2o1R3RwMzZW?=
 =?utf-8?B?TTRwWnBzT0FKSVVLRjVmOUlKQ2k4NC9CK1AwZU5mencwVUVIcXRGaE80U01m?=
 =?utf-8?B?bis4TkZwVDdJWE9IOFpqUkNNbGt4OWVlSkJhYUpIZFg1V3gvUFNIN0loSm5E?=
 =?utf-8?Q?sijfvuuVCHGZVvMtxSha?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?LzY2SklzelU1WjBMMXVkNHpvSXkxL2RJTS9JZzdLQ2FnbkhTTk8yNTJMeDVw?=
 =?utf-8?B?NXRLekltWmJsemxSL0g2UERnV1R3bTZxeXVxMVFRa1MrZjZaYzRFek1SRVRo?=
 =?utf-8?B?R2sxV053akpGL25qSE9uYVpWc3Q1ckhqMHZvMkRyczlrQkl0Tzk3QmIwQlJu?=
 =?utf-8?B?Sy9Lb3llWlQ0d2xTcys1b0lYOEVzY2lNbGI5SlkyOUpmMmErWUtadTN2YkZZ?=
 =?utf-8?B?em4rK2UrR3FhMGJKUVdqQ3c0NTNHT1g0S1orSmxsdkROY3pPZUxkeUF0aXlD?=
 =?utf-8?B?TEkwSXhFWDh4TnllSmR1YUxDM2lBM0tzdkJaS0NUVzVKaWo1RGFvMFVEY0lN?=
 =?utf-8?B?cWtKYTFjRjVpYjNFdVV4blp6cHh3R3BXeldjbElodDcvMjFrZGQ3WlY4MzdE?=
 =?utf-8?B?cVlHcW1ONXlVem4rR2UzVW5wMDF5WElWZWZ2RXJwb2FWNnFBRHFtcE9hTmM5?=
 =?utf-8?B?WldYeVlrcHVEaUlCVFBxbHZNTHdwR25RNVZQVVBJQ2w4Wm5FeHRGVHJudmo4?=
 =?utf-8?B?LzJSbldncVVUOWY4Z1AyMVZnRGUxZHBaN2g3YmJXVkNlSjV0UHJDUklRcm9h?=
 =?utf-8?B?Ti90ZFRvNGx5RXRJTkhQVnp3bmlFMGxlV3N3TC9GVC9MTEp4RElGWjZQalFk?=
 =?utf-8?B?S0tiRGRHdXd5bkFjQTVhKzlPSzlGVnVWa2tCWTFCQjhHR3NYbmlsS05CYkVL?=
 =?utf-8?B?RXNTalI1bGZjNEpad0QvMzJxdUFsOW92dzFxZit1ZVV3aXM0L21uQmFCMUV3?=
 =?utf-8?B?ejY4eVcxSkVQRlBEdVZFMk5Jd3FwKytvd05mck1OSnZwaWNUN0t4S2I2U0RC?=
 =?utf-8?B?b1NXK3RQU0FJOFJIL0tKL010VEkycHcyQzNZd3hKQTM4cURHTzU3SHBNMUEw?=
 =?utf-8?B?ZFhpNmdjMXc2a0NzNDFlaXJzNnZ4RXhHc2E1RkhaVzkvTldXZUJ4MldMS1RG?=
 =?utf-8?B?OTF2MWtvSXp5M20zcHpLM05TVCtNYndkWDFGS1FwMFo5Y0x1TldONm1uUVVi?=
 =?utf-8?B?RjBHT0ticTF0cVloSUN2UHp4anFVYXdsbkNjMXUvSkF5UUVhNUlzWDU2dGU4?=
 =?utf-8?B?cExrUkV0THgxbWhHN250TGJKcDB1VnFyTWtSa3NpRjhlWnNscXFtY1JMZk9r?=
 =?utf-8?B?YjIzcFFyeS9xdjFVeDJvRGc2eHl6VkNZVEN4NVlDWE9VZ214MVhyWGJvREdn?=
 =?utf-8?B?TG1sUTFnemtvYjdMZmdyeE5KS2djVEdqS0NXaTArYmdNY3BXWUJ6THpsRkZW?=
 =?utf-8?B?WDhtMDQ5elZzRmoyRDI4NDlRd3ZFcjlkOVdBdXFKaHVzUUVzYVU0UDRmN1p5?=
 =?utf-8?B?ZldhNFgrSDBlU3p3aHBMY1h2UzhNeFRiSCs4V01Qa0NyQnJxOE45Mm1ISWtJ?=
 =?utf-8?B?aFRpMGZ5SkdLSjFuZDc2NUlYRjBnVWFDMXlKdlZKNU1QV3JwbDNsbVN3MWgx?=
 =?utf-8?B?OGI4V1dUQzdoTlE1V3FwZ1RabzFDcUZjdVBIZnYrcU1halVsSkduSkNNKzd5?=
 =?utf-8?B?aG1lR3JQVmEwenp5VENIdldJZHZnRmZoVjFEdHRvaFB2T3VuOXhueHF1a0Ri?=
 =?utf-8?B?bjBuK3RObnd6a0laanlGc0RCdldhQ3dTTkdmMDBPcFlYVWRldDRNV1ZWRWFq?=
 =?utf-8?B?ektNcmpTaHIzb1BzSkJMSmFHaENKNmpWSUdsNmszeStOc3JDcERjTVJsWCth?=
 =?utf-8?B?OXA0eUd6UlNJUmVOWTRROG1WU01pUnI5V3N6aHhWb3VsOUpmcDVKZXJ1dXlD?=
 =?utf-8?B?dmErT3VTYzFueW5PdE5qMTNDUWdEa1Z6N0I2amQ5K0xiUHFFbXZveGxZMG5F?=
 =?utf-8?Q?I3L8MThk//ag2nNFmvENH9do8DH2BUNwyDlhs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02481486-d750-4b9a-3182-08de4fb4b320
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 19:24:25.0733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR02MB11304

RnJvbTogRWFzd2FyIEhhcmloYXJhbiA8ZWFzd2FyLmhhcmloYXJhbkBsaW51eC5taWNyb3NvZnQu
Y29tPiBTZW50OiBGcmlkYXksIEphbnVhcnkgOSwgMjAyNiAxMDo0NyBBTQ0KPiANCj4gT24gMS84
LzIwMjYgMTA6NDcgQU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IFl1IFpoYW5n
IDx6aGFuZ3l1MUBsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDgs
IDIwMjUgOToxMSBQTQ0KPiA+Pg0KPiA+PiBGcm9tOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5v
cmc+DQo+ID4+DQo+IA0KPiA8c25pcD4NCj4gDQo+ID4+ICtzdHJ1Y3QgaHZfaW5wdXRfZ2V0X2lv
bW11X2NhcGFiaWxpdGllcyB7DQo+ID4+ICsJdTY0IHBhcnRpdGlvbl9pZDsNCj4gPj4gKwl1NjQg
cmVzZXJ2ZWQ7DQo+ID4+ICt9IF9fcGFja2VkOw0KPiA+PiArDQo+ID4+ICtzdHJ1Y3QgaHZfb3V0
cHV0X2dldF9pb21tdV9jYXBhYmlsaXRpZXMgew0KPiA+PiArCXUzMiBzaXplOw0KPiA+PiArCXUx
NiByZXNlcnZlZDsNCj4gPj4gKwl1OCAgbWF4X2lvdmFfd2lkdGg7DQo+ID4+ICsJdTggIG1heF9w
YXNpZF93aWR0aDsNCj4gPj4gKw0KPiA+PiArI2RlZmluZSBIVl9JT01NVV9DQVBfUFJFU0VOVCAo
MVVMTCA8PCAwKQ0KPiA+PiArI2RlZmluZSBIVl9JT01NVV9DQVBfUzIgKDFVTEwgPDwgMSkNCj4g
Pj4gKyNkZWZpbmUgSFZfSU9NTVVfQ0FQX1MxICgxVUxMIDw8IDIpDQo+ID4+ICsjZGVmaW5lIEhW
X0lPTU1VX0NBUF9TMV81TFZMICgxVUxMIDw8IDMpDQo+ID4+ICsjZGVmaW5lIEhWX0lPTU1VX0NB
UF9QQVNJRCAoMVVMTCA8PCA0KQ0KPiA+PiArI2RlZmluZSBIVl9JT01NVV9DQVBfQVRTICgxVUxM
IDw8IDUpDQo+ID4+ICsjZGVmaW5lIEhWX0lPTU1VX0NBUF9QUkkgKDFVTEwgPDwgNikNCj4gPj4g
Kw0KPiA+PiArCXU2NCBpb21tdV9jYXA7DQo+ID4+ICsJdTY0IHBnc2l6ZV9iaXRtYXA7DQo+ID4+
ICt9IF9fcGFja2VkOw0KPiA+PiArDQo+ID4+ICtlbnVtIGh2X2xvZ2ljYWxfZGV2aWNlX3Byb3Bl
cnR5X2NvZGUgew0KPiA+PiArCUhWX0xPR0lDQUxfREVWSUNFX1BST1BFUlRZX1BWSU9NTVUgPSAx
MCwNCj4gPj4gK307DQo+ID4+ICsNCj4gPj4gK3N0cnVjdCBodl9pbnB1dF9nZXRfbG9naWNhbF9k
ZXZpY2VfcHJvcGVydHkgew0KPiA+PiArCXU2NCBwYXJ0aXRpb25faWQ7DQo+ID4+ICsJdTY0IGxv
Z2ljYWxfZGV2aWNlX2lkOw0KPiA+PiArCWVudW0gaHZfbG9naWNhbF9kZXZpY2VfcHJvcGVydHlf
Y29kZSBjb2RlOw0KPiA+DQo+ID4gSGlzdG9yaWNhbGx5IHdlJ3ZlIGF2b2lkZWQgImVudW0iIHR5
cGVzIGluIHN0cnVjdHVyZXMgdGhhdCBhcmUgcGFydCBvZg0KPiA+IHRoZSBoeXBlcnZpc29yIEFC
SS4gVXNlIHUzMiBoZXJlPw0KPiANCj4gPHNuaXA+DQo+IFdoYXQgaGFzIGJlZW4gdGhlIHJlYXNv
bmluZyBmb3IgdGhhdCBwcmFjdGljZT8gU2luY2UgdGhlIGludHJvZHVjdGlvbiBvZiB0aGUNCj4g
aW5jbHVkZS9oeXBlcnYvIGhlYWRlcnMsIHdlIGhhdmUgZ2VuZXJhbGx5IHdhbnRlZCB0byBpbXBv
cnQgYXMgZGlyZWN0bHkgYXMNCj4gcG9zc2libGUgdGhlIHJlbGV2YW50IGRlZmluaXRpb25zIGZy
b20gdGhlIGh5cGVydmlzb3IgY29kZSBiYXNlLiBJZiB0aGVyZSdzDQo+IGEgc3Ryb25nIHJlYXNv
biwgd2UgY291bGQgY29uc2lkZXIgc3dpdGNoaW5nIHRoZSBlbnVtIGZvciBhIHUzMiBoZXJlDQo+
IHNpbmNlLCBhdCBsZWFzdCBmb3IgdGhlIG1vbWVudCwgdGhlcmUncyBvbmx5IGEgc2luZ2xlIHZh
bHVlIGJlaW5nIHVzZWQuDQo+IA0KDQpJbiB0aGUgQyBsYW5ndWFnZSwgdGhlIHNpemUgb2YgYW4g
ZW51bSBpcyBpbXBsZW1lbnRhdGlvbiBkZWZpbmVkLiBEbw0KYSBDby1QaWxvdCBzZWFyY2ggb24g
IkhvdyBtYW55IGJ5dGVzIGlzIGFuIGVudW0gaW4gQyIsIGFuZCB5b3UnbGwgZ2V0IGENCmZhaXJs
eSBsb25nIGFuc3dlciBleHBsYWluaW5nIHRoZSBpZGlvc3luY3Jhc2llcy4gRm9yIGdjYywgYW5k
IGZvciBNU1ZDIG9uDQp0aGUgaHlwZXJ2aXNvciBzaWRlLCB0aGUgZGVmYXVsdCBpcyB0aGF0IGFu
ICJlbnVtIiBzaXplIGlzIHRoZSBzYW1lIGFzIGFuDQoiaW50Iiwgc28gZXZlcnl0aGluZyB3b3Jr
cyBpbiBjdXJyZW50IHByYWN0aWNlLiBCdXQgdGhlIGNvbXBpbGVyIGlzIGFsbG93ZWQNCnRvIG9w
dGltaXplIHRoZSBzaXplIG9mIGFuIGVudW0gaWYgYSBzbWFsbGVyIGludGVnZXIgdHlwZSBjYW4g
Y29udGFpbiBhbGwNCnRoZSB2YWx1ZXMsIGFuZCB0aGF0IHdvdWxkIG1lc3MgdGhpbmdzIHVwIGlu
IGFuIEFCSS4gSGVuY2UgdGhlIGludGVudA0KdG8gbm90IHVzZSAiZW51bSIgaW4gdGhlIGh5cGVy
dmlzb3IgQUJJLiBXaW5kb3dzL0h5cGVyLVYgaGlzdG9yaWNhbGx5DQpkaWRuJ3QgaGF2ZSB0byB3
b3JyeSBhYm91dCBzdWNoIHRoaW5ncyBzaW5jZSB0aGV5IGNvbnRyb2xsZWQgYm90aCBzaWRlcw0K
b2YgdGhlIEFCSSwgYnV0IHRoZSBtb3JlIExpbnV4IHVzZXMgdGhlIEFCSSwgdGhlIGdyZWF0ZXIg
cG90ZW50aWFsIGZvcg0Kc29tZXRoaW5nIHRvIGdvIHdyb25nLg0KDQpJIHdpc2ggV2luZG93cy9I
eXBlci1WIHdvdWxkIHRpZ2h0ZW4gdXAgdGhlaXIgQUJJIHNwZWNpZmljYXRpb24sIGJ1dA0KaXQg
aXMgd2hhdCBpdCBpcy4gU28gSSdtIG5vdCBzdXJlIGhvdyBiZXN0IHRvIGRlYWwgd2l0aCB0aGUg
aXNzdWUgaW4gbGlnaHQNCm9mIHdhbnRpbmcgdG8gdGFrZSB0aGUgaHlwZXJ2aXNvciBBQkkgZGVm
aW5pdGlvbnMgZGlyZWN0bHkgZnJvbSB0aGUNCldpbmRvd3MgZW52aXJvbm1lbnQgYW5kIG5vdCBt
b2RpZnkgdGhlbS4gSSBkaWQgYSBxdWljayBncmVwIG9mIHRoZQ0KaHYqLmggZmlsZXMgaW4gaW5j
bHVkZS9oeXBlcnYgZnJvbSBsaW51eC1uZXh0LCBhbmQgd2hpbGUgdGhlcmUgYXJlIG1hbnkNCmVu
dW0gdHlwZXMgZGVmaW5lZCwgbm9uZSBhcmUgdXNlZCBhcyBmaWVsZHMgaW4gYSBzdHJ1Y3R1cmUu
IFRoZXJlIGFyZQ0KbWFueSBjYXNlcyBvZiB1MzIsIGFuZCBhIGNvdXBsZSB1MTYncywgZm9sbG93
ZWQgYnkgYSBjb21tZW50DQppZGVudGlmeWluZyB0aGUgZW51bSB0eXBlIHRoYXQgc2hvdWxkIGJl
IHVzZWQgdG8gcG9wdWxhdGUgdGhlIGZpZWxkLg0KDQpNaWNoYWVsDQo=

