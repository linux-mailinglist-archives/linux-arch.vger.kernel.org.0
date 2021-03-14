Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A052D33A88B
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 23:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhCNWcV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 18:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCNWbx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 18:31:53 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B115C061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 15:31:52 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 236A392009C; Sun, 14 Mar 2021 23:31:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 173A192009B;
        Sun, 14 Mar 2021 23:31:50 +0100 (CET)
Date:   Sun, 14 Mar 2021 23:31:49 +0100 (CET)
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
        Jinyang He <hejinyang@loongson.cn>
Subject: Re: [PATCH V4]: minor cleanup and improvement
In-Reply-To: <20210309080210.25561-1-huangpei@loongson.cn>
Message-ID: <alpine.DEB.2.21.2103142326220.33195@angie.orcam.me.uk>
References: <20210309080210.25561-1-huangpei@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 9 Mar 2021, Huang Pei wrote:

> [PATCH 1/2] V4 vs V3:

 It will help if you don't change the subject proper of the cover letter 
with every iteration of a patch series, as in that case mail user agents 
(at least the sane ones) will group all iterations together in the thread 
sorting mode.  With the subject changed every time the link is lost and 
submissions are scattered all over the mail folder.

  Maciej
