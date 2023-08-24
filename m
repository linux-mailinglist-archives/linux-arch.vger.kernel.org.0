Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375037869B8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjHXILG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbjHXIKo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:44 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBCA1989;
        Thu, 24 Aug 2023 01:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCqONykCn0iqWSt6WUpLA7M4tCp8u/XrC2XEfS49pSPHhRYZSKDunIBYvca7Lp2UJdTgNOtmz6hI7QwzBXgThnLkuSvrH3pJXHGY5TSaKVLK2jLAKHQet7IuSXM10Ab16Cg3EElNIFkBdu1AmXuyfj0pvgDVcprXlaM/NQydNDsc6sCAe1zUKnjV9yIKxzyXE61wHRu1wgwy2TezjTM9JgSIrJTudwgSDFzmMAU69x6NEyu9gfVwZ7jPYuFBfg3ZJ6OV9lQUVUpwGEkJAHie73MeoSSgCcLxRDXkq5SXQ0nyjLJ2mwnd4fD+qYnt2b7Fm9np9hn5IqrRNPKMSKNMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sxgkr5jIcqci7y3BNhOT8j71zNzbQ4WzI8nrmvuOIaQ=;
 b=RojF/9mHQ0rnl45AyR4i3J9t4gTZtUNCDgJLqTEeWW679otbZPZRbCGZE2Cf14NKyqETU2LlWHRdXWoT8IAIxjOUjJZlB7TAtqfTCrm/z9rSREt6xKVeT1R39NJT9pSU1Y/hoTqi29bVu/KXfY+tl9xs9YVFkdWsUhEv73WqxXMKv4OdJT4wL7UliAgIB2s4CqExYiT7oGlOkAY57KRd71S3+sMljU3volccliRTUha6/VEumYc5UbKX7Zc4vJPT2QKdwOG1trS49/dgKXRF7HTsxAh/lxhkZtNe1A82ltJR91jUsu5jQ8SSWancP1/NBRLD+axopexDjD2NFCQBhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sxgkr5jIcqci7y3BNhOT8j71zNzbQ4WzI8nrmvuOIaQ=;
 b=aBITZnbCxPd7gB3z74uGzfCSAL8QQebahmNkn6J4EDkN31WR5LXH90rRlD0mkZgnKJkiNkFw9p4xvzJMGbDHJGuh+Yjf5ZsESJMdgsNQNcpoC/HhgAcP2am/2DinB467Iy9vFMmHdBwMXlTqkBx5J1bOThzMDc2XuwFA/WbsGkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:11 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:11 +0000
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
Subject: [PATCH v3 07/10] Drivers: hv: vmbus: Bring the post_msg_page back for TDX VMs with the paravisor
Date:   Thu, 24 Aug 2023 01:07:09 -0700
Message-Id: <20230824080712.30327-8-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824080712.30327-1-decui@microsoft.com>
References: <20230824080712.30327-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0175.namprd15.prod.outlook.com
 (2603:10b6:930:81::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|PH8PR21MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca9d0ec-7634-4aea-1ae0-08dba47941f1
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0hMVn9HTUQKLQaxquuIvHnVNTKkViVKYguc8iJMdWGk3zce/JFNrGcHoy+ocjtho3jOsTbWU2nOA919X/0WcUES0O4J0VBA6B3sWetWJ6qLop7yhekIyytcjyK4LAZ8CJqmiHQVgpjaHT3XGFUF5RpZ37idgC2uSye1thUR6i0CG8/eF11YTk1k1Dr5LgnA60wKcKpdsdXxSkxoadGHUj12we99OyXhh+wrXkL3WqVr38oyqPlJKXOBMYsxgY0lDS1WJ4tpYHzmsEMKWkdfVO3Tr+4tqzrbTFq8SCwkvMIUfYJ1fiyReXiaEzwG/B61MXwvV0F5Azxy8m7bEvMLh4wPojoHvkQpMd+0rCdzKrZseCDiolpbJS9XH9XKlRzT4ww4aXMpOpsJz1j4ncAzs2ibNX8DuoVp0r6FzA2yUnOIuHhT6dNowMuhUQ7ygTTXr5BLFmdclE+Xg0umnoZuyvpDE+elTOXFUugfySQk5S/tDYhqGRNU/bQnhfarP7dDxzFjgqR1LZg8NdI8l/MOlbtxzeUA1UFjk3wdM/O57bGM+kt5ssMIZEnNxhfBle0CcH682w0Fuh8WbyeluJorYWh4piqBysbN04dVjiS/SxZywKCfO9aPOew3VF1Disrp9H41HJ6p3oaYu/WaZgz8iHzf7AJCSnmjqmvHtM62eNWLpw8EsG9Cm5D6nXgmT1hz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szt8dCrHjC6V5iKOORcuYG7IJP3ytkuV3rz/n6jwEZiexGSKGK8XwO3xDGOC?=
 =?us-ascii?Q?eAahczCBVo97VTBXE3zdYca6wYi5Y0GExDz3Nws9bosPReUn1C9Sl32wVvWC?=
 =?us-ascii?Q?zBBeKaglxuk+QTLOEBX2bV4Qpv6y3YtnpRin5JwDAxdYlefqL+ALEMwgq1Q5?=
 =?us-ascii?Q?FH2QZrQ7pbBA1C8tes57iUvY0UD2LK/RMx3GHuQL/i0izz7FA7V+Ej/PbTDc?=
 =?us-ascii?Q?nKqcgDektNNEVXzhL04I/Xvw3qEuj3BAks05SokdB0PmYS4mwl/QuH9x9qVw?=
 =?us-ascii?Q?+frJl3yWKb9gGN+y8x1/1Rmg1deISd8GgNs9JsZu6N0hXnhdQFH6lwHA1nqM?=
 =?us-ascii?Q?DXxCdOzJGtRaFI4GqBMVmx15Go3kUr4Wc5t0zTIXWQGZ+fOHDw74ESy5+n6V?=
 =?us-ascii?Q?MM8Oy6DgxQ4OlwByFAtDcBLIKu+ctVifxS4uCLbRl/aU+zdIm8xxoFhQr2KE?=
 =?us-ascii?Q?FqzxYb6a6OPzM0Tx2xSDRQ2YFIF/iEJkIWRtn7D+T9aQu/IUnlduhzChJpIV?=
 =?us-ascii?Q?vEyz6APRT7NobhPf9b+7LhZFbF+7sIwE4x4Lclqa8rZ3uKGtq1CuePJGhGyQ?=
 =?us-ascii?Q?3AqDea84HlpaAyNPloSQj+bfbx5Pqfm9dr8HvksH2FlhWvwWTvUXrTJKjLWC?=
 =?us-ascii?Q?3sFKMVb2KjQxHxTkj2a4HCmKVOOXDGiIYkxp254fCDBQ2qN34QLbVVzyfH8g?=
 =?us-ascii?Q?Nt3nfG2EAhPjO41Nh+vBx+aanju9TkD0oLYeqlpwtsbBCo8hFXWeUt8VLlEf?=
 =?us-ascii?Q?tkxfOdxYUCkUeCCFSPg61MQ2GK6MkRRAWzjIAQhxQRxsar6XExB3caQN8ej7?=
 =?us-ascii?Q?pi0b8fC6QjW9kaZgRY8og5OKFOhzIsWOTiinQQYVIAkxSrY4pQFkXfQI9SMw?=
 =?us-ascii?Q?pba95wktTwlbtFI+4aMH38VJfX8NWipB4kFKtWLKau2XVLdoqy4Xv/Yq7sDi?=
 =?us-ascii?Q?8gvE9ihkNP8qS1broEUH9jFcwfclO1bY4Hprx5Pk/Tq4Bwnsrz0S/w4qmudM?=
 =?us-ascii?Q?SAp3m1+Qt8GI+fkH12lGlYL12zA5dx5Z+rbPT5Afnfgfj9H5yvplOnGcAOSb?=
 =?us-ascii?Q?D3tKCLtEyeJgX8mEBwtzD5np0k+XyFeVMfk3ncXwrPP1GwKIXaJIc48z0b49?=
 =?us-ascii?Q?n7lMqQANQ1EUdkEkXrFW7HKOjhpzwurYMi2Gk6+ST19y3mTurYtjisjJZd/V?=
 =?us-ascii?Q?lTT7AjzIO18TkmjbbBFHUI2udJxi/efSUeyA9dIIKXbaQlv+yIvJ7mpU/vAS?=
 =?us-ascii?Q?kOt+JZjOIekfaJBORtYLX0FsgRGVrCcJyrxVv49ajLACTyMYv8aQlRSSnaF2?=
 =?us-ascii?Q?E7niUOQl/of9BTmdEhVrBUHqhDdVkXz5I5zrq7Nmt6r/1d1DiahxQpS7fYr6?=
 =?us-ascii?Q?3HfggqUGqn/1duzeRqyrhyQvwn0QLFX3zpbDIbF0NqL8Q51R23JqjYkKgcyu?=
 =?us-ascii?Q?h6fS3uctVbKJLRke8QXqtRDP5j+TbZhlipFbDXOfZALcky90SUSjprdcquI3?=
 =?us-ascii?Q?kaHjth+jY8x7FhmmJ0BPaRKANEFHQJancPuh4hMxlnhSMqLEFYjTtaMsG4Il?=
 =?us-ascii?Q?COiE4XfUzCpbMY3RICQwKIopXrtsvWWqv33qhNMY/bVVwjMpUUPbI4rcAdKX?=
 =?us-ascii?Q?mPCKsNdWh6/lvtCe9Ahu6P4qiHlUcVyUrWzcFhbRGvUG?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca9d0ec-7634-4aea-1ae0-08dba47941f1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:11.0054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blgXKbl7cSMJGb5d4AQwhjzd0+/cjqsR1WYKiTPDu7fjfsGwIoTEfO4GHCUARYwoNNUEZ9t7awNBP0QrZwCECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The post_msg_page was removed in
commit 9a6b1a170ca8 ("Drivers: hv: vmbus: Remove the per-CPU post_msg_page")

However, it turns out that we need to bring it back, but only for a TDX VM
with the paravisor: in such a VM, the hyperv_pcpu_input_arg is not decrypted,
but the HVCALL_POST_MESSAGE in such a VM needs a decrypted page as the
hypercall input page: see the comments in hyperv_init() for a detailed
explanation.

Except for HVCALL_POST_MESSAGE and HVCALL_SIGNAL_EVENT, the other hypercalls
in a TDX VM with the paravisor still use hv_hypercall_pg and must use the
hyperv_pcpu_input_arg (which is encrypted in such a VM), when a hypercall
input page is used.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

Changes in v3:
  hyperv_paravisor_present -> ms_hyperv.paravisor_present

 arch/x86/hyperv/hv_init.c | 20 +++++++++++--
 drivers/hv/hv.c           | 59 +++++++++++++++++++++++++++++++++++----
 drivers/hv/hyperv_vmbus.h | 11 ++++++++
 3 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index eca5c4b7e3b5..3729eee21e47 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -480,6 +480,22 @@ void __init hyperv_init(void)
 	 * Setup the hypercall page and enable hypercalls.
 	 * 1. Register the guest ID
 	 * 2. Enable the hypercall and register the hypercall page
+	 *
+	 * A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg:
+	 * when the hypercall input is a page, such a VM must pass a decrypted
+	 * page to Hyper-V, e.g. hv_post_message() uses the per-CPU page
+	 * hyperv_pcpu_input_arg, which is decrypted if no paravisor is present.
+	 *
+	 * A TDX VM with the paravisor uses hv_hypercall_pg for most hypercalls,
+	 * which are handled by the paravisor and the VM must use an encrypted
+	 * input page: in such a VM, the hyperv_pcpu_input_arg is encrypted and
+	 * used in the hypercalls, e.g. see hv_mark_gpa_visibility() and
+	 * hv_arch_irq_unmask(). Such a VM uses TDX GHCI for two hypercalls:
+	 * 1. HVCALL_SIGNAL_EVENT: see vmbus_set_event() and _hv_do_fast_hypercall8().
+	 * 2. HVCALL_POST_MESSAGE: the input page must be a decrypted page, i.e.
+	 * hv_post_message() in such a VM can't use the encrypted hyperv_pcpu_input_arg;
+	 * instead, hv_post_message() uses the post_msg_page, which is decrypted
+	 * in such a VM and is only used in such a VM.
 	 */
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
@@ -487,8 +503,8 @@ void __init hyperv_init(void)
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
 	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
-	if (hv_isolation_type_tdx())
+	/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg */
+	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
 		goto skip_hypercall_pg_init;
 
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 48b1623112f0..523c5d99f375 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -57,20 +57,37 @@ int hv_post_message(union hv_connection_id connection_id,
 
 	local_irq_save(flags);
 
-	aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	/*
+	 * A TDX VM with the paravisor must use the decrypted post_msg_page: see
+	 * the comment in struct hv_per_cpu_context. A SNP VM with the paravisor
+	 * can use the encrypted hyperv_pcpu_input_arg because it copies the
+	 * input into the GHCB page, which has been decrypted by the paravisor.
+	 */
+	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
+		aligned_msg = this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
+	else
+		aligned_msg = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
 	aligned_msg->connectionid = connection_id;
 	aligned_msg->reserved = 0;
 	aligned_msg->message_type = message_type;
 	aligned_msg->payload_size = payload_size;
 	memcpy((void *)aligned_msg->payload, payload, payload_size);
 
-	if (hv_isolation_type_snp())
-		status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
-				(void *)aligned_msg, NULL,
-				sizeof(*aligned_msg));
-	else
+	if (ms_hyperv.paravisor_present) {
+		if (hv_isolation_type_tdx())
+			status = hv_tdx_hypercall(HVCALL_POST_MESSAGE,
+						  virt_to_phys(aligned_msg), 0);
+		else if (hv_isolation_type_snp())
+			status = hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
+						   aligned_msg, NULL,
+						   sizeof(*aligned_msg));
+		else
+			status = HV_STATUS_INVALID_PARAMETER;
+	} else {
 		status = hv_do_hypercall(HVCALL_POST_MESSAGE,
 				aligned_msg, NULL);
+	}
 
 	local_irq_restore(flags);
 
