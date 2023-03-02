Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C56A87F8
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 18:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCBRfz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 12:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCBRfy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 12:35:54 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D105A16AC1;
        Thu,  2 Mar 2023 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZxst8M5C7DdL/kU7LhPi9LvQSZLihKjPf4whJMg8SU=;
 b=Ib/1m531NorcKNq4phRYbnkLOZwazSyRRm/4NyxZ66Oi4IB++ZR2OpXxxAoz4C4X16yYAXNUA/8ixOcv+gy0cybK0nqxSdeSLqfSKh0ZZUj8dXEIazFOiAtDZhpgRPqSsvkNiZCfu3BHEfE/Zg8TuzTvFfitiyehcYWjkTNI1+E=
Received: from DB8PR09CA0006.eurprd09.prod.outlook.com (2603:10a6:10:a0::19)
 by DB4PR08MB9215.eurprd08.prod.outlook.com (2603:10a6:10:3f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 17:35:13 +0000
Received: from DBAEUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::d8) by DB8PR09CA0006.outlook.office365.com
 (2603:10a6:10:a0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 17:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT034.mail.protection.outlook.com (100.127.142.97) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 17:35:13 +0000
Received: ("Tessian outbound 55ffa3012b8f:v135"); Thu, 02 Mar 2023 17:35:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 087dc406b1087843
X-CR-MTA-TID: 64aa7808
Received: from ea16d2d9266e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 22678EB6-7A56-4017-BBF4-0F79C7469A93.1;
        Thu, 02 Mar 2023 17:35:01 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ea16d2d9266e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 02 Mar 2023 17:35:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DP2xOA6uA8QHx6Itqmi4yN1S0OVMGnUbtPuQptQq7T9GZF/I7/1y4y3ffVum7+38pSDrwUpkMzLJLTRBUzSMldoba65yVay5u7hnIyvsaZ12FHhwCUR5uZdhdDT/Gz5IPX7lA2hz8Us/QId1g4GH2oIrRhTqMXN179vu3HKvudaDWQVZuXA38PovZ/iMvaouSD1iaJab3pQMAVwVbdHvISbrMl7MJKr2GH3ZdQp2RUHaMHAw9YN828ioHMGjCVD6RrOLgqY8pB1DRboz9pTWle90n7cfsFfQBvEhcGvU/OYLciR7dBdZQHBFkjSXTv3nMNwWjbIEhjzZFg1wVwVd7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZxst8M5C7DdL/kU7LhPi9LvQSZLihKjPf4whJMg8SU=;
 b=ZfEmUFMBR2UbGlMv0T/KAKF/S5Xut9HaqFJav61Gnhym77NBmX52K2FQHT5i+8eKy7Bam3UQEZ0dvXT53CWh6jwbzyscfPKmTjM05kdGsfbRAV71oZqZEkZ1S8flnlo/tDcrqLv+111ZsPQvocHJ8KgRFF2kyW9hFjQ5O/Xnqe8r+3K77b2RQHLzQGIIQ6Ewh1E3ftCNLUcxjsjtZZhTcPPPWDAMj6r85UHqJ4S0VBabhf3CvbpJRBd0D8/cfBZCKiChwOTq2XPz0VOdDz4GhnriNVwxyxJdsbSHgLWh6h69cuvDiPPpyUD58HR+8T5mq7TooC1y3LQB36rHqwMG8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZxst8M5C7DdL/kU7LhPi9LvQSZLihKjPf4whJMg8SU=;
 b=Ib/1m531NorcKNq4phRYbnkLOZwazSyRRm/4NyxZ66Oi4IB++ZR2OpXxxAoz4C4X16yYAXNUA/8ixOcv+gy0cybK0nqxSdeSLqfSKh0ZZUj8dXEIazFOiAtDZhpgRPqSsvkNiZCfu3BHEfE/Zg8TuzTvFfitiyehcYWjkTNI1+E=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AM8PR08MB6627.eurprd08.prod.outlook.com (2603:10a6:20b:368::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 17:34:56 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::e3d1:5a4:db0c:43cc%6]) with mapi id 15.20.6134.027; Thu, 2 Mar 2023
 17:34:56 +0000
Date:   Thu, 2 Mar 2023 17:34:40 +0000
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
        david@redhat.com, debug@rivosinc.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, nd@arm.com, al.grant@arm.com
