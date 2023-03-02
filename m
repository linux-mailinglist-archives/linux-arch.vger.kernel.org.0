Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073026A8A0D
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 21:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjCBUO7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 15:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCBUO6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 15:14:58 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF433587;
        Thu,  2 Mar 2023 12:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaWRKM8qj8Mlfw+60ACjiPeBOjY46KHKMm+UXCFGDpI5PgAf0VDJl0aLrlX6BRpJe4UBLPUmK4bMFLPeo0Xx+eV2/M7id1sWkmzVqQISaLTcTyHf+M6TlU1YzVp51XqmAM8EeMtSQziiINh/7FV36jpVap4yIBWPQ/fA7+aLSEOALLZscxzBXy6mzT1u1JZBYH/h2p3Pcan309CicbzPvxUwI0TRufcwGrKRbq/+l2Y7KytygtCOsKEVUtaJEzCIN7cdwXCG3As9trqlNCbx+qli0q+hQkFk46/o9OwthfZ/u4lLvmT6pkjevkcmcRiDEwhi8cj5jlRNRYMwH0DWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIqEjFK2AXGbZRukYNRq0MQkoFLm0Bwjir76vrLtUzs=;
 b=VJzVZbMg/odxgCDmOV2EDZZ/yA/Act6ww+AiA2pohR43ou49+Ft+V5ClGnsvC+I5Fm1JiyxqeLBahCNZdI0YLzUryitlUcxKi8M9xleHPBdtX6QCKr1KgtfkTKk+hRWr+/V1/Lyk4Y+0IEU4Zd9HvxmTlrtljR0+qIKnjWHd51rRNQ1ScM8/mf4d8KuaEx2+MIs6uc0AFrbKzDYzK6hS+wNlLSxJieBRnCykeOWMHWmnanAEd7BH00+WZ4Wy5u3agVJbK23Ds6nXEQFQZ5LWR9t6cqS9d+ISGgCFEPv/kmLvfC4Dl95amkzMFekR7EMbuBVUZ97y0TZ2yB4sl+V2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIqEjFK2AXGbZRukYNRq0MQkoFLm0Bwjir76vrLtUzs=;
 b=I+Sy5C9uWNsmk7RM3KYJuctTagbuxZDtPR/sQizYxnhSHXPFEkhf2GxnaLxrnlUpxvL615B1j1BCZm+HwHG+5UG76cQqjeGOxRpgSt6/dpgb9dCjUn+c7p+M96GhG6gpDv4o58eihuN5HOPrUtyS9ROTz4w4M7LAF29PrGeN2Pc=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3684.namprd21.prod.outlook.com (2603:10b6:930:e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.5; Thu, 2 Mar
 2023 20:14:51 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%5]) with mapi id 15.20.6178.007; Thu, 2 Mar 2023
 20:14:51 +0000
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
Subject: RE: [PATCH 2/2] x86/hyperv: VTL support for Hyper-V
Thread-Topic: [PATCH 2/2] x86/hyperv: VTL support for Hyper-V
Thread-Index: AQHZTCW/nhwRydqikE2Go5MqNVEY0q7n58KQ
Date:   Thu, 2 Mar 2023 20:14:51 +0000
Message-ID: <BYAPR21MB16889D8038E051CB4AEC3B9AD7B29@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677665288-6879-1-git-send-email-ssengar@linux.microsoft.com>
 <1677665288-6879-3-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1677665288-6879-3-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=881b4f36-bc36-4831-801a-a7b0e7615291;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-02T19:48:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3684:EE_
