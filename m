Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54CE304995
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 21:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbhAZFZd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbhAZBcX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 20:32:23 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::71f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C97C0698CD;
        Mon, 25 Jan 2021 17:22:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcqiZsP6PKfa8SB1pp+xfBK22pS50jNp0Ytehi2+AV0iZV45G+9ax16nVFIJC3lRgo+P69MkSlA8ma7HXUHTp5S2/btke+xniLU5ioMubHeCA6W5312yUFOF24+9OPk8QOkteGo3t7mEDVHrGnej36J/4iz+oynlXTfN/ZsrGJQZmfi9AVuhRLLYDIfEosPCNvcjjTzbNNYf7bgKx9OscVctQCVpoYkGXTS14wFrQfE0LEZBrPuDmLMvQVIikPtlhBgpYEOpxWGvLuioYMkmkgjWCtD8sbXkJEiMZgAbRP3izmm65uIPPCX6dhroceh/ORkzwKKBWJ4r7INkt4EcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX/hGgumZ/PzceBmuA/w3bmhqMpAGJembZU9oI6HysE=;
 b=S00BqOsie2EeV4jpjb79Z9i7yD7E72+0B7BgEFzoLZlRH1q343U/DZOp7pfoIsfHBoLh49CjqxCWCO680ph2D/YU/6ICVN0WqKIWsie6vfptcmOJ1iJrzH37bK7sgZ1DR0rpNLUArDmPHu5B8WZbu/2XckG8DNtjOudlkCIRwe7ItwQ8a7ZAj61cxUY4QzALpLO+0+4Z1VHuR/PlgUyBjwiWZqQRu4m4Hwusbfwm4iZePZVXmfGBpZvyGfMLYLTDP1qQE+M+ISWKl7YFY8jZqaM2YR4moX8TVNLyMxzv5JaHzlcKh6Qj2x4GqKU/oBlgwOpHiNlKOLguggT1+hwCjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lX/hGgumZ/PzceBmuA/w3bmhqMpAGJembZU9oI6HysE=;
 b=cD9d6WMH7FJp0aYF3WjfZLCKp1Lph2e3tZtes92aAvIRb3lH0QssuH+oUpeyII0jet+qTZgtYIG96c+F3JxwDoYWaP2jW1zYje5YumAKFE3tUaBtR796b3cgiJg2I81jVxxKyB+55rORgI+u6qszJa4LW09sXPArwj39IcxcT80=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Tue, 26 Jan
 2021 01:22:10 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 01:22:10 +0000
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v5 11/16] asm-generic/hyperv: update hv_msi_entry
Thread-Topic: [PATCH v5 11/16] asm-generic/hyperv: update hv_msi_entry
Thread-Index: AQHW7yP207XtrKRjgkqkN3kDOaxu3Ko5JNXA
Date:   Tue, 26 Jan 2021 01:22:09 +0000
Message-ID: <MWHPR21MB1593A7574C6F05858C7DCEE1D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-12-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-12-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T01:22:08Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=efc6fad5-d6d6-426d-8944-e00d52b8c29e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edc3c7ac-1b67-4bf5-91b7-08d8c198cd83
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0873F549F24FAA9112FC9D64D7BC9@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MSkzifEV8vpWMGyH4vzB9K4AGDDuWiTNill0CLOhx4Ey0XQ3N0Q5L85kvK7JaC7uMod+4MoSe/oUL9rTmtmXL2t57L1GYMA0gYg6FuE7gGDJxl4vpIIstdOjQbJQ9gJc1ZkJveIL3MnmOwOU/hAN+nlYIVHjjUb+E+pGY8mVYrExG7diq/DjefYtEsE2Lb7pfHtUJs1bK7h4xjaMYrVjZRnMkW0J9+haM72FgVywgz6iI2pbfIVDSB15HiWEstlSLHt5K+H7wyjztGHdfSK/BSi9WYdKg3XSZHorrKQ0aaMVbMp76uZaknN8/x0foFM+TDnDLdHasKWE24qcEbEc6JUrZi4nDH6GKQ3fcCSNyB81tEe+z7ODbwsoplESBQYBxbDzVoAAtRmDh6BtBl6aJkxTFViRtiAgQ1X9EtBWgqPaZ4c5pxfGQAmfBBlOedtC79soOS/fj0hSkZf2dJ+fw83CX0P/Rro7jD3MWCm3ja2Qyc3Qt4RQPvL+xiaGawvyPlNrhPeCKRx34kiYeDE/gJe0sdRB5v6wS6fYKczveVST9asYukyMKlvmtfwnaD2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(478600001)(52536014)(66446008)(71200400001)(55016002)(8936002)(7416002)(54906003)(4326008)(66946007)(76116006)(64756008)(110136005)(83380400001)(9686003)(66476007)(66556008)(86362001)(7696005)(6506007)(8990500004)(82960400001)(82950400001)(33656002)(8676002)(26005)(186003)(316002)(10290500003)(5660300002)(2906002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8nhR8qRN3JB7L4FPm9cArUws2554Hu7NhZEyhrEZZC1EUFWGuMw8dx4SFBge?=
 =?us-ascii?Q?10NiCVwaAMz06MjKnFNx9TlBYdsvXdx1yrU89rNRfX67OS9WZL6jYrfrIqVx?=
 =?us-ascii?Q?ALM6sqWZeO2uOTYD93jMVj6z5yt3hXA6PtD+rNP0p1qRoIefiPDRY9fR+8hK?=
 =?us-ascii?Q?CeXDajUdU+wb17UdqYnswIIqxckjH/BqGWNr9mrycfBewYHwHG9YpJij4cNd?=
 =?us-ascii?Q?T65ZpI+7CgGtoKe2/x2z0kOBKbjxooLMYIcxzGo97d1LNTSgjssHeB2I7Qob?=
 =?us-ascii?Q?bo5dYJdGq80R2geODOpGLROk3blj4BYM4pVUPUMcHZ14hDjgX7Ajpv5GTeVN?=
 =?us-ascii?Q?Wwruwil6Y7reoCiL56W+p0NmuJE3Ex9Fu53qUGba4TVchfyANiZMjivaUHs+?=
 =?us-ascii?Q?5ukG+aluUW0R8qK4qkJuZHmcvlGgzZTIY3d1jC6fIRqTtzfPK+qS04lJ6zJm?=
 =?us-ascii?Q?04xmrnYzI8T86yRDubZB7kjKXCiW6KfoVeqS3GZt6c3kcy/0Z7bE+XCFedup?=
 =?us-ascii?Q?K/EL17HZcABS18y9gCFFw8ijs+UjxUfTAw76AHn6ExVGS0SSz3RfnofaOQat?=
 =?us-ascii?Q?ETs/XFKcO1vsIGHcuD4EjgUcKZwK1iPWsahv0s3ItwqbeH/yS0s+rZTYzlp1?=
 =?us-ascii?Q?KO6GeFrHoj5coBCJ0lebsSgRIo5k3fyXOl/Yf/TgTej2LTlNesasNibxKHVz?=
 =?us-ascii?Q?xJ3QZXJoqXRrnZivLM+9p1jUc/UsTMgigq1b/uM4YFLy2Lr/n5ydhS1F7nml?=
 =?us-ascii?Q?6/Nj4WFW0lDrhza07jGE4ZkzjF3xsH2eV0kqUROUKSX9NCnlVtQqFc4itm3c?=
 =?us-ascii?Q?ybeGCAF5AvXN/lpkkylqlT13YzMkXq/Og02UKfEufhZbE98V8MNpn1fxCWOx?=
 =?us-ascii?Q?kME9RKeXsgU5/k5osgSq0AOW5VL/NeKYJxA9kTto4+1PipP1Fl7cp352JH5z?=
 =?us-ascii?Q?GVyYCmJJd1n7LjmGWyCCRpYyry2xgqDm8+LZ+sxv4L+y4pyLkIa0B8h+kzf4?=
 =?us-ascii?Q?dD9fru5Wh3h349eyd/giD5yYY8eqjmvH/BoyewIlFYxRrFBaXtVwI4/IaAWl?=
 =?us-ascii?Q?GZ3vaHFQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc3c7ac-1b67-4bf5-91b7-08d8c198cd83
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:22:09.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOSeh9+p7I3W3JijcvUYnqv24ShEJeNiFkpzmJul9RRfRKD1DTM6mP/3iV07OGfm21Sz1vGVyT4nVDwODGfA7dKrrArUjKAM7ocS353HBFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> We will soon need to access fields inside the MSI address and MSI data
> fields. Introduce hv_msi_address_register and hv_msi_data_register.
>=20
> Fix up one user of hv_msi_entry in mshyperv.h.
>=20
> No functional change expected.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/include/asm/mshyperv.h   |  4 ++--
>  include/asm-generic/hyperv-tlfs.h | 28 ++++++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 4e590a167160..cbee72550a12 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -257,8 +257,8 @@ static inline void hv_apic_init(void) {}
>  static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_en=
try,
>  					      struct msi_desc *msi_desc)
>  {
> -	msi_entry->address =3D msi_desc->msg.address_lo;
> -	msi_entry->data =3D msi_desc->msg.data;
> +	msi_entry->address.as_uint32 =3D msi_desc->msg.address_lo;
> +	msi_entry->data.as_uint32 =3D msi_desc->msg.data;
>  }
>=20
>  #else /* CONFIG_HYPERV */
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index ec53570102f0..7e103be42799 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -480,12 +480,36 @@ struct hv_create_vp {
>  	u64 flags;
>  } __packed;
>=20
> +union hv_msi_address_register {
> +	u32 as_uint32;
> +	struct {
> +		u32 reserved1:2;
> +		u32 destination_mode:1;
> +		u32 redirection_hint:1;
> +		u32 reserved2:8;
> +		u32 destination_id:8;
> +		u32 msi_base:12;
> +	};
> +} __packed;
> +
> +union hv_msi_data_register {
> +	u32 as_uint32;
> +	struct {
> +		u32 vector:8;
> +		u32 delivery_mode:3;
> +		u32 reserved1:3;
> +		u32 level_assert:1;
> +		u32 trigger_mode:1;
> +		u32 reserved2:16;
> +	};
> +} __packed;
> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;
>  	struct {
> -		u32 address;
> -		u32 data;
> +		union hv_msi_address_register address;
> +		union hv_msi_data_register data;
>  	} __packed;
>  };
>=20
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
