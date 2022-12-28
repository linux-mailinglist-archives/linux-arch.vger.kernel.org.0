Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C951F657370
	for <lists+linux-arch@lfdr.de>; Wed, 28 Dec 2022 08:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiL1HAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Dec 2022 02:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiL1HAb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Dec 2022 02:00:31 -0500
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9207C16;
        Tue, 27 Dec 2022 23:00:28 -0800 (PST)
HMM_SOURCE_IP: 10.64.8.41:50980.540084794
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-123.150.8.42 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id 92988100295;
        Wed, 28 Dec 2022 15:00:25 +0800 (CST)
Received: from  ([123.150.8.42])
        by gateway-153622-dep-79f476db8-8kzc7 with ESMTP id e1c18bf96238464184ac59529b01e4d1 for rostedt@goodmis.org;
        Wed, 28 Dec 2022 15:00:26 CST
X-Transaction-ID: e1c18bf96238464184ac59529b01e4d1
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From:   Song Chen <chensong_2000@189.cn>
To:     rostedt@goodmis.org, mhiramat@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Song Chen <chensong_2000@189.cn>
Subject: [PATCH v4 0/2] reorganize trace_peobe_tmpl.h
Date:   Wed, 28 Dec 2022 15:07:55 +0800
Message-Id: <1672211275-31393-1-git-send-email-chensong_2000@189.cn>
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
1, reorganize patchset.

v3:
1, mark nokprobe_inline for get_event_field.
2, remove warnings reported from kernel test robot.
3, fix errors reported from kernel test robot.

v4:
1, reset changes in v3(2) and v3(3), they are not reasonable fix.
2, fixed errors by adding "#ifdef CONFIG_HAVE_REGS_AND_STACK_ACCESS_API".

Song Chen (2):
  kernel/trace: Introduce trace_probe_print_args and use it in *probes
  kernel/trace: Provide default impelentations defined in
    trace_probe_tmpl.h

 kernel/trace/trace_eprobe.c       | 146 +-----------------------------
 kernel/trace/trace_events_synth.c |   7 +-
 kernel/trace/trace_kprobe.c       | 106 +---------------------
 kernel/trace/trace_probe.c        |  27 ++++++
 kernel/trace/trace_probe.h        |   2 +
 kernel/trace/trace_probe_kernel.h | 143 +++++++++++++++++++++++++++--
 kernel/trace/trace_probe_tmpl.h   |  28 ------
 kernel/trace/trace_uprobe.c       |   2 +-
 8 files changed, 174 insertions(+), 287 deletions(-)

-- 
2.25.1