x-ms-office365-filtering-correlation-id: 6f432cf2-23af-4036-931a-08db1b5ac799
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGyjZRYfQUWRdtxCBChvEfSfBQ7TuxX62fQaZ12SA+pBFEHDCNF8XeMnTlVaIj+pEi51/cBWupEdRDhmhruyMuQV+RJI+q0PMbwnJnYzvAvSrzBUOA9VPB9KWTABOSzNrYE4EYqAyboi00yToCiEgQaB/1RnBMH7E767es8RaUvEi45iFU0qlCVHBIO9df5uWDXkdv1DWOiog2m5VjPGIsCcUUg4fvWvC3K2Hy+Yh1w+vGlqddGMsKOrY9XMQcae6XfyIw1lnarYpNnrYkBNsWFGoi7tDmpKcb7Uc/Gz9oh5N4uifrrIbVhZGze6JeUxjmdX7u3vm5xi40L3rVpaRCMzySe/WUcgZLPD+j384teGm3tVaw22rVY/+na8Lmm1rKdDbs6HmuinjqhMJc9NocvYD2SypWo1IWGA+KeBNLyKXy60HiYAD/HRh/boIVWUHa7fBBAm3aT1gMI3goNHcfExfK1swc7yajRmsZ5dWaeNJfXlrZdHRJUV2I88aV+SQLAE+iDrxN7uB/fduXbP5jeDyxFzF34y80hjWr80KFnnxsHvLJi1omI03Oz7OHW6XCvJuekbB7zHl60XSkJW1JCW7K76HAmQ/Q2hduAlJT3OH8RQ8amxl0Rk3CpH9jxoCQW5k5I3XZLENvZhpU156tV4a2iuFhAr2k/RBurDtbfa5x11/mtqEM67K+KiVU92juhQvOZXvmKq5cLRou6LJmJjs/FKOd06vEwQ+PujedDF9HXYb+TGU4VDK0hjKOr1EneLGeUuebW7lWg08Z94gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(5660300002)(55016003)(30864003)(7416002)(38070700005)(7696005)(10290500003)(82950400001)(110136005)(82960400001)(71200400001)(38100700002)(921005)(478600001)(122000001)(9686003)(41300700001)(6506007)(33656002)(8936002)(64756008)(186003)(86362001)(26005)(8676002)(66476007)(66556008)(66946007)(76116006)(66446008)(316002)(2906002)(8990500004)(83380400001)(52536014)(66899018)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0sPWhr5bL94IbSaRVTxOy/qR8FKZi0M50vdaT3YuoHnT8BngOtbHJybAg5wl?=
 =?us-ascii?Q?m9LpsjYFrS/ehExTsmik7enCg73GmJGdVgLVJ7gQzTMogYolTSR5M2BO7nAb?=
 =?us-ascii?Q?YBQ/Xvq4Wrth9ldkZc6F95PVbXKqxxw3TekcehxbOHoUQvy0biz8+Oakxv22?=
 =?us-ascii?Q?SSPTzGsQjWE4r+q1MPgi8dz6FZEg/4Pbgr4A6egvtJoxTMKfeMbYirsuNwtB?=
 =?us-ascii?Q?WsyerEkJiuo4QLjbsTdd2k3lehCdQJTBtGqdRSUyhVT+p9LE2e4owz8iK3Q0?=
 =?us-ascii?Q?No0KAzQY2cdYkLUbQz6v15TwL/lhHI+pDN5/eJHGAsMdNTHB7EyPbLtBl5Xd?=
 =?us-ascii?Q?wosQa2+37RRZcOHF1mPkwbywkcMjFw1H0UxNah5OEwbs8X8OYpuFBE4Yc8ba?=
 =?us-ascii?Q?yrhGz1UU4AxW4QowxsDrjbBhB/v0osN9XqwmU+LArN5uNSmJQ6rfinNzgBcF?=
 =?us-ascii?Q?uumRFlDmG7zhMrnWyPG3zYAc7mPIlWEZsDtbNgPD26CYf57/nfVfICDJlM+c?=
 =?us-ascii?Q?bKHyy/INHxFZsJ55tgdXPsWZ8O0VPiCufN7QP92HmGHUEcsYuU2l333eV73y?=
 =?us-ascii?Q?FSveZEyo/U/8rIZn/q8Gl0T/imm8frUaW5fFqZ+01R2lYwLDIwfkrH9Qc2BL?=
 =?us-ascii?Q?wNg3DMtDJGZxL5hXnwKxz1T8ky7QEfIQu6P3gPdnRRMJHPXZ+VsVSmzAEwWV?=
 =?us-ascii?Q?9dWqn5v0U5myYD66AUqKr6vRW9BdK60i6FFot5WCJdhCG5VUre1A3crWugzW?=
 =?us-ascii?Q?yxTGF8mzdf1B5aknw3dqNBr32y7tJRNVIWtGBBTmdIFNqROeWRfa5QZdRxS+?=
 =?us-ascii?Q?0ictO/33p4+O1ydZSvIEhssf+DXURfOHBfhrlaiCo3TiqrC2yzFNtswCTPVe?=
 =?us-ascii?Q?t7fZw86Gy45el0o84rxQN1gdPyT9DBVIcCX7wFaOqVs55S/1QTlpxCzbLoQG?=
 =?us-ascii?Q?XLyvl568ycyt6aGfQUAisS3Lo5kmO2KfvAVWtT/Rd9ntAKfUjXQaK5cOmfkI?=
 =?us-ascii?Q?tUlV4VwrzZk3uuuFNYZ3WVavzVA77CUgpGvTGaML+td0AxLXNk8Gi9Nnxg7F?=
 =?us-ascii?Q?w6runI7tM7oYlkgjQxhpD7RN8305vd/Vwx/sajULRBUjz41fA3Qo3K345DL8?=
 =?us-ascii?Q?ePZItj4Db1Rk8OIAV2SNgXUhee8to4kDW8W+pjqTrPH+IGpEfrY+4lqLBaS9?=
 =?us-ascii?Q?vCfSR0SOtKOBR4qGt4+v+h9zs9kjYsrNEFM5DvU1OwCyIveTFBHUbsEomM1y?=
 =?us-ascii?Q?bMJVx3/XwtA3IzKb8u4u6UXM8ECdBq8Azt2GEzbBgmf/la6Fjf8JprukhoCs?=
 =?us-ascii?Q?QavRS/KNJCH9pU2vkIodi9is/naBCnopjWx8h8f146gKrRrkc8TRYO8reP6P?=
 =?us-ascii?Q?iJ5Hk3MfuMtCURfzi6NOUYl2Ji7fZvmx9qkkvUQxl5UyGDwQ9ArrZHKY92sU?=
 =?us-ascii?Q?XdVshP1aUpJUt7eCYjNjEwA0HNFcNKlN2r5N4JTjI6L30KyoyMtRVltLiNcq?=
 =?us-ascii?Q?M/V+bHJtjHz3YS0CE573AtOK9kjin0vJ9cj8vJ4TvMa91W14A4KUcyiTfb8J?=
 =?us-ascii?Q?plHzZmXdAWYOXwhKyvaN7JkDOD1jj3mHL5q2EhkYg2MHAoEI2+/9Pzf6Eb+7?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f432cf2-23af-4036-931a-08db1b5ac799
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 20:14:51.2325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/fFxxmWS7zS98Cu+VO8iSJj4utdBnW1y3AzNpPjOrRFvRgV9IwF81LLADuVWX0Pbloz0Jjm3n1qm7sy1kemtcvkTsTerMI1QkSc82RhJvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3684
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, March 1=
, 2023 2:08 AM
>=20
> VTL helps enable Hyper-V Virtual Secure Mode (VSM) feature. VSM is a

