Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F71738FD5
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 21:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjFUTOx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjFUTO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 15:14:27 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626651FD2;
        Wed, 21 Jun 2023 12:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRfertxwGGTgE3YtGWvHtM0/6LsFV23e0co2ZNRVFBfii5Xb3cR0ov8wpUCZMPvlV6KHDB8Lr76iE7V2kkoReOsBCg/csOg9nrjZ4sjtQdNbe0vTWC3QqzGFVM9xbSsG4f7pkmLSnEfMHLrthUOlM/IuqwUQSAldl1lHMvXRFHIaREdlqtDpY8lX2oHh8SH8vysxfnSunm6Z0FXs5T6ifsxyH3HRQ6P1HyqhtKlU/DioBuXDD30UavcsB60XF4aNWcQYOWHRx84IlS7CUuEV06qjLrOriL2ur6l8dHyf4mKhzJlGfhRdY50QrydTFSssZBpupwcT2IBZdpBqnHVCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MsDwaOwi/CgW6Yr7aTJR5hfbE35O5E4fDtBHbmSzLM=;
 b=F9z9XC9j1Es0xUCk8KHkG2RAya12XDr5JIlDNjkyjkkOVsLvNBck/7PwmORKl0SFJ76+9b+tx+OU1ZMD9spuw5hyOS2AW7eNnSTNQZpssYDZ8K52YoqyOLb+2NeI8+cYsJ0zhIQTJPn4knMPZnPbSXs4isnEDPgkpJ4TfkXJeRTXw7wC9owc3yF4leiJ+1ZHovDNfFpHxuQFqgQXHy1OqRbtDmtoJg6I491H1NGzrIVYIHbC1XLXrjEHKX9aQrkuvuKEbKzOrcbGUVNVRm+R1JGULoa1wD/WaYPlfdNz//C8UmIRfm/w7fEKZO71nY7anv8Kgj41XTDKMMJtoecqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MsDwaOwi/CgW6Yr7aTJR5hfbE35O5E4fDtBHbmSzLM=;
 b=D7w7yn7V84PqMW8YRmeBl0IDbXY8sNkVXMzUvUGntgsOsJMpcRtcWRsElfsZP7tfo7CyYIPcwYyLzE1cDYRfd58ASTeqvasQaVb2DH47nhWxWz6WcWNiVjSk0P9Mbtm3oyt1dJuU+j4oaFvXFZGCyogki6PrlbWAB91hLvmRLgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW6PR21MB4009.namprd21.prod.outlook.com
 (2603:10b6:303:23f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.11; Wed, 21 Jun
 2023 19:13:56 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6544.008; Wed, 21 Jun 2023
 19:13:56 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v9 2/2] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Wed, 21 Jun 2023 12:13:17 -0700
