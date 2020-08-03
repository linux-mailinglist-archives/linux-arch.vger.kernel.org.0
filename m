Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115D823A5F5
	for <lists+linux-arch@lfdr.de>; Mon,  3 Aug 2020 14:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgHCMn2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Aug 2020 08:43:28 -0400
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:14673
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbgHCMnZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Aug 2020 08:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/Kn/llKFrxePEP85B+SBaK0iufG9zXVECQc6FhyP8M=;
 b=XA/bRGmRHkvWN2eRCIkwPVLlgAAt0CzvunsAG3SUHRAECbNhtb+uwnu3gdN/GPc7WUIjn9jo3+kNZJE3hTZYXYuDqLvsfOppKfPYM3qytBE8fT+tFJY09P7Y7W90xCy47aJ3KecoGkn6H6Soo5QQKQ9c1gFhBhg31pUHGkYlU5w=
Received: from AM7PR04CA0002.eurprd04.prod.outlook.com (2603:10a6:20b:110::12)
 by DB8PR08MB4091.eurprd08.prod.outlook.com (2603:10a6:10:a2::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Mon, 3 Aug
 2020 12:43:20 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:110:cafe::11) by AM7PR04CA0002.outlook.office365.com
 (2603:10a6:20b:110::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Mon, 3 Aug 2020 12:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Mon, 3 Aug 2020 12:43:20 +0000
Received: ("Tessian outbound df763aae78fc:v63"); Mon, 03 Aug 2020 12:43:20 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 84dd5c9c336bae18
X-CR-MTA-TID: 64aa7808
Received: from 211586358827.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 29E533A4-08BF-4486-9966-48CF1249D349.1;
        Mon, 03 Aug 2020 12:43:14 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 211586358827.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 03 Aug 2020 12:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgIJcZUrYmaOvwmoQdr2plVV30NLjDxD9s+LbKYUWdoUhrug9DOaAs6wojLL66Q5hwTsPHdDmikXxSxVN5JheuI6dTusizkoNl4enOCj31A0+6hbAW6L4aIBVvjWyvpc++/0pXKSr6F0Vm1Sr0+PC/vwipvzZdvnDgFG3POvAmrHeTMR9NHLCubrFMcPaUtK53lJTQfnbFpRHgCrbfR0boFqSFIU/F6xbHlfUYDgIuJ8iPNJdZNpqg2nBNdi7zAnyhCrLjMxxcp5PyrabXSLdTfp1JS48y5KCc3VFVU1gmkhwsL7+KGO9EWjJ0sE7q5EtRBtbXrDhCoPiL1EsYaHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/Kn/llKFrxePEP85B+SBaK0iufG9zXVECQc6FhyP8M=;
 b=AP/wPG7+LSRqOsPym2MKDrGyygzFCOXhbPOmWyKkVrwJr3+IE5kijAMKayAwL6PO2qg5/ZWdduZD4rBvvE8SwFBJ2Z883l1kAu1Ubo0jk6Dxl6W4Kw2NCpeUkaMDI3ceoM0tMvHur1NbDnsvx+FhG5taz2ifAJMLP9IpJl1PMDYUpqEjX2S2X8XcSkWwuTRj7ltUX62DVGZa66ne8kiHlQQEGwpnlvxGUpVjD/QzzUiVrwelW6ZzhhMhLxSlK5ucaNLHn7RDNY5HZqHVJJ+0muulTnrI5ydMzZlHANUL2QlH1ML0LHlD1KCs76IhjJSAfvcWGRCTyBCYhkBQtB7sgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/Kn/llKFrxePEP85B+SBaK0iufG9zXVECQc6FhyP8M=;
 b=XA/bRGmRHkvWN2eRCIkwPVLlgAAt0CzvunsAG3SUHRAECbNhtb+uwnu3gdN/GPc7WUIjn9jo3+kNZJE3hTZYXYuDqLvsfOppKfPYM3qytBE8fT+tFJY09P7Y7W90xCy47aJ3KecoGkn6H6Soo5QQKQ9c1gFhBhg31pUHGkYlU5w=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4296.eurprd08.prod.outlook.com (2603:10a6:20b:b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Mon, 3 Aug
 2020 12:43:12 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::2404:de9f:78c0:313c%6]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 12:43:12 +0000
Date:   Mon, 3 Aug 2020 13:43:10 +0100
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
Message-ID: <20200803124309.GC14398@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-30-catalin.marinas@arm.com>
 <20200727163634.GO7127@arm.com>
 <20200728110758.GA21941@arm.com>
 <20200728145350.GR7127@arm.com>
 <20200728195957.GA31698@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728195957.GA31698@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0443.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::23) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0443.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Mon, 3 Aug 2020 12:43:11 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6220e4ad-cb81-47d7-b772-08d837aacd75
