Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0655E837D
	for <lists+linux-arch@lfdr.de>; Fri, 23 Sep 2022 22:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiIWU15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Sep 2022 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbiIWU1h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Sep 2022 16:27:37 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D94121E79;
        Fri, 23 Sep 2022 13:22:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmw+AK9cg8wsLS44PEVbgdSnGSTg8J9gZsUIiGFNPNM8QEiRqbz6Bhkq1wGHlPPlrvs8ln5D6iijtr0oeo53zyn8pIXQEOYT7f6W1P/bvdKy9eM29ayCQnYyEr5vChslcOJGChVog3YacMXk5hisJXXnsfTVTlz9MaanWFNBdnRgSwNTd6LwTRQmdeBWSSyJ3P5zDlpahUUVd9Ugh3KOjRyeTTa3Nwx2a+5CDlITkQgPBh7k9RpnbSh43QKbM6FmFz1Cj2xLYboLNrKdux89YuVnm13Jvf/86ytd+WnmiOCP0pkTarOWUS5Hwi3Qv4sqf5vFF2BMJ/+qDgf2KcSXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYwlSMqDAlQBzU2Jd4e2dIhJxmX0xCf5/KaThDhXBsQ=;
 b=oV4b/gXMiIRW4t0A4V9XCJb+l5T+EdLFU6g6OHwkfT4hB2+21AHU/8PORycJMyK3D07ZgA1Q8BtK74OSsUJJMMirA1sPojUiW9SVBpT97ZgEYtneNsHqYdD3WghYwdW9A4gnq/Ypvw5WMx/UgvewaJ1Ac/ie3A10PvQmlEQRVGyEYUDKUsBz3s6W4cBqheFpcQZzl0FPub4JRjgnShv0y9QFl/IPypmxokr8vmjdbcvsGkkQ2YjvZGh9F1Uorrj8PUpB1SGu9VvKLqZkdDpx++3GlsrCyNMIHQnUkMUoXuHB+U+TCdgh+XRp/A4r5TlVM5oxY2mmt3jVeR/2VRO9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYwlSMqDAlQBzU2Jd4e2dIhJxmX0xCf5/KaThDhXBsQ=;
 b=QD+bB/endTUEftc7Vi6zIu2PX257eLgiuU3sW23dlK+mN0fzwzEtu4gbcPhDYvCgpPkRK+snS2oCiWlNfMB8QAG48G5DRcXb8mlVyEiacs1qHS4cZDjrATANKMjlZNe6ppgEIKgDrAg02fCeBlA5p1z4FkobK/Cl4AEwU3neocU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3580.namprd21.prod.outlook.com (2603:10b6:208:3d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.11; Fri, 23 Sep
 2022 20:18:55 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5676.009; Fri, 23 Sep 2022
 20:18:55 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Li kunyu <kunyu@nfschina.com>, KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v3] hyperv: simplify and rename generate_guest_id
