Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D06787111
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 16:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbjHXOHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 10:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241458AbjHXOGs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 10:06:48 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE05019BA;
        Thu, 24 Aug 2023 07:06:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NruUgT1iDurMrc/Kz1lVN7FMq+e6Z9jFJIOy6OQlmoECgOVKSAqXd+4S/rZo3mHyj7HVJMDP47NsQ2pKjQByBV/6IlwAYzVpa6EX61AzA5Au1RkkPpM5ECDaPPYHwQeI9aSrwMfBWpI0tdb/5UoFRIhcP7YjTILnHXnIVNw1e3Ph7nu7ggIhI5W0SYiRcdlG5JcOPP5xM8OxwZQInBh0XeXOIG8gFs+8MhgIxPHrkRh1afaQoLZg75FHFnbvV1MJOMhTipfqCpf48BZGFIRCk5dl1Y3uY1400Dyhf2GE0UXORka68g453FHdWEbrvCOH9TwCVU2auky2mMvczL6GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rW5iRKD81YvSCfISgmdh9QPAm/mSFsIl6ZxIc3IVs8M=;
 b=YOGqp3FT3Nti9rn1s5qf/onXa4b/jN+ON4Na32N0BOg67i2nRzgTOOPKI1pprJ56r0QiCmeTVx5kTWPZAFQdb0jrz01Eo0hlyQYUMqdHNJbr1o2mfPC3yf0mSdlFB5sqX1QXcMqGEdHyjcnSrEedUTu3GIMnsUpaf6BJ0Uj2MG6A/jlHG72Wq3xqkpQFzdV2jhhtw3OIq1hOmdEUaAP3vsADZeGZ41kaFauSmEhWnolRv85YiXVN5WJLxLNhJIDEtZJFLTvZG3duJZwCm3Bq7U31sjbtnYvjuCgVFesMsvF6kL1dJGN8HiTQ/kI7IS3SmVMUnreWvzuEZAiapdaICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rW5iRKD81YvSCfISgmdh9QPAm/mSFsIl6ZxIc3IVs8M=;
 b=X/tCbgIyCzYOqjJyIBy9TstN13BTc5vTRVvmc0ARqMhev9c2CvLt5+aJXuZAVFaPuUMb8oCYSxJ6RROTkj3MIR6IZ6xBhvaz96tvH5IZZn1tg+QUks57IR1kruy0ZeLo0yQj4wD9Wk9rrBJDM6vx/tftlmbC2N4ZDoq+RI5VDT8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1533.namprd21.prod.outlook.com (2603:10b6:208:1f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.6; Thu, 24 Aug
 2023 14:06:42 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.005; Thu, 24 Aug 2023
 14:06:42 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v3 06/10] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Topic: [PATCH v3 06/10] x86/hyperv: Introduce a global variable
 hyperv_paravisor_present
Thread-Index: AQHZ1mIfHIt7pNNA30SpUuTlT2+9ZK/5e2mw
Date:   Thu, 24 Aug 2023 14:06:42 +0000
Message-ID: <BYAPR21MB16889E3C1EA35BC8D248959ED71DA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230824080712.30327-1-decui@microsoft.com>
 <20230824080712.30327-7-decui@microsoft.com>
