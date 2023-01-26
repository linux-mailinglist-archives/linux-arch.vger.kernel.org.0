Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29D67CC71
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 14:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjAZNlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 08:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjAZNlv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 08:41:51 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2F6DFEF;
        Thu, 26 Jan 2023 05:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl7ux7BH1QYZwdIbWYlYsKL4As7C7/lso+XTbCl95Zd7iCBytRao0evhvENljTbry5oEeoxyAZ2b3Kf6YUibGN/7NbvZ33wogXYJOx98mZYfSUdLhEAL9QJfr7rysgLAQWBTlmInE1o6HDt5J+CHdmjouF6GHE9xKm+1LIJtcy26jW/UfpmYfNFES1k5BN1NIuCPPLGNr9JLW5thFuZoq4fJvGfEOXKkRBNuJYTH7Du5Lu0ooNj4EWcP/v8ZcXRHjGOi2Uz1UTSQa8m9tWa1h5TJFRMfDDNHsGhU5IllxpVY9cFF/zF1C0Gmb/qRXpTBx9ABm+06so2tGC1iq9NWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GXikmn9qmiCfBczUikh30occA7qEcNe9xmBBdin2oU=;
 b=GjY+Pw9cLxtStKn/nb+maZDKSbv5L2l0nk3vdd1SJBlY42C6zY0UeH7s8hVDXmLw1CtzyUirlP4QkpXbU2AcVPAV/Th5tVQ4XU2y5bHjVauBwjJZ/W0y6pWcn67b+SHzuj5QKUmfOF6q7pKLwWAIvgjv2HlfpDPJy89N8kTirAKcFWSpqk1OELY0ubJFk2Be4mjiOw1lYpy/BSNchVjhO1cFKPzYSFGT9TjcIz5FMQWtYuCM6arObhOjiBWfA36o5A3jfgPkBt92S8xKg8/lKtR/Wq8tL1NKUA2RnTcdwvUD/6XLvX2Ne4OpdDCAE96LTS2xgcwdctol+3QmAr4+Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GXikmn9qmiCfBczUikh30occA7qEcNe9xmBBdin2oU=;
 b=BD97YNbxyUe3hAee9GgvPY+iWUDu7yqfkDmiqRKGYyeIFqCa7ia9v2kZY/T6ubmK1zMClN8adS4spBBQYfUhZUUNeybcbaXOvSPZaeoIMfjl7V9va+30eS25oz3HJBeWzpHbiWEZKwJMO/zJ+DnjVGa5HcidhBH0SMh0lRxJixFeefXBcBwoM1/gcCWJLWjfJ9AlppkGntbk+S2TEU1+haw6HCdFyjPgRcXEo3bV9m5SVRpRaPR4rcVy4duk3aPPKNhzRAydBIT1Q9Zv8cZDqQJL/CT0V7yIPD3FWqqV32XyqG7Bz9Kv0EiXXlptgvD4EEacS82iQC6Fub3orCAItQ==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by DB9PR08MB8674.eurprd08.prod.outlook.com (2603:10a6:10:3d2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 13:41:45 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 13:41:45 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Thread-Topic: [PATCH v1 1/5] gpiolib: fix linker errors when GPIOLIB is
 disabled
Thread-Index: AQHZMPkATbER0wIsQ0KiuzYNmSrrJa6wWpKAgAAixICAAChygIAAA3kAgAAJQQCAAAM6yA==
Date:   Thu, 26 Jan 2023 13:41:45 +0000
Message-ID: <AM6PR08MB4376030EDCFAD7F5FD5313D2FFCF9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
 <20230125201020.10948-2-andriy.shevchenko@linux.intel.com>
 <ca399c86-5bfc-057b-6f9f-50614b91a9b9@csgroup.eu>
 <Y9JTo1RkxT2jORPE@smile.fi.intel.com>
 <7b7df1f7-4f47-d19a-02ff-91984b25ba98@csgroup.eu>
 <a9ec7f46-dd07-40e7-ae48-a1e48d2101c5@app.fastmail.com>
 <Y9KAPge5zy0cIqi8@smile.fi.intel.com>
In-Reply-To: <Y9KAPge5zy0cIqi8@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR08MB4376:EE_|DB9PR08MB8674:EE_
x-ms-office365-filtering-correlation-id: 9f810e65-7a53-4468-2eef-08daffa31102
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Md4uyxS5TnivgjUOTw2jOESxVc62aqKaGlKXWMqp+AN02mD1eq2XSD+kcqbZ4UrB27EPofVPuXWWKTeufrkuKFraztjMk8RYxlAGsfun6m7cgk/ZBAs1u3wQrC1s4alJWt096KfLwfXiaa5VxQGC9krqJE8dcRi6XdUdqTXqMzNRStO2OeOV7zlJI6QgmyYq2ZbhMi1P4DYUBungM5yCIRxQjhTrU/xnBQp0I7Pf4Mf30dK/fz9E1QEWyb54yL3rneeYNPCZ8SzVMM07kya33c9ec6ZmA8ZQTEmO6vMgZk84qJhGchiUIKmmRbPBEF82sNdsW3X6lxNvuh4jKFq/K1NRos5BQKRpzgEeMXuTUjBhgVTXNwclFB5aSIeqSyT+5Efe5nKq7E+T8/6jkvWcXash5FfGEeoHOsMmbtKDoPDZYRp5aoIJIH9mYPrnsfmfFpXaEOP5WsYkmPEIE3Po3GCl7IS78LMIsTw84FPTaHfhphaHyx/WP3IptmBPQLYDfCzJafvSHhrF8DQCRKJVISVYJZZ6aEBWB4sVMC6Iw4YtvDCxeDZwaN2WhAgpIda2tDPddS6EwoyMvUzng0EkSN+aqsI09LFIro9jfwQbrAxtC6+2SneGrXSFX6XwzxQ8Q00hgQNJ6HS9dKChXLmQENSwcNRLxqKvnk36bmJ4yiVyMWMzoV8e6O385UCOpBAPWAvXxr1643H21sofqFeeRP/elYvxnhi05SWlP3xK7wY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39840400004)(396003)(376002)(136003)(346002)(451199018)(6506007)(5660300002)(26005)(186003)(9686003)(52536014)(38100700002)(8936002)(38070700005)(83380400001)(41300700001)(122000001)(7416002)(71200400001)(7696005)(2906002)(966005)(478600001)(33656002)(4326008)(66446008)(64756008)(76116006)(66476007)(86362001)(66946007)(8676002)(316002)(66574015)(55016003)(110136005)(54906003)(66556008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?REEZ37RWTL9eXHUS+HlwkC3HnFroG2slfRTSWypNAJbuczhkchQLaGFfIa?=
 =?iso-8859-1?Q?0vFfjl8dZBX8ThaHtKM5LptNei8A1n2wJmShvBnDOz620s01invfO6mpYp?=
 =?iso-8859-1?Q?I6/7Xt945nej5sQN5TV4ufsxzcapDbL0KpM41XB5XFTzKBIkMYqfZh/cG4?=
 =?iso-8859-1?Q?GHRHlPYZEKDN/6zi37DN6arPmEA82w2mbk6tS+rdcJM9FBiVyXblyEBHrK?=
 =?iso-8859-1?Q?ZLsZ53CJ0UVnXza6pB6YMUVf77Gq5+eGIAe0104MVznrM7AAIYwgm8BXei?=
 =?iso-8859-1?Q?//eR9NFRgf9iwBn15/FhM0J5tziwa/SU23agi1ZdMMnCIAA5xBvr5V32eF?=
 =?iso-8859-1?Q?SCmLTTbquUeRYPjEQQxo3R4C4BgYT86cGTV/1QXn2nbrtD2JiMFa8Or0/u?=
 =?iso-8859-1?Q?8YtKDSspsj/FlUV2923ykm34xx6VjYKfrWPrNk01nA2uk2DR8xKtlQ6Hbl?=
 =?iso-8859-1?Q?nd7PiigXbHR51O7sOEr9L4hwbQ/wnGpBXWuNQZWvXkOb0QMjFY8vbrv6Q5?=
 =?iso-8859-1?Q?duSw0F+pQPSVq863DzQxm6vE5j6gQjS+jYhX5VtFXCBN7CIqfDWmlS4Nm3?=
 =?iso-8859-1?Q?nmoLsHWTCeg67ewZskU/HddKlo/J5VtRyocujMGrJbeYDS+N8ze/FPbPB7?=
 =?iso-8859-1?Q?MIzomj0M5P0p75zt/nRengDf8sALKnj3ScQXCQ8nDS2Katic7N7g675FNz?=
 =?iso-8859-1?Q?1LfPBOsDGFuPTsiufX3XRyGek3kv9IDAlc1NGixZPaElpezWU1Ta8hUmI0?=
 =?iso-8859-1?Q?VZs/nHmL5iTgW0HjKHKeNa87ccn2M7JqcFMNHeAfwvLKvCaewdKO8KQdA8?=
 =?iso-8859-1?Q?Mvxuveunyvv6eBV0BRlqbbROTBf0QAfTQQ8w77I+vEzok4inECDfzSCQqg?=
 =?iso-8859-1?Q?UESXxSKQQdNR+qIRevL5XeM2jidzioYMgMxtej5agGY393rGw55IvxoP2q?=
 =?iso-8859-1?Q?0Rtrv/VnmocBFJsbdo84AQr/4Hku3OkUqNKKnai3WItseqVHRnLkfdIavi?=
 =?iso-8859-1?Q?WYJySS+Oa7CxX/Bqqfxm2X7ywuehQKoXhWNyZPu5a2CuB6O/5e26PwbIw+?=
 =?iso-8859-1?Q?No6B8Gu9kuPpMofk5wX4w+wbcBJhcK4YLu426M0MetERlf/gx5VIF/uDYL?=
 =?iso-8859-1?Q?a/pgRj8dTJKtekVhTsIK8Db2UCwtTtBkcK7UWOy/v7YFdCcKAsLFhZ8/qD?=
 =?iso-8859-1?Q?zMl4hEwDU1oCHIhW/7m1RxBFP1B+oRqdsxydL8MIyMcgwRV1MbubD/SLLE?=
 =?iso-8859-1?Q?XBBSPNM5ewDBTeyx/8Vyu7dyMPs1BClVUQdbepCIgkT6ih+BSnl2F4H3rx?=
 =?iso-8859-1?Q?yygtcvfqQuDRAjLrFV3wuFVeia+nUV/i86KKp9zXYDlxDQ6DyVjl1Pqvpy?=
 =?iso-8859-1?Q?fq4vwM/IqIm6PErjUHlxtCZ3x0BqR1qZz8x5oiDKYF3DM2q25ZMN1oAXMj?=
 =?iso-8859-1?Q?RqkRLN3f5kYgGsaXdMDe/MMQv/KSAnEvw7kN4lOEIau2P3xvUxzJ7xGOa4?=
 =?iso-8859-1?Q?yo1xysFeaDiaN8NgvkAJj6bZpBmXQcjT0HI4PB/acQRT0Kj6vE7xyNnntB?=
 =?iso-8859-1?Q?gP8paXOQh8uO72BKzER7VMBTS1GtYDSNbgQ0180GzU41fNpN3MSZwK1JA1?=
 =?iso-8859-1?Q?MgrmeIT7zUNrM79u2HbNvIOZ71MAME2uf4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f810e65-7a53-4468-2eef-08daffa31102
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 13:41:45.6141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3bGLTGiHojEmrNOSSbGsDorODxy3ppXldipCi9Gh7TuT46gWaQIezdboqghXGEjHAN++fgmIA7BKEuv7HEft3syg1RFRkgOUC79Na+egkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8674
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 26, 2023 at 02:29PM +0100, Arnd Bergmann wrote:=0A=
> On Thu, Jan 26, 2023 at 01:56:26PM +0100, Arnd Bergmann wrote:=0A=
> > On Thu, Jan 26, 2023, at 13:44, Christophe Leroy wrote:=0A=
> > > Le 26/01/2023 =E0 11:19, Andy Shevchenko a =E9crit=A0:=0A=
> > >> On Thu, Jan 26, 2023 at 08:14:49AM +0000, Christophe Leroy wrote:=0A=
> > >>> Le 25/01/2023 =E0 21:10, Andy Shevchenko a =E9crit=A0:=0A=
> > >>>> From: Pierluigi Passaro <pierluigi.p@variscite.com>=0A=
> > >>>>=0A=
> > >>>> Both the functions gpiochip_request_own_desc and=0A=
> > >>>> gpiochip_free_own_desc are exported from=0A=
> > >>>>=A0=A0=A0=A0=A0=A0 drivers/gpio/gpiolib.c=0A=
> > >>>> but this file is compiled only when CONFIG_GPIOLIB is enabled.=0A=
> > >>>> Move the prototypes under "#ifdef CONFIG_GPIOLIB" and provide=0A=
> > >>>> reasonable definitions and includes in the "#else" branch.=0A=
> > >>>=0A=
> > >>> Can you give more details on when and why link fails ?=0A=
> > >>>=0A=
> > >>> You are adding a WARN(), I understand it mean the function should n=
ever=0A=
> > >>> ever be called. Shouldn't it be dropped completely by the compiler =
? In=0A=
> > >>> that case, no call to gpiochip_request_own_desc() should be emitted=
 and=0A=
> > >>> so link should be ok.=0A=
> > >>>=0A=
> > >>> If link fails, it means we still have unexpected calls to=0A=
> > >>> gpiochip_request_own_desc() or gpiochip_free_own_desc(), and we sho=
uld=0A=
> > >>> fix the root cause instead of hiding it with a WARN().=0A=
> > >> =0A=
> > >> I agree, but what do you suggest exactly? I think the calls to that =
functions=0A=
> > >> shouldn't be in the some drivers as it's layering violation (they ar=
e not a=0A=
> > >> GPIO chips to begin with). Simply adding a dependency not better tha=
n this one.=0A=
> > >> =0A=
> > >=0A=
> > > My suggestion is to go step by step. First step is to explicitely lis=
t =0A=
> > > drivers that call those functions without selecting GPIOLIB.=0A=
> > =0A=
> > I tried that and sent the list of the drivers that call these functions=
,=0A=
> > but as I wrote, all of them already require GPIOLIB to be set.=0A=
> > =0A=
> > This means either I made a mistake in my search, or the problem=0A=
> > has already been fixed. Either way, I think Andy should provide=0A=
> > the exact build failure he observed so we know what caller caused=0A=
> > the issue.=0A=
> =0A=
> I believe it's not me, who first reported it. So, Pierluigi, can you poin=
t=0A=
> out to the LKP message that reported the issue?=0A=
> =0A=
> P.S> LKP sometimes finds a really twisted configurations to probe on.=0A=
> =0A=
> -- =0A=
> With Best Regards,=0A=
> Andy Shevchenko=0A=
> =0A=
I've received the following messages:=0A=
- https://lore.kernel.org/all/202301240409.tZdm0o0a-lkp@intel.com/=0A=
- https://lore.kernel.org/all/202301240439.wYz6uU0k-lkp@intel.com/=0A=
- https://lore.kernel.org/all/20230124075600.649bd7bb@canb.auug.org.au/=0A=
Please let me know if you need further details.=0A=
Regards=0A=
Pier=
