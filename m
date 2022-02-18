Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB14BB610
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 11:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbiBRKB5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 05:01:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiBRKBz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 05:01:55 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90058.outbound.protection.outlook.com [40.107.9.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF977766A;
        Fri, 18 Feb 2022 02:01:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx8ttGtpTcWLq+bkAi6jGJ6EpNPbePEbncK77cBcDXLGMFOa4jQpO0BcadOiN6ptGeckKAbBW1MkFweKO8jG3wHH40QVHLTGKXgbe1QahRmfzDFQo8elhy+23kNKNsAP6Vm/7IBm6H+vlyluw3uHE6Z+egnlsiaPSfsjrBfOk7I/BiAVbo78iApqCym1Iq+epivtAFjlV3DNdvNnH1U9J8Ioh2jsbcad1nbw0UH9YZlAXG4t0xTtkIDUgqdSCG2raQjUU7P00UaBOG3cZVkdkgOMpB2GxDvKeazAvOTHqpguKlw4HrUZMFypi9bfviv0K9cdXKFcE5x9ZHn8A7ThiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLNY9qDCIO4RGr52QiJIclJO0ZTdmVBLN4g+EzPyQ70=;
 b=gL43lh4ybRf847m0skDCVoG2i9hCmgB2XIDFhBEK3BNTSnmMsdoC4esxYTDtWjimrInoOAkwUgs27s0FODxHcnHdaMkH8AT4/jSVGWsxvda804zAdZ/HnYyFsZf2Jes2o7WllTWlNBpysTXlC+l7CJuL3YHPELzFfEk7MBl1WUnbZxFjFUh+4lhvFtzCa1dywwk3dpDPJjzjrOLfBOETK6CCRbfkEphf8pR9gQTasLBKPPnwMzyrtszKnQ10yM75PiIoTUj9ip05JmhTe85zBQ11efCXpapt1sih6Rbzqk9O6uGC9jtxeH64hWgy4wV/ARWeOVOTeBloM4l/8ENRkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRXP264MB0774.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:17::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 10:01:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%4]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 10:01:32 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "bcain@codeaurora.org" <bcain@codeaurora.org>,
        "deller@gmx.de" <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "richard@nod.at" <richard@nod.at>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
Thread-Topic: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
Thread-Index: AQHYIzcr/0MVz4zz9E+FaRkUlMFJvKyXVyqAgAE2QACAAIkqAA==
Date:   Fri, 18 Feb 2022 10:01:32 +0000
Message-ID: <c5710bc5-0440-b828-d91e-6961081573af@csgroup.eu>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
 <Yg77bNZfNhSk0bVQ@zeniv-ca.linux.org.uk>
