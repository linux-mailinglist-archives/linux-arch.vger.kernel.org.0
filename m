Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A22382425
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhEQGVi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 02:21:38 -0400
Received: from verein.lst.de ([213.95.11.211]:56077 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhEQGVi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 02:21:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 465B36736F; Mon, 17 May 2021 08:20:18 +0200 (CEST)
Date:   Mon, 17 May 2021 08:20:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org
Subject: Re: [PATCH 5/6] [v2] asm-generic: uaccess: remove inline
 strncpy_from_user/strnlen_user
Message-ID: <20210517062018.GC23581@lst.de>
References: <20210515101803.924427-1-arnd@kernel.org> <20210515101803.924427-6-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515101803.924427-6-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 15, 2021 at 12:18:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Consolidate the asm-generic implementation with the library version
> that is used everywhere else.
> 
> These are the three versions for NOMMU kernels,

I don't get the three versions part?

> +	select GENERIC_STRNCPY_FROM_USER
> +	select GENERIC_STRNLEN_USER

Given that most architetures select the generic version I wonder
if it might be worth to add another patch to invert the logic so
that architectures with their own implementation need to sekect a symbol.

> +extern long strncpy_from_user(char *dst, const char __user *src, long count);
> +extern long strnlen_user(const char __user *src, long n);

No need for the extern here.
