Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62D3034AB
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 06:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbhAZFZX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:23 -0500
Received: from mail-mw2nam12on2136.outbound.protection.outlook.com ([40.107.244.136]:14048
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387448AbhAZBXy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 20:23:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gapo81IjsPgf6pES0CvZw1SH6kmFsyFt/n642KIWLxGJByBX1gRrUWAsyWiYXvzbZzrILWH4oOi7e7SZT7uxQbfhnWAw2Z4O7kPA9DhF73ioi67pTHZEvIf4yl1KfO9nt5G7n4FX+/KN8GY6cWcTkpPw0yoSKYDRDiH3gyZXa3S5xxlPbsu9N1LaEc1kl/DeLPY67goWx/6LUV7mrf1mnJATP1A+3LESR8lju6b5UUIBKOrcNbbs1qf1MQn05Gro2KQ9fI5r+w5Lr1TFiWicJrwiStdqUYG0whlpi2WLAUbp5UPMZK1HpKIhy+USsWp1ZGiq4SRfvbGEPSxRGFHziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjVe6hOj0cgr4Do+eH6LO1gUlHiW4G89pJ2Y2NQIP8U=;
 b=mNeTL/Dwh7NlIXROI65nQ+NP2aMHXWmbkXLxqy9vGYl2qM7lVusr/J7zSjtvUPvwdgn9Q6j5V7fEBvSDNcBUbAXw5aEsyM4kewBjXNGbRJdSfRwPOw+Kgg8aJzRFMlgBb4HyM1shfmIRxekvaGGH1fNB4dYS+AxuuxiMY6Vq5bxvf4CGXEVmgh/5eyMoJRRmvgQdjHeJydktcuNg8A3+q2Ez+D6YIpVSGjzeI761mBwhAiq/BJeR34dIgZGpjuDIyC63rD/9rGYsXbwCGmZotAPSOIVPqIgWl6aM7+aFEVoC8HtXLmUnolcpuhX3XWl8V9W4LUsq3RWXVyE22aXcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjVe6hOj0cgr4Do+eH6LO1gUlHiW4G89pJ2Y2NQIP8U=;
 b=JohllkHTOzyR2tdFs3wVRBQj9Lp1ncPJA9FFVbfRMk50GGE7YrAPPgPOec8XQw52PTF/7O2GdTfX8YMQ5Guy4UEMBcyUDwTBGNva02gs2fMplqRH8k/VB/VhEXkwTcLZY5E9dxzJmkcu0iTXN8RO3DMburtXE2XYp396DIChJRY=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Tue, 26 Jan
 2021 01:23:03 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 01:23:03 +0000
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
        Rob Herring <robh@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 12/16] asm-generic/hyperv: update hv_interrupt_entry
