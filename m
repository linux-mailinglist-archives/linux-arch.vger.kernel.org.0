Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07361B9F3B
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD0JAN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0JAN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 05:00:13 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7CC061A10;
        Mon, 27 Apr 2020 02:00:12 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 499dyg0GXTzQlJ3;
        Mon, 27 Apr 2020 11:00:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id DbjYKUVnLrBu; Mon, 27 Apr 2020 11:00:07 +0200 (CEST)
Date:   Mon, 27 Apr 2020 11:00:05 +0200 (CEST)
From:   Hagen Paul Pfeifer <hagen@jauu.net>
Reply-To: Hagen Paul Pfeifer <hagen@jauu.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Message-ID: <2008370628.171531.1587978005102@office.mailbox.org>
In-Reply-To: <CAK8P3a1qdyw+5B-E52O42VEWvpq_6jF74__ptM+q6SoKd3pkuA@mail.gmail.com>
References: <20200426130100.306246-1-hagen@jauu.net>
 <20200426163430.22743-1-hagen@jauu.net>
 <CAK8P3a1qdyw+5B-E52O42VEWvpq_6jF74__ptM+q6SoKd3pkuA@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Rspamd-Queue-Id: BC5A81693
X-Rspamd-Score: 0.45 / 15.00 / 15.00
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> On April 27, 2020 10:30 AM Arnd Bergmann <arnd@arndb.de> wrote:

Hey Arnd

> When you add a new system call, please add it to all architectures.
> See the patches for the last few additions on how to do it, in
> particular the bit around adding the arm64 compat entry that is
> a bit tricky.

Yes, the patch was intended to be as an rough (but x86_64 working)
RFC patch to basically check if there is interest in it. Or whether
there are fundamental reasons against pidfd_ptrace().

If not I will prepare v3 with all input, sure! Thank you Arnd

Hagen
