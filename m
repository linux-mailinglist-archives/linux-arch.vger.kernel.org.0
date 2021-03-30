Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2586134E063
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 06:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhC3Eyp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 00:54:45 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58847 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhC3EyT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 00:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617080059; x=1648616059;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FuRTLMB8S9haaNEMKBaXIHC95eqC8Z4u6i16BP9+aj8=;
  b=XEUV6LUZzZfK4Vwoo+tgGGzqa/8tZFxNlVSk5m+gCRrnr0jiChSjEGJi
   wMFkW0C5+sTiXC9Ivw+UJRSRnSoP1BfSxyaqi+Rz8ihlPdI11/xQrsci6
   YPOEltvRFAKyqmgl3xucLPE4woym6FYnRsTnvFpoQFirXxrWumkKojGcS
   9Ar6tu540ovfFnt5GBXIVoST0RLI71yCg9jDEMrZ69TcrNzMFv9jiSUIR
   BeCyoEq697gCdFCkN1mekKwjZnRVhhYEbPRxvNyRlh5V3VV2jx8XBRCP3
   rmyYhMcZRw8ElGSdJC9bfW00vZRGvqwZjTlORV4aANUWmoBtJselg2+X0
   w==;
IronPort-SDR: DpgkQQcPsozQnTNefoLWdN0TZr8K9T8Dl3VonFTTPCcGbJPZTmYJbKybJ59wNfnac3eDqmTF+t
 hdm8j6pJJflaztkW6U+Ui8H8b2vjIgwrjlhXEo2+YeOcXMi7Oid85w7jsSn0whNoeNjjLywu+C
 8TorYcJfuMYV68579am6FANawCPwXnRj9BR7Mq190AAEHRYAsbmnFqd5HjTJiJeBP19UEMV73n
 LYpOm/g+9FLY8LitcTeaQIlnWf0+wN20Zzpi0sp5bX8OQaiIRwyDgpCrUFsFZakgryWR03ydsc
 m1w=
X-IronPort-AV: E=Sophos;i="5.81,289,1610380800"; 
   d="scan'208";a="163306644"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2021 12:54:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+Jf5jV14aRm9CKlIc14exriZdil6M2s6tLCd8pA3oDYOk3ecsuMEmEgeYOcXomwECCYQ5hISOdqbGh2e0Bh7AnnpQeRBiw2satxZlxdY+UHkA9nnaQ6t9xpyFi+VoaJd4357wlv92SpJhqGO0NMVqA6laA/Tii+pse396kJqZEPyIsIpMVRWQz/zhoLkhSlm63rgQ3/lFCVl7mB7vyRrm9hH8Pu1IaMBMJ+21JsKyFUvRiV9J9TuwBxqUluu2Pb0i2LW9Cx6QAxuvrK1dI0kRmuIAwCAW6NhEaNKssRrVR+94BHfZ8T5QY/s8+nhxwsDQ8WK+Iv8u3KYzNZ3G4B6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuRTLMB8S9haaNEMKBaXIHC95eqC8Z4u6i16BP9+aj8=;
 b=dPMaDnIP24XqEUj6QQwBX65sajqfbgkf9rnKDR2ooPLFnYx2ApOcYYRCCdkCeQ3PJMb2PmbO+5QVFaZUf5HNaox2oRiBwSeFIRdkm0M/43KD0iU6bKt7AmQSTAHZPtaZ1efSB5j+vbl2TC67Z3EmQGyRPpl4N2nmNGZfK00s/jEGnM12S/vqkVH/wKiIGNBrpjtO+tUUsmkmdkf7xiPUuN8UWOAbIoUyFqZT2G/9vPzx/YlKPwNcFWSiP0ntVe7LiEMGT1HkaOVUFVBrLmwY0ABGh8CwatjOo0LKKeJBzLoDWrrw8F5SqWNnhzesC5suB3EZQyzPeE2JTP0Rhd7eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuRTLMB8S9haaNEMKBaXIHC95eqC8Z4u6i16BP9+aj8=;
 b=q/HFBwkXINn+R3+qADI+cGw1gaFq/CvGvDEchnSKJzARX/RNKJ6ydIBdzJBqPVBQpT6g1rmk8aPkk/WDBxolDYxcFBnhYyY/Dcar42HhXJQCSP0vhNWB5pUilkMN8Tg9f4BlLOad38f9kkZE6Ec2P+vksu0oeYl8bxA6FNzHCNs=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4329.namprd04.prod.outlook.com (2603:10b6:5:9a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 04:54:10 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::38c0:cc46:192b:1868%7]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 04:54:10 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>
