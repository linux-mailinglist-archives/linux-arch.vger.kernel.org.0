Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A063308277
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 01:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhA2Agt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 28 Jan 2021 19:36:49 -0500
Received: from mail-dm6nam10on2123.outbound.protection.outlook.com ([40.107.93.123]:46625
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231224AbhA2AgQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Jan 2021 19:36:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ievFF/vkMMRVHxzvxUd9t9MP+9Zc8lvfTJt1U7SbvFg6P+m+F4vXrtbdSO2n7G0iwrIjXPXI27xvWL2irPM2mF7v/V5i9me859ALMzlvBi5NB6OcXXuJBMaRaXyLrOnhY1ypCMbuQ9lrpceMgvpNDnQAzQnKKUIwIuM8WrnW0VUAMPlvrI7qaqq7yjiDJToI39GHv7mleEG1wlwsT4pECSNK2p/z11h52FPG1xLCOtzaDbIY8Zzn1gb5CHjn+uOdEUORGu37o0p5dYgZ4R5Wn++hCeAGOTyBYISnMKTfGM54sxWPM+7IoeevlJ7YXd88IF8o4qgHptLHlcaL2WTR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCS+YpL0snqkFmy1iqSmSjoX5bcK3xt176NlM7vEljE=;
 b=SCcdaRlLQEOodQV9LHeT5wanT6PReK4kiNZevjzum5aguExwdgg4hoP5TN65obQU+oxSIcVFPBzFQl9wpTb1ZX8AOqtmr3vS2KYCwQhvgRLZRF3ICg4cQMd0Wv2xj9TfqUtybiX/6PTcsyUv/zv2qkCPLFAXI5tjpJ4orjEm7yEXk3m3IN+kxp/sNWLuLkYOEaXQfxA/O7RxjBkFV1Va76jVE4TrHg/OKwqR2ZW+rTnM5/vQCnkGcvVqSIDg3CSCTmMC/lgXSg74GXrzPmg+xWCMi8oXq7V1NBrbhsIGjrDzAYFULLpcZnQMopHw+l+tNBbtwOWQ3qFINwtbZ4n+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCS+YpL0snqkFmy1iqSmSjoX5bcK3xt176NlM7vEljE=;
 b=FFv0LJoRr+1D15n5E2AnWMKHv2seeyVLQeB+knOhrPvBznOsdyuJH+KXspybJoSjKn+TBI/cOnKy7/DmtSR/1SqNbKODzz6oAeQ7s0e7pFF7dwrxGbgm3+s6d08LSEM60tV4OCUChCEmJzPj3y0JOuNcaILzninGA/FYVB8+7os=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Fri, 29 Jan
 2021 00:35:27 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Fri, 29 Jan 2021
 00:35:27 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] x86/hyperv: Load/save the Isolation Configuration
 leaf
Thread-Topic: [PATCH v2 1/4] x86/hyperv: Load/save the Isolation Configuration
 leaf
Thread-Index: AQHW89pi31QWB+TP3028lS5/+FlxVao9tHIA
Date:   Fri, 29 Jan 2021 00:35:27 +0000
Message-ID: <MWHPR21MB15931605F5181B2822AC2FFBD7B99@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210126115641.2527-1-parri.andrea@gmail.com>
 <20210126115641.2527-2-parri.andrea@gmail.com>
