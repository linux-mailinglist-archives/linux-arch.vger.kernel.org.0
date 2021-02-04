Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE5B30F10D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 11:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbhBDKiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 05:38:11 -0500
Received: from elvis.franken.de ([193.175.24.41]:51664 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235343AbhBDKiI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 05:38:08 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1l7c0m-0002Oa-00; Thu, 04 Feb 2021 11:37:20 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id DF6BFC0D52; Thu,  4 Feb 2021 11:34:59 +0100 (CET)
Date:   Thu, 4 Feb 2021 11:34:59 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     ambrosehua@gmail.com, Huang Pei <huangpei@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhc@lemote.com>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, Li Xuefeng <lixuefeng@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
Message-ID: <20210204103459.GA10558@alpha.franken.de>
References: <20210204013942.8398-1-huangpei@loongson.cn>
 <1612409285.q4gi3x2bhk.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612409285.q4gi3x2bhk.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 04, 2021 at 01:29:26PM +1000, Nicholas Piggin wrote:
> Excerpts from Huang Pei's message of February 4, 2021 11:39 am:
> > MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
> > + 2 TLB Invalid), butthe second TLB Invalid exception is just
> > triggered by __update_tlb from do_page_fault writing tlb without
> > _PAGE_VALID set. With this patch, user space mapping prot is made
> > young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
> > and it only take 1 TLB Miss + 1 TLB Invalid exception
> > 
> > Remove pte_sw_mkyoung without polluting MM code and make page fault
> > delay of MIPS on par with other architecture
> > 
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> 
> Could we merge this? For the core code,

sure, but IMHO I should only merge the MIPS part, correct ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