Thread-Topic: [PATCH v5 12/16] asm-generic/hyperv: update hv_interrupt_entry
Thread-Index: AQHW7yP2wwc4EqBA8EWKcKJ5oJD2lqo5JReA
Date:   Tue, 26 Jan 2021 01:23:03 +0000
Message-ID: <MWHPR21MB15936D273DDF0D6790DEE8FDD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-13-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-13-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T01:23:01Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=43a75e13-b0f8-4fed-acb4-6ede6cfd6036;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 892f0b97-8002-4d10-fed9-08d8c198ed75
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0873996A0573E06CC0909077D7BC9@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57+mykKnUjGGfqTNrl22h2nJLBxdKfuxtNNumVhfYSZwlxVNI3Rua03oUJfX23bKGBpzSiTa+zfCC8hUSDaogH7dnJiQZh9kTLuW/x0VW+2+gqyYx3qYpbskquHZymKs17+tvKF2CFa3/7wH40/L6LOQOM56l9osbP4c/w3tLdBAkF5mUskm+P4ZA77JEUthdPCxDwbVyjGs3cR7fR+UZrNjQXhTI3TpoYPAOEi3b/hT6/5nVg4FnMI410QM4KqYtPKGxuAH3GNzhpz/io4wSl93Vlxr31HLtAIfN9ZlXa5cYSqm5dGamdLjAW64ToQ5FlKj/hqZNxvTlC1qWvM4Smhh5Gy6uyXzfZBXrzDB+YDCNfFmqIysDxsV23SeUqXtcBnmiXyOqY39hu4Cbev9bPkowIR9h9qbRNQoG/7goBAzRD/FMcupbXUugADijT3y7OULOMGw8WZvKMSPd5LQvrk8r6v2RNExGOO/fnPam01E9xGiVBJZup8H071yXv6CMPEJ40UpWSUbcYRL6MI/86yC5Ca4oRXgUFDX/iKwUyDxWEFcmggNLXqXRqV/DMZe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(478600001)(52536014)(66446008)(71200400001)(55016002)(8936002)(7416002)(54906003)(4326008)(66946007)(76116006)(64756008)(110136005)(83380400001)(9686003)(66476007)(66556008)(86362001)(7696005)(15650500001)(6506007)(8990500004)(82960400001)(82950400001)(33656002)(8676002)(26005)(186003)(316002)(10290500003)(5660300002)(2906002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vHF2gMoEvR9KH/OHXAdgacc4r8wRZPtO2IogfyY6wRR10Z2N3QiW9rRSXC0z?=
 =?us-ascii?Q?Mb8G7o0linSUn35K6wG1mWks81fGbyLcVe0x34BRS/TOocPtKafLjFWi0vh+?=
 =?us-ascii?Q?nxtmpNiqZwKT8uv5SzUejyhCcYfANQrx6Ytb6QXcmZBwLBb232DVuI3PP6Lk?=
 =?us-ascii?Q?iBGeCLP/jkDl4hy4JTmB3w5TaHxyqSkv0Kw+SD6hIZ4F3IZPQYNPujkw3XdA?=
 =?us-ascii?Q?5toEb5byeK9raJVqdG1UvKuolh/U48USzMIlpWsXvmHKbnfNpyXn06t9/tv2?=
 =?us-ascii?Q?MhqEvRCFr28SCBuEZoUOjk5ShCA1Yb0n/TFZdpgjpyl60J092TPIle7pW28k?=
 =?us-ascii?Q?94n/y7297SnHMk2HmeoSKqOfKjAmMNHiwJWefk20AMCL7LhPA/fg39nmTfB0?=
 =?us-ascii?Q?ijFYxzflare2qM/gxH2pghC8MlTnTu0RizldknkrZFDP8FQM4iqcuq9X3soF?=
 =?us-ascii?Q?7bJdMzoRt4fJ4/sMepXOEUTOHp9EJZW/YcbU6zjkpJbrGAc6n+ylqCr4XnXr?=
 =?us-ascii?Q?qikxqvt28goN4mkAXvpuByToNQIWU19vyIDKADr8j3ph7UzNxhnPvZ8zjjRb?=
 =?us-ascii?Q?67W0Nmt2qPNHi1hiDsoct0BzVCjrZWOrbRAl4ed3kXsC/5XYkPpepACUYXfL?=
 =?us-ascii?Q?o0zA9eRHELdl3ctLUr3EJY9+SCJftH9z803815wcF9oxj1AGHZvohKYsFzCB?=
 =?us-ascii?Q?95QFJTbCYkIOZjHfbhdRDBxrEZdTC/1VFfUhh2Y3Rag6enP01QAHZTIQMyfi?=
 =?us-ascii?Q?wXEkl+dsUO7PKGqcnWofxyOggSwbjx4Nc2kE77M2dB5JquyHjEJ9bPMf2zyL?=
 =?us-ascii?Q?YXW4tIVGMnzSuokpxg7gdo1oM88SAs5BLGUYY4C2+sz8wwNcb+odmhPNFRwy?=
 =?us-ascii?Q?KeGJE4bgaX2ljBZbXlArbC67Mueo33gzlRRjzdS87Rt6eMq+C2kacsSfHhdp?=
 =?us-ascii?Q?r4hrsauHJwEjKI91UyTYoLDq5BEGEeXcyIVCpUuLTlVDaN29h6T+fVYoOtJx?=
 =?us-ascii?Q?eFwiGP1a7JLpEWRposUC0yVzpIxbbuLfwvfUlQDMp7uN03pf3A1Zlm7ihXBQ?=
 =?us-ascii?Q?ny+gpwYj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892f0b97-8002-4d10-fed9-08d8c198ed75
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:23:03.4349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENzL5vaoyd3JUoZX628AQtysewUIaYYfrfvjArl/So35WLUIIB1In/IanMkRJe3f2mqDGFvvJLHhgAMGrvIQZzdOTKGVufFZUaQeAKsDKJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> We will soon use the same structure to handle IO-APIC interrupts as
> well. Introduce an enum to identify the source and a data structure for
> IO-APIC RTE.
>=20
> While at it, update pci-hyperv.c to use the enum.
>=20
> No functional change.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c |  2 +-
>  include/asm-generic/hyperv-tlfs.h   | 36 +++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 6db8d96a78eb..87aa62ee0368 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1216,7 +1216,7 @@ static void hv_irq_unmask(struct irq_data *data)
>  	params =3D &hbus->retarget_msi_interrupt_params;
>  	memset(params, 0, sizeof(*params));
>  	params->partition_id =3D HV_PARTITION_ID_SELF;
> -	params->int_entry.source =3D 1; /* MSI(-X) */
> +	params->int_entry.source =3D HV_INTERRUPT_SOURCE_MSI;
>  	hv_set_msi_entry_from_desc(&params->int_entry.msi_entry, msi_desc);
>  	params->device_id =3D (hbus->hdev->dev_instance.b[5] << 24) |
>  			   (hbus->hdev->dev_instance.b[4] << 16) |
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 7e103be42799..8423bf53c237 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -480,6 +480,11 @@ struct hv_create_vp {
>  	u64 flags;
>  } __packed;
>=20
> +enum hv_interrupt_source {
> +	HV_INTERRUPT_SOURCE_MSI =3D 1, /* MSI and MSI-X */
> +	HV_INTERRUPT_SOURCE_IOAPIC,
> +};
> +
>  union hv_msi_address_register {
>  	u32 as_uint32;
>  	struct {
> @@ -513,10 +518,37 @@ union hv_msi_entry {
>  	} __packed;
>  };
>=20
> +union hv_ioapic_rte {
> +	u64 as_uint64;
> +
> +	struct {
> +		u32 vector:8;
> +		u32 delivery_mode:3;
> +		u32 destination_mode:1;
> +		u32 delivery_status:1;
> +		u32 interrupt_polarity:1;
> +		u32 remote_irr:1;
> +		u32 trigger_mode:1;
> +		u32 interrupt_mask:1;
> +		u32 reserved1:15;
> +
> +		u32 reserved2:24;
> +		u32 destination_id:8;
> +	};
> +
> +	struct {
> +		u32 low_uint32;
> +		u32 high_uint32;
> +	};
> +} __packed;
> +
>  struct hv_interrupt_entry {
> -	u32 source;			/* 1 for MSI(-X) */
> +	u32 source;
>  	u32 reserved1;
> -	union hv_msi_entry msi_entry;
> +	union {
> +		union hv_msi_entry msi_entry;
> +		union hv_ioapic_rte ioapic_rte;
> +	};
>  } __packed;
>=20
>  /*
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

