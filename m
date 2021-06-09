Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7720A3A085E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 02:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhFIA15 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 20:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234717AbhFIA1z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 20:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F5CF61352;
        Wed,  9 Jun 2021 00:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623198345;
        bh=j6Daa0ANcHXgawdprrhhE9gPp/k5n5R1I8bzEIzLkJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SZYHTTfaMcaxuiVLTcleHa9xYaQtKKlW0lSVx8ank0QE87umgBXHwANYgV3RZTaNu
         rf7Ir5wxGLTzdarw+lfYNOq0SOvDo1l3StstPYzKpK2C8V7G7swvSJ4cooRpaDMdu2
         H1uHQBHkLxKC0zrfLh/KxjIWjXc3HCBsO4EPTYqY=
Date:   Tue, 8 Jun 2021 17:25:44 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 8/9] mm: replace CONFIG_NEED_MULTIPLE_NODES with
 CONFIG_NUMA
Message-Id: <20210608172544.d9bf17549565d866fbb18451@linux-foundation.org>
In-Reply-To: <20210608091316.3622-9-rppt@kernel.org>
References: <20210608091316.3622-1-rppt@kernel.org>
        <20210608091316.3622-9-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue,  8 Jun 2021 12:13:15 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> After removal of DISCINTIGMEM the NEED_MULTIPLE_NODES and NUMA
> configuration options are equivalent.
> 
> Drop CONFIG_NEED_MULTIPLE_NODES and use CONFIG_NUMA instead.
> 
> Done with
> 
> 	$ sed -i 's/CONFIG_NEED_MULTIPLE_NODES/CONFIG_NUMA/' \
> 		$(git grep -wl CONFIG_NEED_MULTIPLE_NODES)
> 	$ sed -i 's/NEED_MULTIPLE_NODES/NUMA/' \
> 		$(git grep -wl NEED_MULTIPLE_NODES)
> 
> with manual tweaks afterwards.
> 
> ...
>
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -987,7 +987,7 @@ extern int movable_zone;
>  #ifdef CONFIG_HIGHMEM
>  static inline int zone_movable_is_highmem(void)
>  {
> -#ifdef CONFIG_NEED_MULTIPLE_NODES
> +#ifdef CONFIG_NUMA
>  	return movable_zone == ZONE_HIGHMEM;
>  #else
>  	return (ZONE_MOVABLE - 1) == ZONE_HIGHMEM;

I dropped this hunk - your "mm/mmzone.h: simplify is_highmem_idx()"
removed zone_movable_is_highmem().  
