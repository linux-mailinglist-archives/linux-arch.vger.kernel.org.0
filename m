Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3616AE611
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 17:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCGQPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Mar 2023 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCGQPE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2023 11:15:04 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C222385A;
        Tue,  7 Mar 2023 08:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4KtjZDyZlKujHLmcdWN/rS7zSpAo6XoQeFzKkVFJAc=;
 b=zO6/kS4/CK129z+xWF7Istrs6MUTijaEqknnPijNbt7oiKhYU/8Fz9QKDgD3MC70ukuyu0diRRUCAVZnyu9LghST47rs/rRUA1rb7lZZ7FXlIg0WITsDaNmi3I4yK460jBpunKSskEoBIpT0CzlkUoh0gS6Qswvp7ErycgT4eps=
Received: from DU2PR04CA0178.eurprd04.prod.outlook.com (2603:10a6:10:2b0::33)
 by PAWPR08MB9996.eurprd08.prod.outlook.com (2603:10a6:102:35a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Tue, 7 Mar
 2023 16:14:37 +0000
Received: from DBAEUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b0:cafe::7c) by DU2PR04CA0178.outlook.office365.com
 (2603:10a6:10:2b0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 16:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT018.mail.protection.outlook.com (100.127.142.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.28 via Frontend Transport; Tue, 7 Mar 2023 16:14:37 +0000
Received: ("Tessian outbound c2bcb4c18c29:v135"); Tue, 07 Mar 2023 16:14:36 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 256eb6345820ee5d
X-CR-MTA-TID: 64aa7808
Received: from f2cc540fe456.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 96E998F2-AD56-48E6-9BBA-BD17A57EB5E1.1;
        Tue, 07 Mar 2023 16:14:29 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f2cc540fe456.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Mar 2023 16:14:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NotXR3ZRN/Sh3ulSeVcEyzB/x9Gl5grT/tODXVvhh06rCcNCA2l7zbuTsPSf11gaLGf0+xyr9Ne/oCvXZKQY3i16S1ibPE50yEOxRNXM52hwL5gp/8Hrf6J4WC1hyYbs6DKXrkxOTO+IsGWhb3hO2aRFlK5WgidnpnJP5rbZEGPultmBT/eLvXaftnDrKtCWZj2sWqUQgZYZqPBoqEfoNvkg4RTzVcZBqTFFiUHp2nw+Kwj3Y4Oy6cpYW+J9pXfvYLaN6IoPd/z6pRHCQY+s4mo3c5PZYAeHrNs3NWcUDvZvizPhKpNwwz0YSGtBaLun2Z8s0MIsVbojdCts6lfERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4KtjZDyZlKujHLmcdWN/rS7zSpAo6XoQeFzKkVFJAc=;
 b=ZH7NPDSeTF1/5nwwghUBc054qaBMBzGJuQAtwx5g21VOvGyN8tFvciieIYP/9t49RUvnr7ds67SOrturi9FLIk7lQizgd1QOLGu00FNFnheUEQLdKHfN5Dk6KWISQLL5frvVjh7BEHgFnzKcMTbTSnaokIWilXDhi4TYj+RX+DvJ/lnoo0x2tmFqYSZPQ1tcu+ML2YBIxf7oWhMz1ZssS4Kqr25PWBL7i7IHeH69qvpmvY00hraVKvaMRIWGc9MPSuci8dbnZOJOgf3dPbTFn7TWcjmZKljX1TBGQvgWX7pJU+DPrDkkA8oBcOac1TTNMEuIUvhTqy93mNzq2EKOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4KtjZDyZlKujHLmcdWN/rS7zSpAo6XoQeFzKkVFJAc=;
 b=zO6/kS4/CK129z+xWF7Istrs6MUTijaEqknnPijNbt7oiKhYU/8Fz9QKDgD3MC70ukuyu0diRRUCAVZnyu9LghST47rs/rRUA1rb7lZZ7FXlIg0WITsDaNmi3I4yK460jBpunKSskEoBIpT0CzlkUoh0gS6Qswvp7ErycgT4eps=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS2PR08MB8748.eurprd08.prod.outlook.com (2603:10a6:20b:544::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 16:14:26 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 16:14:26 +0000
Date:   Tue, 7 Mar 2023 16:14:09 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
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
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>, "nd@arm.com" <nd@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 01/41] Documentation/x86: Add CET shadow stack
 description
Message-ID: <ZAdi0dc+6Jmq36Mn@arm.com>
References: <Y/9fdYQ8Cd0GI+8C@arm.com>
 <636de4a28a42a082f182e940fbd8e63ea23895cc.camel@intel.com>
 <df8ef3a9e5139655a223589c16a68393ab3f6d1d.camel@intel.com>
 <ZADQISkczejfgdoS@arm.com>
 <9714f724b53b04fdf69302c6850885f5dfbf3af5.camel@intel.com>
 <ZAYS6CHuZ0MiFvmE@arm.com>
 <87wn3tsuxf.fsf@oldenburg.str.redhat.com>
 <a205aed2171a0a463e3bb7179e8dd63bd4012e7e.camel@intel.com>
 <ZAc2LQEfvRLCknQQ@arm.com>
 <87ilfcoe59.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ilfcoe59.fsf@oldenburg.str.redhat.com>
X-ClientProxiedBy: LO4P302CA0006.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::12) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS2PR08MB8748:EE_|DBAEUR03FT018:EE_|PAWPR08MB9996:EE_
X-MS-Office365-Filtering-Correlation-Id: 15acc6e2-902d-4032-cc33-08db1f270c23
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ZoGkrQKyiHlpR6HILptdzrXZOvO6wBpB4iPjAKzfaEk4OkzFmWydJrWpdwuuAe0jGELcEp5S3cZNzO3ZVo7fZV2ZWXGMs6IsAVvNh6sa9idPTqT3XabBUTF3CmTdGahwJE72Fo9ia4JS3pThmK2Jebt7gI1+18LXHfZNGYpk6N5A2OSF7y9AC6MMd/aVyw8a4uoaxcd4oZ03t9WWTnSpyOkTDC4mz6/Kq5UkALik29YMJ/7JFB2HjT+AUyr86UelBzWtpg/enh4FlWPuAEqgxF8HW+RxP2gvvCOwKZ8KH1gMGlzD1wErlCeuG4j65W3Pi2q9iCI9KoAjdIYLCaJw8YSgT4hQ2YBUwESMQd0u5vrdl8ipLn010BWUaJm3N4UfYOFE/RoJ0CVZ7i3Sr8/KfqWLVJULe17a70FJgW2pE75h7uU3l3A4GF9+sIMSwGFdHTUAn5bM2B3sNRrzdKBsmtfwktoBiIpB9odKhnDxELdj/iTQ9DdvUw1/ApwTWtFoX7Fd3r0yQGL7R1JUbwjQqNkM0lqvp7bEnBqDiik5v42l6HaRIYa56vny2dP+Xm408RUk2EPmLSHXHYHAheoL6ew5OJ+pRc7C0qzWGU3BSizCHR/NvyskDZAVWiB8CKJ1RW2ZPQWr2SaxoLSDdPs3dFCVRAPqpSajTzZ9NNMCg+SWtGXFZZtu7enJqvaq1jKS
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199018)(38100700002)(86362001)(8936002)(66946007)(36756003)(44832011)(7406005)(7416002)(2906002)(5660300002)(6916009)(4326008)(8676002)(66556008)(41300700001)(66476007)(186003)(26005)(83380400001)(2616005)(316002)(478600001)(6506007)(6512007)(54906003)(6486002)(6666004)(66899018)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8748
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 981bc13e-6a83-4eb4-b9e6-08db1f270547
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kbj7XkX55rflYWRArwwhq+3k+i9T4+O+V8IKHEnujqhcQBl+L60zprP3z4joltGkjsn7l3Qw4eFsRHuH2jolv3w7u5gH5VF+IgWBdW0+im216MKnaXgfyCe0wMGYAU3iwHpHG8oDVk4+p8BK/fo4ZkgeOvRD64h88py+XD50LX3JEKVd9kJBFIOwTJCU7dj9izY3vW5d0KKX+jQumA8t55th5aH28KL8exgOMhuPFCprobJh54OdRPvWrFWrqq+PTuURJI4pIlFT05lHscmsaa9aCVll1ttP//rGrK4kSQO2agAmHCzzy4m8gKEslneB61kQXmoapVR1XTN/S2cPOIzdXpMYrfVTYYqGF3xu6A92ywsC7UBeFB5NN0i4LmlTEVXP2fRYKzU6tmdoUqTS18Q3MffN9NEhW0uNFaOgdG1effP+hI2MNp/ZTjjwnw2YkyQo/4Hoj9jjrr+S5HTyQFv/59lkT71cdo7AU0yNIrUKVubsb36FoSRKs3hHkt6Gib+gmf350j53zDEOJ0YVY8U+qHc8Yj1DdNuVOE1Z/IRRVL/hYZbSRbq+3qJb5x7k4hYXmvk42jkKUvCn1tNz+aFzdC8SgzQcP7tAHgWf3sXv5WaIFBXbVZsiurV88up9P2w13OTaPx1Qd4AM0+wbNCb6Mme/2crdOoCJonDMiaH7ymSEy6iaXYsfQNfCm+lG7jYGQmCKW4dMLJjGE4Ngi6aacrzuraxz9AlHx82RA5Q=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(66899018)(82310400005)(36860700001)(82740400003)(47076005)(83380400001)(36756003)(107886003)(478600001)(81166007)(54906003)(316002)(356005)(5660300002)(336012)(6512007)(6486002)(2616005)(6666004)(40460700003)(41300700001)(26005)(186003)(6506007)(450100002)(44832011)(2906002)(6862004)(70586007)(70206006)(8936002)(4326008)(40480700001)(8676002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 16:14:37.0759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15acc6e2-902d-4032-cc33-08db1f270c23
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9996
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/07/2023 15:00, Florian Weimer wrote:
> * szabolcs:
> 
> > changing/disabling the alt stack is not valid while a handler is
> > executing on it. if we don't allow jumping out and back to an
> > alt stack (swapcontext) then there can be only one alt stack
> > live per thread and change/disable can do the shadow stack free.
> >
> > if jump back is allowed (linux even makes it race-free with
> > SS_AUTODISARM) then the life-time of alt stack is extended
> > beyond change/disable (jump back to an unregistered alt stack).
> >
> > to support jump back to an alt stack the requirements are
> >
> > 1) user has to manage an alt shadow stack together with the alt
> >    stack (requies user code change, not just libc).
> >
> > 2) kernel has to push a restore token on the thread shadow stack
> >    on signal entry (at least in case of alt shadow stack, and
> >    deal with corner cases around shadow stack overflow).
> 
> We need to have a story for stackful coroutine switching as well, not
> just for sigaltstack.  I hope that we can use OpenJDK (Project Loom) and
> QEMU as guinea pigs.  If we have something that works for both,
> hopefully that covers a broad range of scenarios.  Userspace
> coordination can eventually be handled by glibc; we can deallocate
> alternate stacks on thread exit fairly easily (at least compared to the
> current stack 8-).

for stackful coroutines we just need a way to

- allocate a shadow stack with a restore token on it.

- switch to a target shadow stack with a restore token on it,
  while leaving behind a restore token on the old shadow stack.

this is supported via map_shadow_stack syscall and the
rstoressp, saveprevssp instruction pair.

otoh there can be many alt shadow stacks per thread alive if
we allow jump back (only one of them registered at a time) in
fact they can be jumped to even from another thread, so their
life-time is not tied to the thread (at least if we allow
swapcontext across threads) so i think the libc cannot manage
the alt shadow stacks, only user code can in the general case.

and in case a signal runs on an alt shadow stack, the restore
token can only be placed by the kernel on the old shadow stack.

thanks.
