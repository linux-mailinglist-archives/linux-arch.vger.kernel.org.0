Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DBD64B067
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 08:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiLMH35 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 02:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbiLMH3z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 02:29:55 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2040.outbound.protection.outlook.com [40.107.12.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70BF1A804;
        Mon, 12 Dec 2022 23:29:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXPe17iqcxzBk8FFauCRd/Wo/pexBuqw/+ek/Gyo0MziqPk5rJtA1Wv7myWDSGxDdrbsF4uADZ0+kzgvDRRQAPceetMLcUnxwdLUzOpiWuWrp9E3s4HWNF0Dyx2sdbwQ31ZAf0u5IWyRw9amb/kMwjpeFj0LCU4pkdlmRgUNTDeKT7jjTlTuZrZJrl4wJsbUnVWgcB+8FsDy9q5zD9sOHukOe0vsJWLUXK1/Ki/zkVY0sOBA8qSqQ++RuYrevdGnPjzTpaS61ZOceY+LyQsUI53yQyCIeGlhG1hRsCbgg2Mlc4yUZiCiBPwt2V56bs3J5poAO4dqnsXgQtmz5KWlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lwTymY4FgaNaJBs4HjjqwQ+NZ/XQr+B6URCQKmN8Gg=;
 b=RQkw9oXam+N4SOX8dflLlimZ80IOm6PRDJcIGTzAFeRCA0ZqL6K/42x3HsP0KSXYk5Cke/7ZX/imcfrCdTVOskylZsoQBfSR1ASAfOFCNMXOSJrw6d75YA0NqI18hUb85Zo88vUL+c2JUP2InE6c55VTEvyZpXhVEowacroEOopDOf7+vC4ra7fxidzvRzb11Z+2BU6A/D9Ft6G791IbT6TaipKhtjrCe7p0+Tzj9JYTRJEVVU9QDbab/LojwxOyaHM7E3bmY4Fomoj7FqFiV0IlhPPZSGOO0LgKdPzyTrVFZ7DuPH3ak9oLReubLkK0HhugrN5L0UJsuv7LB/d2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lwTymY4FgaNaJBs4HjjqwQ+NZ/XQr+B6URCQKmN8Gg=;
 b=gD0KM3gw9On1MqJ7mZFCeIkPEBfvbcbZT+HlVkuVZVhv5AXIvPmx8BLd7djNmG3cLcO8W613d82WrbAkEal65baHXx3fDC9jvk8TaxeN3hj/hpKaPUcPLVV7yXMXCIQGCz7ynL6qLLgjMer+lnNqE+NQ9nHXs3Ke3oR7Y5oABoWy/T6fCvNYj6aq6tNQUtZeiGtUkcQk40jCfoHOtTsZKlmgFhAo8O2MptBNBl458l0oIQVy8mwr8LPhHXcUm6ZcsZnxXsrs7HnmyWp/I3fIo0ZPnmMdXIN4CYio2eeR1xq9MNtAxusUxcYuLkkHKeF/wUbZ3bOnHYC4Hj1jNbR/Bw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2048.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Tue, 13 Dec
 2022 07:29:50 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%9]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 07:29:50 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Jeanson <mjeanson@efficios.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
Subject: Re: [RFC PATCH] Syscall tracing on PPC64_ELF_ABI_V1 without
 KALLSYMS_ALL
Thread-Topic: [RFC PATCH] Syscall tracing on PPC64_ELF_ABI_V1 without
 KALLSYMS_ALL
