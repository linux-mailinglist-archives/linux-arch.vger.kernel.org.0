Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE77C52DA
	for <lists+linux-arch@lfdr.de>; Wed, 11 Oct 2023 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjJKMGP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Oct 2023 08:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjJKMGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Oct 2023 08:06:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30317A4;
        Wed, 11 Oct 2023 05:06:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697025969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8PMcuYySmTK2GLGzDl7ickSIL5xZv3CLwffGGkD0iM=;
        b=YIjUXdrvRneuXFgc7gq7Rn4OY3r/Caz1QfO/PDv0g1CxSKzy/JObsngmnPSIL5InPiL5wb
        oZfTjPtiVApWl+yNCYR6qGxu1NhdHl264HE+q4etwtvlceDSzsK55ijK/8fKVymicPDUvr
        PeBukGq/h+e/CxmKXPHaeCzDULMVqJcu2htT4ul+cAH4Vg8ld6Q2seATPdoZs5harGwQAE
        5FI+Y6qwsG1KaGYooyqLdICL2aI+YhN95XDjvvrZ6rZaSYk/Lv2DD4XZI0WWuQGEGEH5qi
        scUiHjHYSC+sTvAbciNbgwzE3/aMU0B/0FnDkIysRRdzAoOS+eh6+x9yZwl//A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697025969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e8PMcuYySmTK2GLGzDl7ickSIL5xZv3CLwffGGkD0iM=;
        b=ZOhzBjNvuXO9xiRWpa7Tdwnq7GT1Qfbi1aZb6EEWC5hCIlDewkaxbXXyrQaiE4o1EynyFn
        IL9wQ8L8YD+6czAw==
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
In-Reply-To: <ZSV6i4pnjQqvWuKp@shell.armlinux.org.uk>
References: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
 <ZSV6i4pnjQqvWuKp@shell.armlinux.org.uk>
Date:   Wed, 11 Oct 2023 14:06:08 +0200
Message-ID: <87o7h5l5xr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 10 2023 at 17:23, Russell King wrote:
> Okay, I give up. 15 days, still no real progress. I don't see any point
> in submitting any further patches for the kernel outside of those areas
> that I maintain. Clearly no one cares enough to bother (a) properly
> reviewing the patch, (b) applying the patch that Thomas thought
> "makes tons of sense."
>
> If patches that "makes tons of sense" just get ignored, then what does
> the future of the kernel hold? Crap, that's what, utter crap.
>
> As I said, it seems that the Linux kernel process is basically totally
> broken and rotten. If a six line patch that "makes tons of sense" can't
> be applied, then there's basically no hope what so ever.

Oh well. I usually try to keep track of such stuff, but this one fell
through the cracks.

Shit happens and we are all human, no?

Sorry for the wrong information about ia64. The removal did not happen
because someone stepped up as a possible maintainer.

Thanks,

        tglx
