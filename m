Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A87203FCB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgFVTBD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbgFVTBC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 15:01:02 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE9AC061573
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 12:01:01 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id l10so10278002vsr.10
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 12:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/64wMp0V9meZEtKgaDR20F6s2d5MyfXMXxe7Mp6vXQ=;
        b=qi30Gs6Ir6O5NjA3TAb1E3BACdlzOgEXtHLV5n1JbpUFDebrCiDjm/zA1dgR+IYLZi
         8vudaKN2OAMa9yC4zca10vWX/rSZ970qTXiW9hJPS6CJXYyloKRlO+DRTXQkiwNYFyvK
         FvK8vZppwmXSOgPfhuhcuptIIjSs/3t3bakmWiTelSzswozYjinqwQB9N6V0YheiHW7L
         QDZNZ32GL1iPl3XlhFH7wR31pv3ypoSKTUNjkVMW/jGPyodY62qio7MAfdbwe5pVpgKp
         eohJ9Sua6WEAKVMGmSByHGYIqgiTuorjRgs152VZFGPck8DdjTfIQ4LG8NP9hbeBH38U
         JcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/64wMp0V9meZEtKgaDR20F6s2d5MyfXMXxe7Mp6vXQ=;
        b=YL2VyMutsqoi7cgd1e6g+PBQnlflcJIrZtU+c9ik9WAW25Mf6L3dG3BTnCjplAG3gd
         PUsDxHjrv9eArqeYt6eSXXAHg0lsxvqizSyW7g+pVNYpBOz2W36/BBnodiM1as8xOJ8j
         7mPRQYAENIlZGwWqvh265aVTalByYmEpwFVPqiPuG35xZ0uATVJ0+xrh7phpl/LoevZu
         aqUFebByCTt40cZHjbHXaibg04SYdYqMdXDU6G9GmH5lF2q0wcbrjGphguFbQGokj5h3
         FIWvzQTJqu4I03m2A3ea57idoeMo2B1VSxKhAdJBwMaZL7kr3dFYCSn2js61zr3UfaXk
         aslQ==
X-Gm-Message-State: AOAM531gCMegRfasI4pj0Pgnk4leUCFdEquaUBEYrp8h5cxfcZ/pcY03
        Aj9B/sue5E5rN+1tpQJnxz4WA8dQ8WXG7EUh8HZzIQ==
X-Google-Smtp-Source: ABdhPJyW0K87CHnldkSTFwRFf5MB1bwDtF64tqTcDCXikcxkB3CPil9kvucAAh6TuvehsGzdKWLc/l8rYSOfG1vkAfk=
X-Received: by 2002:a67:79cf:: with SMTP id u198mr17465862vsc.240.1592852460665;
 Mon, 22 Jun 2020 12:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-21-catalin.marinas@arm.com> <ef61bbc6-76d6-531d-2156-b57efc070da4@arm.com>
 <CAMn1gO6KGbeSkuEJB_j+WG8DAjbn81OdfA6DQQ+FFA5F6dcsVQ@mail.gmail.com> <20200622171716.GC10226@gaia>
In-Reply-To: <20200622171716.GC10226@gaia>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 22 Jun 2020 12:00:48 -0700
Message-ID: <CAMn1gO5rhOG1W+nVe103v=smvARcFFp_Ct9XqH2Ca4BUMfpDdg@mail.gmail.com>
Subject: Re: [PATCH 20/22] arm64: mte: Allow user control of the excluded tags
 via prctl()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 22, 2020 at 10:17 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Hi Peter,
