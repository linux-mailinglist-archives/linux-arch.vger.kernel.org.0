Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF8352696
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 08:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhDBGh6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Apr 2021 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBGh5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Apr 2021 02:37:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF20C0613E6;
        Thu,  1 Apr 2021 23:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=23JVev1P6hfZn75YYKAeRgCkKkBm6a8rfr6nXZM/23Y=; b=DidHl2sJes5CZndoc3Jq3dcebg
        mHIG2+4LZPraKak5HEMoK0y5J2IN+LGspSYgcrDWzNKlc2hELMTpEx/cRtXNSteFzQC58hDAl/Zf7
        FnMIDAJJhvKvxesv3o0OwP/BzOHYMsJyft0tWmRNf3lx4Lnyk1AquB6H2AutP63hjsWxrxBEumlcb
        2rC3O68k8xLzsESDaHWYMzu3vLCyoQAMZNMXEUIEeRl6vkT8pgZBNaHnhTsDAG4+NgJGZOIlFY9Ky
        bnP3x4iu02ItVcHPk1+J4B68TLe+1IqUgzG8yVAGE2P8dQQe9sbqQQ6wDpJxGuR2URuUn8LGWri3a
        KUpOgXeA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lSDR6-007IGD-Qr; Fri, 02 Apr 2021 06:37:42 +0000
Date:   Fri, 2 Apr 2021 07:37:40 +0100
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
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 03/18] mm: add generic function_nocfi macro
Message-ID: <20210402063740.GA1738362@infradead.org>
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401233216.2540591-4-samitolvanen@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks, this looks much better than the earlier naming:

Acked-by: Christoph Hellwig <hch@lst.de>
