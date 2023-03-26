Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E727A6C95ED
	for <lists+linux-arch@lfdr.de>; Sun, 26 Mar 2023 17:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCZPFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 11:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjCZPFN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 11:05:13 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5713AAA;
        Sun, 26 Mar 2023 08:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl8jA/gfBXT147ohV4L69ULM9t8yRSUAhNEaf3C/UJFXJl1l16n9IRavBYATFS4I3YkHqrhuLQmNLnscomqGThzrbxFBdr5Pl2KAkcvaKgcLatH1OiDbV+n6h/QyzVX33+H9pPtVdwQxGTxmOAu84VrRA4KUKjBbgQv7Gu36f1NvI2HEwdwZrYCftDU0sIs3c/phDmPDI5DoTyRzhn9p4ueNV3BC21zrVhl8QKvHln6EddJuTijH3U8rG5RtJ03z++yPk2wd5hqXs+0pcAw7x5XtQpt9TgYyKxeHjLnbHeAY+3BufQEQR+qxoDC0GrrHlsq419IlYD6TaOaBvsBQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRb/c6xvB9wzHN8s0u3iKrNcBvBhHb3GAZ5leerFuEY=;
 b=AsYDkXUTPl6KjpJvvuJMZw4RnqeWVa5Dkbehu0I8tuDCjgQQr0flExDuH2PCKdT67x+zb87ZTfLmryfz0UT8Shq22nZfWAfDoEArFHS3uGhvb6vTo21jFD42W7dlWqzchOt/sK+Cf8AlyoiouNa2FXvDGAQeLtik7gQC16lZOUDLVQqzl140pzMD0GJoXSfDuNLcl7/HivQsS1SOq60nVwTadTapbL1Y2mlsMvjRR68N03VFyu7htccoRzgz6Nkb2Q8Jwbjx2STGIKYX9j6PmcH7SV706Yw2Hx9oXnE6JDE1ri3Luz+iYOoA2ZGDshakfwviSC75JO4e17gJnUxLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRb/c6xvB9wzHN8s0u3iKrNcBvBhHb3GAZ5leerFuEY=;
 b=PAfKPV/0GIDSGqhw+IgwwDgJoqwrEp9BF96zYJScn2MZ+sSu3GNKO2P4I910uq7ZJUxOoFr28kJ3ZISF1BUCbZLfzF4KivWhM/CX9XnoMoIPJnWjNeCZZI9Nn20saCQH+NyhO0EOFzao0XaYQFXcaAZ5809N9gI2JEkUlaKv008=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1908.namprd21.prod.outlook.com (2603:10b6:303:7b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16; Sun, 26 Mar
 2023 15:05:08 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.014; Sun, 26 Mar 2023
 15:05:08 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3 2/5] x86/hyperv: Add VTL specific structs and
 hypercalls
Thread-Topic: [PATCH v3 2/5] x86/hyperv: Add VTL specific structs and
 hypercalls
