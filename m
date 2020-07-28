Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E74230CC5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 16:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgG1OyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jul 2020 10:54:04 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:16385
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730455AbgG1OyE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 10:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOGn/rZS/6oqXAk6AXaV4udlEXZI9X9EQxgwdO4fo0c=;
 b=8L/KQOOCh3rXHclQjRj6UbI4v0JULcENfMobmWmaFJk/2Z0nADY8q6Q5R/JGsDzdogFMsp+NIvIGMrBNOjmaXr4RHfEemnzIwkMfIeXzgCp/NvoCoGCuaJAg9dsRgTqEdLJUf59nqzrDtOPRV68OYdMM8rednnpfed55Ckfr0Mw=
Received: from PR0P264CA0060.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1d::24)
 by AM5PR0802MB2545.eurprd08.prod.outlook.com (2603:10a6:203:a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 14:54:00 +0000
Received: from VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:100:1d:cafe::58) by PR0P264CA0060.outlook.office365.com
 (2603:10a6:100:1d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24 via Frontend
 Transport; Tue, 28 Jul 2020 14:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT032.mail.protection.outlook.com (10.152.18.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.10 via Frontend Transport; Tue, 28 Jul 2020 14:53:59 +0000
Received: ("Tessian outbound 73b502bf693a:v62"); Tue, 28 Jul 2020 14:53:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2481ceb6a1746985
X-CR-MTA-TID: 64aa7808
Received: from f57b1d4f14e3.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8A3D0836-DE03-495A-9D47-CFB4E69295F3.1;
        Tue, 28 Jul 2020 14:53:54 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f57b1d4f14e3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 28 Jul 2020 14:53:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwR/mSN3z1Kd1AQcYRQYtFtMz3v6NFb9u4AceVoBaO2K69T4O5Z0x/LhCXWN0vvdUFKYa9sS0B8GgTJariML/7tfxz5edaIahtBSEzW8B6Nbov8FXV9SG5q/tgIbaA/TxvROPQ5A8gbNlP+v0XZZPBhgK0vxf6EUoKPJfK+Ald+2Ie/wa+1xi1cAG0ByNBDG66s4FLsh4OGxEcEudkiucpgrnsUKBtr5eKq0QzHg23Hnt8cI4R3L8Hy3RAu4wA9Z8ADdQJd9sKG+E52oGGx0ZG6+awij+wGbCnUcBrSjloRxfXqSmWUw3zNZnAuL9Czayr2IXVQ78Ngf+jcbT/6cMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOGn/rZS/6oqXAk6AXaV4udlEXZI9X9EQxgwdO4fo0c=;
 b=GBQieZsAv/qq3By6tUxdzxGsAP9vxiQCc1zQZcgKzIYb4MLRt3f3AtqG3xr3PxwoayJCxMKapHalQRoPO5iyxH5qyzl1jp3p6jZs0WjBQhg/V7Sl/Qx4/NV73/cfZO37d8Iv2mmYY6TmqKAFyMjDFChSXH5qVovdlSApowGp6viU18BtLbYcvydUScmlJjOIZWEYfCI7pwUHdTRN8wtkvFuVIs+kFnZn0d5LYSaqTE3bZgrh5E1mYVu20oIiki/ckgXYun/0n5SyxcI9GZDzHNp0x3PuTOVcfRPqH3abKtHd/0laf3Rnruf53WJDcUCYGdtagKLEHz+f7lNBhYmXqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOGn/rZS/6oqXAk6AXaV4udlEXZI9X9EQxgwdO4fo0c=;
 b=8L/KQOOCh3rXHclQjRj6UbI4v0JULcENfMobmWmaFJk/2Z0nADY8q6Q5R/JGsDzdogFMsp+NIvIGMrBNOjmaXr4RHfEemnzIwkMfIeXzgCp/NvoCoGCuaJAg9dsRgTqEdLJUf59nqzrDtOPRV68OYdMM8rednnpfed55Ckfr0Mw=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM7PR08MB5319.eurprd08.prod.outlook.com (2603:10a6:20b:dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 14:53:53 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 14:53:53 +0000
Date:   Tue, 28 Jul 2020 15:53:51 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200728145350.GR7127@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728110758.GA21941@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LNXP265CA0049.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::13) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.51) by LNXP265CA0049.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24 via Frontend Transport; Tue, 28 Jul 2020 14:53:52 +0000
X-Originating-IP: [217.140.106.51]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d992ccd5-801c-4a0f-0799-08d833060fb1
X-MS-TrafficTypeDiagnostic: AM7PR08MB5319:|AM5PR0802MB2545:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB25459E1DF0D33923C95F33D1ED730@AM5PR0802MB2545.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: a4PUfl3DZUCSRzhP0feGhPA2UEnHTwxoTL1ndJQOc/JZkdfjB/btyj89BsceUbB7W658dG5PJIHvmHmz0u3aXTUdcVi/dUdimhf7uFnq6hecjl+ZhPR+2nu7F/Zn3vkgvmpdVetwRBY0oBGvunKSSKiP/6EiNquT+PA6PJLykHQRKFZ//NJQ25VgQIwumBiOdyhZINrzNne7vSGq6EMP5sT8vyOhYOGdIvVAwnu3jGazAaDpw7pdSU5T1lo5Qlb75dCMexyQFozyFz6rbHCAo51rp5NUctMZlNCVfC61Vx/TjUzAsWlL192cWtimWK8YLUly6VTisjqUl+o85DO34Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(7696005)(52116002)(2906002)(86362001)(55016002)(1076003)(316002)(83380400001)(8936002)(478600001)(36756003)(6862004)(4326008)(66946007)(54906003)(33656002)(8886007)(2616005)(16526019)(186003)(8676002)(956004)(5660300002)(66556008)(37006003)(66476007)(44832011)(26005)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ySzYcha3bl9/L4lYc4GjDNIiEK5k/sJKwb9C7yMHTd/RoocnbB7Uh0aQNVQkm3xiUdNpgpLuJ8+N9nwh7z5P6Ycntkqv6AVovG6WfBWe/votGd5LVaAeB8bGjHbiMtma8g6tlmqfleKmltrSrXl9G/XPRaHSumup8YbszTPBlV8TwccGJsSr0KBim8pxg5sgX9G1T+XF43dS0ShS5kcjT3ln1nUCAkB8+CBLfFtPYANANv4gIZ+/ytlzOav87WaZ0iWRN3BbJqOOdJS6mnAvlDIf7HwOwKpjdhyBmq0LEkMF5m8LIsLAYTbxamJER+NAeRnapiHcSdC9lCc/4IjGG6vGw1lIm8SKl+DRqyA6pGQjMe+rPcp8gXanmsM6qwNPNC4Jeeztl2WXkuV2xCocx8Hew8oqzEPvmkUw4751ouBn3Ts3+XqGh6NUGK4GSY38sOxLqeKf5Vqt8j/gaNmCHzYAzPqPkKrdvTLS/K+Mm6Vb8KhoRAyuHU1t3ms/L+lB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5319
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e4f559b3-cf6c-406b-c4e9-08d833060b83
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUgBLaPd6TF4KxDBwnQXoSGPU+pUaAWp9050oNNDUptoElR36/YGo64wM7vLPOQ3OKnPHaqnGEVpjUxEz76RVS+k8GjepALgkbvahxHWdo3LVEZ7+e5vybCvwRtaKbVAui2BKC2Zkdl5Tqwv6er04h0bIGmIhoRwxHk5FvHBeHorCCRl8MAiTv/H+xjGytcKK4jD7kItTfcMA8mZZCK736M2YfYkk2/4cpCjy4S9B7o74ABv279aTYAV3FS6fC8Nio2jnh3h/eK/UqGIxxuhajb/eUdyXfYd1KLRx1zhPT7reYdEz1Dwx7ot3XZoV3MEv3g96APm6umQR2Oo7gB+nozlB9jByLzIAKrY2WLuB38wKbtG3r8NN5CCNgK2lv44FGd9IJxmt1M6DYhIoMXZAw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966005)(37006003)(186003)(16526019)(82740400003)(478600001)(54906003)(47076004)(36756003)(8886007)(2616005)(956004)(7696005)(33656002)(8676002)(1076003)(44832011)(70206006)(70586007)(8936002)(86362001)(55016002)(356005)(336012)(36906005)(316002)(83380400001)(6862004)(5660300002)(2906002)(6636002)(4326008)(81166007)(26005)(82310400002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 14:53:59.7886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d992ccd5-801c-4a0f-0799-08d833060fb1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2545
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/28/2020 12:08, Dave Martin wrote:
> On Mon, Jul 27, 2020 at 05:36:35PM +0100, Szabolcs Nagy wrote:
> > The 07/15/2020 18:08, Catalin Marinas wrote:
> > > +The user can select the above modes, per thread, using the
> > > +``prctl(PR_SET_TAGGED_ADDR_CTRL, flags, 0, 0, 0)`` system call where
> > > +``flags`` contain one of the following values in the ``PR_MTE_TCF_MASK``
> > > +bit-field:
> > > +
> > > +- ``PR_MTE_TCF_NONE``  - *Ignore* tag check faults
> > > +- ``PR_MTE_TCF_SYNC``  - *Synchronous* tag check fault mode
> > > +- ``PR_MTE_TCF_ASYNC`` - *Asynchronous* tag check fault mode
> > > +
> > > +The current tag check fault mode can be read using the
> > > +``prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0)`` system call.
> > 
> > we discussed the need for per process prctl off list, i will
> > try to summarize the requirement here:
> > 
> > - it cannot be guaranteed in general that a library initializer
> > or first call into a library happens when the process is still
> > single threaded.
> > 
> > - user code currently has no way to call prctl in all threads of
> > a process and even within the c runtime doing so is problematic
> > (it has to signal all threads, which requires a reserved signal
> > and dealing with exiting threads and signal masks, such mechanism
> > can break qemu user and various other userspace tooling).
> 
> When working on the SVE support, I came to the conclusion that this
> kind of thing would normally either be done by the runtime itself, or in
> close cooperation with the runtime.  However, for SVE it never makes
> sense for one thread to asynchronously change the vector length of
> another thread -- that's different from the MTE situation.

