Return-Path: <linux-arch+bounces-22-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728D7E35F7
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 08:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2290B20B41
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 07:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6998FCA43;
	Tue,  7 Nov 2023 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acoL0bXE"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829017C3
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 07:35:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50F491;
	Mon,  6 Nov 2023 23:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699342525; x=1730878525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q1Ncs1UDtaNyenIgqpRfxqYAp5Eq7r/gyxU9SBegFlg=;
  b=acoL0bXEtRJr5n+L8CCVBfybokvaVssSe2BzCKEB80Agxuzyey7+jLJR
   ixNdwiS1N24hb5BJ1zsKXbevnkl39+y9sye6888jFjvt3Opa5ayVDznRA
   aRkoYXboLcDUnKm9nntRNlEstooSeKkmDDyCNYA6cfas8qYHpYrdl201j
   /WaSeCbW/L3Q86OxBG5ECFgGjY5RxkOtTIXxirwmkBx7Jl8UJxcNILbBY
   gr42GUyWpAGvGxai8JkLjZygbeLAWlIvDIBh7NZ+9wMosQ0r54qzvxOVn
   zzU0ApoENNYFyfALI9q4ZUy2V/7ch/JbCQjdkjMortbhUTwuRSnLQdFGd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="369649842"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="369649842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 23:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="3896494"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 23:33:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 23:33:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 23:33:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 23:33:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 23:33:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aO/vGNAdvx7IXoe1eIEgOHOQ0yDPyXI6h+yS+huHvnQViNOWbnLeWyx/dpNYpJWuXXZD1d4Q4pmO4yN3l8IrLvqysN8TyvrSDThrC6re66Kzfts8M3ngBUUgnQm6HEsjSuJzxXxAvvQMbtqLRSeafc3pSj0MvoNdUKA2PCWEnbF/v7CxcydEK2X6b55IifzHf7OCJEk8GfyFsJu+gbuF5IXWwRn4dyIVDJHL/tMHS3P1AZzX+FRcYc+lAr06KL314KTX7N5PFQRvzSfTQrQ1k/tZgp6EZiygR6BnIdggqs6KTsTy7+3HyFGdPGWRAnti9O7tjnFP1m36MN0vy2MOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1Ncs1UDtaNyenIgqpRfxqYAp5Eq7r/gyxU9SBegFlg=;
 b=ljb6fZ5CzbETIJjXz9qsRUMQiEP+5lyff63sH14GrE3TkLAB1mRdH/I9LR/QaeOJNsB4pqrf4D/uxaF6MgtlGBZ1dHdxS6GjELOjA+MzP1jHZ9bLPlMPl8iNpENzTbanMFvmleeoaSPQrj2LAxP1wOruWDKVzjftqfI+t8DKUWVgT1XJOUJcDMhYiXHfHlYKG4xHFhQj4GX6CfvhhAQHMS+m8UBJXyQtavSpwcVgCEgiUVIM91gJUmOONrgJI0WaDAnyJquLOyuMULAB18mY/obXF+7YPeKE7wLl6tyysmqxTq+8xj8Ggvw2EoEJS3y7UD/nC2M4x57vb89Jo8o9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 CY8PR11MB7035.namprd11.prod.outlook.com (2603:10b6:930:51::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Tue, 7 Nov 2023 07:33:19 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::d070:1879:5b04:5f57%4]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 07:33:19 +0000
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
Subject: RE: [PATCH v10 3/5] riscv: Checksum header
Thread-Topic: [PATCH v10 3/5] riscv: Checksum header
Thread-Index: AQHaDRWHZXzQK5VfSE6P3Qq65/nQZLBud4kg
Date: Tue, 7 Nov 2023 07:33:19 +0000
Message-ID: <DM8PR11MB57517DB5180352D536565A4FB8A9A@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20231101-optimize_checksum-v10-0-a498577bb969@rivosinc.com>
 <20231101-optimize_checksum-v10-3-a498577bb969@rivosinc.com>
