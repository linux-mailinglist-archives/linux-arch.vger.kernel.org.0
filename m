Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C297280AB
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 14:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjFHM4l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 08:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjFHM4k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 08:56:40 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020015.outbound.protection.outlook.com [52.101.61.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDD62D5D;
        Thu,  8 Jun 2023 05:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jhpn3wpSXj8JuRiOLDeQC8KbIzYW6WQvpjjAPXZymZ1Q75HuGLId9VOR/phKCji6EZumrZyrcqxt8yFtG+h83PLWkNgKfVcPe0ncjV6SiEM6/pe7uSmxlBxbSVXFzdZWAzS25LQpGOK82+tiPvK1vsZtYPDTNZIqRkwcufKIINj5GosGEJpibMk/yd1WKdYmt9bfZNZih7eW37y95IN14/xET+mvykFbW/Id2MWAqvyFiiQV8BZnAEFb2uYg4rIm0c9UZhou5TecIRScnAbtYu6WwHIBkHxmW4RMDE5CJcILeeThwgsrRCg50xotCHnN2fAEZHGoDNKyVwwSL7PohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7Pk0okEy08US2D15VwUX/8pRFzLGry6RLULcCCb4ec=;
 b=OOkImvx2z7TRrhul3+NSV9gCA3unpcKEwS8GL00tMuNlE7zIt/5Jarp2kDQf+LBbYHy3NkNv+Bt2OTYf7JNK5jKEdaAD13vlCosSY3zSyQPA7lBcUKsZJeuXk1t7zuNhOTenIw4q8Ssn1OECZG3zbr5Xi9h5Mwajkq0Q9p7mVyv+IW3MZsjYiV4eCTVVWoE32j5Cczd+pUjWe3aj+op5WO9OXV8/anx5+zVRUYZWBCqr2uJC9zn7aCWUYyLqXFfPYezua31qer5e2uTa9RcCAiX9Q17r1ABNXM9j9s0WU9FkgIwbWOUnlguxdSciw/+MDFSQ85OPCxBcE7gMqKAVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7Pk0okEy08US2D15VwUX/8pRFzLGry6RLULcCCb4ec=;
 b=BjFOCyPGqy3zCsVCOBuo5oXGKgusGJ693705lGFmZOJWnhgVp9NRVDpR06J54P5QuTLY4vfMQBZHmpIeNRZq7vgzUfft/1YNd60lR5omFpXus1qBdeEKhWj1WTFsXyDhRfbqK8+vU9bzbZ4RkhNsDkf7ZtBesSHqUvd+k66jWIk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MWH0PF2418FBE1E.namprd21.prod.outlook.com (2603:10b6:30f:fff1:0:3:0:a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.11; Thu, 8 Jun
 2023 12:56:13 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 12:56:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/9] x86/hyperv: Add sev-snp enlightened guest static key
Thread-Topic: [PATCH 1/9] x86/hyperv: Add sev-snp enlightened guest static key
Thread-Index: AQHZlJwMbcDLsoSDQ0+wxKbSaonMLa+A5piA
Date:   Thu, 8 Jun 2023 12:56:12 +0000
Message-ID: <BYAPR21MB168808E653CDCE3585EB8858D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
 <20230601151624.1757616-2-ltykernel@gmail.com>
In-Reply-To: <20230601151624.1757616-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de8d63af-99cc-4ffe-ae28-1df97151a006;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T12:51:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MWH0PF2418FBE1E:EE_
x-ms-office365-filtering-correlation-id: ee73aad5-f191-4f03-b3d4-08db681fbd04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g95JM+2yMYYlH4SAPXUgiHF3bB8vYxLb7nBObMl1UxofNS0HILRs/gL+B4sbMMhwcVSYQ5fsGolZaW5dJ5jeVWa1fFyOYivmkMS23syNirmItQQLHQixlgLwRf77cwWPX0sreiD3a0+0pDg+As9Tm9WAAWqMP/mCGCHX6QpTv1k0tMHiR0W1CdgnaB0LzRrTHxFXvyv0ezFS/P/iWWL7+ucM8nVhLG5Y2l0y5hTsHeJ3hervz+kFDt3RBwn0YTA/U/iJwUEdABnVsC2Tx5YhyB9/pRrAPHiKdGEj4Oh3KYa68Sn3bmVi/NverV/4tvChtEKDe+1qzNrMFrh7IHTaemuKANui0qdfMxQWQwNexBVMVH1D/hLFDAL4a3lFnB2ZUnaXfJhcM+NKNYLY1/7gjqpbY34PbDtXJ0DucxDz77eu8usjo2pwRK4So+Hlzt6LLLz1EGK/Dvt+TmrwnAB/4+zDUNc95PYT4E7E8r6lwp0gUi7zWtNAP0zJWDcvfdu9X1iG/gcAasR1fmeLRc0rFDk521GGWRZfpg1s28gNGRHAqkxzpSjn0G06tfbUu8XgFuLLQTMWvw2QJ53yl4py26daXCjX25tEccOTKXDk+WS85NEw7XI6W91IT2TzkZ0o+AFfxOeH5zqK3sYGiHPx6ft1JE+4vOr9jE2e0SUqIF5rWaaqKH2Y0Pa8yFicATq8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(366004)(451199021)(66446008)(66476007)(66556008)(66946007)(86362001)(7696005)(41300700001)(64756008)(8936002)(8676002)(4326008)(76116006)(316002)(52536014)(54906003)(55016003)(110136005)(2906002)(10290500003)(478600001)(71200400001)(33656002)(82950400001)(186003)(38070700005)(8990500004)(7416002)(5660300002)(122000001)(38100700002)(83380400001)(921005)(9686003)(82960400001)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zBEw1f3Zr/k7alSQ3QB6j+pNbc45tSqdqDMuFcsLFFtukVPu7cPKs+MY/1uO?=
 =?us-ascii?Q?vaveoZHzzHpUadu1KoYxt6Ff/XQJo/dN0lgIYX7JL9zvSkyuHykV0Une/3m2?=
 =?us-ascii?Q?nV7S+imOwnBsN6Vf/uZbEqp1aEr790sMmki9YgzOJe/WRJEfJVYHFeTLXFqX?=
 =?us-ascii?Q?UFv2BOBtF/1Wl4wu1wpIh3eJSbH/YhTcmbUzrOBobermu5GFeqwcL2sKRLgU?=
 =?us-ascii?Q?HsVd7CrCxAPmcKw80vBK9aeYWUnzWYjrZF2vcSvwv+LVDMdrl+pZFdJi3BZH?=
 =?us-ascii?Q?gE9fAZVwTbeO+pHbUhGyEEL+evPxST0aNGWLxOKQ4tvLQ2oxEQNjCuJ+P4Sb?=
 =?us-ascii?Q?yaZVqRrLgoianEwqVig1xTLv9yDOMytGqQ0bo+R/qZU5Xc1TR3mYwLlJNLzY?=
 =?us-ascii?Q?R57mHopEmHytrQiWlarzC7utmNV8Llif/h/YDY9hT26nb0qYM9k4aSm05qaN?=
 =?us-ascii?Q?7RDX8NtUcAkO4lBYC2xSVPsSAg5Q9c5hoiot0LF3Bc8VL0TqQXKR8E2z+w1O?=
 =?us-ascii?Q?dA0vbzR84iTexZ2hz8Rpg2bpiikcYD3mz5mn3B00GqZaKqzZefEKPVEnIXzD?=
 =?us-ascii?Q?ytWkFHKkkjV+6HhU+Jsm+WHcmBADMaB/9dQUhUnLbJVRxkTB+dT26zQiP+zx?=
 =?us-ascii?Q?tKD+fznVklUFJQ0bbJi9sM19TxQsS4WZLFOcDsArSS19jBpFVHgVX9vZxAcW?=
 =?us-ascii?Q?TZfKsiFlcRGirM1ljg94Blfx13ALpl4IxBowxYE+OyAyX0FSpeCzyz+VCvEZ?=
 =?us-ascii?Q?+uJxn8Youv4YSbmzU3vcGN6MSvPI6GLDsErgD2Yvbc169ugyV0EVZ2EnxGBf?=
 =?us-ascii?Q?MWYPueJd3vPsdJJamqVLk3f+CXQGUtXxWNnO4jFjNxS3qqY49GxOjH5knJ/c?=
 =?us-ascii?Q?NRNHO8vuLRkgKjA7oSl0PQkwSP+iCb/WUCG5v5EaZVnVYVarM7kCUnXfrmoc?=
 =?us-ascii?Q?LNgPoRbjsmAt10DKT9RhxIDuITYc4pIhSnkAmED9uapTPaFrSXJhFHz0VBLb?=
 =?us-ascii?Q?MXrgRHNQGbi++jlMFFxKugLnczLkmi9AsxvHBVfYRZa7og3e4QB4f5M9dJWz?=
 =?us-ascii?Q?da4UJ/RSXsaxYNPYUfYBWjhVLi16yg8C+fn8E2ADCrIcgox7PDDmhi3o1KnD?=
 =?us-ascii?Q?5UPiZNpkzcRnNs6IveQ4QjXkRqq6VR5OxTVRflHBMZUXXYq4RPYot4oQhbZk?=
 =?us-ascii?Q?Y3vmbT5A5XahrkQKe7rQVs9l97mD8BlntfvFKQfmh1H/AJVrOkZLo8Lu7gnz?=
 =?us-ascii?Q?KntklQ0y2A0RRjElk2jZBFF6hz6KMOw1ZDMwhpHCsuH8AfA1m6eLS48zNLFw?=
 =?us-ascii?Q?a5ryxusYwTlQoIK5RfSgMddaSQGvr2FVtD0O2+/J21wMWN4lUoTpYRW6+u6b?=
 =?us-ascii?Q?RI31oymZ4aLUXF7YhbfL1OG/Jqqa069De9LYzNtHpZW38TZmyzfXGoITT114?=
 =?us-ascii?Q?o3d95BLgHusUsRL9pko20y3LRonGt10cL3vBzApkY3LIYsbqZ3c/EMskoIzg?=
 =?us-ascii?Q?KObNKhhXImjk+m83QXgAHeGzFV1knajrs1l3xjQAQlhB6SlReJ5f9phFUrF6?=
 =?us-ascii?Q?Cl1yoO47p9/LlTgrznlIyIcY1M8i6Sy8NNGch5P12kVCPn96SksxWARAByV5?=
 =?us-ascii?Q?mA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee73aad5-f191-4f03-b3d4-08db681fbd04
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 12:56:12.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ovTQP1D/LxMARLYbHvQiBVLYuTaldQx4CKU3zRQDtXg0FDuKf7UZ5Y8FURn5U6Z7D9pi0BsldZzvuWTfPNe7wp1FgSYHRaPGxR1q6hvg4yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PF2418FBE1E
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Thursday, June 1, 2023 8:16 AM
>=20
> Introduce static key isolation_type_en_snp for enlightened
> sev-snp guest check.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 11 +++++++++++
>  arch/x86/include/asm/mshyperv.h |  3 +++
>  arch/x86/kernel/cpu/mshyperv.c  |  8 ++++++--
>  drivers/hv/hv_common.c          |  6 ++++++
>  include/asm-generic/mshyperv.h  | 12 +++++++++---
>  5 files changed, 35 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index cc92388b7a99..5d3ee3124e00 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -409,3 +409,14 @@ bool hv_isolation_type_snp(void)
>  {
>  	return static_branch_unlikely(&isolation_type_snp);
>  }
> +
> +DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
> +/*
> + * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
> + * isolation enlightened VM.
> + */
> +bool hv_isolation_type_en_snp(void)
> +{
> +	return static_branch_unlikely(&isolation_type_en_snp);
> +}
> +
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 49bb4f2bd300..31c476f4e656 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -26,6 +26,7 @@
>  union hv_ghcb;
>=20
>  DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
> +DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
>=20
>  typedef int (*hyperv_fill_flush_list_func)(
>  		struct hv_guest_mapping_flush_list *flush,
> @@ -45,6 +46,8 @@ extern void *hv_hypercall_pg;
>=20
>  extern u64 hv_current_partition_id;
>=20
> +extern bool hv_isolation_type_en_snp(void);
> +
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index c7969e806c64..9186453251f7 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -402,8 +402,12 @@ static void __init ms_hyperv_init_platform(void)
>  		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
>  			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
>=20
> -		if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP)
> +
> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
> +			static_branch_enable(&isolation_type_en_snp);
> +		} else if (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) {
>  			static_branch_enable(&isolation_type_snp);
> +		}
>  	}
>=20
>  	if (hv_max_functions_eax >=3D HYPERV_CPUID_NESTED_FEATURES) {
> @@ -473,7 +477,7 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	if ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_VBS) ||
> -	    (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP))
> +	    ms_hyperv.paravisor_present)