Thread-Topic: [PATCH v3] hyperv: simplify and rename generate_guest_id
Thread-Index: AQHYz0GurzqyloJRkEuW72OO+2hVKq3tc6Cw
Date:   Fri, 23 Sep 2022 20:18:55 +0000
Message-ID: <BYAPR21MB1688909EE6240BB087D7C788D7519@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220923114259.2945-1-kunyu@nfschina.com>
In-Reply-To: <20220923114259.2945-1-kunyu@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ee52f0f-41bc-4be9-8352-5dd954b6f207;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-23T20:14:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3580:EE_
x-ms-office365-filtering-correlation-id: a9acc65f-82f1-4a2a-b97b-08da9da0d70e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HjfKNuVZrzxOdlk4ekK/Dlp4o9qyoFMMm3Sro92dm656Koud7uA0obxzgaLlhs3WWIQJ4YdktJSqIkQlwbGos6LbSvMJiRCfgsEikMt1H05GGmB5R09f6VdBr1Jq5aeCQHuDkq1Z7B1IxKLlfxw2ImHurp9HIoQLqjuTtOOvpqgBA50l99ZPkCq+B3r6pt1J5yNUwMU0rJ+WhZ9yyDS2I9/RFI9xzcI14m91JGv2Lvo8Npi46IxF36IFOUQrLTGNmrj0I/SsmJ5qSrx2/Paspz8tdZ943Llecev/0XhvTYvrbLIotJbiiFXWLuH/9cuPgDvNziNulf0CQcVqxG0eMeJjQ+0CYTt28cwiniALxg4Ty2iWrBvWjDJuQSiBiAuKrWAydiklSXUSscELfWhT/snnG2BuMvToUaT9RWOdhCLpMOKSqQ8jBXYKboWXsnIrJyltqy/lG7zF3RNofov2VTBPcrVyp2ALiorZLvJzpGmKCI4121yBmkpHBJxNPtXICR//5PtpBLhvMYHGtm9TrP+8IA4FL63dh+uPYaIqXZKcvbLTyRDpPltOmkDWf+jhVrFXysgzaJMz3/kC8uImUoTwevXNvz170qlzOnX0UdJLPyH2USUvHxBURduIGcivhbokOOeFEXU0Pe8mdDIrwgwODFM0wGSF6hqjHhQUMDEOtDnOylNhH6saq/gh+WbaVbEoYnxRBr1wUQuRgjEdoRY18qYs9MEk1iA704M8mmqkU2sjLifug+xUtE0rsFxl+xZ/Upfg9Dna3LT25zjiA8HUXMnbyqjqaG1/+yo8qq93TQg862+jbvenO0OCoeSFlCCvHLvHjizYB+Cuc1Nlsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(122000001)(38100700002)(52536014)(7416002)(41300700001)(5660300002)(8936002)(2906002)(186003)(478600001)(6506007)(7696005)(9686003)(26005)(71200400001)(55016003)(66556008)(66946007)(76116006)(8676002)(64756008)(66476007)(66446008)(4326008)(316002)(86362001)(10290500003)(110136005)(54906003)(83380400001)(38070700005)(921005)(33656002)(8990500004)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dcZUcPeb0I4hb7z5NAFXbsxrBGBDxNlpl6oT4JXycHCOoBbES99KK5kqjLe/?=
 =?us-ascii?Q?69j9twxJIutSsO9AKAeDovatyWI2afz3aAWgNTCAAwFvTlUBNba+zFMAkSNd?=
 =?us-ascii?Q?E5PtVwGJTSTyncB9xnH8FscgTNhf1JT9+z/S+7rly5MHHaEU87WICZ7xU4ZY?=
 =?us-ascii?Q?KIonLvPdmkHVXECd7l7kRfR8DFPakC8lEreISId0wBXj/GNRJHHcCusMu7rh?=
 =?us-ascii?Q?vzfPSrA5PKCceARer1qGxBIR0Yu4Me+uuXpq5rEbn8iQrbLHFzLQGB/X8Jor?=
 =?us-ascii?Q?iM4yElay9fsy/rtzzEeWQz+dQoZr0w2ffwSodnq4qDM20WHxc9wsEbQjsnAp?=
 =?us-ascii?Q?Ith44TFYAKrSRoeVD47QF0taP+Y1oYHm6EaKGRuHQOb+28TkW4UYKZyumqRZ?=
 =?us-ascii?Q?HsMy389OrPqbw1hvMTULciJW/yOYtx+JplzwhGc8m+DHTnWizWyygBx7x12w?=
 =?us-ascii?Q?VHdmk672BMBPel5uqqRqQULZybLxTb7E3TzVIkUTni9vxPi3gyuPzUJr1QJq?=
 =?us-ascii?Q?BPjeTwobC3k/jzZocJK4kNJnVgIzStIigIIWknzJVWxAHonEulLTG1ZhXNVf?=
 =?us-ascii?Q?xrc4n4kF7xrLL8BjsXST1Ltmg6fgAuLIpzDps1elY8MYotx0XrsYApduMapP?=
 =?us-ascii?Q?YHxR0F6kguWCo6iKInJ8vOd57vp1z7twNv24KoWQglToKsj/tDQYVfmOGL0E?=
 =?us-ascii?Q?iAb56WBabAPxnmqLmhT+SuCBoVvtUQX7H1XGxmdxC1XxS0lGx8zFd4KUHnjE?=
 =?us-ascii?Q?mN8x2anQOF5Ta9wtWF4jYg+zJ+zTkHw/jHmg/s0dNF60OO/kIPeKW2Z0mOZx?=
 =?us-ascii?Q?3FZKJSky1FQaDjRMGas1xAi5OF0LU25KnuNxWMRb2Dp3ANyJBElU0YtFnqPX?=
 =?us-ascii?Q?2/+cq9PeRRlWwu/w6n/PcPGI6jYiXlzNT8cywoG4WTAmCtoN7fOxrp3s+0AL?=
 =?us-ascii?Q?561U+mDsXFbWibFPijv/CW/0F6Kuu4pEi9PIELV77wdvEktrAPypevWaE+Up?=
 =?us-ascii?Q?X+a2Hr+cNo77kERW+IxdQmxo8x+94+cuXDZAhVqqTVZV+/rZuXt7HY0DWm+G?=
 =?us-ascii?Q?tAsQ9jBgt075nK+tqpr827KGMSn3LIFWGmUUn+cnWoNWULUd01H1XZ1BUCNR?=
 =?us-ascii?Q?/k85Go6RH+WkxAIPaakZacrHaTz0Xa9EWPCZc48a/Qg8qtGQE1aiGndXYjyw?=
 =?us-ascii?Q?PO04BrWLfJnkHVDxvZ5jny8AS87r1TU//LClKiwOzJqY0IjZRpqvC5fsPHRR?=
 =?us-ascii?Q?wAMe1bvdrSEq6m+Gl32uH5B0N1kZiv35pXbv04M8olbF6ckLLnx5iy4otlZS?=
 =?us-ascii?Q?/bNCeRO2UL8/11y26BpmZyFNOjU27tR/i246QOzE1cKt83bn9SCFPghekUNc?=
 =?us-ascii?Q?KNnM1Denf+rxX7XgfAjDx0WZ6o0FTHrwAkyCAv3ZsPBp51CfxyF3Uu5vB9F2?=
 =?us-ascii?Q?UFpBBoO+P9Nbr3U/tHL3+r1n6e3/6uiNNj6OKHS8klEBMw42RuJ1t01om+i7?=
 =?us-ascii?Q?UC5RyQ5ram7qXsVpUiY2ahXnHLYnY47sCx2oBGofDH1Asdn0VpcY3CaZlTI/?=
 =?us-ascii?Q?s+cXqlkZHuBnO2VQ8LBycuiT10kCtRoMR5f2lwcd/Si85dTKl9g2963UOxok?=
 =?us-ascii?Q?Vg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9acc65f-82f1-4a2a-b97b-08da9da0d70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 20:18:55.4584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YUwxMbrt1lc6u1nh3xvimrZJzYCZlcJvEFceC3XOrmbUnq5nCiFyoAKjO250P1fs/7mVT4cFDBZQCPoI04FC9kPEoe3OAT3UM+jQKragz/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Li kunyu <kunyu@nfschina.com> Sent: Friday, September 23, 2022 4:43 A=
