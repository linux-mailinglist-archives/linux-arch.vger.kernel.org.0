Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961516C10E0
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 12:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCTLgH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 07:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCTLgG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 07:36:06 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D4812CC5;
        Mon, 20 Mar 2023 04:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/0OXfMDH/COM+KoAZ/fz1EI3SEJaMAxTnJnOj3Q0zU=;
 b=PlV0czP+uR3cQvQT98f23v007Tr1cDo4+bPEyR4xzN2LkNj/xJxb6LxLvpPxrhe6LlhJqX5lRyS8u7wsCCT0JcLc1hZ/N2Ynjk9aBgcXWOA5QNZkr32WkXeZE/BDwrArbGooVw1z0sftqXLtJfT8VYRhXQ68Ha2m+qYa1cYWPS0=
Received: from AM7PR02CA0012.eurprd02.prod.outlook.com (2603:10a6:20b:100::22)
 by AS2PR08MB8877.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:36:00 +0000
Received: from AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::3) by AM7PR02CA0012.outlook.office365.com
 (2603:10a6:20b:100::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 11:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM7EUR03FT023.mail.protection.outlook.com (100.127.140.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 11:35:59 +0000
Received: ("Tessian outbound c2bcb4c18c29:v135"); Mon, 20 Mar 2023 11:35:58 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 59d781a3f21f1164
X-CR-MTA-TID: 64aa7808
Received: from 8ba69ab46d8c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2AB943E8-1C81-415F-AB91-C776082CE881.1;
        Mon, 20 Mar 2023 11:35:51 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8ba69ab46d8c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 20 Mar 2023 11:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz5niBylGHStPf2pahMkUhjR0xSN8fApzNxWAVTyzj2CQEOVakamv5luk/3qZGhehU+KSe0BRejf3wGtvNSj/Ukj3bfaZ0ZefWCqXzuDZlZHF428D356xJbcn22mB+4vsEWnkXZvRvTOuUGb9pZ10Sduy48QpXTlqRhjTooZDD6IZ6G4hAou29nALmCFHQcZ64gfDmfyShU8lWIppqzvl5bo+4nlYV3M0MAiCbOfbWLmYuUNXGjXw/ghk0JOIkYwZsK6FBMaWg0uAankwpoXMTt6y+MgZgzUnCwtg81w99VfrgpBr/RcHVUZfkgg1eHoC46m9ou+e+9EnE3LMFE/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/0OXfMDH/COM+KoAZ/fz1EI3SEJaMAxTnJnOj3Q0zU=;
 b=g1xEMN7KBKg4bTkdcgIbs3kfRhloT6x32vxq+slNxnPqFRRNRJE+YGqd3bTCdiLQF6Rmf+9Q+/yVfWAYRmX/+ZrfsjCLN+Wtf94KyLgvxP/fgq1eg+r8oZm6xfVmuhH0TTvR7Yv1UNQ0hG9XIWGUo7M4TAzAfmUY3cHXRVdVKeH1veLj1qFVFAYxot/dSQTn0ViccpA7XDRqYsYBYP/CeK3zlBQELkWwizt4ZHYxhYFC/4+Xh554rAJdd8Pen7TgfW2tUIRFG6w1XVC/MPNlcEpHt9AaeTWo3Cxxakgykk2IjgsyOxCvt1fIrr3gAXxKLhdvlD2aNlRxi70+FrV/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/0OXfMDH/COM+KoAZ/fz1EI3SEJaMAxTnJnOj3Q0zU=;
 b=PlV0czP+uR3cQvQT98f23v007Tr1cDo4+bPEyR4xzN2LkNj/xJxb6LxLvpPxrhe6LlhJqX5lRyS8u7wsCCT0JcLc1hZ/N2Ynjk9aBgcXWOA5QNZkr32WkXeZE/BDwrArbGooVw1z0sftqXLtJfT8VYRhXQ68Ha2m+qYa1cYWPS0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB6405.eurprd08.prod.outlook.com (2603:10a6:20b:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 11:35:45 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 11:35:45 +0000
Date:   Mon, 20 Mar 2023 11:35:18 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Deepak Gupta <debug@rivosinc.com>, Mike Rapoport <rppt@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
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
        eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, nd@arm.com, al.grant@arm.com
Subject: Re: [PATCH v7 33/41] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <ZBhE9m9qTT/wKeRQ@arm.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-34-rick.p.edgecombe@intel.com>
 <ZADbP7HvyPHuwUY9@arm.com>
 <20230309185511.GA1964069@debug.ba.rivosinc.com>
 <ZBAf/QI42hcVQ4Uq@kernel.org>
 <CAKC1njTP2WAnkh3vaNGGaeOCa_uArNAatVOXxie+chR2mhA89w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKC1njTP2WAnkh3vaNGGaeOCa_uArNAatVOXxie+chR2mhA89w@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AS8PR08MB6405:EE_|AM7EUR03FT023:EE_|AS2PR08MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6fe987-d984-4d4e-be5c-08db29374764
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FzAJQbPeUprYEwEj9zaXz3NKphRZjrqfLwP4WlLI6gC39/hw6TY5D7XtVkLFzOtHP4BQj+ohFNp8asZeA83uUJnUSH4zjWatobdR972vPQXoJqhN5u1u9PoSH6WHSFp5ACH3CbpIUCGPerFwIoZKvcsQdPeDL2KjPp2vhfLNMoOWutmTemBoEgpVmmhP7lACmxbUbGLFdSMfzxK5EV/196uFa2swusNs3LoJmFxIoNxf9GwgMWYz3aGgUpA+x6sRBOLvez3rVwfDn75P8k0sUi0EStt874qM6fSmyw4viXcaSIvQDi39o132QZKW/n5rQ4sYHsdNb9gIJStn9KaB3k7P8EBy01VKdYwvoEsriBeh7nK0tfhJlM8sroD71JfZinayR4QO7YEvM6veoZBBXX8X+1wuxKVxAOmKZ0FTAbEH5JQScUolHhpFIFT6ExeX/eEM4vV0ak2ba0+78uYp4G+ECfFbvMDcwhKwhAV3hzpMSTDp41Yq+nq3bKNNNIr2iOjiGu/GjUxL2M+BYYhZqlP5O7AzrvwBM9CJw7w30Mz1Rkh/PY6jP/oTtJRlLhZNAoPYRKtBLX3on33P+VN4CPuBRTs01JBDxzb3QkRETr7uk/LhnItuxivV6CKwJt8tWUptEtN4NnHszXyMu5xcVA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199018)(44832011)(8936002)(7406005)(7416002)(5660300002)(41300700001)(86362001)(38100700002)(36756003)(2906002)(4326008)(6486002)(83380400001)(478600001)(6666004)(2616005)(186003)(54906003)(26005)(6512007)(6506007)(53546011)(66899018)(110136005)(316002)(8676002)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6405
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c31a7994-589e-4af1-baf7-08db29373e34
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqeAiQ1IV+Tz9dPVJuazJLjw2v1yDJZfVw1/vMUV2QNq3wbzrFTz7MVoqB6s9UB9dLAa+TtTjSKnTHgcNEIx6H5J6deqPPjw5TNurAoPCrsQjbvyTVGJsjMdMfZx+XhCtfTLBLtoD20pY2yQkGcnbDDQMZjNw7Tj1d3gdEOowV4WY1lKmKiWoUA1hVa1JBfNPB3yLtDMMKshulClEsV03PCXIA9Fa0i8ARJjPDW3phtQdS+BGraf6keMqjqoDOT7SxloTclTQieQyzAMz3w3pKLwyv/wM7jMvmUmGleb0hIsQxQs123zBfzPn0/+/lXbCmFnjJx8PY+btjSm9fa8m0neUZZHNLQj75UHiEsf01d0p0WHQgHph1L5TjGjktkVfoV+t0RLNsq7LgCIVq4lO07gzPD8ZgP+PHFdOXouozoNJJswF668n91IiucZAstfv+2EGA0l0xWQzfeHA4D2M/CqDe4FNk9pkvcu2jsLhpCd2EkLkIui81MLVZfrD8GCHqLqAtw0Nl4B/tWKNuDFGPg7tj2CMHXTLB5R2mQyXLsHJtjlxg7GKbttcK/WlkVnJcU6KEgbZe7clStJJJymQOHRv7Ra0Ofbf+2ztpDAHmAXLz9hKuFKhbcmi1EAVPrqF6qeDZYR1O6TwG38v0zFH0tztLiHQZLBNgZTsRQ+BTLY3S/8cvTJvQ+lIYueurWHlsNpucXheR22F7bZzlcWpw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(46966006)(40470700004)(36840700001)(186003)(6666004)(47076005)(478600001)(26005)(336012)(6486002)(83380400001)(6506007)(54906003)(6512007)(53546011)(2616005)(110136005)(450100002)(316002)(66899018)(8676002)(70586007)(70206006)(4326008)(36860700001)(8936002)(44832011)(41300700001)(5660300002)(40460700003)(82740400003)(81166007)(2906002)(356005)(40480700001)(82310400005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 11:35:59.9688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6fe987-d984-4d4e-be5c-08db29374764
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8877
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The 03/16/2023 12:30, Deepak Gupta wrote:
> On Tue, Mar 14, 2023 at 12:19 AM Mike Rapoport <rppt@kernel.org> wrote:
> > As for the userspace convenience, it is anyway required to add special
> > code for creating the shadow stack and it wouldn't matter if that code
> > would use mmap(NEW_FLAG) or map_shadow_stack().
> 
> Yes *strictly* from userspace convenience, it doesn't matter which option.

everybody seems to assume that the new syscall only matters for
the code allocating the shadow stack.

there are tools like strace, seccomp,.. that need to learn
about the new syscall and anything that's built on top of them
as well as libc api interposers like address sanitizer need to
learn about the related new libc apis (if there are any.. which
will be another long debate on the userspace side, delaying the
usability of shadow stacks even more). such tools already know
about mmap and often can handle new flags without much change.

i agree that too much special logic in mmap is not ideal and
using an mmap flag limits future extensions of both mmap and
shadow map functionality. but i disagree that a new syscall is
generally easy for userspace to deal with. in this case the
cost seems acceptable to me, but it's not free at all.

