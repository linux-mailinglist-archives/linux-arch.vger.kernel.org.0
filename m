Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB1F1211C5
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 18:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfLPRaw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 12:30:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42779 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPRaw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 12:30:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id q6so8293024wro.9
        for <linux-arch@vger.kernel.org>; Mon, 16 Dec 2019 09:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fWYDGMp/nApDNbsrJ+5xWU9putwDijDotVARBJn+ns=;
        b=gdIMAIf97ukxAmjomWXZt5U5oVo5ZHPpBsn8yC+LUJsUpG/0g7jNbRu+fF+T5QXIRv
         dUc+6/GMVd4y8Dn2BUkBrZAVDct54i+OJAb18XlddDIlSOeTLs5ZX6V6nJD04poiKKjh
         MhFytbWzx2fnX2crjrCcKdUmIPgC/Kh4VMnTWPHWuXs92o0u5Zn8uFTP7URYbKd/yNYA
         H1pK3pAA/pcShk0GqJBgQ3yHpAsRyELjKg7Wq/ouI7OBxjm8qbhr8qcWOb3LU1mhCJXV
         rolTLcMf2FYfJZvSerMd2MPTvBNIu61GdGWwGrGBtp8FZQqzVVyRurinNqK9NnLPpzsh
         Drrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fWYDGMp/nApDNbsrJ+5xWU9putwDijDotVARBJn+ns=;
        b=lq5maBl/lrTTLgWxQXXpd8OzANM+UCc7AY11Fr1QSjq+cr4NuJDvVZ4A7xsq59KmAT
         1nbYQuJf8KBzFsO6eJ/Chl7A/9tUj0TxHy7Dwo2l4g7NifeNXWJnWUl/E9QiWLn9huhd
         1f9dWd/5TKuyL5YdGN7WjUAiXBiAIyUMeimR3fY99NjX9H9AYAwr7ws4TD13PobCyISR
         xJ1wfOdljdDvRbcmrnwOMI33xicZTLMoxV2gB9GuYJ4OLEMffQRZ3KxTWCCtinqXPK11
         S8NF/NgDqgQ21SV0k4F/xF7LImgHhab0I3iqv+As+Jsxd7hRmJ5+M2Dim5O572y5Ic3k
         gjyg==
X-Gm-Message-State: APjAAAWDV67UsTexJp+Gj5tJEawOD5WUlrijhJyrztxloCwxY9VrfVX4
        RukdmMr6iGGMPYmu5cYcnrPvmnFygHZ0zGuJ6Oz4qg==
X-Google-Smtp-Source: APXvYqyoF+KvnzIYNr2E7q8HeyNbCKjQw7uAH6xStgdJExVzXSR0xSCZPRzKzq+G6oWrvHrRDKICuZ+IOnGR+n/Xc8k=
X-Received: by 2002:a5d:4984:: with SMTP id r4mr30348162wrq.137.1576517448748;
 Mon, 16 Dec 2019 09:30:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211184027.20130-1-catalin.marinas@arm.com>
 <20191211184027.20130-21-catalin.marinas@arm.com> <ef61bbc6-76d6-531d-2156-b57efc070da4@arm.com>
In-Reply-To: <ef61bbc6-76d6-531d-2156-b57efc070da4@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 16 Dec 2019 09:30:36 -0800
Message-ID: <CAMn1gO6KGbeSkuEJB_j+WG8DAjbn81OdfA6DQQ+FFA5F6dcsVQ@mail.gmail.com>
Subject: Re: [PATCH 20/22] arm64: mte: Allow user control of the excluded tags
 via prctl()
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Branislav Rankov <Branislav.Rankov@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 6:20 AM Kevin Brodsky <kevin.brodsky@arm.com> wrote:
>
> +Branislav, Peter
>
> In this patch, the default exclusion mask remains 0 (i.e. all tags can be generated).
> After some more discussions, Branislav and I think that it would be better to start
> with the reverse, i.e. all tags but 0 excluded (mask = 0xfe or 0xff).
>
> This should simplify the MTE setup in the early C runtime quite a bit. Indeed, if all
> tags can be generated, doing any heap or stack tagging before the
> PR_SET_TAGGED_ADDR_CTRL prctl() is issued can cause problems, notably because tagged
> addresses could end up being passed to syscalls. Conversely, if IRG and ADDG never
> set the top byte by default, then tagging operations should be no-ops until the
> prctl() is issued. This would be particularly useful given that it may not be
> straightforward for the C runtime to issue the prctl() before doing anything else.
>
> Additionally, since the default tag checking mode is PR_MTE_TCF_NONE, it would make
> perfect sense not to generate tags by default.
>
> Any thoughts?

This would indeed allow the early C runtime startup code to pass
tagged addresses to syscalls, but I don't think it would entirely free
the code from the burden of worrying about stack tagging. Either way,
any stack frames that are active at the point when the prctl() is
issued would need to be compiled without stack tagging, because
otherwise those stack frames may use ADDG to rematerialize a stack
object address, which may produce a different address post-prctl.
Setting the exclude mask to 0xffff would at least make it more likely
for this problem to be detected, though.

If we change the default in this way, maybe it would be worth
considering flipping the meaning of the tag mask and have it be a mask
of tags to allow. That would be consistent with the existing behaviour
where userspace sets bits in tagged_addr_ctrl in order to enable
tagging features.

Peter

