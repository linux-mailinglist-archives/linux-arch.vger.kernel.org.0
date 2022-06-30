Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35B85616A1
	for <lists+linux-arch@lfdr.de>; Thu, 30 Jun 2022 11:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiF3Jk3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbiF3JkP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 05:40:15 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120049.outbound.protection.outlook.com [40.107.12.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256A43ADF;
        Thu, 30 Jun 2022 02:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvimmMh5CJ7euOtnTel89VL8bNgivy0uPL2CeRAn7Vcpe9gBUhjSUnuXdXZvMPQ/n0DsI17L/98p8k69N2T3arQJywYEog2PLkWoGNWIP5HJbj2zj7KNr4QPjYyb/iXCOBx43UNr1hZa9qB8HRbr5mEBp9jRTVdK23N6bYqF6f51cuXi21Qso2hlXGlEl9li75Wsv7yt/qFfQa44F3AbyQUh5TmrfnZ+f897y4JQnVzOJyMibCi2AmGg5PY8rzu37FvWYL8fBTFTilKhi5k2uvXBrWAltDMgMDxts3KpmRHilzCJOKvFu2tK63AXp2GeD/zg2DMQqffTK5EoKSpX4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMeKVwvSbRwvoBs30QPDxE281RsKQasxaJqwbmlllu4=;
 b=cWVt1Jl1jZGKx6339YaVjvgC+rsSAvBh5tvqNlSt6Y7u14QfRwkJNvBa06LuSrvVBQEZhXmMslLmLVJjDFoZ5NWiviTy3pths27RYNWqAatEC7Ne0xb8KntWFD2zjvezgFOUz7bFe05DAEiTex4suREWuYUrUVk+shI9W8OhaGK1ykKyEsmmNNuH5T/1lytOjZcB/ED46de8ymd7yMz52sFxGLSX71pGdyPMdLNhNhL7tDcCrtWjE0+EQAR/9IF1B8yjIJe0eQpQSMh7Tnj3PGoHviQouwNESamlT3NJb8NvM5AwmzSQMydLa46IMaxm4Enn2/ZzLJR41LuWOM1u+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMeKVwvSbRwvoBs30QPDxE281RsKQasxaJqwbmlllu4=;
 b=ZU2IHEXgYTh3xtZ3bfJeDls6oYA+prJXQ7JDCs10uhCGFDAD5KmeqPAVW0s7IpWv3HjV36sWEdiEczP18K3lS58Jk4SLr8GNbGnDMTzKMnS+Grr9IhIWDSbGxx7vVsNl6RAWwNahrTMqw9N/Cm9XngeHed6AA+dEzJDhjbkTjXoPswDnrixJaf613sMVs3IdulxhCSDCyxGsgMoi9vA7uR1GUGuX1NpHdmZZTZacCxImoMvsNafc3iQcHBTcq011F7dLn/MSdzijUNuQyqDhl4zsEKoLw8UhTK+B0Y2vAzRWpc/kbN2fqkCZUERO+Si8biuVETZQU2cWzMr9LO5rTw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3884.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 09:40:07 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::e063:6eff:d302:8624%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 09:40:07 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Michael Schmitz' <schmitzmic@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>
CC:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Denis Efremov <efremov@linux.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matt Wang <wwentao@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Thread-Topic: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Thread-Index: AQHYgko2LS/pMWfW70ubVz2tbpCdNa1UWsAAgA6f54CAANYAgIAAaFUAgAA844CAAOqegIAADSKAgAAV5gCAAigCgIAAGqcA
Date:   Thu, 30 Jun 2022 09:40:07 +0000
Message-ID: <a36a85a3-3fd3-10ac-cac3-09a90eaf1936@csgroup.eu>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
 <c30bc9b6-6ccd-8856-dc6b-4e16450dad6f@gmail.com>
 <CAK8P3a1rxEVwVF5U-PO6pQkfURU5Tro1Qp8SPUfHEV9jjWOmCQ@mail.gmail.com>
 <9f812d3d-0fcd-46e6-6d7e-6d4bf66f24ab@gmail.com>
 <26852797d822462abc1c9f96def7fa42@AcuMS.aculab.com>
In-Reply-To: <26852797d822462abc1c9f96def7fa42@AcuMS.aculab.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 197d08b7-70ce-40d0-7d78-08da5a7c8483
x-ms-traffictypediagnostic: PR0P264MB3884:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YgefRFycATSF/wH5lwAcSBvoAr7lJUYaXBANNAXV02nvFe/wclA5C9wg8npkHg2oHXSr/z2GTmIe7BUaP8VnwCheso9HUNnA+ZjUhZPBbW/tPoCYYBVz16D9WagbTJWbcsxQesNlkqzsCF5S3Vsyqm7vbA0KaetOmwOh6j/nZUx8BrcMdDbeUPqR9WLULIdhJEsb89ipeCrnCi53GZ9GkR+AzcVuazueeXyAPgqf0Dt7g5sfMNIEAKC8/F6KyBi4GipGipWAASMrI5ToV3U9ePpQ+ihocAOFiCtTqS9GSChugZOkNZPSjqbTyMa+wpNKZq0yKi4y/g/Psnpu5iZGqG5nzR5pa6D+Y8PRLZ05YOzvlwo38BjAUq+HYZ7eFvgvyvRBtlPHXOsWiqQmjq1tEqK5WsBayuz+uBH+n+NklRkc8lfRzqRBEJD8o5kDsW5VWXPV3exVS3tRpcV3p8HlyQxRZn7Xrxg2b7BFsXS8XuNAOqbBGZZtPJL8q24nlb/N6Kv0IwnUgKcgewsYDmBvg7YRm16sR26puQ75+H8hIbbTRAbMtzJs1rll+x+Rz8peecWqKtVfkn400nSLAPR6LEBhj6srirveJ34Zc0w7r2ivpTEQDpPqfWgdMh4o0d5sAh3yGBGpe4+3/2S48JGDseucXVJhKh5qBD0bye0b3wh+dg49FJQTFLI+vB+XoM8j2dEiaIvTEZXkcaE6pKH7IQh6wh6obbTKk98Soh+Wetwktrag0leyJL6oY3wsOoW6kYRnqXhohKeTUyJKGTibWw+QljPMm1ZLYzV5AgkpfoK6Hgr3E1o6zZan0E1YW4eEs04VXlEdWRKYqCdzItYSh8itBUJVGcdsN0ZY4yS6D52XpQrH+GqQBkgUHPoqhHDm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(6506007)(186003)(53546011)(2906002)(122000001)(41300700001)(6512007)(2616005)(26005)(31696002)(38100700002)(38070700005)(44832011)(8936002)(478600001)(86362001)(76116006)(64756008)(66446008)(66476007)(66556008)(36756003)(4326008)(8676002)(7416002)(66946007)(6486002)(31686004)(316002)(91956017)(71200400001)(5660300002)(110136005)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDVHMlY5U1Q2QVlDUmJ4WVhueDB4Sk1lL1hFRStCenVLTTM2aUg2ekdFczMz?=
 =?utf-8?B?SGFnM0oxT3UxbXBhaWxaRGVENW5MYktKaTY5T0JHajNPdW1iQnlVNmhFNXgw?=
 =?utf-8?B?NFVzNDhQK3JTM2xPK2lWSjdrbytwSlRFL2FLUGhVenZucmk2WHoyQ3pneUF0?=
 =?utf-8?B?RTRWbEpEcnNFdkNieHV5MlhRNWZwMWpuSllVZmkzcjIxZjYyS0VSVkJGZkhC?=
 =?utf-8?B?TFhUeVF2eFJlVVVIRHBhUXhLN1hROHlNYmttSE13OFNJN3BTVW03RE1WQXJP?=
 =?utf-8?B?RWF4U2xwbGc1VmdLb2ZZVi9HOStIVmhPd1FVUXBKRitSTjAzc0l6Unp1NlBh?=
 =?utf-8?B?dmI4K0VlT1czYmFjWkZaL0FjMDhVZllxRXFxYktBNTNpWFpBeUZYaUpDR1VF?=
 =?utf-8?B?eWZTRHNBYzJuSkhLZVB2ZHFucUJKbTllREpQRGNEVnk5UWkwRk9lT0RGV0hR?=
 =?utf-8?B?NHN1NnpUT2k0bVdsK1lGUG4wWnlpOG1NbzV0aVc2dXlHYWZ1QU54YTFlVXVR?=
 =?utf-8?B?YjI5Rm8xbDc1ejN1VTlLMDFsRWNCWUdPWVJ1N2NWeURqdTNSYkZqeTJYL1ky?=
 =?utf-8?B?di8ya1RaVk93b2cxTk1lTlVBOEJ3Z0RZZWhQZStoejYyVk9WdE94aDl0MFVu?=
 =?utf-8?B?QmFCWmo5ZUtxa1pCM3NEbXhzWTFrQjcwelJBbElpdVVHcGZUMm13VjhXdm9j?=
 =?utf-8?B?L1lmRGwvekNRUDVSc1ZLc0M0NmoxcXFPUFJlVlozcHo4bENoaVlJODhRakoy?=
 =?utf-8?B?WVYwaDZuT0JDQWUyTWFsMEQyQXpENG1HTGJ0clhuVFo5QzNVS3loM2FVMUcz?=
 =?utf-8?B?eDR1a1VXY2tuRG5rcG84SFVVL3hzYWx5cFZPdlIyRGQzYldmc01YWmZ2bnhi?=
 =?utf-8?B?b1FJeUlXUE9sR2MxRTNETk9YNjZEaEFNdlRCN280VW1MV01sWFJrT2pRekY1?=
 =?utf-8?B?d0FjaTUvem1xVXprTVBzOFRJeFpkbWVjbEVZN3FUcCtndmJRdExEQUJESlhp?=
 =?utf-8?B?MTE5VlRKQ0x4QTgvbzA0SDF2ZVZod1AyanVxNlZtTFNETHhyYTdVQk5WeE5t?=
 =?utf-8?B?RmhUMFJNR24wbGVmVmk1aUtGTWVsdmpiTlFhUHFqUkIzKzRxMjlnUk9PRU9E?=
 =?utf-8?B?emd3Mm5jYkEvRXU3TVhjN3hXbVd0OEFlQXQyeE1hYXo0MTlLbHpvSHprUTdo?=
 =?utf-8?B?WGJ4ajJiaVR3VEgrU2hTc3YxcjhnUWtvSk1EM3lxcHpPT0d6dFJWM0tQbGQx?=
 =?utf-8?B?cTRLRHpSUGJWN2cxZ1ZGRW14ZjNLNVJSQWxXcWxSS2ZvaG40dmFlZDhFdXQx?=
 =?utf-8?B?dWZ1M05hYVBtYWg4NWQ0VXZ0RXFjL1NWbUcrK1ZTaFdxWEVwdFNqcEJqcDlv?=
 =?utf-8?B?TC9ueVNlZEtCZ3dVS1gzaFBRVGc3V1ZDSWljS0dQb1BoUU0ycDJmQ2FueC93?=
 =?utf-8?B?Wlk3ajF6eUlKSzNxY2krRC94Ym1qN3NPNUlMeGk1YldTN1ZVQVA1MmttQlJl?=
 =?utf-8?B?dDlZSWJjM2taYVZ1K241WWNlUUdLRGRPV1M1VjF5MitGZFdVeFFXcjB2Slcr?=
 =?utf-8?B?ZUU0VVFzWTJaZXkwZXBrcU9lendPZVVVaFJiNmRvN2Vwc3VJMTlDOC9tZjBV?=
 =?utf-8?B?SEs3RTZpeGtPUkozNHJFeElKekRuUlRzcFl0YTJYZDdtcWJUQUliWFZ1WWVC?=
 =?utf-8?B?ZlVvNjN3TDlvQ013OFhULzV6MVo4U0I1ZTRHWEVVeUVmWGNlaXJFUlI2QkFR?=
 =?utf-8?B?SHgxL0ppMGd6ekdjQTZxaFc5MnZnQlZjSWlhODFiS3BIUk9vZTVwT3hDSVJy?=
 =?utf-8?B?QUZCSHFMMFk3UHBzVXZPNktQMm0yKzB0MmNSR3hnTEEvdXRsLzQwR1NkRHY5?=
 =?utf-8?B?VmpOdytkS0FDV09iemNnTXlpc0tEQTQwVzcyTzNsdkRPSlFuY2JuZ3ZQNTha?=
 =?utf-8?B?SmVqcm9BNzhpY1cxZmM5U3E0VysrSEZmYTBjdlBYbVRoY1pkMFh0bVVKbkxz?=
 =?utf-8?B?MTdycWVqcWdhR01GMldreW0rZ1BKYmdLelVWbDVaU0lEdzg1VFdhdmNpNHo0?=
 =?utf-8?B?eUovSng0K0RTMmQxdnR1dlFlNGllc1hncjFGcFY4eFg1WEhxZzZuZ0Y1ekty?=
 =?utf-8?B?Tk81QTZPSWtCeFB4UFZrODhlTGhYUlVrWnRmZ0tiZ2FxSC9XbTMwS0JnTGdp?=
 =?utf-8?Q?1ybU3eQfBpz7KVuGSeaSkX8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57345C3932941D43899ACCFE1837141A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 197d08b7-70ce-40d0-7d78-08da5a7c8483
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 09:40:07.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wCQCyMvdbRz94JyAWaTJfUZjoHcgPdj7636b4yI5xzQCmQhKbr/l4vwnEyAM82GglD98gdtMJrpaYQXpSpT5OxbizVlsvjGY5Ow/RAZMQik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDMwLzA2LzIwMjIgw6AgMTA6MDQsIERhdmlkIExhaWdodCBhIMOpY3JpdMKgOg0KPiBG
cm9tOiBNaWNoYWVsIFNjaG1pdHoNCj4+IFNlbnQ6IDI5IEp1bmUgMjAyMiAwMDowOQ0KPj4NCj4+
IEhpIEFybmQsDQo+Pg0KPj4gT24gMjkvMDYvMjIgMDk6NTAsIEFybmQgQmVyZ21hbm4gd3JvdGU6
DQo+Pj4gT24gVHVlLCBKdW4gMjgsIDIwMjIgYXQgMTE6MDMgUE0gTWljaGFlbCBTY2htaXR6IDxz
Y2htaXR6bWljQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4+IE9uIDI4LzA2LzIyIDE5OjAzLCBHZWVy
dCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+Pj4+Pj4gVGhlIGRyaXZlciBhbGxvY2F0ZXMgYm91bmNl
IGJ1ZmZlcnMgdXNpbmcga21hbGxvYyBpZiBpdCBoaXRzIGFuDQo+Pj4+Pj4gdW5hbGlnbmVkIGRh
dGEgYnVmZmVyIC0gY2FuIHN1Y2ggYnVmZmVycyBzdGlsbCBldmVuIGhhcHBlbiB0aGVzZSBkYXlz
Pw0KPj4+Pj4gTm8gaWRlYS4NCj4+Pj4gSG1tbSAtIEkgdGhpbmsgSSdsbCBzdGljayBhIFdBUk5f
T05DRSgpIGluIHRoZXJlIHNvIHdlIGtub3cgd2hldGhlciB0aGlzDQo+Pj4+IGNvZGUgcGF0aCBp
cyBzdGlsbCBiZWluZyB1c2VkLg0KPj4+IGttYWxsb2MoKSBndWFyYW50ZWVzIGFsaWdubWVudCB0
byB0aGUgbmV4dCBwb3dlci1vZi10d28gc2l6ZSBvcg0KPj4+IEtNQUxMT0NfTUlOX0FMSUdOLCB3
aGljaGV2ZXIgaXMgYmlnZ2VyLiBPbiBtNjhrIHRoaXMgbWVhbnMgaXQNCj4+PiBpcyBjYWNoZWxp
bmUgYWxpZ25lZC4NCj4+DQo+PiBBbmQgYWxsIFNDU0kgYnVmZmVycyBhcmUgYWxsb2NhdGVkIHVz
aW5nIGttYWxsb2M/IE5vIHdheSBhdCBhbGwgZm9yIHVzZXINCj4+IHNwYWNlIHRvIHBhc3MgdW5h
bGlnbmVkIGRhdGE/DQo+IA0KPiBJIGRpZG4ndCB0aGluayBrbWFsbG9jKCkgZ2F2ZSBhbnkgc3Vj
aCBndWFyYW50ZWUgYWJvdXQgYWxpZ25tZW50Lg0KDQpJIGRvZXMgc2luY2UgY29tbWl0IDU5YmI0
Nzk4NWMxZCAoIm1tLCBzbFthb3VdYjogZ3VhcmFudGVlIG5hdHVyYWwgDQphbGlnbm1lbnQgZm9y
IGttYWxsb2MocG93ZXItb2YtdHdvKSIpDQoNCkNocmlzdG9waGUNCg0KPiBUaGVyZSBhcmUgY2Fj
aGUtbGluZSBhbGlnbm1lbnQgcmVxdWlyZW1lbnRzIG9uIHN5c3RlbXMgd2l0aCBub24tY29oZXJl
bnQNCj4gZG1hLCBidXQgb3RoZXJ3aXNlIHRoZSBhbGlnbm1lbnQgY2FuIGJlIG11Y2ggc21hbGxl
ci4NCj4gDQo+IE9uZSBvZiB0aGUgYWxsb2NhdG9ycyBhZGRzIGEgaGVhZGVyIHRvIGVhY2ggaXRl
bSwgSUlSQyB0aGF0IGNhbg0KPiBsZWFkIHRvICd1bmV4cGVjdGVkJyBhbGlnbm1lbnRzIC0gZXNw
ZWNpYWxseSBvbiBtNjhrLg0KPiANCj4gZG1hX2FsbG9jX2NvaGVyZW50KCkgZG9lcyBhbGlnbiB0
byBuZXh0ICdwb3dlciBvZiAyJy4NCj4gQW5kIHNvbWV0aW1lcyB5b3UgbmVlZCAoZWcpIDE2ayBh
bGxvY2F0ZXMgdGhhdCBhcmUgMTZrIGFsaWduZWQuDQo+IA0KPiAJRGF2aWQNCj4gDQo+IC0NCj4g
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQo+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMp
