Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122FC275415
	for <lists+linux-arch@lfdr.de>; Wed, 23 Sep 2020 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIWJKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Sep 2020 05:10:35 -0400
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:9699
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgIWJKb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Sep 2020 05:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzgmUemalOFlEJAnQ3wNlX9VEIBZL6ML6nV9jflSQ4Y=;
 b=m3YBSeDbljsmuIZszKogWY+F72ZXUjSv4NqUdyTzfUk79C1fUFeaAFsrk1+6L58d1fH3fofESwr5UyasW9qQTUpKhjNoE4Zrtl1sFv0qbuY8VWQeekXXtadw2TSFHjeVVUhzhZt+rnx1FUplMvEim6ty7Fc9cZebKvRSDtFMClI=
Received: from DBBPR09CA0027.eurprd09.prod.outlook.com (2603:10a6:10:d4::15)
 by DBBPR08MB4744.eurprd08.prod.outlook.com (2603:10a6:10:f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17; Wed, 23 Sep
 2020 09:10:26 +0000
Received: from DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::2e) by DBBPR09CA0027.outlook.office365.com
 (2603:10a6:10:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Wed, 23 Sep 2020 09:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT061.mail.protection.outlook.com (10.152.21.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.21 via Frontend Transport; Wed, 23 Sep 2020 09:10:26 +0000
Received: ("Tessian outbound e8cdb8c6f386:v64"); Wed, 23 Sep 2020 09:10:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 7ce91b9e131beaf4
X-CR-MTA-TID: 64aa7808
Received: from a77fc1472dc4.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9E55CEE6-CBA8-405D-8F99-F18A560549F5.1;
        Wed, 23 Sep 2020 09:10:21 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a77fc1472dc4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Sep 2020 09:10:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZW67eVYmScC745fIXBdvhfbpEj4Ygp+pv39RWZmKWTatDkgt3PCz8yoVLp1I+jNXQEF6FRpN6lQ1sL3sCAkEWQTOtGPJ9cCz3ymZEzkQvmlopDvdyeHT6nInJQ8J3KtHOPm6Iz80ouWFDIF23BdFNmr5FE40SW7ArMhma+8ZamzKmC0Pbu/cs9jkILA49+iX2hYrAWn8xXRl1yTC9dmGOsllMK6fe+FOjfcOm9ePNPEfm2ICPFW/2fb6YPBIEt4T5piE9FaTcFda996cjsXqICQNOqOjRAb2JBu3bIab4rfaiyR3txQOmvr6adwjTY0ZCcBK6hMIRrfoKoMo7Kq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzgmUemalOFlEJAnQ3wNlX9VEIBZL6ML6nV9jflSQ4Y=;
 b=M4ll7M0Ae44p3bSvTFmL25CQV6QLSeh4NC5b4fZwCTB/4F7swkWKppX9yGdeFMZj9kkhHQd7qlEqosE9y+KCld7d3G+yQBeBgdX7g8pcmp4BZ+O6/8z6TPuvTdo74uGZt+1MtjZ1GvdWTW6D+0JEBjnKuwbxV3AODS99X10R4orr6ri7VeQcEUxk6K+9qcn9WwxpCEB4FslRBnQVm/zv9taJctUE5J+IGaJFo9eHye0/Olptvu/r5dDxlqY7SCBbV1dsisx6z0G+A45MxfsxK4ppRxedzGOigWny7oxNck10RUUPjLM+okdauqAJei1OMf8ALOisOvVVHmmY92kryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzgmUemalOFlEJAnQ3wNlX9VEIBZL6ML6nV9jflSQ4Y=;
 b=m3YBSeDbljsmuIZszKogWY+F72ZXUjSv4NqUdyTzfUk79C1fUFeaAFsrk1+6L58d1fH3fofESwr5UyasW9qQTUpKhjNoE4Zrtl1sFv0qbuY8VWQeekXXtadw2TSFHjeVVUhzhZt+rnx1FUplMvEim6ty7Fc9cZebKvRSDtFMClI=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from VE1PR08MB5566.eurprd08.prod.outlook.com (2603:10a6:800:1a9::7)
 by VI1PR08MB2848.eurprd08.prod.outlook.com (2603:10a6:802:23::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 09:10:18 +0000
Received: from VE1PR08MB5566.eurprd08.prod.outlook.com
 ([fe80::11d4:e51c:433e:ed0a]) by VE1PR08MB5566.eurprd08.prod.outlook.com
 ([fe80::11d4:e51c:433e:ed0a%7]) with mapi id 15.20.3391.025; Wed, 23 Sep 2020
 09:10:18 +0000
Date:   Wed, 23 Sep 2020 10:10:08 +0100
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
Message-ID: <20200923091008.GC16385@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
 <20200904103029.32083-30-catalin.marinas@arm.com>
 <20200917081107.GA29031@willie-the-truck>
 <20200917090229.GA10662@gaia>
 <20200922155248.GA16385@arm.com>
 <20200922165529.GH15643@gaia>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922165529.GH15643@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0401CA0026.namprd04.prod.outlook.com
 (2603:10b6:803:2a::12) To VE1PR08MB5566.eurprd08.prod.outlook.com
 (2603:10a6:800:1a9::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.54) by SN4PR0401CA0026.namprd04.prod.outlook.com (2603:10b6:803:2a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19 via Frontend Transport; Wed, 23 Sep 2020 09:10:14 +0000
X-Originating-IP: [217.140.106.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94a6d069-20e1-4cbf-2a7b-08d85fa082c1
X-MS-TrafficTypeDiagnostic: VI1PR08MB2848:|DBBPR08MB4744:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR08MB47446858A82D94E843B90C7DED380@DBBPR08MB4744.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 2akHAG4RMNb0jOxd0X3XK8mOhMlE4ZGGAeK6tbEvcFiBtbq4JWgeUdkJPY7dAUAcZDUYNQ9T+ukAY+y4blBWnTDg1DZYrv42j3qt0sSUY2xWtgB45WyVp9QQCdZG0jsaVZ6PmII5pSoOVaUqN3zXaXxGPet1uk1g9Dy/lkECJTO3ecsLvprCeo97HxckXT1GliaHjkDnNzvPfpPRu6724KnaKbFJOQ8HPG7vKyOLxq8sAV5GMdckRTh8KonjFFEX5dMchZMZe4NZQ7zgh7VYBMzxFAX4aL9LwqFH4c0pfpMLUMEgB/eG7MZx0pLF4fieMJiOz/X7iJvqHB07SBHrVg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5566.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39850400004)(346002)(376002)(136003)(186003)(16526019)(83380400001)(6862004)(33656002)(86362001)(956004)(2616005)(478600001)(8936002)(52116002)(26005)(7696005)(55016002)(54906003)(5660300002)(44832011)(6666004)(8886007)(8676002)(6636002)(1076003)(66946007)(66556008)(4326008)(66476007)(316002)(37006003)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: k10POoofrRxwlsnRk5D7EU3HVisKT81v/k4DE6eOYSG/uFHHe3gOvAPtGyI9ddzUqhyPDMJACUZXE6KFtNOCWWbYlMlPQHsoZ9MOTmGgjYbtI6jcLS0nwx9BGXLSX/RgHG2pmGXMH8VdOV6Dx9aw33zkxdSTfEc8zNeiWWSLjDaMrG1xMCUdewj8fcDShPN8CtSgtorGMblmgxkjtHeVt3CfvVpsnIA6Xp/oTvg7xcDbRj0z5uZycLjpzx3zEChnyG5OiZIgFyMqCBR9Tu3b1N7MiJIULPZo0/AbvFM0Q+X2vV+6HUWIkmTSmjN2Q3RVwVflR+Fn4MFOYy08V6AbaBmXsVJM7NY36WJrpBR35jTTNaPUUqu3Lo2lsxkTg7dUH9EAm/LS1EOCwucZme29e30cH8wrcoR+PChdwmI55BngBi1shVWo8L425UD1UWHLdKzN1Nt6QpENv505Z8PDHj52SI93Y3FdEZth/xldrXeFCM2zY0NLuPr5+q82m2xT4mb7tRCb0D59P49Lcgby8Q1tvv2CVRru3pV2VLaET2mH9teZKxO9VcmGXSmzkgL1Wgibjk+3V+iELxeDn+wyQYUUELefhL0y++6AQGi95tFx7mrpk+0ogXCLfs5wK4K2WjzMPQjmPmUwAy59mUw73g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2848
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b585b680-41c3-42e2-863f-08d85fa07dcb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: le/wSDaSD8UWqBTqUVuI2rFmY8rFKLmi+21q4sGy9+0gR6/po56xbkhq8GP06s8ON7DAm7qGX1CZixxWD1vAO7DnJbZhY5t+JpGeLSdUztz4QLe53xD2XGeMODIa82QNiFefcEsZ+MYabCYVjbvvBHuui71o8rwnOTEzICHeAtQDgvA4C4UztB51OIqmbHjKZb1AhcUx+0AOhD+vvtBlguJSrk8gAyZmO578/LZHUaxHKv+M9dRvdbj6vDb3nA+dYp9H0toKtmNbkfBadHoKyrvnriLpitXrdiTI47nwi1gVvoTBBtJIa4h4Pr+rsf/aSwEOTT2OYZ+VUOvI7WcOxsm7fZq5qCzJ41JAY7NrXZiz22FHNjOnhCDu3ulW0JnZUieZPq6YQUoOUyR99uMKvA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(46966005)(82310400003)(8936002)(478600001)(107886003)(36756003)(81166007)(6636002)(86362001)(186003)(6666004)(26005)(47076004)(4326008)(2906002)(70586007)(70206006)(336012)(83380400001)(6862004)(8886007)(316002)(37006003)(5660300002)(356005)(44832011)(54906003)(16526019)(956004)(8676002)(33656002)(2616005)(7696005)(82740400003)(55016002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 09:10:26.5963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a6d069-20e1-4cbf-2a7b-08d85fa082c1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT061.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4744
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 09/22/2020 17:55, Catalin Marinas wrote:
> On Tue, Sep 22, 2020 at 04:52:49PM +0100, Szabolcs Nagy wrote:
> > if we add a kernel level opt-in mechanism for tag checks later (e.g.
> > elf marking) or if the settings are exclusively owned by early libc
> > code then i think the proposed abi is ok (this is our current
> > agreement and works as long as no late runtime change is needed to the
> > settings).
> 
> In the Android case, run-time changes to the tag checking mode I think
> are expected (usually via signal handlers), though per-thread.

ok that works, but does not help allocators or
runtimes that don't own the signal handlers.

> > i'm now wondering about the default tag check mode: it may be better
> > to enable sync tag checks in the kernel. it's not clear to me what
> > would break with that. this is probably late to discuss now and libc
> > would need ways to override the default no matter what, but i'd like
> > to know if somebody sees problems or risks with unconditional sync tag
> > checks turned on (sorry i don't remember if we went through this
> > before). i assume it would have no effect on a process that never uses
> > PROT_MTE.
> 
> I don't think it helps much. We already have a requirement that to be
> able to pass tagged pointers to kernel syscalls, the user needs a
> prctl(PR_TAGGED_ADDR_ENABLE) call (code already in mainline). Using
> PROT_MTE without tagged pointers won't be of much use. So if we are to
> set different tag check defaults, we should also enable the tagged addr
> ABI automatically.
> 
> That said, I still have a preference for MTE and tagged addr ABI to be
> explicitly requested by the (human) user either via environment
> variables or marked in an ELF note as "safe with/using tags". Given the
> recent mremap() issue we caused in glibc, I'm worried that other things
> may break with enabling the tagged addr ABI everywhere.
> 
> Another aspect is that sync mode by default in a distro where glibc is
> MTE-aware will lead to performance regressions. That's another case in
> favour of the user explicitly asking for tag checking.

ok this all makes sense to me.

> 
> Anyway, I'm open to having a debate on changing the defaults.
> 
> -- 
> Catalin
