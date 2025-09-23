Return-Path: <linux-arch+bounces-13720-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6880B93E3E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 03:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6432E2F79
	for <lists+linux-arch@lfdr.de>; Tue, 23 Sep 2025 01:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8383246BB4;
	Tue, 23 Sep 2025 01:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FK6aimIW"
X-Original-To: linux-arch@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azolkn19011036.outbound.protection.outlook.com [52.103.12.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7891DB54C;
	Tue, 23 Sep 2025 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591336; cv=fail; b=WLi0wI7D5KZ3t9/BlG+Qx4Znv2az+yGJddeTRNdkUO4cnrhDURNxhZCQZHbZ1I+yHK88fQNfP5JVFRELevZoaA61Gb0xH7ul98GzL2Urtm6WTLQ8zaW+6akABSqKFrQ7Co/ulZq4cXl+vGZwRPYOq4j/Ra3avPVy0SXoJSj2DRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591336; c=relaxed/simple;
	bh=PFvVWb5jedZkUO9jspsg6uXirWiKaBUDnSa4mKRBS/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pOEY5xcoJshHJcGSWhfHfIsQUtvDIk/d528WBrRjr5XmXLhHD7LKQ5lH5xha1URAxCfUQW4h53w60WV0AaRqt0ewmNyo8FIiFZPMv3nn2J9QSQDSfdsporJt8G0y2jqRLWbX5Qt56MbNajrId3siiYYh2sANr1cBKJbvJyZldjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FK6aimIW; arc=fail smtp.client-ip=52.103.12.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkgMdalX7TeZbD5Wh7FsiCy74+km/k/G632eCWlOYiWqbVBFhRHWEeXObcET3PmweKVoXS0QgjmrTcJshKCQZsHnpwwde+4ns9oZNQJ4pJo1A0HiEX/okTJ324jVMlRyJI7IoRP0JrcTuScQkb+gOu89tivKT0rEGb8IPRs34DvR0hjOfwNF0lepBOd31oCKEHhSK0Q4Y4CoWfRKvCFBECsmA3u5txfU7yCmfgsEXpPygriXJTqxLtbFWyGJ/IYwxsz3t4W/eeO+/z+QSejEY9fEuA6wY7pDQ86dsfMZ8e0YZPV0zcuIeplK3YCIRy+eXpVB3/Bld0aia5hTpXegSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFvVWb5jedZkUO9jspsg6uXirWiKaBUDnSa4mKRBS/Q=;
 b=gFTrF/wnS+ccjKqhEvN22CJAMrPuKWEDo+bxHm5tOwympYdbWrTc5qMyrvkI1tZU73RCgyQQHaRMDQxAlUDgIph+6D6ljJTkDZING6pESVPP4WxbBzXGYISVw2nrq2OAMQYxYVOHMTX2jSTRYH76f/cPXU86f1TOLHevvxXi6INY5h7AuIeYG+CWi2fopWm+O4bz7A/eLPOQyKpCt9Bp+v/ZJtyD3T2UzsYJHeNt/Q7WXSeH1U4FXJG4qRQvgyqVxINwSEVu9Ov5wFLBSbmAhs/dpwvTUAcvuUG1bZ/RShzYaSot98Q0EHtnwIZ0Cy+XOfY7bwGFX9xTAMEMsSJuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFvVWb5jedZkUO9jspsg6uXirWiKaBUDnSa4mKRBS/Q=;
 b=FK6aimIW9ZBa/tFuszkFj908O6tDyQmJhkT7KYfpJQ8qBr9UMdEIPpp8oc/uNM1orAsz+ofYqmumFW5RgZeLB78XTDJkwfM6vfm3ZfAT2RRyqCvwb6Q55jGZCb4JMbNop1+H77EeYVLjhpsPXNBI81cjzhQ8AFVdBOvAyzyNfvOl9N1ua+xLjFR3hk7tdC2a3+L+I110mjPE7JKVEg7BEsdg8RU2x8KxeWS60H23rxq3h8mDN9DbfexxfQWjsXmDfYwPKS7PpAGDKhXSBFBACFoalPwnVf7mVFYnv5NuhfPdCKyaJgOWcVEO2po3oyaR4v2gbjUkybR4AbnPLODQBQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8686.namprd02.prod.outlook.com (2603:10b6:a03:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 23 Sep
 2025 01:35:27 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 01:35:27 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Thread-Topic: [PATCH v1 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Thread-Index:
 AQHcIeeHwOAc5qTPekmo9sfTvV5JMLSTKvtggANxwICAApl2cIAAoT4AgAGEbICABLNJUA==
Date: Tue, 23 Sep 2025 01:35:26 +0000
Message-ID:
 <SN6PR02MB4157C93C875579C2F5CDA71BD41DA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-6-mrathor@linux.microsoft.com>
 <SN6PR02MB4157CD8153650CC9D379A03DD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87cab5ec-ab76-b1cf-4891-30314e5dace6@linux.microsoft.com>
 <SN6PR02MB4157AFD23F088FC243A24C17D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <58e4f6b3-6ae3-4bf4-3e1f-0981d6af91ea@linux.microsoft.com>
 <eb755e6d-3adf-ee3b-2942-666bc1bedef5@linux.microsoft.com>
In-Reply-To: <eb755e6d-3adf-ee3b-2942-666bc1bedef5@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8686:EE_
x-ms-office365-filtering-correlation-id: bb7ace20-340c-43b7-b54b-08ddfa417937
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|13091999003|31061999003|461199028|15080799012|19110799012|41001999006|40105399003|440099028|3412199025|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?TjFRNHZQN3NIbGJja2cxQk5WQ0JlOTNzd3dRRUs5YnVVUCtPcWEyWmYrUzlo?=
 =?utf-8?B?SU1XcFFxR2ZJSEdnUkhjQjI0aGtiREk2c2dTMk94S3ZBSDhjVVBQMlVmSEtU?=
 =?utf-8?B?L2JNTVkwa1BRWnZUU0pncEFlaWVzYUlISVJIVHVNL0NkOWtPZWZVU1o4eGdQ?=
 =?utf-8?B?alh4eXA1blJ2YkhJYk9TV0hMTE95bUhxdnZrV3pjVVlFZTJlYnFZbWZJWlQ2?=
 =?utf-8?B?YUxRbEcrSUlkTUpEalA4cVY2c1hOdktScWpOZ08yY0Vka3VTR3lCQUNRMGp0?=
 =?utf-8?B?Y0NydFJNWXRTQWh3cTZHRGd4V25kMXZ6VVpyb3lWNFRJQ0RWK2dVQmVOU0Ny?=
 =?utf-8?B?NktmRC9QbTNiZUVUdmRqYzlOOFI5OGtjbFU2L0dWZ1hEcTBWMTdieGtVVzdV?=
 =?utf-8?B?cUtUbUNXU1lPaTRuZTdBd1BIRnNFbzBjVkpPdU9BZlJFUGRiM1NYem5jRkFD?=
 =?utf-8?B?TGIvOUVmR2dqK2hNK3FPOFBzc3p4bjFQNFhwbmFaSnJrZFhRQ3Y5OEhBN2hh?=
 =?utf-8?B?K1M2b2lwNUlEUGllbzBOM2ZZTjFuRzY5ZEpKbG51elhxNDNXQVpvWEpBZXBP?=
 =?utf-8?B?OFdhakFYUjI5SDBMN0huYjRmeDBXSmFtdGpva3FVMnJsK1VFNjlyZXZqRkdw?=
 =?utf-8?B?M1FiVGpCZ0NBZVI4c3dqV011K1J0L254WStzOExTRk9QcDIwUTVCQkJsY1ph?=
 =?utf-8?B?OHU2QTBPcHhsWm9LbU04TDJjU0FjZzdZOHh6NWxPb2xBdGpPaG50U1VGT291?=
 =?utf-8?B?L201VE1JcDBIU2lTVXBSZkZBWFBNcFlSeW5xeEhIZCtqN1NsbEpmSW9jMU9E?=
 =?utf-8?B?K04yVERwYUVHSEJlL0tPT2V4T3EzY2VxdFVKUnpQV3BRYlJVWlVBdGpZcnRn?=
 =?utf-8?B?dG1vTXN1VlB6NTlMN0QwME9pRnRiY0pRUS92UHQ2RkZ4OWVOd3FDUlgzQW1h?=
 =?utf-8?B?U1RHTmZLVE43dUlpNnN0OGFpblV1UTJlYUN4VDUyMnRTUTBmbWFDSDc1UG9q?=
 =?utf-8?B?TDdUcEhkOVRORGFSdCt5Qmd5djIyUTNGOTB4b1U0cERFR2VPK0RBQm8wRlo3?=
 =?utf-8?B?bU9LQlZ5UWEzbGZYR2puYUFueWFad2h5VnNPckNUby9IM1ZNZ3FWR1RnVW5O?=
 =?utf-8?B?ejd4RXlaTEZ6VFBNTXBXV3ZiOXprak5IMW5MVzBQd1Z4UXJYVWVOM0FhVDV3?=
 =?utf-8?B?M3o5cEkwTmZRclZVQlBOVjhLaDFnQ2drTk9RNE4vcHNjQ1YwcVBBQjJsUnQ3?=
 =?utf-8?B?U00wRUx6aUtlSnZhRkt1Uk94OXpvR2xXQ3FwN2dQZmtEWFRTMGZ4RkJEalVY?=
 =?utf-8?B?cVJpVXVXc29EdEZBTGRPSGhRTzFVMzNOa3VUYnZEVmJDY25meC9TbUtpdmpj?=
 =?utf-8?B?cm5qQXhYLysxQ3ZMQnNsZ05CM2RnNU1DUmFBT0ViaUlENFJ3UHdKU1FMRm8r?=
 =?utf-8?B?WjErYTN6b0o5VFNKRVJtVGRINlB5VmIxaDc1RU8xTUs1VXZIaWVkZDhsdFA0?=
 =?utf-8?B?SFE0UGsydDhlYWtSWVFtNVRRaU1sUE9adEhINEc3ek1GeTdjNHRjTEhQL0NU?=
 =?utf-8?B?aENXdDJtcVNlU0JxNDJnTm9YdEprSTNXV1BGRk1LOFBsTWEwUDVYTkxuT29H?=
 =?utf-8?Q?UKSuhXEobzNuFULdPueTXYSgHaX31XzKYsLFjhqp3WEI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tld0eFg3YysyM1lSbWszRG9uZkdTdThsR1VjMnVsOElpaEtnYlFJVSs0SjUx?=
 =?utf-8?B?eFRKUW1Qc2sxSkE3ZEZhV1g1WC9hcEZDOHpBdzVTZWtCWkJWSkg1RDY4aUMy?=
 =?utf-8?B?Zy9GWEhaRjFzRk5RSGkzR1ZXSFhCUW9NbzFoRGZDK0Z3ZkJuYWRjV2YwTjds?=
 =?utf-8?B?eW5sZ3MrL1Y1THoxM0htdmFBREhmaDFCR3VFOGJoWUh5MDZBV1cwYnozU08v?=
 =?utf-8?B?Wk5SUXBqcVVldWxEb0poVm9NVzdVRktHQ3E3VHVsVzViR3VDM1ZqTlRkRWlj?=
 =?utf-8?B?MFlPQm5hMzd5ajhPMHhPdTJpTGxiSThKVmdCWHNPbFR5eWpRWUQ2ZnlZUHBQ?=
 =?utf-8?B?VXpoUGtpbSt4aXFaSnM2Q1NTQitKQlA2VU5zS3ZvbjQ3bDY2RlpIRXdiWGdN?=
 =?utf-8?B?MjZvaXhpZjBoV0h0cDRjZ2Y4MXBVekRpUnBUcEJHV25MS2piYTBJejhNUDRG?=
 =?utf-8?B?RUJqdlN2TjZIUUorZVpzWHpyaWlSRW5GN0RUR2MyREFqWkl5NFN3bHlOWTNS?=
 =?utf-8?B?ZmhTNzZEUU9hZ2VlbVBWSmI0eWtKSFZNRkp4dTZ4ZHRyZlp5SEwvZ0Q3Y2tY?=
 =?utf-8?B?MUl1cldwV1RjcG01bnZjSUxzQ2Yzd21iR1l3cHRzd2V0cUZuOW1MS2Q4cHRQ?=
 =?utf-8?B?U1VQK2xIdmF5bk91N3dGcHl3TEdKZno3cE01RkxUblUvT3REeW9RcUJXQ0N4?=
 =?utf-8?B?cXg4MmtjczB4RHA4M24vMERDdzFjQUFCS2hoRENxWjNUMVcrZUttK1JpbGJS?=
 =?utf-8?B?cVEwT0ZEb0FzODl0K3djTEduT3g1eUxaR1hZR2w0QnBLajNqMDUweS9XczV3?=
 =?utf-8?B?RWkzVVI0K0liWUtOZlFTdkJxT0o1dm1JMzlreTEraUtJa0pUYVBxUnJjYmVx?=
 =?utf-8?B?ZnhuTGpTNlE5aWJkRWwyT05LRC8xTHArMWVSMUp1c2pkTno0VlhpbUJpelJk?=
 =?utf-8?B?NHdaRERWa2hhdmF2bkhITXQyTTRpRnYxZG9MOUxyRDlPeTBBZkVLM2Y3TzM3?=
 =?utf-8?B?Z2tncGZGSmxMeHM5Zis1UWxjalEzOGpxTFEzWmZMajh2d1o5bFk1c0s0ZHVQ?=
 =?utf-8?B?U2pJRHpDb01GdC9senZGQWlvSjMzWDVtMTU0VXN5Smw2U3Rpd0lxdm11NVNq?=
 =?utf-8?B?c1JMUU9rUlYreUxkWVFJNFNnZ3paMFluYUlTbTRoQW05UGJaQmk0MXp5OEha?=
 =?utf-8?B?UDhkYTM2cHhwSjRmTUdlNkoyQ3dHVnFkemI2d2MrZS85ZHFabm5uU2tlNW5a?=
 =?utf-8?B?cG03TjhnZFBaR0FBTkg1dTJDeHRlcVQ2QXduRXRTZnhXY29qem9TblZlUXNK?=
 =?utf-8?B?NUN6S3pObFMwdWs1N1dZaVFFYXNiZUcyY2Y5SWNzYk9YejIxNHZtaUo1d1pj?=
 =?utf-8?B?dHR4aVZvUFZOUTFOczhzc05FMVRWek9ES05ydWZ4VG5zdGZPTG1XUXdIeW5Q?=
 =?utf-8?B?b2NlYVJ5TFluNEtrdXZEdUJweDlkK1Y4b2FoZUFOeVJRRVhBYWRJTnh2ZE04?=
 =?utf-8?B?RlBMTFFXek9xRmhyUm1NblZQUFRGYjRJeFdobnBNU2lnMHhSQS9Cek4wMldE?=
 =?utf-8?B?dFV3aXpNM25XQ0xDV1oxeXNLbkQxUElaOFNhWG13bGFYaE9iakVLc2U1SXhh?=
 =?utf-8?Q?lyA0RauVADcQiRfYO2M4lo9xOgqO2rQJDrsmgMMTTed4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7ace20-340c-43b7-b54b-08ddfa417937
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 01:35:26.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8686

RnJvbTogTXVrZXNoIFIgPG1yYXRob3JAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5
LCBTZXB0ZW1iZXIgMTksIDIwMjUgNjo0MyBQTQ0KPiANCj4gT24gOS8xOC8yNSAxOTozMiwgTXVr
ZXNoIFIgd3JvdGU6DQo+ID4gT24gOS8xOC8yNSAxNjo1MywgTWljaGFlbCBLZWxsZXkgd3JvdGU6
DQo+ID4+IEZyb206IE11a2VzaCBSIDxtcmF0aG9yQGxpbnV4Lm1pY3Jvc29mdC5jb20+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxNiwgMjAyNSA2OjEzIFBNDQo+ID4+Pg0KPiA+Pj4gT24gOS8x
NS8yNSAxMDo1NSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQoNCltzbmlwXQ0KDQo+ID4+Pj4+ICsv
Kg0KPiA+Pj4+PiArICogQ29tbW9uIGZ1bmN0aW9uIGZvciBhbGwgY3B1cyBiZWZvcmUgZGV2aXJ0
dWFsaXphdGlvbi4NCj4gPj4+Pj4gKyAqDQo+ID4+Pj4+ICsgKiBIeXBlcnZpc29yIGNyYXNoOiBh
bGwgY3B1cyBnZXQgaGVyZSBpbiBubWkgY29udGV4dC4NCj4gPj4+Pj4gKyAqIExpbnV4IGNyYXNo
OiB0aGUgcGFuaWNpbmcgY3B1IGdldHMgaGVyZSBhdCBiYXNlIGxldmVsLCBhbGwgb3RoZXJzIGlu
IG5taQ0KPiA+Pj4+PiArICoJCWNvbnRleHQuIE5vdGUsIHBhbmljaW5nIGNwdSBtYXkgbm90IGJl
IHRoZSBic3AuDQo+ID4+Pj4+ICsgKg0KPiA+Pj4+PiArICogVGhlIGZ1bmN0aW9uIGlzIG5vdCBp
bmxpbmVkIHNvIGl0IHdpbGwgc2hvdyBvbiB0aGUgc3RhY2suIEl0IGlzIG5hbWVkIHNvDQo+ID4+
Pj4+ICsgKiBiZWNhdXNlIHRoZSBjcmFzaCBjbWQgbG9va3MgZm9yIGNlcnRhaW4gd2VsbCBrbm93
biBmdW5jdGlvbiBuYW1lcyBvbiB0aGUNCj4gPj4+Pj4gKyAqIHN0YWNrIGJlZm9yZSBsb29raW5n
IGludG8gdGhlIGNwdSBzYXZlZCBub3RlIGluIHRoZSBlbGYgc2VjdGlvbiwgYW5kDQo+ID4+Pj4+
ICsgKiB0aGF0IHdvcmsgaXMgY3VycmVudGx5IGluY29tcGxldGUuDQo+ID4+Pj4+ICsgKg0KPiA+
Pj4+PiArICogTm90ZXM6DQo+ID4+Pj4+ICsgKiAgSHlwZXJ2aXNvciBjcmFzaDoNCj4gPj4+Pj4g
KyAqICAgIC0gdGhlIGh5cGVydmlzb3IgaXMgaW4gYSB2ZXJ5IHJlc3RyaWN0aXZlIG1vZGUgYXQg
dGhpcyBwb2ludCBhbmQgYW55DQo+ID4+Pj4+ICsgKgl2bWV4aXQgaXQgY2Fubm90IGhhbmRsZSB3
b3VsZCByZXN1bHQgaW4gcmVib290LiBGb3IgZXhhbXBsZSwgY29uc29sZQ0KPiA+Pj4+PiArICoJ
b3V0cHV0IGZyb20gaGVyZSB3b3VsZCByZXN1bHQgaW4gc3luaWMgaXBpIGhjYWxsLCB3aGljaCB3
b3VsZCByZXN1bHQNCj4gPj4+Pj4gKyAqCWluIHJlYm9vdC4gU28sIG5vIG11bWJvIGp1bWJvLCBq
dXN0IGdldCB0byBrZXhlYyBhcyBxdWlja2x5IGFzIHBvc3NpYmxlLg0KPiA+Pj4+PiArICoNCj4g
Pj4+Pj4gKyAqICBEZXZpcnR1YWxpemF0aW9uIGlzIHN1cHBvcnRlZCBmcm9tIHRoZSBic3Agb25s
eS4NCj4gPj4+Pj4gKyAqLw0KPiA+Pj4+PiArc3RhdGljIG5vaW5saW5lIF9fbm9jbG9uZSB2b2lk
IGNyYXNoX25taV9jYWxsYmFjayhzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gPj4+Pj4gK3sNCj4g
Pj4+Pj4gKwlzdHJ1Y3QgaHZfaW5wdXRfZGlzYWJsZV9oeXBfZXggKmlucHV0Ow0KPiA+Pj4+PiAr
CXU2NCBzdGF0dXM7DQo+ID4+Pj4+ICsJaW50IG1zZWNzID0gMTAwMCwgY2NwdSA9IHNtcF9wcm9j
ZXNzb3JfaWQoKTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCWlmIChjY3B1ID09IDApIHsNCj4gPj4+
Pj4gKwkJLyogY3Jhc2hfc2F2ZV9jcHUoKSB3aWxsIGJlIGRvbmUgaW4gdGhlIGtleGVjIHBhdGgg
Ki8NCj4gPj4+Pj4gKwkJY3B1X2VtZXJnZW5jeV9zdG9wX3B0KCk7CS8qIGRpc2FibGUgcGVyZm9y
bWFuY2UgdHJhY2UgKi8NCj4gPj4+Pj4gKwkJYXRvbWljX2luYygmY3Jhc2hfY3B1c193YWl0KTsN
Cj4gPj4+Pj4gKwl9IGVsc2Ugew0KPiA+Pj4+PiArCQljcmFzaF9zYXZlX2NwdShyZWdzLCBjY3B1
KTsNCj4gPj4+Pj4gKwkJY3B1X2VtZXJnZW5jeV9zdG9wX3B0KCk7CS8qIGRpc2FibGUgcGVyZm9y
bWFuY2UgdHJhY2UgKi8NCj4gPj4+Pj4gKwkJYXRvbWljX2luYygmY3Jhc2hfY3B1c193YWl0KTsN
Cj4gPj4+Pj4gKwkJZm9yICg7Oyk7CQkJLyogY2F1c2Ugbm8gdm1leGl0cyAqLw0KPiA+Pj4+PiAr
CX0NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCXdoaWxlIChhdG9taWNfcmVhZCgmY3Jhc2hfY3B1c193
YWl0KSA8IG51bV9vbmxpbmVfY3B1cygpICYmIG1zZWNzLS0pDQo+ID4+Pj4+ICsJCW1kZWxheSgx
KTsNCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCXN0b3Bfbm1pKCk7DQo+ID4+Pj4+ICsJaWYgKCFodl9o
YXNfY3Jhc2hlZCkNCj4gPj4+Pj4gKwkJaHZfbm90aWZ5X3ByZXBhcmVfaHlwKCk7DQo+ID4+Pj4+
ICsNCj4gPj4+Pj4gKwlpZiAoY3Jhc2hpbmdfY3B1ID09IC0xKQ0KPiA+Pj4+PiArCQljcmFzaGlu
Z19jcHUgPSBjY3B1OwkJLyogY3Jhc2ggY21kIHVzZXMgdGhpcyAqLw0KPiA+Pj4+DQo+ID4+Pj4g
Q291bGQganVzdCBiZSAiY3Jhc2hpbmdfY3B1ID0gMCIgc2luY2Ugb25seSB0aGUgQlNQIGdldHMg
aGVyZS4NCj4gPj4+DQo+ID4+PiBhIGNvZGUgY2hhbmdlIHJlcXVlc3QgaGFzIGJlZW4gb3BlbiBm
b3Igd2hpbGUgdG8gcmVtb3ZlIHRoZSByZXF1aXJlbWVudA0KPiA+Pj4gb2YgYnNwLi4NCj4gPj4+
DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlodl9odmNyYXNoX2N0eHRfc2F2ZSgpOw0KPiA+Pj4+PiAr
CWh2X21hcmtfdHNzX25vdF9idXN5KCk7DQo+ID4+Pj4+ICsJaHZfY3Jhc2hfZml4dXBfa2VybnB0
KCk7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwlpbnB1dCA9ICp0aGlzX2NwdV9wdHIoaHlwZXJ2X3Bj
cHVfaW5wdXRfYXJnKTsNCj4gPj4+Pj4gKwltZW1zZXQoaW5wdXQsIDAsIHNpemVvZigqaW5wdXQp
KTsNCj4gPj4+Pj4gKwlpbnB1dC0+cmlwID0gdHJhbXBvbGluZV9wYTsJLyogUEEgb2YgaHZfY3Jh
c2hfYXNtMzIgKi8NCj4gPj4+Pj4gKwlpbnB1dC0+YXJnID0gZGV2aXJ0X2NyM2FyZzsJLyogUEEg
b2YgdHJhbXBvbGluZSBwYWdlIHRhYmxlIEw0ICovDQo+ID4+Pj4NCj4gPj4+PiBJcyB0aGlzIGNv
bW1lbnQgY29ycmVjdD8gSXNuJ3QgaXQgdGhlIFBBIG9mIHN0cnVjdCBodl9jcmFzaF90cmFtcF9k
YXRhPw0KPiA+Pj4+IEFuZCBqdXN0IGZvciBjbGFyaWZpY2F0aW9uLCBIeXBlci1WIHRyZWF0cyB0
aGlzICJhcmciIHZhbHVlIGFzIG9wYXF1ZSBhbmQgZG9lcw0KPiA+Pj4+IG5vdCBhY2Nlc3MgaXQu
IEl0IG9ubHkgcHJvdmlkZXMgaXQgaW4gRURJIHdoZW4gaXQgaW52b2tlcyB0aGUgdHJhbXBvbGlu
ZQ0KPiA+Pj4+IGZ1bmN0aW9uLCByaWdodD8NCj4gPj4+DQo+ID4+PiBjb21tZW50IGlzIGNvcnJl
Y3QuIGNyMyBhbHdheXMgcG9pbnRzIHRvIGw0IChvciBsNSBpZiA1IGxldmVsIHBhZ2UgdGFibGVz
KS4NCj4gPj4NCj4gPj4gWWVzLCB0aGUgY29tbWVudCBtYXRjaGVzIHRoZSBuYW1lIG9mIHRoZSAi
ZGV2aXJ0X2NyM2FyZyIgdmFyaWFibGUuDQo+ID4+IFVuZm9ydHVuYXRlbHkgbXkgcHJldmlvdXMg
Y29tbWVudCB3YXMgaW5jb21wbGV0ZSBiZWNhdXNlIHRoZSB2YWx1ZQ0KPiA+PiBzdG9yZWQgaW4g
dGhlIHN0YXRpYyB2YXJpYWJsZSAiZGV2aXJ0X2NyM2FyZyIgaXNuP3QgdGhlIGFkZHJlc3Mgb2Yg
YW4gTDQgcGFnZQ0KPiA+PiB0YWJsZS4gSXQncyBub3QgYSBDUjMgdmFsdWUuIFRoZSB2YWx1ZSBz
dG9yZWQgaW4gZGV2aXJ0X2NyM2FyZyBpcyBhY3R1YWxseSB0aGUNCj4gPj4gUEEgb2Ygc3RydWN0
IGh2X2NyYXNoX3RyYW1wX2RhdGEuIFRoZSBDUjMgdmFsdWUgaXMgc3RvcmVkIGluIHRoZQ0KPiA+
PiB0cmFtcDMyX2NyMyBmaWVsZCAoYXQgb2Zmc2V0IDApIG9mIHRoYXQgc3RydWN0dXJlLCBzbyB0
aGVyZSdzIGFuIGFkZGl0aW9uYWwgbGV2ZWwNCj4gPj4gb2YgaW5kaXJlY3Rpb24uIFRoZSAoY29y
cmVjdGVkKSBjb21tZW50IGluIHRoZSBoZWFkZXIgdG8gaHZfY3Jhc2hfYXNtMzIoKQ0KPiA+PiBk
ZXNjcmliZXMgRURJIGFzIGNvbnRhaW5pbmcgIlBBIG9mIHN0cnVjdCBodl9jcmFzaF90cmFtcF9k
YXRhIiwgd2hpY2gNCj4gPj4gb3VnaHQgdG8gbWF0Y2ggd2hhdCBpcyBkZXNjcmliZWQgaGVyZS4g
SSdkIHNheSB0aGF0ICJkZXZpcnRfY3IzYXJnIiBvdWdodA0KPiA+PiB0byBiZSByZW5hbWVkIHRv
ICJ0cmFtcF9kYXRhX3BhIiBvciBzb21ldGhpbmcgZWxzZSBwYXJhbGxlbCB0bw0KPiA+PiAidHJh
bXBvbGluZV9wYSIuDQo+ID4NCj4gPiBoeXAgbmVlZHMgdHJhbXBvbGluZSBjcjMgZm9yIHRyYW5z
aXRpb24sIHdlIHBhc3MgaXQgYXMgYW4gYXJnLiB3ZSBwaWdneQ0KPiA+IGJhY2sgZXh0cmEgaW5m
b3JtYXRpb24gZm9yIG91cnNlbHZlcyBuZWVkZWQgaW4gdHJhbXBvbGluZS5TLiBzbyBpdCdzDQo+
ID4gYWxsIGdvb2QuDQo+IA0KPiBhY3R1YWxseSwgd2hhdCBpIHNhaWQgZWFybGllciB3YXMgdHJ1
ZSwgbm90IGFib3ZlLiB0aGF0IHRoZSBhcmcgaXMNCj4gb3BhcXVlIGFuZCBoeXAgZG9lcyBub3Qg
dXNlIGl0ICh3ZSBhcmUgdHJhbnNpdGlvbmluZyBwYWdpbmcgb2ZmIGFmdGVyDQo+IGFsbCEpLiBp
IGRpZCB0aGlzIGFsbCBhbG1vc3QgdHdvIHllYXJzIGFnbywgc28gaGFkIHZhZ3VlIHJlY29sbGVj
dGlvbnMNCj4gYnV0IGZpbmFsbHkgaGFkIHRpbWUgdG9kYXkgdG8gZ28gYmFjayB0byBzcXVhcmUg
b25lIGFuZCBvbGQgbm90ZXMsDQo+IGFuZCByZW1lbWJlciB0aGluZ3Mgbm93LiBzbyBmaW5hbCBh
bnN3ZXI6DQo+IA0KPiB0aGUgaHlwZXJjYWxsIGNhbGxzIGl0IFRyYW1wb2xpbmVDcjMsIGkgZ3Vl
c3MgdGhpcyBpcyBob3cgd2luZG93cyB1c2VzIGl0DQo+ICh0aGV5IGhhdmUgY3VzdG9taXplZCBr
ZXJuZWwgY29kZSBmb3IgY29yZSBjb2xsZWN0aW9uKS4gZG9pbmcgdGhhdCB3YXMNCj4gYmVjb21p
bmcgdG9vIGludHJ1c2l2ZSBvbiBsaW51eCwgc28gaSBkZWNpZGVkIHRvIHVzZSB0aGUgYXJnIHRv
IHBhc3MgdGhlDQo+IGluZm8gaSBuZWVkZWQgaW4gdGhlIHRyYW1wb2xpbmUgY29kZS4gU2luY2Ug
dGhlIGh5cGVyY2FsbCBjYWxscyB0aGUgYXJnDQo+IFRyYW1wb2xpbmVDcjMsIGkgbXVzdCBoYXZl
IGp1c3QgdXNlZCB0aGF0IG5hbWUgZm9yIHRoZSBhcmcgdG8gbWF0Y2ggaXQsDQo+IHByb2JhYmx5
IGZhbHNlbHkgYXNzdW1pbmcgaHlwZXJ2aXNvciBzb21laG93IGxvb2tlZCBhdCBpdC4gKGFjdHVh
bGx5LA0KPiB0aGUgd2luZG93cyBoeXBlcmNhbGwgd3JhcHBlciBkb2VzIGxvb2sgYXQgaXQgdG8g
bWFrZSBzdXJlIGl0IGlzIGENCj4gcmFtIGFkZHJlc3MpLg0KPiANCj4gc2luY2UgdGhlIGh5cGVy
Y2FsbCBkb2Vzbid0IHVzZSB0aGUgYXJnLCBpdCBjb3VsZCBqdXN0IGNhbGwgaXQNCj4gZGV2aXJ0
QXJnLCBidXQgbWF5YmUgaW4gdGhlIHBhc3QgdGhleSB1c2VkIGl0IHNvbWVob3cuIGluIG15IGxh
dGVzdA0KPiB2ZXJzaW9uLCBpIGp1c3QgY2FsbCBpdCBkZXZpcnRfYXJnLg0KDQpPSy4gIEdvb2Qg
dG8gZ2V0IHRoaXMgYWxsIHN0cmFpZ2h0ZW5lZCBvdXQuIFBsZWFzZSBsZWF2ZSBhIGNvZGUNCmNv
bW1lbnQgdG8gdGhlIGVmZmVjdCB0aGF0IHRoZSBoeXBlcmNhbGwgZG9lc24ndCB1c2UgdGhlIGFy
ZywgYW5kDQp0aGF0IHRoZSB2YWx1ZSBpcyBwcm92aWRlZCBzb2xlbHkgdG8gYmUgcGFzc2VkIHRv
IGh2X2NyYXNoX2FzbTMyKCkNCmZvciBpdCB0byB1c2UuIFRoYXQgbWVhbnMgdGhhdCBzdHJ1Y3Qg
aHZfY3Jhc2hfdHJhbXBfZGF0YSBpcyBvd25lZA0KYnkgTGludXggYW5kIGNhbiBiZSBjaGFuZ2Vk
L3VwZGF0ZWQgYXMgbmVlZGVkLg0KDQpUaGUgYXNzaWdubWVudCBzdGF0ZW1lbnQgdG8gdGhlIGh5
cGVyY2FsbCBpbnB1dCBjb3VsZCBsb29rIGxpa2U6DQoNCmlucHV0LT5hcmcgPSBkZXZpcnRfYXJn
OwkvKiBQQSBvZiBzdHJ1Y3QgaHZfY3Jhc2hfdHJhbXBfZGF0YSAqLw0KDQp3aGljaCB3b3VsZCBh
bGlnbiB3aXRoIHRoZSBjb21tZW50IGluIHRoZSBoZWFkZXIgb2YgaHZfY3Jhc2hfYXNtMzIoKS4N
Cg0KTWljaGFlbA0K

