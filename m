Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD913D06D
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 00:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgAOXAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 18:00:23 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:36542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729714AbgAOXAX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 18:00:23 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3594FC0525;
        Wed, 15 Jan 2020 23:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579129221; bh=aL7a/z4s4wNZJY9xrtcBxVa3c2vUOJNtlLUj6Zn/GPM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ViqzQsxJtpnhRPWAfu37ZiruRL540n+S1+dulActVbnve/mHkxX0CoeXUv94+wyqK
         HC90aJO2LUWmDPBqt/LTxI3KzSI7icoNBQwIqqM4kR/XGI4uWcrdhIRaWyHQfuE4wO
         bayu6czbIBAbjvazTyT1Cy/RB78+upU/Amth0VuGl8049nF/m7TSxuWz652HsqAJBN
         pX4PJGsTJwESCV2vW/DMiGvyPsdD0507Kq5Dv3ei/O9kxtJXkvSi5s0tiHEP+O39Rs
         lmaXepUXDBJLNTL5V5Xu0I4TXKV6HCEGC9/Y/ykq4iWwu/euVhFd2YUl2uJ5T6F4CT
         /S2kyrUmq1nmQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 39C21A0067;
        Wed, 15 Jan 2020 23:00:20 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 Jan 2020 15:00:20 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 15 Jan 2020 15:00:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dACTkH+302gyKBoClJ7gf4gRJ5P312Ieuh5NEGCF19aEXEHpUguzrii2B+Q+kXU5RSiE0qzNDhEphhCPeebTqLQMEzqA3OL07OjZVdDz1QqBCpe9TVyfCCwrKkMU2pMW3DjtWlSGIeeBJ0aBn3l8bZuhSrhlYy/GRmskTmbyBcT8UFBkzpJkTIpn8y883Q+2kUYIgUyeUBOo3iHfmUiHkA4EhtW6vdyzekA8s2Oh3wzLS0mfmKnlbZvcAMwG6QSGlYNp4hcyC7ZukLD6i1ZwS057EHWCqli4akAUoQvnR22aME+25fcdW120y9608a9Q0kV8lOz6ke3XYWIoUUdAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL7a/z4s4wNZJY9xrtcBxVa3c2vUOJNtlLUj6Zn/GPM=;
 b=DXXM5nT0q/J+hnEUH5Oku9oomCSvoXkxoPcuelFUss04T+Tlp3ewaZJ/1wM4Rs0CFvdybQRZaGfDIYRKX8qgJCdeG/XjhGTDOjjVOgz4YuqoeaOopuqtE5YtVNSSHDu28p7kYowzzOveRexOuFGOOv1jKYCZUZFPm5tCnO2STfe28LLerRvniN8wlfxmoJ3uj0KDB1DsBtfHSWrYpJ3uBu4xbswNbStA4uE/cJ/MHQIKj7zxrCL5zuC6L+s1uTtGaJ8iniKWQHHiAfWjLtmfXaGrcRfbdMTBrJTaKywSeYiWTpM2TiSCXY7stS8vykVGFpEWp05Ar8nfd4yTZXkg/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL7a/z4s4wNZJY9xrtcBxVa3c2vUOJNtlLUj6Zn/GPM=;
 b=Ufia/eH8fWJhbdVLVSD+Ahb0HZM8NiaOV2NPDCkAmdUmOclCbRbfNpbWQrLqC+zgQEJ1JGMSzzMOJ/0bgO9ggopbHnUGVZdLMtuRqNnJaEBfHU54QCEujG9FtJpc/gMCiVPLZjnH967SH5LLHujeFaBLLBI2OEMdUXNSGTuuxJQ=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (20.178.54.89) by
 BYAPR12MB2646.namprd12.prod.outlook.com (20.177.124.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 23:00:18 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::39a1:22ee:7030:8333%6]) with mapi id 15.20.2623.017; Wed, 15 Jan 2020
 23:00:18 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Andrey Konovalov <andreyknvl@google.com>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Ingo Molnar <mingo@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
Thread-Topic: [RFC 2/4] lib/strncpy_from_user: Remove redundant user space
 pointer range check
Thread-Index: AQHVyxaGa9XIQ1INcUi806p/qvo5ZafrzegAgACLBoA=
Date:   Wed, 15 Jan 2020 23:00:17 +0000
Message-ID: <ff24ea2b-e232-36a2-4e11-c89400feff45@synopsys.com>
References: <20200114200846.29434-1-vgupta@synopsys.com>
 <20200114200846.29434-3-vgupta@synopsys.com>
 <CAAeHK+zxVw6jOu-NzjR14U_i5cpDynE=OC3D5WswTvqT8o5NhQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zxVw6jOu-NzjR14U_i5cpDynE=OC3D5WswTvqT8o5NhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e116f8c8-82e1-4976-d91a-08d79a0eb0b4
