Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C22833A4F2
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 14:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhCNNMU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 09:12:20 -0400
Received: from elvis.franken.de ([193.175.24.41]:57616 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235420AbhCNNMS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 14 Mar 2021 09:12:18 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lLQXO-0007q5-00; Sun, 14 Mar 2021 14:12:06 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7979DC214A; Sun, 14 Mar 2021 14:06:42 +0100 (CET)
Date:   Sun, 14 Mar 2021 14:06:42 +0100
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
Subject: Re: [PATCH V5] MIPS: clean up MIPS_PGD_C0_CONTEXT
Message-ID: <20210314130642.GA5165@alpha.franken.de>
References: <20210313013927.26733-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313013927.26733-1-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Mar 13, 2021 at 09:39:26AM +0800, Huang Pei wrote:
> V5:
> 
> correct the calculation error in commit and reformat the patch

no need for a cover letter for a single patch. Please put the patch
version into the patch subject itself (PATCH v5) and the version
history below the --- line after the diffstat.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
