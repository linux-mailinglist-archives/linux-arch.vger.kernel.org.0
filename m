Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003E2503B9
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgHXQts (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:49:48 -0400
Received: from mail-dm6nam12on2120.outbound.protection.outlook.com ([40.107.243.120]:2560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728692AbgHXQtY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmh7zPrpkdtYYlbf7EZ2TZykptLuxgUehTkwenJFZGVw/PO8P7lFFjOCpFtXEv4ZY1zO6pTQBoKLT+Z8XcrPgZZhgKJfqIwPL/XoDCtcyChmewoWwaDsBoqSf+ZMpYzmZZA2FVtdngaC9SUAFQS20hZL5V+JZKwWG5UaLxmhKJ4sFHYFnXXd93WFLb2jvnp5aRq1KHxtbk2ooUcHG8sLlIFeMnYN01i7Ke2m+qnMdT5kgxI+VEZA06P6B8qwtQeTGtJH0Gkh0bQq+K9gRy/YP+8rXWw5Kq6JQuEsacScrO7rliRWdpq1VHgTg/E4T0RprTIX7y/juGkexHB+3r1OIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEGJ2pGVOoA/475BwOAc1zBZDs85myo5tbrBv9fk6gs=;
 b=VmYf1PcqSh9FP5C559ZNJVI5gWRxdZIBUt0LxuCVa/1WLVhmYUfjveXaBAKrHPG8u5fnd0dAusInPG9gBltlH8M25rtfdt/MGZh969ZKl5rMVAs22Q7xrmCV/bcRApKbbYTa4qSHEslqvITo2UPwPiIxoSggYUJ2Shyg4scrvqvMIh5TrItTxzcnz0lju7cEeg/I/pA+BZ7p876uGHlvXVq7nXOjLeFPyl0dCMusChfcg5jog7difoBHf+FjJegEOlTWZ60YCS8QH28Hvz7P4nA0BqGRo9uB4C8fPj0KzZCaL0tKlmi27dkxYxdSinj7EMuoknN2do9/Fbyc6Ce1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEGJ2pGVOoA/475BwOAc1zBZDs85myo5tbrBv9fk6gs=;
 b=dgxFO3qZBPgZZjoKrqnRciGdmAtMRC05wxJtH9DHVnXdCAcB949fuoFDBrVYRRfIzrt6yaAo1inHz10sxDn0YMKXze0t9qmLbGzFs2TN7SqKzWmUJQCFHbF54a60VDSaMUpiuGjMzyLDqLw4OV4+pkDUgO06TdA7VmepnYDsFEU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:48:03 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:48:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 09/10] arm64: efi: Export screen_info
Date:   Mon, 24 Aug 2020 09:46:22 -0700
Message-Id: <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:57 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b944ed7e-ea53-431e-239d-08d8484d7527
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB07531CBCA87D9E956712ECFCD7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5eypPP52A/ERruzShY38nJwOGXshoQyh8Jc4vvaZkEItLPdEKiyzPIbzBRK+TO7t4nesnrxq2mlkmY+lKkuZPv5xBqdOPhgsrhvIllh3VBnXRmqm4uEAfmXao7AKbLCnhb4zr3OH+fzTWbton5HZESgoj8TKucWhO0j8+6Pf8LrI+cvh51TWFx3uTzsr2HT6SmicYbbfRb1bnZ0M2Qrz4VWr/CbUKatJ6f2VTbYUtsEOauBfvwbKp46ANTj2tU8djOVkpx0F2p9a/jNjSsk2bwA03aUrH5v+bWdlrjldwb6Re/TVhIqXZnTNJSPwY5dPZpCH8GuxxALBSb7uF6VlJ4gJkdYrex2Hlc5HOvX1Q2WWOrLJs5X4Rv4EgYqEkuDS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(4744005)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: FjG9xMA2M72cJ656kgx19qu0AmSurrEi3ZkaAVZc+o8Vzdgtd4xWEnNDCmr4nxIvVl5SpipqsCfC0DZLAIoB6EroilhaRRNjzuKG7XZacB6zBu4fW+SIN5wjfUTgvNfY78E6i9op/tW+j9BfOYwmR3OnvHzusnCxMpliWkzu3alXlsiImnWtqnbf7yY1wQw8yG+LVxyGLJLhrtumj1vcp/sU0FOJ21vfJJZXM4ect6+J5p6Nk64shZVPlvdDEIWbxKnSsTDJvr8M1tAjabilr6Odiw9fLjxQiAcr4SqmPjTMeQI7w7HI1iyZDpXNSX9wmZY9S80imUWn2+bw1jumZOsXL5dUa12b186VF2UjlTHGw3m1fRDMt9o1cyE3M6qhMwXm5Z8asPdSnrnFKjsNO4qjl4HjPXLu7tQwg8w9mwGPN1ZZ2TPibSCqaVahc7SrmtNKQGZWsv/fwx/I1At1onwk0WmQ0uBKzQkFBd9CkyOF0BiRIc3tKKxUMvHNleAwuXYF573o+VCuGv8YmULi+kx3aaBV5J4w+4hKJl8tg50Ppri923xAue+8N0nJmYvVKGAjplwyfL7HLylygDHxKIewsW6PobOZBdYN6tV1WzA1Vp9tHITotOcqn2P9zKyNHq+m9YbkTIusv8AzN+BkNQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b944ed7e-ea53-431e-239d-08d8484d7527
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:59.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svTdflFckd3ap9GnsidBAs11dw5dvVb8g2CuGtZcnn7a5A9Gty0n8stKeESmdxVmiZQ7jcGvY3TaX8y/NjwW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Hyper-V frame buffer driver may be built as a module, and
it needs access to screen_info. So export screen_info.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/kernel/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index d0cf596..8ff557a 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -55,6 +55,7 @@ static __init pteval_t create_mapping_protection(efi_memory_desc_t *md)
 
 /* we will fill this structure from the stub, so don't put it in .bss */
 struct screen_info screen_info __section(.data);
+EXPORT_SYMBOL(screen_info);
 
 int __init efi_create_mapping(struct mm_struct *mm, efi_memory_desc_t *md)
 {
-- 
1.8.3.1

