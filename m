Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF194078F9
	for <lists+linux-arch@lfdr.de>; Sat, 11 Sep 2021 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhIKPHg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Sep 2021 11:07:36 -0400
Received: from mail-oln040093003015.outbound.protection.outlook.com ([40.93.3.15]:32879
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229633AbhIKPHg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Sep 2021 11:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghIXUsvliM2IxEvBOnxMKkQqUE1JJN2wDeSlchCr52VuCcyJLWcFvMnIKCKpQE36Xlf20Uuq4AXtfKe66yJTobvCZeDyn1Moqfamfz/eVBGBrRzrOYR/014ouXUjL+PbP5X618gS3AYtBugaL/m67IJhOMA9wAgZbvJhzB5q2LyZvLVn8fJwpH7Ay/oKGQXaY7OokbRIy8r3BspdVI7B1ILIWCTJAfyM439atf3q/xhJs391pA5WihQIBqeznhwgQzCTHVUdbF0y8yrAi4eL5kYAUkASx0smyfThbukJxXSLh7/0DLDcDBfIX23AH01UW5prId64UhHznQKu2vMi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9owJEdi83Ly1dtZEhG2ZNYq33dRTQJnWsD7sy+xEpMA=;
 b=kPxE7zRox34ovAu2Bm6ufmSoj/nMI/LChgo9JmMCcMi3XUzO33x96TfCiyuX9sGZmD/ksDtDvWq384XGjIQO1h2S6dujNCXmQ1vXsOenYIxW2+FwMyxrl2w+vBgcR3FWxxySh5yc7F/p/FXgf0O/ZlvR6UgLXu+NyNHu6Nm3Yd/JyCIVOHx6O8rHOLkH9mdjNtAIT7Lj/BmXrYveBHw9AfU6XblqkbW5L7jkmQZnjpMblxEUE7M/1TJx+nGIlC2zPtym2mGHzv8iv6Q1ruOTydnXiba9mt1fDyyJmHTT8shswJ5nps1A2DBuSa1m03gDrcvKh4VVx/BBgaRX9m38Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9owJEdi83Ly1dtZEhG2ZNYq33dRTQJnWsD7sy+xEpMA=;
 b=adrVwvqV78p4sRM6plys+MKIqg/LLqcwImgRD9fLzQEH5lzrInMoxgcgoJ4+hxdrP8oI1CJLocnpJgWSg4H7IqCGH6VEuUzxofDLpIDxOsZjk3/GqbJJFOrc80qOUhCjj4DmEEEMufYrTheNIq15kpMODXfCEbOKKqnpu+JEaMc=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.7; Sat, 11 Sep
 2021 15:06:19 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::45ad:3f2b:a0a5:4202%6]) with mapi id 15.20.4523.008; Sat, 11 Sep 2021
 15:06:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] asm-generic/hyperv: provide
 cpumask_to_vpset_noself
Thread-Topic: [PATCH v2 1/2] asm-generic/hyperv: provide
 cpumask_to_vpset_noself
Thread-Index: AQHXpnWvazf7s0/gcEySN+8356FaQque795Q
Date:   Sat, 11 Sep 2021 15:06:18 +0000
Message-ID: <MWHPR21MB15933CFA486898817B7E396AD7D79@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210910185714.299411-1-wei.liu@kernel.org>
 <20210910185714.299411-2-wei.liu@kernel.org>
