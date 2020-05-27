Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780D01E3F36
	for <lists+linux-arch@lfdr.de>; Wed, 27 May 2020 12:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgE0KiB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 May 2020 06:38:01 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:23425
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729876AbgE0KiA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 May 2020 06:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC8hu/BFQIM7H4j/7IxzeLC11M3CPA3knApPExMqh5o=;
 b=OuSDJehM9/2x73TsGXFhJUdZg1fictz+TS21pGGoFuYcW2GZRhEqB+mqUjlNiO5BI7oe8ywuhitVFOEaUvI/xsggsC1KRg5eu7Ary1PdbER6KOPK0/y+V6GFbCOw0BfxnolRcRhikPHVLgdn5q9aL+zw7UEOlQxeO3arcrBF1eE=
Received: from DB3PR06CA0016.eurprd06.prod.outlook.com (2603:10a6:8:1::29) by
 AM5PR0802MB2500.eurprd08.prod.outlook.com (2603:10a6:203:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 10:37:54 +0000
Received: from DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::c3) by DB3PR06CA0016.outlook.office365.com
 (2603:10a6:8:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Wed, 27 May 2020 10:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT029.mail.protection.outlook.com (10.152.20.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 27 May 2020 10:37:54 +0000
Received: ("Tessian outbound cff7dd4de28a:v57"); Wed, 27 May 2020 10:37:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fd040cad52335522
X-CR-MTA-TID: 64aa7808
Received: from 172cffbdcd5a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 01E3EC68-FE3A-429D-9424-4D5CCE0DDFCE.1;
        Wed, 27 May 2020 10:37:48 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 172cffbdcd5a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 May 2020 10:37:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgxfJkHG3oCxKmHQ5pAS5YNhV+g2y8CsR7jA7uaY+L/XPlh82l2iLHvAukFis0MA13AKwEeF4q0JzOJRTlvCjtcYHQ/qYc+V6sV2qPpPLfB7avegO48JV4IE1YngNzjtHVXl3dRF8SDRHNicFz0E0JTCmi9aRvOAwwnhBkWsv70vS0FJIkekb4hN6ar3JJm9pxdLrLiszaF6YrF4KiMlsVg4qVHQwXyNgmcEuafCUFAVF5DtyolfMSp0lw1TdC+WqcYmssWJI+sBZe7tq138DUHP1qPYzUL6FJKn7CDZsXV97HDUieCbyS7h3CKjWdeoXg8gAj6yOPO1r0GRjpuYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC8hu/BFQIM7H4j/7IxzeLC11M3CPA3knApPExMqh5o=;
 b=V48bEE2f7QqRa34fHI4uxbem4RvSrLWr95H6qqAbi8JIUwC12uuoZG2YNJVio5J90mKT1wdzuFdTK5GUKd0joyON59QWGM6ZPaY0FXzLJtppPShLEiGR7sy6T8vxY1p7P2eTEYgSYPjueLS4bzNc2X8zd06ZVyBO5yM9mccQoZUG7c57UI21nsbmxHoPJv+sMqZk2OqQcQUKjpLhFq5qnYO7IJjV3n22Gqs5Fdtc05hWT9GZU3lwUlzYvNLFiuUQd256Kc34MPkPBY1bspdkyXnzG6H7KJYsySofv+CcQtrqAfKR9TMoQY7LOxTPbdUNdBsHYyCq+2qRFYhlyR/POA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC8hu/BFQIM7H4j/7IxzeLC11M3CPA3knApPExMqh5o=;
 b=OuSDJehM9/2x73TsGXFhJUdZg1fictz+TS21pGGoFuYcW2GZRhEqB+mqUjlNiO5BI7oe8ywuhitVFOEaUvI/xsggsC1KRg5eu7Ary1PdbER6KOPK0/y+V6GFbCOw0BfxnolRcRhikPHVLgdn5q9aL+zw7UEOlQxeO3arcrBF1eE=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4150.eurprd08.prod.outlook.com (2603:10a6:20b:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 10:37:44 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 10:37:44 +0000
Date:   Wed, 27 May 2020 11:37:42 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Patrick Daly <pdaly@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v4 24/26] arm64: mte: Introduce early param to disable
 MTE support
Message-ID: <20200527103741.GB24512@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
 <20200515171612.1020-25-catalin.marinas@arm.com>
 <a2ad6cbf-2632-3cda-eb49-74ddfbed2cec@arm.com>
 <20200518113103.GA32394@willie-the-truck>
 <20200518172054.GL9862@gaia>
 <20200522055710.GA25791@pdaly-linux.qualcomm.com>
 <20200522103714.GA26492@gaia>
 <20200527021153.GA24439@pdaly-linux.qualcomm.com>
 <20200527095504.GB11111@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200527095504.GB11111@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0445.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::25) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0445.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 10:37:43 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 193b80cf-5cd4-4ded-9a14-08d8022a03a4
X-MS-TrafficTypeDiagnostic: AM6PR08MB4150:|AM5PR0802MB2500:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2500CE42802381C6711C587BEDB10@AM5PR0802MB2500.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XHvcw5wLFxQljxNlGP2UKVy8VNcEuwmnFZVuY6UKtgh4F0IynNrj+TudEYO4M105GmmFB9uw2WTspFUYGObV/EX1wiWyBwC1P2gdVNsAC35kaQgOXq5ZdyQGiQQyj+fVEfmqMAxIvMDdpEVSDM0lV54wIOBrrExeH9FWhGmh730t12NU6ncHb3zRMu/8vpsl0qijnUBEzEpIxQkQowl4VptMw/GIsw+xK+yZNM2ourXO40vS1QAGemrOeRXAFIwOxowRU0DtySgmjMf05Zu9NyD0wY4oOgnCCCowSv3lKGUZHKoyux2x35C/yDOtSrsMXfVtvgf2eNm7LBTfVvFvsw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(8936002)(36756003)(55016002)(478600001)(8886007)(6916009)(83380400001)(1076003)(86362001)(66476007)(66946007)(66556008)(5660300002)(8676002)(44832011)(2616005)(956004)(4326008)(16526019)(316002)(33656002)(26005)(186003)(52116002)(7696005)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WU5/LU97yIkZ2I/dQRNtktSaeffzR3B4ITIqJp3W75hWS+e6EiqDeLVk1ctV8obtN/qSFzHxtF172eakKM6UPy57diYeNX5xvEvXznL//JGX1W2LA3Gy5fmepbpTd0l6IKOO38qqdbS2nfRItNXoAl6rUdygJAqKgeDQh/3oaZ2GhDJvPLCuciFrLk4jevjtIR0NxGg1UVUtH0acTspQ66IuHnKM0ufn5aDfk5sGC6vWxOANq7OErTUon366W5QDCBSSg/si7hnRHFC23334qlgaCAdIyN9tZZADab/ag7Sm6COfoTXY4f8JcDQJwvhj2sqAOKB0s1TqqTnuuzySePNioQAazAh5vKDR8w5im0u47QbvpgcDX0TE+GzRlfSIQdycP7IjmLBElwS2zkB1ygErUNB9utqJQegBuUxqCyB25mvt1nebdjUIa42eOR2Gdsy/iqmic47vFPfBdf1Ls8BZ9iYRG86x1Dkvx8GqtJgOAY5F/Lj2+H6ge+xCGAmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4150
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966005)(316002)(16526019)(26005)(82740400003)(186003)(6862004)(44832011)(956004)(336012)(70206006)(2616005)(83380400001)(70586007)(81166007)(8886007)(7696005)(2906002)(47076004)(478600001)(33656002)(54906003)(5660300002)(356005)(55016002)(86362001)(8676002)(8936002)(4326008)(82310400002)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2235684d-8977-4109-faf9-08d80229fd41
X-Forefront-PRVS: 04163EF38A
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /f20NGzTKLXuaSdCn5m7tkD3k/5Sq7ak4o2yLM8OqXCOzmnXLZw0g6gii1w4MbAj84Cyx7EeDMr+MgpJsx0yL1A7kKynQo0hK68OfVelI2lVcjefG2ECJEpskzjmIw9BEfAL0m42N5jfPjZXSNd4oT+BzPyiI566vaNq0F8iG/lu3rOiW/B2rN75lN7a8JcCJzzw3lAE7RaG8QK5oiAg0BXpwqkUSOp+dX6LcACAmLyEpeHZFjQeR5PPHkrc79Ag6+ElujPBUUKCT0lObxQDjnAGnAHE86gQ9pYklTl0DNSE4QFrjGFIt5OgtIgHoAYbO8QqAlN6sOgqDukkG9gSLB5XepNjVCpCbShNLGQhD7nV/jG1fH2Jvfo8P0T6TM9Mo8f60SdV2VB2d708yMjnjg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 10:37:54.5861
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 193b80cf-5cd4-4ded-9a14-08d8022a03a4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2500
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 05/27/2020 10:55, Will Deacon wrote:
> On Tue, May 26, 2020 at 07:11:53PM -0700, Patrick Daly wrote:
> > On Fri, May 22, 2020 at 11:37:15AM +0100, Catalin Marinas wrote:
> > > The actual question here is what the on/off behaviour is needed for. We
> > > can figure out the best mechanism for this once we know what we want to
> > > achieve. My wild guess above was performance analysis but that can be
> > > toggled by either kernel boot parameter or run-time sysctl (or just the
> > > Kconfig option).
> > > 
> > > If it is about forcing user space not to use MTE, we may look into some
> > > other sysctl controls (we already have one for the tagged address ABI).
> > 
> > We want to allow the end user to be able to easily "opt out" of MTE in favour
> > of better power, perf and battery life.
> 
> Who is "the end user" in this case?
> 
> If MTE is bad enough for power, performance and battery life that we need a
> kill switch, then perhaps we shouldn't enable it by default and the few
> people that want to use it can build a kernel with it enabled. However, then
> I don't really see what MTE buys you over the existing KASAN implementations.
> 
> I thought the general idea was that you could run in the (cheap) "async"
> mode, and then re-run in the more expensive "sync" mode to further diagnose
> any failures. That model seems to work well with these patches, since
> reporting is disabled by default. Are you saying that there is a
> significant penalty incurred even when reporting is not enabled?
> 
> Anyway, we don't offer global runtime/cmdline switches for the vast majority
> of other architectural features -- instead, we choose a sensible default,
> and I think we should do the same here.

i would not expect mte overhead if userspace processes
don't map anything with PROT_MTE and don't enable tag
checking with prctl. (i.e. userspace runtimes can "opt
out" of mte for better power, perf and battery)

is that not the case?
