Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA665C74B
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 20:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbjACTR5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 14:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbjACTRB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 14:17:01 -0500
Received: from MW2PR02CU001-vft-obe.outbound.protection.outlook.com (mail-westus2azon11022016.outbound.protection.outlook.com [52.101.48.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE2715FF3;
        Tue,  3 Jan 2023 11:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0b1GjU2UVeJeOOF9XpqGZJOPiRILPCJtS6FBhrtlwughiHlnsP4dY9HkDrPrETDiuL66N0P1/pIr87LEk1mA9K07L3pcgPSPT213bcptS04ePwDdWSVMuq1GdWGcCcx4msjMo78+1JIfJtmIQWJhHr4aHUliat3FhaTnVIYU6S6vbOoCRSZ2qIjT8wY1jvdNURoCAZeO5OTKvPkwC6zLWkLXiWEoCz56ilN2pExaVUEFVr4cK1vu6qQnPUBDFKMjrhP1qDHOTwhsaoGTG0A8tZo6wBTtyP4RsPeSwltc/7+BAx8Q6JsrlQlQzNiJQ3ChkJSE5a9dHViRfU5Kz4gKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4PkGIhEYE6MDabWTKTxM3gCyaLPFSKj1Zyg01+xa34=;
 b=eCKZAw1ydjO0EoOPMdXOxzFMXmFaUuR3n+YevLPXuNqqFCNjKu7hjl6y5VURd7HBKPOz5jnEUqVr684sEzga1tA9nZDxaj2DAdeO561EL1gjuAGXHmjr62UC6KV6coCBpHR/ctRuzO22sdWJ1KqWelrlCY17VPQ+cH0Z13OydwXwumUh2fnUQdWN8toG6NcnwuPluQ20W/R2Ba7se6bvE2Q6tjiZY8JLvbkLWwJZA+KVvpP7795SCrAJpDwWZq8/opxIToquGwyng0R0QIDMoEdmJ3s35IdjAprahq548bmEpDJz4nxpnu2w5+uZ3z4nUIhS2YVdQxKRnTEOeg0Khg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4PkGIhEYE6MDabWTKTxM3gCyaLPFSKj1Zyg01+xa34=;
 b=VFnt/QjaxXIIBHJG8kKpGvvcDDp3lQTbBSL5n2IiGKyWxMZU1TM5s2fGNOoIjGtLTuhk388+9s6hUXo1ABjrnGJkVpHrIWgX7H0cyZcoY7CSvLlJD/5rIeMpKdnHnbnt4ofY/g2E3Vvp5IrqXqnmNRIJ5JuTFrDbfJLM9W9kPMo=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3749.namprd21.prod.outlook.com (2603:10b6:208:3d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.1; Tue, 3 Jan
 2023 19:15:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::db1a:4e71:c688:b7b1%4]) with mapi id 15.20.6002.005; Tue, 3 Jan 2023
 19:15:08 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>
Subject: RE: [PATCH v10 5/5] x86/hyperv: Change interrupt vector for nested
 root partition
Thread-Topic: [PATCH v10 5/5] x86/hyperv: Change interrupt vector for nested
 root partition
Thread-Index: AQHZHnmpvVLD+m3uzEu9T0k4Q2fsXa6KtlGAgAJbacA=
Date:   Tue, 3 Jan 2023 19:15:08 +0000
Message-ID: <BYAPR21MB168837EA6BBCFB72DE8DC406D7F49@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1672639707.git.jinankjain@linux.microsoft.com>
 <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
In-Reply-To: <021f748f15870f3e41f417511aa88607627ec327.1672639707.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=132e43ca-3251-459b-90e1-534bd6e21870;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-03T19:12:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3749:EE_
x-ms-office365-filtering-correlation-id: b4d4b314-aaf9-41de-766d-08daedbed452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ptAhqc3inK18l++Eq5jyrf/3rbYQxj0Teyz3FqnYt0jwLYVImgYaC06Yo4C4SNgkzr1G6XgUBDTibBZe3QTLTQEYsqhWvJjgRxNhLcspbmLiLhoY3jQBfen3HOwLDfQe+Gjpu1k33CXXNCC6ETDPWr/d9JR6baPVflZbCMhdxWN54uuCcNNEClx11d+wAPgxSfgNuTIoaNTyWqYYwIWxri2AXYve8xgK3PWt/ZSikW+i+RsaVwD0YV0lCDDpuG695yaAsJV1vUDyyFIXYg3f37+JB7b2xo+iwDJjNpKd8A264zWlCd2YBdxK6see3BaP6FJzeC/AUnc6AXMatuqZ/g+PWNoPx+5nliUtPUts2tjfNzDQGzYJJz/95JEcZECePLOAvt3+7YlmM16G9AgL5MHj5ubuoJ+6Di+dKtYmKW7S1OsyUYk3fYUvDmiDSsK4qzsr1E2uUr44G7HCv9vqGdFwgzIhm7Jbx7Mcp+4fUWvXxVmeQK8Tu5NISTtPQPk7JjsCJaxA6J1tXkdtaaoP7VD0DZutTogr3edyS7PV61a6SPm+5ikK44KJ87TeuMXsAjVOYN7cnPyNn2HQwP1PXVph2bfDUtIy8WzA9Fmein6lcswG+vJ9dXoZSAli3d5opxpczcfQ8euX0yP+Mo2dqjRmB5nC56r0k/fZvFQktzSgihg37xDgA92t+uIYQ4avlbuQ1G1M150wkRuKJ/0eZ52LrJ7POx9RciQgpbF/GEsTzL7aEh9j2pM9Dr6lBiaeeolHtuZbq5W1hQm6PCHtCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(451199015)(8936002)(7416002)(52536014)(8676002)(66476007)(4326008)(66446008)(76116006)(66556008)(64756008)(5660300002)(41300700001)(2906002)(6636002)(54906003)(316002)(10290500003)(71200400001)(110136005)(478600001)(8990500004)(6506007)(107886003)(186003)(33656002)(26005)(9686003)(7696005)(66946007)(83380400001)(82960400001)(82950400001)(55016003)(86362001)(122000001)(38100700002)(38070700005)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6Q38CG9hgwhrpKhmq52SoyraBvj5WZcdfJ+qVylno9OEp561kUN0zce6HI4V?=
 =?us-ascii?Q?3zaDhKvXN+35EB5eUftDeA/WrD9MyZjOspSPfoc8WoTPBJeOay7p37JJF1Db?=
 =?us-ascii?Q?i+hFtnMt0SCkqBL8AGuhx4CdGqpnMYochCBxPzmxE4cBLZuX7pOHJUpMHo0t?=
 =?us-ascii?Q?tysB0Ht/HK61yk/aNlJEp12JeW6v3xp95GyXny73q26FjXrC+aTP7IM0B7SU?=
 =?us-ascii?Q?G4jtvlAJ2yBA3EpHedbzY7vqKa3PH9SqYD6/cNEPc3rbuOhWsy5zkwD2tAzq?=
 =?us-ascii?Q?f4Mqj9lMBTsbpajHRFoFGhDqSULuGxjL9iuLegr/HmliMaxuSXKeKPrJGCln?=
 =?us-ascii?Q?a2/H+qEeMUAPV/a+Zx4G2vJ7ExQW/s/0q81qhxc8fBquoMsd6oyYhssFUCcR?=
 =?us-ascii?Q?zQBP1j/D2hO5cpyVk2cI4zfS7u8M3Oo9cpCjSvnv0zRQ5HmYs5I9y7RHFJxX?=
 =?us-ascii?Q?ujLLe35Y22WcMxs9OAzeO1jMUnmBPc1+AWxnmcs1EdNLN/eWvQUlv3MmEEdT?=
 =?us-ascii?Q?4JPvKGv7FG5GDL8cpI57MY3VX0w21dMbXabyGaSBkPnIRyA8fEPeGGmO+vgq?=
 =?us-ascii?Q?29sq314ejRuWiCBe5LFTYPBi1VtmmqJ0Kyuz8VjIgbTeYw86IgRxfZrIXKz2?=
 =?us-ascii?Q?1KeCHZNRbxv0lhEVv3Q8dVwj4bofsJqC88ciSid3+GKB/YOrOEcZ/+Qhasvm?=
 =?us-ascii?Q?dAbH+cxmK/eptsNdg+hcTgbKDgyIO7kcofF878UyRYgOuaEKRpmSDcX5Xw2E?=
 =?us-ascii?Q?c5mUjiejIdBttBt1iQKXXz7oFTqd7l/ue9Lql9plihJ+K5yu3S7jhx3en21B?=
 =?us-ascii?Q?iy6+DuqvlpYl7uDH1PfocKEcR4WygeBqecarrSjoaHoSLFWEk29s0DoiCJuz?=
 =?us-ascii?Q?b3Jaf3tx8xp8GxqLYaUvAr55odsL4L+dzgQM8flJBBqtTDzW+L2YnDTmNftb?=
 =?us-ascii?Q?7viY33EC6EHch4Q5W3leAKq3JyFcv1KCnUtIOjCRQCdhKizTPw+pZ7QYXogx?=
 =?us-ascii?Q?e2HMtSyvmYFGn4uHXwpM/lAWhjfzBlGUpbi6lGttxIwMjG0ct0bgjhh8aD17?=
 =?us-ascii?Q?nfw0m3FgAQ5Wg64e0XYfZ4PZrF6fGtbHdxUgVrjjU7+ckmazl/99Akmqczpn?=
 =?us-ascii?Q?ixlv5mVZpvb6G3XscZYxunx3tn4uY0U8aPgoJAoyeKqnTAmbonx/qxdlBR8L?=
 =?us-ascii?Q?ZMPNQmukfklhgQ6kg4EdtCXffy5KuL5eNUQckXGLj5Hh5Iyk0RxoEvX7YRdi?=
 =?us-ascii?Q?EmUVR5qVEzmbFQqwBK2XZCDEiYBh53aBDH+V2JPoQ4S9I9UbPrqyMXCKXrJM?=
 =?us-ascii?Q?APqwgnE/thuBSOyHoI6FkFoH4bHwcsC0AKV4ZAF5PSKp+w9PFoza+FeiKubP?=
 =?us-ascii?Q?KdMgAlN9GS7KdHnp1Tn6FyjoMPKuZCLlnz1CtVw9RrCkvDFHl8YQABIT5/PD?=
 =?us-ascii?Q?7YlgYMyUNsAdhfX2NDad0fZi/KSfXucyEugMu929MrsWDU8FoZSeOBf8s0Ix?=
 =?us-ascii?Q?NEoRZGg4iOGLufL5XpZIE0exhXdV9nGhQ+A7GXHim5chKurMT3YuPbH7Sqkf?=
 =?us-ascii?Q?bsUyzi7kDX/gfRbIX0eafPZkpAL4XfIZ8aD6R5yiLSbEA7+ZiXteVuPVwQIF?=
 =?us-ascii?Q?EA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d4b314-aaf9-41de-766d-08daedbed452
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 19:15:08.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUClqr7SnRTp2MWQ9IPXeZ5ctpJ5eHilZaRxsi+EzSokhYwp7P02/CH8SjoDq2G84bjGwpn9QiRKIY7FVknDs4XRzV1R4MlEy7OoVMhaPjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Sunday, January 1,=
 2023 11:13 PM
>=20
> Traditionally we have been using the HYPERVISOR_CALLBACK_VECTOR to relay
> the VMBus interrupt. But this does not work in case of nested
> hypervisor. Microsoft Hypervisor reserves 0x31 to 0x34 as the interrupt
> vector range for VMBus and thus we have to use one of the vectors from
> that range and setup the IDT accordingly.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/idtentry.h    |  2 ++
>  arch/x86/include/asm/irq_vectors.h |  6 ++++++
>  arch/x86/kernel/cpu/mshyperv.c     | 15 +++++++++++++++
>  arch/x86/kernel/idt.c              | 10 ++++++++++
>  drivers/hv/vmbus_drv.c             |  3 ++-
>  5 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idten=
try.h
> index 72184b0b2219..c0648e3e4d4a 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -686,6 +686,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,
> 	sysvec_kvm_posted_intr_nested
>  DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,
> 	sysvec_hyperv_callback);
>  DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,
> 	sysvec_hyperv_reenlightenment);
>  DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,
> 	sysvec_hyperv_stimer0);
> +DECLARE_IDTENTRY_SYSVEC(HYPERV_INTR_NESTED_VMBUS_VECTOR,
> +			sysvec_hyperv_nested_vmbus_intr);
>  #endif
>=20
>  #if IS_ENABLED(CONFIG_ACRN_GUEST)
> diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/ir=
q_vectors.h
> index 43dcb9284208..729d19eab7f5 100644
> --- a/arch/x86/include/asm/irq_vectors.h
> +++ b/arch/x86/include/asm/irq_vectors.h
> @@ -102,6 +102,12 @@
>  #if IS_ENABLED(CONFIG_HYPERV)
>  #define HYPERV_REENLIGHTENMENT_VECTOR	0xee
>  #define HYPERV_STIMER0_VECTOR		0xed
> +/*
> + * FIXME: Change this, once Microsoft Hypervisor changes its assumption
> + * around VMBus interrupt vector allocation for nested root partition.
> + * Or provides a better interface to detect this instead of hardcoding.
> + */
> +#define HYPERV_INTR_NESTED_VMBUS_VECTOR	0x31
>  #endif
>=20
>  #define LOCAL_TIMER_VECTOR		0xec
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 938fc82edf05..4dfe0f9d7be3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -126,6 +126,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
>  	set_irq_regs(old_regs);
>  }
>=20
> +DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_nested_vmbus_intr)
> +{
> +	struct pt_regs *old_regs =3D set_irq_regs(regs);
> +
> +	inc_irq_stat(irq_hv_callback_count);
> +
> +	if (vmbus_handler)
> +		vmbus_handler();
> +
> +	if (ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED)
> +		ack_APIC_irq();
> +
> +	set_irq_regs(old_regs);
> +}
> +
>  void hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  	vmbus_handler =3D handler;
> diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
> index a58c6bc1cd68..3536935cea39 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -160,6 +160,16 @@ static const __initconst struct idt_data apic_idts[]=
 =3D {
>  # endif
>  	INTG(SPURIOUS_APIC_VECTOR,
> 	asm_sysvec_spurious_apic_interrupt),
>  	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
> +#ifdef CONFIG_HYPERV
> +	/*
> +	 * This is a hack because we cannot install this interrupt handler
> +	 * via alloc_intr_gate as it does not allow interrupt vector less
> +	 * than FIRST_SYSTEM_VECTORS. And hyperv does not want anything other
> +	 * than 0x31-0x34 as the interrupt vector for vmbus interrupt in case
> +	 * of nested setup.
> +	 */
> +	INTG(HYPERV_INTR_NESTED_VMBUS_VECTOR,
> asm_sysvec_hyperv_nested_vmbus_intr),
> +#endif
>  #endif
>  };
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 6324e01d5eec..740878367426 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2768,7 +2768,8 @@ static int __init hv_acpi_init(void)
>  	 * normal Linux IRQ mechanism is not used in this case.
>  	 */
>  #ifdef HYPERVISOR_CALLBACK_VECTOR
> -	vmbus_interrupt =3D HYPERVISOR_CALLBACK_VECTOR;
> +	vmbus_interrupt =3D hv_nested ? HYPERV_INTR_NESTED_VMBUS_VECTOR :
> +				      HYPERVISOR_CALLBACK_VECTOR;
>  	vmbus_irq =3D -1;
>  #endif
>=20
> --
> 2.25.1

I'm giving my "Reviewed-by" based on what I know, but I'm unsure
about the validity of grabbing vector 0x31 out of the middle of the
range versus at the end like all the other fixed vectors.  Getting
this changed on the MSHV side would really be a better solution.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

