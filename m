Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D355A5A66DE
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 17:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiH3PG2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiH3PG1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 11:06:27 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3AFF2C93;
        Tue, 30 Aug 2022 08:06:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgA6TMMexxOzn9VVDSQTyFmvEvxKFDCTBje8Ecq5O+76Ivd3Iqf5txZLrWun1l/apgWs5y729LYn3usYykmyxyBCdR/Opo1gxYZb3ctTP+v0XAt+7WkuUZRIpqHZjOH/zt3tBTMCJWSoRmX6JUvO4pWLVTZaPtJsMuhbe6mFpriMEj0hzxkI51yC/wIFZp2WfH5910Zav7yT641zj4ZMqIp8x2qSJLJ9HJXoJ4kIRdD9O5wk7ZTql/tPmIBaI8ZtXy16JHZ0hLDZU4bNLG+LHBmdEFs4xVG7VmG127lGWBtCN77jPLvprQAQFkrkZNX/S6jOPNEFsbg22mK/WnvVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lG4jdpTkHOvXzIgATS4yYyGV6Sr2KWeCVf2ozBr8EV8=;
 b=TSqfJRnouGJYYDImfMW/iufTe7cLANzWRFAAmvNN34WKDE2URKNQzjp/gjTodQAFS9621SYtlYK7fVLYw8Yyx+xEaiaY6+hRXXIDSp4/PjskHF5usNZa0eMl9WLd/zNXEf2XmM5CoK5W6TTIovGM7HmreBIiz3J+/GOgziLa0ObQLtI/QriFmrsSwrZF4cHiYlgRIlGC/wAr+zrkrHe8mxE+dbGcAHphFW/qE9StfDhqel/n/M7Vag4BGSeaQkS8zKCx4wr1YWyf9qfzGb2ISBMXfayEyJYJLinGYBapsSDsFB1+B6QgfgBNstPSwlJGX0o+XKN407GZpvx5gkn5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lG4jdpTkHOvXzIgATS4yYyGV6Sr2KWeCVf2ozBr8EV8=;
 b=Ej+wHolBpR7G4WaGUR2dKrAYon+mNf8xYx9t79IzOVyCf++eKYIDeCw2HmHmpTWjP9WDLknZUqtFRj+UkUuCwPouwSG3nQLWZDcAuEgQHRkZhHclB805KDfJRJ/teFoL4MB3WSs2wxcjfZ7v6zVifQ8aLxgnDqClw7hJiLkb6Ew+DVwNhLVUdXMDZaiWSj1S3NiFSveBVJlwfTNIIX6PWs5LdAppZbbNC2dM7ykO60z5bm4CUF32Y4wQjIznEtgywqcp+5d7XWZLk9Neo9KKVDdATaApSVp14pEAL7zGr0aXPHQQItIJKmpwngZOJFBDIifPWNqWGM0eh8tBGqNytw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2997.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 15:06:21 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 15:06:21 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alexander Potapenko <glider@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and
 put_user()
Thread-Topic: [PATCH v5 04/44] x86: asm: instrument usercopy in get_user() and
 put_user()
Thread-Index: AQHYuV2zgoiwrRRxuUOabTtvU9EmQ63HkWMA
Date:   Tue, 30 Aug 2022 15:06:21 +0000
Message-ID: <51077555-5341-cf53-78bb-842d2e39d1ec@csgroup.eu>
References: <20220826150807.723137-1-glider@google.com>
 <20220826150807.723137-5-glider@google.com>
