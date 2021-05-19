Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063EC388F57
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 15:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbhESNnt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 09:43:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhESNnt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 09:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6804C61073;
        Wed, 19 May 2021 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621431749;
        bh=hkMKaefUTDUwr0Z0eUT1cJgEMFnVcnhMetquZ12S2kY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K1O7NZybQkKHxgrF8CUVBXUbbVsfeRZExPgycekw8Mp3WMW3ZVeFFuemlsphvr6mQ
         EnxLtDdIG5R3dU6WEBkg+bGG41kBm9/LGSSYtkVRoHh+P0fOvI1lR5rNIXbSMcYiW1
         oyJ++WRAzIsmlz1fnwav/juWewehG9QqNv9a46WbZlXkyzRU1qn9quYtC+opTWqlWr
         +RoX+YCQCPSzfqsek+Ljjf06oG2l0zqWkrQTXDNsJprDr1eKJccI3p9jEYx7aPFabG
         bvcohgEqJUx44fj671YH7xCqMWNIOyiUlmESFpweX40nbpNN1OC27Yhn4AF6ztbEEv
         FQXUJsYGrZJHw==
Received: by mail-wr1-f50.google.com with SMTP id p7so10346840wru.10;
        Wed, 19 May 2021 06:42:29 -0700 (PDT)
X-Gm-Message-State: AOAM531bk9CEFOfpX7b9G9k1WxYcpHhXOu8kBe30Yr5gy0uHP660lJJH
        +mmZvPUjztTQFPNBQ3GnxpCyVpn9kCTY3TAn818=
X-Google-Smtp-Source: ABdhPJzkIbFl99FOXt6elobu2LwCnNdjjquJ1/r7IVc1E+OFNv6b39/2WxIknufzd5MXTjoFKqNgb73GyWJ6Rj43JVc=
X-Received: by 2002:a05:6000:1b0b:: with SMTP id f11mr14855486wrz.165.1621431748001;
 Wed, 19 May 2021 06:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-3-arnd@kernel.org>
 <f52b8bc9600443dab1814766552fe6bf@AcuMS.aculab.com>
In-Reply-To: <f52b8bc9600443dab1814766552fe6bf@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 19 May 2021 15:41:15 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2WD+Y8hALadK1iCnaSijO8Xr+o-05s5KnJt292FENuMw@mail.gmail.com>
Message-ID: <CAK8P3a2WD+Y8hALadK1iCnaSijO8Xr+o-05s5KnJt292FENuMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: simplify compat_sys_move_pages
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 10:49 PM David Laight <David.Laight@aculab.com> wrote:
> >
> > +static int put_compat_pages_array(const void __user *chunk_pages[],
> > +                               const void __user * __user *pages,
> > +                               unsigned long chunk_nr)
> > +{
>
> Should that be get_compat_pages_array() ?

Nice catch, thanks!

Fixed now.

       Arnd
