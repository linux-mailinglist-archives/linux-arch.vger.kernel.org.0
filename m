Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2972745CC
	for <lists+linux-arch@lfdr.de>; Tue, 22 Sep 2020 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIVPxE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Sep 2020 11:53:04 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:39017
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgIVPxE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Sep 2020 11:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNlMc3BfSCHBfmvuHxysUdTHrqLsanEl/lgUOtkyrZI=;
 b=ya6s8secKJnUuPrqMD57mof50sK8ubEu/bFd/qXrCcIT1zdTW+sS9vlWnxHvstA5rXtPNtZsKhPU81VzCr5gG6aZ1Y/0K1WuHMLCXYRSUGZwnMlhn4AwTGoiDOiJT8bJcJK6p9kHQJsSW9+4JvgK3Fg9oAI+UENQGf+50IxjobM=
Received: from AM5PR04CA0015.eurprd04.prod.outlook.com (2603:10a6:206:1::28)
 by VI1PR08MB5501.eurprd08.prod.outlook.com (2603:10a6:803:138::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 22 Sep
 2020 15:53:00 +0000
Received: from VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::14) by AM5PR04CA0015.outlook.office365.com
 (2603:10a6:206:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15 via Frontend
 Transport; Tue, 22 Sep 2020 15:53:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT042.mail.protection.outlook.com (10.152.19.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 15:53:00 +0000
Received: ("Tessian outbound 195a290eb161:v64"); Tue, 22 Sep 2020 15:52:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f6ed8c82c5e227ec
X-CR-MTA-TID: 64aa7808
Received: from 8ce197089d28.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 42BC8765-7AE1-4912-8B77-5AF8C51E68DD.1;
        Tue, 22 Sep 2020 15:52:54 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8ce197089d28.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Sep 2020 15:52:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hknS0N+UtDSYG5AEf1YZLG8h9JMtq2cDG+DKb36u1pgfc7Cma276SApH8hFD3nwko90I/hGXRlsPwTXT8M5O+TKacQEXPiBN/kibBDnRpWOl+w9IRbd/v8oJ/1YuYj9iI1Kn1sAHA03Ilwm9CAvyIiya4nY5y1kWl2V8gogaaTNMPvsduefyElcl9kuHGW0UrLNWISfmp/CQ10Ex+UPpEZT+zzOlcAZbmoD940UKupsVeULswCIGcsRlZ3d2R8XAjQURYSZrhTR8Uzw/r7Jjh9EwVvWEHe7P6ed5Oq+PP/MjCUfH5WH3o1L5kDkDDq/n6Y8PuN/gm54wVz6SWKJO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNlMc3BfSCHBfmvuHxysUdTHrqLsanEl/lgUOtkyrZI=;
 b=Hg3PRNOUUphhK8HOqsnMhQRIxHYp7jepRztn0AV4/5vHu1zWAJBSzsxhrMJzpL9txcFzXOWNKC40tHQwtJKwb81oiRCCyr1bLDThHHFszUvTuNEi9GE8yAASe49PZDfHZnQTlLkw8I8xsUam0xeBNDdBx+UI8HFatPTXAKk2oJOLSQBKr7xrBXSXr2+RFpclkxmkGNQAXDR2O/kURphLffromeu9qZkyayGFdufyYBr/SjbEx5jM+/1/bBVf/KgssDbL43MX72y+020vyL3nGQbYZqTot/NvPmEmJIY8vx29sF0bTQhutRN65xjSWDzf4kTKZVkXJu2FfjOONUw3HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNlMc3BfSCHBfmvuHxysUdTHrqLsanEl/lgUOtkyrZI=;
 b=ya6s8secKJnUuPrqMD57mof50sK8ubEu/bFd/qXrCcIT1zdTW+sS9vlWnxHvstA5rXtPNtZsKhPU81VzCr5gG6aZ1Y/0K1WuHMLCXYRSUGZwnMlhn4AwTGoiDOiJT8bJcJK6p9kHQJsSW9+4JvgK3Fg9oAI+UENQGf+50IxjobM=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR3PR08MB5563.eurprd08.prod.outlook.com (2603:10a6:102:89::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 22 Sep
 2020 15:52:51 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad67:3b31:680d:9d01]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ad67:3b31:680d:9d01%3]) with mapi id 15.20.3391.027; Tue, 22 Sep 2020
 15:52:51 +0000
Date:   Tue, 22 Sep 2020 16:52:49 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v9 29/29] arm64: mte: Add Memory Tagging Extension
 documentation
