Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA407818BA
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 12:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHSKbc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 06:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHSKbb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 06:31:31 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2040.outbound.protection.outlook.com [40.107.12.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BD12DD24;
        Sat, 19 Aug 2023 01:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBmENzGTcUVp0G+MH+ocGhK7ySmF2R0a4d1+59DRKz59CZTWRU8vfUMD/rWSPEoFxfCsdgge9mLqiliIzYv8daZ7ZP3MPXMcBKScVxEipwpNJNt49Ga0sj+DGf7cr4ifeK8PZzTktxa1u+InUjNIXC9JqAyQpA2E0xEiNlwpgrDJGO1W6/Xbn7GruL//wNATiXxidwTGntZ+bCfTSHBF9BxrUABnSDTOy3QIOa1rIaW+x6FgJxP7436yqOHzCp+WlBtTFlBf9lHv/4fHrhEd3V69+25pFpLwganQMBiler3jQ2mP3t9K280GVuWKaZsGki8epiAlFVac0dDqp/m0cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwUe6Wo8Ua5nVbNH9rxeKLQvUgz0aX/os4ro/0ncXIE=;
 b=hHxjLWd6T8C09KV+4OoEN5TmlAAhfZBqLVpyxPOqGySbUox59llOnOAKyyBQXZJDQYyAjXZKpxJBz7KmySaOTuSEar613AQKaYusx48f+FYMRV5bwT6ZvnBz+tMCJWF9cMT0ysDSQ9bhMBohAafdDcPNodh9i9jeUcXmZzSS7ZcSe+hE4ObGU3268ZhONwixeEw6bHB+Fa5fschlEyGfkqsPyDOhEm7T5UadIdTB8Tz8hgAciBY7d1hdNtP9WOioK5jBs2r4FFb/MZXfHnOXBQGLxXbU2tozUqoamziuc5ZjLXb4ttK9a99+tanrCiRzofln1cgsCMf8FkZqqsXmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwUe6Wo8Ua5nVbNH9rxeKLQvUgz0aX/os4ro/0ncXIE=;
 b=KPgo4roDomgrxWdrgqY4K74PmTVx5YtgDWWCZSRtheFFRq2aTg+1AVQDky4C84aD2kwj6j67xx3Uztq5x+wK1AUkG6IRkvhwUBScazc3JGEoxuj+08k9zusEYKnrVskt+M/Ow/M/pkiYSLnT1QdrAplteeh2xZQf573/lDBcjDKEd434FcwygMbR5y/ddPmaHOgraViop1tGLjnv3/PlP8zjZbNdFnf7AvJoPXgjmQvOGYTiM/h5erwjNahEQJzSyx/9JXINCVZCnfAAvW2YhmtnQvg1u2AUgKOqZWReTq6PorN7LY2rlCEBBi/PQ1Cte0oyePVIvSJBamSrnrD6/Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1710.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Sat, 19 Aug
 2023 08:53:25 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6699.020; Sat, 19 Aug 2023
 08:53:25 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Jesse T <mr.bossman075@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "wireguard@lists.zx2c4.com" <wireguard@lists.zx2c4.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] treewide: drop CONFIG_EMBEDDED
Thread-Topic: [PATCH] treewide: drop CONFIG_EMBEDDED
Thread-Index: AQHZ0JNUtziEhhHG30OKXvCX3Mslja/t0OeAgALpygCAAEAXgIAAWUmA
Date:   Sat, 19 Aug 2023 08:53:25 +0000
Message-ID: <c96756ed-8714-6e67-c6b1-0614f57d41d0@csgroup.eu>
References: <38e1a01b-1e8b-7c66-bafc-fc5861f08da9@gmail.com>
 <86e329b1-c8d7-47bf-8be8-3326daf74eb5@infradead.org>
 <78a802c5-3f0d-e199-d974-e586c00180eb@infradead.org>
 <CAJFTR8T-Fdu_aKapP+Lb6pLYo_ykXwXw6rFZNGR5=WKU1QwUPQ@mail.gmail.com>
