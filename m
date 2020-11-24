Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8B52C2FE4
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 19:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbgKXSWR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 13:22:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:9921 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388355AbgKXSWO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 13:22:14 -0500
IronPort-SDR: XS0aYKAGaxp/D35u7SolClWmzqtzW15KJwhuUIqPjaHH2VS/RvxOtSxbqlsz5AL74BRco3V/4z
 orX5vuJp7nTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151253693"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="151253693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 10:22:12 -0800
IronPort-SDR: eezLHn3NioiOgNwEko23X+utuca9xyRQcs6MR+VbO8x9uK4nRbqHw2k48aYvKy6UIHKHV4IJ0t
 MMslYG/p8OYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="327668970"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2020 10:22:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 10:22:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Nov 2020 10:22:11 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 24 Nov 2020 10:22:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gge1Q1JpAloXOTIB+iw6E9n/EWmUNxNFo4ZlkOToStQqJRvKwIYiwfme+Dh9DgWgmVM4DxbmT4eV6NAJlFiLXQIP4B8wgWObbbv6OdYsmxVjIom0sepAEPSFdKxJ/Ll3A2wAi/VK1ksx5zZB6eMBGf7/kvThvJac7YyadDqQ/qUlB1cojatnpDF7Lp4GiW7SEYLQsf5v0CVAF5ghUKc12GgYNNLFPn9WT642BbfAppzg6wnGZdZ/6/15pFcmyD15MmXmQBgYl6eV5NXg4U8arzEQ1CszNqQu+6yd6a36mwxiY3/tJ0513oYN4RKecaOlalkcrLiPssja/PqkmxP1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve3d7BuSRXYV+O2XueI7T8Oiv21admzuD9utGgA/qes=;
 b=YhlIHXUAlyb/Bn4lmXIN2fFnEX8UYxioXTMa2OaCOp71ywwtoSVk5zalkE7aU6MiCKvOk/qle3L95kQIM3SvH+xFBDEumh1HuyvQYgcxebOi4yG6QJM+ol5WzNFfKSoPgeyRsLQuzzmOa/oxAhbgzAFak+Mx5idASNOHZP/gzuBXxCk0yww+w7qD92q4KMB2oKHnQalw3G7/k0h0TcL2GTSpcTyPFathuCSewzniEJ1p7UwtVgJhh3bwoYs7O5chE7J8vZPr+PhxCZQPi4mKuh6FU8HCBQBxl3KjjLMU20d9cu9e/zyXkOvHwoShKwjjMyo5NfkH1VKK9GPYQJEtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ve3d7BuSRXYV+O2XueI7T8Oiv21admzuD9utGgA/qes=;
 b=nfkgOHMr0rj2L4KmFnf9MFBxqrXSCchXn1WP1HdIoZR5PbglVVhZIxQ/TCs2HNT5IRbQe+Qwjk4/1dZ1Vy7b0WSfjRI8fqDT3IkTHpTOyOL4N/Rv13VE2w/YHZMOoIl3NddIDMPW5n6YOCBGsLwi/unSOKKOoU+9COCO6o8k4vk=
