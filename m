Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B667C642488
	for <lists+linux-arch@lfdr.de>; Mon,  5 Dec 2022 09:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiLEI0b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 03:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiLEI0a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 03:26:30 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD466BF7C
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 00:26:29 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.43:44912.801624490
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id DC2B71002CF;
        Mon,  5 Dec 2022 16:22:43 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-6cffbd87dd-f7vjc with ESMTP id 9e96ef7c3352454ab22033a3810357f5 for rostedt@goodmis.org;
        Mon, 05 Dec 2022 16:22:43 CST
X-Transaction-ID: 9e96ef7c3352454ab22033a3810357f5
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v3 0/4] reorganize trace_peobe_tmpl.h
Date:   Mon,  5 Dec 2022 16:29:32 +0800
Message-Id: <1670228972-3934-1-git-send-email-chensong_2000@189.cn>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

In the first patchset, my intension was to remove trace_probe_tmpl.h,
just keep a unified process_fetch_insn and process_fetch_insn_bottom
in trace_probe.c for all *probes. is_uprobe was the most important
move to approach. If it was not accepted, the whole patchset couldn't
stand.

Then I change my goal to at least no warnings or errors when impelenting
a new feature based on trace probe if it includes trace_probe_tmpl.h by
provideing default behaviors. What's more, it also removes redundant
code in kprobe and eprobe.

---
v2:
1, mark nokprobe_inline for get_event_field
2, remove warnings reported from kernel test robot
3, fix errors reported from kernel test robot

Song Chen (4):
  kernel/trace: Introduce trace_probe_print_args and use it in *probes
  kernel/trace: Provide default impelentations defined in
    trace_probe_tmpl.h
  include/asm-generic/io.h: remove performing pointer arithmetic on a
    null pointer
  kernel/trace: remove calling regs_* when compiling HEXAGON

 include/asm-generic/io.h          |  45 ++++++---
 kernel/trace/trace_eprobe.c       | 146 +--------------------------
 kernel/trace/trace_events_synth.c |   7 +-
 kernel/trace/trace_kprobe.c       | 106 +-------------------
 kernel/trace/trace_probe.c        |  27 +++++
 kernel/trace/trace_probe.h        |   2 +
 kernel/trace/trace_probe_kernel.h | 158 ++++++++++++++++++++++++++++--
 kernel/trace/trace_probe_tmpl.h   |  28 ------
 kernel/trace/trace_uprobe.c       |   2 +-
 9 files changed, 222 insertions(+), 299 deletions(-)

-- 
2.25.1

