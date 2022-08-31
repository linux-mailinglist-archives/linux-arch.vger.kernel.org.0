Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A8C5A75EB
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 07:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiHaFtI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 01:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiHaFtG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 01:49:06 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120087.outbound.protection.outlook.com [40.107.12.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB7BA9CC;
        Tue, 30 Aug 2022 22:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IV1/L830XO5BGNcNcU8ul+V5bTgaaOk2mSkXoVuhBkNBSy+e4CqWQCr/EoJZGsG6oddwQuawWbRzVNlMes/NFXFJ/YTMRGhp8a6+Rub0E0irUIwKKb+QlgKj+20mJJqQCc0Dun1mEBqMn2KWPIc0t+CZvq5jLiit4kHXzHmgwFk82asMtavXmkunQYqfh/PLZpfx8UV9pMkYJ76QQP0Tbra/es9tiFbJAiLko2t80nSxlVmm1P8rcpKEnfL9NwqVMDnaOutAj0VXrzOB3F/0rnTtvRWEEXBik2yQOChLSI6sreb1cLDPuOgxDBr7pgkAtc+qKlPDVeoqNKW3a2pNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvCi32CL3YvB/dL4LQcAisl0u7qJC6UT/FxUfL3brPY=;
 b=OHL4p7b/FCTQWm7h/jEqdCf+mRgWkVU6tyBlhu2Vp2chLusQTk1qxAeodd2HNPeC/qt35eZlIXts7Z61OwIwAejDJbovlDulOvBNjVUhG1RpRaQDoGKBx9rSfcGWJBtOXryo7ZsH+58VHxYJ1HM+4zjmMuds+ybg1J/OmJpFCrul5PdkVWj3C7lDSq4KbWh0mq3dUdr2ErxpTMpOe78Goks9Z3X5CB3rqSSQUHqXejdt0k2Z0k5qa4NbdGOij54f6OiCOesd0dO+rCMJzepvZtNbn89a6cONtLakK8mOAc6nixTNwPPS3dlZbeujSh5on1OTYzXl6c7yohQLzYdXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvCi32CL3YvB/dL4LQcAisl0u7qJC6UT/FxUfL3brPY=;
 b=loyZrau/Y/m8Dv4UlgcxQ5iXeze8Uk7zm+YcJdWZPVkefqCgovXysd3Y6z2YGYCkeukgmiq7KEPHe54MI35tOEix8gpwVnjnrul1IOP1NHZc+40VIb5/m1ULjNluIaERhVyNwAEON/O3CaDMzc+tRXrz+wt76ALkSHdnxVCj6U6RY5MSbJmw1stw/BvZIz/aGsAD/SBs4pOUwNfMFs6qWeOMolr8ruYePqWU58Tuq9UAL9L+Jjc+eoyDAeHv/TCWv/xJIqqiAAehD1zR1NBjJrnHzbjA/96T1KW/T0v9U7BB1hm0s0rCJeopFnSpAmtZ/KL5MQ8LV8INpH9TnK8B+Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2855.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 05:49:03 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 05:49:03 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
Thread-Topic: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
Thread-Index: AQHYu8Kiku3lQE6A5kqVB459VJPNJK3H48wAgACfbIA=
Date:   Wed, 31 Aug 2022 05:49:03 +0000
Message-ID: <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
In-Reply-To: <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 528f74f5-6cc4-4403-d041-08da8b148278
x-ms-traffictypediagnostic: PR0P264MB2855:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jSeJ58W24dIs9ByRRUESY2/QwWR9naebzNEkaYSHTQCNkCul3f+X7e3D/YsIYNtUJXMa7H1OwAMKY5cgSUEfukU0rkwfdT0WCs8JsM1BQHCiFelheFIiaSWOiHIr2cO8faRLI6z4gpOFh3GYywyd7OGc32q2tJ6x2gIzpj1GBRm3LcUY3IWjtiQPSWprodVsRJkBpUViH94pCrlGVIEZ+Q0xL3xt0FnqQEICryQv84H1q1R/FBWq4Jsjxp3TRV6aT8zKpUJO899rJGKCI5RTlNhQ5kByZrqJR4UDN5GT/Qofc0GeVYfZ9DRRys1J31UOfWihSTJnUzEkRBV5LlzJ8An3whbGfK7+3uggo8zIpsSrnZzGP4c5/qd1S9FO8Rww/xeuB3zbhovWiRFX4fxZNGCLGcZGlDBXM2pgtRLwCe6hQSxgV2WouwoYPcWDCQolpjhly432wDYf+OSFMV/OEkE2w0PvT3AqcOVGWQrbyYyhkfBr+igyVFTb9e1vRm0jkgAd8QMQ5otXDhBuQIQaSlYgRYE03LEmyKBQ9Cqc5nsM1owd1mk8E1sfTv67O+A3qNhKmn0+GgkRN1q8WhhnRy6UHThRKaf8oeLcZs04bj/c0DqqivK3yNS9s5wkSUEIQVVX3ovcOmhgAQXL2OC45WaoUbgb2LlI6AMfDK4LlYL4zTQvUD/njBvRVCvXjyYV5aj6Rcq8glVGWMqktuo9JevdtdybJRn8Boa4L5NiaByNPk0s9RiendEhEO1JIm5e7yeg1GH4cqa4YBuljx3gEnPIuGxwHQfojn+g3urLN4Wrt3H7VRzyz5nrbeEbPejGyt8Evz/MXrGRY0SVPSeGOi9xv8Dwv0kRYos5rJfpjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39850400004)(376002)(396003)(71200400001)(31686004)(66446008)(66476007)(66946007)(64756008)(6916009)(54906003)(316002)(66556008)(6486002)(4326008)(31696002)(8676002)(76116006)(86362001)(36756003)(8936002)(38070700005)(478600001)(5660300002)(7416002)(41300700001)(6512007)(53546011)(6506007)(122000001)(38100700002)(2616005)(2906002)(44832011)(26005)(83380400001)(186003)(66574015)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZ3OFlzMUNuS05DbWE2VXF4SnEwTUdneGZYTG5mY3M1YytyUjBhYXNJUWUy?=
 =?utf-8?B?ZTdSeFlSclAzNjlma2tXUkFqdXZoNUVSK1VrUy83bjZFOGZ0aWVPYTFXMmtw?=
 =?utf-8?B?M1ppeFZVSEdIMUdxc0NUYVZwaFdYZ2Zsc1FMSHRKOW1mZ2RhaFYwU1dlNWsy?=
 =?utf-8?B?RS96L3hjcFZIUWFacU01dEV0OXQ0M05ZVzlxVGRKSEs2TWhPQlkxUzZ1UFYr?=
 =?utf-8?B?VUxnek0rVnJ3ZVNZOVhGM2RyOEZaYnQwTGdnalVXclVlY08vVzhpSzVIcC9x?=
 =?utf-8?B?TVgwaWV4M3B2bU54N3ZkNFRacDJnTFRzKzhSTXBNZHVzRTZMU0p3WVkzSXAr?=
 =?utf-8?B?OG1pcktGaExHZTVGUHJsNFMxbFFLMkoxY3N3cDltVUtIU2VyYVhiZy9RNUlP?=
 =?utf-8?B?dEp0V3RXTmNHQTYyVFhISm9CWi9MUHBhMDlpYnVlemQ5WnlGYU8xVEtoQVZa?=
 =?utf-8?B?Q2JGWnhndnAvbERnUElIeEw5TDlmRUx4ZWx3TzQyQ09JeDVBMUNBbTBncDZu?=
 =?utf-8?B?WVlRWHM4MmhnWHA1Y0VxcFVWUks5RG9mbHFWQXpCMEVKT3VCcTRSdkptSThm?=
 =?utf-8?B?bk9EMHhPUVpJUTE5MTRBSlBwdGV4Q3NwWEROcmtGSzNlbmYzUTJ3UENBRzNM?=
 =?utf-8?B?RUpGV25pNi9VSFZsWW52UDVvUzIzbklIUjR2RFIvV2tSM243MXhlUmZaa2hH?=
 =?utf-8?B?QW1SUWJDZW1nNkQ5T1lZMHJHUThFUmJzMTBlZXZWSVlia2ZacEttTi9rS0t2?=
 =?utf-8?B?bVA4TitYSitwSHNnUVhhMGlMTVZRV3Nwc0FNRGRiQTU5MUNMeCs4QlNnUkRq?=
 =?utf-8?B?OTY4dHlDY0EvUkZ4a1JFUHBMNXBLV05kQ0lreC9EdDRPWkJTVnN5ZjBMSFZV?=
 =?utf-8?B?QjUxOTBBNFZTSDdFQVVQWForTUM0RFBIMUZ2eXNOU1djN2xhZ2RrNkNWVHVO?=
 =?utf-8?B?dXJrSnVGWThNZXZ5ZnZwekpzL3NlNVJuMG44Q1ovN3RxSGdUaEZMV25FMFAz?=
 =?utf-8?B?RHdvMkcvSjFSc0dsS0RyUnAwalY0OE5XTHVSdFpjWlNORjJKZFpOc3lzNTlt?=
 =?utf-8?B?N3g2MysyUG01TUFSaExBaFNYUE1mdkp0aGZFSHd6QlhiZFFGNDJTM2V1eDAr?=
 =?utf-8?B?aVJoNm9rYlc5SUVPYjlGcUpybGNzc2Vwa241OWdTeStwQzhCdkFhU0tteko4?=
 =?utf-8?B?dGxNWm1XQ290L1hEc01PV3pEVlR1UWtBVjVnRTd3cVBPZ3RUdHE2aFJoeHM4?=
 =?utf-8?B?NXJsREptTFkzNFdSZkVXUHFqd0pvaUlVL0FTajd1WnIwcUU5c2RHMkVHdThE?=
 =?utf-8?B?Z0grTzN4Y3Q4cEEzcW84QVIxTjl3M1NTSjdJUmliVVhBUG8vRFVORmppVGhz?=
 =?utf-8?B?TURWeHdld3RMRGVpTWVVVnZiUnJDeHdVRElkTmxGbUZHdjRrQVRCNXJEZUxG?=
 =?utf-8?B?Ykg5bk9rY24zeHphM2UrV3gwTjFJeWh3NG12NnlCY3ZnalNFQ01zK3hkQTNu?=
 =?utf-8?B?OXVWa0lnMG5ab2Z6RTUzNXBKaXlpN2JMUFhVWEQ5N0dha0IxQVY4UkFUaUYv?=
 =?utf-8?B?VjdsYW1WaG50dGVRTFVJMmJjaEh1SDk3UGtEeE9HNnhLS3FnaFRZZUpPd2M3?=
 =?utf-8?B?UWRoVXdOaEErN2htUzYweHhBMDQ5VXcyS09RTG5saktpbk9JT0twenl6U3RZ?=
 =?utf-8?B?VkRNQUNwaWozUFJMRGh4RjNJNGpENEVDVUFHMUFPU2l5ZDZGTDNtNDVhQkNN?=
 =?utf-8?B?d1lhaEFjYTdsQWkwTHgxY3M5Y1lnd05OdkhJR1hSYktXRDZjMzZoWWt3RjBv?=
 =?utf-8?B?alVlejNIYW00N3M2YVA3NHBvL2ExS29jZVF6ZGdoQXBoT0M5V0UwSGVtT1NT?=
 =?utf-8?B?TGV5bEdmNlBKMnA4N0NYT0JxQ0RXM3AxK3hwd0kzUmpsMUhkbEdPTlZxblJ2?=
 =?utf-8?B?eE80NnYyRWIwVlZOZGNWQWJ4VUJrbWdnb0YrSWJRSGEwakJJZWlaNlRyNzF5?=
 =?utf-8?B?ZFdqTFhEcmZqUHkrSzNORFNYMkxYNGtESUpuRk5hdEVxTWJ1WmRBVmJxRTlr?=
 =?utf-8?B?eXJTKzhNOURmbUF2RW5rUURES0tEanZrdHRUUG11aDc3aTg1dFFJY2sxbk9u?=
 =?utf-8?B?UzEwNERMTVNZVGg2NkJNSjYyTUJBMGowWkl3VUNmV3pGeVp3THZkdVBNS0cz?=
 =?utf-8?Q?n+4yJSSz4Tfef+J5n0/KCO8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A68A8AF84F769944BB50A137B17AFE67@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 528f74f5-6cc4-4403-d041-08da8b148278
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 05:49:03.0596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGhYp9H5K3xKu5Fo+FfwWATYusfW0PaE6aT14M/1s5HCW5nyHs938yYOcN8QyrFFRMPV+7iQhTm9kjIgiKTBK5eM4p6RKEFyM266QrfaPgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2855
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDMwLzA4LzIwMjIgw6AgMjI6MTgsIEFuZHkgU2hldmNoZW5rbyBhIMOpY3JpdMKgOg0K
PiBPbiBNb24sIEF1ZyAyOSwgMjAyMiBhdCA3OjE5IFBNIENocmlzdG9waGUgTGVyb3kNCj4gPGNo
cmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6DQo+Pg0KPj4gU2luY2UgY29tbWl0IDE0
ZTg1YzBlNjlkNSAoImdwaW86IHJlbW92ZSBncGlvX2Rlc2NzIGdsb2JhbCBhcnJheSIpDQo+PiB0
aGVyZSBpcyBubyBsaW1pdGF0aW9uIG9uIHRoZSBudW1iZXIgb2YgR1BJT3MgdGhhdCBjYW4gYmUg
YWxsb2NhdGVkDQo+PiBpbiB0aGUgc3lzdGVtIHNpbmNlIHRoZSBhbGxvY2F0aW9uIGlzIGZ1bGx5
IGR5bmFtaWMuDQo+Pg0KPj4gQVJDSF9OUl9HUElPUyBpcyB0b2RheSBvbmx5IHVzZWQgaW4gb3Jk
ZXIgdG8gcHJvdmlkZSBkb3dud2FyZHMNCj4+IGdwaW9iYXNlIGFsbG9jYXRpb24gZnJvbSB0aGF0
IHZhbHVlLCB3aGlsZSBzdGF0aWMgYWxsb2NhdGlvbiBpcw0KPj4gcGVyZm9ybWVkIHVwd2FyZHMg
ZnJvbSAwLiBIb3dldmVyIHRoYXQgaGFzIHRoZSBkaXNhZHZhbnRhZ2Ugb2YNCj4+IGxpbWl0aW5n
IHRoZSBudW1iZXIgb2YgR1BJT3MgdGhhdCBjYW4gYmUgcmVnaXN0ZXJlZCBpbiB0aGUgc3lzdGVt
Lg0KPj4NCj4+IFRvIG92ZXJjb21lIHRoaXMgbGltaXRhdGlvbiB3aXRob3V0IHJlcXVpcmluZyBl
YWNoIGFuZCBldmVyeQ0KPj4gcGxhdGZvcm0gdG8gcHJvdmlkZSBpdHMgJ2Jlc3QtZ3Vlc3MnIG1h
eGltdW0gbnVtYmVyLCByZXdvcmsgdGhlDQo+PiBhbGxvY2F0aW9uIHRvIGFsbG9jYXRlIHVwd2Fy
ZHMsIGFsbG93aW5nIGFwcHJveCAyIG1pbGxpb25zIG9mDQo+PiBHUElPcy4NCj4+DQo+PiBJbiBv
cmRlciB0byBzdGlsbCBhbGxvdyBzdGF0aWMgYWxsb2NhdGlvbiBmb3IgbGVnYWN5IGRyaXZlcnMs
IGRlZmluZQ0KPj4gR1BJT19EWU5BTUlDX0JBU0Ugd2l0aCB0aGUgdmFsdWUgMjU2IGFzIHRoZSBz
dGFydCBmb3IgZHluYW1pYw0KPj4gYWxsb2NhdGlvbi4NCj4gDQo+IE5vdCBzdXJlIGFib3V0IDI1
NiwgYnV0IEkgdW5kZXJzdGFuZCB0aGF0IHRoaXMgY2FuIG9ubHkgYmUgdGhlIGJlc3QgZ3Vlc3Mu
DQo+IA0KDQpXZWxsLCBpdCdzIGFscmVhZHkganVzdCBhIHByZWNhdXRpb24uIExpbnVzIFcncyBl
eHBlY3RhdGlvbiBpcyB0aGF0IA0Kc3RhdGljIG9uZXMgYXJlIGFsbG9jYXRlZCBhdCBmaXJzdCwg
dGhleSBzaG91bGQgYWxyZWFkeSBiZSBhbGxvY2F0ZWQgDQp3aGVuIHdlIHN0YXJ0IGRvaW5nIGR5
bmFtaWMgYWxsb2NhdGlvbnMgc28gaGUgd2FzIGV2ZW4gdGhpbmtpbmcgdGhhdCB3ZSANCmNvdWxk
IGhhdmUgc3RhcnRlZCBhdCAwIGFscmVhZHkuDQoNCkJ1dCBJIGNhbiBzdGFydCBoaWdoZXIgaWYg
eW91IHRoaW5rIGl0IGlzIHNhZmVyLCBtYXliZSBhdCA1MTIgd2hpY2ggaXMgDQp0aGUgZGVmYXVs
dCBBUkNIX05SX0dQSU9TIHRvZGF5Lg==