>
> Thanks,
> Kevin
>
> On 11/12/2019 18:40, Catalin Marinas wrote:
> > The IRG, ADDG and SUBG instructions insert a random tag in the resulting
> > address. Certain tags can be excluded via the GCR_EL1.Exclude bitmap
> > when, for example, the user wants a certain colour for freed buffers.
> > Since the GCR_EL1 register is not accessible at EL0, extend the
> > prctl(PR_SET_TAGGED_ADDR_CTRL) interface to include a 16-bit field in
> > the first argument for controlling the excluded tags. This setting is
> > pre-thread.
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > ---
> >   arch/arm64/include/asm/processor.h |  1 +
> >   arch/arm64/include/asm/sysreg.h    |  7 +++++++
> >   arch/arm64/kernel/process.c        | 27 +++++++++++++++++++++++----
> >   include/uapi/linux/prctl.h         |  3 +++
> >   4 files changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> > index 91aa270afc7d..5b6988035334 100644
> > --- a/arch/arm64/include/asm/processor.h
> > +++ b/arch/arm64/include/asm/processor.h
> > @@ -150,6 +150,7 @@ struct thread_struct {
> >   #endif
> >   #ifdef CONFIG_ARM64_MTE
> >       u64                     sctlr_tcf0;
> > +     u64                     gcr_excl;
> >   #endif
> >   };
> >
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 9e5753272f4b..b6bb6d31f1cd 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -901,6 +901,13 @@
> >               write_sysreg(__scs_new, sysreg);                        \
> >   } while (0)
> >
> > +#define sysreg_clear_set_s(sysreg, clear, set) do {                  \
> > +     u64 __scs_val = read_sysreg_s(sysreg);                          \
> > +     u64 __scs_new = (__scs_val & ~(u64)(clear)) | (set);            \
> > +     if (__scs_new != __scs_val)                                     \
> > +             write_sysreg_s(__scs_new, sysreg);                      \
> > +} while (0)
> > +
> >   #endif
> >
> >   #endif      /* __ASM_SYSREG_H */
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 47ce98f47253..5ec6889795fc 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -502,6 +502,15 @@ static void update_sctlr_el1_tcf0(u64 tcf0)
> >       sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
> >   }
> >
> > +static void update_gcr_el1_excl(u64 excl)
> > +{
> > +     /*
> > +      * No need for ISB since this only affects EL0 currently, implicit
> > +      * with ERET.
> > +      */
> > +     sysreg_clear_set_s(SYS_GCR_EL1, SYS_GCR_EL1_EXCL_MASK, excl);
> > +}
> > +
> >   /* Handle MTE thread switch */
> >   static void mte_thread_switch(struct task_struct *next)
> >   {
> > @@ -511,6 +520,7 @@ static void mte_thread_switch(struct task_struct *next)
> >       /* avoid expensive SCTLR_EL1 accesses if no change */
> >       if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> >               update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> > +     update_gcr_el1_excl(next->thread.gcr_excl);
> >   }
> >   #else
> >   static void mte_thread_switch(struct task_struct *next)
> > @@ -641,22 +651,31 @@ static long set_mte_ctrl(unsigned long arg)
> >       update_sctlr_el1_tcf0(tcf0);
> >       preempt_enable();
> >
> > +     current->thread.gcr_excl = (arg & PR_MTE_EXCL_MASK) >> PR_MTE_EXCL_SHIFT;
> > +     update_gcr_el1_excl(current->thread.gcr_excl);
> > +
> >       return 0;
> >   }
> >
> >   static long get_mte_ctrl(void)
> >   {
> > +     unsigned long ret;
> > +
> >       if (!system_supports_mte())
> >               return 0;
> >
> > +     ret = current->thread.gcr_excl << PR_MTE_EXCL_SHIFT;
> > +
> >       switch (current->thread.sctlr_tcf0) {
> >       case SCTLR_EL1_TCF0_SYNC:
> > -             return PR_MTE_TCF_SYNC;
> > +             ret |= PR_MTE_TCF_SYNC;
> > +             break;
> >       case SCTLR_EL1_TCF0_ASYNC:
> > -             return PR_MTE_TCF_ASYNC;
> > +             ret |= PR_MTE_TCF_ASYNC;
> > +             break;
> >       }
> >
> > -     return 0;
> > +     return ret;
> >   }
> >   #else
> >   static long set_mte_ctrl(unsigned long arg)
> > @@ -684,7 +703,7 @@ long set_tagged_addr_ctrl(unsigned long arg)
> >               return -EINVAL;
> >
> >       if (system_supports_mte())
> > -             valid_mask |= PR_MTE_TCF_MASK;
> > +             valid_mask |= PR_MTE_TCF_MASK | PR_MTE_EXCL_MASK;
> >
> >       if (arg & ~valid_mask)
> >               return -EINVAL;
> > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > index 5e9323e66a38..749de5ab4f9f 100644
> > --- a/include/uapi/linux/prctl.h
> > +++ b/include/uapi/linux/prctl.h
> > @@ -239,5 +239,8 @@ struct prctl_mm_map {
> >   # define PR_MTE_TCF_SYNC            (1UL << PR_MTE_TCF_SHIFT)
> >   # define PR_MTE_TCF_ASYNC           (2UL << PR_MTE_TCF_SHIFT)
> >   # define PR_MTE_TCF_MASK            (3UL << PR_MTE_TCF_SHIFT)
> > +/* MTE tag exclusion mask */
> > +# define PR_MTE_EXCL_SHIFT           3
> > +# define PR_MTE_EXCL_MASK            (0xffffUL << PR_MTE_EXCL_SHIFT)
> >
> >   #endif /* _LINUX_PRCTL_H */
>
