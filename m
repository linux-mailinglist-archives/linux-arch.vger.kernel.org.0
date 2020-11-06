Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0886D2A99E1
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKFQz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 11:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgKFQz1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Nov 2020 11:55:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BA620720;
        Fri,  6 Nov 2020 16:55:25 +0000 (UTC)
Date:   Fri, 6 Nov 2020 11:55:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/8] linker-section array fix and clean ups
Message-ID: <20201106115523.41f7e2ed@gandalf.local.home>
In-Reply-To: <20201106164537.GD4085@localhost>
References: <20201103175711.10731-1-johan@kernel.org>
        <20201106160344.GA12184@linux-8ccs.fritz.box>
        <20201106164537.GD4085@localhost>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 6 Nov 2020 17:45:37 +0100
Johan Hovold <johan@kernel.org> wrote:

> It's simply specifying alignment when declaring the variable that
> prevents this optimisation. The relevant code is in the function
> align_variable() in [1] where DATA_ALIGNMENT() is never called in case
> an alignment has been specified (!DECL_USER_ALIGN(decl)).
> 
> There's no mention in the documentation of this that I'm aware of, but
> this is the way the aligned attribute has worked since its introduction
> judging from the commit history.
> 
> As mentioned above, we've been relying on this for kernel parameters and
> other structures since 2003-2004 so if it ever were to change we'd find
> out soon enough.
> 
> It's about to be used for scheduler classes as well. [2]

Is this something that gcc folks are aware of? Yes, we appear to be relying
on undocumented implementations, but that hasn't caused gcc to break the
kernel in the past.

-- Steve