currently there is libc mechanism to do some operation
in all threads (e.g. for set*id) but this is fragile
and not something that can be exposed to user code.
(on the kernel side it should be much simpler to do)

> > - we don't yet have defined contract in userspace about how user
> > code may enable mte (i.e. use the prctl call), but it seems that
> > there will be use cases for it: LD_PRELOADing malloc for heap
> > tagging is one such case, but any library or custom allocator
> > that wants to use mte will have this issue: when it enables mte
> > it wants to enable it for all threads in the process. (or at
> > least all threads managed by the c runtime).
> 
> What are the situations where we anticipate a need to twiddle MTE in
> multiple threads simultaneously, other than during process startup?
> 
> > - even if user code is not allowed to call the prctl directly,
> > i.e. the prctl settings are owned by the libc, there will be
> > cases when the settings have to be changed in a multithreaded
> > process (e.g. dlopening a library that requires a particular
> > mte state).
> 
> Could be avoided by refusing to dlopen a library that is incompatible
> with the current process.
> 
> dlopen()ing a library that doesn't support tagged addresses, in a
> process that does use tagged addresses, seems undesirable even if tag
> checking is currently turned off.

yes but it can go the other way too:

at startup the libc does not enable tag checks
for performance reasons, but at dlopen time a
library is detected to use mte (e.g. stack
tagging or custom allocator).

