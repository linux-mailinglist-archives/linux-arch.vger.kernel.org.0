Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9C3872B7
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346889AbhERG6L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 02:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbhERG6J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 02:58:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13056C061573;
        Mon, 17 May 2021 23:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=E0iEnbEcXZYfCTAvDZB9RxI6+B
        2tVe673AOgsLhOujpJY5sX+4TcqmnL84LVm7EECqT4UgeLqfd998Tp2kgXQ6DQGaTyIN6akfGisBs
        DlLNqC0BEPC2jcOEBmVbf76vac/A8YqIwxF18VYvghosegeSdoB7Lp6X4/j/SGh4HskZVrWkbI2vB
        HFT6vJdgrRSiuYydbzMgIQGu+lvJC0dRPdR8fCBDMjj4SHAqKvDRDUCbUlvrh0UbGRdoMC1gf8i6h
        Qd2gfYbeyJdk6QzWgoFJucNOFE6A06UYmNLrn2Id7zCqCTA3oYk0pTrSDgnV4GROZMEvanjbVAF74
        udYXgx9Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1litdH-00Djjj-DI; Tue, 18 May 2021 06:55:21 +0000
Date:   Tue, 18 May 2021 07:55:11 +0100
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
Subject: Re: [PATCH v3 4/4] compat: remove some compat entry points
Message-ID: <YKNkzzgT4mwI9Xjs@infradead.org>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-5-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517203343.3941777-5-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
