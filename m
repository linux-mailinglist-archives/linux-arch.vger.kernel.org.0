Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5850926FB82
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgIRLeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 07:34:01 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:2180 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgIRLdM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 07:33:12 -0400
X-Greylist: delayed 1439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:31:30 EDT
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08IB530i003763;
        Fri, 18 Sep 2020 04:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=wCULVw6MGGSDQC60QAzeExtdkXPfpksTt5srP6VUlxE=;
 b=Ab78yJVeS0p7O4xwwb59XZiyl9khtIH2ICmmWqBRIDV1zN2Mv5aiH3+iKDQTZOTW0H9g
 9vZcHCYn1qmQrlGBgtFQ7sQSB3s4mgrJtuU7isjRhbyKTGZ6ZuD3aUvOKl8lO2YSNygO
 5BYQF/m8uyhhw52SnK+w51ECGvmB2HbffKXW3fBszzQk+iTVtfa10FiGTAZQAAIqnqva
 8E35cntfsNGxNvkcbl8Y2Ij2ixtvcmbCtlwqp3/RdEdRusihS/80QMXOSRcvrG2BVAri
 l90brHLyMttJX0xnbDVgiYaFdvA9l4JJ52Bvd7W4uaYCA+2AtlRqXkhqpM8Zizt9tQm+ 9g== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 33m73mv733-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Sep 2020 04:06:44 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Sep
 2020 04:06:43 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Sep
 2020 04:06:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 18 Sep 2020 04:06:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK0/HYk+G8qIJmClRd+bSbcdy+5GEOaVMrJvJuxXrQNzWY4G71Pj/uln574sM/c/6JVq/3tfTmfgtEeKMTa/sF4WTROebAXin2VdgtC2+dT3OAYqcn0MFts1nCcV+bAj5m0fpk6T57s/xvfgnRucntxnvbWQcysvy3ChX/llOMpVFWmDfMzAgRg52B7l13dmIeWsQ2nXm8Tf8GbN2tzMdPPE/It5hhOJIyRuahtufQxkRjxI8fD+1L9agdIt0ughiV6lfm5RhKpMUtBprvPnNTNbzGsU6jVT1cRYzJBefEyEBfMoP7JtZYl5rsxOXcrA0a2j8fOyetOqZpAdemZrng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCULVw6MGGSDQC60QAzeExtdkXPfpksTt5srP6VUlxE=;
 b=LTagbd3myp3H62/1yXXuxNbgPkyVOcKjbwmWzLkkZohr8TMT7DUo2F4CCWRdcNKKpXAIbKSbixldUaCfixhfY0IZEHrGLOQfwfYHPnufYUTa0Th4HRujdS/tHVlJ+wmqg+LOMsWyLFfx2PGlqXqnzYl/YTHn4PhkViskU3MjC6Ez/t3e4r1YrF5+ggu2lABs0+bL8l2BZZ2/NuRF1TXh5J9HLQ3/ThTVwjDidMTP6L2Te/I5bJQvbM1L4Gu7SjoJH4/bmg+C19IC50ueM75PAX+MDvD2xgLJEjSTirffg9CNrYoRfCZ5kw0LE5TleqDV5QSYE0/JnQg5OBQ92zcVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCULVw6MGGSDQC60QAzeExtdkXPfpksTt5srP6VUlxE=;
 b=mQGxDEnhlE79qUB1r8YtuNlIyhbAqhIloAaxUpIdnMN0wyEZoKLEoTBw6dVBaC7cnVpAEcoEGegf7AGltboA7LEStVHJkAze7izb5IDT3R3RNF7ZjZnf0I9LqAGL6pWtNVOCJWEQzUSQ/JEhSmpqXW1FYDUGvbh3VbqIY2MUjNQ=
Received: from BYAPR18MB2679.namprd18.prod.outlook.com (2603:10b6:a03:13c::10)
 by BYAPR18MB2549.namprd18.prod.outlook.com (2603:10b6:a03:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 11:06:40 +0000
Received: from BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e]) by BYAPR18MB2679.namprd18.prod.outlook.com
 ([fe80::2ded:ad90:8fc1:5c9e%4]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 11:06:40 +0000
From:   George Cherian <gcherian@marvell.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v2 3/3] asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP
 pci_iounmap() implementation
