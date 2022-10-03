Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0365F284A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 07:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJCFzB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 01:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJCFy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 01:54:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA77010FFF;
        Sun,  2 Oct 2022 22:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVegDW5j15wwLOk7csLgFXLg+Gbchb4IzfptuBOKeie4YRdXB3Cmh3ji0gFXvUGz+fUputS2POe/1krRoJuE/Me/NuaAXxldM0EaoZzsk1bGc39XDTcdNib4zeY/Yf7n0Fi45IZ+AMGxmVP/TZxtrC2REMwSWE7TeKM/KwKQ4YQ/SP9XTOKApsbzmubpt94swX2FxP3xmqMDtf3Tyvmf6p7tEyoo7yEGEwfG6CmykhkfDFYW95egAAo8XAN5vPW0nohoJXkrQ8eNzE67PEXQLQFjYAEVu7vPomSmXvyg5MHDW2u3+tb/rXlXLsntx+LN6DAfIyEuFwd+VE6KONMs8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4/3EZM1ZLVJhD5XmC7rV5wDWnN3btORZZR0AaF2Ju8=;
 b=l11JDqplLfZesIPlKIToncGXMKl+XXP3F6H7j84SAhLtrgYFf2OtkQiAYTNtFq66pnah+rI+XdZNCMmCVeufVn05kO+dFQelKs/pOHTZTtmxe4oDlKuICGJL2YU9Fa0Tzzju+zGqSikwwmCMnoe1j8/Hzm3jSrZM0l7wK5JekDAXfP9ZBs3CP3W7pvZHxiLFXvxIQIAizwpvkqQFrNdkJi7EJ1ZbRxRdX4CsepLp8FzARij5ywoZs458qtZ1pz0G4imi3skdp/SsOgLVbYKe+moqAvREFo0xYzOjegy6TimERNLDbLAmYdQZHlJOxPhv2mn0/kvdpN8mTQKWfe7RLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4/3EZM1ZLVJhD5XmC7rV5wDWnN3btORZZR0AaF2Ju8=;
 b=SFsI5kj/513TwC+TGD31mDv/yGUpRwbSKuCespy9cPQw0r8DwnipAcbUS+Ay5ORGLbDNNXSEJZ0eI0Bzh0jE6FlqI52n2qRWeF+MqF566kLidzFmK0sKqRl6CiAXvnmyboq1Wlgw272oc++WD7/hqx53WAJI38OaOtNQeBJ9rekOJyu8ErQz5x5F8LU5CgKSEdXZ3H1WXRviYly8vCpDtM1WCBYxHFyiK9ss7qt/obN26+ykkelGoLU1Yrj6drtlMvPBqW3fStrHB2DEKNX0Kv9UPUq9H17Q9/AlJAGXd2GAB0rPfDEmQBKlth6HBNDiBN9e9ViwWzy203lZsDNBVg==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 05:54:54 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::f166:64a7:faf9:659a%5]) with mapi id 15.20.5676.023; Mon, 3 Oct 2022
 05:54:54 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     Joel Fernandes <joel@joelfernandes.org>
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
        "akiyks@gmail.com" <akiyks@gmail.com>,
        Dan Lustig <dlustig@nvidia.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v1] locking/memory-barriers.txt: Improve documentation for
 writel() usage
Thread-Topic: [PATCH v1] locking/memory-barriers.txt: Improve documentation
 for writel() usage
Thread-Index: AQHY1HD1laDrRIDleEGxkmQmi+hX2a33OsCAgATzBBA=
Date:   Mon, 3 Oct 2022 05:54:53 +0000
Message-ID: <PH0PR12MB5481FE2A85C3492AF645E2FADC5B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220930020355.98534-1-parav@nvidia.com>
 <CCD8EFA1-D0CF-4E57-905C-E7CA8E4DA56F@joelfernandes.org>
