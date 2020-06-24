Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BBB2077DF
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 17:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404287AbgFXPsy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 11:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404137AbgFXPsy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 11:48:54 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB7C20A8B;
        Wed, 24 Jun 2020 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593013733;
        bh=SiOccSYDq3Ujl7Qm6Nh9lr81LZ11ZdVVR+s/kwlHeOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nmm+51b9WSfuZVeBEdjeJFGECh07l9JW/yiiBpt1qkXd8cZx7k0aHGwmZnPz6pZG8
         g8/1xJgtXyTnlK37REkGB5d+Ukr9b6G2pTfuGkkt3Kf46J6KyT/tw5sd0IjX4FSrDT
         6g9b7KPsamhuad8caHmHZPS6HfQh/caZs2MDUlZU=
Received: by mail-ot1-f50.google.com with SMTP id n5so2373531otj.1;
        Wed, 24 Jun 2020 08:48:53 -0700 (PDT)
X-Gm-Message-State: AOAM531py8qiC6uBuO651wgI2n9EvG8A6aerPh55tTLNikdij6ZlElkR
        pI0VImorSsqheznzE+3v/tX5gkvgtxKLy12yWP8=
X-Google-Smtp-Source: ABdhPJy7f5kUbglm41IsevGTp/GRt9FgnT8Y+c1SPNB4P7tPiV04yjmDIrwCKi5qqnP9kihr/urjcaBCWYo7IocupoA=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15mr393127otf.77.1593013732575;
 Wed, 24 Jun 2020 08:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org> <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook> <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
 <202006240820.A3468F4@keescook> <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
 <202006240844.7BE48D2B5@keescook>
In-Reply-To: <202006240844.7BE48D2B5@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 24 Jun 2020 17:48:41 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHqBs44uukRSdFwA_hcmX_yKVfjqdv9RoPbbu-6Wz+RaA@mail.gmail.com>
Message-ID: <CAMj1kXHqBs44uukRSdFwA_hcmX_yKVfjqdv9RoPbbu-6Wz+RaA@mail.gmail.com>
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

On Wed, 24 Jun 2020 at 17:45, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jun 24, 2020 at 05:31:06PM +0200, Ard Biesheuvel wrote:
> > On Wed, 24 Jun 2020 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > > > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > > > stub, given that it runs under the control of the firmware, with its
> > > > memory mappings and PAC configuration etc.
> > >
> > > Is BTI being ignored when the firmware runs?
> >
> > Given that it requires the 'guarded' attribute to be set in the page
> > tables, and the fact that the UEFI spec does not require it for
> > executables that it invokes, nor describes any means of annotating
> > such executables as having been built with BTI annotations, I think we
> > can safely assume that the EFI stub will execute with BTI disabled in
> > the foreseeable future.
>
> yaaaaaay. *sigh* How long until EFI catches up?
>
> That said, BTI shouldn't _hurt_, right? If EFI ever decides to enable
> it, we'll be ready?
>

Sure. Although I anticipate that we'll need to set some flag in the
PE/COFF header to enable it, and so any BTI opcodes we emit without
that will never take effect in practice.
