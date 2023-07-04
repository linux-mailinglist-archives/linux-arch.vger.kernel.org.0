Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9E2746FF8
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 13:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjGDLea (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGDLe3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 07:34:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928C10C1;
        Tue,  4 Jul 2023 04:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfnUgvnL7AJDCGu42BP6KxU0+paF86x5RF6VikbUJM=;
 b=FgWJ9wkwxv8ul4qSsgcFZ1FBIao+fmm+H7T6wS+DGwJ86nDesi/YCQhwykWeW/KYP22Cz4p8VQCWN2qjQ/PWsxD+JQ42B+I329yutkzf3fKXu9B8tYbHeS0QpPgU8A8pCk5cVhzQ32CKsOrJjXbMFOnFxtF9Ks8lVSa8BQ2PHdM=
Received: from FR3P281CA0138.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:95::17)
 by DU0PR08MB10365.eurprd08.prod.outlook.com (2603:10a6:10:40b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 11:34:24 +0000
Received: from VI1EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:95:cafe::d0) by FR3P281CA0138.outlook.office365.com
 (2603:10a6:d10:95::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Tue, 4 Jul 2023 11:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT054.mail.protection.outlook.com (100.127.144.193) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.18 via Frontend Transport; Tue, 4 Jul 2023 11:34:24 +0000
Received: ("Tessian outbound e2424c13b707:v142"); Tue, 04 Jul 2023 11:34:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dbc53054c0979844
X-CR-MTA-TID: 64aa7808
Received: from 6cabc2462c2a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 03E7BAA6-8E7A-4AD8-B309-93357F5228B1.1;
        Tue, 04 Jul 2023 11:34:16 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6cabc2462c2a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 04 Jul 2023 11:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUzi61KHV45aiF3LMxUK3Z2AyfGh4xlkRFb+Ligu8hToOaObuHB0DzHpfrGya1jTbV4HJ5DJf5eK7lMBDaDjdaHf53bbUBTLZpRXSR1Mwx8MwOmLjtDhiDX9ANxnf5tDlFLr34OKUfjlUG3Eg8jyxmiA4LFUvFBShbb5YF0rlq1q/qs/qc9BG1UuQoJ2E69cy3ZmMZZdo2VwNRuoNh2q6p7ft1bqjlngl5jPDoDWnAvdSJVrh0MN+FuiQZeR47CKBBOnLk+wTw19wb7iv3GxL6fdM9sjWkO0/eaZ0N+ycduB9eSanuqC8JLA6iVcRnVZI2d5O8hJLtUChJRtJp4ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIfnUgvnL7AJDCGu42BP6KxU0+paF86x5RF6VikbUJM=;
 b=WOV7T9IgH2/gSwo/gDgOlGMmyXQ3nWYIZ9ZPCHRE5X13A7T/2COqJwFYE45QCPPDguMqtBh2IO1XKph7EqTFlIqm0w5Z3lu8iPpiLmsz2p+9Enmq1QHCQseFhDff4ywwHeVyZ/zUHa+282AWbUqRrJ/DSoVRE7WG6fbG9yj4voSvZiOdINK/vSoyivHvWKb6IXWvOYzNZvOec6bJEuBIr6OJ1LO5J4upJARd59djLdngMR342CBm9bZKdeMycGJi7zJt1XmPodusNbI4fzAlJ17L9OE5kf7/Iym9/9/xzf00HcI19MwHbZP+I60kFxGCy6wJwKpCoPETWIkFJclBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIfnUgvnL7AJDCGu42BP6KxU0+paF86x5RF6VikbUJM=;
 b=FgWJ9wkwxv8ul4qSsgcFZ1FBIao+fmm+H7T6wS+DGwJ86nDesi/YCQhwykWeW/KYP22Cz4p8VQCWN2qjQ/PWsxD+JQ42B+I329yutkzf3fKXu9B8tYbHeS0QpPgU8A8pCk5cVhzQ32CKsOrJjXbMFOnFxtF9Ks8lVSa8BQ2PHdM=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by GV2PR08MB10382.eurprd08.prod.outlook.com (2603:10a6:150:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 11:34:12 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 11:34:12 +0000
Date:   Tue, 4 Jul 2023 12:33:44 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZKQDmK5nfa8xV9JM@arm.com>
References: <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
 <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
 <ZKMRFNSYQBC6S+ga@arm.com>
 <87r0pox236.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0pox236.fsf@oldenburg.str.redhat.com>
X-ClientProxiedBy: SN7PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:806:125::7) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|GV2PR08MB10382:EE_|VI1EUR03FT054:EE_|DU0PR08MB10365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2575e2bf-3517-4122-7548-08db7c829e41
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: nBvPP1pD1a8nO3X6DnV0/UbTmQ66F3xL1qLQpj0RiCXc9ujA6Zdw9I05ChWRDJJe+gy5WokAuwTVs2+vXjehqONuW8KQtpgo8ASfWxNnIspdDCzbNECyqnl65Em3VaOCRvKiB85n+1z40/TDfH8x4NcSdkqPQzSxduMJVb0Lf37K/tCzoAU2SXd+Arbsde25kWaogi0Qdbm6luaev10BMw+1IR5uvem7VXFgEac5PFybd/AatKYupgrFOfpWwb5Id52eKz3FkKq1c2Tnvcks59EPpQHohwg8J7vwILnagXsCtbbkwRPJbobuW8i2h2dEcpA6nMDt2Y6gZls9EqBx7aKrXPCPsSrVooiFLM8yvUWW6sLNIN9HiPhakiwTvXKPxtdPyfXHurhRT7QBQbH6TPFlF5q2Sl76YIEaDGa7eMoTiMy3gcxrw1DEYEeSj6lyCSzEq4isigh0tCfrcVlmpRFLzb0zQOO0yuLhGkMXxqFxTeLKtELz3TtKQ/EOeFkvh1n5jhPL102CEJEGeU7gZVo+Is776XponzKbk0oqKsNYDT/dzQ0shzbFfyBbUB55
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199021)(66476007)(316002)(66946007)(2906002)(6916009)(66556008)(4326008)(38100700002)(6512007)(26005)(186003)(6506007)(6486002)(6666004)(478600001)(54906003)(2616005)(83380400001)(8936002)(7416002)(7406005)(5660300002)(86362001)(36756003)(44832011)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB10382
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 44b814ea-d6b5-412f-22f9-08db7c8296e1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ME3poT1IClXY3U5KrxeIgTRbmlAEPnlejBwEvpab8WGUp9NjlPR+dTv4q27FQymaW3wYnBc/rfocZ0sQPVV0erCPHSGsZS5I/oyRQPD9ZL8QzETBcEhrbdJHujbVsERLbwC3Ilaf3I9jKxl5ALrOzDXxyUjqzlZ0dzoUANO4Rz3Kt9t+ADUV+tVdsBwh4eXXuBNIAxUFqh7bKn+2JNGsk2FJxO1wTUZAf21h3eP8K+KX3haj8PLdFe8hh61x2dvmQTjBiBFgwEL3Tei85NM4vfcSuFL/GA3S835K22Ua9X6y1TvxlJp59e2Gh+mzgfvN93UJqGe2GbHpXvOmQXQE1TrmwYbQWUYdD2cxmCxd1kdGG8YoZaFmIhQyFwfv5sVGOk14ll9f+g/DYV7T/Ne87JAVTnpO13gU+9AKnNfk8wvFcvutbFFIGCIiG+Xomq0Jc42OleeWPRMzZimEGNPhBWj3Pcn8YFq0UnNPMWAv0tkbio2POe9VbB7QDQSBfAwC5n6Ui5Q3f9SyauhtEXliBiq+6btB5TwFmD7mMmbcGLT80YMTW0uxR0uS1jxlaCT2dPkfBq4wVeHSoAUuuBn1djEh5MjRb1KVtOhAi1txQ/Amr9yq0f0HDkrhJLMjJZvq+YRhoA4eBtwONBR6gqnPKlQ3qgh4wgxsLhq6kelN3XdzTPILd3olhBL1EoNyXgSgHhIvp8vS+u6S8D4fs6Vad/lJ9gfLLMP1xgwoBIeEyaMJS8Nzy2oIjG6BSWfZtM5
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(44832011)(70206006)(4326008)(36756003)(450100002)(70586007)(478600001)(316002)(2906002)(8676002)(8936002)(6862004)(5660300002)(336012)(41300700001)(40460700003)(54906003)(86362001)(40480700001)(6486002)(36860700001)(6512007)(82310400005)(6666004)(6506007)(26005)(186003)(2616005)(82740400003)(83380400001)(356005)(47076005)(81166007)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 11:34:24.3396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2575e2bf-3517-4122-7548-08db7c829e41
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10365
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/03/2023 20:49, Florian Weimer wrote:
> * szabolcs:
> 
> >> alt shadow stack cannot be transparent to existing software anyway, it
> >
> > maybe not in glibc, but a libc can internally use alt shadow stack
> > in sigaltstack instead of exposing a separate sigaltshadowstack api.
> > (this is what a strict posix conform implementation has to do to
> > support shadow stacks), leaking shadow stacks is not a correctness
> > issue unless it prevents the program working (the shadow stack for
> > the main thread likely wastes more memory than all the alt stack
> > leaks. if the leaks become dominant in a thread the sigaltstack
> > libc api can just fail).
> 
> It should be possible in theory to carve out pages from sigaltstack and
> push a shadow stack page and a guard page as part of the signal frame.
> As far as I understand it, the signal frame layout is not ABI, so it's
> possible to hide arbitrary stuff in it.  I'm just saying that it looks
> possible, not that it's a good idea.
> 
> Perhaps that's not realistic with 64K pages, though.

interesting idea, but it would not work transparently:

the user expects the alt stack memory to be usable as normal
memory after longjmping out of a signal handler.

this would break code in practice e.g. when a malloced alt
stack is passed to free(), the contract there is to not
allow changes to the underlying mapping (affects malloc
interposition so not possible to paper over inside the
libc malloc).

so signal entry cannot change the mappings of alt stack.

i think kernel internal alt shadow stack allocation works
in practice where their lifetime is the same as the thread
lifetime. it is sketchy as os interface but doing it in
userspace should be fine i think (it's policy what kind of
sigaltstack usage is allowed). the kernel is easier in the
sense that if there is actual sigreturn then the alt shadow
stack can be freed, while libc cannot catch this case (at
least not easily). leaked shadow stack can also have
security implication but reuse of old alt shadow stack
sounds like a minor issue in practice.
