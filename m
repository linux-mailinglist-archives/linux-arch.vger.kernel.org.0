Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEE537025F
	for <lists+linux-arch@lfdr.de>; Fri, 30 Apr 2021 22:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhD3UrM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Apr 2021 16:47:12 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52048 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231265AbhD3UrM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Apr 2021 16:47:12 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 546874043E;
        Fri, 30 Apr 2021 20:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1619815583; bh=GbMIczPTnnRephqd+l3mI3WYBrJvTxGXKuKlWzS4Wsw=;
        h=From:To:CC:Subject:Date:From;
        b=AtqV5aaAXE4Y3WYEqXhblkBXoY/HSuPnE/lqXvWiv5nHoWNPHmcKsezac2qsCZPWR
         r7DQgIWYi1Ld8TzGUsdddHSqBw/GzDXMK7t8AasLQ1d/OPaYJl/U/vz3QhjD39FL66
         F5QIMbHSsEF94h4dBjqSpFoRLm3kZ62ym9djjUlKxsdDfkNuA8PHukq5cPSolY2iJr
         jZqoYTWSGBQZ76c0sXi2CikD/HvKXIAFreAdekp+JAUEegg49OpAD8PCxzc38c1Z9X
         KINSo3e1oxjc3n5p3gHGmdk6QWwJpv3awpRiOCXqGM+F1FBBNji7+wqOk2Ut/YC7Fj
         eBg+IWiEtl04g==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B756BA005E;
        Fri, 30 Apr 2021 20:46:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 859D44061D;
        Fri, 30 Apr 2021 20:46:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="BrBuSWqN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddTUClwdYcG9BlEw5cwTPgpvCD0KrUUxl9AjP0nzHtx4tN8s5bV0h4tV0fGlSqyx0SEyWpQuaK7YQRJkz+G1Uvrq4vdGiAMGI+VFy/kc8HFwb68Yz91aUOcOw09szYVh+IUw2oMQ8Ovzuu7q5+J+JoFbuRV/eVXsO8kO2JnR/rCnN9JrvxMe86ywQR4K8w7R7yh0EgA4x3tS4EkAqhBVuLHqfh6/YkmSLFTgBTNGZ78E6F7tLJUhQQIHCz/NSsLIncWgY+1xc7cjWwQv4xPCTT4ITI3HAp4Xet6vXJTG0DnRHiypviJEyaDx+VFyyjM3yShgx/VuoFQHNitwggq2uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbMIczPTnnRephqd+l3mI3WYBrJvTxGXKuKlWzS4Wsw=;
 b=JdMiF3+YNWVZi4dq4uBSrcKUy1bFvW/cdJBYf57VgDEJwASFmEOXCQsGRdnoyYuecNg7Q4ni4RAZoye0vuCcVd6rVYikEvUhI0ZS26ZKAU+ojQgbk5Weqv81iMjl48o/wwJWhhGWK2AtvYHNZOWl6L9sBJlCy/T/4m6JuSbB5D/2KDVNiOw2RbLB/hEVrb8k+l5FYt57s5ruNrtQD7QRDcg41aJSZxsQRHMNQJ30INp/lFNd7fELOkABLYCp6Gmb1hRM10PIdiVoYZqrwMHhMDKHq3fOs58YL9sfCX797baa3orGVr1G1MU/vXcxlG6Kfq2pfKhak9iqqxiFPGQiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbMIczPTnnRephqd+l3mI3WYBrJvTxGXKuKlWzS4Wsw=;
 b=BrBuSWqN5//l3+TpqiVjECHuPGuydoVPlDJAA7YLZZjIP8MuzPZZW/uiGUWBGEXk2asQYEDfPAYCEKnihL3T4NyLq1PzSu56L2C8L4S37PV9qzBXqRc/BdH5S/3V4+97+B96KijFTCHEobtmKvanIZ8TYAspWAMPg4jUKPrlNvo=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4098.namprd12.prod.outlook.com (2603:10b6:a03:205::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 30 Apr
 2021 20:46:17 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::d1a0:ed05:b9cc:e94d%7]) with mapi id 15.20.4087.035; Fri, 30 Apr 2021
 20:46:16 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Heads up: gcc miscompiling initramfs zlib decompression code at -O3
Thread-Topic: Heads up: gcc miscompiling initramfs zlib decompression code at
 -O3
