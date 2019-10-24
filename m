Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD28E2D77
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2019 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbfJXJfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Oct 2019 05:35:19 -0400
Received: from mail-eopbgr70103.outbound.protection.outlook.com ([40.107.7.103]:4005
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408871AbfJXJfT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Oct 2019 05:35:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmGiBsQxz3T86HnbxSahtPCZQiOWo7K6bAsIeym0n5GpvZzeBpAcVwPs2v1+jHPgkoZpf8wUxIqs4YKZyHUCb6LSOH3pn8rkgbx5ZAA2vZXzw8hV21FScyu3GH5I0r4sFLpBptfoU4tumfDYDdaHhOAoqIAg7KKfBTzHwEKjypdmB9kqKpNNp22c2deK8HocEfd3TK6nt6fRz1XaHO6fEV7azWsAp0XqdnZZ7gCWUP7w8Sx3WzKa33mbMYQ6esS8paBXPYjEqYOpJeldDHbcGbh64EtbL4RDNvcYRf8SWnQqoCy9ZMg0PmzzRiDXWKRie1gumqVD2k6f3X3+mUmthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIt9WUl36EPMd6/sTow+jAoauCcP0HziIST+STpNbbY=;
 b=gEJ6Fr4/2XPwmUqdJEkHtAcqkzJLv1qKL92rKRfQh6AfQePvhiZ67pZFNwV/VuoKe65CRS8NdKty6ok7y/eR3u0Vd6dpfEVoyb9FU/Dyk0pzzLdbB+NmRlRmROjW4AejpDFddoYDfiIgRL8RFh/UXZVvXfiSyCTjMw9+QKj+l2vZjV1pDSH3pT9rtkOSqh9nVcSAOrqdyKJWxmlC/kITIf74nrliU4n7uCYMLCvZQOkDnX5sHnQLfVyTnUvACFZe8PxNI8uyTqi0I2bRFcH8iI1aGIPoXlNoNlRKLRqFDeuL3XLEz4uOEGTsMI1RYv/923GMEGV1vVoztnQTdxwmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIt9WUl36EPMd6/sTow+jAoauCcP0HziIST+STpNbbY=;
 b=fEAnr2/i3O1AFS3nbpfEP8nNqk2J98i29Ta1hHaixE6dDgnhOQxfsfxuZdfA1FoKmOIky8RikVrhIENBJQZaDuSscfbgTUCYfJwUvhLLXD96t0J3rrr38rgQM1Hq/pS9wFlWvV0Gz7tHQUrFL7AK1wapZGeBnZx/qiLMDB7cTGA=
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com (52.134.66.158) by
 DB3PR0202MB3546.eurprd02.prod.outlook.com (52.134.69.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 09:35:12 +0000
Received: from DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::c5b8:6014:87a4:1afe]) by DB3PR0202MB3434.eurprd02.prod.outlook.com
 ([fe80::c5b8:6014:87a4:1afe%7]) with mapi id 15.20.2347.030; Thu, 24 Oct 2019
 09:35:12 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "jdike@addtoit.com" <jdike@addtoit.com>,
        "kirill@shutemov.name" <kirill@shutemov.name>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "msalter@redhat.com" <msalter@redhat.com>,
        "richard@nod.at" <richard@nod.at>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "sammy@sammy.net" <sammy@sammy.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Thread-Topic: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Thread-Index: AQHVik5IAuql7dy41k6PeTHw6KB4tA==
Date:   Thu, 24 Oct 2019 09:35:12 +0000
Message-ID: <20191024093451.15161-1-peda@axentia.se>
References: <1571822941-29776-9-git-send-email-rppt@kernel.org>
In-Reply-To: <1571822941-29776-9-git-send-email-rppt@kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0501CA0011.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::21) To DB3PR0202MB3434.eurprd02.prod.outlook.com
 (2603:10a6:8:5::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c3bd73e-ee81-4715-6d9a-08d7586577ad
x-ms-traffictypediagnostic: DB3PR0202MB3546:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB35468A3E1F5AE0EF9B52833BBC6A0@DB3PR0202MB3546.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0200DDA8BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(396003)(366004)(376002)(136003)(346002)(199004)(189003)(64756008)(1076003)(66946007)(66476007)(66446008)(66556008)(4744005)(50226002)(8936002)(8676002)(1730700003)(4001150100001)(86362001)(305945005)(7406005)(7736002)(66066001)(7416002)(2501003)(54906003)(99286004)(81156014)(81166006)(186003)(14454004)(5660300002)(76176011)(316002)(52116002)(2616005)(53546011)(6506007)(256004)(102836004)(386003)(26005)(6436002)(6512007)(71190400001)(71200400001)(446003)(11346002)(229853002)(486006)(5640700003)(508600001)(6486002)(25786009)(4326008)(476003)(2906002)(6246003)(107886003)(6916009)(6116002)(3846002)(2351001)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB3PR0202MB3546;H:DB3PR0202MB3434.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Z+ITuVOvCqKitQmaADNxgLO2KW0fDtwzxFLSRNNn7r/d6V85rreanKo2s+2tZaj57S+YSqLI8dMNxycmFP8TlbakDoiFDVeKSRPOuJMnSnLz1FzJ7iBy5FiQjktww9Zw3RWbkbaN4l8LIFun9RYGE1a+THN5jNpOMYuioTqkSimDg+3oKV0TYwESyYh1EUIGoUOwF4rz96lC1DTez136wnhWjR8bRzbsSQlFYS9NScyPinY2fuJ4aYSJh+2DAxCiSAFCobU6RUtFi4veZnHL30ia6pfX28Yt3ehNs5GYmVtFyV9xNES/PlYYRfl6QOXFPAbB1XEzjvbSKf4E0nKvP5X+69BruKyQA070TgGVgdtHQJdNqcM3TihTxK47muVoD9QxJUr985Mz1Js63GkmAokSqaiYs0iRgoJbAAJ+NZnMA++qwWJCmuskvsG/Dto
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3bd73e-ee81-4715-6d9a-08d7586577ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2019 09:35:12.1588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVrjWJqkAg7QlUmFAou+rEr+R3o62OggdRIdKwgVr0fz9Ctp3nIcWVOZEyuS4mrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3546
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2019-10-23 12:28, Mike Rapoport <rppt@kernel.org> wrote:
> parisc has two or three levels of page tables and can use appropriate
> pgtable-nopXd and folding of the upper layers.
>
> Replace usage of include/asm-generic/4level-fixup.h and explicit
> definitions of __PAGETABLE_PxD_FOLDED in parisc with
> include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> include/asm-generic/pgtable-nopmd.h for three-lelve configurations and

I think you mean .../pgtable-nopud.h in the latter case.

Cheers,
Peter
