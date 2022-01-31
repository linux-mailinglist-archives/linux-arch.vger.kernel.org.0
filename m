Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18F34A46BE
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 13:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376652AbiAaMTl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 07:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377370AbiAaMTT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 07:19:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D61CC06173D;
        Mon, 31 Jan 2022 04:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=YFDDe5oib/xF9rn91S4g43Rqhm
        G5RyYVlxzee62HumiUjUwRN5/WZwivUW+Do4klh4KThptaCn3Ire78uK3IfcDa3xjV2APYs0Fnt+H
        49djOCYkLbporPC+wJGvyhKobjjvOakfIUHuB+jH6mUs8mQzIFxHEGL8U1k8iaqzakEHIup6XqFId
        0rZoERJzMVUf/pGMhuqnQucX3J6B9e0dmQh+LeQqWbRqvKgupMzTu7PgbzqPhaN6J5zS++ikTBiJA
        gsfLY0Xq9lG/UqCLoDBs4RJPlj/YMDt4O+NLOVNXlX+TSKxA2UloYw8OgqsByonZ/1pyKnm+TDqtJ
        82mb9G1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEVe8-009INd-1R; Mon, 31 Jan 2022 12:19:00 +0000
Date:   Mon, 31 Jan 2022 04:19:00 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     guoren@kernel.org
Cc:     palmer@dabbelt.com, arnd@arndb.de, anup@brainfault.org,
        gregkh@linuxfoundation.org, liush@allwinnertech.com,
        wefu@redhat.com, drew@beagleboard.org, wangjunqiang@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 01/17] kconfig: Add SYSVIPC_COMPAT for all
 architectures
Message-ID: <YffTtHYdvZA9kGLY@infradead.org>
References: <20220129121728.1079364-1-guoren@kernel.org>
 <20220129121728.1079364-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129121728.1079364-2-guoren@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
