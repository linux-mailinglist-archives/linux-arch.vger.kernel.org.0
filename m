Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84BD24C380
	for <lists+linux-arch@lfdr.de>; Thu, 20 Aug 2020 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgHTQnl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Aug 2020 12:43:41 -0400
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:12942
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729461AbgHTQnb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Aug 2020 12:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLRXlLfx9w3hbPTUL8tE01oSRTvAoAWjDxFfP8rLm6M=;
 b=41bcz3AC4pdhTE7FXktt+uzz87/5KoyuTFns/hUNPOVxQyMO9O1goRerlazpmQbjV31beMraFtv8lcPQxAlJb41PtqXgFJq1eT1JlKaQAi79tB6Zo6WOa1WPo7Kg0p82lMNXRYwnpRrd/mLcUTX3zBKjuGb1Ppikv8KjF1CAB1Y=
Received: from DB6PR0802CA0028.eurprd08.prod.outlook.com (2603:10a6:4:a3::14)
 by AM6PR08MB3365.eurprd08.prod.outlook.com (2603:10a6:20b:42::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Thu, 20 Aug
 2020 16:43:26 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::e2) by DB6PR0802CA0028.outlook.office365.com
 (2603:10a6:4:a3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Thu, 20 Aug 2020 16:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 16:43:26 +0000
Received: ("Tessian outbound bac899b43a54:v64"); Thu, 20 Aug 2020 16:43:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 30abdcd1df25c4c9
X-CR-MTA-TID: 64aa7808
Received: from 1e6c7e2ef5f8.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B621596B-B2E7-4134-8661-A641EC6A6A09.1;
        Thu, 20 Aug 2020 16:43:20 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1e6c7e2ef5f8.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 20 Aug 2020 16:43:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9bt78X92lh6BE8Lot2agLGX9Knhit2PeghGoIXrFu78QsqlFnomDR4WwTbcMFg0Vy346OFj9lRioPIEEn0w9Hy07uwW9/UNGGE2LgBszBlboIoLTScM1lZYARB5o6aFwd2vZKex8mkS3RkMrfraSvFfmtp3g0iM/gktLFdWp7umFxFAlOkIbfwCTOVGpEb/cNmsddpJMumM8wDLuvSeKmgUK5xJLCHos3KSwysVGB83R5IX5wVayj4f+wsDPk6djhslMzM7N/DmiecA/d3Uh33lFdXKbJDrSnm1kNP0souH/4n332bbNH6ZKmtbyD6o28yvmGcOgPWR3IMghVgsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLRXlLfx9w3hbPTUL8tE01oSRTvAoAWjDxFfP8rLm6M=;
 b=Bm/HH8B4YcPYrukOn+xSC6VoXyA1qVcubIYxd7M1r6O6Z0KLfm4DE5KWDeaMhJZi0D50Tn/gTP8IPvtLlMw0WHv2pFoBNZsoqVAY3/yvLLZiZBTJUXGcwvHdI+Z/926S2KD2iRVMqVMAlYvuktT/u7/4Tl+CEbAwhp63LDfAGyxjUiyKLrQ0ifH/To7/1lGkdXje8J8wCGto4516RRminqtGrmUe3LY0ExGisQ0aIUBUNF+Lrx0BiDJqFliZzBLsvh+FIlU+h/+NwbOfWr4YfJRqYbFNt7aftWMh+OHUXXWc2OV88QAZ+Pr0ot3+cPTxSz6pC/fr1PsgI+AQEDJS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLRXlLfx9w3hbPTUL8tE01oSRTvAoAWjDxFfP8rLm6M=;
 b=41bcz3AC4pdhTE7FXktt+uzz87/5KoyuTFns/hUNPOVxQyMO9O1goRerlazpmQbjV31beMraFtv8lcPQxAlJb41PtqXgFJq1eT1JlKaQAi79tB6Zo6WOa1WPo7Kg0p82lMNXRYwnpRrd/mLcUTX3zBKjuGb1Ppikv8KjF1CAB1Y=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3318.eurprd08.prod.outlook.com (2603:10a6:209:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 20 Aug
 2020 16:43:17 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::eda3:77d3:ed89:c472]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::eda3:77d3:ed89:c472%6]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 16:43:17 +0000
