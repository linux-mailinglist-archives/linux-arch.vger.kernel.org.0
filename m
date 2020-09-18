Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA72707C1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 23:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRVGj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 17:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRVGi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 17:06:38 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AEDC0613CE;
        Fri, 18 Sep 2020 14:06:38 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y74so8460856iof.12;
        Fri, 18 Sep 2020 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvHhXjI9PINmG+l6DCDjKQZbsTRKGGMkTBP5zN5aSFQ=;
        b=IWLwt/JbdMSRpT6Wv3WAyCBN9qFCREgWtJcF0R1RIzLVY0SISm4RFwHsdcXIdL5d4E
         Yy7/2s+LDlk/87c0Fp+tQVi0zmDpn6GNtT8zIFczwsT7f4zqRnFy453Wbrx2aO+2VbVj
         vdaq2zhFJLmSjCLU0mocGAmtZoaaUK6RKO8Qz0A7yeJUTDJbRPhXHIh5ZOcHlXUvXFk3
         LUOd/Bi9DKb0KWJIFqeinsKHmFCXFee6BbXLTqIXmNkioPBdjnv37wleZo/wrgkqn1NX
         72vkgJhAipRe1DB64E2Yesd7jEdncu2/Nm2GU5jxRqcToMVoB7Ia5jtjXQAZwflWHYOc
         Ckjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvHhXjI9PINmG+l6DCDjKQZbsTRKGGMkTBP5zN5aSFQ=;
        b=A/WFCEewpv/hVP+yj013d7fyobtZY8fzFKEx4Junlhi7DrYSak7z3b0OLVahYulrHB
         8NFC6b6mNd7Lg5G6mwHrfT+pLbyzV96qZKN//EwbDgSCAQjNhORLMHUNyS2FKZWIyxJk
         Fwmrq0DlLMkxwM4DgFZu9OX4Xph7r12OwbM5AZoOtEqeGG3XGY97Wjc5gjc+3+W0d22c
         MGUl/FltLIoTeJuPOhJrMiqcgdDDTopfSSKUMCyffb5xylQpPxRIkFHanGHhLRqjgDYn
         K+UNQWnsr1jsKXu+vqb9GW7A8a27SKRn9slONAWBTY9KActvTnBsEwoIXvZer2dGEzu3
         5Xrw==
X-Gm-Message-State: AOAM531ceTPCGYCq7GYxVopo4hkPHCdZ4yuRW3CTkWOJHw1eUkvzV73r
        W/vrN/MLASot8dzmTKH08JwEr2HMjIHIuIuMrXM=
X-Google-Smtp-Source: ABdhPJz3m6rfOxVGTE582qPYyesCg/UTfBm54/gjoz20D1+b0ua1bBFx46wx6IdHom/D2OhPgwwR2gJWI9CZGMjZWXc=
X-Received: by 2002:a5e:9e4c:: with SMTP id j12mr29230986ioq.37.1600463197971;
 Fri, 18 Sep 2020 14:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200918192312.25978-1-yu-cheng.yu@intel.com> <20200918192312.25978-9-yu-cheng.yu@intel.com>
 <f02b511d-1d48-6dea-d2e6-84d58e21e6cd@intel.com> <20200918210026.GC4304@duo.ucw.cz>
In-Reply-To: <20200918210026.GC4304@duo.ucw.cz>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 18 Sep 2020 14:06:02 -0700
Message-ID: <CAMe9rOrHCE51dKSz3fPXG-ORNim_Ok7rtwQxnudH9et4ecHBRA@mail.gmail.com>
Subject: Re: [PATCH v12 8/8] x86: Disallow vsyscall emulation when CET is enabled
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
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
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 2:00 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2020-09-18 12:32:57, Dave Hansen wrote:
> > On 9/18/20 12:23 PM, Yu-cheng Yu wrote:
> > > Emulation of the legacy vsyscall page is required by some programs
> > > built before 2013.  Newer programs after 2013 don't use it.
> > > Disable vsyscall emulation when Control-flow Enforcement (CET) is
> > > enabled to enhance security.
> >
> > How does this "enhance security"?
> >
> > What is the connection between vsyscall emulation and CET?
>
> Boom.
>
> We don't break compatibility by default, and you should not tell
> people to enable CET by default if you plan to do this.
>

Nothing will be broken.   CET enabled applications don't use/need
vsyscall emulation.

-- 
H.J.