Subject: Re: [PATCH v7 30/41] x86/shstk: Handle thread shadow stack
Message-ID: <ZADeMDFETi7bfcz+@arm.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-31-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230227222957.24501-31-rick.p.edgecombe@intel.com>
X-ClientProxiedBy: LO4P123CA0212.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::19) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR08MB7179:EE_|AM8PR08MB6627:EE_|DBAEUR03FT034:EE_|DB4PR08MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: 86df1c8b-8658-4320-c489-08db1b447ab4
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PA/jQEX62PRhY1JLUBJ+b4SDv5jnOV2P+T9T+WP5QRS1KyXmRUXsrbiajXFDDGWFD4m+ZX7F5gGlPcKeVKGwRhq5P7eEbeKi8GDQ2kg8IgNDNd0zSGvnf20CSk74171YEISYNjnCCM2xkB5l0VncTvPV2j9DuAB4OxEBcklJnhyodNNE+kJIeVvBnd5BP6P4YhzzzRThViWN6BtCNfzgMSQZ75pa5D173eyiRc8bTvMSkishEm2+UBsMhcKqz692e+X7pe6h56OS1XOrToiRJrFM0GC6odu1nRYyMcOy1runq2A1JvqT25MrQUIadySa+WX4AxIxlH9FG8pxCVKKAuTyEVsAnS6bWmwtWsx0na1bJVHjjm8CZB7AzuxDXUQDMaAyJDJDb/KvG1xcKIwGq0cOUU99iMWBQn7sDUhm3ZINNeZDDEbYZgOjsJaaWQCAmVY41RIcri+587paP1sXQIvkGLlCcZlJRtVoSz78cniVvVacTkyAgov2OMRS2UiqCAsXbULDSItFI4E2vcfc6Q5xAn+f2LRpabrTJKt2lf0zxUaIFrrl35R+isVX4n/+SRt3hZhLNjswuv8OB0+p7yQ1QKmph4DwDUqE1N4HX1BNWKbc13Fjzji4YzpREKTpRyDAXask4QKCcl3iWlJZFAN/fVfuw6eUC3j7ffE58Z2qA9BorPnmeo41csKb5bN4
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(451199018)(36756003)(6666004)(6486002)(6512007)(6506007)(186003)(26005)(2616005)(41300700001)(110136005)(316002)(4326008)(66556008)(44832011)(2906002)(8676002)(66476007)(7406005)(5660300002)(478600001)(7416002)(8936002)(38100700002)(86362001)(921005)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6627
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3addd604-2708-4e02-3290-08db1b44701b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: munOdyvh9RDvz3/Om/5VAGPqcF0F5I3qclIj4imxII9CgRNV4a9WuGMtKY2rGrWiEQsjqLvKTnkkMj4m+G2DXfcfTuxJhpmXuWS2eLGvOzQAhBaFVVj1eZNAqIuYxgw1DBYPcariYcHLPMhnEcnhLpyXCVovf+WHDGyPc3QjsO4eqThv24+vU2FlYJEYkKTQ2Bu4B7q4xPUZYpJbmc/xdzDpkdvbgMfB9gTm76V+HfGMi3n3DtNrMvI3JgBIz268qIAiHJ0gVQ1bzV75P8yykJtBzGGOo1bbx8x/ICT8N3UpI0R/4FZlk4qoSrQeTR/YpvO3mCcmBS4sfyYt/PpoUqfCc/ME0sDq7CNQ19no9cUEt0H9HoeXWBx7iQkVtbzPE/CD0wzYY9IJXQhL/r34oKCSKSqtcmNn4uNqXG6boOQUp39tk7GA63n5Xz660gkHIEAUYWNKSF2dsAr7Bf9ak5yfN8rWYluMDgDL+19iII/usj4y7SNrpTDK9+NeFsg43ai1QWl6Fa72djyFQHLDYoNtQP3PgvyQsbDOxR1ASapevhstLJ1mV/mo8HYPYxcyNeGoVPS5dGOlodfuhKYneAp3rSsva167wt0z7o/QeofJ/OANv33g8VQJrh3AKfuVvyrc1wbRgDySXPjAOwhw1un/MHcExJQZ4gi0kmViBPm6/Fbii+M/+1TO2ctQum6shs87PfPNoGgwW4cOxncUBCFC+mNjwa56fhNsLI/iEzM=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(336012)(83380400001)(478600001)(110136005)(316002)(47076005)(36756003)(82740400003)(81166007)(4326008)(36860700001)(8676002)(6506007)(2616005)(186003)(6666004)(40460700003)(6486002)(450100002)(70206006)(5660300002)(6512007)(40480700001)(70586007)(44832011)(8936002)(26005)(86362001)(41300700001)(2906002)(921005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:35:13.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86df1c8b-8658-4320-c489-08db1b447ab4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9215
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
> For shadow stack enabled vfork(), the parent and child can share the same
> shadow stack, like they can share a normal stack. Since the parent is
> suspended until the child terminates, the child will not interfere with
> the parent while executing as long as it doesn't return from the vfork()
> and overwrite up the shadow stack. The child can safely overwrite down
> the shadow stack, as the parent can just overwrite this later. So CET does
> not add any additional limitations for vfork().
> 
> Userspace implementing posix vfork() can actually prevent the child from
> returning from the vfork() calling function, using CET. Glibc does this
> by adjusting the shadow stack pointer in the child, so that the child
> receives a #CP if it tries to return from vfork() calling function.

this commit message implies there is protection against
the vfork child clobbering the parent's shadow stack,
but actually the child can INCSSP (or longjmp) and then
clobber it.

so the glibc code just tries to catch bugs and accidents
not a strong security mechanism. i'd skip this paragraph.
