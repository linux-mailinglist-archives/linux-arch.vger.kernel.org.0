Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAFDD2ED1
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfJJQra (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 12:47:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37710 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJJQra (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 12:47:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id u20so3067787plq.4
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e1YZSnr+tf37urRS0Z3ujXsrRMc5cw+9H7NAi1i2jVA=;
        b=izpAwLJ1ZfINeJ1IGvzXfqW7v0EVcZgsTyN1EOshDrEdBCIUSqkIleCU5BZWm63bPM
         eZKMQCfAts2ypPUa2YAeUCHOY9OigZ+1dV2iaRJWF3dFNdzuaPxx+X7j5M9nVPDl6n5z
         T3tK6luCqjuU0Ibyy5rvMfcc7jZy+Z/gsIufM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e1YZSnr+tf37urRS0Z3ujXsrRMc5cw+9H7NAi1i2jVA=;
        b=JT8Rw3vVxD5g1Omdy4h2deKtR5qDN5Ai5kglJZFRjMyP+ihZhfp6vn+phaakj5/zE/
         CaRy2T6yjVLMwLKFBsr43TvxFsNnL6Hn99NHJbJlnVh8OmX0fqhX7NtjnoJmilihlpNI
         BrsTs42DYxeHY+CSXLqxReB095G1lN4HfaRrcXDSNOiqh37T5vFVL8XBJESMWXOsZilQ
         qXlmInUPdanNRleuuGBrRHDAfBYdBYeklUt5dp1KNHOhGTshkn9i1eLWVUQSYcyLwr8A
         RDtUWD25OZyG60fISDMc+B1teY/lbVr0XlIZdiVGNpewVN6WIoYzyXtj7vFFBietii/Q
         F5Bw==
X-Gm-Message-State: APjAAAVVamYvD+RsEwkDC3/bduf91SLpJ/LWhEyy9baYYIB/l8j8ayF5
        gP51/KqKzec7+pQ17W4DAsrWWw==
X-Google-Smtp-Source: APXvYqzOHOGfFvHHv3LUcDdUgo528S5MG4NnAaB5IQ1fyDZOtJwryOAp83caQNAMb12Fx3S0UUC80Q==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr9844183plo.230.1570726048308;
        Thu, 10 Oct 2019 09:47:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h68sm8085569pfb.149.2019.10.10.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:47:27 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:47:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/29] vmlinux.lds.h: Allow EXCEPTION_TABLE to live in
 RO_DATA
Message-ID: <201910100947.AC066B160@keescook>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-15-keescook@chromium.org>
 <20191010152516.GG7658@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010152516.GG7658@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 05:25:16PM +0200, Borislav Petkov wrote:
> On Thu, Sep 26, 2019 at 10:55:47AM -0700, Kees Cook wrote:
> > Many architectures have an EXCEPTION_TABLE that needs only to be
> > read-only. As such, it should live in RO_DATA. This creates a macro to
> > identify this case for the architectures that can move EXCEPTION_TABLE
> > into RO_DATA.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index d57a28786bb8..35a6cba39d9f 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -69,6 +69,17 @@
> >  #define NOTES_HEADERS_RESTORE
> >  #endif
> >  
> > +/*
> > + * Some architectures have non-executable read-only exception tables.
> > + * They can be added to the RO_DATA segment by specifying their desired
> > + * alignment.
> > + */
> > +#ifdef RO_DATA_EXCEPTION_TABLE_ALIGN
> > +#define RO_DATA_EXCEPTION_TABLE	EXCEPTION_TABLE(RO_DATA_EXCEPTION_TABLE_ALIGN)
> > +#else
> > +#define RO_DATA_EXCEPTION_TABLE
> > +#endif
> > +
> >  /* Align . to a 8 byte boundary equals to maximum function alignment. */
> >  #define ALIGN_FUNCTION()  . = ALIGN(8)
> >  
> > @@ -508,6 +519,7 @@
> >  		__stop___modver = .;					\
> >  	}								\
> >  									\
> > +	RO_DATA_EXCEPTION_TABLE						\
> >  	NOTES								\
> >  									\
> >  	. = ALIGN((align));						\
> > -- 
> 
> I think you can drop the "DATA" from the names as it is kinda clear
> where the exception table lands:
> 
> RO_EXCEPTION_TABLE_ALIGN
> RO_EXCEPTION_TABLE
> 
> The "read-only" part is the important one.

Excellent point; I was not loving the how long the name was either. :)

-- 
Kees Cook
