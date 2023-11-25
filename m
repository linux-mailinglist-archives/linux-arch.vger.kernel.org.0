Return-Path: <linux-arch+bounces-458-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1072A7F88A4
	for <lists+linux-arch@lfdr.de>; Sat, 25 Nov 2023 07:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F0DEB2104F
	for <lists+linux-arch@lfdr.de>; Sat, 25 Nov 2023 06:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCBBA20;
	Sat, 25 Nov 2023 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J5RFVBve"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F28C1;
	Fri, 24 Nov 2023 22:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700894318; x=1732430318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IXFBoxFXBtMc80h1d6/q+oeMzCcUDVVAQBDgoO/3dy0=;
  b=J5RFVBve6IWTDQAV4ujnU8vGjmmYS97OTquBCwy25qucGRG8A6p7uLyx
   EJttlu9u8ptBRFNtGV2hV41/XnznzQl7B85NXx0TO7dsw7NvohW52Pymz
   rDgSbYI/KREV7TJUX1lQKr0WC7GTjZryV0io/Q9Cqvb61xTmtFSxRERFC
   snuire+ANizKYsg2BqbAMh05yS5CBtVrGrXJLX63s2L/Un7a/tdiB2YNV
   c6xcm7WApl82xKEcyApHSZYvpAGxiqeHNC4kEnvlWtYAOAkZtgJxr30IN
   0m/V8cHi+6hDy9FqcwxjIRinE/e9SlG+o5V8TOLxCXI/qB+9P10b1MvUW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="5728761"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="5728761"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 22:38:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="911615192"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="911615192"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Nov 2023 22:38:37 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 22:38:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 24 Nov 2023 22:38:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 24 Nov 2023 22:38:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOwiui/XXVKq5Oa73Ow/wYDrqI5Ga6F7mjC2JWWKgTo/6E0mlCJIT5j21RlonUyxPcQ3XJ1dK575zx48YputiHJxk5UFNSJZCO/KKfSLqfZPY/TmcZOSkxR/dJNXvVcUosX00ocQnhHogZVZoK/dn71HsIOFqKOWZD1R9eFSXQ7l1uR4jgd4DopglMnsnPHy941YslZit4ufqKjOkom5HGbJluGQ9yxArV1VmNtQvC2NrU5gnXxiXbeiK5mfX385Ug2wSVcFBlyDQJ+/KponKHR5hoi/qFqwn1gpTaaXsLDZqOa6ccIHbJWLt8RIBArCW6Hb9kkE4tKDoijPpRVTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXFBoxFXBtMc80h1d6/q+oeMzCcUDVVAQBDgoO/3dy0=;
 b=bv07C2+DjJE7gVZd8Y4ydwb52hsqmVesDRA3DGzG6sdWgGFmrn6mG5i6OSDeipyAOORkUCgo4SHjK9oY0Y0R87XSgOLUzNC3XlKQueCGwLcj5un4QLSJu6TZRnTZV852Djbt843DAOi3VsdMT8D8I8ygd/iq5N3OcdmCM75zbEgqdxAw8YrcHYPJR20IoQyMB/aDUK5dRZEkEHxl007/WKoEXbK+FdrrDUVtLYdzccwXiURpyhi0oNgAS8kNNxHC4BRu6qHxFj8PMKsp7jrnoNtn/sWkhVvwjH8N7fWUC8LHTEXWDNbXyx+r63tA35lk48nmeZbSCTEsGvQ1YtPXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.24; Sat, 25 Nov 2023 06:38:33 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 06:38:33 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, David Laight <David.Laight@aculab.com>, "Evan
 Green" <evan@rivosinc.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v11 3/5] riscv: Add checksum header
Thread-Topic: [PATCH v11 3/5] riscv: Add checksum header
Thread-Index: AQHaGZz9ffOuNJ7RfECBYl54jfwiyrCKoFjw
Date: Sat, 25 Nov 2023 06:38:32 +0000
Message-ID: <DM8PR11MB575199D2693923C5A538457EB8BFA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
 <20231117-optimize_checksum-v11-3-7d9d954fe361@rivosinc.com>
