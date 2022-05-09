Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830A351F435
	for <lists+linux-arch@lfdr.de>; Mon,  9 May 2022 08:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiEIF7a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 May 2022 01:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiEIFvZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2022 01:51:25 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120049.outbound.protection.outlook.com [40.107.12.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0039013F1DC;
        Sun,  8 May 2022 22:47:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQhFau0SwrgAHIcmtaOwyxjMc7uN5VuUQxrsaXaB/15AWjNnK6BWEjPEJUSaPNSBefcw3hRuT0dgMCXvZ9g7mCl4tlgc9+iW/pCqIp6xqmQVTxTad/XQSIQQpzZE5KiLGyCvOr3gx3C4RbsX2vzT+Qdi0bEmTZYySZZhYrD4mkTUZvfS0FkWNuLZG8ifP+hRjHKNaEIHHuHnxbxGMVdZPIJZoc5LfFdDieMH75bNx6HLKQlAfE95q/8hySqnsObB373NA+1mwhYF1fFscztb93o+3aflfxFhxMRtaJFalPL3EdlDPGb188++zrIdEPztVnU2ppFLs1tdWk/BnFV1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Pbvy5dIPWBGJ6kM3iHxkkQRy+MKOcO66JJiaSEXZzo=;
 b=B+ib5FtrZLXWXVV9O6EF503VzPz/cwN0zVKbdrhxc6b3EsXtzp0DcBxgWoSYJAvluTC/PBOoj6DpNkDDYLLPfTTbXzejN5oW4n9qF1DTFmesUdSQGPSnhpPzenhrpraFNCP9gKJERRGILR4RPvfh83nY7fANnR+/kxhTjY6W4REVl2ymYuN5JuIqdmfUnQtJV/rj29b3xZ4yDJYDHkaHheXIj778XfehxfHxVa1x98hWC1YBEL8sBr/paLRHrBxaYFguqfkvLoV2Clu8vhRzB1hVCeCRCGKH2OQbuUTiyFOD9Y/v1j02IKg0izv2VHsN3j4L7Mj0lFEprSFJq/ZxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB2277.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 05:46:03 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad4e:c157:e9ac:385d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::ad4e:c157:e9ac:385d%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 05:46:03 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Muchun Song <songmuchun@bytedance.com>
CC:     "dalias@libc.org" <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "deller@gmx.de" <deller@gmx.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "svens@linux.ibm.com" <svens@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2 1/3] mm: change huge_ptep_clear_flush() to return the
 original pte
Thread-Topic: [PATCH v2 1/3] mm: change huge_ptep_clear_flush() to return the
 original pte
Thread-Index: AQHYYr9IzdY/UNkDFUyCEcmwVx+NYq0U9FUAgAEWTgA=
Date:   Mon, 9 May 2022 05:46:03 +0000
Message-ID: <d5055b48-d722-e03d-fc32-16fd76e3fa22@csgroup.eu>
References: <cover.1652002221.git.baolin.wang@linux.alibaba.com>
 <012a484019e7ad77c39deab0af52a6755d8438c8.1652002221.git.baolin.wang@linux.alibaba.com>
 <Ynek+b3k6PVN3x7J@FVFYT0MHHV2J.usts.net>
 <bf627d1a-42f8-77f3-6ac2-67edde2feb8a@linux.alibaba.com>
