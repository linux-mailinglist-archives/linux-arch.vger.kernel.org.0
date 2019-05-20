Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 539F823A3D
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2019 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391654AbfETOhX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 May 2019 10:37:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36052 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731837AbfETOhX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 May 2019 10:37:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id c14so8968045qke.3;
        Mon, 20 May 2019 07:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/2L5o2AoOKLKFPcdkjNIAmz2G/5ZFe52UTQRqPzuYk=;
        b=DV3jVCYnKcYK5l9o1u8iwTMUtREqHQ8NhUc5CrfrrjoCQyudywF7NVNcUATvxJPQc0
         IfxQfRVKad2p/2KrIzd5K5z4vfqvgq+KNkSPZzF46vHUhjQjY+0WTN2uTZdTZ4xYBun7
         uSXsEWZSgRAZ6bKcsh23qjLoqSH5pXuH2attLD/4dIE+LUuumtb4I5m9wlAC52y7akhH
         HFwNd4K0EGWfMTO1nTL/6gQ3NciBUxM5BpzS7zDC7Oplp553GkihCRWSZSBLT0WHTf3h
         rOBxfVAI8YIE72CYVHD52TC2gYcHcjouW+wjRIBaW1QUw5lkO6mvzOBR4UJqvOf+dIsV
         sDDw==
X-Gm-Message-State: APjAAAXMKWh+uCHSSDCF1f5hhuWeW4jIGQo8ihVjltulq3A2Eafk5rXu
        zpN9EO1bcMJVO9LZEY87ekKh4QwFFBPDXb+I9s0=
X-Google-Smtp-Source: APXvYqw/K0JoPhQjbioFloDoxv8hPwsc8PzdGxaBHlE2BolGJGFffF+O1yZKUKyE5ZdibkGoaW8RhPzIvapSmk2bhfM=
X-Received: by 2002:a05:620a:5ed:: with SMTP id z13mr21969541qkg.84.1558363041328;
 Mon, 20 May 2019 07:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190520134605.29116-1-christian@brauner.io>
In-Reply-To: <20190520134605.29116-1-christian@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 May 2019 16:37:03 +0200
Message-ID: <CAK8P3a1cZZ6SQe5mGjhga=MgTvCGF6OKyjvosR8J6z6EpH+rVA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, cyphar@cyphar.com,
        David Howells <dhowells@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 20, 2019 at 3:46 PM Christian Brauner <christian@brauner.io> wrote:
>
> In line with Arnd's recent changes to consolidate syscall numbers across
> architectures, I have added the pidfd_open() syscall to all architectures
> at the same time.

Thanks! I've checked that the ones you have added are all
done correctly. However, double-checking that you got all of them,
I noticed that you missed mips-o32 and mips-n64. With those added:

Acked-by: Arnd Bergmann <arnd@arndb.de>
