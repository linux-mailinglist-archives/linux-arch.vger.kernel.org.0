Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B72A73BC7F
	for <lists+linux-arch@lfdr.de>; Fri, 23 Jun 2023 18:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjFWQZl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Jun 2023 12:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjFWQZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Jun 2023 12:25:40 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77BC18B;
        Fri, 23 Jun 2023 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/DlcP6NFNh/v3X34McLagCs6euDIA5WhLlrq2giJUI=;
 b=q5WJWZJVz+RWu2HWspSuO/x/YJev8GQMp2HGU4Z/P9iBlmOoeMR9Zx7OZz2uNolHbu4UI8rZRUlRYVG3qL3ii8beJpNJoTqHiFGuCK3r7VC0xxyae105QO7XJyttOzTATOv2ugMpm2qTpeMbRFvLQI5oxvN1pUOnRq9HRayOpL8=
Received: from AS8PR04CA0158.eurprd04.prod.outlook.com (2603:10a6:20b:331::13)
 by GV1PR08MB8497.eurprd08.prod.outlook.com (2603:10a6:150:81::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 16:25:29 +0000
Received: from AM7EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:331:cafe::36) by AS8PR04CA0158.outlook.office365.com
 (2603:10a6:20b:331::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 16:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT055.mail.protection.outlook.com (100.127.141.28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Fri, 23 Jun 2023 16:25:29 +0000
Received: ("Tessian outbound 546d04a74417:v142"); Fri, 23 Jun 2023 16:25:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 988967d30cb6f782
X-CR-MTA-TID: 64aa7808
Received: from a28f41af7f1c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 73587C64-D6D2-4FDE-BF67-51ABBAC1CF8C.1;
        Fri, 23 Jun 2023 16:25:22 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a28f41af7f1c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 23 Jun 2023 16:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSSx+bBmm6VDl2OlIqPEgblGxSh/9RrElryjuSRiGZMnmmgKuNKStak0X/Nr3shFZyq75GlsQTTgEQBXd2ZxoQX6IGTMrOZd23Bod4XlDXV3NbqDgLKgshwwxiyh5I2F5qiVGk132UogI0l1hL1A1sdsqXF3/Vf7Ad0jly8UmbG+8tgM5yCKtbbWS/w1yUa+3cIDMQ8fTE/Zfm6yB9XndjqZHuoO7jnlGKEQMElYu7X7eKwRBCulmTmC53Dgh7yYcR7TO+unriCx8qfGSwFGikDoLU27LBu65vuSftPMSULaADB2O0m00xO9uVjo3NojaF9eGE9CSAlTj3M1MEwKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/DlcP6NFNh/v3X34McLagCs6euDIA5WhLlrq2giJUI=;
 b=cOifoYhZSyHBF6NAECM5n0/4QOVDrJNsCmjwHlY4phxlHKfin3AVo7Z2PMHGGDV0eXDduBHO8BG4JECqZ6ok29RNfYOGHhgIqo9/EJa4BOE51wnkD9sTLbeavpqe/hp6gnP/M7XdsvhBP+hSTXRiu2RQnvastD2/OBo0ueeOMysjnT9eMFQkqGlul/xoRFoV78u0wEKufW/VkACQ1ziQEJ088/QzIObAAvtxlgGhNnhI2vsMPWSywf44ZkUVgZnquE8aA/AhtC0i6nFLAdmXcRkz2YvxmVqujspbAKr66+zZ/KmKWivA+X+UfCa51XJqD80s9lusoa//3OkSZuh0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/DlcP6NFNh/v3X34McLagCs6euDIA5WhLlrq2giJUI=;
 b=q5WJWZJVz+RWu2HWspSuO/x/YJev8GQMp2HGU4Z/P9iBlmOoeMR9Zx7OZz2uNolHbu4UI8rZRUlRYVG3qL3ii8beJpNJoTqHiFGuCK3r7VC0xxyae105QO7XJyttOzTATOv2ugMpm2qTpeMbRFvLQI5oxvN1pUOnRq9HRayOpL8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 16:25:18 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 16:25:18 +0000
Date:   Fri, 23 Jun 2023 17:25:03 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
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
Message-ID: <ZJXHX0rmj/fMKagR@arm.com>
References: <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <5ae619e03ab5bd3189e606e844648f66bfc03b8f.camel@intel.com>
 <ZJQF636p80oywgqZ@arm.com>
 <46a5ffc762bfd6ccb60c9568b7fb564d40c04c45.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46a5ffc762bfd6ccb60c9568b7fb564d40c04c45.camel@intel.com>
X-ClientProxiedBy: LO4P265CA0278.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::19) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|VE1PR08MB5630:EE_|AM7EUR03FT055:EE_|GV1PR08MB8497:EE_
X-MS-Office365-Filtering-Correlation-Id: fe5f0109-2e30-4309-f757-08db7406758a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 34lEmS4C+mqFf6r4UUeCWp5i/6n4YPPeeohayU648GYv3ZhlMAL0/H7yrYNqmLZCwQ2y3qRQ+s+kdFD0gAkPO0qkFEdnC5zPqZlq2weLFVRD+BKlrmfe30azzWSBN8Z8m+sQJ5S1HatPT81rbcqFwRwXEc391I4O2vO6CIl5/uKunpNBesT/kUToyIXnbE7WpPBbtw4cnRd6jXKqQcQeU7wsKlogrECtHuBeyQCKHzpLcJUmpVkX3c4Yucp4LJUq3167ClRjbBbZ6UX/9aYnrsy2A+rk2bmty67UMoucI3bqYJ4PqfB9e+jQ/l/UmieGNtTYpK5fu2W6Z46aKa3RtiyGg8LBz9n4MiXe6iBDQRcMWn3pcp7XOF79mjwj9JVu8vjxTP99MRduGroqMYz4iu5Jz7fF4bs5kqTmrfTBLJlDSicBzwwxNVCYPhKNocHz23WxTySwj7UqeYXqPAaal7fFBpVTayPnyXLUZ9nhkGxM792VpdIZogbudjSf+nG+GHHiihNPnGBvZIAGwdjuOCDRHhiuseF14oUav3uqrFx8gljqyJqIiyQKNVb9Ou0m
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(4326008)(110136005)(54906003)(38100700002)(86362001)(66946007)(66556008)(66476007)(478600001)(316002)(6666004)(83380400001)(6486002)(2616005)(8676002)(7416002)(7406005)(2906002)(8936002)(41300700001)(36756003)(186003)(26005)(5660300002)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5630
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cb23ab79-aa63-44d9-fc5b-08db74066e90
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yrp6GuDF/oL7F9Ncoii+C7u0tWzyqPLDMRI+kAQ8b56BzndKCHqq7X4kEOfz7kPj5071KtDDLAqaSIySIFeLH+rFhsxFRPbUBxmiUndI/QFKX8DHSlleLDsLW8LtWO3Oq2lAp6uflH66W8+JUsNNhVZPWyZufoyghbauyiugsUaTiuX915Jlru/AHuRw1lApUGbhziedCBL9oHB9ET3HEPAOq8gDPd8+xwR0BQIOkrHXnS2f3ImNF47ESCReWXM+SiUXoawsyRuRXcgPfcbbc8NEcevTE8dnDAcQ3nZVDf4erLQXfgabJ6X6dMImU4Z9vuCw8QZklhIRy3wFVdirbwYtiftjp+yALU3j3lZ8wIlo8LA26i4XSRGgtWFkc0ZHAYNQwGgHCSny41oD+BUFuUng6/gVz46Y194A8s927RTrCJjRkJ6HR7MVL2MLo+x4cDun/E8DXBOja6MaC3fDz4ceJCwoSyZWpLxWdNRhEat9HH5imem2gY4cmb+SCq9GC0xHpRQA2gfzLuKE1zygxajQ6+X0ETcaz5p1UlUrw0dcvkCoHW09ov5cPVq6MfX9xqlhX8m06kzo+JOzGQuWNGm5IdafuCaAz5Ctz2RsEyrgLMyd0BBEmbY6uAonWbJ3XqZv2HL7FOkymrQ0fccNPnKIHqEum1aQJRFxmIwmcPugKrUkawVmlTymyP35XaR59v3kyJpR5FbiPLUQuSjbGibDjgfBgzfzQQHW4AMYtctYK/Qe0hfrz+RyxUZBQK27
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(336012)(316002)(83380400001)(8676002)(8936002)(41300700001)(47076005)(2616005)(186003)(82740400003)(356005)(81166007)(36860700001)(6506007)(6512007)(26005)(40460700003)(6486002)(6666004)(54906003)(110136005)(40480700001)(478600001)(107886003)(450100002)(36756003)(86362001)(4326008)(70586007)(70206006)(2906002)(82310400005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 16:25:29.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5f0109-2e30-4309-f757-08db7406758a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8497
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/22/2023 16:47, Edgecombe, Rick P wrote:
> On Thu, 2023-06-22 at 09:27 +0100, szabolcs.nagy@arm.com wrote:
> 
> 
> [ snip ]
> 
> > swapcontext is currently *not* supported: for it to work you have to
> > be able to jump *back* into the signal handler, which does not work
> > if
> > the swapcontext target is on the original thread stack (instead of
> > say a makecontext stack).
> > 
> > jumping back can only be supported if alt stack can be paired with
> > an alt shadow stack.
> > 
> > unwinding across a series of signal interrupts should work even
> > with discontinous shstk. libgcc does not implement this which is
> > a problem i think.
> 
> I would be helpful if you could enumerate the cases you think are
> important to support. I would like to see how we could support them in
> the future in some mode.
> 
> > 
> > > But how does the proposed token placed by the kernel on the
> > > original
> > > stack help this problem? The longjmp() would have to be able to
> > > find
> > > the location of the restore tokens somehow, which would not
> > > necessarily
> > > be near the setjmp() point. The signal token could even be on a
> > > different shadow stack.
> > 
> > i posted the exact longjmp code and it takes care of this case.
> 
> I see how it works for the simple case of longjmp() from an alt shadow
> stack. I would still prefer a different solution that works with the
> overflow case. (probably new kernel functionality)
> 
> But I don't see how it works for unwinding off of a ucontext stack. Or
> unwinding off of an ucontext stack that was swapped to from an alt
> shadow stack.

why?

a stack can be active or inactive (task executing on it or not),
and if inactive it can be live or dead (has stack frames that can
be jumped to or not).

this is independent of shadow stacks: longjmp is only valid if the
target is either the same active stack or an inactive live stack.
(there are cases that may seem to work, but fundamentally broken
and not supportable: e.g. two tasks executing on the same stack
where the one above happens to not clobber frames deep enough to
collide with the task below.)

the proposed longjmp design works for both cases. no assumption is
made about ucontext or signals other than the shadow stack for an
inactive live stack ends in a restore token, which is guaranteed by
the isa so we only need the kernel to do the same when it switches
shadow stacks. then longjmp works by construction.

the only wart is that an overflowed shadow stack is inactive dead
instead of inactive live because the token cannot be added. (note
that handling shstk overflow and avoiding shstk overflow during
signal handling still works with alt shstk!)

an alternative solution is to allow jump to inactive dead stack
if that's created by a signal interrupt. for that a syscall is
needed and longjmp has to detect if the target stack is dead or
live. (the kernel also has to be able to tell if switching to the
dead stack is valid for security reasons.) i don't know if this
is doable (if we allow some hacks it's doable).

unwinding across signal handlers is just a matter of having
enough information at the signal frame to continue, it does
not have to follow crazy jumps or weird coroutine things:
that does not work without shadow stacks either. but unwind
across alt stack frame should work.
