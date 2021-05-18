Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBA438727D
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbhERGpk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbhERGpi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 May 2021 02:45:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B3C061756;
        Mon, 17 May 2021 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=OGsU7plbD8JAWYLTUch9Rm1H4M
        CGw2jk2RZePo5Yhfp5cmTrFtKhl8m6e9lVs0F0gpU+me7y1HNe8Xx8IqPFKq50Si4gKF+dmRDe9BB
        RuYcyo0x5cOXrwCHwiN01Nx2erBWTda/y+NRiDs1LgV2AYtEwW/gD0v5P4QvyEmJQyCyn27KxWddv
        sW61rGwGeuATqYFWNM4jnGGItEqyfMzTExtv1Py423msL9ckn+63Fo4YzjnMg4PhWsvWBAndOcwl0
        mf/A1pEe5xfjsc9aCIWPUmSUSfMe/XEpUdfF5qut+96GIhaxfEfgqCwpIwglvX1Rsq10PaEnRRFY9
        ah/4uenA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1litQX-00DioB-2l; Tue, 18 May 2021 06:42:12 +0000
Date:   Tue, 18 May 2021 07:42:01 +0100
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
Subject: Re: [PATCH v3 2/4] mm: simplify compat_sys_move_pages
Message-ID: <YKNhuW+Vvi33LKcF@infradead.org>
References: <20210517203343.3941777-1-arnd@kernel.org>
 <20210517203343.3941777-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517203343.3941777-3-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
