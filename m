Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1682A2B4B51
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 17:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgKPQf3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 11:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730661AbgKPQf3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 11:35:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0934BC0613CF;
        Mon, 16 Nov 2020 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lsCQTKnHxur9/zEdCsChRHyPn3npRYu7yGgCY+aF/tA=; b=PQA+A7t+gCs0zUxiQKBdASltCh
        k65Y3YIv5tIG+e0b07GK4b7OQRGdhqO7WLM+rLEGZirwiGzHJEHGP7QeQkxgZMyYUBfr2jqUgipZP
        JCQpQXb+8d0GtvfrcOB8UjlMLogqZtAhZDAQVPIQd7R4/QGohEmElb7OZzlP7AhTG6GMniWhxEPat
        23dpohFYjUT49Z3rCb7MtXqVYohtzztc3Ul+JxWhw2BSPjrglMoot5KbzGtWpJ20zRzvaaOIbApPx
        OZbFcSKLq3mOfYZhy0qICwd7tAy6Yf/ygnTPTw5A3F23SYdfy5+sIlzeHDf4qp30QBD38I7uYWxTE
        +KT7xB+w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehTP-0004zh-9K; Mon, 16 Nov 2020 16:35:23 +0000
Date:   Mon, 16 Nov 2020 16:35:23 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     zengzhaoxiu@163.com
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 1/3] lib: Introduce copy_from_back()
Message-ID: <20201116163523.GA18835@infradead.org>
References: <20201109191601.14053-1-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109191601.14053-1-zengzhaoxiu@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Nov 10, 2020 at 03:16:01AM +0800, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Copying the matched bytes from the back output buffer is the
> key code of the LZ decompression algorithm which used by zlib, lzo, etc.
> 
> This patch introduce the optimized copy_from_back function.
> The function will be used by later patches in this series.
> 
> Optimization for a specific architecture will be available in the future.
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Please use mandatory-y in include/asm-generic/Kbuild for the case where
we have a sensible default that only a few architectures want to
override.
