Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715A473A64B
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjFVQnR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjFVQnN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 12:43:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598AA2107;
        Thu, 22 Jun 2023 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA/DUTfqmB3gV9+rUppqpDrXrRo6DIOkirzU0nWj3eU=;
 b=8JdBDWmCQg1AmGWX+O79mq355t9UBwxJOiopXlCCXPQs71GVJFsRz5Tsfj0OWr3FKAvD9UAbqYwRekUOJVypyE5JXQ9Gs/+dSoBhdsoVYN9AYwUwOE9dKjjbziICFiEDtGhSBds/kT7U9rW88e4oKo+xZS7PERKB06sakJC8OXs=
Received: from DUZPR01CA0115.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::27) by AM7PR08MB5383.eurprd08.prod.outlook.com
 (2603:10a6:20b:102::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:42:54 +0000
Received: from DBAEUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:4bc:cafe::28) by DUZPR01CA0115.outlook.office365.com
 (2603:10a6:10:4bc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 16:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT017.mail.protection.outlook.com (100.127.142.243) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24 via Frontend Transport; Thu, 22 Jun 2023 16:42:54 +0000
Received: ("Tessian outbound 52217515e112:v142"); Thu, 22 Jun 2023 16:42:53 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 128e7f28d2ae9b1c
X-CR-MTA-TID: 64aa7808
Received: from f23967a44e06.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1E0577D1-55FA-47A6-B77C-3023F0419000.1;
        Thu, 22 Jun 2023 16:42:46 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f23967a44e06.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 22 Jun 2023 16:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9DJ1Q/QNuDRL/cI4RxzWmcmnhZkvzL0nsyt147gE+qx/6mg6MzQa3TxZgkdqy8jDFPtny1mpUcSYz0J+9wS2qriatfZMswi2ZF33nWNcEB9OPkQGckSowA9JAXkutjslpnxxYzLwIV5Jkz1Rt17bO8HdsviKRFNUrVr3VA4nzFIYCE6qFgd6IsjrApXAa53jinDdeu/lq/RQ85ntT0iVPv/Am4YPodnMWKqj54ibdWnNgIRr5gBJbGPXloxIqxmc8mlvWpnnR0UzG4v0cYCCIBWMRUMKGfo/K2UPKPQFUc5m17OK9iOhgnA00iO26MXvJ2SWI2dQ8WFu7R/wOPxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EA/DUTfqmB3gV9+rUppqpDrXrRo6DIOkirzU0nWj3eU=;
 b=EpRn7DfPXTuYfJfAkJeQQLnjc3CTwGHZ6wQZQjJm1pwN6Hjz0zfa8atsp89GJgtMeOdBDiTtKiQ0gOMi63SWUEHl9wMLGREkk3PjHok1sUzU2+hxd3XKIql6ioKwV9JUM3MhRmc3jwTuWGWKkILLGDLadTZmPKyKqKpicgvOpQbGblFOOo3QQHozaYrR0h+gr7ULIBBD62snXFpTS1Ys8OnH4kokwtyMhVzjTF5OqDK5wCqUBbDEQD5tCHMGjt7vAtPTjWg3Ud9kLe2t5KOWR4jEB/kKi2ECUjaD8X2gvZytM7RlVnFnQEx7Q2lH4CTLZ//OX3piQaND+06vkqfYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EA/DUTfqmB3gV9+rUppqpDrXrRo6DIOkirzU0nWj3eU=;
 b=8JdBDWmCQg1AmGWX+O79mq355t9UBwxJOiopXlCCXPQs71GVJFsRz5Tsfj0OWr3FKAvD9UAbqYwRekUOJVypyE5JXQ9Gs/+dSoBhdsoVYN9AYwUwOE9dKjjbziICFiEDtGhSBds/kT7U9rW88e4oKo+xZS7PERKB06sakJC8OXs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU2PR08MB10230.eurprd08.prod.outlook.com (2603:10a6:10:46e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:42:41 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::43b7:3a83:5cbe:4559%4]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 16:42:40 +0000
Date:   Thu, 22 Jun 2023 17:42:11 +0100
From:   "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "nd@arm.com" <nd@arm.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "jannh@google.com" <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZJR545en+dYx399c@arm.com>
References: <ZImZ6eUxf5DdLYpe@arm.com>
 <64837d2af3ae39bafd025b3141a04f04f4323205.camel@intel.com>
 <ZJAWMSLfSaHOD1+X@arm.com>
 <5794e4024a01e9c25f0951a7386cac69310dbd0f.camel@intel.com>
 <ZJFukYxRbU1MZlQn@arm.com>
 <e676c4878c51ab4b6018c9426b5edacdb95f2168.camel@intel.com>
 <ZJLgp29mM3BLb3xa@arm.com>
 <c5ae83588a7e107beaf858ab04961e70d16fe32c.camel@intel.com>
 <ZJQR7slVHvjeCQG8@arm.com>
 <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrW+30_a2QQE-yw9djVFPxSxm7-c2FZFwZ50dOEmnmkeDA@mail.gmail.com>
X-ClientProxiedBy: DS7PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::9) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|DU2PR08MB10230:EE_|DBAEUR03FT017:EE_|AM7PR08MB5383:EE_
X-MS-Office365-Filtering-Correlation-Id: c3778a74-cb59-41b5-57a1-08db733fba09
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: fKWg56gc052v8Z59iBUecFoVNqPWeWHoCPXiAQy7DZHgj4J45pDJRsgDiVUY83MOiLMyIqskN4LuMWrMTkhLDHpIrPfVh2KDIXhTk03W6LnqMETOD6MvstU0pz7M5vO9PTxdl/6pCYUn/v5hYIRmzdwkGp9Ha1V+MTvgoK4p6npsqp5d36fUg+Gqdqz1Z2QkvBzVirKg1PMM2U7QM34xAqqP2SJX62Y/XmNfvVLf2J4+6nBqc6rR1HQ38G6ClCdmt6J131BRxvhUeUSWSpbjSPa/AKkqE4fEBvafChGt5iFhRlAXK8unsGwJYg5gOor7wVW0VrOnsaHj4+G5SC/rDfxseqTqb+Ieani7pvsl/v4TkI5X4dzU+HfF1Qgurhw4V4Bf6A5DU/0sfwr+yb8NZHYE70V0YebBxfFbXZEQH4TciUbSnhxS5X/F5u4Zglx8uZYLWQ0P+GaB8dxVwK/tR/vutIICtGJ+YL5KboUIbsZOKCUCgNyCWCjYriMG4KaORYxBqYyE6zEWPC6yBi1KHZKY/BU7V41gWd4gjipjASMFgZ1x5ldLutBE1kw5XTpml3r478eXMRiwBPMuIXpnoah2ab7xcJtsscjJQ6Jyz4w=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(54906003)(4326008)(478600001)(6666004)(6512007)(53546011)(26005)(6486002)(2906002)(186003)(66476007)(66556008)(8936002)(316002)(7406005)(66946007)(6916009)(5660300002)(41300700001)(7416002)(8676002)(38100700002)(6506007)(36756003)(2616005)(83380400001)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10230
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d65093b2-bfcc-47e2-460c-08db733fb12d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FC2es5rEd5D3YDcD3O9IZZCVwYoxkp9Tt+eMisyOOGOTSkho6/4nEePut3Cnj6ql1ftOZ6Vyavs+yHfSV8R11CHvdNXwpfbgDRTcP1FV9LG84t6c5zpp7KttlX4QFaYtGmAuES2zNGlzrijJ6+g4aKQnrKwRUI8rC/s1rK/L/163Flu8MR0lRy+9uJ6kwlXNY8Eo/8sJBDsu99kZlri67iOBvO/+KLaC8qacG7opj478ClmDDOGcVKLc+5W1uqqwhznLzaRJ9PW3qfQqhZOibgGFbRmvqCv2695WTre6ai4K8d9XKwnxMhwUPGhtSPS/oEC/ufoV0ad4m8PZ0rffe786Gu0iKE1a1gnni9SHa6uQLwTLfSUC8+lUlVq+FjYfKSQCTvyIUMFM2gBSr5quFYucM1qCDFqVmZxV4ifyBjIbZ8axfafPUZnRpKmLl/2Cil/7ZTh5frmgkivCftJg6DSdtzaewIFDBHst4dppwdLYWlnZyJstr53pEo0ElIoUSBmKTCq35Q773keyaue5PX+K/K7XGGxeNvvhEwA2yBgVDzC8gClG85xhrFIjl+9LSsHVp9yXnf3T4ufSYl0EdiwGY1FR8/whSCmc1OK7e3+EQGae7H07KVm0Cv2sPQo+6iblG+tPY16vfPKciR3Q9nChjBCIXSc4ezMROBQyPFibI0DAwOb7pvot+3AxAQitw4c8ZJHZfjiQleexcP7qUYpfHucdBNnghkcB4D/N4sVF4IDflWq7RcwBNl2Mz49MgjPy8L84uO90AgyUP+fvQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(36756003)(53546011)(40460700003)(81166007)(70206006)(356005)(5660300002)(6862004)(41300700001)(86362001)(8676002)(4326008)(450100002)(40480700001)(316002)(8936002)(70586007)(82740400003)(107886003)(6486002)(47076005)(26005)(6506007)(186003)(2616005)(6512007)(2906002)(478600001)(336012)(6666004)(54906003)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 16:42:54.4209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3778a74-cb59-41b5-57a1-08db733fba09
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5383
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 06/22/2023 08:26, Andy Lutomirski wrote:
> On Thu, Jun 22, 2023 at 2:28 AM szabolcs.nagy@arm.com
> <szabolcs.nagy@arm.com> wrote:
> >
> > The 06/21/2023 18:54, Edgecombe, Rick P wrote:
> > > On Wed, 2023-06-21 at 12:36 +0100, szabolcs.nagy@arm.com wrote:
> > > > > The 06/20/2023 19:34, Edgecombe, Rick P wrote:
> > > > > > > I actually did a POC for this, but rejected it. The problem is,
> > > > > > > if
> > > > > > > there is a shadow stack overflow at that point then the kernel
> > > > > > > > > can't
> > > > > > > push the shadow stack token to the old stack. And shadow stack
> > > > > > > > > overflow
> > > > > > > is exactly the alt shadow stack use case. So it doesn't really
> > > > > > > > > solve
> > > > > > > the problem.
> > > > >
> > > > > the restore token in the alt shstk case does not regress anything
> > > > > but
> > > > > makes some use-cases work.
> > > > >
> > > > > alt shadow stack is important if code tries to jump in and out of
> > > > > signal handlers (dosemu does this with swapcontext) and for that a
> > > > > restore token is needed.
> > > > >
> > > > > alt shadow stack is important if the original shstk did not
> > > > > overflow
> > > > > but the signal handler would overflow it (small thread stack, huge
> > > > > sigaltstack case).
> > > > >
> > > > > alt shadow stack is also important for crash reporting on shstk
> > > > > overflow even if longjmp does not work then. longjmp to a
> > > > > makecontext
> > > > > stack would still work and longjmp back to the original stack can
> > > > > be
> > > > > made to mostly work by an altshstk option to overwrite the top
> > > > > entry
> > > > > with a restore token on overflow (this can break unwinding though).
> > > > >
> > >
> > > There was previously a request to create an alt shadow stack for the
> > > purpose of handling shadow stack overflow. So you are now suggesting to
> > > to exclude that and instead target a different use case for alt shadow
> > > stack?
> >
> > that is not what i said.
> >
> > > But I'm not sure how much we should change the ABI at this point since
> > > we are constrained by existing userspace. If you read the history, we
> > > may end up needing to deprecate the whole elf bit for this and other
> > > reasons.
> >
> > i'm not against deprecating the elf bit, but i think binary
> > marking will be difficult for this kind of feature no matter what
> > (code may be incompatible for complex runtime dependent reasons).
> >
> > > So should we struggle to find a way to grow the existing ABI without
> > > disturbing the existing userspace? Or should we start with something,
> > > finally, and see where we need to grow and maybe get a chance at a
> > > fresh start to grow it?
> > >
> > > Like, maybe 3 people will show up saying "hey, I *really* need to use
> > > shadow stack and longjmp from a ucontext stack", and no one says
> > > anything about shadow stack overflow. Then we know what to do. And
> > > maybe dosemu decides it doesn't need to implement shadow stack (highly
> > > likely I would think). Now that I think about it, AFAIU SS_AUTODISARM
> > > was created for dosemu, and the alt shadow stack patch adopted this
> > > behavior. So it's speculation that there is even a problem in that
> > > scenario.
> > >
> > > Or maybe people just enable WRSS for longjmp() and directly jump back
> > > to the setjmp() point. Do most people want fast setjmp/longjmp() at the
> > > cost of a little security?
> > >
> > > Even if, with enough discussion, we could optimize for all
> > > hypotheticals without real user feedback, I don't see how it helps
> > > users to hold shadow stack. So I think we should move forward with the
> > > current ABI.
> >
> > you may not get a second chance to fix a security feature.
> > it will be just disabled if it causes problems.
> 
> *I* would use altshadowstack.
> 
> I run a production system (that cares about correctness *and*
> performance, but that's not really relevant here -- SHSTK ought to be
> fast).  And, if it crashes, I want to know why.  So I handle SIGSEGV,
> etc so I have good logs if it crashes.  And I want those same logs if
> I overflow the stack.
> 
> That being said, I have no need for longjmp or siglongjmp for this.  I
> use exit(2) to escape.

