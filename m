Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6514B91A3
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 20:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbiBPTnl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 14:43:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiBPTnk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 14:43:40 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120043.outbound.protection.outlook.com [40.107.12.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD89137005;
        Wed, 16 Feb 2022 11:43:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNyYE2hF+H9DGd4By7F/ySEhPuqt03jbYMjArKOHkpR7bnv5oTZa7tPR4TzgbJuszauR/97i6us2FoPV1XDlW7B4B3Svs+jfuAxOUNr+xb10y+Rrzizz0YVr70+GpDT22BIhAIqTjA0QLbNBOE0RqCYNeAVaHQeiTfLMHpMHup2PBMp85qNyWzR/vf2rOQWi9Fh0Ufu0Xc9pWvbrHDOAE7doAo8C/bz5Kcx39xhX1A1dqMcH7KBDe+6DVw/EJyPLRvkYFfQxbNhd4+DeJVNNMMrzhPzmT7C6KOyg4tLlab83WvYaaH55SuY2qOhfNx2v1BnDMSWltJ8E0VX/lCnTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKiUpkGWKdxoK6RmgeUJy9q95nKdIBzv7Tgl46VDnJc=;
 b=U9CKOGTb1RUjpeK1O+ZzMCUy4UFqQowzIvlUtzHDK/usbYU/FDPyMiZ4VrlhPKre5viupaXT+f/pVNYzfIaXhP3S4hyOIvOHHHQXPU1bugO7cK3EgkP7TcNje2n6hGuM9AuJMdEuWt61ZSUmgwXOGa5DrippsdJhS0nveXN0opBZFVjpCSBDI6P9KTAA7/HykPBsDNgfIES8iTvfljq8cqpScMUzfa0HfU9CyKk2dJDu0+qfNUXB1k0qCmeqR4kDH/jPwz4HLLmXm0mfaYZHC4lFWQFqWYlT2UUc06yzK0u1PaDoW41YOu4tQGzohsbkYmbgwJVMIvuU1E2FmyJY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1598.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 19:43:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%4]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 19:43:22 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Guo Ren <guoren@kernel.org>,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Helge Deller <deller@gmx.de>, X86 ML <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Openrisc <openrisc@lists.librecores.org>,
        Greentime Hu <green.hu@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Richard Weinberger <richard@nod.at>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
Thread-Topic: [PATCH 08/14] arm64: simplify access_ok()
Thread-Index: AQHYIcG2lACfrj59DUiJDVSV0p8dwqyURYUAgAAPVACAAkKMAA==
Date:   Wed, 16 Feb 2022 19:43:22 +0000
Message-ID: <07050857-c9d2-bab2-2191-8d244d6f7708@csgroup.eu>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-9-arnd@kernel.org>
 <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
 <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
