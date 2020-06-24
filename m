Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1183207930
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405127AbgFXQaj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 12:30:39 -0400
Received: from foss.arm.com ([217.140.110.172]:40744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404976AbgFXQ30 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5209A1FB;
        Wed, 24 Jun 2020 09:29:24 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FA1B3F73C;
        Wed, 24 Jun 2020 09:29:21 -0700 (PDT)
Date:   Wed, 24 Jun 2020 17:29:19 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Fangrui Song <maskray@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <20200624162919.GH25945@arm.com>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
 <202006232143.66828CD3@keescook>
 <20200624104356.GA6134@willie-the-truck>
 <CAMj1kXHBT4ei0xhyL4jD7=CNRsn1rh7w6jeYDLjVOv4na0Z38Q@mail.gmail.com>
 <202006240820.A3468F4@keescook>
 <CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com>
 <202006240844.7BE48D2B5@keescook>
 <CAMj1kXHqBs44uukRSdFwA_hcmX_yKVfjqdv9RoPbbu-6Wz+RaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHqBs44uukRSdFwA_hcmX_yKVfjqdv9RoPbbu-6Wz+RaA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 05:48:41PM +0200, Ard Biesheuvel wrote:
> On Wed, 24 Jun 2020 at 17:45, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Jun 24, 2020 at 05:31:06PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 24 Jun 2020 at 17:21, Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Wed, Jun 24, 2020 at 12:46:32PM +0200, Ard Biesheuvel wrote:
> > > > > I'm not sure if there is a point to having PAC and/or BTI in the EFI
> > > > > stub, given that it runs under the control of the firmware, with its
> > > > > memory mappings and PAC configuration etc.
> > > >
> > > > Is BTI being ignored when the firmware runs?
> > >
> > > Given that it requires the 'guarded' attribute to be set in the page
> > > tables, and the fact that the UEFI spec does not require it for
> > > executables that it invokes, nor describes any means of annotating
> > > such executables as having been built with BTI annotations, I think we
> > > can safely assume that the EFI stub will execute with BTI disabled in
> > > the foreseeable future.
> >
> > yaaaaaay. *sigh* How long until EFI catches up?
> >
> > That said, BTI shouldn't _hurt_, right? If EFI ever decides to enable
> > it, we'll be ready?
> >
> 
> Sure. Although I anticipate that we'll need to set some flag in the
> PE/COFF header to enable it, and so any BTI opcodes we emit without
> that will never take effect in practice.

In the meantime, it is possible to build all the in-tree parts of EFI
for BTI, and just turn it off for out-of-tree EFI binaries?

If there's no easy way to do this though, I guess we should wait for /
push for a PE/COFF flag to describe this properly.

Cheers
---Dave
