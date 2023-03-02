Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173956A872E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCBQqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 11:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCBQqd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 11:46:33 -0500
X-Greylist: delayed 118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 08:46:31 PST
Received: from cmx-mtlrgo002.bell.net (mta-mtl-002.bell.net [209.71.208.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B667B34C2D;
        Thu,  2 Mar 2023 08:46:31 -0800 (PST)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [174.88.80.104]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 63F6814000DA1401
X-CM-Envelope: MS4xfLVO8ITc1kj8qoxJFtfOPz1EuT7a95tpUZP4sXes5k+K6EBHSG976j7A+uSPtTUw4nb7P2L+8EePjZy+fJ0k7kzOAlWBq7pDr3YMv2wHDQMTnvASGOiD
 iZko+LpnFwlDJ00F7UdTQYrQWfNNROBalCvTEMRb4+VMkb0AC3XHCv7i5S96s4V1KAZoemqGkL+tlWfdN3QqdEz/71NqzV2pV2+amkfBZGBenRwRwFGJ4bh8
 ew3+rQUOOrZhFjB4suCAdJttJrIkkJ+WjltCUv2E1b9/svjrx+FvzK7Hr7TD0xFRsL72s/lN1vksOizeo54w8mgDkxFWnDE8209jNglwa40Gp90LnLmShC8S
 lcF2SLNoqjABa9jsVh0rcZ51aWoUCoLSzGNcIejRSxWRUN0hEx30W36VcUNxyvs60vSdKG3uddxVX+kKVtwKH5YRUMUFIpYIdYkEnP/F/wCiTpA5z3cWsY2E
 ogcxm4d3FqCHPgB2
X-CM-Analysis: v=2.4 cv=GcB0ISbL c=1 sm=1 tr=0 ts=6400d21a
 a=jp24WXWxBM5iMX8AJ3NPbw==:117 a=jp24WXWxBM5iMX8AJ3NPbw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=Sjfu5S3q6Ak1qpNjs2gA:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (174.88.80.104) by cmx-mtlrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 63F6814000DA1401; Thu, 2 Mar 2023 11:43:06 -0500
Message-ID: <9bb5280e-c875-6eee-b28e-2abc03427e5f@bell.net>
Date:   Thu, 2 Mar 2023 11:43:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 18/34] parisc: Implement the new page table range API
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-19-willy@infradead.org>
Content-Language: en-US
From:   John David Anglin <dave.anglin@bell.net>
In-Reply-To: <20230228213738.272178-19-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-02-28 4:37 p.m., Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio()
> and flush_icache_pages().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
> from being per-page to per-folio.
I have tested this change on rp3440 at mainline commit e492250d5252635b6c97d52eddf2792ec26f1ec1
and c8000 at mainline commit ee3f96b164688dae21e2466a57f2e806b64e8a37.

So far, I haven't seen an issues on c8000.  On rp3440, I saw the following:

_swap_info_get: Unused swap offset entry 00000320
BUG: Bad page map in process buildd  pte:00032100 pmd:003606c3
addr:0000000000482000 vm_flags:00100077 anon_vma:0000000066f61340 mapping:0000000000000000 index:482
file:(null) fault:0x0 mmap:0x0 read_folio:0x0
CPU: 0 PID: 6813 Comm: buildd Not tainted 6.2.0+ #1
Hardware name: 9000/800/rp3440
Backtrace:
  [<000000004020af50>] show_stack+0x70/0x90
  [<0000000040b7d408>] dump_stack_lvl+0xd8/0x128
  [<0000000040b7d48c>] dump_stack+0x34/0x48
  [<00000000404513a4>] print_bad_pte+0x24c/0x318
  [<00000000404560dc>] zap_pte_range+0x8d4/0x958
  [<0000000040456398>] unmap_page_range+0x1d8/0x490
  [<000000004045681c>] unmap_vmas+0x10c/0x1a8
  [<0000000040466330>] exit_mmap+0x198/0x4a0
  [<0000000040235cbc>] mmput+0x114/0x2a8
  [<0000000040244e90>] do_exit+0x4e0/0xc68
  [<0000000040245938>] do_group_exit+0x68/0x128
  [<000000004025967c>] get_signal+0xae4/0xb60
  [<000000004021a570>] do_signal+0x50/0x228
  [<000000004021ab38>] do_notify_resume+0x68/0x150
  [<00000000402030b4>] intr_check_sig+0x38/0x3c

Disabling lock debugging due to kernel taint
_swap_info_get: Unused swap offset entry 000003a9
BUG: Bad page map in process buildd  pte:0003a940 pmd:003606c3
addr:0000000000523000 vm_flags:00100077 anon_vma:0000000066f61340 mapping:0000000000000000 index:523
file:(null) fault:0x0 mmap:0x0 read_folio:0x0
CPU: 2 PID: 6813 Comm: buildd Tainted: G    B              6.2.0+ #1
Hardware name: 9000/800/rp3440
Backtrace:
  [<000000004020af50>] show_stack+0x70/0x90
  [<0000000040b7d408>] dump_stack_lvl+0xd8/0x128
  [<0000000040b7d48c>] dump_stack+0x34/0x48
  [<00000000404513a4>] print_bad_pte+0x24c/0x318
  [<00000000404560dc>] zap_pte_range+0x8d4/0x958
  [<0000000040456398>] unmap_page_range+0x1d8/0x490
  [<000000004045681c>] unmap_vmas+0x10c/0x1a8
  [<0000000040466330>] exit_mmap+0x198/0x4a0
  [<0000000040235cbc>] mmput+0x114/0x2a8
  [<0000000040244e90>] do_exit+0x4e0/0xc68
  [<0000000040245938>] do_group_exit+0x68/0x128
  [<000000004025967c>] get_signal+0xae4/0xb60
  [<000000004021a570>] do_signal+0x50/0x228
  [<000000004021ab38>] do_notify_resume+0x68/0x150
  [<00000000402030b4>] intr_check_sig+0x38/0x3c
[...]
pagefault_out_of_memory: 1158973 callbacks suppressed
Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF

Rebooted rp3440.  Since then, I haven't seen any more problems.

Dave

-- 
John David Anglin  dave.anglin@bell.net

