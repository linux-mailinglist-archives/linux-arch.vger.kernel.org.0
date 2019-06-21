Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86AC4E704
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 13:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFULSq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 07:18:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37490 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfFULSq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2019 07:18:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so6195986wme.2
        for <linux-arch@vger.kernel.org>; Fri, 21 Jun 2019 04:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NabQZDyF6ofZk8run8ReROPDDNPPhXEMVOy6Fc5LD2A=;
        b=A0sR4TbA5sn9q6BPXeU1kL9L2rZYmfUq90m2Sf0mR6201SQWimJDCuq975mx4xdPMX
         NIoPXdOUBPw4EZ7mzDrd3p6sFLm6s9pSSW0e9mgtMc6rXQQeYIR2dgyZkoRof3qM35LP
         5eRLvNwhvTbC4pcagAYYGBlOnLcU2RDd7TiNKmhSHyHAkTsmrA1crtabpPFcBBqxhzvV
         X/tnH8Qcgl8EZ6/5uaWL4eJKnqQ5xekFKeIMDSPucn3iqtUXmJC8cwg5FfZultGJuxFJ
         3svqrNjQJA7RZodeSacxMWBKE99m5lY+xX5GPKzuGK4aii45lI+GSO4URvxn0IXqiwZm
         mw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NabQZDyF6ofZk8run8ReROPDDNPPhXEMVOy6Fc5LD2A=;
        b=ugdcXE6FrDdsWvxbKWAbKQZ4EIEdGogs3+f+lD5/BX4uJZT97lLRHUDcl3/uJeIa8c
         ISp9TV76PMWToM0TDdMFSlHFhAMcAsBdE8P1VjtYZ08NFTR+OkLOr6WKfp2j+VBxh6sn
         C5wYT3kPVIqxRhu1V9xeeNQkUiYHpeCEiFASwNA69cYcV8KTiqj3AqS3AAJO7V6pgv3Q
         4r7MSI/hthjJSqKxySeDn1KlmtwXXr/JgJXHw7WzjnD3wLR2wy6UpkWUpdydcGeOAE+Y
         77H7l6LqfNSACQFiiwtTmnDuRqMcsdSfPKlHlaO1jcJzlUTrMic3PECMzv6c+NXk2j8O
         pctg==
X-Gm-Message-State: APjAAAVM/Ll5zOP9+pfgkfykHM0GczY9ksB2J4CxWo0U0pB9MLJwiZpq
        nPisHHXJ1BQ6cm09Z3wTpZI8Dw==
X-Google-Smtp-Source: APXvYqzLoKsLczgYAoe7ayG3xoBLZkEIoT8eLSCvDDxUbIs9XKe0M+GRht7p9R+HZi2Sd7kHDL7H8w==
X-Received: by 2002:a1c:a7ca:: with SMTP id q193mr4122227wme.150.1561115923826;
        Fri, 21 Jun 2019 04:18:43 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id a84sm2327897wmf.29.2019.06.21.04.18.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 04:18:43 -0700 (PDT)
Date:   Fri, 21 Jun 2019 13:18:41 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
Message-ID: <20190621111839.v5yqlws6iw7mx4aa@brauner.io>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
 <20190620184451.GA28543@roeck-us.net>
 <20190620221003.ciuov5fzqxrcaykp@brauner.io>
 <CAK8P3a2iV7=HkHBVL_puvCQN0DmdKEnVs2aG9MQV_8Q58JSfTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2iV7=HkHBVL_puvCQN0DmdKEnVs2aG9MQV_8Q58JSfTA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 21, 2019 at 11:37:50AM +0200, Arnd Bergmann wrote:
> On Fri, Jun 21, 2019 at 12:10 AM Christian Brauner <christian@brauner.io> wrote:
> > On Thu, Jun 20, 2019 at 11:44:51AM -0700, Guenter Roeck wrote:
> > > On Tue, Jun 04, 2019 at 06:09:44PM +0200, Christian Brauner wrote:
> >
> > clone3() was placed under __ARCH_WANT_SYS_CLONE. Most architectures
> > simply define __ARCH_WANT_SYS_CLONE and are done with it.
> > Some however, such as nios2 and h8300 don't define it but instead
> > provide a sys_clone stub of their own because of architectural
> > requirements (or tweaks) and they are mostly written in assembly. (That
> > should be left to arch maintainers for sys_clone3.)
> >
> > The build failures were on my radar already. I hadn't yet replied
> > since I haven't pushed the fixup below.
> > The solution is to define __ARCH_WANT_SYS_CLONE3 and add a
> > cond_syscall(clone3) so we catch all architectures that do not yet
> > provide clone3 with a ENOSYS until maintainers have added it.
> >
> > diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
> > index 7a39e77984ef..aa35aa5d68dc 100644
> > --- a/arch/arm/include/asm/unistd.h
> > +++ b/arch/arm/include/asm/unistd.h
> > @@ -40,6 +40,7 @@
> >  #define __ARCH_WANT_SYS_FORK
> >  #define __ARCH_WANT_SYS_VFORK
> >  #define __ARCH_WANT_SYS_CLONE
> > +#define __ARCH_WANT_SYS_CLONE3
> 
> I never really liked having __ARCH_WANT_SYS_CLONE here
> because it was the only one that a new architecture needed to
> set: all the other __ARCH_WANT_* are for system calls that
> are already superseded by newer ones, so a new architecture
> would start out with an empty list.
> 
> Since __ARCH_WANT_SYS_CLONE3 replaces
> __ARCH_WANT_SYS_CLONE for new architectures, how about
> leaving __ARCH_WANT_SYS_CLONE untouched but instead

__ARCH_WANT_SYS_CLONE is left untouched. :)

> coming up with the reverse for clone3 and mark the architectures
> that specifically don't want it (if any)?

Afaict, your suggestion is more or less the same thing what is done
here. So I'm not sure it buys us anything apart from future
architectures not needing to set __ARCH_WANT_SYS_CLONE3.

I expect the macro above to be only here temporarily until all arches
have caught up and we're sure that they don't require assembly stubs
(cf. [1]). A decision I'd leave to the maintainers (since even for
nios2 we were kind of on the fence what exactly the sys_clone stub was
supposed to do).

But I'm happy to take a patch from you if it's equally or more simple
than this one right here.

In any case, linux-next should be fine on all arches with this fixup
now.

Christian


[1]: Architectures such as nios2 or h8300 simply take the asm-generic
     syscall definitions and generate their syscall table from it. But
     since they don't define __ARCH_WANT_SYS_CLONE the build would fail
     complaining about sys_clone3 missing. The reason this doesn't
     happen for legacy clone is that nios2 and h8300 provide assembly
     stubs for sys_clone but they don't for sys_clone3.

