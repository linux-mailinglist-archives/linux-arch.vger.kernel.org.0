Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4612350368
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhCaP0i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 11:26:38 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:27872
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236313AbhCaP0d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 11:26:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp8Tm4DKRW5rYAsjcFENNIBb/KV0iYUaXZVj6xmLjOwqIlZ3DWwlDzN8teQZKVwTm+ML8nO4v5OjJvKZ7UYNfiP5XRSNvSxH7WvS5jcgWAk9t09t79Cco5qm7BtLHzD6a8i6qmDDbEzCsxhV/03cM7P5NDj/mQsqPuYaHnmeDjEcQX6d11+207/hxhoXbFp24pUjdIATCaPeW1HIAhmJsG9IhY2cZxN1pefchCaxYTtvEnFjNM5SfSH+bUFOq+4LS6l8yqE0x9opMdVap+9GHcVr0678mU1bzX1Qw1p3YPYnU+VlGv+B5XVAMnESZW1gojuTB2EizDET1e2xaBhJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODKxtqqICodsMpZJHAMKc8y9rGhJGqNYJ1ZFFUFXvBI=;
 b=DMbNlzjkK/rlWVJB/6wFXl2RMckaDp6fLk9gr3WuHKqUtmrN5ZRLPgXXw4BuMuvv65scy5yEe1L7tHSWkAmkG5o3OcsMft/yFKijNVWUIHg22gc2iMz3bSXu/m12eiH4f5owl3NRdoyz1KFdNFVlf7cbs+kzq+/KkERovOXi4qLPI6YmiSKFeGXa0aKc0z0+z2MmQc7gXfLHggtP2HSsxebMk8BsxPFENjdLocI0kD+NQbyrF0+u5L6rEU11uErqWd3pHk35c+FesCidqyvEIFhi6oy1rHhyLHQhItUR73vnzM+7P4tjRDltYxtBlL6fwLYX1xwHlDf6bkbtLnZfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODKxtqqICodsMpZJHAMKc8y9rGhJGqNYJ1ZFFUFXvBI=;
 b=diQGjqPmhnjuCK63Mdp8YAVTYcErQnzeapfcvd/o/0VeNqKHVIweuEVO519OlPK3KBwJZj3VYTE53GK+NgnN1uxFuv/nLwI1CR5dTjVvt5tg3Pvo1yC6VOBVR/7rkWcXNbpE4ODE/sc1bbH0YBNPySs84mMb2vcwpqs+OqPjyy4=
Received: from DM6PR02MB5386.namprd02.prod.outlook.com (2603:10b6:5:75::25) by
 DM6PR02MB4044.namprd02.prod.outlook.com (2603:10b6:5:9e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Wed, 31 Mar 2021 15:26:28 +0000
Received: from DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::bdf8:e364:ff76:5a5a]) by DM6PR02MB5386.namprd02.prod.outlook.com
 ([fe80::bdf8:e364:ff76:5a5a%7]) with mapi id 15.20.3999.028; Wed, 31 Mar 2021
 15:26:28 +0000
From:   Srinivas Neeli <sneeli@xilinx.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michals@xilinx.com>
CC:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value and
 _set_value
Thread-Topic: [PATCH v3 3/3] gpio: xilinx: Utilize generic bitmap_get_value
 and _set_value
Thread-Index: AQHXEpIKh2Z+DxgXxk2j1Ouh22Apyap5r+SAgBz1lICAB7giEA==
Date:   Wed, 31 Mar 2021 15:26:28 +0000
Message-ID: <DM6PR02MB53863852A28F782B0942ECD8AF7C9@DM6PR02MB5386.namprd02.prod.outlook.com>
References: <cover.1615038553.git.syednwaris@gmail.com>
 <4c259d34b5943bf384fd3cb0d98eccf798a34f0f.1615038553.git.syednwaris@gmail.com>
 <36db7be3-73b6-c822-02e8-13e3864b0463@xilinx.com>
 <CAMpxmJUv0iU0Ntmks1f6ThDAG6x_eJLYYCaDSjy+1Syedzc5dQ@mail.gmail.com>