Received: from BY5PR11MB4056.namprd11.prod.outlook.com (2603:10b6:a03:18c::17)
 by BY5PR11MB4055.namprd11.prod.outlook.com (2603:10b6:a03:18b::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 24 Nov
 2020 18:22:06 +0000
Received: from BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a]) by BY5PR11MB4056.namprd11.prod.outlook.com
 ([fe80::a556:7843:c77:936a%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 18:22:06 +0000
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
        Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Topic: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
Thread-Index: AQHWvqcjVskyJoXuH0ORuPNb6HHBoanRpbwAgAX6YYA=
Date:   Tue, 24 Nov 2020 18:22:06 +0000
Message-ID: <B2D7D498-D118-447E-93C6-DB03D42CBA4E@intel.com>
References: <20201119190237.626-1-chang.seok.bae@intel.com>
 <20201119190237.626-4-chang.seok.bae@intel.com>
 <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
In-Reply-To: <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67e2d856-c909-434f-2983-08d890a5d9a5
x-ms-traffictypediagnostic: BY5PR11MB4055:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB405571781386DBF9A96776CBD8FB0@BY5PR11MB4055.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: No7zsjepreIkgKnyX29kIX7Auiyqwb4e9o2s0VSuVLYCUD/VwKB0/Pj7YsbxDQ/m6P04XPFssQdi4+I244X93/W+K0Xu+6Bo8aPKc6jbWGmdM54aa+8BMstc1yU5/sG4sT82o8YmaXarxOKZu8yKl9x51LP+Mf0TSL3kvujQ4dAm03nTl0wqFurSTJJsCNoRhvEqAnQwHzEHqNii+oZ+k8VCZrGtRQYFXzdfkyZX8s2Mq5W6rgpoopAv8I6joGErZCTxAr7PqGtp+JbpWbVLYhq2c6R6kVoiOCztvTu1FjsFGDGmbHU1qT/TdbZnW2OTpuZQcFK6kPVL4Gj5AmesbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4056.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(8676002)(33656002)(8936002)(6916009)(2616005)(86362001)(186003)(26005)(71200400001)(4326008)(2906002)(6506007)(53546011)(478600001)(5660300002)(66476007)(7416002)(6512007)(76116006)(6486002)(66556008)(66446008)(64756008)(66946007)(54906003)(83380400001)(316002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rlnnhFBcnz4dk2qlGDXB1Vj7hKddn5qbGdErPNC+xKKp+qtMxUnqK2zjeWhc?=
 =?us-ascii?Q?tEbJB+es3ea3DLoGsR0iXT0YQuoUcMQ16uuDo0JYu9YRdoiM0bPetQpKx4uc?=
 =?us-ascii?Q?iyZy5RjBz3+mU5v2tDAhSLjkp6Jwf+WXTR9nA8/dNup6oPf4631Xvq86M09V?=
 =?us-ascii?Q?zkPZmD1vvDU6lLPbAkSEBNGiT3SuljbuTomA+YTgjhUGOwl8IGjaytoTdTqH?=
 =?us-ascii?Q?FjJfye/Xqme1IvLwFFO0192UnmuLvbtww5ymLIdQsfbXwNWBsucDXQFHKQa7?=
 =?us-ascii?Q?mABrcUfVu31TeFmLIFWrMYD+iWUuoDroqzaenkRWzPXNsLUYtTUS8Fllu46s?=
 =?us-ascii?Q?5Y/iaWxz9UpvXk1VA/DXnEa03MjzxGEPGlswwTZcYl0ou0X2FpNnWFHXI/pg?=
 =?us-ascii?Q?hrlhuhgEFRhIYbUUEPzpCkAgUnJ9Z9L0B3p1fm4b4Ru3S2sObjOGbxPVdwb3?=
 =?us-ascii?Q?A0Et8iRymjyc8wr3VFujxF9U3jDD1o8E60WI8rXmc2KA2y9BYXzIfI8vebAo?=
 =?us-ascii?Q?vbyePcaiRUULWxZFcYxQiD6ORbGXSFE7x7apsCQKZTNWWltbaoJRFywuwxs+?=
 =?us-ascii?Q?fBCbAxyHQwnIkWj5+E6WFd84Rf0BH6KWbVNI8i+OqGmErwkiJ4U++g5WiXon?=
 =?us-ascii?Q?jKSvjC7ac9fV5coItlipYxaph2T/X8EpHgAksIQ+kCv8795Sf4bEmyhX1xXK?=
 =?us-ascii?Q?zt2CSYwJPqRCpIkAKYJ/j7xRdhzv+OtkWFwX/Ukx+Mbs+Azm3dzfjKOc1w5Y?=
 =?us-ascii?Q?fA0PZa+kKw+kBpv/8zfJh6O6rN4JK0oQ4lfkNG8QttQhjscsd2V9AqvC2TE8?=
 =?us-ascii?Q?igynHvml0F+PooKGSgb0n5wcVBsogUi07rYij20FjkMYzIVo5da9wNpv+J4O?=
 =?us-ascii?Q?7JNPVNo+3emmBkDm1Rx/7aOfC216XDwi945zqVhuYy/7wg37t8t/ZoedCqkd?=
 =?us-ascii?Q?PC8+8UnRwaGc0sWjqCHlca6OV1tAgYG960wMyZTT/Ur9KqrGKTJeZAGLco55?=
 =?us-ascii?Q?UUcb?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EA67DFB2AA0614093F2DC010C2F2956@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4056.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e2d856-c909-434f-2983-08d890a5d9a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 18:22:06.6469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V0GVc2M+2KRj1DPXKnw8ncplUmYb3luWhVj99dg8WQqypt5Xqk9QAWsm7nCLhOr6d1dYAln2KmKiIzl2RSNzMcLW0Siz3vtw8vE1j6Pg2M8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4055
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> On Nov 20, 2020, at 15:04, Jann Horn <jannh@google.com> wrote:
>=20
> On Thu, Nov 19, 2020 at 8:40 PM Chang S. Bae <chang.seok.bae@intel.com> w=
rote:
>>=20
>> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
>> index ee6f1ceaa7a2..cee41d684dc2 100644
>> --- a/arch/x86/kernel/signal.c
>> +++ b/arch/x86/kernel/signal.c
>> @@ -251,8 +251,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs=
 *regs, size_t frame_size,
>>=20
>>        /* This is the X/Open sanctioned signal stack switching.  */
>>        if (ka->sa.sa_flags & SA_ONSTACK) {
>> -               if (sas_ss_flags(sp) =3D=3D 0)
>> +               if (sas_ss_flags(sp) =3D=3D 0) {
>> +                       /* If the altstack might overflow, die with SIGS=
EGV: */
>> +                       if (!altstack_size_ok(current))
>> +                               return (void __user *)-1L;
>> +
>>                        sp =3D current->sas_ss_sp + current->sas_ss_size;
>> +               }
>=20
> A couple lines further down, we have this (since commit 14fc9fbc700d):
>=20
>        /*
>         * If we are on the alternate signal stack and would overflow it, =
don't.
>         * Return an always-bogus address instead so we will die with SIGS=
EGV.
>         */
>        if (onsigstack && !likely(on_sig_stack(sp)))
>                return (void __user *)-1L;
>=20
> Is that not working?

onsigstack is set at the beginning here. If a signal hits under normal stac=
k,
this flag is not set. Then it will miss the overflow.

The added check allows to detect the sigaltstack overflow (always).

Thanks,
Chang=
