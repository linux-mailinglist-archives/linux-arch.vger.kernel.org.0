Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC91347232
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 08:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbhCXHPU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 03:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhCXHPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Mar 2021 03:15:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4680AC061763;
        Wed, 24 Mar 2021 00:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WZNXlX3eOEcZWcovU9zwR1I2oqNzGrOjWZWd75LU5ZE=; b=dkGd8++747v3h/hYgkBJiJdwk5
        PWwJAEoFe4SEvtib+PWo8O1uHz83djehIMQSdnlmb1REGO5EV+ai1XfGZioyH8Ql1EhLRkR5p2ZnG
        1pkAuvYWEkKMLqDvjStL4l9A78QhLzRsPKxflpkfjhZ2hPNag18sMT1dpjWG2WWE+Uc0BBQ/s4dBy
        6o1fFxinChsqDoPC9wz4p5NvxQWN+AGPjQkubFEVBSKNdmvEPii7GNy/yM3eT1P9iSLUd2Wy8Rhod
        prA0XCpf7vR/OA/R9UVZ9PZsy/YnOuA17GWykOo2KsrhKISaP/P7KLnX9JfhPBfXzaEy9Ohhktqgn
        wAvphNNA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOxiH-00B54e-77; Wed, 24 Mar 2021 07:14:16 +0000
Date:   Wed, 24 Mar 2021 07:13:57 +0000
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
Subject: Re: [PATCH v3 03/17] mm: add generic __va_function and __pa_function
 macros
Message-ID: <20210324071357.GB2639075@infradead.org>
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323203946.2159693-4-samitolvanen@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 23, 2021 at 01:39:32PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function addresses
> in instrumented C code with jump table addresses. This means that
> __pa_symbol(function) returns the physical address of the jump table
> entry instead of the actual function, which may not work as the jump
> table code will immediately jump to a virtual address that may not be
> mapped.
> 
> To avoid this address space confusion, this change adds generic
> definitions for __va_function and __pa_function, which architectures
> that support CFI can override. The typical implementation of the
> __va_function macro would use inline assembly to take the function
> address, which avoids compiler instrumentation.

I think these helper are sensible, but shouldn't they have somewhat
less arcane names and proper documentation?
