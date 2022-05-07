Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE2351E6D6
	for <lists+linux-arch@lfdr.de>; Sat,  7 May 2022 14:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446131AbiEGMPD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 7 May 2022 08:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391180AbiEGMPB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 May 2022 08:15:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD4033884;
        Sat,  7 May 2022 05:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAC15B8009F;
        Sat,  7 May 2022 12:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1A7C385A6;
        Sat,  7 May 2022 12:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651925472;
        bh=ny0hixdm2DB1RZtEMrHXgACsqdZeemYTQuhSsXAyMAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YW/RatCk8lNqeYJ1ojv5lru5Rw94pEIjaS0Hr8WaAXhjDPEQzKEk6OwQtyjRQKsqV
         X4vxkcKZItcNhYtEERfPTd2aVVu3bLMQpxtFgwGUbQeEkd8UZ7paOdYxod1Hv9RYBb
         5L3QuWJ3nkLRvkUcX7RevWAz2F8UJXQT4zR6VTw535S6VaZbNHKDtESBkKNBVJoDQa
         iKHGcQOVxeCqWmNKWw0WDUoEI6Xh/vho/9QsUvlzDK2h8hUdmKtZhRo/jERXARmo/i
         5A+aU9pxupmDFO7WigUACN918yMjoLFQvWHI8uWtc5Tk+Ns7xrcyApL5YPx4oxccB+
         H1eFW5aaPCiFg==
Date:   Sat, 7 May 2022 14:11:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH V9 13/24] LoongArch: Add system call support
Message-ID: <20220507121104.7soocpgoqkvwv3gc@wittgenstein>
References: <20220430090518.3127980-1-chenhuacai@loongson.cn>
 <20220430090518.3127980-14-chenhuacai@loongson.cn>
 <CAK8P3a0A9dW4mwJ6JHDiJxizL7vWfr4r4c5KhbjtAY0sWbZJVA@mail.gmail.com>
 <CAAhV-H4te_+AS69viO4eBz=abBUm5oQ6AfoY1Cb+nOCZyyeMdA@mail.gmail.com>
 <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0DqQcApv8aa2dgBS5At=tEkN7cnaskoUeXDi2-Bu9Rnw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 30, 2022 at 12:34:52PM +0200, Arnd Bergmann wrote:
> On Sat, Apr 30, 2022 at 12:05 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Sat, Apr 30, 2022 at 5:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Sat, Apr 30, 2022 at 11:05 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > This patch adds system call support and related uaccess.h for LoongArch.
> > > >
> > > > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > > > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> > > >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> > > >    bit platforms still use newstat now.
> > > >
> > > > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > > > A: The latest glibc release (2.34) has some basic support for clone3 but
> > > >    it isn't complete. E.g., pthread_create() and spawni() have converted
> > > >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> > > >    related applications can still not work perfectly with clone3. E.g.,
> > > >    Chromium sandbox cannot work at all and there is no solution for it,
> > > >    which is more terrible than the fork() story [1].
> > > >
> > > > [1] https://chromium-review.googlesource.com/c/chromium/src/+/2936184
> > >
> > > I still think these have to be removed. There is no mainline glibc or musl
> > > port yet, and neither of them should actually be required. Please remove
> > > them here, and modify your libc patches accordingly when you send those
> > > upstream.
> >
> > If this is just a problem that can be resolved by upgrading
> > glibc/musl, I will remove them. But the Chromium problem (or sandbox
> > problem in general) seems to have no solution now.
> 
> I added Christian Brauner to Cc now, maybe he has come across the
> sandbox problem before and has an idea for a solution.

(I just got back from LSFMM so I'll reply in more detail next week. I'm
still pretty jet-lagged.)
