Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877E628F0C7
	for <lists+linux-arch@lfdr.de>; Thu, 15 Oct 2020 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgJOLOt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 07:14:49 -0400
Received: from mail-eopbgr20074.outbound.protection.outlook.com ([40.107.2.74]:4481
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726987AbgJOLOs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Oct 2020 07:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuIOZqds7HVmTbwOkKNoCaPeCnxVgYGSP9f3kGwQKOk=;
 b=vpsjFyG1H2gNEPKuSdkIzlCxk95q9e9GSsRgHQ1nH2RfIENghHqhlVKJPSH7Hw3E4F4S2NPLVCQcMHZvK7LG5WbSA12OqlRLotZpaPEXHoKIroqFhYU3UOg422AITd8QRNuYyFgvkOKF7C4HUWG0CUryOAVFI+/ePXOXrOmFXbw=
Received: from DB7PR03CA0087.eurprd03.prod.outlook.com (2603:10a6:10:72::28)
 by PA4PR08MB6013.eurprd08.prod.outlook.com (2603:10a6:102:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 11:14:41 +0000
Received: from DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:72:cafe::4c) by DB7PR03CA0087.outlook.office365.com
 (2603:10a6:10:72::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend
 Transport; Thu, 15 Oct 2020 11:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT006.mail.protection.outlook.com (10.152.20.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 11:14:41 +0000
Received: ("Tessian outbound 7c188528bfe0:v64"); Thu, 15 Oct 2020 11:14:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fc332f62fda21c8e
X-CR-MTA-TID: 64aa7808
Received: from 8287c33b6d53.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FA1D8D6E-496F-4C48-9AB8-1B1F40713AC3.1;
        Thu, 15 Oct 2020 11:14:35 +0000
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8287c33b6d53.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 15 Oct 2020 11:14:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqySt0VdIDls9J3OxeFdqxkYVn5nBSjobXLBdASELCsUkK7z75352GMm57li/goUPF/xs2EFTuK47fHHZ2GWy71FCH1kN9xPNOm7xGTMwSuHaj6+e0jUibrNDxnsQbjIA6K1w8mAWsI2DD7h9QSORQByXyQ18cq2likwj5Kj2kCldt0uiR4v8P1A7EIf6bD2HBHPo/wxO4YqC/whC8EurtwUZLZt7V2Iu3SRKadVCw4XUAvLfC8Xn/BjY1zMtL6FDl+54Uv/s0167V29+I/D8kX8qWmfM9o96etcybZ+YG4THuWI/BytfOedjTXXHcvWdmF0og2cbxlvghhcShUplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuIOZqds7HVmTbwOkKNoCaPeCnxVgYGSP9f3kGwQKOk=;
 b=cXdMU+kv0NH80NK3V50fgBTWiK6WomVjfrKGG93T21rKExe9RMRMJo0U6s1wv6MX0iyh9OjFGYIvMYZlVnL8nzhEdIgM9/ULnjhwMK1cNyVviUHvsIK7gZMLBv9VBqnX93JPyQ44idrepX057nSCPEu+UsMtMmsvLkRJQ+/SxstyHoyFYIeCqnYfZBove2p0Z8d1L5EOqaXccu0hWoTFT4ENg5OaCKzauuAR5Hxy41cOzLLtXmfD0y+XZxCdHqsRo4kfXXSILr3WXzBsljHwLXU5/KeRwjbm5svFWF7/I63l40Cf9aqIfwghLpWuDJHm5R5OlaDcHmdponKgqWxT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuIOZqds7HVmTbwOkKNoCaPeCnxVgYGSP9f3kGwQKOk=;
 b=vpsjFyG1H2gNEPKuSdkIzlCxk95q9e9GSsRgHQ1nH2RfIENghHqhlVKJPSH7Hw3E4F4S2NPLVCQcMHZvK7LG5WbSA12OqlRLotZpaPEXHoKIroqFhYU3UOg422AITd8QRNuYyFgvkOKF7C4HUWG0CUryOAVFI+/ePXOXrOmFXbw=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR2PR08MB4809.eurprd08.prod.outlook.com (2603:10a6:101:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Thu, 15 Oct
 2020 11:14:33 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::957e:c80e:98f4:23d6%6]) with mapi id 15.20.3477.021; Thu, 15 Oct 2020
 11:14:32 +0000
Date:   Thu, 15 Oct 2020 12:14:30 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>, nd@arm.com
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20201015111429.GH3819@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
 <20200917161550.GA6642@arm.com>
 <20200918083046.GA30709@willie-the-truck>
 <CAMn1gO76z7eLcuYg_PuWPCq7_N5p29518EGy-FdY9AvyY0fDgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMn1gO76z7eLcuYg_PuWPCq7_N5p29518EGy-FdY9AvyY0fDgw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15)
 To PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P123CA0027.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 11:14:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cf133ffb-f9a5-40cf-8291-08d870fb830f
X-MS-TrafficTypeDiagnostic: PR2PR08MB4809:|PA4PR08MB6013:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PA4PR08MB6013991642C66EC9506BBCF7ED020@PA4PR08MB6013.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NX2AUxlMVd9jQRl2laYVGpDVKath54SGObtuRNWfOPgP3k+LDKnI8nnQyT9i+0e1W07uCz5puU0ANKljblOoDyNFy9uCqvw+de5Kg8tE8/h87I2P7VwhIxsnhwdNyr/73mG4ZQDJIPumSYV3qW7wZTaDLQv73KU2YTDYD5xuQ6iIlNjViOJvN7AYHGKDOAhEnh7Oe3bQQtbyrbVk8LAljuMJyE7bCZb3ID36VjCKbuNqgscjXhH9RC5YE81H4Kyy5lenhU06V9bFWahilnPXa/dT1opAp9ybNo8WsNB6Uoa1J4NjOrn7+cT8dBoMfZPX434CFAZggy3vbT0Wwd7NzTQ+Pn/5dzrKjg/zvt7sU6BV+2sSKYYI79rT6VftbxYbwZQ0bn3BqspaePnzBL69tXtXZY+7OrKfu9F6BFttfhk2I8huVzqLS0xa2+2a7FZI48FflPghABSjt9EwtrO5Hg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(36756003)(54906003)(55016002)(2616005)(316002)(83080400001)(66476007)(186003)(66556008)(66946007)(966005)(956004)(83380400001)(86362001)(16526019)(8886007)(34490700002)(33656002)(7696005)(8936002)(1076003)(4326008)(53546011)(478600001)(2906002)(8676002)(26005)(52116002)(5660300002)(44832011)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Udh2321Ap8jwL6VBn4sOtJy9q1/VXlpUvEnGGO5hwBoSm/wfayNxTz3b+HOohyuKay9CicOSqNDyoa9y4Y77vNwGbXVUvuptX1H9PT7ieRh9XPzU31BcBbqb0vVNfwRVlS7Crng2iFMyHtW/Kqs8hQD+YOi8WRilFpoxaqZqdu3CrKIKSsbMhkqsh1JFkog/eH72K7AFHrLadJ3NOhwoFZ5fWM4UzkUb0QorqFj59/Pra48+fkffNB2PsT9fkpe8ogRp/VXYlfC/FoYxrD4hcTR+1VF/0dR3T4txeh41uM6S5y31+hM0lBCd7/rirda3BifZHhoK1xne2oLDS/SdOvm3LwW3j0IA64LPGJIVSSyrumGE30IxJ3hODNL/aBzIRWPh36UHV8mcVZsrHoM7O4AuAoXaMqgVaG9+voDpTYOoLrC4l+cKgifpi04PGoEywG5uyuYSiJcMsrSEu4qBoQFzIMZUSTnYJx5amFSwP9Fkc64C3x1sTL4kTz/CW7XX1ND0oQgSDPeaI8LcAiEa0n0B445JeIyT8NGmR/Nr+O0LVTMLbJsB57vqw2XsrFeD+8jkGuXyd+bomkFMjgiK4d6uf2T0xdZwnpHE+XSj/3C6U3Ey2fCwpYN+5duBMFFjp2iq6FZRlTJGSkhqO8p5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4809
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9bfad322-18db-498a-9ba9-08d870fb7dfb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvSLCHlIIQ3mE6Rf9zuqQhPp0L1cjvRjP9LPpygMQ7+mPHJDcWzPgJhoDt+IP7O+jYlnMpPBgsZlbhfluAhrQWW1n7n9UEPBju2tsj8sau26ViCWQf9YBmuo77P+q0byPMH+9tFr/MQTXYjAVzw7jyJq9WmJ7b4pVZ9ZPtjtAHY/sLDc2S2ymC6zZfZkx/x1VHKOHDh1FkcA0c2fQgIU2QddzD5XnpoXtjoHItZrRfdTUMrBYuR5X3zE/fgGiBUbNLt8HFX4slgAuSRrI3TRk0ITt7Z9RxvcSqcQavnPWfhn0YHc+NReel6hgxJRlSi0bTkNvGizbAxXw+0pLv55Ds1ARA6Zb47A1P3luk8Tnae6Wh6u+wRChwXubPUR7Hvn+50s6wC0CRS4kL0eiZf2bQMybzYRrlfcFxAArwaLNKvZnxqjk9dXrLESpSKTGQ8KVpPUli0k+LmMUXHKIIZI+9Q3ppBAzbY7d06LvH/Q9cI=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(46966005)(4326008)(81166007)(82740400003)(316002)(83080400001)(36756003)(83380400001)(966005)(54906003)(44832011)(7696005)(1076003)(336012)(47076004)(55016002)(86362001)(478600001)(356005)(82310400003)(5660300002)(8886007)(26005)(8676002)(70206006)(53546011)(70586007)(186003)(16526019)(956004)(2906002)(6862004)(8936002)(33656002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 11:14:41.0789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf133ffb-f9a5-40cf-8291-08d870fb830f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6013
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 10/14/2020 16:43, Peter Collingbourne wrote:
> On Fri, Sep 18, 2020 at 1:30 AM Will Deacon <will@kernel.org> wrote:
> > I think so, yes. I'm hoping to queue it for 5.10, once I have an Ack from
> > the Android tools side on the per-thread ABI.
> 
> Our main requirement on the Android side is to provide an API for
> changing the tag checking mode in all threads in a process while
> multiple threads are running. I think we've been able to accomplish
> this [1] by using a libc private real-time signal which is sent to all
> threads. The implementation has been tested on FVP via the included
> unit tests. The code has also been tested on real hardware in a
> multi-threaded app process (of course we don't have MTE-enabled
> hardware, so the implementation was tested on hardware by hacking it
> to disable the tagged address ABI instead of changing the tag checking
> mode, and then verifying via ptrace(PTRACE_GETREGSET) that the tagged
> address ABI was disabled in all threads).
> 
> That being said, as with any code at the nexus of concurrency and
> POSIX signals, the implementation is quite tricky so I would say it
> falls more into the category of "no obvious problems" than "obviously
> no problems". It also relies on changes to the implementations of
> pthread APIs so it wouldn't catch threads created directly via clone()
> rather than via pthread_create(). I think we would be able to ignore
> such threads on Android without causing compatibility issues because
> we can require the process to not create threads via clone() before
> calling the function. I imagine this may not necessarily work for
> other libcs like glibc, though, but as I understand it glibc has no
> plan to offer such an API.

no immediate plans.

to make such api useful we would have to expose it to
users (e.g. custom allocators) which is tricky.

note that glibc has the necessary infrastructure to do
the internal signaling, but it had issues in the past.

i think it had problems with qemu-user and golang c ffi
and libc internal issues around multi-threaded fork/vfork
or simply stack overflow because of small thread stacks
and growing signal frames that are more likely to hit
at the wrong time if libc uses more internal signals.

so i think such per process operation is easier to handle
correctly in the kernel.

doing this outside of the libc (e.g. in a custom allocator)
is not possible (without relying on new libc apis) which i
thought was a reasonable use-case, but likely glibc will
enable sync tag checks early and leave it that way (the only
tricky bit is to have an opt-in/-out mechanism for binaries
that are not compatible with the tagged address abi and
i don't know yet how that will work).

> [1] https://android-review.googlesource.com/c/platform/bionic/+/1427377

btw in the bionic implementation there are writes to
globals (g_tcf, g_arg, g_func) that are later read in
signal handlers of other threads without atomics. i'm
not sure if that's enough synchronization (can we
assume that tgkill synchronizes with signal handlers?).
