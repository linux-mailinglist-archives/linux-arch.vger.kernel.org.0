Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C7F34A0BA
	for <lists+linux-arch@lfdr.de>; Fri, 26 Mar 2021 05:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCZE7O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Mar 2021 00:59:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhCZE7H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Mar 2021 00:59:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36BF061A58
        for <linux-arch@vger.kernel.org>; Fri, 26 Mar 2021 04:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616734747;
        bh=dEk8ZXGgMpgPdB95Q+GWWYAMhYOliJnVarqq5EcDWEE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IWOsNvg58vOFUWT01buAMi6aVmFyR/F/67TxIWw7mhrCEHU78kIlVqzY6tYjplM4i
         u001B70a1lm78IUuN9PnYfMUjE34PpO/womuAFIBex5XJoXIxrWA0dAp9BNpYjuPVa
         P87cJxgbN0UABjkdn8rdbV2rgtuedbGUDvR1wnHcRAJtPe9bKsYUAkcSrIFOqEIeyY
         5ju4iR/7st+C2gZ1JUjHMOooHDqlkcqiNQVRmlfCvY8sre+cbjwrTlDU5agDbhsDl8
         vW07K1acZp7M1+SapQ2UJtpiA8j+i3U4uM0+Fclf7I8k3SP476BvU8FiNZODO0KTR2
         5rol1NAUy+tVg==
Received: by mail-ej1-f50.google.com with SMTP id kt15so6464384ejb.12
        for <linux-arch@vger.kernel.org>; Thu, 25 Mar 2021 21:59:07 -0700 (PDT)
X-Gm-Message-State: AOAM533rmDy4+o94wc/vf3w/rSpDUwQez/w8LUs0sihnOJgfKsgUiCGo
        gVnYCEp0HtxKy4vdCxANQYQrlziqeKepl6L7PLba1g==
X-Google-Smtp-Source: ABdhPJxCxNQfg/K4yaCHgGuHl7WepFi+j5GnPwB/0t0ZibWzhF4vOLkV71zCZw4RX4om+spYA/cLAkttnsbBPJK4pho=
X-Received: by 2002:a17:906:7e12:: with SMTP id e18mr13774986ejr.316.1616734745657;
 Thu, 25 Mar 2021 21:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210316065215.23768-1-chang.seok.bae@intel.com>
 <20210316065215.23768-6-chang.seok.bae@intel.com> <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
In-Reply-To: <CALCETrU_n+dP4GaUJRQoKcDSwaWL9Vc99Yy+N=QGVZ_tx_j3Zg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Mar 2021 21:58:54 -0700
X-Gmail-Original-Message-ID: <CALCETrVRz8kvqxk2Xg5=c_0YWcgofXnqPb3uZRcca9pphE0sHg@mail.gmail.com>
Message-ID: <CALCETrVRz8kvqxk2Xg5=c_0YWcgofXnqPb3uZRcca9pphE0sHg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] x86/signal: Detect and prevent an alternate signal
 stack overflow
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

I forgot to mention why I cc'd all you fine Xen folk:

On Thu, Mar 25, 2021 at 11:13 AM Andy Lutomirski <luto@kernel.org> wrote:

>
> >         } else if (IS_ENABLED(CONFIG_X86_32) &&
> >                    !onsigstack &&
> >                    regs->ss != __USER_DS &&

This bit here seems really dubious on Xen PV.  Honestly it seems
dubious everywhere, but especially on Xen PV.

--Andy
