Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F359AA8F
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 03:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiHTBwb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 21:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiHTBwa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 21:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69E5D8E39;
        Fri, 19 Aug 2022 18:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EA8C61938;
        Sat, 20 Aug 2022 01:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07E2C433C1;
        Sat, 20 Aug 2022 01:52:27 +0000 (UTC)
Date:   Fri, 19 Aug 2022 21:52:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
Message-ID: <20220819215240.3caf89e2@gandalf.local.home>
In-Reply-To: <246779c0-b834-16a6-ec68-c06d8f9a375d@loongson.cn>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
        <20220819081403.7143-2-zhangqing@loongson.cn>
        <20220819132509.127a1353@gandalf.local.home>
        <246779c0-b834-16a6-ec68-c06d8f9a375d@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 20 Aug 2022 09:38:21 +0800
Jinyang He <hejinyang@loongson.cn> wrote:

> I think we have implemented CONFIG_FTRACE_WITH_ARGS in dynamic ftrace
> in the [Patch3/9]. 

Sorry, I must have missed it.

> But, for non dynamic ftrace, it is hardly to
> implement it. Because the LoongArch compiler gcc treats mount as a

Don't bother implementing it for non-dynamic. I would just add a:

config HAVE_FTRACE_WITH_ARGS if DYNAMIC_FTRACE

and be done with it.

> really call, like 'call _mcount(__builtin_return_address(0))'. That
> means, they decrease stack, save args to callee saved regs and may
> do some optimization before calling mcount. It is difficult to find the
> original args and apply changes from tracers.

Right, there's no point in implementing it for non dynamic. Like I said,
non-dynamic is just a stepping stone for getting dynamic working. Once you
have dynamic working, it's up to you to throw out the non-dynamic. It's not
useful for anything other than porting to a new architecture or for
academic purposes.

-- Steve
