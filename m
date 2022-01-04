Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3084848F3
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 20:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiADTvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 14:51:03 -0500
Received: from mail-eus2azon11020014.outbound.protection.outlook.com ([52.101.56.14]:57594
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231462AbiADTvC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Jan 2022 14:51:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuzAQT71hJ46zyXsnEs0Ptr1lyDvwKHw3BJBq/9H7lSkdWdOHA0x/nqTyRWdO+Wfg9e68Wz7tYuGE/G3gZJychNKB1orB2NoVg78hBEmWs/QQZu+pNm5tuxAculW842IffnV5yum9kCrfpUBglaJkOoKpBjgitJvd7vbNL637Ek+gLGk+UJkJShnbVE9xWkN+dOXs+WBYCTgL1ZuBj1NxzgcvmFjhcsjLphkpi9VO0kdoOENTcA4Sa9urzjg6rzXmoIuIJ0G0D6/AvJKWtqhtZ7/Qad+tPLDQUDjJSlld7ZHWD4MqCQ/lavsYDr9JQ55mIhrOyyYdJdjwSoaLeE+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT7HpVD4zsdHlDQ+Nb1BLsvXxx+rsE5NbfOlM9sNlNY=;
 b=ifNPOk6gAfGkiDC2J76vdDfW2wRDXwzGJ8gCdKAITpOW+TUmrmA+34MIEfG6XJh0BS+qmce1WmEWVX4zqjIQuXKgfEZvQp2fyCvt41726rR3s0rrRGvu7fYLFPq5GpGehkuxUWtfIMrDj4nsoqa/o/x8yDMGnumQZ4Q6CDB9DaickQ8TRZ5kcvGMzfuf8aof8NPJ3jPeGMzcTeELdQfHcsSvXHqrbp4UCC5fUL1GtRwImPtjwwqJHrLBsMRFYA/aGVypuKQ8s/s3uM+svqKjL6gzrpqbdek7R9o4oo2PW8Qnyq4Nx+hG33AFfpvU4VDttadp6wBMurHV0bmqdo9BKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT7HpVD4zsdHlDQ+Nb1BLsvXxx+rsE5NbfOlM9sNlNY=;
 b=dvYHls2ab6pRskzegZSY3rwpgaoLj0IsV0e/AK9aleazhcvpwlSUityFtff8ge/60SfghqgMOS0iYukb0BGSAzKUfLwPiJxlVLavaSFkg/t2bgSXujaaDW+/WsyqGqWMoVcwaV7QglFfPMchXyPce7HKO/IlUrfr0FjlB2j6Ezs=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by SN6PR2101MB1328.namprd21.prod.outlook.com (2603:10b6:805:107::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.3; Tue, 4 Jan
 2022 19:50:54 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d%7]) with mapi id 15.20.4888.001; Tue, 4 Jan 2022
 19:50:54 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v7 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Topic: [PATCH v7 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Index: AQHX83dFKzW346rikEmeCnVJfdll/qxGoMFwgAy5eoCAAATPIA==
Date:   Tue, 4 Jan 2022 19:50:54 +0000
Message-ID: <MWHPR21MB1593B704CAA86AEC071A7D9ED74A9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1639767121-22007-1-git-send-email-sunilmut@linux.microsoft.com>
 <1639767121-22007-3-git-send-email-sunilmut@linux.microsoft.com>
 <MWHPR21MB1593272A454D568311C3B254D7429@MWHPR21MB1593.namprd21.prod.outlook.com>
 <BN8PR21MB11403EEA28B7029B32BB8B4AC04A9@BN8PR21MB1140.namprd21.prod.outlook.com>
In-Reply-To: <BN8PR21MB11403EEA28B7029B32BB8B4AC04A9@BN8PR21MB1140.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=16d6b1a8-2b41-4c86-a58f-b6b517debcd0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-27T17:04:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05371a7d-dc34-4b72-a738-08d9cfbb84fb
x-ms-traffictypediagnostic: SN6PR2101MB1328:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <SN6PR2101MB1328AA482DC6A58953B0888AD74A9@SN6PR2101MB1328.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JvcOITf7YgCQrEAUr4UIDOc5829Hkld85rroyD1RdUneoVUkJH5NVOTHNtzLm7XHuXZJVn0smVQJRbwqB5WRaixCZN1DHgjnsMQ6+an9WWhe86OQlqutK6h6iVE8m8pJ1q3PItBPSrWTybM6sGI3vHJ/Z2O49Xzxl9JiZqAMIT3+n+M3Nxf7lR4ncdHG7AE90knD/QeafEDR+ZnbGFB+iTDgCN6E63Vpxznr3wj4vsi3LQv6ne+RtIMHYfMdBhBKJcrs33UzuCWZtUai6iJ+G7w4hiKiBI+V9MR8SV+2yIV1I1ohXXHSfxvo45Peu3b0a8I/annq/5rPHW9he9ImJZGyDeRRUCNCgP5i4Wv+hB5pYjtPLRIG3rFsBYe0il/Wvcp9hkK+vRtraqpRPQRoHxfdD/GCZ19hsa1K9UPJuu9os8O3+8d39zp4OPs/uJ7cf7/PA8KnRxKl6Z9mziARd8LbzJbPne3v/157Gsk9WFAfw4oJQXxtvunuWVNY3/g6xs+HF3pkjn8Cn6OA4L4/adatnFU8TwcpeyjyTwb3wRRd2+Pe90Eeol1YIQcuqC3ZGTR4uvEpGZ4wpk+0bDqvEPFIGMXSqtZ7aAQaV6aVE+znNNzHI7F8tQEJ2KEhnCSroVEfv7w9tXvDYcLS8pQby9azDCP4LpDWEptzIByTLvvOtLBlEG+GXllbyTRevb4zxk4l1rByM6U6FdY3+3eRqAr2sh2vhVShmtq584t48FX7vAG3M4aDBm/PEqmc7kXu4o/fZHmsY2pRANVxYupwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(38070700005)(7696005)(26005)(122000001)(66476007)(52536014)(110136005)(2906002)(82950400001)(54906003)(64756008)(6506007)(38100700002)(5660300002)(55016003)(316002)(76116006)(66556008)(921005)(66946007)(66446008)(8936002)(7416002)(33656002)(82960400001)(8676002)(10290500003)(86362001)(71200400001)(8990500004)(508600001)(186003)(4326008)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Gl/kvm4JPGJ/+tprz/jY3Y2VqjX91RZzy1WPwHJcdzAhwCe6UFk3r/DzeNS?=
 =?us-ascii?Q?+ae9q1Le0WdulPAWq/JF2AdHuc4EafPHJSwyn1PZY6gHphXmnitEQBdz4NHK?=
 =?us-ascii?Q?Ick09CnEYL4ZVvGlY4bYkpkcTz8fZ7n74rRmJFH9EhuFzFhwZHY4bN0CRQzf?=
 =?us-ascii?Q?UpFylKECuNWODbBPqJDOXLpJGNmDkr0ULPG6u8x+0NAVfh7iePdjpOqdecaf?=
 =?us-ascii?Q?b/SZRP/Pry3WTwLnkURDNPpjGnomyqGLHWNM3cxYGrC94hCiCf8SFWY3QD/O?=
 =?us-ascii?Q?HBCc84WTy3DSvxVTE2T2gmIBSaHl//Exxhhp2pZ+k57WsDypyZoALU3tyigw?=
 =?us-ascii?Q?IL8ExHfwawpDB2/YVGatVXqVRGDKbU1SAAyjqoliJCjR9HtdNOyXu+EZNEQo?=
 =?us-ascii?Q?QvDzm4sS53p2FedrD+F947i4HCIbWCIwcul82A8L8L4Z4H0twQ3yTV+Mh448?=
 =?us-ascii?Q?Cwaenewftc9bCJPeL1JiRHxqneeklmmP25feFlz1IWm5nrjocb7oIUSwEEt4?=
 =?us-ascii?Q?GowkFUQhE6WJqa/wr1mGZotLt2mcRkcAsOVmUe9kuskXiF1byGJRW62yBa/v?=
 =?us-ascii?Q?2UXCHQUeBj72me62yFFr94hbw/6lxsLxUfOV5qKteOo21S8InB/T7mt3CoiR?=
 =?us-ascii?Q?Gg8WCFPC/6ZsikkE73GYy5e4LFyxBfjOu7E+nvauLZitln65oghb5zPyPIAS?=
 =?us-ascii?Q?jouixME0tPvAhM7qtPwCnXOYXmUNPBoEti8Vz1bVXCVK+L8Xx7QDCufcykpv?=
 =?us-ascii?Q?dS1i+3upzm624K6X7GhNGnzLqdiXInchZvD20f7X+ueMGg/X6ndfXni/fA9e?=
 =?us-ascii?Q?zH3UC5MGZrRop+XYFPDMjhRJJTY+Ud9lfm/3HoK0L/KF3BVlKkwqE6BBv7em?=
 =?us-ascii?Q?46KpWcoqsYHSBuFtP0zLk1O3zaGF18NGcA856UYTgGeKn00LWke7af8q4EDf?=
 =?us-ascii?Q?YYwODkbHjMxydCwevj0rZHgDvDKdEqtCPGTaXAYjkxaglbBsFlhqbHiMloMz?=
 =?us-ascii?Q?mgMFzdo2AZMOIPSjuNJlqYNR8/qCQ8HSo7mTgiONuYPK+5n5HGKX6y/2pqpr?=
 =?us-ascii?Q?3/JazbfmwTybRsW0VyU5+YuAjUUcw3lqNNAzNB13U7uLrCtROzZnourS3Htr?=
 =?us-ascii?Q?Rj6LP8wSJUAL4oykW790JUIaTutWTBauiIkHbk2i6xbeF3Qj+tNlBKbFpWL7?=
 =?us-ascii?Q?EYXZ51UAH8mDeMMQbhJZxPBS+L2XJ9Qu3cxN2yrVY5GkoSArXrz2hdVshfO3?=
 =?us-ascii?Q?v4C+dSdvfBZjprUoHKk7hZ4b+74WjGVb6ZbhsnnPM9B2sNFZad0M1qKDRINY?=
 =?us-ascii?Q?MBfF2ZoqaK2shIRmiF4iJNYzXjKIN77mbmwQoZIqiqv7UMfbhNrkEQbsGJNM?=
 =?us-ascii?Q?OIzxIdlzDn8TgBTDXJAopnwxmp5uPorI6XHfF8W+8gXIk1Bhw7A/d76tCroK?=
 =?us-ascii?Q?ValTawJ9JhwxQ3WaZL5czLs5QjTrYXUGe5dMsd3GzRrgpgH6o1kS/dVBLqAO?=
 =?us-ascii?Q?4IoovtTjfUOVQqznm0UkG+t46mGq55ixiQAg6uB7/DSXvEx0dNNy1eXCUl4x?=
 =?us-ascii?Q?kX5aWq+m59vQtvjf5pGrj+Eb4r3lw9ARZ+9Mo66+mDW8gwmK6xImarA3pLRg?=
 =?us-ascii?Q?hmo8C3YFCIQ4EzAbIlSanO/1XFadfk2JJyzORDA3f3xGN/XE3QJzzCXg/QX8?=
 =?us-ascii?Q?dIlIAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05371a7d-dc34-4b72-a738-08d9cfbb84fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 19:50:54.4854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxw92E5zvxpp/6EknXfZtN4F+LBpBx3oF6pPBJX7uGjj4ZEYK7nyXOGxnKQkHEhehQRdbe53TlvY/esiewbThgPHCT9KiQZ6oA5IbMWoa3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1328
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Tuesday, January 4, 2=
022 11:24 AM
>=20
> On Mon, 27 Dec 2021 17:38:07 +0000,
> "Michael Kelley (LINUX)" <mikelley@microsoft.com> wrote:
> >
> > From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Friday,
> > December 17, 2021 10:52 AM
> > >

[snip]

> > > +
> > > +static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
> > > +				       unsigned int virq, unsigned int nr_irqs,
> > > +				       void *args)
> > > +{
> > > +	irq_hw_number_t hwirq;
> > > +	unsigned int i;
> > > +	int ret;
> > > +
> > > +	ret =3D hv_pci_vec_alloc_device_irq(domain, nr_irqs, &hwirq);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	for (i =3D 0; i < nr_irqs; i++) {
> > > +		ret =3D hv_pci_vec_irq_gic_domain_alloc(domain, virq + i,
> > > +						      hwirq + i);
> > > +		if (ret)
> > > +			goto free_irq;
> > > +
> > > +		ret =3D irq_domain_set_hwirq_and_chip(domain, virq + i,
> > > +						    hwirq + i,
> > > +						    &hv_arm64_msi_irq_chip,
> > > +						    domain->host_data);
> > > +		if (ret)
> > > +			goto free_irq;
> >
> > This error path doesn't clean up correctly.  While parent IRQs allocate=
d
> > in previous iterations of the loop is cleaned up, the parent IRQ
> > allocated in the current iteration is not.
> >
>=20
> 'irq_domain_set_hwirq_and_chip' really shouldn't fail. If you still feel
> that we should address this, I can.
>=20

My view is that the code should be logically consistent.  If the
error path should never happen, then we can ignore the return value
and not try to do any cleanup.  But if we are going to treat the error
as possible and have cleanup code, then the cleanup code should be
correct.   It looks like the GIC irqchip drivers follow your approach and
assume irq_domain_set_hwirq_and_chip() never fails, so they don't
check the return value.  I would be OK with that approach here.

Michael


