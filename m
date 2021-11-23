Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906C245A224
	for <lists+linux-arch@lfdr.de>; Tue, 23 Nov 2021 13:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbhKWMF3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Nov 2021 07:05:29 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:58378 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhKWMF2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Nov 2021 07:05:28 -0500
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Nov 2021 07:05:27 EST
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 4DE03233DF2D
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Message-ID: <f40206d8-2563-f1aa-8494-715406463bbe@omp.ru>
Date:   Tue, 23 Nov 2021 14:55:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 6/6] MIPS: loongson64: fix FTLB configuration
Content-Language: en-US
To:     Huang Pei <huangpei@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <ambrosehua@gmail.com>
CC:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mips@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhuacai@loongson.cn>
References: <20211123074927.12461-1-huangpei@loongson.cn>
 <20211123074927.12461-7-huangpei@loongson.cn>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <20211123074927.12461-7-huangpei@loongson.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

On 23.11.2021 10:49, Huang Pei wrote:

> Commit "da1bd29742b1" makes 'set_ftlb_enable' called under

    You should cite the commit the same way as in the Fixes: tag (except you 
can break up the long lines).

> c->cputype unset, which leaves FTLB disabled on BOTH 3A2000
> and 3A3000
> 
> Fixes: da1bd29742b1 ("MIPS: Loongson64: Probe CPU features via CPUCFG")
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
[...]

MBR, Sergey