Thread-Index: AQHZDm/UBtWhlvS25UGRWg8dV8YpkK5rbH2A
Date:   Tue, 13 Dec 2022 07:29:50 +0000
Message-ID: <39c53bd1-432f-15f6-4cbd-b8551fc261cf@csgroup.eu>
References: <20221212212159.3435046-1-mjeanson@efficios.com>
In-Reply-To: <20221212212159.3435046-1-mjeanson@efficios.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB2048:EE_
x-ms-office365-filtering-correlation-id: a2cb3caf-e66e-4517-257a-08dadcdbd202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A1cvJSstesvowLSJKwKpWgDg2Q8v4AJzdPktK2lsqEYZYxHQL8kglsdWx0ev4ED5wjynLX1FaW/Ty+GmBJUlVEKVW69tCBAxLdVYF59IiQz+WhN/l6BmLN+td9hcdQXNQI6jyIS9H/z1LeOhb5qTa5yTi5y5gW5EnMro7cgmT+1jmtqPagwDvBDsSvWH5DbWm1n/b+geytleK3zCH9pwA/ojzbdf47wo4z4zw7IWzUH8mMniW6elbGtQFU8Ki/wrscYD2yLWHNWZZT3tr1iMxgiD2HWnjYkWOyUn/TMV5P6DzE6plwniIj9q6/0D3T3IEIwWhOjaRyIKLQm5IijFBe5ZXhbOcgblyXkGCm2dczV4px7JeFJ7J3uEN6XC6AI2IUdE7VliBZ7fi1C5BEzpNKghvfbqu1Cjy+/rhjivdscwdg9N4t/V11P45j9OD/tmZhRP6vet3kzwhryh4UIiXN4PjIi3JYVl2T//CFpPJ/2eYnHDC4/ktNzSGGvH2ZxQ8Eyr0H6YmSYmKJ1D3u2vXn+xbVktJQQzxzqj1DYhmY+op34HiwId2hsE9dHhjZRIO6x7qFsPEdXYX3Pv6TjMyY3HSPgzFB8lNplGUM/rVWVN/VrAMg5oClnqjzqn/bWMERU7neOEk1gtsb8LZkpZTOsAQumY5b15G5LZ9Y7W6tk0ssPGZDt1sThv9bat8WvuQNrpCWhzrSLzvNXfdzlyPZvLKzn3KLSAih1sp30pW62OajVgyvmXlHjEBlNezpzmp/l3+dmF8nnFXO0XUWb/FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(366004)(39850400004)(451199015)(38100700002)(122000001)(2906002)(4326008)(86362001)(31696002)(66556008)(66946007)(316002)(66446008)(54906003)(91956017)(38070700005)(76116006)(64756008)(8676002)(41300700001)(110136005)(66476007)(44832011)(2616005)(5660300002)(7416002)(8936002)(478600001)(186003)(71200400001)(6512007)(26005)(6506007)(31686004)(6486002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MldRdFVML3UrRlZuUno2NnlaUTNEM25neEhLeHJFM3VGS2FObHZ2eWF4ajVK?=
 =?utf-8?B?blpzV2tlTmN0MG5sZ1QyL3lmSzhZWFFUY29UUnpocVp1bXljbzN1VElqU1RI?=
 =?utf-8?B?NzNUcmRlK2RSQmloZGdwbzlkV0FFaFk0dld6TGpBNmtCQnVYZE4yeG5DaVdy?=
 =?utf-8?B?MS84cjliT0hWZjJiM2FXdVE4ZUlVL1ByaUtXS1hSVU80THl0OFNBcTRBRVRC?=
 =?utf-8?B?Z2FJQnd0SnhiTnZrL3NGeEl0bnBhY3d3aHR5aVZVSFZsZExTcTg4eWJGd1lz?=
 =?utf-8?B?dzVBZHJzVzhKenBXNmNnTU5qeHhWa05OM2Znc1docHFKL2kxdmNlck1iSk5Y?=
 =?utf-8?B?ZVlxZjdlblFST1FvYitZK0p3dy8waGFYOUxxMzVQVERxaEFwVE92M3d1UHpO?=
 =?utf-8?B?WHZRQnZmZitNenluVERpWUFjMUhvR3FKZmZkeFYraHozRDlUY2NzYlRqa0ZI?=
 =?utf-8?B?cVByRTJjd1EyOHFWeEk1L0pzOTlsOGkxdG1ycWJQQzdwSFQ3LzhxcnpjMmlx?=
 =?utf-8?B?NUVKMUowTXJTZ1p2RVdMRFNrcEFxN3RFNWl3b1ZqTU44Y25IanZ4VE45T2xX?=
 =?utf-8?B?WFdueENaRHhsRmtJQzMwTkdyTWhuc2l5TFRjN0llN0tLTXpBczJVdEpqbFl1?=
 =?utf-8?B?UjNCc2FuZGI5Vzg3WDB6NEFZMnUySlIrRy9iWTRTL3IzOVJDWHUzcml0REdU?=
 =?utf-8?B?WEhJV2ZjK3l6NGFTLytQY0NCZWlPVEJ5TDJDZ1lQL3VnMFg3akZsTXZCOTFU?=
 =?utf-8?B?VXJxQUM3eFljZG5CMllVUGNPSGpCeDdFdGQ3UCtBQThwVFczNjFGTXFuZnlU?=
 =?utf-8?B?ams1ZG1BYVJRK2VLdXArU3BaV1FnVlBidmp4ZjFmTkwzTVRrSkdLMW9CRWNr?=
 =?utf-8?B?QmZFdEpHb0t6Z0cyTzlFcUpRb2Y1VEFDODBuWXNWZkJhTVVSMXZOU01TSCty?=
 =?utf-8?B?dGRMKytPWHNwdldaeE1xa3RTQ3RlQ0JTYThBbkxxaDdpdTZHNk9JZFg5SWpO?=
 =?utf-8?B?K05RZGdoK2VOT09DY1M5NHpwVVlZTlYyTUhpV0RwelhYYkkyTzVPZnY3UUdp?=
 =?utf-8?B?ZVRUK0tmMVh4K1FRb3BlL0MycTFPZ00wUzFnK2g1VEplelQ0TjFoclQ5UHps?=
 =?utf-8?B?Smd4RFZCZlk2bEh2VGw0QXVUalFvaUV5K09mbHdMTjVJU20wR1dweEk0bmpo?=
 =?utf-8?B?c2wrQklEdTFHR3RBb2t0LzFvZ2RReGFITkNBMmlJR3dUbHMrU0ZtNlN2OVBH?=
 =?utf-8?B?Mld1Q2M0LzdMaGtVM1plb2dmWFdyV1A2YU1pZStJV1hCSjhjMDFJSG5Bc3Zj?=
 =?utf-8?B?UldWRDhWa3FQMTNzdjR0V2c3SDlWcTl0YjQ5MzZvZTZscnpGWUVweWtlZy9t?=
 =?utf-8?B?T1RxY0haUUZzT3lFY1ZnVVcrZStHd1VvNUZWbE8vNVgxTVRXVGFBbkppbG5X?=
 =?utf-8?B?eUZsRlRuSmIrUGVoL1ptWm54L28yRkxXNTFCU2dmMlQxY0F5THZLaEp1c0Y4?=
 =?utf-8?B?eG9WN3EzK3Vkc1lJM21RWVlxL1k3RnR5ellZWXRkL0lUUmxLUVd2Ukw4dmlY?=
 =?utf-8?B?aUNBMzYwaGNOYlNIdWlabWgrTGpHeG53UXdxUFg5SzgyRCsvUGtyWXVHakFD?=
 =?utf-8?B?SmhRWkp1aFVCQlovN3ZnajFpVHlBSjNDTHhHSUV3UFRSd3VvZ05FSU11UGZa?=
 =?utf-8?B?c1g3bXFDdE9CUWZaRk1YZEMyT0kwYXFsODAwUm1JMTl0eTVJS3pFTDlKTzJI?=
 =?utf-8?B?Qlh1elc3bitmWUl1R1Q4cVhrejBiTHdacXJhMEdzd0ZNRjBaUEI2SzBoaDJM?=
 =?utf-8?B?YnBkWmdLR1NGOGEyZCtKMXpRNlgrbEF1TU9XR3ZTdG9zbEhWSE51OUE1ZUhH?=
 =?utf-8?B?R2xjNi9qY3FZUmlZSWo1ZCt5OExDa095NHBTU2lmbEN4ZFd3c1Y3RXUrY2ll?=
 =?utf-8?B?cmFZNEMxMFZwWTVnL2xiYVVNamxOc3hiVU9nRXpoeHVKVTNXUTEyckVPUTlu?=
 =?utf-8?B?SEJBbnJER2ZNMUdha004UUhOSHlZL3ZOd3U4RU13bGVmK1dva2l1SWFwRS9K?=
 =?utf-8?B?clJLRytXZCswdEZRbTcvMTRWOGtTSEI3dlA1bGZSQ0Z3VHRRU0dXRHJMWTFl?=
 =?utf-8?B?QzlNR0pGN0hENndEUFRKSVpIbzhSekJEVWp6a3g3UlN2T0JUNFlOMjhWekdF?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0703909A6910204C967AE69FA5A968BF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cb3caf-e66e-4517-257a-08dadcdbd202
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 07:29:50.5494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgdFUj7EusPXQzJwMT1mSWI7KZt4JP3vsSrQuRvWp9kTSO6t9iyYeIaR+mwMa9qB11viS2KTKXaBsCsE5W/tv5lmRB+oVAQtUZ2SosGV2Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2048
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

