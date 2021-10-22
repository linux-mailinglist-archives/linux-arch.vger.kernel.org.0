Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D99F4379C2
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhJVPWJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhJVPWJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:22:09 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1404C061764;
        Fri, 22 Oct 2021 08:19:51 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id i189so5884857ioa.1;
        Fri, 22 Oct 2021 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=edUysRKGfaZOTuM3uYR99rq4ae03o5LqY877IUKK/u4=;
        b=OV9+U6++bii1LgELrCjulmFIWampisMJ86zIok+nNJ7XJXUfILrGKlaXTqwBgRyUTz
         +sxGL4FGIVlFzBSamuiZADhcODjGZ36A8Pwjub6rVMGCeZi0RufSJ2xoa2XpQcJvzEeY
         JpoKvpjMTyHfmCbel/hNNKU5kbM5rEWpLOr7OGYIX3EZccKxgFzm7YR7erBYUMBP/a+j
         FQqxIRh28Zf/ixoUZT/Ivj59Qp2DqfSkIsWUSUmYC157rAVTDfLvk0STBFuiesHFpGgY
         KEKtTn2LZ9o8Cyjvbyuvi7hnIDlVeo1SXRfIp1GbaO9gv81h6dU0Kyu3UVdSZd3u0ja3
         npgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=edUysRKGfaZOTuM3uYR99rq4ae03o5LqY877IUKK/u4=;
        b=7qWvZM8pn62Rtv/58TqKViJjEGTOwjFNMjt2Qo06U1vbKldgfzSzatIRe7lko1vKZO
         6oWiObvsvcpib4f3x3iLLAG0Urjk79MH83tM6OAOEN6XF+/EMiOFVMQ9ADzpcMLENfZ4
         9IPV/c0/rgYBry8b3YUgXc1tI0X3+ynpMdJut7i7uOLVTjTNetCGht0cBstJk5cUSrwn
         UEBI1VylbBa+VOH9OR3oduYOrWqQgd255VfBaWPApTnqctmzna0LuX+jOy4hAXbAJ/DW
         0fXs0GLlyOidgM+aDC12FsqHWg67eIYdIMcrWFzKPlXHPTyHNglprqlDrhwLz0mc+Ji5
         MhoQ==
X-Gm-Message-State: AOAM533Ogas4xcDCGozlPUhaWBaBZtYQy+mv8ORGCIpF5pNhG7PLiL8Z
        zDt0al+HvL0eKAulz9+DIRk=
X-Google-Smtp-Source: ABdhPJxSDypiYJInzx4XwEZ8NcgEsqzqv+UUXkXQDiglcxs6zTx7KjuYegOh3MB/AopBCcoAA7HNZA==
X-Received: by 2002:a6b:ea11:: with SMTP id m17mr131844ioc.139.1634915991219;
        Fri, 22 Oct 2021 08:19:51 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x5sm4208612ioh.23.2021.10.22.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:19:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id C689827C005A;
        Fri, 22 Oct 2021 11:19:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 22 Oct 2021 11:19:47 -0400
X-ME-Sender: <xms:ktZyYbo-0xCgktB-G4PseuSbdB9Jt05Z02dF1bg-T14I5YJtc5dPtg>
    <xme:ktZyYVrtulvtNFpxyCy8dPYInOg33GzwqWwpawhv3APnYQ0kJ7fXGAwrA79GATjFO
    T-NQQJrElfJ2mLcOQ>
X-ME-Received: <xmr:ktZyYYNDLtLpl1TuebIf7Qy1jUYxqTn5sUBFe2uZsnZrcscd-oBaDRqJGhaIzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvkedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ktZyYe7cASrg4U0TiKXQ2rge3q3yecqGfi3TysEBZCfj5c-7Wqs94g>
    <xmx:ktZyYa6p9Nrgrcu8gycciaBtDEY3NH6MbMazqxPWS4wM29oD6xuqmQ>
    <xmx:ktZyYWgv7duMbyE0XSyCRF3iOV3Mkymt1G8cC7xw8_rPhUuV5kJVwA>
    <xmx:k9ZyYawABAAee3hR_-tz10XhH4UNTnbP7VaExlTqmEEn6SKe38sCaK1AzFo>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Oct 2021 11:19:45 -0400 (EDT)
Date:   Fri, 22 Oct 2021 23:19:17 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>,
        Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] locking: Generic ticket lock
Message-ID: <YXLWdVGl4NP2HBCO@boqun-archlinux>
References: <YXFli3mzMishRpEq@hirez.programming.kicks-ass.net>
 <4de96b16-a146-f82a-a7f2-706dba4f901f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4de96b16-a146-f82a-a7f2-706dba4f901f@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 21, 2021 at 02:04:55PM -0400, Waiman Long wrote:
[...]
> > +static __always_inline int ticket_is_contended(arch_spinlock_t *lock)
> > +{
> > +	u32 val = atomic_read(lock);
> > +
> > +	return (__ticket(val) - __owner(val)) > 1;
> Nit: The left side is unsigned, but the right is signed. I think you are
> relying on the implicit signed to unsigned conversion. It may be a bit
> clearer if you use 1U instead.
> > +}
> > +
> > +static __always_inline int ticket_is_locked(arch_spinlock_t *lock)
> > +{
> > +	return __ticket_is_locked(atomic_read(lock));
> > +}
> > +
> > +static __always_inline int ticket_value_unlocked(arch_spinlock_t lock)
> > +{
> > +	return !__ticket_is_locked(lock.counter);
> > +}
> > +
> > +#undef __owner
> > +#undef __ticket
> > +#undef ONE_TICKET
> > +
> > +#define arch_spin_lock(l)		ticket_lock(l)
> > +#define arch_spin_trylock(l)		ticket_trylock(l)
> > +#define arch_spin_unlock(l)		ticket_unlock(l)
> > +#define arch_spin_is_locked(l)		ticket_is_locked(l)
> > +#define arch_spin_is_contended(l)	ticket_is_contended(l)
> > +#define arch_spin_value_unlocked(l)	ticket_value_unlocked(l)
> > +
> > +#endif /* __ASM_GENERIC_TICKET_LOCK_H */
> 
> Other than the nit above, the patch looks good to me.
> 
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Same here ;-)

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun
