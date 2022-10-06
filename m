Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90B5F5ECA
	for <lists+linux-arch@lfdr.de>; Thu,  6 Oct 2022 04:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJFCkZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 22:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFCkX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 22:40:23 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2080.outbound.protection.outlook.com [40.107.96.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D0427B3B;
        Wed,  5 Oct 2022 19:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdxFZgfmaFcJbuIy+FUv+LLxCmnrdX7DuI6NBtxWw951xSg4LYzGjkaa7ECJXDnLA0TzrnIXD++meX9ttprWA4hrINw0xyvQb0M8VrmXQDdA/uzd9/BPVJ3V3/KQ7yGGrjOrFltBK3r4Fasq2FmTkNGniO20uxvaBWq0meSu8mU83nedgE6FYcS+MSHbz1rpRr5jdmrgJsclzuCtczG7HX6AzLWhQ1yle6U7zxulASJw37GiXwRXDFn67INJfOjV3EvgBTaFfS3v8aDmrKv/ftjBFbGIZMOdOjBFDtp/TDNSn3pYeeJR1Wzu6MPS4n0z4QzaCLiTpvPM08tFV+QPgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rxZVFYQPbFXSVDRJKBpsjopUZXSdyQhHdnekeLtYeA=;
 b=ORCAyRUed9ymiXHeiA0l60mR5ZGwLt0dazLcSL5CIZxapLlcGhVAd6b66TABjiuwFThUXy8ajHx3T/GUsPTLV3XkTscCkQSxMDXS2k9g3EEoNwl2MW0SlYy0AMQVUNZ9Ml7OXo/Dg2X7/lexlgWcuXoZlVg3ZVcxN1f3VpMy2OYInc6WdVo4CQDINi1irOioPeJPKipOVYMEufAF+L4+moXqrNdpuqFc56Js7hM1l8F/w5XrhRmlMmiN+cXUmIV31ujeotl8O3LjOc+pkEe7YW67+34i6QBluW9Q1Ms9SDlR78itRvahOqY8uQECP639JYhgpG8YdXwrJUxTJIJaWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rxZVFYQPbFXSVDRJKBpsjopUZXSdyQhHdnekeLtYeA=;
 b=jKejvhP50k2B1okhn/U12tyfJS11aAvBplXWYUne92hhlx7JFfVynffqckuu4MtABUqKR6577aus/MzVZhSIkYUuwRZrnp33RyE2GSG4PPRjy7mS+w+2nfBqKxmtlTJ2FxBncX6NWnr0GEyf9xlDlDFlwoXKWjLJkGNroUZ0ZUzy4eUmd7n+mwcJ2WhPoHVB/Ezi7wM905bXB+Belroc4HAmI2pYtr2xCBU8I4ecCIFlKlvvXyKqZwUTCNjyOprJgBoSDkzqYJBPhYTYNyi3mA33pSnAUoPjUl6ygHuF8/Dm6dmEH9tWB63mBCwRhy8J6O+YU2E8BtV5JqM2WmpBeQ==
Received: from DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) by
 SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:238::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 6 Oct
 2022 02:40:19 +0000
