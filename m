Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683376DE0CB
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 18:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDKQRK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 12:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjDKQQz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 12:16:55 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D816583;
        Tue, 11 Apr 2023 09:15:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQyBSJ0IOoCjHyUQNmJ6ppxiFbTXPxJuv9zp4PclPdZrvG4PTmAghwlGifQnVffSIg3HScJscd6MWXqAGa1OZjTmuV56zztP7hNYfU76eXJ3/3Nx8ePNzHwcGso/DkJLQX2cc6I+BPcQDcsI7gTI7yFn5EC3yw09U2bPBfN/C5hgH35rqdoLcAEFC4dJW8km0s3VTbW9PIOsBdvsXQ8IK6qEXuuDnXMUDC1aR1D+AcKv4+r0p+pEIF+epHc93L0uChJJ+FkocWQZItrmuTpYmZJtHN1Xt7wzDwmhXq2fTfzcjXjuPOW5DkVatyrLu3biPZU1tI5/uY58qYnLz20Vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6jTvi4cBN9STOzvdb1EtOfWEJn1iawTSHED6TlWv9c=;
 b=E/yIDw4IUX0BQdq+Qy7FcEyfV9CfB2GS54b3NhGcBywg32j1G17qISJ8SNopepWUQ9l3ZdFo4SqcmDTHfHlGXViLlS5pY53sEl47z3ARoyCMR93mvws7TImb6mCUr9pZ4jr6Gf+30u3T1CUNQyPr/0Apgg05EIi2rNyjYNHjkLvZhyIpyVogf0ZVrgae005AHHizPICvWzO8F5uVkijSGUdMa4MdJSGOeKokeYyoeNdvM8zaNhKdgBCWx3N0WApn4yCEWd1+zPPNmDVnhulVeYurkGYUNIiLYqza9HMRw4x/h+97RFlQ9NFwO5l9cp5RmZQYk3/bZladhFayuLuY1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6jTvi4cBN9STOzvdb1EtOfWEJn1iawTSHED6TlWv9c=;
 b=CRg5OiLzTMSq2jBeX9VVy2rVFYiPHG/nxnTQ5G+zcTnMXcW//0ijmSRmA+D2lwjP5vh+YYG6OE1abowmzW8a/kwiJxANT7ZDb/FDwRdVomdZ44sXRq8rG4RSU6RlfC7KJAJjEMXX6vZ01VTh8lCKcqGWJDGqgsRb6X3Od8+HxxQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BY5PR21MB1474.namprd21.prod.outlook.com (2603:10b6:a03:21f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.3; Tue, 11 Apr
 2023 16:15:16 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6319.003; Tue, 11 Apr 2023
 16:15:16 +0000
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
Subject: RE: [PATCH v4 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Topic: [PATCH v4 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Thread-Index: AQHZalucCeL8OJ6U9EuS9cHI1Uigha8mTGcA
Date:   Tue, 11 Apr 2023 16:15:16 +0000
Message-ID: <BYAPR21MB168819E464EF7243D6215D10D79A9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230408204759.14902-1-decui@microsoft.com>
 <20230408204759.14902-2-decui@microsoft.com>
In-Reply-To: <20230408204759.14902-2-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=27285f65-d218-4c19-8147-87fb203e2454;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-11T16:13:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BY5PR21MB1474:EE_
x-ms-office365-filtering-correlation-id: ceac6b52-987c-4a8d-5687-08db3aa7f001
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MV2nDw7bRxahe1rjr1Pue2FfAg/KivhYe4ygozigpqx8FrnvYKwHGyY7rX1wrWfj4pczpKXmVgfVMzk+TiNG+1F0SfRJzigi8FHsFB5lfD1uCQlxItVkPnAj8pMKi0Hds5CwXx+38dVymtqUQNC6M6Ew6e2YqJ7hkoWZKzD4C0osGKqglK/KBIrjG82+/u7nLSBCA4iNYbn8R4OHBln5OfOewpDDtSMLwZPIyQn+juwSgmb3Yvgf3dAoIb+xRCXKW0hD8rsnazzcBpo7JmBW/iu5cpvZmeyD4kgCsoY7t1Jk2VhP7CBOJhRSdb/X2p0N6DLSO0xTaomWWGvlYQjBKUl+YsdkCkvc3juUtHFMhAD+ZSz6lGWpMWvKdzzLv86vPFxfY9iVNCB4atMBPi+QIT5KlhogOfh/GvB/GHjUtU/MyTWKyOmA3RDwJMdGgyJwjzzuGwdMi1U/S0YO/en9e6ZuTJfOKfQ96KiKgeTX8nIH0zEBuL6lw73iHBTZ6muJIT02p0Tu6rDIWI8uD9Hkm7zBSPAS9aX4nBoOXmPasbTwt9cn2IuV3RzVyTbviXY7hL8cZoLLxg+qCpxGSkMOYukYMA7pZY+XR2czRCAp0IXff1tCZq+EIqxLAfemJ8EDCWLVzavgOReiCFY+A49HFjwIjtPICNqbe9s8GKCeheot/ue5V0Gzs1Yq5Z4neoXQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(451199021)(9686003)(6506007)(26005)(107886003)(2906002)(7416002)(5660300002)(83380400001)(186003)(82960400001)(82950400001)(66476007)(52536014)(8936002)(7696005)(54906003)(38100700002)(71200400001)(478600001)(122000001)(921005)(10290500003)(41300700001)(55016003)(110136005)(38070700005)(316002)(86362001)(786003)(4326008)(33656002)(64756008)(66946007)(66446008)(8990500004)(76116006)(8676002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sUya2fxSyuXLEvnOM2R+sX+Y/ZFB5CCHY+KVzvVjrtJexMMT1FqiiZw0PboK?=
 =?us-ascii?Q?0VrWw25q2GPkZl7xTm4kwi1M1fdeTN4RnEDz6Dv/xKK+nV9Yi6FmYRSka3M7?=
 =?us-ascii?Q?ueupz0E/huTozx2U9IPlCeplbU2q8bU6WLkfeCiDab35L/YKncCHrCLB0E37?=
 =?us-ascii?Q?7Lob9h2FhM9nrBrIGx6oPZ/7+wBzLbIHNh6fkbk3g2pw0cHU9qsG/ADFOreS?=
 =?us-ascii?Q?TCBIDIXejdMdzsoLM30+2UEuFhkJIZiWB8zjyk2L2yQbvB4A9NVayKuMZd0W?=
 =?us-ascii?Q?TiGNAglmb9RUcPv+H61yoMWIodkmL6pcRejB63vCqTiu9vMGU+o/aYGBBAuN?=
 =?us-ascii?Q?uWTg/uWZkB14qz9p33LkmYwoiJeX4TvmATi23oZ08t3EiUehZ1p7Eq+8LmZm?=
 =?us-ascii?Q?ahVE7gud0oOw8wIYCqFizDIC1bqur7iCiV6w/79q1NgNU2UxPduxeRulSIpg?=
 =?us-ascii?Q?v/eLUE6rgXcbMNN7+S1eZLkvqOEsKyBnHgBEhH/+38DbLNEE5srdrjY0m8xP?=
 =?us-ascii?Q?M+h2xLc5H2gUymvtHu32JAXy8rsDTK6mgO4+VDGdAvuUcsFbavUOiI4R9NcJ?=
 =?us-ascii?Q?hco1++7cLf/eVpxEjol9uS7STl2yIrDtsD2mkuAsSvNA53i3toTXDgx9O/TG?=
 =?us-ascii?Q?ZxV295A4WkhTDG6cSJhXqdF4EAOdqVlMZXnU5YzjTs+iKnYr8t7O2EXbgzpq?=
 =?us-ascii?Q?kojKtFwjm+8shRppySrYsGI9OdCOd1M3MULnLRhS/OYVMXDv7fms+w/ki+DI?=
 =?us-ascii?Q?U8fT6m6dOaX6+tYo82CsmpyJUZp2a/HS7v/0bxaLfj9dmaEUHALeYrR6dH1/?=
 =?us-ascii?Q?KF0Wd43XRZuk+aHMof64zLV4sjnC45qYyGrJnOC7BSr7Z7/d7h/fXa6zwS5J?=
 =?us-ascii?Q?vBN3cSdcLJJW6sMtriwzL1B405LRxNd2ce++yu2suaBg31L1JZSl3ZqkBPzb?=
 =?us-ascii?Q?9ffldo3q0Dt8ngY3NbOW4yR3Et1kRqPfQ7kcFiLi3u44eqfr3rCGS+jBf4H0?=
 =?us-ascii?Q?EOhvq8BBlQSoxWivwWBD3K0J+TgxUKUBTcCRWPu+6he+s5/vtJ+2u2WrnjM5?=
 =?us-ascii?Q?yWb6iYZvGg2V34ZOWu4bujCfHw88j4d/xgc+F71MlkxRepF8Hv3JrQH4mCfB?=
 =?us-ascii?Q?TV6zJZmLCJU0IwT41lHtXNuX352NFTWAt2TCFN+zNhRAxfad27YuPvqs+SRJ?=
 =?us-ascii?Q?9osP2RxIE8WSetBmun3On7XnC/KsHT4n5DZuh2GbeUntSac0ZpfUSlE/iB+c?=
 =?us-ascii?Q?xeOEyHtb99PdmTtSDiLHjScTcvo8BZ0rp/Uoa4PWV/KDoQ9EKyqwZAj9YXJu?=
 =?us-ascii?Q?LyXD/Nzc+R4z6H4BPtLdBiQKP2/m1vr+R4bLquJowSrZ48ANLgx0lsCf8um2?=
 =?us-ascii?Q?9NAdZt2l9tIUZTJAZ0rnB7pBTJb611knDu33RExhlJU5i4GxvcITohCqWXlr?=
 =?us-ascii?Q?tkBSAVuaooHCZ+uIBxbNm6gmskkD/+KdYBX4vC+8fAgSE05KEh3btGDZXT+u?=
 =?us-ascii?Q?EF/pPlJh4scmK3Ku/3jWXrwUIV+pb1pqEcPF1+BQMW8jEyQMiqgpQvkM9veK?=
 =?us-ascii?Q?8vhsmceOHAxVbmjmaRnKHYbkpSUljLM/9C/rYfKaBXaVPSh9iOqQCypzoPZD?=
 =?us-ascii?Q?Og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceac6b52-987c-4a8d-5687-08db3aa7f001
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 16:15:16.3153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kYUlKwtwDJdEk8A4zmbiIqfv2kXLzwd1n1Hlv8MpPH+hosJrXg18Jj7KCGHOSr0o/4/yoradDvMk7SCTGQCsSdwXn6pNKnMVEdzQCDLfbNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1474
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
> GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
> error code =3D TDG.VP.VMCALL_RETRY (1), and the guest must retry this
> operation for the pages in the region starting at the GPA specified
> in R11.
>=20
> When a TDX guest runs on Hyper-V, Hyper-V returns the retry error
> when hyperv_init() -> swiotlb_update_mem_attributes() ->
> set_memory_decrypted() decrypts up to 1GB of swiotlb bounce buffers.
>=20
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  arch/x86/coco/tdx/tdx.c | 64 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 12 deletions(-)
>=20
> Changes in v2:
>   Used __tdx_hypercall() directly in tdx_map_gpa().
>   Added a max_retry_cnt of 1000.
>   Renamed a few variables, e.g., r11 -> map_fail_paddr.
>=20
> Changes in v3:
>   Changed max_retry_cnt from 1000 to 3.
>=20
> Changes in v4:
>   __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT) -> __tdx_hypercall_ret()
>   Added Kirill's Acked-by.
>=20
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 4c4c6db39eca3..5574c91541a2d 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -28,6 +28,8 @@
>  #define TDVMCALL_MAP_GPA		0x10001
>  #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
>=20
> +#define TDVMCALL_STATUS_RETRY		1
> +
>  /* MMIO direction */
>  #define EPT_READ	0
>  #define EPT_WRITE	1
> @@ -788,14 +790,15 @@ static bool try_accept_one(phys_addr_t *start, unsi=
gned long len,
>  }
>=20
>  /*
> - * Inform the VMM of the guest's intent for this physical page: shared w=
ith
> - * the VMM or private to the guest.  The VMM is expected to change its m=
apping
> - * of the page in response.
> + * Notify the VMM about page mapping conversion. More info about ABI
> + * can be found in TDX Guest-Host-Communication Interface (GHCI),
> + * section "TDG.VP.VMCALL<MapGPA>".
>   */
> -static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bo=
ol enc)
> +static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
>  {
> -	phys_addr_t start =3D __pa(vaddr);
> -	phys_addr_t end   =3D __pa(vaddr + numpages * PAGE_SIZE);
> +	int max_retry_cnt =3D 3, retry_cnt =3D 0;
> +	struct tdx_hypercall_args args;
> +	u64 map_fail_paddr, ret;
>=20
>  	if (!enc) {
>  		/* Set the shared (decrypted) bits: */
> @@ -803,12 +806,49 @@ static bool tdx_enc_status_changed(unsigned long va=
ddr, int numpages, bool enc)
>  		end   |=3D cc_mkdec(0);
>  	}
>=20
> -	/*
> -	 * Notify the VMM about page mapping conversion. More info about ABI
> -	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
> -	 * section "TDG.VP.VMCALL<MapGPA>"
> -	 */
> -	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
> +	while (1) {
> +		memset(&args, 0, sizeof(args));
> +		args.r10 =3D TDX_HYPERCALL_STANDARD;
> +		args.r11 =3D TDVMCALL_MAP_GPA;
> +		args.r12 =3D start;
> +		args.r13 =3D end - start;
> +
> +		ret =3D __tdx_hypercall_ret(&args);
> +		if (ret !=3D TDVMCALL_STATUS_RETRY)
> +			break;
> +		/*
> +		 * The guest must retry the operation for the pages in the
> +		 * region starting at the GPA specified in R11. Make sure R11
> +		 * contains a sane value.
> +		 */
> +		map_fail_paddr =3D args.r11;
> +		if (map_fail_paddr < start || map_fail_paddr >=3D end)
> +			return false;
> +
> +		if (map_fail_paddr =3D=3D start) {
> +			retry_cnt++;
> +			if (retry_cnt > max_retry_cnt)
> +				return false;
> +		} else {
> +			retry_cnt =3D 0;
> +			start =3D map_fail_paddr;
> +		}
> +	}
> +
> +	return !ret;
> +}
> +
> +/*
> + * Inform the VMM of the guest's intent for this physical page: shared w=
ith
> + * the VMM or private to the guest. The VMM is expected to change its ma=
pping
> + * of the page in response.
> + */
> +static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bo=
ol enc)
> +{
> +	phys_addr_t start =3D __pa(vaddr);
> +	phys_addr_t end   =3D __pa(vaddr + numpages * PAGE_SIZE);
> +
> +	if (!tdx_map_gpa(start, end, enc))
>  		return false;
>=20
>  	/* private->shared conversion  requires only MapGPA call */
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