I'd suggest putting the full expansion "Virtual Trust Levels (VTL)" here
at first use, rather than at the beginning of the second paragraph.

> set of hypervisor capabilities and enlightenments offered to host and
> guest partitions which enable the creation and management of new
> security boundaries within operating system software. VSM achieves
> and maintains isolation through VTLs.
>=20
> Add early initialization for Virtual Trust Levels (VTL). This includes
> initializing the x86 platform for VTL and enabling boot support for
> secondary CPUs to start in targeted VTL context. For now, only enable
> the code for targeted VTL level as 2.
>=20
> In VTL, AP has to start directly in the 64-bit mode, bypassing the

Suggested revised wording:

When starting an AP at a VTL other than VTL 0, the AP must start directly
in 64-bit mode, bypassing the=20

> usual 16-bit -> 32-bit -> 64-bit mode transition sequence that occurs
> after waking up an AP with SIPI whose vector points to the 16-bit AP
> startup trampoline code.
>=20
> This commit also moves hv_get_nmi_reason function to header file, so
> that it can be reused by VTL.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/Kconfig                   |  23 +++
>  arch/x86/hyperv/Makefile           |   1 +
>  arch/x86/hyperv/hv_vtl.c           | 242 +++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h |  75 +++++++++
>  arch/x86/include/asm/mshyperv.h    |  14 ++
>  arch/x86/kernel/cpu/mshyperv.c     |   6 +-
>  include/asm-generic/hyperv-tlfs.h  |   4 +
>  7 files changed, 360 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/hyperv/hv_vtl.c
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 947e24714c28..e0d074bd04ce 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -781,6 +781,29 @@ menuconfig HYPERVISOR_GUEST
>=20
>  if HYPERVISOR_GUEST
>=20
> +config HYPERV_VTL
> +	bool "Enable VTL"
> +	depends on X86_64 && HYPERV
> +	default n
> +	help
> +	  Virtual Secure Mode (VSM) is a set of hypervisor capabilities and
> +	  enlightenments offered to host and guest partitions which enables
> +	  the creation and management of new security boundaries within
> +	  operating system software.
> +
> +	  VSM achieves and maintains isolation through Virtual Trust Levels
> +	  (VTLs). Virtual Trust Levels are hierarchical, with higher levels
> +	  being more privileged than lower levels. VTL0 is the least privileged
> +	  level, and currently only other level supported is VTL2.
> +
> +	  Select this option to enable Hyper-V VTL configuration at boot
> +	  time. This option initializes the x86 platform for VTL and add
> +	  support to boot secondary CPUs directly in to 64 bit context as
> +	  required by VTL.
> +
> +	  This option should only be enabled for the higher VTLs that is > 0.
> +	  If unsure, say N.