In-Reply-To: <20231117-optimize_checksum-v11-3-7d9d954fe361@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DM4PR11MB6264:EE_
x-ms-office365-filtering-correlation-id: fa2f1691-e4c1-4654-40b9-08dbed8124de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rG6Y9FGqptfnuAsU9aghHOrBsCLPIb7b1RaP3fL+H7GsDozx50Mtk5CwtmxTfeABM/QVUdWO7HQujN/JuusAjpdPupZZtA5civ5zW6/LCCL/bxZkCEzsek3kd1wJiaaNvRk0SKgc2KXd6W8mgOols5xa3ICDmswf2exMHDDN6sfqrWjwr2iIpoaFmpWzfYC1oMTzFKtMY71tt8Lq6I/iv4kFmVoXJ8Ejk9c36IDnM4teNtw9AJctHvsVn0UoSe42IBHSO0mPIiCFTuIDDkgz7XYairECyQAipsf3qyWSjqbokh6tGMWUYpsw6FaOlTe8yEDl6Y4y2YmtgJgR0gn7C4FP6e5P/Xwxl7UpyEK/CAsbYV8NF0BtotJbNOZU3X5z94F7EzI3HnqVM9DvIpQoY2xwCfrZJCQWqe4oKTfab1XkhIkKWc+mMCQQ6phDZtdrd6S0x6R3FHZIfE48YA5wtVoXTEdtNVOCVxofB0lIK3y2DEfibK5PJhi7PjETQY5K0TjxC32ezWIW7f5wE0wCy/pkJWk5AvJsfAke1Fk6gdl9aQVANbyDX2ySurxmouP5UKQQS3ygMhu1JztX57kyVIvbpyMaxRPYBJM9hqbJUHFfe/kEK5xnwV5SpVQ1eSwc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(76116006)(66476007)(66446008)(64756008)(54906003)(316002)(52536014)(66556008)(66946007)(8936002)(8676002)(4326008)(478600001)(110136005)(7416002)(86362001)(5660300002)(2906002)(41300700001)(71200400001)(33656002)(122000001)(38100700002)(7696005)(6506007)(53546011)(9686003)(83380400001)(26005)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWNvZ2g4N3hPUFNUeHhIOC82Z2pNSHg0VW42dS9xRDdVd1BYbE9qdWliMlZI?=
 =?utf-8?B?RGdIem03S0g0ejZiZlhpcFZCRFEwcWc2U2hhMVdZQmlpTUxTMU1zYnBFc1NY?=
 =?utf-8?B?bDJ5VFRpTG1tVWo0RkM0VlYvZ2lhNXp0MVR2RUtnZTQzTGxaUzRCL25KUzRn?=
 =?utf-8?B?dU01ZkNSV0xVT2FadThocklFbTVQQmJpdGliOVhHU05tdE9henY0SlJZTUV2?=
 =?utf-8?B?bTlLQUVVWkY0Mm13aHNUZHp0V3NQMGxPYnJYQmI5ckpKNjhqOGF0U1Bla2Yz?=
 =?utf-8?B?RmIrYzlmZFpEaXdEM21oKzNvTWtHWlRFYk9NRDVCbXRLWXhheFdkYThQaXNE?=
 =?utf-8?B?b0xJWU9LK3NqOW1EandidktLUFYwaWd5SG8raVh4OW45LzdGeGZMZmdmdmFQ?=
 =?utf-8?B?REZic3kyZE8xcTdaTklMTVpsTmxGYk9PMGJodm5Od3cxSFcxT0k3UXRDeFhC?=
 =?utf-8?B?d3NwL04yVlNOUFNYOGZMR1dzS2cvREUzNWkramxEYnM1cFllMURwNUhrbW9N?=
 =?utf-8?B?VlNqcVo1bDM1QkJuQ2xXTVRIcGZXZ3JiaWxBM09OVC9waUZlanpEbnNWTjFD?=
 =?utf-8?B?cjFkMjN1b3RrVGUvWGRRNDB6bmhxbVJkdWJMR1VSWmVib2xmVmE5S3BGMWxx?=
 =?utf-8?B?MjhOZks1UlRvRUdJcmFrOG5Fdm5DdDdURWJlYzFHN0NCYmFDK2VzTmx0WXUy?=
 =?utf-8?B?dHY2R2hXK05OL3Z2UTVnTkVVZnFsajhDMjZqb1R2WTJzbUNFYlg5RUVNeit4?=
 =?utf-8?B?QldYTGpqajlDNExXbEJBQWJRL1JrcXAyajc1empYVGdlOUVheFJWNFo5Z21G?=
 =?utf-8?B?L3lFY0J3L2lmWVJOQk5lTGlwbTRZRmY5WURydGQ0Vk12VnNxZG5mUXlTSXVQ?=
 =?utf-8?B?TXJyNzB1eDNTVk83UEpOOUp6TnJKSGVWNTk1UEsyM0gwbGNvYldUR01nSXVp?=
 =?utf-8?B?d2xVSDhES3JLNmNrYnY4eEV5RVZ3OE1zdllQeUVTN1lWcEw3ODM1R1JjMmwv?=
 =?utf-8?B?NVpIWFJCVUNpL0NnUHlMcm1meXNYeEs3bHY4Q1pQeDVrU1FlL2l2b3c2MTR0?=
 =?utf-8?B?WnZ0TEdHbDFqWHloV1FwNVZEKzE2djJUWU9ZRlk0VHNkQW9wNG41Vk5SNnhP?=
 =?utf-8?B?cXQ1VGkzZFF1T1cxeU5HNmIxVXZnWnBrRndPZURVWEJFOXYxeS9LeStXdmFp?=
 =?utf-8?B?TDdwVWZrYTN2RldncTRzVStXdWM1YW10RDUvWThRYlVVRisyZXVCOWdHaVcy?=
 =?utf-8?B?K1RPbUlqOWhmSWdiRTNqeW5WY3BsTFZrQ2duNDRFaWVUYXpTTFhJclp6WVJX?=
 =?utf-8?B?WDA3bHd6dlBQNklHK3Vkd3RmbCtnUGx6d2JDOTNyUFFTQmlvU2l1eE5ONHRm?=
 =?utf-8?B?WXEyTlloWVFCTDRVdVRYQ05hUTNiTTVpeVRMb2hraVhuSkgzN0c2azZtdzNU?=
 =?utf-8?B?ekVQaVdXa3ZkeTllbTF6Y1c2T2VTUHlUSWJIRVoxZmNERjJyNHMyTlEwZmFI?=
 =?utf-8?B?d1d5UWcxaUVOd3NONTZKSmhvWlR3dm9nRWNEa0dDdWI2dGJ5K2s3WkZqSVFF?=
 =?utf-8?B?Nk5VQ243YXVvTjBKeGlFWk9oWDhZN09QVERNaVQ5NExpaWRXRTVmYXNDYmx1?=
 =?utf-8?B?QjJQZGRLV21QWi8rN3M3MUxhQjlKMnNjRnFNeGRNU1dFVlNKS05sZlRCQk9C?=
 =?utf-8?B?RkxidzI0VlFFcXE5bk53WVlvMWVzMkhZMWhEQ0pYL1E4eGQxN2ZIMXRuOFlI?=
 =?utf-8?B?Q3F5L0sxb2hXeDMreFJmdUxOYitwQlFEN3dqeUpiWGNWUVlUeWp6YlNERkxL?=
 =?utf-8?B?NjNXa2dqRkdFZzlZK3kzTFlRQUJOcEVxUU8zQjkwcko0dVdyNDRiSFhqRlZZ?=
 =?utf-8?B?WWE1V2VtMEJqNEdCZ2RybzZTRlNDTkRXL2ZTSzRtYWlEaVF2KzBkT1RxWGZC?=
 =?utf-8?B?YkFXZm5qUmh5Ty9OTzZrbHZoTGpORCt3K0I0NnNxeXd5WHhaL0l3K284U2Rm?=
 =?utf-8?B?cHM5SngwZitMaXNlUGc3QkIxRHpzRXdqMkZXZ2pGRW1VREdVMVQ3U1lxUkpL?=
 =?utf-8?B?RDVGa3JMSE9SajUyL1NVWDFaNWtZeFJKMEZ1cFdHSGxENnhCS2xRM3pkN0lX?=
 =?utf-8?Q?hQK9gVLH8ylbQvZDuY7rKvmNZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2f1691-e4c1-4654-40b9-08dbed8124de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2023 06:38:32.7965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ks12yLkdYIJb2Z2UPhLWhte4aAcYTOYxzEOFH06xOU/YpJVbuZuixst5OLtMbhc52zmr7Bfqs4UdIZ/vXsbG7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hhcmxpZSBKZW5raW5z
