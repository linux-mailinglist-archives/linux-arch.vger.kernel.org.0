Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0707C234DA6
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgGaWlS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 18:41:18 -0400
Received: from mx07-001d1705.pphosted.com ([185.132.183.11]:39118 "EHLO
        mx07-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbgGaWlS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 18:41:18 -0400
X-Greylist: delayed 2603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2020 18:41:16 EDT
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VLr1Oq028552;
        Fri, 31 Jul 2020 21:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=aMdqP+P+B1QxriVhVqcickg+xTQqbaGh+TaN8Em3axE=;
 b=A96jtxkir7YYD/IDsG4LMIr6WGm/LFpsTOwEpX7CH5ZQsYCdgtPOsa6uOY+wCPfM9g7s
 ioPIcVhvJSyiHbLDaPJ+8hGYCJ2uPkuT7EHBYB+BI2DUP74Zsmr1h9OZanuy/X1cSdoU
 NCiFdpCPrmb+F4Fv+zbg1jU/v/7PFRmrXm6dViXJdSO4VbrSzdaFtU609ViMxwiyLJk1
 YYoCv5FV4GHJk7B9UR4dfov78z0d7Nss8YhCTAmera+l8Sr+XOWkvkJW7JJaEyOHaPTD
 mYYNVgC1TpJhZiEnd6OVgqETtGCdwhjC80vdBN0tyNO6xZSCQ8GaVwh+mgYUbwyYCz4C 7g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx08-001d1705.pphosted.com with ESMTP id 32gdwkk6bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 21:57:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCBMNGtuVA4MSarhYMws8bPRvnUtrOa7INgy2KPHIigpXf0TzXK5zvYLS/HIS/uQgZeBCz4vKP7S5wlGpSJUnCBj3FMw6VWp5HrpuwJnB+WdnfNInLXxnNKP+czE5TcfxYoOy9hrsqtGHCEwGZ6CWeRu1OIr33cb7UYKNfig3rK6ngLd5pXu/PawjZNPjj2DFSTYuaqGwU+6FmJbUrMrk56+3s2xxEnqT6IKjlLl2gL1f1hrv3tE1kPoHLa+3AwsycAbbrs4WvKxS7UPdVv2r/tdKznMasP8rZ0B+YBs0v4Fo2bZK0/PCDhpxKDOLg7gDjO9I1UY6IkakiCSKZC1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMdqP+P+B1QxriVhVqcickg+xTQqbaGh+TaN8Em3axE=;
 b=bwyHRU8xrIRVL5h52h0if7FnsjKlNGU2Qo2KdxxtDQdvOZLQR1REp9Q47qwwxHOKxRN1/6Zfo5BBFpUyN9n3UH8yQbnj2sGi1ndvUfSzGT7ysSqzjWYud4xpJh/kzml8CJ7NC1EKlvBQlwpwE3eFyb97JGXXZ/VKvYnRxuUEB3Rkzn4mwYFuWuOK66IeTblepcTsGIHz4R6WST0jfOAWXBi7VoQGMkPGrAjW6XkH5KG2iV4KuuLJdxzxNnnZNbiR6+sMbVHwG6vPlSawBv6RqtJ9SPc/SdfZKLnPv0wx/XHvyxYcwmix0GufTt1x1TL91XTWVfRqCXTC8XuDJTfY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2104.namprd13.prod.outlook.com (2603:10b6:910:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.15; Fri, 31 Jul
 2020 21:57:41 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::5c0c:3d3a:c493:efa]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::5c0c:3d3a:c493:efa%11]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 21:57:41 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     "josh@joshtriplett.org" <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: RE: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
