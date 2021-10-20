Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D2434EF1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Oct 2021 17:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhJTPYm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Oct 2021 11:24:42 -0400
Received: from mail-bn8nam11on2139.outbound.protection.outlook.com ([40.107.236.139]:53089
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229941AbhJTPYm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Oct 2021 11:24:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJ/GZ6/DrhAuBwRhjLDfvMYW0cv40vW/2Z+J56dPm7BKGDQ/1M6iApU8yAGniP3teIIZ/01LQ6FUYuIDJhFmLgouijx/y/CUXjA3tRT9CTrhDz679y8vz/mVv76F+NTBdiaVkZAD76aF/DhSQ0B8CLbNOs1xeQQb2mw+DK0LSyKcGSDUW6aSrg84g82T0ip4HvMSYzU0AQh0QEhfqoUvL+I7mMFN32RpL9qzu0pSh76x8K7X8pqibg4PNEHUTbdSZ+btE/Ws/cEkcsMMTAlXoU1IkDNF1SLMzRi+e4RJIWq1TgEiro7dnG2JehrNkSLHjpMykF685BqLFdxG2ZMjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7AqvPUE5cHJt+XhtWqVHQhVenl1AUs8vF+5i8zG/ho=;
 b=h3BCGlhFwO6pwnNV70kbkGXpuOUuNqszFHJEcKxlr9FZDcj9OUU3UkJK3Z6EZvgLv/Lxfu/EeTHoGY/pUBmu3VSR8+o5NcjS+s1X/16QuTk+8VkwoxQNl0knmS3sSYwb/Qazdh/Z5GBxDGth3pXf3s9oTdBBARTsa7lKQ+1z6NdPPfx8rNFgVLcFB5uJNzCdRWzsh/OtlGWyTDIu9UmBskCodL5ZwsoBXcFZtGtMsx6jwngAcxdJgAfXs/4+oV32SvZ0zEs0YTqil5G0txrJEyJXmk+5Dvb4lTDXd15PzQcXnjcKt7OcS9OahkZBOXdQNo6BmEJkiZOKxH4Orlk/RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7AqvPUE5cHJt+XhtWqVHQhVenl1AUs8vF+5i8zG/ho=;
 b=YtR2dqEif7DtNauCmmvVS62s8iYzS+Zk7hi1Dc21mFRbfmhrGCPP3Zg1sg8jrPwX82dRXLs6U2UOoE4UduSm7UjzLWVJmOIhHwWoHHQsvD2Vn9L/68FFkwXbe6RKnDfxLxGtVZjQq4BWkvI7ZwrFzsZyi6n1oISPGkPKtj2YgPA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0863.namprd21.prod.outlook.com (2603:10b6:300:77::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.4; Wed, 20 Oct
 2021 15:22:19 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::240b:d555:8c74:205c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::240b:d555:8c74:205c%4]) with mapi id 15.20.4649.004; Wed, 20 Oct 2021
 15:22:19 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@linux.microsoft.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [PATCH v3 1/2] PCI: hv: Make the code arch neutral by adding arch
 specific interfaces
Thread-Topic: [PATCH v3 1/2] PCI: hv: Make the code arch neutral by adding
 arch specific interfaces
Thread-Index: AQHXwRPKcbHndDKDX0Oue2oQSrZra6vcCg3g
Date:   Wed, 20 Oct 2021 15:22:19 +0000
Message-ID: <MWHPR21MB1593BFB8A2A1E5C0DDB5DBF1D7BE9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1634226794-9540-1-git-send-email-sunilmut@linux.microsoft.com>
 <1634226794-9540-2-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1634226794-9540-2-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=436550c2-fe4d-46c9-a4c2-7df8893d2529;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-10-20T15:21:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e04ef6d-0db8-44dc-787e-08d993dd6879
