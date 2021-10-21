Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048D0435CF0
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 10:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJUIep convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Thu, 21 Oct 2021 04:34:45 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:45857 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbhJUIei (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Oct 2021 04:34:38 -0400
Received: by mail-oi1-f180.google.com with SMTP id z126so12801547oiz.12;
        Thu, 21 Oct 2021 01:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ceLayuoY70owN3NNsnQH6S+jy2K/HGM8B6O2q8i1GAk=;
        b=YCr0yE2FgiqGaAqFS2CQf6iIuzKjkgSChItshZahMB8bH09SCBbqVTEhxPR2nEbABI
         J28+vLs7F423PE22/SRg5MvHV82v84xUJa/lRuWT5cdmE+68risR3FGVG6u2tLx7bPVY
         ts7UkiXatY3svnoOZRLY0diRcQmRaGh7sl0YshBJAyRT8RvTBjoAlrPscfL1H99z1Ah/
         VL3dSpfxThB0tnTcpsHxCxuIKnoV0Z6WCttKGuhuirz3WC1IEz31OeNoQhQAKc5dZdy9
         uZrcf0QPbThf2OkjtRXpD1rqKQRQXgu07R/l2c0Gmh4o9NgoBTZh48TYjfgUa6dMw5Hz
         c/mA==
X-Gm-Message-State: AOAM530LpmidWPEL43GrLudI1V3XbiGyrv6qsIjOtNmBnkhH4dtFbyS/
        w+s5sA+bujyeZVNVWk8+iBtj1wQolWlmttu59Vg=
X-Google-Smtp-Source: ABdhPJxII4gwyuuwZSE0+97ar6I7zWp2Jlu7LoTmQcOVpBv5Lkm+3ns6lcPNpIqYwJ3CoMM3pxGAXl0ujDP3wS4Hl9w=
X-Received: by 2002:aca:eb82:: with SMTP id j124mr3578574oih.46.1634805141944;
 Thu, 21 Oct 2021 01:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <87y26nmwkb.fsf@disp2133> <877de7jrev.fsf@disp2133>
In-Reply-To: <877de7jrev.fsf@disp2133>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Thu, 21 Oct 2021 10:32:10 +0200
Message-ID: <CAAdtpL5+bjpy93DY5gf1ZM4k3BtP+JNJAUSSmvt8cq3shsJR4A@mail.gmail.com>
Subject: Re: [PATCH 21/20] signal: Replace force_sigsegv(SIGSEGV) with force_fatal_sig(SIGSEGV)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 20, 2021 at 11:52 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
>
> Now that force_fatal_sig exists it is unnecessary and a bit confusing
> to use force_sigsegv in cases where the simpler force_fatal_sig is
> wanted.  So change every instance we can to make the code clearer.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/arc/kernel/process.c       | 2 +-
>  arch/m68k/kernel/traps.c        | 2 +-
>  arch/powerpc/kernel/signal_32.c | 2 +-
>  arch/powerpc/kernel/signal_64.c | 4 ++--
>  arch/s390/kernel/traps.c        | 2 +-
>  arch/um/kernel/trap.c           | 2 +-
>  arch/x86/kernel/vm86_32.c       | 2 +-
>  fs/exec.c                       | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