IDxjaGFybGllQHJpdm9zaW5jLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE5vdmVtYmVyIDE4LCAy
MDIzIDU6MjggQU0NCj4gVG86IENoYXJsaWUgSmVua2lucyA8Y2hhcmxpZUByaXZvc2luYy5jb20+
OyBQYWxtZXIgRGFiYmVsdA0KPiA8cGFsbWVyQGRhYmJlbHQuY29tPjsgQ29ub3IgRG9vbGV5IDxj
b25vckBrZXJuZWwub3JnPjsgU2FtdWVsIEhvbGxhbmQNCj4gPHNhbXVlbC5ob2xsYW5kQHNpZml2
ZS5jb20+OyBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBhY3VsYWIuY29tPjsNCj4gV2FuZywg
WGlhbyBXIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+OyBFdmFuIEdyZWVuIDxldmFuQHJpdm9zaW5j
LmNvbT47DQo+IGxpbnV4LXJpc2N2QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBhcmNoQHZnZXIua2VybmVsLm9yZw0KPiBDYzogUGF1
bCBXYWxtc2xleSA8cGF1bC53YWxtc2xleUBzaWZpdmUuY29tPjsgQWxiZXJ0IE91DQo+IDxhb3VA
ZWVjcy5iZXJrZWxleS5lZHU+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgQ29ub3Ig
RG9vbGV5DQo+IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IHYxMSAzLzVdIHJpc2N2OiBBZGQgY2hlY2tzdW0gaGVhZGVyDQo+IA0KPiBQcm92aWRlIGNoZWNr
c3VtIGFsZ29yaXRobXMgdGhhdCBoYXZlIGJlZW4gZGVzaWduZWQgdG8gbGV2ZXJhZ2UgcmlzY3YN
Cj4gaW5zdHJ1Y3Rpb25zIHN1Y2ggYXMgcm90YXRlLiBJbiA2NC1iaXQsIGNhbiB0YWtlIGFkdmFu
dGFnZSBvZiB0aGUgbGFyZ2VyDQo+IHJlZ2lzdGVyIHRvIGF2b2lkIHNvbWUgb3ZlcmZsb3cgY2hl
Y2tpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFybGllIEplbmtpbnMgPGNoYXJsaWVAcml2
b3NpbmMuY29tPg0KPiBBY2tlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9j
aGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2NoZWNrc3VtLmggfCA4
Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9p
bmNsdWRlL2FzbS9jaGVja3N1bS5oDQo+IGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1
bS5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMmZjZjg2
NDE4NmU3DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9j
aGVja3N1bS5oDQo+IEBAIC0wLDAgKzEsODIgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wICovDQo+ICsvKg0KPiArICogQ2hlY2tzdW0gcm91dGluZXMNCj4gKyAqDQo+
ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgUml2b3MgSW5jLg0KPiArICovDQo+ICsjaWZuZGVmIF9f
QVNNX1JJU0NWX0NIRUNLU1VNX0gNCj4gKyNkZWZpbmUgX19BU01fUklTQ1ZfQ0hFQ0tTVU1fSA0K
PiArDQo+ICsjaW5jbHVkZSA8bGludXgvaW42Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvdWFjY2Vz
cy5oPg0KPiArDQo+ICsjZGVmaW5lIGlwX2Zhc3RfY3N1bSBpcF9mYXN0X2NzdW0NCj4gKw0KPiAr
LyogRGVmaW5lIHJpc2N2IHZlcnNpb25zIG9mIGZ1bmN0aW9ucyBiZWZvcmUgaW1wb3J0aW5nIGFz
bS0NCj4gZ2VuZXJpYy9jaGVja3N1bS5oICovDQo+ICsjaW5jbHVkZSA8YXNtLWdlbmVyaWMvY2hl
Y2tzdW0uaD4NCj4gKw0KPiArLyoqDQo+ICsgKiBRdWlja2x5IGNvbXB1dGUgYW4gSVAgY2hlY2tz
dW0gd2l0aCB0aGUgYXNzdW1wdGlvbiB0aGF0IElQdjQgaGVhZGVycw0KPiB3aWxsDQo+ICsgKiBh
bHdheXMgYmUgaW4gbXVsdGlwbGVzIG9mIDMyLWJpdHMsIGFuZCBoYXZlIGFuIGlobCBvZiBhdCBs
ZWFzdCA1Lg0KPiArICoNCj4gKyAqIEBpaGw6IHRoZSBudW1iZXIgb2YgMzIgYml0IHNlZ21lbnRz
IGFuZCBtdXN0IGJlIGdyZWF0ZXIgdGhhbiBvciBlcXVhbCB0bw0KPiA1Lg0KPiArICogQGlwaDog
YXNzdW1lZCB0byBiZSB3b3JkIGFsaWduZWQgZ2l2ZW4gdGhhdCBORVRfSVBfQUxJR04gaXMgc2V0
IHRvIDIgb24NCj4gKyAqICByaXNjdiwgZGVmaW5pbmcgSVAgaGVhZGVycyB0byBiZSBhbGlnbmVk
Lg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIF9fc3VtMTYgaXBfZmFzdF9jc3VtKGNvbnN0IHZv
aWQgKmlwaCwgdW5zaWduZWQgaW50IGlobCkNCj4gK3sNCj4gKwl1bnNpZ25lZCBsb25nIGNzdW0g
PSAwOw0KPiArCWludCBwb3MgPSAwOw0KPiArDQo+ICsJZG8gew0KPiArCQljc3VtICs9ICgoY29u
c3QgdW5zaWduZWQgaW50ICopaXBoKVtwb3NdOw0KPiArCQlpZiAoSVNfRU5BQkxFRChDT05GSUdf
MzJCSVQpKQ0KPiArCQkJY3N1bSArPSBjc3VtIDwgKChjb25zdCB1bnNpZ25lZCBpbnQgKilpcGgp
W3Bvc107DQo+ICsJfSB3aGlsZSAoKytwb3MgPCBpaGwpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBa
QkIgb25seSBzYXZlcyB0aHJlZSBpbnN0cnVjdGlvbnMgb24gMzItYml0IGFuZCBmaXZlIG9uIDY0
LWJpdCBzbyBub3QNCj4gKwkgKiB3b3J0aCBjaGVja2luZyBpZiBzdXBwb3J0ZWQgd2l0aG91dCBB
bHRlcm5hdGl2ZXMuDQo+ICsJICovDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1JJU0NWX0lT
QV9aQkIpICYmDQo+ICsJICAgIElTX0VOQUJMRUQoQ09ORklHX1JJU0NWX0FMVEVSTkFUSVZFKSkg
ew0KPiArCQl1bnNpZ25lZCBsb25nIGZvbGRfdGVtcDsNCj4gKw0KPiArCQlhc21fdm9sYXRpbGVf
Z290byhBTFRFUk5BVElWRSgiaiAlbFtub196YmJdIiwgIm5vcCIsIDAsDQo+ICsJCQkJCSAgICAg
IFJJU0NWX0lTQV9FWFRfWkJCLCAxKQ0KPiArCQkgICAgOg0KPiArCQkgICAgOg0KPiArCQkgICAg
Og0KPiArCQkgICAgOiBub196YmIpOw0KPiArDQo+ICsJCWlmIChJU19FTkFCTEVEKENPTkZJR18z
MkJJVCkpIHsNCj4gKwkJCWFzbSgiLm9wdGlvbiBwdXNoCQkJCVxuXA0KPiArCQkJLm9wdGlvbiBh
cmNoLCt6YmIJCQkJXG5cDQo+ICsJCQkJbm90CSVbZm9sZF90ZW1wXSwgJVtjc3VtXQ0KPiAJXG5c
DQo+ICsJCQkJcm9yaQklW2NzdW1dLCAlW2NzdW1dLCAxNgkJXG5cDQo+ICsJCQkJc3ViCSVbY3N1
bV0sICVbZm9sZF90ZW1wXSwgJVtjc3VtXQ0KPiAJXG5cDQo+ICsJCQkub3B0aW9uIHBvcCINCj4g
KwkJCTogW2NzdW1dICIrciIgKGNzdW0pLCBbZm9sZF90ZW1wXSAiPSZyIiAoZm9sZF90ZW1wKSk7
DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQlhc20oIi5vcHRpb24gcHVzaAkJCQlcblwNCj4gKwkJCS5v
cHRpb24gYXJjaCwremJiCQkJCVxuXA0KPiArCQkJCXJvcmkJJVtmb2xkX3RlbXBdLCAlW2NzdW1d
LCAzMglcblwNCj4gKwkJCQlhZGQJJVtjc3VtXSwgJVtmb2xkX3RlbXBdLCAlW2NzdW1dDQo+IAlc
blwNCj4gKwkJCQlzcmxpCSVbY3N1bV0sICVbY3N1bV0sIDMyCQlcblwNCj4gKwkJCQlub3QJJVtm
b2xkX3RlbXBdLCAlW2NzdW1dDQo+IAlcblwNCj4gKwkJCQlyb3JpdwklW2NzdW1dLCAlW2NzdW1d
LCAxNgkJXG5cDQo+ICsJCQkJc3VidwklW2NzdW1dLCAlW2ZvbGRfdGVtcF0sICVbY3N1bV0NCj4g
CVxuXA0KPiArCQkJLm9wdGlvbiBwb3AiDQo+ICsJCQk6IFtjc3VtXSAiK3IiIChjc3VtKSwgW2Zv
bGRfdGVtcF0gIj0mciIgKGZvbGRfdGVtcCkpOw0KPiArCQl9DQo+ICsJCXJldHVybiBjc3VtID4+
IDE2Ow0KPiArCX0NCj4gK25vX3piYjoNCj4gKyNpZm5kZWYgQ09ORklHXzMyQklUDQo+ICsJY3N1
bSArPSByb3I2NChjc3VtLCAzMik7DQo+ICsJY3N1bSA+Pj0gMzI7DQo+ICsjZW5kaWYNCj4gKwly
ZXR1cm4gY3N1bV9mb2xkKChfX2ZvcmNlIF9fd3N1bSljc3VtKTsNCj4gK30NCj4gKw0KPiArI2Vu
ZGlmIC8qIF9fQVNNX1JJU0NWX0NIRUNLU1VNX0ggKi8NCj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQpS
ZXZpZXdlZC1ieTogWGlhbyBXYW5nIDx4aWFvLncud2FuZ0BpbnRlbC5jb20+DQoNCg==

