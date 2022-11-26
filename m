Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8D639434
	for <lists+linux-arch@lfdr.de>; Sat, 26 Nov 2022 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKZHgv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Nov 2022 02:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKZHgu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Nov 2022 02:36:50 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120048.outbound.protection.outlook.com [40.107.12.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BF82BB23;
        Fri, 25 Nov 2022 23:36:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eo/3NvshKHWIdejzAvPeeg+x7FDRFSpgQVhFVlkDgxt82x1ZNevLpURBtJ+wvwojglqa5Bd+UqRMpXF0WWdIdbKpR+43eNJh1t3YRDV3cczPIc02oxB6pHYarOleP5J7mEmR0imlA2HCQ7whNnh+tnV6+hJ20Untk4Mgko/4XJ3SNxonlfHHcJCE/e1uSgLle9tENqBobd8PBUj4N4H0PQ9S4kenZR7+TuFbDhaUyG4fUCUScvSLfKJEBC7L3rbVFXe9n+p5SpQwmku+kuJTU6uXxfJLP5nljWJWkcr5ecr1uQaaM/h+E0ueywmqSCIgwKLzqB0a0YBGh91mkRBwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jx1j70Ifm7h6lMtX3I8fpL0HmzDbb4yLqfgvb7J7gk=;
 b=OWzA2U/7db7YU7gzEw/ishzwVCc6B7En5Dbixr9T6bhiHbLfRVHQ6Bo+xbjpQQY+uCFh0aO34PuxDDBvv5Fr4Nkt0/ACTdknfOKXIkiLnkSCAvZmvpUC+qI7m9LSl+q3VwF4FND4yprKCnNGvhTObsJ/6EFbeKOrWPV5+UpcR5uwogAObg29xTsWTpcYOpCjn1ePtwX6Jz8nmnLnb6MDwCrrGzt67APfKO63fOADgBhOGz4BB/bOItQwGvMLUOHdwM9bKYOv0KSQtNUZf3Qc/cURCb2gYHYwn5M48Zg/8gHYwJ5oK8tDGXRVDNarAbocT7W2yhj05ZVSgdVUZ+GDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jx1j70Ifm7h6lMtX3I8fpL0HmzDbb4yLqfgvb7J7gk=;
 b=oC624KjIM2iWd/PnqgRPSx5y7GLDUPkhb6koev6907bJ0wWO+N5I213JZOuieX74UuFetOo7kzK0bwC3eFKOhiUp6e7n0lR1opQArTXL8qNsOzNklLzWEcX08ecuMiMogpb5uPlbpDnTPZbYlzpGd+dHPoID+W5ibV90kghKXIibEw6w16ztcM5uwxeI4uNEDuUpEYA9YMFagt2HgD3fciPtVFOmxkdvUao4wgFhboRe67K9n+vsnhGwZ/qsxNPPdO2AN/Cp36sCdfAOX3ikla1d8bkndBviNmw1GMcUS5IkIAPuDXX2vQCnk1HPadWvfoT/ZRzXpuesWp///ZGzUg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1790.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Sat, 26 Nov
 2022 07:36:45 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::a85b:a9b6:cb36:fa6%8]) with mapi id 15.20.5857.021; Sat, 26 Nov 2022
 07:36:45 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 2/3] powerpc/book3e: remove #include
 <generated/utsrelease.h>
Thread-Topic: [PATCH 2/3] powerpc/book3e: remove #include
 <generated/utsrelease.h>
Thread-Index: AQHZAVWpki/i7bY6nkCRQ+Pno6q/Xq5Q0P+A
Date:   Sat, 26 Nov 2022 07:36:45 +0000
Message-ID: <03859890-bf90-4ad0-1926-4b8cb8dbfa57@csgroup.eu>
References: <20221126051002.123199-1-linux@weissschuh.net>
 <20221126051002.123199-2-linux@weissschuh.net>