In-Reply-To: <20210910185714.299411-2-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8809fceb-4ef2-46fe-b619-2dc69115e71e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-11T15:05:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 215558f9-fcc5-463e-a7f3-08d97535b57a
x-ms-traffictypediagnostic: MW2PR2101MB1019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB10197B2DF2EE14209D251E44D7D79@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 348LrdknhDhERurbjnQ8qncn93iOoPupe+GJmCpJeug02igC0HbgbscdhSsxweNxdgM8+aAkhif6WLX9g8NrKQ+R7eJE5dVt7ZWbHAvXujhwKFwP3hw065CLEmUj5CCE/mSukp2ACNNG925nzBemFaZJpc5MtdQAObyXEEfMMhQBKgomlJqCCecVWAT8oeHucJ7yZ/lS9RA7RZIxXDyXksrBSZCUUvnYHmsEQ7we7IkgQYL/YAeneqKEfrur9Xkrjk0GLbxdgdgqx17/svJM0VTk+Irp/NpW01nS3/6nht/q5Kgc+W453q4e7faysr/XvNte8FsPNP2s3BZK/hleT811EiE+4wpjxi9EdqYV8lz+NZsHqDlRc0ZDFDLCY3VYRm4IOt8w3xB2HzU+krvjUEGSPtPm04Zb8HBj5La/3VHe3XeB8kDyrPoxh73kpDV87wjW+J6p8GumitUhRTZ2cwOGmx2JTwyy9OyJxmYmegda1LPsuh+kWbrnuvp1zU/P7/tGHbSI6bWLEDraflvfhwEXRz+10uNN+LrmBoh/0RVo3xX5Kk38vC0a07ovCyTYYKQ0fL2IqYL5Z21gtRQj2oIR07gaeexR3iBcEQ40H+Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(64756008)(66446008)(9686003)(7696005)(6506007)(66476007)(8676002)(54906003)(82950400001)(8936002)(38100700002)(4326008)(55016002)(71200400001)(26005)(10290500003)(186003)(110136005)(83380400001)(33656002)(82960400001)(122000001)(66946007)(508600001)(316002)(86362001)(38070700005)(66556008)(5660300002)(2906002)(8990500004)(52536014)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UoNX3w51DT3ZBhl1wU3Bzk2DrebiLNQg8YcfrYqqNDMVTL7kmXZ5IIMM7h6x?=
 =?us-ascii?Q?dRkIshKtTJiHE4eXzDQoPOirQxFEb0ZIL7IiFSNML+VsOLMLa4SSn+JmZ6bU?=
 =?us-ascii?Q?L3pg8Ny5o/X44+xdydXBP7kwZRNyOqTxisXKDCpYGrBs6e9Se8dBeSyAPbDx?=
 =?us-ascii?Q?c9g8aiY2/bIXpxB6cQt4Jt8tvOpqcm6pKkvSspXCHCGsfiiJHY6vHBVPrmJz?=
 =?us-ascii?Q?gJeaG47lS70XpwoTaEgoCHtIGExj/4/+POwA5csogKd/1Re52nTXa+Fz5Ln0?=
 =?us-ascii?Q?Zlk85Hj/z/9v3pRobbV26UQEzJCj46Ej9vuSU8Aroex7E10HggZHdZO2h3Tx?=
 =?us-ascii?Q?ABScIXiblCPqJrSOpOv31NyFhHExdEN/6Nsf9qFpEJW6djwLp39DiyRWQT/d?=
 =?us-ascii?Q?hgIpxNrn0+awE2dnkUwDKt/6XlAxIKHhv5iKc8EaorkHasbqKnjb/80mUT4F?=
 =?us-ascii?Q?6AcQ+I4acKw0oyt2VMQzVx8wQLSHFpg0vb+qMZ8+yBAVHI+eaxqHNr1U9juP?=
 =?us-ascii?Q?x5Mzat/wNSuf5F0w1uAOJchAiNMRcTLDPoPAsYU3ZZ7cBHFx6sJu9PvZ6iW1?=
 =?us-ascii?Q?+Yfkk9N2EmHj0PpxRhOJVJ/zn+wAA2giWiotTumWdsJsFJ1h+Bkqb1qZVaWV?=
 =?us-ascii?Q?WMTMJVCRcWoRi5i2Fw0Kf92p7c0hHszXpASpZHjkFwkJNRGLIM4eP3BlPWeZ?=
 =?us-ascii?Q?DGpBggQU/fK4SeR39UQLIueB5ug/NBoac4Rh6dOTskdBthPa26IfYjq4u4ad?=
 =?us-ascii?Q?EHDx1127j0iwjGabe8Hg1KRErYN64i+sqcNo3k9f9yiatuxR+roLJl9RM7oJ?=
 =?us-ascii?Q?VMXILCW2Ek1paGwVuEJkkVwg8q1kjQ3jM5aorjU2WeI4sxNZrWBeLhovk5+A?=
 =?us-ascii?Q?Z+r0UWN7nq16/WTYJgfkhKpHG/C4UbPwvq2/x5UqOZo6j/xGVRXzSJa/ZGh/?=
 =?us-ascii?Q?aa/83JgTuDU6EjOl5+JT0uB134sZyN5NfDXTiravY/GxYjwxXA/b2rsoeVjX?=
 =?us-ascii?Q?2fApWbZlkS6oOI52dJNbNn/a3ic2wZ1tOemNFryUzApZ9siKkfUI2w13g3fR?=
 =?us-ascii?Q?3LVqw3nNndtRZKfvZnKvdpNG8YL1H4nENeGdFv+8v8CUcyuiWvYpRloiY4Qi?=
 =?us-ascii?Q?pzUqFIc2DKmp7jEHpBPvW5FlA4Hk8xGGcbpB8aQVG0UDryrCCczBGg+Kk/nM?=
 =?us-ascii?Q?7ueTWSEVrv0Q0WYKGpCiDbuxs9B2QDvmYZogzzkTIiQTooySp2vOJbYUr3JN?=
 =?us-ascii?Q?5CvApruRiHKuY/8w0mVqJep3kkxoSbd88YsbxvXEek2K+t0OL4QA1wUhBI6f?=
 =?us-ascii?Q?00/QLrk+RnDWXTKpHKzfALN+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 215558f9-fcc5-463e-a7f3-08d97535b57a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2021 15:06:18.6387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLttx992YN1WiO6i5li4gufZIIuNG/zfIBp7V1xII3rn6Ct9fhZFtRZNZVxXM99e0GBd4J4wzN2rOZKXhQagKla3q9fQEyrn8a8w8PdlfgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Wei Liu <wei.liu@kernel.org> Sent: Friday, September 10, 2021 11:57 A=
