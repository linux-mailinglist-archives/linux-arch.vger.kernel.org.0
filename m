Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56D5F5F9A
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 05:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJFD0t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 23:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJFDZy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 23:25:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC60C60519;
        Wed,  5 Oct 2022 20:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVEWYRhPOBRcF4w8RRdVkT06KDdqQNhfpC1SZNxERpUTxURzK516Tcf34MisDvS5RCRi2ck7V47pShOs+xDC+4Cy4vsyZ0qUOC9Wuf0PVfEVPDNLx+kqVq7cLqy7eV9KsAAC/pmcNR35UTSNN4vsHH3hN0MDz1fdfBCwIrsq9hXq/25X28poWv90W6fKRsS/q9M7cU8P/6i5LINF1zpRtoWTBzrM5o+ySMJas4ngaXGpjO22QcdpH6jOYJTajGtG8jHzBLOGdLWw5izlYmg7k5CQeQ8eut8T48AjlH8vlFAKckOvXX47p/DOfuFttRSc7X4ZVpF0UND8D07o7IR/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHdpEkNYXeK88v5uDKv95swXOiwk5TdrxQYzT/DjjF8=;
 b=GmQRPOYjB2sTtIlXfGlJNWo5Wkkn7fNkrLk8NPGKOMc2SxPgcrb6Q278iZ/Jkd/ZY9SuxgSXuft9Rr14ZLjvlzSgB0/VcbHsgmLe4CWWziPnWYML1w4K6n+8vL7Fa82jk0Dl+Xsen81GAnkgc98h7LNyWUuHPowzmC/jsS7Z2dw5OAaHpNgkfmc8El8xqwjAqgq1ycVj41w/fpP9OjCPurpt/3QKlcAqpRABAvXjga+cZURNzdEfBsSooU7i6WlZ0E38kZhEMRREq+dbpXpeu8tJivLGkKO1Vd9OkL0hkSmHCURKvQRZJtgl7hWLouWgvAujZ+FLp6pYeSNHrH6/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHdpEkNYXeK88v5uDKv95swXOiwk5TdrxQYzT/DjjF8=;
 b=QiYn+GveJPJk26iuKDNjoIgeG+sfuYdIyQ0CyKX696qizGo+m0Lgvx7bnaQK/UJhJzfplmPnjoE62x0m+clpLyULVhpIuLzolR6heDdVrNcq/RsR/fj97kiKGRk3Xpowf8k3Wg6+dByhp0BoTJK5UioPzBU0HODVV2hozhOZ30Dl92QvlcRtfdR1/QoLOvg1Lp2HXRqgD/yZUE4a2NZ05pI1iXgzN35Ixx1KLe/3BAkX9dki/eTeBV8SxQaNzDx9S6w6w1lHwnbFxdQr1U1O9AUoY7poOA1stIaZf8WPksO7aSLIJ6zK3cteJNsGMmE1kX1NOKla4O49HkB4BFx+Rw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 03:25:48 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a%5]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 03:25:48 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Akira Yokosawa <akiyks@gmail.com>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        Dan Lustig <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v2] locking/memory-barriers.txt: Improve documentation for
 writel() example
Thread-Topic: [PATCH v2] locking/memory-barriers.txt: Improve documentation
 for writel() example
Thread-Index: AQHY2KgAyntXB8tE2EqVYIIWW3s9264AqswAgAAHyZA=
Date:   Thu, 6 Oct 2022 03:25:48 +0000
Message-ID: <PH0PR12MB5481D87865AA1F5A21A334DFDC5C9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221005104749.157444-1-parav@nvidia.com>
 <6a6941fb-53a0-cdd2-9783-590cb959d4e7@gmail.com>