The wording of the previous two paragraphs should be more explicit.  I'd
suggest something like:

	Select this option to build a Linux kernel to run at a VTL other than
	the normal VTL 0, which currently is only VTL 2.  This option initializes
	the x86 platform for VTL 2, and adds the ability to boot secondary CPUs
	directly into 64-bit context as required for VTLs other than 0.  A kernel
	built with this option must run at VTL 2, and will not run as a normal
	guest.

	If unsure, say N.

> +
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
>  	depends on HAVE_STATIC_CALL
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 5d2de10809ae..a538df01181a 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y			:=3D hv_init.o mmu.o nested.o irqdomain.o ivm.o
>  obj-$(CONFIG_X86_64)	+=3D hv_apic.o hv_proc.o
> +obj-$(CONFIG_HYPERV_VTL)	+=3D hv_vtl.o
>=20
>  ifdef CONFIG_X86_64
>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+=3D hv_spinlock.o
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> new file mode 100644
> index 000000000000..0b67e1bf017d
> --- /dev/null
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -0,0 +1,242 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023, Microsoft Corporation.
> + *
> + * Author:
> + *   Saurabh Sengar <ssengar@microsoft.com>
> + */
> +
> +#include <asm/apic.h>
> +#include <asm/boot.h>
> +#include <asm/desc.h>
> +#include <asm/i8259.h>
> +#include <asm/mshyperv.h>
> +#include <asm/realmode.h>
> +
> +extern struct boot_params boot_params;
> +static struct real_mode_header hv_vtl_real_mode_header;
> +
> +static struct legacy_pic vtl_pic;
> +
> +static int vtl_pic_probe(void)
> +{
> +	null_legacy_pic.probe();
> +	return vtl_pic.nr_legacy_irqs;
> +}
> +
> +void __init hv_vtl_init_platform(void)
> +{
> +	pr_info("Initializing Hyper-V VTL\n");
> +
> +	x86_init.irqs.pre_vector_init =3D x86_init_noop;
> +	x86_init.timers.timer_init =3D x86_init_noop;
> +
> +	x86_platform.get_wallclock =3D get_rtc_noop;
> +	x86_platform.set_wallclock =3D set_rtc_noop;
> +	x86_platform.get_nmi_reason =3D hv_get_nmi_reason;
> +
> +	x86_platform.legacy.i8042 =3D X86_LEGACY_I8042_PLATFORM_ABSENT;
> +	x86_platform.legacy.rtc =3D 0;
> +	x86_platform.legacy.warm_reset =3D 0;
> +	x86_platform.legacy.reserve_bios_regions =3D 0;
> +	x86_platform.legacy.devices.pnpbios =3D 0;
> +	/*
> +	 * Do not try to access the PIC (even if it is there).
> +	 * Reserve 1 IRQ so that PCI MSIs to not get allocated to virq 0,
> +	 * which is not generally considered a valid IRQ by Linux (and so
> +	 * causes various problems).
> +	 */
> +	vtl_pic =3D null_legacy_pic;
> +	vtl_pic.nr_legacy_irqs =3D 1;
> +	vtl_pic.probe =3D vtl_pic_probe;
> +	legacy_pic =3D &vtl_pic;
> +}
> +
> +static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
> +{
> +	return ((u64)desc->base3 << 32) | ((u64)desc->base2 << 24) |
> +		(desc->base1 << 16) | desc->base0;
> +}
> +
> +static inline u32 hv_vtl_system_desc_limit(struct ldttss_desc *desc)
> +{
> +	return ((u32)desc->limit1 << 16) | (u32)desc->limit0;
> +}
> +
> +typedef void (*secondary_startup_64_fn)(void*, void*);
> +static void hv_vtl_ap_entry(void)
> +{
> +	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_par=
ams);
> +}
> +
> +static int hv_vtl_bringup_vcpu(u32 target_vp_index, u64 eip_ignored)
> +{
> +	u64 status;
> +	struct hv_enable_vp_vtl *input;
> +	unsigned long irq_flags;
> +
> +	struct desc_ptr gdt_ptr;
> +	struct desc_ptr idt_ptr;
> +
> +	struct ldttss_desc *tss;
> +	struct ldttss_desc *ldt;
> +	struct desc_struct *gdt;
> +
> +	u64 rsp =3D initial_stack;
> +	u64 rip =3D (u64)&hv_vtl_ap_entry;
> +
> +	native_store_gdt(&gdt_ptr);
> +	store_idt(&idt_ptr);
> +
> +	gdt =3D (struct desc_struct *)((void *)(gdt_ptr.address));
> +	tss =3D (struct ldttss_desc *)(gdt + GDT_ENTRY_TSS);
> +	ldt =3D (struct ldttss_desc *)(gdt + GDT_ENTRY_LDT);
> +
> +	local_irq_save(irq_flags);
> +
> +	input =3D (struct hv_enable_vp_vtl *)(*this_cpu_ptr(hyperv_pcpu_input_a=
rg));
> +	memset(input, 0, sizeof(*input));
> +
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->vp_index =3D target_vp_index;
> +	input->target_vtl.target_vtl =3D HV_VTL_MGMT;
> +
> +	/*
> +	 * The x86_64 Linux kernel follows the 16-bit -> 32-bit -> 64-bit
> +	 * mode transition sequence after waking up an AP with SIPI whose
> +	 * vector points to the 16-bit AP startup trampoline code. Here in
> +	 * VTL2, we can't perform that sequence as the AP has to start in
> +	 * the 64-bit mode.
> +	 *
> +	 * To make this happen, we tell the hypervisor to load a valid 64-bit
> +	 * context (most of which is just magic numbers from the CPU manual)
> +	 * so that AP jumps right to the 64-bit entry of the kernel, and the
> +	 * control registers are loaded with values that let the AP fetch the
> +	 * code and data and carry on with work it gets assigned.
> +	 */
> +
> +	input->vp_context.rip =3D rip;
> +	input->vp_context.rsp =3D rsp;
> +	input->vp_context.rflags =3D 0x0000000000000002;
> +	input->vp_context.efer =3D __rdmsr(MSR_EFER);
> +	input->vp_context.cr0 =3D native_read_cr0();
> +	input->vp_context.cr3 =3D __native_read_cr3();
> +	input->vp_context.cr4 =3D native_read_cr4();
> +	input->vp_context.msr_cr_pat =3D __rdmsr(MSR_IA32_CR_PAT);
> +	input->vp_context.idtr.limit =3D idt_ptr.size;
> +	input->vp_context.idtr.base =3D idt_ptr.address;
> +	input->vp_context.gdtr.limit =3D gdt_ptr.size;
> +	input->vp_context.gdtr.base =3D gdt_ptr.address;
> +
> +	/* Non-system desc (64bit), long, code, present */
> +	input->vp_context.cs.selector =3D __KERNEL_CS;
> +	input->vp_context.cs.base =3D 0;
> +	input->vp_context.cs.limit =3D 0xffffffff;
> +	input->vp_context.cs.attributes =3D 0xa09b;
> +	/* Non-system desc (64bit), data, present, granularity, default */
> +	input->vp_context.ss.selector =3D __KERNEL_DS;
> +	input->vp_context.ss.base =3D 0;
> +	input->vp_context.ss.limit =3D 0xffffffff;
> +	input->vp_context.ss.attributes =3D 0xc093;
> +
> +	/* System desc (128bit), present, LDT */
> +	input->vp_context.ldtr.selector =3D GDT_ENTRY_LDT * 8;
> +	input->vp_context.ldtr.base =3D hv_vtl_system_desc_base(ldt);
> +	input->vp_context.ldtr.limit =3D hv_vtl_system_desc_limit(ldt);
> +	input->vp_context.ldtr.attributes =3D 0x82;
> +
> +	/* System desc (128bit), present, TSS, 0x8b - busy, 0x89 -- default */
> +	input->vp_context.tr.selector =3D GDT_ENTRY_TSS * 8;
> +	input->vp_context.tr.base =3D hv_vtl_system_desc_base(tss);
> +	input->vp_context.tr.limit =3D hv_vtl_system_desc_limit(tss);
> +	input->vp_context.tr.attributes =3D 0x8b;
> +
> +	status =3D hv_result(hv_do_hypercall(HVCALL_ENABLE_VP_VTL, input, NULL)=
);

The normal pattern is to *not* use hv_result as a wrapper around hv_do_hype=
rcall().
Let the hypercall return the raw 64-bit status.  Then hv_result_success() a=
nd
hv_result() take that raw 64-bit status as an input.

> +
> +	if (!hv_result_success(status) && status !=3D HV_STATUS_VTL_ALREADY_ENA=
BLED) {

For the second check above, use hv_result(status) !=3D HV_STATUS_VTL_ALREAD=
Y_ENABLED.
The first check is correct if you remove the hv_result() around hv_do_hyper=
call().

> +		pr_err("HVCALL_ENABLE_VP_VTL failed for VP : %d ! [Err: %#llx\n]",
> +		       target_vp_index, status);
> +		status =3D -EINVAL;
> +		goto free_lock;
> +	}
> +
> +	status =3D hv_result(hv_do_hypercall(HVCALL_START_VP, input, NULL));

Again, the hv_result() above is unnecessary.  hv_result_success() below exp=
ects the
raw 64-bit hypercall status as input.

> +
> +	if (!hv_result_success(status)) {
> +		pr_err("HVCALL_START_VP failed for VP : %d ! [Err: %#llx]\n",
> +		       target_vp_index, status);
> +		status =3D -EINVAL;
> +	}
> +
> +free_lock:
> +	local_irq_restore(irq_flags);
> +
> +	return status;
> +}
> +
> +static int hv_vtl_apicid_to_vp_id(u32 apic_id)
> +{
> +	u64 control;
> +	u64 status;
> +	unsigned long irq_flags;
> +	struct hv_get_vp_from_apic_id_in *input;
> +	u32 *output;
> +
> +	local_irq_save(irq_flags);
> +
> +	input =3D (struct hv_get_vp_from_apic_id_in *)(*this_cpu_ptr(hyperv_pcp=
u_input_arg));
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->apic_ids[0] =3D apic_id;
> +
> +	output =3D (u32 *)input;
> +
> +	control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
> +	status =3D hv_result(hv_do_hypercall(control, input, output));

Same: don't use hv_result() here.

> +
> +	local_irq_restore(irq_flags);
> +
> +	if (!hv_result_success(status)) {
> +		pr_err("failed to get vp id from apic id %d, status %#llx\n",
> +		       apic_id, status);
> +		return -EINVAL;
> +	}
> +
> +	return output[0];

The value of output[0] must be copied to a local variable *before* the
call to local_irq_restore().  Once local_irq_restore() is called, you must =
not
access the hyperv_pcpu_input_arg any longer, since preemption could occur
and the hyperv_pcpu_input_arg could get reused.

> +}
> +
> +static int hv_vtl_wakeup_secondary_cpu(int apicid, unsigned long start_e=
ip)
> +{
> +	int vp_id;
> +
> +	pr_debug("Bringing up CPU with APIC ID %d in VTL2...\n", apicid);
> +	vp_id =3D hv_vtl_apicid_to_vp_id(apicid);
> +
> +	if (vp_id < 0) {
> +		pr_err("Couldn't find CPU with APIC ID %d\n", apicid);
> +		return -EINVAL;
> +	}
> +	if (vp_id > ms_hyperv.max_vp_index) {
> +		pr_err("Invalid CPU id %d for APIC ID %d\n", vp_id, apicid);
> +		return -EINVAL;
> +	}
> +
> +	return hv_vtl_bringup_vcpu(vp_id, start_eip);
> +}
> +
> +static int __init hv_vtl_early_init(void)
> +{
> +	/*
> +	 * `boot_cpu_has` returns the runtime feature support,
> +	 * and here is the earliest it can be used.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_XSAVE))
> +		panic("XSAVE has to be disabled as it is not supported by this module.=
\n"
> +			  "Please add 'noxsave' to the kernel command line.\n");
> +
> +	real_mode_header =3D &hv_vtl_real_mode_header;
> +	apic->wakeup_secondary_cpu_64 =3D hv_vtl_wakeup_secondary_cpu;
> +
> +	return 0;
> +}
> +early_initcall(hv_vtl_early_init);
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index 0b73a809e9e1..08a6845a233d 100644
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
> +struct hv_init_vp_context_t {
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
> +	struct hv_init_vp_context_t	vp_context;
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
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 4c4c0ec3b62e..4ff549dcd49a 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -11,6 +11,10 @@
>  #include <asm/paravirt.h>
>  #include <asm/mshyperv.h>
>=20
> +#define HV_VTL_NORMAL 0x0
> +#define HV_VTL_SECURE 0x1
> +#define HV_VTL_MGMT   0x2
> +
>  union hv_ghcb;
>=20
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> @@ -181,6 +185,11 @@ static inline struct hv_vp_assist_page
> *hv_get_vp_assist_page(unsigned int cpu)
>  	return hv_vp_assist_page[cpu];
>  }
>=20
> +static inline unsigned char hv_get_nmi_reason(void)
> +{
> +	return 0;
> +}
> +
>  void __init hyperv_init(void);
>  void hyperv_setup_mmu_ops(void);
>  void set_hv_tscchange_cb(void (*cb)(void));
> @@ -266,6 +275,11 @@ static inline int hv_set_mem_host_visibility(unsigne=
d long
> addr, int numpages,
>  }
>  #endif /* CONFIG_HYPERV */
>=20
> +#ifdef CONFIG_HYPERV_VTL
> +void __init hv_vtl_init_platform(void);
> +#else
> +static inline void __init hv_vtl_init_platform(void) {}
> +#endif
>=20
>  #include <asm-generic/mshyperv.h>
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index f36dc2f796c5..da5d13d29c4e 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -250,11 +250,6 @@ static uint32_t  __init ms_hyperv_platform(void)
>  	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
>  }
>=20
> -static unsigned char hv_get_nmi_reason(void)
> -{
> -	return 0;
> -}
> -
>  #ifdef CONFIG_X86_LOCAL_APIC
>  /*
>   * Prior to WS2016 Debug-VM sends NMIs to all CPUs which makes
> @@ -521,6 +516,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
> +	hv_vtl_init_platform();
>  #endif
>  	/*
>  	 * TSC should be marked as unstable only after Hyper-V
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

