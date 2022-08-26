Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADEB5A2A7B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 17:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243915AbiHZPIj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 11:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243353AbiHZPIV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 11:08:21 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120089.outbound.protection.outlook.com [40.107.12.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E54DB7F4;
        Fri, 26 Aug 2022 08:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKxtvItl9U10bherwlHfsl0bCvceECcNRM1gIdHH6zCUHhz6jesJaihhWlTniC0ycWuLluo7xfJoybNDIGnbsEgSF0Q9EGbYw6pqS6HBA4iMANYWDRmlkbyVkG8wXXA7qySVGkh636IXcZTPWmNArZrWdIv6w5m1Sn0jBXCtGXFBVn8sUfMyyG0Jc1STR+Nx9mQSCnd5pxofdjCDUwjVRnGLnWvjwaoFWjnGDxWvZ9HIblkl7XJluR5/pyObR+wwa2UgKxuPV5F2eDS5TqgX/HnNhfjJgSmArzo8LmA1ouYPYMfGYztgePKIedLRRSY8tDO0Nqr6rO6946rQLh9XIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhtUzkcnb+87DB9I1tjQ1oZcs4B6d1lV757Ixku0Zbs=;
 b=Es/Xr1TgZEfesSyPyjx1g2MyjkTQ3L4EF7cEBnRv3oMn2SQCl9Ih8mFpXijMP7HFkB9H729G3HW9je2TpRwODmDk3G18kk6IF12tH+gTedj0X+cNHNY2uMd5Upy6DohKF5H5MGi7bLd77jn46dVvuyOM/1T+RVjNgJEYZq+3njUGaS+dzSbOof7kKSobnZbDnF4QQIU0zak//6Sw+6y1awhZTvUdzfGxZSMqPaYr2k/4xJrQuNoRH9J7AFq9w2u4R/rRDVmFAKicHFpN0nxTfB+sVlxIXQBfK17/Yw8Vtzcz2ugl+BOY1Tw8NDsFgt6vhcqekTJMU9RChTbNF6oIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhtUzkcnb+87DB9I1tjQ1oZcs4B6d1lV757Ixku0Zbs=;
 b=lxWzZLKlCH7Xa+ipmKuMMkarSQYovTiqr8z7RoRMX4IS7GJcJUPqNANmy1/jdH2WjjKPxO3NCIrVf2XfQCRnVEO5k91rCULjhT3z8BwKok38kIYAXCallBDa9FahUgTbHUzIUXzDncj4MW38XFc/v1W/4Z/ts7IqEGFg/2u82rx6uWTYLBjzXwGxCT6T4osGfQAXc6wjQxcCL9MnJDUqJfswyHsSllVl8ajI2bYoloWNRKWMDNdokl3EA7rP93PbUcoONuFGF6uVicyBMvirtg84Apn6llxsbkmRdf/bhZRgC6rPt6+K9UabC5z21IdI2pRDC8+eX6UWioSJNpvAAw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3016.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 15:08:17 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 15:08:16 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Alexandre Courbot <gnurou@gmail.com>,
        Alexandre Courbot <acourbot@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Topic: [PATCH] gpio: Allow user to customise maximum number of GPIOs
Thread-Index: AQHYq9yc0+2EsNg9hki12SrFrcAXy620c0uAgAAEKoCAABfpAIAABZOAgAAOlYCAAAXLgIALDnQAgAAGlgCAAY9WgIAAFeqA
Date:   Fri, 26 Aug 2022 15:08:16 +0000
Message-ID: <f76dbc49-526f-6dc7-2ef1-558baea5848b@csgroup.eu>
References: <f31b818cf8d682de61c74b133beffcc8a8202478.1660041358.git.christophe.leroy@csgroup.eu>
 <CACRpkdY53c0qXx24Am1TMivXr-MV+fQ8B0CDjtGi6=+2tn4-7A@mail.gmail.com>
 <CAK8P3a1Vh1Uehuin-u5QrTO5qh+t0aK_hA-QZwqc00Db_+MKcw@mail.gmail.com>
 <CACRpkdbhbwBe=jU5prifXCYUXPqULhst0se3ZRH+sWOh9XeoLQ@mail.gmail.com>
 <CAK8P3a0j-54_OkXC7x3NSNaHhwJ+9umNgbpsrPxUB4dwewK63A@mail.gmail.com>
 <CACRpkda0+iy8H0YmyowSDn8RbYgnVbC1k+o5F67inXg4Qb934Q@mail.gmail.com>
 <CAK8P3a0uuJ_z8wmNmQTW_qPNqzz7XoxZdHgqbzmK+ydtjraeHg@mail.gmail.com>
 <CACRpkdb5ow4hD3td6agCuKWvuxptm5AV4rsCrcxNStNdXnBzrA@mail.gmail.com>
 <87f2ff4c-3426-201c-df86-2d06d3587a20@csgroup.eu>
 <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
In-Reply-To: <CACRpkdYizQhiJXzXNHg7TXUVHzhkwXHFN5+e58kH4udGm1ziEA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7c25afb-35d0-4d6a-c1b9-08da8774ce10
x-ms-traffictypediagnostic: PR0P264MB3016:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Fp2CV4/UGJP4XTtc/RCrRP6h47vAQ+Su+MWqQQJ5A2dv+ZKq5dkuCP+mNT1tPHqEWAnPbcISQcYlF5wBJhWMD+GzwrRxM4fLfxXQQjGQWjvez43LSMXdI0b37AJFvHs8XZeJiNKG+wioaUpzBg8b0b/vzyLEcP9+Prd0xm++0lwTuzflrIdJRymWk0PuSUIuvLQfJb33sSYEuT32qHkVuWX2N+aE2HuvhNwAddptaFIeRlBFb6dfg+nSPo54MFVRT6UYkpzKnQl1/jJ0R2YQjXE9xbhiIXcFwt4wfBjeFCXO2dLcte9rIHMoYgBIj7v07mWUFApfvY3mzsz9ASpM1zzTNcErK90KHoL0Jes2bIo2ePM10tJNxlUYzT01vkqsfp48NUtENNkRH1Iz9V8jSoQH5CClx0czJJxBj+B3gxtk7w9YP0s8HvR2JoEbF+hHW1gVOCVD87IP8s5Y5UhbYkByLODC28WrM1JHLK8BDtCdu7JOy/EpQseg5/SBt3W1I+vK18Taz8cNqfE8LnUT4sZs+HFPm+Uo7Qm3PeIWK0Ub9OPgeGsyKFrDhO7N400rtJCf8q46R8YI/pJcNvO2Zuxc0lkU2W9RyIRyJyzDymt22E2KwD3dx+kCz9wK85St3rqtIdDs6zLopMwhvEiWpEZSqM+9sJaxZE4vUPhGHT2GaKq7jBn42plBFRE3Zp6ixWuNCIPK3xrXt3HUD2giqdKOm+8ftwFIpIt5kt14R1rcbHO9Nj9rK5Tdczqhhgf4gFL8FTdyQMx7qVQFi7Jj0ZfFdDf0fbjXIPO4/Q9hctO2iD6boB5iIvJIc6o+jkCsJmWxNHvubvEnrGsnRc1tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(39850400004)(366004)(346002)(186003)(2616005)(7416002)(5660300002)(8936002)(2906002)(44832011)(4744005)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(41300700001)(36756003)(31686004)(6512007)(478600001)(53546011)(26005)(6506007)(6486002)(71200400001)(122000001)(38070700005)(31696002)(86362001)(91956017)(316002)(76116006)(6916009)(54906003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDZvZ2hKRUpKWjJRS0x2UHRLWUNBV3lUQUVqV2poYUMvS3ZVRFhLcHZzOWZO?=
 =?utf-8?B?bzNtNlcrQ0YzSjg2YTFDT0VjWTY1YmRjZ1BJdHBOa0V6OXE2eEd0b1lyNFRU?=
 =?utf-8?B?ZFdaaXFtOE5PS0FxTEVhd1JycXVza0lIclJDREl2dHVKL01lL3lUR1k5RCs1?=
 =?utf-8?B?Y1Nsc0lOTTVZZlM0ZVlLZTVnMlh0Q3ZKTzdsN2lLOWNIRG1nSWJuRW4zcy83?=
 =?utf-8?B?V2tWR1QvcExyTG5qak9renk4V3B1UE85VEg2VCthZytxTm56Qm5mYzk5S0Rs?=
 =?utf-8?B?Q3c2dk84enBNYnpuc0kxelVFMGZiTWF4NUVzVjNwMTA1NTdXL2hpNlBXS0or?=
 =?utf-8?B?ZFlkcTIzRERhNWtUOFRjL0J1VWRkOGdSaitCNUNZK29KbFdPUkNWVVU2eVBM?=
 =?utf-8?B?QlgrOXQ2ejRoUURvRXoxZFhkQjBURTVLOE9POU9XSXVkN2J3NWxIM1pOWTdW?=
 =?utf-8?B?ZzJVNzdxWDJYbGVXRjU5WXRDYWlJOVZlZFVQVlFlQTlOL21QSU11Z1NKZjFu?=
 =?utf-8?B?TjZZNmVna1ZzZGlmQm9Xcm5qWGN4QUlSVXlKU2U2ZGdENkVHclRNRVdmcGF1?=
 =?utf-8?B?QUxuNFc0V2FTdk5sNEU1TjdhYk9RMW9WZ2RyU2RmT3BtVERKRkZsek5BZmVp?=
 =?utf-8?B?d2s0RUczYitTSDQ0ZG0wTStLVmp2MFNyc3ZseGVlL3hiaHNqWkIzL3hZUFlY?=
 =?utf-8?B?ZFVVclN3cGFxQ3VuMGN3R3VxeUFHa2c3V2R4c2lYSENGWXhhRXZ1MGQxVWt0?=
 =?utf-8?B?VEw4L2lpbmdUUDAxUFZGTDNxVUw4Sk5YZmNhZzBpbE9rUWYzR28za2dHTjVZ?=
 =?utf-8?B?cU5MT1Jvb3YraU14dFJoazVBWGJ2RjhRQVd0cTlWY1BPcFg5V1ZHMEVJYjQ2?=
 =?utf-8?B?MHdMYmxjbzcxVXZpRytidlh1RGMzaWdTMzNuUTdNOVVhTHZpTE94TzZZa3Ju?=
 =?utf-8?B?VjdsRXFPYThMYitqY1FKMHZTaVY5cDVxT1J4dmJsRHRmUVVZVDV2QzFSZXVP?=
 =?utf-8?B?NkhsTmRuRWFWM2V5UlNnemxpbVc5OGtaaTNVMTgwQTNEUGpuY3RQZkxsU21Z?=
 =?utf-8?B?SjQrVEJpWW1YYmRTWVNOUFNyN1hsQUt6Nmx3eXFlbktsNEFCQWRmdDZXSjJB?=
 =?utf-8?B?azNZeUZOUjFwT3RqbGpnQkVlRFpabEkyNjVZVGxLQTQ1ckhMYlAzZ3JLWW1J?=
 =?utf-8?B?SGlHeiswMGk2aVFTV0xoWEh6alJQWVhPWG8rd2kvVlFhRG15ZEJtN29uZUxL?=
 =?utf-8?B?KzJ5MW1tbGtUVEl4Vjg5TTlWQXcyQ0hHeU9GcURkSzBMcjJxK2h5WVorVnds?=
 =?utf-8?B?YnUyZm9yZ1VBUkR2aUVtYnYzSUNwSyswd1VIc21SQU1HaHNHZFUwZXBCajlp?=
 =?utf-8?B?SWN6RTluTGNhMnQ4OEhMaHNVYnNyZGlVUTJvYnE0VmRkaExBaXIwZXhJS1hs?=
 =?utf-8?B?eHFjUWlSZWZHWGxCS0NFSkJLSlNnanVLUFgwZDZkS1lUd2M5OUQ0YzFRclND?=
 =?utf-8?B?VDdOK0V1Y0x6eGUwMVY4QnVSbWVSVTUycU5wNjJnOEtDTkkrZ3dDb1l2V2NQ?=
 =?utf-8?B?Y2tVWjJpNFRJYk80N3NMR29XOHJDNm1zZUI1QVM0YVBLUzcxdGNIeTNveC9i?=
 =?utf-8?B?blcwN0ZzZXFxWndzZFh3bStZUDZmSTF0cENkWDMyOUZEa1A5dVFEZWM0ZmZC?=
 =?utf-8?B?cDl5K1VESTllL3dVc09iSE01NW94U3lDVklJbFI4K0xOOEZKRXBXbzdTRFFt?=
 =?utf-8?B?NWh4YVB3MHlWRkc1QXBVb1dzcUJyV2VWQ3VjdmRpdlNldUQwUWRBR3FXNDZ1?=
 =?utf-8?B?Z0FzU3YrMHhpQnB5cktiOGN4KzVrdmhQOWxHV0JQdE1vaEMyTnl0ajQ0ckVp?=
 =?utf-8?B?aGNEclp1cFk3eUw5UGZ6b1dmNHRnUVpEUks5SW5KK0VwMjYrVko2TzQzSXJ4?=
 =?utf-8?B?eUlhSG92YWM5Z0RzemlHWDdPS3Z3STlZMFRML0xzMk1Ddmh3R0N1M0NmNG5K?=
 =?utf-8?B?NXJTSWVlYUk5UXpLcjJlOGhkTDhoVjNoNVlBNlBMYzZSUVh3UmFTQXR4SXRP?=
 =?utf-8?B?SHF3enBNYUg3SmUxTXJQaTl2dDhBSE05ZlVSb1o4YjlzUmtSZm1ZNks1SmY1?=
 =?utf-8?B?aGMraUpjYXVPZ08vK0pVdEQvaWNZVlMxU1ROM1J6bmFoVHNkWHRWdDNkdFVI?=
 =?utf-8?Q?2jlpI0oL2b2ValhFM/oX3Gk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C29556D20961184BBEB247A052763A9D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c25afb-35d0-4d6a-c1b9-08da8774ce10
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 15:08:16.9351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sBJqC7xIwZDUl1twADtfGz0+EM52cIsuPp6n8wVdFgbHXcdyzjNQAE5sEj/AhZeQsD+oVWG5cosTkZlwSVFkoTbF5P6WdQ2eHEyrTfqaGQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3016
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDI2LzA4LzIwMjIgw6AgMTU6NDksIExpbnVzIFdhbGxlaWogYSDDqWNyaXTCoDoNCj4g
T24gVGh1LCBBdWcgMjUsIDIwMjIgYXQgNDowMCBQTSBDaHJpc3RvcGhlIExlcm95DQo+IDxjaHJp
c3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPiANCj4+PiBDaHJpc3RvcGhlPyBXaWxs
IHlvdSB0YWtlIGEgc3RhYiBhdCBpdD8NCj4+DQo+PiBXaGljaCBwYXRjaCBzaG91bGQgSSB3cml0
ZSA/DQo+IA0KPiBPbmUgdGhhdCByZW1vdmVzIENPTkZJR19BUkNIX0hBU19OUl9HUElPIGVudGly
ZWx5LCB0aGVuDQo+IGFsbG9jYXRlIGJhc2VzIGZvciBuZXcgR1BJTyBjaGlwcyBmcm9tIDAgYW5k
IHVwd2FyZCBpbnN0ZWFkLg0KPiBBbmQgdGhlbiBzZWUgd2hhdCBoYXBwZW5zLg0KPiANCg0KT2ss
IEkgY2FuIGdpdmUgaXQgYSB0cnkuDQoNCkJ1dCB3aGF0IGRvIEkgZG8gd2l0aDoNCg0KZHJpdmVy
cy9ncGlvL2dwaW8tYWdncmVnYXRvci5jOgliaXRtYXAgPSBiaXRtYXBfYWxsb2MoQVJDSF9OUl9H
UElPUywgDQpHRlBfS0VSTkVMKTsNCg0KQ2hyaXN0b3BoZQ==
