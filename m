Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAA7170D95
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 02:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgB0BDF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 20:03:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38518 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgB0BDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 20:03:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id z9so1355342oth.5;
        Wed, 26 Feb 2020 17:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S769i1368sIwWs8ipSKB7xon/VMLgcv4Y8AvbYRckQY=;
        b=ZnUxF4xX92wcGG5B4nG/wtaHOfP8fIZUtUVMNIKh6tIoj/xRhvkw9tfbSI+IEPixIU
         y9owEvyjnBITgIWPXPZx0w0oNk74m8f9xIrINCvemecgRgbZIlj9ds+etFjdpkrIntZg
         MQZ7iJBnj5Ukvuwov5/JIY3iAwQidcz/TR8DmKqo1WcWVwv6+NVgPRvgzdmxnskkHTiY
         Mbn5ddCwgNtx4tNr+QJT238BcbqehOGzDYC1AsvAN4cpRbg2/PFCs5ysQ9jCKmLp9NOe
         V5ZpcV8ObbcYN4ZKwirEocF0OXwiPueA0GenhqaSOhYDFCozGvNvdrtL/xRXg4WW6mgS
         18Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S769i1368sIwWs8ipSKB7xon/VMLgcv4Y8AvbYRckQY=;
        b=eJIesfgMRceLThehs8T+j1j0Vx9w4EKZRl25dSW9DcuUEW7/XPggKoKIgfHf3iMEau
         1tPLEhpKoDAqRdsbBUs68+mxQ//Cvc6ZnCYF66zZKr5GdWx7liUEveRcB6J/4pCt2/5x
         xqb+tJdU8vQOV9PD9k46wHo11sCGoFCYj/DPLtHcipE2EILo2n+UIfdHo3xza0FP8HQf
         1QLEepc5wm8feoec7N7IO1PQO/DQoAvOCczO7CS5iMUYIREL9K5kV5IRgWEjVhJcbRrv
         O2NGeC2on6fNwkCN57KTz4N9MFcHLkFAyfQIrmdyStiY6uM7lV7x+hcU0l3hJwpuZ9zN
         PFoQ==
X-Gm-Message-State: APjAAAU6bTgI/VF2+jEhPQEViSCu+c0LCUL/TSAj6gtY4joJswDO5idG
        uYB+Z1S6dAm/X2518vLofhvDCCVCtd3q9/5ZQ0c=
X-Google-Smtp-Source: APXvYqxdnQ1bCveubu+e0x1tG27vAUGWa7Yj7IkTOFO7Kz1hD4e+Z1F/Fris3J3KDyHngytIZLW60UvznGsx6PLfCkE=
X-Received: by 2002:a9d:21c5:: with SMTP id s63mr1283207otb.142.1582765384096;
 Wed, 26 Feb 2020 17:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20200205181935.3712-1-yu-cheng.yu@intel.com> <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
In-Reply-To: <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 26 Feb 2020 17:02:28 -0800
Message-ID: <CAMe9rOouOwNC873v=LOv5rJWcbe9Zvg+od8229J33V=ZfrB1rg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 10:05 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> > +# Check assembler Shadow Stack suppot
>
>                                   ^ support
>
> > +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> > +  ifeq ($(call as-instr, saveprevssp, y),)
> > +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
> > +  endif
> > +endif
>
> Is this *just* looking for instruction support in the assembler?
>
> We usually just .byte them, like this for pkeys:
>
>         asm volatile(".byte 0x0f,0x01,0xee\n\t"
>                      : "=a" (pkru), "=d" (edx)
>                      : "c" (ecx));
>
> That way everybody with old toolchains can still build the kernel (and
> run/test code with your config option on, btw...).

CET requires a complete new OS image from kernel, toolchain, run-time.
CET enabled kernel without the rest of updated OS won't give you CET
at all.

-- 
H.J.
