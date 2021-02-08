Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E99314084
	for <lists+linux-arch@lfdr.de>; Mon,  8 Feb 2021 21:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhBHUap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Feb 2021 15:30:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:30752 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236842AbhBHUag (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 8 Feb 2021 15:30:36 -0500
IronPort-SDR: olbiQ4eTQ5q2KCozq5WRAzhNzQkuRS4Ms+QZkzyDTdbe+265WzQTzDp8ZQnje1aklAoAhc9jsG
 0pc+Xs1K5zXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="160931003"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="160931003"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 12:29:54 -0800
IronPort-SDR: xI3AtQtotIwi0/0FtdfX4vDXZQimvtD4pivPRKOCtKqDWUx2nANuCh35IK4RhE9gb/AaBe4VgU
 iabOwTuuoldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="398530243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 08 Feb 2021 12:29:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Feb 2021 12:29:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 8 Feb 2021 12:29:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 8 Feb 2021 12:29:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNsZuOSGvrg9sg8P/rOdG9oi2rF4mfaAgMmhgYbSulfRlxxQVj+CtJClp3b9NOilbfqvuyYPsWXLBgIkNtAXG9YUhIftLpfChkVWSenG+/sJQ0M1QTju2fTFnWV8+vGc8RKiwjcIbKYtvhMDP+B5Eh4cBc8JR5a6OIhxs7MhRIUd1Q74R0/2qbR/RglPei6nZJdeKC/2lkeGByo7m3NMAoxUv8z0/oJgDSIWmYDnSl9uwQpnH8F/ILB6Qv7KAc8+vkZwkwwbJp01m739mWViy0ZVpLoS56dq3N8D4juYpMaPrn3QtVNrAUgp/bibezwMR1zubc8vi8Sd427AVTwevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT8tN+LgwnZ7BQyT5E0gIoj78HvjjWI9d9cRIzwQoEM=;
 b=LnYEP9wl33nfvG2MT2jvxZDpL1epg72zongjGZ7dKAWOytNLkouD/jwU9CD2yyWYY2MOhTO+vao1qt8KATxZDkKF6mgwolHsKh8pB7miMPnJnGfCxdAqGKcAw6RMDKfDYNgIj5rdo1kU02wOkBiFZj09TtNUOspmc8U+x5geE0mQbrt2A9TuDxW3NYEovVQKVCNbUzdIViefeme8OV/Maaci5PSR0MmpXrJWa6BlzB+ABKezekSF6F0UdmwkCD5laAxXN0gohg46iVszSi2h5HIyTJ/ILNEQSbilS/koPrLemKwPQhpUJ4fdKjgoP3xti11DKxU12IaIM7jBDeFxRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT8tN+LgwnZ7BQyT5E0gIoj78HvjjWI9d9cRIzwQoEM=;
 b=CgB/rZP3LDlaHcm8RuivTTpQA0zn5VruuphQIPm0LYRkY43eKo+34RQkToXQ1Q0iZDCVA4yxkwLXEr3lzjNWitPhkJRAskviJ5FLKOo3bWTNFcOmXj8PmkLtlZJokbpwcRb6oqErpQ0HPrrvggtzj7eqwHEEg3nlbOElsqXPoKc=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Mon, 8 Feb
 2021 20:29:51 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 20:29:51 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Jann Horn <jannh@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "Dave Martin" <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "kernel list" <linux-kernel@vger.kernel.org>,
        Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>,
        Roland McGrath <roland@redhat.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Topic: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Index: AQHWvqcjVskyJoXuH0ORuPNb6HHBoanRpbwAgAX6YYCAAAWAAIB3j2EA
Date:   Mon, 8 Feb 2021 20:29:50 +0000
Message-ID: <81DF502F-9327-4365-AD17-21CFAE94ED0B@intel.com>
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
x-ms-office365-filtering-correlation-id: f5f4a5bd-0bd0-41cd-f81c-08d8cc70493d
x-ms-traffictypediagnostic: PH0PR11MB4967:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4967EFCD77418CBB09AAA6C5D88F9@PH0PR11MB4967.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnbaaPXnE8N00PwIYLLrSKLbDMLJQPD0WRLftadbI9aGvRjN6lPPkadL0lCu+FCnp21d2b1AVBSFugab2rr1aj2BlU3PWJtLW6neYvUiSQCSYEx4jhtnZpQWCTist+p6ok8BUrF/DcjJskyqayk9OSbOqlqi2udf7Q9jpR8jVdGKGJul5bVLbuqLZe0vsreVN2CyW76lSeRPQbCjSM8oJ6TKDgx2wsNGZaT+kFjZ+sZCnG4dKD0yGWIW9FWXgZFghA2wDNSLQpn5qe9xCm19Xt17UZDt19WiLP3q9gk5E2D6+rO0om9jcvdSCJCj+4jEJhra3U68WMxeqe4JC/23pZRd4bLePMY/F0X1XOU6uAfyjbqwHU6hxqbCwlk9RTu2WPAYuyK2S6ed8skkLiDZp3aevS1IMacdfc0zl+xHbufrVrYwslh5+zXgKtdVEgap4yebzhIpAkjlujKzvvLUvQeynGkBk98LFMYNTczNAV8CEzyCNzhy/kTlAt2lhVzbIg9WMS2D1i7xKN8DIcrRWQL2pUqvCq8a6eIyeyN1BGVGJoqGPVAHg5hJ5bs/cqyS+iBzJh7936Ecv7Q78fxLpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(66556008)(2616005)(64756008)(66476007)(66946007)(36756003)(8936002)(6506007)(76116006)(66446008)(186003)(26005)(53546011)(33656002)(5660300002)(91956017)(316002)(478600001)(83380400001)(54906003)(71200400001)(6486002)(4326008)(6512007)(8676002)(7416002)(6916009)(2906002)(86362001)(107886003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XQvfWYrtbyvdX8/o1vu7Up/XJLTgoYNeB3guXtS6sy66o8rsoopfEuK/SH2W?=
 =?us-ascii?Q?r4Pgp+Bup+FK61x6fQQGwA7tnEBRHnFyUUAgMb6kMC+mNgtAibEEdlLKKtau?=
 =?us-ascii?Q?ciOjjhwzacpfgBQocwo7MjfVH8ya4PzZjUqxISJFuseIfOmF7aLlGt4OViOc?=
 =?us-ascii?Q?KNg/WsGaXc8FNANYYmzlW7GKMYBAbsVpS8lrBMFov/YTyrxSPmF6wX/iJneC?=
 =?us-ascii?Q?SrFOrhHWpQ1bABuqrE/iInE0xlkqN7nDlfnKgTFTzolOa842mjKcd6rUgsx6?=
 =?us-ascii?Q?USlV7AkGxKRfqAd+GlcCjPdzSkvfBwshWA1WLqmfPRqVB6NjZaL0cSDFX6qR?=
 =?us-ascii?Q?i6CzF9ij4LDNQMmbn6M2nPK/YxzwI8Mq7zlc6WM0OCEqn4tBlCRTH9S5ov/R?=
 =?us-ascii?Q?yaweqNZpgPh1ypGUPD3xb4Yt1qEUpAZy2BdXl0AHy3rHzsdy1ByKUlJt5+3t?=
 =?us-ascii?Q?yuJ2UX0dUtGJz6OsXvc7r93pU/B1fYfJafpIKisAyRTjzlCS20WilAvAqclf?=
 =?us-ascii?Q?UBsYIpTHEFl5oU4xxptAdTpLNgosPRnjoWMfhAanqdJl9DgF6Iy8zsGqwSmQ?=
 =?us-ascii?Q?Kz+F08o9HD5AEPvymaSw/PP05NwwE2emNe2AgCVP+w+havpczu4zq2lH3Nmb?=
 =?us-ascii?Q?PAd6YupdRG9j23Xq53GpANgVNZu2YnUI7VIo27GN9g6bDqDzaFpZ3uQaRjwQ?=
 =?us-ascii?Q?2Y6ENy2Xm/Zfz1QaHE6vD8bR7SxnKO7g1NdvlHFJyFMP+WyrftUASSeRDktr?=
 =?us-ascii?Q?NbDlFHRC36gmRBlIeLdQiqHMrpQdjt4tYpNfFm8Rdw+k1/bV+ah+nKc5HTdu?=
 =?us-ascii?Q?ayulKoqxji8AEV3iHQqLLdX2uQuG7Sc6QX/FNKpS+SETgusUW7vK02hTLUEn?=
 =?us-ascii?Q?RfcvHe/6GRjFttbIFlvhJ9DyULDKdc/pBJ7Dj2PRZJw05vNc0j1d5JdQyZNG?=
 =?us-ascii?Q?G8yWnSQ0AEz2HLTeEAcET+ojCHSme+sOzf4rvmvmpYUL+4WeQxh6We4nfV0s?=
 =?us-ascii?Q?1C/000kyJnhbQq1yNvnE9jIyoCxINTEUI4c2twIPRVf781N97w3I6ZY34juq?=
 =?us-ascii?Q?z7+nIPFuPb7H73pBL/mrUXm3EbCZ2R1/1QgMlVp0gxTCuHZa6gO9jF962BWe?=
 =?us-ascii?Q?nUEowFxFwPk+C3h56HEf9hyrQFdVOxpvth4sIQevw5pcQ6wJFBCHmaYiEw2J?=
 =?us-ascii?Q?2oqIrFjjBYgLj6umdj3hiHM2XACS/fsMrzqmb2PUaDiRa8YAc5g3AKgDYe0p?=
 =?us-ascii?Q?5v2K1flVNCnonT/bpFF7qyujKkCiVvk2KlKLlv7imlohAm/OlZJLvc6GVJrT?=
 =?us-ascii?Q?tOkzjsDIpWh36gz9MdnrxhfN?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <393536D3FB7EA04EAF6ADF503A496856@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f4a5bd-0bd0-41cd-f81c-08d8cc70493d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 20:29:50.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsX7rN4jy8Jq/dtvVLwym70CGYyneEYlTt7lSncXC9w3A/N6wBm58SuY/0E7Aosqsm8ICx1xLzXLI4Tmv/eQ8HkhXTpq0hUUcA2R80OTYWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Nov 24, 2020, at 10:41, Jann Horn <jannh@google.com> wrote:
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

FWIW, here.=20

Thanks to the report by Oliver via the kernel test robot, I realized that
this needs to be conditional on the SS_AUTODISARM tag like, :

    onsigstack =3D !(current->sas_ss_flags & SS_AUTODISARM);

Thanks,
Chang=
