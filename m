Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F11639EC1
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 02:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiK1BUx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 20:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1BUv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 20:20:51 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020017.outbound.protection.outlook.com [52.101.46.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CB6DC;
        Sun, 27 Nov 2022 17:20:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QagL/YWetd7FtuAWiDz76FOv1AhTGpSt1deMQHjI5yiGxg2vq7gGZtSgL7wx99waQWLneWgImSg9onGYtGpMQr2WTc26zxSKDgJACu1EUuLbjZaLxlf2+YUfd2Yb5xruXzE7BbTpLl8ItBakGBgXbnjdR9mjntfJMVLgcnMM6ILRbs0i1i+aJ/katVOJ7n2yDXiLrpgMGibl2EoWLyU+klqMt/+UtBEBfWCAb5NigLoh3G+eZK9MXQhGhID0aT2LCQKa2UNKzt4FNMVNv984olOa1K04A+kNJaRAS54vLGORC07lEcVCPVfCbklBpWi+MH7Ma+RTVMHDNjPBxajwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jucHj2laIbmVK59Ph45cF4Fn3DVeEyED3Bct0MO31A=;
 b=gfsOmKhnYLvluRtqNNp9XcXlgYSkecUoNhuhbdfdRxonXKQ7b8wUlRpuXKir0HQOgfsF8rs0l5bqM1tebG7Znyh1EbCTR9r9rgw/lBkUWKpGji6usD7I5adJ15eHaiJqclB93kKZx40XAuegtpVpEshkeDAIXF2w8byLMZSJ0J313+1brLlpsjRDXGg5Ad7VPnwJauIu9SLIwuPi0MkhmhBjVl9NZXbqf7PR0sTohut+vxVLav2Z13mICajPOk7vqw/GXVl3mjWRhqw0dXZKaB+olxv22wTKqZtjCcyMEhCmKyXxwKPlKl78GzpGEcchL6r9BlWH2bkfBzBcaUZr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jucHj2laIbmVK59Ph45cF4Fn3DVeEyED3Bct0MO31A=;
 b=MeilY9QrWex/eq8JPUhmCWkoKD2SI13AausinzV5hD6TvMBC9r+2mi76q1re057qiWpxWlUw5W6TMmkF3UzCP0ZihdZPdnjiZ4/PhWgfmywqaI9Sio6S0zcGNiM2YWRuUBnsriCkUACSAsh5KOgFqZ1MKuTJKbNunXL40SKPFDk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1326.namprd21.prod.outlook.com (2603:10b6:510:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 01:20:43 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 01:20:42 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
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
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Topic: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Thread-Index: AQHY/eL68sa7B8PD5UqEC8+ROEIS6K5MlaWggAb3pYCAAAPKQA==
Date:   Mon, 28 Nov 2022 01:20:42 +0000
Message-ID: <BYAPR21MB1688A412FCBEBB3189107102D7139@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a799fdd5-3e93-46b4-b0f9-8dd673651b98;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T14:34:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1326:EE_
x-ms-office365-filtering-correlation-id: c6676da1-d749-4efb-0e67-08dad0dec49d
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjKpJ5pyTUgbbkiHVj0dCo3UpOVdFfHFZ4J5Fs5nXmK45K+PG6opROCEYJGiiorz7xQZqDgx6Nk6iiPjkToRn847+YnVxiN5eioUD+aQbVGqWaGyt1YYrIR1C3HJXBSnt5rZ3xhCRrlXha1tZlBHTWMci5B3FeR9dztt1fx3GNTRzkpc/IDTvBWfX/G1WRjTZhefvNykgDwbY9KyfSgb7he1pj7TFtcWYriwCFLeOoHMVwBNtO9KAIlgTZXegvwiRRUPfDRjBmaZW6ahSchOFTrKTx04wb+8JpGoW7PXQOEZoUpuV9pcyfmpH6Tdt6ikN92oHjIV05keGP/NzE+MUgYtrDBJ57lG+sr3DTrjEePS351TO3cFWWR9OQvZAp7t477lQCoSwj8+sqqyBumgAbHvkm9z7sfQXAORiwTi1Nb6uFwJiZhq3YiCd3H0cExoRSz5zqwEULOyHOi2fM/IKUqnH5p6pizVlh7hjW+vEs2H+d3UsD87LIw3QEoFwfI9QDAh3RJt7kMTsWB7tR8IiMvmk5AJnaRNVDS4VKNkd6HAGZBXjt2nRDRvq1Dv7YPGSRWG3BFcOOMPErYH0HIimFf1h8t/2OsHWgW70fhBlnn/91yHH7b5TfE/stH/0lQqUM4Ae6zWGtq+gqrCHJ+qDRpGDb1JY2uWdR6x7aw1sOW992m7diJX0EBmLHptIjye0Cl0o6/ztDqhPFdmzwBa2SgpffV7GJCZKWdbVgTEu9WS7yczk99OaSTfUHdMVLvXDPeDiLzuCAUTTxgjYTVk0B5BMbLOA/w9DXCe5wk5OcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199015)(86362001)(33656002)(55016003)(186003)(316002)(41300700001)(66446008)(76116006)(66556008)(66946007)(66476007)(64756008)(4326008)(8676002)(71200400001)(26005)(110136005)(7696005)(5660300002)(9686003)(53546011)(6506007)(478600001)(10290500003)(38070700005)(966005)(52536014)(921005)(82950400001)(82960400001)(7416002)(8936002)(122000001)(8990500004)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSkZImO8k2d0Oz02RMBW3gSaqnocUBap440RrGl5MYRQwhGvqbq+9EWK6J0m?=
 =?us-ascii?Q?OJrWWywdii0EzuwpJoN7JuSxHdEwfEq0GM7eVH5cHjn+Q80a9Ls4aWP942zp?=
 =?us-ascii?Q?QDt3KnwOyfJwIEGc0Y+nEDm+0+JLVgTDj/+svv2cLk1Hs9xUc6Hk0R4i4SqG?=
 =?us-ascii?Q?oJntfY0ldkV6ywUGhkClRmknyuz6sbzz0yOriAxXDP8Ct+cqvH/1Lv2lmFKW?=
 =?us-ascii?Q?Sx92RD5nUg/sPxMgR5mGQBhEiy12iWPSg+sEev1DWD+oZuVVEA/ivZGrlx9T?=
 =?us-ascii?Q?2JYaEHuE317HXsIsB4jyCVnPUx97yuFMxsL2sOINqDV99O8FWfrHaAMvgCag?=
 =?us-ascii?Q?r6gjhP9+oUM5UyMB7BH8yd3/O/EFq4RSuqbb1FdIo9GzTtopyFreozRJM3Ew?=
 =?us-ascii?Q?RXZhdW7+wDWLDEO/SdMGUZKOHc5pF3QsYoSFEfUyyQsw7aCnTJsMhuMz4RkC?=
 =?us-ascii?Q?3gqgF2/YFjjHSSlqCv9sr4PGf8ryRWdIb1lCTeJyUwyk51WsXVqG9K03qul9?=
 =?us-ascii?Q?KI7gldJHgjDnqrvxd/DG6Y8dDLcGQlBn6B/OTlx5KUBnut/z554pPgs5KMNg?=
 =?us-ascii?Q?c5y4eo2NKtwqSAKP4TDGIWgtr9rqmJR3+hcESsAMcfTYaJWA8dzOaydYeRBK?=
 =?us-ascii?Q?zKnOAcIeZkItQNUNzNEv1fEe+CCc7TDS1B7kZ+WA1kvzen/mv+Ssezx4dvR+?=
 =?us-ascii?Q?VjpjwkmciO+7GOsf7vhFEtZMYhIW/VKvifUfRA/envHN4isJ4PRsfDD27+gE?=
 =?us-ascii?Q?jly9eg5pI/K+8MI8ypP+qMxxkHPXg3D9POwDp6aI6jq9+ttQ5dNCIRy+Rp1S?=
 =?us-ascii?Q?FUYzdnO0fc8gIZEGw1C9hkifp5njvb4YB5kwdSpMkYtC1FAhjo1VU6uYTQg4?=
 =?us-ascii?Q?oeq0GV8JbQjFRUVeBc1HkHfLfUa7Q4oEdtNaYBlhwxurC/iwqXUuZTANq2ep?=
 =?us-ascii?Q?nyx695WCib8Egg7i/u1erqFszeQpMwwFL9E5+nJH/6bGJ+PWpJJBJmZ6xnrL?=
 =?us-ascii?Q?kM/L6kVMJeoS1DX8zKJmOaznXdwEhzymxs0u+lrZD/7Oc6RT6InnI14PdXBB?=
 =?us-ascii?Q?k2AnPNFnjQQnhUNq3BrqknWaTEeBdDALFQhhVVnKt+c7d9w1GGNLjvRk/Pe+?=
 =?us-ascii?Q?Q68V5yLBvxRzyY8w7MvGnwHN+rPslhtO8DgjMRaG+VIB1gPlb84938I5KJQC?=
 =?us-ascii?Q?8GReQPhJWR83ROVV51aBPa1jAvU8zOhls2EHdjdZxlfiAjDImeesTcAtgOra?=
 =?us-ascii?Q?YP8+Rclg8WevIfra+hEXwzQ96uR91BYvf40UEZ7JNbB4qZcPxPbprJI5TNYM?=
 =?us-ascii?Q?anHYiTtN5Mc7/0I7FMG+EJ1rXaBwVFkEjN1LMitneE9w5N70fk/DwdVaxc2q?=
 =?us-ascii?Q?QzTl2I/zQ0P+c2bShd0s4EyN7W9E6MALTXAAy2pbtT5GuST0FTbQYsy4ob5+?=
 =?us-ascii?Q?EcgydUH9GQ7uDloUzk11/zZDJOCbRAxYJa7XkNUvhhf7MCXhsgNhlzcMTDui?=
 =?us-ascii?Q?Xn67sCmiPD3GkgMPCHqoV1dEXQ1Ul3DCW2BOjlBGiwXBSraTGSOea1Hdk7Qv?=
 =?us-ascii?Q?zW8cReqUTuF8tHfHs9pL3rHMKvY/gRbGVFoVx2qbDLkKSVQRU4PChajlkpy7?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6676da1-d749-4efb-0e67-08dad0dec49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 01:20:42.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwOhH0MRdwtkZYhQGvTvpy5zfiVKDMkBoUe2qCErJcuupFbC33U2tDK9gCUHhne7bqHMSRyjZWG2tAMCRPN5/b3BC7x0w24ee2+iROgqoWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1326
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, November 27, 2022 4:59=
 PM
>=20
> > From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Sent: Wednesday, November 23, 2022 6:45 AM
> > To: Dexuan Cui <decui@microsoft.com>; ak@linux.intel.com; arnd@arndb.de=
;
> >
> > Two thoughts:
> >
> > 1)  The #ifdef CONFIG_INTEL_TDX_GUEST could probably be removed entirel=
y
> > with a tweak.  hv_isolation_type_tdx() already doesn't need the #ifdef =
asthere's
> > already a stub that returns 'false'.   Then you just need a way to hand=
le
> > __tdx_ms_hv_hypercall(), or whatever it becomes based on the other disc=
ussion.
> > As long as you can provide a stub that does nothing, the #ifdef won't b=
e needed.
> >
> > 2)  Assuming that we end up with some kind of Hyper-V specific version =
of
> > __tdx_hypercall(), and hopefully as a "C" function, could you move the =
handling
> > of  ms_hyperv.shared_gpa_boundary into that function?  Then you won't n=
eed
> > to break out a separate include file for struct ms_hyperv.  The Hyper-V=
 TDX
