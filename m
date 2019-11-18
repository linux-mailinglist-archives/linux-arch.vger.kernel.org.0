Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA8100D52
	for <lists+linux-arch@lfdr.de>; Mon, 18 Nov 2019 21:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKRUy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Nov 2019 15:54:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbfKRUy6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 Nov 2019 15:54:58 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2A42230C;
        Mon, 18 Nov 2019 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574110498;
        bh=TCcCWzt+woiXDfMa33gUEmmxlLgYw/oRawWE+pFh2tQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fw3Oo/M7wub+tVFG/tjWRtkQo9IgZ1fCUAsprnMwj9wsIN3hb7axv3ZE2JmIchCPt
         Mc5MFm+xg8eLnKiLlotW7GUMBcNjaoWHQ5GoqXkv0dbNx0LVDQa/ybIC60+wOLnd11
         E0QC5jRjM9F2aKqy7plh2+VrGWz0YLhrAqt9XIY0=
Date:   Mon, 18 Nov 2019 12:54:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
Message-Id: <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
In-Reply-To: <20191118145114.GA9228@avx2>
References: <20191118145114.GA9228@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 18 Nov 2019 17:51:15 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> PT_GNU_STACK is fail open design,

Not sure what this means.  Please expand on the motivation for this
change.

> at least warn people that something
> isn't right.

People who use an executable stack get a kernel splat.  How is that
useful?

> ...
>
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
>  		goto out_unlock;
>  	BUG_ON(prev != vma);
>  
> +#ifdef CONFIG_MMU
> +	if (vm_flags & VM_EXEC) {
> +		pr_warn_once("process '%s'/%u started with executable stack\n",
> +			     current->comm, current->pid);
> +	}
> +#endif
>
>  	/* Move stack pages down in memory. */
>  	if (stack_shift) {
>  		ret = shift_arg_pages(vma, stack_shift);

