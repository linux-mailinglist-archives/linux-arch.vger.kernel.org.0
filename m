Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7183230F94A
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 18:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbhBDROs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 12:14:48 -0500
Received: from mail-dm6nam12on2128.outbound.protection.outlook.com ([40.107.243.128]:46817
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238159AbhBDROV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 12:14:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clEtMrXbov7M1Y87q/2whjYgF2nniwnp+oZnYzyS+8MvGK/pQlOKWhoy/WKSx2OAtm29V2ukgyRkxg198i9sX186+hRs9dAKnBkE3pePZs24bbPo7sRkcvPoTyTFTFgAN8BegShdpCRH6bd+1jJ5Z8FT0Z+oPDZ8u+ebtmaALPD5bps201ZMM/h0wVIaxIVDdCIev/7kDv3C2JBeN0ddRZbYSI5g0zYZZ5Uy+2wD+h9vlnB5OrqH5m46IkzNdGA313cwk22LyK3eCOqTCbg4y14FeXluafAsJCjEqFeKIzgWf0szdzUfPZ10peo4VXN4lpy2eitiM8G7s7HdSP14ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg8OWryhcbm5PPDTzpUpiV7uwXF+JTuCGfX9xgE+sIU=;
 b=PEtihQDc6g5Y0CR5BLN2/7F7ItwCja4EFdLFoGflB8dgQT5AA+z7FcoVP+5I65mbVhN1izV53rFpugV3GtnI0gpXuPvFGbaecGOhHrjDz+1Xl+7OmeLmRpM+RyPfowA8960Gz88AhlP2wTrr67+CfX//pe00QWs2LBkrIkAloiU1+CBmLmWMAwTGkvgsDf3+8Y+U2gEe0iXJMg5eFwUwOhab1x96G6vS/BkGut98UsHcjjEnYi6s1Cm3vQzRxFe84uoTTXebb5z+Lh+35OMEJah9TTF0eGpqRrJSyE3XU5p/6WnujNf+D+d96GyOfQeqftRP6POHI1xuA+zqdtjAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sg8OWryhcbm5PPDTzpUpiV7uwXF+JTuCGfX9xgE+sIU=;
 b=KBLRVrN9B+CkviZRMj1My1YvPgkBVaPAI7i6ZRyGK82sILhWJHTvYRKS4siSbEPC7mwYQS10axkecdPhe5PkbdgqVckBTPmysVjGICCKSA930KwOCEgzBVLEInETIf4AUoRPbWTNVDV4hHj476MfhUhQ0lK9fjoDGGJpofWFRKQ=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1873.namprd21.prod.outlook.com (2603:10b6:303:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.3; Thu, 4 Feb 2021 17:13:30 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 17:13:30 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v6 09/16] x86/hyperv: provide a bunch of helper functions
Thread-Topic: [PATCH v6 09/16] x86/hyperv: provide a bunch of helper functions
Thread-Index: AQHW+j3uULlbgWjr406sbgkChiWFS6pIPA1Q
Date:   Thu, 4 Feb 2021 17:13:30 +0000
Message-ID: <MWHPR21MB1593E317A4D6B24A7B9BAB75D7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-10-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-10-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T17:13:28Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4588920b-1c53-49ac-b87f-40a865c55e7d;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86a5f865-d5ff-45cc-c7c8-08d8c930320b
x-ms-traffictypediagnostic: MW4PR21MB1873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1873E8705C9956CC17697F86D7B39@MW4PR21MB1873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LftyXfomziHgK4RsjPwuL+WqjkQlRb4C4caAS3+n483+96khC/7AVovxBmCPJUnxMdMSOxKfronhuJI+5Twsq5CjeNZbECnrv8hzPNqI4UdXV68N2l8QzlQ/aplWT0DxZPhGdb8CHQTk+HuJV+rCbs9KdGhJObbPEnnEvopMmmWG5PASCo4dvphb8N4mpUXv6OltJh7rErLklJ7JcUskGxxxcvUJQUEM/SKvxrkasRoqnw2ukPLiE+Q6a6Y7nL92iXPnhl6kzNXYeGS1XSFKX9C9O+hIsGxyCQCigA96vz0oqMjoXLSTR8U5jzJDaAsVcHqqoaeezPCsY0YTekOl89b3HqwomR0xR8NXsxYf7d9IKpazSWZ4zpaswRjCDtJw13DLmHp/W+j8fetLYSnRXp9eABFHFdWkHju8jNRgp4RUwbCaglbDWar5M+kN5auf7PhkFKi8bktAA64CN+RP2MjitAuqNrf32vCJTEDSa4EqhbR2pHHG6eBGjJsyhojc2+/Tny79k0EQizAy1fZNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(8990500004)(7696005)(26005)(8936002)(8676002)(64756008)(66556008)(82960400001)(4326008)(54906003)(316002)(33656002)(110136005)(76116006)(66946007)(5660300002)(2906002)(55016002)(10290500003)(82950400001)(478600001)(186003)(7416002)(52536014)(9686003)(6506007)(71200400001)(66476007)(86362001)(66446008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6Gxn64uwdUnPS8g1h2s48DhVz6W1H7Foj1N5bAsV7U4dGpZsS3K67WllmBD8uLhozTGhP4glXf5i9xcIpX0b6cefO+DNyWQ14JdRavOdgGmyURQwGDXIqt96DY0LumjeNy0A0ot15y+fshl0ACoDxu62x04Z28a9BZTshmSTn/OCPswqEG45GbU8xtPJ8NRrmTU3TVajSssNHznJiEbPGbJo1BHlfgpNEiIkNrLdhXznaTkz6naQEOEYcWAf083RIpA2oMo7YftzjE/ozy0UHkWWO0yXzK+sNATyNe2hbU00XsiIDKy+7Tv4cbJIAgLVqV4Z81EoOgyZprZccr3QCVUuYaz1pzBGoS8moHbRT4pMDUgY4gih21pECf/LNZ0sBTaRLdertGEg5XwB5auNbCjphBTYy5VrI5Z3wyx3neSVWQdMlSxVGe+fyp8dXigUHcacXUMT5HyvUcrmexigZJCHtqoB0A1qMY7uqnhrBUGr19COKZ2cdVcjsRuBrlsTIz3+p+lZ/KHuRUug0pmkGbrMuZFQBQJJKTn3pHzFfT+JIgDH4SrFVZUTumkjCx8tfuKA8if7FD8S+j454ZmqFLOR1wP8/XubhOlx6gp7O2yZ4Fpf/66IK/H+e2Incsd5Jf1/FeO37qHfEEvxlMTecfHEGo552L12Urd4JRDbHLlXweg3fch9Qsrd962Dy5z5xbTNrINQLWRG/FqppaFjjExAQMNJVTJJtQxtVoKKZ8M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a5f865-d5ff-45cc-c7c8-08d8c930320b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 17:13:30.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEWLTLBHjuKweXvV7UWq0a4uYFzDbrRGYK/YGmmjDI2d+fKN++Am9U/STAgfbZiO8U3qM1SO431YEZ3LlW3xwJZy6iBA0NTD9IfkApH/7fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:04 A=
M
>=20
> They are used to deposit pages into Microsoft Hypervisor and bring up
> logical and virtual processors.
>=20
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v6:
> 1. Address Michael's comments.
>=20
> v4: Fix compilation issue when CONFIG_ACPI_NUMA is not set.
>=20
> v3:
> 1. Add __packed to structures.
> 2. Drop unnecessary exports.
>=20
> v2:
> 1. Adapt to hypervisor side changes
> 2. Address Vitaly's comments
>=20
> use u64 status
>=20
> pages
>=20
> major comments
>=20
> minor comments
>=20
> rely on acpi code
> ---
>  arch/x86/hyperv/Makefile          |   2 +-
>  arch/x86/hyperv/hv_proc.c         | 219 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |   4 +
>  include/asm-generic/hyperv-tlfs.h |  67 +++++++++
>  4 files changed, 291 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/hv_proc.c
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

