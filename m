Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7972C3217
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 21:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbgKXUnu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 15:43:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:5569 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731938AbgKXUnt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 15:43:49 -0500
IronPort-SDR: bdsZ1hCimTRB8k03+M+cux2Q1ncpxZdvkUVh7rNZwPw9aEuR9QW14TjIhXHTOy0eccAUfYhash
 pikOSaXJGhBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="172171075"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="172171075"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 12:43:48 -0800
IronPort-SDR: FXwDEa7nooBTcFlSLP73lP+qFeSCeas91rTzJzHFJPLSqYKyddPtPRFqPjmnk58MNK97QHUI30
 EriHrUun9nlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="403032478"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2020 12:43:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 12:43:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 12:43:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Nov 2020 12:43:48 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.59) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 24 Nov 2020 12:43:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfEU4TSOjV5X7+wLPxRXuNwitwsHO90y+icxZnZHgW2KlcPb1PFwC17C0Fvca0qxBGKk6gamHkPMZ8R4ydzJtkbWTnHl0Q9mfImZhcJY1c/OMbWHuPX3nRziYqC1AaTqbUH64/Q5A5raTCx2TPVO6vXxVfSz8nMyqwSjuB7g3HXKKR7t/emy2WKrPgfh6gSm4VQXPKKhGYA98uNBPpO/xFAkplNVtxhp63PygiGEpplmw9HfkvB2LatoXFkQzsqM1gJfBcPc/Fs8Gocvx/IspK93LvYAIefVilf8EsOYamNVDdgrkgLliD8oYUCpRYvQW+i0zfxwfmdCzz2xyKb7GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on5rOrZNmLLLOpdo1SjpmjFsAVOH9LqBYh6qUvzvRlE=;
 b=IWf2iUVY5XNjg7OsKjScoI824kTVcF5J+2DGSv84+VPzSCA9S5Pq5AllSuEzyCOnWZu7Ykv+7ekI771ZX6QU003EfPnRYDKT4+Ltua1/wKs3hK8a8VC4RRgyrQ2PloqZYdmXSIc53FXFn50t5Wsg0pQeASv0MrW1XZvTUcZqjY2np3yt90i9crpbY6/U6zdJZ6KSGZ2HAaokX8DOejU/E0FywPdPzfqWJYzZq250XmPEu7hcFxarsjjrBv4eHliesMhXs17kmGJICqUXeywW2XJwNUQieP707w8EejSC6Bm1gGOK1W58AoP7aq5U+1o2qX6nQMqO+qnycwMtJTafgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on5rOrZNmLLLOpdo1SjpmjFsAVOH9LqBYh6qUvzvRlE=;
 b=bebLEH8c20bwsEeIRJhJdX1dZyjBHT3tcmT7y8p8M58/LkhHkdYdjzcYZ17J0P+ZZMufIXFZaiQPzTUfUQNSSFSwZ1Q14Ri7DenGQU2ZspHCf2aZZU4IiE4dcyjRrb5XOE+zSOTGvy/qLWr6a9sQ+N5m85PMJ6yO/wouCa0gesw=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by SJ0PR11MB4909.namprd11.prod.outlook.com (2603:10b6:a03:2af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 20:43:46 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 20:43:46 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>,
        Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Topic: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Index: AQHWvqcjVskyJoXuH0ORuPNb6HHBoanRpbwAgAX6YYCAAAWAAIAAIhWA
Date:   Tue, 24 Nov 2020 20:43:45 +0000
Message-ID: <15AB5469-3DBD-4518-9C15-DDCE7C70B1B5@intel.com>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-4-chang.seok.bae@intel.com>
 <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
 <B2D7D498-D118-447E-93C6-DB03D42CBA4E@intel.com>
 <CAG48ez1JK6pMT2UD1v0FwiCQq48FbE5Eb0d3tK=kK4Sg0TG7OQ@mail.gmail.com>
In-Reply-To: <CAG48ez1JK6pMT2UD1v0FwiCQq48FbE5Eb0d3tK=kK4Sg0TG7OQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2b6ab1a-1649-423b-09e7-08d890b9a39c
x-ms-traffictypediagnostic: SJ0PR11MB4909:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49096A19B1EED1EAE5B67D98D8FB0@SJ0PR11MB4909.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0D7fMpBYcGN/+/zpfvlOHnh7StVyA90AVnIkO9vEEZtaZDPk1cJ56zXROVKY+rNSTYg/SinDm8vprthtmZjPIYzM2xUn5pLJxgVDn+vxGfN0ktzWGVtcY7XuXoZhACp9Qpe80tIDKgwdog1va6xm3l2rDy2yTHV+4t9/AfTqsOKxQ9HgFUgme9aHlronvtULpyWp3uwyTjl2+WqcDnxO/U+wRasm8tYYYUdSh0pgAicIgn1LXBiBG3FysjA2+jFwkg+uEecRkRALRbYwc0Tv0HAn2+NU6GrpzYqi9s6ctZzj0eb+VHgvkoOcA2kDHIryqJzqkV8WhhNy+w5shAcm5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(6916009)(33656002)(8936002)(6512007)(8676002)(2906002)(26005)(54906003)(53546011)(86362001)(6506007)(186003)(76116006)(66946007)(64756008)(6486002)(66556008)(2616005)(316002)(71200400001)(66476007)(83380400001)(66446008)(4326008)(36756003)(478600001)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kGkqWXe1dvwefy7sebYn45m0CNN+/b2E2pdAc/Tygb5gKYxKI03fKh3QgAAH?=
 =?us-ascii?Q?xqzCkPSjqS0e54SfoanQxWmpcyoTyiZo6TzUxPXEDq3WC97F52q7ndtT13Y6?=
 =?us-ascii?Q?dCcIQdDi2t/iDgaqujyrRPg2GSFNEUyh0H8+W1fdn4oEurvdWW0eYciOzNaN?=
 =?us-ascii?Q?yl6STHGUU2+lwh7yl5UyZSMa4AP44G1JNpjqwgAGLloRUO/r/IR7Dvzo0Zoa?=
 =?us-ascii?Q?04EFbYd+v9eAGxZJF1/zf2ZeRsUubHWbWrfFKx8i8EmLjUKbrcaCd4huW7Ig?=
 =?us-ascii?Q?P6OxhcbOnDY+IjY9ZYDXuqalbN9zSCc+jrr7jAR/eVlVAoF3QhLuqlkIzw93?=
 =?us-ascii?Q?tjKMUZjmsINBTyejA7FM4gYoIhxIaGJ/lQ8fgI3R+GT80oCjMzJXseebv6AD?=
 =?us-ascii?Q?21CZOFCzCKp2QoI9K5+ddVCmUrIhyHiYtsAEykatToAAuM3exSmUBLPXKcDk?=
 =?us-ascii?Q?HEFHc+uWi/XEzTyMBVsrYAenJkdOMD/XEZTtV0VNb/oTxa5M0kw/zVqh+qi1?=
 =?us-ascii?Q?w45gkYcD3AVpSsspJa4yIH0WJnlVaKpDIdlLwFYBFx2z/33v1Au6nucjwXKT?=
 =?us-ascii?Q?pI/acTGLJk4KXTNCy8+xK2YuddSJiSzxREEq5lASF0gI00xvKV6gyCIeO4W/?=
 =?us-ascii?Q?tsf3TSn2lvgqPHlCr4qG0UwBNMo/9i9DoDr2FlLI8dDW5JBv0DJZqQURe6BC?=
 =?us-ascii?Q?50w9gBEg3W1iYRYE3Izn6mVK62IfOcxJO1MOuZ1q3VONKXU9cK20vmwfBzjB?=
 =?us-ascii?Q?AJJtBumxPzidToFy4Cgwo5w7ZLMqH7AEZpvVFy/rglipfpmofugLN1C8+T1T?=
 =?us-ascii?Q?QqBA1MmuOg0CJ2yUSYsOOWnBjKHoww9Dbqe47VmO47EfFUUh3t+wZJbUBSho?=
 =?us-ascii?Q?n3SRDzu8QbqTgoTA1XRORhAdcfgzOkuFnhrQB78vb9MFkug1mv1WV9AopUMU?=
 =?us-ascii?Q?KfInfCj259tsaTqe7smIpGCBSma+IQ5rgyxeDsx40teoWngcs6IIPEn65ORJ?=
 =?us-ascii?Q?JMZm?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <798AD0D402EBB74B8A8E3BED902AA4CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b6ab1a-1649-423b-09e7-08d890b9a39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 20:43:45.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31XZxWASW2Adi7Iy5Cle8XIK4tr8+c1mLGpc5tm0u6+8i9IjJ4L5DmcxeEFL8jzQQ7HkNUpyE0aR/aNh7MFm37Z7CB4RgWPueSlZZL9snGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4909
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Nov 24, 2020, at 10:41, Jann Horn <jannh@google.com> wrote:
>=20
> On Tue, Nov 24, 2020 at 7:22 PM Bae, Chang Seok
> <chang.seok.bae@intel.com> wrote:
>>> On Nov 20, 2020, at 15:04, Jann Horn <jannh@google.com> wrote:
>>> On Thu, Nov 19, 2020 at 8:40 PM Chang S. Bae <chang.seok.bae@intel.com>=
 wrote:
>>>>=20
>>>> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
>>>> index ee6f1ceaa7a2..cee41d684dc2 100644
>>>> --- a/arch/x86/kernel/signal.c
>>>> +++ b/arch/x86/kernel/signal.c
>>>> @@ -251,8 +251,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_re=
gs *regs, size_t frame_size,
>>>>=20
>>>>       /* This is the X/Open sanctioned signal stack switching.  */
>>>>       if (ka->sa.sa_flags & SA_ONSTACK) {
>>>> -               if (sas_ss_flags(sp) =3D=3D 0)
>>>> +               if (sas_ss_flags(sp) =3D=3D 0) {
>>>> +                       /* If the altstack might overflow, die with SI=
GSEGV: */
>>>> +                       if (!altstack_size_ok(current))
>>>> +                               return (void __user *)-1L;
>>>> +
>>>>                       sp =3D current->sas_ss_sp + current->sas_ss_size=
;
>>>> +               }
>>>=20
>>> A couple lines further down, we have this (since commit 14fc9fbc700d):
>>>=20
>>>       /*
>>>        * If we are on the alternate signal stack and would overflow it,=
 don't.
>>>        * Return an always-bogus address instead so we will die with SIG=
SEGV.
>>>        */
>>>       if (onsigstack && !likely(on_sig_stack(sp)))
>>>               return (void __user *)-1L;
>>>=20
>>> Is that not working?
>>=20
>> onsigstack is set at the beginning here. If a signal hits under normal s=
tack,
>> this flag is not set. Then it will miss the overflow.
>>=20
>> The added check allows to detect the sigaltstack overflow (always).
>=20
> Ah, I think I understand what you're trying to do. But wouldn't the
> better approach be to ensure that the existing on_sig_stack() check is
> also used if we just switched to the signal stack? Something like:
>=20
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index be0d7d4152ec..2f57842fb4d6 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -237,7 +237,7 @@ get_sigframe(struct k_sigaction *ka, struct
> pt_regs *regs, size_t frame_size,
>        unsigned long math_size =3D 0;
>        unsigned long sp =3D regs->sp;
>        unsigned long buf_fx =3D 0;
> -       int onsigstack =3D on_sig_stack(sp);
> +       bool onsigstack =3D on_sig_stack(sp);
>        int ret;
>=20
>        /* redzone */
> @@ -246,8 +246,10 @@ get_sigframe(struct k_sigaction *ka, struct
> pt_regs *regs, size_t frame_size,
>=20
>        /* This is the X/Open sanctioned signal stack switching.  */
>        if (ka->sa.sa_flags & SA_ONSTACK) {
> -               if (sas_ss_flags(sp) =3D=3D 0)
> +               if (sas_ss_flags(sp) =3D=3D 0) {
>                        sp =3D current->sas_ss_sp + current->sas_ss_size;
> +                       onsigstack =3D true;
> +               }
>        } else if (IS_ENABLED(CONFIG_X86_32) &&
>                   !onsigstack &&
>                   regs->ss !=3D __USER_DS &&

Yeah, but wouldn't it better to avoid overwriting user data if we can? The =
old
check raises segfault *after* overwritten.

The old check is still helpful to detect an overflow from the nested signal=
(s)
under sigaltstack.

Thanks,
Chang=
