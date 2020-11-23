Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42C2C136C
	for <lists+linux-arch@lfdr.de>; Mon, 23 Nov 2020 20:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgKWSe2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Nov 2020 13:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbgKWSe2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Nov 2020 13:34:28 -0500
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E35BC0613CF
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2020 10:34:28 -0800 (PST)
Received: by mail-vk1-xa43.google.com with SMTP id v185so973456vkf.8
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2020 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ducm/uE+sMkPK2UOgkqYMUQ4ilvqi+LJ419ruam/qFs=;
        b=a28npanXu2b+2Zm6spF8Xxq67i0FF1mofgAXLZrp9sWLlq5VqELCHg7nNtL/fggxfy
         4CvQOkS95wisZC5OOhHXgHc7fhFAJxswBiURdiMJ9pvomlaHamPT+ykt9lAJiikZ+dLt
         osQObvLhHeCEfH726pPrnktuPN+mM05X3eQTo9OM7P951PbVbYXAJtMdKWsW3ZpOJycz
         Fo60Q7UeI0dsFGaQdho0oc4TBDEtFVDe4gG5sgoLUuJHQYabpl1Mv31/0zpxLkiYJIlP
         yNiDIkVOpAML5h30am2pinK5OAxNIvR/ui0KubaSslDdw6PBBAOOjQrByts6Koo1ViWx
         IqJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ducm/uE+sMkPK2UOgkqYMUQ4ilvqi+LJ419ruam/qFs=;
        b=XyH0saRrYdRWAdC+CkXNsa72c6Ls4hLmotu3OaaEp8ckBREpOEXqPnpOkgATqfZ/my
         CxQZZbFUNXQ7bEpd3tjtqZ13wvTaUYNbHXasb83lcSEc3SbW6PntEt/KYXaeU9h773zL
         QPkGTK9UvZowNe+RiSCfOOAbtGa0Mrs/EP78kr1wxTRAmW8kfaW5gfg1yHgtlwO8XyE5
         MZxGEfrpDM3H0zPfzDvbh17r1GDYPzth53FthiVjCVEO8Z8SY5Qb0IqjmhH0NkFU0r+u
         DuMOR/Qibn3S1NW8L7OQ02L37oLkO36LnFlTfg94VEhEnQSebevaJ1lG/fQj2SyeI/qd
         lAOQ==
X-Gm-Message-State: AOAM530+XMHmVLEmyWVBxT/tje8j2bJRtVrOtMYx+vaQSHIJKum9bpPY
        YmUadpd+tcuKSJYkGaQ+vroySgXW6MrDm/uRkIJd2w==
X-Google-Smtp-Source: ABdhPJzC0vN0JaDRTG9c5TGsH9fkbupHyjbfe084sm69JglMhlEIa99nGJXCtSMl92Ch4dEphBLEyKdnjfaSUw9p8Ug=
X-Received: by 2002:a1f:b245:: with SMTP id b66mr1161485vkf.3.1606156467081;
 Mon, 23 Nov 2020 10:34:27 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-16-samitolvanen@google.com> <20201123102149.ogl642tw234qod62@google.com>
In-Reply-To: <20201123102149.ogl642tw234qod62@google.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 23 Nov 2020 10:34:16 -0800
Message-ID: <CABCJKudwt6xDUMADRjXU04bxZFFWOFOs_26TJGHV_vnP8Qs5Jw@mail.gmail.com>
Subject: Re: [PATCH v7 15/17] KVM: arm64: disable LTO for the nVHE directory
To:     David Brazdil <dbrazdil@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 23, 2020 at 2:21 AM David Brazdil <dbrazdil@google.com> wrote:
>
> Hey Sami,
>
> On Wed, Nov 18, 2020 at 02:07:29PM -0800, Sami Tolvanen wrote:
> > We use objcopy to manipulate ELF binaries for the nVHE code,
> > which fails with LTO as the compiler produces LLVM bitcode
> > instead. Disable LTO for this code to allow objcopy to be used.
>
> We now partially link the nVHE code (generating machine code) before objcopy,
> so I think you should be able to drop this patch now. Tried building your
> branch without it, ran a couple of unit tests and all seems fine.

Great, thanks for testing this, David! I'll drop this patch from v8.

Sami
