Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B978639E86
	for <lists+linux-arch@lfdr.de>; Mon, 28 Nov 2022 01:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiK1A6h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Nov 2022 19:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK1A6g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Nov 2022 19:58:36 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westus2azon11020017.outbound.protection.outlook.com [52.101.46.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C960626A;
        Sun, 27 Nov 2022 16:58:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7k+UWK4GRUn/6LIBkBQhk7sdQfyu0i4b96ZeMRTC2LZbmQzxE2w3xFIINQ9RIkne/bBCdqXdsJJFhLSM6MOnkpwmBLI1i8/jpeKsYl0Ti7kA7MpHNiexSYSQI4K6lkiY3p83Ym3hvUab4Y5VqNmLJ5MmA5zt87zWjHTBfHWFFSwMTmlP1wHgX7fSj8/7OuvUAOfsbJyuHtETa+NiXm++umGw/gbhv3m4OG7WqBm9WktfDQ1PVL+LQ9Dp06hWkts+ymET0bJIgGE9zHCqlB6uzgQOrxeO/PriJurxnxmzMWfiLvIBmpRlkJN2YPPx0P/ebPB0iqnVabIcnW1J2tfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJkkPIg46rzITsC/rUupOsmKwZ51iv3l9KKDoi4+Omc=;
 b=SmWt0S7WIB1dB84BAkeuvJWzZxaf9h1vF4kIA++2KTqSzdnhKB3dWrh6rwMegnsjmBSDgbkLTF94B8HmGmAn1J+0URBpFk7pG+j0NGCxPpXAdYSLU2rJ8UwaOu4pJAPGJw1ejX2f7fxC2nP2nRAojjvi3j2EnQK3skoNRoH+dnbA9QK5Pp7FPkUkVGFGi11YFeVtNatm8TiivEpwJQAdUI0c9lkE/Nh07G4mw0GJp96+Yd6BNxNjBb5CdB96WTicrdt7R4zJX7m7kyqBVl0s74Mr6s8D2SXVC/8Baf41ol2oEHA6N7sO5MSuYX7conGASIb45PcoP4XR9CAxh/qoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJkkPIg46rzITsC/rUupOsmKwZ51iv3l9KKDoi4+Omc=;
 b=ORhiLZoZ+fEo1Dg2RzCU3vhBA7mS5/V55eS0IUCo59PJEIcnx+EW6fkpamZBYZSUCM+sj+hEcwmNUp9MTX8X7p0ClUHMSuwk+wvR43XZ4xUBsPM+Bng4qoO0elw9Q9gPhdmtV467bEoPkhztt7yfcdYqSGq6asIksa6o7EYSBls=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3543.namprd21.prod.outlook.com (2603:10b6:930:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 28 Nov
 2022 00:58:32 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::ac9b:6fe1:dca5:b817%6]) with mapi id 15.20.5880.008; Mon, 28 Nov 2022
 00:58:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
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
Thread-Index: AQHY/0oyvJMCdibbbUqzNA0JVsxn0a5TiVBA
Date:   Mon, 28 Nov 2022 00:58:31 +0000
Message-ID: <SA1PR21MB133528B2B3637D61368FF5FFBF139@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221121195151.21812-1-decui@microsoft.com>
 <20221121195151.21812-6-decui@microsoft.com>
 <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16886270B7899F35E8A826A4D70C9@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a799fdd5-3e93-46b4-b0f9-8dd673651b98;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-23T14:34:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3543:EE_