In-Reply-To: <20220826150807.723137-5-glider@google.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33168c62-9f3d-4adc-6be3-08da8a99330f
x-ms-traffictypediagnostic: PR0P264MB2997:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hoIkqG7rA5cLucG4YnuCHFaKDCGOUXOfVaU0vAL6k7ajyoZ7NW6GvPt72Ss+/mWlFZESAl/KZNFI8Erjojo4uo+HtecgJqfUbGjLkptinGx5t0obDauP7M3WiK9Q7/mb7LjWrHjoF0AGSlpjORn0UdDoQEl4nNq8/qgW9Eopk2Iq7NgpYo6XAELKYeZSJDGqKg569ZPWtHZ/rPkII1IaYFieVyYCMVQheJXlQ6G6cpyutEUefhy7jnOxUIzZGuhuDnmW5VoBC/ObjE2ncFSfROQdrXCMpUTIt5SmK7aa6ZsSPq02mdo4WkcTI3KyOOl29r/Uyd6cKz3GgGNBEl3IJNO0sPHqqKyJ9zn3TLmRKrKrVhKq3shG1jqCNNhinA22NZxluAkn2Ylxzu1IoBAtK86ODzFXYa9DNT+boiYKGwTPQwlRhVGy8dsv1OffCcU3THrIIXVTS7mj5TkK4xI9QepzI94bStPj7hIe/O6sNDU8Z2wHht3GoodfZF9zkXNAMuXz5TMOl7ukIF/KhQdRFhw8/km9lIUNL/RiFESx7dTm3ONB90YO1FYK4hm45/nu+cJJEkYq/VnJ1e9YLkSeJ2hypPfkRTX0WfqSxoGht3gzQzXMWwOJ0E8djmWeUTfhxCSuI08vVeLU6lI4rV6JOndDk8peHITd3cf65JJCkBFmOJiJVNi8MkhHJLWlTw2LpjAk5aysyVXd0/RVZHXdHyubccX6JwkGRf9gTA3Q45U8kNzFQWKq6yRMEpRMPj3mJ4rTnpg2TWxfH8uom1v+h7kRhujZcRTuAagVmcTvQfzzWMk7ol0wVvSNHIqu/dZ95DocOmJO7eP0TyRTMMrxqNECTESRBj+KjDXa3HNP+zM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(39850400004)(376002)(6916009)(66556008)(83380400001)(36756003)(66946007)(31686004)(66446008)(64756008)(66476007)(66574015)(76116006)(966005)(316002)(478600001)(54906003)(4326008)(8676002)(6486002)(91956017)(2616005)(86362001)(7406005)(7416002)(5660300002)(26005)(41300700001)(2906002)(31696002)(71200400001)(186003)(6506007)(38070700005)(38100700002)(122000001)(8936002)(6512007)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTVMTjcrL1pta05HL2ZOaTNZRlgySEk5aTByUFhZQXZqcmo1VitJeGxhU0pm?=
 =?utf-8?B?ZllTSEVFVzdOYmVyU01BOEhjbHkxYUVBbEE0RFFtM2pac0RsQ0htdmlJdUl4?=
 =?utf-8?B?b1RKZFVQRms1V2lKcWtrekQwelBHOFVTR2tWd05EWEd6YjcwM05aWC8ybTdu?=
 =?utf-8?B?RUh0ZHIwdFBUeDdUTTJ0aDZCa1RkQTh0VTVNSU9vQndjOFpHcEVlUVV4dzVq?=
 =?utf-8?B?Y2RsdVFtYmlYS1E4U1NGVUhuOUlsZ2huQWtsb0FmUW9WQkF2eENnMUZGaUdL?=
 =?utf-8?B?cHZtZVkrMWlFTmZJb2NwaTZRMFFRQTdNVkovd0FvYWt1d21XaE1QLzRxdStq?=
 =?utf-8?B?NUYyS2ttb1I0dS9JUkVWVnFmbnlNNktLNVpoVE1obGhvbU4xeUowblExT00y?=
 =?utf-8?B?Y25yVEd5ZGRqTlduYjhVbUU2dDdVbU1aZmo3N3F5a3JKWWc4NldweCtSbmxh?=
 =?utf-8?B?UFN6SnY0VlV3SktoVFY0M0RvWndTZ2dFNUxTYk84eGlnZUNkaUJkUmMvUWFR?=
 =?utf-8?B?ckQrcWl6S0JFRTNPcVJFc2JPODd1KzUrZXByc09qYm15Q0lNdFBCNHdCWnpx?=
 =?utf-8?B?UVRBZHU5UENCaGFnVHFsSjJ4ZXIrQk1aYjdBdm1TdEdlUllNYkNCZTk4RFRy?=
 =?utf-8?B?amt1ejJ6eHdMRnd4MnB1WGtRT2FpdERrSFFtVUpsN1YwT29OemkwK0poSFcw?=
 =?utf-8?B?cjA5UXdBRnE1c0dpVVZVV2hJa1BXK1FndVcvcDBLVFFYdVdwY3dEZllxNFZi?=
 =?utf-8?B?NVVRQnlPZzVYbVZmMjYzZFlWaDYvVVpJYWNMS3BVM0dDT2tTWDlOcDRVZFFY?=
 =?utf-8?B?cVp4UEJ6NlVVbExYUmUxRnE4dEEwdThYc2R6bEVyMVJFMCtrTXNXVEMwR2cy?=
 =?utf-8?B?K1NmZTkza0h5a1UxZ3BjOVFKZC93SUVYcnh6QkpqcFU4Tk05am5lWE0vbDc2?=
 =?utf-8?B?WUZxWENHTEV1Q0toVXRZSVV6MlRUU2lhdEQ3b2pZSi9LL2FIblVnQU9WZThL?=
 =?utf-8?B?eWlRaUFuU2lCRkQrR1NCYXZsejI3N3cxdWM0UTR1dVNFUVJhdkpDSmdQK1I5?=
 =?utf-8?B?WENqRGY4aXJqd2QwOHJiWUVoKzU3V1U3cHZLUEUvUVoxejdjQVNlWjZsem54?=
 =?utf-8?B?Yk5IWTQ1RUFtclJQLzhmbitJMENIWDVjaUU3cTh6KzJVeUVUOW00emQ4cnhU?=
 =?utf-8?B?NlFMcEVRTnBuME9zbThoQ0M5QlR2KzZmc0tsZDVVMzNwblRTank2aUJpTHp4?=
 =?utf-8?B?bU9hRUcvdnVtTmd0QUF1YkJaMTV4UFdqSFpiWTA3MlpFMkk4bnlVL2hEekZY?=
 =?utf-8?B?aUpWd3BXWWt0YzVJUm5ydGdPNmpaSFNOUm1YZzd3QVVONzFjck93SnBxSWsr?=
 =?utf-8?B?TzJXRi8xSGFTTzdGM0dHclpwaWlKWGU5V1ZQQWlPZ0ZMekdldm9Da1dHdHND?=
 =?utf-8?B?UTY0V0lRRnEwMldYMkhJeE9xRXZFS3FYV2RKcldmaGt2N0ZFT1NweGREV1hi?=
 =?utf-8?B?cTNQdFN3ZDZHdEJGUy94VTk0T3hOcEhqRlBPbjJZWXpITzdpM1dBRFNPVjhC?=
 =?utf-8?B?bkhGRzcvMTJDYW1nTk0rUmVRcXNmcm5lZDh2QXQvb1pZbEhpS3dZcm4vVjY1?=
 =?utf-8?B?MXBpTXN3b2x0Wkp6bG1GMlZac3R1Q2lBWm5jVVg2Y3Q3VWtTaGRUK2NPd1Rr?=
 =?utf-8?B?aHJWMjlaRjNITVFTbHF6cWN3ZGo0YWE2Sm0rcEk0cjlNcVY3Vzh3U01qeGJ6?=
 =?utf-8?B?WW8zYXZ6NzdBTHRMaU1aNTAyQ0RNYzlRdEc0VEUzdGRENS9XM0NMaGVhTXVB?=
 =?utf-8?B?bmp0UjBVeHVSN3BWKzd2VVVGVnh0eDlIbHdHTUhPTEVsN1BOdElGaXd0Zzgx?=
 =?utf-8?B?Y3JDZVlNQnZGMmtVWXRaeTdZRE4xYi9IeDQ4VEt1NjdSMWl6Wi9JZjNNaXZF?=
 =?utf-8?B?bExXNXkzRWlKTVcrdjJCLzdKVHo1K3ZjZkcvTjk1WG5ZTEl4YmlEYWNaWGdy?=
 =?utf-8?B?aVpUUmthekY5LzRBM2VOVjREUUN5NGtrcHVwZFkyYlNVS1NEK09XNzR1K1dN?=
 =?utf-8?B?M1lYL2RvSU1BNWtyTFdCL0ducWg1VUd5eHlaRnVUMFpFcGtLNGRRMUgrK2pR?=
 =?utf-8?B?NjA2OEVkeHh1MUp0YXhDcHNZdXE4OXRHMU5HYzljM09SK1BiSEZ0eEgwbUVp?=
 =?utf-8?Q?cblbFMup+a0SVhTihtRwcVQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7940925FCCF9C84EA7C7B7718689F727@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 33168c62-9f3d-4adc-6be3-08da8a99330f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 15:06:21.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/fh1OLU/QWGZDmySwrDxSa293tuJ+Tj3/rit46M1SXWaxeYL/Wwxmdj+BKuY0upUWB1swpgtLPMbv573Bflpg2i9S82/9tNWcAhvRAcddk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2997
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI2LzA4LzIwMjIgw6AgMTc6MDcsIEFsZXhhbmRlciBQb3RhcGVua28gYSDDqWNyaXTC
oDoNCj4gVXNlIGhvb2tzIGZyb20gaW5zdHJ1bWVudGVkLmggdG8gbm90aWZ5IGJ1ZyBkZXRlY3Rp
b24gdG9vbHMgYWJvdXQNCj4gdXNlcmNvcHkgZXZlbnRzIGluIHZhcmlhdGlvbnMgb2YgZ2V0X3Vz
ZXIoKSBhbmQgcHV0X3VzZXIoKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBQb3Rh
cGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KPiAtLS0NCj4gdjU6DQo+ICAgLS0gaGFuZGxlIHB1
dF91c2VyKCksIG1ha2Ugc3VyZSB0byBub3QgZXZhbHVhdGUgcG9pbnRlci92YWx1ZSB0d2ljZQ0K
PiANCj4gTGluazogaHR0cHM6Ly9saW51eC1yZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9pZC9JYTlm
MTJiZmU1ODMyNjIzMjUwZTIwZjE4NTlmZGY1Y2M0ODVhMmZjZQ0KPiAtLS0NCj4gICBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmggfCAyMiArKysrKysrKysrKysrKystLS0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vdWFjY2Vzcy5oDQo+IGluZGV4IDkxM2U1OTNhM2I0NWYuLmMxYjg5ODI4OTllY2Eg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaA0KPiArKysgYi9h
cmNoL3g4Ni9pbmNsdWRlL2FzbS91YWNjZXNzLmgNCj4gQEAgLTUsNiArNSw3IEBADQo+ICAgICog
VXNlciBzcGFjZSBtZW1vcnkgYWNjZXNzIGZ1bmN0aW9ucw0KPiAgICAqLw0KPiAgICNpbmNsdWRl
IDxsaW51eC9jb21waWxlci5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2luc3RydW1lbnRlZC5oPg0K
PiAgICNpbmNsdWRlIDxsaW51eC9rYXNhbi1jaGVja3MuaD4NCj4gICAjaW5jbHVkZSA8bGludXgv
c3RyaW5nLmg+DQo+ICAgI2luY2x1ZGUgPGFzbS9hc20uaD4NCj4gQEAgLTEwMyw2ICsxMDQsNyBA
QCBleHRlcm4gaW50IF9fZ2V0X3VzZXJfYmFkKHZvaWQpOw0KPiAgIAkJICAgICA6ICI9YSIgKF9f
cmV0X2d1KSwgIj1yIiAoX192YWxfZ3UpLAkJXA0KPiAgIAkJCUFTTV9DQUxMX0NPTlNUUkFJTlQJ
CQkJXA0KPiAgIAkJICAgICA6ICIwIiAocHRyKSwgImkiIChzaXplb2YoKihwdHIpKSkpOwkJXA0K
PiArCWluc3RydW1lbnRfZ2V0X3VzZXIoX192YWxfZ3UpOwkJCQkJXA0KDQpXaGVyZSBpcyB0aGF0
IGluc3RydW1lbnRfZ2V0X3VzZXIoKSBkZWZpbmVkID8gSSBjYW4ndCBmaW5kIGl0IG5laXRoZXIg
aW4gDQp2Ni4wLXJjMyBub3IgaW4gbGludXgtbmV4dC4NCg0KPiAgIAkoeCkgPSAoX19mb3JjZSBf
X3R5cGVvZl9fKCoocHRyKSkpIF9fdmFsX2d1OwkJCVwNCj4gICAJX19idWlsdGluX2V4cGVjdChf
X3JldF9ndSwgMCk7CQkJCQlcDQo+ICAgfSkNCg0KQ2hyaXN0b3BoZQ==
