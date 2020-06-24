Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C474D2077D7
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 17:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404413AbgFXPpu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404341AbgFXPpu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 11:45:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23294C061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 08:45:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so1617355pgm.0
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hK2U0EQ30BnaoNQF4dntRJJsTATOCoxIawSQhDYIzmg=;
        b=M4LcVYqRbaeMeIINijtdkTk9Mq9ZlKIrJ+b+Wa23FTDNWKj72NHGbG+3MUPtzF/6HD
         fnXAyak2M9Dn2IqmZW3TBp+BiHYeQLI/IrliERUvgTRtYlT9Vi7yCIjCmWObVj1WZxoy
         OoxYZil7tVXXusQocI3bVFLIuNl0lf9VLeTJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hK2U0EQ30BnaoNQF4dntRJJsTATOCoxIawSQhDYIzmg=;
        b=Z1T2W1Kbdz4YAZEv6KpEk3o6rtMWIGzlT8lTRT5ASqaJ9AC0Kaz15TdnUqSqTiE/Cd
         LwHQZ7PG9tSW4be1PEYMbve3obT0Zx9aY/kq2JdJh6Ec2ukFgqZ/je+eXPaHfyc3ycgR
         Z+KsXBaB0ThF0gFIuOMiKPWUpPlyIufGB0sYQ4W60dwGY8h+IdFPJDBAbiuPcIbvjCHB
         7S86bjijk4lb+CnP83seQNxXTceuY1KdZ+VqqOeHAsVgxQu1qxU0svpM36rOPIk4u3Vu
         DsPI13Y7W90km/32SfuktnzkJp0CT8LgJP55bdB0FhrjVlBiANRc+XZaQACWGYwijWVi
         4UZg==
X-Gm-Message-State: AOAM531IjAI877xW5O0tjZIVQX3YBqLoOKQvKuX50k6qwCoqEQ5q2uBa
        luYDtSJnTJM77g/QmuwrlSTTXA==
X-Google-Smtp-Source: ABdhPJyO4OF6FOKJDg0GWgqo8d8vGoNOrouABB2h+m/a+MKK/rMjyCtOyVbd34SFBAt5h7VZPF0kvw==
X-Received: by 2002:a63:a84d:: with SMTP id i13mr21644988pgp.342.1593013549628;
        Wed, 24 Jun 2020 08:45:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s197sm20482307pfc.188.2020.06.24.08.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:45:48 -0700 (PDT)
Date:   Wed, 24 Jun 2020 08:45:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
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
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <202006240844.7BE48D2B5@keescook>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook>
 <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
 <202006240820.A3468F4@keescook>
 <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 05:31:06PM +0200, Ard Biesheuvel wrote:
> On Wed, 24 Jun 2020 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > > stub, given that it runs under the control of the firmware, with its
> > > memory mappings and PAC configuration etc.
> >
> > Is BTI being ignored when the firmware runs?
> 
> Given that it requires the 'guarded' attribute to be set in the page
> tables, and the fact that the UEFI spec does not require it for
> executables that it invokes, nor describes any means of annotating
> such executables as having been built with BTI annotations, I think we
> can safely assume that the EFI stub will execute with BTI disabled in
> the foreseeable future.

yaaaaaay. *sigh* How long until EFI catches up?

That said, BTI shouldn't _hurt_, right? If EFI ever decides to enable
it, we'll be ready?

-- 
Kees Cook
