Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6715C4E3925
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 07:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237042AbiCVGrj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 02:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiCVGri (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 02:47:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A4E5EDC9;
        Mon, 21 Mar 2022 23:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D9116148A;
        Tue, 22 Mar 2022 06:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B024C340FD;
        Tue, 22 Mar 2022 06:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647931570;
        bh=hhAPCoaMSvMdBpBGQUL4AfiQiPsS12xmMjwJk64lVwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mTM0o6i/TnOE5bjF9tnScVcRYE5SEfzZvk98MEJMIbvS6xAyHeaxae/iYLVA7qVoL
         y9gnflHGbsnEIrgNQaidlrWeCsQvu4UH8qF5tGEnPvIhDm0bUkbSMOUGULiJvi8QFB
         0cJcQUC0WVmBHtd3ZWO4AdhceTlntVMAUcyS4b2itap/JZGhPywl0TQ8pNhJQVbpop
         38kPysWdn0XE4g2LDDZPKjtutxQAqHcIdCQVur839yRxirldUtOz9czkaeC+fKMKRh
         qm/7CrO6b6gmY2k/8pWxprJHj2m/wu8e6W/YvQqPER8dgmFyZ+wKMgfOSJwX5u9DqA
         rTkxWbl/8oDEA==
Received: by mail-vs1-f53.google.com with SMTP id v206so2003456vsv.2;
        Mon, 21 Mar 2022 23:46:10 -0700 (PDT)
X-Gm-Message-State: AOAM532d3Cz57VEL0IRbano6HAh+o7aHNQAmZtoBKYZ6020BgiJIWvbG
        3jmQ5OPHyPKQ36kXvjTZQkEQgvlGR0ya6n7I7e4=
X-Google-Smtp-Source: ABdhPJy5NXfAIso2F2+24UJmT6jDU2XX7NsQdluZergkSkOFjyDuh2G4iyJgCgicmkVQYM+5Is7fWIuWhEamegVW4JQ=
X-Received: by 2002:a67:bc05:0:b0:324:eed0:ec29 with SMTP id
 t5-20020a67bc05000000b00324eed0ec29mr5402967vsn.2.1647931569197; Mon, 21 Mar
 2022 23:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220316232600.20419-1-palmer@rivosinc.com> <20220316232600.20419-4-palmer@rivosinc.com>
 <YjjuOZMzQlnqfLDJ@antec> <CAJF2gTSFh0NKLys7kr=UdQWHDyYgg3XmgTJtVaL37Re7QdZ8uw@mail.gmail.com>
 <YjlMIGKgYaLLpp5T@antec>
In-Reply-To: <YjlMIGKgYaLLpp5T@antec>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 22 Mar 2022 14:45:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRGPhhVErmgpvyGuKcwKZERdvmphDTa1n2i5jv--V+tHA@mail.gmail.com>
Message-ID: <CAJF2gTRGPhhVErmgpvyGuKcwKZERdvmphDTa1n2i5jv--V+tHA@mail.gmail.com>
Subject: Re: [PATCH 3/5] openrisc: Move to ticket-spinlock
To:     Stafford Horne <shorne@gmail.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>, jszhang@kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
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

On Tue, Mar 22, 2022 at 12:10 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On Tue, Mar 22, 2022 at 11:29:13AM +0800, Guo Ren wrote:
> > On Tue, Mar 22, 2022 at 7:23 AM Stafford Horne <shorne@gmail.com> wrote:
> > >
> > > On Wed, Mar 16, 2022 at 04:25:58PM -0700, Palmer Dabbelt wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > >
> > > > We have no indications that openrisc meets the qspinlock requirements,
> > > > so move to ticket-spinlock as that is more likey to be correct.
> > > >
> > > > Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> > > >
> > > > ---
> > > >
> > > > I have specifically not included Peter's SOB on this, as he sent his
> > > > original patch
> > > > <https://lore.kernel.org/lkml/YHbBBuVFNnI4kjj3@hirez.programming.kicks-ass.net/>
> > > > without one.
> > > > ---
> > > >  arch/openrisc/Kconfig                      | 1 -
> > > >  arch/openrisc/include/asm/Kbuild           | 5 ++---
> > > >  arch/openrisc/include/asm/spinlock.h       | 3 +--
> > > >  arch/openrisc/include/asm/spinlock_types.h | 2 +-
> > > >  4 files changed, 4 insertions(+), 7 deletions(-)
> > >
> > > Hello,
> > >
> > > This series breaks SMP support on OpenRISC.  I haven't traced it down yet, it
> > > seems trivial but I have a few places to check.
> > >
> > > I replied to this on a kbuild warning thread, but also going to reply here with
> > > more information.
> > >
> > >  https://lore.kernel.org/lkml/YjeY7CfaFKjr8IUc@antec/#R
> > >
> > > So far this is what I see:
> > >
> > >   * ticket_lock is stuck trying to lock console_sem
> > >   * it is stuck on atomic_cond_read_acquire
> > >     reading lock value: returns 0    (*lock is 0x10000)
> > >     ticket value: is 1
> > >   * possible issues:
> > >     - OpenRISC is big endian, that seems to impact ticket_unlock, it looks
> > All csky & riscv are little-endian, it seems the series has a bug with
> > big-endian. Is that all right for qemu? (If qemu was all right, but
> > real hardware failed.)
>
> Hi Guo Ren,
>
> OpenRISC real hardware and QEMU are both big-endian.  It fails on both.
>
> I replied on patch 1/5 with a suggested patch which fixes the issue for me.
> Please have a look.
Great, I saw that:

static __always_inline void ticket_unlock(arch_spinlock_t *lock)
{
     u16 *ptr = (u16 *)lock + __is_defined(__BIG_ENDIAN);
//__is_defined(__BIG_ENDIAN) would be zero for openrisc.

Using CONFIG_CPU_BIG_ENDIAN is correct, Arnd has also asked me using
CONFIG_CPU_BIG_ENDIAN in compat.h:

diff --git a/include/asm-generic/compat.h b/include/asm-generic/compat.h
index 11653d6846cc..d06308a2a7a8 100644
--- a/include/asm-generic/compat.h
+++ b/include/asm-generic/compat.h
@@ -14,6 +14,13 @@
 #define COMPAT_OFF_T_MAX       0x7fffffff
 #endif

+#if !defined(compat_arg_u64) && !defined(CONFIG_CPU_BIG_ENDIAN)
+#define compat_arg_u64(name)           u32  name##_lo, u32  name##_hi
+#define compat_arg_u64_dual(name)      u32, name##_lo, u32, name##_hi
+#define compat_arg_u64_glue(name)      (((u64)name##_lo & 0xffffffffUL) | \
+                                        ((u64)name##_hi << 32))
+#endif
+
 /* These types are common across all compat ABIs */
 typedef u32 compat_size_t;
 typedef s32 compat_ssize_t;



> BTW. now I can look into the sparse warnings.
>
> -Stafford
>
--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
