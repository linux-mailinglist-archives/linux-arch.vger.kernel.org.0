Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888C42CCAD3
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 01:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgLCACN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 19:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgLCACM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Dec 2020 19:02:12 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E701C061A47
        for <linux-arch@vger.kernel.org>; Wed,  2 Dec 2020 16:01:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c79so94286pfc.2
        for <linux-arch@vger.kernel.org>; Wed, 02 Dec 2020 16:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfjgZXZpIq5fZzABqVm3ochfUst+vG1roSThKbX3esM=;
        b=aKU+Elxn2oMCSfhsrlmIncnG+eVufUmT2zZGZTURg6obiMVmWLv2CQrsZALP8JHr6v
         80wrfU2Kj3rw9JzGE1+ad3sYmQZQVz6coBP/qWBA1CluJ2fZQ9zFZ4l6/vlEm63POXgw
         PoXOTvefcAuxzcoYa6jNF36cSIGxuqPsczhvBBhEyt1it/5x6Z9UoRq1nyzo8Q/oPO6y
         8tFie1CBzkzTNDEZnK/uXLIeFNGsuWQZQvA6FlTiEpIBKkZpLzj9c+okfN8BIcEDQF66
         yCFvYhAsRmLuryGfPwmqK9NiVqvG5a5hjCVx77mxrjmWl+oxa/bmaXsQ2vt2BC7OXv3G
         fQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfjgZXZpIq5fZzABqVm3ochfUst+vG1roSThKbX3esM=;
        b=W+//vAcshq/pKzoAgjyw/QPtlFhhO71v73SKqC3BWAhOkt9GhWqXiXEXr0wS0LaONK
         eXkY08wmhTw3jXm3krhjXuL8XI3Tc+akXrFtUrzcVdO4NnT2yWkxe6I5suR9mB2FZlE7
         X/ZMM5kXyCKKBTYFlLaEYjUUhNINkRVDFs8tb2uYNiGwwzLkQ4FygWtcoRsQ4dxLCiDk
         Vq0ZK1XqXTqwt9Z8lFyRjeP4Q77UdQ5RY1hs9THV9v+Fa4RK5vJsYhHi7l763OtyS57J
         rJfAnkVIgA7jvyLk1puNqGnRf/wof5xGalkTgSgGwxep1yovflmipOBshJSwl6D2xH+A
         ep0Q==
X-Gm-Message-State: AOAM531tOqdT3DEyQijOXv2WsOOn7MqM75JAo6CVrEA/FNKzBV/lYRQn
        npb+FGMS+h2H3dCHbAOOQulM2pKqAjMns6AW8O2jBQ==
X-Google-Smtp-Source: ABdhPJzlujdkqv4BrCfZTRRGmpK19lQ/Z9l2aUuOfXxVaHuxefVyErqf509JoPqL0nZR4gxpFozulWm1c0trs5O9RLg=
X-Received: by 2002:a62:7905:0:b029:197:f300:5a2a with SMTP id
 u5-20020a6279050000b0290197f3005a2amr614586pfc.30.1606953691833; Wed, 02 Dec
 2020 16:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
In-Reply-To: <20201201213707.541432-1-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Dec 2020 16:01:20 -0800
Message-ID: <CAKwvOdnJvGR9L8n+w3E6idCXkGyykkycqbjiPQNNQSoCHrabLg@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 1, 2020 at 1:37 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This patch series adds support for building the kernel with Clang's
> Link Time Optimization (LTO). In addition to performance, the primary
> motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
> to be used in the kernel. Google has shipped millions of Pixel
> devices running three major kernel versions with LTO+CFI since 2018.
>
> Most of the patches are build system changes for handling LLVM
> bitcode, which Clang produces with LTO instead of ELF object files,
> postponing ELF processing until a later stage, and ensuring initcall
> ordering.
>
> Note that arm64 support depends on Will's memory ordering patches
> [1]. I will post x86_64 patches separately after we have fixed the
> remaining objtool warnings [2][3].
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
> [2] https://lore.kernel.org/lkml/20201120040424.a3wctajzft4ufoiw@treble/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-vmlinux
>
> You can also pull this series from
>
>   https://github.com/samitolvanen/linux.git lto-v8
>
> ---
> Changes in v8:
>
>   - Cleaned up the LTO Kconfig options based on suggestions from
>     Nick and Kees.

Thanks Sami, for the series:

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

(build and boot tested under emulation with
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
additionally rebased on top).

As with v7, if the series changes drastically for v9, please consider
dropping my tested by tag for the individual patches that change and I
will help re-test them.
-- 
Thanks,
~Nick Desaulniers