VGhlIGNoYW5nZXMgYXJlIGFic29sdXRlbHkgbm90IHNwZWNpZmljIHRvIHBvd2VycGMuIFlvdSBz
aG91bGQgYWRqdXN0IA0KdGhlIHN1YmplY3QgYWNjb3JkaW5nbHksIGFuZCBjb3B5IGxpbnV4LWFy
Y2ggYW5kIHRyYWNpbmcgYW5kIHByb2JhYmx5IA0KYWxzbyBpYTY0IGFuZCBwYXJpc2MuDQoNCkxl
IDEyLzEyLzIwMjIgw6AgMjI6MjEsIE1pY2hhZWwgSmVhbnNvbiBhIMOpY3JpdMKgOg0KPiBJbiBh
ZDA1MGQyMzkwZmNjYjIyYWEzZTZmNjVlMTE3NTdjZTdhNWE3Y2E1IHdlIGZpeGVkIGZ0cmFjZSBz
eXNjYWxsDQo+IHRyYWNpbmcgb24gUFBDNjRfRUxGX0FCSV9WMSBieSBsb29raW5nIGZvciB0aGUg
bm9uLWRvdCBwcmVmaXhlZCBzeW1ib2wNCj4gb2YgYSBzeXNjYWxsLg0KDQpTaG91bGQgYmUgd3Jp
dHRlbiBhczoNCg0KQ29tbWl0IGFkMDUwZDIzOTBmYyAoInBvd2VycGMvZnRyYWNlOiBmaXggc3lz
Y2FsbCB0cmFjaW5nIG9uIA0KUFBDNjRfRUxGX0FCSV9WMSIpIGZpeGVkIC4uLi4NCg0KDQo+IA0K
PiBGdHJhY2UgdXNlcyBrYWxsc3ltcyB0byBsb2NhdGUgc3lzY2FsbCBzeW1ib2xzIGFuZCB0aG9z
ZSBub24tZG90DQo+IHByZWZpeGVkIHN5bWJvbHMgcmVzaWRlIGluIGEgc2VwYXJhdGUgJy5vcGQn
IHNlY3Rpb24gd2hpY2ggaXMgbm90DQo+IGluY2x1ZGVkIGJ5IGthbGxzeW1zLg0KPiANCj4gU28g
d2UgZWl0aGVyIG5lZWQgdG8gaGF2ZSBGVFJBQ0VfU1lTQ0FMTFMgc2VsZWN0IEtBTExTWU1TX0FM
TCBvbg0KPiBQUEM2NF9FTEZfQUJJX1YxIG9yIGFkZCB0aGUgJy5vcGQnIHNlY3Rpb24gc3ltYm9s
cyB0byBrYWxsc3ltcy4NCj4gDQo+IFRoaXMgcGF0Y2ggZG9lcyB0aGUgbWluaW11bSB0byBhY2hp
ZXZlIHRoZSBsYXR0ZXIsIGl0J3MgdGVzdGVkIG9uIGENCj4gY29yZW5ldDY0X3NtcF9kZWZjb25m
aWcgd2l0aCBLQUxMU1lNU19BTEwgdHVybmVkIG9mZi4NCj4gDQo+IEknbSB1bnN1cmUgd2hpY2gg
b2YgdGhlIGFsdGVybmF0aXZlcyB3b3VsZCBiZSBiZXR0ZXIuDQo+IA0KPiAtLS0NCj4gSW4gJ2tl
cm5lbC9tb2R1bGUva2FsbHN5bXMuYycgdGhlICdpc19jb3JlX3N5bWJvbCcgZnVuY3Rpb24gbWln
aHQgYWxzbw0KPiByZXF1aXJlIHNvbWUgdHdlYWtpbmcgdG8gbWFrZSBhbGwgb3BkIHN5bWJvbHMg
YXZhaWxhYmxlIHRvIGthbGxzeW1zIGJ1dA0KPiB0aGF0IGRvZXNuJ3QgaW1wYWN0IGZ0cmFjZSBz
eXNjYWxsIHRyYWNpbmcuDQo+IA0KPiBDYzogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFu
LmlkLmF1Pg0KPiBDYzogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3Vw
LmV1Pg0KPiBDYzogTWF0aGlldSBEZXNub3llcnMgPG1hdGhpZXUuZGVzbm95ZXJzQGVmZmljaW9z
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBKZWFuc29uIDxtamVhbnNvbkBlZmZpY2lv
cy5jb20+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvYXNtLWdlbmVyaWMvc2VjdGlvbnMuaCB8IDE0ICsr
KysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9saW51eC9rYWxsc3ltcy5oICAgICAgIHwgIDMgKysr
DQo+ICAga2VybmVsL2thbGxzeW1zLmMgICAgICAgICAgICAgIHwgIDIgKysNCj4gICBzY3JpcHRz
L2thbGxzeW1zLmMgICAgICAgICAgICAgfCAgMSArDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9zZWN0
aW9ucy5oIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9zZWN0aW9ucy5oDQo+IGluZGV4IGRiMTNiYjYy
MGY1Mi4uMTQxMDU2Njk1N2U1IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL3Nl
Y3Rpb25zLmgNCj4gKysrIGIvaW5jbHVkZS9hc20tZ2VuZXJpYy9zZWN0aW9ucy5oDQo+IEBAIC0x
ODAsNiArMTgwLDIwIEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBpc19rZXJuZWxfcm9kYXRhKHVuc2ln
bmVkIGxvbmcgYWRkcikNCj4gICAJICAgICAgIGFkZHIgPCAodW5zaWduZWQgbG9uZylfX2VuZF9y
b2RhdGE7DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsgKiBpc19rZXJuZWxfb3BkIC0gY2hlY2tz
IGlmIHRoZSBwb2ludGVyIGFkZHJlc3MgaXMgbG9jYXRlZCBpbiB0aGUNCj4gKyAqICAgICAgICAg
ICAgICAgICAub3BkIHNlY3Rpb24NCj4gKyAqDQo+ICsgKiBAYWRkcjogYWRkcmVzcyB0byBjaGVj
aw0KPiArICoNCj4gKyAqIFJldHVybnM6IHRydWUgaWYgdGhlIGFkZHJlc3MgaXMgbG9jYXRlZCBp
biAub3BkLCBmYWxzZSBvdGhlcndpc2UuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBp
c19rZXJuZWxfb3BkKHVuc2lnbmVkIGxvbmcgYWRkcikNCj4gK3sNCg0KSSB3b3VsZCBhZGQgYSBj
aGVjayBvZiBDT05GSUdfSEFWRV9GVU5DVElPTl9ERVNDUklQVE9SUzoNCg0KCWlmICghSVNfRU5B
QkxFRChDT05GSUdfSEFWRV9GVU5DVElPTl9ERVNDUklQVE9SUykpDQoJCXJldHVybiBmYWxzZTsN
Cg0KPiArCXJldHVybiBhZGRyID49ICh1bnNpZ25lZCBsb25nKV9fc3RhcnRfb3BkICYmDQo+ICsJ
ICAgICAgIGFkZHIgPCAodW5zaWduZWQgbG9uZylfX2VuZF9vcGQ7DQo+ICt9DQo+ICsNCj4gICAv
KioNCj4gICAgKiBpc19rZXJuZWxfaW5pdHRleHQgLSBjaGVja3MgaWYgdGhlIHBvaW50ZXIgYWRk
cmVzcyBpcyBsb2NhdGVkIGluIHRoZQ0KPiAgICAqICAgICAgICAgICAgICAgICAgICAgIC5pbml0
LnRleHQgc2VjdGlvbg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rYWxsc3ltcy5oIGIv
aW5jbHVkZS9saW51eC9rYWxsc3ltcy5oDQo+IGluZGV4IDY0OWZhYWMzMWRkYi4uOWJmYjRkOGQ0
MWE1IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2thbGxzeW1zLmgNCj4gKysrIGIvaW5j
bHVkZS9saW51eC9rYWxsc3ltcy5oDQo+IEBAIC00Myw2ICs0Myw5IEBAIHN0YXRpYyBpbmxpbmUg
aW50IGlzX2tzeW1fYWRkcih1bnNpZ25lZCBsb25nIGFkZHIpDQo+ICAgCWlmIChJU19FTkFCTEVE
KENPTkZJR19LQUxMU1lNU19BTEwpKQ0KPiAgIAkJcmV0dXJuIGlzX2tlcm5lbChhZGRyKTsNCj4g
ICANCj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfSEFWRV9GVU5DVElPTl9ERVNDUklQVE9SUykp
DQo+ICsJCXJldHVybiBpc19rZXJuZWxfdGV4dChhZGRyKSB8fCBpc19rZXJuZWxfaW5pdHRleHQo
YWRkcikgfHwgaXNfa2VybmVsX29wZChhZGRyKTsNCj4gKw0KDQpXaXRoIHRoZSBjaGVjayBpbnNp
ZGUgaXNfa2VybmVsX29wZCgpLCB5b3UgY2FuIG1ha2UgaXQgc2ltcGxlcjoNCg0KCXJldHVybiBp
c19rZXJuZWxfdGV4dChhZGRyKSB8fCBpc19rZXJuZWxfaW5pdHRleHQoYWRkcikgfHwgDQppc19r
ZXJuZWxfb3BkKGFkZHIpOw0KDQo+ICAgCXJldHVybiBpc19rZXJuZWxfdGV4dChhZGRyKSB8fCBp
c19rZXJuZWxfaW5pdHRleHQoYWRkcik7DQo+ICAgfQ0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEva2Vy
bmVsL2thbGxzeW1zLmMgYi9rZXJuZWwva2FsbHN5bXMuYw0KPiBpbmRleCA2MGMyMGYzMDFhNmIu
LjAwOWIxY2EyMTYxOCAxMDA2NDQNCj4gLS0tIGEva2VybmVsL2thbGxzeW1zLmMNCj4gKysrIGIv
a2VybmVsL2thbGxzeW1zLmMNCj4gQEAgLTI4MSw2ICsyODEsOCBAQCBzdGF0aWMgdW5zaWduZWQg
bG9uZyBnZXRfc3ltYm9sX3Bvcyh1bnNpZ25lZCBsb25nIGFkZHIsDQo+ICAgCQkJc3ltYm9sX2Vu
ZCA9ICh1bnNpZ25lZCBsb25nKV9laW5pdHRleHQ7DQo+ICAgCQllbHNlIGlmIChJU19FTkFCTEVE
KENPTkZJR19LQUxMU1lNU19BTEwpKQ0KPiAgIAkJCXN5bWJvbF9lbmQgPSAodW5zaWduZWQgbG9u
ZylfZW5kOw0KPiArCQllbHNlIGlmIChJU19FTkFCTEVEKENPTkZJR19IQVZFX0ZVTkNUSU9OX0RF
U0NSSVBUT1JTKSAmJiBpc19rZXJuZWxfb3BkKGFkZHIpKQ0KPiArCQkJc3ltYm9sX2VuZCA9ICh1
bnNpZ25lZCBsb25nKV9fZW5kX29wZDsNCg0KU2FtZSwgd2l0aCB0aGUgY2hlY2sgaW5jbHVkZWQg
aW5zaWRlIGlzX2tlcm5lbF9vcGQoKSB5b3UgZG9uJ3QgbmVlZCB0aGUgDQpJU19FTkFCTEVEKENP
TkZJR19IQVZFX0ZVTkNUSU9OX0RFU0NSSVBUT1JTKSBoZXJlLg0KDQo+ICAgCQllbHNlDQo+ICAg
CQkJc3ltYm9sX2VuZCA9ICh1bnNpZ25lZCBsb25nKV9ldGV4dDsNCj4gICAJfQ0KPiBkaWZmIC0t
Z2l0IGEvc2NyaXB0cy9rYWxsc3ltcy5jIGIvc2NyaXB0cy9rYWxsc3ltcy5jDQo+IGluZGV4IDAz
ZmEwN2FkNDVkOS4uZGVjZjMxYzQ5N2Y1IDEwMDY0NA0KPiAtLS0gYS9zY3JpcHRzL2thbGxzeW1z
LmMNCj4gKysrIGIvc2NyaXB0cy9rYWxsc3ltcy5jDQo+IEBAIC02NCw2ICs2NCw3IEBAIHN0YXRp
YyB1bnNpZ25lZCBsb25nIGxvbmcgcmVsYXRpdmVfYmFzZTsNCj4gICBzdGF0aWMgc3RydWN0IGFk
ZHJfcmFuZ2UgdGV4dF9yYW5nZXNbXSA9IHsNCj4gICAJeyAiX3N0ZXh0IiwgICAgICJfZXRleHQi
ICAgICB9LA0KPiAgIAl7ICJfc2luaXR0ZXh0IiwgIl9laW5pdHRleHQiIH0sDQo+ICsJeyAiX19z
dGFydF9vcGQiLCAiX19lbmRfb3BkIiB9LA0KPiAgIH07DQo+ICAgI2RlZmluZSB0ZXh0X3Jhbmdl
X3RleHQgICAgICgmdGV4dF9yYW5nZXNbMF0pDQo+ICAgI2RlZmluZSB0ZXh0X3JhbmdlX2luaXR0
ZXh0ICgmdGV4dF9yYW5nZXNbMV0pDQo=
