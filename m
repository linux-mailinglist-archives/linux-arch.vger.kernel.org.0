Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7723A5A5E
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbhFMUfm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 16:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbhFMUfm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 16:35:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB23C061766
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:33:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bp38so17605251lfb.0
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VC5cDZGWEYWXdqFfbXDpqSf2zZYlr3PKXrJxtfAkz2M=;
        b=cd5cBp/Yn7qqbIqUiv2KvlvBMaJ5y5QFxGvkESukJAqrMM4dzGnqOa91I9VnWf3Fjo
         /OioPPbJRTvwXRUkb+EEK4PA61DyFEcGBYFDAujv6jWzpVc3aN5rGCrtGE411PZs1nqv
         Ek2jx/dgIpb6/RQbggoVhe9JasBuxKt2UD2Zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VC5cDZGWEYWXdqFfbXDpqSf2zZYlr3PKXrJxtfAkz2M=;
        b=olBM+yLgwZohgMNZ78nZ9v/YkO44HpQ+LkKgg39VkBQ8vm5QL/XjoOuPST6Ew/xToI
         qDIZrdgfQ3sdni5HIcdSiXQZ0h4z8ZAlzvN+R1i9wIQ581rP8JhdXzCnDwxqK1+Gr+H4
         sn7b54c1yziux2cG77xYzwWyMGwbY9zb3QOF2rKPg0kbvQL5aNARviga3va6MaNzE6Oz
         sXXvX8W6wOY8EbB7grV+9MVFu/Di7dbB1qscAD63fL1mlRHUDQOA847ef6fId7dp74F0
         pyzkC5DMUFpUubEoqW/P6/Qvd4sW6++8ct+1LHEfcl7WcwhbGY6umoR5JUrfk8npq57J
         qEag==
X-Gm-Message-State: AOAM533U7OpLK5rHri1QC4q32a85tsKjSQSfPqn211eUyIx5nxEo11gV
        FO3T9203aV0uVRN7fIRSQFTp7LyyXFXVnfvk
X-Google-Smtp-Source: ABdhPJwDBHoRBOhWHccqr8sCMIPmQTaU+LuvnvvuWWaRud4S90aBJkITpIRHkDNF1cKIW28HxgF61w==
X-Received: by 2002:a05:6512:6cc:: with SMTP id u12mr9647658lff.32.1623616402096;
        Sun, 13 Jun 2021 13:33:22 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w8sm1272839lfp.209.2021.06.13.13.33.21
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 13:33:21 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id r16so17190383ljk.9
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:33:21 -0700 (PDT)
X-Received: by 2002:a2e:b618:: with SMTP id r24mr6031999ljn.48.1623616401345;
 Sun, 13 Jun 2021 13:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <1623541098-6532-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=wi2KnsPbv2BOKHa+hb3CmyxsWRQBmSrzqzNezZ=vxH6bg@mail.gmail.com>
 <0a96ad37-dedb-67f3-3b27-1ff521c41083@gmail.com> <CAHk-=whO6fK4xCuEYDmDMVg_WKxP8cu429x7qjEO_k5sYVoMhg@mail.gmail.com>
In-Reply-To: <CAHk-=whO6fK4xCuEYDmDMVg_WKxP8cu429x7qjEO_k5sYVoMhg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Jun 2021 13:33:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wje1Y3hVoQX-jZNQcscUuXO7Fe9tNQBcfyLJNUDMegT4g@mail.gmail.com>
Message-ID: <CAHk-=wje1Y3hVoQX-jZNQcscUuXO7Fe9tNQBcfyLJNUDMegT4g@mail.gmail.com>
Subject: Re: [PATCH v1] m68k: save extra registers on sys_exit and
 sys_exit_group syscall entry
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 13, 2021 at 1:26 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and then in gdb you just do
>
>         b main
>         run

Btw, this extra stage is unnecessary, but if I just do that "catch
syscall group:process" before the process has even started, gdb gets
confused at the start.

You could skip this and just do "catch syscall exit_group" and then "run".

I used that "group:process" just to catch both the legacy "exit" and
the new "exit_group", but then it catches fork/execve too, and I think
that's what confuses gdb when it happens as you start the process.

Just to clarify why I did that odd thing.

             Linus
