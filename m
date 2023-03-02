Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30306A85F3
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 17:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCBQP6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 11:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCBQP5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 11:15:57 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2052.outbound.protection.outlook.com [40.107.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4D43933;
        Thu,  2 Mar 2023 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA9YAlRCVAd4jYmxRufFFwoXSulswkAHdmGR06WQVRU=;
 b=DDHj6tArna11e/2DTaXWkEMlhyf5uMwsagsCIe1KGBMgf00Mm2ctgZtOy+fIc8IlH/0mQqd/r+542RciqXiP9yiTNXLjVQ7W3WbKBDxYQBxIEA8zQkSqIwx/Vk6pkUmSZcVnrf10nT0A5FWIhIJgHFIlYDRoJmH5KMe/wGRsFMU=
Received: from DUZPR01CA0257.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::29) by AS4PR08MB7759.eurprd08.prod.outlook.com
 (2603:10a6:20b:516::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 16:15:10 +0000
Received: from DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4b5:cafe::dc) by DUZPR01CA0257.outlook.office365.com
 (2603:10a6:10:4b5::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 16:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT058.mail.protection.outlook.com (100.127.142.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.19 via Frontend Transport; Thu, 2 Mar 2023 16:15:10 +0000
Received: ("Tessian outbound f2a8d6d66d12:v135"); Thu, 02 Mar 2023 16:15:10 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d0e4b46c10843a17
X-CR-MTA-TID: 64aa7808
Received: from b9fe3212f9da.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 05B64559-4BEC-4E5F-A4C1-F773C751F0E0.1;
        Thu, 02 Mar 2023 16:15:03 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b9fe3212f9da.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Mar 2023 16:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/W6S5TSz0vdeGJDEUejXUab12iwuwnIAuXzOqq5RrI4M+pPjbyCGhsiAw+PRBa9K7pNVERwhLR4m4zkmvc19eepfqWGjo7p51D42lt7BlDZhEX2iz5JIrBjaoS2SXOEjcTKT9x6R5l2Mmw3BLLW8eF5uBKolWtl9KdCSrKbPcmG6pYOP8wGF5ANg+kQaQ+mHAfUGW/G8KDGD1bkYi4gmv/I+LpPOJW1jjHujdO1D7d2dZ1F5OfQTLfz63zT0iarGZfAy5Ky/obz/I5hNW3pFoU8U7xwJX/RV/7xIz9BLIKDathaThatd97dUfUArHjocwz3K81mEtPkXulHMTLcVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rA9YAlRCVAd4jYmxRufFFwoXSulswkAHdmGR06WQVRU=;
 b=kUzpGMl7vO89f9/J5CSfhDwXb8joyitqanPkFt0uBggGTdyDmo4LpeqV+xm8sPUu6sORDV9Dy2pQ9vmNhhtNxkpaVcTjphiMS1KzwTjNL9xwNcUknAwoIOMre5EJgq4QOBxFgKt+gx7ebcSA9JiaWrBOfROhrxAwe2OUD8vRHiMS/W6N3qnUfpqCFMU6TxtJWi79aoUzt680XzgtcK/3kbB/1JS4LRcOMQ6WRBb4pPjoSJ2wsCj+0gR4R8U6jX1iYyqS8rW/J2zvqKiTfjVnCwrQAxrTxrWU1jP5rcm50nNujT5FEGp/0xTWwkFDnlTanrmx6AxVv8QYJX4F9uaxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rA9YAlRCVAd4jYmxRufFFwoXSulswkAHdmGR06WQVRU=;
 b=DDHj6tArna11e/2DTaXWkEMlhyf5uMwsagsCIe1KGBMgf00Mm2ctgZtOy+fIc8IlH/0mQqd/r+542RciqXiP9yiTNXLjVQ7W3WbKBDxYQBxIEA8zQkSqIwx/Vk6pkUmSZcVnrf10nT0A5FWIhIJgHFIlYDRoJmH5KMe/wGRsFMU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by PAWPR08MB9055.eurprd08.prod.outlook.com (2603:10a6:102:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 16:14:56 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Thu, 2 Mar 2023
 16:14:56 +0000
Date:   Thu, 2 Mar 2023 16:14:28 +0000
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "bp@alien8.de" <bp@alien8.de>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, nd@arm.com
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZADLZJI1W1PCJf5t@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
X-ClientProxiedBy: SN6PR2101CA0010.namprd21.prod.outlook.com
 (2603:10b6:805:106::20) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|PAWPR08MB9055:EE_|DBAEUR03FT058:EE_|AS4PR08MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be8ea46-b14e-45ec-591a-08db1b394c13
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 76jz1fINr9NJiS8vpPT6ZZXxaLqBDZkRGTU8IwPGPz67jnRq0yfdLT/L4xJXmP+k31K8GMOII3yY5h7KD/xOlwK+wU0HRArumgk7S70lq0mHwefmrgzk0aPbAJPDWxeX9XE3gvhYkMnsQ0EsYIWzF+mNcm/mXvlANZf/Rccw5xuNsOa3i6N6SiEdLFYHpnxtXSmqmpgPNjXDm5qHf0lCf4yxBVqje/OINvbqEYfj10JZFASx8p0uGfxKvAtB6lx3bmjsapojkR4rLl/C3FWTECXCQakIHnixaiFfRHkyweOzOzYtUSxgYxpqQy/HlvSAZqwHsP0FzbD2aKsEz1zCbVuz38txq6XIl13z6hSfx81HmpuY++vigJ1JgMxUH3zccNw5HRiqw6+7a+AuZ2AxqVCFQDId4AM+lbRn8/uH+/N7NhtSXlI3PSerqXZ9CkaW7VLSnmFGwbVEjy2Ot/QHL+bYlWG29XKVKBA96LjesmzwNrSN3bimBzcw9gXp6khHuRFRNX1xnHiv+ZkFY6rgK2QvQ5Vf2z+uyengPalOaJGJPjvwN/01+e9qO/SPAKa1JIORaV6G2DoPIKLi3WSgdq83W7hdWaOzuThJaQ9aUXv3JCXEsAWAzrPunB6hqVaq/rn6LncOzm29AY7eMcr34EWMzfNthi4pJ+1Rt3MWIK1Hr1/4WzpYbi6FdjUES6iE
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199018)(36756003)(6666004)(6486002)(966005)(6506007)(6512007)(2616005)(26005)(186003)(41300700001)(110136005)(4326008)(316002)(66556008)(66946007)(66476007)(8676002)(2906002)(8936002)(7406005)(478600001)(7416002)(5660300002)(38100700002)(86362001)(921005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9055
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5b7982fa-4f6d-464a-7302-08db1b39430f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0YQEWmG3EdPxQaxcTmbg12DPZyPIPa6fSuJMdPhrkQgyS9DVolJkpVyB7rpzuSNGmV7iOOfXFD5oriVzBBy6BrGyJXSPNoAV0ZKrbr/yUZsR0RrT1AJ1wXDw4kkpMTZ39DN627VvI5+j6emlrDvdtBno2MdHOtp39hiNJwo6Sx3L/pWWBX5bGMo/RNvzU8dvIzl2uVK09E156zPUhmXyGhjN5ry4nq8HOiKyf9+AcP8m6n7+XrR4Qvecpp/mcSVQZwljkogArocuOtgfGxt61HgFeJZniV7n49cEwCEH2Tu5mVqcH+D3kPv9elIssiGourHe4KPduw6XGhr410y46mlfya5mlCg0HZ/rED/cB3wyX4zNzYH/wsvuLhGXhDDebESYuRfu2e1p4trT7B07aMq5v3cgFS4KGHCHyVY0dINsEHO9vk5c6uYZx/FBICrIpfUcQnYDdDldy1NnWkd7+USbFr6leOB3zIPI0/K1dx0T5vVFDYUYHlSkwpAd/aT8sD/NJsYDBfSko1d+Xe9MrwgnEOd3Gw3OzsvAHOB4yqFQrO/rETWbkJZh7irOGcvQDFqNn40HAr1++4yiDVpIo+v3RIeYtz2JoY27tzlp7BD3gENVVFalBPVBnyZ6KSDYA+jwO19tGAMEyi5YUTCy4uAcSpfJ8ObhcOTxWFyEu90H0z/Po3HTOhCnDquaPnM0C2pDF3907LLcDQQKeSgIg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199018)(40470700004)(36840700001)(46966006)(47076005)(83380400001)(36860700001)(6666004)(40460700003)(36756003)(8936002)(81166007)(82740400003)(478600001)(5660300002)(356005)(921005)(82310400005)(40480700001)(86362001)(336012)(26005)(2616005)(186003)(6512007)(6486002)(6506007)(966005)(70206006)(8676002)(70586007)(2906002)(316002)(41300700001)(450100002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:15:10.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be8ea46-b14e-45ec-591a-08db1b394c13
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7759
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/01/2023 18:07, Edgecombe, Rick P wrote:
> On Wed, 2023-03-01 at 14:21 +0000, Szabolcs Nagy wrote:
> > The 02/27/2023 14:29, Rick Edgecombe wrote:
> > > +Application Enabling
> > > +====================
> > > +
> > > +An application's CET capability is marked in its ELF note and can
> > > be verified
> > > +from readelf/llvm-readelf output::
> > > +
> > > +    readelf -n <application> | grep -a SHSTK
> > > +        properties: x86 feature: SHSTK
> > > +
> > > +The kernel does not process these applications markers directly.
> > > Applications
> > > +or loaders must enable CET features using the interface described
> > > in section 4.
> > > +Typically this would be done in dynamic loader or static runtime
> > > objects, as is
> > > +the case in GLIBC.
> > 
> > Note that this has to be an early decision in libc (ld.so or static
> > exe start code), which will be difficult to hook into system wide
> > security policy settings. (e.g. to force shstk on marked binaries.)
> 
> In the eager enabling (by the kernel) scenario, how is this improved?
> The loader has to have the option to disable the shadow stack if
> enabling conditions are not met, so it still has to trust userspace to
> not do that. Did you have any more specifics on how the policy would
> work?

i guess my issue is that the arch prctls only allow self policing.
there is no kernel mechanism to set policy from outside the process
that is either inherited or asynchronously set. policy is completely
managed by libc (and done very early).

now i understand that async disable does not work (thanks for the
explanation), but some control for forced enable/locking inherited
across exec could work.

> > From userspace POV I'd prefer if a static exe did not have to parse
> > its own ELF notes (i.e. kernel enabled shstk based on the marking).
> 
> This is actually exactly what happens in the glibc patches. My
> understand was that it already been discussed amongst glibc folks.

there were many glibc patches some of which are committed despite not
having an accepted linux abi, so i'm trying to review the linux abi
contracts and expect this patch to be authorative, please bear with me.

> > - I think it's better to have a new limit specifically for shadow
> >   stack size (which by default can be RLIMIT_STACK) so userspace
> >   can adjust it if needed (another reason is that stack size is
> >   not always a good indicator of max call depth).
> 
> Hmm, yea. This seems like a good idea, but I don't see why it can't be
> a follow on. The series is quite big just to get the basics. I have
> tried to save some of the enhancements (like alt shadow stack) for the
> future.

it is actually not obvious how to introduce a limit so it is inherited
or reset in a sensible way so i think it is useful to discuss it
together with other issues.

> > The kernel pushes on the shadow stack on signal entry so shadow stack
> > overflow cannot be handled. Please document this as non-recoverable
> > failure.
> 
> It doesn't hurt to call it out. Please see the below link for future
> plans to handle this scenario (alt shadow stack).
> 
> > 
> > I think it can be made recoverable if signals with alternate stack
> > run
> > on a different shadow stack. And the top of the thread shadow stack
> > is
> > just corrupted instead of pushed in the overflow case. Then longjmp
> > out
> > can be made to work (common in stack overflow handling cases), and
> > reliable crash report from the signal handler works (also common).
> > 
> > Does SSP get stored into the sigcontext struct somewhere?
> 
> No, it's pushed to the shadow stack only. See the v2 coverletter of the
> discussion on the design and reasoning:
> 
> https://lore.kernel.org/lkml/20220929222936.14584-1-rick.p.edgecombe@intel.com/

i think this should be part of the initial design as it may be hard
to change later.

"sigaltshstk() is separate from sigaltstack(). You can have one
without the other, neither or both together. Because the shadow
stack specific state is pushed to the shadow stack, the two
features don’t need to know about each other."

this means they cannot be changed together atomically.

i'd expect most sigaltstack users to want to be resilient
against shadow stack overflow which means non-portable
code changes.

i don't see why automatic alt shadow stack allocation would
not work (kernel manages it transparently when an alt stack
is installed or disabled).

"Since shadow alt stacks are a new feature, longjmp()ing from an
alt shadow stack will simply not be supported. If a libc want’s
to support this it will need to enable WRSS and write it’s own
restore token."

i think longjmp should work without enabling writes to the shadow
stack in the libc. this can also affect unwinding across signal
handlers (not for c++ but e.g. glibc thread cancellation).

i'd prefer overwriting the shadow stack top entry on overflow to
disallowing longjmp out of a shadow stack overflow handler.

> > I think the map_shadow_stack syscall should be mentioned in this
> > document too.
> 
> There is a man page prepared for this. I plan to update the docs to
> reference it when it exists and not duplicate the text. There can be a
> blurb for the time being but it would be short lived.

i wanted to comment on the syscall because i think it may be better
to have a magic mmap MAP_ flag that takes care of everything.

but i can go comment on the specific patch then.

thanks.
