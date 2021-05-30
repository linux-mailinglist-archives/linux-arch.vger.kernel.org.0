Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6700E394EA6
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 02:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhE3Ab7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 May 2021 20:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhE3Ab6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 May 2021 20:31:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CEBC06174A
        for <linux-arch@vger.kernel.org>; Sat, 29 May 2021 17:30:20 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id t21so3416016plo.2
        for <linux-arch@vger.kernel.org>; Sat, 29 May 2021 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Xq8rjDdajOrEnJH/gYsPZPip8sU4KPaYjYp9VZxKFxg=;
        b=Li711QZ4jfbmgsYIYc13IzJADdEzcf/jVUy5AIHJgsr00pEXHYXwBh5HE5xuHgQ9Iw
         OuF0OawaFzTp+DkAbEwoSZxEuLtKvFH6VYDWrvzvdp6Uc1L5x+x994srisje+kTR4Qmf
         ZExtumx+PUJg+rAkp6HwcVDgEyHlZzF9QKIolJ8rfLLazk3Yj8xfWPetx+6O+kTUkfvN
         UVxnkBQG52r++fcHdKP9Lma7hwtC41ipDo9Ll72XXjn+dIaEvQbv66QXaMqKeMvrMa3i
         eA976sfPV9IRtUaNQoRkp3jIev3kFelLcnuJk9khpW+A5oiHDsQFY1mJ9OZuX8A1spfz
         OFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Xq8rjDdajOrEnJH/gYsPZPip8sU4KPaYjYp9VZxKFxg=;
        b=TQADZHOJ98oR0Oznue4nQ98rOxPE+28KK1YgbkZKeZ2s8GWH5nyCbWob5RU1dEgNky
         pQXYhH1t+VrFO0NFgM0PjjkBIYu6zoxCbE4gOWFeH04fRW3oRuA+nNxuNa/nolYV+Dgf
         3kvJl0bD9eGkYMDLHfjYiNR5e10IvgGKg3b0lFh0OVGX+vIJrYXPDF9xTe+2FbCparts
         xhSw56i9J1wqrI0YaX6vwzkjBVJud/Jw5QvRjmjg+sPAnv7jX0NlWsbnljKh/bY/DgFs
         8TfPfn/v+GaFpk/tsF09s8TfK5Ehywa2DDxUkUIA6EeJboUWcfk2jDATNyTfxC9Q0e25
         oF6g==
X-Gm-Message-State: AOAM531Sp4WnkKwVITXFffIhKzmscCXMycFf5/iau8oMhjSS6VOj68x3
        Qzx6B72b2qqmbq5kdIKwyH1Xrw==
X-Google-Smtp-Source: ABdhPJxKeHz3bdKzW+qaaA5CNw7eizOlyQUSlrZom5qN9xyOtG7sUWzn4T85FVINWEK0dsYvqxAOZQ==
X-Received: by 2002:a17:90a:6589:: with SMTP id k9mr3348112pjj.14.1622334619298;
        Sat, 29 May 2021 17:30:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a9sm7182418pfo.69.2021.05.29.17.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 17:30:18 -0700 (PDT)
Date:   Sat, 29 May 2021 17:30:18 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 17:29:11 PDT (-0700)
Subject:     Re: [PATCH RFC 0/3] riscv: Add DMA_COHERENT support
In-Reply-To: <CAJF2gTTBAKTBY5AF9jd8tfT-33Y+McyFis_xk_aMvZZpLsvVxw@mail.gmail.com>
CC:     anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>,
        Anup Patel <Anup.Patel@wdc.com>, wefu@redhat.com,
        lazyparser@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-sunxi@lists.linux.dev, guoren@linux.alibaba.com,
        Paul Walmsley <paul.walmsley@sifive.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-a5f8374f-350b-4c13-86e8-c6aa5e697454@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 21 May 2021 17:36:08 PDT (-0700), guoren@kernel.org wrote:
