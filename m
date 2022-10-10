Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD235F9C62
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 12:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJJKGS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 06:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJJKGS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 06:06:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1616766A61;
        Mon, 10 Oct 2022 03:06:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VP88YIo0o8E/GdM+jNtgJ0WeXyckTAVDWAKMjmQ3fdnOCry7qChq3bIGDnBIvQjAfyv18PTDSt2wbcPhT1H/WlGLOI/YYgRerc/62klTcgfio5lnr+ypdYUjFpbje7CRLKxx6Lwgg18l4EDQKDsPOy1roOuNiY4euCQods3A4q9vTAhZdg5TfZ3lGOqrUsxn4tUYIjAs3pJmIX17hzgjOpSC0Yxx6bUbPIJY2W+QLTZT7Hr5iYczodtuYGG2etQDp0Q2fSgrGvxopqrhMh7G9oPUHLiJr5t3f82QtLJwTSNcO0oeXEQQzGy7lPTvFP6DjjU7CAS85/x/kbRnsMyRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qiDRyWf6/LO0+y31u4caFqhKvTuShY4ozgUrRkEH7I=;
 b=eEJsCktwrEoEpTe7NhliNmwtXSjqVXmJrCl32zN3To2nj4gFHBNmu9TWF2EkcjBD7A9eZoiyPhjTE8qtVfk4EP6N0QAbhNd6P2QTxchC4Sp2o7YdTFhItF9qxSi85pNp0udvPA/dVJChaFOLHOVtiaiIV3hJqJG1PnBWMA+VGoHjsc1jHUwCR4g+EGhANiTrGICM2t7k8QuFifycJ+lirJ0cqBURKxnwb2U/IBSdEm/pRzPubOZr4IdviNR6rr21Wm7ezqtNZyLFPY9ZgInTEHD1q+bOcW+0m0suXrFDogM98z4uowdVeZ1xEBUUGbN1hO3QCggglsOdpRWxmYUU0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qiDRyWf6/LO0+y31u4caFqhKvTuShY4ozgUrRkEH7I=;
 b=R+EW1BnppN5yPmUYaa7Yh9/W7k9yo/CkC3FarGnQeA58FVQqSTi+SOIPxZ1hK/ZXpe2wzYtle+veAa/q2LjVqNLQxX09h1Phu3h5GlZSlk7YpJQzQcFlPMLJwyL0JNN7t2nJyWF/pnPIXJCumE25t3LmK6EhxMinXj/CSBtdck2c9Fu0ak4WWtwG0rfLsJeBKP6SK9nBPUzTkpODRc5SfYTmzubO8yWkvgSdcqbUc0Ls2GkybhjEZ/THVp8HtwlH8u786AxSMsZazbc0V/AasQkOPLehsFGCia9KDDGDgQfe7YTEddEiEtP7saTcTq31X/Ohy46NigrAghiOhr/buQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 10 Oct
 2022 10:06:12 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a%5]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 10:06:12 +0000
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
Subject: RE: [PATCH v3] locking/memory-barriers.txt: Improve documentation for
 writel() example
Thread-Topic: [PATCH v3] locking/memory-barriers.txt: Improve documentation
 for writel() example
Thread-Index: AQHY2TYPlGTnR0DcK0Cgxwi/6YaaPa4BTG0AgAYggdA=
Date:   Mon, 10 Oct 2022 10:06:12 +0000
Message-ID: <PH0PR12MB5481FE47480CB6626D9BDDE3DC209@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20221006034457.165878-1-parav@nvidia.com>
 <2dedeb9a-279d-8756-cb74-6d0919f0a02e@gmail.com>
