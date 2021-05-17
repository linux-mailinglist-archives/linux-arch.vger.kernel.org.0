Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53023382406
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 08:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhEQGR4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 02:17:56 -0400
Received: from verein.lst.de ([213.95.11.211]:56020 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234737AbhEQGR4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 May 2021 02:17:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E9B8E6736F; Mon, 17 May 2021 08:16:35 +0200 (CEST)
Date:   Mon, 17 May 2021 08:16:35 +0200
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
Subject: Re: [PATCH 3/6] [v2] hexagon: use generic strncpy/strnlen from_user
Message-ID: <20210517061635.GA23581@lst.de>
References: <20210515101803.924427-1-arnd@kernel.org> <20210515101803.924427-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515101803.924427-4-arnd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 15, 2021 at 12:18:00PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most per-architecture versions of these functions are broken in some form,
> and they are almost certainly slower than the generic code as well.
> 
> Remove the ones for hexagon and instead use the generic version.
> This custom version reads the data twice for strncpy() by doing an extra
> strnlen(), and it apparently lacks a check for user_addr_max().

I'd be tempted to just remove the first paragraph and reword the second
as:

Remove the hexagon implementation of strncpy/strnlen and instead use the
generic versions.  The hexago version of strncpy reads the data twice by
doing an extra strnlen(), and it apparently lacks a check for
user_addr_max().
