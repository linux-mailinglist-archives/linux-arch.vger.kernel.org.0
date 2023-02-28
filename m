Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B243B6A5345
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 07:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjB1G6i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 01:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjB1G63 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 01:58:29 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2070.outbound.protection.outlook.com [40.107.9.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE303E3A9;
        Mon, 27 Feb 2023 22:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwxl3wee/iyjTLVD9cK0MYEpUnkcRdqgJWHGcLb2SgC8KtD8oDvnSW/W2yI/PtzmuvTgE00WgBYVO7arR4i9T0XktKQvdWT5k5nKFFRp5CHSdH0BLPFD/0554hTAXkUOtgdMAhAxdA6cS0zlhhsO924QG+9bdrcmEQQR+fTkYd6z1E+d9eZGsfRv55jWQBXYizwzIw64fQQRVEWVoFULZOcso2Us1y+EvCF2GM2tyzzyz663+BOJAuHuCNiG20Hy6N1Q55GJAoCYJVZaUJpo9Kwb3hGO7DzepLMSyRIem4qkufgoXC7RS9BAK0XefS69hClUxT/iAOwBgPzO37sTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCLAHHXF0lbmZorfRFp1BWX8qLIp+udCu8oSVxeL3eg=;
 b=SQZmtNr+QkjvaYFY/WwfQGuVGTQNOvKfWL7TRUhIXzXLY+VgJdQ4rwmwF+GCl85V1yiNZIC5vd5bfw8CxEInn64mqf433dNx56VPpBIlqhe/PrWzzrV9KXZD/0R++QzlyXEaaVvsK2tf6BbzJFvIpbLTpRGbMy4zB6WaRXJ2zdYJHr4pfY0CQMTkrRkU2cM1Prws1ynYtJu3UVguiYSds0gqbwFGeXBOCSea8hIVf+lK+3ma6kXjsyG2LTXpzjz6xldtkEwpbOmE/xCWEdvMPRpq5tK/yDiEEYWzfRCZx4G8DHW8xdRpV4YuFMTa9Z6OdIT4nfkbZXaPxy55ms3zog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCLAHHXF0lbmZorfRFp1BWX8qLIp+udCu8oSVxeL3eg=;
 b=ZvTF6R8Ccrgj2mY60fe2MYMHyWswZvbrQluW7XVvh1DVafNp/nTaKUrswhnto+CeIId4RwR5dHzvRB+iTlAtCzT4pfd4mVw27DnYK4bmlu4EybBEMyPesyRKAIZmKrYZFbed/KUKNQiilvzfLMEVtp0dXDNroSP2f/44JPTiLLWSr7OPXcqmy7IIBKtRi6GEcJINbIGgKeTZqcNVV+4FBUpxpeiOoZeF7WaDNyLQ1Bn9oz4aWYvZg28VssIQOYrNYVd5OgQlhNbt2For5E9YmCsGu3jeoKgd4+lYSZmnOcpkcWOmArtT/oW8ozpR5O+Lpuu3nnzp7Z9gZj1BnNgl2w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2940.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 06:58:18 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2cfb:d4c:1932:b097%5]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 06:58:18 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 18/30] powerpc: Implement the new page table range API
Thread-Topic: [PATCH v2 18/30] powerpc: Implement the new page table range API
Thread-Index: AQHZStUJBEwAYnjQzEOVusOyuXC6o67jMlKAgAAKAgCAALITgA==
Date:   Tue, 28 Feb 2023 06:58:18 +0000
Message-ID: <9425f83a-e923-b119-cf7a-6b9a9f8dd8b7@csgroup.eu>
References: <20230227175741.71216-1-willy@infradead.org>
 <20230227175741.71216-19-willy@infradead.org>
 <ee864b97-90e6-4535-4db3-2659a2250afd@csgroup.eu>
 <Y/0QqO10jK55zHO0@casper.infradead.org>
