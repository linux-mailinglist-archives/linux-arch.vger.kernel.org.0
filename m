Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE65388B3B
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 11:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344970AbhESJ5l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 05:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239269AbhESJ5k (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 05:57:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 863CD610A1;
        Wed, 19 May 2021 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621418179;
        bh=sZokVnqgg00yP4zqIdHOGtJNBrDhc7J4zbJvv0Ja+io=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GYQJtAh0WaKxA6miEevGbUjT/mk3FvnIDKg/CajqjoSahOznMEGHCRzfEIrcVsIgw
         jVonLhDVI3iO2i3b48e+LZgxHdDKmIXzTZmGy8LtB+vutYxuwIPD3D0SfNma2Dy8bH
         fIaAfkbRt74xUeORaRxWYpDorVwd4ufaJvtD42xpkC7PBMC6VvqF0GH+RRw5BS9Y9F
         V/XLOyj7zDVj9SRnU2xFjKcCjHrJhnvUImDYRi1Ao/BOX9t7RGebtf4046niW1Mxzw
         6jRAK7SIiwi+H/pR2F0wkuhdZKh7EXx+LRh+Cy2bMyX9b9vO+N7Fcdjv0axjqcDG8o
         QNbVDBUWvjxFg==
Received: by mail-wr1-f53.google.com with SMTP id a4so13364466wrr.2;
        Wed, 19 May 2021 02:56:19 -0700 (PDT)
X-Gm-Message-State: AOAM531dYy8s1uPLEIP3jP1WMmCoOn6IeJm4Iq2/B6YOHtnmza8eUHk5
        pvFhIrr7F+ECAsC+KvifBVO/8I6Bbyc2hrszHeQ=
X-Google-Smtp-Source: ABdhPJxirDRKmtA1WHZsh+96IOOD39lg70KHdjcBxrpwvP9eC7gAvKJhLCHII5pv2yoe8aJ74qHdnQpI6dkT/Ni7pnk=
X-Received: by 2002:adf:e589:: with SMTP id l9mr13892459wrm.361.1621418178204;
 Wed, 19 May 2021 02:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-2-arnd@kernel.org>
 <m1bl982m8c.fsf@fess.ebiederm.org> <CAK8P3a27_z8zk6j5W4n+u3g2e90v-h+3AbaTZ6YjCQ0B7AbJaA@mail.gmail.com>
 <CAK8P3a277VggQbBnXUzpwP7TKMj-S_z6rDMYYxfjyQmzGJdpCA@mail.gmail.com> <m1y2cbzmnw.fsf@fess.ebiederm.org>
In-Reply-To: <m1y2cbzmnw.fsf@fess.ebiederm.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 19 May 2021 11:55:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2kjF5v9OyNL+8m_855xqjcW3MWfRrigmWirAaEk1O6nw@mail.gmail.com>
Message-ID: <CAK8P3a2kjF5v9OyNL+8m_855xqjcW3MWfRrigmWirAaEk1O6nw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 12:45 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@kernel.org> writes:
> > On Tue, May 18, 2021 at 4:05 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >> On Tue, May 18, 2021 at 3:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I think something like the untested diff below is enough to get rid of
> compat_alloc_user cleanly.
>
> Certainly it should be enough to give any idea what I am thinking.

Yes, that looks sufficient to me. I had started a slightly different
approach by trying
to move the kimage_alloc_init() into the top-level entry points to
avoid the extra
kmalloc, but that got rather complicated, and your patch is simpler overall.

The allocation could still be combined with kexec_load_check() into a new
function to reduce the number of duplicate lines, but if you think the current
version is ok, then I'll leave this part as it is.

I've fixed a duplicate kfree() and some whitespace damage, and rebased the
rest of my series on top of this to give it a spin on the build test boxes.
I'll send a v4 series once I have made sure there are no build-time regressions.

Can I add your Signed-off-by for the patch?
Is there a set of tests I should run on it?

      Arnd
