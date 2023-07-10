Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8074DBAC
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 18:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjGJQzq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 12:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjGJQzn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 12:55:43 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF2F187;
        Mon, 10 Jul 2023 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b52kxjIbzKwFn0WYm3LjTdw2O3lOH9P+tsnbMSn4c3o=;
 b=Q7PVmz6V31vZ6DchfQsbT5TzCPTr3yHt7TcK2+adS7seBq6OamDqr1d9AlIYcAMB+cidBlOBl1nBflJfbfGffYB9T4/jWmwbelkQBzHpBFq1Kv47+nKwHyFylMweyMpu/RDLB1Zcw4ICiUARXFILvF+IhfCT9I0jQ/UYRwefMXg=
Received: from DB8PR03CA0030.eurprd03.prod.outlook.com (2603:10a6:10:be::43)
 by DB5PR08MB10096.eurprd08.prod.outlook.com (2603:10a6:10:4aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:55:04 +0000
Received: from DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::2e) by DB8PR03CA0030.outlook.office365.com
 (2603:10a6:10:be::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 16:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT021.mail.protection.outlook.com (100.127.142.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 16:55:04 +0000
Received: ("Tessian outbound f9124736ff4f:v145"); Mon, 10 Jul 2023 16:55:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ac1b14dc7dceaa16
X-CR-MTA-TID: 64aa7808
Received: from f0426a1ec8f0.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 561E077A-9C4C-417B-8EEB-CDD0D27B6C78.1;
        Mon, 10 Jul 2023 16:54:56 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f0426a1ec8f0.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 10 Jul 2023 16:54:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv38UvGdzw8yEokfG7qSRHYkJsmEXCfV4ZWwmrrdIKPxKW1Is+4lGs11B2YM+T8m5tKC6kh6bEGXUWpUJ2F9jTlUOrMeC9e8gXmu/y/G8E1NyWL0K4q5XSi4plzbDP6+LMvPAzi8NhXGCZtT1cvf7r+7uOUnwfwTbwr6x2cscn8yq3FiNiOOiFO1evevyP6+64nrNq18m8gJFXa1Ir6a1BzqRbXLo7S5bbZle7tq8MPHA0qnsZmnIa6cGoPBWC5S7yJr4pt+xGQpsfzMZ1YxIsFT4DCx4XrTruKigRWqHLMFQrD0WoaC4ymfBIFJzxvFmsqM2iPfooKKdZFptPkihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b52kxjIbzKwFn0WYm3LjTdw2O3lOH9P+tsnbMSn4c3o=;
 b=HgMTEgsEknOH4tbhCl6vu/xnM4Uk0TvrnDFAYd8RoKACd0eQfZFs4kHshyPdUbYvIupesIpnGEAy+H2ox5Wa2gNNZjoVTkrjCkO9z8p07/CWDoOXL2/DNyggcUPaLLYOFgPfGTL6Ja4lcWuU4YwbeknsOKpkSMZslXNOy4EJezgb9ZGwofj4vGBjweN1Um6LT5l49UOfqabP+pOO6bZv0pdg6BDlZjUQin7/jk9V6Jp3EC5eQ3Y/jnUFS0S24i4oLrb9m1w7UHRsqUUHzvcY0lg+5Np6Qnx0cbmQyvE4rLgvbf47Ebj9L6oiGh7/UfamKHueu4OOZlUKYeKd67D8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b52kxjIbzKwFn0WYm3LjTdw2O3lOH9P+tsnbMSn4c3o=;
 b=Q7PVmz6V31vZ6DchfQsbT5TzCPTr3yHt7TcK2+adS7seBq6OamDqr1d9AlIYcAMB+cidBlOBl1nBflJfbfGffYB9T4/jWmwbelkQBzHpBFq1Kv47+nKwHyFylMweyMpu/RDLB1Zcw4ICiUARXFILvF+IhfCT9I0jQ/UYRwefMXg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB10345.eurprd08.prod.outlook.com (2603:10a6:20b:57d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 16:54:54 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 16:54:54 +0000
Date:   Mon, 10 Jul 2023 17:54:37 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "bp@alien8.de" <bp@alien8.de>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "jannh@google.com" <jannh@google.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZKw3zSKxCug0IbC1@arm.com>
References: <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
 <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
 <ZKMRFNSYQBC6S+ga@arm.com>
 <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
 <ZKa8jB4lOik/aFn2@arm.com>
 <68b7f983ffd3b7c629940b6c6ee9533bb55d9a13.camel@intel.com>
 <ZKguVAZe+DGA1VEv@arm.com>
 <1c2f524cbaff886ce782bf3a3f95756197bc1e27.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c2f524cbaff886ce782bf3a3f95756197bc1e27.camel@intel.com>
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB10345:EE_|DBAEUR03FT021:EE_|DB5PR08MB10096:EE_
X-MS-Office365-Filtering-Correlation-Id: 184477e6-a80d-4fef-0330-08db8166687e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oW4Qi92VkPAyncIJaMc5/GkNdY7ixx3sNE9sR6k3xm2R3DjcDHAR19us0fRhGEyxgTCMZJIewwypXajzW7BK6nuiy9EgeuyUMPOtGUrjFVNGfpNZX6k3AcFwGQUxPskDTpl8Jslv2wcnIRX9jXWOymFoVcyeC6+ahmfbAINTCWkcU7iG4TzjUNOzTCxohNyN0l9VURILsqqowD9b7yhYUPh2hEaFXdGZnMyxnrqfNBqD2jzq4qdm3ICRHjjxZXx2oRPQ4ZVEXNShIKBVs7sUOXpVZkVPvgko6mg25RteUI/+QDGJonlH9pR4wRZz3lgprivN+nksUpGPiJCiiXPc8RDwh9PCITKIBe789EPe7xc1xLRDiiwPCXiaWs6xw+dKoasEoIba2SKaJfBxNMtfxJVtUd6g+AvyTPvnuDf089hDqOG3zfs1mQ0WeUk3qZ4/DHhRVa2HIOurXHNVRkPY6FK2WMbwbx2AqeCXuk9Drgfv2CpspMhyQ3ryG/ykl3NeHpGJPXlaYGCYfV7EU2cnPFjfaOaDv8ePlRXBUINdmFJGOqxsNY2VQuD32eY+XrU1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(6666004)(6486002)(478600001)(110136005)(54906003)(2616005)(83380400001)(36756003)(86362001)(2906002)(66946007)(186003)(6506007)(26005)(6512007)(38100700002)(8936002)(8676002)(4326008)(66476007)(41300700001)(66556008)(316002)(5660300002)(7416002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10345
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: df91ed88-ba0d-47fe-2815-08db816660af
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YS/IhEVpgiHbZ1ZGDo2ZwCfR83itoC6AkR243bcokxW8u2YEDWJeIGRsVJnxEG+Dmg2JLhN3Ro1aBcn9TFkaQlZ2h1ddIq2h5eZpty4+3seOxHdY14bObb4gDLhDADI4DV2VO6Jr9oJ5MCUHriAJILhVbKnpT3meDgbA0pC+rDF50GA/4okhiSp1sXsuzCSvfM6LvXHHDS+dtY936eXQaeuCxvfNm44j3NZnxdZLp1DLZtZEUqBZ430TCo8n1j/8Z/rmnUY9w6a7LQwPx7f3kDK2sby9tTKZllaUVypAY59I7PrfnnBzJK/uVKgPG4UF3T4vv1AADZd3WkLeASkQkte1BVzSHbr7rOOhDMsJT0lSewM0MkRjtSGt3slBetFrJ4cFyVvLvLFO6T7cHIAAPRq0KCCkhS/rfi18wfBwDSV/l86oi1pI0gQf4emIQrZ78DsZleHMRaN8lXt4/ZSyEj0H+xT9gk0KZZy05Mrt839SyGRg5Vb2F8Mov7UX5VQMwBRzrpovzf5kI7xieQbzL4K4FI9AliiVRjsxLgxC8NOblmETm8ep0swHafMzjWqDkmxnJCElO++hCoR0IFAvOA/OIQNudxsySM3q44XSBXJKwFzd+jnx5JZnDp5YeR4sFgdIm+GKQ1Ph4T8orlF6sipmyvkPB5feU9RHaZPRm4tANR/ojCxpajea6Wy2zL60HuRBvcUZx3Zr1BcW2hTe6q7BQFA9LlwF7f8QqUS1AR7rDFHRzFpb3/xJuTWSHdGg
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(6486002)(110136005)(54906003)(450100002)(36860700001)(47076005)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2616005)(2906002)(70206006)(82310400005)(336012)(70586007)(26005)(6506007)(107886003)(186003)(6512007)(81166007)(82740400003)(8676002)(356005)(5660300002)(4326008)(316002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 16:55:04.1543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184477e6-a80d-4fef-0330-08db8166687e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10096
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/07/2023 17:37, Edgecombe, Rick P wrote:
> On Fri, 2023-07-07 at 16:25 +0100, szabolcs.nagy@arm.com wrote:
> > > Separate from all of this...now that all the constraints are
> > > clearer,
> > > if you have changed your mind on whether this series is ready,
> > > could
> > > you comment at the top of this thread something to that effect? I'm
> > > imagining not many are reading so far down at this point.
> > > 
> > > For my part, I think we should go forward with what we have on the
> > > kernel side, unless glibc/gcc developers would like to start by
> > > deprecating the existing binaries. I just talked with HJ, and he
> > > has
> > > not changed his plans around this. If anyone else in that community
> > > has
> > > (Florian?), please speak up. But otherwise I think it's better to
> > > start
> > > getting real world feedback and grow based on that.
> > > 
> > 
> > the x86 v1 abi tries to be compatible with existing unwinders.
> > (are there other binaries that constrains v1? portable code
> > should be fine as they rely on libc which we can still change)
> > 
> > i will have to discuss the arm plan with the arm kernel devs.
> > the ugly bit i want to avoid on arm is to have to reimplement
> > unwind and jump ops to make alt shadow stack work in a v2 abi.
> > 
> > i think the worse bit of the x86 v1 abi is that crash handlers
> > don't work reliably (e.g. a crash on a tiny makecontext stack
> > with the usual sigaltstack crash handler can unrecoverably fail
> > during crash handling). i guess this can be somewhat mitigated
> > by both linux and libc adding an extra page to the shadow stack
> > size to guarantee that alt stack handlers with certain depth
> > always work.
> 
> Some mails back, I listed the three things you might be asking for from
> the kernel side and pointedly asked you to clarify. The only one you
> still were wishing for up front was "Leave a token on switching to an
> alt shadow stack."
> 
> But how you want to use this involves a lot of details for how glibc
> will work (automatic shadow stack for sigaltstack, scan-restore-incssp,
> etc). I think you first need to get the story straight with other libc
> developers, otherwise this is just brainstorming. I'm not a glibc
> contributor, so winning me over is only half the battle.
> 
> Only after that is settled do we get to the problem of the old libgcc
> unwinders, and how it is a challenge to even add alt shadow stack given
> glibc's plans and the existing binaries.
> 
> Once that is solved we are at the overflow problem, and the current
> state of thinking on that is "i'm fairly sure this can be done (but
> indeed complicated)".
> 
> So I think we are still missing any actionable requests that should
> hold this up.
> 
> Is this a reasonable summary?

not entirely.

the high level requirement is a design that

a) does not break many existing sigaltstack uses,

b) allows implementing jump and unwind that support the
   relevant use-cases around signals and stack switches
   with minimal userspace changes.

where (b) has nothing to add to v1 abi: existing unwind
binaries mean this needs a v2 abi. (the point of discussing
v2 ahead of time is to understand the cost of v2 and the
divergence wrt targets without abi compat issue.)

for (a) my actionable suggestion was to account altstack
when sizing shadow stacks. to document an altstack call
depth limit on the libc level (e.g. fixed 100 is fine) we
need guarantees from the kernel. (consider recursive calls
overflowing the stack with altstack crash handler: for this
to be reliable shadow stack size > stack size is needed.
but the diff can be tiny e.g. 1 page is enough.)

your previous 3 actionable item list was

1. add token when handling signals on altstack.

this falls under (b). your summary is correct that this
requires sorting out many fiddly details.

2. top of stack token.

this can work differently across targets so i have nothing
against the x86 v1 abi, but on arm64 we plan to have this.

3. more shadow stack sizing policies.

this can be done in the future except the default policy
should be fixed for (a) and a smaller size introduces the
overflow issue which may require v2.

in short the only important change for v1 is shstk sizing.
