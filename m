Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F5D435CC7
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 10:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhJUIUf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 04:20:35 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45819 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhJUIUd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 04:20:33 -0400
Received: by mail-ot1-f45.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so11313122otq.12;
        Thu, 21 Oct 2021 01:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hd/+QnCCQ1ttXjZzIuOwM5Awcbe5eGoYYrYqsyq6bCA=;
        b=hWtfWfjBkvbQN6+S/T071uaPJLFOXDBzglYceACeFgr80VxaUfcoWAJo5UK669n4OU
         i+lRrd8kjZQX0pYmVb9hdwecJd6/M6FK87+udBqwENwpiPCVFVlvT4xugAC9sh9FyYb8
         TTR9w12VN/m2pnPMsL+PyxZOuRin0/KBEnguZ9Q0o/2fPZDOUGCA+SZg1IylCMMNyGVN
         BboYt89LvrGqhKpcRLjrO/yu38xHrnwcnq2HeRdEc/KXpOhtLFx+a+eW2vccRUsWQNlC
         ambluegEEs0pbyaNmGUQs4qS0gGRrsp3HCgja7D0SC9WeHLmaopAIGeKVb3geKM3i2jy
         2JNA==
X-Gm-Message-State: AOAM532r/c0ob3o4R0e7NVzP4x+49pKlDHp2s3gwrh9AXsmsApdqsrqe
        LdVF4DdYLCjr8u1+xW3TEdGoDjpfxQnKxQ==
X-Google-Smtp-Source: ABdhPJwl18YmfI6yLfUyvuRUylrzdnZIoNu+Orbtt/7R1cFBDtqJVkCq7y6q1P9hDXkwIKuEw0uZ5w==
X-Received: by 2002:a05:6830:2708:: with SMTP id j8mr3681292otu.240.1634804297167;
        Thu, 21 Oct 2021 01:18:17 -0700 (PDT)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id q185sm507885oib.26.2021.10.21.01.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 01:18:17 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so9561974ott.2;
        Thu, 21 Oct 2021 01:18:16 -0700 (PDT)
X-Received: by 2002:ab0:3d9a:: with SMTP id l26mr4816956uac.114.1634803797383;
 Thu, 21 Oct 2021 01:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <877de7jrev.fsf@disp2133>
In-Reply-To: <877de7jrev.fsf@disp2133>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Oct 2021 10:09:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
Message-ID: <CAMuHMdURxrdjsXq7+q-AWTwxVUdmddOj2vvNHv6M=WtsU5nRvg@mail.gmail.com>
Subject: Re: [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV) with force_fatal_sig(SIGSEGV)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rich Felker <dalias@libc.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        H Peter Anvin <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonas Bonn <jonas@southpole.se>,
        Kees Cook <keescook@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Openrisc <openrisc@lists.librecores.org>,
        Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

Patch 21/20?

On Wed, Oct 20, 2021 at 11:52 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Now that force_fatal_sig exists it is unnecessary and a bit confusing
> to use force_sigsegv in cases where the simpler force_fatal_sig is
> wanted.  So change every instance we can to make the code clearer.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

>  arch/m68k/kernel/traps.c        | 2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