Thread-Topic: [PATCH v2 3/3] asm-generic/io.h: Fix !CONFIG_GENERIC_IOMAP
 pci_iounmap() implementation
Thread-Index: AdaNq12Y3eWMrUtASzCq/UTE45fX4g==
Date:   Fri, 18 Sep 2020 11:06:40 +0000
Message-ID: <BYAPR18MB2679E96E4FFF66F7520DD90DC53F0@BYAPR18MB2679.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [49.207.192.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23c5dbcc-7fed-4acd-528e-08d85bc2eba0
x-ms-traffictypediagnostic: BYAPR18MB2549:
x-microsoft-antispam-prvs: <BYAPR18MB25490D126179555D1F3354AEC53F0@BYAPR18MB2549.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oe7L3sVPq+G1nJAoapWO8wvg4+F5IqhvnGYv1vGr4lO0pUvMnj+7zfaxfQWQQSH4j9IcI9KXFzw/zPu7IuGlMieqvj43wAnCHHcPgMceaQItU8pKCUfZjhCKWii3/Np9CdPHqrbSU8S4togGSbEOy/JPShslK3vYv9Irxq6qHDXvrXZv2mB2kfyLLAaz4ZX1HhRMnBrUYg8kji1wKaeWIhNeWj+Da0lR9U1XwEPSRdlZVYrC419BwxrOGKGYLrOsguCJiskYtwi1oDPHk3/nqST37wQeY6kNRl1IZ8jTfltx3R9HRBU4g3hETJ6FhmyQ9a2fCq6Nnekb13+cDL2It7mJBrc9zww6s7ucfTTbUcHl7eF16IQxpJXERfmnsR4i0KlKrQ6/x+7N6+cMhgx7Vwho6D9u8NGCQOZ2u8ZEdtOx9yLITzUfOwUucIA2rVR+kWtvNqU0evNkB5TSm3qMsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2679.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(8676002)(2906002)(8936002)(110136005)(83380400001)(71200400001)(76116006)(66476007)(7416002)(33656002)(66556008)(4326008)(54906003)(966005)(66946007)(86362001)(64756008)(19627235002)(66446008)(5660300002)(26005)(186003)(52536014)(7696005)(55016002)(9686003)(316002)(478600001)(55236004)(53546011)(6506007)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Eus1lDvY14oGICB8V+izgEwpent5XCznjQia6x8xuxu74Mq+HAgy4zBf2rpl7Js6yGtlTEWaoBgOtc1SnUNIV8l/rtk6k1lvl77oQUY3K08HJ/fmFktkDQ+Y7LbwxikCYeMEzApD5jHLaKRlgh08WKSapfEam82zspeJbNCzjkkhogOOft0oPs/giKPdSkyMSW7/7UCn5tGnwJAsalHqwLuhfJaj33SWG4B6gO8Du4epuEx5VjOt+sYj314gFZKz0ZQC/P/kL/ke08Ge7BhdlaOLgJaiGOHheSoA8yagyivl7I7NOtWGFokBVezYTE2eJmSxWjwKH+69t2GNye+gm+BLnJu+gOgQazy1cHOqdXWZK1QZzUgZfqR39mcuat7yS63KPW/+rRIZM/RZGKWUFNf6BNqnJr+yqZ9/F3NFJDqp27ZSVTHMfX8inHAXWRBOXa2ycP1zDntI/7qKWFCbLkLk2cEYKQACN56kzbl5svYQISpFZIzwihQlPXW5mGPsDVxanL9Vt4lLyT2qtk4u/8D2DiYl9G0hBJogN4kXKd1Q9QbEWzy0HrNXxonj/DC2eZA+Dw54v1bH+6YPcFLOmPUECpqnTmy3eupCJjUIqB36LWtvrNKvhOvstvafC0GlHEd9UswSvOUe6m8KE3sW1A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR18MB2679.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c5dbcc-7fed-4acd-528e-08d85bc2eba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 11:06:40.6061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOmRvgO4OxfZqSSuWBqUXop4701xLJtTtBPFPCO123ofyuZL7gcN9g08NpD0hB2UW/eeH+d48B/9gfHneEJjQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2549
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-18_14:2020-09-16,2020-09-18 signatures=0
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, September 17, 2020 3:00 PM
> To: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-kernel@vger.kernel.org; George Cherian <gcherian@marvell.com>;
> Arnd Bergmann <arnd@arndb.de>; Will Deacon <will@kernel.org>; Bjorn
> Helgaas <bhelgaas@google.com>; Yang Yingliang
> <yangyingliang@huawei.com>; linux-pci@vger.kernel.org; linux-
> arch@vger.kernel.org; linux-arm-kernel@lists.infradead.org; David S. Mill=
er
> <davem@davemloft.net>
> Subject: Re: [PATCH v2 3/3] asm-generic/io.h: Fix
> !CONFIG_GENERIC_IOMAP pci_iounmap() implementation
>=20
>=20
> ----------------------------------------------------------------------
> On Wed, Sep 16, 2020 at 03:51:11PM +0100, Catalin Marinas wrote:
> > On Wed, Sep 16, 2020 at 12:06:58PM +0100, Lorenzo Pieralisi wrote:
> > > For arches that do not select CONFIG_GENERIC_IOMAP, the current
> > > pci_iounmap() function does nothing causing obvious memory leaks for
> > > mapped regions that are backed by MMIO physical space.
> > >
> > > In order to detect if a mapped pointer is IO vs MMIO, a check must
> > > made available to the pci_iounmap() function so that it can actually
> > > detect whether the pointer has to be unmapped.
> > >
> > > In configurations where CONFIG_HAS_IOPORT_MAP &&
> > > !CONFIG_GENERIC_IOMAP, a mapped port is detected using an
> > > ioport_map() stub defined in asm-generic/io.h.
> > >
> > > Use the same logic to implement a stub (ie __pci_ioport_unmap())
> > > that detects if the passed in pointer in pci_iounmap() is IO vs MMIO
> > > to iounmap conditionally and call it in pci_iounmap() fixing the issu=
e.
> > >
> > > Leave __pci_ioport_unmap() as a NOP for all other config options.
> > >
> > > Reported-by: George Cherian <george.cherian@marvell.com>
> > > Link:
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g
> > > _lkml_20200905024811.74701-2D1-2Dyangyingliang-
> 40huawei.com&d=3DDwIBAg
> > >
> &c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DTjMsEFPc7dirkF6u2D3eSIS0cA8FeYpzRkk
> Mzr4a
> > > Cbk&m=3DUO5qU5LtNtCn6_gnT0rCkBxIm-w8jCaxHO6v7oK-U-
> I&s=3DCSGHQpKoVdNiqb1e
> > > DFuRUhka_Xv5o2PosWZ1rR8oOD4&e=3D
> > > Link:
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g
> > > _lkml_20200824132046.3114383-2D1-2Dgeorge.cherian-
> 40marvell.com&d=3DDw
> > >
> IBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DTjMsEFPc7dirkF6u2D3eSIS0cA8FeYpz
> RkkM
> > > zr4aCbk&m=3DUO5qU5LtNtCn6_gnT0rCkBxIm-w8jCaxHO6v7oK-U-
> I&s=3D3B83oan7i1g3
> > > KaPgQmFK6PudR9GzvAPk33Z5Yyv-CMI&e=3D
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: George Cherian <george.cherian@marvell.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Yang Yingliang <yangyingliang@huawei.com>
> > > ---
> > >  include/asm-generic/io.h | 39
> > > +++++++++++++++++++++++++++------------
> > >  1 file changed, 27 insertions(+), 12 deletions(-)
> >
> > This works for me. The only question I have is whether pci_iomap.h is
> > better than io.h for __pci_ioport_unmap(). These headers are really
> > confusing.
>=20
> Yes they are, in total honesty there is much more to do to make them sane=
,
> this patch is just a band-aid.
>=20
> I thought about moving this stuff into pci_iomap.h, though that file is
> included _independently_ from io.h from some arches so I tried to keep
> everything in io.h to minimize disruption.
>=20
> We can merge this patch - since it is a fix after all - and then I can tr=
y to
> improve the whole pci_iounmap() includes.
>=20
> > Either way:
> >
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>=20
> Thanks a lot. I'd appreciate a tested-by from the George as he is the one=
 who
> reported the problem.

Verified this patch and it works as expected.
Tested-by: George Cherian <george.cherian@marvell.com>
=20
> Lorenzo