Thread-Topic: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
Thread-Index: AQHWZ0tdFHgmKRoEqU+Vr8dgbGY8EakiNCiAgAAFxNA=
Date:   Fri, 31 Jul 2020 21:57:41 +0000
Message-ID: <CY4PR13MB1175A3B5D9DE33D3A1E045A6FD4E0@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200731212721.GC32670@localhost>
In-Reply-To: <20200731212721.GC32670@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: joshtriplett.org; dkim=none (message not signed)
 header.d=none;joshtriplett.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [192.34.114.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82ee0b16-f33b-42b4-d531-08d8359cbf54
x-ms-traffictypediagnostic: CY4PR1301MB2104:
x-microsoft-antispam-prvs: <CY4PR1301MB2104944CDFCA6E29BC8CB1FFFD4E0@CY4PR1301MB2104.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMVtNmMCO99eM1acel2C7QGIO/1K8v3F5CAXrTo9W9/UctLoMFrMJRLj/l4pGmwE/PlN2n+jsRcfk882P7UVSaKkQeHe3oRGemwkMJG3KTzXBO0GctbzL7JgITcE8Yj525YlX04H+NPldkbTy9RnAOBR/M+z7Inx46NC+5oswqwTTbRUYWvb94Acmv4M48rAFCuvv8Vv08xU2Qy1eu+7VDOjqb13zy1aW9kcn19o0TPXaXjkb+g5xvDM7MCqMipsGoBLzujbeJK1H2Uo7AN3kFCoELbOSNrPkJndn4J79AcUEzOQLo8fLVhZTW+x90k8BXNB8OIVgmsaZqf4MKCTYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(64756008)(66476007)(66556008)(66446008)(76116006)(54906003)(8676002)(86362001)(8936002)(7696005)(71200400001)(110136005)(478600001)(4326008)(26005)(66946007)(9686003)(186003)(52536014)(5660300002)(2906002)(83380400001)(316002)(6506007)(33656002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OP1u0jz2rWX8YAZ6WB6r3L0f/9W9+bRTke5V/0m0WsMosUBX6vjvNlaaDADzmkSfkJMo0INHzCs+D5J0bPknP1vSGALsqTjTZeyrPgUjenEgvlCnpJYsMC4UdsngOaZnAk2Nm+m/pzJRCOzJEILXlQyCo++jzahWHbr3KGrTEn+VhQWm9jWdaI4ME2NZBOGd7UYLJ5h7IbUGz2ImUybg8A4SgTlg4aR8BWwlKPwUQXeR4WDfknpIbSuvAF++HX1dZU2otm/ZC6urYClj4YOTWFEmOxUwnjntfIxWcqCNjXztyCPYklBpIVD9s2ai5ROduPq3xh3o0mLwGuKw0Peete2+QCnpBUJbp+WE/e+mrt9OqAhxfYAUS1XI6HSLe0Ik5R65U3V1q4SkDy4eEicF8VRmj921cmpFmJJA7xxgmS1fuDXHc2gfAIXT6SPzOleiVuRByMDbyvw2E5V1oNz06FHrLg50l9zMy6hM6+KK9F9AwTr48jI/I2E+QH8n0NRLZBzEXGvK3nNY+ASH/+J179VRgBeUGl4cWUFyHoHcrBjHFqz4zIZ/yKxH2dezut2sFZyv2R5d8LpMtqqlXRRL0XYqpj1ywdcPE9cVM7x9y/Jod0EDj3PppsAXwvOzXGGXCXNJB5TyMjcqdGF9b1jt+g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR13MB1175.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ee0b16-f33b-42b4-d531-08d8359cbf54
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 21:57:41.3293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6JrqXCjJMzfRhKHHPoYaUhX/J7LE1tbbi0du2YY3sXmv+KZeSG7F1NvlnwDEMcs/x6xw8OTBKcS8s2zLs9rzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2104
X-Sony-Outbound-GUID: LBasDos5cIa0nVEJPRIu0CT9TKezEDec
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_09:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007310153
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> -----Original Message-----
> From: josh@joshtriplett.org
>=20
> On Fri, Jul 31, 2020 at 05:00:12PM +0200, Arnd Bergmann wrote:
> > The majority of the code in the kernel deals with hardware that was mad=
e
> > a long time ago, and we are regularly discussing which of those bits ar=
e
> > still needed. In some cases (e.g. 20+ year old RISC workstation support=
),
> > there are hobbyists that take care of maintainership despite there bein=
g
> > no commercial interest. In other cases (e.g. x.25 networking) it turned
> > out that there are very long-lived products that are actively supported
> > on new kernels.
> >
> > When I removed support for eight instruction set architectures in 2018,
> > those were the ones that no longer had any users of mainline kernels,
> > and removing them allowed later cleanup of cross-architecture code that
> > would have been much harder before.
> >
> > I propose adding a Documentation file that keeps track of any notable
> > kernel feature that could be classified as "obsolete", and listing
> > e.g. following properties:
> >
> > * Kconfig symbol controlling the feature
> >
> > * How long we expect to keep it as a minimum
> >
> > * Known use cases, or other reasons this needs to stay
> >
> > * Latest kernel in which it was known to have worked
> >
> > * Contact information for known users (mailing list, personal email)
> >
> > * Other features that may depend on this
> >
> > * Possible benefits of eventually removing it
>=20
> We had this once, in the form of feature-removal-schedule.txt. It was,
> itself, removed in commit 9c0ece069b32e8e122aea71aa47181c10eb85ba7.
>=20
> I *do* think there'd be value in having policies and processes for "how
> do we carefully remove a driver/architecture/etc we think nobody cares
> about". That's separate from having an actual in-kernel list of "things
> we think we can remove".

I'm not sure the documents are the same.  I think what Arnd is proposing
is more of a "why is this thing still here?" document.  When someone does
research into who's still using a feature and why, that can be valuable inf=
ormation
to share so that future maintenance or removal decisions can be better info=
rmed.

Maybe e-mails are sufficient for this, but they'd be harder to find than so=
mething in
the kernel source. But that supposes that people would look at the file, wh=
ich=20
appears didn't happen with feature-removal-schedule.txt.

 -- Tim

