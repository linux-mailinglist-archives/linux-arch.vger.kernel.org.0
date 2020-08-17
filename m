Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3B5246749
	for <lists+linux-arch@lfdr.de>; Mon, 17 Aug 2020 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgHQNYx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Aug 2020 09:24:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbgHQNYw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Aug 2020 09:24:52 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7A00CE75938667D035FB;
        Mon, 17 Aug 2020 21:24:10 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.19) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 21:24:04 +0800
Subject: Re: [PATCH v4 6/8] mm: Move vmap_range from lib/ioremap.c to
 mm/vmalloc.c
To:     Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <john.wanghui@huawei.com>
References: <20200816090904.83947-1-npiggin@gmail.com>
 <20200816090904.83947-7-npiggin@gmail.com>
From:   Tang Yizhou <tangyizhou@huawei.com>
Message-ID: <27dd4db0-00e1-383a-f276-1622b2e68a4d@huawei.com>
Date:   Mon, 17 Aug 2020 21:23:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200816090904.83947-7-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.19]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nicholas,

We may change the title as follows:
mm: Move vmap_range from mm/ioremap.c to mm/vmalloc.c

Yizhou

