Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6E46D7CE6
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 14:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbjDEMpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 08:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjDEMpv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 08:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD9E1BC1
        for <linux-arch@vger.kernel.org>; Wed,  5 Apr 2023 05:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680698711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJlvbrDO3MZW25EtVUfp0HoO311UYJgGKtfX/KEqF/k=;
        b=GER116tgb+iYLrIT7d4YCy70CvkCC3ZTYBKLxajJxbZgXuyKM2JcZML6stGxqYHRr9T3HP
        v8nxW5K3mkeZs7BYaINTyAH6JCw+5alZIbchu93T79G7V2a+W0U8fV0muR1w1xJg8nfw83
        Gk8E7tl2N3FaU5OmliSluZx/6RQwOf8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-jbPuKRBYNvy-gSOGDYNxeg-1; Wed, 05 Apr 2023 08:45:10 -0400
X-MC-Unique: jbPuKRBYNvy-gSOGDYNxeg-1
Received: by mail-qk1-f200.google.com with SMTP id t23-20020a374617000000b0074a4dba4b5aso3518182qka.16
        for <linux-arch@vger.kernel.org>; Wed, 05 Apr 2023 05:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680698710;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJlvbrDO3MZW25EtVUfp0HoO311UYJgGKtfX/KEqF/k=;
        b=5uBFCDGCXU7tOS9Oelacxdivv2rrg66QLMlHaRAdl49RZeEYCITleZi0Ql2lVi+vzV
         2I0RVTfQQZ4MLcjE4dT+KP4bK0HqtlOf0HTtEiHDSZ9FpFN99OkCiJbT/vys5XuJc4Hl
         gTgp8E1QzjwTOKWLwRscbJ46qioU62KS+UJYu7xkfOReTji1Xa6e/qqabV5MLTBaL+Hw
         Nd6mUw9R0/gxtYCwhFUc+HisohDZZwer1gcqy5PkBzy5iUF8uosOKFh4PrRnjOTlC+9V
         hvcAub42jBIKfGlL4tZ3+GLGd8huw6VygrzijbEWjmPqqrI7qwIX8RO7v5/dfD1ycFHN
         /M+A==
X-Gm-Message-State: AAQBX9ebaz8dxiN2K2X9hEzGh+TYO7AO2gepwhWI0jDIAkHdHYJv27Fm
        Bg2itwizLaIt43/6JArYKt39u+y4FZ0YuFXNbYTsRAMbxnabxm7mZxIaeJn9nsbv0/S/UT1Hapj
        A0BOS8XJ/+WHMaN1mBH5a1Q==
X-Received: by 2002:a05:622a:1716:b0:3e4:eb03:687d with SMTP id h22-20020a05622a171600b003e4eb03687dmr4303557qtk.44.1680698709737;
        Wed, 05 Apr 2023 05:45:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350YM3193lIgKl2aWj9mqpkVtYuh0l9dX5dcxwgxaNjVBgfvhxy0L8/57jtC9NbW/iCG3sMx10Q==
X-Received: by 2002:a05:622a:1716:b0:3e4:eb03:687d with SMTP id h22-20020a05622a171600b003e4eb03687dmr4303502qtk.44.1680698709447;
        Wed, 05 Apr 2023 05:45:09 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id t186-20020a37aac3000000b00746b7372d62sm4415939qke.27.2023.04.05.05.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 05:45:08 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yair Podemsky <ypodemsk@redhat.com>, linux@armlinux.org.uk,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        ardb@kernel.org, juerg.haefliger@canonical.com,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        tony@atomide.com, linus.walleij@linaro.org,
        sebastian.reichel@collabora.com, nick.hawkins@hpe.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, dhildenb@redhat.com,
        alougovs@redhat.com
Subject: Re: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI
 only to CPUs in kernel mode
In-Reply-To: <ZC1j8ivE/kK7+Gd5@lothringen>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
 <20230404134224.137038-4-ypodemsk@redhat.com>
 <ZC1Q7uX4rNLg3vEg@lothringen> <ZC1XD/sEJY+zRujE@lothringen>
 <20230405114148.GA351571@hirez.programming.kicks-ass.net>
 <ZC1j8ivE/kK7+Gd5@lothringen>
Date:   Wed, 05 Apr 2023 13:45:02 +0100
Message-ID: <xhsmhpm8ia46p.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/04/23 14:05, Frederic Weisbecker wrote:
>  static void smp_call_function_many_cond(const struct cpumask *mask,
>                                       smp_call_func_t func, void *info,
> @@ -946,10 +948,13 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
>  #endif
>                       cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
>                       if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
> -				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> -				nr_cpus++;
> -				last_cpu = cpu;
> -
> +				if (!(scf_flags & SCF_NO_USER) ||
> +				    !IS_ENABLED(CONFIG_GENERIC_ENTRY) ||
> +				     ct_state_cpu(cpu) != CONTEXT_USER) {
> +					__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
> +					nr_cpus++;
> +					last_cpu = cpu;
> +				}

I've been hacking on something like this (CSD deferral for NOHZ-full),
and unfortunately this uses the CPU-local cfd_data storage thing, which
means any further smp_call_function() from the same CPU to the same
destination will spin on csd_lock_wait(), waiting for the target CPU to
come out of userspace and flush the queue - and we've just spent extra
effort into *not* disturbing it, so that'll take a while :(

I don't have much that is in a shareable state yet (though I'm supposed to
talk some more about it at OSPM in <2 weeks, so I'll have to get there),
but ATM I'm playing with
o a bitmask (like in [1]) for coalescable stuff such as do_sync_core() for
  x86 instruction patching
o a CSD-like queue for things that need to pass data around, using
  statically-allocated storage (so with a limit on how much it can be used) - the
  alternative being allocating a struct on sending, since you don't have a
  bound on how much crap you can queue on an undisturbed NOHZ-full CPU...

[1]: https://lore.kernel.org/all/20210929152429.067060646@infradead.org/

