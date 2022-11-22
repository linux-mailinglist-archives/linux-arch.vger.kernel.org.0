Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060AF6348BC
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiKVUvd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 15:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiKVUva (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 15:51:30 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11012004.outbound.protection.outlook.com [40.93.200.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFC865E9;
        Tue, 22 Nov 2022 12:51:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUd0z33HHX53kJKLFIrWAVREtWjDc09aSQpLigqDOTNET5OmEOcgd7lW46mgic9UK//zeSgV6P/pxwaYfBPFPnnTBaTWQbGzL5dhWBbJn1KBAxwyd+Md2qtOVRz4/FrOerrAvE5lkO6NbYrbH9Mw8OQSi78VM+piLTkl1AjQQqLLXjiywaIwrh0a8AF8ZUPOMQL7CRcuM2Tqm7tFPfPdKEXvI8dZ0W3GS/AIubGvGU7mPQggTybA+cUSCXm6h5tsV/X064Al8UnH1m8He2x6ko0L5I706pS37Xs7jKpO9X6BjESISSSI+/Kc/ngzrm1S6VVNgtkMOmGEcgIRAVpbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T/OjXgYQYUrl1mZ6Jon5LLiBUW3laV3qJLjAuRIO80=;
 b=kJDJcFi0i9udOa8RprL8mh+ZKiFvfaU0sY5DG195Hm6WL3Mq3ig/9sUU+bK0oSX9SNFqtii9w3BnUHCKf6yrWTt0Jk1m7wtlRQsnuCntRfMWB3BpjfKj/4zbeL+a3pYOT3OJtBqemoIFz5pHS8t6Ge5KOK/RGSRqVczErHUjC86xOg6doiQnNcIB1gOOcF/2lNRiy4dhLtHlnWKqVR9MGAj5wa+i5VMk51fDyYkuIlJ303ZXK6r68kigGOWbeY7itvnzujVxgB5KkvMUh7eNqiGPB0tXnn+VLUu23SZktAjy77EPZooNlbL1McxdZsM73sWVEiE4aGF2OBmVt6F+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T/OjXgYQYUrl1mZ6Jon5LLiBUW3laV3qJLjAuRIO80=;
 b=IQK8eahJD76K4ozuIMaNkIml/xXpwlNvgxDljk0UunLfOqqmwZO1lRexEFP1x9dvLlhiV3UXtiU2h5qyfHnFw5SkUfftgXxLA577AX6D+ag0uM+qcZKOo0jVzr4WgQBBEd7Ol9EGzVFBHdQmUS37UQkb08PYhksda6cF74fU2NI=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by PH0PR05MB7766.namprd05.prod.outlook.com (2603:10b6:510:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 20:51:27 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f57e:85ed:97ea:b642]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f57e:85ed:97ea:b642%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 20:51:27 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
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
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Thread-Topic: [PATCH 3/3] compiler: inline does not imply notrace
Thread-Index: AQHY/qw4yX0fCsinjkK7j3XEu4rqM65LXzUAgAAL0gA=
Date:   Tue, 22 Nov 2022 20:51:27 +0000
Message-ID: <B764D38F-470D-4022-A818-73814F442473@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
 <20221122195329.252654-4-namit@vmware.com>
 <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
In-Reply-To: <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|PH0PR05MB7766:EE_
x-ms-office365-filtering-correlation-id: 9df9112e-30bf-46ce-404f-08dacccb535b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7quHwcxzGNiVKVItv0ItPHaRwaz+oALn7k5FINt++dlXcr9ft+cyKETgWuoa0Cvo/WaH8qHpu9DexHlPWGZGkASOIitsnaZJlAVQZsvGrVnoPL6NTf94bCp2Geu5ouYUq1z+W+KUE6xvKs1i+eJh+BnaqeVUmCgjJ2jIVi7aAwos7sp9txo8tsezJ+ElJqKisS4n8LhQcHjukzJhY4b7XuVfoRzEsUjCz08CR1XFhCrE8uAk1yjp8ZoFbiGxqc0k1nT6wsq0qWIfDMvmsDbmJL2iSgRyJinK5WIhCoMB8xQv9KTVpFT3rFvG7oBAqTEafEMdhlVudcyldbsxZpT/kcLj6J984szvxpKYWyUCm/hVuilkY1i11z3SOivyNOmL8nYa+YuQ9sEjeXsZnjPySxRvCtjXh9VP4sbMb57HJPDzIX3xJ3r1cInpEtVOwYXZcbY39NPh0U+fWjsdk9Pjkz0yuigs30KAJQ+jJQDYBmWm+h5DLrt+f6qNZaNeNws+dTS1WszeFr+KqcJA0rrDOVJh/wq8Cgfwgil/gJ7AMN/f/SDVbEJisOfJXXSd+g60rpkPR1ZT5IHs99eABnd05NwbKRYoWh2GcB2s27EbXz55IZyQ5EaTMJT1l6PTBem7YswpF5WgEy0WdWrF61BwibpLF+EL+LeVTzHKNoknHt6o0SlT34XnoK5QwMHPNyA835GVrABtK6IqJkQVz4lDd9QqjkM4Pj/x3YNqg/ajI02NK6rXS/7Th2X2xLfay6lQxGuPnt46Us6CNxghMnHl6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(36756003)(66556008)(2616005)(33656002)(6506007)(54906003)(41300700001)(76116006)(66946007)(66446008)(86362001)(53546011)(66476007)(7416002)(316002)(5660300002)(64756008)(71200400001)(6486002)(478600001)(26005)(8936002)(6512007)(186003)(6916009)(38100700002)(122000001)(8676002)(38070700005)(4326008)(2906002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDhJVno4MHVXSnFnZVBmbGlhaGhWdWhlTUhqWFJ1cEx1T2RTYTI4dElhNGlj?=
 =?utf-8?B?ck9VU1prckxYeFJ3RmdzS1dYOVJZaFlZbXdZeC95S240b1A4RzZMVmZ6c0cw?=
 =?utf-8?B?ajBQa3llbUZwdDY5K2g2dUxna0FSbFY0MU0veFhYeWxmTjYxdHFtSGkza0ZP?=
 =?utf-8?B?dGdqNVNrOE83bVNxVyt3QisxSWVtZDIyTkpMbnNUcVFVN0hYb1ErYVZPTVhV?=
 =?utf-8?B?YUJZM1NTM3lteUVKaW0xbDdFaXhoRGk4eHdYTzJHVUkxNUZiN3Y5NDgwMDNp?=
 =?utf-8?B?K1pheGY4MzczaktyMHR0QWN0OFRBN0xTa1ZMTTIrNXU1SXJDYW9wTzg3QTEv?=
 =?utf-8?B?K1pUWGdMRmROL2QvcjVjODd3aEVZN1FkbEJqNCtSTlY2Mi9nRWJOVHN4bWdW?=
 =?utf-8?B?RnplYm52RHdNaURMYTlOQ3NhNzJvLytyTXUwTFgrUGNKTG1IaHhrS0dGRHh5?=
 =?utf-8?B?cDVhQlB0ZDYvZzNQRUNBYkQrS3lDNlNLOTd2b0RoSU1xQyt4RkRTTzY0OTRL?=
 =?utf-8?B?OXU1dGdObnRLM2RoSU50RGl3djlTVVkwTlUrMUtwRktOaGNQR1NPUG00YUJQ?=
 =?utf-8?B?Nmk0SnljOFc0VDlNU3R6WkVJL09sYlB5S0hkM0YxNXh0dytRbUc2d0lOcUhQ?=
 =?utf-8?B?alNFWFJkSmVoSEJXc0J0NktJMGxCWlVCYzNIS2E4NTd1L1FCbFdUb2RKNUVM?=
 =?utf-8?B?aDFwQUdjUzZmRjlkNVBuaVU0ZnRXNkxyVDZyRkhXUFZNWVZqc2QrNkxMUVpa?=
 =?utf-8?B?YnhuM0krN2RzeGdCbEpXeGhZd2dEc2ZQVlA4Y1NKWDZMaGtKVnNlZkRIWGpT?=
 =?utf-8?B?bExVWStpcCs3ZWhxbERIUUdtc0pZcThjTEhZTDJkeWNDU2JtTG42SnR1WFJq?=
 =?utf-8?B?OUlrU01lVDJqTDFGUnByazZ4WWU4ZG5YVUliWUJUZWJDb0NESG1IT04wQzIw?=
 =?utf-8?B?ZDM2MkNZV3ZHenEwQTRQeE1ybW1QYjlFT3RMZ0hqc1JaQ0c2ZFJldHNmdlBV?=
 =?utf-8?B?emtMWi9MZ1c5TjJUc05ULzVScWlNdTE2eFQxQXZqQjV3U042V040bWc1Zkp4?=
 =?utf-8?B?TUdUdGUwWnQvTVQ5MFhXQ0NETDE5Vi82cUZiTUxtUWFCbXNodVJvR0hqWmhB?=
 =?utf-8?B?cjFuY24vWFI3c3pPenJMQ0ZINFJ6K2RmYlg1L2VzcUk0emtTNGpMbnZUT3Y1?=
 =?utf-8?B?OHpicW5CaGY0dElsQzRvelF4YXZTdkxnMWFUZ0FaVkpFUjFDWVI3Zm5sdkll?=
 =?utf-8?B?eDlaWlcvblEyRnluczRVc0x4NExnaDlSam9iM0M5Q1lBbTB6anYxd0pxbDN0?=
 =?utf-8?B?cUxnOVcwYWt1ZjF1NFB1SWJuYTVsRUdnWHU5Q3lmbjJLRDVUVTl4dlM5bDY0?=
 =?utf-8?B?dDN4WVdUMzFKMzREa3I1NmZ2a3RrMWQ0OHczYzBrRnZSVDZLNVZyYUw4dlFx?=
 =?utf-8?B?ZVAzNEIyenVwajdWL091NlJucytuUEZKQzhoVE9IYnorQytCNm9ZSVAzLzlX?=
 =?utf-8?B?dC8zaW10VmR4MEhMQzNxYTZTOHRvK2RFZ0ZKYTV0Qjk1RkYwdXlxbHRNY3Mx?=
 =?utf-8?B?ZkJ6Ync2MFJ1cWRrd3VJQnpPL1hnZ3p4bUJSbFd4clczNEVIQmtnRXE5VjZN?=
 =?utf-8?B?T1lvMEpwOWNoekRYakF6NzZocFpsQi80bEN2ZG80c3NnWXcwUDlNNUo1OHRh?=
 =?utf-8?B?NGp6bkZ6SWY3UDVDczJEd204cVM0NXNUSmpHTFFacnRUQXZHaU5IYzQyYWlJ?=
 =?utf-8?B?RkJOTUlLc1ZBUHhBUFFicGtpZGxUMVI1WXB5K2RVcDAvUzk4Um1MdnBVR1pW?=
 =?utf-8?B?SlZNRE1NNWJwTFQ1U0I3bURmY3F4VFMyb3FkaklHcVRkVUVUTTB2emJCSk9Z?=
 =?utf-8?B?ZmgvYUJwNVhrUUhNZzFoUUdjcm1JeFJ2eUJOWXlpeDNKKzRMZzNldzBHdWhq?=
 =?utf-8?B?UXNBd00zSFZWaFQ4V0hjWjV5NU5ZM285OWE4dTVQZEVsYStkZzhiR0JmOG9S?=
 =?utf-8?B?RW1xTG5QTWxRQnJMelpYL3U5cTV3Z241REpFRy82Y09ub2E3NmVIWXFNRUFU?=
 =?utf-8?B?ZzFMVUdOUnNEWVVzQ1ozd1cyWjh2Q2JqWm82b0RKaTZ0a1B2bmJSRHVHbWhv?=
 =?utf-8?Q?UPzdSvp+RoNJjIEJ98HqV/0g8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEEA53B2F0AE6147BD219566224AD566@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df9112e-30bf-46ce-404f-08dacccb535b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 20:51:27.4794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sPoI8f7v4LEpG/BY1yj1bZpOqmX8KKk90VCFa86KSUdGJJ/9EVDpGaPYIEAc2hQIipndqTHlpZuEkB/UlP5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB7766
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gTm92IDIyLCAyMDIyLCBhdCAxMjowOSBQTSwgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4gd3JvdGU6DQoNCj4gISEgRXh0ZXJuYWwgRW1haWwNCj4gDQo+IE9uIFR1ZSwgTm92IDIyLCAy
MDIyLCBhdCAyMDo1MywgTmFkYXYgQW1pdCB3cm90ZToNCj4+IEZyb206IE5hZGF2IEFtaXQgPG5h
bWl0QHZtd2FyZS5jb20+DQo+PiANCj4+IEZ1bmN0aW9ucyB0aGF0IGFyZSBtYXJrZWQgYXMgImlu
bGluZSIgYXJlIGN1cnJlbnRseSBhbHNvIG5vdCB0cmFjYWJsZS4NCj4+IEFwcGFyZW50bHksIHRo
aXMgaGFzIGJlZW4gZG9uZSB0byBwcmV2ZW50IGRpZmZlcmVuY2VzIGJldHdlZW4gZGlmZmVyZW50
DQo+PiBjb25maWdzIHRoYXQgY2F1c2VkIGRpZmZlcmVudCBmdW5jdGlvbnMgdG8gYmUgdHJhY2Fi
bGUgb24gZGlmZmVyZW50DQo+PiBwbGF0Zm9ybXMuDQo+PiANCj4+IEFueWhvdywgdGhpcyBjb25z
aWRlcmF0aW9uIGlzIG5vdCB2ZXJ5IHN0cm9uZywgYW5kIHR5aW5nICJpbmxpbmUiIGFuZA0KPj4g
Im5vdHJhY2UiIGRvZXMgbm90IHNlZW0gdmVyeSBiZW5lZmljaWFsLiBUaGUgImlubGluZSIga2V5
d29yZCBpcyBqdXN0IGENCj4+IGhpbnQsIGFuZCBtYW55IGZ1bmN0aW9ucyBhcmUgY3VycmVudGx5
IG5vdCB0cmFjYWJsZSBkdWUgdG8gdGhpcyByZWFzb24uDQo+IA0KPiBUaGUgb3JpZ2luYWwgcmVh
c29uIHdhcyBsaXN0ZWQgaW4gOTNiM2NjYTFjY2QzICgiZnRyYWNlOiBNYWtlIGFsbA0KPiBpbmxp
bmUgdGFncyBhbHNvIGluY2x1ZGUgbm90cmFjZSIpLCB3aGljaCBkZXNjcmliZXMNCj4gDQo+ICAg
IENvbW1pdCA1OTYzZTMxN2IxZTlkMmEgKCJmdHJhY2UveDg2OiBEbyBub3QgY2hhbmdlIHN0YWNr
cyBpbiBERUJVRyB3aGVuDQo+ICAgIGNhbGxpbmcgbG9ja2RlcCIpIHByZXZlbnRlZCBsb2NrZGVw
IGNhbGxzIGZyb20gdGhlIGludDMgYnJlYWtwb2ludCBoYW5kbGVyDQo+ICAgIGZyb20gcmVzZXRp
bmcgdGhlIHN0YWNrIGlmIGEgZnVuY3Rpb24gdGhhdCB3YXMgY2FsbGVkIHdhcyBpbiB0aGUgcHJv
Y2Vzcw0KPiAgICBvZiBiZWluZyBjb252ZXJ0ZWQgZm9yIHRyYWNpbmcgYW5kIGhhZCBhIGJyZWFr
cG9pbnQgb24gaXQuIFRoZSBpZGVhIGlzLA0KPiAgICBiZWZvcmUgY2FsbGluZyB0aGUgbG9ja2Rl
cCBjb2RlLCBkbyBhIGxvYWRfaWR0KCkgdG8gdGhlIHNwZWNpYWwgSURUIHRoYXQNCj4gICAga2Vw
dCB0aGUgYnJlYWtwb2ludCBzdGFjayBmcm9tIHJlc2V0aW5nLiBUaGlzIHdvcmtlZCB3ZWxsIGFz
IGEgcXVpY2sgZml4DQo+ICAgIGZvciB0aGlzIGtlcm5lbCByZWxlYXNlLCB1bnRpbCBhIGNlcnRh
aW4gY29uZmlnIGNhdXNlZCBhIGxvY2t1cCBpbiB0aGUNCj4gICAgZnVuY3Rpb24gdHJhY2VyIHN0
YXJ0IHVwIHRlc3RzLg0KPiANCj4gICAgSW52ZXN0aWdhdGluZyBpdCwgSSBmb3VuZCB0aGF0IHRo
ZSBsb2FkX2lkdCB0aGF0IHdhcyB1c2VkIHRvIHByZXZlbnQNCj4gICAgdGhlIGludDMgZnJvbSBj
aGFuZ2luZyBzdGFja3Mgd2FzIGl0c2VsZiBiZWluZyB0cmFjZWQhDQo+IA0KPiBhbmQgdGhpcyBz
b3VuZHMgbGlrZSBhIG11Y2ggc3Ryb25nZXIgcmVhc29uIHRoYW4gd2hhdCB5b3UgZGVzY3JpYmUs
DQo+IGFuZCBJIHdvdWxkIGV4cGVjdCB5b3VyIGNoYW5nZSB0byBjYXVzZSByZWdyZXNzaW9ucyBp
biBzaW1pbGFyIHBsYWNlcy4NCg0KSSBoYWQgbm8gaW50ZW50aW9uIG9mIG1pc3JlcHJlc2VudGlu
Zy4gVGhhdCB3YXMgbXkgdW5kZXJzdGFuZGluZyBmcm9tIG15DQpwcmV2aW91cyBkaXNjdXNzaW9u
IHdpdGggU3RldmVuLg0KDQpJIGFzc3VtZSB0aGF0IHRoaXMgcGF0Y2ggbWlnaHQgY2F1c2Ugc29t
ZSByZWdyZXNzaW9ucy4gVGhlIGZpcnN0IHBhdGNoIGluDQp0aGlzIHNlcmllcyB3YXMgaW50ZW5k
ZWQgdG8gcHJldmVudHMgc29tZSByZWdyZXNzaW9ucyB0aGF0IEkgZW5jb3VudGVyZWQuDQpUaGlz
IHBhdGNoIGFsc28gbWFya3MgYSBmdW5jdGlvbiB0aGF0IHdhcyBtaXNzaW5nIOKAnG5vdHJhY2Xi
gJ0gYmVmb3JlLiBBbmQgSQ0KZGlkIGdldCBrZXJuZWwgaGFuZ3MgZHVlIHRvIHRoZSBtaXNzaW5n
IOKAnG5vdHJhY2XigJ0uDQoNCkFueWhvdywgSSBiZWxpZXZlIHRoYXQgdGhlIGFsdGVybmF0aXZl
IC0gb2YgbGVhdmluZyB0aGluZ3MgYXMgdGhleSBhcmUNCijigJxpbmxpbmXigJ0tPuKAnW5vdHJh
Y2XigJ0pIC0gaXMgZXZlbiB3b3JzZS4gT2J2aW91c2x5IGl0IHByZXZlbnRzIHByb3BlciB0cmFj
aW5nLA0KYXMgdGhlcmUgYXJlIGV2ZW4gc3lzdGVtIGNhbGxzIHRoYXQgdXNlIGlubGluZSwgZm9y
IGluc3RhbmNlDQpfX2RvX3N5c19wcm9jZXNzX21hZHZpc2UoKSBhbmQgX19kb19zeXNfbXJlbWFw
KCkuDQoNCkJ1dCBtb3JlIGltcG9ydGFudGx5LCB0aGUgY3VycmVudCDigJxpbmxpbmXigJ0tPuKA
nW5vdHJhY2XigJ0gc29sdXRpb24ganVzdCBwYXBlcnMNCm92ZXIgbWlzc2luZyDigJxub3RyYWNl
4oCdIGFubm90YXRpb25zLiBBbnlvbmUgY2FuIHJlbW92ZSB0aGUg4oCcaW5saW5l4oCdIGF0IGFu
eQ0KZ2l2ZW4gbW9tZW50IHNpbmNlIHRoZXJlIGlzIG5vIGRpcmVjdCAob3IgaW5kaXJlY3QpIHJl
bGF0aW9uc2hpcCBiZXR3ZWVuDQrigJxpbmxpbmXigJ0gYW5kIOKAnG5vdHJhY2XigJ0uIEl0IHNl
ZW1zIHRvIG1lIGFsbCByYW5kb20gYW5kIGJvdW5kIHRvIGZhaWwgYXQgc29tZQ0KcG9pbnQuDQoN
Cj4gSXQncyBwb3NzaWJsZSB0aGF0IHRoZSByaWdodCBhbnN3ZXIgaXMgdGhhdCB0aGUgYWZmZWN0
ZWQgZnVuY3Rpb25zDQo+IHNob3VsZCBiZSBtYXJrZWQgYXMgX19hbHdheXNfaW5saW5lLg0KDQpJ
IHRoaW5rIHRoYXQgaXQgaXMgcHJvYmFibHkgYmV0dGVyIHRvIG1hcmsgdGhlbSBhcyBub3RyYWNl
LiBQZW9wbGUgbWlnaHQNCnJlbW92ZSBfX2Fsd2F5c19pbmxpbmUuIElmIHdlIHdhbnQgdHdvIHZl
cnNpb25zIC0gb25lIHRyYWNlYWJsZSBhbmQgb25lIG5vdA0KdHJhY2VhYmxlIC0gd2UgY2FuIGFs
c28gZG8gdGhhdC4gQnV0IEkgYW0gbm90IHN1cmUgaG93IG1hbnkgcGVvcGxlIGFyZSBhd2FyZQ0K
b2YgdGhlIHJlbGF0aW9uc2hpcHMgYmV0d2VlbiBpbmxpbmUvX19hbHdheXNfaW5saW5lIGFuZCB0
cmFjaW5nLg0KDQo=