Message-ID: <20200922155248.GA16385@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917090229.GA10662@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::31) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by LO2P265CA0091.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 15:52:51 +0000
X-Originating-IP: [217.140.106.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 291417d2-8d49-45df-30e7-08d85f0f9515
X-MS-TrafficTypeDiagnostic: PR3PR08MB5563:|VI1PR08MB5501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB5501CEFA8DD9DF6F6E126060ED3B0@VI1PR08MB5501.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 6pgZPDuq6+dE03Ok39pzE1S12bxKbSkjBRrdHBJMkV8h6oEEMl7opsxDcsV9speEYDHkDcVtPzoFGNBXz+VnZE0J2WTRAC4yrqS08bEmwbSoB+5iFqkR5OrgHVijgeRPC5tlJITRN5XwMtx81e+ZfqX+N32FZ1PW+M10B255zL3Zs1bRpBm3/8Ou3sQ0KgYCtY/okQ5uOV6VtaqAl4c+IK2cdbMXdX7YkrCRXJ8ypWx0sfOoH7GSQTrQn1tydvTOLIyos9BMWVeefCsgOX6nKuwQSwUZxG75DINAc2B9dxaIfi+cCbpgcvIKjh3rBdNcD0I28y7ka0GhjkIx3lW7/w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(346002)(376002)(136003)(16526019)(6636002)(33656002)(86362001)(956004)(2616005)(478600001)(8936002)(26005)(7696005)(52116002)(83380400001)(5660300002)(54906003)(6862004)(8676002)(8886007)(44832011)(55016002)(4326008)(66556008)(186003)(316002)(37006003)(66476007)(66946007)(2906002)(1076003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HdM9/F3GeXgJ2cZC6B9uK74rGDCFoQt2zyWnwrZ5Z6Xj0F9tKgSrz3r8Wic8NEHJxqhQqGTiFzSLlcFnGqe4OHtfPXaIHFct/x4C/kcBHPFJx5+HIK3JFonoPY3UMcnP5dwvBptg6BnXvQp7dJ+VIlMv5DCELVYam5x9hiiobM0yecr2xwTbMGc37C9vzCWRHsxKwhs47sQd1uJm5xYQuBMDpQ7tgxuKw+RrDQcYUnqeWz/gfG6iVVuUo5zq3ZO/A4VTLokp/oSxCN+F1Y5X7DCLvhA+nroSRte4dTTc39D6x2VYsXNZEwmBGCQyfrrSGtU0OwaDYac7f5gKoxIaKXd8W0esRadu1rk4e43G4lnTC37ezt+kyqQzmkWReCatHNtbq+igMho90rCKrIKu61/Y8kRnIJMBpfzP16OkyP5UxTomaOiLA1z6wjqC0x/xp7rdsphlHWU3hh3M0K3LZ+vtBXYkJUdUGTlFsL8cYqwUiQUoLAKJOecAviNOps66mibcTiV44/sK27KBj8wFYheCUJjKv4qZdDKdRU826QTLO3rMesczUh4bMi1pVhGy+FUBzCY9clmgBuUJjFnXDZxKiOj2fWCWpbYnR9rKyn8tOU4+mhBmVhXmZ8c3MOrpudkJ5ceg06VtjbiFBBncOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5563
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b3c98b4d-fc1c-4bdf-b8d1-08d85f0f8fbe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ntMd37bpYDUNd67poTvph45vedPtOGyeH8wUr3k4W7GkJ0DQhHBP/flyrz51STAMOzoCKUuuKjnML4c6sYkf3sMCtacB67f2lrKG1di/prIf5F0yvbHVoFOxYvSBtaeJFhFrmhQb4QmlGdr6uPKBkwugDhcU53z1KnJi75NqC2WGSX+KTjm/6rzkKGVPLVAdkod7dtCL5ZHCYvqKzmXxjyPaiRvGXc2J+enda+FwO0V5NTK5cawEGhPN/58iv4lyoSoiViev+5qOWEB2tmf/7TRbCuh/1F008BLue2rVmZfCe397tuL9gSROz4kSrA2gb2BEiu1RhjqGwz45iId1JAoPtCnMoq5qVGB5kK1JsE/3EGsZXVPEu6Oqm7l1wNq6+4IG619cU6TNkx2fyVpTXg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(70206006)(956004)(8676002)(37006003)(54906003)(33656002)(8886007)(44832011)(336012)(2906002)(86362001)(82310400003)(478600001)(2616005)(6636002)(5660300002)(70586007)(83380400001)(186003)(36906005)(36756003)(316002)(7696005)(82740400003)(356005)(81166007)(107886003)(47076004)(55016002)(1076003)(4326008)(16526019)(6862004)(26005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 15:53:00.2097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291417d2-8d49-45df-30e7-08d85f0f9515
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5501
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 09/17/2020 10:02, Catalin Marinas wrote:
> On Thu, Sep 17, 2020 at 09:11:08AM +0100, Will Deacon wrote:
> > On Fri, Sep 04, 2020 at 11:30:29AM +0100, Catalin Marinas wrote:
> > > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
...
> > > Acked-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > 
> > I'm taking this to mean that Szabolcs is happy with the proposed ABI --
> > please shout if that's not the case!
> 
> I think Szabolcs is still on holiday. To summarise the past threads,
> AFAICT he's happy with this per-thread control ABI but the discussion
> went on whether to expand it in the future (with a new bit) to
> synchronise the tag checking mode across all threads of a process. This
> adds some complications for the kernel as it needs an IPI to the other
> CPUs to set SCTLR_EL1 and it's also racy with multiple threads
> requesting different modes.
> 
> Now, in the glibc land, if the tag check mode is controlled via
> environment variables, the dynamic loader can set this at process start
> while still in single-threaded mode and not touch it at run-time. The
> MTE checking can still be enabled at run-time, per mapped memory range
> via the PROT_MTE flag. This approach doesn't require any additional
> changes to the current patches. But it's for Szabolcs to confirm once
> he's back.

my thinking now is that for PROT_MTE use outside
of libc we will need a way to enable tag checks
early so user code does not have to worry about
tag check settings across threads (coordinating
the setting at runtime seems problematic, same
for the irg exclusion set).

if we add a kernel level opt-in mechanism for tag
checks later (e.g. elf marking) or if the settings
are exclusively owned by early libc code then i
think the proposed abi is ok (this is our current
agreement and works as long as no late runtime
change is needed to the settings).

i'm now wondering about the default tag check mode:
it may be better to enable sync tag checks in the
kernel. it's not clear to me what would break with
that. this is probably late to discuss now and libc
would need ways to override the default no matter
what, but i'd like to know if somebody sees problems
or risks with unconditional sync tag checks turned on
(sorry i don't remember if we went through this before).
i assume it would have no effect on a process that
never uses PROT_MTE.
