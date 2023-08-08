Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B99774D4D
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 23:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjHHVsD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Aug 2023 17:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjHHVsC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Aug 2023 17:48:02 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B7830DD;
        Tue,  8 Aug 2023 10:18:45 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-584243f84eeso67230587b3.0;
        Tue, 08 Aug 2023 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691515121; x=1692119921;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=694ts041qMq4P0o30b2m71kcJCYvyz59KOSQWxuaGro=;
        b=AEvteDYhCGBKfBiYrW1QNP/QSXTIrNuNomnfLMNuss3h7d/AKsaaWhq0cT2ZMmOkPf
         Sne9PgyD9QNwb3SQ9wPsHoGzypxmo6Hb+RNIimf7/yMzdBb0gNplY/XjTzMYMm8wPekn
         UppRRROJll68BbzeZTEb3eyIFqzpElGORhcAQ1MiCboCVKVoHbiSbsi3w1exFmoxhD/l
         L9OxjRp9cUfKhb7jtEAyPSPH+JN9IVC5M3TnjvRygh8RdPPjy7j/RRuN6LtktFFQ2nGC
         g7/5QEmMt6Z8DvBbEJe0E52UvRRxC/VYiXtu9uoObTLnBrI8gKpP+XfToMtswXuJGuHE
         pQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691515121; x=1692119921;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=694ts041qMq4P0o30b2m71kcJCYvyz59KOSQWxuaGro=;
        b=F9EP6MmO0bX3bXiAEwjwhTwpbj0TGYWhTh13aWi99VEJqOWiLxOuipfrxjQFjJjsKK
         XEYHotDa595BYlZoI6O2EuogG22CMuzDugGFirK1S/RYb7GU1EnPmOw0PbuIEfzIBQsk
         0HWAAtDJNU5sFvyRmKnvaLb9WdPrj5Ox06gz8LplNf+rhFpqnOogY2xWKP5BYq6zMZEy
         Jgp1bnDgc3ydny8AkAlhPogLhwbGK5ltSVYbIKfLqqdMDnagIMn/i2B60+IMnfeNf2fa
         oVIBlR/AEG58KaVbDnJLxHix+JBlnJPv0xNYqunvfMXYzSSEphnUP9OKLiMTM62/mSdJ
         NbFw==
X-Gm-Message-State: AOJu0Yyvlqjci+P4mwZ1fzFqcxDFn1D9DlSM9UrBiW6TKCjrosDe9cKR
        5rLQjsTFZ79Cy2rTyUInnM+Bhl4vXaHQW3L+tB1Sv6DtRik=
X-Google-Smtp-Source: AGHT+IH7VG/tSlNfYrSJiqGN7tVMMFiwEj6CcG7Ue4DbCdRSXbidxa0qqgv0gNNet0VW0ZVsx4gbteA6n9E14PBjz3g=
X-Received: by 2002:a4a:650d:0:b0:56c:e71c:2993 with SMTP id
 y13-20020a4a650d000000b0056ce71c2993mr11518458ooc.8.1691481746597; Tue, 08
 Aug 2023 01:02:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:696:0:b0:4f0:1250:dd51 with HTTP; Tue, 8 Aug 2023
 01:02:26 -0700 (PDT)
In-Reply-To: <ZNG2tHFOABSXGCVi@gmail.com>
References: <20230731023308.3748432-1-guoren@kernel.org> <20230807183655.kbnjtvbi4jfrcrce@f>
 <ZNG2tHFOABSXGCVi@gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 8 Aug 2023 10:02:26 +0200
Message-ID: <CAGudoHEDFX7Wk-PA5=chWr0z4PnRO_gKoU2g-3RJO0uOzqogYQ@mail.gmail.com>
Subject: Re: [PATCH V2] asm-generic: ticket-lock: Optimize arch_spin_value_unlocked
To:     Guo Ren <guoren@kernel.org>
Cc:     will@kernel.org, David.Laight@aculab.com, peterz@infradead.org,
        mingo@redhat.com, longman@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/8/23, Guo Ren <guoren@kernel.org> wrote:
> On Mon, Aug 07, 2023 at 08:36:55PM +0200, Mateusz Guzik wrote:
>> On Sun, Jul 30, 2023 at 10:33:08PM -0400, guoren@kernel.org wrote:
>> > From: Guo Ren <guoren@linux.alibaba.com>
>> >
>> > The arch_spin_value_unlocked would cause an unnecessary memory
>> > access to the contended value. Although it won't cause a significant
>> > performance gap in most architectures, the arch_spin_value_unlocked
>> > argument contains enough information. Thus, remove unnecessary
>> > atomic_read in arch_spin_value_unlocked().
>> >
>> > The caller of arch_spin_value_unlocked() could benefit from this
>> > change. Currently, the only caller is lockref.
>> >
>>
>> Have you verified you are getting an extra memory access from this in
>> lockref? What architecture is it?
> For riscv, this patch could optimize the lock_ref on the same compiling
> condition:
>  - After lifting data dependencies, the compiler optimizes the prologue
>    behavior, thus the callee-register-saved path becomes optional. This
>    is a significant improvement on the lock_ref() self.
>  - Compare the "98: & 9c:" lines before the patch and the "88:" line
>    after the patch. We saved two memory accesses not only one load.
>

