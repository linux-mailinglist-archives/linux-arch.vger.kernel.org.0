Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D213B49E0FA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 12:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiA0LcE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 06:32:04 -0500
Received: from mail-eopbgr90079.outbound.protection.outlook.com ([40.107.9.79]:42070
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240422AbiA0LcD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 06:32:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvVLOJgKqWqTho5CtTUiLt+a8Pn3k7TAO+fA8VdmepzElketfAfC7ydwzYRy1/nPdB3xrstL4jWiCVkEnQMAPwPzXveqetrcu+sWjCnRnODrhyuph7VELoXWItLMGQvf0GA7dmm1QDkTu/jB/QO/rrBwAUQq60yuLrpWCaSRfH5J0gyx/SAi0Hcr/mLwJh0kqEseNzzeRd5ZvlkFu5tys0Rs1/dzQDgy6RwWTIj9Q6CBOd8DSKz3aKp9jwaoV92noH9BbhUoaLUMAe6bGqvXgt/DAKmfmvlXIIYZcFvVt2kFk2ocFAgv3rXjfh7dX5pPSkHlUKugd3yQh9zjQN+6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zklrAIWnPoPJhHqc2ppzz8P7FY4rklWGnGWrIp6VXbI=;
 b=hteOLbypnEtiUwmjKeT7RmDa84QuvjOZZ/0TzH9W3fYhaMQF+mI1jjhCrk5G+E3kFNcAap9BroCSV974SqwBoULgC4JlWyduxI2+nDjXggX1fHx+iqhqpuez0j81nZ6oBu4Kf5nZGhmGdbrrXka3VkW7y3+ht+grD/i3edGllmCRjj5Lt1DHioe2sJfukwUK8Ai4LMe+U0tTWLSWH/Bjgxw5jw/ESlBVvb3AD9I0uIYEXRDqGJDjlx2WfsqwgJtwiPBFjMOYGudMTzP0p4I55EHYq4qDfutDlU1dK7wNNZW184kirVNkMAzmLdRDcAb80s7tfkD1ZIfW3xVKp5D4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB0763.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Thu, 27 Jan
 2022 11:32:01 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c9a2:1db0:5469:54e1%6]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 11:32:00 +0000
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
Thread-Index: AQHYEQPgKgdjFmN/j0GzHm/ZB6XnTKxyGsoAgASmLQA=
Date:   Thu, 27 Jan 2022 11:32:00 +0000
Message-ID: <abf4f3c5-f765-d360-cc61-de6692bd63a1@csgroup.eu>
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
x-ms-office365-filtering-correlation-id: 49474175-95ae-4bc0-6a97-08d9e188a286
x-ms-traffictypediagnostic: PR0P264MB0763:EE_
x-microsoft-antispam-prvs: <PR0P264MB07630612894E32C010031A77ED219@PR0P264MB0763.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyY4xuVgkYUQvbjrgXwaXGjVM5BZD2HFZVii3/taxaUMGp3ZcsKwELM0zh8f2YNphvPhcTtDZhp+FuY1ALKpdbLA0AvNwpP/6IM1Z9hoePlmaGAwW19rkA7W2bUaOHaSCB6I/PSFyBnffse8HgnEGWCWzWISofid4xfd6IWNaKSimdoSWMS0i287tsweSenJa4rB7lkPWVmVpMZEqpVB2T8YZ1buZ2iVNnXntyyEqXyRLrmEjUMmrI104ASifmOTQVOn4bhzTgLbEyzcc0WrHIdIn0VG1M8ZZvpNoTkWYAGcC88obcr3YLp+aQA+g0umy2kWKsIYbPRIwxto8KwHdDTH4XeZJAlw7Tdm2hb9lClwRO8MzUAB5qds+mk4CaxxF3W46ANlaaDfYZ0qBz9WTOeMw5gBVYOLUOv5TBaO/BNEndzZ/8b3x3woV3qQo3X1/xXLMprXQAesJS+MeSi7baYmy3j392MdD6DRAsAv4aEiynVz1hssJmGMEz0ZZ/8uU0fteKbzXlMfS+iQ1xeGP4beQKLWkAltlIAZOgv5Qsy165le9hwTmjuy84xXGSiaeJFnnzxjivpIIgct+obY000/sMcHFDgOOcs9W7wspdHI9awW02vCFica4m3BcLkqL7RFt1zFlZBGKzPsjhVjBGRh+NKR/xOSLa6wVpcxexJOC1sKlq/2F0Vu8OSY2QTIjkvZVt/oaoAlm7xS7OwPRV1MOpK07qex4AO52afFpUCFhBBFujF+IIewnyfPimFFlrTqOtTjhodIuPiwERuV4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(26005)(186003)(8936002)(38070700005)(316002)(54906003)(71200400001)(122000001)(508600001)(31686004)(36756003)(2906002)(66446008)(8676002)(91956017)(76116006)(66946007)(86362001)(4326008)(31696002)(6512007)(6486002)(2616005)(6506007)(6916009)(44832011)(5660300002)(64756008)(4744005)(66556008)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enZ1UkYrcW44Z0NUYnBLR2NTRFl0d2dVQlIwYUx2aU5xR081eG9vSHZaUzF5?=
 =?utf-8?B?cWEwdUdCRzlpL1M2QksvZ09EZmNNZjlMbG96WlBwb1RWQUxhOEdEMGY3Rzhp?=
 =?utf-8?B?cnVqUGxlNU1lT25xbit0L1Vtck1IYlFPbmlnbUFUczVwUURHZTl0WHdjcWwv?=
 =?utf-8?B?cE5TNU91WkRNR0ZkM1BNN0o4M002V1JmTmd5SkVPNVphaGExQUc1MUFpcWZI?=
 =?utf-8?B?M2NHcnVRUUpwRGR6ejVEbEF5aFI4ZnkwR2JMNHpKbVU3OCtjdFRSNDd2YnhF?=
 =?utf-8?B?RE55S0dnUnpSSHIvVThhNkkzN2diN1VTRFVzalFTRU1YdWNZbE1FUE80UExE?=
 =?utf-8?B?a2ovbTVMQ1o1Yk9TZHNkMW9VdUdlTkpRTkJPSjBQWUdoQ2V1bXNPTlptbkti?=
 =?utf-8?B?ZnJ2N1duVStYQkxPNXYyLzAySGRoTzRWbUcrVUtBeDdLY3VMTjZkb3pldkZq?=
 =?utf-8?B?cUhBc0dHNjFPdWhJQ2Q2eG45MkViazhkYmQ4RjZkT0VYNmV2TkRHbnF4TlhF?=
 =?utf-8?B?SVJiMjB1TW1WeCtTMStEQjBnS2JIYkgyclhzVnduZml2Qk9zb1BhekE0VGJp?=
 =?utf-8?B?UG8vV0VrYjBQeDEvK1FTSDhoQ3ZBQXc4RjdwOHJielVDN2Z5WndBbURralBm?=
 =?utf-8?B?VW5vUjhLcEswU1hVQlF3amY3QTk0OHdKNlJITXgrU2NXWnlUNG53UmNZZkYx?=
 =?utf-8?B?UjRETlN5Z294c2Fad2w5NFl0U0tSTld2aDJqNmdlM0w1SzFobm94b05xQk9z?=
 =?utf-8?B?SnV0eVVTdlh0WGR2SzZPM3JPc3Y5NUlacmR1OG50Z0h1OXgyK2FiTzZmWGpW?=
 =?utf-8?B?d05sZ1ZsWWVlcTkvalBOT1hQQXk1ODJKTjBLcVEycFU0WjAxcjIzVTVDZXcy?=
 =?utf-8?B?a2gvajliTHY5L2trNzBGamVnTi9Nemg2eENwbEM1cDdhbnNTSGxmMk1GcUF3?=
 =?utf-8?B?bERKVWl4MGM0cTdSSnNIVE9pNlZCMW5FQ012QmM2NHArNy9FbHVWYmlhY1hO?=
 =?utf-8?B?eFg0UFE2VktjQ3ZWeFFmWUpNWGNHbUFFTllaUE1LZS9DTDdHOEZCNS8yYWx0?=
 =?utf-8?B?aklFbzBnSVdqOTBkTFU4ZG43NEpnUGxnY1lla3o0VWpsOXFlN1NWZDRFY0lr?=
 =?utf-8?B?VElrM2p0aWt3bU45L1NqdlRiVDNIeDBoN1JZdXlkQjF3cHA1SGlQWU5xNCtr?=
 =?utf-8?B?UkJCVUlMeEIwa3NmOG5XTDVwS1ovNmV3WHZPYWwzTTlBMzR1d241UlhIUFhJ?=
 =?utf-8?B?ekd3SEpuclJHY0RabnpsUC9yTXk1ZnhHZGpFNE9BYU11TTliRVpLNmg1YzVR?=
 =?utf-8?B?ZFVRTUU1QU4zenpPSEJsYkk0NlhETVhBa294ZjdSWG1MYVZsUDhUWnN5dFVR?=
 =?utf-8?B?bHQ4bS9BSnJ2WGRNcUxpRHRrWkFEYk13aXBmdVIwN2FWcTM1ckdyV0srQjlK?=
 =?utf-8?B?bE1oZGpFSjY3S2ZudGd5RGhTZHdieFZDNlNka01ORE5zVXgvbVJSNnFrOTIr?=
 =?utf-8?B?REIxRTZFRjB0Q3RVUUpFcUQ5T3J6N21MdzNJc2t6bGZkNzRnT3R0eDFlbVpy?=
 =?utf-8?B?WnFESkRXeHRtNko2OVpHQTk0eWpLaFZhakVDd0RpRXFTd1dEMmREeU93K3NZ?=
 =?utf-8?B?Q1NIUGh6ZjlUYlhnTFhxd0RaVktPZ3ZpMHhnZGc1WVRMcmJIUUdKZ1oxWUxW?=
 =?utf-8?B?T0Era25kb3FnUlV3a1dQU0lFWGdBUXp2UVgyZ1VaZHF6RDYwS3ZZbXpDL2xS?=
 =?utf-8?B?UCtBTlR6SFBSSSt0YlRkek5zOWF2VkJKT3M2OGE5OUphMGZyaVlmdmNqUFVR?=
 =?utf-8?B?YS9MMExEOEVLVHpUMWhhbW9tQk1oOWFTS1UwVlhhcTE3eW9BVENvS1dOZnV2?=
 =?utf-8?B?OXEyWHZyczFsM2UxRG9mWXJVZlhtSTNRRUR4amNiM000c1NpYmUxRFhvYS9V?=
 =?utf-8?B?Q1U3a3lZN2JZcnB3dGhyTHIydk8yNXB3MzdHdjVmaVRPQjY1NEZ0anRYWUVQ?=
 =?utf-8?B?ZWh3K0lnbmx6RGlhUlZ6WEtMcmNINDVKdGRGZ3M1WThjTVlaeDJyZXl2b3hh?=
 =?utf-8?B?d1hpcFlmQjdQTmZmWE9Yb1VrNDg1aXhoenVRWWVIS3o4bkMzSit6YUlhbndX?=
 =?utf-8?B?Ykxuei90eTJ2b1dWQzV1dFZWWXVLejdNOTRONHdNckVpLzN4V0JvdjkrSHE0?=
 =?utf-8?B?c0JncE5VeFNGVnljWnI3ejlReVhSNzZVYkdjMnR1U3ZJRXcrR1JzSlVoOFFT?=
 =?utf-8?Q?fJdiLqrr2ZgVzI91rPEuRgCTaoANjvyginC9iStqGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F257BC61D0439478ADB562266EF3014@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 49474175-95ae-4bc0-6a97-08d9e188a286
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 11:32:00.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDq5m43ZGQ9b/IsoeGtUz17Nd9uQGryEwZz79jSZIjhzLjzL8ElJTk2g67W0ifGLVrbpaUdaJSqZ3vJ4oYHr1QGGAB4p57MUFEGj6pdnSlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB0763
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI0LzAxLzIwMjIgw6AgMTM6MzIsIENocmlzdG9waCBIZWxsd2lnIGEgw6ljcml0wqA6
DQo+IE9uIE1vbiwgSmFuIDI0LCAyMDIyIGF0IDA5OjIyOjE1QU0gKzAwMDAsIENocmlzdG9waGUg
TGVyb3kgd3JvdGU6DQo+PiArc3RhdGljIGlubGluZSBib29sIHdpdGhpbl9yYW5nZSh1bnNpZ25l
ZCBsb25nIGFkZHIsIHZvaWQgKmJhc2UsIHVuc2lnbmVkIGludCBzaXplKQ0KPiANCj4gUGxlYXNl
IGF2b2lkIHRoZSBvdmVybHkgbG9uZyBsaW5lLg0KPiANCj4gLi4gQnV0IGdpdmVuIHRoYXQgdGhp
cyBmdW5jdGlvbiBvbmx5IGhhcyBhIHNpbmdsZSBjYWxsZXIgSSBzZWUgbm8NCj4gcG9pbnQgaW4g
ZmFjdG9yaW5nIGl0IG91dCBhbnl3YXkuDQoNCkkgZmluYWxseSBkZWNpZGVkIHRvIGRyb3AgdGhp
cyBjaGFuZ2UgZnJvbSB0aGUgc2VyaWVzIGFzIGl0IGJyaW5ncyANCmxpdHRsZSBhZGRlZCB2YWx1
ZS4NCg0KVGhhbmtzDQpDaHJpc3RvcGhl