Date:   Thu, 20 Aug 2020 17:43:15 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com,
        libc-alpha@sourceware.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Matthew Malcomson <Matthew.Malcomson@arm.com>
Subject: Re: [PATCH v7 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200820164313.GL29343@arm.com>
References: <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
 <20200803124309.GC14398@arm.com>
 <20200807151906.GM6750@gaia>
 <20200810141309.GK14398@arm.com>
 <20200811172038.GB1429@gaia>
 <20200812124520.GP14398@arm.com>
 <20200819095453.GA86@DESKTOP-O1885NU.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200819095453.GA86@DESKTOP-O1885NU.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::27) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.53) by LO2P265CA0231.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 16:43:17 +0000
X-Originating-IP: [217.140.106.53]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 85622ae7-08f1-47cc-d750-08d845282957
X-MS-TrafficTypeDiagnostic: AM6PR08MB3318:|AM6PR08MB3365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3365F9844A08C0E4747E148EED5A0@AM6PR08MB3365.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Gog2+gXjJTlN38m4D1W6ecWYV0qKsGs8sRNUTFR9jHctlolQfDLhRPJn7cWyHeWQwWI2bzS40JGi9EIxOQIT2JsNBNOvHLDAbcHpaMo6hdA7ATv21tmO6q25t+8lLgngeCcyejUOwyYS604BlJ6VplN0vyhZ+TLdE3+HlJ1gu+ORw4EbMhht2yYiwooX74p5jBeGzjSbzE2wOChX79TdvbpoQa1UH+lmP6drNP9w3L1UC+lKddb5y6p7PpZZkH8eZwX6zUMo5ahq+7ulnK4U+IFeCv7SEHsooSeNRpPS7aprr2Hvky0IXRgMPlCbeKxloG6JxKnRhva+JCphjOdEKQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(66556008)(52116002)(83380400001)(37006003)(53546011)(54906003)(66476007)(5660300002)(33656002)(55016002)(26005)(16526019)(8936002)(478600001)(186003)(2906002)(66946007)(2616005)(8886007)(1076003)(36756003)(86362001)(44832011)(316002)(4326008)(6636002)(8676002)(7696005)(956004)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BMC1eYnGUspM8KG0OrkJNMQjAVHZwyEw5+yCB65qeDtH9qFklLHPes7m7Lx06no42d/Cml31V/K+u9K4ScFQ82BK28fmlJsCPjSpLXmw5YovAe0XZP7xdAPzN4HnrcN57iS/ZEbo6GOXG/oOsnLIfIy2UrNyXe4Wx6TFyPv446+z8NZQ7ArnaPBFqniWfJXgjGSXOyLnNvJfiUlN65Zt8SCQEosXHFKOA5JdkVzYT1sG7Q92ZXViC9KwpPnpwcdGIgwdaoLS46rnp/f+StJE53liUP+yOxY1X3XKE4dK+sc7kUYUP1SiHz4LCZlblDCihjAe7aGEq7qycTRgTTyNSMWUwy4dflrcuzRBvAdsj0oKT0XRngkRTzabglh26SSrWww2IB6kqCjrhv9pZmta9KWeAgmXIyC1ODXKvVRi0aELNOjmrEbPRWQoVCw0QVNnNyu+oqJwPYBTsQ6b0lELJ2BFCvmVFST8FHM4lPsLxNKKe7HvkiATzZJEWMDavYmRUma0vR0Pc97scHDOWr63nb0vh6TKRAvLvXqZ/7ukOsWfcQjp40GqFmje32s5t7yw9qAeh2rB5C/KwXQCorcR4GEOas/L1uo8I3XMJhls27ZONZHzhC50mgURJYR38rqIdo6qzkTXcDKzgjitT4GWOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3318
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 56290c20-6043-4de4-2407-08d8452823bd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDAis/PJIrnRWp5n5okayam3IwKYJWExLen8sPAXbTuRLwaGqLmHtfi9/xnxCUh89Ii9AZo8tDO7sRDg3WiBL11fp7hSjgcF0wFuQ62t9P1MCfxXceNov5Ok+kis2jWcc48rayQqtLYLBoWe+R91CBbXtIgmLHOersQRvDAwLu0ZTmINBtBB+mR+Onkb064+2JNICYaLZMMnyXEUqUkIZjGmDr2J03Kh2Wg9UKt/rqJdTd5cfzMeX8fYsWrPHjBU4orRmhlsQgzltZf7MoFNi0GrkPNO7dFWlMFxl2c+sa2ojE+8Pb5+YjHiTIeWEAqCo1t01R9APFglcaqXejo9eyu045pg7dY91GACeCsaORDyLw05uwogx+OfPkmW2KqsPbjDLG+C7e0C5AopMmLQjw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966005)(6862004)(70206006)(6636002)(8676002)(86362001)(81166007)(47076004)(356005)(82740400003)(336012)(70586007)(33656002)(8886007)(316002)(5660300002)(16526019)(83380400001)(186003)(37006003)(82310400002)(53546011)(7696005)(2906002)(44832011)(54906003)(55016002)(956004)(4326008)(2616005)(478600001)(1076003)(36756003)(8936002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 16:43:26.7236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85622ae7-08f1-47cc-d750-08d845282957
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3365
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

adding libc-alpha on cc, they might have
additional input about compat issue handling:

the discussion is about enabling tag checks,
which cannot be done reasonably at runtime when
a process is already multi-threaded so it has to
be decided early either in the libc or in the
kernel. such early decision might have backward
compat issues (we dont yet know if any allocator
wants to use tagging opportunistically later for
debugging or if there will be code loaded later
that is incompatible with tag checks).

The 08/19/2020 10:54, Catalin Marinas wrote:
> On Wed, Aug 12, 2020 at 01:45:21PM +0100, Szabolcs Nagy wrote:
> > On 08/11/2020 18:20, Catalin Marinas wrote:
> > > If we allow such mixed object support with stack tagging enabled at
> > > dlopen, PROT_MTE would need to be turned on for each thread stack. This
> > > wouldn't require synchronisation, only knowing where the thread stacks
> > > are, but you'd need to make sure threads don't call into the new library
> > > until the stacks have been mprotect'ed. Doing this midway through a
> > > function execution may corrupt the tags.
...
> > there is no midway problem: the libc (ld.so) would do the PROT_MTE at
> > dlopen time based on some elf marking (which can be handled before
> > relocation processing, so before library code can run, the midway
> > problem happens when a library, e.g libc, wants to turn on stack
> > tagging on itself).
> 
> OK, that makes sense, you can't call into the new object until the
> relocations have been resolved.
> 
> > the libc already does this when a library is loaded that requires
> > executable stack (it marks stacks as PROT_EXEC at dlopen time or fails
> > the dlopen if that is not possible, this does not require running code
> > in other threads, only synchronization with thread creation and exit.
> > but changing the check mode for mte needs per thread code execution.).
> > 
> > i'm not entirely sure if this is a good idea, but i expect stack
> > tagging not to be used in the libc (because libc needs to run on all
> > hw and we don't yet have a backward compatible stack tagging
> > solution),
> 
> In theory, you could have two libc deployed in your distro and ldd gets
> smarter to pick the right one. I still hope we'd find a compromise with
> stack tagging and single binary.

distros don't like the two libc solution, i
think we will look at backward compat stack
tagging support, but we might end up not
having any stack tagging in libc, only in
user binaries (used for debugging).

> > so stack tagging should work when only some elf modules in a process
> > are built with it, which implies that enabling it at dlopen time
> > should work otherwise it will not be very useful.
> 
> There is still the small risk of an old object using tagged pointers to
> the stack. Since the stack would be shared between such objects, turning
> PROT_MTE on would cause issues. Hopefully such problems are minor and
> not really a concern for the kernel.
> 
> > do tag checks have overhead if PROT_MTE is not used? i'd expect some
> > checks are still done at memory access. (and the tagged address
> > syscall abi has to be in use.)
> 
> My understanding from talking to hardware engineers is that there won't
> be an overhead if PROT_MTE is not used, no tags being fetched or
> checked. But I can't guarantee until we get real silicon.
> 
> > turning sync tag checks on early would enable the most of the
> > interesting usecases (only PROT_MTE has to be handled at runtime not
> > the prctls. however i don't yet know how userspace will deal with
> > compat issues, i.e. it may not be valid to unconditionally turn tag
> > checks on early).
> 
> If we change the defaults so that no prctl() is required for the
> standard use-case, it would solve most of the common deployment issues:
> 
> 1. Tagged address ABI default on when HWCAP2_MTE is present
> 2. Synchronous TCF by default
> 3. GCR_EL1.Excl allows all tags except 0 by default
> 
> Any other configuration diverging from the above is considered
> specialist deployment and will have to issue the prctl() on a per-thread
> basis.
> 
> Compat issues in user-space will be dealt with via environment
> variables but pretty much on/off rather than fine-grained tag checking
> mode. So for glibc, you'd have only _MTAG=0 or 1 and the only effect is
> using PROT_MTE + tagged pointers or no-PROT_MTE + tag 0.

enabling mte checks by default would be
nice and simple (a libc can support tagging
allocators without any change assuming its
code is mte safe which is true e.g. for the
latest glibc release and for musl libc).

the compat issue with this is existing code
using pointer top bits which i assume faults
when dereferenced with the mte checks enabled.
(although this should be very rare since
top byte ignore on deref is aarch64 specific.)

i see two options:

- don't care about top bit compat issues:
  change the default in the kernel as you
  described (so checks are enabled and users
  only need PROT_MTE mapping if they want to
  use taggging).

- care about top bit issues:
  leave the kernel abi as in the patch set
  and do the mte setup early in the libc.
  add elf markings to new binaries that
  they are mte compatible and libc can use
  that marking for the mte setup. dlopening
  incompatible libraries will fail. the
  issue with this is that we have no idea
  how to add the marking and the marking
  prevents mte use with existing binaries
  (and eg. ldpreload malloc would require
  an updated libc).

for me it's hard to figure out which is
the right direction for mte.

> > > In the presence of stack tagging, I think any subsequent MTE config
> > > change across all threads is unsafe, irrespective of whether it's done
> > > by the kernel or user via SIGUSRx. I think the best we can do here is
> > > start with more appropriate defaults or enable them based on an ELF note
> > > before the application is started. The dynamic loader would not have to
> > > do anything extra here.
> > > 
> > > If we ignore stack tagging, the global configuration change may be
> > > achievable. I think for the MTE bits, this could be done lazily by the
> > > libc (e.g. on malloc()/free() call). The tag checking won't happen
> > > before such calls unless we change the kernel defaults. There is still
> > > the tagged address ABI enabling, could this be done lazily on syscall by
> > > the libc? If not, the kernel could synchronise (force) this on syscall
> > > entry from each thread based on some global prctl() bit.
> > 
> > i think the interesting use-cases are all about changing mte settings
> > before mte is in use in any way but after there are multiple threads.
> > (the async -> sync mode change on tag faults is i think less
> > interesting to the gnu linux world.)
> 
> So let's consider async/sync/no-check specialist uses and glibc would
> not have to handle them. I don't think async mode is useful on its own
> unless you have a way to turn on sync mode at run-time for more precise
> error identification (well, hoping that it will happen again).
> 
> > i guess lazy syscall abi switch works, but it is ugly: raw syscall
> > usage will be problematic and doing checks before calling into the
> > vdso might have unwanted overhead.
> 
> This lazy ABI switch could be handled by the kernel, though I wonder
> whether we should just relax it permanently when HWCAP2_MTE is present.

yeah i don't immediately see a problem with that.
but ideally there would be an escape hatch
(a way to opt out from the change).

thanks