>
> Revisiting the gcr_excl vs gcr_incl decision, so reviving an old thread.
>
> On Mon, Dec 16, 2019 at 09:30:36AM -0800, Peter Collingbourne wrote:
> > On Mon, Dec 16, 2019 at 6:20 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
> > > In this patch, the default exclusion mask remains 0 (i.e. all tags can be generated).
> > > After some more discussions, Branislav and I think that it would be better to start
> > > with the reverse, i.e. all tags but 0 excluded (mask = 0xfe or 0xff).
> > >
> > > This should simplify the MTE setup in the early C runtime quite a bit. Indeed, if all
> > > tags can be generated, doing any heap or stack tagging before the
> > > PR_SET_TAGGED_ADDR_CTRL prctl() is issued can cause problems, notably because tagged
> > > addresses could end up being passed to syscalls. Conversely, if IRG and ADDG never
> > > set the top byte by default, then tagging operations should be no-ops until the
> > > prctl() is issued. This would be particularly useful given that it may not be
> > > straightforward for the C runtime to issue the prctl() before doing anything else.
> > >
> > > Additionally, since the default tag checking mode is PR_MTE_TCF_NONE, it would make
> > > perfect sense not to generate tags by default.
> >
> > This would indeed allow the early C runtime startup code to pass
> > tagged addresses to syscalls,
>
> I guess you meant that early C runtime code won't get tagged stack
> addresses, hence they can be passed to syscalls. Prior to the prctl(),
> the kernel doesn't accept tagged addresses anyway.

Right.

> > but I don't think it would entirely free
> > the code from the burden of worrying about stack tagging. Either way,
> > any stack frames that are active at the point when the prctl() is
> > issued would need to be compiled without stack tagging, because
> > otherwise those stack frames may use ADDG to rematerialize a stack
> > object address, which may produce a different address post-prctl.
>
> If you want to guarantee that ADDG always returns tag 0, I guess that's
> only possible with a default exclude mask of 0xffff (or if you are
> careful enough with the start tag and offset passed).
>
> > Setting the exclude mask to 0xffff would at least make it more likely
> > for this problem to be detected, though.
>
> I thought it would be detected if we didn't have a 0xffff default
> exclude mask. With only tag 0 generated, any such problem could be
> hidden.

I don't think that's the case, as long as you aren't using 0 as a
catch-all tag. Imagine that you have some hypothetical startup code
that looks like this:

void init() {
  bool called_prctl = false;
  prctl(PR_SET_TAGGED_ADDR_CTRL, ...); // effect is to change
GCR_EL1.Excl from 0xffff to 1
  called_prctl = true;
}

This may be compiled as something like (well, a real compiler wouldn't
compile it like this but rather use sp-relative stores or eliminate
the dead stores entirely, but imagine that the stores to called_prctl
are obfuscated somehow, e.g. in another translation unit):

sub x19, sp, #16
irg x19, x19 // compute a tag base for the function
addg x0, x19, #0, #1 // add tag offset for "called_prctl"
stzg x0, [x0]
bl prctl
addg x0, x19, #0, #1 // rematerialize "called_prctl" address
mov w1, #1
strb w1, [x0]
ret

The first addg will materialize a tag of 0 due to the default Excl
value, so the stzg will set the memory tag to 0. However, the second
addg will materialize a tag of 1 because of the new Excl value, which
will result in a tag fault in the strb instruction.

This problem is less likely to be detected if we transition Excl from
0 to 1. It will only be detected in the case where the irg instruction
produces a tag of 0xf, which would be incremented to 0 by the first
addg but to 1 by the second one.

> > If we change the default in this way, maybe it would be worth
> > considering flipping the meaning of the tag mask and have it be a mask
> > of tags to allow. That would be consistent with the existing behaviour
> > where userspace sets bits in tagged_addr_ctrl in order to enable
> > tagging features.
>
> The first question is whether the C runtime requires a default
> GCR_EL1.Excl mask of 0xffff (or 0xfffe) so that IRG, ADDG, SUBG always
> generate tag 0. If the runtime is fine with a default exclude mask of 0,
> I'm tempted to go back to an exclude mask for prctl().
>
> (to me it feels more natural to use an exclude mask as it matches the
> ARM ARM definition but maybe I stare too much at the hardware specs ;))

I think that would be fine with me. With the transition from 0 to 1
the above problem would still be detected, but only 1/16 of the time.
But if the problem exists in the early startup code which will be
executed many times during a typical system boot, it makes it likely
that the problem will be detected eventually.

Peter
