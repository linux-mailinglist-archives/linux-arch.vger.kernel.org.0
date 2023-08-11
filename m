Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2BE779A8F
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjHKWTl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjHKWTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:40 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5B42112;
        Fri, 11 Aug 2023 15:19:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/t/WdYcyXYFdc6n2CVWAcWC3SkImUgG/gleyX2qng4aUFzr3IIzPmNvMBPFCUCIOtvKmGM2YugabFEEVExfYNsHBuqmZm+szMJFTFF1g22JDAltv1Baluz9mxTrHbqEhs3N67ZoC1bbt6n1tjWiFDkNxhsRRMzYNtrkFGQqHnmaBBRGwaR0yGPy8yjQdZDwHa6vakykVx7xjHiVSTlMEjOLpHIM8QcjRFCIPKj4AxgSGt7XwrWe587rR1onpgzuS2TZ3lXQz4543ekUDrUKYrHQMfmwu55dkWuqO+gybNWShLusvitJ73ToeZ0ut67KpiWnV2etDGfznaMvlgAlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJcEMEhvZCM18ooBD0zrMhr3m6gDTRJD2jcXR46eemc=;
 b=YFRksvvNrmXHOZZRMileocpGkj+5Wbp6OaZR7Vd2wjup+LfDwgSOrwFu5WES6prdEguNMJeswVkiYJws08qucs82Ix2INauBnbpncBkobT7jiPRzlM+eA3HMXyOTGwmTFRpAk/Ru0IZZc2mwHl1PLBtXWblVxwosPJu8GTzgLkDELJJFrEuKdeYaLM3PCA7oVAy7opjbSiGRPJ5BhtDU2PvyMewHXOA3EXmhL45TfJwWYQqtFtnZfGHMQd//hmDEC/AIbYXp+rHjO1aMy1p5120tuKAqq6hWUXPDRj4jzOroBBApSIxqOG7ThG8hjaz5eS2V5vri3zcHnbJf+5Zu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJcEMEhvZCM18ooBD0zrMhr3m6gDTRJD2jcXR46eemc=;
 b=Akdzc0E4xblF9ZnyTUfv/nijeGMU/c6ccvSQAcOScnz2vdSbYxjoMgQTXOWpLeGF4UalBNhzJZ/l/0vQ0lDd9CJ246p6Xv/QFRV3b7GIpHU2tQl3Fu1mlwC6YjNr/Hot8pRE+BP9TBT85sp31Fc88yMy9frL9HBb8AP/iH0bLLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:36 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:35 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 0/9] Support TDX guests on Hyper-V (the Hyper-V specific part)
