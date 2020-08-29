Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABB325667B
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgH2Jbp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 05:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgH2Jbo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 05:31:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A4320791;
        Sat, 29 Aug 2020 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598693503;
        bh=mRFSDrdb3CJe2f+LAM7xJ8zLaomR+oMA2NdfHPPa/t0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0yxm7IYZjnpWoncFmotRWzVmXnF0Xg4sF5JIoCi82xNx/OASmYj1Az+HI5i87X4sl
         IxxhQXmB2/34D3+Ma3jTxSNDJf5x8IgXSf0ERSyv1a/e9t+O2sX4gHr2Ozx2/nrK5f
         vYnTsiFcyBN3248K09lO/ot/VYcAVmDXe37yQ6ww=
Date:   Sat, 29 Aug 2020 18:31:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eddy Wu <Eddy_Wu@trendmicro.com>, x86@kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 06/16] csky: kprobes: Use generic kretprobe
 trampoline handler
Message-Id: <20200829183139.9bf2877cf4f1a436b360c722@kernel.org>
In-Reply-To: <CAJF2gTR5z87fb4ieOcrnMNT6GxSAhj99cf7draGVaHnk7G-pCQ@mail.gmail.com>
References: <159854631442.736475.5062989489155389472.stgit@devnote2>
        <159854636764.736475.9112286781925119117.stgit@devnote2>
        <CAJF2gTR5z87fb4ieOcrnMNT6GxSAhj99cf7draGVaHnk7G-pCQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 20:34:22 +0800
Guo Ren <guoren@kernel.org> wrote:

> Looks more clear.
> 
> Acked-by: Guo Ren <guoren@kernel.org>

Thanks Guo! I'll add it to the next version.

> 
> On Fri, Aug 28, 2020 at 12:39 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/csky/kernel/probes/kprobes.c |   78 +------------------------------------
> >  1 file changed, 3 insertions(+), 75 deletions(-)
> >
> > diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> > index f0f733b7ac5a..a891fb422e76 100644
> > --- a/arch/csky/kernel/probes/kprobes.c
> > +++ b/arch/csky/kernel/probes/kprobes.c
> > @@ -404,87 +404,15 @@ int __init arch_populate_kprobe_blacklist(void)
> >
> >  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> >  {
> > -       struct kretprobe_instance *ri = NULL;
> > -       struct hlist_head *head, empty_rp;
> > -       struct hlist_node *tmp;
> > -       unsigned long flags, orig_ret_address = 0;
> > -       unsigned long trampoline_address =
> > -               (unsigned long)&kretprobe_trampoline;
> > -       kprobe_opcode_t *correct_ret_addr = NULL;
> > -
> > -       INIT_HLIST_HEAD(&empty_rp);
> > -       kretprobe_hash_lock(current, &head, &flags);
> > -
> > -       /*
> > -        * It is possible to have multiple instances associated with a given
> > -        * task either because multiple functions in the call path have
> > -        * return probes installed on them, and/or more than one
> > -        * return probe was registered for a target function.
> > -        *
> > -        * We can handle this because:
> > -        *     - instances are always pushed into the head of the list
> > -        *     - when multiple return probes are registered for the same
> > -        *       function, the (chronologically) first instance's ret_addr
> > -        *       will be the real return address, and all the rest will
> > -        *       point to kretprobe_trampoline.
> > -        */
> > -       hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> > -               if (ri->task != current)
> > -                       /* another task is sharing our hash bucket */
> > -                       continue;
> > -
> > -               orig_ret_address = (unsigned long)ri->ret_addr;
> > -
> > -               if (orig_ret_address != trampoline_address)
> > -                       /*
> > -                        * This is the real return address. Any other
> > -                        * instances associated with this task are for
> > -                        * other calls deeper on the call stack
> > -                        */
> > -                       break;
> > -       }
> > -
> > -       kretprobe_assert(ri, orig_ret_address, trampoline_address);
> > -
> > -       correct_ret_addr = ri->ret_addr;
> > -       hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> > -               if (ri->task != current)
> > -                       /* another task is sharing our hash bucket */
> > -                       continue;
> > -
> > -               orig_ret_address = (unsigned long)ri->ret_addr;
> > -               if (ri->rp && ri->rp->handler) {
> > -                       __this_cpu_write(current_kprobe, &ri->rp->kp);
> > -                       get_kprobe_ctlblk()->kprobe_status = KPROBE_HIT_ACTIVE;
> > -                       ri->ret_addr = correct_ret_addr;
> > -                       ri->rp->handler(ri, regs);
> > -                       __this_cpu_write(current_kprobe, NULL);
> > -               }
> > -
> > -               recycle_rp_inst(ri, &empty_rp);
> > -
> > -               if (orig_ret_address != trampoline_address)
> > -                       /*
> > -                        * This is the real return address. Any other
> > -                        * instances associated with this task are for
> > -                        * other calls deeper on the call stack
> > -                        */
> > -                       break;
> > -       }
> > -
> > -       kretprobe_hash_unlock(current, &flags);
> > -
> > -       hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> > -               hlist_del(&ri->hlist);
> > -               kfree(ri);
> > -       }
> > -       return (void *)orig_ret_address;
> > +       return (void *)kretprobe_trampoline_handler(regs,
> > +                       (unsigned long)&kretprobe_trampoline, NULL);
> >  }
> >
> >  void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> >                                       struct pt_regs *regs)
> >  {
> >         ri->ret_addr = (kprobe_opcode_t *)regs->lr;
> > +       ri->fp = NULL;
> >         regs->lr = (unsigned long) &kretprobe_trampoline;
> >  }
> >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/


-- 
Masami Hiramatsu <mhiramat@kernel.org>
