Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB2207E9B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 23:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404033AbgFXVbt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 17:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404012AbgFXVbs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 17:31:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F7C061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:31:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a45so2683930pje.1
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeZYP2K14l8wy15C+mHJ7IGJGj+bMsdiaVhcvV254wo=;
        b=YLhBzo5tLLnGs0t6TdhnFSz7LC+dIOGSdyR2PzbiJ5sbNeH/OqOlpGPE843RDUqPyB
         xcP72I6Wr3gEeg8vpHpVkU6u63LLrd63P+x1ZZGXfe69+AWJdANZ6EXt2a9Wp3ONoSX+
         IYQFe9nK3k7itVIzd+Ql+LZ3lDH+ctkvhSsUBvpMOUjNf93JbToJ7w7Jl9+ej3WyaGi0
         t64ZoJLPWNph8t4rfm6P3KDNWB+A/4Ny+h52bYBhzjkl8jF/deowywj6kuu84Svv0pXL
         Tt9UDtDNXClNBGQZGornTX62JX0NBkg8bcnSbq3QZ1eCahNDu3bRnftlUijmcZVfck9j
         lPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeZYP2K14l8wy15C+mHJ7IGJGj+bMsdiaVhcvV254wo=;
        b=Q+RghIQnhFHjcBzJWZ8rymOpcurxdAUrIeJfLYoG4zk6QU+FjMqdOJyi8yK9G8Zbv0
         JcoENpNs3RPk5qQakBoRIvYqKQVm7fgfRwgwxP8lHPKHMQmjtuzAq5zPqYWZKftYPdJi
         UM16vCsaJI9UjSS9d6H/5pc4n7wtmPk+mxW7z+QF9jMFc4/x762mPWOZiItDExWfGBF4
         45OsDhCkhMlPqGsinUHcA8oYGDY+qBK6rFMtZkc+2SK6w10HHB4VI7XJkzrQNloEwx4O
         aEeqHKluHDs0qHIGiFWAzROVkOHfflgMhTpwqQ6O+uQTzGfp3+Xmyy7AKEqgf3kvbqmL
         XsNA==
X-Gm-Message-State: AOAM533F3FxClzdwViYdlUGlgxBwtkbVic2NHerbTgjXDvLJHECDwPxh
        DoWggKqzVHtSDQvuxPaNAKsEaSYMVKaBSQtH1moTDA==
X-Google-Smtp-Source: ABdhPJz+HM0notouaxjjmVfRuFFbkI9iWq5lvgoF8vO75RohUtNuXeLwq0dwZGEXHBIiKBXeihMyXNtyRUAlF/ihVkc=
X-Received: by 2002:a17:90a:1e:: with SMTP id 30mr28248270pja.25.1593034308056;
 Wed, 24 Jun 2020 14:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624211540.GS4817@hirez.programming.kicks-ass.net>
In-Reply-To: <20200624211540.GS4817@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 14:31:36 -0700
Message-ID: <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
Subject: Re: [PATCH 00/22] add support for Clang LTO
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 2:15 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 24, 2020 at 01:31:38PM -0700, Sami Tolvanen wrote:
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is to allow
> > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
> > Pixel devices have shipped with LTO+CFI kernels since 2018.
> >
> > Most of the patches are build system changes for handling LLVM bitcode,
> > which Clang produces with LTO instead of ELF object files, postponing
> > ELF processing until a later stage, and ensuring initcall ordering.
> >
> > Note that first objtool patch in the series is already in linux-next,
> > but as it's needed with LTO, I'm including it also here to make testing
> > easier.
>
> I'm very sad that yet again, memory ordering isn't addressed. LTO vastly
> increases the range of the optimizer to wreck things.

Hi Peter, could you expand on the issue for the folks on the thread?
I'm happy to try to hack something up in LLVM if we check that X does
or does not happen; maybe we can even come up with some concrete test
cases that can be added to LLVM's codebase?

-- 
Thanks,
~Nick Desaulniers
