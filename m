Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99337601447
	for <lists+linux-arch@lfdr.de>; Mon, 17 Oct 2022 19:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJQRGg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJQRGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 13:06:34 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120083.outbound.protection.outlook.com [40.107.12.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E464DF3C;
        Mon, 17 Oct 2022 10:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AeR/vk+aAgU8fe5U3PDUU9vnwiD0+PWtduSUMiYMmh80oxzTogfRdfhh4cjfxd/jAf0B1ueeMzr1sGAB9cKHgQdNTZ4Bp1laqUYRrctnd/NCyPufpmx41uuY9rWjOR4Kk8Xonk3s1Xu81kFpP7VIfwRhWrMWxy8n3EodOzdW7woMaIE2EDGxdXUmc0/Kan+wfzzgbGb3FSfvh7wlMKSWmXrxuRpq75icWZpy7wKIkCdJeb6H+hWgcQc3B9uEvpTyY+s9wq6gt6rQnNHBKMY7Iw8J06Uuz7oF7yWNFnj/I08ym6YmS6CHcYJ03oE50Fp4C2xglBdSVrx6n1BobM1TQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsy4Wyc6I/Mb9vnFNdj3kb3FipyGVXEHyo0UuCT/ZM4=;
 b=EDp9zln3DtvTnyUyMyJWP3LG8MdYZoOVTen0n/PdrmguCVOJkY9PN49Qyb/PS080s7iQAzVr072IW+2jZu6O/CchjItN3X3FwffNsP8j907ZmLNa0sqpeUzvm+GrxyGttYyr32w0p4aM4ND3N2FTkw+6UmUdzc/3Qgu5fBrbkFxvguY503v4F1d9KjZdwoIfY8tKPgxzdTTNyShY0u/3A2JrX73adllQVS9etJaieQJ1sN8TYSn7QuFvpK05H+YpJZkYjq0F8jWo9zg8LPg827oJNGL4mrciW38OIK8cYkrY6t6MET4scN13sKGq6yO+/k3THB9xPR3BewiBAWI3uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsy4Wyc6I/Mb9vnFNdj3kb3FipyGVXEHyo0UuCT/ZM4=;
 b=otTsWqp4NWUAg9VcK3aS6TZ7GmXIDx/YIwt4rA+rHfmPLnmde9lwtUF47rlyZJzsQz1u43OsUaUrcScVsViZH/7flMdmmT13QeZJ7hB215JruOwr18Z8j0BUMEM2euUHI09VFXBKlz7+1KT+2JoPjk/ZeGFlHlONWiFVysLChRRky0uo4vuEfSqWilwdGPDG5HYHw5wNtf5gZwGs7+Sh8EJbdAhnpeq+tmurMVtxm9I6D3mPQ2S6bXlY5At1Cx+xmqQFj6vbigk0xw0BwjkozI734fqyyUhTm4CTyYIunePmME+M+vzKrnQdcmbskEmis0xcsNEVCjVhccMpYlGUFQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3185.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 17:06:29 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c854:380d:c901:45af%6]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 17:06:29 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "David.Laight@aculab.com" <David.Laight@aculab.com>,
        "shorne@gmail.com" <shorne@gmail.com>
Subject: Re: [RFC PATCH 0/8] mm: ioremap: Convert architectures to take
 GENERIC_IOREMAP way (Alternative)
Thread-Topic: [RFC PATCH 0/8] mm: ioremap: Convert architectures to take
 GENERIC_IOREMAP way (Alternative)
Thread-Index: AQHY3iLNYhDB80P9PUWaKHoLqXb2p64RxQgAgAEUPQA=
Date:   Mon, 17 Oct 2022 17:06:29 +0000
Message-ID: <fd7aa861-a85a-cc6d-df62-6e5e9a1b3149@csgroup.eu>
References: <cover.1665568707.git.christophe.leroy@csgroup.eu>
 <Y0yj0IDBVOFwCFuv@MiWiFi-R3L-srv>