> On Wed, May 19, 2021 at 3:15 PM Anup Patel <anup@brainfault.org> wrote:
>>
>> On Wed, May 19, 2021 at 12:24 PM Drew Fustini <drew@beagleboard.org> wrote:
>> >
>> > On Wed, May 19, 2021 at 08:06:17AM +0200, Christoph Hellwig wrote:
>> > > On Wed, May 19, 2021 at 02:05:00PM +0800, Guo Ren wrote:
>> > > > Since the existing RISC-V ISA cannot solve this problem, it is better
>> > > > to provide some configuration for the SOC vendor to customize.
>> > >
>> > > We've been talking about this problem for close to five years.  So no,
>> > > if you don't manage to get the feature into the ISA it can't be
>> > > supported.
>> >
>> > Isn't it a good goal for Linux to support the capabilities present in
>> > the SoC that a currently being fab'd?
>> >
>> > I believe the CMO group only started last year [1] so the RV64GC SoCs
>> > that are going into mass production this year would not have had the
>> > opporuntiy of utilizing any RISC-V ISA extension for handling cache
>> > management.
>>
>> The current Linux RISC-V policy is to only accept patches for frozen or
>> ratified ISA specs.
>> (Refer, Documentation/riscv/patch-acceptance.rst)
>>
>> This means even if emulate CMO instructions in OpenSBI, the Linux
>> patches won't be taken by Palmer because CMO specification is
>> still in draft stage.
> Before CMO specification release, could we use a sbi_ecall to solve
> the current problem? This is not against the specification, when CMO
> is ready we could let users choose to use the new CMO in Linux.
>
> From a tech view, CMO trap emulation is the same as sbi_ecall.
>
>>
>> Also, we all know how much time it takes for RISCV international
>> to freeze some spec. Judging by that we are looking at another
>> 3-4 years at minimum.

Sorry for being slow here, this thread got buried.

I've been trying to work with a handful of folks at the RISC-V 
foundation to try and get a subset of the various in-development 
specifications (some simple CMOs, something about non-caching in the 
page tables, and some way to prevent speculative accesse from generating 
coherence traffic that will break non-coherent systems).  I'm not sure 
we can get this together quickly, but I'd prefer to at least try before 
we jump to taking vendor-specificed behavior here.  It's obviously an 
up-hill battle to try and get specifications through the process and I'm 
certainly not going to promise it will work, but I'm hoping that the 
impending need to avoid forking the ISA will be sufficient to get people 
behind producing some specifications in a timely fashion.

I wasn't aware than this chip had non-coherent devices until I saw this 
thread, so we'd been mostly focused on the Beagle V chip.  That was in a 
sense an easier problem because the SiFive IP in it was never designed 
to have non-coherent devices so we'd have to make anything work via a 
series of slow workarounds, which would make emulating the eventually 
standardized behavior reasonable in terms of performance (ie, everything 
would be super slow so who really cares).

I don't think relying on some sort of SBI call for the CMOs whould be 
such a performance hit that it would prevent these systems from being 
viable, but assuming you have reasonable performance on your non-cached 
accesses then that's probably not going to be viable to trap and 
emulate.  At that point it really just becomes silly to pretend that 
we're still making things work by emulating the eventually ratified 
behavior, as anyone who actually tries to use this thing to do IO would 
need out of tree patches.  I'm not sure exactly what the plan is for the 
page table bits in the specification right now, but if you can give me a 
pointer to some documentation then I'm happy to try and push for 
something compatible.

If we can't make the process work at the foundation then I'd be strongly 
in favor of just biting the bullet and starting to take vendor-specific 
code that's been implemented in hardware and is necessarry to make 
things work acceptably.  That's obviously a sub-optimal solution as 
it'll lead to a bunch of ISA fragmentation, but at least we'll be able 
to keep the software stack together.

Can you tell us when these will be in the hands of users?  That's pretty 
important here, as I don't want to be blocking real users from having 
their hardware work.  IIRC there were some plans to distribute early 
boards, but it looks like the foundation got involved and I guess I lost 
the thread at that point.

Sorry this is all such a headache, but hopefully we can get things 
sorted out.

>>
>> Regards,
>> Anup
