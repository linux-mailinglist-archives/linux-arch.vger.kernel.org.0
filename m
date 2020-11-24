Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322B72C2F61
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 18:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403811AbgKXRzp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 12:55:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48906 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732036AbgKXRzp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2020 12:55:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 9CBC41F44F1B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     tglx@linutronix.de, hch@infradead.org, mingo@redhat.com,
        keescook@chromium.org, arnd@arndb.de, luto@amacapital.net,
        wad@chromium.org, rostedt@goodmis.org, paul@paul-moore.com,
        eparis@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, kernel@collabora.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 04/10] seccomp: Migrate to use SYSCALL_WORK flag
Organization: Collabora
References: <20201116174206.2639648-1-krisman@collabora.com>
        <20201116174206.2639648-5-krisman@collabora.com>
        <20646400-0e16-0eb5-c829-3b77df8c38e3@gmail.com>
Date:   Tue, 24 Nov 2020 12:55:39 -0500
In-Reply-To: <20646400-0e16-0eb5-c829-3b77df8c38e3@gmail.com> (Dmitry
        Osipenko's message of "Tue, 24 Nov 2020 19:28:24 +0300")
Message-ID: <87360yprl0.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Dmitry Osipenko <digetx@gmail.com> writes:

> Hi,
>
> This patch broke seccomp on arm32 using linux-next, chromium browser
> doesn't work anymore and there are these errors in KMSG:
>
> Unhandled prefetch abort: breakpoint debug exception (0x002) at ...
>
> Note that arm doesn't use CONFIG_GENERIC_ENTRY. Please fix, thanks in
> advance.

Hi Dmitry,

I believe this is the same problem reported yesterday on this thread

  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2390444.html

can you please try the patch I shared on that thread?

  https://lore.kernel.org/patchwork/patch/1344098/

Thanks,

-- 
Gabriel Krisman Bertazi
