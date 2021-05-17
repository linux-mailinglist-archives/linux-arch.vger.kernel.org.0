Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178083829CB
	for <lists+linux-arch@lfdr.de>; Mon, 17 May 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236247AbhEQK3j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 May 2021 06:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbhEQK3j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 May 2021 06:29:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79830C061573;
        Mon, 17 May 2021 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rLb4WLtzCt3pie0yCq3Bk7nNX431oFC9urgUQrI6e5M=; b=T5KqDgEGebvZJeUWDVNQiDGwTa
        NNoHyW62q49jKgsXYwK78QaPy5xeR4Cg/M8rc170REZY7NOLg+DyyF+lumRmJCniHnJ4EbuB7Nm8x
        NzVUVDZhY2i47siTBq+19E7YR85JnNgxkw11HHMLdUywbB7O/PgKz4B7zshG75IX/cvXVzylxlN5a
        7QJmwg+5Q/5ZrxS44koU4mUR8YBwkvoAP4CopaYteTco7rDPpgzY2KYkGcYt3vs5Mp+bN3ianV7Rt
        3O7mA+H269wN+6wVra9xssfzah82jROCgcmcGkpLwEK2jmqGfG/hmOGg3ps1scoFK37oNlRQHZsJo
        BKrTpFLw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1liaU0-00Co94-3k; Mon, 17 May 2021 10:28:20 +0000
Date:   Mon, 17 May 2021 11:28:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/13] partitions: msdos: fix one-byte get_unaligned()
Message-ID: <YKJFRBynJXoFtTyy@infradead.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-9-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514100106.3404011-9-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 14, 2021 at 12:00:56PM +0200, Arnd Bergmann wrote:
>  /* Borrowed from msdos.c */
> -#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
> +#define SYS_IND(p)		((p)->sys_ind)

Please just kill this macro entirely.

> -#define SYS_IND(p)	get_unaligned(&p->sys_ind)
> +#define SYS_IND(p)	(p->sys_ind)

Same here.
