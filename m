Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A0348D98
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 11:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCYKBb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 06:01:31 -0400
Received: from elvis.franken.de ([193.175.24.41]:58851 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCYKBM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 06:01:12 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lPMnd-00074f-03; Thu, 25 Mar 2021 11:01:09 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 44236C1C81; Thu, 25 Mar 2021 11:00:09 +0100 (CET)
Date:   Thu, 25 Mar 2021 11:00:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: Re: [PATCH] MIPS: loongson64: fix bug when PAGE_SIZE > 16KB
Message-ID: <20210325100009.GD5775@alpha.franken.de>
References: <20210324032451.27569-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324032451.27569-1-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 24, 2021 at 11:24:51AM +0800, Huang Pei wrote:
> When page size larger than 16KB, arguments "vaddr + size(16KB)" in
> "ioremap_page_range(vaddr, vaddr + size,...)" called by
> "add_legacy_isa_io" is not page-aligned.
> 
> As loongson64 needs at least page size 16KB to get rid of cache alias,
> and "vaddr" is 64KB-aligned, and 64KB is largest page size supported,
> rounding "size" up to PAGE_SIZE is enough for all page size supported.
> 
> Fixes: 6d0068ad15e4 ("MIPS: Loongson64: Process ISA Node in DeviceTree")
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/loongson64/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
