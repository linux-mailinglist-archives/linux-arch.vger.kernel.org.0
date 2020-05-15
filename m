Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EF61D4D53
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 14:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgEOMEs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 08:04:48 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:63560
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbgEOMEs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 08:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GakRaHszA36F8KkKA6IskoBKEmPyt3LszhQFogIOAEI=;
 b=g9zhiQ7g/myKWlzoNZ2x9g7G/9kLYq3eEm16gYFq5Uz6iPMpZ2ho4B1nmuzigzz+3mBKH2euIxtZ3spM+WL+XrpRaSq+vxRbu/eVPNpXNmrfKnyRay/LmuZhXDNNcZb9ooFU2ucdsACdmnb418Gb9mdJMdAWJHhC3S52W7Hm7RE=
Received: from AM5PR04CA0013.eurprd04.prod.outlook.com (2603:10a6:206:1::26)
 by HE1PR0801MB1915.eurprd08.prod.outlook.com (2603:10a6:3:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 12:04:43 +0000
Received: from AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::b5) by AM5PR04CA0013.outlook.office365.com
 (2603:10a6:206:1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend
 Transport; Fri, 15 May 2020 12:04:42 +0000
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
 15.20.3000.19 via Frontend Transport; Fri, 15 May 2020 12:04:42 +0000
Received: ("Tessian outbound 5abcb386707e:v54"); Fri, 15 May 2020 12:04:42 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 01a8068636f8397a
X-CR-MTA-TID: 64aa7808
Received: from 4dd3ab939d8e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 82E89776-DB01-45B0-BF6E-F35C22E89D05.1;
        Fri, 15 May 2020 12:04:36 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4dd3ab939d8e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 May 2020 12:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXz3aI+VVh4bWEMlyNSdbmqxsydfnRGyto38muC6le9kKCjPAGIJzx0ky/aLrEWex1p0uFqpyl4ugJijysucMW+DGSIjS7k74dX6UICEGvrxt62SBbOCViCk19CjqWPFWwJH3LLGGMOYe3+KMFXccP4nAanHesZNUvDrWIcdWYkfyyqINe3B1fNgmQjv0+r2KoBGuu4lPyVUmP2A4djkARPX0ey8obcIpCaBcOoWA+Lau8GpWxZM5RSnoNVibPAfnwwM6A+JVhUQ5cV8lrXx4UxdUECH6jGwTrm63QM8jhdNhc0xEJRR5qqVPzc+FWPfMI5/+Sj2Eh0z0yQnRx1qWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GakRaHszA36F8KkKA6IskoBKEmPyt3LszhQFogIOAEI=;
 b=FiL/d97wbM8bueds9Gm+z4wKwgVxdTdSNiBjl5nL9DNiy1JBj0tiClWkI2zyYP2EL8WwFvFAohDOaBSd0T1nfzvg3D3/Evvt1ge2rSoU18uVCpWk7i5lCN7//eRtrVnashuIguPuJ+6tEIWiCgCBJH+19coZ9Kg5hF5+n2tS0HblGS+xsAwZpBGLFHgnK3E0FMp1+sju05fwgxQF6llfxxacswqS3GqeXSOk5eHG/iyopcZnUSTQI6qF783T97R27o21Kc0oZnCFZKA66CipbZPiPnGhaayiCbaAE2fKf6MB8Q4ikwkFV1mDIMAOsOcit93pwhZxkA9RtMS5DDXQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GakRaHszA36F8KkKA6IskoBKEmPyt3LszhQFogIOAEI=;
 b=g9zhiQ7g/myKWlzoNZ2x9g7G/9kLYq3eEm16gYFq5Uz6iPMpZ2ho4B1nmuzigzz+3mBKH2euIxtZ3spM+WL+XrpRaSq+vxRbu/eVPNpXNmrfKnyRay/LmuZhXDNNcZb9ooFU2ucdsACdmnb418Gb9mdJMdAWJHhC3S52W7Hm7RE=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3911.eurprd08.prod.outlook.com (2603:10a6:20b:80::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Fri, 15 May
 2020 12:04:35 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 12:04:35 +0000
Date:   Fri, 15 May 2020 13:04:33 +0100
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
Message-ID: <20200515120433.GE27289@arm.com>
References: <20200421142603.3894-24-catalin.marinas@arm.com>
 <20200429164705.GF30377@arm.com>
 <20200430162316.GJ2717@gaia>
 <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
 <20200515103839.GA22393@gaia>
 <20200515111359.GC27289@arm.com>
 <20200515112740.GB22393@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515112740.GB22393@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::20) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 12:04:35 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98d34ed9-91fa-4c21-cf24-08d7f8c826dd
X-MS-TrafficTypeDiagnostic: AM6PR08MB3911:|HE1PR0801MB1915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB19153356515EAD8838EFC041EDBD0@HE1PR0801MB1915.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PMUjniqh90HxO54jLCRigwTgV+h1hNwEKNsy7nQgxlNzCjrGn+WuCw4FYnqZCNcqe7pCyZDWLObvxasMUCsVXONt2770pUDcymE2s7cjAQyjyZewYpF6sUff3D/3iYFXtihcw+YEJRHNmykOYqnmK8tuaqwLnlSEgxW2zMM8DAxZj60Yg/32EgdPLk3UbPY8rxgOB0MRDg1a6va6QrAIaftDqDOY59Z8pPTwh3wxp7B3AqLl17Ch83fTi/9eMQIGqWuj1PNak8ILG5fBcCveDBOVpl43vulVoo+/9NIzMvNfohcUhblARTCYRMlAp9BTzKi3++08Hec0Lc8ndI7l4Sjz9BFkleTfEbDUim4gPobdFkMmX+cETspezhlF0tXO++d85UcZfzNFuzubnbvS+S2NcNNydatxatoQXG3Tb5/juZgm2LK2V4vCNTjKFp+W
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(54906003)(26005)(186003)(16526019)(8886007)(52116002)(2616005)(956004)(6636002)(7696005)(55016002)(4744005)(8936002)(37006003)(66556008)(44832011)(478600001)(6862004)(66476007)(2906002)(86362001)(8676002)(33656002)(4326008)(36756003)(1076003)(316002)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vHNoMi8bt57OWASlmfOPYxo6146R5a74b1Lkr1/V/xRIr8RvR6q9ZWEAucehpvSO5JImee8moEIbKpe0wGR3+zdDEOvK7eRgIWb8rIZ3mBfOH4Kj8r/s15iyLkjd/efCId2PDgJU70EfoWe6mrPkBkSPNcqXwXi7D/3n4wW49ymGZ9ns3BVFrK3eijTtdqPYaYEMcG0zNRTC6y+4eD/wrMtsDksHt7ENKxBmg2Sod3U2FIeOZO2C9Rbxb0ePcMI/2IMpsQ7l97/vOYopJ1RbUJ6tSKQrBFT5SBAxuevqjzx9GFPljNgvpA0TzcJJSh5UZJw1GpxqxPmyPeHuOfNNoCp+gBnlSSg8v902kF9XDCpq9v5JF99TPxrne8khGkr1YDadKOdTNzi/OLNLTOg7dsN8BSWMmc7nsM/gbX32D3iUmGZKfTrNugl3yBAypdxSzF1bynrS1FRJYBc1ck8QfnAvx67dXA8sj1vmgCANYTndu/BsPwLTENpymFLL/xwz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3911
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966005)(4744005)(478600001)(26005)(44832011)(6636002)(1076003)(186003)(956004)(8936002)(55016002)(2616005)(37006003)(7696005)(33656002)(16526019)(8676002)(82740400003)(36906005)(316002)(54906003)(47076004)(336012)(5660300002)(70206006)(70586007)(36756003)(6862004)(86362001)(356005)(8886007)(4326008)(82310400002)(81166007)(2906002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5bdbc560-2235-4c74-a59a-08d7f8c822a7
X-Forefront-PRVS: 04041A2886
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LO9Vg9x1pxAZMds8yl/WMv8zrtx2TCssfklYhZwHnTRdI2EDdte7p2PU35MlI6sFBSLRSLVNSakZoYLaih33lD19oZA4p8dSnswjkzQsO266iPSqanCEuhd/QDpyHAtuV33SPIdhhJPnL/QR9UdF+OAotgR8Q0PZMPy2Gpb18pFNPrwTPnCvxyTjXC/VX5USHtm8IhpAhlmUSDGy6dzQGosW3RJEMOnuFvq78tkO6F3VNMyL85JYtsxMeiJEqKaLar95ZwUTWJgYS/rY+TGYnK7jLTfHajED+/3IY33cTziQydZeElf+39KcGYJN7lncmMvJudrqbURnCkP4lC5VK91/WdZ6Ub6XkDfML4Y3ok0mOZm35UNyIWXK7IJwHA4UyLB6rOupLTC3QjA0lOSlwlk3m2lVVun9lJPOfsHuJ+ergmQ/XUc8YFhphtCjtr1bRwbbZCLtXbHchlINLTFaFyeyT9QgUcoGTGV5Lu2MrTy/JOUvoGaus2Tshpy7uQIUZkdu7jOf4VrHEqLk4WUjBQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:04:42.4863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d34ed9-91fa-4c21-cf24-08d7f8c826dd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1915
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 05/15/2020 12:27, Catalin Marinas wrote:
> Thanks Szabolcs. While we are at this, no-one so far asked for the
> GCR_EL1.RRND to be exposed to user (and this implies RGSR_EL1.SEED).
> Since RRND=1 guarantees a distribution "no worse" than that of RRND=0, I
> thought there isn't much point in exposing this configuration to the
> user. The only advantage of RRND=0 I see is that the kernel can change

it seems RRND=1 is the impl specific algorithm.

> the seed randomly but, with only 4 bits per tag, it really doesn't
> matter much.
> 
> Anyway, mentioning it here in case anyone is surprised later about the
> lack of RRND configurability.

i'm not familiar with how irg works.

is the seed per process state that's set
up at process startup in some way?
or shared (and thus effectively irg is
non-deterministic in userspace)?