x-ms-traffictypediagnostic: BYAPR12MB2646:
x-microsoft-antispam-prvs: <BYAPR12MB26464456C0A2BBE1CB1CA7D4B6370@BYAPR12MB2646.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(86362001)(71200400001)(186003)(53546011)(5660300002)(6512007)(316002)(6506007)(4326008)(478600001)(26005)(6486002)(6916009)(36756003)(54906003)(966005)(31686004)(7416002)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(76116006)(2906002)(81166006)(4744005)(81156014)(2616005)(31696002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2646;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MSTnxnxFc9lH0t0c/5Gc0XoiccobuzPWQOolU2B6A0GiJEuUzAH+kig2zo6UfVXq817wbPD7xeQSe+bCKXDh93altTP2LO92tMFVBpqq1UIwkW72lNaKTK3IAEwZVclPaT7oCIMRIU//4DwRjhqpuqVsRO2oMAS2WnC/XDOLZrsF5BqH+BChEyFfbPv/s1jZZA0c+3XvJUFmG/7eKz+yR7q1IZg27ZsDE79EFZM5ryHeozNcsiPHZXUMbSEfcXHWKaOayd5Fm7T6U5xiYRMwcl+/k/kb01jjcbVpDF3jUglakQ+Rj8gqXFZG/A0Uzwmq6ZayIJ7STVlZmL+uyltb5KHSml1gCWZJ7L7yeJNLoK7i5Uq3IGeAVE01JUhcs2cR1itXmTCo/+q2F50AyqbHZBbC1G99VO5/JXfc0wIHdc9M8G+62v3eReRrhAm1TpiXJRHI7nwPZynH2AJkk5/j607Ykf4SjFRxDzOWhIxGieraYzFc/zgUMGKpLAEN2viXk6nFm18PsY3oHFfCZglNSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D60597E658C594BBC4C84C7030A0485@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e116f8c8-82e1-4976-d91a-08d79a0eb0b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 23:00:17.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EmTEpNjYJh8NYdu1oKNFR/rNiO1EGKOtVPlpy7XNx1quAI6TvSzeOVUyDJTs9MK7aTm2GbAz5i1tJ0hnGIgE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2646
X-OriginatorOrg: synopsys.com
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

T24gMS8xNS8yMCA2OjQyIEFNLCBBbmRyZXkgS29ub3ZhbG92IHdyb3RlOg0KPj4gLSAgICAgICBt
YXhfYWRkciA9IHVzZXJfYWRkcl9tYXgoKTsNCj4+IC0gICAgICAgc3JjX2FkZHIgPSAodW5zaWdu
ZWQgbG9uZyl1bnRhZ2dlZF9hZGRyKHNyYyk7DQo+DQo+IElmIHlvdSBlbmQgdXAgY2hhbmdpbmcg
dGhpcyBjb2RlLCB5b3UgbmVlZCB0byBrZWVwIHRoZSB1bnRhZ2dlZF9hZGRyKCkNCj4gbG9naWMs
IG90aGVyd2lzZSB0aGlzIGJyZWFrcyBhcm02NCB0YWdnZWQgYWRkcmVzcyBBQkkgWzFdLg0KDQpJ
dCBpcyBtb290IHBvaW50IG5vdywgYnV0IGZ3aXcgdW50YWdnZWRfYWRkcigpIHdvdWxkIG5vdCBo
YXZlIGJlZW4gbmVlZGVkIGFueW1vcmUNCmFzIGl0IHdhcyBvbmx5IG5lZWRlZCB0byBjb21wdXRl
IHRoZSBwb2ludGVyIGRpZmZlcmVuY2Ugd2hpY2ggbXkgcGF0Y2ggZ290IHJpZCBvZi4NCg0KPiAN
Cj4gWzFdIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L2FybTY0L3RhZ2dl
ZC1hZGRyZXNzLWFiaS5odG1sDQo+IA0KPj4gLSAgICAgICBpZiAobGlrZWx5KHNyY19hZGRyIDwg
bWF4X2FkZHIpKSB7DQo+PiAtICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBtYXggPSBtYXhf
YWRkciAtIHNyY19hZGRyOw0KPj4gKyAgICAgICBrYXNhbl9jaGVja193cml0ZShkc3QsIGNvdW50
KTsNCj4+ICsgICAgICAgY2hlY2tfb2JqZWN0X3NpemUoZHN0LCBjb3VudCwgZmFsc2UpOw0KPj4g
KyAgICAgICBpZiAodXNlcl9hY2Nlc3NfYmVnaW4oc3JjLCBjb3VudCkpIHsNCg0K
