Return-Path: <linux-arch+bounces-222-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB47EBAD3
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 02:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA782811FD
	for <lists+linux-arch@lfdr.de>; Wed, 15 Nov 2023 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9EE396;
	Wed, 15 Nov 2023 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3Ri24tB"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4842739B;
	Wed, 15 Nov 2023 01:11:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F20EDC;
	Tue, 14 Nov 2023 17:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700010685; x=1731546685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qHJE4d2C7vS0byJHP47zK02H4xpnoouZuWpkipdsHTw=;
  b=c3Ri24tBQnYyU+r99/qKZzRHRcbJDRugEXaG79x2Jmi5Yc3RZXJtxsJ7
   I138TtrTXuIs8SpZlaKgIjPEefOewSy8zS5HEWkG/eSF2UDvzhovTFofD
   aTADnyfHFb/Ic0xh66H1Lzfspbpps1OBi3LSL6fbMswnJpmV71aH1jvYq
   qU82uHsS+GJ0ozsJgOpsnPcSrtg995xCxM+6ga6MAZxbRjA3AI6c4ij/O
   WuG4nFp6rRNzlRelbznpRJq3NkqfiClsKh9eBGjfO8J1YkmfrkR3lt15u
   k6kkQXC9mDcZbVvoWglx1xnvW4aRx6pj5IUNWnH+9MWHe8UIUN1eHdpnI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="389635148"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="389635148"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 17:11:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="855487958"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="855487958"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 17:11:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 17:11:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 17:11:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 17:11:23 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 17:11:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0xnNMLvTKS/lgsDDVbOrFJzCOUzPnjzvJjlSshn8zDRfMs4lgDAhcEPLObFydWkC7ryn8L6BoezaPrL1Ve/CsZhsuwHpZ8DM1Fd5H7GA6o8tUkNmg5DPMVtZVaFQT89lVknFCknDde2BT8V5IfhIbf1RHZZh9E3DjalckibRxu4p7G55JhELPr5Iw33FDQqhw/13xzyY6apSH/YNW8R8VVan8TR4imJzXpPAPZx7EfAbmSVpCQRc3f3cVG8wPBQ4bhry+uNwtdUCuvTnDPbClyfOGhKkGDy85fu4gztdzSRoVvOPLL4ZykIqDySLGonZVgxheeVwiU9p0oCZVyUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHJE4d2C7vS0byJHP47zK02H4xpnoouZuWpkipdsHTw=;
 b=Hf/leNUiJX4nhRKqD2wHhgHkYmeVcVsQgW6rnQ7rSPGt576/mRVHsRmnGSCU9SY4jJ5F1Xap0WDIk82oQehodwpGxQAwqmvIvRBBqWB+wVy+CUmLA+AblJ2x0R3jnRdIGeSQyJU5G5dARRC5A3829vZfg8cUi1O5uR6EU88lCOvYC0rBcgDZd57or7IYeuFZgBA5Dvt7et0RzTrFzQkn44hOL2j08w7iW/lPGteuxQCogarXuITfrnF1+PbRUrUmvNjf58f4kBckaTNtxT/zscSP03TQ4rmm4SaL0qVxyoI5AWfBA4ZW2IErxV+MtLH2RwzBTD1w3nqJmZwDtaEjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SJ0PR11MB8296.namprd11.prod.outlook.com (2603:10b6:a03:47a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Wed, 15 Nov
 2023 01:11:20 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 01:11:20 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "peterz@infradead.org" <peterz@infradead.org>, "fweimer@redhat.com"
	<fweimer@redhat.com>
CC: "xry111@xry111.site" <xry111@xry111.site>, "andrealmeid@igalia.com"
	<andrealmeid@igalia.com>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Thread-Topic: Several tst-robust* tests time out with recent Linux kernel
Thread-Index: AQHaF2CkpUD9xWdoIUy/PHM3o7TKCQ==
Date: Wed, 15 Nov 2023 01:11:20 +0000
Message-ID: <822f3a867e5661ce61cea075a00ce04a4e4733f3.camel@intel.com>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
	 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
	 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
	 <20231114154017.GI4779@noisy.programming.kicks-ass.net>
	 <87ttpowajb.fsf@oldenburg.str.redhat.com>
	 <20231114201402.GA25315@noisy.programming.kicks-ass.net>
In-Reply-To: <20231114201402.GA25315@noisy.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SJ0PR11MB8296:EE_
x-ms-office365-filtering-correlation-id: 758806ed-8bb6-4236-0aee-08dbe577c70f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jVPoo85yHodWxJInD7KOjwYN2+P5huGb4SJyD4yhaF3x1Pqfeqq1jShsdsHbs2BZ26u2Rssqzi1tpe6POq/K5mr3i331ILXsqHBadTr8osHmky2RCUKPzxHOtFfTNq7xjvz6YZpSfEuG4nrbwz7yI74umQd/civifyMfISI8WPCWM9asKMTKnfjmhiTGVAI/DezU1yeXnhXNijA6pGOlKG0VAWEJdnS1Rd/OpBPlvMfs2HsGMvk04zJ29VEzqOD1gglAntv96fnatADEvycgMUP7yWWZAi/JLPJ26s+8QW0HeauHdfv5SikQ730afO0uXfLjCjwIhq7qYxcyoEpg5CBxSi/0fRoSW0RgLAStSSxMw55mCFuXeMMgHx+jtN9Bv5dOk+rbayuxIU14p5SgZ7TDtqUIMnDM3GUOhExnrmgX7EOR45m4/09sRDfgXV7vmqeZ3O9Na85G2Vla6zR8qaUwfwJk31b/VUFOeDN75D3IVjUFnfBS7Yf92pup5SSJigksxh7AV/RMEYLcA15z6HV7NuHd5+CvM6XlZEAj9ju2I7ZvR20LW2ffcdYV+P5Kss6nMboDcfWSzUnYrLUsGzM/bPKHZuLMe+M3m1ApYSVrwQeXjgRk/rLVfuo8h0a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(122000001)(6486002)(478600001)(36756003)(6506007)(316002)(76116006)(54906003)(6512007)(66946007)(66476007)(66446008)(66556008)(64756008)(110136005)(91956017)(38100700002)(41300700001)(83380400001)(71200400001)(8676002)(4326008)(8936002)(5660300002)(86362001)(4001150100001)(4744005)(2616005)(82960400001)(2906002)(26005)(7416002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUU4Y3RzVGx5MjlXL2lFVm1IeU1uS25SWkxRMVlUcDQ1Q3UrVkNnV1dXVitv?=
 =?utf-8?B?SWNPeEhKbmJyeWd1RjNMUDNESTFuL1NPNmhCc3U3a3JqdEZUYkR4UFJReFJz?=
 =?utf-8?B?cnNvNy9MUE8zcFdzb0VDMXBTZ2dHdzErRGd0NHBCK3ZQc0o2SEJsSDdhQm0z?=
 =?utf-8?B?QkM2Wk5Ja1RNcURJL29hT2lLeCtSdWFFZUhDYktWSnBiT1FNaE82ZkExZkFK?=
 =?utf-8?B?RWliSE41cWpPZk1vTnlhdFhqd0szYjRaRWVYTlc5clZHaEc1MFQ5Y2RvcGJz?=
 =?utf-8?B?T1dtMzZKaFVYY3JORkM0UUNDVkRMTk0zTjE4eGlkM21vZ2JDK2YxeGxQcjVn?=
 =?utf-8?B?Qytjc1hQVUlTR2dsQVEvd2tiYlBUcEtuSStHbkZ0cFVvVS9pTW84MEdydGw3?=
 =?utf-8?B?c25vcDZRbWdxbVM5dzhNVktjWmUyQlljd25SZVdPSDlLQVp0UWdSdHhyME94?=
 =?utf-8?B?TGQ1dTJkNVc3WjlQWDJBQkdRd2VuT25tTVp6TlZ2WW1GRm1XZUZzRWgxZjRy?=
 =?utf-8?B?OXNHdnh1aS80dlIraFJuN0Fodlh2UTQyc25qcGVEaGp1dXBLRDlwWXdmcFJ1?=
 =?utf-8?B?M1NiM2hOTk9zT1FSTktCOWRNUkVqNlpRMUZYSTJNNWxpd1VDM25PQWFGb2VF?=
 =?utf-8?B?U0FlRUVML2o5Q09pb3hUeE41Yk5WVW55VDV5WHNsWmFDWCs0ZmlEVG00dTYv?=
 =?utf-8?B?Uk5pSStXOUhtUG1sK09IMFNFZEx4QWRhR3d0Zkxpb3U5M2F0ZjhTcm42Zjl6?=
 =?utf-8?B?YkJzMEdVM1JnMlpLVXpIdExoaXpRZ0dJUjN5Q0NwQ0ZyZ0QwclhmY0hiY3o3?=
 =?utf-8?B?dXBPS0RSMDc5MGw3VWVlb3pIYWIxUVN2b09WOGVWdU1yRlFCaUg0RzBwQkpm?=
 =?utf-8?B?QkhmS3RtQmN2SkJuN0p1bFo0UmdCcUR0VUlNODErUzBsMS9XM0ovenRYU3h2?=
 =?utf-8?B?dmlpMVh0TzNQNzRRbnVjWkhEclQ3bU9yYjdhWmpvWW80MGhIMVNNeGhGYkxJ?=
 =?utf-8?B?ck9icG5iR0pXRE5NZEc4bXVDeDZ0SDZySVJNRUE1MDZSWnptZTFFUkpOUGgy?=
 =?utf-8?B?ZjdsV01VY2F1ZnNYZlliU0JHOXlyc1BUait0ZjU1Z0Q2NDBUWFI3THBxOXMz?=
 =?utf-8?B?aUUvMGYvVjlOajZKS3pzMkJiVW5uUklRNzVjSG5sdThnWTdGK0tHTndBeFlJ?=
 =?utf-8?B?UGhLaEYyc05LTC9zN3ppRHhmVUc3cmRuOEJCYWhpc0lhbzNXVkpDT0ZFZldj?=
 =?utf-8?B?eSszOHpub2RXTkc4Y29yY0IyeitMY2VSNWkyRGVCVm1OZFR1UzZSY09MVjFB?=
 =?utf-8?B?K1YwQ2JnQXF5bDUzc3MwMUdadXBNbmVZdk9DYytNMXpOb3RqejhwN0YrT3Az?=
 =?utf-8?B?VVk5MmlWT01mbnFjU0tibGkzWTJkazNZaE5aOW5teFo4NU96cVoyckcxN3p1?=
 =?utf-8?B?MG55TjFyRGdVZlZWdVQ3dlhlbU5jMDVkb1l0WDlHbUQzWlJhMUZYcmxwMjFN?=
 =?utf-8?B?NEtGcTZ2ODkxcWEvenJzbDRvWHJnN1VJQjM1NHE4byttNVp5eG9kTGpNOFZ4?=
 =?utf-8?B?WUs1dWF5VVROaUdlNENSY2UwM3RuQTZvRnhLK3hnOGducC9IdVdFY0VyZzNp?=
 =?utf-8?B?QTdOTnFXVlRtc1ZMSWxSektsb1A1K0w2QjNoYUVwZVN3Y3NDK0VKVjNwMHlF?=
 =?utf-8?B?NFAwN21QSWhLWTdBeDBMbnd4ckZwNExPd1NZMi9Oc2VhQVA3V2N6M2g5aHNr?=
 =?utf-8?B?dmdzVmo3SDFITGdzeFJRdEljZG1tRXgzMmx3cTNOSXQ5dDV2elRzTHhJN2xt?=
 =?utf-8?B?cXRQMFpuMEI5MnpkQm9tdG5NUHZVZGxMakJjWUhCS2dRaGIzOC9ZT2hab3lx?=
 =?utf-8?B?UTFEWGh4NDBUTWxudDFKaktrZHpDY1hwY3VIWDJwNG1OTUR4RVRmZlM3NmVH?=
 =?utf-8?B?bTBtOG9id2FKeEI4MjZnRFZEZitVc2ZSQVNQbDlFTi9GMnBJU0VpWGo2NFJa?=
 =?utf-8?B?anZnKzN3YkxQTWpXUUI2ZHhhbGpXVXd5MVdadnNwS0NNcTdFbW5iSDlrTnZl?=
 =?utf-8?B?QXhicHl2dlZoWFZHVzlVbFZmYWovcWV3K2tDMzRhTitRUUE0Z0RhMDhKM1BN?=
 =?utf-8?B?UE1teE9nSGJIcXZSTEQvT21qdWU0aHd5RVVhRXpXTXNQZVpuNUNiQXpLMjlJ?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <870329B95409694592C4FAD1340B207E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758806ed-8bb6-4236-0aee-08dbe577c70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 01:11:20.6010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO/0mA3mqK8oj+2SFggUBkCGI6ogTRO8uJTmWyFVSfRe8yIDfmkcyWHy0IraqeJNwizhYK7whWovXoPgT9e96pQqZloW0lail0M3HSD8t40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8296
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDIzLTExLTE0IGF0IDIxOjE0ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gVXJnaCwgdGhhbmtzIQ0KPiANCj4gQ29uZmlybWVkLCB0aGUgYmVsb3cgY3VyZXMgdGhpbmdz
LiBBbHRob3VnaCBJIHNob3VsZCBwcm9iYWJseSBtYWtlDQo+IHRoYXQNCj4gRkxBR1NfU0laRV8z
MiB8IEZMQUdTX1NIQVJFRCBhZ2FpbnN0IExpbnVzJyB0cmVlLg0KPiANCj4gTGV0IG1lIGdvIGRv
IGEgcHJvcGVyIHBhdGNoLg0KDQpJIHNhdyB0aGVzZSBmYWlsIG9uIHRoZSBnbGliYyBzaGFkb3cg
c3RhY2sgYnJhbmNoIHRvZGF5LCBhbmQgSSBhbHNvIHNhdw0KdGhpcyBvbmUgZmFpbGluZzoNCkZB
SUw6IG5wdGwvdHN0LXJvYnVzdHBpOA0KDQpJdCBzcGl0IG91dDoNCm11dGV4X3RpbWVkbG9jayBv
ZiA0MSBpbiB0aHJlYWQgMSBmYWlsZWQgd2l0aCAyMg0KY2hpbGQgZGlkIG5vdCBkaWUgb2YgYSBz
aWduYWwgaW4gcm91bmQgMQ0KDQpBZnRlciB0aGUgZml4IGhlcmUgSSBzYXcgdGhlIG90aGVycyBw
YXNzLCBidXQgc3RpbGwgbm90IHRzdC1yb2J1c3RwaTguDQpOb3Qgc3VyZSBpZiBpdCBpcyBzb21l
IHNoYWRvdyBzdGFjayBjb21wbGljYXRpb24uIEkgY2FuIHRyeSB0byBkaWcgaW4NCnRvbW9ycm93
IGlmIHRoZSBwcm9ibGVtIGRvZXNuJ3QganVtcCBvdXQuDQoNCg==

