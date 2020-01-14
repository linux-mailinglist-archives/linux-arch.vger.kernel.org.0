Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE23E13B4B3
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 22:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgANVtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 16:49:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34257 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVtX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jan 2020 16:49:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so11051133lfc.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vctch71naqEGLrugWbqoCH3ToLlQlQB3yrVoOl+SPvs=;
        b=KZsiFFqPOkrryEiWdCUg5hoXCgV2OLEIU5JBuDM284Mh6WRn/AjOiD1HtsNJRqviVx
         9kKzxAmtgZreU18bWEW2HXaM6Ao4fNRodAVWs6R4i29I6H6YakNGcUy2JKOXR0tVereO
         66FAx40w7vVtGWNG+UhiUq933mXri6+ihEilQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vctch71naqEGLrugWbqoCH3ToLlQlQB3yrVoOl+SPvs=;
        b=jw64mtTcyIHl7+rrU23eG00VRwe+d9SfJiJW7offEJ3O6uOdPoXPPdDMfBHewPVmGU
         jjG4orS6Lcwj2WesMZ1l9eQBDQF0ofNP4xF3LdSSnFQpPfQyohmNSH0g9xwDlnwCuyQn
         GpgVHCIzFJoedfrMKPT0v+QPtLx6MIHiXlpdkP3QsVgdIi1szAkoosO0649OFxun5ko0
         tEOiMkYpFzeckmuJ3TDLjevXYuqJyPTTJ+Y7FMpT2Oyz3H0we33gDYm6e4gX1hywF183
         tDodJt1UcRKq0LT3lqrWr9fuBW4WITA6MDR/CzhgCkjOpjeSM6Wma5QizfNCRByE7g7U
         2Wzg==
X-Gm-Message-State: APjAAAWb2X/pNelMXnAKnDmy6mEo59RGMXPArG5hR4dYFYNg4hkLjR1p
        T7mBd4YUPgZn8pM7UPyZV9PKdVBKkUI=
X-Google-Smtp-Source: APXvYqwVqsAd0F8x8QhEj5/ZpEIpE8+RMKF3sXRPSh2+cYykpnYTR/ipUg9zXokyZpHNl1z9zZilcg==
X-Received: by 2002:a19:7502:: with SMTP id y2mr3154624lfe.55.1579038560672;
        Tue, 14 Jan 2020 13:49:20 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s4sm8248225ljd.94.2020.01.14.13.49.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:49:19 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l18so11051046lfc.1
        for <linux-arch@vger.kernel.org>; Tue, 14 Jan 2020 13:49:19 -0800 (PST)
X-Received: by 2002:a19:48c5:: with SMTP id v188mr3185145lfa.100.1579038558938;
 Tue, 14 Jan 2020 13:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-5-vgupta@synopsys.com>
 <CAK8P3a2GUqmcA_q33=20OrK1+cU4f3mCrgci_bO3ho4B5PRODg@mail.gmail.com> <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
In-Reply-To: <3734021d-1756-3a09-6595-14ca58c64bf9@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jan 2020 13:49:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
Message-ID: <CAHk-=wjX-c9YpPhbQ073UPnTvELNQCN49vqK1yY7JGuHSn5-ew@mail.gmail.com>
Subject: Re: [RFC 4/4] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 14, 2020 at 1:37 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> On 1/14/20 12:42 PM, Arnd Bergmann wrote:
> >
> > What's wrong with the generic version on little-endian? Any
> > chance you can find a way to make it work as well for you as
> > this copy?
>
> find_zero() by default doesn't use pop count instructions.

Don't you think the generic find_zero() is likely just as fast as the
pop count instruction? On 32-bit, I think it's like a shift and a mask
and a couple of additions.

The 64-bit case has a multiply that is likely expensive unless you
have a good multiplication unit (but what 64-bit architecture
doesn't?), but the generic 32-bit LE code should already be pretty
close to optimal, and it might not be worth it to worry about it.

(The big-endian case is very different, and architectures really can
do much better. But LE allows for bit tricks using the carry chain)

             Linus
