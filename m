Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA830401A63
	for <lists+linux-arch@lfdr.de>; Mon,  6 Sep 2021 13:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241296AbhIFLJJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Sep 2021 07:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241269AbhIFLJJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Sep 2021 07:09:09 -0400
X-Greylist: delayed 148205 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Sep 2021 04:08:04 PDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B800DC061575;
        Mon,  6 Sep 2021 04:08:04 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 3BA0892009C; Mon,  6 Sep 2021 13:08:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3676E92009B;
        Mon,  6 Sep 2021 13:08:02 +0200 (CEST)
Date:   Mon, 6 Sep 2021 13:08:02 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     =?UTF-8?B?6buE5rKb?= <huangpei@loongson.cn>
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
In-Reply-To: <20210905004810.5783639.10620.10055@loongson.cn>
Message-ID: <alpine.DEB.2.21.2109061306140.38640@angie.orcam.me.uk>
References: <20210904151218.10167-1-huangpei@loongson.cn> <alpine.DEB.2.21.2109041955310.38640@angie.orcam.me.uk> <20210905004810.5783639.10620.10055@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 5 Sep 2021, 黄沛 wrote:

> You mean including  asm/asm.h? 
> 
> or redefine LONG_ADDU as ** "addu " ** in asm/llsc.h?

 Use the existing macros, they're there for this purpose and widely used 
throughout the port already.

  Maciej