In-Reply-To: <2dedeb9a-279d-8756-cb74-6d0919f0a02e@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4454:EE_
x-ms-office365-filtering-correlation-id: aee0fbf2-d9cb-4f14-d875-08daaaa70fdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pd/Tt7UuNc/Q3ycR7WeT8W+OAgkfZZhFf0lJyWgVDOsPaN8uqPB+MbaoFxWEZ7nAtbnJN48Bh1jPlJYR6QdVzkRmWP6WLUtYva1qQhZaJedfrN1oviExloSTsG8mIkuO7Q6e7bmrG1+C4mwqEPh2OfGI/lpdy4BY6jyVD5VHr6DAoCUMiAJx4hRnlBUYvk9nAHyfNy7/wWYgzvVpqUWVaj2MP2FRNlak8gEldHUm397uxOmNo/tqq1JkeIC1hMH9JWF9gIEPdi6jIqCsjE8f/220U0ZTxQEps6Y0Ah9pk4sc+nhQyQaWeu2/qf0ot1vEJqdZGRxdeAkHORTOsf2jm7zl6u7d2OrY+qM6UOSaWV+JUg2D8R5nNTD9f0rIQwRuCWS/2q3AfwVKYvCXJf3rxevikaS7B9LJnf49Sx3r/k8A02AkiqV27q7iyBiDBoutYoXoffjHmTeUTjaWrTJtQt98Xl9L+keLSjggq1hkB1gHNxevELR7YoFrUbiQpEp3toBEYNySR2ef6O9uV2H+rLlfIzuByFxrjaywrBth2y8q36yIHPhQwlfXpC5GQOlsJoUje0JA73W0GsO77YDb9g3Bs+8T7SpILoHy6kQ/1mwfKvLLnJW3blMAQOe1EMbeyDQwoJ7pircCOO8jHWsjw63kxRGWOCCkeVrBPBRkzFpQjPmlCV8DuQ3ynOFQhs+4slEnJQR5FD8zjvMlO1555xjz8VR4GvhbYxIvTne3WBE+xct0hKUWS2pOBe/hokaBtZpo8qL6j156wJn0t1HgKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199015)(83380400001)(9686003)(4326008)(186003)(38100700002)(122000001)(38070700005)(7416002)(2906002)(5660300002)(54906003)(52536014)(64756008)(41300700001)(55016003)(8936002)(66446008)(7696005)(8676002)(71200400001)(66476007)(478600001)(66556008)(6506007)(316002)(66946007)(76116006)(6916009)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzdROHhKeHUvMmY2ZFFjY2RFZ0JyNWdUY0M0NFNCTS9JQTVDUytOSnA0aS9G?=
 =?utf-8?B?eWNMbW8yajJCbXdtTlVhWXZMK1h4ZkErQUtJQnhsZnlTYUlVcUhKenAvRGpX?=
 =?utf-8?B?Nzd3VW9ERjJmUWdRcndDRWpxR3JIREFabTd2eTJhOS9PcVRBNEFxZ3FLZUFk?=
 =?utf-8?B?ZTh2ejhYZG5sMG5wRzdOOG5ndHFDK1dQdnBrTFNaR013a3NCNXh1SnRFV2ow?=
 =?utf-8?B?L2paVXpPS0ZIUEtRTEJ0eG01SGdNMGk0NjZMTGlxOGh2L0NvY1ZIL2gvZ0tU?=
 =?utf-8?B?cjBHTzh6azZnWHR2MWxZeUswbmNOb0Nlc3JZOTdidkMxWFZMV3NaK2Z1TENP?=
 =?utf-8?B?d1FCRWphMXRoK21rYVBWT3BqNUJjY0ovelBTUWN6UTlpc00yallXODJnaXBs?=
 =?utf-8?B?akNnV3g0bFgvWkdJcG5aQXBHc3NSYm1wb2dkU2QwdEZnTEVMa2ZURG80cnRC?=
 =?utf-8?B?bnZZTXRGR0JzaklpOEF4RUhIN3VwcmpFUDlNdnVFNjVVVzcxd1hNeWJnalZO?=
 =?utf-8?B?ZXZZcldRaDV2bmQ0a3FwREltWThxR0JYdkpxa0NCQVNRa0w2ZG5oeHlPMjRi?=
 =?utf-8?B?d3N3WTJYWmdLbThWTVhzTmdrQ3plYUtoM2FEM2gvZjFkQ0NLNzY2Wi85dEc4?=
 =?utf-8?B?d3VDTUxUWXUzNXRrZ3J1d1BqWU84c28yWUluM1AwUXBTSERzaTFTRmhkcmND?=
 =?utf-8?B?T2hQOWhJMVEwL2UrM2VEYmVBZDJVT3Z3dGtkNHA3eHN5K2VPSHRkaTdUZjhP?=
 =?utf-8?B?eEluWGt0N0ZJd0NlN2tsVUlOREJ3VlJ5RFBWMXVHMEt2R2ZzL1owNlJlaUVs?=
 =?utf-8?B?K3Y1OGxRQmF5b2E2aXZyU3NpTEh6RjhXL1dSUVYyd2daWW5kaW5tZjBLV1VD?=
 =?utf-8?B?YVRYTkpLM1dzdTlUbHVRUXdOczVIbjhNRzRWWHV2d0tSU05mUjNiN1ppeGdl?=
 =?utf-8?B?NnlwQk9pTU9SUXhudk5tWFU3M0pMV3ZtY3hHbUpZQi9Sak5sTElVUnJmd0JJ?=
 =?utf-8?B?SGFuTGJGTU81aWtycytCMVBWak1CVFBWYW5XOGRmakI3RlZKTWx1N2t0M0NE?=
 =?utf-8?B?WXM4ZmRWV0xMSDRWcUQ3WjhaZVkvd3NFWnJXUWRHV0hrMm1xZ04zYzduNlIz?=
 =?utf-8?B?TW1sMEhsVUlpdmI4ZGp5bXZyVDQyTTRDN2lyaWsxSlRmN0FJa21NOWdYdUpp?=
 =?utf-8?B?TEFnbnE4QkxHdUFEMU1kV1R4ZU9kTlNKbFcwcGZWdWJtOHNMdXdjRlRTT0th?=
 =?utf-8?B?RjJPdkIwWTZodTNRYnVXSEFMdndadEtPMFc1ZEczaGZVbVNycmFHU09yMEo1?=
 =?utf-8?B?dmV0RUlWU3VrTnMvQStNZWh5TG1IY3pES2xaUm5QZTBjWXE3L3hGcW1XdGpm?=
 =?utf-8?B?QXZkNTkvSTkzTVhVL2QreUZxUHc5VWRWYmZFTkpvM2hyYnk3Q2xvbTBsbXUr?=
 =?utf-8?B?WmlQSTRVbkV0WmZmZmhoQk5NdHd3OWUvOGtXMkM5OG9PS3M3YXorVXROaHo1?=
 =?utf-8?B?S3NGUlkrRzY1SXNPQTBKTVlETXdIZnRVdS9aMWFVQ1hnOWMrc09ma1BISXNU?=
 =?utf-8?B?QzZtU3U3WGJGR3JqUlc1c0YwRW42aHZtU051blJoRmNYeStzMWhibWt0ZWkx?=
 =?utf-8?B?S1NRWm9sblk2Mkl1dlo5b0J1UGlYOEtOY0tNbHJJWEhrWCt4R2VPWlhPc3di?=
 =?utf-8?B?YjhleDl6by9ibUdiQ3MwemdhSkZEUTFWUkdwTWZESUNydzNqMkw5NmxwaXVS?=
 =?utf-8?B?VitVNnNCQ2hEYzFMbitjNjhJalUvN3ovWHNhemlwck5PQW5veXJJNE13OXBa?=
 =?utf-8?B?YWw3QU9tZG5zVjZ1UHNWZ0M1eThmZHhnUjdQVEpQQjRMQ3loTVJydnNKSlJY?=
 =?utf-8?B?VzQ2RDhuWnFUMmVScFQyUnBzM2lleEVXSDlWQVR2MWU4WFd3QXJocjlncVo3?=
 =?utf-8?B?eDhzVlBEMHc2Zm15QzlkS0syekd5YlBZeVE3N2RkeWxoWmZxMmVKNldVVWpa?=
 =?utf-8?B?bTVXN1k5ZGx4TWNzay9lSnRzWGpGL2ptRHV6U0NXdW11UXhSS25nWEpneWxo?=
 =?utf-8?B?YlVQVGZQU0I2WkUxeHEybkd4MW9jVFNocEhhb3BSMlFzU1NobTNoZXJNbHV3?=
 =?utf-8?B?M0RzdWV1Vit4SkJuWVpBYUluQjRKZ1g0Y21DNEpjMFRVRjVPU01vTGJkN2Zp?=
 =?utf-8?Q?wN62Lxrsz/N98GSnowErg8TmMnGSKs3F6qXx8w2T1HKX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee0fbf2-d9cb-4f14-d875-08daaaa70fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 10:06:12.8113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMozNnzyT9YVzunZl9enVaQsrOrwwxInjdbOuelOYBrpRDTPG+0BrH20ZxLTJmrP8BacEOyhdzaSpLiBWusasQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PiBGcm9tOiBBa2lyYSBZb2tvc2F3YSA8YWtpeWtzQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNk
