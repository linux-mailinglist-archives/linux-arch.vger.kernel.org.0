Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE446C95E5
	for <lists+linux-arch@lfdr.de>; Sun, 26 Mar 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCZPD2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Mar 2023 11:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCZPD1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Mar 2023 11:03:27 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C043AAA;
        Sun, 26 Mar 2023 08:03:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5iPMstrb79wIkZTH1SdsUl2ht11SESNiUAf7Q2WXQVWLWemm0WeK+5+0zylCQMm19raNLaX3oW9UW0sd7e5zJbMG247vtl7nr00o0KMZwXEJuLG9KBNvwgXPWtB/Tq4xnwGrOfi0AcmcvVrrciiYzlqyxnxEqXSZMFTvr7c+fKuNYSsGQRUFzv3lqyJ7pxXSVVNCaEyLK5SRcymBB6zDshRPeT3MEx9cjdfYweDhVT9KpZ91qmSnijkQAR+RZQlmVF6w14HbpKAyuWOVZwXNa7JFWjK6ghhdYQkO7ZGE3APukEcuxmQ31bGrQEszicaO2WZhkRJVSBF81rAiNckrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7CyEEyfnYCOFZsj4wvPwjaQ9OtOH3pEVIAv+VDDaNg=;
 b=mD+PKdeyfXW17rlj87Srn6lBVRmy9fOw+jSL70yeLqxhJ/TCK4nlqGlYP8pTGCit3D24CmyXITN4iX2g27eAYWa9nZ1s6yGVuN6BG10AOBepbPFqdlTIR5sul8usmVHdY6QDeqTrT9pF1tZ/HVUcijiMJbUO1PwICOnyOcwjivTLPcPT5Yg33cJI9GYg9eibNZioceOihoOFhR8Xejaq3VtXk15g3IveNH0HkLEQWnLSkb1Bu2/hv+GwH0y6v99XWDICV95FRZPlqjP7Q/lVElD0M8A5EsdmIi5xlM3mthJwgZT4itViFrlF+7ySYUJWCoZxFJglAKrHVPn5Yr0o+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7CyEEyfnYCOFZsj4wvPwjaQ9OtOH3pEVIAv+VDDaNg=;
 b=dLwM421AejVjVzz+byFzULG3WOhQRX2ARvUTNedUho2a6WnzkL0la24J46yIj6NEk3GaGKMwRMQtoa8oEzkKWEvok+QcjoaD/rjmb5N1kgNAv7VQPuoSXOWCCaQrSDoI/cAdS/99kZPtE1inTAhEkN+jaP+fnasQkDH+OfMi00k=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MW4PR21MB1908.namprd21.prod.outlook.com (2603:10b6:303:7b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16; Sun, 26 Mar
 2023 15:03:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.014; Sun, 26 Mar 2023
 15:03:18 +0000
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
Subject: RE: [PATCH v3 1/5] x86/init: Make get/set_rtc_noop() public
Thread-Topic: [PATCH v3 1/5] x86/init: Make get/set_rtc_noop() public
Thread-Index: AQHZWxNDNKy/ZC/mu069j5k8UJzEUK8NMdHA
Date:   Sun, 26 Mar 2023 15:03:17 +0000
Message-ID: <BYAPR21MB16885E11E5112939F59FD0BFD78A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
 <1679306618-31484-2-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1679306618-31484-2-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=daf9b3e7-37d9-45fd-ab07-4fd6a3e79bed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-26T15:02:29Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MW4PR21MB1908:EE_
x-ms-office365-filtering-correlation-id: 864cb73e-bba5-4c6e-f014-08db2e0b3b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbR3Ngz6kHz39/X2FMfBm0PRXyAZaUiRjXBoEhe3LOrRZl7DpI49mq1xE6t4tS6f0BMe3kQV5xJHGFr1zycCA2Ie4JeRfePooHzdkarDj6cCnEj2fDFwDY1Imu+b1bCYAOJTc/pNx4PcdWxI7zZB+F+vHrI+HWPM6dBYH3qjnel1H6dDXrplgCh6C5o9DtVDNFXcbN6e7LpG5+sumA3BxUqBSDtsQkgVzb7zEd7wLfRb1U7tqFZXtmO6Le1jT6IE9JeshpyEYHJypasH0fVpkD0PiGiZtsZ6IrO73wV4rH70KAPjFiCC7yWCGkKOzpX8BveSSj8P8Mo0a0JYiwz79bYQXsjddBDzjBUx0ppo17UlKfBbsludFt7l315s0r3XT5CsewbwpARhJucnllpUlIvmhO8XKwfJeOHXQvu3X975wKTJIy5DbTIy9us5f2uQN5bawgnChc3Jy3IDmOZUCDsyDEMt+umdhcaeyT8TnbE7Bpnn2b09hB/rc/WGt4dWaLbzV9J6Nv8jOPfHVzN0iRZi57mJbgHaYhjOa4H3YupSCCelTSlYe1a92G24EZM+SUH1AfvaaLTIpp/Am4JNcpL5ZYSyFL4An0BAdcIrmG9C4pmz7MBBJSHGKWKpoenN4ZYyUFPjyOJo/G4+x8FXGOudjclYEat6FIe0/dLieb0WFqtcB1Xbh2timK4IwAiW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(122000001)(38100700002)(82950400001)(82960400001)(55016003)(33656002)(86362001)(38070700005)(921005)(2906002)(10290500003)(186003)(26005)(478600001)(6506007)(9686003)(5660300002)(7416002)(8936002)(71200400001)(7696005)(52536014)(41300700001)(110136005)(316002)(66556008)(64756008)(66446008)(66476007)(66946007)(8990500004)(8676002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vzrPsoMfDUPaFkcj7t1+zPdlwVBNZXFOJEajJlPUAKlCNoQeg49aJoM2wHaR?=
 =?us-ascii?Q?2DV8uIS979rZLLn3snMiXRT8Ny/Oe5N2K5iVP4TSObc+uylFgYIvbWO9rFso?=
 =?us-ascii?Q?GPRLZ+XLtUELK53K8oOgPEscd1GL64X7LPPEteviU79+APNod+6tgPnagQcw?=
 =?us-ascii?Q?HNKMDvBRY0opJi3C3US5a9uRHPS05mBaDPD2wSFTSdXua1xXgNJvaShXbPKE?=
 =?us-ascii?Q?kyIyyYa6+CLigzoaM1WM4wFWGxlj29jky0weDvJ7fPUiAjcKg9SnSZjxBoCj?=
 =?us-ascii?Q?Uflnz/i3qMF1h3ZKuXaNdz/g0EeDRBUstthrVWlpMcCcS4AHfz2gnrXN4h6k?=
 =?us-ascii?Q?AdA1xVFJzGpmXi3AD/vgvUUd8QHhfOyd79gyQ4+ZBIscGXWDzbq/cc7jnhCF?=
 =?us-ascii?Q?H5xBgbgpy+DcNinkLhnHCKePGSH0h8OOak+iIWTYSV5AwHoJO+bLLae1ishN?=
 =?us-ascii?Q?4jsDc2bcEeKdeUO5tpG/yGvGRMQ596KY+0ivLylgz90Duio8B07iNur2UBVF?=
 =?us-ascii?Q?mxIRblgem7S7vGzKAyfLUUHhZW3MKNLvNMOQ7shzts7XwhyH9iuR48kV6VhC?=
 =?us-ascii?Q?CHy3D2EqZzROsbnUVdJEh2fMNMnLG2Mxmn8LH/XXwn6stcQ2nwXFu2C4p2CE?=
 =?us-ascii?Q?qxuf1DplXVghvJmcB7oAQYKOUaIuSTA2Xc66MR4fwkb9wCCFiPsyH8yHnG63?=
 =?us-ascii?Q?rntlEsxRAFs+ehL8a5nrr7zRHiydVSS2guQJDfl23ZB25BlTQGBdxeembEoZ?=
 =?us-ascii?Q?bI+7Hxc8RUDxYjKcgDRIW2sn2Dj6FEGO1Am3qBfucDs+sO/aajHa8wS98Gd2?=
 =?us-ascii?Q?xaL02bxNUndD6iU1e4jL/Pbyt7FQTAnyqz5l+/yTa2tEtk0oK+evZRFhcxuP?=
 =?us-ascii?Q?v16OxpFVtrmFvoh4QfLattTyoo4q7SjFk1ZFfsC2K0dfS9oimK/rowf6z65s?=
 =?us-ascii?Q?Pp6haq6e4ZreR1ndnVupi2+0EVtXhOU/pC4c0/z2UAAEaefVwEydHimWRM9I?=
 =?us-ascii?Q?z8tUBZ//AGnup1eAm48j2TqHTCDFcgp65ZEhn2C0KBXN+0SO++FYCYgDb4wZ?=
 =?us-ascii?Q?QJERbCuMyDyiSr1X2ZYZE23j/8FqIQzuxw+6pm9PTXMWVRfWr6ct3EPCllgr?=
 =?us-ascii?Q?otvcjLrwMX7mIGqXYWf/sBV515SPFTFhsjpQalUD64sh9lSBSN2287L0hUNP?=
 =?us-ascii?Q?gwmbIhSF/BXBA7dwK7CdE2Vu9zdDlIwl8bx/F44ajB9DxBYOpGDqp14jhahn?=
 =?us-ascii?Q?M4d6DtWdATKhQDCB13sw+pswQkTkzZyy230nzEwYTOgin4ATRHjYvZB7cBj3?=
 =?us-ascii?Q?jCPMcSEWVw9o8e51hogeJhAja7OP/CIOWmlpELB4dGNc8gdQiSPwcr9iqiCE?=
 =?us-ascii?Q?bVZw6hHXe5SZ5V46ppzzIOJG48mLU1ZNdwP2s3Gd5B2NecGXD/vDs/Qcy5/d?=
 =?us-ascii?Q?8hS09DhOm8V5MHjAR7xGrsvMHfzgvFQVg5fF0ZzPGupwLBlwlmapsjd1f4My?=
 =?us-ascii?Q?kCaTYcEivrZfxjvI6pYs6hMMgN5BPW7w9duSfEkqhoyvbWA/2EN2/VpV2C7q?=
 =?us-ascii?Q?U05McqgEI74iazFrflqD6TvuKBHdPbzhHDUUt+SNz7RarMllxrSq9a6HmSdg?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864cb73e-bba5-4c6e-f014-08db2e0b3b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 15:03:17.5062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXGxuBnm4jjmuL7iykP8EL0J9GeXY0bbIJlkj09epkKr68M024eI/rTtbjUJdHqxBbTX+oUTne+7oFI80uvEdESZg7AyvEhFsezRdjXaDTU=
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
> Make get/set_rtc_noop() to be public so that they can be used
> in other modules as well.
>=20
> Co-developed-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/include/asm/x86_init.h | 2 ++
>  arch/x86/kernel/x86_init.c      | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_i=
nit.h
> index c1c8c581759d..d8fb3a1639e9 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -326,5 +326,7 @@ extern void x86_init_uint_noop(unsigned int unused);
>  extern bool bool_x86_init_noop(void);
>  extern void x86_op_int_noop(int cpu);
>  extern bool x86_pnpbios_disabled(void);
> +extern int set_rtc_noop(const struct timespec64 *now);
> +extern void get_rtc_noop(struct timespec64 *now);
>=20
>  #endif
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index ef80d361b463..d93aeffec19b 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
>  static void iommu_shutdown_noop(void) { }
>  bool __init bool_x86_init_noop(void) { return false; }
>  void x86_op_int_noop(int cpu) { }
> -static __init int set_rtc_noop(const struct timespec64 *now) { return -E=
INVAL; }
> -static __init void get_rtc_noop(struct timespec64 *now) { }
> +int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
> +void get_rtc_noop(struct timespec64 *now) { }
>=20
>  static __initconst const struct of_device_id of_cmos_match[] =3D {
>  	{ .compatible =3D "motorola,mc146818" },
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