@@ -105,6 +122,24 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
+		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
+			hv_cpu->post_msg_page = (void *)get_zeroed_page(GFP_ATOMIC);
+			if (hv_cpu->post_msg_page == NULL) {
+				pr_err("Unable to allocate post msg page\n");
+				goto err;
+			}
+
+			ret = set_memory_decrypted((unsigned long)hv_cpu->post_msg_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt post msg page: %d\n", ret);
+				/* Just leak the page, as it's unsafe to free the page. */
+				hv_cpu->post_msg_page = NULL;
+				goto err;
+			}
+
+			memset(hv_cpu->post_msg_page, 0, PAGE_SIZE);
+		}
+
 		/*
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
@@ -178,6 +213,17 @@ void hv_synic_free(void)
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		/* It's better to leak the page if the encryption fails. */
+		if (ms_hyperv.paravisor_present && hv_isolation_type_tdx()) {
+			if (hv_cpu->post_msg_page) {
+				ret = set_memory_encrypted((unsigned long)
+					hv_cpu->post_msg_page, 1);
+				if (ret) {
+					pr_err("Failed to encrypt post msg page: %d\n", ret);
+					hv_cpu->post_msg_page = NULL;
+				}
+			}
+		}
+
 		if (!ms_hyperv.paravisor_present &&
 		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
 			if (hv_cpu->synic_message_page) {
@@ -199,6 +245,7 @@ void hv_synic_free(void)
 			}
 		}
 
+		free_page((unsigned long)hv_cpu->post_msg_page);
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 	}
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 55f2086841ae..f6b1e710f805 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -123,6 +123,17 @@ struct hv_per_cpu_context {
 	void *synic_message_page;
 	void *synic_event_page;
 
+	/*
+	 * The page is only used in hv_post_message() for a TDX VM (with the
+	 * paravisor) to post a messages to Hyper-V: when such a VM calls
+	 * HVCALL_POST_MESSAGE, it can't use the hyperv_pcpu_input_arg (which
+	 * is encrypted in such a VM) as the hypercall input page, because
+	 * the input page for HVCALL_POST_MESSAGE must be decrypted in such a
+	 * VM, so post_msg_page (which is decrypted in hv_synic_alloc()) is
+	 * introduced for this purpose. See hyperv_init() for more comments.
+	 */
+	void *post_msg_page;
+
 	/*
 	 * Starting with win8, we can take channel interrupts on any CPU;
 	 * we will manage the tasklet that handles events messages on a per CPU
-- 
2.25.1