In-Reply-To: <CAK8P3a2VfvDkueaJNTA9SiB+PFsi_Q17AX+aL46ueooW2ahmQw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d34d3f70-d99e-4506-7184-08d9f184976a
x-ms-traffictypediagnostic: PR1P264MB1598:EE_
x-microsoft-antispam-prvs: <PR1P264MB1598D8FEB1C2DDED285ECB39ED359@PR1P264MB1598.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZE8bfoFTs+qgxrB+OGzJFnpG9vJDsTd+tU2q26Z9+9g/f67Kg93PrwvxkTEXG37rQzU9//+inYGe+TbcutlvLU+Z2u9ABp5YLfszxXEOLsSzJIoJRnpS0GKG8DV9pLZyAyWwkijOysDo17vT/wi6hqNaTGhOzXYyhZA05+E4zaeyHgj2RMWjvl9ckAmBPbimQy3BvnD5/NSOjIzXIecJI0R9+wYMWmKqVDDoVjUZC1dQ/Hdki2aH0jTABj5U8XjUTbzjPFuGugVO7LY//3waoVTAd6XeZgtcqJCTTTgvTgwpOh2VMhI1s7hSMg7huoT33IJzgC5RpOY6ITliwXkrLmN7O9QemD7aESD3+sphr2r7YKWXgVFe959kbI6UKx9NAtYh4iZmW/O7fNjjy3GVBHVCr+zHBQGShzcMfR+h+SpGAYq26Pa7nBGgyoubNidwNH4t5bIdhz/aC2TUut7bSPVhmF2eTBZVpIegS9hhb2VSvZRYA7KimqYybQz61PdQkDvDhv1I69SptHa3GXvGYkOPyWvK83JQZeX5GsbWrliNnAhrxJmwCnBMCyZx8eDnoNHDBoxf8Y/RhbenOxpGG3YedV1EgEklAstJDSn9rnwyA8QqxlcCLJFjUpYvH//5xNywrwD0CI6Vu9zac2Da9C6Rjj1xHAdxw2li9fWinNow28OvWzpMrVvkcgt7DfXMHZbsowykal+F+jr9vXCoy6gUE4TdqJZE3DsBycuUIFOpdzBGvDuEf1nOABnX0yP1nl5wXaAu6uuFp4D5bMb4Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(186003)(122000001)(54906003)(36756003)(26005)(66574015)(83380400001)(4326008)(64756008)(66446008)(44832011)(8676002)(2616005)(5660300002)(66476007)(316002)(66556008)(76116006)(66946007)(91956017)(31696002)(31686004)(38070700005)(86362001)(8936002)(7416002)(7406005)(7366002)(2906002)(508600001)(38100700002)(6512007)(53546011)(6486002)(110136005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0Z3ZytrMlg5cDdFUWlZQkp4aGF2L2J6S1l2ZzF3WWtTa25UZ1ByOGF6SU1z?=
 =?utf-8?B?Qjllbi9SY0RJbXVwQjNCc1QyWVY0VjZaZ2ZMeHJwaE5NdEFmaE5mUkZWcjRN?=
 =?utf-8?B?TmJFSE80ZVM5WkxmRll6KzBUZ1VCZDl4ZlBXb3AzYTZjN1RpWWMydkZubFpB?=
 =?utf-8?B?WEtOM0NoVzJEcytSYVdUYTBNRWZhWmZHN0Nsc0V0SlZ1SytMc0x4VEY0TU5W?=
 =?utf-8?B?NERYamZJMnhaaEFxRFZDMHMyVUU4azJvWUVBWjU3eUo5Y00xVnU4Q0xBaVFM?=
 =?utf-8?B?NVlpK1lCdmdjS2hwelJ3TWtMc0syTFBQdGxwdElKRHBIY0tQcjJ3RXdYWllw?=
 =?utf-8?B?YmhUT0o4R085aFVVYnJEcjM5RHNkbUJERGdPZUQ5MFNLdDhYS2JINmdRSzN5?=
 =?utf-8?B?SDk4cFZoVFpJb3p6V3BzUGRtdzcrRXdwVmgzMmNQYWlaU1dJS3I3WTFjOWxr?=
 =?utf-8?B?eGdmeXpWdEFSdHNTU0VWcnh6U1loSUloMTZmRnVsMHFrMnNWYmNaVWN2aHdT?=
 =?utf-8?B?TW5TaTU2dDNNYXRFKyt6WTFTK1pwNjJ5SDFyMHF3YU1vUUlGVVBFb0pIdlZ2?=
 =?utf-8?B?QmpGSGF5REQ1THB2eHhuRUo0dVBBbnNob0pIWmRBTTVNcWlkSlVlR0VkN1lP?=
 =?utf-8?B?WVNrM2laZXdMdUU5U2srK01aMnJHZG14RDIwZGtPRDB6djY3QWhPVmJndzl0?=
 =?utf-8?B?eWVha3hsV2hMWDh0TG42Z09ZS2p2RURTNk15TmU3YlJGZVNmczVsd0EyTEtT?=
 =?utf-8?B?QlF4T2owZTBoZGxRWnhacEhoODFMczlKM1NDNG9FR21Ybnd4VkxENmhVRGdr?=
 =?utf-8?B?bUZzakpoWk9wNjc5dER6R3lKTTdNUnNNa3ExSUErUnd1RFB6cWE4Tm53REJ1?=
 =?utf-8?B?NnR2U1BLWXZNcmIxTTFOdGdjVlEyTmFBNXU0RFM2V29VWHFFeUdWakpxb1Yv?=
 =?utf-8?B?bjFFMUdGOEVhR0ZoR1dqakI3UG9hdWZGTXovRndaQUZzL3ZCVkhIWExNeWdz?=
 =?utf-8?B?NG80RkJPbmxSVk15eTFrNExIKzhCc2RUMkRjSC9xNVp4TGF4UktrbVoxUGc0?=
 =?utf-8?B?K0R5VFN0MXhYQXpSQit0eDZlZEtaYkpIVklSRE1ucHd0REgvZDlnNG8yQ1lS?=
 =?utf-8?B?WlhGMWFUVFBzZ0tpb0FvTGJDdTNiRHlTWE5RR1hDWWk5akZ0NlczZDYzckM2?=
 =?utf-8?B?RHFobENyUEoxRVk0a1VCckJtSFl5NklRMnRzYnJGeU81cHhrUG9DMS9kTGRa?=
 =?utf-8?B?YndVS2NGUWs1azl3OEg4VDZYWjI5S1E1UjEwM2JTNW1ISWF4WDlXQVNrV05V?=
 =?utf-8?B?Z25RRE52VDlEUUZya3E3dUIyUWw5R1QxOFlOSkpjUU15UjB6RGpVKytCM05k?=
 =?utf-8?B?UDR1a284RlhQdHJ0ZEtPM0FBNVJxb1l1STFkdE5jNFYrTWNSUXV5d2NOL2VF?=
 =?utf-8?B?QmtvaFJrTDUyc1Z5amhKbytFYjM0c2FiTlFVUEtjVlcyMnFTVDFnTThGb0k5?=
 =?utf-8?B?R3BoVStlMU5peEF5VWZqQkF2UEc3MnJRRHdody9QV05wcStsWjVqUWdIb0RF?=
 =?utf-8?B?bmtXaTlodldocmZwWmtacWtBSFFSRFFUNVEwR2ZwWnp0TzlOanI1YmtWTm1y?=
 =?utf-8?B?ZGFBTjlla3BQVk9oQlg2dEVCNUtpQk1vcW4rdkl1NzN1OWtGa0dFOWpaeDFR?=
 =?utf-8?B?bGc3Q1BpNFRkbnJoVjdDZFJidFRJeUllQkMrdjcyYW1QYUY2dXkya0dVVG1a?=
 =?utf-8?B?b0NYSzdXTGk1MU1EcFRHVGYzVGcvM3doOFlFdDluSVlIZERxR1hpUDRBdEIr?=
 =?utf-8?B?QkdYc0hFYTMwU251cEZGV3hyaGttMEVrcGFFbDFicVdteFdKblNQdVloMWNq?=
 =?utf-8?B?RDlGckwySFdPVXZDckFNK29YSXF1WURZQkdKY01SQ1o1ZksyQ1BlVjhmWlVl?=
 =?utf-8?B?VlhwM2pPOTZHWktvOVdsUzUrVmZCd2VKK0NESmlLUnlLc1BpdnBSR3J3b3Bs?=
 =?utf-8?B?d2xxeW4wazVQb0dYK242NkRoL2l2RkZJeUk5dXl2RVpsM280aXRLN0QzQkFV?=
 =?utf-8?B?ZkF4QWJKLyttU1UyZVlUSUF2SUNLNG96YW0vYndTaW9vVldWSEhIV0Z1YWx2?=
 =?utf-8?B?RzNuZmJJaXhuOWREOHVKbVlyUFU3Q09ieFlaSkxFYjROYkxuVHBGYU5Yd0ZV?=
 =?utf-8?B?elloTkc2YmVPZHpkRFJjNCtEWDVNMGRZaTloVVBZNFU4TzhIc0MvdHkyK3lu?=
 =?utf-8?Q?qLZ56MYUwvAFoDw77pKhrZBZw24ewVchF5ZodOMUNc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <960826EF45C096488B90F51C2BE6F213@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d34d3f70-d99e-4506-7184-08d9f184976a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 19:43:22.7323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8D3j98qzodDbwgEFF1iaEJidEYfiJc103+KQCz3ye3MaebqeBjb/fpshA/EBiFUE/BiAWJPeEVrO1tf3WCFUDgqM3mOmIssY6fke1x2lsIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1598
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE1LzAyLzIwMjIgw6AgMTA6MTIsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
T24gVHVlLCBGZWIgMTUsIDIwMjIgYXQgOToxNyBBTSBBcmQgQmllc2hldXZlbCA8YXJkYkBrZXJu
ZWwub3JnPiB3cm90ZToNCj4+IE9uIE1vbiwgMTQgRmViIDIwMjIgYXQgMTc6MzcsIEFybmQgQmVy
Z21hbm4gPGFybmRAa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4+Pg0KPj4NCj4+IFdpdGggc2V0X2ZzKCkgb3V0IG9mIHRoZSBwaWN0
dXJlLCB3b3VsZG4ndCBpdCBiZSBzdWZmaWNpZW50IHRvIGNoZWNrDQo+PiB0aGF0IGJpdCAjNTUg
aXMgY2xlYXI/ICh0aGUgYml0IHRoYXQgc2VsZWN0cyBiZXR3ZWVuIFRUQlIwIGFuZCBUVEJSMSkN
Cj4+IFRoYXQgd291bGQgYWxzbyByZW1vdmUgdGhlIG5lZWQgdG8gc3RyaXAgdGhlIHRhZyBmcm9t
IHRoZSBhZGRyZXNzLg0KPj4NCj4+IFNvbWV0aGluZyBsaWtlDQo+Pg0KPj4gICAgICBhc20gZ290
bygidGJueiAgJTAsICM1NSwgJTIgICAgIFxuIg0KPj4gICAgICAgICAgICAgICAidGJueiAgJTEs
ICM1NSwgJTIgICAgIFxuIg0KPj4gICAgICAgICAgICAgICA6OiAiciIoYWRkciksICJyIihhZGRy
ICsgc2l6ZSAtIDEpIDo6IG5vdG9rKTsNCj4+ICAgICAgcmV0dXJuIDE7DQo+PiBub3RvazoNCj4+
ICAgICAgcmV0dXJuIDA7DQo+Pg0KPj4gd2l0aCBhbiBhZGRpdGlvbmFsIHNhbml0eSBjaGVjayBv
biB0aGUgc2l6ZSB3aGljaCB0aGUgY29tcGlsZXIgY291bGQNCj4+IGVsaW1pbmF0ZSBmb3IgY29t
cGlsZS10aW1lIGNvbnN0YW50IHZhbHVlcy4NCj4gDQo+IFRoYXQgc2hvdWxkIHdvcmssIGJ1dCBJ
IGRvbid0IHNlZSBpdCBhcyBhIGNsZWFyIGVub3VnaCBhZHZhbnRhZ2UgdG8NCj4gaGF2ZSBhIGN1
c3RvbSBpbXBsZW1lbnRhdGlvbi4gRm9yIHRoZSBjb25zdGFudC1zaXplIGNhc2UsIGl0IHByb2Jh
Ymx5DQo+IGlzbid0IGJldHRlciB0aGFuIGEgY29tcGlsZXItc2NoZWR1bGVkIGNvbXBhcmlzb24g
YWdhaW5zdCBhDQo+IGNvbnN0YW50IGxpbWl0LCBidXQgaXQgZG9lcyBodXJ0IG1haW50YWluYWJp
bGl0eSB3aGVuIHRoZSBuZXh0IHBlcnNvbg0KPiB3YW50cyB0byBjaGFuZ2UgdGhlIGJlaGF2aW9y
IG9mIGFjY2Vzc19vaygpIGdsb2JhbGx5Lg0KPiANCj4gSWYgd2Ugd2FudCB0byBnZXQgaW50byBt
aWNyby1vcHRpbWl6aW5nIHVhY2Nlc3MsIEkgdGhpbmsgYSBiZXR0ZXIgdGFyZ2V0DQo+IHdvdWxk
IGJlIGEgQ09ORklHX0NDX0hBU19BU01fR09UT19PVVRQVVQgdmVyc2lvbg0KPiBvZiBfX2dldF91
c2VyKCkvX19wdXRfdXNlciBhcyB3ZSBoYXZlIG9uIHg4NiBhbmQgcG93ZXJwYy4NCj4gDQoNClRo
ZXJlIGlzIGFsc28gdGhlIHVzZXIgYmxvY2sgYWNjZXNzZXMgd2l0aCANCnVzZXJfYWNjZXNzX2Jl
Z2luKCkvdXNlcl9hY2Nlc3NfZW5kKCkgdG9nZXRoZXIgd2l0aCB1bnNhZmVfcHV0X3VzZXIoKSAN
CmFuZCB1bnNhZmVfZ2V0X3VzZXIoKSB3aGljaCBhbGxvd2VkIHVzIHRvIG9wdGltaXNlIHVzZXIg
YWNjZXNzZXMgb24gDQpwb3dlcnBjLCBlc3BlY2lhbGx5IGluIHRoZSBzaWduYWwgY29kZS4NCg0K
Q2hyaXN0b3BoZQ==
