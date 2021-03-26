Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464F834A99B
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 15:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZOXb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Fri, 26 Mar 2021 10:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhCZOXY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 10:23:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8087261A24;
        Fri, 26 Mar 2021 14:23:22 +0000 (UTC)
Date:   Fri, 26 Mar 2021 10:23:21 -0400
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/6] kprobes/ftrace: Use ftrace_location() when
 [dis]arming probes
Message-ID: <20210326102321.666afcc5@gandalf.local.home>
In-Reply-To: <F3EABE66-8F6A-4F12-A8D7-E5653C616AA4@loongson.cn>
References: <20210313064149.29276-1-huangpei@loongson.cn>
        <20210313064149.29276-5-huangpei@loongson.cn>
        <20210325154433.7ed7e56a@gandalf.local.home>
        <F3EABE66-8F6A-4F12-A8D7-E5653C616AA4@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 26 Mar 2021 22:12:18 +0800
Huang Pei <huangpei@loongson.cn> wrote:

> Patch 4/5 is from arm64’s KPROBES_ON_FTRACE,  I think which is needed by
> all RISC with both KPROBES_ON_FTRACE and -fpatchable-function-entry.
> 
> But since V7, no further patches are released, what protocol should I follow if
> I need these two patches?
> 

If you need this patch, just resend it, but with the proper author. If you
look at the thread I linked to, Jisheng pointed out that the From line that
held the proper author was missing from the patch.

You'll need that.

-- Steve