M
>=20
> The generate_guest_id function is more suitable for use after the
> following modifications.
> 1. Modify the type of the guest_id variable to u64, which is compatible
> with the caller.
> 2. Remove all parameters from the function, and write the parameter
> (LINUX_VERSION_CODE) passed in by the actual call into the function
> implementation.
> 3. Rename the function to make it clearly a Hyper-V related function,
> and modify it to hv_generate_guest_id.
>=20
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
>=20
> --------
>  v2: Fix generate_guest_id to hv_generate_guest_id.
>  v3: Fix [PATCH v2] asm-generic: Remove the ... to [PATCH v3] hyperv: sim=
p
>      lify ... and remove extra spaces
> ---
>  arch/arm64/hyperv/mshyperv.c   |  2 +-
>  arch/x86/hyperv/hv_init.c      |  2 +-
>  include/asm-generic/mshyperv.h | 12 +++++-------
>  3 files changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index bbbe351e9045..3863fd226e0e 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -38,7 +38,7 @@ static int __init hyperv_init(void)
>  		return 0;
>=20
>  	/* Setup the guest ID */
> -	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id =3D hv_generate_guest_id();
>  	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
>=20
>  	/* Get the features and hints from Hyper-V */
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3de6d8b53367..93770791b858 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -426,7 +426,7 @@ void __init hyperv_init(void)
>  	 * 1. Register the guest ID
>  	 * 2. Enable the hypercall and register the hypercall page
>  	 */
> -	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id =3D hv_generate_guest_id();
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index c05d2ce9b6cd..7f4a23cee56f 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,6 +25,7 @@
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
>  #include <asm/hyperv-tlfs.h>
> +#include <linux/version.h>

Having added the #include of linux/version.h here, you should remove it
from arch/arm64/hyperv/mshyperv.c and arch/x86/hyperv/hv_init.c.
It shouldn't be needed any longer in those two files.

Michael

>=20
>  struct ms_hyperv_info {
>  	u32 features;
> @@ -105,15 +106,12 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16=
 rep_count, u16 varhead_size,
>  }
>=20
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
> -static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_versi=
on,
> -				       __u64 d_info2)
> +static inline u64 hv_generate_guest_id(void)
>  {
> -	__u64 guest_id =3D 0;
> +	u64 guest_id;
>=20
> -	guest_id =3D (((__u64)HV_LINUX_VENDOR_ID) << 48);
> -	guest_id |=3D (d_info1 << 48);
> -	guest_id |=3D (kernel_version << 16);
> -	guest_id |=3D d_info2;
> +	guest_id =3D (((u64)HV_LINUX_VENDOR_ID) << 48);
> +	guest_id |=3D (((u64)LINUX_VERSION_CODE) << 16);
>=20
>  	return guest_id;
>  }
> --
> 2.18.2