Date:   Fri, 11 Aug 2023 15:18:42 -0700
Message-Id: <20230811221851.10244-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To MW2PR2101MB1099.namprd21.prod.outlook.com
 (2603:10b6:302:4::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1099:EE_|DM4PR21MB3417:EE_
X-MS-Office365-Filtering-Correlation-Id: 7418f24c-2ebf-481e-7c1d-08db9ab90b28
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9kF6FZl+PxMOP53NTMMSO+7UoosGe8msepJFwMmExr7SARnUvvB/bjlonoN0vC0kLGbngWwhsEZ2PQHmtBdGpu4Peu3v25Sh40aHMasAjB9jG4FTAzxixkRIAJOtuBIdmiPyCa1d0hMszlAGVfsyzIgU2oC+s+4BOQEK+G7kIbubj4X/rSqWsnBfLbRb+asbQEY786RjrgIX2vwdgKR/SdBrSltM6WsJNeO4jHG9d+DNzrixgQM5TTpDaiqYlBNga+8W0XpokeNWcgL1uVJf92G01kz3HKbJ+xVnW/M4Zw4s1XEuqxRo1Crm7/uM57gIQLTDE51mEvIDN42SQwhud0zBy7piHFE18ysuhy9XYC29YrYGVGiWYEfqudYoNyb+TzPCvQTQDMzygiP/l6bynjoJsESorerVGJn3V1mink11unpfKYcThwwtrcZnYSJHE/vE1av3rxUL4QQn6fjAJsMVsnLEfosCbtUQf29LqPf2C4Yfe7annVZEaMtVNPasuId9sQbieHrjZzyIgpy954/gVOdwo6mYCSlg0UwoepmpEYrZgQizP6LgcG5LdJ3tNSm+XSuSbQUdjuj2RPGExp599/pBJRu6Y8MZy2voiylfK11O3D+1T9sDTvvPogHPCIJRp7rN/QYezbZfMlX8xBL2v5hZzWolakRp44SDvIZFGFbXvn38JWgRYzsjfqV5y2z6JuNjWnsFEXZpCUU+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(966005)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enXgVZGL6R+Wyu+gcOmPMpodHFOrC4V2O+puTQPp7grTNMXkbLJ5COTG3M5h?=
 =?us-ascii?Q?8xJBQ66ZXzgtV5EPSLXz308MzhRN9MSXKZy9GEEY7djAOHWGvTxAMW8XkCfD?=
 =?us-ascii?Q?fPxCDAoBLnB92edLNv9V+ITPIppjzZisgJ6P+//4EuAajEsLVewYQdPIMV2s?=
 =?us-ascii?Q?o5tpjarnWQreuDPfk5aTYtonfn+fsVa1ei+MRVrewBd6O+TIjh9+kGPR7oLb?=
 =?us-ascii?Q?v+TvouhKyNOY0GkggoC5Z4ohB0LCm27agUjZZfDIkzFHdLNrEbcKZIIv1W8Q?=
 =?us-ascii?Q?hVLHlvy5FAk8w8Ljlhz6XA0V/T+9gtmSuQqrtqKJ/jToSYM6ljGaU8YF5sHz?=
 =?us-ascii?Q?2m3xIgZiUs4IOW/7NpE7lQbvfheJiRv+ArbzgBq8Ac1g/txVyLvk9Ne9YVbH?=
 =?us-ascii?Q?uRwRBbr0ZgvHGAEFYJ2gdsrz9U3huxeGnP+S83iLD98922V8FiWYP5lK8+w/?=
 =?us-ascii?Q?C4pRywVfg4i8iWCRunHM+zLzPx5DymrHtn6GC09BlR4BsIKKp3FN5k1kpTIU?=
 =?us-ascii?Q?ztEmezWgWP3aDfoD5FteTkO90tuTuvjwh7T5hIP0rKFuLd0U1qPQp4TpP1le?=
 =?us-ascii?Q?SHfVvj3KL+vCr3e6hvzRlWjWSEK1hphVeeC0u0M+Q33EOIjkUsEIfsdC8so5?=
 =?us-ascii?Q?7QMnOwHyX6L9uvOd10ruqyu/obwgRl+yQXKTuZt47w5yX4CKTtSA7vNFPGRC?=
 =?us-ascii?Q?z9YRfP0A1YSCLpFR0sQq43blOPJM9nTi4jiGpF+UOy425mX8Ru9TxFyG5TtK?=
 =?us-ascii?Q?+5SOK89aIB6moRsodN/ch/hGM2NmWYaCp0RXJqf8dgwKqKyZ0UauO+TzpYXQ?=
 =?us-ascii?Q?DF0oL+we2nIplvvEK8MllazFyjl6sf0/tWjWrCc2PbWvTN2k2SzaMPxLP94y?=
 =?us-ascii?Q?8tCViUS/sNC+fgpoZ16Wev/Weq/EREaN7iessnWfL8tJ/+Ihnnqv8u2tc+Az?=
 =?us-ascii?Q?ojw1X4Bbtbb+f1MBdCCIxG2gL4WY/1Fi7tOUpGVNcfAIvgb1Phl9tfCmXloV?=
 =?us-ascii?Q?IW/SRV9mvL7Vty/U8f/LorP+R6/eVX1ujFuaAqQcGaH1F7Y7yUUzioXkTM4N?=
 =?us-ascii?Q?AJRY4usHwqXDS5qUzkXkI1EMtmd/PfMwMYeGzyhb2VjJTHijAL/6R87sBUhZ?=
 =?us-ascii?Q?UCbml0d8SOTQDI7cbRPMhZJTpkkP9du1XaLh9LmHeWo8gr5S1Yd2SLZba0+7?=
 =?us-ascii?Q?TEFIvdD/x06/s66+1bKeU6yW01Lv21XreQhmGNUwAl1aStEoVNl9zSjcSOma?=
 =?us-ascii?Q?0pFhXbI8uNvoOsEto8hZelH5sv/tPz+1oKV2g85r6iSuTX+x+VoSlWCPIGqm?=
 =?us-ascii?Q?Wcvx023NR6YYMJQEsjL3UW6fmlOfPx+DrdxK6Q/5K67lI1ioRGPH98NEnr/s?=
 =?us-ascii?Q?cjiaMhuEuDIEwkXun7BtlM6VwmVtWWQ02LUaNRO7JFtCNYiMNTYnj3hiX61/?=
 =?us-ascii?Q?wQtkcTNC5PIT5TB4GzyX+4uhz6CXehweCWVEiyywsAlhh6LKRZsJ3lQiczMe?=
 =?us-ascii?Q?oadBbDLbKKVO4BTp83AXCwQkzr9aolMHorfuSuEzWDdQmo5LaYYKQFzuzkVq?=
 =?us-ascii?Q?2hdMb5u1dTChYrYQCXhzwzXJfC9eMq4X+hjEbtkQTU/wN47qwtXi11JoOlgJ?=
 =?us-ascii?Q?oXgeqHkRb9Fp87e0/i4I9oEHU+nlQwOHnIMCRxHjTO2C?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7418f24c-2ebf-481e-7c1d-08db9ab90b28
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:35.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/qrrrcPpGBMoy2/wOaEGEHPuoD9ubKCPjh1t3U8sykQVlQjzDWUCczyLZxcFXm7QHUcsKWFQf1vEealxEOe8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3417
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hyper-V provides two modes for running Intel TDX VMs:

1) TD Partitioning mode with a paravisor (see [1]).
2) In "fully enlightened" mode with normal TDX shared bit control
   over page encryption, and no paravisor

