Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1733A3D90E6
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 16:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236959AbhG1Oqw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 10:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235521AbhG1Oqw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jul 2021 10:46:52 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4215C60527;
        Wed, 28 Jul 2021 14:46:49 +0000 (UTC)
Date:   Wed, 28 Jul 2021 10:46:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <mingo@redhat.com>, <davem@davemloft.net>, <ast@kernel.org>,
        <ryabinin.a.a@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        "Sergey Senozhatsky" <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 2/7] kallsyms: Fix address-checks for kernel related
 range
Message-ID: <20210728104642.7ae75442@oasis.local.home>
In-Reply-To: <20210728081320.20394-3-wangkefeng.wang@huawei.com>
References: <20210728081320.20394-1-wangkefeng.wang@huawei.com>
        <20210728081320.20394-3-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 28 Jul 2021 16:13:15 +0800
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> The is_kernel_inittext/is_kernel_text/is_kernel function should not
> include the end address(the labels _einittext, _etext and _end) when
> check the address range, the issue exists since Linux v2.6.12.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
>  include/linux/kallsyms.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/kallsyms.h b/include/linux/kallsyms.h
> index 2a241e3f063f..b016c62f30a6 100644
> --- a/include/linux/kallsyms.h
> +++ b/include/linux/kallsyms.h
> @@ -27,21 +27,21 @@ struct module;
>  static inline int is_kernel_inittext(unsigned long addr)
>  {
>  	if (addr >= (unsigned long)_sinittext
> -	    && addr <= (unsigned long)_einittext)
> +	    && addr < (unsigned long)_einittext)
>  		return 1;
>  	return 0;
>  }
>  
>  static inline int is_kernel_text(unsigned long addr)
>  {
> -	if ((addr >= (unsigned long)_stext && addr <= (unsigned long)_etext))
> +	if ((addr >= (unsigned long)_stext && addr < (unsigned long)_etext))
>  		return 1;
>  	return in_gate_area_no_mm(addr);
>  }
>  
>  static inline int is_kernel(unsigned long addr)
>  {
> -	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_end)
> +	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
>  		return 1;
>  	return in_gate_area_no_mm(addr);
>  }

