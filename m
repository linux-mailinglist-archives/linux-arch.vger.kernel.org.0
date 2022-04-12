Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36D4FE157
	for <lists+linux-arch@lfdr.de>; Tue, 12 Apr 2022 14:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiDLM7S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 08:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354820AbiDLM4x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 08:56:53 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F82A4D611;
        Tue, 12 Apr 2022 05:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8RvQqTtNpwnrtsqoRh17iraYn6DUd7CanWu0ygxB6q5Q7S6mm6/2JQvK3m+4A4TCTLy/h62iTVuZiy39oa8JqblYmh+1j8YDrJjTdfwX0LGxV5HnBjRDiRJn/AlWB8ZzHvX42xa8SZRZrmWX9L2Xo+Hy5efwYcNPE4DpzQNDS5TwEyRku9984zdumenOsdO9uf4VlcwE11a31s0O3OCHUq0i4kpGoRBFEWVaTqXbvok+ejuPBzWw6HL17ZHHjZxB0kb1Gx58rUbwj8wEJoGuO9JKbzKv1Qk/TowmuF+iE5Okd7WF3t3X0Es0A3X8YJl6WpqxAS3CtSsnnoawW3UPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=el11HsS71lefoMzcvMPVtVlGuXUd4+R9QyEFI1J89oQ=;
 b=LdkZf0ibPbBE9f9VssZzUN2c4ljneRpYOHxFur+W+fX+9TGa/jIyR/CSdRcQLuROSl5MZkLwGG79QyOyzMemBcTRpiUdqs2k07m3YDklIHo9M4M6VX+XkGgVlqDcB2xXnOB20e4ktHBLhpMz/RSZ1+5DFjbYoFZO8UDMGLpv0W3iwRzQJD+AJbIF1chDMQ127PBJ4/DIJI4GqFySqkQ4yodvIijSu7k86JcaaASYwHzcdbThEV8MNthy/eoV521CB0hWz6tkvjsdFlTtPWWCVUWkuskLN1vY+tnyN/TcDvU5buT5eBFCC6l2Eu/GfIQ9DLY45l/i+V2DrRIKRkA7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2665.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 12:30:44 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::59c:ae33:63c1:cb1c%9]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 12:30:44 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 7/7] mm/mmap: Drop arch_vm_get_page_pgprot()
Thread-Topic: [PATCH V5 7/7] mm/mmap: Drop arch_vm_get_page_pgprot()
Thread-Index: AQHYTic7TC1Upfj0QkagENkxhWjEtKzsNfEA
Date:   Tue, 12 Apr 2022 12:30:43 +0000
Message-ID: <99d110d7-6c99-c42e-e93a-a6bc7cbde8d8@csgroup.eu>
References: <20220412043848.80464-1-anshuman.khandual@arm.com>
 <20220412043848.80464-8-anshuman.khandual@arm.com>
