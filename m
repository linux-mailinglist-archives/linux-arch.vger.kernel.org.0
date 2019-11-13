Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268BDFB22F
	for <lists+linux-arch@lfdr.de>; Wed, 13 Nov 2019 15:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfKMOIN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Nov 2019 09:08:13 -0500
Received: from mail-eopbgr1320075.outbound.protection.outlook.com ([40.107.132.75]:7680
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727673AbfKMOIM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Nov 2019 09:08:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zay928Yh81R8IVlrw4MksuuRJZmzhWlbfpF2jxgMvSxZ7NY9LKyx7DOKYd9X3SlKxrGgAgNAVrJSNRL1ez18HDQKp7Aa64W0KKqSQ/ipIFjYsZ7EiSbPosit+BIjeHQ9JT8psI+6nJ1R+dLaC4f/edihXT5vZiN21NxynkmYFSRwi0FxWv8+uWyb0iBmtiWq4YG54ODBll7KJZTdpp7MN7mWuhfvuEPHk8syBBzvvUr7niqEdoWkScPPoLOZcTWEJvGtPq9M5GmxzxbPKAwr3D73awji1OUovhEXjFfuBr0FVLsOo5aV6ZYDocKHHzQOxhNBYB4Iec+8XPFYMtWoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nHEsLaw1Cz9+X1pVruDRkVipWsrR4oCuWZw9ccmmc=;
 b=PN20lrvzr4TiUNjXyaufcnjf7tGbq2XHLJFEcvpth35g3JXCcsXPkF26SwL4ZSkCqBe2T6xHnqg8J65fokoL4eOdvGMSHgBdTbQ85OIFrl93EpEEqwFxRGVoay/Yr2a5fKs2CaiuqoJPoJhcoehz5ikjdryIID5cuEhQl0yVnzTWWeuMTRMrF2QsiBpV6SltSUmRP0VY3S6hYSeyEPJSLjeyyVKAxJYL5Nv0bPp0pObJF9bqHb3uaDQiXvAbwH4tOAyuKG7zuS2bFPeO9ZOSj3pH9oMn+EnUnmfz4L/nRUHg6CGEflnAWa6ogHkAvFbmJnu3S2cryzx9/pMT7zxOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7nHEsLaw1Cz9+X1pVruDRkVipWsrR4oCuWZw9ccmmc=;
 b=Nl9/99m5LnOn0fEBCKJGGsQmzguQLXuJthQOrm+cWYV95zas4fOAGuD22eLcBpBam9IkLuXlrOzvhfaOC5MnPZ8G9/tgTgLnU3XE7juHlsbUVmPkHJoXXlFDU8DZBkSQgY/ysqrCxhvojHTDIGJUyXoqWqkAOd4NCY7tWPovmXk=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB3288.apcprd01.prod.exchangelabs.com (20.178.154.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Wed, 13 Nov 2019 14:08:09 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::49d4:fc70:bde2:c3a%2]) with mapi id 15.20.2430.028; Wed, 13 Nov 2019
 14:08:09 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged me to
 try applying for refugee status/political asylum in several countries
Thread-Topic: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged
 me to try applying for refugee status/political asylum in several countries
Thread-Index: AdWaK8MHKfFkamRTRQmKzCHjWlAnRA==
Date:   Wed, 13 Nov 2019 14:08:09 +0000
Message-ID: <SG2PR01MB2141B8BE3E4D8FEFA083558F87760@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:9162:51ee:7860:8489]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c545d92a-301c-4b7e-c90a-08d76842e9e1
x-ms-traffictypediagnostic: SG2PR01MB3288:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SG2PR01MB3288090799C9F18E8A89931F87760@SG2PR01MB3288.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(136003)(39830400003)(199004)(189003)(6916009)(8936002)(52536014)(5660300002)(966005)(486006)(476003)(74316002)(305945005)(86362001)(508600001)(25786009)(5640700003)(107886003)(6436002)(2501003)(9686003)(6306002)(14454004)(55016002)(7736002)(33656002)(256004)(14444005)(71200400001)(6116002)(2906002)(316002)(71190400001)(186003)(2351001)(76116006)(7696005)(99286004)(81156014)(81166006)(4326008)(46003)(66476007)(66946007)(66556008)(64756008)(66446008)(6506007)(102836004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB3288;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dvN7pzXWWGGIRy09jgguy8z1e86SRC2/3o0SobnFBGK3T976FBSgjWjxo80cxeWV1gMgCrlg/Uzx+dw3K8Tjvhj+J5oBRVYEalD+v5NTR+Gbh+R8BjpDCUHGsb276mJ1fSaEQFPHf6VGFGKExJHAE6I5bPBoSeEH7huIMdUbWjoOlyTGsXiW7rVQjqwAOsMwrkZiDIo2OSUnHK3C+/799eOX9BX7lL0YbcjIZRr8mq81Ekaytp6NyG9KudN+L/PtncQ5w9qB5BACt4i8MYV45IiJQSBH5OFwQC9kP5kNTdGeTSvMZKLxDdYl3ziCbo3AGbp4D66a/bfo4nETFE3dVascGnE2aGirbRvOfUWFfeQyPHX9FZkqhoCDDqSLM+MU8+fmn60Pz9r0fy7SA2OgzKBoqsb2LzVy7zoAzezVKoWUDEPfc40dQP5YNRcwZwszGoFNNSwSixWD+zFV3nYcP82qs8pLOhofvMVrVWa/X1o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c545d92a-301c-4b7e-c90a-08d76842e9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:08:09.5624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/UKYymJ3siLeTZH/8bT33ELVEZCzTM28SGfFquV+z5OakQscGlySc0oKX27nzc5rm4bHl/+DXgmaPam9fYg2OFbdQCHnFUf2hLhETqD9Ok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3288
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Subject: Singapore Democratic Party leader Dr. Chee Soon Juan encouraged me=
 to try applying for refugee status/political asylum in several countries

I have a chance encounter with Singapore Democratic Party leader Dr. Chee S=
oon Juan along the street at Toa Payoh Lorong 4 on 13 November 2019 Wednesd=
ay at about 3:00 PM Singapore Time. I was on my way home after a 3-hour par=
t time/temporary job from 11 AM to 2 PM Singapore Time when I bumped into D=
r. Chee. We had a short discussion. I briefly told Dr. Chee of my plight fo=
r the past 13 years, which has been told countless times in my RAID 1 mirro=
ring redundant Blogger and Wordpress Blogs, my autobiography first draft 11=
 November 2019 and my countless international posts. Dr. Chee advised and e=
ncouraged me to try applying for refugee status/political asylum in several=
 countries. We parted soon after.

Teo En Ming's Archives and Records Administration (TEMARA). Office of the G=
rand Historian. Records made on 13 November 2019 Wednesday Singapore Time.

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

