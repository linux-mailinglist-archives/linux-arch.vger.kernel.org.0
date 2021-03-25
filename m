Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DF8349A87
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 20:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhCYTjM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 15:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhCYTit (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:49 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253BD619C9;
        Thu, 25 Mar 2021 19:38:47 +0000 (UTC)
Date:   Thu, 25 Mar 2021 15:38:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/6] MIPS: move FTRACE_SYSCALLS from ftrace.c into
 syscall.c
Message-ID: <20210325153845.759b242e@gandalf.local.home>
In-Reply-To: <20210313064149.29276-3-huangpei@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
        <20210313064149.29276-3-huangpei@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 13 Mar 2021 14:41:45 +0800
Huang Pei <huangpei@loongson.cn> wrote:

Why?

-- Steve

> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/kernel/Makefile  |  1 -
>  arch/mips/kernel/ftrace.c  | 33 ---------------------------------
>  arch/mips/kernel/syscall.c | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 34 deletions(-)

