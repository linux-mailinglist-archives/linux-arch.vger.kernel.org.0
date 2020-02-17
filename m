Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A16C1161D75
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 23:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgBQWkI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 17:40:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35387 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgBQWkF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Feb 2020 17:40:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id w12so21630049wrt.2
        for <linux-arch@vger.kernel.org>; Mon, 17 Feb 2020 14:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76Z6CK20GgcJDSbhtaVsIFc+JofKd4d7bU36INZrWq8=;
        b=kxzPl+66GzU0tsmDlLsFrMwRER4GjmMjrCsQ8WBsJpK7WvBK66WgF+Za2d5YquYg0F
         56RJP+B7UnTuynnPArjOIS1mmcoVxNYTlc14JckbL5FQk3LgaTbIghYssIHIN6EAxt+U
         t8iJ5dQuIFhTYJQhYFKFKc0tUg1isJ4xiyna6ZbcvPum0pst/kjre1zEdMQWE4DGB6Qx
         ywSlGjIKeXfeyfQuvaTNBYECdGcYQGdrc6GKo7gxv7XmTTW/Vv6OhAGMH8kp9Z+ytHGc
         86TWTERacFcFKshU+EVa4AX9mCL/p8VC4HwrbpCPGflRZljZRLqzoRQLprmBJyPhQaMl
         9QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76Z6CK20GgcJDSbhtaVsIFc+JofKd4d7bU36INZrWq8=;
        b=K4BCci969mwu70N9l9lM5YRFEfXHEznO9NzHBl8s2S3+XUwiUc7N3znkA4mNEegDdj
         /6ViH54DthZrHy0DaoxA1hC3sC1ZmjsVpdVuBZ2rHWVXwqSTckjfGTa964WC4pi2TDDn
         JNMu+XZVPAJfRiIU5UraFHJmlzdxG/SSqa/KJ9A4QJYHSoTiK+6UXWDej6aSRhvsEb25
         IYON03GSXWaJTYwyU/rDdrL5rSCWtZV5HXEnkeINaVHFbcgIG/4/akdWJ/RpDmDoHdLu
         h6xCxWPKgKAG49izRpUSThmXNOQpv1PBR8H1gybq+QpHa0Pfn+Hh+YyZYDNNyB7YSUUU
         7OEw==
X-Gm-Message-State: APjAAAWe/bJCZs2oIfxVmhOuFCKli50KVfpG7xoOEdbS/e5jh6M8sAsj
        HVMi1yUE8eRfDxyJXdwPWLZk69aQvmwzCRy5kHEAUw==
X-Google-Smtp-Source: APXvYqwNZrDDXyuSSAFRXCKsy/wiMe0qfoB8DAfRSRnoO8OLRY0g8yoVJOVwgE7xeIdVzjRpZGxBZ5gLv8/0K5cJ2j4=
X-Received: by 2002:a5d:6a4b:: with SMTP id t11mr24090235wrw.262.1581979204034;
 Mon, 17 Feb 2020 14:40:04 -0800 (PST)
MIME-Version: 1.0
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
 <20200213161614.23246-20-vincenzo.frascino@arm.com> <20200213184454.GA4663@ubuntu-m2-xlarge-x86>
 <0cee3707-d526-3766-3dde-543c8dbd8e68@arm.com> <20200217164608.GA2708@willie-the-truck>
In-Reply-To: <20200217164608.GA2708@willie-the-truck>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Feb 2020 23:39:53 +0100
Message-ID: <CAKv+Gu8Qh495twz-3UQrFiKfPq-Kt_o+JrCNwEcdMedV2DqPEA@mail.gmail.com>
Subject: Re: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
To:     Will Deacon <will@kernel.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        0x7f454c46@gmail.com, linux-mips@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>, pcc@google.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        avagin@openvz.org, Stephen Boyd <sboyd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        salyzyn@android.com, Paul Burton <paul.burton@mips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 17 Feb 2020 at 17:46, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Feb 17, 2020 at 12:26:16PM +0000, Vincenzo Frascino wrote:
> > On 13/02/2020 18:44, Nathan Chancellor wrote:
> > > On Thu, Feb 13, 2020 at 04:16:14PM +0000, Vincenzo Frascino wrote:
> > >> Enable Clang Compilation for the vdso32 library.
> >
> > [...]
> >
> > >> +LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> > >
> > > Well this is unfortunate :/
> > >
> > > It looks like adding the --target flag to VDSO_LDFLAGS allows
> > > clang to link the vDSO just fine although it does warn that -nostdinc
> > > is unused:
> > >
> > > clang-11: warning: argument unused during compilation: '-nostdinc'
> > > [-Wunused-command-line-argument]
> > >
> >
> > This is why ended up in this "unfortunate" situation :) I wanted to avoid the
> > warning.
> >
> > > It would be nice if the logic of commit fe00e50b2db8 ("ARM: 8858/1:
> > > vdso: use $(LD) instead of $(CC) to link VDSO") could be adopted here
> > > but I get that this Makefile is its own beast :) at the very least, I
> > > think that the --target flag should be added to VDSO_LDFLAGS so that gcc
> > > is not a requirement for this but I am curious if you tried that already
> > > and noticed any issues with it.
> > >
> >
> > --target is my preferred way as well, I can try to play another little bit with
> > the flags and see what I can come up with in the next version.
>
> Yes, please. I'd even prefer the warning rather than silently assuming that
> a cross gcc is kicking around on the path.
>

Doesn't Clang have -Qunused-arguments for that?
