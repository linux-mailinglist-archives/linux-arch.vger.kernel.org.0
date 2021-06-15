Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9413A77DE
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhFOHXn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOHXm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 03:23:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986AC061574;
        Tue, 15 Jun 2021 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K3tN2FjwClDMueW/dRkNP1gpJFA+mQVQcAmzf0tIJNU=; b=M3Ahny1kf0WKwr4OCsfkABA5RB
        BhOOn6WUW0NNSN5nh+IUSvjf85CwKW5zkCadIHC0gIGYsMGgCCnEKgxmVV7/kKmzBHQiel7QXzmgN
        AffxNp3lSLO+M0koptUSEfY8SgmAoiPuRERr/kxz5IMuqh9NgZxatJh7Jv/BideoWbA7SRJkqIivi
        3+Vfdq596W3L7bIT2IITpsePNy45clkFzu/R4orBNgmrtuW5YzMl54fOnk9dMmaXqf+fMb4X0Enb/
        wTC4gW4hHGUXmdPJhKZBdtm3NFXykddIMWWfM7ax3j1St5U689fWd4PMHh+ZRbpVxEp5JQke5CalO
        5U65+/ww==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lt3Nc-006CQF-SX; Tue, 15 Jun 2021 07:21:05 +0000
Date:   Tue, 15 Jun 2021 08:21:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] signal: Add unsafe_copy_siginfo_to_user()
Message-ID: <YMhU3Df7foVo9BaM@infradead.org>
References: <b813c1f4d3dab2f51300eac44d99029aa8e57830.1623739212.git.christophe.leroy@csgroup.eu>
 <684939dcfef612fac573d1b983a977215b71f64d.1623739212.git.christophe.leroy@csgroup.eu>
 <YMhOMoKKvew0YYCt@infradead.org>
 <7061fbee-cc82-2699-cf12-e5a4ae46940f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7061fbee-cc82-2699-cf12-e5a4ae46940f@csgroup.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 09:03:42AM +0200, Christophe Leroy wrote:
> 
> 
> Le 15/06/2021 ?? 08:52, Christoph Hellwig a ??crit??:
> > On Tue, Jun 15, 2021 at 06:41:01AM +0000, Christophe Leroy wrote:
> > > +	unsafe_copy_to_user(__ucs_to, __ucs_from,			\
> > > +			    sizeof(struct kernel_siginfo), label);	\
> > > +	unsafe_clear_user(__ucs_expansion, SI_EXPANSION_SIZE, label);	\
> > > +} while (0)
> > 
> > unsafe_clear_user does not exist at this point, and even your later
> > patch only adds it for powerpc.
> > 
> 
> You missed below chunck I guess:
> 
> > diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> > index c05e903cef02..37073caac474 100644
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -398,6 +398,7 @@ long strnlen_user_nofault(const void __user *unsafe_addr, long count);
> >   #define unsafe_put_user(x,p,e) unsafe_op_wrap(__put_user(x,p),e)
> >   #define unsafe_copy_to_user(d,s,l,e) unsafe_op_wrap(__copy_to_user(d,s,l),e)
> >   #define unsafe_copy_from_user(d,s,l,e) unsafe_op_wrap(__copy_from_user(d,s,l),e)
> > +#define unsafe_clear_user(d, l, e) unsafe_op_wrap(__clear_user(d, l), e)

That doesn't help with architectures that define user_access_begin but
do not define unsafe_clear_user. (i.e. x86).
