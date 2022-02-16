Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6037B4B8E84
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbiBPQu3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 11:50:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiBPQu3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 11:50:29 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2029058E
        for <linux-arch@vger.kernel.org>; Wed, 16 Feb 2022 08:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJJErxCYFaw1dV8tCv3IiJpu7O1wfAQOvd0Sb9dLrR4=;
 b=eBqFpGGU7GfJlLSRt+mROmb5t+RHNxqAL/WWLefmx+ym95T4+IHRotmStMAUGmkugHMPW7eZyiaZToUXhAqQknpp9p69i73LKEdvT64MUkyXFySg9VMPuWXrXxW1vi82XyAKTwdESYAMJxCt0bDJ6IDhThIp4o5x/bNcAlM74qk=
Received: from AM6PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::25) by AS8PR08MB7144.eurprd08.prod.outlook.com
 (2603:10a6:20b:404::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 16:50:11 +0000
Received: from AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::ab) by AM6PR01CA0048.outlook.office365.com
 (2603:10a6:20b:e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 16:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT044.mail.protection.outlook.com (10.152.17.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 16:50:11 +0000
Received: ("Tessian outbound 18e50a6f0513:v113"); Wed, 16 Feb 2022 16:50:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3c1be13d1e13468c
X-CR-MTA-TID: 64aa7808
Received: from dcef7d1ef4d7.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 37ACD246-76C1-462F-B463-F10DEA4113F3.1;
        Wed, 16 Feb 2022 16:50:01 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dcef7d1ef4d7.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Feb 2022 16:50:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwUoW71TxQQfqVTqR32Qswe+hBZv/RRp2znR/jJ+gZhUckOasBq3HMROIBFYw+LLo1665HzP+d1zU4JDGEPqvehAMWNaTlNQSxBmBJcUa7wCRtc34Ss9v0GlfWkXxjSMxXddjugobrOS8IImVqtaZ5VDK/JThD8THU7qjiG/jbBIeeY4coIZImwMjdpiC4ur+bhS8cVUXOWJWM0ue/TpFfsOBaz2Jz3ZQ57DQZIGr+DX8bHXWSwV7TPcp5gKbXjgRzeAjPrF/JtpyZzRAAUKtEzzzddHDnF694qNHoG9WXyL/skNoMW53H7W1gNQ/Z2SegNnA4fHXlm2LZpNgzqJEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJJErxCYFaw1dV8tCv3IiJpu7O1wfAQOvd0Sb9dLrR4=;
 b=Yzw/5+nrMn1lz1Z1IZ4XfWXuu5Aef9BjzCxg8hqgeKDf4LcdL0n3z5dtvJqEUoEYnxZ6QH++z1fXWr7Ys311ot0AURiA1y9xGd5kZugU0UAj6kyw9orgeCTgXL1QqSH5BiTTVaLpiQEpZbszn8P+vQnyaAV1aefk/fXS4Mlnebe8G9AVWXZOYOU0X9XXXqlMTcLWYrRZ1yj5ofS9ePR/P14oguy5JfhqWos5A+HYB+GMXSOpRjFti9x63207kWWE01/Eq9qQlElb5D17dNwD4PFexdby3c8jk2LY3LTWATP9QY1c0i1zPfHsXcfgYOODcv725hCeW/Kq8BtQblbknQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJJErxCYFaw1dV8tCv3IiJpu7O1wfAQOvd0Sb9dLrR4=;
 b=eBqFpGGU7GfJlLSRt+mROmb5t+RHNxqAL/WWLefmx+ym95T4+IHRotmStMAUGmkugHMPW7eZyiaZToUXhAqQknpp9p69i73LKEdvT64MUkyXFySg9VMPuWXrXxW1vi82XyAKTwdESYAMJxCt0bDJ6IDhThIp4o5x/bNcAlM74qk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by HE1PR0801MB2026.eurprd08.prod.outlook.com (2603:10a6:3:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 16 Feb
 2022 16:49:56 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::dca:9146:2814:3f63%7]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 16:49:56 +0000
Date:   Wed, 16 Feb 2022 16:49:54 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, libc-alpha@sourceware.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20220216164954.GH2692478@arm.com>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
 <Ygz9YX3jBY0MpepU@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ygz9YX3jBY0MpepU@arm.com>
X-ClientProxiedBy: LNXP265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::28) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 06ecbf26-9219-41dd-a8f5-08d9f16c65e7
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2026:EE_|AM5EUR03FT044:EE_|AS8PR08MB7144:EE_
X-Microsoft-Antispam-PRVS: <AS8PR08MB71446F2FB199F972D7480431ED359@AS8PR08MB7144.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cizM09AmuJ2aPOskTFQNRanv/PDD7RASlNAflthfB60JbTbKsFlyeRz1aij7zj+popNy5w+sSZarcsWcXuaA78ESPbw2VlZ/0DONfHihYpZ91DYZT8F78/VTrr+EwrtHva9AtOTohJjSsHmY54fCv+Gq5mQZgWiLYhx1K6Y5oMhB7wW/SSYWTIKrQg0rpsgJ3uRam8HPogk1rNFdTRlN2uLlAqlYXaMm4JCwyfEgG7ircex04xRA/Dz/BwIodAK/JWrDoNHmFE+BduCNHNp915HxckS72DqiWhQ9mpP5NQAEaCnkL0jV1KhmD6CDJr46br/fkV81sVeCdLbheS3QXIePoPr2vVRf8xZ/LBPWQY8/oVkZRtYcegVIEY5PB5gvvalR0agJvzKMDTWRsc8iT4mydxncNWiF70lcWYI2GXFSm7aGeP9Gee76rcQGR1yXx/pfcE8DnleyMP83AocxPXXEXb0InSQU5fMwuGXAJdmCq+jv4cl9I9IfNS/71o+Zg7KBQJbUSMAZkpO0IGAfyaNjIjC4x9BxLFsQ35tBt6sJq3caDiqVs9Azp1kb41s08eZ4HJSOiKfZBNV0FxW6XWQAhEi5+/QVQ91eIe8BYaQNDaGtXjdsFOCVZ3Mwkbvr6GY86Y1kEb4PxcJZHYr/tqfGunyVgAz8QfLdOccbDyEio5KtrisaKRfAsM3RMWz5flJzlNSlFVf0C1EM5YTPEQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(6636002)(186003)(37006003)(26005)(54906003)(86362001)(83380400001)(38100700002)(316002)(508600001)(6486002)(33656002)(2616005)(52116002)(6506007)(6512007)(38350700002)(44832011)(2906002)(4326008)(6862004)(8676002)(66476007)(8936002)(66556008)(66946007)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2026
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa6db03b-7a64-4685-55cd-08d9f16c5cb6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+NAObwHe6N1Dvt5OZBoRZrnC5LoZ+WIglthaqcLwkx4g6VuwJGQRGKKTpInKie0rNypSEvD4n6pybzffuIFTGwoH4g2jYg6tn7pF8KbE1XNSDhtGfcVDRS5CVr17bvwtlC1+W3i2vlBA8sjxP9WFDp6hmOKae4ZFIT+Nw+QJg/GAW2k6IQwlxKKRB9rtl2R+37cflztB9tyExQBtvmYvVjsGIgOsK7/ePRUK0E+O8qc0iDr+25iiA/Kxh7tNzcNmKC65gR5W+UwscCg4mrL8dmARZYTUft4xKKZHFklfsbABKyDOPiHHTY/6Zxi0kOM1vQVoa2+/cuL0JOtXFy127q34cs6nQbeqFSmh9WFu6HAK6OUo8ikRrFt2PCH6HU6gelWYSyyzNOKkJft+PSelktLGrattDoa3uDjWmNy2rcjDjzNxgvzh4VjqbNa7zs3/Xxc0XsDLANsrOCqyjFE+buUuDWxPceqddQYQ34GmjG9XU7lQk/fHWGqOLD0l2+fv/1RBDmISRTf7SNFvw/XU4VYzO2Cj4t1UR1Cv2NTSqbaIMvalxXSEr3vj+ZiddvCsllkkdxPMHiJ9hEEmI3FSAks34jqUjCkD40oYp7OUuPjmcOikt6sbzG5I5Ndif3zj0esKHqogwvbZnVJxHc0nnzm+B4640hKtFP8F5WJn6HwEBeIdGKzLPrGUXbXFjXg
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(83380400001)(2616005)(81166007)(186003)(356005)(36756003)(336012)(70206006)(1076003)(37006003)(26005)(70586007)(86362001)(316002)(6862004)(6636002)(36860700001)(107886003)(4326008)(8936002)(8676002)(2906002)(6486002)(44832011)(508600001)(47076005)(5660300002)(82310400004)(40460700003)(6506007)(33656002)(6512007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 16:50:11.7453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ecbf26-9219-41dd-a8f5-08d9f16c65e7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7144
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 02/16/2022 13:34, Catalin Marinas via Libc-alpha wrote:
> On Tue, Feb 15, 2022 at 06:34:56PM +0000, Will Deacon wrote:
> > This appears to be a user-visible change which cannot be detected or
> > disabled from userspace. If there is code out there which does not work
> > when BTI is enabled, won't that now explode when the kernel enables it?
> > How are we supposed to handle such a regression?
> 
> If this ever happens, the only workaround is to disable BTI on the
> kernel command line. If we need a knob closer to user, we could add a
> sysctl option (as we did for the tagged address ABI, though I doubt
> people are even aware that exists). The dynamic loader doesn't do
> anything smart when deciding to map objects with PROT_BTI (like env
> variables), it simply relies on the ELF information.
> 
> I think that's very unlikely and feedback from Szabolcs in the past and
> additional testing by Mark and Jeremy was that it should be fine. The
> architecture allows interworking between BTI and non-BTI objects and on
> distros with both BTI and MDWE enabled, this is already the case: the
> main executable is mapped without PROT_BTI while the libraries will be
> mapped with PROT_BTI. The new behaviour allows both to be mapped with
> PROT_BTI, just as if MDWE was disabled.
> 
> I think the only difference would be with a BTI-unware dynamic loader
> (e.g. older distro). Here the main executable, if compiled with BTI,
> would be mapped as executable while the rest of the libraries are
> non-BTI. The interworking should be fine but we can't test everything
> since such BTI binaries would not normally be part of the distro.

note: a bti marked exe has to be built against a bti enabled
runtime (so crt files etc are bti compatible) and any system
that executes such an exe must be newer and thus bti aware
(according to glibc abi compatibility rules).

so while it's possible that ld.so is not bti marked when an
exe is, the ld.so will be at least bti aware, which means it
will map all bti binaries (including the exe) with PROT_BTI.

so this doesn't really affect glibc based systems. and there
are not many other systems that can produce bti marked exes.
(i don't think this can cause problems on android either)

if we ever wanted to map bti marked binaries without PROT_BTI
and introduced a knob to do that in ld.so, then this change
would be problematic (we cannot easily remove PROT_BTI from
the exe), but we don't have such plans.

> 
> If there are dodgy libraries out there that do tricks and branch into
> the middle of a function in the main executable, they will fail with
> this series but also fail if MDWE is disabled and the dynamic linker is
> BTI-aware. So this hardly counts as a use-case.
> 
> For consistency, I think whoever does the initial mapping should also
> set the correct attributes as we do for static binaries. If you think
> another knob is needed other than the cmdline, I'm fine with it.
> 
> -- 
> Catalin