CC:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: RE: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Thread-Topic: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Thread-Index: AQHXIzQ13Qj+G1dtVUSTIu+6TgYVfKqamdaAgAA6hoCAAAIFgIAACcWAgAANXoCAAPGCgIAAGwkw
Date:   Tue, 30 Mar 2021 04:54:10 +0000
Message-ID: <DM6PR04MB62011884B58F1F4BD5909D308D7D9@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
In-Reply-To: <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [122.172.186.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7787b79d-796f-499c-fb91-08d8f337db77
x-ms-traffictypediagnostic: DM6PR04MB4329:
x-microsoft-antispam-prvs: <DM6PR04MB432902FC3D9D70A6972109258D7D9@DM6PR04MB4329.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02Ovv4ymkLxst/2lIDUGGfyCowfjnuh9P3ZQaRlz8WH/w0NBEHXGBmYkhVoLMt0fe5piwXnsOa+2bPY5QmxwtxbsT1Eua/TpAQBRVIU9UVp6R7O7dU5KNpimgBl6nyS/rBkaYMgHOg6k/U2BhywJUs+SPYwMdcNWqbKIWMHZ4zyDI4JO7K5PMycrVsZYiPB5j3RdHUzS5zCfp2DZomn1aH3Vrll/bCg8G5naiXL077gRzG0Ck8kLUE8d1R5T/cLlgn3rVPYzl1APvKe3pgIBg3ywtn/nsEJn/gVXyexnWFgkKdD5TBbZw6JppmjJIqkmhp+9lBboNZiipPwDjgDm4eHY4VpC0eh0KIPRlSFmE9gimtsPBYskO3jHxk4Guj1pmp2GFrSg2VxUsznYSSBoQrvLxyPC2h6JMLgvftzskvxdEU68mHGckpn7kJxrixTRekxfiqSf1lh3ZIVmYAzaa1B/BxaMxA46qgJFTiQx0GLhMXFO9NJluLDJqpUmrjQJLL7sgj5DMpFseUEEZVVewNgBgckjpQ05VckAt9QUN9MtR+JXQ81mOOJGT20o47nk61v9zBBhbYslkRHN6T5/mcapB/vFmsghRQin0a+hWBYyJFHtj58gbYgbcxmUODNo2JKbIPA01SVRQ0eFpgc6v5n3J7OPcOklE0g+hRus5ddBA2lqBLiuXmOwyMPeYY1b7xHP+q3/BOpepEwP3IxGWEvjceKNWiSMqAiHzGj9gi6cddKnDPWFydh9g9FbHn1R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(6506007)(7416002)(53546011)(83380400001)(7696005)(76116006)(9686003)(71200400001)(55016002)(86362001)(52536014)(966005)(5660300002)(26005)(54906003)(316002)(64756008)(66946007)(110136005)(478600001)(8936002)(2906002)(66476007)(66556008)(66446008)(8676002)(38100700001)(4326008)(55236004)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UytUYnp0Zm9IR1BLR1QyTklGMlpIZ281eDJGZ3p2aVJnd1NURUtyUEdtL1I2?=
 =?utf-8?B?YmFWME1ZbVI1SXBFdjhoTHkzWmhNbmVOeFdvT1J2RXNKamx4c3o3R05KOVNP?=
 =?utf-8?B?aEplS2hZeHA5aFo3ZkxMRG93cmJQRnoyUmY3N2l1eHRCendZakdmTVRyNXVp?=
 =?utf-8?B?Mlc3dnBhSnR4V0ZDT3RpclpvZ0tEaG9hUStXR2RUamNuSmNOVVMyR3NSNzZj?=
 =?utf-8?B?MjRkSHNFajRSVFVNVlV1Snkrd0wzUGI4WS8yS1lUWURFUDVPN0JEMkNUZDJl?=
 =?utf-8?B?T3kvTzcvdzB4K0gzQTZXOWdPMEE2TkxPZmFoTUV0UnJIcXAzNWpMNjlVRmlZ?=
 =?utf-8?B?L0tEb0dqelZFbFBGWXNVQmVUWGpnZDFBZG1aSEdBelhzM3hCL2FDdzFLbGtQ?=
 =?utf-8?B?YUNIOWc5NVRyVEtjYjZkNHoyandJMEo3L1NOalJnWWZ4Y09MR0haTERDa1VP?=
 =?utf-8?B?d1dwNUl6V3lYejRqQlJUMFJLOXZ4QnN0MVhIRDV2WjYzdENuck9hSUEreUhI?=
 =?utf-8?B?RmpQNHBBWHBhV1FITTlrSEI4ekZ6Q29Fa244YmhReXdmV3k5VTV5Uy8zaEdO?=
 =?utf-8?B?dWg3aGZ1R2k1THU4M0xyVjdSSTlsOGltVnV5Q3Z5TGZOQUxRQmFHYnJNa1cy?=
 =?utf-8?B?SFNrdVo4Rk4zaEF1ZTFrbkNOYlFNWTBNeUZxRENpV0VYU25oanpVQlpJdGxG?=
 =?utf-8?B?clo1cjhhc09tRllRaGxBaVhFaUxpMk9UcEJ1R0V4bXNWdkRNTXAwd0UrbCtH?=
 =?utf-8?B?aHBuTDc2QURKNFpBc2tWTDAyc3pNLzBGSVBhQnM1VVBUY2YxU0FQek9NclhK?=
 =?utf-8?B?TWVBeGhEaFdyVnJ4alhidW9EYitROVoyMTJpYTV6Z1BzSExnaU5ybTNnYkpk?=
 =?utf-8?B?YndLdFRobDVucTc1NE5RSXFwWW5zN0t0dTVBZTJsMFdMVzB1VGFzZ0l1azB2?=
 =?utf-8?B?NXh4ZEpzSzVZN2ExaFRvUkRFVVhrS242V3c1c3VDcDlVUEdLVVI2NCs3U3R6?=
 =?utf-8?B?aTM0MzVtanpFWVJsWWhqWU1zam9vbXk3ZWZITVM4c1JiRWZuQVZrb25KRk0z?=
 =?utf-8?B?Vk5xY3NMNVNzaUk1d2NCVk93U3FlT2xRYjd1d2V4Sk9GWTA2a05CL2toY000?=
 =?utf-8?B?QlB5UXNKWC96ZmlnelhuaFhiTXRUMDR4b0NUek9iQi9lWGdCTzNxVWtGYnkr?=
 =?utf-8?B?OFV0cTNLN0JHa1p2cmNEZkxFYytvSmVtRlVpaWtjSjFuK25lTmtKSldZZ0dL?=
 =?utf-8?B?TmIwcXBjd1VMelF3S1RkUGgrTjFIaExDZzFDOVEwc3NCTXFkVnFRbENNbWkw?=
 =?utf-8?B?UVdTbVlnUmNHNGc4c29Bc2hHUWRlcmEzTCtkcm5PWG81MVZzeTJSbnpUb2pD?=
 =?utf-8?B?ZTY1alFrejRQanVnbnZhVmhFK3M0ZGUxZ2YzNmg2OHRJcHBNSWl5VjFMVW5h?=
 =?utf-8?B?SWVUTFFWNldLRjZMb3RNd1pyRVdveHdCeVZ4SWVWdkwwVmQ5VmR6QVZSZEt4?=
 =?utf-8?B?QVRzZjRrUVdaMVpjSmtaNkptME4xVjcwcmlRYVYza28yYlJXZzg3TG1WVlFo?=
 =?utf-8?B?Q0wyQzJpd2VGai9YeG1tSmNZbU5RSFUrNnIrbktpTVczYXFna0QyajFuM3A4?=
 =?utf-8?B?OExzK3JFbUxNZzhsbnJaeEZIUG91WHNKMk1Ddnd6WXQ0NTc0ditDWjNvWDdI?=
 =?utf-8?B?UExYNExtQnc2RWhxbXk1ZHVZYStNRVpmWWIyWngyZWY1dnBlRmFOeGEycDdI?=
 =?utf-8?Q?7mJoy30LWlg2yQwPeq/T1TW/16BBbhQ63kGxKYq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6201.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7787b79d-796f-499c-fb91-08d8f337db77
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 04:54:10.2370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WKnYb/gXgCXA9BzewmHHZd1yhRxn5qjqVx+7x6O/TYcyY/r0nAZvhuq17ZAZt29czrI19z/AObedHun+AQF4Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4329
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VvIFJlbiA8Z3VvcmVu
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDMwIE1hcmNoIDIwMjEgMDg6NDQNCj4gVG86IFBldGVyIFpp
amxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IGxpbnV4LXJpc2N2IDxsaW51eC1y
aXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0KPiA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWNza3lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcmNoDQo+IDxsaW51eC1hcmNoQHZnZXIua2VybmVsLm9yZz47IEd1byBSZW4gPGd1
b3JlbkBsaW51eC5hbGliYWJhLmNvbT47IFdpbGwNCj4gRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+
OyBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IFdhaW1hbg0KPiBMb25nIDxsb25nbWFu
QHJlZGhhdC5jb20+OyBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgQW51cA0KPiBQYXRl
bCA8YW51cEBicmFpbmZhdWx0Lm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAzLzRdIGxv
Y2tpbmcvcXNwaW5sb2NrOiBBZGQNCj4gQVJDSF9VU0VfUVVFVUVEX1NQSU5MT0NLU19YQ0hHMzIN
Cj4gDQo+IE9uIE1vbiwgTWFyIDI5LCAyMDIxIGF0IDg6NTAgUE0gUGV0ZXIgWmlqbHN0cmEgPHBl
dGVyekBpbmZyYWRlYWQub3JnPg0KPiB3cm90ZToNCj4gPg0KPiA+IE9uIE1vbiwgTWFyIDI5LCAy
MDIxIGF0IDA4OjAxOjQxUE0gKzA4MDAsIEd1byBSZW4gd3JvdGU6DQo+ID4gPiB1MzIgYSA9IDB4
NTVhYTY2YmI7DQo+ID4gPiB1MTYgKnB0ciA9ICZhOw0KPiA+ID4NCj4gPiA+IENQVTAgICAgICAg
ICAgICAgICAgICAgICAgIENQVTENCj4gPiA+ID09PT09PT09PSAgICAgICAgICAgICA9PT09PT09
PT0NCj4gPiA+IHhjaGcxNihwdHIsIG5ldykgICAgIHdoaWxlKDEpDQo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBXUklURV9PTkNFKCoocHRyICsgMSksIHgpOw0KPiA+
ID4NCj4gPiA+IFdoZW4gd2UgdXNlIGxyLncvc2MudyBpbXBsZW1lbnQgeGNoZzE2LCBpdCdsbCBj
YXVzZSBDUFUwIGRlYWRsb2NrLg0KPiA+DQo+ID4gVGhlbiBJIHRoaW5rIHlvdXIgTEwvU0MgaXMg
YnJva2VuLg0KPiA+DQo+ID4gVGhhdCBhbHNvIG1lYW5zIHlvdSByZWFsbHkgZG9uJ3Qgd2FudCB0
byBidWlsZCBzdXBlciBjb21wbGV4IGxvY2tpbmcNCj4gPiBwcmltaXRpdmVzIG9uIHRvcCwgYmVj
YXVzZSB0aGF0IGxpdmUtbG9jayB3aWxsIHBlcmNvbGF0ZSB0aHJvdWdoLg0KPiBEbyB5b3UgbWVh
biB0aGUgYmVsb3cgaW1wbGVtZW50YXRpb24gaGFzIGxpdmUtbG9jayByaXNrPw0KPiArc3RhdGlj
IF9fYWx3YXlzX2lubGluZSB1MzIgeGNoZ190YWlsKHN0cnVjdCBxc3BpbmxvY2sgKmxvY2ssIHUz
MiB0YWlsKQ0KPiArew0KPiArICAgICAgIHUzMiBvbGQsIG5ldywgdmFsID0gYXRvbWljX3JlYWQo
JmxvY2stPnZhbCk7DQo+ICsNCj4gKyAgICAgICBmb3IgKDs7KSB7DQo+ICsgICAgICAgICAgICAg
ICBuZXcgPSAodmFsICYgX1FfTE9DS0VEX1BFTkRJTkdfTUFTSykgfCB0YWlsOw0KPiArICAgICAg
ICAgICAgICAgb2xkID0gYXRvbWljX2NtcHhjaGcoJmxvY2stPnZhbCwgdmFsLCBuZXcpOw0KPiAr
ICAgICAgICAgICAgICAgaWYgKG9sZCA9PSB2YWwpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KPiArDQo+ICsgICAgICAgICAgICAgICB2YWwgPSBvbGQ7DQo+ICsgICAgICAgfQ0K
PiArICAgICAgIHJldHVybiBvbGQ7DQo+ICt9DQo+IA0KPiANCj4gPg0KPiA+IFN0ZXAgMSB3b3Vs
ZCBiZSB0byBnZXQgeW91ciBhcmNoaXRlY3V0ZSBmaXhlZCBzdWNoIHRoYXQgaXQgY2FuIHByb3Zp
ZGUNCj4gPiBmd2QgcHJvZ3Jlc3MgZ3VhcmFudGVlcyBmb3IgTEwvU0MuIE90aGVyd2lzZSB0aGVy
ZSdzIGFic29sdXRlbHkgbm8NCj4gPiBwb2ludCBpbiBidWlsZGluZyBjb21wbGV4IHN5c3RlbXMg
d2l0aCBpdC4NCj4gDQo+IFF1b3RlIFdhaW1hbidzIGNvbW1lbnQgWzFdIG9uIHhjaGcxNiBvcHRp
bWl6YXRpb246DQo+IA0KPiAiVGhpcyBvcHRpbWl6YXRpb24gaXMgbmVlZGVkIHRvIG1ha2UgdGhl
IHFzcGlubG9jayBhY2hpZXZlIHBlcmZvcm1hbmNlDQo+IHBhcml0eSB3aXRoIHRpY2tldCBzcGlu
bG9jayBhdCBsaWdodCBsb2FkLiINCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9r
dm0vMTQyOTkwMTgwMy0yOTc3MS02LWdpdC1zZW5kLWVtYWlsLQ0KPiBXYWltYW4uTG9uZ0BocC5j
b20vDQo+IA0KPiBTbyBmb3IgYSBub24teGhnMTYgbWFjaGluZToNCj4gIC0gdGlja2V0LWxvY2sg
Zm9yIHNtYWxsIG51bWJlcnMgb2YgQ1BVcw0KPiAgLSBxc3BpbmxvY2sgZm9yIGxhcmdlIG51bWJl
cnMgb2YgQ1BVcw0KPiANCj4gT2theSwgSSdsbCBwdXQgYWxsIG9mIHRoZW0gaW50byB0aGUgbmV4
dCBwYXRjaCANCg0KSSB3b3VsZCBzdWdnZXN0IHRvIGhhdmUgc2VwYXJhdGUgS2NvbmZpZyBvcGl0
b25zIGZvciB0aWNrZXQgc3BpbmxvY2sNCmluIExpbnV4IFJJU0MtViB3aGljaCB3aWxsIGJlIGRp
c2FibGVkIGJ5IGRlZmF1bHQuIFRoaXMgbWVhbnMgTGludXgNClJJU0MtViB3aWxsIHVzZSBxc3Bp
bmxvY2sgYnkgZGVmYXVsdCBhbmQgdXNlIHRpY2tldCBzcGlubG9jayBvbmx5IHdoZW4NCnRpY2tl
dCBzcGlubG9jayBrY29uZmlnIGlzIGVuYWJsZWQuDQoNClJlZ2FyZHMsDQpBbnVwDQo=
