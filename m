Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8F024E2B0
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 23:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHUV2d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 17:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHUV2c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 17:28:32 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8C1C061573;
        Fri, 21 Aug 2020 14:28:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so2250837qtm.10;
        Fri, 21 Aug 2020 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u1w1dHewQ24Wh+EinJOH0pHgm/+gMZl7ydhUDFjuxnU=;
        b=OoMfAjUZNkobdLMpwQ9UFNRLMGg4krPXHtBq3Ds15ChRcLsqX5B44nEIZJ7s3FioZb
         6oYiG18I/qsd0529aq3ua3uxtI9gSYEoW1ALH3ba3XWAGTaZyUYdsQjnyKpSlukJxuDK
         blqEdLgUgL92jae/PdnFYiYeQApnlj3mz4LbeuOo0gZeJGEl1IO3i09PIX52HxaxPzuw
         RFp86XFjqI3KHojp/MGn7uEZDzu48zBiI1YdZs1C9zvnjpGOTRvfXPiIBijrgP0nQZ/8
         r1qooc2oOrlTJHcXqo4mDtmOntpRN/IkGUKtZOIH8/BEzBMvlyrn5M0AFD1NgtMnpmVn
         cKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=u1w1dHewQ24Wh+EinJOH0pHgm/+gMZl7ydhUDFjuxnU=;
        b=BX2MLtIcDcf8Ced0SLuiHabf4WDIiqrULdH+/X8rQDjutqeQKi056Jza3vWjKYq6re
         TBXzkWVPbTh6BSmfeeauMCi9DhnNlx8mcoNXVegZbxvkrngyu0pGu82plVsAYw5q5yLC
         jlf/qdcfmgx95r7/TekMrrXXCG/M05S/U34Joag7srIKmlH7qixrTDE+OX4PfL1FDDFy
         OfSRhAIzBbbxdZUB5UhsdSeN36m2+KQRY9K+lyoD9KW0Naz+wsj0ST+urbqHBQ8zG91E
         rwZsTg4XVFuILgpAUVBR4TUQR2t+PZ2bp9SwJPP/iSV61+BKk8b7/M3XlAYjbjkNrNnG
         vzrw==
X-Gm-Message-State: AOAM531cHi1mcfApn5zQ4ImWX0f+vNV00Dg6Wo54lPjkrcsv6mZREVSf
        CzNHN1JCa74rnilLYH+9fRc=
X-Google-Smtp-Source: ABdhPJxtZVULVA3N4dt/bqKeQXc8/i3GQ6y0v/dOVtDkDPQdS8K00WAzx4b4ykHLL9yquf0LN759jg==
X-Received: by 2002:aed:27c8:: with SMTP id m8mr4565676qtg.302.1598045310404;
        Fri, 21 Aug 2020 14:28:30 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p189sm2823699qkb.61.2020.08.21.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:28:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Aug 2020 17:28:28 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 27/29] x86/boot/compressed: Remove, discard, or assert
 for unwanted sections
Message-ID: <20200821212828.GA1741495@rani.riverdale.lan>
References: <20200821194310.3089815-1-keescook@chromium.org>
 <20200821194310.3089815-28-keescook@chromium.org>
 <20200821200159.GC1475504@rani.riverdale.lan>
 <202008211421.47347CA42@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202008211421.47347CA42@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 21, 2020 at 02:21:34PM -0700, Kees Cook wrote:
> On Fri, Aug 21, 2020 at 04:01:59PM -0400, Arvind Sankar wrote:
> > On Fri, Aug 21, 2020 at 12:43:08PM -0700, Kees Cook wrote:
> > > In preparation for warning on orphan sections, stop the linker from
> > > generating the .eh_frame* sections, discard unwanted non-zero-sized
> > > generated sections, and enforce other expected-to-be-zero-sized sections
> > > (since discarding them might hide problems with them suddenly gaining
> > > unexpected entries).
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > >  	.rel.dyn : {
> > > -		*(.rel.*)
> > > +		*(.rel.*) *(.rel_*)
> > >  	}
> > >  	ASSERT(SIZEOF(.rel.dyn) == 0, "Unexpected run-time relocations (.rel) detected!")
> > >  
> > >  	.rela.dyn : {
> > > -		*(.rela.*)
> > > +		*(.rela.*) *(.rela_*)
> > >  	}
> > >  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
> > >  }
> > > -- 
> > > 2.25.1
> > > 
> > 
> > When do you get .rela_?
> 
> i386 builds, IIRC. I can try to hunt that down if you want?
> 
> -- 
> Kees Cook

Nah, just curious.

Thanks.
