Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BE5303149
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 02:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbhAZB3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jan 2021 20:29:51 -0500
Received: from mail-mw2nam12on2095.outbound.protection.outlook.com ([40.107.244.95]:54880
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731988AbhAZB1j (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 20:27:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMGa7RDlKYhO50TVmxCH47YJ/bjO85nzGEMv+cb9HwBr5WMuM62+JcSkZS5AsBDBzLo7eORubgaI/uwcb0iJe0QSDPcmfEfTqcrT3rYt5itSX8XEUla51R0BTGnhuBZwyiVE/LayXXuggeCqKkDReIiR+8jf4+pqgt9MNAWPcMvzK4aZLvEQSZOsagjFEe3ouU/9zo4Bf2nNpXY+vWnC7B2VfPVm7Zn2BieiJ3lKREyKvDJkvlffLOrfQ3h+nWULA/pR031DBSfg+kf8Di4BRx8rkNXV33ygP6D0RpjPtV5Q0A2ZozM5q4fJibtrfH4DIJdyU4DLgKEEflA5yUsmag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DLSqtnhRJ1rUItyAjVlBeES3/Mu/Swkj0yvgUkIZwM=;
 b=ashtEVdNUcR73pKi/LQzyPE9ZQfgOi6CPdWB1sn9ROuhusqqLaEa0dLNR2q0ZGjNMBbfptY9YiJQZs3kMtZOgtxeIx87QxcDSbw6ZumLftLYzoHnIsvUIxWnWQ06mX99ZGqs5Dc5FuOzySEw5k0hxlKi1ISGk0LlFQLSAdOQvbJNJZ167ZxlOmHvJvej//8rIPQWHuU+VnXPQaxLcJtJYX6T19LPFd4aubqmUjTE+maqY9jeFOcUkWU/TE5q3dBYnGsQvp6psPgRlIAzPtfh5U2sTZtgZ8cVwUxuYAeiN0+rpkbkuYnkUXZB8RQSYFHShL7XSoWh1Xxl2y1Sgpp4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DLSqtnhRJ1rUItyAjVlBeES3/Mu/Swkj0yvgUkIZwM=;
 b=SDPU6iA3T+3tZWnDiBqCe46CMaMkIsxYOAuUyEgSp+3tJmnLhnjAQLnYV2kY21GN41v4+IaHIofnEeMn+AO0cASOZ/LqpqSgy5hEeu1dnZK21r2fppO5rjGIgiTYdkafQSz4bEOazB6BVA4Jl+y2T9tp0/aS4MlSA+hWfryEKQA=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Tue, 26 Jan
 2021 01:26:52 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 01:26:52 +0000
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
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Thread-Topic: [PATCH v5 13/16] asm-generic/hyperv: introduce hv_device_id and
 auxiliary structures
Thread-Index: AQHW7yP3XhY0LOeCcky/eXuYzxnTqao5JVQw
Date:   Tue, 26 Jan 2021 01:26:52 +0000
Message-ID: <MWHPR21MB1593959647DA60219E19C25ED7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-14-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-14-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T01:26:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=78c1268a-4d54-4cf6-9bc4-8b87c2748cda;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89abe313-6617-44da-4471-08d8c19975ea
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0873E456B5BEEED05CE80387D7BC9@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eighj0E2hlOWgQtZhKr/KTtEkMcLVkW9FlDv9JelZnZQuKYLN1klge0LaTozmZHGUTjG+uE9oXuHdMFW8agPAXpkduFakmlDGXiRzfbkYiX7JDxBhrvDDZhyC5aX8XCvmruKWZuoDNOViPAKQVUpypt6kN1v2k70wxPnFa0dZsMSCsJj+qh1NPeZg+LYj14iCIScz8lVofFE4HccMYQXt+trj1IzepWp6F93QXDseInc0EjlsuzWLyX+q3Qe4kFbgxRmwelMdGD5e6/f1KJtxSD+qgdJszNpDlbphUb8ncwEI4OjX0k+iX/uFEricCkFDhDVMxa7Sg32tftUuIeN8c5lcnZeihe5zPlBYR6Gt3q9dEqEk8KTcWV7QV8o/2gnqdpghiRHIvNJOZA9k9II+Rd8JCNdoEMY/aiuiH8VizLK9s1sJJ7u0VYqKolQ2m9mzfCU050Uhbx2FiwIZGKodDXPUv1xk5RYIK3HNtkEFava/O2Kg96U3gkhFhhVIx/G5xdGMQ370hHMFnLVtcTlXGF5dsabHdyIq+zaR1kETuxuhGVfP4RdCu1SklqeB3Ob
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(8676002)(33656002)(26005)(186003)(86362001)(7696005)(82950400001)(82960400001)(6506007)(8990500004)(2906002)(5660300002)(10290500003)(316002)(54906003)(4326008)(64756008)(110136005)(66946007)(76116006)(66446008)(478600001)(52536014)(8936002)(71200400001)(55016002)(9686003)(66476007)(66556008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XSlXXf2WpMzmOQCIZjFYXaKN1s4dAD5A+t0wVuuHuSnuSaK0DF5yRVe1QIOu?=
 =?us-ascii?Q?iY3oH8G++cmoivsZuOqqgMwP21A12au9uV54SdYcGKYn03DLygqXLH5cwG3Y?=
 =?us-ascii?Q?TFAQnJN6YXDMTbF3jUWeXs6c/mYRNEzbFbPrdKZjkJTxYu5UnL4sQgEyC//0?=
 =?us-ascii?Q?tM3wx2HkpxmMJgErYnkPFoln5TAZfCMuOhfHjgARfHyS/FkMDJUVPeYdMZ/t?=
 =?us-ascii?Q?G5t/56wpWcYOQuBlHFVeFeMVwZJKTRbSTS8cZwYrZxOxp4KNbUyHHx5EQvAx?=
 =?us-ascii?Q?ZFAmhFkWAIskfav/pa7R1U8FCX0vNsuaw+4CTzHeDy1JhFlQGK5Oj9WoRXW/?=
 =?us-ascii?Q?8ju3Uq54d0/9qMW6omE11O6s7lSyxnsCZfiVYer2RhiU7Y/fFzN7I0AgA7t/?=
 =?us-ascii?Q?luZAogbvwhaVLvHGmYHQdFc5WL5UHKQNDTwtfzoGzU3QEkvPOUEWdZ8qOu7c?=
 =?us-ascii?Q?9BYV+lRSLFm6Ww1wgYg4CRBx+6hea1UgC6KXN+aum1cSHMlra1o1vjbWFLPx?=
 =?us-ascii?Q?mOHlcBbKVwRmcDwNCK3DTaBcdOl3RHtZOy9+hkbIbD8hUb64J49/9Ks5hMKI?=
 =?us-ascii?Q?uLlTb26xTfjxjiuRJgY/g3KbngjwLC0IxyxPF/RAx6E9mZ8ZTHc57UMMHHRr?=
 =?us-ascii?Q?Hn8nkcW4NuFz5oqxIrnjEYnNUsa95kC11dVC83hmaNw4l0g2Z1y4roRFnnOp?=
 =?us-ascii?Q?Ozt2woh02hrUL7VhwhjRmUnZf15U/T/B1zssnhngbYeM2CLq9Ku6Gt521EOW?=
 =?us-ascii?Q?2hnw+a5eeiiGGiD/VWdygLbC/npDzLXT6ZJ4SKe32rEqWQO2uF5j9QfCf1C0?=
 =?us-ascii?Q?tO8waNcirNMh2dQ64v+eOYHFOXhFy+IdEt9upzWlT6g/OsW/BR1DECnfv/lA?=
 =?us-ascii?Q?0x1BsBDaO5Dp87qO9njlDR/qOPkCZW/C7bS7iZ6dW6jIF/R971mWtipMF43W?=
 =?us-ascii?Q?uWvlZC/06q+vOm3RWUt6U3MB2Yrwy705Sw6FkwLSzpyln5Nw5KR6IgFid4CJ?=
 =?us-ascii?Q?yINRNEgXNjL2MvxzELfWFtSNZRNNljMjmULNr4OEqp0KLdZa+pZniatwNCNa?=
 =?us-ascii?Q?H13V5QDB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89abe313-6617-44da-4471-08d8c19975ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:26:52.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BLTiBqPNkCSsG9nd4hLk+zA96D0H+cTyNvBpEAgXfkjhNArSyBZG25BAIAkgoHzWrbVw1FbsfNeuMrlcQtSDfoLsW8dZ3fUOrk80uy8lpAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> We will need to identify the device we want Microsoft Hypervisor to
> manipulate.  Introduce the data structures for that purpose.
>=20
> They will be used in a later patch.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>=20
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 8423bf53c237..42ff1326c6bd 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -623,4 +623,83 @@ struct hv_set_vp_registers_input {
>  	} element[];
>  } __packed;
>=20
> +enum hv_device_type {
> +	HV_DEVICE_TYPE_LOGICAL =3D 0,
> +	HV_DEVICE_TYPE_PCI =3D 1,
> +	HV_DEVICE_TYPE_IOAPIC =3D 2,
> +	HV_DEVICE_TYPE_ACPI =3D 3,
> +};
> +
> +typedef u16 hv_pci_rid;
> +typedef u16 hv_pci_segment;
> +typedef u64 hv_logical_device_id;
> +union hv_pci_bdf {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 function:3;
> +		u8 device:5;
> +		u8 bus;
> +	};
> +} __packed;
> +
> +union hv_pci_bus_range {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 subordinate_bus;
> +		u8 secondary_bus;
> +	};
> +} __packed;
> +
> +union hv_device_id {
> +	u64 as_uint64;
> +
> +	struct {
> +		u64 :62;
> +		u64 device_type:2;
> +	};

Are the above 4 lines extraneous junk?=20
If not, a comment would be helpful.  And we
would normally label the 62 bit field as=20
"reserved0" or something similar.

> +
> +	/* HV_DEVICE_TYPE_LOGICAL */
> +	struct {
> +		u64 id:62;
> +		u64 device_type:2;
> +	} logical;
> +
> +	/* HV_DEVICE_TYPE_PCI */
> +	struct {
> +		union {
> +			hv_pci_rid rid;
> +			union hv_pci_bdf bdf;
> +		};
> +
> +		hv_pci_segment segment;
> +		union hv_pci_bus_range shadow_bus_range;
> +
> +		u16 phantom_function_bits:2;
> +		u16 source_shadow:1;
> +
> +		u16 rsvdz0:11;
> +		u16 device_type:2;
> +	} pci;
> +
> +	/* HV_DEVICE_TYPE_IOAPIC */
> +	struct {
> +		u8 ioapic_id;
> +		u8 rsvdz0;
> +		u16 rsvdz1;
> +		u16 rsvdz2;
> +
> +		u16 rsvdz3:14;
> +		u16 device_type:2;
> +	} ioapic;
> +
> +	/* HV_DEVICE_TYPE_ACPI */
> +	struct {
> +		u32 input_mapping_base;
> +		u32 input_mapping_count:30;
> +		u32 device_type:2;
> +	} acpi;
> +} __packed;
> +
>  #endif
> --
> 2.20.1

