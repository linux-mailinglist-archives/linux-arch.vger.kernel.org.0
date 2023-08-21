Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1978316B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Aug 2023 21:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjHUTdf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Aug 2023 15:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjHUTde (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2023 15:33:34 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2419AF3;
        Mon, 21 Aug 2023 12:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOzpVMa4hE1benJv+3RieJqJjkPc1DvLQEMgwjg5V/cIknVZifnc5173rj+WMxoNPxfWFBvc11XYWXHR16pOWXJhYW1W7VJnigbNvGhsRP1tWNo8x5kVC7jPTsa9Q6qwCsY0vphj4qczzsCX6Xhtear7KrHepQIpWo07yX5ldWmzt104NcAYC6ZWlQJ3teZEWW+dVkH3i7EgRybzZSo2fTzXeaOUc3syz0lGY+BM0MOsQ/7qX+XGetPsVg/VfW+i7le4bopg1kLDUo9XHJQ40X3jHzyCMpih5uf8hsx5JKO22ksLEVSJ+3mcnHTtSv7ePwfCGgBykxG7GgySqZqE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UEPsdscM2g9jIYySCZ2e83pBNcxIAYsVqjVUqKmMdlM=;
 b=GE+JCHwOCp+Mdlz1LptOTrVIL89bjucm+iKeOvOOOfnbWhoQkDf0tPV05QjUACQ14ZWc+ZRbhcYuytXu1Nsh8SXnjcRk+Z1lWYpKIbTHiu6oTnOaAaEgetjsYyiMyziybzNLpD+c8lPh2inw7SS3v9n/iAbozfaPFy2nqLqa2+5yb6ffKbs9SCFXPvnVCvODsqtTg39Y3MPSMm1N/cBbbOA3eJ/LtfXrxvR7O+GhZaiz3nCBMhxk402xA7aTtAAm6WTn+zk/zCXJmDNlO0ig57n6I8/skVlfmZMacgWAbdBW/iPLZoRVIGEPlIL+GSqdGQ+b4AG/nB7YYp7ACt3Fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEPsdscM2g9jIYySCZ2e83pBNcxIAYsVqjVUqKmMdlM=;
 b=WLAQA6tk5507fPZkkeU4V3ShgeBWMkCj0cSGNZgPg/EIxg1bGgSL0kvs2/vFXL+2eYeXY6ddS7dYd0K16X91T49WFGt4LNhUYf2bLFlHXeBFo+YFN6CNdW5B7qchBFCX3dFz1hMCj3No6XmyJntPko4cSXO+yWq4iWcHO/mEitk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1864.namprd21.prod.outlook.com (2603:10b6:510:15::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Mon, 21 Aug
 2023 19:33:28 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4cec:9321:1b73:6d5f%4]) with mapi id 15.20.6745.001; Mon, 21 Aug 2023
 19:33:28 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
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
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH v2 8/9] x86/hyperv: Use TDX GHCI to access some MSRs in a
 TDX VM with the paravisor
Thread-Topic: [PATCH v2 8/9] x86/hyperv: Use TDX GHCI to access some MSRs in a
 TDX VM with the paravisor
Thread-Index: AQHZ06TZ7YXLEavaqkmDqsXoOiDf4q/04rIg
Date:   Mon, 21 Aug 2023 19:33:28 +0000
Message-ID: <BYAPR21MB168893DB3BC5D579281275E9D71EA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230820202715.29006-1-decui@microsoft.com>
 <20230820202715.29006-9-decui@microsoft.com>