X-MS-TrafficTypeDiagnostic: AM6PR08MB4296:|DB8PR08MB4091:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB4091442DAED3D2A93FEAE9BBED4D0@DB8PR08MB4091.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UZHYahv5jdbugdh3T3msdWQ8fEmWKImAnodp9jYmyLzZP3pQOoYK+8+ln/JPq01651jeUPt1O93Tb+aCRFGWHkjRfC8/PFwNtQk4fgXmPKCgyz9uxHRg2AwmFPYaSYcH7zeR/R6sY9kHpbtg9R5sKKSHRP5t9DHf74jiwNjXiSCivnzitIct/ud7EADeLRu945khabuWZU+tK5oGkK+iRUhrD0Vbhjn0326+SoIEHotie1YVd3Bc7vboCXkYNlHBWgE+v7KaniThHK4ml3rIqJ9hQWzRjcD/xQLMvMM4i/VxBMC68qUKqAKm95qqULCwPEoEgYOjqiBMfqMY+sBY1Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(83380400001)(52116002)(8936002)(86362001)(316002)(37006003)(956004)(8676002)(36756003)(4326008)(478600001)(2906002)(6862004)(2616005)(66946007)(16526019)(44832011)(6636002)(55016002)(5660300002)(7696005)(8886007)(66476007)(66556008)(186003)(1076003)(33656002)(26005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UiV5+MNemOKVjQZPPV9yP5detMdm/WX/i4Lq9Mr5KQH84mAvPUrstxG1U2FbBjf6MGyeO7+6CPhPpyP4ykGsD1Nodu0Iz7hKwePKa0xubzQYp8wkwHJ9hchVqulRnB/FmeVhB4eKZO+vgpJlgAzG88IVSnV/y6I2QNmPIAg/+YPsRBA1WBTXVDGhnVhB3BXoQB9DK82RRa9iCW71w9UbOz36meywb6x2HnZ6AQB1r19yGzBmgatYezHL2Ugdww7c8I2oJo74XjK3IQ6RGou1Q9kCBUE4L1rsaZTw82AWkRnqUJyknshivSh7cA3I4bFz8D6/5hY3ey0hr2kr7/QgTktTinz5d96JviEwqJY5Zkgdd2kO4UPtYgzwhQENm28avdlpbLy8hiXfLnNWwPnRujzPqpF59YKD5iMfJi1VpWg1kX3oIBQ5oTWyqat5mlJiATMIfPzfa4dMlsXCgRq5o/+c0leTO7u/DmH/pdGQpxqoxgl6sS8aDB+vKDIyTdsiriz66uZZ8Eimd7koTkY0ogtj2Np8zvaQhtgNN96ErWKmrXQl6TAIcm/GSapIsWkrU23CxMaRVb+ouLYzjiTVacM4X2kVXEAUqjI4FW9AiSzCtKqVVe4j7bs5cr5ezG+phkutU3+tlIxWSEsC4XPp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4296
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 342771a7-cbc0-449b-5c48-08d837aac869
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3blTXSTU4MJhdAMmVTwugSX2Oxi42e0s2DR8KzxW74q1bDMvZwuz54x9eyO/aar+bojxU+cjsrTGZVGvzxTVchzM+6tkCNL9k6f72Oj6GQMSNk/Z+rEOmvAL0xmJKmLtwmejrb00Gq+ScMnCNig/8vk8GNhUoDQYIhnq54oGkYJSOda1F6FNxjWOu0tKaH0XeXfWi8g6GPekp/Nqp1dakeXUrn7BwezxoXblpIGz3Z7PrKxhIuqLsNwavNAaQIwqrM4IqVatND2owikPtS9aDTldDIYzA3OS550ZnuN/Ys0f3zFJrc7IiVVP2Ets+QUcLK11NK1BDTBqMnzquD9GKZkwA41pNLTj2M5c0TUSbyg1SmdVmYYMCCiPVpKJz3gr9+iFy03nYYxm9deNdLONag==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(44832011)(356005)(6862004)(82310400002)(83380400001)(54906003)(478600001)(2616005)(956004)(37006003)(82740400003)(5660300002)(81166007)(4326008)(47076004)(7696005)(8886007)(36756003)(86362001)(1076003)(70586007)(55016002)(2906002)(316002)(26005)(8936002)(186003)(8676002)(336012)(33656002)(16526019)(6636002)(70206006)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2020 12:43:20.2687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6220e4ad-cb81-47d7-b772-08d837aacd75
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4091
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/28/2020 20:59, Catalin Marinas wrote:
> On Tue, Jul 28, 2020 at 03:53:51PM +0100, Szabolcs Nagy wrote:
> > if linux does not want to add a per process
> > setting then only libc will be able to opt-in
> > to mte and only at very early in the startup
> > process (before executing any user code that
> > may start threads). this is not out of question,
> > but i think it limits the usage and deployment
> > options.
> 
> There is also the risk that we try to be too flexible at this stage
> without a real use-case.

i don't know how mte will be turned on in libc.

if we can always turn sync tag checks on early
whenever mte is available then i think there is
no issue.

but if we have to make the decision later for
compatibility or performance reasons then per
thread setting is problematic.

use of the prctl outside of libc is very limited
if it's per thread only:

- application code may use it in a (elf specific)
  pre-initialization function, but that's a bit
  obscure (not exposed in c) and it is reasonable
  for an application to enable mte checks after
  it registered a signal handler for mte faults.
  (and at that point it may be multi-threaded).

- library code normally initializes per thread
  state on the first call into the library from a
  given thread, but with mte, as soon as memory /
  pointers are tagged in one thread, all threads
  are affected: not performing checks in other
  threads is less secure (may be ok) and it means
  incompatible syscall abi (not ok). so at least
  PR_TAGGED_ADDR_ENABLE should have process wide
  setting for this usage.

but i guess it is fine to design the mechanism
for these in a later linux version, until then
such usage will be unreliable (will depend on
how early threads are created).
