Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915564FEF3F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 08:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiDMGJ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiDMGJz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:09:55 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120084.outbound.protection.outlook.com [40.107.12.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086CA35A89;
        Tue, 12 Apr 2022 23:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KML9dbz6Ey1rIb/oVK2AShtDI+HdiHdDNLs+uGuVpX0qlVfn6fxEcc6zhzVng7IAvpYqskE5W39SUEcx6zTcvrszrFTvfXC3UWvT8zPLD4qtOyqAOGTwEVirQ6aIj3y5L3aW951XskdcZFVDG4VRXw9joezCcFazztU1qA79RKjkuH02dbY6nW3OGUXWrBuixEZZIPqNMV7pfNQGB1pmh+Tq++om+SPvVXju1Yu/odFNrlDM4AazwLkGjOThXgDfsc2F3GSwNtKJhEPJSVwwOGTPY3LnfpBLL3I+flAGYLT6x/AjHNUou+JyxsedpSJ3US59Qyf1yY4B5ySH/mby4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ist7mvfASlB+iboe3q6by7FcnokZD5tou2pfv0hew7U=;
 b=VE9HrZUh68w1DI17A0Yau4JflEamoJskRlmjGDSRJE5Ze0JR8+7+/Wmzx0Cajv2xYaNAsh2U/v+kQrMEzM7mCBq8QdLXw6maHE7Jh0qGsf62g5jSTWddKj0Nxb7tMv/Vytnq0La6Yt41G4FQ+ZkB/UnZSwAYTZsSYxNLdgqmtqTMEgRm3qzkKTE1T+uwCd3Zvl24PRWsa2mifWD2JNKOrcxfZH7jswK5daNMJivNCHVinD1FWaMu2ZjO3TXBGF1TrAq6923jm3A4aaA+SR0JoMyxPjJDCbmUQj0qsxGnJ/+oEKqSD/ASq994Qbv7rFQbFDQeGD6YoBCo117905vZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3447.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 06:07:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%8]) with mapi id 15.20.5164.020; Wed, 13 Apr 2022
 06:07:32 +0000
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V6 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Topic: [PATCH V6 2/7] powerpc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Thread-Index: AQHYTvuB8y2JXMLHPUaQls1IyBm1ZqztW46A
Date:   Wed, 13 Apr 2022 06:07:32 +0000
Message-ID: <2ec59f96-fc8a-fc2e-6804-382605131668@csgroup.eu>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
 <20220413055840.392628-3-anshuman.khandual@arm.com>
