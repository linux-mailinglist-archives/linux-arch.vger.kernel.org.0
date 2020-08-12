Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BD7242999
	for <lists+linux-arch@lfdr.de>; Wed, 12 Aug 2020 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHLMpi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Aug 2020 08:45:38 -0400
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:61856
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726829AbgHLMph (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Aug 2020 08:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNu778xEi7b34KsTs7PLpJlHaym7d3QUKgNn66lztDk=;
 b=2IYbqUQbWsyAcwzm5Tjsbjv9mkp8LqXynU5aWOzXZ1L3rb4i1GWD37nv7vxBm9XjljjQiWRuzsuFG1f4Bz17Y18EswKYqiZYyvY6GV0aq0kUTL0kLtL81gDTmaPxuGFASQFVavf2Jrf9G1sHf6d/UCfDPuSyrIGYYjMfbLl/xkc=
Received: from AM5P194CA0001.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::11)
 by AM4PR08MB2852.eurprd08.prod.outlook.com (2603:10a6:205:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Wed, 12 Aug
 2020 12:45:31 +0000
Received: from AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::e4) by AM5P194CA0001.outlook.office365.com
 (2603:10a6:203:8f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 12:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT012.mail.protection.outlook.com (10.152.16.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 12:45:30 +0000
Received: ("Tessian outbound 195a290eb161:v64"); Wed, 12 Aug 2020 12:45:30 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b5f4411f5c542a2b
X-CR-MTA-TID: 64aa7808
Received: from 4e3cd944f737.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 86804A99-9257-4AD8-898F-D65A4AE9C9E7.1;
        Wed, 12 Aug 2020 12:45:25 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4e3cd944f737.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 12 Aug 2020 12:45:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHd9X+ua7TtSN2Gb8ebMGH574sK426sKcqVLdkMlF1PeMUOfY2QrLe+MOVcfgWoWeFyPwxXubwEiI/l9O1wEAVOTpeiSKW74N9Guufk9Zi8paEYpmBt1t2QGf8dZCkyzW5Uz7i1oaMKy+XkeX+FXECFJ3YeVX+ZDizg4YhhJzZyyPPkEjWqEXwXkVoCX0n0p6hrxFG9/KNjuicmkT6uik8AxY2fIxLL2VONfrZrW/s/N0Jutn8ws5O6DT+lI9DXNApL+K5f+LxyAFV1EILorvoVvmB8Ikihy/n7BN/Y50EJXJoL/kT/+mFg3Ds9L1bOm0WH5LsCBymv9PEwOaj4+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNu778xEi7b34KsTs7PLpJlHaym7d3QUKgNn66lztDk=;
 b=b6D0XRf5EJ3nMpmdd2+vkiy2PZQ7cKuG/UEvBdVg1klB6FV64ZM4/gj3r3gcq8+dipy41VlHe3cSc4R0Z7lkqRecChGi/mD+0RaOHrrX6CiZkUb4ABHH4PINej6WI134Zh5SJkHk4Ky5nu1oUQuaZL8Uxz3ho9cJbksUdzN+5yKe2zQmGbxkSbt1GYnSp218oAjI9460MfwaZ9TNCY+S14NN3bkhlvlqEBrhliQEIQWpD2k/FnJb1ZHxU3ZGK/kJrvZLk9YQRXoWWKO1xLzFIz9O/t1vIB04iQLWp1RORbK9gkKaMlxpnEK+cKrPfSNY4X9hq0j4Wd1oARh94fpYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNu778xEi7b34KsTs7PLpJlHaym7d3QUKgNn66lztDk=;
 b=2IYbqUQbWsyAcwzm5Tjsbjv9mkp8LqXynU5aWOzXZ1L3rb4i1GWD37nv7vxBm9XjljjQiWRuzsuFG1f4Bz17Y18EswKYqiZYyvY6GV0aq0kUTL0kLtL81gDTmaPxuGFASQFVavf2Jrf9G1sHf6d/UCfDPuSyrIGYYjMfbLl/xkc=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3046.eurprd08.prod.outlook.com (2603:10a6:209:48::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 12 Aug
 2020 12:45:23 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3261.025; Wed, 12 Aug 2020
 12:45:23 +0000
Date:   Wed, 12 Aug 2020 13:45:21 +0100
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
Message-ID: <20200812124520.GP14398@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
 <20200807151906.GM6750@gaia>
 <20200810141309.GK14398@arm.com>
 <20200811172038.GB1429@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811172038.GB1429@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0284.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::32) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P265CA0284.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Wed, 12 Aug 2020 12:45:22 +0000
X-Originating-IP: [217.140.106.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd93c669-8acf-4cbc-4169-08d83ebd9907
X-MS-TrafficTypeDiagnostic: AM6PR08MB3046:|AM4PR08MB2852:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB28523A05D4B90137CCE81636ED420@AM4PR08MB2852.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yNQl5ibhjqCl1pWkKQGdNFSG7cwGPKonqaTiccYH5/+NmfVw6wLPUsVFC6MfDGyp/5BlYvlvZ8FzddB46XkU3kNyQSh4fSwmAKaZeU4p3Vo8KsYNvdu7hBsodg7txbdWeiHxlGDoiJ/5ewMLhu2mcgM0JKJKVOgQBC1ACbftw0rkeLNJtMwF95Z/EV/DDfaBVudz1SVOtD02Jy5w9xcZwF4evfazkMbuqe3Mm9Y2k5OHo4UnvUbUE3XS1AGSNgc+m4x71WJYq7k3t7qgNjPqSfNWHV4Q7+8olviTDlZy5lCRJs45ltsLNDhJ2/P+UBK0mubX+SZqGqA+ZxMh1RJzUnFa8PjT/ru4z3ByiIG2v7ksgC/vFsD7huHBw1gbU/5nPC7A1qmAWmfuLUdjB5hi+g==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(966005)(37006003)(6862004)(8886007)(316002)(26005)(86362001)(2906002)(186003)(33656002)(16526019)(52116002)(478600001)(36756003)(6636002)(55016002)(956004)(66556008)(66476007)(8676002)(83380400001)(1076003)(4326008)(7696005)(8936002)(66946007)(5660300002)(44832011)(2616005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qiofI/F1hpWkT4l0e+Gzg6aq7ZYUcD3Ky/3bWZbIA3gbyjT5BpRuGLMvo9L7oEIqaRgp6xPtvEWCNj1KNegvNGUeTUpcI5hgIRkypXb9388rYJ+QjDOCDYo1dIrj/24mpSPZ0MN6b+dRNKDmyLkoWH4Ymcvu8GRoTqn3HK+vqdVbcVAEoduMrU589+euuy7pIJB2REzTM7rHIGmn/qsc2HRbXaSZEsvLYXsNRdi5Jt4VeHTSY3D8JT7Tud2gXiiRdlvkU3SczdyFauQGJF9DhnSAJG+bB1MQYRHdM0cJCxpOmluYagQ/H8JAG/ZTYRfXjELr6fDpMcYS6w9DgbVLQejz/0LZKnADBgJt/Ght2Xm0JNwl5X/6yZ/YiMDPpMdPrINpQq5OCKrk9Abj7EcGszn0UnPqJFu33XcU0T7Va7j8eY0g2azREbOB9YigsOIlbRyVUNJif3qCbdH+HsKTFtNc7h+433X72w1YIj5+TxvftVVONjsa+w/rCIwA6H46aF/atjmmajltLHiUynO6oP+PM6sQsoVzc75YIf61UdUDr7ITuZ4p5eiQV8WNBEEHWP8Y90pKxRG5Z62PiPk7S1tX7ZrRP8lyus+l+G4ggq6AFd+KuH3Q9pVB13dXsdaYR6lW/CZ7w7T+FCgc5puQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3046
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5ab16609-c28d-4934-50d8-08d83ebd945e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRXe106LmiHCHrZxvY4fSjRqhfmg4MAKawIsHUM/WfuCb+Xx5qojrqca0/WH/TTnLVG0NWePjkyMqETqD8u+N9RRte3gyg8nt/b1naurlhMw24wxOa52dMo6UGuLAWnO7H4f6LB+gaEjDsAAVmFG/KdhWVXGiVlyGA2rTBC1FTrToqerBbym6xQCfx0MyObqdvsktTQfoRuvKtNPvNxn1JA9rrjSD2oehjKpJBdwMd4YBBmeMgap//StnWPGa0KK9fmvjiVZQKROpoaGK4HEEgpxCGKA3X/WAq7qt9oyXBybMwQ0aoRrB6Ic2xgNKAUNck9SrxmwXAauhWRptm01EhHsma/sEiFWJg9a1giBcvP/hpxZ+KoT1xpUY7Z4UaJZlr2crJV+QaR3EYnfl1+9D+zkzLouxoU4dhLz16XQ2Az9lgn1ZWccdVlh9U7h1dcQbiLIY/+9LAJJ+PXpsGJkN1pmaZYGts+lGWWSBpc8UM4=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(956004)(82740400003)(36756003)(83380400001)(356005)(70206006)(8886007)(16526019)(26005)(316002)(36906005)(4326008)(6636002)(6862004)(81166007)(70586007)(186003)(37006003)(33656002)(1076003)(2616005)(2906002)(54906003)(7696005)(8936002)(336012)(44832011)(5660300002)(478600001)(86362001)(82310400002)(47076004)(55016002)(8676002)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 12:45:30.9334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd93c669-8acf-4cbc-4169-08d83ebd9907
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2852
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 08/11/2020 18:20, Catalin Marinas wrote:
> On Mon, Aug 10, 2020 at 03:13:09PM +0100, Szabolcs Nagy wrote:
> > The 08/07/2020 16:19, Catalin Marinas wrote:
> > > On Mon, Aug 03, 2020 at 01:43:10PM +0100, Szabolcs Nagy wrote:
> > > > if we can always turn sync tag checks on early whenever mte is
> > > > available then i think there is no issue.
> > > > 
> > > > but if we have to make the decision later for compatibility or
> > > > performance reasons then per thread setting is problematic.
> > > 
> > > At least for libc, I'm not sure how you could even turn MTE on at
> > > run-time. The heap allocations would have to be mapped with PROT_MTE as
> > > we can't easily change them (well, you could mprotect(), assuming the
> > > user doesn't use tagged pointers on them).
> > 
> > e.g. dlopen of library with stack tagging. (libc can mark stacks with
> > PROT_MTE at that time)
> 
> If we allow such mixed object support with stack tagging enabled at
> dlopen, PROT_MTE would need to be turned on for each thread stack. This
> wouldn't require synchronisation, only knowing where the thread stacks
> are, but you'd need to make sure threads don't call into the new library
> until the stacks have been mprotect'ed. Doing this midway through a
> function execution may corrupt the tags.
> 
> So I'm not sure how safe any of this is without explicit user
> synchronisation (i.e. don't call into the library until all threads have
> been updated). Even changing options like GCR_EL1.Excl across multiple
> threads may have unwanted effects. See this comment from Peter, the
> difference being that instead of an explicit prctl() call on the current
> stack, another thread would do it:
> 
> https://lore.kernel.org/linux-arch/CAMn1gO5rhOG1W+nVe103v=smvARcFFp_Ct9XqH2Ca4BUMfpDdg@mail.gmail.com/

there is no midway problem: the libc (ld.so) would do
the PROT_MTE at dlopen time based on some elf marking
(which can be handled before relocation processing,
so before library code can run, the midway problem
happens when a library, e.g libc, wants to turn on
stack tagging on itself).

the libc already does this when a library is loaded
that requires executable stack (it marks stacks as
PROT_EXEC at dlopen time or fails the dlopen if that
is not possible, this does not require running code
in other threads, only synchronization with thread
creation and exit. but changing the check mode for
mte needs per thread code execution.).

i'm not entirely sure if this is a good idea, but i
expect stack tagging not to be used in the libc
(because libc needs to run on all hw and we don't yet
have a backward compatible stack tagging solution),
so stack tagging should work when only some elf modules
in a process are built with it, which implies that
enabling it at dlopen time should work otherwise
it will not be very useful.

> > or just turn on sync tag checks later when using heap tagging.
> 
> I wonder whether setting the synchronous tag check mode by default would
> improve this aspect. This would not have any effect until PROT_MTE is
> used. If software wants some better performance they can explicitly opt
> in to asynchronous mode or disable tag checking after some SIGSEGV +
> reporting (this shouldn't exclude the environment variables you
> currently use for controlling the tag check mode).
> 
> Also, if there are saner defaults for the user GCR_EL1.Excl (currently
> all masked), we should decide them now.
> 
> If stack tagging will come with some ELF information, we could make the
> default tag checking and GCR_EL1.Excl choices based on that, otherwise
> maybe we should revisit the default configuration the kernel sets for
> the user in the absence of any other information.

do tag checks have overhead if PROT_MTE is not used?
i'd expect some checks are still done at memory access.
(and the tagged address syscall abi has to be in use.)

turning sync tag checks on early would enable the
most of the interesting usecases (only PROT_MTE has
to be handled at runtime not the prctls. however i
don't yet know how userspace will deal with compat
issues, i.e. it may not be valid to unconditionally
turn tag checks on early).

> > > > - library code normally initializes per thread state on the first call
> > > >   into the library from a given thread, but with mte, as soon as
> > > >   memory / pointers are tagged in one thread, all threads are
> > > >   affected: not performing checks in other threads is less secure (may
> > > >   be ok) and it means incompatible syscall abi (not ok). so at least
> > > >   PR_TAGGED_ADDR_ENABLE should have process wide setting for this
> > > >   usage.
> > > 
> > > My assumption with MTE is that the libc will initialise it when the
> > > library is loaded (something __attribute__((constructor))) and it's
> > > still in single-threaded mode. Does it wait until the first malloc()
> > > call? Also, is there such thing as a per-thread initialiser for a
> > > dynamic library (not sure it can be implemented in practice though)?
> > 
> > there is no per thread initializer in an elf module.
> > (tls state is usually initialized lazily in threads
> > when necessary.)
> > 
> > malloc calls can happen before the ctors of an LD_PRELOAD
> > library and threads can be created before both.
> > glibc runs ldpreload ctors after other library ctors.
> 
> In the presence of stack tagging, I think any subsequent MTE config
> change across all threads is unsafe, irrespective of whether it's done
> by the kernel or user via SIGUSRx. I think the best we can do here is
> start with more appropriate defaults or enable them based on an ELF note
> before the application is started. The dynamic loader would not have to
> do anything extra here.
> 
> If we ignore stack tagging, the global configuration change may be
> achievable. I think for the MTE bits, this could be done lazily by the
> libc (e.g. on malloc()/free() call). The tag checking won't happen
> before such calls unless we change the kernel defaults. There is still
> the tagged address ABI enabling, could this be done lazily on syscall by
> the libc? If not, the kernel could synchronise (force) this on syscall
> entry from each thread based on some global prctl() bit.

i think the interesting use-cases are all about
changing mte settings before mte is in use in any
way but after there are multiple threads.
(the async -> sync mode change on tag faults is
i think less interesting to the gnu linux world.)

i guess lazy syscall abi switch works, but it is
ugly: raw syscall usage will be problematic and
doing checks before calling into the vdso might
have unwanted overhead.

based on the discussion it seems we should design
the userspace abis so that per process prctl is
not required and then see how far we get.
