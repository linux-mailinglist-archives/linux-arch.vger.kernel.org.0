Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C48E459EBF
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 10:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhKWJE2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 04:04:28 -0500
Received: from elvis.franken.de ([193.175.24.41]:36883 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235319AbhKWJAq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Nov 2021 04:00:46 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mpRcJ-0006gd-00; Tue, 23 Nov 2021 09:57:31 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 104BBC2EF3; Tue, 23 Nov 2021 09:56:49 +0100 (CET)
Date:   Tue, 23 Nov 2021 09:56:48 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V2]: bugfix
Message-ID: <20211123085648.GA5995@alpha.franken.de>
References: <20211123074927.12461-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123074927.12461-1-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 23, 2021 at 03:49:21PM +0800, Huang Pei wrote:
> V2:
> 
> +. fix warning message when building "slip" and "hamradio"
> 
> +. Indexed cache instruction CAN NOT handle cache alias, just remove the
> detection for "cpu_has_dc_alias" 
> 
> +. improve commit message
> 

please don't mix MIPS fixes with other independent driver updates in one
series.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