In-Reply-To: <Y/0QqO10jK55zHO0@casper.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2940:EE_
x-ms-office365-filtering-correlation-id: 406def1a-d4d8-413c-2110-08db19592bd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F7+L4pLh1DG0N1GrBi0stykcuCc9TJIkTLhLFn9mEHzvx9gtBiifHmVe7aFdv2Scbfeb5ImQBGjp0UFe9d2LZDu7mj37rZG6M6I+EyQWN0KhvPgjmUt1B1Pu5n2sPkqYJAfWfcfFHI7/Mo4P4jhvUGiCHxBskgYSy+0tOBPPf0UJDhK3j+hf6FPwFDXTiMTxANn0efdVbffRAG3/9pUqfekoRmbDxmXej7nX/3wFUEpUlC2YmTDmwiVz+kbkOA6IFIbl1I7U55rl7Otg9pp5SKEcSAy55O6s/Jg0sRRPOmtxxxhKHx6SgKB9O6x36dEGFkIRCya+kIaehxdq6lnSqK3dB7Gu/uD7yHnSIKSaaYq26gXWqGvLsJGSbSFiRZkOuaHIJxf4Fe2/nBx93uCBw/OH+m9NvfEuvWRMf+scAw3DdU/KVPcqebaTg9wah+OkqwQ0mWpNJw5fIk4KEpj6EmEgGK/zyeMv8U35vIqaq1jWl34iXAsh3YSEaLc91nxMnXVCfefhVwgAZ08Pq22qVxo0cAzbE/PNWK7wubysgAJzzcg+beGSU+/hrZP7cFiD4+ixc3zYstIFqb5Wkfdrj9U+Dy4BV5XyQaqS0R711M1sQTfrGmEL2371tv3M7guAASM0gIg9deDBU0ft1kdOOOegKerwUvU7KrHR3ZKwZIF4kai+dYxZ/x5tWE841UpaY6Nv8XZ6TFMVHkOOdw+5bTCJgJiFJhMTUJZcX3hcHObXy6LWtlhnSSUOWHKA3sRov+j/EgGHY5bwEYHIaq4baw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199018)(54906003)(8936002)(31696002)(86362001)(44832011)(5660300002)(6486002)(66946007)(316002)(122000001)(66556008)(6916009)(66476007)(64756008)(4326008)(66446008)(36756003)(8676002)(76116006)(38100700002)(41300700001)(38070700005)(91956017)(66574015)(2906002)(2616005)(71200400001)(6506007)(31686004)(26005)(186003)(6512007)(83380400001)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVdwdGlCRzZMc01tU2dYd2V5TkdGRU1xNmRxU0JFQmc1dm9zMHBTWnhhVmdI?=
 =?utf-8?B?TEVFdElnM2ZuSDU0Wk9yZUFkOEJtVEVvN2M0NEZjT2F2L2x1VHBQUDNNWlpy?=
 =?utf-8?B?MVdIdWpiS2tyUy9BUmdSTWdib0dXa0E1ZzJsVHJEYkN3K3RLdjVsQzVPQ3Q3?=
 =?utf-8?B?WEZMQVUzbGNXbm5kY0RxWU5JSUMvQ2pCeWs5VE1KWlJ2M0lBZXJDQjhCcUl2?=
 =?utf-8?B?WEkyRys0RE5QblduSmoyVHFMaTJTMHMydXlyOXdlWnAvM1duK2FsanA1L2Yv?=
 =?utf-8?B?MUhuVVNOdStPQytzTytkNEtwTmNGNHdCb3EzNVAxdldwSCt6MUZQT3h3d3RV?=
 =?utf-8?B?WnY5MzJNOVZLZUZHRVdBajNmaVhXSk80R1lCK2xJa2ZmSGM4b0VtdERnV1FS?=
 =?utf-8?B?SjVwckJuN3V0UWhGNHE2bDZGcmJDcUp4bWNTajc4aUdmNXZFMWxOc2pyVzA5?=
 =?utf-8?B?M21nelRmWUZTUTBnYWJpZ1FIc0JRS1FXbE4wREdaMG5qbllKS1NZSkRBR2dY?=
 =?utf-8?B?Uy9IaTJMU1QrUENNMVdNbnc0YUUxeE1yYlY2NWhnSGtGZSt0ODhZTGZjdjdo?=
 =?utf-8?B?TEhhQnBraldlSW5BZFlOSE5haEJETWhQWWxYdGc1VEFDTE5IQmxWb3p0ZDAr?=
 =?utf-8?B?VzhwOG1XdWpja1MrK0FnVHNBZlZtbEt2eFpOREQ2VzBKYkozN2JZd3Z6T1lF?=
 =?utf-8?B?Z2hhNkVucnlGYjVaUkNHcVNmK1BZLzZTZFhZcmZnQjNiWWhBUCsvR280Smhh?=
 =?utf-8?B?N3d1dVRHbW0vWmxnelBZNHNQRlNteFovMS9FdlM1RVZLOWZHWjZCaFM5UGFY?=
 =?utf-8?B?cVh5VlJCbTdtcmF3MUFjZ1dUN2t1bW9jWlh3Umt3R3pNbHlOUkZ2VWJKVmZq?=
 =?utf-8?B?a1A5UTk1U2JIWFZTTFFFOWJpcFV0eGQ0MVZNdDJpQUFvU2h0c005Smk0RXNT?=
 =?utf-8?B?bzMwWkE4c2VHOGFZWWovVWxvWXZ3MDJpK2V3dUlKeHJ0eW80QXhFdEdYalZL?=
 =?utf-8?B?QlJ5OVBiN2F1cUtHVVZHMWc3cWkrV3puY3NDUGF2ZWRWTW5ERk9SbS9pdFM3?=
 =?utf-8?B?aGdNT0l4RUZlL0p2WUFVOFZKOWp6RitYazRvY1FYVGRrQ3V1OENFb1RuaExs?=
 =?utf-8?B?VXZSL002bGhSR3loQldOSWVBL2c2WFhxSEZPSk8xWnVZRDFDWkJpM2ExYkZx?=
 =?utf-8?B?WVJXYWphV296TFhIamV0NWUyd2dycjBMemxXVEFZSUorbTRtMEJYVDl2UVBY?=
 =?utf-8?B?OGxoS0dMQ3kra0ZoSlZ5UVZ0V29VOUN0N0t1cy9KNGttUkRsYURTU0VZU1hL?=
 =?utf-8?B?eFEwempkTWhUTXRlOERPOHozR3E5S1JPcXZQVTJoL0VueG0yRnZMN1NvN3p1?=
 =?utf-8?B?Y1Nwa0JIY0ZzTVVDekVuRkM2QUY0eWtQWmk3MENyMGprdEFtak9Qb25Oa2FY?=
 =?utf-8?B?dnRuQVlFRjFUSC9EU3dTTkNEWG9tMGl6UEtONGRDZnJQQzN0eWVnZnBJK0NJ?=
 =?utf-8?B?SEFxQ2tURStieExxQ1I1MGRuaHArNXNsSFRrTGdOaXVUNWdZRHdnN29ZRU9K?=
 =?utf-8?B?dy9mNERSYlcyMmFFYUZFL25zSHFRQ0JGZFBGeWtISlU0RjRtTktsbGYySU1z?=
 =?utf-8?B?MzNSWmc0M00vMzZaSFBqVU5rbHRMalZQT2s5b1hlTVpCY1RER0NTTVpOMU9B?=
 =?utf-8?B?dTh2cjBMQ1Q5V2k1VVZDenpnUEtkVmZrSzU1NlpCOXdMajdYUzNUSVZpZXN1?=
 =?utf-8?B?SFFFOTlJcjRsc3JsNWk4c2hnRTRKdUlxSnh6OVFEWld3QmxpT2ZRT3lYNi9y?=
 =?utf-8?B?WHl0R3FQRDZEd1E1QzN6aVVVR1lVTGpxaDVXeGZDTkJtL0ExL3hUZjYxTlh6?=
 =?utf-8?B?clJLakF6dlJMclJqcU8rRlM0YmN1N1kyZEN1QlAwQW1FR213ZS9majNQRytr?=
 =?utf-8?B?SUpNbjNNcDUrMjdmZDBWWWIwUGd3Qk01b0R4WjEzNHBIY1ZiVGhyV2dVUTNa?=
 =?utf-8?B?bnR4U21XbXNLWmpSK1pDL0VidldWVGlUbXZZeERFblNyR3lOVnVBZ09LcWlt?=
 =?utf-8?B?aEw1eDZrVU55TFNPbGhGTmR4Umg0RGpSdmtReDVESzY4Zy9IbmRuZkxOVkUw?=
 =?utf-8?B?Z2VVditzK0x4L00vNTE0WTZpaW8wT3dvSXZkTFVGMjQ3ejFZV1cyL0tTdlN2?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A29B386F57A33F46A12E3CDF298D7136@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 406def1a-d4d8-413c-2110-08db19592bd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:58:18.0538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olhKL5bbBLIehdwJL7d/EjcolVgnfF86b5/uHL/LbhO5Blvv5O6y87fPF6nsd+kFboQsYGFcizhcgaCECVPKWFE4bccNHagt5bh1KzmQqeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2940
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI3LzAyLzIwMjMgw6AgMjE6MjAsIE1hdHRoZXcgV2lsY294IGEgw6ljcml0wqA6DQo+
IE9uIE1vbiwgRmViIDI3LCAyMDIzIGF0IDA3OjQ1OjA4UE0gKzAwMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBMZSAyNy8wMi8yMDIzIMOgIDE4OjU3LCBNYXR0aGV3
IFdpbGNveCAoT3JhY2xlKSBhIMOpY3JpdMKgOg0KPj4+IEFkZCBzZXRfcHRlcygpLCB1cGRhdGVf
bW11X2NhY2hlX3JhbmdlKCkgYW5kIGZsdXNoX2RjYWNoZV9mb2xpbygpLg0KPj4+IENoYW5nZSB0
aGUgUEdfYXJjaF8xIChha2EgUEdfZGNhY2hlX2RpcnR5KSBmbGFnIGZyb20gYmVpbmcgcGVyLXBh
Z2UgdG8NCj4+PiBwZXItZm9saW8uDQo+Pj4NCj4+PiBJJ20gdW5zdXJlIGFib3V0IG15IG1lcmdp
bmcgb2YgZmx1c2hfZGNhY2hlX2ljYWNoZV9odWdlcGFnZSgpIGFuZA0KPj4+IGZsdXNoX2RjYWNo
ZV9pY2FjaGVfcGFnZSgpIGludG8gZmx1c2hfZGNhY2hlX2ljYWNoZV9mb2xpbygpIGFuZCBzdWJz
ZXF1ZW50DQo+Pj4gcmVtb3ZhbCBvZiBmbHVzaF9kY2FjaGVfaWNhY2hlX3BoeXMoKS4gIFBsZWFz
ZSByZXZpZXcuDQo+Pg0KPj4gTm90IHN1cmUgd2h5IHlvdSB3YW50IHRvIHJlbW92ZSBmbHVzaF9k
Y2FjaGVfaWNhY2hlX3BoeXMoKS4NCj4gDQo+IFdlbGwsIEkgZGlkbid0LCBuZWNlc3NhcmlseS4g
IEl0J3MganVzdCB0aGF0IHdoZW4gSSBtZXJnZWQNCj4gZmx1c2hfZGNhY2hlX2ljYWNoZV9odWdl
cGFnZSgpIGFuZCBmbHVzaF9kY2FjaGVfaWNhY2hlX3BhZ2UoKQ0KPiB0b2dldGhlciwgaXQgd2Fz
IGxlZnQgd2l0aCBubyBjYWxsZXJzLg0KPiANCj4+IEFsbHRob3VnaCB0aGF0J3Mgb25seSBmZWFz
aWJsZSB3aGVuIGFkZHJlc3MgYnVzIGlzIG5vdCB3aWRlciB0aGFuIDMyDQo+PiBiaXRzIGFuZCBj
YW5ub3QgYmUgZG9uZSBvbiBCT09LRSBhcyB5b3UgY2FuJ3Qgc3dpdGNoIG9mZiBNTVUgb24gQk9P
S0UsDQo+PiBmbHVzaF9kY2FjaGVfaWNhY2hlX3BoeXMoKSBhbGxvd3MgdG8gZmx1c2ggbm90IG1h
cHBlZCBwYWdlcyB3aXRob3V0DQo+PiBoYXZpbmcgdG8gbWFwIHRoZW0uIFNvIGl0IGlzIG1vcmUg
ZWZmaWNpZW50Lg0KPiANCj4gQW5kIGl0IHdhcyBqdXN0IG5ldmVyIGRvbmUgZm9yIHRoZSBodWdl
cGFnZSBjYXNlPw0KDQpJIHRoaW5rIG9uIFBQQzMyIGh1Z2VwYWdlcyBhcmUgYXZhaWxhYmxlIG9u
bHkgb24gOHh4IGFuZCBCT09LRS4gOHh4IA0KZG9lc24ndCBoYXZlIEhJR0hNRU0gYW5kIEJPT0tF
IGNhbm5vdCBzd2l0Y2ggTU1VIG9mZi4gU28gdGhlcmUgaXMgbm8gdXNlIA0KY2FzZSBmb3IgZmx1
c2hfZGNhY2hlX2ljYWNoZV9waHlzKCkgd2l0aCBodWdlcGFnZXMuDQoNCj4gDQo+Pj4gQEAgLTE0
OCwxNyArMTAzLDIwIEBAIHN0YXRpYyB2b2lkIF9fZmx1c2hfZGNhY2hlX2ljYWNoZSh2b2lkICpw
KQ0KPj4+ICAgIAlpbnZhbGlkYXRlX2ljYWNoZV9yYW5nZShhZGRyLCBhZGRyICsgUEFHRV9TSVpF
KTsNCj4+PiAgICB9DQo+Pj4gICAgDQo+Pj4gLXN0YXRpYyB2b2lkIGZsdXNoX2RjYWNoZV9pY2Fj
aGVfaHVnZXBhZ2Uoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+Pj4gK3ZvaWQgZmx1c2hfZGNhY2hlX2lj
YWNoZV9mb2xpbyhzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPj4+ICAgIHsNCj4+PiAtCWludCBpOw0K
Pj4+IC0JaW50IG5yID0gY29tcG91bmRfbnIocGFnZSk7DQo+Pj4gKwl1bnNpZ25lZCBpbnQgaSwg
bnIgPSBmb2xpb19ucl9wYWdlcyhmb2xpbyk7DQo+Pj4gICAgDQo+Pj4gLQlpZiAoIVBhZ2VIaWdo
TWVtKHBhZ2UpKSB7DQo+Pj4gKwlpZiAoZmx1c2hfY29oZXJlbnRfaWNhY2hlKCkpDQo+Pj4gKwkJ
cmV0dXJuOw0KPj4+ICsNCj4+PiArCWlmICghZm9saW9fdGVzdF9oaWdobWVtKGZvbGlvKSkgew0K
Pj4+ICsJCXZvaWQgKmFkZHIgPSBmb2xpb19hZGRyZXNzKGZvbGlvKTsNCj4+PiAgICAJCWZvciAo
aSA9IDA7IGkgPCBucjsgaSsrKQ0KPj4+IC0JCQlfX2ZsdXNoX2RjYWNoZV9pY2FjaGUobG93bWVt
X3BhZ2VfYWRkcmVzcyhwYWdlICsgaSkpOw0KPj4+ICsJCQlfX2ZsdXNoX2RjYWNoZV9pY2FjaGUo
YWRkciArIGkgKiBQQUdFX1NJWkUpOw0KPj4+ICAgIAl9IGVsc2Ugew0KPj4+ICAgIAkJZm9yIChp
ID0gMDsgaSA8IG5yOyBpKyspIHsNCj4+PiAtCQkJdm9pZCAqc3RhcnQgPSBrbWFwX2xvY2FsX3Bh
Z2UocGFnZSArIGkpOw0KPj4+ICsJCQl2b2lkICpzdGFydCA9IGttYXBfbG9jYWxfZm9saW8oZm9s
aW8sIGkgKiBQQUdFX1NJWkUpOw0KPj4+ICAgIA0KPj4+ICAgIAkJCV9fZmx1c2hfZGNhY2hlX2lj
YWNoZShzdGFydCk7DQo+Pj4gICAgCQkJa3VubWFwX2xvY2FsKHN0YXJ0KTsNCj4gDQo+IFNvIHlv
dSdkIGxpa2UgdGhpcyB0byBiZToNCj4gDQo+IAl9IGVsc2UgaWYgKElTX0VOQUJMRUQoQ09ORklH
X0JPT0tFKSB8fCBzaXplb2YocGh5c19hZGRyX3QpID4gc2l6ZW9mKHZvaWQgKikpIHsNCj4gCQlm
b3IgKGkgPSAwOyBpIDwgbnI7IGkrKykgew0KPiAJCQkgdm9pZCAqc3RhcnQgPSBrbWFwX2xvY2Fs
X2ZvbGlvKGZvbGlvLCBpICogUEFHRV9TSVpFKTsNCj4gCQkJIF9fZmx1c2hfZGNhY2hlX2ljYWNo
ZShzdGFydCk7DQo+IAkJCSBrdW5tYXBfbG9jYWwoc3RhcnQpOw0KPiAJCX0NCj4gCX0gZWxzZSB7
DQo+IAkJdW5zaWduZWQgbG9uZyBwZm4gPSBmb2xpb19wZm4oZm9saW8pOw0KPiAJCWZvciAoaSA9
IDA7IGkgPCBucjsgaSsrKQ0KPiAJCQlmbHVzaF9kY2FjaGVfaWNhY2hlX3BoeXMoKHBmbiArIGkp
ICogUEFHRV9TSVpFOw0KPiAJfQ0KPiANCj4gKG9yIG1heWJlIHlvdSdkIHByZWZlciBhIGZsdXNo
X2RjYWNoZV9pY2FjaGVfcGZuKCkgdGhhdCBkb2Vzbid0IG5lZWQgdG8NCj4gd29ycnkgYWJvdXQg
UEFHRV9NQVNLKS4NCg0KWWVzIGxvb2tzIGdvb2QuDQoNCg0KQ2hyaXN0b3BoZQ0K
