Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF4B63C6F9
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiK2SCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Nov 2022 13:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiK2SCH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 13:02:07 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11011004.outbound.protection.outlook.com [40.93.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C946B392;
        Tue, 29 Nov 2022 10:02:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE+DvT2o+5XltTQ0BK/VZqd3fZBXEBQ7VsuDz294O3SPEmVKZHbbIcuo3oznV5P1w2GOQRWI1/g0FOyOqadVhD1xNbg1LYgnDlGCdfGTeqZELsIBeUPm9I8WIzN7aiPDZ7VkoaTHnNB1r1WxkO6NKJjXIf5nicRI4wDOHTYj5uP/TmuCQxjBvH3iva2joJvUHTpjAGcA2KZltiiNUlXBN6kozXUIQBS0lFLJWExHGArLLOkqRxCSnAi99ND6hj+9gfwKirs7UN+SwlFZP4CVgkhhzji8fmDm6LGQfY0Cjf5t+ogY4QJ/8l+LoDk+tRsrmtai1iXnRnzriPgzawD07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUOLnSuJdbe/kghS9icJ3CgT/0z3ugyqHT71efSGwHQ=;
 b=IJ8RXPmUw9Z+ZRlQouwz8ZDtiXx+mLQWOq95FESamSdVpTcUIGree7PxDuI6039j9g6aRZ8lNbWK5YC9CDYNIm/RjN6L0L1C1IDduI7ViKZU31+OpAh6hdvmwXKzn2SOol9QWHZWkOs/CU/NDQq6OHWSm/j6g12cC4H0TsIEAbUtJ+R79V0Mbhb3/Y1Z5KmGLEQ7Fj5QkFIm/UqFHdwGoo76uKZMl99VbQUDsapPhSMGhFNOEDZwKiYLUeXuTn1GIORVD7u1+tsfLTHepNX3yTdkUy2qQ1CLnSwK49DO/722sjux1BFRDcMLA9acQTFnTLF6dzMT4bkVRNXwVBnpFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUOLnSuJdbe/kghS9icJ3CgT/0z3ugyqHT71efSGwHQ=;
 b=e0eRB4OFc0zDsDPFDpIJGpsFPVmv9FPyfbXtXKD9snNpLQ/lBVFlBC2/+6sKh8PYY8QWHA9iDi2kDHiZriWDTkojTQxoSAvR2jhu0kuQ5oTAoXs4+7a6IQ+BRnvo00D7D5V25+GEgswFJtt04amZiz5aBPUY59FXI/cbRTPEE18=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by CO2PR05MB2775.namprd05.prod.outlook.com (2603:10b6:102:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Tue, 29 Nov
 2022 18:02:01 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f57e:85ed:97ea:b642]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f57e:85ed:97ea:b642%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 18:02:01 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Thread-Topic: [PATCH 3/3] compiler: inline does not imply notrace
Thread-Index: AQHY/qw4yX0fCsinjkK7j3XEu4rqM65LXzUAgAAL0gCACc5dAIAAG7QAgAAC0wCAALMjgIAAMPWA
Date:   Tue, 29 Nov 2022 18:02:01 +0000
Message-ID: <58C520A0-D263-4F08-B1CB-D32C043865F2@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
 <20221122195329.252654-4-namit@vmware.com>
 <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
 <B764D38F-470D-4022-A818-73814F442473@vmware.com>
 <4BDE3655-CCC3-412B-9DDB-226485113706@vmware.com>
 <20221128231532.40210855@gandalf.local.home>
 <2CFF9131-48E9-44D3-93CA-976C47106092@vmware.com>
 <20221129100647.4957579e@gandalf.local.home>
In-Reply-To: <20221129100647.4957579e@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|CO2PR05MB2775:EE_
x-ms-office365-filtering-correlation-id: c65d0ea5-c84b-4938-5a80-08dad233d0c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5/cpJhAGO4nFqpvFR8uDtid5VNSswslKlan+2J1B2IPe914iwahN4zjv0vqkMkpIiL6aKk4fv16VPCg/5wYmx4Ko4oORzrCbxk0q1/iG2nQQorbWiPGfVTeKdbJ8v6zZOvmC02uEyhF9aYEqCVbeXVGKGynRFTx205lpo3aFMEMLTt4JvUff97fHLjKupzywy5I47pfTE1ueqhzmO2ZI3IqLxTOX7wtedQcuVobMEXm/cKaO1pkF1lkCOeHckGlmL5ZPpuxcFGeKcUQpQm1GQCE2cCVH4dOg5mX6xghcLSdh9ZpJfYLx9mB6JX808jwqGZC+EBekA8H9Z0qMZNeECKHM87AjNcgnUy8w8aY2DSpwrQ5hjGPp/RwIYxpot3VGo8Pw/wMeky4Df2XN9MDa35ml3jAHWZq2co0swscOrv80ZtKreaZhatXTK9xpNe+KpAEwsk646tlLOx38WPGMxg4nhGtkDW8nNDFc65t81PMz7+FHj9GJM+7xdCJUpKwFfw7EbYVRCgsXgadJ1Z5VAoMmAorsCZ3SgneGgXr0mK/GG5ELdf4t5ZF2yn90p1TbQTFKwhCj0NZ/oecNSkZQAWxZH19Bg20TjButY9dDHq8DbcyaxdBCxGDVSj+l8KKZ2Ir1xNeOB3iiBJ9JHkkAimlX/pq37IYopRAg7ReUONiAf8KE6YJbLqFy4y7JF1ItR5XbitkcdLhok6ekY/anyGMaH2oq1EUKjkfb+tzzBM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(38100700002)(36756003)(122000001)(316002)(6916009)(54906003)(33656002)(8936002)(5660300002)(83380400001)(64756008)(66446008)(41300700001)(86362001)(66476007)(66556008)(4326008)(8676002)(66946007)(76116006)(7416002)(478600001)(2906002)(38070700005)(71200400001)(6506007)(6486002)(186003)(2616005)(26005)(6512007)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djBsR3BUbFdrSlJuVjVNL3UvWS9qLzZOSy94UmFCenEzQTE4bXh5UkVMb2lC?=
 =?utf-8?B?OTk2b3ZQRG1jKzVicUdVTWFSeXp2eHNlbWljWEFUWU8zN0g2Rjg3UVpmd1NV?=
 =?utf-8?B?QTcwNjA2eHpDN3dHYlNOc3pScUVXT1M5QmZZMEEyd3F3dGtmeVpoUDBiRm55?=
 =?utf-8?B?Z3VYZGFydjlVa2JWS1BkZnA2UVllckhvUnhWNmx6ZjBoOUxza2k1L293dTNV?=
 =?utf-8?B?R0lNSmlNcGxNanlyczZJeEZJTEhUeElKMzB5N09KTDRiQjBFUVY5KzNVMnU4?=
 =?utf-8?B?U2Q3VHB1a2NHV0lRYURlNmtZTzkzRXRVVlhKbWJ2d253S0k1aTNjdzRmUW11?=
 =?utf-8?B?L0ZEZlNaME1GZ09wOEdEandDZlpqeVRxdnl3bTB0VUxWeE81cE5iUG1JVGZU?=
 =?utf-8?B?akVub0hvWGFTeDBXaE5objFlaThYUVdYUDBUNGZJYTRsdTdDc3dlRGN0QVVF?=
 =?utf-8?B?ZjI3Qm1MUjYzYnkwbTRYOEZqaWJTRy9aVmFIcjhEUjdCOThHTFpnbzJBdFhM?=
 =?utf-8?B?VlBrczllTVBVeVlZdnoxSGs3QjlMc2FJS1VuNzlvMGFNdkp1dThlTERNUkhE?=
 =?utf-8?B?eEJYVG1zYlVmNnVzdjFuUGZYc3A0U3AxTm5kV1hpUXhzNFh2R25kZUZ2Tyth?=
 =?utf-8?B?Y2lZblg0UlB0Qm1FZWJ1aEZxU2pBZ0laRng4ZmpjU0JyS2RVUHgzTFZ4d0t0?=
 =?utf-8?B?U2t0QzFsK1AzNnY5cFJ6dW1OWHRKRGw1RzJUOE15SVdvZWR4UkxjSUZvTjdV?=
 =?utf-8?B?K3FDQ0VzVVluM2QyQVUzaWxVQjAwMjFKZEUxdDhMQlhZY21QTkRFWFZBZ0J2?=
 =?utf-8?B?NmNodDBiVTNOa3owQWxqN1pSTFd3L3Vvd0hnZ21nc0NEUFRlRDMwTVd6UzVv?=
 =?utf-8?B?T0hVZlVka0Rrd2ZmR0o2TFE3cDNlK1NQazdNcHdzcmtMVmlhdDZqMWFiU2tj?=
 =?utf-8?B?bnlHT1FGMERTaWp0bUgwUVZ2MktQTE92cVNrQ1RMS25pYVlhUWlUWFBlMG4z?=
 =?utf-8?B?MWVhdmJtR1JscWlVWThrQkxLY2tLR29iY0tCSGJBWFlUUG9yQ3JDRllGdE05?=
 =?utf-8?B?NkFpRVA5Wll6YSthWUhFYVhoT0daUjhTUXpkalE4Q0txOEkycytxV2dOajdm?=
 =?utf-8?B?YXlXMFA4ZTBKYzVDWTYwUldCbU5BMGlTdE9iUnR6MTQ3cFd4Vmo2WGNCUUNM?=
 =?utf-8?B?Uks4eGxacStqaThadHUrMWlsZSszNVBkREZCZHBkb0hVR0M3SDhMU3Nid04x?=
 =?utf-8?B?bzJDeUJZMHptNUgxYjBOc2UzS2h1eFZDbzVjUUtEeFQzdENUNVc3ZG5CNW9t?=
 =?utf-8?B?dWVFTGt4aEk5ZlV4M0RPU1hOcGdzUjFvKzNBWEcrdHNPU01yNGY2aVBZWFBK?=
 =?utf-8?B?cVRZbVJmT1ZxRDNQTFBPTWx6Y2JsbHlxTkI5K2NHa2dlUTBFOE5zKzNiNnRl?=
 =?utf-8?B?aW5CNHg5eFl0YS85dUhPc1VvaFRmYklpYWNlMkJRcE1ENUY0aFNiVTBldkZx?=
 =?utf-8?B?c3h2TUcxMVFYQklxVElnVXF1dWpBWXY1YXlYSFdibDZPalV0bjFqaVpEODBk?=
 =?utf-8?B?WGtnaXVXNG14ci9MaDVPT2hTRHpTZnZxTUpyYmI3SzM2SVVyMXRTZXdIZ3Uz?=
 =?utf-8?B?Zkx3eDdrSUFsVkgwcnoxaFFlVVRoVzhjL09jemVQMCtaQ2JGTzZkY3BteTFz?=
 =?utf-8?B?MytqN1JJSjBkUzV0amVoTHJEZEdiWEN4RFV2ajhlWTFTaWdSTy9NWkN4a3Q0?=
 =?utf-8?B?a1ZSMDJlNk5Ob0dpNUpZbVpnUnMvQldXTTl2ZWVNd2t2QWJZbCtLVjd2OGVY?=
 =?utf-8?B?RXhvaHdwTDdNVzI0YnlqTDhmSmlLU0JzMHM4TVViWnhNZG5pN3lJamFxUUMy?=
 =?utf-8?B?ZVIvbFJHb0VwaFVMYWVsWDVacVdxcmoyQzNBeTdzM08yRTN5dDBZd21hczdR?=
 =?utf-8?B?Tm9veVNCUFJidXhYOTRMbEVDWHlYQm15dFVrSm1KclpzancvZ0RjTTVSVEQz?=
 =?utf-8?B?bGZMQ0NxUDIyeXZCbm0zZGs0RUpyY3k0TGp2dXgvdEpYNllmbzlIUzU2WklI?=
 =?utf-8?B?eVZXVURWeGlzQW1OQ2JCei9QUmtqWGVldk9uemF2OU53MFE1OGczOCtVQTFn?=
 =?utf-8?Q?4K6wHphw3Q/U7qd5W86vnYmqc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D116880B88D104893E1257843434C53@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65d0ea5-c84b-4938-5a80-08dad233d0c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 18:02:01.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JruKVSOBFUCgCYfO6Hdsc1bxwiJEUB8kEc3YCAoGsYVryIDzr8PMsxfQfir1WFfOHVN5J/losXQEVdRmnzGBlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR05MB2775
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTm92IDI5LCAyMDIyLCBhdCA3OjA2IEFNLCBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29k
bWlzLm9yZz4gd3JvdGU6DQoNCj4gT24gVHVlLCAyOSBOb3YgMjAyMiAwNDoyNTozOCArMDAwMA0K
PiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3cm90ZToNCj4gDQo+IA0KPj4gSSB3aWxs
IG5lZWQgdG8gZnVydGhlciBkZWJ1ZyBpdCwgYnV0IHRoaXMgaXNzdWUgZG9lcyBub3Qgb2NjdXIg
ZXZlcnkgdGltZS4NCj4+IA0KPj4gVGhlIGtlcm5lbCBkaWRu4oCZdCBjcmFzaCBleGFjdGx5IC0g
aXTigJlzIG1vcmUgb2YgYSBkZWFkbG9jay4gSSBoYXZlIGxvY2tkZXANCj4+IGVuYWJsZWQsIHNv
IGl0IGlzIG5vdCBhIGRlYWRsb2NrIHRoYXQgbG9ja2RlcCBrbm93cy4gQ291bGQgaXQgYmUgdGhh
dA0KPj4gc29tZWhvdyB0aGluZ3MganVzdCBzbG93ZWQgZG93biBkdWUgdG8gSVBJcyBhbmQgbW9z
dGx5LWRpc2FibGVkIElSUXM/IEkgaGF2ZQ0KPj4gbm8gaWRlYS4gSSB3b3VsZCBuZWVkIHRvIHJl
Y3JlYXRlIHRoZSBzY2VuYXJpby4gDQo+IA0KPiBZb3UgaGF2ZSBsb2NrZGVwIGVuYWJsZWQgYW5k
IHlvdSBhcmUgcnVubmluZyBmdW5jdGlvbiB0cmFjaW5nIHdpdGggc3RhY2sNCj4gdHJhY2Ugb24/
IFNvIHlvdSBhcmUgZG9pbmcgYSBzdGFjayB0cmFjZSBvbiAqZXZlcnkqIGZ1bmN0aW9uIHRoYXQg
aXMgdHJhY2VkPw0KPiANCj4gSSBkb24ndCB0aGluayB5b3UgaGl0IGEgZGVhZGxvY2ssIEkgdGhp
bmsgeW91IGhpdCBhIGxpdmUgbG9jay4gWW91IGNvdWxkDQo+IHBvc3NpYmx5IHNsb3cgdGhlIHN5
c3RlbSBkb3duIHNvIG11Y2ggdGhhdCB3aGVuIGFuIGludGVycnVwdCBmaW5pc2hlcyBpdCdzDQo+
IHRpbWUgZm9yIGl0IHRvIGJlIHRyaWdnZXJlZCBhZ2FpbiwgYW5kIHlvdSBuZXZlciBtYWtlIGZv
cndhcmQgcHJvZ3Jlc3MuDQoNCkl0IG1pZ2h0IGJlIHRoZSBpc3N1ZS4gUGVyaGFwcyBJIGhhdmUg
YSBidWcsIGJlY2F1c2UgbXkgY29kZSB3YXMgc3VwcG9zZWQgdG8NCmVpdGhlciBlbmFibGUgc3Rh
Y2stdHJhY2luZyB3aXRoIHNlbGVjdGVkIGZ1bmN0aW9ucyBvciBjcmVhdGUgYSB0cmFjZSBhbGwN
CmZ1bmN0aW9uIGJ1dCAqd2l0aG91dCogc3RhY2stdHJhY2luZy4NCg0KVGhhbmtzIGZvciB0aGUg
cG9pbnRlciBhbmQgc29ycnkgZm9yIHRoZSBub2lzZS4NCg0KUmVnYXJkcywNCk5hZGF2
