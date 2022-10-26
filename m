Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F1360E3E6
	for <lists+linux-arch@lfdr.de>; Wed, 26 Oct 2022 16:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiJZO6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Oct 2022 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiJZO6V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Oct 2022 10:58:21 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11021018.outbound.protection.outlook.com [52.101.52.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86E4103279;
        Wed, 26 Oct 2022 07:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHv0fUPUQyijfj6THaByWUx2TD224FGkaXszSO69/d4w3Cck0jlXGiY1XXjyOaBaLOKQmqo/yqsJZIolW8LvHo64h1zP7dhnukT6g9BtRYOJZYFN6ihMwE1maBWjRRofKwSPeEG+f7zfxUg3xKjQjNW4Kha3dAeV8S3KP1vCad3nLb2gBEBQynLeGGPkPwKyKXAC8iXKQjADnThMztiMFcrIjAkvWMoz9jkTxILx4J9MAYnp/qWFhcwJWNCavWRUHbRcRFTBo4rM6y4Rw6XSIUc9Ohp8S5UUpO/vjMkvYMpJ6twJdVjg3dJXGrkcDeCG0oGK7KhaBsgj8JSQvD0NWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Vefq4Od+nHnTE+8mloBKR5Ke1QR1D9tKcoQyJ3/X4=;
 b=U6mDlZk4HP7+NVQA7EWbDPKyW+SHZ+d3NHRxR+RJEWPDvgO9LnDiyubGgmvkTdoqe2ImgJoKKKghWnV55CzogZIZu9lSX8znCer8WL6WCPh/qkLacr9FWcA3Gu1k2G2LnRPSoFGEi6jXJpFEC29zWo61NBXaWRe9t66SImfZWqrXdGL6OllhNePkLIsNqVxQdPNjEwL03p2BD5gyuVWkthg4hoAzdCYMF9zIBd4xOqb1yw4EgK0AemZwfjNg2MC8CZE6iA7MNf/iDGscE5yOrC3C2r2Pt/9GgJni/e86oHuHztxX55jaA02zjAspxfakd36KRV25m39gWaYgga8bqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Vefq4Od+nHnTE+8mloBKR5Ke1QR1D9tKcoQyJ3/X4=;
 b=JjsU7i11QlEyc+eV4osryDsa12k+F5+44ptV2jM9LB+Vd7u5jWHeRxuBnlYrs1LE4DPdR3y4uvkQ+nw6I+1z7FXhe+TZNJgwF3ceTgLnhi+JZtwnz+wmO9DrztzddfUWC4mhqA6UafyYPdzEXXlZPASQUQFol84fTAR6+voQzFQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1870.namprd21.prod.outlook.com (2603:10b6:a03:291::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17; Wed, 26 Oct
 2022 14:58:16 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5791.008; Wed, 26 Oct 2022
 14:58:16 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
CC:     "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: RE: [PATCH 1/2] x86/hyperv: fix invalid writes to MSRs during root
 partition kexec
Thread-Topic: [PATCH 1/2] x86/hyperv: fix invalid writes to MSRs during root
 partition kexec
Thread-Index: AQHY6UGvlrvlNvpN9kCIgZhIqftchq4gwsZA
Date:   Wed, 26 Oct 2022 14:58:16 +0000
Message-ID: <BYAPR21MB168837A9E4B73D7B26040B52D7309@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221026134715.1438789-1-anrayabh@linux.microsoft.com>
 <20221026134715.1438789-2-anrayabh@linux.microsoft.com>
In-Reply-To: <20221026134715.1438789-2-anrayabh@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e86985a8-2f14-410c-8c7d-8bcae44c7f1a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-26T14:53:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1870:EE_
x-ms-office365-filtering-correlation-id: 0c775da2-83dc-4dda-4df6-08dab762832b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aXNH7chfemGRSJz+tlzrnw1PDD8OJ8gnzpDhIB/QfY383VkJ2shEzgsnvoyC4rDtXJpW1Vjs/FJ5NUVWYTizO3P0L+fZlGv/racaY0R2iiphxki1di5mO04/hNnLHdTSd+CE2kagjf92WLDfP/n79KIc9SiOXLRlqYyqQBHM/MlN0CqJauz3RRjvpcs/0A1Qdb4gpqqrMbJHKJ0gDzkKAA4uZzWLc/WPVMxFren5jLS4SybTvmx99nuYn+zLH4ucCLVWzwaHekqVseOFpckF8Z4m0sgDPgKq51PDKkyEpGM1zGNIiSxJk24wqrhoiKUqunHLslDYRPawPIGeel2ZOYibmJUnn2ubyJcG0pYmipgb6NBUdstE4lTSmRstbt+KajQG2feoTgtwpn5+xLdiXNu7zzQ+A0QPxei1CinezbBGgRsiXPTENkbc7pt+UCE8uFBo5vF/4NyV/ucvf7co+11eOYzBLb4l48K3ymRd4damzWE5qaTnqjw7zLsfQCkuNUSXgBkDCIwpKXxgH4yOLfsAr7MdMcuK6j2/+O9Dai5eXk0Xbf0UOHlG5SJe2X95hBRAn+EasZrkGq5YfnBBv1GiPunQB+jhMGMwwBvvccdZt38IjAExUitLgLCDOIY6EdWa0v6OvUXPSVq7z2wz4jnnfGZxIyP3Y8tfbtM883Wry0Jn2TGqvvy4ZUjn9gMaHyfPbGINNKx3Hrf8i+3Ny7xzhIxt4bXkREtQWhIfBMDH1bk2yO8Ay6C8Nyy2qX9FpIaZXlMZcukMwJH2+3PiwUECpkBi1uAwNiMD/06NmWwcp5zuxwfFEIhRTeO20I8G3tHnIB+0xlqPPJpFzI/mfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199015)(2906002)(6506007)(38070700005)(186003)(66476007)(66446008)(5660300002)(38100700002)(41300700001)(52536014)(66556008)(921005)(7416002)(122000001)(4326008)(33656002)(86362001)(8676002)(26005)(7696005)(110136005)(8936002)(64756008)(66946007)(8990500004)(82950400001)(82960400001)(55016003)(54906003)(478600001)(71200400001)(76116006)(10290500003)(316002)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ij/sBJeZhVPP8UTn/N3K7VZY5a6t3Ww9mf+8gDdmfGNtx6Z4FJofMSmZwgmK?=
 =?us-ascii?Q?3HfPIrJ3ebDI5GqshRn/3l16UG5zD3vfhK7Zh9iHpMs++mspr+XnVj9B07Hu?=
 =?us-ascii?Q?cynCPdWdfZ7alShs/XSAxEYHYNnP9DBkZ1+l9o7x646MEslwiyT4Huq4Efd7?=
 =?us-ascii?Q?sSt6Y1WsmPwOpujw/CFHCL7Zl17nA8laY4L9TJY95krBFuubGtO+9ariZT4C?=
 =?us-ascii?Q?BRELxKgZdSc1hH4MBgNhFfaDQc9XQLZ/L1Jt/nu7drNJJJlRFDZpoBtoZvTv?=
 =?us-ascii?Q?Kw8f6Y8ad5m+wUW7ZvdQrhRhdZTVALrKm9M3vv1feLWmxnMt+4FTVRihA9Xr?=
 =?us-ascii?Q?1kgVK0dBeRQdBv25fg+rvG7E2NN+m1zC3+0fo1yVNqKxfqiZlatAdjgaaRsS?=
 =?us-ascii?Q?6sUNHt0973VMDP6pQLWPGPRl5LCo0WSo5HbU+ZzPGzSaC4hdDGl48K1kPWo5?=
 =?us-ascii?Q?dJC583yBCwt7WqbM4M9ddUtks47GOSEt2Qz2633N+GrsuZQuXMgLdMefIvbI?=
 =?us-ascii?Q?bMvzL4SnvpfEpQy3dwISoQO2BhufTMdjx+iS//DthNzR6w/7GZ8XYck4Udm1?=
 =?us-ascii?Q?j23KfiZQIEGmxEQPN/Poug+Mpm4DmhJILC9WgAVG3vRsvezsc+OnyS3pjAHR?=
 =?us-ascii?Q?CGZGCwuePqBzPkBWZWnkuXAQtwn5EttibIljn03EyTNpSzp2ZcWTyPmmtH8E?=
 =?us-ascii?Q?nEICsPxIXTvb39rvf9Jw4YlxIIJr2A7bSeqcvIZqAs4cAO5fIyUL8hlwqCoX?=
 =?us-ascii?Q?JtON94npVHfL3DIKtBhF0V36M0vcwExTDL/QiCWp/qxC4BKi0U3cxKGqyyvd?=
 =?us-ascii?Q?pU8ymJOkiRTL5sRF+pIRzXe7M9epXdP0t0VSqHdo9LhbkA//gUP8yoH/5TKk?=
 =?us-ascii?Q?no1sBHXDEnW0R6VZ1VWX5K9Gs2eYsqrid2yHNY9J+2wdWDc/eNpIHf4ENhQH?=
 =?us-ascii?Q?vKZ5uHWr8AVmF0R2RvEStDfpOIhmjD6Tv7SDxpM656FmHtmnhoumIrV2ESxN?=
 =?us-ascii?Q?mQ8OG/zV2QZkGDmeegOsxCOaZQZoQ86hl8OwxV6Qi1oeDFNN0mKxIiHXaCzx?=
 =?us-ascii?Q?cPllQXprf4O3CFbeSrFxgNkULMNFrFHzM3AGvGHO6qt13cQtxu8cYLNimGnR?=
 =?us-ascii?Q?pfXPSirGasBvsvlPwskf70c65tIH6impHW75+DCKvOZ0d3ow17NIz85umg6w?=
 =?us-ascii?Q?D7SUubu3DTPocc+SQ3jGhqxVR2dCpMp460BCu3A58ac0R5zX0nEW4rbKUngB?=
 =?us-ascii?Q?+dhCZ0x4Cm9Ars56nxDEfDJ1y0aLaw9TXP3sgh7tNYxX9A6kl3B+sFQ0NozN?=
 =?us-ascii?Q?w3dgrawwCrmTLcwMtcu1xx74zEAXRiphyhF8Z+rzVV2fcq5oIkuQOms0ryLD?=
 =?us-ascii?Q?F4SxlzVDbC87gPiEkvfipH84ZwT2hyMuCOsWAOO02zlTiIziIcGLjoWkeBRv?=
 =?us-ascii?Q?7TUHIQ+3csvq+jxM6C7VTUy8EuPrfSzTp+EHbOwgF9qEVECcfg9sY4G9er6s?=
 =?us-ascii?Q?YWF6P6CFdp4ZUsusD/Sa2+pi3mlFsjG17AAP/k/8Zzb1WCuXLPstIy//6vYf?=
 =?us-ascii?Q?i081kUeKDvVbEz6lLw9C7DaK6FC2B7wk9aReVLHgPnnWeTTiw56Ow2GOQN/H?=
 =?us-ascii?Q?Aw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c775da2-83dc-4dda-4df6-08dab762832b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 14:58:16.1521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8wnI20dLIqU1R+8hgA+GjpYjqZOlL986En5PtD6wBiH4HLj+lnCGP9gjcRZ19KXUIZ9NtOXoGGF6rvT2G2ezuGHqkY9dM/RXh8EjrNY2Swc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1870
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Wednesday, Oc=
tober 26, 2022 6:47 AM
>=20
> hv_cleanup resets the hypercall page by setting the MSR to 0. However,
> the root partition is not allowed to write to the GPA bits of the MSR.
> Instead, it uses the hypercall page provided by the MSR. Similar is the
> case with the reference TSC MSR.
>=20
> Clear only the enable bit instead of zeroing the entire MSR to make
> the code valid for root partition too.

When the enable bit is cleared (but not the PFN) in the MSR, do we know
for sure that Hyper-V removes the overlay page for the PFN?  Making sure
that the overlay page is removed is the main reason for clearing the entire
MSR.   If we're going to leave the PFN in place and just clear the enable b=
it,
we need to confirm with the Hyper-V guys that the overlay page will be
removed.

Michael

>=20
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 29774126e931..76ff63d69461 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -537,6 +537,7 @@ void __init hyperv_init(void)
>  void hyperv_cleanup(void)
>  {
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> +	u64 tsc_msr;
>=20
>  	unregister_syscore_ops(&hv_syscore_ops);
>=20
> @@ -552,12 +553,14 @@ void hyperv_cleanup(void)
>  	hv_hypercall_pg =3D NULL;
>=20
>  	/* Reset the hypercall page */
> -	hypercall_msr.as_uint64 =3D 0;
> +	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hypercall_msr.enable =3D 0;
>  	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>=20
>  	/* Reset the TSC page */
> -	hypercall_msr.as_uint64 =3D 0;
> -	wrmsrl(HV_X64_MSR_REFERENCE_TSC, hypercall_msr.as_uint64);
> +	rdmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
> +	tsc_msr &=3D ~BIT_ULL(0);
> +	wrmsrl(HV_X64_MSR_REFERENCE_TSC, tsc_msr);
>  }
>=20
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
> --
> 2.34.1

