Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3460C334324
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 17:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhCJQfb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 11:35:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:63993 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231244AbhCJQfH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 11:35:07 -0500
IronPort-SDR: 0a7g/yUUiqNSI18eZZWFydZBwx85Npzk2y864Hj2p7HCZ/2fk19AAlmFFyLqIrpyaHI/7k/MSJ
 E7c48Snh9r4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="176103621"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="176103621"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:35:04 -0800
IronPort-SDR: ZbmO3y0S5l65g4+gRHRvfJDuNjd5srq/nFsDXV1WuClmXF0k0eCddQpOcAmoki540je7pQsLtM
 OBdOHPVPOvVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="403740705"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2021 08:35:01 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Mar 2021 08:35:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Mar 2021 08:35:01 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Mar 2021 08:34:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eu+X9cXQt/wnm1vDFTgJagQa93elVfgIHJEnn1Gvd+Q3nauTe5O8lMq16GqUtXZXdWo9kt21M4FocOfJ2Fj2wMcRuv3oHrBUBYVK27PKLX91Nde4T01GMtxoAg/BbP+wET3j8HAjN7jxQI9hTqCVPOMSlhAH/LCJN/VMnOc70cxxWR1O9ti8+A/8f0LGdUbDWqe/HTM2ifqus2XSY8tJBTeL2GNntMc7DUXKsLwe5cs0vS44uuHTwJGiqkjIlH4Sn3sVLyp3AG+paGr+ymGjWoWSHzYLwUdc+XHswbb8kwDdhl6NfSIYjKzl00c0vj93HDQvceVOru2uhdb2PIvRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDIXV5BL7Lk7haUOMLnZol97s4TKPUmq7rCcOp+u7dU=;
 b=Ur9xvD7q/jrYjM1GyedftutYi6Kohv3LSnsEfUmU73TNDwhCitTTyXjtH2tMiIQfmERN84BhxGlGmA3xWwmELYJBgGUQGHi5K/JAbX/HCGMm8kXTxu0N96pTamizcM5gfKgZbbSEacreskgTF1CBWIj8MGK4/U7nfsO5qW1xyGnROdvPdC11H5e7Tsnk8gFX17KV08bZjFyc3bJhclOE7NQC516yImccxNZgf99Cse550/xv2ETPM1K2J+wYTHh02hJ+mR8/VCoVFWBoqYa+zOrRfHb5//LMyUpFzgBuy2JcQXiNxBISh5a8XqjY30RqbMA0HjXeUcXugOlMGJfu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDIXV5BL7Lk7haUOMLnZol97s4TKPUmq7rCcOp+u7dU=;
 b=AkEeBYNriXFqxtqznfQWZAPrLO9+J1TW1aVEx5HDAj5PPEAVuxfqzF/obUhJbHdj2DegUJ6xhGWaUrQySOWRG08FrP3GbiFVg/F1Zp3PgG90F8zcfQ7PpR1b01SbPhlY/c3msZkinn/206Zgbon2ipE1DmAS/Rkdgvlj54JdPTw=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Wed, 10 Mar
 2021 16:34:40 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::78e6:b455:ce90:fcb0%6]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 16:34:40 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
Thread-Topic: [PATCH v6 3/6] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
Thread-Index: AQHXDSqN2pJXnno8/EOtP238eFt3R6p1PmiAgAg9ywA=
Date:   Wed, 10 Mar 2021 16:34:40 +0000
Message-ID: <F637CCE0-1744-478C-B2ED-65EA14B07938@intel.com>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
 <20210227165911.32757-4-chang.seok.bae@intel.com>
 <20210305104325.GA2896@zn.tnic>
