Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C966A8A8E
	for <lists+linux-arch@lfdr.de>; Thu,  2 Mar 2023 21:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCBUkq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Mar 2023 15:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCBUkp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Mar 2023 15:40:45 -0500
Received: from cmx-torrgo002.bell.net (mta-tor-002.bell.net [209.71.212.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FD559C3;
        Thu,  2 Mar 2023 12:40:42 -0800 (PST)
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [174.88.80.104]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 63F52EA4010FFA11
X-CM-Envelope: MS4xfBMbnnIrk9fOtS+ErDc2D/Y8SAVdLFz3sxDNB/LAE2dng6CmGuhfnSDFmZYFbU4YOSpw3n1ogKnZUCMS1oYtPVIZwQu8UqNQV1oRZcBsCwu+1zJlO9mY
 8xG/mr4jfqUFcwjEpkasc/yXfWTPRGptN2pZkBAtnP6GVVNTvpR1TtxJv8pmu8KjbxiKTtGGa9JEC+YWpWz6I1fHm8b1wP5efX5TqdpuSns26h0WfPQf+XJt
 t+TIwZCEEVWh6BEhrQUxBs9XRckJdPkfOGC2mP25nUQ5j3vnKyEYJcbr75szp+AnZx7NS5IM1FBL09rn//p8Zlwg4y4kqA9V8gS0AFNDm6oDYkdgrmRiFMFY
 FE8G1XGyBe0cMLOTS1Cfp6iUVj06cJYAY/RDCmdBt7QuCj1VSLWSszzuIoGY5bwPImPbZhzRVT97PeeeIPh2j6DEtMjvuXvRlt1LEJOdg98Sxp02KAhg54px
 gUtN4kMk/zBkufae
X-CM-Analysis: v=2.4 cv=ULS+oATy c=1 sm=1 tr=0 ts=640109c1
 a=jp24WXWxBM5iMX8AJ3NPbw==:117 a=jp24WXWxBM5iMX8AJ3NPbw==:17
 a=IkcTkHD0fZMA:10 a=FBHGMhGWAAAA:8 a=2RFP64wVy-t9rOqPcicA:9 a=QEXdDO2ut3YA:10
 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (174.88.80.104) by cmx-torrgo002.bell.net (5.8.814) (authenticated as dave.anglin@bell.net)
        id 63F52EA4010FFA11; Thu, 2 Mar 2023 15:40:33 -0500
Message-ID: <1d0efde0-a7a5-11ca-158a-a30825d44516@bell.net>
Date:   Thu, 2 Mar 2023 15:40:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 18/34] parisc: Implement the new page table range API
Content-Language: en-US
From:   John David Anglin <dave.anglin@bell.net>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-19-willy@infradead.org>
 <9bb5280e-c875-6eee-b28e-2abc03427e5f@bell.net>
In-Reply-To: <9bb5280e-c875-6eee-b28e-2abc03427e5f@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-03-02 11:43 a.m., John David Anglin wrote:
> On 2023-02-28 4:37 p.m., Matthew Wilcox (Oracle) wrote:
>> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio()
>> and flush_icache_pages().  Change the PG_arch_1 (aka PG_dcache_dirty) flag
>> from being per-page to per-folio.
> I have tested this change on rp3440 at mainline commit e492250d5252635b6c97d52eddf2792ec26f1ec1
> and c8000 at mainline commit ee3f96b164688dae21e2466a57f2e806b64e8a37.
Here's another one:

------------[ cut here ]------------
kernel BUG at mm/memory.c:3865!
CPU: 1 PID: 6972 Comm: sbuild Not tainted 6.2.0+ #1
Hardware name: 9000/800/rp3440

      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
PSW: 00001000000001101111111100001111 Not tainted
r00-03  000000000806ff0f 000000004fab8d40 00000000404584b0 000000004fab8d40
r04-07  0000000040c2f4c0 0000000047fe60c0 000000004fab8b98 0000000000000953
r08-11  000000004de3de00 0000000000000000 0000000047fe60c0 0000004093ff4660
r12-15  0000000000000001 0000000047fe60c0 0000000040000540 000000022f8e9540
r16-19  0000000000000000 000000004c694c40 000000004fab8860 00000000000003d0
r20-23  0000000007be3a40 0000000000000fff 0000000000000000 000000004109f1a0
r24-27  0000000000000000 0000000000000cc0 0000000046de3a68 0000000040c2f4c0
r28-31  80e00000000a0435 000000004fab8df0 000000004fab8e20 0000000000000001
sr00-03  0000000000207c00 0000000000000000 0000000000000000 0000000002f11c00
sr04-07  0000000000000000 0000000000000000 0000000000000000 0000000000000000

IASQ: 0000000000000000 0000000000000000 IAOQ: 000000004045908c 0000000040459090
  IIR: 03ffe01f    ISR: 0000000000000000  IOR: 0000000000000000
  CPU:        1   CR30: 0000004095d64c20 CR31: ffffffffffffffff
  ORIG_R28: 000000001c569ad0
  IAOQ[0]: do_swap_page+0x108c/0x1168
  IAOQ[1]: do_swap_page+0x1090/0x1168
  RP(r2): do_swap_page+0x4b0/0x1168
Backtrace:
  [<000000004045a554>] handle_pte_fault+0x244/0x358
  [<000000004045c58c>] __handle_mm_fault+0x104/0x1b8
  [<000000004045c81c>] handle_mm_fault+0x1dc/0x318
  [<000000004044cb38>] faultin_page+0xa8/0x178
  [<000000004044e848>] __get_user_pages+0x328/0x560
  [<0000000040450ac4>] get_dump_page+0x9c/0x128
  [<0000000040596cb8>] dump_user_range+0xc0/0x2d8
  [<000000004058e790>] elf_core_dump+0x5f8/0x708
  [<0000000040596384>] do_coredump+0xc2c/0x14a0
  [<0000000040259040>] get_signal+0x4a8/0xb60
  [<000000004021a570>] do_signal+0x50/0x228
  [<000000004021ab38>] do_notify_resume+0x68/0x150
  [<0000000040203ee0>] syscall_do_signal+0x54/0xa0

CPU: 1 PID: 6972 Comm: sbuild Not tainted 6.2.0+ #1
Hardware name: 9000/800/rp3440
Backtrace:
  [<000000004020af50>] show_stack+0x70/0x90
  [<0000000040b7d408>] dump_stack_lvl+0xd8/0x128
  [<0000000040b7d48c>] dump_stack+0x34/0x48
  [<000000004020b160>] die_if_kernel+0x1d0/0x388
  [<000000004020c1c4>] handle_interruption+0xc34/0xc88
  [<000000004020307c>] intr_check_sig+0x0/0x3c

---[ end trace 0000000000000000 ]---
note: sbuild[6972] exited with preempt_count 1

Dave

-- 
John David Anglin  dave.anglin@bell.net

