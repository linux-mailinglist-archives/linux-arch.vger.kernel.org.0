Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7527B7473DA
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjGDORQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 10:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGDORP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 10:17:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2111.outbound.protection.outlook.com [40.107.94.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB561AC;
        Tue,  4 Jul 2023 07:17:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEoH394YjTodv+ZzOI8/4CKCzJPhB/xwNYhSe/dBZ9JTSHJfdqJwNfsAIdR6ZLwE/cFzUUrrwWNZmbRlqsWzOIMzSj2F2g55gvvM2WucZOOmFO1Pexp/uJxKRtgpPLj6T3pOZMwF8M8DTnj8inAn7Ihkwmuu9tnNYrgS0XZT+gkn1DYZOEmCIf+hSLKf5zwtmptt34X1SytLzSpsNFwrTYg+HU2p1V6msp8fqSF4p9hLT7ZHlOdbWO4DNr2FDMXUWikYAclohBrhDMHoxvAMG/1zj4dry7uZxffu9UDXFPWE33Ew3fWm5jaS2i9Zv+laTByH1mc9Punc7UXxPvgmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB+55NC/I/MIyxcj8GLXZHZFTSu3JIAtwf5YLy3nRFk=;
 b=fX9id2L9v0DleKClgM9fJKBwuRq6L2uP1XadMJbxk0qqOzaX8qnKn9IjmkQ6YfEfT8DMt1WacOeqmFu3xEH7j6pXYOD1fKiryNV5OhFP3X31LUvlwe/iAf8NKnWS/PgMsxnlo4ArSCxxdP8mne4SIWtdIzdGfxXbnUdk2sMU4K1VB/uzkCus6Iifm1ZqHtHzWxMrxtet8t5wwEVBRNBc/YV+7W61fC6sTwXhDEhCo/+eYeQRPzinmXzReTOQ7yeq9W7+sjLNQAw2wf4iViRHqCbncNx0u4/FYbM3/c6AlAuqNu9jAJhZs2NdjbILZSXmQMFBDhYgZ4ptL4lof8O5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB+55NC/I/MIyxcj8GLXZHZFTSu3JIAtwf5YLy3nRFk=;
 b=Aa/4Uu+lbTqNI8jMr92IXJXJYcHE9wBalz8lvv/skFrHWFv9XJ2X11z7Jn34rIZoaZZLYgcyOhvBRT/2QGyRAFOwsLuCInqmzGMllCRKwV1+sSN8Z+fqkapB7sDBDeHt7IMI8gaI66kJ6JDAuU/2fjnHy/hKDFJJ9mvvoB7iE08=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3733.namprd21.prod.outlook.com (2603:10b6:930:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.8; Tue, 4 Jul
 2023 14:17:11 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4295:75a9:26d2:e64%5]) with mapi id 15.20.6588.006; Tue, 4 Jul 2023
 14:17:11 +0000
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
Subject: RE: [PATCH V2 1/9] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Topic: [PATCH V2 1/9] x86/hyperv: Add sev-snp enlightened guest static
 key
Thread-Index: AQHZqKasDlCo781MIEWDwFT7WbQcKK+psokQ
Date:   Tue, 4 Jul 2023 14:17:11 +0000
Message-ID: <BYAPR21MB1688570E8D0D0C49B68DD548D72EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
 <20230627032248.2170007-2-ltykernel@gmail.com>
