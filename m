Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED147944A
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 19:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbhLQStW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 13:49:22 -0500
Received: from mail-eus2azlp17011010.outbound.protection.outlook.com ([40.93.12.10]:39677
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240446AbhLQStT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Dec 2021 13:49:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDkjFHmeWvIRimg9rJ+CiZLn0MHaf8s0gOn0T2RCMYsm9WNUYy5xD5hvPUWZdsaU7xp9lrJd30olFjUr+eVlYeD8NCHhzPnf7ZwhIGDA03r17SmPeSckn6EF1D7VrMkh3mIFtgIvOmsO9LW82UhAV0M8DC/QibtB8zKufTAoDxOjIx4lH9/CWeBgcL2as3FJU6H/nx7gAXq/GLeHUjGtjsGBIAKmshj+6fXUOV8hJyJc6AGduacUogAZTDGF4/E8aydioCqPE8efh5bsAHAz9FJR72ioLKs8eCyxJbdpkd6difhMREIWiyMt4x3/hN4vNRFhfRy/hzTMr5mu7ZR5sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSSdo//AEn+gfAaFL5OTWXxtTzLzTi/vMZne3dVq42g=;
 b=nPkxLFAd7F5Q2X4674kQn8dNOHnAi08rSl83i/iqM7EU05emKf6gyaBO8SAvgQW226BuzYksMpuhbLzVPYILv76/l8qtvMD50//5bcd2S7VRmBzL72XcQcrTObvV9QzcYB3wp0uxsLi8YJaRjy87M+VU62nBWOUjshNnVfDG3UgTxGXLCIQuF8Q6qgCnNp2glH6HX5QyPhzXD6Cf3m0CpE7+04IVvjt8Zk6xI8JsYyN3V9/LMaRPlyq8sEY6EJj2X1ORpxvigm4R/bWPpru7OsNjBpg4Swmpbi/c9a5+tA3nDSgXDCppxu3ofpcUXv+wrXA3kVKhkURFtg7MpdGDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSSdo//AEn+gfAaFL5OTWXxtTzLzTi/vMZne3dVq42g=;
 b=i5xn1kNowRY9xKvm0YMC95xT3q9/pm99HdZJNQQmOxjv9FaHPN4x4LDK6n1U9tF12DvWDDxEDZYon/tiAHzg16QagV6Bj/QlW2Kn6OWZFMHoqTzBTdiKA8YwkGn3jNLbksYYwhOEyCBpWPCVuZKPa/LBB02imn8Z8WyqfLGdAR4=
Received: from BN8PR21MB1140.namprd21.prod.outlook.com (2603:10b6:408:72::11)
 by BL0PR2101MB1108.namprd21.prod.outlook.com (2603:10b6:207:37::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.10; Fri, 17 Dec
 2021 18:49:11 +0000
Received: from BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::b5b2:afd4:68e0:cade]) by BN8PR21MB1140.namprd21.prod.outlook.com
 ([fe80::b5b2:afd4:68e0:cade%7]) with mapi id 15.20.4823.006; Fri, 17 Dec 2021
 18:49:11 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v6 0/2] PCI: hv: Hyper-V vPCI for arm64
Thread-Topic: [EXTERNAL] Re: [PATCH v6 0/2] PCI: hv: Hyper-V vPCI for arm64
Thread-Index: AQHX3FmIBElJZrU8a0ijKx1N/lXuJqwz6riAgANIluA=
Date:   Fri, 17 Dec 2021 18:49:11 +0000
Message-ID: <BN8PR21MB1140A6EFABF87C0FBAA0606AC0789@BN8PR21MB1140.namprd21.prod.outlook.com>
References: <1637225490-2213-1-git-send-email-sunilmut@linux.microsoft.com>
 <20211215163503.GA698547@bhelgaas>
