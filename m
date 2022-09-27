Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635B65ECF1E
	for <lists+linux-arch@lfdr.de>; Tue, 27 Sep 2022 23:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiI0VIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Sep 2022 17:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiI0VIx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Sep 2022 17:08:53 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5101C26DD;
        Tue, 27 Sep 2022 14:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHSH+CVFpSWqtB70BGQpYjS8apw/r9RdiC51GT2W9zN/sJ/aJ5KusSJWtSnf3xmlX8StqUz85aGw3osZ/rY0V9tqqRlbJqpMYK89kB47pFqO97x89iJFHp0hixqyL6CZFvDH7kuJO1p+SieXn9Ll1FmEaChHTP5D1TbnSYpfmHpbT83XWP4ovtbG5kifIz6u3xLStgTyURglXpJtqgPDsmWAMrlmwarbR0pBA5ZdQUsvMWTbDX2V7opbRl8hmrOchju8XA893NWSPVDk1qBC28o35iHqvM0Zh7PsSP09DJH5F2xXhUsR1ccAPfqbOMyNtp9pPmKm0yxJgDvNq/2x7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6EOQVtueklmSwhWxMvdhmB07wQWZwzUhHz/egqRJWk=;
 b=jnyBvQnMZjqCDWaSk27w7oU3QULxSB6MVCDpJv31brU7/7N0/NtOWvX+uygAHZOBcqiQHDmcDRCgE3BY5PXfLurYpNtq2JN2yKzGGQy2Ug9+gONcdtP17lySwJTA9SxqYmXcfMZneu2k8V9+AaCkzxIfLQiDp3WtA3xmC+gnw36pIjQQrr+B/RG/SWtAFNVBjq7OBLA+98mHHGSp6HV/ipMeVXNvSLHaK7QXt65vyVmHvvqo9MqVuN+2ClpDPbeTRXNzTOpNJdOsAvdoW968CItyA11xLA6lMjdgJmgrtrhgWbmjnprTCBW9OozDENi3AdmWM78fWnDGICx2MEjvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6EOQVtueklmSwhWxMvdhmB07wQWZwzUhHz/egqRJWk=;
 b=KPrXdlSs4RJSLkI3mwIQuw+lx4HAJQ+Cnuqt5Q+W6O257I87TtiY7awgrZyZdvBW7un8vmHFsQQOaxjf2XRGkcywrLQgq85w32urgjuQCpGUOV8DKlhPw1mZ4BrPjTspDaycurYfJFtKzMVjau3xP+0XRFx2uRqAZg0P19v11JA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1428.namprd21.prod.outlook.com (2603:10b6:a03:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0; Tue, 27 Sep
 2022 21:08:49 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5709.000; Tue, 27 Sep 2022
 21:08:49 +0000
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
Subject: RE: [PATCH v5] hyperv: simplify and rename generate_guest_id
Thread-Topic: [PATCH v5] hyperv: simplify and rename generate_guest_id
Thread-Index: AQHY0kU6yw6DQGKJiECLriNBOOmP7a3zxQzA
Date:   Tue, 27 Sep 2022 21:08:48 +0000
Message-ID: <BYAPR21MB1688ABC8562E0AC0830237C9D7559@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20220927074550.3347-1-kunyu@nfschina.com>
In-Reply-To: <20220927074550.3347-1-kunyu@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9d09b948-d7ca-499d-92ab-41aa1cba3f18;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-27T21:04:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1428:EE_
x-ms-office365-filtering-correlation-id: c804d620-a0f0-457f-5e4a-08daa0cc7901
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CcU8R6slQSKldmAOL1UDes/b7Vw7nymRPGJAJyRXD+BBjAQS3U1ffM9GF7yD17Z2e3ImmgA9FamuOzyWp669lxz/9/wNr0mOpEhYSSiQF/NLiLCWz3JXEcmPAUjLHuaYEh3NFsp8C1IR10ziBjwka6AhqXH7XSMPg3ggjO+Cs/uubnRLJLH6lKG/sUtIcxJkMwtuqZufPqZxMJr30WUuRKvv4PivYdrCbh6XK3pti9kKEJ4KsQua/PsNoM+Z9x9sFchPnC3PLpWq+DIbD2W4zFnylK5+efGYa8eyFhsLfsebAYBijr66d76Aa0Tifk5LR6Uqdp7Ymzyhtgmp0Oyzoihm+oTcIQr3L+nFnokaL634HSpCdJ/04c4D1fj9pINU9SLcFUGWn6Sdim16bCIPw90bTts6pFvfTvMRHyspyRGHEVrN9Iv6VAl7V4gcAKCWZD1KwC9UGD+bKj9pqs+0tgRFbEFDI7H0T5s9Nt4WqRr7X2eEK0uCB4OptnaqLVOR1XUxDHtEVF4nFPzkxOW1SxxWeOyAah8jA3jlTYxRHBbNVh69NHvDhND6pGrmMzp+vZ4hPRZuHQmkdVMg61sHgzvx7nSr1ENSt08BTC+VuQxLCdV3YYhhDfxmkFX7D4m3yN/FBZWck0REXta7bPTjgSoTvRPkLJj2aO5451DjsHd9Nuk/0BXRpSIj2YTCcBEMW3iz8hhv3PJlmPtcEmPnz3ES5YEgll1IjEzhsWHCvg4fSTSQUVoZbhLSlm/VrAn+FbrY0bYzHS6J+esjdx2ewU5BRUIFNR/u4ByQQkt4YJiSAO6baTuJ3osyykfBPlctPxJnG/twt2R4fQYo32CJuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(83380400001)(9686003)(71200400001)(186003)(38100700002)(82960400001)(82950400001)(2906002)(7416002)(38070700005)(921005)(122000001)(478600001)(6506007)(7696005)(41300700001)(5660300002)(8990500004)(52536014)(55016003)(10290500003)(8936002)(66946007)(66556008)(26005)(66446008)(8676002)(4326008)(76116006)(66476007)(64756008)(54906003)(316002)(33656002)(110136005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S6zm/O5lxbxPIDOVzNyqR8tsUrSRlqTuqfOwfVWwRf+QZUsMithUqyvb0VPH?=
 =?us-ascii?Q?V7zT0KaGYeP723OvxoAR9gz2VRoRCv9Ve9XRpzthIzb40V9EUQo7MLGeowLF?=
 =?us-ascii?Q?fmieb5OrKDTW38u95dc2GxFdCaJQWqOJ4FiIOS5oxf4sXIYphdaNojAoR2Y8?=
 =?us-ascii?Q?s55St3Fr0AXo8jRK4tT4OoWzRwCd0hyVEVbEPbfk7Yo6hcxT4hXxQNbTGb7E?=
 =?us-ascii?Q?2FTitq/3LmccphErPESU+EPvAvzeeQcEJIITtZauVrzSsN1QH7YWg9p8T8JP?=
 =?us-ascii?Q?AjZnwW/+kf5saW16EpiXaZApNgALifamYty0PhOUXpMFpwddoBs8MVEFCaG/?=
 =?us-ascii?Q?bx1MP6nTN6QZm/tMGoSdGppzbQlImZnRGNdG17TCvmg++WFhoKbeaPZRGV+J?=
 =?us-ascii?Q?OY3ygNQ7sxO5nyzhLNtsJ6zoI62P1dtYVor1QaZ+XYzS9YMPAzXs1DRq1uYv?=
 =?us-ascii?Q?9uQZs7IBtn9Li4ubh3bMQFmsQKN6FO0lg/h+ebjqXqDE8pl9dRrhq+SblGH7?=
 =?us-ascii?Q?iF3zPxUIxBtB4jPWsdXl+4IpFdGddH4uaG6w602N7fb3IQZT2fQVNEd4VOsY?=
 =?us-ascii?Q?tHxy6DTDCPeN64NgTOPr82XTYn/EeClWTwb65gH9a2SK+A82pryM+ATd9L1H?=
 =?us-ascii?Q?wRZNUb1UVHoyWG0DHXt1YsoH4lG+/WUM4/+HMCgLq/RN2MqvdYEZRQXkq7u0?=
 =?us-ascii?Q?jbIEmUeRt8IsnB0qaT+Dg8FNEwEb41NuUVegTCqGaqglpWlbgA70s29lJbpx?=
 =?us-ascii?Q?OIgpTw99EW0kJ2G5vFMLT5BsU+dv9GEm+japLkgnVnKu3aqnyO91yVGveVaV?=
 =?us-ascii?Q?rU3GBNfIsA7eXBVal8CkUXnE0PJ0WMme37/1DZ09nrx/+jfRZG2gWvQdiYgU?=
 =?us-ascii?Q?R9ZApUEoAX/qHZAYC8oUxgmEahs+R8XkptsTe6SXHOhSzP25t6k6EnuTVmUn?=
 =?us-ascii?Q?4VagxIFn3gsn5WjrXRyZmtJDX2J7Dp3eXyfP9TziVXI9Xb/UJGt7G1O0fpvu?=
 =?us-ascii?Q?3Qf4p2Iwzw16oVCuqKXn9LPhIh/REnCeEZizgzJflDjABkgil5qlmrwy0QCd?=
 =?us-ascii?Q?aMcnkjMDXuynv0W/Z7RZRPCGCv0q+P4eIdLXjnM354R6x00bgwUGIfo9BLl5?=
 =?us-ascii?Q?ZnvaZWdU2V47BZxsezYyGn2n0tz4F0eiNB3TRCrEIuPL+ElfcJnTY/v/aSWR?=
 =?us-ascii?Q?eUAE6rMFp9YrAC6AQSLzDOg9eP2X8buOWEmMn9SEMxRLoD54ykezpnPUYyPv?=
 =?us-ascii?Q?q+5ctyCt9Ajnslx4s3R0S8jCQouyYSQtrlYe4koLbvb11x8nFmv6CB1P7Mbo?=
 =?us-ascii?Q?DacfuBYHBQ6xkMan8wq1JRDTZyduFti2dfSQ8W/9qvaS9L7cK5NGp4YgqGyh?=
 =?us-ascii?Q?kNcQyABfeyUZs62YYaB9U7nQ/TGNuZ3jbgFeQ+GJ5qH816KoS9O3fk8VEpoF?=
 =?us-ascii?Q?QncTCmjhAmHCue7v5WdNrBU8ID47EBBK24TNG16/JVgQtMHYzKmlf2jYGQeo?=
 =?us-ascii?Q?3VNqFzyrGmuUfBj/N1VYHhvg5z67yz1OnZlI73bq2zCah11Q/CC1QMQj3nO9?=
 =?us-ascii?Q?5zR1rMu4LtQuecbwNcRHP2qKzu3qqVaFiBa+7kl/P4rgkTfJ1Rx6+O7WDu4M?=
 =?us-ascii?Q?sQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c804d620-a0f0-457f-5e4a-08daa0cc7901
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 21:08:48.9939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2y1x2EictKhPvgZI2NPLEPSVdRrEQDJpYtH+QXdudITLNZDZ5W+1pUNjzmGgxOf+HbPlOZ5rCqVVT/GqYGpCokGcdsln+64DQCGjk20odI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1428
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Li kunyu <kunyu@nfschina.com> Sent: Tuesday, September 27, 2022 12:46=
 AM
>=20
> The generate_guest_id function is more suitable for use after the
> following modifications.
> 1. Modify the type of the guest_id variable to u64, which is compatible
> with the caller.
> 2. Remove all parameters from the function, and write the parameter
> (LINUX_VERSION_CODE) passed in by the actual call into the function
> implementation.

The above statement is no longer true.

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
>  v4: Remove #include <linux/version.h> in the calling file, and add #incl=
u
>      de <linux/version.h> in the function implementation file
>  v5: <linux/version.h> is changed to the definition position before v4, a=
n
>      d the LINUX_VERSION_CODE macro is passed in the function call
> ---
>  arch/arm64/hyperv/mshyperv.c   | 2 +-
>  arch/x86/hyperv/hv_init.c      | 2 +-
>  include/asm-generic/mshyperv.h | 9 +++------
>  3 files changed, 5 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index bbbe351e9045..a406454578f0 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -38,7 +38,7 @@ static int __init hyperv_init(void)
>  		return 0;
>=20
>  	/* Setup the guest ID */
> -	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
>=20
>  	/* Get the features and hints from Hyper-V */
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 3de6d8b53367..032d85ac33fa 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -426,7 +426,7 @@ void __init hyperv_init(void)
>  	 * 1. Register the guest ID
>  	 * 2. Enable the hypercall and register the hypercall page
>  	 */
> -	guest_id =3D generate_guest_id(0, LINUX_VERSION_CODE, 0);
> +	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
>  	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index c05d2ce9b6cd..bfb9eb9d7215 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -105,15 +105,12 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16
> rep_count, u16 varhead_size,
>  }
>=20
>  /* Generate the guest OS identifier as described in the Hyper-V TLFS */
> -static inline  __u64 generate_guest_id(__u64 d_info1, __u64 kernel_versi=
on,
> -				       __u64 d_info2)
> +static inline u64 hv_generate_guest_id(u64 kernel_version)
>  {
> -	__u64 guest_id =3D 0;
> +	u64 guest_id;
>=20
> -	guest_id =3D (((__u64)HV_LINUX_VENDOR_ID) << 48);
> -	guest_id |=3D (d_info1 << 48);
> +	guest_id =3D (((u64)HV_LINUX_VENDOR_ID) << 48);
>  	guest_id |=3D (kernel_version << 16);
> -	guest_id |=3D d_info2;
>=20
>  	return guest_id;
>  }
> --
> 2.18.2

I'm good with the code.  Thanks for taking into the account the input
from Olaf Hering.  But per my comment above, the commit message
needs to be updated to reflect this last change.

Michael

