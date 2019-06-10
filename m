Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDE333BFD0
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2019 01:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390521AbfFJXVa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jun 2019 19:21:30 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45538 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390500AbfFJXV3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jun 2019 19:21:29 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so7523917oib.12;
        Mon, 10 Jun 2019 16:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZaE9J9S5+4tokzmlUvtvROgLbYm6CbLOjAt2bzs6+ko=;
        b=XQq46nLUk1w0so/Oo7f4Obzwh/o1q87LWsXwXUYuy18n6wtiBRK2ftGBmxm0auLw3C
         2yYiVAkdcv6+/IVh7X6QrM0UoSGQyitdM1QDCifV12RE9hSZfSNyJQrEQfP2SMg4enWZ
         9LDHi3uZQaqUAoUSQ0q3cxiPm+2hhlnnol/CR7tdZmeUtkO7SxOTVDda6RZ80MibiTWD
         lnM9MHvgLA0qymLGPVIp3eSUnd1KmStoOEVcrMnZzpgJDMBk/K3h1H5rHaQxobmMSEsZ
         7xq5E1OCNHUfIZU9DJSeMtA0aMcMep/1d7coTjVhV//p15VgmmRXrPIBHbhiOyr1iHtd
         A5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZaE9J9S5+4tokzmlUvtvROgLbYm6CbLOjAt2bzs6+ko=;
        b=luuLNQQfplYtfLVJ44OyRDTbHQm4hNDi/FzsHr9LXKoIF9pnXXjIAqVgqxPfySUvMA
         0Bf/4bgcxBFmzcKBOsI+57msF4o4SpbLQAk3zCIvY4Rbf0zaZ+wqrOJcivFFgcgFUg40
         yZQwwxV2Ml/79TNGR11xnzdZ/VMyuWqV5B4NRC0FL1eGWmPlICp5bLn1U2PIW+OfWs1L
         f3yOa6mJc6c/aGhfpVpNX3by1wzHOPw92R1habqATxfopdsUtjGynVJRLbTMGELrm5xH
         w8nXC1Hu5a56FJTryL0XDmFD+rhonVJltjJzYmG9KWBPEzIGNFbc8EuEXautXYXX7wm6
         i85A==
X-Gm-Message-State: APjAAAWIt247kDgRRxUTz31YkXSUK5XnK/Jtk65KlFPO++agY00yH8BD
        2i/LK1vRobbWYomsxQV0WAP59zHQQFEnFceNlZ0=
X-Google-Smtp-Source: APXvYqzb5bNwl6WsntXoXRG9f925hb0b4zMvZ1roOsKlf05inct+tI9izH6k+IgRME05YsAxf20EyAgYGYpegeQTvhQ=
X-Received: by 2002:aca:c508:: with SMTP id v8mr13855096oif.104.1560208888753;
 Mon, 10 Jun 2019 16:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190606200926.4029-1-yu-cheng.yu@intel.com> <20190606200926.4029-4-yu-cheng.yu@intel.com>
 <20190607080832.GT3419@hirez.programming.kicks-ass.net> <aa8a92ef231d512b5c9855ef416db050b5ab59a6.camel@intel.com>
 <20190607174336.GM3436@hirez.programming.kicks-ass.net> <b3de4110-5366-fdc7-a960-71dea543a42f@intel.com>
 <34E0D316-552A-401C-ABAA-5584B5BC98C5@amacapital.net> <7e0b97bf1fbe6ff20653a8e4e147c6285cc5552d.camel@intel.com>
 <25281DB3-FCE4-40C2-BADB-B3B05C5F8DD3@amacapital.net> <e26f7d09376740a5f7e8360fac4805488b2c0a4f.camel@intel.com>
 <3f19582d-78b1-5849-ffd0-53e8ca747c0d@intel.com> <5aa98999b1343f34828414b74261201886ec4591.camel@intel.com>
 <0665416d-9999-b394-df17-f2a5e1408130@intel.com> <5c8727dde9653402eea97bfdd030c479d1e8dd99.camel@intel.com>
 <ac9a20a6-170a-694e-beeb-605a17195034@intel.com> <328275c9b43c06809c9937c83d25126a6e3efcbd.camel@intel.com>
 <92e56b28-0cd4-e3f4-867b-639d9b98b86c@intel.com> <1b961c71d30e31ecb22da2c5401b1a81cb802d86.camel@intel.com>
 <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com>
In-Reply-To: <ea5e333f-8cd6-8396-635f-a9dc580d5364@intel.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 10 Jun 2019 16:20:52 -0700
Message-ID: <CAMe9rOqLxNxE-gGX9ozX=emW9iQ+gOeUiS3ec5W4jmF6wk6cng@mail.gmail.com>
Subject: Re: [PATCH v7 03/14] x86/cet/ibt: Add IBT legacy code bitmap setup function
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 10, 2019 at 3:59 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> > We then create PR_MARK_CODE_AS_LEGACY.  The kernel will set the bitmap, but it
> > is going to be slow.
>
> Slow compared to what?  We're effectively adding one (quick) system call
> to a path that, today, has at *least* half a dozen syscalls and probably
> a bunch of page faults.  Heck, we can probably avoid the actual page
> fault to populate the bitmap if we're careful.  That alone would put a
> syscall on equal footing with any other approach.  If the bit setting
> crossed a page boundary it would probably win.
>
> > Perhaps we still let the app fill the bitmap?
>
> I think I'd want to see some performance data on it first.

Updating legacy bitmap in user space from kernel requires

long q;

get_user(q, ...);
q |= mask;
put_user(q, ...);

instead of

*p |= mask;

get_user + put_user was quite slow when we tried before.

-- 
H.J.