x-ms-office365-filtering-correlation-id: 0f1f0ba0-aba2-4849-3480-08dad0dbab36
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNjwxAhcrUpHFS+ottKl1VQ0uAAYvRWQmqsmbtBx4FnybCUZ6p8pX2qdGtau5MwVAWaK87Fy9aL9PWgcWGH23yoa7bM2XqtrbcTmr8HY4xMBhr4YqTFnV/CPr31Fc2zcrJifsNvW60ySiTIOUS1uQsOb/RDXzN0JDvhMf70aeKkaaaO05IUx6F7l0xmOVzuMXvAZiZTthVjhoYXQkjFutU0260KvgRxsg4N0QecMbwCkIQe8YRmxptjKrpUiRLOHveSKAWqJdhHSqCEwoX8N9lB6hxoawTMyyGdL6ByUihmlAAmhRqZiSdn68XnWL+Yyl3NY44SrH2NIg4W7blSEHzR0auVzF4yKHQzjbYaQAvKbE5wK7iBk4oU3rQK5rlhkR+9e0dU9kU6EjLPcJH4jLyEuoHI1T/pGlXAqUwDmjx1cGMTRZnr9qdu7/4YTvhPyG12hnMML/QoguuEkBG3puk3hlwmzJN79FayOM/8WdBUW1F7KlKCDROknwcwujZcf99lvYfs8uQo+Jrk8wXXGMqfHR6yN7JdzoFsM0jsjgqRbU0FBzRqVFmSMGeAXdtGZRrDSCwWBcPa2DBxz4EU3iw1bIpw/4KiojL9kmyKIfAO1cCRnb2j2q7/HUkHlJ8Sr57KyNfbUfXwscy7RDuwVbvZXg+aKeNjmHiwy0s2grs3EENqujae/MljwywPjhqajHQUJ/DDpbuda/JI+UUFeZ3pLPysY+/T+LxJnq7LsEs/4eHW+sOb1Iy/zvTCO5SAKMrsKPlg4rXJ4hKbhYckjtzYN0CWiZC6MZxHXcDrSm38=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199015)(9686003)(7696005)(53546011)(2906002)(26005)(6506007)(82950400001)(82960400001)(966005)(38100700002)(921005)(86362001)(5660300002)(52536014)(110136005)(38070700005)(316002)(10290500003)(122000001)(71200400001)(478600001)(66946007)(7416002)(66556008)(8936002)(66476007)(76116006)(64756008)(66446008)(8676002)(186003)(8990500004)(41300700001)(33656002)(4326008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tEocPDW9U0ZZtdypr/qX4T6wpSe+FYF/z1y+pMmfuVcBOlRyVCBlJpiZqwOV?=
 =?us-ascii?Q?ZBpeKFfC/LqmV1lrofPQm8cC75L4rP1oozfyy53BBi6pHHE9ovbgjO2i8B2X?=
 =?us-ascii?Q?iTxEiLo41E6W2hO+ir2U4Rn3cvcnFGE0n1DndNY+jbuCCC2z5wFFwok0K9Tz?=
 =?us-ascii?Q?6Mo55VXui/8m+Lkx11pP9PSJoakO3GdFl5Wr0e5LxMxrOAeCMNBP2CO3+el1?=
 =?us-ascii?Q?r8jF1kdmhxMjcztF1UGZ8wrTvrtq6GHzbNRBW7K7xVadSA3vXzuOWW/M8Ch6?=
 =?us-ascii?Q?m2zivALSKOU5FbKTTuDbpJoxirEABu2x0bg3FLWe7a2tivd+VPV6IgESzRG1?=
 =?us-ascii?Q?GVm7pZurrxHuhP5mRqPHPJEfv5hx1oaL3g9AeJ+CzdfMnQwgic4vv9vdZDFR?=
 =?us-ascii?Q?QDhowcRlvRlYYCi+PEsd5z50f1aOGkYT5kN+I7Sttjz9kBqKJOQB5aLD5uWP?=
 =?us-ascii?Q?Thuq2wZpjFMgHap/UGpG//+dIHUsWod+Zwn0cjxV4zp/H2Q3PnJg3eMNN0ZI?=
 =?us-ascii?Q?3CpkWgDwlkXLcZEQ9yuXo8/NpXGnllbh0s1n/US/BDelUdxZ5YXIfE0Ra96j?=
 =?us-ascii?Q?u5b7kNV9QWr3CPXC5ngZtuGLsbo3YSpZrDSwM9MmGVSP7+X+T0N2IV1cVKfc?=
 =?us-ascii?Q?iZlQo5Bu7fKAabxq6iDjXfSM8WugbsaCSBSqwUevAeVUK81eIwbRVlbuYHgW?=
 =?us-ascii?Q?XbXjfOlBGDSzhNdUMe2dsMxAmGxhnoGZRrWAXpyKP6q/P7xDKkMn5n8mAgdl?=
 =?us-ascii?Q?lDu9gJO4OV1e5zWMAwrEEj+piX2ylcRdP5ARsydIMy46Z9KWw+Ac7GyH/421?=
 =?us-ascii?Q?4Nn4lQs39T0e3y1fjs56QWA17i833f64zNQdP/Ydpqc4Mtbe7yGuy6cQJY97?=
 =?us-ascii?Q?AX5pnoWGah4l0Hzb3dSHYT85MlwhZ4ksdW81Ql0iu4WCGUntXkWWJHeQg7m0?=
 =?us-ascii?Q?i2cHxISGzTpkAE2o6VYiqCWcNxhWfAfPijl6ti43DamVp6fJGYiiCgPu8Ls1?=
 =?us-ascii?Q?U14+6tEe26XRXLciHJnkQLRvxoZB2HxAI423lFa6YgC5wTDe+os6DvzlCEE+?=
 =?us-ascii?Q?DQgnz5ZFahk0y+M/YM99C888crZKdxHz5EO6JhqWNMbgvMm7yaA2RzAuS7Y9?=
 =?us-ascii?Q?fV25uDMSGYJL0WOKo2XL5nMM+pzjQQ+Ihenh5k5A/sqhIDLPBfmNVNwMJr+y?=
 =?us-ascii?Q?mO/LlaOdxlwGkY3n1byE3xJzT19rZErsl/nqAbmU567d5LA9Ja1g2AKEjZph?=
 =?us-ascii?Q?lCtsjUOY3eaLtTCfBbv6EPCTku38+V4lTOIUf9lw3JLRZnSbir29VRARWLh4?=
 =?us-ascii?Q?DXP9EUbkm3yKI5rhHSvAJr6cAP7EwvAmo2pEPVPvXjEbgOmZ0S2umuNo1Ci7?=
 =?us-ascii?Q?cpcjwcpT3Xkxh0cXM0JdZKgrAdeNiagjm5ljwudMttpdMZBGYsD26yyjO7Ck?=
 =?us-ascii?Q?Lz7rUe/egZvGsm68BlJK1e7grVy2g9ZEshGWMBynEOggLpMrBRQ3UT3y7F43?=
 =?us-ascii?Q?BYddJsX9U8P5zBeBqM3fS6UA8deC0UfxUpmqbuoRjpjz3m7/BYM2akNqkTo9?=
 =?us-ascii?Q?8xlwBBli+4OfHaZHWrjT+9/QijLMoBzFMWCeHno6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1f0ba0-aba2-4849-3480-08dad0dbab36
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 00:58:31.4593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HRhRW+DFUHHzXwLgDC16982NHABvR5l6kWuGodeVoDv3GiAoIbpkUU9VVx89gELzgJaV2EcyLkd+8olZa41hXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3543
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Wednesday, November 23, 2022 6:45 AM
> To: Dexuan Cui <decui@microsoft.com>; ak@linux.intel.com; arnd@arndb.de;
>=20
> Two thoughts:
>=20
> 1)  The #ifdef CONFIG_INTEL_TDX_GUEST could probably be removed
> entirely
> with a tweak.  hv_isolation_type_tdx() already doesn't need the #ifdef as
> there's
> already a stub that returns 'false'.   Then you just need a way to handle
> __tdx_ms_hv_hypercall(), or whatever it becomes based on the other
> discussion.
> As long as you can provide a stub that does nothing, the #ifdef won't be
> needed.
>=20
> 2)  Assuming that we end up with some kind of Hyper-V specific version of
> __tdx_hypercall(), and hopefully as a "C" function, could you move the
> handling
> of  ms_hyperv.shared_gpa_boundary into that function?  Then you won't
> need
> to break out a separate include file for struct ms_hyperv.  The Hyper-V T=
DX
> hypercall function must handle both normal and "fast" hypercalls, and the
> shared_gpa_boundary adjustment is needed only for normal hypercalls,
> but you can check the "fast" bit in the control word to decide.
>=20
> I haven't coded these ideas, so maybe there are snags I haven't thought o=
f.
> But I'm really hoping we can avoid having to create a separate include
> file for struct ms_hyperv.
>=20
> Michael