The first mode is similar to AMD SEV-SNP's vTOM mode (see [2]).
The second is similar to AMD SEV-SNP's C-bit mode(see [2]).

For #2, the v6 patchset was [3], which is later split into 2 parts:
the generic TDX part (see [4][5]), and the Hyper-V specific part, i.e.
the first 5 patches of this patchset. For the second part, I rebased
the patches to Tianyu's fully enlighted SNP v5 patchset [2]. Since this
is a straightforward rebasing, I keep the existing Acked-by and
Reviewed-by in the v6 patchset [3].

The next 3 patches of this patchset add the support for #1.

The last patch (the 9th patch) just makes some cleanup.

Please review all the 9 patches, which are also on my github
branch [6].

I tested the patches for a regular VM, a VBS VM, a SNP VM
with the paravisor, and a TDX VM with the paravisor and a TDX
VM without the paravisor, and an ARM64 VM. All the VMs worked
as expected.

If the patches all look good, I expect that Tianyu's patches [2]
are merged into the Hyper-V tree's hyperv-next branch first, then
these 9 patches can be merged afterwards.

Note: Tianyu will post v6, and I expect that the 9 patches can
still apply atop Tianyu's v6 -- if not, I'll post a new version.

Thanks,
Dexuan

References:
[1] Intel TDX Module v1.5 TD Partitioning Architecture Specification
[2] https://lwn.net/ml/linux-kernel/20230810160412.820246-1-ltykernel%40gmail.com/
[3] https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/
[4] https://lwn.net/ml/linux-kernel/20230811214826.9609-1-decui%40microsoft.com/
[5] https://github.com/dcui/tdx/commits/decui/mainline/x86/tdx/v10
[6] https://github.com/dcui/tdx/commits/decui/mainline/x86/hyperv/tdx

Dexuan Cui (9):
  x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
  x86/hyperv: Support hypercalls for fully enlightened TDX guests
  Drivers: hv: vmbus: Support fully enlightened TDX guests
  x86/hyperv: Fix serial console interrupts for fully enlightened TDX
    guests
  Drivers: hv: vmbus: Support >64 VPs for a fully enlightened TDX/SNP VM
  x86/hyperv: Introduce a global variable hyperv_paravisor_present
  Drivers: hv: vmbus: Bring the post_msg_page back for TDX VMs with the
    paravisor
  x86/hyperv: Use TDX GHCI to access some MSRs in a TDX VM with the
    paravisor
  x86/hyperv: Remove hv_isolation_type_en_snp

 arch/x86/hyperv/hv_apic.c          |  15 +++-
 arch/x86/hyperv/hv_init.c          |  53 ++++++++++---
 arch/x86/hyperv/ivm.c              | 120 ++++++++++++++++++++++++++---
 arch/x86/include/asm/hyperv-tlfs.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  29 ++++++-
 arch/x86/kernel/cpu/mshyperv.c     |  72 ++++++++++++++---
 drivers/hv/connection.c            |   2 +-
 drivers/hv/hv.c                    |  88 +++++++++++++++++----
 drivers/hv/hv_common.c             |  46 ++++++++---
 drivers/hv/hyperv_vmbus.h          |  11 +++
 include/asm-generic/mshyperv.h     |   3 +
 11 files changed, 379 insertions(+), 63 deletions(-)

-- 
2.25.1

