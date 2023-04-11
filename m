Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56416DE0F6
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjDKQ20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 12:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDKQ2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 12:28:25 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94713C26;
        Tue, 11 Apr 2023 09:28:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYNcOzRz85xQFeNuc+XGClVIPhTs1jUbChrb5e0eWbcjqDLBWdyvLszabqwfe85yZyYSk+7eEkrbrga29iKW3n1MqxTbCFdTsA21MEZL2DMIRtw9oRahszz9lhtL4m0zH+EYIFe3DOPcgncpq2yCgdWRF2Zcc+iGa/2+2h3atXO1imknl5ufE4KXb3Fa0OL32Wq/A1GKNwMiw6lVV6dohOLQXHF5lxfs69cZ46/MpTapgn8YlGHMQS63zZGeU24UB1SggR1s0pse5SRjljEqPdcjxj+CpIXt+7m5vlNU1Hq1/PTbpYGac3WpcuvyJRQ/6csEDj3U8t5U4qU4bhZ/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVfjABpqN/WG1MDWSf30NDEuDRa0TFP5G1yBjp35foc=;
 b=UyqT411tjSxGbjsBTICr2uQuj7PnXRmZmr6wY8shrqTmR/Fcm1vKZf5USgTC46+ndee5F64uM6Nee/WW3fsMIxgNRvI6K4k11F7xrda4sTlFW/m/aWrS+lEDgNu+VUjC/e/vhIWoi5f9tyKnMP7jjGl5ITdefepw84Ri+llypPTBwsU5NKlLU/2RWOneyn86c4OoQQkgubS3ycVvE3IPpIRmp6JcSPYyzfno8YvS7fT4GCkoK/quv4QLokg3mrjvyupKseBmCTJ2+JSefhQ6gMTjtFMJyQg6+AsAd+QuP88OFVzPPROTNPckDgUnKM+rq5Ft6lUPU8T86m9HWD9avA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVfjABpqN/WG1MDWSf30NDEuDRa0TFP5G1yBjp35foc=;
 b=gTDxiXSvkS+QsaKIwYdA5MTISNUx47uZ89HljnbvHcXBq/xOBC64Zy3/ej7302kuhQnXjOoZz3FGlF8r4X6Knba7shMzWifPu6FarCUgueYc7HnlaBFcW7Wg2IOu7cY2EslcdesnosVHIp6Z7aIP5YYgLVh1UIMyhwVahgOtyyA=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY1PR21MB3942.namprd21.prod.outlook.com (2603:10b6:a03:52e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 16:28:20 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 16:28:20 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Subject: RE: [PATCH v4 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v4 2/6] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZalue3UMXRGWETEqXBMcyUuN3aa8mTWdQ
Date:   Tue, 11 Apr 2023 16:28:20 +0000
Message-ID: <BYAPR21MB16885F59B6F5594F31AE957AD79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-3-decui@microsoft.com>
In-Reply-To: <20230408204759.14902-3-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=371d6cdb-ff3e-4998-bc60-5c76fb1af873;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T16:17:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY1PR21MB3942:EE_
x-ms-office365-filtering-correlation-id: 4b785f34-f395-4f2d-56ce-08db3aa9c321
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfFyEJ7i3B6BnnoAxTOoQ8sIL/JfRPD34Ej/AXiwK4SqFeXGHnJwr84/Lq/Qv94WNb6IanxPF+F1n/qgM3Dxw6LrYOFZkGOSzrURlSlw/YphsIMXHiXL7vKNFOWLp2NOhJBUWs9+QAEud8AOh3LZtfCGJ18CE0JV+V5htvMCz/JF0W+99bv6Gcug/U+2rmEgc2d8bClcCqoH+cabTa8sFxDdbqO0a3a8MyYT28B3VWnr3jO3GBlU+UUW0xfZiBbfLjrXTJfqMqiLpLKH1SD/kLx0x6SAYkfsfVJjzAWhUWXB4T9WMcpcomkI2roeuQdgzVSu0/ECt4TqC8084T3zB0jzSmh/9kdqWc5Mvi0hSB3i6EsbCOSPxI83oMMg64KrcCOjYPvBnnZtUphhTP9uMApgK3ttE0jKDixubwKEzKsvXG3BTsm1VcwgSu8qao+igOieAbM+HYJlb0xbRTSsceaWiUXx4N0nm9TLbkDF8X+H0BlqS397TUoViITffzR/mIjnA9ITUQZ31HXy9ajdYr8wuFhdCiP9H5uC5JGPfe5GEV5kr0q01GB2NRvmhaOWe8aSj6dbekVALWV1Cg9M97XwGnlmB9SWRvRVu41caz+WiCGUx4qXucw03ZUBwWUJJ3p/pk1rsxyXRRg++/d2eQRUwfiebr7QWfgAQoM0oifkJKMaenR2kE0ucBK3ge2h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(52536014)(8936002)(41300700001)(38100700002)(8676002)(64756008)(66946007)(66446008)(76116006)(4326008)(66556008)(66476007)(71200400001)(5660300002)(54906003)(33656002)(2906002)(478600001)(10290500003)(7696005)(7416002)(9686003)(55016003)(26005)(6506007)(110136005)(316002)(786003)(107886003)(186003)(86362001)(38070700005)(8990500004)(921005)(122000001)(82950400001)(82960400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMlhDGdizDdXrK3g6b3NOZAMQs27krlzsVNapawBJ6E+rVbITGKr5xjYoN+a?=
 =?us-ascii?Q?yG2t1x2q50IRffGfhVT/ACWbBgtMkuKA8t6NtqffP1MHKZzdMaF3zLWttbaj?=
 =?us-ascii?Q?sO0VihKwRtbFkG/E0acd1ExWrkED5+TMxeZanQX/qxDoYwe02oHfU68rqEB3?=
 =?us-ascii?Q?qs/YwQsdLSLvy9iwP45F5+ZyCSduKeYy3zgP8YpW7s7H9nK7sResq/QUEZnA?=
 =?us-ascii?Q?8XpZNdrod0mdevemspY1ZYJLAYoxRNtUt/sRSEMSrhM6xIdcITCUzzz9SpjV?=
 =?us-ascii?Q?GioahTgCaRHs1nWcRmviUEEWjKeSG/Y+RIWyZnr3p8HxJcLsDO2qHVOsJM1K?=
 =?us-ascii?Q?2tN/TRHbLBr5qC/BeJCe1c/E7V8kxCSFljmDEjr8DjVUYgt7w1SaEU+OD3Bj?=
 =?us-ascii?Q?vhYYDTd9qv9NUI8W79KAToelYvv0HHIyLEg96vfcb3cN23P7+dhlv4/PKbsy?=
 =?us-ascii?Q?MwjICtleIaTDe5eMGmdhEThDNJVRLrcoEVHArJ4egc4Mc066e+nxdzv8KVNk?=
 =?us-ascii?Q?8i3MAhBjXgTusTMiJ8AWKvxlsexEfG3gnb6NiIwKtsEROEPwy5pSWU4rAJzj?=
 =?us-ascii?Q?Z44Xo6LI1hchdxpFzKlwH9hfhvDSHHVSqHn5dxY7SWLYH+jKllE2T9ntqtJT?=
 =?us-ascii?Q?E02EPyeX+WMmjs4V365geB7PeNkNwOGEJHyi+Bgtz1ho+G2/BFVXyJ8ffs2a?=
 =?us-ascii?Q?pgTdjA3ckPwNn5casvED5/t4hArltUOb/bbJ9r4RCaV4vfNMn5U5HcQsm6Tw?=
 =?us-ascii?Q?lNVdcL+9r7KWsNqAjBcDs/yhQKamHVHGjtbExfrmDqOw39n3KlOYd8reE3py?=
 =?us-ascii?Q?X6WrkbsaHo8uZlDys0NXX2TopvW2QphXg6cSfjf7jFAYNvScBRyWOD9a/Hi7?=
 =?us-ascii?Q?NBvcIF+MsgV2aFfxvMOmLDLvNr4sdVuyfWo1jq/3dJuSm5lDzm5/p4zeNflH?=
 =?us-ascii?Q?PObH2py317iKu5IJr5FdwZxFMH9dgoeYYis/OlH9wgo6TEk31qtqIXscdzS3?=
 =?us-ascii?Q?qMad06ozwRTArIwKR6Cb3lqS2oRgkmX4MdumnKFJ2SI67Bu0wZrD8UgPxlMX?=
 =?us-ascii?Q?f3k2uNA3qFKFXz66xlsBRaUt+WHXUjhPOL/2a1o7PtsIucBmd8y5KamzEfep?=
 =?us-ascii?Q?mLWdrD/DTLJAmDlLWO2brAWqdbIkJEt4+pqLWixxDu/S2mAvvIvXKyluhv2X?=
 =?us-ascii?Q?hCCjHfkzYJIIry/7keIsoXog+QJbVBV66qHVa8lqDWlr01Zvp88k0wkc2S2A?=
 =?us-ascii?Q?2mVrt8QazvytfdeWfFxAn/bNEaMB8GPLn0BZc6UiQsdSMWK/KSGv5M0FLnQr?=
 =?us-ascii?Q?WSPdNrdAwkOA8UXmQ8T6LcPe/jYlrMMUQZ/dk50zpLEtaHabmwg6MKqntzGQ?=
 =?us-ascii?Q?TivWdjmMDcCv3+FfLdhrz6zWJL9LmrXxyq7HZwBuMiA1WN78ifj8XMgOHyG0?=
 =?us-ascii?Q?EGdXyV3HAV3sAcK9QiW/a3gNTjrj0IRoM0cUHJ8P9mKNcuY8T7yPC9byoR5Q?=
 =?us-ascii?Q?+3sxcYfMPMas5t3ycvjhBawIMN1snJ3+Zl6A9zXO+HF6hgnrQA8NVhLvbpJu?=
 =?us-ascii?Q?ybTGjBz537efC/ZTiZZqmYn6PFKGmtZbIfoGXKrmoCac49G16GEZsPDRmfRB?=
 =?us-ascii?Q?wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b785f34-f395-4f2d-56ce-08db3aa9c321
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 16:28:20.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zb8BVIoMguTK3KLzrNA9o+HgChEyoCgW4PmEf6WPpt+vFvrNmuARPQC0AQWk3yVz2fBuaOAde0ReGfuwn4i64pP4tqLo7qhhLop+opxqo6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB3942
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Saturday, April 8, 2023 1:48 P=
M
>=20
> When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf(=
)
> allocates buffers using vzalloc(), and needs to share the buffers with th=
e
> host OS by calling set_memory_decrypted(), which is not working for
> vmalloc() yet. Add the support by handling the pages one by one.
>=20
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 76 ++++++++++++++++++++++++++++-------------
>  1 file changed, 52 insertions(+), 24 deletions(-)
>=20
> Changes in v2:
>   Changed tdx_enc_status_changed() in place.
>=20
> Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
> how to get the underlying huge page info (if huge page is in use) and
> try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
> is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
> underlying page allocation info is internal to the mm code, and there
> is no mm API to for me get the info in tdx_enc_status_changed().
>=20
> Changes in v3:
>   No change since v2.
>=20
> Changes in v4:
>   Added Kirill's Co-developed-by since Kirill helped to improve the
>     code by adding tdx_enc_status_changed_phys().
>=20
>   Thanks Kirill for the clarification on load_unaligned_zeropad()!
>=20
>   The vzalloc() usage in drivers/net/hyperv/netvsc.c: netvsc_init_buf()
>     remains the same. It may not worth it to "allocate a vmalloc region,
>     allocate pages manually", because we have to consider the worst case
>     where the system is sufferiing from severe memory fragmentation and
>     we can only allocate multiple single pages. We may not want to
>     complicate the code in netvsc_init_buf(). We'll support NIC SR-IOV
>     for TDX VMs on Hyper-V, so the netvsc send/recv buffers won't be
>     used when the VF NIC is up.
>=20
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 5574c91541a2d..731be50b3d093 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpufeature.h>
>  #include <linux/export.h>
>  #include <linux/io.h>
> +#include <linux/mm.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -789,6 +790,34 @@ static bool try_accept_one(phys_addr_t *start, unsig=
ned long
> len,
>  	return true;
>  }
>=20
> +static bool try_accept_page(phys_addr_t start, phys_addr_t end)
> +{
> +	/*
> +	 * For shared->private conversion, accept the page using
> +	 * TDX_ACCEPT_PAGE TDX module call.
> +	 */
> +	while (start < end) {
> +		unsigned long len =3D end - start;
> +
> +		/*
> +		 * Try larger accepts first. It gives chance to VMM to keep
> +		 * 1G/2M SEPT entries where possible and speeds up process by
> +		 * cutting number of hypercalls (if successful).
> +		 */
> +
> +		if (try_accept_one(&start, len, PG_LEVEL_1G))
> +			continue;
> +
> +		if (try_accept_one(&start, len, PG_LEVEL_2M))
> +			continue;
> +
> +		if (!try_accept_one(&start, len, PG_LEVEL_4K))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * Notify the VMM about page mapping conversion. More info about ABI
>   * can be found in TDX Guest-Host-Communication Interface (GHCI),
> @@ -838,6 +867,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr=
_t
> end, bool enc)
>  	return !ret;
>  }
>=20
> +static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t e=
nd,
> +					bool enc)
> +{
> +	if (!tdx_map_gpa(start, end, enc))
> +		return false;
> +
> +	/* private->shared conversion requires only MapGPA call */
> +	if (!enc)
> +		return true;
> +
> +	return try_accept_page(start, end);
> +}
> +
>  /*
>   * Inform the VMM of the guest's intent for this physical page: shared w=
ith
>   * the VMM or private to the guest. The VMM is expected to change its ma=
pping
> @@ -845,37 +887,23 @@ static bool tdx_map_gpa(phys_addr_t start, phys_add=
r_t
> end, bool enc)
>   */
>  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bo=
ol enc)
>  {
> -	phys_addr_t start =3D __pa(vaddr);
> -	phys_addr_t end   =3D __pa(vaddr + numpages * PAGE_SIZE);
> +	unsigned long start =3D vaddr;
> +	unsigned long end =3D start + numpages * PAGE_SIZE;
>=20
> -	if (!tdx_map_gpa(start, end, enc))
> +	if (offset_in_page(start) !=3D 0)
>  		return false;
>=20
> -	/* private->shared conversion  requires only MapGPA call */
> -	if (!enc)
> -		return true;
> +	if (!is_vmalloc_addr((void *)start))
> +		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);
>=20
> -	/*
> -	 * For shared->private conversion, accept the page using
> -	 * TDX_ACCEPT_PAGE TDX module call.
> -	 */
>  	while (start < end) {
> -		unsigned long len =3D end - start;
> +		phys_addr_t start_pa =3D slow_virt_to_phys((void *)start);

I've usually seen "page_to_phys(vmalloc_to_page(start))" for getting
the physical address corresponding to a vmalloc() address.  For example,
see virt_to_hvpfn(), kvm_kaddr_to_phys(), nx842_get_pa(),
rproc_va_to_pa(), etc.

Does anyone know if there is a reason to use one vs. the other?
slow_virt_to_phys() is x86-only, but that's not a problem here.

Otherwise,
Reviewed-by: Michael Kelley <mikelley@microsoft.com>

> +		phys_addr_t end_pa =3D start_pa + PAGE_SIZE;
>=20
> -		/*
> -		 * Try larger accepts first. It gives chance to VMM to keep
> -		 * 1G/2M SEPT entries where possible and speeds up process by
> -		 * cutting number of hypercalls (if successful).
> -		 */
> -
> -		if (try_accept_one(&start, len, PG_LEVEL_1G))
> -			continue;
> -
> -		if (try_accept_one(&start, len, PG_LEVEL_2M))
> -			continue;
> -
> -		if (!try_accept_one(&start, len, PG_LEVEL_4K))
> +		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
>  			return false;
> +
> +		start +=3D PAGE_SIZE;
>  	}
>=20
>  	return true;
> --
> 2.25.1

