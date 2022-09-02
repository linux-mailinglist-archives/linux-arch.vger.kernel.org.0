Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7110F5AB555
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 17:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbiIBPgT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 11:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiIBPfo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 11:35:44 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90070.outbound.protection.outlook.com [40.107.9.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7862191;
        Fri,  2 Sep 2022 08:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7WCa0VUnV3giQTsCR/iyh5othPeGYLFViePGLB20vpGL+5wKudtUADglEIm6GoIpxnGg9XyybRKc+8yLDdqN7zttJmuBIoBVahVRegpa8sgd6mmi1WyEF6lUcr5B57dXWM1DFK62kV2RJeYnYGV1cXiVYgtGTRrgyNjNnNCD3bIXDFS7BxtXwNQKWfBM+HRnGz6whA9ozJ0xomKcDW+w95TPdO35ZIqaJfWBFuzkWqOLE8nyez4nQYSmi7p17bEa2WiWfj1lMzfQ3Ill6TM5NQmADX9zjnac/JzXyWpNgJCnRXVQYp16WRsBnYcZ2O9H9NcDOH6vg9tVfR+nqhTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb5MMmLVuJB6nwAxSyt2ImUV36/E6Ixrp0KzWRY0bds=;
 b=bAbNb3mKkmBgMQ64AE4MyU6snsJZnW8MmqHoEysNfC8GKV16//gMAQunM/BWVftq9XMHa0b6x0cBnQTJ5clEuldO6brZMM8zF6VuTsR8cAcIO3IW9Hd9OC1pjidoBb5ozXHEGddD9fJnXipyV3eWr56dvA09Q+3wrUYC9wCHOE3rvPUuE56Y3lEnNLUUprIaE19XKAuuISxG0xQdLZcenj56MRC47LXZ+wBydjCb3OFmxYd2nzYDcnmcjY7rj+VfaQOH1KJydq9PEX1slzKS/+fIJypHPc2bsiTdBwLxHdGjiTmiM4sn8Y6e2B5TPwaydUfwLYNSE81wgznisf6XJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb5MMmLVuJB6nwAxSyt2ImUV36/E6Ixrp0KzWRY0bds=;
 b=tLpPWBi2c36zqZPADPGZU+LP7sqQP+BI89sVgK5Nj/cS3O15bylUb+HND3sPispYkKu3xtAOxdBSlBNlbmmxSq3TZjnskKwZLHxRGaiLWpj+YMdIyFs6d7llNV9FBzUPIgwazRt/BFv6trTcbqGya9kfxeTupsUcRdCvDempW8TD8ydeC59d+DZy5GP6NayQuR48nsfKzajR9cbsVYRLboUGjOC3bkHOJ9yN8EnZYoBNhWQsaJ6NukvEx3wMrO1/YHn0u2KkNJrGOFN//uGnG0ShaJ8/bMyqRhXqjOJgM7h7Pwu4/cz7OccnNaufAXjQx2wRqv8mMsHC+o87KKXeyA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3406.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 2 Sep
 2022 15:22:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 15:22:20 +0000
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
        Davide Ciminaghi <ciminaghi@gnudd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v2 5/9] gpiolib: Get rid of ARCH_NR_GPIOS
Thread-Topic: [PATCH v2 5/9] gpiolib: Get rid of ARCH_NR_GPIOS
Thread-Index: AQHYvsmEfS3tQkOA1Uengw0AnlxVLa3MOzeAgAAGyoA=
Date:   Fri, 2 Sep 2022 15:22:20 +0000
Message-ID: <63b3c26a-be33-6ef3-7feb-ff7997fbc752@csgroup.eu>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <97011204619556ecb3d8c9aaff2b58c28790fe8a.1662116601.git.christophe.leroy@csgroup.eu>
 <CAHp75Ve6zMC9s=TZT_pWoyxnKtXE0xipFCv_RDY4r4amnVbVxQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve6zMC9s=TZT_pWoyxnKtXE0xipFCv_RDY4r4amnVbVxQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c586c10c-7429-441f-ca8f-08da8cf6ede6
