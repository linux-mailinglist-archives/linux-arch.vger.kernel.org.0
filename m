Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA894FEF39
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 08:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiDMGI4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiDMGIy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:08:54 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120052.outbound.protection.outlook.com [40.107.12.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14C35A8A;
        Tue, 12 Apr 2022 23:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt4MXkmGwgEUY3K/NeComRWPh1sacQFc2jNbcmhn5vXpMyK3qQFaSu1c4EPwP0ytIMBOcKRDBUpuwDpMB1uXaP1Pi+SxLSeU8RKZpyNMune8d2QMI2gJ/X9M5JfMpx3HPeDXOpY+kGQ7YVFoqnXNvBxgT2xb/ZnjMIxcZGncBzLffBniUOW+j6CYahN/sEnyGTX5aIVtEAQf2xiFQB3mHw+q+wCjcu1jQvfjQsgC5lrFnbNDM9yekOBVxlGryxbYOtxcdP5koqeXHFisPAcDzHAKDwuhteAIXB+OKJNWSrGnGa/OLuTr1t12Ajcou1ft7Z06bEhrM4VId39iXnkHqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YRpaI743EtbqjMdjdEuZ2vlW/LDNTsaquEdIXdwy+8=;
 b=Hs1gB1BSPpT7L+uLan3vWbsBavDPpr8DNMT5qiZhMu9NWddUSRLDUOqMam/hqkFY0vpI0PQgFuXtF34xStqLbYvwXq1riI8mTiQsWOllpKpnOdyvcGJ0s54mr9wkV+7W5jOTJuYE8zSW++6Q3x4k4CiS6sYgs9sMAk5fLIvpT9zEk60gh03sytlekUR1KNiwG0g4EPgo0Si9mQNnUOHxts9bJ7mcG9X4ocLfOC1fxGBrI5tBvxqv2g8AbDCt47zmEZnHfcaOPNP6umqhXZ6kDXswQ9W1GpqOvKLMDqb0qWU75eQhhihEQY2HZNKDHtk4AsRcb2jua1bI3tDf+3gbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2890.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 06:06:28 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%8]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 06:06:28 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 7/7] mm/mmap: Drop arch_vm_get_page_pgprot()
Thread-Topic: [PATCH V6 7/7] mm/mmap: Drop arch_vm_get_page_pgprot()
Thread-Index: AQHYTvuVfcyRFzOtNEORls02nayik6ztW0GA
Date:   Wed, 13 Apr 2022 06:06:28 +0000
Message-ID: <a0b02062-6e61-4521-ae14-3279be658efc@csgroup.eu>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
 <20220413055840.392628-8-anshuman.khandual@arm.com>
