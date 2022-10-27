Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB360F981
	for <lists+linux-arch@lfdr.de>; Thu, 27 Oct 2022 15:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbiJ0Nop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Oct 2022 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiJ0Noo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Oct 2022 09:44:44 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023016.outbound.protection.outlook.com [52.101.64.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E327FAE8;
        Thu, 27 Oct 2022 06:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkvqBT7RrZdQ/b0mLu94W0gTwI3FiHcI3jg0INeOJXgI2Sdk3Md07vzG06YRG6vLZpB/go2ZizhtpX9D0ZL+pz18ilZfsPyw5mHvRXz+xypdQRStSCIvC+bcA0T7UQdeM4D7yU5m33UJDSNrAgZaYrS8/LGaRPE/2sFWt93rif2ojO1Ewc7bkfXM49akSCoQHdl/5lRjcfOV3pw/6APh3VKmKsWDQQZy8fa/Nf8hy1kIricv+x4eje5r6GtOEmmBXyBNR/cMNGGhuR1BvrDiM0jY4i8szoeGXqKIUqJRr4yOwObWf7RBnDEUgE8anhYxhcIFeXpdjQqzFff4Gcsybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cYJoaG6KVUlnx0tVpextdzky09PM0w/nfES/Fi1XRc=;
 b=j2WoCuBGDku9RGlh9HR7WvMkdbqrS6Z1G8duEd03mRPtsFreSdNqNYbfaG+f/BzaJUsS7F48SHUkzbKB6X+x6umEeI2GhT7fF0XxupcxcwzuDbpbV7PsmKQ+bLRbsl0ZyB+vz/RNORkC+arvW2a2TbVBO7wc8FnxlUmVrl7J47fi/yHJx1lPJPEYSFJ+LFLu7Teo363w1w5cvA/vNAIFAf0R/crtEouG/5Xhil33u/MSf2oLSV8JMMGFB64xgrCwwZBR9yhhglst60f6HNb+NS/B63iCKKivGgDJ9mUi1TG/edWP0iPeeBhUTMb6eZ0ZfGDKml/TBAGtSUpjRctwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cYJoaG6KVUlnx0tVpextdzky09PM0w/nfES/Fi1XRc=;
 b=eJpcDDQLIgVqS/BB+p/QX8sWTU7PitVwi5acXMN2Uh/kVXdvTR/VZS52hLjIwwn6C/T90SemCr8Wk4JeoqY2WIpgE9aXJayCHdvLKYFSql2rvWNKohkXJ+dDIsqNu4oaGhSTVBH+EFvu/4+7eDmFhCTUNWsc0oi1+EXQpnir/o0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA1PR21MB3809.namprd21.prod.outlook.com (2603:10b6:806:2b5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Thu, 27 Oct
 2022 13:44:41 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5791.008; Thu, 27 Oct 2022
 13:44:40 +0000
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
CC:     "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "mail@anirudhrb.com" <mail@anirudhrb.com>
Subject: RE: [PATCH v2 2/2] x86/hyperv: fix invalid writes to MSRs during root
 partition kexec
Thread-Topic: [PATCH v2 2/2] x86/hyperv: fix invalid writes to MSRs during
 root partition kexec
Thread-Index: AQHY6erhFE1zdq3efUKf5zsoIswvq64iQBpw
Date:   Thu, 27 Oct 2022 13:44:40 +0000
Message-ID: <BYAPR21MB168872A298C1CDC140FBF454D7339@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221027095729.1676394-1-anrayabh@linux.microsoft.com>
 <20221027095729.1676394-3-anrayabh@linux.microsoft.com>
In-Reply-To: <20221027095729.1676394-3-anrayabh@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=26158297-5d35-4ff9-a477-14a9bd09a902;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-27T13:42:34Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA1PR21MB3809:EE_
x-ms-office365-filtering-correlation-id: 7c3c8bff-0897-4eb3-d7c6-08dab82165df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOHLH/CtQzLuejL8h9KZ4/DwHuMkxwDH+1ac0MxC3PUqcMMQeHbCqGt40A8TsnIwAqO2aLBZ0W/hZ3dg6W1CBCS6o4lox8bg/JkwB7RosgsSiGsFm5OmMXr4v4Le1r5h1z6j0F7uERSvHAQdlNYdPh4GkO6tJiXP0N7GSEp6ESgUz/CnGqZywhOevj1Zo70g3TJ71+6zT4dpNc8wBkS9gAtXg8vaFOVwt32JZvcHH38P1kfBmhwezefSb0I3vTPFbrGf3FMD1Va6zVnR/BvjOspt2Ue8tO425aqW184VmbsZoZEf7E1rZyJWFzuiVEDyb9PDbUg936tT0vkrnS3yPZ7lVWRuNHHRbtnmKk8RMe2TM7rs1KGP8tmhM8HMuR4jR3OXEY2Ojmg8WRFM8M1wg/3M/4ek0CLTjGiB6PG3keVwhylUSh9zrjNOc9Oe21CByHTMhAC0i8qp4n/Rw0M7hxlmt8Q5Vtv+uJ77+vQ8lvBWtgUl0yFu9PRoX4XHJdeAdQgI11AdCpM7QxGeHSSIHFgSiiVyDhIdVE0EsuaDqDZMe0bzhZXr/7Gsx+eAnsVLpyOsrHxI2mAy4zhfIqIQrJy/4cb4K3ukVlnLleI/fpJLNu7e4HFIypeZJykJiVdqko+XyZ/u8apu+rdAsfaSDhJJ13CLP9ag5kaJGS1KZ4riw0gMYx2ci1x55IRonpgPtDBeoJ1xG4kt47x0jl0wbctKDFjC91ekMuFWHJNAlwSNoQzEiz67PAcP1y5PzuNd0xXuMKhPE/QEKA0nFyvW6atoNKoSK4TG8KKU4mTozK1T1FbXgFPxwsoo3zbTEdEp6Z91GwXP2MdsXAhS/HR6sQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(33656002)(2906002)(8990500004)(64756008)(66446008)(66476007)(66556008)(38070700005)(921005)(38100700002)(122000001)(7416002)(5660300002)(110136005)(52536014)(41300700001)(54906003)(8936002)(316002)(71200400001)(66946007)(55016003)(10290500003)(4326008)(8676002)(76116006)(83380400001)(9686003)(26005)(478600001)(6506007)(82950400001)(82960400001)(7696005)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9sHptFkmZEoMSNEIsxCJ0M2Vt3k8cLVmBC8YGg6aXbTipE1JrBK5ygjAqIUO?=
 =?us-ascii?Q?Hv5d0WuWJHbfEBldLsmLnLw2xCDf3X9GqEltpu7CHagsO6ap5Vc1hgihIFfk?=
 =?us-ascii?Q?RwYw7hdCDNmtwVrbMbyD8NjHCOWlOp45MUjwpJU6RVLt0QbZQVFC1EHj7P7n?=
 =?us-ascii?Q?z/UAjvjX/CG0s770ITU5zNASEvGnztDAvX2cgcu70woNLCkWRn0bgNacsjN/?=
 =?us-ascii?Q?+tcjajUIzhUhLiIoG9z219lgI6EWl5pkRvPiuUbcjQ9F75ih8x3uAVSsaaAQ?=
 =?us-ascii?Q?Rsm0pWWRJ4TRw6wXrrMLkiZBP286spvj6x0PyR3E9MszZqMd0kOozsvanM9U?=
 =?us-ascii?Q?JjORKkPLTP87Ljy1sO0XoHi6OtgHk+9c1NDBVl3ZCTrGVgcz0foga4MeDZhe?=
 =?us-ascii?Q?w5Y0iIZm9rs0ctv5WTxZCDIot6SHLx7ILDHIJV+ofsbuSI2DsinMi8ek5fyr?=
 =?us-ascii?Q?ZPRGOxwaSycpbzPDWHqlYnHqvVCF+eUafbIOKrWWEAD/pLGjYoKJsXMrE0qB?=
 =?us-ascii?Q?1UjQU3EOMEMoCcgyzi7ztbI4fLBZ3VCeL3f3nhH98xzIntvlFfV9rNcmiyRl?=
 =?us-ascii?Q?BrEFpkJg8pApcBGTI7P1g+uGhpzwyDBaJTrj9+Ukx07VZOJdvcfsQecld+11?=
 =?us-ascii?Q?BhdEaAvup/yGII2bQRAUaQ2M31wLCl1qrZMAus3NQZSkRiIqDvZwM1yw6doQ?=
 =?us-ascii?Q?NAgylu9u4gh9P5v01HSS0uecqIMr5mXGweFpbnOhMGgP1Ne7bjHqGgJqmfRA?=
 =?us-ascii?Q?7MZI7P5QZsV8+DBL3dcvOpIr83RQrDsUUC4fQ0N/7KXec40d3HHlGImBmEMZ?=
 =?us-ascii?Q?IqieX+3NuOdCRuu8RgKoM8+oLBvVmAmUkDBsG/uNjE0lmhWYmbi5JqenG0rk?=
 =?us-ascii?Q?HW56SmeEFB60AlR0doY3S+jPTPDgh3scg9rlPQfgNhHg22ZBI3HR3B3YsTK5?=
 =?us-ascii?Q?lmZwSQmJuz6fhQ68wz8Q3JBZ0Za86DlHOmFVcTLjlItsclqo/K+ziL2Y/Ocp?=
 =?us-ascii?Q?3aw8LCY76DLTV8edZ6tP7lqk39p1fmjSlTp3emZy9NkauUja5S3TJEEGhyzB?=
 =?us-ascii?Q?sMAIlZ21HL4k7n8MoLFtTWKYSF1ux8BxclGL5YgMZ+xjmmiwH/pWHoRFyyCq?=
 =?us-ascii?Q?udLymTHxRgGwMvve3XZuFgzSsxYGz5U60N3hfyQ1OvkqDKAvl32kLRFIwvyo?=
 =?us-ascii?Q?GVSRsUZ5rxzNo2B0dZSMjB6oImBiG4OIDNH8Zaq3iUvMHS7pGst6/aFFIhiV?=
 =?us-ascii?Q?9CLR6OqsR+HaepwHZg4X9yaxGB9tWUPWxqXxO53WQSxtKJYDVcd9Isui9AUz?=
 =?us-ascii?Q?zfskIQrIvVSEXTa01nSR2sXGa0qP3+98Ltc34itWGQYboSEjqBWr52vBj40H?=
 =?us-ascii?Q?Finye4od51PZzpJmcr/oUFMtKDPB2iP+A4q5JsQzFbBChJtIHC1a+YQgMbBW?=
 =?us-ascii?Q?PsT2AhECnLPRqaI0Nrg051+oQ6twqlpMUo/KmJpumXdSo4rDeAZXATgSPvFY?=
 =?us-ascii?Q?UBzmnm0qNCo/U0bIY4VNJ0tTW41zbW7Cp+twALSgSzkZORE1EWKNIBfjSgVu?=
 =?us-ascii?Q?5DblBg3mayR0NNmyD2v2H4T0O36qkeri/CN5bJ7JFCDH1EqyZryPPddjMsgT?=
 =?us-ascii?Q?2A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3c8bff-0897-4eb3-d7c6-08dab82165df
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 13:44:40.8321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPvPg7HZK3Xpl7akj4VnzfrV7gFA0+lUrTP0sOfA0YeMJywGvzKo/tjpiP3XHzoLgJ8Ymk+8mQhmOTOxhzQRRe74UljarsGioUO7QtDY7t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB3809
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Anirudh Rayabharam <anrayabh@linux.microsoft.com> Sent: Thursday, Oct=
ober 27, 2022 2:57 AM
>=20
> hv_cleanup resets the hypercall page by setting the MSR to 0. However,

The function name is hyperv_cleanup(), not hv_cleanup().

> the root partition is not allowed to write to the GPA bits of the MSR.
> Instead, it uses the hypercall page provided by the MSR. Similar is the
> case with the reference TSC MSR.
>=20
> Clear only the enable bit instead of zeroing the entire MSR to make
> the code valid for root partition too.
>=20
> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 29774126e931..80fdfff9266c 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -537,6 +537,7 @@ void __init hyperv_init(void)
>  void hyperv_cleanup(void)
>  {
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
> +	union hv_reference_tsc_msr tsc_msr;
>=20
>  	unregister_syscore_ops(&hv_syscore_ops);
>=20
> @@ -552,12 +553,14 @@ void hyperv_cleanup(void)
>  	hv_hypercall_pg =3D NULL;
>=20
>  	/* Reset the hypercall page */
> -	hypercall_msr.as_uint64 =3D 0;
> -	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
> +	hypercall_msr.as_uint64 =3D hv_get_register(HV_X64_MSR_HYPERCALL);
> +	hypercall_msr.enable =3D 0;
> +	hv_set_register(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>=20
>  	/* Reset the TSC page */
> -	hypercall_msr.as_uint64 =3D 0;
> -	wrmsrl(HV_X64_MSR_REFERENCE_TSC, hypercall_msr.as_uint64);
> +	tsc_msr.as_uint64 =3D hv_get_register(HV_X64_MSR_REFERENCE_TSC);
> +	tsc_msr.enable =3D 0;
> +	hv_set_register(HV_X64_MSR_REFERENCE_TSC, tsc_msr.as_uint64);
>  }
>=20
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
> --
> 2.34.1

Modulo the nit in the commit message,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