> > hypercall function must handle both normal and "fast" hypercalls, and t=
he
> > shared_gpa_boundary adjustment is needed only for normal hypercalls,
> > but you can check the "fast" bit in the control word to decide.
> >
> > I haven't coded these ideas, so maybe there are snags I haven't thought=
 of.
> > But I'm really hoping we can avoid having to create a separate include
> > file for struct ms_hyperv.
> >
> > Michael
>=20
> Thanks for the great suggestions! Now the code looks like this:
> (the full list of v2 patches are still WIP:
>=20
> https://github.com/dcui/tdx/commits/decui/hyperv-next/2022-1121/v6.1-rc5/=
v2=20
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 13ccb52eecd7..00e5c84e380b 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -276,6 +276,27 @@ bool hv_isolation_type_tdx(void)
>  {
>  	return static_branch_unlikely(&isolation_type_tdx);
>  }
> +
> +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr)
> +{
> +	struct tdx_hypercall_args args =3D { };
> +
> +	if (!(control & HV_HYPERCALL_FAST_BIT)) {
> +		if (input_addr)
> +			input_addr +=3D ms_hyperv.shared_gpa_boundary;

At one point when working with the vTOM code, I realized that or'ing in
the shared_gpa_boundary is probably safer than add'ing it, just in case
the physical address already has vTOM set.  I don't know if that possibilit=
y
exists here, but it's something to consider as being slightly more robust.

> +
> +		if (output_addr)
> +			output_addr +=3D ms_hyperv.shared_gpa_boundary;

Same here.

> +	}
> +
> +	args.r10 =3D control;
> +	args.rdx =3D input_addr;
> +	args.r8  =3D output_addr;
> +
> +	(void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
> +
> +	return args.r11;
> +}
>  #endif
>=20
>  /*
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 8a2cafec4675..1be7bcf0d7d1 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -39,6 +39,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u=
32
> num_pages);
>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flag=
s);
>=20
> +u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr);
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output=
)
>  {
>  	u64 input_address =3D input ? virt_to_phys(input) : 0;
> @@ -46,6 +48,9 @@ static inline u64 hv_do_hypercall(u64 control, void *in=
put, void
> *output)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input_address, output_address);
> +
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
>=20
> @@ -83,6 +88,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 i=
nput1)
>  	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, 0);
> +
>  	{
>  		__asm__ __volatile__(CALL_NOSPEC
>  				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> @@ -114,6 +122,9 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u6=
4 input1,
> u64 input2)
>  	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
>=20
>  #ifdef CONFIG_X86_64
> +	if (hv_isolation_type_tdx())
> +		return hv_tdx_hypercall(control, input1, input2);
> +
>  	{
>  		__asm__ __volatile__("mov %4, %%r8\n"
>  				     CALL_NOSPEC

Yes.  This new structure LGTM.

Michael
