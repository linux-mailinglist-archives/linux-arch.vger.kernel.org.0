Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4612B4CA9
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732785AbgKPRYk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 12:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732722AbgKPRYj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2020 12:24:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C882AC0613CF;
        Mon, 16 Nov 2020 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=as7Ofxnf4henLaDv5k+5jutbpCtk1PuRyVgEti8GzUM=; b=K4am1h8fWJBd8S5IKWPhmqbW2j
        soYhtrp8quVS5F7yqcRYqewc14MWpvoF+VOIcp7EDcU3wrLAjiFMqATbLK1hajXISbTdTTsPSDGmM
        OvzzW03I9nXQOW6AYim37aZjsfYRag7wMOpnISTHGfbGMpe+E7/l1Da03tLmg6lsdfomju5uv89W/
        gSUrF8SZq54oQsGM6cToO8R6vOnwJdOLd9kkjcf6FpTlHHFv+YyiObxllVt9LubbbhL43rTI/IhRh
        9WYSGvhV50CNQbmM81LQwkG6eDj1ufUnLAY7yt4ly9uctv5kVJD9uQjZcnrTSRcf9Lk4clkg4MgXX
        sG5LfyBQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keiF1-00089O-UZ; Mon, 16 Nov 2020 17:24:36 +0000
Date:   Mon, 16 Nov 2020 17:24:35 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Zhaoxiu Zeng <zengzhaoxiu@163.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: Re: [PATCH 1/3] lib: Introduce copy_from_back()
Message-ID: <20201116172435.GA29722@infradead.org>
References: <20201109191601.14053-1-zengzhaoxiu@163.com>
 <20201116163523.GA18835@infradead.org>
 <092552df-204e-beee-58f8-da194b866d0f@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <092552df-204e-beee-58f8-da194b866d0f@163.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> +#define FAST_COPY_SAFEGUARD_SIZE (sizeof(long) * 2 - 1)
> +
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +
> +/*
> + * The caller must ensure that the output buffer has enough space (len + FAST_COPY_SAFEGUARD_SIZE),
> + * so we can write 2 words per loop without overflowing the output buffer
> + */
> +static __always_inline u8 *copy_from_back_fast(u8 *out, size_t dist, size_t len)

The code is pretty unreadable with these longs lines.  Please stick to
the normal 80 char limit.
