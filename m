Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829326A6E4D
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 15:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCAOXW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 09:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCAOXH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 09:23:07 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6113CE07;
        Wed,  1 Mar 2023 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sL7BLHhA94t0p3OtewZZpQ9Cnw7zEmxa9mz2Z8zTHY=;
 b=iRxaQLqvvH8nfaYC4r0Brxf5Wn+RID9AMNF743W5rSl5B1S3wPsnGxX2MEiTmjL9Yn8R7uXEWL7axFaVq23rLSrMSUPIbW7bEJhasgYpKuUwblNBNNRvuKsgGF3xkr15lZxt/tJ8v/rmyeiWfoEgj+V/ruF3/IjKGfrYn9sfhcw=
Received: from AS9PR06CA0343.eurprd06.prod.outlook.com (2603:10a6:20b:466::26)
 by AM8PR08MB6612.eurprd08.prod.outlook.com (2603:10a6:20b:368::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 14:22:29 +0000
Received: from AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::9d) by AS9PR06CA0343.outlook.office365.com
 (2603:10a6:20b:466::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 14:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT039.mail.protection.outlook.com (100.127.140.224) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.18 via Frontend Transport; Wed, 1 Mar 2023 14:22:28 +0000
Received: ("Tessian outbound 0df938784972:v135"); Wed, 01 Mar 2023 14:22:27 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3b74164fc6e3c085
X-CR-MTA-TID: 64aa7808
Received: from 002a1e3e30ec.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3E4CC9FA-8521-40D4-BED7-F09C69BA903D.1;
        Wed, 01 Mar 2023 14:22:19 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 002a1e3e30ec.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 01 Mar 2023 14:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzGhG+SNQxEWzcU7xmOd+DKphMJ0/8Q7qq3VIaTjOWz/XyGR20KHO769mg0WYW1nRXmr7V8iGJ8CyJ+RgtTBC0PajxlWL4fKi3zUYu1rGw6lLhHOBBIlvWyJd5E23ZQwtgDh1bb1EX7W1/TklA3t+EmRaQKPxEeWJHVaztpnfsxPhC38KCf4Frrj5IM9iojidWp7BUf7b20CbK1vKlRFyyDuBW4277I6s6Pc2JqFiWEMFPmmjhPkPZrBK3B467FsrbLtyb/+y9H5sYh61Yyv45wNn7sMph62YoawTWrktrNl2/iinVLl8f+6RnmbQF1c2JsnPvfwigbkSisc6Kk1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sL7BLHhA94t0p3OtewZZpQ9Cnw7zEmxa9mz2Z8zTHY=;
 b=YOAmt5InV3lV9UFsjt0AkGAt87piumbG2EDi1H16mPwketXMAuOLV2xwGaFSnMYJTNuuwVG2JivnvO07ifYq2Yy7m0ocz7OFgDEnRTgcH5i4Gzk3bZz+r4ESlStb+ctcj2CGBRSu8XvTllpsvTCCnHLFMlCuvoiePxam/N64MjSGkad0IVtNdj39KVrdV7QFgzfb5L1iFdfHmM0pl4W1ik7rLBCLM9P371aN0J83L97tx89FknyoHfrNiPTZhzB4JEUGh4edm+ArhO5HLKbISKxeiVAXyfmfRD1McUzGN6cJJS/8DQOmUj2Ml14vPdmzC2eKEmUwExDNzzQW5GRv5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sL7BLHhA94t0p3OtewZZpQ9Cnw7zEmxa9mz2Z8zTHY=;
 b=iRxaQLqvvH8nfaYC4r0Brxf5Wn+RID9AMNF743W5rSl5B1S3wPsnGxX2MEiTmjL9Yn8R7uXEWL7axFaVq23rLSrMSUPIbW7bEJhasgYpKuUwblNBNNRvuKsgGF3xkr15lZxt/tJ8v/rmyeiWfoEgj+V/ruF3/IjKGfrYn9sfhcw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by GVXPR08MB7751.eurprd08.prod.outlook.com (2603:10a6:150:7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 14:22:11 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Wed, 1 Mar 2023
 14:22:10 +0000
Date:   Wed, 1 Mar 2023 14:21:41 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com,
        Mark Brown <broonie@kernel.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <Y/9fdYQ8Cd0GI+8C@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-2-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: SA9PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:806:20::6) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|GVXPR08MB7751:EE_|AM7EUR03FT039:EE_|AM8PR08MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: a27af4c6-a14a-4e62-552b-08db1a6062ed
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Rrrr7dLoMXYf5d3THoS+a7jmRGfAOpcqMBAktAgzJwF6Ymd6ZZOLrfOpeNsJ4fUSyDqAzGy43O8FzZRSiVq1YkCue3Tr285BwpURq5ixp8ZzGvYMtrcEr0iYVk5TPubWMHZ3joSXDYnEZvd6PKBZkXE2vVr/ijJGfkyHD6HDjR7zktvQEZ1ogHbKZiiUP/ZjH/sJ8XnYdu8/xp1J/1V0Kzk0HIPyu24drIkYpJcw7+jYDQty9nKx3+yDTSxhiiwNSJk0FLnqANdSURHxs6YhPD5t6I/2ww10EA1bjyByGggWxOzJHq0nKtoKQjJoK8BYr6yeT13RDpAWppn8Rv6aYSw+2/EwqFvo5ANQ04xbzfs6srWXp8NKKMStZkcLqNC5Dr525lfTVQ7hscqkoU8QICU/ESVvcEDP7alGlDK4OU1nrKhKuVvnkFwLbLdV4f6tCx4FQy5XE2xqlq+6PNV3P995tVX7quMFbwu1xv9Uf/3CZKd5ry4smEdEHk3BCbM6xQwUocjWN0BWiJaZ1u/0R+SffTLvgFrq5rhXmXpltWgVl5FZbHFC9BpG762mufgnI1LAktbD9dpPQu4XansDWQPmhSRUI9BeQBAKZt0GXNnOOu9/4zmPT3mt2xP2LQ+8fCJR48huQLbfbawPBqXWybUiHHLOpfpwIp/EGi3XTwOLnZq6nd5qXxfVZOobBGd5
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199018)(36756003)(110136005)(83380400001)(316002)(478600001)(6486002)(2616005)(186003)(6506007)(26005)(6666004)(8936002)(921005)(41300700001)(86362001)(2906002)(7416002)(7406005)(5660300002)(6512007)(66556008)(66946007)(44832011)(8676002)(38100700002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7751
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a112cec5-9479-49a4-96da-08db1a60578b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqJ3+PaqGbHhasNSkIbePufBNILHKIuaTsvv89qFpFnqzk2EgXEIrz1vj6ye5YCveuzMi+5Zxexz22dFcQhfiT0qN15f2L9r5K43rirte25d/mv5qMFHLFw0cWw15bk2/VY7REVv+iWZqsEDUKcW/hpErScxHSSln1S9TVi4k7LNQGj3pHkg27S/IsNZfN5AiuWzJePehORNkmXaX10rfbImpiia/l8uvjBfUB7EQnssKs24/d7ss2JxWPvhvwLRJtCQGL34MnsyVEkhjjQW1f1J//KPIJlORaZKcSMM84XP2S3daQIU5CnbuAqibxepkIKWLdHyuhroR12klyq7JGC5YS6oOvwgw8BIKbtN2cwIh4gKtMcckOnRHcbpOBIISHlizU7/PzM/NW9Bv+32jPKinmObwyilJQ6VbxvwE+Vup1yU/fH7TIOPPwVmI5KBTi0jRgw3KYQ083/wiKktbIWEBKPQ1ZD1J5KHsNHM/h7uTAf4geGmCDOlrf2X3J0TS0LLEmFq28AKT/RF18zBuavOmqDcwGjt2gDGMKBa6uy6uAUZkKaEh5+LpXDb1Zv0Jr3DqYHqfoHkAv82kPok252ip7CJ8yUKtrMK9p3xN4x5/3pnAGY5cqhYmMIXxLRWMcrPxgXxmT0GBEat/X2HCJIo36VqBRRM/IF+oFpb/kh41n1l3mIxXMFoePlXyzxEktPd1q742N8ddLA9z73fm4QRQdUUZBSTqBvhLx/4zPY=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(110136005)(82310400005)(2616005)(2906002)(336012)(316002)(47076005)(186003)(44832011)(8936002)(26005)(6512007)(36860700001)(6486002)(36756003)(81166007)(86362001)(107886003)(5660300002)(82740400003)(40460700003)(478600001)(41300700001)(356005)(921005)(6666004)(70206006)(450100002)(40480700001)(6506007)(8676002)(70586007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 14:22:28.0867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a27af4c6-a14a-4e62-552b-08db1a6062ed
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6612
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 02/27/2023 14:29, Rick Edgecombe wrote:
> +Application Enabling
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +An application's CET capability is marked in its ELF note and can be ver=
ified
> +from readelf/llvm-readelf output::
> +
> +    readelf -n <application> | grep -a SHSTK
> +        properties: x86 feature: SHSTK
> +
> +The kernel does not process these applications markers directly. Applica=
tions
> +or loaders must enable CET features using the interface described in sec=
tion 4.
> +Typically this would be done in dynamic loader or static runtime objects=
, as is
> +the case in GLIBC.

Note that this has to be an early decision in libc (ld.so or static
exe start code), which will be difficult to hook into system wide
security policy settings. (e.g. to force shstk on marked binaries.)

From userspace POV I'd prefer if a static exe did not have to parse
its own ELF notes (i.e. kernel enabled shstk based on the marking).
But I realize if there is a need for complex shstk enable/disable
decision that is better in userspace and if the kernel decision can
be overridden then it might as well all be in userspace.

> +Enabling arch_prctl()'s
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Elf features should be enabled by the loader using the below arch_prctl'=
s. They
> +are only supported in 64 bit user applications.
> +
> +arch_prctl(ARCH_SHSTK_ENABLE, unsigned long feature)
> +    Enable a single feature specified in 'feature'. Can only operate on
> +    one feature at a time.
> +
> +arch_prctl(ARCH_SHSTK_DISABLE, unsigned long feature)
> +    Disable a single feature specified in 'feature'. Can only operate on
> +    one feature at a time.
> +
> +arch_prctl(ARCH_SHSTK_LOCK, unsigned long features)
> +    Lock in features at their current enabled or disabled status. 'featu=
res'
> +    is a mask of all features to lock. All bits set are processed, unset=
 bits
> +    are ignored. The mask is ORed with the existing value. So any featur=
e bits
> +    set here cannot be enabled or disabled afterwards.

The multi-thread behaviour should be documented here: Only the
current thread is affected. So an application can only change the
setting while single-threaded which is only guaranteed before any
user code is executed. Later using the prctl is complicated and
most c runtimes would not want to do that (async signalling all
threads and prctl from the handler).

In particular these interfaces are not suitable to turn shstk off
at dlopen time when an unmarked binary is loaded. Or any other
late shstk policy change will not work, so as far as i can see
the "permissive" mode in glibc does not work.

Does the main thread have shadow stack allocated before shstk is
enabled? is the shadow stack freed when it is disabled? (e.g.
what would the instruction reading the SSP do in disabled state?)

> +Proc Status
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +To check if an application is actually running with shadow stack, the
> +user can read the /proc/$PID/status. It will report "wrss" or "shstk"
> +depending on what is enabled. The lines look like this::
> +
> +    x86_Thread_features: shstk wrss
> +    x86_Thread_features_locked: shstk wrss

Presumaly /proc/$TID/status and /proc/$PID/task/$TID/status also
shows the setting and only valid for the specific thread (not the
entire process). So i would note that this for one thread only.

> +Implementation of the Shadow Stack
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Shadow Stack Size
> +-----------------
> +
> +A task's shadow stack is allocated from memory to a fixed size of
> +MIN(RLIMIT_STACK, 4 GB). In other words, the shadow stack is allocated t=
o
> +the maximum size of the normal stack, but capped to 4 GB. However,
> +a compat-mode application's address space is smaller, each of its thread=
's
> +shadow stack size is MIN(1/4 RLIMIT_STACK, 4 GB).

This policy tries to handle all threads with the same shadow stack
size logic, which has limitations. I think it should be improved
(otherwise some applications will have to turn shstk off):

- RLIMIT_STACK is not an upper bound for the main thread stack size
  (rlimit can increase/decrease dynamically).
- RLIMIT_STACK only applies to the main thread, so it is not an upper
  bound for non-main thread stacks.
- i.e. stack size >> startup RLIMIT_STACK is possible and then shadow
  stack can overflow.
- stack size << startup RLIMIT_STACK is also possible and then VA
  space is wasted (can lead to OOM with strict memory overcommit).
- clone3 tells the kernel the thread stack size so that should be
  used instead of RLIMIT_STACK. (clone does not though.)
- I think it's better to have a new limit specifically for shadow
  stack size (which by default can be RLIMIT_STACK) so userspace
  can adjust it if needed (another reason is that stack size is
  not always a good indicator of max call depth).

> +Signal
> +------
> +
> +By default, the main program and its signal handlers use the same shadow
> +stack. Because the shadow stack stores only return addresses, a large
> +shadow stack covers the condition that both the program stack and the
> +signal alternate stack run out.

What does "by default" mean here? Is there a case when the signal handler
is not entered with SSP set to the handling thread'd shadow stack?

> +When a signal happens, the old pre-signal state is pushed on the stack. =
When
> +shadow stack is enabled, the shadow stack specific state is pushed onto =
the
> +shadow stack. Today this is only the old SSP (shadow stack pointer), pus=
hed
> +in a special format with bit 63 set. On sigreturn this old SSP token is
> +verified and restored by the kernel. The kernel will also push the norma=
l
> +restorer address to the shadow stack to help userspace avoid a shadow st=
ack
> +violation on the sigreturn path that goes through the restorer.

The kernel pushes on the shadow stack on signal entry so shadow stack
overflow cannot be handled. Please document this as non-recoverable
failure.

I think it can be made recoverable if signals with alternate stack run
on a different shadow stack. And the top of the thread shadow stack is
just corrupted instead of pushed in the overflow case. Then longjmp out
can be made to work (common in stack overflow handling cases), and
reliable crash report from the signal handler works (also common).

Does SSP get stored into the sigcontext struct somewhere?

> +Fork
> +----
> +
> +The shadow stack's vma has VM_SHADOW_STACK flag set; its PTEs are requir=
ed
> +to be read-only and dirty. When a shadow stack PTE is not RO and dirty, =
a
> +shadow access triggers a page fault with the shadow stack access bit set
> +in the page fault error code.
> +
> +When a task forks a child, its shadow stack PTEs are copied and both the
> +parent's and the child's shadow stack PTEs are cleared of the dirty bit.
> +Upon the next shadow stack access, the resulting shadow stack page fault
> +is handled by page copy/re-use.
> +
> +When a pthread child is created, the kernel allocates a new shadow stack
> +for the new thread. New shadow stack's behave like mmap() with respect t=
o
> +ASLR behavior.

Please document the shadow stack lifetimes here:

I think thread exit unmaps shadow stack and vfork shares shadow stack
with parent so exit does not unmap.

I think the map_shadow_stack syscall should be mentioned in this
document too.

ABI for initial shadow stack entries:

If one wants to scan the shadow stack how to detect the end (e.g. fast
backtrace)? Is it useful to put an invalid value (-1) there?
(affects map_shadow_stack syscall too).

thanks.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
