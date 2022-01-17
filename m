Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515ED49036D
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 09:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbiAQIFp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 03:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiAQIFo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 03:05:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F19C061574;
        Mon, 17 Jan 2022 00:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CSEVknsdd7jDGJj+3PvcdmkBUO+zpH4Q7qOdN2vWYaY=; b=japM3XqNI+Dx0lALW0GaEe2xjT
        vIodQmY8ICdBCuHjUY6i4iepf96oIOeifs/CXf4td3IumFSZFhtStocTjYxMbWXB9YG2yPBoU3xN5
        y0OfXEJkV/wS5OXyhat5lhjFOcGs0hH85ATVPwTMFj0Rm8UnLnURvsk0tyEvJ2XSLr3scv/inKpIm
        vqReXLMi8hcRlRSeplMAq5FLawt5/LeBgNficloBagWsizuJO5v+sY5MZEQc8MyiMHvilj1Pt3hf5
        vbTvLRZRBHk6NwzpFu/2aI+isadj7VHgbljiCW4xNzOXJuFv+bzRUooW+B/KD/WPPqCVlxz9KjnGw
        de+xyYXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9N1J-00E1Uy-VU; Mon, 17 Jan 2022 08:05:41 +0000
Date:   Mon, 17 Jan 2022 00:05:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 03/10] exit: Move oops specific logic from do_exit into
 make_task_dead
Message-ID: <YeUjVZX764zLm9/K@infradead.org>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-3-ebiederm@xmission.com>
 <YdUxGKRcSiDy8jGg@zeniv-ca.linux.org.uk>
 <87tuefwewa.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuefwewa.fsf@email.froward.int.ebiederm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 07, 2022 at 12:59:33PM -0600, Eric W. Biederman wrote:
> Assuming it won't be too much longer before the rest of the arches have
> set_fs/get_fs removed it looks like it makes sense to leave the
> force_uaccess_begin where it is, and just let force_uaccess_begin be
> removed when set_fs/get_fs are removed from the tree.
> 
> Christoph does it look like the set_fs/get_fs removal work is going
> to stall indefinitely on some architectures?  If so I think we want to
> find a way to get kernel threads to run with set_fs(USER_DS) on the
> stalled architectures.  Otherwise I think we have a real hazard of
> introducing bugs that will only show up on the stalled architectures.

I really need help from the arch maintainers to finish the set_fs
removal.  There have been very few arch maintainers helping with that
work (arm, arm64, parisc, m68k) in addition to the ones I did because
I have the test setups and knowledge.  I'll send out another ping,
for necrotic architectures like ia64 and sh I have very little hope.
