Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB3483D02
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 08:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiADHiG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 02:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiADHiF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 02:38:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD31C061761;
        Mon,  3 Jan 2022 23:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OWaDAnifm56GHcbEAiqmG6sxl7
        1qM9Vn2SItAVQ+af+OQv+Dw7s84FvDyHGpEgN187mrO54bq/na5Tb5uzzH07999yZK/IWNwGg9cU9
        RC682MPKXMooYZaooU1jhkcWA24bGs5t2bI6n4A/r7OY2HQ71hJCOCOl9Q0Z20drZh6BuYLxm5gT5
        Nfdnu0JuXrGheVHlY3kbe0RwgcR1Dp25SFTkywldvU5GKLrWOp9Fa9IXcCcDHqQ5GnUHnTHxv7GdV
        x6NyZj5vhuLiUPRfhYC7hxa02C/U6mTZkb7zfCCD5z51yiIDEfou+kyf8IXiHqcXvco8nEgxPqaNk
        e0iO9D2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4eOS-00AWQE-JV; Tue, 04 Jan 2022 07:38:04 +0000
Date:   Mon, 3 Jan 2022 23:38:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH 01/17] exit: Remove profile_task_exit & profile_munmap
Message-ID: <YdP5XJL1pNRnX5q6@infradead.org>
References: <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <20220103213312.9144-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220103213312.9144-1-ebiederm@xmission.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
