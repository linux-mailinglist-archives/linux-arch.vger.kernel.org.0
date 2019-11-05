Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35571EFD0D
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 13:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfKEMTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 07:19:00 -0500
Received: from mail-eopbgr1320050.outbound.protection.outlook.com ([40.107.132.50]:22912
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfKEMTA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 07:19:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvmwRLmIympDT+d6vpM/QTkSIz/pixJylIbamY65ro6UUwrE4EVhSZBomvdiZvQn73li4EQXlL9AsQ4LmUyTVrNezjQpYEzBTlY0v7PYXG1vpkzj1XGfzG+gApSOA+mWiEEkOsimavmul1fpdg7/ODiUr3C5bPsUn+gNPEPIfcaUxWZff3ZCtIeiCC3tH2c+9ZnroSWFEFg0XZ59ZrSrl1GIvp08518XELT5iWo12Zx2uIV2FfcFL9HoUmio8kV0lFlcCdrfmArh/fnwzkEhJerL0Gp9+Aa5GBhVIvW8Hx4o5f2vL6TPYDu00iYI51SoJqEGo/2vwFDyVlMeTJ7Fcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1wfJQMw57GHZ3f/QVA+bFRWOTZP/g+o05EoNYBkI7I=;
 b=Uyrl7jZF6NxbI3RyERW7+utmsR8YqVYlCZUt37/KOJpgMM+m55fPmzYUvRXEQynauvyiu4BcbPIxdhGZ2JOGvmkl+8JfwNA/ciFGRyXHoEa5WWBjrI5EwycslWOAcb9/gEfhQBjaupUOYL3S0HqyZcIvZzB7gfHMwg2FOXuEhzus4qSHYEAw/xOwTvrcIyYVrhckscloL0nqpYNoB8z+OXt8m15WeX+bEL4BQRlt+tgPLJT+wyS0eb0uV3j5lWmb2tbUZba/tcQ3WT/nn9b1wx0st0UI3f03OugqqJSm6au75V7+x32f5rDJuw+AUp/a8DzHBl3PNrFBkMaRZTYK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1wfJQMw57GHZ3f/QVA+bFRWOTZP/g+o05EoNYBkI7I=;
 b=DQVhKj8LmWADJ88PK+QGTSKc9amy2IbuPWyFjJBSbeYxqyV4tdjguO3tbSew4QOkmF7j9pZJdWK2XKWgLPTgPx2X9wrIP3qGavuSNGwn3leCn7X95nnQQAsP8LJJ6UamnmOqdDGrRdlc8q4TLzembnz3DtbDU/99nk0ejsp3dlM=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2582.apcprd01.prod.exchangelabs.com (20.177.168.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 12:18:53 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a%2]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 12:18:53 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera on 3 Nov
 2019 Sunday
Thread-Topic: I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera on 3
 Nov 2019 Sunday
Thread-Index: AdWT0yZ5Et53+B4XQcu7YRulU6LM4Q==
Date:   Tue, 5 Nov 2019 12:18:52 +0000
Message-ID: <SG2PR01MB2141FE7ABF38A578216D3D49877E0@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:e1cf:3260:7a2:ccd6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2b0f4bc-6914-4f06-8032-08d761ea5287
x-ms-traffictypediagnostic: SG2PR01MB2582:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB2582E4C5364F42CDFF8DCFD8877E0@SG2PR01MB2582.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39830400003)(396003)(346002)(366004)(189003)(199004)(2351001)(476003)(5660300002)(14454004)(486006)(6916009)(71190400001)(305945005)(7736002)(6506007)(2501003)(71200400001)(508600001)(5640700003)(6436002)(7696005)(74316002)(52536014)(99286004)(9686003)(55016002)(6306002)(102836004)(86362001)(316002)(33656002)(2906002)(46003)(25786009)(107886003)(4326008)(14444005)(256004)(6116002)(966005)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(81156014)(8936002)(186003)(8676002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2582;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uAMdDKxLkgnZeSBvu5jlpceXar7Kky+qHffPeExiKn0kh2wGsbWlXjNyDdsUaAzL6bkC0J/F9xsD5u24HRi4FvVQefIG+GNKotcJie3F93uMxQ7hoU9K7B22WMto8o/rj82MlzIUcviFWFzT3vH4OPG4VKfLDyhTkIj4Yn9tEjO8VIV3JpHNxzUVYMmYJaZaJs6oOsY0jrafn8C6EHeAorIYYcJtja7yzC4s2MoxU90N3EaPGzXZoF0F9rSyoQpX2efFFNG1GJq0ZnxagvvXyUAtJjq5PXxkMGa1+wD8ykwSg4/KoPLOWiffGyJWn8KwxEKRYPK++Mo1t7DsE5FMdOQH4CfQBS+engt7C9eZZM7rKNpOWjr2SF7QboJMUwAchP7Akq0CjiYLf/+OWZNACxCE8/u2+cevfWvJNqwv+7lsITWkgKJJEs3C/+U8F5HTZAzcSEgZNQj00zaQ1VsDCIXj+30BJ6jG36dt/IblRVU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b0f4bc-6914-4f06-8032-08d761ea5287
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 12:18:53.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEtwIw5MXFQn3GWgJdNx+xEcKww3TrGcWemU/RvdFNN9r5BXdbcfUGis+Y/4iM62MedHvJDh03AxNDPrs4qZ4fjqAWXBK5qVWIISoofioyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2582
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Subject: I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera on 3 N=
ov 2019 Sunday

Good day from Singapore,

I bought my Panasonic FZ1000 Mark 2 4K hybrid bridge camera at Funan Singap=
ore shopping mall level 3 on 3 Nov 2019 Sunday at 3:25 PM Singapore Time.

The Panasonic FZ1000 Mark 2 camera has an 1.0-inch MOS image sensor and a f=
ocal length of 25-400 mm (37 to 592 mm in 4K video recording mode). This sa=
ves me the hassle of constantly changing between Sony 16-50 mm kit lens, So=
ny 55-210 mm zoom lens, and Sigma 30 mm F1.4 prime lens every now and then.=
 I simply cannot afford to buy an expensive full-frame DSLR or mirrorless c=
amera with expensive camera lens in excess of SGD$15,000 (like what most ph=
otographers in Singapore do) due to my extreme poverty in Singapore. I beli=
eve that a hybrid bridge camera with an 1.0-inch sensor and a focal length =
of 25-400 mm costing approximately SGD$1000 will suffice. The Panasonic FZ1=
000 Mark 2 is considered a Compact Camera, but with an image sensor much la=
rger than 1/2.3 inch. It has a built-in flash and a hot shoe for mounting a=
n external flash. It also features a F2.8-4 Leica lens.

TAX INVOICE 3 NOV 2019
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Qty: 1, Panasonic FZ1000 Mark 2 bridge camera, SGD$1039

Qty: 1, STEINZEISER Battery Charger + Adapter, SGD$28

Qty: 1, DIVI PA-BLC12 3rd party camera battery, SGD$28

Qty: 1, SIRUI UV PRO ALU 62MM lens filter, SGD$23

Qty: 1, screen protector given free, SGD$0

Grand Total: SGD$1118

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is ONLY AFTER I have sold most of my Sony A6300 4K interchangeable len=
s camera system for a combined total of SGD$810, after using it for about 3=
 years and 4 months since June 2016.

The following items were sold for SGD$650 at 12:00 PM Singapore Time at Toa=
 Payoh MRT station:

(1) Sony A6300 camera body, with box and accessories (includes default char=
ger), sold for SGD$400

(2) Sigma 30 mm F1.4 prime lens, with box, sold for SGD$250

(3) 2 units of original Sony NP-FW50 camera batteries

(4) brand new Panasonic 16GB SD card worth SGD$15 given free

The following item was sold for SGD$160 at 1:23 PM Singapore Time at City H=
all MRT station:

(5) Sony E-Mount 55-210 mm F4.5-6.3 telephoto zoom lens (model: SEL55210) w=
ith box

SGD$650 and SGD$160 add up to SGD$810 mathematically.

I *still* have other camera accessories (belonging to my old Sony A6300 cam=
era system) waiting to be sold. I am hoping to raise more than SGD$1000 ins=
tead of SGD$810 so that I do not have to spend so much on my new Panasonic =
FZ1000 Mark 2 bridge camera as I have been taking up numerous mediocre low-=
paying part time and temporary jobs in Singapore since August 2019.

Published 4 Nov 2019 Monday Singapore Time.






-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