In-Reply-To: <CAMpxmJUv0iU0Ntmks1f6ThDAG6x_eJLYYCaDSjy+1Syedzc5dQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [103.200.40.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d88c5b90-5a36-4189-e761-08d8f4595ac2
x-ms-traffictypediagnostic: DM6PR02MB4044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB4044D37DE7DDE661A14BA1F7AF7C9@DM6PR02MB4044.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3USOty5HJjxKwipmw7XXJM5YmRCAzNEa8oznUP34hpJ84blEFn3Hx02FB0IlbIF51ir0MlBaE3BEeLcIKGrRU3usxbV0OZKDDqst9HMQHdZ7qfObMNOSCzt4p+nyLKG5wnCnMesoqnlsxqRew16X8kUjphl13t/tibXO+r/zYRfDIHRERqhS55EQ1fv6rss6C+Use30FjpSNbeu7zt1dtIYvrHSg5o7EIbVJMqpR20dKh3CUGoxwd1TjPNuUkuMTiC1Ks4Lvukd9jR4WnZCWKEDIr/dylTH/BJmrxYdS6ateYsFj1qJWl5FQB8j0xlFKlsUE1/qbxoOdgoAM7MBizlkRBy1duGWutVaWOIRp11Ci4SazUpkF9HTRE/hjjSUfuGaIhKROY8MLYSpA7/waihcI16v7HOigIlTLxMYgVDqD8sl5pcjfhNSN5YNMcc4FP++KVTWGS2wScl95jvof9W4e5CLPhdX7hAQ+YL8iJASyFdsOc2YYOFlRgahh7kJfsLHCLzZJyTebT5ufW7UPJ8h/kO61LAQTqfuAi8kN6zfctYV3M7gRxObEU+qA0myPaDWBN8xs4eyq6xVu3VTVg7HYmd0+8UQDdjJPGOOjQjE+/tug32MS6cGnJlic8RTclYT+fxvEBx2w7Nf0rULDcN8t6FFONE+is0howoqZV1J9Of+kqC+QempXadeeoAM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5386.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(478600001)(8936002)(107886003)(7696005)(8676002)(4326008)(110136005)(53546011)(6636002)(26005)(186003)(6506007)(2906002)(66446008)(64756008)(54906003)(66946007)(71200400001)(66556008)(66476007)(9686003)(86362001)(76116006)(5660300002)(55016002)(316002)(52536014)(7416002)(83380400001)(33656002)(38100700001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cFd2RC92WkZmUmF6Z3FyakdQVkRXbW9NcHBLYlBEbTJnbGRsZS8wRmdOSDda?=
 =?utf-8?B?QVZBbEYyVld2bzJ0UUpQNHdoRGkxTFF0NDJYK1pYMFlBNmZabGdOZ1UyQUFl?=
 =?utf-8?B?QmN2aVEwVDlBSHlKMHAzSFJlT2M0cUFwWExjeVp5dlBkN2FRLzR5aWZ1Y2lQ?=
 =?utf-8?B?ejUxZnNON3ptblpEaTkrb24rT09mbEExdHVZQk5DVkZ6ZHZSZzgwVU54eXpC?=
 =?utf-8?B?dGVuRWhwN1Z5L0dpeTNmT2hBWEFGUFB2dnRTUlFDWXlHcDQ1WEgxd3orcXEz?=
 =?utf-8?B?SEo0MTBQZll1QmRaK2FpZlZoQ2NIYWdPV0pTU2EzN2IwcGVGSzNxTTE0d0V4?=
 =?utf-8?B?ZEtaZWNneCtNV09Qem5DUGZ3bjErR0ZmcEFwdkprSG5pNWVrMnpsYktnc20r?=
 =?utf-8?B?YnJxSk50S21Zc2xlUTRkbUtKL0JvVmljQ2pKWHdxMTZOelQ4L2pwZzFOenpr?=
 =?utf-8?B?b0d0YURPYUhFQ0J2Ny9UVTRXRDBhYXVhWEVCdUhyU1RlWVlKSFdvdW96RThF?=
 =?utf-8?B?SGo2T3dGSnRsWERXM2tsV20wRGYvbkFLNS9Obm9aejYzYTZGc0tITGhjK21P?=
 =?utf-8?B?L29VYjlpazQydHN1c0dqZFcxMWNYa21iNEpmMGJ4RVJhejNZNzcwTjVEQlR3?=
 =?utf-8?B?WWJLRm9jOTgrT01TbVBPcUNJTW1yelNOb01haDg1WHRFcGUyeTJ0RkdWTEc0?=
 =?utf-8?B?OHNuOEc2V09RNTlJMTI1SHUvcmhIeFF0T3FjaEtXSEVCbzJhNXA3bmVBaG5Q?=
 =?utf-8?B?bmp4d3NGNkw5MmttYXJVZy9hM29iZFQwaWlRMWRzblMzVE1LTEpRVGd1Sjlx?=
 =?utf-8?B?R25uTEg2U2FsR1ZXWWRwa3NZeHFtQTlHaFo1bVpMUEptZERRc050azUwQmxQ?=
 =?utf-8?B?WTdpNjZHOUFpWWpuSWsycGZodWFaWGhheS9LdEI0dzhqT1RsMm9uTkV2MjRI?=
 =?utf-8?B?K083RmdUY2pDUEJZdnJGS3NiekJMeG9xMSt5cGR1SXVtdXZjc1YxT3RvNm0v?=
 =?utf-8?B?SHNPN05ER3lJcStURzEyU3R5dENQMlExTE1iUlFLbXllYUFzTm0zYmFnL3Fs?=
 =?utf-8?B?Nkp5ZGF0OW1qV1hCdzBrWWhaakpvZnVUT09JR21nODBHU0FORnB3MUI2amFk?=
 =?utf-8?B?Sy9YeTJRa1dwRHM5TXUxQWhscVIrVDRyOEhsZWgrSm5kWjFCVDFjdWhqN3FG?=
 =?utf-8?B?VkQ5QzJOeWJyY3Ezby9PSkxDUC9GSGtDT1NTQ2JOcDh1MzJhbEV5QWRUbTl5?=
 =?utf-8?B?MFFoL3BjeEg3VTNiN1JOOGc4OTQyVTAxaW1YZUVpUFBtNityTTA3bmFHcG95?=
 =?utf-8?B?VnI4ZGxva0Q5TStHNm1aa3RtejFzTEd5RUMvNTIwTGdXV3NGMktvQW41RkRp?=
 =?utf-8?B?OUlXWFdkRys1Mit1NXRITUlMTVpNNFB2M1lkaWtTU05aRUxNWVYrd3ZDc1gx?=
 =?utf-8?B?TzYyNmlJNStYcHVtRllVSkxhKzM2Z0ppYWxqOEMxV2lBNTRqeEJnTmJRK056?=
 =?utf-8?B?UWdNbjNlSUxmZHd6YlEwVjh2Y0lTaytKWUdLRHdJQWt0RFloOUNLWExONm1W?=
 =?utf-8?B?aCtBa28zY2ZFTWpjNVczSVBONHYyUHlWVVRza3d0ODc1RTJKNGtLd0k0YzVD?=
 =?utf-8?B?YjdmeWVkRDRiL2JUek94dTdhdmlRVDg3OE41elIxYjJnSGZsKzNZWW4zRWxN?=
 =?utf-8?B?ZXJ2TmUzVm84R3ljRzVDeXI3UkhqOFJyREwybHgvYWJ3NGNlMXFoYVByOG1U?=
 =?utf-8?Q?KXBdKzsmOm4GWVtlLylcWL0NNNCk+v2bG4D/ySI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5386.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88c5b90-5a36-4189-e761-08d8f4595ac2
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 15:26:28.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9a/F/G7vc6I15ZEsT4QMvuNfOIalTrntX5jwjCvGFkRjU8mVfDqcc0IgMuo/xBWWaGeeCkYNFDIaAyMNONcf9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4044
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydG9zeiBHb2xh
c3pld3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJj
aCAyNiwgMjAyMSAxMDo1OCBQTQ0KPiBUbzogTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5j
b20+DQo+IENjOiBTeWVkIE5heXlhciBXYXJpcyA8c3llZG53YXJpc0BnbWFpbC5jb20+OyBTcmlu
aXZhcyBOZWVsaQ0KPiA8c25lZWxpQHhpbGlueC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IFdpbGxpYW0gQnJlYXRoaXR0IEdyYXkN
Cj4gPHZpbGhlbG0uZ3JheUBnbWFpbC5jb20+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRl
PjsgUm9iZXJ0DQo+IFJpY2h0ZXIgPHJyaWNodGVyQG1hcnZlbGwuY29tPjsgTGludXMgV2FsbGVp
aiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPjsNCj4gTWFzYWhpcm8gWWFtYWRhIDx5YW1hZGEu
bWFzYWhpcm9Ac29jaW9uZXh0LmNvbT47IEFuZHJldyBNb3J0b24NCj4gPGFrcG1AbGludXgtZm91
bmRhdGlvbi5vcmc+OyBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+OyBEYW5pZWwNCj4g
TGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz47IEFtaXQgS3VjaGVyaWENCj4gPGFt
aXQua3VjaGVyaWFAdmVyZHVyZW50LmNvbT47IExpbnV4LUFyY2ggPGxpbnV4LWFyY2hAdmdlci5r
ZXJuZWwub3JnPjsNCj4gbGludXgtZ3BpbyA8bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc+OyBM
S01MIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz47IGFybS1zb2MgPGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47DQo+IGxpbnV4LXBtIDxsaW51eC1wbUB2Z2Vy
Lmtlcm5lbC5vcmc+OyBTcmluaXZhcyBHb3VkIDxzZ291ZEB4aWxpbnguY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzIDMvM10gZ3BpbzogeGlsaW54OiBVdGlsaXplIGdlbmVyaWMgYml0bWFw
X2dldF92YWx1ZSBhbmQNCj4gX3NldF92YWx1ZQ0KPiANCj4gT24gTW9uLCBNYXIgOCwgMjAyMSBh
dCA4OjEzIEFNIE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+DQo+IHdyb3Rl
Og0KPiA+DQo+ID4NCj4gPg0KPiA+IE9uIDMvNi8yMSAzOjA2IFBNLCBTeWVkIE5heXlhciBXYXJp
cyB3cm90ZToNCj4gPiA+IFRoaXMgcGF0Y2ggcmVpbXBsZW1lbnRzIHRoZSB4Z3Bpb19zZXRfbXVs
dGlwbGUoKSBmdW5jdGlvbiBpbg0KPiA+ID4gZHJpdmVycy9ncGlvL2dwaW8teGlsaW54LmMgdG8g
dXNlIHRoZSBuZXcgZ2VuZXJpYyBmdW5jdGlvbnM6DQo+ID4gPiBiaXRtYXBfZ2V0X3ZhbHVlKCkg
YW5kIGJpdG1hcF9zZXRfdmFsdWUoKS4gVGhlIGNvZGUgaXMgbm93IHNpbXBsZXINCj4gPiA+IHRv
IHJlYWQgYW5kIHVuZGVyc3RhbmQuIE1vcmVvdmVyLCBpbnN0ZWFkIG9mIGxvb3BpbmcgZm9yIGVh
Y2ggYml0IGluDQo+ID4gPiB4Z3Bpb19zZXRfbXVsdGlwbGUoKSBmdW5jdGlvbiwgbm93IHdlIGNh
biBjaGVjayBlYWNoIGNoYW5uZWwgYXQgYQ0KPiA+ID4gdGltZSBhbmQgc2F2ZSBjeWNsZXMuDQo+
ID4gPg0KPiA+ID4gQ2M6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJy
ZS5jb20+DQo+ID4gPiBDYzogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFN5ZWQgTmF5eWFyIFdhcmlzIDxzeWVkbndhcmlzQGdtYWls
LmNvbT4NCj4gPiA+IEFja2VkLWJ5OiBXaWxsaWFtIEJyZWF0aGl0dCBHcmF5IDx2aWxoZWxtLmdy
YXlAZ21haWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9ncGlvL2dwaW8teGlsaW54
LmMgfCA2Mw0KPiA+ID4gKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+
ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9ncGlvLXhpbGlueC5jIGIvZHJp
dmVycy9ncGlvL2dwaW8teGlsaW54LmMNCj4gPiA+IGluZGV4IGJlNTM5MzgxZmQ4Mi4uODQ0NWU2
OWNmMzdiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncGlvL2dwaW8teGlsaW54LmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvZ3Bpby9ncGlvLXhpbGlueC5jDQo+ID4gPiBAQCAtMTUsNiArMTUs
NyBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiA+ICAjaW5jbHVk
ZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0K
PiA+ID4gKyNpbmNsdWRlICJncGlvbGliLmgiDQo+ID4gPg0KPiA+ID4gIC8qIFJlZ2lzdGVyIE9m
ZnNldCBEZWZpbml0aW9ucyAqLw0KPiA+ID4gICNkZWZpbmUgWEdQSU9fREFUQV9PRkZTRVQgICAo
MHgwKSAgICAvKiBEYXRhIHJlZ2lzdGVyICAqLw0KPiA+ID4gQEAgLTE0MSwzNyArMTQyLDM3IEBA
IHN0YXRpYyB2b2lkIHhncGlvX3NldF9tdWx0aXBsZShzdHJ1Y3QNCj4gPiA+IGdwaW9fY2hpcCAq
Z2MsIHVuc2lnbmVkIGxvbmcgKm1hc2ssICB7DQo+ID4gPiAgICAgICB1bnNpZ25lZCBsb25nIGZs
YWdzOw0KPiA+ID4gICAgICAgc3RydWN0IHhncGlvX2luc3RhbmNlICpjaGlwID0gZ3Bpb2NoaXBf
Z2V0X2RhdGEoZ2MpOw0KPiA+ID4gLSAgICAgaW50IGluZGV4ID0geGdwaW9faW5kZXgoY2hpcCwg
MCk7DQo+ID4gPiAtICAgICBpbnQgb2Zmc2V0LCBpOw0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgc3Bp
bl9sb2NrX2lycXNhdmUoJmNoaXAtPmdwaW9fbG9ja1tpbmRleF0sIGZsYWdzKTsNCj4gPiA+IC0N
Cj4gPiA+IC0gICAgIC8qIFdyaXRlIHRvIEdQSU8gc2lnbmFscyAqLw0KPiA+ID4gLSAgICAgZm9y
IChpID0gMDsgaSA8IGdjLT5uZ3BpbzsgaSsrKSB7DQo+ID4gPiAtICAgICAgICAgICAgIGlmICgq
bWFzayA9PSAwKQ0KPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ID4gLSAg
ICAgICAgICAgICAvKiBPbmNlIGZpbmlzaGVkIHdpdGggYW4gaW5kZXggd3JpdGUgaXQgb3V0IHRv
IHRoZSByZWdpc3RlciAqLw0KPiA+ID4gLSAgICAgICAgICAgICBpZiAoaW5kZXggIT0gIHhncGlv
X2luZGV4KGNoaXAsIGkpKSB7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgeGdwaW9fd3Jp
dGVyZWcoY2hpcC0+cmVncyArIFhHUElPX0RBVEFfT0ZGU0VUICsNCj4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpbmRleCAqIFhHUElPX0NIQU5ORUxfT0ZGU0VULA0K
PiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoaXAtPmdwaW9fc3Rh
dGVbaW5kZXhdKTsNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICBzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZjaGlwLT5ncGlvX2xvY2tbaW5kZXhdLCBmbGFncyk7DQo+ID4gPiAtICAgICAgICAg
ICAgICAgICAgICAgaW5kZXggPSAgeGdwaW9faW5kZXgoY2hpcCwgaSk7DQo+ID4gPiAtICAgICAg
ICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPmdwaW9fbG9ja1tpbmRleF0s
IGZsYWdzKTsNCj4gPiA+IC0gICAgICAgICAgICAgfQ0KPiA+ID4gLSAgICAgICAgICAgICBpZiAo
X190ZXN0X2FuZF9jbGVhcl9iaXQoaSwgbWFzaykpIHsNCj4gPiA+IC0gICAgICAgICAgICAgICAg
ICAgICBvZmZzZXQgPSAgeGdwaW9fb2Zmc2V0KGNoaXAsIGkpOw0KPiA+ID4gLSAgICAgICAgICAg
ICAgICAgICAgIGlmICh0ZXN0X2JpdChpLCBiaXRzKSkNCj4gPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNoaXAtPmdwaW9fc3RhdGVbaW5kZXhdIHw9IEJJVChvZmZzZXQpOw0KPiA+
ID4gLSAgICAgICAgICAgICAgICAgICAgIGVsc2UNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNoaXAtPmdwaW9fc3RhdGVbaW5kZXhdICY9IH5CSVQob2Zmc2V0KTsNCj4gPiA+
IC0gICAgICAgICAgICAgfQ0KPiA+ID4gLSAgICAgfQ0KPiA+ID4gLQ0KPiA+ID4gLSAgICAgeGdw
aW9fd3JpdGVyZWcoY2hpcC0+cmVncyArIFhHUElPX0RBVEFfT0ZGU0VUICsNCj4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgIGluZGV4ICogWEdQSU9fQ0hBTk5FTF9PRkZTRVQsIGNoaXAtPmdwaW9f
c3RhdGVbaW5kZXhdKTsNCj4gPiA+IC0NCj4gPiA+IC0gICAgIHNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmNoaXAtPmdwaW9fbG9ja1tpbmRleF0sIGZsYWdzKTsNCj4gPiA+ICsgICAgIHUzMiAqY29u
c3Qgc3RhdGUgPSBjaGlwLT5ncGlvX3N0YXRlOw0KPiA+ID4gKyAgICAgdW5zaWduZWQgaW50ICpj
b25zdCB3aWR0aCA9IGNoaXAtPmdwaW9fd2lkdGg7DQo+ID4gPiArDQo+ID4gPiArICAgICBERUNM
QVJFX0JJVE1BUChvbGQsIDY0KTsNCj4gPiA+ICsgICAgIERFQ0xBUkVfQklUTUFQKG5ldywgNjQp
Ow0KPiA+ID4gKyAgICAgREVDTEFSRV9CSVRNQVAoY2hhbmdlZCwgNjQpOw0KPiA+ID4gKw0KPiA+
ID4gKyAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmNoaXAtPmdwaW9fbG9ja1swXSwgZmxhZ3MpOw0K
PiA+ID4gKyAgICAgc3Bpbl9sb2NrKCZjaGlwLT5ncGlvX2xvY2tbMV0pOw0KPiA+ID4gKw0KPiA+
ID4gKyAgICAgYml0bWFwX3NldF92YWx1ZShvbGQsIDY0LCBzdGF0ZVswXSwgd2lkdGhbMF0sIDAp
Ow0KPiA+ID4gKyAgICAgYml0bWFwX3NldF92YWx1ZShvbGQsIDY0LCBzdGF0ZVsxXSwgd2lkdGhb
MV0sIHdpZHRoWzBdKTsNCj4gPiA+ICsgICAgIGJpdG1hcF9yZXBsYWNlKG5ldywgb2xkLCBiaXRz
LCBtYXNrLCBnYy0+bmdwaW8pOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgYml0bWFwX3NldF92YWx1
ZShvbGQsIDY0LCBzdGF0ZVswXSwgMzIsIDApOw0KPiA+ID4gKyAgICAgYml0bWFwX3NldF92YWx1
ZShvbGQsIDY0LCBzdGF0ZVsxXSwgMzIsIDMyKTsNCj4gPiA+ICsgICAgIHN0YXRlWzBdID0gYml0
bWFwX2dldF92YWx1ZShuZXcsIDAsIHdpZHRoWzBdKTsNCj4gPiA+ICsgICAgIHN0YXRlWzFdID0g
Yml0bWFwX2dldF92YWx1ZShuZXcsIHdpZHRoWzBdLCB3aWR0aFsxXSk7DQo+ID4gPiArICAgICBi
aXRtYXBfc2V0X3ZhbHVlKG5ldywgNjQsIHN0YXRlWzBdLCAzMiwgMCk7DQo+ID4gPiArICAgICBi
aXRtYXBfc2V0X3ZhbHVlKG5ldywgNjQsIHN0YXRlWzFdLCAzMiwgMzIpOw0KPiA+ID4gKyAgICAg
Yml0bWFwX3hvcihjaGFuZ2VkLCBvbGQsIG5ldywgNjQpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAg
aWYgKCgodTMyICopY2hhbmdlZClbMF0pDQo+ID4gPiArICAgICAgICAgICAgIHhncGlvX3dyaXRl
cmVnKGNoaXAtPnJlZ3MgKyBYR1BJT19EQVRBX09GRlNFVCwNCj4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHN0YXRlWzBdKTsNCj4gPiA+ICsgICAgIGlmICgoKHUzMiAqKWNoYW5n
ZWQpWzFdKQ0KPiA+ID4gKyAgICAgICAgICAgICB4Z3Bpb193cml0ZXJlZyhjaGlwLT5yZWdzICsg
WEdQSU9fREFUQV9PRkZTRVQgKw0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
WEdQSU9fQ0hBTk5FTF9PRkZTRVQsIHN0YXRlWzFdKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHNw
aW5fdW5sb2NrKCZjaGlwLT5ncGlvX2xvY2tbMV0pOw0KPiA+ID4gKyAgICAgc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmY2hpcC0+Z3Bpb19sb2NrWzBdLCBmbGFncyk7DQo+ID4gPiAgfQ0KPiA+ID4N
Cj4gPiA+ICAvKioNCj4gPiA+DQo+ID4NCj4gPiBTcmluaXZhcyBOOiBDYW4geW91IHBsZWFzZSB0
ZXN0IHRoaXMgY29kZT8NCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBNaWNoYWwNCj4gDQo+IEhleSwg
YW55IGNoYW5jZSBvZiBnZXR0aW5nIHRoYXQgVGVzdGVkLWJ5Pw0KSSB0ZXN0ZWQgcGF0Y2hlcyB3
aXRoIGZldyBtb2RpZmljYXRpb25zIGluIGNvZGUgKHNwaW5fbG9jayBoYW5kbGluZyBhbmQgbWVy
Z2UgY29uZmxpY3QpLg0KZnVuY3Rpb25hbGl0eSB3aXNlIGl0J3Mgd29ya2luZyBmaW5lLg0KDQo+
IA0KPiBCYXJ0DQo=
