Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D232053EC0B
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiFFQPe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 12:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbiFFQPd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 12:15:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8261158F3F
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 09:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D186B81AA9
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF23C3411E
        for <linux-arch@vger.kernel.org>; Mon,  6 Jun 2022 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532130;
        bh=BxKrqJOw52/VG909IN38P58ROEHwrI6/4lDipAlauuk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pUa71RQWxXz5U60ljQW+tPelmhccM7IrXnzg10oRqG1Xns+El3TVL52UBUOtpXkCI
         WAOuANVybvOGl0YctGUsQMslGemSDZS4G7hjlQ4mfi3mpabvcOTW6AylXDpfeEmkHt
         d7AAO8PkWhE56CEf6bpPh4VunNeZ2Ypr1H50bVgF3DUEte6WSk8eOMSsSjxko1fJkz
         eg1gfGOLpr2aVF38VPQiQoWYab8az+iw+P7v1QHKbc9A3a4vDqAlsFgQP8VeHsYgXT
         gVMLKMKEMeu7X9a2xqZK1UeZsipgaHWGQNUGoIO2BQpikhJQq7Fa/R930F4xE7mRQc
         N9Z1Vh0HkM/Hg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-f16a3e0529so19746585fac.2
        for <linux-arch@vger.kernel.org>; Mon, 06 Jun 2022 09:15:30 -0700 (PDT)
X-Gm-Message-State: AOAM5321Y8UPTKWAJnicTPoLzJ1Lrt0rBVjU/mEMeBV10VGoJIazpwwI
        nUvADywSfGrSYFuRQBoTses3iEwKG3nf4AsM1Vg=
X-Google-Smtp-Source: ABdhPJy5/9O63RxJH/msQSUphy66vahRu4JMGCbqyDjhwBZ+82tGKIl+tmB/mJ63xt7BbReeh/wtV+6A4mJPvR88TQI=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr32349470oap.228.1654532129378; Mon, 06
 Jun 2022 09:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220606152150.GA31568@willie-the-truck> <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
In-Reply-To: <Yp4eqzHKyV64/Nxc@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 6 Jun 2022 18:15:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGyO0Dtws-qy=3=D-QhR9jV83n3g7CjJwy99YAMejh5Fg@mail.gmail.com>
Message-ID: <CAMj1kXGyO0Dtws-qy=3=D-QhR9jV83n3g7CjJwy99YAMejh5Fg@mail.gmail.com>
Subject: Re: Cache maintenance for non-coherent DMA in arch_sync_dma_for_device()
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, vgupta@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, bcain@quicinc.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 6 Jun 2022 at 17:36, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Mon, Jun 06, 2022 at 04:21:50PM +0100, Will Deacon wrote:
> >   (1) What if the DMA transfer doesn't write to every byte in the buffer?
>
> The data that is in RAM gets pulled into the cache and is visible to
> the CPU - but if DMA doesn't write to every byte in the buffer, isn't
> that a DMA failure? Should a buffer that suffers DMA failure be passed
> to the user?
>
> >   (2) What if the buffer has a virtual alias in userspace (e.g. because
> >       the kernel has GUP'd the buffer?
>
> Then userspace needs to avoid writing to cachelines that overlap the
> buffer to avoid destroying the action of the DMA. It shouldn't be doing
> this anyway (what happens if userspace writes to the same location that
> is being DMA'd to... who wins?)
>
> However, you're right that invalidating in this case could expose data
> that userspace shouldn't see, and I'd suggest in this case that DMA
> buffers should be cleaned in this circumstance before they're exposed
> to userspace - so userspace only ever gets to see the data that was
> there at the point they're mapped, or is subsequently written to
> afterwards by DMA.
>
> I don't think there's anything to be worried about if the invalidation
> reveals stale data provided the stale data is not older than the data
> that was there on first mapping.
>

Given that cache invalidate without clean could potentially nullify
the effect of, e.g., a memzero_explicit() call, I think a clean is
definitely safer, but  OTOH, it is also more costly, and not strictly
necessary for correctness of the DMA operation itself.

So I agree with the suggested change, as long as it annotated
sufficiently clearly to make the above distinction.

> > Finally, on arm(64), the DMA mapping code tries to deal with buffers
> > that are not cacheline aligned by issuing clean-and-invalidate
> > operations for the overlapping portions at each end of the buffer. I
> > don't think this makes a tonne of sense, as inevitably one of the
> > writers (either the CPU or the DMA) is going to win and somebody is
> > going to run into silent data loss. Having the caller receive
> > DMA_MAPPING_ERROR in this case would probably be better.
>
> Sadly unavoidable - people really like passing unaligned buffers to the
> DMA API, sometimes those buffers contain information that needs to be
> preserved. I really wish it wasn't that way, because it would make life
> a lot better, but it's what we've had to deal with over the years with
> the likes of the SCSI subsystem (and e.g. it's sense buffer that was
> embedded non-cacheline aligned into other structures that had to be
> DMA'd to.)
>

As discussed in the thread related to Catalin's DMA granularity
series, this is something I think we should be addressing with bounce
buffering for inbound DMA. This would allow us to reduce the kmalloc
alignment as well.
