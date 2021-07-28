Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2A3D9205
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 17:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhG1PcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 11:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235622AbhG1PcN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 11:32:13 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21C1060E09;
        Wed, 28 Jul 2021 15:32:11 +0000 (UTC)
Date:   Wed, 28 Jul 2021 11:32:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mingo@redhat.com>, <davem@davemloft.net>, <ast@kernel.org>,
        <ryabinin.a.a@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>
Subject: Re: [PATCH v2 6/7] sections: Add new is_kernel() and
 is_kernel_text()
Message-ID: <20210728113204.67fa6dfc@oasis.local.home>
In-Reply-To: <20210728081320.20394-7-wangkefeng.wang@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
        <20210728081320.20394-7-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 28 Jul 2021 16:13:19 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> @@ -64,8 +64,7 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
>  
>  int notrace core_kernel_text(unsigned long addr)
>  {
> -	if (addr >= (unsigned long)_stext &&
> -	    addr < (unsigned long)_etext)
> +	if (is_kernel_text(addr))

Perhaps this was a bug, and these functions should be checking the gate
area as well, as that is part of kernel text.

-- Steve


>  		return 1;
>  
>  	if (system_state < SYSTEM_RUNNING &&
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 884a950c7026..88f5b0c058b7 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -235,7 +235,7 @@ static void describe_object(struct kmem_cache *cache, void *object,
>  
>  static inline bool kernel_or_module_addr(const void *addr)
>  {
> -	if (addr >= (void *)_stext && addr < (void *)_end)
> +	if (is_kernel((unsigned long)addr))
>  		return true;
>  	if (is_module_address((unsigned long)addr))
>  		return true;
> -- 
