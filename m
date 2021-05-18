Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F256E3872B0
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 08:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346854AbhERGzU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 02:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbhERGzT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 02:55:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C155C061573;
        Mon, 17 May 2021 23:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FPflQsvnmxGeUn8tLpNCQuGDZB45mYWLMbn7rLriiVA=; b=FkqYz0ndUCbgFoDLfRi3txqNNi
        DthCs1cKGgjjd6vdSD7x2NwQEtV567loUkw+pEK6CxVb1TJhZ0m1ZnqfB1fRL976w3WnpNNW1Hbtc
        jAxp2N71cYQUX2fZEh3HNplXVOoyj/Z6FlIGFlT7Roxe5ESUJX+fTYyGiBHlXaWq//M0+kU+n4csW
        yyOU7GruzN57trnNhYunG8x4uV+6sKL7Q+5TE0ur7s2rrHlRtBaU3Y1shoqZenZJQg3v9VBOeBrcg
        nY8/aqLRtA475RfGm3pC+IqMLMFpCy7dHTTsSVUzr75NTqzXiGI18Z/UVTiu7kHSd6V2f+bxy7Sdr
        fBSptcEQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1litaN-00DjX0-Mw; Tue, 18 May 2021 06:52:17 +0000
Date:   Tue, 18 May 2021 07:52:11 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org
Subject: Re: [PATCH v3 3/4] mm: simplify compat numa syscalls
Message-ID: <YKNkG3IzK4nl2VSX@infradead.org>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517203343.3941777-4-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Except for the various annoying overly long lines this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