In-Reply-To: <6a6941fb-53a0-cdd2-9783-590cb959d4e7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BN9PR12MB5131:EE_
x-ms-office365-filtering-correlation-id: 1f7b6595-4742-4cae-0a6f-08daa74a7683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THa7T+w+G4FnkRRg1CRrEd8AZXZQnzd4vup9k/X61IjKyb4VWQt3bLeLHbyJm6H7IfMMjsmLfPg3l8KY9fpLuc5xjo7Tgh2EJuHGg030Oiy4L8m5Cxx1CYhsTgaTloq7CM4tZeOvvEEDgbEpgxBIgSyjwYD3JL48jCT8P5qvP97sw1T58YsmE6TVR/Tt1kN5Oi+4pJ0PNbfrWY2DLjbpqdD9eW+wpi1oaUnoVrvTuhOt67Y7eW43oVTCzTPP3dnvN7PeNAkPssPpYbMlSwkn80+1Jk2eBCmW6+h7G9YxDxmJhIT1fikmUs0Yb6r38Cpgj5DJR+EWNyctqldUuISk3O3BAnbeWRQCh6zKI5X6wm0/1prOvEWWoauUFLmnN2rGpTnatyI4DslMycxZnQDlTaqMW6TOZY9KXoox97vddpDrWml4j3SdWhE5RyHoJ0V/CfJd8ggFjz13uaZXkqwgRGJtl/gBtmMBYTkaHNetjlULVcDICqoClcetxs6fhJNNpQOwtlNRpff28Od1+BxCctHzpxwze0QrHbvGjJbx9yYRtYJ52L5HcumBkDeXTyHijnyl9rtANiqQlLDK5bGjDIasCS7DT9C4nVjAfZ/sNzE4Vv76GcTwjUsca6nt4mNqT8Ampn7OL2clfaq4McvtktrHRuam4Kj8+tI3Kf3O/Rh++GvzDAHiUBZVBpqOcvY2jgGNkt1kWH0dLDrGJJglePT/fW4uXFBlDBWFU/5qyj2XGOyKhzOA+fmQdq5p2IdIHoEcyuZldCIB4Kpg1E6Gkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199015)(8676002)(6916009)(316002)(54906003)(26005)(7416002)(5660300002)(83380400001)(8936002)(41300700001)(9686003)(186003)(52536014)(478600001)(66446008)(76116006)(66946007)(86362001)(71200400001)(4326008)(55016003)(33656002)(66556008)(64756008)(66476007)(7696005)(6506007)(38100700002)(2906002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEF5ckdzakdtL29qRUFBYVZrT21RYkFVbmpZVEtQRDF3MUoxVk9mbk1Sd1Fq?=
 =?utf-8?B?dHUrVko3aWtIQjJEL2ovUFNJeUhDWlVtcE9iUXovYks2STU4ajAzVGdhTFd3?=
 =?utf-8?B?S2xZdXFxeldRcEtYV1V4aEJqTkE2ZUZxY0hCWkp1UjhSS0Z4Rk9GY3NOcFQw?=
 =?utf-8?B?NDJWdWJTT1R3Z0hKbDFGck9sUkFHYW1OaU5La2cxeXhJWlRKTms2Sks3MUsr?=
 =?utf-8?B?NzZ5enVTbkJaYlFBT3ZCSkU5SUtxRUNNbDB2bG03VWFQS3AwVXlkaE1FRVpK?=
 =?utf-8?B?MTBPOFdqNERkVm1QY0V3L0p1V1V2dkd2cnh2SDVDRUgybXQ0NXIyN1lhbnFY?=
 =?utf-8?B?cXNGcDdpZmMrVXc2azZZSDZKeTc2SVpSUGhsTW9Hb1I1QVVidHBaemlXbVh5?=
 =?utf-8?B?cUFBT2VQbHllU2d4Q0RWaVlJT0hqZlBKd0dIRU44b3lwdFNGZHdYM09CUkFF?=
 =?utf-8?B?MEY0WVlYZktRb25PbWNBcW8yWkFzbnhlV0V2ZGNBVDM1UHlmRE1nSDFQNUlo?=
 =?utf-8?B?SkhGV3o1RHNnYjJJemRhY1ZYZEpkaGxDbHdLcTZMMlpnU3pUTEVTWTN4NFpl?=
 =?utf-8?B?QVF0K0NKdDBQYXArUW9CeURpbDdmV3FJWFhnWDBLL0I0RFhqKzhWSWVxSlpl?=
 =?utf-8?B?NkoyRmd1Vm1YZEhJZ0p2dUxab3BOOTZOSFFEek1NN3hPRitKaHVsbnZsbVBq?=
 =?utf-8?B?eGd2NDhFWlVKcXBWeXlqc3o1cjlERFFoWE9jZFcrMytqVURyT01ocEp6L0hy?=
 =?utf-8?B?aVJ5Q0ZiSmFBR2M3aWZ4OHRiNi9oS2pmcUJpMzMwSzZLNkNQZFQvODMrWlZ4?=
 =?utf-8?B?cEQ1WVVSVUZWQ3IvOVgvaEQrREl4VHN3dFFKMkdXWTBSSjJ4Q0p1RG1XYlRY?=
 =?utf-8?B?cjRUZEY3ZUNEc1RURDdvSi9vQ3hBVUwxenFxU01RWlpoNHhCYXFZNU50OGVU?=
 =?utf-8?B?c0F4Tm1ucXk4QUtNTWc4UnJTZWlhM3VMS21pZ1ZWSDBqTE94ZmNOMEZXZjFm?=
 =?utf-8?B?bFVCTVYrTTcwempaNFFtRXdORGtpenAxRVlvNUlqbytueWFRK2JzTVNFMkx0?=
 =?utf-8?B?NzhDdWpGRmxJdTVnUTF3RU5OTzB0YnQ2RUhSVWQ4aUMzMnpFUVQxamxzL1NC?=
 =?utf-8?B?SHZ6TW80a093MTBWeFE1SGlMV2tOQnZyckhaQUVNRXZSN2NUTWlSMEI4d1Av?=
 =?utf-8?B?eXJuUE44SjlRU1Q5d3o0S29WU2VxeUhHSFFjV3ZreFFjRjVudmFXMXI3ZU9P?=
 =?utf-8?B?V1Raais4RXVmcjd2dEFpbzgwYkc3ejJFRVR0cTBsYnc4bkZIaEEzcWs3Y2R4?=
 =?utf-8?B?QUUwV2sramMzeEV5SzhBSGVOa0xFZTFBd0xKaWJYRFBUMTVFTjUrbzJpeWFi?=
 =?utf-8?B?TWdCUitLNUFKN0dOVVRRYVRGalg4UW04MEhuZjFqdEVlajNJOG9sOUFxdUFj?=
 =?utf-8?B?SXRUZG9XbUg1eTZpNmZwamtwalQzVzlVM1RuRFZ0ZGJUcjFnaytWcUxUbXRR?=
 =?utf-8?B?bmdialJKamRVRzhMODNaSUROck9hbTZHSy9abEFjY21HcE01VEtMMDdPa3J1?=
 =?utf-8?B?S3RHU2ZlM3Rha1ZSVUhWemowSTcwVTVGUDVvWGpXSnZtekU0SC90NStrZ0lv?=
 =?utf-8?B?T2xpNytrN3IraFZrRDlIYnFYYUJKamlEVllwdDFEajVUaWhYK2pvTFhaZ3RE?=
 =?utf-8?B?SVFBWllRN0dNTlVnZnBwbGoxYWNlU09KelRGZFNCN2ZXbjBzQ0U1Qkg2UmUv?=
 =?utf-8?B?Y1pkOTRSMDMvdnc5cWJkOE45NG1wbUdUMDQ5Vk5UY3gyYXlveFMvVmIxTXRj?=
 =?utf-8?B?MllWVklhbjJlTnBScHQvYU9aUmd0ckFQQnA4a1d1WXduenREc0sweHorVzlu?=
 =?utf-8?B?aStVWEJXUGd6MmhQeGV0ZnJGTEowdjZLWkNqek00UVNTS0Z3cnAxcHl5THpa?=
 =?utf-8?B?dFdXRmVtNjlNWHVTOWFqRmRTQU15bmJUdXA2aFZzb3ZrQnNJdUZ1SGpnVktm?=
 =?utf-8?B?WENhTFpQSHh6eitjNnAxem1jVFZFQjBERjNwNW9ZMVpNSFhma2VGNHgwQVpC?=
 =?utf-8?B?Nk9KdjZtVzFtZS95SFkwOGtNeEtUNVB6MnoyZXlEL1NURVpRdS9ROHlacllo?=
 =?utf-8?Q?1uZU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7b6595-4742-4cae-0a6f-08daa74a7683
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 03:25:48.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6gNHjgMV8LKTUqyMoheoeVduN5pfJZthYvvoGpV+QcZ9aK/x1FxOgwa4/LA8OTu8GpGGQA0FHDtnoR2wRNxS4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQo+IEZyb206IEFraXJhIFlva29zYXdhIDxha2l5a3NAZ21haWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgT2N0b2JlciA2LCAyMDIyIDg6MTggQU0NCj4gDQo+IEhpLA0KPiANCj4gTWF5YmUgSSdt
IHRvbyBuaXQtcGlja3ksIGJ1dCBzZWUgYmVsb3c6DQo+IA0KPiBPbiBXZWQsIDUgT2N0IDIwMjIg
MTM6NDc6NDkgKzAzMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPiBUaGUgY2l0ZWQgY29tbWl0
IGRlc2NyaWJlcyB0aGF0IHdoZW4gdXNpbmcgd3JpdGVsKCksIGV4cGxjaXQgd21iKCkgaXMNCj4g
PiBub3QgbmVlZGVkLiB3bWIoKSBpcyBhbiBleHBlbnNpdmUgYmFycmllci4gd3JpdGVsKCkgdXNl
cyB0aGUgbmVlZGVkDQo+ID4gcGxhdGZvcm0gc3BlY2lmaWMgYmFycmllciBpbnN0ZWFkIG9mIGV4
cGVuc2l2ZSB3bWIoKS4NCj4gPg0KPiA+IEhlbmNlIHVwZGF0ZSB0aGUgZXhhbXBsZSB0byBiZSBt
b3JlIGFjY3VyYXRlIHRoYXQgbWF0Y2hlcyB0aGUgY3VycmVudA0KPiA+IGltcGxlbWVudGF0aW9u
Lg0KPiA+DQo+ID4gY29tbWl0IDU4NDY1ODFlMzU2MyAoImxvY2tpbmcvbWVtb3J5LWJhcnJpZXJz
LnR4dDogRml4IGJyb2tlbiBETUEgdnMuDQo+ID4gTU1JTyBvcmRlcmluZyBleGFtcGxlIikNCj4g
DQo+IFlvdSBjYW4gY2l0ZSB0aGUgY29tbWl0IGluIHRoZSBDaGFuZ2Vsb2cgdGV4dC4NCj4gSnVz
dCBzYXk6DQo+DQpJIHByZWZlciB0byBhbm5vdGF0ZSB0aGUgbG9uZyBjb21taXQgYXMgYSBzZXBh
cmF0ZSBsaW5lLiBUaGlzIG1ha2VzIHRoZSBkZXNjcmlwdGlvbiBzZW50ZW5jZSBlYXN5IHRvIHJl
YWQuDQogDQo+ICAgICBDb21taXQgNTg0NjU4MWUzNTYzICgibG9ja2luZy9tZW1vcnktYmFycmll
cnMudHh0OiBGaXggYnJva2VuIERNQSB2cy4NCj4gICAgIE1NSU8gb3JkZXJpbmcgZXhhbXBsZSIp
IGRlc2NyaWJlcyB0aGF0IHdoZW4gdXNpbmcgd3JpdGVsKCksIC4uLg0KPiANCj4gQWxzbywgYSBi
bGFuayBsaW5lIGlzIG5lZWRlZCBhYm92ZSBTLW8tYiB0YWdzIGFzIGEgZGVsaW1pdGVyLg0KPiAN
CkFkZGluZyBibGFuayBsaW5lIGluIHYzLg0KDQpbLi5dDQo+IElmIHlvdSBwZXJtaXQgYSBzbGln
aHRseSBsb25nIGxpbmUgaGVyZSwgdGhpcyBodW5rIHdvdWxkIGJlIG11Y2ggZWFzaWVyIHRvDQo+
IGNvbXBhcmU6DQo+IA0KVHJ1ZSwgYnV0IGRvY3VtZW50IGNyb3NzZXMgdGhlIDgwIGxpbmVzLiBT
byBJIHdpbGwga2VlcCB0aGUgZXhpc3RpbmcgYWxpZ25tZW50IG9mIDgwIGNoYXJhY3RlcnMgcGVy
IGxpbmUuDQoNCj4gKyAgICAgYSBkbWFfd21iKCkuICBOb3RlIHRoYXQsIHdoZW4gdXNpbmcgd3Jp
dGVsKCksIGEgcHJpb3IgYmFycmllciBpcw0KPiArIG5vdCBuZWVkZWQNCj4gICAgICAgdG8gZ3Vh
cmFudGVlIHRoYXQgdGhlIGNhY2hlIGNvaGVyZW50IG1lbW9yeSB3cml0ZXMgaGF2ZSBjb21wbGV0
ZWQNCj4gYmVmb3JlDQo+ICAgICAgIHdyaXRpbmcgdG8gdGhlIE1NSU8gcmVnaW9uLiAgVGhlIGNo
ZWFwZXIgd3JpdGVsX3JlbGF4ZWQoKSBkb2VzIG5vdA0KPiBwcm92aWRlDQo+ICsgICAgIHRoaXMg
Z3VhcmFudGVlIGFuZCBtdXN0IG5vdCBiZSB1c2VkIGhlcmUuIEhlbmNlLCB3cml0ZVgoKSBpcyBh
bHdheXMNCj4gKyAgICAgcHJlZmVycmVkIHdoaWNoIGluc2VydHMgbmVlZGVkIHBsYXRmb3JtIHNw
ZWNpZmljIGJhcnJpZXIgYmVmb3JlIHdyaXRpbmcNCj4gdG8NCj4gKyAgICAgdGhlIHNwZWNpZmll
ZCBNTUlPIHJlZ2lvbi4NCj4gDQo+IFRoYXQgc2FpZCwgSSBkb24ndCBmZWVsIGNvbWZvcnRhYmxl
IHdpdGggdGhlIHNlbnRlbmNlIHlvdSBhZGRlZC4NCj4gSXQgbG9va3MgdG8gbWUgaXQgaXMgcmVk
dW5kYW50IGJlY2F1c2Ugc3VjaCBhIGd1YXJhbnRlZSBvZiB3cml0ZVgoKSBpcyBhbHJlYWR5DQo+
IGNvdmVyZWQgaW4gdGhlIHNlY3Rpb24gb2YgIktFUk5FTCBJL08gQkFSUklFUiBFRkZFQ1RTIi4N
Cj4gU2VlIHRoZSByZWxldmFudCBleHBsYW5hdGlvbiBxdW90ZWQgYmVsb3c6DQo+DQpJIG9ic2Vy
dmVkIHRoYXQgdG9vLCBidXQgSSB0aG91Z2h0IGl0IGlzIHdvcnRoIHNob3J0IG5vdGUgdG8gYWRk
IGFsb25nIHdpdGggdGhpcyBleGFtcGxlLg0KQnV0IEkgYWdyZWUgc2luY2UgdGhlIG5leHQgcGFy
YSByZWZlcnMgdG8gaXQgYW55d2F5LCBJIHdpbGwgZHJvcCB0aGlzIDJuZCBhZGRpdGlvbiBpbiB2
My4NCiANCj4gCTMuIEEgd3JpdGVYKCkgYnkgYSBDUFUgdGhyZWFkIHRvIHRoZSBwZXJpcGhlcmFs
IHdpbGwgZmlyc3Qgd2FpdCBmb3IgdGhlDQo+IAkgICBjb21wbGV0aW9uIG9mIGFsbCBwcmlvciB3
cml0ZXMgdG8gbWVtb3J5IGVpdGhlciBpc3N1ZWQgYnksIG9yDQo+IAkgICBwcm9wYWdhdGVkIHRv
LCB0aGUgc2FtZSB0aHJlYWQuIFRoaXMgZW5zdXJlcyB0aGF0IHdyaXRlcyBieSB0aGUNCj4gQ1BV
DQo+IAkgICB0byBhbiBvdXRib3VuZCBETUEgYnVmZmVyIGFsbG9jYXRlZCBieSBkbWFfYWxsb2Nf
Y29oZXJlbnQoKSB3aWxsDQo+IGJlDQo+IAkgICB2aXNpYmxlIHRvIGEgRE1BIGVuZ2luZSB3aGVu
IHRoZSBDUFUgd3JpdGVzIHRvIGl0cyBNTUlPIGNvbnRyb2wNCj4gCSAgIHJlZ2lzdGVyIHRvIHRy
aWdnZXIgdGhlIHRyYW5zZmVyLg0KPiANCj4gQWxzbyBwbGVhc2Ugbm90IHRoYXQgdGhpcyBkb2N1
bWVudCBzaG91bGQgbm90IGRlc2NyaWJlIGFueSBpbXBsZW1lbnRhdGlvbg0KPiBkZXRhaWxzIG9m
IHRob3NlIGFjY2Vzc29ycy4gVGhpcyBkb2N1bWVudCBpcyBub3QgbWVhbnQgYXMgYW4gaW1wbGVt
ZW50YXRpb24NCj4gZ3VpZGUsIGJ1dCBhIGd1aWRlIGZvciBrZXJuZWwgZGV2ZWxvcGVycyB3aG8g
dXNlIHRoZW0uIFRoaXMgaXMgY2xlYXJseQ0KPiBtZW50aW9uZWQgaW4gIkRJU0NMQUlNRVIiIGF0
IHRoZSB0b3Agb2YgdGhpcyBmaWxlLg0KPiANCkluIHRoZSBkaXNjbGFpbWVyIHNlY3Rpb24gSSBk
aWRu4oCZdCBzZWUgYW55IG9iamVjdGlvbiB0byAiZGVzY3JpYmUgYW55IGltcGxlbWVudGF0aW9u
Ii4gOikNCkZvciBleGFtcGxlLCBkaXNjbGFpbWVyIGl0c2VsZiB0ZWxscyB0aGF0IGEgYmFycmll
ciBtYXkgYmUgbm8tb3AgdGFsa2luZyBhYm91dCBhIHBvc3NpYmxlIGltcGxlbWVudGF0aW9uIG9u
IGEgcGxhdGZvcm0uDQoNCkJ1dCBJIGFncmVlIHRvIHlvdXIgYWJvdmUgcG9pbnQgdGhhdCBhYm92
ZSAjMyBhbHJlYWR5IGNvdmVycyB3aXRoIG15IGFkZGl0aW9uLg0KSGVuY2UsIEkgd2lsbCBkcm9w
IHRoYXQgcGFydCBpbiB2My4NClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KPiAgICAgICAgIFRo
YW5rcywgQWtpcmENCj4gDQo+ID4gKyAgICAgbmVlZGVkIHRvIGd1YXJhbnRlZSB0aGF0IHRoZSBj
YWNoZSBjb2hlcmVudCBtZW1vcnkgd3JpdGVzIGhhdmUNCj4gY29tcGxldGVkDQo+ID4gKyAgICAg
YmVmb3JlIHdyaXRpbmcgdG8gdGhlIE1NSU8gcmVnaW9uLiAgVGhlIGNoZWFwZXIgd3JpdGVsX3Jl
bGF4ZWQoKSBkb2VzDQo+IG5vdA0KPiA+ICsgICAgIHByb3ZpZGUgdGhpcyBndWFyYW50ZWUgYW5k
IG11c3Qgbm90IGJlIHVzZWQgaGVyZS4gSGVuY2UsIHdyaXRlWCgpIGlzDQo+IGFsd2F5cw0KPiA+
ICsgICAgIHByZWZlcnJlZCB3aGljaCBpbnNlcnRzIG5lZWRlZCBwbGF0Zm9ybSBzcGVjaWZpYyBi
YXJyaWVyIGJlZm9yZSB3cml0aW5nDQo+IHRvDQo+ID4gKyAgICAgdGhlIHNwZWNpZmllZCBNTUlP
IHJlZ2lvbi4NCj4gPg0KPiA+ICAgICAgIFNlZSB0aGUgc3Vic2VjdGlvbiAiS2VybmVsIEkvTyBi
YXJyaWVyIGVmZmVjdHMiIGZvciBtb3JlIGluZm9ybWF0aW9uIG9uDQo+ID4gICAgICAgcmVsYXhl
ZCBJL08gYWNjZXNzb3JzIGFuZCB0aGUgRG9jdW1lbnRhdGlvbi9jb3JlLWFwaS9kbWEtYXBpLnJz
dA0KPiA+IGZpbGUgZm9yDQo=