In-Reply-To: <20230627032248.2170007-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=627109f0-dc4d-4710-82eb-bae116462f43;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-04T14:15:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3733:EE_
x-ms-office365-filtering-correlation-id: 77b61816-9ecf-4375-ed17-08db7c995b96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cs1oLQhJlGA3eCpzSS5f/SBhyrv7yBziHhkq6NmLrKy4ipr7HvfW+T/18z28g/zA/B0kz/5qIQP0Rb+HDUr2v3SrfySa3lYsA80mCvbnFLCr1vxk8xYkMCLTvge8Fy3o726gEzjE4NK/U5TNmjeVFg5yyxDKmpw28slFjSTHRYelG4p60b5I6tQXFV7iCM5HIVa0gsiFK84wIAOvbfihDkIMJ9Gf73EOVxa4uCPdxdg8tGDlUtyEW7Yk5JrByj5MXitc6+b4oY0pGwK+Rv5MqPJI8Ut1mhogrVq3MlpTAdtdcV1zfwBL6+GNDU1vJb0YcdEfPONJkcMRLWvz2WWvA8m8A0J/i4ouZfz0kmsWpcqMNoq4wCjbxa9Pf0NxMgWQlg3HGhpkYTQuSl56BN9PqZTlc6WsK2+GTJWRCMvi/3jmv7EBKYb4fzATTb+F+V9dD19F4MilUCoVe6lV8/bm6y/orrlkaGcAogJ6y84h7l5Lk2BqvqDi/iuow8w2U7YkQE+0kG63qKpUHUktimGNY+hvSldh1VkQb/5VKCf6z1Ks85Jr1bK/kMcqCI2y5YpliqpDXkquT6nYuN+5BJQFfUAatbBJ6jN6KKITHgnTRJ5/THpZyxoUT8QsqN5VjLVf3libHGQLYJrOC8ViGOnOWSApKxrRU0CpK+x3OZLINlFKWV7VP9avoeoRihUjqtFk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(8936002)(54906003)(110136005)(478600001)(26005)(9686003)(41300700001)(52536014)(33656002)(71200400001)(7416002)(2906002)(5660300002)(86362001)(7696005)(64756008)(316002)(66476007)(122000001)(55016003)(66556008)(76116006)(38100700002)(4326008)(66446008)(66946007)(38070700005)(921005)(8990500004)(82960400001)(82950400001)(6506007)(10290500003)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fSTV0aWqnwfkwwAuFFGqip+ij1Dwabftm2u0SsF0CcT8maMeqwd9vSfjMG/P?=
 =?us-ascii?Q?/cS+Z0QSjjDesQOzcLO3o3NkzktNBn0SHbqfOh3lXfr2FDHMwfYCyEi3pLhc?=
 =?us-ascii?Q?di/DRhMNJm97phWlkl5rpFkVPcxy/Ljab5K+Ns5aM/dBHfr5q+c5fpF/MncJ?=
 =?us-ascii?Q?i7GfO5qKkfXozaVUslcSZ8jsCCkKI85lqkybYsKN5JE/wqHChrdPKpc+QEzm?=
 =?us-ascii?Q?LJXNaViASd+tQ51JcURPmnJnNoRmiVMQWOT2deuyx2fl4l1wzwMYooj1YOUM?=
 =?us-ascii?Q?796YwjQSAgozNRf9KqYwbYfTzkUvQZAp22wqK/rrKdlDy0RI0TjjOerrFGnL?=
 =?us-ascii?Q?mDGZ6X6QPj+vwdfHohYJ7bpNJLtDJXZ2gC4WGbbZATSZ6qEgUHvXpzOb8cdn?=
 =?us-ascii?Q?OzCcE+kIVjPngAQDRzSHivDQoRzqR4Ktl2OboVRIOixRcXNVoZccUzmwCesx?=
 =?us-ascii?Q?xtDHQxRYvUmghdYq7aMfnjoXegjT+yg+APe2fVXcOkJpIB/GO80y8xfrkwJY?=
 =?us-ascii?Q?p6w2rJku2Y5Of3IOcUEQNhorsRaq/67mt9v+VfpkJ+DUXjeg4wL6syV6NKYv?=
 =?us-ascii?Q?SKrT+ByljSt3ZD6REsG18MB6tmGUGeWf1JXOGgXVaOUTbUY91lvUoZhIB05G?=
 =?us-ascii?Q?TngeNfoifEquGeuFMtXzkYL2kArVbxzJTP/VpOqvkXpQijxovrpHqNf+vuPg?=
 =?us-ascii?Q?E4/h10GBbGsvi98ZlzdXmDw8xL7+sPownjCsJsadPkj92uO2i4MEipFCenS6?=
 =?us-ascii?Q?tMqGk2JLYJHjaAzL3PxXOU+zi+Awa8qDwfAUVP3+wGmHS/J2xXXIPAvfsy4v?=
 =?us-ascii?Q?hVPZ8SNPLsr/WV03Adog61kjYm1bdLzg34jN5UDN+KgnsZ+/eDDwEby3K13F?=
 =?us-ascii?Q?bB/WqDsfcpP67IfcnHqW6qPi5Weapvx8CWzBmpAPnqgSuHKJFaJYzGyLjJ0K?=
 =?us-ascii?Q?DPMbq14yIRfFZG0M8YGrKyrtdeZzhZ3UbLkF7N4ZhNjH1VztVHL+75dV1TUA?=
 =?us-ascii?Q?OjVcCj1AbSuW5ZLOK4m6ngP94q399eDNxtldOl9IiJoGthA2LYowjnJUxOoF?=
 =?us-ascii?Q?0jO48ZJvUhlgxHIUXN5B52SchlS7k8IyGwwh74lr9VSth5u5MANs+Y3ZB8SC?=
 =?us-ascii?Q?bxIbrhR2c11dBE8EKZzGcLVDg7we1gGc+QSKtNxVPyhoRcsIgUxuRoARv/k6?=
 =?us-ascii?Q?iX3tf8Dsx04z78ob46ZVPmFAhZqdEDoAJ1qfYWgLHcHPEa7r7iCqLGjHlzVv?=
 =?us-ascii?Q?yCGHGP+eG5NYsBJDRg+wkj7+fbkmq05W8UNKxKaFD9qJiJvt6LUL0NI1wY8W?=
 =?us-ascii?Q?BoELIWB0OjXNA6ZNHMolQsZqoxwBkbU1gyDQT/DFMMIAau9DiDX6BMz4J14M?=
 =?us-ascii?Q?AZormnlLRzgAimOAr/CnbMi6/sLYEUNpIpqUrDqjK1y+XoemZy3UWpQPfe4K?=
 =?us-ascii?Q?6SOi8LkJJzLEK9iXI6GIt8mygW66FddySL/xQwMMfoWB4awTsVaMNJ7okk5S?=
 =?us-ascii?Q?II9UaeCO26FvmrI6fEUBnMGs5BVQjDFpeeNp+yelg8KUVyGC7OPT+dIqpepX?=
 =?us-ascii?Q?C8n0MvLNE6ps/uoSy13kxhYTfRlfyeTu6vi1JuEVQPV/46pHaNiVN0B2YSly?=
 =?us-ascii?Q?Sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b61816-9ecf-4375-ed17-08db7c995b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 14:17:11.1146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpcckr9yEbEkuDS7OTukRvJ5zRSVYNewufy20xGbnXDF+uJUTk7S501qPG1ZGANbyMgH4HrIgdMTdzfnB0sY7W7T/gdnfYshhsSo21d+8Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3733
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, June 26, 2023 8:23 PM
>=20
> Introduce static key isolation_type_en_snp for enlightened
> sev-snp guest check.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 11 +++++++++++
>  arch/x86/include/asm/mshyperv.h |  3 +++
>  arch/x86/kernel/cpu/mshyperv.c  |  9 +++++++--
>  drivers/hv/hv_common.c          |  6 ++++++
>  include/asm-generic/mshyperv.h  | 12 +++++++++---
>  5 files changed, 36 insertions(+), 5 deletions(-)
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

