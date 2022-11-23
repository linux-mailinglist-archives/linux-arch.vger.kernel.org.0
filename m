Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D0636228
	for <lists+linux-arch@lfdr.de>; Wed, 23 Nov 2022 15:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiKWOp1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Nov 2022 09:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbiKWOp0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Nov 2022 09:45:26 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022015.outbound.protection.outlook.com [52.101.63.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0327B31;
        Wed, 23 Nov 2022 06:45:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9/olN0Q3ImnvHmRd1JaC+gVKBphyvdg+K0k94Q8TrHECcuUoK7v/Ss7a7kWqyAVgjs+H+PA7mF8X8az93BnLLkr8lRZkDA4QaGHYuOst5dwXHRTErR23m8cuJ5jg2XnhYkzdMVXN0ODu2IT1QWhc525psA8u5k8Zmdhet1PyEQKKVXXogLoQ6uNJOX4xEuH1iH6uIZkEoc+SvZa0NJDVUvY886fiAVXbSJZDgNUZsH21lT0F2U+XY5/mPn8Dwg7PvE8ojnXDZKDSAMO56H+o7RG7jIX59Ki7XSahk/oqF25l+ZG65fQCB8+xM3ppp9ZpEuC+ya9rW3WYDbFuHQm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PaXfWlzLahE9B0t1NDv2j8BBIDrLFskyMjQICqCmMS8=;
 b=cpixIz5GIweDLzHAIN9057+0heGaMbtiZw/9G7fBTWpd+XRiT5DH604qxixp1L6GtFEYfEo1hqZETCXsco9tPj4i/MOPLmI4EuqTUrfyioJonLHd+lzh2DOEGtgdhGDolozOZq2VCMfI1vBU+5JMZoXqvS6/z8QHwA5zUQaUqDnRZcfOge92waIrfmzWkAD1+k0A5zRFVWWx3Vtr3BeGRhm/g9OqFvXMWqArFMCKDQ41DRSPwD6LRxrB5wj7N1lp6LDypd+ircRHM+msLlcBvagAl8Veer34QG1f2kkK5R3pJbsNg5LoH7Jdol/L3U46dMNkGQTSe2xtP78l0hwKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PaXfWlzLahE9B0t1NDv2j8BBIDrLFskyMjQICqCmMS8=;
 b=c4gWoFhGUUiJ5VF+DGVHAYuxDpIkRCKKk2jJzqQxY+utUTVFFWipWhxfyH61aZR1CDkFBE1BArficfjLwjiPIYhJrInKXTAVSkjSYZ5MlGxZe/7SWxBn8JYB3b3ylxQWJbgTcQXQKF0PUFub6sNV86EW0tu8pRNcfTiXQ0UVxnQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3114.namprd21.prod.outlook.com (2603:10b6:208:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Wed, 23 Nov
 2022 14:45:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5880.002; Wed, 23 Nov 2022
 14:45:15 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/eL68sa7B8PD5UqEC8+ROEIS6K5MlaWg
Date:   Wed, 23 Nov 2022 14:45:14 +0000
Message-ID: <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
In-Reply-To: <20221121195151.21812-6-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a799fdd5-3e93-46b4-b0f9-8dd673651b98;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T14:34:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3114:EE_
x-ms-office365-filtering-correlation-id: 335b5260-f8f7-4215-b394-08dacd615514
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klaEowYSNrpwY/EmBv+8na3YEVtDVFN9+8JrCe13m4b+20vdIkHF9OicwmbiQSJFnUjFyON2AzbVIwrAoqsmyGu4aMQN7eFVkPBfMzSPcnyWHOZW76RZ06ign0h3/ooxRuIfpZQg3rpEQA3lCWtO0g5BJ+hjJ3s3EBQ3nxtJHSN0psx8moyQrt9H+kFEVpCxr9RteyNmibR2kDYc2edkKWDs7+qxxwRpnc80ycRzjXJMe1hznT5InsnjEjGooNXevP7O0+YxQiLsvgHxQCGaL2qjMxBC2+uvUznKcD4Cl20mXQwq7Beo6H63job4EyZm3yf5It2DqYRqdsfXUGZ/KqhOnu60WOcAreGNTUyeFYggzLOht/xy+Cx/Tc/AmL6h6WZCPPClJsbeZLzzchNReBqaOc2zkhX4LrNwA4lgngL6LpR4C9+C2+zg1TtRPd0wrfoqXhasn0DTM86ejTVbrfjCmqZTpGKKR17VM51te5PiXW4v9NAzEHVi+ZH4VbrGh3pOA3s5iSHVWptqcPsHcQkWBKaBCHuJg3dicnN9zxaP2Y4+G/zGWvnALwZbI278e5vIff1GhMLMRVyxoc1Cwx7aj9WMo1CpxyLNaa4D5ZQ0Bi1Y4fCjMaIsZjMaPDVr1htP6r1MeVbFeGm4r+OK/60eSt09m7KECqB0u8y77gQFS5kzHWsNMaNthgpWPoIn4VWA7yAROkGMsqXRy2O/wJ6nlo1d319d1C/7Ii1DYFG/oCplsf7t04KAYVGbA0tOhFtzW1uVl5loWFZrXJKsLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(8990500004)(478600001)(83380400001)(2906002)(38100700002)(122000001)(7416002)(5660300002)(82950400001)(82960400001)(8936002)(71200400001)(52536014)(186003)(41300700001)(55016003)(66446008)(921005)(38070700005)(64756008)(66476007)(8676002)(4326008)(66556008)(76116006)(9686003)(66946007)(107886003)(110136005)(26005)(10290500003)(86362001)(316002)(54906003)(7696005)(33656002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?piFzj29C623qbHsm0sJNaHi4CtZAC9k0t0fvgiqIMZWAguhu13KPsFlAAq8Q?=
 =?us-ascii?Q?U5P7L3nEH8LgbhKX81WXM+BtyJvN6yrbVmAfDpXY9wKx5uUy8J6M6x4DmcBo?=
 =?us-ascii?Q?y9AMcl92LMnc1Aju8syDUDAeLHYOvg/gPuj0Upygc3z26u8EQFdYWEvWkGyD?=
 =?us-ascii?Q?8NHnDdKY+WF39MWHosUKPIDYHPUkJxKa/07E2zJcKclfmSegSOmwtudRZHoM?=
 =?us-ascii?Q?0j2xgL4cjvyZmmhI0d+Sz1/FPlBtS1EoCcVaRjj381KlCqheh9UkW/DBYwxI?=
 =?us-ascii?Q?ej9EZoHY8Awc2M8zJldMXUTs75UbkBrHXuQhmW9tLvxea+QlmDqXal5ubiGb?=
 =?us-ascii?Q?7vXz4ZGUSdl9p3wLLFATCImWrLRCpoPklYH1ROWQpSTh8p9OxxojIeBOVi86?=
 =?us-ascii?Q?E0H+C4UkQnKiSSEMbSD474FQ3U6NLwpxr5e6zd6pQ+YT0GZ0VAOScjxTk0ow?=
 =?us-ascii?Q?0HXHBmhS23g/YBe+glECrIzt9136cXSV2IBN4RqWuzFsN+8SG1PuYxTJ4+R7?=
 =?us-ascii?Q?IY6nsST3+NWf2pfoWJDahRazzSLKSnvXbwGUTJpuOsbzAYnwaLJ6hSmf6Lt8?=
 =?us-ascii?Q?Z9o05V+TiZoRcCnQ6+FdCIkYgRLVZSZ+Bh4Sq2Cvdx9SIMlP46gU5pS1FrKs?=
 =?us-ascii?Q?qI/m0hZXL5xS6MxEij/+MOEYtoUtPqnu0fnjizj3Hm54ee0CFAkS+Wt3Xls5?=
 =?us-ascii?Q?jsN/8RjC8uSkkwOy0xDQ0Q3JR9VE52CZQmSXIXxn99nI2hIdH3POGLVsL3t+?=
 =?us-ascii?Q?H5lDYSFqkD33TOB0f2Hf/p1X86E1Mf2FetSE3IRq8hawzHe+0a8BGoka6QH3?=
 =?us-ascii?Q?pv2WXm9rRt5u+5rvkS5nEPtRPKO/kX0aSHePLt348sSaypjVKfbMDfmrvILD?=
 =?us-ascii?Q?IhnUwDp3tO1Y1bfGabS9DS/8j5l+lVAl3ghsdMj85fZqDNMUnbOduWxB0trj?=
 =?us-ascii?Q?AWcUzoFg9PI2ntRL7Adp7fwFB+6QXziSGr9suIpYC9rVmZhvGCUjQ/B1SED0?=
 =?us-ascii?Q?BDfrkaxzaRHZEvjslxjnO+0cpkMO/R5Za7N2iQzB2hvzB2mz28PiPLQ17asX?=
 =?us-ascii?Q?4vj8ytjUoMcxnrU5LauRXZoeru0EC8aaU20lzhxkE+mvfYEoZMBlJSDj9sBI?=
 =?us-ascii?Q?kk0/2VBTZ0E1bjQU2UnI++IbaexdO73AzgxbU6upYDmbEzT5RGvLGe6AyGAJ?=
 =?us-ascii?Q?AdVkjdMDGWsoxrVkUe5B54cjFWuQqeeMg/mJWGwkY99Z34adN6M59ZLUgf12?=
 =?us-ascii?Q?BYAXvNEzBWv1jZ5mpQgSnHeS/koDzMkCsLqI7M2cdDiUP8aipCJadVPaH+ZX?=
 =?us-ascii?Q?KFKG4MHJf5vOFNK6XAeTIi1M439ebRnadehAXZ4wuo4mLJW4sEyhIpXztlwh?=
 =?us-ascii?Q?ZsJgwdXlv92iR4/qMqwRZ/4re6m8pdOyPcycjb/ZyCI+N39GglIHp1p86D2p?=
 =?us-ascii?Q?UEMVtfiUTWpLyDMw1WYUQKcL/GACZ6n1QrjJVw8gMtdMaIxxoMext/oBqNX/?=
 =?us-ascii?Q?V8sTZV+D+9V5OK5QsPYCi+iD+hilZF8Uecz08pm+L3abDoTuz1+n1rwQRbq3?=
 =?us-ascii?Q?VyiHVHTyy2JjyTYSmAxSbfFegqUSgJ9fjjG0EzEBoY6cMe+6BDGICHGYh/rR?=
 =?us-ascii?Q?QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 335b5260-f8f7-4215-b394-08dacd615514
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 14:45:14.8663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G0bE3XaJOlXHzeb8c1iDrvmDHVHn6gxWBaIS8UZoDUcl5+58uqk6jRZZiw4tn2HSsYdYWipueqHq06uLp7bC4CNEmjF+Z1YthHNeMTB+NQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3114
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, November 21, 2022 11:5=
2 AM
>=20
> A TDX guest uses the GHCI call rather than hv_hypercall_pg.
>=20
> In hv_do_hypercall(), Hyper-V requires that the input/output addresses
> must have the vTOM bit set. With current Hyper-V, the bit for TDX is
> bit 47, which is saved into ms_hyperv.shared_gpa_boundary() in
> ms_hyperv_init_platform().
>=20
> arch/x86/include/asm/mshyperv.h: hv_do_hypercall() needs
> "struct ms_hyperv_info", which is defined in
> include/asm-generic/mshyperv.h, which can't be included in
> arch/x86/include/asm/mshyperv.h because include/asm-generic/mshyperv.h
> has vmbus_signal_eom() -> hv_set_register(), which is defined in
> arch/x86/include/asm/mshyperv.h.
>=20
> Break this circular dependency by introducing a new header file
> for "struct ms_hyperv_info".
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  MAINTAINERS                          |  1 +
>  arch/x86/hyperv/hv_init.c            |  8 ++++++++
>  arch/x86/include/asm/mshyperv.h      | 24 ++++++++++++++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c       |  2 ++
>  include/asm-generic/ms_hyperv_info.h | 29 ++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h       | 24 +----------------------
>  6 files changed, 64 insertions(+), 24 deletions(-)
>  create mode 100644 include/asm-generic/ms_hyperv_info.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 256f03904987..455ecaf188fe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9537,6 +9537,7 @@ F:	drivers/scsi/storvsc_drv.c
>  F:	drivers/uio/uio_hv_generic.c
>  F:	drivers/video/fbdev/hyperv_fb.c
>  F:	include/asm-generic/hyperv-tlfs.h
> +F:	include/asm-generic/ms_hyperv_info.h
>  F:	include/asm-generic/mshyperv.h
>  F:	include/clocksource/hyperv_timer.h
>  F:	include/linux/hyperv.h
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 89954490af93..05682c4e327f 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -432,6 +432,10 @@ void __init hyperv_init(void)
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
>  	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		goto skip_hypercall_pg_init;
> +
>  	hv_hypercall_pg =3D __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
>  			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
>  			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> @@ -471,6 +475,7 @@ void __init hyperv_init(void)
>  		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>  	}
>=20
> +skip_hypercall_pg_init:
>  	/*
>  	 * hyperv_init() is called before LAPIC is initialized: see
>  	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
> @@ -606,6 +611,9 @@ bool hv_is_hyperv_initialized(void)
>  	if (x86_hyper_type !=3D X86_HYPER_MS_HYPERV)
>  		return false;
>=20
> +	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
> +	if (hv_isolation_type_tdx())
> +		return true;
>  	/*
>  	 * Verify that earlier initialization succeeded by checking
>  	 * that the hypercall page is setup
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 9d593ab2be26..650b4fae2fd8 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -9,7 +9,7 @@
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
> -#include <asm/mshyperv.h>
> +#include <asm-generic/ms_hyperv_info.h>
>=20
>  union hv_ghcb;
>=20
> @@ -48,6 +48,18 @@ static inline u64 hv_do_hypercall(u64 control, void *i=
nput, void
> *output)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> +#if CONFIG_INTEL_TDX_GUEST
> +	if (hv_isolation_type_tdx()) {
> +		if (input_address)
> +			input_address +=3D ms_hyperv.shared_gpa_boundary;
> +
> +		if (output_address)
> +			output_address +=3D ms_hyperv.shared_gpa_boundary;
> +
> +		return __tdx_ms_hv_hypercall(control, output_address,
> +					     input_address);
> +	}
> +#endif

Two thoughts:

1)  The #ifdef CONFIG_INTEL_TDX_GUEST could probably be removed entirely
with a tweak.  hv_isolation_type_tdx() already doesn't need the #ifdef as t=
here's
already a stub that returns 'false'.   Then you just need a way to handle
__tdx_ms_hv_hypercall(), or whatever it becomes based on the other discussi=
on.
As long as you can provide a stub that does nothing, the #ifdef won't be ne=
eded.

2)  Assuming that we end up with some kind of Hyper-V specific version of
__tdx_hypercall(), and hopefully as a "C" function, could you move the hand=
ling
of  ms_hyperv.shared_gpa_boundary into that function?  Then you won't need
to break out a separate include file for struct ms_hyperv.  The Hyper-V TDX
hypercall function must handle both normal and "fast" hypercalls, and the
shared_gpa_boundary adjustment is needed only for normal hypercalls,
but you can check the "fast" bit in the control word to decide.

I haven't coded these ideas, so maybe there are snags I haven't thought of.
But I'm really hoping we can avoid having to create a separate include
file for struct ms_hyperv.

Michael

>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
>=20
> @@ -85,6 +97,11 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 =
input1)
>  	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
>  #ifdef CONFIG_X86_64
> +#if CONFIG_INTEL_TDX_GUEST
> +	if (hv_isolation_type_tdx())
> +		return __tdx_ms_hv_hypercall(control, 0, input1);
> +#endif
> +
>  	{
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> @@ -116,6 +133,11 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64 input1,
> u64 input2)
>  	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
>  #ifdef CONFIG_X86_64
> +#if CONFIG_INTEL_TDX_GUEST
> +	if (hv_isolation_type_tdx())
> +		return __tdx_ms_hv_hypercall(control, input2, input1);
> +#endif
> +
>  	{
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 9ad0b0abf0e0..dddccdbc5526 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -349,6 +349,8 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  			case HV_ISOLATION_TYPE_TDX:
>  				static_branch_enable(&isolation_type_tdx);
> +
> +				ms_hyperv.shared_gpa_boundary =3D cc_mkdec(0);
>  				break;
>=20
>  			default:
> diff --git a/include/asm-generic/ms_hyperv_info.h b/include/asm-
> generic/ms_hyperv_info.h
> new file mode 100644
> index 000000000000..734583dfea99
> --- /dev/null
> +++ b/include/asm-generic/ms_hyperv_info.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _ASM_GENERIC_MS_HYPERV_INFO_H
> +#define _ASM_GENERIC_MS_HYPERV_INFO_H
> +
> +struct ms_hyperv_info {
> +	u32 features;
> +	u32 priv_high;
> +	u32 misc_features;
> +	u32 hints;
> +	u32 nested_features;
> +	u32 max_vp_index;
> +	u32 max_lp_index;
> +	u32 isolation_config_a;
> +	union {
> +		u32 isolation_config_b;
> +		struct {
> +			u32 cvm_type : 4;
> +			u32 reserved1 : 1;
> +			u32 shared_gpa_boundary_active : 1;
> +			u32 shared_gpa_boundary_bits : 6;
> +			u32 reserved2 : 20;
> +		};
> +	};
> +	u64 shared_gpa_boundary;
> +};
> +extern struct ms_hyperv_info ms_hyperv;
> +
> +#endif
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index bfb9eb9d7215..2ae3e4e4256b 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,29 +25,7 @@
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
>  #include <asm/hyperv-tlfs.h>
> -
> -struct ms_hyperv_info {
> -	u32 features;
> -	u32 priv_high;
> -	u32 misc_features;
> -	u32 hints;
> -	u32 nested_features;
> -	u32 max_vp_index;
> -	u32 max_lp_index;
> -	u32 isolation_config_a;
> -	union {
> -		u32 isolation_config_b;
> -		struct {
> -			u32 cvm_type : 4;
> -			u32 reserved1 : 1;
> -			u32 shared_gpa_boundary_active : 1;
> -			u32 shared_gpa_boundary_bits : 6;
> -			u32 reserved2 : 20;
> -		};
> -	};
> -	u64 shared_gpa_boundary;
> -};
> -extern struct ms_hyperv_info ms_hyperv;
> +#include <asm-generic/ms_hyperv_info.h>
>=20
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
> --
> 2.25.1

