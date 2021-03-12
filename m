Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C69D6338A37
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 11:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhCLKep (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Mar 2021 05:34:45 -0500
Received: from elvis.franken.de ([193.175.24.41]:52589 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233329AbhCLKel (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Mar 2021 05:34:41 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lKf7u-0007WV-01; Fri, 12 Mar 2021 11:34:38 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E1643C1E4A; Fri, 12 Mar 2021 11:27:09 +0100 (CET)
Date:   Fri, 12 Mar 2021 11:27:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Subject: Re: [PATCH 2/2] MIPS: loongson64: alloc pglist_data at run time
Message-ID: <20210312102709.GB7027@alpha.franken.de>
References: <20210309080210.25561-1-huangpei@loongson.cn>
 <20210309080210.25561-3-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309080210.25561-3-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 09, 2021 at 04:02:10PM +0800, Huang Pei wrote:
> Loongson64 allocates arrays of pglist_data statically and is located
> at Node 0, and cpu from Nodes other than 0 need remote access to
> pglist_data and zone info.
> 
> Delay pglist_data allocation till run time, and make it NUMA-aware
> 
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/loongson64/numa.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

applied to mips-next.

This patch looks independant from the first one in this series (that's
why I've applied it). So please post such patches as single patches
and not as series.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
