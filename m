Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D34026AC
	for <lists+linux-arch@lfdr.de>; Tue,  7 Sep 2021 12:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhIGKB4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Sep 2021 06:01:56 -0400
Received: from angie.orcam.me.uk ([78.133.224.34]:33242 "EHLO
        angie.orcam.me.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhIGKB4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Sep 2021 06:01:56 -0400
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 415F392009C; Tue,  7 Sep 2021 12:00:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3AD2492009B;
        Tue,  7 Sep 2021 12:00:48 +0200 (CEST)
Date:   Tue, 7 Sep 2021 12:00:48 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     loongson <huangpei@loongson.cn>
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
In-Reply-To: <6113C299-3E26-4445-97FD-32690FD91C95@loongson.cn>
Message-ID: <alpine.DEB.2.21.2109070317000.38640@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2109061827590.38640@angie.orcam.me.uk> <6113C299-3E26-4445-97FD-32690FD91C95@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 7 Sep 2021, loongson wrote:

> Please show me your code

 See commit e496453d3e15.  You may get inspiration from <asm/stacktrace.h> 
too.

> This email and its attachments contain confidential information from 
> Loongson Technology , which is intended only for the person or entity 
> whose address is listed above. Any use of the information contained 
> herein in any way (including, but not limited to, total or partial 
> disclosure, reproduction or dissemination) by persons other than the 
> intended recipient(s) is prohibited. If you receive this email in error, 
> please notify the sender by phone or email immediately and delete it.

 Your message has hit public mailing list archives already I'm afraid.

  Maciej