This test needs to be:

  	if ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_VBS) ||
	    ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) &&
	    ms_hyperv.paravisor_present)

We want to call hv_vtom_init() only when running with VBS, or
with SEV-SNP *and* we have a paravisor present.  Testing only for
paravisor_present risks confusion with future TDX scenarios.

>  		hv_vtom_init();
>  	/*
>  	 * Setup the hook to get control post apic initialization.
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 64f9ceca887b..179bc5f5bf52 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -502,6 +502,12 @@ bool __weak hv_isolation_type_snp(void)
>  }
>  EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
>=20
> +bool __weak hv_isolation_type_en_snp(void)
> +{
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
> +
>  void __weak hv_setup_vmbus_handler(void (*handler)(void))
>  {
>  }
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 402a8c1c202d..d444f831d633 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -36,15 +36,21 @@ struct ms_hyperv_info {
>  	u32 nested_features;
>  	u32 max_vp_index;
>  	u32 max_lp_index;
> -	u32 isolation_config_a;
> +	union {
> +		u32 isolation_config_a;
> +		struct {
> +			u32 paravisor_present : 1;
> +			u32 reserved1 : 31;
> +		};
> +	};
>  	union {
>  		u32 isolation_config_b;
>  		struct {
>  			u32 cvm_type : 4;
> -			u32 reserved1 : 1;
> +			u32 reserved2 : 1;
>  			u32 shared_gpa_boundary_active : 1;
>  			u32 shared_gpa_boundary_bits : 6;
> -			u32 reserved2 : 20;
> +			u32 reserved3 : 20;
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> --
> 2.25.1