In-Reply-To: <20210305104325.GA2896@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c86aed5d-523e-47aa-0edf-08d8e3e2673c
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4821AC4B4761D5AFB7785B5AD8919@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0yZkisxjFW8j2rbtaOMbXFtwFkIR9glMCGkASId6i0jZ2s4TfV3Gufun8EEDkDi7y6deNyKXzi03DecDPWuK2nDyqyi8JGZa7m9XcfpyFv+XHLsu1IvmFkJ0HAMHuL7SXNLD1XXmzrDzNn0c3Cweux8YxZubfXD3j6JvoJ9fr2q4B3iB4IAUb2ICjdwlUxcd8j+nK6QeLJrw5sQHciREuaQ6W0Fgkv2vynWqjWerF4g5dNP84SwWxbDNpERKjND9ebfJ/nz1u24Vzs2wU8NqH8q3jLBP++WH1qh6dCsnPLd5tvKJD7bccZmiL8AJclRRdHoIPPIqzF1YQNFdnCcybCDp9s8fuIlBnelTWfbZFsAwbbNf1Ke7XEqOUeXGd/DAEbjDeUJ5oFAd8x1xx/f9P4pPFNPmzySfdmUUU6kHwfGf22zYwRYuzoThpfj1QSD1ZeZYX8Vs1JyLvnoPwBNPgiU8ZNegof1EHiwF766V4zrFNeQubuR1R5x1DSD5PNxreQacm4cTeSb/ggvHNxH7Om3GLO49g5c6W/OkBriNS1tFVFKjMeWOMHicb5j8fPsknP5LFxUS/3NTAS33SQBRtwEis/pa/iEExHsDp2dri7rIG7YtvcV98x2ipv/pLFLvLN6jAQze8kbWl7Axv5KlBsqdTQNA+bOw62bYuoIvXs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(366004)(39860400002)(7416002)(2906002)(54906003)(316002)(33656002)(4326008)(36756003)(66476007)(5660300002)(66446008)(66556008)(53546011)(6916009)(6506007)(71200400001)(66946007)(478600001)(86362001)(966005)(6486002)(64756008)(76116006)(186003)(8676002)(8936002)(2616005)(26005)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?H3RTeYF8olZ+o/s2OBxSxuggJH5U2fbmuHP16anu+LS8BubFmpPh/jLZu+KV?=
 =?us-ascii?Q?8ViLvyTkycJFIkEIGuCUw68y5JUHalbotN7BfOWlLG8Iex5QHo67fJMdNJ1s?=
 =?us-ascii?Q?/nGKTd1znLBk52UrnPArH+g3gWLcENkVCxnfnxXQfq2YiLzYG+NlvOwrdglA?=
 =?us-ascii?Q?WlfUoQj3dJHXT0FtTeBwIHQsOuJGWWr192pACvAvZ01xW5aOSoT37jKYlNKE?=
 =?us-ascii?Q?e3IfPg0cxHNv4OTM0WClCOU2HQy4C5ntrj6Nh3dYycefiRl+oTPmBqDBfqHi?=
 =?us-ascii?Q?3QQXQtyuFAhaHYrs9KZrybhyM3x9Ip3Ays5jfwCbIkEAd69e3lLGjdGE/Vpe?=
 =?us-ascii?Q?4yQRk7O0Y+cPlJ++r9M1/QPeBjnxFDTBDf1SJyRJT/6ejs/a4zpLxLMqhzPc?=
 =?us-ascii?Q?+J+x2t0Zi88K0UcbaIACMtjcesY7Pg4oupdNaY9kDu6cyShItAsxFrpIXFef?=
 =?us-ascii?Q?WM2QKaZnf5WsJraeZgZU5l/zz3fsSD50pZj7t/+L0crPw7BA57oASRN1HlZA?=
 =?us-ascii?Q?v4Z21qBDwuy3REeaSocjp4UljSuhtlfHZiWDCf3u97SIC2PVUrZQ6QW3C/gE?=
 =?us-ascii?Q?QzN1W/iJl8uMN9/RahK6QZlCJHzJGM3re/4fh5g2UYm9LX2fk8Q0bs0DQIDS?=
 =?us-ascii?Q?N6B5iPmxSrMr0xDcw9xVeKscdcynzslqZ471SLwhqJsvGTuaMTitfy0OF5Xt?=
 =?us-ascii?Q?p3qsi34AhmL6TBtyspbiWnI/ljpK0/BgFr9kj1mW46GxUhCA7Wxym1f+Hu1K?=
 =?us-ascii?Q?npmZxM+0rao50cpODJHUHI1TTcjpcw4ytfGnpUbHxT3jjc/e+9SboGfon8Z3?=
 =?us-ascii?Q?5RBLSoZTmhiIhIIOoyBXU1zmZkw19/8h9ASJhc/ZnfaBayfuxW3HDZmUZa7P?=
 =?us-ascii?Q?McHm1OkwE470MfDCh5R5XwWVu69rjTVHFEyaKIT32+qS6BuMdHrYyII8aGNl?=
 =?us-ascii?Q?vnhkEhhZJpnC4feDeX/jOlNqia/a1kwrW1CfenFh1DMxWP8Qiw7PvbswgjaL?=
 =?us-ascii?Q?7bVjNJUpaZC8MlnePfnCkySLY0MYsIFhrqW2TBUPhReaavNe1kfIyleHrug3?=
 =?us-ascii?Q?56tZAs2g3ZaupWFZ5WzMuRTCZ6HJbhiR4VYmv3LPVT/UQEyAgJdw1r2gScpO?=
 =?us-ascii?Q?skuDCcR+xzJCLgsNG6KOmTOxvWA4AJelw1jvSsdm0Nq6qlt5W8hoYfW3G3kF?=
 =?us-ascii?Q?SH5OTy5WUo2aLv7dcGChd2BJeLj6hF0UgErlJI7DC5Wn5sZZOB8ml/ymsLDb?=
 =?us-ascii?Q?sO0JuXgChssMTqLWEtjNn66hv3q4qQSkaq2mKNLPJbZZsZW/wku1aJDx/qU9?=
 =?us-ascii?Q?DJqiRNMggoHwMF14Frbber6h?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <06DBA46FF2D5DB4084ABD13454D46EFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c86aed5d-523e-47aa-0edf-08d8e3e2673c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 16:34:40.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HC63dy7O3YcYgPf7fAcSIjxc2MnN12mq5aCrZl5bQdiJbGvmKeMe91dgZYIZL6peW0lGU6fsA1UtKwQHUqXCspB9m7MbtSM9m388HzU+07E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mar 5, 2021, at 02:43, Borislav Petkov <bp@suse.de> wrote:
