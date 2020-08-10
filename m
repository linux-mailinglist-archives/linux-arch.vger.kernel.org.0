Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A38240746
	for <lists+linux-arch@lfdr.de>; Mon, 10 Aug 2020 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgHJONZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Aug 2020 10:13:25 -0400
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:23296
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbgHJONY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 10 Aug 2020 10:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqBGPJu0/V4HtY+7+CSvIpmz8VLqYev4m1cJRClJXY=;
 b=Gdxxde6LGL54DnBD4q/42wPYTfRPijS7cHEqG8fx7ozl/4rP+tIENtC2AXlf9VJGeY67unlCk5v3Coo8AYjQ9sWhIDuWK0dW78rI6hh/0wjcCLp8VFlx19NVV2ia5hV1Si4GvhepKXptP/SV9P97Bai1avMP6YltDgs6vP/AERM=
Received: from DB6PR1001CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::12)
 by AM6PR08MB3240.eurprd08.prod.outlook.com (2603:10a6:209:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 14:13:18 +0000
Received: from DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::3c) by DB6PR1001CA0026.outlook.office365.com
 (2603:10a6:4:55::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Mon, 10 Aug 2020 14:13:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT012.mail.protection.outlook.com (10.152.20.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.16 via Frontend Transport; Mon, 10 Aug 2020 14:13:18 +0000
Received: ("Tessian outbound 7a6fb63c1e64:v64"); Mon, 10 Aug 2020 14:13:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d35552457c716a4b
X-CR-MTA-TID: 64aa7808
Received: from cc7bb2979b03.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A90BF09F-BEF4-4ECF-97D9-5B00A0271EE3.1;
        Mon, 10 Aug 2020 14:13:13 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cc7bb2979b03.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 10 Aug 2020 14:13:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5MklIPK88MrXHc6jI1sVPsQ7bpRXBpa2BxzL/YzZXDZ8e8ducX8P6v+H8OtReJC7BLkco5fXwoAZif/2CNpTqGMS2pgKWMAlPQzB2+JJiN+rU8UG0Dsu70LUlRqJPU1k8F/eia8kGhMQ/UivsTO6TCDXTnjstBiIXuu0SoqQ3sxVGw7SUmK6Z1Upb4SvACTczz8P6cK8YL0lU60JYU9d2GL1x5z3TdBHcOrYCtUnLXhTjsJZOqpFmrGp+Yx475b3M1caQvb/cu3Xd0/kgMjteMwaygxaba6BEoEczpZ+L73ZgFt83DuZHr5qrJChZJvLNsR6rWj42+KGQkN9I0e2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqBGPJu0/V4HtY+7+CSvIpmz8VLqYev4m1cJRClJXY=;
 b=PMDMIgI+Vw/sRfbPIrT87p/yaxW13YMYfM+vGqjxIrlwzf5PzJxoSkcSpPSRekyOy1aiSYS1BP6IURq+XuaTbpKjJAedM8G73aGU0fS5j5Hja5Pc+w6WE8KC+aFUAWKu06HybWWtsAEvM9p9CHwG8zOoLkWbLXIliufLBmFOMcY42ciKcpKz66rD3jw9ryIEYpj01fymUHTgrBPBbayui2nG3PGxmRb4tbWeV77mG7lmWOx6UHajYkxZ/lYsmkNtkNZOHh2miVATQjZwHY7hZYRknZB+P9wRvFw0fmeFSbjtXTaFYGx3mSi8S6AO6m6w/ibO2bv285BZ/wZkoRZdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDqBGPJu0/V4HtY+7+CSvIpmz8VLqYev4m1cJRClJXY=;
 b=Gdxxde6LGL54DnBD4q/42wPYTfRPijS7cHEqG8fx7ozl/4rP+tIENtC2AXlf9VJGeY67unlCk5v3Coo8AYjQ9sWhIDuWK0dW78rI6hh/0wjcCLp8VFlx19NVV2ia5hV1Si4GvhepKXptP/SV9P97Bai1avMP6YltDgs6vP/AERM=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4135.eurprd08.prod.outlook.com (2603:10a6:20b:a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Mon, 10 Aug
 2020 14:13:11 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 14:13:11 +0000
Date:   Mon, 10 Aug 2020 15:13:09 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200810141309.GK14398@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
 <20200807151906.GM6750@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807151906.GM6750@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO3P123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::11) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.52) by LO3P123CA0006.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ba::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Mon, 10 Aug 2020 14:13:11 +0000
X-Originating-IP: [217.140.106.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e50529c1-bde6-4056-3cd8-08d83d3787e6
X-MS-TrafficTypeDiagnostic: AM6PR08MB4135:|AM6PR08MB3240:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB32402EE0D08878A8CB3C0E8CED440@AM6PR08MB3240.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: U+tLyPJeaw5MnzxXDxxcDJyL5fV94UDKJo5rcCVYVIlHvj18nEZMYANCcCug1AlmpGPmDI+eDdbKCVf4KOR5W6wNaL488FMQnuKCxoAqa5YaU3Jgvb5jLXuD54ppXi+rysuLFwD1AwxJ44zCVKSMXJjcH3hk6AZqSdfWgzE+7cu+X40aqkRW7qemvK48LdJjGCB28IRELzjSCWFKK+y90Iqq3g7C6EtWdIkd2/KGsOYMzlYLuLrF0gMPkbbLC296eelswgyHN23fJmZnDKqRqFhm83tZ7idyhxSUmq095wzH7SCkvjJ704PA2cI77U2/XB9ZvCmjmSMOxmem53HUhw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(55016002)(52116002)(7696005)(66476007)(66556008)(8886007)(86362001)(5660300002)(8936002)(83380400001)(6636002)(66946007)(36756003)(4326008)(33656002)(956004)(6862004)(1076003)(16526019)(186003)(316002)(37006003)(54906003)(26005)(8676002)(2906002)(478600001)(2616005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XbXR+5UT6j/sZLHSvNpYAAiDnX278PkY5SUuvwtE4nJFAxNqGCwkDti3zPkXoVilmehjqfuO4mqrheBxdl3h5UlDJVRa2EtcjiX/7XujmXcJ9ODPm3/t/CTniB6cXBQ4RYMOu8zw/PyVLnig2UNdAqP4pYkUkQeawwZO8M3ACpuCEFuMdrNXlPYXjUMRMTy7gZw8TkWUyCD7qrXtt2ldb+gR7fZEUck6DygWHwdhUwGZ1TgiYHgtmwD8D0Kvhvm0rog0pE5O/5YwDgj+JDwmS36lQrioh+t9wT/AL1lJUWt1DD1/Lv7FYCuNoBdnX+CZbaaqpImxtJVDKiXOw4wTEs8x8Ze0YAlRaqY+dJhK0FDPqaLKeqpLxCEjoOekTRVFS3yHVO5yVlSsOTqRAzRPQPGxFp2hhervIbNwYWFruP4ISK5OArOCAfIZDatl52GasEihfxG/OsOSCAmz6Dn9zDPu9GjzkrRBVT4LSqBqCvrXSP6ib4L34gt6vL7cUKTerRxvQbkY2IVdTl/oQRp5gAkJLazI6aqLjdqKdVW+Ic6CCQiz5Y4JVgkqS8JgB4OXnGeNUqyXWHvvJjRa3lht+rRLTL07Tvl97Ks75ZvPZsqbTWlXMe3xOqkbO7pu0oq2bcG04Gk6brq3dFeFjqpfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4135
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f8917dbb-59ce-494d-6076-08d83d3783af
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yW2jWhVCURL6joqBCGXuv5KJfJeIwyMa2X9gF1EuRq9VevB14KMyBRz8coNeWVUkDwoagIDDB1mWMUR3vKxIcEx2rjXa4hqLBXWAjO+qNucEy1I/Zol99Y1g5QpBM3CbwT+pOTuI1SSbrTS1ZxebpnqJZdPaS+KXED0Fc2HjEbWCHIqMlFirTopuXrXuVFrq75k/V7WFDpnzC7R5qXW3s05+CD+Mn758UcJuRJaeJ+845+9mUwAfJHDOS9xC0Rp1uuln31cz9OiXebZaEuMxTpbWsRrR0lT2tNX7jBPCGaMZHhu59zcdQkaCi8HtE3omOA9FMj5kcK6x+DTUzRXDXsWiXvw0+2QIyIrjbpJoWTMiNvLFvoo9MfDiOoHtDkXn4y9imrndBMPUTes7lvo9jQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966005)(86362001)(1076003)(956004)(2616005)(44832011)(6862004)(55016002)(70206006)(70586007)(8886007)(83380400001)(36756003)(4326008)(5660300002)(82310400002)(8936002)(33656002)(8676002)(2906002)(54906003)(7696005)(82740400003)(47076004)(37006003)(26005)(316002)(336012)(478600001)(6636002)(81166007)(356005)(186003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 14:13:18.5363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50529c1-bde6-4056-3cd8-08d83d3787e6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3240
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 08/07/2020 16:19, Catalin Marinas wrote:
> On Mon, Aug 03, 2020 at 01:43:10PM +0100, Szabolcs Nagy wrote:
> > if we can always turn sync tag checks on early whenever mte is
> > available then i think there is no issue.
> > 
> > but if we have to make the decision later for compatibility or
> > performance reasons then per thread setting is problematic.
> 
> At least for libc, I'm not sure how you could even turn MTE on at
> run-time. The heap allocations would have to be mapped with PROT_MTE as
> we can't easily change them (well, you could mprotect(), assuming the
> user doesn't use tagged pointers on them).

e.g. dlopen of library with stack tagging.
(libc can mark stacks with PROT_MTE at that time)

or just turn on sync tag checks later when using
heap tagging.

> 
> There is a case to switch tag checking from asynchronous to synchronous
> at run-time based on a signal but that's rather specific to Android
> where zygote controls the signal handler. I don't think you can do this
> with libc. Even on Android, since the async fault signal is delivered
> per thread, it probably does this lazily (alternatively, it could issue
> a SIGUSRx to the other threads for synchronisation).

i think what that zygote is doing is a valid use-case but
in a normal linux setup the application owns the signal
handlers so the tag check switch has to be done by the
application. the libc can expose some api for it, so in
principle it's enough if the libc can do the runtime
switch, but we dont plan to add new libc apis for mte.

> > use of the prctl outside of libc is very limited if it's per thread
> > only:
> 
> In the non-Android context, I think the prctl() for MTE control should
> be restricted to the libc. You can control the mode prior to the process
> being started using environment variables. I really don't see how the
> libc could handle the changing of the MTE behaviour at run-time without
> itself handling signals.
> 
> > - application code may use it in a (elf specific) pre-initialization
> >   function, but that's a bit obscure (not exposed in c) and it is
> >   reasonable for an application to enable mte checks after it
> >   registered a signal handler for mte faults. (and at that point it
> >   may be multi-threaded).
> 
> Since the app can install signal handlers, it can also deal with
> notifying other threads with a SIGUSRx, assuming that it decided this
> after multiple threads were created. If it does this while
> single-threaded, subsequent threads would inherit the first one.

the application does not know what libraries create what
threads in the background, i dont think there is a way to
send signals to each thread (e.g. /proc/self/task cannot
be read atomically with respect to thread creation/exit).

the libc controls thread creation and exit so it can have
a list of threads it can notify, but an application cannot
do this. (libc could provide an api so applications can
do some per thread operation, but a libc would not do this
happily: currently there are locks around thread creation
and exit that are only needed for this "signal all threads"
mechanism which makes it hard to expose to users)

one way applications sometimes work this around is to
self re-exec. but that's a big hammer and not entirely
reliable (e.g. the exe may not be available on the
filesystem any more or the commandline args may need
to be preserved but they are clobbered, or some complex
application state needs to be recreated etc)

> 
> The only use-case I see for doing this in the kernel is if the code
> requiring an MTE behaviour change cannot install signal handlers. More
> on this below.
> 
> > - library code normally initializes per thread state on the first call
> >   into the library from a given thread, but with mte, as soon as
> >   memory / pointers are tagged in one thread, all threads are
> >   affected: not performing checks in other threads is less secure (may
> >   be ok) and it means incompatible syscall abi (not ok). so at least
> >   PR_TAGGED_ADDR_ENABLE should have process wide setting for this
> >   usage.
> 
> My assumption with MTE is that the libc will initialise it when the
> library is loaded (something __attribute__((constructor))) and it's
> still in single-threaded mode. Does it wait until the first malloc()
> call? Also, is there such thing as a per-thread initialiser for a
> dynamic library (not sure it can be implemented in practice though)?

there is no per thread initializer in an elf module.
(tls state is usually initialized lazily in threads
when necessary.)

malloc calls can happen before the ctors of an LD_PRELOAD
library and threads can be created before both.
glibc runs ldpreload ctors after other library ctors.

custom allocator can be of course dlopened.
(i'd expect several language runtimes to have their
own allocator and support dlopening the runtime)

> 
> The PR_TAGGED_ADDR_ENABLE synchronisation at least doesn't require IPIs
> to other CPUs to change the hardware state. However, it can still race
> with thread creation or a prctl() on another thread, not sure what we
> can define here, especially as it depends on the kernel internals: e.g.
> thread creation copies some data structures of the calling thread but at
> the same time another thread wants to change such structures for all
> threads of that process. The ordering of events here looks pretty
> fragile.
> 
> Maybe with another global status (per process) which takes priority over
> the per thread one would be easier. But such priority is not temporal
> (i.e. whoever called prctl() last) but pretty strict: once a global
> control was requested, it will remain global no matter what subsequent
> threads request (or we can do it the other way around).

i see.

> > but i guess it is fine to design the mechanism for these in a later
> > linux version, until then such usage will be unreliable (will depend
> > on how early threads are created).
> 
> Until we have a real use-case, I'd not complicate the matters further.
> For example, I'm still not sure how realistic it is for an application
> to load a new heap allocator after some threads were created. Even the
> glibc support, I don't think it needs this.
> 
> Could an LD_PRELOADED library be initialised after threads were created
> (I guess it could if another preloaded library created threads)? Even if
> it does, do we have an example or it's rather theoretical.

i believe this happens e.g. in applications built
with tsan. (the thread sanitizer creates a
background thread early which i think does not
call malloc itself but may want to access
malloced memory, but i don't have a setup with
tsan support to test this)

> 
> If this becomes an essential use-case, we can look at adding a new flag
> for prctl() which would set the option globally, with the caveats
> mentioned above. It doesn't need to be in the initial ABI (and the
> PR_TAGGED_ADDR_ENABLE is already upstream).
> 
> Thanks.
> 
> -- 
> Catalin
