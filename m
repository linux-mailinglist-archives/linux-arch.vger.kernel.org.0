Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE31781FB0
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjHTU2D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjHTU2A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:28:00 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1151310F5;
        Sun, 20 Aug 2023 13:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlOpTi4CoWXadIXAkVaUadVMKzeoxk9CCZaEsDFMLhrPP9Z+zB7Xrzi7mLkb3KuLqYbnbWrBrYf8LWxA/7tX+pO3Gk5rSdL+efLIJt7mpHSn7NFn5Ahf/vPyhEYETuJj5qqs4UraQEfXRNQLbOF1ndzS349noVGU/89ET+1pVIyolmU85wx1KyneQPYppgkMo2I2NQFg2TSDHEyRMbxSfulFAkGhxLrj+OvdufXkwa9rs8kmP4Thf1zMlQz0ajXQP0qk5Iu+YVrAfHy2CT0TGJYS1rnXWK/z4WENqpiq9JYpCU1H7PRRYECsHpG7LeYDy32MJjSAAHVoxkXIEubDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w22lobcDn7Gs/aY3mo1+b3zFaMwuJGwy6dfZHLRuL/s=;
 b=lI5MBWodwgSIgtOWAX6G/iVrTduk4nrNdv9DWM12LmGZDHAFCFvWNXmfwLmZvpcG+aUDGJIV9l1onk3XFqmwUNnH2yOfEPoZM8qDdFWfwXikp6uZPvOIQMpSrYKN1AV+FwVbPCiOwNbmTf6SEznsvJ9A0EF/mpT/6nQN+1tSsasd8srwoBW6bp9F+O29FNr/93nTmjA9IoR0JKIJHyqpv11GT1E0G7/ManSHlln9oNH0iZSR0FdJ19nLuYGAtX346OFIrYb6VhGrXt/muhMRe173CiuDeeLymovmv+fo+/bZ73b0blGWJGXSmdvGWMxSf8meoXnkXQrH1SfcqAZFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w22lobcDn7Gs/aY3mo1+b3zFaMwuJGwy6dfZHLRuL/s=;
 b=O2Slpq+EDxkogBpGCNO3Mn0J3zGjyAUT9Skh5PgxgdN7cVyKT8f37Iz21isgwIetuVJ/0IbZ3WDRibuBPAz287kxg4EA3jm2hRGJp2l7Y1uaRNFXpS6WJROGxYZq424it5Wo95PMSKtiNv6/0RVuwibSUl15k0pQRc2ql/fQupU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:27:51 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:27:49 +0000
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
Subject: [PATCH v2 0/9] Support TDX guests on Hyper-V (the Hyper-V specific part)
Date:   Sun, 20 Aug 2023 13:27:06 -0700
Message-Id: <20230820202715.29006-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW4PR21MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: f926a86f-0c63-439e-75ed-08dba1bbeb33
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w6+tI+eolHlj+CkU/9f1OBaW+a9oWcwMMT9Ve9hXRCd7nbOKYx3EF5jFUQab7YB3lWZUnv7KWxFY0cp57or3ExgvX99fb/8TJ0w1fuq7kWQckhLMxAiZhmAJ48PJ6IJFeMozxXoGCgniqHl0eVBEDQrg6TyefuwWMBLPXXy8w04H3MB9FjDv8Pe+58eDOO4sHTRH0BbInzOGmcN+V7cxCQJeoaJBRJXv1W1Buv4Z5zQyOyza0YgtDEgFl18HnWIxVEZ+xE9sEbtP0jdDZjVBVRgvarkSnEbHMZOMfJisfuhfy/EuMC5t6Rs5ZARrxBr4I1XOBvzQEAKwYr1vcEqCpLIQ3rbCSwtkhkSBeihEq7NSxJ5weAnLMrjBGCh5v02V4jHorVsUXpjF9buoM0SICJO29hnv6hCosWRJe9udLseLKV+bGOXnjFlfDJ+1IxrJ7Bi7AxvGiUgPepYYMyPNOJIsqD/j/V6etfnjYEy7G/QXJWBXxoqueW0JSWyqxUpoJRCwFKKnk13vbO7FBlaF0aHjGaz96P8wBMC/gvemsTsCuPpvj9D07hdwF1a8aQmXSGjweZEltKoCDKSXz7qhcsvtquD4aJ4+ncl+FaJZTuZLycIfuPUDJX7/FgIcg7gNNmNuu10NyhVhJfVzoIr168lbY7SdWLRBUYSWTsV1JNU9gR3TmVzSSXvFiTWtHaoP/KLsoosWuwEDw3+yptSiKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(966005)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?klIwbCVon1RzlZkcU9JJFjMhkLy5X7EdkuxaAKxIMbj404MP7dUG4cu+uxUe?=
 =?us-ascii?Q?VFMJS0GudXq10a2y77NskK5NbfUanhUqEFzTWV4Iy7vuhcse1qKJj4rT4DKW?=
 =?us-ascii?Q?+NILxAR/RVuH6s9S95QT07EIRmTuQqOtqPrU2hkvwHeV0oVD5GmZdG0qCcwp?=
 =?us-ascii?Q?wZoidBXod4IFVQs0DUFxe0gYuw1deTf4ENYPeNMNOac9aVjOBU2vHsHvyrQY?=
 =?us-ascii?Q?exEuMDMOz6S0rRdQjhqJaGHu2tVlnDV2aatKBsEO7HcatkHbG+E/HkDaPnXs?=
 =?us-ascii?Q?hD/rWxX5BH8Bx1S5OOAKF3JUSvjeAjyVeQtXP98i/dlDMre6RXsxYY6GuY57?=
 =?us-ascii?Q?MqLX1k7QUfz1NuxWYbohGeQUmL1o8Huq+DKJ5n9ByI3PaWcojgw6VOwR5G40?=
 =?us-ascii?Q?TJt8Dd+QmS8a0OnMuyraWUN/GhFyeTXP6FlC5zAAQAXLQptRm2qRfpPG/i6X?=
 =?us-ascii?Q?7MTyHNe2v/IyoupQmA/t9Dl1Mi91tQNxtaDOMXmFC6q9ITi5DPTsrdZtyK5M?=
 =?us-ascii?Q?7N7vfGeLgvBFengRdSI+mCV3qr8Vzi5TXJYAwtBNN3APq0CQTMMaVEDw651Q?=
 =?us-ascii?Q?rGAO91jadhDYwI6t9mvO69pjWk9HvdIGeIJah5rodM1VMaimwkVYt4uvnPdC?=
 =?us-ascii?Q?mklhjw3/DphKZIfFPGRdCSVi9r97eWbUGMhp1yDieNTQ3TNgglqjOVxXQ6y6?=
 =?us-ascii?Q?3vsZ8dVfOio+g/pXmui++hpQeQ1Y1kJ+aJTwPQgz2H2oeeEI50SPtSOwJ5fk?=
 =?us-ascii?Q?3dqMTkrcltYzsbqC281SLAzA/KNo0lfXSCCxCTqBhX/odnajB3LAyHExcXQd?=
 =?us-ascii?Q?FcTVt+c8cnLs1f4ENpfPn7LS/EPLxSQvBrV6RFHNenrZ9u22HCf2aMl1VcZC?=
 =?us-ascii?Q?1U79HnQAcj8PxM6AOEGRo3Y9eYF1qaYc9+Wna0qJj8q6T1I0O3DessBgNSua?=
 =?us-ascii?Q?9WZGCdZFNnUMriNXhHxLhhvcXmzPRGnFXHk91yx7gNPv9HxA5xTBgvwiZOoC?=
 =?us-ascii?Q?Hib/AgY0toSjYGWUhjAeDLr3WrSd4wLqRdEA8DScYvxP+YZ2OGhIhKhkJ1zP?=
 =?us-ascii?Q?qkQZdqAHPkBCDNFbLKlnOjD0yl4nK49n5UznaRsgJwqOX6PZ12IJ1dtMCgvc?=
 =?us-ascii?Q?gwAh7xEQ58ytiLM2jRCqrSZaT2smoZyyxwDHpepPmZabVJbJZh5P5K+KpDby?=
 =?us-ascii?Q?WZMNFgyVVF0emFEmqu628LJ1M/NWdAtPyGuJa9Jtfso5OM3jWL+2gxNaTvaQ?=
 =?us-ascii?Q?EC3fiyiuiAaUVkgEXrXHET4L4lZGmtOLOpD1iDpL+VnlmvuK5HfpaSamh4fC?=
 =?us-ascii?Q?YJDr66QkfL6F5iPqL+5sRQ5qj3pz4X+P7k2JVASdPueclEdL3MAREB7RLle1?=
 =?us-ascii?Q?kKQWVWUZ+PBIVVv34ypCTwesSW5xfImM8tlXNg2OaYYCYobOWzfVOXZKMKpq?=
 =?us-ascii?Q?SpCqc5kbOsc6NaGYAAWL94XrOAWNnwLnLtGwNlVaDQwUriBIFVBiZfQCmniJ?=
 =?us-ascii?Q?mUqY605aR0n9+6jTRoEDe8kC9hIxHazkDghdZrMTuWVqPPGukz2JjsEkSWbA?=
 =?us-ascii?Q?/lYMIWQhgT1ffr8hC2eKUZlZl4ffvrkLxGrzzjKaltoGs+89+0egbtaj0ewh?=
 =?us-ascii?Q?ZUatx700GyGCbJVu0ykX93D4pHh3/h1cIVUgpQGRRwzV?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f926a86f-0c63-439e-75ed-08dba1bbeb33
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:27:48.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQkw47mdfxzFHDgW04udA/LhfLLU3N/mrsKtXo+tLdiNTf8Ifr+WclwNF8kZxNswLEDlE4MnPkdq++zAdzX8lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
the patches to Tianyu's fully enlighted SNP v7 patchset [2]. Since this
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

