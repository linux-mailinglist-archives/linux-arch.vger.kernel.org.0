Return-Path: <linux-arch+bounces-2985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B187B5CF
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 01:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B01C20B56
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 00:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A6029AB;
	Thu, 14 Mar 2024 00:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uaH8Ybmt"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2063.outbound.protection.outlook.com [40.92.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC611FB4;
	Thu, 14 Mar 2024 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376213; cv=fail; b=dOZBRCAy4UFpVA/Lxw6DC/1CqdsTs2H20+6jfo6w0iGwaOzPiZajVJ5ur5c7KxXm0v3bwXrzhXDTevQbgP+M9DN3O7NsJAXX8Bbq5ztAGONO0cAbjKXou/0Jxwg7A9ccKaPJGCgh5GbeYv31FiVdcmpRxi2OdnlQQmeE7+KDNlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376213; c=relaxed/simple;
	bh=ooT3R0ApHqSfh2P1J1seqcwNqPR3S4Dlq7n5r/zeWWA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oved1bIwHtDkN7fijoyyJronAwNdEbo8Y22ybNkLPpuaFLoT/pVNLU2x973l42PKSWY0juL+pPNV3voqEMVcdmPdr1d0uVyv+9I1KH8rqCPMtTmPAlfDRJEWaJxqnie46lFVgDAL+2+nm0vS55q+nr0OoQDosZ+siMDpUZwQH8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uaH8Ybmt; arc=fail smtp.client-ip=40.92.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VyryE/R1vSd9LCUiISQnJ5QhrGrXhSlOM9dNfDpbyEpIT5DbVg6RhT/BIHVjUE1h8nDmEXXKGpGJN2Qcren5FmhS0zvpI0J+V0fM8fWTTa2Ax118O0LEnYKdjWU0dKuIbR5Ziez8YVXUvY8YVRxcyU5gaNxkQ9j9cbonIz/6gCaW22y1R+KP0AzJzpJIr5XqeURsPs4Z8tfue9kgo5uS/eCxvBXUVvgRE12ukWcpvAkKll84pTp2FbxJOXEHkTRxAfbPG2bhYd1e6W92fKQFgKbo98QveQcR22gDsbg0aDR6ubH3Hb/Msaz/bn+f5+5dCK0cemOwE51MKD8IaEtY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooT3R0ApHqSfh2P1J1seqcwNqPR3S4Dlq7n5r/zeWWA=;
 b=C/ZeceBwOKbqQREWbhJNq4n3gsOXzNaQb7+uArC2PvYNR4jABiJvObZYuvEMNzdnTAezv2smXz5jnLpigGMWYdIXDaIltT6yo7uKniRRkTmFXVxD1A39AvcPgzYlcmVYH45P3YzCjqRlXpX8vaM6HT953/URDGnPOTCrCiLckFKjv9iCT3JVgrHLG8n58D69deNcVOFQ27cF5FAyyLybo1DXoz57IAw+XciFthRGTO7jqw/EzwKB62p04EFbkQpfLxUe/mLjvHc7v1PGROkAONi/H3v2dH6M46u3iALeFP0GKM9+cg5ubZUhpO8wxRrkdNTyTcmgsgpSR0J6SgqLCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooT3R0ApHqSfh2P1J1seqcwNqPR3S4Dlq7n5r/zeWWA=;
 b=uaH8YbmtSSTEjGcMnlmCCKae18aaLuS1ETAF+3N6MGYibDrHMMtFArR4xh/3lcjpofSx36SFEwt+sJOCQLJGOaYV1+Y4RHMz1fyrGv43rXVgCutKKw3YH28nqNNaMNFDctgNI9S0/qEt81H986lfCE4J4rAu5IYnc1dQ5ABzbH3KFDlLiwenshUysU3fXOIRengyZXj1rEIU4POOPBTJ5D6QQdaljlpKIdJzfyAObFus9BbsQceNTtNRL5Av2XNaORb00no3P6FfNSHjUR/9mRM/XUmNuNvR5O+QNimY+/WrBAIGRa34S6zWgq8/VPsidoSGehX0gEGDsOFE7fVzSQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7074.namprd02.prod.outlook.com (2603:10b6:a03:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 00:30:06 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 00:30:06 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>, "tytso@mit.edu"
	<tytso@mit.edu>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Topic: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest
 random number generator
Thread-Index: AQHacMAZOd50lMXg2E+WGXTGLlHRJ7E2XAeAgAAJkfA=
Date: Thu, 14 Mar 2024 00:30:06 +0000
Message-ID:
 <SN6PR02MB41576DD458EB3C72F3784EDBD4292@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240307184820.70589-1-mhklinux@outlook.com>
 <ZfI3owmQOKc4Ta_X@zx2c4.com>
In-Reply-To: <ZfI3owmQOKc4Ta_X@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [PnPyJYwOkmxqgtHO01JAIIpReXpO16bw]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7074:EE_
x-ms-office365-filtering-correlation-id: 3a3e2b3c-56ab-4990-f9f6-08dc43bde5fa
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VmXz6TSeeNViPezUmkJ1Ah3hvgzfisqSKVqvoIJnYaTRnxWW63XUAa+ZLflYVsU4wxHfwLIquoX5ikk6OqzA0nTEI/jHsPV+bEUSxKd0p9RU9FlLpcLMSLkV6EIYkhVsUYyd+i3WzWJTkqOgt3D4UG4s4SYKWgdDnjV5UjNEqulKlIDtN+YZGEhnjJTA7BYGcQZ1syA59Ahta/7sLIJm3TXVk4VtRcvlWHTBfm5yta7YHl66xreeIgvUJYwlJAtwevA/xd/DK4Y/un6zFDFj3/4uQ0AI3gMR/qQls1IqFSX3TSR9X0Fb8dk+XJ9+Icky76lUZNnJlnJ2HxVDLW/k6fqAyF50D2wtt3LLj24D4W4Oi1J19gheoFYulPwZ5ED/95dm2oJ0ESgXVVVUwPPs8ybOC9prs+suyebe+h3U7jWOvfZcWVkz7ZK9JAbC2C13ePsBLGfMBswDmLDGhnFsJszEviarl+zInREiU6UIjEa7x4UaHL1EKzOWnsduh+/xRjd5oQd6CWKcd7PIgCtpbHL9EpEAi2PvcfvPGcoeY4gHjzQ4MtrBPjJlZluti70A
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEs5MXlUQUJpTU5oQy9GSmFrSytnd0N2M3FPUDRSVGphMVc4S3hydm82MGNP?=
 =?utf-8?B?UDFHUTlTMTVNQ1hEZkVURHRlKytUMFlNbTBsOGhaSGI0WWY3a1lnYmNRelpI?=
 =?utf-8?B?NlhiaWZxMW5EZWowekRJM1hVSXhQREY1WmZ2Zkl1UEsrc01GQlVrN1FWTW82?=
 =?utf-8?B?UFJCZXFKbVM5bURDTGFHdXJyK3hIRmNlZ0FVMTZmTldvNzhQMzJZcHBndjVH?=
 =?utf-8?B?cUZLbXd2NGxSWVFmZDZxeHZtTFRBZWV6dWdINTRaeS81Y2JDUTQ0bDRNYWpV?=
 =?utf-8?B?TG10MjhmNmxub0ppemVFQXU4ZHRJQmRHWjdzQlJGR2NGbVpEZ2FpNzB0SVFi?=
 =?utf-8?B?N2N3WjRsTVd0QndTVDI4a21qelJpaTY2UDQrRjNFZnZtWmhINUJSUTc4b2Ev?=
 =?utf-8?B?dEFOdDRicitmV1d0SmdxV01hcSt2UGp0S3dyN3JXTk5zUTVXb2VCQ1RmWmpn?=
 =?utf-8?B?ZVZIV2J0NUFheVc3SGxHZkR3REVaWFRqN3UwU3BHczU3ZGRGd1pqY1ZZRFZm?=
 =?utf-8?B?Z1QyL3ZTZ21lNksySmFTV1h0QytCVWxkUFUyWktjS0dhNW9QMEVPemg5S0Yz?=
 =?utf-8?B?bGNwUkpjRWJDNkxZcTgzdk14N2dzekMzN1ovYktrZDhqbStvSlg2eC9YQ2xN?=
 =?utf-8?B?bkhrQmF6V2ExYnAvS1dZalp0VlpkenhlMXZPV1EzcS9jL0pmc3lydGpBajBJ?=
 =?utf-8?B?bERpUjJxVWNhZEQ2QURWcEFmUXJ2MWhVWTI1ZW1rZjNLY3hCemRIQTl5UE5o?=
 =?utf-8?B?em9MSDlSWk5veGYrUTZnSTFEcklpeW1LMjJtZlpYZVlMV0MrNEtKbWVwYnlm?=
 =?utf-8?B?cFpJWmxIQmVoZGUvRlRwdVhQbVJNbEtoNHlVbEczb0ppUXRLMjJ0eTdDQ2RC?=
 =?utf-8?B?SEE0bC9uUEdJVEwvSmJRaXEwYkVtMmtpditXMjYyVnFPeG91cUZnc0pVb253?=
 =?utf-8?B?QUdmeE5ERGxvRFlsRVRBNjdkNlRRQ1BRNDZsSExNblBZakhkcVpDd1dnWUtE?=
 =?utf-8?B?bytvVUN0RHdHVmY2YlJ3UklFRGNTTEpOZWxxVkdRUGcrSUN6aWV4bmpBM2xP?=
 =?utf-8?B?NUdFZ1dyOHg5dEFrU0grN1ZjV3FvUGxZMUN1RlFFTGROeTg3ajNmU0VtdTgx?=
 =?utf-8?B?Y0gzaTN2MW5NZGd1ekRhTzBnWmt6djhSOFdnL1BORkw3cVJBbmwzd3Ivb3Yx?=
 =?utf-8?B?d0k5dDkwT243Vk9WdkNRTm1zNFM4UFJFVlV4RERLeFg5YWt2M2ZkV1JmcWJp?=
 =?utf-8?B?VFh3VXFOdjRGeWc4U0JUSHJFZmNqMC9KTEpNc1JydmNVQ1oxV09lcnJpbG03?=
 =?utf-8?B?WVpSSVlKWGJ4cUZ4Z0lkLytNVDhONGl0Wnl1Y3RCNVJNTlpHdjhrUHNsa2Y0?=
 =?utf-8?B?SmFSMExqM1hNZlVoNWp5R0FvSGJyQ1hvSGQ5c1FORU9hdHgrSXBudTVCNEQx?=
 =?utf-8?B?c3BPVFZRLzM1N1lXemRDaFg2bzEzbE53M052bUh6bGNjVHl3dFJHS1lGUllY?=
 =?utf-8?B?M1VMVTNFRE5FWjY4c3N4WHBvbFFyenUzU0oydEMxNWQ1c0tLTWtWNXZ6LzFl?=
 =?utf-8?B?cnZsTWVqVHAwa2t0aFMwNDF3ZUpDczl2am1CZlp5YjNhWVlzK0dUaG1SSkZo?=
 =?utf-8?B?Ui92VUE3NW5Ha1crSlBkR3llbzNFSEE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3e2b3c-56ab-4990-f9f6-08dc43bde5fa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 00:30:06.5518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7074

RnJvbTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+IFNlbnQ6IFdlZG5lc2Rh
eSwgTWFyY2ggMTMsIDIwMjQgNDozMyBQTQ0KPiANCj4gSGkgTWljaGFlbCwNCj4gDQo+IE9uIFRo
dSwgTWFyIDA3LCAyMDI0IGF0IDEwOjQ4OjIwQU0gLTA4MDAsIG1oa2VsbGV5NThAZ21haWwuY29t
IHdyb3RlOg0KPiA+ICsJLyoNCj4gPiArCSAqIFNlZWQgdGhlIExpbnV4IHJhbmRvbSBudW1iZXIg
Z2VuZXJhdG9yIHdpdGggZW50cm9weSBwcm92aWRlZCBieQ0KPiA+ICsJICogdGhlIEh5cGVyLVYg
aG9zdCBpbiBBQ1BJIHRhYmxlIE9FTTAuICBJdCB3b3VsZCBiZSBuaWNlIHRvIGRvIHRoaXMNCj4g
PiArCSAqIGV2ZW4gZWFybGllciBpbiBtc19oeXBlcnZfaW5pdF9wbGF0Zm9ybSgpLCBidXQgdGhl
IEFDUEkgc3Vic3lzdGVtDQo+ID4gKwkgKiBpc24ndCBzZXQgdXAgYXQgdGhhdCBwb2ludC4gU2tp
cCBpZiBib290ZWQgdmlhIEVGSSBhcyBnZW5lcmljIEVGSQ0KPiA+ICsJICogY29kZSBoYXMgYWxy
ZWFkeSBkb25lIHNvbWUgc2VlZGluZyB1c2luZyB0aGUgRUZJIFJORyBwcm90b2NvbC4NCj4gPiAr
CSAqLw0KPiA+ICsJaWYgKCFJU19FTkFCTEVEKENPTkZJR19BQ1BJKSB8fCBlZmlfZW5hYmxlZChF
RklfQk9PVCkpDQo+ID4gKwkJcmV0dXJuOw0KPiANCj4gRXZlbiBpZiBFRkkgc2VlZHMgdGhlIGtl
cm5lbCB1c2luZyBpdHMgb3duIGNvZGUsIGlmIHRoaXMgaXMgYXZhaWxhYmxlLA0KPiBpdCBzaG91
bGQgYmUgdXNlZCB0b28uIFNvIEkgdGhpbmsgeW91IHNob3VsZCByZW1vdmUgdGhlIGB8fCBlZmlf
ZW5hYmxlZChFRklfQk9PVClgDQo+IHBhcnQgYW5kIGxldCB0aGUgYWRkX2Jvb3Rsb2FkZXJfcmFu
ZG9tbmVzcygpIGRvIHdoYXQgaXQgd2FudHMgd2l0aCB0aGUNCj4gZW50cm9weS4NCg0KT0ssIGZh
aXIgZW5vdWdoLiAgQnV0IGp1c3QgdG8gZG91YmxlLWNoZWNrOiAgV2hlbiB0aGlzIGlzIGNhbGxl
ZCwNCnRoZSBFRkkgUk5HIHByb3RvY29sIGhhcyBhbHJlYWR5IGludm9rZWQgYWRkX2Jvb3Rsb2Fk
ZXJfcmFuZG9tbmVzcygpLA0KIGFuZCB0aGlzIGxpbmUgaGFzIGJlZW4gb3V0cHV0Og0KDQpbICAg
IDAuMDAwMDAwXSByYW5kb206IGNybmcgaW5pdCBkb25lDQoNCkkgZG9uJ3Qgc2VlIGFuIG9idmlv
dXMgcHJvYmxlbSB3aXRoIGNhbGxpbmcgYWRkX2Jvb3Rsb2FkZXJfcmFuZG9tbmVzcygpDQphZ2Fp
biwgYnV0IHdhbnRlZCB0byBjb25maXJtLg0KDQpBbHNvLCBpZiB3ZSdyZSBhZGRpbmcgdGhpcyBB
Q1BJLWJhc2VkIHJhbmRvbW5lc3MgZm9yIFZNcyB0aGF0DQpib290IHZpYSBFRkksIHRoZW4gZm9y
IGNvbnNpc3RlbmN5IHdlIHNob3VsZCB1c2UgaXQgb24gSHlwZXItVg0KYmFzZWQgQVJNNjQgVk1z
IGFzIHdlbGwuDQoNCj4gDQo+ID4gKw0KPiA+ICsJc3RhdHVzID0gYWNwaV9nZXRfdGFibGUoIk9F
TTAiLCAwLCAmaGVhZGVyKTsNCj4gPiArCWlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSB8fCAhaGVh
ZGVyKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogU2luY2UgdGhl
ICJPRU0wIiB0YWJsZSBuYW1lIGlzIGZvciBPRU0gc3BlY2lmaWMgdXNhZ2UsIHZlcmlmeQ0KPiA+
ICsJICogdGhhdCB3aGF0IHdlJ3JlIHNlZWluZyBwdXJwb3J0cyB0byBiZSBmcm9tIE1pY3Jvc29m
dC4NCj4gPiArCSAqLw0KPiA+ICsJaWYgKHN0cm5jbXAoaGVhZGVyLT5vZW1fdGFibGVfaWQsICJN
SUNST1NGVCIsIDgpKQ0KPiA+ICsJCWdvdG8gZXJyb3I7DQo+ID4gKw0KPiA+ICsJLyoNCj4gPiAr
CSAqIEVuc3VyZSB0aGUgbGVuZ3RoIGlzIHJlYXNvbmFibGUuICBSZXF1aXJpbmcgYXQgbGVhc3Qg
MzIgYnl0ZXMgYW5kDQo+ID4gKwkgKiBubyBtb3JlIHRoYW4gMjU2IGJ5dGVzIGlzIHNvbWV3aGF0
IGFyYml0cmFyeS4gIEh5cGVyLVYgY3VycmVudGx5DQo+ID4gKwkgKiBwcm92aWRlcyA2NCBieXRl
cywgYnV0IGFsbG93IGZvciBhIGNoYW5nZSBpbiBhIGxhdGVyIHZlcnNpb24uDQo+ID4gKwkgKi8N
Cj4gPiArCWlmIChoZWFkZXItPmxlbmd0aCA8IHNpemVvZigqaGVhZGVyKSArIDMyIHx8DQo+ID4g
KwkgICAgaGVhZGVyLT5sZW5ndGggPiBzaXplb2YoKmhlYWRlcikgKyAyNTYpDQo+IA0KPiBXaGF0
J3MgdGhlIHBvaW50IG9mIHRoZSBsb3dlciBib3VuZD8gT2J2aW91c2x5IHNraXAgZm9yIDAsIGJ1
dCBpZg0KPiB0aGVyZSdzIG9ubHkgMTYgYnl0ZXMsIGNvb2wsIDE2IGJ5dGVzIGlzIGdvb2QgYW5k
IGNhbid0IGh1cnQuDQo+IA0KPiBGb3IgdGhlIHVwcGVyIGJvdW5kLCBJIHVuZGVyc3RhbmQgeW91
IG5lZWQgc29tZSBzYW5pdHkgY2hlY2suIFdoeSBub3QNCj4gcHV0IGl0IGEgYml0IGhpZ2hlciwg
dGhvdWdoLCBhdCBTWl80SyBvciBzb21ldGhpbmc/IENhbid0IGh1cnQuDQoNCkJvdGggYm91bmRz
IGFyZSBqdXN0IGEgY2hlY2sgZm9yIGJvZ3VzbmVzcy4gIEhhdmluZyB0aGUgaHlwZXJ2aXNvcg0K
cHJvdmlkZSBqdXN0IDQgYnl0ZXMgKGZvciBleGFtcGxlKSBvZiByYW5kb21uZXNzIHNlZW1zIGxp
a2UNCnRoZXJlIG1pZ2h0IGJlIHNvbWV0aGluZyB3ZWlyZCBnb2luZyBvbi4gIEJ1dCB3aWRlbmlu
ZyB0aGUgYm91bmRzDQppcyBmaW5lIHdpdGggbWUuICBJJ2xsIHVzZSAiOCIgYW5kICJTWl80SyIu
DQoNCj4gDQo+ID4gKwkJZ290byBlcnJvcjsNCj4gPiArDQo+ID4gKwlsZW5ndGggPSBoZWFkZXIt
Pmxlbmd0aCAtIHNpemVvZigqaGVhZGVyKTsNCj4gPiArCXJhbmRvbWRhdGEgPSAodTggKikoaGVh
ZGVyICsgMSk7DQo+ID4gKw0KPiA+ICsJcHJfZGVidWcoIkh5cGVyLVY6IFNlZWRpbmcgcm5nIHdp
dGggJWQgcmFuZG9tIGJ5dGVzIGZyb20gQUNQSSB0YWJsZSBPRU0wXG4iLA0KPiA+ICsJCQlsZW5n
dGgpOw0KPiA+ICsNCj4gPiArCWFkZF9ib290bG9hZGVyX3JhbmRvbW5lc3MocmFuZG9tZGF0YSwg
bGVuZ3RoKTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogVG8gcHJldmVudCB0aGUgc2VlZCBk
YXRhIGZyb20gYmVpbmcgdmlzaWJsZSBpbiAvc3lzL2Zpcm13YXJlL2FjcGksDQo+ID4gKwkgKiB6
ZXJvIG91dCB0aGUgcmFuZG9tIGRhdGEgaW4gdGhlIEFDUEkgdGFibGUgYW5kIGZpeHVwIHRoZSBj
aGVja3N1bS4NCj4gPiArCSAqLw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IGxlbmd0aDsgaSsrKSB7
DQo+ID4gKwkJaGVhZGVyLT5jaGVja3N1bSArPSByYW5kb21kYXRhW2ldOw0KPiA+ICsJCXJhbmRv
bWRhdGFbaV0gPSAwOw0KPiA+ICsJfQ0KPiANCj4gU2VlbXMgZGFuZ2Vyb3VzIGZvciBrZXhlYyBh
bmQgc3VjaC4gV2hhdCBpZiwgaW4gYWRkaXRpb24gdG8gemVyb2luZyBvdXQNCj4gdGhlIGFjdHVh
bCBkYXRhLCB5b3UgYWxzbyBzZXQgaGVhZGVyLT5sZW5ndGggdG8gMCwgc28gdGhhdCBpdCBkb2Vz
bid0DQo+IGdldCB1c2VkIGFnYWluIGFzIDMyIGJ5dGVzIG9mIGtub3duIHplcm9zPw0KDQpXaGF0
J3MgeW91ciB0YWtlIG9uIHRoZSB3aG9sZSBpZGVhIG9mIHplcm8naW5nIHRoZSByYW5kb20gZGF0
YT8gICBJDQpzYXcgdGhlIEVGSSBSTkcgcHJvdG9jb2wgaGFuZGxpbmcgd2FzIGRvaW5nIHNvbWV0
aGluZyByb3VnaGx5DQpzaW1pbGlhci4gIEJ1dCB5ZXMsIGdvb2QgcG9pbnQgYWJvdXQga2V4ZWMo
KS4gIFplcm9pbmcgdGhlIGhlYWRlci0+bGVuZ3RoDQp3b3VsZCBtYWtlIHNlbnNlIHRvIHByZXZl
bnQgYW55IHJlLXVzZS4NCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgLS0gSSB3YW50ZWQgdG8gZ2V0
IHRoZSBiZW5lZml0IG9mIHlvdXIgZXhwZXJ0aXNlDQppbiB0aGlzIGFyZWEuIDotKQ0KDQpNaWNo
YWVsDQo=

