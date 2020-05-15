Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50421D4E23
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgEOMx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 08:53:59 -0400
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:47921
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgEOMx6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 08:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stnUWRg+rnNrzWma3EVekRGQliDkle5EU2+JAanlOO0=;
 b=vOrhozJLUjbB8OP5QYYL/Axc7SoArGrEMy+a54cCbfwd02LV7JpVI+JkW/HfwM4noOoMpVyBuSS/vhLtNA+Jqpp8yB4b3OvYt0pw4O6Q9/SCvAk8fcu+TMxAI86CQg5DqLVyvOJT7ME9L45f71pqkkEdX1L10RyjMmk44FJA/50=
Received: from AM5PR0402CA0010.eurprd04.prod.outlook.com
 (2603:10a6:203:90::20) by HE1PR0801MB1721.eurprd08.prod.outlook.com
 (2603:10a6:3:7f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Fri, 15 May
 2020 12:53:53 +0000
Received: from AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::34) by AM5PR0402CA0010.outlook.office365.com
 (2603:10a6:203:90::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Fri, 15 May 2020 12:53:53 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT064.mail.protection.outlook.com (10.152.17.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.19 via Frontend Transport; Fri, 15 May 2020 12:53:52 +0000
Received: ("Tessian outbound 11763d234d54:v54"); Fri, 15 May 2020 12:53:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bd20fb0878f121e3
X-CR-MTA-TID: 64aa7808
Received: from 135ebd315029.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 85374A5A-381D-4505-90F0-20AD9B96B8E1.1;
        Fri, 15 May 2020 12:53:47 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 135ebd315029.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 May 2020 12:53:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jTnxrjxFbDjHXO7hiXEANI1RPrc3B6nmagfB6EWtGjlKrazgxKD7Kp6PKx09PtC7CKVlWUZKoWwsfbM4CmKE6JKLIx9Q11+hlERLcgIGXiDNyT4ekrS5QOMN1tfOkoOFPJlfpn8cC1wmYi+tQoqlnUX47UGqACqEWIWPJhcMjhMb3wW+mjdfP0TKjZp8BnXsl9KkmctOj60rs33n22JZ+6bI1c4Lz85DtRAhF85EsLXH+sUmH2j7WffF/2yk11v46LRhEDEC1koMpxIQeW+/xqPMqg2zGYtS4D87NKnsX+1xLByffCGzkpZXxKNcB2Lg38KRS0vvg5K4sG32HIL22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stnUWRg+rnNrzWma3EVekRGQliDkle5EU2+JAanlOO0=;
 b=DiX4/Ky7LCJQ17pmeXuH6Mr+48G8ni8tAReQTvB+lpasVDz1Xmlu2HKYfYoO9S/eE7v8CHtgwlqazrPB2z1RR59EQ/GzNstkIjyUYRY5dhUeQV8nFOl7dgB9x35gwl9UGHfgJ9FjtjTM4Jm+y2Va/gfAQXxT+fwkikpASYQwSKqWo78PPT7VkPulIERahqVYt2E1WaUsdYegzceis1nNZMZnYurugBoI2KbYh4FYYBl5x0dLMJF41siQpCMEWdwe1yeulzYoXzf1YQBfTc9+RrGjRp9kqyZJF6hOAcmdl1g51imqXw8C8Tt1C05WbMo4EXV/MdHxxJ+y9DEbCzHgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stnUWRg+rnNrzWma3EVekRGQliDkle5EU2+JAanlOO0=;
 b=vOrhozJLUjbB8OP5QYYL/Axc7SoArGrEMy+a54cCbfwd02LV7JpVI+JkW/HfwM4noOoMpVyBuSS/vhLtNA+Jqpp8yB4b3OvYt0pw4O6Q9/SCvAk8fcu+TMxAI86CQg5DqLVyvOJT7ME9L45f71pqkkEdX1L10RyjMmk44FJA/50=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3862.eurprd08.prod.outlook.com (2603:10a6:20b:8c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 12:53:44 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 12:53:44 +0000
Date:   Fri, 15 May 2020 13:53:32 +0100
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
Message-ID: <20200515125332.GF27289@arm.com>
References: <20200430162316.GJ2717@gaia>
 <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
 <20200515103839.GA22393@gaia>
 <20200515111359.GC27289@arm.com>
 <20200515112740.GB22393@gaia>
 <20200515120433.GE27289@arm.com>
 <20200515121343.GC22393@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515121343.GC22393@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN6PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:805:66::34) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by SN6PR08CA0021.namprd08.prod.outlook.com (2603:10b6:805:66::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:53:39 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 713a336b-aa5d-4326-f628-08d7f8cf0565
X-MS-TrafficTypeDiagnostic: AM6PR08MB3862:|HE1PR0801MB1721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB17219EFD0B62DCAC4F25D462EDBD0@HE1PR0801MB1721.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hLzO3fSMBPbkP8zlp0v4LdsUj4l2Y7AZcDdRIi5ln16z7ovj07LSh2yhEuAw98XNDbiR4KXNI/s9zBELVNmNqp9EpKDxXtbNgnZB4k0opLLxgDy872BXXHpVHgk1r7tZAqQJWwqozG8stHGZlri5V5YgB5VHv8eZYsFjJNfWtHAMcH2wXpeIHIX3XHUTSWWuoSNpzHzj0ZFvQhqA6qI4SD6FwWZ5JnFSC0rXXAS9kJ2drhD9rRsPn8GBgRkqyKGKENnqHgP3RcdIOWdZXKJDtOtyuNWzHXU/mk4h7ibIah4cBX1tCs9F4uwfQxwQlYF2V2m/p9YIe8wRE58gjDcA4gzyhO3toI2Nm0ZwUcW6/3PS3jftiUSIpbELhGTzNSGFAr4Wg9JNfgemrQtk7+DFRwHhl0OZrBKN/ieNg6/ciNWf1goDMJGeIDwy5k+bLiok
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(6636002)(478600001)(66946007)(6666004)(54906003)(26005)(66476007)(186003)(316002)(66556008)(2906002)(2616005)(44832011)(16526019)(956004)(8886007)(6862004)(55016002)(4326008)(36756003)(8676002)(5660300002)(8936002)(86362001)(1076003)(37006003)(33656002)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r+8TzCJLJ2NVDtsHL4aDbrFoaDNU2yupok/9DttLOZsNCAodscMqBBlk+PK7dRuSXgjfNJrQHmZx4rE8fS54ilDKWl1m84O9PBY2UTALsx1aGneLm9zp4vhU72bh+hpbW2NFjmz4WZBvNJv5AZyzd1lLYoT3UCl3TkT1LUNkPDGGthO0Uzwxg0zvYKliv7dVSkrQuqxBbcqm3F4jBrilYImKRP6hiOsGi7NdpQGjYNN2Pv9V3SrPKD+3d3VB0pjzSGVDBk2F8061bRd3uAR9BsKNbV8/F6cuYnbQZFBN0mper0HLHX4/W0bPACb3eVcZtQbNfyfsT2Hmb2NM57/Mei9LJfM/UFLjK1EPZZV0FPQ2r8S3kKusQwHJk5p4aBv8CT4KJqnCtvbcATK117FN1/gIGo+CV1kiZjak0DougawCXi/iS3hp9f8z6bmgHvrO/8JaC1gcy0u8h8x6O6zHFuJQtfH7mkgokpQVm5iiuO9ZMYJeYiSKGLMnpYqsu+fK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3862
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(4326008)(8936002)(81166007)(6636002)(47076004)(8676002)(86362001)(55016002)(54906003)(37006003)(36906005)(82740400003)(316002)(6862004)(1076003)(956004)(44832011)(70586007)(36756003)(5660300002)(336012)(478600001)(186003)(6666004)(33656002)(16526019)(356005)(70206006)(26005)(7696005)(82310400002)(2616005)(2906002)(8886007);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 25cafa1f-93e1-42ed-c2eb-08d7f8cf0027
X-Forefront-PRVS: 04041A2886
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2V2+KaK6dAD1NSyj/GcSjP04mZiif36kwftm4C5q8SR1iXXfZfRI4XUZd9OQVVxjA6AyGQwtO9TGwq+x1nhQh0y14LP84sb+yZM0/yzcjgNDQhDvVtsHXOk5R/P3AVxVrYD19jX9VgDmk+4ugPhH+qGUq5oZxxizm40JGNROjGRGTmKeH9WdJfET5rDa0xBhAFIV8zi6AosQic203UABnt+2Qj70fS6r7Iy/hkltBdn727HsM/ejjS8T+rOb7hTmxV+Az13EzwNdbsJIvIkqLAV90Q1OC50KsLZ5ztsnOT9aMi3wFf5HSNIM+goc5NnkB3V1TORtGKIf6hyGkJJQ1Gvp1iV9ux94oMzZnhPi42RiS0xabTTK3iv0EiHLV9kvpFkCdbvGZLWi6DEDuqGPro4QDe9ASwVUG4GNZ1QJyiSjyZIUzR1/h4ugpas7uTBkPWdpcw7pSIu620IeqK+jM+zc3bXqbRmKediJ4r3ss/JlpX/Q5wYOD9vucH0Inv/SQypnPyN/SraXlHC04nvxbA==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:53:52.8161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a336b-aa5d-4326-f628-08d7f8cf0565
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1721
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 05/15/2020 13:13, Catalin Marinas wrote:
> On Fri, May 15, 2020 at 01:04:33PM +0100, Szabolcs Nagy wrote:
> > The 05/15/2020 12:27, Catalin Marinas wrote:
> > > Thanks Szabolcs. While we are at this, no-one so far asked for the
> > > GCR_EL1.RRND to be exposed to user (and this implies RGSR_EL1.SEED).
> > > Since RRND=1 guarantees a distribution "no worse" than that of RRND=0, I
> > > thought there isn't much point in exposing this configuration to the
> > > user. The only advantage of RRND=0 I see is that the kernel can change
> > 
> > it seems RRND=1 is the impl specific algorithm.
> 
> Yes, that's the implementation specific algorithm which shouldn't be
> worse than the standard one.
> 
> > > the seed randomly but, with only 4 bits per tag, it really doesn't
> > > matter much.
> > > 
> > > Anyway, mentioning it here in case anyone is surprised later about the
> > > lack of RRND configurability.
> > 
> > i'm not familiar with how irg works.
> 
> It generates a random tag based on some algorithm.
> 
> > is the seed per process state that's set up at process startup in some
> > way? or shared (and thus effectively irg is non-deterministic in
> > userspace)?
> 
> The seed is only relevant if the standard algorithm is used (RRND=0).

i wanted to understand if we can get deterministic
irg behaviour in user space (which may be useful
for debugging to get reproducible tag failures).

i guess if no control is exposed that means non-
deterministic irg. i think this is fine.