Thread-Index: AQHZWxNEgmQFOIIRck21W7I8hT6uOq8NMmUQ
Date:   Sun, 26 Mar 2023 15:05:08 +0000
Message-ID: <BYAPR21MB1688865E2E53A1F92CB16D0DD78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1679306618-31484-3-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=cb9741b8-2e6b-45ed-b1a0-4cdb5cb0d8a2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-26T15:04:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1908:EE_
x-ms-office365-filtering-correlation-id: ae0b474f-e9e2-430c-2351-08db2e0b7d34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iHEgpe/y1km4iTswz5KsnYXgkNk4pQMd3Y6omq1494vjIMu0J3IuifwQWFt3Lrt6yVxFMqMK7ACoE0ANUZQtUZl9zp0ZG/YJs0E4R6n4i+eAE3e8zNrGW1bHxY4kjuArpRAz8PqvMB0e/tY9Gw/2htOQ7qCZt19ulpdjEmvU25wHlS8jG3My5HLmtRUkcBaHZWg4mU5hIPoiZejFqGKL/eVsu32aC2agd8TtKYykJj2p8efT7oAO8B90tsM+nkOt8ArzXXj2lnsu7qIDsgZVouDT7VpLbAiUJ0BCX20buSnXuEat6UhyvWAHB2wGgzk60TCK7BsyKakxCFPQM/2kAXOszWUT8TjY6ZgZTnrQLFIswQdyMZM94pN37MH6oHhVuhwf4qDjdZLUQSkeuWxp2E91KkzjdXcX1FDF2S15uJPh8rN/H9dhp3sRFQ0j17hhCbO+u65eE5vQaOBU7HGUUIMGXq6npCSkTHx/qRwsZPMUv8oU27azfIoHLpT3wiD1A3LKXVRzWftKSY4I5FG4iOAhDB71VDJvu3Qs3BxNm1uwKxSuaYC8XBf9SVjK+LMudgWpExR6yNYwwL5hsd7aZcV/H6iMHBBr3G4PsJEtsCrFVD7oPSdFOV0WWIgLv57EhAF1bzUF7BFVtBwk2nwieRGO6/rw8xHYIN1jtSearHdDycu+2DKmOO4OFVcLISVW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(122000001)(38100700002)(82950400001)(82960400001)(55016003)(33656002)(86362001)(38070700005)(921005)(2906002)(10290500003)(186003)(26005)(478600001)(6506007)(9686003)(5660300002)(7416002)(8936002)(71200400001)(7696005)(52536014)(41300700001)(110136005)(316002)(66556008)(64756008)(66446008)(66476007)(66946007)(8990500004)(8676002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q3In/8jgJIgIA5ZXxkxqbVZ3tVEQTxILZ+jTL8VJowY3BEvtgmkdjeDGkJB7?=
 =?us-ascii?Q?w4wAcE6fmAjtzpnBBUg81ObhExPEWAKS4r/Asoksh/ZPsz7yRM2zKaT2mK63?=
 =?us-ascii?Q?5C8H0tVecZdO6glqgSLs9yRlrV0UxVMqoVeT5DA2jWFYme5qZ1KGrtHAHw3R?=
 =?us-ascii?Q?D/zlfO9YkWi37ykZykD+e3LNSAu98jPTM/LuzEkH+jM54/pPq9eUJCRhnFC2?=
 =?us-ascii?Q?zdQmUYb2xVevhU27vMqLmKySwKcpOj5RiAYpnp06/yHm2LNJvhZDr56G/JOj?=
 =?us-ascii?Q?z+lWXrc9JDwMkIj7r+8arlQfsW1zxV2smNzMXr31q0IwQZHP5cDOf1yYPhPz?=
 =?us-ascii?Q?rhl/jMf4WDFei3h0K0Dvy1hF5EMwjOmDuRmSwHCL9kt3kNpRZP8ch1iPzOxX?=
 =?us-ascii?Q?JA3DG1DSyFEKD9ttD6DrnNfZcn81yRBZc+KmmU6DuPnTxwltADQqSLCO/EXC?=
 =?us-ascii?Q?c3xXrkkdQjAVB/wWq9Ed62cToEj8oecfgGBmaklU7AbTsLGwIvBd3RDLzYMF?=
 =?us-ascii?Q?LR0WWoewdl+BvjnfcI1CI0x/hq/kh1Zd47zvA7lFpRnddaKpvdTsDsewX4p0?=
 =?us-ascii?Q?S2wPqWDH+vH6pBJ9Gw9esUyfxrYfFQ6Spbz6u2dHb5DERCENt19IuGP/uVJ8?=
 =?us-ascii?Q?8KQ44inD7Hm5x6FhpCf1ZbzHhrFKWIFfxe9c5DEKcvjC+xdH/9K6Ugf7JEBK?=
 =?us-ascii?Q?Z5e4B/0g489OvMtOeFnGJjaBeQZNTr2qlH/MHidb2+ECP/KQHGD/fYnEzvGo?=
 =?us-ascii?Q?zR2U8qOgRtSYflMhDGMEfsNa7+7uy+5SUeVgFgAt87hIqf2fDRo75z/ilHhG?=
 =?us-ascii?Q?SE0zlv3I3ZZTDvYuHEmZeLgvdTP2O3kKLRSmAsw2g7QzPuVnRDthPTzFYNkD?=
 =?us-ascii?Q?Ezllo2cLcVT/d8CjOgRsqAS/J7J0Ds2Yl3mzfNnSjX0rmy6Xg9YiAE72Bl5r?=
 =?us-ascii?Q?tR7lB/4x4dfJRIKuzPkaORugQp6oNdYC1TthqP5DncLWlE2Bz4y+0L1KZ6qw?=
 =?us-ascii?Q?vBecx+UqKFd8lTfC7kMdgJ+bFwJcXTEmfKvwLSTZya5yTm7siFvPuT4uw49F?=
 =?us-ascii?Q?OZNmSNXr7ppS81gLRPgo+MtcIQVETnDsE8/x+7gXM6cMswlbQKs7sUOedWWm?=
 =?us-ascii?Q?3DEWE8lNPOeZKbqjkYZqGyB3w128Fi3Z2l6WyOSOEcwgdPk2ZJcB/gPfWUXs?=
 =?us-ascii?Q?yXTBt8Wc6QaXYZB6Rg2LMTrqNOSmZM6oJtK23J6DyL3afhg+4t+GZGlj+n/M?=
 =?us-ascii?Q?/t95pmqhY9KrxM8zluWckYSHrh+eAHKW+ASQPWjLKNCa+X8nfzEpWoA6ARfz?=
 =?us-ascii?Q?LqXCM5BKyYUiL99inqaDhl8d7g12FXRy2tR7DAlMD4dnPKZ9veYVzkSf4kVl?=
 =?us-ascii?Q?fP13/0O8bC/ef47csZ0GfhAMsJqQ48iiNgJt3p6uLLnkmorMjzErh7IfWoUC?=
 =?us-ascii?Q?vz+LSJq3plw/aBhOv5cFbNl2z1QEuwet01693YuWSQ0wCdlKq5se0LNFM8HK?=
 =?us-ascii?Q?Ry7MAtX9bX72na6N7CxZ3UVDzWzCK44NG7Q44ISPf9/ACIOgFyDtZpbKvWjy?=
 =?us-ascii?Q?yxeaJ/Ds4do1gO/ZqtmsOw4aRrraziK/gkYeHk/lQLwFT99LKW+UGyfweQIz?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0b474f-e9e2-430c-2351-08db2e0b7d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 15:05:08.3050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYIYgCjmSkwExvS9vvloQlnDmKpiE8fl7C0uBYl2kl6TcXPaXw7ju3okaONoM8/TJr6dRnVKtKBAp9iTiPD5sjG9R/5JewUWS6IbJFeKcsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1908
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, March 20, =
2023 3:04 AM
>=20
> Add structs and hypercalls required to enable VTL support on x86.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 75 ++++++++++++++++++++++++++++++
>  include/asm-generic/hyperv-tlfs.h  |  4 ++
>  2 files changed, 79 insertions(+)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 0b73a809e9e1..0b0b4e9a4318 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -713,6 +713,81 @@ union hv_msi_entry {
>  	} __packed;
>  };
>=20
> +struct hv_x64_segment_register {
> +	__u64 base;
> +	__u32 limit;
> +	__u16 selector;
> +	union {
> +		struct {
> +			__u16 segment_type : 4;
> +			__u16 non_system_segment : 1;
> +			__u16 descriptor_privilege_level : 2;
> +			__u16 present : 1;
> +			__u16 reserved : 4;
> +			__u16 available : 1;
> +			__u16 _long : 1;
> +			__u16 _default : 1;
> +			__u16 granularity : 1;
> +		} __packed;
> +		__u16 attributes;
> +	};
> +} __packed;
> +
> +struct hv_x64_table_register {
> +	__u16 pad[3];
> +	__u16 limit;
> +	__u64 base;
> +} __packed;
> +
> +struct hv_init_vp_context {
> +	u64 rip;
> +	u64 rsp;
> +	u64 rflags;
> +
> +	struct hv_x64_segment_register cs;
> +	struct hv_x64_segment_register ds;
> +	struct hv_x64_segment_register es;
> +	struct hv_x64_segment_register fs;
> +	struct hv_x64_segment_register gs;
> +	struct hv_x64_segment_register ss;
> +	struct hv_x64_segment_register tr;
> +	struct hv_x64_segment_register ldtr;
> +
> +	struct hv_x64_table_register idtr;
> +	struct hv_x64_table_register gdtr;
> +
> +	u64 efer;
> +	u64 cr0;
> +	u64 cr3;
> +	u64 cr4;
> +	u64 msr_cr_pat;
> +} __packed;
> +
> +union hv_input_vtl {
> +	u8 as_uint8;
> +	struct {
> +		u8 target_vtl: 4;
> +		u8 use_target_vtl: 1;
> +		u8 reserved_z: 3;
> +	};
> +} __packed;
> +
> +struct hv_enable_vp_vtl {
> +	u64				partition_id;
> +	u32				vp_index;
> +	union hv_input_vtl		target_vtl;
> +	u8				mbz0;
> +	u16				mbz1;
> +	struct hv_init_vp_context	vp_context;
> +} __packed;
> +
> +struct hv_get_vp_from_apic_id_in {
> +	u64 partition_id;
> +	union hv_input_vtl target_vtl;
> +	u8 res[7];
> +	u32 apic_ids[];
> +} __packed;
> +
>  #include <asm-generic/hyperv-tlfs.h>
>=20
>  #endif
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index b870983596b9..87258341fd7c 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -146,6 +146,7 @@ union hv_reference_tsc_msr {
>  /* Declare the various hypercall operations. */
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
> +#define HVCALL_ENABLE_VP_VTL			0x000f
>  #define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
>  #define HVCALL_SEND_IPI				0x000b
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
> @@ -165,6 +166,8 @@ union hv_reference_tsc_msr {
>  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_START_VP				0x0099
> +#define HVCALL_GET_VP_ID_FROM_APIC_ID		0x009a
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
> @@ -218,6 +221,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_STATUS_INVALID_PORT_ID		17
>  #define HV_STATUS_INVALID_CONNECTION_ID		18
>  #define HV_STATUS_INSUFFICIENT_BUFFERS		19
> +#define HV_STATUS_VTL_ALREADY_ENABLED		134
>=20
>  /*
>   * The Hyper-V TimeRefCount register and the TSC
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

