Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27A059A4FD
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 20:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354690AbiHSRfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354701AbiHSRex (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 13:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98416A4AF;
        Fri, 19 Aug 2022 09:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C678A617AD;
        Fri, 19 Aug 2022 16:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE66C433C1;
        Fri, 19 Aug 2022 16:53:31 +0000 (UTC)
Date:   Fri, 19 Aug 2022 12:53:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
Message-ID: <20220819125343.1623d850@gandalf.local.home>
In-Reply-To: <f9b12eed-a7a0-0f2b-4679-1f465e22cad6@loongson.cn>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
        <20220819081403.7143-2-zhangqing@loongson.cn>
        <f9b12eed-a7a0-0f2b-4679-1f465e22cad6@loongson.cn>
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

On Fri, 19 Aug 2022 17:29:29 +0800
Jinyang He <hejinyang@loongson.cn> wrote:

> It seems this patch adds non-dynamic ftrace, this code should not
> appear here.
> BTW is it really necessary for non-dynamic ftrace? I do not use it
> directly and frequently, IMHO, non-dynamic can be completely
> 
> replaced dynamic?

Note, I keep the non dynamic ftrace around for debugging purposes.

But sure, it's pretty useless. It's also good for bringing ftrace to a new
architecture (like this patch is doing), as it is easier to implement than
dynamic ftrace, and getting the non-dynamic working is usually the first
step in getting dynamic ftrace working.

But it's really up to the arch maintainers to keep it or not.

-- Steve
