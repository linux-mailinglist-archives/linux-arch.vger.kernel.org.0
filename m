Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B86481AF6
	for <lists+linux-arch@lfdr.de>; Thu, 30 Dec 2021 10:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbhL3JA2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Dec 2021 04:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhL3JA2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Dec 2021 04:00:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BC2C061574;
        Thu, 30 Dec 2021 01:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vFgwQFGnP1+nZeL5xidq9k2TiaD3WdltS2FPFb0c2qA=; b=hSaUvXVYJLH2XhksKFosQF2YHU
        dGP5innnv/tBj7GGtJdnhhYyL6mWSDOrz1NIx6rv4mYjbHi7dEyC4CPSPe4JlCgVOyo9rYxQdsD8q
        EQ8XSLZ5mZRJVuVC5qyz5p9S2SzO0De2a5XnNwxaI0dz1ksfOmZ0YqcwaYGQfKRR1FaxYxnIktniK
        LSsuBJ9c8O5Bw+3/8Fo5/U5wkfG0lR9oDKlVz9GxIjrQhq2DOKWmaIivzRsc+z3/wCSt2kSTNgWaS
        SnJjoKqTvyOarGUHx025oaka8eR1wQ0Cxieh8IWOHBM+LfioMEXHdnMqa3mKdC8jNPLJLi0q63zpo
        LCfE3baA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2rIM-0046EG-3y; Thu, 30 Dec 2021 09:00:22 +0000
Date:   Thu, 30 Dec 2021 01:00:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Bruce Schlobohm <bruce.schlobohm@intel.com>,
        Jessica Yu <jeyu@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marios Pomonis <pomonis@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, live-patching@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v9 00/15] Function Granular KASLR
Message-ID: <Yc11JrelnWJgV7KX@infradead.org>
References: <20211223002209.1092165-1-alexandr.lobakin@intel.com>
 <YcVq1pMHWvPFHH5g@infradead.org>
 <20211227183318.1447690-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227183318.1447690-1-alexandr.lobakin@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 27, 2021 at 07:33:18PM +0100, Alexander Lobakin wrote:
> From: Christoph Hellwig <hch@infradead.org>
> Date: Thu, 23 Dec 2021 22:38:14 -0800
> 
> > On Thu, Dec 23, 2021 at 01:21:54AM +0100, Alexander Lobakin wrote:
> > > This is a massive rework and a respin of Kristen Accardi's marvellous
> > > FG-KASLR series (v5).
> > 
> > Here would be the place to explain what this series actually does and
> > why it is marvellous.
> 
> As I took this project over from another developer/team, I decided
> to preserve the original cover letter and append it to the end of
> mine, as well as to keep most of the original code in the separate
> commits from mine.
> For sure I could redo this if needed, is it really so?

A cover letter needs to explain what you're doing for the reader.
No one is going to page forever to look for that.
