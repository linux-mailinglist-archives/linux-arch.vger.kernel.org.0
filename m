Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40EBE28241
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbfEWQND (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 12:13:03 -0400
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:39480
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730782AbfEWQND (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 12:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0+os/sdMMXz7DI3IasTQ/bX6qmv//gAQT6tXiuRggI=;
 b=TI/RCTTwk/erlf+r9ZDvEXAgbP0TM7Yiy18Xl/4priFSAR4PyUy/o0XjsrH88xVHBVta5YDhWLCrLLr9fS+enrukq3onMmKiamGt+bmd43SCb1N843UvlBiQmJ2y9KYmO+tvTCgyXQ/YxywrbfNjA78Jp6DhPJqjzYj0za+SWfA=
Received: from VE1PR08MB4847.eurprd08.prod.outlook.com (10.255.113.87) by
 VE1PR08MB4847.eurprd08.prod.outlook.com (10.255.113.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 23 May 2019 16:12:59 +0000
Received: from VE1PR08MB4847.eurprd08.prod.outlook.com
 ([fe80::1534:1364:767d:777b]) by VE1PR08MB4847.eurprd08.prod.outlook.com
 ([fe80::1534:1364:767d:777b%2]) with mapi id 15.20.1900.010; Thu, 23 May 2019
 16:12:59 +0000
From:   Dave P Martin <Dave.Martin@arm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        James Morse <James.Morse@arm.com>,
        Will Deacon <Will.Deacon@arm.com>
Subject: Re: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not
 force_sig_fault for SIGKILL
Thread-Topic: [REVIEW][PATCH 03/26] signal/arm64: Use force_sig not
 force_sig_fault for SIGKILL
Thread-Index: AQHVEQAmROT4Tsc0Y02QCkja63yvnaZ4kTWAgAA7TwyAABY/AA==
Date:   Thu, 23 May 2019 16:12:59 +0000
Message-ID: <20190523161256.GF2019@e103592.cambridge.arm.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
 <20190523003916.20726-4-ebiederm@xmission.com>
 <20190523102101.GW28398@e103592.cambridge.arm.com>
 <87r28pgr3h.fsf@xmission.com>
In-Reply-To: <87r28pgr3h.fsf@xmission.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.5.23 (2014-03-12)
x-originating-ip: [217.140.106.49]
x-clientproxiedby: LO2P265CA0455.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::35) To VE1PR08MB4847.eurprd08.prod.outlook.com
 (2603:10a6:802:a6::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dave.Martin@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fb12db9-812e-4730-b50b-08d6df9985d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4847;
x-ms-traffictypediagnostic: VE1PR08MB4847:
x-microsoft-antispam-prvs: <VE1PR08MB4847009B5BB40B6DE42670A1FE010@VE1PR08MB4847.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(40434004)(199004)(189003)(386003)(66476007)(73956011)(7736002)(102836004)(6506007)(5024004)(14444005)(229853002)(66946007)(64756008)(305945005)(68736007)(66556008)(26005)(6916009)(186003)(316002)(81156014)(66446008)(256004)(3846002)(86362001)(2906002)(81166006)(8676002)(52116002)(6436002)(6116002)(99286004)(66066001)(58126008)(76176011)(54906003)(6486002)(33656002)(25786009)(71200400001)(71190400001)(11346002)(1076003)(72206003)(4326008)(8936002)(478600001)(53936002)(486006)(5660300002)(446003)(6512007)(14454004)(476003)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4847;H:VE1PR08MB4847.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qnNJ8qDxcRqGVsUixjKvKgHaLdkkdlhhuC0RTafqhEfARbN2TTpa+zn/+u/v3Mb3+jImqirypD5wrY/axlg8wcAHZw6IVw8WzpMob91VHyW0IZMHlCHoZuH4fCTtxxWlZO1UWriDqC4vkGQqkb8Sy8t2j7orts9Q6PTRUOF9EshJbH61UaEP4YO7RJxVevAxh+rPIQehcUPJEXp//pGn/U7YL+XYxiWVR9Ju2gas49e8zskZhjnm6363m5Oey2MCxg7NzoghkClzc8R62pJj+8xdeEUInLwLbGw2CvGAdTWQ+e3U9oMwZbOR0dwm79d0fAfjVSh1H7zTtmpUzBtVkg/4dbGqX/olQT89SDVZNUaDLjAoD3q+2874QcF2s9+e5V0LWWigQyztZcFhF7KKv5lGAM+3wDsSXi2IQhH3t1Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B48C8992B857004B8A071824B809E7D6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb12db9-812e-4730-b50b-08d6df9985d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 16:12:59.0689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4847
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 23, 2019 at 03:53:06PM +0100, Eric W. Biederman wrote:
> Dave Martin <Dave.Martin@arm.com> writes:
>
> > On Thu, May 23, 2019 at 01:38:53AM +0100, Eric W. Biederman wrote:
> >> It really only matters to debuggers but the SIGKILL does not have any
> >> si_codes that use the fault member of the siginfo union.  Correct this
> >> the simple way and call force_sig instead of force_sig_fault when the
> >> signal is SIGKILL.
> >
> > I haven't fully understood the context for this, but why does it matter
> > what's in siginfo for SIGKILL?  My understanding is that userspace
> > (including ptrace) never gets to see it anyway for the SIGKILL case.
>
> Yes.  In practice I think it would take tracing or something very
> exotic to notice anything going wrong because the task will be killed.
>
> > Here it feels like SIGKILL is logically a synchronous, thread-targeted
> > fault: we must ensure that no subsequent insn in current executes (just
> > like other fault signal).  In this case, I thought we fall back to
> > SIGKILL not because there is no fault, but because we failed to
> > properly diagnose or report the type of fault that occurred.
> >
> > So maybe handling it consistently with other faults signals makes
> > sense.  The fact that delivery of this signal destroys the process
> > before anyone can look at the resulting siginfo feels like a
> > side-effect rather than something obviously wrong.
> >
> > The siginfo is potentially useful diagnostic information, that we could
> > subsequently provide a means to access post-mortem.
> >
> > I just dived in on this single patch, so I may be missing something mor=
e
> > fundamental, or just being pedantic...
>
> Not really.  I was working on another cleanup and this usage of SIGKILL
> came up.
>
> A synchronous thread synchronous fault gets us as far as the forc_sig
> family of functions.  That only leaves the question of which union
> member in struct siginfo we are using.  The union members are _kill,
> _fault, _timer, _rt, _sigchld, _sigfault, _sigpoll, and _sigsys.
>
> As it has prove quite error prone for people to fill out struct siginfo
> in the past by hand, I have provided a couple of helper functions for
> the common cases that come up such as: force_sig_fault,
> force_sig_mceerr, force_sig_bnderr, force_sig_pkuerr.  Each of those
> helper functions takes the information needed to fill out the union
> member of struct siginfo that kind of fault corresponds to.
>
> For the SIGKILL case the only si_code I see being passed SI_KERNEL.
> The SI_KERNEL si_code corresponds to the _kill union member while
> force_sig_fault fills in fields for the _fault union member.
>
> Because of the mismatch of which union member SIGKILL should be using
> and the union member force_sig_fault applies alarm bells ring in my head
> when I read the current arm64 kernel code.  Somewhat doubly so because
> the other fields in passed to force_sig_fault appear to be somewhat
> random when SIGKILL is the signal.
>
> So I figured let's preserve the usage of SIGKILL as a synchronous
> exception.  That seems legitimate and other folks do that as well but
> let's use force_sig instead of force_sig_fault instead.  I don't know if
> userspace will notice but at the very least we won't be providing a bad
> example for other kernel code to follow and we won't wind up be making
> assumptions that are true today and false tomorrow when some
> implementation detail changes.
>
> For imformation on what signals and si_codes correspond to which
> union members you can look at siginfo_layout.  That function
> is the keeper of the magic decoder key.  Currently the only two
> si_codes defined for SIGKILL are SI_KERNEL and SI_USER both of which
> correspond to a _kill union member.

I see.  Assuming we cannot have a dummy internal si_code for this
special case (probably a bad idea), I think Will's suggestion of at
least pushing the special case handling down into
arm64_force_sig_fault() is probably a bit cleaner here, expecially
if other callers of that function may pass in SIGKILL (I haven't
looked though).

Cheers
---Dave
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