In-Reply-To: <20230820202715.29006-9-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b9a46b56-4213-4bc0-9a19-b314d6479c17;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-21T15:34:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1864:EE_
x-ms-office365-filtering-correlation-id: da0fdefb-8984-4036-f177-08dba27d7f01
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gt1tVSGW+rKXrjrcJrJNg6IpvQpocLmCesEWgeeKm23GPzgGf0lprwZBEZTViCoSLYYGS1hRKbqTvvaqbXeGHJpAlyjKKF+eDidOrxu+iSr3J9Ur6Lztj3HZQB97JkQba36pymgSSYcTo0stoAtYGt0Gc5vehjGyEYdWRgGzQXVC/MHlDAfl4vraacNrL0ioeh2MGQ91gf8dGUbqLRtjHhbuT5gvUSRv6FWhbYT5bxBMMh+Nyqj2/Q6Uoh85ElTLO5QgWyGO6BWnX8firbNQCmwJEGSDtzHZ38XwGjmL+e2u6+njlyoalsLfISMVuMr0cNzA4pQuxr6fNplb3wOEmZ2RkTvdOllT0/hQBA5wCrXHuKG7OYLsS2kz1F4doDq7YeilEaoFshA4+81LpRSZUZUdHXYf7swea/6ODe79nNSbvioJHg28iMS+n2sEG/ZPUkRCPIX5gMyaoZHTT11S3A6Yf4wfZKJ3z8+eE9b9l+lo9x6+eQl1rWAd4FFqdiZaGx9sqVachtm6a8nFx7Dd7R+GwHJ5+cryzDHi90Iem/kBD7FyT8ZGcNNhCefx8HeOvLeHTlW87tNTch0U6JtMuJ0ujFS85jTcUOL+KF1+h6urs+sLutHVDBqhKpJy/jXdH1BiihkVMhPnCBEj2TzNYVbjQNbrW3j89yH0aHEbWh8Jc4O2BSgjoLaY4yE1sCUOOMap72KMfXMyVFdxjsEgoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(1800799009)(186009)(451199024)(2906002)(7406005)(7416002)(38100700002)(83380400001)(38070700005)(122000001)(921005)(8990500004)(55016003)(76116006)(66946007)(110136005)(66556008)(66476007)(64756008)(66446008)(316002)(54906003)(71200400001)(41300700001)(478600001)(33656002)(10290500003)(12101799020)(86362001)(6506007)(7696005)(9686003)(4326008)(82960400001)(5660300002)(26005)(82950400001)(8676002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gOKr7A0+69DfE+yt/WIL7GIfDBnQhhTxkb7BYBq34NnQhqZc9gM0RyWOI9b2?=
 =?us-ascii?Q?sL0muL3/J5pRxkfwPwJKvsFQGRiY3DhJsJSufRGFQt6D4OX6KYoJgk/6TxBc?=
 =?us-ascii?Q?YpfXdjLIkGxixcJL2l60PHhRlb02HU3GygKaUYCctcw6OSyigcyELFCg2Gkg?=
 =?us-ascii?Q?c8/iPPXG+qIwnTnKTlmvyrkVCP8sNX/dliBIObpBLDF/jreJfdqWBHn379IA?=
 =?us-ascii?Q?zm252QYH/4x6pLbAQb1KHZqzjk7jqu8rvWfcfgk0DrdEKgk9KXrcRQ9GstvC?=
 =?us-ascii?Q?CNxqE7F+sknDvGRayGzeXTizykUPIZ92jOSUPhfr1uow8gp26gnsIfbvAakz?=
 =?us-ascii?Q?cqk2UbQKV/NmsDUwgFBGy/GV3hpoYNwr8fbY9Nsru5dXzMc5MVcItW5fS69/?=
 =?us-ascii?Q?tIj+QM/z0bpi52sJXEgYfQ9UzUNfYKslV2JZd5sTeFMMJPnU5MRjdt13HfyP?=
 =?us-ascii?Q?IjTut3w+7UL0kwU+5LjC6UAgydt4xqwrG80IdHlH+hl/Tx64OC0UwBIEEkeD?=
 =?us-ascii?Q?SgKcAWSohHF4kxiwzk9STaAbboEYQNAH7U0WM2YLMouanWOXoR/EjZdp1FWQ?=
 =?us-ascii?Q?b6XQSl2+cXKe3fONvIt9ZQmvt06UJ45vFl4nUCxIpU8a3dvoHsOSLvj3RGE6?=
 =?us-ascii?Q?7z7ewKcnSB6eGpCFbYeevrTZ6XLP8RakvvNOnci+jDqWYpHCLh9P5Cj+d5KM?=
 =?us-ascii?Q?njXAHOQp4A9O5PmDUN7k47kUhFx951DW6mcBDk4rt7QoSL/fJ0H4lcYnc7D1?=
 =?us-ascii?Q?LYScjhPiMNUEjVoNK8HdaWVCDUNAJOfOjdTer21H06PDUGg50E3nbNSdp8xv?=
 =?us-ascii?Q?ec076ev/W4e1dFStqUmQkLylmo+wi3AUDGt7zvlvEQ358ZC8ThCjFq66cyq7?=
 =?us-ascii?Q?Os8BrkM2x8cNlWzb/JM4nF82/wnGM6KZ/Uu0R2MCGYas+gYUuTyLK/a40bwU?=
 =?us-ascii?Q?AoknWr1gNO7Ej9S1TNEL7Vxvql2ZGVbMqUqljRU7ob/RQrIBfk3CdSscz6po?=
 =?us-ascii?Q?xWAwTuaxSJSnx4pD4cs6sNuED/D0xmol9DFSVkB7BK5QFm3dWZLV2JPojIK0?=
 =?us-ascii?Q?H5vdrtWB8oLnBpoJCdRjkw4fJIrFcgLeTL81RSRkERdDLXUyjc7XTPoPgxfB?=
 =?us-ascii?Q?6EGbS7dEJbqjTbW1YQR66ogkJW8i6fWMrSa00l6qVdghtxF1Ra+gx8rjc1zy?=
 =?us-ascii?Q?OxNDDCXWWraXK5tSlAdKSl9HhhmpeRE+EuOeMUxanRUCYF2zBHN1zPWPKfmX?=
 =?us-ascii?Q?rzkVh5n/uMqu7AYUvgRdEpPEcxavfKig+w2v6gvK8v/yNACFTmHnfofNYPhJ?=
 =?us-ascii?Q?RACj0L1hEAU3byhhygc4YyicRZnOARoMO7h6mpnjNsctTjHD8gceimnkyR6i?=
 =?us-ascii?Q?XhJ6NOtTeJSzMMyxoV5oYxqUDKa4zr4QdSDU8Vgm4+BXeAH9k9Xe6/6qeITz?=
 =?us-ascii?Q?t5t1CJ+6Edo8tH1W1wK4HKFxFZZ5Jt3vKml1sgQWE5Bjh3lYUD2VGHOURJCa?=
 =?us-ascii?Q?jJKhWEiwHyLe8GwmlQMV5ow5RunPmtjQtOLswNqCy8jsSfTnaKAFVD9E3Ca6?=
 =?us-ascii?Q?ZZCZ+1PFfZo8wxBo+v430avsxO1ke8z3zUkEnpsxhS46/f37jkuZTzxwrc+5?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0fdefb-8984-4036-f177-08dba27d7f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2023 19:33:28.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bZsz/UKXFRrmy/Rk1PRv6Vaq/dxOYizVFnkZRXEArkx9uU2jkb3A7M017BD23dT/BVWokjRmbiFs34jZzBgaVgYqMKY2GV/cS0bsfpTTzmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1864
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, August 20, 2023 1:27 P=
M
>=20
> When the paravisor is present, a SNP VM must use GHCB to access some
> special MSRs, including HV_X64_MSR_GUEST_OS_ID and some SynIC MSRs.
>=20
> Similarly, when the paravisor is present, a TDX VM must use TDX GHCI
> to access the same MSRs.
>=20
> Implement hv_tdx_read_msr() and hv_tdx_write_msr(), and use the helper
> functions hv_ivm_msr_read() and hv_ivm_msr_write() to access the MSRs
> in a unified way for SNP/TDX VMs with the paravisor.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> Changes in v2: None
>=20
>  arch/x86/hyperv/hv_init.c       |  8 ++--
>  arch/x86/hyperv/ivm.c           | 72 +++++++++++++++++++++++++++++++--
>  arch/x86/include/asm/mshyperv.h |  8 ++--
>  arch/x86/kernel/cpu/mshyperv.c  |  8 ++--
>  4 files changed, 80 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 892e52afa37cd..18afbb10edc64 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -500,8 +500,8 @@ void __init hyperv_init(void)
>  	guest_id =3D hv_generate_guest_id(LINUX_VERSION_CODE);
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
> -	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
> -	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
> +	/* With the paravisor, the VM must also write the ID via GHCB/GHCI */
> +	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
>=20
>  	/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hyperca=
ll_pg
> */
>  	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
> @@ -590,7 +590,7 @@ void __init hyperv_init(void)
>=20
>  clean_guest_os_id:
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> -	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> +	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
>  	cpuhp_remove_state(cpuhp);
>  free_ghcb_page:
>  	free_percpu(hv_ghcb_pg);
> @@ -611,7 +611,7 @@ void hyperv_cleanup(void)
>=20
>  	/* Reset our OS id */
>  	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> -	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
> +	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
>=20
>  	/*
>  	 * Reset hypercall page reference before reset the page,
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 920ecb85802b8..93d54d8ef12e1 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -186,7 +186,49 @@ bool hv_ghcb_negotiate_protocol(void)
>  	return true;
>  }
>=20
> -void hv_ghcb_msr_write(u64 msr, u64 value)
> +#define EXIT_REASON_MSR_READ		31
> +#define EXIT_REASON_MSR_WRITE		32

These exit reasons are defined in arch/x86/include/uapi/asm/vmx.h.
Are they conceptually the same thing and should be reused?

> +
> +static void hv_tdx_read_msr(u64 msr, u64 *val)

Could you make the function name be
hv_tdx_msr_read() so it matches hv_ghcb_msr_read()
and hv_ivm_msr_read()?  :-)

> +{
> +	struct tdx_hypercall_args args =3D {
> +		.r10 =3D TDX_HYPERCALL_STANDARD,
> +		.r11 =3D EXIT_REASON_MSR_READ,
> +		.r12 =3D msr,
> +	};
> +
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	u64 ret =3D __tdx_hypercall_ret(&args);
> +#else
> +	u64 ret =3D HV_STATUS_INVALID_PARAMETER;
> +#endif
> +
> +	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
> +		*val =3D 0;
> +	else
> +		*val =3D args.r11;
> +}
> +
> +static void hv_tdx_write_msr(u64 msr, u64 val)

Same here on the function name.

> +{
> +	struct tdx_hypercall_args args =3D {
> +		.r10 =3D TDX_HYPERCALL_STANDARD,
> +		.r11 =3D EXIT_REASON_MSR_WRITE,
> +		.r12 =3D msr,
> +		.r13 =3D val,
> +	};
> +
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	u64 ret =3D __tdx_hypercall(&args);
> +#else
> +	u64 ret =3D HV_STATUS_INVALID_PARAMETER;
> +	(void)args;
> +#endif
> +
> +	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
> +}
> +
> +static void hv_ghcb_msr_write(u64 msr, u64 value)
>  {
>  	union hv_ghcb *hv_ghcb;
>  	void **ghcb_base;
> @@ -214,9 +256,20 @@ void hv_ghcb_msr_write(u64 msr, u64 value)
>=20
>  	local_irq_restore(flags);
>  }
> -EXPORT_SYMBOL_GPL(hv_ghcb_msr_write);
>=20
> -void hv_ghcb_msr_read(u64 msr, u64 *value)
> +void hv_ivm_msr_write(u64 msr, u64 value)
> +{
> +	if (!hyperv_paravisor_present)
> +		return;
> +
> +	if (hv_isolation_type_tdx())
> +		hv_tdx_write_msr(msr, value);
> +	else if (hv_isolation_type_snp())
> +		hv_ghcb_msr_write(msr, value);
> +}
> +EXPORT_SYMBOL_GPL(hv_ivm_msr_write);
> +
> +static void hv_ghcb_msr_read(u64 msr, u64 *value)
>  {
>  	union hv_ghcb *hv_ghcb;
>  	void **ghcb_base;
> @@ -246,7 +299,18 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
>  			| ((u64)lower_32_bits(hv_ghcb->ghcb.save.rdx) << 32);
>  	local_irq_restore(flags);
>  }
> -EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
> +
> +void hv_ivm_msr_read(u64 msr, u64 *value)
> +{
> +	if (!hyperv_paravisor_present)
> +		return;
> +
> +	if (hv_isolation_type_tdx())
> +		hv_tdx_read_msr(msr, value);
> +	else if (hv_isolation_type_snp())
> +		hv_ghcb_msr_read(msr, value);
> +}
> +EXPORT_SYMBOL_GPL(hv_ivm_msr_read);
>=20
>  /*
>   * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 2a4c7dcf64038..18f569c44c39d 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -280,15 +280,15 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool lev=
el, int
> vcpu, int vector,
>  int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *=
entry);
>=20
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
> -void hv_ghcb_msr_write(u64 msr, u64 value);
> -void hv_ghcb_msr_read(u64 msr, u64 *value);
> +void hv_ivm_msr_write(u64 msr, u64 value);
> +void hv_ivm_msr_read(u64 msr, u64 *value);

These declarations are under CONFIG_AMD_MEM_ENCRYPT, which
is problematic for TDX if the kernel is built with CONFIG_INTEL_TDX_GUEST
but not CONFIG_AMD_MEM_ENCRYPT.  Presumably we want to make
sure that combination builds and works correctly.

I think there's a bigger problem in that arch/x86/hyperv/ivm.c has
a big #ifdef CONFIG_AMD_MEM_ENCRYPT in it, and TDX with paravisor
wants to use the "vtom" functions that are under that #ifdef.

>  bool hv_ghcb_negotiate_protocol(void);
>  void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
>  void hv_vtom_init(void);
>  int hv_snp_boot_ap(int cpu, unsigned long start_ip);
>  #else
> -static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
> -static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> +static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
> +static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
>  static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
>  static inline void hv_ghcb_terminate(unsigned int set, unsigned int reas=
on) {}
>  static inline void hv_vtom_init(void) {}
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 3dff2ef43bc73..a196760afa7a1 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -72,8 +72,8 @@ u64 hv_get_non_nested_register(unsigned int reg)
>  {
>  	u64 value;
>=20
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
> -		hv_ghcb_msr_read(reg, &value);
> +	if (hv_is_synic_reg(reg) && hyperv_paravisor_present)
> +		hv_ivm_msr_read(reg, &value);
>  	else
>  		rdmsrl(reg, value);
>  	return value;
> @@ -82,8 +82,8 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
>=20
>  void hv_set_non_nested_register(unsigned int reg, u64 value)
>  {
> -	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
> -		hv_ghcb_msr_write(reg, value);
> +	if (hv_is_synic_reg(reg) && hyperv_paravisor_present) {
> +		hv_ivm_msr_write(reg, value);
>=20
>  		/* Write proxy bit via wrmsl instruction */
>  		if (hv_is_sint_reg(reg))
> --
> 2.25.1

