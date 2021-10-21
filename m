Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3B436006
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 13:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJULOi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 07:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJULOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 07:14:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D441C06161C;
        Thu, 21 Oct 2021 04:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ot6BoOREJVsPeSpSVlitYEN/YRc+jriHmGG5NiWBxhk=; b=4pH7raY1P8DEgo9UWXVTxSKn2r
        dCQ6xggO9wUyU30/QgWYxLSUScN0fc7KUhfPbKptPCZmPCKJBqcahrNcRz36GrlU8+2qlNmxVk6yn
        gif0BU0JJehvSlypk45tomMwxOifUrInkbn7fUJ+HeMciMdM0ErxDFem+VoVMXJiQJTT1jtmZo5yA
        +I9X6thSoHQAxnj8xLkMdVZrdYq/2RgS07kropx1qzAWPvI4Up6uIyzOiXCZ7E/sXgsdQvq/E4cQZ
        ypbHMUTzgoqP/clVvTZP7ieLgkXfK2mLGCSYIFSA7o6YGVw1Bqp/9pNRsXu8hwRjHUeXiAZFm16Jo
        INn1t8TA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdVzh-007JwJ-5C; Thu, 21 Oct 2021 11:12:21 +0000
Date:   Thu, 21 Oct 2021 04:12:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 12/20] exit/kthread: Have kernel threads return instead
 of calling do_exit
Message-ID: <YXFLFUjGsvdK13Sa@infradead.org>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-12-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-12-ebiederm@xmission.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 12:43:58PM -0500, Eric W. Biederman wrote:
> In 2009 Oleg reworked[1] the kernel threads so that it is not
> necessary to call do_exit if you are not using kthread_stop().  Remove
> the explicit calls of do_exit and complete_and_exit (with a NULL
> completion) that were previously necessary.

With this we should also be able to drop the export for do_exit.
