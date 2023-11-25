Return-Path: <linux-arch+bounces-459-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E977F88A6
	for <lists+linux-arch@lfdr.de>; Sat, 25 Nov 2023 07:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D45F3B210BA
	for <lists+linux-arch@lfdr.de>; Sat, 25 Nov 2023 06:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00176A20;
	Sat, 25 Nov 2023 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gV2SsVqo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1665C1;
	Fri, 24 Nov 2023 22:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700894563; x=1732430563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zDgsg3FGusXIcd9qWrsvatJR5Tz0B0eitk4iutuj/10=;
  b=gV2SsVqo1OUh60iJophxDpgE1uEDV6VjJkjdqaKW+vQVgpJmcVU3adg7
   oE04C8oX73tg2jqx/JBp+gYs/W9XaP97obW/v+KHYeR6bY5jjZj11a7Gq
   tNolFUId32XRXNSFBa3cHsFAEltf/0LcFFASw1Jl7bT4AXbpKqjoGapg1
   hlxZsiCPyNx2py3t5JoCRUanPmwrrNM68F/ifDZ7414S/pfity8ftiAsn
   dgtNXL/CcAmLf/UxRCA6sm0gg+2OCWGDbMP/Lsc6/KlMFB1IiLkQIOKeB
   8iJ5xT4MFN6ip/8nLZCDdBripOnYKWohppy6NqMuEKJYVR/it0u0sLOYW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="14055644"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="14055644"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 22:42:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="767660344"
X-IronPort-AV: E=Sophos;i="6.04,225,1695711600"; 
   d="scan'208";a="767660344"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Nov 2023 22:42:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 22:42:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 24 Nov 2023 22:42:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 24 Nov 2023 22:42:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 24 Nov 2023 22:42:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fck29rVWJW/Cn6vzMucR2I3zb13eCBUAa5EILmZki6UJRqBwYJOd3fiux4maH1X3WzKpxZYCsSETWAvWrFQgtWZD85dagXKwMFS6QhP6u8qmckOVEGM0cq54Kow9omcJFZggDdhcpWxlo6N1137D0l5EaQ/DK5ubAYdy5sJSJRid0K/cWWSwqOpbZciATtC/Au5zt1WdWGUD4tfmGG7eoYgobG6bLbjwzAAi2Hn54zwdKGazwDgDLVQnqL1u1YHxJ0zXwM/q5XQdgDZOToEHHlJUTxJafmG99eqX+D0sWJThjvX43cskRkI03ETgChwdsCv0Z5jK8q8pQpTt2R44Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDgsg3FGusXIcd9qWrsvatJR5Tz0B0eitk4iutuj/10=;
 b=NlTvYzFDlHPEIXoF8/ArbwC3qRCLYC1JCFSpECTqZ2O0Tdviok67K8xmdOvRpklneniaUFZPhQJus0P5+ntbiyTEtC93lw12LYhf6DRdkqLfMmZsZsQL4owKz0xibN6Wx/4MbboGBl8l1tYCxrh2RSFn4YSHxTsDhi1ehdS+qGfHDgt7vu1QpVLK5H4dMABbLjaZnuPJaotxGDKMEPtYi3Bowk6SRW28YZ+JifajTnd3leuIx41AZyItWVxPY4UMp7NIBgAWEfgJ4nHw4c+N3V+Yy3AuDFMnDJsdHPRL7+MA6OJbPdqtDxT3kjD77ScqsqA4LiVT4g3AHkGsb+QSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.24; Sat, 25 Nov 2023 06:42:35 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 06:42:35 +0000
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
Subject: RE: [PATCH v11 4/5] riscv: Add checksum library
Thread-Topic: [PATCH v11 4/5] riscv: Add checksum library
Thread-Index: AQHaGZ0Aj4BzX6PH5E2v19ATE2XBZbCKoZBw
Date: Sat, 25 Nov 2023 06:42:35 +0000
Message-ID: <DM8PR11MB5751DDA0B278E4E43B59197EB8BFA@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231117-optimize_checksum-v11-0-7d9d954fe361@rivosinc.com>
 <20231117-optimize_checksum-v11-4-7d9d954fe361@rivosinc.com>
