Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD1749D07
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 15:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGFNIY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjGFNIX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 09:08:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65361BC9;
        Thu,  6 Jul 2023 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9tXCIMd1UzmmWbgHwAE1NaFAYam9lAdBTvegn0V62I=;
 b=XKR2xfuHGYZ4M+w/R4vm1N+/5NiHu4k3gPVh3l2PdG09xwTkXpNkHNiuMLekv7KMgEsUEnp46gYIj/vSFY1MHkJiaLEUndMp3afFMGXhEnn4lgnNJ68soBSo9nJPkAHdkYFw2JNqM9frmAM/eECsPPExZ3byOWHIeprpYcFT0oU=
Received: from AS9PR06CA0343.eurprd06.prod.outlook.com (2603:10a6:20b:466::26)
 by PAVPR08MB9016.eurprd08.prod.outlook.com (2603:10a6:102:325::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:08:11 +0000
Received: from AM7EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::cf) by AS9PR06CA0343.outlook.office365.com
 (2603:10a6:20b:466::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 13:08:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT016.mail.protection.outlook.com (100.127.140.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24 via Frontend Transport; Thu, 6 Jul 2023 13:08:11 +0000
Received: ("Tessian outbound e2424c13b707:v142"); Thu, 06 Jul 2023 13:08:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 50e20a765dc3fe86
X-CR-MTA-TID: 64aa7808
Received: from ec28c8c90f1a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D63A2DE1-F817-4E06-85ED-F58040274C87.1;
        Thu, 06 Jul 2023 13:08:02 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ec28c8c90f1a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 06 Jul 2023 13:08:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhzni2GUXHFsT4O+vvD75Wr5xI3IW6o0KOPTT/OxALCvu1ugnuFtc5LrrsnP05wvXn4fe6IZ0EXIAa8F2GpIQ2MTJLwDOmgHtPUjn8IIY1q+EUXNmBdZ34ia0gvHqu0h3bMJ9KPzuqnjoYzdwQj/vqTWEH78dZWKHElPBfi/Q/pJCzZGPqDqMdhxk9/2kiZiHaHGsf3185gp5znG2YBj1sV4fNf1VT8ZjHoTLxX4lsosCRliHzdIbviOsm4ZWPWgWm0qQ6eQptH/jJoQzlE9HjL8qKNNfZEHwLPg0UdzGYJTxgmZij9nkluTXQu708XKb/JPBHjMDB2rljkgK/XPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9tXCIMd1UzmmWbgHwAE1NaFAYam9lAdBTvegn0V62I=;
 b=nrWbecu1GxSk8f35yO7QM93EMfNWt9lxxVitig85hALMPO4DzL9M5GsAl4vhXS+hos5qKSI1lyeoJsCmjpzm1O3qMqeFNTxs1CVz9UVMnETi+ZBgIofBTLsh68X6CrmPMt04AWsyA1hc7P8wFMxc9NxMG1Ho1hkfen6YAF6z3PVWFY1WuRJvi4oDVd7CC/2i9zQJair2NO62cvB+rv+h7yBfc6bhkd3+F24QssggIs9RP7PM5+i7TfkBw0shT8Wgwy0qAYsYB6XAgwEvh+v4V1V91AeAJWgISHH2CmI9HbreNIGJa8yBmBpkQZyHqpzPA1AhBccr28cbLN6/Utib6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9tXCIMd1UzmmWbgHwAE1NaFAYam9lAdBTvegn0V62I=;
 b=XKR2xfuHGYZ4M+w/R4vm1N+/5NiHu4k3gPVh3l2PdG09xwTkXpNkHNiuMLekv7KMgEsUEnp46gYIj/vSFY1MHkJiaLEUndMp3afFMGXhEnn4lgnNJ68soBSo9nJPkAHdkYFw2JNqM9frmAM/eECsPPExZ3byOWHIeprpYcFT0oU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by VI1PR08MB10273.eurprd08.prod.outlook.com (2603:10a6:800:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 13:07:53 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:07:53 +0000
Date:   Thu, 6 Jul 2023 14:07:24 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZKa8jB4lOik/aFn2@arm.com>
References: <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
 <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
 <ZKMRFNSYQBC6S+ga@arm.com>
 <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eda8b2c4b2471529954aadbe04592da1ddae906d.camel@intel.com>
X-ClientProxiedBy: SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::15) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|VI1PR08MB10273:EE_|AM7EUR03FT016:EE_|PAVPR08MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ac36ce-fb9f-4df9-604f-08db7e220ce8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZUtyXLUNSdMaoJHkGUhiNffRozuWvAMc7zvcANren9+i/yNGTAWnviihd9NXa+iqd7rBgPUNplRYaUr3nTZ1QnnTKb8SlzRTrKfwvR41lEprx+8HpTNyghK1XlYcv3Jg3J3WM8VC2J1JV2BNuIbs4BlfC6X5fKZpG2ULI9Sk0zinHqPFPAHAbQ+mox8EUsFnL5VkqaolHvmwNNiFPt/gW5IuaqpdU1oWdUGNcYVJIa0LYxvLUxoZWXZ5ejBbuDE9LJ2cZ00oyWuQdz9AQamkQ+cj0eSkWTIGSQWjpKhb7wRJ/334FfN92M2qIU6oBR58wINOtUVk0KK7iOvn8T03HbXN+aeCXBHi0diaMO6SBSAr4zMfbrqVeY+taync8Wgm6XnPMZHk7EFAiA3oa9YkntbCQMZ+mohgCjWmST2UXQbgHCqSdkpU1C70jV4Rl1BIrKDrk8/lGTfFtNFH8JpEUScQTUuf87OIqJgcGxu9JfuMyhj1BYnbLaD0unIuAVlY2Sh4WYVZcLU/e2bM1ZmP9oZX5H9pvZ1Em/TqB98oXT7kzcxCCP77dFbB2WR2loav
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(316002)(4326008)(66556008)(86362001)(66946007)(66476007)(6506007)(6512007)(186003)(26005)(83380400001)(2616005)(2906002)(6486002)(6666004)(66899021)(41300700001)(38100700002)(8936002)(478600001)(7416002)(7406005)(5660300002)(110136005)(54906003)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10273
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7207327c-7d8e-4e44-aa02-08db7e220236
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: apiAj79P06uU2R/k9j/ZwAYmofcTso0XdNL4av8Bs5383l3HPhV/F+oJA9SzAwf6aVkjxAEa8XchVe61EJcX20qjV2ZljTxPda4NqdeZ9G6wWg0zrGjUikUAJUsVcQsKwWdQWEo/xpNyag9XhLMeXb/tbz/G3xhLtguK3YpPN+OHqXjM00rVW1+ncZyJ5Uvx+T6ItDFT9RWpTorYTB+guCDpHlQ1AAobsFOiOcW34FkrctrRywTZhB2tHxTEj3TSOj9ZRlZ9/utfKHpFzprVSiXDXYepFOYyXqh0q2Y+74KRroQqLi+OZFxPYpdlGNjkJMPdJfDE4rQ/6d3FBNC9Z+zzjsYrkW2PTlx9HSzWk5ANFGYPCDarEsmktY7OLND8+VnM28AKN78q3HT2BXyTT1QM24jGv42nw/Lpc+vqWLoopQmSBHjUbYRsbSu2/15l4knVeP/Q2DRam4phn97kUFhhnugP0HHtqc2pPgbFtxD0ms6+qXbSz+1oUW56XOh923qsaq75eiW9tnaNAZ65znsUZ0UKpARU140qnYhmxgwZ2FwDNpQzsjQ6zPYzDvE2yEijQfArNoTOoFZQmGg0GGZO5bn5XWZZKMMU+ozR4YsTaXWGkdFjrZQGvV0PocTJwQZIN+ouZYMUW5eufnXUHeK9fCLGEugztf5UmYc+HUSFKu9u6/yIuzS/CZFN9ZF2y2Vq2NANBj8XBlO5GFHjFFKHe5A3o7E/enCvFyS0MjpPICBNcaeoWOoK7Cf5pdYa
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(478600001)(6486002)(6666004)(70206006)(450100002)(110136005)(54906003)(70586007)(26005)(336012)(186003)(107886003)(6506007)(2906002)(82310400005)(6512007)(41300700001)(316002)(8936002)(8676002)(5660300002)(4326008)(81166007)(356005)(82740400003)(36756003)(86362001)(40460700003)(83380400001)(47076005)(2616005)(40480700001)(66899021);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:08:11.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ac36ce-fb9f-4df9-604f-08db7e220ce8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9016
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/05/2023 18:45, Edgecombe, Rick P wrote:
> On Mon, 2023-07-03 at 19:19 +0100, szabolcs.nagy@arm.com wrote:
> > Could you spell out what "the issue" is that can be triggered?
> > 
> > i meant jumping back from the main to the alt stack:
> > 
> > in main:
> > setup sig alt stack
> > setjmp buf1
> >         raise signal on first return
> >         longjmp buf2 on second return
> > 
> > in signal handler:
> > setjmp buf2
> >         longjmp buf1 on first return
> >         can continue after second return
> > 
> > in my reading of posix this is valid (and works if signals are masked
> > such that the alt stack is not clobbered when jumping away from it).
> > 
> > but cannot work with a single shared shadow stack.
> 
> Ah, I see. To make this work seamlessly, you would need to have
> automatic alt shadow stacks, and as we previously discussed this is not
> possible with the existing sigaltstack API. (Or at least it seemed like
> a closed discussion to me).
> 
> If there is a solution, then we are currently missing a detailed
> proposal. It looks like further down you proposed leaking alt shadow
> stacks (quoted up here near the related discussion):
> 
> On Mon, 2023-07-03 at 19:19 +0100, szabolcs.nagy@arm.com wrote:
> > maybe not in glibc, but a libc can internally use alt shadow stack
> > in sigaltstack instead of exposing a separate sigaltshadowstack api.
> > (this is what a strict posix conform implementation has to do to
> > support shadow stacks), leaking shadow stacks is not a correctness
> > issue unless it prevents the program working (the shadow stack for
> > the main thread likely wastes more memory than all the alt stack
> > leaks. if the leaks become dominant in a thread the sigaltstack
> > libc api can just fail).
> 
> It seems like your priority must be to make sure pure C apps don't have
> to make any changes in order to not crash with shadow stack enabled.
> And this at the expense of any performance and memory usage. Do you
> have some formalized priorities or design philosophy you can share?
> 
> Earlier you suggested glibc should create new interfaces to handle
> makecontext() (makes sense). Shouldn't the same thing happen here? In
> which case we are in code-changes territory and we should ask ourselves
> what apps really need.

instead of priority, i'd say "posix conform c apps work
without change" is a benchmark i use to see if the design
is sound.

i do not have a particular workload (or distro) in mind, so
i have to reason through the cases that make sense and the
current linux syscall abi allows, but fail or difficult to
support with shadow stacks.

one such case is jumping back to an alt stack (i.e. inactive
live alt stack):

- with shared shadow stack this does not work in many cases.

- with alt shadow stack this extends the lifetime beyond the
  point it become inactive (so it cannot be freed).

if there are no inactive live alt stacks then *both* shared
and implicit alt shadow stack works. and to me it looked
like implicit alt shadow stack is simply better of those two
(more alt shadow stack use-cases are supported, shadow stack
overflow can be handled. drawback: complications due to the
discontinous shadow stack.)

on arm64 i personally don't like the idea of "deal with alt
shadow stack later" because it likely requires a v2 abi
affecting the unwinder and jump implementations. (later
extensions are fine if they are bw compat and discoverable)

one nasty case is shadow stack overflow handling, but i
think i have a solution for that (not the nicest thing:
it involves setting the top bit on the last entry on the
shadow stack instead of adding a new entry to it. + a new
syscall that can switch to this entry. i havent convinced
myself about this yet).

> 
> > 
> > > >   we
> > > >   can ignore that corner case and adjust the model so the shared
> > > >   shadow stack works for alt stack, but it likely does not change
> > > > the
> > > >   jump design: eventually we want alt shadow stack.)
> > > 
> > > As we discussed previously, alt shadow stack can't work
> > > transparently
> > > with existing code due to the sigaltstack API. I wonder if maybe
> > > you
> > > are trying to get at something else, and I'm not following.
> > 
> > i would like a jump design that works with alt shadow stack.
> 
> A shadow stack switch could happen based on the following scenarios:
>  1. Alt shadow stack
>  2. ucontext
>  3. custom stack switching logic
> 
> If we leave a token on signal, then 1 and 2 could be guaranteed to have
> a token *somewhere* above where setjmp() could have been called.
> 
> The algorithm could be to search from the target SSP up the stack until
> it finds a token, and then switch to it and INCSSP back to the SSP of
> the setjmp() point. This is what we are talking about, right?
> 
> And the two problems are:
>  - Alt shadow stack overflow problem
>  - In the case of (3) there might not be a token
> 
> Let's ignore these problems for a second - now we have a solution that
> allows you to longjmp() back from an alt stack or ucontext stack. Or at
> least it works functionally. But is it going to actually work for
> people who are using longjmp() for things that are supposed to be fast?

slow longjmp is bad. (well longjmp is actually always slow
in glibc because it sets the signalmask with a syscall, but
there are other jump operations that don't do this and want
to be fast so yes we want fast jump to be possible).

jumping up the shadow stack is at least linear time in the
number of frames jumped over (which already sounds significant
slowdown however this is amortized by the fact that the stack
frames had to be created at some point and that is actually a
lot more expensive because it involves write operations, so a
zero cost jump will not do any asymptotic speedup compared to
a linear cost jump as far as i can see.).

with my proposed solution the jump is still linear. (i know
x86 incssp can jump many entries at a time and does not have
to actually read and check the entries, but technically it's
linear time too: you have to do at least one read per page to
have the guardpage protection). this all looks fine to me
even for extreme made up workloads.

> Like, is this the tradeoff people want? I see some references to fiber
> switching implementations using longjmp(). I wonder if the existing
> INCSSP loops are not going to be ideal for every usage already, and
> this sounds like going further down that road.
> 
> For jumping out occasionally in some error case, it seems it would be
> useful. But I think we are then talking about targeting a subset of
> people using these stack switching patterns.
> 

i simply don't see any trade-off here (i expect no measurable
difference with a scanning vs no scanning approach even in
a microbenchmark that does longjmp in a loop independently of
the stack switch pattern and even if the non-scanning
implementation can do wrss).