then libc or the dlopened library has to ensure
that checks are enabled in all threads. (in case
of stack tagging the libc has to mark existing
stacks with PROT_MTE too, there is mechanism for
this in glibc to deal with dlopened libraries
that require executable stack and only reject
the dlopen if this cannot be performed.)

another usecase is that the libc is mte-safe
(it accepts tagged pointers and memory in its
interfaces), but it does not enable mte (this
will be the case with glibc 2.32) and user
libraries have to enable mte to use it (custom
allocator or malloc interposition are examples).

and i think this is necessary if userpsace wants
to turn async tag check into sync tag check at
runtime when a failure is detected.

> > a solution is to introduce a flag like SECCOMP_FILTER_FLAG_TSYNC
> > that means the prctl is for all threads in the process not just
> > for the current one. however the exact semantics is not obvious
> > if there are inconsistent settings in different threads or user
> > code tries to use the prctl concurrently: first checking then
> > setting the mte state via separate prctl calls is racy. but if
> > the userspace contract for enabling mte limits who and when can
> > call the prctl then i think the simple sync flag approach works.
> > 
> > (the sync flag should apply to all prctl settings: tagged addr
> > syscall abi, mte check fault mode, irg tag excludes. ideally it
> > would work for getting the process wide state and it would fail
> > in case of inconsistent settings.)
> 
> If going down this route, perhaps we could have sets of settings:
> so for each setting we have a process-wide value and a per-thread
> value, with defines rules about how they combine.
> 
> Since MTE is a debugging feature, we might be able to be less aggressive
> about synchronisation than in the SECCOMP case.

separate process-wide and per-thread value
works for me and i expect most uses will
be process wide settings.

i don't think mte is less of a security
feature than seccomp.

if linux does not want to add a per process
setting then only libc will be able to opt-in
to mte and only at very early in the startup
process (before executing any user code that
may start threads). this is not out of question,
but i think it limits the usage and deployment
options.

> > we may need to document some memory ordering details when
> > memory accesses in other threads are affected, but i think
> > that can be something simple that leaves it unspecified
> > what happens with memory accesses that are not synchrnized
> > with the prctl call.
> 
> Hmmm...

e.g. it may be enough if the spec only works if
there is no PROT_MTE memory mapped yet, and no
tagged addresses are present in the multi-threaded
process when the prctl is called.

