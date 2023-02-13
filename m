Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126F0693CD1
	for <lists+linux-arch@lfdr.de>; Mon, 13 Feb 2023 04:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBMDPU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 22:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMDPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 22:15:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8D79EFC
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 19:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676258118; x=1707794118;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=xJDBiDcQ0cWId5JcO1QpQxz/lsikwhB8GwpzVgTGWEo=;
  b=AW/ucrR1WvEfB6K4fAriSxdR4gq73Le53L0b1QuN/s5pV+jUIT2Hn1BX
   Hx3Tw4C1XztiWo+zy8Y6wiAaod9IWQN9KJ01soBS0EOYHQyD7ZAt0Y1E6
   jj4XRspr2HYFx5QeyNos5TprkTSHV7bUcdgcxcndOTc53zgLRvoJoj0sM
   chwKxU50F3I9SIPhaWr1CEFifoTcc2pF1hbeRwP42exyHEVlGEAmD2aYp
   MdOuGIUV27CicduO02Vg5Qp0p6pLFzIXs5xVeMMKurouk+LlUa4pQWqir
   k8T3mHTd2Q1nMkfLDdBxWyIZvhQEu3ff9mMC5xjBaqySrkZH3Bw1izlpt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="311157716"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="311157716"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 19:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="737358765"
X-IronPort-AV: E=Sophos;i="5.97,291,1669104000"; 
   d="scan'208";a="737358765"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 12 Feb 2023 19:15:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 12 Feb 2023 19:15:18 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 12 Feb 2023 19:15:18 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 12 Feb 2023 19:15:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBp1DIlH+PTvPnC1jodmASVgaxM9QY2YQzQRF0auu0l+XtzyJnGWvgg8iRzrYCgmC8LSwSXZxPBqsbXPnUUyFH7/NZP2dGdQM95jKC7w3rM0/xSdQOgHwolUzQHV9Lc4bx1CNB9iekXAlBuhrBlamjKQCWEi4bAUr9jF0BanTweiX/selRk00wOYwKEAfcIaDOh7aIikT+pKmJWqkjDTNNEsytXnOJYUohy4RyhBsHaUDm/IRpg6hdATzeOwCuRVOvRxRueC/wLPxRoFCM4bP3Xmkhkn9MClw1YIvDcmth5gi74vSFqCnWexqHVBEI/wyuDUxHavT4AsF/HbjIffDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJDBiDcQ0cWId5JcO1QpQxz/lsikwhB8GwpzVgTGWEo=;
 b=nVER4OW/K01ZM9xxt4TdT97Olm3N0aLwH/W5Fg4wYuW4IfOT0YHbvYhsQFBO5EYm3OI+htZdb/os777F+h/vJJ4CLL52ay/GwUUVxDvMWh0AokajDsSM1J6oYqxqXRw2CpCpDwaW+UMgpkJeJ1ADn4aVcGpDlf7BSrUTIvkcIcGnYPTT0Okz9aJbDz+INUqXFbEgLujb0QSy0IKbqcJzkTF00dDBcWlvOofV+wqb/3LJ/a5pxTlE4ikQKF6hL5ERb8WmVS1mA1cOOakHZUcZvOYUdIH0xLYZRGkZfrQPr0PfaaeNeXd47xinfP2yJyKPjHYEGDkcvhExnlua9qszcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SJ0PR11MB4960.namprd11.prod.outlook.com (2603:10b6:a03:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 03:15:15 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%7]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 03:15:15 +0000
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 5/7] alpha: Implement the new page table range API
Thread-Topic: [PATCH 5/7] alpha: Implement the new page table range API
Thread-Index: AQHZP1lkqIOOKZ6iDkmbIBe2WVNdDw==
Date:   Mon, 13 Feb 2023 03:15:15 +0000
Message-ID: <27986320585214476dc49429046766df75f21040.camel@intel.com>
References: <20230211033948.891959-1-willy@infradead.org>
         <20230211033948.891959-6-willy@infradead.org>
