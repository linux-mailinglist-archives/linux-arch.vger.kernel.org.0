Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A820776A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 17:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404108AbgFXPbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 11:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404017AbgFXPbT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 11:31:19 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4421214DB;
        Wed, 24 Jun 2020 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593012678;
        bh=/XOHUfqgbkJQ/VFuvcNxNCzM8LEt5wElAfbZZ/I0QOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1/gbox5RlRrTg4kiGntX+1BFq5EOO4rauIXcE4/g/S2HjduHZ27HO7Fjy+HijbTVB
         sVuOiSgFcgbSQ3pmCbbNxTv8ndSCUbtspQ8cQSVbB0+WOhS45jjaDROjbJheaBvJPx
         Jp7yfm6yZTnYcCEC/Dzy+L1wptwcf9GX1xIrcY+o=
Received: by mail-oi1-f174.google.com with SMTP id p70so2137708oic.12;
        Wed, 24 Jun 2020 08:31:18 -0700 (PDT)
X-Gm-Message-State: AOAM531OUry3LxIaCJNJYm+bjOFgYMaCgh7oWr55Vjbeqqz0xQT2Qrpz
        HHdslCzCbxKXyjDwTD9L/g+JnsF4c0E37Seyz/Q=
X-Google-Smtp-Source: ABdhPJyrGY95Bb0CTBeTb4CjO3FI7dpKNkRH6VdRIt+LCKBsYjwk4gHaFIm8ccr4EwcCcNYIphYlt47P29XWTXpZnCA=
X-Received: by 2002:aca:b241:: with SMTP id b62mr19630758oif.47.1593012677928;
 Wed, 24 Jun 2020 08:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org> <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook> <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com> <202006240820.A3468F4@keescook>
In-Reply-To: <202006240820.A3468F4@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Jun 2020 17:31:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
Message-ID: <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>, Fangrui Song <maskray@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, X86 ML <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 24 Jun 2020 at 17:21, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > stub, given that it runs under the control of the firmware, with its
> > memory mappings and PAC configuration etc.
>
> Is BTI being ignored when the firmware runs?
>

Given that it requires the 'guarded' attribute to be set in the page
tables, and the fact that the UEFI spec does not require it for
executables that it invokes, nor describes any means of annotating
such executables as having been built with BTI annotations, I think we
can safely assume that the EFI stub will execute with BTI disabled in
the foreseeable future.
