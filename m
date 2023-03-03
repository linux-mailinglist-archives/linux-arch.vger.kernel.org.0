Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069136A9BCA
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 17:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCCQbd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 11:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjCCQb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 11:31:28 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3B4B762;
        Fri,  3 Mar 2023 08:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnXkqilarehHRVej9BHrS5YNxmgjnu+ApoGT/tOwEVo=;
 b=aVvCyQhS3rp9NX3975/ufMDEZruAyvxa8Vq//TURrd7mJat4/TXhMdJ+9hN0fCW5utRS57cF2xT1BFQsZzP3/tXZIo3UQW1EgZwa0eeWmeQkAlt8pLY+CHNElafgoo3H6nog9uzLCqYI7T7mr7BAzQZWrYRt01/iGc69nsSLZyY=
Received: from FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:96::10)
 by GV2PR08MB8098.eurprd08.prod.outlook.com (2603:10a6:150:76::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Fri, 3 Mar
 2023 16:31:19 +0000
Received: from VI1EUR03FT022.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:d10:96:cafe::6a) by FR0P281CA0136.outlook.office365.com
 (2603:10a6:d10:96::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10 via Frontend
 Transport; Fri, 3 Mar 2023 16:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VI1EUR03FT022.mail.protection.outlook.com (100.127.144.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 16:31:18 +0000
Received: ("Tessian outbound b29c0599cbc9:v135"); Fri, 03 Mar 2023 16:31:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: dfbb8837bf3da4f7
X-CR-MTA-TID: 64aa7808
Received: from cb5e7e4f84ff.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B1A65480-BAD4-4EF8-AA5D-5CFAD9267067.1;
        Fri, 03 Mar 2023 16:31:10 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cb5e7e4f84ff.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 03 Mar 2023 16:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXI3lI32CJByB3whhIMfz6k1EN2cfyAqb1R/Xx+vmDR3Gq0l6RFHGhgy/ITEyEnBPiM8Ir0K1wEG1MYRA+SK3RKNL0YIm1USMmecjcealGfjk+KEwGnd+e5IlEVTxVTReCqSiyqNkEdKjRf2zMFzOLmjqI6NrwZ1ncAdpKPmhCNaBG5Jt17a+wWG/KFiDEg2gl6urKcC2jBo3f+xz2SulnztseZCxDgJ6g7CKFgpm3XKERlzy4RbGv1+/LHJZVuPyVkdQ6073zPsTAo12OiAOlrh0CWfUM1V50jcxcXFI1i7VO87HU2rVpQnSolE9IMzmTxKJO4SVTmCGP/Wnm2GTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnXkqilarehHRVej9BHrS5YNxmgjnu+ApoGT/tOwEVo=;
 b=NsUZZVYnuovDmFhoNqTlleE7WEDg34GX3GzohZCKxZYP5pi9N0ybhjGwkfhM1QeTeTL07gx1ITiViF3tfbIPweEFnl+IKemj32CJjYmgRkaqpoob5c8/drIQA1ZUJBRPbIWU4541MsIeSPffVkSyWxEPfJyLMN3RZoOMb9W52JmSxaKq/9LEAoxrh/wntM7d4fn9dfDNgt82be9ZXZzeDDckdnZS6fLiIbqeNgOKBEWBsgng2qh3mXOdftHO6EfaJ7RpCaCltu7hP8SWzIA0cWcun2VTvufjPAyUvGzLCa1c3L60E0y0VZgVZUkMGaVdXn+bOYdiLFCWfHCE1oygSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnXkqilarehHRVej9BHrS5YNxmgjnu+ApoGT/tOwEVo=;
 b=aVvCyQhS3rp9NX3975/ufMDEZruAyvxa8Vq//TURrd7mJat4/TXhMdJ+9hN0fCW5utRS57cF2xT1BFQsZzP3/tXZIo3UQW1EgZwa0eeWmeQkAlt8pLY+CHNElafgoo3H6nog9uzLCqYI7T7mr7BAzQZWrYRt01/iGc69nsSLZyY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by PAXPR08MB6447.eurprd08.prod.outlook.com (2603:10a6:102:de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Fri, 3 Mar
 2023 16:31:04 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Fri, 3 Mar 2023
 16:31:04 +0000
Date:   Fri, 3 Mar 2023 16:30:37 +0000
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>, "nd@arm.com" <nd@arm.com>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZAIgrXQ4670gxlE4@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <ZADLZJI1W1PCJf5t@arm.com>
 <8153f5d15ec6aa4a221fb945e16d315068bd06e4.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8153f5d15ec6aa4a221fb945e16d315068bd06e4.camel@intel.com>
X-ClientProxiedBy: SN7PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:806:126::33) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|PAXPR08MB6447:EE_|VI1EUR03FT022:EE_|GV2PR08MB8098:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e46c13-2d6e-4c82-6af6-08db1c04b789
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /UXqjHLwi/bKlvotgF4qnKIest1mngSygeXxuJzwbzB62lroHGFZNEbsHo/4Am2V7Gs53UTrjnP0CNWCLB+K7d+AGC1GAt3DkAjUVjZcASDJltubLBnuUzktaq2Nu4mTf5rlj5uPcgBEYwcxMp+ua1iiHWFwTQSWE00qR/LVC1u469nTtAANPbUtvfmCAdKpVwnri3zQpOKcjoiyPdgA/kAEMzKuvY5Kk3V24OfnAjKC4LFzttwwV6fjSTm4UhsgqWNmr0ruyrEz2TSd3neGJ4smIukB9UAZjj556deSkhcEH4FkT9vO258nJamO5CJ+MNT1ZRVBxo49PZmBWnfT8nuP4nKFPyPx1VuG2YWbmqxdvVxNsL+K/Tp9LaSR3ls6n7Oelg8gnBQ+Fds1kGZ0KJ0zuLF7UAhXmLDnkK8Tu4Cjo145arhG5AKwMoqXsLiYuy6yI6SnbPWHiWLGw8dmBzuwQjFl2QSAwy22UZyBE4m690LKFSv/GuZssfNnqvBclpcE4aaC6rmxVGK35cvmNDb4HftmStEpMcfwMUkNeqp6aL1n1DqsC9yDZ7b6FjEjhe8zn4Sq2RstFsBzzF1uEfVbSc9uAd20+dSivJWeCBU6yWK2SdsF4JsFh6+RIOzXLg2WhpsNp4CqPsfM+r3kVNeK/0cnUREq6/revYI9H8ZJAu7Cz23i9R1oMumm+0CG
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(6486002)(2906002)(66899018)(6666004)(7416002)(6506007)(6512007)(110136005)(54906003)(26005)(186003)(2616005)(36756003)(7406005)(86362001)(66946007)(66476007)(4326008)(8676002)(66556008)(316002)(5660300002)(478600001)(83380400001)(41300700001)(38100700002)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6447
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ae1d6e88-5166-4193-85db-08db1c04aee0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aeEuc1CFnd5ZUJn8osG4yJAVVl632K1dT5Qe/xepsO5D0daqEm1Co0wZz/IQq/ZFvsiKwRqeC/rGw1qfbz8iYdtu522Kny+FJztFz+IlxNFt7/SQ6m0Tf4iTLYrJnP9sRbB4xfF8iA+r2kyfVivg8ZCznAxzysrlkHRrtii30UUHKFQfbj2B3dN98w0AHKYhoA0IgXJ6gwCDkft/Nv1LAUtDo7dk1wriXCVJ0bVlkeRWXaHF85QpXFlH8441LFKrgwQe9IU07Php1eGi19yu2WzvYimeXZXLTt7xyjPNXzm5N3oyWesTXS6DBnrl4tgmP8ODI8QI8GUExsME1RLFzOHb4HKi/c1E0++c78edpG6B5Ni2siZBBN6Axm8oKGx+vM54mHD3MQo2zn3JklxNoCfivCOm4OGald5OpPunXO/mlr6KNpswqwT5rv5zAvH+Mk5ujniblC3depajl3TqoattzhxmBBTnG+nDDf4oyfRkAr7fHN86dPFJFyiO8THdhuN/ioNH3UuVS8ACI/ByBxUrUaVwv8QZjBIqN1d/XHKr/l+4L/WPyuRlYjIjSHqwB54v8IBdbOhKvyhZ8WK77X6WsGTigEgVWV5vM7uI4u1XAl+qFPwCbGTj5JMNngjxpZMGBA/zsniwYrDzNUwY4Ne+2zCHV/x4CDhUkeuBUcL7rVkQoCEB1K4D0WKP5g/xl7YuPV20Z226Z4l3iB2V0HZr6Itv+rBfneQWt6qDneY=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(6486002)(36756003)(6666004)(70206006)(2906002)(8676002)(40480700001)(8936002)(4326008)(36860700001)(5660300002)(86362001)(82740400003)(356005)(81166007)(921005)(6506007)(26005)(6512007)(478600001)(54906003)(66899018)(316002)(186003)(450100002)(41300700001)(2616005)(70586007)(83380400001)(110136005)(82310400005)(40460700003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 16:31:18.4928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e46c13-2d6e-4c82-6af6-08db1c04b789
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR03FT022.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8098
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/02/2023 21:17, Edgecombe, Rick P wrote:
> Is the idea that shadow stack would be forced on regardless of if the
> linked libraries support it? In which case it could be allowed to crash
> if they do not?

execute a binary
- with shstk enabled and locked (only if marked?).
- with shstk disabled and locked.
could be managed in userspace, but it is libc dependent then.

> > > > - I think it's better to have a new limit specifically for shadow
> > > >   stack size (which by default can be RLIMIT_STACK) so userspace
> > > >   can adjust it if needed (another reason is that stack size is
> > > >   not always a good indicator of max call depth).
> 
> Looking at this again, I'm not sure why a new rlimit is needed. It
> seems many of those points were just formulations of that the clone3
> stack size was not used, but it actually is and just not documented. If
> you disagree perhaps you could elaborate on what the requirements are
> and we can see if it seems tricky to do in a follow up.

- tiny thread stack and deep signal stack.
(note that this does not really work with glibc because it has
implementation internal signals that don't run on alt stack,
cannot be masked and don't fit on a tiny thread stack, but
with other runtimes this can be a valid use-case, e.g. musl
allows tiny thread stacks, < pagesize.)

- thread runtimes with clone (glibc uses clone3 but some dont).

- huge stacks but small call depth (problem if some va limit
  is hit or memory overcommit is disabled).

> > "sigaltshstk() is separate from sigaltstack(). You can have one
> > without the other, neither or both together. Because the shadow
> > stack specific state is pushed to the shadow stack, the two
> > features don’t need to know about each other."
...
> > i don't see why automatic alt shadow stack allocation would
> > not work (kernel manages it transparently when an alt stack
> > is installed or disabled).
> 
> Ah, I think I see where maybe I can fill you in. Andy Luto had
> discounted this idea out of hand originally, but I didn't see it at
> first. sigaltstack lets you set, retrieve, or disable the shadow stack,
> right... But this doesn't allocate anything, it just sets where the
> next signal will be handled. This is different than things like threads
> where there is a new resources being allocated and it makes coming up
> with logic to guess when to de-allocate the alt shadow stack difficult.
> You probably already know...
> 
> But because of this there can be some modes where the shadow stack is
> changed while on it. For one example, SS_AUTODISARM will disable the
> alt shadow stack while switching to it and restore when sigreturning.
> At which point a new altstack can be set. In the non-shadow stack case
> this is nice because future signals won't clobber the alt stack if you
> switch away from it (swapcontext(), etc). But it also means you can
> "change" the alt stack while on it ("change" sort of, the auto disarm
> results in the kernel forgetting it temporarily).

the problem with swapcontext is that it may unmask signals
that run on the alt stack, which means the code cannot jump
back after another signal clobbered the alt stack.

the non-standard SS_AUTODISARM aims to solve this by disabling
alt stack settings on signal entry until the handler returns.

so this use case is not about supporting swapcontext out, but
about jumping back. however that does not work reliably with
this patchset: if swapcontext goes to the thread stack (and
not to another stack e.g. used by makecontext), then jump back
fails. (and if there is a sigaltshstk installed then even jump
out fails.)

assuming
- jump out from alt shadow stack can be made to work.
- alt shadow stack management can be automatic.
then this can be improved so jump back works reliably.

> I hear where you are coming from with the desire to have it "just work"
> with existing code, but I think the resulting ABI around the alt shadow
> stack allocation lifecycle would be way too complicated even if it
> could be made to work. Hence making a new interface. But also, the idea
> was that the x86 signal ABI should support handling alt shadow stacks,
> which is what we have done with this series. If a different interface
> for configuring it is better than the one from the POC, I'm not seeing
> a problem jump out. Is there any specific concern about backwards
> compatibility here?

sigaltstack syscall behaviour may be hard to change later
and currently
- shadow stack overflow cannot be recovered from.
- longjmp out of signal handler fails (with sigaltshstk).
- SS_AUTODISARM does not work (jump back can fail).

> > "Since shadow alt stacks are a new feature, longjmp()ing from an
> > alt shadow stack will simply not be supported. If a libc want’s
> > to support this it will need to enable WRSS and write it’s own
> > restore token."
> > 
> > i think longjmp should work without enabling writes to the shadow
> > stack in the libc. this can also affect unwinding across signal
> > handlers (not for c++ but e.g. glibc thread cancellation).
> 
> glibc today does not support longjmp()ing from a different stack (for
> example even today after a swapcontext()) when shadow stack is used. If
> glibc used wrss it could be supported maybe, but otherwise I don't see
> how the HW can support it.
> 
> HJ and I were actually just discussing this the other day. Are you
> looking at this series with respect to the arm shadow stack feature by
> any chance? I would love if glibc/tools would document what the shadow
> stack limitations are. If the all the arch's have the same or similar
> limitations perhaps this could be one developer guide. For the most
> part though, the limitations I've encountered are in glibc and the
> kernel is more the building blocks.

well we hope that shadow stack behaviour and limitations can
be similar across targets.

longjmp to different stack should work: it can do the same as
setcontext/swapcontext: scan for the pivot token. then only
longjmp out of alt shadow stack fails. (this is non-conforming
longjmp use, but e.g. qemu relies on it.)

for longjmp out of alt shadow stack, the target shadow stack
needs a pivot token, which implies the kernel needs to push that
on signal entry, which can overflow. but i suspect that can be
handled the same way as stackoverflow on signal entry is handled.

> A general comment. Not sure if you are aware, but this shadow stack
> enabling effort is quite old at this point and there have been many
> discussions on these topics stretching back years. The latest
> conversation was around getting this series into linux-next soon to get
> some testing on the MM pieces. I really appreciate getting this ABI
> feedback as it is always tricky to get right, but at this stage I would
> hope to be focusing mostly on concrete problems.
> 
> I also expect to have some amount of ABI growth going forward with all
> the normal things that entails. Shadow stack is not special in that it
> can come fully finalized without the need for the real world usage
> iterative feedback process. At some point we need to move forward with
> something, and we have quite a bit of initial changes at this point.
> 
> So I would like to minimize the initial implementation unless anyone
> sees any likely problems with future growth. Can you be clear if you
> see any concrete problems at this point or are more looking to evaluate
> the design reasoning? I'm under the assumption there is nothing that
> would prohibit linux-next testing while any ABI shakedown happens
> concurrently at least?

understood.

the points that i think are worth raising:

- shadow stack size logic may need to change later.
  (it can be too big, or too small in practice.)
- shadow stack overflow is not recoverable and the
  possible fix for that (sigaltshstk) breaks longjmp
  out of signal handlers.
- jump back after SS_AUTODISARM swapcontext cannot be
  reliable if alt signal uses thread shadow stack.
- the above two concerns may be mitigated by different
  sigaltstack behaviour which may be hard to add later.
- end token for backtrace may be useful, if added
  later it can be hard to check.

thanks.