Thread-Index: AQHXPgHd1RlrjZ3rIE6wtN03PsVzsg==
Date:   Fri, 30 Apr 2021 20:46:16 +0000
Message-ID: <75d07691-1e4f-741f-9852-38c0b4f520bc@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f48d204-db90-486e-ca0d-08d90c190062
x-ms-traffictypediagnostic: BY5PR12MB4098:
x-microsoft-antispam-prvs: <BY5PR12MB409871071C90523DAD9AB324B65E9@BY5PR12MB4098.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jEudJzTWMPdpVg7CrD3KUb9kPpYi7U5wqr00Wb/kj2AInt4QmRZIewWelT+gXvP32ccJ4VYtfeUZtbXSVSEE+tU0onVLJKa/uAikS/nGP4EEG2d9RLexi2sMGSKz4c2n7g6vupJTKugB2TkJd3pbch5a3R7mVzwenrA/JicL+htnHpSYOBhT0ioQMizqwJdrNoYOXZGU62MDX9m94xm4Us/Me/wpq1zJbUOLo20lIEv9gT2NsNcSd27TS3HnDeLU6c6u7m5A4xj4HcFxzZ74kqYcQqARnPtaueRYltRyp2uGvAZo7zmqHilcK4Yk0D9GJ35kDwQSnAShUbP9/ryibc2u36sXyGK/142JpOf2Bm6ZEoFVTD/w1edKxyQl8xKR7tCd1NYREwqxSXmZtU3nD7OERIbqaWPnjHlyqoP+eFf4xQesx2+Bsj8tonjlwBXDbG2cCyHaeXHAnwwGw8mfLnMhfzKBIKnnIlXC3o2MmC8SDUZqkfCovikt2+oDh1Un31Wjf2YMh8AshOrqu6c9X/+JMLg+5+DUI/793FGmNZLAwAYKBmw4estaNMMAQ+uocwszTTSWd+hAA0zDL9/XeNoogDxaNe3OOaB6DkJg+8hSkpM3ZGZG07042Cdw6zx3WkN3ZtEtbOCI3hqNksgPFhuzPKao135W5j2ao8k73aHf0oJ/0C7+CIh8BfwNzKqcbFFqiPLKQ6fHZ99qtr0snwDyxGa05KOlGMr8WeAb9koRs1OikCb/R/o+9HYdKDJ5UjYebtQaGO3zKBOY0JWNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(39850400004)(346002)(396003)(26005)(478600001)(186003)(8936002)(6512007)(54906003)(64756008)(38100700002)(6506007)(110136005)(2616005)(71200400001)(6486002)(966005)(36756003)(66476007)(4326008)(316002)(86362001)(83380400001)(31686004)(8676002)(2906002)(5660300002)(66556008)(122000001)(66946007)(66446008)(76116006)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UEpqTDVTdnJNa1kwYVUxTUFiZkxQR00xamk2Z0FtdmRMcDdFK2ZaTlorRXR6?=
 =?utf-8?B?QU11MVg4WFhxN0NzcXAzU1JEMkV5bC8vUXdQNmpyNTdlcmllTm92K1c0a3kr?=
 =?utf-8?B?akNoM3Vzbk1EUGNaM3lRZHNjejBuamVuekUyNkI2ajZ4STRnY3pVTm9qeDk5?=
 =?utf-8?B?WEFCYUM1M1p3UFFMOHVuOE5LcEk5L2VRUmxmUkNtTGEzL3Z3R1gxMDRVK2g0?=
 =?utf-8?B?NFZsNUR0SXdlR0ZUeUJ5Q1o0cHpUc3paaTR3eEE0UjhBYXVLYlZLRjA0ejNP?=
 =?utf-8?B?MGNPNVVTQkt5WURHN3pXdVBNNUtJZlBhYTN0NHU0NitEWC94QUlKOXJzS0t1?=
 =?utf-8?B?b21kWHYrdWovZWszVUFlQzZUWXdYYVM3Um5CdEFyZXA0OUYwdFQ4M2RGMGpo?=
 =?utf-8?B?YzBaeU9pRWkxQ29qWGJoY3d5SnNKRkpaN04vZmREZ0E0TExpYnd3SWd3akxM?=
 =?utf-8?B?UDNyNkk5SHpDbnB1cW0zcCtqRU5VdmUrbUtSKzA5WTBQOFNkdFU3YVdsR1h6?=
 =?utf-8?B?MVhSMXJpdmpnYk1qZHAwTkNoTTBIUEh4UHF4TSt1Z1JFL3dYdnczQkhlbnB4?=
 =?utf-8?B?c1dLM2tFNUlEME93V2NXMVh6ZW4yakVHVFpFc1hLVzlSczhaK0ltaG1DdUdi?=
 =?utf-8?B?VkYvQzZQUGFRYmNjTjVYdEpGU1l0YWpPRGMvV041RzVoMTdsOG9xNGg1bTZK?=
 =?utf-8?B?eW9VSUpyVGl3SnUxRmp1ME5vWWlVSUxPZW5BbVhxWko2YSswb0xhOHl2dkR5?=
 =?utf-8?B?UU95YU9aZmJDRXNKUGxRZWRjRk53d0V3UnVQckxHVGRXQjZhdmRuNVhCY1RT?=
 =?utf-8?B?QVFoNXZXalJ0bkRWcGpTOGhJd3N0NGZ6eUtqQVd2WlRlNG5wdkNpNTBid05q?=
 =?utf-8?B?UkNqZFZSajZJRExOakdRQm5zQTdsWG9LRkdGVmJjMWFrRkhBY2toS1NRQjh0?=
 =?utf-8?B?VlVldlRiZ0JiMkZxaGNGVE42MVBVYzZtTFF4eWZGR2l6QStUQk1xZzJSVktr?=
 =?utf-8?B?aURkZUN1MlFwTlJieUNXQlJNandvcG41U2dFcDEvSmQzZkRaK2kyWDRWbGY4?=
 =?utf-8?B?SFpUQjJVQ3ZuVklxNkF6b3RJaUlZMHR6dnQzSW1iQmR6RFRoSWU3U0htV2dn?=
 =?utf-8?B?MkVrT1dGVmhpbm13b05vZzNTLzRxZ1pDdU40NVJiR2JIcHc0QVVxYzd3TWhl?=
 =?utf-8?B?WDNoVTZiOHlUUE1xaldNYkljamIwdTFKRzd6VHpoSDRKdDdzanBQQ3RydFYw?=
 =?utf-8?B?Q2w5ZmNtblF3bFVYRExRMWVjTk5NZk5pM2FXUFA1L291RHpxNC82YlQwYVlq?=
 =?utf-8?B?S2NBWGJJVnFaYUFNOGE4d3kxamc5OVhqdnFrbmRTdndiTTdOeGxwbVBlZ0dh?=
 =?utf-8?B?VWhmS25CdzhIZ0xSSXVNUUk0c3BIN1g2Y3pYZ3VlTENTMUpHR0lkVUtSWkor?=
 =?utf-8?B?V0RvWGFseEZSUmd3NHl5VkNjV012NkNKajBCU040d0J6RTdPMllBZ0VNMjJo?=
 =?utf-8?B?dUZZUnMyY2tCTzlwWjBEV3d4bjNiWjVIMlB2QWhtMy9jRkpteXk4Y1J5R3E5?=
 =?utf-8?B?SXdBRW1wSWtFejNSSEErS2x2Um9wSDdBR096a3hna29SU1ZjQlBGL2VyWXpi?=
 =?utf-8?B?VWtnOHZnUmtoWDJoV3Z0c3Bka0tQdWlXRXdqQzRkYVNvNmlmRGpWMzkwMWI2?=
 =?utf-8?B?UjJIQlNDQ0t0bVh0WVpUZ3kwcHhnT2tFWGFFT1h0RXdrNzRPcXh0TGcxbzV0?=
 =?utf-8?Q?4MyTDsA0H4V4jdcLFA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <74ED9ADC53D2A8419A08C9C5B00033D8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f48d204-db90-486e-ca0d-08d90c190062
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2021 20:46:16.8816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 96BnqSiMyOuvMw3OzEdNXKDpuNu3rxyse/KTO8pLOnYGrXzRfpIrkJwbCDU/smVi7crhbn11Plv8Z2bMVliRQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4098
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

