Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289CC49E511
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jan 2022 15:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiA0Os7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jan 2022 09:48:59 -0500
Received: from mail-eopbgr140074.outbound.protection.outlook.com ([40.107.14.74]:53098
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238164AbiA0Os6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Jan 2022 09:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpre9LfVjvmqU1C7IQSDLCKfZApWVeD0w1MPrT/qSK8=;
 b=uEp/y9qAaHJJ3I6C1ql7RN7dF6+6vJ5JpF1nOlusjpwUuBlvv0LljoqyAt9lENrCF4W6rFTDaVhCRflh5jchS5aKj4k3ZWvOfyGBQxDkeh6gRffWXWd2u7TqXxiRKd+PRfq+e2vCOwDJ5cl+bbempSp/Rhh013vPxPDLsoRoZRs=
Received: from DU2PR04CA0256.eurprd04.prod.outlook.com (2603:10a6:10:28e::21)
 by VI1PR0801MB1757.eurprd08.prod.outlook.com (2603:10a6:800:5a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 14:48:43 +0000
Received: from DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:28e:cafe::b2) by DU2PR04CA0256.outlook.office365.com
 (2603:10a6:10:28e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17 via Frontend
 Transport; Thu, 27 Jan 2022 14:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT025.mail.protection.outlook.com (10.152.20.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 14:48:43 +0000
Received: ("Tessian outbound 63bb5eb69ee8:v113"); Thu, 27 Jan 2022 14:48:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5cd3e99686449da8
X-CR-MTA-TID: 64aa7808
Received: from a0d92831d203.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2E7EE147-6AB5-433D-AD87-93345D001B42.1;
        Thu, 27 Jan 2022 14:48:34 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a0d92831d203.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 27 Jan 2022 14:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8nffH8gk65Q4yAuzbHdO2O1m4gpsjHTLQOEYvAXgfnrOkbTDk9zmadMpyLMG/p7Zur43lGxLrLLD7FjxBw0tQVbdm2qi9lK9rTek3mM0AzZ+hX3v8IEXRRjaU0c/VgVtoQwjPN3oo7QsPT1dT8lEbytVz2c+UWeWQyGa4uD/tFWEwAyoJ0RmDfclS9h4HkcTV0JnQJBoGZNdjRd9sdkyWWpG3N5MrqWEKGoUVuIgkhlQvtDeE8MmMF5F65qMrTDcoTHNereDxulHD0iEf4NEjLh5s/iTzePVmmjq40aaNLo1RXoCeluxqMjxh1dL/NXOxWLlHbaQ6HcRkBpKsrTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fpre9LfVjvmqU1C7IQSDLCKfZApWVeD0w1MPrT/qSK8=;
 b=dl0rcbyvCVlZZKzy19yVKA4yupbRO+h/GmjcNHk/XBJg4E8TKoYcgPPq5YHbJDIzbrrAFskd1fHSTninNhOCJXZF8ZO/KSI2Gr/E7bf7E8pd/13L7ORajXCdd4CjSRocqi7S+016p/xOT5xzWGmQH8tXVbU8+JKHe8NYIdgzSl1CHNaX7T+BusU1T/t3Dn+LKN0syBp0+047k0jlPU0hIx9Eid3OxEbKDD1Mi0GLFCJtRjO420IBGvLkBnA8lNjVhpNzrRQmG162RSsnl56kq69FsnwVvrAaz66HYD7Ocf6XCgC1UYyFE4D9Xds4STVgEjCopyGBOnOKOiGs8yByOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fpre9LfVjvmqU1C7IQSDLCKfZApWVeD0w1MPrT/qSK8=;
 b=uEp/y9qAaHJJ3I6C1ql7RN7dF6+6vJ5JpF1nOlusjpwUuBlvv0LljoqyAt9lENrCF4W6rFTDaVhCRflh5jchS5aKj4k3ZWvOfyGBQxDkeh6gRffWXWd2u7TqXxiRKd+PRfq+e2vCOwDJ5cl+bbempSp/Rhh013vPxPDLsoRoZRs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM8PR08MB6322.eurprd08.prod.outlook.com (2603:10a6:20b:361::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 27 Jan
 2022 14:48:29 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63%5]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 14:48:29 +0000
Date:   Thu, 27 Jan 2022 14:48:20 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220127144820.GF1989194@arm.com>
References: <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk>
 <YdgrjWVxRGRtnf5b@arm.com>
 <YeWtRk0H30q38eM8@arm.com>
 <20220118110255.GC3294453@arm.com>
 <YfKO7r5l7AUvd8r/@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfKO7r5l7AUvd8r/@arm.com>
X-ClientProxiedBy: SN4PR0401CA0014.namprd04.prod.outlook.com
 (2603:10b6:803:21::24) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2c5042c5-7388-4a10-054e-08d9e1a41d8f
X-MS-TrafficTypeDiagnostic: AM8PR08MB6322:EE_|DB5EUR03FT025:EE_|VI1PR0801MB1757:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0801MB17574CF810E1E26A9C1C30FDED219@VI1PR0801MB1757.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VYwLRK3pB15OeAB+sXaK8oYyTiDuc1BNLRhu8REDjPUDgd2mfOwnsVjSjvpS7pX9GSROri2LQa2sfLSEf7+MLgD9DpCXTzmrbdLiWre40dwsLYuMLwxG6q16/kuorog2WyHEPWRFkWzT9CjgnGRsuZ5D/UOCHSfOmzh0ZHGbCXlJfCXyTliu3ioOgzpn+XNnTD0CjyQO/HP5LvGyG1E74ISW5bfNTrqf3+v12xzPSR9EQhYxzMxUHS/+Bgm+I7Xh60oWeX3wmD12tDGbOZkvkktjM/NNnjfHMV/q4vsDVxKtWTMwoxzvrsaAnRyTQTMJ6tG9uLO+jicL2isg5oAd2LhqcKuIOb86feF+4PpxJJfSJknw4IG/T3ocK8chBr3P6PNiC/F1ynow1GBfpqrWEgCxdM8Z7V2/iwud+vEtFn2N6Sy0xq+gzb6Q6hnZZJw/HC9jYWDpsiCPVZpsneeqqFSe53RfEqsDUUYdCWDU5bfKmHtyPgJ332vRmwWiXs5ac1vycVwl5SyWkY7zs6rQzwBsQ9jDY5UdoWLZv4fYncJMUX31INKf4wT5UuRbXPpdWNeEnb0EvDaDmlt6urfHUsGmknp8AEv/Gk4XqnfDKs07kySrXdgiC/yT/8wrI0V6K9u40P2Vd3Ee5RANRepJNQrowHZNJO3kkjtyyUey2lTjxny7ffkIMdTPdK2ermGP5o/0xyvNW8Zr56zdZcdKjW2CvpzqXPR38BGQiQu+25hHsk7J3/ROxDXpaiIzeYgY/ZYEIKEGerCIp6AM/faUc+7gigJFeY550ZYsomgf/wI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(1076003)(6666004)(66946007)(26005)(6636002)(83380400001)(33656002)(66556008)(66476007)(2616005)(52116002)(2906002)(508600001)(6486002)(8936002)(6506007)(966005)(8676002)(186003)(4326008)(86362001)(316002)(54906003)(38100700002)(38350700002)(37006003)(44832011)(5660300002)(6862004)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6322
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 63200a58-2166-4868-f459-08d9e1a414e9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mqOvqPdvVHbhhHpqfxT9KRa0GVZr1Ovakkhk4CyLGo3j687jnqe+u1DXvjQDU693GS3oozwx90Wu+iKCzqzXc3i2weTjN+wRUZm9moTHvGhtCi+n+GNtTt5wNoRyTLIkOx4IALqCFFHjXZo/z4flSMBXSPtLdyNoca49+wZ2RoD3V7PgAbzuY1hwqrHpVLemhLD+qqUcSfjSo02XgIrS9mKDqe+eHo+5ZK/w8ggbS2CzPZw4tQLl7GhzZ5xQ8LMTisbBz77F5IR7Y2RjBqEtcsKWMMy8uZ1Z/uPWcknS7PRTRtM4rAz0+fyl0wLPn/ob946zRNFyObJLWFJhKSJ3Ucf6LDGqx59aPkvGOlxxF9xmhR4vp2Hs5ANmzFea6c1dhOtRuMihD/aMuYczQh1rmS4orDAo+Kt4CE7ijPFxvD1aayJnqp4hHHG1SmtDk4RWHWnsuQhJEyu8wEQKc/iP+bF66i9pRA5AqqX3u8324Mx4fVDGt8etQOwF0xQW1x6wXxLhBV581MxK/iRN5cFV36vIkKenofydUDPiLqoVbeUxmGS5MNSGpSwVBRYUsNkz4s14rrTXqrlhU7FlXYCFh9aeulpTi6IIatEei5SVvf66LyP+iCDIPLGGLaYIIXaDW6HadsyCVF66/ydgeUDCGp/gSIMm2zHBS7gPam124CNJp09m7afaPOk8pFkFiTjGtxde+3rS4paGKD93U+TLEdBtZhSih5z5tuzeMvNmLLNf0XL+oeGl1ZQxxAq6XcBJXritCb911Q7rxyn4YSzooQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(36860700001)(316002)(70586007)(82310400004)(70206006)(37006003)(6636002)(356005)(81166007)(6512007)(5660300002)(508600001)(2906002)(186003)(4326008)(36756003)(2616005)(44832011)(1076003)(966005)(6486002)(6506007)(26005)(6666004)(8936002)(47076005)(40460700003)(86362001)(6862004)(8676002)(33656002)(336012)(83380400001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:48:43.6278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5042c5-7388-4a10-054e-08d9e1a41d8f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT025.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1757
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 01/27/2022 12:24, Catalin Marinas wrote:
> (Mark posted another series but I'm replying here to clarify some
> aspects)
> 
> On Tue, Jan 18, 2022 at 11:02:55AM +0000, Szabolcs Nagy wrote:
> > The 01/17/2022 17:54, Catalin Marinas wrote:
> > > On Fri, Jan 07, 2022 at 12:01:17PM +0000, Catalin Marinas wrote:
> > > > I think we can look at this from two angles:
> > > > 
> > > > 1. Ignoring MDWE, should whoever does the original mmap() also honour
> > > >    PROT_BTI? We do this for static binaries but, for consistency, should
> > > >    we extend it to dynamic executable?
> > > > 
> > > > 2. A 'simple' fix to allow MDWE together with BTI.
> > > 
> > > Thinking about it, (1) is not that different from the kernel setting
> > > PROT_EXEC on the main executable when the dynamic loader could've done
> > > it as well. There is a case for making this more consistent: whoever
> > > does the mmap() should use the full attributes.
> > 
> > Yeah that was my original idea that it should be consistent.
> > One caveat is that protection flags are normally specified
> > in the program header, but the BTI marking is in
> > PT_GNU_PROPERTY which is harder to get to, so glibc does not
> > try to get it right for the initial mapping either: it has
> > to re-mmap or mprotect. (In principle we could use read
> > syscalls to parse the ELF headers and notes before mmap,
> > but that's more complicated with additional failure modes.)
> > 
> > i.e. if (2) is fixed then mprotect can be used for library
> > mapping too which is simpler than re-mmap.
> 
> I lost track of the userspace fixes here, was glibc changed to attempt a
> re-mmap of the dynamic libraries instead of mprotect()?

yes (so under mdwe, bti is lost on the exe but not on libs)

see the commit message for the fix
https://sourceware.org/bugzilla/show_bug.cgi?id=26831

> 
> It looks like (2) is a simpler fix and (1) could still be added for
> consistency, it's complementary.

i agree.

if (2) is fixed then i would change glibc to use
mprotect and handle the failure (this will require an
update to systemd and disabling mdwe on old kernels)

if (1) is fixed then i would probably still keep
doing mprotect on the main exe so bti protection
works on old kernels.

