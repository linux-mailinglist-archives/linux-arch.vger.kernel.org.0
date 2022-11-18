Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907B562F95D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Nov 2022 16:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbiKRPfh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 10:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbiKRPfg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 10:35:36 -0500
Received: from DM6PR05CU003-vft-obe.outbound.protection.outlook.com (mail-centralusazon11023020.outbound.protection.outlook.com [52.101.64.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812255ADF9;
        Fri, 18 Nov 2022 07:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwHFQJdomexYJ3eAe3sge+l12LUdA/OsiKRXMMPCa5CwiIXU8QY/SQwrEG4hqM9QGysm5y8N1yn4zdTUEj5sXBV4jiQszmgZcyzhfhkEJqLllyM8Vh6X5VAIEL/gTOjrxmnilUh4KKyhij7jt9HU5t+ehWVj7dwU287ebL21JJR2DPUQ3KLTURF0WnpaEsUaffVmIVEfR5vkgfcrZRxC4JqGZcudkrlXpKl+7seLtSgG+r6tlE9G6xivGdePCVqtpwO7zt0dUbwsmjbj0Jkq6LAH0SD5hkXLa1yn+92nbnEP57VV4MDeDFd8IF6FoNzA+a8W5w4njYpJh8RSMpjLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwQB6LQm7CDSdTNWrvQoPzFVqDy+XFHFyiymr96I+q4=;
 b=VQoWzjDGsbJqdXVJ9a+ecSCC8DWDHa//HQF6yYnaeIMNsIiJUTgcJs1tH3s6SybIpXtExlB9B1SFwYkhWI0RRXpZvMOW+VO3xEae1sI4Q8UeTr99J4VnQg/JY5w/ykcmkO6DDBAVZHDL7tZ4WeYgyyD5TbtRP1af4z9r7mlV15qhtTWx4oS8cW7pBLN4QY0jOOZvCYyM16lq/KSUQSEImXUYO8qfBMOJZVXCUzr8ITkcYa1VMJQ6UgNCrhSOEVdAMlhPxJTgI3w6urcAsdBewnmNuvN/+2CFYYVfcl5A28SH+CwGsU5qBbdCFim1SZke2aCe7Xw0UGjTxrPmp/vthA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwQB6LQm7CDSdTNWrvQoPzFVqDy+XFHFyiymr96I+q4=;
 b=TVcznT+tunrpoVCyYw1KsiW2LQvUr8jmZHMQKcHqNmK3FVyO7mm8G/8qnPiepw6yKCAbemJ13fCL2wbuuo5WH5ujWsoCWNhdfYBUvo1wTElQyflFDUsdzCO9tRkoD0DdrBAsa3Sg3UVLcojOtNHNuqHYmpNbcVjb5/0ap3d2V3s=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by BL1PR21MB3331.namprd21.prod.outlook.com (2603:10b6:208:39c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.8; Fri, 18 Nov
 2022 15:35:29 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5857.008; Fri, 18 Nov 2022
 15:35:29 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jinank Jain <jinankjain@linux.microsoft.com>,
        Jinank Jain <jinankjain@microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>
Subject: RE: [PATCH v4 3/5] x86/hyperv: Add an interface to do nested
 hypercalls
Thread-Topic: [PATCH v4 3/5] x86/hyperv: Add an interface to do nested
 hypercalls
Thread-Index: AQHY+jSmELRLubiPOUOBsS0zIlGWdK5E0h3A
Date:   Fri, 18 Nov 2022 15:35:29 +0000
Message-ID: <BYAPR21MB168830A725464BCCCD9A023CD7099@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <cover.1668618583.git.jinankjain@linux.microsoft.com>
 <3a09f876982e14cea8883f03fa9260db1fe64857.1668618583.git.jinankjain@linux.microsoft.com>
In-Reply-To: <3a09f876982e14cea8883f03fa9260db1fe64857.1668618583.git.jinankjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=af7f36d7-c952-4bc5-84e2-ad15692a4a34;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T15:34:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|BL1PR21MB3331:EE_
x-ms-office365-filtering-correlation-id: 35b7bad8-07d9-4dbd-6d3b-08dac97a8605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJp/pgr2J83UypKR6W/EPbC75QnuQt9TolMuJjpP3jUQDs5llmMPFZ4rSaSrr+ljCH8hfcBldYKXBjMyAE9iYEprWWAhkvghX2PuoqEejcV0i9RlFv61VVB5mgWlbGGPtXi+Ubo6ZICSkNA9n+sHEQMJz/x8U1j+PpBJdzbwj+S1DmNIFHi8aetDuJPRHRYkEKBNjCaMWW4IBTdT5XMo9t2oTas2afguFq7XkVI2NRuI4plY6RAM2f1Ja29r9mzL/rKmI2OGZEetUKSMPFcb4hMkwOOU8vAsPmvUlt5uXQRujQ4cSXHJNtsQAPbOFURwUuVK5pdxpcGGxqQ5htB0ogPYjytehoYmexcsFo2s4qOd9e8mHG0zxsDhmNbFmZJwWqEFevB54SbAy2qprMWDDvAQMYM4Z2rZGlkTrqjvvwGnDL/JMa400WPU/8qqs2VvyKQCVlZN62ha1xaTCRR3QC6ENBNJl84kHQhCpCUDsZfMop6mBmem9kEafK/2Pn8UTVGuN61lGFa+Bvlbl8DX6bmZ8BAzsK6gX8SLRlmuKbQa/bjYUWQ1u84rmSXkIZ76aFJA9p/yVG5jTnkEwYiQcH5VQtpxHF1nBWAd4CyRdMH1CToY/nW9F9GJ1rhCN1MYC82JKTCemJxcOZ03VqIKhMgfGKHveqjeYu/kzyWJhO/u117Iv0QZrI1y0hb2x0WecHTk2yPkpD5tX0FaP+9PF7klF52E42OuclqIjtVssKOFlP4Cdvii9qGcG3FXDUNj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199015)(5660300002)(316002)(7416002)(122000001)(71200400001)(478600001)(8676002)(86362001)(64756008)(66946007)(76116006)(66556008)(66446008)(66476007)(4326008)(8990500004)(26005)(107886003)(41300700001)(55016003)(82960400001)(8936002)(82950400001)(38100700002)(110136005)(6636002)(38070700005)(54906003)(52536014)(10290500003)(33656002)(2906002)(186003)(7696005)(6506007)(9686003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eU3golSm1fC20Y8z+EnknIqE/Y6Qcv5PGciQHhwIn0ASMVctzVwsJfqSL3FZ?=
 =?us-ascii?Q?ssA6Xx30Agscoxs55mKW/l3+qcqK1biuKDaAk2uN/qGHx8CEW8TxbXAsbZa4?=
 =?us-ascii?Q?zdWtwXLN8jj4Pr8Z0pcWebs5vUExcaZFQHNHLKQei+HpDzwOo8mn+2g3BYjY?=
 =?us-ascii?Q?mDxynMTetvTukn2QfiNIEfOsvrZZQrU+my39Mxct8kp0+MLRYFtC9SZwPXUB?=
 =?us-ascii?Q?c8ABp8upDeyFHNAn7zuHfaP9RsLV1kaXrBpAMmK6tqrUfF0TFZdW+Nr8oIO1?=
 =?us-ascii?Q?9SEEg9iGn8SJh58M4p4VTGADt0NZ9ykkv8uME+X2Sv+UUwVXrR4MRODMcau0?=
 =?us-ascii?Q?URoytVvArFToG37zv/iYdJz1LFAivO9A+Kh8OsEpF1d3AC9BCo89HI+lhNbP?=
 =?us-ascii?Q?WcmmkDmQ1cn0z0CNRUZqRTofLYIJAiX5XtGhq2IwY5m+oOOnKAszilvZKiLB?=
 =?us-ascii?Q?n64oGSfYnI/Jy+f9PJ8gtb0Xs/5icwlmSsEn4MoyZENsk+tOYzWqTZ4Y/30d?=
 =?us-ascii?Q?PAEh71v6OHmpVPia1a3ZisyZfQM+nsnuOL33S+25iYN1AaRPt28ylqw7bBzg?=
 =?us-ascii?Q?0S5aHVQXDSjZGPZHEW8s3MPsxIJVDYOjxrcMTx++xaggEoMe9b3XV8HntTsH?=
 =?us-ascii?Q?/GB116AHdkn/tFO7o1nrmhbPzGdvdKjrXKcUBYEGW1pDxt9OAllUryQZMkMO?=
 =?us-ascii?Q?kyqLSsGoHlgp5e3wCD1XsbxnvQ3q14d2xs58jA/aKg3WDbM9wbRaETkr2FzT?=
 =?us-ascii?Q?P70TkJXGBp77UvdkrhtQMhsBYNb8l3zufiq3l1N+XIuZ4Ud6RA15DNY3FH+D?=
 =?us-ascii?Q?ULsI9CEPc3j+IR2euZl0K+4TrzXwp2DTK9E1BfDyEhWfpyMUVzChO2aiJ3pv?=
 =?us-ascii?Q?UQ6gfUzO1lR7JWx0Cl7GfNtFsy8i2hZjBXuoRRGnZTczWBifUscFW4m8ob4s?=
 =?us-ascii?Q?TMpA2Nhjg1P6LW7HTKjwiqlnGWQpxsVZ8W0GZmD47Frz36Iy17yuKG/IqK23?=
 =?us-ascii?Q?DwUtZl2T8+mWJ/mW+d6DESbb0VCmKBWPRPtRRI/VHkJVBAhcMaIBcW+kDCqi?=
 =?us-ascii?Q?4qv/WJTn3ebCWMlKMdaCpEkmnneLPU3xkD2Bd6a8sU4D0Zv6jVuCjbOCYNfs?=
 =?us-ascii?Q?R4W5fRLgOVdI6j8Hju9TcjuLecAvyJwU37ua+B7UJL9SqiesbLqrORyG8KZq?=
 =?us-ascii?Q?yycGWqd1I5ZK/viyduGbDJEBaMPHdt01oZJyn3Jo1O/S67MIS1HtTP8p4zXa?=
 =?us-ascii?Q?0C62yaoSyQooHTYgzc50+5d0PNH64Y/rnVmT7yEOZNBKt0HcYUG2vX/Q2lYU?=
 =?us-ascii?Q?bUKSQfUDmErG2FEbXVu6KBoeguWVxJLW5xLwx+tmYzEvCvxogZ9TVBoZ7xB7?=
 =?us-ascii?Q?lRv4RfKq2wYvkLbKp4txINGrMnTVipfcCGluRuyT7OmAstoD22Py7iwMgnqD?=
 =?us-ascii?Q?7Ytnyoq6vM/WZ+86O9fG1u+7D9TSwFN69Y/GaicMPcAbgIIqxgud0w+keknp?=
 =?us-ascii?Q?41da+3WONEjkk8beSGFrM1dA+kI0o6hlqkRvwuh1xJKFYs6m+URw1PKJqNE/?=
 =?us-ascii?Q?d3MiMWNNnLlyQ5Yn+DkuC+GUXGr4pNMp/BS5gbS/Sbc0DskDQ1n0pSbgS1y2?=
 =?us-ascii?Q?5Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b7bad8-07d9-4dbd-6d3b-08dac97a8605
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 15:35:29.7416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A68J0QdTker6ZkpXTr4uATLuaqBZNQ61BsyO64R5DzXXD4Ig2OczubwHY2AhL5IL54U1gQLP7QLZ8bkyviUzOYc5EngCBDQr2O5mZOJY/Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jinank Jain <jinankjain@linux.microsoft.com> Sent: Wednesday, Novembe=
r 16, 2022 7:28 PM
>=20
> According to TLFS, in order to communicate to L0 hypervisor there needs
> to be an additional bit set in the control register. This communication
> is required to perform priviledged instructions which can only be

s/priviledged/privileged/

> performed by L0 hypervisor. An example of that could be setting up the
> VMBus infrastructure.
>=20
> Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h |  3 ++-
>  arch/x86/include/asm/mshyperv.h    | 42 +++++++++++++++++++++++++++---
>  include/asm-generic/hyperv-tlfs.h  |  1 +
>  3 files changed, 41 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hy=
perv-tlfs.h
> index b5019becb618..7758c495541d 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -380,7 +380,8 @@ struct hv_nested_enlightenments_control {
>  		__u32 reserved:31;
>  	} features;
>  	struct {
> -		__u32 reserved;
> +		__u32 inter_partition_comm:1;
> +		__u32 reserved:31;
>  	} hypercallControls;
>  } __packed;
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 326d699b30d5..42e42cea0384 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -74,10 +74,16 @@ static inline u64 hv_do_hypercall(u64 control, void *=
input, void
> *output)
>  	return hv_status;
>  }
>=20
> +/* Hypercall to the L0 hypervisor */
> +static inline u64 hv_do_nested_hypercall(u64 control, void *input, void =
*output)
> +{
> +	return hv_do_hypercall(control | HV_HYPERCALL_NESTED, input, output);
> +}
> +
>  /* Fast hypercall with 8 bytes of input and no output */
> -static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> +static inline u64 _hv_do_fast_hypercall8(u64 control, u16 code, u64 inpu=
t1)
>  {
> -	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
>  	{
> @@ -105,10 +111,24 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u=
64 input1)
>  		return hv_status;
>  }
>=20
> +static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall8(control, code, input1);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall8(u16 code, u64 input1)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT |
> HV_HYPERCALL_NESTED;
> +
> +	return _hv_do_fast_hypercall8(control, code, input1);
> +}
> +
>  /* Fast hypercall with 16 bytes of input */
> -static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> +static inline u64 _hv_do_fast_hypercall16(u64 control, u16 code, u64 inp=
ut1, u64
> input2)
>  {
> -	u64 hv_status, control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
>  	{
> @@ -139,6 +159,20 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u=
64 input1,
> u64 input2)
>  	return hv_status;
>  }
>=20
> +static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input=
2)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT;
> +
> +	return _hv_do_fast_hypercall16(control, code, input1, input2);
> +}
> +
> +static inline u64 hv_do_fast_nested_hypercall16(u16 code, u64 input1, u6=
4 input2)
> +{
> +	u64 control =3D (u64)code | HV_HYPERCALL_FAST_BIT |
> HV_HYPERCALL_NESTED;
> +
> +	return _hv_do_fast_hypercall16(control, code, input1, input2);
> +}
> +
>  extern struct hv_vp_assist_page **hv_vp_assist_page;
>=20
>  static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned i=
nt cpu)
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hype=
rv-tlfs.h
> index b17c6eeb9afa..e61ee461c4fc 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -194,6 +194,7 @@ enum HV_GENERIC_SET_FORMAT {
>  #define HV_HYPERCALL_VARHEAD_OFFSET	17
>  #define HV_HYPERCALL_VARHEAD_MASK	GENMASK_ULL(26, 17)
>  #define HV_HYPERCALL_RSVD0_MASK		GENMASK_ULL(31, 27)
> +#define HV_HYPERCALL_NESTED		BIT_ULL(31)
>  #define HV_HYPERCALL_REP_COMP_OFFSET	32
>  #define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
>  #define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
> --
> 2.25.1