Now that you mention it, I see riscv in cc. ;)

Your commit message states "arch_spin_value_unlocked would cause an
unnecessary memory access to the contended value" and that lockref
uses it. Perhaps incorrectly I took it to claim lockref is suffering
extra loads from the area it modifies with cmpxchg -- as I verified,
this is not happening as the argument to arch_spin_value_unlocked is a
copy of the target lockref struct. With this not being a problem,
potential scalability impact goes down a lot. And so happens with the
code from qspinlock on x86-64 there are no extra memory accesses to
anything anyway.

I don't speak riscv asm so can't comment on the result. I'll note
again that extra work for single-threaded use is definitely worth
shaving and may or may not affect throughput in face of other CPUs
messing with lockref.

You can easily test lockref with will-it-scale, I would suggest the
access() system call which afaics has least amount of unrelated
overhead. You can find the bench here:
https://github.com/antonblanchard/will-it-scale/pull/36/files

> ========================================================================
> Before the patch:
> void lockref_get(struct lockref *lockref)
> {
>   78:   fd010113                add     sp,sp,-48
>   7c:   02813023                sd      s0,32(sp)
>   80:   02113423                sd      ra,40(sp)
>   84:   03010413                add     s0,sp,48
>
> 0000000000000088 <.LBB296>:
>         CMPXCHG_LOOP(
>   88:   00053783                ld      a5,0(a0)
>
> 000000000000008c <.LBB265>:
> }
>
> static __always_inline int ticket_spin_is_locked(arch_spinlock_t *lock)
> {
>         u32 val = atomic_read(&lock->val);
>         return ((val >> 16) != (val & 0xffff));
>   8c:   00010637                lui     a2,0x10
>
> 0000000000000090 <.LBE265>:
>   90:   06400593                li      a1,100
>
> 0000000000000094 <.LBB274>:
>   94:   fff60613                add     a2,a2,-1 # ffff <.LLST8+0xf49a>
>
> 0000000000000098 <.L8>:
>   98:   fef42423                sw      a5,-24(s0)
>
> 000000000000009c <.LBB269>:
>   9c:   fe842703                lw      a4,-24(s0)
>
> 00000000000000a0 <.LBE269>:
>   a0:   0107569b                srlw    a3,a4,0x10
>   a4:   00c77733                and     a4,a4,a2
>   a8:   04e69063                bne     a3,a4,e8 <.L12>
>
> 00000000000000ac <.LBB282>:
>   ac:   4207d693                sra     a3,a5,0x20
>   b0:   02079713                sll     a4,a5,0x20
>   b4:   0016869b                addw    a3,a3,1
>   b8:   02069693                sll     a3,a3,0x20
>   bc:   02075713                srl     a4,a4,0x20
>   c0:   00d76733                or      a4,a4,a3
>
> 00000000000000c4 <.L0^B1>:
>   c4:   100536af                lr.d    a3,(a0)
>   c8:   00f69863                bne     a3,a5,d8 <.L1^B1>
>   cc:   1ae5382f                sc.d.rl a6,a4,(a0)
>   d0:   fe081ae3                bnez    a6,c4 <.L0^B1>
>   d4:   0330000f                fence   rw,rw
>
> 00000000000000d8 <.L1^B1>:
>   d8:   02d78a63                beq     a5,a3,10c <.L7>
>
> 00000000000000dc <.LBE292>:
>   dc:   fff5859b                addw    a1,a1,-1
>
> 00000000000000e0 <.LBB293>:
>   e0:   00068793                mv      a5,a3
>
> 00000000000000e4 <.LBE293>:
>   e4:   fa059ae3                bnez    a1,98 <.L8>
>
> 00000000000000e8 <.L12>:
>
> ========================================================================
> After the patch:
> void lockref_get(struct lockref *lockref)
> {
>         CMPXCHG_LOOP(
>   78:   00053783                ld      a5,0(a0)
>
> 000000000000007c <.LBB212>:
>
> static __always_inline int ticket_spin_value_unlocked(arch_spinlock_t
> lock)
> {
>         u32 val = lock.val.counter;
>
>         return ((val >> 16) == (val & 0xffff));
>   7c:   00010637                lui     a2,0x10
>
> 0000000000000080 <.LBE212>:
>   80:   06400593                li      a1,100
>
> 0000000000000084 <.LBB216>:
>   84:   fff60613                add     a2,a2,-1 # ffff <.LLST8+0xf4aa>
>
> 0000000000000088 <.L8>:
>   88:   0007871b                sext.w  a4,a5
>
> 000000000000008c <.LBB217>:
>   8c:   0107d69b                srlw    a3,a5,0x10
>   90:   00c77733                and     a4,a4,a2
>   94:   04e69063                bne     a3,a4,d4 <.L12>
>
> 0000000000000098 <.LBB218>:
>   98:   4207d693                sra     a3,a5,0x20
>   9c:   02079713                sll     a4,a5,0x20
>   a0:   0016869b                addw    a3,a3,1
>   a4:   02069693                sll     a3,a3,0x20
>   a8:   02075713                srl     a4,a4,0x20
>   ac:   00d76733                or      a4,a4,a3
>
> 00000000000000b0 <.L0^B1>:
>   b0:   100536af                lr.d    a3,(a0)
>   b4:   00f69863                bne     a3,a5,c4 <.L1^B1>
>   b8:   1ae5382f                sc.d.rl a6,a4,(a0)
>   bc:   fe081ae3                bnez    a6,b0 <.L0^B1>
>   c0:   0330000f                fence   rw,rw
>
> 00000000000000c4 <.L1^B1>:
>   c4:   04d78a63                beq     a5,a3,118 <.L18>
>
> 00000000000000c8 <.LBE228>:
>   c8:   fff5859b                addw    a1,a1,-1
>
> 00000000000000cc <.LBB229>:
>   cc:   00068793                mv      a5,a3
>
> 00000000000000d0 <.LBE229>:
>   d0:   fa059ce3                bnez    a1,88 <.L8>
>
> 00000000000000d4 <.L12>:
> {
>   d4:   fe010113                add     sp,sp,-32
>   d8:   00113c23                sd      ra,24(sp)
>   dc:   00813823                sd      s0,16(sp)
>   e0:   02010413                add     s0,sp,32
> ========================================================================
>
>>
>> I have no opinion about the patch itself, I will note though that the
>> argument to the routine is *not* the actual memory-shared lockref,
>> instead it's something from the local copy obtained with READ_ONCE
>> from the real thing. So I would be surprised if the stock routine was
>> generating accesses to that sucker.
>>
>> Nonetheless, if the patched routine adds nasty asm, that would be nice
>> to sort out.
>>
>> FWIW on x86-64 qspinlock is used (i.e. not the stuff you are patching)
>> and I verified there are only 2 memory accesses -- the initial READ_ONCE
>> and later cmpxchg. I don't know which archs *don't* use qspinlock.
>>
>> It also turns out generated asm is quite atrocious and cleaning it up
>> may yield a small win under more traffic. Maybe I'll see about it later
>> this week.
>>
>> For example, disassembling lockref_put_return:
>> <+0>:     mov    (%rdi),%rax            <-- initial load, expected
>> <+3>:     mov    $0x64,%r8d
>> <+9>:     mov    %rax,%rdx
>> <+12>:    test   %eax,%eax              <-- retries loop back here
>> 					<-- this is also the unlocked
>> 					    check
>> <+14>:    jne    0xffffffff8157aba3 <lockref_put_return+67>
>> <+16>:    mov    %rdx,%rsi
>> <+19>:    mov    %edx,%edx
>> <+21>:    sar    $0x20,%rsi
>> <+25>:    lea    -0x1(%rsi),%ecx        <-- new.count--;
>> <+28>:    shl    $0x20,%rcx
>> <+32>:    or     %rcx,%rdx
>> <+35>:    test   %esi,%esi
>> <+37>:    jle    0xffffffff8157aba3 <lockref_put_return+67>
>> <+39>:    lock cmpxchg %rdx,(%rdi)      <-- the attempt to change
>> <+44>:    jne    0xffffffff8157ab9a <lockref_put_return+58>
>> <+46>:    shr    $0x20,%rdx
>> <+50>:    mov    %rdx,%rax
>> <+53>:    jmp    0xffffffff81af8540 <__x86_return_thunk>
>> <+58>:    mov    %rax,%rdx
>> <+61>:    sub    $0x1,%r8d              <-- retry count check
>> <+65>:    jne    0xffffffff8157ab6c <lockref_put_return+12> <-- go back
>> <+67>:    mov    $0xffffffff,%eax
>> <+72>:    jmp    0xffffffff81af8540 <__x86_return_thunk>
>>
>


-- 
Mateusz Guzik <mjguzik gmail.com>