In-Reply-To: <20220412043848.80464-8-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da343467-779f-4409-7563-08da1c80438d
x-ms-traffictypediagnostic: MRZP264MB2665:EE_
x-microsoft-antispam-prvs: <MRZP264MB2665B4B46477CC0758AE77F3EDED9@MRZP264MB2665.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OwTThoxPX5Mvo1OrLsRaQia8PgPsn5PEXFIB31+i0SAOwDzj6gIie5g8u4JXUuBxmXiLa//CZx5avWNAgmthaeEsPmAEgc/yN8WIEHDyZq+CkwfhZT3PIi0lsAGrCvrkmD3Z8efwGxVjxyDn+R5cpc081p8h2N2SFFMi5EBqYF1tqL48FIyPaKoF6rqaEQzvDF/mXOdVbYQExzcQ8TpgoWvVKtLtRZw0aQhTT5gFALdhJ5N2j4W7+Lyeqd5ZPtVm2TT4f1u1t4io5UZ5A3Twlh91Ig9oF1CMiKEkm6Rw/KeeX6LfLV08oB3pSNIQ+8KqMShJ6i31AifydJKSjnrpTzdRHdBKW0rxZwyHR32CZT8/epqSNbeMqZ3popcqGzU5PIKdF15xEYqg5cDIWhQQ7rKzV4iVhR0aIEOgziwEUd5Gv0/p6cmLcxYN8cIaqFzskqJJUbimTDwie7TcWkcleGJUjrq1eBA8tTFKKeKndz1jrIjRAJqC8BWbnzxQEkM8qaIw7qCrtOBQld9ADCWtYXzrPQWNFqs1SIFOYLqpNC2UuDC7eb4AI3qJZlzcFmSgwSLO1YH9mtVSlLCXUMhSh8y/xUiqsSZtn1ApllcsTJNnwpaPNGFojhzXw76Brtmb6EHbmNI41MKduswwDjxaFLFpEynLZ5jkeu6aCTo8KEQPjuan3zcjFwXObibcN7UM7X6xyjzEUPrtWzLjiznpaNCQt3BpvhiVikPlrntBoUPN1FtlGmGaeCePm0KoKbY+SJSiBLY4U2lpbp7s40le2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(91956017)(66556008)(4326008)(38100700002)(6506007)(66476007)(66946007)(76116006)(8936002)(6486002)(66446008)(7416002)(8676002)(83380400001)(31696002)(64756008)(508600001)(122000001)(31686004)(110136005)(54906003)(36756003)(86362001)(38070700005)(2906002)(26005)(186003)(71200400001)(316002)(2616005)(44832011)(66574015)(6512007)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDc2SmNleWhEWFJSNENVemM3dXhMWjlrRVIzOFEzdG82UTljdGtTWTNEa282?=
 =?utf-8?B?a3IzOWt0RjR1aHhQN1FRd2doSVo4UERac1l6RkJuRmhUTDlMU2MwSUt1cHJt?=
 =?utf-8?B?YWl4ejMxY3R0c0kxa1dOWnV3bW56akppOGtEQlE3RlpHd3p0ZWtmOVhjd3Ry?=
 =?utf-8?B?MUlYblovR1pyUnV1ZHZIWGxWa2xZaUorMDNCdGVIU2s2N3NlN3Z0S1o4T0x1?=
 =?utf-8?B?Tm1ZZm9oWSt5K0VGQTVOWWJsK3daZ0MyWTE0VHlNOU1MOGFIdEZOQWZ0b3VH?=
 =?utf-8?B?eTd3dEdqMHh2Y3V1QXM4UmRaOGk5QVJqWG9wMGRZZHRMV2VwWHNzVER3em0r?=
 =?utf-8?B?SnJiM0loYlVZUDFoRFlOWFVad1pIOUpEMEJObldVU1RiV3FMbTFnTFJxb3Jo?=
 =?utf-8?B?VmpRYUw2d0NYbXQ3dDNoSHlpTXBZcjJ1VHN0NjBzSXdsYW5GU2pYdE9JMmtC?=
 =?utf-8?B?K3NlcEhHN1hwaXN6d1NZZjNSWmM0K3p3LzYvVVRoUjRMQmVFang2UVQzRlVu?=
 =?utf-8?B?RkxpaXhUZUh0V0NicFdpLzFZelJBcHIzd0toUGp6Z0EyT1lxc1RTaDZackdh?=
 =?utf-8?B?QUN4V2VZcEl1M20zZVlwdDJscU5MUi83TDREUFk3UXdYMHNKSGJsRGg2eU11?=
 =?utf-8?B?d3FUUW0vUmdyMFZrNlRmajJTTVAxWW5FZy9ieUFMUFBHNnJYejN5Rk5hYy9o?=
 =?utf-8?B?OVhCVmRqTE1HTVdpNWN1YUxtOWFIenJDKzRXdXVaUXkyY3R5VWUwTjlCQklG?=
 =?utf-8?B?MzFrVExrMDhobEVOcUdLYk9uaWcvdXFyT2VTTXh3NXZDdUZmZmVTcDAxc2FI?=
 =?utf-8?B?UXZDaG9xRGxMWDU3Vi9VY3kxNXBXQ2pMSm5jRW5OdWF5cWhPOEcwR0F4ZXNt?=
 =?utf-8?B?cHZMVkZIb28zZHZXQXNqVG9hczF3RCtrMk9scjhMQnpqZE1KRmVPZFowZ1Fi?=
 =?utf-8?B?NlJvV040VDAzRk9NYjN1SjEwY3VRQ3R3L3Z4MGVtUGxGZXI1eVU3amtVVDhC?=
 =?utf-8?B?ZENUOFV0NUVRYkZJdDJWRlVsVkxpbEJneGh0U1JOc24raDBkMFVydllqUHkv?=
 =?utf-8?B?TGZqS21JcXBqTzNXRXJvVnFic0E5UlFySnhkckVOc0M3T0VrSEwxSTJzNm5M?=
 =?utf-8?B?RGVIdnQ2NjdKV1B4UndBeHlheUQvdUsvekhlSXpyUnVLcUNwZ3p4V3JFc3FB?=
 =?utf-8?B?dDcyQ3IyVVNrVEdPc3BsdWpnZ2dyNFBHYVhrbkE3TE93ejBtM24xR0tiTXdD?=
 =?utf-8?B?VmJHT0tjYWV3Zzlyc1NXRjRCNE1BRmNrS3dnS0w4UkRlYkMwUE5hSDNDZTNo?=
 =?utf-8?B?cGlGZkpKT2tDemF3d0RIUVhnSnVQR1VkRlZuMmhqclY2bG9xNTI1Q3UyNngx?=
 =?utf-8?B?TUlZTFlWMmVOaWNxaUtjdU54RkEvb3FxU3JLbFVrMmdtYURlUHN5TjEwNDNV?=
 =?utf-8?B?SHl6c3dPbERqbTIyWU53VEYzNmRaMzJ4cUlPeWg1TitIaytaK3VVeDZNRDRH?=
 =?utf-8?B?eExsMzBiUGNTQzhzMW41Y2FZVDdwa01KcHZWWFpiRHdQUGxEL0xvdDZJU1N3?=
 =?utf-8?B?aldYL25aRGEyNXNDZUZ4UlVFMEtySFBpTDlmUTBZK1lDUFZEMEd1elB0Nk5I?=
 =?utf-8?B?aitxcFVpdU5NTlA2WlgzWG5tby9WMlR1N0hVZ3JvYjlod3Q2aFE2WmpmMXFk?=
 =?utf-8?B?UnRFUGFnRVMzakwvZFdtNjl3Qk1UY1YyUnRxOXJFSUFUTkcrdzYyY1lJME5G?=
 =?utf-8?B?K1NseFBNZkJMRVh0dVZNZ2M4d2R3UDV6WGtTZTNEbFBicFFyTkJnaitFWVNH?=
 =?utf-8?B?OXlGdS9TNHZidy9iTDBIOEZveEdLT2VNbC8yeGk4SWZ4Ly9ibXZ5YTA4ZUlh?=
 =?utf-8?B?TEJSVWxkR2YwdXJjMmczam1tTzdnczk4ZHE1QnhMZlpZanVwK0hhQW9hVk1v?=
 =?utf-8?B?bngreXA0WUVNaE9PMlF6U0ZDeTE5amNYLytYT0N2SDg5K1lpN2x1YVVKbWRv?=
 =?utf-8?B?VTA4d043UWx1UFJjYkkxNERHNjc4U3hGV2ZJcmpCNUN0V3RYdk96Yk5FN0Ji?=
 =?utf-8?B?ZndoN3ZsTWtKSFVuVjlUWWNBd1VXY2ZzbFlWdjRxSWJMck5KMzhaNFpQUmRm?=
 =?utf-8?B?QzZiRU12UXZ0Vm5PQTMvZUQxd3c2ZUZjM0RLWENBeXB4Zi9HaHk1VVlPUk5j?=
 =?utf-8?B?NktaRFJmdDdtSmZsZ2ZIdkxpUzVrS0FReklQLzdaRTVYR2ZpQjJzT1o3U09U?=
 =?utf-8?B?eDVJU2Mxb2t4Q2pDR2U2dEVtakJ0UWZjQjBWNDhKdTRWa3BTYzJXOFU3c1VC?=
 =?utf-8?B?UU1lZzNpYWtzTlQ5Q3B5L2ZGSXZZTUJrMDBiS3F2L0pBTllSMTFWUkM5K0hG?=
 =?utf-8?Q?1N9Fu8c+N4J6h+Negwoyj/sOQQWlt2NMlaKxN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D52AA4A775878E4CB6453D2DE1DAA7EF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: da343467-779f-4409-7563-08da1c80438d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 12:30:43.9988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 856gjqtb1vfcMc1rdZhRvi0sevPail2K4R6IYqOKhwohs/8fuFRCVEiv8XW/sLqgZZaVktdtIDKTh4o8Up+C1QPTgaEh9O6NxatKxh6JbF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2665
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDEyLzA0LzIwMjIgw6AgMDY6MzgsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFRoZXJlIGFyZSBubyBwbGF0Zm9ybXMgbGVmdCB3aGljaCB1c2UgYXJjaF92bV9nZXRfcGFn
ZV9wcm90KCkuIEp1c3QgZHJvcA0KPiBnZW5lcmljIGFyY2hfdm1fZ2V0X3BhZ2VfcHJvdCgpLg0K
PiANCj4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IENj
OiBsaW51eC1tbUBrdmFjay5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gUmV2aWV3ZWQtYnk6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEFuc2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBh
cm0uY29tPg0KPiAtLS0NCj4gICBpbmNsdWRlL2xpbnV4L21tYW4uaCB8IDQgLS0tLQ0KPiAgIG1t
L21tYXAuYyAgICAgICAgICAgIHwgMyArLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
bW1hbi5oIGIvaW5jbHVkZS9saW51eC9tbWFuLmgNCj4gaW5kZXggYjY2ZTkxYjgxNzZjLi41OGIz
YWJkNDU3YTMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1hbi5oDQo+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvbW1hbi5oDQo+IEBAIC05MywxMCArOTMsNiBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgdm1fdW5hY2N0X21lbW9yeShsb25nIHBhZ2VzKQ0KPiAgICNkZWZpbmUgYXJjaF9jYWxjX3Zt
X2ZsYWdfYml0cyhmbGFncykgMA0KPiAgICNlbmRpZg0KPiAgIA0KPiAtI2lmbmRlZiBhcmNoX3Zt
X2dldF9wYWdlX3Byb3QNCj4gLSNkZWZpbmUgYXJjaF92bV9nZXRfcGFnZV9wcm90KHZtX2ZsYWdz
KSBfX3BncHJvdCgwKQ0KPiAtI2VuZGlmDQo+IC0NCj4gICAjaWZuZGVmIGFyY2hfdmFsaWRhdGVf
cHJvdA0KPiAgIC8qDQo+ICAgICogVGhpcyBpcyBjYWxsZWQgZnJvbSBtcHJvdGVjdCgpLiAgUFJP
VF9HUk9XU0RPV04gYW5kIFBST1RfR1JPV1NVUCBoYXZlDQo+IGRpZmYgLS1naXQgYS9tbS9tbWFw
LmMgYi9tbS9tbWFwLmMNCj4gaW5kZXggZWRmMmE1ZTM4ZjRkLi5kYjdmMzMxNTQyMDYgMTAwNjQ0
DQo+IC0tLSBhL21tL21tYXAuYw0KPiArKysgYi9tbS9tbWFwLmMNCj4gQEAgLTExMCw4ICsxMTAs
NyBAQCBwZ3Byb3RfdCBwcm90ZWN0aW9uX21hcFsxNl0gX19yb19hZnRlcl9pbml0ID0gew0KPiAg
IHBncHJvdF90IHZtX2dldF9wYWdlX3Byb3QodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gICB7
DQo+ICAgCXBncHJvdF90IHJldCA9IF9fcGdwcm90KHBncHJvdF92YWwocHJvdGVjdGlvbl9tYXBb
dm1fZmxhZ3MgJg0KPiAtCQkJCShWTV9SRUFEfFZNX1dSSVRFfFZNX0VYRUN8Vk1fU0hBUkVEKV0p
IHwNCj4gLQkJCXBncHJvdF92YWwoYXJjaF92bV9nZXRfcGFnZV9wcm90KHZtX2ZsYWdzKSkpOw0K
PiArCQkJCShWTV9SRUFEfFZNX1dSSVRFfFZNX0VYRUN8Vk1fU0hBUkVEKV0pKTsNCj4gICANCj4g
ICAJcmV0dXJuIHJldDsNCj4gICB9DQoNCl9fcGdwcm90KHBncHJvdF92YWwoeCkpIGlzIGEgbm8t
b3AuDQoNCllvdSBjYW4gc2ltcGx5IGRvOg0KDQoJcmV0dXJuIHByb3RlY3Rpb25fbWFwW3ZtX2Zs
YWdzICYNCgkJKFZNX1JFQUR8Vk1fV1JJVEV8Vk1fRVhFQ3xWTV9TSEFSRUQpOw==