> On Sat, Feb 27, 2021 at 08:59:08AM -0800, Chang S. Bae wrote:
>> Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
>> use by all architectures with sigaltstack(2). Over time, the hardware st=
ate
>> size grew, but these constants did not evolve. Today, literal use of the=
se
>> constants on several architectures may result in signal stack overflow, =
and
>> thus user data corruption.
>>=20
>> A few years ago, the ARM team addressed this issue by establishing
>> getauxval(AT_MINSIGSTKSZ). This enables the kernel to supply at runtime
>> value that is an appropriate replacement on the current and future
>> hardware.
>>=20
>> Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
>> added for ARM in commit 94b07c1f8c39 ("arm64: signal: Report signal fram=
e
>> size to userspace via auxv").
>>=20
>> Also, include a documentation to describe x86-specific auxiliary vectors=
.
>>=20
>> Reported-by: Florian Weimer <fweimer@redhat.com>
>> Fixes: c2bc11f10a39 ("x86, AVX-512: Enable AVX-512 States Context Switch=
")
>=20
> Right, so this has a Fixes: tag and points to bugzilla entry which talks
> about signal stack corruption with AVX-512F.
>=20
> But if this is going to be backported to stable, then the patch(es)
> should be minimal and not contain documentation. And if so, one will
> need all three to be backported, which means, a cc:stable should contain
> a comment explaining that.
>=20
> Or am I misreading and they should not need to be backported to stable
> because some <non-obvious reason>?
>=20
> Also, I'm not sure backporting a patch to stable which changes ABI is
> ok. It probably is but I don't know.
>=20
> So what's the deal here?

Yeah, right. While this attempts to fix the issue, it involves the ABI chan=
ge.
Len and I think PATCH5 [1] is rather a backport candidate as it gives a mor=
e
reasonable behavior.

At least, I can make a new patch for this documentation if you think it is =
the
right way.

> You also need:
>=20
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 4693e192b447..d58614d5cde6 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -35,3 +35,4 @@ x86-specific Documentation
>    sva
>    sgx
>    features
> +   elf_auxvec
>=20
> to add this to the TOC.

Ah, will do that.

>> +   #include <sys/auxv.h>
>> +   #include <elf.h>
>> +
>> +   #ifndef AT_MINSIGSTKSZ
>> +   #define AT_MINSIGSTKSZ	51
>> +   #endif
>> +
>> +   stack_t ss;
>> +   int err;
>> +
>> +   ss.ss_size =3D getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
>> +   ss.ss_sp =3D malloc(ss.ss_size);
>> +   ...
>> +
>> +   err =3D sigaltstack(&ss, NULL);
>> +   ...
>=20
> That source code needs some special markup to look like source code -
> currently, the result looks bad.

How about this code:

#include <sys/auxv.h>
#include <elf.h>
#include <signal.h>
#include <stdlib.h>
#include <assert.h>
#include <err.h>

#ifndef AT_MINSIGSTKSZ
#define AT_MINSIGSTKSZ	51
#endif

stack_t ss;

ss.ss_sp =3D malloc(ss.ss_size);
assert(ss.ss_sp);

ss.ss_size =3D getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
ss.ss_flags =3D 0;

if (sigaltstack(&ss, NULL))
	err(1, "sigaltstack");


>> +2. The exposed auxiliary vectors
>> +---------------------------------
>> +
>> +AT_SYSINFO
>> +    The entry point to the system call function the virtual Dynamic Sha=
red
>> +    Object (vDSO), not exported on 64-bit.
>=20
> I can't parse that sentence.
>=20
>> +
>> +AT_SYSINFO_EHDR
>> +    The start address of the page containing vDSO.
> 						^
> 						the
>> +
>> +AT_MINSIGSTKSZ
>> +    The minimum stack size required to deliver a signal. It is a calcul=
ated
>> +    sigframe size based on the largest possible user context. When prog=
rams
>> +    use sigaltstack() to provide alternate signal stack, that stack mus=
t be
>> +    at least the size to function properly on this hardware. Note that =
this
>> +    is a minimum of the kernel to correctly get to the signal handler.
>=20
> I get what this is trying to say but it reads weird. Simplify pls.
>=20
>> +    Additional space must be added to handle objects pushed onto the st=
ack
>> +    by the signal handlers, as well as for nested signal delivery.
>> +
>> +    The purpose of this parameter is to accommodate the different stack
>> +    sizes required by different hardware configuration. E.g., the x86
>> +    system supporting the Advanced Vector Extension needs at least 8KB =
more
>> +    than the one without it.
>=20
> That could be simplified too.

Rewrote like this:

AT_SYSINFO is used for locating the vsyscall entry point.  It is not export=
ed
on 64-bit mode.

AT_SYSINFO_EHDR is the start address of the page containing the vDSO.

AT_MINSIGSTKSZ denotes the minimum stack size required by the kernel to
deliver a signal to user-space.  AT_MINSIGSTKSZ comprehends the space consu=
med
by the kernel to accommodate the user context for the current hardware
configuration.  It does not comprehend subsequent user-space stack
consumption, which must be added by the user.  (e.g. Above, user-space adds
SIGSTKSZ to AT_MINSIGSTKSZ.)

>> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
>> index 66bdfe838d61..cd10795c178e 100644
>> --- a/arch/x86/include/asm/elf.h
>> +++ b/arch/x86/include/asm/elf.h
>> @@ -312,6 +312,7 @@ do {									\
>> 		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
>> 		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
>> 	}								\
>> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\
>=20
> Check vertical alignment of the '\'

Sorry, I will make sure this next time.

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20210227165911.32757-6-chang.seok.bae@inte=
l.com/


