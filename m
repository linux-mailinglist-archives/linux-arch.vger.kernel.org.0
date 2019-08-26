Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA3369CACF
	for <lists+linux-arch@lfdr.de>; Mon, 26 Aug 2019 09:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfHZHmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Aug 2019 03:42:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55080 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfHZHms (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 03:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lIut4B8w/K6qaNO5//JKDXgxZBzz15ddgNf2zVVfQ1E=; b=f6XJLfxeBVv9Hyb0B1vtj9oxL
        i8iw5LMMkKhG+T6Xu47kb2+iCLpMrKBQjXS1NBw74AP7B3pgxUBsbndSWQGizhRtNCAgW99j5+OeI
        c+T+1uJAk4oCoRSmOm0NE/wm6iL8VH+qSfESDzvXkGeSKy+GyCJWsD5r3LnItvz8EK4g8tAXBgRgi
        JMSMaRtxN+OddwD4UaHD/oWS7Za8/f15E/5LTf3nBtMiL8X2OQpSYRhvIozCuZOKt/2bBeTu5XD5k
        MSr7q1wHFvaw9hwCCzoDKZY0xDJWDWNsCSapSfqxfwjWoZuh5bxf2qBIOtw+RF3Jx2EN1us7T239k
        nCed49xqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i29dr-0004v1-6h; Mon, 26 Aug 2019 07:42:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3BB083075FE;
        Mon, 26 Aug 2019 09:41:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9740120B33552; Mon, 26 Aug 2019 09:42:15 +0200 (CEST)
Date:   Mon, 26 Aug 2019 09:42:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 03/11] asm-generic: add generic dwarf definition
Message-ID: <20190826074215.GL2369@hirez.programming.kicks-ass.net>
References: <20190825132330.5015-1-changbin.du@gmail.com>
 <20190825132330.5015-4-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190825132330.5015-4-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 25, 2019 at 09:23:22PM +0800, Changbin Du wrote:
> Add generic DWARF constant definitions. We will use it later.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  include/asm-generic/dwarf.h | 199 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>  create mode 100644 include/asm-generic/dwarf.h
> 
> diff --git a/include/asm-generic/dwarf.h b/include/asm-generic/dwarf.h
> new file mode 100644
> index 000000000000..c705633c2a8f
> --- /dev/null
> +++ b/include/asm-generic/dwarf.h
> @@ -0,0 +1,199 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Architecture independent definitions of DWARF.
> + *
> + * Copyright (C) 2019 Changbin Du <changbin.du@gmail.com>

You're claiming copyright on dwarf definitions? ;-)

I'm thinking only Oracle was daft enough to think stuff like that was
copyrightable.

Also; I think it would be very good to not use/depend on DWARF for this.

You really don't need all of DWARF; I'm thikning you only need a few
types; for location we already have regs_get_kernel_argument() which
has all the logic to find the n-th argument.

