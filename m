Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A47031A4B4
	for <lists+linux-arch@lfdr.de>; Fri, 12 Feb 2021 19:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhBLSq7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 Feb 2021 13:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhBLSq6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Feb 2021 13:46:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50D0764E8E;
        Fri, 12 Feb 2021 18:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613155577;
        bh=zP8CXtfdzYg8GZduBGIiauSpipKWLXxVJL/muVPE1oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMPmC+4a31rklT/0aspd1UMMidJsHkzvQWxJOZNO+9VeYpGk6TI0OWBUMlp/cqzo+
         OodtCewrShT6A7CFaatlVG5WujuJ5ZCclK/VwG368gP4NT+njMIR0Xsr3IKShQcFwS
         Ze4kmcW7EN0YxhwFt88Q7a+kMTFn7KaY0sEo92+M+LB2fqwWoqxgZhin+cbZuZl1PG
         D/ZC7QeNtfFm67yE7DoEOEddORTT55YNEtD8XSqkv67RqctccRG6dyIGRxYBAP4f8G
         9Ir/hWqtmbUATnekpsub1HtlM5zKYVrOl7/tguXwpS5oJmlqxX+xkuL2F3hfG9Az09
         lc+MsFIpYEFMw==
Date:   Fri, 12 Feb 2021 18:46:11 +0000
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-arch@vger.kernel.org, len.brown@intel.com,
        tony.luck@intel.com, libc-alpha@sourceware.org, jannh@google.com,
        ravi.v.shankar@intel.com, carlos@redhat.com, mpe@ellerman.id.au,
        hjl.tools@gmail.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, luto@kernel.org, linux-api@vger.kernel.org,
        tglx@linutronix.de, bp@suse.de, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/5] uapi: Move the aux vector AT_MINSIGSTKSZ define
 to uapi
Message-ID: <20210212184610.GA31608@willie-the-truck>
References: <20210203172242.29644-1-chang.seok.bae@intel.com>
 <20210203172242.29644-2-chang.seok.bae@intel.com>
 <20210204155519.GA21837@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204155519.GA21837@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 04, 2021 at 03:55:30PM +0000, Dave Martin wrote:
> On Wed, Feb 03, 2021 at 09:22:38AM -0800, Chang S. Bae wrote:
> > Move the AT_MINSIGSTKSZ definition to generic Linux from arm64. It is
> > already used as generic ABI in glibc's generic elf.h, and this move will
> > prevent future namespace conflicts. In particular, x86 will re-use this
> > generic definition.
> > 
> > Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Cc: Carlos O'Donell <carlos@redhat.com>
> > Cc: Dave Martin <Dave.Martin@arm.com>
> > Cc: libc-alpha@sourceware.org
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-api@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > Change from v4:
> > * Added as a new patch (Carlos O'Donell)
> > ---
> >  arch/arm64/include/uapi/asm/auxvec.h | 1 -
> >  include/uapi/linux/auxvec.h          | 1 +
> >  2 files changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/uapi/asm/auxvec.h b/arch/arm64/include/uapi/asm/auxvec.h
> > index 743c0b84fd30..767d710c92aa 100644
> > --- a/arch/arm64/include/uapi/asm/auxvec.h
> > +++ b/arch/arm64/include/uapi/asm/auxvec.h
> > @@ -19,7 +19,6 @@
> >  
> >  /* vDSO location */
> >  #define AT_SYSINFO_EHDR	33
> > -#define AT_MINSIGSTKSZ	51	/* stack needed for signal delivery */
> 
> Since this is UAPI, I'm wondering whether we should try to preserve this
> definition for users of <asm/auxvec.h>.  (Indeed, it is not uncommon to
> include <asm/> headers in userspace hackery, since the <linux/> headers
> tend to interact badly with the the libc headers.)
> 
> In C11 at least, duplicate #defines are not an error if the definitions
> are the same.  I don't know about the history, but I suspect this was
> true for older standards too.  So maybe we can just keep this definition
> with a duplicate definition in the common header.
> 
> Otherwise, we could have
> 
> #ifndef AT_MINSIGSTKSZ
> #define AT_MINSIGSTKSZ 51
> #endif
> 
> in include/linux/uapi/auxvec.h, and keep the arm64 header unchanged.

I think it just boils down to whether or not anything breaks. If it does,
then we'll have to revert the patch, so anything we can do now to minimise
that possibility would be good.

Will
