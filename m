Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF96D34B8
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 01:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJJX5k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 19:57:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40239 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfJJX5k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 19:57:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so4678655pgl.7
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2019 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JDPAnamTFIBp8EbgTewpJ7Tw/YLIi8XdRk99n5ihTZ0=;
        b=Db/oz2S5lstBws+DqElygyxc81UBHBsr+H3aP9d7X1Exv8x5nrqyE8LlbCfAHNDI33
         C0Lez0UyqONC9IaOea8gT8nPL1/x5uCEuR2jRaabo/Im85fb5YQ8dXKHBhHzlSwEU26t
         LMRAjaDuj9AVfrjyE4E00p9tS9qPnDSjC8rv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JDPAnamTFIBp8EbgTewpJ7Tw/YLIi8XdRk99n5ihTZ0=;
        b=fQKe8eubL7Aah4Ru+fXZrLQtCYIq1+5C3ibkSrlDA1mi/lJRrehDtfLlOO0+uZqZVr
         pc6hNO9vOSE3ZEAEHy57XA5dDsgtN4ZK1Z6uHRuya+qZtDJP3sQneEebAfxSl2+x49Oz
         8QsJbd09efsV+uT7CXwaNSHMddUME7Fy7RMluV6TBb2CYpV+00Cf/IEN8spHUxydvWia
         NJsUDYAHfHCu8ZWeQEL0vqIPdtJ8NnYL+8hZB5w4WkF0jVCMK5s8xreCOUqoxwtVOtY+
         VaRFn4r6Wd4Dik6QRC7/daX0Hw3mG39TT//StTVf3M+ZVNOlQI6L6XUJ50TX6wgtrhD6
         FzrA==
X-Gm-Message-State: APjAAAXZJDsESxsB3J+rr2xKrlQpoLFquB5Lz74575Z5lFh1i2eW2AWt
        4JYFjjHVVsD7IfBnPqRFrIWZNw==
X-Google-Smtp-Source: APXvYqxc417dQnyKwr23xDZjX8PoZldCbCNE524Aqa25++NjX1n3K1nM+hIHdvRdzpYCGpdnTHOJmw==
X-Received: by 2002:a17:90a:cc12:: with SMTP id b18mr13644961pju.141.1570751858072;
        Thu, 10 Oct 2019 16:57:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b4sm5035339pju.16.2019.10.10.16.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:57:37 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:57:36 -0700
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
Subject: Re: [PATCH 00/29] vmlinux.lds.h: Refactor EXCEPTION_TABLE and NOTES
Message-ID: <201910101657.234CB71E53@keescook>
References: <20190926175602.33098-1-keescook@chromium.org>
 <20191010180331.GI7658@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010180331.GI7658@zn.tnic>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 08:03:31PM +0200, Borislav Petkov wrote:
> On Thu, Sep 26, 2019 at 10:55:33AM -0700, Kees Cook wrote:
> > This series works to move the linker sections for NOTES and
> > EXCEPTION_TABLE into the RO_DATA area, where they belong on most
> > (all?) architectures. The problem being addressed was the discovery
> > by Rick Edgecombe that the exception table was accidentally marked
> > executable while he was developing his execute-only-memory series. When
> > permissions were flipped from readable-and-executable to only-executable,
> > the exception table became unreadable, causing things to explode rather
> > badly. :)
> > 
> > Roughly speaking, the steps are:
> > 
> > - regularize the linker names for PT_NOTE and PT_LOAD program headers
> >   (to "note" and "text" respectively)
> > - regularize restoration of linker section to program header assignment
> >   (when PT_NOTE exists)
> > - move NOTES into RO_DATA
> > - finish macro naming conversions for RO_DATA and RW_DATA
> > - move EXCEPTION_TABLE into RO_DATA on architectures where this is clear
> > - clean up some x86-specific reporting of kernel memory resources
> > - switch x86 linker fill byte from x90 (NOP) to 0xcc (INT3), just because
> >   I finally realized what that trailing ": 0x9090" meant -- and we should
> >   trap, not slide, if execution lands in section padding
> 
> Yap, nice patchset overall.

Thanks!

> > Since these changes are treewide, I'd love to get architecture-maintainer
> > Acks and either have this live in x86 -tip or in my own tree, however
> > people think it should go.
> 
> Sure, I don't mind taking v2 through tip once I get ACKs from the
> respective arch maintainers.

Okay, excellent. I've only had acks from arm64, but I'll call it out
again in v2. Thanks for the review!

-- 
Kees Cook
