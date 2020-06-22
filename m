Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C38204428
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 01:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgFVXAT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 19:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731268AbgFVXAQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 19:00:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19285C061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:00:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id q22so6080915pgk.2
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=83TCNCBjNohNVrqhGduE8K74z3IQ6/Lu6H9fSwHcKBI=;
        b=DEgcNUgmnqgavBlvTgADYfLgOafyX/H5FdDRdvi9Bb6S/WBs7kYll9YiPjRSOvgAEG
         v7bulz7OBSDhmA+jwBGRGVdMGRWVjDRy6+FOm9QURTY20m2IeGFzm5+8yMNEN2Dr6Oa1
         ibe8QqZwP9MNkKA71L+uamdauQHqW1Qj57tvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=83TCNCBjNohNVrqhGduE8K74z3IQ6/Lu6H9fSwHcKBI=;
        b=ZcJkgFhP7bkwGPhB7CYcK2z5/FNOUzrUwtDvneDjJ71KCfLrcXkrP8VxjuB8utz2NB
         QFMCP5xiiOj/fv52QUtUerihli7BL5m1jU9KG1+Z1AaXQBd/pG0E9D/FagBat6Qx6eb3
         lP82wEkR0p3ZjKN8ROA77y0ZkJ6bDOPRc1gsuUICGB2ZEe4D3yjXI/ga4WwHTI2L/Jvx
         HWXpdDa7xGiYMS6ZIfzX09Bjm7e7WfDMWawr/2IitCKFns9JyCRSp8MkBb8f2EVeiqmP
         BzKpgDVW/yIIJWWoWCFlLLYWYs6cF77qTOpn/F6U++aVmTQJUdrauPEsJYvoNnDKVmNI
         hKAg==
X-Gm-Message-State: AOAM532xEV+Ah/YCmgEfElvlt/hSmwjWO3RY0O+zM2QR8SsUYToIh9dT
        7ZMg7MIW8R1sjoJ2u4HQ24okEw==
X-Google-Smtp-Source: ABdhPJzDfln86XAWzAEV3/P8Jj4TpYbAS/ch7Sm25KrySby0/SNFjM433WHLKjjRx44/ZmqpW6wv+w==
X-Received: by 2002:a63:df56:: with SMTP id h22mr14511327pgj.140.1592866814612;
        Mon, 22 Jun 2020 16:00:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v7sm14485890pfn.147.2020.06.22.16.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:00:13 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:00:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <202006221600.81F5586@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
 <202006221543.EA2FCFA2FF@keescook>
 <20200622224928.o2a7jkq33guxfci4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622224928.o2a7jkq33guxfci4@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 03:49:28PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
> > > LLD may report warnings for 3 synthetic sections if they are orphans:
> > > 
> > > ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> > > ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
> > > ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> > > 
> > > Are they described?
> > 
> > Perhaps:
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..57e9c142e401 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -792,6 +792,9 @@
> > 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
> > 		.stab.index 0 : { *(.stab.index) }			\
> > 		.stab.indexstr 0 : { *(.stab.indexstr) }		\
> > +		.symtab 0 : { *(.symtab) }				\
> > +		.strtab 0 : { *(.strtab) }				\
> > +		.shstrtab 0 : { *(.shstrtab) }				\
> > 		.comment 0 : { *(.comment) }
> > 
> > #ifdef CONFIG_GENERIC_BUG
> 
> This LGTM. Nit: .comment before .symtab is a more common order.

Adjusted.

> Reviewed-by: Fangrui Song <maskray@google.com>

Thanks!

-- 
Kees Cook
