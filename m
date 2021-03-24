Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA00347222
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 08:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhCXHMj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 03:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbhCXHML (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 03:12:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0DC061763;
        Wed, 24 Mar 2021 00:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=54Qbh71jGibI/QTbfGG9/h5IL8C6wSLI2XHKlvis0eI=; b=gFRvzRpNXls/yy7upHczWVYAMN
        tOtlIgTyynn1qKZJTjKZf7gLY/ai8EAbFpatb1GSNXmIX9TGJBw0FFq8ULfEhfTXJRshV44Ji6SDD
        xmEdnsDTyOuEmKufKDbbEo/NztEPcL4cE4o1F3drnw0lpu9lIn4F1Fo2lheZpicyMkZRpCdezVpc7
        R8ofDGz02Gbr6vVvgyHnT+/ODApGr/cWel/pFRc8o2BxNO3lvyfpHg9f8M2vmfdne64d5LRlHpquw
        nv3mMqN6vB2BSdEdR3oRlhsY771qgeKMtDHEqjKzzRzLpTtnwEo4HhZ0dBbzAidV8ejNIq/gjWEXx
        beublnGw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOxea-00B4xp-Ks; Wed, 24 Mar 2021 07:10:18 +0000
Date:   Wed, 24 Mar 2021 07:10:08 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/17] treewide: Change list_sort to use const pointers
Message-ID: <20210324071008.GA2639075@infradead.org>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-10-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-10-samitolvanen@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 23, 2021 at 01:39:38PM -0700, Sami Tolvanen wrote:
> list_sort() internally casts the comparison function passed to it
> to a different type with constant struct list_head pointers, and
> uses this pointer to call the functions, which trips indirect call
> Control-Flow Integrity (CFI) checking.
> 
> Instead of removing the consts, this change defines the
> list_cmp_func_t type and changes the comparison function types of
> all list_sort() callers to use const pointers, thus avoiding type
> mismatches.
> 
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Looks good:
Reviewed-by: Christoph Hellwig <hch@lst.de>
