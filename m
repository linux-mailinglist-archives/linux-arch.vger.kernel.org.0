Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C395F2858
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 08:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJCGEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 02:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJCGD7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 02:03:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ECE3CBF2;
        Sun,  2 Oct 2022 23:03:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKWfU1Dd/3b7+ufr1HM0yfmf3XS4GYzzLCxC5eZmDHuh28jxOsJJNuQjCXfW3BWJRfLk0l20gKjthXkUyQFM8n7BehC35gNg/5N+FnyPbkJC9J3SKYKoH7g+KODvlgJnfNzJcq3WFqR+/OtAXSr9S8u0rhbAhXLbv+4pRwJt2n2g/g3sJps/p498fZWzYBMAmePHRCQomoC2ogkSf4heilVqzMgR2CUxuaxmy29WpKGq6N9RzlrrDYrtWcOD8NjWXOpu1PbcSNmkwBV137kUNHUON0rMdQ3w5WZ4GDWxgfDgZZrT1pINeTAj3hlo657X+NmGakI4Y1YalpiXqgPyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ke5wXgN1NJXJ/PQMMDo6xDumim0f6ZHAVt3/vTknvaM=;
 b=ODuzgpeT+iEv2yNzqQi76COLe9Go4xMm9R+REP0xsSY/54Z2pMDx359F9MFJgjDZZEvEk6WhC7xypm4zm/ZK9Bidw24XyIIJKB2bbhY+4fqwKdBQjzelpOGT0VGUoqP+Z24pAkGBi0rWkWT/ukRKkssctOrc6Q0HZzi7CI0uQk6q13KJ0Jp7VqXq4AqjmWwb+zW0+tzM3PLIQ+AKgaLt8HCUWAxR1bGIbcmrVmlAn+xAhITVUTHdQwYnzAOKuGSj85NJirRlbvgs8+vpIxgBNNbtdDEjOckNKpL+nEEZzRj1wvhQr/TUoF0ZmmyAOas9e4Zjs/N4hgsX3FO3u8Wl3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke5wXgN1NJXJ/PQMMDo6xDumim0f6ZHAVt3/vTknvaM=;
 b=exSSfsghDIpXbxNYkBfyANZQtQPHnxfDu+UcjLrSLh2xZWKKck80hANW/FkTARIfUuNTQeLcB1M87Dts5JyIglDu6fqeTbgvTzgf0bP3GFTBEe1WbvsUwujGgBl/IdeD72fFLIVzk+n2nmA/pK0k5Vw8hnqa6kCYmlKQHaaA6uxf54oQznHI9p5q7XwkMJx2egved3UheW54o8pAk2r3VN/Yyvh5ohTQSMbNzrKBdR2Lo4Jhptngg70G5/ccd1FJZLYzjPwXL6Z+qIuIFjbusyJkBxDwNzUJP6hBdyoXpwgteNbF+/dfIBCgivNDVM+D70az0HFy87WYoyJUOhIH9Q==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Mon, 3 Oct
 2022 06:03:56 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a%5]) with mapi id 15.20.5676.023; Mon, 3 Oct 2022
 06:03:56 +0000
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
Subject: RE: [PATCH v1] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Topic: [PATCH v1] locking/memory-barriers.txt: Improve documentation
 for writel() usage
Thread-Index: AQHY1HD1laDrRIDleEGxkmQmi+hX2a33S8iAgATkr/A=
Date:   Mon, 3 Oct 2022 06:03:56 +0000
Message-ID: <PH0PR12MB54811586529AAFBD16F6A296DC5B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220930020355.98534-1-parav@nvidia.com>
 <5db465f3-698f-ebee-a668-1740a705ce9c@gmail.com>