Compared with v1, the difference is trivial: the v2 is mainly a rebase
to Tianyu's v7.

Thanks,
Dexuan

References:
[1] Intel TDX Module v1.5 TD Partitioning Architecture Specification
[2] https://lwn.net/ml/linux-kernel/20230818102919.1318039-1-ltykernel@gmail.com/
[3] https://lwn.net/ml/linux-kernel/20230504225351.10765-1-decui@microsoft.com/
[4] https://lwn.net/ml/linux-kernel/20230811214826.9609-1-decui%40microsoft.com/
[5] https://github.com/dcui/tdx/commits/decui/mainline/x86/tdx/v10
[6] https://github.com/dcui/tdx/commits/decui/mainline/x86/hyperv/tdx-v2 

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
 arch/x86/hyperv/hv_init.c          |  59 +++++++++++---
 arch/x86/hyperv/ivm.c              | 120 ++++++++++++++++++++++++++---
 arch/x86/include/asm/hyperv-tlfs.h |   3 +-
 arch/x86/include/asm/mshyperv.h    |  42 +++++++---
 arch/x86/kernel/cpu/mshyperv.c     |  75 +++++++++++++++---
 drivers/hv/connection.c            |   2 +-
 drivers/hv/hv.c                    |  88 +++++++++++++++++----
 drivers/hv/hv_common.c             |  46 ++++++++---
 drivers/hv/hyperv_vmbus.h          |  11 +++
 include/asm-generic/mshyperv.h     |   6 +-
 11 files changed, 391 insertions(+), 76 deletions(-)

-- 
2.25.1

