Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499B427166C
	for <lists+linux-arch@lfdr.de>; Sun, 20 Sep 2020 19:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgITRsS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Sep 2020 13:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgITRsS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Sep 2020 13:48:18 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC20C061755
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2020 10:48:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q13so14611630ejo.9
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2020 10:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ejz/GOVvBNgiciatH4EjBRwlfy2MnL1tDSObr2BrKeg=;
        b=cBDZkiv4uiqeUChUbmqRPD8tkvllq4angLGjbI6fcWbyt0pYNQ1SGMQdEdmcewXaXT
         IE5S9J/GFuNXr/rpY1dC/0Yf7uyzIPTs0u+8f3gLaQ3BI+ak5trluGhkQvuTa+ZLZ3HS
         UcueGtftJ4Q3p1fqvR6MgwdAfAMUTTFhAr56U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ejz/GOVvBNgiciatH4EjBRwlfy2MnL1tDSObr2BrKeg=;
        b=Oa02VCDBetnYaDqCy5FDV/hZQW5Qpe8F0uSs1rOykqC9qm35lqh6x7GmftnJ8O4wdy
         TKjPTCeQDfNeC32y1xPQxlNI7zLBYDaEq6MKINNrcJ+qBK8DPtGwam7LHrbAi2m37OrJ
         DJoaDtI74QzKwrYVaFYEIdx2pcBaKKRCQdurpCZk/jC9w5w1x+Ofll33ramyGR/8w7Lh
         l8sK64k/yojqb8/T7SJVq1W8crz3OKNFDpKSFLfjRtIsN0PO5LSkGO38eSQukLyqwp9W
         BZAycQ9i/+/sOv5Uwq1b/BP53/Dyrhxz4pr5BAiqRiJdXWsPlJ8ZlvASBk6rGBn9Lo4j
         8GtQ==
X-Gm-Message-State: AOAM5318RJuT9/iiTPJZWYtpmZX8c8yLpkvMhUtctdGXJdxtbO1hFZ/4
        1yc6cfgCzBrg1LzSF44D5uzw2A/bfUs8gQ==
X-Google-Smtp-Source: ABdhPJyygLnJKi7n1lFSraCNZKa/1g6tk4VXbGTq8avPq+pTLWQBPMUXbYuxI2qrnQq54+y014K7yQ==
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr45617248ejb.149.1600624096699;
        Sun, 20 Sep 2020 10:48:16 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id p20sm6998099eja.18.2020.09.20.10.48.16
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 10:48:16 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id i1so10734894edv.2
        for <linux-arch@vger.kernel.org>; Sun, 20 Sep 2020 10:48:16 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr13708479ljh.70.1600623791519;
 Sun, 20 Sep 2020 10:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
 <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com> <87eemwcpnq.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eemwcpnq.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 10:42:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
Message-ID: <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 20, 2020 at 10:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I think the more obvious solution is to split the whole exercise:
>
>   schedule()
>      prepare_switch()
>         unmap()
>
>     switch_to()
>
>     finish_switch()
>         map()

Yeah, that looks much easier to explain. Ack.

               Linus
