Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ABE1D4C34
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 13:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgEOLOQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 07:14:16 -0400
Received: from mail-eopbgr20048.outbound.protection.outlook.com ([40.107.2.48]:14372
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbgEOLOP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 07:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKqypdRt0eM7h+oJLaSFaZRxLz9VoWNKQ7BPuDV+APA=;
 b=d8HSI4svamBKJEAqMkyhUn523+w4pRMcPkNCHn0sraW4MxL89t4PkNE7DZQZkDonUnyI/s5CY8DmEvSmbqCCDhzg/z0nY5XE0WybLEvN3P1h+IqOAh9BAu+r1MnU1QAhTZxXo+zNbjml/fNhribMRzmURHdjNWtLbNquc26/SXo=
Received: from MR2P264CA0144.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:30::36)
 by DB8PR08MB5259.eurprd08.prod.outlook.com (2603:10a6:10:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 11:14:10 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:30:cafe::75) by MR2P264CA0144.outlook.office365.com
 (2603:10a6:500:30::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Fri, 15 May 2020 11:14:10 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.19 via Frontend Transport; Fri, 15 May 2020 11:14:10 +0000
Received: ("Tessian outbound 5abcb386707e:v54"); Fri, 15 May 2020 11:14:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f033ae43b31de339
X-CR-MTA-TID: 64aa7808
Received: from 4cf287762eb4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BB8A5372-111C-4715-B4BF-A1100C5A5DD9.1;
        Fri, 15 May 2020 11:14:04 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4cf287762eb4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 May 2020 11:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQqDJcmxhv2b8ZxTwLzdZUmV0g6LO0t/YYdpcxpbHlGrmbic1I7pU+ckq4rqovW4rYEVUdfdhKyzoy0PC9vjPBmW+qzqs79UxatGwlMxJb8jFtdMrjWVXtqYDfFmY8bEpZjv+3+fciq+LMhHt1PbIFAwue17nlnbZ9yJgQDiMcAwDYnffJ6yaXqHPAYlhYewnZj3AIxhHsYsFpALQohZYLr2U9lIXenkZhrq/yTKtVGpz/A1ZleeyDqEx+ST3IApL4QSW2dBBIYJzeRCzhI1+bjBpowfFdIiA4usJMo867y1r2PEbhiIQsEFR5YjkbcgDoc9Tfx95790JFBe3SbgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKqypdRt0eM7h+oJLaSFaZRxLz9VoWNKQ7BPuDV+APA=;
 b=O6kokDp42tv1AyhNGDc9HxJMICwjxn5GegZ55wCq2pkAaKFS01d64cEflKZEkkqnifvUWtSIn5h0t4rCU0+ZoFBtvfRdH8AELmqzqrusJUaR2EWyYVYAPAX3vp0UD2nnaYWKM2A9nGXmQJu0MrDqqS3GtKLrgWKtWq+tRMjkR6C0xUcibtTjR2lgIoFi0MU7J9X2eWMHSqux597vHhxcdd7NRj0OEvqRtIWViIfXEquzWcK/2UkV6LfWaA9rmCP6SoDsDpL/HEqb863mTeLaBvl0wSppSpI2nNdNBt0JBGw3uqmTsasCNjm0NpEIpzrHSSKZPcvqkKnO5buqVjswSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKqypdRt0eM7h+oJLaSFaZRxLz9VoWNKQ7BPuDV+APA=;
 b=d8HSI4svamBKJEAqMkyhUn523+w4pRMcPkNCHn0sraW4MxL89t4PkNE7DZQZkDonUnyI/s5CY8DmEvSmbqCCDhzg/z0nY5XE0WybLEvN3P1h+IqOAh9BAu+r1MnU1QAhTZxXo+zNbjml/fNhribMRzmURHdjNWtLbNquc26/SXo=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4819.eurprd08.prod.outlook.com (2603:10a6:20b:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 11:14:02 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 11:14:02 +0000
Date:   Fri, 15 May 2020 12:14:00 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, nd@arm.com
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200515111359.GC27289@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-24-catalin.marinas@arm.com>
 <20200429164705.GF30377@arm.com>
 <20200430162316.GJ2717@gaia>
 <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
 <20200515103839.GA22393@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515103839.GA22393@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0268.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::16) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0268.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Fri, 15 May 2020 11:14:01 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a43650e1-9e14-4ca3-0052-08d7f8c1176f
X-MS-TrafficTypeDiagnostic: AM6PR08MB4819:|DB8PR08MB5259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB5259C2646E531ADA5DEC87D7EDBD0@DB8PR08MB5259.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LvQxsvDBOa6XRENjWMPTfjdR0XM7M2QsPjEH++FH59HNajPDx08Q0p1s5v4s5VlyybTpXBFYudCTV/D0j7fU8cyNhbklCtTt6AaZMlED57UMDaDt3RQtu6wm0Z3RlISDyR7aeVKc9Pv1LgNFfpms6Z2pEV/1FsqQgmKfUPqSH2qv8vaalEJSHEGCcuJzK5LHbhHdEHoL3rapCdqmMcAHrlz4PS8Cq/JLV3jPyTClaOit70PnnS9dWtYlgiTnz43MAjCS21vjgLHhtD0ELCWOIGoJBX1L1b1Ye1JEGsULY2nS/EzIXP+4J7ZaeFQwBqfwbUiYApzs2XPL019yevIYteX20RQNq0Qvy0t00J+7hz5WCP5vWag5aHpy4ZVmCZuDNWp0bddhoGgd9LsBI49bGxpyzh/Yk5wfrXI2I3UquA7S12PE2413yaBcTujG8wNe
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(26005)(6862004)(4326008)(478600001)(186003)(16526019)(956004)(44832011)(7696005)(52116002)(55016002)(2616005)(8886007)(5660300002)(33656002)(2906002)(36756003)(8936002)(54906003)(37006003)(86362001)(6636002)(8676002)(66946007)(66556008)(316002)(1076003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +6Eyr3AszXQQJNIJW/+tGeKL30AckYwkhsNCYcHp3zFmOX8hY/tF46PnZZM+8BFNEJXiqVI6FEvgvsRiIY68Hw2IdOLY3chcbShUFwebdk54h8Lc4Q3abXwFeXRyndIt8BlToQjRMSE2aInkg8xYo8IzldaFyPp3T3R2m85uCLoGLokOvnXh3lnfnPiD7MupqUlRlvxuEB/mLUpX7OBSNtCvncFSwFlM99043vYxyhpoiX/F7Rz5/G4XiDTvD51gZfiKL2+rfLbIO4XvQ96SASQxo+RfRONPVn096hTSZLftTl+vXa41LaIIeB76Lic2PdCK9RWias9zyE+hlUiay2anTIEHYXe4410JnISh/ICFP6efG7iPtSuAuiI0jz4pekqqX0COSJNiQU+KsiLhI+dlDnrYLPagIWEOCyKKUyPUn6X9sp1Fk3tdS50SRU9WEGdEnqtKJ3l0qbv1518QapwcB7o5Yk+fYMy460hQcSmY7sa/D/Trx11zzyEGCPzY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4819
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(26005)(6862004)(4326008)(47076004)(44832011)(55016002)(6636002)(336012)(33656002)(956004)(82740400003)(70206006)(54906003)(37006003)(478600001)(70586007)(2616005)(8886007)(36906005)(356005)(82310400002)(7696005)(81166007)(5660300002)(1076003)(86362001)(186003)(8936002)(316002)(36756003)(8676002)(16526019)(2906002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 672a0ece-bf7b-49b2-dacd-08d7f8c1129e
X-Forefront-PRVS: 04041A2886
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uf/FT5Lz0izGTIRjMEeAmTfsPwPNDuKJW8/3hXmCWZOO8klw9kNOzvOhlpXpR6mFoIatZ5WCtc62vMlIrkjdf2WhBOJlA2ncwm3t93Nywahn9QttQ27CF6vKmg+JInJYGEzOourKXheiykApHlj13ldyaOEV7mUWedoFODCenh8NxZtU6MtLeg+ftUoySWze6mzb405jJuNG8vPsZ7fDTaW/CTcWW0foxMoYdGa8jiEWW061Geq+oWW9JzouoDodajFPMUuobg1/NiWTeygPnaUgriIW6fccZhUWx6urkbRt7cr5GoeLupxK1Q7MBbDydaeyWPj25t//vQnmHuUhby1OCy7doI0phNpSSGm2m80oC1Jy5LDIl93uh45ozJycgkO/E3rMMndGeFdRZAhLEWts4H9ajyoPrVz+/9npkUCj055PG2Aq5p0WuYZ4yFLY4gOt4B07vzyZYiqLGwG0xPUFjREBGL5QgBiMQmW6pFQU3XCGKeHfpNRwnC07fDdKWjOLRoIttDX9uafQ+DoHtw==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 11:14:10.0662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43650e1-9e14-4ca3-0052-08d7f8c1176f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5259
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 05/15/2020 11:38, Catalin Marinas wrote:
> On Thu, May 14, 2020 at 12:37:22PM +0100, Catalin Marinas wrote:
> > On Wed, May 13, 2020 at 04:48:46PM +0100, Dave P Martin wrote:
> > > > > > On Wed, Apr 29, 2020 at 05:47:05PM +0100, Dave P Martin wrote:
> > > > > > > On Tue, Apr 21, 2020 at 03:26:03PM +0100, Catalin Marinas wrote:
> > > > > > > > +excludes all tags other than 0. A user thread can enable specific tags
> > > > > > > > +in the randomly generated set using the ``prctl(PR_SET_TAGGED_ADDR_CTRL,
> > > > > > > > +flags, 0, 0, 0)`` system call where ``flags`` contains the tags bitmap
> > > > > > > > +in the ``PR_MTE_TAG_MASK`` bit-field.
> > > > > > > > +
> > > > > > > > +**Note**: The hardware uses an exclude mask but the ``prctl()``
> > > > > > > > +interface provides an include mask. An include mask of ``0`` (exclusion
> > > > > > > > +mask ``0xffff``) results in the CPU always generating tag ``0``.
> > > > > > > 
> > > > > > > Is there no way to make this default to 1 rather than having a magic
> > > > > > > meaning for 0?
> > [...]
> > > The only configuration that doesn't make sense is "no tags allowed", so
> > > I'd argue for explicity blocking that, even if the architeture aliases
> > > that encoding to something else.
> > > 
> > > If we prefer 0 as a default value so that init inherits the correct
> > > value from the kernel without any special acrobatics, then we make it an
> > > exclude mask, with the semantics that the hardware is allowed to
> > > generate any of these tags, but does not have to be capable of
> > > generating all of them.
> > 
> > That's more of a question to the libc people and their preference.
> > We have two options with suboptions:
> > 
> > 1. prctl() gets an exclude mask with 0xffff illegal even though the
> >    hardware accepts it:
> >    a) default exclude mask 0, allowing all tags to be generated by IRG
> >    b) default exclude mask of 0xfffe so that only tag 0 is generated
> > 
> > 2. prctl() gets an include mask with 0 illegal:
> >    a) default include mask is 0xffff, allowing all tags to be generated
> >    b) default include mask 0f 0x0001 so that only tag 0 is generated
> > 
> > We currently have (2) with mask 0 but could be changed to (2.b). If we
> > are to follow the hardware description (which makes more sense to me but
> > I don't write the C library), (1.a) is the most appropriate.
> 
> Thinking some more about this, as we are to expose the GCR_EL1.Excl via
> a ptrace interface as a regset, it makes more sense to move back to an
> exclude mask here with default 0. That would be option 1.a above.

i think the libc has to do a prctl call to set
mte up and at that point it will use whatever
arguments necessary, so 1.a should work (just
like the other options).

likely libc will disable 0 for irg and possibly
one or two other fixed colors (which will have
specific use).

the difference i see between 1 vs 2 is forward
compatibility if the architecture changes (e.g.
adding more tag bits) but then likely new prctl
flag will be needed for handling that so it's
probably not an issue.
