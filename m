Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F02919C7F3
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 19:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388908AbgDBR0m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 13:26:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39072 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbgDBR0l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 13:26:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id g32so2149326pgb.6
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H5lB7pAvXIGYlFSVzFQn+Y4Z8wDMSG1ZSww0VcSBoT8=;
        b=gKNvgOy8hc6wCQvlSge37MBqulJCBRagCkj447Qm1o8xx2FINMhQg5yknXEoUR6m+Z
         ULQfZI01R/Qh6BD8443+HVRJj3c4uKax+LRFJqInEv1IolAfai65y4GBiay60zRG7BpJ
         TCadjYWSD4d+eJ6tLlRgQ4de9aCNzq574JQwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5lB7pAvXIGYlFSVzFQn+Y4Z8wDMSG1ZSww0VcSBoT8=;
        b=Supc1wPuuSQcwZBg50XMMzSxWkTqD8hMsBQ1N9phtg+vzGeVhaoQo6J3SV5tJeAGte
         jhjUMJE5oEQyBPR2eWDxdx+KdE7Ix6slp3W1EPlRME9Gt20YfqzcwSqUQ5/Og0I1EtQD
         zj9rFlfAelSkNVE2OBFBp1aHxel8sM8dNMcqZkqFu/zWDnQ6sN8P51V5DEXyG8zHENBf
         9F2EZD0pIsRlLWsZQy2+F5pOm83P+ZHEFjc5Aaxs7zZzbXS8zAMepSZfY6CpB+5UHtWP
         f4UNUuFWA26EJkUx4Dcy7ZYMovNpeKs+J7iFgBAKPQIqL1rMUk/Xei1SsfwcHXYwVwjU
         tuSw==
X-Gm-Message-State: AGi0PuZMIITpibh9+6wDHgDmVi75GSshGaD0mo1vBUuhlkCdSm+NIerx
        69UOxzZORHwNZhYZJmcavfbRPg==
X-Google-Smtp-Source: APiQypJ2hmcB7ZLOhajLAuwgEV7uDtr5aTLCSP2mbBo/qg5FkMdgwdaJkp+Be18iVsLhUUcAH8dMmA==
X-Received: by 2002:a05:6a00:2cf:: with SMTP id b15mr4105568pft.174.1585848400117;
        Thu, 02 Apr 2020 10:26:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p1sm4171243pjr.40.2020.04.02.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:26:39 -0700 (PDT)
Date:   Thu, 2 Apr 2020 10:26:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Borislav Petkov <bp@suse.de>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Enable orphan section warning
Message-ID: <202004021023.D3D8AA3BE@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <CA+icZUWTnP8DYfbaMwKtJbG30v7bB4w6=ywo8gn8fvwr731mUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWTnP8DYfbaMwKtJbG30v7bB4w6=ywo8gn8fvwr731mUQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 06:20:57PM +0200, Sedat Dilek wrote:
> On Fri, Feb 28, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Hi!
> >
> > A recent bug was solved for builds linked with ld.lld, and tracking
> > it down took way longer than it needed to (a year). Ultimately, it
> > boiled down to differences between ld.bfd and ld.lld's handling of
> > orphan sections. Similarly, the recent FGKASLR series brough up orphan
> > section handling too[2]. In both cases, it would have been nice if the
> > linker was running with --orphan-handling=warn so that surprise sections
> > wouldn't silently get mapped into the kernel image at locations up to
> > the whim of the linker's orphan handling logic. Instead, all desired
> > sections should be explicitly identified in the linker script (to be
> > either kept or discarded) with any orphans throwing a warning. The
> > powerpc architecture actually already does this, so this series seeks
> > to extend this coverage to x86, arm64, and arm.
> >
> > This series depends on tip/x86/boot (where recent .eh_frame fixes[3]
> > landed), and has a minor conflict[4] with the ARM tree (related to
> > the earlier mentioned bug). As it uses refactorings in the asm-generic
> > linker script, and makes changes to kbuild, I think the cleanest place
> > for this series to land would also be through -tip. Once again (like
> > my READ_IMPLIES_EXEC series), I'm looking to get maintainer Acks so
> > this can go all together with the least disruption. Splitting it up by
> > architecture seems needlessly difficult.
> >
> > Thanks!
> >
> 
> Hi Kees,
> 
> what is the status of this patchset?
> Looks like it is not in tip or linux-next Git.

Based on the feedback, I have 3 TODO items:

- track down and eliminate (or explain) the source of the .got.plt on arm64
- enable orphan warnings for _all_ architectures
- refactor final link logic to perform the orphan warning in a clean way

I'm working through these (and other work) still. I'm hoping to have
another version up some time next week.

-- 
Kees Cook
