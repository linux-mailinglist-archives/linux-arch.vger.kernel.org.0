Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF98E401E49
	for <lists+linux-arch@lfdr.de>; Mon,  6 Sep 2021 18:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244050AbhIFQag (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Sep 2021 12:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243932AbhIFQag (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Sep 2021 12:30:36 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59F08C061575;
        Mon,  6 Sep 2021 09:29:31 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9EF9C92009C; Mon,  6 Sep 2021 18:29:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 985D792009B;
        Mon,  6 Sep 2021 18:29:29 +0200 (CEST)
Date:   Mon, 6 Sep 2021 18:29:29 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Huang Pei <huangpei@loongson.cn>
cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] MIPS: fix local_t operation on MIPS64
In-Reply-To: <20210906140307.cnj7iv567aibvhzr@ThinkPad-W520>
Message-ID: <alpine.DEB.2.21.2109061827590.38640@angie.orcam.me.uk>
References: <20210904151218.10167-1-huangpei@loongson.cn> <alpine.DEB.2.21.2109041955310.38640@angie.orcam.me.uk> <20210905004810.5783639.10620.10055@loongson.cn> <alpine.DEB.2.21.2109061306140.38640@angie.orcam.me.uk>
 <20210906140307.cnj7iv567aibvhzr@ThinkPad-W520>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 6 Sep 2021, Huang Pei wrote:

> || {standard input}: Assembler messages:
> {standard input}|11389| Error: unrecognized opcode `long_addu $6,$3,$2'
> {standard input}|11392| Error: unrecognized opcode `long_addu $6,$3,$2'
> {standard input}|11404| Error: unrecognized opcode `long_addu $5,$7,$2'
> {standard input}|11407| Error: unrecognized opcode `long_addu $5,$7,$2'
> {standard input}|12354| Error: unrecognized opcode `long_addu $20,$3,$2'
> {standard input}|12357| Error: unrecognized opcode `long_addu $20,$3,$2'

 Sheesh, you need to unquote the references to get them expanded.

  Maciej
