Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 044FE30A1C
	for <lists+linux-arch@lfdr.de>; Fri, 31 May 2019 10:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEaIT6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 May 2019 04:19:58 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33915 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIT6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:19:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id t64so5732256qkh.1;
        Fri, 31 May 2019 01:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2i9o+QCi5Un3I73MDLbCaDaVzjOTNEEi6IBhCC3kICg=;
        b=ayT3E93hItr1xWKRIDqxw0V3LM39utGKjDzRAcMS92nf4XUdAc/McQpntDTb53viyX
         lEt+qP+8rfhbGVRnNPFkIXliCHvWhmy5cPG7buqBbDh2wUhkjjSwr+FcUvQv/KETjqZ1
         5zDIA65jQEJ1wSWX5QyUuugnQ3Q3KD5ME/jkoavykL8hqm9zK1feGo1R4ZLlhRwRr55W
         rXKkc2WFZx/kdYkGdI/gx9VHYsXypwUffAKsyrFicickwIblOGMMuSieixh1qMH2d09R
         aFCv0Zz/m5/SdQAD7JUH6wcXAKQSXrNqPua2hWx6tQsVujO6zuqJKQvafYUkEl0G1NxP
         cRew==
X-Gm-Message-State: APjAAAVyHXmM++UgH0UqYonzfZBLGsbFiL+V/AmUdOH11Tm70ve8LZ+m
        ixMCWaN30QZMBWJ98/ImDJC6gOa/Eko+xDnt2Ls=
X-Google-Smtp-Source: APXvYqxnEiYB/dBem+6mgKf6bXFBj1bjFxkqSMt48GYBuC9zHPyT0mGNU8kl57dtAqEwpvwiRaTB+tPorSF0idY/h3M=
X-Received: by 2002:a05:620a:1085:: with SMTP id g5mr7435825qkk.182.1559290796933;
 Fri, 31 May 2019 01:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-3-vincenzo.frascino@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 May 2019 10:19:41 +0200
Message-ID: <CAK8P3a3Sr+MNbGQiMYt3RrE6SaYFPO-rXNoNvtOC7=qKE1kuYQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/19] kernel: Define gettimeofday vdso common code
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +
> +static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
> +{

Rather than marking every single function in here as "notrace",I think it
would be more robust to remove the '-pg' flag in the CFLAGS used for
compiling the vdso files.

       Arnd
