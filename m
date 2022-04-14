Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81BC50060C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Apr 2022 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiDNG0a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Apr 2022 02:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiDNG03 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Apr 2022 02:26:29 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90083.outbound.protection.outlook.com [40.107.9.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897D61EECB;
        Wed, 13 Apr 2022 23:24:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nckg6XjeitXbFVjYjdhi80iot8cM8EbI0SE7xhF1sfLdVmjB9SuXfwW6vZs36HwNSa3s4QNTI024KZGlX3PY46Z/srdSVU1fbN9r+rK512TqcwSPDMHo2S0SruPMGFs6sddYDAEyiiHDMrjEi2OPrQv5bL+uKW5tQKlMlT0b5SQmL2IEO/6wAnOlzy5++yyF4jOgyxdvMydDUdRQe8KFywVCqqLXS5GoqUWUICWi1fL4A91mrmS+n9NKj6tT8L3VynlDoW2BlPUrwVjzy8FOtTCIscd4+Oqer2/34vAR8UMcRWczCQJkLR0ONon5pxDIeNlkXi4J4ljVW/2WbKKK+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMspl9goQOsd1Y1U8A8K0H5Uvjjije1QNg2suE/jlN4=;
 b=Lw/IWte6nfLXRq/n1O1lBXYazvzmSGUDvqp0WFJ7KKkhbGPIjFpxPDT+TowuqmKjEAnuKcdj0Fo/nQntk1gu4p1wIKDa14Nl1YbCUrwxBN5aJ34OKpiusoN/smIackknLdnU4BK5mWlWRyfar0bDZdc43EiC6KaDmLEXAJs9lpuBGYF4d70gGAxspgNUtfGPI4l+xWWhy1dlwXyROCM4jJfzMZm8snYUac/FA5i30c1M3dZYTEdEloAoNWchcSkVklB3Xo6OehbBy26uv3PHoWFP37rCd/P71PAGKTJPDnvugyF0sFy7Lx17TSEoNn4AUIHIE79xfrx37F9pJi8Hqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2454.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 06:24:00 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%8]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 06:24:00 +0000
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
Subject: Re: [PATCH V7 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Topic: [PATCH V7 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Index: AQHYT8fejEKbxTKHc0Sq1urAeYFQYKzu8OIA
Date:   Thu, 14 Apr 2022 06:23:59 +0000
Message-ID: <64e04efb-3689-5652-07f5-e04d2915294a@csgroup.eu>
References: <20220414062125.609297-1-anshuman.khandual@arm.com>
 <20220414062125.609297-5-anshuman.khandual@arm.com>
In-Reply-To: <20220414062125.609297-5-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54ca89d8-9d3a-46d2-9a00-08da1ddf5ce9
x-ms-traffictypediagnostic: PR0P264MB2454:EE_
x-microsoft-antispam-prvs: <PR0P264MB245422D80CC6B45D425D06C6EDEF9@PR0P264MB2454.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GRb7p+p1X89EueYGiGLlmHTi+seUGngqjTKN3sQydmeNyV5pMM14SJehFPDCpHogGtLE1fmsSdqgzFcUWx6usjoBhGt66gq68v+K6SL82jCcDOZoSI/Y2i7/4+VQ67xaFgMv3Ks+M/4KFye60F4Pvi7XDMmL1AfMpRlIpeVLmLxHL+9k2jdSRvuK2sr29qd9wYxig0CCf/FJY4km917Ozj0k5P4sWlbCmMit5B6fouiGxzrltw8PUZ5uVULeRzJKjAiupB3PdqxMSmApS/oMrxR4+9eb2oRrxsDFh8fvjfFYHxlEZyQl/UrlgSM6EW3KruODEQhiVUSHHHI+XVXbGysFyTCpLDJVIabKX6Q3CjgF+18AjK5jYmyWf4hM1tp4fiu1znrEoyvQa/1Hfy4TSwnb2OdtvT+FyMn1TIUyWaPnqZTdPbAM2phNK+/czeQVfrvJj4BsW9RoaCuh/t4APWn4CrTIUZZnHNKzumCmQVVGqSXSHN1RxvJMtGweTkcAWCwC7KdCzweNDiT5WsLKz7xeIw+OdigWdUx/EkqnEMSdTRUtiCnhTqVoiIgR55YBG6Jxo/iClCqb1WiFA+I9EX84BQpy5JUfuuQ/A7wmdetyukAm3cG1rMVRw+fa4WeyA+T0ZNWHFoMSzdonUXW03sxALR5sK9adO94/pg10/izazSEMe6zEQy2tLkIK3KD5giUoxvmxVUqOlrPjQcGfyFRnXzaN6RwK/GXdYih6v4V7/ZV6oieb4ceG1GSH0N/GPDjGCWQn4c6MTSdf+ZOc8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(66946007)(86362001)(64756008)(54906003)(66556008)(66476007)(91956017)(110136005)(66446008)(44832011)(76116006)(83380400001)(38100700002)(122000001)(316002)(6512007)(6506007)(71200400001)(4326008)(38070700005)(31696002)(8676002)(2616005)(8936002)(2906002)(36756003)(31686004)(66574015)(5660300002)(26005)(186003)(7416002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d213MVpFUnNTNExlc0lySXFpWkJqT3lmc25aOGN3Z0NFNXViZUs4M2VNbmJp?=
 =?utf-8?B?dndSM3o4bDRndFlxOTlFQ0lUN2NiNGpjVFR2NVo1bGMyZksyTGNDeDNIUzJT?=
 =?utf-8?B?azFnekFsNHNlbm1lQnN4L2J5Wlp1STFuRmloN3ZZRHQ2Y2V4UXZPaDArNy9t?=
 =?utf-8?B?QmU1dGlDdnlhWkhkVkFPSWVkcjFMWkd1MHNzbGUwT0Y3MFl5TEFpRFNZL0tm?=
 =?utf-8?B?Y2lvYk9EV3FyRzYvM3BrTTBwNlVLYVlTbER0dkduUSswcXJCMjlScjMvUVBU?=
 =?utf-8?B?c2RobHcyWFZxRnlHb2VoYlppTklaNXh5UEI0WVpoUnRITUV4WUJmcmRpQVRs?=
 =?utf-8?B?dFdBbjcwOGpKcDRmTXFrYk56SDhmMStvRFF5MUZMc0QxbStWUTVPM2I4cUR6?=
 =?utf-8?B?bG93NE1weTVTSEMxZ1Z3dXVURGdlZkpobmRTWnNoallJcXlZVloxZWcxd2kr?=
 =?utf-8?B?MjRGMkF4R0pxcS9LcjZCeWE1MDBJNENEaXFkVDNaMEpJaUVsalZpeFhWazRS?=
 =?utf-8?B?N1djdnVJSFJLRndTaXhCL0dZTnM4R1RGSHptSDBkeDNBOHFEZ1BZQkcycElN?=
 =?utf-8?B?MFdxN2FMQnNMYjc2UDJTV1RBZWdLRzNJQjNrUGxPVi83ZUgzWVBOemVLVjYz?=
 =?utf-8?B?U1NnWWNIY2k0b25sLzAzY05HT0NQSUVxMmw3dnhobWtMWVdodHZGT2w4cXg4?=
 =?utf-8?B?SGZMd09IMTZkclRKR3pEWmE4d21RSkZwbldtWW5SUnMyOFJFQzFUUm4zMFR6?=
 =?utf-8?B?aXZVamVNSUdSZHpMcjJpU2s1czQ1dDcyelVNZVFFN1VFNzBqaEJhd2hKSXBw?=
 =?utf-8?B?N2ZocmN0aHVnOTN6ZzJmYkxlei93L3lPdENiZVZuNjA5QmxnSU5JREhWaDRv?=
 =?utf-8?B?cGVyMFFjaTdWdnZWTXlWYlNqSmhGTERXcURrbnNtYmRObmxXcGhBYjh3Zzlv?=
 =?utf-8?B?WXBVSldNcGM0MlJ0cVJxTGF1WnpPd0daQjd4MmpmNXFFQ3h1S3h0bDJQcEVw?=
 =?utf-8?B?dzY5VGRvQWN2d2Y2d1BlMmtqNTlsVklCMDZIQzZYSmxBM1NNTHVDdmJQSnM4?=
 =?utf-8?B?RTZYZXhJOHMxS3ZVZkgydFplRy9hcHM0MktHckgvNzh1cWdRQWE0MlFrRDdT?=
 =?utf-8?B?Ly92K09DSWVjVllFZjlGaHJoTWo5V01NbTFyYXdoUTFjeEI0am9xTU1DQytl?=
 =?utf-8?B?L3luQVlQUGRZZzFsSUlVWERmb1FhRWpKanI2WmZxcnhpQ21SUGRsQmZEYUVP?=
 =?utf-8?B?dGVOaUpiTzV1YXd0UWJuL1Nkek5KYlpsZVlueWhrWmw5UkpWMndBUEdiMnJu?=
 =?utf-8?B?cUgvTUxCaDRGUnhhY24ralp5M1N1N01PdWlGMWZsRnhPcmVXb2hmNThsbm5k?=
 =?utf-8?B?Qkl6WGpjR0lMLzh5b2Y5ZVk0OGQ4OWZTTWxvaTR3U25uRWliaWdnWHJZNXlD?=
 =?utf-8?B?SzFDMWwxSXFiRno5SVg1dXZIZzlZckh6Vjg4K0dXaUNId24yTXQyVmtldFRr?=
 =?utf-8?B?NFVpMkErRUE0ZXFvQ2IyTkg2aThUaFE5TVdzRE1zbnZjVUNsaWJUbmlzYTFx?=
 =?utf-8?B?RkxLd0hUTEUyaFdvSEFUdDBLeDhpUXVTNmUxbXZ5Mi9YWk45Y3hPUDl1K1Rr?=
 =?utf-8?B?ZDhRdW1vN3AwVWJoQUo5WGYwM1RER0kzblRkMVNPb2JaSXQ0cTZzb3BXaGIv?=
 =?utf-8?B?ZEZ0WlA0MnppY0dhdjA5M0IyTmx5M0pkTDRnbzY4VXdHaGVhdlQrYytjZmhi?=
 =?utf-8?B?L05XTXdTZHp4bTIvWmlRSUk4azFzdWt0Qm1OazkvYUQ0R2RvOFZjWTJ0R2xE?=
 =?utf-8?B?ekh3NHZPZUU2STBGOFVUUTNSemZjMW9GQ1RtTmo1RGJjem95R2NmeUhaNFFh?=
 =?utf-8?B?NUZ3clR6REl3azdZRG9MMTJvRHRvbVNwRmFuMnJXM3pDNUQvVHQ2VDFWZ3NM?=
 =?utf-8?B?L3c5VnR3TmRjZW10U3A5aW1ySDUwZmlLSlYwQmFZL0NnMitiSzNWUXJEMW0y?=
 =?utf-8?B?c3hGdVhoVUZTb2NHVTBqbU1jMHJWaU9raXBFTCtTUmJCcGN3aUYzM1N1ZTY4?=
 =?utf-8?B?ZE93SGtGMU5Wb01nQ0ZuNmdiVkE1VEJxZHVVMFkzVWJuYXJkUUhuZFI4dGJQ?=
 =?utf-8?B?NVhaTjluRFpnejAxV0tYS2xZUHVCUFlLd29qelc5b3ZncGs5OFFTOU0xeGRP?=
 =?utf-8?B?WTBZcGgxVWJlR2R1TXQ2S0NmZTN0TkRTSHhyWW1CODd0MzNZTEFyOUd5dW00?=
 =?utf-8?B?YWp5bS9FR25yd3QyWnlxUlZVK0JrUzNFcklZNUtGcGRLUUEra0ZWbThZOFhZ?=
 =?utf-8?B?NXhGUWJuR2dqa2pmeGNwOFpZS013WXhtSjlFZ1lNRGJHbll6K2E3M0d1OW5J?=
 =?utf-8?Q?TEFRZVChWsOXuuYCpYaYBg48fgVM58BqUIABm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <916013C7A6ABDD4F9F58F9CD1FC9F170@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ca89d8-9d3a-46d2-9a00-08da1ddf5ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 06:23:59.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJjbaqwErMz5hDgKxD0iqoqY00Ugr29efnCaf7bLEq8O9xIRCr7C2VMJeru9g+JTevXTh/H1SjderkT0ZHXfgzTX1/VXAqadOaFeutkRn/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2454
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE0LzA0LzIwMjIgw6AgMDg6MjEsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFRoaXMgZGVmaW5lcyBhbmQgZXhwb3J0cyBhIHBsYXRmb3JtIHNwZWNpZmljIGN1c3RvbSB2
bV9nZXRfcGFnZV9wcm90KCkgdmlhDQo+IHN1YnNjcmliaW5nIEFSQ0hfSEFTX1ZNX0dFVF9QQUdF
X1BST1QuIEl0IGxvY2FsaXplcyBhcmNoX3ZtX2dldF9wYWdlX3Byb3QoKQ0KPiBhcyBzcGFyY192
bV9nZXRfcGFnZV9wcm90KCkgYW5kIG1vdmVzIG5lYXIgdm1fZ2V0X3BhZ2VfcHJvdCgpLg0KPiAN
Cj4gQ2M6ICJEYXZpZCBTLiBNaWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBDYzogS2hh
bGlkIEF6aXogPGtoYWxpZC5heml6QG9yYWNsZS5jb20+DQo+IENjOiBzcGFyY2xpbnV4QHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBBY2tlZC1i
eTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBSZXZpZXdlZC1ieTog
S2hhbGlkIEF6aXogPGtoYWxpZC5heml6QG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFu
c2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPg0KDQpSZXZpZXdlZC1i
eTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KDQo+IC0t
LQ0KPiAgIGFyY2gvc3BhcmMvS2NvbmZpZyAgICAgICAgICAgIHwgIDEgKw0KPiAgIGFyY2gvc3Bh
cmMvaW5jbHVkZS9hc20vbW1hbi5oIHwgIDYgLS0tLS0tDQo+ICAgYXJjaC9zcGFyYy9tbS9pbml0
XzY0LmMgICAgICAgfCAxMiArKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5nZWQsIDEzIGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9zcGFy
Yy9LY29uZmlnIGIvYXJjaC9zcGFyYy9LY29uZmlnDQo+IGluZGV4IDkyMDBiYzA0NzAxYy4uODVi
NTczNjQzYWY2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3NwYXJjL0tjb25maWcNCj4gKysrIGIvYXJj
aC9zcGFyYy9LY29uZmlnDQo+IEBAIC04NCw2ICs4NCw3IEBAIGNvbmZpZyBTUEFSQzY0DQo+ICAg
CXNlbGVjdCBQRVJGX1VTRV9WTUFMTE9DDQo+ICAgCXNlbGVjdCBBUkNIX0hBVkVfTk1JX1NBRkVf
Q01QWENIRw0KPiAgIAlzZWxlY3QgSEFWRV9DX1JFQ09SRE1DT1VOVA0KPiArCXNlbGVjdCBBUkNI
X0hBU19WTV9HRVRfUEFHRV9QUk9UDQo+ICAgCXNlbGVjdCBIQVZFX0FSQ0hfQVVESVRTWVNDQUxM
DQo+ICAgCXNlbGVjdCBBUkNIX1NVUFBPUlRTX0FUT01JQ19STVcNCj4gICAJc2VsZWN0IEFSQ0hf
U1VQUE9SVFNfREVCVUdfUEFHRUFMTE9DDQo+IGRpZmYgLS1naXQgYS9hcmNoL3NwYXJjL2luY2x1
ZGUvYXNtL21tYW4uaCBiL2FyY2gvc3BhcmMvaW5jbHVkZS9hc20vbW1hbi5oDQo+IGluZGV4IDI3
NDIxN2U3ZWQ3MC4uYWY5YzEwYzgzZGM1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3NwYXJjL2luY2x1
ZGUvYXNtL21tYW4uaA0KPiArKysgYi9hcmNoL3NwYXJjL2luY2x1ZGUvYXNtL21tYW4uaA0KPiBA
QCAtNDYsMTIgKzQ2LDYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHNwYXJjX2NhbGNf
dm1fcHJvdF9iaXRzKHVuc2lnbmVkIGxvbmcgcHJvdCkNCj4gICAJfQ0KPiAgIH0NCj4gICANCj4g
LSNkZWZpbmUgYXJjaF92bV9nZXRfcGFnZV9wcm90KHZtX2ZsYWdzKSBzcGFyY192bV9nZXRfcGFn
ZV9wcm90KHZtX2ZsYWdzKQ0KPiAtc3RhdGljIGlubGluZSBwZ3Byb3RfdCBzcGFyY192bV9nZXRf
cGFnZV9wcm90KHVuc2lnbmVkIGxvbmcgdm1fZmxhZ3MpDQo+IC17DQo+IC0JcmV0dXJuICh2bV9m
bGFncyAmIFZNX1NQQVJDX0FESSkgPyBfX3BncHJvdChfUEFHRV9NQ0RfNFYpIDogX19wZ3Byb3Qo
MCk7DQo+IC19DQo+IC0NCj4gICAjZGVmaW5lIGFyY2hfdmFsaWRhdGVfcHJvdChwcm90LCBhZGRy
KSBzcGFyY192YWxpZGF0ZV9wcm90KHByb3QsIGFkZHIpDQo+ICAgc3RhdGljIGlubGluZSBpbnQg
c3BhcmNfdmFsaWRhdGVfcHJvdCh1bnNpZ25lZCBsb25nIHByb3QsIHVuc2lnbmVkIGxvbmcgYWRk
cikNCj4gICB7DQo+IGRpZmYgLS1naXQgYS9hcmNoL3NwYXJjL21tL2luaXRfNjQuYyBiL2FyY2gv
c3BhcmMvbW0vaW5pdF82NC5jDQo+IGluZGV4IDhiMTkxMTU5MTU4MS4uZjYxNzRkZjJkNWFmIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL3NwYXJjL21tL2luaXRfNjQuYw0KPiArKysgYi9hcmNoL3NwYXJj
L21tL2luaXRfNjQuYw0KPiBAQCAtMzE4NCwzICszMTg0LDE1IEBAIHZvaWQgY29weV9oaWdocGFn
ZShzdHJ1Y3QgcGFnZSAqdG8sIHN0cnVjdCBwYWdlICpmcm9tKQ0KPiAgIAl9DQo+ICAgfQ0KPiAg
IEVYUE9SVF9TWU1CT0woY29weV9oaWdocGFnZSk7DQo+ICsNCj4gK3BncHJvdF90IHZtX2dldF9w
YWdlX3Byb3QodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gK3sNCj4gKwl1bnNpZ25lZCBsb25n
IHByb3QgPSBwZ3Byb3RfdmFsKHByb3RlY3Rpb25fbWFwW3ZtX2ZsYWdzICYNCj4gKwkJCQkJKFZN
X1JFQUR8Vk1fV1JJVEV8Vk1fRVhFQ3xWTV9TSEFSRUQpXSk7DQo+ICsNCj4gKwlpZiAodm1fZmxh
Z3MgJiBWTV9TUEFSQ19BREkpDQo+ICsJCXByb3QgfD0gX1BBR0VfTUNEXzRWOw0KPiArDQo+ICsJ
cmV0dXJuIF9fcGdwcm90KHByb3QpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTCh2bV9nZXRfcGFn
ZV9wcm90KTs=
