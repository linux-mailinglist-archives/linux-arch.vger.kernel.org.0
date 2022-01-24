Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ECA498040
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jan 2022 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbiAXNBL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jan 2022 08:01:11 -0500
Received: from mail-eopbgr90089.outbound.protection.outlook.com ([40.107.9.89]:6546
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229645AbiAXNBL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Jan 2022 08:01:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXamYssElgrVoA9YvTgJ7OnD5TEJPOA9TgA+T1EGTis2zk9KuAcyLBQ5v6vI9mnZvZkAXh/JffT8++B/NaaadjwDdkLGI+waay554sbbvdveNxfx4ygUDD56dywTNOYTIQTojnZRiwGGdIIQR7KZ44RwvEAC1l2ZWqE4Dh5wWCNhwlCIZ2LDvfV4LWgUUKF2w/kCwzHgH8kK81tlD8A7JewttEBVVHPqSHwVzdQafOkC0uzt/iyVB0woUyXTsLPKa+NOKoPBXpVFFaPzkslgCes3M6bOp0XItn/FVntaNdDF8RLk3viCQi7UZwE3Vi0A9xCORK4Y3LEIV+8bSF+/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OOKvamwVG9PD4QEqxqscW0LhRjXAVeO1Yroikce9Zw=;
 b=BwyhypWG3OgS5+9NfmujyxwWcvPGWSC9GJZZTKWgfrEOGoYy0OXNrymHOwT42bMU7nvdyelz+wOt6m7XuwlU4Ktk7FRYz1WmlZR9ZjJUN5i6qNW78at7yuA8kt2Ia6Fw6yhsDhNm7n/wwUTCVB6I6EKiroIFBvj9BCjyzp8AyfsYEOKZxxOuiZsALz7bHD3SHtA1Ug2qzlccG3lBUCRWZy8sd2cciXRYvtIf9t2ltb11xbZ2KnXzE/FywOyxF5vuZOwnfAXCqwCulB+ybinUNnBnXJ9C3+iy8emeQDO6cs7HGe2nlAczdh7vpwDO8rnDPnWJMUUBulE8oeesN1I5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2680.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 13:01:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::9d4f:1090:9b36:3fc5%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 13:01:08 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Thread-Topic: [PATCH 1/7] modules: Refactor within_module_core() and
 within_module_init()
Thread-Index: AQHYEQPgKgdjFmN/j0GzHm/ZB6XnTKxyGsoAgAAIFgA=
Date:   Mon, 24 Jan 2022 13:01:08 +0000
Message-ID: <1e220bfa-72ae-65bc-3771-42e872e7d399@csgroup.eu>
References: <cover.1643015752.git.christophe.leroy@csgroup.eu>
 <e5e58875bd15551d0386552d3f9fa9ee8bc183a2.1643015752.git.christophe.leroy@csgroup.eu>
 <Ye6cTJKTD9JehwnY@infradead.org>
In-Reply-To: <Ye6cTJKTD9JehwnY@infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86f414c3-af89-489a-6474-08d9df3996fe
x-ms-traffictypediagnostic: PR0P264MB2680:EE_
x-microsoft-antispam-prvs: <PR0P264MB26801D82CCBDAB481659464DED5E9@PR0P264MB2680.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwYVvObV9dzjgeS2QT2QYJniu+rt7VLMp0ZYqowS1yAu4uEyWxQiqDYRDp13JKInORd4ki48z3wH64lTzq2bEHde/owP31XR8VrLZhumIHyQD2l89JtZTQPX5AHYy0l/Wj3SrChyUvPhta4qjYazMgk0RHAX+cq6utBc/Zw5h5R5FXEGhNCdviAnxPQwFWGnfTbac+XZBOkMbjGq0vxVJvgMylzcjozatMS2sm2ZFeJBljwYI5RzWmdB6whVRmyrXW3deZ+znAT/Uc7tP+UD4HsCVDG4Zi8srwv3euUU4lNTpTeyF/rnwh/jqfQSOAjc5H6p6MmBJgy5HdU+cL+xqb1FH2AGqwqpczD3drScU1Lr8MQqEenjqgEPfVS6kbs4WXxLmQBHmtwyvwxWmScl72jpIN5SeFv1VsII9hwqXTDiiZ2h1uHVs+wYCe+XszSXzgLXarU4AMuqHGvTBk1aRx6RfshZD/JV8fsVjvfEvxijRxjixkarXRaxhY2MfPPabLNYX5Qz9l1JYLfVbUqRPVuVrS59Ij6mo1PFmgHcRAOEnjEia4wVwlYo/dfMVlHrj590uCO+zVcWiLM8KUwskM5TiD7beqQrP3XP2eJYEMqaawZYuKWgJrOlp8x4U2YF2KEGUxMiPIfp14KgbYhthPQnf42GY6K/zTn73Z9muwsHY1mPNAuhNJaor8/uh16C9WMiMEc+pTCQF12jZ5CTlGz5f0X7DvfvhHPiej1e9ZO4AEGkybZO3Y72xDUc3c3IR8f38K7D/FngnBkN9kmyPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(26005)(4326008)(186003)(8676002)(31686004)(8936002)(508600001)(66556008)(316002)(2616005)(6506007)(71200400001)(6486002)(36756003)(4744005)(6916009)(38070700005)(31696002)(91956017)(76116006)(6512007)(54906003)(66946007)(66476007)(122000001)(44832011)(5660300002)(2906002)(66446008)(64756008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGRVc2I2bXNBeXIxdmxXVk9vRWlCYmFFcml2a05qZDJzZFpQWnNvTW1KN1JQ?=
 =?utf-8?B?MjhxVlpCcmRDV1d1VkJ1Y3FoK3haWUpVYVR6S2dBb3IzWmt4VnZkekszanpp?=
 =?utf-8?B?dDZvSmJEN2lJRlZKZmVqUWtPaDJsamNqYWtqUTdIWHB5SVhiR0hjV3pCQUEx?=
 =?utf-8?B?ZkhGODRnS1ZPaUs4bnFiNFF3N09GNnhaMXRxdUpWWWx1NUtEZVUwVzU4VjNR?=
 =?utf-8?B?M1kyaW81bnFBYzZsWWZRRS9qVjFSOC9iN0NEK1ZzWXFkWVJ1RnViMUQ4b05p?=
 =?utf-8?B?KzJOUkR3dG1FbDdGWXNXbkF3Y1QxOGw2Wjd4Um8wbjIzQUtsQVkwdlFPZXBS?=
 =?utf-8?B?Si82Vm1iN1VvcFlKaDhWMlgyYmhMZGRsY2p5MVB3cTNPSnEzcXdmaHBob3Fw?=
 =?utf-8?B?TmRlWkUrSWpnQVRJVjB4ZDh5Ui9HSmd0VmdNeWJKbzIzZmgxZWN4ZDVtWVhI?=
 =?utf-8?B?dndzeVpMcmcwa0Ntb2ltWXVnK3lZNGhZTERTYk5jMHZhczBEQXl4dHNSVDhw?=
 =?utf-8?B?NXFZS2dETm9TWWZQb0VBWjh1MEdyYWViT1BwVEo4NEhjOWNnZTZ2NDJadnBJ?=
 =?utf-8?B?Q2hkd1BkQk16SU1CUXZiYUgrcWI3M05NdTU5RElKKzA1WlRMcTU0SEl6Zk9C?=
 =?utf-8?B?T1VEUlMzVWxkTW9ON2VCT3N6dDZrdmxmWm5tQ2toSFdVMlkxaElCNUcrMHVV?=
 =?utf-8?B?S2FzUGhaZEpsVmRYTXVDcSttWFljeVY2MFdpQ1NkNjVvWmYwOTRVa08xWW5M?=
 =?utf-8?B?NmZGNWRoc1FHclhHUHY0QkpXdTZ6K1RSYmoyZkxzbHNqYVZWV2Zic1UvMFp1?=
 =?utf-8?B?b2Y5Y3grSEJvZUI2V0lSckFTNTBrcWRnN05scDRPbXV1enVqTWo3MVVUcFFh?=
 =?utf-8?B?VHRtV2thZUt5YkE5YzZjcHljR3FIU2xBYnhkNlk3aXdZQmxXN3N0ZDFOZzlS?=
 =?utf-8?B?L01uQ2lXMytLenhEWm8velNUb2lucFp2eEtBMnJXbC9TTVFrdC82aXlzMDhZ?=
 =?utf-8?B?QXdDenhlWVRiNWhYOWdkVWZoeHRickptQU9QSWMwZkErVEk2b3AzdXBLTUpp?=
 =?utf-8?B?QjVYR0d2K0t5ODVUdVc0RERhZE9YRkZod21Gc01LVmRydDZBZUZ2NEI3akdm?=
 =?utf-8?B?WWV2eUJGcFdjdHJwN0I5eFptUXRRckVwVVBHTzJlNWc3UHVvOTkxT0RpaTV5?=
 =?utf-8?B?TXJKR0VJYzVJR2NrRW1mUjFIUTEwaVdPejR1eWlQWExLb0JFYmJWOGV0Qk4x?=
 =?utf-8?B?clVBNXpGMFlKNzZSTTR6WjV4QnJQM0gwcHRDUFVvNzdmVmY1cW1ib24zKzk0?=
 =?utf-8?B?d2xRTHRnNXRJRkpscWU4V0MybW56cnRoQjljREVnRHgvK2xkT2Znc29TYkZm?=
 =?utf-8?B?aGNkbGdqUDlMK01kTVo3TUp4cno4TjlYaWpJR3JQZEY4TXVyU2Z3VFdxemlV?=
 =?utf-8?B?N2RtMTNGdmRCUU90c0xQMnphSW9tZWV4YmVOTXIwcnpZcWJHZmlMcXpPa29r?=
 =?utf-8?B?QzhFVU1VemMrNGZ2VlJSc0N1ekJYdWRHQ3Fjc0tYbXpxVkRSVFBXN0lXM09t?=
 =?utf-8?B?WlFsSTNnWVRib2RwdUtzRGpLK2FQblBGcXBkazZqUW9JcWU1SlZLRFlZYlNJ?=
 =?utf-8?B?SEZpbVpFS2cydjkxdUJLN3h6RXQvc21KeGppSFZyS3hmWE52MFdqNFFybWVI?=
 =?utf-8?B?Q3Y3NVNrbXdPZXdVU2Vtem00TVgwMEhvZENTQXRCaXNWdnpCZktXMkMxRXBw?=
 =?utf-8?B?b0h0M2pORGQvUEo2TzdZOWJFdVBadW1LeWhiQStIMmRzZEVscHlWWXZxcUVR?=
 =?utf-8?B?UVZhNHZBYkZRcktVZlR0cEVLcWdqUU9NSzU5QzduRCt6c1VTdTlRMGF0RVpy?=
 =?utf-8?B?VGZ6dGEwMndFYXBMMG14VnNQVmRsMnkyWi85eU1mSzVzMHkydUhuYmpHVjdZ?=
 =?utf-8?B?U0s0MjVDeGNOVGlBc3JIRXRBRnplUkxlWWFNa1R1eEI5ZnZ0RzVIc09pUy9k?=
 =?utf-8?B?cU96RG85UlZhWkxkeW5BZGl2SHJac1kxZExEWHk0aGRhVmN5L3haQnlnWGVC?=
 =?utf-8?B?OVMzRjRtc3dyWGlDVVRMajZ6WWZFY3pEVXRPUTFBOUdmd1NmUzBYUHJUWFVG?=
 =?utf-8?B?Y25uSVY0TVhHUWhDOElETTlNZkdPbzVtQjJBWmtRMmsvbklneGNwK3dwWHBt?=
 =?utf-8?B?ekU4U2l6bkZTcVdURXM1L2ErK3lZcGFlUzZWSCtLUnJtQkVOaW55T0RiZGNK?=
 =?utf-8?Q?E0ybLgY7nZQr28io5BVspx3+cSGvCjL6EQ2vd3tW2Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29490B43FB67B3449CBC87D509870086@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f414c3-af89-489a-6474-08d9df3996fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 13:01:08.8395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aWtErBPR9Rk4XA0G49q65gpH+wCTdF0Dqcg29b764/88AgWplfPHAMKsX6nhiugMidnSVNRfWtB7zvboKB9T0bm5CfFMAv18gZRliHsCJDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2680
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI0LzAxLzIwMjIgw6AgMTM6MzIsIENocmlzdG9waCBIZWxsd2lnIGEgw6ljcml0wqA6
DQo+IE9uIE1vbiwgSmFuIDI0LCAyMDIyIGF0IDA5OjIyOjE1QU0gKzAwMDAsIENocmlzdG9waGUg
TGVyb3kgd3JvdGU6DQo+PiArc3RhdGljIGlubGluZSBib29sIHdpdGhpbl9yYW5nZSh1bnNpZ25l
ZCBsb25nIGFkZHIsIHZvaWQgKmJhc2UsIHVuc2lnbmVkIGludCBzaXplKQ0KPiANCj4gUGxlYXNl
IGF2b2lkIHRoZSBvdmVybHkgbG9uZyBsaW5lLg0KPiANCj4gLi4gQnV0IGdpdmVuIHRoYXQgdGhp
cyBmdW5jdGlvbiBvbmx5IGhhcyBhIHNpbmdsZSBjYWxsZXIgSSBzZWUgbm8NCj4gcG9pbnQgaW4g
ZmFjdG9yaW5nIGl0IG91dCBhbnl3YXkuDQoNClBhdGNoIDIgYnJpbmdzIGEgc2Vjb25kIGNhbGxl
ci4NCg0KSGF2aW5nIGl0IGluIHBhdGNoIDEgcmVkdWNlcyBjaHVybiBpbiBwYXRjaCAyLiBJcyBp
dCB0aGUgd3Jvbmcgd2F5IHRvIGRvID8NCg0KQ2hyaXN0b3BoZQ==