In-Reply-To: <20231117-optimize_checksum-v11-4-7d9d954fe361@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|DM4PR11MB6264:EE_
x-ms-office365-filtering-correlation-id: f128119e-6fbe-4968-4022-08dbed81b592
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IX8fShq6WWH151VBwcTO/oLdU13HeWSpbXyKmpG2v6HcSoaZcX/Jr8G8ARE6TBqPTvzj3K6ePjn9AqBXt4PLn1l1xvBKDWS5bHPjbFiYlHMS1qLHeCtR7S4PgCUFo1+GujvaToXEve5lLcy+wtT6JTwr4aMJN32IyumBmxqEZt1yoQiEcCrVMbMVhhlpyiy0Nw6a3SGlYyJwwO5ypUH8oMlzTx0TsOY/XRGuHMZ7A0NuIF4d9wRDyabPl9eXScxB/Z82Cb/utQqEDYkZZtgoWWbyTIqTezjPJsF9AdyNx5gmTkLSlwsB5vpElfq+V2dKZdWO2m25QU8H2WDERSJnEwrB4kf4igAaC8jHkGC6kQ0ueNYm27kNJ2+wM1pTEb8bU0NaNHGajhp1l1BhutXjRyJNqt4FJ2dDlVBr9cUqKtzfqAAOXgbtwGtoozg+gPEQUIGCJ1kNI6jg5rTQUUvFrjao0tt9kvSIWZ+ikzvow/JId4D8llm9404w3n7oAxxAvjb1Z1fT4okSr/9ssSziyh5KJvw8pLoacUg2FsJfgK9OLcasP+/iF5gAQJr3Ck8NXtrycpHby9j4eQyihaphtKM/nJzvQ4mjlncILJgmQXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(76116006)(66476007)(66446008)(64756008)(54906003)(316002)(52536014)(66556008)(66946007)(8936002)(8676002)(4326008)(478600001)(110136005)(7416002)(86362001)(5660300002)(2906002)(41300700001)(71200400001)(33656002)(122000001)(38100700002)(7696005)(6506007)(53546011)(9686003)(83380400001)(26005)(82960400001)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0dMcnpyQnJEbnRWZnQzcDdaVUdCeDh4Mm9tMnNkOVRpMkd1Qy9KN3p2RTRz?=
 =?utf-8?B?OFlVOTMrTUF3VjV6WkZhNUF6dTRibXloVXdzVkRDUjViS2hHNXlXeGcrY0ZU?=
 =?utf-8?B?aHhmYUJHVnY3MkxFbHJwbUJsS29oOGRkOUFRbFBpM3hBeTBNd2Frd3A0Nlhu?=
 =?utf-8?B?TnNCeUd2SmpvTVVDSTRSN3B1Y1UyT1h5b0JOM3lCSmt3cHpScm5KWG9Mejhz?=
 =?utf-8?B?SUxRWENGZTdRNGo2Qm9KWUE2eUNlYzEyQStvWHZGY3UwZDlaOUZ5TFhWUlJr?=
 =?utf-8?B?U05HM1c3K1RtSE1FV1VBdGtFR1lscDZ3QWQrTXJZVEo4MXhWWU1vb2dvQ0Q2?=
 =?utf-8?B?RUlIazNLZEZsRUtwcEQ4WWFUM3FBT1lBcmcvbFpXNlpzdUhuR2NIOXltTnJr?=
 =?utf-8?B?YW5GQVI3REtkTUNkem05cmg1bG0rL0ZNWlozQTdISC9lQmV6VXZiSGxQeWs5?=
 =?utf-8?B?blF5YzBreVdKS2ZwYmdNdnBRellQeG45enU2NGNSdFlDZXhhTmF6UkxNZ2Y0?=
 =?utf-8?B?Ry9SVUQvRldLbmdmS3VzazNHc1YzUVhMZVVtV0xkcDZ1bHpNNWV3QzZpc3NN?=
 =?utf-8?B?UUpoOFdCMi9YSTZudFBkNm9obHBsRFpYZmV6WDkrTTBrTFQydHRYN29TTFpN?=
 =?utf-8?B?UVpSSkpxNFg4QU1kdFhrVWhESCtHKzRIbUE4clBQZ3d1WS9lWjNzSkJlNGRP?=
 =?utf-8?B?amo3Z3hRNy9iL0tDSmNIMGw2TGh5YjIybTVtU3JGcmxsYTJOSW8weDNwVEZy?=
 =?utf-8?B?NURuZzJRZVBVZVdoR25WaXA3aC9yZWNRMmZjSDJaMjRmM1NKc3F3NEFyU2py?=
 =?utf-8?B?TXgrWG8rNWM3OEh4ZXo1U2NCTVBkVk9Sc0U2TzR3MDJQQ0JrTHdmOG1hRG5X?=
 =?utf-8?B?eDVQenFpVFcxUkxVcUkzeG43SmdRcnV5NWhMWVErZndMM2dUdWx1aThTQmxV?=
 =?utf-8?B?SFBTWXprYWxXak1VNDl1QjVJRC90RU9qRGtVR0xzVWozOG9JOXdHemhHZmFQ?=
 =?utf-8?B?YmIzNWEvMzhUc284UGUxMFN6UDJrUVozWEg3N3p3eURMbml1ZzU3VzZtcC9W?=
 =?utf-8?B?U1RjOFFIOGxhNnV5VmlNK1UzVndoZWRpUS9CNE54YU1nVUY5QjljRy9McDli?=
 =?utf-8?B?WTRrTHV1cm5Pc2dFQ0tRMFVWc01KUXc4Y2VBQjFYSE8zTmxPNHhCb3dIQ0Jo?=
 =?utf-8?B?RTBGcGdkVWZYb0Z4dXg2bnl1VGUyUjlPZDJzYXBFWnVrQU53ZUNvUm5VZ2R4?=
 =?utf-8?B?WFliU2pWeVY2MncrNFNFUFhGVk8raVlVazRIMUZBSFhUeDNYRFdZQzE3SU11?=
 =?utf-8?B?OHVVS0tWeW1DQzB0b3haQzlyVlEzeTJ4TWljWm1WMzhMVmFkTk5CU1BOSnRu?=
 =?utf-8?B?NTkvWjRoZDFCQ2h5UWpFT2pQa2Q3dytsY2RJU3UyM1dkbFkvRnh2R3BISDNF?=
 =?utf-8?B?aU5FN2o3aWFndXNQYTduZUVBK0lQc2J5ODB5R2pxZGsvbmlSejlBU3NQblla?=
 =?utf-8?B?QWZ1UTA3S2hqcjhMdGpkTkxzbm0wMU50OXZYaFVCb05pMU1PbDdZd0gvNGdP?=
 =?utf-8?B?cmpuTkUzMWtaRG8zNUREUkhKbTc2UlhXK0tqWnNPNURTWm44OHhUYUtOZUJt?=
 =?utf-8?B?d3NaN3JPVWRWM1FCb1g4QUh2V2F3UXJBYStYU0pCTVppV0NCa1dUa1p4RjMv?=
 =?utf-8?B?YURyNklGMlR1TXBSTHJqK0pKQkJKcHlvMXRvbFlMSldXRHc5OFN1V2YzQ3Z3?=
 =?utf-8?B?QU5wNlhGZ0hFMmVMaE5nU3ZtcXI0SVlLRWwwMzh0amxFM0NPNDF0WjFLWlp2?=
 =?utf-8?B?RldWZmtCTzJTTldRRmhIa1JCcWZiZFZYNXA0NjZJVUMzYmJhR3RrK054L2NR?=
 =?utf-8?B?UXdMS1NVSUtSOGZPMnJvRWFrQkpYOWErZk1vVnhQWExMeHp4OG5Mb2d1ZFMz?=
 =?utf-8?B?UDRTajdZVUU5RmRlUnpJRVdrMnE3S1h3c2hVVmVXSC9vZDZkOThOMnNlcFNV?=
 =?utf-8?B?YnJBUnd4aHlyMWtxVkxtMlJzMmdFZ09DSExGTjNyZjkxRXJHcmFpYksreWo3?=
 =?utf-8?B?YjFqVkpEWDUrOWwwSWVoeVp1S3Nyb0RGdThHVnF6U3R4ZzUwTlNYK1lORHU1?=
 =?utf-8?Q?FT5KFeBK8jbdu7/kf4lJocaUE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f128119e-6fbe-4968-4022-08dbed81b592
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2023 06:42:35.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1JZ4v5eZZ14cU27LRGAhx+ANWeqWXIXNCwSepZ3GXhnAicEK1o6WBpMmKSvwqOfrHNi2UcSfb0E8uTqZRyBE4Q==
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
IHYxMSA0LzVdIHJpc2N2OiBBZGQgY2hlY2tzdW0gbGlicmFyeQ0KPiANCj4gUHJvdmlkZSBhIDMy
IGFuZCA2NCBiaXQgdmVyc2lvbiBvZiBkb19jc3VtLiBXaGVuIGNvbXBpbGVkIGZvciAzMi1iaXQN
Cj4gd2lsbCBsb2FkIGZyb20gdGhlIGJ1ZmZlciBpbiBncm91cHMgb2YgMzIgYml0cywgYW5kIHdo
ZW4gY29tcGlsZWQgZm9yDQo+IDY0LWJpdCB3aWxsIGxvYWQgaW4gZ3JvdXBzIG9mIDY0IGJpdHMu
DQo+IA0KPiBBZGRpdGlvbmFsbHkgcHJvdmlkZSByaXNjdiBvcHRpbWl6ZWQgaW1wbGVtZW50YXRp
b24gb2YgY3N1bV9pcHY2X21hZ2ljLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hhcmxpZSBKZW5r
aW5zIDxjaGFybGllQHJpdm9zaW5jLmNvbT4NCj4gQWNrZWQtYnk6IENvbm9yIERvb2xleSA8Y29u
b3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS9jaGVja3N1bS5oIHwgIDEzICstDQo+ICBhcmNoL3Jpc2N2L2xpYi9NYWtlZmlsZSAgICAgICAg
ICAgfCAgIDEgKw0KPiAgYXJjaC9yaXNjdi9saWIvY3N1bS5jICAgICAgICAgICAgIHwgMzI2DQo+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAzIGZpbGVzIGNoYW5n
ZWQsIDMzOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1bS5oDQo+IGIvYXJjaC9yaXNjdi9pbmNsdWRl
L2FzbS9jaGVja3N1bS5oDQo+IGluZGV4IDJmY2Y4NjQxODZlNy4uM2ZhMDRmZjFlZGE4IDEwMDY0
NA0KPiAtLS0gYS9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2NoZWNrc3VtLmgNCj4gKysrIGIvYXJj
aC9yaXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1bS5oDQo+IEBAIC0xMiw2ICsxMiwxNyBAQA0KPiAN
ClsuLi5dDQoNCj4gKyAqIG1pc2FsaWduZWQgYWNjZXNzZXMsIG9yIHdoZW4gYnVmZiBpcyBrbm93
biB0byBiZSBhbGlnbmVkLg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIF9fbm9fc2FuaXRpemVf
YWRkcmVzcyB1bnNpZ25lZCBpbnQNCj4gK2RvX2NzdW1fbm9fYWxpZ25tZW50KGNvbnN0IHVuc2ln
bmVkIGNoYXIgKmJ1ZmYsIGludCBsZW4pDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9uZyBjc3VtLCBk
YXRhOw0KPiArCWNvbnN0IHVuc2lnbmVkIGxvbmcgKnB0ciwgKmVuZDsNCj4gKw0KPiArCXB0ciA9
IChjb25zdCB1bnNpZ25lZCBsb25nICopKGJ1ZmYpOw0KPiArCWRhdGEgPSAqKHB0cisrKTsNCj4g
Kw0KPiArCWthc2FuX2NoZWNrX3JlYWQoYnVmZiwgbGVuKTsNCj4gKw0KPiArCWVuZCA9IChjb25z
dCB1bnNpZ25lZCBsb25nICopKGJ1ZmYgKyBsZW4pOw0KPiArCWNzdW0gPSBkb19jc3VtX2NvbW1v
bihwdHIsIGVuZCwgZGF0YSk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFpiYiBzdXBwb3J0IHNhdmVz
IDYgaW5zdHJ1Y3Rpb25zLCBzbyBub3Qgd29ydGggY2hlY2tpbmcgd2l0aG91dA0KPiArCSAqIGFs
dGVybmF0aXZlcyBpZiBzdXBwb3J0ZWQNCj4gKwkgKi8NCj4gKwlpZiAoSVNfRU5BQkxFRChDT05G
SUdfUklTQ1ZfSVNBX1pCQikgJiYNCj4gKwkgICAgSVNfRU5BQkxFRChDT05GSUdfUklTQ1ZfQUxU
RVJOQVRJVkUpKSB7DQo+ICsJCXVuc2lnbmVkIGxvbmcgZm9sZF90ZW1wOw0KPiArDQo+ICsJCS8q
DQo+ICsJCSAqIFpiYiBpcyBsaWtlbHkgYXZhaWxhYmxlIHdoZW4gdGhlIGtlcm5lbCBpcyBjb21w
aWxlZCB3aXRoIFpiYg0KPiArCQkgKiBzdXBwb3J0LCBzbyBub3Agd2hlbiBaYmIgaXMgYXZhaWxh
YmxlIGFuZCBqdW1wIHdoZW4gWmJiDQo+IGlzDQo+ICsJCSAqIG5vdCBhdmFpbGFibGUuDQo+ICsJ
CSAqLw0KPiArCQlhc21fdm9sYXRpbGVfZ290byhBTFRFUk5BVElWRSgiaiAlbFtub196YmJdIiwg
Im5vcCIsIDAsDQo+ICsJCQkJCSAgICAgIFJJU0NWX0lTQV9FWFRfWkJCLCAxKQ0KPiArCQkJCSAg
Og0KPiArCQkJCSAgOg0KPiArCQkJCSAgOg0KPiArCQkJCSAgOiBub196YmIpOw0KPiArDQo+ICsj
aWZkZWYgQ09ORklHXzMyQklUDQo+ICsJCWFzbSAoIi5vcHRpb24gcHVzaAkJCQlcblwNCj4gKwkJ
Lm9wdGlvbiBhcmNoLCt6YmIJCQkJXG5cDQo+ICsJCQlyb3JpCSVbZm9sZF90ZW1wXSwgJVtjc3Vt
XSwgMTYJXG5cDQo+ICsJCQlhZGQJJVtjc3VtXSwgJVtmb2xkX3RlbXBdLCAlW2NzdW1dCVxuXA0K
PiArCQkub3B0aW9uIHBvcCINCj4gKwkJCTogW2NzdW1dICIrciIgKGNzdW0pLCBbZm9sZF90ZW1w
XSAiPSZyIiAoZm9sZF90ZW1wKQ0KPiArCQkJOg0KPiArCQkJOiApOw0KPiArDQo+ICsjZWxzZSAv
KiAhQ09ORklHXzMyQklUICovDQo+ICsJCWFzbSAoIi5vcHRpb24gcHVzaAkJCQlcblwNCj4gKwkJ
Lm9wdGlvbiBhcmNoLCt6YmIJCQkJXG5cDQo+ICsJCQlyb3JpCSVbZm9sZF90ZW1wXSwgJVtjc3Vt
XSwgMzIJXG5cDQo+ICsJCQlhZGQJJVtjc3VtXSwgJVtmb2xkX3RlbXBdLCAlW2NzdW1dCVxuXA0K
PiArCQkJc3JsaQklW2NzdW1dLCAlW2NzdW1dLCAzMgkJXG5cDQo+ICsJCQlyb3JpdwklW2ZvbGRf
dGVtcF0sICVbY3N1bV0sIDE2CVxuXA0KPiArCQkJYWRkdwklW2NzdW1dLCAlW2ZvbGRfdGVtcF0s
ICVbY3N1bV0JXG5cDQo+ICsJCS5vcHRpb24gcG9wIg0KPiArCQkJOiBbY3N1bV0gIityIiAoY3N1
bSksIFtmb2xkX3RlbXBdICI9JnIiIChmb2xkX3RlbXApDQo+ICsJCQk6DQo+ICsJCQk6ICk7DQo+
ICsjZW5kaWYgLyogIUNPTkZJR18zMkJJVCAqLw0KPiArCQlyZXR1cm4gY3N1bSA+PiAxNjsNCj4g
Kwl9DQo+ICtub196YmI6DQo+ICsjaWZuZGVmIENPTkZJR18zMkJJVA0KPiArCWNzdW0gKz0gcm9y
NjQoY3N1bSwgMzIpOw0KPiArCWNzdW0gPj49IDMyOw0KPiArI2VuZGlmDQo+ICsJY3N1bSA9ICh1
MzIpY3N1bSArIHJvcjMyKCh1MzIpY3N1bSwgMTYpOw0KPiArCXJldHVybiBjc3VtID4+IDE2Ow0K
PiArfQ0KPiArDQo+ICsvKg0KPiArICogUGVyZm9ybSBhIGNoZWNrc3VtIG9uIGFuIGFyYml0cmFy
eSBtZW1vcnkgYWRkcmVzcy4NCj4gKyAqIFdpbGwgZG8gYSBsaWdodC13ZWlnaHQgYWRkcmVzcyBh
bGlnbm1lbnQgaWYgYnVmZiBpcyBtaXNhbGlnbmVkLCB1bmxlc3MNCj4gKyAqIGNwdSBzdXBwb3J0
cyBmYXN0IG1pc2FsaWduZWQgYWNjZXNzZXMuDQo+ICsgKi8NCj4gK3Vuc2lnbmVkIGludCBkb19j
c3VtKGNvbnN0IHVuc2lnbmVkIGNoYXIgKmJ1ZmYsIGludCBsZW4pDQo+ICt7DQo+ICsJaWYgKHVu
bGlrZWx5KGxlbiA8PSAwKSkNCj4gKwkJcmV0dXJuIDA7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFNp
Z25pZmljYW50IHBlcmZvcm1hbmNlIGdhaW5zIGNhbiBiZSBzZWVuIGJ5IG5vdCBkb2luZyBhbGln
bm1lbnQNCj4gKwkgKiBvbiBtYWNoaW5lcyB3aXRoIGZhc3QgbWlzYWxpZ25lZCBhY2Nlc3Nlcy4N
Cj4gKwkgKg0KPiArCSAqIFRoZXJlIGlzIHNvbWUgZHVwbGljYXRlIGNvZGUgYmV0d2VlbiB0aGUg
IndpdGhfYWxpZ25tZW50IiBhbmQNCj4gKwkgKiAibm9fYWxpZ25tZW50IiBpbXBsbWVudGF0aW9u
cywgYnV0IHRoZSBvdmVybGFwIGlzIHRvbyBhd2t3YXJkIHRvDQo+IGJlDQo+ICsJICogYWJsZSB0
byBmaXQgaW4gb25lIGZ1bmN0aW9uIHdpdGhvdXQgaW50cm9kdWNpbmcgbXVsdGlwbGUgc3RhdGlj
DQo+ICsJICogYnJhbmNoZXMuIFRoZSBsYXJnZXN0IGNodW5rIG9mIG92ZXJsYXAgd2FzIGRlbGVn
YXRlZCBpbnRvIHRoZQ0KPiArCSAqIGRvX2NzdW1fY29tbW9uIGZ1bmN0aW9uLg0KPiArCSAqLw0K
PiArCWlmIChzdGF0aWNfYnJhbmNoX2xpa2VseSgmZmFzdF9taXNhbGlnbmVkX2FjY2Vzc19zcGVl
ZF9rZXkpKQ0KPiArCQlyZXR1cm4gZG9fY3N1bV9ub19hbGlnbm1lbnQoYnVmZiwgbGVuKTsNCj4g
Kw0KPiArCWlmICgoKHVuc2lnbmVkIGxvbmcpYnVmZiAmIE9GRlNFVF9NQVNLKSA9PSAwKQ0KPiAr
CQlyZXR1cm4gZG9fY3N1bV9ub19hbGlnbm1lbnQoYnVmZiwgbGVuKTsNCj4gKw0KPiArCXJldHVy
biBkb19jc3VtX3dpdGhfYWxpZ25tZW50KGJ1ZmYsIGxlbik7DQo+ICt9DQo+IA0KPiAtLQ0KPiAy
LjM0LjENCg0KUmV2aWV3ZWQtYnk6IFhpYW8gV2FuZyA8eGlhby53LndhbmdAaW50ZWwuY29tPg0K
DQpCUnMsDQpYaWFvDQo=

