Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CC262F990
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 16:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiKRPlz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242443AbiKRPll (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 10:41:41 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020020.outbound.protection.outlook.com [52.101.46.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA07992A;
        Fri, 18 Nov 2022 07:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN+2Nbi3tWx1I+GUCbLI0JuwPxEEJyhbQjt7Pxl4ltQUpRBoq4GWbjqj7tGoiBTm5qVD3+B/Jx3fo7dwjeCZXnokmf38cKUvyz3JktBqm8umuDgg0hMOiYuL3A72J7QMmY7xkrxaqZFNmm4hXiL6eWx+9sSBqmd2FLRtx9zXBDWLe9d5oa/bNHHk3dTG0KMW9NmKiJg9ATtTsJUrtdmKFJDVashHzt7zkiyqY672irjSYzu9ir3Ri2mggcQ88d0ShBUXMeSz0pnC+yYFgxRJQXZaGOJkVppxWAPvHrXE37fu2YDs6TwSbAiFcCQ2EnFVSU/S/3wzRZNQVoH4Kb+JJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzu2nBgqpHLpUEImC2icwrO40tSK7Kbz6bQBRWf1cbA=;
 b=cVsjOvqI5PhwnN15n2Lp67P0QGwlJHEoimE87LVuhywKcU1TOW5/RcmbX4bU4WTxo7HT9y3hWoVF/cSUSASdoQAnwDcpbskjJ4ouodvJqYx/dn3sQ3CRnHy/s9DmeTs/A3JoIFHEjbTxOXblAwAQU8QNoMF/to1AKSjVc+EvzCluW2JjFyqUljCsHLq39bRXdY9oQoj7To0sOyXY4KSJfwofepJj9Y1qKE6anSDA3xeKYImtdbNqymkiBPdJkat+WsXsfmCW1y39XOXoa5lfCmRMCKyB5WBQm8Sttk9PdFDZpCJF8MOdwyyIMQfGPDn+X4QvVQmhyASHXcYiVD+2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzu2nBgqpHLpUEImC2icwrO40tSK7Kbz6bQBRWf1cbA=;
 b=jiM9nVabzzxaK1wSrEiRLqZ5/vcHYgEyRuJfSoySiSrQApS1hgPKUHtYb3oNxUm83ldi4nh4U0sIVKqPBZPhXzosrEHOXLV3PrY9ssnb8e231iXvq4TbRNEGOm14dRbBpNasRO8PtqqjcKHQE9Zlq6md+D2JkjoNwpq1RFlUv7Y=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3331.namprd21.prod.outlook.com (2603:10b6:208:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Fri, 18 Nov
 2022 15:41:33 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 15:41:32 +0000
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
Subject: RE: [PATCH v4 5/5] x86/hyperv: Change interrupt vector for nested
 root partition
Thread-Topic: [PATCH v4 5/5] x86/hyperv: Change interrupt vector for nested
 root partition
Thread-Index: AQHY+jSrGM61zYIyYkSIBuTFWlgcbK5E0tNQ
Date:   Fri, 18 Nov 2022 15:41:32 +0000
Message-ID: <BYAPR21MB16888EE1161A550E1050F0F7D7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1668618583.git.jinankjain@linux.microsoft.com>
 <42848accc9dbe87a48a0f2ceb7ae9294452bda68.1668618583.git.jinankjain@linux.microsoft.com>
In-Reply-To: <42848accc9dbe87a48a0f2ceb7ae9294452bda68.1668618583.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9b4cdcbe-3d2a-412c-9c4c-d6c2d7e87f4f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T15:37:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3331:EE_
x-ms-office365-filtering-correlation-id: 9d993aee-5de8-47ce-362c-08dac97b5e6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HdXH4FMCxAa9TwCu+Druz7lMJvXmQMnvWmX9FZ4TkQt52XowjxSdzshZ9gvsHMBkHga8BXnZzt3imTDA3BPSD3boy7Ev5+34Us+Z+j4NoR2Q/CvKynxDF5oo8nOvULz2ELcJeBtm28gDovQCAwNVEheaFACL9Ni9MqJpZCZlAJosTJgEj0ZENCth2uiY5tGnDFMbJOvRz3lVlBGfS7T/BsespTnCmUXs9JMtQT5rtEaaMnssAbY7GnTniuAWvIdrexHl4OpANWnXknDx3/S/JSluAQDIJAFWawU72PCFTxKYmMtKhDkAVt6GfHa85NXvtf1/4SmEWxLeF6pZeUyXbAI+DK1l9FIBx0PSRwQfkKXGN8obkYezg0VFN/eEN9JRtykaECNIH8oWkJWf8bRmDC3FZtV8T+x/8BxvtWXHiZP7gDzW2dIHEw5V9aKYrDv/TeIqddI6U5Ke6gMZz69XsaTY/vWe1vyyX8zJKA2LdHzaUSZIpcMcyJGvbCJJqoZGwe6upZ4gyLnOCAbfS341iiDH2ehq7npFpHI+kJAvXMyV87fIm2m7P72u+BRYvjOPqFZ2HsV+9vs/JqF9Fabc1lOS18F/+CXT4r2u49Xsgp3c72wvm7B/HLeTO8kgjTKhVUsL53oZyvjluECFnX3wiC6JNKWxa1vfW0B4bQ6UN8yt3DbF1HTsWQMy0qp30sTxDoiLJjycP1mzCOVqoXbQMTq/gVqCnOIvRSi5q9WdG6tUjoYwTlLv8PTl9fPBFBnT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(5660300002)(316002)(7416002)(122000001)(71200400001)(478600001)(8676002)(86362001)(64756008)(66946007)(76116006)(66556008)(66446008)(66476007)(4326008)(8990500004)(26005)(107886003)(41300700001)(55016003)(82960400001)(8936002)(82950400001)(38100700002)(110136005)(6636002)(38070700005)(54906003)(52536014)(10290500003)(33656002)(2906002)(186003)(7696005)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rk/65JEN16Z03nr6B1anWuyUI55paGOPJlxCVae06uj3HAcSWCHuE42pqOek?=
 =?us-ascii?Q?+fGXV3vhiS1S+GKhzI3XIw9Vm33XF45GT2FVbnjItjKwu3ouKK+acmynuuyr?=
 =?us-ascii?Q?AcPVaAFrJSvQ7Y4FuavHc16wLmhQ/HMIOdTs5Ez4pBNN5KGEsmqRefwlbPbz?=
 =?us-ascii?Q?C/s+5kQ1k6BtQ1JJHs7O7wgB8fCTVBc7AGlcFqrNdsyBnwLxoji/jLAA2hiF?=
 =?us-ascii?Q?4viWGP8d6ZsL83JXrCs19YfsltrMZ1EO7gSOoAKkazGV6sglb+STAWfEhQ3v?=
 =?us-ascii?Q?YvKNsIesoCkh/Z9nLZBB9kdzxawmPSqU6c7dLYuUmidkCFzGUtcRxUz/KK5k?=
 =?us-ascii?Q?wzor6OGP+EeJCN6UuPjWnPSuT+NH5HlG7Sx0RdYv9EENKt9AvgxZIYxUIZWU?=
 =?us-ascii?Q?0pzlEaBDUP+hJqr6iYQf/lmcXocbwjihnwiaxnZtKoFyhD46g/tWw7a/4zTs?=
 =?us-ascii?Q?J6VH+qSFsvzTdJt8dMJtU+X5S01PQhjI+veWpy6BLVmAbio58DJCRZej/KNM?=
 =?us-ascii?Q?uHU5kKBKfb3pssyNfFDtoF2KvZRORx6/4+0zzWT6MkldQ37bO9IgPz14lrtf?=
 =?us-ascii?Q?9Xjqb4vrJ/edYNt58NNE+Tz492inKoOAked9E6gu5S8C6LuPirufvh85xrsM?=
 =?us-ascii?Q?1uaskXX6V+DrReTcxjWUjAHdLZTr5hmbnqBWfKZaBMg6xV0oYxODbLmDwERr?=
 =?us-ascii?Q?+0+xIVTupgdMLrohzohqcc3aGWQH9ftEd7FkLfh+E9WiF310YVGsr/xToQpq?=
 =?us-ascii?Q?XAQUXToCz9EWjQuUtWrIMwknI0K9EBOjal8GhQ5OShciay29T01XaiRHLI9f?=
 =?us-ascii?Q?TTRbQaaFMS03Yz9RJcFoAeTy3O8e5/EJ/hP1vzpPEGjxGaanPOek8OEJNnUu?=
 =?us-ascii?Q?aNW4pMV8/PYX9Mv08PkEJsIDyoasg9TK8/FWGfUVZjx7m1MfsPqCtKc3zoYF?=
 =?us-ascii?Q?aepNQ36PnSS0vwBCaqAHdnwCFryN6IGhE8Zbtp20dtlOdcMtqHO1w9PTo8Py?=
 =?us-ascii?Q?tnydbTWp2d8HZIpFnc0ov4V2ZrtlwdKRy4T30ig03K+pQWT4e33yhh5jJTTL?=
 =?us-ascii?Q?oedmeWRLUmG7OSRv7JwJA/ut/cEOtbifBvP0lbuYCnR+Q724eJoiHI3eJew8?=
 =?us-ascii?Q?frUy1NswKjb2/zLyMCPG0QeqDpvfLO4KUdoyrF8OO36gMEOqGOztA29DdPp0?=
 =?us-ascii?Q?mIrLVJJ8B5wn7s/j0CuS8Q5jVncBsduOfrrpFgZl8DyQAHy5QmTWxGZ0qUaf?=
 =?us-ascii?Q?2YEZLUuoUF8AsRueqLcPvVgiujc+kjoqir5AE9iAOcs7+bcG9LaNpzO1NIq9?=
 =?us-ascii?Q?14ybgHthkuWll9pC6Jc1oVDZ7kuqe/DFdVzb79/2D9NQsAUzLXr4dFcY9PMa?=
 =?us-ascii?Q?gFSKJEykTQYDA+p+KluCtokaFcYouSB7JMqjdnGWoDXHJhwFlkKxkJ2dMxmY?=
 =?us-ascii?Q?n7RYSy9VRuhKGfNL0sUImJ6XpBOQAgveb2nztO5Qohd40sf+tDQn4uldKztq?=
 =?us-ascii?Q?GVGrumdONbzsy2CX0mrPX5tzFAK/A8QKUJTQYxWGDmqaLz+TJYjKCpCY/ZJf?=
 =?us-ascii?Q?XQyHvquazfLWSgH8wob4TrNRMfuM4PlvfESy/xzr21uEItznaM1KSKLqIS3L?=
 =?us-ascii?Q?7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d993aee-5de8-47ce-362c-08dac97b5e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 15:41:32.8188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IM8f02wSX6B6wiavSUgSdt+PQ2/5DRPKdK4QXq9vbCl3//H64TeH9jGzyHWQ2jZHFX24SeZnWYvJ3c1ZoySYDvjbegVXXuJsBtrWGQxTKLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, Novembe=
r 16, 2022 7:28 PM
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
>  arch/x86/kernel/idt.c              |  9 +++++++++
>  drivers/hv/vmbus_drv.c             |  3 ++-
>  5 files changed, 34 insertions(+), 1 deletion(-)
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
> index 3e6711a6af6b..ec7fef43e03b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -110,6 +110,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
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
> index a58c6bc1cd68..ace648856a0b 100644
> --- a/arch/x86/kernel/idt.c
> +++ b/arch/x86/kernel/idt.c
> @@ -160,6 +160,15 @@ static const __initconst struct idt_data apic_idts[]=
 =3D {
>  # endif
>  	INTG(SPURIOUS_APIC_VECTOR,
> 	asm_sysvec_spurious_apic_interrupt),
>  	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
> +#ifdef CONFIG_HYPERV
> +	/*
> +	 * This is a hack because we cannot install this interrupt handler via =
alloc_intr_gate
> +	 * as it does not allow interrupt vector less than FIRST_SYSTEM_VECTORS=
. And hyperv
> +	 * does not want anything other than 0x31-0x34 as the interrupt vector =
for vmbus
> +	 * interrupt in case of nested setup.
> +	 */
> +	INTG(HYPERV_INTR_NESTED_VMBUS_VECTOR,
> asm_sysvec_hyperv_nested_vmbus_intr),
> +#endif
>  #endif
>  };
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 0937877eade9..c1477f3a08dd 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2767,7 +2767,8 @@ static int __init hv_acpi_init(void)
>  	 * normal Linux IRQ mechanism is not used in this case.
>  	 */
>  #ifdef HYPERVISOR_CALLBACK_VECTOR
> -	vmbus_interrupt =3D HYPERVISOR_CALLBACK_VECTOR;
> +	vmbus_interrupt =3D hv_nested ? HYPERV_INTR_NESTED_VMBUS_VECTOR :
> +					    HYPERVISOR_CALLBACK_VECTOR;
>  	vmbus_irq =3D -1;
>  #endif
>=20
> --
> 2.25.1

Given the backdrop that this is a real hack due to MSHV limitations,
this looks OK to me.  But someone on the x86 side will have to weigh
in on whether this will break anything in x86 vector management.

A somewhat dubious,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