In-Reply-To: <20220413055840.392628-8-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99411e2e-4e19-47e1-90da-08da1d13bfdf
x-ms-traffictypediagnostic: MRZP264MB2890:EE_
x-microsoft-antispam-prvs: <MRZP264MB289027BA3B061BDDF52C3AA4EDEC9@MRZP264MB2890.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yvjcM/KS2AsX9z6wCcO7FLyHKp1o1GmvxhJUTLYW8SGHnLv0NedhqpeTu7FGUUinEz4pRg3UXVTCmNcf+50lyd+8hpytDn+R8iNNvrpSNKGdLgrV8Xw9uENV+wklcqWNqMM3dhymieoryvpCKcsDtrKiW+4RbSobfaim7mN/kzfzVuH9grTSQlKBYCpmxvDJsfqWXNCtI0jpHW0MvmPd3nDJt5UQGoJXefX8IsUrHZVHm2lWFe2jO5Lv7ZJ6CmXqLG+gUbVVW+X6cL42HBa1yg48VzGDoEl2ORxWGvRrXrLyeTSf4CbeeerOKP2JbYb7mTISnoRGw02iS+FsGz79srDMqtmWO4POyEcDSKlymobRGvLOqaGgWEc6cDJjpRkuVbcQ6qU2SxAId9jYL0DaQAurctYjoA2qfIBBXbZ4KMnmf/xmr13NoV5VSGIsKCJdP5NDptNlxqEDcIfGpKMjWfHi1dSfRB9o6dSi3E8U4bwOQZA/m+QLG2XOHKmui0XU07hwa3R0D4gTFfcFdAmpBh+N6Tb98TpADQ/aRSONMgwoyKrHBoo236WHVrWPofJboODh5ZVgLEBk4K/ynEgBtfZoe7Wl9bUtXq+TKbZ3vsbmoJLKS/QRdY2+dbck8fhJzqWaCbKxHEuJHoFLb93mqP5OTs5e+oI8nNIDnC8Yt9rjrXQLZpa47tGUtvU5HIs7ZoTUEb6x3YSgEOLjmdZnGi2dcXzh133FCBQPx0Nf8a9/Jo/uqZAPIeGrrLdvgE+pjva7B8lURRy/1KihhEMahQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(38070700005)(76116006)(71200400001)(36756003)(44832011)(86362001)(8936002)(2616005)(7416002)(6506007)(6512007)(66574015)(31696002)(186003)(2906002)(26005)(31686004)(5660300002)(8676002)(38100700002)(66946007)(64756008)(66476007)(316002)(66446008)(4326008)(66556008)(6486002)(54906003)(122000001)(91956017)(83380400001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG9vOHVOek1zMm1mRStHajJpbEVYMWFzZWxjMHl2eWhHQ0NYb2VGM2ZzT2Qx?=
 =?utf-8?B?eTdLZHpGM00rNkwzTVAyNGlPUkZOWmdvMzNYOXdIcFpyU1RlSTZqWXVYRllv?=
 =?utf-8?B?c0NxSENQb1l3TjhiQUhwaHNLcWp5VEl6Q0lRSGh2TnFZdkxidlRaSVNRQWNH?=
 =?utf-8?B?Z3VSWFRocU5LcG5mL1lUajBGcXZYM3BLcU52MEw4cDhVZ2RnSDAvUUNFdWdm?=
 =?utf-8?B?cjcyNTFCZlBnejJmMzFqV1lUb0UvNnk2dU5yczNhQ3AvWS90YUd0ZHdKUkU4?=
 =?utf-8?B?VlVKZHpEbU93SEpsSXlnY2lNVi93bGJmSU1RT0ZsMVpzQjVRZHVJOGhHOXYr?=
 =?utf-8?B?bkZvbHZzbWU5NnZ4WTNncU9Zb3FLa3hWaFF2TEZKNXM1K0hpUWcza3p3SlJB?=
 =?utf-8?B?WXo5aXdPU2lpbDg1bkRnV3A0VWdySzhZZkVhSEFCZk5KZUR1SmZSbFRkRzFw?=
 =?utf-8?B?dmNTVUxhbzV6aW8vMDVPaDdqclhKQ3dOUnNBd21UVGRHcUthQVMzZFFHTGxa?=
 =?utf-8?B?ZnpQSGFKUlFRUE5UVGFzeWNJQTBzTEJIanlWVUtZL3pWUndUUG9UVEJjSVNl?=
 =?utf-8?B?djMvaVV3d2NjR2NiWit3WDF1YlhiY3E0S2oyWXBkVGwvL2duNUFQdDJEdXlr?=
 =?utf-8?B?c29iOTZ4ajNFUEszbXlzTE1nNE5BUmJ0VUk5Y0xDRXYrNmJxbGVlOFBmTzRz?=
 =?utf-8?B?Sk1UNW82b1BaYTZUdWRnMnUrZ05MMVNHRG8vQlh1NTJiak5FMGc1MEd5WjRW?=
 =?utf-8?B?d2taY3JrK2FnSWt4TDhoUFVLampsdmR5eTVsLzAyN3MrYzEzcVZ0NFBCRTBG?=
 =?utf-8?B?bmJyMHdmWmdyZFhTSHJBT3liWDBKM2gxSmxtTk5TZnpBK3ljdGJCK1hyR2VE?=
 =?utf-8?B?bUxGWU5zbmc5TzhsS3ZGRWxDZG9remFKS3EvcHBkdGFGSmhZYjcxOVdWTkN0?=
 =?utf-8?B?OENMTmhYSVdkcTJMRkwwR1FMNlBSRFJ5OHRvMW43WW5zd204T21mdEhMUHIz?=
 =?utf-8?B?dTVIMnFYY2dESVZXcE9EeFl4eGJJbG4yeDdaMXZZOGduMWpTUlpkMkVsNnps?=
 =?utf-8?B?THRFZUVQSEc3b05rMGdJNlgwUmJzZXdJdHoxOUs5RmEyNFE3d2RjRmc5dXc2?=
 =?utf-8?B?V2dJSmFSeHJkeStBY29sL2FJVEdka0l5bS8vWWVaVlNyT1FIdkxqbVhhai91?=
 =?utf-8?B?K20xYU0yOTA5cHdscHZHZ2RVdU1qTVFvTUtJMFZEb2pFTVVuS0E0c0h0d0E0?=
 =?utf-8?B?bmxhQmR6M01UblR4YkdXNDlTdDVQdHdjWTJpMzRKWUE5MzdzaWVzc1ZEcWNP?=
 =?utf-8?B?bEcyTTlmbWVPdkI1S2NKRmNSWHozWXdCZldwRnR1aVVyMXQwY01CNFh5SkpJ?=
 =?utf-8?B?TjhUeFlIWFMvRldyam50K3ozekp1Wk1xbU5OV0Fra2JTTlBpWXd4TUZMZll5?=
 =?utf-8?B?cmdNbjVqbXVmaE5rNGtidVp1WFRuMjcramxNdnNuaHYza3pXTDB0a1VNVXpm?=
 =?utf-8?B?T3oyQWpUTW9tS2xGL1R6aXZ6REZWOFdBbExPVkV2WVpIeGpIcmg2bVArOERR?=
 =?utf-8?B?R1FJd2kwd1BEWitTNWdhUzFaMnpLVnEyWHBidmhhRWUrNnRvby8wd0FlZU1l?=
 =?utf-8?B?c0VhMkREOVQ1RHE5ei9RYWJkVDVONXptSElTaEl5VXdWemFSWkZQam5rVVFk?=
 =?utf-8?B?eUdYMWtqOU8xQy85Wk9nYVFsajlaMStuSFkvVDFYczVpalJJYjIwSjR5ZUZk?=
 =?utf-8?B?bmsrZHMxRlZXdFB6VE9JY3NIWWExZ0s2Y0JjaklYcFF2aUx2WnRWdk1TZ2FG?=
 =?utf-8?B?TDBpcmpJajd1Z2s0ZVdVOUwyMVJONVFGREVhVTNxZENUelcxUDcrZmNRblk0?=
 =?utf-8?B?RUE3ak1uY1dqMXB1YWVNSyt1YTNJWUhMR3hNb0hHa1YvU0JXa3BnbEU3UVJm?=
 =?utf-8?B?WEE3YmZBTERHRytKWDJRZDFJM3FGSmlqaUo4MThhdUI0bWFkNisrK1VTalM0?=
 =?utf-8?B?cHNzSmNSWGprS1lTdDl5Z0pROHp0QU9YemVPWTNFVGxUM25ZcGlhVlFpYk56?=
 =?utf-8?B?K3QvbmtWY1JxVFUrdEk5cmpLdGJjT0RWQTJ6RVNpWTNkT0VHMEpvTWNSdHcy?=
 =?utf-8?B?SXJ4OTVXVTdWck9FRkxjZi9mQTBtZm83emQvRFI4bWtGN1FFY1RqYkgzQ3JQ?=
 =?utf-8?B?VTBUeGJHd0VlbDFtaDBydWJlQkh5b1pNdURtM0hHYzlBRVRKaE8rY3VWWE8x?=
 =?utf-8?B?ZnFNMHlLc3d3azhzcGhVT0RSRnh3b0ZPUFpTOXpXVkphTDNOaGNwczZML2lP?=
 =?utf-8?B?bWtKMVh0UEFyT2h0NERLdy96aVkwSWg4a0hTaURhenk3anozaFh3SjN1UGJY?=
 =?utf-8?Q?4dOfdXRKknpKK/iBvgTV0bGm2DGqk86MjeSCc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <966D6BFE6FC9A04C9FFCC5375067FC58@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 99411e2e-4e19-47e1-90da-08da1d13bfdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 06:06:28.6405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SEY4PIOm2/5qAjoV4SPsIsjC0dHzxd1qsi7QUnZGMx3BkR+WYyY05EJppveq65jye8Po0ojgPVB20srH7b6QdNHGkPy/9MgvBESFAmCsqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2890
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDEzLzA0LzIwMjIgw6AgMDc6NTgsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFRoZXJlIGFyZSBubyBwbGF0Zm9ybXMgbGVmdCB3aGljaCB1c2UgYXJjaF92bV9nZXRfcGFn
ZV9wcm90KCkuIEp1c3QgZHJvcA0KPiBnZW5lcmljIGFyY2hfdm1fZ2V0X3BhZ2VfcHJvdCgpLg0K
PiANCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IENj
OiBsaW51eC1tbUBrdmFjay5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gUmV2aWV3ZWQtYnk6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+
DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3Jv
dXAuZXU+DQoNCj4gU2lnbmVkLW9mZi1ieTogQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmto
YW5kdWFsQGFybS5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvbGludXgvbW1hbi5oIHwgNCAtLS0t
DQo+ICAgbW0vbW1hcC5jICAgICAgICAgICAgfCA0ICstLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvbW1hbi5oIGIvaW5jbHVkZS9saW51eC9tbWFuLmgNCj4gaW5kZXggYjY2ZTkxYjgx
NzZjLi41OGIzYWJkNDU3YTMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1hbi5oDQo+
ICsrKyBiL2luY2x1ZGUvbGludXgvbW1hbi5oDQo+IEBAIC05MywxMCArOTMsNiBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgdm1fdW5hY2N0X21lbW9yeShsb25nIHBhZ2VzKQ0KPiAgICNkZWZpbmUgYXJj
aF9jYWxjX3ZtX2ZsYWdfYml0cyhmbGFncykgMA0KPiAgICNlbmRpZg0KPiAgIA0KPiAtI2lmbmRl
ZiBhcmNoX3ZtX2dldF9wYWdlX3Byb3QNCj4gLSNkZWZpbmUgYXJjaF92bV9nZXRfcGFnZV9wcm90
KHZtX2ZsYWdzKSBfX3BncHJvdCgwKQ0KPiAtI2VuZGlmDQo+IC0NCj4gICAjaWZuZGVmIGFyY2hf
dmFsaWRhdGVfcHJvdA0KPiAgIC8qDQo+ICAgICogVGhpcyBpcyBjYWxsZWQgZnJvbSBtcHJvdGVj
dCgpLiAgUFJPVF9HUk9XU0RPV04gYW5kIFBST1RfR1JPV1NVUCBoYXZlDQo+IGRpZmYgLS1naXQg
YS9tbS9tbWFwLmMgYi9tbS9tbWFwLmMNCj4gaW5kZXggYjk2ZTk5NWYzNzMzLi40NzViN2MzNjcw
MzIgMTAwNjQ0DQo+IC0tLSBhL21tL21tYXAuYw0KPiArKysgYi9tbS9tbWFwLmMNCj4gQEAgLTEw
OSw5ICsxMDksNyBAQCBwZ3Byb3RfdCBwcm90ZWN0aW9uX21hcFsxNl0gX19yb19hZnRlcl9pbml0
ID0gew0KPiAgICNpZm5kZWYgQ09ORklHX0FSQ0hfSEFTX1ZNX0dFVF9QQUdFX1BST1QNCj4gICBw
Z3Byb3RfdCB2bV9nZXRfcGFnZV9wcm90KHVuc2lnbmVkIGxvbmcgdm1fZmxhZ3MpDQo+ICAgew0K
PiAtCXJldHVybiBfX3BncHJvdChwZ3Byb3RfdmFsKHByb3RlY3Rpb25fbWFwW3ZtX2ZsYWdzICYN
Cj4gLQkJCShWTV9SRUFEfFZNX1dSSVRFfFZNX0VYRUN8Vk1fU0hBUkVEKV0pIHwNCj4gLQkJCXBn
cHJvdF92YWwoYXJjaF92bV9nZXRfcGFnZV9wcm90KHZtX2ZsYWdzKSkpOw0KPiArCXJldHVybiBw
cm90ZWN0aW9uX21hcFt2bV9mbGFncyAmIChWTV9SRUFEfFZNX1dSSVRFfFZNX0VYRUN8Vk1fU0hB
UkVEKV07DQo+ICAgfQ0KPiAgIEVYUE9SVF9TWU1CT0wodm1fZ2V0X3BhZ2VfcHJvdCk7DQo+ICAg
I2VuZGlmCS8qIENPTkZJR19BUkNIX0hBU19WTV9HRVRfUEFHRV9QUk9UICov
