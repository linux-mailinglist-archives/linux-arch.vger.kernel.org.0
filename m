Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9916C1F8C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 19:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjCTSYa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 14:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjCTSYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 14:24:02 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azlp170110002.outbound.protection.outlook.com [IPv6:2a01:111:f403:c110::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A828C33CF1;
        Mon, 20 Mar 2023 11:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmliDI0AnrlTpc4liKJIZ2e8dRQLlqXDGx8qdSUnIKxyvIqThjwKpB+VrsPakBRwYGqqqaBqQxikZd+W2HJn8f0FAeBkjNFggQtwjqWz4kxeBUMnO2R9WDo5HsHSrny51yIGmuRjwIaYH07SUu5jEoAH+yn8N2Tsq/oVi3tpSzRvxRVtZzPBgwK/1dbxzx9J4PsEPeOawUQNH6EyaqM8v8QroDHPPf7KRsccChoDHTnCXZhs9s3reNP5vstI461OBrEqDKKGwfzKDo2ToHdqQg8PKQ/7s6ftKOZOGh9dXD7aEjvNENIeoT/v2i5k2weUkX1KQTmEq0QC2DjtJlR4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IcQT8j4U9WHexz0Fqe+v5CiFK91Z9R+/Iz72aCqr0I=;
 b=oF8YdF05p8hmEvnli8G1OKV7ADpP6gY5sIrI+tVAB8LVsYEEWDlt0n5R6eLeniq3sEdXccBsQERbLy/vvO5/YivocD95uZ3lmaEERb+gCT0kx0jwtSETV0Da4k3Vv9Nt48KHcHtyPyELpLnjBx51gu7HkeyiRB7nJ0y4D0tLGHVscvvgVBhRy7yPUyLCuAxIADJTjcdmbE3LjSbBMU2+3o3f+cdAPfIAOsQINdwrtqzUqSD3DYvPHX+J7rq+d93nQ29wHJ9S5AAOoLeEV91RbOg4J5PRl6oqAZ97JhqadqP8xM7WpPZEIO2pAyqesrcgApUaolXGRMcTsVXOUdZFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IcQT8j4U9WHexz0Fqe+v5CiFK91Z9R+/Iz72aCqr0I=;
 b=YZlUb8K6cx9khwHLxBznnyn2bqkJODrBJuBPG3ZfHTIhTjfFrXclqwwwbzGTYhQNrppLpkj0PPkeKavNEmlvR7PCi1h27Pe5/DpqWBvwc0xhpLwvZ02cUuLLvJmGepHZoi6XmrDlK8kIOQJOELwIrubpzvhwBVnAPYPEDTTanws=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1486.namprd21.prod.outlook.com (2603:10b6:208:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.2; Mon, 20 Mar
 2023 18:16:37 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.002; Mon, 20 Mar 2023
 18:16:37 +0000
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
Subject: RE: [PATCH v3 4/5] x86/hyperv: VTL support for Hyper-V
Thread-Topic: [PATCH v3 4/5] x86/hyperv: VTL support for Hyper-V
Thread-Index: AQHZWxNEDmrxXEJK60WJ//1R5me3Jq8D+O6g
Date:   Mon, 20 Mar 2023 18:16:37 +0000
Message-ID: <BYAPR21MB1688093876677DEE259C9914D7809@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-5-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1679306618-31484-5-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b283aaa1-9e54-44ef-bbf1-c42f8f8b57c9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-20T18:12:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1486:EE_
x-ms-office365-filtering-correlation-id: 482a8b89-76dc-4394-d3c3-08db296f3eb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mTPjDJLptSOrQLb3NGfWa592e0osDu0bVs+cJNdsR7v/bbNjkNqmCqT5aa0qC6DmrMQFfTRf+CKsKHbDcfGRw5Qp6NXWtu6+jFLwUT6CzJrkMdsHeql33xkUVimIaZnSaSKlTG1bUWQ0iBBldYjXZjEtHoA7VfZj+4YSjLJUxM+vNlIjJEwx8qVjSBUFWs2feeceDWxmgX/TCca2vYIYD5HzrmpDkKUrd+hCDIsPSzqfNb6XuuPTefTw1G70c2sgbeUTzL7cA7aKZ4veOKNqI3iNixumnARE1y82YJeAh6cXt+Eoh7oxMPdkMR59ZzBdbFUYXt7o1hoAj7J0gnJn09rPB1yE93+mUb9MjZL6qqDJlhdqjNdW/JlGT8lGoACBFX3fiEKZ4fqZEvusM4M/JvVCpXbf/S8DpawoXVzSIY9LSepHPsXQUAmrPv99pB/fYKgV8D99VpE1zC7dvnTav9G+/bcpl0Zbez5Jj+tNCybmBBjUBP4gMyqzALqCitCbk4HWQa88zcq4Bapaj2bdgfutZdnQ+Dryfqa2TwVor7//do2V5Md9VYvYymY+aFc6DJc7n3BDg7NJ1usB2Bi3A3lSFapZNpx6TJQOEEF7MtjGd2M4SPBT4tRbUQ2RdIFO8QcjxjmYeuR194SFBVisyxMGHi58HBTbBv4TCSnBPVkcSzwt8wuIcjNA4/+2hz9PFnrPddeDD3X9fg2tmrCdVjpBX7drKNoUWGJXiSPqBKP5+eQZt8rg33vf2IEwyl52n3Hfc4hYOXrLjTqPKxFhtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199018)(7416002)(5660300002)(8936002)(41300700001)(83380400001)(52536014)(55016003)(38100700002)(122000001)(8990500004)(82960400001)(82950400001)(33656002)(38070700005)(86362001)(921005)(2906002)(7696005)(71200400001)(110136005)(10290500003)(316002)(478600001)(9686003)(26005)(6506007)(186003)(66476007)(66946007)(66446008)(66556008)(76116006)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PITqHXRB7BjOqWRvMfbNlctpTnunGl4RzRuJCcnJV2jQ3+gv9vXcvSBMVNwu?=
 =?us-ascii?Q?yqe9XVp0eESENzPWSAvlJeseBr34vhOrK7qR2BuxWUESTr1Gc0VGjNI4VE36?=
 =?us-ascii?Q?7nVoUT+KgHecQAOhEhGmUU8Z/wRkzg1BmLkwzlCnM78yTwVhppobqsDz8HbU?=
 =?us-ascii?Q?zS/ioW8lbwrLo935HC09MV2G+0qnv9yXffnwP77Anrn42IKM0ADAYz6EFCF+?=
 =?us-ascii?Q?/TmXEVlpjYN/dkrN6MlHIxTI9zbIiUTE7MiCGqt2SvE6voZaiA3xaDGazW+1?=
 =?us-ascii?Q?xlQwli/T8T+L/y3HfQFZ8tPiGFW/HwNHO7m1IzNVc6eLKdPPOYcTQM1ETRDj?=
 =?us-ascii?Q?40ZSe9ZmyW+1C1XUXfAbIN1LKsCwssIXjpm0wG7lJ/uXoojMRFcxFsNZsPmb?=
 =?us-ascii?Q?5Pk+IbsnpzGHjNzr6PS+sFqp3Ftm73YyW1EvrRavw0F/QOp7f5g8k+xRJSys?=
 =?us-ascii?Q?uIQnO96004WIklCRBiGvLLjQxmOlNMIldEQ0zPAvdV1QPtrP6U4johr5XapJ?=
 =?us-ascii?Q?dWm14G4D/Gj0dRt8B+WFNVpTgP6nKjs3B3Mtel3bGQ+K7IaxjWDI+F9Q+gDx?=
 =?us-ascii?Q?0yT2o924TUTuzGZiLhcYlqE+jb6cLi6gScAs5OoHPeaTqQ2mDb6QiMXi6DO2?=
 =?us-ascii?Q?7tiB+K6zWZUbzxeiCvMJGw59BYq7LSD60vW9LYAbAfpP88umtcCbO4WWB/PD?=
 =?us-ascii?Q?PwhHz36irUVNrzsaYTOt8ZmJz/HirlpVkxpwGDWtyq8A1XGP0JbWRWoAB+zc?=
 =?us-ascii?Q?U68w2NNYe607QjsL0U/qf463v8beSswubXthdU+FA87Uzd1i0M1GcxVqc2dN?=
 =?us-ascii?Q?0DLrxR1JWR7ioieGsnXsvaE0dwuYALm9UHI3KrzDh/Ehcc69phD2dcM5yVmC?=
 =?us-ascii?Q?WKm3yaCxNmHQFqFPdtesJhMAk6pxXq45dteGsewog6zyA3CtDDAdeD7l2jij?=
 =?us-ascii?Q?q1wlJlY2alem9xLw/BSaHSx7rZdraDW0PDNXXTCvXx8rpmbnD/gbCoqUDw+e?=
 =?us-ascii?Q?5Fg3jFlbjA9mLPXW2EArtdL4q9S98ASF9AGK25LwirZVwmEztGmxmW2TNeIO?=
 =?us-ascii?Q?xKjsqRqm/fesk5lz6khY+vbaKe9fFoRJq0AQoY66WomLIhCRyXkXTnYQTh4L?=
 =?us-ascii?Q?vby89c4dOIfxdZHC/Eg6UrTgXdqtDHhDEJRVkXZmsR9zZZmfwU1lWcOpzxjV?=
 =?us-ascii?Q?URWNB+ajMxDHTnudQLyKC4ZpV1QjQGWMuNNmRkMbDu6P3uyUbNDVjcuDOoBN?=
 =?us-ascii?Q?DrN0bIl+fcsnIY+ST/GyKtls2flGwl0cawjhr6CZbHCUE2FAy2aNj9jZXeC4?=
 =?us-ascii?Q?xNsm+6A2LOf+D6+LQlbQMVVI/Ijc8+1HDxK5zjiYUOSAwyKFhWmiNydOOIBU?=
 =?us-ascii?Q?zQyTxy3kr3yaHbYeH4+CdDQ31LntRCgFZby4UeYCGoIiQiIaJkS2grA0ZPt8?=
 =?us-ascii?Q?mgfbVx6uqGmKHRDgXvMmThVuhXkKgU5OxWrk25ecWIY+ycTxpTDktKA9JRXt?=
 =?us-ascii?Q?Ik7CPasEiI5nvPhZ1bQwfbq20RJpjpIkI5ONNveHrmcirU8fAJsTyLVWXZjC?=
 =?us-ascii?Q?OzzlFK0X5FG+X/KAxh7rBNFTq5aN+sUjtpaTq9nc+rbuxkanPd+B8C+AdJBZ?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482a8b89-76dc-4394-d3c3-08db296f3eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 18:16:37.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBw+3L7mphDe9SXSSLYmkCtNFrWyiQlPasMV5Q9225vGxurxksexXjcPIqnPTm+uQEAxNIr91Wxx8NQs7Zu9BQ7EoYzSDVXdGyIDWudKeus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1486
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, March 20, =
2023 3:04 AM
>=20
=20
[snip]

> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 35b16b177035..4af218e70395 100644
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
> @@ -272,6 +276,12 @@ static inline int hv_set_mem_host_visibility(unsigne=
d long
> addr, int numpages,
>  #endif /* CONFIG_HYPERV */
>=20
>=20
> +#ifdef CONFIG_HYPERV_VTL_MODE

Hmmm.  CONFIG_HYPERV_VTL_MODE isn't defined until Patch 5 of this series.
I guess this works because of #ifdef behavior with non-existent values, but
it is a little bit weird to be referencing a CONFIG_ option that hasn't bee=
n
defined yet.

> +void __init hv_vtl_init_platform(void);
> +#else
> +static inline void __init hv_vtl_init_platform(void) {}
> +#endif
> +
>  #include <asm-generic/mshyperv.h>
>=20
>  #endif
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 61363ce0b335..0dd385cdc332 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -520,6 +520,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  	/* Register Hyper-V specific clocksource */
>  	hv_init_clocksource();
> +	hv_vtl_init_platform();
>  #endif
>  	/*
>  	 * TSC should be marked as unstable only after Hyper-V
> --
> 2.34.1