Thanks for the great suggestions! Now the code looks like this:
(the full list of v2 patches are still WIP:=20
 https://github.com/dcui/tdx/commits/decui/hyperv-next/2022-1121/v6.1-rc5/v=
2)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 13ccb52eecd7..00e5c84e380b 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -276,6 +276,27 @@ bool hv_isolation_type_tdx(void)
 {
 	return static_branch_unlikely(&isolation_type_tdx);
 }
+
+u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr)
+{
+	struct tdx_hypercall_args args =3D { };
+
+	if (!(control & HV_HYPERCALL_FAST_BIT)) {
+		if (input_addr)
+			input_addr +=3D ms_hyperv.shared_gpa_boundary;
+
+		if (output_addr)
+			output_addr +=3D ms_hyperv.shared_gpa_boundary;
+	}
+
+	args.r10 =3D control;
+	args.rdx =3D input_addr;
+	args.r8  =3D output_addr;
+
+	(void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	return args.r11;
+}
 #endif
=20
 /*

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyper=
v.h
index 8a2cafec4675..1be7bcf0d7d1 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -39,6 +39,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32=
 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)=
;
=20
+u64 hv_tdx_hypercall(u64 control, u64 input_addr, u64 output_addr);
+
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address =3D input ? virt_to_phys(input) : 0;
@@ -46,6 +48,9 @@ static inline u64 hv_do_hypercall(u64 control, void *inpu=
t, void *output)
 	u64 hv_status;
=20
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input_address, output_address);
+
 	if (!hv_hypercall_pg)
 		return U64_MAX;
=20
@@ -83,6 +88,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 inp=
ut1)
 	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
=20
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	{
 		__asm__ __volatile__(CALL_NOSPEC
 				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
@@ -114,6 +122,9 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 =
input1, u64 input2)
 	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
=20
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	{
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     CALL_NOSPEC