In-Reply-To: <CCD8EFA1-D0CF-4E57-905C-E7CA8E4DA56F@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6777:EE_
x-ms-office365-filtering-correlation-id: 0d9bf3a6-ea61-4c5e-65fa-08daa503cb46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QACs4H9HVuhVmovpscz2RuZyxzxSFvy1rUyu/b9f1QNddl9jdt1rvLVRUSbjeXwudHsKpNnW4Ii/Xo2I12ZpEzqseH28TWzltv9Whs/Ej+gBwHquTiBcrumthpJorVsJtoYTmKG+Hrac349bNAJJeoMjkJQmRdTLNgiTawKKKIGruXw9crky61B540MemqFIe9qUh3zOmBgeVNud/dhaWoPzrgEt060hP5ul4Gilqt5HVlijISBMG4eIgkGChko6nOLsonSQyqH+vn9P3QdgjwAwL0mOJuOpRgW+6O11bh28i4ST2WzdPAfG9HRGvP5TZMerkAFeBRSfZkaxRFbLebGswdMGnh2pzI6X4oTNmBOsWd9XnqSZ99ZIkVIaXAOWJSjSB37wU47LpS03LIDKytnSCZkn7/75KvON17hVQCytGaGBrZv2fGapiMZbEDS9Nh4DyCyZhoppmDCF0wpLMRyQIjOwFG+YeDjcINbgVGq98fcn4+dP7OE80SzEy5MK4WxM3twqE/Vjlx6EBkWTBdBbkMDWxpAM9omwwmYpWNHXCfAawlBjOIyIC1v6/fDKM6k8Don6EOWB2UfioCKskGL6Az0Qop5HuYNyZRacX1TJN3AdGk5Fq4+q8eHny1mKWCnw2iez46rDO8IbMJRYM1niYVZQejsohzoEMylOCpWeYcZTlUVb9hdh534MidecDB3EYHl/kGc62sgdcbujbQl1QovD8v0+Vcmcss1u/rFSSWjVwwE2d5ZdGrxmmFMIDBT3QPEv+di3tbqFBa00AyMKah12N9gBuBxrQqjfu38x2/fm8OvdmBLIWRARgZ//v0c2B2tTSIFAy3fW1us1qf72wExg3CHacBcpAshZehYOgHeRmBMSDaQLu2BYnHVAhfrVplI7MVHCkN784C0dJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199015)(122000001)(7696005)(6506007)(38100700002)(66476007)(64756008)(66446008)(66556008)(66946007)(38070700005)(8676002)(6916009)(54906003)(76116006)(4326008)(55016003)(86362001)(33656002)(186003)(53546011)(26005)(9686003)(71200400001)(966005)(478600001)(2906002)(316002)(5660300002)(83380400001)(41300700001)(8936002)(52536014)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YktEdnRlaFJ1NWpnQ1YrZXhlRG44ZVlZc2dRNlUxY2NrbzlYc1YxOWx0Q2Jr?=
 =?utf-8?B?elJPSHVjRFJaVFdFWTk1TW52OW1mckhnaUp2SEtraU9XVVFMV2VxeHhCVnN5?=
 =?utf-8?B?L056MFFQT2pVUFFaYWxDUms3SkJldTk4UDRMSWY0alk1RzFEWkZzMWNhQjV1?=
 =?utf-8?B?MzMrTEVRV3FHZU5XRGpLQkIrUEZvalhGUU1HaDhMNzVuQUpTblFCUFlhYklY?=
 =?utf-8?B?TW5IUW9hQlVFdGxXaDVhb3dQSUdDZVljL0NneHJhN3BwcVJkSWQ1Zm8ra2VQ?=
 =?utf-8?B?ajIvUFk0UEdxdnNzeWp3bTB3VkZKbmtjcDBrMnlwL3VVR2tyS2MyalZ5dFl4?=
 =?utf-8?B?M1o5c292elA0MDJhTGNxSDdEWnpnN05INmwzcGZNUTBmRUhlUmNtT0ZIaEZi?=
 =?utf-8?B?UjNPYzgzWEErZ29kaE1TUmppVk51dmxyMzMwSjRxWmw0TXFPRHk4dW4vMnYy?=
 =?utf-8?B?QXQ2TTdUWHR0WEVUa0gyWTZ3elpndlpaYldGdzRYcWxuWEZiVERrRW9JZXkz?=
 =?utf-8?B?VzMyK2tkZG9ycC96MWNkdTM0VzA2TTdLUjhOZkVxZlJhb0ZZVURpamlHeEVt?=
 =?utf-8?B?cHNZeU16c1R1cGtiVnkwV0F6MnpoRXBDeGs2d3FPNjdoOGdLcG52MVN3NGYx?=
 =?utf-8?B?MHQ2Z0F1WFhNVHFwSWNwSHkrRTRkK1plbitnMS9GWkJMZzFaK1BoNE9NQW53?=
 =?utf-8?B?VG9QQmk0U0lHUGd1VkFDS0xJWGZjZkxoYnhrZTdIWFdKRll3UE1DOUZ3bVIx?=
 =?utf-8?B?RStkY0Y3N0lDdEp5cmFPSFArRE1rM0NHaGVTUlpuWno5RkpEODVTRnp4alBC?=
 =?utf-8?B?aTVlamRPZDFIWHNNN1RJcXJzQlB6NFZMQUNxOUh5SnNwbnlTUHAxVnNIK3hW?=
 =?utf-8?B?MURjQkJSMitnaW9IWkZtMVhPaWxLcFdwU1RlamlkeXlCRHU5OE1jVmhIY0lR?=
 =?utf-8?B?NExuRUlVV2EyWnRndFBEQ1VKcTFKemptLzdqbGRRbHFYUEVmSGwxeDFZOGZ2?=
 =?utf-8?B?Q1orWmpvK0h3L1Jqa1N2eEh0WVN2Tis4Y2lSdmtZMTVyaHFqUFhibWZxZm5p?=
 =?utf-8?B?MkREQXAybzJCcjBydzAyYXcwODdrdDJFWGk5dzhqSlhlN2FWZEd3QUpxdU53?=
 =?utf-8?B?NFpBdzNHcXFEWGFNemZkMzl0V3JkOVlRRHl5SnZ1ZHFkMDU2eFpwZXEwTENi?=
 =?utf-8?B?S1hjS0g3cHFPcEp4czQxblVFdHdOc3NNM1IwTk9kTjc5d3h3bTNSeUxyZTNP?=
 =?utf-8?B?RTZhQ3BGMEYrSEltek1wR1RPSGE2YVJvY3AzUlBBaUFHVUVhNWQ1dlhTQkQ5?=
 =?utf-8?B?SFphVGtjclg0Zjh3Y0xWdk5QcmEvcVJITlphNU9NNHNYeWhlRXJkaUc5czls?=
 =?utf-8?B?akdUWlZ1REhoR1EvY1RkblhERjNJaFRwZ0VQd0RzVUpyN21SSno4UEVtUDZJ?=
 =?utf-8?B?KzN6a3FlaWZjWWRzZ1IyM2s1MzNtVThuODI3dkxXcGxLYmwxeGJzTXU0N2hK?=
 =?utf-8?B?SVVCS1VUYjNCQm1iV3A2RWZCNzJrWU1idlZXZFJzREs3Zi9sbmlnelloZzlW?=
 =?utf-8?B?dWpyNUpITngrUFgxYlZKQkdSSS9CRjVNbUJHL0xkSmVtc2dMMThDWDJCdEVk?=
 =?utf-8?B?RXdQY3VGZXA2V0dQUWFQYWJ6aG5mamFmYjQ3WHUrU21GSVFyRzQ5TlNQbWdP?=
 =?utf-8?B?aVA2RWpzQm5KSDVReFpMS3FIU1JKZy90elN0SlN3djlUTkRmL2NHUzRZL0Jq?=
 =?utf-8?B?TDE0MnplSUs1Vk1ubGhwU0xFQmZRLyt1d3U4eTdFOTY4RVgxQnJEMFdJUnBT?=
 =?utf-8?B?WEFySW9mWG9LQnJVSkMvZVlIeExEYlFsVmViUi9hcUhtTGZ0V3FXV3p3bXFq?=
 =?utf-8?B?YlFMSFJlbGR0VGkzZmdVYzAwbHZKYlZTQmRCdzN2bUQ4eXJyNTNvMGNlbkU0?=
 =?utf-8?B?NkNjMHVHUEQyVnpKTWs3UVBtc29VeHY4NlJvZXk5MS9ORlBXYlM0SGI5dm9v?=
 =?utf-8?B?ZTJDdjg0dGphMmlxRndXaXA1WlllRXlxaW41eXlPMFdkOCs5VGV3VjV3SDZh?=
 =?utf-8?B?UEFoNXByeEVpeUdnOXBXRFpsenkrdE9QQUd0TjdIZ1pvR01ROWFoR3FrdVBH?=
 =?utf-8?Q?QU17gmEykijb/4FjhLrFd3oY4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9bf3a6-ea61-4c5e-65fa-08daa503cb46
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 05:54:53.9595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3+UGQl89wwtreo/sf65v9xTVaonqD0G0kSLoRo0sX4Q/JBUJa2ICLiW7ciGB1JfNaT7Gl4CP5ArULsxVpvbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGkgSm9lbCwNCg0KPiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9y
Zz4NCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMzAsIDIwMjIgNzo0MSBBTQ0KPiANCj4gSGks
DQo+IA0KPiA+IE9uIFNlcCAyOSwgMjAyMiwgYXQgMTA6MDQgUE0sIFBhcmF2IFBhbmRpdCA8cGFy
YXZAbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiDvu79UaGUgY2l0ZWQgY29tbWl0IGRlc2Ny
aWJlcyB0aGF0IHdoZW4gdXNpbmcgd3JpdGVsKCksIGV4cGxjaXQgd21iKCkgaXMNCj4gPiBub3Qg
bmVlZGVkLiB3bWIoKSBpcyBhbiBleHBlbnNpdmUgYmFycmllci4gd3JpdGVsKCkgdXNlcyB0aGUg
bmVlZGVkDQo+ID4gSS9PIGJhcnJpZXIgaW5zdGVhZCBvZiBleHBlbnNpdmUgd21iKCkuDQo+IA0K
PiBCZWNhdXNlIHlvdSBtZW50aW9uZWQgaXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCBXaHkgbm90
IG1lbnRpb24gaW4gdGhlDQo+IGRvY3VtZW50YXRpb24gdGV4dCBhcyB3ZWxsIHRoYXQgd3JpdGVs
KCkgaGFzIHRoZSBuZWVkZWQgSS9PIGJhcnJpZXIgaW4gaXQ/DQo+DQpJdCBpcyBhbHJlYWR5IGRv
Y3VtZW50ZWQgaW4gWzFdLg0KVGhvdWdoIFsxXSBpcyBkb2VzbuKAmXQgZGVzY3JpYmUgYWJvdXQg
dXNpbmcgSS9PIGJhcnJpZXIuDQoNClRvIGtlZXAgWzFdIGFuZCBhYm92ZSBleGFtcGxlIGluIHN5
bmMsIGFuZCB0byBhZGRyZXNzIEFraXJhJ3MgY29tbWVudCBbMl0sIGl0IG1ha2VzIHNlbnNlIHRv
IGRyb3AgSS9PIGJhcnJpZXIgZnJvbSB0aGUgYWJvdmUgZXhhbXBsZSBhbmQgcmV3b3JkIHRoZSBs
aW5lIGFzIGJlbG93DQoNCiJOb3RlIHRoYXQsIHdoZW4gdXNpbmcgd3JpdGVsKCksIGEgcHJpb3Ig
YmFycmllciBpcyBub3QgbmVlZGVkIi4NCiANClsxXSBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC9sYXRlc3Qvc291cmNlL0RvY3VtZW50YXRpb24vbWVtb3J5LWJhcnJpZXJzLnR4dCNM
MjU1OQ0KWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNWRiNDY1ZjMtNjk4Zi1lYmVl
LWE2NjgtMTc0MGE3MDVjZTljQGdtYWlsLmNvbS8NCj4gPg0KPiA+IEhlbmNlIHVwZGF0ZSB0aGUg
ZXhhbXBsZSB0byBiZSBtb3JlIGFjY3VyYXRlIHRoYXQgbWF0Y2hlcyB0aGUgY3VycmVudA0KPiA+
IGltcGxlbWVudGF0aW9uLg0KPiANCj4gVGhhdCB3b3VsZCBtYWtlIGl0IG1vcmUgYWNjdXJhdGUs
IHNpbmNlIGFjY3VyYWN5IGlzIHlvdXIgZ29hbC4NCj4gDQpZZXMuIEFib3ZlIG1vZGlmaWVkIHRl
eHQgbG9va3MgbW9yZSBhbGlnbmVkIHRvIHdyaXRlWCgpIGRvYy4NCldpbGwgc2VuZCB2Mi4NCg==