In-Reply-To: <20231101-optimize_checksum-v10-3-a498577bb969@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|CY8PR11MB7035:EE_
x-ms-office365-filtering-correlation-id: e08073bc-2a0b-4eb3-d321-08dbdf63d09c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZ1pLjdVlEQgCNmncVR1v174PJ9I0QEOjqW7XlJqvimu1AF3az+B8Uoiz9VYCUSM5urqySUNCwVlVr5ENiPGZCAtYTcpCAIRtDX0Yqs5wcCznQYQPxvp05VHMD+4CDBY2cMVGLqivjo3RGaXdulXGBjnptadB2dvmGMiYpzIHt4tKGQ+6YteV8wVkg9Z0tmOTY7A4ajPXgDsK4qVcXCKqR/GCMauk7DlqIiH1unKaURbQz4c7LlWz8yW9Kbvs0lvB+30coNGdjPUKBCadA/3aUWk3JKY9PZtvO9oBljeROQssUG5qRYWBLNXodaBvllzCC9DU0TfJee4DtWZ30UujmKDVdyzLquSjbfOrIO0FhoHI89gGsfuR7rvFBWKC4AaGluJR0JGj9zRQO0+2RzuVwXDxJZwvhS95CHWjuROJoj2li0wuQgWwyjRpdtiQZ3na0fywZBsqHrKSFejod7xNj86DrXOvKA3PboHkmmrbD2v6jh3AYDYEL3HcfYod5TSGvLe5SAaQQzuNb5nLF3LUBJZz01GBI19C6B7JiD4UmW2M4apxTVgfsEz6GT2UbH8hRdwifxnz3bYVkkd/Ts6tW6z044WJPf7qCjAdGkDWaLQ0f4wrzaJGGTth6M0wONx1Iiyzb77XIilp1TrgFFc7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(9686003)(122000001)(52536014)(82960400001)(26005)(478600001)(54906003)(64756008)(76116006)(66556008)(66476007)(66446008)(66946007)(110136005)(316002)(38070700009)(53546011)(7696005)(6506007)(71200400001)(8676002)(5660300002)(8936002)(4326008)(55016003)(2906002)(38100700002)(41300700001)(33656002)(83380400001)(86362001)(7416002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2s5TVovVXY3T0F3VnBCR003d3NleGl4ZXBXa1J5cG1YRThLWmVRaDhjZWFC?=
 =?utf-8?B?Y2NSay85eGQyTnp6TjZHR1NKOG1QbGZudStVYnM2ZElOQkVySS85Tit1eXcv?=
 =?utf-8?B?NGN6WjRqdjA3MmRyekU4cm54TlVjVld1S0JOcmVkdlhzM1M1c0VVS2NZbTJr?=
 =?utf-8?B?V1UrTVlvdVRiTlFPQ2Q0YlI1ajFUL2hoOVdnUVRYazJKdjcxaWxVd2R6QVYy?=
 =?utf-8?B?cDJvelA4b0JyRFEyc25JNlVReHRMeDdOck5NNmZNSUw1L2ltK0VnZHVVZzYw?=
 =?utf-8?B?SnNCSG5jdm9XYytJK1hDaUpNWlVZR1g5Snh6Slg3L2lNejljdFg4WVlRUjFN?=
 =?utf-8?B?eVBEK1pEa0dpQ3hGc2dOVUJDalVYNEpCRTNLSXJpOXdGTHN5RmxzbDRVZFM3?=
 =?utf-8?B?YjQvclYwb2p4V0I0c05BY3o0OTY2enBEWFBDaWNDcDNHS3J3alVPZERQWUNp?=
 =?utf-8?B?Y1FXTjhhSmlRekFNWlZZeXRXU3dtRHVuUXN1dHJIckhrMUpoL2J0L1Y5NG9J?=
 =?utf-8?B?b0VFOTNZd1prMWFNK08xbmt4T05Jck92ZFk1VEZRYm5RVkJsYkdlZjFPbHZV?=
 =?utf-8?B?THg1NnBTcmdKRnlYMkJzSkNzR1ZOdy9SUjVIdEp3TjY3MDFSOE9FV3hOTnRZ?=
 =?utf-8?B?anNYZXJhbW9wZ3FUSnlXS0lPa3F3Qitzayt2dWE4UmtrNjJ3MGtKd1kyZC9L?=
 =?utf-8?B?WXlaSGxsUjdrUUJ0SWNOa1licTFkRWtQSFB3YTVqKzhTWTE3SE5iU0VnVlh2?=
 =?utf-8?B?NWFLRWo5eXRjb0ppQXRyWjI2UUdUekpFVkhPaGExRDQ0SmVPQnlGVXZQWUZD?=
 =?utf-8?B?UzV0YlpFd0gvQTFIVllZSzhlNWJmalVPTkdMOU1CZEh0Qm5xUTU4R21ZMWU5?=
 =?utf-8?B?bDN1MGRndzBXZG52V3FsVUJ2TVhTNVJHeVVsMy9VR2pxY29QckR1Q3hocGhn?=
 =?utf-8?B?NHpHTENSNEh5Uzk2ZzNjbkd2ZHN3YUV3anhEaHZyMHdRWEplS0xaNGYyWENl?=
 =?utf-8?B?b1lJZTRCRHBUWS81Qld6U215RENoTXJmbE9pOUl3SmVkMGNsVndiSXA0UFBP?=
 =?utf-8?B?eVh4TjFqM0JoL3ZRMGV3K04wbTV6TU4wZDl2YndKUURVMHRnSjFUVkpoSUpk?=
 =?utf-8?B?dEI0anRpRmUvcjFwL0JBS3NqMzNHblJnZmFhRkxHVFRJcnpvdUN2MUNJanZC?=
 =?utf-8?B?djV4STRRR3o0S0N5N0NpZnU0MTNUZWFEOVNNdUVlUUxjbUlGRWZiNnBFRlRT?=
 =?utf-8?B?V2x1M0FOSDUxVU4rcUYrcGwvMzVFYVlIWi9jVjBDdi9GNURJOXIrdnl2SWc2?=
 =?utf-8?B?a0lGall0SkZuY0JJeTg5VTJ0RjR3MmZEamdEcytGaTZNUGMyMnF5TFY1ZUtq?=
 =?utf-8?B?WmNZZ1VXVUtOdU92eURYbjdXK3ZDaXpSUm12eTUzQXQvdzV1SXFoZEhuK1JG?=
 =?utf-8?B?Y202N0RJa0JDejNPMURlem10RmJWZ3JMSmpSeFRJOU1xTDJvcSs4Mys5SXo4?=
 =?utf-8?B?bXU4bDVGV2pZTXZYK2VOMi9pNGNVQXV0aVFRdFM0bG1oQWxscmJ6M0pVYWti?=
 =?utf-8?B?aTQ0cjhGRmwrVWxhZmNLQXliOUdpSm5lS1FhQzg2WXlsNitTdzNxWXV3VG83?=
 =?utf-8?B?YUczdlhXQW5wb1dtMHJPUWEvRmI0ZTJWZjRqM1M2Q202VkZWZ0IzRXViWTBF?=
 =?utf-8?B?S2dOUHRYcUh1YVd6MEJSWVJxdzVMSjk2SXhKaEtDNUpRbzZMNFk4cEQ0RjRE?=
 =?utf-8?B?eU1DL1dkSC9aTFp6STFrcDQzVnlDYXM4ZDQ1TndqNnJNWUk4cFd2am1kUzlO?=
 =?utf-8?B?eHpqeUUzK2RUSEJ4TGd2cFRteTZVNGI5L1A4bDZnaTV2bEVTNmR1VUhyM1BP?=
 =?utf-8?B?WXVZOHZOUjltNTI1R2RIWCsyaHBUL3VYN0gvWHFOOUNsY2thSmlzcXM4VEIv?=
 =?utf-8?B?cWdUV213R3dEejhNcG5xNWErL0FSbEcrcjNaYTY2U2hNSENhRytuaEg5TEVZ?=
 =?utf-8?B?OEJVNVlMU3lJem44OGpocFpnQjNvWTVxbGVYbVNiKy8vQWxRWkxPK0lORllX?=
 =?utf-8?B?OEcycG03ZDIrTXYwcmNoNllXZW1TUVlPZ0M4djhFeTQyOWoxK2VPcER1RnIx?=
 =?utf-8?Q?Z920V52NEqg14+qUUA9FsVPHr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e08073bc-2a0b-4eb3-d321-08dbdf63d09c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 07:33:19.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZwoFFDKMxkqTm8N4l8Y80vYOf9JpvG9LIrSAoX+JRi6U6zkUxrhz9HBkNAzZaXGhXpx0sUm1WYhcqHdBHkYKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7035
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hhcmxpZSBKZW5raW5z
IDxjaGFybGllQHJpdm9zaW5jLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDIsIDIw
MjMgNjo0OCBBTQ0KPiBUbzogQ2hhcmxpZSBKZW5raW5zIDxjaGFybGllQHJpdm9zaW5jLmNvbT47
IFBhbG1lciBEYWJiZWx0DQo+IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBDb25vciBEb29sZXkgPGNv
bm9yQGtlcm5lbC5vcmc+OyBTYW11ZWwgSG9sbGFuZA0KPiA8c2FtdWVsLmhvbGxhbmRAc2lmaXZl
LmNvbT47IERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+Ow0KPiBXYW5nLCBY
aWFvIFcgPHhpYW8udy53YW5nQGludGVsLmNvbT47IEV2YW4gR3JlZW4gPGV2YW5Acml2b3NpbmMu
Y29tPjsNCj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGFyY2hAdmdlci5rZXJuZWwub3JnDQo+IENjOiBQYXVs
IFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5QHNpZml2ZS5jb20+OyBBbGJlcnQgT3UNCj4gPGFvdUBl
ZWNzLmJlcmtlbGV5LmVkdT47IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBDb25vciBE
b29sZXkNCj4gPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djEwIDMvNV0gcmlzY3Y6IENoZWNrc3VtIGhlYWRlcg0KDQpJcyBpdCBiZXR0ZXIgdG8gbWFrZSB0
aGUgdGl0bGUgbW9yZSBkZXNjcmlwdGl2ZSBhcyAicmlzY3Y6IEFkZCBjaGVja3N1bSBoZWFkZXIi
Pw0KDQo+IA0KPiBQcm92aWRlIGNoZWNrc3VtIGFsZ29yaXRobXMgdGhhdCBoYXZlIGJlZW4gZGVz
aWduZWQgdG8gbGV2ZXJhZ2UgcmlzY3YNCj4gaW5zdHJ1Y3Rpb25zIHN1Y2ggYXMgcm90YXRlLiBJ
biA2NC1iaXQsIGNhbiB0YWtlIGFkdmFudGFnZSBvZiB0aGUgbGFyZ2VyDQo+IHJlZ2lzdGVyIHRv
IGF2b2lkIHNvbWUgb3ZlcmZsb3cgY2hlY2tpbmcuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFy
bGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMuY29tPg0KPiBBY2tlZC1ieTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBhcmNoL3Jpc2N2L2lu
Y2x1ZGUvYXNtL2NoZWNrc3VtLmggfCA4MQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1bS5oDQo+IGIvYXJjaC9y
aXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1bS5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uM2Q3N2NhYzMzOGZlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
YXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9jaGVja3N1bS5oDQo+IEBAIC0wLDAgKzEsODEgQEANCj4g
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICsvKg0KPiArICogQ2hl
Y2tzdW0gcm91dGluZXMNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgUml2b3MgSW5j
Lg0KPiArICovDQo+ICsjaWZuZGVmIF9fQVNNX1JJU0NWX0NIRUNLU1VNX0gNCj4gKyNkZWZpbmUg
X19BU01fUklTQ1ZfQ0hFQ0tTVU1fSA0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgvaW42Lmg+DQo+
ICsjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0KPiArDQo+ICsjZGVmaW5lIGlwX2Zhc3RfY3N1
bSBpcF9mYXN0X2NzdW0NCj4gKw0KPiArLyogRGVmaW5lIHJpc2N2IHZlcnNpb25zIG9mIGZ1bmN0
aW9ucyBiZWZvcmUgaW1wb3J0aW5nIGFzbS0NCj4gZ2VuZXJpYy9jaGVja3N1bS5oICovDQo+ICsj
aW5jbHVkZSA8YXNtLWdlbmVyaWMvY2hlY2tzdW0uaD4NCj4gKw0KPiArLyoNCj4gKyAqIFF1aWNr
bHkgY29tcHV0ZSBhbiBJUCBjaGVja3N1bSB3aXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgSVB2NCBo
ZWFkZXJzDQo+IHdpbGwNCj4gKyAqIGFsd2F5cyBiZSBpbiBtdWx0aXBsZXMgb2YgMzItYml0cywg
YW5kIGhhdmUgYW4gaWhsIG9mIGF0IGxlYXN0IDUuDQo+ICsgKiBAaWhsIGlzIHRoZSBudW1iZXIg
b2YgMzIgYml0IHNlZ21lbnRzIGFuZCBtdXN0IGJlIGdyZWF0ZXIgdGhhbiBvciBlcXVhbA0KPiB0
byA1Lg0KPiArICogQGlwaCBpcyBhc3N1bWVkIHRvIGJlIHdvcmQgYWxpZ25lZCBnaXZlbiB0aGF0
IE5FVF9JUF9BTElHTiBpcyBzZXQgdG8gMiBvbg0KPiArICoJcmlzY3YsIGRlZmluaW5nIElQIGhl
YWRlcnMgdG8gYmUgYWxpZ25lZC4NCj4gKyAqLw0KDQpGb3IgY29tbWVudHMgb24gQVBJIHBhcmFt
ZXRlcnMsIGl0J3MgYmV0dGVyIHRvIGZvbGxvdyB0aGUgIkBwYXJhOiB4eHgiIHN0YW5kYXJkIGZv
cm1hdA0KYW5kIGluZGVudGlvbiBhbGlnbm1lbnQgdXNlZCBpbiBvdGhlciBwbGFjZXMuDQoNCj4g
K3N0YXRpYyBpbmxpbmUgX19zdW0xNiBpcF9mYXN0X2NzdW0oY29uc3Qgdm9pZCAqaXBoLCB1bnNp
Z25lZCBpbnQgaWhsKQ0KPiArew0KPiArCXVuc2lnbmVkIGxvbmcgY3N1bSA9IDA7DQo+ICsJaW50
IHBvcyA9IDA7DQo+ICsNCj4gKwlkbyB7DQo+ICsJCWNzdW0gKz0gKChjb25zdCB1bnNpZ25lZCBp
bnQgKilpcGgpW3Bvc107DQo+ICsJCWlmIChJU19FTkFCTEVEKENPTkZJR18zMkJJVCkpDQo+ICsJ
CQljc3VtICs9IGNzdW0gPCAoKGNvbnN0IHVuc2lnbmVkIGludCAqKWlwaClbcG9zXTsNCj4gKwl9
IHdoaWxlICgrK3BvcyA8IGlobCk7DQo+ICsNCj4gKwkvKg0KPiArCSAqIFpCQiBvbmx5IHNhdmVz
IHRocmVlIGluc3RydWN0aW9ucyBvbiAzMi1iaXQgYW5kIGZpdmUgb24gNjQtYml0IHNvIG5vdA0K
PiArCSAqIHdvcnRoIGNoZWNraW5nIGlmIHN1cHBvcnRlZCB3aXRob3V0IEFsdGVybmF0aXZlcy4N
Cj4gKwkgKi8NCj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUklTQ1ZfSVNBX1pCQikgJiYNCj4g
KwkgICAgSVNfRU5BQkxFRChDT05GSUdfUklTQ1ZfQUxURVJOQVRJVkUpKSB7DQo+ICsJCXVuc2ln
bmVkIGxvbmcgZm9sZF90ZW1wOw0KPiArDQo+ICsJCWFzbV92b2xhdGlsZV9nb3RvKEFMVEVSTkFU
SVZFKCJqICVsW25vX3piYl0iLCAibm9wIiwgMCwNCj4gKwkJCQkJICAgICAgUklTQ1ZfSVNBX0VY
VF9aQkIsIDEpDQo+ICsJCSAgICA6DQo+ICsJCSAgICA6DQo+ICsJCSAgICA6DQo+ICsJCSAgICA6
IG5vX3piYik7DQo+ICsNCj4gKwkJaWYgKElTX0VOQUJMRUQoQ09ORklHXzMyQklUKSkgew0KPiAr
CQkJYXNtKCIub3B0aW9uIHB1c2gJCQkJXG5cDQo+ICsJCQkub3B0aW9uIGFyY2gsK3piYgkJCQlc
blwNCj4gKwkJCQlub3QJJVtmb2xkX3RlbXBdLCAlW2NzdW1dDQo+IAlcblwNCj4gKwkJCQlyb3Jp
CSVbY3N1bV0sICVbY3N1bV0sIDE2CQlcblwNCj4gKwkJCQlzdWIJJVtjc3VtXSwgJVtmb2xkX3Rl
bXBdLCAlW2NzdW1dDQo+IAlcblwNCj4gKwkJCS5vcHRpb24gcG9wIg0KPiArCQkJOiBbY3N1bV0g
IityIiAoY3N1bSksIFtmb2xkX3RlbXBdICI9JnIiIChmb2xkX3RlbXApKTsNCj4gKwkJfSBlbHNl
IHsNCj4gKwkJCWFzbSgiLm9wdGlvbiBwdXNoCQkJCVxuXA0KPiArCQkJLm9wdGlvbiBhcmNoLCt6
YmIJCQkJXG5cDQo+ICsJCQkJcm9yaQklW2ZvbGRfdGVtcF0sICVbY3N1bV0sIDMyCVxuXA0KPiAr
CQkJCWFkZAklW2NzdW1dLCAlW2ZvbGRfdGVtcF0sICVbY3N1bV0NCj4gCVxuXA0KPiArCQkJCXNy
bGkJJVtjc3VtXSwgJVtjc3VtXSwgMzIJCVxuXA0KPiArCQkJCW5vdAklW2ZvbGRfdGVtcF0sICVb
Y3N1bV0NCj4gCVxuXA0KPiArCQkJCXJvcml3CSVbY3N1bV0sICVbY3N1bV0sIDE2CQlcblwNCj4g
KwkJCQlzdWJ3CSVbY3N1bV0sICVbZm9sZF90ZW1wXSwgJVtjc3VtXQ0KPiAJXG5cDQo+ICsJCQku
b3B0aW9uIHBvcCINCj4gKwkJCTogW2NzdW1dICIrciIgKGNzdW0pLCBbZm9sZF90ZW1wXSAiPSZy
IiAoZm9sZF90ZW1wKSk7DQo+ICsJCX0NCj4gKwkJcmV0dXJuIGNzdW0gPj4gMTY7DQo+ICsJfQ0K
PiArbm9femJiOg0KPiArI2lmbmRlZiBDT05GSUdfMzJCSVQNCj4gKwljc3VtICs9IHJvcjY0KGNz
dW0sIDMyKTsNCj4gKwljc3VtID4+PSAzMjsNCj4gKyNlbmRpZg0KPiArCXJldHVybiBjc3VtX2Zv
bGQoKF9fZm9yY2UgX193c3VtKWNzdW0pOw0KPiArfQ0KDQpUaGUgYWxnb3JpdGhtIGxvb2tzIGdv
b2QgdG8gbWUuDQoNCkJScywNClhpYW8NCg0KPiArDQo+ICsjZW5kaWYgLyogX19BU01fUklTQ1Zf
Q0hFQ0tTVU1fSCAqLw0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==

