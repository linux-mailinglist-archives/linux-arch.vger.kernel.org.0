Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA674620F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jul 2023 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjGCSTt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jul 2023 14:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCSTr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2023 14:19:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77063DC;
        Mon,  3 Jul 2023 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11l1F8kl2f+o1Fb8H6ZnFOr8wj7VM7BAcUWWxvnkeWc=;
 b=B+DfxVVvapY5UHm9rDx8sZeukeAJt0uWAlLkmLvKMKa8F5TiId1MnFu/WxTvOCuv1ypFUpXGVdgdNudYMMvEJyvcMs7ouTdlfPJ/19cvZEjYVPrkXqtozqqr8ysh6cXTq2oP4KbYQONxWqIpPxpIEte9UYmQcjNQPlaWK2XmqcY=
Received: from DUZPR01CA0329.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::28) by GV1PR08MB7913.eurprd08.prod.outlook.com
 (2603:10a6:150:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 18:19:37 +0000
Received: from DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4ba:cafe::9b) by DUZPR01CA0329.outlook.office365.com
 (2603:10a6:10:4ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.30 via Frontend
 Transport; Mon, 3 Jul 2023 18:19:37 +0000
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
 15.20.6565.18 via Frontend Transport; Mon, 3 Jul 2023 18:19:37 +0000
Received: ("Tessian outbound b11b8bb4dfe8:v142"); Mon, 03 Jul 2023 18:19:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f90893aeb757d9fb
X-CR-MTA-TID: 64aa7808
Received: from cdb9d9a9a3cb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 06465484-5DA4-4614-8536-1D646FACA0CF.1;
        Mon, 03 Jul 2023 18:19:31 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cdb9d9a9a3cb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 03 Jul 2023 18:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxfaPEWIi8j0czZV2ALs4K+eNO090hQ4tmKjpuq2aUop/NKPLi1Idlxms6yPaTSMjDoIGqo5co61uszvHQzjsZtqt19awlud5mOSfj9k9dhRvK6fOfy/7s2kQcU4W7W3f/C5x0km0dZ+5Dqw985QZO/kvJWKbmd7gJPf8zNyYoRTY5F3rVlwVrijcuXIEYyoe5mJvNX/M3U7t/6T/Z8+LP1EE0Yrn2nbQ0DE6MKBTsGld8sBKFlnoJK8BQEqJqUt7/IUgO+UB7alI3tIhP8bnYohgp5qjVfR/tdRRvQQVuNOptMiCWCL48sevmSu84kgIqWdAwc0HiXiFkCDZ2dJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11l1F8kl2f+o1Fb8H6ZnFOr8wj7VM7BAcUWWxvnkeWc=;
 b=nTIonKXlsDA1yNmexAgHz2kaI6SWwcixwZotHl9BHaQW2zws+fQL2y3HGtFnu3l5vBxGPyK/53+/0at9HKU3a3XVU545XuXzEXq3mBRD0OzWNn9usjWmpdRnLIynjeZ8SrgsT/TgVMouGXCcr9dsCa05A+gx+wOHWBadf4XmVim/noDEnju5Z893KvZd7gi0rv90qNdfq0LeQX8n5r4kfOr+cKYoOUjkr4Q1p1Me2jqnZMjeFk7YafMGuzQ3vl9ERvI8YQFFejcxcdmrDFuRIeoslMuqwvFUd9Zr6SeV92s1/KVCJXSfh2WuhO8gJYcSVPzz4d9PMo+tNuNGkDinRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11l1F8kl2f+o1Fb8H6ZnFOr8wj7VM7BAcUWWxvnkeWc=;
 b=B+DfxVVvapY5UHm9rDx8sZeukeAJt0uWAlLkmLvKMKa8F5TiId1MnFu/WxTvOCuv1ypFUpXGVdgdNudYMMvEJyvcMs7ouTdlfPJ/19cvZEjYVPrkXqtozqqr8ysh6cXTq2oP4KbYQONxWqIpPxpIEte9UYmQcjNQPlaWK2XmqcY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS4PR08MB7902.eurprd08.prod.outlook.com (2603:10a6:20b:51d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 18:19:27 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 18:19:27 +0000
Date:   Mon, 3 Jul 2023 19:19:00 +0100
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
        "fweimer@redhat.com" <fweimer@redhat.com>,
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
Message-ID: <ZKMRFNSYQBC6S+ga@arm.com>
References: <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
 <ZJR545en+dYx399c@arm.com>
 <1cd67ae45fc379fd82d2745190e4caf74e67499e.camel@intel.com>
 <ZJ2sTu9QRmiWNISy@arm.com>
 <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e057de9dd9e9fe48981afb4ded4b337e8a83fabf.camel@intel.com>
X-ClientProxiedBy: DM6PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:5:120::27) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS4PR08MB7902:EE_|DBAEUR03FT058:EE_|GV1PR08MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a14d60-b21d-41c0-f13d-08db7bf20f61
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LDbFipKGgs8BDN27DGtAqjbHYBDvRgXsqUHoO4BcahGIWi6TEeYO5f5xOQah/MwamW5tw9hie2/wvEEuq/oIamWxoQdmTVUVPsPPmlKxWA8deHxpFPnaMRpWdf9q7JGhoBsSsgWmVyLWgtRbJCGdgFF/KopJOUWz9Ip8mFRlk+wwwSynnlLhqYDQSssI3oKDmgOIgc2/0eWcRNBBsdPE7y3RlwCE73b8pEObwl11blOGGPO6FgspGFFgMo1HI79bXgiDG41cxVODC9i7njm5yrcpI1iVykMqA2/kqrp4nc4UIdDtMiuVfHHrY0178cff1Ss60Q6pWogXLQRc+FN9GkR4N857im6LFiH7wfhr0VRYHiNrKHYCX/S1vml3JI7zNs+BBn/nN48FPkuzequn+k9y4/nWMAF12FYYzW3GmFFcuJhUz/JidlIH/M3ql2LiwD40P1JgP0R+Qs6rTwMwkouXp/+lVbIgEEFzG3nBlrJHmTcUkF1CTQEwsyczW+WLIo1AkG9fVMClodAp2w9uuChxUOLev8DzeXqvWimr4tCOWJSSVJGs5ask+jxLJKJzujxNkyJMWWaQvrX6RAgtzn0QJTg1F61SClmmBUOVYCc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(4326008)(316002)(66556008)(66476007)(66946007)(26005)(86362001)(6512007)(6506007)(186003)(83380400001)(966005)(2616005)(2906002)(6486002)(6666004)(30864003)(38100700002)(7406005)(7416002)(5660300002)(478600001)(8676002)(54906003)(110136005)(8936002)(41300700001)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7902
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0d66b1d3-7e7e-4d92-238c-08db7bf20963
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPJWAfSZ1VVMMbnDABOQKMz2446oHhQCkYmIvU+ZLpkfnyT6BVLxo1gGvcE6/SqJ5xukxkOTCvQcwU9sh6uEnsUB06bvtFpvY8hZItABxx8EHao4T6PEXmQlMzkoC+HDGCd9Itklk4hNuUFVD/NvD89yAa02q70eXFdgW0WdDbaXMUBm8QkABoulVj5LkGmjRD+BmO/dTJCE5d4gD3npGd/mRRZUFos2igD5IEksRTfKHHhRPr+z+JQOhs4jixBBWSf/+2BSArGxfoUmm3OSkqdfBNwzDwrIw6fBHEudAud64Af9RS+B0H9CnCts0Lu/5duGWykG0DMJrj8S1vz9Pxii4ueCBA/bg17AXyLNzqmWYf6Qwnce48/CG8mejSnqNQRFNa781wB+Y2WzubqbZNt6nNIP/djGiABCsokyV6ozxyWvRtGJe38cPPTDDTvhLXaqBVqbJL5Q7EpCd5GhO2BBV+2RQFGmLa5rx7HjZLfHf2ug1Jqx3TToFO7YLDAPeAnuepI4kk0mU2QKMXrYoiLhuj5TFWebygCkXCJ7Q9FCcjBATH09fUnLyQJNWkb7QqL6jymfwhgqPql81TmgXlPEuIPkXXIcDWMYZnbalHZxyC0gAFbvf/i/kSZQ00YldyZX9fwIwCXIOn5uehp9xsP5Ug0OMfozlNwie1T2F4l/9fv5nad0j/Je5hcYqlGfcr1PahH4A83bTuytGfnxOWcH68cbcB8eWHayOpBEz3vwOQPOxzTBM0cjy4uHOwIK
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(6486002)(26005)(30864003)(107886003)(5660300002)(478600001)(86362001)(70586007)(70206006)(4326008)(81166007)(82740400003)(6512007)(186003)(36756003)(966005)(2616005)(6666004)(2906002)(6506007)(40460700003)(82310400005)(8676002)(316002)(450100002)(336012)(47076005)(8936002)(356005)(36860700001)(40480700001)(83380400001)(54906003)(110136005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 18:19:37.2342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a14d60-b21d-41c0-f13d-08db7bf20f61
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7913
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 07/02/2023 18:03, Edgecombe, Rick P wrote:
> On Thu, 2023-06-29 at 17:07 +0100, szabolcs.nagy@arm.com wrote:
> > The 06/22/2023 23:18, Edgecombe, Rick P wrote:
> > > I'd also appreciate if you could spell out exactly which:
> > >  - ucontext
> > >  - signal
> > >  - longjmp
> > >  - custom library stack switching
> > > 
> > > patterns you think shadow stack should support working together.
> > > Because even after all these mails, I'm still not sure exactly what
> > > you
> > > are trying to achieve.
> 
> Hi Szablocs,
> 
> Thanks for writing all this up. It is helpful to understand where you
> are coming from. Please don't miss my point at the very bottom of this
> response.
> 
> > 
> > i'm trying to support two operations (in any combination):
> > 
> > (1) jump up the current (active) stack.
> > 
> > (2) jump to a live frame in a different inactive but live stack.
> >     the old stack becomes inactive (= no task executes on it)
> >     and live (= has valid frames to jump to).
> > 
> > with
> > 
> > (3) the runtime must manage the shadow stacks transparently.
> >     (= portable c code does not need modifications)
> > 
> > mapping this to c apis:
> > 
> > - swapcontext, setcontext, longjmp, custom stack switching are jump
> >   operations. (there are conditions under which (1) and (2) must
> > work,
> >   further details don't matter.)
> > 
> > - makecontext creates an inactive live stack.
> > 
> > - signal is only special if it executes on an alt stack: on signal
> >   entry the alt stack becomes active and the interrupted stack
> >   inactive but live. (nested signals execute on the alt stack until
> >   that is left either via a jump or signal return.)
> > 
> > - unwinding can be implemented with jump operations (it needs some
> >   other things but that's out of scope here).
> > 
> > the patterns that shadow stack should support falls out of this
> > model.
> > (e.g. posix does not allow jumping from one thread to the stack of a
> > different thread, but the model does not care about that, it only
> > cares if the target stack is inactive and live then jump should
> > work.)
> > 
> > some observations:
> > 
> > - it is necessary for jump to detect case (2) and then switch to the
> >   target shadow stack. this is also sufficient to implement it.
> > (note:
> >   the restore token can be used for detection since that is
> > guaranteed
> >   to be present when user code creates an inactive live stack and is
> >   not present anywhere else by design. a different marking can be
> > used
> >   if the inactive live stack is created by the kernel, but then the
> >   kernel has to provide a switch method, e.g. syscall. this should
> > not
> >   be controversial.)
> 
> For x86's shadow stack you can jump to a new stack without leaving a
> token behind. I don't know if maybe we could make it a rule in the
> x86_64 ABI that you should always leave a token if you are going to
> mark the SHSTK elf bit. But if anything did this, then longjmp() could
> never make it back to the stack where setjmp() was called without
> kernel help.

ok. i didn't know that.

the restore token means the stack is valid to execute on later. so
from libc pov if the token is missing then jumping to that stack is
simply ub. (the kernel could help working around missing tokens but
presumably the point of not adding a token is exactly to prevent
any kind of jumps to that stack later).

so i don't think this changes much. (other than the x86 model has
inactive dead stacks that cannot be jumped to, and this is enforced.
but libc jumps are not supposed to leave such dead stacks behind so
libc jumps would have to add the restore token when doing a switch.)

> > - in this model two live stacks cannot use the same shadow stack
> > since
> >   jumping between the two stacks is allowed in both directions, but
> >   jumping within a shadow stack only works in one direction. (also
> > two
> >   tasks could execute on the same shadow stack then. and it makes
> >   shadow stack size accounting problematic.)
> > 
> > - so sharing shadow stack with alt stack is broken. (the model is
> >   right in the sense that valid posix code can trigger the issue.
> 
> Could you spell out what "the issue" is that can be triggered?

i meant jumping back from the main to the alt stack:

in main:
setup sig alt stack
setjmp buf1
	raise signal on first return
	longjmp buf2 on second return

in signal handler:
setjmp buf2
	longjmp buf1 on first return
	can continue after second return

in my reading of posix this is valid (and works if signals are masked
such that the alt stack is not clobbered when jumping away from it).

but cannot work with a single shared shadow stack.

> >  we
> >   can ignore that corner case and adjust the model so the shared
> >   shadow stack works for alt stack, but it likely does not change the
> >   jump design: eventually we want alt shadow stack.)
> 
> As we discussed previously, alt shadow stack can't work transparently
> with existing code due to the sigaltstack API. I wonder if maybe you
> are trying to get at something else, and I'm not following.

i would like a jump design that works with alt shadow stack.

...
> So since they are tied together, and I thought to hold off on it for
> now. I don't want to try to squeeze around the upstream userspace, I
> think a version 2 should be a clean slate on a new elf bit.

ok.

> > i understand that the proposed linux abi makes most existing binaries
> > with shstk marking work, which is relevant for x86.
> > 
> > for a while i thought we can fix the remaining issues even if that
> > means breaking existing shstk binaries (just bump the abi marking).
> > now it seems the issues can only be addressed in a future abi break.
> 
> Adding a new arch_prctl() ENABLE value was the plan. Not sure what you
> mean by ABI break vs version bump. The plan was to add the new features
> without userspace regression by putting any behavior behind a different
> enable option. This relies on userspace to add a new elf bit, and to
> use it.

yes future abi break was the wrong wording: new abi with new elf bit
is what i meant. i.e. x86 will have an abi v1 and abi v2, where v2
abi is not compatible e.g. with v1 unwinder.

> > which means x86 linux will likely end up maintaining two incompatible
> > abis and the future one will need user code and build system changes,
> > not just runtime changes. it is not a small incremental change to add
> > alt shadow stack support for example.
> > 
> > i don't think the maintenance burden of two shadow stack abis is the
> > right path for arm64 to follow, so the shadow stack semantics will
> > likely become divergent not common across targets.
> 
> Unfortunately we are at a bit of an information asymmetry here because
> the ARM spec and patches are not public. It may be part of the cause of
> the confusion.

yes that's unfortunate. but in this case i just meant that arm64
does not have existing marked binaries to worry about. so it seems
wrong to do a v1 abi and later a v2 abi to fix that up.

> It kind of sounds like you don't like the x86 glibc implementation. And
> you want to make sure the kernel can support whatever a new solution is
> that you are working on. I am on board with the goal of having some
> generic set of rules to make portable code work for other architectures
> shadow stacks. But I think how close we can get to that goal or what it
> looks like is an open question. For several reasons:
>  1. Not everyone can see all the specs
>  2. No POCs have been done (or at least shared)
>  3. It's not clear what needs to be supported (yes, I know you have 
>     made a rough proposal here, but it sounds like on the x86 glibc 
>     side at least it's not even clear what non-shadow stack stack 
>     switching operations can work together)
> 
> But towards these goals, I think your technical requests are:
> 
> 1. Leave a token on switching to an alt shadow stack. As discussed
> earlier, we can't do this because of the overflow issues. Also since,

i don't think the overflow discussion was conclusive.

the kernel could modify the top entry instead of adding a new token.
and provide a syscall to switch to that top entry undoing the
modification.

there might be cornercases and likely not much space for encoding
a return address and special marking in an entry. but otherwise
this makes jumping to an overflowed shadow stack work.

but it is also a valid design to just not support jumping out of alt
stack in the specific case of a shadow stack overflow (treat that as
a fatal error), but still allow the jump in less fatal situations.

> alt shadow stack cannot be transparent to existing software anyway, it

maybe not in glibc, but a libc can internally use alt shadow stack
in sigaltstack instead of exposing a separate sigaltshadowstack api.
(this is what a strict posix conform implementation has to do to
support shadow stacks), leaking shadow stacks is not a correctness
issue unless it prevents the program working (the shadow stack for
the main thread likely wastes more memory than all the alt stack
leaks. if the leaks become dominant in a thread the sigaltstack
libc api can just fail).

> should be ok to introduce limitations. So I think this one is a no.
> What we could do is introduce security weakening kernel helpers, but
> this would make sense to come with alt shadow stack support.

yes this would be for abi v2 on x86.

> 2. Add an end token at the top of the shadow stack. Because of the
> existing userspace restriction interactions, this is complicated to
> evaluate but I think we *could* do this now. There are pros and cons.

yes, this is a minor point. (and ok to do differently across targets)

> 3. Support more options for shadow stack sizing. (I think you are
> referring to this conversation:
> https://lore.kernel.org/lkml/ZAIgrXQ4670gxlE4@arm.com/). I don't see
> why this is needed for the base implementation. If ARM wants to add a
> new rlimit or clone variant, I don't see why x86 can't support it
> later.

i think it can be added later.

but it may be important for deployment on some platforms, since a
libc (or other language runtime) may want to set the shadow stack
size differently than the kernel default, because

- languages allocating large arrays on the stack
  (too big shadow stack can cause OOM with overcommit off and
  rlimits can be hit like RLIMIT_DATA, RLIMIT_AS because of it)

- tiny thread stack but big sigaltstack (musl libc, go).

> So if we add 2, are you satisfied? Or otherwise, on the non-technical
> request side, are you asking to hold off on x86 shadow stack, in order
> to co-develop a unified solution?

well a unified solution would need a v2 abi with new elf bit,
and it seems the preference is a v1 abi first, so at this point
i'm just trying to understand the potential brokenness in v1
and possible solutions for v2 since if there is a v2 i would
like that to be compatible across targets.

> I think the existing solution will see use in the meantime, including
> for the development of all the x86 specific JIT implementations.

i think some of that work have to be redone if there is a v2 abi,
which is why i thought having 2 abis is too much maintenance work.

> And finally, what I think is the most important point in all of this:
> 
> I think that *how* it gets used will be a better guide for further
> development than us debating. For example the main pain point that has
> come up so far is the problems around dlopen(). And the future work
> that has been scoped has been for the kernel to help out in this area.
> This is based on _user_ (distro) requests.

i think dlopen (and how it is used) is part of the api/abi design.

in presence of programs that can load any library (e.g. python exe)
it is difficult to make use of shstk without runtime disable.

however if dlopen gets support for runtime disable, reducing the
number of incompatible libraries over time is still relevant,
which requires abi/api design that allows that.

> Any apps that don't work with shadow stack limitations can simply not
> enable shadow stack. You and me are debating these specific API
> combinations, but we can't know whether they are actually the best
> place to focus development efforts. And the early signs are this is NOT
> the most important problem to solve.

disabling shadow stack is not simple (removing the elf marking from
an exe is often not possible/appropriate, but using an env var that
affects an entire process tree has problems too.) but i don't have
a solution for this (it is likely a userspace issue).

debating the api issues was at least useful for me to understand
what can go into the x86 v1 abi and what may go into a v2 abi.