In-Reply-To: <5db465f3-698f-ebee-a668-1740a705ce9c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB7128:EE_
x-ms-office365-filtering-correlation-id: da4e9191-b5d2-445f-fb59-08daa5050e5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lbwJBS/Rf/HTD03pUC3P5YAIDaUGXfbopmQpgK3JxJ2ZWVQtclqTcNuYimNlZ5jlJlBcrgPtekzGY8bOR+W6W22isQFu7t1wBaCiE/zYhPZGe5AAavuvv39ubAsrB+NFZeUFblKKRkU1YrQYCyIwLO4xu+T9khZuiLG4WAZd9y01DuU//mcYUAbrOFydXDyTT9iD9lNpD40zAxXzEOLvSWUDvXVBKW3delVrN0WWj9eEm54AmtYGitOMd5CCN177+3oTIS92DNdmEqmGf9gPo/bvxthGoQ+3H0PKpiFPR73w0xghDlxZwZ7hSRfwTVVdUBbVfyKBAp54SoH9DenRehe2+2r4XgfUlVgXmxHQpZDVXd6AmGWUc9kodXYPAS0YsWP4VlyvysDCv8kqDQn3nnAaoku2VNJpX4J9i+mLEXA5EuFK6oqz3ysFOyBYoXR4LZvuzaEylOitGRwlV9aviV6B76MFdxG8lM7r7KTjFzdnofHpWo2/wILZ0TLkIebxas//sXduqGdLkg2wXEPrCqVamWtNPDu/VPSkHbX45jjQ/0jOvuj/09AjeN1YVAYroo+NCfVGT6eR6Uz2u5cCYguxeTNgwmtOgxixwTfsRglqU7atxXQxpminNTkg+GFHwBrwBuy5K4LCaJa8QDFBkUgaamtGFcwkhgPixN9JxnUggSighhMKvK8wMYq+worX9wALUxI1OPGNGzS8Cn3Cjy4Y3Z+fAdTG3MzWDPFg29ZK0IZI5JIKomQErh+3G+0lBnu1Ppz9dKc3K5o3ANMn7VSZ2BqxcQ1qTm23sfceduq/xRrOBk4drWCUjyHEFGDhHwURYVkRborlSpURfjNj+MGU8P7SEkE7105tpWfGr/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(451199015)(41300700001)(9686003)(966005)(66946007)(478600001)(71200400001)(52536014)(76116006)(64756008)(66446008)(186003)(6506007)(8676002)(7696005)(66476007)(4326008)(26005)(33656002)(66556008)(5660300002)(7416002)(38070700005)(8936002)(2906002)(54906003)(6916009)(55016003)(316002)(38100700002)(83380400001)(86362001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXJJM01EcTlEdGNGUWw0WTJXQzZGRnhyZGhUOGhrc0dMeTd6VnhUNitKSXRH?=
 =?utf-8?B?ZEx2NUEyK1I4cnN4Nmd4MTJmOHIwWnN6cUlBNG90eGlGS0FQTmNiWWZnYXY5?=
 =?utf-8?B?TXdhRTViNTI0YjVJa0t2MVpBQWc4dGFTYStsaVU3bFFHMEdQTjNJQVBQQ1Jm?=
 =?utf-8?B?bStjWkdKSzFuakV4bUcwbHFmb29obmNzeGhuRUxRMUNUa3czZGZzOWpxTU5k?=
 =?utf-8?B?SFYycDhFZys1bDRXUnY0c1hIS2wybjVicVZzUk5ZUkk1V09vZHZBLzFnTkRG?=
 =?utf-8?B?SnBnTk1Ua1lEQ3d6R1NNY3U2VjlvSGxLbXd4UWU2Tkg5aXl1ZHhBUk01TTBV?=
 =?utf-8?B?d2JUL2UrbGNoZXAxVzMyMCs1Z2RBNVk2M1ZIRkZQK3IwNkZTa2ZmZEJCRS9V?=
 =?utf-8?B?QjB3eFZORGx1cU9mVVgvdjFyRmgxaHA0R3Q1Szh4RnpvUmlvc2NPNkUzZzNB?=
 =?utf-8?B?dzhiUW9vV21XU1NyT1RqNGs2Ujlydm1jMzc0Q3JSMzVrSEJySmRDTUhsU1hU?=
 =?utf-8?B?Q1E5dVFBVWtiRllFOElEdHRsN3U3VlFCUnExSGduT2dVS1BMZEU3eW1kTkxR?=
 =?utf-8?B?MmNzWmpIRHFYOTJneDREZjBsMEIvNFJmTzB2U0NHQmtGSE5oUmVuRkJLOWt2?=
 =?utf-8?B?MVhicUhhTVViYXExenNxT0VwczFhSGpNbE5CTXdxRFBNNFk2OG16L3JEbitj?=
 =?utf-8?B?RG8zQ3dSWUo0Q0F1OElQdkdXbUJ6ZHVTN0NsMWk3VkpLemNCbCtmbE1JR1d2?=
 =?utf-8?B?Vlk3b1UzMkl0UytnVG1WSXVhZHBIckVkeEpyc1NGbEpRTUVPa1E3dE1DNWFS?=
 =?utf-8?B?OU5qM2xkL0JRRk1UUHdKNkpBYXpXTmQ2RlA1aTFRSTk1TklzVEhRSnQzSkU2?=
 =?utf-8?B?dENEUXROZHhma2h3NDFhZEt4bmJFcjIwVjloaStLRzQ1TzhPUWFtUUxwUklD?=
 =?utf-8?B?Y0J4Qks4bXovajlZVUt4Z0pFQmpjVEtlZmtRbVVPNGpRb3JURWpoTHJLSHh1?=
 =?utf-8?B?Ukh3WnV4VHhkbWFkRGNveTNtWkY2emRQSjJhRGpGRUw0T09Fd1o4UjZWTDBx?=
 =?utf-8?B?bDdJamUzRkkyeElCZ01rRWI1V2JJMkllQmRoWjZJM1BQS1ZVbzNTbXVvQUtT?=
 =?utf-8?B?dS9YeTlHd2U2V3pPam5aMWZoVHJTd1pXWDFhcUlmR3A1UGRReHR5djhxRlY4?=
 =?utf-8?B?ZWNyRFNCSlNMSE5zRjlaRzFBV1Y0bTRNVUFwdlJ0bCs0cGtIRU5hL21uL3pq?=
 =?utf-8?B?ZGFQVXlaWWVJVDl4bjZsN0NmbVNLSkVXbHZjN1pCYWRkS1NoWThJazhlWWp1?=
 =?utf-8?B?T2Q3MTRXQmhsOWU3V3lPdkYwZEU4VlZFRlBOaE1uVVBUUGJmK3hwL29ZODdr?=
 =?utf-8?B?ZXkwcnNnOGRuQTIzSTBjUnpiQXlJQzlkSldjQnFMczdZd1pUZSsxOVBRTEV2?=
 =?utf-8?B?SFMzRXlsM3BOeWtYMUExbjNZZVNQa1cxencrYWFlbkNBUStvRDhaTis1SkRJ?=
 =?utf-8?B?ZnNlRFFPaXMxeHdoc3RlaE9SOHJmQldLaW9pamIwcElrUTBYeEsxTTZzN1lV?=
 =?utf-8?B?eTRZZzhGUzJkMjVjZ0crOG54VnI4ZE80QmE1eGtPK0pzeGhXUmlRcWNobTNW?=
 =?utf-8?B?SnRtMjBTNlV3eXM2NGFUeTlwOERyWFBtS2d1TUgySjFWMWJTcFZiU3VlK2Jj?=
 =?utf-8?B?Q0NzQnhiR3ZqNm1kTGt1RCtWMGpFV3AwcUxkalFIVG55WENVRSs5K2x1YnNr?=
 =?utf-8?B?dzkrQkV1RHhKL29WWnl3Z0ZSQmQxazZyOFFSRDd0UG9nL0haV0VpQS9sY0p4?=
 =?utf-8?B?WXpCZTVSVUJOeGdSUVByemJUbjA1Nkp4SldxSms3bkNSazVWc1pqVWRxYUE1?=
 =?utf-8?B?MEVOOGdDOUZpbXAxTFE0YmNYRy9aNm9yZlN1QU5HckIvZUlCdjIvUFFPQjUy?=
 =?utf-8?B?dW5WcElGNTIva2dhc3J6aUxTU3c2VEI4Q2ExZmFmN2V0Y2EwOVZPVUI4ZEw2?=
 =?utf-8?B?c29lcFpRTVVyN1o2QTg3ZHpaQys2c0xrZ0kwdVdGb0k5Tk5qc2hZV25zUjN6?=
 =?utf-8?B?RHlWV3FJcDdrZUdiMFduMjZ5elpaSGs2VVNuZm5rZER3VTZVUUZVbzBWNFJu?=
 =?utf-8?Q?4+PXN+URp+wFLLMcmmdSX9wd0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da4e9191-b5d2-445f-fb59-08daa5050e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 06:03:56.0624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mp8t7mqEcws/0BOZ1hm2rKWmv/JuyKyO9JqnDUJEugLaWW5ejuiboRM/Xu0fFh+j66tFNDLJGngXc40wG+6c0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBBa2lyYSBZb2tvc2F3YSA8YWtpeWtzQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5