In-Reply-To: <20220413055840.392628-3-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47832e8c-41cc-411b-4f55-08da1d13e612
x-ms-traffictypediagnostic: PR1P264MB3447:EE_
x-microsoft-antispam-prvs: <PR1P264MB3447E9F5B0186D3AA51D39C3EDEC9@PR1P264MB3447.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fKY9A9Tu5nI0AbqhsGeCPY5QTotx/eUqx56jkbsiuycYRJMyFwlMvqOVA8GZzKDOzn9RVxsnF6ruvEkeQrTYH0JHaDCfxvkxyVGpNXuPix5aRNDtuFA8ej5eF8gzqBukJJaT4fCzjNfeAzwFG+Pz7ghn3gagWyeK60w2PdjnhcMXPX2xvMImKdTPvj1rnn95nEc8OwRbZme4xHPR3pVZwXqpiFXAMthog2+hESI/tNERNVxAhUUvLwLpwllwaHu2qk614TzjUeu9wKzQXA3jFlU7cVMpu5pCqW4Eokd5ECcYU6LwgTDPfQVqMLrHKgv0JcsZwM3EmhAq8kuW3N3TE49nOf70FOgjwuJ41y/ZoZ9yFvzuWnqjnT9ntiGiv07issKozYm85/P1XZibiGUGydG2lTq0T31dz2mvyaoO2viw2YUwkWkGeFQYYH1wkDkgsaQEXI/VnUs0AemzqdOL5uUqZMiyd4XAkhpwwLn0G5FiZtnRE0ViN/ikOay9qJB/zOtEMSmhJHexyhSxBltMe2fiSfiYINyH5WmPIjD+KRbXmKGPCels/qiEBdgmXovqxgP60XB4Rnlj7nD1Of3Yymv2AvKwtNBvzmlUrimXWbKKATzkCEMDfj52xzwZ6PUjFYWVW6cvhGaaZUFesI2xcbDyzulrTa2JKMEb6ED6QHw2xQidalsHJcTZzyt+x3HaYTbFNJhcpFglpN9hmvFemUzqFpxpm5yzdAmAqgB2UAxs6dww/drXhjmDR36nJMWQn7LEdsApf+8Paf3fkZHN2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66446008)(8676002)(8936002)(38100700002)(4326008)(6486002)(66946007)(76116006)(7416002)(66476007)(83380400001)(122000001)(508600001)(91956017)(31696002)(31686004)(110136005)(54906003)(36756003)(64756008)(6506007)(86362001)(26005)(186003)(2906002)(38070700005)(71200400001)(2616005)(316002)(6512007)(66574015)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3d2blBIYXV4Y0tia3Q2elNQQTJMd0FCM3lmOVRSSHJWWTd3NHlXYUtUWVE2?=
 =?utf-8?B?Zy9tYUczVTlQL3I1bzRSWWxTR3YraHlsdzhncXNxMkU1Qy9VVEo0YmlRMVZF?=
 =?utf-8?B?U2UxNnhrM0tzTU9iS0s4cEJ0MldLSUJZMmphTld3cVBqQzdCcE9TVFovTWhx?=
 =?utf-8?B?eTZCQkdKVGVuY0JvQVZMUU5CMlVWa2Y5dFpRRnVaekpLemdEMUJaT2g1TCtR?=
 =?utf-8?B?a1liR0FRL3dhLzFHT1VYeW9qeG1WOVZuVjdSKzBDM292UFdCUjhXeStWLy9W?=
 =?utf-8?B?bVh0enYvNlphYjlyYVpVTTNlbytvZ010S1JyeFEwNVVnWnRpRXNDbnViaXVn?=
 =?utf-8?B?a25CQSszMmU0RDljYWVRWERmRnBLMldiUFNqWSsyUWtTd1I5N2c0Q09GTndz?=
 =?utf-8?B?SzZTTzB3eWRvd29hVGRucldVUmR0ZVcwMGNXU1l0Y0MvWGJkdnExMk9yU1Nu?=
 =?utf-8?B?SmxNKzVsbFB4QWVnRWtLbkdtMTRSQStjZkpWT2R3NkRkNDQ5RlZSTzRDeFQ0?=
 =?utf-8?B?aUtYN0RnVWdEblBSU0cyNkF6MEo0c3VDaUl2NERuKzczbzgzcTd6Y1dkMzBT?=
 =?utf-8?B?TXROVlBXOVNsbGRlWThZWkZUQkU2RmhlbEpsM1dUR3hGR1k5L2hxVzlvZGhw?=
 =?utf-8?B?ckxzb0pzdzdOOHJOVDhOUXhnRHF5NlZ3Ti9wOGdYeCtPUVprVVd4THJmWmJl?=
 =?utf-8?B?b1FKeVNUMG90a3F1cTNvS28xeGovZkFiamhscmhOZzhRdHMzOGRYaGdEWXlj?=
 =?utf-8?B?cWVXUDBMWDNPTmZpOXpYUWR2WnQ3cE5ON3AwNWxjdzF4aFRObHJ4TTljSU5F?=
 =?utf-8?B?bVBwZHlQNEYvVTYvUFFCN1hFNDJzRTZYVmc4a2htR1c1SGYrWGpmSUl6bjVF?=
 =?utf-8?B?M1drTTZFQXU1V2dRTkd1K21QZ3Y0UXhBUFcvZktlYmdpNWMwSTJYWGt4N05j?=
 =?utf-8?B?dndtMkE1UTRTV2oxZGFodW9vMjh2TGxxbkhJTXhncG5GOTFiQ3IwV2ZURnZL?=
 =?utf-8?B?TjNhalgwREFXOWJVQ0NWZDhEcDdNM0tMVlJFbWJSVnFEeDJ2MTNGTFJrT2s2?=
 =?utf-8?B?dHFVT3BkWmkyVmt6T3kyUXhtT0ltaUs1a0hSWUxqdTRaOSt4ZmFzbld4d0RK?=
 =?utf-8?B?ZWh5UzBtZXFxZXByTXBWL0QrLzBDaTRmNDY1YjY5bnVraUhwZ1NqMG9iUXRZ?=
 =?utf-8?B?QzVVUVRJbHpld3VDM2FOd09JQVRaQm1zamt3SkU4OUQwWlZ1SnRzaHYxWmZY?=
 =?utf-8?B?S0JsOWFyUy9NNlVNQnhhR3V3ZEwrMVczSUZrMmVUUHVSOWYyOXlVVWdhUlYr?=
 =?utf-8?B?R0UzelhCaDBWcnYwYkNya3dqM1FuNHA3M01icHBmdS9hTnJsYXlpYkpjNGlM?=
 =?utf-8?B?ZXZ6Q2dwaG5HYXhMNkFheE03dnV3TEZVNEp5OTRTY0lDWER1NWdUQnpUM2Vs?=
 =?utf-8?B?ZzkvbDVXci9DM2ZrbkJwc0ZycWYyaFlxL24zRnEyUEovSVdrcHhYblhoS1Jp?=
 =?utf-8?B?T2lBRjlGc0tBVVNQeGRhQjBLdnFRQjZCK0VoYVpSS21SZ1ZxR3hyM3BTc1V2?=
 =?utf-8?B?VEJhd294WC9yUi9LWWlyK3d3d0p3bHJSUFNkRXVBSnp3Wi92YlNrSE9MSW5Z?=
 =?utf-8?B?R2VKYkxMUnVYQkphQ0VFZC9ybXhNVWtYWEZ3b1lZOE1QTXJYMjRWQ2g3ZkQ5?=
 =?utf-8?B?eDIzdW1oY0xuRG5nVXBuZWZOS09sNk9jZmI1ZmxIUEt1NDYzVm1IUVZoTmFi?=
 =?utf-8?B?QjRmVlAwKytWbzFmVHZOeDJteURyazVRTnVMV0dVMVlKMGVKOFRnUkNLRWRl?=
 =?utf-8?B?OFZDMEZUYlBBdEZPR3hLc0d2elRmZmZweWRLT29qUW1DenQ2NTVtSVJaUmZC?=
 =?utf-8?B?SHpRNk1tSVFpU3RncmZGZjhOdTk3dmRybVhWWnBmanJEQ2RJNjhJbnNpNUtx?=
 =?utf-8?B?MmZVbnJwQ0FzOVRPTnhJdVg1WWtQUXVQK2VmdDVWeU9iY0dkNEdVT0RESzZt?=
 =?utf-8?B?MmpLVjQrNVlSK0ZpZ0RhdHgwellvR3U2OWttS1EvYklabWV2L2dOTVFjdmpL?=
 =?utf-8?B?R3pwdWNsT0drWFRxZzZwbUVQTXZiVmJzWVNDZ1ZoUGdoQUhQS2dyWmtLWVJI?=
 =?utf-8?B?NnNLRjB3VGFYQnFndHJZU0Jlb2dnN0RPbFV4M21aaTlxbTVwNGVlM1dsVkl4?=
 =?utf-8?B?MmZGdnNmb1lZMkUyYVZ2MUV3YWhPQ2hYbkFwcENXNDd1aWpVeGQwTktBRlpI?=
 =?utf-8?B?RUdNY2JPSnlVOUM1MEFaN1RNRHhFZUxJQnlzdlplc0hXOG1uMjJzaGpIaWND?=
 =?utf-8?B?YTI4eUNINjhsZ0pIVDYwNjBwREFZYkh6VWJuWnBTcmYvczJ0RVEyUnhhbjBp?=
 =?utf-8?Q?fIYQB6CjFFtLmU44d/pdDAj6UyCjjx0iR9Z+v?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1EE251C81824644B0BC0797BB17BB82@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47832e8c-41cc-411b-4f55-08da1d13e612
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 06:07:32.6796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 94Mb3Fu5MAc+xBhfIfjkwE6Z2zI8l84d0xUOu40HzFhS1cwY4l3wBxuG9/ZIuLYO5qr6vvA/R173MXTypiu2n4K58WFDAoy1WEUcylwitcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3447
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
X1BST1QuIFdoaWxlIGhlcmUsIHRoaXMgYWxzbyBsb2NhbGl6ZXMNCj4gYXJjaF92bV9nZXRfcGFn
ZV9wcm90KCkgYXMgX192bV9nZXRfcGFnZV9wcm90KCkgYW5kIG1vdmVzIGl0IG5lYXINCj4gdm1f
Z2V0X3BhZ2VfcHJvdCgpLg0KPiANCj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1h
bi5pZC5hdT4NCj4gQ2M6IFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPg0KPiBDYzog
bGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogQW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmto
YW5kdWFsQGFybS5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3Rv
cGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAgYXJjaC9wb3dlcnBjL0tjb25maWcg
ICAgICAgICAgICAgICB8ICAxICsNCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vbW1hbi5o
ICAgIHwgMTIgLS0tLS0tLS0tLS0tDQo+ICAgYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3BndGFi
bGUuYyB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMvS2NvbmZpZyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnDQo+IGluZGV4IDE3NGVkYWJiNzRmYS4u
NjllNDQzNThhMjM1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KPiArKysg
Yi9hcmNoL3Bvd2VycGMvS2NvbmZpZw0KPiBAQCAtMTQwLDYgKzE0MCw3IEBAIGNvbmZpZyBQUEMN
Cj4gICAJc2VsZWN0IEFSQ0hfSEFTX1RJQ0tfQlJPQURDQVNUCQlpZiBHRU5FUklDX0NMT0NLRVZF
TlRTX0JST0FEQ0FTVA0KPiAgIAlzZWxlY3QgQVJDSF9IQVNfVUFDQ0VTU19GTFVTSENBQ0hFDQo+
ICAgCXNlbGVjdCBBUkNIX0hBU19VQlNBTl9TQU5JVElaRV9BTEwNCj4gKwlzZWxlY3QgQVJDSF9I
QVNfVk1fR0VUX1BBR0VfUFJPVAlpZiBQUENfQk9PSzNTXzY0DQo+ICAgCXNlbGVjdCBBUkNIX0hB
VkVfTk1JX1NBRkVfQ01QWENIRw0KPiAgIAlzZWxlY3QgQVJDSF9LRUVQX01FTUJMT0NLDQo+ICAg
CXNlbGVjdCBBUkNIX01JR0hUX0hBVkVfUENfUEFSUE9SVA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9w
b3dlcnBjL2luY2x1ZGUvYXNtL21tYW4uaCBiL2FyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9tbWFu
LmgNCj4gaW5kZXggN2NiNmQxOGY1Y2Q2Li4xYjAyNGU2NGM4ZWMgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9tbWFuLmgNCj4gKysrIGIvYXJjaC9wb3dlcnBjL2luY2x1
ZGUvYXNtL21tYW4uaA0KPiBAQCAtMjQsMTggKzI0LDYgQEAgc3RhdGljIGlubGluZSB1bnNpZ25l
ZCBsb25nIGFyY2hfY2FsY192bV9wcm90X2JpdHModW5zaWduZWQgbG9uZyBwcm90LA0KPiAgIH0N
Cj4gICAjZGVmaW5lIGFyY2hfY2FsY192bV9wcm90X2JpdHMocHJvdCwgcGtleSkgYXJjaF9jYWxj
X3ZtX3Byb3RfYml0cyhwcm90LCBwa2V5KQ0KPiAgIA0KPiAtc3RhdGljIGlubGluZSBwZ3Byb3Rf
dCBhcmNoX3ZtX2dldF9wYWdlX3Byb3QodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gLXsNCj4g
LSNpZmRlZiBDT05GSUdfUFBDX01FTV9LRVlTDQo+IC0JcmV0dXJuICh2bV9mbGFncyAmIFZNX1NB
TykgPw0KPiAtCQlfX3BncHJvdChfUEFHRV9TQU8gfCB2bWZsYWdfdG9fcHRlX3BrZXlfYml0cyh2
bV9mbGFncykpIDoNCj4gLQkJX19wZ3Byb3QoMCB8IHZtZmxhZ190b19wdGVfcGtleV9iaXRzKHZt
X2ZsYWdzKSk7DQo+IC0jZWxzZQ0KPiAtCXJldHVybiAodm1fZmxhZ3MgJiBWTV9TQU8pID8gX19w
Z3Byb3QoX1BBR0VfU0FPKSA6IF9fcGdwcm90KDApOw0KPiAtI2VuZGlmDQo+IC19DQo+IC0jZGVm
aW5lIGFyY2hfdm1fZ2V0X3BhZ2VfcHJvdCh2bV9mbGFncykgYXJjaF92bV9nZXRfcGFnZV9wcm90
KHZtX2ZsYWdzKQ0KPiAtDQo+ICAgc3RhdGljIGlubGluZSBib29sIGFyY2hfdmFsaWRhdGVfcHJv
dCh1bnNpZ25lZCBsb25nIHByb3QsIHVuc2lnbmVkIGxvbmcgYWRkcikNCj4gICB7DQo+ICAgCWlm
IChwcm90ICYgfihQUk9UX1JFQUQgfCBQUk9UX1dSSVRFIHwgUFJPVF9FWEVDIHwgUFJPVF9TRU0g
fCBQUk9UX1NBTykpDQo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvcGd0
YWJsZS5jIGIvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3BndGFibGUuYw0KPiBpbmRleCAwNTJl
NjU5MGY4NGYuLjhiNDc0YWIzMmY2NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL21tL2Jv
b2szczY0L3BndGFibGUuYw0KPiArKysgYi9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvcGd0YWJs
ZS5jDQo+IEBAIC03LDYgKzcsNyBAQA0KPiAgICNpbmNsdWRlIDxsaW51eC9tbV90eXBlcy5oPg0K
PiAgICNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9tZW1y
ZW1hcC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3BrZXlzLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L2RlYnVnZnMuaD4NCj4gICAjaW5jbHVkZSA8bWlzYy9jeGwtYmFzZS5oPg0KPiAgIA0KPiBAQCAt
NTQ5LDMgKzU1MCwxOSBAQCB1bnNpZ25lZCBsb25nIG1lbXJlbWFwX2NvbXBhdF9hbGlnbih2b2lk
KQ0KPiAgIH0NCj4gICBFWFBPUlRfU1lNQk9MX0dQTChtZW1yZW1hcF9jb21wYXRfYWxpZ24pOw0K
PiAgICNlbmRpZg0KPiArDQo+ICtwZ3Byb3RfdCB2bV9nZXRfcGFnZV9wcm90KHVuc2lnbmVkIGxv
bmcgdm1fZmxhZ3MpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9uZyBwcm90ID0gcGdwcm90X3ZhbChw
cm90ZWN0aW9uX21hcFt2bV9mbGFncyAmDQo+ICsJCQkJCShWTV9SRUFEfFZNX1dSSVRFfFZNX0VY
RUN8Vk1fU0hBUkVEKV0pOw0KPiArDQo+ICsJaWYgKHZtX2ZsYWdzICYgVk1fU0FPKQ0KPiArCQlw
cm90IHw9IF9QQUdFX1NBTzsNCj4gKw0KPiArI2lmZGVmIENPTkZJR19QUENfTUVNX0tFWVMNCj4g
Kwlwcm90IHw9IHZtZmxhZ190b19wdGVfcGtleV9iaXRzKHZtX2ZsYWdzKTsNCj4gKyNlbmRpZg0K
PiArDQo+ICsJcmV0dXJuIF9fcGdwcm90KHByb3QpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTCh2
bV9nZXRfcGFnZV9wcm90KTs=