YXksIE9jdG9iZXIgNiwgMjAyMiA2OjAxIFBNDQo+IA0KPiBIaSwNCj4gDQo+IE9uIFRodSwgNiBP
Y3QgMjAyMiAwNjo0NDo1NyArMDMwMCwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+IFRoZSBjaXRl
ZCBjb21taXQgZGVzY3JpYmVzIHRoYXQgd2hlbiB1c2luZyB3cml0ZWwoKSwgZXhwbGNpdCB3bWIo
KSBpcw0KPiA+IG5vdCBuZWVkZWQuIHdtYigpIGlzIGFuIGV4cGVuc2l2ZSBiYXJyaWVyLiB3cml0
ZWwoKSB1c2VzIHRoZSBuZWVkZWQNCj4gPiBwbGF0Zm9ybSBzcGVjaWZpYyBiYXJyaWVyIGluc3Rl
YWQgb2YgZXhwZW5zaXZlIHdtYigpLg0KPiA+DQo+ID4gSGVuY2UgdXBkYXRlIHRoZSBleGFtcGxl
IHRvIGJlIG1vcmUgYWNjdXJhdGUgdGhhdCBtYXRjaGVzIHRoZSBjdXJyZW50DQo+ID4gaW1wbGVt
ZW50YXRpb24uDQo+ID4NCj4gPiBjb21taXQgNTg0NjU4MWUzNTYzICgibG9ja2luZy9tZW1vcnkt
YmFycmllcnMudHh0OiBGaXggYnJva2VuIERNQSB2cy4NCj4gPiBNTUlPIG9yZGVyaW5nIGV4YW1w
bGUiKQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEu
Y29tPg0KPiA+DQo+ID4gLS0tDQo+ID4gY2hhbmdlbG9nOg0KPiA+IHYyLT52MzoNCj4gPiAtIHJl
bW92ZWQgcmVkdW5kYW50IGRlc2NyaXB0aW9uIGZvciB3cml0ZVgoKQ0KPiA+IC0gdXBkYXRlZCB0
ZXh0IGZvciBhbGlnbm1lbnQgYW5kIHNtYWxsZXIgY2hhbmdlIGxpbmVzDQo+ID4gLSB1cGRhdGVk
IGNvbW1pdCBsb2cgd2l0aCBibGFuayBsaW5lIGJlZm9yZSBzaWduZWQtb2ZmLWJ5IGxpbmUNCj4g
PiB2MS0+djI6DQo+ID4gLSBGdXJ0aGVyIGltcHJvdmVkIGRlc2NyaXB0aW9uIG9mIHdyaXRlbCgp
IGV4YW1wbGUNCj4gPiAtIGNoYW5nZWQgY29tbWl0IHN1YmplY3QgZnJvbSAndXNhZ2UnIHRvICdl
eGFtcGxlJw0KPiA+IHYwLT52MToNCj4gPiAtIENvcnJlY3RlZCB0byBtZW50aW9uIEkvTyBiYXJy
aWVyIGluc3RlYWQgb2YgZG1hX3dtYigpLg0KPiA+IC0gcmVtb3ZlZCBudW1iZXJlZCByZWZlcmVu
Y2VzIGluIGNvbW1pdCBsb2cNCj4gPiAtIGNvcnJlY3RlZCB0eXBvICdleHBsY2l0JyB0byAnZXhw
bGljaXQnIGluIGNvbW1pdCBsb2cNCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9tZW1vcnkt
YmFycmllcnMudHh0IHwgNSArKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
bWVtb3J5LWJhcnJpZXJzLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9tZW1vcnktYmFycmllcnMu
dHh0DQo+ID4gaW5kZXggODMyYjVkMzZlMjc5Li44OTUyZmQ4NmM2ZTYgMTAwNjQ0DQo+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9tZW1vcnktYmFycmllcnMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9tZW1vcnktYmFycmllcnMudHh0DQo+ID4gQEAgLTE5MjcsMTAgKzE5MjcsMTEgQEAgVGhl
cmUgYXJlIHNvbWUgbW9yZSBhZHZhbmNlZCBiYXJyaWVyDQo+IGZ1bmN0aW9uczoNCj4gPiAgICAg
ICBiZWZvcmUgd2UgcmVhZCB0aGUgZGF0YSBmcm9tIHRoZSBkZXNjcmlwdG9yLCBhbmQgdGhlIGRt
YV93bWIoKQ0KPiBhbGxvd3MNCj4gPiAgICAgICB1cyB0byBndWFyYW50ZWUgdGhlIGRhdGEgaXMg
d3JpdHRlbiB0byB0aGUgZGVzY3JpcHRvciBiZWZvcmUgdGhlIGRldmljZQ0KPiA+ICAgICAgIGNh
biBzZWUgaXQgbm93IGhhcyBvd25lcnNoaXAuICBUaGUgZG1hX21iKCkgaW1wbGllcyBib3RoIGEN
Cj4gZG1hX3JtYigpIGFuZA0KPiA+IC0gICAgIGEgZG1hX3dtYigpLiAgTm90ZSB0aGF0LCB3aGVu
IHVzaW5nIHdyaXRlbCgpLCBhIHByaW9yIHdtYigpIGlzIG5vdA0KPiBuZWVkZWQNCj4gPiArICAg
ICBhIGRtYV93bWIoKS4gIE5vdGUgdGhhdCwgd2hlbiB1c2luZyB3cml0ZWwoKSwgYSBwcmlvciBi
YXJyaWVyIGlzDQo+ID4gKyBub3QgbmVlZGVkDQo+ID4gICAgICAgdG8gZ3VhcmFudGVlIHRoYXQg
dGhlIGNhY2hlIGNvaGVyZW50IG1lbW9yeSB3cml0ZXMgaGF2ZSBjb21wbGV0ZWQNCj4gYmVmb3Jl
DQo+ID4gICAgICAgd3JpdGluZyB0byB0aGUgTU1JTyByZWdpb24uICBUaGUgY2hlYXBlciB3cml0
ZWxfcmVsYXhlZCgpIGRvZXMgbm90DQo+IHByb3ZpZGUNCj4gPiAtICAgICB0aGlzIGd1YXJhbnRl
ZSBhbmQgbXVzdCBub3QgYmUgdXNlZCBoZXJlLg0KPiA+ICsgICAgIHRoaXMgZ3VhcmFudGVlIGFu
ZCBtdXN0IG5vdCBiZSB1c2VkIGhlcmUuIEhlbmNlLCB3cml0ZVgoKSBpcyBhbHdheXMNCj4gPiAr
ICAgICBwcmVmZXJyZWQuDQo+IFNvIEkgYXNzdW1lZCB0aGF0IHRoaXMgbGFzdCBzZW50ZW5jZSB3
b3VsZCBiZSByZW1vdmVkIGFsdG9nZXRoZXIuDQo+IENhbiB5b3UgZXhwbGFpbiB0aGUgaW50ZW50
aW9uIG9mIGFkZGluZyBpdD8NCj4gDQpKdXN0IHRvIGhpZ2hsaWdodCB0byBkZXZlbG9wZXJzIHRv
IHVzZSBvZiB3cml0ZVgoKSBvdmVyIF9yZWxheGVkKCkgdmFyaWFudC4NCkJ1dCBJIHRoaW5rIGl0
IHJlZHVuZGFudCBnaXZlbiBhYm92ZSBleHBsYW5hdGlvbiBvZiBub24tZ3VhcmFudGVlLg0KDQo+
IElNSE8sICJwcmVmZXJyZWQiIGRvZXNuJ3QgbWVhbiBhbnl0aGluZyBpbiB0aGlzIGRvY3VtZW50
Lg0KDQpEcm9wcGluZyB0aGUgbGFzdCBzZW50ZW5jZSBpbiB2NC4NClRoYW5rcw0K