x-ms-traffictypediagnostic: PR1P264MB3406:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnaH/LViDbXu69+L63d2C4x66HtlJBmvMgesikmSctUcF6/AKPg/ztAMCIkL8YkgW4aAAQ9NtY8Xgfy1/g5bm2vP7BBL284Tk4AkNJ39h24VZauErb1FkavJ0zNxucC58S3QqroRdfpJKyAufubM4EvCqWAU6+Qo91iN2CMtGm+4NFYKMGrfUi9+PJfvjyTSZFS/MLBXHzZn9kuD8MEqYZd6H/xrIUH6H/Ghrl7Pi7dYtvBpYFuTZ5RSZW762uVzG5bzXv068xE3UHqEySSir26rFsMLnYq7XKpBzkeYDho3DeNcyPsoyBwTYAH2UX1Z0hk8qK2a++zr+Na9bLMTOu03WusbR1oMzcHIg+rojLSJsrupeYtZs42tYSM1xG+xpyv7PPtXftXzgalt21l1EhfzVpMxvIOb2cDdL4de3f91qa8MCaq103w8BoV6CIXbg1Pke928EC0WuoH5fAUZqIxk2UTpoDaax11BCGQkUOCunQ6cbo1ifT/IX8xIgMiKK4MdCuy7GJ7nNFHCL+HdqyvIAAEv0NiGl7FiSFFuVJoLEPQKnkNEv6/0CdrtPjVE/Xk6v5SnH74DGe/JGOKR3n62HU0iU4LxWJqffK5e7EPG7B8hROPV6blnJ1iWA3LSWf60fgPAuy5EuvQ5JNM7hbgY+kBYzoggcte/jTP5ilTkDOe8pvbQoRXwgL364BQpzzcrzwTL4miylrhs3rIqtlZX3h9/T4sRDSv7CaaobT4YQLUCb8VStN0KgMup8QIHc0XZXdHZDfBZojKOKqe00lpbezP+qqs1Rokt5WQiutRIOa8RAXEts3mEMNlGXnECUaJGDVRInJPQ6QP6csRUw8eWsH70Z3Il3ul1RQ1V7OU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39850400004)(366004)(396003)(41300700001)(6486002)(6506007)(86362001)(6916009)(54906003)(71200400001)(478600001)(316002)(83380400001)(53546011)(31696002)(122000001)(38100700002)(38070700005)(26005)(6512007)(66574015)(186003)(2616005)(8936002)(7416002)(36756003)(2906002)(5660300002)(4326008)(76116006)(66476007)(91956017)(64756008)(66946007)(8676002)(44832011)(31686004)(66556008)(66446008)(26583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzVXcC91bmRIamNNT09oRTFvVVBheUY2OW1vcEZtUVJ6OFFQaHkwMzVLZ1E0?=
 =?utf-8?B?TnVuSG9IU3Q4ZDRjV0kwWFAvd0xaeVdhdzh6TWZ5REZhSWpkaHBaaTdXbm9Q?=
 =?utf-8?B?cnR4cHNRUlJwbnJqalIzRFRqbmV4My85OVJQN09zOXVxUWZKcWdIcXUyUGxa?=
 =?utf-8?B?TXZDR0VMQXVsTHBlajdUaTFRWnRvaVdFYXJaR2R1NnY0eGY5NmRQbk9FU0RQ?=
 =?utf-8?B?c1JlSHZnc2pSLzhObk5MOXREU2xUL0dncnZoZDdaLzVucWo2YmxBdy9oWmdS?=
 =?utf-8?B?TDlYWnN6cVFZL0h1UTJHUUdkUXJpTmxRM0JLK0pVYm5vMDhNalZrZXp3K2sy?=
 =?utf-8?B?Z2VmbDVnUHRhV1VrTG13R0ZPL3RiOTBFaXlWQmx4V25yMXVnREZMVTliQUVa?=
 =?utf-8?B?RHBYNGQxK3JsdVFpaWdZN2prQWthd2lkdVI2aTA5ZUtweFBkQlZZZmZDUjVt?=
 =?utf-8?B?UjQ1cXc2aE5TM3VEV21BNEY3OGZTSVAxdjRUOHZCREhaU204VTQ4d0FISi9l?=
 =?utf-8?B?bFRYTGlIR1Y4amF5UDY3VFR5bTBGQ2t3cmFvNk4xcEZVNkNqRnBLcTdEaUo5?=
 =?utf-8?B?dW9XUVhOVkVvNTVPcjJDZWZ0eFlia2JhMFV3ZFVlV2h4MTFsaEx5MnlwQytj?=
 =?utf-8?B?Vk5zQWxmU1VXbEJQbktFS2xzSll5U1Y4ei9pa0FnVmxuNko5dnI4NysvV20v?=
 =?utf-8?B?WGFIUWczQ0NyREVSVk9JaFl5bFlUd3FEQTV1QmlONkgxSTVIS0xXTVowY1I1?=
 =?utf-8?B?MVFRNDd3dkdJcnl4OEVOTjJHTHBRWWtLK3Z0bzQvd2NaU0h5eGx0ancxVUEv?=
 =?utf-8?B?QlREUFQ3ODV6QktjOTh0TEs3V1lzNVU4NkdXMi9KNGNmMGc5TmtxWURoS0FO?=
 =?utf-8?B?aWhNejdOU0I0ZFA1Yy9YUnFZcmJJT01zNThob0Z2djJQaVllMmN4ZUNKMDVp?=
 =?utf-8?B?MFdDMDlsajZqbnlpVVZCbnZTRE1ONzA2L3lOd05xcWh4QlRpN2FHOTlGcGNq?=
 =?utf-8?B?eUg3T1BYNWFZcEhUZFlTV0I5R3JEdUExaUttL1A5Q0RnQkxvQnZiM3d0eFh2?=
 =?utf-8?B?bWsvM2xWZXlUTWdmVEVTTTFrUjBzM3lPSVRNbjIyQWVmV1RxaUs1WXVZSTNu?=
 =?utf-8?B?NkpHMGxvbXp6WFM3L1Y1UXVQWm5EME02Y3NSNzY5dkR0dFR5RGZXZHhQbGNX?=
 =?utf-8?B?bWdvSVR3Qk40Nm5JVnJQbExFbURkY0hEczhaVlpoeEtpOHUvK0syY2poN1JN?=
 =?utf-8?B?SDVnd3hjcWdkL2pvZWlIWm5qRmhCOTErNFVSVGZDSDRDa2Jxd1ljSk1kZ0tn?=
 =?utf-8?B?ejNMN3kyRzhvUGY3ODRKbDltRUVpbmYramJSQkhFQThzLzZOd1liSmpIbXlk?=
 =?utf-8?B?cjlDQW1kU2k3SjBiWWFjbGtsVjY5V0Z5ZVVQT1lZdG43UEhsWjhtRS9nTTRi?=
 =?utf-8?B?OWI0ejMwUmVpc01vRUlXSzZjMFFJVUNvbjRCb2NFU1dWNXRod3h3S3dkMEJa?=
 =?utf-8?B?NnZVUTkrZVZKQlZkZ3Aza1lqNDRSOHJLazBKUDdXRFg3MVZXQmp2WE43Wkp0?=
 =?utf-8?B?SXpScXpObmxQUzUzeTBWV3ZNVjlScHB2YWxGM0R0SEo4WHZBK2VGUFlQUWtr?=
 =?utf-8?B?bWZHOW9wMTc0eXFscjh0Q0JJaFFuU21MNzVqUmJ4OFNQa1RHMUdHdEFxdEd4?=
 =?utf-8?B?MCs0UnJkMDk4V1RrT2psYjUvNEpiSVZYZkN1M1NzM1ZLQ2RYL3dQNjBYVzVs?=
 =?utf-8?B?K0R4Q0tvUzFEQnB5MTZBU1J0R0x2bDhXSzM0VEY2djcvSHFvSG9DRlJIUDJj?=
 =?utf-8?B?a2dyZXFMcU1WZEhtREQ1eHcxcnMxWXJEYk81a3g0RWlTZkhpdTFVUHJwZTVw?=
 =?utf-8?B?cXFOSFRsQzl1YjdyMldHbytBZWl4bUdkbFRnWTByK1VMWm1VVHVsQ1FCdHdE?=
 =?utf-8?B?MTVYQkR6WGRHbHBpMEQ2MjRsTk9rdVdnVHRXRGxub3hPU1Jia1p6bVBLNGQ3?=
 =?utf-8?B?anpjSm1iQ3lhMVhDSlo2cjRaVHJsaTRTdnVOV1dteGVvMUMrdkYrelFraEF6?=
 =?utf-8?B?WTd4VGdwK0Q0cGZLRXlMNXZ1dy9MK1NBMTNTclUxS3Zvd0ZrMjFIT01yN0o2?=
 =?utf-8?B?Z0RJTFBYbE9VbnNpaXBZazMvbGliVHNNL0VmQVNiTUEwVTNCaCtleENHWnlP?=
 =?utf-8?Q?FL1uKpfmuJJ34akf7b6XEmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDD03A698AFC6649BA481F8FC235B2C9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c586c10c-7429-441f-ca8f-08da8cf6ede6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2022 15:22:20.7359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LoXTCUfvdmpRlwppmnZOuumg3jGMO8UhVGEAyONckIL5J9yNc+eE5Y2GnGVeCrobkuWaVqKuyrvG1NtJQX5lL5mpm/UGo8oggHg8xarDzoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3406
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDAyLzA5LzIwMjIgw6AgMTY6NTgsIEFuZHkgU2hldmNoZW5rbyBhIMOpY3JpdMKgOg0K
PiBPbiBGcmksIFNlcCAyLCAyMDIyIGF0IDQ6NTcgUE0gQ2hyaXN0b3BoZSBMZXJveQ0KPiA8Y2hy
aXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToNCj4+DQo+PiBTaW5jZSBjb21taXQgMTRl
ODVjMGU2OWQ1ICgiZ3BpbzogcmVtb3ZlIGdwaW9fZGVzY3MgZ2xvYmFsIGFycmF5IikNCj4+IHRo
ZXJlIGlzIG5vIGxpbWl0YXRpb24gb24gdGhlIG51bWJlciBvZiBHUElPcyB0aGF0IGNhbiBiZSBh
bGxvY2F0ZWQNCj4+IGluIHRoZSBzeXN0ZW0gc2luY2UgdGhlIGFsbG9jYXRpb24gaXMgZnVsbHkg
ZHluYW1pYy4NCj4+DQo+PiBBUkNIX05SX0dQSU9TIGlzIHRvZGF5IG9ubHkgdXNlZCBpbiBvcmRl
ciB0byBwcm92aWRlIGRvd253YXJkcw0KPj4gZ3Bpb2Jhc2UgYWxsb2NhdGlvbiBmcm9tIHRoYXQg
dmFsdWUsIHdoaWxlIHN0YXRpYyBhbGxvY2F0aW9uIGlzDQo+PiBwZXJmb3JtZWQgdXB3YXJkcyBm
cm9tIDAuIEhvd2V2ZXIgdGhhdCBoYXMgdGhlIGRpc2FkdmFudGFnZSBvZg0KPj4gbGltaXRpbmcg
dGhlIG51bWJlciBvZiBHUElPcyB0aGF0IGNhbiBiZSByZWdpc3RlcmVkIGluIHRoZSBzeXN0ZW0u
DQo+Pg0KPj4gVG8gb3ZlcmNvbWUgdGhpcyBsaW1pdGF0aW9uIHdpdGhvdXQgcmVxdWlyaW5nIGVh
Y2ggYW5kIGV2ZXJ5DQo+PiBwbGF0Zm9ybSB0byBwcm92aWRlIGl0cyAnYmVzdC1ndWVzcycgbWF4
aW11bSBudW1iZXIsIHJld29yayB0aGUNCj4+IGFsbG9jYXRpb24gdG8gYWxsb2NhdGUgdXB3YXJk
cywgYWxsb3dpbmcgYXBwcm94IDIgbWlsbGlvbnMgb2YNCj4+IEdQSU9zLg0KPj4NCj4+IEluIG9y
ZGVyIHRvIHN0aWxsIGFsbG93IHN0YXRpYyBhbGxvY2F0aW9uIGZvciBsZWdhY3kgZHJpdmVycywg
ZGVmaW5lDQo+PiBHUElPX0RZTkFNSUNfQkFTRSB3aXRoIHRoZSB2YWx1ZSA1MTIgYXMgdGhlIHN0
YXJ0IGZvciBkeW5hbWljDQo+PiBhbGxvY2F0aW9uLiBUaGUgNTEyIHZhbHVlIGlzIGNob3NlbiBi
ZWNhdXNlIGl0IGlzIHRoZSBlbmQgb2YNCj4+IHRoZSBjdXJyZW50IGRlZmF1bHQgcmFuZ2Ugc28g
YWxsIGN1cnJlbnQgc3RhdGljIGFsbG9jYXRpb25zIGFyZQ0KPj4gZXhwZWN0ZWQgdG8gYmUgYmVs
b3cgdGhhdCB2YWx1ZS4gT2YgY291cnNlIHRoYXQncyBqdXN0IGEgcm91Z2gNCj4+IGVzdGltYXRl
IGJhc2VkIG9uIHRoZSBkZWZhdWx0IHZhbHVlLCBidXQgYXNzdW1pbmcgc3RhdGljDQo+PiBhbGxv
Y2F0aW9ucyBjb21lIGZpcnN0LCBldmVuIGlmIHRoZXJlIGFyZSBtb3JlIHN0YXRpYyBhbGxvY2F0
aW9ucw0KPj4gaXQgc2hvdWxkIGZpdCB1bmRlciB0aGUgNTEyIHZhbHVlLg0KPj4NCj4+IEluIHRo
ZSBmdXR1cmUsIGl0IGlzIGV4cGVjdGVkIHRoYXQgYWxsIHN0YXRpYyBhbGxvY2F0aW9ucyBnbyBh
d2F5DQo+PiBhbmQgdGhlbiBkeW5hbWljIGFsbG9jYXRpb24gd2lsbCBiZSBwYXRjaGVkIHRvIHN0
YXJ0IGF0IDAuDQo+IA0KPiBFdmVudHVhbGx5IHdlIGhhdmUgdG8gZ2V0IHJpZCBvZiBncGlvX2lz
X3ZhbGlkKCkgY29tcGxldGVseS4uLg0KPiBCdXQgdGhpcyBpcyBhbm90aGVyIHN0b3J5Lg0KPiBS
ZXZpZXdlZC1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0K
DQpZZXMgdGhhdCBjb3VsZCBiZSBkb25lIGFzIGEgZm9sbG93LXVwLg0KDQpUaGVyZSBhcmUgYWJv
dXQgMzAwIGNhbGwgc2l0ZXMuDQoNClNob3VsZCBzaW1wbHkgcmVwbGFjZSBncGlvX2lzX3ZhbGlk
KGdwaW8pIGJ5IGdwaW8gPj0gMC4gQW5kIHRoZW4gdmVyaWZ5IA0KdGhhdCB0aGUgY2hlY2sgaXMg
cmVhbGx5IHJlcXVpcmVkLiBCdXQgbmVlZHMgdG8gY2hlY2sgc2lnbm5lc3Mgb2YgZ3BpbyANCmF0
IGV2ZXJ5IHBsYWNlLg0KDQpGaXJzdCBsb29rIHNlZW1zIGFscmVhZHkgcHJvbWlzc2luZzoNCg0K
DQppbnQgZ3Bpb19yZXF1ZXN0X29uZSh1bnNpZ25lZCBncGlvLCB1bnNpZ25lZCBsb25nIGZsYWdz
LCBjb25zdCBjaGFyICpsYWJlbCkNCnsNCglzdHJ1Y3QgZ3Bpb19kZXNjICpkZXNjOw0KCWludCBl
cnI7DQoNCglkZXNjID0gZ3Bpb190b19kZXNjKGdwaW8pOw0KDQoJLyogQ29tcGF0aWJpbGl0eTog
YXNzdW1lIHVuYXZhaWxhYmxlICJ2YWxpZCIgR1BJT3Mgd2lsbCBhcHBlYXIgbGF0ZXIgKi8NCglp
ZiAoIWRlc2MgJiYgZ3Bpb19pc192YWxpZChncGlvKSkNCgkJcmV0dXJuIC1FUFJPQkVfREVGRVI7
DQoNCg==