In-Reply-To: <20230824080712.30327-7-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=56d05a7b-85d3-46b6-9922-c516dd3f9f89;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-24T14:05:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1533:EE_
x-ms-office365-filtering-correlation-id: fd1d36e6-9c9f-4bd2-513f-08dba4ab57b3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NZObLmIrAYkzcgg4BQI0lkanYkth/GAT8jOnJWEHcBGCd70IH6l2YfvVN/6a7+B3rKhx8gmZeKJRwoG71ITmQvBaSlxXKyfTvGUawUyS77mqhzgHLtxBO5i7gsrMEd8kgCzdSHm4lcr53aTP2ikSGwrlOxtwQoywvo86JigboDG7B21YNpiEkvMmlm1p2yAJBpZv3cdMXXbpW8uAvlCSxXTY5TNvoRPEoZILalq0eierKgqkx+W3mb+HsqnecQa4wuRuUPgQZedHy6IGOWiIxylVg70xMyqYh2mbo2ifuRPw1aQYab3LvUtlFWd+2F/cNbzNA7BVboKAyf6KIndNv0OyK+raJDn7wuoq7D4acr+e+6eBqhTFmYs4bDdF14XD63lIxPySoHQK/gfxrC4BjrFyzW3GeerxmM6V3Suu0r1D7Qck5Pqzbd134BqF2x6fQcn13PHZsyFmjOgqkARzKU88e4kgGbGe0N+PLSFF6/EhJOa1DkTxR8Vskb1X2VCqwimm6+MK830UN9r2iGHlO+dl6whUv16dSH4cKWDEZe3P4VG9GW6z3IKCmzvo47zMAm5g9ggAC8ql5sprl0LWwCNAEYD3dEmkA5Svqy6wfiqwwk8voHWBrN8S7S4M/0erjHJRpeB+r3NloqUNAgE0qkqVaa5LM6xx1/QoN9xqKXvVllCPa60qd2fTggQOMYGztGr9jPIexxaIPnIjyhdWFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(7696005)(6506007)(71200400001)(10290500003)(9686003)(478600001)(83380400001)(26005)(2906002)(7416002)(7406005)(110136005)(54906003)(8990500004)(316002)(64756008)(52536014)(66476007)(76116006)(66946007)(41300700001)(66556008)(4326008)(8936002)(8676002)(5660300002)(921005)(33656002)(38100700002)(55016003)(82960400001)(86362001)(82950400001)(122000001)(38070700005)(12101799020)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IdtfiAWNubt+lHU7WwAsdW+oYdurcsN7oXp1CxZrWxRv6LyEbdXoAcfdbQsd?=
 =?us-ascii?Q?EDRfD0aNoQA62WNu29EJC1ZC7Kswr/Jl9SN0hzZdFCFq5z8ADJD1D0EE99Fq?=
 =?us-ascii?Q?CxG7e44C5gBrC6rDwv5bTNdPi1KdQWjmGW3eXmG6IEB/MBTHg0L03WOCFW4h?=
 =?us-ascii?Q?ImdUmw1QcptC6154epb1NhJN+dVhX/QgXXujptHomGt4y9Cz0FMQPo0RXEdD?=
 =?us-ascii?Q?qlL97SkXkFVSdYigs9WvpWGqgJ+YDkTKvAZBLhKpkdrXm5ktpu7nICWH7lu4?=
 =?us-ascii?Q?RlxZnWbp1OLfpeyaqgHUltO0aqTbT4pKoEX/y/e5U1TFMkLNnhPvCZ5snM/E?=
 =?us-ascii?Q?lDRxWI0ygPrJr7fy2zXobThDNAOwo9812+tfMx+6axujdddegdxg1BB+9nwk?=
 =?us-ascii?Q?ctN/YKJl0FYcDwhNSOiELR1+PIcyQWwblHQZaL+XxaDctgp0OSZK1vWyftsd?=
 =?us-ascii?Q?8EUnypVAz7x2zxuG63q1cCDVXIgnQ8AFawOnO1Dbbc8ezEGow7TG/ldwjkO5?=
 =?us-ascii?Q?OoOQ334mmoYepDODlxRZZ9UR0Kf7+0IM4TCDFd7c6M/GtCtWEIvOxpeghENe?=
 =?us-ascii?Q?3/k2iJCTNTansss5uefi8vn1Se4JghLu8/Dco+Hr5G/NUk7DKLInN1Osy6eP?=
 =?us-ascii?Q?pkL2zeRX9fuf3Pf3nOmYTFjDuZWag4pgZWiFviSr4gEjlFPwheuL15vkdeWS?=
 =?us-ascii?Q?99ro+Iy00PlMVSF6nj0n59gPblf+Mtg0EOrLxid8K+1u0jUAQNWO7fHl/ief?=
 =?us-ascii?Q?ymBRk28Y7Lk/SrUFA08hs6Rr3LHC5ZNEd7o0GJHZhUe9y2N/d3Q1MvG9OL8T?=
 =?us-ascii?Q?z4MVTGjiWe1yuZdPqNqXsJmoUUnKo+evHNMdcKSHxXXh6lGyjFtD/I/LUfms?=
 =?us-ascii?Q?Lzbq4iYsL1gbdAmhwmf4HPIyCKUL4q2Qby1TABXoZie7/k6BmR9ygHWRe0uE?=
 =?us-ascii?Q?BDtpZJUTa2r2cGBRmBElu9L3MZ6Ylmko2o80uWUtl+adC+Wbv9idmIKDsryb?=
 =?us-ascii?Q?tex1CNb1UMGbAkvw4S9I7NCzeYDi92dRFDDzLHzLJFX1ebFNTaP7b6JdUEo0?=
 =?us-ascii?Q?XbyRmaZcOQmMohDeySO8/iqocGdcG1SrCjkrVAmV0rbqS8pz36c5cctZYsgE?=
 =?us-ascii?Q?X2n6S1BWNLSvh8OZYTIllfhjkWlxFzUJwFYHrmjQ5+KeRTl03QxvDxkv7SB+?=
 =?us-ascii?Q?Sws54WGjKHlOfqvNdERbebWa+AjjngF83rY0Ns8AkliXTvK/wQhMfZIeAC5+?=
 =?us-ascii?Q?2w3PsV5K4/hNXY7D/mPRQ+3ywrHHuoU3igFHomYAMc36Re7G1OqY4rozA9jI?=
 =?us-ascii?Q?QtYnCL0pBO4VT2BbrDdUyDLKNmgPoxu56P2jv3gCSGYTycHvhOs4fQEqleX+?=
 =?us-ascii?Q?jAarNeL82jxKarBcdhbO/4fn/92RnpwGOVo/30QFWIs7m6YgMLDoAdA4R6om?=
 =?us-ascii?Q?irAXMpxsUe36hvQg/6R2f8XozhkxPYU+mEEACV7J+eutbn9UWjbZFv1A9/CC?=
 =?us-ascii?Q?NN/M7EuVFS7PTsCE5pS7Ourk2gX9EmYdOECusUbjBpVAArWQ/R1N+ZMVUDgt?=
 =?us-ascii?Q?dGZUQlYqi5xjBfpgY2PcrtqhlrDj/HIEEDZEYhTm1wpRB8F9UrruSKWZfnOX?=
 =?us-ascii?Q?pQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1d36e6-9c9f-4bd2-513f-08dba4ab57b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 14:06:42.0430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4Ra40cQ30HZ/5c7E7tjohUqJK+3UpHKAFOPPQK4XFAvHHz6MfWkUFvtpXA81wA1yQaYf7YQsEiBZtxbDS1X1htYTe4OQ3iurVFmrLEOUlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1533
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, August 24, 2023 1:07=
 AM
