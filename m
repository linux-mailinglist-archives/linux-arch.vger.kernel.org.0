Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C33C277974
	for <lists+linux-arch@lfdr.de>; Thu, 24 Sep 2020 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgIXThA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Sep 2020 15:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728780AbgIXThA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 24 Sep 2020 15:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600976218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=twNrygaxLsVZPNKYCHY3ZfHX7UvhS+LdDIfmkCz5FTg=;
        b=Kr4u0+wKDT4eE4Ovfk8dVq+zwEnG3+m9nBXV98aP7EduhHCHW16A+CAkoAsez2npbw8dyM
        F42oliu8ePZ+iErn6O4Kku3QUN9ZIpqaI29BaqqCM/MwyQAJ1jE7qUu8VTcTnyor0Tjv1G
        AGafI+2TkSoImau4U/fywK786XFkk6M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-VTV_BFyLNMSQqr7ubQBYsw-1; Thu, 24 Sep 2020 15:36:56 -0400
X-MC-Unique: VTV_BFyLNMSQqr7ubQBYsw-1
Received: by mail-wm1-f70.google.com with SMTP id u5so147739wme.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Sep 2020 12:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=twNrygaxLsVZPNKYCHY3ZfHX7UvhS+LdDIfmkCz5FTg=;
        b=e9fB7Tvyy6nKjsYeR/6jIqZ3/VOq7QebRJLl+LCV+feWcjYMCU4R9EL/QHs9d5m0+i
         XETrM8Z/I9TCmKGKokS7XrVy/XVno1ZLKoAcqpP4vnQwoW3mjEeDU4eA5yETpZrHhlQU
         oKNCAuDqSHaX36UFZmI5NL0ZJU9ySzvjJCCrkToug5NU3JbnCfPR5J45ZreRzHvjFHB8
         mvogBAFI/2RLs120dQMnMBg4MpyxyLC5PgxyEI/jFGRFPir5p4LLld5tLE7jYtv1lsvq
         9jF2lKmrwzuywWaKPB+I/XswJE+3Tb4pnxV8ot/fwqaLmpTSSjf9lut9cnpAod68gUcC
         xGlQ==
X-Gm-Message-State: AOAM530ErOcokgMuPHe46cZbYG+C7x6c0xFLmcRrmxl/1zLUKLh5eGNA
        idRlbX/qwxRJ8W18CmQd7XX7cx6utZxeopxUEDxAP0cfQsi0ARKlMtpY+zmNrmtSxD01cjLABEn
        GDWyzstWYXh/opQ8hQTipqA==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr491636wrp.91.1600976215160;
        Thu, 24 Sep 2020 12:36:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynpHjsvPmbyspQelrDSoXiAKotSicrrWAZZ3D0g/KyVrY5rzQz/w0XAUEKgRr9DXJGglK1Gg==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr491615wrp.91.1600976214950;
        Thu, 24 Sep 2020 12:36:54 -0700 (PDT)
Received: from x1.bristot.me (host-87-17-196-109.retail.telecomitalia.it. [87.17.196.109])
        by smtp.gmail.com with ESMTPSA id h204sm302746wmf.35.2020.09.24.12.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:36:54 -0700 (PDT)
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
To:     peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
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
References: <87mu1lc5mp.fsf@nanos.tec.linutronix.de>
 <87k0wode9a.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
 <87eemwcpnq.fsf@nanos.tec.linutronix.de>
 <CAHk-=wgF-upZVpqJWK=TK7MS9H-Rp1ZxGfOG+dDW=JThtxAzVQ@mail.gmail.com>
 <87a6xjd1dw.fsf@nanos.tec.linutronix.de>
 <CAHk-=wjhxzx3KHHOMvdDj3Aw-_Mk5eRiNTUBB=tFf=vTkw1FeA@mail.gmail.com>
 <87sgbbaq0y.fsf@nanos.tec.linutronix.de>
 <20200923084032.GU1362448@hirez.programming.kicks-ass.net>
 <20200923115251.7cc63a7e@oasis.local.home>
 <20200924082717.GA1362448@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <7541acd1-65a0-0d55-4028-71cab544e90d@redhat.com>
Date:   Thu, 24 Sep 2020 21:36:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924082717.GA1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 9/24/20 10:27 AM, peterz@infradead.org wrote:
> So my current todo list is:
> 
>  - Change RT PULL
>  - Change DL PULL
>  - Add migrate_disable() tracer; exactly like preempt/irqoff, except
>    measuring task-runtime instead of cpu-time.
>  - Add a mode that measures actual interference.
>  - Add a traceevent to detect preemption in migrate_disable().
> 
> 
> And then I suppose I should twist Daniel's arm to update his model to
> include these scenarios and numbers.

Challenge accepted :-)

-- Daniel