In-Reply-To: <Yg77bNZfNhSk0bVQ@zeniv-ca.linux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e039961-d5be-4533-85a1-08d9f2c5a449
x-ms-traffictypediagnostic: MRXP264MB0774:EE_
x-microsoft-antispam-prvs: <MRXP264MB077444B3E4FF9E9C2AB8D159ED379@MRXP264MB0774.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6znA45T6jhZDGgmS9hdOSWO+FX6qaf2PSVUEOIFKPrtFeRE+tcFQQWj3XJo4gBk4LH4wwIGbu5i5c65m+dnMUBUexr4bnRLKG0kpWFO1XC55ElXbPpKIEbZ2Z7WAINnHLjkgV0qCl+yFuOBPA4g/UE8H+mIcUTuFZGqkQIzdlW2eWu7sNT6Glo55u21Hzqp6RW4u3CQUnPSlnkfVAg5g7SO7cN9nGHDRkEr92Ill3kgcQT2+PCm1mEXUIikQXGveQMX4HhGGdMhB+xeTGHajjg2XXqksA3vZgydzo3yWVdIiGwK5+8PuZ+/6m9aKIJiTNHu/2ZXXZRnCyNYvIJEUD247RYOql1aLzlz3PgpbWriqmh25xORH8sI6V7d0Px2OwTnU6KT0VaMk3VA9GQeb1dJbK3yvwRCh9JDl6/J9u2EzEUvvUcX+X44vbt4GZjPLnptF5Dz7PhcGASHKUUEx1jE9jYi6VTX8GWix/VyDo2Sm/w41JrZWAW/Uq7BD5zNStkEEdwYwfBk1TeXjIhSHHf3MeHJ0Dza1xn3z+oM60GbnQzlabWF+ClCSeLI7GRbe4jbsYpfiY4+SCVqPllRbyy6DX4k3jSjR+M18+HRqmqO7IvmEu8pKcvkzvCUhwQ5AU0d6T3BXVGAUZVdgxPmCMg+kBJeu/jPc5qnM5hxeiLpdRb89wZyI0BTliLnz3PNXCBptU/fVEoB9BQ/NAAp1AOvFSupg2OahVahazAmWrlMiwb2ruaUIds8AMlnganKle59Lkw7nMKDrugWBMUHcpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(122000001)(508600001)(6486002)(316002)(31696002)(54906003)(110136005)(8676002)(38070700005)(4326008)(38100700002)(64756008)(66556008)(66446008)(86362001)(8936002)(66476007)(71200400001)(76116006)(66946007)(2906002)(2616005)(6512007)(66574015)(36756003)(31686004)(5660300002)(44832011)(6506007)(83380400001)(7406005)(7416002)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlhvYVdaOHZHN1pwZ2REQW0wb1RFK1hxd2VmNGxxa1czb0xpSE15VVJucC8w?=
 =?utf-8?B?TlVVci9YZXNDVDdORkMvb0hVd3pNS3A4ODFQYnBXUlhqeDYxNWt0Q0hWL1l6?=
 =?utf-8?B?eHRhRjJOeml4TEIyZnJ2blMrRTNvZmJsMEpWU25JZHlBVlBwb0NmMVN0Z0ZI?=
 =?utf-8?B?aXdoZWRzRUpWNVU3N1RQSFVKVnJCQlRneFVMM2FJM3RiQWd1MjUwVWZUcTJl?=
 =?utf-8?B?SkJiTzlkVXBhTjFFWGllem9xUHQ1TUJHc084Z0lTM01SeXU4R0cyc1VrME9V?=
 =?utf-8?B?TVRpbG9pdUE2U0JIcjkzNXUvelpJU2E4bjM3R3MxdVRmYmNKanlCVm9Zc3Bj?=
 =?utf-8?B?WGpEcWdtTFZRa0hMNWtBampZbHRQQVN0Yml3U2NOQWVjWGFLVExYMm0xdmx4?=
 =?utf-8?B?WDRBTDQvaSt2cjcyMlk2elNmUU16aE42TWoyWFdReEdVVFp1bXIxRVhmZ2xk?=
 =?utf-8?B?U1VZbytsc1kySUJzM0U1ZzRWVmJ0a21GU3pJNmk1cENmK0NDVFFPOVRieGJK?=
 =?utf-8?B?eFloRjFKUGNDWW5CSVJLZllqK0I0ZnViY3RYWmdzRy9rTFZmdmowZEI1Z1F5?=
 =?utf-8?B?ZUFRQ3FkdGJ0Z0tpa2hLNjJpNWpxSW9tZ3g3Z0ZyVGplYzV5UnRia3AweUhE?=
 =?utf-8?B?M1cwQWF0YlZTOGJmU3UvTzFqWnpwbmR6NVdoM3h1cXpMVUdCTmtMc0NUazNz?=
 =?utf-8?B?RVhoVmM0S2Jqd2tFZTJlY2lpZzJ5SXZkN2Z2ZHZYVjhkTFlkUjBqQVRFWWxF?=
 =?utf-8?B?bVBNUHZIb0RobnhxbS8yRG1NdGxSQlhwMUxkR2k2TkIyeTFhWnRVRXB4ajli?=
 =?utf-8?B?blFQWUVnSzk4bExGckpXWUViMXNzdldUQlRlUVZsNWw1cEZnTUNNandCYk9O?=
 =?utf-8?B?cDlOUGJYb3J5dEpIV09SVFJycXJCejQ1N1E4TVZEdVoraVZ5emxiNC9ZMUpO?=
 =?utf-8?B?NjJ4SUg2Z2traGlZNUpjSjN5WVkzWUFaemdwd3ZDbjlQRTVYdkRhekNTVTZU?=
 =?utf-8?B?TlM3M0ZxRCs0Z0p4ZTY2MEY3ZXpEU3JOcGxtbmJGZUR4dmhhUmxNclVGT1kz?=
 =?utf-8?B?dGR5bXBjNU5sVzQ3ZDRQV0NVVVl1TzVUVmIzUjJoV0RlYnFkTTJLTDhZQ2xS?=
 =?utf-8?B?R3BFRXNveHZvOW05bko3VithSENORkZDaUh2NVE0ZGN3YzBsMXEwWUdmRUsy?=
 =?utf-8?B?TE1RT2F1SzNZS3pZVWtZY2V5aVp3S0w2MFhoZTAyNVduK2pmZnJTeC8xTFdQ?=
 =?utf-8?B?cTJCY1crOTh4TUFWbUlvSXVlcE5aYkdOUnoxLzdtRkFsTUE2R2J2WDhPQUlL?=
 =?utf-8?B?WVdEQTdDYkFhWWl1RGtnWkovOStVZ003L3ZJdEJvak5mWktoR3QwR3gvM005?=
 =?utf-8?B?Ujk4STkxcjN5bzlJUXM0YUZsb3RwNnNTYW5DZnJyWkhXMDdVbTBLR1FpVzJ2?=
 =?utf-8?B?MUdMYmtxS2xNeGg3NnpNMTZvZXVYU2JKRGdXOHh1R2Z4TzFxUG9OWWxPNStM?=
 =?utf-8?B?S0Z0WTJoRDZYWmpvdDI2ZTJSdnVOU2ZoanpOQ0ZITEhkdmVwV0Ixd3dJd1o5?=
 =?utf-8?B?dExMZWRMOVNFRXpWRVdQMmFJV1VyU1lnYWtLMFFqTUhIV2QwRFR1WEQ5S0JT?=
 =?utf-8?B?WG94VXh3ZFc4a2NqYlJpdldpVFR3Tkt2eS84N1E3a3FNbER0Rk8xbG05amcz?=
 =?utf-8?B?N3pYOW5XbW9UNllFd2FDMTRYcXJnYU1qYWdtcFQ2clFiU2dvenBTUlVyT1Fr?=
 =?utf-8?B?WW5uVVh1RDVETDIrTzhZN2NJUUkzM3JyRTB6T0tVbitPZkM1c0pKSmROdC9Y?=
 =?utf-8?B?L1gzWFB1UU1iY2VXeWQ3ZGQ3S3hZTkhQME5xL09OeEowdHVhZnFZQ2Q3V3Jz?=
 =?utf-8?B?THJ3Uk9lSkNORnFMa1ZmUndUYitpTzNtZmxpM2I5N2QvUFhBTXlJWS9Mb0xu?=
 =?utf-8?B?SGEzM1NOSUZxMUVuOGpmMXQzWDlPc21Tamt5MnVxWkl0SWNlKzAvTzBMYzh0?=
 =?utf-8?B?c3BNSmw5dXJLN014M0RDeFA5WXkxSzUrbDQyY3BqdXRNSW8yMWdndGtIQmVx?=
 =?utf-8?B?NnZvQVdML29DdnVTTGtWMElaVlp1ckZRUU1FTUVNekE1NVJVWHlrdHFEaVFW?=
 =?utf-8?B?OWtYaVdDbEZFNWJNR1UvSXFsYm1PNHROK0pkdDRXWW1MRnhMTUdJR1FYUm1v?=
 =?utf-8?B?S0xkdjVxQkZ2SWdUWjlOQWRVK0VzaXBnWTFiR2VUVXgrOEM4aWRPQ214OVhi?=
 =?utf-8?Q?d5XU+gKNAx+DwbAmKRfFPUtW1DDQAcAyhXib2MHGCE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <536145C92E644D43B274A77FE4354E3A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e039961-d5be-4533-85a1-08d9f2c5a449
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 10:01:32.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqLoSBWXwHsbv1m2nVBxblyd+itzTAL68jkFLsPdrNl1wHsb873aouwEs6WbG75ZvH4fk9DwDcTlosL3HMAUtJcB2263zVv+lu8tb8xPGHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRXP264MB0774
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE4LzAyLzIwMjIgw6AgMDI6NTAsIEFsIFZpcm8gYSDDqWNyaXTCoDoNCj4gT24gVGh1
LCBGZWIgMTcsIDIwMjIgYXQgMDc6MjA6MTFBTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90
ZToNCj4gDQo+PiBBbmQgd2UgaGF2ZSBhbHNvDQo+PiB1c2VyX2FjY2Vzc19iZWdpbigpL3VzZXJf
cmVhZF9hY2Nlc3NfYmVnaW4oKS91c2VyX3dyaXRlX2FjY2Vzc19iZWdpbigpDQo+PiB3aGljaCBj
YWxsIGFjY2Vzc19vaygpIHRoZW4gZG8gdGhlIHJlYWwgd29yay4gQ291bGQgYmUgbWFkZSBnZW5l
cmljIHdpdGgNCj4+IGNhbGwgdG8gc29tZSBhcmNoIHNwZWNpZmljIF9fdXNlcl9hY2Nlc3NfYmVn
aW4oKSBhbmQgZnJpZW5kcyBhZnRlciB0aGUNCj4+IGFjY2Vzc19vaygpIGFuZCBldmVudHVhbGx5
IHRoZSBtaWdodF9mYXVsdCgpLg0KPiANCj4gTm90IGEgZ29vZCBpZGVhLCBjb25zaWRlcmluZyB0
aGUgZmFjdCB0aGF0IHdlIGRvIG5vdCB3YW50IHRvIGludml0ZQ0KPiB1c2VzIG9mICJmYXN0ZXIi
IHZhcmlhbnRzLi4uDQoNCkknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgeW91ciBjb25jZXJuLg0K
DQpUb2RheSBpbiBwb3dlcnBjIHdlIGhhdmU6DQoNCglzdGF0aWMgX19tdXN0X2NoZWNrIGlubGlu
ZSBib29sDQoJdXNlcl9yZWFkX2FjY2Vzc19iZWdpbihjb25zdCB2b2lkIF9fdXNlciAqcHRyLCBz
aXplX3QgbGVuKQ0KCXsNCgkJaWYgKHVubGlrZWx5KCFhY2Nlc3Nfb2socHRyLCBsZW4pKSkNCgkJ
CXJldHVybiBmYWxzZTsNCg0KCQltaWdodF9mYXVsdCgpOw0KDQoJCWFsbG93X3JlYWRfZnJvbV91
c2VyKHB0ciwgbGVuKTsNCgkJcmV0dXJuIHRydWU7DQoJfQ0KDQpXZSBjb3VsZCBpbnN0ZWFkIGhh
dmUgYSBnZW5lcmljDQoNCglzdGF0aWMgX19tdXN0X2NoZWNrIGlubGluZSBib29sDQoJdXNlcl9y
ZWFkX2FjY2Vzc19iZWdpbihjb25zdCB2b2lkIF9fdXNlciAqcHRyLCBzaXplX3QgbGVuKQ0KCXsN
CgkJaWYgKHVubGlrZWx5KCFhY2Nlc3Nfb2socHRyLCBsZW4pKSkNCgkJCXJldHVybiBmYWxzZTsN
Cg0KCQltaWdodF9mYXVsdCgpOw0KDQoJCXJldHVybiBhcmNoX3VzZXJfcmVhZF9hY2Nlc3NfYmVn
aW4ocHRyLCBsZW4pOw0KCX0NCg0KQW5kIHRoZW4gYSBwb3dlcnBjIHNwZWNpZmljDQoNCglzdGF0
aWMgX19tdXN0X2NoZWNrIF9fYWx3YXlzX2lubGluZSBib29sDQoJYXJjaF91c2VyX3JlYWRfYWNj
ZXNzX2JlZ2luKGNvbnN0IHZvaWQgX191c2VyICpwdHIsIHNpemVfdCBsZW4pDQoJew0KCQlhbGxv
d19yZWFkX2Zyb21fdXNlcihwdHIsIGxlbik7DQoJCXJldHVybiB0cnVlOw0KCX0NCgkjZGVmaW5l
IGFyY2hfdXNlcl9yZWFkX2FjY2Vzc19iZWdpbiBhcmNoX3VzZXJfcmVhZF9hY2Nlc3NfYmVnaW4N
Cg0KQW5kIGEgZ2VuZXJpYyBmYWxsYmFjayBmb3IgYXJjaF91c2VyX3JlYWRfYWNjZXNzX2JlZ2lu
KCkgdGhhdCBkb2VzIA0Kbm90aGluZyBhdCBhbGwuDQoNCkRvIHlvdSBtZWFuIHRoYXQgaW4gdGhh
dCBjYXNlIHBlb3BsZSBtaWdodCBiZSB0ZW1wdGVkIHRvIHVzZSANCmFyY2hfdXNlcl9yZWFkX2Fj
Y2Vzc19iZWdpbigpIGluc3RlYWQgb2YgdXNpbmcgdXNlcl9yZWFkX2FjY2Vzc19iZWdpbigpID8N
Cg0KSWYgdGhhdCdzIHRoZSBjYXNlIGlzbid0IGl0IHNvbWV0aGluZyB3ZSBjb3VsZCB2ZXJpZnkg
dmlhIGNoZWNrcGF0Y2gucGwgPw0KDQpUb2RheSBpdCBzZWVtcyB0byBiZSBwcm9ibGVtYXRpYyB0
aGF0IGZ1bmN0aW9ucyBpbiBhc20vdWFjY2Vzcy5oIHVzZSANCmFjY2Vzc19vaygpLiBTdWNoIGFu
IGFwcHJvYWNoIHdvdWxkIGFsbG93IHRvIGdldCByaWQgb2YgYWNjZXNzX29rKCkgdXNlIA0KaW4g
YXJjaGl0ZWN0dXJlJ3MgdWFjY2Vzcy5oDQoNCkNocmlzdG9waGU=
