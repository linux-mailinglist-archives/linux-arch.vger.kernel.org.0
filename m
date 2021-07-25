Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08953D4D09
	for <lists+linux-arch@lfdr.de>; Sun, 25 Jul 2021 12:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhGYJZI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Jul 2021 05:25:08 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:39481 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhGYJZI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Jul 2021 05:25:08 -0400
Received: by mail-vk1-f172.google.com with SMTP id f1so1379263vkk.6
        for <linux-arch@vger.kernel.org>; Sun, 25 Jul 2021 03:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHyqWT5T8EnnHCYAwXfDHN6CTdT91ozwfA6Z/DQ/7N8=;
        b=hyh/Y061JVhYgDZZ5GFHZhIAddProdK+0LmFzgLc5H2/Ekgrjo1GhH6ibR+/+Lvz5Q
         l/qF6GxNn4KrWMlzpYuPp7jxZcp+iZS10sSPkYAdgbeUzNXwufhTtzmQANKzL4rmBx1f
         R+9Bt5b8EWHr/BsZ4Xo+765xNXc6HcFy4gSoN18fftBD4w+AR33LcjqFmI9xQYUuL11N
         Iwtw0EFN7cQffAmZq2tTkD4GDtK81ipwvYvUYJQ21pjQxNYhOjxS92fB+4yxDpnbtykc
         0PDPdn4v5UDq4XuJWsno565aVSj/1caVjLyAYQdy0RmRhfwz9IkXGpNgfNx0v0pJEwPg
         HTaA==
X-Gm-Message-State: AOAM532+MV68O5SFCjiDcoEKVRxTHq1ScK8k2FSrLgtUwwQDB0XoHv/U
        kERyGlQusi33jXLGwHPlHVGd6u6FJdfOB1VxYMY=
X-Google-Smtp-Source: ABdhPJzQKq4M8f7Z5qDbOveUgVw3PiuXDpF00/PNMEaRAbyNIAhtUEl8Hf0fNN11BiGeW9PYKobK+69rnZDtrCXfnl8=
X-Received: by 2002:ac5:cd9b:: with SMTP id i27mr7805690vka.1.1627207537068;
 Sun, 25 Jul 2021 03:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <1624407696-20180-1-git-send-email-schmitzmic@gmail.com> <1624407696-20180-4-git-send-email-schmitzmic@gmail.com>
In-Reply-To: <1624407696-20180-4-git-send-email-schmitzmic@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 25 Jul 2021 12:05:26 +0200
Message-ID: <CAMuHMdVA5d7z6awGrpJ+Tb3PRxz7Nczd_SLXZ=cAwsS8tFU_vg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] m68k: track syscalls being traced with shallow
 user context stack
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On Wed, Jun 23, 2021 at 2:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Add 'status' field to thread_info struct to hold syscall trace
> status info.
>
> Set flag bit in thread_info->status at syscall trace entry, clear
> flag bit on trace exit.
>
> Set another flag bit on entering syscall where the full stack
> frame has been saved. These flags can be checked whenever a
> syscall calls ptrace_stop().
>
> Check flag bits in get_reg()/put_reg() and prevent access to
> registers that are saved on the switch stack, in case the
> syscall did not actually save these registers on the switch
> stack.
>
> Tested on ARAnyM only - boots and survives running strace on a
> binary, nothing fancy.
>
> CC: Eric W. Biederman <ebiederm@xmission.com>
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>

Thanks for your patch!

> --- a/arch/m68k/kernel/entry.S
> +++ b/arch/m68k/kernel/entry.S
> @@ -51,75 +51,115 @@
>
>  .text
>  ENTRY(__sys_fork)
> +       movel   %curptr@(TASK_STACK),%a1
> +       orb     #TIS_SWITCH_STACK, %a1@(TINFO_STATUS+3)

This doesn't work on Coldfire:

arch/m68k/kernel/entry.S:55: Error: invalid instruction for this
architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001,
68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k,
68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32
[68330, 68331, 68332,
 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) --
statement `orb #(1<<1),%a1@(16+3)' ignored

>         SAVE_SWITCH_STACK
>         jbsr    sys_fork
>         lea     %sp@(24),%sp
> +       movel   %curptr@(TASK_STACK),%a1
> +       andb    #TIS_NO_SWITCH_STACK, %a1@(TINFO_STATUS+3)

arch/m68k/kernel/entry.S:60: Error: invalid instruction for this
architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001,
68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k,
68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32
[68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349,
68360], fidoa [fido]) -- statement `andb #(~((1<<1))),%a1@(16+3)'
ignored

>         rts

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
