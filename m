Return-Path: <linux-arch+bounces-8497-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 565779AD41A
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 20:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722AC1C20CD1
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB9E1D0E3E;
	Wed, 23 Oct 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UC/AqlvN"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazolkn19013074.outbound.protection.outlook.com [52.103.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36312DD88;
	Wed, 23 Oct 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708760; cv=fail; b=OQ8TVanCZMvSdJGHxdSRr/iadZPqwrtgg8ab3dd5uaFG4BBke3+/g4ie4XYNxvZnrUHAMF06OruvOi6FfdKXYVamS5jvEUqSPGr+8rwa6xtiojpGdoE+3g6mf/MvYYjT1I7o/brvCrFU60zcNzGKNSxQwQjTkp3kbfRGqtog3wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708760; c=relaxed/simple;
	bh=zSJ/MiGL2LTRqkWoVEQ4MA3l+eu9gbvymeuh3JeHZQ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EeGsm6y8Ph1x4REkLM12PGjYHnJ0P/L4hg8U44m9i/9FdWLO/380Vv2EtUahyOf8PuU68XdIoT26smxIrzwT6kE6jc+y3ezRkLWHaLeZ1WyuoN6fbBLerks8z+ykN1NS/r5MzsMJ54458ID0zQ00nAaT/atwTiv9ve82iceis30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UC/AqlvN; arc=fail smtp.client-ip=52.103.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O61qVqwjqYc9IMbqQbGlN3DxfSMzKoGFQs+KKkQAl4L7lrAJEqrwxQvovSEI5djewDgkGefax2HrlrsyU+wEswlu6YvmURkaiiz7pYJ3k4bLmYvGO6jFfQBbIYWwiNR+A9LppkPyCqtN1zpCda8w6GtZCreDhyOq3w3S1hAElUpQFb9EN4KVaRlPRM4v4gCaAqPRbxX68/+ZgCPBaXln3XVoNsKECgQo2fS2URy40k0rFVHmCa3gOqW9CtY+Eu6augykAESJLjk8DbiOXx9dKrgqI0LhbbBhz82MAX9LkvykpnHkOKYWCehPU8cBk9Ui0mZZnX37MdDTTjrCL11hQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSJ/MiGL2LTRqkWoVEQ4MA3l+eu9gbvymeuh3JeHZQ8=;
 b=V/oN4BeZj6rjLouptOidQLU0vBGfkewhRqc9awSUv8+hBwUyBfZBfxTXMq7IoD7BzQarGVlu+J/lpgzNgeuBPqsDbjzLn4oNsT0c77FLk1BkgMKicYsFXJGi4Y7I/7l4hdkE+NElNLY8D5AI3ViojbtmG/DvfcUQticMPZg/FjczO8c78O6bo15xKh/cTrAWsk0wOP8c98YFZwRBV5CE9S5sC6Od2nrfCghB8H+xetDkc/9DS4VBNGUHlfKM/cMPW6EtiuIU6YKeN1SXHgK0kQwgSSNkkrNpvEvrhT+5N9SPNevexIRKfKZSnp+22pap+QvFPUtVwjV932tgvPg4Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSJ/MiGL2LTRqkWoVEQ4MA3l+eu9gbvymeuh3JeHZQ8=;
 b=UC/AqlvNllUJ/yHVzjFOr0RltXGb/9OBIFVT3rZPlqBlFyonGmxYD1xuZfZJ1ER4BtAfTPHKTPcs40ELJLCgQclofJGy21M77jwxE49OSBQNkNMkS/R5vR7fl/u52+QfQjU+n4jRhQiKbFQ8Dg3beFP0gxU37K8Ol3SIFCVZVZTirCY3h5uxEm5/3pr3px7bbH1/BslByMsS8Qo0cvFBHbaUESQlcTGUmxqi8rclZfyiAmWRW2lj0Od6kj5TXyZ4FzDgrvDpOFkT7I69KDQPz90hltBaX9jYfj33s1fWD4FVGKFcfC5q56TPcqXoWzxpaHCUGkUrJTz+sA/C0hGiIg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA2PR02MB7818.namprd02.prod.outlook.com (2603:10b6:806:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 18:39:14 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8069.016; Wed, 23 Oct 2024
 18:39:14 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, MUKESH RATHOR
	<mukeshrathor@microsoft.com>, "linux-hyperv@vger.kernel.org"
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
Subject: RE: [EXTERNAL] RE: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Topic: [EXTERNAL] RE: [PATCH 0/5] Add new headers for Hyper-V Dom0
Thread-Index: AQHbFc3gheIHrTrmm0yVUene//yVY7J/bLBwgAFjPQCAEsKYgIABNfFw
Date: Wed, 23 Oct 2024 18:39:14 +0000
Message-ID:
 <SN6PR02MB415712BA42A894116CA095B8D44D2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157F6EA7B2454D2F6CBF2ECD4782@SN6PR02MB4157.namprd02.prod.outlook.com>
 <d70bbad7-bcad-2031-a4e1-755b502422a4@microsoft.com>
 <c426d122-4ba3-4193-80d5-a40d7554d324@linux.microsoft.com>
In-Reply-To: <c426d122-4ba3-4193-80d5-a40d7554d324@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA2PR02MB7818:EE_
x-ms-office365-filtering-correlation-id: 70a49709-1227-420f-f560-08dcf391fe6b
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799003|8062599003|8060799006|15080799006|440099028|3412199025|102099032|56899033;
x-microsoft-antispam-message-info:
 GjOFciutwFIaGu0z9Z2kDU+bWijCHNTO6jOGtJcGYxPELgddV6SErE+UH7yocfJLsZEjVcc0FPjZ3cJD6ck0+GQK36X3L3t2YxYrdO2znyPhknpLMWvxu6wC5iDOT9oSA+N+D36Kcg/9s/szpuN5u4MhVjsgU4GcJ/oIFJiqu2qDS7/VF+cvenM1qyGzy0utl6Z58GjmDNOHHg45xGe/MMJbLhM4rDlUwSBOx/1wID9UR7QtQIChg/MnCuXnzqFr4i4mOu+9OsSeL/606rBlvOsPfY5csrnFQT3/gfBDI+wKz2XmDPr+hxoq+sQ8h7Kp3WNri0jUFdhbdDY7d2WK0sbjdWqw3IpeqNqEhTxVLYVKUrLYAmJqYu2o7Mh1mvjrHqN4xv+Xw9LSgIjh5QDkaQ9WiQLGBA7mRrDwrWOAEoc9rCWc1BNkkHzttEMOflrHf682wsZL34GIhFOUOLkCtwQJilOxtBjgXpPukP2zHotU+uFoMEnWKmpoViHA7TYNNmQ4Y/A9BEV2w0GIxFGuc2/Nnu753cOWJMCE8D5HN/bjwjeWB3UM+926BODytsz7EtsGhB1tBtNm7A4pUjQzv8XpVohNyNzOqZ2fg4XrMFCjegzQ67j9geyKu+eQCqxfwfy0BzC+XL1mj+IncPAsUpkT+NRtnqpAWD3bEXfUGzW6sC4GclNxG80oLb3r7npgUrQTjc0VFCYp6SohjH1pZA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmVjNGkxTEd1NHJuaS93YTZnMzdJMFR5S3o1WkhMZ3BrNm5xaTRoSzdzL0V2?=
 =?utf-8?B?alQwVzV0S0F5ZVZ5VHhNUStRYUhuQzZlK3FSOTQ5UWZUanEva2RBQk9qQTFh?=
 =?utf-8?B?c21YS3RwS3VjWndWRFJ4SkY1dUxXZVQwdkY4c2VSMWdtV0xtYzhHQnhxT1Jl?=
 =?utf-8?B?RXlmRVBrQ2lZKzIrOGgvUjdUUUd6ZDZSZlF1enFNYkplNVRicHpXVDR4Sm5a?=
 =?utf-8?B?azdXK05CVDNBZmZOOXVHSFhNVWJPSDFRaTVyUkhYVGtxcWwrcDJMVkRZRitz?=
 =?utf-8?B?OU01N2dWQUx3VE4wYlFFTW81b3Q2TEZhbnl6THlvZUc2WjJHTE5TdE5xdFVw?=
 =?utf-8?B?d1cxUGIwaUJwcEVhUjAxN2svMUh6di9rUmlacHdUUUovdGx4Wi9XSTJWS2Zt?=
 =?utf-8?B?MUxSaFU0MDhGWFNKRXZzRmZoYjA4L3BwZ1lYNWFQdkxRU3dsYXFrR1NsbXJP?=
 =?utf-8?B?VU51Mis1c2kzV01WN2cxY1lQZFNzMENHd1VJNC9Yc29CVnpGaFBtUmc5Qlgy?=
 =?utf-8?B?MElmUU9NejlyOXJRb3BTUUhwNStjK1Bobkl1R0plZU1zVWVtN0RsYXZxNGJN?=
 =?utf-8?B?OEJ0M3hnZ2JQTGxsVm1yQ0VWVGcrRWJqZzVLclZub21TWFBVSTZwUzBzWmFm?=
 =?utf-8?B?NkQzTHZHWFFPQklXMUxmNlNyR0cyK1BoZE9MaGQxMWhYUnJxdDFncWRBUkdz?=
 =?utf-8?B?SkJMQ1BTQlkyZTBqMmhOL3lSQTVxOW5ocGQzbUp3RlBNUlpkbXJlN2I3VkZH?=
 =?utf-8?B?VUdOVGY0bVFrMDlhd2dUU1RCcGV2bjBENVR1aUNkRnNLNkhsVGpzRzBibUh5?=
 =?utf-8?B?VHhOWCtkN3JSQmtkMW1LL2RsSnJyMmx2Qm5hTE91VjRiMXVPaU5ZTVNEQ0Ny?=
 =?utf-8?B?QnVGRktESE9FT1A4TmYyZ3NtTFM2KytJWU4xa3d5dDEwT2FqM0NhV2p4cUQv?=
 =?utf-8?B?RzhETWt0NkhlMlltSzZhanlaNEpTR3ZpdlNvZkxJVkZGbERvbi93WUlxeVg4?=
 =?utf-8?B?Y0ZQdStCUDZITmsxN25UNnRISG9BRzN0TkZmRDE0Y3BTYzJvTjVRcm5pQmdT?=
 =?utf-8?B?QW9nVnFvUUJ5ZU10TVBXZmZyTXNlRm5nbjJpeEx5NHczYzhrNjNyN0xmSTVh?=
 =?utf-8?B?TjJEdC9DbTY0K2cydWg3KzhzcnNqdTBuNWlSMzBsNjhMMEcxS0UyUFBXblNW?=
 =?utf-8?B?Tk83cGtCODRCM3pxQUpIaHFKRm1GUHQvbDlweDZ1SE56dFhUYjA5dzVZMzRo?=
 =?utf-8?B?aEYwYnVYZitZRFY4Tk9aTE1saWRZUkVMVVMwbGFvZ0pVdTZQN1dQaGl3RDdM?=
 =?utf-8?B?Ly9NTEEveUlIWXp5bTFweUJZZVM2L2pkaTMrVVJ3SHMrOVFBVWxseENUVnNv?=
 =?utf-8?B?aDhINHJwSTdOQ2ZwSjBCM2FNNkdVQXVnME9WNGh3ckpwOWxrNHpNY2poVmxn?=
 =?utf-8?B?Nnd6cGNPTTRNVkxZSk9oVTVSeWVPeEQ0NWw0UHVHTUxRZ1RKSWZFeUd1MW5a?=
 =?utf-8?B?YnJ2VjJPMkFqd0J2akRmZW0rSU1PRlJTeWdMRUdIQVVDaEpXZElCZVR0b21l?=
 =?utf-8?B?VUVZVW4yckdyYkZLeUM4NWdZTVNZckRVVGFFNlYrRWtWalFaYWphMHlCOE85?=
 =?utf-8?Q?RwR8q2YpMgQp02Cn4H6H5bI3XISGGZZMf9zXbB4T4sEg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a49709-1227-420f-f560-08dcf391fe6b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 18:39:14.3516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7818

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIyLCAyMDI0IDU6MDQgUE0NCj4gDQo+IE1pY2hhZWwgLSBz
b3JyeSBmb3IgdGhlIGRlbGF5LCBJIGp1c3QgZ290IGJhY2sgZnJvbSB2YWNhdGlvbi4NCj4gDQo+
IE9uIDEwLzEwLzIwMjQgNjozNCBQTSwgTVVLRVNIIFJBVEhPUiB3cm90ZToNCj4gPg0KPiA+DQo+
ID4gT24gMTAvMTAvMjQgMTE6MjEsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+ICA+IEZyb206
IE51bm8gRGFzIE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDoN
Cj4gPiBUaHVyc2RheSwgT2N0b2JlciAzLCAyMDI0IDEyOjUxIFBNDQo+ID4gID4+DQo+ID4gID4+
IFRvIHN1cHBvcnQgSHlwZXItViBEb20wIChha2EgTGludXggYXMgcm9vdCBwYXJ0aXRpb24pLCBt
YW55IG5ldw0KPiA+ICA+PiBkZWZpbml0aW9ucyBhcmUgcmVxdWlyZWQuDQo+ID4gID4+DQo+ID4g
ID4+IFRoZSBwbGFuIGdvaW5nIGZvcndhcmQgaXMgdG8gZGlyZWN0bHkgaW1wb3J0IGhlYWRlcnMg
ZnJvbQ0KPiA+ICA+PiBIeXBlci1WLiBUaGlzIGlzIGEgbW9yZSBtYWludGFpbmFibGUgd2F5IHRv
IGltcG9ydCBkZWZpbml0aW9ucw0KPiA+ICA+PiByYXRoZXIgdGhhbiB2aWEgdGhlIFRMRlMgZG9j
LiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzDQo+ID4gID4+IG5ldyBoZWFkZXJzIChodmhk
ay5oLCBodmdkay5oLCBldGMsIHNlZSBwYXRjaCAjMykgZGlyZWN0bHkNCj4gPiAgPj4gZGVyaXZl
ZCBmcm9tIEh5cGVyLVYgY29kZS4NCj4gPiAgPj4NCj4gPiAgPj4gVGhpcyBwYXRjaCBzZXJpZXMg
cmVwbGFjZXMgaHlwZXJ2LXRsZnMuaCB3aXRoIGh2aGRrLmgsIGJ1dCBvbmx5DQo+ID4gID4+IGlu
IE1pY3Jvc29mdC1tYWludGFpbmVkIEh5cGVyLVYgY29kZSB3aGVyZSB0aGV5IGFyZSBuZWVkZWQu
IFRoaXMNCj4gPiAgPj4gbGVhdmVzIHRoZSBleGlzdGluZyBoeXBlcnYtdGxmcy5oIGluIHVzZSBl
bHNld2hlcmUgLSBub3RhYmx5IGZvcg0KPiA+ICA+PiBIeXBlci1WIGVubGlnaHRlbm1lbnRzIG9u
IEtWTSBndWVzdHMuDQo+ID4gID4NCj4gPiAgPiBDb3VsZCB5b3UgZWxhYm9yYXRlIG9uIHdoeSB0
aGUgYmlmdXJjYXRpb24gaXMgbmVjZXNzYXJ5PyBJcyBpdCBhbg0KPiA+ICA+IGludGVyaW0gc3Rl
cCB1bnRpbCB0aGUgS1ZNIGNvZGUgY2FuIHVzZSB0aGUgbmV3IHNjaGVtZSBhcyB3ZWxsPw0KPiAN
Cj4gSXQncyBub3Qgc3RyaWN0bHkgbmVjZXNzYXJ5LiBXZSBjaG9zZSB0aGlzIGFwcHJvYWNoIGlu
IG9yZGVyIHRvDQo+IG1pbmltaXplIGFueSBwb3RlbnRpYWwgaW1wYWN0IG9uIEtWTSBhbmQgb3Ro
ZXIgbm9uLU1pY3Jvc29mdC0NCj4gbWFpbnRhaW5lZCBjb2RlIHRoYXQgdXNlcyBoeXBlcnYtdGxm
cy5oLiBBcyBNdWtlc2ggbWVudGlvbmVkIGJlbG93LA0KPiBldmVudHVhbGx5IGl0IHdpbGwgYmUg
YmV0dGVyIGlmIGV2ZXJ5b25lIHVzZXMgdGhlIG5ldyBoZWFkZXJzLg0KDQpEb2luZyBiaWcgY2hh
bmdlcyBpbmNyZW1lbnRhbGx5IGlzIGNlcnRhaW5seSB1c2VmdWwgYW5kIGNvbW1vbiBlbm91Z2gN
CmluIGtlcm5lbCBkZXZlbG9wbWVudC4gQnV0IGhhdmluZyB0d28gc2V0cyBvZiBoZWFkZXIgZmls
ZXMgdGhhdCBkZWZpbmUNCnRoZSBzYW1lIHRoaW5nLCBmb3IgdXNlIGluIHR3byBkaWZmZXJlbnQg
cGFydHMgb2YgdGhlIGNvZGUgdHJlZSwgc2VlbXMNCmEgYml0IG9mZiB0aGUgYmVhdGVuIHBhdGgu
IEkgZG9u4oCZdCBzZWUgdGhhdCB0aGVyZSB3b3VsZCBiZSBzaWduaWZpY2FudA0KcmlzayBpbiBk
b2luZyBLVk0gYXQgdGhlIHNhbWUgdGltZS4gQnV0IHRoZSBLVk0gZm9sa3Mgc2hvdWxkIHdlaWdo
DQppbiBvbiB0aGlzLg0KDQpKdXN0IG15ICQuMDIgd29ydGgsIGFuZCBJIHdvbid0IG9iamVjdCB3
aGljaGV2ZXIgd2F5IHlvdSBnby4NCg0KTWljaGFlbA0KDQo+IA0KPiA+ICA+IEFsc28sIGRvZXMg
Ikh5cGVyLVYgZW5saWdodGVubWVudHMgb24gS1ZNIGd1ZXN0cyIgcmVmZXIgdG8NCj4gPiAgPiBu
ZXN0ZWQgS1ZNIHJ1bm5pbmcgYXQgTDEgb24gYW4gTDAgSHlwZXItViwgYW5kIHN1cHBvcnRpbmcg
TDIgZ3Vlc3RzPw0KPiA+ICA+IE9yIGlzIGl0IHRoZSBtb3JlIGdlbmVyYWwgS1ZNIHN1cHBvcnQg
Zm9yIG1pbWlja2luZyBIeXBlci1WIGZvcg0KPiA+ICA+IHRoZSBwdXJwb3NlcyBvZiBydW5uaW5n
IFdpbmRvd3MgZ3Vlc3RzPyBGcm9tIHRoZXNlIHBhdGNoZXMsIGl0DQo+ID4gID4gbG9va3MgbGlr
ZSB5b3VyIGludGVudGlvbiBpcyBmb3IgYWxsIEtWTSBzdXBwb3J0IGZvciBIeXBlci1WDQo+ID4g
ID4gZnVuY3Rpb25hbGl0eSB0byBjb250aW51ZSB0byB1c2UgdGhlIGV4aXN0aW5nIGh5cGVydi10
bGZzLmggZmlsZS4NCj4gDQo+IFlvdSdyZSBjb3JyZWN0IC0gImFsbCBLVk0gc3VwcG9ydCBmb3Ig
SHlwZXItViIgaXMgcmVhbGx5IHdoYXQgSSBtZWFudC4NCj4gPg0KPiA+IExpa2UgaXQgc2F5cyBh
Ym92ZSwgd2UgYXJlIGNyZWF0aW5nIG5ldyBkb20wIChyb290L2hvc3QpIHN1cHBvcnQNCj4gPiB0
aGF0IHJlcXVpcmVzIG1hbnkgbmV3IGRlZnMgb25seSBhdmFpbGFibGUgdG8gZG9tMCBhbmQgbm90
IGFueQ0KPiA+IGd1ZXN0LiBIeXBlcnZpc29yIG1ha2VzIHRoZW0gcHVibGljbHkgYXZhaWxhYmxl
IHZpYSBodipkayBmaWxlcy4NCj4gPg0KPiA+IElkZWFsbHksIHNvbWVkYXkgZXZlcnlib2R5IHdp
bGwgdXNlIHRob3NlLCBJIGhvcGUgd2UgY2FuIG1vdmUgaW4NCj4gPiB0aGF0IGRpcmVjdGlvbiwg
YnV0IEkgZ3Vlc3Mgb25lIHN0ZXAgYXQgYSB0aW1lLiBGb3Igbm93LCBLVk0gY2FuDQo+ID4gY29u
dGludWUgdG8gdXNlIHRoZSB0bGZzIGZpbGUsIGFuZCBpZiB0aGVyZSBpcyBubyByZXNpc3RhbmNl
LCB3ZQ0KPiA+IGNhbiBtb3ZlIHRoZW0gdG8gaHYqZGsgZmlsZXMgYWxzbyBhcyBuZXh0IHN0ZXAg
YW5kIG9ic29sZXRlIHRoZQ0KPiA+IHNpbmdsZSB0bGZzIGZpbGUuDQo+ID4NCj4gPiBTaW5jZSBo
ZWFkZXJzIGFyZSB0aGUgdWx0aW1hdGUgc291cmNlIG9mIHRydXRoLCB0aGlzIHdpbGwgYWxsb3cN
Cj4gPiBiZXR0ZXIgbWFpbnRlbmFuY2UsIGJldHRlciBkZWJ1Zy9zdXBwb3J0IGV4cGVyaWVuY2Us
IGFuZCBhIG1vcmUNCj4gPiBzdGFibGUgc3RhY2suIEl0IGFsc28gZW5mb3JjZXMgbm9uLWxlYWtp
bmcgb2YgZGF0YSBzdHJ1Y3RzIGZyb20NCj4gPiBwcml2YXRlIGhlYWRlciBmaWxlcyAodW5mb3J0
dW5hdGVseSBoYXMgaGFwcGVuZWQpLg0KPiA+DQo+ID4gVGhhbmtzDQo+ID4gLU11a2VzaA0KPiA+
DQo+IA0KPiBUaGFua3MgZm9yIHByb3ZpZGluZyB0aGUgYWRkaXRpb25hbCBjb250ZXh0LCBNdWtl
c2guDQo+IA0KPiBOdW5vDQoNCg==

