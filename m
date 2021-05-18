Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5543881B7
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 22:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbhERUym (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 16:54:42 -0400
Received: from mga11.intel.com ([192.55.52.93]:6453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhERUyl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 16:54:41 -0400
IronPort-SDR: q+5ck90r3hzpehbfPhcMIHvkq3I8WzncprcLsh8c8zXFOQQGA/5c+eWJrgwbXOXvSXZDKBcjvd
 UlM3Ki5NwL1g==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="197727089"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="197727089"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:53:21 -0700
IronPort-SDR: sYxX/8uItS7xyvUr8JfpdoITo4dIFvVyLDb3ZfUcOfOIByx+OmyFkMqW/+VlXp8w3PXDUwbmZY
 AiKZGvR1ZgLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="395002795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2021 13:53:21 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 13:53:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 18 May 2021 13:53:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 18 May 2021 13:53:20 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 18 May 2021 13:53:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scoy6TQMVFUqL0bXuMid5EiIWIi2H8D702PDTKqsranQM8cwcxbVr5/cuq6rooNcVSWZJuAbAxJyCBI6K1Gi7qQ1bAXPntFbBaRm1tl6Heg4S51zfPN95VMIdfRKQAEzRaM6FLF7WtY2ouhWvVP7oDMcOQ7DkQCe92RMV0i0d9dUH4bUtkszu2rcx0viatskvHFfKhE+jFx97MgIs4gBzjxSaiL/khj8K5SL/6ENwD1kxMa3zNcNOByCFMbWhwmjH5jOQ+2rYBRH0ODqMYSDjdqxDG4BWbt2KQre4Y9z0vNaS/d+XQcp3SFELVym9eo/fYS8A9VmpWACxj2Z/Bc5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHfY/04r9jzq0Ip+Kme61KuCPHsMTklPY22NxOwdVX4=;
 b=YV7zZk3lYBtpjHQn8Awzvvo60B6vXvw5vp3vx+gRNnteKpESKoUyk7Bvbmrs/5edPNKhZbo2sYFepGfxk2to44T2KHQLJbs10+C0NMyVpzGAdGxj8feOtvBt7WUNwOtl9zijpHqPtNby+er5RX5u0nyAP3beYgq1c3wamkFgjEe9ihyWEUY2fOyE7Fo9jIPJ8YYYOs/9DcQLNttJt6BXkIMyIWT650V5up3HUmd3GSRwQmByB/V9zTHyIRbb4uBIuz4nnpZrLt4ujGvkFV+HNlxfBinF0AcfFWXbBbHMqxdJTmtlOVqbP/IMl5unyo+I5GyIseoI3V6/aYBhT0fkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHfY/04r9jzq0Ip+Kme61KuCPHsMTklPY22NxOwdVX4=;
 b=rD7OLiAbYCTKztmk9JuyUKX7oUEJsUbC4qGP9Z1So7+XFSL33nGT3HQ++89pNbK0tgaSwSetagQDGJkjR3tWmHV3lZ0/iTaK7z+fCVIif8skugtG4vH2gwAo+tZodWmWS5Zlu01Z0/u0GfaPeHRXHHyBhmkLlQAp7l/o96w6keU=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Tue, 18 May
 2021 20:53:18 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673%5]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 20:53:18 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     "bp@suse.de" <bp@suse.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "jannh@google.com" <jannh@google.com>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
Thread-Topic: [PATCH v8 5/6] x86/signal: Detect and prevent an alternate
 signal stack overflow
Thread-Index: AQHXNzOQXxUM6Mub30elxTKCBjQG3arAOYAAgACB+ICAAFz1gIAoyMgA
Date:   Tue, 18 May 2021 20:53:18 +0000
Message-ID: <8933FF62-4AE9-44E7-8A05-ACA5A91BBE28@intel.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-6-chang.seok.bae@intel.com>
 <854d6aefdf604b559e37e82669b5e67f@AcuMS.aculab.com>
 <9C452E66-0C41-462B-9971-56825444AD65@intel.com>
 <1955da4c211f4d4fbbf74a6b8bdae0f6@AcuMS.aculab.com>
In-Reply-To: <1955da4c211f4d4fbbf74a6b8bdae0f6@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea27a03d-8821-413e-f40a-08d91a3ef714
x-ms-traffictypediagnostic: PH0PR11MB5030:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB503052C9202F402CDD061C7DD82C9@PH0PR11MB5030.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBAe3GVbso8EPClMRU2lAHHCSyOxNLkl7NJIozLAYCrz8yt/OXZ/+m/RBhK/60LDtPedwSEwre6nASGBk4JRDGt8tRmOxXTzxeppEiMWHJYpnxff8/C7KNCZDyeS7ymMkUzTn7J5hEm8IRNaPST8zCNJQaeY9/MR/MDO/DCTgeUqx+E/J2brGtgOX0vhlVKqYLvnKqI9fem2/Gkr5N5O60C2mobwK4UrX/Gp3zMgTcko72cALvMAAI2/cmGDCEY6AqjNdQJ8zKp6B23oNLWYE0jhFWB2sWLbNpMs7g09m7m1+6PPr+9gc4ub5aUu3ZYMiMmBdld2Hy50wqnbLdRfCQB5LHc+o//gw3g1KUtRzqBn1lMe70BTWupuDT1IbvfAgbVJyBHu1uSeq4cYOW+K/Q7wHoG5i1B6wYTzwvxAZPM92QHUUi5s8dQFZwBz5Wv5GNIHUVrVS1FRW++LSHeTevRhkw8Ddt2Ecy7xbpA0mSvBUSR8qOayEFETSv+uxO/5Xapyhder/DxUHOIovQyJI1/hLFQBBMEwGAHoRNestygyfkpPjSGE5Lclv/mmxYb4Ivbjzpsuw0H/ScNtSknXrkol62h5PT8j3ycGZ90W2ChRbEOdniHESUZWL1BqkFDqfYKx2HggFT5R9Y+m/YFKb3u0sSiiYb9pwhfRS/RI4lk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(66476007)(86362001)(66946007)(7416002)(8676002)(64756008)(66446008)(76116006)(66556008)(6512007)(38100700002)(5660300002)(8936002)(33656002)(316002)(2906002)(6916009)(186003)(6486002)(36756003)(4326008)(478600001)(26005)(6506007)(54906003)(53546011)(71200400001)(2616005)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NlX9xzeuhMoFW3i31iOg1LQNIL+iOV0cA6G8oOXDTGNn9ib8wI0FBa1rPvMI?=
 =?us-ascii?Q?oiqMXm5PSSu+waEJTbVdyxZsgJ4KIVQs+iZiE5pM4WzKXlMBSDsTUzqf5wXN?=
 =?us-ascii?Q?771eD+JmJ9sCTAKvPinXgEsT/vaPh/YM+b5HZnX4C/aAW+vpilV8K3MAkoFh?=
 =?us-ascii?Q?VFiWhST9mxt1+jamC4Ki28ATilwYjICLrnP8p0OTjmnVr1rwanKRxRh6bZs0?=
 =?us-ascii?Q?dAe4vFOyETODMjHOuwev4Ltqh08rOuKxLUVRSo1XspYgMdAN3Xh7xPajU5ks?=
 =?us-ascii?Q?g2VUMMT2G53y4tR7cPae2yYqSrN6GpMpf362ltgCQwu58uhphb1q8KMJLi1F?=
 =?us-ascii?Q?7itrdxlbD9LFqSWj3MfNRAOVTVRLkjaiPfdz9duA0nltk43EJwcbTHD32lX9?=
 =?us-ascii?Q?tE2jJfMLaHmprM8+r2W5fIsiSpCTzeklu0lQf2XvKD3G0GaOx1OtKq+SyKyL?=
 =?us-ascii?Q?crEwIkmu+ZxQLbuX5zKlWyCNBbCerzrptmOWuy/waCrwgFMnuYD7/afQQ1Ml?=
 =?us-ascii?Q?owh2htgznQb6naZP0PLBrU27i3Eei+OCYAT6WTdkl1Kc9p370ovtv16mGYWR?=
 =?us-ascii?Q?jkBluIbsLF8JqwRWfjRomZ7IvwBzxQnCvsJowG7ZPHrSSQgerwBkGK86BWgS?=
 =?us-ascii?Q?1LaVmY75fVMbZPI7KRj1wSNdF4hkef/P4KWm8Q7qCU0/EfokLUxoXLs3wWnn?=
 =?us-ascii?Q?vzvIPE00iT0HQ6VhJp9tL75dsOUvZljiImrJ65yqNJUCOFmTm2EYd/A9rAiV?=
 =?us-ascii?Q?xmRnW7I6pg8+ehtMx4O6i7l4PzTBc7lF3nRRlclWfOdKIMFDBX3aasODNwaY?=
 =?us-ascii?Q?GnQL2MeE0civt89UeEtQviYb0A1aSmK2+2e6zpJOdpxvFg0TGK+NgZ5tttLH?=
 =?us-ascii?Q?aNPKlvySBGo0OdxvPR/JZZapJoXlMFAG8suISKGsnNy+AhjuQFPlFyqPwA82?=
 =?us-ascii?Q?kyJQganGRDb3KunlJMgwjaqyYn01zhD/p5Vcv6E2oepeOWRwzqUZYMQXBl3S?=
 =?us-ascii?Q?1Dw8XUxMyr+HupCVnk+GpRuwyzMhS3Mr+lo5Mqd6zOTC+cbfbE6o7yciei2v?=
 =?us-ascii?Q?bBn0EoO8ItAn83oJILri/zZvvac1MHvIqkD6YPafdnnB+RtDriZgPdO5RIrK?=
 =?us-ascii?Q?BZZLRaTX1WsSObdJp+NxywXROHwEndNoyp2aKKfv/xBqvXNnwCELkBmsjL5j?=
 =?us-ascii?Q?iBpIwHwKwZvjstE0Oik30tY6uTeo47hvBFhPj3HRtCxVrO8WUb/AVswP6cc8?=
 =?us-ascii?Q?zLJktetdJpqUr8amilsgcwXVRqwFCp981wsj2Qsx6dU/XpwzPwvuTPPYWaSD?=
 =?us-ascii?Q?8bKZP0LCxQrw7yE0E3+4QgNd?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33F9D2DE9AE84348923B5B12F8D7DC0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea27a03d-8821-413e-f40a-08d91a3ef714
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 20:53:18.3493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFBHYrWCT3KwCIK5GJDLSEL7Q8gZh1xAj6bjr5ga7C4WkAl95ud7lU9U+u3auE8cIGhWzBJimtfPEHVz9+L2s8KKHiyEZIri+QbnB8CDczI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Apr 22, 2021, at 15:04, David Laight <David.Laight@ACULAB.COM> wrote:
> From: Bae, Chang Seok Sent: 22 April 2021 17:31
>>=20
>> On Apr 22, 2021, at 01:46, David Laight <David.Laight@ACULAB.COM> wrote:
>>> From: Chang S. Bae Sent: 22 April 2021 05:49
>>>>=20
>>>>=20
>>>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal=
.h
>>>> index 3f6a0fcaa10c..ae60f838ebb9 100644
>>>> --- a/include/linux/sched/signal.h
>>>> +++ b/include/linux/sched/signal.h
>>>> @@ -537,6 +537,17 @@ static inline int kill_cad_pid(int sig, int priv)
>>>> #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
>>>> #define SEND_SIG_PRIV	((struct kernel_siginfo *) 1)
>>>>=20
>>>> +static inline int __on_sig_stack(unsigned long sp)
>>>> +{
>>>> +#ifdef CONFIG_STACK_GROWSUP
>>>> +	return sp >=3D current->sas_ss_sp &&
>>>> +		sp - current->sas_ss_sp < current->sas_ss_size;
>>>> +#else
>>>> +	return sp > current->sas_ss_sp &&
>>>> +		sp - current->sas_ss_sp <=3D current->sas_ss_size;
>>>> +#endif
>>>> +}
>>>> +
>>>=20
>>> Those don't look different enough.
>>=20
>> The difference is on the SS_AUTODISARM flag check.  This refactoring was
>> suggested as on_sig_stack() brought confusion [3].
>=20
> I was just confused by the #ifdef.
> Whether %sp points to the last item or the next space is actually
> independent of the stack direction.
> A stack might usually use pre-decrement and post-increment but it
> doesn't have to.
> The stack pointer can't be right at one end of the alt-stack
> area (because that is the address you'd use when you switch to it),
> and if you are any where near the other end you are hosed.
> So a common test:
> 	return (unsigned long)(sp - current->sas_ss_sp) < current->sas_ss_size;
> will always work.
>=20
> It isn't as though the stack pointer should be anywhere else
> other than the 'real' thread stack.

Thanks for the suggestion. Yes, this hunk can be made better like that. But=
 I
would make this change as pure refactoring. Perhaps, follow up after this
series.

Chang