M
>=20
> This is a new variant which removes `self' cpu from the vpset. It will
> be used in Hyper-V enlightened IPI code.
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> Provide a new variant instead of adding a new parameter because it makes
> it easier to backport -- we don't need to fix the users of
> cpumask_to_vpset.
>=20
> v2:
> 1. Rename function
> 2. Add preemptible check
> ---
>  include/asm-generic/mshyperv.h | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 9a000ba2bb75..9a134806f1d5 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -184,10 +184,12 @@ static inline int hv_cpu_number_to_vp_number(int cp=
u_number)
>  	return hv_vp_index[cpu_number];
>  }
>=20
> -static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> -				    const struct cpumask *cpus)
> +static inline int __cpumask_to_vpset(struct hv_vpset *vpset,
> +				    const struct cpumask *cpus,
> +				    bool exclude_self)
>  {
>  	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank =3D 1;
> +	int this_cpu =3D smp_processor_id();
>=20
>  	/* valid_bank_mask can represent up to 64 banks */
>  	if (hv_max_vp_index / 64 >=3D 64)
> @@ -205,6 +207,8 @@ static inline int cpumask_to_vpset(struct hv_vpset *v=
pset,
>  	 * Some banks may end up being empty but this is acceptable.
>  	 */
>  	for_each_cpu(cpu, cpus) {
> +		if (exclude_self && cpu =3D=3D this_cpu)
> +			continue;
>  		vcpu =3D hv_cpu_number_to_vp_number(cpu);
>  		if (vcpu =3D=3D VP_INVAL)
>  			return -1;
> @@ -219,6 +223,19 @@ static inline int cpumask_to_vpset(struct hv_vpset *=
vpset,
>  	return nr_bank;
>  }
>=20
> +static inline int cpumask_to_vpset(struct hv_vpset *vpset,
> +				    const struct cpumask *cpus)
> +{
> +	return __cpumask_to_vpset(vpset, cpus, false);
> +}
> +
> +static inline int cpumask_to_vpset_noself(struct hv_vpset *vpset,
> +				    const struct cpumask *cpus)
> +{
> +	WARN_ON_ONCE(preemptible());
> +	return __cpumask_to_vpset(vpset, cpus, true);
> +}
> +
>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>  bool hv_is_hyperv_initialized(void);
>  bool hv_is_hibernation_supported(void);
> --
> 2.30.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

