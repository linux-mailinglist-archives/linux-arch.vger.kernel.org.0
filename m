Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C674B99BB
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 08:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbiBQHUa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 02:20:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiBQHUa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 02:20:30 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90084.outbound.protection.outlook.com [40.107.9.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBCD29C13E;
        Wed, 16 Feb 2022 23:20:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJkW2dUKbfA2Bb4Iqd+aQhEoklTTsS3vVHQMi+slh+4sVBMHXHwOHm8G3e5knDdTEk5/PpyDWMRp+jmd2GnZicwGatGqwdUAO/W5D638VzOhnrZ87AHGVv+Lb1bwhbLytYx60xP4HoYSy4Sm5stHisAtiOsavYsZOIjfBPMUw0UuHwkv19LrRtNnI/oYCg4dLP9nNSOPnk+2OO/7FelVaSsY8iP80CSwctoPkplk6XPCBEQjk1JoqOtU9vnFq1xYxvKzATBWqtYvDYttj7uMf4ur1ScaAC4qYJYnnas9CqQR/s/9Kl2jkDKrKQzZHmmABYBhfVQTbqt3xDAbv1RJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJVxcFu8GWOxD6aURoo1n4buhNZpLc2PtdiYaHTQgp0=;
 b=UPsGMyowfBDcpW+ogqW9TQcHMxBc3PDt49oHoxsHAhNn1Vbk0Te5PCtuJu9YXSjJp1LFx1vaJhZx2W6WY/kZX/IxaNo6TjHHp5q4yGVnQdRdh9w6LM6PFZQgocwjEjzVU1zj1yq4oZfe3SFuJUQsvwPFtDTanK2dFKDlsEwJQ9nQ3PygoypxIX5jNF/VeeZcRPmVjE6PvlltTs4JQmFQMN15gE1+HPNWgKg+oQDP0s1l62Q3tfSJByvHLMKU/P26L3+wVQPa1M+bcCDxtsDfoGXvuirJPQOAcubc15x4XP8IrUcFhSTV+DskGHQbk488EF4AF66pRw/Jgj/3E5gOdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3617.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 07:20:11 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::8142:2e6f:219b:646d%4]) with mapi id 15.20.4995.017; Thu, 17 Feb 2022
 07:20:11 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
