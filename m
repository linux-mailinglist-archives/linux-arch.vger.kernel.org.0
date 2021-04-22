Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178BB3684DF
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhDVQca (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 12:32:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:47939 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236662AbhDVQca (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Apr 2021 12:32:30 -0400
IronPort-SDR: b0bpm16eB0ZsV71xFQXAs/A77KcUfaMDiEiQEDBBQ7QYdZrciFdnAXlNePXRtNXtB16e8ZuSRr
 BjF5EQGyLWQg==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="175406056"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="175406056"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 09:31:33 -0700
IronPort-SDR: hP6DLBZjceLWCEY2NyHaKjVYmUnp2KwsgKSM5EpC34kDiWmii6s8n8qGvSHyNYlYzgEj65Hwui
 fOXJjTMKholw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="421432775"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 22 Apr 2021 09:31:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 09:31:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 22 Apr 2021 09:31:32 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 22 Apr 2021 09:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrN72Htxe+u0VSOrwyXOFswWk7m9lPRTp/gXPEKsrC7mpDh7BhoqayKw4pEzmeXhoxcOHrcUUJNSHacjXw+8E1wb7VCO2Gpfdlh4Cv8Rt2UjWzbMascnwwHXM3KML56O8lweJ2e0FpxNIjir7dGH4BRVCAaY8lN/UpRomsivovZHOL5i6cF26t1kysmcWFzYLjPU4Xi+y6b5IH8spjysA/EVhHmkueDOIaWBYlJsKHzFHpFXnuGuhCRP4YOX/M3ywiZ70n+fIB8OjmKtLMfztn5gQ+49zdzFzhd7kqELtYWvh/fc/ufYkxyaiMIPMOmbb3S0J4G2mrWYUZ8naG4nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2z0kiawhcQYIOowgpDIFtUKOk0YF+McBLVtWnsl6f4=;
 b=oOIPmASxG05/V/uQaaeq0GgWfy5wSbeape7271cma7rKaNtO7b9SpyG4dZqf5TtZUnojJzDtr80tyiV1v0Smfk9KEO8TBVzsHiBoGSfW4e/MKR2UfsifN9Q44+HXTbyFncJW6gJLMMgz6Jv2ZZ6GEpZdDaWa4G2EQRTrBlhpUogZDDjJI725gnB+1tTpB5ZwkCiePnIHBA2trWQ3FgxSbtLcCPklbxVfFl30X757NiCpHINX8epovX0F5VhecBbnmWznCD4f88+/xUh/SUEvgfd/uE5nyOOKvfDh2uFRq7leJI31bdFJ42ZhfaWQtu4Ihu1sTyTvOE+euyeLorAgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2z0kiawhcQYIOowgpDIFtUKOk0YF+McBLVtWnsl6f4=;
 b=Gxdu83ycLk7h79roKRj1qjdN9IF8o2MB4OGpC2525P2Co+zrw02uPEhp9L3CRWXFB10uN9Urfb4jsM5Nwd+k6tRu9kH/cJwIdkxMi2CwUx2yYVtkSV14EL8T5PNkB/XUZij9szhzIiRmBOuSTK/fhgFRYI1DLeHxt+fTzgEAjQs=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 16:31:26 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::8878:2a72:7987:673%5]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 16:31:26 +0000
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
Thread-Index: AQHXNzOQXxUM6Mub30elxTKCBjQG3arAOYAAgACB+IA=
Date:   Thu, 22 Apr 2021 16:31:26 +0000
Message-ID: <9C452E66-0C41-462B-9971-56825444AD65@intel.com>
References: <20210422044856.27250-1-chang.seok.bae@intel.com>
 <20210422044856.27250-6-chang.seok.bae@intel.com>
 <854d6aefdf604b559e37e82669b5e67f@AcuMS.aculab.com>
In-Reply-To: <854d6aefdf604b559e37e82669b5e67f@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d1824b-59a5-4d8b-8915-08d905ac1320
x-ms-traffictypediagnostic: PH0PR11MB5159:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB515949A33A88C1DE294806DCD8469@PH0PR11MB5159.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOHan7eCQQtDCzHrjSNMwZm7CPIcAENnzkCVVLaAbqEUL3LpwcyfmEfLEKgl6QJU43XfeCkkev2Z0KsFwq5CqZpoUOGx1KgVpUiRF8C8NSWADwHaVI4Fkhu4aMsXmnPBQJOBdxuQhXgeFZfM1dbdVM9xX0eJWxPnb7Go8kFGbMUNdBi7dXno9Jo58jO41iDfg5e8CovzT+vrM2dnFObfwiUpArqbatvTnNedWk6wldyCiBlKcCx5huzgzHVl7cqJ+BlHjbnfTm+Yexc0Z8F+5FP4QbX8PIuSNgqTeQSMDwAk8PK/mIKfyI+mvix/BzLEifceWTDJ0Bl0oUz+gm6pDR8oqa/n+PVfD+ktSDfHUUIADQY1csqNen6OW2sB/D4Px+9tme+YtATyGLOf3ic4a1TTeyNTKufOnHyp1q/eQUn5rh+l7x1/+zdOnCPFwT3+HwDN0Hyca2zMpKOE4VfpLQQ0FOK0PC2sutaeD0qMANrmyF9W56l/dYZmS4bpEcb6ErAQithxVf5CWWWMKhh2IJhN3BxIfq8x11ZjSIrji6vjdE7nYfTRMoy7CIC2zmfQ5VmWjY/ovX2yX1ZYB5P/LbfHPSMrwU/1ZUaxpWUVpkOxvOtHOOFdTTOVLjIojuYl3vFgLILOZPz4DELu6OzG3NzPoDGxiigkJopIBKcJQHH9HIJ7T9E9lAUq0En3V/Nag7EuxTZBonntAcixageiJO150aC2bG8nMhSA4xtUlfCzX4xKnC2sB40bo5pjfSDg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(396003)(346002)(36756003)(2616005)(6916009)(71200400001)(478600001)(66446008)(66556008)(8936002)(966005)(38100700002)(2906002)(122000001)(66476007)(186003)(5660300002)(53546011)(26005)(6506007)(8676002)(86362001)(4326008)(33656002)(76116006)(64756008)(6486002)(7416002)(54906003)(83380400001)(316002)(6512007)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xTRKafSrXp7EIpE6Vu1HWYf4i/ujo5BqN+Ll7/uX92D5SadgZN2yemQXYNtA?=
 =?us-ascii?Q?XXec4xihQPDygUCyCxCIcs0E+x/ftg7K5KUJOIaJ+JRIg0mBFcdTn/eox4te?=
 =?us-ascii?Q?dECNgX4StgFELULVmVpKBpenwZ355uGJFy96mRt4I4uDXZFhGG6pNpqy9oDy?=
 =?us-ascii?Q?PJKyicMAvhngPPnygMK155JZGYGVIaAZcyu+hJxCQfqJq/vWvgeg43q76s//?=
 =?us-ascii?Q?cmUf8mgDT3PnhW6D4oX0QJOf3kfcABv6LlnZ72elNNobE+ZoeoT9metr/2vs?=
 =?us-ascii?Q?BorYO+lgMM8Qp/7OWMYll6ZSTVEOqhrTBhX+W/xCDojFADAQtSs7C9ps+ZrR?=
 =?us-ascii?Q?kKfOIZu5fTMS3ODhc2VAnUIST2kpdiZfZEm4kgL0e5wfKYIjg1AHk+veF7V0?=
 =?us-ascii?Q?uHZgmDgmLwIHDnpEZUNa0CCuX4JjO3Ybs5+GwH2aeMsiQdd+n6Nxq6DM4v5O?=
 =?us-ascii?Q?FB9DcOdOWdtqsCVaKi4QgdJRitYebKAfYU+DEBEg/bxLYOfSs/6RIaG2bTIb?=
 =?us-ascii?Q?KIBBYNRaWj2uULyJzEQEiyBLWnsrS4zvwJSng3/DgJB7zPHfZCfwV/lXwJ/w?=
 =?us-ascii?Q?9u4xwhXX4e3hN6Baf6117wXIdkWwpzdzzwOH0QT2flrohxypavRoc+bQQynD?=
 =?us-ascii?Q?8m0mxkH7Vi3o+qqBBCl6Zia73+8m/RY/hp5uvAVRI7gYei0+n6wToWEctB/J?=
 =?us-ascii?Q?q282zzoYQYBOZSiv7F+5XmWtZXAXK7pFyJyU/PiEreOige6ZfUzZc12Hj4oE?=
 =?us-ascii?Q?QId2r9V+6CvoB+fAAum1B9LGilY+l7LShUP7Mch3KYHfzYi8xWcpEAoTSJKX?=
 =?us-ascii?Q?ElPVWQVIu6Cso3cP5E5OTq810VVlCuEiOU15qFuiXvwfuFsJ+ysH/Wvw+erM?=
 =?us-ascii?Q?6XFKt1OW/iyrZtDTlfLcUbJ6k0zTpBOPyltJHzdWCFKFdYLheD/0LtNpoB5E?=
 =?us-ascii?Q?peVxRaskELfxwQ5YinZFH+KWzm1ioHSauoESgWuANJyJ8BQwRyRrhoLXm2z/?=
 =?us-ascii?Q?GAS5DuvY0tUsR8QkwwTzlXLUZVMpiVIasvzeBuToYxZ7ddzC4c868Pdeo4MF?=
 =?us-ascii?Q?Lp9Wn0DbN4FdB7KSjMi61EjKxq3UVmB0dg1SXKC9pt10IczIitc7xXdXAvk5?=
 =?us-ascii?Q?1Yz5qs6F5ukIRqciWW8fzTLcYmOkM90aRvp1KACDjdWIoi0X3AMgl5eq46NJ?=
 =?us-ascii?Q?FUK9HEXB1Ne9q05OsP83/hapjqE5epK7bjUPJkGBGcnvOr3VPiJcnsplAiKY?=
 =?us-ascii?Q?WCgd0ge/X8vc3w+XSghtyV9DfvqkAc6w7T90Y2ahxdYJ6k6x3BBlR7w6poEd?=
 =?us-ascii?Q?ZFv/JWpKqFhzMMI+qd4MEqWw?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D98A9DC7F23BCD4BB8AF09CC91F17005@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d1824b-59a5-4d8b-8915-08d905ac1320
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 16:31:26.0998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Becq6QPv7PxhFES/3IqJm6F2CwN33EvicbxqjR+KgSdHzQ0vthJui5+AzA4qmsl52LZRIunvYCGtEyM3qMPayWhVYi5xN9ox6bl7Nf1Kurk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5159
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Apr 22, 2021, at 01:46, David Laight <David.Laight@ACULAB.COM> wrote:
> From: Chang S. Bae
>> Sent: 22 April 2021 05:49
>>=20
>> The kernel pushes context on to the userspace stack to prepare for the
>> user's signal handler. When the user has supplied an alternate signal
>> stack, via sigaltstack(2), it is easy for the kernel to verify that the
>> stack size is sufficient for the current hardware context.
>>=20
>> Check if writing the hardware context to the alternate stack will exceed
>> it's size. If yes, then instead of corrupting user-data and proceeding w=
ith
>> the original signal handler, an immediate SIGSEGV signal is delivered.
>=20
> What happens if SIGSEGV is caught?

Boris pointed out the relevant notes before [1]. I think "unpredictable
results" is a somewhat vague statement but process termination is unavoidab=
le
in this situation.

In the thread [1], a new signal number was discussed for the signal deliver=
y
failure, but my takeaway is this SIGSEGV is still recognizable.

FWIW, Len summarized other possible approaches as well [2].

>> Refactor the stack pointer check code from on_sig_stack() and use the ne=
w
>> helper.
>>=20
>> While the kernel allows new source code to discover and use a sufficient
>> alternate signal stack size, this check is still necessary to protect
>> binaries with insufficient alternate signal stack size from data
>> corruption.
> ...
>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> index 3f6a0fcaa10c..ae60f838ebb9 100644
>> --- a/include/linux/sched/signal.h
>> +++ b/include/linux/sched/signal.h
>> @@ -537,6 +537,17 @@ static inline int kill_cad_pid(int sig, int priv)
>> #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
>> #define SEND_SIG_PRIV	((struct kernel_siginfo *) 1)
>>=20
>> +static inline int __on_sig_stack(unsigned long sp)
>> +{
>> +#ifdef CONFIG_STACK_GROWSUP
>> +	return sp >=3D current->sas_ss_sp &&
>> +		sp - current->sas_ss_sp < current->sas_ss_size;
>> +#else
>> +	return sp > current->sas_ss_sp &&
>> +		sp - current->sas_ss_sp <=3D current->sas_ss_size;
>> +#endif
>> +}
>> +
>=20
> Those don't look different enough.

The difference is on the SS_AUTODISARM flag check.  This refactoring was
suggested as on_sig_stack() brought confusion [3].

Thanks,
Chang

[1] https://lore.kernel.org/lkml/20210414120608.GE10709@zn.tnic/
[2] https://lore.kernel.org/lkml/CAJvTdKnpWL8y4N_BrCiK7fU0UXERwuuM8o84LUpp7=
Watxd8STw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/20210325212733.GC32296@zn.tnic/




