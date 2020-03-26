Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA319494D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Mar 2020 21:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgCZUjH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Mar 2020 16:39:07 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50360 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgCZUjH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2020 16:39:07 -0400
Received: by mail-pj1-f68.google.com with SMTP id v13so2971324pjb.0
        for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2020 13:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWuaY2ARDKK5sxiHs7Petg6TnIa//yamB8oiOSrF368=;
        b=Xlm2oIcVis6hLxF4vd9AiZ3rs2dpRkXc995FBVYh+n+fFY+TOqOPDsCVtOjcg3vbpK
         lIOQr4191Crg8k3z+pdHPCf0ftRToF0RvgomhQW56bHm4lOnBI3mTQ72OA6cckQJYBU2
         vc4v9tQvZbvnpNSO0Oem/CK7sG+U25R0xIGgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWuaY2ARDKK5sxiHs7Petg6TnIa//yamB8oiOSrF368=;
        b=Mn+Lr22kEDPMOzDfkhZK10k3+Cy3jBPz5cabuUo9jl2fqFenygh775S+o36qSo/4fM
         +s3MFztyp8oq7qgp+67+qo+mppE+9I3AD4bwB2VrQXuF5SEaoXQS72j2VRE5xmjgwRsR
         3p9uGrpeqemahLYKUzcgrs6WIaztAugD3aOs5AZ2WXfkR+GPE85Mb5pBccqtcrdPWvMe
         RtN/Yi2GxfAEElzHBMBLUtuEgcNBAzJ7trU03rs8qWuZIhQgDJeMcCQ3PEQUPWU4PH2U
         7BZfN8i9VzwRU3Ya5nMGRK8npTp6rYNy7kE+bR/v5TOMHj6Mc8KIOFRqk0pkjENRDchS
         ol0A==
X-Gm-Message-State: ANhLgQ1QwyrF2TPz1XzaDGzrwCRFLJ7JfvfdtkfDkZ2CPjWH7WGqe6pW
        NR4oyp63BuZU6jiuxC0ENnAvmw==
X-Google-Smtp-Source: ADFU+vueHO/L49qQvhf+KwlaSFklRNi77rMfS7AIvkQBC3YLkJ5kQz7y+T9IhR4NxkvHoA/SvIhziA==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr9610430pln.225.1585255145727;
        Thu, 26 Mar 2020 13:39:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s137sm2480478pfs.45.2020.03.26.13.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:39:04 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:39:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 1/2] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Message-ID: <202003261335.CC263EF@keescook>
References: <20200326193021.255002-1-hjl.tools@gmail.com>
 <20200326201142.GJ11398@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326201142.GJ11398@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 26, 2020 at 09:11:42PM +0100, Borislav Petkov wrote:
> On Thu, Mar 26, 2020 at 12:30:20PM -0700, H.J. Lu wrote:
> > In x86 kernel, .exit.text and .exit.data sections are discarded at
> > runtime, not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
> > and define it in x86 kernel linker script to keep them.
> > 
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S     |  1 +
> >  include/asm-generic/vmlinux.lds.h | 10 ++++++++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index e3296aa028fe..7206e1ac23dd 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -21,6 +21,7 @@
> >  #define LOAD_OFFSET __START_KERNEL_map
> >  #endif
> >  
> > +#define RUNTIME_DISCARD_EXIT
> >  #define EMITS_PT_NOTE
> >  #define RO_EXCEPTION_TABLE_ALIGN	16
> >  
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index e00f41aa8ec4..6b943fb8c5fd 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -894,10 +894,16 @@
> >   * section definitions so that such archs put those in earlier section
> >   * definitions.
> >   */
> > +#ifdef RUNTIME_DISCARD_EXIT
> > +#define EXIT_DISCARDS
> > +#else
> > +#define EXIT_DISCARDS							\
> > +	EXIT_TEXT							\
> > +	EXIT_DATA
> > +#endif
> 
> /me goes back and reads the old thread on this...
> 
> Kees, do you expect other arches to actually need this
> RUNTIME_DISCARD_EXIT thing or was that a hypothetical thing?
> 
> /me searches more...
> 
> oh, there's a patchset from you
> 
> https://lkml.kernel.org/r/20200228002244.15240-1-keescook@chromium.org
> 
> which already contains this patch *and* an ARM64 patch which defines
> RUNTIME_DISCARD_EXIT so I'm guessing ARM64 wants to discard at runtime
> too.

Correct.

> Which leaves the question why is H.J. sending that patch separate and
> you carry it in a patchset about orphan section warning? Seems like it
> wants to be in your patchset?

I had needed the same clean up for the orphan section handling, and
since it hadn't been picked up yet, I included it in my series. I'm
still stuck addressing several review comments, so there's no reason to
wait for me: I can easily rebase once these patches land somewhere. I'd
be happy to see them in -tip.

Thanks!

-Kees

-- 
Kees Cook
