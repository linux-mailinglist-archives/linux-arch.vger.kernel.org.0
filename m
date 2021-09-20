Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587AE412D59
	for <lists+linux-arch@lfdr.de>; Tue, 21 Sep 2021 05:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhIUDVB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 23:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244157AbhIUCbN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2021 22:31:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBACC04A156
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 13:11:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b15so54117404lfe.7
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 13:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJRE9kS/QPf/0tOqznxzvGRA8erQC6C/9CuG+/yz+9U=;
        b=MjF/lwuc6mPv7nAhg2ZP9d30rlvilAFvjKmYIG8K/nAhbMgJRIcrN70sahLhELV4NY
         uJMN/H9Eb+TGaf8vH+d6MIDjEqr8JeeHKbNJeW1urY2uxDdTgMkADNmigKMnbr6Ri8D8
         J+BrPizNwPAYdm66/8hXK2c/1vjtRzwGGDMjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJRE9kS/QPf/0tOqznxzvGRA8erQC6C/9CuG+/yz+9U=;
        b=oJU6lhiXcLBTvbUI04n021apH4LvKKZRbEK6FI6lCBsgg6WxBzDSPRdN4D2Zd+jnwY
         aZwx5yJyy5lkTe4CKKA1OuDtUYmpaIRUf6pkXUe7ISpRUSliJzcMfUGVLXydjV2Pl34g
         GE00oJavxpR7oDx2xpIuqx35F9K+Eet/OVARBQa/iLVS+NmJVgWO8/f6iHrrUMJjXSJG
         XmMzq+FqIZYOL6oyc8XysKQpFR03Yrb6i/neUsYVBU5IRRYAYRVxkvrEVlmxLhl6Vguz
         HfDK0LPsilxYMC4QjzzXbJXrpEPbeto75fsFwSJhKwJ2hHpbpZnd8R2lxC1OnaNAh+sX
         u0XQ==
X-Gm-Message-State: AOAM530/BV0AEmZIgEsTxnrhYiuDtncjOQIPWAQGWY6h9mBnuAZFHZmY
        ViFn7ZCnmUBtP7saoF+8KYbYw7UztSKjLawIzk0=
X-Google-Smtp-Source: ABdhPJyvdCfgvxEtnGNk94Yk1OZHP8e+ngH39R6jnAbZY/Bm/OqcQgbwVKKmVMg/Y4kgVbDk12Ul9g==
X-Received: by 2002:a2e:9012:: with SMTP id h18mr1626234ljg.336.1632168711250;
        Mon, 20 Sep 2021 13:11:51 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id j12sm1867090ljc.121.2021.09.20.13.11.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 13:11:49 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id g41so39927778lfv.1
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 13:11:49 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr12260277ljc.249.1632168709492;
 Mon, 20 Sep 2021 13:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net> <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
 <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com> <715c52e6-9a71-6924-0643-407311ad56ba@physik.fu-berlin.de>
In-Reply-To: <715c52e6-9a71-6924-0643-407311ad56ba@physik.fu-berlin.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 13:11:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcCZW-Lu85djtfDSiQdOqH1hR=dDP5xHj6vhvMdBCMVA@mail.gmail.com>
Message-ID: <CAHk-=wjcCZW-Lu85djtfDSiQdOqH1hR=dDP5xHj6vhvMdBCMVA@mail.gmail.com>
Subject: Re: Linux 5.15-rc2
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 20, 2021 at 12:14 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> If you want to get feedback whether the kernel actually boots, let me know.

So having looked around more sparc64 actually looks to be ok as-is,
because it doesn't do any ioremap at all, and the PIO accesses are
done at physical address zero.

Sparc uses a special IO memory address space and can basically map all
of PCI that way, and it looks like the hardware does all the required
special things for the PIO range at address 0-0xffff.

So it turns out that the "missing iounmap()" is actually ok on sparc,
because it's a no-op anyway - because the ioremap() was just a pointer
cast with no actual remapping necessary.

And the generic IOMAP thing does assume that PIO is special, in ways
that sparc doesn't need. On x86, PIO is not remapped, but also uses
different instructions, so it's not just pointer games that could be
done at iomap/unmap case.

(And on many other architectures you need to do different
synchronization, even if you could perhaps otherwise make the
PIO-vs-MMIO be only about the pointer mapping - so "writeb()" and
"outb()" aren't just different in the addressing).

End result: the only downside of sparc not using the generic iomap is
likely that sparc will happily use a NULL __iomap pointer (error) and
basically use it as a PIO access. But since other architectures like
x86-64 would warn for that case (see 'bad_io_access()' in
lib/iomap.c), even that isn't actually a big deal - any such bugs
would have been found elsewhere.

And having looked at this, I'm starting to suspect that sparc oddity
is _why_ the fallback version in <asm-generic/io.h> was so broken. It
did the right thing on sparc, but leaks iomap remappings almost
anywhere else. But maybe sparc ended up being the only user of it?

           Linus