Received: from DM8PR12MB5480.namprd12.prod.outlook.com
 ([fe80::1d4d:40f0:a740:cd6e]) by DM8PR12MB5480.namprd12.prod.outlook.com
 ([fe80::1d4d:40f0:a740:cd6e%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 02:40:19 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
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
        "akiyks@gmail.com" <akiyks@gmail.com>,
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
Thread-Index: AQHY2KgAyntXB8tE2EqVYIIWW3s9264AnZoAgAAKzLA=
Date:   Thu, 6 Oct 2022 02:40:19 +0000
Message-ID: <DM8PR12MB54807C4BBFEC28D3CC722278DC5C9@DM8PR12MB5480.namprd12.prod.outlook.com>
References: <20221005104749.157444-1-parav@nvidia.com>
 <a938dcae-0f0c-e99c-7217-29e52a4b2052@gmail.com>
In-Reply-To: <a938dcae-0f0c-e99c-7217-29e52a4b2052@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_|SA1PR12MB5640:EE_
x-ms-office365-filtering-correlation-id: 3baf89c8-9dec-4fd1-2c85-08daa7441bdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dMiNkfPpiGShPr9zxThJFM5tE0iSGfH7+/rDKla+cjXnOIWgkbfr9DuH4Up7IV3XTPmVkJdKWSgDP7gEXVeQACFAxnELjuuLZLgQg/AaYFcr63yD0SztE06+DdqGSiwWKfvCYlVH0YLLYMIQ2n0+nbu4dOJQiVOiykmiK07QR26i7v9Ii7JtMaRhQEwD62PJWoNpgoy12FGLGlBaCD1oFfTZ8nrJTEpUwUdXBeUF3sWV5FwWhfDfXT4Rlqa5eIpRPrOHkH694joOYvKwaNVXAadeK/exsrMpZm2s0jPPdQ8/IHQLJ4vWmmAMpwce4Yn2UjC4iJRpaICm0FAGuOKw0zWEvME3E4k8yCbsCTiSUwPN578XIMM2ScRSMY82HTMVMSk6prbArnHa6SJQFDDNca3JSwyzypzh+Yy7zgUYcAuZSTZhgnN2Au/FfJIQYE0KnwTJApaRoQFwGuecSJYXUlkBN/0d5ywItcfibIoKwhM8CDZtnIlAr4J+/LALNbjwUNPoFGcm20eCzMAfDKlUkobpADOS6iX9SE6lxZb5CQU/bRQ23NPljInEUUGhxc0g1RT8CN3000B9EgcBWEGTS9Xx0O9IzD1xsGA30qusYeSOO2hK+zlSCOowDe/KwBpvpqjkk9TSHFW438jKZhZCqufVcymGjLYnPfZj/viVBrqPN4Nda4v0H/C4Zev/4UAzg9RMgQsI1/2htiKWdxMiUmusHOSn+xN0dn+E1ZUFzgTOy3UWAseXVN6khW0G24euugY2DQNccNFNNFOMtqP8osGzUL7c7VCpB9wgyZk8TH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(52536014)(33656002)(26005)(9686003)(66476007)(7696005)(6506007)(41300700001)(8676002)(66946007)(76116006)(64756008)(5660300002)(66446008)(7416002)(66556008)(8936002)(38070700005)(316002)(38100700002)(921005)(2906002)(86362001)(55016003)(122000001)(186003)(71200400001)(478600001)(53546011)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0prV1ZEemFIaDQ1ZnFDb2lROHBYY0E2blc2YUN0cUh1QU1Nd3gwYmoyV1NJ?=
 =?utf-8?B?MGY5UnNOby9rK1ZTKzZqSEZod0ZUajRuc2JzRVk5UHJCWThrOG9aTE9QOFFu?=
 =?utf-8?B?eXlhRVV3RlpzVHB0YzVuaW5qeU44enowWVpGeXNDOUFmYUlqeWxnSk1yK3Ar?=
 =?utf-8?B?TnNZWWYxV09Vd0ZGL1pmeWNodmZEU3hGakJOR28wTFpseFl1alN0Qmh6QnIw?=
 =?utf-8?B?aDhUVlV2cGxwMjFSS096djQ1WUtvbFVCSHlJZ2x3NDlRSmFrVzlseGVqbWpV?=
 =?utf-8?B?SjJKK0hRengva2VxNTFYQ0tkN0hEd1Vaekh1eS9LOVdxZk96RkFFa0tKYTVF?=
 =?utf-8?B?blVCUkJsc3FBaTB4bXdqbGg5ODhMU1RIY3phZ2plWmhaZVJoY2w4ZldLTTdw?=
 =?utf-8?B?Y3FJUVArQ1V2NHhidWVZM0MySnlmd3FkT2EybGxDT0NMSU5HVmNvVlR5endG?=
 =?utf-8?B?WjRZc1A2L3d5cENjcDRYWUhwc1pIYzhibHpxaWlaNlB2Wk1GZGRiNGVjaW9I?=
 =?utf-8?B?K1NwSHcxVmVWemJ3a2FTZWxJMWlYQkxnWVlmV2NISkVlVWJESWwrRzFOdGVp?=
 =?utf-8?B?c1RGZWZyMlNDY1NvZDJEWnpTYVBVME5DZEg0VUVQbG10L3gzdVVENnRDR2ZJ?=
 =?utf-8?B?ckN2bFRFdlJFeVQvdFFFYTU1YnFEQ2ZpS2w2Y0dMZHVDSkFkOGhYdEhqWVZH?=
 =?utf-8?B?ZXA5YlJjZVBVMGk1djZNWXEwU2NnMytqYUdsaCszS242M2NyM3R6TW5PaUZV?=
 =?utf-8?B?ZUh3WUpOdDdyMGlyZzgvazJGbVRnQS84RE1mUW5BaE5ZRlY1T3B2SHh2VFR3?=
 =?utf-8?B?OUR0ZkpEYW83cWtWWXhKSWlCc3RhUXpBT2k3M084eUJSNllWOHk2MmMzaUFx?=
 =?utf-8?B?YjhDNlZYdU1XVmFIcWhBbEVHMjdDb0J5NTkxSnBHekEwQTZFY2swSVFxMEd3?=
 =?utf-8?B?U1F0SjEwcHVGOXpadHR1N0ZRZnNRK2dnQ05GRkdIanhOV3Bmd2hsa3lEa1Q2?=
 =?utf-8?B?OVNOTzZOV3Fwczl6UHcyY044bzF4bnBMSW5aQ1VMM09WeXhSZWJ3TG1pZ3N3?=
 =?utf-8?B?WVkzTkRqa3VUUC9rTTdRbjVJUlJiSHhPWS9MN2pjYlNoblFjRkcxRVdjNEt2?=
 =?utf-8?B?VTlkSXV1OHZwcjZKR25KVXRzOGU5bHhiVmQrcXFRbjE1U0prand5Y3BJVWFa?=
 =?utf-8?B?RnpJVmxGSnc1TlhudkdmYWNVeklLREtIMkRZQmdQa2piVEtMZ0VyUnVyb1I5?=
 =?utf-8?B?Q2IrK1BWcVZqb0R0RVMwTlNkWnpGbnVtbDlBWWZrOU1iWkdwdkdkMFUwejQw?=
 =?utf-8?B?b2FPZU1pc2c0eW5oWVM2OXRaVXczeDd2L3FyWFVDSEJvc2ZJby82WktFWjYz?=
 =?utf-8?B?WFU2T09CQ1VlelNNRm5DNkZ1V3puS0d0a3JZTGVVMTFjendYb1g3Uk5NN2pM?=
 =?utf-8?B?VXZ5akFwLysrY0JmNjUwNUdtdzgrMHVBSFBLbjRYMjdXVXlXYUxRcE1oUzQ5?=
 =?utf-8?B?YkVOOHZZdUZpbzhUakJoWmYyTU5oYnlvU0JlVlRacUgyMDFXWTBmblVFWFJm?=
 =?utf-8?B?M0dpeWVRYzZmeWlCRitxMHBTak9XcXFuSXozUjBFb1BiV25kM0VJNVA2dEcr?=
 =?utf-8?B?QldtZG1BdlRuMkc2Z1F6ZTRaQXJQZ0VCSjRSK3VyMC9LNUtyTy8yWFJ3cyto?=
 =?utf-8?B?WjNkSjhxQnZtSUlORGlKcDRpdXJ3b2gzOEdvbFBzcE9sUVJIYVhGcGJOeDJQ?=
 =?utf-8?B?OXlNbXBuTUVJOE0rSTUyZ1Z2azROaS9Pc2J6Z3JXQVpWTzJLcjAvQ2JLeWVO?=
 =?utf-8?B?TElPaHliZWVoTVJmcytHSXk5bXMzbjEvcXp1MnRBYWc1N1d4eHRZRVI3cGFT?=
 =?utf-8?B?UEVyc2hTbnA4NlFVeHZkd1JhZ0U1bStNcGNNcDRjY2tiU0hqKzJoTXY3UjRF?=
 =?utf-8?B?TlBVNDNBM1dQRzNRanpGM29aenhHbVhIVU1xZVVWZzE0TlF1RTlaSCtjdytT?=
 =?utf-8?B?d0lsL3hrVVUwOWxYcXNhQ2oyazNKWTl0TWV5ancvK2VKMHlMUGwwNHpTMk5Q?=
 =?utf-8?B?Sy9qZlJPclZVNXI4NTNZREdRMVVBMksvUmVnVlJYcnFOMEVKQ3lLOW9GcjFZ?=
 =?utf-8?Q?MnCU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3baf89c8-9dec-4fd1-2c85-08daa7441bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 02:40:19.3259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NXKmz2UhMjbsBgawsvaTrEMXtCUle1I1UQDL5N5ubbR7Fjswrut0XvQbm6f76of6udO25AM8vX9VnNbNoO8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQo+IEZyb206IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgT2N0b2JlciA2LCAyMDIyIDc6MzEgQU0NCj4gDQo+IE9uIDEwLzUvMjIgMTc6NDcs
IFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPiBAQCAtMTkyNywxMCArMTkyNywxMiBAQCBUaGVyZSBh
cmUgc29tZSBtb3JlIGFkdmFuY2VkIGJhcnJpZXINCj4gZnVuY3Rpb25zOg0KPiA+ICAgICAgIGJl
Zm9yZSB3ZSByZWFkIHRoZSBkYXRhIGZyb20gdGhlIGRlc2NyaXB0b3IsIGFuZCB0aGUgZG1hX3dt
YigpDQo+IGFsbG93cw0KPiA+ICAgICAgIHVzIHRvIGd1YXJhbnRlZSB0aGUgZGF0YSBpcyB3cml0
dGVuIHRvIHRoZSBkZXNjcmlwdG9yIGJlZm9yZSB0aGUgZGV2aWNlDQo+ID4gICAgICAgY2FuIHNl
ZSBpdCBub3cgaGFzIG93bmVyc2hpcC4gIFRoZSBkbWFfbWIoKSBpbXBsaWVzIGJvdGggYQ0KPiBk
bWFfcm1iKCkgYW5kDQo+ID4gLSAgICAgYSBkbWFfd21iKCkuICBOb3RlIHRoYXQsIHdoZW4gdXNp
bmcgd3JpdGVsKCksIGEgcHJpb3Igd21iKCkgaXMgbm90DQo+IG5lZWRlZA0KPiA+IC0gICAgIHRv
IGd1YXJhbnRlZSB0aGF0IHRoZSBjYWNoZSBjb2hlcmVudCBtZW1vcnkgd3JpdGVzIGhhdmUgY29t
cGxldGVkDQo+IGJlZm9yZQ0KPiA+IC0gICAgIHdyaXRpbmcgdG8gdGhlIE1NSU8gcmVnaW9uLiAg
VGhlIGNoZWFwZXIgd3JpdGVsX3JlbGF4ZWQoKSBkb2VzIG5vdA0KPiBwcm92aWRlDQo+ID4gLSAg
ICAgdGhpcyBndWFyYW50ZWUgYW5kIG11c3Qgbm90IGJlIHVzZWQgaGVyZS4NCj4gPiArICAgICBh
IGRtYV93bWIoKS4gIE5vdGUgdGhhdCwgd2hlbiB1c2luZyB3cml0ZWwoKSwgYSBwcmlvciBiYXJy
aWVyIGlzIG5vdA0KPiA+ICsgICAgIG5lZWRlZCB0byBndWFyYW50ZWUgdGhhdCB0aGUgY2FjaGUg
Y29oZXJlbnQgbWVtb3J5IHdyaXRlcyBoYXZlDQo+IGNvbXBsZXRlZA0KPiA+ICsgICAgIGJlZm9y
ZSB3cml0aW5nIHRvIHRoZSBNTUlPIHJlZ2lvbi4gIFRoZSBjaGVhcGVyIHdyaXRlbF9yZWxheGVk
KCkgZG9lcw0KPiBub3QNCj4gPiArICAgICBwcm92aWRlIHRoaXMgZ3VhcmFudGVlIGFuZCBtdXN0
IG5vdCBiZSB1c2VkIGhlcmUuIEhlbmNlLCB3cml0ZVgoKSBpcw0KPiBhbHdheXMNCj4gPiArICAg
ICBwcmVmZXJyZWQgd2hpY2ggaW5zZXJ0cyBuZWVkZWQgcGxhdGZvcm0gc3BlY2lmaWMgYmFycmll
ciBiZWZvcmUgd3JpdGluZw0KPiB0bw0KPiA+ICsgICAgIHRoZSBzcGVjaWZpZWQgTU1JTyByZWdp
b24uDQo+ID4NCj4gDQo+IERpZCB5b3UgbWVhbiB0aGF0IHdyaXRlWCgpIGlzIHdyaXRlKCkgZnVu
Y3Rpb24gZmFtaWx5Pw0KWWVzLg0K