the same crash handler that prints a log on shstk overflow should
work when a different cause of SIGSEGV is recoverable via longjmp.
to me this means that alt shstk must work with longjmp at least in
the non-shstk overflow case (which can be declared non-recoverable).

> For what it's worth, setjmp/longjmp is a bad API.  The actual pattern
> that ought to work well (and that could be supported well by fancy
> compilers and non-C languages, as I understand it) is more like a
> function call that has two ways out.  Like this (pseudo-C):
> 
> void function(struct better_jmp_buf &buf, args...)
> {
>    ...
>        if (condition)
>           better_long_jump(buf);  // long jumps out!
>        // could also pass buf to another function
>    ...
>        // could also return normally
> }
> 
> better_call_with_jmp_buf(function, args);
> 
> *This* could support altshadowstack just fine.  And many users might
> be okay with the understanding that, if altshadowstack is on, you have
> to use a better long jump to get out (or a normal sigreturn or _exit).

i don't understand why this would work fine when longjmp does not.
how does the shstk switch happen?

> No one is getting an altshadowstack signal handler without code
> changes.

assuming the same component is doing the alt shstk setup as the
longjmp.

> siglongjmp() could support altshadowstack with help from the kernel,
> but we probably don't want to go there.

what kind of help? maybe we need that help..

e.g. if the signal frame token is detected by longjmp on
the shstk then doing an rt_sigreturn with the right signal
frame context allows longjmp to continue unwinding the shstk.
however kernel sigcontext layout can change so userspace may
not know it so longjmp needs a helper, but only in the jump
across signal frame case.

(this is a different design than what i proposed earlier,
it also makes longjmp from alt shstk work without wrss,
the downside is that longjmp across makecontext needs a
separate solution then which implies that all shstk needs
a detectable token at the end of the shstk.. so again
something that we have to get right now and cannot add
later.)