In-Reply-To: <Y0yj0IDBVOFwCFuv@MiWiFi-R3L-srv>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3185:EE_
x-ms-office365-filtering-correlation-id: 7aa920d6-b5d1-4256-082b-08dab061ef31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /5NE2Xb54OxjJfQg2rcseOqbTvT5FHObwwV4YECKnae01yeBBXCvZCbujvPoOwnrh9fnUiuzfIDOr8jzTLBg5IEMpHjvqc8JbILYJc4X5Ic1J6D9zIyoNLrbgRwKzMygtBuGTmlr63HzhG1wLUpGRSualeiTTsdgomdK6vyb3Q+MyyF1TsWhkH/OkLf7SQudBOqmmlDVFNtJbjACvMVGU/OvGNYy04rF6p8kZv5Dw5mdHGERXWa8PvEvlf/tjydvJNr14g/ybtjhry8CsrqSgzAL+uL1tMXSaf8CBTYMOFZ07cM4vg+7sDnHkae8FTgDQKAmxvDThIcqrcj02FfL8fHA66W65NrFz6CHEzCHGRUjavWe7Epcxe1Uy42vdwGH81VEPK+g4N/rAIqnXJvVvZdAzpr6GJ9c9FBF7PLeYaxwkzvWIo4GDg/XA+oB86VKYP1RehTB5gCRkwVfhgB7GgFPreFg7KjGRhgGn3HmpZLU0b+02EM4A9Z6gH6SxksiniOlv/mfXQOYAogOkVnIt2FIUTJor3jlaZUDfN+rxzT5Q9G+Lw2Qa7r1ehod/Uq+LXzwQuqP/0j4VzmqG1lCaIqqJuzsq5oGH54k4+HlrtPLfK1p/vgAm40F7gT/rHHKdw9rQ9Cb/F7QcciSZ2X6UshYbHy0VruYg8OK/n0SnYWTOUOUhf1d/w4KvqGluV8+aFFMdaw1x4dlXQOIrz3glMb3U0c6ubsXZwEb9em+5bcNmNsY8KP0H6YwdB2+pnHCWVVJMd6a9Mutb9IkCoAFrQeA3CLs8fYtIttjnc18QgDIUiKfSp5Ix3McBvfWsPz6gH6S0ZW/+flLCa9RBo07KsBpi3nXMOrUPQWBx/1gi3ZXyQQ0A+2NsQPBc4gfJtO9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199015)(122000001)(38070700005)(31696002)(86362001)(41300700001)(36756003)(64756008)(6512007)(26005)(6506007)(8676002)(4326008)(66446008)(6916009)(66946007)(5660300002)(7416002)(44832011)(66476007)(8936002)(66556008)(91956017)(966005)(6486002)(71200400001)(478600001)(76116006)(316002)(54906003)(38100700002)(186003)(83380400001)(2616005)(2906002)(66574015)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGNXQS9xekFMTXlxbW5ta292b09JVTBiY2xVWW9TVDdGSXRPWUhaYWNLU3R1?=
 =?utf-8?B?UG44TE9vRUx0V1cxdEk2dGdJVXovc3Z4V3czb3RkdWJFR2VFZzJ0MnZVeDJs?=
 =?utf-8?B?SFZVWTlrT1J0dkdQSnNtUTBHRnMzTWUyZkUrYjg4RFo1QVdTUTlvcG9jWkN5?=
 =?utf-8?B?OG8zTFBoMUlJODFYb3p0WTV3NVdPMzhleXRoVm5ubWVUbkpXQ05HNk1BTzZ2?=
 =?utf-8?B?NlV6T1pMdjFGYjRqNElqT080ZlE1ZFJyQlZpeENiREdUWTdhL0JLMENUV3lq?=
 =?utf-8?B?R2h2UlZmdmU3MldOa0NFTUxVV0hMZXVVKzloRHJYaVFJWHhDUHBmWUx4eFhm?=
 =?utf-8?B?T1FLUzhiTm5KRm05Vjhqd0p0MnRLbGRVMXVYNnQrQjB5UHBOdThsOUo5Nmlq?=
 =?utf-8?B?MEY3Q0NadW1tZTMrajVrVHBrMjFEZUd5Q1lKa2l3bHFXZWh2M08wUkoxRVYx?=
 =?utf-8?B?dW9QNTVYdjh5U0F3MDduYXRvK1RhcVRmWFUvK1p1NEswdmlaMUVGcE1vV1Uw?=
 =?utf-8?B?aDhONm5hQ3drSHlJYm56RjFjdFZrSnBHYjVLSlpLOG5QeWFwN1FFZnhvc2R2?=
 =?utf-8?B?L1RTSFp3NmVSNGR0cXg4ajB2d043VWFoSTFTOTN0ZXZxODdFRkpIRU5iSTZF?=
 =?utf-8?B?eFMzN0dZdkJ6V1hSN2M5RFcvMFVGRVpXcVUzV0pNTDhCVU5xYjdSUXBZQ0VF?=
 =?utf-8?B?QmFmS2pkTkNGV0pzQksyVG5NVkl3TXVxdUtVbU1QMmlmbmcveENzaStPVGlH?=
 =?utf-8?B?SzZGR0lESEc3Qms3Y1JENmgyUDdSeDhCTkliYnlOalN1RVFXdUlHdG4vSHVN?=
 =?utf-8?B?c1V5VmhZT2d1d2hOWTA3S3E3VjZjd0t4WVVxR29oNWxVYVRiU240WEdTd3Js?=
 =?utf-8?B?WXVpcTdWSHJFcldrN1lsbFNGWkxKcWJBNWtOMDlTWDE1YWpNc29HVG50YWYv?=
 =?utf-8?B?M0x0TUFtcVduTUVQL3JxajdkWnAxd05jMFVXa3dydUp0UzVETE9EYUgzbEVo?=
 =?utf-8?B?bGhuS2VhNGNLOVQrY3RxQ0RqOVh1N2xvREdNU0o1VTh3OTFQdFdaZzZFWlZq?=
 =?utf-8?B?empJYXZKcVJJT0FHWEpJZU9jREpBKzl0MnN3bzFVK3oyaFVkc05kbjdrcSt2?=
 =?utf-8?B?VEdYNHFDcFl1a0w5YjZ5K0lmVkNIRStyYkVJeHgrQ1NxSXIrdmN6NitwbVVu?=
 =?utf-8?B?RzQ0V2pzUGlOZFl1cGFlYmQ5V3BHTk55NXhMMXExSnRZVkM2V29ocTRhSk4r?=
 =?utf-8?B?Nmw3MEhicy9uRjlIdnNZVkR2bjltWTh4MGdrWTcyc0xrTTdDMjZPVEsxWXgz?=
 =?utf-8?B?OXprVlFVbWtvMGRNRmJPbkk3V2xidkMvZjdpV2FGTlRSYUpVeHRjSWd1aCtw?=
 =?utf-8?B?MGZUY0gvZUFnM1RabXVuaHROTFB6cHZUTXkzOTZYcytMMWxGeGlYbm9IazJE?=
 =?utf-8?B?bHNKa3ZVK3BLMTBaYXZLNXdsS2RmdlQ5dzZrekZsZGVIa2JGK1lPMHg2S2Vx?=
 =?utf-8?B?MDEzTlF4eHZjZXF5K01peDduVFZSRHd4dDdjYlEzNnRpU1p2T0t3c243NlhT?=
 =?utf-8?B?TlZLSUYxbGkzQ2oxRHpRa2tQS1hSMlBEZFhqcGRoSDJYWjdQRnowcmJMYnY0?=
 =?utf-8?B?bVFtaHpYMmJvTytQeXZBYkJOdjA1OUhrR0dmbFRhZTRjcDFFenFhU2xsT2pI?=
 =?utf-8?B?dmVMVHJJR3pKUUlnVW5OY3UxVzJvNmliTHZRd0IweW5aU1NrclRidWlZTTRh?=
 =?utf-8?B?ZmphbGZWc0Y1bkI1MlFwS0hFQWhQbSt0SVh0ajYzc2VzbEFZTGNEckR5V2xK?=
 =?utf-8?B?d3ZKd25jaUR2SGRKcG5nNytOZEc0K2lzME5HMnB0MHBxd1MvU3gyZXhUOHV2?=
 =?utf-8?B?cThmdHpHdG50MDU5ZG4vbUZ4UzBlOWFNT2ZiUkJrUGZzSDhLS1JpZnAvKzZW?=
 =?utf-8?B?ZDdMSHpoOWdEMnVySysrLys4RjY0bCt2K1hCSEdkUjg3cDdIaXljSFBFYkI3?=
 =?utf-8?B?NXpFNWkzWmdpc3NkL2YxNkNYNXZLT2wwL0R0R0ZEdFRxS2tXQmdmMG50WUY1?=
 =?utf-8?B?dzJWWlZaSVFEQnQ1NzZCalVKd3Q4c2k4MEtzczlGWk9STkZBVFdacE0wRU16?=
 =?utf-8?B?Qyt6RXZMblh6YWJUZUdiOGorTkptYjFsZ2hZaHY4UVdMNlQxYWc0eE1LdWV4?=
 =?utf-8?Q?qv2lkryb5XrCE5I5ybw3Kq4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C27F4511B790904B8ED0A15780F14EBE@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa920d6-b5d1-4256-082b-08dab061ef31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 17:06:29.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QuItDCDsHg+GjchaB7FlcQIsdWnqQL/dC2DPfFuvJwDDJFSTRz0hNIztJxQwEqeW9OhvJd4URouw8HdgwK+w51jbW7qmts4lYBeZHM1+mww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgQmFvcXVhbiwNCg0KTGUgMTcvMTAvMjAyMiDDoCAwMjozNywgQmFvcXVhbiBIZSBhIMOpY3Jp