In-Reply-To: <20210126115641.2527-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-29T00:35:18Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c2ae570-7d95-48f2-8c3f-02bb6dac4283;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [8.46.75.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f271ce34-67bd-4310-e7b6-08d8c3edc687
x-ms-traffictypediagnostic: MW2PR2101MB1019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10195924B8D9BABD934A6D54D7B99@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: frDhozDkueINQZ85efkVNKeMp5prO7dAIc16oFNmSor36R1VGRFIJ669OeULRb8soyuUu6/hi69r+tGjI+QFrfRFGZt9iSK/9amRDtfroXKk4/vkNECbTilYBa11llJ3PoJc04qkQVpfMwOt9fLnK5lZjyaACZa3i2Vtvhrw6Z1FuJODf0EnW53hvOG88Iu0JfQ9Q2WOE/TLAkWqHjM2iT0ikN8bCqWUzfl7SToW+AOBUye8T1d5iZBUPkiCOfuoeYZp775IV2yFOVuJe0wa/9T7ShHXAsCPaI8KGeBFI/9+l9ryhZjkKFflfr0rllKaGHeMYve8BK4WIzYtp4HarXW7xlNfPLq5k8dXKQvKT+9YgkGGAIA4pGLWRELFimUCf7LWzsvRPnMxsSmzSlxYcVhq10LvFMo0Cv+/zMQf6BZ3IU9zhFA9d/ah4iEnH+uWyhAazGJ4YU9XfQUJyXWWa9TlEOwtWPgQQe+U8ZWpMHzSSlAIjTe4TW32dua0yBW2mWDmmLpqCdSEFApTOh75jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6506007)(64756008)(66476007)(55016002)(66946007)(7696005)(76116006)(478600001)(110136005)(8676002)(8990500004)(66446008)(7416002)(83380400001)(33656002)(9686003)(71200400001)(52536014)(316002)(66556008)(5660300002)(82950400001)(10290500003)(82960400001)(86362001)(54906003)(4326008)(186003)(26005)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?biB/3TESt7AZjuJn1IsBaHmOkEJzYtwR3VhWQsFrN/GSwbPV2mRP0WZxXe1A?=
 =?us-ascii?Q?qYzylI8qH6vBU5R9ZKB61/LjFs5Ga+BhM28QHlFC/DEY5w0ueVofZ623/CjU?=
 =?us-ascii?Q?YPsHx0HpLr/Ubf6cJpl1UqqX1A9YDA+1jAQ6GlbLV0Xu59WfqXqBsKFAXnEp?=
 =?us-ascii?Q?RNWwlY4xpGJPQBlE6QQGtOcwUcI6PJZF/aQGUtNC67U1FtLbX0fepVA9GDtn?=
 =?us-ascii?Q?7UyuCN4BUblPmTe3t2Zqid3k006ftS7do6Hgl5AESr74ZmF75XQMqg2gNQ1d?=
 =?us-ascii?Q?8DgeoEE9iMyBsWUlgfM8ohNE/VXy6gQRBjgiQGf93sU4bRuID3AhVXC8TPck?=
 =?us-ascii?Q?FfI/G1KE9Q4JwAVo7Xnsn1gexG3Aif5oXPepWAMo62EsuZvX9pABVvbwD6YP?=
 =?us-ascii?Q?MZ1UqhFDuj+jg1Act2tY99FS/ned0ZDmVla42qTsOF/IBdJI8T/JBOqpggtw?=
 =?us-ascii?Q?9FlGVgf10EwlQEeOig7ccwPkRV4+CXrB8yMf531oRGUMEvsbatV4ZLRuYAGJ?=
 =?us-ascii?Q?zNLPHMTQj7GBnjvJYXijTZizb+dQfTsoDuzGwfx7vgjmEOEQOXpSfLefaBT+?=
 =?us-ascii?Q?pRKS+4Yz8+gD3cEJSHndnxqWm8zzOE3gXatyldjhcp59ncsBmgPWrGwSVf00?=
 =?us-ascii?Q?RWiR7rXZj52sbq3stfIO4V5zbj3L5BzLd7CDbom4XmLkvjSMGLcXmRbsr+rA?=
 =?us-ascii?Q?0Op2Bi7/MyrT6ciRXu7JP5oojXJtH54PCDPWoLqu6tZS8g4EXVTDFsg8su5t?=
 =?us-ascii?Q?Q54otGk6kPYGWbwhoZuOs9/AQ6GwUR5gDwfUPi3OagaOYxU4euEkwmWLsiLC?=
 =?us-ascii?Q?DyyXjjOhFhmDYSr5HSfnzyY2DuVH2ATmVc70hZvhgv9atUmoQ9amIaCVeipe?=
 =?us-ascii?Q?3l5Q0OU1ul+5JEVsv1MQb1zJtWLCztutXCVbWro0htEy/HGE8qEK9JAwIQ0Y?=
 =?us-ascii?Q?i2t8r+czeThZ8pHJhNE6sACvmz80PZyZwolLSjU7nhekhjl1j0C6poqJ1j54?=
 =?us-ascii?Q?jnHi3+drAvGFFr/0iSXWLoCixpD+WOoLj9dHzwbqU17g1t4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f271ce34-67bd-4310-e7b6-08d8c3edc687
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 00:35:27.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: barWfudVuYGNoDXR3uKvRpxSXvSL9a0GJyBeADZhLjE/B1D6coK56cV6fLBqDfTOUEoLDetvtHCo08fwYag43p5lw0ORBKbYYnCidBn/hpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Janu=
ary 26, 2021 3:57 AM
>=20
> If bit 22 of Group B Features is set, the guest has access to the
> Isolation Configuration CPUID leaf.  On x86, the first four bits
> of EAX in this leaf provide the isolation type of the partition;
> we entail three isolation types: 'SNP' (hardware-based isolation),
> 'VBS' (software-based isolation), and 'NONE' (no isolation).
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: x86@kernel.org
> Cc: linux-arch@vger.kernel.org
> ---
>  arch/x86/hyperv/hv_init.c          | 15 +++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h | 15 +++++++++++++++
>  arch/x86/kernel/cpu/mshyperv.c     |  9 +++++++++
>  include/asm-generic/hyperv-tlfs.h  |  1 +
>  include/asm-generic/mshyperv.h     |  5 +++++
>  5 files changed, 45 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27c..dc94e95c57b98 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -10,6 +10,7 @@
>  #include <linux/acpi.h>
>  #include <linux/efi.h>
>  #include <linux/types.h>
> +#include <linux/bitfield.h>
>  #include <asm/apic.h>
>  #include <asm/desc.h>
>  #include <asm/hypervisor.h>
> @@ -528,3 +529,17 @@ bool hv_is_hibernation_supported(void)
>  	return acpi_sleep_state_supported(ACPI_STATE_S4);
>  }
>  EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
> +
> +enum hv_isolation_type hv_get_isolation_type(void)
> +{
> +	if (!(ms_hyperv.hypercalls_features & HV_ISOLATION))
> +		return HV_ISOLATION_TYPE_NONE;
> +	return FIELD_GET(HV_ISOLATION_TYPE, ms_hyperv.isolation_config_b);
> +}
> +EXPORT_SYMBOL_GPL(hv_get_isolation_type);
> +
> +bool hv_is_isolation_supported(void)
> +{
> +	return hv_get_isolation_type() !=3D HV_ISOLATION_TYPE_NONE;
> +}
> +EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 6bf42aed387e3..6aed936e5e962 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -22,6 +22,7 @@
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
>  #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
> +#define HYPERV_CPUID_ISOLATION_CONFIG		0x4000000C
>=20
>  #define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
>  #define HYPERV_VS_INTERFACE_EAX_SIGNATURE	0x31235356  /* "VS#1" */
> @@ -122,6 +123,20 @@
>  #define HV_X64_NESTED_GUEST_MAPPING_FLUSH		BIT(18)
>  #define HV_X64_NESTED_MSR_BITMAP			BIT(19)
>=20
> +/* HYPERV_CPUID_ISOLATION_CONFIG.EAX bits. */
> +#define HV_PARAVISOR_PRESENT				BIT(0)
> +
> +/* HYPERV_CPUID_ISOLATION_CONFIG.EBX bits. */
> +#define HV_ISOLATION_TYPE				GENMASK(3, 0)
> +#define HV_SHARED_GPA_BOUNDARY_ACTIVE			BIT(5)
> +#define HV_SHARED_GPA_BOUNDARY_BITS			GENMASK(11, 6)
> +
> +enum hv_isolation_type {
> +	HV_ISOLATION_TYPE_NONE	=3D 0,
> +	HV_ISOLATION_TYPE_VBS	=3D 1,
> +	HV_ISOLATION_TYPE_SNP	=3D 2
> +};
> +
>  /* Hyper-V specific model specific registers (MSRs) */
>=20
>  /* MSR used to identify the guest OS. */
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f628e3dc150f3..0d4aaf6694d01 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -225,6 +225,7 @@ static void __init ms_hyperv_init_platform(void)
>  	 * Extract the features and hints
>  	 */
>  	ms_hyperv.features =3D cpuid_eax(HYPERV_CPUID_FEATURES);
> +	ms_hyperv.hypercalls_features =3D cpuid_ebx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.misc_features =3D cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    =3D cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>=20
> @@ -259,6 +260,14 @@ static void __init ms_hyperv_init_platform(void)
>  		x86_platform.calibrate_cpu =3D hv_get_tsc_khz;
>  	}
>=20
> +	if (ms_hyperv.hypercalls_features & HV_ISOLATION) {
> +		ms_hyperv.isolation_config_a =3D cpuid_eax(HYPERV_CPUID_ISOLATION_CONF=
IG);
> +		ms_hyperv.isolation_config_b =3D cpuid_ebx(HYPERV_CPUID_ISOLATION_CONF=
IG);
> +
> +		pr_info("Hyper-V: Isolation Config: GroupA 0x%x, GroupB 0x%x\n",

Nit:  Let's put a space after the word "Group", so that we have
"Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n".

> +			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
> +	}
> +
>  	if (ms_hyperv.hints & HV_X64_ENLIGHTENED_VMCS_RECOMMENDED) {
>  		ms_hyperv.nested_features =3D
>  			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index e73a11850055c..20d3cd9502043 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -89,6 +89,7 @@
>  #define HV_ACCESS_STATS				BIT(8)
>  #define HV_DEBUGGING				BIT(11)
>  #define HV_CPU_POWER_MANAGEMENT			BIT(12)
> +#define HV_ISOLATION				BIT(22)
>=20
>=20
>  /*
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index c57799684170c..c7f75b36f88ba 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -27,11 +27,14 @@
>=20
>  struct ms_hyperv_info {
>  	u32 features;
> +	u32 hypercalls_features;

There was an offline conversation about renaming some of these fields so
they more obviously map to the Hyper-V TLFS while also being architecture
neutral.  Toward that end, I'd suggest the "hypercalls_features" field shou=
ld be
named "features_b".  This would align with the offline discussion, and matc=
hes
what you've done with "isolation_config_a"  and similar below (which is goo=
d).

>  	u32 misc_features;
>  	u32 hints;
>  	u32 nested_features;
>  	u32 max_vp_index;
>  	u32 max_lp_index;
> +	u32 isolation_config_a;
> +	u32 isolation_config_b;
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>=20
> @@ -169,6 +172,8 @@ void hyperv_report_panic(struct pt_regs *regs, long e=
rr, bool
> in_die);
>  void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
> +enum hv_isolation_type hv_get_isolation_type(void);
> +bool hv_is_isolation_supported(void);
>  void hyperv_cleanup(void);
>  #else /* CONFIG_HYPERV */
>  static inline bool hv_is_hyperv_initialized(void) { return false; }
> --
> 2.25.1

