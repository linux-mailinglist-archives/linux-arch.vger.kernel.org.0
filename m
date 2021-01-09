Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D972F00F6
	for <lists+linux-arch@lfdr.de>; Sat,  9 Jan 2021 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbhAIPrO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Jan 2021 10:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIPrN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Jan 2021 10:47:13 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0032BC06179F;
        Sat,  9 Jan 2021 07:46:32 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id w18so13041165iot.0;
        Sat, 09 Jan 2021 07:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=p4G4kzlXe85FDh9nr6ety8HEaHTVitPIdX68eNq7YoM=;
        b=b8WREEKJPvYg3zx7oELzMncDnGWo0z/Hn2hvkbAZNWfbrA/5VRXu3tfrMGG3Z5XsiQ
         YYh0wj3MTKkhX3w273hWJu901loGFbN5ZQCL0tIAcRAU2tNE/jvmAOchI3D3cLwdtTqM
         7pqx1PrZ8DeFeEnztgbWjjj8QquQiI4UtPTUvDqBKrWVKCNy2BvtVyfHONUd5OihjUuu
         41duMXwhF3UMnxoKtBPD058ww/Gqw40GO7zD+p/BUHW7HrsGgpYwK/pLPVtpM77KfiDW
         78M6JW7t0vswJY4TuNKPKX5AAtEmkMGAqNwxsb3aOIKYdLdI8Isw2mA3IPNNxBy2cUJo
         139Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=p4G4kzlXe85FDh9nr6ety8HEaHTVitPIdX68eNq7YoM=;
        b=V1oSI//QdHWyhDkd6QSnKeW7QPJlYybjvxdJAwCuzCQ+obkEEftNFr+yQX9X5t2GtI
         IwDzpvQWH70HsCJml5120fjdMDb3uo4sTbF9/DBqxjDPTQM+lfQ2NBxU8+lxwaUiMlTf
         yfgyJD/FNlur4GRIsKOFu1LasOp8Zp9w1QcmMd2gDhsLDLtR+B+bq5HgKyZ+0Z/PizQs
         HcZmgxJei6FP0LSxmMGO6uXGrx7rvw74+/7peAXRXjNH5SteLQNURY+7j6eKWR43Zq7c
         /xVKnHF8s9JK8zd2/g3JTPmdU5PJFuF3r53IXCF0DN99JtCysPWqyUACR86/pWm4eZ4V
         Mf+g==
X-Gm-Message-State: AOAM530VJjKO2FplvUV8+1gBR7sRXy3dzE2RXjnHQvgVpgUx2gpyjDTj
        a+FzrmVghQulMRMbGz+Aq83xP1mwgKu7z8Alvdw=
X-Google-Smtp-Source: ABdhPJzfGJf6btSfZbEMaCeHEpE1yiatLPzmj4sNKHJDVqYiQdPCBe98JajmModQH00NOG/cIKfbOE+Ue3vZADnBYjM=
X-Received: by 2002:a6b:c9cb:: with SMTP id z194mr9324513iof.110.1610207192321;
 Sat, 09 Jan 2021 07:46:32 -0800 (PST)
MIME-Version: 1.0
References: <20201211184633.3213045-1-samitolvanen@google.com>
 <CA+icZUWYxO1hHW-_vrJid7EstqQRYQphjO3Xn6pj6qfEYEONbA@mail.gmail.com> <20210109153646.zrmglpvr27f5zd7m@treble>
In-Reply-To: <20210109153646.zrmglpvr27f5zd7m@treble>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 9 Jan 2021 16:46:21 +0100
Message-ID: <CA+icZUUiucbsQZtJKYdD7Y7Cq8hJZdBwsF0U0BFbaBtnLY3Nsw@mail.gmail.com>
Subject: Re: [PATCH v9 00/16] Add support for Clang LTO
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jan 9, 2021 at 4:36 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Sat, Jan 09, 2021 at 03:54:20PM +0100, Sedat Dilek wrote:
> > I am interested in having Clang LTO (Clang-CFI) for x86-64 working and
> > help with testing.
> >
> > I tried the Git tree mentioned in [3] <jpoimboe.git#objtool-vmlinux>
> > (together with changes from <peterz.git#x86/urgent>).
> >
> > I only see in my build-log...
> >
> > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> > eb_relocate_parse_slow()+0x3d0: stack state mismatch: cfa1=7+120
> > cfa2=-1+0
> > drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool:
> > eb_copy_relocations()+0x229: stack state mismatch: cfa1=7+120
> > cfa2=-1+0
> >
> > ...which was reported and worked on in [1].
> >
> > This is with Clang-IAS version 11.0.1.
> >
> > Unfortunately, the recent changes in <samitolvanen.github#clang-cfi>
> > do not cleanly apply with Josh stuff.
> > My intention/wish was to report this combination of patchsets "heals"
> > a lot of objtool-warnings for vmlinux.o I observed with Clang-CFI.
> >
> > Is it possible to have a Git branch where Josh's objtool-vmlinux is
> > working together with Clang-LTO?
> > For testing purposes.
>
> I updated my branch with my most recent work from before the holidays,
> can you try it now?  It still doesn't fix any of the crypto warnings,
> but I'll do that in a separate set after posting these next week.
>

Thanks, Josh.

Did you push it (oh ah push it push it really really really good...)
to your remote Git please :-).

- Sedat -

[1] https://www.youtube.com/watch?v=vCadcBR95oU
