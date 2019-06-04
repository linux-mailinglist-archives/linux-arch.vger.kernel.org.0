Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4A134FEB
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jun 2019 20:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFDSkT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jun 2019 14:40:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34963 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFDSkT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jun 2019 14:40:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id l128so3524412qke.2;
        Tue, 04 Jun 2019 11:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PeTVnVUQ+GONB0rIWZed0hseSmoR8h88XuUzFAPkiyI=;
        b=B9m4urp2qvPlzop1mX1/3zYLXIUxsEUeOz1JO9Qj8Hf3Xl8qb6VVxj3bebfYdMNV5a
         7J/tYgwAp8xSn4gIttAIHt1xmaNEP6d2kAczz+bI7VgxmS9O2TIAZoPjv67gbEvQQIkd
         qTtv+oAOnpLA9ATeCbaxDrEA8C+MNkAa3JHYpd46m6UFf1buyNVu9Iy/y20OzHrNBbM2
         H4VYZfRaFPL4svLkrmwZXdrEYWWB30wkb+tRGR9eGA6TFhzKK+D5bEweMOrgiyt44bFN
         74uktXXRfJBSsdmdGBbSo2W/fH3RufAo+ZpDIYBtB+5aUodXc2/pMsqUXkoFTsrVJZE1
         ksLw==
X-Gm-Message-State: APjAAAXKHuWFJLC4xouZPiYBRl67jjCGzv4iQ7TjL9VAaZrE/yhZ4f5R
        ay134bi+6I99dHJiUlMnF9PTUPWZfNI1H2idg2E=
X-Google-Smtp-Source: APXvYqzUIUc2zarPAtswLtMBwKGPQRl08mZYv465oTVDfRCpXmj8pCr6HPGN/ds+HEPBV0WTRAbu4iiAQu5K87R9T9Q=
X-Received: by 2002:a05:620a:16c1:: with SMTP id a1mr28265382qkn.269.1559673618266;
 Tue, 04 Jun 2019 11:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190604160944.4058-1-christian@brauner.io> <20190604160944.4058-2-christian@brauner.io>
In-Reply-To: <20190604160944.4058-2-christian@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jun 2019 20:40:01 +0200
Message-ID: <CAK8P3a0OfBpx6y4m5uWX-DUg16NoFby5ik-3xCcD+yMrw0tbEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 4, 2019 at 6:09 PM Christian Brauner <christian@brauner.io> wrote:
>
> Wire up the clone3() call on all arches that don't require hand-rolled
> assembly.
>
> Some of the arches look like they need special assembly massaging and it is
> probably smarter if the appropriate arch maintainers would do the actual
> wiring. Arches that are wired-up are:
> - x86{_32,64}
> - arm{64}
> - xtensa

The ones you did look good to me. I would hope that we can do all other
architectures the same way, even if they have special assembly wrappers
for the old clone(). The most interesting cases appear to be ia64, alpha,
m68k and sparc, so it would be good if their maintainers could take a
look.

What do you use for testing? Would it be possible to override the
internal clone() function in glibc with an LD_PRELOAD library
to quickly test one of the other architectures for regressions?

      Arnd
