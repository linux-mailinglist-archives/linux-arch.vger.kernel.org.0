Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E434FEFA3
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiDMGQD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDMGQC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:16:02 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120059.outbound.protection.outlook.com [40.107.12.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535352B04;
        Tue, 12 Apr 2022 23:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2ayDVTBT/OOjI7y9LH9CPdnxsOpq7ajW8z/wbchGnyRgZG34EukQn/mO7TDbVKakIVQfR6VqA1TwvF2jbLGEeXkAZ4y6tgG8JDuIVzIqQXSxd0fetW0icypgVsUcIWwwEUxfB69Obo1b3go74Zyw932WGF+7H6K6Rzn4C72uQFXZx8tYZ3Pi2v42ujtqgWliqQkbxAmgR/TMyK7fczhNPqinleY6FyNPL5R9LxXfqk6N2RKV7O1SpMVszNevXzIseL5pi4SwCsiqr4bKjDy0o7IAmv3HjJV6AiKv0hoLOgvF9a8GhmNKdu2ZwbJe5oTW7WWyjCf6tetFIhY/cY0jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91AuElR0XGZbc9+xQZf1eZ20xi1ezERu8K8rDK5dAms=;
 b=kpx/FSxMvCO7l1Y8p0QnLGhrZ3JLyGA9vUnPCytYk4FQiXgLYLMj2viIQUbiSsBui/oZhiVGq1R1+MIh2CAA+iBD7kRboOxRvlEVsXw8oP3OZSS2q/vp88ijyx1W7NRfQ02FiFw0iIU6uMSWKusXU0+NjGg7VCixidqF9YrRVcaKLeD7XyY+kaP665LbCnG3oVekDK6hSafMwDrFagOcHefpGtlLeozJrCmfi3BiG47BCMWyWqBoQ7Hu1h7D7KVpHQ8+DaDEC9GbewwFEs6NhSJHCGpaez9ndwNjBaascGpYqxmkGa73lAiSU3KQIlx5p2UE7+5TGjGkz8W3BXEqoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3689.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:149::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 06:13:40 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%8]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 06:13:40 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: Re: [PATCH V6 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Topic: [PATCH V6 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Index: AQHYTvuJfqUxH6aZpES+BVcjOyREoKztXUMA
Date:   Wed, 13 Apr 2022 06:13:40 +0000
Message-ID: <c3619877-32db-aaa3-5dd9-4917c067bc42@csgroup.eu>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
 <20220413055840.392628-5-anshuman.khandual@arm.com>
In-Reply-To: <20220413055840.392628-5-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9967220-6916-4b9f-71d3-08da1d14c114
x-ms-traffictypediagnostic: PR0P264MB3689:EE_
x-microsoft-antispam-prvs: <PR0P264MB3689F3F2E04236C91D3720E8EDEC9@PR0P264MB3689.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbsiQ1Q6H70vhlps3YdaBtDC0j8AVch55RFedlDvs8sYqSDAyizr1J14e/m09DZliFnNUMG2qVVjPuOdqlXbJdxvrDOL3ln+yKHL1Kl4af09Vf7d0f7iqq5DFPc3kl3TPFzztBPO8R7UcVVdKednfUAduH5g1TXSz4xoutZaS5paN0F8OPNeceYmQi2uvBnuBFddZAlXfVDJ3ydnnfZDdhWjKWmvlEXjSXOaxeMvckDP6LTU5P6XJdeHKUUOBv5Qp75LnXnZcErzGLhivyufGV3zmnfpXjluNsV6eubyRLn1DIXW9BppOLy4mX9ndBq2DDTEqLHHWkGIC/nuTrSpzibpJEVoBzSAjmYPlmbTjBM5GhxQcjgeA++494rVKuh5/dg3pyN3uKTqPNbBft3W1AKOMJNdnikhBnlADc02ttG9qxz38cdw2kVQ3ueyxAcqpYI+9M22CISZ+kaNXGhx9kQy4C6rjs5KvUds5EX6wHlfpvnTNhx3BHjLOJn50rRZxNybM07a9v4Si8WtL6XFr0grnov3f/Z5KIEpSFXUEIe0Ewtb09ZsEeZTpcPSLvObFYn7LhP7wbHY7bjL1GYZmn3HLWNbvA5jGsD4y8HiZ8PfXh1xYnGHnSgnVSAsLj7y4k5+BmKn/6Qf6VBxvzc0MZ11aqH4ueCEWgQIzEsPwHEKG3ISSO0262NeKZviCVvu//r+A/kzQL6dCccaoS/vpGGgzAAfNC34QhuCIlIV1kTIbeo/DctUrtdiLPoK38KMXp3LfzL/8hai5HgZ9XS4tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(26005)(186003)(7416002)(44832011)(38070700005)(508600001)(6506007)(2906002)(6512007)(8676002)(66446008)(36756003)(2616005)(5660300002)(64756008)(91956017)(66946007)(76116006)(4326008)(66574015)(110136005)(316002)(54906003)(66476007)(31686004)(6486002)(66556008)(31696002)(122000001)(38100700002)(86362001)(83380400001)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHhJdVdDVXI5Wk85anI3OUZ3RFU4VWpDanpMR2M1MGZ3ZXVxOVVIR1dCaW9J?=
 =?utf-8?B?ZUdqNHFhVTFpeFRBYnB5WjZPdkpFcjZUaVhPdm5pdFE5bjN6YjN4ZlQ0TTlk?=
 =?utf-8?B?bWw5Q29odGlES082U2pqNmxrUlJDODhQKzBSUFJCYWpLOFcxZTl4K1ludGU4?=
 =?utf-8?B?dFUwYldCOE00R2ozcTJwb2ZWdmJ2V1FsN3crVlQ5Tk81WGJlbVlGK29NWHlD?=
 =?utf-8?B?S0E4YlRld1JuQ1lUYzlaTE9RK3hydC9ldFhwbi9KYVlsNklYemVQcTBLTndj?=
 =?utf-8?B?VTBkaFd4MnMxYXJIRGV0N2E1SGFOOXdBVkllWGR5VW9hanV5VlJpU2FacTFI?=
 =?utf-8?B?RGNueHZUTmdoK1BYaE1KdXpiMEFYSnNTTDRpcDRucUxSMlBaNlZVU3h4SThS?=
 =?utf-8?B?cmY5QjNFSzVUemRGc2Zha2w0UE9IZFBBdzArdmRLeEUrM3RvZm9FS0hCUzlF?=
 =?utf-8?B?MGM2YnFoSkE4ekdQYjBSNW95TVBXbjh5dkRzTG5xVHh3dVlmaEVXQjVGU3hH?=
 =?utf-8?B?WWhUbW82Qit6WGJVSzk0UHU4VUljWlBxVWNmZFBMUlBIYlZ6VysxVllmK3Q0?=
 =?utf-8?B?NXY3RkFiaU1hcWFUNEUyVXVZTmYxRWVyRFh0WkRHM0Z4VncxMEQxbFZzVnNK?=
 =?utf-8?B?RnRmUjh6QTdyTnFRMGNOSzI4TmtUMkpqdFpDUXBxaDltcnRuc3l3MVRtbjF1?=
 =?utf-8?B?WTRQaDA3cFpPdi80UFQ3OTA3Y3NKb2RkT0NuR3dvRDJhSGVQL0wzNXdnSTBW?=
 =?utf-8?B?eVVxL21IZEkxbTFudnJBU1NQdVYzVUlUNXdnYmVBMFpqcmJ5YVAyTU5KbDF3?=
 =?utf-8?B?cURZMFRGNzZCNE9NK2ljUXlYaEd1dEpxdDkyMGZXckg5N2dOS2JkVXZBVFEr?=
 =?utf-8?B?M014dnVUTEtWZGVoTGRmV1dRYllERURZcWF4SDlib1hYK1NrRWp3bGhsTEJE?=
 =?utf-8?B?Z0dSUmFVMHhUVE9LU3JPQ2VBc1pWY3Uvb2N2Z09SLzZld2JpUS9VakpZOWRh?=
 =?utf-8?B?OTBUK2FIdUxVRk1wcXBkeVVFZEhYREdGNEJhV3lBYmpMRVVYeHpzUktGYWFD?=
 =?utf-8?B?RjdrTDNQNVRHYmt4QjFLU3RGRVRsMU5CdzNrbWJGa3JnSUxWQkVjdkdPSW44?=
 =?utf-8?B?NG44alUyTjZjVlpGakY4cmJwckdUWkVFa2pQSEo0QzRFdHU1Z2d2dTdrRlll?=
 =?utf-8?B?N256cDBENXlZcjhCdVo2U1NBLzlETXNwWXlzTS8yaE1rUG5lT3lFT2NnZWdl?=
 =?utf-8?B?OVRTNDZtUDdlOExldTlobTkzL0Jra1NKa3FyTkQxMndDbUdlZGFzUzdmVU1Y?=
 =?utf-8?B?cUI3VDhPZ2pqV2t6Qno0OVo4UDNSVVNjbFpSakswNWpMR0hESjhCNWE1WlVy?=
 =?utf-8?B?QXNGRWh2ZFN5cXc1SVdvTXUxTzVYS0xTWlRja3pMQUN1V3JmM01CYXlxZXJo?=
 =?utf-8?B?dlUyTjBneU5yWVBSTnkvR1lOR0dpamhCRURvOTgxL25RYndvTnBjWThacEVE?=
 =?utf-8?B?ZnpXbDBNMjk0aHFXWW9PUnFNRU0wZFl0MkhlbVFCQnNORUJZbXBVOTZsOVlR?=
 =?utf-8?B?bmJsSlIrK25LRnJlRXQvMjJTbTJiWDdobWszUkhDQ1VSdU4zYUVRZDJKcUg5?=
 =?utf-8?B?VnNoOGZuRUt4bHFmRitoL1NrclFzcThqcGwxT2huLzBsT3U5M2J6cDlRSkxU?=
 =?utf-8?B?dDh3Vk5ma2ZvMU55RmlnSlVMY2lyTExaQVdqN0kwVFU2ZFhJRGJPZUdlQXFm?=
 =?utf-8?B?S3QyeW5wbktzTjhOYVZ4dE1CZTZwUDVOaVJYNmZmeHVaLytWcDBxbzk2RFYz?=
 =?utf-8?B?YUoyekIydjJkVnJ5VnpkUUkrRk1welRaSjBZa0dDYW1mU2ZkMHVwbFdkTHlr?=
 =?utf-8?B?QXpvZll2R3FQS2JwRnNZT1hxanlBQVlUQmVvb25wY2V1M1YvcllQMGU0TVpn?=
 =?utf-8?B?M0gzNHFVdS9FKzJBWGZSL1JRQjgvTzRFK3U0emM5WTJKUHRiTENRamswcDdw?=
 =?utf-8?B?VldyZDVvZG9NcHpEWHQvLytlQXc1Ris0VmdjYkd6bmd3NW8vQmpjTVlWNWs2?=
 =?utf-8?B?RTNYNXhIQk5OOXhWbGJ0dzNLNkx5QXdrNmhzOGc5WGFmR0U3TTNLMUU3SkdW?=
 =?utf-8?B?UVNvUy96bGpub0pQZjBBWlMwNEJOeCs4NGpQRTJmTjNFMXRBSGJWU0EyNUhD?=
 =?utf-8?B?dU8yejNidGl0YVNRTGlxQUpCVVp1eXlxeElLbEFoN0NwUUpRbU9hNFdkVlpC?=
 =?utf-8?B?Z3kwM2hqOWUrZDJsTTlRaG1yaU1jWlU3ZG9Oa3I3cytjVW4zSGhnbGtRd1hP?=
 =?utf-8?B?eUQ3UjJwc3JJZHZ2ZllhRkxCTG1SQ2hpTitNdGVTc1BjQk9hbTNMZjFDcGpj?=
 =?utf-8?Q?TO2aPzki3ap78kYxxSBuZt761ISqg+YwQLzrK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78D2DFCC8EC64D49978425CD52A49E11@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e9967220-6916-4b9f-71d3-08da1d14c114
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 06:13:40.1303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2pw8BcFewY/zd+5Xu+f0QfWtbKc8d4t7dL2jvWoJQWuXWAx+vuiX6js1dfd2oKgxGrUEc5/JWLriDNhZP9rVU/OUjhb9oey6OnxAkmYwRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3689
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDEzLzA0LzIwMjIgw6AgMDc6NTgsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFRoaXMgZGVmaW5lcyBhbmQgZXhwb3J0cyBhIHBsYXRmb3JtIHNwZWNpZmljIGN1c3RvbSB2
bV9nZXRfcGFnZV9wcm90KCkgdmlhDQo+IHN1YnNjcmliaW5nIEFSQ0hfSEFTX1ZNX0dFVF9QQUdF
X1BST1QuIEl0IGxvY2FsaXplcyBhcmNoX3ZtX2dldF9wYWdlX3Byb3QoKQ0KPiBhcyBzcGFyY192
bV9nZXRfcGFnZV9wcm90KCkgYW5kIG1vdmVzIG5lYXIgdm1fZ2V0X3BhZ2VfcHJvdCgpLg0KPiAN
Cj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBDYzogS2hh
bGlkIEF6aXogPGtoYWxpZC5heml6QG9yYWNsZS5jb20+DQo+IENjOiBzcGFyY2xpbnV4QHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBSZXZpZXdl
ZC1ieTogS2hhbGlkIEF6aXogPGtoYWxpZC5heml6QG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPg0KPiAtLS0N
Cj4gICBhcmNoL3NwYXJjL0tjb25maWcgICAgICAgICAgICB8ICAxICsNCj4gICBhcmNoL3NwYXJj
L2luY2x1ZGUvYXNtL21tYW4uaCB8ICA2IC0tLS0tLQ0KPiAgIGFyY2gvc3BhcmMvbW0vaW5pdF82
NC5jICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3NwYXJj
L0tjb25maWcgYi9hcmNoL3NwYXJjL0tjb25maWcNCj4gaW5kZXggOTIwMGJjMDQ3MDFjLi44NWI1
NzM2NDNhZjYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvc3BhcmMvS2NvbmZpZw0KPiArKysgYi9hcmNo
L3NwYXJjL0tjb25maWcNCj4gQEAgLTg0LDYgKzg0LDcgQEAgY29uZmlnIFNQQVJDNjQNCj4gICAJ
c2VsZWN0IFBFUkZfVVNFX1ZNQUxMT0MNCj4gICAJc2VsZWN0IEFSQ0hfSEFWRV9OTUlfU0FGRV9D
TVBYQ0hHDQo+ICAgCXNlbGVjdCBIQVZFX0NfUkVDT1JETUNPVU5UDQo+ICsJc2VsZWN0IEFSQ0hf
SEFTX1ZNX0dFVF9QQUdFX1BST1QNCj4gICAJc2VsZWN0IEhBVkVfQVJDSF9BVURJVFNZU0NBTEwN
Cj4gICAJc2VsZWN0IEFSQ0hfU1VQUE9SVFNfQVRPTUlDX1JNVw0KPiAgIAlzZWxlY3QgQVJDSF9T
VVBQT1JUU19ERUJVR19QQUdFQUxMT0MNCj4gZGlmZiAtLWdpdCBhL2FyY2gvc3BhcmMvaW5jbHVk
ZS9hc20vbW1hbi5oIGIvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9tbWFuLmgNCj4gaW5kZXggMjc0
MjE3ZTdlZDcwLi5hZjljMTBjODNkYzUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvc3BhcmMvaW5jbHVk
ZS9hc20vbW1hbi5oDQo+ICsrKyBiL2FyY2gvc3BhcmMvaW5jbHVkZS9hc20vbW1hbi5oDQo+IEBA
IC00NiwxMiArNDYsNiBAQCBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgc3BhcmNfY2FsY192
bV9wcm90X2JpdHModW5zaWduZWQgbG9uZyBwcm90KQ0KPiAgIAl9DQo+ICAgfQ0KPiAgIA0KPiAt
I2RlZmluZSBhcmNoX3ZtX2dldF9wYWdlX3Byb3Qodm1fZmxhZ3MpIHNwYXJjX3ZtX2dldF9wYWdl
X3Byb3Qodm1fZmxhZ3MpDQo+IC1zdGF0aWMgaW5saW5lIHBncHJvdF90IHNwYXJjX3ZtX2dldF9w
YWdlX3Byb3QodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gLXsNCj4gLQlyZXR1cm4gKHZtX2Zs
YWdzICYgVk1fU1BBUkNfQURJKSA/IF9fcGdwcm90KF9QQUdFX01DRF80VikgOiBfX3BncHJvdCgw
KTsNCj4gLX0NCj4gLQ0KPiAgICNkZWZpbmUgYXJjaF92YWxpZGF0ZV9wcm90KHByb3QsIGFkZHIp
IHNwYXJjX3ZhbGlkYXRlX3Byb3QocHJvdCwgYWRkcikNCj4gICBzdGF0aWMgaW5saW5lIGludCBz
cGFyY192YWxpZGF0ZV9wcm90KHVuc2lnbmVkIGxvbmcgcHJvdCwgdW5zaWduZWQgbG9uZyBhZGRy
KQ0KPiAgIHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvc3BhcmMvbW0vaW5pdF82NC5jIGIvYXJjaC9z
cGFyYy9tbS9pbml0XzY0LmMNCj4gaW5kZXggOGIxOTExNTkxNTgxLi5kY2IxNzc2M2MxZjIgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvc3BhcmMvbW0vaW5pdF82NC5jDQo+ICsrKyBiL2FyY2gvc3BhcmMv
bW0vaW5pdF82NC5jDQo+IEBAIC0zMTg0LDMgKzMxODQsMTYgQEAgdm9pZCBjb3B5X2hpZ2hwYWdl
KHN0cnVjdCBwYWdlICp0bywgc3RydWN0IHBhZ2UgKmZyb20pDQo+ICAgCX0NCj4gICB9DQo+ICAg
RVhQT1JUX1NZTUJPTChjb3B5X2hpZ2hwYWdlKTsNCj4gKw0KPiArc3RhdGljIHBncHJvdF90IHNw
YXJjX3ZtX2dldF9wYWdlX3Byb3QodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gK3sNCj4gKwly
ZXR1cm4gKHZtX2ZsYWdzICYgVk1fU1BBUkNfQURJKSA/IF9fcGdwcm90KF9QQUdFX01DRF80Vikg
OiBfX3BncHJvdCgwKTsNCj4gK30NCj4gKw0KPiArcGdwcm90X3Qgdm1fZ2V0X3BhZ2VfcHJvdCh1
bnNpZ25lZCBsb25nIHZtX2ZsYWdzKQ0KPiArew0KPiArCXJldHVybiBfX3BncHJvdChwZ3Byb3Rf
dmFsKHByb3RlY3Rpb25fbWFwW3ZtX2ZsYWdzICYNCj4gKwkJCShWTV9SRUFEfFZNX1dSSVRFfFZN
X0VYRUN8Vk1fU0hBUkVEKV0pIHwNCj4gKwkJCXBncHJvdF92YWwoc3BhcmNfdm1fZ2V0X3BhZ2Vf
cHJvdCh2bV9mbGFncykpKTsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0wodm1fZ2V0X3BhZ2VfcHJv
dCk7DQoNCg0Kc3BhcmMgaXMgbm93IHRoZSBvbmx5IG9uZSB3aXRoIHR3byBmdW5jdGlvbnMuIFlv
dSBjYW4gbW9zdCBsaWtlbHkgZG8gDQpsaWtlIHlvdSBkaWQgZm9yIEFSTSBhbmQgUE9XRVJQQzog
bWVyZ2UgaW50byBhIHNpbmdsZSBmdW5jdGlvbjoNCg0KcGdwcm90X3Qgdm1fZ2V0X3BhZ2VfcHJv
dCh1bnNpZ25lZCBsb25nIHZtX2ZsYWdzKQ0Kew0KCXVuc2lnbmVkIGxvbmcgcHJvdCA9IHBncHJv
dF92YWwocHJvdGVjdGlvbl9tYXBbdm1fZmxhZ3MgJg0KCQkoVk1fUkVBRHxWTV9XUklURXxWTV9F
WEVDfFZNX1NIQVJFRCldKTsNCg0KCWlmICh2bV9mbGFncyAmIFZNX1NQQVJDX0FESSkNCgkJcHJv
dCB8PSBfUEFHRV9NQ0RfNFY7DQoNCglyZXR1cm4gX19wZ3Byb3QocHJvdCk7DQp9DQpFWFBPUlRf
U1lNQk9MKHZtX2dldF9wYWdlX3Byb3QpOw==