In-Reply-To: <20211215163503.GA698547@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=24b6de6f-3825-483d-b948-947bb6bbbdfb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-17T18:43:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d4d9dc6-cf22-48b1-339c-08d9c18dea5d
x-ms-traffictypediagnostic: BL0PR2101MB1108:EE_
x-microsoft-antispam-prvs: <BL0PR2101MB1108A05898ED87584B07FFC4C0789@BL0PR2101MB1108.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgIgHFpnQCViIrp1h2QIS84c9jpOJyTdcZs3xLNW3HNKs2DrYzfBD3vTytCb1E+kIEK1SRGVv7llyb2BxdK/+neiugNltXfZAtN9gDq/X/v+zjfv6wZvoc/VnL3xPMZhxYMcAXWNPKwQJGPSHj1YyjTaHRasHYdN3hre5nf5dbPEn1d8wBncxLm5aMj36fjq+Q/itJobPX9pU0dobwyHOQdo3O236+NHysMAPBLF8gFYVy7V4PO3vbKPBN1GFzTzwHgWs5m7QzYamPd4UbM0ydX8h70mCwjIbHeKVhE4PMTELE7h06m2/FSkH7ZIfs9hIWS6+3cUO/+pw8oIuNcNtvy3rupKEDObQTSlUhwUbvax0QBLtyLVl7XruIkJPYod1tM/1CixPVZE2yshnA/84XJr3Ib0wmQEMR9BNqqR1QvK/TrrChz4WENkL1A+IVqq2zgJ1K9codJAIBnGhETW93HQHs4W0iQ7u5rH8X0RsnzhrCNED0Vi+CWGfFS2OcwmPKr9wjyGjCBzgK45Lvoj7Dkate10Ih5pxs7HZI+UNmzyg/YGXtY01xyPWi1P4sTTkfpXPhm0ffdsMb8Qahrncp6Hvzqt4Q7UtkGtUuhOWnwMDgkXrYggQl4H+8fRiM3Dh89RSCDU9yv7CwhfpF6VxaxzXR+fHLCejr36xN/3DmVvgRCXJenwx6d4tSbyDilf6Tv7v2bzDKES135cfsOfcEMWmqzYouDMGUAAB8UyQdTJxGa9ynY5wGCh7xPhoAic
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1140.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(9686003)(86362001)(7696005)(110136005)(71200400001)(52536014)(82960400001)(5660300002)(38100700002)(66946007)(2906002)(316002)(8936002)(186003)(76116006)(7416002)(8676002)(122000001)(6506007)(4326008)(508600001)(8990500004)(10290500003)(66556008)(33656002)(53546011)(83380400001)(64756008)(55016003)(66476007)(38070700005)(66446008)(82950400001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3gsp/+3av7XGNlw1mmr7gbSWBaBVUQU9X170bb/W60vbZ6jGUzZP+cNgwAVb?=
 =?us-ascii?Q?v73FAntZu+6YRQgQC7/QzDXXWJnqNNgOJVoz7nPSyphXLngdLjHsC1PEe89I?=
 =?us-ascii?Q?nPH0DnL5FsCKaEIjQ26pANA/LwPfLlN2GpiHPCFzEjfWkGqIkDMR4/vy27Y5?=
 =?us-ascii?Q?PEvpnJnF/AodKNQ7TZSlgfC+OV9dbScr6jco97I095mI401fGsroSbjJifdh?=
 =?us-ascii?Q?+yU1A4kc8eBOYqCTaAzpTGmhh+c1GU/0DBC1F25u4nQ69xJLjfadpV0uSMyY?=
 =?us-ascii?Q?aTB3fU4a6cIgywuVZzSScRwWUNZhOHh1CAmf/+PlOI+iIpZgVHGJoEosZoHc?=
 =?us-ascii?Q?vfDcSiIKe7sMrLnbEcGTS/6i4Q7CO+1LerRHgU5aIc2BKBxQSzvaSBl2rsJ7?=
 =?us-ascii?Q?m5Rr77mXWIgMKJiyNoPPsGhyNnPhJAn8vj3XjhmOJuydbX8IueO0/I8JIQYR?=
 =?us-ascii?Q?XrX1vr5bCiNBbusTllHx9xidRZRB5eyHVcxFe5FOywZhVKN2qGn6f+X69+hW?=
 =?us-ascii?Q?nBA5e6K8HW/H2jR4dyldf7KcX7auukT8JspLuIEHZwFzCc3CYpPTZ+L6y9bA?=
 =?us-ascii?Q?7KSrvOHG7jNAm4Axxq3AhL+uNT1i/yFRWVBMxj1wczMRyD1DGBa/3/CyU2TE?=
 =?us-ascii?Q?UZwsrEX7WBjx4uNpvUm9VhuwRlfREde1rTMpZUzZDXdGRdDvdK2ZBJGjdYUR?=
 =?us-ascii?Q?lmWPIISHLLv3TM87ArYHv5VMoiQZi219mfOlktMpruTjtS55jfZp8H4lX2I3?=
 =?us-ascii?Q?aynftp7RQeesNKP2j1Rx3zQ+LoLKyYtoJs4uDYSKC6Bo8akz1HisyWaHpSZz?=
 =?us-ascii?Q?qsH5hO6Z/pEFxBUL5mLDYAnBEwUikAr6+axeVXhC1FsfUrrMSPsoxDwnQCMi?=
 =?us-ascii?Q?I8FHJ/ATv/F2SY4dXE1nRTWWF99GtNXHDARMCkI83FjwxhWawZE6grefhjxY?=
 =?us-ascii?Q?vxCFKKNuWQjmrDKlKMOfHURtLbZ+/iA+dEtSto/QtHSWZaUgeUbwzveAW3kc?=
 =?us-ascii?Q?LNu1W5Mk4dokdhFq03jeVkAvS1d5Xj3ajcMbzFzixqeCeF5J26Vnzaf1AYqR?=
 =?us-ascii?Q?n3UQVXQLqthieyaYmJKxFPx+xCWC2T9M4tqkPdu+myKQ34MKGEINr1Vuf2Rq?=
 =?us-ascii?Q?Q0eNtZZ9IUtAS6J1F97KlZKitJu9KzNZJhFQrUJsblMVV1XjpTcorD5C812C?=
 =?us-ascii?Q?d+1LCmhfFJJxgjb88JFWEqlPKL41NiWTnI/nXwSmPF/L0kYLEiazY6Fv5hb2?=
 =?us-ascii?Q?Ss0ajZyQQw9lMeJOl/HVNs4qcLQYEfKDtfBk79YAcHCjkw+hZmfYAkE+viNQ?=
 =?us-ascii?Q?hHs39CYZ2/jHedNvuRlT8JuV0o96ye4jjipvAojRejXVw4tODvjq4LEqZWGj?=
 =?us-ascii?Q?Btfap8G3+RH1paWUs0duDl8hOdlZutmAqNKgfStmmi3AwhxWdlAy1Jj6LFGt?=
 =?us-ascii?Q?E51QnHT8SUxEtU41GkTfXF4Uro1wj2F8WytMl5/yb8jOSnBgq8v9FwKEsVmZ?=
 =?us-ascii?Q?3QlBuSemukuMaLmNzQy8aUidvqAJkrmHHzykksdgT3SFzv0W1tYYKQ/4dLBc?=
 =?us-ascii?Q?Yvt60bodr26v8Tg2fy9kKlOL6vJ8fb51v/6zbJCvCIrVkIlatX5vnOS0NBGc?=
 =?us-ascii?Q?eMNYXCd9Y0vE7OvFsSdLkIVSYiqFN5qZBO/IDawBOWIpJoVgSE8b4xFCgE57?=
 =?us-ascii?Q?WwVMkYoWo0TiT+hznXqjAa7sw3K46tXhx97Zgz3ZOWkSC8uJOW1xGaTR67iQ?=
 =?us-ascii?Q?iTekjvZyZg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1140.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4d9dc6-cf22-48b1-339c-08d9c18dea5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 18:49:11.4262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6h82tc0B5uh1Qpq+ihz+iMwPJU9VxzZeKvcV3G7yB1cKJhfV5nekEnFxgl/JVudIzjspdd7S47vK5g9pPQyHfWrw+i9+QwZJCHew3Fmz66I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1108
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wednesday, December 15, 2021 8:35 AM,
Bjorn Helgaas <helgaas@kernel.org> wrote:

>
> On Thu, Nov 18, 2021 at 12:51:28AM -0800, Sunil Muthuswamy wrote:
>=20
> > Sunil Muthuswamy (2):
> >   PCI: hv: Make the code arch neutral by adding arch specific interface=
s
> >   arm64: PCI: hv: Add support for Hyper-V vPCI
>=20
> Both patches are primarily to drivers/pci/controller/pci-hyperv.c, so
> why do the subject lines look so different?
>=20
> Instead of making up a new format from scratch, look at the previous
> history and copy it:
>=20
>   $ git log --oneline drivers/pci/controller/pci-hyperv.c
>   f18312084300 ("PCI: hv: Remove unnecessary use of %hx")
>   41608b64b10b ("PCI: hv: Fix sleep while in non-sleep context when remov=
ing
> child devices from the bus")
>   88f94c7f8f40 ("PCI: hv: Turn on the host bridge probing on ARM64")
>   9e7f9178ab49 ("PCI: hv: Set up MSI domain at bridge probing time")
>   38c0d266dc80 ("PCI: hv: Set ->domain_nr of pci_host_bridge at probing t=
ime")
>   418cb6c8e051 ("PCI: hv: Generify PCI probing")
>   8f6a6b3c50ce ("PCI: hv: Support for create interrupt v3")
>   7d815f4afa87 ("PCI: hv: Add check for hyperv_initialized in init_hv_pci=
_drv()")
>   326dc2e1e59a ("PCI: hv: Remove bus device removal unused
> refcount/functions")
>   ...
>=20
> The second patch adds arm64 support, so it *should* mention arm64, but
> it can be something like this:
>=20
>   PCI: hv: Add arm64 Hyper-V vPCI support
>=20
> >  arch/arm64/include/asm/hyperv-tlfs.h |   9 +
> >  arch/x86/include/asm/hyperv-tlfs.h   |  33 ++++
> >  arch/x86/include/asm/mshyperv.h      |   7 -
> >  drivers/pci/Kconfig                  |   2 +-
> >  drivers/pci/controller/Kconfig       |   2 +-
> >  drivers/pci/controller/pci-hyperv.c  | 281 ++++++++++++++++++++++++---
> >  include/asm-generic/hyperv-tlfs.h    |  33 ----
> >  7 files changed, 300 insertions(+), 67 deletions(-)

Thanks. If I am reading your feedback above correctly, the only correction
you are suggesting is to rename the subject line of the second patch to fix
the format. Otherwise, the subject lines of the patches describe what they
do. I will address this in v7.

- Sunil
