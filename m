Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D7F11E589
	for <lists+linux-arch@lfdr.de>; Fri, 13 Dec 2019 15:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLMO2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Dec 2019 09:28:53 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36828 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMO2w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 09:28:52 -0500
Received: by mail-wm1-f42.google.com with SMTP id p17so6778474wma.1;
        Fri, 13 Dec 2019 06:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6QLZHSUqVyecs2iharIBnV+waYycsRrF0PppbO8VMdc=;
        b=X4Em0CQg7XPS3z8XGXcRnzQcQadSqmHsHNxwILAXvTkGF1A0285lgDVyCcfmeLJMPj
         +Tk9WJ2x/6XiFUCTHg0b8xn10ROMgVaTjQnbg+3qy3Gv3aep3BkV8hyVg4Rj0h75Z/oD
         35XebvEWDrOknx7OGqgYUi4qMIv+qa9zC1voRXNBH6drGXWrKcVy9HlcS2r/HuYmNAI9
         OLcCG+k1GSnn6YvMkJcBCrtfY6FidTIooBhHPKYhYtE5D3BJoBZLsrfJHapK+8InoSks
         f0UPKA4o/9sHfTcTLWVTfcOsu/7MQOC8y9flklApuHnQ61tarND+8sgZ2yf0UyGiQP7W
         Yp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6QLZHSUqVyecs2iharIBnV+waYycsRrF0PppbO8VMdc=;
        b=e1PsduVgWWPPq+XS6OML6AgiNG0pHqizZ+fMSp4k4x5E0WYtf7Q4+spsaIyGb1itu9
         BCDr4EpFN+e9OhOIP7KcYBDMP125frdK+ZBn1ozDVFWXnjhltDagnwJj00kQoJImNiON
         sOnhBEJwbaDR5neVPbqOI+010URVGFCCCJv6x+zo6/We+W3GKpWNU+wQ5oRZwOpzsUzv
         dJ0Q1gruUC+Rf64ORXL0FM9uuIoddNFZT+gi+2ociGtaU4dcnrUindfy5i8X7xSCGgX9
         E8oXwvhnsnxFedLtInHdCoQf36oIsfnUBHH0uZ5l//sCM6grbvMf989H2eg0O1ViAUa/
         /SxA==
X-Gm-Message-State: APjAAAWSCpmOfllyRJxWc+a3ghTwJo5zJ8B5ATF/LQFep4/rQic+dylm
        7bDnAG8hK+EA58J+rPKBXb8=
X-Google-Smtp-Source: APXvYqwcogMDfRsO+0kr7L/xFj6Up/8vQMcepDErEiyPT73ffpPLdwealTjrhoiMySzSoGv/hvLbhQ==
X-Received: by 2002:a1c:980e:: with SMTP id a14mr9520966wme.76.1576247330116;
        Fri, 13 Dec 2019 06:28:50 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40f6:4600:60b0:6ca6:1eae:3b06])
        by smtp.gmail.com with ESMTPSA id h127sm11148048wme.31.2019.12.13.06.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 06:28:49 -0800 (PST)
Date:   Fri, 13 Dec 2019 15:28:46 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191213142846.ki2t2fwljnql66lt@ltop.local>
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <20191212202157.GD11457@worktop.programming.kicks-ass.net>
 <20191212205338.GB11802@worktop.programming.kicks-ass.net>
 <20191213104706.xnpqaehmtean3mkd@ltop.local>
 <20191213125618.GD2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213125618.GD2844@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 13, 2019 at 01:56:18PM +0100, Peter Zijlstra wrote:
> 
> Excellent! I had to change it to something like:
> 
> #define unqual_typeof(x)    typeof(({_Atomic typeof(x) ___x __maybe_unused; ___x; }))
> 
> but that does indeed work!
> 
> Now I suppose we should wrap that in a symbol that indicates our
> compiler does indeed support _Atomic, otherwise things will come apart.
> 
> That is, my gcc-4.6 doesn't seem to have it, while gcc-4.8 does, which
> is exactly the range that needs the daft READ_ONCE() construct, how
> convenient :/
> 
> Something a little like this perhaps?

Yes, this looks good to me.
Just a small nit here below.

> ---
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 7d9cc5ec4971..c389af602da8 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -75,9 +75,9 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
>  
>  #define __smp_store_release(p, v)					\
>  do {									\
> -	typeof(p) __p = (p);						\
> -	union { typeof(*p) __val; char __c[1]; } __u =			\
> -		{ .__val = (__force typeof(*p)) (v) };			\
> +	unqual_typeof(p) __p = (p);					\
> +	union { unqual_typeof(*p) __val; char __c[1]; } __u =	\
> +		{ .__val = (__force unqual_typeof(*p)) (v) };	\

The 2 two trailing backslashes are now off by one tab.

-- Luc 
