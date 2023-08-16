Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C977EBAE
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbjHPVYP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbjHPVYO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 17:24:14 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020014.outbound.protection.outlook.com [52.101.56.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E371BE8;
        Wed, 16 Aug 2023 14:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3T6mkYc1i8xIMULch0uhbJnAtkVgxXur9PGVBy8/mp62atIGcIbugpocedeOoO8Z1DrWaDUS8hHi6l9O5MQOrbA+v+N4ek8PTsluqC5Uk/pcTp45GdQwNMWWKDAKD8nwdKbODIq/sMlSMme9il8NpA1CsM2wcp+c1D48Bw4v53uXARM0FLw2xpVLBkBvWUPlGvmUtz3o8PUNjBrh1GLhoRfhVe5Fmn+JsqKTOmS6D/VoCGuBkfK3Vjfc50P1n3BJWSBjsljc67DceKhkADywZr+WT59Yys/DUsguY16Zxh4LXIXN4cMPNkfFgN1cC06mJXyIshAM3R2EfM3z4CiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MC6j67Y9/ZQpe/Vz+Yjn4hH/T5xLOfC9EMkPO+BBauo=;
 b=YvskpSPql9l56rafb5oun6LulWYtiubn1R9y5WLrmS1LmNcKSHv7moroPNDj6X2BHwFi+aISEz462R3kGZdXiS8GdOy7Jf1wXm1IKmAfKY4168GCcDRmRnaEDkQVXr8GxUyhnE6M0wLsLhhZAzmv4ZfTbgopiILHnGzPq6ywmZb4905e1bsg4bZS1HaFE3MI0cJyr4z9cYCFQCOT9FpjCqG2luXmHM3rI8s5t59K2cQFBbCT8raBK1o/wqRkvfVXkfLtGKjHSfhHgAwHXbnz42q+OUQQVEzmtGccwEF36FzYEHdL+wIBEBsxeikSp/QrkSJ+S+CxitLtKF82pmqUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MC6j67Y9/ZQpe/Vz+Yjn4hH/T5xLOfC9EMkPO+BBauo=;
 b=DhflGE48g/aXb5m8lpKKD8TTiQGqyNGlldhMmB35yPCZ/uxA3zdIuZtlalljhfO1NfsINDxRtQx78CKD3IvCOnHbL3uN9MQMXYk7DyrvysPPenYgVRpxrr/EpxlZ1fSxjKqQXdzgcegZJp+WrEV48C95if6m/79OojvnSGICHrk=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH7PR21MB3877.namprd21.prod.outlook.com (2603:10b6:510:241::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.12; Wed, 16 Aug
 2023 21:24:10 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::b05:d4ac:60ff:3b3f%4]) with mapi id 15.20.6723.002; Wed, 16 Aug 2023
 21:24:10 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Tianyu Lan <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH v6 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Topic: [PATCH v6 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Index: AQHZ0FqWwwhYTLc5ZE2nEAVJ3M8pkq/tWGEA
Date:   Wed, 16 Aug 2023 21:24:09 +0000
Message-ID: <SA1PR21MB1335A775BD084921484B4209BF15A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
 <20230816155850.1216996-6-ltykernel@gmail.com>
In-Reply-To: <20230816155850.1216996-6-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a0b4d3df-b0d3-4f16-98e7-484139e144d9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-16T20:02:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH7PR21MB3877:EE_
x-ms-office365-filtering-correlation-id: 37b444e0-73ec-4f7f-8fa3-08db9e9f2155
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ugOEouuV/0BRP4KCZDqeCUSBbRCWiGjNMpyjQfbPAvTdRUqpaeadRoz1qsfx8McRrbE9+1vlfpLO/jtz9SOpiZ5fyvAYAg4Cqpa96OsplrgMVD3vrky6HtsFQ5wv5hVl1riwq+AQfEcaZWpfNpIGaWHgTAuTm5qBTiGX8Kbg9lIuHzxWEamREzn1OYqGwPlKQ+/Pwr1Jz7WyF4P7e+7mxe4A9wKodN/kd2GAygvNsW9eURAqR32N2YnzXQ/gvT7uLOPkhnz2+DNvVzvHNEcw1cIhI2MOQJHiDdKa5b4tFvP+Qjm7zKUpWxy9kHngDg2am7C2oRcNMVnXmni9Ev6KxcqtN6HXpgHh7wqKv63rxRQU3tMs2CILZowV2SUTyNbkO/LWTjtYhhm3QzaAcJ4ZKPSZA21J37H/DOma3FxZKoP8TnNovg1jf9t0hJblv9nU6SGeuKKiuktVcWUbHQQ7DmYzMoNXijeNiwbPQ/cMkeKMmyIbK4vASApG6cZ0OL4GOiPLVLR1/yVPw+bqSIiMZ3BwXhPiiwj/4Li0/fxdgFgpOHTcjLNzM8qlRKXJUhK3XnU9KurSdDIgmt4yXdA8NfZvs8IeM7DHCGLi6b6jgfqwrI1U1QRbNXZyMbN22C/sVVi4bQVdtgo6Kp/Nfs5S1DrNif4jPSI+PjEz3bVvlNEYI0BzP57CT1bRS5PEUIxRJx3ReWtPxUYTO9M/FnuaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199024)(186009)(1800799009)(8936002)(82950400001)(82960400001)(66946007)(53546011)(8676002)(122000001)(8990500004)(966005)(6506007)(9686003)(38070700005)(921005)(86362001)(38100700002)(33656002)(7416002)(71200400001)(64756008)(5660300002)(7696005)(76116006)(66556008)(66446008)(4326008)(54906003)(52536014)(6636002)(2906002)(110136005)(66476007)(41300700001)(316002)(10290500003)(478600001)(83380400001)(55016003)(12101799020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hlwg/jFhRVEl+EwXA5LQbeI0a1eJPuMzjuZwONwVFU7+6g4RdErt0HgePu/k?=
 =?us-ascii?Q?4+YS9Q3Os5C0ZTF1xIjP9wKNnbuU5Nd6hgRw0Rh4FWVtiIOnJHS4uggntu9/?=
 =?us-ascii?Q?qAi+g1gcDBm5SUOHWnaHitEF3L2kUh7n6vjH7fdBPZ2Az6p7mQVwNyZQrWSu?=
 =?us-ascii?Q?Q3VU4QLcweSvWcXjlpKZkGBiZ7QPQvtD8/Uh3wRndfjVrBNkJg47MG3FH1Jd?=
 =?us-ascii?Q?gP/4JDOkikecHh73T8GUG7gl4qwmTCAIX/p9jSljLSQiiUEclsnJmkRAz6mi?=
 =?us-ascii?Q?024npnR66gSDU5TbA4XMKM/iVM6FLCRa9nSo0cXoBg5Wd4yAxel0/wI4veZT?=
 =?us-ascii?Q?gEfqbDRP3oX+csvK4LQjrFtEA4r7pu0HAnhp/zypcM40deMt1Oe33PhltQb/?=
 =?us-ascii?Q?W67smgP3g94kMzCBG7OzIcuH0sqFbDWoOhMm31LqaDJ4pNssP4RZQqLNpfS2?=
 =?us-ascii?Q?qxfC7jtbh3hgdLtdwTKIzUMnDltSDXnLIL5XJNoqOrrewpydVZXnSN9m9HFV?=
 =?us-ascii?Q?ynX4gDZICbYt9ZB9RTVX21qL6d2StJ9PED9ZUoQ6+2B4ziIoj2Zmp/lpbAxm?=
 =?us-ascii?Q?ZgNKkHhPJmDStN4xexM1tsegBpt0KaCpKCm9BYQAov8R0CuzDv8TgQ3PPF2r?=
 =?us-ascii?Q?XIah+Fv6x4jXPYKiXMN1BR1g+CM/qlsCgHjaXBORU8YE+2FlPJVj3xWcWUY8?=
 =?us-ascii?Q?ReqI5NAWZ/csjFlADm/l00pkcp41mEKSdCXMMO4nC6ulfTnTIdvCcmG6h3A0?=
 =?us-ascii?Q?rO8jNVpGXVFtyBtqRQ3gVIhM7EaGvRybTI9REqjaBH2u4MMG7ppZa0cNnBFE?=
 =?us-ascii?Q?+QC/3CVG6xMsI82Hom97xar7U3u0ca30IOwpK4o51ngx+96T4HPSAulv/e/9?=
 =?us-ascii?Q?pQ1Quz0DjMUhlzqEn7NkpZMpf04MG78wjls606wl6DbNHwST6LyCsuvaBNnu?=
 =?us-ascii?Q?nYFhRSHBYnYzNssT4fVe/VkcgHkTCnSTvijLS83hwim2p1k19Wad8RONytdP?=
 =?us-ascii?Q?v7Nl3zL/ilyoOfHWYDWsI+gSuG573IpDGcU5FWpjVIzOk9Yg9Rv7jU6HNX+d?=
 =?us-ascii?Q?lA9B6rp8bwuMNeBZbIxyX6ZIPdr7Zmc2FldVUbn2A4QTiMuHtbTRdmAnUr9I?=
 =?us-ascii?Q?YySQxrY5GX9EQ2ueFK5jtIxVn3MKHo5BoRBAo82T1UrQj6neTAli/fFR7toC?=
 =?us-ascii?Q?ypzdDdGj7ToEXcMPFt3AJjdyEWWQP5xrxgnHst3t5olShmg+X2z/TtWz8oD0?=
 =?us-ascii?Q?mh3/rgFNc0i4nLbOmQ/lQ8/7Jn0FH/LLopwTcH+LmG1bsSSAqUQ+dJ/6F+M5?=
 =?us-ascii?Q?6hm+d9cLPCmVtgm8VZEjrDLWBL/x0BlQ6f3nv1Vv3lUPKhfi7k6wa7V4G+ld?=
 =?us-ascii?Q?DwefHJBfnQtAMDOm2uhDoAFjDwlFqi4aTK12Ne6V387HPKkP8mRQTy1yCAB9?=
 =?us-ascii?Q?Xpnf4MUWWir53DFQ4olaf52rWpqLchHCoMbIdSSpSogy+hT3VG8orW05Af/U?=
 =?us-ascii?Q?nlG66vRONai3OYOemHx7qpHMaa9q47Ggca+wYpModx4MiyG/J8PwhxAbQvGZ?=
 =?us-ascii?Q?lSTWdvJ7wDhZUZiOM3Mg11KlDZi35jx70BFSK5wanZDJby+XAoetPIYLfJkl?=
 =?us-ascii?Q?0c3KtLUf8bpedAkPlec+01w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b444e0-73ec-4f7f-8fa3-08db9e9f2155
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 21:24:09.9093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ms47AO7JujJSj8Boxu8Ipmkb32SF2aQ3AJO9u7H3i+A1pugqJnb9dK6ovfJzq/23/1bj3ZWFGQAoZgIHjVdw+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Wednesday, August 16, 2023 8:59 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
>  [...]
> In sev-snp enlightened guest, Hyper-V hypercall needs
> to use vmmcall to trigger vmexit and notify hypervisor
> to handle hypercall request.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -59,16 +59,25 @@ static inline u64 hv_do_hypercall(u64 control, void
> *input, void *output)
>  	u64 hv_status;
>=20
>  #ifdef CONFIG_X86_64
> -	if (!hv_hypercall_pg)
> -		return U64_MAX;
> +	if (hv_isolation_type_en_snp()) {
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     "vmmcall"
> +				     : "=3Da" (hv_status),
> ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	} else {
> +		if (!hv_hypercall_pg)
> +			return U64_MAX;
>=20
> -	__asm__ __volatile__("mov %4, %%r8\n"
> -			     CALL_NOSPEC
> -			     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
> -			       "+c" (control), "+d" (input_address)
> -			     :  "r" (output_address),
> -				THUNK_TARGET(hv_hypercall_pg)
> -			     : "cc", "memory", "r8", "r9", "r10", "r11");
> +		__asm__ __volatile__("mov %4, %%r8\n"
> +				     CALL_NOSPEC
> +				     : "=3Da" (hv_status),
> ASM_CALL_CONSTRAINT,
> +				       "+c" (control), "+d" (input_address)
> +				     :  "r" (output_address),
> +					THUNK_TARGET(hv_hypercall_pg)
> +				     : "cc", "memory", "r8", "r9", "r10", "r11");
> +	}

IMO it's better if we add a "return hv_status;" for the SNP case, and don't=
 move
the assembly code for the regular VM. I made a patch:
https://github.com/dcui/tdx/commit/f81013578605aa02939a3186afa9fc76791b3acd

You may want to explain briefly why the earlier approach=20
	ALTERNATIVE(CALL_NOSPEC, "vmmcall", X86_FEATURE_SEV_ES)
doesn't work:

start_kernel() calls hyperv_init() before alternative_instructions(), and h=
yperv_init()=20
already uses hypercalls, e.g. the newly-added get_vtl() in your patch 2.

start_kernel:
  late_time_init
    x86_late_time_init
      x86_init.irqs.intr_mode_init
        apic_intr_mode_init
          x86_platform.apic_post_init
            hyperv_init =3D=3D> it already uses hypercalls, e.g. the newly-=
added get_vtl() in your patch 2.

  arch_cpu_finalize_init()
    alternative_instructions()

We can move the get_vtl hypercall to a later place, but there are also
other hypercalls before alternative_instructions(). IMO it may be unsafe
to run ALTERNATIVE code before  alternative_instructions() is called.