Vitaly had suggested some renaming of this and related variables and
functions, which you had agreed to do.  But I don't see that renaming
reflected in this patch or throughout the full patch set.

Michael

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
> index c7969e806c64..5398fb2f4d39 100644
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
> @@ -473,7 +477,8 @@ static void __init ms_hyperv_init_platform(void)
>=20
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	if ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_VBS) ||
> -	    (hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP))
> +	    ((hv_get_isolation_type() =3D=3D HV_ISOLATION_TYPE_SNP) &&
> +	    ms_hyperv.paravisor_present))
>  		hv_vtom_init();
>  	/*
>  	 * Setup the hook to get control post apic initialization.
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 542a1d53b303..4b4aa53c34c2 100644
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
> index 402a8c1c202d..6b5c41f90398 100644
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
> +			u32 reserved_a1 : 31;
> +		};
> +	};
>  	union {
>  		u32 isolation_config_b;
>  		struct {
>  			u32 cvm_type : 4;
> -			u32 reserved1 : 1;
> +			u32 reserved_b1 : 1;
>  			u32 shared_gpa_boundary_active : 1;
>  			u32 shared_gpa_boundary_bits : 6;
> -			u32 reserved2 : 20;
> +			u32 reserved_b2 : 20;
>  		};
>  	};
>  	u64 shared_gpa_boundary;
> --
> 2.25.1

