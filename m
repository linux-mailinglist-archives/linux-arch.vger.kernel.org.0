Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D55A14F6D22
	for <lists+linux-arch@lfdr.de>; Wed,  6 Apr 2022 23:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbiDFVoG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Apr 2022 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbiDFVnh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2022 17:43:37 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021BCF8EE4
        for <linux-arch@vger.kernel.org>; Wed,  6 Apr 2022 14:21:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso2598652ots.3
        for <linux-arch@vger.kernel.org>; Wed, 06 Apr 2022 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HfFrcmd70k7cFbm2ZXnWFiX/H5FhSCRXyrLZ2pjFPSI=;
        b=JWAdKKIGlR2GXRY2EyBHJpOHb12AGoA/GSAiazO0z3sUuJl2pbLq3y8f2LLZRiK7ag
         jF0pPAE80m/StQPAn0HI9Jocd1N932K40FWD3K+6jyCPxSDW85yi+b5RM+j3udvxF4+j
         4zvhIFli6DskhDlP9Zev4QI97hRqVRtIMcyyKrm7nX3owwnxPNDHJhwIikd2t2FloXmA
         Wk/pQwPT1sVLvBHFuFUW6X+vOB/f3di+0I5KpQAE5mktFyy59esdv+bNVlWExchHjewr
         ahjX/NWsjkK4v6+AkxwjmUhoWZbdfC6ilBaig9EYYETbKicXqqZULA+yUUodPHV8EKDI
         QR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HfFrcmd70k7cFbm2ZXnWFiX/H5FhSCRXyrLZ2pjFPSI=;
        b=mJhMx7pCuQ8CkQecvdtAW6KnTn0TjqZ5OO/FE7WHIGKQshUrvxbhWmDEnwjZ7hp3aH
         MGWLR7W/68qNYSaJvm+EtiPL1mctZhjT0pKczIKf2nN7O87eTai0WxsmZDrbEnCoVAQY
         Q9/lLy2heLyyj9sP3G3Psq0bscX6jYWZ7tBqnKTUnYQr56kUyd60j78f1BFrtGDEcZTi
         /k83Ff4VVfrFDIpzKytUjBcS8HdC2vvPf0Ei1NpMU9vUmAGYxoBOUYoi9aNBdRoc3AMC
         xCdkZU6hbtBmTT2qS9Tc4Q8ub7jwV3t7hxQ+EGZgL1mAmY+ia822pnTf414HTtVCCYoK
         Dd+g==
X-Gm-Message-State: AOAM533b+RB2k1myDow8PXyU1PAkq7CxqKtqGGhCKgkr7ILWAovp4MSa
        cSf+OL+eDPYA2VJCvdFEarRIQg==
X-Google-Smtp-Source: ABdhPJxZn7W+k8uRxWVFozQX95YWH7+EoUvtnn2OqSRwx2HUCEvYG912nG22JE+OWDU4RAdahCRb6g==
X-Received: by 2002:a9d:4d12:0:b0:5c9:4997:452c with SMTP id n18-20020a9d4d12000000b005c94997452cmr3741105otf.127.1649280109270;
        Wed, 06 Apr 2022 14:21:49 -0700 (PDT)
Received: from [192.168.86.186] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id e12-20020a4aa60c000000b00324bb45d7ecsm6352052oom.48.2022.04.06.14.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 14:21:48 -0700 (PDT)
Message-ID: <c3e7ee64-68fc-ed53-4a90-9f9296583d7c@landley.net>
Date:   Wed, 6 Apr 2022 16:25:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rich Felker <dalias@libc.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/4/22 08:22, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Mon, Apr 4, 2022 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Sun, Apr 3, 2022 at 2:43 PM Christoph Hellwig <hch@infradead.org> wrote:
>> > On Tue, Mar 08, 2022 at 09:19:16AM +0100, Arnd Bergmann wrote:
>> > > If there are no other objections, I'll just queue this up for 5.18 in
>> > > the asm-generic
>> > > tree along with the nds32 removal.
>> >
>> > So it is the last day of te merge window and arch/h8300 is till there.
>> > And checking nw the removal has also not made it to linux-next.  Looks
>> > like it is so stale that even the removal gets ignored :(
>>
>> I was really hoping that someone else would at least comment.
> 
> Doh, I hadn't seen this patch before ;-)
> Nevertheless, I do not have access to H8/300 hardware.

The 8300 never got qemu support but I had lunch with the maintainer in Tokyo a
few years back and he showed me how to use gdb to simulate it, which included
booting Linux under the gdb simulation (built-in initramfs talking to serial
console). Here's somebody else using gdb simulation for h8/300:

https://www4.cs.fau.de/~felser/RCXSimulator/

I'm interested in H8300 because it's a tiny architecture (under 6k lines total,
in 93 files) and thus a good way to see what a minimal Linux port looks like. If
somebody would like to suggest a different one for that...

>> 3. arch/sh j2 support was added in 2016 and doesn't see a lot of
>> changes, but I think
>>     Rich still cares about it and wants to add J32 support (with MMU)
>> in the future
> 
> Yep, when the SH4 patents will have expired.

They've had a working J32 on FPGA for a while now, the problem is porting Linux
to it. The MMU design they went with wasn't compatible with sh3/sh4. (Userspace
is, kernel side needs some tweaking.) And they don't want to finalize the design
until they have proper test loads running on it, and then they went off to do
VPN hardware and such during the pandemic...

> I believe that's planned for 2016 (Islamic calendar? ;-)

The website's kind of archived and needs to be completely redone. (It moved
hosts and I lost access to update it for a while, and I got sucked into other
projects since. The mailing list server is also mothballed. Ask Jeff, I brought
it up every weekly call for 6 months...)

Jeff's team is working on making a J2 asic this year (through sky130), and
everything else is queued up after that. They've been grabbing various I/O
subsystems (like the GPS correlators and crypto engine and such) and doing work
on them to make go/no-go decisions for the asic inclusion. (Lots of activity
goes by on the Signal channel, but I can't even get cut and paste to work in
that thing's Android app, and I don't really have the domain expertise to help
out with that part.)

> BTW, the unresponsiveness of the SH maintainers is also annoying.
> Patches are sent to the list (sometimes multiple people are solving
> the same recurring issue), but ignored.

I mailed four or five turtle boards out to people last year, in hopes of getting
wider testing, but everybody I sent one to seems to have vanished. (The pandemic
chip shortage kinda derailed plans to productize that...)

I tested 5.17 on J2 FPGA when it came out, and it booted with two local patches:

1) Commit 790eb67374 needs to be reverted or the j2 boot just hangs before
producing any console output. Dunno why, it seems COMPLETELY unrelated, and yet.
(Wild guess: disturbs the alignment of some important piece of data? Rich knows
and it's in queue.)

2) This patch from Rich stops the j2 boot messages from being a thousand lines
of IRQ warnings, but he called it a hack when he sent it to me and I have no
clue what a "proper" fix would look like (or why that isn't)?

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5f47d8ee4ae3..730252cb7b08 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int rc;

 	pr_info("Initializing J-Core AIC\n");

@@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";

+	rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
+			     of_node_to_nid(node));
+	if (rc < 0)
+		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
+			min_irq);
 	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
 				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);

I'm spinning too many plates to reliably reply to stuff, but I try to check in
as often as I can, and at LEAST regression test each new release.

Rob
