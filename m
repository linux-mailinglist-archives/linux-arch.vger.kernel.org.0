Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A282BBEE6
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 13:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbgKUMZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Nov 2020 07:25:20 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96]:37550 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgKUMZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Nov 2020 07:25:20 -0500
X-Greylist: delayed 2676 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Nov 2020 07:25:18 EST
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@misterjones.org>)
        id 1kgRFo-00CVLU-BN; Sat, 21 Nov 2020 11:40:32 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 21 Nov 2020 11:40:32 +0000
From:   Marc Zyngier <maz@misterjones.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alistair Delva <adelva@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
In-Reply-To: <CAKwvOdmk1D0dLDOHEWX=jHpUxUT2JbwgnF62Qv3Rv=coNPadHg@mail.gmail.com>
References: <20201118220731.925424-1-samitolvanen@google.com>
 <CAKwvOd=5PhCTZ-yHr08gPYNEsGEjZa=rDY0-unhkhofjXhqwLQ@mail.gmail.com>
 <CAMj1kXEVzDi5=uteUAzG5E=j+aTCHEbMxwDfor-s=DthpREpyw@mail.gmail.com>
 <CAKwvOdmpBNx9iSguGXivjJ03FaN5rgv2oaXZUQxYPdRccQmdyQ@mail.gmail.com>
 <CAMj1kXEoPEd6GzjL1XuxTPwitbR03BiBEXpAGtUytMj-h=vCkg@mail.gmail.com>
 <CAKwvOdmk1D0dLDOHEWX=jHpUxUT2JbwgnF62Qv3Rv=coNPadHg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a578025ea33108773fe9f3f6e1f180b5@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ndesaulniers@google.com, ardb@kernel.org, linux-arch@vger.kernel.org, adelva@google.com, keescook@chromium.org, paulmck@kernel.org, kernel-hardening@lists.openwall.com, peterz@infradead.org, gregkh@linuxfoundation.org, masahiroy@kernel.org, linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, clang-built-linux@googlegroups.com, samitolvanen@google.com, jpoimboe@redhat.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-11-20 23:53, Nick Desaulniers wrote:
> On Fri, Nov 20, 2020 at 3:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> 
>> On Fri, 20 Nov 2020 at 21:19, Nick Desaulniers 
>> <ndesaulniers@google.com> wrote:
>> >
>> > On Fri, Nov 20, 2020 at 2:30 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>> > >
>> > > On Thu, 19 Nov 2020 at 00:42, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> > > >
>> > > > Thanks for continuing to drive this series Sami.  For the series,
>> > > >
>> > > > Tested-by: Nick Desaulniers <ndesaulniers@google.com>
>> > > >
>> > > > I did virtualized boot tests with the series applied to aarch64
>> > > > defconfig without CONFIG_LTO, with CONFIG_LTO_CLANG, and a third time
>> > > > with CONFIG_THINLTO.  If you make changes to the series in follow ups,
>> > > > please drop my tested by tag from the modified patches and I'll help
>> > > > re-test.  Some minor feedback on the Kconfig change, but I'll post it
>> > > > off of that patch.
>> > > >
>> > >
>> > > When you say 'virtualized" do you mean QEMU on x86? Or actual
>> > > virtualization on an AArch64 KVM host?
>> >
>> > aarch64 guest on x86_64 host.  If you have additional configurations
>> > that are important to you, additional testing help would be
>> > appreciated.
>> >
>> 
>> Could you run this on an actual phone? Or does Android already ship
>> with this stuff?
> 
> By `this`, if you mean "the LTO series", it has been shipping on
> Android phones for years now, I think it's even required in the latest
> release.
> 
> If you mean "the LTO series + mainline" on a phone, well there's the
> android-mainline of https://android.googlesource.com/kernel/common/,
> in which this series was recently removed in order to facilitate
> rebasing Android's patches on ToT-mainline until getting the series
> landed upstream.  Bit of a chicken and the egg problem there.
> 
> If you mean "the LTO series + mainline + KVM" on a phone; I don't know
> the precise state of aarch64 KVM and Android (Will or Marc would
> know).

If you are lucky enough to have an Android system booting at EL2,
KVM should just works [1], though I haven't tried with this series.

> We did experiment recently with RockPI's for aach64 KVM, IIRC;
> I think Android is tricky as it still requires A64+A32/T32 chipsets,

Which is about 100% of the Android systems at the moment (I don't think
any of the asymmetric SoCs are in the wild yet). It doesn't really 
affect
KVM anyway.

          M.

[1] with the broken firmware gotchas that I believed to be erradicated
8 years ago, but are still prevalent in the Android world: laughable
PSCI implementation, invalid CNTFRQ_EL0...
-- 
Who you jivin' with that Cosmik Debris?