SGksDQoNCkkndmUgaGl0IGEgbWFpbmxpbmUgZ2NjIDEwLjIgKGFsc28gZ2NjIDkuMykgYnVnIHdo
aWNoIHRyaWdnZXJzIGF0IC1PMyANCmNhdXNpbmcgd3JvbmcgY29kZWdlbi4NCg0KICBDb25maWcg
bmVlZHMgdG8gaGF2ZSBpbml0cmFtZnMgKyBnemlwIGNvbXByZXNzZWQuDQoNCglDT05GSUdfSEFW
RV9LRVJORUxfR1pJUD15DQoJQ09ORklHX0tFUk5FTF9HWklQPXkNCglDT05GSUdfREVDT01QUkVT
U19HWklQPXkNCglDT05GSUdfSU5JVFJBTUZTX0NPTVBSRVNTSU9OX0daSVA9eQ0KDQogIGxpYi96
bGliX2luZmxhdGUvaW5mZmFzdC5jDQoNCiAgICAgaWYgKGRpc3QgPiAyKSB7DQoJdW5zaWduZWQg
c2hvcnQgKnNmcm9tOw0KDQoJc2Zyb20gPSAodW5zaWduZWQgc2hvcnQgKikoZnJvbSk7DQoJbG9v
cHMgPSBsZW4gPj4gMTsNCglkbw0KCSAgICAqc291dCsrID0gKnNmcm9tKys7DQogICAgICAgICAg
ICAgIF5eXl5eXiAgICBeXl5eXl5eXg0KCXdoaWxlICgtLWxvb3BzKTsNCglvdXQgPSAodW5zaWdu
ZWQgY2hhciAqKXNvdXQ7DQoJZnJvbSA9ICh1bnNpZ25lZCBjaGFyICopc2Zyb207DQogICAgIH0N
CiAgICAgLi4uDQoNClRoZSBnaXN0IG9mIGlzc3VlIGlzIHRoYXQgZGVzcGl0ZSB1c2Ugb2YgdW5z
aWduZWQgc2hvcnQgcG9pbnRlcnMsIGdjYyBpcyANCmdlbmVyYXRpbmcgd2lkZXIgbG9hZC9zdG9y
ZXMgKDgtYnl0ZSBMREQvU1REIG9uIGFyY3YyIGFuZCAxNi1ieXRlIG9uIA0KYWFyY2g2NCkgY2F1
c2luZyBleHRyYW5lb3VzIGJ5dGVzIHRvIGNvcGllZCBpbnRvIGluZmxhdGVkIGd6aXAgYmluYXJp
ZXMNCm1hbmlmZXN0aW5nIGxhdGVyIGFzIGNvcnJ1cHRlZCBmcmFnbWVudHMgaW4gdGhlIGJpbmFy
aWVzLg0KDQpJJ3ZlIG9wZW5lZCBhIGdjYyBidWcgYXQ6DQogICBodHRwczovL2djYy5nbnUub3Jn
L2J1Z3ppbGxhL3Nob3dfYnVnLmNnaT9pZD0xMDAzNjMNCg0KVGhlIHdvcmthcm91bmQgaXMgdG8g
YnVpbGQgbGliL3psaWJfaW5mbGF0ZS9pbmZmYXN0LmMgd2l0aCAtTzIsIGFsdGhvdWdoIA0KSSBy
ZWNrb24gbm90IG1hbnkgYXJjaGVzIGJ1aWxkIHdpdGggLU8zIGFzIGRlZmF1bHQuIEknbGwgYmUg
cHJvcG9zaW5nIGFuIA0KQVJDIG9ubHkgcGF0Y2ggdG8gYnVpbGQgdGhpcyBmaWxlIHdpdGggLU8y
LCB1bmxlc3MgcGVvcGxlIHRoaW5rIGl0IG5lZWRzIA0KdG8gYmUgZ2VuZXJhbGl6ZWQuDQoNCkFs
c28gcHJvYmxlbSBvcmlnaW5hbGx5IHNlZW4gb24gNS42IGtlcm5lbCwgYWx0aG91Z2ggSSBjb25m
aXJtIGl0IHNob3dzIA0Kb24gbGF0ZXN0IG1haW5saW5lIGFzIHdlbGwuDQoNClVucmF2ZWxpbmcg
dGhpcyBwcmV0dHkgZnVuLCBnb3J5IGRldGFpbHMgZm9yIHRob3NlIGludGVyZXN0ZWQgYXQ6DQoN
CiANCmh0dHBzOi8vZ2l0aHViLmNvbS9mb3NzLWZvci1zeW5vcHN5cy1kd2MtYXJjLXByb2Nlc3Nv
cnMvdG9vbGNoYWluL2lzc3Vlcy8zNzINCg0KDQpUaHgsDQotVmluZWV0DQo=