In-Reply-To: <bf627d1a-42f8-77f3-6ac2-67edde2feb8a@linux.alibaba.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09cfb994-b131-4cb5-435f-08da317f3436
x-ms-traffictypediagnostic: PR1P264MB2277:EE_
x-microsoft-antispam-prvs: <PR1P264MB22774FF0049DBE8221DF5FBAEDC69@PR1P264MB2277.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7GnWxlTXi5kxcEo3QAB6Pmansvb6Fogbv+ztTujiGoYTCCwtxtZ+I0l9MPuwa+bxrgZv4nic6RAyCojGTvXLeZFya/noD1z1zojjf3nvOMO48PM3K7RAWd9iEM20+k7A46nai65xcvl2TJOvTvzC/bB013VDEWbtwgUDPqlZgjCVxmNrGoHIq3G0rerSDwSahy4ZZGZIk013IkCr2xo7mmKuSwPJty3I/rlpIuZv9vrj8kXMxwFbdbo+RlZUQLkCYfNNjqGz/H9lYyOr4HhAHX9XjJ01TxDX/zn36vWazwf5gIigeIRUHUxTEPH3CN2CDhDR6ImqLXrh3yL0vS8pXSEaP26rHaF5oVyqU4jN7Y5yIjYQIiy2zPnMpEdVSkHOB4rwHp5mbfAF7/x2zKtExwYHhiScqSN+uKwEeo9h35GgLwpqUWAojKxTJ+J0V1Nwk5NNk/gTUjohQhycxMzGSd4qdlJGPMtju4gNt8DXhKUvpkqIyCcuCh7J2K0nzqLwIvDEaTZ/TlKeNCFfJ7qb8rUusKN8zCxyUMphebrToa/7wM8SK5EAOPv8gA4SbybTEwnK/HLM6mvpHxQosNaPq8EbfsFq5Ol1d4Dj3Q4I7Shleuw6SpU9oYyszzBciIdBALIkTzYaIInCgDyJ9mOF1Mycm/y/cS07BjgvwGiF8iqLJ20dis75iq5o7tJbG/4lindiimOIH188tjkCZjNXlGx3h/EveSC1I8S02oqredDOk8d+9RHiuCCkl2uEaX0EQg8GyMgWruD2I1LPHCFM7sB+tGWvH2CwsSPV02w4B+b/JLCPBB3NOW4vOjx3rOsGU+7k10iPZkL7aLoi7BZuNYtZsILc37Sr5mEWiPyWEhY4RZZtx8Il6IfviwlixC5J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(6512007)(26005)(2616005)(122000001)(66574015)(38100700002)(31686004)(64756008)(36756003)(8676002)(66446008)(4326008)(66556008)(186003)(110136005)(316002)(91956017)(76116006)(54906003)(66946007)(66476007)(53546011)(508600001)(5660300002)(71200400001)(2906002)(86362001)(6506007)(966005)(31696002)(7406005)(8936002)(6486002)(7416002)(83380400001)(44832011)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW9yRm05YlBhb25lSEFhNnU0VUo5bGxhMlpCNUpKZmNCUmcweEhuQlNneS8z?=
 =?utf-8?B?YzkxWk5WbWhWYlBoUVN0SDNscnQ2RGdrOXdqbDFMUDh4WHFEQ0V1Z1o0WUxF?=
 =?utf-8?B?bmZWMHJGV3VKNVMyNFBRMlhlT3k5Q01mRFJOMlp6NjVLMDJzNk1vMHJEcTlW?=
 =?utf-8?B?UDJKcWdQanhWUG5oamJvS01XeUJQbmluWmIxT1dPMW4zdldIdHVaS1haRm5I?=
 =?utf-8?B?bkM3azl4Ty9YOTRnUDhaYnJQb29BL1RVaTgza0U0dGZVaEFnUWd5Rm1vQngy?=
 =?utf-8?B?dWRxZXBReTEwUW1tbjZlK2dlOGFYVzZjeGl4cVl5S0x4akdId1M0ckhXSGpx?=
 =?utf-8?B?MHNNYXc4d293RmI2eHpNTEhTSmRISWwvMDVOTGtvUlFXZzhJenU4aXowYnZO?=
 =?utf-8?B?S3dJbjY5OW9DMDkzQU80bkFuWXJjcmNSRGI1R3dGYVpndFV2cnF1YWVFUzB3?=
 =?utf-8?B?UlF4VWJQQVIrZlprbEp1Z3hRRy9KRytzbzFma1BOTjdmQzVGa0NTci85QU40?=
 =?utf-8?B?R2J0eHY0aUZsS0dkQ1F1dUpqTXlXbXRqQmJWYlBLK1l0b1BKeEpvekl2V0ZB?=
 =?utf-8?B?L2JZT0xZVzgzKzE4QmR0cCtJV0FKL1VlRzJYeGJVRHZrdDhScVNVemJwN1J1?=
 =?utf-8?B?VEpmV0tXOUhCSXZSMnlVY3NWcGlVbjF1LzJGOVRkZFo1WUFzazVuQysxRGU1?=
 =?utf-8?B?OEtWQllRdkk3VlMyeHFsNmpaeHNGWUsrbHdFSWtLcFIvMjlIRHpsMlJKWmF6?=
 =?utf-8?B?eXRmejI2RmIvL0xNMFdBMTZBRHpERzRWbVM4Z3ZwK09YMUpjMVB0STVyNTE1?=
 =?utf-8?B?aEJwRFNNb3BWV3VOYUJDR0d2SUhtQWMzblhQc2htb0F5aHB1V05JcGFMT09Y?=
 =?utf-8?B?RkprM0tCY2NkSmx2VU9QN1pDUWFDUGJ3ZnVWWTlManh5dlZ5Sk9yejBwdnpX?=
 =?utf-8?B?WThnRmlOUG5MMGx2ejNtd1pSNFVzQldUWjlHOXZZcXJZUmtHVnFXRUU4K0xY?=
 =?utf-8?B?aitWTzRwbWpKUnZkd2FadXljMldNczhtZ0E4Qk9EQzN4dG9DcW5yM1FCUFg4?=
 =?utf-8?B?V29GLzltOURDalJVRG51L2ltbGpXSllJcCtzZ09YMnQ2V3huUGpCRlVLeXg3?=
 =?utf-8?B?QjBEcVdHdnhkOXIrOXNuZUU4dkNINk9YZFY0TmRLMm9zTFJKT1dYcDlYWjNX?=
 =?utf-8?B?TklnNHBrcFNnOEZYRyt6Q2YrNDMrVHlVOFVXSDdEdVhYWnl6VzIvTEVXSkJx?=
 =?utf-8?B?dmd2ZG5UZXJWMVQrQUJib29RSjBneVdYbXEvdm5mVGFtMVlDY0sva3B1SWFp?=
 =?utf-8?B?ZkxvMW1HM0xKVGc4bm95WUZPem9ZRXRHQlRYTjg4VVRUK25sWjB0ZitQQ0Mv?=
 =?utf-8?B?bDA3VUpoTy9BNGJmSS9lRXdETWtxSmMweGo2WHVTeDRsdnVqN1ZlN1k2SUg2?=
 =?utf-8?B?bmlXek45ZWxNKzRpai9URWRONGtWc0RHNXg1Q3dPeWovOEdPV1RKU1ViZzhL?=
 =?utf-8?B?MVkvNVVUYitjR01nTmhjNks5YjdtZUlZeDFBbmhjRC8rWE5KcXo0bGl0ZjNS?=
 =?utf-8?B?YkVwMXI1eUJ5THFHZ2k3Rks0NmthalMyb1pXREJEekhSbjdjK0E1WC8yUXRu?=
 =?utf-8?B?em1Ja0xLcEllR0JNQ2hpMHQxR1hqOWlqeXBJV1BjUHI0N01wVnMzdmNNekNJ?=
 =?utf-8?B?d3hsRGdVekxhQmxuWkpCTTA0NGVzbkdvSFV1RER6MTdGVWZtTThmSURHR1pu?=
 =?utf-8?B?OTcrVkU3eVozQUdMendoSFk1WURMa0N3VHJrSEhoc2dKekw0dDdpb1RTczUw?=
 =?utf-8?B?TzJQb2tEenhaZm9Tams4RmJ4R2NRbXR4QjBraW0wRFNhby9aMWJVQlY5VVdl?=
 =?utf-8?B?MUd0dHNXUVZ3bU0xNkdiWGxNU3h2VW04RHcrdlZScXA0UlJTMmsxb0RaWTVX?=
 =?utf-8?B?ZmtIOTFFU2pQcHFyNktqYm8vcDJ6RlZmVmd2V0R0YTM5ekErellmMkUwalM5?=
 =?utf-8?B?US9WeWl1bkJBT242cjdYTGdOcDN5K2NFWFcwS1RPZU93VUhZL2h0TUc2VENR?=
 =?utf-8?B?VlVhNWczOGg1VjE1Y01wbXNtekNSQjk0UlVYWDY2SXQ0UnEzYk13RU13Szk3?=
 =?utf-8?B?VzBnY0M1ZDJTdXMzK25jM0VyN2pCL2EwbWJMc1l5THE4TzFCS1d0V2ROUkRL?=
 =?utf-8?B?V0NkeklGOXZXTEpGWmx6R21hTjJLS2lzWVBablBOaEFUMlZ5K2J5dTEzT3J0?=
 =?utf-8?B?NXdlcHREclZPVDc3RTArMjRTelBBQ0RiUndYeHFHZ2RUeDBJUmZETTVwNGdK?=
 =?utf-8?B?NjRWNWpWY3ZTSS9OYTFoaC9KZnRhY294Ym15dFY2cFlzS1l5MkZLemo2V1Ux?=
 =?utf-8?Q?nv4aKT8EswJt36T3eNUZdBXIzhud3qJlk9vy7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE7D7F41D32A944F802D4091ACBCCE5E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cfb994-b131-4cb5-435f-08da317f3436
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 05:46:03.2769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXZWYOS/hcbjwxX5HShFUmZzOpb0FKKLQOgptGtGHg1igZl9+1ZVVZH2qvDeBL37kuI52CHBoOmA7hGfKzp7i2w4SI9IJ2yVnH0jiM4YkDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB2277
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDA4LzA1LzIwMjIgw6AgMTU6MDksIEJhb2xpbiBXYW5nIGEgw6ljcml0wqA6DQo+IA0K
PiANCj4gT24gNS84LzIwMjIgNzowOSBQTSwgTXVjaHVuIFNvbmcgd3JvdGU6DQo+PiBPbiBTdW4s
IE1heSAwOCwgMjAyMiBhdCAwNTozNjozOVBNICswODAwLCBCYW9saW4gV2FuZyB3cm90ZToNCj4+
PiBJdCBpcyBpbmNvcnJlY3QgdG8gdXNlIHB0ZXBfY2xlYXJfZmx1c2goKSB0byBudWtlIGEgaHVn
ZXRsYiBwYWdlDQo+Pj4gdGFibGUgd2hlbiB1bm1hcHBpbmcgb3IgbWlncmF0aW5nIGEgaHVnZXRs
YiBwYWdlLCBhbmQgd2lsbCBjaGFuZ2UNCj4+PiB0byB1c2UgaHVnZV9wdGVwX2NsZWFyX2ZsdXNo
KCkgaW5zdGVhZCBpbiB0aGUgZm9sbG93aW5nIHBhdGNoZXMuDQo+Pj4NCj4+PiBTbyB0aGlzIGlz
IGEgcHJlcGFyYXRpb24gcGF0Y2gsIHdoaWNoIGNoYW5nZXMgdGhlIA0KPj4+IGh1Z2VfcHRlcF9j
bGVhcl9mbHVzaCgpDQo+Pj4gdG8gcmV0dXJuIHRoZSBvcmlnaW5hbCBwdGUgdG8gaGVscCB0byBu
dWtlIGEgaHVnZXRsYiBwYWdlIHRhYmxlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQmFvbGlu
IFdhbmcgPGJhb2xpbi53YW5nQGxpbnV4LmFsaWJhYmEuY29tPg0KPj4+IEFja2VkLWJ5OiBNaWtl
IEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFjbGUuY29tPg0KPj4NCj4+IFJldmlld2VkLWJ5OiBN
dWNodW4gU29uZyA8c29uZ211Y2h1bkBieXRlZGFuY2UuY29tPg0KPiANCj4gVGhhbmtzIGZvciBy
ZXZpZXdpbmcuDQo+IA0KPj4NCj4+IEJ1dCBvbmUgbml0IGJlbG93Og0KPj4NCj4+IFsuLi5dDQo+
Pj4gZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYw0KPj4+IGluZGV4IDg2
MDVkN2UuLjYxYTIxYWYgMTAwNjQ0DQo+Pj4gLS0tIGEvbW0vaHVnZXRsYi5jDQo+Pj4gKysrIGIv
bW0vaHVnZXRsYi5jDQo+Pj4gQEAgLTUzNDIsNyArNTM0Miw3IEBAIHN0YXRpYyB2bV9mYXVsdF90
IGh1Z2V0bGJfd3Aoc3RydWN0IG1tX3N0cnVjdCANCj4+PiAqbW0sIHN0cnVjdCB2bV9hcmVhX3N0
cnVjdCAqdm1hLA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBDbGVhckhQYWdlUmVzdG9yZVJlc2Vy
dmUobmV3X3BhZ2UpOw0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBCcmVhayBDT1cgb3IgdW5z
aGFyZSAqLw0KPj4+IC3CoMKgwqDCoMKgwqDCoCBodWdlX3B0ZXBfY2xlYXJfZmx1c2godm1hLCBo
YWRkciwgcHRlcCk7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgICh2b2lkKWh1Z2VfcHRlcF9jbGVhcl9m
bHVzaCh2bWEsIGhhZGRyLCBwdGVwKTsNCj4+DQo+PiBXaHkgYWRkIGEgIih2b2lkKSIgaGVyZT8g
SXMgdGhlcmUgYW55IHdhcm5pbmcgaWYgbm8gIih2b2lkKSI/DQo+PiBJSVVDLCBJIHRoaW5rIHdl
IGNhbiByZW1vdmUgdGhpcywgcmlnaHQ/DQo+IA0KPiBJIGRpZCBub3QgbWVldCBhbnkgd2Fybmlu
ZyB3aXRob3V0IHRoZSBjYXN0aW5nLCBidXQgdGhpcyBpcyBwZXIgTWlrZSdzIA0KPiBjb21tZW50
WzFdIHRvIG1ha2UgdGhlIGNvZGUgY29uc2lzdGVudCB3aXRoIG90aGVyIGZ1bmN0aW9ucyBjYXN0
aW5nIHRvIA0KPiB2b2lkIHR5cGUgZXhwbGljaXRseSBpbiBodWdldGxiLmMgZmlsZS4NCj4gDQo+
IFsxXSANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzQ5NWM0ZWJlLWE1YjQtYWZiNi00
Y2IwLTk1NmMxYjE4ZDBjY0BvcmFjbGUuY29tLyANCj4gDQoNCkFzIGZhciBhcyBJIHVuZGVyc3Rh
bmQsIE1pa2Ugc2FpZCB0aGF0IHlvdSBzaG91bGQgYmUgYWNjb21wYWduaWVkIHdpdGggYSANCmJp
ZyBmYXQgY29tbWVudCBleHBsYWluaW5nIHdoeSB3ZSBpZ25vcmUgdGhlIHJldHVybmVkIHZhbHVl
IGZyb20gDQpodWdlX3B0ZXBfY2xlYXJfZmx1c2goKS4NCg0KQnkgdGhlIHdheSBodWdlX3B0ZXBf
Y2xlYXJfZmx1c2goKSBpcyBub3QgZGVjbGFyZWQgJ211c3RfY2hlY2snIHNvIHRoaXMgDQpjYXN0
IGlzIGp1c3QgdmlzdWFsIHBvbHV0aW9uIGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4NCg0KSW4gdGhl
IG1lYW50aW1lIHRoZSBjb21tZW50IHN1Z2dlc3RlZCBieSBNaWtlIHNob3VsZCBiZSBhZGRlZCBp
bnN0ZWFkLg0KDQpDaHJpc3RvcGhl
