Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2647CED5
	for <lists+linux-arch@lfdr.de>; Wed, 22 Dec 2021 10:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbhLVJIV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Dec 2021 04:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbhLVJIU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Dec 2021 04:08:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F77BC061574;
        Wed, 22 Dec 2021 01:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MFvE6YOOba0aemsOm0zG3CJGZiNw67vjwzqYsZ7WtJ4=; b=vgDsPBclfCZ3QPgUtaW5/sJ+cg
        YXanpyoCXeQLF9bOWsUk8Yy8qupG2Cbz1dd/uC9VmnX9NZrfl7LOL9WFgEihpWkrK/ug3lqUlh7cO
        87WL6xNlVgD2AkVyHXV6YUI5Jji9ztt5cq/DSB09NbbPzKTuWPanhoT+fnT3UsyyseaW8ZIbUzA4Z
        dEFIW7LYU9W3l4wwIPqbwZbS2fl0u35tDJsZ/J1mQdiZxEtUKSeY17wJZcCnzFlF48HfJe9skaBDt
        3q0JkijTpCP0P5cy4mpIt2YWj4uzXu6Yy6IztRczpWSsKSV/SeE/AZOmbHWMe4JZ/C+dCuXAg8/LU
        zcsZUl0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzxbb-009ped-Lg; Wed, 22 Dec 2021 09:08:15 +0000
Date:   Wed, 22 Dec 2021 01:08:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        moyufeng@huawei.com, linux-arch@vger.kernel.org
Subject: Re: [PATCH] asm-generic: introduce io_stop_wc() and add
 implementation for ARM64
Message-ID: <YcLq//2odC3GrGvH@infradead.org>
References: <20211217085611.111999-1-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217085611.111999-1-wangxiongfeng2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

So what is going to use this?
