Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB3E490949
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 14:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiAQNRV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 08:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiAQNRV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 08:17:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F5AC061574;
        Mon, 17 Jan 2022 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M9exD+0mSZV5zshmIjYqewxjSFmbeYhsURfGwRHsD/0=; b=I4Y/ge7URb+P6waigQZLZBZ75x
        MYV/OcmDLfED8AjK3HXexN+U0fdx6CiJGPLH7dXYttU31dUXOWYEka8t9Z7xZMWP6GHPQXjvzlrA1
        kgtx5lhlJeMSCUa89a4jHxVIgDta104zzD37PCINvUZKXIyI9bCkBWgBDhj8kvkJ+sR/EhKALX2qd
        pRn1YQIj8amBFswmI3AtV95HuDdtqbBa2OTdCGrFWjoQiKQJ5236O90QTiCfYPkgPiMFrTOVXYeFH
        dJOlWdOO8QTuKYNydvEKySQklRyDZ4FQckDSxWLHn5BOMEgbgc14AQ3XmAEw9u6WYk5a2R9zvaLZp
        I1TjSldw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9Rsp-00F280-08; Mon, 17 Jan 2022 13:17:15 +0000
Date:   Mon, 17 Jan 2022 05:17:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
Message-ID: <YeVsWgw188lDJkbn@infradead.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-3-ebiederm@xmission.com>
 <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
 <87tuefwewa.fsf@email.froward.int.ebiederm.org>
 <YeUjVZX764zLm9/K@infradead.org>
 <YeVd7xj2Lwyp4QB1@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeVd7xj2Lwyp4QB1@osiris>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 17, 2022 at 01:15:43PM +0100, Heiko Carstens wrote:
> > I really need help from the arch maintainers to finish the set_fs
> > removal.  There have been very few arch maintainers helping with that
> > work (arm, arm64, parisc, m68k) in addition to the ones I did because
> > I have the test setups and knowledge.  I'll send out another ping,
> 
> Just in case you missed it: s390 was converted with commit 87d598634521
> ("s390/mm: remove set_fs / rework address space handling").

Sorry, I forgot about s390, which as often was a model citizen here!
