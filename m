Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2452170E41
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2020 03:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgB0CL4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 21:11:56 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36100 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728178AbgB0CL4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 21:11:56 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so1748713oic.3;
        Wed, 26 Feb 2020 18:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=he1uRJhimWdmXlH4KMyv7rZ5+f5TpR3yYZ1SBC2Q6M4=;
        b=ayBMgFwVIB4RZSA8nsIkYYFeLoUweLRhh+hyZe9/kfucORdETI97Ul78g9Qph+9BgM
         qu5gKbVjpy1/EPdroqPimYar+XVDAmoGWOnWfSArE33rqk2BF+cCY4OcIKbVq+0Bjtob
         7YqFBywBuOdSgMu9muQgiFrzTobGdJVHbMuxpxbKh0c0Cnqqli/Jquqtb6kBMIcDOxAO
         SiO97iJEgur8kaTx3rnGaHspC7w9UHps2kEIU809vgqlclK2xf62C8yXHgxZEU5fKc7R
         sT+s9Azj0270BniGkp8FXfaJrXGu6msYhhJIqYdY0fWF50HHlaFeBymqkSVyNYvx1CVh
         SZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=he1uRJhimWdmXlH4KMyv7rZ5+f5TpR3yYZ1SBC2Q6M4=;
        b=aNggrHctv4FhbdlsuzzhQZBUMZ4KYbsFKljkG9Pw5o1LWZFNG/8RfkAwu0b0H9t9SH
         8ipJ5n+3DDB++UvpcN2/EiVM+AnNNXJOWrRP+JpCBwv4LcZ9zEJmVVnj8Hz1EgrVworN
         fHD4yqZh/UrJflO4PF23gRRMtEFfUvvn8YvtkKx4mYJWAuh2wwPztTUONcg/XSEnb7wm
         pKQ4CZfn3yguoGmoLmRO1bBo3b5WCODolZ4qJPx7L2nUhPWtkOxT5T95PGfXbEKlYCwl
         sRnVCKtqbjeEENOGdHBv1m3RvY/yAVWc9fsSGAUSWpdT2UaJtrakGJAB5Wxl+nwzsmgR
         F5WA==
X-Gm-Message-State: APjAAAXi1hvHHoYdD5YhEZC7bAX1sslk6WWt0mjKxkEnzi0Nr3g/Nre5
        mTHi3mdeFj9GInZ6Gi8dsse4Hmd1FIFxtoJCouk=
X-Google-Smtp-Source: APXvYqxsFL01V4pX4VvSoQr/+nsogbthwMlTWrKppZURcCyyczEcgFcrencOXJXVDfPnbtJSq4aFT1/nkXVy7GOU+7w=
X-Received: by 2002:aca:43c1:: with SMTP id q184mr1584492oia.116.1582769513861;
 Wed, 26 Feb 2020 18:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20200205181935.3712-1-yu-cheng.yu@intel.com> <20200205181935.3712-6-yu-cheng.yu@intel.com>
 <d4dabb84-5636-2657-c45e-795f3f2dcbbc@intel.com> <CAMe9rOouOwNC873v=LOv5rJWcbe9Zvg+od8229J33V=ZfrB1rg@mail.gmail.com>
 <71791bbf-7ee3-fa70-b569-ae643151646e@intel.com>
In-Reply-To: <71791bbf-7ee3-fa70-b569-ae643151646e@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 26 Feb 2020 18:11:17 -0800
Message-ID: <CAMe9rOqhf4y+e6h8i7P8+70pwLSg8n=ise6LEqABNPKarECdeA@mail.gmail.com>
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

On Wed, Feb 26, 2020 at 5:16 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 2/26/20 5:02 PM, H.J. Lu wrote:
> >> That way everybody with old toolchains can still build the kernel (and
> >> run/test code with your config option on, btw...).
> > CET requires a complete new OS image from kernel, toolchain, run-time.
> > CET enabled kernel without the rest of updated OS won't give you CET
> > at all.
>
> If you require a new toolchain, nobody even builds your fancy feature.
> Probably including 0day and all of the lazy maintainers with crufty old
> distros.

GCC 8 or above is needed since vDSO must be compiled with
--fcf-protection=branch.

> The point isn't to actually run CET at all.  The point is to get as many
> people as possible testing as much of it as possible.  Testing includes
> compile testing, static analysis and bloat watching.  It also includes
> functional and performance testing when you've got the feature compiled
> in but unavailable at runtime.  Did this hurt anything even when I'm not
> using it?
>

I will leave the CET toolchain issue to Yu-cheng.

-- 
H.J.