Thread-Index: AQHYIzcr/0MVz4zz9E+FaRkUlMFJvKyXVyqA
Date:   Thu, 17 Feb 2022 07:20:11 +0000
Message-ID: <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
References: <20220216131332.1489939-1-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a894ae92-7959-4cc1-8b33-08d9f1e5ef41
x-ms-traffictypediagnostic: MR1P264MB3617:EE_
x-microsoft-antispam-prvs: <MR1P264MB3617FDDA18BC14382E0C1D42ED369@MR1P264MB3617.FRAP264.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gx3FJwfFcW7eCZBMe6YQsruHcw+LepgHQ/3Yv4BX0WlP0umEhYP0FuC6ELOwAB8bd6DHGChC5A7vvqvOo4U+9Iy1k5oRmFAcFCEDHhDFZz/BWY9JnzUZg9BktYECiV3kRJKnMjfHe65Ll8jcIlpL9nvVaYgsras1W8h1q8EaJJfL2+Wooc5FNFJRDlZUmTXZvwaFJrUuiJDK5cgZHylCMyEgFxwn02+fiy5ZGcaveDvj2s1wXB2NAMRsxYp77dTtiPFNBo9gJzWMzqDnI7nwzVycuo9hUju6KNNGUI52+/LYWspkV370ltEgGJYHziVvfRDtvP4O6ihAvt+KhL99xentBXJ8bF4JRdyCS7p2onaXmtK6Qui3n2CNUryWMEATrer3UdYwtvl4l2K+2JlXvovCECNcqzI8scS8N8R3ARXEDgQ1Iebw7wafrJWzx9YaeBPNlNcJ4scASDtnR+7Sn3GAv4Lxcs5L89L3mC1exmUBcgKYG4frQSrttVNZwDNfNbYEj9A2k6G5YK2ONwrVTJvn/2eJy4OHrNn3eqFQ+Fu1nggmQu10Vyf/Ps8+uJ4Gq4OVVOQVTEgzCrTQBNJrpCl8htlRBJwQij4ZEx6bBm/hQqyhS6nxWNZqgpQv0oZZQZ9b+nrrpInA929w/ARbNgh7oNQ/hyfdixOw3194CfCZFldkT78Ct4MiubF5lNF3a+599kli/Qy0dzWYBAxXFk177n/jzFGpD73P5uLqS8uAyxbYZQ+fqHAeOPIqrDcHdn1kiPv3p+byIfvQtWFmwA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(186003)(44832011)(91956017)(4326008)(8676002)(64756008)(66556008)(66446008)(66476007)(66946007)(54906003)(110136005)(508600001)(6486002)(2616005)(86362001)(83380400001)(316002)(26005)(8936002)(6506007)(5660300002)(66574015)(31696002)(7416002)(7406005)(38100700002)(38070700005)(2906002)(36756003)(31686004)(71200400001)(6512007)(122000001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEwwZm1VOVU2OUR2TFVyZEZrQklWdGpMWWN3L0RPZXdpeDJNREhCejZadlpo?=
 =?utf-8?B?NmNZSGt3VjZuNmVQVmdrdm80NjRmUE04aEwxdThlQ3ZXeG5SRHVUbmhTWGNs?=
 =?utf-8?B?STBUNHRUWmlaVW1tSmpGQ2l3NHNadFZoZDNQVHBKRjd0a2F4VEZPd0pqeGJp?=
 =?utf-8?B?VGFlQnJYNUZCM1ZPZWx0WEtVVG5FV2kydEwxenJoVFIzd2RxaER6VGhLWWps?=
 =?utf-8?B?RFNsZG5SUVJBYXhWOG9XTndhWG56TmtFYW9zeERWTkkwekVmTTdzdXFGZzdY?=
 =?utf-8?B?ZGtzZ3RnTU95c2toL1JwYUZlMFBsRUhwM1djUWJOZFlWN1JVUWpLTlBZU2xq?=
 =?utf-8?B?NDZIc1BwT0IvS3JSY1RRMlg3MkFldXZZbjZ6Q3RiU01KcFhIWlYrZzR3OFVW?=
 =?utf-8?B?ZWVwcG5IUE9DeEJNVW5zWmIza0lsWVZ2Ym9VcnFGeVF4MzJFWkwzcUROUkVQ?=
 =?utf-8?B?UVc0aHlyUFdOSWkrL3VRRnFoYlhENEdXbityQ2pkbDdDdlpYbUJzMzBpOHMr?=
 =?utf-8?B?bytMY3ExOHlidmNmQ0lRdDVFVGRkRDFSZUJnTXpPZUZBTXBmWTZFelU1VUo1?=
 =?utf-8?B?WENQOVlHaVRudy90WkNQUmNveWFMQlM5dlY1dkhIaDJINlVlbzJ5Yk9jdG8x?=
 =?utf-8?B?RU9mWlRkb1RSNVpqMkh5WFhjR3pTcTVQUVFVbUN0amFLb204VmNJWjYzMWRm?=
 =?utf-8?B?N3p3MWluak0xbWJtK2RMMFVpVFNyUFZ0dklCVEpaY2E4TmF3VmlWWFE1dEkr?=
 =?utf-8?B?N3VpTUdGbG5OS2N4ZG40QkROekFQNEowSjdjSnVEdDhEN3MzaUZEUVUrNVhh?=
 =?utf-8?B?eTZFMTV4a29hMkMrSThuRFgrUFppeEdMWUxaNlV5Q08vT1dnM01QTlJHOW1r?=
 =?utf-8?B?dGUyRHNRUlBqQ2JQeUJhUlR4TWpuTkZWTTNQTXQxdGxOdTBKbnN1ZUFmTTNM?=
 =?utf-8?B?TTJ2QVVKcE10Z3BVSXhVSHRnM2tZY0hvTldMaGNoREJlaUdkeUlSa3ZpLytV?=
 =?utf-8?B?b0JRV1RGLzg4SE5mR3FaZ0p5bnBreG1teGMvbUM5ekxKZUdLeDRrREd4THR2?=
 =?utf-8?B?LzY4aXVaL1hUNTNwMGlUcHJxcUYwa3pLdFQ1dFV4TDh6RXh2eFA2ajZGRXpF?=
 =?utf-8?B?bU5LczRicyswd1RTL242VzBZeUNHS0xJcDJBRmJEV2Y1TXFiUHY0OW5hN0xr?=
 =?utf-8?B?ZlZNb0hEWFpwV2I0eEZJaGxlWG90dURXSUx4TWVvVVo3SnlwMkR0cmxkVHR6?=
 =?utf-8?B?RGJWK1ZxMFFva0VEZ0MwSGdmV21aMHhxT21GbmJnYWVpc0RUd3JrdjNKVHox?=
 =?utf-8?B?Z1hudkw4UFZ4ZlZhSGZmTSt2OHYvb3c4MUlaNWY5UWloQ3NGM200WFdkUDRG?=
 =?utf-8?B?eTdiSlBseXZwN1Q1NnJmWkMyM3hVZ3NqUlJaK09EYW1IdU9KUHdIbXNoUWx0?=
 =?utf-8?B?UnJkL0p3QkdBaVAzNVJMMUk0WDhtSS9heHl2a1BIc1hHT01Ba2ZoVlNLRGg5?=
 =?utf-8?B?NTR1WUYzSE9ZYTRJMnl5UDFrUXNkam5ydkVrMFMralBvNzZ0eHFlRElITXNn?=
 =?utf-8?B?d082Z1Q4YzIrQVdQellEY255d3VLQ1hmeCthczlBd2lldm1VT28wS21SQ1hz?=
 =?utf-8?B?SlAyV0VVVFRSNkRuZDVYVXJmSWJDdklXTEFEZWV2VlRUK25ObWlqWFprOEox?=
 =?utf-8?B?U3ZwZnJiOUFsYm5VY2d1ZWtqWDVoV20zQUhaMnExNXNWdTZmV0tTRzdKVTJE?=
 =?utf-8?B?dmFwUndBbEVOSlM2ZEZWSW9hYW1mbjk3Ym1SaFhzWC9YYk9CckdHWENSaG9B?=
 =?utf-8?B?VUc5cjRHSi9PZFdxVTFqUkYvZ29VbERjTWkyODdYb3FaU0tYbHJFbGErWVZv?=
 =?utf-8?B?Y0VJSGhtYlZ1K0NFcDcvK2lJRjZkalBCeGlGZXE5RmtWZHRuaWc2azlSVzlo?=
 =?utf-8?B?RTlNMmJQTEs3bmdadktaQytVclhnQmJjV2lOVnVSUzZBUU1MRnVKd1NLUjhP?=
 =?utf-8?B?UEh1bjhaZDVQWDlvZUpCUGxTNTlRazlqbEJDZG5kUTBtNDI4aUpvME1uakww?=
 =?utf-8?B?SWpVK0hFN2FpNk1FL29TMlNITDNUQmRyZUxXUURVaU44QVlGQmI4d1VYS0cr?=
 =?utf-8?B?OXBMWUZNTTBKVlRrQVBpSGc4VldKSWZVa0Jjd1ZHa1dsbEhoaTNENy80aENY?=
 =?utf-8?B?RFlqcUZ6QUtKczByb2xxaWVDQW9HNVJ6RmVnTmpRNzk0VlZwdXlFQ2hOakdq?=
 =?utf-8?Q?zlwVlTOj8bSOWxrPU+CgprRKPj021Vbe3s6jj+qseA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8997F03B17969542A071796ACE700BFF@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a894ae92-7959-4cc1-8b33-08d9f1e5ef41
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 07:20:11.3022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dlAIVnLGHgOlAL20QQvoem1RRWnvnrHnc/XQRP9wFvPEPoSJWAVOBkrdt51X2/UvAsp58iKwwSeAEpqeyysIql9O8fj0Vgf/AkXpf8+q23o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3617
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DQoNCkxlIDE2LzAyLzIwMjIgw6AgMTQ6MTMsIEFybmQgQmVyZ21hbm4gYSDDqWNyaXTCoDoNCj4g
RnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gDQo+IENocmlzdG9waCBIZWxs
d2lnIGFuZCBhIGZldyBvdGhlcnMgc3BlbnQgYSBodWdlIGVmZm9ydCBvbiByZW1vdmluZw0KPiBz
ZXRfZnMoKSBmcm9tIG1vc3Qgb2YgdGhlIGltcG9ydGFudCBhcmNoaXRlY3R1cmVzLCBidXQgYWJv
dXQgaGFsZiB0aGUNCj4gb3RoZXIgYXJjaGl0ZWN0dXJlcyB3ZXJlIG5ldmVyIGNvbXBsZXRlZCBl
dmVuIHRob3VnaCBtb3N0IG9mIHRoZW0gZG9uJ3QNCj4gYWN0dWFsbHkgdXNlIHNldF9mcygpIGF0
IGFsbC4NCj4gDQo+IEkgZGlkIGEgcGF0Y2ggZm9yIG1pY3JvYmxhemUgYXQgc29tZSBwb2ludCwg
d2hpY2ggdHVybmVkIG91dCB0byBiZSBmYWlybHkNCj4gZ2VuZXJpYywgYW5kIG5vdyBwb3J0ZWQg
aXQgdG8gbW9zdCBvdGhlciBhcmNoaXRlY3R1cmVzLCB1c2luZyBuZXcgZ2VuZXJpYw0KPiBpbXBs
ZW1lbnRhdGlvbnMgb2YgYWNjZXNzX29rKCkgYW5kIF9fe2dldCxwdXR9X2tlcm5lbF9ub2NoZWNr
KCkuDQo+IA0KPiBUaHJlZSBhcmNoaXRlY3R1cmVzIChzcGFyYzY0LCBpYTY0LCBhbmQgc2gpIG5l
ZWRlZCBzb21lIGV4dHJhIHdvcmssDQo+IHdoaWNoIEkgYWxzbyBjb21wbGV0ZWQuDQo+IA0KPiBU
aGUgZmluYWwgc2VyaWVzIGNvbnRhaW5zIGV4dHJhIGNsZWFudXAgY2hhbmdlcyB0aGF0IHRvdWNo
IGFsbA0KPiBhcmNoaXRlY3R1cmVzLiBQbGVhc2UgcmV2aWV3IGFuZCB0ZXN0IHRoZXNlLCBzbyB3
ZSBjYW4gbWVyZ2UgdGhlbQ0KPiBmb3IgdjUuMTguDQoNCkFzIGEgZnVydGhlciBjbGVhbnVwLCBo
YXZlIHlvdSB0aG91Z2h0IGFib3V0IG1ha2luZyBhIGdlbmVyaWMgdmVyc2lvbiBvZiANCmNsZWFy
X3VzZXIoKSA/IE9uIGFsbW9zdCBhbGwgYXJjaGl0ZWN0dXJlcywgY2xlYXJfdXNlcigpIGRvZXMg
YW4gDQphY2Nlc3Nfb2soKSB0aGVuIGNhbGxzIF9fY2xlYXJfdXNlcigpIG9yIHNpbWlsYXIuDQoN
Ck1heWJlIGFsc28gdGhlIHNhbWUgd2l0aCBwdXRfdXNlcigpIGFuZCBnZXRfdXNlcigpID8gQWZ0
ZXIgYWxsIGl0IGlzIA0KanVzdCBhY2Nlc3Nfb2soKSBmb2xsb3dlZCBieSBfX3B1dF91c2VyKCkg
b3IgX19nZXRfdXNlcigpID8gSXQgc2VlbXMgDQptb3JlIHRyaWNreSB0aG91Z2gsIGFzIHNvbWUg
YXJjaGl0ZWN0dXJlcyBzZWVtcyB0byBoYXZlIGxlc3MgdHJpdmlhbCANCnN0dWZmIHRoZXJlLg0K
DQpJIGFsc28gc2VlIGFsbCBhcmNoaXRlY3R1cmVzIGhhdmUgYSBwcm90b3R5cGUgZm9yIHN0cm5j
cHlfZnJvbV91c2VyKCkgDQphbmQgc3Rybmxlbl91c2VyKCkuIENvdWxkIGJlIGEgY29tbW9uIHBy
b3RvdHlwZSBpbnN0ZWFkIHdoZW4gd2UgaGF2ZSANCkdFTkVSSUNfU1RSTkNQWV9GUk9NX1VTRVIg
LyBHRU5FUklDX1NUUk5MRU5fVVNFUg0KDQpBbmQgd2UgaGF2ZSBhbHNvIA0KdXNlcl9hY2Nlc3Nf
YmVnaW4oKS91c2VyX3JlYWRfYWNjZXNzX2JlZ2luKCkvdXNlcl93cml0ZV9hY2Nlc3NfYmVnaW4o
KSANCndoaWNoIGNhbGwgYWNjZXNzX29rKCkgdGhlbiBkbyB0aGUgcmVhbCB3b3JrLiBDb3VsZCBi
ZSBtYWRlIGdlbmVyaWMgd2l0aCANCmNhbGwgdG8gc29tZSBhcmNoIHNwZWNpZmljIF9fdXNlcl9h
Y2Nlc3NfYmVnaW4oKSBhbmQgZnJpZW5kcyBhZnRlciB0aGUgDQphY2Nlc3Nfb2soKSBhbmQgZXZl
bnR1YWxseSB0aGUgbWlnaHRfZmF1bHQoKS4NCg0KQ2hyaXN0b3BoZQ==
