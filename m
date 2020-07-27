Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3495322FC48
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 00:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgG0WjP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 18:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0WjO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Jul 2020 18:39:14 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF3A21744
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 22:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595889554;
        bh=bzXfGesZwJ27ZcLacwSBj5UkSbxcuX0b9ThtTjRUEI4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xUuRMzrbJ8wox2VW8LIkRPZk4GtPqAvVTkvWtiAvz4piaTOsAm8z8+4DugVe6xx/2
         c8FnB7kCZ743heGfoNbbs2IKwcVQD63u9Z6nebTEwiJssc5NaQ0N3P9j8Y9l7jsTqT
         ofj0+oNXxEU8zryy2k3HQtKEGSi/sWuA0xR8BYto=
Received: by mail-wr1-f45.google.com with SMTP id b6so16386285wrs.11
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 15:39:14 -0700 (PDT)
X-Gm-Message-State: AOAM533C2sTaeNkZxKua8w7GAfi97c4pCNHgsKRJFMYbKwTs51/SwoBS
        pvUOF3WC4matUBiGlxTHKOHgcynpaMGBoTbvZgvL1A==
X-Google-Smtp-Source: ABdhPJy5xPtMUiSD1L18V/iohOqyp64MNQhn1uI3cIQMJk2KsNpAI3O4sAgBbYR7hD7T/x+IDlThjWpszcuWoh4VpbY=
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr21694913wrw.70.1595889552892;
 Mon, 27 Jul 2020 15:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200721105706.030914876@linutronix.de> <20200721110808.671110583@linutronix.de>
In-Reply-To: <20200721110808.671110583@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Jul 2020 15:39:01 -0700
X-Gmail-Original-Message-ID: <CALCETrUBQa=L_Chd=RAPDEihvUWC_9KoHG00zYsGOwiYg87naQ@mail.gmail.com>
Message-ID: <CALCETrUBQa=L_Chd=RAPDEihvUWC_9KoHG00zYsGOwiYg87naQ@mail.gmail.com>
Subject: Re: [patch V4 04/15] entry: Provide generic interrupt entry/exit code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Like the syscall entry/exit code interrupt/exception entry after the real
> low level ASM bits should not be different accross architectures.
>
> Provide a generic version based on the x86 code.

I don't like the name.  Sure, idtentry is ugly and x86-specific, but
irq gives the wrong impression.  This is an entry path suitable for
any entry that is guaranteed not to hit during entry/exit handling.
Syscalls, page faults, etc are not "irqs".
