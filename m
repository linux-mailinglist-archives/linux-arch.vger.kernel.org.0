Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23442D2EC8
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfJJQqj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 12:46:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34936 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJQqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 12:46:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so4279694pfw.2
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ucc2HcE1KFej2LH6JBkm0K2H0dlib4/rpE4E9DkdWnQ=;
        b=jCH7hVEz9DolIZ1tWTZ2WBzCCWqtC/N1Zw7aqh/YsT1JbgkR+jdLg1c8HFybVnrnDt
         zDT8Pac3++Knf0BDJnT4AHK6EvCPW0ovTGp9VFWoRwYqDitcprYMafhTNkb/D4GuI+mu
         p5DqysPLL8vgpaaxV3VItm4rQa6UKBD0JpAMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucc2HcE1KFej2LH6JBkm0K2H0dlib4/rpE4E9DkdWnQ=;
        b=svWDIhnEOZfdvR6qcAVcXJ9e9PlGlyVS/irfqyKjA749ubEa0u4KQbdeClSYt/IbKZ
         yF1eJP1lOg3BbtQ0vaIDcFkhODKoMElzGKbafbB15d+gOUtGZh87svdOVky04WVxhkyc
         tdAn8aumFoakxzrhpZi9bHyINAFzKt0w2rkBc1JLbnIQgmxUsYPS3e+cMnyANraZzEuv
         x5yIaZFWgE6VZtYMaPGSWyYD9EzDTiUAhIOygKo+yka4UXg4QhxSYbIt90HH4ax0fdpv
         e5AcUwe6szZ+jYr4/piSmOuDAd8aUeaPlDXRJESfGhLpPo3jNvkiMl55EzX8OP+DkgnZ
         VilQ==
X-Gm-Message-State: APjAAAX7klQo6j6NB239Y81JOakVHQYhbIZpfL3O1a6fZkZE/ifJI6CB
        fmqSiU7IviYEJPwfyXd+tPIRiw==
X-Google-Smtp-Source: APXvYqz81XDUB+KawYO30nxn2eoCx5FdYR8TngYKUPz81EWriv3MgYEwn6iW+aXgb9GpyhSssUlr1A==
X-Received: by 2002:a63:e1f:: with SMTP id d31mr11802284pgl.379.1570725998193;
        Thu, 10 Oct 2019 09:46:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm4896915pgo.45.2019.10.10.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 09:46:37 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:46:36 -0700
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
Subject: Re: [PATCH 07/29] x86: Restore "text" Program Header with dummy
 section
Message-ID: <201910100944.92CFB97157@keescook>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20190926175602.33098-8-keescook@chromium.org>
 <20191010103305.GD7658@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010103305.GD7658@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 12:33:05PM +0200, Borislav Petkov wrote:
> On Thu, Sep 26, 2019 at 10:55:40AM -0700, Kees Cook wrote:
> > Instead of depending on markings in the section following NOTES to
> > restore the associated Program Header, use a dummy section, as done
> > in other architectures.
> 
> This is very laconic and after some staring at ld.info, I think you mean
> this:
> 
> "   If you place a section in one or more segments using ':PHDR', then
> the linker will place all subsequent allocatable sections which do not
> specify ':PHDR' in the same segments."
> 
> but I could be way off. Yes, no?
> 
> IOW, please write in the commit messages first what the problem is
> you're addressing.

Yeah, that's much improved. I really struggled to describe this, given
how weird the linker script logic is here.

> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -147,8 +147,9 @@ SECTIONS
> >  	} :text = 0x9090
> >  
> >  	NOTES :text :note
> > +	.dummy : { *(.dummy) } :text
> >  
> > -	EXCEPTION_TABLE(16) :text = 0x9090
> > +	EXCEPTION_TABLE(16)
> 
> This is killing the filler byte but I have a suspicion that'll change
> eventually to INT3... :)

Yes, though since the exception table isn't executable, filling with
0x90 has no meaning, and I think when I looked at the alignment there
were actually no fill bytes from here on. But it doesn't matter; it all
goes away in the end.

-- 
Kees Cook
