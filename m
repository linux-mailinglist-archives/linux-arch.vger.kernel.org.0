Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8835B2B1C2
	for <lists+linux-arch@lfdr.de>; Mon, 27 May 2019 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfE0KCz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 May 2019 06:02:55 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42050 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfE0KCz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2019 06:02:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id b18so11021540qkc.9;
        Mon, 27 May 2019 03:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVRVMHeKQqu97EmqZ0O2CzVit3QZ4+rp2cPhTqKUleU=;
        b=Ah2Nl7I0XrO1BF0129m1q114xMAxhM1EIFdCsOrvDEPGtCWRfuugXcv/MlUWvqaRQ8
         +QKmCupFf+W46GUUABMC5MFVCAQAa8fVg1/xjI8RuYwZ1dszywcPWVXd1kg2+9KeGNW3
         ++fOxiPql8P8oPUP1YCvLy5KKwK19mJgjFF6rIcBq4IDX1wBIo5wMbgrVkJRrjlFXf3u
         nzRU5DrcQi+4iArfoXZDEOZQwD+unPIj+cQ66407EQ7MWOjmwpyHSNFFUyQbpdrfW0Df
         B96uLx6cV5Q3rNK1tkPcGGY63RevXMncscrfTvL9dUexLl6cyZdyGHzfyOLQ1v4B0tIF
         Hkaw==
X-Gm-Message-State: APjAAAXh82AtaNPEJI+4wAM3akeUgwb0t3kLx9VP/StV9kBTVjhr5A1f
        Fr8VqIUR2uSzUex9FMQJv/K3VCEUPLChk8+FI6c=
X-Google-Smtp-Source: APXvYqxKXE2KyVGw2FI19RnWnVk2RakcSWcDalFy1vamE3kyUqX41ltgZh+7vXtFVvCj+VsaY9djVyudGKIBnjILpNc=
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr7530789qve.176.1558951373831;
 Mon, 27 May 2019 03:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io> <20190526102612.6970-2-christian@brauner.io>
In-Reply-To: <20190526102612.6970-2-christian@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 May 2019 12:02:37 +0200
Message-ID: <CAK8P3a1Ltsna_rtKxhMU7X0t=UOXDA75tKpph6s=OZ4itJe7VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arch: wire-up clone6() syscall on x86
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
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

On Sun, May 26, 2019 at 12:27 PM Christian Brauner <christian@brauner.io> wrote:
>
> Wire up the clone6() call on x86.
>
> This patch only wires up clone6() on x86. Some of the arches look like they
> need special assembly massaging and it is probably smarter if the
> appropriate arch maintainers would do the actual wiring.

Why do some architectures need special cases here? I'd prefer to have
new system calls always get defined in a way that avoids this, and
have a common entry point for everyone.

Looking at the m68k sys_clone comment in
arch/m68k/kernel/process.c, it seems that this was done as an
optimization to deal with an inferior ABI. Similar code is present
in h8300, ia64, nios2, and sparc. If all of them just do this to
shave off a few cycles from the system call entry, I really
couldn't care less.

       Arnd
