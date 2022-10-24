Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEFA60B92F
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 22:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiJXUGC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 16:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiJXUFX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 16:05:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856B121E101;
        Mon, 24 Oct 2022 11:26:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F0F2CE16BB;
        Mon, 24 Oct 2022 16:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5DCC433C1;
        Mon, 24 Oct 2022 16:09:19 +0000 (UTC)
Date:   Mon, 24 Oct 2022 12:09:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <quic_satyap@quicinc.com>
Subject: Re: [PATCH] asm-generic/io: Add _RET_IP_ to MMIO trace for more
 accurate debug info
Message-ID: <20221024120929.41241e07@gandalf.local.home>
In-Reply-To: <20221017143450.9161-1-quic_saipraka@quicinc.com>
References: <20221017143450.9161-1-quic_saipraka@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 17 Oct 2022 20:04:50 +0530
Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:

> Due to compiler optimizations like inlining, there are cases where
> MMIO traces using _THIS_IP_ for caller information might not be
> sufficient to provide accurate debug traces.
> 
> 1) With optimizations (Seen with GCC):
> 
> In this case, _THIS_IP_ works fine and prints the caller information
> since it will be inlined into the caller and we get the debug traces
> on who made the MMIO access, for ex:
> 
> rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 addr=0xffff8000087447f4
> rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 width=32 val=0x0 addr=0xffff8000087447f4
> 
> 2) Without optimizations (Seen with Clang):
> 
> _THIS_IP_ will not be sufficient in this case as it will print only
> the MMIO accessors itself which is of not much use since it is not
> inlined as below for example:
> 
> rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
> rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 addr=0xffff8000087447f4
> 
> So in order to handle this second case as well irrespective of the compiler
> optimizations, add _RET_IP_ to MMIO trace to make it provide more accurate
> debug information in all these scenarios.
> 
> Before:
> 
> rwmmio_read: readl+0x4/0x80 width=32 addr=0xffff8000087447f4
> rwmmio_post_read: readl+0x48/0x80 width=32 val=0x4 addr=0xffff8000087447f4
> 
> After:
> 
> rwmmio_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 width=32 addr=0xffff8000087447f4
> rwmmio_post_read: qcom_smmu_tlb_sync+0xe0/0x1b0 -> readl+0x4/0x80 width=32 val=0x0 addr=0xffff8000087447f4
> 
> Fixes: 210031971cdd ("asm-generic/io: Add logging support for MMIO accessors")
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>


Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

What tree should this go through?

-- Steve