dMKgOg0KPiBIaSBDaHJpc3RvcGhlLA0KPiANCj4gT24gMTAvMTIvMjIgYXQgMTI6MDlwbSwgQ2hy
aXN0b3BoZSBMZXJveSB3cm90ZToNCj4+IEZyb206DQo+Pg0KPj4gQXMgcHJvcG9zZWQgaW4gdGhl
IGRpc2N1c3Npb24gcmVsYXRlZCB0byB5b3VyIHNlcmllcywgaGVyZSBjb21lcyBhbg0KPj4gZXhl
bXBsZSBvZiBob3cgaXQgY291bGQgYmUuDQo+Pg0KPj4gSSBoYXZlIHRha2VuIGl0IGludG8gQVJD
IGFuZCBJQTY0IGFyY2hpdGVjdHVyZXMgYXMgYW4gZXhlbXBsZS4gVGhpcyBpcw0KPj4gdW50ZXN0
ZWQsIGV2ZW4gbm90IGNvbXBpbGVkLCBpdCBpcyBqdXN0IHRvIGlsbHVzdHJhdGVkIG15IG1lYW5p
bmcgaW4gdGhlDQo+PiBkaXNjdXNzaW9uLg0KPj4NCj4+IEkgYWxzbyBhZGRlZCBhIHBhdGNoIGZv
ciBwb3dlcnBjIGFyY2hpdGVjdHVyZSwgdGhhdCBvbmUgaW4gdGVzdGVkIHdpdGgNCj4+IGJvdGgg
cG1hYzMyX2RlZmNvbmZpZyBhbmQgcHBjNjRfbGVfZGVmY29uZmlnLg0KPj4NCj4+ICBGcm9tIG15
IHBvaW50IG9mIHZpZXcsIHRoaXMgZGlmZmVyZW50IGFwcHJvYWNoIHByb3ZpZGUgbGVzcyBjaHVy
biBhbmQNCj4+IGxlc3MgaW50ZWxsZWN0dWFsIGRpc3R1cmJhbmNlIHRoYW4gdGhlIHdheSB5b3Ug
ZG8gaXQuDQo+IA0KPiBZZXMsIEkgYWdyZWUsIGFuZCBhZG1pcmUgeW91ciBpbnNpc3RlbmNlIG9u
IHRoZSB0aGluZyB5b3UgdGhpbmsgcmlnaHQgb3INCj4gYmV0dGVyLiBMZWFybiBmcm9tIHlvdS4N
Cj4gDQo+IFdoZW4geW91IHN1Z2dlc3RlZCB0aGlzIGluIG15IHYyIHBvc3QsIEkgbWFkZSBhIGRy
YWZ0IHBhdGNoIGF0IGJlbG93IGxpbmsNCj4gYWNjb3JkaW5nIHRvIHlvdXIgc3VnZ2VzdGlvbiB0
byByZXF1ZXN0IHBlb3BsZSB0byByZXZpZXcuIFdoYXQgd29ycmllZA0KPiBtZSBpcyB0aGF0IEkg
YW0gbm90IHN1cmUgaXQncyBpZ25vcmVkIG9yIGRpc2xpa2VkIGFmdGVyIG9uZSB3ZWVrIG9mDQo+
IHdhaXRpbmcuDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWXd0TkQlMkZMOHhE
K1ZpTjNyQE1pV2lGaS1SM0wtc3J2LyNyZWxhdGVkDQo+IA0KPiBVcCB0byBub3csIHNlZW1zIHBl
b3BsZSBkb24ndCBvcHBvc2UgdGhpcyBnZW5lcmljX2lvcmVtYXBfcHJvdCgpIHdheSwgd2UNCj4g
Y2FuIHRha2UgaXQuIFNvIHdoYXQncyB5b3VyIHBsYW4/IFlvdSB3YW50IG1lIHRvIGNvbnRpbnVl
IHdpdGggeW91cg0KPiBwYXRjaGVzIHdyYXBwZWQgaW4sIG9yIEkgY2FuIGxlYXZlIGl0IHRvIHlv
dSBpZiB5b3Ugd2FudCB0byB0YWtlIG92ZXI/DQoNCkkgZG9uJ3QgcGxhbiB0byBzdGVhbCB5b3Vy
IHdvcmsuIElmIHlvdSBmZWVsIGNvbmZvcnRhYmxlIHdpdGggbXkgDQpwcm9wb3NhbCwgZmVlbCBm
cmVlIHRvIGNvbnRpbnVlIHdpdGggaXQgYW5kIGFtcGxpZnkgaXQuIFlvdSBoYXZlIGRvbmUgDQpt
b3N0IG9mIHRoZSBqb2IsIHlvdSBoYXZlIGEgY2xlYXIgdmlldyBvZiBhbGwgc3VidGlsaXRpZXMg
aW4gdGhlIA0KZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMsIHNvIHBsZWFzZSBjb250aW51ZSwgSSBk
b24ndCBwbGFuIHRvIHRha2Ugb3ZlciANCnRoZSBnb29kIHdvcmsgeW91J3ZlIGRvbmUgdW50aWwg
bm93Lg0KDQpUaGUgb25seSBwdXJwb3NlIG9mIG15IHNlcmllcyB3YXMgdG8gaWxsdXN0cmF0ZSBt
eSBjb21tZW50cyBhbmQgY29udmluY2UgDQpteXNlbGYgaXQgd2FzIGEgcG9zc2libGUgd2F5LCBu
b3RoaW5nIG1vcmUuDQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0KDQo+IA0KPiBUaGFua3MNCj4gQmFv
cXVhbg0KPiANCj4+DQo+PiBCYW9xdWFuIEhlICg1KToNCj4+ICAgIGhleGFnb246IG1tOiBDb252
ZXJ0IHRvIEdFTkVSSUNfSU9SRU1BUA0KPj4gICAgb3BlbnJpc2M6IG1tOiByZW1vdmUgdW5uZWVk
ZWQgZWFybHkgaW9yZW1hcCBjb2RlDQo+PiAgICBtbTogaW9yZW1hcDogYWxsb3cgQVJDSCB0byBo
YXZlIGl0cyBvd24gaW9yZW1hcCBkZWZpbml0aW9uDQo+PiAgICBhcmM6IG1tOiBDb252ZXJ0IHRv
IEdFTkVSSUNfSU9SRU1BUA0KPj4gICAgaWE2NDogbW06IENvbnZlcnQgdG8gR0VORVJJQ19JT1JF
TUFQDQo+Pg0KPj4gQ2hyaXN0b3BoZSBMZXJveSAoMyk6DQo+PiAgICBtbS9pb3JlbWFwOiBEZWZp
bmUgZ2VuZXJpY19pb3JlbWFwX3Byb3QoKSBhbmQgZ2VuZXJpY19pb3VubWFwKCkNCj4+ICAgIG1t
L2lvcmVtYXA6IENvbnNpZGVyIElPUkVNQVAgc3BhY2UgaW4gZ2VuZXJpYyBpb3JlbWFwDQo+PiAg
ICBwb3dlcnBjOiBtbTogQ29udmVydCB0byBHRU5FUklDX0lPUkVNQVANCj4+DQo+PiAgIGFyY2gv
YXJjL0tjb25maWcgICAgICAgICAgICAgIHwgIDEgKw0KPj4gICBhcmNoL2FyYy9pbmNsdWRlL2Fz
bS9pby5oICAgICB8ICA3ICsrKy0tLQ0KPj4gICBhcmNoL2FyYy9tbS9pb3JlbWFwLmMgICAgICAg
ICB8IDQ2ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIGFyY2gvaGV4
YWdvbi9LY29uZmlnICAgICAgICAgIHwgIDEgKw0KPj4gICBhcmNoL2hleGFnb24vaW5jbHVkZS9h
c20vaW8uaCB8ICA5ICsrKysrLS0NCj4+ICAgYXJjaC9oZXhhZ29uL21tL2lvcmVtYXAuYyAgICAg
fCA0NCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgYXJjaC9pYTY0L0tj
b25maWcgICAgICAgICAgICAgfCAgMSArDQo+PiAgIGFyY2gvaWE2NC9pbmNsdWRlL2FzbS9pby5o
ICAgIHwgMTEgKysrKysrLS0tDQo+PiAgIGFyY2gvaWE2NC9tbS9pb3JlbWFwLmMgICAgICAgIHwg
NDUgKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBhcmNoL29wZW5yaXNj
L21tL2lvcmVtYXAuYyAgICB8IDIyICsrKystLS0tLS0tLS0tLS0tDQo+PiAgIGFyY2gvcG93ZXJw
Yy9LY29uZmlnICAgICAgICAgIHwgIDEgKw0KPj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
aW8uaCB8IDExICsrKysrKy0tLQ0KPj4gICBhcmNoL3Bvd2VycGMvbW0vaW9yZW1hcC5jICAgICB8
IDI2ICstLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAgIGFyY2gvcG93ZXJwYy9tbS9pb3JlbWFwXzMy
LmMgIHwgMjUgKysrKysrKystLS0tLS0tLS0tLQ0KPj4gICBhcmNoL3Bvd2VycGMvbW0vaW9yZW1h
cF82NC5jICB8IDIyICsrKysrKystLS0tLS0tLS0tDQo+PiAgIGluY2x1ZGUvYXNtLWdlbmVyaWMv
aW8uaCAgICAgIHwgIDcgKysrKysrDQo+PiAgIG1tL2lvcmVtYXAuYyAgICAgICAgICAgICAgICAg
IHwgMzMgKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4gICAxNyBmaWxlcyBjaGFuZ2VkLCA5
OCBpbnNlcnRpb25zKCspLCAyMTQgZGVsZXRpb25zKC0pDQo+PiAgIGRlbGV0ZSBtb2RlIDEwMDY0
NCBhcmNoL2hleGFnb24vbW0vaW9yZW1hcC5jDQo+Pg0KPj4gLS0gDQo+PiAyLjM3LjENCj4+DQo+
IA==