In-Reply-To: <CAJFTR8T-Fdu_aKapP+Lb6pLYo_ykXwXw6rFZNGR5=WKU1QwUPQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1710:EE_
x-ms-office365-filtering-correlation-id: 25a0a489-0281-43c0-5f15-08dba091bfbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EcHqq81u8IuWvQFw6rUWkmaUTXy3cVON9a2a66acd2sQPPTlvBKI8BRS1eET+eHTAH4OTUDjB2lZ8pPDrHmCQ0DrqP3nC5msHJI7VQxdtCXX0sepN4o+qBV8hRDfviSdlowA9+eF+7c7sT1CZRt/WRvfuOldfK/rbcbijNdXwEBlDHFwtmapimoMRGbGR+/Dx1a4Gc4KGfXvMZ1MUdV6WxfukeoAhXxc/mwGsy1dg5AQ7keUlWqdLKNNcbFAjK5WVeHzJt+Ccooevx2zdtNlAck0gbU0TuV/Ufy6biTHrtU6bbEg0JLUfGMuy+TqLg3m/NzHkWU+hbkeoiX4uwWB2X6RkmKcswB/M1Kwv6JdEE03fiVuQA64NBWYFx2DEGTaJXD/X9yJxq4z5bBI6LgxphoAct8q95T9jqRWFyh3lOUdYjqwzI4tb9cvmcBsGnQ4w57QeNCMJN1VU1j2VKyATmmTxcVg8pxR12pxajDkASd2b9aS3l+depKB6BgJ7GE04JXWwGKIzAU9N+4WNfKjzdj30EzwDxbYz9I1K4WJEK/+RXzGY1Sg5qpaF/UFohpP6bRukCYhG0L7WHPKLJ74QSL//vwWAUNXbYrtSU6J9X71Jg1e7mtTBonLsPmKENDXXIbNvT6TgnanMesL6MbNYdEQ0qvr6UGxWI2zUcSwBc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(366004)(396003)(376002)(186009)(1800799009)(451199024)(6486002)(71200400001)(38070700005)(38100700002)(6506007)(6512007)(122000001)(31696002)(66899024)(83380400001)(26005)(66574015)(86362001)(36756003)(2616005)(66476007)(316002)(2906002)(66556008)(64756008)(54906003)(66446008)(66946007)(41300700001)(91956017)(110136005)(76116006)(44832011)(5660300002)(7406005)(31686004)(8676002)(8936002)(478600001)(4326008)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk9rejVKMktGaExuYkQ0VzJDaTBlamFBRmF1VGRCaVQ3KyszbFJON3FaQUxw?=
 =?utf-8?B?dHZoeHJFY1BGT0ZOMTlpcXp4SWdCZGJqM1V0VmhFU2ZQR01QZDFyWWV6WUJ1?=
 =?utf-8?B?RHE3dWpTZzB0WkN5MEtGS3hkSnVxVkdtZkpOdlJYYlo0U3ZLMzFWdW5iSita?=
 =?utf-8?B?bzdyNC9pQ0FTZTNLWWVFUE5tK3VQSWdMY0JNY0N0b3R2TVcxNVFUd1IyTUFH?=
 =?utf-8?B?ZWRsSFJ3M1FoS0EvYmJoTmZnY3NWbTYrZ0dCVXBxOFBGRldQYzRHZ0ZGTHRu?=
 =?utf-8?B?ZVA1T1U3WVVmQzR4YnluZXAzcGdjRzhXY25qY3o4Y1JsdTdxcnJuZk83SGw1?=
 =?utf-8?B?WHVtMnk4TjNsSkZxWlZjeFo5MHNyYm1zcWptWEdKWXlqMjdnZERjenBraENJ?=
 =?utf-8?B?dWhIMjJZU1RmWmFmdGl6eW96QXF0SzJpMHR5SlZPRW1rSHFiSVI5cXlnWktU?=
 =?utf-8?B?bFMyYUpNcGNEd01DZXlVazFkSWpTaUx6azR4WVdUY1lQOHJOSlJvUmhTSFFt?=
 =?utf-8?B?bDhyMXBsOFpQREJnRWgrbXJLU3RzU2xVMTFweUhKTTdDV2NrbzJWSU9iRk5r?=
 =?utf-8?B?T2tYSWZocTRqUHZtV0VkUmdidFBML3FJL2NSdEtXQ1BRRk1SREljUXZ5TC9H?=
 =?utf-8?B?cEJDaVVod1hvb3VvRC96YzJlU0FxRmpTOGwwTzFlSWRxc1piUStKeUlaVjVo?=
 =?utf-8?B?elNEOWNKYkVHNVVYeFhFYUpzZzlwK1cweDlJaXY5SEczODRNSXVFUHNqWlEz?=
 =?utf-8?B?dFBkM0tONmMrdWtwUDFaUjlOSUpjTmVrYjljMy9CcjN2S1ZFMkVHNFhPSGN2?=
 =?utf-8?B?MUdBZGw1bzRpejJnVXlWVGhOdXBXS09sSnlrTGdXaWROVUJnQ3ppa2ZVZ3pn?=
 =?utf-8?B?UlY1RUJXOCt1clpPYjJaam81VGQ1UUNReWRLWTcreE5zNDlRbmxBYzliVTJU?=
 =?utf-8?B?ZStvdEprcUZaWGsrZ1lTVzNXeFc3aDNKcW5veGlOcjdrVFl6SERzQUIwL21y?=
 =?utf-8?B?N1k0WE1tNmY2OFNBMGVaV3Z0TDhzYWxtL2dDWGUrdUZBemFqR29qU1FyYldv?=
 =?utf-8?B?U1JFT2xlbUxlOHdrSktXeitWMTIzNFpGZmpNODNRSElmaXo4cWplN3NIcngy?=
 =?utf-8?B?SWxYaVVCVnJhN3R0Qkh1TjJYMlk0eDlaeXlXRTlQME5IWGlCQ2ZKMTI5dXFq?=
 =?utf-8?B?NW1HT3RDNi9iYnJWb2dYZmNhaWNUYmhDdndxV2MreVhTZ3BYNSs5eHVSV0FG?=
 =?utf-8?B?WVZjSzV0dlJUYW0rM2tiQnV1aGUrOWJFQkpXR2RjRzFpQXdMV1Y1dWhyMVZm?=
 =?utf-8?B?dU90RDlnV1NCc20yd2kvVlh6bTdoQXJEb0FsT1F2U1puNjIxeGpENFZOVjFY?=
 =?utf-8?B?T2dndUg2cE1EYnBUWDNZeEI4R1MxMm5PRVhLZEttUm03R1pPM0tYOThqVWhV?=
 =?utf-8?B?czB3aDZkb2g3MWllRDhacE9mYUZVbk1hZFFhclV1RjRqRkRwQmQ2UnhWNFhB?=
 =?utf-8?B?MkE4d05ScW1SQkFuZ1lvcWtkLzJ1YnlwMDVMQjJYQjRVME9XaFNEUzZUbkFI?=
 =?utf-8?B?bGpyOVNXUFN5TUdJRFRkZ2Q1d0ZqYVRrdlAyUHo1cDFUYUwybzlhN241T1BI?=
 =?utf-8?B?czc5cXNTODgyV3hlMTBlbDB1dHNLdHI2dEJZbGdLc2puVTc1OFJ1T0JOUHQw?=
 =?utf-8?B?OWFsVmlCMW5zbGVaazdMTzRBekw2eWo2K0pCYzJxRWRHUTlLWjNUYVI4UDR5?=
 =?utf-8?B?Z0JDUGI3a1RkOXo4aGVhaFZYQnRqaGJqcTRnKzlwdHF2YmVvVlpROVF2SEht?=
 =?utf-8?B?N1BhWHlOV1VHU2xTUStCNXFBSG1KV2JwQkord3E3ZTU4RktRdGdZZEd2M2N5?=
 =?utf-8?B?YVQ4bDlKZUhlZktHNTNyV3Z6OGlJU3g4M3BKVmdTZmVZZXdtTExsbEU2Smsv?=
 =?utf-8?B?bmU4bXhrZXFVUG5pSTlIZ1plVXM1cWRnR3J6amgrb1hXc0xtMmZYY2NRWHlF?=
 =?utf-8?B?UW55aWo0QzYxUytyZ21MTXVVeXh6S2k0blE4UFozQlF2eDBDOXp1VFI1aG9u?=
 =?utf-8?B?L3VhY0VwQ3lRaUMwL091blNCVzh5UWF5YmJudzhsSWJoY2hHeHJSSDhOZktW?=
 =?utf-8?B?VHhIK3FZVVR0R0NFVklzL3JWbGhsNndiMVduODBTMnNBUmlNdWNrUTV1Rytr?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C60E53EA9E3A6E4FA8599A24A5AAC312@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a0a489-0281-43c0-5f15-08dba091bfbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2023 08:53:25.0309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PO4+Et7rgyWy8GmTU+GNthI65EJODyACKs+rqPovKwH1kqenrXAXFKFMoOrvURBrOyOeiLqWOO/OcWCOqgLjqUz/ojwjoUgArp6vl0pm+TI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1710
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGksDQoNCkxlIDE5LzA4LzIwMjMgw6AgMDU6MzMsIEplc3NlIFQgYSDDqWNyaXTCoDoNCj4+Pg0K
Pj4+PiBTaG91bGQgdGhlcmUgYmUgYSB3YXJuaW5nIGhlcmUgdG8gdXBkYXRlIGNoYW5nZSBpdCBp
bnN0ZWFkIG9mIHJlbW92YWw/DQo+Pj4NCj4+PiBrY29uZmlnIGRvZXNuJ3QgaGF2ZSBhIHdhcm5p
bmcgbWVjaGFuaXNtIEFGQUlLLg0KPj4+IERvIHlvdSBoYXZlIGFuIGlkZWEgb2YgaG93IHRoaXMg
d291bGQgd29yaz8NCj4gDQo+IE5vLCB1bmZvcnR1bmF0ZWx5LiBBcyB5b3Ugc2FpZCB3aXRob3V0
IGEgd2FybmluZyBpdCB3b3VsZCBiZSBvdmVybG9va2VkIHNvDQo+IGEgY2hhbmdlIHdvdWxkIG5v
dCBiZSBuZWNlc3NhcnkuDQo+IA0KPiBBIHBvc3NpYmxlIHNvbHV0aW9uIGlzIHRvIGNoZWNrIGlu
IGEgaGVhZGVyIGZpbGUgd2l0aDoNCj4gDQo+ICNpZmRlZiBDT05GSUdfRU1CRURERUQNCj4gI3dh
cm5pbmcgIkNPTkZJR19FTUJFRERFRCBoYXMgY2hhbmdlZCB0byBDT05GSUdfRVhQRVJUIg0KPiAj
ZW5kaWYNCj4gDQo+IERvZXMgYW55b25lIGVsc2UgaGF2ZSBhbiBvcGluaW9uIG9uIHRoaXM/DQoN
Ck15IG9waW5pb24gaXMgdGhhdCBoYXMgaGFwcGVuIHNldmVyYWwgdGltZXMgaW4gdGhlIHBhc3Qg
YW5kIHdpbGwgaGFwcGVuIA0KYWdhaW4uIEl0IGlzIG5vdCBhIGJpZyBkZWFsLCB3aG9ldmVyIHVw
ZGF0ZXMgdG8gYSBuZXcga2VybmVsIHdpbGwgbWFrZSBhIA0Kc2F2ZWRlZmNvbmZpZyBhbmQgY29t
cGFyZSB3aXRoIHByZXZpb3VzIGRlZmNvbmZpZyBhbmQgc2VlIHdoYXQgaGFzIA0KY2hhbmdlZC4g
T25jZSB5b3Ugc2VlIHRoYXQgQ09ORklHX0VNQkVEREVEIGlzIGRpc2FwcGVhcmluZyB5b3UgbG9v
ayBhdCANCmtlcm5lbCBoaXN0b3J5IHRvIGZpbmQgb3V0IHdoeSBDT05GSUdfRU1CRURERUQgZGlz
YXBwZWFycywgYW5kIHlvdSANCnVuZGVyc3RhbmQgZnJvbSB0aGUgY29tbWl0IG1lc3NhZ2UgdGhh
dCB5b3UgaGF2ZSB0byBzZWxlY3QgQ09ORklHX0VYUEVSVCANCmluc3RlYWQuDQoNCkEgY291cGxl
IGV4YW1wbGVzIEkgaGF2ZSBpbiBtaW5kIGZyb20gdGhlIHBhc3Q6DQotIENPTkZJR19GT1JDRV9N
QVhfWk9ORU9SREVSIGJlY2FtZSBDT05GSUdfQVJDSF9GT1JDRV9NQVhfT1JERVINCi0gQ09ORklH
X01URF9OQU5EIGJlY2FtZSBDT05GSUdfTVREX1JBV19OQU5EDQoNCj4gU2luY2Uga2NvbmZpZyBk
b2Vzbid0IGhhdmUgYSB3YXJuaW5nIG1lY2hhbmlzbSB0aGUgcGF0Y2ggc2VlbXMgZmluZSBhcyBp
cy4NCg0KU28geWVzIHRoZSBwYXRjaCBpcyBmaW5lIGFzIGlzIElNSE8uDQoNCkNocmlzdG9waGUN
Cg==
