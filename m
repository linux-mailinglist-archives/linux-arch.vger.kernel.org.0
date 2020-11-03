Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27ED2A3F04
	for <lists+linux-arch@lfdr.de>; Tue,  3 Nov 2020 09:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKCIgd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Nov 2020 03:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCIgd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Nov 2020 03:36:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F43C0613D1;
        Tue,  3 Nov 2020 00:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p2+IvEtdtWCmvisNOmqwSnvZlUcrAuVawfWSleu7q8c=; b=RMWgmuD4PLk7JezIvmM/i8UemI
        sUcOJu3DllUClo3roN1WL3Ve3ZUiOxapADIgmpfVgC8tQ3yF75Lq7/hHuwknHWzSJMejdG2Uf/jeR
        Oix8BJs7KEFchVN4q5IPD+2jI7TSqZNKJWweYSklL2r2P3I6xwlsCZbIcxLZ6v7f5XzkavPLUCTkd
        dgw/B88l3ly8Xn5upD9Bx4Cp8iBfJuCSeEZrNRVQb71qw7sL0GIRECHpWVcpUR8NAMIiraO/8zxYa
        X6TPzMEHt4zzhDqT3BIw2/C02Q5SOeuI8H/bAhYGVdLutucLxhbI89GrwEwZJKNNZX+zqWfI8GOQ0
        x2EjEWXQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZrno-0002di-Uj; Tue, 03 Nov 2020 08:36:29 +0000
Date:   Tue, 3 Nov 2020 08:36:28 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 2/4] mm: simplify compat_sys_move_pages
Message-ID: <20201103083628.GC9092@infradead.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
 <20201102123151.2860165-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102123151.2860165-3-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
> +		       compat_uptr_t __user *, pages,
>  		       const int __user *, nodes,
>  		       int __user *, status,
>  		       int, flags)
>  {
> +	return kernel_move_pages(pid, nr_pages,
> +				 (const void __user *__user *)pages,
> +				 nodes, status, flags);
>  }

Same as for kexec - all the compat syscall tables can just point to
the native version now.