In-Reply-To: <20221126051002.123199-2-linux@weissschuh.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1790:EE_
x-ms-office365-filtering-correlation-id: 9a58d0e5-b18b-4468-8595-08dacf80f856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yVqmGWxlhnh/9rwnPzqPE4n7khlDLKoqsug4b80EFzhRoucXfK4iXGGuqjuD1EByKhY3/vi9f1pf8HRFco9ZTLFO3GMpAJ/9JpB8lS0SIhTsYI7sV1n3LGVXpw+M/NDigjyLPNZw+5Damr55mg3Kfz+rf9AxgXOdA8eTQbMY/HPTH8IpMYCKHEUQWy6luNbWkIDH4LrVuLlDmvWFz9UmA8mqKjs/6xMCecBeig1C9t6k22akJ6I6ptCOPi8UHClwkwXRo0AdUu8jQn0lGgG8DTTNn/trT+iXjSqGh62k5LJiibF4tKA7FP2Ob9fvukNmroBgxkMBzmhNH2YTAVZpd2IYrETBDSNloH54dEuVFf7kh4wKzTT03BgITtC7aHX/Fbf2pNUPvjBkw4xUzS2yNg0QC5GXy11CjEVuNQ/a4uZmu+LhFi7YW2Rh6gm/eLdDjRp6wpBF7f/pbUWEeEBQPEVqVAeWkwnYd0T1CUGD38zEQcq+QIrpuV+sk6LGq8X/jI8n9dT+Zowdx8rItMn/BKbFUwlbUwki3uuJGvYZYjO6Im/xzGpFCgBs9kUgWrf8aRFGtEi7BAxZieQKjAfHwEdS4LVU6FdGMZ6viwVKFf8Jslm+7s5MLbLNP+PEOp4Gs+SgPl0f2ZdPlyj0SRApInFU71UYpMNY27Y45cHQtvnG2eGOePjhCqzrR4K+EFWGAm8CPm827aSyGyEnRMHZXc+gENCfpd6nTuv6cbKUI/PutdcEYtrO8/dH3KaET5pJ0CX54htr+yvv0z4xX2BX8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(366004)(136003)(376002)(346002)(396003)(451199015)(31686004)(6486002)(71200400001)(6506007)(26005)(478600001)(6512007)(110136005)(54906003)(2616005)(36756003)(316002)(8936002)(5660300002)(7416002)(83380400001)(2906002)(76116006)(66946007)(66574015)(91956017)(186003)(44832011)(31696002)(38070700005)(86362001)(66556008)(66476007)(66446008)(64756008)(122000001)(8676002)(4326008)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFQ3Rmd4SW1uNWFySHlob1YwSlBJZjUreDk1Z0VEaHdTTHFnQWtPZ2pIcklS?=
 =?utf-8?B?WklUZ1RHeUdmenlyZno2aVNzaUQvejdKSzN3TEtLalRwYnJINXdRODNwYml4?=
 =?utf-8?B?SmticlVFeDZKcW5xaFowMW5zUDN3MUZaNjh6ekdqdFJZOVhJRzFrbVZweGhz?=
 =?utf-8?B?V2ozOWFISHJLcWx6bVN0ZlRQU0pmVE8wUDZSbXRrV25kRCt6UmZrSnZIOExk?=
 =?utf-8?B?aDVSNXNaVkF6R0t5RERsaVNMejAvK0ZVclpsdGNWbFFPbXNSaFdMRkVRYllw?=
 =?utf-8?B?TFBzSWQ1S2RSRFY0MVpqeWFKSUFFOVlDWWxTVkQzenlYY0hvcC9zeW1WN2Nj?=
 =?utf-8?B?dzE4aEdkM3k3cCtsM0lhRUJSSWNRUU1XQXRMelZIc2VDY0tudkF6SEoxMW9U?=
 =?utf-8?B?cERVK3pXeDVQTDdXdUEvYVNNeE9Zb0lMVkJvR0NLY080YU56U3dkemIyWUZF?=
 =?utf-8?B?bHgvRVp3Yk94QXZiNVNZeUl4T0xrVGZUd2xhQ01FQkdhaWdoUjIya0R5WElj?=
 =?utf-8?B?SnMvdGljRHNYSjQ3ZW9KVDd4MkEvVW5rWUpaSWtrWmxYRkZ1SWQrWUJZNDYy?=
 =?utf-8?B?T2VtcThTTkhsRkpScmI4WHhiV3c2MW9BdWhUeDNSN3FrN29sSUhOczhkRG9X?=
 =?utf-8?B?Sll0Wi9GY0dXeUVMNmJvWDR6ZjV6Q2oyRlN3TGRRMVYyN044MzVnRTRjNHlC?=
 =?utf-8?B?cm9NazIvK1RudDhoblNSN0s5dGJ1OTNCYnJrUHdkS01LU2hWa3pFN2NDM0FM?=
 =?utf-8?B?eE83V0lmNURuMGNLVDR3ekRzbndQaUpVem9QbldnZlhQSnJLc1hHc05aYlYz?=
 =?utf-8?B?N3RQWTFFQ2lqTHNnS2xNbWN2L0lMR1oxaFQvaWtyU3ZUTUp2WDdiTTVjYS9r?=
 =?utf-8?B?eklWbmFweDcxSm93Zk1JN1Y2RmRGbmpuY3F3T0NVd0cvRkZTekU0czZyTjl5?=
 =?utf-8?B?MWY1aXhWaTBpWnNWeUxSM1pDNGZ1WUpXWFoyclRMbXlmKzFTVWg0cHFlVHAx?=
 =?utf-8?B?UlJuTlVHb29XclYzSnNMTkVGOXJzMEx3ME1WL2xtWmFOZlZGcXk2R2NqakNW?=
 =?utf-8?B?MG9CT3NCUTNvMng0WStLZC9zbEgyeURWUzBOSXBjMnR3QUhGTzBoaHJacW9R?=
 =?utf-8?B?eWZLTlhLSHk0dHhHSnVVbFBZMTB3N2RNTHpUekU3U1hsMjlMNFFjSklTbS8r?=
 =?utf-8?B?OFFaRzNsSURTY3ZtWjV2RURwYlg5RVRYeDZwd2s0NEFEbndLRDgyemYyR3lP?=
 =?utf-8?B?cnR5UDYxdkc0dWxhUFdHYlI5cStJTldMVEt2ZDM0K3d2V2hvS3kybzRhZlhs?=
 =?utf-8?B?OEoyR3kwUGNZc1h1Umhidm1BalBaQXdmSUVBcWtNSHhNd2hiN1A4VmFhU1Ry?=
 =?utf-8?B?N25GanRLSTlqREdRSmRMM0RRdkZZemI5YjFDaWhGZTJaekZvcjZmWWl0RWhX?=
 =?utf-8?B?dXlyMTVaWjR1M0lpMzM2UGh2UUo2SC94czE2QzRqTTN3eWxQNGQ5a21OT1Vl?=
 =?utf-8?B?QjVseU01WnZKN1BRWHpiejI3ODhsMWxJeHdpanF3UytYT3NQZ1BLbjNScWZ1?=
 =?utf-8?B?d3U0cW10S0lYS3NkRmR6Q3hVb1ZqeFZ4ei9UVXNUUFV2aE50eElYSS8zczlx?=
 =?utf-8?B?K2JjeTdYY2syNnVOald0WWdoS2NrSnFWUGp6RkJjcEhmWmVDRGtmeTYyS0gv?=
 =?utf-8?B?S3dSUCtNaXkzVFVhZUtZWjFUNTQ4ZkhuVi9tMUlzOU9FM3NMdzFFSVRpMHpa?=
 =?utf-8?B?SS92bEdiS2I3eHVUNnZ4N29nZzJBcTJBOVZMV05TZGVnK25QMURaVXBrSisr?=
 =?utf-8?B?TlJhRXNkQWRQM2NqTXE4dkxnTVdlbWI2V25IMHdDOXBjckJkVWUzdkN3U0lR?=
 =?utf-8?B?Ukpid096YWNKVUZ3UUx5dnpMZnlYNmZZc0FKaG1hR3RUeElTZlJBUllQQVc2?=
 =?utf-8?B?T1FTNzJWdzVFTWVqMUZGaWU0Q0NCRlFYMXlyelFhbHZ1QmVianpsdXhVY2xR?=
 =?utf-8?B?YWFBVXFCN0JvMGRzbERGZGNDdURPenJobEJyQ0hEUk5rVTRZd2t2SzRJMUZO?=
 =?utf-8?B?TEVhMjdYVzFxN0FMZ1JJN0JiVkgxZllqZjcxcVdYaUhLZHdTN3BMOVh0QWVI?=
 =?utf-8?B?QkpCSUk4NXdTeVVCcWFqYm9QbTdXdW5yejVhSjZzNDM0MUsxQ05CQkRGbGdx?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72BCBB4074E25945BC9CFE46033CC234@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a58d0e5-b18b-4468-8595-08dacf80f856
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2022 07:36:45.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aa1E2a4BCu/psLGTVH5my/1FLzk9Oo1vOPAmI1Beb6ktwtgxDwEAGGgZAvoLNwE2FgxApg9G64j5qnFVGmdfGHB6QcIZVC31Gq9qPS5e7+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1790
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI2LzExLzIwMjIgw6AgMDY6MTAsIFRob21hcyBXZWnDn3NjaHVoIGEgw6ljcml0wqA6
DQo+IENvbW1pdCA3YWQ0YmQ4ODdkMjcgKCJwb3dlcnBjL2Jvb2szZTogZ2V0IHJpZCBvZiAjaW5j
bHVkZSA8Z2VuZXJhdGVkL2NvbXBpbGUuaD4iKQ0KPiByZW1vdmVkIHRoZSB1c2FnZSBvZiB0aGUg
ZGVmaW5lIFVUU19WRVJTSU9OIGJ1dCBmb3Jnb3QgdG8gZHJvcCB0aGUNCj4gaW5jbHVkZS4NCg0K
V2hhdCBhYm91dDoNCmFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvNTJ4eC9lZmlrYS5jDQphcmNoL3Bv
d2VycGMvcGxhdGZvcm1zL2FtaWdhb25lL3NldHVwLmMNCmFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
Y2hycC9zZXR1cC5jDQphcmNoL3Bvd2VycGMvcGxhdGZvcm1zL3Bvd2VybWFjL2Jvb3R4X2luaXQu
Yw0KDQpJIGJlbGlldmUgeW91IGNhbiBkbyBhIGxvdCBtb3JlIHRoYW4gd2hhdCB5b3UgZGlkIGlu
IHlvdXIgc2VyaWVzLg0KDQpMaXN0IG9mIGZpbGVzIHVzaW5nIFVUU19WRVJTSU9OIDoNCg0KJCBn
aXQgZ3JlcCAtbCBVVFNfVkVSU0lPTg0KRG9jdW1lbnRhdGlvbi9rYnVpbGQva2J1aWxkLnJzdA0K
YXJjaC9zMzkwL2Jvb3QvdmVyc2lvbi5jDQphcmNoL3g4Ni9ib290L2NvbXByZXNzZWQva2FzbHIu
Yw0KYXJjaC94ODYvYm9vdC92ZXJzaW9uLmMNCmluaXQvTWFrZWZpbGUNCmluaXQvdmVyc2lvbi10
aW1lc3RhbXAuYw0KDQpMaXN0IG9mIGZpbGVzIGluY2x1ZGluZyBnZW5lcmF0ZWQvdXRzcmVsZWFz
ZS5oIDoNCg0KJCBnaXQgZ3JlcCAtbCAiI2luY2x1ZGUgPGdlbmVyYXRlZC91dHNyZWxlYXNlLmg+
Ig0KRG9jdW1lbnRhdGlvbi90YXJnZXQvdGNtX21vZF9idWlsZGVyLnB5DQphcmNoL2FscGhhL2Jv
b3QvYm9vdHAuYw0KYXJjaC9hbHBoYS9ib290L2Jvb3Rwei5jDQphcmNoL2FscGhhL2Jvb3QvbWFp
bi5jDQphcmNoL3Bvd2VycGMvbW0vbm9oYXNoL2thc2xyX2Jvb2tlLmMNCmFyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvNTJ4eC9lZmlrYS5jDQphcmNoL3Bvd2VycGMvcGxhdGZvcm1zL2FtaWdhb25lL3Nl
dHVwLmMNCmFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2hycC9zZXR1cC5jDQphcmNoL3Bvd2VycGMv
cGxhdGZvcm1zL3Bvd2VybWFjL2Jvb3R4X2luaXQuYw0KYXJjaC9zMzkwL2Jvb3QvdmVyc2lvbi5j
DQphcmNoL3g4Ni9ib290L2NvbXByZXNzZWQva2FzbHIuYw0KYXJjaC94ODYvYm9vdC92ZXJzaW9u
LmMNCmNyeXB0by9maXBzLmMNCmRyaXZlcnMvYXV4ZGlzcGxheS9hcm0tY2hhcmxjZC5jDQpkcml2
ZXJzL2F1eGRpc3BsYXkvY2hhcmxjZC5jDQpkcml2ZXJzL2F1eGRpc3BsYXkvbGluZS1kaXNwbGF5
LmMNCmRyaXZlcnMvYmFzZS9maXJtd2FyZV9sb2FkZXIvZmlybXdhcmUuaA0KZHJpdmVycy9iYXNl
L2Zpcm13YXJlX2xvYWRlci9tYWluLmMNCmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kZXZpY2UuYw0KZHJpdmVycy9ncHUvZHJtL21zbS9kaXNwL21zbV9kaXNwX3NuYXBzaG90X3V0
aWwuYw0KZHJpdmVycy9ncHUvZHJtL21zbS9tc21fZ3B1LmMNCmRyaXZlcnMvZ3B1L2RybS92bXdn
Zngvdm13Z2Z4X2Rydi5jDQpkcml2ZXJzL25ldC9ib25kaW5nL2JvbmRpbmdfcHJpdi5oDQpkcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pNDBlL2k0MGVfbWFpbi5jDQpkcml2ZXJzL25ldC9ldGhl
cm5ldC9pbnRlbC9pY2UvaWNlX21haW4uYw0KZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhn
YmUvaXhnYmVfZmNvZS5jDQpkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9t
YWluLmMNCmRyaXZlcnMvbmV0L2V0aGVybmV0L3BlbnNhbmRvL2lvbmljL2lvbmljX21haW4uYw0K
ZHJpdmVycy9uZXQvZXRoZXJuZXQvcm9ja2VyL3JvY2tlcl9tYWluLmMNCmRyaXZlcnMvbmV0L3Rl
YW0vdGVhbS5jDQpkcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQpkcml2ZXJzL252bWUv
dGFyZ2V0L2Rpc2NvdmVyeS5jDQpkcml2ZXJzL3Bvd2VyL3N1cHBseS90ZXN0X3Bvd2VyLmMNCmRy
aXZlcnMvc3RhZ2luZy9vY3Rlb24vZXRoZXJuZXQtbWRpby5jDQpkcml2ZXJzL3RhcmdldC90YXJn
ZXRfY29yZV9jb25maWdmcy5jDQpkcml2ZXJzL3RhcmdldC90Y21fZmMvdGZjX2NvbmYuYw0KZHJp
dmVycy92aG9zdC9zY3NpLmMNCmRyaXZlcnMveGVuL3hlbi1zY3NpYmFjay5jDQppbmNsdWRlL2xp
bnV4L3Zlcm1hZ2ljLmgNCmluaXQvdmVyc2lvbi10aW1lc3RhbXAuYw0KaW5pdC92ZXJzaW9uLmMN
Cmtlcm5lbC9zeXMuYw0Ka2VybmVsL3RyYWNlL3RyYWNlLmMNCm5ldC9ldGh0b29sL2lvY3RsLmMN
Cm5ldC9yeHJwYy9sb2NhbF9ldmVudC5jDQpzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9pbml0
LmMNCg0KQ2hyaXN0b3BoZQ0KDQo+IA0KPiBGaXhlczogN2FkNGJkODg3ZDI3ICgicG93ZXJwYy9i
b29rM2U6IGdldCByaWQgb2YgI2luY2x1ZGUgPGdlbmVyYXRlZC9jb21waWxlLmg+IikNCj4gU2ln
bmVkLW9mZi1ieTogVGhvbWFzIFdlacOfc2NodWggPGxpbnV4QHdlaXNzc2NodWgubmV0Pg0KPiAt
LS0NCj4gICBhcmNoL3Bvd2VycGMvbW0vbm9oYXNoL2thc2xyX2Jvb2tlLmMgfCAxIC0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93
ZXJwYy9tbS9ub2hhc2gva2FzbHJfYm9va2UuYyBiL2FyY2gvcG93ZXJwYy9tbS9ub2hhc2gva2Fz
bHJfYm9va2UuYw0KPiBpbmRleCAwZDA0ZjlkNWRhOGQuLjJmYjNlZGFmZTlhYiAxMDA2NDQNCj4g
LS0tIGEvYXJjaC9wb3dlcnBjL21tL25vaGFzaC9rYXNscl9ib29rZS5jDQo+ICsrKyBiL2FyY2gv
cG93ZXJwYy9tbS9ub2hhc2gva2FzbHJfYm9va2UuYw0KPiBAQCAtMTksNyArMTksNiBAQA0KPiAg
ICNpbmNsdWRlIDxhc20vY2FjaGVmbHVzaC5oPg0KPiAgICNpbmNsdWRlIDxhc20va2R1bXAuaD4N
Cj4gICAjaW5jbHVkZSA8bW0vbW11X2RlY2wuaD4NCj4gLSNpbmNsdWRlIDxnZW5lcmF0ZWQvdXRz
cmVsZWFzZS5oPg0KPiAgIA0KPiAgIHN0cnVjdCByZWdpb25zIHsNCj4gICAJdW5zaWduZWQgbG9u
ZyBwYV9zdGFydDsNCg==