> Looking at the docs Mark linked (thanks!), ARM has generic GCS PUSH and
> POP shadow stack instructions? Can ARM just push a restore token at
> setjmp time, like I was trying to figure out earlier with a push token
> arch_prctl? It would be good to understand how ARM is going to
> implement this with these differences in what is allowed by the HW.
> 
> If there are differences in how locked down/functional the hardware
> implementations are, and if we want to have some unified set of rules
> for apps, there will need to some give and take. The x86 approach was
> mostly to not support all behaviors and ask apps to either change or
> not enable shadow stacks. We don't want one architecture to have to do
> a bunch of strange things, but we also don't want one to lose some key
> end user value.
> 
> I'm thinking that for pure tracing users, glibc might do things a lot
> differently (use of WRSS to speed things up). So I'm guessing we will
> end up with at least one more "policy" on the x86 side.
> 
> I wonder if maybe we should have something like a "max compatibility"
> policy/mode where arm/x86/riscv could all behave the same from the
> glibc caller perspective. We could add kernel help to achieve this for
> any implementation that is more locked down. And maybe that is x86's v2
> ABI. I don't know, just sort of thinking out loud at this point. And
> this sort of gets back to the point I keep making: if we need to decide
> tradeoffs, it would be great to get some users to start using this and
> start telling us what they want. Are people caring mostly about
> security, compatibility or performance?
> 
> [snip]
> 