LCBTZXB0ZW1iZXIgMzAsIDIwMjIgODo0MSBBTQ0KPiANCj4gSGksDQo+IA0KPiBPbiBGcmksIDMw
IFNlcCAyMDIyIDA1OjAzOjU1ICswMzAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4gVGhlIGNp
dGVkIGNvbW1pdCBkZXNjcmliZXMgdGhhdCB3aGVuIHVzaW5nIHdyaXRlbCgpLCBleHBsY2l0IHdt
YigpIGlzDQo+ID4gbm90IG5lZWRlZC4gd21iKCkgaXMgYW4gZXhwZW5zaXZlIGJhcnJpZXIuIHdy
aXRlbCgpIHVzZXMgdGhlIG5lZWRlZA0KPiA+IEkvTyBiYXJyaWVyIGluc3RlYWQgb2YgZXhwZW5z
aXZlIHdtYigpLg0KPiA+DQo+ID4gSGVuY2UgdXBkYXRlIHRoZSBleGFtcGxlIHRvIGJlIG1vcmUg
YWNjdXJhdGUgdGhhdCBtYXRjaGVzIHRoZSBjdXJyZW50DQo+ID4gaW1wbGVtZW50YXRpb24uDQo+
ID4NCj4gPiBjb21taXQgNTg0NjU4MWUzNTYzICgibG9ja2luZy9tZW1vcnktYmFycmllcnMudHh0
OiBGaXggYnJva2VuIERNQSB2cy4NCj4gPiBNTUlPIG9yZGVyaW5nIGV4YW1wbGUiKQ0KPiA+IFNp
Z25lZC1vZmYtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4NCj4gPg0KPiA+IC0t
LQ0KPiA+IGNoYW5nZWxvZzoNCj4gPiB2MC0+djE6DQo+ID4gLSBDb3JyZWN0ZWQgdG8gbWVudGlv
biBJL08gYmFycmllciBpbnN0ZWFkIG9mIGRtYV93bWIoKS4NCj4gSSBkb24ndCB0aGluayBkbWFf
d21iKCkgYW5kIHdtYigpIGJlbG9uZyB0byAiSS9PIGJhcnJpZXIiIGFzIGZhciBhcw0KPiBtZW1v
cnktYmFycmllcnMudHh0IGlzIGNvbmNlcm5lZC4gDQoNCldlbGwsIGluIGtlcm5lbCBjb2RlIGZv
ciBBUk0gaW4gWzFdIHdyaXRlbCgpIGlzc3VlcyBfaW93bWIoKSBJL08gd3JpdGUgbWVtb3J5IGJh
cnJpZXIgdGhhdCBtYXBzIHRvIHdtYigpLg0KQnV0IEkgYWdyZWUgdGhhdCBpbiBkZXNjcmliaW5n
IHRoZSBleGFtcGxlIG9mIGludGVyZXN0IGluIHRoaXMgZG9jdW1lbnQsIGl0IGlzIGJldHRlciB0
byBzdGF5IGF3YXkgZnJvbSB0aGUgZGV0YWlsIGRlc2NyaXB0aW9uIGFuZCBsZXQgd3JpdGVYKCkg
ZXhwbGFpbiBpdC4NCg0KWzFdIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVz
dC9zb3VyY2UvYXJjaC9hcm0vaW5jbHVkZS9hc20vaW8uaCNMMjkwDQoNCj4gVGhleSBhcmUgbGlz
dGVkIGluIHRoZSAiQ1BVIE1FTU9SWQ0KPiBCQVJSSUVSUyIgc2VjdGlvbi4gZG1hX3dtYigpIGJl
bG9uZ3MgdG8gImFkdmFuY2VkIGJhcnJpZXIgZnVuY3Rpb25zIi4NCj4gDQo+IFlvdSBzZWUsIHdy
aXRlbCgpIGlzIG9uZSBvZiB0aGUgZnVuY3Rpb25zIGxpc3RlZCBpbiB0aGUgIktFUk5FTCBJL08g
QkFSUklFUg0KPiBFRkZFQ1RTIiBzZWN0aW9uLg0KPiANCj4gUGxlYXNlIGJlIGNvbnNpc3RlbnQg
d2l0aCB0aGUgd29yZCBjaG9pY2Ugb2YgdGhlIGRvYyB5b3UgYXJlIG1vZGlmeWluZywgc28NCj4g
dGhhdCBhbnkgZnVydGhlciBjb25mdXNpb24gY2FuIGJlIGF2b2lkZWQgaW4gdGhpcyBpbmZhbW91
c2x5IGhhcmQtdG8tZm9sbG93DQo+IGRvY3VtZW50LiA6LSkNCj4NCkkgdW5kZXJzdG9vZC4NCkkg
d2lsbCByZXBocmFzZSBpdCBhcyAiTm90ZSB0aGF0LCB3aGVuIHVzaW5nIHdyaXRlbCgpLCBhIHBy
aW9yIGJhcnJpZXIgaXMgbm90IG5lZWRlZCIuLi4NCiANCg==
