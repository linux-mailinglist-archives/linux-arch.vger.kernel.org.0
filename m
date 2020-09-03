Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79E25CE63
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgICXeS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 19:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXeM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 19:34:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EBEC061244
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 16:34:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u13so3367472pgh.1
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 16:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4fH9b479jfHonzzWwhHXw+3tbSLJMOM3KzAo1jerfBs=;
        b=YPszo9KhuFfseZZDaTsKlonChjdXxtUXRJ77uUarXLsjA//VSNUWKlHR5XkQJIWVHO
         xnk2Vsy5goIfOC2m7gmQ9XrZQN7PqsFGCZA8oDkEbzUkaE3/QfY+PiLiJqkH+J0hk3OC
         Toju6SdmLUVUzrlPYiCuOWqN4sYDQ5u5Bc+CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4fH9b479jfHonzzWwhHXw+3tbSLJMOM3KzAo1jerfBs=;
        b=V12rhDZGZBSeA+DzqAhDxNzQUBU/QthxlwkU2oKGDYk9+koeUQaGOZvajuzBqfj5AW
         oLOGJgISsSD8VB2p8wm7Z+JzKKvpNDe/kVcZNW9Yq5ezLsmqqyofV4uZXPt9UmT3rByr
         neo+J5ZRPohk42Lo1tbCR/ggOQ9SD3XONkHM/ZhsTmQQ3BNvTZ+pg/KTW4Hub+O2nwFq
         NIw486W+WnKnusji0h+Pmn+Dl2DpM7MZDfRaITRBv87o2/TCNhWsVqUO0oJLf3p2rZaG
         3Sykc8Ja8xuDNGjFc7EPisgM/mAY1bNsdMWDLzGI+crYq6qfA+FT/TqnTgocwglw29gd
         kvSA==
X-Gm-Message-State: AOAM530pKizqDlLT5OFRzRqL+u/zCQms/FG3W2gcsYtS1kZmsPjnm8Zd
        5cUQb/kRym3Hs5Hr6Mq9gyoWhA==
X-Google-Smtp-Source: ABdhPJxjnSu+yLHWWJfiy7xRvCiUUgHTAGNwM2UhSXChmSRbPFQ4p7gsIG3bTSR63P416rAUVvCDEw==
X-Received: by 2002:aa7:9707:: with SMTP id a7mr6021587pfg.257.1599176051457;
        Thu, 03 Sep 2020 16:34:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id my8sm3390805pjb.11.2020.09.03.16.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:34:10 -0700 (PDT)
Date:   Thu, 3 Sep 2020 16:34:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
Message-ID: <202009031557.4A233A17F1@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:25PM -0700, Sami Tolvanen wrote:
> This patch series adds support for building x86_64 and arm64 kernels
> with Clang's Link Time Optimization (LTO).

Tested-by: Kees Cook <keescook@chromium.org>

FWIW, this gives me a happy booting x86 kernel:

# cat /proc/version 
Linux version 5.9.0-rc3+ (kees@amarok) (clang version 12.0.0 (https://github.com/llvm/llvm-project.git db1ec04963cce70f2593e58cecac55f2e6accf52), LLD 12.0.0 (https://github.com/llvm/llvm-project.git db1ec04963cce70f2593e58cecac55f2e6accf52)) #1 SMP Thu Sep 3 15:54:14 PDT 2020
# zgrep 'LTO[_=]' /proc/config.gz
CONFIG_LTO=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_THINLTO=y
CONFIG_THINLTO=y
# CONFIG_LTO_NONE is not set
CONFIG_LTO_CLANG=y

I'd like to find a way to get this series landing sanely. It has
dependencies on fixes/features in a few trees, and it looks like
it's been difficult to keep forward momentum on LTO while trying to
simultaneously chase changes in those trees, especially since it means
no one care carry LTO in -next without shared branches. To that end,
I'd like to find a way forward where Sami doesn't have to keep carrying
a couple dozen patches. :)

The fixes/features outside of, or partially overlapping, Masahiro's
kbuild tree appear to be:

[PATCH v2 01/28] x86/boot/compressed: Disable relocation relaxation
[PATCH v2 02/28] x86/asm: Replace __force_order with memory clobber
[PATCH v2 03/28] lib/string.c: implement stpcpy
[PATCH v2 04/28] RAS/CEC: Fix cec_init() prototype
[PATCH v2 05/28] objtool: Add a pass for generating __mcount_loc
[PATCH v2 06/28] objtool: Don't autodetect vmlinux.o
[PATCH v2 07/28] kbuild: add support for objtool mcount
[PATCH v2 08/28] x86, build: use objtool mcount
[PATCH v2 17/28] PCI: Fix PREL32 relocations for LTO
[PATCH v2 20/28] efi/libstub: disable LTO
[PATCH v2 21/28] drivers/misc/lkdtm: disable LTO for rodata.o
[PATCH v2 22/28] arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
[PATCH v2 23/28] arm64: vdso: disable LTO 
[PATCH v2 24/28] KVM: arm64: disable LTO for the nVHE directory
[PATCH v2 25/28] arm64: allow LTO_CLANG and THINLTO to be selected
[PATCH v2 26/28] x86, vdso: disable LTO only for vDSO
[PATCH v2 27/28] x86, relocs: Ignore L4_PAGE_OFFSET relocations
[PATCH v2 28/28] x86, build: allow LTO_CLANG and THINLTO to be selected

The distinctly kbuild patches are:

[PATCH v2 09/28] kbuild: add support for Clang LTO
[PATCH v2 10/28] kbuild: lto: fix module versioning
[PATCH v2 11/28] kbuild: lto: postpone objtool
[PATCH v2 12/28] kbuild: lto: limit inlining
[PATCH v2 13/28] kbuild: lto: merge module sections
[PATCH v2 14/28] kbuild: lto: remove duplicate dependencies from .mod files
[PATCH v2 15/28] init: lto: ensure initcall ordering
[PATCH v2 16/28] init: lto: fix PREL32 relocations
[PATCH v2 18/28] modpost: lto: strip .lto from module names
[PATCH v2 19/28] scripts/mod: disable LTO for empty.c

Patch 3 is in -mm and I expect it will land in the next rc (I hope,
since it's needed universally for Clang builds).

Patch 4 is living in -tip, to appear shortly in -next, AFAICT?

I would expect 1 and 2 to appear in -tip soon, but I'm not sure?

For patches 5, 6, 7, and 8 I would expect them to normally go via -tip's
objtool tree, but getting an Ack would let them land elsewhere.

Patch 17 I'd expect to normally go via Bjorn's tree, but he's given an
Ack so it can live elsewhere without surprises. :)

Patches 19, 20, 21, 23, 24, 26 are all simple "just disable LTO"
patches.

This leaves 9-16 and 18. Patches 10, 12, 14, 16, and 18 seem mostly
"mechanical" in nature, leaving the bulk of the review on patches 9,
11, 13, and 15.

Masahiro, given the spread of dependent patches between 2 (or more?) -tip
branches and -mm, how do you want to proceed? I wonder if it might
be possible to create a shared branch to avoid merge headaches, and I
(or -tip folks, or you) could carry patches 1-8 there so patches 9 and
later could have a common base?

Thanks!

-- 
Kees Cook
