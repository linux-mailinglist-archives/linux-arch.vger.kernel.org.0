Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB6762965
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jul 2023 05:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjGZDoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Jul 2023 23:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGZDoI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jul 2023 23:44:08 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96061268E;
        Tue, 25 Jul 2023 20:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1OUeBgTIxsLDt2yHVESlx6hIJdb4mgR7XM2iEEHNWc0xSsvgWsWqU8xI7fBB1erleuPeIvgdQvcHKkZgv/3FQM4He6QSqsq6eKGaI8Wr/tyLbAYmgyEJbYNnAxBC4yWoJ66wjD8p9e94cuzX9oyeCLdfLiZE3TZudYEQAGMMSG8Gx9Tsf37Z0FbZYP9Jn7kQ/vC+zBT958RlT3tG0VEJ8zJn6Wjsga8wV3DhJZL8WkeIGPoN3JbAbFwgVLo2z4U54O2/AxJxY0g7DN7qKlBbSjZ0hOB1V6KYXSJxHPAaSrt0WB6Pk8WIlp8pN6ctnDljm3SobiUnPbPJ59cQDlg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rljgVzqZ3wT7easg9Ww83GmApFbI0klYUdoWeutlAlI=;
 b=hf0wLNQQwJNd3knpO6ScDmXsl4UPafPrWIdFX5vysN59dQF1Bb6wZGfNwjLbrtqxzQFf/eWaJldGyaZU4z2nTMTympaTQXvxe8pnTI46zioj96TNwmaw66WOscJm9N9UAV2Gt4snlDZnXZIigJcRMUuUhgTDZ/YF1c6Uu1KIAo7yhotOfAvibuFC+vyjcM7s6RERhMT493/9mV3jdHdLZv76jHKHm45sw3eZWy/rwP6bOECB6x/C6ewiQI/dpgeygVscQcsxGf9/gnXiZxu6Oaiq6DvYuPXNus+Urly+lecH77PvD7kt54hxlGL/7FbKoZ2fS9BKZLXbkQkBosPK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rljgVzqZ3wT7easg9Ww83GmApFbI0klYUdoWeutlAlI=;
 b=OZ98iqFSIWHbPgOkK4A3sraSlAgLY3fT9Hw0+S+k2fVU4811ikTwfb+C8L5RQJxoTF6ewiqatIklSd2vudQp5yMv1fhBCvFRhjc84QumhJvFnehCoZuwijTmbrL6QbKmfohGXw+FcMQW6PIUfYje6BzNXTo6II+sGBZcOK0zaiw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA1PR21MB4051.namprd21.prod.outlook.com (2603:10b6:806:2b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.5; Wed, 26 Jul
 2023 03:44:03 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 26 Jul 2023
 03:44:02 +0000
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
Subject: RE: [PATCH V3 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Topic: [PATCH V3 5/9] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Index: AQHZuSc0kUvvgTYmMkGptk368Lxyvq/LcQ4A
Date:   Wed, 26 Jul 2023 03:44:02 +0000
Message-ID: <BYAPR21MB16882FAEDEFAED59208ED9E0D700A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
 <20230718032304.136888-6-ltykernel@gmail.com>
In-Reply-To: <20230718032304.136888-6-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c1dfb2a7-2a71-4b02-a84b-59e300d5b325;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-07-26T03:31:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA1PR21MB4051:EE_
x-ms-office365-filtering-correlation-id: 683d4237-bd31-4365-798c-08db8d8a8de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xxr1VE4rLBfBndDw07N50IoD0vQL1Awwtb/325R/keqfWs9hIS17wvl3CwXQd71ykvF9V7oFGtELLQsNUOs5uWE1DXy/bkuRx/4IvaQ8LEXk37+4OPSFeAHkUIw5QQK8GRmxdSGCaQ9LFOFOpZeDL1S6Hfw3WNUiMlQNbh2snROTJZQPRI9C66zAt05PBHya6zbJNgo+ZJAX2cphHXTyijyU412F2M3FG/nIXYTOq/JaJpf2TIkXP7gV3c/moJpTcOjWWvBc5GFHQb/BvWrFDkK+sX6uyPWbUmNh0QcaYqjQI4IZgZ4Kj9PZFt6Av/NZiY0HFpPNlpuRr1STd3w35UhR3fVgj1YxzlpWSPJC0gb496jnNva1b83pC73UbnyApfx0Dwnt6VgwlBO931frR5k2K8sUBW1wDtGyUm/3IpaWlwjpQgjTqg2NGuPbVO7tenkGmXxtlFOQe8X9H3vuGjfFxxeCdkKtg9UNUcvUyut3r+3jMnPhQ7vd0FbgCaY4albluWEubV0tWZZkYsIM5u/uDOrQgB2iXOVXtLfg40uG1ifENbE+3aASBQSEbeIosLRwxznN2qeeg8CUcvhYoJhUq8Nxrj/qVBCEqfTGsCo5QhsQLx4l4tEOps50BR9IJSP6gc/5PeVJKAOnsQ3trIkAB9pFLVF15YlLSoYPL0aSDmq7+ltkOHMzGQjBRyvJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(82950400001)(82960400001)(8676002)(66946007)(41300700001)(8936002)(64756008)(4326008)(316002)(66556008)(66476007)(66446008)(76116006)(2906002)(7416002)(5660300002)(38070700005)(38100700002)(122000001)(921005)(33656002)(86362001)(9686003)(6506007)(7696005)(55016003)(478600001)(10290500003)(71200400001)(54906003)(83380400001)(110136005)(52536014)(186003)(26005)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sM3nKmG3cpmgADCfLkXWswfKrb/0xPrL245iB/WV5UmAGN2bH01OuvJ+QNBy?=
 =?us-ascii?Q?Sw3G7lL0WJra57SVmx4l8wK3bcVtoSH78n+iO0fdgM8cV3YqxN1LF8UC4RNv?=
 =?us-ascii?Q?MmFcgZZ1+gSHerImjdlfMzAAV7yNkNgByABMFW0ieRV/vZ8rLuuXx8pnKMt0?=
 =?us-ascii?Q?YBF4Jv6P0oXooSk2Hq/8RradYziWyUUwGyMAR40xECGz3vaxdeCAspVvZI0B?=
 =?us-ascii?Q?CdZBepkxpZbQIj4oxROCNONNFaFbQO+hsqmF39vVzJ73DXTJkepVDKUT6bk6?=
 =?us-ascii?Q?zouOWbZG8kXV9Byh5ihUG4dhN5qWtlKlhm6BKhtAHiELyHK4ZD1g2HPi47bk?=
 =?us-ascii?Q?02Ecsq4uJbSLXZ714NitVc2jwOSky1EMs1217SMYn2BRajabRY2SbmNqkS0k?=
 =?us-ascii?Q?XgM2ojO+Rse+0Fr9wQN4iJJ7vJYVY/eFJTEfBaUdhh9J6MPigxEzBaTi/X7A?=
 =?us-ascii?Q?ypgwiTTf2sthw60ZEtuLvA9Sg/jrdp+Q85/Mmrd6OjMDk+Hgshu/gjGJO9R6?=
 =?us-ascii?Q?JGHAT5ul0xiCgymZNGquXPDbRngcO6wBF9Mq1jV83vRWd0bMP2ddPVIKXJcE?=
 =?us-ascii?Q?W01LEF8/E5UCEPxNZP0c8o6Dlr763JBgjekwnwuFUZc3drSVR56VR3Kta930?=
 =?us-ascii?Q?jm1FdXCpH9xG0JXdK/2HniZBS9Qs9xjnlUZ3qBrBfJRz7Rl9xqkIYBeqzhJ0?=
 =?us-ascii?Q?9I8hJvp7A8rdVy/MG0mkCpDIQfCUEVGcB0G9v0ngYXAh3NgU+WH4QwN7ft0Y?=
 =?us-ascii?Q?f4duO86snhdmDPKyo92MkX5jFjskkKZgmF3zG0/quPfmD4jZIhI+uPbIDica?=
 =?us-ascii?Q?t/Cqrc4UTQJ8eaWK9F5LakP9SNn7ZEFNf7EiKJHeqyU9upalRuc0z6y7y7Lm?=
 =?us-ascii?Q?cIQ3HT9fRD6TwnYpovzAoMtnDgDTMPknu+TcbBdk6Dz4LdVGJrjZwlm5ZZqb?=
 =?us-ascii?Q?7ED2rwFLiGqppEu2tafP3T3wYAVxidRkaVkkc/3fDVhVBC3UKSoDX5YFEdxO?=
 =?us-ascii?Q?/aSReawsrtRtea/ibSN4iyFAcfHkavmlR/UpHZyqVYdTHwjGixYjOCt6IibU?=
 =?us-ascii?Q?CRHlmNUvysJrlWDRn63UYGriG7ZxOy15Fr6elcXUdopY2g8zr0HZG6ROE6ad?=
 =?us-ascii?Q?e5LZGwBlNzQjBZYvEIbe2IGSAOnLxM4xn94wV4Q4przlrq05wGFN2aimg2IW?=
 =?us-ascii?Q?T2nqIOv1FolHELFUESXA+gRm9N1G2KxVXOgDM+jWa49hHFuUa61yFYyQ37x1?=
 =?us-ascii?Q?yJSutszKDdm/y6af60whkyRLacrmB+LOwUUpUKrHysoz2JzKGBOHIGEa/00x?=
 =?us-ascii?Q?3q+w5rcJ5TkjOxtPdsDNzuUhphXScORax+1jo7EFnwFMVAojn+fMFfMgAL5y?=
 =?us-ascii?Q?q1MpNVUfMtl+kx2JUKM/+k+uJCtq8R2X+y0B0qHeqg2mo6TqpCfXIo6O2YFd?=
 =?us-ascii?Q?AOq3fDDge6agpjNrEBi7AXJBu7S2myXf9t+MWDuGDKVRGEPafmAO/ZS0hfOh?=
 =?us-ascii?Q?5rCdZazf6KClItgtCtNho+qRGVAPui5814a0uhrQmPHbWD3eLpOdL+YjkxTk?=
 =?us-ascii?Q?PAE6MAice0/wKAikdQUFcPsUhMIrHSTTJxVjrj1Dlf8Hbhr3heIMvCZg/Aoc?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683d4237-bd31-4365-798c-08db8d8a8de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 03:44:02.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kK/pPWviKLXsO+mfaMrBUk4lgNlDnqCkY0zbgpnurj0a4jHOsiKUtTrI7YMa9BAhfbwYt/2PkBL5ZPFXJvD9P3+XQrJ4XD5IWV6stgsvAqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB4051
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, July 17, 2023 8:23 PM
>=20
> In sev-snp enlightened guest, Hyper-V hypercall needs
> to use vmmcall to trigger vmexit and notify hypervisor
> to handle hypercall request.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/include/asm/mshyperv.h | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 2fa38e9f6207..025eda129d99 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -64,12 +64,12 @@ static inline u64 hv_do_hypercall(u64 control, void *=
input, void *output)
>  	if (!hv_hypercall_pg)
>  		return U64_MAX;
>=20
> -	__asm__ __volatile__("mov %4, %%r8\n"
> -			     CALL_NOSPEC
> +	__asm__ __volatile__("mov %[output], %%r8\n"
> +			     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)

Since this code is for SEV-SNP, what's the thinking behind using
X86_FEATURE_SEV_ES in the ALTERNATIVE statements?   Don't you need
to use X86_FEATURE_SEV_SNP (which is being added in another patch set that
Boris Petkov pointed out).

Also, does this patch depend on Peter Zijlstra's patch to support nested
ALTERNATIVE statements?  If so, that needs to be called out, probably in
the cover letter.  Peter's patch doesn't yet appear in linux-next.

Michael

>  			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     :  "r" (output_address),
> -				THUNK_TARGET(hv_hypercall_pg)
> +			     "+c" (control), "+d" (input_address)
> +			     : [output] "r" (output_address),
> +			       THUNK_TARGET(hv_hypercall_pg)
>  			     : "cc", "memory", "r8", "r9", "r10", "r11");
>  #else
>  	u32 input_address_hi =3D upper_32_bits(input_address);
> @@ -105,7 +105,8 @@ static inline u64 _hv_do_fast_hypercall8(u64 control,=
 u64 input1)
>=20
>  #ifdef CONFIG_X86_64
>  	{
> -		__asm__ __volatile__(CALL_NOSPEC
> +		__asm__ __volatile__("mov %[thunk_target], %%r8\n"
> +				     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)
>  				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>  				       "+c" (control), "+d" (input1)
>  				     : THUNK_TARGET(hv_hypercall_pg)
> @@ -150,13 +151,13 @@ static inline u64 _hv_do_fast_hypercall16(u64 contr=
ol, u64 input1, u64 input2)
>=20
>  #ifdef CONFIG_X86_64
>  	{
> -		__asm__ __volatile__("mov %4, %%r8\n"
> -				     CALL_NOSPEC
> -				     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -				       "+c" (control), "+d" (input1)
> -				     : "r" (input2),
> -				       THUNK_TARGET(hv_hypercall_pg)
> -				     : "cc", "r8", "r9", "r10", "r11");
> +		__asm__ __volatile__("mov %[output], %%r8\n"
> +		     ALTERNATIVE("vmmcall", CALL_NOSPEC, X86_FEATURE_SEV_ES)
> +		     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> +		       "+c" (control), "+d" (input1)
> +		     : [output] "r" (input2),
> +		       THUNK_TARGET(hv_hypercall_pg)
> +		     : "cc", "r8", "r9", "r10", "r11");
>  	}
>  #else
>  	{
> --
> 2.25.1