Message-Id: <20230621191317.4129-3-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621191317.4129-1-decui@microsoft.com>
References: <20230621191317.4129-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:930:18::34) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW6PR21MB4009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d2cde4b-9ac2-43d2-d9c5-08db728ba90f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKAS1oQ0cig8LvQ53SsPDTtVRK8EiDWPjlDcli2S1eKzl9jaCNlJoi+5egQXHxIAhF/PRCNPO7rn+ZqOwR0rRqpGux2icp3N+iFfqGbLyRToGMnFifk2FWvBEvfcJRxIfujSZ/K9xnP290mp2q6LDfLNJHMnf4bAxVyudzkOEGbGQEnJQOTRwmcsxVCKXdDvTe90tCVwcKTCKEDlrLTv/ZMOflncTNQ71xm/KkLyH4KtZkdtywQSfLb8KHlvG+c7UtIvFsEssDFWDDT9ElBn8njtkiYEXIfJIL7/nSjnWMViAc+k2iM+XWQJaxExXAT2DcsvTNN+yfPJZaN5J+8KT1YVM0uEi4nSCq+q/t8B+1lLZby31eZEddMonvS1hYQK8t8aVYjLP/7uO4IaVLozF90eMna/EwKJ7WtbjOSUlCgl1OZPfYdraVgPie6rqm/aEpyBQg4kNQKbfBURkDTVCIbrAr4yRa3ECLbF7HJ2QyDPwih6uPhr0COV6y/2EItP9/bB68bqLeUyXc9m/wydYR6eMd/P0Ap23vQaxOCCT/wfw82sNLchsjGwX0Duv3E01/2g4Mp23eA19ugHiD/ka5diiArbOlg41S8ShLI6NzDpfJbSSNCNbCFliBB/MimZ0xH282yFUrNCdkfZtU05Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(86362001)(38100700002)(316002)(4326008)(66556008)(66476007)(66946007)(41300700001)(8676002)(5660300002)(8936002)(2906002)(7416002)(186003)(6636002)(107886003)(6512007)(1076003)(6506007)(36756003)(83380400001)(2616005)(478600001)(921005)(82950400001)(82960400001)(52116002)(6486002)(10290500003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FnkuaCvo8sSqxioUBA+KV0fpRr9lHudjT9eaKEhQbH6gAM/GW0pl6dYVbiqa?=
 =?us-ascii?Q?vc4tgM4s6q49EIb/pdFySVzW41WQe7gXGcM4sCBTi2699CGgVzFkrdZxQ2iG?=
 =?us-ascii?Q?6BC5Q/PKoZYYX0rVGgnoYQI/+evs37I8KyiJ4qASFxWLfW9X9UUEGf5ziF8k?=
 =?us-ascii?Q?/keUsj7GloevfQm6D+h+vdspMtA/z0RTKfZ7cO1o1Np8XnyMOgd9FvJ0/gNW?=
 =?us-ascii?Q?uRLSdrroyc/6Dj0jJR/HswQE0FEczZHSp99ipVIvpHaWrwlqfuq8Yv3agSzk?=
 =?us-ascii?Q?LI4B3nBQ/b7WA4llEz/58RTdNz1mhvahP6UGT3PVRDJaUGbZTObh1u6O9lXH?=
 =?us-ascii?Q?OInrZ9eaLsCb1YyMb8PTZ4Tezt355GtZOMIN4rx+b3up8Y+5m4KSwUfOVbuu?=
 =?us-ascii?Q?YIuyHp8pLdpiz9uubBFN+Bpikxsap6ZOkMcMrO6lt7W55XhfZJCw/St6vtgH?=
 =?us-ascii?Q?MkNcFy2IQkbZDhCTFt8F2jaC8jLoMSRd7cLTzJb5owCGVlFUbT0KLakv0+rJ?=
 =?us-ascii?Q?FQvNb81oXXN5GhG+KSFCYZ4n55aURvHUaae74xyt5uDCQw7y9vfmxNkSEyNz?=
 =?us-ascii?Q?q+zZgiF0yGgY9WzDd5Du9TsC2K/gCMajxMqs9gB2sbigY8Xl3VstE510KUgr?=
 =?us-ascii?Q?XKu7f1eXaafABX+Ix/mKoTtA9pYCVqD/rnMCU8TVeQ+Qq7YxadNX0BPjr4Ze?=
 =?us-ascii?Q?coQZKlt+uYADWJAttCXjb24Kj3oYc0ISECO7HRbPcNLvl/RmUnWmn8W5Azs+?=
 =?us-ascii?Q?9aCNxxFhXJ6iWSl7Tuah/nEyFeLZtzpNtKycHB2LPir2rqIi0jV1mrn74IVk?=
 =?us-ascii?Q?rcyJS9o+sNiz/d2v8X+DnITDEoUFhPliyitPBd81aMlpCR5Ij5PM0N96gtjK?=
 =?us-ascii?Q?WhtPochwpho0qoi1x9nCXbS9OAgtwUpTl6bsvhNGu5YLLE/RYm+EEYILWPCk?=
 =?us-ascii?Q?s3+T+CNQ7ar/9LGwtLGKqH8iixOYEoIiGJcLIsXPQoehsgfOWkiJnnO1HMWy?=
 =?us-ascii?Q?qEH74xVecw07U4pC7BK3mNbafdZmuBx3p28sfvbcAkPpQL+x81CuJWOnh5av?=
 =?us-ascii?Q?XQKGVb/b1btmSa/H+JPCkGKi/rz1Y6oitvIOiJGCgTg72569kV0Uz3sQ4LNY?=
 =?us-ascii?Q?L700JUk6Du65rZ6GN3/qC8Oyj58/ZNicLL4W/Eg1LbVAexoIbnx0vRTMBetl?=
 =?us-ascii?Q?xputZ88xNPbQ09j5mbvM4kFS6TeJlj+QaVUz9i03lxHqO/f0T++6MG9hKCCB?=
 =?us-ascii?Q?bmEeTWHvypQVNemTTZ1uqRaHFVj0/Q+WgVbdr2N7tDfsnwF9MqQnSdRGkNzV?=
 =?us-ascii?Q?L/j6i8RcA9uT1H2C0j0vLbsU8j3nfJE0y5DUXjbpdTkTMUQM0FWEVAqMI8t1?=
 =?us-ascii?Q?wKIpSd56MUDrlxNOntVHlf959RoUgU6OntFqmyoEnimiLnZQ3N5A83ZLdMom?=
 =?us-ascii?Q?0S+2AHu14aVdocco7DDcOWS47oxmz89Em3BKkWYzYoKqpq+K/CH8//XNqu4B?=
 =?us-ascii?Q?65OwAMaMY/betBCDn25PgEQWCZo7k4T6XpLHkbQe9H76hd1dCzMsrgw0iDEC?=
 =?us-ascii?Q?RjsIIAfwC4IddHRUuSShNAuQoe5SEFPLq9M02v3gTSA5ITnlCXRpmKClmfWb?=
 =?us-ascii?Q?/8rIgTsWtbezm9C7OqwXxUISBzOdiLXh7XcBunrg2AUJ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d2cde4b-9ac2-43d2-d9c5-08db728ba90f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:13:56.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zANK5JI9ACo4H0Q4YjockXZTSCjzWf58Q4Ob2eUXS9CwwX7DPUXZNnzfF9vPbeZRlOpm3l3UrLO/LwBesLy8bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR21MB4009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

Changes in v2:
  Changed tdx_enc_status_changed() in place.

Changes in v3:
  No change since v2.

Changes in v4:
  Added Kirill's Co-developed-by since Kirill helped to improve the
    code by adding tdx_enc_status_changed_phys().

  Thanks Kirill for the clarification on load_unaligned_zeropad()!

Changes in v5:
  Added Kirill's Signed-off-by.
  Added Michael's Reviewed-by.

Changes in v6: None.

Changes in v7: None.
  Note: there was a race between set_memory_encrypted() and
  load_unaligned_zeropad(), which has been fixed by the 3 patches of
  Kirill in the x86/tdx branch of the tip tree.

Changes in v8:
  Rebased to tip.git's master branch.

Changes in v9:
  Added Kuppuswamy Sathyanarayanan's Reviewed-by.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 746075d20cd2..c1a2423a8159 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -753,6 +754,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return false;
 }
 
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* shared->private conversion requires memory to be accepted before use */
+	if (enc)
+		return tdx_accept_memory(start, end);
+
+	return true;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -760,15 +774,24 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start = vaddr;
+	unsigned long end = start + numpages * PAGE_SIZE;
 
-	if (!tdx_map_gpa(start, end, enc))
+	if (offset_in_page(start) != 0)
 		return false;
 
-	/* shared->private conversion requires memory to be accepted before use */
-	if (enc)
-		return tdx_accept_memory(start, end);
+	if (!is_vmalloc_addr((void *)start))
+		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);
+
+	while (start < end) {
+		phys_addr_t start_pa = slow_virt_to_phys((void *)start);
+		phys_addr_t end_pa = start_pa + PAGE_SIZE;
+
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+
+		start += PAGE_SIZE;
+	}
 
 	return true;
 }
-- 
2.25.1

