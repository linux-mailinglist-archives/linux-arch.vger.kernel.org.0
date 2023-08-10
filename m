Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC83677843D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjHJXnv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 19:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjHJXnt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 19:43:49 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD786270C;
        Thu, 10 Aug 2023 16:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxUmb5VD0iVHx8ya8APoCmvSqQsrWdqbwAUkzna8HbhEMH6jxjsqOKWdbcRyaqJYxRkGTYcLzxvF8NSolKack7AJO61lA39rs7uHEEUGN5SzVa9xePNXidqHudeBIN3be8hJ71ffqPQbrAKGJP+utGNPAV3AUch7Adyd4l1GoSvMuouw4cPtTkT9EW7E8YSarFvmUJkiGbPW/aLBxyva582DOuuWy8fg3RdmmyrvRiQzVN4DwA+RqAC3J7V0gYF7akI8giPZJI8cp/+lSBXLgGVwx8brPZtLCZHLB6KTumEEtVd6/3SWvCtApuBET1ibYSdv+yiRkM+R+HBotEU0GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBzmr8ScCtGp27zAOvAz4Z+FrDNLbK8ArWbNdHT0LTY=;
 b=miQN4Bhu920WRhLub/BK5+gyE1VqAQrlnAMGJIlG18Lo5EFOK9FLHTYaH9Bi1gl/74uKhAS/Fj6/2xEmyZNcQemp3D0XLXjTFLAI8zf/9oouU6euGzGWL7hVy3goLO4zbgNelikS2nDJGKnuBq3Ioma382HuGzbZara3+MiOUTrtHFcaEcXJLbr5O94FUm9tTmmKIWXr5nvtYIPfJO/7p95QwuK3wwBKIV+XJ1na0F+sgqkOa0isbm5iLRDqwwt2hP8JjNcept/+3UQColqeiE0BsHBR5+0RaVymoMJeL9ZKtTbyOBhYDdfVjrpuVlhuQ6giOCNiZ3msAVgnPqWsYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBzmr8ScCtGp27zAOvAz4Z+FrDNLbK8ArWbNdHT0LTY=;
 b=WQALlp5iBaQnFpkGGbZzuRLfJ7SXMwSklHu7n31FtiDMcMkn0CnXkO+Q0gviwlEjvmcVPM0a1rXjPi3ZUIVn5eoVVkx3qNsfeOfidxLi+0SmcQjB+DUxV0ehicBcgR0xN3D5Tlg0HUjshMtqG9/25eyIaYMjlAnvMBuuNulfzaM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM6PR21MB1340.namprd21.prod.outlook.com (2603:10b6:5:175::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.7; Thu, 10 Aug
 2023 23:43:46 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.004; Thu, 10 Aug 2023
 23:43:46 +0000
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
Subject: RE: [PATCH V5 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Topic: [PATCH V5 5/8] x86/hyperv: Use vmmcall to implement Hyper-V
 hypercall in sev-snp enlightened guest
Thread-Index: AQHZy6RcSmAxWsL870yqkbg9I7eROq/kK2Zg
Date:   Thu, 10 Aug 2023 23:43:45 +0000
Message-ID: <SA1PR21MB1335B3D89CCF3EB16A94E424BF13A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
 <20230810160412.820246-6-ltykernel@gmail.com>
In-Reply-To: <20230810160412.820246-6-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fdd9ae59-68e5-41fe-948c-a9d5122f2978;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-10T23:21:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM6PR21MB1340:EE_
x-ms-office365-filtering-correlation-id: 70f415c2-df45-4b0c-7a9b-08db99fba35f
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AduSJV1XzWi3Vsw/wsSxuZYx4uRL4oyVNlQawhvTrIozseA+t3gKV2UJC5Hm/BqIziqyIKSL+6yLMx+y+he0A4DQJ6bmWoIwOlgH+8ZgZKRTzs73ZHZ5WIy/EiSYICiyUj235gkQIC/2qkLnxZfT3Mma4RI737gXTGmc2ImILivwezfqLGu/taKEYJY74wrLUXmMOXU033Nm/6MSfgjheHYF0PTAX30YWJSMRtujD/kFG3b7CGB6OYz38Qd61QnMQIWhmjRPmC1fabWVJxNoqBxio4cUa2pfaAcy9VWErD0oK++V3B3LPSNPl2sOzaRw0zK5RSO9UWsHfE2OgKNs+oMvHPGwd28jOqkpjhMOHmsE0vgsSytBuzrRc0r1mT1YmhaaM0gSkwZGJZCgGQPd9ntcQz0sUj/CjilxSBPwt83C+EudjM1l4Twtn76AC2idrvUnmP5VDJsVibWY4y/1EzUzqz8ZquIbsjjyQS8XEWTgz7X54QyoMY3jJ4xO1p5ZJP8QjZRK0HZ1WaHJ9jHHpxYf1VOM/bqqFlVInmv+NOdMX9cLErSggPIK1NrTLxLuWJ6X+e3kmhv8BcKpU6csjnHqsT7SRGC2SVp2mxYc1sTdnqI7SZnP5m7gysgaj8J0Sh1Shcr59lk7Cb+3FXlGL0+DeXNnz5gdkBwWeh6FEGoYtXyM8Fr4iedX7yGetNhCfZmZBlCPuo6cQoJaAxQHiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(366004)(39860400002)(186006)(451199021)(1800799006)(86362001)(110136005)(54906003)(10290500003)(71200400001)(2906002)(7696005)(55016003)(9686003)(8990500004)(33656002)(26005)(6506007)(478600001)(8676002)(8936002)(122000001)(38100700002)(921005)(316002)(66476007)(82950400001)(52536014)(64756008)(66556008)(66446008)(66946007)(4326008)(6636002)(76116006)(5660300002)(12101799016)(41300700001)(82960400001)(38070700005)(83380400001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0SYDt27bmHemfhmLN3hBd6bgLxMLf3dN6eWOA40MNfcCfhH7MPoOe2VY2iJb?=
 =?us-ascii?Q?uvE/Glyxh0La5DIyH44PsUOvxcDo6rzuPcix3yaJagz6906TIs4UcBb9YiXn?=
 =?us-ascii?Q?qnPSDxh3zUfYyJTt1HVzY6uTw0mgBqP6Z+GpByqaJ6SMk54QQkWyCxCX6xLm?=
 =?us-ascii?Q?Eq/YqtsUvMsOVgFltu9GCY6nkwa81YZFS8M3KSF84DfVGOLeuK8YgXuClPfY?=
 =?us-ascii?Q?9swgYkyfbCpiPNiuuhj1vvPjAMk3tZQ4D23HfyL4YK7wjj2HYJngpHtkufIl?=
 =?us-ascii?Q?onye/8MebH/mfxH3c/qM70uJwXZMYs1xhY8J4vXd/InFWDOGHzN+L2UWClVw?=
 =?us-ascii?Q?itJLILeJFC0FcjAkuzw0pQ9Iq4z9z43p3lOjGEzSTUKkWXg0DF+9qvUAijbs?=
 =?us-ascii?Q?NVQgu85OF+HSQgVGeX7wd2AWTxM1SFOuexjJouhRth1rydGX2tMb9E3yz1aI?=
 =?us-ascii?Q?KTAmvX8YqEQeHQBpXEs2dk1lyNZ1BNhhd8i0ko9JZnUlB1rZKfjrJQW2Bh6c?=
 =?us-ascii?Q?jHNjPPYTx4cQpaGXWsazwaeGt64gGnIaroT27QAen9GbNe1PnUbRafL6hlCm?=
 =?us-ascii?Q?hKqIPOubBj0hF+w64zTxGIx9KXz8AcuZOLy5Er+KX/S78OQLKCqAkZ9pfbnt?=
 =?us-ascii?Q?ZD+kzh9zDfoGrwrum4zv7KIS87vLM2haPkoX8zaQh2W4oIYt6ltLDc51OjzZ?=
 =?us-ascii?Q?COkjvMWB3hOO9PaufjVy0od/BE6lRzEoUTQWjOUfNS9S9wqkk/y2ep0NBokN?=
 =?us-ascii?Q?eJCB++8FdLl1vVsg+T3wu4UgNHcv4Yak2JVwhiwxSbaRuUAqeRFfKBsTFbM8?=
 =?us-ascii?Q?HnLdREWI7gbeSUS/25u9q3zyPgrp2OPb59+s9TI+OxsYhBG00hXkTvfq8rUA?=
 =?us-ascii?Q?kKVZ+5Xk2I0NOZ6f31DZ9RbtHujUOZxe4MjmsfldPzhvWHKYBeCxmuhVcFts?=
 =?us-ascii?Q?Y4Ik3zI9NU/TuAgk2nY1RwKg1WrnTeokzc44iqJIPfrShEuapKD0BQMcpBee?=
 =?us-ascii?Q?3f7PCAAewQxHFNBi2Ho9E1vAzj4lnxdux9afFAjpxAWwGlRPuQ5F6JxTGoAw?=
 =?us-ascii?Q?tz/Zhtvao8EZVbw/7FzkcWeUZxnzJYJHcB5sFanqG9P6yeN6B2qqTAlrjNTE?=
 =?us-ascii?Q?EQ98tQ2U//iOV7BkrIqEXqhX0PUXAM5FbCcMKublrgGz4di6//t28Mfx6wrC?=
 =?us-ascii?Q?OGnyvG/paMMOQUiPvLdaAet6QUznUYp5xh8xQSnw6z085cCHUAD0e+VdPGVZ?=
 =?us-ascii?Q?++XdPWJB/cGd5DoSDraC1NL4G/14OE/DI0Cd1YrNQ6CnWOTeZ+S+KAl+cFjq?=
 =?us-ascii?Q?cnxVDIHSpHWdqQkhzcbAx7KBG/DBayHmRsg017EW9a+ieyjrF9+vo5FNn0jM?=
 =?us-ascii?Q?Q4laGVvlJ7TJfpLhYMQoQYEet7Q9hsKvsaP/nLW4dJ1jzPFhud2Vn4+otZbe?=
 =?us-ascii?Q?dZsiw+WZQSRncd/leUGcbZBp5zDRGlQl2+odhFlfZf8PYWy/S1fvO68qPm4y?=
 =?us-ascii?Q?MupJKRV2l0Gkx24C3Q4McVsTtD6UT9ZUBb1rJt1p1aHeVrWJk7ZfaYtF6+mO?=
 =?us-ascii?Q?Z127uOFhX7zedZWMBZaADvutauBNfz+RHfk99lzW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f415c2-df45-4b0c-7a9b-08db99fba35f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 23:43:45.9678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g9KCbGVn4is1Od/ZNbUOWFwfKSlh5rTrEl76gaWZVS8jWx4BFzdoGkSHl/nDiorLprgpmDxGCpPBwxwkw6ky1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> From: Tianyu Lan <ltykernel@gmail.com>
> Sent: Thursday, August 10, 2023 9:04 AM
>  [...]
> @@ -103,7 +103,8 @@ static inline u64 _hv_do_fast_hypercall8(u64 control,
> u64 input1)
>=20
>  #ifdef CONFIG_X86_64
>  	{
> -		__asm__ __volatile__(CALL_NOSPEC
> +		__asm__ __volatile__("mov %[thunk_target], %%r8\n"

The "mov %[thunk_target], %%r8\n" is dubious.

I removed it and the kernel still worked fine for my regular VM (on an AMD =
host)
and for my SNP VM (with HCL).=20

I suspect a fully enlightened SNP VM also doesn't need it as this hypercall
doesn't really need an output param.=20

I noticed your=20
[PATCH V5 8/8] x86/hyperv: Add hyperv-specific handling for VMMCALL under S=
EV-ES
exposes r8 to the hypervisor:

+static void hv_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *reg=
s)
+{
+       /* RAX and CPL are already in the GHCB */
+       ghcb_set_rcx(ghcb, regs->cx);
+       ghcb_set_rdx(ghcb, regs->dx);
+       ghcb_set_r8(ghcb, regs->r8);
+}

I guess the intent here is that we want to pass a deterministic value in R8=
 (rather
a random value) to the hypervisor for security's purpose. If so, can we jus=
t set
R8 to 0 rather than %[thunk_target]?

Please add a comment.

Sorry, I was not in the earlier discussion, so I may be missing something.

> +				     ALTERNATIVE(CALL_NOSPEC, "vmmcall",
> X86_FEATURE_SEV_ES)
>  				     : "=3Da" (hv_status),
> ASM_CALL_CONSTRAINT,
>  				       "+c" (control), "+d" (input1)
>  				     : THUNK_TARGET(hv_hypercall_pg)