In-Reply-To: <20230211033948.891959-6-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4820:EE_|SJ0PR11MB4960:EE_
x-ms-office365-filtering-correlation-id: be0a8251-94d9-435a-a885-08db0d7086ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJ5s0hGsQVUKQnJxfz9Zw1a60LLR4fFEt3j/cji6AP/bOoHlIkdNzNFWXqUAMYCdLm0lUoV/hM8tSt4tNxBh5lJHobZb/MOckGWs+LmbGEVVmnPrinWGlMo0d8SCm0/jaorAmvH5zNeHrCHWUmeeQt9ixiva8ZwKfuYcffVJOHdIL8bByacdr/Qt98e1JT7Wo9WX1G1IIAxw96w7cdRZs+lmRcf5S/98jawfVip0kGKOFf2LzSaK4qIcAGO+GONwkxjxxflNKMHnygIZx9jbMcRwZJe1axwPLZ0peX6emEh6KnOAoYxRdo7wQrBfA7BnSe7AP0RbyHefdVJ4QLc4m3SuFyFiQXqEyeV9ROJ6VURiLEJ/kDfOtHSYWUCIczZiO6KOzyBPztLEs8bdIptYwnRP8HSt4LPJpzpBY/MaVOY320dJFVQXM9t5N08ZDY+xGjLNL0MyixoYC2uOf1cKM/WrSPohEjva0ZzUw0sVkh9ul8FazxTwXObqcbvNSyeJGlvbRpnpqHymJy82WJtZsF5xLmiUNg2+XcuE7XMuyPI1heJqZvHvh0nkH7rOjYDsEE5VV/5PCW3ZeOLhCmmUQcaA524kbydzauBA+WKpMI+5I5qKAsgdgyQLFk6BcMNEc0KBHPuXHi1wYZ0qJicaALkAnFttweBDda8OLvTJPe53NMywWggll6AepvbhiNcJ0SOoaaxrKMUsyuTrNyxUnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(8936002)(41300700001)(36756003)(2906002)(122000001)(5660300002)(82960400001)(83380400001)(38100700002)(186003)(6512007)(26005)(6506007)(110136005)(478600001)(86362001)(71200400001)(6486002)(64756008)(8676002)(91956017)(66556008)(66476007)(76116006)(66946007)(38070700005)(66446008)(316002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ditjWWxzZUVrdnZaQVV3a0U1TmZ5K1l0NnlmdmVkbzA3bUdpNFlJSmxpa1ZR?=
 =?utf-8?B?WW03SUVaQXJpQUNXczdGNVFkdFFRZ0lUaHlCQ1piRlhFQ3pLWmJGRXJ0RTBU?=
 =?utf-8?B?aUdaUFlyL1BrZGdPMzhETGY5SWFQeXBVNXRmSkllOHJTSTMzUFd2QktrRCt6?=
 =?utf-8?B?NC9KSzVRdTByU3c2bU5oQzVTMWVpL0Y0eW03NmlER21ROXd4c25qc3pOY1dR?=
 =?utf-8?B?RElYandpdEd4V09HZEtQRU80OERBR1A2eWdkaEhadmhGRG95bXNwUXh2Rm9r?=
 =?utf-8?B?ZUxJRXZOcVBRTzVBZmZpc2gzWldKdk0wY0ZhVjFlM0w2YkkxOHExYTVLeWJB?=
 =?utf-8?B?cDFlakY5M1FMbUhaUEtFcHFtRVAzcjk0MXJKcEc4bWRNREdLNWlBNnpxeGJB?=
 =?utf-8?B?a2FRZmRVMWVnVFFjWnNKbEpTUjEvMC84ZjJJdEpkM3BkMUJUSC9BUGl5UUo5?=
 =?utf-8?B?ZXJzL0o2YjBONzZWcHJiekZZcTF0WFVwZ05ON2NOVStkbTZ5L2dITHJXalFG?=
 =?utf-8?B?dEJOMXF6YllwMWRjR094TWlRQW5VaGo0bXBKRzhrNURxK2NQOFBiY1pWNW5t?=
 =?utf-8?B?ZERHc1lZZUozUnUwM3k5RFpRV29RMjRQamlGVU9Dd2Q5U29WRm5FV3l4K3RJ?=
 =?utf-8?B?TzVYTFlPZ0JvZ1VqUjk1QUJ2Vng3UmtGVE8yd1RobTZPdW1YcGN2dlZvUWRs?=
 =?utf-8?B?L3RkQUUvcjJnL2VGdFhya1NLL0dqM2xKV3ZGalhiZXY1QVEzcVRLT1dWaXNF?=
 =?utf-8?B?U3VyT0ZyQjRpaXlXTGp6UVI1ME9pejdkTEhvTGk1N2xwczVKZ2xDZUlzdE42?=
 =?utf-8?B?UDFRSmthazlzSS9zdTZTMVF1eWpDcEsyQmlGZHdHUXNuY2pBM0FyQytsenEv?=
 =?utf-8?B?dnpob25ZMU13THNjdkZoc2paU3pjT25SVG9IVDVBckFkc2RFREdvMFRDWEtx?=
 =?utf-8?B?aWw3L0lpUVlSSDByMExlSTNYMi95a0JXeEc0U3ZVQ3pFU3R6TE1MdGxXaEQ5?=
 =?utf-8?B?eFJZRjgwU1dLMkl6eEdUM1VlNEhPcmJmd2cwTEpucFdRVThVb3ExNktBbWE0?=
 =?utf-8?B?MXQrQmRzbFZUMFJiUlBoOTZNSElrTFI5dkNrOUFNVmlDa1ZZWTZQSGd1VzQ0?=
 =?utf-8?B?TzF2YkUwU1RVRnQrUlc2a1J0c0lPdVRGVUE5dnhOQTg1ZGNEekZUWTVRV3Y4?=
 =?utf-8?B?MStsMFJGbG95UldvZDZDK3MrVGhDb2JaQk1Ib1l3Qm11cXdMdWdZZWhpSmNW?=
 =?utf-8?B?OG1RRG5vV1NRYXFlUW5COXkveUNySVMyMWorbTJiWTZpNTJDTkhkVHB0NGFX?=
 =?utf-8?B?emVFeTIxaWkyK1VCS0UxaC9CMXBGaUVxUG8rQmpEUVp2NGE1VThqRkwwVHVt?=
 =?utf-8?B?a3FESTdRbldacDV0bUNna1Fob1FKaWFPTWxGWHE0UWh5aWVPZXN3LzFzQ0N5?=
 =?utf-8?B?Y0hBQlBmTTF4MHBhRjY2enlCMFFPUXFFZmc0WFpvRFlnVXNZcUpmdjcrOTZ5?=
 =?utf-8?B?eDdhMVFUb0FLRUYzMjNZVEJ1R3M2VlFlQ1JWMHpSMUU0aEhXWmtTaUpSWTBZ?=
 =?utf-8?B?WGJjUXVyaVdXWHA0NXhoWUIycTFib0plVHBjYVdCK2NOTk9scElOdHB4TllU?=
 =?utf-8?B?azZTd0R4a21rczN3REZUT1lFOEhELzBId0d5UXh3UkJENm9YdDlSMzUwN09v?=
 =?utf-8?B?WXAwTFRJcDBiS242MDV1YnVTam42YXJFQ0FQY25kZjlOZTNYNXg4UndBYk5L?=
 =?utf-8?B?UXVaQTd0RTZ2eC9qSE9wRktGaW1xdjBvNFRGWEhBazZ3M09JYXBXMlY3aXZh?=
 =?utf-8?B?aXFXbXBxRGFyeVBrR2tIUVpxNWk1M3BIQStyYk4zb2pKK01jS1kwbmZyb3Vu?=
 =?utf-8?B?eEkzd0dUMXo2MVA0WWFqL2hGNW9xVlJyQlFSTldDdFlKYmtKSHNON0FPdTdn?=
 =?utf-8?B?dEdNeUJEdzVYT2xoRWxvcmZWcHZFL2V2TndieHpXQjVKQXJTSHNmSVZmV01v?=
 =?utf-8?B?MTVOdHNLUllhbjVFYjdLakdoR2h6MkFhTWpmR2VPdlNwU1JzMFI2TnlDZ2t5?=
 =?utf-8?B?MjE5QmZxeGRQQ2U3VThhUEd3cXcvRUNaaVRPU1Z5QmFCQUlwWEhVckhyb0Iv?=
 =?utf-8?B?dzFQaHVVaEtxS0EwSDdoTnVzY0JIS3UxaVZYbVRaenVSWFFYM0xqZm0zVDhB?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2FBB60C55BFE74497AB059CCB006D0E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0a8251-94d9-435a-a885-08db0d7086ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 03:15:15.4988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /H9tb3g1BWAz7hYQh4H7haVn4wjVr6Wb8lotjaMEfrI6QEW/Ucnkr0UNT84S6rfRy3wUZFE7C2YDaURIAP+t/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4960
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gU2F0LCAyMDIzLTAyLTExIGF0IDAzOjM5ICswMDAwLCBNYXR0aGV3IFdpbGNveCAoT3JhY2xl
KSB3cm90ZToNCj4gQWRkIHNldF9wdGVzKCksIHVwZGF0ZV9tbXVfY2FjaGVfcmFuZ2UoKSBhbmQg
Zmx1c2hfaWNhY2hlX3BhZ2VzKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IFdpbGNv
eCAoT3JhY2xlKSA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gLS0tDQo+IMKgYXJjaC9hbHBoYS9p
bmNsdWRlL2FzbS9jYWNoZWZsdXNoLmggfCAxMCArKysrKysrKysrDQo+IMKgYXJjaC9hbHBoYS9p
bmNsdWRlL2FzbS9wZ3RhYmxlLmjCoMKgwqAgfCAxOCArKysrKysrKysrKysrKysrKy0NCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FscGhhL2luY2x1ZGUvYXNtL2NhY2hlZmx1c2guaA0KPiBiL2FyY2gv
YWxwaGEvaW5jbHVkZS9hc20vY2FjaGVmbHVzaC5oDQo+IGluZGV4IDk5NDVmZjQ4M2VhZi4uMzk1
NjQ2MGU2OWUyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FscGhhL2luY2x1ZGUvYXNtL2NhY2hlZmx1
c2guaA0KPiArKysgYi9hcmNoL2FscGhhL2luY2x1ZGUvYXNtL2NhY2hlZmx1c2guaA0KPiBAQCAt
NTcsNiArNTcsMTYgQEAgZXh0ZXJuIHZvaWQgZmx1c2hfaWNhY2hlX3VzZXJfcGFnZShzdHJ1Y3QN
Cj4gdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gwqAjZGVmaW5lIGZsdXNoX2ljYWNoZV9wYWdlKHZt
YSwgcGFnZSkgXA0KPiDCoMKgwqDCoMKgwqDCoMKgZmx1c2hfaWNhY2hlX3VzZXJfcGFnZSgodm1h
KSwgKHBhZ2UpLCAwLCAwKQ0KTm90IHJlbGF0ZWQgd2l0aCB0aGlzIHBhdGNoIG9yIGFzayBmb3Ig
Y2hhbmdlLiBKdXN0IGEgcXVlc3Rpb24gb2YgbWluZS4NCg0KU28gaXMgaXQgbm9yZSBlZmZpY2ll
bnQgdG8gaW1wbGVtZW50IHRoZSBmbHVzaF9pY2FjaGVfcGFnZShzKSBhcyBuby1vcC4NCmFuZCBk
byB0aGUgcmVhbCBmbHVzaCBpbiB1cGRhdGVfbW11X2NhY2hlKCk/DQoNCg0KUmVnYXJkcw0KWWlu
LCBGZW5nd2VpDQoNCj4gwqANCj4gKy8qDQo+ICsgKiBCb3RoIGltcGxlbWVudGF0aW9ucyBvZiBm
bHVzaF9pY2FjaGVfdXNlcl9wYWdlIGZsdXNoIHRoZSBlbnRpcmUNCj4gKyAqIGFkZHJlc3Mgc3Bh
Y2UsIHNvIG9uZSBjYWxsLCBubyBtYXR0ZXIgaG93IG1hbnkgcGFnZXMuDQo+ICsgKi8NCj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCBmbHVzaF9pY2FjaGVfcGFnZXMoc3RydWN0IHZtX2FyZWFfc3RydWN0
ICp2bWEsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgcGFnZSAqcGFn
ZSwgdW5zaWduZWQgaW50IG5yKQ0KPiArew0KPiArwqDCoMKgwqDCoMKgwqBmbHVzaF9pY2FjaGVf
dXNlcl9wYWdlKHZtYSwgcGFnZSwgMCwgMCk7DQo+ICt9DQo+ICsNCj4gwqAjaW5jbHVkZSA8YXNt
LWdlbmVyaWMvY2FjaGVmbHVzaC5oPg0KPiDCoA0KPiDCoCNlbmRpZiAvKiBfQUxQSEFfQ0FDSEVG
TFVTSF9IICovDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FscGhhL2luY2x1ZGUvYXNtL3BndGFibGUu
aA0KPiBiL2FyY2gvYWxwaGEvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+IGluZGV4IGJhNDNjYjg0
MWQxOS4uMWUzMzU0ZTk3MzFiIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FscGhhL2luY2x1ZGUvYXNt
L3BndGFibGUuaA0KPiArKysgYi9hcmNoL2FscGhhL2luY2x1ZGUvYXNtL3BndGFibGUuaA0KPiBA
QCAtMjYsNyArMjYsMTggQEAgc3RydWN0IHZtX2FyZWFfc3RydWN0Ow0KPiDCoCAqIGhvb2sgaXMg
bWFkZSBhdmFpbGFibGUuDQo+IMKgICovDQo+IMKgI2RlZmluZSBzZXRfcHRlKHB0ZXB0ciwgcHRl
dmFsKSAoKCoocHRlcHRyKSkgPSAocHRldmFsKSkNCj4gLSNkZWZpbmUgc2V0X3B0ZV9hdChtbSxh
ZGRyLHB0ZXAscHRldmFsKSBzZXRfcHRlKHB0ZXAscHRldmFsKQ0KPiArc3RhdGljIGlubGluZSB2
b2lkIHNldF9wdGVzKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB1bnNpZ25lZCBsb25nDQo+IGFkZHIs
DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwdGVfdCAqcHRlcCwgcHRlX3QgcHRl
LCB1bnNpZ25lZCBpbnQgbnIpDQo+ICt7DQo+ICvCoMKgwqDCoMKgwqDCoGZvciAoOzspIHsNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNldF9wdGUocHRlcCwgcHRlKTsNCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICgtLW5yID09IDApDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7DQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwdGVwKys7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwdGVfdmFsKHB0ZSkgKz0gMVVMIDw8IDMyOw0KPiArwqDCoMKgwqDCoMKgwqB9DQo+ICt9
DQo+ICsjZGVmaW5lIHNldF9wdGVfYXQobW0sIGFkZHIsIHB0ZXAsIHB0ZSkgc2V0X3B0ZXMobW0s
IGFkZHIsIHB0ZXAsDQo+IHB0ZSwgMSkNCj4gwqANCj4gwqAvKiBQTURfU0hJRlQgZGV0ZXJtaW5l
cyB0aGUgc2l6ZSBvZiB0aGUgYXJlYSBhIHNlY29uZC1sZXZlbCBwYWdlDQo+IHRhYmxlIGNhbiBt
YXAgKi8NCj4gwqAjZGVmaW5lIFBNRF9TSElGVMKgwqDCoMKgwqDCoChQQUdFX1NISUZUICsgKFBB
R0VfU0hJRlQtMykpDQo+IEBAIC0zMDMsNiArMzE0LDExIEBAIGV4dGVybiBpbmxpbmUgdm9pZCB1
cGRhdGVfbW11X2NhY2hlKHN0cnVjdA0KPiB2bV9hcmVhX3N0cnVjdCAqIHZtYSwNCj4gwqB7DQo+
IMKgfQ0KPiDCoA0KPiArc3RhdGljIGlubGluZSB2b2lkIHVwZGF0ZV9tbXVfY2FjaGVfcmFuZ2Uo
c3RydWN0IHZtX2FyZWFfc3RydWN0DQo+ICp2bWEsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHB0ZV90ICpwdGVwLCB1bnNpZ25lZCBpbnQg
bnIpDQo+ICt7DQo+ICt9DQo+ICsNCj4gwqAvKg0KPiDCoCAqIEVuY29kZS9kZWNvZGUgc3dhcCBl
bnRyaWVzIGFuZCBzd2FwIFBURXMuIFN3YXAgUFRFcyBhcmUgYWxsIFBURXMNCj4gdGhhdA0KPiDC
oCAqIGFyZSAhcHRlX25vbmUoKSAmJiAhcHRlX3ByZXNlbnQoKS4NCg0K
