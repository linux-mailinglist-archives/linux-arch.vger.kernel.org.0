Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AD33034AC
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 06:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbhAZFZ1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 00:25:27 -0500
Received: from mail-dm6nam12on2107.outbound.protection.outlook.com ([40.107.243.107]:24128
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbhAZB3I (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 20:29:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bta+M3feaeIoWhISGL6jqxxW2pkgI2I4CZ00YxjFMDjU6RzOmBsbU3nrneFtg8R1iPVSueQFnO/YP+oAlOLQh9BhZJAfCaO/vXcr6KqLRhJF0YWHVbvZ1iTa51jK/F259evYmTvXsf8V0tdB1Cg91F1W8hKGbSqml4USgZUIvG2kaaANt2+nvy+sTXiMp6eHRL425o+Xp12EbUIRqhaY0w3Dlx4EasqiYNJ8CysFZhDYPyPW7T16XhNogDsfMGwkrgGqCPgnBuNmoLBtS8xufIsVqy9lqUi4B6dhpd7f+a4bVWeUVsfq2p6X3XVsoQh//7rAI5MfbjOZC8Fjl7VUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZAK6GcR7GqW+hIdA/bXTWoFwG9YEZbDOqShwCgYhfQ=;
 b=j619TWBUIGl8jUr9HlcV18xRgyvhVX1n+p7kC+mklZ+bvqUqWxZxCd7aBzvTV4O8jlGG0W/lSP44Y+j6E/fVNCBbT4cvXrGUcjHTlZeEcaIzHZ54TFH3vHtzOmFtZO3WoZoNywVDfaatdM2jS74GE/1DWtBtpXBdA0tn+foGqdmZ6HPu0xd9i7E7Zv1f0tKOPy9Aelv3qokqIkZbSsds0anNeAkS6uW2Gq/44i+LEa6XvbNrW8COjv09xmAubOtB94UsyblN3XaV5QAoXm0EavIXp2ldJj3CD28G9FRqlH6Ko3ItZ2gJKpRXv3GAl6436782nTJxazKbDnQcky854g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZAK6GcR7GqW+hIdA/bXTWoFwG9YEZbDOqShwCgYhfQ=;
 b=S86WWAx+zFtQjqXNAMaYUt/4PYFb8rek5MvLSKk4qUqu/e70Lp2TItfuJbCC0bMco30kWpYYtAHZEov/85HQ0Wq/JQZ7WZDKhDIKP9znDOGibF2zWH8CalVdznOj13jRDO5NDMs9k8zZXMNYTsD8DuSSFv/ECBGNX7D9Tv2H0Vo=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Tue, 26 Jan
 2021 01:27:44 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 01:27:44 +0000
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
Subject: RE: [PATCH v5 14/16] asm-generic/hyperv: import data structures for
 mapping device interrupts
Thread-Topic: [PATCH v5 14/16] asm-generic/hyperv: import data structures for
 mapping device interrupts
Thread-Index: AQHW7yP3Li0cFtxmokK9O8UCUD6/Pqo5JmSw
Date:   Tue, 26 Jan 2021 01:27:44 +0000
Message-ID: <MWHPR21MB159311EB48A64A9D49D2D484D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-15-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-15-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T01:27:42Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a157699f-026f-483f-afd7-a20f3e01d667;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8a97b486-0bb0-4c73-dfbc-08d8c19994f6
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB0873D86622FB55BAA69286BDD7BC9@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:147;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A5g9biWMQUvUyA497Mq9Y+8dS1OefJtVTAGHZh42H6CJ6dmLqrhwxYSgLo3Jgp2ds93lHUS7azoUg49sdAnrqgNSggEITWaQnArUyiW4pcnJ4acxwcjGcgwPVyJH0wjKTJaIGUY5e4vKtpwHFAl2Wbb9K7X78GcYaniIaQRgGskth82icDWSxUGuIq9mY60E5LF/fI5LTCGR/LfuIjhf7T+6xl7KgkYnS6sVuy3r9QrgDq5HmzH7amzzwWKRMi2bjwWjBc83p2TLCBV7D6eU/J5DOXwb5DmdTAlPv1Y3dx4abO/mM6yddlrz2ektkVGUnZY/bmT+08o9sqjstnvu9NFByeNkSK9Efs0BRcImbwpfAXB6GMzQxswjEkARUvDDmr3Ng6YeDDRCHW+xJPWPycxDUeZ0eeql2dxZ2WD1r7YsuegcuLT0f/YoNegrISmou/iHhMAkWuTn8j+ep1i9GZPsESAXX13orWsuzuxpdZ71c8YR5c7pyRN4UTyxDNwjGqBWB3Pvu5271HGDu//4AW7LcuA5VmNDTbUFGBhRELA1SkAw50Vm3XxfNnTP+/3u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(8676002)(33656002)(26005)(186003)(86362001)(7696005)(82950400001)(82960400001)(6506007)(8990500004)(2906002)(5660300002)(10290500003)(316002)(54906003)(4326008)(64756008)(110136005)(66946007)(76116006)(66446008)(478600001)(52536014)(8936002)(7416002)(71200400001)(55016002)(83380400001)(9686003)(66476007)(66556008)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Sf7mOwre7F454i5W2bJRWW5E8WZqbBBGm5A/lcF/OYCRdMeHjTDZKRWj03ZW?=
 =?us-ascii?Q?zlwNjiMAfnIEc6IUYE6t7MrcXZbgGNrVs06spxCm8+9r25EmOfh0mYsrhswr?=
 =?us-ascii?Q?XyTW/kWC6ccJ86Kubl0gGXkZYzRqDi25cxpUsVm+af+EGcZsdTyekpNtZ0fg?=
 =?us-ascii?Q?W72CdHaOqvsCz3swbb9ZfHQY9Gy+PWbt3XI1FSW0O1C5isnpFBI+WwEPtXs5?=
 =?us-ascii?Q?CVJP7Ih/8zmnWedySaHkSnxFP9aURG9I+wGbWA71t8tNE7S+7Mlhlb/z3hmW?=
 =?us-ascii?Q?v75rwzTWT00/fhV66HWk/kHTAHQfDF28lsLTtCR89gmTLT1hAVU41X355vWA?=
 =?us-ascii?Q?eXGvwzOH1j+I/IEdqa3JC2VSMdTm6zJT4NTimayK4IxXRogjIHPHWAZ9WyoW?=
 =?us-ascii?Q?fW7+NEZHbPsN5SyS+sjhjBEspMt3riBGuQjUVGcIt3G1htieVFHxovH7nEXL?=
 =?us-ascii?Q?TjPbapNeYae4PxADUwLhWnNnctGi6/tkljR6H/fLQi1LddSvC0DuO2GHPp4g?=
 =?us-ascii?Q?w2BLiztYxLr26K/InScDZyXK1hnhBcKktcXmdhZ2bcwOdcsDr7L36nVltjre?=
 =?us-ascii?Q?yepqNL3XF+3xEqBAPY8k5gG5jmKDog+/I5o5HTpIcBhuHrp7zjVgEF492kuv?=
 =?us-ascii?Q?SeAw2UnRUuaMC7rOmRiMi2MeRb37cwpswO5nAFsW4LKrVhybuAvy5iPSLN+Z?=
 =?us-ascii?Q?oLy7y1K3W08ebekfXngXFdGa4BXfq0rxru2Fed3HQb4ChuIUhGLJgBzKpBo+?=
 =?us-ascii?Q?Fd0q7grYyn/p3xXJOWq1EozgSsKsXU3v9j5d6g9boDAXa9oohOZE6QJHz0PB?=
 =?us-ascii?Q?zu8sbrry72xnM5mJyKx2Fq1Rtn1GvRNrvrlygJDAjMyidq73JIJE/qZE8kzi?=
 =?us-ascii?Q?Gt677tGLQpkjwddWON4I0aw+486AqNzAgOuNfYHivvVezTRJU89LXOZwgCMG?=
 =?us-ascii?Q?OB1lNrx5U3Ntn99GORTSIwgzvet7PiR2BRC/cRpuBnbK2OXtpVuNPFyXO9LP?=
 =?us-ascii?Q?X83N4iBfLQ4G1NuiAy8XMNZ8y8VKXfK3ndJh/Ber7PumwlhY5bwaWSark/ih?=
 =?us-ascii?Q?+Pejewsu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a97b486-0bb0-4c73-dfbc-08d8c19994f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:27:44.4330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUsAerBetGlyyIwwmhC55+BctJHSAIQudu8WtPJKS5PRwZmT+YBJmjXdPkGAudWGiCIbBy+7cNIfySXRnKsiAOEOBloQlXI2XekfJxHB9uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 A=
M
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 13 +++++++++++
>  include/asm-generic/hyperv-tlfs.h  | 36 ++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 204010350604..ab7d6cde548d 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -533,6 +533,19 @@ struct hv_partition_assist_pg {
>  	u32 tlb_lock_count;
>  };
>=20
> +enum hv_interrupt_type {
> +	HV_X64_INTERRUPT_TYPE_FIXED             =3D 0x0000,
> +	HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY    =3D 0x0001,
> +	HV_X64_INTERRUPT_TYPE_SMI               =3D 0x0002,
> +	HV_X64_INTERRUPT_TYPE_REMOTEREAD        =3D 0x0003,
> +	HV_X64_INTERRUPT_TYPE_NMI               =3D 0x0004,
> +	HV_X64_INTERRUPT_TYPE_INIT              =3D 0x0005,
> +	HV_X64_INTERRUPT_TYPE_SIPI              =3D 0x0006,
> +	HV_X64_INTERRUPT_TYPE_EXTINT            =3D 0x0007,
> +	HV_X64_INTERRUPT_TYPE_LOCALINT0         =3D 0x0008,
> +	HV_X64_INTERRUPT_TYPE_LOCALINT1         =3D 0x0009,
> +	HV_X64_INTERRUPT_TYPE_MAXIMUM           =3D 0x000A,
> +};
>=20
>  #include <asm-generic/hyperv-tlfs.h>
>=20
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index 42ff1326c6bd..07efe0131fe3 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -152,6 +152,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
>  #define HVCALL_RESET_DEBUG_SESSION		0x006b
>  #define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
> +#define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
> +#define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
> @@ -702,4 +704,38 @@ union hv_device_id {
>  	} acpi;
>  } __packed;
>=20
> +enum hv_interrupt_trigger_mode {
> +	HV_INTERRUPT_TRIGGER_MODE_EDGE =3D 0,
> +	HV_INTERRUPT_TRIGGER_MODE_LEVEL =3D 1,
> +};
> +
> +struct hv_device_interrupt_descriptor {
> +	u32 interrupt_type;
> +	u32 trigger_mode;
> +	u32 vector_count;
> +	u32 reserved;
> +	struct hv_device_interrupt_target target;
> +} __packed;
> +
> +struct hv_input_map_device_interrupt {
> +	u64 partition_id;
> +	u64 device_id;
> +	u64 flags;
> +	struct hv_interrupt_entry logical_interrupt_entry;
> +	struct hv_device_interrupt_descriptor interrupt_descriptor;
> +} __packed;
> +
> +struct hv_output_map_device_interrupt {
> +	struct hv_interrupt_entry interrupt_entry;
> +} __packed;
> +
> +struct hv_input_unmap_device_interrupt {
> +	u64 partition_id;
> +	u64 device_id;
> +	struct hv_interrupt_entry interrupt_entry;
> +} __packed;
> +
> +#define HV_SOURCE_SHADOW_NONE               0x0
> +#define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
> +
>  #endif
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

