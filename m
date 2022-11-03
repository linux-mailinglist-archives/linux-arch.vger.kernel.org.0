Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461CC617509
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 04:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiKCDac (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 23:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiKCDa0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 23:30:26 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020018.outbound.protection.outlook.com [52.101.51.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB97815734;
        Wed,  2 Nov 2022 20:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCNYn3jPIjDZmu1jiDlZInQTx5ElC3ojtt+ZNMMYe4gvAJ8zG92DM8J/CABpZc1CZcI0EUkVwfw8mVkAlz/WWCycGoiJCoRMSSC9Po9oxWn3l3K1hK8yaWqdN5uX0+MPp9zByFcOmp0vn3BDXOdcURgbhD+XCQI3Uq0SD0uWc4bznBXqivtDzojGY7ep3MWZnNUuucBdsPlHP/17+O+ARIDexc2PvIVPdCQxCHIWD2P2TgZfplNp3QTggQZXRU9kQjERne94vf9GIJWZwkIM2nZ7V+KSHjaGyjbfhiiH3D5PpVwEOoGgf7Fq8oQIiVaHz2kDJb2i9DOsLZdLRN9qvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvQ4T5D4TYitxXV5Rrfgv1GNNZscuc8rQ+M0I4EfGJ4=;
 b=aCMoA60u4DlDLOm+i6iQ1Jo7n/fAbB22KViEQwEAGsjSPWqPkTdExFwchTkDbQTM2YqVoX0r47s7ie0L7XrJZJIJ3+b8ViphCpC67Q1knLjrapYFlmrX0DFLOO6okDDkzP1CCdWB8AC49EwkQdy8ZNEMBpVDEZaNm26vwfSZluqeo95C7c+4ORK79HY8dtWFLGlNs3MtxXVzAt1KuMKxAiaQfpiOFXUljefecY9XJJ8GjX/p/hprBtzMFc4zkMY17JP7qRghMS5ZDG6qzMz2/uap4EyV93DFHw9mExoac3UxoF+9+d7YdLC8mrL0bojwqEPdxqoVzaUPsjOzXB+B4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvQ4T5D4TYitxXV5Rrfgv1GNNZscuc8rQ+M0I4EfGJ4=;
 b=d8ObBgq5CL6OGqwiSijYCjrfQSR0rEkVpnaOiLy915g8amDXKw78DDtDULVOD7TFKirw6s8fzZ3noNqj3UDLlphc/nSJj1Qvbbt8eUy+1xV5AUVAdySOFQDtizrzH38oBT5zVt/s6PwBEO+dM47X0mCaPUXjsb5C/7sMRMvxT5w=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CY5PR21MB3660.namprd21.prod.outlook.com (2603:10b6:930:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.4; Thu, 3 Nov
 2022 03:29:57 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Thu, 3 Nov 2022
 03:29:57 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "seanjc@google.com" <seanjc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] hv: Setup synic registers in case of nested root
 partition
Thread-Topic: [PATCH v2 2/5] hv: Setup synic registers in case of nested root
 partition
Thread-Index: AQHY7tn7J9M/9jHFF0yIxIZJ9oaEIK4sf8zg
Date:   Thu, 3 Nov 2022 03:29:57 +0000
Message-ID: <BYAPR21MB1688125FE61A935FBC4B8286D7389@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
 <e4553fd2ed37c53028f466fb759b503cde32b810.1667406350.git.jinankjain@linux.microsoft.com>
In-Reply-To: <e4553fd2ed37c53028f466fb759b503cde32b810.1667406350.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=85955e60-4c7f-40e7-80ba-0f883ab878c7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-03T02:48:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CY5PR21MB3660:EE_
x-ms-office365-filtering-correlation-id: a0b1b219-9ae7-4f1e-1b37-08dabd4bae9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Je3+QNHXy4p3J75jZyfkMaub4mrHjuN0EvFsOSW7ElRvjoEh7wCDitsR1KLQYzhaxnZ93ERFvmIriy3YsKaA8uRX5CNmNQnJUSBG4oVUt50C7VXt7bCbMppCE1xD4frsLifMcg11zsWAGuVrXfrmG3y9oFkS5cAQ2C5B3OVToj/iofEngadB/m27H5T3GEDJ6Ud9C8JhGVeud47rA7m1gHiIMTjyCdDOg0YJCvc6jCfET26yggjajNT8mLcKUnzGHpAk/vA+lAeNhI/iCLwNUwC0RIb8zHay+RG5uPCw1P26XRj+BPu59w/465ccLtSHrIqEvTvizl6/dHkpLaqYZeSu9wCSMWJ0LRigodPANiLs6oadtCZXAKDegnZhU/7fQsmVJ3LGTToq8OcJgpgl7VPLG6fYOhr1Xxzd7MFwmy02CPKUSL5tLuplUd7rzz1mNisMUwYv5mYTi9t0k/7WqK2X9SHf3ysdmhpw0MT1KGFv6eqSLg2JDs5ZJDuIc+kbSIRbm70pa0Y+xerJYUtj5o3VSbU55LW6Ew3HG2m9qJ4OE14bcQjaIb1SvOoWlkl+NN06botlbDGuIqdme27/F49Ve7Rtfvgw7xA3WqL79Ha/AQDoDR3EWQXjXiiDcvU9XpVpXK2Eq19QkXHrFb+5KZyexn0GhKcOYW1GkyQsdrq/I1wlxUkw/tBe276fzjf4H5ONvHtiJyJ/69eq2Bv+7GOF6iJRxR3rYejD1LaxIjF1M2Af6RgmphrUzMhoHAL2eyo67qDnXNQkUMEU1qofJtgfsIYT1HzEpbrI496lRf3kYQskl6eI/S0/0CnV6dxe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199015)(8936002)(52536014)(41300700001)(54906003)(110136005)(66556008)(66446008)(6636002)(64756008)(316002)(66476007)(5660300002)(76116006)(66946007)(4326008)(7416002)(10290500003)(8676002)(2906002)(38070700005)(8990500004)(478600001)(71200400001)(6506007)(122000001)(9686003)(7696005)(26005)(38100700002)(83380400001)(82960400001)(33656002)(86362001)(82950400001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rriiixc6nOZWLR8wqE29c8oVlnvgZ1rQiagDmG4HAqrTJQ77l5c+j6tvk7UH?=
 =?us-ascii?Q?h8avoEB99Oi5JiEx0RAcTZDkL202pl0C8IIqgk+HxUR7vH3aXUDnfdzXIIxa?=
 =?us-ascii?Q?2YGBH/bGEUObHUXLxosRye87OW3J8Tb0Aq6uM5AtZ6/9bfu7aPTCdew1GPlv?=
 =?us-ascii?Q?WQm2zNuM0j4aYaV/b0W0RMvvqG9oIvAY5V3WR4ez+HYw3kd/l0MFjZeVKniG?=
 =?us-ascii?Q?tfi1h2r1Luasgv5ih9dgxl36l0x+i/5dN5IKtpln7q14JDbvKIWb7G6HkY5B?=
 =?us-ascii?Q?6HHHhe2maAaUairG4YLh8L8gacAzTyDQmVpv+3etK5pU/WxZw1uCHRtrhfxl?=
 =?us-ascii?Q?XFgGn9pNXyF0ngu9Nbzk+O6fV4NN8+WiItqn8axSWTw+u3tSw7EDvYpTALqJ?=
 =?us-ascii?Q?xVZROawt6zhDq/5pvXOTKt8IcAt84NqWMDNTZLEF7E3btdlZWPoHfaEZxbC5?=
 =?us-ascii?Q?9TItrqXEWju225lZormwzPgKex4PsyjLSQD9hSrXZgx+VxA5ipSnFZjOJko9?=
 =?us-ascii?Q?dKu5i2R3wBVHdUS0CiFCJ1sKqoKNxGABpI9jH0o3Uski431ZQPOHi39pUr6d?=
 =?us-ascii?Q?mBr+obTI6ZLLQ/lfX+wgBVowcAz/Gy6l8lFseHpfZ8kTI4vumF84Bs1T/yAU?=
 =?us-ascii?Q?dndcQT/fi0INwRfDkg1kaYv1drfemY2I0e4ek1qMfVtt7zdv5YY5PtqDfW+0?=
 =?us-ascii?Q?6Z/4yj/zPotADDqTvbEZ1bh4R4l1ZcLcvUNdfSpshu3bbA/ziB9EG9FFtT2p?=
 =?us-ascii?Q?kBbmmCDgff2fvDVcvHfLZKmqFycWYpoh+Dl9nalH050HXU/CfbWLJBDnfToM?=
 =?us-ascii?Q?0PJO4+nOZkZ32lRoEa3F7ga7rjuP0yNdOnXYBbJQXUBCQ3E2tCvbDjwrXY30?=
 =?us-ascii?Q?PYXUh0mSLgGZNztVUSk9qyqbPyvCv1e6PP8gJSGABOkqONzeEBRTS8izW2nW?=
 =?us-ascii?Q?oD98cYQEMiNjeMuF3gUpgVLDP6KAMNgAaXu5QNoTu+9SDubSzkSjoc6VBcsa?=
 =?us-ascii?Q?0SY5XZv3QdMRiYTAld+iON6xbsfdlo4N/dfQp8KK0HIP3Wd/DbTa0OAadGCp?=
 =?us-ascii?Q?HyTGjwgeWqDtPUXNIHG+YG8yHQxNSOY/O8QlYL05OCRzUVhvuSeEFud4LU1/?=
 =?us-ascii?Q?uRMBV9vdvjL9CcURupXFpdOx3HUSVvRIs4/MihOCXliXnBsgSoIMeuV9SZC2?=
 =?us-ascii?Q?0e3ySGlmo0K6zUrhl1bVD80s2mVOuF9tIPxufGmltmxHb9W4fCXAcskxZV0g?=
 =?us-ascii?Q?UcbxMuVNYwQUD0h3LqJP3ry6snXBFjNh5yT4TUTl42D9d2Pfz3Km+LzcIqEa?=
 =?us-ascii?Q?s9RARaNo7yZEYBn1m6epyEenKWGfk66mq/Wg15/LhklfBACh5ck2T2GYTsfm?=
 =?us-ascii?Q?Ie+GTSkyC7n/ML6LtCsBIh3GPHiqt/4wIg4ZvyQ3i+zl7HmfOZMn/h9d9UzX?=
 =?us-ascii?Q?WRlJahUR6dJul4BIY4LdiS5p2u/sIFwkVuIAfWbMBtdJ2czPmF/E0Kg3LPrb?=
 =?us-ascii?Q?mPsKspUx8xoOwTtbOgy7F+AzLpZtfCgPx7f82asGvckVKI0+5ZxzjCPJBRY8?=
 =?us-ascii?Q?TLczzuehoCeV/ybS7/22afDvDpaz4fjsltmiNktHdM6LUFsXAXk1pJxPjOV+?=
 =?us-ascii?Q?FQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b1b219-9ae7-4f1e-1b37-08dabd4bae9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 03:29:57.5606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dLj5rqVd+c/89zbhEEypEy9/TwSbywYJimc+I6jUkWVR7cqvRyN3gLefs+xbf3wECPJUdLmcsSCHvCZUMyfT/MWNIhQkPrfyIBYP9OESXlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3660
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, Novembe=
r 2, 2022 9:36 AM
>=20

The email subject prefix for a patch like this is usually "Drivers: hv:"
Check the commit log for the drivers/hv path, and you'll see what is
usually done.

> Child partitions are free to allocate SynIC message and event page but in
> case of root partition it must use the pages allocated by Microsoft
> Hypervisor (MSHV). Base address for these pages can be found using
> synthetic MSRs exposed by MSHV. There is a slight difference in those MSR=
s
> for nested vs non-nested root partition.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 11 +++++++++++
>  arch/x86/include/asm/mshyperv.h    | 24 ++++++++++++++++++++++++
>  drivers/hv/hv.c                    | 18 +++++++++++++-----
>  3 files changed, 48 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index d9a611565859..0319091e2019 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -225,6 +225,17 @@ enum hv_isolation_type {
>  #define HV_REGISTER_SINT14			0x4000009E
>  #define HV_REGISTER_SINT15			0x4000009F
>=20
> +/*
> + * Define synthetic interrupt controller model specific registers for
> + * nested hypervisor.
> + */
> +#define HV_REGISTER_NESTED_SCONTROL            0x40001080
> +#define HV_REGISTER_NESTED_SVERSION            0x40001081
> +#define HV_REGISTER_NESTED_SIEFP               0x40001082
> +#define HV_REGISTER_NESTED_SIMP                0x40001083
> +#define HV_REGISTER_NESTED_EOM                 0x40001084
> +#define HV_REGISTER_NESTED_SINT0               0x40001090
> +
>  /*
>   * Synthetic Timer MSRs. Four timers per vcpu.
>   */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 29388567eafd..415289757428 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -200,10 +200,31 @@ static inline bool hv_is_synic_reg(unsigned int reg=
)
>  	return false;
>  }
>=20
> +static inline unsigned int hv_get_nested_reg(unsigned int reg)
> +{
> +	switch (reg) {
> +	case HV_REGISTER_SIMP:
> +		return HV_REGISTER_NESTED_SIMP;
> +	case HV_REGISTER_NESTED_SIEFP:
> +		return HV_REGISTER_SIEFP;
> +	case HV_REGISTER_SCONTROL:
> +		return HV_REGISTER_NESTED_SCONTROL;
> +	case HV_REGISTER_SINT0:
> +		return HV_REGISTER_NESTED_SINT0;
> +	case HV_REGISTER_EOM:
> +		return HV_REGISTER_NESTED_EOM;
> +	default:
> +		return reg;
> +	}
> +}
> +
>  static inline u64 hv_get_register(unsigned int reg)
>  {
>  	u64 value;
>=20
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
>  	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
>  		hv_ghcb_msr_read(reg, &value);
>  	else
> @@ -213,6 +234,9 @@ static inline u64 hv_get_register(unsigned int reg)
>=20
>  static inline void hv_set_register(unsigned int reg, u64 value)
>  {
> +	if (hv_nested)
> +		reg =3D hv_get_nested_reg(reg);
> +
>  	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
>  		hv_ghcb_msr_write(reg, value);
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 4d6480d57546..9e1eb50cc76f 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -147,7 +147,7 @@ int hv_synic_alloc(void)
>  		 * Synic message and event pages are allocated by paravisor.
>  		 * Skip these pages allocation here.
>  		 */
> -		if (!hv_isolation_type_snp()) {
> +		if (!hv_isolation_type_snp() && !hv_root_partition) {

Perhaps update the comment above to also cover the root partition
case?

>  			hv_cpu->synic_message_page =3D
>  				(void *)get_zeroed_page(GFP_ATOMIC);
>  			if (hv_cpu->synic_message_page =3D=3D NULL) {
> @@ -188,8 +188,16 @@ void hv_synic_free(void)
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
>=20
> -		free_page((unsigned long)hv_cpu->synic_event_page);
> -		free_page((unsigned long)hv_cpu->synic_message_page);
> +		if (hv_root_partition) {
> +			if (hv_cpu->synic_event_page !=3D NULL)
> +				memunmap(hv_cpu->synic_event_page);
> +
> +			if (hv_cpu->synic_message_page !=3D NULL)
> +				memunmap(hv_cpu->synic_message_page);
> +		} else {
> +			free_page((unsigned long)hv_cpu->synic_event_page);
> +			free_page((unsigned long)hv_cpu->synic_message_page);
> +		}
>  		free_page((unsigned long)hv_cpu->post_msg_page);
>  	}
>=20
> @@ -216,7 +224,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	simp.as_uint64 =3D hv_get_register(HV_REGISTER_SIMP);
>  	simp.simp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_message_page
>  			=3D memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  				   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> @@ -233,7 +241,7 @@ void hv_synic_enable_regs(unsigned int cpu)
>  	siefp.as_uint64 =3D hv_get_register(HV_REGISTER_SIEFP);
>  	siefp.siefp_enabled =3D 1;
>=20
> -	if (hv_isolation_type_snp()) {
> +	if (hv_isolation_type_snp() || hv_root_partition) {
>  		hv_cpu->synic_event_page =3D
>  			memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
>  				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
> --
> 2.25.1