x-ms-traffictypediagnostic: MWHPR21MB0863:
x-microsoft-antispam-prvs: <MWHPR21MB086302B8A59C2F3BF67C5902D7BE9@MWHPR21MB0863.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ssP5i6gAXsBgCl4tU4zcbaFpxd9ka5X8PvoFnWAmnDE7OlDkFgYhJ5HhOu4THgOyfLA2fVhYHxojgioleeNviV7ttXscnAMW4b0u4iPXHUlrQ2ofm9Gie9jcwsGo6pkNmDa7yzU2sadH/AXH0YhSIk45HF8ELwGSUAKfndRkUldtXd0pXXxgc0qZcL/ryiiPvayEps0YIcJPhQPWx+4hvTNvL4LpcM4Q8iMSjTRh2ziNlMJrBC9SwwIfx+9SCKP1E5r9w/owwn8kqdh2pDE2g8p1x2I/XBQW/GYv+AyypNngMqXVz01Dan+hQ4lS0J9xmv4xHGU+2x6ZROoz0tsqa1Uz4C8tRowwI7eh7qyereynvqPbg3sQBb3Re/q70zPmTUYOAb9eSQCkVh2/Q2DCSBGCudjfi8NHaLV1Wcu/5GxC9nyXbRhhi1iE3EtbVAUmfHm68Je+sCmGmmhdsrLvbVrR0tCEtfhyjaPSGAa9CNcNHUvUWj/Egayquf2mhxODmEz9Mn9MP5H8AFYkBTEBJAFvBkuJPlLhm8r6OdAxcf2bsCqhbApRfZvbJmk2RHcbEAuvv/OO4bpjocu0uKmUc4ISyaBAUz2kRLTfAUravW1qkbjYXOg8kFs6v5hDHMjIictswnb6Dny74ZZvoGAyjgzxe3ecSUKg9tTQYPqMRGyu5iUTe9EvQvDmcR9NAEb1ocy+gNh4qBaujjwggGqPywXRGZDi3WZG0JyYwpr3aCM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(26005)(508600001)(10290500003)(66446008)(8936002)(38100700002)(66556008)(66476007)(33656002)(7416002)(64756008)(186003)(107886003)(7696005)(6506007)(52536014)(71200400001)(2906002)(83380400001)(921005)(8676002)(110136005)(122000001)(55016002)(54906003)(8990500004)(82960400001)(86362001)(4326008)(82950400001)(76116006)(66946007)(316002)(9686003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xrMSzq/aQjITM+YTrImbVfG4at/Xar0PSvSvGLjQceO3n8Ly8w65KPZ1gxQ4?=
 =?us-ascii?Q?2pWxeuQGrCjqk9iJK8gaUdOck+cOUAB3UFY9nzhdUJPBMMWeACX5+SymHjgE?=
 =?us-ascii?Q?ANvGiLa9qni2CxJPUl2f2GTOVypO0SfJXeP4y+CsK+S+s5LZ5nQDAfNnp5o3?=
 =?us-ascii?Q?MJhVRRo++EVNGrCCYELz+9DGazC0fMA6HVcmbeAHHGuajTj8zAh1OvCGugNC?=
 =?us-ascii?Q?B3tb+e5xnUlNxMexvyLQBGHrmCEIH1co7U64L5V9Ml5EUI4P6+vVcrZpRyIJ?=
 =?us-ascii?Q?TtSGH+s9iwU8enOeN5eCKGIYiWlE6w3/ZRGGFM7R8XmwKp2XP6YgimANLFmQ?=
 =?us-ascii?Q?tEkAJxMFSmXhJ1vgcIOmB1/WF0WvBVC5SG+MQ2WQe3HA0Lw0m7UKIJINTi1G?=
 =?us-ascii?Q?fuPVSH/FhJieBnAVM4b398vwj+SrJnfn5R+LT/tZ1D3TkG7fZa6cTC35D141?=
 =?us-ascii?Q?OoFemJ62I+YFGvGUBgsb0GpxBFMzEswbRvoQ4Lj2gCYzE7rJIDgBqm5HAwI0?=
 =?us-ascii?Q?kPEP4t13e5a61KzRpEOBm30axlXy+bNRACbep7qF39n4zLOKl/Yc/ycLWDlg?=
 =?us-ascii?Q?fkEPkOWB/8pLzQLqicY3DrwAi7jc96ruELP9xcpv6IHMqbfI/HFjs9D1Yv/5?=
 =?us-ascii?Q?vmd7RW8FU6n9oVaTNxSrUcEm04SagYDP/GmOuIb1WjDvpRTiWjwFkHPg+Bva?=
 =?us-ascii?Q?IF7tN74mz4dEjknpoAPETgwSh6F7gkRzNdIor0te0KwjYUKALBQLZ/IKOypx?=
 =?us-ascii?Q?0gZYbaXZST6mDznkbUjcIFLX3Fz+7/ZpLx8/ZjTLXdS6J2oqbdnMbirDVQLE?=
 =?us-ascii?Q?P2YyjfZ9zXGLb8MnfTrqAYDeFytt+IZrNni0A3fXqTAz5j4I746SGU+W2oMq?=
 =?us-ascii?Q?kUvC0pRDLf6SqOlSy7obfOetnoOwi9J5JGd3E4nlkwm0Yj41hGrvdyrd8jIF?=
 =?us-ascii?Q?IlneAV19PePpEmuQaj75Tk7c9R9t+98336pd648VNMvLfkt/z5jfDxSvYEJz?=
 =?us-ascii?Q?DMKcgSa5QgC/RGoOWC4rGZPp88Fg8NS/uz6+6ZVG7yvmnvnZeIT18UidWn4O?=
 =?us-ascii?Q?XxzeVRengrjU7FB47wHpwMuFGVpMLrg+nVr9a00rnRqjQC1qt1Q7paoCftaO?=
 =?us-ascii?Q?YpZQnmOowfUwt4DIejwrw9Fzf5DlkM6U1CxnVIrWOCE1THxIyzo6aIh82XEm?=
 =?us-ascii?Q?leORpu8PPAABR1/oqTpUjHFogemSDRUZtPr2dCfO7uYBKvIVChZLTLfOhUbi?=
 =?us-ascii?Q?2xP+BqXufK5S81Y4SVJqYXjv51mYqcw4UL9z5MHK4JlO8OlRpS/npPjDoAIq?=
 =?us-ascii?Q?vvXuViCxyQaIUREEqXk/mUyQcMUBaXPJgFmzQukt5PICCfJhlEosCL5rLp00?=
 =?us-ascii?Q?giCLSQ0ImoxssDsYkGz699wTO9B0IAJCSAELoxI5+TihdVzZ3NbslXS31Tl+?=
 =?us-ascii?Q?VJw3IyME7HNz+usEmBPGbOtJV+IdCcbt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e04ef6d-0db8-44dc-787e-08d993dd6879
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 15:22:19.8872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mikelley@ntdev.microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0863
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Thursday, Octob=
er 14, 2021 8:53 AM
>=20
> Encapsulate arch dependencies in Hyper-V vPCI through a set of interfaces=
,
> listed below. Adding these arch specific interfaces will allow for an
> implementation for other arch, such as ARM64.
>=20
> Implement the interfaces for X64, which is essentially just moving over t=
he
> current implementation.
>=20
> List of added interfaces:
>  - hv_pci_irqchip_init()
>  - hv_pci_irqchip_free()
>  - hv_msi_get_int_vector()
>  - hv_set_msi_entry_from_desc()
>  - hv_msi_prepare()
>=20
> There are no functional changes expected from this patch.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In v2 & v3:
>  Changes are described in the cover letter.
>=20
>  MAINTAINERS                                 |  2 +
>  arch/x86/include/asm/hyperv-tlfs.h          | 33 ++++++++++++
>  arch/x86/include/asm/mshyperv.h             |  7 ---
>  drivers/pci/controller/Makefile             |  2 +-
>  drivers/pci/controller/pci-hyperv-irqchip.c | 57 +++++++++++++++++++++
>  drivers/pci/controller/pci-hyperv-irqchip.h | 20 ++++++++
>  drivers/pci/controller/pci-hyperv.c         | 52 ++++++++++++-------
>  include/asm-generic/hyperv-tlfs.h           | 33 ------------
>  8 files changed, 146 insertions(+), 60 deletions(-)
>  create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.c
>  create mode 100644 drivers/pci/controller/pci-hyperv-irqchip.h
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