>=20
> The new variable hyperv_paravisor_present is set only when the VM
> is a SNP/TDX VM with the paravisor running: see ms_hyperv_init_platform()=
.
>=20
> We introduce hyperv_paravisor_present because we can not use
> ms_hyperv.paravisor_present in arch/x86/include/asm/mshyperv.h:
>=20
> struct ms_hyperv_info is defined in include/asm-generic/mshyperv.h, which
> is included at the end of arch/x86/include/asm/mshyperv.h, but at the
> beginning of arch/x86/include/asm/mshyperv.h, we would already need to us=
e
> struct ms_hyperv_info in hv_do_hypercall().
>=20
> We use hyperv_paravisor_present only in include/asm-generic/mshyperv.h,
> and use ms_hyperv.paravisor_present elsewhere. In the future, we'll
> introduce a hypercall function structure for different VM types, and
> at boot time, the right function pointers would be written into the
> structure so that runtime testing of TDX vs. SNP vs. normal will be
> avoided and hyperv_paravisor_present will no longer be needed.
>=20
> Call hv_vtom_init() when it's a VBS VM or when ms_hyperv.paravisor_presen=
t
> is true, i.e. the VM is a SNP VM or TDX VM with the paravisor.
>=20
> Enhance hv_vtom_init() for a TDX VM with the paravisor.
>=20
> In hv_common_cpu_init(), don't decrypt the hyperv_pcpu_input_arg
> for a TDX VM with the paravisor, just like we don't decrypt the page
> for a SNP VM with the paravisor.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2: None
>=20
> Changes in v3:
>   Improved the changelog
>   Use ms_hyperv.paravisor_present in general and only use
>     hyperv_paravisor_present in arch/x86/include/asm/mshyperv.h
>   Fixed the build when CONFIG_AMD_MEM_ENCRYPT and/or
>      CONFIG_INTEL_TDX_GUEST are not set.
>   Updated arch/x86/include/asm/mshyperv.h accordingly
>   hv_vtom_init(): Fixed/added the comments
>   Handled the TDX special case directly in vmbus_set_event().
>=20
>  arch/x86/hyperv/hv_init.c       |  4 ++--
>  arch/x86/hyperv/ivm.c           | 38 ++++++++++++++++++++++++++++++---
>  arch/x86/include/asm/mshyperv.h | 15 ++++++++-----
>  arch/x86/kernel/cpu/mshyperv.c  |  9 ++++++--
>  drivers/hv/connection.c         | 15 +++++++++----
>  drivers/hv/hv.c                 | 10 ++++-----
>  drivers/hv/hv_common.c          |  3 ++-
>  7 files changed, 72 insertions(+), 22 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
