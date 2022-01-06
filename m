Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9744485F7E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 05:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiAFEDi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 23:03:38 -0500
Received: from mail-bn8nam12on2101.outbound.protection.outlook.com ([40.107.237.101]:58136
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230171AbiAFEDg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 5 Jan 2022 23:03:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7KeJfXjP9sDBUadB38K08bk+LrQ0N4XL2ZZJVxEi22pmC57HOpCN0s+S5yRHCzwqxab6I0YdEinWTxJLjjLKHruFva08OPwOpXw/rY0V9tvSwkkNTA2pA9+24v5A+HdMePKAlguymAoPX49GkRDvaPcxHHpTMLMLDaFo9g/jKA0VmUsH2a+iHIy/EqfbNdahKo2Vgpbnh0rAVwXQ8reYpVgmbukNgNSg1Z+C9VLibEHEgS3Gpbb6bNbudLtt2ufGhP0eqtggIi7jYaM3r9InF3uWWA6Tz1xmVqn1C7Br/72JJwJglk3I0miJp86Y6lkEFykcPx0t4b2PGQY5Mxsrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WemVPUINwbwDHPV7BHVF1IROe2TgnhM+WEpLF8o6us0=;
 b=ccfKcGucbs+k/vzLpHE8hHxgfNDWVbzW5wkTG59Mqxlfd3aeAgdfYAELJckhNEAkyQKyalFl+C8bcpRW3wjVsuhkijH1reeNv7V9D6oNKBTcpGtUxqL+SOEPb+VfZ3uI2wGoW6eCG13ItHCu1nfrMxGfzg+ssOKFTGkFYeoUX6okN+tEFpJUfU+bH4z8+y7s76KEOMFtnD3DpCwEDl4uCQSKiwWjtFGqbmwZq5vuVPywejvEGMS47KrGavTDxxW1pY/5zZ+VU3HvBV5CVAQ/OhT0W2kONbBaeU8tZe2ZyknOjm8fjvIS744+6W+wd11ISkfXGNoR4dkeQnRYrRxirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WemVPUINwbwDHPV7BHVF1IROe2TgnhM+WEpLF8o6us0=;
 b=OJc/t46KMh1Wx8oKlWX25yqugr4BzlRIZT+xCR3eZqEd6rlDg2c3L50MfX7hYYH9YKIodbCtHt/GOe6/wzRROZgE6fRXUWVC/o7BV6OyRv9zvl5oHjqiVgwjl0NE0hh6hnT8GDnMJTmz9EmIRlBhP2bbsX6CqFxWQSdJ29b/0uA=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by BN8PR21MB1298.namprd21.prod.outlook.com (2603:10b6:408:a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.5; Thu, 6 Jan
 2022 04:03:32 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::50dc:69b4:f328:519d%7]) with mapi id 15.20.4888.001; Thu, 6 Jan 2022
 04:03:32 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
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
Subject: RE: [PATCH v8 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Topic: [PATCH v8 2/2] PCI: hv: Add arm64 Hyper-V vPCI support
Thread-Index: AQHYAmr+k7nCpnrr6EShNZxR7MUJOKxVX7lA
Date:   Thu, 6 Jan 2022 04:03:31 +0000
Message-ID: <MWHPR21MB1593EDD987F51B9613AC6BDED74C9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1641411156-31705-1-git-send-email-sunilmut@linux.microsoft.com>
 <1641411156-31705-3-git-send-email-sunilmut@linux.microsoft.com>
In-Reply-To: <1641411156-31705-3-git-send-email-sunilmut@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1a5432ae-4ac5-449f-ad85-6d1c0ec36f1e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-01-06T04:02:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7082a59-ae88-47c7-9477-08d9d0c98107
x-ms-traffictypediagnostic: BN8PR21MB1298:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BN8PR21MB12985D69AF7DC2129ABC2D50D74C9@BN8PR21MB1298.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GYFllQAJpjsCz91sStSbyqAjJULi8oPmiQhjmj5iJBu/OYfGnjkVKP6rUSUOQpRxRSyWlqLUoieGnLmt16o5BgCPhSOX6vV176/QmXE8Hwqau1ZUmoRPAIWIM5UhE+54FNQ64G61BJxxJLMb3Kh2r3yO37ArMnNHvGmzBMby6aj3TLhjiqRufE8VFq0f4MXqSd+wlsDn9u16QW2FMYQsOmX98JQ7PtoXU5JXmK6HuMc0w0QxxPCoOn2dlhgUDuIMKC0c/Gi7QqwWuHW4T2inZa+PRrZHeqgsveoHJ/Ulz08AvNtPkq/NvOuc/q50Tgb+djhHKsBnaJephQMyxSHp8FoI/N8uEICIl6UpOW09rmw4DBsGfwSbnu7eCsKsjt8IxBGz1uwzDKG4HjMA2bXEkQLuBKk1/2raW2BLV6RWmpeNbgRX/d+Nd4QqOOuj1Z/npANRm4kJDK60uz+geYEjnAaPwSj+EvVu60VD22VVJiSw+MIur3Cfx7ZD+suGNoP4GEymLXxCJ5oo++zmH0LDvazdmQvO9bfzybIt4ORYDMPZEMagaPDI2yRsCt1SmD333gieQxtkSAiQ5MMwh5a39YMhjDVr0qt/Jnyyd1d7RWZWsg6BuvSTNAmEWEmjNZNCbeiuXIUEwaiAZw0pztgteLu9QG9YBQBdU8DKu5QAlo060nhnrhANzC9PqUEFS6huy1G/fRm4Gi498t0k8JWwrUr6dyPB6bTRP22J8Gi3uE0KI5t+CKECItE4Fx1S8sj/vU6/HddeUghLVgt9foNcSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(921005)(107886003)(54906003)(76116006)(316002)(110136005)(5660300002)(26005)(10290500003)(508600001)(186003)(9686003)(66946007)(66476007)(66446008)(64756008)(66556008)(8676002)(4326008)(8936002)(71200400001)(38070700005)(86362001)(6506007)(7696005)(8990500004)(55016003)(83380400001)(4744005)(38100700002)(7416002)(122000001)(82960400001)(2906002)(82950400001)(33656002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6m2TTVFC9ppqqurauZhBGmJ+htfBVhl9qH3Rj0pSYtoMXO32OIesXfRRdDgQ?=
 =?us-ascii?Q?zlgqFoS3t+CFcveG9vUUHdyPlH2adaMN4DNWM6OTVcx8K7OOvvkrRwHT3TAJ?=
 =?us-ascii?Q?et7jvwMa1ioI2i7hw0qlnD1GLxIC29vCovGMvBsHi79i+u73vAfvGcph7S73?=
 =?us-ascii?Q?ASIXZPr5DAKXmVHkhrLve4mDl21GVSQ9FcWA1ogACb4momL+BWXEhpLnPtf+?=
 =?us-ascii?Q?7JLEBoZ1xLLL4aEC6JkuuRHcaxj83ZaJr8YkJvea1vleCSfDzstBNeW6gNJz?=
 =?us-ascii?Q?csl7pjr00TqEwTFPjAce6xsU+b6+Mje6aYPsZ7zAZ6pfUFMQMy2/xCVW+bXz?=
 =?us-ascii?Q?a/f6+mSAetK3dcmv3dumVMnNTttPNaKKDAbGjZgLFgWcEAlAvGRCj1yOOoRP?=
 =?us-ascii?Q?iqDtmQmDusFBUc1QKuRz4dXYh8nEUxE4qzoSv1L5UooGMQjYr6x5a84JbDTe?=
 =?us-ascii?Q?11gfnIdpHWV2f/PnjkQXICqMFDtF46RUCcVbEjhBMnOdUprns8RBsiO9hYLn?=
 =?us-ascii?Q?T2BOjLjtQfRSO5ox6BbdyWPKpxdqH1g3Trrlq8MybR5qz/zo9wGmnEdtAPs1?=
 =?us-ascii?Q?s+FX6MukA7B1d8u20SHWAklOpYPQDOtr+t0fOliqXPN0ka2LgIdoWPqMtMpo?=
 =?us-ascii?Q?DXO5pFWYmqREoLaXR0y6PnT8T3x9JPV266xMLO3G115WGWpKtH7QxrvS1baf?=
 =?us-ascii?Q?qX2J02ClmnIWvuspFK3mVwZvuXeY1kjpG5AFnMZVgyZyGF5NMk4VYB2mLIIr?=
 =?us-ascii?Q?8cZ8kAvlg3qTL1UvkE5updtQgPXySiJJP+PyXp8p5rKNQKZdPKWlZ3v2XR1z?=
 =?us-ascii?Q?GpBB7HhgplEiB7SDh1eRodRKQEe0nJlZ/t6ZAIMiqpHJfO2cxPsvwKAli/GP?=
 =?us-ascii?Q?sJfa7eLJf4JCpkxSwWTgl+qiydbI/+eMdakiZ5R7XadeUaxHZCBKMV9ntYkr?=
 =?us-ascii?Q?6n6tuRrHjhfMWlcCLfWhoYG0tjP94GWeZDSCSALUYQlS1rLJzpXPWHZPDUcl?=
 =?us-ascii?Q?o0r/MfEmpQdWdQlNI60dKXszRd/KUqU2cVVfqzJ0Gt3sQ9Yq5c8nktn9bt9z?=
 =?us-ascii?Q?yJe2nHjn14w5fqW5ZEiz+eePva/OrGQRs8L6a3G3EdZpYXhN08QN4JRh7fei?=
 =?us-ascii?Q?99m0fh6Ens/w/MsfUDEkDwC3iksuxH8p8yjCU2O1syGU3dVuZ8U5FH3lXYCG?=
 =?us-ascii?Q?6rxIFahimkCQmFhJlO/FS0zWZwHAjqosoUvXfxcfEb9ndWT7cpSg8D6szAIe?=
 =?us-ascii?Q?GfyKSCQVpVceRemhz9YZ3P+Uqydu1OgkmnB28Ih77Hq3v560G/+YfJSYd7Rs?=
 =?us-ascii?Q?H+UBr5SkGdtOESJNdMrwDLmV7nt0b6c01mRQNA47dYCUUwKIahNcs+1hTz0r?=
 =?us-ascii?Q?P1FiUPl9uFZ5V3JpIuTwSkHBmIpIcFTIxxs/ay9uG7nKINfRx2Qz5CgGfeT6?=
 =?us-ascii?Q?3l8v4+4FLK81ELGw4HipvuwC0zdwRhtJSMz46yjD2M6BcKJyPpaT0kq2fWiR?=
 =?us-ascii?Q?pU+L6x1MjJaU3GMmuS2BVtT7E+Js6+b0LS7g4t7GoKHGv/awCfFg5mEHMqZ/?=
 =?us-ascii?Q?Q3Jgw4a93hIJaP2r3OjA9mtX21L9q1c+Yx/piSnUi8OiwdeVaMV9JIMdcO9/?=
 =?us-ascii?Q?sJ1/yezdF6Ar2/DHblT3sbYK0SV18MZksVZ4iFn//q1LtkJ8vt+oCLRGktwS?=
 =?us-ascii?Q?wV5JcA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7082a59-ae88-47c7-9477-08d9d0c98107
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 04:03:32.0097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Qs/86zpwt4vlps0sCssxUILtok0K9SqZS2XzDW/sQ3tMK7SUK0VlG8TYcpALYNXjoJOLpoRRuJEQHiPDaZk2z5DZq+slDpagLTqhAO2F98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1298
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@linux.microsoft.com> Sent: Wednesday, Janu=
ary 5, 2022 11:33 AM
>=20
> Add arm64 Hyper-V vPCI support by implementing the arch specific
> interfaces. Introduce an IRQ domain and chip specific to Hyper-v vPCI tha=
t
> is based on SPIs. The IRQ domain parents itself to the arch GIC IRQ domai=
n
> for basic vector management.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> ---
> In v2, v3, v4, v5, v6, v7 & v8:
>  Changes are described in the cover letter.
>=20
>  arch/arm64/include/asm/hyperv-tlfs.h |   9 +
>  drivers/pci/Kconfig                  |   2 +-
>  drivers/pci/controller/Kconfig       |   2 +-
>  drivers/pci/controller/pci-hyperv.c  | 235 ++++++++++++++++++++++++++-
>  4 files changed, 245 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
