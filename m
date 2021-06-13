Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2410E3A5A59
	for <lists+linux-arch@lfdr.de>; Sun, 13 Jun 2021 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhFMU33 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Jun 2021 16:29:29 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:44819 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhFMU32 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Jun 2021 16:29:28 -0400
Received: by mail-lf1-f49.google.com with SMTP id r198so17486841lff.11
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoxaxoB26KFydlJxQzuZvQHGdzSalMGqJq/x7smY/qY=;
        b=Gp7j+VvfY/4cuumVaNyAmX8ySEzBlwhHdWraceOv8BOU+XYEAbhNbgTKhOsOZb0bO+
         ye/TCZI/fSfKUkGaStZ8Ds5Q9amNYicT7CY3sXFFJsSx8ywQRQuLTtKlflHkJEfYFuAy
         Dnp/jNycuDBJOpKvXmPpO5TtTzK6A36x2uVHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoxaxoB26KFydlJxQzuZvQHGdzSalMGqJq/x7smY/qY=;
        b=g/SNsrwAe61B120TefdJX7WmumR/rQfb5rPO/LGzt8fBp9ixDSbdjHkRyqlokmk23Z
         u4iuRhmfJktRGht3ek6srirXLC/fUJESZhPYeZsMEm3ImNUmOJ9pmbUlHo4ERgLoVLoj
         qV3SQS5VCYow1jdkStekY69jU/+Ur8W7o41V9wsY+3MaOIMBGZaitCTJpoE4KTdYKh8+
         x+IuYIQrUsz80aJSYjM7EAyGNQbMdluLcN6Thzi8K9U/ITFAU4qNcmSV8p+0N9qcnNjq
         9gdxenh49qMcpaN1yGHf6E4pJODWSBF93G8Vz/AsbimkZe/vGsjvjv54JgFNBTaFibmt
         dPkQ==
X-Gm-Message-State: AOAM5339Y3UQNY+QUZJhXKwyauufg64tAZelpz/8FFq4Srz0dn81gDmv
        0Nv1as7JIDGV8raBB03RLKTXDMycl28Kzf+H
X-Google-Smtp-Source: ABdhPJz8anh7a3o6RtwEjg9NEsZrO//UjjfEMkirBS6kT2HQizePvox3Ia6ObFFmDG97+zGYvw898Q==
X-Received: by 2002:ac2:4902:: with SMTP id n2mr9567347lfi.413.1623615985674;
        Sun, 13 Jun 2021 13:26:25 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f14sm1553977ljk.42.2021.06.13.13.26.25
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 13:26:25 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id d2so17123442ljj.11
        for <linux-arch@vger.kernel.org>; Sun, 13 Jun 2021 13:26:25 -0700 (PDT)
X-Received: by 2002:a2e:964f:: with SMTP id z15mr7499352ljh.251.1623615984931;
 Sun, 13 Jun 2021 13:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <87sg1p30a1.fsf@disp2133> <1623541098-6532-1-git-send-email-schmitzmic@gmail.com>
 <CAHk-=wi2KnsPbv2BOKHa+hb3CmyxsWRQBmSrzqzNezZ=vxH6bg@mail.gmail.com> <0a96ad37-dedb-67f3-3b27-1ff521c41083@gmail.com>
In-Reply-To: <0a96ad37-dedb-67f3-3b27-1ff521c41083@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Jun 2021 13:26:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whO6fK4xCuEYDmDMVg_WKxP8cu429x7qjEO_k5sYVoMhg@mail.gmail.com>
Message-ID: <CAHk-=whO6fK4xCuEYDmDMVg_WKxP8cu429x7qjEO_k5sYVoMhg@mail.gmail.com>
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

On Sun, Jun 13, 2021 at 1:07 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> I'd love that, too. My test rig doesn't allow dumping of registers by
> strace, but someone else may have that capacity.

I think doing it manually with gdb should be fairly straightforward.

Something like

        gdb /bin/true

and then in gdb you just do

        b main
        run

and then

        catch syscall group:process
        c

and it should stop at the exit_group or exit system call.

At that point you can just do

        info registers

and see if they match what user space *should* be. They'll probably be
complete garbage without the fix.

I do not have an alpha or m68k machine to test (and not the
energy/inclination to set up some virtual environment in qemu either).
But it should be easy if you already have that environment.

             Linus
